# The 0.9.x optimisation line: from three reverse-engineering dossiers to arkc's stage table

[中文](OPTIMIZER_PLAN.md) | English

0.9.0 is the stable release: **pin down "it compiles correctly" first, then make it
"compile better"**. This document is the map for 0.9.x. Every item states four things:
**where the evidence comes from, which stage it lives in, how it is trimmed away, and how
we prove it actually helps.**

> **Note on figures**: the numbers quoted inside each item are **historical**, taken when that
> optimisation landed (constant materialisation was still in its old form and vstack had no
> per-block resume yet). The authoritative per-step table for the current binary is in
> `docs/COMPARISON.md` section 5; where the two disagree, that table wins.

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

## 2 The line: twelve items, ordered by value per unit of work

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
  set) so the machine stack matches the original word for word. At the boundary, an **entirely MEM**
  shadow stack is flushed and the **next basic block is optimised from an empty register state**
  (no longer the whole tail verbatim); anything else is cut. Pool registers cannot be reconstructed,
  so only values already in memory may cross. The pre-scan must test the **label** form before the
  directive form -- `.L3:` both starts with a dot and is a label, and the wrong order left every
  branch target untagged (18 HAL functions fell back entirely).
- **Cutting in the middle**: an unnameable shape no longer bails the whole function; the optimised
  prefix is kept. When the shadow-stack shape is `00...011...1` (every `MEM` word below every pool
  word), the pass emits `PUSH {pool reg}` in stack order to reconstruct the original machine stack
  word for word and copies verbatim from that line; only a shape that fails this falls back to
  emitting the whole function unchanged. That yields the **never-worse guarantee**: a function is
  fully rewritten, rewritten up to some line and copied after it, or untouched.
