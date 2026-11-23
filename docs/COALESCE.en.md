# `-fopt-coalesce`: rename local copies out of existence

English | [中文](COALESCE.md)

> In one sentence: to satisfy the two-operand Thumb ALU encoding requirement
> "`Rd == Rn`", the value-stack backend first `MOV`s the left operand into a
> scratch register. That copy produces no value of its own -- rename every use
> in the straight-line code that follows to the copy source and the copy can be
> deleted whole. On the full HAL corpus this removes another
> **358 instructions (-1.93%)**, and not one of the 95 TUs grows.

---

## 1. Why

In the family breakdown measured in `docs/OPERAND_ALLOC.md`, `MOV rD, rS`
accounts for **1,305** instructions. Of those, 455 immediately follow the
instruction that defines `rS` and 316 immediately precede a two-operand ALU
op, while the estimated upper bound for "the source dies inside the block, so
the copy can be renamed away entirely" is **1,373 sites (~7.4%)** -- the largest
single block left at the text level.

The shape is extremely regular:

```asm
    LDR  r5, [r6, #0]      ; a
    LDR  r7, [r6, #8]      ; b
    MOV  r0, r5            ; stage the left operand into r0
    AND  r0, r7            ; r0 = a & b (16-bit encoding needs Rd == Rn, so AND r5, r7 is not available)
    LSL  r0, r0, #3        ; downstream consumers keep using r0
    STR  r0, [r1]
```

Throughout this stretch `r0` is nothing but a shadow of `r5`. Rename every
`r0` to `r5` and drop the `MOV`:

```asm
    AND  r5, r7
    LSL  r5, r5, #3
    STR  r5, [r1]
```

Same values, same flags, one instruction fewer, and **no instruction gets
wider** -- every register involved is in `r0`-`r7`, so the 16-bit encodings
still apply. The IAR counterpart is the "copy coalescing / `MovElimination`"
layer inside `CgRegalPhase` (see `c_compiler/iar/docs/06-optimizer.md`).

## 2. The rule

> After a `MOV rD, rS` (both in `r0`-`r7`, distinct, neither is `r6`), rename
> every occurrence of `rD` to `rS` in the straight-line code that follows; delete
> the copy **only** if, at the end of that code, `rD` is no longer live (and, if
> `rD` was redefined inside the stretch, `rS` is not live either).

Bounds of "that straight-line code" (stop at any of them, never step over):

| Stop at | Why |
| --- | --- |
| A label | Renaming cannot cross control flow: a `rD` read on another path never sees the rename |
| A basic-block boundary / conditional branch | Same reason |
| Any instruction inside an `IT` block | Conditional execution; changing its register set changes semantics |
| `!`-writeback addressing, any register list `{...}` | The operand text does not fully describe the read/write sets |
| `BL` / `BLX` | Calls **implicitly** read `r0`-`r3` and implicitly write `r0`-`r3`; none of that is visible in the text |

Three decisions inside the stretch:

1. **Write `rS`**: the copy source gets overwritten, so the stretch ends here.
   If the same line also **reads** `rD`, the later value depends on the copy we
   are about to delete -- abandon the whole stretch;
2. **Write `rD`**: the staged value has been carried into `rS` (after renaming
   this line writes `rS`). From then on `rD` holds no value, so **any** later
   read of `rS` (not of `rD`) would observe the new value -- abandon;
3. **Read `rD`**: this is the main target of the rename; record the position.

Finally, `rD` must be **dead** after the last rewritten line (otherwise someone
outside the stretch still expects the copy result in `rD`); and if `rD` was
redefined inside, `rS` must be dead too (its old value has been overwritten).

## 3. Where it lives and how it is ordered

It is the **fifth rule** (`L5`) of `-fopt-live`, not a standalone pass:
liveness (`la[]` per-instruction live-after masks, `bof[]` block ids, `it[]`,
`kd[]`) is computed once. With `-fopt-coalesce` alone, `ark_live_function()`
still runs (`enable_opt_live || enable_opt_coalesce`), but L1-L4 each carry an
`enable_opt_live` guard, so they do nothing when only coalesce is on -- which is
why OFF IS OFF is a byte-for-byte guarantee.

The pipeline position is unchanged (after `live`, before `regalloc`):

```
vstack → addr → cbz → peep → copyprop → live(+coalesce) → regalloc → slotreg → cmat → fix_far_offset
```

`lv_pass` runs up to 4 rounds; renaming a copy away frequently **unlocks** new
L1/L2 opportunities, so later rounds in the same compilation keep removing
instructions -- which is exactly why the measured instruction drop can exceed
the number of merged copies.

## 4. Real defects hit on the way

Both were written wrong first and then caught by the gates / emulator:

