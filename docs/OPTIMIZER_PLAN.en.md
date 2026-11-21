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

### P4 Duplicate block elimination (the whole-block form of cross-jump)

- Same matcher as P1 without the "tail" restriction: identical blocks become one copy plus
  jumps. AC5's `zip` handles both forms in one place, so the matcher and rewriter are shared
  and only the candidate generator differs. Scheduled after P1 settles.

### P5 Cross-call (interprocedural sharing) -- **explicitly not scheduled**

- The gain depends on "many similar function prologues in one image", and the cost is three
  problems: calling convention, return labels, unwind chain (the four `isn't set` in section
  2.3). arkc has no unwinder and no cross-TU IR pool today, so it could only work within one
  TU -- cost out of proportion to the gain. **Recorded, not scheduled.**

### P6 Continuous size/speed weight (`-Oz` / `-Os` / `-Ot`)

- **Evidence**: IAR makes `-z0..9` / `-s0..9` a continuous weight (0-2 Debug / 3 Low /
  4-6 Medium / 7-9 High); AC5 is the binary `-Ospace`/`-Otime`.
- **Where**: not a new parameter per pass -- first a **single global weight**
  (`g_config.size_weight`, 0..9) read by the inline threshold, the unroll factor and the merge
  threshold. That is what makes the "smaller but not much slower" middle ground reachable.
- **Note**: this is an interface-level change that moves every pass reading it. It must be its
  own round, after P1/P3 settle, and it owes the verdict "weight not set = byte-identical to
  0.9.x".

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
