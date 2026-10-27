local deps_dir = path.getabsolute("build/deps")

workspace "tribo"
  language "C++"
  location "build"

  configurations { "debug", "release", "release-lto" }
  platforms { "x64", "arm64" }

  filter { "platforms:x64" }
    architecture "x64"
  filter { "platforms:arm64" }
    architecture "arm64"
  filter {}

  -- Unique output folder.
  objdir "%{wks.location}/%{cfg.buildcfg}-%{cfg.platform}/tmp/%{prj.name}"
  targetdir "%{wks.location}/%{cfg.buildcfg}-%{cfg.platform}/bin"

  -- Static libraries are not needed in final binary location.
  filter { "kind:StaticLib" }
    targetdir "%{cfg.objdir}"
  filter {}

  -- Setup compiler flags
  cppdialect "c++latest"
  scanformoduledependencies "On"

  conformancemode "On"
  editandcontinue "Off"
  externalwarnings "Off"
  externalanglebrackets "On"
  warnings "Extra"

  filter { "tags:not deps" }
    fatalwarnings { "All" }
  filter { }

  usestandardpreprocessor "On"

  userelativelinks "On"
  incrementallink "Off"
  multiprocessorcompile "On"

  -- Release Flags
  filter { "configurations:release*" }
    optimize "Speed"
    symbols "Off"
    runtime "Release"
  filter { "configurations:release-lto" }
    linktimeoptimization "On"
  filter { "tags:asm", "configurations:release*" }
    generateassembly "verbose"
    buildoptions { "/Qvec-report:1" }

  -- Debug Flags
  filter { "configurations:debug" }
    optimize "Off"
    symbols "On"
    runtime "Debug"
    sanitize { "Address" }
  filter{}

  buildoptions {
    "/diagnostics:caret",
    "/options:strict"
  }

  startproject "tribo-cli"

  project "tribo-cli"
    kind "ConsoleApp"
    files { "src/frontend/cli/**.cpp" }
