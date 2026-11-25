# Code-generation model change (0.9.2 preregistration): from "value stack + r0" to "IR virtual registers + linear scan"

> Status: **preregistration complete; S8a was redefined as a text-layer proxy and is DONE
> (2026-11-25). Verdict: the ceiling is insufficient, S8b does not start.**
> This document emits no code. It does four things: measure the shape of the gap under
> 26 flags (§1), show the text layer is measured out (§2), **correct the feasibility basis of
> the model change** (§3/§4.1: this repository's IR is a pure stack machine with no virtual
> register field, so "measure liveness on the existing IR" is not implementable and S8a can
> only fall back to a text-layer proxy), and pin down the hard ceiling of this line plus the
> full arithmetic of "reaching 5,619" (§4.1a / §10).
> **The criteria were frozen before the run**; §5 was re-derived once from the measured
> results, and both the new and the superseded wording are kept in place.
> Every number comes from this repository's own 95-TU corpus; the command and the
> measurement convention are written in each section.

## 0 What this document answers

`docs/BOUNDARY.md` §7 states flatly that arkc does not promise to reach 5,619 and that
getting there requires a different code-generation model (value stack → graph-colouring
register allocation + constant pool + base reuse) — work deferred to 0.9.2 and later.
After the nineteen 0.9.1 `-fopt-*` passes plus `-fopt-constcond` / `-fopt-boolmat` /
`-fopt-exit` / `-fopt-bitmask`, that line has reached the point where it has to be taken
seriously. This document answers:

1. under the 26-flag corpus, which categories the 6,147-instruction gap against armcc `-O2`
   actually falls into (§1);
2. how much is left in the text layer — measured family by family, and why every family
   lands under the 5% F1 line (§2);
3. what the target model is, and why it changes the *unit of allocation* rather than adding
   one more pass (§3);
4. how to measure feasibility of the first slice without touching emission (§4);
5. what counts as success, what counts as failure, and what would be a false green (§5–§7).

## 1 Current state: per-category gap under 26 flags

