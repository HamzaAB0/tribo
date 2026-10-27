# Common compiler flags.
WARNINGS := -Wall -Wextra -Wpedantic -Werror

CXXFLAGS_REPORT := \
	-foptimization-record-passes=loop-vectorize\|loop-unroll\|slp-vectorizer \
	-fsave-optimization-record

CCXXFLAGS_COMMON := $(WARNINGS) -MMD -fopenmp
CCXXFLAGS_DEBUG := -g -O0 -fno-omit-frame-pointer -fsanitize=address,undefined $(CCXXFLAGS_COMMON)
CCXXFLAGS_RELEASE := -O3 $(CCXXFLAGS_COMMON) $(CXXFLAGS_REPORT)

CFLAGS_COMMON := -std=c99
CFLAGS_DEBUG := $(CFLAGS_COMMON) $(CCXXFLAGS_DEBUG)
CFLAGS_RELEASE := $(CFLAGS_COMMON) $(CCXXFLAGS_RELEASE)

CXXFLAGS_COMMON := -std=c++23
CXXFLAGS_DEBUG := $(CXXFLAGS_COMMON) $(CCXXFLAGS_DEBUG)
CXXFLAGS_RELEASE := $(CXXFLAGS_COMMON) $(CCXXFLAGS_RELEASE)

ifeq ($(OS),macos)
LD_WERROR_FLAG = -Wl,-fatal_warnings
else
LD_WERROR_FLAG = -Wl,--fatal-warnings
endif

LDFLAGS_COMMON := -fuse-ld=lld $(LD_WERROR_FLAG)
LDFLAGS_DEBUG := -fsanitize=address,undefined $(LDFLAGS_COMMON)
LDFLAGS_RELEASE := $(LDFLAGS_COMMON)

AR := llvm-ar
