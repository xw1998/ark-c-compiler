English | [中文](CONSTCOND.md)

# Deciding a branch whose condition is a literal: `-fopt-constcond`

0.9.1-wip. A very small pass: when the condition's value is a literal in the IR, the
branch has a certain direction at compile time. It is off by default and worth
**-79 instructions (-0.65%) / -1,483 bytes (-0.37%)** across 95 HAL/Core TU, `-O2`,
Cortex-M4, 22 -> 23 flags.

## 1 The problem: the front end really hands literal conditions to the emitter

The most common "always true" condition in HAL and user code is not a hand-written
`if (1)`, it is a macro expansion:

```c
#define __HAL_LOCK(__HANDLE__)                       \
  do {                                               \
    if ((__HANDLE__)->Lock == HAL_LOCKED) {          \
      return HAL_BUSY;                               \
    } else {                                         \
      (__HANDLE__)->Lock = HAL_LOCKED;               \
    }                                                \
  } while (0U)                                       \
```

The tail condition of `do { ... } while (0U)` is the literal `0U`, and `assert_param(...)`
becomes `if (0)` when assertions are compiled out. The front end faithfully builds those
conditions into the IR:

```
PUSH_INT 0
PUSH            ; the value-stack DUP (not emitted)
POP
JZ  .L_then
```

So **every** `__HAL_LOCK` and every `do {} while (0)` wrapper leaves a live
`MOV r0, #0` / `CMP r0, #0` / `BEQ` chain. It is not wrong code -- it is a branch whose
answer is already known.

## 2 Why the IR layer

To delete the chain at the text layer you would have to answer two questions the text
cannot: is this constant in `r0` *exactly* what this branch consumes (nothing wrote it in
between)? Are the `PUSH`/`POP` balanced? The IR layer needs neither answer:

- the `k` in `PUSH_INT k` is a literal in the IR, not the history of a register;
- the net stack effect of `PUSH_INT k` plus the following `JZ`/`JNZ`/`CMP_JMP_EQ` is zero,
  so deleting the pair does not move the evaluation depth of any other instruction.

## 3 The three folding rules

| IR shape | Condition truth | Result |
| --- | --- | --- |
| `PUSH_INT k`, `JZ L` | `k == 0` | becomes `JMP L`; `PUSH_INT` becomes `NOP` |
| `PUSH_INT k`, `JZ L` | `k != 0` | both become `NOP` (fall through) |
| `PUSH_INT k`, `JNZ L` | `k != 0` | becomes `JMP L` |
| `PUSH_INT k`, `JNZ L` | `k == 0` | both become `NOP` |
| `PUSH_INT k`, `CMP_JMP_EQ a, b, L` | `k == b->val` | becomes `JMP L` and `b->val = b->aux` (the payload the branch compares is switched to the compared value); otherwise `NOP` |

Between the `PUSH_INT` and the branch, zero or more `IR_DUP` are allowed (`val <= 1` and
not volatile): the DUP is popped by the branch, so folding does not touch it. The corpus
has no such gap in practice (the reading is identical with and without the extension), but
the logic is kept.

At the end the pass calls `compact_func()` to drop the `NOP`s from the instruction stream.

### 3.1 Why before `ir.dce`

Folding can only *create* unreachable code (the block after the new unconditional jump in
`if (0)`, the body of `while (0)`). Running before the linear DCE lets that block be
removed in the same sweep, with no second pass. Measured: `if (0) { g = a*7; }` drops from
38 instructions to 17 (shared prologue/epilogue included) and the loop body disappears
entirely.

## 4 What it does not do (and why)

| Not done | Reason |
| --- | --- |
| 64-bit literal conditions | `PUSH_INT` carries 32 bits; 64-bit constants take another IR path and need their own balance argument |
| data-flow constants (`const int N = 0; if (N)`) | that is `constfold` plus constant propagation; this pass only takes **direct** literals |
| conditions involving volatile | a volatile read is not a constant and must really happen |
| text-level `MOV imm + CMP #0 + conditional jump` deletion | needs text-level liveness, a different order of work; see the residual in §6 |

