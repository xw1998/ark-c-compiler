# Block-tail merging (`--tailmerge`, stage `ir.tailmerge`)

> The first optimisation of 0.9.1, and it says one thing: **when several basic blocks end in
> exactly the same instruction sequence, keep one copy and turn the others into a jump to a
> label placed in front of it**.
>
> Source: `src/opt_tailmerge.c`　Gate: `tests/run_tailmerge_tests.py` (`make test-tailmerge`)
> Position: **13 -> 14**, after `ir.const-global` and before `ir.vectorize`
> (see `docs/PASS_PIPELINE.md`)

---

## 1. Why this position

Inlining moves a callee's body to the call site; constant propagation folds loads of `const`
objects into immediates. Both leave several blocks that end in one identical run of
instructions:

```c
int f(int a, int b) {
    if (a) { ...; b *= 3; b ^= 5; b += 11; return b + 7; }
    else   { ...; b *= 3; b ^= 5; b += 11; return b + 7; }
}
```

The two arms differ wildly above and are identical below. Block-tail merging runs right after
those two stages and removes exactly that duplication; after it only `ir.vectorize` and the
backends remain, and neither creates more of it.

Reverse-engineering evidence (`c_compiler/iar/docs/07-crossjump-and-tbaa.md`): AC5's
`CrossJumps` and IAR's `intracrossjump` do this, and the measured byte account is 8/16/24/40 B
for a shared tail of 1/2/3/5 statements -- **positive at small N**, which is why this is the
first optimisation worth landing.

## 2. Five rules, each with a counter-example or a price behind it

| # | Rule | Why |
| --- | --- | --- |
| 1 | Matching is **instruction-identical** (op / val / aux / aux2 / name all equal), not semantic equality | AC5's `cj6.c` experiment: two tails that differ only in a register (`r1` vs `r0`) are **not** merged. Loosening this needs an equivalence proof this pass does not have |
| 2 | Only tails whose **evaluation-stack depth is 0** are merged | The IR is a stack machine. Jumping to a point with live values carries the evaluation stack as state across a control-flow edge -- a promise the backends have not made. Depth 0 is the statement boundary and costs nothing to require |
| 3 | Tail length >= `ARK_TAILMERGE_MIN_LEN` (default 3) | Every extra entry pays one `JMP`. A two-instruction tail cannot buy that back; the threshold is not trusted on faith either -- the gate prints the real byte account |
| 4 | One merge per round, then the **CFG is rebuilt** | Same shape as `opt_licm_func`. Merging replaces one block's tail with a jump, so the block boundaries around it change; re-deriving the graph is cheaper and harder to get wrong than patching it. Rounds are bounded by code length, which is the termination guard IAR spells `Jump size optimization will not terminate!` and AC5 spells `need another pass` |
| 5 | When the depth model does not hold, the **whole function is abandoned**, not the single block | Half-correct control flow is worse than no optimisation. Triggers: a label entered at two depths, an opcode whose stack effect is unknown, inline asm, a negative depth |

## 3. Algorithm

```
loop:
  mir_build(f)                      # re-derive the basic-block graph
  fixpoint stack-depth analysis (block entry depth + per-instruction depth)
  if !ok: return                     # rule 5
  candidate tail per block: the LAST depth-0 point inside the block, labels excluded,
                            length >= MIN_LEN
  group by (length, instruction-identical); take the group with the largest total saving:
      saving = (members - 1) * (tail_len - 1)
      (members - 1 tails become jumps; each one loses len - 1 instructions)
  if no group: return
  rewrite: insert a fresh IR_LABEL in front of the kept tail, replace each dropped tail
           with one IR_JMP to it
```

Three things that are easy to get wrong:

- **The tail start must be the last depth-0 point in the block.** Taking the first drags the
  branch-specific upper half into the candidate, so two branches that are perfectly mergeable
  look unmergeable. The first draft did exactly this and `merge.c` in the gate caught it
  immediately.
