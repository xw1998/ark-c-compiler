# Ark C Compiler

[中文](README.md) | English

A multi-target C99 compiler (plus a C11 subset: `_Static_assert` / `_Alignof` / `_Alignas` /
`_Generic` / `_Thread_local` / `_Atomic`, see [below](#c11-keywords-subset)). It builds and runs
with gcc on Windows / Linux / macOS, and it also **self-hosts natively on an STM32 (Cortex-M7)**:
it reads `.c` files from external SPI flash, compiles them in place, **and runs the result on the
same chip** (first end-to-end run 2026-11-05, see [milestones](#milestone-compiling-on-an-stm32-running-on-an-stm32)
and [`examples/stm32_selfhost_build/`](examples/stm32_selfhost_build/)).

It covers 98%+ of the commonly used ARM Compiler 5 (armcc) extensions (only C++ mode and advanced
optimisation are missing). **The STM32H743 + armcc5 toolchain path is complete**: compiling the
arkCC sources with armcc5 produces a flashable `arkcc_stm32.hex/.bin`; after boot the target board
reads `.c` sources from W25Q flash, compiles them in place and executes them.

## armcc5 full-compatibility roadmap

**Goal**: on a machine that has armcc5, arkCC is fully compatible with armcc5 — it can compile an
unmodified MDK project into an executable — and can then run on an STM32, i.e. compile STM32
programs on an STM32.

| Stage | Goal | Status |
| --- | --- | :---: |
| Stage 1 | arkCC itself compiled into STM32 firmware by armcc5 | ✅ done |
| Stage 2 | on-board arkCC compiles `.c` into a `.bin` | ✅ done |
| Stage 3a | on-board artifacts load and run on the board (RAM pool block borrowing, `mini run`) | ✅ done (2026-11-05) |
| Stage 3b | artifacts survive power loss (external QSPI NOR + littlefs) | ✅ done |
| Stage 3c | artifacts written back to **internal flash** and jumped to by the bootloader | ✅ done (2026-11-09, see [docs/STM32_BUILD.md](docs/STM32_BUILD.md) §15) |
| Stage 4 | unmodified MDK projects can be compiled directly by arkCC | ✅ done (`--uvprojx` extracts include paths and defines automatically; divide-by-zero protection in preprocessing) |
| Stage 5 | `__user_initial_stackheap`, HAL redirection, full scatter linking support | ✅ done (`__user_initial_stackheap` + `putchar`/`fputc` UART redirection + malloc/free + scatter-aware vector table generation) |

Build details for each roadmap stage are in [docs/STM32_BUILD.md](docs/STM32_BUILD.en.md) and
[docs/MANUAL.md](docs/MANUAL.en.md). To understand the implementation from scratch (rather than just
use it), read [docs/从零写一个C编译器.md](docs/从零写一个C编译器.md) — a 19-chapter textbook (Chinese
full text; [English summary](docs/from-scratch-c-compiler.en.md)): every
chapter has "goals / prerequisites / body / summary / exercises"; every assembly listing, byte and
size in the book was produced by actually running the thing, and the reproduction commands are in
the afterword.

## Milestone: compiling on an STM32, running on an STM32

The "everything on the board" line has five legs. **On 2026-11-05 it reached the end of legs ③ and
④ for the first time**, and the verdict was not "compilation succeeded" but characters that a
program running on the board printed over the serial port by itself.

| # | Milestone | Status | Board reading |
| --- | --- | :---: | --- |
| ① | arkcc itself built into STM32 firmware and running | ✅ | see [docs/STM32_BUILD.md](docs/STM32_BUILD.md) |
| ② | on the board, turn one `.c` into machine code (`.bin`) | ✅ | `cc hello.c` |
| ③ | **several `.c` → one loadable image → execute on the board** | ✅ 2026-11-05 | `make` emits `app.svcm` of 4776 B; `mini run` prints `ARKMAKE: link ok` / `ARKMAKE: cross-file add3=6` |
| ④ | artifacts survive power loss (external QSPI NOR + littlefs) | ✅ | artifacts live in `/mnt/nor`, still there after reset, and can be `mini run` directly |
| ⑤ | artifacts written back to **internal flash** and jumped to by the bootloader | ✅ 2026-11-09 | `app flash write /tmp/m5.bin` → 1452 B / crc `0x612B4A1E` lands at `0x081E0000` and reads back byte-for-byte; `app flash run` prints `M5 alive in flash`, log entry `0x081E0424` is inside the flash region; **after a reset** `/tmp` is empty and the same artifact still runs (the "survives power loss" verdict) |

Leg ③ deserves its own section because it rules out three classes of failure that **look like
success**:

- **a translation unit silently dropped at link time** — the image still links, it is just missing
  that TU. The verdict is that the cross-TU call really returns a value (`add3(1,2,3)==6`), not
  "it compiled".
- **the object being moved by the linker** — arkcc bakes absolute addresses into instructions at
  codegen time (`movw/movt` pairs, literal slots), and only external symbols are relocations. The
  old recipe "reserve a 0x400 vector table up front, then shift the whole image right" measured
  out as string pointers being 0x400 too low: **the image loads, prints nothing, and exits
  immediately**. Now the first object reserves a hole, `-link` only fills the table, and nothing is
  ever shifted.
- **the premise of the four-pass diff not holding** — if the linked result depends on the base
  address, then the byte differences between the four images are not "displacement caused by
  addresses" and the diff table would fold optimisation differences away as addresses. The verdict
  is that the four passes are byte-identical in size (all four rows `A/B/C/D` equal).

The minimal reproducible example is in
[`examples/stm32_selfhost_build/`](examples/stm32_selfhost_build/): two sources + one project
description + one `make` + one `mini run`, with five verdicts and "known limits" (4-source ceiling,
pool budget, unstable timing). The project-description layer comes from
[`ark_make`](https://gitee.com/xw19981010/ark_make), and `make`'s packing callback *is* `cc --pack`
— an image is only allowed one way of being produced, otherwise "what was verified on the board"
and "what make emits" will diverge sooner or later.

## Features (v0.8.3)

### C99 language features

| Area | Support | Notes |
| --- | :---: | --- |
| Basic types | yes | `void/char/short/int/long/long long/_Bool/float/double` + `signed/unsigned` |
| Pointers and arrays | yes | 1-D / multi-D arrays, pointers, function pointers, array decay; array dimensions accept constant expressions `int arr[SIZE+2]` |
| Variable-length arrays (VLA) | yes | `int a[n]` runtime-sized arrays, allocated on the stack via `IR_ALLOCA`; rounded up: 8 on ARM / x86_64, 16 on RV32I (the psABI requires 16-byte sp alignment before every call), and the RV32I epilogue rebuilds sp with `sub sp, s0, frame` before popping the frame whenever the function contains `IR_ALLOCA` — otherwise `return` reads `ra/s0` from the wrong place |
| Composite types | yes | `struct`/`union`/`enum`/`typedef`, bit-fields (really packed bit by bit), flexible array members `data[]`, anonymous struct/union field promotion |
| Complex types | yes | `_Complex double` / `_Complex float`: arithmetic, arguments, return values, implicit conversions and static initialisers all work; a 16-byte `_Complex double` return uses r0-r3 on ARM and a0-a3 on RV32I (soft-float AAPCS, **not sret**, interoperable with gcc callees); the x86 backends reject it explicitly, and passing it through `...` is rejected explicitly too. Details in `docs/MANUAL.md` §4.10 |
| Wide characters | yes | `wchar_t` + `L"..."` wide strings + `L'...'` wide character literals; width switched by `--wchar16`/`--wchar32` |
| Trigraphs | yes | all 9 C99 trigraphs (`??=`->`#`, `??(`->`[`, `??/`->`\`, `??)`->`]`, `??'`->`^`, `??<`->`{`, `??>`->`}`, `??!`->`|`, `??-`->`~`) |
| Qualifiers | yes | `const/volatile/restrict/inline` |
| Storage classes | yes | `static/extern/auto/register`; `static` at block scope persists; `__thread` (armcc) / `_Thread_local` (C11) thread-local storage |
| Control flow | yes | `if/else/while/for/do-while/switch/case/default/break/continue/goto/label/return` |
| Operators | yes | all C99 operators (arithmetic / comparison / short-circuit logic / bitwise / shifts / compound assignment / conditional / comma / sizeof / casts) |
| Functions | yes | many parameters (>4 go on the stack; scalar, 64-bit and struct parameters are assigned per AAPCS32: even register pairs, 8-byte alignment on the stack, numbering by the number of words actually transferred), prototype checking, variadic `...` (supported by all four backends; ARM / RV32I use 4-byte word slots, C / x86_64 use 8-byte slots — see §Backends and `examples/run_va_gate.py`), recursion, separate compilation + linking of multiple files |
| Literals | yes | integers (decimal/octal/hex + suffixes), characters + escapes, string concatenation, floating point |
| Floating point | yes | `float/double` arithmetic / comparison / conversion; the ARM backend supports a hardware FPU (VFP `VADD/VMUL/VCVT/VCMP`) or `__aeabi_f*`/`__aeabi_d*` soft-float stubs, and `double` is true 64-bit precision |
| 64-bit integers | yes | the full `long long` set: arithmetic / comparison / bitwise / unary minus / `++` / `--` / compound assignment / shifts (`__aeabi_l*` + `__aeabi_llsl/llsr/lasr` stubs); shifts and bitwise ops take the **left** operand width per C99 6.5.7; `printf` arguments are not truncated; stack 64-bit arguments are low word first, 8-byte aligned, per AAPCS |
| Division/modulo | yes | signed/unsigned `__aeabi_idiv/uidiv/idivmod/uidivmod` |
| Implicit conversions | yes | the full usual arithmetic conversions + integer promotions |
| Initialisation | yes | scalars, aggregates `{1,2,3}`, nested `{{1,2},{3,4}}`, designated initialisers `.x=1/[2]=5`, strings `char s[]="hi"`, non-literal global initialisers (constant-expression folding) |
| Compound literals | yes | `(int[]){1,2,3}` / `(struct P){.x=1,.y=2}` |
| Structs by value | yes | implemented with a hidden pointer parameter |
| Register allocation | optional | `-fopt-regalloc` (`ARKCC_FEATURE_OPT_REGALLOC`, host/cross 1, on-board 0, off by default): a post-emission text pass moves the hottest frame slots into `r8-r11`, and only slots where "every mention is `LDR r0,[r6,#n]` / `STR r0,[r6,#n]`" are moved; taking an address, `volatile`, and 8/16/64-bit accesses all stay in memory. On the hot case (`char pad[200]` pushes later locals past offset 124) `[r6,#]` references drop 22→13, and two negative cases stay byte-identical. Two cost models: the default only moves far slots and a **function never grows** (25 `.c` files of the H743 self-host project: −2398 B, −0.21%, no file grows); `-fopt-regalloc-near` / `--fregalloc-near` (implicitly enabling the base tier) also moves near slots, cutting stack accesses from 27 372 to 15 108 at the cost of 150 extra bytes and 14 files growing; **frame geometry**: the save block is the anchor — when it widens, the `[r6, #N]` immediates (N ≥ local area upper bound) and the `MOVW/ADD r6` immediates must shift together, and the save block must stay a multiple of 8 (an odd count automatically gets a spare `r8-r11`, at zero byte cost), otherwise a variadic function's `r0-r3` mirror and the caller's stack arguments all shift. Five tiers (default / `-O2` / regalloc / `-O2+regalloc` / `-O2+regtop+inline+regalloc`) run in one go via `examples/run_va_gate.py --opt-suite` |
| Value stack to registers | optional | `-fopt-vstack` (`ARKCC_FEATURE_OPT_VSTACK`, host 1, on-board 0, off by default): the `PUSH {r0}` / `POP {r0}` pairs of expression evaluation stay in `r5`/`r7` (already saved by the prologue, so the frame is unchanged), using destination retargeting plus textual substitution of read-only operands; slots are reference counted, read+write in one operand, read in one and written in another, and the in-place `ADC/SBC/MUL` forms are materialised first, `MOVW/MOVT` is never retargeted, and anything unrecognised leaves the whole function untouched. a boundary (label/branch/call) no longer bails the function when every live value is already back in the machine stack (`cross` pre-scan plus a verbatim tail); otherwise the whole function is still left untouched; `verbf` now only becomes permanent when the tail cannot be modelled (at a label, and after an epilogue that really leaves the function, the shadow stack is reset and optimisation continues). The pool has two slots; `r4` joins as a third one only when three values are alive at once (the frame then grows by the same word so 8-byte alignment holds, and a function that never goes deeper than two is left alone, because an extra saved register for nothing is a loss). A function with no parameters and no locals has no frame at all (the prologue contains no `SUB sp`), so it takes a second path: five-register `PUSH`/`POP` plus one `SUB sp, sp, #4` emitted after `MOV r6, sp` (the epilogue's `MOV sp, r6` discards that padding, so there is no `ADD`, and the `SUB` must not go before the `MOV`). Whole STM32F4 HAL corpus (Cortex-M4, `-O2`) 47,449 -> 33,284 instructions (-29.85%, third slot, per-block resume and a 256-deep shadow stack included), 31,218 with `-fopt-addr`; arith fixture 170 -> 120 instructions; the image never grows; the whole `tests/arm_exec` corpus passes 39/39. See `docs/RA_VSTACK.md` |
| Addressing-mode folding | optional | `-fopt-addr` (`ARKCC_FEATURE_OPT_ADDR`, host 1, on-board 0, off by default): folds an address computed by `ADD` / `MOV` into the `LDR/STR` addressing mode (constant offset or register index) and drops the redundant address arithmetic; a dead-value analysis guarantees the folded register is not read again within the function, barrier instructions `DMB/DSB/ISB` are let through, and the two write-back forms are not implemented because this generator never emits them. Whole HAL corpus (STM32F401xE, `-O2` cumulative, see `docs/COMPARISON.md` section 5; measured on the 36,101-instruction post-vstack baseline with the r4 third slot, crossing continuation, per-block resume and a 256-deep shadow stack) 36,101 -> 33,957 instructions (-2,144 / -5.94%), register-index residue 1,084 -> 0. The same switch also runs a **second time**, after regalloc / vreg / slotreg / cmat: the `MOV rX, r0` copies those passes create are invisible to the first fold, and on the nineteen-switch total that is 12,795 -> 12,346 (-449 / -720 B = -3.51% / -2.15%). A third round (2026-11-25): R1b looks ahead -- after `ADD RB, RS, #imm`, the first access within four instructions whose base is RB and which has no index gets `#imm` folded into it -- and R0 merges `MOV RD, RS` with the `ADD\|SUB RD, RD, #imm` right behind it. On 26 flags the corpus goes 11,766 -> 11,666 instructions / 398,673 -> 396,986 B (-100 / -1,687), both residual shapes drop to zero, and only 100 of the 189 candidates are paid: the rest end a block, where the death of the address register cannot be proved from the text. See `docs/ADDR_FOLD.md` section 13 |
| Strength reduction | optional | `-fopt-strength` (`ARKCC_FEATURE_OPT_STRENGTH`, host 1, on-board 0, off by default): turns a multiply by a power of two into a left shift, with two landing points behind one switch -- the IR peephole rewrites an adjacent `PUSH k` + `MUL` (k a power of two) into `PUSH log2(k)` + `SHL` (both deleted when k==1), and the backend rewrites the `IR_LOAD_IDX` element-size scale from `MOV r2,#es` + `MUL` into one `LSL` (source-level constant multiplies live in the IR, index scaling is generated after it, and neither can see the other). Powers of two only: `MUL` is one cycle on Cortex-M4, so `x*3` keeps its `MUL` and the gate asserts it. The stage row must sit after `ir.xblock`, otherwise deleting `x*1` changes the inlining decision and enabling the pass makes the output bigger (+42 B measured). HAL corpus (cumulative over `-O2`) `MUL` 1,105 -> 12 (the rest are all value x value); on top of the 35,577 of `-fopt-vstack -fopt-addr` -> 33,485 (-2,092 / -6.16%); the same switch's second half then merges the adjacent `LSL` into the addressing mode as `[Rn, Rm, LSL #n]` (each merge trades two 16-bit instructions for one 32-bit one, so the object bytes barely move). See `docs/STRENGTH.en.md` |
| Zero-compare branch folding | optional | `-fopt-cbz` (`ARKCC_FEATURE_OPT_CBZ`, host 1, on-board 0, off by default): a `CMP r0-r7, #0` immediately followed by `BEQ/BNE` becomes one `CBZ/CBNZ` -- one instruction and four bytes less. Four necessary conditions: adjacency (metadata lines only in between), operands exactly `r0-r7` and `#0` with a local target, a forward target whose region upper bound is at most 64 bytes, and dead flags (no flag reader before a flag writer, a return, or the end of the function; an unconditional `B` is followed). The text layer cannot see real widths, so every instruction is estimated at 4 bytes: the bound can only lose folds, never emit an out-of-range branch, and a data directive in the region drops the candidate. HAL corpus (cumulative over `-O2`) 31,421 -> 30,977 instructions (-444), code bytes 78,262 -> 76,486 (-1,776 B); the bytes vary with the widths of the deleted pair (2 to 6 bytes saved per fusion). A second sweep reuses the same flag and the same rule, running after the second liveness/peep/addr sweeps and before frame trimming, so it also fuses the pairs that `cmat`/`slotreg`/`litpool`/`regalloc`/`vreg` newly create: the 19-switch set plus `frame`/`voldmb`/`constcond` reads 12,266 -> 12,215 instructions (-51, -0.42%) and 405,514 -> 404,970 B (-544 B, -0.13%), with adjacent `CMP #0` + conditional branch pairs falling from 146 to 95 (both readings come from the same binary: the second-sweep call was commented out and the compiler rebuilt). See `docs/CBZ_FOLD.en.md` |
| Short-branch shrinking | optional | `-fopt-branch` (`ARKCC_FEATURE_OPT_BRANCH`, host 1, on-board 0, off by default): inside the assembler the whole file is first measured with every branch at four bytes, recording each `B`/`B<cond>`'s `pc`, condition and target name plus the position of every `.align`; `off = target - (pc+4)`, `-256..254` for a conditional (T1 imm8) and `-2048..2046` for an unconditional branch (T2 imm11), odd offsets rejected, a forward target reduced by another 2 as an upper bound, and **any span crossing `.align` refused** (non-linear padding would oscillate). When any decision changes, pass 1 runs again at the real 2/4-byte widths so alignment padding is exact; pass 2 then emits the two-byte form by ordinal and falls back to 32 bits if the condition or target name does not match, and the offset is re-checked before encoding (a hard error, never a truncated branch). `near` fixture 1,386 -> 1,368 B (-18, count stays 160), 1,294 -> 1,276 B on top of `-fopt-vstack -fopt-addr`; HAL corpus (cumulative over `-O2`) the instruction count does not move (only the encoding width does) while code bytes go 76,486 -> 73,906 (-2,580 B / -3.37%), and shrinking never adds a byte (the symbol table is unchanged, so every saved byte is code). See `docs/BRANCH_SHRINK.en.md` |
| Constant to immediate | optional | `-fopt-imm` (`ARKCC_FEATURE_OPT_IMM`, host 1, on-board 0, off by default): at emission time a `PUSH k` immediately followed by an arithmetic or comparison op is folded into the instruction's immediate field, so the constant never travels through the value stack. Each operator passes an encoding gate first: `+`/`-` within +-4095 (ADDW/SUBW), `&\|^` and a `CMP` above 255 must pass `thumb_imm12_a`, shifts 0..31, comparisons right-constant only; anything that does not fit keeps its original shape. The decision and the emission are the same `emit_binary_imm()`, so "swallowed the push but cannot emit the immediate" is structurally impossible; it is mutually exclusive with `--reg-top`. HAL corpus (cumulative over `-O2`) 31,421 -> 25,663 instructions (-5,758 / -18.33%), code bytes 73,906 -> 62,890 (-11,016 / -14.91%). See `docs/IMM_FOLD.en.md` |
| Stack round-trip cleanup | optional | `-fopt-peep` (`ARKCC_FEATURE_OPT_PEEP`, host 1, on-board 0, off by default): a text pass removes two kinds of detour through memory -- a `PUSH {rX}` immediately followed by `POP {rY}` becomes one `MOV` (both lines go when it is the same register), and a `STR rX, [r6, #o]` followed by an `LDR` of the same slot keeps only the `STR`. Nothing is paired across a label, multi-register frame `PUSH`es never match, and `DMB SY` naturally stops volatile; rule R5 rewrites `ADD rD, rS, #0` -- which with `D != S` can only be a 32-bit `ADDW` -- into a 2-byte `MOV` (neither side writes the flags, so no liveness is needed), and because downstream `-fopt-live`/`-fopt-coalesce` only understand `MOV` they take over automatically. The pass runs twice: once after `-fopt-cbz`, once after the second liveness run (the dead pairs are created by the later renames; worth -52 instructions / -108 B). On top of `-fopt-imm`: 25,663 -> 25,033 (-630 / -2.45%) and 62,890 -> 61,628 bytes (-1,262 / -2.01%); R5 plus the second peephole run take the nineteen-switch total from 13,116 to 12,795 (-321 / -736 B); rule R6 then catches `PUSH {rX}` ... `POP {rY}` where `rY` is never mentioned in between (that is a `MOV` through memory -- the copy moves up to the `PUSH` and the pair goes away), and `ip` joins the single-register `PUSH`/`POP` recogniser, 12,346 -> 12,304 (-42 / -54 B). See `docs/PEEPHOLE.en.md` and `docs/VREG.md` sections 17 and 18 |
| Branch on a comparison | optional | `-fopt-cbranch` (`ARKCC_FEATURE_OPT_CBRANCH`, host 1, on-board 0, off by default): at IR emission, when the instruction after `IR_BINARY(comparison)` is exactly `IR_JZ` / `IR_JNZ`, emit `CMP` + `B<cond>` instead of materialising the comparison as 0/1 and testing it again with `CMP r0, #0`. Signed and unsigned have their own condition sets (`BLT/BGE` vs `BLO/BHS`), and the negation of `<=`/`>=` is `BGT`/`BLT` rather than `>`/`>=`; the immediate path carries a `MOV r1,#k` + `CMP r0,r1` fallback. It is exclusive with `--reg-top` and stacks with `-fopt-cbz` (which then folds `CMP r0,#0` + `BNE` into `CBNZ`). A comparison whose result has a second consumer (`int x = (a<b); if (x)`) is never folded. On top of `-fopt-imm -fopt-peep`: 25,033 -> 22,438 (-2,595 / -10.37%) and 61,628 -> 53,404 bytes (-8,224 / -13.34%). See `docs/CBRANCH.en.md` |
| Register copy cleanup | optional | `-fopt-copyprop` (`ARKCC_FEATURE_OPT_COPYPROP`, host 1, on-board 0, off by default): the two **text-level** rules reduced from IAR's `ECT CopyPropagation candidate` / `DefIntoMove` / `Dead MOV`, neither of which needs liveness analysis. A dead copy: a `MOV rD, rS` or `MOV rD, #imm` whose destination is completely overwritten before anything reads it, inside one straight-line block, is deleted (`MOV` writes no flags, so neither values nor flags change); the block ends at a label, any branch, `PUSH/POP/LDM/STM`, the `IT` family, `CPS/BKPT`, or the end of the function. B forwarding: `MOV rD, rS` followed by `OP rD, rD, X` becomes `OP rD, rS, X` (`rD != rS`, `X != rD`, `OP` limited to three-operand ALU ops, **`CMP/CMN/TST` excluded**). The read test must be "the first operand is a read too unless it is a write-only destination", or a `MOV` followed by `STR`/`CMP` gets deleted (the emulator caught 9 wrong answers). Baseline 22,438 -> 21,915 (-523 / -2.33%) and 53,404 -> 52,358 bytes (-1,046 / -1.96%); everything saved is a `MOV`, every other mnemonic is unchanged. See `docs/COPYPROP.en.md` |
| Liveness-driven cleanup | optional | `-fopt-live` (`ARKCC_FEATURE_OPT_LIVE`, host 1, on-board 0, off by default; ~1.5 MB of static tables so it is cropped out of the MCU profile): the first pass that looks **across basic blocks** -- per function it builds a control-flow graph, iterates register liveness (`out = union succ.in`, `in = use | (out - def)`) to a fixed point, and applies four rules. **L1** `MOV rD, rS|#imm` with `rD` not live afterwards -> delete (this is what removes staging that crosses a label or a branch). **L2** `MOV rD, rS` followed within a window (`LV_WINDOW` = 4) by the instruction that reads `rD`, does not write it and after which `rD` is not live -> the consumer reads `rS` and the copy goes (no three-operand ALU needed and no adjacency required; `LDR rD,[rD,...]`, `CMP`, `STR` all qualify; a write to `rD`/`rS` in the window or a block boundary abandons the site). **L3** `MOV rT, #0` followed by an instruction that uses `rT` only as an address index -> drop the index, `[rB, rT, LSL #n]` becomes `[rB]`. **L4** `MOVW/MOVT rD` + `MOV rX, rD` -> materialise the constant straight into `rX` (IAR's `DefIntoMove`); the single-line `MOVW`/`MVN` + `MOV` case folds too (`MOV rD,#imm` does not: replacing a 16-bit `MOVS` with `MOVW` grows the line and drops the flag write). The refusal list: `BL/BLX` read `r0-r3`, a block with no successor returns `r0-r3`, `CBZ/CBNZ` read their first operand, nothing inside an `IT` block is rewritten, `r6`/`sp`/`lr`/`pc` are never a target, the first operand of a two-operand ALU form **is also a read** (missing that deleted 376 live values -- caught by the emulator), and `ADC/SBC/RSC` consumers are never retargeted (the 16-bit encoding requires `Rd == Rn`; the three-register form is not emitted by this assembler). Nine-switch baseline 21,915 -> **19,112 (-2,803 / -12.79%)** and 52,358 -> **45,760 bytes (-12.60%)**; all 681 `MOVW/MOVT/MOV` triples and all 21 `MOVW`/`MVN` + `MOV` pairs in the baseline are hit (2 triples and 1 pair survive because `rD` is still live after the consumer). Also fixes a later real defect: a directive inside a block's line range read the **previous function's stale parse at the same line index** (`iv[]` is only written for real instructions), so `MOV r5, r0` was deleted as a dead copy and `STR r5` read an uninitialised register -- 4 sites in the real corpus (`stm32f4xx_ll_utils.c`, `stm32f4xx_hal.c` twice, `stm32f4xx_hal_cortex.c`); after the fix the nine-switch count goes 19,100 -> **19,105** with 86/95 TUs byte-identical, gate case 7b. **the same switch runs a second time after litpool** (the second run sees the pooled text -- `MOVW`/`MOVT` are now `LDR`): nineteen switches 13,566 -> **13,116 instructions (-450 / -3.32%)**, 34,980 -> **34,200 bytes (-2.23%)**, no TU of the 95 grows; the saving lands only in `MOV` immediate (-290) and `MOV rD,rS` (-160), the other sixteen columns are unchanged. It also flushed out and fixed a real defect in the built-in assembler (`ADDS`/`SUBS` masked high registers with `&7`, quietly computing the wrong value and shifting every following label), and added a **two-pass size self-check** (a hard error; the compile-time probe `ARKCC_ASM_SIZECHECK_PROBE` can make it fail on demand). See section 16 of `docs/VREG.md` |
| Pairing value-stack operands | optional | `-fopt-pair` (`ARKCC_FEATURE_OPT_PAIR`, host 1, on-board 0, off by default): the IR is a stack machine, so two adjacent value-stack pushes plus the binary operator that reads them become "left to r0, right to r1, compute directly"; both `PUSH/POP` pairs and the register shuffling around them disappear. Operands accepted: a stack slot (slot < 8, not volatile), an immediate, a local address, a non-va global address or global scalar (under 8 bytes, loaded by width with `LDR/LDRB/LDRH/LDRSB/LDRSH`). 64-bit values, volatile objects and anything over 8 bytes are left alone. `-fopt-imm` (constant folded into the immediate field) and `-fopt-cbranch` (comparison branched on directly) are both cheaper, so the pair pass stands down for them -- each of those two stand-down rules was paid for by a measured regression (+1,405 and +67 instructions). Over the 95-TU HAL corpus: 19,112 -> 19,096 instructions (-16, 0.08%), no unit larger. See P12 in `docs/OPTIMIZER_PLAN.en.md` (S2-S5 are the later stages) |
| Local-slot constant propagation and dead-store elimination | optional | `-fopt-prop` (`ARKCC_FEATURE_OPT_PROP`, host 1, on-board 0, off by default): two halves of the IR pass share one byte map -- **forward** rewrites a frame slot whose constant was written once and never changed (sign/zero-extended by width) into `PUSH_INT`, **backward** turns a store whose bytes are all dead, together with its droppable producer, into `NOP`. Two size gates, each paid for by a regression: a constant must fit one ARM instruction (otherwise an `LDR` becomes `MOVW+MOVT`, which cost +16 instructions in the first version), and a read that immediately follows a `STORE` covering the same slot is left alone (the value is still in the top register and `-fopt-imm` already folds it for free; rewriting it cost +6). Since `IR_PUSH_ADDR` is the only way to obtain a frame address, a function without it cannot have its frame touched by a callee, pointer write or memcpy, so liveness can be relaxed (-6 -> -29). On top of the ten switches: 19,112 -> 19,083 instructions (-29, 0.15%), `STR -15`, `MOV -14`, no unit larger; instrumentation shows forward propagation replaces nothing on the HAL, so all the value is DSE -- the text-level budget really is exhausted, and the next step has to be IR-level register allocation. See P13 in `docs/OPTIMIZER_PLAN.en.md` |
| Read-back of a statement assignment | optional | `-fopt-deadpush` (`ARKCC_FEATURE_OPT_DEADPUSH`, host 1, on-board 0, off by default): a statement-level assignment to a local emits a `STORE` followed by a read-back push, which the immediately following discard `POP` makes pointless -- a push (one word, or two for `long long`) followed by adjacent pops becomes `NOP`. Volatile reads (observation semantics), four-word complex objects and width mismatches are left alone, and no liveness analysis is done. On top of `-fopt-prop`: 19,083 -> 19,066 (-17, 0.09%), `LDR -14`, `MOV -1`, no unit larger. See P14 in `docs/OPTIMIZER_PLAN.en.md` |
| Constant and dead-copy deletion | optional | `-fopt-cmat` (`ARKCC_FEATURE_OPT_CMAT`, host 1, on-board 0, off by default): the value-stack backend materialises the same constant twice (a copy into a scratch register, then the consumer folds it back into the addressing mode), often writes the scratch register twice in a row, and leaves constants and copies behind that nothing reads anywhere in the function. Nine rules (M1-M7 are text-level; M8/M9 walk the control-flow graph): **M1** `MOV rD, rS` where `rS` is a known 0..255 constant becomes `MOV rD, #k`; **M2** a known index is folded into the addressing mode (`k<<s <= 4095`, same address, same flags); **M3** a flag-neutral write overwritten later in the same block before any read is dropped; **M4** a constant through a three-operand shift; **M5** a constant through an extend; **M6** a conditional branch after a known `CMP` is decided on the spot (the `CMP` itself stays, which is why M6 needs no liveness argument); **M7** a `PUSH {rX}` / `POP {rX}` round trip of the value stack goes, together with the already-dead units between them; **M8** the first rule that needs liveness -- units are cut into blocks along the control flow, a successor plus a use/def graph is iterated to a fixed point, and `MOV rD, #imm` / `MOV rD, rS` that are dead across the whole function are deleted (only those two flag-neutral shapes; `MOVW`/`MOVT` is out of scope and anything covered by `IT` is never touched); **M9** the `PUSH {rX}`/`POP {rX}` round trip at a join goes -- label chains are folded first, and every predecessor of the pop must end with a `PUSH` of the same register before the pair is deleted (a `TBB`/`TBH` or a `BX` not targeting `lr` makes the whole function abstain). Blocks end at labels, any branch, `IT`, `POP/LDM/STM` and **any mnemonic not on the whitelist**; a `MOVW`+`MOVT` pair is always handled as a unit. The read set cost two fatal miscompiles (`MUL r0, r7` reads its own destination, and the first operand of `STR` is a source), each pinned by a regression fixture. On the sixteen-switch baseline: 15,933 -> **14,131 instructions (-1,802 / -11.31%)**, and the `ARKOBJ2` header measures 40,188 -> **36,126 B** of code. A `difflib` diff of the 95 TUs reports M8 deleting 571 lines and M9 another 238, with **0 lines added** in both rounds, and every deleted line is one of those two `MOV` shapes or a `PUSH {r0}`/`POP {r0}`. See `docs/CMAT.en.md` |
| Slot-level register promotion | optional | `-fopt-slotreg` (`ARKCC_FEATURE_OPT_SLOTREG`, host 1, on-board 0, off by default): **deletes lines from the emitted text, never inserts** -- a repeated reload where `r0` already holds the slot (**R1**), and a dead store that is never observed (**R2(a)**: zero reads in the whole function and no address escape; **R2(b)**: overwritten later in the same block). No register is introduced and the frame layout is untouched, so "only ever smaller" is a structural guarantee; every slot above an address escape point (`ADD rX, r6, #off`) is barred from dead-store deletion, and `volatile`, `[r6,rX]` indexed, write-back, non-decimal offsets and frameless functions make the whole function abstain. Baseline (twelve switches + `-fopt-cmat`): 18,729 -> **18,665 (-64, -0.34%)**, `LDR -35`, `STR -29`, none of the 95 TUs grew and 85 are byte-identical. By the pre-registered falsifier (a drop below 0.5% archives the line) **the line is archived**, with the code left behind a default-off flag. See `docs/SLOTREG.en.md` |
| Function-level constant cache | optional | `-fopt-constcache` (`ARKCC_FEATURE_OPT_CONSTCACHE`, host 1, on-board 0, off by default): when one 32-bit constant is materialised **>= 5 times** in a function, build it once at the entry with `MOVW`+`MOVT` into a callee-saved register (`r8`-`r11`) and turn the remaining uses into `MOV rD, rC`. It is the **second client** of `-fopt-regalloc` and shares the same saved-register block: `extra` is computed once, offsets are shifted once and `PUSH`/`POP` are widened once. Registers come from the high registers `ra_` did not take and that the function's own text never mentions; a link-time relocated pair after `.arkdata` is never cached; a function whose prologue was rewritten into vstack's r4 shape abstains as a whole (it carries a pad word that widening would misalign). Baseline (twelve switches + `-fopt-cmat` + `-fopt-slotreg`): 18,665 -> **18,506 (-159, -0.85%)**, none of the 95 TUs grew, 92 are byte-identical and `arm_exec` reports 0 failure. See `docs/OPERAND_ALLOC.md` section 8 |
| 32-bit constants in a literal pool | optional | `-fopt-litpool` (`ARKCC_FEATURE_OPT_LITPOOL`, host 1, on-board 0, off by default): replace a 32-bit constant's `MOVW`+`MOVT` (two instructions, 8 bytes) with one `LDR rD, <label>` (4 bytes) out of a PC-relative literal pool, saving `4(c-1)` bytes and `c-1` instructions (`c` is the use count; at `c=1` it is byte-neutral and only saves an instruction). That needs a **new assembler form** `LDR rd, <label>` with a fixed 32-bit encoding (`LDR Rt,[PC,#imm12]`, `imm12` a byte offset in 0..4095); **out of reach or a foreign label is a hard error**, with two `NOP`s filling the four bytes in place -- never a silent truncation. The text is **cut into regions at every instruction that ends the control flow** (`POP {.., pc}` / `BX` / unconditional `B`, and only the unconditional forms -- `POPNE` comes back), adjacent regions are merged forward up to `LP_REACH_INS = 800` instructions, and **each group gets one pool** right after its terminator, preceded by `.align 4` (a pool is data, control has already left, all branches target labels and all labels follow the pool). One pool per function does not work: `LDR [pc,#imm]` reaches only 4,095 bytes, and two large functions alone hold 225 of the 711 convertible pairs. Refused: a `MOVW`/`MOVT` whose previous line is `.arkdata`/`.arkdatasym` (the linker patches both halfwords, so the pair must stay a pair), a single region over 800 instructions, more than 128 distinct constants in one pool, a function over 4,096 lines, and a function whose last instruction is not a terminator. **The static tables cost about 108 KB, so the on-board profile (`ARKCC_PROFILE_STM32_MIN`) crops it by default**; a cropped build refuses the flag with `C3900U`. 95-TU HAL corpus: eighteen switches **14,271 -> nineteen 13,566 instructions (-705)**, 36,114 -> **34,980 B (-1,134)**; of the 807 adjacent `MOVW`/`MOVT` pairs, 96 carry `.arkdata`, 0 are not real pairs, 711 are poolable and **705 actually convert** (the other 6 sit in refused long regions / large functions, which is exactly the instruction difference), and the byte bill `-2,820 + 1,436 + 250 = -1,134` also reconciles exactly (705 sites save 4 each / 359 pools cost 4 each / `.align 4` pads 250 in total); `HAL_RCC_OscConfig()` 1,256 -> 1,229. Execution-level `arm_exec --extra=-fopt-litpool` reports **0 failure**; the 21 gates are in `docs/LITPOOL.en.md` |
| Local copy coalescing | optional | `-fopt-coalesce` (`ARKCC_FEATURE_OPT_COALESCE`, host 1, on-board 0, off by default): the fifth rule (`L5`) of `-fopt-live`, riding on the same `lv_pass()` -- after a `MOV rD, rS` (`r0-r7`, `d != s`, neither is `r6`), rename every `rD` in the following straight-line code to `rS` and delete the copy, and **no instruction gets wider**. Stops: a label, a block boundary / conditional branch, an `IT` block, `!` writeback, a register list `{...}`, and **`BL`/`BLX`** (they implicitly read and write `r0-r3`, invisible in the text). Three decisions inside: a write to `rS` ends the stretch (abandon if the same line also reads `rD`); a write to `rD` means the value has been carried into `rS` (any later read of `rS` abandons); a plain read of `rD` is the rename target. At the end `rD` must be dead, and `rS` too if `rD` was redefined inside. Every rewritten line is replayed through `lv_same` first, in two passes (verify, then rewrite). Two real defects were caught by the gates and the emulator: handling only "dead right after its last use" almost never fires (the real shape redefines `rD` inside the stretch; 1 instruction lost over 95 TUs), and `BL`'s implicit reads/writes silently ate call arguments (returned 5 instead of 9). Full HAL corpus: 18,509 -> **18,151 (-358 / -1.93%)**; of the 95 TUs 81 are byte-identical, 14 shrink and **none grows**; without the flag everything is byte-identical. See `docs/COALESCE.en.md` |
| Slot promotion to registers | optional | `-fopt-vreg` (`ARKCC_FEATURE_VREG`, host 1, on-board 0, off by default): runs after `-fopt-regalloc` and promotes a frame slot wholly mentioned as `LDR rD,[r6,#n]` / `STR rS,[r6,#n]` into `r8-r11` -- a store becomes `MOV rC, rS` (the same one instruction), the load feeding a consumer is deleted outright, and every line in **the rest of the basic block** that reads that register reads the cache register instead. The region ends at exactly four things: a barrier line (label / branch / `BL` / PUSH/POP), the frame-setup line, another frame load that writes the same destination, and a write-only use of the register (a read-modify-write is renamed and kept so the cache register carries the updated value down the same path; another slot's access and a store sourced from the register are merely renamed and the region continues). Since S6c `BL`/`BLX` is no longer a wall -- but only when the destination register is `>= r4` and the prologue saves it, and a region with an implicit reader at its edge (a call's `r0-r3`, the register inside a `PUSH`/`STM` list, or `r0` returned by the epilogue) gives up renaming entirely and keeps the `MOV`. A slot must elide at least 2 loads to be worth a saved register, and an odd register count takes one more to restore 8-byte alignment. Full HAL corpus (on that day's 18,151 baseline): 18,151 -> **17,350 (-801 / -4.41%)**, 14 TUs shrink and **none grows**; without the flag everything is byte-identical (95/95). After S6c, measured in today's terms (seventeen switches vs eighteen): 14,954 -> **14,271 (-683 / -4.6%)**, 36,204 -> 36,114 B.. It also fixed six real defects (four from S6b plus two implicit-reader defects S6c flushed out): the built-in assembler silently truncated `r8-r15` (`CMP` / immediate `CMP` / `NEG` / `MUL` 32-bit forms and pass-1 widths), two-operand shift `LSL Rd, Rs` had its operand roles reversed, `vg_reads_reg` mistook a two-operand read-modify-write for write-only, and in-place renaming overwrote text still being read; S6c added two of the same family -- deleting a load when nothing in the region was renamed (`hits`), and losing the value to an implicit reader at the region's edge (a call argument / a `PUSH` list / the return value); 0.9.1-wip fixed a seventh: `vg_hi_mask()` was always empty, so vreg believed `r8-r11` were all free and fought the constant cache for the same register (the output contained duplicated register lists `PUSH {r5..r11,r8,r9,lr}`); after the fix eighteen switches read 14,218 -> 14,271 (+53 instructions / +42 B, the price of handing the stolen registers back). See `docs/VREG.en.md` |
| In-chain load hoisting | optional | `-fopt-ldhoist` (`ARKCC_FEATURE_OPT_LDHOIST`, host 1, on-board 0, off by default): a reload of the same `[Rb,#imm]` along one single-predecessor chain is deleted by keeping the first value in the lowest of `r4`-`r11` that the whole function never names; the consumers of a deleted load may only be `CMP Rd,Rn` / `CMP Rn,Rd` / `MOV Rn2,Rd`, and the region ends at a write to `Rb`, an aliasing store, a `BL/BLX`, or a multi-predecessor label.  The frame size is never touched: the `PUSH` and every exit `POP` are widened by the same set (plus one idle register when the parity demands it, keeping sp 8-byte aligned).  26 flags 11,044 -> **10,917 (-127 / -2,612 B = 1.15%)**, almost all of it in `HAL_DMAEx_MultiBufferStart_IT` (-126; `[r8,#0]` loads 266 -> 140), with the other 93 TUs unchanged.  Under the three pre-registered tiers this is the **register tier** (1.0-2.0%: switch kept, default off, below the >=2.0% project threshold); the code stays behind the default-off flag.  See `docs/EXPR_MODEL.md` S10.10-S11 |
| Stack-frame bookkeeping removal | optional | `-fopt-stackframe` (`ARKCC_FEATURE_OPT_STACKFRAME`, host 1 / board 0, off by default): removes the frame bookkeeping the emitter leaves behind when the address of a local is taken.  **P form**: entry `MOV r6, sp` + `SUB sp, sp, #N`, exits `MOV sp, r6` / `ADD sp, sp, #N`, body only touches memory through `[r6(, #imm)]` and never `sp` => delete `MOV r6, sp` and every `MOV sp, r6`, and rewrite each `[r6(, #imm)]` in place to `[sp(, #imm)]` (the `PUSH`/`POP` register lists are untouched, so the `sp` offset and the 8-byte alignment do not move).  **Q form**: the body has neither `[r6` nor `[sp`, exactly one `SUB sp, sp, #N` with matching immediates on every exit `ADD sp, sp, #N` => delete the `SUB` and every `ADD`; an in-body `BL/BLX` combined with an odd `PUSH` register count is refused (the `SUB` is still carrying the 8-byte alignment there).  Three must-refuse shapes: odd `PUSH` + `BL`, in-body `ADD rX, sp, #imm`, in-body `MOV rX, r6`.  On the 95-TU corpus (26 flags + `spill` + `ldhoist` = 10,917) -> **10,785 (-132)**, 385,260 -> 382,620 B; `make test-stackframe` runs 20 checks (including re-deriving every deletion from the unoptimised text, a global alignment invariant and both unicorn arms).  See `docs/EXPR_MODEL.md` S14-S15 |
| Intra-block dead instruction removal | optional | `-fopt-deadins` (`ARKCC_FEATURE_OPT_DEADINS`, host 1 / board 0, off by default): removes a pure register write whose destination nothing later in its basic block reads and which writes no live flag, plus `CMP/CMN/TST/TEQ` whose flags die in the block.  Block boundaries are labels and terminator instructions (`B`/`BX`/`POP {..,pc}`/around `BL`), the block-exit live set is treated as **all-live** (nothing is recovered across blocks), instructions under `IT` are never touched, and calls plus unknown mnemonics act as barriers.  `needf` follows the sound reading: only flag-writing instructions clear it, so a `CMP` followed by `BEQ` cannot lose its `CMP`.  It adds no line: delete only, never rewrite.  Stacked on `stackframe`: 10,785 -> **10,691 (-94)**, 382,620 -> 381,202 B.  `make test-deadins` runs 14 checks whose core is an **independent re-checker** that re-proves every deletion with its own liveness model, in parallel with OFF IS OFF, "removes lines only", equal image arms, four must-refuse fixtures staying byte-identical, and the cropped build refusing the flag by name.  A **pre-existing** defect is registered here but not fixed: `-fopt-live` / `-fopt-cmat` delete user inline assembly lines, see `docs/EXPR_MODEL.md` S15.6.  See `docs/EXPR_MODEL.md` S14-S15 |
| Compare-ladder redundancy removal | optional | `-fopt-ladderload` / `-fopt-ladderstage` (`ARKCC_FEATURE_OPT_LADDER`, host 1 / board 0, off by default): treats the compare ladder a 19-arm ternary such as `(uint32_t)hdma->Instance == DMA_StreamN ? FLAG : ...` lowers to as one unit, and deletes only instructions provably redundant **inside** it -- `-fopt-ladderload` drops the duplicate `LDR Rb, [Rn, #0]` that opens layer 2 and later (no memory write, no call, no write of `Rb/Rn` between the two loads), `-fopt-ladderstage` drops a `MOV Rx, Ry` staging copy in front of a `BNE` whose `Rx` is written before it is read on both successors (`POP`/`LDM` register lists count as writes, but only when the whole list parses exactly). Sharing anything across two ladders is refused: the text layer has no alias information, see `docs/EXPR_MODEL.md` 17.2. Whole 95-TU corpus: 10,691 -> **10,347 (-344, -3.22%)**, 381,202 -> 375,454 B; only `stm32f4xx_hal_dma_ex.c` changes, the other 94 TUs are byte-identical. Against armcc5 on the same corpus: 1.90x -> **1.84x**. `make test-ladder` runs 23 checks (only the two shapes, every deletion re-derived independently, two untouched TUs byte-identical, a `unicorn` four-arm differential over 20 `Instance` inputs plus a sabotaged self-check, and the cropped build refusing both switches by name). See `docs/EXPR_MODEL.md` 17-18 |
| Result born in its destination + base folded into the address | optional (registration tier) | `-fopt-birthdest` / `-fopt-basefold` (`ARKCC_FEATURE_OPT_REGBIRTH`, host 1 / board 0, off by default): `-fopt-birthdest` turns an adjacent `OP r0, ...` / `MOV rD, r0` into `OP rD, ...` and deletes the copy (`OP` must be single-destination, unconditional and without writeback; `r0` must be provably dead afterwards; the rename must not push a 16-bit encoding to 32 bits; **two-operand forms are always refused** because `AND r0, r7` means `r0 = r0 & r7`, so the rename would change the value; `MOVT` is refused the same way, because it writes only the high half and renaming it while deleting the copy splits a 32-bit constant -- S18 fixed this as a correctness bug and keeps a gate on it, see 24-25); `-fopt-basefold` folds a base register that exists for exactly one access, `ADD rB, rX, #imm`, into the address `[rX, #imm+off]` and deletes the `ADD` (`imm > 0`, multiple of 4, <= 1020, `imm+off <= 4095`, no label/branch/call in between, `rX` never written, a store may not store `rB`, and `rB` must be provably dead afterwards). Whole 95-TU corpus: 10,347 -> 10,189 (`-fopt-birthdest`, -158) / 10,330 (`-fopt-basefold`, -17) / **10,172 (both, -175, -1.69%)**; against armcc5 on the same corpus 1.84x -> **1.81x**. Under S20.3's frozen criteria this is the **registration tier** (107-213), so both stay off by default and out of the recommended set. `make test-regbirth` runs six checks (95-TU byte-for-byte OFF IS OFF, four-arm line classification that accepts only the two shapes, an independent re-implementation `tests/rb_oracle.py` matching all 285 translated texts, 657 refused candidates re-proved one by one, a `unicorn` four-arm differential with a sabotaged self-check, and the cropped build refusing both switches by name), plus `make test-movtpair` (all 102 adjacent `MOVW`/`MOVT` pairs of the corpus agree on their register, 0 violations; both arms of the fixture return the 134 the C source implies; and the gate goes red in three places on the pre-fix binary). See `docs/EXPR_MODEL.md` 20-21 |
| Same-value comparison-run folding | optional (landing tier) | `-fopt-chainfold` (`ARKCC_FEATURE_OPT_CHAINFOLD`, host 1 / board 0, off by default): folds a comparison ladder that compares **one register** and gives **the same value** on every arm -- arms 1..m-1 have their `BNE` inverted to `BEQ .Lcf_<f>_<i>` (jumping to a fresh label that lands exactly in front of arm m's `MOV rD, #v`), so the repeated `MOV rD, #v` and `B J` of arms 2..m are never executed; each arm's original entry label **stays where it is**, so entering any arm runs exactly the instruction stream it ran before (hence no label reference counting). A run needs: identical `CMP` operand text, identical `MOV`/`MOVW` mnemonic/destination/`#v` on every arm, arm k's `BNE` resolving exactly to arm k+1's `LDR`, every arm's `B` resolving to one and the same instruction, and `rD` different from both the compared register and the load destination; only `BNE` is inverted and any other conditional branch is refused outright. Whole 95-TU corpus: 10,172 -> **9,822 insns (-350 / -3.44%)**, 372,761 -> 358,964 B (-13,797 B); only `stm32f4xx_hal_dma_ex.c` changes (1,689/70,503 -> 1,339/56,706) and the other 94 TUs are byte-identical. Against armcc5's 5,619 insns on the same corpus: 1.81x -> **1.75x**. Under §22.4's frozen criteria (>= 214) this is the **landing tier**; the **dynamic instruction count is unchanged** (everything deleted was walled off behind a `BNE`), the win is static size, fetch and branch-predictor pressure. `make test-chainfold` runs six checks (95-TU byte-for-byte OFF IS OFF, a diff that accepts only `replace 3->1` and `insert 0->1`, an independent re-implementation `tests/cf_oracle.py` matching all 95 TUs plus a structural re-proof of all 60 runs, a 247-layer census with must-not-fire fixtures, a `unicorn` differential at 190/190 and a sabotaged build at 238 != 190, and the cropped build refusing the switch by name). See `docs/EXPR_MODEL.md` 22-23 |
| Value-stack round-trip removal | optional (record tier) | `-fopt-pushpop` (`ARKCC_FEATURE_OPT_PUSHPOP`, host 1 / board 0, off by default): the IR is a stack machine, so a value that has to survive another computation is really pushed to the machine stack and popped back -- `<def>` (`MOV|MOVW rX,#imm` / `LDR rX,.Llit` / `MOV rX,rY`, straight before the `PUSH`) + `PUSH {rX}` ... `POP {rY}`. The value can always be produced again from the text, so the round trip is pure overhead: the `PUSH` goes and the `POP` becomes either nothing (`rY == rX` and the span never writes `rX`) or the definition replayed (the span clobbers `rX`, so it is re-materialised). Six guards: no `BL`/`BLX` in the span, no instruction naming `sp`, every branch inside the span lands inside it, no label inside the span is entered from outside, and the `MOV rX,rY` form also needs `rY` untouched. This slice sits at the **very end of the text pipeline** and is a **fixed point** (the scanner already runs to the end of the buffer; without iterating the result would depend on how often it is called). Whole 95-TU corpus: 10,172 -> **10,125 insns (-47 / -0.46%)**, 372,761 -> 372,344 B (-417 B); it composes additively with `-fopt-chainfold`: 9,822 -> **9,775** (same -47 / -417); against armcc5 5,619 insns 1.748x -> **1.740x**. 35 sites = 12 with both halves deleted + 23 re-materialised at the `POP` (19 `LDR rX,.Llit` in `stm32f4xx_hal_dma_ex.c`, 4 immediates in `stm32f4xx_hal_exti.c`); single-register `PUSH` census 202 -> 167. `make test-pushpop` runs six checks (95-TU byte-for-byte OFF IS OFF, an independent re-implementation `tests/pp_oracle.py` matching all 95 TUs byte for byte with drift=0, every site re-proved by a cursor walk over the on text plus `rep` operand and destination-register checks, the 202-PUSH census and the reason of all four must-decline fixtures pinned, a `unicorn` differential with the same value 196 and the same RAM snapshot plus two different peripheral addresses and two constant tables so a swapped constant is caught, and the cropped build refusing the switch by name). Note: the `pair` shape has text-level verification only (the executed fixture reliably yields `remat`); the boundary is stated in 27.6. See `docs/EXPR_MODEL.md` 27 |
| Address-chain folding | optional (record tier) | `-fopt-addrfold` (`ARKCC_FEATURE_OPT_ADDRFOLD`, host 1 / board 0, off by default): `-fopt-addr` folds address chains inside one expression and `-fopt-basefold` folds a base register with offset 0 serving exactly one access, so what is left is a **base built by two additions in a row**. Two rules: **A** merges `ADD|SUB rA,rB,#k1` followed by `ADD|SUB rC,rA,#k2` (`rA` dead afterwards) into `ADD|SUB rC,rB,#(k1+-k2)` and deletes the first (`k1+k2 != 0`, `|k1+k2| <= 255`); **B** turns `ADD rA,rB,#k1` (`k1 >= 0`) followed by `LDR/LDRB/LDRH/LDRSH/STR/STRB/STRH rD,[rA]` or `[rA, #k2]` (`k2 >= 0`, `rA` dead afterwards) into the access with base `rB` and offset `#(k1+k2)`, deleting the first (`0 <= k1+k2 <= 4095`). Shared guards: same basic block, no IT, no `!` write-back, all registers `r0`-`r12`, **the new instruction must not be wider than the old one** (mirroring the assembler's 16/32-bit shapes, otherwise the fold trades a deleted 2-byte `ADD` for a 4-byte access), and flags judged **block-locally** (`CBZ/CBNZ` neutral, `B/BL/BX/BLX` stop the scan). Whole 95-TU corpus: 10,172 -> **10,134 insns (-38 / -0.37%)**, 372,761 -> 372,030 B (-731 B); it composes additively with `-fopt-chainfold`+`-fopt-pushpop`: 9,775 -> **9,737**, 358,547 -> 357,816 B. 38 sites = A 24 / B 14, touching only 5 TUs (`main.c` 3, `hal_dma.c` 21, `hal_dma_ex.c` 3, `hal_flash.c` 1, `hal_rcc.c` 10); against armcc5's 5,619 insns 1.740x unchanged. `-fno-opt-addrfold` is byte-identical on both baselines; the gap between the independent census (48) and the probe (83) against the measured 38 is accounted for item by item (16 = cross-block liveness 9 / flags 2 / A-then-B composition 5), and **not one of them is shape-correct yet refused**. `make test-addrfold` runs six checks (95-TU byte-for-byte OFF IS OFF, an independent re-implementation `tests/af_oracle.py` reproducing both arms of all 95 TUs byte for byte with drift=0, a per-round cursor re-proof, every guard restated using only the off-arm text, 9 must-refuse plus 2 must-accept fixtures, a `unicorn` differential with the same value 80 and the same RAM snapshot plus the cropped build refusing the switch by name plus the 606-flag-consumer all-`CMP` self-check). See `docs/EXPR_MODEL.md` 30 |
| Dead `static` removal | yes (no switch) | An unreferenced `static` function is no longer emitted (`ir_drop_unused_static()`, IR level, hanging off the single choke point `ark_emit_program()`): `static inline`, `__STATIC_INLINE` and plain `static` are treated alike, and a candidate only has to be `is_static`; liveness is a fixed point from the kept functions (`IR_CALL`, an `IR_PUSH_FUNC` address-take, global initialisers `init_sym`/`init_refs`, `alias` targets, and **any name spelled out in raw assembly text** -- `IR_ASM` statements and whole-function `__asm` bodies are substring-searched; text it cannot read turns into a link-time undefined symbol, never a wrong image). Never dropped: `used`/`unused`/`weak`/`constructor`/`destructor`/`interrupt`/`naked`/`alias` targets/`main`, plus entry-point names such as `Reset_Handler`/`HardFault_Handler`/`SysTick_Handler` that a linker script or the vector table may reference by name. On by default and at `-O0` too -- this is a correctness fix (a dead helper referencing a declared-only object used to fail the build, e.g. CMSIS `ITM_SendChar` reading `ITM_RxBuffer`), not an optimisation; `-v` prints how many functions were dropped and `--warn-unused-static` still reports earlier in the pipeline. 95-TU HAL corpus 18,151 -> **16,414 instructions (-1,737 / -9.57%)**, all 95 TUs smaller and none bigger; with `-fopt-vreg` 18,151 -> **15,613 (-2,538 / -13.98%)**. See `docs/DEADSTATIC.en.md` |
| Assembler coverage | yes | all LDR/STR addressing modes (`[Rn]`/`[Rn,#imm]`/`[Rn,Rm]`/`[Rn,Rm,LSL #0..3]`/`[Rn,#imm]!`/`[Rn],#imm`, `[sp,#imm]`, `[pc,#imm]`), `VLDM/VSTM/VPUSH/VPOP`, `LDMFD/STMFD/LDMEA/STMEA` aliases, `ADDW/SUBW`; forms that do not exist in the architecture (`LDMIB/LDMDA/STMIB/STMDA`, register-indexed writeback) are explicit errors |
| Preprocessing | yes | object/function macros (`#/##`), `#if/#elif/#else/#endif/#ifdef/#ifndef/#undef/#error/#warning/#pragma`, nested `#include` (<=8 levels), `__VA_ARGS__`, `-I` paths, trigraph replacement |
| Comments | yes | `//` and `/* */` |

### C11 keywords (subset)

Only these six keywords are implemented; the rest of C11 (`<threads.h>`, `_Atomic` applied to
composite types, anonymous-struct-member variants, etc.) is out of scope and produces an ordinary
syntax error instead of being waved through as "probably works".

| Keyword | Support | Notes |
| --- | :---: | --- |
| `_Static_assert(expr[, "msg"])` | yes | works at file scope, block scope and inside structs; `expr` is folded **during parsing** by `eval_const_expr`, and a non-integer-constant expression is an error (`static assertion whose truth we cannot decide` is never let through); when the condition is 0 the `msg` is printed verbatim in the diagnostic |
| `_Alignof(type-name)` | yes | folded from the **type** (not from an expression's "default int" — `sizeof` once answered wrongly on that path); only the type-name form is accepted, `_Alignof(expr)` is an explicit error rather than a guess |
| `_Alignas(type-name)` / `_Alignas(const-expr)` | yes | at file scope any power of two (64 verified to take effect, and the flat ARM SRAM layout also honours `align_bytes` instead of always aligning to 4), on struct members (sets `align_override`, `sizeof` 32 / `align` 16 verified), at block scope ≤ 8 bytes (8 verified); it **never weakens** natural alignment (C11 6.7.5p6: `_Alignas(2) double` is still 8-aligned); non-powers of two and non-constants are errors |
| `_Generic(ctrl, type: expr, ..., default: expr)` | yes | the controlling expression gets the C11 6.5.1.1p2 treatment: lvalue conversion + array decay + **function-designator decay** (`f`, `&f`, `*f` all land on the function pointer type); **no integer promotion** (`char` stays `char`); no match and no `default` → error (returning 0 would be a fabricated answer), duplicate `default` → error; after selection sema squashes it into an ordinary expression, so downstream stages (irgen / global initialisers / every backend) never see it |
| `_Thread_local` | yes | same storage as `__thread` (bit `0x10000`), but validated per C11 6.7.1p4: at file scope it requires `static`/`extern`, cannot modify a function, cannot appear in a `typedef`, and cannot be combined with `auto`/`register`; **armcc's bare `__thread` stays exempt** (`examples/test_tls.c` relies on that). The four diagnostics are ordered most-specific-first, so `_Thread_local int f(void);` reports "applies to objects, not functions" instead of a generic storage-class error |
| `_Atomic` | yes (with limits) | both the qualifier and `_Atomic(type-name)` parse; `_Atomic` goes through `type_atomic()` into `Type::is_atomic` (a shallow copy plus a flag, so singletons are not polluted), which means atomicity **propagates through typedefs** — after `typedef _Atomic int atomic_int;` the object `atomic_int x;` is still atomic. It decides three things: which `<stdatomic.h>` implementation is used, which types are rejected outright, and that `sema` rejects every read-modify-write (`x += 1` / `x++` are errors per C11 6.5.16.2p3 / 6.5.2.4p2 and name `atomic_fetch_*`; `x = 5` is fine, that is one atomic store). Arrays / functions / `struct`·`union` are rejected per C11 (the array case cites 6.7.2.4; composites need a lock, so it refuses instead of pretending to access atomically). Real atomicity exists only on ARM (PRIMASK critical sections); on the other four targets **every atomic operation is a compile-time error**, failing as the undeclared identifier `__arkcc_atomic_<op>_not_supported_on_this_target_use_a_mutex` — it never silently degrades into a plain access. See [docs/ATOMIC.md](docs/ATOMIC.md) |

Block-scope `_Alignas(16/32/64)` is an **error**, not a silent downgrade: the frame is built as
`sp -= N; base = sp`, AAPCS only guarantees 8-byte `sp` alignment, and really supporting 16/32/64
would mean changing prologue/epilogue and dealing with the conflict where the variadic sequence
uses `r5` to hold the old `sp`. The choice here is "rather an error than a wrong answer".

The **semantic boundary** of `_Thread_local` must be stated: the `.tbss`/`.tdata` machinery is only
emitted on the hashed loading path of `ARKCC_FEATURE_ARMCC_KEYWORDS`, so **in a flat bare image
(`--vector-table`) TLS variables are ordinary `.data`/`.bss`** — they live in SRAM and are zeroed by
`__arkcc_init_globals()`; on a single-threaded bare-metal target the value semantics are correct,
but that is not thread-pointer relocation. The C backend emits `__thread` verbatim and leaves it to
the host gcc. Execution-level evidence: `tls_static_init` / `tls_block_static` / `tls_reject` in
`tests/arm_exec/run_arm_exec.py`.

The **semantic boundary** of `_Atomic` needs the same care. `stdlib/include/stdatomic.h` has two
branches: on ARM targets, load/store of 32-bit types are plain accesses (an aligned single-word
access on a single core is indivisible by itself), while `exchange` / `compare_exchange` and the
five RMWs go through `__arkcc_crit_save` / `__arkcc_crit_restore` (`MRS PRIMASK` + `CPSID i`)
critical sections; types that do not fit in a word (`long long`, `double`) route even load/store
through the critical section, and comparison is two-word equality rather than AEABI's vector
equality. Memory order is always `seq_cst` (critical section + the compiler barrier
`__memory_changed`), and **this is single-core interrupt-level mutual exclusion**: cross-core and
cross-DMA visibility is not its job — DMB orders accesses but does not fix cache coherency. On
non-ARM targets (x86 / x86_64 / riscv32 / c) everything except `atomic_init` (which is just an
assignment) and the typedefs is a compile-time error, with the reason written into the name. Boundaries
(`int *_Atomic p` is supported since 0.9.1: the qualifier lands on the **pointer itself**,
load/store stay ordinary accesses, and `p++` is still refused as a C11 read-modify-write;
`_Atomic(long)` is a type specifier and is refused after a `*`. Read-modify-write through a pointer
is now **verified as caught** — `atomic_int *p; *p += 1;`, `p[0] += 1;`, `(*p)++;` and
`++*(p + 1);` are all refused, while `int *_Atomic p; *p += 1;` must compile because the pointee is
a plain int): only `lock xadd` / `cmpxchg16b` on `x86_64` are still not wired up. Gates: `tests/run_atomic_tests.py` runs five targets × (target-identity macros, 11 atomic
operations that must be rejected, `atomic_init` that must compile), and
`tests/arm_exec/run_arm_exec.py`'s `atomic_rmw` / `atomic_nested_mask` / `atomic_wide` /
`atomic_ptr` / `atomic_reject` really execute the critical sections, the 64-bit path and atomic
pointer accesses on unicorn.

### ARM Compiler 5 (armcc) compatibility extensions

#### armcc keywords

| Extension | Support | Emits |
| --- | :---: | --- |
| `__svc(n)` | yes | `SVC #n` |
| `__irq` | yes | interrupt prologue `PUSH {r0-r3,r12,lr}` / epilogue `POP {r0-r3,r12,pc}` |
| `__weak` | yes | `.weak <name>` |
| `__naked` | yes | no prologue/epilogue |
| `__packed` | yes | standalone keyword form + `__attribute__((packed))` + unaligned access through a `__packed` pointer (byte-wise load-and-stitch, 1/2/4/8 bytes; both ARM and RV32I do the full 8 bytes instead of only moving the low 4) |
| `__align(n)` | yes | alignment control that actually takes effect |
| `__at(addr)` | yes | absolute address (same as `__attribute__((at(addr)))` / `#pragma location=`) |
| `__forceinline` | yes | parsed (force-inline hint) |
| `__asm void fn() {...}` | yes | whole-function assembly body (armcc style) |
| `__value_in_regs` | yes | parsed (struct-in-registers return hint) |
| `__pure` | yes | parsed (side-effect-free hint) |
| `__interwork` | yes | parsed (ARM/Thumb interworking hint) |
| `__thread` | yes | thread-local storage (`.tbss`/`.tdata` sections) |
| `__global_reg` | yes | parsed (global register variable hint) |
| `__smc` | yes | parsed (SMC secure monitor call hint) |
| `__int64`/`__int32`/`__int16`/`__int8` | yes | fixed-width integer aliases |
| `__typedef` | yes | parsed (typedef compatibility prefix) |
| `__args`/`__return` | yes | parsed (argument/return register binding hints) |
| `__tp_soft` | yes | parsed (software thread pointer hint) |
| `__nothrow` | yes | parsed (no-exception hint) |
| `__deprecated` | yes | parsed (deprecation marker) |
| `__may_alias` | yes | parsed (alias-safe type hint) |
| `__softfp` | yes | parsed (soft-float ABI hint) |

#### `__attribute__` attributes

| Attribute | Support |
| --- | :---: |
| `section` | yes |
| `aligned`/`packed`/`noreturn` | yes |
| `used`/`unused` | yes |
| `alias("target")` | yes |
| `constructor`/`destructor` | yes |
| `deprecated`/`format(printf,...)` | yes |
| `may_alias`/`nothrow` | yes |
| `pure`/`const` | yes |
| `visibility("default/hidden")` | yes |
| `nonnull` | yes |
| `warn_unused_result` | yes |
| `sentinel` | yes |
| `malloc` | yes |
| `fastcall`/`stdcall`/`cdecl` | yes |

#### `#pragma`

| pragma | Support |
| --- | :---: |
| `#pragma pack(n)` | yes |
| `#pragma anon_unions` | yes |
| `#pragma location=addr` | yes |
| `#pragma diag_suppress` | yes |
| `#pragma arm/thumb` | yes |
| `#pragma import(__use_no_semihosting)` | yes |
| `#pragma push/pop` | yes |
| `#pragma O0/O2/O3`, `#pragma optimize` | yes |

#### Inline assembly

| Form | Support |
| --- | :---: |
| `asm/__asm__` inline assembly | yes — basic form + extended form (operands/constraints/clobbers); fully transparent on the C backend, passed through as text on the ARM backend |

### armcc-compatible predefined macros

| Macro | Value |
| --- | --- |
| `__ARMCC_VERSION` | armcc version number |
| `__arm__` / `__thumb__` | ARM/Thumb mode flags |
| `__arm` / `__thumb` | underscore-less forms (armcc compatibility) |
| `__TARGET_ARCH_7_M` / `__TARGET_ARCH_7E_M` | Cortex-M architecture flags |
| `__TARGET_FPU_VFP` | VFP flag |
| `__BIG_ENDIAN` / `__LITTLE_ENDIAN__` | byte order |
| `__sizeof_int` / `__sizeof_ptr` | type sizes |
| `__STDC_VERSION__` | `199901L` |
| `__STDC_HOSTED__` | `1` (hosted) / `0` (embedded) |
| `__SIZE_TYPE__` / `__PTRDIFF_TYPE__` / `__WCHAR_TYPE__` | GCC-style type macros |
| `__EDG__` | EDG front-end compatibility flag |
| `__APCS_INTERWORK` | APCS interworking flag |

### Code generation

| Feature | Support |
| --- | :---: |
| 32-bit immediates MOVW/MOVT | yes |
| Integer division SDIV / `__aeabi_idiv` | yes |
| 64-bit arithmetic `__aeabi_lmul/ldiv` | yes |
| Soft-float `__aeabi_f*` (single precision) | yes |
| Soft-float `__aeabi_d*` (double precision, `double` is true 64-bit) | yes |
| Hardware FPU instructions (VFP `VADD/VMUL/VCVT/VCMP` replacing the soft-float stubs) | yes |
| VLA dynamic stack allocation `IR_ALLOCA` | yes |
| `.data/.bss/.rodata` section separation | yes |
| Bit-field pack/unpack | yes |
| Compiling assembly files directly | yes (the ARM backend has a full Thumb-2 text assembler; triggered by the `.s`/`.S`/`.asm`/`.ASM` extensions, case-insensitive) |
| Strict AAPCS (>4 arguments on the stack) | yes |
| `setjmp/longjmp` support | yes |
| `.init_array`/`.fini_array` (constructors/destructors) | yes |
| Unaligned access through a `__packed` pointer | yes (1/2/4/8 bytes read and written byte-wise; for 8 bytes the low word is assembled and pushed, then the high word is assembled and pushed, matching the push order of the aligned path) |
| Full DWARF debug info (`.file/.loc/.cfi_startproc/.size` + `.debug_info`/`.debug_abbrev`/`.debug_line`) | yes |
| TLS thread-local storage (`.tbss`/`.tdata`) | yes |
| `--split_sections`, one section per function (`.text.fn`) | yes |
| Scatter loading-description parsing (`include/scatter.h` + `src/scatter.c`) | yes (parsing + scatter-aware linking + vector table generation; see the table below) |
| CPU selection (`-mcpu`/`--cpu`, `include/cpu.h` + `src/cpu.c`) | yes |
| Multi-object data-section relocation `--reloc-data` (`.arkdata` markers + link-time MOVW/MOVT rewriting) | yes (off by default; when off, the old behaviour of reporting an SRAM overlap is kept) |
| In-section absolute-address fixup at link time `--reloc-text` (`.arktext` markers + the object's own `__arkcc_text_base`; the linker computes the displacement per object) | yes (off by default; when off the output is byte-identical to older versions. It fixes code addresses baked into `MOVW/MOVT`, such as string literals) |
| On-demand runtime emission `--rt-lazy` (only reachable `__aeabi_*` blocks) | yes (off by default; `add3.c` 1578 → 60 bytes) |
| IR stack top in r0 `--reg-top` (bounded registerisation, not an allocator) | yes (off by default; 80 sample instructions −7.1%) |
| Explicit `float` ↔ `double` conversion (`VCVT.F32.F64` / `VCVT.F64.F32`) | yes |
| Floating-point constant-expression folding (`eval_const_fexpr` + `fconst_to_int`) | yes — two landing points: explicit conversion to an integer type (`(int)(2.5*4.0)`, `enum {E=(int)(1.5+1.5)}`, `int a[(int)(2.0*3.0)]`) and implicit conversion of global/static initialisers (C99 6.6, `int g = 2.5*4.0;`). NaN/infinity/out-of-range **is not folded** — it errors instead of inventing a value; `int a[2.5]` and `int a[(int)(1.0/0.0)]` report `array dimension is not an integer constant expression` instead of silently taking one element |
| Assembler extended instruction set `--asm-extra` (`ANDS`/`ORRS`/…/`MRS`/`MSR`, 32-bit and pre-decrement forms of `LDM`/`STM`, `TBB`/`TBH`, `LDRD`/`STRD` — 24 mnemonics plus `.W`/`.N` suffixes) | yes (off by default; when off they are unknown mnemonics. `ADDS`/`SUBS` are not on this list: the backend emits them itself, so they are unconditionally accepted — GNU as would assemble `ADD` without `S` as a 32-bit `ADD.W` and silently drop the flags) |
| Capacity limits (full on host / trimmable on board) | yes (`include/arkcc_config.h` §9, one definition with two sets of defaults, each item overridable with `-D`; anything over the limit is an error, never a silent drop) |

### `.sct` / `.s` support matrix

| Capability | Status | Notes |
| --- | :---: | --- |
| Parse `.sct` (scatter) files | ✅ | `scatter_parse_file()` (`src/scatter.c`) |
| Parse GNU `.ld` scripts | ✅ | `linker_script_parse_file()` (`src/scatter.c`) |
| `.sct` → `.ld` conversion | ✅ | emitted only in `-S` mode, `scatter_to_ld_script()` |
| `.ld` → `.sct` conversion | ✅ | emitted only in `-S` mode, `scatter_to_sct_file()` |
| Look up an execution address by section name | ✅ | `scatter_lookup_addr()` + `scatter_get_er_base_for_section()` |
| Actual section placement/linking with `.sct` | ✅ | scatter-aware: `-link` mode parses `.sct`/`.ld` → extracts flash_base/initial_sp → generates a 256-entry vector table → moves code → adjusts symbols/relocation offsets |
| Compile `.s`/`.S` assembly files | ✅ | `arm_assemble()`, a complete Thumb-2 text assembler, triggered by extension |
| Compile `.asm`/`.ASM` files | ✅ | equivalent to `.s`/`.S` (`is_asm_input()`, case-insensitive) |
| Output name when compiling `.asm`/`.ASM` | ✅ | without `-o` it derives `.bin` from the same name (same as `.s`) |
| `--scatter <file>` command-line option | ✅ | parsed in `-S`/`-link`/`-c` modes; participates in vector table generation in `-link` mode |
| `-T <file>` / `--linker-script` option | ✅ | same as `--scatter`; a GNU `.ld` script is converted into the internal scatter representation |
| `--uvprojx <file>` option | ✅ | automatically extracts `<IncludePath>`/`<Define>` from an MDK `.uvprojx` as `-I`/`-D` |

### Standard library subset

| Source file | Provides |
| --- | --- |
| `stdlib/src/printf.c` | a compact `printf` (`%d/%u/%x/%X/%s/%c/%p/%%` + width/zero padding, 64-bit `long long` not truncated) |
| `stdlib/src/string.c` | `memcpy/memset/memmove/memcmp/strlen/strcpy/strcmp` |
| `stdlib/src/math.c` | `sin/cos/sqrt/pow/fabs/floor/ceil/fmod` |
| `stdlib/src/setjmp.c` | `setjmp/longjmp` (portable simplified host implementation, host tests only) |
| `stdlib/src/arm/setjmp.s` | the **real ARM Thumb-2 implementation** of `setjmp/longjmp` (`jmp_buf` holds r4-r11/sp/lr, `longjmp(env,0)` reads back 1); why it must be assembly and cannot be a C wrapper is in the file header |
| `stdlib/src/stdlib.c` | conversions and integer arithmetic: `strtol/strtoul/strtoll/strtoull` (base 2..36, `errno=ERANGE` saturation, `endp` semantics), `atoi/atol/atoll`, `strtod/strtof/strtold/atof`, `labs/llabs`, `div/ldiv/lldiv`, `qsort` (insertion sort, stable, no recursion), `abs` |
| `stdlib/src/heap.c` | `malloc/free/calloc/realloc`: a static arena of `ARK_STDLIB_HEAP_SIZE` bytes (8 KB by default, change with `-DARK_STDLIB_HEAP_SIZE=…`), block splitting/adjacent coalescing; **returns `NULL` when exhausted** (no silently fabricated address), plus the read-only diagnostics `ark_heap_used/ark_heap_capacity` used by gates and the on-board `mem` command |
| `stdlib/src/errno.c` | `errno` as a real object (a single 4-byte global, shared by every TU's `extern int errno`; the `E*` macros live in `<errno.h>`, so renumbering is a header change) |
| `stdlib/src/exit.c` | `exit/_Exit/abort/atexit`: runs the `atexit` chain in reverse registration order, then calls the port hook `_ark_exit(status)` |
| `stdlib/src/exit_default.c` | weak definition of `_ark_exit` (infinite loop): a target project can override it, and only then does `exit()` really leave the image |
| `stdlib/src/signal.c` | `signal/raise` (subset): `SIGINT/SIGTERM/SIGABRT/SIGFPE/SIGSEGV/SIGILL`, `SIG_DFL` goes to `_ark_exit`, `SIG_IGN` ignores |
| `stdlib/src/putchar_default.c` | weak default `putchar` |
| `stdlib/src/arm/aeabi.c` | the 64-bit AEABI runtime for flat ARM images: `lmul` / `ldiv` / `udiv` / `llsl` / `llsr` / `lasr` / `lcmp` / `ulcmp`, all using 32-bit operators only (never recursing into itself), in C, compilable by arkc itself |
| `stdlib/src/arm/aeabi_divmod.s` | four-register-return wrappers for `__aeabi_ldivmod` / `__aeabi_uldivmod` (quotient `r0:r1`, remainder `r2:r3`) — C cannot express a four-register return (`__value_in_regs` is parsed but not code-generated), so this one piece must be assembly, reusing the arithmetic from `aeabi.c` |

`stdlib/include/` headers (23): subsets of `complex.h`/`ctype.h`/`errno.h`/`fenv.h`/`float.h`/
`inttypes.h`/`limits.h`/`locale.h`/`math.h` (with `M_PI` etc.)/`setjmp.h`/`signal.h`/`stdarg.h`/
`stdatomic.h`/`stdbool.h`/`stddef.h`/`stdint.h`/`stdio.h`/`stdlib.h`/`string.h`/`tgmath.h`/
`time.h`/`wchar.h`/`wctype.h`, all declared per C99/C11 — **declarations and implementations share
one source of truth**, and the gate compiles the implementation files against the prototypes in the
headers.

**Flat images (`-o image.bin` / `--vector-table`) and the two ARM runtimes above**: when compiling
`.c` to `.obj`, 64-bit multiply/divide/modulo/shift/compare emit external symbols such as
`__aeabi_lmul` (64-bit add/sub are already inlined as `ADDS`/`ADC`, `SUBS`/`SBC`, so they need no
runtime). **The compiler never implicitly links these two sources** — whether the image needs
soft-float / 64-bit runtime is the linker's decision. So a working flat-image command is three
steps:

```sh
./arkcc -target arm -c stdlib/src/arm/aeabi.c -o aeabi.obj
./arkcc -target arm -c stdlib/src/arm/aeabi_divmod.s -o aeabi_div.obj
./arkcc x.c -target arm -c --vector-table -o x.obj
./arkcc -link x.obj aeabi.obj aeabi_div.obj --vector-table -o out.bin
```

Linking these two sources prints one line, `[link] note: 1 duplicate compiler-runtime symbols
merged`: `aeabi.c` also carries 64-bit add/subtract functions to cover the "somebody calls this
object file directly" case, and they are same-name same-meaning as the runtime built into the
image, so merging is the expected behaviour.

**Known cost (a design choice, not a defect)**: `udivmod64` is a 64-iteration restoring division,
and under arkc's "every intermediate goes on the stack" code shape **one 64-bit division is about
12.8k instructions** (measured on the whole `shift64` case: 9.26M instructions). Soft division on
an M7 is still in the millisecond range at its clock rate, but latency-sensitive inner loops should
avoid 64-bit division.

**RV32I flat images (`-target riscv32 x.c -o x.bin`)**: this backend used to stop at "emit GAS
assembly"; to execute you had to wire up `as -march=rv32im` + `ld -Ttext=0x08000000` yourself. Now it
is an RV32I assembler in its own right and writes the image straight to `0x08000000`: `.text` →
`.rodata` → `.data` laid out consecutively (run `-S` first and you can match every instruction),
section bases 16-byte aligned, and the image **ends at the end of the last section that has any
bytes** (a pure code program is exactly the code length, with no extra alignment padding).
`ARKCC_DUMP_SYMS=1` prints `RV_SYM <name> 0x<address>` to stderr, which host tests use to locate
`main`.

This assembler **has no linker**, so it is stricter than GNU as about "half-finished" input: three
classes of problem are errors and produce no image — unknown mnemonics; branches beyond ±4 KB for
`beq/bne/blt/bge/bltu/bgeu` (±1 MB for `jal/j`); and **references to symbols this translation unit
does not define** (`a flat image has no linker to fill it in`) — leaving a half-written `auipc`
that jumps outside the image while exiting 0 is exactly the silent wrong answer this project
forbids.

**RV32I object mode (`-target riscv32 -c x.c -o x.ark_obj` + `-link`)**: `-c` produces an ARKOBJ2
object whose body holds **already-assembled machine code** (not assembly text), with cross-object
references left for the linker. RV32I's `la sym` / `call sym` are `auipc`+`addi|jalr` pairs, and
only both instructions together decide where the low 12 bits go, so relocations are recorded **in
pairs** (`RV_RELOC_AUIPC`, 8 bytes); `.word sym` wants an absolute address and gets its own kind
(`RV_RELOC_ABS32`). Rewriting only the top 20 bits of `auipc` is not enough — the `auipc` immediate
is shifted left by 12, so the carry out of the low bits must be folded into the following
instruction, which is why the two are always computed together.

Inside an object everything is PC-relative, so **every object can land at any offset in the image**:
the linker concatenates objects at 16-byte alignment, intra-object references hold naturally, and
only the cross-object entries in the table need patching. The one thing that cannot work is a
**cross-object branch** (RV32I has no relocatable 32-bit branch form); such code is an error that
suggests turning it into a call — an error is more honest than half an answer.

The export boundary is decided by an **export table**: only labels named by `.globl`/`.weak` (i.e.
non-`static` definitions at the C level) can be referenced across objects. Otherwise each
translation unit's `static helper` would collide at link time, and the linker's policy is "the first
duplicate strong symbol wins" — which would silently bind file A's static helper into file B's call,
another silent wrong answer.

Objects carry an ISA descriptor (`__arkcc_isa_riscv32`) that is checked in both directions at link
time: objects linked under `-target riscv32` must be RV, and RV objects must be linked under
`-target riscv32`. Without this step, `arkcc -link rv.obj` would take the ARM relocation path, write
Thumb branch encodings into a RISC-V image, and still exit 0. `-v` prints
`[link] object N: base 0x...`; together with `ARKCC_DUMP_SYMS` that is how you convert "offset
inside an object" into an address — a flat image has no symbol table of its own.

Known boundary: **cross-translation-unit function-pointer global initialisers**
(`int (*gp)(void) = f;`) are currently a hard error on the RV backend
(`cannot turn the initialiser of the global 'gp' into data`) — a pre-existing limitation; with
hand-written assembly `.word f` works (`RV_RELOC_ABS32`). Also, the linker still warns and takes the
first of **duplicate strong symbols** (ARM has the same policy; unchanged this round), so defining a
non-`static` global function/variable twice at the C level is not rejected.

`li` immediates accept the whole unsigned 32-bit range (`li t0, 4294967295` is -1, matching GNU as);
only going beyond 32 bits is an error.

**The last four IR classes on RV32I (inline assembly / `__svc` / `__smc` / auto-vectorisation)**:
after the backend's `default` branch became an error, any source using these four failed to compile
on RV — honest, but still a gap in "a complete C compiler". All four are implemented now:

- `IR_ASM`: `asm("...")` lands in the assembly output verbatim; the extended form
  (`asm("t" : outs : ins : clobbers)`, marked by irgen with an `@` prefix) maps `%0..%3` to
  `a0..a3` (`r0..r3` on ARM). This backend **has no operand allocator**, so outs/ins/clobbers are
  discarded — a known boundary, recorded in the gate's comments.
- `IR_SVC` / `IR_SMC`: the number goes into `a7`, the instruction is `ecall`. RV32I **has exactly
  one trap instruction**, so `__svc(n)` and `__smc(n)` are indistinguishable on RV; that is a
  property of the ISA, not a trick. Putting the number in `a7` follows the RISC-V syscall ABI / SBI
  convention, and the kernel side picks it up from there.
- `IR_SIMD_ADD16/SUB16/ADD8/SUB8`: the packed-lane operations produced by auto-vectorisation. The
  RV32I base ISA has no packed instructions, so they are **exactly emulated** with SWAR (per-lane
  signed wrap-around, never saturating — matching ARM's `SADD16/SSUB16/SADD8/SSUB8`). Two easy
  mistakes: the 16-bit family cannot use a byte mask (the carry out of `0x00FF + 1` would be lost,
  so you must mask whole half-words and then shift the carry away); the 8-bit family can group by
  `0x00FF00FF`, but **subtraction must set a guard bit at the start of each lane's gap**, otherwise a
  borrow out of the low byte crosses the gap and steals a 1 from the lane above (`0 - 1` yields
  `0xFFFFFFFF` instead of `0x000000FF`).

This path also uncovered and fixed a **silent wrong answer that existed in both backends**:
`opt_vectorize` widened `LOAD_IDX`/`STORE_IDX` to `es*W` and swapped `BINARY` for SIMD, but never
removed the `IR_TRUNC` left over from element narrowing, so the four lanes packed into one word were
narrowed down to lane 0 — `char a[8] + b[8]` under `-O2` computed `{1,2,3,4,5,6,7,8}` as
`{2,0,0,0,10,0,0,0}`. The fix raises the target width of adjacent `IR_TRUNC`s to 32 (32 is a no-op
in both backends, so no renumbering is needed) and rejects loops over `volatile` and `__packed`
(`aux & 0x200 / 0x400` — the former must not be merged, and the latter's byte-wise path is the very
implementation of unaligned access). Gate: `tests/run_rv_misc_ir_tests.py`.

The same path also exposed and fixed a backend defect: `irgen` records "operand is unsigned" in bit
8 of `aux` (`0x100`), the ARM backend masks that bit off first, but the RV32I backend switched on
`aux` directly, so **unsigned right shift and all four unsigned comparisons fell into the `default`
branch and emitted nothing** — both operands popped, the left operand pushed back, `u >> 4` silently
returned `u` and `a < b` silently returned `a`. Now the bit is masked off and the `srl` / `sltu`
family is selected, and the `default` branch is an error (an unknown operator may not silently
return the left operand).

### Backends

| Backend | Purpose |
| --- | --- |
| **ARM Thumb-2** | STM32 Cortex-M (default; soft-float/hardware FPU + section separation + double-precision stubs + AAPCS + full DWARF + TLS + split_sections + scatter) |
| **C source** | the host test main path (IR -> readable C, full inline-assembly operand pass-through) |
| **x86_64** | a real SysV AMD64 backend: 8-byte pointers, `rdi rsi rdx rcx r8 r9` + `xmm0-7` + right-to-left 8-byte stack slots, `al` carrying the number of xmm regs, 0x400000 flat images (RIP-relative loads), its own 64-bit encoder (`-target x86_64`; the aliases `x86-64`/`amd64` point here) |
| **x86** | i386 cdecl, emits GAS assembly (aliases `i386`/`i686`) |
| **RV32I** | emits RV32I assembly, and has its own flat-image assembler and object path (`arkcc -target riscv32 x.c -o x.bin` writes a whole image at 0x08000000; `-c`/`-link` produce machine-code objects that are concatenated, with no external `as`/`ld`) |

For the x86-64 ABI model, the four silent wrong answers fixed this round, the two deliberate
behaviour changes on i386 and the known-defect list, see
[docs/X86_64_BACKEND.md](docs/X86_64_BACKEND.md).

**The backends do not share one capability table: `stdarg.h` has two incompatible recipes.**

All four backends support variadic function definitions, but the **shape** of the argument mirror
differs, and driver-injected macros make `stdarg.h` pick one:

| Backend | Recipe | Layout |
| --- | --- | --- |
| C / x86 / x86_64 | 8-byte slots (default branch) | one 8-byte slot per argument, numbered by index, advance a `long long *` |
| ARM Thumb-2 | `__ARK_VA_WORD_SLOTS` | one 4-byte word per AAPCS argument word; `va_start` points at the first variadic word; a 64-bit argument is two adjacent words, so round the pointer up to 8 bytes before reading (absorbing the hole the caller left for an even register pair / 8-byte stack slot) |
| RV32I | `__ARK_VA_WORD_SLOTS` + `__ARK_VA_PACKED_WORDS` | same, but this backend's argument words have **no alignment holes** (a0..a7 are flat), so it does not round to 8 |

ARM's va area **is the caller's own argument mirror, not a copy of it**: the variadic function's
prologue pushes "the registers that may still hold variadic arguments" ahead of the saved
registers, so those words land exactly below the caller's stack-argument block, forming one
continuous run of words with it — word j of the area is r_(k+j), followed by words 0, 1, 2… of the
caller's stack-argument block. `k` is the first register number that may hold a variadic argument,
taken as `NCRN` rounded **down** to an even number:

| Named argument words (NCRN) | Prologue push | Cost per call | Epilogue |
|---|---|---|---|
| 0 or 1 | `PUSH {r0,r1,r2,r3}` | 16 B | `POP {..,lr}` + `ADD sp,#16` + `BX lr` |
| 2 or 3 | `PUSH {r2,r3}` | 8 B | `POP {..,lr}` + `ADD sp,#8` + `BX lr` |
| 4 (including "a named argument already on the stack") | nothing | 0 B | ordinary `POP {..,pc}`, stack-argument base back to `local_size+16` |

Rounding `k` to even has four reasons: the area base is always `frame + local_size + 16` (because
`sp_entry = base + pushed bytes`), so zero-copy still holds; "round ap up to 8" and "even AAPCS
argument word count" are equivalent for any even `k` (word j is at `base+4j`, which is 8-aligned iff
`(j-k)` is even, i.e. `k+j` is even); the pushed byte count is a multiple of 8, so `sp` keeps the
AAPCS 8-byte alignment (an odd `k` still walks the area correctly but leaves the frame top at 4 mod
8, which can break an 8-byte local or a gcc-compiled callee); and at `k=4` not a single byte needs
pushing. Stack arguments still have **no ceiling** and need no copy loop. `_ark_va_ptr` is not a real
variable: in `IR_PUSH_GLOBAL` the backend computes `frame + local_size + 16 + 4*slot` straight into a
register (`slot` being the starting word of the variadic argument in the area).

RV32I passes arguments only in a0-a7, so its va area is the 8 words at the **bottom of the frame**
(`s0 - sp_size + 4*k`, inside the 256-byte margin `sp_size` already reserves, costing no extra
stack), and `_ark_va_ptr = s0 - sp_size + 4*named-argument-words`.

**Structs crossing `...`: inlined by word, no address pushed.**

Named parameters wider than 8 bytes use this compiler's own convention (push one address word and
let the callee's `IR_GETARG` memcpy it into its own frame) — the callee sees the type, so a bilateral
convention is enough. Variadic arguments are not like that: **the callee has no type**, and
`<stdarg.h>` only walks consecutive argument words, so the payload itself must be on the wire. AAPCS
does not leave an indirection layer for this case either, and gcc inlines it too (measured:
`f(1, s12)` lands in r1,r2,r3). At the call site the struct is pushed word by word,
`ceil(size/4)` words (word 0 on top, consistent with "arg0 is above arg1"), and `aapcs_assign()`
assigns arguments wider than two words **word by word** — as many as fit go into the remaining
registers, the rest go on the stack (measured with gcc: a 12-byte struct after three named words is
r3 + two stack words, not the whole struct on the stack). The struct address is computed once
(`IR_DUP`/`IR_SWAP` keep it on the stack top and a final `IR_POP` drops it), so the call in
`f(1, mk_s3())` happens only once. Structs of 5..8 bytes keep the old two-word rule (even register
pair / 8-byte stack slot).

This is **ARM only**: RV32I has no stack arguments, and C/x86_64 use an 8-byte slot mirror where
inlined words would be read as something else, so `irgen` errors out there
(`passing a 12-byte structure through '...' is implemented for the arm target only`) instead of
producing a silent wrong value.

One **known deliberate deviation**: for a 16-byte, 8-byte-aligned struct (`struct {long long a,b;}`)
gcc rounds NCRN up to even before placing it; we do not — because `<stdarg.h>` can only judge
alignment by `sizeof` (`_Alignof` is implemented now, but `<stdarg.h>` still uses `sizeof == 8`, and
the call side does not round NCRN either, so this cell still has no alignment information) and the
hole left by rounding is invisible to it, which would read it as the first word. Both sides being
arkc is self-consistent (the `struct8a` case pins this cell); mixing with a gcc-compiled callee
misaligns this cell.

**A call has at most 64 arguments** (the per-backend argument table limit). The 65th used to be
silently dropped and is now a compile error; ARM additionally limits the total to 192 argument words
(also an error when exceeded, no silent truncation).

> This section used to be an 8 KB image area (`frame+8000..8127`) that copied the stack arguments
> into the frame on every variadic call. It passed every execution test and yet **could not run on
> the target board at all**: the on-board small-program task stack is only 4 KB
> (`APP_TASK_STACK_SIZE`) and an 8 KB frame overflows immediately. `run_va_gate.py` now asserts the
> **frame size** of every case too (`FRAME_CAP = 1024`), so "it runs" cannot get past this class.

All of this has been **executed**, not merely "emits assembly": `examples/run_va_gate.py` hands the
same source to gcc (to obtain the expected value) and to arkcc → GNU as → unicorn (to really run
it), then compares exit codes. It covers all-register arguments, register+stack, 64-bit in a
register pair, 64-bit on the stack, the **boundary** case where a 64-bit argument after three named
words is forced onto the stack by an odd register, 64-bit reads in both slimmed area shapes (8 bytes
/ 0 bytes), a long named integer forcing the whole tail onto the stack, `double`, and a `float`
argument promoted to `double` per the default argument promotions. There is also a case with 34
argument words (30 on the stack) pinning "no ceiling on stack arguments".

Five tiers in one run: `--opt-suite` runs default, `-O2`, `-fopt-regalloc`, `-O2 + -fopt-regalloc`
and `-O2 + -freg-top + -finline + -fopt-regalloc` and then aggregates the verdict. This tier is not
optional but required: `-fopt-regalloc` widens the save block from 16 bytes, the `r0-r3` mirror and
the caller's stack arguments shift up with it, and the `16` inside `va_start`'s two constants
(`local+16+…`) stops being true — without the shift, the near tier measured
`20 passed / 29 failed`, all of them numeric errors.

Every case also has to pass three static assertions, none of which depend on an external toolchain,
so the on-board path is watched too:

- **Frame size** (`FRAME_CAP = 1024`): consecutive `SUB sp, sp, #N` are **summed** per function
  before comparing. Earlier the code took "the single largest value", and a big frame is split into
  `4095+4095+810`, so a 9000-byte frame was recorded as 4095 and passed easily — this now has a
  self-check (the self-check plants a fake 9000-byte function).
- **Frame alignment**: every function's prologue (`PUSH…` + `SUB sp`) must add up to a multiple of
  8. It exists to catch changes like "pushing one word less looks free".
- **Area shape**: `int f(int a, ...)` must `PUSH {r0,r1,r2,r3}`, two/three named words must
  `PUSH {r2,r3}`, four named words must push **nothing**. Two further assertions check encodings and
  call results: the bytes of `POP {..,lr}` must be exactly `e0b5 bde8 e040 7047`, and calls to
  declared-but-undefined `extern void`/`extern long long` must push the right number of words.

What is left on RV32I is that backend's own boundary, not something va-specific: it passes arguments
only in a0-a7 (no stack arguments), so "more than 8 argument words" is **explicitly rejected**
(`stack arguments are not implemented`) instead of silently leaving a wrong value as before. 64-bit
arguments and 8-byte values in variadic arguments are genuinely two words (low word pushed first,
high word on top), unaligned 1/2/4/8-byte access through a `__packed` pointer is always byte-wise,
and aggregates >8 bytes crossing `...` are spread over consecutive argument words, where reading them
back uses an `IR_LOAD_IDX` offset that is an **element index**, scaled by the backend per element
width.

**Variadic calls and the `__asm` form**: `__asm int printf(const char*, ...)` — a declaration with
`...` whose body is a whole block of assembly — does not go through the va area (`is_asm_func`) and
works as before on all four backends. A `float` argument to a variadic call is promoted to `double`
per C99 6.5.2.2p6 first (`irgen` emits `IR_F2F`), so parameter widths are counted as 8 bytes.

### Runtime library dependencies: which symbols must come from outside

The backends **no longer carry** any AEABI soft-float / 64-bit integer helper routines, nor RV32I
soft-float routines. They belong to the target runtime library (that is literally how AEABI is
defined) and every real toolchain ships them: `libgcc.a` in `arm-none-eabi-gcc`, `armlib` in armcc.

| What is used | ARM Thumb-2 | RV32I |
| --- | --- | --- |
| `float`/`double` arithmetic (soft-float) | `__aeabi_f*` / `__aeabi_d*` (`add/sub/mul/div`, `cmpeq/cmpgt/...`) | `__addsf3/__subsf3/__mulsf3/__divsf3`, `__adddf3/__subdf3/__muldf3/__divdf3` |
| float ↔ integer / float conversions | `__aeabi_i2f` / `__aeabi_ui2d` / `__aeabi_f2iz` / `__aeabi_d2lz` … | `__extendsfdf2`, `__fixdf*` (chained internally by the soft-float implementation) |
| float comparisons | `__aeabi_fcmp*` / `__aeabi_dcmp*` | `__eqdf2/__nedf2/__ltdf2/__ledf2/__gtdf2/__gedf2` |
| 64-bit integer multiply / divide / modulo | `__aeabi_lmul`, `__aeabi_ldivmod`, `__aeabi_uldivmod` | `__muldi3` / `__divdi3` / `__udivdi3` (`libgcc`) |
| 64-bit integer logical shifts | `__aeabi_llsl` / `__aeabi_llsr` / `__aeabi_lasr` | inlined (`slli`/`srli` per word) |
| 64-bit integer add/subtract | **inlined** (`ADDS`/`ADCS` sequence, no library) | **inlined** (`sltu` + `add`/`sub` carry chains) |
| `memcpy` | the backend carries `__aeabi_memcpy` (struct assignment/passing and array initialisation all use it) | the backend carries a same-name block |
| Hardware FPU mode (ARM `--fpu=hard`) | all the soft-float above is replaced by `VADD/VMUL/VCVT/VCMP`, no runtime dependency | none (RV32I has no floating-point extension) |

Therefore: **an image that uses floating point, 64-bit division or 64-bit↔float conversion must be
linked with the runtime library**. Omitting it does not produce wrong values — it fails at link time
with `undefined reference to __aeabi_...` / `undefined reference to __adddf3`, and that is deliberate:
these helpers were once implemented inline, and five of them measured out as **silent wrong answers**
(`__aeabi_f2iz`, `__aeabi_fdiv`, `__aeabi_uldivmod`, `__aeabi_ldivmod`, `__aeabi_dadd`; see the
comment block in `src/backend/arm/backend_arm.c`), so the whole batch was deleted, turning "computes
it wrong" into "won't link". Pure-integer programs without 64-bit division remain zero-dependency.

The same holds on the RISC-V side: `arkcc -target riscv32 x.c -o x.bin` produces an image containing
only its own code; soft-float and 64-bit multiply/divide need `libgcc` linked separately (or emit
`.s` from the built-in assembler under `-target riscv32` and hand it to a complete toolchain).

## Directory layout

```
ark c compiler/
├── include/                Public headers (arkcc_config.h/config.h/opt.h/cpu.h/scatter.h)
├── src/                    Compiler core (lexer/parser/sema/ir/irgen/preproc/config/opt/cpu/scatter)
├── src/backend/arm/        ARM Thumb-2 backend (codegen + assembler + linker + soft-float/hard-FPU + full DWARF + TLS)
├── src/backend/c/          C source backend (host-side testing)
├── src/backend/x86_64/     Two x86 backends: i386 cdecl (`x86`) + SysV AMD64 (`x86_64`)
├── src/backend/riscv32/    RV32I assembler backend
├── stdlib/include/         Bundled standard library headers
├── port/host/              PC platform layer
├── port/stm32/             STM32 platform layer (platform/flash_fs/main_stm32 entry)
├── examples/               80 test samples (.c; run_tests.ps1 runs 75 of them)
├── examples/stm32_selfhost_build/  On-board self-hosting sample (multi-source .c → app.svcm → executes on the board)
├── mdk/STM32H743_ArkCC/    Keil MDK project
├── build_stm32_armcc.ps1   armcc5 script that builds the STM32 firmware (emits arkcc_stm32.hex/.bin)
├── arkcc.cfg               Default runtime configuration (INI format)
├── Makefile                gcc host build script
├── docs/MANUAL.md          User manual (Chinese, UTF-8)
├── docs/STM32_BUILD.md     STM32 + armcc5 build manual (Chinese, UTF-8)
├── docs/DIAGNOSTICS.md     Diagnostics layer: the byte-for-byte layout contract shared with armcc (Chinese, UTF-8)
├── docs/CI.md              Continuous integration: what runs, what is skipped, and why (Chinese, UTF-8)
├── docs/ATOMIC.md          C11 _Atomic: type-level propagation, read-modify-write rejection, the two <stdatomic.h> branches and their gate (Chinese, UTF-8)
├── docs/X86_64_BACKEND.md  x86-64 (SysV AMD64) backend: registers, stack slots, relocations, execution-level gate (Chinese, UTF-8)
├── docs/MEMLINT.md         Intra-procedural memory lint (--warn-mem): boundary, trim switch, measured cost (Chinese, UTF-8)
├── docs/ENUMCHECK.md       Switch missing an enumerator (--warn-enum): criteria, trim switch, measured cost (Chinese, UTF-8)
├── docs/PASS_PIPELINE.md   Configurable pass pipeline (--pipeline / --print-pipeline): stage table, two profiles, trimming, measured cost (Chinese, UTF-8)
├── docs/UNUSEDRESULT.md    Discarded return value (--warn-unused-result): rule, spellings, trimming, gate (Chinese, UTF-8)
├── docs/MIR_CFG.md         MIR/CFG and the three whole-program checks (unreachable / unused static / recursion): invariants, verdicts, deliberate non-reports, trimming, gate (Chinese, UTF-8)
├── docs/LOOPS.md           Loop optimisations (--licm / --unroll): what moves and what does not, zero iterations, the single accepted shape, limits, gate (Chinese, UTF-8)
├── docs/TAILMERGE.md       Block-tail merging (--tailmerge): the five rules and their counter-examples, the algorithm, the two easy-to-miss points (labels, depth-0 start), three trimming layers, measured byte account (Chinese, UTF-8)
├── docs/TAILCALL.md        Tail call -> jump (--tailcall): the two convertible shapes, the seven refusal conditions, why lr must stay live, three trimming layers, gate and measurements (Chinese, UTF-8)
├── docs/DIVCONST.md        Divide by a constant -> magic multiply + shift (--divconst): why the magnitude method is correct, the three unsigned shapes and the L == 32 case, five refusals, three trimming layers, 45 gate items, an honest byte account (Chinese, UTF-8)
├── docs/XBLOCK.md          Whole-block deduplication (--xblock): why a conditional-branch tail must be refused, why targets are compared as blocks and not label ids, how label-only blocks are normalised, the rewrite shape, three trimming layers, 26 gate items, byte account (Chinese, UTF-8)
├── docs/RA_VSTACK.md       Value stack to register allocation (-fopt-vstack): why the text layer after emission, the shadow value stack and the r5/r7 pool, reference counting and the three shapes that must be materialised, seven safety rails, four rewrite rules plus one peephole, the conditional third slot r4, 23 gate items and the whole ARM execution corpus (Chinese, UTF-8, .en.md twin exists)
├── docs/VSTACK_CFG.md      A control-flow value stack (S7 pre-registration): linear scan + clear-at-boundary measured at nineteen switches as 589 pins / 471 pool-full sites, the cheap version at 0 and the full version's 1,178-instruction (9.6%) bound (so F1 cannot close it), the target model (function CFG + basic blocks + join states: a value crosses a boundary only if every predecessor agrees on register and slot), three slices (S7a read-only shadow solve reporting `retainable`/`must_spill`/`poolfull_after`/`net`; S7b new `-fopt-vstack-cfg` switch off by default with OFF IS OFF; S7c retention across calls bounded at 10 instructions, registered only), frozen criteria (S7a needs net >= 300 = 2.4% to start; S7b >= 3% to land, 1-3% registered only, < 1% revert), **S7a measured: net 220 instructions = 1.79% < 300 so the line is closed** (591 of 589 pins retainable, pool-full 471 -> 952, two independent formulas giving 220/248), with a forced block-end flush anti-false-green control, four prohibitions, and the budget/scheduling rules (Chinese, UTF-8, .en.md twin exists)
├── docs/SIZEWEIGHT.md      Continuous size/speed weight (--size-weight 0..9): the four threshold tables, 5 = the 0.9.0 constants, why there is no -Oz/-Os/-Ot, the derived macro and trimming, 31 gate items, the 80-file byte account, and the known debt "functions with parameters are never inlined" (Chinese, UTF-8)
├── docs/ADDR_FOLD.md       Addressing-mode folding (-fopt-addr): the three rules and their safety, why the two write-back forms are left out, the second run (after regalloc / vreg / slotreg / cmat, 12,795 -> 12,346), section 13 (R1b look-ahead base fold plus R0 merging a `MOV` into arithmetic: 26 flags 11,766 -> 11,666 = -100), the four-arm gate and the whole-corpus measurement (Chinese, UTF-8, .en.md twin exists)
├── docs/STRENGTH.md       Strength reduction (-fopt-strength): why one switch has two landing points, the AC5 evidence, the stage-position trap (after dce it changes inlining decisions and grows the output), folding the index scale into the addressing mode, the 18 gate checks and the whole-corpus measurement (Chinese, UTF-8, .en.md twin exists)
├── docs/CBZ_FOLD.md       Zero-compare branch folding (-fopt-cbz): the one rule and its four conditions, the offset = region - 2 derivation, the region bound and flag scan (including following B), why an out-of-range body is left alone, the second sweep (-51 instructions / -544 B, 146 -> 95 pairs), the 14 gate checks and the whole-corpus measurement (Chinese, UTF-8, .en.md twin exists)
├── docs/BRANCH_SHRINK.md  Short-branch shrinking (-fopt-branch): the measuring/decide/re-lay rounds inside the assembler, the T1/T2 ranges and the .align refusal, the trap that pass 1 must lay out final widths, the 18 gate checks (including the differential far-target test) and the whole-corpus measurement (Chinese, UTF-8, .en.md twin exists)
├── docs/IMM_FOLD.md       Constant to immediate (-fopt-imm): why it must happen at emission time, the two shapes, the encoding guard and refusal list per operator, the exclusion with --reg-top, the 33 gate checks and the whole-corpus measurement (Chinese, UTF-8, .en.md twin exists)
├── docs/PEEPHOLE.md       Stack round-trip cleanup (-fopt-peep): the four pure text equivalences R1/R3/R5/R6 (R5 = zero-displacement `ADD` to `MOV`; R6 = `PUSH {rX}` ... `POP {rY}` with `rY` never mentioned in between, i.e. one `MOV` through memory), the `ip` spelling, why volatile is not affected, why R2/R4 were dropped, the pass order with the second peephole run (-52 instructions / -108 B), the 12 gate checks and the whole-corpus measurement (Chinese, UTF-8, .en.md twin exists)
├── docs/CBRANCH.md        Branch on a comparison (-fopt-cbranch): the IR adjacency criterion, the condition-code table, the two injection points with the immediate fallback, the relation to --reg-top / -fopt-cbz, what is not folded, the 13 gate checks and the whole-corpus measurement (Chinese, UTF-8, .en.md twin exists)
├── docs/COPYPROP.md       Register copy cleanup (-fopt-copyprop): the two rules reduced from IAR's ECT family, why no liveness is needed, the "first operand is a read too" fix the emulator caught, the split of labour with peep, the 147+241 breakdown and why the old 1,141 estimate was wrong, 17 gate checks (Chinese, UTF-8, .en.md twin exists)
├── docs/LIVE.md           Liveness-driven cleanup (-fopt-live): the control-flow graph and the in/out fixed point, the L1-L4 rules, the refusal list, the four defects the tests caught (two-operand implicit read, pp_trim stripping indentation, comparing after rewriting, a directive reading the previous function's stale parse) plus the ADC/SBC three-register one, the split of labour with copyprop, the 19,112 measurement, 10 gate groups (Chinese, UTF-8, .en.md twin exists)
├── docs/CMAT.md           Constant and dead-copy deletion (-fopt-cmat): the nine M1-M9 rules and the block boundaries, the two fatal read-set mistakes the emulator caught (`MUL` reading its own destination, `STR`'s first operand being a source), why a `MOVW`+`MOVT` pair must be handled as a unit, the de-duplication rule that measured zero hits and was deleted, why M8/M9 have to build a graph while M1-M7 do not, M9's label-chain canon fold and its "every predecessor must check its push" rule, the 15,933 -> 14,131 (-11.31%) and 40,188 -> 36,126 B breakdowns, the 95-TU per-file diff (M8 571 deleted / M9 238 / 0 added), 53 gate checks (Chinese, UTF-8, .en.md twin exists)
├── docs/OPERAND_ALLOC.md  Operand allocation (S3 pre-registration, slice S3a landed, S3b closed): the family breakdown of 18,665 instructions (`[r6]` 1,879 / `[r5]` 1,414 / `MOVW`+`MOVT` 2,096 / `MOV rD,rS` 1,305 / `PUSH`+`POP` 1,791), why the text layer is measured out, slice S3a (function-level 32-bit constant cache, 657 measured repeats and an optimistic bound of 399), the real register/frame conflict with `-fopt-regalloc` and the "PUSH widening has exactly one owner" resolution, seven gates and four falsifiers, the implementation (second client / entry materialisation / relocated-pair poisoning) and the pre-existing prefix-match prologue defect it exposed, the 18,665 -> 18,506 measurement and the land verdict, and the S3b (live values across calls) opportunity measurement and closure (0 of 38 call sites still hold a pool register, only 5 genuine cross-call pairs / 0.11%) (Chinese, UTF-8, .en.md twin exists)
├── docs/SLOTREG.md        Slot-level register promotion (-fopt-slotreg): why the pre-registered shadow-register model was overturned by measurement, the delete-only R1/R2 rules and their safety argument (address escape point, volatile, function-level abstention), the root causes of the three miscompiles (indirect write through memcpy / t==3 writing r0 / STR not clearing valid), the 18,729 -> 18,665 measurement and the archive verdict at <0.5%, 7 gate groups (Chinese, UTF-8, .en.md twin exists)
├── docs/FRAME_TRIM.md     Frame trimming (-fopt-frame): drop callee-saved slots pushed but never used, then the `SUB`/`ADD sp` once the frame empties; the value is stack, not code (`PUSH {r4-r7,lr}` and `PUSH {r7,lr}` are both 2 bytes in 16-bit Thumb); 289 of 913 slots unused = 1,156 B of stack; measured -29 instructions / -84 B, bigger TU 0; includes the base_used bail, the sp bail and the 2026-11-25 stack-balance guard (two miscompiles: synthesised padding nobody removed, and an unmatched `PUSH {r0}` on a branch; the guard is now three-way, and `keep_base` keeps trimming whenever every return path can rebuild sp with `MOV sp, base`; net +24 instructions / +456 B over the pre-fix baseline, with 0 functions left unbalanced-and-baseless across the corpus) (Chinese, UTF-8, .en.md twin exists)
├── docs/VOLDBM.md         Volatile frame barriers (-fopt-voldmb): the `DMB SY` pair around a frame-local volatile access is pure overhead when the address never escapes; escape analysis keyed on the object name carried by `IR_PUSH_ADDR`, whole-function fallback when unattributable; 138 of 139 DMBs come from `__IO` locals; measured -170 (-1.38%) / -616 B (-1.88%), bigger TU 0, 16 gate checks (Chinese, UTF-8, .en.md twin exists)
├── docs/VOLMEM.md         Volatile access mark and barrier (the mark is always on at zero cost, only `-fopt-volbar` adds barriers): the C11 6.5.2.3p3 layer "the base object is a volatile aggregate" was dropped by the lvalue paths, so globals, members, dereferenced pointers and bitfields carried no `IR_AUX_VOLATILE` and an IR-only pass was entitled to fold them -- the wrong-answer risk; every site is marked now (95 TUs byte-identical to before); the barrier is still off by default (a single ARMv7-M core does not reorder Device accesses, ARM ARM B2.3.7, and armcc/armclang/IAR/GCC emit none), because forcing it costs +41.0% (12,113 -> 17,081) and 1 -> 2,848 `DMB` and would destroy the beat-armcc size goal, so it lives behind `-fopt-volbar`; 24 gate checks (Chinese, UTF-8, .en.md twin exists)
├── docs/CONSTCOND.md     Deciding a branch whose condition is a literal (`-fopt-constcond`): the front end really builds `if (0)` / `while (0)` / `do {} while (0U)` (the HAL lock macros) / compiled-out `assert_param` into `PUSH_INT k` + `JZ`, and deciding it is pure bookkeeping (net stack effect is zero, `k` is an IR literal), so the pass rewrites the branch and turns `PUSH_INT` into `NOP` at the IR layer, placed before `ir.dce` so the newly unreachable code is swept in the same pass; measured on 95 TUs at `-O2`: 12,113 -> 12,034 (-79 instructions / -0.65%) and 403,432 -> 401,949 B (-0.37%), 12 TUs changed and none grows; the remaining 37 `MOV #imm` + `CMP #0` sites are classified as boolean materialisation / shift guards rather than literal conditions; 19 gate checks, crop 23/23 (Chinese, UTF-8, .en.md twin exists)
├── docs/BOOLMAT.md     Boolean materialisation removal (`-fopt-boolmat`): a comparison result is already 0/1, so `x != 0` is the identity and `x == 0` is the complement, and the IR layer drops the redundant materialisation so that `-fopt-cbranch` / `-fopt-imm` can take over; three rules R1 frame round trip / R2 identity / R3 complement (which steps aside when a branch follows); measured on 95 TUs at `-O2`: 12,266 -> 12,146 (-120 instructions) and 405,833 -> 403,994 B (-1,839 B), 8 TUs shorter and none larger; the remaining 40 `ITE` sites are classified as a CFG-level join materialisation problem from short-circuit evaluation (`A||B` / `A?1:B`); 18 gate checks, crop 24/24 (Chinese, UTF-8, .en.md twin exists)
├── docs/COALESCE.md       Local copy coalescing (-fopt-coalesce): rule L5 of `-fopt-live`, the stop table and the three in-stretch decisions, why handling only "dead after last use" almost never fires, the wrong answer caused by `BL`'s implicit reads/writes eating an argument, the 18,509 -> 18,151 measurement (-1.93%, no TU grows), 7 gate groups, cropping and the three registered not-done items (Chinese, UTF-8, .en.md twin exists)
├── docs/EXIT.md           Dead frame maintenance at the exits (-fopt-exit): a body that never touches sp reaches every return with sp still equal to the frame base, so `MOV sp, base` writes a value the register already holds, and when the base is never read as a base the prologue's `MOV base, sp` goes too; pure deletion (no labels, no branch targets, no frame size), the epilogue's `ADD sp, sp, #N` and every return `POP` are kept, and a body that does adjust sp (VLA / alloca / inline assembly) is refused whole; measured on 95 TUs at `-O2`: 12,146 -> 11,913 (-233 instructions / -1.9%) and 403,994 -> 400,499 B (-3,495 B), 18 TUs shorter and none larger; E1 fires on 139 of 166 framed functions and E2 on 48 more; 18 gate checks, crop 25/25 (Chinese, UTF-8, .en.md twin exists)
├── docs/BITMASK.md        Direct encoding of a negated mask (-fopt-bitmask): `~constant` is built as `MOV rX,#imm` + `MVN rX,rX` and the `AND`/`MOV` right behind it only consumes the result, so both collapse into one `BIC rD,rD,#imm` / `MVN rD,#imm`; three preconditions (three adjacent lines, an `imm` that `thumb_imm12_a` can encode, a strict two-operand consumer with `rX` dying after it), the liveness proof (forward scan, labels crossed, `POP` treated as a write, unconditional branches followed for 4 hops); placed after `-fopt-cmat` and before `-fopt-litpool`; measured on 95 TUs (25 flags + `-fopt-exit`): 11,877 -> 11,766 instructions and 400,125 -> 398,673 B (-111 / -1,452), byte-identical to the baseline with the flag off, 0 failures and 0 larger TUs; 61 folded sites (`BIC` 35 / `MVN` 26); the `MVN`/`BIC` immediates checked byte-for-byte against GNU as (including the odd rotation `0xD0000 = 0xD0 ROR 20`); 18 gate checks, crop 26/26 (Chinese, UTF-8, .en.md twin exists)
├── docs/VREG.md          IR-level virtual register allocation (S6, `-fopt-vreg` implemented, off by default: S6a point elision 18,151 -> 17,736 = -415, S6b whole-block renaming 18,151 -> 17,350 = -801 / -4.41%): the 3.2-3.4x gap against armcc 5,629 / armclang 5,068, why the text layer is measured out (3,213 frame accesses + 1,120 scratch copies + 741 `PUSH {r0}` = 28% is the direct cost of one assumption, that a value must cross memory or r0), the target model (vregs + linear scan + `r0-r3`/`r8-r11` pools, `r6` kept as the frame base, mutually exclusive with `-fopt-vstack`), slices S6a-S6d (S6a targets -8%, >= 1,450), the 7 frozen gates and falsifiers F1-F4, the pre-implementation negative measurements (§10: default regalloc is a no-op, near +23, MOV replacement is byte-negative, upper bound 1,714 lines = 9.4%, S6a revised to "slot cache + rename elision"), cropping via `ARKCC_FEATURE_VREG`, §11 measured result (S6a 17,736, 13 TUs, largest hal_dma -181, six gate checks green) and the registered `-fopt-vstack` six-argument defect, §12 S6b whole-block renaming (17,350, -4.41%, 14 TUs and none grows, eight gate groups green, four real defects: assembler high-register truncation / two-operand shift operand roles reversed / `vg_reads_reg` cannot tell write from read-modify-write / in-place renaming overwrites live text), §13 S6c crossing a call (`vg_lk=5` / `saved_mask` / `dr>=4`; the new `crossbl` fixture returned a wrong answer on its first run and exposed two defects -- a load deleted with zero renames in the region, and three implicit readers: call arguments, `PUSH` lists, the returned `r0`; after the fix, seventeen switches 14,954 -> eighteen 14,271 / 36,114 B (section 14 adds the `vg_hi_mask` fix and its +53-instruction price, section 15 the S6b-2 inter-block upper bound of 266 = 1.96% and its F1 closure), with the earlier -415/-801 honestly qualified as partly bought with wrong answers), and the written non-promise (does not reach 5,629; S6a+S6b targets 12,700, -30%) (Chinese, UTF-8, .en.md twin exists)
├── docs/DEADSTATIC.md    Unreferenced `static` functions are no longer emitted (on by default, no switch): the reachability fixed point and its five edge kinds, the never-dropped list and the entry-point names, the inline-asm text scan and its loud-failure boundary, 95 TUs 18,151 -> 16,414 (-9.57%, 15,613 / -13.98% with vreg), 24 gate checks and two escape hatches (Chinese, UTF-8, .en.md twin exists)
├── docs/MOVIMM.md         Constant materialisation: the five classes (0..255 / MOVW / modified immediate / MVN / two-word) and their flag behaviour, why MOVW needs no following `MOVT #0`, the unsigned immediate parser, the same-tree measurement at `-O2` (-451 instructions, 51,416 -> 50,965; -1,804 bytes, 116,380 -> 114,576), the gate (Chinese, UTF-8, .en.md twin exists)
├── docs/LITPOOL.md        32-bit constants in a literal pool (-fopt-litpool): the `4(c-1)` profit model, why it must be a text pass after cmat, the new assembler form `LDR rd, <label>` and its fixed 32-bit encoding (an error, never a truncation), region cutting at terminators with the 800-instruction merge cap, why only unconditional forms count, the five refusals, the ~108 KB static tables and the on-board crop, 14,271 -> 13,566 with the 807/96/0/711/705 pair audit, the `-2,820+1,436+250=-1,134` byte bill and the 21 gates (Chinese, UTF-8, .en.md twin exists)
├── docs/BUILD.md          Building on Windows / Linux / the STM32H743: toolchain matrix, the two memory layouts measured, the machine verdict from `make stm32-check`, all 23 `-fopt-*` flags refused by name after trimming (23/23), and the honest per-platform verification status (Windows verified / H743 verified / Linux not verified) (Chinese, UTF-8, .en.md twin exists)
├── docs/COMPARISON.md     Side-by-side with armcc / armclang: corpus and method, the nine-row result table and the ratios, the ten optimization switches, the four structural reasons with per-item measurements, the reproduction scripts, three things it must not be read as (Chinese, UTF-8, .en.md twin exists)
├── docs/GCC_BASELINE.md  The gcc baseline (measured 2026-11-25; the yardstick changes): the three-way measurement table (arkc 26 flags 11,666 / 396,986 B, armcc `-O2` 5,619, gcc 13.2.1 `-O2` 4,469 / 174,119 B, gcc `-Os` 4,303) => **gcc is 20% better than armcc, so the first opponent becomes gcc (2.61x)**, the per-TU table (18 non-empty TUs, `hal_dma_ex` 8.05x), the one file that is 23.5% of the corpus and its per-function table (`HAL_DMAEx_MultiBufferStart_IT` 2,632 vs gcc 292 = 9.0x; the excess is 32.5% of the whole gap), the root cause (five `__HAL_DMA_CLEAR_FLAG` statements expand to 2,409 instructions = 91.5% of the function; each = 4 outer arms x 13-way pointer chain = 52 comparisons, each reloading `hdma`, `hdma->Instance` and the constant address plus two dead copies; gcc hoists into r4 once and steps with `adds` on a 0x18 stride), the instruction census, and the acceptance of the first slice (that function <= 1,400, whole corpus >= 5%, OFF IS OFF byte-identical, four execution arms) (Chinese, UTF-8, .en.md twin exists)
├── docs/BOUNDARY.md       The structural boundary against armcc, honestly accounted: 2.19x instructions / 2.35x bytes (12,304 vs 5,619, 32,690 vs 13,920), the three-arm instruction mix, the gap decomposition (4,303 of 6,685 = 64.4% is "value transport"), the three structural causes (value stack / every value through r0 / addresses recomputed), what is left to win (constant pool done at -705 instructions / -1,134 B, `PUSH {r0}` 487, repeated materialisation 1,198 (measured upper bound 297 = 2.41%), reg-reg copies 1,506 (upper bound only 208 = 1.63%) -- both closed under F1), the second liveness run (13,566 -> 13,116 after litpool), R5 plus the second peephole run (13,116 -> 12,795), the second addressing fold (12,795 -> 12,346), R6 plus `ip` (12,346 -> 12,304), the 26-flag closure at 11,666 / 396,986 (2.08x, the address-fold gap paid for 100 more), the finished list and the non-promises (Chinese, UTF-8, .en.md twin exists)
├── docs/RA_MODEL.md        Code-generation model change (0.9.2 pre-registration; S8a is done as a text-layer proxy and came back `ceiling_insufficient`): the per-category 26-flag gap (now 11,666 vs 5,619 = 2.08x; MOVREG/PUSHPOP/FRAME/MOVIMM add up to +4,844 = 78.8%), the evidence that the text layer is measured out (nine residual shapes totalling 167 instructions = 1.42%) plus the address-fold gap (189 candidates, 100 paid, residue zero), the correction that the IR is a pure stack machine (`IrInst` has no vreg field and there is no IR dump, so the planned `nvreg`/`pmax`/`spill_est`/`cov` are not implementable -- not unrun, unrunnable), the S8a ceiling table (L1 133 / L2 32 / L3 718 / result redirection 266 / pool idling <= 636 = <= 1,785 = <= 15.2%), criteria reset on the measurement (eating all of it still gives 1.78x; the in-block realisable part is 3%-6%) => S8b/S8c are not implemented, `-fopt-ra-model` is not added, and the entry for going further is the expression-evaluation model (Chinese, UTF-8, .en.md twin exists)
├── docs/EXPR_MODEL.md      Expression evaluation model (the next entry after 0.9.2 pre-registration; S9a done): 26 flags 11,666 vs 5,619 = 2.08x, the four value-transport classes 4,606 = 39.5% (overrun 3,802 = 32.6%), the two measured `r0` families (`MOV rD,r0` 428 sites, 314 of them right after an instruction writing `r0`; `MOV r0,rX` 305 sites, 124 followed by an instruction reading `r0`), the ceiling (all 3,802 eaten => 7,864 = 1.40x; another 500-700 => about 7,200 = 1.28x), slices S9a/S9b (`-fopt-expr`, `ARKCC_FEATURE_OPT_EXPR`, host 1 / board 0, off by default)/S9c, frozen criteria (>=10% lands / 5-10% registers / <5% withdraws; **S9b implemented and measured at -16 instructions = 0.137%, withdrawn per the criterion, see §9**), §10 S10 preregistration (cross-block stack round trips: 355 dead stores = 3.0%, ~140 live pairs, ceiling 591 = 5.1% => 1.97x; criteria >=4% lands / 2-4% registers / <2% withdraws); **§10.5: S10 shipped as `-fopt-spill` (off by default), and the 5.1% ceiling was refuted by the CFG analysis -- only 3 real dead stores, 331 deletable lines = 2.90% (-4,604 B = -1.17%) => registered in the 2-4% bucket**, three anti-false-green controls and four forbidden moves ; **§11: S12-1 shipped as `-fopt-ldhoist` (off by default), 26 flags 11,044 -> 10,917 = -127 / -1.15% (-2,612 B), the register tier under the frozen three; the gap to the 270 bound is attributed to cross-region repeats counted by the bound script and to `CMP Rd,#imm` being excluded by the frozen rule 5 (registered as the next slice's candidate only)**; **§16: S14 gives user inline assembly a per-function exemption (fixing the §15.6 wrong answer: a function that contains any `__asm` skips the whole text pipeline, `ark_fix_far_offset` still runs); each of the 29 flags alone and all of them together leave the asm-bearing function byte-identical, the exemption costs nothing on the corpus (10,691/381,202, byte-identical to S13), `make test-userasm` runs 5 checks, and `run_ldhoist_tests.py` had to switch its trigger arm to a real HAL TU because the inline-asm fixtures went dead -- 18 checks)**(Chinese, UTF-8, .en.md twin exists)
├── docs/SLOT_REGISTERS.md Slot-level register residence (S2 pre-registration, not implemented): why the text layer has only <=0.7% left, the counter-evidence that both `-fopt-regalloc` modes are a 1:1 reshape on the HAL, the per-block shadow-slot cache state machine (clean/dirty), the cost rule (F+W)-(R+S), the seven frozen gates, the four falsification conditions, and the stacking requirement against `-fopt-vstack` (Chinese, UTF-8, .en.md twin exists)
├── docs/IPO_LTO.md         Whole-program compilation (--ipo / -flto) and cross-TU constant propagation (--const-global): why it is not object-level LTO, merge semantics, refused combinations, cropping, gates (Chinese, UTF-8)
├── docs/OBJ_IR.md         An IR payload in the object and link-time recompilation (--obj-ir / -link --lto): payload format, pool remapping on merge, byte equivalence, refusals and diagnostics, cropping, gate (Chinese, UTF-8)
├── docs/PARTIAL_LINK.md   Partial link (-r): machine code wins, symbol/relocation rebasing, data never moved, three refusals, substitutability and idempotence, cropping, gate (Chinese, UTF-8)
├── docs/BOARD_VALIDATION.md  On-board full validation (the 0.9.0 criterion): 54 cases x three levels, measured readings, the gate's own self-check and every root cause (Chinese, UTF-8)
├── docs/FLOATLIT.md        Exact conversion of floating literals (one rounding): the two 1-ulp wrong answers, the three mid-way roundings in the old code, the 2304-bit fixed-point bignum and the binary long division by 5^k, the prec=53/24 split and why an `f` suffix never goes through double, the honest 400-digit / 100000-exponent limits, the 1,464 B of board `.bss` and zero stack, the 419-case gate (three anti-false-green checks) and the 178,549-case independent cross-check, and the byte-identical 95-TU corpus (Chinese, UTF-8, .en.md twin exists)
├── docs/从零写一个C编译器.md  Textbook-style walkthrough: 19 chapters, from 30 lines to 30 000 (Chinese, UTF-8)
├── docs/from-scratch-c-compiler.en.md  English summary of that textbook (structure, chapter map, reading routes)
└── README.md               Project overview (Chinese, UTF-8)
```

English translations of the documents live next to their Chinese originals as
`docs/X.en.md` (`docs/X.md` stays Chinese); `README.en.md` is the English counterpart of
`README.md`. Each pair carries a one-line language switch at the top. Every document is covered this
way except the 8 740-line textbook, which has an English summary
([docs/from-scratch-c-compiler.en.md](docs/from-scratch-c-compiler.en.md)) rather than a full
translation.

## Building

### Option 1: gcc build (host development and testing)

```bash
make            # produces arkcc.exe
make test       # compiles examples + runs the reloc-text / stdlib / install / x86-64 gates
make clean
```

The same `Makefile` builds on Linux with `make CC=gcc` (the non-Windows branch
switches the output name, `RM` and the null device by itself). To run the trimmed
profile on the H743, `make stm32-check` makes armlink answer "does it fit" against
the real board memory (it needs armclang/armlink/fromelf and prints `SKIP` loudly
when they are absent). Three platforms and the trimming ladder: [docs/BUILD.md](docs/BUILD.md).

### `make install` (DESTDIR / PREFIX)

```bash
make install                                      # installs into PREFIX (default /usr/local)
make install PREFIX=$HOME/arkcc                    # different installation root
make install DESTDIR=/tmp/stage PREFIX=usr/local   # staging for packaging (files land in /tmp/stage/usr/local)
```

The resulting layout:

```
$PREFIX/bin/arkcc[.exe]        the compiler
$PREFIX/include/ark/*.h        22 standard headers
$PREFIX/lib/ark/src/*.c|*.s    library sources (not pre-compiled: which runtime an image needs is decided by the linker)
$PREFIX/lib/ark/src/arm/*      AEABI / setjmp assembly for flat ARM images
$PREFIX/lib/ark/README.md      how this library should be compiled for a given target
```

Three hard rules: **`DESTDIR` is a staging root and `PREFIX` must be a relative path inside it**
(passing `DESTDIR` together with an absolute `PREFIX` is an immediate error — otherwise
`os.path.join()` silently drops `DESTDIR` on Windows and the files are installed directly into
`PREFIX`); **no file is ever deleted**, only overwritten when its contents differ; and **every
installed file is read back and compared byte for byte**, failing on any mismatch. Re-running
`make install` does not re-stamp any file (all 38 mtimes stay identical), and `--dry-run` writes
not a single byte.

> Git Bash / MSYS rewrites `/usr/local` into `C:/…/PortableGit/usr/local` before the script ever
> sees it, so in such shells either use Windows-style paths
> (`make install PREFIX=C:/ArkCC`) or
> `MSYS_NO_PATHCONV=1 make install DESTDIR=/tmp/stage PREFIX=usr/local`.

### Option 2: armcc5 build (produces the STM32 firmware)

```powershell
# requires Keil MDK 5.x, with armcc.exe on PATH or under D:\Keil_v5\ARM\ARMCC\bin
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
# output: bootstrap_x86\armcc_objs\arkcc_stm32.{elf,hex,bin}
```

See [docs/STM32_BUILD.en.md](docs/STM32_BUILD.en.md) for details.

## Command line

```
arkcc <file.c|file.s> [options]
  -o <file>          output file
  -S                 emit assembly text only
  -c                 compile only, do not link (.ark_obj, ARKOBJ2 container)
  -E                 preprocess only
  -link a.o b.o      link several .ark_obj files (if more than one carries .data/.bss you get an SRAM overlap error)
  -v                 verbose
  -target <name>     arm | x86_64 | x86 | riscv32 | c (default arm; x86_64 is the real SysV AMD64
                     backend, i386 is an alias of x86, x86-64/amd64 are aliases of x86_64)
  -I <dir>           header search path
  -O0/-O1/-O2        optimisation level (0 = none, 1 = basic constant folding + DCE, 2 = aggressive)
  -g                 emit DWARF debug information
  -config <file>     load an INI configuration file (default arkcc.cfg)
  -f<feature>        enable a feature (vla/complex/wchar/trigraph/fpu/dwarf/...)
  -fno-<feature>     disable a feature
  -Wno-unused        suppress unused warnings
  --list-backends    list backends

  Diagnostics
  --diag_style <s>   arm (default) | gnu | ide | modern; modern is the clang shape (alias: clang)
  --errors <file>    write the whole diagnostic stream to a file (same as armcc)

  Target CPU selection
  -mcpu <name>       Cortex-M3/M4/M7/M33 etc.
  --cpu <name>       armcc-style synonym
  --thumb            force Thumb mode
  --arm              force ARM mode
  --fpu <type>       soft/hard (soft-float / hardware FPU)

  Dependency generation
  -MMD               emit a .d dependency file (like gcc)
  --depend           same as -MMD
  -MF <file>         set the dependency file name

  Sections and code generation
  --split_sections   one section per function (.text.<fn>)
  -ffunction-sections same as --split_sections

  Language compatibility options
  --dollar           allow `$` in identifiers
  --enum_is_int      force enum's underlying type to int
  --signed_chars     char is signed by default
  --unsigned_chars   char is unsigned by default
  --wchar16          wchar_t is 16 bits
  --wchar32          wchar_t is 32 bits

  DWARF version
  --dwarf2           DWARF v2
  --dwarf3           DWARF v3

  Added in the current round (all off by default; without the option the output is byte-identical to the previous release)
  --reloc-data       relocate data sections across objects (without it, several objects sharing a global
                     still report an SRAM overlap)
  --reloc-text       fix up absolute in-section addresses at link time (code addresses inside
                     MOVW/MOVT, string literals, …; required for multiple objects or whenever the image
                     is loaded somewhere other than the address it was compiled for, otherwise the
                     old base address is read)
  --rt-lazy          emit runtime helpers on demand (only reachable blocks)
  --reg-top          keep the IR stack top resident in r0
  --asm-extra        assembler extended instruction set; --no-asm-extra turns it off explicitly
  --warn-mem         intra-procedural memory lint (address of an automatic
                     object / double free / use-after-free / address stored into
                     static storage / constant subscript out of bounds);
                     --no-warn-mem turns it off
  --warn-enum        when a switch controls on an enum and has no default, check
                     that every enumerator is named; --no-warn-enum turns it off
  --pipeline=<p>     pipeline profile: full (default; every stage still decides
                     with its own flag and -O level) or lite (drops dce-cfg /
                     inline / vectorize and says so)
  --print-pipeline   print each stage's decision: run, or skip plus the reason
  --warn-unused-result  warn when a call discards the value of a function declared
                     warn_unused_result / __must_check; a (void) cast is explicit
  --warn-unreachable code no path from the function entry can reach
                     (--no-warn-unreachable turns it off)
  --warn-unused-static  a static function with no caller and no taken address
                     (--no-warn-unused-static turns it off)
  --warn-recursion   a call cycle in the call graph, self recursion included
                     (--no-warn-recursion turns it off)
  --licm             hoist loop-invariant computation into a frame temporary and
                     leave the store in place (needs -O1 or higher;
                     --no-licm turns it off)
  --unroll           completely unroll a canonical constant-bound for loop
                     (limit ARK_UNROLL_MAX, default 8); --no-unroll turns it off
  --tailmerge        block-tail merging: when several basic blocks end in the
                     same instruction run, keep one copy and branch to it from
                     the others (needs -O1+; --no-tailmerge turns it off).  Only
                     depth-0 tails are merged; an unprovable depth model
                     abandons the whole function
  --tailcall         tail call becomes a jump: when every argument of
                     `return g(a);` fits in r0-r3 and the value is handed back
                     unchanged, tear the frame down and emit `B g` instead of
                     `BL` (two frames become one).  Refused: stack arguments,
                     indirect calls, struct/_Complex results, __naked, __irq,
                     variadic; --no-tailcall turns it off (off by default)
  --divconst         divide by a constant becomes a magic multiply + shift:
                     when the divisor of x / 3 or x % 8u is known at compile
                     time, SDIV/UDIV becomes UMULL plus a shift (powers of two
                     collapse to LSR / AND). Divisors 0, 1, -1 and a signed
                     2^31 keep the real divide. The image usually gets bigger;
                     only the unsigned 2^k shapes shrink. --no-divconst turns
                     it off (off by default)
  --xblock           whole-block deduplication: when two basic blocks are
                     instruction-for-instruction identical, enter with an empty
                     evaluation stack and leave through one jump/return that
                     names its destination, one copy stays and the others
                     become jumps to it (needs -O1+; --no-xblock turns it off).
                     Refused: conditional-branch tails, bodies leaving to
                     different blocks, bodies below 4 instructions, inline asm
  --size-weight=N    continuous size/speed weight (0..9, default 5): moves the inline
                     ceiling, the unroll ceiling and the tail/block merge minimum lengths
                     at once. 0 favours speed, 9 favours size; the four entries at 5 equal
                     the 0.9.0 constants, so not writing it is byte-identical to 0.9.0
  -fopt-vstack       keep value-stack temporaries in r5/r7 (plus r4 when deep enough): PUSH/POP pairs collapse,
                     the producer's destination is retargeted and read-only operands are
                     rewritten to pool registers.  Slots are reference counted, read+write
                     in one operand / read in one and written in another / the in-place
                     ADC/SBC/MUL forms are materialised first, MOVW/MOVT never retargeted;
                     anything unrecognised leaves the function untouched.
                     -fno-opt-vstack turns it off (off by default)
  -fopt-addr         addressing-mode folding: fold an address computed by ADD/MOV
                     into the LDR/STR addressing mode (constant offset, register index)
                     and drop the redundant arithmetic.  The folded register must not be
                     read again later in the function; barriers are let through; the two
                     write-back forms are never emitted so they are not implemented.
                     -fno-opt-addr turns it off (off by default)
  -fopt-strength     strength reduction: x * 2^k becomes a left shift (x*1 is dropped),
                     and the i*sizeof scale of p[i] becomes one LSL; once -fopt-addr
                     has removed the ADD, the adjacent LSL is folded into the operand
                     as [Rn, Rm, LSL #n].  Non-powers of two keep their MUL (MUL is
                     one cycle on Cortex-M4, so a shift chain is never shorter).
                     -fno-opt-strength turns it off (off by default)
  -fopt-cbz          zero-compare branch folding: CMP rX, #0 followed by BEQ/BNE
                     becomes one CBZ/CBNZ (16-bit: one instruction and 4 bytes less).
                     Only folded when the target is forward, the region upper bound is
                     <= 64 bytes, and the flags are provably dead; anything else keeps
                     its original shape.  -fno-opt-cbz turns it off (off by default)
  -fopt-branch       short-branch shrinking: a B / B<cond> whose target fits the
                     16-bit range shrinks from 4 bytes to 2 (same count, fewer bytes).
                     The assembler measures every branch at 4 bytes first and then
                     decides; a span crossing .align is never shrunk, and a branch that
                     does not fit keeps its 32-bit form.  -fno-opt-branch turns it off
                     (off by default)
  -fopt-imm          constant to immediate: a PUSH k followed by an arithmetic or
                     comparison op becomes the instruction's immediate, so the
                     constant never travels through the value stack; every operator
                     passes an encoding gate and keeps its shape if it does not fit.
                     -fno-opt-imm turns it off (off by default)
  -fopt-peep         stack round-trip cleanup: PUSH/POP becomes one MOV, an LDR
                     after a store to the same slot is dropped, and a zero-
                     displacement ADD becomes a MOV; nothing is paired across a
                     label and multi-register frame PUSHes never match; the pass
                     runs a second time on the final text.
                     -fno-opt-peep turns it off (off by default)
  -fopt-cbranch      branch on a comparison: when the next instruction is the
                     conditional jump, emit CMP + B<cond> instead of making a 0/1
                     value and testing it again; a value with another consumer is
                     left alone.  -fno-opt-cbranch turns it off (off by default)
  -fopt-pair         pair value-stack operands: two adjacent pushes and the
                     binary operator that reads them fold into left->r0,
                     right->r1 and a direct operation, removing both PUSH/POP
                     pairs and the register shuffling; constants and comparison
                     branches are left to -fopt-imm / -fopt-cbranch; 64-bit,
                     volatile and >8-byte objects are untouched;
                     -fno-opt-pair turns it off (off by default)
  -fopt-prop         propagate constants into frame slots that are written
                     once and never changed, and drop stores nothing reads;
                     a constant must fit one instruction and a read right
                     after a STORE of the same slot is left alone;
                     -fno-opt-prop turns it off (off by default)
  -fopt-deadpush     drop the read-back of a statement assignment: the read-back push
                     right after the store goes away together with the discarding pop;
                     volatile, four-word complex objects and width mismatches are left alone;
                     -fno-opt-deadpush turns it off (off by default)
  -fopt-copyprop     register copy cleanup: drop a MOV whose destination is
                     overwritten before it is read, and forward MOV rD,rS into an
                     adjacent OP rD,rD,X; nothing is decided across a label,
                     branch or PUSH.  -fno-opt-copyprop turns it off (off by default)
  -fopt-live         liveness-driven cleanup: build a control-flow graph per
                     function and solve register liveness, then drop dead copies
                     across blocks, forward a copy into its single consumer, drop
                     zero indices, and materialise MOVW/MOVT constants straight
                     into the destination; -fno-opt-live turns it off (off by default)
  -fopt-cmat         constant and dead-copy deletion (nine rules): a copy of a
                     known 0..255 constant becomes an immediate, a known index is
                     folded into the addressing mode (k<<s <= 4095), a flag-neutral
                     write overwritten before any read is dropped, a constant is
                     propagated through three-operand shifts and extends, a
                     conditional branch after a known CMP is decided here, the value
                     stack's PUSH/POP round trip goes, a constant or a copy that is
                     dead across the whole function is deleted, and the PUSH/POP
                     round trip at a join goes; MOVW/MOVT pairs are handled as a
                     unit; -fno-opt-cmat turns it off (off by default)
  -fopt-slotreg     slot-level register promotion: drop a reload where r0 already
                     holds the slot, and drop a store that is never observed (zero
                     reads in the whole function with no address escape, or
                     overwritten later in the same block); it only deletes lines
                     and never inserts, so the frame layout is unchanged;
                     -fno-opt-slotreg turns it off (off by default)
  -fopt-constcache  function-level constant cache: a 32-bit constant materialised
                     >= 5 times in one function is built once at the entry into a
                     callee-saved register (r8-r11) and the uses become MOV rD, rC;
                     it shares -fopt-regalloc's saved block, so the widening and
                     the offset shift happen exactly once;
                     -fno-opt-constcache turns it off (off by default)
  -fopt-litpool      32-bit constants into a literal pool: MOVW+MOVT becomes one
                     LDR rD, <label>; the text is cut into regions at terminators,
                     adjacent regions merge up to 800 instructions, one pool per group
                     after its terminator; .arkdata linker pairs, out-of-reach sites and
                     huge functions are left alone; -fno-opt-litpool off (default off)
  -fopt-coalesce     local copy coalescing: after MOV rD, rS rename every rD in the
                     following straight-line code to rS and delete the copy (r0-r7,
                     d != s, neither r6); stops at labels/branches/IT/writeback/register
                     lists/BL|BLX, and rD (plus rS if redefined inside) must be dead at the
                     end; the fifth rule of -fopt-live, so alone it behaves as "L5 only";
                     -fno-opt-coalesce turns it off (off by default)
  --ipo / -flto      whole-program compile: several .c files, one IR program, so
                     optimisation sees across files (cross-file inlining at -O2);
                     statics are renamed per unit, externals de-duplicated with
                     the linker's rules, unreferenced statics pruned.  Needs -o;
                     refuses -c/-E/-g/-link and .s/.o inputs
  --const-global     cross-TU constant propagation: folds loads of constant objects
                     into immediates (needs -O1+).  Only "const + scalar integer
                     initialiser + never written + address never escapes + not
                     volatile/array/aggregate/long long + no __at/section/__thread"
                     folds; anything else keeps its load.  --no-const-global off
  --obj-ir           with -c: serialise the pre-pipeline IR and append it to the
                     ARKOBJ2 object so that -link --lto can replay it;
                     --no-obj-ir turns it off.  Refuses assembly input and text
                     backends (-target c)
  --lto              with -link: read the IR back out of the objects, merge, run
                     the pipeline once and emit again -- byte-identical to --ipo.
                     Must be written before -link; refuses -c/-E/-g, a missing
                     -o and an empty input list
  -r                 with -link: merge N ARKOBJ2 objects into one new object
                     (machine code, symbol table, relocation table), not an
                     image.  -o is required; refuses --lto/-c/-S/-E/-MMD, an
                     object carrying an IR payload, two RAM owners, and
                     riscv32 mixed with non-riscv32
  --dce-cfg          basic-block reachability DCE (deletes only code that is reachable but never executes)
  --build-date <s>   pin __DATE__ (e.g. "May 28 2026")
  --build-time <s>   pin __TIME__ (e.g. "20:26:40")
  --source-date-epoch <n>
                     derive both __DATE__ and __TIME__ from a Unix timestamp (reproducible builds)
```

Build timestamp, macro-redefinition checking, scatter-layout validation and the dependency-file
limit are compile-time only (see `include/arkcc_config.h`); their defaults and behaviour are
documented in appendix D.4 "switch reference table" of
[docs/从零写一个C编译器.md](docs/从零写一个C编译器.md).

## Configuration system

arkcc layers configuration three deep, with priority **command line > configuration file >
compile-time default**.

- **Compile-time switches** (`include/arkcc_config.h`): the `ARKCC_FEATURE_*` macros decide which
  features are compiled into arkcc itself.
- **Runtime configuration file** (`arkcc.cfg`, INI format): the `[features]` section toggles
  individual features, `[general]` controls the optimisation level and debug information. The
  `arkcc.cfg` in the current directory is loaded automatically at startup; `-config <file>`
  selects another one.
- **Command-line overrides**: `-O0/-O1/-O2`, `-g`, `-f<feature>`, `-fno-<feature>`, `--dollar`,
  `--enum_is_int`, `--signed_chars`/`--unsigned_chars`, `--wchar16`/`--wchar32`,
  `--dwarf2`/`--dwarf3` override whatever the file says.

An example `arkcc.cfg`:

```ini
[features]
vla               = 1
complex           = 1
wchar             = 1
trigraph          = 1
fpu_hw            = 1
dwarf             = 1
opt_constfold     = 1
opt_dce           = 1
opt_regalloc      = 0
enum_is_int       = 0
dollar_in_identifiers = 0
split_sections    = 0
signed_chars      = 0
wchar16           = 1
wchar32           = 0
dwarf_version     = 2

[general]
opt_level   = 0
debug_info  = 0
```

## Optimisation

`-O1` and above enable the IR-level optimisation passes in `src/opt.c`:

- **Constant folding**: the triple `PUSH_INT a; PUSH_INT b; BINARY op` collapses into
  `PUSH_INT (a op b)`, scanning to a fixed point (at most 8 passes) so folding cascades.
  Division by zero and modulo by zero are deliberately left alone to preserve runtime behaviour.
- **Dead code elimination**: instructions between `RETURN/JMP/JMP_NAMED` and the next label are
  unreachable and are removed.

Each pass is guarded both by a compile-time `ARKCC_FEATURE_OPT_*` macro and by a runtime
`g_config.enable_opt_*` flag.

## Debug information

With `-g`, or `g_config.debug_info=1`, the ARM backend emits GNU-as-style DWARF directives and the
full set of debug sections into the assembly output:

- `.file 1 "<src>.c"` source-file registration
- `.cfi_startproc` / `.cfi_endproc` frame information
- `.loc 1 <line>` line mapping
- `.size <fn>, .-<fn>` function size
- `.type <fn>, %function` type annotation
- complete `.debug_info` / `.debug_abbrev` / `.debug_line` DWARF sections (`--dwarf2`/`--dwarf3`
  select the version)

## Tests

**Continuous integration**: `.workflow/main-pipeline.yml` (Gitee Go — the repository's main line
lives on Gitee, so this is the one that actually runs) and `.github/workflows/ci.yml` (GitHub
Actions, effective only when the repo is mirrored to GitHub) do the same thing: build arkcc with
the host gcc, `pip install unicorn`, then `make test`. Only gcc/make/python3 are required — no
cross toolchain, no hardware. The PowerShell gates (Windows only), `make stm32`, the differential
tests that need armcc or an ARM toolchain, and on-board self-hosting are all outside CI. What runs,
what is skipped and why is documented in [docs/CI.en.md](docs/CI.en.md).

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1   # 75 cases (71 assertions + 4 skipped)
powershell -ExecutionPolicy Bypass -File run_full_test.ps1        # full regression over 73 samples
python tests/run_stdlib_tests.py                                  # standard-library gate (compile → multi-object link → really execute under unicorn): all 21 expected values are produced by the programs themselves; the `strtod` case is SKIPped with the measured reason printed (the host emulator has no double-precision FPU — that is the emulator, not the library)
python tests/run_x86_64_image_tests.py --arkcc ./arkcc.exe        # x86-64 gate: 35 programs compiled into flat 0x400000 images and run on a 64-bit unicorn core by calling main; every expected value is computed outside the program; also includes "an unresolved symbol must be rejected without leaving an image behind" and "an expected value off by +1 must be judged DIFF" as self-checks. Every program is then compiled a second time for 32-bit i386 and run again — an i386 result that differs from the expectation FAILS the case, it is no longer treated as a footnote
python tests/run_x86_64_selfhost.py                               # x86-64 execution-level self-host gate: the host arkcc compiles its own 24 translation units, the resulting image is executed inside unicorn, and that in-image arkcc compiles a probe; the object must be byte-identical to the host compiler's (2130 bytes, fnv=28c333dc, 877 lines of identical assembly)
python tests/run_install_tests.py                                 # `make install` gate: 38 files byte-identical to their sources, a second run changing no mtime, `--dry-run` writing nothing, absolute PREFIX + DESTDIR rejected; finally a program using malloc/div/qsort is built from the installed tree and must print 181 (host gcc on the same source also prints 181 — that is the oracle)
python tests/run_diag_tests.py                                    # diagnostic layout gate (needs armcc)
python tests/run_diag_boundary.py                                 # diagnostic boundary contract (long lines/limits/CJK/tab, no armcc needed)
powershell -ExecutionPolicy Bypass -File run_asm_test.ps1         # assembly-input gate (.s/.S/.asm/.ASM)
powershell -ExecutionPolicy Bypass -File run_arm_exec_test.ps1    # ARM execution level: compile → link → really run under QEMU (needs qemu-system-arm)
python tests/arm_exec/run_arm_exec.py                             # ARM execution level (unicorn; works without qemu; each case also runs a --reg-top arm)
python tests/asm_cases/run_asm_cmp.py                             # assembler differential: arkc vs arm-none-eabi-as, including the --asm-extra switch contract
python tests/run_atomic_tests.py --arkcc ./arkcc.exe               # or make test-atomic; _Atomic / <stdatomic.h> gate across five targets: exactly one target-identity macro, armcc's arm macro appears only on arm, the 11 atomic operations must be compile-time errors on the four non-ARM targets with no artifact left behind, atomic_init must compile everywhere; the tail self-check requires that the same source is *not* rejected on arm (otherwise "rejected" proves nothing)
python tests/run_c11_keywords_tests.py --arm-as <bin> [--rv-as <bin>]  # C11 keyword gate (ARM + RV32I, 32 items): every runtime case computes its own addresses/values (finding `.balign` in the assembly is not evidence), plus a true/false static-assert contrast and three self-checks
python tests/run_arm_int64_tests.py --arm-as <bin>                 # 64-bit data-path gate (ARM, 12 items): inline add/sub, shifts, comparisons, division/modulo through the runtime library, including a self-proof that the runtime library is still required
python tests/run_arm_abi_mix_tests.py --arm-as <bin>               # AAPCS mixed-call gate (ARM, 16 items × both directions): arkcc and arm-none-eabi-gcc each own one side, unicorn runs the same image, pinning "aggregates crossing `...` are rounded up by alignment", "8-byte align-4 aggregates may be split", and the holes between registers and stack; a pure-arkc oracle of the same shape (run_va_gate.py) cannot see this class of disagreement, hence this gate
python tests/run_rv_float_tests.py --arm-as <bin> --arm-libgcc <libgcc.a> --rv-as <bin>  # RV32I soft-float gate (22 items): floating-point arithmetic/comparison/conversion compared against gcc
python tests/run_capacity_tests.py                                 # capacity gate: 120 objects / 1200 headers / 520 -D / 129 -I (the host must have no artificial limits)
python tests/run_rv_alloca_tests.py --rv-as <bin>                  # RV32I VLA gate: 5 cases compared against gcc with hard-coded expectations asserted in each (both arms wrong is still wrong), covering early return (epilogue restoring sp), two VLAs, 10 stack arguments (alignment) and a `long long` VLA
python tests/run_rv_image_tests.py [--rv-as <bin>]                  # RV32I flat-image gate (8 cases): compile to an image, run `main` on RISCV32 unicorn and compare hard-coded expectations; verify the image tail is exactly the last section's contents (no stray alignment padding); three rejection cases (unknown mnemonic / branch out of range / undefined external symbol) must fail and must **not** produce an image; with `--rv-as` a GNU as/ld reference image is produced from an alignment-matched linker script and must be byte-identical
python tests/run_rv_link_tests.py                                  # RV32I object-mode gate (6 cases + 3 rejections + self-check): `-c` produces machine-code objects, `-link` joins them into one image; cross-TU calls / extern globals / reading arrays across objects / a `static helper` in two TUs that must not collide / `.word sym` absolute addresses / three objects. Unresolved symbols, cross-object branches and an RV object without `-target riscv32` must fail and produce **no** image; every case runs `main` on riscv32 unicorn against a hard-coded value, and a self-check requires that changing an operator changes the answer
python tests/run_rv_misc_ir_tests.py --rv-as <bin> [--arm-as <bin> --arm-libgcc <libgcc.a>]  # remaining RV32I IR gate (23 items): inline assembly, `__svc`/`__smc` (the RV side uses unicorn's `UC_HOOK_INTR` as the kernel and validates the whole a7/argument/return-value convention), and the four packed-lane operations (including cross-lane carry/borrow). Besides the values, every vectorised case requires the SWAR mask / `SADD*` mnemonics to actually appear in the assembly — matching values do not prove SIMD was used, scalar code gives the same numbers; plus two self-checks: a wrong expectation must be rejected, and turning vectorisation off must make the mask disappear
python tests/run_rv_packed_tests.py --rv-as <bin> [--arm-as <bin>]   # unaligned-access gate (RV32I + ARM; the ARM arm runs only when `--arm-as` is given): 7 cases × each arm, byte-level verification of where the store landed (never self-proved by reading back through the same path), 2-byte sign extension, no cross-talk on odd offsets, all 8 bytes of an 8-byte (`long long`, including negative) value with the high/low word order checked
python tests/run_regalloc_tests.py                                 # register-allocation gate: off means off / on really changes something / answers unchanged under unicorn, plus two negative cases (volatile and address-taken) that require the text to stay byte-identical
python tests/arm_exec/run_arm_exec.py --extra=-fopt-regalloc        # the same execution-level cases again, with register allocation on
python examples/run_va_gate.py --opt-suite --arm-as <bin> --rv-as <bin>  # variadic gate across all five switch positions (default/O2/regalloc/O2+regalloc/O2+regtop+inline+regalloc); any group going red fails the run
```

`tests/arm_exec/run_arm_exec.py` is the only host gate in this repository that **really executes
machine code**: it loads the raw image produced by arkc into unicorn (a QEMU core), starts at the
reset vector and reads `main()`'s return value. Semantic errors — one wrong instruction encoding, a
bad link-time address, a `--reg-top` fallback that does not restore state — are visible only on this
path; `run_tests.ps1` goes through the C backend and never sees ARM encodings. Without unicorn the
script reports `skipped` and exits 0 (the compiler itself does not depend on any Python package).

There are 29 cases today (the authoritative list is `CASES` and grows with the gate), each run once
on the baseline arm and once with `--reg-top`: `globals`, `reloc_data`, `reloc_data_off`,
`sub_word_access`, `longlong_args`, `shift64` (64-bit left/logical-right/arithmetic-right shifts with
counts 0/1/8/16/31/32/33/40/47/63, expected values computed by repeated doubling/halving rather
than by shifting), `abi_stack_args` (5/6/7/9-word arguments plus a 64-bit argument that spills to the
stack), `longlong64` (64-bit arithmetic/comparison/bitwise/unary minus/`++`/`--`/aggregates and
pointers/compound assignment), `struct_byval` (structs passed and returned by value, `f().m`,
`arr[i] = f()`, mixed scalar/struct/pointer arguments), `big_frame` (frames > 4095 bytes: a single
`SUB sp` cannot encode that, and the old `(N/4) & 0x7f` computed SP itself wrong), `far_addr` (taking
the **address** of a local whose frame offset exceeds 4095: `ADD Rt, r6, #off` cannot encode it, so it
became `MOVW/MOVT ip` + `ADD Rt, r6, ip`; the first version treated address-taking as loading the
value and emitted `ADD r0, [ip]`, which does not assemble, and the second shared `ADD ip, r6, ip` and
therefore computed `r6 + (r6 + n)` and wrote to a wild address). `const_fold_float` pins compile-time
floating-point folding (no VFP instruction may survive in the image), `tls_static_init` /
`tls_block_static` pin `_Thread_local` initial values and persistence across calls, `tls_reject` pins
the diagnostic text of its four constraints together with "an error must not leave an image behind",
and `atomic_rmw` / `atomic_nested_mask` / `atomic_wide` / `atomic_reject` pin the paired semantics of
`<stdatomic.h>` and the PRIMASK builtins (the value saved by nested entry must be 0,1,1,0 — blanket
mask-clearing on restore would silently re-enable interrupts). A good part of these cases are
regression pins for "compiles fine, then does not run or returns the wrong answer" — each one
corresponds to a defect that was really found and fixed.

`tests/asm_cases/run_asm_cmp.py` assembles every `--asm-extra` mnemonic twice, with two independent
assemblers, and compares **the instruction text produced by `objdump`**, not the bytes: the same
instruction often has several legal encodings (GAS prefers the mod-imm form), so unequal bytes do not
mean a mismatch — equal behaviour is what matters. A second table checks the other half of the switch:
with it off, all 30 mnemonics must be reported as unknown. A third table is the reverse contract — 15
lines that **must fail and must fail for the right reason** (nonexistent register index in a
write-back, non-contiguous VFP list, out-of-range immediate, `LDMIB`/`STMDA`), because these shapes
used to "compile but into a different instruction". Ten sample groups cover flag-setting arithmetic,
`LDM/STM` (16- and 32-bit forms, with and without write-back, increment-before and decrement-after,
high registers and `lr`/`pc`), multiply-accumulate, system registers, PC-relative, `TBB/TBH` and
`LDRD/STRD`, VFP single/double precision and the literal pool, every LDR/STR addressing mode, VFP
multi-register load/store, and armasm's four block-transfer aliases. Without a GNU ARM toolchain the
script exits 2 rather than pretending to pass.

`tests/run_regalloc_tests.py` guards three independent assertions about `-fopt-regalloc`: the default
text contains no `r8-r11` (off means off — the default output is byte-identical to the previous
release); turning it on really does reduce `[r6, #]` references in the hot cases (`far_slots` drops
from 22 to 13); and three cases really executed under unicorn return the same values as Python
(answers unchanged). Two further negative cases — a `volatile` local and an address-taken local —
require the text to stay **byte-identical**: the moment they start being rewritten, the taint rule
"every mention is one of those two shapes" has broken and the positive cases lose their meaning. That
rule did catch two real problems during implementation (address-taking emits `ADD r0, r6, #off`,
without brackets; `volatile` uses exactly the same two instructions).

`tests/run_capacity_tests.py` guards a different line: **the host must not have artificial limits**. It
generates 120 `.c` files, compiles each into an object and links them with `--reloc-data` into one
image; a translation unit that `#include`s 1200 distinct headers (with `-MMD`, so not one `.d` may be
missing); 500 `-D` flags that must compile while 520 must be rejected; and 129 `-I` flags, where the
129th must **fail** and name `ARK_PP_MAX_INC_DIRS`. All four are "the table filled up and the entry
was silently dropped" shapes: before the fix only 32 of 120 objects made it into the image (55 KB
instead of today's 206 KB), `.d` output stopped at 1024 entries, and every `-I` past the 16th simply
vanished — the symptom being a later "header not found", pointing at the wrong cause. The board build
still uses fixed-size tables (`ARKCC_MAX_INC_FILES` / 64 objects); `.bss` is byte-identical before and
after, and the trimming entry point is `-D` (see section 9 of `include/arkcc_config.h`). The image
buffer in the same batch grew from 256 KB to 8 MB (the host allocates it from a pool on demand, so it
does not grow the executable): a 1.2 MB image used to fail with `only 262143 could be read` and now
links normally.

`run_asm_test.ps1` checks extension routing for assembly input: four suffixes produce byte-identical
machine code, `-S` passes assembly input through unchanged, a missing file must fail, and `.c` still
goes through the normal front end (so extension sniffing cannot mistake C source for assembly).
`run_arm_exec_test.ps1` compiles C startup code, an assembly semihosting trap and a C workload, links
them into a bare-metal image and runs it on `qemu-system-arm -machine mps2-an385`, judging the result
by the semihosting exit code (two different workloads must return 8 and 3). The QEMU path defaults to
`D:\qemu\mingw64\bin\qemu-system-arm.exe` and can be overridden with the `ARKCC_QEMU` environment
variable or the `-Qemu` parameter; when QEMU cannot be found the script exits 2 instead of pretending
to pass. This gate caught and pinned fixes for three real defects: the vector table missing the Thumb
bit (Cortex-M enters INVSTATE lockup), `SVC`/`BKPT` immediates without `#` being silently encoded as
0, and `MUL r2, r2, r1` being encoded as `MUL r2, r2, r2` (which made every integer modulo evaluate as
q\*q).

`tests/run_diag_tests.py` compares arkc's diagnostics against those of a **real armcc 5.06** byte for
byte: cases that can be compared exactly are marked `exact`, cases where arkc's error recovery differs
and only the spelling of each line can be compared are marked `shape`, and `--errors` file output is
marked `sink`. The baseline is regenerated from the real armcc with `--regen`; with neither armcc nor a
baseline the exit code is 2 (refusing to pass falsely).

`tests/run_diag_boundary.py` covers the boundary contracts that byte comparison cannot reach: truncation
of over-long lines (`DIAG_LINE_MAX` 512) together with "if the caret cannot be drawn, do not draw it",
the 30-error cap, multiple diagnostics on one line each with their own caret, CJK counted in display
cells, and tabs replayed as-is. It does not need armcc; it asserts the behaviour arkc itself documents.
The layout rules and design notes are in [docs/DIAGNOSTICS.en.md](docs/DIAGNOSTICS.en.md).

All 71 assertion cases pass, 4 ARM-only cases skip the C-backend run (they only check ARM emission and
are not counted as passes), 0 fail (ARM assembly generation + C-backend compile-and-run, with expected
exit codes checked mechanically per file). Coverage: basic arithmetic, functions/recursion,
struct/union/enum, bit-fields, VLA, `_Complex`, `wchar_t`/`L"..."`, trigraphs, inline assembly (basic +
extended), the full `__attribute__` set, `__svc`/`__irq`/`__weak`/`__naked`/`__packed`/`__align`/`__at`/
`__forceinline`, `__asm` whole-function assembly bodies, `#pragma pack/anon_unions/location/...`, TLS,
`__packed` unaligned pointer access, `split_sections`, double precision, 64-bit integers, division and
modulo, compound literals, designated initialisers, structs passed by value, implicit conversions,
integer promotion, 64-bit `printf`, `setjmp/longjmp`, multi-file linking, CPU macros, debug information,
`$` identifiers and more.

## Porting to STM32

All you have to do is replace `port/host/*.c` with `port/stm32/*.c`; the entry point is
`port/stm32/main_stm32.c`. The MDK project lives in `mdk/STM32H743_ArkCC/`. The STM32 side is a
self-hosting configuration: it reads `.c` files straight from an external W25Q flash and compiles
them in place.

**armcc5 build**: `build_stm32_armcc.ps1` compiles the arkCC sources and links a flashable STM32
firmware on any Windows machine with armcc5 — no gcc required. See
[docs/STM32_BUILD.en.md](docs/STM32_BUILD.en.md) for details.

See [docs/MANUAL.en.md](docs/MANUAL.en.md) for the full manual.

## Version history

- v0.9.0: **the stable release** -- "what this compiler can do" stops being "the assembly looks right" and becomes "the return value the board computed is right".  New board gate `tests/run_stm32_board_tests.py`: 54 cases x `-O0/-O1/-O2` = 162 rounds of "compile on the board -> link -> load -> execute -> read the return value", measured **162/162** on an STM32H743 (about 956 s), with the gate carrying its own anti-false-green self-check; criterion, coverage table and every root cause are in [`docs/BOARD_VALIDATION.en.md`](docs/BOARD_VALIDATION.en.md).
  Three classes of defect that would have made "stable" a claim rather than a fact were fixed in the same cycle: (1) **silent truncation on buffer overrun** -- all four back ends (arm / c / riscv32 / x86_64) used to truncate an oversized assembly buffer at `%.*s` and emit anyway, and now **refuse** by name; the STM32 profile's `ARK_SRC_BUF_SIZE` / `ARK_ASM_BUF_SIZE` went to 32 KB / 256 KB, and `make test-buffers` (7 checks) guards it; (2) the board's `link` fails loudly on an undefined symbol (`app.bin: Error: unresolved symbol "nope"`, `link failed: -8`) instead of quietly producing an image that jumps into the vector table; (3) three wrong readings inside the gate itself -- `fconv_rne` treated `FLT_MAX` as an overflow (the expected bit pattern is `0x47EFFFFFF0000000`), the return-value regex accepted half a number (`11` read as `1`, `68` read as `6`; the pattern now carries the line terminator), and a dropped UART had no recovery path (reset + retry, recorded as `[board] note:` rather than silently promoted to a pass).
  This release contains everything that was staged as v0.8.7-wip: `--ipo` whole-program compilation and `--const-global` cross-TU constant propagation (next bullet).
- v0.8.7 (never released on its own; this entry ships as part of v0.9.0): **whole-program compilation** `--ipo` (alias `-flto`, `docs/IPO_LTO.en.md`). One invocation
  takes several `.c` files; each still runs through the frontend on its own (its `static` stays its
  own), and the IR is **appended** into one `IrProgram`, after which the pipeline runs **once** and code
  is generated once. Not object-level LTO because `ARKOBJ2` objects carry no IR: real LTO would add an
  IR payload section and rebuild the IR at link time (renumbering three pools and running a backend
  inside the linker), which is a different contract. Three merge rules: (1) file-scope symbols are
  renamed to `__ipo<unit>f_/g__<name>` and checked against the whole program (another `_` if taken, a
  diagnostic if that fails); (2) external names follow the linker's rules (weak loses to strong, **two
  strong functions are an error**, two `int g;` are one object, two `int g = 1;` are an error, a
  definition beats an `extern`); (3) unreferenced `static`s are pruned after inlining (`used`,
  constructors/destructors, alias targets, `__at`, `section` are always kept, and **any inline assembly
  anywhere disables pruning entirely**). The value comes from `ir.inline` already being whole-program
  scoped: after the merge **cross-file inlining is free** (measured: no `BL one` at `-O2`, present at
  `-O1`). Refuses `-c`/`-E`/`-g`/`-link`/missing `-o`/`.s`/`.o`, each with a reason; a single file
  through `--ipo` is **byte-identical** to a plain compile (both `.s` and `.bin` are diffed). Cropping:
  `ARKCC_FEATURE_IPO` defaults to 0 in the `ARKCC_PROFILE_STM32_MIN` profile (a 128 KB pool cannot hold
  several units' IR) and then `--ipo` reports "not compiled into this build" rather than an unknown
  option. Gate `tests/run_ipo_tests.py` (`make test-ipo`, 19 checks): three dynamic cases returning
  28 / 23 / 4 on the ARM emulator, two duplicate-definition errors that must name the symbol and leave
  **no image**, one assembly read each for pruning and cross-TU inlining, plus the cropped build's
  refusal.
  This release also adds **cross-TU constant propagation** `--const-global` (`docs/IPO_LTO.en.md` §8):
  once merged, "is this `const` really a constant" is answerable in full, so a constant object's load
  becomes an immediate (`const int LIMIT = 100` read from another unit turns into `MOV r0, #100`
  instead of `MOVW/MOVT + LDR`).  The test errs on the conservative side: only "`const` + scalar
  integer initialiser + not `extern` + nobody in the program writes it + address never escapes (never
  taken, never in another object's `init_sym`/`init_refs`) + not `volatile`/array/aggregate/function +
  `type_size==4` + no `__at`/section/`__thread`/`__global_reg`" folds; anything else keeps its load,
  because a missed fold only costs one `LDR` while a wrong fold is a wrong answer.  It sits after
  `ir.inline` (inlining puts reader and definition in one view) and, since the pipeline does not
  iterate, re-runs constant folding itself so a cascade converges in the same round.  It does not do a
  global-value theorem (a non-`const` global never folds even if the whole program never writes it)
  and does not delete the folded `const` object (it still needs a definition for `-link`).  A `static
  const` in a single file folds too.  Cropping: `ARKCC_FEATURE_CONST_GLOBAL` defaults to 0 in
  `ARKCC_PROFILE_STM32_MIN`, and then the option reports "not compiled into this build".  Gate
  `tests/run_constglobal_tests.py` (`make test-constglobal`, 15 checks): folded and unfolded images
  both return 103, five conservative cases keep their load (address taken 6, store through it 9,
  `volatile` 6, array 3, `long long`), `-O0` does not fold, `--print-pipeline` reports `run`/`off`,
  the cropped build refuses the option, and with the switch off a full build and a cropped build emit
  **byte-identical** `.s`.
  This release also adds **an IR payload in the object and link-time recompilation**
  (`docs/OBJ_IR.md`): `-c --obj-ir` serialises the whole pre-pipeline program (type table, three
  constant pools, argument-length table, globals, functions and their instruction streams) and
  **appends it after `ARKOBJ2`'s relocation table**; `-link --lto` reads it back, appends the four
  pools in command-line order with index remapping (`IR_PUSH_STR.val` / `IR_PUSH_FLOAT.val` /
  `IR_CALL.aux2`), reuses `--ipo`'s unit renaming and external-name arbitration, runs the pipeline
  **once** and emits again.  Because the payload is the **unoptimised** IR (the hook sits before
  `pipeline_run_ir()`), `--lto` and `--ipo` hold the same IR at the pipeline entry, so the result is
  **byte-identical in both directions** (`-S` and `-o bin`); same-named statics come back as
  `__ipo1f_helper`/`__ipo2f_helper`, and units without a `main` merge the same way.  An old reader
  stops at the relocation table, so a payload-carrying object still links under plain `-link` and
  produces the same image.  A missing or corrupt payload (truncated, bad magic, version 99, body
  length mismatch) is always a **named error with no output file** -- dropping a unit is a wrong
  answer, far more dangerous than a failed link.  Version compatibility is strict equality with no
  forward compatibility.  Cropping: `ARKCC_FEATURE_OBJ_IR`
  defaults to 0 in `ARKCC_PROFILE_STM32_MIN`, and then both options report "not compiled into this
  build".  Gate `tests/run_objir_tests.py` (`make test-objir`, 26 checks): payload written with the
  prefix unchanged, a `--ipo` reference that really inlines and folds (otherwise the later
  "identical" is an empty equality), the two byte-for-byte comparisons, two emulator readings (102
  and 79), both same-named statics still named, four kinds of damage, a payload-free object refused
  by name, plain `-link` undisturbed, six option refusals, the cropped build's refusals, and with
  the switch off a full build and a cropped build emit **byte-identical** `-c` objects.
  This release also adds **partial link `-r`** (`docs/PARTIAL_LINK.md`): `-r -link a.o b.o -o ab.o`
  reads N `ARKOBJ2` objects, concatenates machine code in command-line order, rebases symbols with
  `offset += base` and relocation sites with the same shift, and writes a **new `ARKOBJ2` object**.
  One semantic rule: **machine code wins** -- the merge takes machine code, not the IR payload, so an
  object carrying `--obj-ir` is **refused by name** and pointed at `-link --lto` (silently dropping
  the payload would make "LTO still works later" a lie).  A global object (`OBJ_SYM_TYPE_DATA`)
  keeps its **absolute address** and data is never moved; `X86_RELOC_SELF_BASE` is resolved in
  place and dropped (byte-for-byte what `-link` does); the `__arkcc_ram_start/end` descriptor is
  kept as-is, hence **one `-r` merges at most one RAM-owning object**; a `riscv32` object is padded
  to 16 bytes once an ISA tag has been seen.  Mixing riscv32 with non-riscv32, a non-object file, a
  truncated table, stray bytes after the tables, the same strong symbol at different addresses and
  disagreeing `--reloc-text` bases are all **named errors with no output file written** (the object
  *is* the deliverable, so "error plus half a file" is worse than either).  Four properties must
  hold: **substitutable** (linking one `-r` product equals linking those N objects byte for byte),
  **idempotent**, **inputs untouched**, and **a referenced-but-undefined name is not invented** (left
  for the final `-link`).  Option-level refusals: `-r` without `-link`, with `--lto`, with
  `-c`/`-S`/`-E`/`-MMD`, without `-o`, or with no objects after `-link`.  Cropping:
  `ARKCC_FEATURE_PARTIAL_LINK` is separate from `ARKCC_FEATURE_OBJ_IR` and defaults to 0 in
  `ARKCC_PROFILE_STM32_MIN`; a cropped build refuses `-r` at option parsing with `C3900U`.  Gate
  `tests/run_partiallink_tests.py` (`make test-partiallink`, 27 checks): the merge and its three
  rebases, `g_init`'s absolute address unchanged, the RAM descriptor preserved, merged-vs-direct
  link byte identity, the emulator answering 13, idempotence, inputs unmodified, merging without
  `main`, same-named file statics keeping their own values, a definition arriving later (41), five
  kinds of damaged input all "non-zero exit and no file written", five option checks, and a cropped
  build whose `-c`/`-link` products stay byte-identical to the full build.
> Entries v0.8.2 and v0.8.1 are translated in full below. Earlier releases (v0.2.0–v0.8.0) are
> documented only in the Chinese [README.md](README.md) — they are long, and every one of them is
> covered by the documents under `docs/`.

  This release also closes the **last written-down gap in the diagnostic layer**: `#1-D: last line of
  file ends without a newline` (`docs/DIAGNOSTICS.en.md` §5.4). The position is **that file's last
  line** (when a header is guilty the message names the header and the main file appears only in the
  summary line), the caret sits one cell past the end of that line, and the `-D` suffix marks it as a
  warning; files ending in `\n`/`\r` and empty files stay silent. It is emitted where the
  preprocessor reads a file — the translation unit before `process()` (armcc also reports while
  reading, so it precedes that file's other diagnostics), a header right after `read_include()`
  succeeds — because "no trailing newline" is a fact about the file, not a semantic error of some
  stage; a header's line text is not in the diag layer's `g.src`, so
  `diag_report_no_final_newline()` takes the line from the caller (a one-shot echo override).
  Cropping: `ARKCC_FEATURE_EOF_NL_WARN` defaults to 1 on every profile; setting it to 0 compiles both
  checks away and **restores 0.8.6 behaviour and size**. Gate `tests/run_diag_tests.py` gains 10
  byte-exact cases (main file / IDE style / header / line 2 of a two-line file / warning-and-error
  ordering / `--errors` sink / four clean controls: trailing `\n`, trailing `\r`, CRLF, empty file),
  and it exposed an older defect that is fixed here: IDE style stripped the code's trailing letter, so
  `#1-D` printed as `#1-` — the strip is only true for driver codes (`C3900U` -> `C3900`); frontend
  codes print verbatim.
  This release also adds the **ARM soft-float AEABI runtime** (`stdlib/src/arm/aeabi_float.c`):
  30 entry points (`__aeabi_fadd/fsub/fmul/fdiv/f2iz/f2uiz/...`,
  `__aeabi_dadd/dsub/dmul/ddiv/...`, `__aeabi_i2f`/`__aeabi_f2d`/`__aeabi_d2f` and friends), all
  integer arithmetic, one rounding site, and not a single call to another AEABI helper. The contract
  is the same as `aeabi.c` — **optional at link time, never linked implicitly**: "not used, not in
  the image" is guaranteed by the link contract, so no macro switch is needed. Two gates:
  (1) the host differential `tests/softfloat_ref.c` (the same case table computed with IEEE double on
  the x86-64 host and compared bit-for-bit against the runtime; `-msse2 -mfpmath=sse` is mandatory
  because x87 double rounding judges a correct implementation wrong) ran 122 million checks with 0
  failures; (2) the ARM execution gate `tests/run_arm_softfloat_tests.py`, which builds the table
  into a real image and runs it on an ARM core model — 217 entry-point rows plus 17 plain-C
  expression steps, both of which must pass, and whose self-containment check rejects a runtime that
  quietly calls some other AEABI helper.
  That gate caught two silent wrong answers that **only ever show up in real code generation**; both
  are fixed here:
  - **The prologue's struct-by-value memcpy clobbers the register parameters behind it**: a
    struct larger than 16 bytes arrives by pointer under AAPCS and the callee `BL __aeabi_memcpy`s it
    into its frame, but `__aeabi_memcpy` clobbers `r0-r3`; the prologue homes the remaining formals
    only afterwards, so every parameter arriving in `r1/r2/r3` was garbage (it showed up as "some
    double operation returns 0"). The fix pushes/pops `r1-r3` around the copy.
  - **The Thumb-2 modified immediate used the wrong bit fields**: the rotate count is **five bits**
    `imm12<11:7>` and the constant is `'1':imm12<6:0>` (seven bits only), and the four byte-fill
    forms are `imm8*0x00010001` / `imm8*0x01000100` / `imm8*0x01010101` rather than "shift by 8/16".
    The old encoder wrote the rotate as multiples of eight bits into `imm12<11:8>`, so
    `EOR r0,r0,#0x80000000` (negating a double) became a legal instruction holding a different
    constant — invisible in `-S` text, wrong only in the `--object` image. The new code is driven by
    `thumb_expand_imm_a()`, a decoder **reverse-engineered from all 4096 measured `imm12` values**,
    and every encoding is decoded back and checked (`decode(encode(v)) == v`) before it is accepted.
- **v0.8.6**: four directions land together, all **off by default, all trimmable, and every switch left at its default leaves the output byte-identical**.
  1. **`--warn-unused-result` + `__must_check`**: dropping the return value of a function marked for checking is now a warning; the marking travels along the declaration chain (`__must_check` / `__attribute__((warn_unused_result))`) and survives macro expansion.
  2. **MIR/CFG substrate + three cross-function checks** (`docs/MIR_CFG.en.md`): `src/mir.c` builds basic blocks and control-flow edges, and on top of it `--warn-unused-static` (a static function nobody references), `--warn-unreachable` (instructions no path can reach -- reported as "N instruction(s) in 'f' can never run") and `--warn-recursion` (direct or mutual). All three look only at **shapes they can prove**: `goto` into a dead block, function-pointer aliasing and `#pragma arm section` cases stay silent.
  3. **Loop optimisations** (`docs/LOOPS.en.md`): `--licm` hoists invariant **computation** into a frame temporary and leaves the store in place (so a zero-trip loop never writes a variable the unoptimised program never wrote); the whitelist is 32-bit word-shaped arithmetic only, excluding `/` and `%` (they can trap) and every access through a pointer. `--unroll` completely unrolls a single-level constant-bound `for` with step 1 and a straight-line body (limit `ARK_UNROLL_MAX` = 8); `break` / `continue` / `goto` and non-canonical shapes are left untouched. Both run after `ir.dce` and before `ir.dce-cfg`.
  4. **A modern diagnostic style** (`docs/DIAGNOSTICS.en.md` section 4.1): `--diag_style=modern` (alias `clang`) gives a clang-shaped header `f.c:4:9: error: ... [#20]`, a framed echo with a right-aligned 5-column line number, and a `1 error generated.` summary. The armcc code is kept after the message as `[#code]` so it stays searchable, and the `note:` line exists only in this style. It is the **only style that does not promise byte compatibility with armcc**; the `arm` / `gnu` / `ide` bytes are pinned by the gate.
  Gates: `make test` **255 PASS / 0 FAIL / 1 SKIP** (the single skip is the emulator's missing double-precision FPU); four new gates `test-unusedresult` / `test-mir` / `test-loop` / `test-modern` (17 / 26 / 29 / 35 checks, each with its own anti-false-green probe: breaking the implementation must turn it red); x86-64 self-host is still 31 self-source TUs -> flat image -> runs under unicorn -> byte-identical host object (`fnv=28c333dc`, 877 assembly lines identical).

- **v0.8.5**: a configurable pass pipeline (`docs/PASS_PIPELINE.md`), plus one x86-64
  linker defect that the pipeline was the first thing to expose. `src/pipeline.c` replaces the
  `#if` / `if` ladder that used to live in `opt_run()` with **one stage table and one loop**: two
  AST stages (`ast.memlint` behind `--warn-mem`, `ast.enumcheck` behind `--warn-enum`; neither has
  an `-O` gate) and five IR stages (`ir.constfold` -> `ir.dce` -> `ir.dce-cfg` -> `ir.inline` ->
  `ir.vectorize`, **table order is execution order**), each with one of three gates (flag only /
  level and flag / level or flag) and a **reason** string. `--pipeline=full` is the default and is
  **byte-identical to not passing the option at all** -- a profile is an upper bound, it never
  replaces a stage's own gate. `--pipeline=lite` drops only the three expensive stages
  (`dce-cfg` / `inline` / `vectorize`) and records why. An invalid value is refused with `C3900U`
  on the command line; in an INI file it is a warning that **keeps the previous value**, because
  there is no previous value to fall back to on the command line and guessing would decide for the
  user. `--print-pipeline` prints one line per stage (`run <name>` / `skip <name> <reason>`):
  **a skipped stage must name the gate that stopped it** -- no output is not a measurement. Two
  switches that were previously accepted but did nothing are now real: `-fno-opt-constfold` and
  `-fno-opt-dce` were ignored because the old `opt_run()` only looked at the `-O` level; the table
  honours them and the output is unchanged because both default to 1. Trimmable:
  `ARKCC_FEATURE_PIPELINE_DUMP` (0 in `ARKCC_PROFILE_STM32_MIN`) strips only the name strings --
  the table and the loop are always compiled in. Measured (ARM, `-c --reloc-data`): 8,342 B
  default, 7,096 B with the dump strings off, 7,830 B with both lints off as well, 6,616 B with all
  three trimmed; host x86-64 default 9,135 B. Zero-change reading: **480/480 byte-identical**
  against the v0.8.4 binary (80 `examples/` sources x 3 `-O` levels x 2 targets, exit codes
  included); the self-host gate still compiles 27 self-source TUs into a flat image, runs the
  compiler under unicorn and compares object bytes, PASS (6,357,774 B, `fnv=28c333dc`). The linker
  defect fixed in the same round: an **absolute** relocation that refers to a symbol defined in
  *another* object was written as `object base + symbol offset`, **missing the image base**
  `X86_IMAGE_BASE` (0x400000). Evidence: the self-host image faulted at `0x3F571F`, a value that
  occurs exactly once in the 6.3 MB image, at the relocation slot of `pipeline.o`'s
  `.quad opt_vectorize` (image offset 0x424c8a = object base 0x42491A + 880); subtracting the
  symbol offset of `opt_vectorize` inside `opt.o` leaves exactly `opt.o`'s object base -- i.e.
  0x400000 short. Fix: at link time, add `X86_IMAGE_BASE` for type 4 (4-byte absolute) only; type 5
  (PC-relative disp32) and the types already settled by `ld_relocate_data` are untouched. New
  regression `fptr_across_objs` (`e1.c` defines `f1()`/`f2()`, `e2.c` builds
  `int (*tab[2])(void) = {f1, f2};` and returns `tab[0]() + tab[1]() * 2`; expected 50; it faulted
  with `UC_ERR_FETCH_UNMAPPED` before the fix), x86-64 object gate now **36 passed**. New
  `tests/run_pipeline_tests.py`, 27 assertions (`make test-pipeline`), covering the text output,
  the actual effect of each stage, the refusal paths and the INI key.
- **v0.8.4**: `--warn-mem` closes two gaps and a new `--warn-enum` arrives (`docs/ENUMCHECK.en.md`).
  `--warn-mem` goes from two diagnostics to four: it now also reports **storing the address of an
  automatic object into an object with static storage duration** (`g = &x;`, `g = local_array;`,
  `g = (T){...};` -- the root object is resolved through `a.b`/`a[i]`, while `g = "abc"`, `g = 0`
  and a local pointer to a local array stay silent) and **a constant subscript outside a known
  array bound** (`int a[4]; a[4]`, `a[-1]`; only named array objects, no VLA, and only when
  `eval_const_expr` folds the subscript -- `p[8]`, `a[i]` and `"ab"[5]` stay silent). `--warn-enum`
  is a separate pass: a `switch` whose controlling expression has enum type, that has no `default:`
  label, and whose `case` labels do not cover every enumerator gets one warning. **Values decide
  coverage, not names** (`case 0:` covers `case RED:`), nested switches are judged independently,
  and a set larger than 64 enumerators or 64 case labels is skipped entirely -- a truncated
  comparison could claim a value is missing when it is merely beyond the table. Both checks are off
  by default, both have a compile-time `ARKCC_FEATURE_*` switch (0 in `ARKCC_PROFILE_STM32_MIN`)
  and an INI spelling (`warn_mem` / `warn_enum`), and where the feature is compiled out both the
  command line and the config file are refused with `C3900U`. Measured cost (host x86-64, each
  measured in isolation): `--warn-mem` `+6,584 B` text at `-O2` / `+5,516 B` at `-Os`;
  `--warn-enum` `+1,852 B` / `+1,548 B`; zero `data`/`bss` for both. With everything off the
  output is byte-identical to v0.8.3. Gates: 27 assertions in `tests/run_memlint_tests.py`
  (12 positive / 16 negative / 12 legal twins) and 19 in `tests/run_enumcheck_tests.py`
  (5 positive / 6 legal twins / 2 negative), both part of `make test`, which is now
  129 PASS / 0 FAIL / 1 SKIP; the x86-64 self-host gate compiles 26 translation units and the
  object is byte-identical (6,349,223 B image, `fnv=28c333dc`).
- **v0.8.3**: adds the intra-procedural memory lint `--warn-mem` (`docs/MEMLINT.en.md`). Two
  diagnostics -- **returning the address of an automatic object** (`return &x;` /
  `return local_array;` / `return &local.field;` / `return (T){...};`) and **double free /
  use-after-free inside one function** -- and only for shapes that can be proven: `realloc`
  revival, `free(p + 1)`, a single-sided `if (c) free(p)`, ownership handed to another function,
  any function containing `goto`/`asm`, and any function whose tracking table (8 pointers /
  32 local names) overflowed all stay silent. Missing a defect is preferred over guessing. With
  the pass off the output is **byte-identical to v0.8.2** (3 programs x arm/x86/riscv32/x86-64 =
  12 `.o` files, all `cmp`-identical). Trimmable: `ARKCC_FEATURE_MEMLINT` defaults to 0 in the
  `ARKCC_PROFILE_STM32_MIN` profile, and where the pass is not compiled in, both `--warn-mem` and
  `warn_mem=1` from a config file are refused with `C3900U` plus the rebuild hint instead of
  pretending the check ran. Measured cost on host x86-64: `+5,424 B` text at `-O2`, `+4,436 B` at
  `-Os`, zero `data`/`bss`, about a 900-byte stack frame per analysed function. Gate
  `tests/run_memlint_tests.py` (`make test-memlint`, 22 assertions): each positive case checked
  line by line and text by text, all 12 negative shapes silent in one file, the 8 legal twins of
  the defects silent, the three-way switch (`--warn-mem` / `--no-warn-mem` / config file), and a
  build made on the spot with `-DARKCC_FEATURE_MEMLINT=0` that must refuse. These diagnostics
  carry **no armcc code** (codes are used only for measured armcc behaviour), so
  `--diag_suppress` cannot target them.
- **v0.8.2**: every historical debt of the 32-bit x86 backend is cleared, and the gate no longer
  leaves it a loophole. (1) Local array indexing: the frame mapping became `[ebp - framelo + off]`,
  structurally identical to x86-64. (2) Structs passed and returned by value: the hidden return
  buffer pointer (sret) lives at `[ebp+8]` and real arguments start at `[ebp+12]`; `struct_sret40`
  used to read `[ebp+16]` because the callee also counted sret as an argument width, and got back
  all zeros. (3) Floating point: `x86_pair_swap_at` degenerated into a no-op at offset 0, so
  `(int)7.9` gave 0. (4) 64-bit integers: `IR_UNARY` ignored `I->val`, the `|a|` mask was written as
  `sar 31`, and the division shift used `add ecx,ecx`. Three wrong values from the C tier were fixed
  in the same round: float/double locals `++/--` were incremented as integers, `IR_BINARY` on 8-byte
  pointers did only 32-bit arithmetic, and pointer ↔ `long long` conversion was a no-op (a pointer is
  one stack word while `long long` is two, so the high half must be split and merged at the irgen
  layer, wired into cast / declaration initialisation / assignment / `return` / call arguments — five
  places). The x86-64 image gate grew from 33 to **35 programs**, and **each program is compiled a
  second time for 32-bit and run again**, with any i386 result that differs from the expectation
  judged FAIL (the old wording was a footnote, which is exactly why "a known 32-bit gap" never went
  red); the self-host gate is still byte-identical (2130 bytes, `fnv=28c333dc`, 877 identical lines
  of assembly). See §5 of `docs/X86_64_BACKEND.md`.
- **v0.8.1**: a real x86-64 backend (SysV AMD64 ABI; `--list-backends` now lists five backends), CI
  automation (GitHub Actions + Gitee Go, see `docs/CI.md`), C11 `_Thread_local` (storage class
  validated per 6.7.1p4, armcc's bare `__thread` stays exempt), and C11 `_Atomic` + `<stdatomic.h>`
  (a real critical section on ARM; compile-time rejection on the other four targets; `Type::is_atomic`
  makes atomicity propagate through typedefs, and `x += 1` / `x++` are always errors; 7 cases were
  added to the ARM execution gate for 29 in total; details in `docs/ATOMIC.md`). It also added an
  x86-64 execution-level **self-host gate** (`tests/run_x86_64_selfhost.py`,
  `make test-x86-64-selfhost`): the host arkcc compiles its own 24 translation units, the image runs
  inside unicorn, and the arkcc inside that image compiles a probe whose object is **byte-identical**
  to the host compiler's (2130 bytes, `fnv=28c333dc`, 877 identical lines of assembly text, 0 libc
  stub hits); x86-64 cases went from 26 to 33, and the front-end root cause behind §3.5 —
  "`sizeof` of a member array silently answered 4" — was fixed (evaluating `AST_MEMBER` during
  parsing fell back to `s = 4`; it is now evaluated in sema, so `sizeof(char sym[512])` goes from 4
  to 512 and the self-host object shrank from 2351 bytes back to 2130).

---

Earlier history in brief (Chinese README only): v0.8.0 made the ARM backend usable for real projects
(a 25-source self-hosting project with `failed=0`) together with the 64-bit data path, static argument
allocation tables, AAPCS struct passing/return, an extended assembler, two levels of register
allocation and the removal of every host-side capacity limit; v0.7.0 reached 98 %+ armcc keyword and
attribute coverage with full DWARF, TLS, scatter files and CPU selection; v0.6.0 added the three-layer
configuration system, VLA, wide characters, trigraphs, `_Complex`, hardware FPU instructions and IR
optimisation; v0.5.0 covered startup/vector tables, HAL/DMA/MMIO, control algorithms and RTOS-grade
projects; v0.4.0 completed C99 plus armcc compatibility; v0.3.0 added floating point, `__svc`, `.s`
compilation and multi-file linking; v0.2.0 introduced the multi-backend architecture; v0.1.0 was a
minimal single-backend ARM subset.
