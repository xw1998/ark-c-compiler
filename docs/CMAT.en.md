# `-fopt-cmat`: cleaning up duplicated constant materialisation

English | [中文](CMAT.md)

> In one line: the value-stack backend materialises the same constant twice -- it
> copies it into a scratch register, and the consumer folds it back into the
> addressing mode -- it also writes the scratch register twice in a row, lets a
> constant walk through a shift or an extend, and still emits `CMP` + branch for
> a `do {} while (0U)` whose condition is known; and the value stack still
> pushes a base, leaves only dead writes in between, and pops it straight back.
> `-fopt-cmat` removes those seven shapes from a function's emitted text: **993
> instructions fewer (-6.23%)** on the whole HAL corpus, `LSL` 509 -> 163,
> `UXTB` 218 -> 61, 116 conditional branches gone, and 67 push/pop pairs gone.

---

## 1. Why this exists

The 0.9.1 text passes already removed a lot of moving around, but the value
stack leaves one family nobody handled:

```asm
    MOV   r7, #0
    MOV   r1, r7                 ; copy a known constant into the index register
    LDR   r7, [r5, r1, LSL #2]   ; the hardware can encode [r5, #0] directly
```

```asm
    MOV   r7, #0          ; written once
    MOV   r1, r7          ; r7 overwritten again before any read
    ...
```

These shapes need no liveness analysis to be proved safe -- either the address
and the result are identical, or the value is provably overwritten before any
read inside the same block. That is the whole domain of this pass.

## 2. The seven rules

### 2.1 M1: a copy of a known constant becomes an immediate

> `MOV rD, rS` where `rS` is known in this block to hold `k`, `0 <= k <= 255`
> becomes `MOV rD, #k`.

On its own this saves nothing (still one instruction). It exists so that M2 and
M3 can see through the copy: once it is an immediate, the register it copied
from is no longer read, and M3 may delete the materialisation that produced it.

The 255 limit is simply the form the emitter itself prints for small constants;
anything larger needs `MOVW` and would get longer.

### 2.2 M2: a known index is folded into the addressing mode

> `LDR/STR/LDRB/LDRH/STRB/STRH rT, [rB, rI(, LSL #s)]` where `rI` is known in
> this block to hold `k`, the byte offset `k << s` fits in 0..4095, and
> `rI != rB`, becomes `[rB, #k << s]`.

Same address, same flags, one operand (and one register read) fewer.

4095 is the Thumb-2 immediate-offset limit. `rI == rB` is excluded. Write-back and
post-indexed forms are outside the accepted shapes.

### 2.3 M3: a flag-neutral write overwritten before any read is dead

> A flag-neutral write (`MOV`, a `MOVW`+`MOVT` pair on the same register, a
> three-operand `LSL LSR ASR ROR`, `MVN`, `UXT*`, `SXT*`, `CLZ`, `REV*`) whose
> destination is written again later in the same block, before anything reads
> it, is dropped.

"Written again inside the block" is exactly why no liveness is needed: a block
has one entry, so the later write happens on every path through it, and no read
can observe the old value.

**A `MOVW`+`MOVT` pair is one unit.** Dropping half of it leaves a different
value in the register, so the implementation fuses the pair into a single unit
(`nlines == 2`) and the rebuild copies or drops it whole.

### 2.4 M4: a constant through a three-operand shift

> `LSL/LSR/ASR rD, rS, #n` where `rS` is known inside the block: the result is
> computed and, if it lands in 0..255, the line becomes `MOV rD, #k`.  Otherwise
> the constant state is still recorded and the line is left alone.

The safety comes from the encoding: **the three-operand shift does not set the
flags** (the old two-operand `LSL rD, rS` form does), so rewriting it as
`MOV rD, #k` changes neither the value nor the flags.

Only 0..255 is rewritten because that is the shape the emitter uses for small
constants; above that a `MOVW` would be needed and the line would get longer.
The state is recorded either way, so M2/M3/M6 can still use the value.
`rS == rD` (`LSL r0, r0, #3`) is accepted too: read, then compute.

### 2.5 M5: a constant through an extend

> `UXTB/UXTH/SXTB/SXTH rD, rS` where `rS` is known: same treatment.

