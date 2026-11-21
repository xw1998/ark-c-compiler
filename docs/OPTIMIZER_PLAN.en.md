# The 0.9.x optimisation line: from three reverse-engineering dossiers to arkc's stage table

[中文](OPTIMIZER_PLAN.md) | English

0.9.0 is the stable release: **pin down "it compiles correctly" first, then make it
"compile better"**. This document is the map for 0.9.x. Every item states four things:
**where the evidence comes from, which stage it lives in, how it is trimmed away, and how
we prove it actually helps.**

---

## 0 Four rules, stated first

1. **A default value is a contract.** Every new pass is compiled in by profile
   (`ARKCC_FEATURE_*`) and **off at run time** (`g_config.enable_*`). With the switch off the
   image is byte-identical to a build that never heard of the pass, and the gate compares the
   images -- that is not a promise, it is a check.
2. **Every "we do not do this" needs a named refusal.** The most transferable thing in the
   dossier is not an algorithm but a shape: nearly every "cannot do" in IAR's C1-C10 table
   has a diagnostic string behind it. arkc's equivalent is a comment listing each rejection
   condition plus a negative case in the gate: a shape the pass promises to leave alone must
   produce assembly byte-identical to the switch-off build.
3. **Trimmed or it is not done.** The board (`ARKCC_PROFILE_STM32_MIN`, self-hosting on an
   H743) has neither RAM nor Flash for a full optimiser. Every pass must be able to disappear
   at compile time: implementation under `#if ARKCC_FEATURE_X`, its row kept in the stage
   table with `built_in=0` so the numbering is stable, and the option refused with `C3900U`
   in a trimmed build.
4. **A gain must be measured, and measured on a small construction.** No "smaller and
   faster" prose -- only "this construction went from N bytes to M bytes".

---

## 1 Where the evidence comes from (external, read-only)

| Evidence | Location | What it supports |
| --- | --- | --- |
| Optimiser component maps (84 `Go*` / 40 `Ect*` / 33 `Cg*` / 56 `Ta*`; AC5: 126 modules, 35 `-O` sub-switches, 65 transformation messages) | `c_compiler/iar/docs/06-optimizer.md` | which capabilities exist, which side defaults them on |
| How-to-level reverse engineering of cross-jump / cross-call (C1-C10 table, `CalcRealJumps` fixed-point, `zip` and the two candidate rounds, byte account 8/16/24/40 B) | `c_compiler/iar/docs/07-crossjump-and-tbaa.md` sections 2-3 | **the algorithm this round copies** |
| Two TBAA routes (IAR access flags + alias cookies; AC5 points-to + `restrict` hints) | same, section 4 | the "faster" line and its boundary |
| AC5 diagnostic reference implementation | `c_compiler/armcc5/ref/` | the style of a named refusal |

The one conclusion all three share: **"smaller" mostly comes from "a piece of code appears
once" plus layout arithmetic; "faster" mostly comes from "will you keep optimising when
aliasing is uncertain" plus ARM-specific instruction rewrites.**

---

## 2 The line: six items, ordered by value per unit of work

### P1 Block-tail merging (block-level cross-jump) -- **landed in 0.9.1**

- **Evidence**: AC5 runs `CrossJumps` after register allocation and before the epilogue
  passes; two candidate rounds (zero-exit blocks first, then the main list); the two block
  self-checks `BLKLIFTABLE` / `on_savepath`; `zip` performs the merge; a jump-distance change
  asks for `need another pass`. Measured: sharing 1/2/3/5 statements saves 8/16/24/40 B --
  **positive even for small N**.
- **Where**: stage `ir.tailmerge`, after `ir.inline` / `ir.const-global`, before
  `ir.vectorize`. After inlining is deliberate: what cross-jump cleans up is duplication
  *another* pass created (AC5's `cj_in.c`: only after `-O2` inlines `tailwork` into both
  branches do two identical tails exist).
