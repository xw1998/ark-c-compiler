# A control-flow value stack (S7 pre-registration): from "linear scan, clear at boundaries" to "solve per block, keep values across joins"

> Status: **pre-registered, and S7a (the read-only shadow solve) has been run and closed**
> (§4.1.1, `net = 220` instructions < 300). This document does not change a single line of
> emission code. It pins three things down first: how the current state and the upper bounds were
> measured (§1), why the text layer has nothing left (§2), and what the criteria, equal budget and
> exit conditions will be when the work happens (§3–§8). The criteria are **frozen before the run**;
> changing them after seeing the numbers would make them worthless.
> Every number comes from this repository's own 95-TU corpus, and each section states its command
> and counting basis.

## 0 What this document answers

`docs/VREG.md` §18.3 measured "join-aware retention of pooled registers" and **did not close it**:
the cheap version turned out to be 0 sites (already closed), while the full version has an upper
bound of 1,178 instructions = 9.6%, above the 5% F1 threshold, so it cannot be closed by F1 and can
only be filed as **the first item of the value-stack model rework**. `docs/BOUNDARY.md` §5.6 records
the same fact as a structural statement. So this document answers:

1. how much the current **linear scan + clear-at-boundary** design actually loses at boundaries (§1);
2. why the text layer (peephole / copies / a wider pool / register copies) is measured out (§2);
3. what the target model looks like — a function CFG, basic blocks, join states (§3);
4. what the first verifiable slice is, and how to measure its value without touching emission (§4);
5. what counts as success, what counts as failure, and what counts as a false green (§5–§7).

## 1 Current state: linear scan, cleared at every boundary

`-fopt-vstack` is a text pass after emission (`ark_vstack_function()`, see `docs/RA_VSTACK.md`).
It keeps a shadow stack recording "value *i* lives in which pool register, or has already been
written back to the machine stack", and the pool has only two slots, `r5`/`r7` (`r4` joins as a
third slot only when three values are alive at once). Its solver is a **linear scan**: at a label,
a branch or a call, every value that is still alive must be **really pushed to memory** (pinned),
otherwise the shadow stack's assumption no longer holds after that edge.

Measured at nineteen switches (95 TUs, `-target arm -O2 -mcpu Cortex-M4` …):

| Item | Sites | Note |
| --- | ---: | --- |
| Real pins (value pinned by a boundary) | **589** | probe in the pinned-PUSH branch behind `ARKCC_VSTACK_STATS`, removed after measuring |
| Genuine `PUSH` from a full pool | **471** | not a boundary problem, a **capacity** problem (only 2–3 slots) |
| Pinned by a label only (mask=1) | 115 | all 115 have `edges = 2` (no single-predecessor label among them) |
| Label + branch (mask=3) | 366 | a branch boundary is always followed by a label, so 2 never appears alone in the mask |
| Pinned by a call only (mask=4) | 5 | |
| All three (mask=7) | 103 | |

Grouped by "what the first boundary is": **474** sites hit a branch or a call first and **115**
hit a label; none of those 115 sits on a single-predecessor label (that is where §18.3's
zero-value cheap version comes from).

The current total: **12,304 instructions / 32,690 B**, against armcc `-O2` 5,619 / 13,920, i.e.
2.19× / 2.35×. Of the 6,685-instruction gap, **4,303 (64.4%) is "value transport"** —
`PUSH`/`POP`/`LDR`/`STR`/`MOV` instructions whose only job is to move a value one hop.
`-fopt-vstack` alone is worth 3,364 instructions (21.5%) / 6,682 B, the largest single item among
the nineteen switches — which is exactly why the value-stack model is the only structural lever
left.

## 2 Why the text layer has nothing left

Four candidates were each measured **read-only before implementation**, with the criteria written
down first:

| Line | Measured | Verdict |
| --- | --- | --- |
| Cheap version (retain across single-predecessor labels) | **0** pins | exact value, not a bound; closed (§18.3) |
| Widening the pool to `r8`–`r11` | buys at most 942, sells 882 of vreg (r8–r11 are 11.6% of the final text) | net negative, closed (§18.4) |
| Register copies, 1,506 lines | cross-block liveness bound **208 = 1.63%** | closed by F1 (BOUNDARY §5.4) |
| Duplicate constant materialisation, 1,198 lines | optimistic bound **297 = 2.41%** | closed by F1 (BOUNDARY §5.3) |

