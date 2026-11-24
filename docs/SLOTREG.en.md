# `-fopt-slotreg`: deleting redundant frame accesses

English | [中文](SLOTREG.md)

> In one line: `-fopt-slotreg` deletes two shapes of frame access from a
> function's emitted text -- a reload where `r0` already holds the slot, and a
> dead store that is never observed. It **only deletes lines, never inserts
> any**, so the correctness argument needs no liveness analysis, only "the
> deletion does not change meaning". On the whole HAL corpus it saves
> **64 instructions (-0.34%)**, of which `LDR -35` and `STR -29`, with no other
> mnemonic moving by one.
>
> **Verdict: by the pre-registered kill line in `docs/SLOT_REGISTERS.md` §5
> (total drop < 0.5% means archive the line), this line is archived.** The code
> stays behind a default-off flag; the reasoning is in §9.

---

## 1 Why this exists, and how it differs from `-fopt-regalloc`

`docs/SLOT_REGISTERS.md` is the pre-registration for this line. It froze the S2
shadow-slot-register model first (`MOV rC, r0` instead of `LDR r0, [r6, #o]`,
with a block-local `clean`/`dirty` state) and only then wrote code. The first
measurement killed that model:

- the default tier of the existing `-fopt-regalloc` family selects **not a
  single slot** on HAL;
- `-fopt-regalloc-near` turns `LDR -73` and `STR -58` into `MOV +131`, with
  **the total count unchanged**.

That is, "replace `LDR` with `MOV`" is a 1-for-1 substitution: it saves memory
latency, **not size**. The goal here is size (beating armcc/gcc `-O2`), so this
pass takes a different road:

> **Do not replace. Only delete.**

A frame access is redundant in exactly two cases -- the value is already in `r0`
(reload), or the value is never read again (dead store). Deleting those needs no
new register and pays no `PUSH`/`POP` widening, so there is no
"widening never paid off, the function got bigger" risk.

## 2 The two rules

A "slot" is a frame offset `off` (`[r6, #off]`). Rules apply **within a block**.

### 2.1 R1: delete the redundant reload

> `LDR r0, [r6, #off]` where `r0` is already known to hold that slot's value
> within this block ⇒ delete.

"Already holds" is known only on one path: the block just executed
`STR r0, [r6, #off]` (or `LDR r0, [r6, #off]`) on the same slot with no
instruction writing `r0` in between.

### 2.2 R2: delete the dead store

> `STR r0, [r6, #off]` satisfying either condition ⇒ delete:
> - **(a)** the slot has `reads == 0` in the whole function and its address has
>   not escaped (`!indirect`);
> - **(b)** a later `STR r0` to the same slot exists in this block with no read
>   in between.

(a) is "written and never looked at", (b) is "overwritten by the next store".

### 2.3 Why no liveness analysis

R1 removes a `LDR` because at that exact moment `r0` already holds the same
value -- a block-local fact. R2(b) removes a store because a later store in the
same block overwrites it, and a block has one entry, so the later store happens
on every path. R2(a) needs a **whole-function** read count of zero, which is
stronger than liveness and easier to prove -- the hard part is not reading the
code but making sure no indirect read is missed (§3).

## 3 The safety argument: delete-only plus function-level abstention

The structural guarantee is that **the output is a subsequence of the input**:
every deletion merely marks a line as dropped, and the rebuild copies every
other line verbatim -- **not one line is newly written**. The gate asserts this
directly (`is_subsequence`).

The remaining risk is entirely "could anything read this slot that the text
layer cannot see". Three gates handle it:

1. **Slot shape test.** A slot is modelled only if *every* occurrence is exactly
   `LDR r0, [r6, #off]` or `STR r0, [r6, #off]`. Anything else -- `LDRB`/`STRH`,
   `ADD rX, r6, #off` (taking the address), `[r6, rX]` indexed, write-back `!`,
   64-bit halves, a non-decimal `off` -- makes the **whole function** abstain
   (`sr_scan_line` returns 5).