`UXTB` truncation and `SXTB` sign extension are pure arithmetic on a constant
and touch no flag.  A result in 0..255 is rewritten; a negative result keeps the
line and drops the constant state, because M2/M6 only accept small non-negative
constants.

### 2.6 M6: a conditional branch after a known `CMP` is decided here

> `CMP rX, #k` followed immediately by a conditional branch (nothing that writes
> the flags in between) where `rX` is known inside the block: the direction is
> computed.  Always taken turns the branch line into `B <target>`; never taken
> drops the line.  **The `CMP` itself is kept.**

Keeping the `CMP` is what makes this safe: every later instruction sees exactly
the N/Z/C/V it would have seen without the pass, so M6 needs no liveness argument
and cannot change any later condition-code evaluation.  The condition is
evaluated the textbook way (a 64-bit subtraction for V, the 32-bit unsigned
difference for N/Z/C) and covers
`BEQ/BNE/BCS/BCC/BMI/BPL/BVS/BVC/BHI/BLS/BGE/BLT/BGT/BLE`.

Rewriting to `B` saves no instruction by itself; it wins because `B` encodes
shorter than a conditional branch in Thumb-2.  Dropping a never-taken branch is
a pure win, and the corpus has far more of those (70 vs 46): the
`do { ... } while (0U)` HAL macros expand to `MOV r0, #0 / CMP r0, #0 / BNE`.

### 2.7 M7: the value stack's `PUSH {rX}` / `POP {rX}` pair goes

> A `PUSH {rX}` followed by a `POP {rX}` with **nothing but already-dead units
> in between** loses both lines.

When the value stack stores a value and immediately loads it straight back into
the same register, with no live code left in between, the round trip buys
nothing: `sp` goes down and comes back, net zero, and no observer ever sees the
intermediate stack write.

Three safety points:

- **no live code in between**.  Every unit between the two must already have
  been judged dead by M3, and M3's criterion is "written again later in this
  block with no read in between", so deleting them changes no value;
- **no labels, no calls**.  A label, `BL`/`BLX` and every branch end the search:
  a branch may reach that `POP` with a different value stack, and a call must
  see the stack frame it expects;
- **no register lists**.  Only exactly `PUSH {rN}` / `POP {rN}` with one
  `r0`-`r12` is recognised; `PUSH {r5,r6,r7,lr}` (prologue) and
  `POP {..., pc}` (epilogue) are never touched.

Two supporting extensions to the existing criteria -- M7 is useless without
them, because the writes in the middle stay live-looking:

- **a `POP`/`LDM` is a write**.  `cm_dies_later` used to treat `POP` as the end
  of the block, so "overwritten by `POP {rX}`" was invisible.  Now a `POP`/`LDM`
  that names the register in its list counts as the overwrite, and one that does
  not name it **keeps scanning** (write-back forms such as `LDM rB!, {...}` and
  lists this pass cannot parse are still block ends);
- **a `POP`/`LDM` clears only its own registers**.  Any `POP` used to wipe all
  thirteen known-constant slots, so after `POP {r0}` even `r1`'s value was gone
  and `LDR r0, [r0, r1, LSL #2]` could not fold to `[r0, #0]`.  Now only the
  listed bits are cleared.

That is why M7's gain arrives in two steps: first the dead `MOV`s in the middle
(-93), then the pairs themselves (-203).

## 3. Block boundaries and the read set

A block ends (state is cleared) at:

- a label (`.L...:` / a function name);
- any branch: the `B` family, `BL`, `BX`, `BLX`, `CBZ`/`CBNZ`, the ten conditional forms;
- `IT` -- the instructions under it are conditional;
- `POP` / `LDM*` / `STM*` -- **with one exception**: a `POP`/`LDM` writes only
  the registers its list names, so it clears only those constant slots and every
  other register stays known (section 2.7).  A write-back `LDM rB!, {...}` and a
  list containing `sp`/`lr`/`pc` are still treated as a full block end;
- **any mnemonic that is not on the whitelist** (an unknown instruction may write a
  register or set flags, so it is a boundary by default).

Comments, `.loc`/`.file` directives and blank lines are not boundaries: they have
no register or flag effect.

