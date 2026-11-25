# Dead frame maintenance at the exits (`-fopt-exit`)

English | [中文](EXIT.md)

> The eighth optimisation of 0.9.1. In one sentence: **a body that never touches
> sp arrives at every return with sp still equal to the frame base, so
> `MOV sp, <base>` writes back a value the register already holds -- delete it;
> and when the base is never used as a base either, the prologue's
> `MOV <base>, sp` that built it is dead too.**
>
> Implementation: `src/backend/arm/backend_arm.c`, `ark_exit_function()` (a
> text-line pass in the ARM backend, right after `ark_frame_function()` and
> before `ark_fix_far_offset()`)
> Gate: `tests/run_exit_tests.py` (`make test-exit`)
> Switch: `-fopt-exit` / `-fno-opt-exit`, INI `opt-exit=` / `exit=`
> Croppable: `ARKCC_FEATURE_OPT_EXIT` (0 in the `STM32_MIN` profile; when
> cropped out the flag is refused by name)

---

## 1. The symptom: every return rewrites a register that never moved

A function with a frame looks like this:

```asm
PUSH  {r5, r6, r7, lr}
SUB   sp, sp, #16
MOV   r6, sp            ; build the frame base
...
MOV   r6, sp            ; <- redundant (E2)
...
MOV   sp, r6            ; <- redundant (E1)
ADD   sp, sp, #16       ; walk back over the frame (must stay)
POP   {r5, r6, r7, pc}
```

`MOV sp, r6` is the **safe default**: if one arm of an `if` leaks a `PUSH`/`POP`
pair, sp at the end of the body is no longer the frame base and `POP {...,pc}`
would read the wrong words. Rebuilding sp from the base decouples the return
path from "is the body stack-balanced?".

The price is one instruction on **every return path**, even in a function whose
body never touches sp. That is the majority of the corpus: as soon as
`-fopt-vstack` moves the value stack into registers, or the function has no
locals at all, the body does not mention sp once.

## 2. Two rules

The whole thing is a **text-line pass** and only deletes: no label is added, no
branch target is rewritten, the frame size is untouched, so
`ark_fix_far_offset`, the literal-pool offsets and the control flow all see the
same function they saw before.

### E1 -- delete `MOV sp, <base>`

The condition is "the whole body provably never moves sp", i.e. after the
prologue nothing else mentions `sp` except these three shapes:

| accepted | why |
| --- | --- |
| `POP {..., pc}` | a return path, kept verbatim |
| `MOV sp, <base>` | E1's own candidate |
| the `ADD sp, sp, #N` or `SUB sp, sp, #N` **directly after** it | the epilogue walking back over the frame -- **kept** |

The third row is the subtle part: `ADD sp, sp, #16` is not a no-op -- sp has to
pass over the frame before the `POP` can read the callee-saved words. So only
the `MOV sp, r6` in front of it goes, the `ADD` stays. The positional
constraint matters: an sp adjustment anywhere else (a VLA's `SUB sp, sp, r0`, an
inline `sub sp, sp, #4`) means the body moves the stack, the base is
load-bearing, and the whole function is refused.

### E2 -- also delete the prologue's `MOV <base>, sp`

E1 must already hold, and the base register must appear **nowhere else** in the
function: the base was built and then never read as `[r6, #off]`, so it is a
value written and thrown away. The r6 inside `PUSH {...}` / `POP {...}` is its
save slot, not a use (those live in the prologue and the epilogues anyway; the
line-level test is about mentions). A single `r6` in the body only cancels E2;
E1 still applies.

### Conservative refusal

Any of the following and **not one character of the function changes**:

- any `PUSH` (a leaked value-stack push is exactly what `MOV sp, base` protects
  against)
- any `POP` without `pc`
- any other mention of sp (`LDR sp`, `STR sp`, an out-of-place `ADD|SUB sp, sp,
  ...`)
- an over-long line, or a function longer than 8192 lines (table guard)
- no unique prologue shape `MOV <base>, sp` (base not in r4-r11)

