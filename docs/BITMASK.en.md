# Direct encoding of a negated mask (`-fopt-bitmask`)

English | [中文](BITMASK.md)

> The ninth optimisation of 0.9.1.  In one sentence: **`~constant` is built as
> `MOV rX,#imm` followed by `MVN rX,rX`, and the `AND` / `MOV` right behind it only
> consumes the result -- Thumb-2 can encode both directly as `BIC` / `MVN` with an
> immediate, so three lines collapse into one.**
>
> Implementation: `src/backend/arm/backend_arm.c`, `ark_bitmask_function()` (an ARM
> backend text-level pass, right after `ark_cmat_function()` and before
> `ark_litpool_function()`)
> Gate: `tests/run_bitmask_tests.py` (`make test-bitmask`)
> Switch: `-fopt-bitmask` / `-fno-opt-bitmask`, INI `opt-bitmask=` / `bitmask=`
> Croppable: `ARKCC_FEATURE_OPT_BITMASK` (0 in the `STM32_MIN` profile; a cropped
> build refuses the flag by name)

---

## 1. The shape: every `& ~constant` builds a mask and then complements it

`x & ~4u` is "complement `4`, then and" to the front end, and the backend emits it
in order:

```asm
MOV   r0, #4
MVN   r0, r0
MOV   r7, r0          ; the mask lands in a long-lived register
...
AND   r0, r7          ; consumer
```

The first two lines **materialise `~4` into a register**.  Thumb-2's `BIC` and `MVN`
both have an immediate form, and the immediate they want is exactly this `imm` (not
its complement):

- consumer is `AND rD, rX` (and `rX` dies after it) => `BIC rD, rD, #imm`
- consumer is `MOV rD, rX` (a plain copy)          => `MVN rD, #imm`

Three instructions become one.  The rewrite is **purely textual**: it touches no
label, no branch target, no frame size, so `ark_fix_far_offset`, the literal-pool
offsets and the control flow all still see the same function.

## 2. Three preconditions

### 2.1 Three adjacent live lines

They must be literally adjacent:

```
MOV  rX, #imm
MVN  rX, rX
<consumer>
```

Only this shape is recognised.  If something else sits in between (say the mask is
`STR`ed out first) nothing is folded -- that means the mask has a use of its own, and
folding would shunt its build cost somewhere else.

### 2.2 `imm` must encode as a modified immediate

Both `BIC #imm` and `MVN #imm` go through `thumb_imm12_a()` (`imm12` plus a 4-bit
rotate).  The test is on the **rotated 8-bit pattern**, and odd rotations are legal:

`0xD0000 = 0xD0 ROR 20` -- rotation 20 is odd, it is legal, and `MVN rD, #0xD0000`
encodes fine;
`0x101` is not any `imm8 ROR 2k` pattern, `BIC`/`MVN` with an immediate cannot encode
it, and the pass **declines**.

(`imm == 0` is declined as well: `~0` is `0xFFFFFFFF`, the `MVN rD, #0` case, but the
`MOV #0` + `MVN` shape does not occur in the corpus -- declining is the conservative
side.)

### 2.3 The consumer must be the strict two-operand form, and `rX` must die after it

- `AND rY, rX` (two operands, second is `rX`) or `MOV rY, rX`.  Shifted or
  three-operand forms such as `AND rY, rZ, rX` are never accepted.
- `rX` must be **provably dead** after the consumer, otherwise the mask still has a
  reader and folding would delete it.  The proof is a forward linear scan
  (`bmk_dead`):

| Seen while scanning | Action |
| --- | --- |
| any mnemonic mentioning `rX` (other than the rows below) | live, give up |
| a line that writes `rX` (`MOV/MOVW/MOVT/LDR/... rX,`) | dead, fold |
| `POP {..., rX, ...}` | treated as a write (the callee-saved word is restored), dead |
| a label definition | skip and continue (the region is already known to be branch-free: any branch aborts the scan) |
| `B .Lx`, unconditional | follow to the target, at most 4 hops; more or a missing target gives up |
| any other branch (`Bcc`/`CBZ`/`CBNZ`/`BX`/table jump), unknown mnemonic mentioning `rX` | give up |
| no conclusion within 40 lines | give up |

When the consumer is `AND rD, rD` (`rX == rY`) no liveness proof is needed:
`rD` is overwritten in place, so the final value is the same either way and there is
no second reader to lose.

## 3. Why it sits after `-fopt-cmat` and before `-fopt-litpool`

- **Not before cmat**: `-fopt-cmat` decides whether the mask has to be materialised at
  all (it can swallow a one-shot constant mask into the consumer).  The other order
  would fold first and then be undone by cmat.
