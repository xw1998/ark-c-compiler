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
        test-objir test-partiallink test-deadinline test-softfloat test-tailmerge \
        test-tailcall test-divconst test-xblock test-sizeweight \
        test-inline test-vstack test-addr test-strength test-cbz test-branch \
        test-imm test-peep test-cbranch test-copyprop test-live test-movimm test-pair \
        test-prop test-deadpush test-cmat test-slotreg test-opalloc test-boolmat \
        test-voldmb test-volmem test-constcond \
        test-litpool test-coalesce install \
        stm32 stm32-check

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
test: test-arm test-c test-x86 test-riscv test-stdlib test-install test-reloc-text test-x86-64 test-memlint test-enumcheck test-pipeline test-unusedresult test-mir test-loop test-modern test-atomic test-ipo test-constglobal test-objir test-partiallink test-deadinline test-strinit test-layout test-complit test-knr test-bitfield test-dblprec test-floatlit test-softfloat test-arm-exec test-buffers test-tailmerge test-tailcall test-divconst test-xblock test-sizeweight test-inline test-vstack test-addr test-strength test-cbz test-branch test-imm test-peep test-cbranch test-copyprop test-cmat test-slotreg test-opalloc test-live test-movimm test-litpool test-coalesce test-voldmb test-volmem test-constcond test-boolmat

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

# Gate for --tailmerge: on/off byte identity, negative shapes that must not
# merge, the same program still running to the same result through the ARM
# executor, the byte account (merged image strictly smaller), and the trimmed
# build refusing the option instead of pretending to optimise.
test-tailmerge: $(ARKCC)
	$(PYTHON) tests/run_tailmerge_tests.py ./$(ARKCC)

# Gate for --tailcall: the convertible shapes must branch instead of calling,
# the refused shapes must come out untouched, the same program must return the
# same value through the ARM executor, the pass must be off by default, and a
# cropped build (-DARKCC_FEATURE_TAILCALL=0) must refuse the option by name
# instead of silently ignoring it.
test-tailcall: $(ARKCC)
	$(PYTHON) tests/run_tailcall_tests.py ./$(ARKCC)

# Gate for --divconst: every constant divide must lose its SDIV/UDIV and
# gain the documented sequence, the refused constants must stay byte-identical,
# a table of dividends must agree three ways (switch off / switch on / exact
# Python model) on the ARM executor, --reg-top and --tailcall must not disturb
# it, the pass must be off by default, and a cropped build
# (-DARKCC_FEATURE_DIVCONST=0) must refuse the option by name.
test-divconst: $(ARKCC)
	$(PYTHON) tests/run_divconst_tests.py ./$(ARKCC)

# Gate for --xblock (whole-block cross-jump): the repeated body must survive
# once with every other copy branching to it, every refused shape (conditional
# branch with two fall-throughs, identical bodies leaving to different blocks,
# a body below the length floor, inline asm) must stay byte-identical, the same
# program must return the same value through the ARM executor, the pass must be
# off by default, and a cropped build (-DARKCC_FEATURE_XBLOCK=0) must refuse
# the option by name.
test-xblock: $(ARKCC)
	$(PYTHON) tests/run_xblock_tests.py ./$(ARKCC)

# Gate for --size-weight (0..9, 5 = the 0.9.0 constants): the four threshold
# tables, the "weight 5 and no flag are byte-identical" account over the corpus,
# each threshold reaching real code at 0/5/9, every malformed value refused
# without writing an object, the ini key in both spellings, the same return
# value through the ARM executor, and a cropped build (the four pass macros at
# 0) that refuses the option by name and prints no weight table at all.
test-sizeweight: $(ARKCC)
	$(PYTHON) tests/run_sizeweight_tests.py ./$(ARKCC)

