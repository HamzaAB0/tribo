#!/usr/bin/env pwsh

[CmdletBinding()]
param(
    [ValidateSet('premake-core', 'all')]
    [string]$Project = 'all',
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RootDir = Resolve-Path "$PSScriptRoot/.."
$DepsDir = Join-Path -Path $RootDir "build" "deps"

$Dependencies = @{
    'premake-core'   = 'https://github.com/premake/premake-core/archive/423849f7a0b24140c6ca51f43deac344084443ee.zip'
}

$SelectedProjects = if ($Project -eq 'all') {
    $Dependencies.Keys
}
else {
    @($Project)
}

function Move-ExtractedContents {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Directory
    )

    $ExtractedDirectory = Get-ChildItem -LiteralPath $Directory -Directory |
    Select-Object -First 1

    if (-not $ExtractedDirectory) {
        throw "No extracted directory found in: $Directory"
    }

    Write-Host "Moving: $($ExtractedDirectory.FullName) -> $Directory"

    Get-ChildItem -LiteralPath $ExtractedDirectory.FullName -Force |
    Move-Item -Destination $Directory -Force

    Remove-Item -LiteralPath $ExtractedDirectory.FullName -Recurse -Force
}

function Expand-DependencyArchive {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Zip
    )

    $Destination = Join-Path (Split-Path $Zip -Parent) ([System.IO.Path]::GetFileNameWithoutExtension($Zip))
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null

    Write-Host "Extracting: $Zip"

    Expand-Archive -LiteralPath $Zip -DestinationPath $Destination -Force
}

function Save-DependencyArchive {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Url,

        [Parameter(Mandatory)]
        [string]$Destination,

        [switch]$Force
    )

    $Directory = Split-Path -Path $Destination -Parent
    New-Item -ItemType Directory -Path $Directory -Force | Out-Null

    $Zip = "$Destination.zip"

    if (Test-Path -LiteralPath $Zip) {
        if (-not $Force) {
            Write-Host "Skipping download: $Zip"
            return $Zip
        }

        Remove-Item -LiteralPath $Zip -Force
    }

    Write-Host "Downloading: $Url"
    Invoke-WebRequest -Uri $Url -OutFile $Zip -ErrorAction Stop

    return $Zip
}

function Get-Dependency {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Url,

        [Parameter(Mandatory)]
        [string]$Destination,

        [switch]$Force
    )

    if (Test-Path -LiteralPath $Destination) {
        if (-not $Force) {
            Write-Host "Skipping: $Destination"
            return
        }

        Remove-Item -LiteralPath $Destination -Recurse -Force
    }

    $Zip = Save-DependencyArchive -Url $Url -Destination $Destination -Force:$Force
    Expand-DependencyArchive -Zip $Zip
    Move-ExtractedContents -Directory $Destination
}

function Get-Dependencies {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [hashtable]$Dependencies,

        [Parameter(Mandatory)]
        [string]$DepsDir,

        [switch]$Force
    )

    foreach ($Name in $SelectedProjects) {
        Get-Dependency `
            -Url $Dependencies[$Name] `
            -Destination (Join-Path $DepsDir $Name) `
            -Force:$Force
    }
}

function Install-Premake5 {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$DepsDir,

        [Parameter(Mandatory)]
        [string]$InstallDir,

        [switch]$Force
    )

    $PremakeDir = Join-Path $DepsDir "premake-core"

    $ExeName = if ($IsWindows) {
        "premake5.exe"
    }
    else {
        "premake5"
    }

    $BuildExe = Join-Path $PremakeDir "bin" "release" $ExeName
    $InstalledExe = Join-Path $InstallDir $ExeName

    if ((Test-Path -LiteralPath $InstalledExe) -and -not $Force) {
        Write-Host "Skipping: $InstalledExe"
        return
    }

    Push-Location -LiteralPath $PremakeDir

    try {
        if ($IsWindows) {
            & ./Bootstrap.bat
        }
        elseif ($IsMacOS -or $IsLinux) {
            & ./Bootstrap.sh
        }
        else {
            throw "Unsupported operating system."
        }

        if ($LASTEXITCODE -ne 0) {
            throw "Premake bootstrap failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        Pop-Location
    }

    Copy-Item -LiteralPath $BuildExe -Destination $InstalledExe -Force

    Write-Host "Premake installed: $InstalledExe"
}

Get-Dependencies -Dependencies $Dependencies -DepsDir $DepsDir -Force:$Force

if ('premake-core' -in $SelectedProjects) {
    Install-Premake5 -InstallDir $RootDir -DepsDir $DepsDir -Force:$Force
}
