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

## 7 Revision (2026-11-25): two miscompiles and a stack-balance guard

The compensation in §6 covers only two paths: "the frame base is still used"
(`base_used == 1`) and "the input already carried an `ADD sp, sp, #n` line". Sweeping the
whole corpus showed the two remaining paths are both miscompiles, and both have the same
shape: **a slot was dropped, but one step of the sp teardown was skipped**.

### 7.1 Defect A: synthesised padding that nobody removes

When `base_used == 0` (the base was built but the body never names it) the pass computes
the alignment padding itself, `newN = (nkeep % 2 == 0) ? 0 : 4`, and emits
`SUB sp, sp, #newN` in the prologue. The teardown side, however, only rewrote or kept an
`ADD sp, sp, #oldN` **that was already in the input text**. When the original teardown was a
single `MOV sp, base` (the padding is covered by restoring the base, so there is no ADD
line), dropping the base because `base_used == 0` left `newN == oldN`, so the `SUB` stayed
as it was and **nothing gave the padding back**.

`HAL_SuspendTick` under 22 switches, before the fix:

```
    PUSH {r5, r7, lr}          ; three words
    SUB sp, sp, #4             ; a 16-byte frame
    ...
    POP {r5, r7, pc}           ; pops three words only: r5 takes the hole, pc takes the saved r7
```

That is a guaranteed crash: the return jumps to the saved value of r7, and sp is 4 bytes
high.

Fix: the teardown no longer depends on the input carrying an ADD line — in front of every
return path's `POP`, if `newN > 0` and this path has not already undone the padding
(`pad_done`), the pass synthesises `ADD sp, sp, #newN`. For both `base_used == 1`
(`MOV sp, base` + `ADD #newN`) and `base_used == 0` (no base) that single `ADD #newN` lands
sp exactly at `sp_entry - 4 * nkeep`, so the two paths merge into one. `pad_done` is reset on
every label line so that one path's teardown state cannot leak into the next (adding it
twice or not at all).

After the fix:

```
    PUSH {r5, r7, lr}
    SUB sp, sp, #4
    ...
    ADD sp, sp, #4
    POP {r5, r7, pc}
```

### 7.2 Defect B: an unmatched `PUSH {r0}` on a branch

`-fopt-vstack` leaves a `PUSH {r0}` that no `POP` ever matches in front of a branch that
jumps to the common return block (`return expr` pushes the value, then the target
re-materialises it with `MOV r0, #imm`):

```
    MOV r0, #0
    PUSH {r0}                  ; no matching POP
    B .L_HAL_Init_0
```