- **A label is never part of a tail.** Copying a label means a second definition of the same
  jump target while every jump still aims at the first; and since `IR_LABEL`'s id lives in
  `val`, instruction-identical matching would also demand equal ids. Both effects together
  make "a tail containing a label" permanently unmatchable, so labels are excluded at the
  candidate stage instead.
- **`IR_CMP_JMP_EQ` is declared unsafe outright**: it is a 0.2.x opcode irgen no longer emits,
  and the **two backends disagree about whether the not-taken edge pops** (ARM pops
  unconditionally, the C backend pops only on the taken edge). Until that disagreement is
  settled this pass does not bet on either reading.

## 4. Trimming (three layers; off means zero change)

| Layer | Mechanism | Guarantee when off |
| --- | --- | --- |
| Compile time | `ARKCC_FEATURE_TAILMERGE` (`include/arkcc_config.h`) | 0 for the STM32_MIN profile or a build without MIR: the whole body of `src/opt_tailmerge.c` disappears; the stage row keeps its number but sets `built_in = 0` and **names no symbol** (otherwise the trimmed build fails to link) |
| Run time | `g_config.enable_tailmerge`, `--tailmerge` / `--no-tailmerge`, INI `tailmerge=` | Default 0. When off the file is linked but never entered, and the image is **byte-identical** to a build without the pass (the gate compares object hashes) |
| Profile | `--pipeline=lite` | `ir.tailmerge` has `min_profile = full`, so lite skips it and records why |

A trimmed build **refuses** the option rather than pretending to optimise:
with `-DARKCC_FEATURE_TAILMERGE=0`, `--tailmerge` fails with `C3900U` naming the macro, on
both the command-line and the INI path.

## 5. Gate

`tests/run_tailmerge_tests.py`, 23 checks, five questions that can fail alone:

1. **Static**: on changes the assembly (a fresh `.L_<func>_N` label and the dropped branch's
   `B` to it), off leaves it identical.
2. **Negative** (must be identical even with the switch on): final statement differs / the
   identical suffix starts at stack depth 1 / suffix shorter than the minimum / the function
   contains inline asm.
3. **Selectivity**: one `.c` holding both a mergeable function and a depth-1 shape -- only the
   former may gain labels. This rules out "the pass never ran in this translation unit".
4. **Dynamic**: the ARM emulator returns the same value with and without the switch, and that
   value is non-trivial.
5. **Byte account + anti-false-green**: the object is strictly smaller and both sizes are
   printed; the pass is off by default; `--no-tailmerge` restores the default object; the
   `-O0` image is byte-identical; `--print-pipeline` reports run / skip honestly including
   `needs a higher -O level`; the INI key works; the trimmed build refuses the option while
   its default object still equals the full build's.

## 6. Measured (0.9.1, host gcc / MinGW)

| Case | Reading |
| --- | --- |
| `merge.c` (two branches sharing `return b + 7;`, plus a three-way `tail3`) | 481 -> 448 assembly instruction lines; object 1146 -> 1086 B |
| `neg_depth.c` (identical suffix starting at stack depth 1) | assembly byte-identical with and without the switch |
| `neg_asm.c` (function containing `__asm`) | rule 5 fires, whole function abandoned, byte-identical |
| `-O0 --tailmerge` | image byte-identical to the switch being off |
| `-DARKCC_FEATURE_TAILMERGE=0` | refuses `--tailmerge` (`C3900U` naming the macro); default object hash equals the full build's |

## 7. Deliberately not done (and what has to exist first)

- **No jump-width recalculation**: the IR has no variable-length encoding, `JMP` has one width,
  so AC5's "jump distance changed => run another pass" has no counterpart here. That is a
  machine-level question.
- **No "cheapest position" hoisting**: AC5 has `BLKLIFTABLE` / `on_savepath` block checks that
  pick the placement with the fewest entries and the tightest layout. This pass simply puts the
  label in front of the **kept** copy: one less layer of reasoning, at the price of the odd
  longer jump. Revisit when there is a measurement to justify it.
- **No cross-call**: see `docs/OPTIMIZER_PLAN.en.md` P5, where the reason is written down.
- **No whole-block duplication (P4)**: same matcher, different candidate generator; open it once
  this one has settled.
