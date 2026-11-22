# Short-branch shrinking (`-fopt-branch`)

English | [中文](BRANCH_SHRINK.md)

> The seventh optimisation of 0.9.1. One sentence: **a `B` / `B<cond>` whose target
> is inside the 16-bit range drops from four bytes to two -- same instruction
> count, fewer bytes, same meaning.**
>
> Implementation: `src/backend/arm/backend_arm.c` (inside the assembler:
> `pass1_a` / `arm_decide_branches` / `pass2_a` / `emit_b16_a`)
> Gate: `tests/run_branch_tests.py` (`make test-branch`)
> Switch: `-fopt-branch` / `-fno-opt-branch` (alias `branch`), INI `opt-branch=` / `branch=`

---

## 1. Why, and at which layer

This backend has always emitted 32-bit branches: `B.W` (T4, +-1 MB) and
`B<cond>.W` (T3, +-1 MB). The reason is written next to `op_size_a()`: a 16-bit
branch that does not fit is **truncated silently**, and the sizing pass does not
yet know where the labels will finally land. A truncated loop back-edge jumps into
the middle of an instruction, and this repository really hit that once after
`-fopt-vstack` was enabled (`UC_ERR_WRITE_UNMAPPED`, pc sitting on the second
halfword of a `PUSH`).

The price of that conservatism is two bytes on every short branch, and most
branches only reach a few lines. So this pass does exactly one thing: **measure
the whole assembly file once with every branch at four bytes, find each branch's
real offset, then rewrite only the ones that really fit into the two-byte form.**

It lives **inside the assembler**, not in the text layer: the text layer cannot
compute label addresses, while two passes are already there. Nothing upstream (IR,
three backends) changes, and every `B` / `B<cond>` line benefits whatever produced it.

## 2. Three rules

During the measuring round, `pass1_a()` records `(pc, cond, target name)` for every
`B` / `B<cond>` and also remembers where each `.align` / `.balign` sits. Then
`arm_decide_branches()` judges each one:

