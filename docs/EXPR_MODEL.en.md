# Expression Evaluation Model (0.9.2 preregistration, S9)

English | [中文](EXPR_MODEL.md)

> In one line: **today's emitter makes a three-hop round trip for every intermediate value of every
> C expression — born in `r0`, moved into the pool, spilled to the frame when needed; the twenty-six
> text rules of 0.9.1 have already shaved everything shavable off that round trip, and what is left
> can only be taken by changing the emission model itself.**
>
> Status: **S9a read-only measurement done; S9b (`-fopt-expr`) implemented and measured
> at −16 instructions = 0.137%, withdrawn per the §6 criterion (see §9)**. Criteria and slicing are
> in §5/§6.
> See also: [BOUNDARY.en.md](BOUNDARY.en.md) (the structural-gap account), [RA_MODEL.en.md](RA_MODEL.en.md)
> (the negative result of the allocator route), [VSTACK_CFG.en.md](VSTACK_CFG.en.md) /
> [VREG.en.md](VREG.en.md) (what the text layer already did).

---

## 1 What the gap looks like now (26-flag accounting, 2026-11-25)

95 TUs, all 26 `-fopt-*` on: **11,666 instructions / 396,986 B**, against armcc 5.06u7 `-O2` at
**5,619 instructions / 13,920 B** ⇒ **2.08× instructions / 2.85× bytes**. Full per-class table
(`D:/tmp/bm/cmp26_ac.py`; the classifier is the same one `BOUNDARY.en.md` §2 uses, rows in the
classifier's output order):

| Class | arkc | armcc | Delta |
| --- | ---: | ---: | ---: |
| `MOV` immediate | 1,193 | 389 | **+804** |
| `MOVW`+`MOVT` | 338 | 0 | **+338** |
| Literal pool `LDR rX, .Llit_*` | 705 | 391 | +314 |
| `MOV` reg-to-reg | 1,268 | 214 | **+1,054** |
| `PUSH`/`POP` | 1,169 | 156 | **+1,013** |
| Frame access `[r6, #n]` | 976 | 45 | **+931** |
| Other memory (other bases) | 1,741 | 1,207 | +534 |
| `[sp, #n]` | 0 | 46 | −46 |
| Arithmetic `ADD/SUB/...` | 772 | 302 | +470 |
| `CMP`/`CMN`/`TST`/`TEQ` | 675 | 479 | +196 |
| Branches | 1,534 | 1,284 | +250 |
| `BL`/`BLX` | 182 | 153 | +29 |
| Logic | 732 | 394 | +338 |
| Shift | 212 | 309 | −97 |
| Extend/reverse | 81 | 202 | −121 |
| `IT` | 40 | 0 | +40 |
| Barrier/system | 20 | 22 | −2 |
| Other | 28 | 26 | +2 |
| **Total** | **11,666** | **5,619** | **+6,047 (2.08×)** |

**The first four classes (`MOV` immediate, `MOV` reg-to-reg, `PUSH`/`POP`, frame access) add up to
4,606 instructions = 39.5% of the whole**; armcc spends only 804 on the same four ⇒ **overrun of 3,802
= 32.6%**. Counting the two constant-transport columns as well (`MOVW`+`MOVT` 338 + literal pool 705),
constant handling alone costs 1,043 instructions.

Those 3,802 are exactly the price of the model fact "every intermediate value goes through a register
or through memory once"; `docs/BOUNDARY.en.md` §3 has pointed here for a long time. **Note that arkc
is already 218 instructions *below* armcc on shift/extend**, so this is not a blanket lag — it is a
single-point overrun in four value-transport classes.

## 2 Why the text layer cannot take these 3,802

The 0.9.1 round finished everything the text layer can do, and every item has a reading:

| Closed family | Result |
| --- | --- |
| Nine residual shapes (duplicate load/materialise, idle `PUSH`/`POP`, `STR→LDR` round trip, `MOV` round trip/chain) | 167 = 1.42% (11,766 basis), all retired under F1 |
| Address-chain folding (base built but not folded into the use) | 189 candidates, 100 realised, residual shapes at zero (`RA_MODEL.en.md` §4.1b) |
| Frame-slot registerisation ceiling | L1 133 / L2 32 / L3 718, net cross-call gain under S7a only 220 instructions |
| Constant pool (32-bit `MOVW`+`MOVT` → `LDR`) | landed, 705 instructions / −1,134 B |

**The part text rules structurally cannot touch was measured separately this round on the 26-flag
corpus (`D:/tmp/bm/r0shapes.py`)**:

| Shape | Hits | Note |
| --- | ---: | --- |
| `MOV rD, r0` (`D≠r0`) | 428 | every site where a value is moved out of `r0` |
| ├ the immediately preceding instruction writes `r0` | **314** | direct reading of "the result is born in `r0`, then moved into the destination register" (upper bound; includes call arguments and return values that cannot be dropped) |
| `MOV r0, rX` | 305 | every site where a value is moved into `r0` |
| └ the next instruction is an arithmetic/logic/shift reading `r0` | **124** | upper bound on operand forwarding (`MOV r0,rX` + `op rD,r0,rY`) |

The two families are 2.7% and 1.1% — **below the F1 threshold (under 5% is registered, not chased),
so retiring them was the text layer's own verdict, not an oversight**. And they are precisely what
proves the model's shape: the value **has to** pass through `r0`, and the text layer can only watch.

The root cause is not "the rules are not good enough": **the three hops are fixed at the moment of
emission**. In the stack-machine IR every expression node really pushes onto the stack, the backend
emits line by line, `r0` is the only work register, and the pool (`r4`/`r5`/`r7`) merely trades a
stack round trip for a register round trip. The text layer only ever sees transfers that have already
been decided; it can delete adjacent ones and merge pairs, but it **cannot decide which register a
value is born in**. `docs/RA_MODEL.en.md` §3.1 has verified this: `IrInst` has no vreg field, and
there is no IR dump.

## 3 Target model: three-address evaluation inside a statement

In one line: **buffer the IR of one expression statement, build the value graph, schedule it into
registers in Sethi–Ullman order — no more `r0` round trip, no more pool shuttling.**

```
Today (one a*b+c statement)              Target (the same statement)
  POP  r1        ; right operand          MUL  r4, r0, r1      ; computed straight into the destination
  POP  r0        ; left operand           ADD  r5, r4, r2
  MOV  r1, r7    ; vstack: pool -> r1     ...
  MOV  r0, r5    ; pool -> r0
  MUL  r0, r0, r1
  MOV  r5, r0    ; result back to pool
  ...
```

- **Buffer unit**: the IR of one statement (between `IR_LINE`s, or up to an `IR_LABEL`/`IR_JMP`/
  `IR_CALL`). Nothing is buffered across statements, so liveness, `volatile` ordering and barrier
  position all stay exactly as today.
- **Registers**: `r0–r3` for leaves and temporaries, `r4`/`r5`/`r7` for in-statement destinations,
  `r6` keeps the frame base, `r8–r11` keep serving callee-saved long-lived values (as today).
- **Overflow**: when in-statement registers run out, spill one slot (`[r6, #o]`), the same slot set as
  today; at statement end the result is written back where it belongs (frame slot or pool).
- **Untouched**: call-argument placement, `volatile` ordering, `DMB`, return and epilogue, and the
  control-flow structure. None of these is part of "evaluation"; the buffer flushes on sight of them.

## 4 Ceiling: even done perfectly this does not reach 1.0×

- Eating all 3,802 overrun instructions ⇒ **7,864 instructions = 1.40×**;
- Then eating, out of the arithmetic delta (+470, address recomputation) and the memory delta (+534),
  the portion that is "recompute the address every time", roughly another 500–700 ⇒ **around 7,200 =
  1.28×**;
- To actually reach 5,619, each of the four classes must be cut close to armcc's level, which means
  **replacing the emission model as a whole with a register machine** (expression + allocation +
  addressing + branching changed together), not something one slice can deliver.

Frozen conclusion: **S9 is the step that turns 2.08× into 1.28×–1.40×, not the step that beats
armcc.** Beating armcc either means changing all four models together (a new project), or accepting
the ceiling of text layer plus local model surgery.

## 5 Slicing

### S9a Ceiling and corpus measurement (this document, done)

- Per-class delta (§1), families already closed in the text layer plus the `r0` residual shapes (§2),
  ceiling (§4).
- Reproduce: `D:/tmp/bm/cmp26_ac.py` (full per-class table), `D:/tmp/bm/r0shapes.py` (the two `r0`
  families), `remeasure.py` (totals).

### S9b Three-address emission inside a statement (implemented and withdrawn, see §9)

- Switch: `-fopt-expr` / `-fno-opt-expr`, config macro `ARKCC_FEATURE_OPT_EXPR` (host 1, board 0,
  **off by default**); the trim table and the `C3900U` by-name rejection table gain one row each
  (same convention as the twenty-six of 0.9.1).
- Scope: only **within a single statement**; control flow, calls, `volatile` and barriers always flush
  back to today's path.
- Buffer failure (an IR op it does not understand) ⇒ re-emit the whole statement with today's bytes,
  **never apply partially**.

### S9c Cross-statement and short branches inside expressions (registered, not scheduled)

`?:`, `&&`, `||` short-circuit evaluation is block-splitting today; bringing them into the buffer
requires "in-block liveness" to exist first (the delta of `RA_MODEL.en.md` §4.1b is stuck exactly
there).

## 6 Criteria (frozen, unchanged before implementation)

**Gain** (26 flags, 95 TUs, baseline 11,666 / 396,986):

- net cut **≥ 10% (≥ 1,167 instructions) with bytes not increasing** ⇒ land it;
- 5%–10% ⇒ register only, keep the switch but off by default, state the magnitude in the README;
- **< 5% ⇒ withdraw the switch** (revert code too) — per the §4 ceiling, missing 5% would mean even
  the "inside a statement" layer does not hold.

**Correctness (all five, any one missing is a failure)**:

1. all 95 TUs compile, readings updated honestly;
2. `tests/arm_exec` full corpus **0 failures**;
3. all existing gates green: `run_addr_tests.py` / `run_vstack_tests.py` / `run_vreg_tests.py` /
   `run_cmat_tests.py` / `run_peep_tests.py` / `run_litpool_tests.py` / `run_bitmask_tests.py`, plus
   `tools/stm32_build_check.py --layout both` PASS on both layouts;
4. **OFF IS OFF**: with the switch off, the 95-TU output is byte-identical;
5. **Trimming**: in an `ARKCC_PROFILE=STM32_MIN` build the switch is 0, `-fopt-expr` is rejected by
   name, and the default-profile footprint is unchanged.

## 7 Anti-false-green controls (frozen)

1. **Force the old path**: a compile-time probe `ARKCC_EXPR_FORCE_LEGACY` makes the buffer fall back
   to today's line-by-line emission for every statement ⇒ the output must be **byte-identical to
   today**. That proves the gain comes from scheduling, not from "the rewrite happened to produce two
   fewer instructions".
2. **No counting a drop in `MOVREG` as gain**: deleting one `MOV` often buys one `LDR` (the 1,178 in
   `VREG.en.md` §18.3 is this kind of number). Judge only on the **two-sided reading of instruction
   count and byte count**.
3. **Relation to `-fopt-vstack`**: S9 eats vstack's territory; the two together **must not be worse
   than S9 alone** (vstack becoming a no-op is fine, undermining each other is not).

## 8 Forbidden moves (frozen)

- Do not back-derive rules from armcc's instruction mix (`BOUNDARY.en.md` §3);
- Do not claim "allocation was done on the IR" without an IR dump (`RA_MODEL.en.md` §3.1);
- Do not change evaluation semantics for consistency: `volatile` ordering, sequence points, and `DMB`
  pairing positions stay untouched;
- Do not extend in-statement buffering across basic blocks unless in-block liveness is proven first
  (`RA_MODEL.en.md` §4.1b).

## 9 S9b measurement and withdrawal (2026-11-25)

**Verdict up front**: `-fopt-expr` was implemented per §5 and measured per §6, and it removes
**16 instructions (0.137%)** — landing in §6's "< 5% ⇒ withdraw the switch (revert the code too)".
The switch and its four config hooks have been reverted; after a rebuild `arkcc.exe` is back to
**11,666 instructions / 396,986 B** on the 26-flag corpus.

**Measurement** (26 flags, 95 TUs; script `D:/tmp/bm/s9b_measure.py`, raw readings
`D:/tmp/bm/s9b_res.json`):

| Configuration | Instructions | Bytes |
| --- | ---: | ---: |
| 26 flags (no `-fopt-expr`) | 11,666 | 396,986 |
| 26 flags + `-fopt-expr` | 11,650 | 396,706 |
| **Delta** | **−16 (0.137%)** | −280 |

Only 2 of the 95 TUs changed: `stm32f4xx_hal_gpio.c` −12 and `stm32f4xx_hal_cortex.c` −4; zero grew;
errs=0, danglingTUs=0.

**Why so small (root cause, measured)**: counting the surviving `PUSH`/`POP` per TU in the output with
`-fopt-expr` on (`stm32f4xx_hal_dma_ex.c` 394, `hal_rcc` 137, `hal_dma` 133) shows the residue is
**materialising a comparison result plus a conditional jump** (`CMP` / `ITE EQ` / `MOVEQ r0,#1` /
`MOVNE r0,#0` / `PUSH {r0}` / `B .L…`) and **constant fill after a branch** (`MOV r0,#1` /
`PUSH {r0}`). The first belongs to `-fopt-cbranch`, the second to inter-block value passing; neither
is the "arithmetic inside one statement" that §5 scoped. In other words, `a+b` and `a+b*c` inside a
statement were already taken by `-fopt-pair` / `-fopt-vstack`, leaving S9b only scraps.

**Verdict**: `statement_local_three_address_insufficient`.

- This refutes **only** the "three-address inside a statement" layer, not the §4 target model;
- of the 4,606 value-transport instructions in §1, **the part attributable to intra-statement
  arithmetic is close to zero on this corpus**;
- the 1.40×/1.28× ceiling of §4 **cannot** be cashed by this layer — the delta lives elsewhere.

**Next levers (re-ordered by measurement, registered not promised)**:

1. **Comparison-result materialisation** (`CMP`/`ITE`/`MOVEQ`/`MOVNE`) — the coverage of
   `-fopt-cbranch`. Measured at only **120 instructions = 1.0%** (`ITE` 40, `MOVEQ` 36,
   `MOVNE` 36, eight others), so **not** a major gap; registered, not the main lever;
2. **Inter-block value passing** (now quantified, below) — the prerequisite of S9c in §5, i.e.
   in-block liveness in `RA_MODEL.en.md` §4.1b;

   > Measured on the same 26-flag output: **single-register `PUSH`/`POP` round trips total 641
   > instructions = 5.5%** (`PUSH {r0}` 498, `POP {r0}` 96, `POP {r1}` 42, five others), 78% of
   > them r0. The shape is a **join of nested conditional expressions**: every arm ends with
   > `MOV*/PUSH {r0}` + `B .Ljoin` and one `POP {rY}` sits at the outermost join — e.g.
   > `stm32f4xx_hal_dma_ex.c` alone has 317 `PUSH {r0}` against only 38 `POP {r0}`, the rest
   > matching `POP {r1}` many blocks further out. Because the pop can be dozens of blocks away,
   > **this is not peephole-solvable**; it needs cross-block value liveness. Removing all 641
   > gives about 11,025 instructions = 1.96x.
3. the 931-instruction frame-access gap (976 vs 45), already judged un-cashable by an ordinary
   allocator in `RA_MODEL.en.md` — a structural difference.

**Evidence kept**: the pre-withdrawal implementation patch is at `D:/tmp/bm/s9b_expr_retract.patch`
(391 lines, not in the repo).