- **A third slot (r4), conditionally**: the pool grows from two slots to three, but r4 is taken
  **only when it pays**. The survey simulates the shadow depth and records the peak number of values
  on the machine stack at once (`sdmax`; a `BL` resets it because a call consumes its argument
  pushes); only `sdmax >= 3` gets r4, because a function that never holds three values saves not one
  instruction and an extra saved register is a pure loss -- in a pre-crossing HAL count 59 of 203
  rewritable functions qualified and the 63 that were blocked saved exactly 0. The cost is paid in full: adding
  r4 to the prologue/epilogue makes `sp` 4 (mod 8), so `SUB`/`ADD sp, sp, #N` become `N+4`; the four
  lines are formatted first and replaced only if all four allocations succeed.  **Frame-less
  functions** (no parameters, no locals -- the prologue has no `SUB sp` at all) take a second path:
  `PUSH`/`POP` become five-register forms plus one `SUB sp, sp, #4` emitted **after** `MOV r6, sp`
  (no `ADD`: the epilogue's `MOV sp, r6` discards the padding; put it before the `MOV` and every
  call leaks one word of the caller's stack).  In the same pre-crossing count, 28 of the 81
  frame-less functions crossed the threshold this way.
- **Criteria**: `tests/run_vstack_tests.py`, 45 checks, `make test-vstack`: byte-identical when off,
  fewer instructions and `PUSH`/`POP`s, **the image never grows**, no lone PUSH/POP pair left in a
  rewritten function, identical results from the off/on/on+regalloc builds on eight fixtures, and
  the cropped build refuses the flag; two checks are about the third slot only -- `deep` must show
  `PUSH {r4, r5, r6, r7, lr}` / `POP {r4, r5, r6, r7, pc}` with `N % 8 == 4`, and `shallow` must
  have no r4 in its prologue; two more cover crossing and cutting -- the block after a `branch`
  label must be rewritten too, and `callptr`'s `POP {ip}` must survive verbatim with no leftover
  adjacent pair before it. Every change also runs the whole `tests/arm_exec` corpus
  (`--extra=-fopt-vstack`, 39 cases, 0 failures) -- **all five semantic defects this pass ever had
  were found by it**.
- **Measurements** (crossing + cut + third slot): the whole STM32F4 HAL corpus (`-O2 -mcpu
  Cortex-M4`, non-directive non-label lines) 47,885 -> 36,532 instructions (**-23.71%**), 30
  functions changed and **none grew**; `-fopt-addr` on top gives 34,915 (-4.44%), `-fopt-strength`
  on top of that 32,901. Fixtures: arith 171 -> 121 instructions, `PUSH`/`POP` 88 -> 12, image
  1392 -> 1292; loop 203 -> 140, 100 -> 12, 1480 -> 1354; struct 1400 -> 1294; variadic 1556 ->
  1422; deep 1384 -> 1354; shallow 1274 -> 1224; branch 152 -> 116, 74 -> 18; callptr 158 -> 127,
  78 -> 30. The r4 row is
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
  measured on the post-vstack baseline (third slot, crossing and cut included) of 36,532
  instructions: 36,532 -> 34,915 (**-1,617 / -4.44%**); the register-index residue drops 1,084 -> 0
  and the `MOV` form 0 -> 0. The total drop is larger than 1,084, so R1 (the immediate-offset form)
  does fire on the new baseline; no per-rule attribution was measured, so none is claimed. Stacked
  on plain `-O2`: 47,885 -> 36,532 -> 34,915. Details in `docs/ADDR_FOLD.md`.

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
  A later half, **R4** (same `-fopt-strength` switch, implemented in `ark_addr_function()`'s
  round loop): once `-fopt-addr`'s R2 has removed the `ADD`, the `LSL` sits next to the access
  and R4 merges the pair into one `[Rn, Rm, LSL #n]` (only `LDR`/`STR`, `n in 1..3`,
  `rI != rB`, and `rS` dead afterwards). Alongside it, a liveness defect in `ad_rw()` was
  fixed: `POP` was counted as a read, so `POP {r1}` kept r1 alive forever. Fold count 243 -> 924.
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
- **Criteria**: `tests/run_strength_tests.py`, **18 checks**, `make test-strength`: OFF IS OFF
  byte-identical, instruction count down, **`MUL` at zero**, **`LSL r1,r1,#n` appears** (an IR-only
  implementation fails this), **no `PUSH #2^k`+`MUL` residue**, the `odd` fixture byte-identical,
  the image never grows, all five arms agree, and a cropped build refuses the flag. R4 adds four:
  the merged `[rB,rI,LSL #n]` exists on `all` (1), is 0 on `on`, is 0 on `va`, and `LSL #1..3`
  strictly decreases (3 -> 2, with the 1 residue coming from `ad_dead_after` bailing out at a label).
- **Measurements**: plain `-O2` 47,885 -> **46,779** (**-1,106 / -2.31%**), `MUL` **1,105 -> 12**
  (all 12 remaining are value x value, none constant); on top of the 34,915 of
  `-fopt-vstack -fopt-addr` -> **32,901** (-2,014 / -5.77%). The 924 folds of R4 (the LSL folded
  into the addressing mode) are a pre-crossing sub-measurement and were not re-measured on their
  own here, so only the whole-arm figures are quoted. Full chain:
  **47,885 -> 36,532 -> 34,915 -> 32,901 (-31.29%)**. Object bytes: base 116,480 -> 114,180
  (-2,300 B); on top of vstack+addr 89,010 -> 86,730 (-2,280 B). R4 **does not change bytes**:
  each merge trades two 16-bit instructions for one 32-bit one, so only the instruction count
drops.
  Details in `docs/STRENGTH.en.md`.

### P10 Zero-compare branch folding (`-fopt-cbz`, **landed in 0.9.1-wip**)

- **Evidence**: AC5 emits a single `CBZ`/`CBNZ` for a zero-compare branch such as
  `if (!p)` (`armcc --c99 -O2 -c --cpu Cortex-M4` + `fromelf --text -c`), while arkc spent a
  `CMP rX, #0` plus a 32-bit `B<cond>.W`.
- **One rule**: a `CMP r0-r7, #0` immediately followed by `BEQ/BNE` (only metadata lines in
  between) becomes `CBZ/CBNZ rX, .L_x` with the branch deleted. Four necessary conditions:
  adjacency; narrow operands; a forward target whose upper bound is at most 64 bytes; and
  **the flags are dead** (no flag reader before a flag writer, a return, or the function end;
  an unconditional `B` is followed to its target).
- **Offset derivation, written down**: after folding, `offset = region bytes - 2`, independent
  of how far the label was from the `CMP` (the deleted `CMP` and the deleted branch sit at the
  two ends and their shifts cancel).
- **Conservative upper bound**: the text layer cannot see real widths, so each instruction
  counts as 4 bytes and `LDR =sym` as 8; a data directive in the region drops the candidate.
  The bound can only make the pass give up, never emit an out-of-range `CBZ`.
- **Why it was tricky**: every `if` body ends with `B .L_end`; the first version called `B`
  unsafe and fused nothing. Following the target fixed 5/5 in the fixture. The other real
  defect was rebuilding from the trimmed lines, which erased the indentation of the whole
  function.
- **Cropping**: `ARKCC_FEATURE_OPT_CBZ` (0 under STM32_MIN, 1 on host), off by default; a
  cropped build refuses the flag with `C3900U`. `CBZ`/`CBNZ` left the `--asm-extra` list (a
  compiler has to assemble its own output, same as `ADDS`/`SUBS`).
- **Gate**: `tests/run_cbz_tests.py`, **14 checks**, `make test-cbz`: OFF IS OFF byte for
  byte; CBZ only with the flag; the count drops; the adjacent pairs are consumed; it still
  pays on top; it runs after vstack/addr; the image never grows; all five arms agree; an
  out-of-range body (upper bound 80 bytes) is never folded; nothing is rewritten when the
  target is too far; the image is unchanged; a cropped build refuses the flag and still
  compiles without it. Plus the whole `tests/arm_exec` corpus (0 failures).
- **Measurements**: plain `-O2` 47,885 -> **47,491** (-394 / -1,620 B over 96 translation
  units); full chain 32,901 -> **32,478** (-423 / -1,736 B). Each fusion saves 2 to 6 bytes
  (16-bit `CMP` + 32-bit `Bcc` -> 16-bit `CBZ`). Of the 814 adjacent pairs in the HAL corpus 394
  were fused; the rest hit the 64-byte bound or still read the flags.
  Details in `docs/CBZ_FOLD.en.md`.

### P11 Short-branch shrinking (`-fopt-branch`, **landed in 0.9.1-wip**)

- **Evidence**: this backend has always emitted 32-bit `B` / `B<cond>` (`B.W` T4 +-1MB,
  `B<cond>.W` T3 +-1MB), because the `op_size_a()` sizing round does not know label
  addresses yet and a 16-bit form that does not fit is truncated silently -- which
  actually happened once after `-fopt-vstack` (a truncated loop back-edge,
  `UC_ERR_WRITE_UNMAPPED`).
- **How**: it lives **inside the assembler**. The measuring round lays every branch out
  at four bytes and records `(pc, cond, target name)` plus the `.align` positions;
  `arm_decide_branches()` tests `off = target - (pc+4)`, `-256..254` for a conditional
  (T1 imm8) and `-2048..2046` for an unconditional one (T2 imm11), rejecting odd offsets;
  a forward target is reduced by another 2 (the upper bound from this branch's own 4 -> 2);
  **any span crossing `.align` is refused** (non-linear padding would oscillate). If any
  decision changed, pass 1 runs again (now at real 2/4-byte widths, so alignment padding is
  exact), then pass 2 emits the two-byte form by ordinal, falling back to 32 bits when
  `cond` or the target name does not match.
- **The big trap**: the second pass-1 round must lay out the final widths. The first
  version still sized at four bytes while pass 2 emitted two, so labels were never re-laid
  and **every following instruction moved two bytes earlier** -- branches landed in the
  middle of instructions (`addr=0`, `pc=0x8000C2A`). `add_branch_a()` now returns the
  width it reserved and pass 1 advances `pc` with it.
- **Fail rather than lie**: `emit_b16_a()` recomputes the offset and raises a hard error
  (`internal layout error`) plus a `NOP` instead of encoding a truncated offset.
- **Cropping**: `ARKCC_FEATURE_OPT_BRANCH` (STM32_MIN 0 / host 1), off by default; at 0 the
  plan fields and call sites disappear entirely (no fields, no code, no size change) and a
  cropped build refuses the flag with `C3900U`.
- **Gate**: `tests/run_branch_tests.py`, **18 checks**, `make test-branch`: OFF IS OFF
  byte-identical, instruction count unchanged, whole-2-byte shrink, still pays on top of
  vstack/addr, the image never grows, five arms agree, **far targets (200- and 300-statement
  loop bodies) keep their 32-bit form**, the cropped build refuses the flag and still
  compiles without it. "Far" uses a **differential test**: a minimal reference program
  measures what the runtime helpers save on their own (10 B) and far/vfar must save exactly
  that -- one extra byte would mean a long branch had been squeezed into 16 bits.
- **Measured**: `near` fixture 1,386 -> 1,368 B (-18, count stays 160), `va` arm
  1,294 -> 1,276 B; STM32F4 HAL, 96 units, code sections 116,480 -> **113,058 B
  (-3,422 B / -2.94%)**, 96/96 shrink with nothing growing (the symbol table is unchanged,
  so every saved byte is code). Details in `docs/BRANCH_SHRINK.en.md`.

### P12 Pairing value-stack operands (`-fopt-pair`, **landed in 0.9.1-wip, slice S1**)

- **Why start here**: the IR is a stack machine, so `a & b` reaches the backend as
  `PUSH/PUSH/POP/POP/AND` -- four of the five instructions only move operands.
  The ten-switch baseline over 95 HAL translation units is **19,112 instructions /
  45,760 bytes**, with the histogram `MOV 3903 / LDR 2457 / ADD 1460 / STR 1163 /
  MOVW 1115 / PUSH 1060 / CMP 1035 / MOVT 981`: `MOV` plus `LDR` is 33% of the
  total and almost all of it is stack traffic and the temporaries it drags in.
  The text layer is measured out on the same corpus (`ADD rD,rS,#0` 463,
  `MOV#imm+LSL` 326, only 3 pairable `PUSH/POP` => at most ~1.7%), so the next
  step has to be where operands land at the IR level.
- **One rule**: `IR_PUSH A; IR_PUSH B; IR_BINARY op` becomes `A->r0; B->r1; op`
  with no stack traffic. The net stack effect is +1 (the result is still pushed
  for its consumer), so this is word-for-word equivalent to the old two-push,
  two-pop sequence.
- **What may be an operand** (`pair_operand_ok`): a stack slot (`aux` slot < 8,
  not `IR_AUX_VOLATILE`), an immediate, `IR_PUSH_ADDR`, a global address, or a
  global scalar that is not a va pointer and is smaller than 8 bytes (loaded with
  `LDR/LDRB/LDRH/LDRSB/LDRSH` by width). **Refused**: volatile, 64-bit values,
  va pointer symbols, objects over 8 bytes, and any shape not on that list -- a
  stack round trip is better than a wrong answer.
- **Two stand-down rules, both paid for in measurements**:
  1. **Stand down for `-fopt-imm`**: when the second operand is an encodable
     constant, `ADD r0, r0, #4` is always one instruction cheaper than
     `MOV r1, #4` plus `ADD r0, r1`. Without this rule the first version went
     19,112 -> **20,517 (+1,405)** on the corpus, with `hal_dma.c` alone at +404.
  2. **Stand down for `-fopt-cbranch`**: a comparison consumed by the next `if`
     is two instructions cheaper as `CMP + Bcc` than materialise-and-test again,
     and `-fopt-cbranch` lives inside `case IR_BINARY`, so a pair that bypasses
     that case silently disables it. With the rule 19,179 -> **19,096**, and
     every translation unit is flat or better.
  Both stand-down tests **reuse the existing helper**
  (`emit_binary_imm(b, op, v, left=0, emit=0)`) instead of introducing a second
  set of thresholds that could drift.
- **Trimming**: `ARKCC_FEATURE_OPT_PAIR` (`STM32_MIN` 0 / host 1), off by
  default and present only in host and cross builds. A cropped build refuses
  `-fopt-pair` by name (`C3900U`) and still compiles without the flag.
- **Gate**: `tests/run_pair_tests.py`, **20 checks**, `make test-pair`:
  OFF IS OFF byte-for-byte (`-O2` == `-O2 -fno-opt-pair`), the default build
  still shows 8 stack operations, the pass removes exactly 4 of them so
  `AND r0, r1` reads both registers directly, instruction and image sizes only
  shrink, the label set is untouched, `a+4` is byte-identical with and without
  `-fopt-imm`, `if (a<b)` is byte-identical under `-fopt-cbranch` **while
  without that flag the pair pass does take the comparison** (a differential
  control so "never looks at comparisons" cannot pass), a 64-bit and and a
  volatile read are byte-identical, all five fixtures return the same value in
  both arms under unicorn, and a cropped build refuses the flag.
- **Measured** (95-TU HAL corpus, `-fopt-pair` on top of the ten switches):
  **19,112 -> 19,096 (-16 instructions, 0.08%)**, `fails 0`, `MOV 3903 -> 3888`;
  per file `hal_gpio.c -5, hal_cortex.c -3, hal_rcc.c -3, hal_dma.c -2,
  ll_utils.c -2, system_stm32f4xx.c -1`, the other 89 units flat, **none larger**.
- **Why keep a 0.08% step**: it exercises the whole plumbing-and-gate template --
  where a new pass sits, how it stands down, OFF IS OFF, a two-way differential
  control, refusal in a cropped build, and equal values in the emulator -- that
  S2-S5 will reuse unchanged. `-fopt-vstack` already turns a single `PUSH {r0}`
  into a shadow register (`a+b` is only three instructions in the baseline),
  so the room left at this layer was small to begin with.
- **Staged plan (S2-S5, none started)**:
  - **Status (2026-11-23)**: S2 landed as `-fopt-slotreg` and was **archived** under the <0.5%
    falsifier (P17); S3 is now pre-registered as **P18** (`docs/OPERAND_ALLOC.md`), whose slice
    S3a has landed as `-fopt-constcache` and whose slice S3b has been **measured and closed** under
    the same <0.5% falsifier (0.11%, section 9); S4/S5 remain registered only.
  - **S2 intra-function virtual-register colouring**: longest live range inside a
    straight-line block only, no call sites, pool r8-r11 (callee-saved, same reason as
    `-fopt-regalloc`; the slice is defined in `docs/SLOT_REGISTERS.en.md`); the goal is to turn
    "load it back for every use" into "keep it in a register across the block".
  - **S3 call sites and blocks**: values live across `BL` go into callee-saved
    registers (cost: 4 bytes per function in the prologue) and only when a
    "bytes of LDR saved > PUSH cost" balance says so.
    **Status (2026-11-23)**: measured -- the genuine cross-call opportunity is 5 pairs / 0.11%, so
    the slice is **closed** under the falsifier.
  - **S4 spills and high registers**: r8-r11 only under the same positive
    balance, with the same tiering threshold the near-slot regalloc uses.
  - **S5 merge with vstack**: pick one instead of stacking both (they fight over
    the same round trips); the corpus decides which one stays on by default.
- **Risks recorded**: overlapping responsibility with `-fopt-vstack` (S5 has to
  be a subtraction); rising register pressure spills long live ranges; debug
  readability (variable locations must survive under `-g`); board size (whether
  S2 and above is worth keeping under `STM32_MIN` is a question only the
  `make stm32-check` size gate can answer).

### P13 Local-slot constant propagation + dead-store elimination (`-fopt-prop`, **landed in 0.9.1-wip**)

- **Diagnosis**: across the 95-TU HAL corpus there are **1,974 local loads (10.3%)** and
  1,163 `STR`s against frame slots, and `MOV+LDR` (build a temp address/value, then read it
  back) accounts for 33% of them. Most of those loads read a slot that was written once and
  never changed afterwards -- declaration initialisation is the typical case.
- **Two halves, one byte map**: `valid[off]` marks "this byte's constant value is known",
  `bytes[off]` holds the value.
  - **Forward propagation**: one straight-line sweep. `IR_PUSH_INT/IR_PUSH_ADDR` and a
    non-volatile `IR_PUSH_VAR` of known width mark their bytes valid; a `PUSH_VAR` whose
    bytes are all known is sign/zero-extended exactly per `LDRB/LDRSB/LDRH/LDRSH/LDR` and
    rewritten to `IR_PUSH_INT`; a store marks its bytes; a label, branch, call, `ASM`,
    `ALLOCA` or a frame-address escape clears the map (no guessing across joins).
  - **Backward dead-store elimination**: byte-level liveness swept backwards. A store whose
    bytes are all dead, and whose producer is droppable (`PUSH_INT/PUSH_ADDR`, width 1/2/4,
    non-volatile `PUSH_VAR`), is turned into `IR_NOP` together with that producer; the
    `IR_NOP`s are then compacted away.
- **Two size gates, each paid for by a measured regression**:
  1. `prop_imm_one_instr()` only replaces constants that fit one ARM instruction. Without it,
     a frame `LDR` (1 instruction) became `MOVW+MOVT` (2), and the corpus grew from 19,112 to
     **19,128 (+16)**.
  2. **Redundant-load skip**: a `PUSH_VAR` that immediately follows an `IR_STORE` covering
     all of its bytes is not replaced. The value is still in the top-of-stack register, so
     `-fopt-imm` already folds that load into zero instructions; rewriting it to `PUSH_INT`
     at IR level adds a `MOVW`. Without this rule the corpus was 19,118 (+6), with
     `hal_dma/hal_flash/hal_flash_ex/gpio` all larger.
- **One relaxation, argued not assumed**: backward liveness marks everything live at
  `CALL/LOAD_IDX/STORE_IDX/MEMCPY/STORE_GLOBAL/...` only when the function contains an
  `IR_PUSH_ADDR` (its frame address escaped). In this IR `IR_PUSH_ADDR` is the only way to
  obtain a frame address (all 24 emission sites in `irgen.c`: aggregate init, bitfields,
  taking an address, passing by address), so without it no callee, pointer write or memcpy
  can name a byte of the frame. Before this relaxation the pass saved 6 instructions; with
  it, **29**.
- **Trimming**: `ARKCC_FEATURE_OPT_PROP` (`STM32_MIN` 0 / host 1), off by default, enabled on
  top of `-O2`. A trimmed build refuses `-fopt-prop` with `C3900U` and still compiles without
  the flag. The `ir.prop` stage row trims to all zeros (`built_in=0`, null function pointer),
  `ARK_PROFILE_LITE`, minimum level 1.
- **Gates**: `tests/run_prop_tests.py`, **36 checks**, `make test-prop`. Highlights: OFF IS
  OFF byte-identical; a declaration-initialised dead store goes 3->2 with the image not
  growing; both arms of an `if/else` merge and a `volatile` store stay byte-identical; a slot
  read through a callee (true escape) and a still-read slot keep their store count; a slot
  that is never address-taken can be dropped even when the function is called; a
  pure-constant read goes 2->0 and the function shrinks; seven fixtures return the same value
  on unicorn with the pass off and on; the trimmed build refuses the flag. Every gate passes
  `-fno-opt-inline`: inlining is a size-driven decision, so deleting one instruction can push
  a small `static` over the threshold, and then the gate would be measuring the inliner.
- **Measured (ten switches plus `-fopt-prop`)**: **19,112 -> 19,083 (-29 instructions, 0.15%)**,
  `fails 0`; `MOV 3903 -> 3889`, `STR 1163 -> 1148` (exactly 15 `PUSH;STORE` pairs removed),
  every other mnemonic unchanged; per file `hal_flash_ex.c -12, main.c -4, hal_pwr_ex.c -4,
  ll_utils.c -4, gpio.c -2, hal_cortex.c -2, hal_flash.c -1`, the rest unchanged, **nothing
  larger**.
- **Honest conclusion (important)**: instrumented counters show `replaced=0` and
  `removed_pairs=15` on this corpus -- **forward propagation earns nothing on the HAL**,
  because `-fopt-imm` already tracks register-resident values at the text level, and almost
  every IR-visible "read of a known constant" is a form it already folds for free (that is
  where the redundant-load skip came from). All the value comes from backward DSE, and dead
  stores are simply rare in the HAL (declaration init followed by immediate overwrite). This
  says the **text-level budget is genuinely exhausted**: 0.15% is close to the measurable
  limit here, and the next step has to be IR-level register allocation (P12's S2 onwards),
  not more local rules.

---

### P14 Throwing away the read-back of a statement assignment (`-fopt-deadpush`, **landed in 0.9.1-wip**)

- **Measure first**: on the 19,083 lines produced by the ten switches plus `-fopt-prop`, we asked what S2
  (register allocation) could actually buy:
  - straight-line blocks that load the same frame slot twice with no store or clobber in between:
    **56 instructions (0.3%)**;
  - a `STR` followed later in the same block by a read of the same slot (`STR -> LDR` round trip):
    **203 places**, distances 1:51, 2:25, 3:44, 4:14, 5:6;
  - **dead frame reads (the destination is never read afterwards): 0**.

  So the remaining room needs real register allocation; a single local rule is capped below 1%, and the
  "drop dead `LDR`" direction has exactly zero yield on this corpus, so it was ruled out first.
- **The rule**: for a statement-level assignment to a local, `irgen.c` emits `IR_STORE` and then an
  `IR_PUSH_VAR` (the source comment says "Re-load the stored value"); for an expression statement the very
  next instruction is the `IR_POP` that discards it. The predicate is therefore narrow: `IR_PUSH_INT` /
  `IR_PUSH_ADDR` (always one word) or an `IR_PUSH_VAR` of width 0/1/2/4 (one word) / width 8 (two words)
  **followed immediately by n `IR_POP`s** becomes `IR_NOP`, with a final `compact_func`.
- **Conservative edges (keep a redundant stack round trip rather than a wrong answer)**: volatile reads
  have observation semantics and are excluded; `IR_AUX_COMPLEX` (16, four words) is not "one value" and is
  excluded; width 8 with a mismatched number of pops is not recognised; only *adjacent* pops count and no
  liveness analysis is performed -- falsifiable, explainable, no CFG needed.
- **Trimming**: `ARKCC_FEATURE_OPT_DEADPUSH` (STM32_MIN 0 / host 1), off by default; the stage row
  `ir.deadpush` runs under `ARK_PROFILE_LITE` at minimum optimisation level 1; a trimmed build refuses
  `-fopt-deadpush` with `C3900U`.
- **Gates**: `tests/run_deadpush_tests.py`, **25 checks**, `make test-deadpush`. Highlights: OFF IS OFF is
  byte-identical; a statement assignment goes from 3 to 2 `LDR`s and the image does not grow; a **used**
  assignment (`z = (y = a + 1) + 2`) loses only the outer one while the inner read-back stays; the
  `volatile` function text is byte-identical and its `LDR` count unchanged; a `long long` assignment goes
  from 5 to 3 `LDR`s with the same return value; all four fixtures agree off vs on under unicorn; the
  trimmed build refuses the switch yet compiles without it. Every gate passes `-fno-opt-inline`, for the
  same reason as in P13.
- **Measurement (ten switches + `-fopt-prop` + `-fopt-deadpush`)**: **19,083 -> 19,066 (-17, 0.09%)**,
  `fails 0`; against the ten-switch baseline of 19,112 this is **-46**. Histogram: `LDR 2457 -> 2443`,
  `MOV 3889 -> 3888`, nothing else moves. Per file (against 19,112): `hal_flash_ex -12, hal_cortex -10,
  ll_utils -6, main.c -4, hal_pwr_ex -4, gpio -2, hal_exti -2, hal_gpio -2, hal_pwr -1, hal_rcc -1,
  hal_rcc_ex -1, hal_flash -1`; no unit grows.
- **Honest conclusion**: the 56 repeated loads and the 203 round trips are the real S2 prize; this pass
  removes exactly one shape (the read-back of a statement assignment) for 0.09%. Closing the roughly 3.4x
  gap to armcc/gcc therefore requires P12's S2: intra-function virtual-register colouring (r8-r11,
  straight-line blocks only, nothing across a call), also off by default and trimmable.
- **Next step (S2 pre-registration sketch)**: virtual registers cover only live ranges inside one
  straight-line block that never crosses a call or a label; they compete with `-fopt-vstack` for the same
  stack round trips, so if the combination turns negative only vstack stays on by default (rule S5);
  spilling is conservative (a range interrupted by a call is abandoned). The gates stay "byte-identical
  when off, image never larger when on, 95/95 differential parity".

---

### P15 Slot-level register promotion (S2 pre-registration, **not implemented**)

- **Why a separate entry**: after P7 through P14 took the HAL corpus from 47,885 instructions down to
  19,066, the remaining room can no longer be eaten by "one more text rule" -- see below.
- **Measured room (on top of the twelve switches)**: frame traffic still accounts for **18.8%**
  (`LDR` 2,443 + `STR` 1,148 out of 19,066); 56 repeated loads inside a straight-line block, 203
  `STR -> LDR` round trips on the same slot, **0** dead frame reads. So shape-exact text rules are
  capped at roughly **0.7%**, and "drop dead `LDR`" has exactly zero yield.
- **The key counter-example**: the existing `-fopt-regalloc` family selects **not a single slot** on
  the HAL in its default mode; `-fopt-regalloc-near` turns `LDR -73`, `STR -58` into `MOV +131` and
  leaves the **total unchanged**. The remaining frame accesses are therefore not redundant accesses but
  the product of a model in which every intermediate has to pass through r0.
- **Next step (slice S2a)**: block-local slot caching -- a promoted slot moves between a `clean` and a
  `dirty` state, writes back only when a block ends dirty, is costed as `(F + W) - (R + S)` and applied
  only when that is negative; it uses r8-r11 (callee-saved, widening PUSH paid once per function),
  reuses the taint proof and frame-shifting code of `ark_regalloc_function()`, never spills and never
  crosses a block.
- **Gates and falsification conditions are frozen**: seven gates (OFF IS OFF, off by default, never
  grows, block consistency, unicorn parity, trimming via `C3900U`, no cross-backend drift) and four
  falsifiers (total drop below 0.5%, any TU growing, needing a spill to pass, a negative stack on top
  of `-fopt-vstack`). All of it lives in `docs/SLOT_REGISTERS.md` (Chinese) /
  `docs/SLOT_REGISTERS.en.md` (English); after implementation only a "measurement" and a "verdict"
  section may be appended.
- **Deferred (2026-11-23)**: measure before building paid off once more here -- see P16: the
  "duplicated constant materialisation" family measures 1.77% on its own, an order of magnitude more
  than the 0.7% text-layer room estimated on this page, so S2a is sequenced after P16.
- **Landed and archived (2026-11-23)**: after measurement S2a became delete-only and was
  archived; see **P17**.

---

### P16 Duplicated constant materialisation (`-fopt-cmat`, **landed in 0.9.1-wip**)

- **Why it went first**: P15's pre-registration bounded the text-layer room at "<=0.7%" (framed as
  frame traffic, repeated loads, same-slot round trips). That accounting missed a whole family: the
  value-stack backend materialises **the same constant twice** (`MOV r7, #0` into the index register,
  then `LDR r7, [r5, r1, LSL #2]` folding it back into the addressing mode) and also writes the scratch
  register twice in a row. Measured on top of the twelve switches this family is **1.77%** -- an order
  of magnitude more than the pre-registered estimate -- so it was taken first and S2a deferred.
- **Three rules**: M1 a copy of a known 0..255 constant becomes an immediate; M2 a known index is folded
  into the addressing mode (`k<<s <= 4095`, `rI != rB`); M3 a flag-neutral write overwritten later in the
  block before any read is dropped. None of them needs liveness analysis.
- **Two fatal miscompiles (fixed, and pinned by the gate)**: (1) a two-operand ALU instruction reads its
  own destination (`MUL r0, r7`) -- the second version limits the source part to what follows the first
  comma and recognises read-modify-write forms; (2) the first operand of `STR` is a source, and the first
  version treated it as a destination and deleted the copy that had just loaded the value.
- **`MOVW`+`MOVT` is handled as a unit**: dropping half of it leaves a different value, so the pair is
  fused into one unit in the implementation.
- **One rule that was removed**: the first draft also de-duplicated a same-value `MOVW`/`MOVT` pair. It
  fires **zero** times on the corpus, so it was deleted and the rules renumbered -- which is itself a
  finding.
- **Trimming**: `ARKCC_FEATURE_OPT_CMAT` (`STM32_MIN` 0 / host 1), off by default; the ~300 KB BSS of
  static tables exists only in host builds; a cropped build refuses `-fopt-cmat` with `C3900U`.
- **Gates**: `tests/run_cmat_tests.py`, **17 checks**, `make test-cmat`: byte-identical when off, each of
  M1/M2/M3 firing, `strfirst` (the copy is read only by `STR`) and `big` (a `MOVW`/`MOVT` pair)
  **byte-identical**, three fixtures x three arms (off/on/alone) agreeing on unicorn, labels surviving,
  the cropped build refusing. One layer further: `run_arm_exec.py --extra=-fopt-cmat` ran the whole
  execution suite on a cmat-enabled build with **0 failures**.
- **Measurement (twelve switches + `-fopt-cmat`)**: **19,066 -> 18,729 (-337, 1.77%)**; the histogram
  moves only `MOV 3888 -> 3551` and no other mnemonic at all; the line diff splits into M3 337 / M1 193
  rewrites / M2 180 rewrites (`LDR` 168 + `LDRB` 12), 710 lines deleted and 373 added.
- **Conclusion**: the text layer did not run out of room -- the room was distributed differently from the
  pre-registration's assumption (repeated loads and same-slot round trips really are 0.7%, but duplicated
  constant materialisation is another 1.77%). Every new pass should therefore start by scanning the whole
  corpus for the shape distribution instead of extrapolating P15's table.