- **Implementation, point by point**:
  1. Matching is **instruction-identical**, not semantic (`cj6.c` counter-example: `r1` vs
     `r0` and it refuses). The IR carries no register allocation, so matches are easier to
     find than at machine level -- that is the IR-level dividend.
  2. Only tails whose entry stack depth is **0** are merged. The IR is a stack machine;
     jumping into a point with values live on the evaluation stack means carrying state
     across an edge, which is the backend's promise to make, not ours to assume.
  3. Gain test: `len >= ARK_TAILMERGE_MIN_LEN` (each extra entry pays one `JMP`), and every
     merged copy must really get shorter. No saving, no merge.
  4. One merge per round, then rebuild the CFG -- the same shape as `opt_licm_func`. Rounds
     are bounded by code length, which is the termination guard (IAR's
     `Jump size optimization will not terminate!` is the same idea).
  5. A depth analysis that fails (labels entered at inconsistent depth, `IR_ALLOCA` present)
     abandons the **whole function**, not just that block: half-correct control flow is worse
     than no optimisation.
- **Trimming**: `ARKCC_FEATURE_TAILMERGE` (0 for STM32_MIN or a build without MIR); runtime
  `--tailmerge`, off by default, `-O1` and above only.
- **Verdict**: `tests/run_tailmerge_tests.py` -- 23 checks, `make test-tailmerge`: static (on:
  assembly changes; off: byte-identical, and the default object equals that of a build with
  the pass compiled out), negative (final statement differs / identical suffix starts at stack
  depth 1 / suffix below the minimum / inline asm in the function -- all four untouched; plus a
  **mixed file** showing only the mergeable function gains labels, which rules out "the pass
  never ran in this TU"), dynamic (same non-trivial value on the ARM emulator), byte account
  (the constructed case must **really shrink**, and the gate prints both sizes).
- **Measured (0.9.1, host gcc/MinGW)**: `merge.c` 481 -> 448 assembly instruction lines,
  object 1146 -> 1086 bytes; the `-O0` image is byte-identical; a
  `-DARKCC_FEATURE_TAILMERGE=0` build refuses `--tailmerge` with `C3900U` while its default
  object stays byte-identical to the full build.

### P2 Tail call -> jump (**landed in 0.9.1**, 4 B each)

- **Evidence**: section 3.5, measured -- `f(x){return g(x+1);}` goes from
  `PUSH{lr}/BL/POP{pc}` to `B.W g`, while `h2/h3` cannot, because they use the result after
  the call; that is IAR's `PreservesLR` decision.
- **Where (changed from the first draft)**: no new `IR_TAILCALL` opcode. The decision is made
  at **emission time in the ARM backend**: `IR_CALL` immediately followed by `IR_RETURN`, or --
  for a void callee -- `IR_CALL` + the dummy `PUSH_INT 0` + `IR_RETURN`. That adjacency already
  means "the call's value is this function's result", because every conversion (widening,
  truncation, `_Complex` reseating, struct copy) inserts instructions in between. On top of it
  the arguments must all fit in r0-r3 (`stack_args == 0`). Emitted text:
  `MOV sp, r6` -> `ADD sp, sp, #local` -> `POP {r5, r6, r7, lr}` -> `B callee`; `lr` has to stay
  live (the `lr` variant, not the epilogue's `pc`), so the callee's own `POP {.., pc}` returns
  straight to our caller. Refused: stack arguments, indirect calls, sret, `_Complex`,
  `__naked`, `__irq`, variadic.
- **Trimming**: `ARKCC_FEATURE_TAILCALL` (0 for STM32_MIN; the whole decision block folds away);
  runtime `--tailcall`, off by default. **No `-O` gate** (same as `--reg-top`: an explicit switch
  is the intent); `docs/TAILCALL.md` is the normative description.
- **Verdict**: `tests/run_tailcall_tests.py` -- 29 checks, `make test-tailcall`: the switch really
  changes the assembly; three positive shapes assert an exact `B <callee>` line plus
  `POP {r5, r6, r7, lr}` and **no** `BL`; tail recursion becomes a branch; six refused shapes stay
  byte-identical; one TU with both shapes shows the pass is selective; the emulator returns the
  same non-trivial value; off by default (byte-identical object); a cropped build refuses the
  option with `C3900U` and its default object hashes the same as the full build's.
- **Measured (0.9.1, host gcc/MinGW, Cortex-M7)**: `tc.c` assembly 424 -> 413 lines, object
  1171 -> 1157 B; `tf`/`tf64`/`vt`/`tsum` 23->21, 23->19, 18->15, 55->53 instructions; emulator
  `off=81 on=81`.
- **Not done**: moving stack arguments, and other backends (on x86-64 / RISC-V `--tailcall` is a
  harmless no-op). Details in `docs/TAILCALL.md`.

### P3 Divide by constant -> multiply by a magic number + shift (**landed in 0.9.1**)

- **Evidence**: both sides have it (IAR `GoDivideByConstant`/`TaDivByConstant`; AC5
  `constant_multiply.c` + `no_constdiv`). Without hardware divide, `/const` calls
  `__aeabi_idiv`: 20+ cycles become 3-6.
- **Where (changed from the first draft)**: not a new IR pass but **emission time in the ARM
  backend** -- `IR_PUSH_INT c` immediately followed by `IR_DIV`/`IR_MOD` means the divisor is
  known, so the push is dropped and the magic sequence is emitted instead. The lookahead is two
  instructions deep (`x / -5` is `PUSH_INT 5` + the 32-bit negating `IR_UNARY` + `DIV`; the
  counter `divconst_skip` swallows that negation). Three unsigned shapes (power of two -> `LSR`,
  `m < 2^32` -> `UMULL` + shift, `m >= 2^32` -> the add form, with `m = (2^64-1)/d + 1` when
  `L == 32`); signed goes through the **magnitude method** (save/restore the sign around the
  unsigned sequence, remainder as `n - q*c`), and a negative divisor costs one `MVN`. Refused:
  `c == 0`, `c == 1`, signed `c == -1`, signed `|c| == 2^31`, unsigned `c == 1` -- a refusal is
  byte-identical output.
- **Trimming**: `ARKCC_FEATURE_DIVCONST` (0 for STM32_MIN; the lookahead block and the emitter
  disappear); runtime `--divconst`, off by default, and -- like `--tailcall` -- with no `-O`
  gate. `docs/DIVCONST.md` is authoritative.
- **Verdict**: `tests/run_divconst_tests.py`, 45 checks, `make test-divconst`: static shapes
  (each of the 16 cases hits its own marker and `SDIV`/`UDIV` drops to zero), selectivity within
  one TU, five byte-identical refusals, execution agreeing three ways (16 divisors x 66
  dividends, checksum `0x40F32C43`, including the `--reg-top`/`--tailcall` combinations),
  anti-false-green (off by default, `--no-divconst`, a trimmed build refusing with `C3900U`
  plus the INI guard) and an honest byte account. The math was verified in Python first:
  9,150,609 unsigned and 4,030,257 signed pairs, 0 failures.
- **Measured**: object 4293 -> 4533 B (**+240 B**), instruction lines 1743 -> 1836 (+93). It
  trades cycles, not bytes; only the two unsigned power-of-two shapes really get shorter. The
  feature's own code size (host gcc -O2 on `backend_arm.c`) is `.text` 93376 -> 95056 B
  (+1680 B), symbols 186 -> 189.

### P4 Duplicate block elimination (the whole-block form of cross-jump) -- **landed in 0.9.1**

- Same matcher as P1 without the "tail" restriction: identical blocks become one copy plus
  jumps.
- **Three decisions that had to be made while landing it** (each one prevents a specific
  wrong answer):
  1. **Blocks ending in a conditional branch are refused** -- the taken successor is named in
     the body but the fall-through successor is decided by the block's position, so identical
     bodies can walk into different code. Only a one-successor transfer named in the body is
     safe.
  2. **Jump targets are compared as blocks, not as label ids** -- `irgen` gives each arm of an
     `if` / `else if` its own merge label (`.L_two_1` vs `.L_two_3`); comparing ids misses
     exactly the most common duplicated block (the first implementation did this and the
     switch produced literally no change).
  3. **Label-only blocks are normalised first** -- adjacent merge labels each become a leader,
     producing a block that holds nothing but labels and falls through; `xb_resolve_block()`
     walks through those single-successor blocks before comparing block ids and refuses on a
     cycle.
  It also requires an empty entry stack, no label in the body, no `FUNC_BEGIN/FUNC_END`, and
  a body of at least 4 instructions.
- **Trimming**: `ARKCC_FEATURE_XBLOCK` (0 for STM32_MIN or without MIR), shared section under
  `ARKCC_FEATURE_TAILMERGE || ARKCC_FEATURE_XBLOCK`; runtime `--xblock` off by default, stage
  `ir.xblock` (allowed from -O1). `docs/XBLOCK.md` is authoritative.
- **Gate**: `tests/run_xblock_tests.py`, 26 checks, `make test-xblock`: static shape and call
  site count (`BL` 5 -> 2), four refused shapes byte-identical, same-TU selectivity, emulator
  agreement with a non-trivial value, anti-false-green (default off, `--no-xblock`, cropped
  build `C3900U` with an identical default object hash, ini key, stage table, `-O0`), and the
  byte account.
- **Measured**: 320 -> 272 assembly lines, object 869 -> 767 B (`BL g` 5 -> 2). Details in
  `docs/XBLOCK.md`.

### P5 Cross-call (interprocedural sharing) -- **explicitly not scheduled**

- The gain depends on "many similar function prologues in one image", and the cost is three
  problems: calling convention, return labels, unwind chain (the four `isn't set` in section
  2.3). arkc has no unwinder and no cross-TU IR pool today, so it could only work within one
  TU -- cost out of proportion to the gain. **Recorded, not scheduled.**

### P6 Continuous size/speed weight (`--size-weight` 0..9, **landed in 0.9.1**)

- **Evidence**: IAR makes `-z0..9` / `-s0..9` a continuous weight (0-2 Debug / 3 Low /
  4-6 Medium / 7-9 High); AC5 is the binary `-Ospace`/`-Otime`.
- **Shape**: one global weight `g_config.size_weight` (0..9, default 5) moves **four
  thresholds**: inline ceiling, unroll ceiling, tail-merge minimum length, block-merge minimum
  length. At 5 the four entries equal the 0.9.0 compile-time constants (12 / 8 / 3 / 4), so
  "not writing the option = byte-identical to 0.9.0". The four old macros
  (`ARK_INLINE_THRESHOLD` etc.) are deleted: one value, one source.
- **Different from the draft; changed**: no `-Oz/-Os/-Ot`. `-O` decides which passes run,
  these four limits only tune the trade-off inside one pass, and a `-Oz` would be read as
  changing the `-O` level too. One numeric weight, orthogonal to `-O`.
- **Trimming**: `ARKCC_FEATURE_SIZEWEIGHT` is **derived** (OR of the four pass macros) and
  `#undef`'d before deriving -- cropping only it leaves the accessors undefined (took an
  `ld returned 1` to learn). The four passes' code is not cropped by their flags, they only
  leave the stage table, so in a cropped build the accessors fall back to the historical
  constants.
- **Gate**: `tests/run_sizeweight_tests.py`, 31 checks, `make test-sizeweight`: the four
  tables + "5 = historical constants" + monotonicity + non-flat ends; no-flag and `=5` objects
  byte-identical (6 fixtures + `hello.c`); each threshold reaching `-S` text and the emulator
  (`BL h` 0/0/2 and 0/2/2, unroll 467/135/135 and 275/275/135, tail 313/302/244, block
  353/159/137); six malformed values refused with no object; a cropped build refusing and
  printing no table line; the ini key in both spellings plus an out-of-range warning; four
  fixtures returning the same value at 0/5/9; corpus bytes 5040 -> 3094.
- **Measured**: all 80 files of `examples/*.c`, HEAD versus this round: **0 differences**.
- **Functions with parameters (fixed in 0.9.1-wip)**: the debt P6 recorded in
  `docs/SIZEWEIGHT.md` section 6 was that `irgen` writes `aux = (size<<8)|slot` for
  `IR_GETARG` (scalars included), while the inline decision read `(aux>>8)!=0` as
  struct-by-value => **any function with a parameter was never inlined** (`forceinline` did not
  help either). The decision now comes from the parameter types
  (`irgen_param_slots()`); one- and two-word parameters inline, payloads carried by address and
  the C (8-byte slots) / x86-64 (one pointer word) targets still refuse. Gate:
  `tests/run_inline_tests.py` (`make test-inline`, 25 checks). Two notes: (1) P6's inline
  dimension could only be observed on parameterless callees, and its "all 80 files of
  `examples/*.c`, 0 differences" claim holds for that round only -- from 0.9.1-wip inlining a
  parameterised callee changes the default `-O2` output; (2) the `--tailcall` and `--xblock`
  gates now pass `--no_autoinline`: the former's fixtures are exactly the
  parameterised-small-callee shape and the `B leaf` rewrite would be inlined away before the
  pass ran, and the latter's duplicate blocks *are* the two calls to `g()` inside `two()` and
  `three()` (the full `make test` caught it: seven checks failed at once, object 865 -> 763
  bytes once isolated). One measurement trap
  stays: inlining is single pass, so with a startup file the copy of `main` inlined into
  `Reset_Handler` still carries its un-expanded `BL h`.

### P7 Value stack -> register allocation (`-fopt-vstack`, **landed in 0.9.1-wip**)

- **Evidence**: IAR's `08-backend-passes.md` ranks "the value stack of expression evaluation" as
  the first backend win; ARMCC's `13-regalloc-selection.md` / `14-regalloc-internals-and-open-items.md`
  describe keeping intermediate values alive in registers as a **precondition** for allocation (a
  stronger allocator cannot help once the value already went to memory).
- **How**: no new IR opcode and no change to `gen_expr`; instead a **function-level text rebuild over
  the emitted assembly** (the same pattern as the existing `ark_regalloc_function()`). A shadow value
  stack, a two-slot pool (r5/r7, already saved by the prologue => zero frame change), destination
  retargeting and textual substitution of read-only operands; when the pool runs dry it falls back to
  a real `PUSH`.
- **Slots are reference counted**: `POP r0; PUSH r0; PUSH r0` (the store sequence of a 5..8-byte
  struct return) makes one slot referenced from three places, and "return it after the first use"
  hands somebody else's value to the second.
- **Three shapes must be materialised**: read+write in the same operand (`LDR r0,[r0,#0]`),
  read in one operand and written in another (`ADD r0,r0,r1`), and the in-place three-operand forms
  (`ADC/SBC/MUL` need `Rd==Rn`); `MOVW`/`MOVT` are never retargeted (the pair builds one value).
- **Cropping**: `ARKCC_FEATURE_OPT_VSTACK` (0 under STM32_MIN, 1 on the host); off by default at
  runtime, enabled by `-fopt-vstack`, and a cropped build rejects the flag with `C3900U`.
- **Crossing boundaries**: a label / `B` / `Bcc` / `BX` / `BL` / `IT` used to bail the whole
  function whenever the shadow stack or the memory stack was non-empty, which is too tight -- many
  functions have already written every value back to the machine stack there. Now a pre-scan from
  `pro_end+1` counts `PUSH`/`POP` as open brackets and tags every unclosed `PUSH` line `cross` at a
  label/call/branch; a `cross` line emits a real `PUSH` (out of the pool register when `pend` is
  set) so the machine stack matches the original word for word; at the boundary, if the shadow stack
  is **entirely MEM**, `verbf` is set and the rest is emitted verbatim, otherwise it bails as before.
  Pool registers cannot be reconstructed, so only values already in memory may cross.
- **A third slot (r4), conditionally**: the pool grows from two slots to three, but r4 is taken
  **only when it pays**. The survey simulates the shadow depth and records the peak number of values
  on the machine stack at once (`sdmax`; a `BL` resets it because a call consumes its argument
  pushes); only `sdmax >= 3` gets r4, because a function that never holds three values saves not one
  instruction and an extra saved register is a pure loss -- on the HAL corpus 59 of 203 rewritable
  functions qualify and the 63 that were blocked saved exactly 0. The cost is paid in full: adding
  r4 to the prologue/epilogue makes `sp` 4 (mod 8), so `SUB`/`ADD sp, sp, #N` become `N+4`; the four
  lines are formatted first and replaced only if all four allocations succeed.
- **Criteria**: `tests/run_vstack_tests.py`, 23 checks, `make test-vstack`: byte-identical when off,
  fewer instructions and `PUSH`/`POP`s, **the image never grows**, no lone PUSH/POP pair left in a
  rewritten function, identical results from the off/on/on+regalloc builds on six fixtures, and the
  cropped build refuses the flag; two of the checks are about the third slot only -- `deep` must
  show `PUSH {r4, r5, r6, r7, lr}` / `POP {r4, r5, r6, r7, pc}` with `N % 8 == 4`, and `shallow`
  must have no r4 in its prologue. Every change also runs the whole `tests/arm_exec` corpus
  (`--extra=-fopt-vstack`, 36 cases, 0 failures) -- **all five semantic defects this pass ever had
  were found by it**.
- **Measurements** (crossing + third slot): the whole STM32F4 HAL corpus (`-O2 -mcpu Cortex-M4`,
  non-directive non-label lines) 47,885 -> 38,004 instructions (**-20.64%**, third slot already
  included); `-fopt-addr` on top gives 36,553 (-3.82%). Fixtures: arith 171 -> 121 instructions,
  `PUSH`/`POP` 88 -> 14, image 1392 -> 1292; loop 203 -> 140, 100 -> 12, 1480 -> 1354; struct
  1400 -> 1294; variadic 1556 -> 1458; deep 1384 -> 1354; shallow 1274 -> 1226. The r4 row is
  booked honestly: 59 functions each save one more word (about +472 bytes) for 340 fewer
  instructions, and the per-object byte size was not measured separately. Details in
  `docs/RA_VSTACK.md`.

### P8 Addressing-mode folding (`-fopt-addr`, **landed in 0.9.1-wip**)

- **Evidence**: IAR's `08-backend-passes.md` list of peepholes ranks "fold address arithmetic into
  the addressing mode" right after the value stack; ARMCC's `09-addressing-modes.md` shows AC5
  letting `LDR/STR` consume `[Rn, #imm]` / `[Rn, Rm, LSL #n]` directly instead of emitting a
  separate `ADD` for every subscript.
- **How**: again a **function-level pass over the emitted assembly** (hooked between
  `ark_vstack_function()` and `ark_regalloc_function()`). Fixed point, at most 6 rounds, three
  rules: **R1** constant offset `ADD RD,RB,#imm` + `mem Rt,[RD(,#off)]` -> `mem Rt,[RB,#imm+off]`;
  **R2** register index `ADD RD,RB,RI[,LSL #n]` + `mem Rt,[RD]` (`off` must be 0) ->
  `mem Rt,[RB,RI[,LSL #n]]`; **R3** `MOV RB,RS` + an access through `RB` -> rebase onto `RS`,
  drop the `MOV`.
- **Safety comes from a dead-value analysis**: if the destination of the `ADD`/`MOV` is still read
  later in the function the pair is not folded; the exception is the immediately following `mem`
  that itself reads it (`ad_is_load`) -- the value is eaten by the address, so it folds
  unconditionally. Barrier instructions `DMB/DSB/ISB` are skipped (they have no register operand,
  and `ad_rw()`'s "unknown means read+write everything" fallback would otherwise block `volatile`
  accesses forever; without this opening the HAL residue count stalled at 3).
- **Deliberately not done**: the two ARMv7-M write-back forms (pre-index `[Rn,#imm]!` and post-index
  `[Rn],#imm`) are measured to be **emitted zero times** by this code generator (`*p++` comes out as
  "register add + store back to the frame slot"); the only occurrences in any object file are two
  hand-written uses in `__arkcc_mcpy`, a function the pass does not visit. Implementing them would be
  dead code, so they are left out (see the main document for the details).
- **Cropping**: `ARKCC_FEATURE_OPT_ADDR` (0 under STM32_MIN, 1 on the host); off by default at
  runtime, enabled by `-fopt-addr`, and a cropped build rejects the flag with `C3900U`.
- **Criteria**: `tests/run_addr_tests.py`, `make test-addr`: byte-identical when off (OFF IS OFF),
  all four arms (base/off/on/both) **never grow the image** and the indexed addressing form really
  appears, **NO RESIDUE** (the three foldable in-place shapes must count zero in on/both -- an
  implementation that only folds the first two cannot pass), every rewritten operand is a form on the
  mnemonic whitelist, all four arms compute the same answer under unicorn, and a cropped build
  refuses the flag.
- **Measurements**: the whole HAL corpus `examples/ark_test/ark_test_all.c` (STM32F401xE, `-O2`),
  measured on the post-vstack baseline (third slot included) of 38,004 instructions:
  38,004 -> 36,553 (**-1,451 / -3.82%**); the register-index residue drops 1,075 -> 0 and the
  `MOV` form 0 -> 0. The total drop is larger than 1,075, so R1 (the immediate-offset form) does
  fire on the new baseline; no per-rule attribution was measured, so none is claimed. Stacked on
  plain `-O2`: 47,885 -> 38,004 -> 36,553. Details in `docs/ADDR_FOLD.md`.

### P9 Strength reduction (`-fopt-strength`, **landed in 0.9.1-wip**)

- **Evidence**: AC5 emits `LSLS` for `x * 4`, emits `LDR r4, [r3, r2, LSL #2]` directly for
  `p[i]`, and emits one scaled `ADD` for `x * 3` (measured with
  `armcc --c99 -O2 -c --cpu Cortex-M4` plus `fromelf --text -c`). A real compiler never routes a
  constant multiply through `MUL`.
- **Two landing points, one switch**: of the 1,105 `MUL` instructions in the HAL corpus, 1,052 are
  `IR_LOAD_IDX` stride scaling (`i * sizeof(elem)`, `MOV r2,#4` 1,043 times and `#2` 9 times) and 53
  are source-level constant multiplies. The IR **cannot see the former at all** (it only holds an
  `IR_LOAD_IDX` node), so: **A** `opt_strength_func()` in `src/opt.c` rewrites an adjacent
  `PUSH k` + `MUL` (k a power of two) into `PUSH log2(k)` + `SHL`, deleting both when k==1;
  **B** `IR_LOAD_IDX` in `backend_arm.c` emits `LSL r1, r1, #n` instead of `MOV r2, #es` +
  `MUL r1, r2` when `es` is a power of two. Two flags would force users to enable both.
- **Powers of two only**: `MUL` is one cycle on Cortex-M4 and an `LSL`+`ADD` chain is never
  shorter (measured, not assumed); `x*3` keeps its `MUL` and that is asserted in the gate, so a
  later "helpful" change cannot extend the rule into a shift/add chain.
- **The stage position was measured**: the first version sat after `ir.dce` and made the output
  **bigger** (pow2 fixture 512 -> 533 instructions, image 2128 -> 2170 B) -- deleting `x*1`
  dropped one function's IR from 12 to 10 instructions, under the `opt_inline` threshold, so it got
  inlined. Moving the row after **`ir.xblock`** (before `ir.vectorize`) means inline /
  const-global / tailmerge / xblock see the same IR shape as before, and the problem disappeared
  (512 -> 503).
- **Cropping**: `ARKCC_FEATURE_OPT_STRENGTH` (0 under STM32_MIN, 1 on the host -- cropping it from
  the board is correct since the pass is off by default and would only sit in Flash). Off by
  default; `-fopt-strength` enables it; a cropped build refuses the flag with `C3900U`.
- **Criteria**: `tests/run_strength_tests.py`, 14 checks, `make test-strength`: OFF IS OFF
  byte-identical, instruction count down, **`MUL` at zero**, **`LSL r1,r1,#n` appears** (an IR-only
  implementation fails this), **no `PUSH #2^k`+`MUL` residue**, the `odd` fixture byte-identical,
  the image never grows, all five arms agree, and a cropped build refuses the flag.
- **Measurements**: plain `-O2` 47,885 -> **46,779** (**-1,106 / -2.31%**), `MUL` **1,105 -> 12**
  (all 12 remaining are value x value, none constant); on top of the 36,553 of
  `-fopt-vstack -fopt-addr` -> **35,453** (-1,100 / -3.01%). Full chain:
  **47,885 -> 38,004 -> 36,553 -> 35,453 (-25.96%)**. Object bytes: 115,090 -> 112,878
  (-2,212 B); 92,408 -> 90,208 (-2,200 B). Details in `docs/STRENGTH.en.md`.

---

---

## 3 How this relates to the stage table (two layers of trimming)

| Layer | Mechanism | Guarantee when off |
| --- | --- | --- |
| Compile time | `ARKCC_FEATURE_*` | code and strings disappear; the stage row stays for numbering with `built_in=0`; the option is refused with `C3900U` |
| Run time | `--<pass>` / `-fno-<pass>`, INI key | image byte-identical to a build without the pass |
| Profile | `--pipeline=lite` | expensive stages skipped with a reason; `full` equals "not written" byte for byte |

All three need gate coverage: **being switchable off** and **leaving no trace when off** are
two different claims.

---

## 4 Known debts (unrelated to optimisation, recorded)

See `docs/BOARD_VALIDATION.md` section 8: about 1.3 KB of arena per statement, a long
`double` literal off by 1 ulp, `aeabi_float.c` not uploaded to the board, occasional serial
RX byte loss, `pyocd -m` needing a fixed cwd. The optimisation line does not touch these, but
they constrain how it can be verified (e.g. the board cannot run a fully unrolled large
function).
