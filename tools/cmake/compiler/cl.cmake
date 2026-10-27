set(
  TRIBO_CXX_FLAGS_COMMON
  /diagnostics:caret
  /EHsc
  /external:anglebrackets
  /external:W0
  /FAs
  /FC
  /options:strict
  /nologo
  /permissive-
  /W4
  /Zc:preprocessor
  /Zc:__cplusplus
)

set(TRIBO_CXX_FLAGS_RELEASE ${TRIBO_CXX_FLAGS_COMMON} /O2 /Qpar /Qpar-report:1 /Qvec-report:1)
set(TRIBO_CXX_FLAGS_DEBUG ${TRIBO_CXX_FLAGS_COMMON} /Od /fsanitize=address)

set(TRIBO_LINKER_FLAGS_DEBUG /INCREMENTAL:NO /fsanitize=address)
set(TRIBO_LINKER_FLAGS_RELEASE /INCREMENTAL:NO)

unset(TRIBO_CXX_FLAGS_COMMON)