Convention: 95 TUs (`examples/ark_test` Core/Src plus the HAL Src directory), compiled with
`-target arm -O2 -mcpu CortexM4 -D STM32F401xE -D USE_HAL_DRIVER --reloc-data -S` and 26
switches (`sw24`'s twenty-four plus `-fopt-exit` and `-fopt-bitmask`). An instruction is a
line indented by four spaces that does not start with `.`; the classifier is the same one
used in `docs/BOUNDARY.md` §2 (`classify2.py`'s `classify()`, condition codes and `S`
suffixes normalised, `MOVW`/`MOVT` listed separately, accesses based on `[r6` counted as
`FRAME`).

| Category | arkc | share | armcc `-O2` | share | delta |
| --- | ---: | ---: | ---: | ---: | ---: |
| MOVREG (`MOV rD, rS`) | 1,315 | 11.2% | 214 | 3.8% | **+1,101** |
| PUSHPOP | 1,169 | 9.9% | 156 | 2.8% | **+1,013** |
| FRAME (`[r6, #o]`) | 971 | 8.3% | 45 | 0.8% | **+926** |
| MOVIMM | 1,193 | 10.1% | 389 | 6.9% | **+804** |
| MEM (other bases) | 1,746 | 14.8% | 1,207 | 21.5% | +539 |
| ARITH | 822 | 7.0% | 302 | 5.4% | +520 |
| LOGIC | 732 | 6.2% | 394 | 7.0% | +338 |
| MOVW+MOVT | 338 | 2.9% | 0 | 0.0% | +338 |
| POOL (`LDR rX, .Llit_*`) | 705 | 6.0% | 391 | 7.0% | +314 |
| BR | 1,534 | 13.0% | 1,284 | 22.9% | +250 |
| CMP | 678 | 5.8% | 479 | 8.5% | +199 |
| BL | 182 | 1.5% | 153 | 2.7% | +29 |
| IT | 40 | 0.3% | 0 | 0.0% | +40 |
| OTHER | 28 | 0.2% | 26 | 0.5% | +2 |
| SYS | 20 | 0.2% | 22 | 0.4% | −2 |
| SP | 0 | 0.0% | 46 | 0.8% | −46 |
| SHIFT | 212 | 1.8% | 309 | 5.5% | −97 |
| EXT | 81 | 0.7% | 202 | 3.6% | −121 |
| **Total** | **11,766** | | **5,619** | | **+6,147 (2.09x)** |

The four leading items — `MOVREG + PUSHPOP + FRAME + MOVIMM` — add up to **+4,844
instructions, 78.8% of the whole gap**. They are not four separate opportunities; they are
four faces of **one model fact**:

1. **every intermediate value is born in `r0` and then moved by a `MOV` to wherever it
   actually has to live** (MOVREG 1,101);
2. **the value-stack pool holds only `r5`/`r7`** (with `r4` borrowed when three values are
   live at once), and when the pool fills up the value degenerates into a real
   `PUSH`/`POP` — 471 pool-full sites plus 589 boundary pins live inside the PUSHPOP delta
   (see `docs/VSTACK_CFG.md` §1);
3. **every local is touched through `[r6, #o]`** (a 926-instruction delta) —
   `-fopt-slotreg`'s delete-only rule removed the dead stores and the duplicate reads; what
   remains is produced by the rule "a value must be written to memory before it can be read
   back";
4. **the same constant is materialised once per site** (MOVIMM + MOVW/MOVT) —
   `-fopt-litpool` chased 32-bit constants into the pool, but 0..255 short constants still
   get "one `MOV` for every consumer".

## 2 The text layer is measured out: residual-shape scan (26 flags)

Method: read-only scan of `D:/tmp/bm/gate_exit/bmk_on/*.s` (the 95 products under 26 flags),
counting hits for every shape the text layer could in principle still delete. **Every count
is an upper bound** (anything uncertain is counted as deletable).

| Residual shape | Hits | Share of 11,766 | Note |
| --- | ---: | ---: | --- |
| same register reloads the same literal twice in one block | **55** | 0.47% | `LDR r5, .Llit_x` again while r5 was never written |
| same register re-materialises the same immediate in one block | **52** | 0.44% | rX still holds `#imm`, another `MOV rX, #imm` follows |
| `PUSH {rX}` immediately followed by `POP {rX}` | 30 | 0.25% | idle spin between pool slot and pin |
| `STR rX,[r6,#o]` then `LDR rX,[r6,#o]` on the same slot within 3 lines | 15 | 0.13% | same value round trip |
| `STR` immediately followed by `LDR`, same slot and register | 9 | 0.08% | the adjacent form of the above |
| `MOV d,s` immediately followed by `MOV s,d` (round trip) | 5 | 0.04% | the two sides shuttle the same value |
| `MOV d,s` immediately followed by `MOV e,d` (chain) | 1 | 0.01% | already covered by `-fopt-copyprop` |
| `MOV d,s` whose destination is last used on the next line | 0 | 0.00% | historically 32 (19 flags); the upstream passes eat it by 26 |
| `STR` immediately followed by an identical `STR` (idempotent store) | 0 | 0.00% | does not exist once 23 switches run together |
| **Total** | **167** | **1.42%** | |

Three conclusions:

- each family on its own is **below the 5% F1 line**, and together they are only 1.42% —
  and that 1.42% is the **sum of mutually exclusive upper bounds** (a real implementation
  would have them eat into each other). Under the repository's existing discipline
  (`docs/VREG.md` F1) they are all **closed**.
- this explains why the last four passes (`constcond` / `boolmat` / `exit` / `bitmask`) are
  each worth only 0.5%–1.2%: they are not badly built, the **magnitude itself has run out**.
- therefore the 0.9.1 optimization line **ends here**: of the remaining 6,147 instructions
  (2.09x) there is no family from which another text rule could take 5%.
- **Addendum (2026-11-25)**: while measuring the S8a ceiling a batch of "base address formed
  and never folded" shapes was scanned up. The first draft recorded them as a family this
  table missed; **that was wrong**. Reading `ark_addr_function()` shows `-fopt-addr`'s
  R1/R2/R3 were already folding exactly this, and only two coverage gaps were left: the
  access need not be adjacent, and `MOV` may be followed by arithmetic instead of an access
  (see §4.1b). With both closed the 26-flag corpus goes from 11,766 to **11,666 instructions
  / 396,986 B** (-100 = -0.85%, -1,687 B), and a rescan of the folded output finds both
  shapes at zero. It does not overlap this table's 167 (those are duplicate moves and round
  trips; this one is base-address formation).

Reproduce (read-only, not committed):

