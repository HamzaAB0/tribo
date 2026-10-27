# Makefile for GNU make on Linux and MacOS.
# [Variables]
# CC: Path to the C Compiler
# TIDY: Path to clang-tidy

include tools/gmake/setup.mak

SRC_CLI := $(sort $(shell find src/cli -type f -name '*.c'))
OBJ_CLI := $(patsubst %.c, tmp/%.o, $(SRC_CLI))
ASM_CLI := $(OBJ_CLI:.o=.s)
TIDY_CLI := $(OBJ_CLI:.o=.tidy)

all: bin/tribo-cli
	@echo Built $@: $^

bin/tribo-cli: $(OBJ_CLI) | bin
	$(CC) $(LDFLAGS) $^ -o $@

# Second expansion used to deduce dependency on output directory
.SECONDEXPANSION:
tmp/%.o: %.c | $$(@D)/.
	$(CC) -c $< -o $@ $(CFLAGS)

asm: $(ASM_CLI)

tmp/%.s: %.c | $$(@D)/.
	$(CC) -g -S -fverbose-asm $< -o $@ $(CFLAGS)

tidy: $(TIDY_CLI)

tmp/%.tidy: %.c | $$(@D)/.
	$(TIDY) $< -- $(CFLAGS)
	echo > $@

bin:
	mkdir -p $@

# Rules for creating output directories. Prevent deletion of pattern dirs.
.PRECIOUS: tmp/%/.
tmp/%/.:
	mkdir -p $@

clean:
	rm -rf bin tmp

rebuild: clean
	$(MAKE) $(filter-out rebuild,$(MAKECMDGOALS))
