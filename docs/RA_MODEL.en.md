# Code-generation model change (0.9.2 preregistration): from "value stack + r0" to "IR virtual registers + linear scan"

> Status: **preregistration complete, the read-only S8a pressure measurement has not been run.**
> This document emits no code. It pins down three things first: what shape the gap has under
> the 26-flag corpus (§1), why the text layer has been measured out (§2), and the first
> verifiable slice plus its frozen criteria (§3–§7).
> **The criteria are frozen before the run** — changing them after the implementation
> starts would make them meaningless.
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
and `CBZ`, tail calls and block merging, `--size-weight`.

One part is missing: **the allocator itself**.

## 4 Slices

### 4.1 S8a: read-only pressure measurement (no emission change)

On the existing IR (S6 already numbers every value), measure each function in parallel:

| Report item | Meaning |
| --- | --- |
| `nvreg` | number of virtual values in the function |
| `pmax` | maximum overlap width of live intervals (values alive at once) |
| `spill_est` | estimated spills of a linear scan over "8 available registers plus short-lived r0–r3" |
| `cov` | share of instructions that live in functions with `pmax <= 8` and `spill_est == 0` |

`cov` is the number the criterion looks at. `pmax` alone means nothing: one 30-wide block is
enough to blow up the average, while the real payoff depends on **most instructions** living
in functions that need no spills.

Discipline: the probe is read-only (stderr, behind `ARKCC_RA_STATS`), removed after the
measurement and never committed; after removal the 26-flag figures must return to
`11,766 / 398,673` byte for byte.

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

**S8a criterion** (decides whether S8b happens):

- `cov >= 60%` (share of all instructions living in functions with `pmax <= 8` and no spill)
  ⇒ continue to S8b;
- `cov < 40%` ⇒ **close**: the model change is not feasible; this document becomes a
  negative result;
- `40% <= cov < 60%` ⇒ register only, do not implement, and shrink the slice (only functions
  with `pmax <= 4`).

**S8b criterion** (decides whether the switch stays):

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