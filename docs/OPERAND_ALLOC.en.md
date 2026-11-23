# Operand allocation (S3 pre-registration): from "every intermediate crosses memory" to "values stay in registers"

> Status: **pre-registered, not implemented**. This document measures the corpus (§1), writes down
> in numbers why the text layer has nothing left to eat (§2), defines the first slice S3a to a
> verifiable granularity (§3), faces the **register and frame conflict** with the existing
> `-fopt-regalloc` (§4), and freezes the gates and falsifiers (§5-§7). Every number comes from a
> measurement on this repository's own corpus, with the command and the counting convention in each
> section.

## 0 What this document answers

P12 in `docs/OPTIMIZER_PLAN.md` describes S3 as "call sites and across blocks", but S2
(`-fopt-slotreg`) was **archived** after measurement -- the safe text-layer room is only 0.34% (see
`docs/SLOTREG.md` §9). So the question becomes:

1. What are the remaining 18,665 instructions actually made of (§1);
2. Why one more text rule cannot help (§2);
3. What the first verifiable slice is, and what it is worth (§3);
4. How it is sequenced against `-fopt-regalloc`, which wants the same registers and the same frame (§4);
5. What counts as success and what counts as failure (§5-§7).

## 1 Current measurements (2026-11-23)

Corpus: the 95 TUs under `examples/ark_test`, built with
`-target arm -S -O2 -mcpu Cortex-M4 -D STM32F401xE -D USE_HAL_DRIVER --reloc-data` on top of the
twelve switches + `-fopt-cmat` + `-fopt-slotreg`. Only non-directive, non-label lines are counted.

**18,665 instructions in total.**

| Mnemonic | Count | Share | What it is |
| --- | ---: | ---: | --- |
| `MOV` | 3,551 | 19.0% | of which `MOV rD, rS` **1,305**, `MOV rD, #imm` 1,729 |
| `LDR` | 2,408 | 12.9% | reading back the frame and the value stack |
| `ADD` | 1,460 | 7.8% | |
| `STR` | 1,119 | 6.0% | |
| `MOVW` | 1,115 | 6.0% | low half of a 32-bit constant |
| `PUSH` | 1,060 | 5.7% | value-stack pushes / frame saves |
| `CMP` | 1,035 | 5.5% | |
| `MOVT` | 981 | 5.3% | high half of a 32-bit constant |
| `B` | 771 | 4.1% | |
| `POP` | 731 | 3.9% | |
| `BNE` | 611 | 3.3% | |
| `LSL` | 510 | 2.7% | |

Memory base registers (same `.s` files):

| Base | Accesses | Meaning |
| --- | ---: | --- |
| `[r6, #n]` | **1,879** | named locals and their spill slots (frame pointer) |
| `[r5, ...]` | **1,414** | the value stack (temporaries of expression evaluation) |
| `[r0/r1/r4/r7, ...]` | 525 | real array/struct accesses and vstack shadow slots |

In other words: **17.6 out of every hundred instructions read or write the function's own memory**
(1,879 + 1,414), another 11.2 materialise 32-bit constants (`MOVW` + `MOVT` = 2,096), 7.0 are pure
register-to-register copies (`MOV rD, rS` = 1,305), and 9.6 push or pop the value stack
(`PUSH` + `POP` = 1,791).

## 2 Why the text layer has nothing left to eat

Three things are done and each was measured against frozen gates:

| Line | Gained | Verdict |
| --- | ---: | --- |
| Twelve text switches (P7-P14) | 47,885 → 19,066 | landed |
| `-fopt-cmat` (P16) | 19,066 → 18,729 (-1.77%) | landed |
| `-fopt-slotreg` (P17) | 18,729 → 18,665 (-0.34%) | **archived** (< 0.5% falsifier) |

The lesson from `-fopt-slotreg` is decisive: without its safety gate it could delete up to -1.82%,
but every one of those deletions rested on **indirect reads and writes the text layer cannot see**
(the two `STR`s of `c = k ? a : b` are read inside `memcpy`), and that measured as 5 execution-level
failures. What the text layer can take safely is 0.34%; the rest is blocked on "who still reads this
memory", a question the text layer **cannot answer** -- only the IR can.

So the next step is not to delete more, but to **stop producing these instructions**: let IR values
live in machine registers directly.

## 3 Slice S3a: a function-level 32-bit constant cache (callee-saved)

### 3.1 Why start with constants

`MOVW` + `MOVT` total 2,096 (11.2%), the largest single family, and it has the cleanest semantics:
**once a 32-bit constant is materialised into a register, it stays there until that register is
overwritten.** That needs no liveness analysis, only the "register == constant" fact, block-local or
across blocks.

Measured (same corpus, split by function, key = the `MOVW` operand string **including the destination
register**, so this is the conservative convention):

| Item | Value |
| --- | ---: |
| `MOVW` total | 1,115 |
| "the same `MOVW` shape appears again in the same function" | **657** (59%) |
| Functions with a duplicate | about 70 (few functions, but the duplicates concentrate in a few big ones) |