```bash
# 26-flag products plus the per-category comparison
python -X utf8 D:/tmp/bm/gate_bmk.py      # writes gate_exit/bmk_off, bmk_on
python -X utf8 D:/tmp/bm/cmp26.py         # the per-category table of §1
python -X utf8 D:/tmp/bm/scan26.py        # adjacent shapes (PUSH/POP, STR/LDR, MOV chains)
python -X utf8 D:/tmp/bm/litdup.py        # duplicate literal reloads in one block
python -X utf8 D:/tmp/bm/immdup.py        # duplicate immediate materialisation in one block
```

## 3 The target model: the unit of allocation moves from text lines to IR virtual registers

Today (`docs/RA_VSTACK.md`): every expression node in the IR **really pushes once**, the
backend emits line by line, and the value-stack pass (`-fopt-vstack`) renames a shadow stack
**on the text**, with a pool of two to three slots and a hard flush at every boundary. The S6
series (`-fopt-vreg` / `-fopt-slotreg`, `docs/VREG.md`) has taken text-level renaming as far
as it goes: it can delete redundant moves, but it **cannot decide where a value is born** —
that was fixed at emission time, and it was `r0`.

The target model is one sentence: **give every IR value a virtual register at emission time
and do the allocation in the IR**.

```
the life of a value v:  defined by one IR instruction, live over [def, last_use]
allocation:             linear scan (Poletto & Sarkar), over r4–r11 (8 callee-saved registers);
                        r0–r3 stay for arguments/return values and for short-lived temporaries
                        whose interval crosses neither a call nor a branch
frame slots:            only two kinds of object stay at [r6, #o] — spills, and variables
                        whose address is taken
boundaries:             in-block allocation first; joins keep the conservative criterion of
                        `docs/VSTACK_CFG.md` §3
```

Why this is a model change and not one more pass:

- today's 926-instruction FRAME delta and 1,101-instruction MOVREG delta are the **same
  decision**: a value is born in `r0` and must go to memory first. No amount of text renaming
  can change "it was born in `r0`".
- conversely, once the allocator can say "this value lives in `r7`" at emission time, a large
  part of the `MOV`/`STR`/`LDR` families **never gets generated** instead of being generated
  and then deleted. That is exactly the root of the three structural causes in
  `docs/BOUNDARY.md` §4.

Parts already in place (do not rebuild): the constant pool (`-fopt-litpool`), base reuse and
addressing folding (`-fopt-addr`), strength reduction (`-fopt-strength`), compare-to-branch
### 3.1 The IR of today: a pure stack machine, no virtual-register field (correction)

The first draft of this preregistration claimed "S6 already numbers every value". The code
does not work that way; re-checked on 2026-11-25:

- `IrOp` in `include/common.h` has **pure stack semantics** — `IR_PUSH_INT` / `IR_PUSH_VAR` /
  `IR_BINARY` (comment verbatim: "pop right operand r1, left operand r0") / `IR_STORE` …;
  every instruction takes its inputs from and leaves its output on an **implicit stack top**;
- `IrInst` in `include/ir.h` has only `op / val / name / aux / line / aux2` — **no virtual
  register number** and no live interval;
- `-fopt-vreg` is implemented by `ark_vreg_function()` at
  `src/backend/arm/backend_arm.c:3794` (call site 14713); what it receives is an already
  emitted `AsmBuffer` and it renames registers **on the text**. `-fopt-slotreg` is the same.
- the IR has no dump option either (no `--dump-IR`), so there is no "read the IR offline"
  route.

So **S6 is not IR-level numbering; it is post-emission text renaming**, the target model of
§3 is still **unimplemented**, and the first thing S8b must do is "add a vreg field to
`IrInst`, make irgen number values, add an IR dump" — which is itself part of the model change
(and costs work beyond the allocator).

Parts already in place (do not rebuild): the constant pool (`-fopt-litpool`), base reuse and
addressing folding (`-fopt-addr`), strength reduction (`-fopt-strength`), compare-to-branch
and `CBZ`, tail calls and block merging, `--size-weight`.

One part is missing: **the allocator itself** (and the IR change it requires).

## 4 Slices

### 4.1 S8a: ceiling measurement (text-layer proxy, DONE 2026-11-25)

**Why not "measure `nvreg`/`pmax`/`spill_est` on the IR"**: see §3.1 — the IR is a stack
machine, `IrInst` has no vreg field and there is no IR dump. The four report items as
originally specified are **not implementable** on today's tree: not "not run", but "cannot be
run". Running them requires S8b's first step (vreg field plus dump), which is no longer
read-only.