# Gate for inlining functions that take parameters (0.9.1): a small
# parameterised callee is expanded at -O2 and not with --no_autoinline,
# the size rule still refuses it at --size-weight=9, __forceinline still
# bypasses that rule, two-word parameters (long long / double / 5..8-byte
# structs) are copied word-accurately, the refused shapes (>8-byte struct
# by address, five parameters, recursion, "...") keep their calls, the C
# and x86-64 targets keep theirs too, the same program returns the same
# value on the ARM executor, and a cropped build
# (-DARKCC_FEATURE_OPT_INLINE=0) refuses --autoinline by name.
test-inline: $(ARKCC)
	$(PYTHON) tests/run_inline_tests.py ./$(ARKCC)

# Gate for -fopt-vstack: with the flag off the object must be byte-identical to
# the default build; with it on the pushed/popped values must stay in r5/r7,
# no rewritten function may still contain a lone PUSH/POP pair, the image must
# never grow, and the ARM executor must return the same value from the plain,
# the vstack and the vstack+regalloc builds.  A cropped build
# (-DARKCC_FEATURE_OPT_VSTACK=0) refuses the flag by name.
test-vstack: $(ARKCC)
	$(PYTHON) tests/run_vstack_tests.py ./$(ARKCC)

# Gate for -fopt-addr: OFF IS OFF (byte-identical without the flag), the fold
# really happens (instruction count down, index forms appear, no foldable pair
# left behind, image never bigger than the no-flag baseline), every rewritten
# operand is a form the assembler accepts, all four arms compute the same
# answer in the emulator, and a cropped build refuses the flag by name.
test-addr: $(ARKCC)
	$(PYTHON) tests/run_addr_tests.py ./$(ARKCC)

# Gate for -fopt-strength: OFF IS OFF (byte-identical without the flag), a
# multiply by a power of two becomes a left shift (instruction count down,
# MUL count down to the few odd constants, the new "LSL r1, r1, #n" index form
# appears, no foldable PUSH #2^k + MUL pair left behind), a multiply by 3 or 5
# keeps its MUL and costs nothing, the image never grows, the flag still pays
# on top of -fopt-vstack -fopt-addr, and all five arms compute the same answer
# in the emulator.  A cropped build (-DARKCC_FEATURE_OPT_STRENGTH=0) refuses
# the flag by name while still compiling the same program without it.
test-strength: $(ARKCC)
	$(PYTHON) tests/run_strength_tests.py ./$(ARKCC)
# Gate for -fopt-cbz: OFF IS OFF (byte-identical without the flag), `CMP rn,
# #0` + `BEQ/CBNZ` collapses into one CBZ/CBNZ only when the flags are provably
# dead, the CMP+branch pairs are consumed, instruction count drops, the image
# never grows, the pass still pays on top of -fopt-vstack -fopt-addr and runs
# after them, an out-of-range body (upper bound > 64 bytes) is left untouched,
# and all five arms compute the same answer in the emulator.  A cropped build
# (-DARKCC_FEATURE_OPT_CBZ=0) refuses the flag by name while still compiling
# the same program without it.
test-cbz: $(ARKCC)
	$(PYTHON) tests/run_cbz_tests.py ./$(ARKCC)
# Gate for -fopt-branch: OFF IS OFF (byte-identical without the flag), a
# branch that fits the 16-bit range becomes 2 bytes while one that does not
# keeps its 4-byte form, instruction count is unchanged (this is a width
# change, not a rewrite), the image never grows, the pass still pays on top
# of -fopt-vstack/-fopt-addr, alignment-sensitive spans are refused, and all
# five arms compute the same answer in the emulator.  A cropped build
# (-DARKCC_FEATURE_OPT_BRANCH=0) refuses the flag by name.
test-branch: $(ARKCC)
	$(PYTHON) tests/run_branch_tests.py ./$(ARKCC)

