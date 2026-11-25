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

   > Measured on the same 26-flag output: **501** single-register `PUSH` and **140**
   > single-register `POP` (`PUSH {r0}` 498, `POP {r0}` 96, `POP {r1}` 42, `{r2}`/`{r3}` one
   > each). A per-function LIFO stack replay splits them in two: **355 `PUSH {r0}` are never
   > popped before the frame restore** (= 3.0%, dead stores that need no replacement), and only
   > the remaining **~140 pairs** are real round trips. The shape is a **join of nested
   > conditional expressions**: every arm ends `MOV*/PUSH {r0}` + `B .Ljoin` with one `POP {rY}`
   > at the outermost join — `stm32f4xx_hal_dma_ex.c` alone has 317 `PUSH {r0}` against only 62
   > single-register POPs, the rest landing on a further-out `POP {r1}` or simply thrown away by
   > `MOV sp, r6`. **Full accounting and the preregistration are in §10.**
3. the 931-instruction frame-access gap (976 vs 45), already judged un-cashable by an ordinary
   allocator in `RA_MODEL.en.md` — a structural difference.

**Evidence kept**: the pre-withdrawal implementation patch is at `D:/tmp/bm/s9b_expr_retract.patch`
(391 lines, not in the repo).

## 10 Cross-block value passing (S10 preregistration, 2026-11-25)

The §9 verdict points here, but §9's 641 is a **mixed** number. After a per-function LIFO stack
replay (`D:/tmp/bm/stacksim.py`, read-only) the account is:

| Shape | Count | Share | Cashable |
| --- | ---: | ---: | --- |
| `PUSH {r0}` never popped before the frame restore (dead store) | **355** | 3.0% | delete, **no replacement needed** |
| live pair, `POP {r0}` (the arm already holds it in r0) | 96 | — | both instructions go, net 2 |
| live pair, `POP {r1}`/`{r2}`/`{r3}` | 44 | — | pop becomes one arm-end `MOV`, net 1 |

Ceiling: **355 + 96x2 + 44 = 591 instructions = 5.1%** ⇒ 11,666 -> 11,075 = **1.97x**.

**Why dead stores exist**: the emitter pushes "the value this arm produced" onto the machine stack
for the join to read, and some joins never read it (the enclosing expression got the value another
way), so the `PUSH` survives until `MOV sp, r6` throws the whole frame away. There is **no `[sp, #n]`
access anywhere** in the 0.9.1 output (armcc has 46), so "never popped" equals "never read" — an
equivalence that is decidable on today's output.

**Why a peephole is not enough**: the live half's `POP` sits dozens of blocks away (`hal_dma_ex`
has 317 pushes against 62 single-register pops), so which register an arm must end in depends on
the outer pop's target — that is **cross-block value liveness**, the S9c prerequisite of §5.

### 10.1 Slicing

- **S10a delete dead stores** (first: biggest and safest): per-function LIFO replay, delete every
  single-register `PUSH {rR}` that is never popped before `MOV sp, r6` and where the function has no
  `[sp` access. Whole-function skip conditions: a `sub sp` (VLA/`alloca`), a `setjmp`/`longjmp`
  call, inline assembly, an exception/`__svc` frame on the stack.
- **S10b join-point register merge**: for live pairs, rewrite `PUSH {r0}` + `B .Ljoin` as an
  arm-end `MOV rY, r0` (when `rY == r0` just delete both) and drop the `POP {rY}` at the join.

### 10.2 Criteria (frozen; the ceiling is only 5.1%, so the bar is rescaled and must not be mixed with §6's 10%)

26 flags, 95 TUs, baseline 11,666 / 396,986:

- net cut **>= 4% (>= 467) with bytes not increasing** ⇒ land it;
- 2%-4% ⇒ register only, switch kept, off by default;
- **< 2% ⇒ withdraw the switch (revert the code too)**.