S8a therefore became a **ceiling measurement on the emitted text**, with a harder question:
**"if the allocator were perfect and produced not one redundant move or spill, how many
instructions could go away at most?"** That ceiling does not depend on the IR change and can
be pinned down today; if it cannot reach the target by itself, there is no point building the
allocator first.

Read-only scan of `D:/tmp/bm/gate_exit/bmk_on/*.s` (the 95 products under 26 flags). **Note:
these products already ran `-fopt-vreg` / `-fopt-slotreg` (they are two of the 26 switches),
so the numbers below are the residual *after* S6 — there is no double counting with S6.**

| Ceiling item | Count | Share of 11,766 | Source |
| --- | ---: | ---: | --- |
| frame slot to register · in-block (L1) | 133 | 1.13% | `slotscan3.py` |
| frame slot to register · cross-block, not across a call (L2) | 32 | 0.27% | same |
| frame slot to register · across a call (L3, needs callee-saved) | 718 | 6.10% | same |
| result redirection (`MOV rD,r0` with r0 dead afterwards) | 266 | 2.26% | `movredir.py` (266 of 313 candidates have r0 dead) |
| value-stack pool `PUSH {r0}`/`POP {r0|r1}` churn | <= 636 | <= 5.41% | PUSH `{r0}` 498 + POP `{r0}` 96 + POP `{r1}` 42 |
| **Total (hard ceiling, mutually exclusive shapes added)** | **<= 1,785** | **<= 15.2%** | |

Where the L3 718 live: `hal_dma_ex` 300, `hal_dma` 90, `hal_rcc` 85, `hal_flash_ex` 68 —
long functions that keep hitting the same local with `STR`/`LDR`, exactly what callee-saved
allocation should eat.

`ADD sp, sp, #imm` 222 / `SUB sp, sp, #imm` 146 (368 together) are **frame setup and
teardown**, not waste: armcc shows single digits only because it keeps parameters and locals
in registers and has a zero frame (see the side-by-side in §10).

### 4.1a What this ceiling says: allocation alone does not beat armcc

- eat all 15.2% (impossible) and 11,766 becomes about **9,980**, still **1.78x** armcc `-O2`;
- and 6.10% of that 15.2% is L3 across calls — S7a already measured retention across calls at
  only **220 instructions net** (save 1,182, pay 962, see `docs/VSTACK_CFG.md`). Applying the
  same survival rate, what is actually realisable is **the in-block L1+L2 165 (1.40%) plus the
  266 redirections plus part of the pool churn**, on the order of **3%–6%**;
- in other words **S8b (in-block) lands in the "3%–6%, register only" band, S8c (across
  calls) reaches double digits only at a known cost, and neither ceiling reaches 5,619.
  Allocation is not the answer; it moves 2.09x to 1.8x.**

### 4.1b Address-chain folding: not a new family, a coverage gap in `-fopt-addr` (closed, 100 paid)

While measuring the S8a ceiling a batch of "base address formed, never folded" shapes turned
up, and the first draft took it for something new. Reading `ark_addr_function()`
(`src/backend/arm/backend_arm.c`) corrects that: `-fopt-addr`'s R1/R2/R3 **already folded**
an access adjacent to `ADD RD, RB, #imm` / `ADD RD, RB, RI` / `MOV RD, RS`. The 189 measured
instructions were the residue of two **coverage gaps**:

| Gap | Shape | Count |
| --- | --- | ---: |
| the access need not be adjacent | `ADD rD, rX, #k` (or `MOV rD, rX`), then `[rD, #j]` a few lines later | 189 |
| the `MOV` is followed by arithmetic, not an access | `MOV rD, rS` + `ADD/SUB rD, rD, #k` (visible only after R1b) | 38 |

The fix **extends `-fopt-addr`**: no new switch, no new trimming row (the whole block already
sits under `ARKCC_FEATURE_OPT_ADDR`).

- **R1b (look-ahead base fold)**: after `ADD RB, RS, #imm`, find the first access inside four
  instructions whose base is RB and which has no index register. The window closes on a label,
  a conditional, `B/BX/BL/BLX/CBZ/CBNZ`, a write to RB or RS, or a read of RB that is not that
  access. The fold still obeys R1's death rule (the access writes RB back, or RB is dead
  afterwards).
- **R0 (move merged into arithmetic)**: `MOV RD, RS` followed by `ADD|SUB RD, RD, #imm`
  (imm 0..4095) becomes one `ADD|SUB RD, RS, #imm`. The MOV dies the moment the ADD overwrites
  it, so **no liveness check is needed**; result and flags are the ones the ADD/SUB already
  produced.

