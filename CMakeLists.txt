cmake_minimum_required(VERSION 4.4.4)

# Enforced global properties.
set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD f35a9ac6-8463-4d38-8eec-5d6008153e7d)

project(tribo LANGUAGES CXX)

include(${CMAKE_CURRENT_LIST_DIR}/tools/cmake/architecture.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/tools/cmake/compiler/setup.cmake)

find_package(OpenMP REQUIRED)

add_executable(tribo-cli)

target_sources(tribo-cli
  PRIVATE
  src/frontend/cli/main.cpp
)

set_target_properties(tribo-cli
  PROPERTIES
  COMPILE_OPTIONS "${TRIBO_CXX_FLAGS}"
  CXX_SCAN_FOR_MODULES ON
  CXX_EXTENSIONS OFF
  CXX_MODULE_STD ON
  CXX_STANDARD 23
  CXX_STANDARD_REQUIRED ON
  LINK_LIBRARIES "OpenMP::OpenMP_CXX"
  LINK_OPTIONS "${TRIBO_LINKER_FLAGS}"
)

include(GNUInstallDirs)
install(TARGETS tribo-cli
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