The five correctness conditions are the same as §6 (95 TUs compile / `tests/arm_exec` 0 failures /
the seven existing gate scripts + `tools/stm32_build_check.py --layout both` / OFF IS OFF /
`-fopt-*` rejected by name under `ARKCC_PROFILE=STM32_MIN`).

### 10.3 Anti-false-green (frozen)

1. **Balance self-check**: per function, `pushes - popped slots` must equal the baseline difference
   minus the number deleted (proves the stack discipline still holds);
2. **Slot trace self-check**: every deleted `PUSH` records function name, index and depth; the replay
   asserts that no POP lands on that depth and no `[sp` access exists in that function. The check must
   be able to **fire** (plant one `PUSH` that should be kept and confirm it is reported);
3. **Never count "fewer PUSHes" as gain**: only the two-sided instruction/byte reading counts, and the
   image must not grow;
4. **Never touch multi-register frame `PUSH`/`POP`** (that is ABI, not this pass).

### 10.4 Forbidden moves

- Do not call S10 "cross-block liveness done" — it covers only the stack round trip;
- Do not try it on VLA/`alloca`/`setjmp` functions (the stack is not LIFO there, the replay is invalid);
- Do not replace `PUSH {r0}` with `STR r0, [sp, #-4]!` to make numbers (more bytes — cheating).

### 10.5 Measurement and verdict: the ceiling was refuted (2026-11-25)

What got implemented is not §10.1's linear LIFO replay but a CFG-decided merge: **for every
`PUSH {rX}`, if every path leaving it reaches a `POP {rX}` and no instruction in between writes
rX, delete the pair (and the pop at the join)**. The account therefore differs from §10's table:

- **§10's 355 dead stores were an artefact of the linear replay.** A diamond's two arms each
  `PUSH {r0}`, and the merge `POP {r0}` is *after* the branch in the text, so a linear scan that
  assumes "only this path" counts every "value already in r0" as a dead store. **Once the CFG is
  seen, only 3 lines in the whole corpus are real dead stores**, so S10a produces almost nothing.
- What actually pays is S10b's **same-register** case: the `POP {rX}` target is the register the
  arm already holds, so both the `PUSH` and the `POP` disappear with no replacement.
  `HAL_DMAEx_MultiBufferStart_IT` in `stm32f4xx_hal_dma_ex.c` alone loses 286 pushes + 28 pops =
  **314 lines**; over 95 TUs the corpus total is **331 lines**.

Readings (26 flags, 95 TUs, same machine, same command line):

| Arm | Instructions | Bytes |
| --- | ---: | ---: |
| 26-flag baseline | 11,404 | 392,907 |
| + `-fopt-spill` | 11,073 | 388,303 |
| delta | **-331 (-2.90%)** | **-4,604 (-1.17%)** |

**Verdict: per §10.2 this is the 2%-4% bucket => register it, keep the `-fopt-spill` switch, leave it
off by default.** It is not a landing (short of 4%) and not a withdrawal (well above 2%). §10's 5.1%
ceiling is **void**; the real cashable amount is 2.90% -- the most valuable correction of this round,
and the ceiling was wrong precisely by counting live values on both sides of a branch as dead stores.

**What was not done** (left as debt, explicitly): the 44 `POP {r0}` -> `POP {r1}` cases need the arm
tail rewritten to a single `MOV rY, r0` (net 1 instruction) -- that *changes* instructions instead of
*deleting* them, so it is out of scope here.

**Implementation boundaries** (each one is a code comment and each is held by
`tests/run_spill_tests.py`):

- It rides on the CFG/liveness machine `-fopt-live` builds, so `ARKCC_FEATURE_OPT_SPILL` is forced
  to 0 under `!ARKCC_FEATURE_OPT_LIVE` or `ARKCC_PROFILE_STM32_MIN`, and the driver refuses the flag
  by name (`C3900U`);
