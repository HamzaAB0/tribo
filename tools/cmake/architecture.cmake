if(NOT DEFINED TRIBO_BUILD_ARCH)
  string(TOLOWER "${CMAKE_HOST_SYSTEM_PROCESSOR}" _tribo_host_arch)

  if(_tribo_host_arch MATCHES "^(x86_64|amd64|x64)$")
    set(TRIBO_BUILD_ARCH x64)
  elseif(_tribo_host_arch MATCHES "^(aarch64|arm64)$")
    set(TRIBO_BUILD_ARCH arm64)
  else()
    message(FATAL_ERROR
      "Unsupported host architecture '${CMAKE_HOST_SYSTEM_PROCESSOR}'. "
      "Set TRIBO_BUILD_ARCH explicitly to x64 or arm64."
    )
  endif()
endif()

if(NOT TRIBO_BUILD_ARCH MATCHES "^(x64|arm64)$")
  message(FATAL_ERROR
    "Invalid TRIBO_BUILD_ARCH '${TRIBO_BUILD_ARCH}'. Expected x64 or arm64."
  )
endif()

set(TRIBO_BUILD_ARCH "${TRIBO_BUILD_ARCH}" CACHE STRING "Build architecture (x64 or arm64)")
set_property(CACHE TRIBO_BUILD_ARCH PROPERTY STRINGS x64 arm64)

unset(_tribo_host_arch)
