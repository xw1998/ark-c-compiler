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
### 10.9 The last of the emission-level margin: 1.01%, and where S11 ends and S12 begins (2026-11-25)

Section 10.8 pointed "the real money" at the emission/IR layer, so the first thing to do is to
measure **how much is left in the emission layer itself** — otherwise there is no boundary for a
project.  This section uses a read-only script with **five rules frozen before the run**
(`D:/tmp/bm/s11_ldreuse_ub2.py`) to measure "redundant loads into the same destination register",
and re-checks the three candidates of 10.8 under the same definition.

The rules (written down before measuring, so nothing can be tuned afterwards):

1. The candidate is `LDR Rd,[Rb,#imm]` (`LDRB/H/SB/SH/D` treated alike; widths are never mixed).
2. The **nearest earlier** `LDR Rd,[Rb,#imm]` in the same function has the same destination `Rd`
   (same register, same base, same offset), and nothing between the two writes `Rd` or `Rb`.
3. Nothing between them is a `STR/STRB/STRH/STRD/STM/PUSH` (anything that might alias is treated
   as aliasing), and no `BL/BLX`.
4. No second `LDR R?,[Rb,#imm]` in between (a second holder would make "which one to delete"
   ambiguous).
5. Every label crossed must have exactly one predecessor (with several predecessors the earlier
   holding relation does not hold).

| Item | Count | Share of 11,044 |
| --- | ---: | ---: |
| Removable duplicate loads | **112** | **1.01%** |
| ... in `stm32f4xx_hal_dma_ex.c` | 109 | — |
| ... in `stm32f4xx_hal_pwr.c` / `stm32f4xx_hal_dma.c` | 2 / 1 | — |

**Why 262 reloads leave only 112 reusable ones**: in `HAL_DMAEx_MultiBufferStart_IT`,
`hdma->Instance` is reloaded 262 times (`LDR r0,[r8,#0]` 135 + `LDR r5,[r8,#0]` 127), but the
`MOV r0,#k` that selects a constant at every level happens to clobber exactly the `r0` holding
that value, so only the 109 places in the `BLS/BHI` binary-search skeleton satisfy rule 2.  This
reading **sharpens** difference 1 of 10.8 ("the compared value is loaded only once"): it is not a
peephole at all, it is "pick, for a value that lives across 19 levels, a register that the result
constants do not clobber" — a local register allocation.  Corollary: done purely in the emission
layer, the upper bound is 112.

Two more re-checks under the same definition (neither justifies a switch):

| Candidate | Bound | Reading |
| --- | ---: | --- |
| Constants as an arithmetic series (`chainub.py`: next pool word = previous word + an encodable immediate) | 109 places | **Not a single instruction is saved**: `ADD Rd,Rx,#imm` and `LDR Rd,.Llit` are both one instruction; what is saved is pool bytes (~4 B each, ~436 B). Under "one switch, one meaning" this does not get a switch of its own |
| Addresses staged through the machine stack (`s11c.py`) | `PUSH` 418 / `POP` 421, but only **11** places (0.10%) where the `POP` is immediately followed by an access through that register | The two ends of the staging are typically 30+ instructions apart; the text layer cannot see the other end |

**Verdict of this section**: the emission-level margin in **instruction count** is 112 instructions
= 1.01%, below the 5% threshold of F1 in `docs/BOUNDARY.md`, and is therefore closed under F1.
**S11 (the emission-level slice) is not opened and gets no switch** — it sits alongside the four
items of 10.7, S10 of 10.5 and the saturation verdict of 10.6, and this section revises none of
them.

**Where S11 ends and S12 begins**: all three big items dissected in 10.8 — 286 result-constant
materialisations, 262 `B .Ljoin`, 77 stack-staging instructions — are **not local replacements**.
Collecting them requires "sinking the store into each arm" or "changing the block layout", i.e.
changing how a statement is turned into code in the first place.  That is beyond the granularity
of "one switch, one meaning", so by repository discipline it is a project-level change, registered
as **S12 (IR structure layer)**; its scope and upper bounds are the dissection table of 10.8, and
its criteria are not frozen here.

The upper bound of S12's first slice (S12-1, "hoist a load of the same address") has been measured
the same way (`D:/tmp/bm/s12_1_ub.py`): `LDR Rd,[Rb,#imm]` reaching a `CMP Rd,Rn` within three
instructions, with the same `(Rb,imm)` loaded at least twice in the function, occurs **270 times
(2.44%)**, 254 of them in `stm32f4xx_hal_dma_ex.c`.  That is more than twice S11-1's 112; the only
difference is that S12-1 is allowed to move the value into a **dedicated register that the result
constants do not clobber** — which is difference 1 of 10.8 verbatim.  The cost is that it needs a
register the ABI lets us rewrite (one of `r4`-`r11` not referenced by that function, extending
`PUSH/POP` when needed), and it must refuse every case with an aliasing store, a call, or a
rewritten base inside the region.  This slice is still 2.44%, **below F1's 5%**, so it cannot be
opened under F1 on its own; it is registered only as the first step of S12.
### 10.10 S12-1 pre-registration: hoisting a load of the same address (`-fopt-ldhoist`)

Section 10.9 closed the emission-level margin at 1.01%, and the project-level ruling opened the
first slice of S12.  This section freezes its rules, criteria, anti-false-green checks and
trimming **before any code is touched**.  Upper bound from the end of 10.9: **270 instructions =
2.44%** (`s12_1_ub.py`).

**The transformation**: "the same `(Rb,#imm)` is loaded over and over inside a region" becomes
"load it once into a dedicated register `D`, then delete every later load of the same kind".  The
only difference from S11-1 in 10.9 is that **the destination register is allowed to change** —
that is difference 1 of 10.8 verbatim, and it is the reason the 262 reloads in dma_ex can be
recovered.

**Frozen rules** (implementation and measurement both follow these seven; nothing changes after
the run):

1. The candidate is `LDR Rd,[Rb,#imm]` (`LDRB/H/SB/SH/D` treated alike; widths are never mixed).
2. The **dedicated register** `D` is the lowest of `{r4,r5,r6,r7,r8,r9,r10,r11}` that appears
   **nowhere** in the whole function text (neither read nor written, `PUSH/POP` lists included).
   If none is available the whole function is abandoned (named give-up point
   `ldhoist: no dedicated reg`).
3. The function must have **exactly one** prologue `PUSH` containing `lr`, and **every** exit
   `POP` must contain `pc`; `D` is added to each of them.  Otherwise abandon
   (`ldhoist: prologue/epilogue shape`).
4. A region starts at a candidate load and extends forward until the first of: a write to `D`,
   a possibly aliasing `STR/STRB/STRH/STRD/STM`, a `BL/BLX`, a write to `Rb`, or a label with
   more than one predecessor.
5. Every load inside the region that matches rule 1 with the same `(Rb,#imm)` is deleted; each
   use of its `Rd` between that load and the next write to `Rd` must be one of exactly three
   forms — `CMP Rd,Rn` / `CMP Rn,Rd` / `MOV Rn2,Rd` — and the `Rd` operand is rewritten to `D`.
   A fourth form abandons **that load only** (the rest of the region is left alone).
6. The first candidate load of the region becomes `LDR D,[Rb,#imm]` (no instruction is added),
   and its uses are rewritten by rule 5.
7. A deletion is given up if `Rd` is still read outside the region.  This is guaranteed
   conservatively by "every write to `Rd` inside the region has cleared its value"; no
   cross-region liveness is introduced.