Mnemonic comparison is **case-insensitive**: the emitter prints `bx`, `rev16`,
`revsh`, `rrx` in lower case, and also prints conditional forms such as `MOVNE`,
`MOVEQ`, `MOVHI`, `MOVLS`, `MOVLT`, `MOVGE`. Conditional forms are not on the
whitelist, so they are boundaries.

### 3.1 The read set: two fatal mistakes that were caught

"Which operands count as reads" is the one real trap in this family. The first
version got it wrong twice, and both were **real miscompiles**:

1. **A two-operand ALU instruction reads its own destination.** `MUL r0, r7` is
   `r0 = r0 * r7`: `r0` is both destination and source. The first version took
   "everything minus the destination" as the read set, so in `MOV r0, r5` +
   `MUL r0, r7` the copy was treated as dead, deleted, and the program read a
   stale `r0`. Fix: the source part is only what follows the first comma, plus
   the destination when `cm_is_rmw()` says the form is a two-operand
   read-modify-write.
2. **The first operand of `STR` is a source.** The first version assumed
   `operands[0]` is always a pure destination, so `STR r0, [r6, #24]` looked like
   a write of `r0` and the `MOV r0, #0` in front of it was deleted -- the store
   wrote garbage. Fix: for `STR` / `STRB` / `STRH` / `CMP` / `CMN` / `TST` /
   `PUSH` / `NOP` the read set scans the **whole** operand string.

The `strfirst` fixture in the gate is the regression guard for the second
mistake: the only consumer of `MOV r5, r0` is `STR r5, [r1]`, so a pass that
treats `STR` as a write deletes the copy and stores something other than 5.

## 4. Refused on purpose

- `ADD` / `SUB` / `AND` / `ORR` / `EOR`: they may set flags, and the corpus is
  full of `ADD rX, rB, #0` used as a copy -- treating it as a copy would change
  the value domain;
- `MUL`: `MULS` sets N/Z;
- write-back / post-indexed addressing;
- register indexes other than a plain `LSL #s` (`LSR`/`ASR`/`ROR` index, `RRX`);
- offsets beyond 4095;
- **two-operand** shifts and extends (`LSL rD, rS` sets N/Z/C, so rewriting it
  would change the flags);
- in M6, anything but an immediately following branch (`pcmp` is cleared by any
  non-`CMP` unit);
- any deletion that would need liveness analysis to prove (end of block, across blocks).

## 5. One rule that did not survive

One more mechanism was tried and deleted besides the pair rule below: handing
"constant producers" to M3 (`cm_cdef`/`cm_canddef`).  Its post-check only looked
for liveness from the fold point, and when a fold does not actually happen
(value > 255 or negative) the fold point itself still reads the source register
and lies outside the scan -- so it would **delete a producer that is still
read**, the one kind of silent wrong answer this pass must never produce.
Removing it costs no benefit: every producer that can set the constant state is
a flag-neutral write, which M3 already covers.

The first draft also had a rule: drop a whole `MOVW`+`MOVT` pair when the
register already held that constant.

Measured on the corpus it fires **zero** times: between two pairs with the same
value there is always a read of the register (which clears the state), and when
there is no such read the first pair was dead for a different reason anyway.
Following "do not keep code that never fires", the rule and its state
(`pknown`/`pval`) were removed and the rules renumbered to M1/M2/M3, with
M4/M5/M6 appended after them rather than reshuffled. It is
recorded here because it is itself a conclusion: **this shape does not occur in
the corpus.**

## 6. Measurements (whole HAL corpus, 95 TUs, Cortex-M4, `-O2 --reloc-data`)

Baseline = the current sixteen 0.9.1 switches
(`vstack addr strength cbz branch imm peep cbranch copyprop live prop deadpush
constcache slotreg coalesce vreg`).  The corpus is assembled per TU with `-S`;
instructions are counted line by line with `^\s+[A-Za-z][A-Za-z0-9.]*\s` (a
`grep` misses a dozen directive-shaped lines per TU, so a script does the count).

| build | instructions | vs baseline |
| --- | ---: | ---: |
| baseline (sixteen switches, `-fno-opt-cmat`) | 15,933 | -- |
| + `-fopt-cmat`, M1/M2/M3 only | 15,613 | **-320** |
| + `-fopt-cmat`, M1-M6 | 15,236 | -697 (-4.37%) |
| + `-fopt-cmat`, all seven rules | **14,940** | **-993 (-6.23%)** |

