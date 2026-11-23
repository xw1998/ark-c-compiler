# Slot-level register promotion (S2 pre-registration)

> Status: **pre-registered, not implemented**. This document freezes *what* to build,
> *what counts as success* and *what counts as failure* before any code is written.
> Every number below comes from a measurement on this repository's own corpus, and the
> command and the counting rule are stated in each section.

## 0 What this document answers

P12 in `docs/OPTIMIZER_PLAN.md` names S2 as "intra-function virtual-register colouring" but never
pinned it down. After P7 through P14 took the HAL corpus from 47,885 instructions down to 19,066,
the remaining questions are: **where is the remaining room, how is it measured, and when is this
line done**. Without that written down first, the next pass becomes "another 0.1%".

Four questions are answered here:

1. how much frame traffic is left and what shapes it takes (section 1);
2. why one more text rule cannot help (section 2);
3. exactly what the first verifiable slice of S2 is, and why it is correct (section 3);
4. gates, falsification conditions, trimming and rollback (sections 4-6).

## 1 Current measurements

Scope: the 95 translation units under `examples/ark_test` (`Core/Src/*.c` plus
`Drivers/STM32F4xx_HAL_Driver/Src/*.c`), compiled with
`-target arm -S -O2 -mcpu Cortex-M4 -D STM32F401xE -D USE_HAL_DRIVER --reloc-data` plus the
twelve existing switches (vstack / addr / strength / cbz / branch / imm / peep / cbranch /
copyprop / live / prop / deadpush). Only instruction lines are counted, never directives or labels.

| Item | Value | Share |
| --- | --- | --- |
| total instructions | 19,066 | 100% |
| `LDR` (almost all `LDR r0, [r6, #off]`) | 2,443 | 12.8% |
| `STR` (almost all `STR r0, [r6, #off]`) | 1,148 | 6.0% |
| frame traffic together | 3,591 | **18.8%** |
| `MOV` | 3,888 | 20.4% |
| ... of which `MOV rD, rS` | 1,615 | |
| ... of which `MOV rD, #0` | 967 | |
| ... of which `MOV sp, rS` / `MOV rD, sp` | 302 / 215 | |
| adjacent `MOV`-`MOV` pairs | 943 | |

Opportunity shapes (same scope, counted by script):

| Shape | Count | Note |
| --- | --- | --- |
| same frame slot loaded twice in one straight-line block, no `STR`/clobber between | 56 | only 0.3% |
| `STR -> LDR` round trip on the same slot inside one block | 203 | distances 1:51, 2:25, 3:44, 4:14, 5:6 |
| dead frame read (the destination is never read afterwards) | **0** | the "drop dead `LDR`" direction has no yield and is ruled out |

The existing `-fopt-regalloc` (a text pass that *renames* a slot into r8-r11) on the same corpus:

| Mode | Result |
| --- | --- |
| default (far slots only: byte savings must pay for the wider PUSH/POP) | 19,066 -> **19,066**, not a single slot selected |
| `-fopt-regalloc-near` (near slots too) | 19,066 -> **19,066**: `LDR -73`, `STR -58`, `MOV +131` |

That last row is the most important sentence of this section: **the accesses changed shape but the
instruction count did not move at all**, because each replaced `LDR r0,[r6,#o]` became
`MOV r0, rN` -- still one instruction. What was saved is memory latency, not size.

## 2 Why one more text rule cannot help

Putting the two tables together:

- the part that is shape-exact enough for a text rule (56 repeated loads + 203 round trips + 0 dead
  reads) is capped at roughly **0.7%**, and each of those 203 places saves at most one instruction,
  only when no writable call and no label sits in between;
- the remaining ~3,500 frame accesses all *do* something: they move a value from here to there.
  They exist because every intermediate in this backend has to pass through `r0`, the single
  accumulator (`LDR r0,[r6,o]` -> compute -> `STR r0,[r6,k]`). Removing them requires the operation
  to happen **on r8-r11 directly**, which is operand allocation.

So S2 is not "one more rule"; it is a different model. Section 3 describes the first falsifiable
slice of that model.

## 3 Target model: shadow slot registers (slice S2a)

### 3.1 Selection (which slots may be promoted)

Reuse the taint proof that `ark_regalloc_function()` already implements and that
`tests/run_regalloc_tests.py` already covers: a slot at offset `o` may be promoted only when **every**
mention of it in the whole function is exactly `LDR r0, [r6, #o]` or `STR r0, [r6, #o]`. Any other
shape (`LDRB`, `STRH`, `ADD rX, r6, #o`, a 64-bit half, a struct field, a volatile access) keeps the
slot in memory. What that rule buys is the statement this whole design rests on: **the slot's address
never escapes, so only these instructions can read or write it.**

### 3.2 Registers