## 5 Reading (95 TU, `-O2`, Cortex-M4)

| Configuration | Instructions | Bytes | Errors |
| --- | --- | --- | --- |
| 22 `-fopt-*` | 12,113 | 403,432 | 0 |
| 23 (+ `-fopt-constcond`) | **12,034** | **401,949** | 0 |
| delta | **-79 (-0.65%)** | **-1,483 B (-0.37%)** | -- |

12 translation units change, **none grows**. Hottest units by instruction count:

| TU | delta |
| --- | --- |
| `stm32f4xx_hal_dma.c` | -15 |
| `stm32f4xx_hal_flash_ex.c` | -12 |
| `stm32f4xx_hal_rcc.c` | -10 |
| `stm32f4xx_hal_dma_ex.c` | -8 |
| `main.c` | -7 |
| `stm32f4xx_it.c` | -5 |
| `gpio.c` / `stm32f4xx_hal_msp.c` / `stm32f4xx_hal_flash.c` / `stm32f4xx_hal_pwr_ex.c` / `stm32f4xx_hal_rcc_ex.c` | -4 each |
| `stm32f4xx_hal_gpio.c` | -2 |

## 6 Residual: 37 `MOV rX, #imm` right before `CMP rX, #0`

The 23-flag text still contains 37 of these. Sampled, both kinds are **not** adjacent
literal conditions:

1. **Boolean materialisation + logical or** -- `if (cb != NULL || m1cb != NULL)` compiles to
   `MOVNE r0, #1` / `MOVEQ r0, #0` / `B .L_x_8`, then `MOV r0, #1` / `CMP r0, #0` / `BEQ`.
   That `#1` is the **result** of the materialisation above, not a literal in the source.
2. **Shift-amount guard** -- `MOV r4, #32` / `CMP r4, #0` / `ITE LT`: `#32` is a shift width
   and the `CMP` is the negative-shift check, unrelated to constant conditions.

Removing kind 1 needs a "boolean materialisation" pass at the IR layer (feeding the 0/1
value of `?:`/`||` straight into the branch) that must also handle the two-branch merge.
That is a different pass with a much wider reach. It is registered, not folded in here.

## 7 Cropping

`ARKCC_FEATURE_OPT_CONSTCOND`: 0 for `ARKCC_PROFILE_STM32_MIN`, 1 otherwise. When cropped,
`-fopt-constcond` is **refused by name** (`C3900U`) rather than accepted and silently
ignored. Measured **23/23**: the 22 older flags plus `constcond` all return `C3900U`,
while the five kept flags `constfold` / `dce` / `inline` / `regalloc` / `vectorize` still
return `rc=0`. (The table in `docs/BUILD.md` section 5.2 says 23/23 for the same reason.)

## 8 Gate

`tests/run_constcond_tests.py` (19 checks, `make test-constcond`):

1. **OFF IS OFF**: `-O2` and `-O2 -fopt-constcond -fno-opt-constcond` are byte-identical
   (assembly and image).
2. The **dead body of `if (0)` disappears** (no store into `cc_g0` survives).
3. The **taken body of `if (1)` stays**, with no branch on a literal left.
4. **`while (0)`** leaves no back-edge.
5. **`do { } while (0)`** keeps the body and drops the back-edge.
6. **A real condition is untouched**: a function branching on a parameter is byte-identical,
   in the same translation unit as a folded function.
7. **The answer is the same**: all five fixtures return the Python value (6/7/8/9/21) on
   unicorn in both arms.
8. **Cropped, refused**: a `-DARKCC_FEATURE_OPT_CONSTCOND=0` build reports `C3900U` and
   names `-fopt-constcond`; without the flag it still compiles.