- **per-function bail**: any `[sp` access, any non-constant `sp` adjustment, any IT block that writes
  `sp`/`PUSH`/`POP`, an unreachable branch target, or two paths reaching a join at different depths;
- `MOV sp, rB` is treated as an **absolute restore**: the frame base is pinned by the straight-line
  prologue (`MOV rB, sp`, written exactly once in the function), which is what makes "depth above the
  frame is unknown" recoverable -- without it the pass never fires;
- **self-check**: the number of deleted lines must equal (paired pushes + paired pops), and a zero on
  either side means nothing is written back;
- gate: `tests/run_spill_tests.py` / `make test-spill` (OFF IS OFF, delete-only, every removed line is
  a PUSH/POP, the image never grows, the two anti-false-green shapes stay byte-identical, unicorn
  agrees on four arms, and a cropped build refuses the flag by name).

### 10.6 Follow-up measurement and verdict: a BIC is not a branch (2026-11-25)

After §10.5 landed, the corpus still had 418 PUSH / 421 POP left. This round started by
**censusing the bail reasons** instead of going straight at the 44 `POP {r0}` -> `POP {r1}`
cases guessed at the end of §10.5.

**Method** (throw-away instrumentation, removed before commit, never shipped): every
`return 0` in `ark_spill_function` printed `SPILLBAIL <reason> np=<candidate single-register
PUSH lines in this function>`, and the end of the function printed `SPILLOK`; 95 TUs, 26
flags. **Before the fix** the census read:

| Reason | Functions | Candidate PUSH lines |
| --- | ---: | ---: |
| `selfcheck` (`npair == 0`, nothing to delete) | 174 | 59 |
| **`tgt-missing` (branch target not found)** | **29** | **101** |
| `depth-disagree` (join reached at two depths) | 5 | 6 |
| passed (deletions landed) | 4 | 335 (330 deleted) |

**Root cause**: 93 of the 101 `tgt-missing` lines sat in two TUs
(`stm32f4xx_hal_rcc.c` 52, `stm32f4xx_hal_dma.c` 41), and the "branch" it printed was

```
BIC r7, r7, #0x10000
```

The line `if (L == 3) return 2;` in `lv_branch_kind()` exists for `BNE/BEQ/BLT/...`, but it
catches *every* three-letter mnemonic starting with `B`; `BIC`/`BFI`/`BFC` are data-processing
instructions whose names merely start with `B`. Two costs followed:

- **spill side**: `#0x10000` was looked up as a label, not found, and the whole function
  bailed -- the conservative "rather miss than miscompile" rule was amplified by a spelling
  test, and the entire function's round-trip analysis was thrown away;
- **live side**: the block was read as a conditional branch with an unknown target, `bsx = 2`
  (every register treated as read) and the block ended there -- every `BIC` silently cost a
  slice of liveness precision.

**Fix**: accept only the real two-letter condition suffixes
(`EQ NE CS HS CC LO MI PL VS VC HI LS GE LT GT LE AL`). `BLT/BLE/BLS` stay branches (their
suffixes are in the table); `BIC/BFI/BFC` no longer are.

**Measured** (95 TUs, same machine, same command line):

| Arm | Before | After |
| --- | ---: | ---: |
| 25 flags | 11,404 / 392,907 | **11,375 / 392,476** (-29 insns / -431 B) |
| 26 flags (+`-fopt-spill`) | 11,073 / 388,303 | **11,044 / 387,872** (-29 / -431) |
| spill's own delta | -331 / -4,604 | -331 / -4,604 (unchanged, still 2.90%) |

**Verdict**: a **precision fix** in `lv_branch_kind`, shared by `-fopt-live` and
`-fopt-spill`; not a new optimisation and not a criterion reversal. `make test-spill` is green,
and so are `test-live`/`test-option`/`test-slotreg`/`test-addr`/`test-coalesce`/`test-deadpush`/
`test-vreg`/`regalloc`/`test-arm-exec` (0 failures).

