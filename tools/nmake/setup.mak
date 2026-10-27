# Architecture detection
!IFDEF VSCMD_ARG_TGT_ARCH
ARCH = $(VSCMD_ARG_TGT_ARCH)
!ELSE
!ERROR Unable to determine target architecture from VSCMD_ARG_TGT_ARCH. Please run from a Visual Studio Developer Command Prompt.
!ENDIF

# Compiler detection
!IF "$(findstringi clang-cl,$(CC))" != ""
COMPILER=clang-cl
!ELSEIF "$(findstringi icx-cl,$(CC))" != ""
COMPILER=icx-cl
!ELSEIF "$(CC)" == "cl"
COMPILER=cl
!ELSE
!ERROR Unsupported compiler: $(CC), expected cl, clang-cl or icx-cl
!ENDIF

!INCLUDE $(COMPILER).mak

# Set flags based on build type.
!IF "$(DEBUG)" == "1"
CFLAGS = $(strip $(CFLAGS_DEBUG))
CXXFLAGS = $(strip $(CXXFLAGS_DEBUG))
LDFLAGS = $(strip $(LDFLAGS_DEBUG))
LINKFLAGS = $(strip $(LINKFLAGS_DEBUG))
ARFLAGS = $(strip $(ARFLAGS_DEBUG))
!ELSE
CFLAGS = $(strip $(CFLAGS_RELEASE))
CXXFLAGS = $(strip $(CXXFLAGS_RELEASE))
LDFLAGS = $(strip $(LDFLAGS_RELEASE))
LINKFLAGS = $(strip $(LINKFLAGS_RELEASE))
ARFLAGS = $(strip $(ARFLAGS_RELEASE))
!ENDIF