2. **Address escape point.** As soon as a line like `ADD rX, r6, #off` computes
   an address pointing at frame offset `>= off`, every slot with `off >= that`
   is marked `indirect`, **and so is every slot created afterwards**. An
   `indirect` slot may not be deleted by R2(a) -- the address can flow into a
   call such as `memcpy`, and from the text layer there is no way to enumerate
   which slots it writes (this was this round's first miscompile, §5).
3. **volatile.** `IR_AUX_VOLATILE` on `IR_PUSH_VAR` / `IR_STORE` /
   `IR_PUSH_ADDR` is carried into the pass (`ark_slotreg_function(...,
   IrFunc *f, ...)`); a marked slot never has its state cleared and never has a
   store deleted.

**No spill, no `r8`-`r11`.** The pass introduces no register at all: frame
layout, `PUSH`/`POP` and offsets stay untouched. That makes "only ever smaller"
a structural property instead of a cost trade-off to be verified.

## 4 Block boundaries

A block ends (state cleared, `pending` kept where noted) at:

- labels (`.L...:` / a function name);
- `B` family, `BX`, `BL`, `BLX`, `CBZ`/`CBNZ`, conditional branches, `IT`;
- `POP` / `PUSH` / `LDM*` / `STM*`;
- any instruction writing `r0`, and any unmodellable reference to `r6`.

`DMB`/`DSB`/`ISB`/`SEV`/`WFE`/`WFI` are **not** boundaries -- they neither write
`r0` nor touch the frame, and treating them as boundaries would drop
opportunities for nothing (the corpus has 139 `DMB`).

A function without `MOV r6, sp` (`__naked`, frameless) abstains entirely: no
frame means no `[r6, #off]` premise.

## 5 The three miscompiles found and fixed this round

The first version (with R2(a) not checking `indirect`) reached -340 (-1.82%) on
the HAL corpus, but `tests/arm_exec` went from 0 failures to 5. Three causes:

1. **Struct conditional expression: `c = k ? a : b`** (`struct_cond`, 40 ≠ 46).
   The compiler first computes the addresses of `a` and `b` with
   `ADD r0, r6, #0`, then copies with `BL __aeabi_memcpy`. Two
   `STR r0, [r6, #4]` (for `c.y`) and two `STR r0, [r6, #12]` have "no `LDR r0`
   reading these slots anywhere in the function" in the text, so R2(a) deleted
   them -- the real reads are inside `memcpy`, invisible to the text layer.
   **Fix**: the escape point of §3 item 2. The cost is -340 → -64.
   This is the exact price of "rather delete less than delete wrongly":
   0.34% instead of 1.82%, and the safe version charges only the former.
2. **`t==3` lines did not check that `r0` was written** (`shift64` 10 ≠ 50,
   `abi_stack_args` 1 ≠ 50). `LDR r0, [r6, #96]` is a legal frame read but fell
   into the "other reference containing `r6, #n`" branch; it replaced `r0` with
   another slot's value while `valid[0]` stayed true, so the later
   `LDR r0, [r6, #0]` was deleted by R1. **Fix**: any frame reference with `r0`
   as destination clears all `valid` state.
3. **The `STR` branch did not clear other slots' `valid`**: after
   `STR r0, [r6, #16]`, `r0` holds slot 16's value and cannot also be slot 0's.
   **Fix**: `for (k) valid[k] = 0;` before `valid[s] = 1;`.

After all three, `run_arm_exec.py --extra=-fopt-slotreg` is **0 failures (41
cases)**. Each got a gate fixture or an assertion (§8).

## 6 Measurements (whole HAL corpus, 95 TUs, Cortex-M4, `-O2 --reloc-data`)

Baseline = the twelve 0.9.1 switches + `-fopt-cmat` (P16, 18,729).

| Build | Instructions | Change |
| --- | ---: | ---: |
| Baseline (twelve switches + cmat) | 18,729 | — |
| + `-fopt-slotreg` | **18,665** | **-64 (-0.34%)** |

Mnemonic account (line count over the same `.s` files):

| Mnemonic | Baseline | + slotreg | Delta |
| --- | ---: | ---: | ---: |
| `LDR` | 2,443 | 2,408 | **-35** |
| `STR` | 1,148 | 1,119 | **-29** |
| everything else | 15,138 | 15,138 | 0 |

Per-TU result: **not one of the 95 TUs grew**, **85 TUs are byte-identical**,
and the other 10 each lost 1-17 instructions. "None grew" is the measured
confirmation of the delete-only guarantee, not a coincidence.

## 7 Implementation

`src/backend/arm/backend_arm.c`, one `#if ARKCC_FEATURE_OPT_SLOTREG` block,
scheduled **before** `#if ARKCC_FEATURE_OPT_CMAT` -- the store is deleted first,
and the constant that fed it is then seen as a dead write by cmat's M3, so the
two compose in one build instead of getting in each other's way:

| Function | Purpose |
| --- | --- |
| `sr_pre8` | prefix compare (tells `LDR`/`STR` from `LDRB`/`LDRSH`) |
| `sr_scan_line` | classify a line: 0 no `r6` / 1 `LDR r0` / 2 `STR r0` / 3 other `r6` reference with `#off` / 4 `MOV r6, sp` / 5 unmodellable |
| `sr_writes_r0` | does the line write `r0` |
| `sr_barrier` | does the line end the block |
| `sr_slot` | find or create a slot (new slots inherit `indirect` when `off >= sr_esc_lo`) |
| `ark_slotreg_function` | the whole pass: two passes (pass 1 builds the slot table and read counts, pass 2 decides line by line) then rebuild |

Static tables: `SR_MAX_SLOTS 128`, `SR_MAX_LINES 3000`,
`SrSlot{off, reads, taint, indirect}`. `-fopt-slotreg` is **off** by default;
under `ARKCC_PROFILE_STM32_MIN` the macro is 0, code and static tables stay out
of the image, and a cropped build rejects the flag with `C3900U` plus the macro
name.

## 8 Gates (`make test-slotreg`)

`tests/run_slotreg_tests.py`, seven groups:

1. **OFF IS OFF**: `-O2` and `-O2 -fno-opt-slotreg` are byte-identical
   (1200/1200 bytes);
2. **Only ever smaller** (per fixture): every removed line is
   `LDR`/`STR r0, [r6, #n]`; the output is a subsequence of the input; the image
   never grows;
3. **R1 fires**: `sr_pick` (a spilled parameter reloaded at once) 21 → 20;
4. **R2 fires**: `sr_dead` (written, never read) 9 → 7;
5. **No over-deletion**: `sr_esc` (frame address escapes into `memcpy`) and
   `sr_vol` (volatile) are **byte-identical**; in `sr_bl` no `LDR` is folded
   across a call;
6. **Same answers**: seven fixtures × three arms (off / on / alone) return the
   Python answers in unicorn;
7. **Cropped build** rejects the flag with `C3900U` plus the macro name, and
   still compiles without the flag.

On top of that, `tests/arm_exec/run_arm_exec.py --extra=-fopt-slotreg` runs the
whole execution-level comparison (function pointers, 64-bit, soft float, atomics,
TLS, setjmp, ABI stack arguments, struct conditional expressions... 41 cases) on
a slotreg-enabled build: **0 failures**. `--selfcheck` confirms the gate itself
turns red.

## 9 Verdict: archived

`docs/SLOT_REGISTERS.md` §5 froze four kill conditions; the first is:

> Total instruction count over the corpus drops less than 0.5% (i.e. < 95).

The measured -64 < 95, so **the line is archived per its own
pre-registration**. This is not "the work failed"; it is the pre-registration
doing its job: "how much counts as success" was nailed down before the first
line of code was written, the measurement fell short, and there is no chasing
the number by piling on rules.

**Why not dig further.** The -340 tier already proved that more deletions exist,
but every one of them rests on indirect reads and writes the text layer cannot
see (§5 item 1). The only way to push this line to 1.8% is to let the text layer
*guess* which slots `memcpy` writes -- exactly the opposite of "rather report an
error than give a wrong answer". **The real headroom is not in the text layer**:
the remaining 3,500-odd frame accesses each do something useful, and making them
disappear requires computing directly in registers, i.e. real operand
allocation (`docs/OPTIMIZER_PLAN.md` P12, slice S3) -- a different model, not
more rules.

**Why the code stays in the tree.** `-fopt-slotreg` is off by default, byte-zero
when off (§8 group 1), semantics-preserving on 41 execution-level cases (§8
group 6), and grows no TU out of 95 (§6). It is a **proven-safe -0.34%**, and
there is precedent: `-fopt-regalloc-near` also ships with zero measured gain.
Builds that need the smallest image can turn it on; everyone else pays nothing.

**Lesson for the next line.** The corpus shape census must be finished before
writing code (P16's lesson), and "headroom" must be estimated as "how much can
be safely deleted" rather than "how large it looks": frame accesses are 18.8%,
but only 0.34% can be deleted safely.

## 10 Revision (2026-11-24): the `escape` / `wide` miscompile and two blind spots

Re-running the gate on the nineteen-switch set exposed a **wrong answer** in the
`escape` fixture (`off=16 on=8 alone=16`). Two blind spots were found and fixed,
both the same root: **the pass only knows frame accesses based on `r6`, but the
frame base can be copied into another register.**

1. **Frame-base alias (a real miscompile).** Inside `sr_sum(struct srP p)` the
   emitter produces `MOV r5, r6` followed by `LDR r5, [r5, r7, LSL #2]`: a
   by-value struct parameter is **indexed from a copied base**. The pass searches
   for `"r6, "`, which `MOV r5, r6` does not contain => the line looks
   frame-free => slot #0 is judged "never loaded in this function" =>
   `STR r0, [r6, #0]` is deleted as a dead store => the answer goes from 16 to 8.
2. **Frame address taken into a register (a blind spot).** In `main`, `MOV r0, r6`
   hands the address of `a` to `sr_esc`; again no `"r6, "`, so neither `taint`
   nor `sr_esc_lo` is raised, and both stores to `a`'s slots are deleted.

**Fix** (`sr_count_r6` plus two special cases): count how many `r6` **tokens** a
line has. Zero => not a frame line; two or more => abandon (`ADD r6, r6, #4`);
exactly one but not in the `[r6, #n]` shape (`MOV r5, r6`, `MOV r0, r6`) =>
**abandon the whole function**. `MOV r6, sp` and the epilogue `MOV sp, r6` are
explicitly classified as frame setup/teardown, not aliases.

**Cost**: under the twelve-switch set, 14,646 -> **14,583 (-63 instructions)**
against the old -64 => the wider abstention costs **one instruction**;
`smaller TU 10 / identical 85` unchanged. Under nineteen switches, 12,345 ->
12,312 (-33). 95 TUs 0 err; `tests/arm_exec` 0 failure.

**One over-strict assertion fixed at the same time**: the `wide` fixture's
`LDR r1, [r6, #20]` is not deleted by this pass but by the **second `-fopt-live`
sweep** that runs after it and sees r1 already holds the value. The old
assertion mixed deletions from two passes. The comparison arms now disable
`-fopt-live` (`NC = ['-fno-opt-cmat', '-fno-opt-live']`), so "every removed line
is `LDR/STR r0, [r6, #n]`" really tests only this pass. **Fixing an assertion is
not loosening it**: establish who deleted the lines before touching the text, or
another pass's legitimate optimisation gets recorded as this pass's overreach.

## 11 Revision (2026-11-24): an out-of-frame load must invalidate the slot cache

Under 23 switches `abi_stack_args` returned 1 instead of 50; the minimal set was
`-fopt-pair -fopt-slotreg -fopt-vstack`.

**Root cause.** Pass 1 correctly classifies `LDR r0, [r6, #56]` as a frame load
(`off = 56 >= base`: this is an *incoming stack argument*, not part of this function's
frame), but the caller only handles the `off < base` branch, so `sr_lk[line]` stays 0
("unclassified") and `valid[slot]` is never invalidated. The next `LDR r0, [r6, #0]` is
then deleted as "slot 0 is already in this register", and `a` is replaced by an unrelated
value.

**Fix.** A load with `off >= base` also sets `sr_lk[nlines] = 6` ("this pass does not
understand this line; do not trust the cache"), for `t == 1` (a real load) only — `t == 2`
(stores) need no cache invalidation.

**Why not bail the whole function.** An out-of-frame load exists in every function with
stack arguments; bailing would disable slotreg entirely on any `f(a,b,c,d,e)`-shaped
function.

**Cost.** One extra invalidation; the load it saves from deletion had to stay anyway, so
no size regression.

**Gates.** `abi_stack_args` with three flags = 50; under 23 switches
`struct_narrow_copy` 84 / `struct_narrow_call_assign` 61 / `sret_live_results` 50;
`tests/arm_exec` 40/40; `make test-slotreg` fully green.