Measured on the 26-flag 95-TU corpus (`D:/tmp/bm/remeasure.py`):

| Stage | Instructions | Bytes | vs. before |
| --- | ---: | ---: | --- |
| before (`e295220`, 26-flag products) | 11,766 | 398,673 | — |
| + R1b (look-ahead base fold) | 11,713 | 397,686 | -53 / -987 |
| + R0 (MOV merged into arithmetic) | **11,666** | **396,986** | **-100 / -1,687** |

**189 predicted, 100 paid, and the whole difference is "death at the end of a block"**:
`ad_dead_after()` returns "live" on a label, a branch or a call, because the text layer does
not know which successor block a block end flows into. Loosening that would mean betting on a
liveness fact the pass cannot prove, which "rather an error than a wrong answer" forbids. The
gap is itself the conclusion: **the address folds the text layer can safely pay are used up**;
what is left needs real in-block liveness, i.e. the S8b allocator, and §4.1a has already
shown that allocator alone does not beat armcc.

Rescan of the folded output (`addrchain_ac.py`): `MOV + ADD-self` **0** left, `ADD` base +
`[rD]` **0** left. Gate `tests/run_addr_tests.py` is green, including OFF IS OFF and the four
emulator arms.

### 4.1c Reproduce (read-only, not committed)

```bash
python -X utf8 D:/tmp/bm/slotscan3.py    # frame-slot ceiling 133 / 32 / 718
python -X utf8 D:/tmp/bm/movredir.py     # result redirection 313 -> 266
python -X utf8 D:/tmp/bm/addrchain.py    # address-chain ceiling 128 + 61 (before the change)
python -X utf8 D:/tmp/bm/addrchain_ac.py # residue in the folded output: 0 + 0
```

### 4.2 S8b: implementation (new switch, off by default)

`-fopt-ra-model` (macro `ARKCC_FEATURE_OPT_RA_MODEL`, 1 on the host, 0 on the board, off by
default): with the switch **off**, emission is byte-identical to today (OFF IS OFF); with it
**on**, the allocator of §3 runs. The trimming table (`include/arkcc_config.h`) and the
by-name refusal table in `src/main.c` (`C3900U`) each gain a row.

**In-block first, cross-block later**: S7a already proved that retaining values across joins
is worth only 220 instructions net (save 1,182, pay 962), so the first cut of S8b is
**in-block only**; joins wait for S8c and must be re-measured.

### 4.3 S8c: joins and call boundaries (registered, not started separately)

Once in-block works, hook up the join criterion (reuse §5.6 / `docs/VSTACK_CFG.md` §3's
"all predecessors agree") and drop `BL` from the boundary set (`r5`/`r7` and r8–r11 are all
callee-saved, so crossing a call is safe). Criteria as in S8b.

## 5 Criteria (frozen, not to be changed before implementation)

**S8a's original criterion (superseded, wording kept)**:

- `cov >= 60%` (share of all instructions living in functions with `pmax <= 8` and no spill)
  ⇒ continue to S8b;
- `cov < 40%` ⇒ **close**: the model change is not feasible; this document becomes a
  negative result;
- `40% <= cov < 60%` ⇒ register only, do not implement, and shrink the slice (only functions
  with `pmax <= 4`).

**Why superseded**: `cov` needs `pmax`/`spill_est` computed on the IR, and §3.1 established
that the IR has no vreg field (not implementable). It is replaced by the **hard ceiling** of
§4.1, with the criterion moving from "coverage" to "realisable instruction count":

**S8a's current criterion (re-derived 2026-11-25, replaces the above)**:

- the in-block slice (L1+L2 + result redirection + the in-block part of pool churn) has a
  measured ceiling of **3%–6%**, i.e. it sits between the "5%–10% register only" and the
  "< 5% revert" lines below ⇒ **S8b does not start**;
- the full slice (including L3 across calls) ceilings at <= 15.2%, but S7a already measured
  L3's real net benefit at **220 instructions (1.87%)** ⇒ the realisable figure stays **< 5%**;
- neither reading reaches >= 10%, and **the 1.78x ceiling still loses to armcc `-O2` (1.0x)**
  ⇒ **the model change is recorded as `ceiling_insufficient`; S8b and S8c are not
  implemented and `-fopt-ra-model` is not added**.

**S8b criterion (wording kept; not activated because S8a went negative)** (decides whether
the switch stays):