- **Not after litpool**: once a 32-bit mask enters the literal pool it becomes
  `LDR rD, <label>` and the `MOV #imm` line no longer exists.  Running first sees the
  `MOV`, and it also keeps `BIC`/`MVN` immediates out of the pool (4 bytes versus 4
  bytes in the pool plus an `LDR`).
- **`-fopt-vstack` must run upstream**: while the value stack is on the stack there
  are `PUSH`/`POP` pairs between the build and the consumer, the three lines are not
  adjacent, and the pass sees nothing.

## 4. Measured (95 HAL/Core TUs, `-O2` + 25 `-fopt-*` including `-fopt-exit`)

| Metric | off | on | delta |
| --- | --- | --- | --- |
| instructions | 11,877 | 11,766 | **-111** |
| assembly bytes | 400,125 | 398,673 | **-1,452** |
| undefined labels / failed TUs / larger TUs | 0 / 0 / -- | 0 / 0 / 0 | -- |

With the flag off the output is **byte-identical** to the previous 25-flag baseline
(0 diff), so the -111 is entirely this pass.

Per-TU drop (top 9): `stm32f4xx_hal_dma -39`, `hal_pwr -17`, `hal_rcc -17`,
`ll_utils -9`, `hal_rcc_ex -8`, `hal_flash -6`, `hal_flash_ex -6`, `hal_cortex -5`,
`stm32f4xx_hal -4`.

Folded sites: `BIC rD, rD, #imm` **35**, `MVN rD, #imm` **26**, **61** in total.
Five sites stay unfolded: four `AND r7, r0` (the `imm` is not encodable, or the
consumer is not in a branch-free linear region) and one `UXTB r0, r0` (not this rule;
its input is not a `~constant` either).

## 5. Encoding correctness: byte-for-byte against GNU as

The `MVN`/`BIC` immediate forms are not an encoding invented here; they were checked
with a cross assembler (`arm-none-eabi-as`, the default `DEFAULT_GNU_BIN`):

| source | encoding |
| --- | --- |
| `MVN r7, #0x1` | `6ff0 0107` |
| `MVN r7, #0xD0000` (odd rotation) | `6ff4 5027` |
| `MVN r1, #0x80000000` | `6ff0 0041` |
| `BIC r7, r7, #0x1000000` | `27f0 8077` |
| `BIC r3, r3, #0x2` | `23f0 0203` |
| `BIC r10, r10, #0x40000` | `2af4 802a` |

`arkcc`'s output is **byte-identical** to that table.  The point of the cross-check is
to pin down that the immediate encoder does not invent shapes of its own -- including
the odd rotation, which is easy to get wrong by eye.

## 6. Gate

`tests/run_bitmask_tests.py` (`make test-bitmask`) pins 18 checks:

| Check | Content |
| --- | --- |
| OFF IS OFF | `-O2 <passes>` and the same plus `-fno-opt-bitmask` are **byte-identical** as assembly and as image |
| the copy fold fires | `MOV/MVN/MOV` becomes a single `MVN rD, #0x4`, and the function gets **exactly two lines shorter** (a "never grows" check alone cannot catch a rule that never fires) |
| the and fold fires | `MOV/MVN/AND` becomes `BIC rD, rD, #0x2`; the un-folded arm has `AND rD, rX` and no `BIC`; again **exactly two lines shorter** |
| odd rotation | `~0x000D0000` must fold to `MVN rD, #0xD0000` (asserted by name; an implementation that only accepts even rotations goes red here) |
| not encodable, declined | the `~0x101u` function is **byte-identical** |
| no adjacent consumer | a function that stores the mask before using it is **byte-identical** |
| a live mask is not clobbered | when the mask is read again after the consumer only the copy may be rewritten: `MVN rD, #0x8` appears and the function is **exactly two lines shorter** |
| whole-file bookkeeping | instruction count drops, the image never grows, every branch target is defined |
| same answer | six mask shapes (rotated and non-encodable included) fold into one checksum: four arms (`base`/`off`/`on`/`all`) return the same value in unicorn, matching a value Python computes independently |
| cropped out, refused | a build with `-DARKCC_FEATURE_OPT_BITMASK=0` refuses `-fopt-bitmask` with `C3900U` and the flag named; without the flag it still compiles |

## 7. Where it belongs

- **Complementary to `-fopt-cmat`**: cmat removes a mask that is only used once,
  bitmask removes the two steps that build a mask and immediately complement it; each
  leaves shapes on the corpus that the other cannot take.
- **Mutually exclusive with `-fopt-litpool` on the same constant**: a folded `imm`
  never reaches the pool; an unfolded one (not encodable, or a consumer shape the rule
  does not accept) still belongs to litpool.
- **No overlap with `-fopt-imm` / `-fopt-peep`**: those work on the `MOV` and on
  arithmetic immediates themselves and do not know the cross-instruction fact that
  `MVN` is the complement of `MOV`.
