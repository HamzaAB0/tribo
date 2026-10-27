WARNINGS = /W4 /WX -Wpedantic /external:W0

CCXXFLAGS_COMMON = \
	/diagnostics:caret \
	/external:anglebrackets \
	/nologo \
	/options:strict \
	/permissive- \
	/Zf \
	/MP \
	/openmp \
	/FC \
	$(WARNINGS)

CCXXFLAGS_COMMON = /MD -fuse-ld=lld -g /FAs /nologo $(WARNINGS)
CCXXFLAGS_DEBUG = -fsanitize=address,undefined /Od /Zi $(CCXXFLAGS_COMMON)
CCXXFLAGS_RELEASE = \
	-O3 \
	/Qvec \
	/Qopt-report=0 \
	/Qopt-report-phase:vec,loop,openmp \
	/Qiopenmp \
	/Qopt-report-file:stdout \
	/Qipo \
	$(CCXXFLAGS_COMMON)

# Linker
LINKFLAGS_COMMON = /NOLOGO /WX /NOIMPLIB /DEBUG:FULL /TIME
LINKFLAGS_DEBUG = $(LINKFLAGS_COMMON)
LINKFLAGS_RELEASE = $(LINKFLAGS_COMMON) /INCREMENTAL:NO /LTCG:STATUS /LTCG

LDFLAGS_COMMON = /nologo -fuse-ld=lld
LDFLAGS_RELEASE = \
	-Qipo \
	/Qopt-report=2 \
	/Qopt-report-phase:vec,loop,openmp \
	/Qopt-report-file:$@.opt.txt

LINKFLAGS_DEBUG = $(LDFLAGS_COMMON) -fsanitize=address,undefined

# C++ flags.
CXXFLAGS_COMMON = /EHsc /std:c++latest /Zc:__cplusplus
CXXFLAGS_DEBUG = $(CXXFLAGS_COMMON) $(CCXXFLAGS_DEBUG)
CXXFLAGS_RELEASE = $(CXXFLAGS_COMMON) $(CCXXFLAGS_RELEASE)

# C flags.
CFLAGS_COMMON = -Xclang -std=c99 /Zc:__STDC__
CFLAGS_DEBUG = $(CFLAGS_COMMON) $(CCXXFLAGS_DEBUG)
CFLAGS_RELEASE = $(CFLAGS_COMMON) $(CCXXFLAGS_RELEASE)

AR = llvm-lib