- a net **>= 10% (>= 1,177 instructions) decrease with no byte increase** under 26 flags ⇒
  land it (this is the magnitude a model change should have; §1's four leading items are
  4,844, so 10% asks for a quarter of them);
- 5%–10% ⇒ register only; the switch stays but off by default and the README states the
  magnitude;
- **< 5% ⇒ revert the switch** (code included, nothing left in the tree) — under 5% means the
  "change the model" judgement itself was wrong, and ten thousand new lines are not worth 4%.

**Correctness (all five, or the slice fails)**:

1. all 95 TUs compile, and the 26-flag instruction/byte figures are updated honestly here;
2. every `tests/arm_exec` case passes with **0 failures** (execution-level reconciliation);
3. existing gates green: `run_peep_tests.py` / `run_addr_tests.py` / `run_vreg_tests.py` /
   `run_cmat_tests.py` / `run_litpool_tests.py` / `run_bitmask_tests.py`, plus
   `stm32_build_check.py --layout both` passing both layouts;
4. **OFF IS OFF**: with the switch off, all 95 products are **byte-identical** to today;
5. **trimming**: the `ARKCC_PROFILE=STM32_MIN` build has the switch at 0, refuses
   `-fopt-ra-model` by name (`C3900U`), and its default-profile size is unchanged.

New fixtures (written before S8b, expectations first):

- a value consumed by three different expressions in one block (one def, one allocation);
- eight values live at once (exactly filling r4–r11); the ninth must spill into a reusable slot;
- a local whose address is taken (`&x` escaping into `memcpy`) — it must stay in the frame;
- a `volatile` local — it must stay in memory and its `DMB` pairing must not move;
- a value used both before and after a call (keep it in a callee-saved register; S8c may not
  relax this before it is measured).

## 6 Anti-false-green controls

Three, written in stone:

1. **force one register**: after the allocator lands, a compile-time probe
   `ARKCC_RA_FORCE_R0` puts every value in `r0` and spills by today's rules — its 95 products
   must be **byte-identical to today**. This proves the gain came from allocation, not from
   "the rewrite happened to produce two fewer instructions".
2. **the interaction with `-fopt-vstack` must be non-negative**: with `ra-model` on, the
   incremental change from `-fopt-vstack` may not be negative (the model change eats exactly
   the ground vstack stands on; if stacking them gets worse, they are fighting over the same
   sites).
3. **`MOVREG` totals are not a gain**: deleting a `MOV` very often introduces an `LDR`
   (the 1,178 in `docs/VREG.md` §18.3 is exactly this class of "looks like a gain" number).
   The verdict reads **both** the instruction total and the byte total.

## 7 Forbidden shortcuts

- never relax liveness to pass a criterion (anything uncertain counts as live);
- never reverse-engineer rules from "what armcc emits" (`docs/BOUNDARY.md` §3);
- never report `spill_est` or `pmax` on their own as a gain;
- never touch the five frozen gates of §5 or the F1–F4 refutation lines of `docs/VREG.md`;
- never flip `-fopt-ra-model` to on by default (the trimming profile stays: 1 host, 0 board);
- never slip cross-block work into S8b (S8c is separate and must be re-measured).

## 8 Budget

- S8a is a read-only measurement: about 3 minutes of machine time (95 TUs once), nothing
  committed.
- One full S8b reconciliation = 95 TUs twice + six gate suites + `arm_exec` +
  `--layout both`, which is on the order of ten-plus minutes of machine time by past
  measurements.
- Repository convention: no task longer than 10 minutes may be started before 08:15 on a
  weekday; across a shutdown the run resumes per TU from disk.
- **Order**: S8a → (if it passes) fixtures → implementation → gates → numbers in this
  document → commit. Any step that fails stops there and writes a negative result; nothing
  pushes forward past a failed gate.

## 9 Relation to existing documents

| Document | Relation |
| --- | --- |
| `docs/BOUNDARY.md` §1/§4/§7 | upstream: the three-arm comparison, the three structural causes, and "reaching 5,619 requires a different model" |
| `docs/RA_VSTACK.md` | the seven safety rails of today's value stack; S8b inherits them |
| `docs/VREG.md` | S6's numbers and the F1–F4 refutation lines; this document is the layer after "text renaming is done" |
| `docs/VSTACK_CFG.md` | S7's negative result (net 220 < 300) — the direct reason for "in-block only" |
| `docs/MIR_CFG.md` | the repository's existing IR-level CFG and fixed point; S8b's block splitting and liveness reuse it |
| `docs/OPERAND_ALLOC.md` | the house style for a preregistration |
| `docs/OPTIMIZER_PLAN.md` §3 | the two trimming layers (`STM32_MIN` and `ARKCC_FEATURE_*`); a new switch follows the same path |