So M1/M2/M3 account for -320, **M4/M5/M6 for another -377** and **M7 (with the
two criterion extensions) for another -296**.

M7's -296 reconciles line by line (the same two counters over three trees,
subtracted mnemonic by mnemonic):

| item | M1-M6 | seven rules | delta | belongs to |
| --- | ---: | ---: | ---: | --- |
| `PUSH` | 962 | 895 | **-67** | the push/pop pairs M7 drops |
| `POP` | 633 | 566 | **-67** | same |
| `MOV` | 3,733 | 3,594 | -139 | dead writes the new criteria expose |
| `LSL` | 186 | 163 | -23 | same |
| total | 15,236 | 14,940 | **-296** | |

That is **67 pairs (134 lines) plus 162 dead lines in between = 296**, exactly
the measured difference.  The M1-M6 tree still holds 74 sites of the shape
`PUSH {r0}` / `MOV r0, #0` / `MOV r1, #0` / `POP {r0}` /
`LDR r0, [r0, r1, LSL #2]`; 67 of them go.  The remaining seven look the same
but their middle write is still read by a later instruction, so not a single
line of them moves -- that is the price of doing no global liveness analysis,
and the reason the rule is safe.

Mnemonic account (M1-M6, same `.s` files, baseline vs all six rules; the M7
part is the table above):

| mnemonic | baseline | + cmat | delta |
| --- | ---: | ---: | ---: |
| `LSL` | 509 | 186 | **-323** |
| `UXTB` | 218 | 61 | **-157** |
| `BNE` | 516 | 402 | **-114** |
| `MOV` | 3,803 | 3,733 | -70 |
| `LSR` | 125 | 56 | -69 |
| `B` | 771 | 817 | **+46** |
| `MOVW` | 941 | 937 | -4 |
| `MOVT` | 807 | 803 | -4 |
| `BEQ` | 182 | 180 | -2 |
| total | 15,933 | 15,236 | **-697** |

This account reconciles with the rules without a remainder (the table below is
**derived from the mnemonic account above**, not from a second set of counters;
two independent paths give the same numbers):

| rule | hits | reconciliation |
| --- | ---: | --- |
| M4 | **392** | `LSL` -323 plus `LSR` -69, each replaced by one `MOV` |
| M5 | **157** | `UXTB` -157, same (`UXTH`/`SXTB`/`SXTH`: 0 this round) |
| M6t (to `B`) | **46** | `B` +46, no instruction-count change |
| M6d (drop branch) | **70** | conditional branches drop by 116 = 46 (M6t) + 70 (M6d), of which `BNE` -114 and `BEQ` -2 |
| M3 (drop neutral write) | **623** | `MOV` net -70 = +549 (new `MOV`s from M4/M5) - 619 (deleted by M3); plus 4 `MOVW`+`MOVT` pairs (8 lines) => 619 + 4 units = **623** |

Closure check: the 392 + 157 shifts and extends become just as many `MOV`s, so
they net 0; M3 deletes 619 `MOV` lines plus 8 `MOVW`/`MOVT` lines, and M6d
deletes 70 branch lines => -619 - 8 - 70 = **-697**, exactly the measured
difference.

At 4 bytes per Thumb-2 instruction the code is about **2,788 bytes** smaller
with M1-M6 and about **3,972 bytes** smaller with all seven rules.
(This is derived, not measured: the corpus is not linked into an image.)

## 7. Where it lives

`src/backend/arm/backend_arm.c`, one `#if ARKCC_FEATURE_OPT_CMAT` block placed
right after `-fopt-regalloc` and before `ark_fix_far_offset()`:

| function | role |
| --- | --- |
| `cm_streq` | case-insensitive mnemonic compare |
| `cm_trim` | strip leading blanks and the trailing CR (give up if it does not fit) |
| `cm_split` | split into "mnemonic + rest" |
| `cm_reg` / `cm_imm` | `rN` (0..12) / `#decimal` |
| `cm_first_reg` | `rA, rest` |
| `cm_write_first` | is the first operand a pure destination |
| `cm_neutral` | is the mnemonic a flag-neutral write |
| `cm_boundary` | does it end the block |
| `cm_is_rmw` | two-operand read-modify-write (`MUL rD, rS`, `LSL rD, rS`, ...) |
| `cm_uses` | the read set (section 3.1) |
| `cm_mem_idx` | recognise `[rB, rI(, LSL #s)]` |
| `cm_shift3` | recognise a strictly three-operand `LSL/LSR/ASR rD, rS, #n` (the two-operand form sets flags, so it is refused) |
| `cm_extend2` | recognise `UXTB/UXTH/SXTB/SXTH rD, rS` |
| `cm_cond_true` | condition evaluation on frozen operands (1 taken / 0 not / -1 unknown) |
| `cm_dies_later` | "is this register written before anything reads it, from line j to the block end" -- M3's test (a `POP`/`LDM` counts as a write when its list names the register, and the scan keeps going when it does not) |
| `cm_list_mask` | `{r4,r5,r6}` -> register mask; lists naming `lr`/`pc` or a write-back base are refused (returns 0) |
| `cm_one_reg` | `{rN}` naming exactly one register in 0..12 |
| `ark_cmat_function` | the pass: line table -> unit table (fusing MOVW/MOVT) -> walk M1/M2/M4/M5/M6 -> M3 -> M7 -> rebuild |

`-fopt-cmat` is **off by default**. Under `ARKCC_PROFILE_STM32_MIN` the macro is
0, so neither the code nor the static tables are in the image, and a cropped
build refuses the flag (`C3900U`) while naming the macro. The static tables are
about 300 KB of BSS and exist only in host builds.

## 8. Gate (`make test-cmat`)

`tests/run_cmat_tests.py`, thirty-seven checks:

1. **OFF IS OFF**: the default build and `-fno-opt-cmat` are byte-identical;
2. **M2 fires**: the `LSL #2]` shape goes to zero, `[rB, #off]` becomes more
   frequent, the image never grows;
3. **M1 fires**: `MOV rX, rY` drops while `MOV r1, #0` appears;
4. **M3 fires**: the neutral write overwritten before any read disappears and
   the instruction count drops by at least two;
5. **anti-over-deletion**: `strfirst` (whose copy is read only by `STR`) and
   `big` (`MOVW`/`MOVT` pair) are **byte-identical** in both arms;
6. **the answers stay the same**: three fixtures x three arms (off / on / alone)
   return the Python answer on the emulator;
7. **labels survive**;
8. **a cropped build** refuses the flag by name (`C3900U` + macro) and still
   compiles without it;
9. **M4/M5/M6 fire**: `LSL r0, r0, #3`, `LSR r0, r0, #1` and `ASR r0, r0, #2`
   disappear with the flag on and the folded `MOV r0, #16` / `MOV r0, #50`
   carry the right values; `UXTB r0, r0` drops by one and leaves
   `MOV r0, #128`; the `do {} while (0U)` `BNE .L_cm_clk_0` line disappears
   while every `CMP r0, #0` stays (proof the flags did not move); the
   instruction count goes 149 -> 139.  The anti-over-fold half: `200 << 5`
   (6400) and `200 << 1` (400) both overflow the 8-bit immediate and keep the
   same line count in both arms, while the `UXTB` in the same file still folds
   (proof the file really is processed).
10. **M7 fires, on a real driver**: the fixture is `stm32f4xx_hal_dma.c` from
    the benchmark corpus.  The shape is hard to build in a small synthetic
    fixture (it needs "base already on the value stack", "the index folds to a
    constant" and "a later instruction rewrites the index register" at the same
    time) but appears 52 times in that driver.  Assertions: the
    `PUSH {rX}` / dead writes / `POP {rX}` / indexed-load groups go **52 -> 0**,
    the instruction count 2,351 -> 2,035, **multi-register `PUSH` (prologues)
    15 -> 15**, **epilogue `POP {..., pc}` 32 -> 32**, labels 264/264 and
    functions 15/15 all unchanged, and 81 single-register `PUSH` lines still
    survive (proof it is not deleting `PUSH` wholesale).

As a stronger layer, `tests/arm_exec/run_arm_exec.py --extra=-fopt-cmat` ran the
whole execution suite (function pointers, 64-bit, soft-float, atomics, TLS,
setjmp, ...) on a build with cmat enabled: **0 failures**.