## 3. Why it runs after `-fopt-frame`

Running it *before* the frame trimmer has an appeal: `-fopt-frame` would see an
unused r6 and could also drop the r6 save slot and the alignment padding from
`PUSH {...}` (bounded by E2's 48 functions).

The cost is that `-fopt-frame` **bails out entirely**: it locates the frame base
by scanning for `MOV <base>, sp`, so a function whose base was already deleted
loses its `SUB sp`/`ADD sp` trimming too. The trade is clearly negative, so the
order is **frame -> exit -> fix_far_offset**.

## 4. Measured (95 HAL/Core TUs, `-O2` + 24 `-fopt-*`)

| metric | off | on | delta |
| --- | --- | --- | --- |
| instructions | 12,146 | 11,913 | **-233** |
| assembly bytes | 403,994 | 400,499 | **-3,495** |
| undefined labels / failed TUs | 0 / 0 | 0 / 0 | -- |

18 TUs got smaller and **not one got bigger** (`stm32f4xx_hal.c -33`,
`hal_cortex -31`, `hal_dma -28`, `stm32f4xx_it.c -18`, `hal_pwr_ex -18`,
`hal_flash_ex -17`, `hal_flash -15`, `hal_rcc -13`, `hal_rcc_ex -13`,
`hal_pwr -12`, ...).

Where the -233 comes from (corpus count, matches the total above):

| rule | functions that fired | lines deleted |
| --- | --- | --- |
| E1 | 139 of the 166 functions with a frame base | 185 |
| E2 | 48 more of those (base never read) | 48 |
| total | -- | **233 (about 1.9%)** |

Why the other 27 framed functions decline: the body has a `PUSH` (the value
stack was not fully absorbed by `-fopt-vstack`), or sp is adjusted inside the
body (VLA / `alloca` / inline assembly). **That is the design: save less rather
than answer wrong.**

## 5. The gate

`tests/run_exit_tests.py` (`make test-exit`) pins 18 checks:

| check | content |
| --- | --- |
| OFF IS OFF | `-O2 <passes>` and the same plus `-fno-opt-exit` are **byte-identical**, as text and as image |
| E1 fires | a function with locals: `MOV sp, <base>` count 1 -> 0 and the instruction count drops (the drop is asserted to be non-zero) |
| E2 fires | a parameterless `void` function: `MOV <base>, sp` also goes 1 -> 0, and exactly two lines per function are removed |
| a real base is kept | in the same E1 fixture the `MOV <base>, sp` count is unchanged (E2 must step aside) |
| the teardown stays | `ADD sp, sp, #N` and `POP {..., pc}` counts are unchanged in both fixtures |
| the image never grows | every arm's image is <= the arm without the flag |
| labels whole | every branch target is defined |
| it declines | a VLA (`SUB sp, sp, r0`) and an inline `sub sp, sp, #4` come out **byte-identical** |
| same answer | recursive frame function + two-return epilogue + frameless `void` function + VLA: four arms (`base`/`off`/`on`/`all`) return 48 in unicorn, matching a Python computation |
| cropped out, refused | a `-DARKCC_FEATURE_OPT_EXIT=0` build reports `C3900U` with the flag named, and still compiles the file without the flag |

## 6. Where it sits

- **Complementary, not overlapping, with `-fopt-frame`**: the trimmer owns
  `SUB sp` / `ADD sp` / save slots; this pass owns the `MOV sp, base` on the
  return paths and the unused `MOV base, sp`. With both on, the corpus is left
  with `MOV sp, base` + `POP {...pc}`, which is exactly what this pass deletes.
- **Strongly coupled to `-fopt-vstack`**: only a body whose value stack lives in
  registers stops touching sp, which is what makes E1 eligible. The 27 declined
  functions are mostly the ones the value stack did not absorb.
- **No coupling with `-fopt-litpool` / `-fopt-addr`**: pure deletion, and
  `ark_fix_far_offset` still runs afterwards.
