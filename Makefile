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
EXE   := .exe
else
ARKCC := arkcc
RM    := rm -f
NULLDEV := /dev/null
EXE   :=
endif

.PHONY: all clean test test-arm test-c test-stdlib test-install test-x86 test-x86-64 \
        test-x86-64-selfhost test-riscv test-reloc-text test-memlint \
        test-enumcheck test-pipeline test-unusedresult test-mir \
        test-loop test-modern test-atomic test-ipo test-constglobal \
        test-objir test-partiallink test-deadinline test-softfloat \
        install stm32

all: $(ARKCC)

$(ARKCC): $(SRC) $(wildcard include/*.h)
# Headers are prerequisites too: a header-only change (a size macro, a
# profile default) used to leave the old binary in place, and 'make' said
# "Nothing to be done" while the source tree said otherwise.
	$(CC) $(CFLAGS) $(SRC) -o $(ARKCC) $(LDFLAGS)

# Every backend gets at least an emit smoke test here, so a change that breaks
# one target cannot hide behind the others' gates.  The symbolic targets
# (stdlib / install / reloc-text / x86-64) execute code and memlint checks the
# diagnostics the compiler prints; those are what actually say "this works",
# the rest only say "this still compiles".
test: test-arm test-c test-x86 test-riscv test-stdlib test-install test-reloc-text test-x86-64 test-memlint test-enumcheck test-pipeline test-unusedresult test-mir test-loop test-modern test-atomic test-ipo test-constglobal test-objir test-partiallink test-deadinline test-strinit test-layout test-complit test-softfloat

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

# Gate for --warn-mem: the two shapes the pass claims to see must be reported on
# the right line, the legal twin of each must be silent, and a build with
# -DARKCC_FEATURE_MEMLINT=0 must refuse the option instead of ignoring it.
test-memlint: $(ARKCC)
	$(PYTHON) tests/run_memlint_tests.py ./$(ARKCC)

test-enumcheck: $(ARKCC)
	$(PYTHON) tests/run_enumcheck_tests.py ./$(ARKCC)

test-pipeline: $(ARKCC)
	$(PYTHON) tests/run_pipeline_tests.py --arkcc ./$(ARKCC)

# Gate for --warn-unused-result: an annotated call used as a statement warns on
# the call's line, the (void) cast and every value-consuming shape stay silent,
# a call through a pointer is silent, and a build without the feature refuses
# the option instead of pretending to check.
test-unusedresult: $(ARKCC)
	$(PYTHON) tests/run_unusedresult_tests.py ./$(ARKCC)

# Gate for the MIR checks (--warn-unreachable / --warn-unused-static /
# --warn-recursion): every reported shape is located by anchor, every legal
# twin is silent, the image is byte-identical with the checks on and off
# (they are lint, not optimisation), the graph builder re-verifies its own
# invariants on the case sources, and a build without the feature refuses the
# options instead of pretending to analyse control flow.
test-mir: $(ARKCC)
	$(PYTHON) tests/run_mir_tests.py ./$(ARKCC)

# Gate for --licm / --unroll: the invariant really moves out of the loop and
# the counted loop really disappears, both programs still compute the same
# answer on the ARM emulator, both switches off are byte-identical to a build
# without the passes, and a build with the features cropped refuses the
# options instead of pretending to optimise.
test-loop: $(ARKCC)
	$(PYTHON) tests/run_loop_tests.py ./$(ARKCC)

# Gate for --diag_style=modern: the header, the framed echo and the caret
# column are checked against the token they point at (by display width, so a
# tab counts one column and a CJK character two), the arm and ide styles must
# stay byte-identical, and the note line must exist in modern only.  The last
# stage builds a cropped compiler (-DARKCC_FEATURE_DIAG=0) and requires it to
# link, so a missing no-op cannot hide behind the full build.
test-modern: $(ARKCC)
	$(PYTHON) tests/run_modern_diag_tests.py ./$(ARKCC)

# Gate for --ipo / -flto: one program built from several sources.  The merge
# rules are checked where a shortcut would change an answer -- each file keeps
# its own static of one name, two strong definitions are an error, two
# tentative ones are one object, an undefined external is still refused -- and
# the cross-file inline at -O2 is read off the assembly.  A build cropped with
# -DARKCC_FEATURE_IPO=0 must refuse the option instead of pretending to merge.
test-ipo: $(ARKCC)
	$(PYTHON) tests/run_ipo_tests.py ./$(ARKCC)

# Constant-object gate: a const global with a scalar initialiser is a constant
# even when the reader sits in another translation unit, so after the IPO
# merge a pass may replace its load with an immediate.  The gate asserts both
# directions (folded / still a load) and every conservative case that must NOT
# fold: address taken, store through a cast, volatile, array, long long.  A
# build cropped with -DARKCC_FEATURE_CONST_GLOBAL=0 must refuse the option.
test-constglobal: $(ARKCC)
	$(PYTHON) tests/run_constglobal_tests.py ./$(ARKCC)

# Object-IR gate: -c --obj-ir appends the pre-pipeline IR to the ARKOBJ2 file
# and -link --lto replays it, so the linked program must be byte-identical to
# --ipo (same pools, same inlining, same constant folding).  The gate also
# corrupts the payload four ways and requires a named error with no output
# file, and a build cropped with -DARKCC_FEATURE_OBJ_IR=0 must refuse both.
test-objir: $(ARKCC)
	$(PYTHON) tests/run_objir_tests.py ./$(ARKCC)

# Partial-link gate: -r merges ARKOBJ2 objects into one object (code, symbols,
# relocations) instead of writing an image, so `-link` of the merged object must
# reproduce the direct link byte for byte and answer the same number.  The gate
# also requires every refusal it advertises -- an IR payload, two objects that
# place .data/.bss, a foreign ISA, a damaged object -- to exit non-zero and
# write nothing, and a build cropped with -DARKCC_FEATURE_PARTIAL_LINK=0 to
# refuse -r while producing byte-identical objects.
test-partiallink: $(ARKCC)
	$(PYTHON) tests/run_partiallink_tests.py ./$(ARKCC)

# Dead-inline gate: an unreferenced `static inline` function no longer reaches
# code generation, so a unit that includes a CMSIS-style header but never calls
# its helper compiles even though that helper references an external object.
# The gate asserts the drop and, equally, every shape that must NOT drop: a
# called inline, `__attribute__((used))`, an address taken by a global
# initializer, main, plain `static` (still reported, not silently removed) and
# any unit containing inline asm (the pass backs off entirely).
test-deadinline: $(ARKCC)
	$(PYTHON) tests/run_deadinline_tests.py ./$(ARKCC)

# Soft-float runtime gates (stdlib/src/arm/aeabi_float.c).  Two independent
# oracles, because "the algorithm looks right" is not evidence: the host build
# compares the runtime against the host's own IEEE double bit for bit, and the
# ARM gate builds the same table into a real image and executes it on a core
# model.  -mfpmath=sse is load bearing: an x87 host rounds twice and turns the
# very first tie (2^52/DBL_MAX) into a wrong answer, which would blame the
# runtime for a host flag.  Both halves run from one target -- skipping the
# host half because it "obviously passes" is how a wrong runtime ships.
test-softfloat: $(ARKCC)
	$(CC) -std=c99 -O2 -ffp-contract=off -fno-fast-math -msse2 -mfpmath=sse \
	    tests/softfloat_ref.c stdlib/src/arm/aeabi_float.c -o build_softfloat_tests/sf_ref$(EXE)
	./build_softfloat_tests/sf_ref$(EXE)
	$(PYTHON) tests/run_arm_softfloat_tests.py --arkcc ./$(ARKCC)
# Gate for a block-scope string literal initialiser on a freestanding target:
# `char a[] = "hello";` used to lower to a real `IR_CALL "memcpy"`, which links
# on the host (libc) and fails on a freestanding ARM/RV32I target with
# "unresolved symbol memcpy".  The programs here link with no runtime object
# at all, run on the emulator, and a planted libc call proves the detector has
# a positive sample.
test-strinit: $(ARKCC)
	$(PYTHON) tests/run_str_init_tests.py --arkcc ./$(ARKCC)

# Layout gate: sizeof/offsetof of packed structs, bit-fields, `:0` separators and
# #pragma pack scopes, checked against armcc 5.06 (the ABI these targets use).
# The host gcc cannot serve as the oracle: gcc 4.8 (MinGW) ignores
# __attribute__((packed)) on structs entirely, so every packed case would
# "agree" with the wrong layout.  Each case runs on the ARM emulator and
# returns a number the program computed itself.
test-layout: $(ARKCC)
	$(PYTHON) tests/run_layout_tests.py --arkcc ./$(ARKCC)

# Compound-literal / subscript gate: `(struct S){3,4}.b` used to read member 0,
# `2[arr]` used to multiply the *address* by the element size, `(char *)&a[1]+4`
# used to move four ints, and `sizeof((int[]){1,2,3})` answered 4.  Every case
# asserts a number the program itself computes, and three checks replay a
# deliberately wrong expectation to prove the gate can fail.
test-complit: $(ARKCC)
	$(PYTHON) tests/run_complit_tests.py --arkcc ./$(ARKCC)

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

# x86-64 gate: every program is compiled to a flat image and executed on a
# 64-bit core, each asserting a constant computed outside the program.  The
# last two stages are the ones that make the passes mean anything: an external
# symbol the image cannot resolve must be refused (not linked as `call +0`),
# and the harness re-runs a case with a deliberately wrong expectation and
# requires it to fail.  Every program is then compiled a second time for the
# 32-bit `x86` target and run again; an i386 answer that differs from the
# expectation fails the case -- that backend is a verdict, not a reference arm.
test-x86-64: $(ARKCC)
	$(PYTHON) tests/run_x86_64_image_tests.py --arkcc ./$(ARKCC)

# x86-64 self-host gate: arkcc compiles all 24 of its own translation units
# on the target, the self-compiled compiler is linked into a flat image that
# runs on unicorn, and it then has to reproduce the HOST object for a payload
# byte for byte.  Equality of the assembly text alone is not a pass: it only
# says where a difference is, not that there is none.
# Kept out of the default `test` aggregate on purpose -- it shells out to the
# target compiler 26 times (about two minutes) where the other gates take
# seconds.
test-x86-64-selfhost: $(ARKCC)
	$(PYTHON) tests/run_x86_64_selfhost.py --arkcc ./$(ARKCC)

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