`r8-r11`, for the same reasons as the existing pass: the backend never names them and AAPCS makes
them callee-saved, so `__aeabi_*` helpers and user code preserve them. The moment one slot in a
function is promoted, the prologue/epilogue `PUSH`/`POP` must widen; `ra_` already implements that,
including offset shifting and keeping the saved block 8-byte aligned, and it is covered by gates.
Hence **the widening cost is paid once per function, no matter how many slots are promoted.**

### 3.3 Cache state machine (the difference from the existing regalloc)

`-fopt-regalloc` treats the register as the slot's home: every `STR` writes it, every `LDR` reads it,
regardless of anything else. S2a wants the same thing *per block*, with an explicit state:

| State | Meaning | on `STR r0,[r6,#o]` | on `LDR r0,[r6,#o]` | at block end |
| --- | --- | --- | --- | --- |
| `clean` | memory and register agree | `MOV rC,r0` -> `dirty` | `MOV r0,rC` | nothing |
| `dirty` | memory holds a stale value | `MOV rC,r0` | `MOV r0,rC` | `STR rC,[r6,#o]` -> `clean` |

A block is a maximal run of lines with no label in between; every branch (`B`/`Bcc`/`BL`) *ends* the
current block, because all exits out of it must see consistent memory. Registers stay valid across
`BL` (callee-saved), so a call itself needs no write-back -- as long as the callee cannot obtain the
slot's address, which selection (3.1) guarantees.

### 3.4 Cost model (count before rewriting)