---

### P17 Slot-level register allocation (`-fopt-slotreg`, **measured and archived in 0.9.1-wip**)

- **What it does**: measurement overturned P15's shadow-register model (`MOV rC, r0` for
  `LDR r0, [r6, #o]`) -- that is a 1-for-1 substitution with an unchanged count. It became
  **delete-only, never insert**: delete a reload where `r0` already holds the slot (R1), and delete
  a store that is never observed (R2(a): zero reads in the whole function and no address escape;
  R2(b): overwritten later in the same block). No register is introduced and the frame layout is
  untouched, so "only ever smaller" is a structural guarantee rather than a cost trade-off.
- **The safety boundary was bought with yield**: without the address-escape test it deleted up to
  -340 (-1.82%), but with 5 `arm_exec` semantic failures (`c = k ? a : b` writes two `STR`s that
  `memcpy` reads internally, invisible to the text layer). With the test it is -64 (-0.34%) and
  0 failures.
- **Measured** (on top of the twelve switches + `-fopt-cmat`): 18,729 -> **18,665 (-64, -0.34%)**,
  `LDR -35`, `STR -29`, every other mnemonic unchanged; none of the 95 TUs grew, 85 are
  byte-identical.
- **Verdict: archived.** By the falsifier frozen in `docs/SLOT_REGISTERS.md` §5 (a drop below 0.5%
  closes the line), -0.34% does not clear it; the seven gates and four falsifiers were left word for
  word, only §9 "design revision and measurement" was appended.