### 3.2 The rule

> If a 32-bit constant `K` is materialised `c` times in a function (`c >= 3`), materialise it once
> into a **callee-saved** register `rC` (one of `r8`-`r11`) and turn the other `c - 1` occurrences into
> `MOV rD, rC`.

The account: `2c` instructions become `2 + (c - 1)`, a gain of `c - 2`; but `rC` is callee-saved and
must be saved, which costs one `PUSH` and one `POP` (2 instructions). So **net = (c - 2) - 2 = c - 4**
and the threshold is `c >= 5`; `c = 3` and `c = 4` break even or lose and are not selected.

### 3.3 Measured upper bound (optimistic convention)

Modelling "every duplicate constant pays `c - 4`, at most 4 cache registers" over the same `.s` files:

| Model | Instructions saved | Share of 18,665 |
| --- | ---: | ---: |
| unlimited cache registers | **399** | 2.1% |
| 4 cache registers (`r8`-`r11`) | **193** | 1.0% |

Both are **upper bounds**: the model assumes no extra `MOV` and that every reuse really hits. The
real value will be lower. Judging by P17 (text-layer bound 0.7% → measured 0.34%), S3a will most
likely land at **1-2%**.

### 3.4 Why it is still worth doing (and not only for that 1-2%)

Because it is the **foundation** for S3b: the three hard parts of S3a are exactly the hard parts of
"let a value live in a callee-saved register":

1. putting something other than a frame slot into `r8`-`r11` (the existing `ra_` only promotes
   **frame slots** there);
2. widening `PUSH`/`POP` and **shifting every offset** (the existing `ra_` has that code,
   covered by `tests/run_regalloc_tests.py`);
3. keeping 8-byte alignment (`ra_` already spends a spare register on an odd saved-word count).

Once S3a works, S3b (live values across calls in callee-saved registers) is just **a different
consumer** and no longer touches the frame.

## 4 The conflict with `-fopt-regalloc` (solve it before starting)

This is a real problem found by reading `ark_regalloc_function()`, not a hypothetical:

| Conflict | Fact | Consequence |
| --- | --- | --- |
| Same registers | `ra_`'s default tier selects no slot on HAL, `-fopt-regalloc-near` does, and it uses `r8`-`r11` | two passes wanting the same registers |
| Same frame | both widen `PUSH`/`POP` and both must **shift every offset** | whoever runs first decides `extra`; the second must know how many words were saved |
| Same order | `ra_`'s shifting code only knows about the block it added | both adding once means offsets shifted twice or not at all |

**The decision (fixed; implement it this way)**: S3a does not widen `PUSH`/`POP` itself; it **asks
`ra_` for the result first** -- expose `ra_`'s chosen `made[]`/`extra`, let S3a pick from the
**remaining** registers, and let `ra_`'s widening **also save** the registers S3a needs (`extra`
computed in one go, offsets shifted exactly once). In other words: **the PUSH widening and offset
shift may have exactly one owner**, and S3a is its second customer.

If implementation shows S3a must widen by itself, the slice **degrades to not done** -- two passes
shifting offsets independently is a high-risk area for miscompiles and is not worth 1-2%
(cf. "rather report an error than give a wrong answer").

## 5 Gates (frozen; unchanged once implementation starts)

`tests/run_operand_alloc_tests.py`, `make test-opalloc`:

1. **OFF IS OFF**: without the flag the 95-TU corpus is byte-identical;
2. **Only ever smaller**: `on <= off` for every TU and a strict drop in the total; **any TU growing
   turns the gate red**;
3. **The reuse really happens**: in at least one fixture the `MOVW`+`MOVT` count for one 32-bit
   constant drops and the replacement is `MOV rD, rC` (not a deletion);
4. **Correct across calls**: in a fixture with a `BL` between two materialisations, the cache still
   hits (the callee-saved argument) and the value is still correct after the callee returns;
5. **Does not fight `ra_`**: with `-fopt-regalloc-near` also on, the two do not use the same register
   and the offsets are shifted exactly once (asserted by comparing the frame-offset set before and
   after);
6. **Semantics**: the whole `tests/arm_exec` corpus agrees off/on, plus at least 3 new fixtures
   (constant across a `BL`, constant inside a loop, constant with `ra_` also on);
7. **Cropping**: `ARKCC_FEATURE_OPT_CONSTCACHE` (`STM32_MIN` 0); a cropped build rejects the flag
   with `C3900U` and still compiles without it.

## 6 Falsifiers (fixed)

Any of these archives the line:

- total instruction count drops less than 0.5% (< 95);
- any single TU grows;
- more than 4 cache registers are needed to clear 0.5% (the gain would come from "more registers",
  not from the "constant reuse" mechanism);
- S3a has to widen `PUSH`/`POP` itself (i.e. the shared scheme of §4 does not work).

## 7 Direction of S3b (registered only, not pre-registered)