All four are "margin visible from the text layer", and all four are under 5%. One thing is left:
**a value should not be written back to memory at a boundary** — and that is not something another
text rule can fix, because it requires the solver to know what the other end of each edge looks
like.

## 3 Target model: function CFG, basic blocks, join states

Replace the solving unit — "one linear sequence per function" — with "the DAG of basic blocks plus
back edges", and replace the linear shadow stack with **block-entry states**:

```
State = { depth,                     // logical value-stack depth (number of logical values)
          slot[i] -> { reg | MEM },  // where value i is: pool register number, or already in memory
          pool[R]  -> slot index }   // reverse map, used to recycle a killed value's register
```

- **Inside a block** the existing rules stay untouched (reference counting, materialise when one
  operand both reads and writes, never retarget `MOVW`/`MOVT`, materialise the in-place
  `ADC/SBC/MUL` forms, …).
- **At a join**: a value may cross a label **without going to memory** if and only if **every
  predecessor** arrives at that label with the **same pool register and the same slot index** for
  that value. If any predecessor says "it is in memory" or "it is in another register", the value
  must spill at the join. This is conservative, and it must be: a pool register that does not hold
  the value on another path produces wrong code.
- **Calls**: `r5`/`r7` are callee-saved under AAPCS, so surviving a call is legal; treating a call
  as a wall is a **model choice**, not an ABI constraint. But only **5** pins are pinned by a call
  alone (bound 10 instructions), so this is not worth its own slice — it is registered as S7c (§4.3).
- **Capacity**: retained values occupy pool slots. With 471 pool-full sites the pool is already
  tight, so the work must **also report** "how many pool-full sites remain after retention". This
  is the easiest place to fool oneself: if retention pushes pool-full from 471 to 900, most of the
  gain is eaten back while the instruction count still looks good.

## 4 Three slices

### 4.1 S7a: read-only shadow solve (no emission change)

Run a second, **parallel** CFG solve over the same emitted text: build basic blocks, iterate the
§3 `State` to a fixed point (`in[B] = join(in[pred])`, and advance inside a block with the existing
rules), **without changing any output line**, and report four numbers:

| Report | Meaning |
| --- | --- |
| `retainable` | of the 589 pins, how many have **every predecessor in agreement** and could be retained (×2 instructions gives one bound) |
| `must_spill` | the other side: what must go to memory on some path (a lower bound) |
| `poolfull_after` | what the 471 pool-full sites become if S7a's retention were applied |
| `net` | `retainable × 2 − (poolfull_after − 471) × 2`, the read-only estimate of the **net** instruction gain |

`net` is the number the criteria look at. `retainable` alone means nothing — §18.3's 1,178 is
exactly that half-a-number.

### 4.1.1 Measured (S7a is done; the `net ≥ 300` bar was not met, so the line is closed)

The probe is **read-only**: inside `ark_vstack_function()` it runs a parallel CFG solve over the
same `VsLine` array and writes no output line at all. It was removed afterwards with
`git checkout -- src/backend/arm/backend_arm.c`, and `lp19.py` on the rebuilt compiler still reports
`12,304 insns / 32,690 B / 95 units / 0 err` — byte-identical to the state before pre-registration.