**S10 is saturated here**: after the fix only 166 candidate lines remain, 152 of them on
"cannot be proven" (`npair == 0`, which should not be deleted anyway) and 14 on disagreeing
depths; **there is no second `tgt-missing` shape**. Most of the remaining 418 pushes are the
prologue `PUSH {r5,r6,r7,lr}`, which is outside this pass. Going further needs a different
mechanism (S10b's `MOV` form, or S8c's cross-block residency), not this section.

**Sibling debt (registered, not touched this round)**: `pp_r6_stops()` also uses
`mn[0] == 'B'` to end its r6 window early on `BIC`/`BFI`. That direction is conservative
(it only loses a rewrite opportunity, never the answer), and moving it needs its own
preregistration ("a longer window still only performs an equivalent register rename"), so
this round leaves it registered only.

**Anti-false-green**: `tests/run_spill_tests.py` gains a `bicmix` fixture that first asserts
"this source really makes the back end emit a `BIC`" and only then "the diamond in the same
function is still deleted"; the second check alone would silently pass as the back end drifts.
The pre-fix instrumentation reading (`SPILLBAIL tgt-missing ... mn=BIC op2=[#0x10000]`,
29 functions) is the measurement behind this entry.
### 10.7 Census of the remaining text-level candidates (2026-11-25)

With the BIC fix in (26 flags: 11,044 insns / 387,872 B), the open question is **how much of
the remaining 6,068-instruction gap still lives in the text layer**. To answer it the same
95 TUs were histogrammed by mnemonic and compared category by category against
`arm-none-eabi-gcc 13.2.1 -O2` on the same corpus (`cats.py`; counting only lines that start
with whitespace and do not start with `.`).

| Category | arkc | gcc -O2 | Diff |
| --- | ---: | ---: | ---: |
| MOV | 2,319 | 510 | **+1,809** |
| LDR | 2,229 | 1,030 | **+1,199** |
| BRANCH | 1,383 | 496 | **+887** |
| ADD/SUB | 768 | 147 | +621 |
| CMP | 675 | 256 | +419 |
| PUSH | 418 | 55 | +363 |
| POP | 421 | 98 | +323 |
| MOVW/MOVT | 339 | 17 | +322 |
| STR | 965 | 674 | +291 |
| LOGIC | 645 | 428 | +217 |
| CBZ/CBNZ | 151 | 37 | +114 |
| MVN | 87 | 3 | +84 |
| MUL/DIV | 27 | 21 | +6 |
| IT | 40 | 45 | -5 |
| SHIFT | 212 | 224 | -12 |
| CALL/BX | 182 | 296 | -114 |
| other | 183 | 639 | -456 |
| **Total** | **11,044** | **4,976** | **+6,068** |

The top three categories (MOV / LDR / BRANCH) account for +3,895, i.e. **64%** of the whole
gap, and none of them is reachable from the text layer alone: most MOVs are argument passing
and write-back from the evaluation model, most LDRs are "each variable is re-read from its
frame slot", and most branches are conditions recomputed statement by statement (no
cross-statement condition reuse). Below is the breakdown and, per candidate, the upper bound
of what a *text-only* rewrite could recover.

**MOV breakdown** (`movscan.py` / `movpairs.py`): 1,090 immediates (376 `#0`, 270 `#1`),
1,044 register copies, 185 stack-base moves (`MOV rB, sp` 118 = number of framed functions,
`MOV sp, rB` 67). The hottest register copies are `MOV r0,r5` 174, `MOV r1,r7` 158,
`MOV r5,r0` 137, `MOV r7,r0` 93, `MOV r8,r0` 68 -- all traces of "compute into r0, then move
into/out of a variable slot or argument position", i.e. exactly what §3's target model
(three-address evaluation within a statement) is meant to remove.

