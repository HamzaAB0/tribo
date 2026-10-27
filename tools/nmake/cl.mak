WARNINGS = /W4 /WX /external:W0

CCXXFLAGS_COMMON = \
	/diagnostics:caret \
	/external:anglebrackets \
	/nologo \
	/options:strict \
	/permissive- \
	/Zc:preprocessor \
	/Zf \
	/MP \
	/openmp \
	/FC \
	$(WARNINGS)

CCXXFLAGS_DEBUG =	\
	/Od \
	/Z7 \
	/MDd \
	/fsanitize=address \
	$(CCXXFLAGS_COMMON)

CCXXFLAGS_RELEASE = \
	/O2 \
	/FAs \
	/MD \
	/Qpar \
	/Qpar-report:1 \
	/Qvec-report:1 \
	/GL \
	$(CCXXFLAGS_COMMON)

# C++ flags.
CXXFLAGS_COMMON = /EHsc /std:c++latest /Zc:__cplusplus
CXXFLAGS_DEBUG = $(CXXFLAGS_COMMON) $(CCXXFLAGS_DEBUG)
CXXFLAGS_RELEASE = $(CXXFLAGS_COMMON) $(CCXXFLAGS_RELEASE)

# C flags
CFLAGS_COMMON = /Zc:__STDC__ # Defaulting to default C99-ish behaviour.
CFLAGS_DEBUG = $(CFLAGS_COMMON) $(CCXXFLAGS_DEBUG)
CFLAGS_RELEASE = $(CFLAGS_COMMON) $(CCXXFLAGS_RELEASE)

LDFLAGS_COMMON = /nologo
LDFLAGS_DEBUG = /fsanitize=address $(LDFLAGS_COMMON)
LDFLAGS_RELEASE = $(LDFLAGS_COMMON)

LINKFLAGS_COMMON = /NOLOGO /TIME /WX /NOIMPLIB /machine:$(ARCH) /DEBUG:FULL
LINKFLAGS_DEBUG = $(LINKFLAGS_COMMON)
LINKFLAGS_RELEASE = $(LINKFLAGS_COMMON) /INCREMENTAL:NO /LTCG:STATUS /LTCG

AR = lib
