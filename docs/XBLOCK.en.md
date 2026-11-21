# Whole-block deduplication (`--xblock`)

> The fourth 0.9.1 optimisation, the whole-block form of P1 `ir.tailmerge`.
> One line: **when two basic blocks are instruction-for-instruction identical,
> enter with an empty evaluation stack, and leave through one exit that names
> its destination inside the body, keep one copy and turn every other copy into
> a single jump in place.**
>
> Implementation: `src/opt_tailmerge.c` (IR pass, stage `ir.xblock`, sharing the
> matcher and the stack-depth model with `ir.tailmerge`)
> Gate: `tests/run_xblock_tests.py` (`make test-xblock`)
> Switch: `--xblock` / `--no-xblock`, ini keys `xblock=` / `cross-block=`

---

## 1. Relationship to `--tailmerge`

AC5 folds tail merging and whole-block merging into one pass (`zip`) and only
changes the candidate generator. arkc follows that split: `tm_same_inst()`
(instruction comparison) and `tm_analyse_depth()` (per-block evaluation-stack
depth) are shared; `ir.tailmerge` compares the *identical suffix* of blocks,
`ir.xblock` compares *whole* blocks. Each stage has its own runtime switch and
its own compile-time macro, so turning one on does not turn the other on.

## 2. Three extra conditions (each one prevents a specific wrong answer)

Tail merging satisfies these by construction (a tail starts at depth 0, holds no
label, ends in `return`). Whole-block merging has to check them, and skipping
any one of them changes what the program means:

| Condition | What goes wrong without it |
| --- | --- |
| **a) The evaluation stack is empty on entry** | A block can be entered with half an expression still on the stack. Jumping to the shared copy would carry the evaluation stack across a control-flow edge, which no backend promises. |
| **b) The body (after the leading labels) contains no label** | Every label is somebody's jump target. Two definitions of the same target become "whichever copy came first", so jumps silently change destination. |
| **c) The body ends in a one-successor transfer: `JMP` / `JMP_NAMED` / `RETURN`** | See below. |

### 2.1 Why a conditional branch (`JZ` / `JNZ`) must be refused

When a block ends in a conditional branch, its *taken* successor is named inside
the body, but its *fall-through* successor is whatever block happens to follow
it in the instruction list. Two identical bodies can therefore leave through two
completely different doors:

```c
int cond_case(int a, int b)
{
    int r = 0;
    if (a == 1)      { if (b * 2 > 10) { r = b + 1; } }   /* falls into r = b + 1 */
    else if (a == 2) { if (b * 2 > 10) { r = b + 2; } }   /* falls into r = b + 2 */
    return r;
}
```

Both `if (b * 2 > 10)` condition blocks are identical and both end in a
conditional branch. Merged, the `a == 1` path lands in `r = b + 2`. Conditional
branches are therefore refused: merging is only sound when there is one
successor and that successor is written in the body.

### 2.2 Targets are compared as *blocks*, not as label ids

`irgen` gives each arm of an `if` / `else if` its own merge label, so the two
arms' terminators spell `.L_two_1` and `.L_two_3` -- the *same* destination under
*two* names. Comparing label ids misses exactly the most common duplicated block
(the early implementation did this, and turning the switch on produced literally
no change).

The fix is to resolve the label to the basic block that defines it and compare
block numbers.

### 2.3 Blocks that hold nothing but labels

Adjacent merge labels each become a leader, which produces a block that has no
instructions at all:

```
.L_two_3:          ; block 5: labels only
.L_two_1:          ; block 6: label + real code
    LDR r0, [r6, #8]
    ...
```

Jumping to `.L_two_3` and jumping to `.L_two_1` land in the same place.
`xb_resolve_block()` therefore walks through "empty body, single successor"
blocks until it reaches a block with code and compares that block id; a cycle of
labels returns -1 (refuse, do not guess).

## 3. The rewrite

For a group of `k` candidates keeping `keep`:

1. Insert a fresh `IR_LABEL new_label` in front of `keep`'s body
   (`new_label = f->label_count++`);
2. Replace every `drop` body with one `IR_JMP new_label`;
3. Keep each `drop` block's *own* leading label where it is -- those labels are
   still other blocks' jump targets. Only the body moves.