**LDR/STR shapes** (`ldrscan.py`): `[rX],#imm` 1,497 (peripheral accesses through r5),
literal-pool loads 809, `[r6],#imm` 644 (frame slots), `[rX]` 214, register offset 30.

**Upper bounds of the five text-level candidates** (each is "do only this rewrite, no
evaluation-model change"):

| Candidate | Upper bound | Share of 26-flag total |
| --- | ---: | ---: |
| Redundant literal reload elimination (reuse `LDR rX, .Llit_*` while still valid) | 75 / 809 (9.3%) | 0.7% |
| `STR` to a slot never `LDR`-ed in the same file (`cands.py`) | 67 | 0.6% |
| `CMP rX,#0` + `BEQ/BNE` -> `CBZ/CBNZ` (`brscan.py`) | 58 | 0.5% |
| `B` to the immediately following label (`brscan.py`) | 48 | 0.4% |
| `MOVW #imm` + `UXTH` on the same register (`cands.py`) | 6 | 0.05% |

**Verdict: the text layer is measured out.** The five bounds sum to 254 lines (2.3%), the
largest single one is 0.7%, and no single item reaches the 4% tier of §10.2; under the frozen
rule they can only be *registered*, not landed as an optimisation. On top of that, the first
two (literal reuse, dead-slot STR) are tightly coupled to the register allocation result, so a
pass for either costs about as much as an evaluation-model change while returning an order of
magnitude less.

**The remaining gap is therefore attributed to the evaluation/register model**, not to the
text layer: recovering the "read once more / move once more / recompute the same condition"
parts of MOV/LDR/BRANCH is precisely the surface of S9c/S11, and their bounds are set by the
method of §4 (each statement evaluated once, each variable loaded at most once per block).
That is a project-level change and cannot be reached by local rewriting.

**No existing verdict changes**: §10.5's "bound falsified" and §10.6's "S10 saturated" both
still hold; this section only measures the "how much is left in the text layer" question down
to 2.3% and gives a reproducible decomposition.
### 10.8 Where the gap actually sits: five functions hold more than half of it (2026-11-25)

§10.7 measured the text layer down to 2.3%.  The question a census has to answer next is
**whether the remaining 6,068 instructions are spread evenly over the 95 TUs or concentrated in
a few functions** -- that decides whether the next step is "one more general pass" or "fix one
shape".

Per-function reconciliation (`D:/tmp/bm/fndiff.py`; only functions that occur in both the arkc
and the gcc listing, counting indented lines that do not start with `.`):

| Function | arkc | gcc -O2 | Diff |
| --- | ---: | ---: | ---: |
| `stm32f4xx_hal_dma_ex.c:HAL_DMAEx_MultiBufferStart_IT` | 2,073 | 292 | **+1,781** |
| `stm32f4xx_hal_rcc.c:HAL_RCC_OscConfig` | 1,034 | 366 | +668 |
| `stm32f4xx_hal_dma.c:HAL_DMA_IRQHandler` | 460 | 182 | +278 |
| `stm32f4xx_hal_rcc.c:HAL_RCC_ClockConfig` | 331 | 124 | +207 |
| `stm32f4xx_hal_rcc_ex.c:HAL_RCCEx_PeriphCLKConfig` | 309 | 130 | +179 |
| `stm32f4xx_hal_gpio.c:HAL_GPIO_Init` | 304 | 158 | +146 |
| `stm32f4xx_hal_pwr_ex.c:HAL_PWREx_ControlVoltageScaling` | 177 | 72 | +105 |
| `stm32f4xx_hal_flash.c:HAL_FLASH_IRQHandler` | 179 | 77 | +102 |
| `stm32f4xx_hal_gpio.c:HAL_GPIO_DeInit` | 183 | 93 | +90 |
| `stm32f4xx_hal_rcc_ex.c:HAL_RCCEx_EnablePLLI2S` | 126 | 38 | +88 |
| sum over all common functions | -- | -- | **+5,260** |

The top five account for +3,113, i.e. **59%** of the comparable gap, and the first one alone is
**34%**.  So the "2.2x" headline is not uniform across the corpus: **half of it sits in three or
five HAL functions**, and the other ninety are already close to gcc.  That is the most valuable
reading of this round -- it narrows "change the model" down to "look at what happens inside
`HAL_DMAEx_MultiBufferStart_IT`".

**Dissecting that function** (arkc: 2,120 instruction lines, 536 labels, a literal pool in groups
of 18 words; gcc: 292):

| Mnemonic | arkc | Meaning |
| --- | ---: | --- |
| LDR | 565 | the compared field and a literal are reloaded once per level |
| MOV | 532 | the selected constant is copied into r0 once per level |
| CMP | 263 | one equality test per level |
| B | 262 | "value selected -> join" once per level |
| BNE | 244 | "not equal -> next level" once per level |
| MOVW | 65 | used when the selected constant is above 255 |
| STR | 47 | the actual side effects (only 47) |

The C side is about 40 lines: five `__HAL_DMA_CLEAR_FLAG(hdma, __HAL_DMA_GET_xx_FLAG_INDEX(hdma))`
macros, each expanding into a **19-level conditional-expression chain**
(`inst == DMA1_Stream0 ? A : inst == DMA1_Stream1 ? B : ...`), and the chain is expanded **once per
macro**.  **Six instructions per level**: `LDR r0,[r8,#0]` (reload `hdma->Instance`),
`LDR r7,.Llit_i` (reload an address constant), `CMP r0,r7`, `BNE .Lnext`, `MOV/MOVW r0,#k`
(the selected value), `B .Ljoin`.

gcc's shape at the same place (`D:/tmp/bm/gccmulti.s`):

```asm
	movs	r3, #1
	b	.L24
.L32:
	ldr	r3, .L64+28        ; an 8-word pool of peripheral base addresses
	cmp	r4, r3             ; hdma->Instance is loaded once and stays in r4
	beq	.L37
	adds	r3, r3, #24        ; next stream = base + 0x18, no extra pool word
	cmp	r4, r3
	beq	.L38
	...
	str	r1, [r3, #-56]     ; the selected arm stores through the addressing mode
```

Three differences, all structural:

1. **The compared value is loaded once** (gcc in `r4`, we reload it into `r0` per level);
2. **Later constants are derived arithmetically** (`adds r3, r3, #24`; we open a new pool word
   per level);
3. **The address selection is folded into each arm's store** (`str r1, [r3, #-56]`; we push the
   address onto the machine stack and pop it at the join to do `STR r0,[r1,#0]`).

**Why the text layer cannot fix it** (all three measured this round on `cp/new_s25`):

| Candidate | Upper bound | Why it is not enough |
| --- | ---: | --- |
| Load reuse across single-predecessor edges (`ldrcse_ub6.py`) | 127 (1.15%) | each level's `MOV r0,#k` clears the holding register; only 109 sites in the chain are genuinely reusable |
| Destination-register forwarding (`dstfwd_ub.py`) | 112 (1.0%) | only holds where the producer's Rd is unconstrained in the 16-bit encoding (LDR/MOV/MOVW/MUL/UXT...); forwarding a two-operand ALU form forces a 32-bit encoding, so bytes do not shrink |
| Branch to the immediately following label (`brnext3.py`, strict) | 48 (0.43%) | requires only metadata between branch and label; another 46 have `.align`/pool words in between and **must not be deleted** (control would fall into data) |

Together these are 287 instructions (2.6%), still short of a preregistration, and the real money is
one level up: **the chain should not be expanded this way at all**.  That needs (a) a register for
the compared value that the result constants do not clobber, and (b) "which arm was taken" turned
into a constant sequence rather than one instruction per level.  Both live in emission/IR, not in
text.