# Gate for -fopt-imm: a constant operand pushed by IR_PUSH_INT and consumed by
# the next IR_BINARY is folded into the instruction's immediate field, so the
# value never travels through the value stack.  The gate checks OFF IS OFF
# (byte-identical without the flag), that the immediate really appears and the
# `MOV r0, #k` really disappears, that all four arms compute the same answer in
# the emulator, that a constant the encoding cannot carry (AND 0x12345678,
# ADD 70000, MUL 5, DIV 3) falls back byte-identically and never leaves the
# "; imm fold inconsistent" marker, the combination with --reg-top still works,
# and a cropped build (-DARKCC_FEATURE_OPT_IMM=0) refuses the flag by name.
test-imm: $(ARKCC)
	$(PYTHON) tests/run_imm_tests.py ./$(ARKCC)
# Gate for -fopt-peep: register copies that travel through the value stack are
# removed (PUSH {rX} ... POP {rY} -> MOV rY, rX, and a store followed by a
# reload of the same pool slot keeps only the store).  The gate checks OFF IS
# OFF, that the copy pairs really go to zero, that instruction count and image
# size shrink, that all four arms compute the same answer in the emulator, that
# labels are preserved, and that a cropped build (-DARKCC_FEATURE_OPT_PEEP=0)
# refuses the flag by name.
test-peep: $(ARKCC)
	$(PYTHON) tests/run_peep_tests.py ./$(ARKCC)
# Gate for -fopt-cbranch: a comparison whose only consumer is the very next
# conditional jump is branched on directly instead of being materialised as 0/1
# and compared again.  The gate checks OFF IS OFF, that ITE materialisations and
# the redundant "CMP r0, #0" disappear, that instruction count and image size
# shrink while the label set is untouched, that a comparison stored in a
# variable keeps its materialisation, that all four arms compute the expected
# answer in the emulator, that the unsigned and the large-immediate shapes take
# the right path, and that a cropped build (-DARKCC_FEATURE_OPT_CBRANCH=0)
# refuses the flag by name.
test-cbranch: $(ARKCC)
	$(PYTHON) tests/run_cbranch_tests.py ./$(ARKCC)
# Gate for -fopt-copyprop: the IAR "ECT" copy rules reduced to the two that
# are safe without liveness -- a dead register copy inside one straight-line
# block, and a copy forwarded into its only consumer.  The gate checks OFF IS
# OFF, that the four unread barrier arguments vanish while the barriers stay,
# that both pool copies in the fuse fixture fold into their ADD, that a
# control fixture full of *read* copies is left byte-identical (anti-over-
# deletion), that instruction counts and image sizes drop by exactly the
# expected amount, that labels survive, that all three fixtures return the
# Python answer in the emulator, and that a cropped build
# (-DARKCC_FEATURE_OPT_COPYPROP=0) refuses the flag by name.
test-copyprop: $(ARKCC)
	$(PYTHON) tests/run_copyprop_tests.py ./$(ARKCC)

# Gate for the liveness pass: a control-flow graph plus in/out sets per basic
# block, on top of which four rules fire -- dead copies (L1), copies folded into
# a consumer (L2), a staged zero index dropped from an addressing mode (L3), and
# an address materialised straight into its destination (L4).  Each rule owns a
# fixture and must change exactly the lines it claims: instruction deltas, copy
# counts, indexed/plain load counts and label counts are all pinned.  A control
# fixture built around `MOV r0, r5 / LSL r0, r7` -- where the two-operand ALU
# form reads its own destination -- must come out byte-identical, which is the
# anti-over-deletion half.  A cropped build (-DARKCC_FEATURE_OPT_LIVE=0) refuses
# the flag by name (C3900U) and still compiles without it.
test-live: $(ARKCC)
	$(PYTHON) tests/run_live_tests.py ./$(ARKCC)

test-movimm: $(ARKCC)
	$(PYTHON) tests/run_movimm_tests.py ./$(ARKCC)

