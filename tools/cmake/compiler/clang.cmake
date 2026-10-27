set(TRIBO_CXX_FLAGS_COMMON -Wall -Wextra -Wpedantic)

set(
  TRIBO_CXX_FLAGS_RELEASE
  -O3
  -fsave-optimization-record
  -foptimization-record-passes=loop-*
  -save-temps=obj
  -fverbose-asm
  ${TRIBO_CXX_FLAGS_COMMON}
)

set(
  TRIBO_CXX_FLAGS_DEBUG
  -g
  -O0
  -fsanitize=address
  -fsanitize=undefined
  -fno-omit-frame-pointer
  ${TRIBO_CXX_FLAGS_COMMON}
)

set(TRIBO_LINKER_FLAGS_DEBUG -fsanitize=address -fsanitize=undefined)

unset(TRIBO_CXX_FLAGS_COMMON)