**The first version tripped over its own bug**: it split blocks only at labels. `reach` collapsed to
single digits (in `hal_dma_ex.c`'s first big function only 2 of 10 blocks were reachable), because a
conditional branch *in the middle* of a straight run is a real edge; splitting only at labels
declares the whole tail unreachable. After also splitting after every branch terminator, 2,763 of
3,061 blocks are reachable (90.3%), 212 functions take part, and `unk = 0` (an instruction `vs_form`
does not know is treated as a no-op instead of killing the block). That is a reusable lesson in
itself: **a text-layer CFG must split on branches, not only on labels.**

Corpus readings (19-switch basis, 95 TUs):

| Report | Measured | Pre-registered baseline | Note |
| --- | --- | --- | --- |
| `retainable` | **591** | 589 pins | nearly every pin has agreeing predecessors at the join |
| `must_spill` | **0** | — | no pin is forced to memory by a full pool |
| `poolfull_after` | **952** | 471 pool-full sites | retention keeps registers busy and doubles it |
| `net` | **220** | criterion ≥300 | `2×591 − 2×(952−471)` |
| cross-check | 248 | — | `2×(sim_r 4,203 − cur_r 4,079)` |

`retainable` exceeds the 589 baseline by 2 because the simulation also finishes a few functions
the real pass bails out of early; the 0.3% difference does not affect the verdict.

Two independent formulas give 220 and 248; both are below 300. **The mechanism is clear**: retention
does turn 591 pins (≈ all 589) into pooled values, saving 1,182 instructions, but holding registers
across boundaries pushes later pushes into a full pool, so pool-full goes 471 → 952 and pays back
962. The net is 220 instructions = **1.79%**, short of the 2.4% bar.

The distribution is very concentrated: 306 of the 591 retainable pins (more than half) come from a
single TU, `stm32f4xx_hal_dma_ex.c`, followed by `hal_rcc.c` 123, `hal_rcc_ex.c` 36, `ll_utils.c` 28
and `hal_dma.c` 26. Even on the most optimistic reading the gain sits in three or four large
functions, not in the corpus as a whole.

**Basis caveat**: only **17** of the 95 TUs produce a non-zero reading; the other 78 produce none.
The root cause was found this round and it is **not a compiler defect**:
`examples/ark_test/Core/Inc/stm32f4xx_hal_conf.h` enables only seven modules
(`HAL_GPIO/EXTI/DMA/RCC/FLASH/PWR/CORTEX_MODULE_ENABLED`), so every other peripheral driver source
sits entirely inside `#ifdef HAL_xxx_MODULE_ENABLED` and is an empty translation unit after
preprocessing - five lines of `.s` (`.thumb` / `.text` / `.file` ...) and a 20-byte `.o`. So "12,304
instructions from about 18 TUs" is a property of the corpus configuration, not missed compilation;
"95 TU" is a nominal basis and every percentage here divides by 12,304, not by TU count.

**Verdict (per the frozen §5 criteria)**: `net = 220 < 300` ⇒ **S7b is not started; the value stack
keeps its linear scan + boundary flush**. §4.2/§4.3 stay as design records and are not implemented.
This is a negative result, not an unfinished one: the bound (1,178) and the real net (220) differ by
5.4×, and the gap is exactly the `poolfull_after` term §4.1 already named — it now has a measured
number behind it.



### 4.2 S7b: implementation (new switch, off by default)

A new switch `-fopt-vstack-cfg` (macro `ARKCC_FEATURE_OPT_VSTACK_CFG`, host 1, on-board 0, off by
default). With the switch **off**, `ark_vstack_function()` must be byte-identical to today
(OFF IS OFF). With it **on**, vstack solves over the CFG and only values whose owning register
agrees at the join cross the boundary; everything else materialises as it does today. The cropping
table (`include/arkcc_config.h`) and the by-name rejection table in `src/main.c` (`C3900U`) each
get one line — the fixed cost of every new switch.

### 4.3 S7c: retention across calls (registered, no separate slice)

Take `BL`/`BLX` out of the boundary set (`r5`/`r7` are callee-saved). The bound is **10
instructions**, not worth a slice of its own; after S7b lands, if the structure makes it free
(splitting the boundary test into "label/branch" and "call" masks), do it then under the same
criteria.

## 5 Criteria (frozen, not to be changed before implementation)

> **S7a verdict (executed)**: `net = 220 instructions` (1.79%) < 300 ⇒ closed under the second
> bullet of this section; the value stack keeps its linear scan. Readings and reasoning: §4.1.1.

**S7a** (decides whether S7b is started at all):

- `net ≥ 300 instructions` (**2.4%** of the current count) ⇒ proceed to S7b;
- `net < 300` ⇒ **close it**; the value stack keeps its linear scan and this document becomes a
  negative result.

**S7b** (decides whether the switch stays):

- net **≥ 3% (≥ 370 instructions) at nineteen switches and the byte count does not grow** ⇒ land it;
- 1%–3% ⇒ register only; keep the switch but document its magnitude in the READMEs;
- **< 1% ⇒ revert the switch** (code included; do not leave it in the tree).

**Correctness (all four, missing any one is a failure)**:

1. all 95 TUs compile, and the nineteen-switch instruction/byte counts in this document are updated
   honestly;
2. `tests/arm_exec` passes 39 cases with **0 failures** (execution-level reconciliation);
3. the five existing gates are green: `run_peep_tests.py`, `run_addr_tests.py`,
   `run_vreg_tests.py`, `run_cmat_tests.py`, `run_litpool_tests.py`, plus
   `stm32_build_check.py --layout both` PASS on both layouts;
4. **OFF IS OFF**: with the switch off, the 95 TU outputs are **byte-identical** to today's; with
   it on, the built-in assembler's encodings are cross-checked against GNU `as` at least for the new
   fixtures.

New fixtures (mandatory, and written **before** S7b):

- a nested branch with two joins (the same value sits in different pool registers on three paths);
- a loop back edge (the value is redefined on the back edge, so the join must spill);
- a value still used after a call (the S7c shape; expect "spill" for now);
- a many-predecessor label (`edges > 2`; all 115 label pins in the corpus have 2 predecessors, so
  the fixture must be harsher).

## 6 Anti-false-green control

One control, frozen: a build with the switch **on** but with a forced flush at every block end
(compile-time probe `ARKCC_VSTACK_CFG_FORCEFLUSH`) must produce **byte-identical** output to today
on all 95 TUs.

What this proves is "the gain comes from join retention and nothing else", rather than "after
rewriting vstack we happened to drop two instructions". Without this control no positive reading is
trustworthy — `docs/VREG.md` §18.3 was already bitten once by reading the wrong slot for `kind`
(garbage `kind` values), which shows how easy it is to measure a number that merely looks right.

## 7 What is not allowed (frozen)

- Do not report `retainable × 2` as the gain (that is §18.3's 1,178, and it is not a gain);
- do not relax "every predecessor agrees" in order to pass the criteria (relaxing it produces wrong
  code, violating "rather fail loudly than answer wrongly");
- do not reverse-engineer rules from "what armcc's instruction mix looks like" (`docs/BOUNDARY.md`
  §3 already rules that out);
- do not touch the seven frozen gates of §5 or the F1–F4 falsifiers of `docs/VREG.md`;
- do not flip `-fopt-vstack`'s default on as a side effect (the cropping profile stays: host 1,
  on-board 0).

## 8 Budget and scheduling

- One full reconciliation = 95 TUs compiled twice (switch off / switch on) + five gates +
  `arm_exec` + `--layout both`; by existing measurements this is **on the order of a dozen minutes**
  of machine time, not of human time.
- By the repository's existing rule: such tasks (over 10 minutes) must not be started before
  **08:15** on weekdays; if the machine shuts down mid-run, resume per TU from on-disk checkpoints.
- S7a is a pure read-only measurement (probe removed afterwards, never committed), so it can run
  first; S7b's implementation and gates belong to the next round.

## 9 Relation to the existing documents

| Document | Relation |
| --- | --- |
| `docs/RA_VSTACK.md` | This document changes the solving unit it describes (linear scan → per block); the in-block rules and the seven safety rails are all inherited |
| `docs/VREG.md` §18.3 / §18.4 | The direct predecessor: 589 pins / mask table / cheap version 0 / full version 1,178 / r8–r11 net negative |
| `docs/BOUNDARY.md` §5.6 | The same fact stated structurally (the value-stack machine is pinned by boundaries) |
| `docs/OPERAND_ALLOC.md` | The template for a pre-registration document (§0 what it answers → measurement → slice → conflict → frozen criteria → falsifiers) |
| `docs/LIVE.md` | The repository's existing CFG + fixed-point implementation (`-fopt-live`); S7a's graph construction should reuse its conventions |
