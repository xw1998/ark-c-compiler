# `-fopt-frame`: trimming callee-saved slots nobody uses

English | [中文](FRAME_TRIM.md)

> In one line: `-fopt-frame` deletes callee-saved register slots that were
> pushed but never used in the function body, from the **already emitted text**,
> and then deletes the matching `SUB sp` / `ADD sp` once the frame shrinks. On
> the whole HAL corpus it saves **29 instructions (-0.24%) and 84 bytes**, with
> `bigger TU 0` (not one translation unit grows).
>
> **What it saves is stack, not code.** See §3 -- this must be stated plainly, or
> we repeat the "predicted ten times the measured" mistake.
>
> **Verdict: against the pre-registered falsification line (< 0.5% total
> reduction closes the line), the code-size part is closed; the stack reading is
> booked and kept.** The flag is off by default and cropped in the STM32_MIN
> build (refused by name with `C3900U`).

---

## 1 Why

Every `HAL_xxx_Init` in HAL looks the same: enter with `PUSH {r4-r7, lr}`, leave
with `POP {r4-r7, pc}`. But many bodies only use `r4` (or none at all); the
remaining slots are pure habit copied from the prologue.

Offline census first (`pushscan.py`, 216 functions, 913 `PUSH` slots):

| quantity | reading |
|---|---|
| total `PUSH` slots | 913 |
| slots never read or written in the body | **289 (31.7%)** |
| in stack bytes | **1,156 B** |

Then a full model simulation of "drop slot -> frame shrinks -> drop `SUB`/`ADD`"
(`framesim2.py`) predicted **132 functions / 285 instructions / 1,328 B**.

## 2 Implementation

The pass runs right before `ark_fix_far_offset()` and after the second
`-fopt-addr` round, directly on the text emitted by `codegen_arm()`
(`src/backend/arm/backend_arm.c`, `ARKCC_FEATURE_OPT_FRAME`):

1. `fr_trim()` locates each function's `PUSH {..}` and the matching `POP {..}`;
2. scan the body and record every register read or written as `[rN` into `fr_names`;
3. drop from the `PUSH`/`POP` lists every callee-saved slot (`r4`-`r11`) that is
   **not** in the use set; `lr`/`pc` are never touched;
4. if `PUSH` is left with `{lr}` and `POP` with `{pc}`, delete the matching
   `SUB sp, #N` / `ADD sp, #N` as well (this is the step that removes an instruction);
5. one conservative bail: if `sp` appears in the body (inline asm, VLA, `alloca`),
   give up on the whole function; bail too if `base_used` disagrees with the frame size.

Delete-only, never insert => the correctness argument needs no liveness analysis,
only "the dropped slot is semantically unused".

## 3 Measured: code only breaks even, the gain is stack

Four arms -- base / this pass only / `-fopt-voldmb` only / both -- over 95 TUs:

| arm | insns | bytes |
|---|---|---|
| base | 12,304 | 32,690 |
| `-fopt-frame` | **12,275 (-29, -0.24%)** | **32,606 (-84)** |
| `-fopt-voldmb` | 12,134 (-170) | 32,074 (-616) |
| both | 12,105 (-199) | **31,990 (-700)** |

`-fopt-frame` alone: `smaller TU 10 / bigger TU 0 / identical 85`.

**Why 29 instructions and not the predicted 285** (debug counters from `frdbg_all.py`):

```
{'tipped_with_drop': 126,   # functions whose frame really shrank
 'frame_only': 0,           # PUSH/POP edited but SUB/ADD kept
 'drop0_baseused_bail': 25} # given up on, base_used mismatch
```

All 126 functions did shrink their frame, yet **none** of them also removed an
instruction -- because in 16-bit Thumb `PUSH {r4-r7, lr}` and `PUSH {r7, lr}` are
**both 2 bytes**. Dropping a slot changes encoding bits, not length. Only "the
frame becomes empty => `SUB sp`/`ADD sp` vanish too" really removes an instruction,
and in HAL only 29 functions reach that.

=> **The value of this pass is stack usage**: 1,156 B of stack is real on an MCU
(a 4 KB budget). Code size only breaks even. Reading it as a 2% size win is wrong.

## 4 Gate

- 95 TUs compile with 0 err;
- four arms `bigger TU 0`; the both arm `smaller TU 16 / identical 79`;
- **OFF IS OFF**: the default build is byte-identical to the pre-change binary
  (full `diff -rq` on `.s` and `.o` shows no difference);
- `tests/arm_exec` baseline 0 failure; `--extra=-fopt-frame --extra=-fopt-voldmb` also 0 failure;
- the cropped build (`ARKCC_FEATURE_OPT_FRAME=0`) refuses `-fopt-frame` by name
  with `C3900U`, and still compiles without the flag.

## 5 Not done / known limits

- No cross-`BL` slot reuse (needs liveness plus call-site analysis; the gain would
  again be stack only);
- Linux host not really run (no cross toolchain here); MinGW host plus
  `--layout both` build-level check only;
- STM32H743 only `--layout both` build; not run on the board.

## 6 Revision (2026-11-24): multiple returns and frame-base offset compensation

Under 23 switches `-fopt-frame` itself introduced two miscompiles, both variants of
"a PUSH slot was trimmed on one return path only".

### 6.1 Multiple returns: only the first epilogue was trimmed

The old code trimmed the **first** `POP {..}` it found; other return paths kept the wide
`POP`. One function therefore had `PUSH {r4-r7, lr}` narrowed to `PUSH {r7, lr}` while a
second epilogue still executed `POP {r4-r7, pc}` — popping four extra words on exit,
leaving SP skewed, and the emulator reported `UC_ERR_EXCEPTION`.

Fix: step 2 collects **all** `POP {..}`; step 3b marks the sp-restore line of every
`return` path (`MOV sp, r6` / `ADD sp, #N`); step 4 scans the whole function; step 7
rebuilds line by line. `FR_MAX_EPI = 64` is the ceiling; beyond it the function is bailed.
The trimmed set is the **intersection** over all epilogues (drop a slot only if no return
path uses it).

### 6.2 base_used: dropped words must become padding

With a frame base the prologue is `PUSH {..}` + `SUB sp, sp, #N` + `MOV r6, sp`, and
incoming stack arguments live at `[r6, #(4*np + oldN) + k]`. Dropping `d` PUSH slots also
shrinks the `SUB` immediate by `4d`, which **moves the base down by `4d`**, while the
incoming arguments stay where the caller put them per the ABI — every stack argument is
then read `4d` bytes off. Measured: `five(1,2,3,4,9)` returned `11` (the fifth argument is
a stack argument).

Fix: with `base_used` the total frame size is kept unchanged — `newN = oldN + 4 * dropped`
(the dropped slots become padding, the `SUB` keeps its old immediate). If the original
frame size is not a multiple of 8 (so the alignment cannot be preserved while compensating),
the whole function is bailed.

**Why not simply bail.** Bailing loses frame optimisation for every function with locals or
stack arguments, which is exactly where the win is. With compensation the total frame size
is unchanged and the alignment holds automatically, while the shorter `PUSH`/`POP` encoding
is still gained (in 16-bit Thumb `PUSH {r4-r7,lr}` and `PUSH {r7,lr}` are the same length;
the real win is stack, see §3).

### 6.3 Gates

`abi_stack_args` with `-fopt-frame` alone = 50 (1 before the fix); `shift64` with five
flags = 50; `tests/arm_exec` under 23 switches 40/40; `make test-frame` fully green;
95 TUs compile without error.