**Criteria** (tiered in proportion to the bound, following the precedent of 10.2 rather than
F1's 5%):

| Tier | Net corpus reduction (26 flags, baseline 11,044) | Disposition |
| --- | --- | --- |
| Land | >= 2.0% (>= 221) | stays off by default, registered as a usable tier |
| Register | 1.0% - 2.0% (110-220) | switch kept, default off, judged "below the project threshold" |
| Retract | < 1.0% (< 110) | code reverted, only these readings kept |

**Anti-false-green (all four required)**:

1. `ARKCC_FEATURE_OPT_LDHOIST=0` and "compiled in but not passed" must both produce `.s` output
   for the 95 TUs that is **byte-identical** to today (OFF IS OFF).
2. A fixture that **must fire**: the same `(Rb,#imm)` loaded twice along a single-predecessor
   chain with only a `MOV` to another register in between => exactly one `LDR` left, and its
   destination is `D`.
3. A fixture that **must not fire**: a `STR [Rb,#other]` (potential alias), a `BL`, or a
   multi-predecessor label between the two loads => both `LDR`s kept verbatim.
4. `make test-arm-exec`, `tests/run_vreg_tests.py` and `tests/run_regalloc_tests.py` all green:
   one extra register in `PUSH/POP` makes any wrong restore path show up here.

**Trimming**: a new `ARKCC_FEATURE_OPT_LDHOIST`, forced to 0 under `ARKCC_PROFILE_STM32_MIN`,
with the on-board name-based refusal of `-fopt-ldhoist` (`C3900U`) along the same path as the
21 existing `-fopt-*` names.  Off by default: `-fopt-ldhoist` must be given explicitly.

**Forbidden (written down)**:

1. Never insert a new `PUSH/POP` pair into a function that has none to extend — that changes the
   frame and the calling convention.
2. Never delete a load on the strength of "nothing seems to read it outside the region" without
   liveness backing it.
3. Never take `D` from `r0`-`r3`: those are caller-saved scratch and a `BL` will clobber them.
4. Never count "changed the destination register without deleting a load" as a gain.

## 11 S12-1 measurement and verdict (2026-11-25)

The seven rules of S10.10 are implemented verbatim in `ark_ldhoist_function()` in
`src/backend/arm/backend_arm.c`, behind `-fopt-ldhoist` / `ARKCC_FEATURE_OPT_LDHOIST`
(forced to 0 under `ARKCC_PROFILE_STM32_MIN`).  This section is the honest accounting
after the run.

### 11.1 Readings

| Configuration | Insns | Bytes |
| --- | ---: | ---: |
| 25 flags (no `-fopt-spill`, no `-fopt-ldhoist`) | 11,375 | 392,476 |
| 26 flags (+ `-fopt-spill`) = S12-1 baseline | **11,044** | **387,872** |
| 26 flags + `-fopt-ldhoist` | **10,917** | **385,260** |
| Net | **-127** | **-2,612** |
| gcc `arm-none-eabi-gcc 13.2.1 -O2`, same corpus | 4,976 | - |

127 / 11,044 = **1.15%**.

**Verdict: register tier.**  Under the three tiers frozen in S10.10, 1.0%-2.0% is
"register": the switch stays, default off, judged "below the project threshold
(>= 2.0%)".  That is the criterion being applied, not an implementation failure -- 11.2
shows the candidates the rules allow have been taken.

### 11.2 Where the gain lands

| TU | Before | After | Net |
| --- | ---: | ---: | ---: |
| `stm32f4xx_hal_dma_ex.c` | 2,186 | 2,060 | **-126** |
| `stm32f4xx_hal_pwr.c` | - | - | -1 |
| the other 93 TUs | - | - | 0 |

`HAL_DMAEx_MultiBufferStart_IT` is the only real battlefield in this slice:

- `LDR r?, [r8, #0]` (`hdma->Instance`) goes from **266 to 140** in that function;
- `PUSH {r5, r6, r7, r8, lr}` becomes `PUSH {r4, r5, r6, r7, r8, r9, lr}` (`D = r4`;
  the frame is 52 bytes, so 7 registers = 28 bytes and 28 + 52 = **80**, still a
  multiple of 8);
- all 3 exits `POP {r5, r6, r7, r8, pc}` become `POP {r4, r5, r6, r7, r8, r9, pc}`;
- 12 anchor loads and 19 levels of nested ternaries fold into `CMP r4, ...` with
  **no instruction ever added**.

### 11.3 Why 127 is below the 270 bound

The bound script (S10.9's `s12_1_ub.py`) counts every load whose `(Rb,#imm)` key occurs
>= 2 times in the **function**, without asking whether the two fall into one region.
Rule 4 ends the region at a write to `Rb`, an aliasing store, a call, or a
multi-predecessor label -- so cross-region repeats can never be deleted under the rules.

Re-running the same bound script on the `lh_on` output gives **142** (128 of them in
dma_ex), i.e. only about half of the "bound" is intra-region duplication.  What is left
untaken:

- 12 `LDR r0, ...` loads whose consumers are `ADD` / `STR`, not `CMP` (rule 5 knows three
  shapes only);
- 116 `LDR r5, [r8, #0]` loads, likewise not candidates (consumer outside the three
  shapes, or region cut by an aliasing store).

**Conclusion: the candidates the frozen rules allow are essentially exhausted.**
127 / 142 = 89%.

### 11.4 The one clear remaining direction (registered, rules unchanged)

Rule 5's three shapes are `CMP Rd,Rn` / `CMP Rn,Rd` / `MOV Rn2,Rd` and **not
`CMP Rd,#imm`**, while a large share of armcc's compares are immediate forms
(`CMP r0, #1`).  Relaxing that would likely take another batch, but S10.10 says "no rule
changes after the run", so this slice **does not touch the rules** and only registers the
relaxation as a candidate for the next S12 slice (which needs a new preregistration).

### 11.5 Gates

New `make test-ldhoist` (`tests/run_ldhoist_tests.py`, 20 checks, all green):

1. **OFF IS OFF**: `-O2 <passes>` and `-O2 <passes> -fno-opt-ldhoist` are byte-identical
   as assembly text and as image; a cropped build (`-DARKCC_FEATURE_OPT_LDHOIST=0`)
   writes the same text as the full build when the flag is absent.
2. **Must fire**: two `[r8,#0]` loads collapse to one; it lands on `r4` (a register the
   function never names); both `CMP`s read it; `PUSH` and every exit `POP` are widened by
   the same set; sp stays 8-byte aligned (6 saved registers + 16-byte frame = 40); the
   instruction count drops by exactly one; no dangling label; the image never grows.
3. **Must not fire**: an aliasing `STR`, a `BL`, and a two-predecessor label between the
   two loads, plus a plain-C fixture, all come out byte-identical (the plain-C arm also
   returns 26 on the emulator in both arms, matching Python).
4. **Cropped out**: a `-DARKCC_FEATURE_OPT_LDHOIST=0` build refuses `-fopt-ldhoist` by
   name (`C3900U`) and still compiles the same file without the flag.

Companion regressions: `make test-arm-exec` **0 failure**; `tests/run_vreg_tests.py` all
green; `tests/run_regalloc_tests.py` "all claims hold"; `test-spill` / `test-option` /
`test-live` / `test-slotreg` / `test-addr` / `test-coalesce` / `test-deadpush` /
`test-exit` all green.

### 11.6 An engineering fact: plain C cannot build the must-fire fixture

The seven rules are narrow enough that **no qualifying function can be built out of C**
with arkc's current code generation.  Six shapes were tried and none fires, each for its
own reason:

- the address of a pointer parameter is recomputed (`MOV r5, #0x20000000` / `ADD`),
  writing `Rb` and ending the region immediately;
- with `-fopt-vreg` promoting the pointer to `r8`, the `STR [r6, #8]` at the head of a
  branch body is an aliasing store, cutting the region to a single load;
- the nested-ternary shape is right, but rule 7's conservative implementation requires
  the deleted load's `Rd` to be written inside the region, and in a small function the
  result constant lands on a different register => `killed == 0` => decline.

The fixtures therefore use `__asm volatile`, which the assembler copies through
**verbatim**.  One trap worth recording: the text pass compares mnemonics literally, so
**inline assembly must be upper case**; a lower-case `ldr` is silently skipped (the first
fixture in this round did not fire for exactly that reason, and looked plausible).

### 11.7 Forbidden readings

1. 1.15% is **not** "the pass is not implemented" -- dma_ex's 126 instructions were
   checked one by one.
2. Never add 1.15% to S10.9's 1.01% and call the result "gap removed": they measure
   different layers, and together they are still a 2% effect that cannot move the +122%.
3. "Register tier" does not mean the next slice is worth opening: whether to do the S11.4
   relaxation still needs a project-level ruling (S10.9's precedent: below 5% margin, do
   not open a new slice).

## 12 S12-1b measurement and withdrawal (2026-11-25)

S11.4 registered "rule 5 does not include `CMP Rd,#imm`" as the next candidate slice.
This section is the **measurement** of that candidate, and the verdict is **withdraw**:
after the relaxation the gain is **0 instructions**.

### 12.1 Two probes (neither committed)

Before touching any frozen wording, two throw-away probes measured what rule 5 is worth:

| Probe | Change | Reading |
| --- | --- | --- |
| A (S12-1b proper) | in `ldh_shape`, the `CMP` branch first checks "`op[0]==D`, `op[1]` starts with `#`, and `op[1]` does not mention `D`" => return 0 | 10,917 / 385,260 |
| B (ceiling of rule 5) | consumer test relaxed to "any instruction, provided exactly one operand is *exactly* that register and the instruction does not write it" | 10,917 / 385,260 |

Both readings are **bit-identical** to S11.1's 10,917 / 385,260. Probe A was verified
to really fire on a hand-written fixture (`CMP r5,#11` and `CMP r5,#22` both rewritten to
`CMP r4,...`, the second load deleted, `PUSH`/`POP` widened to `{r4,r5,r6,r7,r9,lr}`),
so the zero is not "the probe never connected".

### 12.2 Why it is zero (root cause, measured)

Immediate compares are **not** rare in this corpus: the 26-flag output has **331**
`CMP Rd,Rn` and **344** `CMP Rd,#imm`. Something further upstream blocks it:

- the region-aware ceiling (rerunning `s12_1_ub.py` on the `lh_on` output) is only **142**,
  128 of them in dma_ex;
- S12-1 already took **127** of those (89%);
- the remaining 15 are stopped by rules 4/7 (region cut by a write to `Rb`, an aliasing
  store, a call or a two-predecessor label; `killed == 0`), **not by rule 5**.

**Conclusion, written down**: "rule 5 misses immediate compares" is a phantom gap.
Relaxing it buys nothing, and the ceiling version buys nothing either; the two identical
readings also rule out the "gained as many as it lost" coincidence (a real trade would
still move the byte count).

### 12.3 Verdict

**S12-1b withdrawn** (0 instructions, below the <110 withdrawal line of S10.10's tiers).
**The S12-1 line is closed at "register tier"**; `-fopt-ldhoist` stays (default off,
same registration basis as `4b3fc25`). Both probes were reverted with `git checkout`;
the tree is identical to `35b5a76`.

### 12.4 Forbidden readings

1. "0" does **not** mean immediate compares are rare: 344 `CMP Rd,#imm` versus 331
   register-form `CMP`.
2. "0" does **not** mean S12-1b was badly implemented: probe A *is* the relaxed
   implementation, and the reading *is* the gain.
3. Do not reopen S12-1's wording because of this withdrawal: S11.3 and S11.4 stand, this
   section only appends.

## 13 Residual survey of the text layer (2026-11-25, closing)

Every remaining candidate family, measured in one pass on the 26-flag output `lh_base`
(11,044 basis). This is the last survey of "what the text layer can still take":

| Candidate family | Ceiling (insns) | Share of 11,044 |
| --- | ---: | ---: |
| Literal-base hoisting (one dedicated register per function, the most repeated `Llit`) | 140 | 1.27% |
| Dead frame stores (`[r6,#n]` slots written and never read in the function) | 91 | 0.82% |
| Alignment-only frames (`SUB/ADD sp` only for 8-byte alignment; body touches neither `[r6]` nor `[sp]`) | 66 | 0.60% |
| In-block literal-load dedup (no extra dedicated register, per-block tracking) | 61 | 0.55% |
| In-block frame-slot promotion (same slot accessed >=2 times in one block) | 25 | 0.23% |

Reproduction scripts (`D:/tmp/bm/`): `litdup3.py`, `frameslot.py`, `framealign.py`,
`litdup2.py`, `frameslot2.py`; `litdup.py` gives the whole-function count (438) but
requires a dedicated register, so it is reference only.

**Three conclusions**:

1. Every family is below **1.3%**; together (they overlap, so they do not add cleanly)
   they are a 3.5% effect at most -- enough to move 11,044 to roughly 10,650, still
   **1.9x** armcc.
2. Three of them (literal-base hoisting, dead frame stores, alignment-only frames) carry
   the **same meaning** as `-fopt-ldhoist` (hoist a repeated materialisation into one
   dedicated register, or trade an alignment-only frame for a register), so they could be
   folded into the existing switch; but by S10.10's tiers, 140 = 1.27% is still
   register tier.
3. **The text layer closes here.** S4's judgement (reaching 5,619 requires changing the
   emission model) now has reading support: in one accounting (25/26 flags, without
   `-fopt-regalloc`) 25 flags **11,375** -> `-fopt-spill` **11,044** (-331) ->
   `-fopt-ldhoist` **10,917** (-127) -> S12-1b **0**; with S9b (other accounting,
   11,666 -> 11,650, -16) the whole round is **11,375 -> 10,917 (-458, -4.0%)**, still
   **1.94x** armcc. The -49% has to come from the structural layer.

## 14 S13 pre-registration: post-emission redundancy removal (frozen 2026-11-25, before implementation)

S13 closed the text layer, but its table still holds two families that **no switch covers**
and whose upper bound can be **frozen exactly**: dead instructions (a pure register write in a
block that a later write overwrites before any read, and `CMP/CMN/TST/TEQ` whose flags die in
the block) and frame bookkeeping (`MOV r6, sp` and a `SUB/ADD sp` that only serves alignment).
These are not "same instructions, better chosen" -- they are instructions the emitter left behind
that are **provably useless**, so they do not contradict S2/S4: S4 says rewriting *live*
instructions cannot recover the missing 49%; deleting provably dead ones is a different question.

This section freezes **one slice with two switches**: `-fopt-deadins` (dead instructions) and
`-fopt-stackframe` (frame bookkeeping). Each switch keeps exactly one meaning; the criterion is
judged **once, on the combined number**.

### 14.1 Upper bounds (read-only measurement, 2026-11-25)

Baseline: 26 flags + `-fopt-spill` + `-fopt-ldhoist` = **10,917 instructions / 385,260 B**.

| family | bound | share of 10,917 | script |
| --- | ---: | ---: | --- |
| `-fopt-deadins`: intra-block dead write + dead flags | 94 (25 dead writes + 69 dead flags) | 0.86% | `D:/tmp/bm/deadub4.py` |
| `-fopt-stackframe` P: drop `MOV r6, sp` / `MOV sp, r6`, rewrite `[r6,#n]`->`[sp,#n]` | 102 (94 functions) | 0.93% | `sf_ub2.py` + depth model |
| `-fopt-stackframe` Q: `SUB/ADD sp` of a frame nothing uses | 42 (21 functions x 2) | 0.38% | `framealign.py` |
| **total** | **238** | **2.18%** | |

Among the 94 P functions, 13 are refused because a `[r6,#n]` appears after an in-body `PUSH`,
3 because `MOV rX, r6` / `ADD rX, r6, #imm` takes the base address, and 9 Q candidates are
refused because an unused frame with an odd `PUSH` and a `BL` still needs the `SUB` for
8-byte alignment. These are **hard refusals**; the implementation may not relax them.

### 14.2 `-fopt-deadins` rules (frozen)

Unit = **basic block** (instructions between labels, terminated by `B/Bcc/BX/BL/BLX/CBZ/CBNZ`
or a `POP` naming `pc`). Scan the block **backwards** with the live set initialised to
**all of r0-r12 live** (conservative block exit) and `needf = 0`:

1. A **flag reader** (`B<cond>`, `ADC/SBC/RSC`, `IT*`) sets `needf = 1`.
2. A pure flag writer `CMP/CMN/TST/TEQ`: if `needf == 0` **delete the whole instruction**;
   otherwise `needf = 0`, `live |= reads`.
3. A **pure register write** (`MOV/MOVS/MOVW/MOVT/ADD/ADDS/SUB/SUBS/AND/ANDS/ORR/ORRS/EOR/
   EORS/BIC/BICS/MVN/MVNS/LSL/LSLS/LSR/LSRS/ASR/ASRS/UXTB/UXTH/SXTB/SXTH/MUL/MULS/
   RSB/RSBS/NEG/NEGS/REV/REV16/REVSH`) whose destination is r0-r12, is **not** in `live`
   and is not "writes flags while `needf==1`" ⇒ **delete**; otherwise `needf=0` and
   `live = (live - writes) | reads`.
4. Any other instruction (`LDR/STR/PUSH/POP/BL/VLDR/UDIV/...` and every unrecognised
   mnemonic) ⇒ `live = all of r0-r12`, and `needf` updated from the `S` suffix.
5. A block containing any `IT*` instruction is **skipped entirely**.

Read/write conventions: `MOVT Rd` reads `Rd`; a two-operand ALU form (`AND r5, r7`) reads `Rd`;
`CBZ/CBNZ/B/BX/BL/BLX` write nothing; `LDR Rd, [Rb, #i]` reads `Rb` (including `Rd == Rb`).

### 14.3 `-fopt-stackframe` rules (frozen)

For one function region, take the **prologue shape**: first instruction is `PUSH {..}`, then an
**optional** `SUB sp, sp, #N`, then an **optional** `MOV r6, sp`; neither present ⇒ not applicable.

**P form** (requires `MOV r6, sp`): in the body

- no `sp` may appear except the prologue `SUB` and the exit `MOV sp, r6` + `ADD sp, sp, #N`;
- every exit must be `[MOV sp, r6] [ADD sp, sp, #N] POP {.., pc}` (or the same with `BX lr`),
  and the `ADD` immediate must **equal** the prologue `SUB` immediate;
- every occurrence of `r6` in the body must be `[r6]` or `[r6, #imm]` (no `[r6, rX]`, no `!`
  writeback) and must occur at **machine-stack depth 0** (depth accumulated over in-body
  `PUSH {}`/`POP {}` register counts; `STM`/`LDM` are refused);
- if all of that holds ⇒ delete `MOV r6, sp` and every `MOV sp, r6`, and rewrite each
  `[r6(, #imm)]` into `[sp(, #imm)]`. The `PUSH`/`POP` register lists are **left alone**
  (`r6` stays saved/restored so that the `sp` offset and 8-byte alignment do not move).

**Q form** (frame entirely unused): the body has neither `[r6` nor `[sp`, exactly one
`SUB sp, sp, #N` with `N > 0`, and every exit `ADD sp, sp, #N` uses the same `N` ⇒ delete that
`SUB`, every exit `ADD`, and (if present) `MOV r6, sp`. **Refused when the body contains
`BL/BLX` and the `PUSH` register count is odd** (the `SUB` is then still carrying 8-byte
alignment).

### 14.4 Criterion (frozen, decided before the run)

Relative to **10,917** (26 flags + `spill` + `ldhoist`):

| hits | verdict |
| --- | --- |
| >= 219 (>= 2.0%) | **lands**: both switches kept, default off, added to the README flag table |
| 110 - 218 | **register tier**: kept, default off, not recommended |
| < 110 | **withdrawn**: only the measurement above is kept, the code is reverted |

### 14.5 Anti-false-green (frozen, four, all must pass)

1. **OFF IS OFF**: with both switches off, the 95-TU `.s` set is **byte-identical** to
   10,917 / 385,260 B.
2. **Must fire**: fixtures (inline assembly **must be upper case**) for a dead write, a dead
   flag, a P frame and a Q frame; with the switches on, the deleted lines and the rewrite are
   checked line by line.
3. **Must not fire** (one fixture each, byte-identical with the switches on): a write that is
   read afterwards; a `CMP` followed by a **conditional** branch; a frame whose address is taken
   with `MOV rX, r6`; a frame with `PUSH {r0}` in the body and a later `[r6,#n]`; an unused
   frame with a `BL` and an odd `PUSH`.
4. **Regression**: `test-arm-exec` 0 failure, and `test-ldhoist` / `test-exit` / `test-spill` /
   `test-frame` / `run_vreg_tests.py` / `run_regalloc_tests.py` all green.

### 14.6 Forbidden readings (frozen)

1. Do not read these 238 as "the text layer still has margin": they are provably useless
   instructions, S13's table stays closed, and neither may be used to rewrite S13's conclusion.
2. Do not describe `-fopt-deadins` as register allocation: its block-exit live set is
   **all-live** and it recovers nothing across blocks; cross-block dead writes are a separate,
   registered, unopened candidate.
3. Do not skip the 8-byte alignment check on the Q form, and do not drop `r6` from the `PUSH`
   to "buy instructions" (that only saves bytes and moves the `sp` offset and alignment).
4. Do not relax "the body never moves `sp`" to save the occasional `MOV r6, sp`; a `[r6,#n]`
   after an in-body `PUSH` is refused by the depth rule.

## 15 S13 measurement and verdict (2026-11-26, after the run)

Both switches are implemented and wired (`-fopt-stackframe` / `-fopt-deadins`, off by
default, `-fno-opt-*` turns them off, `-DARKCC_FEATURE_OPT_STACKFRAME=0` /
`-DARKCC_FEATURE_OPT_DEADINS=0` crops them out). This section applies the criterion frozen
in §14.4 once, to the combined number, and does not judge the two passes separately.

### 15.1 Three readings (same 95-TU corpus, same gauge)

| tag | flags | insns | `.s` text bytes |
| --- | --- | ---: | ---: |
| `s13_off3` | 26 flags + `spill` + `ldhoist` | **10,917** | **385,260** |
| `s13_sf3` | above + `-fopt-stackframe` | **10,785** (−132) | 382,620 |
| `s13_both3` | above + `-fopt-stackframe -fopt-deadins` | **10,691** (−226) | 381,202 |

−226 against 10,917 is **−2.07%**, i.e. ≥ 219 ⇒ **landing tier** (first tier of §14.4). Both
switches stay, default off, and go into the README flag table. Split by pass: `stackframe`
−132 and `deadins` −94 (running `deadins` alone is also −94; the two families do not overlap —
`deadins` removes pure register writes, `stackframe` removes `MOV rX, sp` and `SUB/ADD sp`
and rewrites, and they are disjoint).

- OFF IS OFF re-verified byte for byte: with both switches off, the 95-TU `.s` set is
  **identical** to `s13_off3`, 385,260 B (`cmp` branch of `D:/tmp/bm/redo13.py`).
- Reproduction: `D:/tmp/bm/redo13.py` (the three re-measurements), `D:/tmp/bm/cls13.py`
  (change classification).

### 15.2 Change classification (off3 → sf3)

585 lines deleted, 453 added (net −132):

| shape | count | note |
| --- | ---: | --- |
| `DEL: MOV` | 100 | mostly `MOV r6, sp`, a few `MOV sp, r6` |
| `DEL: ADD` | 16 | exit `ADD sp, sp, #N` |
| `DEL: SUB` | 16 | entry `SUB sp, sp, #N` (Q form) |
| paired `ADD/DEL` | 453 | in-place rewrites of `[r6(, #imm)]` → `[sp(, #imm)]` (`LDR 183 / LDRB 13 / LDRH 8 / STR 243 / STRB 6`), **not** new instructions |

Spot checks: `HAL_PWR_DeInit` (Q form) loses `PUSH {r5,r7,lr}`-frame's `SUB 4`/`ADD 4` and keeps
`POP {r5,r7,pc}` intact; `HAL_PWR_EnableBkUpAccess` (P form) loses `MOV r6, sp`, gets
`[r6,#0]→[sp]`, and keeps `SUB/ADD 12` because that body really uses its local.

### 15.3 Where `-fopt-deadins` actually fires (sf3 → both3, net 94, zero added lines)

`hal_flash.c` 2, `hal_pwr_ex.c` 8, `hal_rcc.c` 64, `hal_rcc_ex.c` 20. Dominant shape is a
`MOV r0,#1` + `CMP r0,#1/2/3` pair whose other operand and flags are never read again. The two
`hal_flash.c` lines are `ADD r0, r0, #1` / `SUB r0, r0, #1` whose `r0` is immediately
redefined by `MOVW`; both were audited as genuinely dead.

### 15.4 One correction to the letter of §14.2

§14.2 says "otherwise `needf = 0`". The implementation follows the **sound** reading: only an
instruction that *writes* flags clears `needf`, otherwise a `CMP` / `MOVS` / `ADDS` followed by
`BEQ` would let the `CMP` be deleted. The two readings agree on flag-writing instructions and
differ only on pure writes; the literal reading would wrongly allow deleting a pure write after
a `CMP` whose flags are still needed. The criterion and the verdict are unchanged.

### 15.5 Gates (two new targets, `make test-stackframe` / `make test-deadins`)

- `tests/run_stackframe_tests.py`: 20 checks, all green. Core: **re-derive every deletion from
  the unoptimised text** (five P-form checks, four Q-form checks), three must-refuse fixtures
  byte-identical (odd `PUSH` + `BL`, in-body `ADD r0, sp, #0`, in-body `MOV r6, r0`), a
  **global alignment invariant** (odd `PUSH` without a compensating `SUB4` fails), a dangling
  label check, both unicorn arms returning 27, and the cropped build refusing `C3900U` by name
  while the no-flag text stays identical.
- `tests/run_deadins_tests.py`: 14 checks, all green. Core: an **independent re-checker** with
  its own liveness model (all-live at block exit, exact modelling of
  `PUSH/POP/LDR/STR/LDM/STM/B/CBZ`, calls and unknown mnemonics as barriers) scans the
  unoptimised text backwards and proves each removed line to be "pure register write + no live
  flag written + destination not live here", in parallel with "removes lines, adds none",
  "both image arms equal (`off=4 on=4`)", "four must-refuse fixtures byte-identical" and "the
  cropped build refuses the flag by name".
- Regression: `test-arm-exec` / `test-ldhoist` / `test-exit` / `test-spill` / `test-live` /
  `test-vstack` / `test-cmat` / `test-bitmask` / `test-stdlib` / `test-x86-64` all green
  (230 `[ok]`, 0 `[FAIL]`; x86-64 side 70 passed / 0 failed), plus `run_vreg_tests.py` and
  `run_regalloc_tests.py`.

### 15.6 A **pre-existing** defect, registered, not fixed here

`-fopt-live` and `-fopt-cmat` **delete user inline assembly lines**: `__asm volatile("MOV r4, #11")`
silently disappears when those two passes are on (bisecting the other 24 flags individually
never swallows it). The cause is that `IR_ASM` is emitted as just `"    " + template`
(`src/backend/arm/backend_arm.c`, around line 15456), so the text passes cannot tell user asm
from their own instructions and treat it as an ordinary instruction to reorder or delete. This
is a **wrong-answer defect that predates the pre-registration** (user asm must be an
undeletable barrier); the fix touches every text pass that rebuilds a function, so by discipline
it gets its own slice and its own pre-registration. Registered here only; it does not block S13.
Reproduce:

```
printf 'unsigned f(unsigned x){__asm volatile("    MOV r4, #11"); return x;}\n' > /tmp/a.c
arkcc -target arm -S -O2 -fopt-live /tmp/a.c -o /tmp/a.s && grep -c 'MOV r4, #11' /tmp/a.s   # 0
```

Workaround used by this round's gates: fixtures that carry user `asm` only enable
`-fopt-vstack -fopt-addr -fopt-frame`.

### 15.7 Forbidden readings (frozen)

1. Do not read −2.07% as "the text layer still has margin": these are provably useless
   instructions that the emitter left behind; §13's closing stays, and the ratio to armcc is
   still **1.94×**.
2. Do not call `deadins` register allocation: its block-exit live set is all-live and it
   recovers nothing across blocks.
3. Do not read the 453 `[r6→[sp` rewrites as "new instructions" — they pair one-to-one and the
   net is already accounted for.
4. Do not claim "all combinations verified" because the gates stack 27 flags: they verify these
   two passes under the given combinations, not the Cartesian product of flags.


## 16 S14: a per-function exemption for user inline assembly (2026-11-26, after the run)

### 16.1 Why (following on from the §15.6 defect)

The text passes work on the post-emission assembly text, and `__asm` is written into that
text verbatim (`"    " + template`), so a pass cannot tell a user line from one it emitted
itself. The measured consequence is a wrong answer: `-fopt-live` / `-fopt-cmat` silently
deleted `__asm volatile("MOV r4, #11")`, and other passes could just as easily rename
registers inside user code.

**Two candidate fixes**:

1. **A per-pass asm barrier**: add a "stop when you see asm" scan to each of the 12 passes
   that rebuild a function. Large surface, and missing one is a silent wrong answer.
2. **A per-function exemption**: if the body contains any `__asm`, the whole text pipeline
   skips that function. Soundness for every pass at once, at the price of no text-layer
   optimisation for such functions.

Option 2 was taken. The criterion is **sound first** ("better to fail than to answer
wrongly"): user asm is an **undeletable barrier**, and the compiler has no right to reorder,
rename or delete around it.

"Add a test-only switch that lifts the exemption" was **explicitly rejected**: it reopens a
path to a silent wrong answer.

### 16.2 Implementation (`src/backend/arm/backend_arm.c`)

- `int fn_user_asm = 0;` next to `int fstart = 0;`, cleared at each function entry;
- the first line of `case IR_ASM:` sets `fn_user_asm = 1;` (recorded at emission time, not
  inferred from text, so formatting cannot defeat it);
- at the text-pass block entry: `if (fn_user_asm) goto arm_skip_text_opts;`;
- `ark_fix_far_offset(&buf, fstart);` **still runs** (it is a correctness fix: the far-branch
  trampoline must exist), then the `arm_skip_text_opts:` label and
  `if (fn_user_asm) goto arm_skip_frame_opts;`;
- `arm_skip_frame_opts:` sits after the frame-bookkeeping pass's `#endif`, i.e.
  `stackframe` / `deadins` are exempt too.

### 16.3 Criteria and readings (`tests/run_userasm_tests.py`, 5 checks, all green)

| check | result |
| --- | --- |
| all four user asm lines are present with no flags | ok |
| **each of the 29 flags applied on its own** leaves the asm-bearing function byte-identical to the no-flag build | ok |
| all 29 flags **at once** likewise byte-identical (307 B) | ok |
| a second function in the same file with no asm **is still optimised** (46 → 14 insns) | ok |
| both unicorn arms return 9 (the value the user asm wrote really lands) | ok |

Checks 2 and 3 are the positive evidence: the passes really are on in this build (check 4
proves it) and they do not touch the user's function at all. Check 4 also rules out the
reading "the exemption means every pass is dead".

### 16.4 Zero cost on the corpus

None of the 95 TUs carries a user `asm` function, so the exemption changes no number:

| tag | flags | insns | `.s` text bytes |
| --- | --- | ---: | ---: |
| `s14_off` | 25 flags (`sw24`) | 11,375 | 392,476 |
| `s14_on` | 26 flags + `spill` + `ldhoist` + `stackframe` + `deadins` | **10,691** | **381,202** |

`10,691 / 381,202` is **byte-identical** to `s13_both3` in §15.1, so §15's verdict needs no
revision at all. Reproduction: `D:/tmp/bm/redo14.py`.

### 16.5 Gate interaction: `run_ldhoist_tests.py` had to be rewritten (done)

S12-1's must-trigger / must-not-trigger fixtures were written in **inline assembly** (§11
records why: arkcc's own emitter cannot spell that shape). After S14 those fixtures are
exempt wholesale, and `make test-ldhoist` failed 6 checks on the spot — **not a regression,
a dead fixture**. What replaced them:

- **The trigger arm is now a real TU**: `examples/ark_test/.../stm32f4xx_hal_dma_ex.c`, built
  with all 26 flags (`vstack/addr/frame` alone give this pass a delta of 0, so the full set is
  required), six HAL/CMSIS include paths, `-D STM32F401xE -D USE_HAL_DRIVER --reloc-data`.
  Measured: `2186` → `2060` insns, **exactly one function** changes
  (`HAL_DMAEx_MultiBufferStart_IT`, `2073 → 1947`, −126); inside it the hottest `[r8, #0]`
  appears **256** times in the off arm, **126** are removed and **130** kept; the dedicated
  register is `r4` (never present in the off text, in r4..r11), the prologue goes
  `PUSH {r5,r6,r7,r8,lr} → {r4,r5,r6,r7,r8,r9,lr}` with all four return `POP`s widened,
  `4×7 + 52 = 80` stays 8-byte aligned, no dangling labels, text 79,266 → 76,660 B.
- **The intent of the three "must not trigger" checks is carried by evidence that survives**:
  (a) the other three functions of the same TU are byte-identical; (b) 130 of the same-address
  reloads in that function are **left alone** ("not hoist-everything"); (c) the pure-C fixture
  is byte-identical and both unicorn arms still return 26. The three asm fixtures
  (possibly-aliasing `STR` / `BL` / two-predecessor label) are deleted, with the module
  docstring stating why they can no longer exercise this pass (the S14 exemption) and pointing
  here.
- The other two checks (`OFF IS OFF`, the cropped build refusing `C3900U` by name) now also run
  on the real TU, which is strictly stronger.

The gate currently has 18 checks, all green.

### 16.6 Forbidden readings (frozen)

1. Do not read the exemption as "the §15.6 defect was not serious": what was fixed is a
   **wrong answer** (user asm deleted); the price is that **such a function gets no text-layer
   optimisation at all**. Both halves must be stated.
2. Do not read it as "every pass is dead": check 4 of `run_userasm_tests.py` and §16.4 both
   show that functions without asm are optimised as before and the corpus numbers are unmoved.
3. Do not re-interpret S12-1's verdict because `run_ldhoist_tests.py` was rewritten: §11's 127
   deletions and the "registered tier" verdict stand; only the **fixture that measures it**
   changed, because the fixture's carrier (inline assembly) is exempt under S14.
4. Do not generalise "per-function exemption" into "per-module / per-file": the decision point
   is `IR_ASM` appearing in **this** function, and other functions in the same file are
   optimised as usual (check 4 pins this).

## 17 S15 pre-registration: local redundancy inside a compare ladder (frozen 2026-11-26, before implementation)

After section 13 closed the text layer and sections 14/15 landed, the only large region of the
corpus still untouched by any switch is the compare ladder inside
`HAL_DMAEx_MultiBufferStart_IT` -- nineteen `(uint32_t)hdma->Instance == DMA1_StreamN ? FLAG : ...`
ternary chains expanded from `__HAL_DMA_GET_xx_FLAG_INDEX`. This section freezes the **measured
bound**, then why the big-looking number is **not reachable**, then a slice that only deletes.

### 17.1 Bound (measured read-only on this host, 2026-11-26)

Baseline: the S13/S14 figure **10,691 insns / 381,202 B** (26 switches + `spill` + `ldhoist` +
`stackframe` + `deadins`). Scripts `D:/tmp/bm/chainsel_ub2.py` (generalised ladder census) and
`D:/tmp/bm/laddertrim_ub.py` (reachable bound).

**Ladder census** (a layer = `LDR Rc, .Llit_k` + `CMP Rd, Rc` + `BNE Lnext` + value
materialisation + `B Ljoin`, where `Lnext` is the next layer):

| Quantity | Measured |
| --- | ---: |
| Ladders | 24 |
| Layers | 249 |
| Instructions inside ladders | **1,607** (15.03% of 10,691) |
| of which `stm32f4xx_hal_dma_ex.c` | 21 ladders / 1,555 |
| of which `stm32f4xx_hal_gpio.c` | 2 ladders / 50 |
| Ladders sharing the same 12-key sequence (in dma_ex) | **17** |

Layers come in two shapes, **mixed inside one ladder**:

- **Shape A (5 insns)**: `LDR Rc, .Llit_k` / `CMP Rd, Rc` / `BNE Lnext` / `MOV|MOVW Rv, #imm` / `B Ljoin`.
- **Shape B (8 insns)**: `LDR Rb, [Rn, #0]` / `LDR Rc, .Llit_k` / `CMP Rd, Rc` / `MOV Rv, Rd` /
  `MOV R?, Rc` / `BNE Lnext` / value materialisation / `B Ljoin`.

### 17.2 Why the bound is 337 and not 1,607 (frozen; the earlier estimate is refuted by measurement)

The estimate given to the user earlier was "bound -1,781 insns / 16.7%". That was a **static
count**, not a reachable quantity. The real money in the 1,607 is **sharing across statements**:
the 17 ladders compare the same `hdma->Instance` (`LDR Rb, [r8, #0]`) against the identical key
sequence, differing only in the value. Collapsing them into "compute the index once, then five
table lookups" is exactly gcc's 292-instruction route (`D:/tmp/bm/gccmulti.s`).

**That rewrite is not admissible in this compiler.** Sharing requires `*(r8 + #0)` (the compared
instance pointer) to be unchanged between two ladders, and between two ladders there is precisely
`STR Rv, [r1, #0]` -- a write to `DMA1/2->IFCR`. The text layer has **no alias information** and
cannot prove that write does not land on `*(r8 + #0)`. gcc can, because it has types and path
information (the store target is a named peripheral object, the load is a member read through a
pointer). Under "report an error rather than give a wrong answer", cross-statement sharing is
refused outright and **not implemented**.

What remains reachable is redundancy **inside a single ladder**. Between two adjacent layers of a
ladder there is **no memory access and no call** (only `LDR` of a literal, `CMP`, `MOV`, `Bcc`,
`B`), so the following two deletions are provable:

| Rule | Measured | Share of 10,691 |
| --- | ---: | ---: |
| `-fopt-ladderload`: duplicate load `LDR Rb, [Rn, #0]` from layer 2 on | 98 | 0.92% |
| `-fopt-ladderstage`: dead staging `MOV Rx, Ry` in front of `BNE` | 239 | 2.24% |
| **Total** | **337** | **3.15%** |

Both live in `stm32f4xx_hal_dma_ex.c` (98 / 239); every other TU contributes 0.

### 17.3 The two rules (frozen)

First recognise a **ladder**: three or more layers of the shape
`[LDR Rb, [Rn, #0]]?` / `LDR Rc, .Llit_k` / `CMP Rd, Rc` / `MOV Rx, Ry`{0,1,2} / `BNE Lnext` /
`MOV|MOVW Rv, #imm` (or `LDR Rv, .Llit`) / `B Ljoin`, where the label `Lnext` is immediately
followed by the next layer of the same shape. `Rd` and `Rv` are constant across one ladder; fewer
than 3 consecutive layers is left alone.

**`-fopt-ladderload`**: layer k >= 1 starts with `LDR Rb, [Rn, #0]` with the **same register pair**
as layer 0's load, and between layer 0 and layer k there is **no** `STR/STRB/STRH/STM/LDM/PUSH/
POP/BL/BLX` and no other write to `Rb` or `Rn` => delete that load. (`B` does not count as a
barrier: it jumps to `Ljoin` and cannot re-enter the ladder.)

**`-fopt-ladderstage`**: a layer has one or two `MOV Rx, Ry` immediately before its `BNE Lnext`,
and `Rx` is **written before it is read in both successors** (the taken block = the first
instruction after `Lnext`; the fall-through block = this layer's value materialisation or the next
layer's first write), and nothing sits between those `MOV`s and the `BNE` => delete them. (`MOV`
without `S` does not touch the flags.)

**Refusals (frozen)**: fewer than 3 layers; `Rd`/`Rv` changing between layers; whatever follows
`Lnext` is not the next same-shaped layer (i.e. the ladder is interrupted); the `BNE` target is not
the immediately following label; any `IT` at either end; a missing `Ljoin` or a `Ljoin` that is not
`B`; any unparsed line in the function (`ld_scan` failure).

### 17.4 Criteria (frozen, fixed before the run, not to be re-read afterwards)

Against **10,691 insns**:

| Hits | Verdict |
| --- | --- |
| >= 214 (>= 2.0%) | **landing**: both switches stay, default off, added to the README flag table |
| 107 - 213 | **registered tier**: switches stay, default off, not in the recommended set |
| < 107 | **withdrawn**: keep only the measurements in this section, revert the code |

The metric is the **static instruction count**, as in sections 14/15. This slice does not change
the dynamic execution count (it deletes a duplicate load and dead staging, neither of which alters
the path taken), so no dynamic cost has to be registered -- unlike the "table + loop" rewrite
refused in 17.2, which would have to register one.

### 17.5 Anti-false-green (frozen, four checks, all must pass)

1. **OFF IS OFF**: with both switches off, the 95 TUs' `.s` files are **byte-identical** to
   `10,691 / 381,202 B`.
2. **Must fire**: on the real TU (`stm32f4xx_hal_dma_ex.c`, 26 switches + the four above), three
   arms (load only / stage only / both) are compared line by line against the off arm:
   - load only: every deleted line is a `LDR Rb, [Rn, #0]` of layer 2 or later, count **= 98**,
     and each ladder still has exactly one load at its entry;
   - stage only: every deleted line is a `MOV Rx, Ry` immediately in front of a `BNE`,
     count **= 239**, and the relative positions of every `CMP`/`BNE` are unchanged;
   - both: **337** lines deleted, and **no line added or rewritten** (delete only).
3. **Must not fire**: `stm32f4xx_hal_gpio.c` (same corpus, also shape A, but no duplicate load and
   no staging) is byte-identical; the 4-layer shape-A ladder in `stm32f4xx_ll_utils.c` (ladders
   shorter than 3 are untouched); and a hand-written **pure C** fixture whose three-layer ladder
   has its value register **read before it is written** in both successors -- off and on arms
   byte-identical (this pins "it does not delete every MOV it sees").
4. **Semantics**: a `unicorn` differential on the real function -- set `hdma->Instance` to each of
   the 19 key constants and to one non-matching value, map the `0x40000000` region as writable RAM,
   call `HAL_DMAEx_MultiBufferStart_IT`, and compare the return value, `hdma`'s `State` /
   `ErrorCode` fields and the contents of the written addresses between the off and on arms:
   all 20 inputs equal. `make test` must also be green.

### 17.6 Readings that are not allowed (frozen)

1. Do not call the 1,607 "the S15 bound": that is a static count. The reachable bound is **337**,
   and the difference is the alias proof in 17.2, not "still to do".
2. Do not read 17.2's refusal of cross-statement sharing as "S15 is worthless": 337 insns = 3.15%,
   a landing tier under 17.4, and it is **pure deletion** -- no path change, no new register, no
   literal-pool churn.
3. Do not describe these two rules as "register allocation" or "CSE": they only delete instructions
   that are provably redundant **inside one ladder**; nothing is shared across ladders.
4. Do not relax "written before read in both successors" in `-fopt-ladderstage`: dropping one half
   deletes a live value, and that rule is the whole correct-by-construction argument of this slice.

## 18 S15 measurements and verdict (2026-11-26)

Section 17 is the pre-registration frozen before the run; this section records what the run
produced, where it departs from the pre-registration, and the verdict. "Do not re-read the
criteria after the run" is honoured literally here: **the criteria in 17.4 (static instruction
counts, >= 214 landing / 107-213 registered / < 107 withdrawn) and the two rules themselves are
untouched.** Only the measurements are recorded, with the root cause of the difference spelled
out.

### 18.1 Readings (`D:/tmp/bm/redo15.py`, `redo15b.py`, 95 TUs, 26-flag line)

| arm | instructions | .s bytes |
| --- | ---: | ---: |
| off (26 flags, = S14 final) | 10,691 | 381,202 |
| `-fopt-ladderload` only | 10,593 | 379,144 |
| `-fopt-ladderstage` only | 10,445 | 377,512 |
| both | **10,347** | **375,454** |

The off arm is byte-identical to the S14 final (`cp/s15_off` vs `cp/s14_on`: no difference).
Against armcc5 `-O2` on the same corpus, 5,619 instructions: **1.90x -> 1.84x**
(10,691 / 5,619 = 1.9026; 10,347 / 5,619 = 1.8414).

### 18.2 What changed, line by line

- `-fopt-ladderload` removes **98** lines, all of them reloads of the shape `LDR rX, [rY, #0]`.
  The same function holds 146 loads of that shape; **48** stay.
- `-fopt-ladderstage` removes **246** lines, all of them `MOV rX, rY` staging copies in front of a
  `BNE`: 107 `MOV r0, r5`, 128 `MOV r1, r7`, 11 `MOV r0, r4`.
- Both switches remove **344** lines; the two line sets are **disjoint** and their union is the
  combined arm; **no line is added or rewritten** (delete only).
- Across the 95-TU corpus **only** `stm32f4xx_hal_dma_ex.c` changes; `stm32f4xx_hal_gpio.c` and
  `stm32f4xx_ll_utils.c` (which holds a four-deep shape-A ladder, below the three-layer threshold)
  are byte-identical.
- Of the 48 surviving reloads, 43 have a barrier an independent scan can see (a memory write, a
  call, a rebase) and the other 5 are refused by the shape analysis (ladder shorter than three
  layers, or the earlier load belongs to a different register pair).

### 18.3 Departure from 17.5 item 2 (written down, not silently reworded)

The pre-registration said "stage = 239, both = 337"; the run gives **246 / 344**. There are two
root causes for the +7, and neither loosens a rule:

1. **A `POP`/`LDM` register list used to count as a read and now counts as a write -- but only when
   the list parses exactly.** In the sketch behind 17.3 the "written" test only accepted
   instructions whose first operand is the destination (`MOV`, `LDR`, ...). In the real TU the taken
   arm of a layer begins with `POP {r1}`: that really does write `r1`, yet the earlier
   implementation counted it as a read, so no `MOV r1, r7` could ever be proven. The landing
   implementation adds `ld_list_def()`: it answers "write" only for `POP`/`LDM*` whose operand parses
   from `{` to `}` as `rN`, `rN-rM` or `sp/lr/pc` with nothing left over, and anything unparsed stays
   a read. **That makes the "written" test exact instead of over-conservative; the threshold of rule
   2 (written before read on both successors) is unchanged.**
2. **The bound script under-counted one shape**: `MOV r0, r4` (the value register is `r4`, not
   `r5`), 11 lines, fell outside the `(constant, value-register)` grouping of 17.1.

The tier is therefore unchanged: 344 >= 214 is a **landing**. The measurement basis is still the
static instruction count, and this slice changes no dynamic path, so no dynamic cost is registered.

### 18.4 Verdict

**Landing tier.** 10,691 -> 10,347 instructions = **-344 = -3.22%**, `381,202 -> 375,454 B`
(-5,748 B). Both switches default to off and are listed in the README flag table. Against armcc5 on
the same corpus: 1.90x -> **1.84x**.

### 18.5 Gate (`tests/run_ladder_tests.py`, `make test-ladder`, 23 checks, all green)

1. **OFF IS OFF**: the real TU with both switches and with
   `-fno-opt-ladderload -fno-opt-ladderstage` is byte-identical (76,540 B).
2. **Only the two shapes**: all 98 lines the load arm removes are `LDR Rd, [Rb, #0]`; all 246 the
   staging arm removes are `MOV Rx, Ry` followed by a run of the same and then a conditional branch;
   no line is added; the two sets are disjoint and their union is exactly the combined 344.
3. **Nothing else moves**: `stm32f4xx_hal_gpio.c` and `stm32f4xx_ll_utils.c` are byte-identical
   with both switches on.
4. **Independent re-derivation**: every removed reload has an earlier identical-shape load with no
   barrier in between; every removed staging copy has its destination written before it is read on
   both successors (the scanner follows a `B` to the join itself; an undecidable case is counted
   separately and this run has none). 43 of the 48 surviving reloads are explained by a barrier the
   scanner finds on its own.
5. **Semantics (unicorn differential)**: the fixture issues one `__HAL_DMA_CLEAR_FLAG` per flag kind
   and snapshots the four `IFCR` registers after each (a later write would otherwise mask an earlier
   one and a wrong deletion could not be seen). With `hdma->Instance` set to the 16 stream addresses,
   three out-of-range values and one SRAM pointer -- 20 inputs -- all four arms return the same
   value, and a **sabotaged** copy of the fixture (one `CLEAR_FLAG` deleted) returns a different
   value (124 vs 156), so the differential really is sensitive to a wrong deletion.
6. **Cropped out**: a `-DARKCC_FEATURE_OPT_LADDER=0` build refuses both switches by name (C3900U)
   and, without them, writes the same text as the full build.

### 18.6 Forbidden readings (frozen)

1. Do not read 344 as "above the pre-registered bound, so the rule got bolder": 337 was a
   static-census *estimate*, the +7 has the two root causes of 18.3, and the proof strength is
   unchanged.
2. Do not call 18.3 item 1 a relaxation of rule 2: what changed is how precisely a write is
   recognised (`POP`/`LDM` list parsing), not the "written before read on both successors" test.
3. Do not call the 48 surviving reloads (146 - 98) "still to do": 43 have a barrier and 5 belong to
   ladders below the layer threshold; both are the rule declining on purpose.
4. Do not edit section 17 with these numbers: 17 is the pre-registration record, and post-run
   deviations belong here.

## 19 What is left in the text layer after S15 (2026-11-26, post-run census)

With S15 landed the whole corpus was re-measured to answer one question: **what is the next
slice on top of the current emitter, and what is its bound?**

Baseline: 95 TUs, all 29 `-fopt-*` switches on (the 26 flags + `spill` + `ldhoist` +
`stackframe` + `deadins` + `ladderload` + `ladderstage`) => **10,347 insns / 375,454 B**;
armcc 5.06u7 `-O2` on the same corpus is **5,619 insns** => **1.841x**. Scripts:
`D:/tmp/bm/s16all.py` (compile) and `D:/tmp/bm/cmp16.py` (classify, same classifier as §1).

### 19.1 Category reconciliation (29 flags vs armcc)

| Category | arkc | share | armcc | share | delta |
| --- | ---: | ---: | ---: | ---: | ---: |
| `MOV` immediate | 1,147 | 11.1% | 389 | 6.9% | **+758** |
| `MOV` register | 883 | 8.5% | 214 | 3.8% | **+669** |
| `PUSH`/`POP` | 839 | 8.1% | 156 | 2.8% | **+683** |
| literal pool | 809 | 7.8% | 391 | 7.0% | +418 |
| `[sp, #n]` | 453 | 4.4% | 46 | 0.8% | +407 |
| arithmetic | 735 | 7.1% | 302 | 5.4% | +433 |
| `MOVW`+`MOVT` | 339 | 3.3% | 0 | 0.0% | +339 |
| logic | 732 | 7.1% | 394 | 7.0% | +338 |
| other memory | 1,517 | 14.7% | 1,207 | 21.5% | +310 |
| branches | 1,534 | 14.8% | 1,284 | 22.9% | +250 |
| frame access `[r6, #n]` | 190 | 1.8% | 45 | 0.8% | +145 |
| `CMP`/`CMN`/`TST`/`TEQ` | 606 | 5.9% | 479 | 8.5% | +127 |
| `IT` | 40 | 0.4% | 0 | 0.0% | +40 |
| `BL`/`BLX` | 182 | 1.8% | 153 | 2.7% | +29 |
| other | 50 | 0.5% | 48 | 0.9% | +2 |
| extend/reverse | 81 | 0.8% | 202 | 3.6% | -121 |
| shifts | 212 | 2.0% | 309 | 5.5% | -97 |
| barrier/system | 20 | 0.2% | 22 | 0.4% | -2 |
| **total** | **10,347** | | **5,619** | | **+4,728 (1.84x)** |

Against §1 (26 flags, 11,666) S10-S15 took **1,319 insns = 11.3%**; the four value-transport
categories (`MOV` immediate, `MOV` register, `PUSH`/`POP`, frame access) went from 4,606 down to
**3,059**, still **3.8x** armcc — **value transport remains the only overspent item**. Every other
category is of the same order (shifts and extends are actually below armcc).

### 19.2 Where it is concentrated (arkc side, 210 functions)

| Function | arkc | note |
| --- | ---: | --- |
| `HAL_DMAEx_MultiBufferStart_IT` | 1,598 | 24 comparison ladders / 250 layers, 5 insns per layer |
| `HAL_RCC_OscConfig` | 982 | six `if/else` trees plus bit-field read-modify-write |
| `HAL_DMA_IRQHandler` | 460 | |
| `HAL_RCC_ClockConfig` | 319 | |
| `HAL_RCCEx_PeriphCLKConfig` | 297 | |
| `HAL_GPIO_Init` | 302 | |
| `HAL_DMA_PollForTransfer` | 195 | |
| top ten functions | 4,308 | 41.6% of the corpus |

`HAL_DMAEx_MultiBufferStart_IT` went from 2,120 in §17 to 1,598 (S15 took 522), but each layer is
still **5 insns** (`LDR Rc, .Llit_k` / `CMP Rd, Rc` / `BNE Lnext` / `MOV|MOVW Rv, #imm` /
`B Ljoin`). gcc emits 292 insns for the same function: the compared value is **loaded once**
(in `r4`), the successor constants are **derived arithmetically** (`ADD r3, r3, #24`), and the
selected value is **folded into the memory access of its arm**. All three need "pick a register for
the compared value" and "fold the selection into the access" — both live in the emitter, and the
text layer can only watch the five lines that were already fixed at emission time.

### 19.3 Remaining candidate families and their bounds (29 flags, 10,347 basis)

Script `D:/tmp/bm/ub19.py` (per function, per basic block; every number is an **upper bound**,
not a reachable amount):

| Candidate | bound (insns) | of 10,347 | why it is hard to realise |
| --- | ---: | ---: | --- |
| result born in its destination (`MOV rD, r0` right after a write to `r0`) | 311 | 3.01% | the emitter must choose the destination register up front; a text rewrite has to deal with 16/32-bit encoding growth (no byte win) |
| base folded into the addressing mode (`ADD rB, rX, #imm` then one use of `[rB]`) | 209 | 2.02% | needs `rB` dead in the block; `-fopt-addr` already took the foldable part |
| single-register `PUSH`/`POP` round trip | 202 / 109 | 1.95% | LIFO pairing across blocks; S10 already cut 501 -> 202 |
| duplicate immediate materialisation inside a block | 47 | 0.45% | what `-fopt-constcache` covers |
| literal base hoisting (§13) | 140 | 1.35% | needs a dedicated register |
| dead frame stores (§13) | 91 | 0.88% | |

The first three overlap (the same `r0` birth point and the same `ADD` base), so **adding them is not
a reachable amount**: conservatively, in the spirit of §17.2, some **350-450 insns = 3.4%-4.4%**
can be cashed, i.e. **10,347 -> about 9,900-10,000, 1.76x-1.78x**.

### 19.4 Verdict (frozen)

1. **The text layer ends here**: no single family has a bound above 3.0%, and no one slice can push
   1.84x below 1.5x.
2. **The 1,300 insns in `HAL_DMAEx_MultiBufferStart_IT` are not a text-layer bill**: they need
   (a) a register for the compared value that the result constants do not clobber, (b) successor
   constants derived arithmetically, (c) the selection folded into a memory access — all three live
   in the emitter/IR, and only the register-machine model of §4 can take them.
3. **Cross-ladder sharing stays rejected per §17.2**: between two ladders there is a
   `STR Rv, [r1, #0]` writing `DMA1/2->IFCR`, and the text layer has no aliasing information to
   prove it cannot hit `*(r8 + #0)`.
4. **The next slice needs a project-level decision**: either "S16 result born in its destination +
   base folded into addressing (about 3.4%-4.4%)", or "S17 change the emitter model (§4 bound
   1.28x-1.40x, costed as a new project)", or "close the performance line". This section only
   records measurements; it pre-registers nothing.

## 20 S16 pre-registration: result born in its destination + base folded into the address (2026-11-26, frozen before implementation)

Once §19 had measured what is left in the text layer, the project-level decision was to open this
slice: **two rewrites that only need to hold inside a single basic block.** This section freezes the
bound and the rules, then the criteria and the anti-false-green checks; the implementation and the
measurements go into §21.

### 20.1 Bound (read-only measurement, 2026-11-26)

Baseline: 95 TUs, all 29 flags **10,347 insns / 375,454 B**. Scanner
`D:/tmp/bm/s16_ub2.py`, whose rules correspond one-to-one to 20.2 and which carries its own forward
liveness test `dead_after()` (walk forward, follow one unconditional `B` to its label, treat a
conditional branch, a call or an unknown target as "not provable" and count it separately).

| Family | hits | of 10,347 | where |
| --- | ---: | ---: | --- |
| A result born in its destination | **278** | 2.69% | `hal_rcc` 61 / `hal_dma` 57 / `hal_gpio` 44 / `hal_flash_ex` 20 / `hal_exti` 17 / `hal_dma_ex` 16 ... (12 TUs) |
| B base folded into the addressing mode | **45** | 0.44% | `hal_dma` 28 / `hal_rcc` 8 / `hal_dma_ex` 4 / `hal_rcc_ex` 2 ... (6 TUs) |
| **total** | **323** | **3.12%** | 14 TUs; the other 81 are unchanged |

Sites the rules decline, counted by the same scanner and frozen here so that they cannot later be
read as "not done": of the 428 `MOV rD, r0` sites, 122 have a predecessor that does not write `r0`,
4 still read `r0` on some successor, 5 meet a conditional branch, 2 an unknown jump target, 1 a
call, and 16 would push a 16-bit encoding to 32 bits; family B additionally declines 46 sites where
`rB` is still read after the access, 40 whose target is not provable and 12 with a call in between.

### 20.2 The two rules (frozen)

**A `-fopt-birthdest` (result born in its destination)**: two adjacent instructions
`OP r0, ...` / `MOV rD, r0` with `rD != r0`, where

1. `OP` is **single-destination** (`MOV`/`MOVW`/`MOVT`/`LDR*`/`ADD`/`SUB`/`AND`/`ORR`/`EOR`/
   `BIC`/`LSL`/`LSR`/`ASR`/`ROR`/`MUL`/`MVN`/`RSB`/`ADC`/`SBC`/`UXT*`/`SXT*`/`REV*`) and
   **unconditional** (a conditional write such as `MOVEQ`/`LDRNE` is never accepted: when the
   condition fails the original keeps the old value of `r0`, while a rename would keep a different
   one);
2. the other operands of `OP` may read `r0` (`AND r0, r0, #6` -> `AND rD, r0, #6` is equivalent
   because `r0` is left untouched and the read still sees the old value);
3. `r0` is **not needed** after the `MOV`: walking forward, the next touch of `r0` must be a write;
   one unconditional `B` to a label may be followed (at most 8 hops); `POP`/`LDM` that write `r0`
   count as a write, while a list containing `pc` that does not write `r0` is **not provable**
   (`r0` is the return value there); `BL`/`BLX`/`BX`, a conditional branch or an unknown target is
   **not provable**;
4. when `rD` is outside `r0`-`r7`, an `OP` that is currently 16-bit encodable may not be pushed to
   32 bits (`narrow_ok()`, conservative: every register <= `r7` and a small enough immediate);
5. an `OP` with a writeback suffix (`... !`) is left alone.

On a hit: rewrite the first operand of `OP` to `rD` and delete the `MOV`. That is **one rewritten
line plus one deleted line**, unlike the previous five slices, so the gate checks that the rewrite is
exactly "destination register becomes `rD`, every other byte unchanged".

**B `-fopt-basefold` (base folded into the addressing mode)**: `ADD rB, rX, #imm` (`imm > 0`,
a multiple of 4, <= 1020) followed within 1-5 instructions by **the only** use of `rB`, which is
`LDR|STR|LDRB|STRB|LDRH|STRH rD, [rB]` or `[rB, #off]`, provided

1. between the `ADD` and that access there is no label, branch, call, `PUSH`, `POP`, `LDM`, `STM`
   or `IT`, no other reference to `rB`, and no write to `rX`;
2. the folded offset `imm + off <= 4095` (the `LDR`/`STR` immediate field) and the access does not
   mention `rX`;
3. the value register of a `STR*` is not `rB` (after deleting the `ADD`, `rB` no longer holds that
   address);
4. `rB` is not needed after the access (item 3 of A, starting at the access).

On a hit: rewrite the access to `[rX, #imm+off]` (`[rX]` when the sum is 0) and delete the `ADD`.

### 20.3 Criteria (frozen, fixed before the run)

Relative to **10,347 insns** (static instruction count, the same basis as §14/§15/§17):

| hits | verdict |
| --- | --- |
| >= 214 (>= 2.0%) | **landing**: both switches kept, default off, listed in the README flag table |
| 107 - 213 | **registration tier**: switches kept, default off, not in the recommended set |
| < 107 | **withdrawn**: keep the measurements only, revert the code |

### 20.4 Anti-false-green (frozen, six checks, all must pass)

1. **OFF IS OFF**: with both switches off the 95 TUs are **byte-identical** to 10,347 / 375,454 B.
2. **Must fire, and only per the rules**: four arms on the real corpus (A only / B only / both /
   neither), diffed line by line: the A arm has exactly **278** "one rewrite + one delete" sites and
   the rewritten line differs from the deleted one only in the destination register (`r0` -> `rD`);
   the B arm has exactly **45** such sites and the rewrite must relate the two lines as
   `[rB(, #off)]` -> `[rX, #imm+off]` with the same `imm + off` the static scanner reports; the two
   arms touch disjoint line sets and together give **323**.
3. **Independent re-check**: from the finished `.s` the scanner recounts all four arms -- every A
   site must be preceded by a single-destination instruction that now writes `rD`, and every B site
   must have its `ADD` gone with the right offset -- and re-proves "`r0`/`rB` is dead" for each site
   (anything unprovable counts as a failure).
4. **Must not fire**: two hand-written pure-C fixtures -- (a) `MOV rD, r0` where `r0` is still read
   afterwards; (b) `ADD rB, rX, #imm` where `rB` is referenced again. Both arms byte-identical.
5. **Semantics**: `unicorn` differential -- the same fixture run on all four arms with 12 input sets
   (including two out-of-range and two aliasing cases), with identical return values and memory
   snapshots; plus a **sabotaged** build (one rewrite deliberately names the wrong register) to show
   the differential is sensitive.
6. **Cropped**: a `-DARKCC_FEATURE_OPT_REGBIRTH=0` build refuses both switches by name (C3900U) and,
   without them, writes the same text as the full build; `make test` all green.

### 20.5 Forbidden readings (frozen)

1. Do not read 323 as "S16 saves 323 instructions" without also saying the **dynamic execution count
   does not change**: every removed instruction is a copy or a recompute inside one basic block that
   would have run anyway, and no branch structure changes.
2. Do not call family A a relaxation of `-fopt-live`/`-fopt-copyprop`: those delete a copy that is
   overwritten inside a block, whereas this family **changes the destination register of the
   producer** and therefore needs forward liveness.
3. Do not call family B "`-fopt-addr` left undone": `-fopt-addr` folds an address chain **inside one
   expression**, this family folds "a base register that exists for exactly one access" across
   statements, which `-fopt-addr` cannot reach by construction.
4. Do not reconcile 20.1's 428/122/... against §19's 311: §19's 311 is a **loose upper bound**
   (only "the previous instruction writes `r0`", no provable-death, no encoding and no conditional
   write), while 20.1's 323 is the **provable, reachable amount**.

## 21 S16 landing readings and verdict (2026-11-26)

Both rules of S20 are implemented (`ark_regbirth_function` in
`src/backend/arm/backend_arm.c`), with the switches `-fopt-birthdest` /
`-fopt-basefold` (off by default) and the crop macro `ARKCC_FEATURE_OPT_REGBIRTH`.
This section records only the readings, the verdict and the **root causes of the
implementation deviations**; the criteria are still the ones frozen in S20.3 and
are not rewritten after the fact.

### 21.1 Measurement (95 TUs, 29 flags, one build, 2026-11-26)

| arm | instructions | `.s` bytes | vs 10,347 |
| --- | ---: | ---: | --- |
| both off (baseline) | **10,347** | 375,454 | -- |
| `-fopt-birthdest` | **10,189** | 373,084 | **-158 (-1.53%)** |
| `-fopt-basefold` | **10,330** | 375,131 | **-17 (-0.16%)** |
| both on | **10,172** | 372,761 | **-175 (-1.69%)** |

The two arms add up (158 + 17 = 175) and act on disjoint line sets (checked line by
line by the gate). Against armcc5's 5,619 instructions (S17 basis) the ratio moves
from **1.841x** to **1.810x**.

**Verdict: registration tier.** 175 falls in S20.3's `107 <= hits < 214` band: both
switches are kept, off by default, not part of the recommended set -- and S20.3's
table is not edited to fit the implementation.

### 21.2 Per-TU distribution (only 16 TUs hit)

| TU | baseline | A | B |
| --- | ---: | ---: | ---: |
| `stm32f4xx_hal_dma.c` | 1,481 | 43 | 1 |
| `stm32f4xx_hal_gpio.c` | 595 | 25 | 3 |
| `stm32f4xx_hal_flash_ex.c` | 700 | 19 | 0 |
| `stm32f4xx_hal_dma_ex.c` | 1,708 | 16 | 3 |
| `stm32f4xx_hal_rcc.c` | 1,736 | 16 | 4 |
| `stm32f4xx_hal_flash.c` | 680 | 14 | 2 |
| `stm32f4xx_hal_exti.c` | 446 | 11 | 2 |
| `stm32f4xx_hal_rcc_ex.c` | 710 | 4 | 2 |
| `main.c` | 133 | 3 | 0 |
| `stm32f4xx_ll_utils.c` | 564 | 2 | 0 |
| `gpio.c` | 56 | 1 | 0 |
| `stm32f4xx_hal.c` | 295 | 1 | 0 |
| `stm32f4xx_hal_cortex.c` | 571 | 1 | 0 |
| `stm32f4xx_hal_pwr_ex.c` | 259 | 1 | 0 |
| `system_stm32f4xx.c` | 127 | 1 | 0 |
| the other 79 TUs | -- | 0 | 0 |

Only these 16 TUs of the corpus have real bodies (the other `.s` files are five
lines), so **OFF IS OFF cannot be shown with a quiet TU the way S15 did it**; it is
shown over all 95 TUs byte for byte (21.4 item 1).

### 21.3 Implementation deviations and their causes (all four are "more conservative than pre-registered")

1. **Family A fell from 278 to 158, and the main cause is that the two-operand form
   would change the value (not a missed optimisation).** The corpus has **308**
   adjacent `OP r0, ...` / `MOV rD, r0` pairs; in **116** of them the producer is a
   **two-operand** form (`AND` 45, `LSL` 36, `ORR` 25, `MUL` 8, `LSR` 2). In the
   emitter and in the 16-bit encodings, `AND r0, r7` means **`r0 = r0 & r7`**
   (`Rd = Rd OP Rm`; encodings `0x4000`/`0x4300`/`0x4040`/`0x4380`), so renaming it to
   `AND rD, r7` computes `rD = rD & r7` -- **the rename changes the value**.
   S20.2 item 2 ("the other operands may read `r0`") only holds for the three-operand
   form, where `r0` is a source and keeps its old value; a two-operand form uses `r0`
   as both source and destination and must be refused as a family.
   The implementation adds `rb_pure_dest()`: three-operand forms are always pure
   destinations, two-operand forms are only allowed for
   `MOV/MOVW/MOVT/MVN/LDR*/UXT*/SXT*/REV*/RRX/CLZ`.
   **This is the most important result of the round**: not a smaller count, but 116
   sites that would otherwise have been turned into wrong code.
2. **The rest of the A refusals (each re-derived per site by the gate, no "unknown")**:
   `encoding` 25 (the rename would push a 16-bit encoding to 32 bits), `live` 5 (`r0`
   is still needed after the `MOV`), `dest_in_ops` 4 (`rD` appears among the producer's
   source operands). 158 + 116 + 25 + 5 + 4 = 308, which matches the number of adjacent
   pairs.
3. **Family B fell from 45 to 17, and the main cause is a defect in the pre-measurement
   scanner.** `D:/tmp/bm/s16_ub2.py`, used for S20.1, treated `.L...:` lines as assembler
   directives rather than labels, so sites where the `ADD` and the access are separated
   by a label were judged "provably dead" (about 28 of them); the implementation breaks
   at `ld_kd[j] == 2`, which is the correct behaviour.
   The other cause is `ld_list_def`'s gap on register lists written `{r5, r6, ...}`
   (space after the comma); S16 carries its own `rb_list_def`, which wins back **+2**
   sites. The remaining implementation conservatism (all-operand check, `IT*`
   exclusion) is unchanged.
   Refusal census for the 507 refused B candidates (gate classifier):
   `index_written` 244, `live` 144, `other_base` 96, `barrier` 12, `imm_range` 9,
   `label_between` 2.
4. **What was not done (and does not count towards 175)**: rewriting a two-operand
   producer into a three-operand one (`AND r0, r7` + `MOV r5, r0` -> `AND r5, r0, r7`).
   It is semantically right and also removes an instruction, but it is **a new rule**
   (it needs the death of `r0` and a deliberate 16-bit -> 32-bit re-encoding) and it
   needs its own pre-registration and criteria; it is left for a separate slice and may
   not be counted into this one.

### 21.4 Gate (`tests/run_regbirth_tests.py`, `make test-regbirth`, six checks, all green)

1. **OFF IS OFF**: all 95 TUs, both switches off vs
   `-fno-opt-birthdest -fno-opt-basefold`, byte-identical, and the total is still
   `10,347 / 375,454 B`.
2. **Only the two shapes**: line-by-line classification of the four arms -- the A arm
   changes exactly 158 sites, each one "one rewritten line + one deleted line" where the
   only difference is the destination register (`r0` -> `rD`); the B arm changes exactly
   17, each `[rB(, #off)]` -> `[rX, #imm+off]` with the `imm + off` the static scanner
   reports; the two arms are disjoint and together give 175; no line is ever added or
   rewritten into a third shape.
3. **Independent reconstruction**: `tests/rb_oracle.py` re-implements both rules from the
   text alone (no shared code or constants with the compiler) and reproduces all 285
   non-off texts byte for byte; every deleted anchor is re-proved dead (`r0`/`rB` written
   before it is read), every offset fits, every encoding guard holds.
4. **It declines when it must**: all 657 refused candidates are still in the text (each in
   the arm that would have used it: A in the A-only arm, B in the B-only arm), every
   refusal is re-derivable from the unoptimised text (`unknown` = 0), and two hand-written
   "must not fire" fixtures are byte-identical in all four arms.
5. **The answer does not change**: one emit-and-run fixture with four A sites and one B
   site returns the same value and the same 256-byte RAM snapshot in all four arms over 12
   inputs; a **sabotaged** copy (one folded store removed) returns a different value
   (247 vs 38), so the differential does see a wrong deletion.
6. **Cropped out**: a `-DARKCC_FEATURE_OPT_REGBIRTH=0` build refuses both switches by name
   (C3900U) and, without them, writes the same text as the full build.

### 21.5 How to read this (S20.5 still stands)

1. 175 is a **static instruction count**, one deleted instruction per hit; the **dynamic
   execution count does not change**, since every removed instruction is a copy or a
   recompute inside one basic block that would have run anyway, and no branch structure
   changes.
2. The verdict is "registration tier", not "landing": the criteria are untouched, nothing
   was bent to fit the implementation, and the switches stay out of the recommended set.
   Raising the tier later requires a new slice with a fresh measurement and freshly frozen
   criteria.
3. `116` must always be quoted with its meaning: it is the number of sites where the rule
   **as written would have changed the value**, not "116 instructions left on the table" --
   under the current rules those sites must not be touched at all.

## 22 S17 pre-registration: same-value comparison-run folding (2026-11-26, frozen before implementation)

§19.4 wrote off "the 1,300 instructions of `HAL_DMAEx_MultiBufferStart_IT`" as emit/IR-layer
work, because it needs (a) a register chosen for the compared value, (b) a running
constant stepped by a fixed stride, and (c) the selected result folded into the access.
This round took that function apart layer by layer and found a **fourth shape** inside it:
**adjacent comparison layers that pick the same result value repeat the same carry work**.
That shape needs no alias information, no register allocation and moves no branch target, so
the text layer can fold it -- **350 instructions = 3.38%**, twice the size of S16's two rules
combined (175). This section freezes the rule and the criteria; the implementation and the
measurement go in §23.

### 22.1 Slice census (2026-11-26, five candidate families, all measured by local scripts)

| Candidate family | Script | Measured upper bound | Verdict |
| --- | --- | ---: | --- |
| pool constant folded into an immediate (`LDR Rc, .Llit` feeding an ALU op) | `D:/tmp/bm/ub20.py` | **0** | of 809 pool loads only 277 feed an ALU op, and every constant is > 255 (peripheral addresses) |
| census of `MOV reg,reg` sources | `ub21.py` | 858 sites, 540 with the source dead afterwards | needs cross-block liveness; not redeemable in text |
| `MOV` chain folding (`MOV rA,rB` + `MOV rC,rA`) | `ub22.py` | **6** | too small |
| small immediate materialised and used once | `ub23.py` | **14** | too small |
| **same-value comparison runs** | `ub33.py` | **350** (60 runs) | **this slice** |

So this is not "§19.4 said there was nothing left, so a slice was invented": §19.4 pushed the
whole account of that function to the emitter, but the part of it where **one flag bit is
shared by four instances** only ever lived in the text.

### 22.2 Where the shape comes from (a public macro expansion, not corpus tuning)

The five ladders come from five public STM32 HAL macros:
`__HAL_DMA_GET_TC/HT/TE/DME/FE_FLAG_INDEX(hdma)`. The macro body is a chain of ternaries that
maps **every concrete stream address** of `hdma->Instance` to one flag bit:

```c
#define __HAL_DMA_GET_TC_FLAG_INDEX(__HANDLE__) \
  (((uint32_t)((__HANDLE__)->Instance) == ((uint32_t)DMA1_Stream0)) ? DMA_FLAG_TCIF0_4 : \
   ((uint32_t)((__HANDLE__)->Instance) == ((uint32_t)DMA2_Stream0)) ? DMA_FLAG_TCIF0_4 : \
   ((uint32_t)((__HANDLE__)->Instance) == ((uint32_t)DMA1_Stream4)) ? DMA_FLAG_TCIF0_4 : \
   ((uint32_t)((__HANDLE__)->Instance) == ((uint32_t)DMA2_Stream4)) ? DMA_FLAG_TCIF0_4 : \
   ... )
```

One flag bit serves Stream *k* **and** Stream *k+4*, and each stream exists on both DMA1 and
DMA2, so four adjacent layers compare different constants
(`0x40026010 / 0x40026410 / 0x40026070 / 0x40026470`) while **picking the same value**
(`#32`). Each layer lands in the `.s` as five instructions:

```asm
    LDR r7, .Llit_2_0_2        ; 32-bit stream address
    CMP r4, r7
    BNE .L_..._17              ; not equal -> next layer
    MOV r0, #32                ; the value this layer selects
    B   .L_..._18              ; the join shared by all layers
.L_..._17:
```

All four layers write `MOV r0, #32` / `B join` and are simply walled off by the preceding
`BNE` -- **three of the four carries are pure waste**.

### 22.3 The rule (frozen)

**Layer**: five consecutive instructions (label lines may sit in between, assembler
directives may not):

```
LDR rL, .Llit          ; op[1] starts with `.L` (a literal-pool load), rL is a register
CMP rX, rL             ; exactly two operands
BNE Lnext              ; this slice accepts BNE only; every other condition is refused
MOV|MOVW rD, #v        ; exactly two operands
B J                    ; immediately after the MOV, with no label in between
```

**Run**: two or more adjacent layers such that

1. every layer's `CMP` operands are **byte-identical text** (same `rX`, same `rL`);
2. every layer picks the same shape and value: same `MOV`/`MOVW` mnemonic, same `rD`,
   identical `#v` text;
3. layer k's `BNE` (k < m) resolves **exactly to the `LDR` of layer k+1**;
4. every layer's `B J` resolves to **one and the same instruction**;
5. `rD` differs from `rX` and from `rL` (the proof stays in the simplest case).

**Rewrite**: a run of m layers becomes

```
    LDR rL, .Llit_1               ; layer 1, unchanged
    CMP rX, rL
    BEQ .Lcf_<f>_<i>              ; only the BNE is inverted, retargeted to a fresh label
    LDR rL, .Llit_2               ; layers 2..m-1: LDR/CMP unchanged, BNE inverted
    CMP rX, rL
    BEQ .Lcf_<f>_<i>
    ...
.L_..._k:                         ; each layer's original entry label **stays in place**
    LDR rL, .Llit_m               ; layer m: LDR/CMP unchanged, BNE kept
    CMP rX, rL
    BNE Lnext
.Lcf_<f>_<i>:                     ; new: the hit point
    MOV rD, #v                    ; layer m's MOV/B unchanged
    B J
```

Net effect: delete `2(m-1)` instructions, rewrite `m-1` (`BNE` -> `BEQ`), add `m-1` label lines.

**Why every original entry label can stay exactly where it is**: entering at layer k executes
`LDR/CMP/BNE/MOV/B J`, instruction for instruction what it executed before, so even if some
other branch still targets layer k the semantics do not move. That is why this rule needs no
label reference counting at all.

**Deliberate limits**:

- Only `BNE` is inverted to `BEQ`; the inversion table for
  `BEQ/BLS/BHI/BLT/BGE/BLE/BGT/BCS/BCC/BMI/BPL/BVS/BVC` is **not implemented here** -- a
  non-`BNE` layer is refused outright (rather an error than a wrong answer).
- A run lives inside one function and one contiguous instruction stream; a directive line
  inside a layer refuses the run.

### 22.4 Upper bound and criteria (frozen before the run)

Against **10,347 instructions / 375,454 B** (95 TUs, 29 flags -- the same yardstick as
§14/§15/§17/§20):

| Item | Count |
| --- | ---: |
| foldable runs | **60** (lengths: 56 runs of 4, 3 runs of 3, 1 run of 2) |
| layers inside runs | 235 (238 layers exist; 3 do not form a run) |
| net static instructions | **350** (`2*3*56 + 2*2*3 + 2*1*1 = 336 + 12 + 2`) |
| net `.s` bytes | **442** (`MOV` 2 B / `MOVW` 4 B, counted per run) |
| TUs hit | 1 (`stm32f4xx_hal_dma_ex.c`, 1,708 instructions) |

| Hits | Verdict |
| --- | --- |
| >= 214 (>= 2.0%) | **landing**: the switch stays, default off, added to the README flag table |
| 107 - 213 | **register tier**: the switch stays, default off, not recommended |
| < 107 | **withdrawn**: only the measurement stays, the code is reverted |

350 >= 214, so the expected verdict is **landing**; if the run comes in under 214 the tier
drops accordingly and **the table is not rewritten to fit the implementation**.

### 22.5 Anti-false-green (frozen, six gates, all must pass)

1. **OFF IS OFF**: with the switch off, all 95 TUs are **byte-identical** to
   `10,347 / 375,454 B`.
2. **It must fire, and only as the rule says**: the on-arm has exactly **60 runs / 175
   `BNE`->`BEQ` rewrites / 350 deleted lines (175 `MOV` + 175 `B`) / 175 added label lines**;
   every deleted `MOV` has the same shape and value as the one kept, every deleted `B` has the
   same target as the one kept; a rewritten line differs from the original only in the mnemonic
   and the target label; no fourth shape appears.
3. **Independent check**: a separate re-implementation on the `tests/` side (sharing no code
   or constant with the compiler) reproduces the on-arm byte for byte across 95 TUs, and
   re-proves per run that each `BNE` targets the next layer's `LDR`, that all `B`s share one
   target, and that the `CMP`/`LDR` operands are identical text.
4. **It must not fire** (four hand-written fixtures, on-arm byte-identical):
   (a) same shape but different result values; (b) same value but different `B` targets;
   (c) same value but a label between the `MOV` and the `B`; (d) same value but the conditional
   branch is `BEQ` (this slice inverts `BNE` only).
5. **Semantics**: a `unicorn` differential over a fixture holding one 4-layer run plus one
   non-matching input; both arms return the same value and the same 256 B RAM snapshot, and a
   **sabotaged** build (the merged `BEQ` deliberately turned back into `BNE`) returns something
   different.
6. **Cropping**: a build with `-DARKCC_FEATURE_OPT_CHAINFOLD=0` rejects `-fopt-chainfold` by
   name (C3900U), and without the switch it is byte-identical to the full build; `make test` is
   green.

### 22.6 Forbidden readings (frozen)

1. 350 is not a dynamic win: every removed `MOV`/`B` was **never executed** (the preceding
   `BNE` walls it off), so **dynamic instruction count is unchanged**. The win is static size,
   fetch and branch-predictor pressure -- which also means it can never make a bench slower;
   the worst case is zero.
2. Do not claim "§19.4 was wrong": §19.4's item 2 judged (a)(b)(c) of that function, and this
   slice folds a fourth shape it did not count. All three original judgements stand.
3. Do not call this CSE: no ladder traversal is merged and no comparison result is shared
   across runs; only the repeated carry of a same-value run is deleted.
4. Do not reconcile 350 against §19.3's 350-450: that figure is the redemption estimate for
   three other families (birth/base/pair), a different yardstick and different families.

## 23 S17 landing readings and verdict (2026-11-26)

The rule of §22 is implemented (`ark_chainfold_function`, `src/backend/arm/backend_arm.c`),
the switch is `-fopt-chainfold` (default off) and the crop macro is
`ARKCC_FEATURE_OPT_CHAINFOLD`. This section only records the readings, the verdict and the
**root cause of the byte deviation**; the criteria themselves are §22.4, unchanged after the run.

### 23.1 Measurement (95 TUs, one build, 2026-11-26)

| Arm | Instructions | `.s` bytes | Versus off |
| --- | ---: | ---: | --- |
| switch off (the post-S16 baseline) | **10,172** | 372,761 | -- |
| `-fopt-chainfold` | **9,822** | 358,964 | **-350 (-3.44%)** / **-13,797 B (-3.70%)** |

Against armcc5's 5,619 instructions (§17 yardstick) the ratio moves from **1.810x** to **1.748x**.

**Verdict: landing tier.** 350 >= the 214 threshold of §22.4 (2.0%) -- the switch stays,
default off, and is added to the README flag table. The criteria table is not touched.

### 23.2 Per-TU distribution (exactly one TU is hit)

| TU | off insns | off bytes | on insns | on bytes |
| --- | ---: | ---: | ---: | ---: |
| `stm32f4xx_hal_dma_ex.c` | 1,689 | 70,503 | 1,339 | 56,706 |
| the other 94 TUs | -- | -- | unchanged | unchanged |

All 60 runs live in `HAL_DMAEx_MultiBufferStart_IT`. The low coverage is not a rule problem:
in this corpus the ladder shape ("one compared register, several same-value arms") only occurs
in that one function.

### 23.3 Byte deviation and its root cause (§22.4 predicted -442 B, the run measured -13,797 B)

**The 442 B of §22.4 is not changed**: it is the correct upper bound under the
"encoded length of the removed `MOV`/`MOVW`" yardstick. The -13,797 B reported here uses a
different yardstick -- `.s` text bytes. The whole difference comes from three things, each
accounted for line by line:

1. **Yardstick**: every reading since §14 (S14/S15/S16/S17) counts `.s` text bytes
   (including the 2 B `\r\n`), not encoded lengths. Deleting an instruction saves the **whole
   text line**, not its 2-4 B of machine code.
2. **Every rewrite is "3 lines -> 1 line"**. Measured sample (first block of `dma_ex`,
   lengths include `\r\n`):
   `    BNE .L_HAL_DMAEx_MultiBufferStart_IT_17` (44 B) +
   `    MOV r0, #32` (16 B) +
   `    B .L_HAL_DMAEx_MultiBufferStart_IT_18` (42 B) = 102 B,
   replaced by `    BEQ .Lcf_2261_126` (22 B) => **-80 B** per block (-82 B when the deleted
   instruction is a `MOVW`). 175 x 80/82 ~= **-14,730 B**.
3. **On top of that, 60 generated label lines are added**
   (`.Lcf_<buffer offset>_<LSR line of the run head>:`, about 16 B each with `\r\n`):
   **+933 B**.

Total -14,730 + 933 = **-13,797 B**, matching the measurement byte for byte; the instruction
count drops by exactly 350 because a label is not an instruction (so §22.4's 350 needs no
correction).

### 23.4 Gate (`tests/run_chainfold_tests.py`, `make test-chainfold`, six checks, all green)

1. **OFF IS OFF**: all 95 TUs, switch off vs `-fno-opt-chainfold` are byte-identical, and the
   totals are still `10,172 / 372,761 B` (the post-S16 baseline was not silently changed).
2. **Only the rule's edits appear**: the diff holds exactly two shapes -- `replace 3->1`
   (`BNE` / `MOV|MOVW rD,#v` / `B` -> `    BEQ .Lcf_...`), **175** of them, and `insert 0->1`
   (`.Lcf_...:` label lines), **60** of them; 175 rewrites, 175 `MOV` deleted, 175 `B`
   deleted, 60 labels added, and no third shape.
3. **Independent re-derivation**: `tests/cf_oracle.py` re-implements the rule on its own
   (sharing no code or constants with the compiler); over all 95 TUs it reproduces the on-arm
   **byte for byte** after normalising label names, 60 runs in total. It also re-proves every
   run structurally **from the folded text**: each replaced triplet really is `LDR/CMP/BEQ` on
   one register, the kept layer still reads `LDR/CMP/BNE` and still ends in `MOV|MOVW rD,#v`
   plus `B`, the generated label sits exactly in front of that kept `MOV`, and the kept layer
   is not folded again. **Why the "turn the `BEQ` back into a `BNE` and reassemble" sabotage is
   not used**: arkcc does not accept `.s` as an input that produces an executable image
   (a hand-run `--vector-table -o x.bin` emits only 446 B with `entry 0x08000401` out of range,
   and unicorn faults), so the breakage of item 5 is done at the **C level** and the wording
   says so ("the harness sees a lost assignment") instead of pretending to be an
   assembly-level sabotage.
4. **Must not fire**: a hand-written `MUSTNOT` fixture with the same shape but four different
   values yields **0 runs** and both arms are byte-identical; the corpus census finds **247**
   layers with reasons `{'extend': 175, 'move_form': 31, 'no_following_layer': 25,
   'value': 16}`, every refusal is re-derivable from the off-arm text (`unknown` = 0), and
   every refused layer is verified line by line to still be untouched in the text.
5. **Semantics**: an `emit-and-run` fixture that really carries a four-layer run (run sizes
   `[4, 4]`) returns the same value and the same 256 B RAM snapshot in both arms
   (**190 / 190**, equal to the expectation computed independently from the C source in
   Python); the **sabotaged** build (first layer keeps the else-value -- exactly what a wrong
   fold does, a lost assignment) returns **238 != 190**, which proves the differential sees a
   wrong fold.
6. **Crop**: a build with `-DARKCC_FEATURE_OPT_CHAINFOLD=0` refuses `-fopt-chainfold` by name
   (`C3900D` / `C3900U`, rc=1) and, without the switch, writes text byte-identical to the full
   build; `make test` is green.

### 23.5 Readings (the forbidden readings of §22.6 still hold)

1. 350 is a static instruction count; **the dynamic instruction count is unchanged** (every
   deleted `MOV`/`B` sits behind a `BNE` and was never executed). The win is static size, fetch
   and branch-predictor pressure; the worst case is zero and no benchmark can get slower.
2. The verdict "landing tier" only means "the switch stays, default off, listed in the README
   flag table"; it does not mean recommended. To raise the tier, measure again in a new slice
   and freeze new criteria.
3. Do not call this CSE; do not reconcile 350 against §19.3's 350-450 (different yardstick,
   different families); do not claim "§19.4 was wrong" (it judged three other shapes).

### 23.6 New debt found in this round (does not affect this verdict; queued as the next slice)

The first version of the gate fixture indexed with `src[i % 6u]` and read the global back in
the same function; it returned 109 in both arms instead of 190. Chasing that exposed a
**different** defect: under `--reloc-data`, `-fopt-copyprop` splits a `MOVW`/`MOVT` pair.

- Minimal repro (`D:/tmp/bm/cf/m7.c`): `seen[0] = src[i % 6u]; acc = acc*31u + seen[0];`
- It emits `MOVW r0, #24` / `MOVT r7, #8192` / `LDR r7, [r7, #0]` (the `MOVT` destination does
  not follow), so every iteration reads `src[0]`; arkcc returns **192**, gcc returns **134**.
- Required conditions: `-fopt-copyprop` must be in the chain (removing it makes the bug
  disappear) and `--reloc-data` must be on (without it the value comes from the literal pool
  and is correct) -- so it is a multi-pass chain trigger that the current 95 TU corpus does
  not cover.
- Nature: **wrong code**, which violates "rather an error than a wrong answer". The fixture now
  uses an explicit wrap index (`if (++k == 6u) k = 0u;`) to avoid it, so this slice's readings
  and verdict are unaffected. That slice needs its own pre-registration: freeze the criteria
  first (`MOVW`/`MOVT` must share the destination register, `m7.c` compared against gcc, 95 TU
  OFF IS OFF), then fix, then add a standing gate.

## 24 S18 pre-registration: `MOVT` is not a complete definition (2026-11-26, frozen before implementation)

### 24.1 The defect (reproduced first, criteria frozen after)

The first version of the S17 gate fixture (`src[i % 6u]` indexing plus a same-function read-back of
the global) returned 109 in both arms instead of 190. The cause is unrelated to S17: it is a **wrong
rename** in `-fopt-birthdest` (S16).

- Minimal repro `D:/tmp/bm/cf/m7.c` (`seen[0] = src[i % 6u]; acc = acc*31u + seen[0];`):
  `arkcc -O2 --reloc-data` returns **192**, MinGW gcc `-O2` on the same source returns **134**.
- Located pass by pass (temporary dumps of the function text after every pipeline stage; reverted
  with `git checkout` once the diagnosis was complete):

  | Point | Text |
  | --- | --- |
  | `after_spill` | `MOVW r0, #24` / `MOVT r0, #8192` / `MOV r7, r0` / `MOV r4, #0` / `LDR r7, [r7, r4, LSL #2]` |
  | `after_regbirth` | `MOVW r0, #24` / **`MOVT r7, #8192`** / `MOV r4, #0` / `LDR r7, [r7, r4, LSL #2]` |

  The rename happens only in `ark_regbirth_function` (`-fopt-birthdest`) and the `MOV r7, r0` copy is
  deleted, so `r7` only receives the top half (`0x2000_0000 | old low half`) and the low half `24`
  stays in `r0` with nobody reading it. The address is wrong, so the program does not read `seen[0]`;
  that is where 192 comes from.

### 24.2 Root cause (frozen)

`rb_pure_dest()` (`src/backend/arm/backend_arm.c`) lists `MOVT` among "the first operand is a pure
output". But `MOVT rD, #hi` **writes only the top 16 bits**, so it is not a complete definition of
`rD`; renaming it and deleting the following `MOV rX, rD` splits a 32-bit constant in half. In the
same family `lv_rw()` treats `MOVT` as "the whole register is killed" (`wr = {rD}` in liveness).
That happens to be safe on today's emitter output (`MOVT` always follows a `MOVW` of the same
register), but as soon as another pass renames one half the liveness model breaks the same way.

### 24.3 Rules (frozen)

1. **Primary fix**: drop `MOVT` from `rb_pure_dest()`. Rule A of `-fopt-birthdest` may no longer
   rename on a `MOVT`; `MOVW` stays (a `MOVW rD, #imm` writes a zero-extended 32-bit value into `rD`,
   which is a complete definition).
2. **Same-family hardening**: `lv_rw()` counts the destination of `MOVT` as **read** as well
   (read-modify-write), so the liveness model can never kill a register whose low half is still live
   just because a `MOVT` covers its top half. This is a conservative change: the worst case is one
   missed rewrite.
3. **Not done (explicit)**: renaming a `MOVW`+`MOVT` pair together and then deleting the copy is a
   new rule and needs its own pre-registration. So this slice's readings may **only shrink or stay**;
   a hit count that goes down is acceptable, and zero gain is acceptable too -- this is a
   **correctness fix**.

### 24.4 Criteria (frozen before the run, unchanged after)

| Item | Criterion |
| --- | --- |
| Correctness | `m7.c` returns **134** (matching gcc) in both the on and the off arm |
| Structural invariant | Over 95 TUs with all of BASE on, every `MOVW rD, #lo` followed (across directives) by a `MOVT rE, #hi` must have **D == E**; **zero violations** |
| Readings unchanged | 95 TUs: the off arm is still **10,172 / 372,761 B** and the on arm (with `-fopt-chainfold`) is still **9,822 / 358,964 B**; if that fails, re-judge against §22.4's table -- **never edit the table** |
| OFF IS OFF | `-fno-opt-birthdest` is byte-identical to the off arm |
| Regression | `make test`, `make test-regbirth` and `make test-chainfold` all green |

### 24.5 Anti-false-green (frozen, all must pass)

1. **The fixture must really carry the triggering shape**: the gate itself (independently, in Python
   under `tests/`) proves the fixture text holds the adjacent pair "a producer whose destination is
   `r0` and fully defined by it" + "`MOV rX, r0` right after" + "`r0` never read afterwards";
   otherwise the check proves nothing.
2. **The off arm must not pass either**: `-fno-opt-birthdest` and the on arm both return 134 with the
   same RAM snapshot.
3. **The invariant checker has its own self-check**: a correct text with one `MOVT rX` hand-edited to
   `MOVT rY` must be reported as a violation by the very same checker (no permanently green checker).
4. **Corpus re-count**: print both the number of adjacent `MOVW/MOVT` pairs over 95 TUs (102 before
   the fix) and the violation count (must be 0 after).
5. **Crop**: a build with `-DARKCC_FEATURE_OPT_REGBIRTH=0` still refuses both switches by name and,
   without them, is byte-identical to the full build.

### 24.6 Forbidden readings (frozen)

1. Do not claim "§21 was wrong": §21 judged the **tier of the readings** (175 -> register tier); this
   slice is one wrong rename inside the same switch, the readings do not move and the verdict stands.
2. Do not book this slice as an optimisation: the expected gain is zero or negative (fewer rewrites);
   it is a **correctness fix** and must not appear in any gain table.
3. Do not use it to explain S17's 350: different thing, different family, different yardstick.

---

## 25 S18 landing readings and verdict (2026-11-26)

### 25.1 What was fixed (two places, no new rule)

As frozen in §24.3, the only change is in `src/backend/arm/backend_arm.c`:

1. `rb_pure_dest()` drops `"MOVT"` (`MOVW` stays) and says why on the spot;
2. the generic branch of `lv_rw()` now counts a `MOVT`'s own destination as read (read-modify-write),
   which shuts the door on the rest of the family.

`git diff --stat` = 12 insertions, 1 deletion. **No rewrite rule was added**, so this slice cannot
produce a new hit: it only withdraws a rewrite that should never have happened.

### 25.2 Readings: not one digit moved

| Arm | Instructions | Bytes |
| --- | --- | --- |
| Off (all 32 BASE passes, `-fopt-birthdest` on) | **10,172** | **372,761** |
| `-fno-opt-birthdest` arm | **10,330** | **375,131** |
| Difference (= the rewrites S16 booked to `-fopt-birthdest`) | **158** | 2,370 |
| On (BASE + `-fopt-chainfold`) | **9,822** | **358,964** |

The difference is still the **158** that S16 pinned, which says the fix did **not** make the corpus
do one rewrite less: all 102 adjacent `MOVW/MOVT` pairs in the corpus agree on their register, so not
one of them ever walked the withdrawn path. Unchanged readings are the expected outcome, not "the fix
did nothing" -- §25.4 shows this gate does go red on the pre-fix binary. The 1.748x against armcc5
therefore stands.

### 25.3 `make test-movtpair` (14 checks, all green)

`tests/run_movtpair_tests.py` reuses the `run_chainfold_tests.py` harness (same 95-TU corpus, same
build and unicorn execution) and pins six groups:

1. **The price is zero**: the off arm is 10,172 / 372,761, the `-fno-opt-birthdest` arm is
   10,330 / 375,131, and the difference is exactly 158 (the A-arm site count from S16).
2. **The fixture carries the shape, untouched**: the `MOVW/MOVT` pair of the `.bss` end is present in
   the `-fopt-birthdest` arm, and all 11 pairs of the fixture are **line-for-line identical** to the
   `-fno-opt-birthdest` arm (not "looks right": the whole list has to be equal).
3. **The answer comes from the C source**: both arms return **134**, computed independently in
   Python, with the same 256-byte RAM snapshot.
4. **Corpus census**: over 95 TUs, adjacent `MOVW rD` / `MOVT` pairs = **102, violations 0**.
5. **The checker self-checks**: rewriting one pair's `MOVT` to another register makes the very same
   scanner report **exactly one** violation.
6. **Crop**: a build with `-DARKCC_FEATURE_OPT_REGBIRTH=0` refuses `-fopt-birthdest` and
   `-fopt-basefold` by name (`C3900U`, rc=1) and, without them, writes byte-identical text.

`make test-chainfold` (54 ok lines) and `make test-regbirth` are green as well, and the full
`make test` exits 0.

### 25.4 Non-vacuity, measured

Before trusting the gate, the pre-fix source was rebuilt (`git checkout --
src/backend/arm/backend_arm.c`, then `make`) and the very same gate reported **3 failures**:

```
[FAIL] the -fopt-birthdest arm of the fixture carries the MOVW/MOVT pair of the .bss end
[FAIL] the pair is byte-identical in the arm without the switch
       (with: MOVW r0, #24 / MOVT r7, #8192  without: MOVW r0, #24 / MOVT r0, #8192)
[FAIL] both arms return the value the C source says (134)  (on=192 nobd=134)
```

The second line is the defect itself: `MOVT r7` standing in for `MOVT r0`. With the fixed source
restored, all 14 checks pass. **The gate goes red on the bug**; it is not permanently green.

### 25.5 Verdict

**A correctness fix, gain 0.** It belongs in no gain table, it moves neither the §21 nor the §23
tier, and it does not touch the 1.748x.

`-fopt-birthdest` now only renames a single instruction that fully defines its destination; the
refused shape is `MOVT` (and any future half-writing instruction). Recovering the hits beyond those
158 would need **pair renaming `MOVW`+`MOVT` and then deleting the copy** -- a new rule, requiring a
new pre-registration (§24.3 item 3 already says this slice does not do it).

### 25.6 Forbidden readings (frozen)

1. Do not say "the readings did not move, so the change was pointless": they did not move because the
   corpus never covered the shape, and §25.4 has shown the defect is real (`m7.c`: 192 vs 134).
2. Do not book this slice as a failed optimisation: it was never an optimisation; the verdict is a fix.
3. Do not wave it away with "gcc does it too": `MOVT` writing half the register is an architectural
   fact and depends on no reference implementation's yardstick.

---

## 26 S19 pre-registration: the first emit/IR-level slice (2026-11-26, frozen before implementation)

### 26.1 Why it has to be the emit layer: four freshly measured bounds

With S18 closed (off arm 10,172 / 372,761 B, on arm 9,822 / 358,964 B, 1.748x against armcc5),
S19 was opened by project-level decision. Four candidate families were **measured**, not estimated
(`D:/tmp/bm/cf/meas_cmpimm.py`, `meas_lit.py`, `meas_litcse.py`):

| Candidate | Optimistic bound | Measured reachable | Share of 9,822 |
| --- | ---: | ---: | ---: |
| Literal-load sharing (one load per literal per function) | **438** | -- | 4.5% |
| 　└ of which the loosest sound rule (a single-predecessor label keeps what it knows) | -- | **88** | 0.9% |
| Constant into a compare (`MOV rX,#imm` + ... + `CMP rX,rY`) | 50 | **25 sites** | 0.5% |
| Ladder layer (`LDR` literal / `CMP` / branch) | 741 | -- | 7.5% |

Literal loads: **809 loads over 371 distinct literals** corpus-wide (optimistic 438), but every ladder
layer loads a **different** constant and the same constant reappears in far-apart ladders separated by
join points (the same `r7` holds different literals on different incoming paths, so it must be TOP).
An available-value analysis therefore reaches **88** instructions at best.

Frozen conclusion: **neither the text layer nor available-value sharing is the road.** Of the 1,235
instructions in `HAL_DMAEx_MultiBufferStart_IT`, 275 literal loads + 262 `CMP` + 244 conditional
branches are two-per-layer hard cost that the text layer cannot compress further.

### 26.2 The only big lever: how equality chains are lowered

Measured composition of that function: `LDR 331` (275 literal + 43 memory), `CMP 262`, `BEQ 176`,
`B 85`, `MOV 131`, `PUSH 35` / `POP 38`, `STR 38` (25 of them `[r1, #0]`).

`PUSH {rX}` ... `POP {rY}` pairs sit around whole ladders: that is the **value-stack model** pushing
the address of an assignment target, evaluating the expression, then popping it to store. armcc/gcc
keep the address in a register and lower the 250 equality comparisons as a **binary search / jump
table**, which is why they land on 292.

Bound frozen this round: lowering that function's ladders as a binary search gives 1,235 -> about
**400**, i.e. roughly **-800 to -1,000 instructions corpus-wide (-8% to -10%)**, `1.748x` -> about
**1.60x**.

**One negative conclusion, frozen**: even with this slice done ideally, **armcc is still out of
reach** -- the remaining gap is spread over value transport (`MOV` immediate +758, `MOV` register
+669, `PUSH`/`POP` +683, `[sp,#n]` +407), which is register-allocator quality, not any single
family's food.

### 26.3 Slice order (frozen; in this order, each pre-registered separately)

1. **S19-a value-stack round-trip removal**: `PUSH {rX}` ... `POP {rY}` (same function, no `BL`
   between, no other `PUSH`/`POP`, no write to `sp`, `rX` not written in between) becomes
   `MOV rY, rX` and the `PUSH` is deleted. **Gain: 0 instructions** (two for two), but it takes stack
   traffic from 73 to 0 and is the prerequisite for S19-b.
2. **S19-b pick registers for the compared value and the target address**: with the round trip gone,
   move the address into a register the expression never uses (`r9`-`r11`) so each ladder layer
   loses one push.
3. **S19-c binary-search lowering of equality chains**: the real -800.

This section (26) pre-registers only the **order and the criteria**; it pre-registers no payout.

### 26.4 Criteria (frozen before the run, not to be edited after)

| Item | Criterion |
| --- | --- |
| Correctness | Each slice: all 95 TUs plus `make test` green; fixture arms return the Python model value |
| OFF IS OFF | The new switch defaults off; the off arm is byte-identical to `-fno-opt-<name>` and still **9,822 / 358,964** |
| Readings | Write the expected bound down *before* the run, report only the measurement after; a shortfall is re-judged against §22.4, the table is **never edited** |
| Crop | A build with `ARKCC_FEATURE_OPT_<NAME>=0` refuses the new switch by name (`C3900U`) and, without it, is byte-identical to the full build |
| Anti-false-green | Every slice ships: a shape census (independent Python verdict, printing its hit count), a checker self-check (a hand-broken text must be caught), a `unicorn` differential (both arms same value and same RAM snapshot) and a sabotaged copy that must change the value |

### 26.5 Forbidden readings (frozen)

1. Do not claim "S19 will beat armcc": §26.2 freezes the bound at 1.60x; `1.0x` needs a rewritten
   allocator.
2. Do not read §26.1's 88 as "literal sharing is useless": it is the ceiling of available-value
   analysis **on this corpus**, so the conclusion is "not worth it", not "the rule is wrong".
3. Do not skip the slice order: S19-c depends on the registers S19-a/b free up; doing c first drives
   the register pressure into spills.

## 27 S19-a landing readings and verdict (2026-11-26, recorded after the run)

### 27.1 Measured readings

Implementation: `ark_pushpop_round()` + `ark_pushpop_function()` in
`src/backend/arm/backend_arm.c`, switch `-fopt-pushpop` / `-fno-opt-pushpop`, crop
macro `ARKCC_FEATURE_OPT_PUSHPOP` (0 in the `STM32_MIN` tier). Once this round's
measurements were in, it was moved to the **very end of the text pipeline** (after
`-fopt-chainfold`, before the `arm_skip_frame_opts:` label) and made a **fixed point**
(`PP_MAX_ROUNDS = 8`; every round rewrites at least one line, so it terminates). The
reason is in 27.2.

Four cross sections (`BASE` = the 32 `-fopt-*` of §26.4 plus `-fopt-birthdest` and
`-fopt-basefold`, **without** `chainfold` and `pushpop`):

| Cross section | Insns | Bytes |
| --- | ---: | ---: |
| `BASE` (off arm) | 10,172 | 372,761 |
| `BASE` + `-fopt-pushpop` | **10,125** | **372,344** |
| `BASE` + `-fopt-chainfold` | 9,822 | 358,964 |
| `BASE` + both | **9,775** | **358,547** |

The two switches **compose additively**: `-47 insns / -417 bytes` is identical on both
bases, with no interaction term. armcc5 on the same corpus is still 5,619 insns, so the
ratio goes from **1.748x** to **1.740x** (9,775 / 5,619 = 1.7396). Script
`D:/tmp/bm/cf/pp_compose.py`.

Site composition (35 sites, `47 = 2x12 + 23`):

| Disposition | Sites | Rule |
| --- | ---: | --- |
| `pair` (both halves deleted) | 12 | `rY == rX` and the span never names `rX` |
| `remat` (value rebuilt at the POP) | 23 | the span clobbers `rX`, so the definition is replayed |
| `copy` (`MOV rY, rX`) | 0 | absent from this corpus |

Per translation unit: `stm32f4xx_hal_dma.c` 9 (all `pair`, DEF is `MOV r0, #imm`),
`stm32f4xx_hal_dma_ex.c` 22 (19 `remat` with `LDR rX, .Llit` + 3 `pair`),
`stm32f4xx_hal_exti.c` 4 (all `remat`, DEF is `MOV r0, #4`).

Single-register `PUSH` census (202 corpus-wide): `site 35` / `no_definition 141` /
`nested_push 13` / `sp_in_span 8` / `call_in_span 5`; the on arm keeps **167**.

**Pre-registration vs measurement** (per §26.4 only the measurement is reported; the
table is not edited): §26.3 wrote "gain: 0 instructions (two for two)"; the measurement
is **-47**. The morphological guess was wrong -- it assumed the only shape was `pair`
(delete two, add none), while 23 of the sites are `remat` (delete two, add one, net -1).
This is an underestimate, not an overstatement; both numbers stay on the record.

### 27.2 The rule and why it is safe

The rule is frozen in the module docstring of `tests/pp_oracle.py`, which shares no code
and no constants with the implementation:

```
<def>            ; MOV|MOVW rX,#imm / LDR rX,.Llit / MOV rX,rY, straight before the PUSH
                 ; (only .loc / blanks / comments in between, never a label)
PUSH {rX}        ; one register, r0-r12
...
POP {rY}         ; one register, r0-r12; the first PUSH/POP after the PUSH (inner pair)
```

Six guards: no `BL`/`BLX` in between; no instruction naming `sp` in between; every branch
target inside the span lands inside the span; no label inside the span is entered from
outside it; the `MOV rX, rY` form additionally requires that `rY` is not named in the span.

Three dispositions:

1. `rY == rX` and the span does not name `rX` -- **both lines go**;
2. `rY != rX` and `rX` is untouched -- the PUSH goes, the POP becomes `MOV rY, rX`;
3. `rX` is clobbered in the span -- the PUSH goes, the POP becomes `<def> rY, <operand>`.

**Why a fixed point is required**: `ark_pushpop_round`'s scanner `ld_scan(b, from)` runs
from the function start to the **end of the buffer** (the same convention as `chainfold`
and every other text pass). So "call it once per function" actually walks the tail after
that function too and exposes new sites there; only iterating until a round rewrites
nothing makes the result independent of how many times it is called. The cap is 8 rounds,
and every round deletes at least one instruction, so it terminates.

**Why it must run last**: two cascades polluted the criteria. First, `-fopt-deadins`
deletes the DEF of a re-materialising site (the four `MOV r0, #4` in
`stm32f4xx_hal_exti.c`). Second, it fuses `LDR r0, [r8, #96]` + `MOV r1, r0` into
`LDR r1, [r8, #96]`, so the span the oracle sees in the **final** text differs from the
span the pass saw -- the two multisets matched but their order did not. With `pushpop`
moved last, it reads final text and the gate can take a **byte-for-byte second opinion**
(`ON text == oracle(OFF text)`): all 95 TUs come out with `drift == 0`.

**Costs** (known, frozen): (a) four instructions less than the slot before `deadins`
(-51 -> -47); (b) four dead `MOV r0, #4` stay in the text (8 bytes), because `deadins` no
longer gets a chance at them -- that is a second layer of analysis this slice does not do.

**Why the PUSH line always goes and `rep` is written only at the POP**: an earlier version
emitted `rep` twice, at the PUSH and at the POP, which defined `rY` **before** the span
while the guard only checked `rX`; a span that still used `rY` would have been silently
miscompiled. Fix: delete the PUSH line, write `rep` at the POP line only.

### 27.3 Criteria (`tests/run_pushpop_tests.py`, six items, 32 checks, all green)

| Criterion | Frozen value |
| --- | --- |
| OFF IS OFF | 95 TUs byte-identical to `-fno-opt-pushpop`; 10,172 / 372,761 |
| Fires only by the rule | `pp_oracle.transform(OFF) == ON` byte for byte; 10,125 / 372,344; 35 sites = 12 pair + 23 remat + 0 copy; `touched == {dma 9, dma_ex 22, exti 4}` |
| Every site re-proved from the on text | cursor walk: the DEF line survives, the span is untouched, the PUSH is gone, the POP carries exactly `rep`; `rep_ok` checks mnemonic, operand text and destination register; sites are disjoint; single-register PUSH 202 -> 167 |
| Declines when it must | census `{site 35, no_definition 141, nested_push 13, sp_in_span 8, call_in_span 5}` pinned; `PAIR_TEXT` / `COPY_TEXT` / `REMAT_TEXT` each yield one site of the expected kind with a pinned `rep`; `NO_DEF_TEXT` / `OUTSIDE_TEXT` / `CALL_TEXT` / `PC_TEXT` yield none, with a re-derivable reason (`no_definition` / `span_split` / `call_in_span` / `pop_not_single`) |
| The answer does not change | `unicorn` runs the fixture in both arms: 2 sites off, 0 on; 12 inputs return **196** in both arms (computed in Python from the C source); the 0x40020000 + 0x8000 and 0x20000000 + 0x100 snapshots are identical (33,024 bytes); the last two words are `(0x00100000, 0x00005555)` |
| Cropped out, refused | `-DARKCC_FEATURE_OPT_PUSHPOP=0` refuses the flag by name (`C3900U`) and, without it, writes the same text as the full build |

Anti-false-green: `pp_oracle` and the compiler share no code or constants (two
implementations); the three "must fire" controls pin both the kind and the `rep` text; the
four "must decline" controls pin the reason string; the executed fixture uses **two
different absolute peripheral addresses and two different constant tables** (`FLAG` /
`NOTFLAG`), so a swapped or lost constant changes the 0x4002xxxx snapshot. Same gate via
`make test-pushpop`.

### 27.4 Correction to §26.2 (measured armcc, not estimated)

§26.2 took **gcc**'s 292 for armcc's reading and concluded "-800 to -1,000 insns, 1.60x".
Real armcc was re-measured this round
(`D:/Keil_v5/ARM/ARMCC/bin/armcc.exe --thumb -O2 --cpu Cortex-M4`, same TU, same `-D`/`-I`):
**armcc is at 985 instructions on that function, not 292**.

| Item | armcc5 | Ours (`BASE`+chainfold+pushpop) | Delta |
| --- | ---: | ---: | ---: |
| Total | **985** | **1,210** | +225 (1.229x) |
| `CMP` | 258 | 262 | +4 |
| `BEQ` | 183 | 176 | -7 |
| `BNE` | 60 | 68 | +8 |
| `LDR` | 147 | 350 | **+203** |
| `MOV` | 71 | 131 | **+60** |
| `PUSH` | 1 | 13 | +12 |
| `POP` | 2 | 16 | +14 |
| `STR` | 25 | 38 | +13 |
| `B` | 78 | 85 | +7 |

Three frozen conclusions:

1. **armcc does not lower to a binary search.** `CMP 258` / `BEQ 183` / `BNE 60` against
   our `262 / 176 / 68` -- it compares layer by layer too. §26.2's "binary search / jump
   table" is gcc's technique, not armcc's.
2. **There is no "-800 lever".** Against armcc this function is only 225 instructions
   apart: 203 are `LDR`, 60 are `MOV`, 26 are `PUSH`/`POP` -- all **value transport**
   (per-layer literal reloads and register shuffling), not "how ladders are lowered".
   §26.2's 1,235 -> about 400 and 1.60x are withdrawn.
3. The corpus-wide claim is corrected accordingly: the text-layer ceiling is **about
   1.70x** (27.5); `1.0x` can only come from rewriting the emitter / register allocator.

### 27.5 Text-layer ceiling table (after S19-a, base 9,775)

| Residual family | Bound (insns) | Source |
| --- | ---: | --- |
| `MOVW`+`MOVT` literal pairs -> `LDR` from a pool | 102 | §19.4 |
| Literal-load sharing (single-predecessor available values) | 88 | §26.1 |
| Constant into a compare | 25 | §26.1 |
| Normalisation + immediate chains | 8 | §19.4 |
| **Total** | **223 (2.3%)** | 9,552 / 5,619 = **1.700x** |

The "stack round trip" row is gone: this slice cashed it in (pre-registered 32 ->
**measured 47**). Even eating all 223 reaches only 1.700x.

### 27.6 Forbidden readings (frozen)

1. Do not claim "S19 beats armcc". Corpus-wide 1.740x, same function 1.229x; §26.2's
   1.60x is withdrawn.
2. Do not keep quoting §26.2's "-800 to -1,000" or "binary-search lowering" -- see 27.4,
   that was gcc's reading.
3. Do not call 1.740x "close to armcc": the gap sits in `LDR` (+203/function), `MOV`
   (+60) and stack traffic (+26), which is allocator quality.
4. **The `pair` shape has text-level verification only.** The executed fixture reliably
   produces a `remat` site (`*(volatile unsigned*)0x40026458u = FLAG(in)`); `pair` is
   covered by three text-level proofs (byte-for-byte == oracle, cursor walk, control
   texts) and **has no runtime coverage**. That is this slice's honest boundary.
5. Do not read the fixed point as "a patch for a bug": it follows from the existing
   "scan to the end of the buffer" convention that binds every text pass.

## 28 S19-b's premise is refuted; where the next cut goes (2026-11-26)

### 28.1 The pre-registered hypothesis

§26.3 froze S19-b as "pick the compared value and the target address into registers
like `r9`-`r11` that expressions do not use, so each ladder layer loses one push source",
bounded by the "stack round trip, 32" row of §26.1.

### 28.2 Measurement: the hypothesis does not hold

After S19-a landed, the same function (`HAL_DMAEx_MultiBufferStart_IT`, `BASE`+`chainfold`+
`pushpop`) was re-measured:

- the function now has 13 `PUSH` / 16 `POP` (35 / 38 before S19-a), and the 12-layer
  selector ladder has **not a single stack round trip left**. The "one push source per
  layer" that S19-b meant to remove is not in the text any more -- S19-a's `pair`/`remat`
  removed it outright. The pre-registration had read the ladder as "still pushing".

### 28.3 Measurement: where the difference actually sits

Same function, against real armcc (`--thumb -O2 --cpu Cortex-M4`), per class (table in
§27.4):

| Item | armcc5 | Ours | Delta |
| --- | ---: | ---: | ---: |
| Total | 985 | 1,210 | +225 |
| Literal loads `LDR rX, .Llit` | **9** | **294** | +285 |
| `LDR` total (including memory) | 147 | 350 | +203 |
| `MOV` | 71 | 131 | +60 |

The 294 is traced to the source: the second argument of `__HAL_DMA_CLEAR_FLAG` is
`__HAL_DMA_GET_*_FLAG_INDEX(hdma)`, a 12-constant `CHSEL` ladder that the function expands
five times, so those 12 constants are each loaded about 21 times in this one function
(74 pool labels, 294 loads). armcc instead **loads two base literals, derives the other
seven with small `ADD`/`SUB` immediates, and keeps them in `r8`-`r12`/`lr` across
ladders**. That is not a difference in "how ladders are lowered" -- it is **constant
materialisation plus cross-basic-block register caching**.

Corpus-wide (`BASE`+`chainfold`+`pushpop`, 9,775 insns), per class:

| Item | Insns |
| --- | ---: |
| `MOV` | 1,667 |
| `LDR` | 1,955 (`LDR rX, .Llit` = 828) |
| `PUSH`+`POP` | 769 |
| `STR` | 935 |
| `B` | 642 |
| `CMP` | 606 |
| `MOVW`+`MOVT` | 293 |

### 28.4 Verdict

1. **S19-b is withdrawn**: it was not "implemented with no effect", its **premise was
   refuted and nothing was built**. The "stack round trip, 32" family was cashed in by
   S19-a (47), so that account is settled.
2. **The text layer closes at 1.740x.** The two remaining large items are `MOV` 1,667
   (value transport) and `LDR rX, .Llit` 828 (constant materialisation); both need
   **cross-basic-block liveness** to rewrite safely, and a text pass does not have it
   (`pp_oracle` can only answer boolean questions about an interval). The 223-row of
   §27.5 still holds (that is the part with local evidence); it does **not** include the
   828.
3. The next cut can only be **the emitter / register allocator** (Task V): keeping
   constants in registers across a long straight-line region and minimising value
   transport. That is not another `-fopt-*`; it is a different IR-to-asm emitter.

### 28.5 Forbidden readings

1. Do not write S19-b up as "implemented, zero gain" -- it was not implemented, and the
   reason is refutation by measurement.
2. Do not claim "the text layer can still squeeze out 200 more insns": the two large
   items are quantified and both sit on cross-block liveness.
3. Do not attribute 294 vs 9 to "armcc lowers ladders better" (§27.4 already refuted it).

## 29 Three probes that close the text layer, and the Task V pre-registration (2026-11-26)

### 29.1 Two new probes (prototype measurements, not estimates)

To make sure the sentence in 28.4 ("the text layer cannot do it") is not an excuse, the
amount a *real CFG plus liveness* could reach was measured. The prototypes are
`D:/tmp/bm/cf/v1_proto.py` (CFG construction, backward liveness, successors/predecessors)
and `v2_proto.py`, run over the 95-TU corpus of `BASE`+`chainfold`+`pushpop` (9,775 insns).

**Probe 1: constant residency.** Rule: if a `.Llit_k` is loaded at least twice in a
function, and for some `LDR rX, .Llit_k` the next instruction reads `rX` without writing
it and `rX` is not live after it (liveness decides), that load can go and the next
instruction can name a resident register instead; the resident register must come from
`{r9, r10, r11}`, be mentioned nowhere else in the whole function body, and be saved by
the prologue `PUSH` (so the caller is not corrupted). Result:

- corpus **40 insns / 39 functions** (largest single function
  `HAL_DMAEx_MultiBufferStart_IT`, 14).

**Probe 2: `MOV` copy propagation.** Rule: if `MOV rX, rY` is followed by an instruction
that reads `rX`, does not write `rX`, does not write `rY`, and `rX` is dead afterwards,
rename that use to `rY` and delete the `MOV`. Result:

- corpus **23 insns / 11 functions** (largest TU `stm32f4xx_hal_dma.c`, 10).

Together **63 insns = 0.64%**. With S19-a's 47 already banked, everything the text layer
can still do with local proofs is **under 0.7%** of 9,775. `1.740x` is the text floor.

### 29.2 Why the 828 literal loads stay

`40` is the answer: what can be saved is not the number of loads but the **existence of a
register that can hold the value across blocks**. There are three (`r9`-`r11`), and
`HAL_DMAEx_MultiBufferStart_IT` alone has 74 distinct pool literals loaded 294 times
(12 constants times 5 macro expansions times their per-region pool copies). Three
registers eat 14 of them. Eating the rest requires **register allocation in the emitter** --
which is exactly how armcc keeps constants in `r8`-`r12`/`lr` across ladders (28.3), and
not something the text layer can add.

### 29.3 Task V pre-registration (three slices, frozen one at a time)

| Slice | Content | Criterion (frozen before implementing) | Cropping |
| --- | --- | --- | --- |
| **V-1** | a **constant/address residency cache in the emitter**: pin the most-used constants or addresses of a function on registers that the prologue `PUSH` already saves and that the emitter's allocator does not use; load at first use, refer to them afterwards | corpus instruction count must be **<= 9,775 - 150** and `PUSH`+`POP` must not grow; otherwise the slice is withdrawn, the criterion is not re-cut | new switch off by default, `ARKCC_FEATURE_OPT_CONSTCACHE`, 0 in the `STM32_MIN` tier |
| **V-2** | **value transport**: fold the pure copies the emitter emits between `IR_PUSH`/`IR_POP` (the bulk of the 1,667 `MOV`) | corpus `MOV` count must drop by **>= 200** and the total must not rise | own switch, as above |
| **V-3** | **allocator**: colour live intervals instead of the fixed scratch + stack scratchpad | target: corpus <= 5,619 x 1.10; no stage is promised until V-1/V-2 are measured | own switch, as above |

Hard constraints shared by all three (not negotiable):

1. **OFF IS OFF**: with the new switch off, all 95 TUs must be byte-identical to the
   current `arkcc.exe`.
2. **The answer does not change**: the full `tests/arm_exec/` suite plus the `unicorn`
   differential (value and RAM snapshot) agree in both arms.
3. **Croppable**: in the `STM32_MIN` tier the feature must fail the build and the switch
   must be refused by name (`C3900U`).
4. **Miss the bound and withdraw**: criteria go into this section before implementation
   and are copied out afterwards, never recomputed.
5. **IR semantics untouched**: V-1/V-2 change only how a value is moved, never what is
   computed.

### 29.4 Forbidden readings

1. Do not call V-1/V-2 "the road to 1.0x": their targets are -150, -200 and "look first";
   against 5,619, even an optimistic V-1+V-2 lands around 1.70x.
2. Do not treat the 63 in 29.1 as "another 0.6% still to grab" -- the probes exhausted
   what local proofs can see; what remains is *not locally provable*, not "unwritten".
3. Do not claim V-1/V-2 complete without a full regression run.

## 30 Address-chain folding: landing and verdict (2026-11-26, recorded after the run; `-fopt-addrfold`)

### 30.1 What this slice cuts

`-fopt-addr` folds address chains that live inside **one expression**; `-fopt-basefold`
(section 20) folds a base register that exists for exactly one access and carries offset 0.
After both, one shape is left: a base register **built by two additions in a row**.

```
    ADD rA, rB, #k1          ; first leg: form the base
    ADD rC, rA, #k2          ; second leg: add more to it (rA dies right here)
```

and its access variant:

```
    ADD rA, rB, #k1          ; first leg
    LDR rD, [rA, #k2]        ; the access already carries an offset (k2 >= 0)
```

Two rules, both text level, behind `-fopt-addrfold` / `ARKCC_FEATURE_OPT_ADDRFOLD`:

| Rule | the two instructions | rewrite | numeric range |
| --- | --- | --- | --- |
| **A** | `ADD\|SUB rA,rB,#k1` followed by `ADD\|SUB rC,rA,#k2`, `rA` not live after the second | delete the first, second becomes `ADD\|SUB rC,rB,#(k1+-k2)` | `k1+k2 != 0`, `\|k1+k2\| <= 255` |
| **B** | `ADD rA,rB,#k1` (`k1 >= 0`) followed by `LDR\|LDRB\|LDRH\|LDRSH\|STR\|STRB\|STRH rD,[rA]` or `[rA, #k2]` (`k2 >= 0`), `rA` not live after the second | delete the first, base becomes `rB`, offset becomes `#(k1+k2)` (`k1+k2 == 0` is written `[rB, #0]`) | `0 <= k1+k2 <= 4095` |

`ADDS`/`SUBS` never match (those are the explicit carry chains of 64-bit arithmetic; rewriting
them changes the value). `LDRSB` is not in rule B's mnemonic set: it has no 16-bit immediate
form, so the width guard would already refuse the `-2/+4` trade, and rather than introduce an
unverified shape it is simply not accepted.

### 30.2 The guards and why each one exists

| Guard | Implementation | Why it is mandatory |
| --- | --- | --- |
| Same basic block | `bof[j] == bof[i]` | across blocks "the second always runs" is false, so deleting the first would drop a computation on another path |
| Not inside an IT | `!it[i] && !it[j]` | under conditionality the two do not necessarily run together |
| No write-back | any operand text containing `!` is refused | write-back modifies the base register, so the folded form means something else |
| Registers all in `r0`-`r12` | `0 <= r <= 12` in `af_alu_imm`/`af_mem_imm` | `sp`/`pc` (and `lr`) taking part in base arithmetic is not this slice's business |
| `rA` not live afterwards | `la[j] & (1<<rA)` refuses (the live pass's **cross-block** `la[]`) | this is the **only** reason deleting the first instruction is invisible |
| The new instruction may not be wider | `af_alu_size(rd,rB,|tot|) <= af_alu_size(rd,rA,|k2|)`, same for `af_mem_size` | otherwise the fold trades a deleted 2-byte `ADD` for a 4-byte access: zero or negative win. Assembler facts: `ADD/SUB imm` is 16-bit only for `rd==rn && rd<=7 && imm<=255` (`ADDS`) and `imm<=7` with all-low registers; `LDR/STR` is 16-bit only for `r0`-`r7` with `imm<=124 && imm%4==0`; `LDRB/STRB <= 31`; `LDRH/STRH <= 62` even; `LDRSH` is always 4 bytes |
| Flags, block-local | `af_flags_free(j)`: scan from `j+1` to the end of the block and refuse on any flag reader; `CBZ`/`CBNZ` count as **neutral** (they read a register, not the flags, and `-fopt-cbz` puts one right after most loads), `B`/`BL`/`BX`/`BLX` stop the straight line, `LDM*`/`STM*` and `MOV`/`LDR`/`PUSH`/`POP` etc. are neutral | rule A changes C/V, rule B deletes a flag writer outright. In this code base flags are **block-local** (`ark_deadins` already treats them that way), so the scan stops at the block end |

The flags guard is not a guess: item 6 of `tests/run_addrfold_tests.py` censuses the 31
flag-setting TUs and finds **606 flag consumers, every one of them fed by a `CMP`**
(`{'CMP': 606}`). That census is a self-check inside the gate, so a corpus change turns it red.

### 30.3 Five-arm readings (95 TUs)

| Arm | Instructions | Bytes |
| --- | --- | --- |
| `BASE` | 10,172 | 372,761 |
| `BASE + addrfold` | **10,134** | **372,030** |
| delta | **-38 (-0.37%)** | **-731 B (-0.20%)** |
| `BASE + chainfold + pushpop` | 9,775 | 358,547 |
| `BASE + chainfold + pushpop + addrfold` | **9,737** | **357,816** |
| delta | **-38** | **-731 B** |

- Both baselines give the same -38 / -731 B, so the slice is **additive and does not overlap**
  `chainfold`/`pushpop` (those two rewrite comparison ladders and value-stack round trips;
  this one rewrites address arithmetic).
- **OFF IS OFF**: each baseline was also built with `-fno-opt-addrfold` and came out
  **byte-for-byte identical** to the build with the switch never mentioned (0 files differ).
- 38 sites = **A 24 / B 14**, touching **5 TUs**: `main.c` 3, `stm32f4xx_hal_dma.c` 21,
  `stm32f4xx_hal_dma_ex.c` 3, `stm32f4xx_hal_flash.c` 1, `stm32f4xx_hal_rcc.c` 10.
- Against armcc5's 5,619 on the same corpus: 1.740x **unchanged** (38 instructions is under
  0.4%, which does not move the ratio at two decimals).

### 30.4 The gap against "how many there should be"

Two independent estimates came first:

- **Probe** (`D:/tmp/bm/cf/v1_proto.py` line, real CFG + backward liveness): 83.
- **Independent census** (`tests/af_census.py`: its own parser, its own basic blocks, its own
  block-local liveness, sharing no line of code with the pass): **48** (A 23 / B 25).

Measurement gives **38** (A 24 / B 14), and those 38 sites fall on **23 distinct text pairs**
(identical repeated text pairs count once). `af_diff.py` accounts for the gap want by want:
**16 items**, distributed as

| Reason | Count | Explanation |
| --- | --- | --- |
| `la_live` | 9 | the census judges `rA` "dead" with **block-local** liveness, the pass judges it "live" with the live pass's **cross-block** `la[]` => a correct refusal. Examples: `HAL_DMA_Init`'s `ADD r5,r0,#32` / `LDR r0,[r5,#0]` (x3), `HAL_DMA_RegisterCallback`'s `ADD r5,r8,#68/76/80/84` / `STR r9,[r5,#0]`, `HAL_DMA_Abort_IT`, `HAL_FLASHEx_OBProgram` |
| `flags` | 2 | a flag reader later in the same block. Examples: `HAL_DMA_Init`'s `ADD r5,r0,#20` / `STR r9,[r5,#0]`, and the matching pair in `HAL_FLASH_IRQHandler` |
| composition (A then B) | 5 | the census treats `DMA_CheckFifoParam`'s `ADD r5,r0,#40` / `LDR r0,[r5,#0]` as a pure B candidate; in fact **A** first merges `#40` with `#4` into `ADD r5,r0,#44` in one round, and **B** folds that into the addressing in the next (end state `LDR r0,[r0,#44]`). All 5 disappear from the final text, so they were not refused |

**Reading: not one of the 16 is "shape-correct but refused for no reason".** 9 are cross-block
liveness (conservative but necessary), 2 are flags (necessary), and 5 are the same code being
eaten by A first, so B can no longer fire on the original shape (composition, not a miss).

### 30.5 The gate `make test-addrfold` (six checks, 33 items, EXIT=0)

1. **OFF IS OFF**: both baselines built with `-fno-opt-addrfold` are byte-identical.
2. **An independent second implementation reproduces everything**: `tests/af_oracle.py` has its
   own parser, its own basic-block split, its own liveness to a fixed point, its own width and
   flags shapes, and reproduces the compiler's output **byte for byte on both arms across all
   95 TUs (drift=0)**; it also checks the site count 38, the A24/B14 split and the per-TU
   account `on_i == base_i - 38`.
3. **Per-round cursor re-proof**: `af_oracle.steps()` returns each round's
   `(before, after, sites)` (line numbers only mean something inside the round that produced
   them; a flattened site list produces false alarms), and every round goes through
   `reprove()`: prefix unchanged -> first line gone -> the `q-p-1` lines in between unchanged ->
   the second line equals the text that round produced -> the rest unchanged.
4. **Guards restated**: `guard_ok()` uses **only the off-arm text** and walks every guard of
   30.2 again, including "is `rA` written (killed) before it is read again in the block".
5. **Must-refuse / must-accept fixtures**: 9 must-refuse (`live`/`it`/`writeback`/`flags`/
   `range_a`/`zero_a`/`range_b`/`grow_a`/`grow_b`) plus 2 must-accept (`POS_A` ->
   `ADD r5, r6, #56`; `POS_B` -> `LDR r1, [r0, #8]`).
6. **Semantics + cropping**: the `unicorn` fixture returns the same value (80) on both arms
   with the same 256-byte RAM snapshot, 4 sites `['A','A','A','B']` on the off arm and 0 on the
   on arm; the cropped build `-DARKCC_FEATURE_OPT_ADDRFOLD=0` refuses the switch by name
   (`C3900U`) and, without the switch, produces text identical to the full build; plus the
   606-consumer census self-check of 30.2.

### 30.6 How not to read this

1. **Do not read 38 as "45 more are still there"**: all 16 items in 30.4 have correctness
   reasons (cross-block liveness 9, flags 2, composition 5); the distance from the probe's 83
   and the census's 48 is a **difference of criteria**, not debt.
2. **Do not read A's 24 as "beyond pre-registration"**: the freeze covered the **correctness
   guards** and the "two families A/B", not the A/B ratio; 24/14 is a measured split, not a
   moved goalpost.
3. **Do not call this slice done without a full regression**: `make test-addrfold` covers this
   slice only; a full `make test` is a separate gate before release.
4. **Do not present the B fixture shape as "just write any C"**: the compiler almost always
   folds the offset into the access, so `ADD rA,rB,#k1` + `[rA,#k2]` only shows up when the
   value load is **delayed past the address computation**. The stable form is

   ```c
   unsigned v = gh.inst->par;
   if (gh.inst->par & 4u) { out = v; return 1; }
   ```

   yielding `ADD r5, r0, #8` / `LDR r0, [r5, #0]` -> `LDR r0, [r0, #8]`. The store shape
   (`h->inst->par = in;`) cannot be produced: the global/stack load is inserted after the
   address computation and destroys adjacency.
5. **Do not conflate this slice with `-fopt-basefold`**: `basefold` folds a base register with
   offset exactly 0 serving exactly one access; this slice folds **two-leg additions** and
   **accesses that already carry an offset**. Their acceptance conditions do not overlap:
   `basefold` needs `imm > 0` and a multiple of 4, `rB` serving that one access, and no
   label/branch/call in between; rule B allows `k1` not a multiple of 4 and `k2 > 0`, and its
   only liveness requirement is "`rA` dead afterwards".

## 31 V-1's premise, measured and withdrawn; S21 pre-registration: same-value re-materialisation removal (2026-11-26, frozen before implementation)

### 31.1 Why V-1 (constant/address residency) is withdrawn

The criterion section 29.3 froze for V-1: whole-corpus instruction count **<= 9,775 - 150**,
with the `PUSH`+`POP` total not increasing. The withdrawal is about the **ceiling**, not about
feasibility:

- Probe 1 of 29.1 had already measured residency to exhaustion: to pin a constant or address
  across blocks a function needs a register **not mentioned anywhere in the function body** that
  the prologue has saved with `PUSH`. Only `r9`/`r10`/`r11` are such registers, and the whole
  corpus yields **40** of them (39 functions, the largest a single function with 14).
- To make sure the probe was not simply conservative, this round measured a weaker rule of the
  same family (the same register re-materialising the same value): **124** sites
  (60 x `MOV|MOVW rX, #imm`, 64 x `LDR rX, .Llit_k`), spread over 38 files, led by
  `main.c` 19, `stm32f4xx_hal_flash.c` 18, `stm32f4xx_hal_dma.c` 16,
  `stm32f4xx_hal_flash_ex.c` 14, `stm32f4xx_hal_rcc.c` 13.

164 together would clear 150, but they are **two different rules**: residency means "hold it in
another register", re-materialisation removal means "the register already holds this value".
V-1's frozen criterion only counts residency, and residency tops out at 40. Under 29.3's hard
constraint 4 (fail the criterion, withdraw, do not move the goalposts) **V-1 is withdrawn and
not implemented**.

Note: what can be saved among the 828 `.Llit` loads is not "the number of loads" but "whether a
register can hold it across blocks", as 29.2 already argued; 40 is the end of that road. The real
answer is V-3 (the allocator), not V-1.

### 31.2 S21 pre-registration: `-fopt-remat` (same-value re-materialisation removal)

**Rule (text level, frozen)**: after an instruction that puts a **constant value** into a register,

```
    MOV|MOVW rX, #imm       or       LDR rX, .Llit_k
```

if `rX` is not written, and **on the same straight line** the **identical instruction** appears
again (same mnemonic, same operands), the later one is deleted -- the register already holds
that value.

**Guards (frozen, one per implementation check)**:

1. **Straight line**: scanning forward from the first one stops at a **referenced** label (a
   label no branch references can only be reached by falling through, so it is transparent) and
   stops at any branch/return/call (`B*`/`CBZ`/`CBNZ`/`BL`/`BLX`/`BX`, `POP {..., pc}`).
2. **IT blocks**: stop if the first instruction or the candidate sits under an IT (the
   conditional instruction count cannot change).
3. **Writers**: stop at any instruction that writes `rX` (it no longer holds that value); reads
   of `rX` in between do not matter (the value is unchanged).
4. **Same value**: mnemonic and every operand text identical (`MOV` and `MOVW` are not
   interchangeable, nor are `#5` and `#0x5` -- the latter never appears from this emitter).
5. **Flags untouched**: `MOV`/`MOVW`/`LDR` write no flags, so deleting them changes nothing any
   consumer of the condition codes can observe.
6. Both instructions must be inside the same function body (the pass runs per function).

**Criterion (frozen)**: whole corpus (`BASE`+`chainfold`+`pushpop` = 9,775) must end at
**<= 9,675 instructions (i.e. >= 100 deleted)**, with the `PUSH`+`POP` total not increasing.
The census predicts **124**. Fail the criterion, withdraw.

**Anti-false-green (frozen)**:

1. OFF IS OFF: with the switch off, all 95 TUs are byte-identical.
2. An independent second implementation reproduces both arms (`tests/rm_oracle.py`), drift=0.
3. Every site re-proved item by item: nothing in between writes `rX`, no referenced label, no
   branch, and after deleting the line the value is still in the register.
4. Must-refuse fixtures: `rm_write` (a write to `rX` in between), `rm_branch` (a conditional
   branch in between), `rm_ref_label` (a referenced label in between), `rm_it` (under an IT),
   `rm_diff` (the second one is a different value).
5. Must-accept fixtures: one `MOV rX, #imm` and one `LDR rX, .Llit`.
6. A `unicorn` differential with the same value and the same RAM snapshot; the cropped build
   refuses the switch by name (`C3900U`).

**Cropping**: the new switch is off by default, `ARKCC_FEATURE_OPT_REMAT`, `STM32_MIN` profile 0.

### 31.3 How not to read this

1. Do not read 124 as "V-1 met its criterion": V-1 froze residency (ceiling 40); this is a
   different rule and it is numbered S21.
2. Do not quote "164 together" as the win of one rule.
3. Do not treat this rule as a substitute for constant residency: it only holds when the same
   register already carries the same value; reuse across registers is still the allocator's job.

## 32 S21 landed: readings and verdict (2026-11-26, written after the run; `-fopt-remat`)

### 32.1 Readings

The rule and its guards are exactly the ones frozen in 31.2; the implementation is
`ark_remat_function` (`backend_arm.c`), called at the **end of each C function's text pass**
(after `-fopt-addrfold`). Both baselines were measured:

| baseline | off | on | delta |
| --- | --- | --- | --- |
| `BASE` (31 flags) | 10,172 insns / 372,761 B | **10,057 insns / 370,454 B** | -115 insns / -2,307 B |
| `BASE` + `-fopt-chainfold` + `-fopt-pushpop` | 9,775 insns / 358,547 B | **9,660 insns / 356,240 B** | -115 insns / -2,307 B |

- Both baselines delete the **same 115 lines**: 53 `MOV`, 62 `LDR rX, .Llit_k`.
- `PUSH` 383 / `POP` 386, identical in both arms (the "must not grow" half of the criterion).
- Against armcc5's 5,619 insns on the same corpus: 9,775 / 5,619 = 1.740x -> 9,660 / 5,619 =
  **1.719x**.
- The 17 TUs holding sites: `main.c` 18, `stm32f4xx_hal_dma.c` 16, `stm32f4xx_hal_flash_ex.c` 14,
  `stm32f4xx_hal_flash.c` 13, `stm32f4xx_hal_rcc.c` 13, `stm32f4xx_hal_rcc_ex.c` 9, `gpio.c` 8,
  `stm32f4xx_hal.c` 7, `stm32f4xx_hal_dma_ex.c` 3, `stm32f4xx_hal_gpio.c` 3,
  `stm32f4xx_ll_utils.c` 3, `stm32f4xx_hal_msp.c` 2, `stm32f4xx_hal_pwr_ex.c` 2,
  `system_stm32f4xx.c` 1, `stm32f4xx_hal_cortex.c` 1, `stm32f4xx_hal_exti.c` 1,
  `stm32f4xx_hal_pwr.c` 1.
- The switch is **off by default** (`enable_opt_remat = 0`); `ARKCC_FEATURE_OPT_REMAT` is host 1,
  `STM32_MIN` 0.

### 32.2 The criterion

31.2 froze: whole corpus (9,775 baseline) at **<= 9,675** insns (i.e. at least 100 deleted), with
`PUSH`+`POP` not growing. Measured: **115** deleted, `PUSH`+`POP` 769 -> 769, so the criterion is
**met** and the slice lands in the record tier (off by default, croppable). The probe used at
freeze time predicted 124; that does not change the reading, since **115 >= 100** and no
"withdraw if missed" clause is triggered.

### 32.3 The six gate items (`make test-remat`, 31 checks, EXIT=0)

1. OFF IS OFF: two baselines x 95 TUs, switch absent / `-fno-opt-remat` byte-identical; the two
   baselines still total 10,172 / 372,761 and 9,775 / 358,547.
2. The independent second implementation `tests/rm_oracle.py` (its own walk; it only borrows
   `af_oracle`'s parser, read/write and branch primitives) reproduces all 95 TUs byte for byte on
   both arms (drift=0): 115 sites = 53 `MOV` + 62 `LDR`, per-TU distribution equal to the table
   above, and `on = off - 115`.
3. Every site is re-proved from the **switch-off text alone**: two materialisations of the same
   value into the same register, nothing writing that register in between (an earlier same-value
   duplicate is itself a site and does not count as a write), no label a branch can land on, no
   branch/return/call, neither line under an IT; and line by line, only the second line is gone
   and nothing else moves.
4. Six must-refuse fixtures (`write`, `branch`, `ref_label`, `it`, `diff`, `mix` -- `MOV` and
   `MOVW` never mix) and two must-accept fixtures (one `MOV`, one `LDR .Llit`).
5. A `unicorn` fixture: `zero_path` (four zero stores, four `MOV r0,#0` -> 3 sites) plus
   `reg_path` (one peripheral address reloaded through `LDR r5,.Llit` -> 3 sites) plus 1 in the main
   loop, **7 sites (4 `MOV` / 3 `LDR`)**; both arms return **248** over 8 rounds (recomputed in
   Python from the C source) and leave the same first 256 bytes of RAM; the switch-on arm carries
   zero sites.
6. A cropped build (`-DARKCC_FEATURE_OPT_REMAT=0`) refuses `-fopt-remat` by name (`C3900U`) and
   writes the same text as the full build when the switch is absent.

### 32.4 Three scope facts (each one is in the gate, not a verbal convention)

1. **The per-function pass cannot reach the generated TU tail**: `__arkcc_init_globals` and the
   rest of the tail are emitted outside the function loop, so the pass never sees them; the corpus
   holds **6** such sites (`stm32f4xx_hal_flash.c` 5, `system_stm32f4xx.c` 1). The oracle aligns
   its scope through `generated_start()`, which cuts at the label **definition** line (not at the
   `BL __arkcc_init_globals` the startup code emits earlier in the file -- cutting at the reference
   would throw the whole file away); with that cut both arms drift=0 and the site count is exactly
   115.
2. **The strict whole-scope census is 121** (59 `MOV` + 62 `LDR`) = 115 + the 6 in the tail. The
   124 the freeze-time probe (`v1_cse2.py`) reported differs by **3, and all three are "a first
   line inside another site's window is skipped"**: once a group of duplicates is found the cursor
   jumps to the end of the window, so another first line inside that window is never tried as the
   next site (`gpio.c` 28->32 and `main.c` 98->101 for `LDR`, `stm32f4xx_hal.c` 95->98 for `MOV`).
   Collecting those 3 would need the pass to iterate to a fixed point; the criterion is already
   met, so this slice does not do it, and the boundary is written here instead of being left as an
   unexplained difference in the counts.
3. **`LDR` means the literal pool only** (`.Llit`): `LDR rX, [rY, #imm]` reads memory, not a
   constant, and is never a candidate. Of the 828 `.Llit` loads in the corpus, 62 are removed this
   way.

### 32.5 How not to read this

1. Do not read 115 as "the end of this rule": a fixed-point iteration of the same family would
   take 3 more (32.4 item 2), and the real answer is still V-3 (the allocator).
2. Do not turn the 6 tail sites into an S21 debt and restructure the per-function pass: that is a
   design boundary (the pass runs per function), and covering it needs a whole-TU flow, which is
   not this rule's job.
3. Do not call S21 landed without a full `make test`.