| Condition | Test |
| --- | --- |
| **C1 target is defined** | `find_label_a()` finds it (externals are left to the linker) |
| **C2 fits the 16-bit range** | unconditional: `-2048 <= off <= 2046` (T2, imm11); conditional: `-256 <= off <= 254` (T1, imm8). `off` is relative to `pc+4` and must be even |
| **C3 no `.align` inside the span** | padding is non-linear: shrinking changes the padding, which changes the offset again, which may oscillate. Any span crossing `.align` is refused |
| **C4 forward targets count as an upper bound** | a forward target is reduced by another 2 (this branch's own 4 -> 2 pulls the target closer); other shrinks can only shorten the span further, so the result is an upper bound |

All three hold => `shrink = 1`, and pass 2 emits the two-byte form at the same ordinal.

**Why only two pass-1 rounds**: the decision uses a conservative upper bound (C4)
and a shrink can only shorten spans, so a branch that fit in round one fits even
better in round two -- the decision is monotone and cannot flip. Measure -> decide
-> if anything changed, run pass 1 again (now with real 2/4-byte widths, so
alignment padding is exact) -> pass 2. No fixed-point iteration.

## 3. The big trap: pass 1 must lay out the final widths

The first version still sized every branch at four bytes in the second pass-1
round while pass 2 emitted two bytes: label addresses were never re-laid, so
**every instruction after pass 2 moved two bytes earlier** and branches landed in
the middle of instructions (`UC_ERR_WRITE_UNMAPPED`, `addr=0`, `pc=0x8000C2A`,
on the entry of `__arkcc_globals_init`). Disassembly showed `bne.n 0xc44` where it
should have been `0xc36`.

The fix is for `add_branch_a()` to return the width this round uses, and pass 1 to
do `pc += add_branch_a(...) ? 2 : 4`. After that all four arms executed identically.

The lesson: **layout and emission must share one width source.** So emission has a
self-check too -- `emit_b16_a()` recomputes `off`, and on an out-of-range value it
raises a hard error (`internal layout error: shrunk B does not fit its 16-bit
range`) and emits `0xBF00` (a `NOP`) instead of encoding a truncated offset.
Fail the build rather than emit a wrong jump.

## 4. How pass 2 keeps its place

Pass 2 walks `branches[]` by occurrence ordinal: every branch takes the current
entry and only uses its `shrink` when `cond` and the target name match; otherwise
it falls back to the 32-bit encoding. That fallback is required insurance: losing
a fold is acceptable, desynchronising layout and emission is not.

## 5. Measurements

### 5.1 Fixtures (`tests/run_branch_tests.py`)

| Fixture | plain `-O2` | with `-fopt-branch` | note |
| --- | --- | --- | --- |
| `near` (loop + small `if`) | 1,386 B / 160 insns | **1,368 B / 160 insns** | 18 B saved (9 branches), count unchanged |
| `near` on `-fopt-vstack -fopt-addr` | 1,294 B | **1,276 B** | still 18 B on the shorter shape |
| `far` (200-statement `while` body) | 6,466 B | **6,456 B** | exit test and back-edge are both past 2 KB, so **only the runtime helpers' 10 B** |
| `vfar` (300-statement loop) | 9,366 B | **9,356 B** | same, 10 B |

"Only 10 B" in the last two rows is **correct behaviour**: every image carries the
runtime helpers (`__arkcc_globals_init`'s zeroing loop and the `memcpy` loop), and
those do contain a few genuinely short branches. The gate measures that baseline
with a minimal program that has no user branch at all (`save=10`) and requires
`far` / `vfar` to save **exactly** the same amount -- one extra byte would mean the
long branch had been squeezed into 16 bits.

### 5.2 Whole STM32F4 HAL corpus

All 99 translation units of `examples/ark_test` (`Core/Src` + `HAL_Driver/Src`),
`-c -O2 -mcpu Cortex-M4 --reloc-data`, five separate `-I`:

| Measure | plain `-O2` | with `-fopt-branch` | change |
| --- | --- | --- | --- |
| units compiled | 96 | 96 | three `*_template.c` / external-symbol units skipped, same on both arms |
| code-section bytes (sum of the object header length field) | 116,480 B | **113,058 B** | **-3,422 B / -2.94%** |
| object file bytes (symbol tables included) | 136,352 B | **132,930 B** | -3,422 B (the symbol table is byte-identical, so all of it is code) |
| units that shrink | -- | **96 / 96** | nothing grows; largest -1,020 B (`stm32f4xx_hal_dma_ex`) |

## 6. What the gate says

`make test-branch` runs three fixtures x five arms (`base` / `off` / `on` / `va` /
`all`) plus a reference program and a cropped build -- 18 checks:

1. **OFF IS OFF**: `-O2` and `-O2 -fno-opt-branch` are byte-identical (1,386/1,386).
2. **the reference program isolates helper branches**: `save=10`, and even.
3. **`near` keeps its instruction count**: 160 -> 160.
4. **`near` shrinks by whole 2-byte branches**: `1,386 -> 1,368` (-18).
5. **`near` really drops bytes**.
6. **`near` still pays on `-fopt-vstack -fopt-addr`**: `1,294 -> 1,276`.
7. **the image never grows**.
8. **all five arms agree**: `42 x 5`.
9. **`far` keeps the out-of-range target 32-bit**: `save=10`, equal to the reference.
10. **`far` keeps it under the other two passes**: `3,622 -> 3,612` (again 10).
11. **`far` image never grows**.
12. **`far` arms agree**: `132 x 5`.
13. **`vfar` likewise**: `save=10`, `va 5,198 -> 5,188`.
14. **`vfar` arms agree**: `94 x 5`.
15. **the cropped build refuses `-fopt-branch` by name** (`C3900U`, exit 1).
16. **the cropped build still compiles without the flag** (exit 0).

Checks 3-8 together guard "fewer bytes but same meaning": asserting only "smaller"
would miss a wrong target (which also shrinks the image), so every arm must return
the value Python computed on unicorn -- a one-byte offset error takes the wrong
branch or fetches from the middle of an instruction and the value changes at once.

Two gate-design problems found during development, kept here for reference:

- **An `if` fixture is a poor "far target" test**: `if (n) { 200 stmts }` ends the
  body with a `b.w` to the join point at offset 0, and **shrinking that one is
  correct**, so `save` is always 2 above the reference. With a `while` body both
  the exit test and the back-edge are genuinely out of range and `save` equals the
  reference exactly.
- **100 statements are not far enough under `-fopt-vstack`**: vstack cuts each
  `s += k` from ~27 to ~12 bytes, leaving ~1,200 bytes, so the back-edge lands
  inside T2 and shrinks legitimately. The fixture therefore uses **200 statements**.

## 7. Cropping

`ARKCC_FEATURE_OPT_BRANCH` in `include/arkcc_config.h` is 0 under
`ARKCC_PROFILE_STM32_MIN` and 1 on host / cross builds. At 0 the whole plan state
of `ArmAsm` (`branches` / `align_pcs` / `plan_branches` ...) and the `pass1`/`pass2`
call sites are preprocessed away -- **no fields, no code, no size change** -- and
`src/main.c` rejects the flag with `C3900U: -fopt-branch is not compiled into this
build` (refused, not silently ignored).

It is **off** at runtime (`g_config.enable_opt_branch = 0`), so output without the
flag is byte-identical to 0.9.0.

## 8. Relationship to the other passes

It runs inside the assembler, **after every text-level pass**: it sees the final
instruction stream produced by `vstack` / `addr` / `strength` / `cbz`, so

- a shorter function can bring an out-of-range branch back into range, which makes
  the saving additive (`near` still saves 18 B on top of `va`, same for the HAL
  corpus);
- conversely it opens no new opportunity for the earlier passes (widths change,
  instruction counts do not).

It does not conflict with `-fopt-cbz` either: cbz **deletes** a conditional branch,
so the ordinal table simply has one entry less, and each pass only touches its own layer.

## 9. Costs and what was left out

| Not done | Why |
| --- | --- |
| branches whose span crosses `.align` | non-linear padding may oscillate; refused outright |
| iterating to a fixed point | the decision is monotone (C4 upper bound); two pass-1 rounds suffice and more rounds only cost time |
| introducing 16-bit `CBZ` | that is `-fopt-cbz`'s job and already landed in 0.9.1 |
| a third pass verifying layout against emission | `emit_b16_a()`'s range check *is* that verification (hard error, never silent) |

The cost: **one extra pass-1 round whenever the flag is on**. On the HAL corpus
that round costs the same order as the regular pass 1 and was not timed
separately; what it buys is 2.94% of code size.