# Gate for -fopt-coalesce: a `MOV rD, rS` that only exists because a
# two-operand Thumb ALU needs Rd == Rn is deleted once the straight-line run
# after it is renamed onto rS.  The gate pins OFF IS OFF, that the three ALU
# staging copies in a fixture really go (and the result lands in rS), that the
# instruction count never grows, that a two-operand self-source and a staged
# return value are byte-identical, that the emulator returns the Python answer
# in the off / on / on-alone arms, and that a cropped build
# (-DARKCC_FEATURE_OPT_COALESCE=0) refuses the flag by name (C3900U).
test-coalesce: $(ARKCC)
	$(PYTHON) tests/run_coalesce_tests.py ./$(ARKCC)

# Gate for -fopt-pair: two adjacent value-stack pushes and the operator that
# reads them are emitted as two loads straight into r0/r1 instead of a
# PUSH/PUSH/POP/POP round trip.  The gate checks OFF IS OFF, that exactly the
# two staging pairs disappear from a bitwise and, that a folded immediate
# (-fopt-imm) and a comparison feeding a branch (-fopt-cbranch) are left
# byte-identical because those passes are cheaper, that a 64-bit and and a
# volatile read are refused, that the emulator returns the Python answer in
# both arms, and that a cropped build (-DARKCC_FEATURE_OPT_PAIR=0) refuses
# the flag by name (C3900U).
test-pair: $(ARKCC)
	$(PYTHON) tests/run_pair_tests.py ./$(ARKCC)

# Gate for local-slot constant propagation with paired dead-store removal
# (-fopt-prop): that the default build is byte-identical and keeps writing an
# overwritten temp, that the dead store goes while a live one stays, that a
# join point and a taken address end the analysis while a call alone does not,
# that volatile stores are left alone, that `x = 7; y = 1; return x + y;`
# folds with the loads gone, that every fixture returns the Python answer in
# both arms, and that a cropped build (-DARKCC_FEATURE_OPT_PROP=0) refuses the
# flag by name (C3900U).
test-prop: $(ARKCC)
	$(PYTHON) tests/run_prop_tests.py ./$(ARKCC)

# Gate for -fopt-deadpush: a statement assignment stores its value and then
# reloads it for the enclosing expression, which the statement immediately
# pops.  This pass deletes that throw-away push (and the POP after it, or the
# POP chain of a two-word value).  The gate pins OFF IS OFF, that exactly one
# reload goes, that the reload a nested assignment really uses stays, that a
# volatile read stays, that a `long long` statement loses both reloads, that
# every fixture returns the Python answer in both arms, and that a cropped
# build (-DARKCC_FEATURE_OPT_DEADPUSH=0) refuses the flag by name.
test-deadpush: $(ARKCC)
	$(PYTHON) tests/run_deadpush_tests.py ./$(ARKCC)

# Gate for -fopt-cmat: the backend materialises the same constant twice (a copy
# of a known index into the scratch register, then the indexed load) and writes
# the scratch register twice in a row.  The pass cleans that up with three
# rules inside one straight-line block -- a copy of a known 0..255 constant
# becomes an immediate (M1), a known index is folded into the addressing mode
# when the byte offset fits in 0..4095 (M2), and a flag-neutral write that is
# overwritten before any read is dead (M3).  The gate pins OFF IS OFF, each
# rule firing, the instruction/image deltas, that a copy read by STR (a source
# operand) and a MOVW/MOVT pair are left byte-identical, that every fixture
# returns the Python answer in three arms, that labels survive, and that a
# cropped build (-DARKCC_FEATURE_OPT_CMAT=0) refuses the flag by name.
test-cmat: $(ARKCC)
	$(PYTHON) tests/run_cmat_tests.py ./$(ARKCC)

# Gate for -fopt-boolmat: OFF IS OFF (byte-identical without the flag), the
# boolean materialisations and the instruction count both drop (and neither
# drop is zero, so a rule that never fires cannot pass), R2 (`!= 0`) and R3
# (`== 0` whose value is used) each fire, R3 steps aside when -fopt-cbranch can
# fold the branch itself, a re-test of a non-comparison value (`(a&3)!=0`, a
# char, a pointer load, a call result, a long long compare) is left
# byte-identical, five arms agree with a Python computation in unicorn, and a
# cropped build (-DARKCC_FEATURE_OPT_BOOLMAT=0) refuses the flag by name.
test-boolmat: $(ARKCC)
	$(PYTHON) tests/run_boolmat_tests.py ./$(ARKCC)