## 10 The final accounting of 0.9.1: what reaching 5,619 would take

Put the gap table of §1 next to the ceiling of §4.1 and the answer is plain: **this is not a
gap an allocator can close.**

| Source of the gap | Count | Who would eat it | Measured realisable |
| --- | ---: | --- | --- |
| MOVREG +1,101 | 1,101 | allocator (values no longer born in r0) | 266 (2.26%) |
| PUSHPOP +1,013 | 1,013 | allocator (no value-stack pool) | part of the <= 636 |
| FRAME +926 | 926 | allocator (locals stay in registers) | 165 in-block + 718 across calls (the latter nets 220) |
| MOVIMM +804 | 804 | partly allocator reuse of zero/one | not measured; 240–400 at a 30%–50% reuse rate |
| MOVW/MOVT +338 | 338 | constant pool (`-fopt-litpool` already there; the rest is pooling's edge) | not measured |
| POOL +314 | 314 | same | not measured |
| ARITH +520 | 520 | address-chain folding (100 paid in §4.1b) plus the expression model | 100 (0.85%, landed) |
| LOGIC +338 / MEM +539 / BR +250 / CMP +199 | 1,326 | the expression and branch models | not measured |

**Total provable on today's tree: about 1,100–1,400 instructions = 9%–12%** (of which the
100 address folds have already been paid this round), landing at
**10,000–10,600 = 1.8x–1.9x**. Reaching 5,619 for real means cutting **more than half of every
one of the six families**, which is not "change the unit of allocation" but **rewrite how
expressions and constants are evaluated** (every C expression from "push — pop — round trip
through r0" to "compute straight into the destination register"). That is an order of
magnitude more work than S8b, and `docs/BOUNDARY.md` §3 already forbids working backwards from
armcc's instruction mix.

Three sentences, final:

1. **the 0.9.1 optimization line closes here**: 26 flags give **11,666 instructions /
   396,986 B**, **2.08x** armcc `-O2` in instruction count; the nine residual families (167 =
   1.42% on the pre-change corpus) are all closed, the address-fold gap is closed this round
   for 100 instructions (0.85%), and the residue is zero;
2. **the model change (S8b/S8c) is recorded as `ceiling_insufficient`**: all 15.2% of the
   ceiling would still only give 1.78x, and the in-block realisable part is < 5%;
3. to go further the entry point is the **expression-evaluation model** (not the allocator);
   its preregistration and frozen criteria are in [EXPR_MODEL.en.md](EXPR_MODEL.en.md)
   (S9: the four value-transport classes overrun by 3,802 = 32.6%; eating all of it gives 1.40x,
   another 500-700 gives about 1.28x). **S9b was implemented and measured: -16 instructions =
   0.137%, withdrawn per the frozen criterion, verdict `statement_local_three_address_insufficient`
   (`EXPR_MODEL.en.md` §9).**

## 11 The two consumers of one saved-register pool: the constant cache and slot promotion (0.9.1-wip, measured)

Section 10 put the allocator's realisable share at 1,100-1,400 instructions. This section records
how much of that was taken by the only part that **already stood up inside its own account** --
not a new pass, but the repair of two existing passes' **line cap** and **register-pool
arbitration**.

### 11.1 Two blockers

1. **Line cap.** `ark_vreg_function` starts with `if (nlines >= VG_MAX_LINES) return;` and
   `#define VG_MAX_LINES 3000`. `HAL_DMAEx_MultiBufferStart_IT` (the largest single function in
   this corpus) is 3,327 lines, so the whole function was skipped: `-fopt-vreg` had a measured
   gain of exactly zero there, not because it was poor but because it never ran. The cap is now
   **8192**, host-side only: under `ARKCC_PROFILE_STM32_MIN` `ARKCC_FEATURE_OPT_VREG` is 0, so
   the board build's static array does not grow.
2. **First come, first served.** The constant cache inside `-fopt-regalloc` and `-fopt-vreg`
   share r8-r11, and the cache runs first, so the pass only ever got the leftovers. Measured on
   that function: slot 0 is read **276 times** while the hottest cacheable constant is rebuilt
   7 times -- the pool was split the wrong way round.

### 11.2 The arbitration rule (as written in the code)

- A private count table `ra_any_off[] / ra_any_cnt[]` (`RA_MAX_ANY 96`), filled in pass 1 by
  `ra_ldr_any()`, which matches `LDR rN, [r6, #off]` for **any** destination register. It
  deliberately does **not** go through `slots[]`: one more offset in that table changes
  `nslots`, which changes the real slots' taint, which would break OFF IS OFF.
- The arbitration quantity is `slot_saving = ra_any_max() - 1` (the largest `any`, minus one, the
  same accounting as the cache's `count - 1`). Each time the cache picks a `best`, if
  `slot_saving > 2 * (count - 1)` it breaks out and leaves the rest of the pool to
  `-fopt-vreg`.
- **Why a factor of two.** `any` is an *upper bound* on what the pass can elide (it also needs a
  single-path region and a renameable consumer), so the estimate must keep a discount; a register
  is handed over only when the margin survives that discount.

### 11.3 Readings (26-flag corpus)

| Measure | Before | After | Delta |
| --- | ---: | ---: | ---: |
| Whole corpus | 11,666 insns / 396,986 B | **11,404 insns / 392,907 B** | -262 (-2.25%) / -4,079 B (-1.03%) |
| `stm32f4xx_hal_dma_ex.c` | 2,745 | **2,500** | -245 |
| `stm32f4xx_hal_rcc.c` | 1,828 | **1,811** | -17 |
| The other 22 TUs | -- | -- | 0 |
| Target `HAL_DMAEx_MultiBufferStart_IT` | 2,632 | **2,387** | -245 (-9.3%) |

Control readings on the same function: `no-constcache` 2,387 / `no-cc + no-vreg` 2,664 /
`no-vreg` 2,632 / `no-slotreg` 2,387 -- after arbitration the function hands all four high
registers to `-fopt-vreg`.

### 11.4 The honest verdict against the frozen criteria

Neither criterion frozen in `GCC_BASELINE.md` §4 was met:

- primary, "target function <= 1,400": measured 2,387, **not met**;
- secondary, "26-flag corpus >= 5% (<= 11,083) and no byte growth": measured -2.25%, **not met**
  (the byte count did not grow).

Side by side with §10 and `GCC_BASELINE.md` §5 this is the **fourth independent reproduction** of
the text layer's ceiling: gcc does this function in 292 instructions because it loads `Instance`
once, strength-reduces to `adds r3, r3, #24` and reads pooled offsets -- decisions at the
expression/IR level (`EXPR_MODEL` §10, S10/S11), not something the text can still give up.

### 11.5 OFF IS OFF (byte for byte)

With `-fopt-vreg` and `-fopt-constcache` dropped, all 18 TUs compared against the pre-change
binary (`7b97e13`): **`differing TUs 0`**, every TU byte-identical. The cropped build
(`-DARKCC_FEATURE_OPT_VREG=0`) still refuses `-fopt-vreg` by name (group 6 of `run_vreg_tests`).

### 11.6 A limitation registered this round (not fixed; needs its own preregistration)

`ra_is_prologue_push()` only accepts `PUSH {r5, r6, r7, lr}`, and `base = local_eff + 16` also
hard-codes "the saved block is four words". When `-fopt-vstack` needs a third pool slot it turns
the frame into `PUSH {r4, r5, r6, r7, lr}` (five words), and then:

- `ark_regalloc_function` returns on its first pass (`!have_prologue`), so the **constant cache
  and regalloc both silently do nothing** on that function;
- the function also never sees the 276 slot reads, so the arbitration cannot happen there at all.

This is **per function**, not global (`dma_ex`'s prologue is still the accepted shape, which is
why the readings above are real). The fix is to derive the saved-block width from the prologue
list instead of assuming 16 bytes, but that touches `base`, every offset derivation and the
epilogue match, so it needs its own preregistration first.

### 11.7 Gates

`run_regalloc_tests`, `run_slotreg_tests`, `run_live_tests`, `run_addr_tests` and
`run_vreg_tests` all pass; `tests/arm_exec` reports **0 failure** across its four arms.

One documented skip in `run_vreg_tests`'s `mixed` case: it asks for the constant cache and this
pass to appear in one PUSH, and §11.6 closes that off from both sides -- with `-fopt-vstack`
regalloc backs out of the frame, and without it an earlier pass has already deleted the
promotable load (measured: the function is byte-identical with and without `-fopt-vreg`). The
case keeps its frame, offset, duplicate-list and answer checks; only that one claim became a skip,
and no existing check was weakened.