- **Why the code stays**: off by default, byte-zero when off, semantics unchanged on 41
  execution-level cases, no TU grew out of 95 -- a **proven-safe -0.34%**; precedent:
  `-fopt-regalloc-near` ships with zero gain too.
- **The real lesson**: frame accesses are 18.8% of the corpus, but **only 0.34% can be safely
  deleted** -- the headroom is not in the text layer. The remaining 3,500-odd frame accesses each do
  something useful; making them disappear needs computation directly in registers (P12's S3 operand
  allocation), which is a new model, not more rules.

---

### P18 Operand allocation (S3 pre-registration; slice S3a landed as `-fopt-constcache`)

- **Why the model has to change**: after P16 (cmat, -1.77%) and P17 (slotreg, -0.34%) the text layer
  is measured out -- slotreg without its safety gate could delete -1.82%, but every one of those
  deletions rested on indirect accesses the text layer cannot see, and that measured as 5
  execution-level failures. Of the remaining 18,665 instructions, **17.6% read or write the
  function's own memory** (`[r6]` 1,879 + `[r5]` 1,414), 11.2% materialise 32-bit constants
  (`MOVW`+`MOVT` 2,096), 7.0% are pure register copies (`MOV rD,rS` 1,305) and 9.6% push or pop the
  value stack (1,791). These are not redundant accesses; they are what a model in which every
  intermediate must cross memory produces.
