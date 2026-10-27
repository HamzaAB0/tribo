#!/usr/bin/env pwsh

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Enter-VS {
    [CmdletBinding()]
    param(
        [ValidateSet('arm64', 'amd64', 'x86')]
        [string]$HostArch,

        [ValidateSet('arm64', 'amd64', 'x86')]
        [string]$TargetArch
    )

    # Detect native OS architecture
    $DetectedArch = switch (
        [Runtime.InteropServices.RuntimeInformation]::OSArchitecture
    ) {
        'Arm64' { 'arm64' }
        'X64' { 'amd64' }
        'X86' { 'x86' }
        default { throw "Unsupported OS architecture: $_" }
    }

    if (-not $HostArch) {
        $HostArch = $DetectedArch
    }

    if (-not $TargetArch) {
        $TargetArch = $DetectedArch
    }

    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

    if (-not (Test-Path $vswhere)) {
        throw "vswhere.exe not found: $vswhere"
    }

    $vs = & $vswhere -latest -products '*' -property installationPath

    if (-not $vs) {
        throw "No Visual Studio installation found."
    }

    Import-Module "$vs\Common7\Tools\Microsoft.VisualStudio.DevShell.dll" -ErrorAction Stop

    Enter-VsDevShell `
        -VsInstallPath $vs `
        -Arch $TargetArch `
        -HostArch $HostArch `
        -SkipAutomaticLocation
}

Enter-VS