For one block and one slot let `R` be the replaced `LDR` count, `S` the replaced `STR` count, `F` the
number of fills (the block's first access is an `LDR` and there are more accesses afterwards) and `W`
the write-backs (whether the block ends `dirty`). The instruction delta is `(F + W) - (R + S)`.
**Apply only when it is negative**: `F + W < R + S`.

That gate defines the shape this slice really eats: "one write, several reads inside a block" and
"several reads/writes of one slot inside a block", never "one write, one read" (there `F=1, W=1`,
a draw, so nothing happens).

The wider `PUSH`/`POP` costs +2 bytes each, once. Following the existing regalloc accounting, a
promoted slot must therefore save at least 2 instructions (4 bytes) inside the function, so there is
an extra requirement: **the slot's net saving in this function is >= 2 instructions.**

### 3.5 Explicit non-goals

- live values across blocks (both sides of a label): no caching, block boundaries force consistency;
- 64-bit, `complex`, struct, volatile slots and any slot whose address escapes: never promoted;
- spilling (all of r8-r11 taken): the fifth slot is not invented; the rest of the function's slots are
  simply abandoned (**no spill**).

## 4 Gates (frozen; unchanged once implementation starts)

`tests/run_slotreg_tests.py`, `make test-slotreg`:

1. **OFF IS OFF**: without the flag the 95-TU corpus is byte-identical to the current HEAD;
2. **off by default**: `-O2` without the flag produces a byte-identical image;
3. **never grows**: per TU `on <= off`, and the corpus total strictly decreases;
4. **block-consistency assertion**: for every promoted slot, a structural check on the function text --
   every block that exits `dirty` must end with a `STR rC,[r6,#o]`;
5. **semantics**: `tests/arm_exec` on the whole corpus, off vs on, same value (39 cases), plus at least
   three new fixtures: a slot accumulated in a loop, the same slot written by both `if`/`else` arms, and
   a block containing a `BL`;
6. **trimming**: `ARKCC_FEATURE_OPT_SLOTREG` (STM32_MIN 0); a trimmed build refuses the flag with
   `C3900U`, still compiles without it, and the stage row stays with `built_in=0` and a null pointer;
7. **no cross-backend drift**: the pass is ARM-text only; x86_64 and riscv32 are untouched and
   `make test` stays green.

## 5 Falsification conditions (written down so the line can be closed honestly)

If any of the following holds, the line is **closed** and gets no further investment:

- the corpus total drops by less than 0.5% (i.e. fewer than 95 instructions);
- any TU grows (the wider `PUSH` was not paid for);
- exceeding 0.5% would require spilling (that would mean the gain comes from a spill policy, not from
  the block-caching mechanism);
- with `-fopt-vstack` already on, the stacked gain is negative (section 6).

## 6 Relation to the existing passes

S2a competes with `-fopt-vstack` for the **same** stack round trips: vstack owns the value stack of
expression evaluation, S2a owns named locals, and in HAL code the two interleave inside one block.
A stacked measurement is therefore mandatory:

- if `vstack + slotreg` gains no more than `vstack` alone (slotreg only re-eats what vstack already
  removed), only vstack stays enabled by default (the "S5: pick one" rule);
- only if the combination is positive and the gains do not overlap may both enter the default set.

This measurement is the first thing done after implementation and its result is written back into this
file and into P15.

## 7 Risk and rollback

- everything lives behind `-fopt-slotreg`, off by default, with the byte-identical `OFF IS OFF` gate
  as the backstop;
- the taint proof, register choice, `PUSH` widening and offset shifting are reused from
  `ark_regalloc_function()`, not rewritten;
- if any gate in section 4 turns red, the first step is turning the flag off (zero cost), the second
  is reverting code;
- after implementation this file may only gain a "measurement" section and a "verdict" section; the
  gate text in sections 4 and 5 may not be edited.

## 8 Measurement (2026-11-23, before S2a)

Section 1 bounded the text-layer room on top of the twelve switches at **<=0.7%** (framed as frame
traffic, 56 repeated loads inside a block, 203 `STR -> LDR` round trips on the same slot, 0 dead frame
reads). Before building S2a the whole corpus was scanned for the shape distribution, and that estimate
turns out to **cover only one family**:

- repeated loads and same-slot round trips really are at the 0.7% level;
- but "duplicated constant materialisation" -- the value stack copying a constant into a scratch
  register and the consumer folding the index back into the addressing mode, plus the scratch
  register being written twice in a row -- is **1.77% (337 instructions)** on top of the twelve
  switches, an order of magnitude more than the pre-registered room.

The order therefore changed: `-fopt-cmat` goes first (P16, landed: 19,066 -> 18,729, only `MOV`
moves), and **S2a is deferred until after cmat**, with its stacked-measurement baseline now
"twelve switches + `-fopt-cmat`".

The seven gates in section 4 and the four falsifiers in section 5 are **unchanged word for word**;
only the precondition and the baseline moved. P15 now points at P16.

## 9 Design revision and measurement (2026-11-23, after S2a was implemented)

Per section 7 this section only **appends**; the seven gates in section 4 and the four falsifiers
in section 5 are unchanged.

### 9.1 What the measurements overturned: the shadow-register model of section 3

Section 3 proposed `MOV rC, r0` in place of `LDR r0, [r6, #o]`. That substitution is **1-for-1**:
`-fopt-regalloc-near` on the same corpus measures `LDR -73`, `STR -58`, `MOV +131` and
**19,066 -> 19,066 instructions**, not one fewer. Implementing section 3 as written could only
save memory latency, not size, which contradicts the goal set in section 1.

**Revision**: S2a became **delete-only, never insert** -- no register substitution, no `r8`-`r11`,
no frame-layout change; only two locally provable kinds of frame access are deleted from the
emitted text:

- **R1**: `LDR r0, [r6, #o]` where the block already knows `r0` holds that slot ⇒ delete;
- **R2(a)**: `STR r0, [r6, #o]` where the slot has `reads == 0` in the whole function and its
  **address has not escaped** ⇒ delete;
- **R2(b)**: a later `STR r0` to the same slot in the same block with no read in between ⇒ delete
  the earlier one.

### 9.2 Revision to section 3.1: the address escape point

Section 3.1 only required "every occurrence of the slot is `LDR r0`/`STR r0`". Measurement showed
that is not enough: `ADD rX, r6, #o` **computes an address** (it does not access memory), and that
address can flow into `memcpy`, after which any slot at or above it may be written indirectly --
something the text layer cannot enumerate. So: as soon as such an address-computing line appears,
every slot with `off >= that offset` is marked `indirect` (new slots inherit it), and an `indirect`
slot may not be deleted by R2(a).

The price of this revision is measured: without it, -340 instructions (-1.82%) and 5 `arm_exec`
semantic failures; with it, -64 (-0.34%) and 0 failures.

### 9.3 Where the seven gates of section 4 landed

`tests/run_slotreg_tests.py` (`make test-slotreg`) covers section 4 items 1, 2, 3 and 6 directly
(OFF IS OFF / off by default / only ever smaller / cropping). Item 4 (block consistency) became two
stronger structural assertions -- "every deleted line is `LDR`/`STR r0, [r6, #n]`" and "the output is
a subsequence of the input" -- because this implementation inserts no line at all, so both are
stricter than the original gate. Item 5 is covered by seven fixtures × three arms agreeing in
unicorn, and outside that by `tests/arm_exec/run_arm_exec.py --extra=-fopt-slotreg` running the full
41-case execution suite. Item 7 (no drift in other backends) is covered by the x86_64 and riscv32
parts of `make test`; the pass lives only in the ARM text layer.

### 9.4 Measurement (baseline = twelve switches + `-fopt-cmat`, 18,729)

| Build | Instructions | Change |
| --- | ---: | ---: |
| Baseline | 18,729 | — |
| + `-fopt-slotreg` | **18,665** | **-64 (-0.34%)** |

Mnemonic account: `LDR 2,443 -> 2,408` (-35), `STR 1,148 -> 1,119` (-29), everything else unchanged.
Per TU: none of the 95 grew, 85 are byte-identical.

### 9.5 Verdict: archived

By the first falsifier in section 5 (a total drop below 0.5%), the measured -64 < 95, so **the line
is archived**. The stacked measurement of section 6 is therefore not needed (its prefix is already
"vstack on", and this pass is still +64 on top, just below the line). The full argument, the root
causes of the three miscompiles and "why the code stays in the tree" are in
`docs/SLOTREG.md` (Chinese) / `docs/SLOTREG.en.md` (English).