If S3a clears its line, S3b's subject is **live values across call sites**: a temporary in the value
stack (`[r5, ...]`, 1,414 accesses) or the frame (`[r6, #n]`, 1,879 accesses) that is read back after
a `BL` should live in a callee-saved register. Its account is far harder (live intervals and a spill
policy), so it **must be pre-registered separately, after S3a's gates and frame machinery work and
after S3a's measured gain is known**. This document freezes no number for S3b.

## 8 Implementation and measurement (2026-11-23, S3a landed)

### 8.1 Where it lives

`-fopt-constcache` is not a pass of its own: it is the **second client** inside
`ark_regalloc_function()`, which is how the rule written into section 4 holds -- "the `PUSH`
widening and the offset shift may have exactly one owner". `extra` is computed once, offsets are
shifted once, `PUSH`/`POP` are rewritten once.

- **The constant survey** walks the same text before slot selection. A `MOVW` immediately followed
  by a matching `MOVT` on the same destination is one pair; the key is `(lo, hi)`. A pair that
  follows `.arkdata` / `.arkdatasym` is a link-time relocated address and **not a number**, so the
  whole key is poisoned (never cached) while the other keys in the same function still qualify.
- **Selection order**: `ra_` picks its slots first (`made[0..nregs)`); constants only take what is
  left of `r8`-`r11`, and only a register that does **not appear anywhere in the function's original
  text** (conservative -- a misjudgement only costs one register). The total still obeys
  `RA_MAX_REGS` (4).
- **The account** is `Sigma(count-1)`: materialising a constant `c` times costs `2c` instructions,
  building it once at the entry plus one copy per use costs `2+c`. Turning the saved block from
  "no saved register" into "some" costs one wider `PUSH` and `POP` (2 instructions), charged only
  when `nregs == 0` started out true; when the constants do not cover it the whole group is
  handed back, so a function never grows because of this pass.
- **The materialisation sits at the entry** (after `PUSH`, before `SUB sp`), not at the first
  textual use -- that use can sit inside a branch, which is not dominance-safe.
- An odd register count takes one spare register, so the saved block stays a multiple of 8 bytes
  (AAPCS wants that at every `BL`).

### 8.2 An existing defect the work exposed (fixed)

`ra_` recognised the prologue with a **prefix** match on `"PUSH {r5"`. A value-stack spill of one
value is written `PUSH {r5}` and matched too, so a **mid-function** spill was widened as if it were
the frame save and the entry materialisation was inserted in the middle of the body; meanwhile the
vstack r4 shape `PUSH {r4, r5, r6, r7, lr}` did not match at all (which is why `ra_` had never
broken those functions).

The fix compares the **whole list**: with spaces removed it must be exactly `PUSH{r5,r6,r7,lr}`.
The epilogue is the same (`POP{r5,r6,r7,pc}` or `POP{r5,r6,r7,lr}`). `PUSH` is rewritten only at its
first occurrence (the real frame save) while every return path's `POP` is rewritten (they all have to
restore the same widened block), and the tail element (`pc}` or `lr}`) is carried over verbatim
instead of being chosen here.

**The cost and the boundary**: this pass deliberately does **not** take over vstack's r4 prologue
shape -- it carries an extra pad word and widening it would break 8-byte alignment. So a function
whose frame was rewritten into that shape by `-fopt-vstack` abstains as a whole: a little less gain,
but it can never be wrong. That is an accepted conservatism, not an oversight.

### 8.3 Measurement (baseline = twelve switches + `-fopt-cmat` + `-fopt-slotreg`)

| Item | Value |
| --- | --- |
| Corpus | 95 TUs under `examples/ark_test` |
| Off | 18,665 instructions |
| On | **18,506 (-159, -0.85%)** |
| Changed | 3 TUs: `stm32f4xx_hal_dma_ex.c` 3,412->3,340, `stm32f4xx_hal_rcc.c` 2,887->2,813, `stm32f4xx_hal_rcc_ex.c` 1,150->1,137 |
| Unchanged | 92 TUs byte-identical; **no TU grew** |
| OFF IS OFF | A cropped build (`-DARKCC_FEATURE_OPT_CONSTCACHE=0`) on the same corpus is byte-identical to the default build on 95/95 |
| Execution level | `tests/arm_exec --extra=-fopt-constcache` -- **0 failure** |

### 8.4 Verdict: land (no falsifier triggered)

None of the four falsifiers in section 6 holds: -0.85% is above the 0.5% line, no TU grew, at most
4 registers are used, and S3a **did not have to widen `PUSH` itself** (the shared scheme of section 4
works). All seven criteria of section 5 land in `tests/run_operand_alloc_tests.py`
(`make test-opalloc`) and every check passes; three of them ("across a call", "no register clash",
"offsets shifted exactly once") assert on the real emitted text rather than arguing from the IR.

S3b is still not pre-registered: this slice solved "put a non-slot value into `r8`-`r11`" and
"widen the saved block and shift offsets exactly once", but S3b also needs live intervals and a
spill policy, so section 7 stands.