1. **Handling only "dead right after its last use" almost never fires.** The
   first version required `rD` to die immediately after its last read in the
   stretch, but the most common shape is `MOV r0, r5 / AND r0, r7 / LSL r0, r0,
   #3` -- `rD` gets **redefined** inside the stretch. Result: 95 TUs lost 1
   instruction total. The fix is decision 2 in §2.
2. **`BL`'s implicit reads/writes.** `MOV r0, r5` is very often **staging a
   call argument**, and `BL` reads its arguments from `r0`-`r3` without writing
   any operand text. The rename only looks at operand text, so the `BL` line
   "looks like" it does not read `r0`; the copy was deleted, the argument was
   lost, and the emulator returned 5 instead of 9 for `br(12,10,0)`. Fix: stop
   at any `BL`/`BLX` inside the stretch, and abandon on any line that "reads or
   writes `rD` but never mentions `rD` in its operand text" (the same class of
   implicit register).

## 5. Measurements

Same corpus as `docs/COMPARISON.md`: 95 TUs of `examples/ark_test` (`Core/Src`
+ `Drivers/STM32F4xx_HAL_Driver/Src`), `-O2`, all fifteen switches,
`--reloc-data`.

| Configuration | Instructions | Change |
| --- | --- | --- |
| fifteen switches (no coalesce) | 18,509 | — |
| fifteen switches + `-fopt-coalesce` | 18,151 | **-358 (-1.93%)** |

- Of the 95 TUs, 81 are byte-for-byte identical, 14 shrink, **none grows**;
- Largest drops: `stm32f4xx_hal_dma.c` -82, `stm32f4xx_hal_flash_ex.c` -48,
  `stm32f4xx_hal_gpio.c` -38, `stm32f4xx_hal_rcc.c` -34, `stm32f4xx_ll_utils.c` -33;
- Without the flag, all 95 assembly files are **byte-for-byte identical** to
  before the change (OFF IS OFF).

The gap to the 7.4% upper bound is entirely the three conservative stops: a
write to `rS` inside the stretch, a `BL` inside the stretch, and `rS` still live
at the end. All three are doable, but each one costs another "why is this still
correct" argument for a few hundred instructions -- not worth the risk of a
wrong answer right now. **Delete less, never answer wrong.**

## 6. Gate (`tests/run_coalesce_tests.py`, `make test-coalesce`)

| Group | Assertion |
| --- | --- |
| 1 | **OFF IS OFF**: `-O2` and `-O2 -fno-opt-coalesce` are byte-for-byte identical |
| 2 | `merge`: the fixture really has 5 `MOV r0, r5` staging copies; the on arm deletes at least 3 and never increases the total; `AND r0, r7` 2 → 0, `AND r5, r7` 0 → 2, `ORR r5, r7` 0 → 1; `LSL r0, r0, #3` 1 → 0 and `LSL r5, r5, #3` 0 → 1 (the value is carried across an in-stretch redefinition); the remaining 2 unmergeable copies stay |
| 3 | `selfsrc` (`MOV r0, r5` + `LSL r0, r7`, both operands read the target): the two arms are **byte-for-byte identical** -- anti-over-deletion |
| 4 | `ret` (the staged value is the return value; `rD` is live at the exit): the two arms are **byte-for-byte identical** |
| 5 | All four fixtures × three arms (off / on / on-alone) return the Python answers (86 / 35 / 8 / 9) on the emulator |
| 6 | New lines can only come from renaming: every mnemonic appeared in the off arm and every new line mentions `rS` |
| 7 | Cropped build (`-DARKCC_FEATURE_OPT_COALESCE=0`) rejects `-fopt-coalesce` by name (`C3900U`), and still compiles without the flag |

Fixtures must carry the full switch set: the staging shape only appears after
`-fopt-vstack`, and liveness comes from `-fopt-live`.

## 7. Cropping

`ARKCC_FEATURE_OPT_COALESCE` (`include/arkcc_config.h`):

- `ARKCC_PROFILE_STM32_MIN` ⇒ `0`;
- otherwise ⇒ `ARKCC_FEATURE_OPT_LIVE` (the rule rides on `lv_pass()`, so it has
  nowhere to hang when live is cropped out).

Passing `-fopt-coalesce` to a cropped build gives
`Fatal error: C3900U: -fopt-coalesce is not compiled into this build (rebuild with -DARKCC_FEATURE_OPT_COALESCE=1)`
and returns 1. Because it shares `lv_pass()`, **off** means zero size and zero
behaviour change (no new static tables).

## 8. Not done (registered)

- **Continuing past an in-stretch write to `rS`**: requires a proof that the old
  `rS` value is needed by nobody thereafter -- equivalent to splitting the live
  range again. Small gain, long argument.
- **Merging across branches**: the rename result differs per path; needs SSA or
  path-sensitive analysis.
- **Real register allocation**: still `docs/OPTIMIZER_PLAN.md` P12's S4/S5 (at
  the IR level). Local copy coalescing can only eat the part that has already
  been staged once.