# Gate for -fopt-slotreg: the pass only ever deletes lines, never inserts, so
# the gate pins that every dropped line is a frame load/store of r0, that the
# output is a subsequence of the input, that the image never grows, that rule
# R1 (redundant reload) and R2 (dead or overwritten store) each fire, that an
# address-escaping frame and a volatile frame stay byte-identical, that a call
# boundary is never crossed, that all three arms agree on the answer in
# unicorn, and that a cropped build (-DARKCC_FEATURE_OPT_SLOTREG=0) refuses the
# flag by name.
test-slotreg: $(ARKCC)
	$(PYTHON) tests/run_slotreg_tests.py ./$(ARKCC)

# Gate for -fopt-voldmb: a volatile access to a frame slot whose address this
# function never takes has no other observer, so the DMB SY pair is pure
# overhead.  The gate pins OFF IS OFF, that the pair goes (and the function is
# exactly one instruction shorter per deleted barrier), that a leaked `&v` puts
# it back byte for byte, that an unrelated address-of does not blind the pass,
# that a function with no volatile access is untouched, that every arm returns
# the Python answer under unicorn, and that a cropped build
# (-DARKCC_FEATURE_OPT_VOLDBM=0) refuses the flag by name.  See docs/VOLDBM.md.
test-voldmb: $(ARKCC)
	$(PYTHON) tests/run_voldmb_tests.py ./$(ARKCC)

# Gate for volmem: the volatile qualifier has to reach every access (global,
# volatile aggregate member, dereferenced pointer), and the DMB SY pair around
# such an access is a separate, off-by-default decision (-fopt-volbar).  The
# gate pins OFF IS OFF, zero barriers by default, that every load and store
# survives (the IR mark), that the flag adds balanced pairs without moving an
# access, that a plain function is byte-identical either way, that all arms
# agree under unicorn, and that a cropped build
# (-DARKCC_FEATURE_OPT_VOLBAR=0) refuses the flag by name.  See docs/VOLMEM.md.
test-volmem: $(ARKCC)
	$(PYTHON) tests/run_volmem_tests.py ./$(ARKCC)

# Gate for -fopt-constcond: a branch whose condition is a literal is decided at
# compile time.  The front end really hands `if (0)`, `while (0)`, `do {} while
# (0)` (the HAL lock macros) and `assert_param` to the emitter as a PUSH_INT
# plus a JZ/JNZ against it; deciding it is bookkeeping, with no guess, and the
# net stack effect of the pair is zero.  The gate pins OFF IS OFF, that the
# false body and the empty-loop back-edge disappear, that the taken body stays,
# that a parameter branch in the same translation unit is byte-identical, that
# every arm returns the Python answer on the emulator, and that a cropped build
# (-DARKCC_FEATURE_OPT_CONSTCOND=0) refuses the flag by name.  See docs/CONSTCOND.md.
test-constcond: $(ARKCC)
	$(PYTHON) tests/run_constcond_tests.py ./$(ARKCC)

# Gate for the operand-allocation family (slice S3a, -fopt-constcache): a
# 32-bit constant rebuilt at every use is built once at the entry into a
# callee-saved register and copied per use.  The gate pins that it is off
# without the flag, that no fixture gains an instruction or a byte, that the
# reuse really happens (fewer pairs, `MOV rD, rC`, one entry materialisation in
# r8-r11), that a use after an un-inlinable call still reads the register, that
# -fopt-regalloc's slots and this pass's registers never overlap, that the
# caller-argument offsets move by exactly one saved block, that all three arms
# return the Python answer on the emulator, and that a cropped build
# (-DARKCC_FEATURE_OPT_CONSTCACHE=0) refuses the flag by name.
test-opalloc: $(ARKCC)
	$(PYTHON) tests/run_operand_alloc_tests.py ./$(ARKCC)

