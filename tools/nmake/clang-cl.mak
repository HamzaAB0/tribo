!IF "$(ARCH)" == "x64"
CLANG_ARCH = x86_64
!ELSEIF "$(ARCH)" == "arm64"
CLANG_ARCH = aarch64
!ENDIF

WARNINGS = /W4 /WX -Wpedantic /external:W0

CCXXFLAGS_COMMON = \
	/nologo \
	/options:strict \
	/diagnostics:caret \
	/FC \
	-fuse-ld=lld \
	/openmp \
	/MD \
	/permissive- \
	-target $(CLANG_ARCH)-pc-windows-msvc \
	$(WARNINGS)

CCXXFLAGS_DEBUG = /Od /Zi $(CCXXFLAGS_COMMON)

CCXXFLAGS_RELEASE = -Xclang -O3 /Qvec -flto /FAs $(CCXXFLAGS_COMMON)

LDFLAGS_COMMON = -fuse-ld=lld -target $(CLANG_ARCH)-pc-windows-msvc /MD
LDFLAGS_DEBUG = $(LDFLAGS_COMMON)
LDFLAGS_RELEASE = $(LDFLAGS_COMMON)

LINKFLAGS_COMMON = /NOLOGO /WX /NOIMPLIB /DEBUG:FULL /TIME
LINKFLAGS_DEBUG = $(LINKFLAGS_COMMON)
LINKFLAGS_RELEASE = $(LINKFLAGS_COMMON) /INCREMENTAL:NO /LTCG:STATUS /LTCG

# C++ flags.
CXXFLAGS_COMMON = /EHsc /std:c++latest /Zc:__cplusplus
CXXFLAGS_DEBUG = $(CXXFLAGS_COMMON) $(CCXXFLAGS_DEBUG)
CXXFLAGS_RELEASE = $(CXXFLAGS_COMMON) $(CCXXFLAGS_RELEASE)

# C flags
CFLAGS_COMMON = -Xclang -std=c99 /Zc:__STDC__
CFLAGS_DEBUG = $(CFLAGS_COMMON) $(CCXXFLAGS_DEBUG)
CFLAGS_RELEASE = $(CFLAGS_COMMON) $(CCXXFLAGS_RELEASE)

# On x64 builds, add ASan and UBSan. Not available for Arm64.
!IF "$(ARCH)" == "x64"
CCXXFLAGS_DEBUG = $(CCXXFLAGS_DEBUG) -fsanitize=address,undefined
LDFLAGS_DEBUG = $(LDFLAGS_DEBUG) -fsanitize=address,undefined
!ENDIF

AR = llvm-lib
