# Detect architecture
UNAME_M := $(shell uname -m)
ifeq ($(UNAME_M),x86_64)
	ARCH := x64
else ifeq ($(UNAME_M),aarch64)
	ARCH := arm64
else ifeq ($(UNAME_M),arm64)
	ARCH := arm64
else
$(error Unsupported architecture: $(UNAME_M), expected x64 or aarch64.)
endif

# Detect OS
UNAME := $(shell uname -s | tr A-Z a-z)
ifeq ($(UNAME),darwin)
	OS := macos
else ifeq ($(UNAME),linux)
	OS := linux
else
$(error Unsupported OS: $(UNAME), expected Windows, Linux or MacOS.)
endif

# Detect compiler
ifeq ($(OS)-$(CC),linux-cc)
COMPILER = gcc
else ifeq ($(OS)-$(CC),macos-cc)
COMPILER = appleclang
else ifneq ($(findstring clang,$(CC)),)
COMPILER = clang
else ifneq ($(findstring gcc,$(CC)),)
COMPILER = gcc
else
$(error Unsupported compiler: $(CC). Expected clang or gcc.)
endif

MAKEFILE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(MAKEFILE_DIR)/$(COMPILER).mak

ifeq ($(DEBUG),1)
CFLAGS := $(strip $(CFLAGS_DEBUG))
CXXFLAGS := $(strip $(CXXFLAGS_DEBUG))
LDFLAGS := $(strip $(LDFLAGS_DEBUG))
else
CFLAGS := $(strip $(CFLAGS_RELEASE))
CXXFLAGS := $(strip $(CXXFLAGS_RELEASE))
LDFLAGS := $(strip $(LDFLAGS_RELEASE))
endif

TIDY := clang-tidy