# Gate for -fopt-litpool: a 32-bit constant costs two instructions
# (MOVW+MOVT); loading it from a literal pool costs one load per site plus one
# word per distinct value.  The pool is PC-relative and reaches 4095 bytes, so
# the text is cut into regions at every terminating instruction and the pools
# follow them.  The gate pins OFF IS OFF, that the instruction count falls by
# one per materialisation, that the image shrinks when a value is shared and
# never grows when it is not, that every pool sits after a terminator and every
# site names a defined word, that a function too big for one load gets several
# pools and still assembles (the reach gate), that .arkdata-marked pairs are
# untouched, that every fixture returns the Python answer in three arms, and
# that a cropped build (-DARKCC_FEATURE_OPT_LITPOOL=0) refuses the flag by name.
test-litpool: $(ARKCC)
	$(PYTHON) tests/run_litpool_tests.py ./$(ARKCC)




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

# A too-small buffer must be named, never silently truncated: the ARM emitter
# used to hand the assembler the prefix of a 92 KB program, which came back as
# the board answered 'unknown mnemonic P'.  The sizes are compile-time,
# so the gate builds cropped copies and requires the diagnostic + no output.
test-buffers: $(ARKCC)
	$(PYTHON) tests/run_buffer_tests.py ./$(ARKCC)

# The only gate that *executes* the ARM machine code (unicorn, a QEMU core):
# every other ARM target checks that the assembly looks plausible and that it
# assembles, which is exactly the evidence this project does not accept.  The
# script exits 0 with "skipped" when unicorn is not installed -- the compiler
# itself must never depend on a Python package to build -- so this target is
# safe on a bare machine and load-bearing wherever the dependency is present.
test-arm-exec: $(ARKCC)
	$(PYTHON) tests/arm_exec/run_arm_exec.py --arkcc ./$(ARKCC)

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
test-knr: $(ARKCC)
	$(PYTHON) tests/run_knr_tests.py --arkcc ./$(ARKCC)

# Bit-field read-modify-write: `s.b++` must not move `s.a` (ARM run gate).
test-bitfield: $(ARKCC)
	$(PYTHON) tests/run_bitfield_tests.py --arkcc ./$(ARKCC)

# `double` must really be 64-bit, in storage and in arithmetic.  The suite had
# no case that would notice a double degrading to float precision (plausible
# values, nothing diagnosed), so this gate pins bit patterns and the
# strict-binary64 answers of a few derived expressions.
test-dblprec: $(ARKCC)
	$(PYTHON) tests/run_arm_double_precision_tests.py --arkcc ./$(ARKCC)

# Gate for floating literals: the value in the constant pool must be the
# correctly rounded one, for decimal and hex forms, at binary64 and (with an
# `f` suffix) at binary32.  The old lexer accumulated digits in a double and
# was 1 ulp low on long mantissas; every case here is checked bit for bit
# against an independent exact conversion.
test-floatlit: $(ARKCC)
	$(PYTHON) tests/run_floatlit_tests.py ./$(ARKCC)

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

# ===== STM32 trimmed-profile fit check =====
# `make stm32` cross-compiles the trimmed profile, but it links a bare ELF with
# no memory layout, so it can only say "it compiles".  This target links the
# same source set through a scatter file that encodes the real STM32H743
# memory -- 512 KB AXI with no SDRAM, and the 32 MB SDRAM layout with it -- and
# asserts that the compiler actually fits.  It skips loudly (and exits 0) when
# no armclang/armlink/fromelf is installed.  See docs/BUILD.md.
stm32-check:
	$(PYTHON) tools/stm32_build_check.py --layout both

clean:
	-$(RM) $(ARKCC) arkcc arkcc.exe *.bin *.gen.c
	-$(RM) arkcc_stm32.elf