This was harmless before 0.9.1 **only because `MOV sp, r6` restores sp absolutely**. Once
`-fopt-frame` removes the frame base the epilogue's `POP` reads from a shifted stack:
`HAL_Init` was emitted as `PUSH {r5, lr}` + `POP {r5, pc}`, which looks balanced, but r5 was
restored from the leaked 0 (the caller's callee-saved register was clobbered); only because
pc happened to land on the saved lr did it not crash outright.

The fix is a **guard**, not a compensation: after `fr_mark_used` the pass walks the function
text once, linearly, keeping a word depth that starts at `np` (`PUSH` adds, `POP`
subtracts). On reaching every return path the depth must equal exactly the number of
registers that `POP` names; otherwise the whole function is bailed (its `MOV sp, base` and
original teardown are kept).

**Why bail.** A path-dependent stack imbalance has no single constant that compensates it,
and a linear scan cannot see branch joins, so it will sometimes bail on a function that is
really fine — and a false bail costs **code size only**, which is the same direction as
"rather report an error than give a wrong answer". The code comments say so.

Cost on this corpus: **45 functions** have an unbalanced return depth in the 22-switch input
text, and all 45 are now left untrimmed. The root cause (the front end pushing a word on a
`return` path and re-materialising the constant at the target) cannot be decided safely in
the text layer; it is registered as follow-up work (needs a CFG or an IR-side fix).

### 7.3 Cost and readings

95 TUs, 22 switches (`off` and the 19-switch arms are unaffected and still read exactly as
in `docs/VREG.md` §18.5):

| Configuration | Instructions | Bytes |
| --- | ---: | ---: |
| before (`0521238`) | 12,215 | 404,970 |
| after | **12,258 (+43 / +0.35%)** | **406,264 (+1,294 B / +0.32%)** |

Per function: **40 functions** change, of which **28 are guard bails** (`HAL_Init`,
`HAL_InitTick`, `HAL_DMA_DeInit`, `HAL_DMA_Start`, `HAL_RCCEx_PeriphCLKConfig`,
`LL_PLL_ConfigSystemClock_*`, and so on) and **12 are defect A being fixed, one synthesised
`ADD sp, sp, #4` each** (`HAL_SuspendTick`, `HAL_DBGMCU_DisableDBG{Sleep,Stop,Standby}Mode`,
`HAL_MPU_Disable`, `HAL_FLASH_OB_Launch`, `HAL_PWR_DeInit`, `HAL_PWR_DisableSleepOnExit`,
`HAL_RCC_GetPCLK{1,2}Freq`, `FLASH_FlushCaches`, `HAL_PWR_DisableSEVOnPend`). The single
`DMB SY` and the 95 adjacent `CMP #0` + conditional-branch pairs are unchanged.

The +1,294 B is **the price of fixing miscompiles, not a new feature**: on the same corpus
`-fopt-frame` now degrades to "leave the function alone" on those 40 functions instead of
producing code that crashes or clobbers registers.

### 7.4 Gates

- `make test` fully green (21 suites, 0 failed / 1 skipped);
- `tests/arm_exec` under 23 switches **40/40**; `tests/arm_exec --extra=-fopt-frame
  --extra=-fopt-voldmb` **40/40** (there is no `make test-frame` target);
- the cropped build (`ARKCC_FEATURE_OPT_FRAME=0`) refuses `-fopt-frame` by name
  (`C3900U`), while the 5 lite-profile switches are still accepted (23/23 refused,
  5/5 accepted);
- 95 TUs compile with 0 err; with `-fopt-frame` off the output is byte-identical (covered by
  the byte-identical suites in `make test`).

---

## 8 Revision 2 (2026-11-25): `keep_base` -- taking the whole-function bail back

### 8.1 Why a second revision

Section 7 traded safety for a whole-function bail, and the price was 28 functions losing
trimming entirely. Read the root cause of Section 7.2 backwards and it says something else:
the leaked `PUSH` is only fatal **because the frame base was deleted with it**. As long as
every return path still runs `MOV sp, base`, the epilogue does not read from wherever sp
happens to point -- it rebuilds sp from the saved base, so the leak is still there but it can
no longer move the words the `POP` reads.

So the guard becomes three-way instead of two-way:

1. return path balanced -> trim as before (the behaviour prior to Section 7);
2. unbalanced, but every return path can rebuild sp with `MOV sp, base` -> **`keep_base`**:
   keep the base, keep trimming the PUSH/POP slots and the padding;
3. unbalanced and some path can only tear the frame down with `ADD sp` -> only then fall back
   to the Section 7 bail.

### 8.2 Implementation (`ark_frame_function`)

- the depth scan no longer `goto bail`s when a `POP {..pc}` arrives at a depth that differs
  from its register count; it only sets `need_base`;
- after the scan every return path is checked against `fr_eb[]` (recorded by the backwards scan
  in step 3b: "this path's teardown contains `MOV sp, base`"). Any path without it still
  bails, otherwise `keep_base = 1`;
- under `keep_base` the base register slot stays in the PUSH/POP lists (otherwise `MOV sp, base`
  reads a register nothing saved), and both `MOV base, sp` and `MOV sp, base` are kept;
- padding splits two ways: when the body never names the base (`base_used == 0`) the whole
  padding goes (`newN = 0`, sp is restored by `MOV sp, base`, and no stack argument is read
  through the base anyway); when the body does use the base, Section 7's rule applies
  (`newN = oldN + 4 * dropped`) because stack-argument offsets are computed from
  "base = sp minus padding", so the total frame size must be preserved.

### 8.3 Readings

| Configuration | Instructions | Bytes |
| --- | ---: | ---: |
| before (`0521238`, with the miscompiles) | 12,215 | 404,970 |
| Section 7 guard (whole-function bail) | 12,258 | 406,264 |
| Section 8 `keep_base` | **12,239** | **405,426** |

That is **-19 instructions / -838 B** against the guard build and **+24 instructions / +456 B**
against the pre-fix build -- the net price of the miscompile fixes, cut down from +43 / +1,294 B.
`off` (49,186 / 927,055) and the 19-switch arm (12,602 / 412,756) are byte-identical: with frame
off this path never runs, so OFF IS OFF still holds.

Per function (against the "frame off" input text): **123 functions are rewritten, 51 of them
with fewer instructions, none with more.** Typical: `HAL_InitTick` 40->36, `HAL_ResumeTick`
9->6, `HAL_NVIC_EnableIRQ` 7->5, `HAL_DMA_Abort_IT` 29->26, `HAL_Init` 26->25.

### 8.4 Self-check: one recomputable invariant

New check (reads the emitted text only, no pass-internal state): for every function in the
95-TU, 22-switch output, run a linear stack-depth scan; whenever a `POP {..pc}` arrives at a
depth that does not match its register count, that function **must** contain `MOV sp, rX`.

| Build | Functions | with `MOV sp, base` | unbalanced **and** no base |
| --- | ---: | ---: | ---: |
| before (`0521238`) | 216 | 161 | **6 functions / 13 paths** (`HAL_Init`, `HAL_InitTick`, `HAL_DMA_Abort_IT`, `HAL_PWR_PVD_IRQHandler`, `HAL_RCC_NMI_IRQHandler`, `HAL_RCC_DeInit`) |
| Section 8 `keep_base` | 216 | 167 | **0** |

Note this invariant is **not** "the stack is always balanced" -- the leak from Section 7.2 is
still there (that is the value-stack pass's debt, registered at the end of Section 7.2). What it
proves is that an imbalance can no longer misalign the epilogue's `POP`.

### 8.5 Gates

- `make test` fully green: `RC=0`, 612 `PASS`, 486 `[ok]`, `0 failure(s)`; the single `FAIL
  selftest` line is the soft-float comparator's **deliberate negative self-check**, immediately
  followed by `self check: comparator rejects a wrong answer (ok)`;
- `tests/arm_exec` under 23 switches **40/40**;
- cropped build (`ARKCC_PROFILE_STM32_MIN`), all 28 switch names tried: **23/23 refused
  (`C3900U`)**, the 5 lite-profile switches **5/5 accepted**;
- 95 TUs compile with **0 err**; with `-fopt-frame` off the output is byte-identical to `dcc43ea`.