So each merged member saves `len - 1` instructions and a group saves
`(k-1)*(len-1)`.

## 4. Iteration and termination

Same shape as `ir.tailmerge`: **one merge -- the group with the largest saving --
per round**, then `mir_build()` rebuilds the CFG and the depth model and the
candidates are collected again. Every round turns at least
`ARK_XBLOCK_MIN_LEN` (4) instructions into one, so the round count is bounded by
construction; `guard <= f->code_count` only turns "a bug" into "exit" instead of
a hang.

Ties go to the earliest group, so the result does not depend on traversal order.

## 5. Refusal list (all byte-identical output)

| Shape | Why it is refused |
| --- | --- |
| Block ending in a conditional branch | §2.1: the fall-through successor is decided by position |
| Same body, terminators naming different blocks | One piece of code, two exits |
| Body shorter than `ARK_XBLOCK_MIN_LEN` (4) | Every copy pays one entry branch; a short block only loses |
| `IR_FUNC_BEGIN` / `IR_FUNC_END` in the body | Once per function; this also keeps the entry block out of the pool |
| Inline asm / unknown stack effect / a label reached at two depths | The stack model is abandoned for the whole function; a half-correct CFG is worse than no optimisation |
| `__naked` / `__asm` functions | Hand-written bodies are left alone |

## 6. Trimming

Three layers, as everywhere else:

| Layer | Mechanism | Guarantee when off |
| --- | --- | --- |
| Compile time | `ARKCC_FEATURE_XBLOCK` (0 for STM32_MIN or without MIR) | The code disappears; the stage row stays but `built_in = 0`; `--xblock` is refused with `C3900U` naming the macro |
| Run time | `--xblock` / `--no-xblock`, ini `xblock=` | The object is byte-identical to a build without the pass |
| Profile | `--pipeline=lite` | Expensive stages are skipped with a reason |

The shared section (matcher + depth model) is guarded by
`ARKCC_FEATURE_TAILMERGE || ARKCC_FEATURE_XBLOCK`: with both macros at 0 this
`.c` file compiles to nothing.

## 7. Gate (`make test-xblock`)

`tests/run_xblock_tests.py`, 26 checks, five independent questions:

1. **Static**: the switch changes the assembly; the number of duplicated call
   sites drops from 5 to 2 (2 in `two()`, 3 in `three()`); each shared block
   gains a fresh label; every dropped copy becomes a branch to it; instruction
   lines and bytes both go down.
2. **Refused shapes byte-identical**: conditional-branch block (§2.1), identical
   bodies leaving to different blocks (`break` to two different exits), body
   below the length floor (a `goto`-only body), inline asm; plus a **mixed file
   in one TU** proving only the mergeable function is touched (this rules out
   the false green "the pass never ran").
3. **Dynamic**: the same program returns the same value with the switch on and
   off on the ARM emulator, and the value is non-trivial (`37`); the refused
   shapes also agree.
4. **Anti-false-green**: off by default and the default object is byte-identical;
   `--no-xblock` undoes it; a `-DARKCC_FEATURE_XBLOCK=0` build refuses the
   option with `C3900U` while its default object hashes the same as the full
   build; ini `xblock=1` works; the stage table names `--xblock`; at `-O0` the
   switch changes nothing.
5. **Byte account**: the constructed case goes 869 -> 767 B and 320 -> 272
   assembly instruction lines.

## 8. Measurements and limits

- Constructed case (two and three identical arms, each body containing one call):
  320 -> 272 assembly instruction lines (-15.0%), 869 -> 767 B object
  (-11.7%), `BL g` 5 -> 2. The whole gain is the duplicated call sequence.
- Works on one TU's IR only: cross-TU needs `--ipo` to pull the bodies in
  (same as `ir.tailmerge`); cross-function sharing is P5 `cross-call`, which is
  **explicitly not scheduled**.
- Little to gain on code that is already tidy: this needs a repeated expression
  sequence in the source, and CSE / loop-invariant hoisting eat part of that
  first, so the effect is only visible on genuinely duplicated source shapes.
- The gate asserts the ARM assembly shape; the other backends go through the
  same IR pass, and equivalence rests on "IR-level rewrite + same value on the
  emulator" rather than per-backend assertions.