- **Slice S3a: a function-level 32-bit constant cache.** When a 32-bit constant is materialised
  `c >= 5` times in a function, materialise it once into a callee-saved register (`r8`-`r11`) and turn
  the rest into `MOV rD, rC`; net gain `c - 4`. Measured (conservative convention, key includes the
  destination register): **657 of 1,115 `MOVW` (59%) repeat inside the same function**, an optimistic
  upper bound of **399 (-2.1%)**, or **193 (-1.0%)** with at most 4 cache registers.
- **Its real value is the foundation**: S3a has to solve "put something that is not a frame slot into
  `r8`-`r11`", "widen `PUSH`/`POP` and shift every offset" and "keep 8-byte alignment" -- exactly the
  hard parts of S3b (live values across calls).
- **The known conflict (found by reading `ark_regalloc_function()`)**: `ra_` and S3a want the same
  registers, the same frame block and the same offset shift. The fixed resolution is "the PUSH
  widening and offset shift may have exactly one owner": S3a does not widen itself, it takes the
  remaining registers from `ra_`'s `made[]`/`extra`, and `ra_`'s widening also saves them. If
  implementation cannot do that, the slice **degrades to not done** -- two passes shifting offsets
  independently is a miscompile hotspot and not worth 1-2%.
- **Measured (2026-11-23, S3a landed)**: `-fopt-constcache` is implemented as the second client
  inside `ark_regalloc_function()` (`extra` computed once, offsets shifted once, `PUSH`/`POP`
  rewritten once). Baseline 18,665 -> **18,506 (-159, -0.85%)**, only 3 TUs changed, 92
  byte-identical and **none grew**; `arm_exec --extra=-fopt-constcache` reports **0 failure** and a
  cropped build on the same corpus is byte-identical on 95/95. The work also exposed an existing
  defect: `ra_` recognised the prologue by **prefix** (`"PUSH {r5"`), so a value-stack spill of one
  value was widened as the frame save while vstack's r4 shape did not match at all. It now compares
  the whole list, and deliberately declines the r4 shape (it carries a pad word that widening would
  misalign), so those functions abstain as a whole.
- **Gates frozen**: seven gates (OFF IS OFF / only ever smaller with any growth red / the reuse
  really happens and the replacement is `MOV rD,rC` / still hits across a `BL` / no register clash
  with `ra_` and offsets shifted once / `arm_exec` parity / cropping rejects with `C3900U`) and four
  falsifiers (< 0.5% archives the line, any TU growing, more than 4 registers needed, having to widen
  `PUSH` itself). All of it in `docs/OPERAND_ALLOC.md` / `.en.md`.
- **S3b: measured and closed (2026-11-23)**. Live values across call sites in callee-saved
  registers were measured once, right after S3a landed (`docs/OPERAND_ALLOC.md` section 9): of 38
  call sites that have live values in the 95 TUs, **0 still hold one in a pool register** -- the
  "split because a pool register is live" route never fires; genuine cross-call single
  `PUSH`...`POP` pairs are only **5 in 3 functions**, an upper bound of **20 B = 0.11%**, and after
  paying the widened `PUSH` (12 B over those 3 functions) 8 B net remain. **Closed under the same
  <0.5% falsifier: not pre-registered, not implemented.** Scope: this holds only for this corpus and
  the current `-fopt-vstack` model, and does not mean value-stack round-trips are not worth
  optimising.

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
