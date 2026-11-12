CC      ?= gcc
# Python is only used by the gate scripts under tests/.  Override with
# `make PYTHON=/path/to/python test` if the interpreter is not on PATH.
PYTHON  ?= python
CFLAGS  ?= -Wall -Wextra -O2 -std=c99 -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-unused-variable -Wno-unused-function -Iinclude
LDFLAGS ?=

SRC_CORE := $(wildcard src/*.c)
SRC_BE   := $(wildcard src/backend/*/*.c) src/backend/registry.c
SRC_HOST := port/host/flash_fs_host.c port/host/platform_host.c port/host/debug_host.c
SRC      := $(SRC_CORE) $(SRC_BE) $(SRC_HOST)

ifeq ($(OS),Windows_NT)
ARKCC := arkcc.exe
RM    := del /Q
NULLDEV := nul
else
ARKCC := arkcc
RM    := rm -f
NULLDEV := /dev/null
endif

.PHONY: all clean test test-arm test-c test-stdlib test-install test-x86 test-x86-64 \
        test-riscv test-reloc-text test-atomic install stm32

all: $(ARKCC)

$(ARKCC): $(SRC) $(wildcard include/*.h)
# Headers are prerequisites too: a header-only change (a size macro, a
# profile default) used to leave the old binary in place, and 'make' said
# "Nothing to be done" while the source tree said otherwise.
	$(CC) $(CFLAGS) $(SRC) -o $(ARKCC) $(LDFLAGS)

# Every backend gets at least an emit smoke test here, so a change that breaks
# one target cannot hide behind the others' gates.  The four symbolic targets
# (stdlib / install / reloc-text / x86-64) execute code; they are what actually
# say "this works", the rest only say "this still compiles".
test: test-arm test-c test-x86 test-riscv test-stdlib test-install test-reloc-text test-x86-64 test-atomic

test-arm: $(ARKCC)
	./$(ARKCC) examples/hello.c -target arm -S -o $(NULLDEV)
	./$(ARKCC) examples/arith.c -target arm -S -o $(NULLDEV)
	./$(ARKCC) examples/func.c  -target arm -S -o $(NULLDEV)

test-c: $(ARKCC)
	./$(ARKCC) examples/hello.c -target c -o hello.gen.c
	./$(ARKCC) examples/arith.c -target c -o arith.gen.c
	./$(ARKCC) examples/func.c  -target c -o func.gen.c

# Gate for --reloc-text: two objects, linked 0x1C070000 away from the base they
# were compiled against, must end up with their string literals pointing at
# themselves -- and with the flag off, at the old (wrong) address.  The second
# object is the point: a global delta passes object #0 and fails object #1.
test-reloc-text: $(ARKCC)
	$(PYTHON) tests/run_reloc_text_tests.py ./$(ARKCC)

# Library gate: every stdlib entry point is compiled and run on the ARM
# emulator, and each case asserts a number the program itself computed.  A
# case that needs hardware the emulator does not have (double-precision FPU)
# is reported as SKIP with the measured reason -- never silently passed.
test-stdlib: $(ARKCC)
	$(PYTHON) tests/run_stdlib_tests.py --arkcc ./$(ARKCC)

test-x86: $(ARKCC)
	./$(ARKCC) examples/hello.c -target x86 -S -o $(NULLDEV)
	./$(ARKCC) examples/arith.c -target x86 -S -o $(NULLDEV)
	./$(ARKCC) examples/func.c  -target x86 -S -o $(NULLDEV)

# x86-64 gate: sixteen programs are compiled to a flat image and executed on a
# 64-bit core, each asserting a constant computed outside the program.  The
# last two stages are the ones that make the passes mean anything: an external
# symbol the image cannot resolve must be refused (not linked as `call +0`),
# and the harness re-runs a case with a deliberately wrong expectation and
# requires it to fail.  The 32-bit `x86` result is printed as a reference arm
# only -- that backend's pre-existing 64-bit/FP gaps are reported as SKIP.
test-x86-64: $(ARKCC)
	$(PYTHON) tests/run_x86_64_image_tests.py --arkcc ./$(ARKCC)

# _Atomic gate: five targets, four checks.  Each target's identity macro must be
# exactly one and must name itself; the eleven atomic operations must be a
# compile error on the four non-ARM targets, must say which operation and what to
# use instead, and must leave no output file behind; atomic_init must compile
# everywhere.  The last stage is the one that makes refusals mean something: the
# same source must NOT be refused on arm, otherwise "refused" has no resolution.
test-atomic: $(ARKCC)
	$(PYTHON) tests/run_atomic_tests.py --arkcc ./$(ARKCC)

test-riscv: $(ARKCC)
	./$(ARKCC) examples/hello.c -target riscv32 -S -o $(NULLDEV)
	./$(ARKCC) examples/arith.c -target riscv32 -S -o $(NULLDEV)
	./$(ARKCC) examples/func.c  -target riscv32 -S -o $(NULLDEV)

# The install gate builds a program *against the installed tree* (malloc + div
# + qsort) and runs it on the emulator, so "the copy is byte-identical" is not
# the only thing it proves.
test-install: $(ARKCC)
	$(PYTHON) tests/run_install_tests.py --arkcc ./$(ARKCC)

# ===== install =====
# Stages the driver, headers and library sources under $(DESTDIR)$(PREFIX).
# DESTDIR is a staging root (package builds) and is empty by default; the
# script refuses to write outside it, never deletes, and reads every installed
# file back byte-for-byte.
PREFIX  ?= /usr/local
DESTDIR ?=

install: $(ARKCC)
	$(PYTHON) tools/install.py --prefix "$(PREFIX)" $(if $(DESTDIR),--destdir "$(DESTDIR)") --arkcc ./$(ARKCC)

# ===== STM32 cross-compilation =====
# Fails if arm-none-eabi-gcc is missing, but Makefile syntax stays valid.
ARM_GCC ?= arm-none-eabi-gcc

STM32_CFLAGS = -mcpu=cortex-m7 -mthumb -mfpu=fpv5-d16 -mfloat-abi=hard \
    -DARKCC_STM32 -DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN \
    -DARK_POOL_SIZE=262144 \
    -DARK_SRC_BUF_SIZE=32768 -DARK_ASM_BUF_SIZE=131072 -DARK_CODE_BUF_SIZE=65536 \
    -DARK_OBJ_BUF_SIZE=4096 -DARK_LINK_BUF_SIZE=4096 \
    -DARKCC_BACKEND_X86_64=0 -DARKCC_BACKEND_RISCV32=0 -DARKCC_BACKEND_C=0 \
    -Iinclude -Iport/stm32 \
    -Wall -Wextra -O2 -std=c99 -ffreestanding -nostdlib \
    -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-unused-variable -Wno-unused-function

# STM32 builds only the ARM backend + frontend core (excludes main.c; keeps config.c, now using fs_read_file).
# Excludes the C backend (not needed on STM32); x86_64/riscv32 backend files are not compiled,
# and -DARKCC_BACKEND_*=0 keeps registry.c from referencing their symbols.
STM32_SRC := $(wildcard src/*.c)
STM32_SRC := $(filter-out src/main.c, $(STM32_SRC))
STM32_SRC += src/backend/arm/backend_arm.c src/backend/registry.c
STM32_SRC += port/stm32/flash_fs_stm32.c port/stm32/platform_stm32.c port/stm32/main_stm32.c

arkcc_stm32.elf: $(STM32_SRC)
	$(ARM_GCC) $(STM32_CFLAGS) -o $@ $^ -lgcc

stm32: arkcc_stm32.elf

clean:
	-$(RM) $(ARKCC) arkcc arkcc.exe *.bin *.gen.c
	-$(RM) arkcc_stm32.elf
