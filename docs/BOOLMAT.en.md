# Boolean materialisation removal (`-fopt-boolmat`)

English | [中文](BOOLMAT.md)

> The seventh optimisation of 0.9.1. In one sentence: **a comparison already
> yields 0 or 1, so testing that result against zero again is redundant --
> `(a<b) != 0` is the identity and `(a<b) == 0` is the negation, and the pass
> removes the extra materialisation in the IR.**
>
> Implementation: `src/opt.c`, `opt_boolmat_func()` (IR stage `ir.boolmat`,
> right after `ir.deadpush`)
> Gate: `tests/run_boolmat_tests.py` (`make test-boolmat`)
> Switch: `-fopt-boolmat` / `-fno-opt-boolmat`, INI `opt-boolmat=` / `boolmat=`
> Croppable: `ARKCC_FEATURE_OPT_BOOLMAT` (0 in the `STM32_MIN` profile; when
> cropped out the flag is refused by name)

---

## 1. The symptom: the same boolean computed twice

`if (p && q)`, `if ((a < b) != 0)`, `return (x == y) != 0;` are all ordinary C.
The front end emits `!= 0` literally -- push a zero, compare again -- so the IR
contains

```
BINARY LT          ; a < b        -- already 0/1
PUSH_INT 0
BINARY NE          ; (a<b) != 0  -- the identity, computed for nothing
```

and the backend materialises both comparisons:

```asm
CMP   r5, r7
ITE   LT            ; a < b as an int
MOVLT r0, #1
MOVGE r0, #0
CMP   r0, #0
ITE   NE            ; compare against zero again
MOVNE r0, #1
MOVEQ r0, #0
```

The last four instructions can only ever see 0 or 1 and return exactly what they
see -- **four instructions, five bytes, zero information**. When the value is
consumed by an `if`, `-fopt-cbranch` would normally fold "compare + conditional
branch" into two instructions, but the extra materialisation in the middle hides
the comparison from it.

## 2. Three rules

The whole pass is local IR rewriting. Every rule skips `IR_NOP` (slots left by
other passes).

### R1 -- the frame round trip (`STORE w ; PUSH_VAR w`)

`int x = (a<b); if (x)` writes the value to the frame and reads it back.
Storing 4 bytes and immediately reading the same 4 bytes has a net stack effect
of zero, and the read returns exactly the bytes just written. Conditions:

| Condition | Test |
| --- | --- |
| width is exactly 4 | `aux & 0xFF` is 0 or 4; `VOLATILE`/`SLOT64`/`COMPLEX` are refused |
| same slot | both instructions have the same `val` (frame offset) |
| nobody watching | no other `STORE`/`PUSH_VAR`/`PUSH_ADDR`/`STORE_FLD`/`LOAD_FLD` in the function has `val` in `[off-3, off+3]` |
| clean function | any function containing `IR_ASM` or `IR_ALLOCA` is skipped outright |

The width must be **exactly 4**: the 1-byte round trip of `char c = 300` is not
an identity (store `0x2C`, read back 44). The "±3 window" covers three
observers at once: a second read of the same slot, a bitfield neighbour inside
the same word, and an address taken near the slot. Skipping functions with
`IR_ASM`/`IR_ALLOCA` follows the conservative precedent `-fopt-prop` already
applies to the same question (inline asm can name a frame slot by offset, and
`ALLOCA` changes what "the frame" means).

R1 saves **only 3 instructions** on the HAL corpus -- the front end mostly keeps
temporary booleans in value-stack registers rather than frame slots. The bulk
comes from the next two rules. R1 stays because it is the correctness backstop
for that channel: if another pass ever pushes the value back into the frame, R1
recovers it for free.

### R2 -- identity (`<cmp> ; PUSH_INT 0 ; BINARY NE`)

The comparison result is in {0,1}, so `x != 0` is `x`. Delete both the
`PUSH_INT 0` and the trailing `BINARY NE`; the comparison result stays on the
value stack. **The comparison then sits right next to its consumer**, so
`-fopt-cbranch` recognises `<cmp> + JZ/JNZ` and folds it into `CMP` plus one
conditional branch.

### R3 -- negation (`<cmp> ; PUSH_INT 0 ; BINARY EQ`)

`x == 0` is `x ^ 1` (with `x` in {0,1}). Rewrite `PUSH_INT 0` to `PUSH_INT 1` and
`BINARY EQ` to `BINARY BXOR`; `-fopt-imm` then folds that into one
`EOR r0, r0, #1`. Four instructions become one.

**One exception**: when the instruction after the `BINARY EQ` (skipping `NOP`s)
is already `JZ`/`JNZ`, R3 declines. Compare the two paths:

| Path | Cost |
| --- | --- |
| leave it to `-fopt-cbranch` | `CMP r0, r1` + `BNE/BEQ target` (**2** instructions, the condition just inverts) |
| R3 rewrites to `^ 1` and lets cbranch consume that | `CMP` + `ITE` + three MOVs + `EOR #1` + `CMP #0` + branch (**more**) |

R2 has no such exception: after deleting the pair the IR is exactly the shape
cbranch wants. R1 is branch-agnostic (it does not change the shape of the value
on the stack).

### The exact shape matched

The first instruction must be `IR_BINARY` with `aux & ~0x100` in
`{EQ, NE, LT, GT, LE, GE}` and no bits other than `0x100` (the unsigned-compare
bit) set; the middle one must be `IR_PUSH_INT` with `val == 0` and no
`VOLATILE`; the last must be `IR_BINARY` with `aux` exactly `TOK_NE` or `TOK_EQ`.
Anything whose first instruction is not a comparison (`(a & 3) != 0`,
`(a + b) != 0`, a `char` variable, a pointer load, a call result, a `long long`
comparison -- those go through `IR_64CMP`) is left alone, because its value is
not drawn from {0,1} and deleting the pair would be a wrong answer.

## 3. Why the IR and not a new opcode

The first sketch was "add an IR opcode meaning the flags are still live", which
would touch irgen, `irser`, MIR and all four backends. Reading the code showed
it was unnecessary: `-fopt-cbranch` already performs "`BINARY <cmp>` followed by
`JZ/JNZ` becomes a single conditional branch" **in the emitter**, so removing the
extra materialisation in the IR is enough -- the comparison lands on the value
stack, sits next to the branch, and the downstream pass collects the win. One
file changes, no new opcode, all four backends behave exactly as before.

## 4. Measured (95 HAL/Core TUs, `-O2` + the 23 `-fopt-*`)

| Metric | off | on | delta |
| --- | --- | --- | --- |
| instructions | 12,266 | 12,146 | **-120** |
| assembly bytes | 405,833 | 403,994 | **-1,839** |
| undefined labels / failed TUs | 0 / 0 | 0 / 0 | -- |

Only 8 TUs shrink and none grows (`stm32f4xx_hal_rcc.c -27`, `ll_utils.c -16`,
`hal_dma.c -13`, `hal_dma_ex.c -10`, `hal_rcc_ex.c -9`, `hal_exti.c -7`,
`hal_gpio.c -4`, `hal_pwr_ex.c -4`).

**The gain is smaller than expected, and the reason is measured**: most of the
40 remaining `ITE` blocks in the corpus are **short-circuit** shapes
(`if (A || B)`, `A ? 1 : B`) -- each arm pushes a value and the two must agree on
the stack shape at the join, so the `ITE` materialisation is unavoidable and the
`CBZ` that consumes it sits after the join. That is out of reach for this pass
(it needs a CFG-level rewrite of branch targets) and is logged as a follow-up.

## 5. Gate

`tests/run_boolmat_tests.py` (`make test-boolmat`) pins each of these:

| Check | Content |
| --- | --- |
| OFF IS OFF | `-O2` and `-O2 -fno-opt-boolmat` produce **byte-identical** assembly and image |
| IT PAYS | both the `ITE` count and the instruction count drop, and neither drop is zero (otherwise "the rule never fires" would pass too) |
| R2 fires | a fixture of only `(cmp) != 0`: `ITE 16 -> 8`, instructions `412 -> 340` |
| R3 fires | negation shapes whose value is *used* rather than branched on: `ITE 10 -> 7`, instructions `232 -> 223` |
| R3 steps aside | the same negations consumed by `JZ`: byte-identical with and without the flag (left to cbranch) |
| must not touch | `(a&3)!=0`, `(a+b)!=0`, a `char` variable, a pointer load, a call result, a `long long` comparison -> byte-identical |
| same answer | six relational operators, unsigned, negation, nesting, the value used as an `int`, the value used arithmetically: five arms (`base`/`off`/`on`/`va`/`all`) return one value on unicorn, equal to a Python computation of the same fixture |
| cropped out | a `-DARKCC_FEATURE_OPT_BOOLMAT=0` build answers `C3900U` for `-fopt-boolmat` and names the flag; without the flag it compiles normally |

## 6. Interaction

- **Super-additive** with `-fopt-cbranch` and `-fopt-imm`: R2 brings the
  comparison next to the branch, R3 turns `== 0` into a single `EOR` immediate,
  and both downstream passes get more to work with. R2 and R3 each shrink the
  output alone, but together they shrink it more (the `va -> all` columns above).
- The order relative to `-fopt-prop` is deliberate: `prop` folds
  "store a constant, read it back" into an immediate first, and boolmat only
  handles what is left, so the two never overlap.
