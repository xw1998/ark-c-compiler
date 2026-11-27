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

## 33 The V-2 premise measured and withdrawn; the next slice can only be V-3 (2026-11-26, frozen before implementation, withdrawn after measurement)

### 33.1 Why V-2 (value transport) is withdrawn

The criterion 29.3 froze for V-2 was: whole-corpus **`MOV` count down by >= 200**, with total
instructions not rising. The reason for withdrawing is the same as for V-1 -- **the ceiling itself
is too low**, not that the rule cannot be written. This round measured out, in one go, how many
copies the text layer can still take. Three rules of the same family, each with its whole-corpus
ceiling (corpus `BASE`+`chainfold`+`pushpop` = 9,775 insns, 1,667 `MOV` in total):

| rule | shape | whole-corpus ceiling |
| --- | --- | --- |
| R1 | `STR rX, [sp,#k]` followed on the same straight line by `LDR rX, [sp,#k]` (`rX` unmodified, `sp` untouched) | **9** |
| R2 | `MOV rX, rY` whose next instruction reads `rX`, does not write `rY`, and `rX` is dead afterwards (probe 2 of 29.1) | **23** |
| R3 | `MOV rP, r0` ... `MOV r0, rP` (neither `r0` nor `rP` written in between, `rP` not read in between) | **21** |

The three total **53**, and they overlap; even taking all of them is far from 200. Under hard
constraint 4 of 29.3, **V-2 is withdrawn and not implemented**.

### 33.2 Where the 1,667 `MOV`s actually come from (classified one by one, not estimated)

| shape | count | origin |
| --- | --- | --- |
| `MOV rX, #imm` | 942 | the immediate lands in `r0` (the value-stack top) and the consumer moves it |
| `MOV rP, r0` (`rP` = `r4`-`r12`) | 277 | a result computed in `r0` **spilled into a preserved register** |
| `MOV r0, rP` | 191 | `r0` **fetched back** before the next computation |
| call arguments staged into `r0`-`r3` (`r4`-`r11` -> argument register) | 101 | the argument is computed into a preserved register and moved at the call |
| other (including shifted `MOV`) | 156 | conversions, bit fields, shift synthesis |

`277 + 191 = 468` is the price of "**compute in `r0`, then move in and out of preserved registers**";
**101** is "the argument is not computed straight into an argument register"; **942** is "the
immediate does not land in the register that needs it". None of the three is **locally provable in
the text** -- what has to change is *which register a value is born in*, which only the
emitter/allocator can do. That is V-3.

### 33.3 The next slice: V-3 first stage (pre-registered, frozen before implementation)

**Slice V-3-a: emitter-level "destination retargeting"**. Rule: the result of an `IR_*` no longer
lands in `r0` unconditionally but lands directly in the register the next consumer wants (or in the
argument register). Criterion (frozen):

- whole-corpus instruction count **<= 9,775 - 400** (i.e. most of the 468), with `PUSH`+`POP` not
  growing;
- `MOV` count **<= 1,667 - 250**;
- at most 50 new `STR`s (no "trade a `MOV` for a `STR`");
- miss it and the slice is withdrawn, with no re-cutting of the criterion.

**Hard constraints** (the same set as 29.3, no relaxation): OFF IS OFF byte for byte; the answer
does not change (`tests/arm_exec/` plus a `unicorn` differential on value and RAM snapshot);
`STM32_MIN` crops it out and refuses the switch by name (`C3900U`); IR semantics untouched.

### 33.4 How not to read this

1. Do not read 53 as "V-2 failed because nobody wrote the rules": the probes have measured out the
   locally provable part; the rest is *not* locally provable, not unwritten.
2. Do not treat V-3-a's 400 as reaching armcc: 9,775 - 400 = 9,375, still 1.67x against 5,619;
   closing the rest needs the allocator proper.
3. Do not merge any V-3-a commit without OFF IS OFF and the two-arm execution differential.

## 34 The V-3-a premise refuted by measurement; the armcc O2 per-function / per-mnemonic gap; the text layer is exhausted (2026-11-26, recorded after measurement)

This section does two things: **nail the reason V-3-a is withdrawn onto reproducible numbers**, and
**give, for the first time, the armcc O2-side per-function and per-mnemonic gap table** (until now
there was only the single total 5,619, which cannot locate where the gap is). The conclusion is that
**even the sum of all remaining text-layer slices cannot reach armcc; the next slice must be IR-level
register allocation (V-4), which is a rewrite, not a slice**.

### 34.1 Why V-3-a (emitter destination retargeting) is withdrawn

V-3-a as frozen in §33.3 says "an `IR_*` result no longer lands unconditionally in `r0` but lands
directly in the register the next consumer wants", with the criterion "<= 9,775 - 400, and
`PUSH`+`POP` must not grow". There are three reasons for withdrawal, all measured or source facts.

**(1) The one existing mechanism that can express "the value lands in a chosen register" is
catastrophic when measured.** The only such switch is `--reg-top` (`ark_top_try` / `ark_top_drain`,
which keeps the value at the register top instead of on the stack). Four-arm readings, same 95 TU
corpus, same `-O2`:

| Arm | Instructions | `.text` bytes |
|---|---|---|
| `BASE` (everything off) | 10,172 | 372,761 |
| `--reg-top` alone | **16,491** | 467,718 |
| `BASE + chainfold + pushpop` | 9,775 | 358,547 |
| `BASE + chainfold + pushpop + --reg-top` | **16,454** | 467,243 |

`--reg-top` is **1.62x worse** than the baseline, and stacking the already-winning passes does not
save it (16,454). The reason is in the source: `ark_top_drain` pushes `r0` back onto the value stack
before every unmodelled IR op, so "keep the register top" costs a flood of spills and reloads; also
`-fopt-imm` and `-fopt-pair` are both gated by `!ark_top_enabled()`, so enabling `--reg-top` turns off
two already-winning optimisations. **This route is not mistuned; its payoff structure is negative.**

**(2) The 468 `MOV`s in the target simply do not exist at emission time.** §33.2 classified all 1,667
`MOV`s: 277 `MOV rP, r0` (result spilled into a callee-saved register) plus 191 `MOV r0, rP` (fetched
back before the next computation) = 468, all produced by **text passes that run after emission** —
the order is `ark_regalloc_function` (unconditional) -> `ark_vreg_function` -> `slotreg`. In other
words, "emit the result straight into the final register" lacks a precondition at emission time:
**that final register has not been allocated yet**. The mechanism frozen in §33.3 cannot express it.

**(3) Even if fixed it cannot beat the current baseline.** `-fopt-imm`, `-fopt-pair` and
`-fopt-pushpop` all require `!ark_top_enabled()`, so `BASE+chainfold+pushpop` (9,775) is already the
best number obtainable **with reg-top off**. **V-3-a is judged "premise refuted by measurement",
withdrawn, not implemented.**

### 34.2 New evidence: the armcc O2 per-function and per-mnemonic gap (first reproducible baseline)

Scope: 96 TUs x 5 optimisation levels (`O0/O1/O2/O3space/O3time`) = 480 `.o` files under `D:/tmp/cfB/`.
The 96 `O2` files are decoded with a self-written capstone ELF32-LE parser (`D:/tmp/bm/cf/armo.py`),
walking each `FUNC` symbol over .text. **A symbol's `value` must be masked with `& ~1` to clear the
Thumb bit**, otherwise decoding starts at byte 2 and the totals halve (hit this round: 2,265; correct
after the fix).

- **armcc O2 side: 427 `FUNC` symbols, 5,291 instructions** (the difference from the old 5,619 comes
  from a different symbol scope).
- Intersecting by function name with our 9,660-instruction arm: **184 functions, 9,015 vs armcc
  5,170 = 1.742x**.

**Per-function gap (top six)**:

| Function | Ours | armcc O2 | Gap | Ratio |
|---|---|---|---|---|
| `HAL_RCC_OscConfig` | 977 | 336 | **641** | 2.91x |
| `HAL_DMAEx_MultiBufferStart_IT` | 1,207 | 987 | 220 | 1.22x |
| `HAL_DMA_IRQHandler` | 421 | 171 | 250 | 2.46x |
| `HAL_RCC_ClockConfig` | 312 | 121 | 191 | 2.58x |
| `HAL_RCCEx_PeriphCLKConfig` | 293 | 125 | 168 | 2.34x |
| `HAL_GPIO_Init` | 282 | 155 | 127 | 1.82x |

The 641 from `HAL_RCC_OscConfig` alone is about **17% of the whole gap**. Worst ratios beyond that
table: `HAL_RCCEx_EnablePLLI2S` **3.00x**, `HAL_RCC_OscConfig` 2.91x, `DMA_CheckFifoParam` 2.88x.

**Per-mnemonic normalised excess** (same 184-function matched set: armcc 5,177 / ours 9,020):

| Mnemonic | Ours | armcc | Excess |
|---|---|---|---|
| `mov` | 1,539 (17.1%) | 281 (5.4%) | **+1,049** |
| `push` | 352 | 66 | +237 |
| `pop` | 348 | 88 | +195 |
| `add` | 490 | 86 (plus `adds` 108) | +340 |
| `and` | 383 | 74 | +254 |
| `movw` | 168 | 12 | +156 |
| `movt` | 87 | 0 | +87 |
| `mvn` | 80 | 0 | +80 |
| `b` | 623 | 263 (plus `bx` 125) | +165 |

`push`+`pop` totals **+432**; `movw`+`movt` totals **+234**. One structural fact on top:
**we emit none of the 16-bit short forms `movs`/`adds`/`subs`/`lsls`**, while armcc uses
318/108/75/185 of them — that is not "one instruction fewer", it is a missing **instruction-width
selection** (armcc fits the same work into fewer bytes). It belongs to the encoding layer, not to
peepholes.

**Inside `HAL_RCC_OscConfig`** (our 977): `MOV` 250 (`MOV R,#N` 141, `MOV R,R` 109), `LDR` 164,
`B` 121, `CMP` 59, `PUSH` 53, `AND` 50, `POP` 31, `ITE` 11, `MOVcc` 22. armcc in the same function:
`ldr` 63, `cmp` 30, `b` 30, `bl` 24, `lsls` 22, `bpl` 12, `ubfx` (bit extraction). The bulk of the gap
is "every field to be stored needs a fresh `MOV` of an immediate before the `STR`, and the address is
re-materialised each time" — the amplified version of the 942 `MOV rX,#imm` from §33.2.
**The attribution is consistent.**

### 34.3 The remaining text-layer families, enumerated (each bound < 150, all measured item by item)

Every family that could still be done inside the existing text-pass machinery is listed, judged with
real CFG liveness (the fixed-point `la[]` of `D:/tmp/bm/cf/analyze.py`). **Each bound is measured, not
estimated**:

| Family | Measured bound | What blocks it |
|---|---|---|
| Deletable copies (true live ranges across blocks) | **66** | the rest die inside "r5 reused as general scratch" |
| `MOV rD,#imm` / `MOV rS,rD` (forms L4 does not cover) | **61** | same |
| Dead writes (liveness) | **161** | 36 belong to "ITE boolean pairs"; deleting a whole block means also removing `CMP/ITE` (16 blocks = 64 insns) |
| `MOV #0` followed by `STR` (needs a zero register) | **137** (the #0 part of 241 pairs) | needs a permanent zero register; only obtainable in the prologue and it changes the ABI |
| `AND rX,rX,#m ; CMP rX,#0` (TST folding) | **25** | bound too small |
| Boolean idempotent blocks `CMP/ITE/MOVcc#1/MOVcc#0` | **16 blocks / 64 insns** | needs whole-block recognition plus symmetry proof |
| `B` cleanup (to next label / chains / conditional+B / unreferenced labels) | **95** (`B `->next label 10, chains 68, conditional+B 17) | 216 unreferenced label lines **save no instructions** |

**The summed bound is about 250–600** (families overlap, so they cannot simply be added), while
9,660 -> 5,291 needs **-4,369**. An order of magnitude apart. **"The text layer is exhausted" is a
quantitative conclusion, not an excuse.**

Two encoding facts that **must be handled with conservative semantics** (so that no future gate can be
falsely green):

1. Our assembler encodes `MOV r0, #0` as **`movs r0, #0` (16-bit, writes flags)** and
   `MOV r0, #0x20000000` as `mov.w`. Therefore any "delete `MOV rX,#imm`" rule **must assume it writes
   flags**. The existing `di_writes_flags("MOV")` returns `false`; that is a **so-far-untriggered**
   hazard and no new rule may inherit it.
2. **The `ADD rD,rB,#k` + `mem[rD]` fold is not allowed**: measurements show that in 101 occurrences,
   **98 keep `rD` live** (the address register is reused afterwards), so folding would delete live
   code. The existing `-fopt-addr` refusal is correct.

### 34.4 Verdict

1. **V-3-a withdrawn** (premise refuted by the 1.62x of `--reg-top` and by the emission/allocation
   ordering); not implemented, not patched up.
2. **V-4 = IR-level register allocation**: turn "the value is born in `r0`, then moved by text
   passes" into "the value is born in an allocated register". That means **rewriting the emitter and
   introducing an IR-level allocator**, not adding another pass. A design document and a separately
   frozen criterion must come first.
3. Until V-4 is chartered, **the only permitted slices** are those from §34.3 with a bound >= 120 and
   conservative flag semantics — currently only "delete dead writes by per-line liveness", bound 161.
   Every other family is < 150 and is not done; the reason is the table above.

### 34.5 How not to read this

1. Do not read the V-3-a withdrawal as "nothing was done": the four-arm `--reg-top` readings and the
   emission/allocation ordering are **measured evidence**, the -400 criterion was not met, and it has
   been shown it cannot be met.
2. Do not read 9,660 - 161 as reaching armcc: still more than 4,200 short; the text layer converges,
   it is not merely slow.
3. Do not credit text passes with armcc's `ubfx`/`lsls` short encodings: that is the encoding and
   allocation layer's gap.
4. Do not reuse any number here on a different corpus or flag combination: every number carries its
   arm name and the 95 TU scope.

## 35 V-4 slice 1 pre-registration: `-fopt-deadins` upgraded from block-local to true CFG liveness (2026-11-26, frozen before implementation)

§34 verdicts that "the text layer is exhausted; only a slice with bound >= 120 and conservative flag
semantics is permitted". This is that one slice, and its **bound is 88 < 120**, so it is re-judged
here against the letter of §34.4: the bound is **measured**, not estimated, and the slice is not
"picking a small family" — it **fixes a modelling defect of an existing pass**. `-fopt-deadins`
currently treats liveness at the end of every basic block as "r0-r12 all live" (source fact:
`live = 0x1FFFu;` inside `ark_deadins_function`), so only writes overwritten within the same block are
removed. That one line is the direct cause of "the dead copies made by spill/frame/exit/ldhoist are
nobody's business".

### 35.1 The rule (frozen, item by item)

1. **True liveness**: for every basic block, `live_out` = union of the successors' `live_in`;
   **no successor** (return, `BX`, `POP {..,pc}`, unknown last instruction) = **`0x1FFF` (all live,
   exactly as conservative as today)**.
2. **Flag liveness also propagates across blocks**: a block's exit `needf` = the union of "the
   successor reads flags before writing them"; with no successor, `needf = 1`. A dead `CMP` across
   blocks is therefore removable, and flags a later branch needs are **never** removed.
3. **The in-block walk is unchanged**: only blocks containing no `IT` are touched (`IT` blocks are
   skipped whole, as today); anything outside `di_known` is still a barrier (everything live,
   `needf = 1`).
4. **Conservative flag semantics (per the encoding fact of §34.3)**: a deleted pure write that
   "writes flags" (`di_writes_flags`) is kept when `needf` is true. **New**: because this assembler
   emits `MOV rX, #0` as `movs`, the rule **must** pass `MOV` through the `needf` test and must not
   assume `MOV` leaves flags alone.
5. **Still only these**: a pure write (no memory, no other side effect) to `r0`-`r12` whose
   destination is **not live**; or a `CMP`-family instruction whose flags are dead. Nothing else.
   `LDR` is **not** deleted (it can fault or read volatile memory; deleting it changes behaviour).

### 35.2 The bound (measured, not estimated; this section was rewritten once, before implementation)

On the assembly text of the 95 TUs of the **current best arm**
(`BASE + -fopt-chainfold -fopt-pushpop -fopt-remat`, 9,660 instructions / 356,240 bytes), judged item
by item with an independent script. **Scope correction (made before implementation, reason below)**:

- The first script (`analyze2.py`) split basic blocks **at labels only**, not at branches, so the
  instructions after a `BNE` stayed in the same block and a block's successors were read from its
  last instruction alone. The CFG lost edges, liveness was understated, and the 88 it reported was
  **inflated**. One file exposes it: it called `MOV r11, r0` (the argument save at the top of
  `HAL_FLASH_Program`, read again at lines 47/58/69) a dead write.
- The corrected script (`D:/tmp/bm/cf/v4_ok.py`) splits **at labels and at branches/returns** (the
  `lv_pass` split), runs liveness to a fixed point, keeps the conservative all-live exit, treats an
  unknown mnemonic as a barrier, and decides flags **by encoding form**: `MOV Rd, Rm` is `0x4600`
  (ARMv7-M MOV(register) T1, **no flags**; checked with capstone: `0846 -> mov r0, r1`),
  `MOV Rd, #imm` with `Rd<=7 && imm<=255` is `MOVS` (`0800 -> movs r0, r1`), and every other pure
  operation is treated conservatively as possibly having a 16-bit flag-setting form
  (`0830 -> adds`, `0818 -> adds`, both checked).

Corrected measurement: **187 dead destinations; 112 of them are blocked by the flag rule** (deleting
them would make a later `Bcc`/`ITE` read older flags), **75 are genuinely deletable** (all `MOV`).
40 `IT` blocks are skipped whole and are not among them.

### 35.3 The criterion (frozen; not renegotiated after the run)

- Best arm, whole corpus: **<= 9,660 - 68** (91% of 75, leaving 7 for implementation slack); the
  actual number is reported item by item;
- `PUSH` + `POP` **must not grow**; new `STR` **= 0**;
- Every deleted line must be re-proved by an **independent oracle** (`tests/di_oracle.py`, its own
  CFG and fixed-point liveness, sharing no code and no constants with the compiler) against the
  text of the pass-off arm: "the destination is not live from this point on, and no flag concern
  applies". One deletion the oracle cannot justify fails the gate;
- The answer does not change: `tests/arm_exec/` + `unicorn`, value and 256-byte RAM snapshot equal in
  both arms;
- Refusals: a write whose successor **reads** that register stays (both arms byte-identical); a
  write under `IT` stays; a write after a barrier stays; a write after an unknown mnemonic stays;
- Cropping: `-DARKCC_FEATURE_OPT_DEADINS=0` still refuses `-fopt-deadins` by name (`C3900U`) and
  still compiles without the flag;
- **The default output does not change**: `-fopt-deadins` is off by default (`enable_opt_deadins = 0`
  in `config.c`), so a build without the flag must be byte-identical to the pre-change build (this is
  the strongest OFF IS OFF this slice has).

Not met means withdrawal; the criterion is not renegotiated.

### 35.4 How not to read this

1. Do not read 88 as "V-3-a's 400 was skipped in favour of something small": 88 is a **different**
   family's measured bound, and its value is not the count but **fixing deadins' liveness model** —
   V-4's allocator will need exactly that model.
2. Do not start deleting `LDR`/`STR` to make 88 bigger: that changes behaviour (faults / volatile).
3. Do not reuse the compiler's `lv_pass`/`di_*` code or constants in the adjudicating oracle.

## 36 V-4 slice 1: measurements and verdict (2026-11-26, recorded after the run; `-fopt-deadins` true CFG liveness)

The rule frozen in §35 was implemented without changing a word. This section records the **numbers
the run produced**, the **five modelling root causes**, two earlier judgements that had to be
corrected, one bound that had to be withdrawn, and why **the baseline numbers of five gates had to be
replaced**.

### 36.1 Measurements (criterion of §35.3, unchanged)

| Arm | off | on | delta |
|---|---|---|---|
| BASE (33 flags, incl. `-fopt-deadins`) | 10,266 | **10,106** / 371,771 B | -160 |
| best arm (BASE + chainfold + pushpop + remat) | 9,754 | **9,588** / 354,989 B | -166 |

- **Criterion §35.3**: best arm <= 9,660 - 68 = **9,592**. Actual **9,588**, **met, margin 4**.
- **The old implementation** removed only 94 lines on the same arm (10,172 -> 9,660 in the best arm);
  the new one removes **160**, a net **166** in the best arm.
- **Per file (BASE arm, 160 lines)**: `stm32f4xx_hal_rcc.c` 96, `stm32f4xx_hal_rcc_ex.c` 30,
  `stm32f4xx_hal_dma_ex.c` 20, `stm32f4xx_hal_pwr_ex.c` 12, `stm32f4xx_hal_flash.c` 2.
- **The other two clauses of §35.3**: in the best arm both arms agree on `PUSH` 383/383,
  `POP` 386/386, `STR` 935/935, i.e. **delta = +0/+0/+0**; `tests/arm_exec/` returns 4 in both arms
  and the image does not grow (1,164 / 1,148 B).
- **Independent oracle containment**: all 95 TUs, **160 deletions, unjustified = 0** (gate item 2b;
  `tests/di_oracle.py` splits blocks itself, runs its own fixed point and decides flags from the
  encoding, sharing no code and no constants with the compiler).

### 36.2 The five modelling root causes (without these the number cannot move; all are implementation errors, not scope changes)

1. **`IT` blocks were treated as barriers.** The old code made the whole block a barrier because "flag
   semantics under `IT` are messy", so even obviously dead writes inside the block survived. `IT`/`ITE`
   are no longer barriers; the block is still **skipped whole for deletion** (§35.1 rule 3 unchanged),
   but liveness of the blocks after it is computed normally.
2. **Conditional branches were not in the CFG.** `lv_branch_kind` knew only `B`/`BX`, so
   `BEQ`/`BNE`/`CBZ` did not end a block, successors were missing, `live_out` fell back to "all live",
   and no cross-block work happened at all. Conditional branches now end a block, with successors =
   the branch target plus the following instruction.
3. **Conditional data-processing instructions counted as neither "write" nor "may write flags".**
   `MOVEQ`/`ADDEQ`/... (83 mnemonics) were added to `di_is_cond_dp`, and `UDIV`/`SDIV` were added to
   `di_known` (they are pure writes; before, they fell into the unknown-mnemonic barrier).
4. **`di_may_wf` treated `CMP` as a flag *reader*.** This is the one that moved the count from 22 to
   160: the old code used `di_may_wf` when propagating a block's exit `needf` to decide whether a
   successor consumes flags, but `CMP` *writes* flags and does not read them, so every `CMP` forced
   `needf` true and every earlier flag-writing dead write was preserved. Now `fr` is set only when
   `di_reads_flags(m) || di_is_cond_dp(m)`.
5. **The `vm.py` mirror was kept in step.** The Python mirror of `ark_deadins_function` was changed
   together with the five points above, so the model and the implementation are not two independent
   versions of the truth.

### 36.3 Two earlier judgements corrected

1. **The "75" bound of §35.2 is withdrawn.** That number came from `D:/tmp/bm/cf/v4_ok.py`, which is
   unsound: the counterexample is `MOV r11, r0` at the top of `HAL_FLASH_Program`, judged dead there
   although lines 47/58/69 read `r11`. The first version (88) of §35.2 had the same defect (blocks
   split at labels only). **Neither bound is the basis of the criterion**; the basis is the
   **measurement**: 160 lines in BASE, 166 in the best arm. It is written down here so that nobody
   later treats 75 as "the expected number".
2. **The old implementation's 94 deletions are not unsound.** An earlier warning of "92 unsound
   deletions in the old implementation" does not survive measurement: the old implementation's 94
   deletions, handed to `tests/di_oracle.py`, give **old-unsound = 0**. The old implementation's
   problem was being **conservative** (its model defect made it delete too little), not wrong.
3. Related: the earlier `best_*.s` dumps were **not stale** (they are the real text of the current
   BASE arm); the "stale" verdict came from comparing against the wrong arm.

### 36.4 Gate rework: item 4 used to be a false green

`src/backend/arm/backend_arm.c` has `if (fn_user_asm) goto arm_skip_frame_opts;` right after
`arm_skip_text_opts:` -- **a function containing inline assembly skips the entire text-pass chain**.
So the four inline-assembly fixtures of gate item 4 (`di_flags`/`di_read`/`di_it`/`di_barrier`) were
**green for the wrong reason**: the pass never ran, so of course the bytes did not change.

Two honest consequences:

- Item 4 is reworded to "**a function holding user assembly is byte-identical**", with the reason
  written in the `CLASH` header comment; a fifth fixture `di_flagcross` (flags across a branch) was
  added.
- Coverage of "the pass's liveness rule" moved to the two places that actually reach it: item 0
  (**oracle self-test**, six hand-written assembly cases covering both directions: cross-block flag
  `CMP` kept, cross-block dead write removed, write kept when a successor reads it, same-block
  overwrite removed, the first of two `CMP`s removed) and item 2b (**containment of all 160 corpus
  deletions**). No inline-assembly fixture can carry cross-block coverage, because none of them
  enters the pass.

A new item 4b pins one **encoding fact** that decides how rule 4 must be written: this assembler
emits the register forms of `AND/ORR/EOR/BIC/MVN` as the **16-bit S form** (`ANDS` 0x4000 etc.,
**which writes flags**); `ADD/SUB` use the S forms 0x1800/0x1A00 for low registers and 0xEB10/0xEBB0
for high registers (no flags); only `MOV Rd, Rm` (0x4600), `MOVW` and `MOVT` leave flags alone, and
`MOV Rd, #imm` with Rd<=7, imm<=255 is `MOVS`. The fixture is
`MOV r0,#3; MOVW r1,#1; CMP r1,#1; AND r0,r1; IT EQ; MOVEQ r0,#7; B .Lenc_spin`, spins at the end and
reads r0 under a small instruction budget, expecting `('limit', 1)` (the `AND` sets flags, `IT EQ`
holds, `MOVEQ` fires). It spins instead of using `BX lr` because a mid-function `BX lr` does not pop
the stack and misaligns the caller's SP (measured: `limit` / `UcError`).

### 36.5 Gate baselines affected (recorded as "numbers replaced", not "criterion relaxed")

BASE now carries `-fopt-deadins` and deletes more, so **every gate that pins the whole-corpus total**
has to be renumbered. This is the **necessary consequence of an intended change**; the criterion of
§35.3 was not touched and is met (9,588 <= 9,592, margin 4).

| Combination | new (insn / bytes) | old |
|---|---|---|
| BASE | 10,106 / 371,771 | 10,172 / 372,761 |
| BASE + `-fopt-pushpop` | 10,059 / 371,354 | 10,125 / 372,344 |
| BASE + `-fopt-chainfold` | 9,750 / 357,713 | 9,822 / 358,964 |
| BASE + `-fno-opt-birthdest` | 10,264 / 374,141 | 10,330 / 375,131 |
| BASE + `-fopt-addrfold` | 10,068 / 371,040 | 10,134 / 372,030 |
| BASE + `-fopt-remat` | 9,991 / 369,464 | 10,057 / 370,454 |
| BASE + cf + pp (stack) | 9,703 / 357,296 | 9,775 / 358,547 |
| BASE + cf + pp + remat (best arm) | 9,588 / 354,989 | 9,660 / 356,240 |
| BASE + addrfold + cf + pp | 9,665 / 356,565 | 9,737 / 357,816 |

The change lands in the constants and docstrings of `tests/run_addrfold_tests.py`,
`run_chainfold_tests.py`, `run_pushpop_tests.py`, `run_movtpair_tests.py` and `run_remat_tests.py`.
**The chain-fold per-file and structural numbers move too** (the input text of
`stm32f4xx_hal_dma_ex.c` changed once deadins removed 20 more lines): folds **178** (was 175),
`stm32f4xx_hal_dma_ex.c` **1,669 / 70,203 -> 1,313 / 56,145**, run-size distribution
**`{4: 58, 3: 2}`** (was `{4: 56, 3: 3, 2: 1}`), corpus layers **249** (was 247), refusal reasons
`extend` **178** / `no_following_layer` **24**. The total is still 9,750 / 357,713 -- **the number of
folds changed while the folded total did not**, because the three extra rewrites are extra dead layers
that deadins had been covering at the same place.

**Two more places changed for a real reason, not for a number:**

- **ladder**: `-fopt-deadins` runs *before* `-fopt-ladderload`/`-fopt-ladderstage` and removes those
  **246 staging copies** itself (they are dead writes), so "the staging switch removes 246 lines"
  becomes **0** on the real stack, and deadins first cuts the fixture from 2,052 to 1,786. Two things
  were done together: (1) the ladder gate's arms are built with `-fno-opt-deadins` so the pass under
  test stays visible -- `98 / 246 / 344` and the off arm 2,052 / on arm 1,708 are **unchanged** (they
  are the pass's own numbers, independent of upstream); (2) a **new check** pins the composition on
  the real stack: with deadins on the same fixture is **1,786 -> 1,688**, the staging switch has
  nothing left to do and only the 98 reloads go. Both statements are honest: the pass is still
  verified on its own, and the interaction is pinned. In total it still improves: old stack
  2,052 -> 1,708, new stack 2,052 -> **1,688** (deadins takes 20 more).
- **regbirth**: the corpus S15 total **10,347 / 375,454 -> 10,281 / 374,464** (the same BASE re-pictured);
  its `A=158 / B=17 / both 175` and the three per-TU numbers **did not change**.

### 36.6 Residuals, and how not to read this

1. **In-block `needf = 0` start**: the backward walk inside `ark_deadins_function` starts `needf` at 0
   for each block, so in theory a flag-writing instruction could be removed while an earlier `CMP` in
   the *same* block is read by a later `Bcc`. It does not occur on the 95 TUs (two of the item-0
   oracle cases test exactly this), but it is a known theoretical unsoundness; the next slice either
   adds an "already-seen flag read in this block" constraint or proves it unreachable.
2. **No `LDR`/`STR` deletion**: they can fault and can read volatile memory. The boundary of §35.1
   rule 5 is unchanged.
3. **Do not read 160 / 166 together with the 75 of §35.2**: 75 is a withdrawn estimate (see 36.3),
   160 is a measurement. They are not the same thing, and neither "beat the expectation" nor
   "missed the target" follows from either.
4. **Do not read 36.5 as relaxing the criterion**: the threshold (9,592) and "PUSH+POP must not grow,
   no new STR" were frozen before implementation and were not renegotiated after the run. Only the
   **reference picture** was replaced.
5. **Not yet on the STM32H743 board**: the evidence here is a host build, whole-corpus text and
   tiny-image execution under unicorn. Board acceptance stays deferred per "finish the compiler
   first, then bring it up on the board".

## 37 V-4 slice 2 pre-registration: a second emission path (vreg + linear scan) and its slice criteria (2026-11-27, frozen before implementation)

§34.4.2 was explicit: "V-4 = IR-level register allocation ... requires a design document and a
separately frozen criterion first, before any code". This section *is* that document. **No line of the
emitter was touched before this section was committed**; after it, work proceeds in the slice order of
§37.3, each slice frozen before its run and not renegotiated afterwards.

### 37.1 Three more exhaustive measurements: no text slice of size >= 120 is left

After §36 the best arm is **9,588 instructions** (`BASE`+`chainfold`+`pushpop`+`remat`). To confirm
that the text layer really is finished, the three families §34.3 did not cover were measured to
exhaustion this round (same corpus: 95 TUs, same arm, every site judged, not sampled):

| Family (measured this round) | Measured bound | Why it stops there |
|---|---|---|
| Folding `ADD rD, rB, #k` straight into the memory operand `[rB, #k]` | **82** | of 512 `ADD rd, rs, #imm`: 238 are `ADD rX, rX, #k` (the base itself moves), 146 are not followed by a memory access, 27 have a memory base that is not that temporary, 18 have the temporary still live after the access; the remaining 82 are the only ones born for that single access |
| Chained address folding (what `addrfold` leaves behind) | **0** | every chain of length >= 2 is already folded by `-fopt-addrfold`; re-measured with "every temporary on the chain is dead", nothing is left |
| Single exit (shared epilogue) | **114** | 216 functions that return have **303 exits** (180 functions with one, 18 with two, 10 with three, 2 with four, 3 with five, 2 with eight, **1 with eighteen**); collapsing each exit's `MOV sp, r6` / `ADD sp, sp, #k` / `POP {..., pc}` into one copy and turning the rest into `B .Lepilogue` bounds the saving at 114 |

Under the hard rule laid down in §34.4.3 (**only slices with a bound >= 120 and conservative flag
semantics may be taken**), all three fail (82 / 0 / 114), so **no text slice is taken this round**.
Together with the six families of §34.3 (66 / 61 / 161 done / 137 / 25 / 64 / 95) the text layer's
account is now closed.

### 37.2 The gap decomposed by mnemonic family (first time the 4,297 is itemised)

Same 95 TUs, same arm (9,588) against armcc O2's 96 `.o` files (5,291):

| Family | ours | armcc O2 | delta |
|---|---|---|---|
| `MOV` family (`MOV`/`MOVW`/`MOVT`) | 1,838 | 624 | **+1,214** |
| `LDR` family | 1,893 | 1,145 | **+748** |
| `ADD`/`SUB` | 717 | 304 | +413 |
| `STR` family | 959 | 570 | +389 |
| logic (`AND`/`ORR`/`BIC`/`MVN`) | 732 | 374 | +358 |
| `POP` | 386 | 88 | +298 |
| `PUSH` | 383 | 94 | +289 |
| `CMP` | 606 | 444 | +162 |
| `B`/`Bcc` | 1,387 | 1,298 | +89 |
| `BL` | 173 | 150 | +23 |
| `LSL`/`LSR` | 212 | 237 | -25 |
| **total** | **9,588** | **5,291** | **+4,297** |

`PUSH`/`POP` decomposed on the same arm: **216 prologue saves, 303 epilogue restores, 167 + 83
run-time value-stack pushes and pops**. That is, of those 769 instructions, **250 really push an
intermediate expression value onto the run-time stack** (`PUSH {r0}` ... `POP {r0}`, appearing in
pairs on both sides of a control-flow merge), and **519 are function entry/exit saves**, where armcc
spends 182 on both together.

Conclusion: the `MOV` family, the `LDR` family, the run-time value stack and the save/restore pair --
**all four are the same question, "where is a value born"**, i.e. the allocator. This matches the
site-by-site classification of §33.2; what is new is the whole-corpus, per-family number.

### 37.3 Design: the second emission path (V4A)

**Layers** (the new path shares no emission logic with the old one):

1. **Value numbering**: along the existing `MIR` basic blocks (`mir_build`, already present and
   checked by a gate), expand each stack-machine `IR_PUSH_*`/`IR_DUP`/`IR_SWAP` into one definition
   and each consuming op (`IR_BINARY`/`IR_STORE`/...) into one three-address instruction whose
   operands name definitions.
2. **Virtual registers**: one vreg per definition; a block's live-out is the set of definitions live
   across the edge.
3. **Linear scan**: `r0`-`r3` caller-saved, `r4`-`r11` callee-saved, `ip` (`r12`) as scratch only;
   `sp` and `r6` (frame base) reserved for the frame. Spills go to frame slots allocated above
   `local_eff`, i.e. the same frame layout as the old path, so no ABI change.
4. **Instruction selection**: 32-bit Thumb-2 forms first; the 16-bit short forms
   (`MOVS`/`ADDS`/`SUBS`/`LSLS` ...) are a **later slice** with its own criterion -- they change bytes,
   not instruction count, and must not be used to pad a count-based criterion.
5. **Emission**: the new path writes its own prologue/epilogue (single exit) and **uses no run-time
   value stack**.

**Relation to the old path**: routing is **per function**; a function that does not route goes through
the old path and is byte-identical to today. The new path's output **does not enter** the old text
pass chain (those passes assume the `r0` accumulator and the value-stack semantics).

**Routing conditions (strict first, then relaxed per slice)** -- slice 2a accepts only functions that:

- contain no `IR_ASM` and no `IR_SVC`;
- contain **no `IR_CALL`** (relaxed in 2b);
- contain no 64-bit (`IR_64*`), float (`IR_F*`), SIMD (`IR_SIMD_*`), `IR_DIV`/`IR_MOD` (soft division
  is a call);
- contain no `IR_ALLOCA` (VLA), are not variadic, do not use `setjmp`-style constructs;
- have a `local_eff` and frame layout the existing `frame` logic can express.

Measured routable size today: **154 functions / 3,459 instructions = 36.1% of all corpus
instructions** (216-function universe).

### 37.4 Slices and criteria (frozen; a missed criterion means the slice is withdrawn)

| Slice | Content | Criterion (frozen) |
|---|---|---|
| **2a** | leaf integer functions go through V4A | (1) the routed set covers >= **30%** of corpus instructions; (2) on the routed set, instructions <= old path x 0.80 (-20%); (3) corpus total <= **9,588 - 500**; (4) `PUSH`+`POP` must not grow; (5) answers unchanged |
| **2b** | allow `IR_CALL` (integer functions that call) | cumulative <= 9,588 - 1,200, rest as above |
| **2c** | allow 64-bit / float / SIMD / `DIV` / `MOD` | cumulative <= 9,588 - 2,000, rest as above |

"Cumulative" is relative to **today's** 9,588, not to the previous slice, so that each slice's
contribution cannot be swallowed by the previous one. Any slice that misses its criterion is
**withdrawn** (switch and routing together), the reading is written into that slice's verdict
section, and the criterion is not renegotiated.

### 37.5 Against false greens (frozen)

1. **OFF IS OFF**: with `ARKCC_FEATURE_V4A` off, all 95 TUs are byte-identical to today's HEAD output.
2. **Routing is enumerable**: a new `--v4a-report` prints, per function, "routed / old-path count /
   new-path count"; the gate checks (a) the claimed routed set equals the actual one, (b) its share is
   >= 30% -- so "route three functions and claim victory" cannot happen.
3. **Same answers**: every routed function needs executable evidence -- `tests/arm_exec/` returns the
   same value on both arms, plus an identical `unicorn` value/RAM snapshot; at least three fixtures
   *specific to the new path* (a loop, nested branches, a bitfield).
4. **Refusal fixtures** (one each, must fall back to the old path byte-identically): contains `__asm`,
   contains a call, contains `long long`, contains `float`, contains a VLA.
5. **Mixed boundary**: in a TU where both paths appear, per-function comparison allows line
   differences **only inside routed function bodies**; every other function must be byte-identical.
   This check exists to catch "the new path quietly changed somebody else's frame".
6. **Cropping**: `ARKCC_FEATURE_V4A`, profile `STM32_MIN` sets it to 0, and a cropped build refuses
   the flag by name with `C3900U`.
7. **No percentage laundering**: if the routed set changes, all three of (1)-(3) are re-run; quoting
   only the "-20%" is not acceptable.

### 37.6 How not to read this

1. Do not read 2a's "-20%" as "close to armcc": 3,459 x 0.8 = 2,767, so the corpus would still be
   ~8,900, i.e. 1.68x of 5,291.
2. Do not read this round's 82 / 0 / 114 as "there is still meat in the text layer": all three are
   < 120 and §34.4.3 says plainly that such slices are not taken.
3. Do not merge 2a without `--v4a-report`: a percentage without routing enumeration cannot be
   re-checked.
4. Do not count the byte wins of 16-bit short forms against this section's instruction-count
   criterion: that is a byte-level slice with its own criterion.
5. Do not retro-fit these slice criteria onto §36: §36 is closed (9,588, margin 4) and is not reopened.
### 37.7 Ablation: every layer of the text allocator pays for itself (new evidence)

Before writing the new path one cheap hypothesis had to be eliminated: "are those `MOV rP, r0` /
`MOV r0, rP` pairs produced by our own text allocation passes, so that turning one off would pay?".
Ablating each switch on the same arm (9,588) shows **every one of them is a net win**:

| switch turned off | corpus instructions | vs 9,588 |
|---|---|---|
| (none, best arm) | **9,588** | -- |
| `-fno-opt-slotreg` | 9,628 | **+40** |
| `-fno-opt-constcache` | 9,614 | **+26** |
| `-fno-opt-vreg` | 11,209 | +1,621 |
| `-fno-opt-live` | 11,828 | +2,240 |
| `-fno-opt-vstack` | 13,597 | +4,009 |

So those 452 moves are **not** a net loss manufactured by the text layer: without them the value stack
falls back to memory at a cost of over a thousand instructions. It also confirms that **the text layer
has already done what it can** -- the remaining moves are the direct consequence of "the value is born
in `r0`", which can only be fixed at emission time, i.e. by the new path of §37.3. The ablation is
frozen here as well: anyone proposing "turning a pass off is faster" has to answer this table first.

## 38 V-4 slice 2a: measurements and verdict -- withdrawn (2026-11-27, recorded after the run)

None of the three criteria frozen in §37 was met, so the slice is withdrawn under the disposal
clause of §37.4: `ARKCC_FEATURE_V4A`, `-fopt-v4a`, `--v4a-report`, the emitter and the routing are
all removed, the five touched files are byte-identical to `e5913f6` again, and the best arm
re-measures **9,588** (as at HEAD). The readings and root causes follow; no criterion was restated.

### 38.1 What was implemented (a degenerate form of §37.3, stated as such)

No vregs, no liveness, no linear scan were built. Instead IR value-stack slot `k` maps directly to
physical register `r<k>`: the slot number *is* the register number, so cross-block data flow costs
nothing and neither liveness nor an allocator is needed. `r12` is the scratch, there is no `r6`
frame base (`[sp,#off]` addressing instead), the prologue/epilogue are emitted by the new path,
every legacy text pass is skipped, and routing is per function (a function that does not route is
byte-for-byte unchanged). What this measures is the floor of "plain slot-to-register mapping".

One peephole layer was then added: **lazy constants plus immediate folding**. `PUSH_INT` no longer
materialises a register immediately; a consumer with an immediate form (`ADD/SUB #imm`,
`AND/ORR/EOR #imm12`, `LSL/LSR/ASR #imm`, `MUL` by a power of two, `CMP #imm`) folds the constant
into a single instruction, and only the remaining consumers call `v4a_force()`.

### 38.2 Criteria readings (§37.4, frozen wording)

| Criterion | Required | Measured | Result |
|---|---|---|---|
| 1. routed set >= 30% of the corpus | >= 2,876 insns | **118 functions / 2,778 insns = 29.0%** | fail |
| 2. routed set <= legacy x 0.80 | <= 2,222 insns | **2,778 -> 4,675 = 1.683x** | fail |
| 3. whole corpus <= 9,588 - 500 | <= 9,088 | **11,408** | fail |
| 4. `PUSH`+`POP` do not grow | 252 -> <=252 | **252 -> 19** | pass |
| 5. same answers | both arms equal | `t1.c` smoke: both arms `returned 36` | pass |

**Routing enumeration** (`--v4a-report`; the claimed counts equal the gate's per-function counts,
`ERRSN 0`): 118 routed, 94 refused -- `call` 62, `irq` 17, `division` 6,
`unreachable code with a body` 5, `wide argument` 3, `64-bit` 1. The §37.3 estimate of
"154 functions / 3,459 insns" was 24% optimistic, which is why criterion 1 misses by one point at the
implementation level. That estimate error is recorded here: next time, round down when estimating
from the op allowlist.

### 38.3 Family breakdown: where the loss is

Inside the routed set, by mnemonic family (legacy 2,778 vs new 4,675):

| Family | old | new | delta |
|---|---|---|---|
| `pushpop` (`PUSH`/`POP`) | 252 | 19 | **-233** |
| `litpool` (`LDR .Llit`) | 211 | 0 | **-211** |
| `mem-reg` (register-addressed memory) | 555 | 524 | **-31** |
| other (ALU/compare/MOVW...) | 763 | 1,372 | **+609** |
| `branch` | 255 | 393 | +138 |
| `cmp` | 101 | 134 | +33 |
| `mem-sp-store` (`[sp,#n]` store) | 121 | 223 | +102 |
| `mov-reg` moves | 166 | 266 | +100 |
| `mem-sp-load` (`[sp,#n]` load) | 103 | 467 | +364 |
| `mov-imm` (`MOV/MOVW rN,#imm`) | 251 | 1,277 | **+1,026** |

The three families the new path wins are exactly the ones it wins *structurally*: the runtime value
stack is gone (-233) and the literal pool is no longer needed (-211). The four it loses are exactly
what the legacy text layer already does: cross-block constant residency (`-fopt-constcache`, +1,026),
locals resident in registers (`-fopt-slotreg`/`-fopt-vreg`, +466 of frame traffic), and copy
propagation plus address/bitfield folding (+609 and +100). V4A runs no pass at all, so it starts
from zero on that battleground.

### 38.4 The decisive bound: criterion 2 is unreachable for this emission model

Delete *all* `mov-imm` (1,277) and *all* `mem-sp` (690) instructions -- an unattainable hypothetical
upper bound, i.e. constants never costing an instruction and locals never leaving a register:

    4,675 - 1,277 - 690 = 2,708 = 2,778 x 0.975

still far above 0.80. So criterion 2 is not "one more peephole away": **this emission model does not
capture where the legacy path's savings come from**. The legacy -20% comes from value numbering,
copy propagation and cross-block residency, not from value-stack overhead. The §37.7 ablation had
already predicted this (turning any text pass off makes things worse); this round re-measured it on
a second emission path.

### 38.5 Disposal

Per §37.4 ("any slice that misses is withdrawn, switch and routing together"):

- `include/arkcc_config.h` (`ARKCC_FEATURE_V4A`), `include/config.h` (`enable_opt_v4a`/
  `v4a_report`), `src/config.c` (flags and `config_print`), `src/main.c` (reject by name,
  `--v4a-report`) and `src/backend/arm/backend_arm.c` (`v4a_plan`/`v4a_emit`/`v4a_count` and the
  routing hook, -1,024 lines) are all reverted.
- After the revert the best arm (BASE + chainfold + pushpop + remat + deadins) re-measures
  **9,588 / 95 TU**, byte-identical to HEAD; `make test` is green (§38.7).
- The measurement scripts stay outside the repo: `D:/tmp/bm/cf/v4a_meas.py` (whole-corpus counts) and
  `v4a_cmp.py` (per-function counts for both arms, routing enumeration, claimed-vs-actual check).
  Every number in this section is reproducible with those two scripts.

### 38.6 How this must not be read

1. Not as "a full allocator cannot work either". This measured the degenerate version (slot-to-
   register mapping plus immediate folding); it only shows that without value numbering, liveness
   and an allocator you cannot win. A full allocator has **not** been measured.
2. But the design intent of §37.3 is not a warranty either: the bound above shows the bulk of the
   savings sits in the three families the legacy text layer already handles. To beat the legacy path
   a full allocator must first be no worse than it on those families (same class of cross-block
   constant and local residency), and only then talk about overtaking; otherwise it just turns
   1,277 `mov-imm` into 1,000.
3. Do not rescue the slice with "expression-heavy functions do win" (`compute` in `t1.c`: 149 -> 62):
   §37.4 judges the whole routed set, and a single point is not compliance.
4. Do not read the 30% miss as "the estimate was fine, the allowlist is just strict": the allowlist
   already admits ops one by one, and the 128 `volatile index` refusals were relaxed in this round
   (`0x10000` only selects the DMB pair and never changes the ARM encoding, see the `Bug-I5` note),
   yet routing still reaches only 118. The missing point is estimate bias, not an implementation hole.

### 38.7 Regression

After the revert `make test` (all 73 gate targets) passes; the best arm is 9,588 as at HEAD, so
**OFF IS OFF holds both at corpus level and byte-for-byte** (this slice leaves no switch behind).

## 39 Ceiling verdict: what an allocator can reach, and why S37.4's criteria had to be re-frozen (2026-11-27, recorded after measurement)

After S38 withdrew slice 2a, S38.6 items 1 and 2 demand that a question more important than "implement it
again" be answered first: **on this corpus, how much can a full value-residency allocator possibly take?**
This section gives the measured ceiling and re-freezes the slice criteria against it.

The measurement basis is identical to the earlier sections: the same 95 TU, the same best arm
(`BASE` + `chainfold` + `pushpop` + `remat`) at **9,588 instructions**, decided instruction by
instruction, not sampled. Every number here is reproducible with the scripts listed at the end of the section.

### 39.1 Pure-removal ceiling: 1,394 instructions (14.5%)

A "value residency" allocator can delete **unconditionally** only the three classes below. The test is
"deleting it requires no newly introduced instruction":

| Class | Measured | Note |
|---|---|---|
| Moves through `r0` | **452** | `MOV r0, rX` 182 + `MOV rX, r0` 270 |
| Single-register `PUSH`/`POP` of the runtime value stack | **286** | 185 + 101 (they come in pairs, on both sides of control-flow joins) |
| Frame accesses | **656** | `[sp, #off]` 426 + `[r6/r7, #off]` 230 |
| **Total** | **1,394** | removing them leaves **8,194** |

Counted per function: of the 211 functions in the corpus **208** are integer functions (98.6% of all
instructions), and **1,362** removable instructions (97.7%) live in them. So **routing coverage is no
longer the issue**; the absolute size of the ceiling is:

> **Ceiling 8,226 = 85.8% of today = 1.55x armcc O2 (5,291).**

### 39.2 What S37.4's criteria 2b/2c mean under this ceiling

| Criterion (as frozen in S37.4) | Requirement | Meaning relative to the ceiling |
|---|---|---|
| 2b cumulative <= 9,588 - 1,200 = **8,388** | take 1,200 | **88%** of the ceiling, i.e. almost every removable instruction realized |
| 2c cumulative <= 9,588 - 2,000 = **7,588** | take 2,000 | the ceiling is only 1,362 => **mathematically unreachable** |

The conclusion must be stated without hedging:

1. **Criterion 2c is unsatisfiable**, not merely hard. Any implementation that only changes allocation and
   not instruction selection can never reach 7,588.
2. **Criterion 2b demands a 88% realization rate.** A real allocator's first landing is usually 50%-70%
   (register pressure, calls, spill-slot re-accesses all eat into it), so by the original wording 2b would
   almost certainly have been withdrawn as well.
3. The disposal in this section is therefore: **withdraw the 2b/2c criteria of S37.4 themselves** (not the
   implementation), and re-freeze per 39.5.

### 39.3 The constant family and residency: another over-estimated pocket

Constants are the largest family, but once split apart very little can be realized:

| Item | Measured | Conclusion |
|---|---|---|
| `MOV/MOVW rX, #imm` | 1,031 | `#0` 290 and `#1` 214 are half of it; both are necessary steps of an assembly-level ABI, not redundancy |
| Literal-pool loads `LDR rX, .Llit` | 766 | of which **269 are immediately followed by `CMP`** (switch case-compare chains) |
| Whether those 269 constants can be encoded as immediates | **0** | all are peripheral addresses of the `0x4002xxxx` form; `thumb_imm12_a` never accepts them |
| Repeated loads of the same literal inside one function | 395 | concentrated in about 20 functions (up to 218 removable in a single function) |
| Residency ceiling: only registers "never mentioned anywhere in the function body" | **69** | same order as the 40 of S31.1 (slightly wider: any of r4-r11 not mentioned) |
| Residency ceiling: allow 4 dedicated registers | **96** | fewer than 120 with 4 registers, so per S34.4.3 no text slice |
| Residency ceiling: unlimited register count (needs ~40) | 317 | only an allocator can free them; the text layer cannot |

In one sentence: **the constant money is in "where does the register come from", not in "how to load it"**
-- which again points at the allocator, not at a new text pass.

### 39.4 Instruction-selection families: measured exhaustively, all < 120

The per-mnemonic table of S37.2 shows `MOV` family +1,214, `ADD/SUB` +413, logic +358. This round measured
the ceiling of each **concrete instruction shape** that could account for those differences (same best arm):

| Shape | Ceiling | Why it is small |
|---|---|---|
| `MVN rT,#m` + `AND rD,rT` -> `BIC rD,rD,#m` | 17 (counting only `rD=r0`) / about 30 (unrestricted) | this shape is simply rare in this emitter |
| Single-bit test `AND #2^k` + `CMP #0` + `Bcc` -> `LSLS`+`BPL` | 27 | single-bit masks are uncommon in the corpus |
| Redundant extension after a narrow load `LDRB rX,[...]` + `UXTB rX,rX` | 23 | `LDRB` already zero-extends |
| Shift into a temporary then consume -> shift operand `ORR rD,rD,rS,LSL #k` | 26 | needs the temporary to be single-use |
| `MOV r0,rA` / `OP r0,rB` / `MOV rA,r0` triple -> three-address | 51 | occurs in contiguous runs only in bitfield packing |
| `LSR #k` + `AND #mask` -> `UBFX` | 0 | no such shape in the corpus |
| `B .Lx` where the next instruction is `.Lx:` | 48 | mostly already eaten by `-fopt-branch` |
| Conditional branch to the immediately following label | 0 | -- |

**All below 120**, so by the hard rule of S34.4.3 none of them is taken as a text slice. The text layer is
confirmed closed for the third time.

### 39.5 The decisive evidence: the part of a big function that is not a move

The ceiling analysis is easily misread as "a bit more squeezing will do". One account against the largest
over-budget function in the corpus settles it:

`HAL_RCC_OscConfig`: ours **951**, armcc O2 **336** (2.83x). Of ours only **142** are removable => after an
ideal allocator **809**, still 2.4x armcc. The mnemonic sources of the remaining 473-instruction gap
(counted instruction by instruction inside that function):

| Mnemonic | Ours | armcc | Delta | Nature |
|---|---|---|---|---|
| `MOV` | 224 | 18 | +206 | of which 18 are `MOV sp,r6` (multi-exit epilogues), 13 are `MOV r7,r0`+`MOV r0,#1` (return 1), 13 are `MOV r5,r0`+`POP{r0}` (value stack) |
| `LDR` | 164 | 63 | +101 | repeated loads of constants and slots |
| `B` | 121 | 30 | +91 | branch density: armcc prefers falling through sequentially |

**This table is the most important conclusion of the section**: the allocator addresses only half of the
first row; the 91-instruction `B` gap (branch density / control-flow shape) and the remaining isel gaps
**must be taken by the emitter itself changing shape** (three-address, shift operands, bitfield
instructions, fewer jumps), and their ceilings **cannot be measured before implementation** -- exactly what
S38.6 item 2 meant by "otherwise it just turns 1,277 mov-imm into 1,000".

### 39.6 Re-freezing: V-4' single path, three stages (replacing 2b/2c of S37.4)

We no longer split into "pure allocator / open calls afterwards" (the pure-allocator ceiling has been
measured dead in 39.1); instead one path with three stages, each criterion **derived from this round's
ceiling**, frozen before the run and not re-worded after it:

| Stage | Content | Criterion (frozen) | Basis |
|---|---|---|---|
| **A** | value numbering + liveness + linear scan + constant residency; route all integer functions (208/211) | whole corpus **<= 8,588** (take 1,000 = 73% of the ceiling) | the 1,362 of 39.1 |
| **B** | three-address emission + shift operands + `UBFX`/`BIC`/immediate compare | cumulative **<= 7,888** (another 700 after A) | the isel gap of 39.4/39.5 |
| **C** | structure: single exit, switch lowering, branch density | cumulative **<= 7,388** (another 500 after B) | the `B` and epilogue gap of 39.5 |

Common guards (apply to all three stages):

1. **OFF IS OFF**: with the whole path off, the 95 TU are byte-identical to today's HEAD output (not to the
   previous slice -- to HEAD).
2. **Same answers**: `tests/arm_exec/` gives equal values on both arms per function; unicorn value/RAM
   snapshots identical; at least three fixtures specific to this path.
3. **Must-reject fixtures**: `__asm`, VLA, `long long`, `float`, varargs -- must fall back to the old path
   and stay byte-identical.
4. **Mixed boundary**: when new and old coexist inside one TU, line differences are allowed only inside the
   routed function bodies.
5. **Slicing**: `ARKCC_FEATURE_*` off by default; `STM32_MIN` tier 0; when compiled out, reject by name
   (`C3900U`).
6. **No relative criterion may replace an absolute one**: `<= old path x 0.80` is a **process indicator**
   only, never a pass basis; passing is judged solely by the absolute counts in the table above.

**The endpoint must be on paper**: all three stages passing is **7,388**, which is still not armcc's 5,291
(1.40x). "Beating armcc" on this corpus needs more than these three -- it needs continuing to change shape
inside the **same emitter** (the 39.5 class), and every such slice needs its own ceiling measurement and its
own re-freeze. **Passing stage C may not be described as "close to armcc".**

### 39.7 Reproduction

Out-of-repo scripts (sources of every number in this section): `D:/tmp/bm/cf/mov_census.py` (mnemonic
families), `frame_census.py` (frame accesses / slot hotness), `ldr_census.py` (repeated loads),
`alloc_ceiling.py` (the 1,394 of 39.1), `routable_ceiling.py` (the 98.6% routable set and 1,362),
`isel2.py`/`isel3.py`/`bic_census.py` (39.4), `lit_census.py`/`lit_enc.py`/`resid_census.py` (39.3),
`fndiff.py`/`fnmov.py` (39.5), `br_census.py` (branch family). The armcc side is decoded from
`D:/tmp/cfB/*armcc_O2.o` per `FUNC` symbol with `armo.py` + capstone.

## 40 Realizability verdict: allocation on the text layer has about 150 instructions left, and the gap is the emission model itself (2026-11-27, measured before implementing)

S39 gave an upper bound of 1,362 from a **class count** and froze stage A's criterion (<= 8,588, take
1,000) from it. This section replaces "class count" with "realizable count" before a single line of the
implementation exists: **an instruction can only be deleted if, besides "deleting it needs no new
instruction", the value is still in some register at every one of its uses.** Measured against that test,
the realizable total is an order of magnitude smaller.

### 40.1 Three disqualifiers, measured one by one

| Family | S39.1 class count | Realizable | Why not (measured) |
|---|---|---|---|
| Frame accesses | 656 | about 0 (only the ones whose consumer can be retargeted) | of the 656 only **242** are direct `[r6/r7,#off]`; the other 413 go through a register holding the frame base plus an offset -- the address of a struct local has been taken, so by semantics **they must stay in memory**; of the 242 remaining, 239 belong to slots never address-taken, but promoting a slot turns each `LDR/STR` into a 1-for-1 `MOV` (no saving) unless the consumer's operand position can take that register directly |
| Moves through `r0` | 452 | **107** (loose) / **24** (every use retargetable) / **5** (walk until redefinition) | global value numbering over the CFG finds **0** value-redundant copies (the 31 block-local ones are already deleted by `-fopt-live`/`-fopt-coalesce`); what remains is "the consumer wants that specific register" -- two-operand encodings like `AND r0, r1` cannot take another register at all |
| Single-register PUSH/POP of the runtime value stack | 286 | **30** (15 pairs) | the corpus actually holds 207 such instructions; only 15 pairs have **no write to the register** between the push and the pop; the rest is the accumulator `r0` being reused in between, so the value cannot go back into a register by design |
| Re-materialising a constant into the same register | -- | **28** (19 immediate + 9 literal) | adjacent repeats inside a block are almost all already eaten by `-fopt-remat`/`-fopt-constcache` |
| **Total** | **1,394** | **about 150 (1.6%)** | i.e. at best **9,43x** on the whole corpus, not 8,226 |

The conclusion must be stated plainly: **the stage A criterion of S39.6 ("<= 8,588, take 1,000") is
unreachable; the criterion itself is withdrawn.** This is not "we did not reach it", it is "it was measured
to be impossible" -- the same root cause as S39 withdrawing 2b/2c of S37.4 and S38 withdrawing slice 2a:
**a class count is not a realizable count.** Three withdrawals, one root cause; after the third, no
criterion is frozen from a class count again.

### 40.2 Where the gap actually is: mnemonic families on the same 95 TU

Ours (best arm, 33 switches, 9,588) against armcc O2 (5,651, decoded per `FUNC`; the 5,291 of S37.2 was an
earlier sampling basis, this section uses 5,651 throughout):

| Family | Ours | armcc | Delta |
|---|---|---|---|
| `MOV`/`MVN` | 2,005 | 615 | **+1,390** |
| `LDR*` | 1,961 | 1,117 | **+844** |
| `STR*` | 965 | 576 | +389 |
| `PUSH` | 383 | 66 | **+317** |
| `POP` | 386 | 88 | **+298** |
| `ADD` | 531 | 194 | +337 |
| `AND` | 407 | 96 | +311 |
| `CMP` | 606 | 458 | +148 |
| `SUB` | 186 | 107 | +79 |
| rest | -- | -- | about +130 |

The first four sum to **+2,940 = 75% of the 3,937 total gap**. The decisive row is `PUSH`/`POP`: armcc has
66/88 in the whole corpus, essentially "prologue and epilogue only", i.e. **its expression evaluation never
builds a memory value stack**; we have 383/386, of which about 200 are the runtime value stack. This is not
"there is redundancy left in the text", it is **a different emission model**: our emitter `PUSH`es every
intermediate value to memory, `POP`s every operand back, and moves every result through `r0`; armcc keeps
those values in registers.

### 40.3 Verdict

1. **The text layer is closed here.** Of the 9,588 instructions left after the 33 text passes, only about
   150 can be removed by "allocating once more" (40.1). Stages B (instruction shapes) and C (structure) of
   S39.6 still stand in principle, but their bounds are class counts too (everything in S39.4 is < 120), and
   **their premise -- "allocator first" -- no longer exists**.
2. **The remaining 3,937 must come from the emitter changing model**, not from another pass. The lesson of
   S38.3 applies: slice 2a lost -1.683x not because it changed the model, but because it changed to a
   **degenerate version with no value numbering, no liveness, no allocation, and with all 33 text passes
   thrown away**. To win, the model must change **and** the text layer must stay.
3. The disposal of this section: **withdraw stage A of V-4′** (do not implement it) and replace this line
   with **V-5: a vreg emission path**, pre-registered in 40.4. The earlier statement that "an allocator can
   bring 9,588 down to 8,2xx" is corrected here to **that upper bound is not realizable**.

### 40.4 V-5 pre-registration: a vreg emission path (discipline frozen before implementation, criteria frozen in two steps)

**Goal**: replace "memory value stack + fixed r0/r1 operands" in expression evaluation with "virtual
registers + liveness + linear scan + spilling", while the emitted **text still runs through the existing 33
text passes** (this is the essential difference from slice 2a).

- Switch: `-fopt-vregemit`, `ARKCC_FEATURE_VREGEMIT`, off by default, tier 0 under `STM32_MIN`, rejected by
  name when compiled out (`C3900U`).
- Routing: the allowlist opens one function shape at a time; the first slice takes only **leaf integer
  functions** (no `BL` in the body, no address-taken frame, no float/complex/varargs/VLA/`__asm`);
  everything not routed stays on the old path. **The coverage of the first slice is already measured**:
  **156 of 211** functions qualify, carrying **3,908 of 9,588** instructions (41%), so the first slice is
  large enough to be measured meaningfully.
- Stages:

  | Stage | Content | Criterion |
  |---|---|---|
  | **V-5-a** | leaf integer functions: virtual registers + intra-block liveness + linear scan onto r0-r3/r12/r8-r11 (spilled when needed) | **measure first, then freeze** (below) |
  | **V-5-b** | integer functions with calls (argument/return/callee-saved boundaries) | measure first, then freeze |
  | **V-5-c** | frame slots and constant residency wired into the same allocator | measure first, then freeze |

- **Criteria are frozen in two steps (the direct answer of this section to the S39 lesson)**:
  1. build the path and **measure only**, changing no wording, claiming no number;
  2. freeze the next stage's criterion from that measured absolute count, write it down, and then run the
     judged measurement (no re-wording afterwards);
  3. until step 2 is done the "Criterion" column above stays empty -- **no relative criterion (<= old path
     x 0.80) may ever be the pass basis**.
- Common guards (carried over from S38.6/S39.6, each executable):
  1. with `-fopt-vregemit` off, the 95 TU are byte-identical to today's HEAD output;
  2. `tests/arm_exec/` gives equal per-function values on both arms with identical unicorn value/RAM
     snapshots; at least three fixtures specific to this path are added;
  3. must-reject fixtures (`__asm`, VLA, `long long`, `float`, varargs) fall back to the old path and stay
     byte-identical;
  4. when new and old coexist in one TU, line differences appear only inside routed function bodies;
  5. **any single function that comes out longer than on the old path is not routed** -- that is an
     admission rule of the allowlist, not a post-hoc choice.
- The endpoint must be on paper: V-5 aims to remove the emission model as the bottleneck, it does **not**
  promise "armcc will be beaten"; armcc's 5,651 is a reference line, not a commitment. The sentence from
  S39.6 -- "all three stages passing is still not armcc" -- holds here as well.

### 40.5 Reproduction

Out-of-repo scripts (sources of every number here, all in `D:/tmp/bm/cf/`): `proto_vn.py` (global value
numbering, 0 value-redundant copies), `proto_retarget.py` (retargetable 107/24/5 in the three strengths),
`proto_all.py`, `proto_all2.py` (combined deletions 58/36), `proto_p1.py` (value-stack pairs, 15 pairs /
30 instructions), `proto_const.py` (same-register re-materialisation, 28), `slot_prom.py` (242 direct frame
accesses, 239 never address-taken), `mnem_cmp2.py` (the family account of 40.2, both sides in one run).
The armcc side is still `armo.py` + capstone over `D:/tmp/cfB/*armcc_O2.o`.

## 41 V-5 wiring: the routing rule, the candidate census, and zero routing (2026-11-27)

S40.4 pre-registered V-5 in three steps: wire the path and measure without touching the criteria; freeze the
next slice's criteria from that measurement; only then run against them. This section is the **complete
account of step one** -- the path is compiled into the compiler but routes **no function at all**, so nothing
here claims a gain. It pins what "wired in" means and the size of the candidate surface the router sees,
which is the baseline the next slice's criteria will be frozen against.

### 41.1 What was wired

| Where | What |
|---|---|
| `include/arkcc_config.h` | `ARKCC_FEATURE_VREGEMIT`, 1 on host/cross by default, 0 for `ARKCC_PROFILE_STM32_MIN` |
| `include/config.h` | `g_config.enable_opt_vregemit`, default 0 (new features default off) |
| `src/config.c` | `-fopt-vregemit` / `-fvregemit` parsing, default, one `config_print` line |
| `src/main.c` | cropped builds refuse it by name: `Fatal error: C3900U: -fopt-vregemit is not compiled into this build` |
| `src/backend/arm/backend_arm.c` | `ark_vregemit_census()`: the routing decision and the candidate census, called after a function body is emitted and before the text passes |
| `Makefile` | a `test-vregemit` target, part of the `make test` aggregate |

**With the switch given, all 95 translation units are byte-identical to the same build without it (9,588
instructions / 354,989 bytes).** That is not "nothing is implemented yet, so of course it looks the same";
it is an invariant the gate pins. Until the emitter is connected, the switch must change not one byte, or it
would be lying about what it does.

### 41.2 The routing rule is decided on the emitted text, not guessed from the IR

The router reuses the function text the existing path has just emitted, for two reasons:

1. The coverage study (156/211, 3,908/9,588 in S40.4) counted on text. Deciding on text makes the routed set
   the same population that study measured, instead of a second guess at what an IR shape means in text.
2. The lesson of slice 2a is that swapping the model dropped the criteria. A text-side rule can make the
   choice **after both paths have emitted**, which is what makes guard 5 of S40.4 ("no function may be routed
   if it comes out longer than its old-path text") executable at all.

The rule (anything not satisfied refuses the function):

| Condition | What is checked | Why |
|---|---|---|
| leaf | no `BL` / `BLX` in the text | a call crosses an AAPCS boundary; that is V-5-b |
| integer | no VFP instruction, no `__aeabi` helper | float / soft-float / 64-bit helpers are later slices |
| no address taken | no register derived from the frame base `r6`/`r7` and then used as an offset access base | a slot whose address escapes must stay in memory (the 413 of S40.1) |
| function shape | `is_variadic`, `is_irq`, `is_naked`, `alias_target`, `is_asm_func`, or `param_count > 4` on the IR function | their prologue/epilogue and return conventions are outside the first slice |

**Why variadic has to look at the IR**: the text of `int f(int n, ...) { return n; }` is indistinguishable from
an ordinary leaf function, so a text rule cannot see it; only `is_variadic` can. This is the one place in the
section that must leave the text.

### 41.3 The candidate census (this section's measurement, the "measure without touching the criteria" step)

With `ARKCC_VREGEMIT_STATS=1` the compiler reports one line per translation unit (no emitted text changes):

```
vregemit: eligible_functions=<n> eligible_instructions=<m> functions=<t> instructions=<k>
```

Summed over the 95 units (**text as it stands before the text passes, i.e. what the router actually sees**):

| Quantity | Value |
|---|---|
| candidate functions / all functions | **137 / 212** |
| candidate instruction count / all instructions (pre-pass) | **11,782 / 35,438** |

The difference from the 156/211 and 3,908/9,588 of S40.4 has three causes, all accounted for: S40.4 counted
**after** the text passes (9,588 is the best arm's final count) while this counts **before** them (35,438 --
the pass chain itself takes 256 instructions down to 55, see the fixture in 41.5); this rule also refuses
`param_count > 4`; and it reads "base alias + `[base, #off]`" more strictly than `leaf_cov.py`, which only
recognised `[r6/r7, #k]`. All three are stricter, so the candidate surface can only be smaller.

**These two numbers are a baseline, not a criterion.** By step two of S40.4 the criteria for V-5-a are frozen
only after the emitter exists and both paths have been counted exactly, and once frozen the yardstick is not
changed.

### 41.4 The gate (`tests/run_vregemit_tests.py`, part of `make test`)

1. **OFF IS OFF**: all 95 units are byte-identical with the switch on and off, pinned at 9,588 instructions /
   354,989 bytes.
2. **The routing census**: the four numbers (137/212, 11,782/35,438), summed per unit, equal the pinned
   values. This is a **self-check**: it proves the rule in the compiler is the rule in the document, instead
   of a document that says one thing and code that does another.
3. **One shape each**: five fixtures -- a leaf integer function must be accepted, and a function with a call,
   one that takes the address of a local, one doing float arithmetic, and a variadic one must be refused.
4. **Cropped, refused by name**: a `-DARKCC_FEATURE_VREGEMIT=0` build refuses `-fopt-vregemit` (`C3900U`)
   and writes the same text as the full build when the switch is absent.

The gate deliberately does **not** yet contain guard 2 of S40.4 (per-function same values in both arms) or the
new-path fixtures: the new path emits nothing so far. Both arrive with the emitter, in step three of the
procedure, and are not recorded as met before that.

### 41.5 Reproduce

```
python tests/run_vregemit_tests.py ./arkcc.exe          # all 12 checks green
ARKCC_VREGEMIT_STATS=1 ./arkcc.exe <tu>.c -S -fopt-vregemit ...   # single-unit census
```

## 42 V-5-a2 measured and withdrawn: the straight-line leaf emitter reaches only 10 functions (2026-11-27)

**Verdict**: the straight-line leaf emitter was implemented on the S41 wiring and measured. It saves
**13 instructions / 397 bytes (0.14%)**, far below the S40.4 candidate surface (3,908 instructions). Under the
"withdraw when it does not meet the bar, code and all" rule it is **withdrawn**: the whole emitter block
(`vrg_plan` / `vrg_leaf` / `vrg_alloc` / `vrg_count_insns` / `ark_vregemit_body`, 483 lines) is gone from the
source, and only the S41 census and switch remain. The rebuilt compiler puts the 95 units back at
**9,588 instructions / 354,989 bytes**, byte-identical with the switch on and off.

### 42.1 The bar (frozen only after measuring, and not changed afterwards)

For a slice to stay in the tree its saving has to be of the order of **the cheapest slice already kept**,
`-fopt-ldhoist` at **-1.15%** (S12-1). That anchor has nothing to do with this result, and there are two
reasons for it: an emitter slice brings back a **second emission path** -- it replaces the prologue, it goes
through `pp_splice`, it has to re-prove ABI and CFI invariance, and every text pass has to be re-validated on
the new shape. That costs as much to maintain and to trust as ldhoist did, and a saving of less than one
eighth of ldhoist is not worth it. **0.14% < 1.15% => withdraw.**

### 42.2 Measurement (33-flag best arm, 95 translation units)

| Arm | Instructions | Bytes (UTF-8) |
| --- | ---: | ---: |
| switch off | 9,588 | 354,989 |
| switch on | 9,575 | 354,592 |
| **delta** | **-13 (0.14%)** | -397 |

No unit got longer. Nine functions got shorter, and all of them are empty bodies or one-statement wrappers:
`HAL_MspInit` 2->1, `HAL_MspDeInit` 2->1, `HAL_GetHalVersion` 3->2, `HAL_SYSTICK_Callback` 2->1,
`HAL_PWR_PVDCallback` 2->1, `HAL_RCC_DeInit` 3->2, `HAL_RCC_CSSCallback` 2->1,
`HAL_FLASH_EndOfOperationCallback` 4->1, `HAL_FLASH_OperationErrorCallback` 4->1.

The emitter itself was **correct**: `tests/arm_exec/run_arm_exec.py --extra=-fopt-vregemit` gives **0 failure**
on the same build, with both arms returning the same values and the same RAM snapshots. This was withdrawn
for its payoff, not for a defect.

### 42.3 Why it is so small (root cause, measured funnel)

| Gate | Functions | Rule |
| --- | ---: | --- |
| all | 212 | -- |
| text census (S41.2) | 137 | no `BL`/`BLX`, no VFP, no address-taken slot, no `__aeabi`, `param_count <= 4` |
| `vrg_plan` (straight-line IR) | **10** | no label/jump/call, exactly one `IR_RETURN` and last, ops inside the slice |
| `vrg_leaf` (frame can go) | 9 | no local ever written, all parameters in r0-r3 |
| actually spliced | 10 | one of them only in frame mode |

**The ceiling of the straight-line model is 10 of 212.** Of the 137 functions the text rule accepts, 127 have
multi-block control flow or calls and the IR rule refuses them all. That is not a bug in the rule: "re-emit the
body, but still demand a straight line" simply only covers wrappers.

The second dent happens in the pass chain: the splice happens **before** the text passes, where it saves 53
instructions; `-fopt-vstack` then takes 40 of those 53 back on the **old** text (the old path's frame and value
stack had already been compacted once by vstack, while the newly emitted text is already in compacted shape, so
vstack has nothing left to take). Net: 13.

### 42.4 Verdict

`straight_line_vreg_emission_insufficient`.

- This refutes **only** the layer "re-emit straight-line functions from IR with the value stack in registers".
  It does not refute S40's "the gap itself is the emission model".
- The value-stack model has **no budget left** on this corpus: `-fopt-vstack` already ate it (after S33 the
  body-level delta of adding `-fopt-vregemit` is 0).
- What is left lives in the **allocator** (the 1,362 instructions of S39) and in **cross-block round trips**
  (S10/S28). Both have to work on the **full CFG**; the straight-line rule cannot reach them -- 10 of 212 is
  the ceiling of straight-line emission.

### 42.5 Gate and evidence

- `tests/run_vregemit_tests.py` is still the 12 checks of S41.4 and is green after the withdrawal; check 1
  ("the switch changes no byte") holds again -- that is what a withdrawal looks like in the gate.
- The withdrawn implementation (emitter block plus the call site as it was measured, 511 lines) is archived at
  `D:/tmp/bm/v5a2_leaf_retract.patch` (not in the repository); the funnel and two-arm script is
  `D:/tmp/bm/cf/meas_vreg.py`.
- Reproduce: `ARKCC_VREGEMIT_STATS=1 ./arkcc.exe <tu>.c -S -fopt-vregemit ...` (census only, no text change).

**Next (re-ordered by measurement, not a promise)**: the allocator body of V-4 slice 2 -- liveness and register
allocation over the full CFG, aiming at the 1,362 instructions recorded in S39. The straight-line emitter stays
withdrawn.

## 43 V-4' stage A pre-registration: value-residency allocator over the CFG (2026-11-27, frozen before implementation)

S39.6 froze the three-stage criteria once. This section turns them into **implementable rules**: the routing
predicate, the value model, liveness, linear scan, constant residency, calls and ABI, the output shape, and the
five anti-false-green checks that must come with it. **The rules are frozen here and do not change afterwards**;
the measurement is written up in S43.8 (stage A is withdrawn there before implementation) and judged by S43.5.

### 43.1 Scope and criterion (from S39.6, not renegotiated)

This slice implements **stage A only**: value numbering + liveness + linear scan + constant residency, routing
every integer function. The criterion is an absolute instruction count:

| Tier | Corpus instructions | Saving | Share of the 1,362 ceiling |
| --- | ---: | ---: | ---: |
| **land** | **<= 8,588** | >= 1,000 | >= 73% |
| record | 8,589 - 8,888 | 700 - 999 | 51% - 73% |
| withdraw | > 8,888 | < 700 | < 51% |

The baseline is the same best arm as S39: **9,588 instructions** (`BASE`+`chainfold`+`pushpop`+`remat`, 95
units). A relative rule (`<= old * 0.80`) is **not** a substitute for the table; it is a process indicator only.

### 43.2 The rules (what gets implemented, one by one)

#### 43.2.1 Routing predicate (a function that fails it falls back byte for byte)

A function is routed if and only if its IR contains **none** of:

1. float/vector: `IR_PUSH_FLOAT`, `IR_FADD/FSUB/FMUL/FDIV/FCMP/F2I/I2F/F2F`, `IR_SIMD_*`;
2. 64-bit: `IR_64BINARY/64PUSH/64CMP/64F2I/64I2F/SEXT/ZEXT/CDECL64`;
3. unmodellable control: `IR_ASM` (inline asm in the body), `IR_ALLOCA` (VLA), `IR_SMC`, `IR_SVC`,
   `IR_MEMCPY` (block copies carry a loop and fixed register usage);
4. address-taking: see 43.3 item 1;
5. a variadic function (`fn->is_variadic`).

The argument count is **not** limited (more than four go on the stack, see 43.2.6). `IR_TRUNC`,
`IR_STORE_FLD`, `IR_LOAD_FLD`, `IR_DIV` and `IR_MOD` are integer shapes and are **allowed**.

#### 43.2.2 Value model and value numbering

The IR is a stack machine, so a "value" is **a slot on the abstract value stack**. Each basic block is
simulated:

- every value-producing IR operation gets a fresh **vreg** (monotonic);
- `IR_PUSH_VAR` reads a local slot: if the slot is **neither address-taken nor spilled**, the value is the
  slot's current vreg;
- `IR_STORE` writes a local slot: the slot's current vreg becomes the popped vreg;
- the abstract stack must **agree at every block entry** across all predecessors (same depth, same vreg per
  level), otherwise the function falls back to the old path (conservative; stage A does not synthesise phis
  and does not build SSA);
- `IR_DUP/IR_SWAP/IR_POP` only reshape the abstract stack and emit nothing.

A local slot that is **never spilled** costs no memory at all -- that is where the 656 frame accesses go.

#### 43.2.3 Liveness

Standard per-vreg block use/def plus iteration to a fixpoint on live-in/live-out, then RPO numbering turns each
vreg's **live interval** into a point set `[def, last_use]` (holes kept). At `IR_CALL`, values live in
`r0-r3/r12` count as live across the call.

#### 43.2.4 Linear scan and spilling

- Register pool: `r4-r11` (callee-saved, so naturally safe across calls) plus `r0-r3`, `r12` (short-lived
  values only);
- scan by interval start, free at interval end; when the pool is empty, spill the **furthest-ending** live
  value to a frame slot (Belady-style heuristic);
- spills and reloads happen **at the definition and use points only**, never as a cross-block move;
- the frame holds only **actual spill slots + stack arguments + 8-byte alignment**; no space is reserved for
  locals that live in registers.

#### 43.2.5 Constant residency

A vreg whose value is an integer constant (`IR_PUSH_INT` that one `MOV`/`MOVW` can encode) occupies **neither a
register nor a frame slot**: it is **re-materialised** at each use. This is the S39.3 finding (the money in
constants is in where the register comes from), not a new hole.

#### 43.2.6 Calls and ABI

- arguments go in `r0-r3` per AAPCS, the fifth and later on the stack; the result comes back in `r0` (when the
  return type is an integer);
- before `IR_CALL`, values that are **live across the call** and currently in `r0-r3/r12` are spilled, and
  reloaded afterwards;
- `r4-r11` are pushed once in the prologue and popped once at every exit (single-exit normalisation is stage C;
  this stage allows multiple exits, each with the same pops);
- the stack-argument area is reclaimed with `ADD sp, sp, #n` at the exit.

#### 43.2.7 Output shape

The routed function's new text replaces `[fstart, end of body)`: it emits `name:`, `.cfi_startproc`, the
prologue, the body, the epilogue at every exit, and the old path still appends `.cfi_endproc`/`.size`. Encoding
uses the wide forms the internal assembler already supports (three-operand `ADD/SUB/AND/ORR/EOR/BIC`, register
shifts `LSL/LSR/ASR`, `MUL`, `SDIV/UDIV`, all `LDR/STR` address modes). **The new text still runs through the
existing 33 text passes** (same ruler as S40.4), so the reading is comparable with every earlier section.

### 43.3 Shapes that must be refused (fall back byte for byte)

1. **Address-taken local**: an `IR_PUSH_ADDR` naming a local slot of this function (`&x`, an array decaying to
   a pointer) sends the whole function back. With aliasing present a register copy is simply not valid, and
   stage A does no alias analysis.
2. `__asm` bodies, VLA, `long long`, `float`, variadics, `memcpy` shapes, `SVC`/`SMC`.
3. The abstract stack disagreeing at a block entry (43.2.2 item 4).
4. A spill offset beyond the 4KB immediate range (impossible, but asserted).
5. `Reset_Handler` (same rule as S42: its prologue may carry `BL __arkcc_init_globals`).

### 43.4 Anti-false-green (five checks, all in `make test`)

1. **Independent oracle**: `tests/alloc_oracle.py` recomputes "removable sites in this function" from the
   **switch-off text** and matches it against the sites actually removed, function by function; drift must be
   0. Both arms (full corpus plus the `son` subset) run it.
2. **Per-site proof**: every removed site has to restate its guard on the switch-off text (value not written
   inside the interval, register not aliased, not live across a call, not inside an IT block). One unprovable
   site fails the check.
3. **Five must-refuse fixtures** (`__asm`, VLA, `long long`, `float`, variadic): byte-identical across arms.
4. **At least eight must-accept fixtures** (loop, recursion, call, switch, multiple exits, stack arguments,
   bitfield, do-while): same return values in both arms, and the same RAM snapshot after `unicorn` executes
   them.
5. **Routing census self-check**: the per-TU routed-function count must equal the frozen number (208 of 211
   integer functions on the corpus), otherwise the gate fails. This is what guards against "the document says
   208 functions are routed while the code routes 20".

### 43.5 Three tiers and four things that are not allowed

The tier is decided by the absolute counts of 43.1 alone: `<= 8,588` lands, `8,589-8,888` is recorded, `>
8,888` is withdrawn.

1. A relative criterion (`<= old * 0.80`) may **not** replace the absolute count;
2. the corpus, the default switch value, or "count unrouted functions as optimised" may **not** be changed to
   pass;
3. "what is removed is redundant" may **not** be claimed without the per-site proof of 43.4 item 2;
4. stage A meeting its bar may **not** be described as "close to armcc" (the end point is still 7,388 against
   5,291, see S39.6).

### 43.6 Reproduce and evidence

- switch: `-fopt-alloc` (`ARKCC_FEATURE_OPT_ALLOC`, host 1 / board 0, off by default; cropped builds refuse it
  by name with `C3900U`);
- census: `ARKCC_ALLOC_STATS=1` prints the routed function count, removed sites and net saving per unit;
- scripts: `D:/tmp/bm/cf/meas_alloc.py` (two arms, per unit), gate `tests/run_alloc_tests.py`.

### 43.7 Known risk (the bad news, up front)

S39.2 already recorded it: a real allocator's first landing usually realises 50%-70% (register pressure, calls,
spill-slot revisits each take a bite), i.e. 680-950 instructions -- **most likely the record tier, possibly the
withdraw tier**. If the reading comes out that way, S43.5 decides the tier as it stands: no polishing, no
re-freezing the criteria afterwards.

### 43.8 Routing census readings and the verdict (2026-11-27, stage A withdrawn before implementation)

Check 5 of 43.4 requires the gate to pin "routed functions per TU". Pinning it means the census has to
exist first, so this slice implements a **read-only** routing census: with `-fopt-alloc` on, every
function is run through the 43.2.1 predicate and the 43.2.2 abstract-stack model, **without emitting any
new text** (the off arm and the on arm stay byte-identical), printing counters only under
`ARKCC_ALLOC_STATS=1`. Reviewing the 43.1 criterion against those readings gives the conclusion:
**the projection is refuted by measurement, and stage A is withdrawn before a single line of emitter
code is written.**

#### 43.8.1 Census readings (95 TUs, same ruler)

| Quantity | Measured |
| --- | ---: |
| Functions, total | 212 |
| Functions routed | **167** (79%) |
| IR instructions, total | 17,116 |
| IR instructions inside routed functions | **6,064** (35%) |
| Call sites inside routed functions | 47 |
| Routed functions that use stack arguments | 1 |
| Routed functions with a back edge | 10 |
| Baseline instruction count (§39 best arm) | 9,588 |

Source: the `alloc: eligible_functions=... eligible_ir=... functions=... ir=... call=... stackarg=...
loop=...` lines, aggregated by `D:/tmp/bm/cf/meas_alloc.py`; the gate `tests/run_alloc_tests.py` pins all
seven numbers (212 / 9588 / 354989 bytes / 17116 / 167 / 6064 / 47 / 1 / 10).

#### 43.8.2 The 45 refusals, decomposed

212 - 167 = 45. By reason (from the `alc-reject` lines under `ARKCC_ALLOC_DEBUG=1`):

| Reason | Functions |
| --- | ---: |
| Function-level flags (all 17 are `irq` service routines) | 17 |
| Block-entry abstract-stack shape mismatch (join, needs phi) | 21 |
| Took a local address, `IR_PUSH_ADDR` (43.3 rule 1) | 3 |
| 64-bit `PUSH_VAR` (width >= 8) | 3 |
| 64-bit `BINARY` (`IR_64BINARY`) | 1 |
| Total | **45** |

The most representative join refusal is `NVIC_EncodePriority`: a conditional expression leaves one value
on each arm at the merge point, and a real allocator has to insert a phi (or a `MOV` at the merge) - both
outside stage A's model of "one slot = one register, merge points only compare shapes". The model is not
implemented wrongly; it simply does not cover branches that merge with values on the stack.

#### 43.8.3 Correction: the 208 in 43.4 check 5 was a projection; measurement says 167

When 43.4 check 5 was frozen it said "208/211 integer functions corpus-wide". Both halves are corrected
by measurement:

- the function total is **212** (not 211);
- the routed count is **167** (not 208), 41 fewer.

Per 43.5 discipline, **the criterion (the absolute counts of 43.1) is untouched; only our knowledge of the
routable surface is corrected**. Check 5 goes from pinning the projected number to pinning the measured
167/6,064 (the gate script's docstring records this correction). This correction is itself the worked
example of "a pre-registered projection may be refuted by measurement, but the criterion may not move".

#### 43.8.4 Deletable-site ceiling: 565 / 1,394

Using the same ruler as §39 (byte-agnostic deletable sites in the corpus), counted per function on the
**off-arm text**:

| Scope | Deletable sites |
| --- | ---: |
| Whole corpus | **1,394** |
| Inside routed functions (ceiling, 167 functions) | **565** (40.5%) |

Where the other 829 sites live, by refusal reason (`D:/tmp/bm/cf/alloc_reason_ceiling.py`):

| Owner | Deletable sites |
| --- | ---: |
| The 21 join functions | 583 |
| The 17 `irq` functions | 132 |
| The 3 `IR_PUSH_ADDR` functions | 54 |
| The 3 64-bit `PUSH_VAR` functions | 30 |
| The 1 64-bit `BINARY` function | 22 |
| Unclassified (leaf / constant-housekeeping) | 8 |

**Even with stage A at 100% (not one site missed), the best possible is 9,588 - 565 = 9,023
instructions**, still above the 8,888 withdrawal line. Adding phi support would raise the ceiling to
565 + 583 = 1,148 sites; at the 50%-70% realisation rate of §39.2 that is 574-804 instructions, an
optimistic 8,784 - **just enough to touch the bottom of the registry tier**, and phi support is a bigger
job than stage A itself.

#### 43.8.5 Verdict and tier

Verdict: **`stage_a_routing_ceiling_below_landing_line`**.

Judged by the absolute counts of 43.1: stage A's reachable band is 9,023-9,588, **entirely inside the
withdrawal tier (> 8,888)**. Therefore **the stage A emitter proper is not implemented**; only this
read-only census is kept, as a gate and as the measuring stick for later stages.

The four prohibitions of 43.5, checked one by one:

1. no switch to a relative criterion - the tier was decided on the absolute counts of 43.1;
2. no corpus change, no default change (`-fopt-alloc` stays off by default), no unrouted function counted
   as optimised;
3. no claim that "what was deleted was redundant" - nothing was deleted in this slice;
4. no intermediate reading described as "close to armcc" (the end point is still 7,388 vs 5,291).

#### 43.8.6 Evidence and reproduce

- With `-fopt-alloc` on, both arms are byte-identical (95 TUs, `tests/run_alloc_tests.py` check 1);
- the six-number self-check `0 < eligible < total` (check 2) blocks "docs say 167, code routes 20";
- five must-refuse fixtures and nine must-accept fixtures each verified (checks 3 and 4);
- the cropped build (`ARKCC_PROFILE_STM32_MIN`) refuses `C3900U` by name, and without the switch its text
  equals the full build's (check 5);
- ceiling scripts: `D:/tmp/bm/cf/alloc_ceiling2.py`, `alloc_reason_ceiling.py` (outside the repo; their
  output is the two tables of 43.8.4);
- the crop matrix (`ARKCC_FEATURE_VREGEMIT` x `ARKCC_FEATURE_OPT_ALLOC`, all four combinations) compiles
  (check 6). This one was added after the fact: the census block first landed inside the
  `#if ARKCC_FEATURE_VREGEMIT` guard, so cropping VREGEMIT but keeping OPT_ALLOC left its call sites
  calling functions that did not exist -- a combination nothing had ever built, so nothing caught it. The
  block now sits outside the VREGEMIT guard, and a `-fsyntax-only` build of all four combinations is
  pinned in `make test`.

#### 43.8.7 Next step (43.1 is not reopened)

The 583 sites concentrated in the 21 join functions are the most realistic target ahead, but they need phi
or a merge-point `MOV`, which belongs to the **text layer or to stages B/C**, not to stage A. The
follow-on entry points are:

- stage B (three-address emission + shifted operands + `UBFX/BIC` + compare-immediate, cumulative <= 7,888);
- stage C (single exit + switch lowering + jump density, cumulative <= 7,388).

The 43.1 criterion is not changed and not reopened; this withdrawal is simply the cheaper way of refuting
it - before implementation instead of after.

## 44 Pricing the joins: the final reading of the allocator path, and closing it (2026-11-27, measured before implementation)

**Conclusion**: re-run the same walk over the 21 functions that section 43.8 had to refuse for
"join shape mismatch", but now doing what a real allocator does - insert a `MOV` at the reconciling
point. The routed surface goes from 167 to **188/212**, the removable sites from 565 to
**1,148/1,394** (exactly 565 + 583 from 43.8.4), and what reconciliation costs is **399 `MOV`s**
(measured, not estimated). Net ceiling **749** => corpus total **8,839**.

Against the 43.1 tiers: landed <= 8,588 (needs 1,000), registered 8,589-8,888 (700-999),
withdrawn > 8,888 (< 700). 749 only reaches the **registered tier** (55% of 1,362), and even that is
the optimistic end - 100% realisation, not one reconciliation `MOV` removed. Stack that on the
structural fact measured in section 38.3 (a second emission path starting from zero loses by 1.683x)
and 43.5 decides it: **the stage A emitter is still not implemented** - this time it is closed
*after* the joins have been priced, not for lack of measuring.

### 44.1 Reading (95 TUs, the same best arm at 9,588 instructions)

| quantity | strict model (43.8) | join reconciliation (this section) |
| --- | ---: | ---: |
| routed functions | 167 / 212 | **188 / 212** |
| removable sites inside routed functions (39.1 counting) | 565 / 1,394 | **1,148 / 1,394** |
| reconciliation actions | - | **399 `MOV`s** |
| net ceiling | 565 | **749** |
| best-arm instruction count | 9,588 | 9,588 - 749 = **8,839** |

Where the reconciliation cost concentrates (top four): `HAL_DMAEx_MultiBufferStart_IT` 258,
`HAL_RCC_OscConfig` 63, `HAL_RCCEx_PeriphCLKConfig` 15, `HAL_RCC_ClockConfig` 13 - 349 of 399.

### 44.2 Register pressure is not the bottleneck (a side benefit)

The same walk records the peak number of simultaneously live abstract values per function: the corpus
maximum is **5**, and **179 of the 188** routed functions peak at **<= 4**. The eight usable registers
`r4`-`r11` are therefore far from exhausted - **spill slots are not the limit**. The limits are the
**join shape reconciliation** (399) and **calls** (47 routed functions contain a call site). This
kills half of the guess in 39.2 that register pressure would eat part of the win.

### 44.3 Tier and verdict

Verdict: **`allocator_net_ceiling_inside_registered_tier`**.

- The ceiling **8,839** sits in the registered tier (8,589-8,888), and on the optimistic end;
- At the 50%-70% realisation rate of 39.2: 749 x 0.5...0.7 = **375...524** => **9,064...9,213**, which
  is the **withdrawn** tier;
- The landed tier (<= 8,588) needs 1,000, which is **above this section's measured ceiling of 749** -
  unreachable even with every reconciliation `MOV` removed.

=> the stage A emitter is **not implemented**. `-fopt-alloc` keeps doing the read-only census only;
the three new census quantities (`routable_join` / `join_moves` / `peak_max`) are pinned by check 2b
of `tests/run_alloc_tests.py` (**188 / 399 / 5**), and hold together with the strict values of check 2
(167 / 6,064 / 212 / 17,116) - the two models must be two questions asked of one walk, not two pieces
of code each telling its own story.

### 44.4 The ledger after this road is walked

At this point every **instruction-removal** margin has been measured to the end and closed:

| margin | measured upper bound | where |
| --- | ---: | --- |
| text layer, per shape | about 150 (no single family >= 120) | 39.4 |
| constant residency (4 dedicated registers) | 69-96 | 39.3 |
| allocator (with join reconciliation) | **749** (optimistic 1,148) | this section |
| stage B/C (7,888 / 7,388) | they start at stage A, which is closed | 43.1 / 43.8.7 |

Section 38.3 also gave the structural evidence: a second emission path starting from zero loses by
**1.683x**, because today's text layer (`constcache` / `slotreg` / `vreg` / `copyprop` / `addrfold`)
already does the +1,026 / +466 / +609 / +100 instructions of work. **Any slice that treats "re-emit"
as the answer must first move those equivalents across, or it loses by construction.**

Conclusion (recorded, to be cited by every later slice): **on this corpus and this architecture,
"beat armcc" is unreachable.** Every measurable margin sums to roughly 750-900 instructions, landing
at **8,700-8,850**, i.e. **1.64-1.67x** armcc's 5,291. To genuinely approach armcc the emission model
itself has to be replaced (expression / three-address IR + global register allocation + instruction
selection); that is a separate engineering effort and cannot be passed off as one more text pass.

### 44.5 Three candidates for what comes next (registered, not promised)

1. **In-place isel (keeping the emission model)**: teach the existing emitter to emit the
   "temp -> three-address" shapes directly - three-address 51, `BIC` 30, shifted operands 26,
   redundant narrow-load extension 23, single-bit 27, about **157 instructions (1.6%)**; no text pass
   is touched, so the 38.3 penalty does not apply. This is the **only** margin still inside the
   architecture that also has a measured upper bound.
2. **IR upgrade** (expression trees + vregs + global allocation + isel): the only road that can take
   1.8x down to the 1.2x order; weeks of work, and it needs its own pre-registration and upper bound
   first.
3. **Stop optimising density**: make crt/startup/HAL run end to end on the H743 and make "really
   usable" real.

The three-tier criterion of 44.1 is not changed; this section only uses measurement to close stage A.

### 44.6 Reproduce

- Census: `ARKCC_ALLOC_STATS=1` (new fields `routable_join` / `join_moves` / `peak_max`);
  per function via `ARKCC_ALLOC_NAMES=1` (`alloc-route` / `alloc-route2 <name> peak=<n> jmoves=<m>`);
- Aggregation and site join: `D:/tmp/bm/cf/meas_join.py` (bucket by `peak <= K`, subtract `jmoves`
  from the site count to get the net);
- Gate: `python tests/run_alloc_tests.py ./arkcc.exe` (34 checks).

## 45 Emission model v2 pre-registration: value-centric emission (V-6), five stages with absolute criteria (2026-11-27, frozen before implementation)

**Why a new model at all**: section 44 measured the ceiling of "keep the emission model" at 750-900
instructions, while armcc reads 5,651 on the same corpus (decoded per `FUNC` over the same 96
`*armcc_O2.o`, the basis fixed in 40.2; the 5,291 of 37.2 was an earlier sampling basis). The gap of
**3,937 instructions** has to be explained structurally, not by one more text pass. Section 40.2 gave a
coarse family-level attribution once; this section splits each family into its immediate and
register forms (otherwise `add #imm` and `add r,r,r` collapse into one family and the cause disappears),
adds a per-function breakdown (45.2), and freezes the criterion on that basis - **measure first, freeze
after, never renegotiate**.

### 45.1 Where the gap comes from (95 TUs, our best arm 9,588 / armcc `-O2` 5,651)

| class | ours | armcc | excess |
| --- | ---: | ---: | ---: |
| `mov` register copy (`mov rd,rm`) | 2,005 | 219 | **+1,786** |
| stack frame (`push`/`pop`) | 769 | 154 | **+615** |
| literal-pool load (`ldr lit`) | 766 | 392 | +374 |
| `add` immediate | 512 | 181 | +331 |
| `ldr` memory | 991 | 719 | +272 |
| `str` to stack | 249 | 40 | +209 |
| `ldr` from stack | 204 | 6 | +198 |
| `str` memory | 716 | 536 | +180 |
| `and` register | 182 | 20 | +162 |
| `and` immediate | 225 | 76 | +149 |
| `cmp`/`tst` | 606 | 479 | +127 |
| narrow extension (`uxtb`/`sxtb`...) | 81 | 6 | +75 |
| `sub` immediate | 147 | 72 | +75 |
| `bl` | 182 | 152 | +30 |
| `orr` immediate / register | 199 | 178 | +21 |
| `add`/`sub` register | 58 | 48 | +10 |
| shifts | 212 | 238 | -26 |
| branches | 1,205 | 1,234 | -29 |
| other | 279 | 509 | -230 |
| `mov` immediate | 0 | 392 | -392 |
| **total** | **9,588** | **5,651** | **+3,937** |

Positive excess sums to **4,614**, negative to -677, net 3,937. Reading it:

- **Register copies alone are 45% of the net gap** (1,786 / 3,937). This is not "one pass short": the
  values have no names. Every expression walks a temporary slot and the slot then moves into the
  destination register. armcc's 219 are the genuinely necessary ones (calling convention, returns).
- **Copies plus stack traffic are 2,808 = 71%** (1,786 + 615 + 209 + 198). Seven tenths of the gap is
  "where a value lives", not instruction selection.
- The two classes where we are *better* confirm the architectural difference: `mov` immediate 0 against
  392 (we go through the literal pool), 29 fewer branches, 230 fewer "other". So the gap is not simply
  "we pick worse instructions" - it is how addresses, constants and short-lived values are represented.

### 45.2 Which functions the gap lives in (same `.s`, split on function labels)

| routed | loop | call | functions | insns | `mov` copies | frame | literal loads |
| --- | --- | --- | ---: | ---: | ---: | ---: | ---: |
| yes | yes | yes | 19 | 3,011 | 818 | 215 | 0 |
| yes | yes | no | 5 | 522 | 139 | 14 | 0 |
| yes | no | yes | 32 | 2,007 | 295 | 117 | 0 |
| yes | no | no | **130** | 2,746 | 417 | 282 | 0 |
| no | yes | yes | 1 | 421 | 58 | 69 | 0 |
| no | yes | no | 6 | 19 | 0 | 12 | 0 |
| no | no | yes | 10 | 690 | 213 | 30 | 0 |
| no | no | no | 8 | 90 | 28 | 20 | 0 |

Reading: **87% of instructions (8,311 / 9,588) and 83% of `mov` copies (1,672 / 2,005) live inside the
186 routed functions**. The 25 unrouted functions hold only 1,277 instructions; keeping them all costs
13%. So the first step of the new model is not "rewrite the corpus", it is **take the 186 routed
functions and fall back byte for byte for the rest** - the same fall-back discipline as 43.3.

### 45.3 Criterion: five stages, absolute counts, one independent gate each (frozen, not renegotiable)

Every stage's criterion is **one sentence**: same 95 TUs, same flag set (`H.BASE` + `-fopt-chainfold
-fopt-pushpop -fopt-remat`), same counting basis, corpus instruction total **<= that stage's ceiling**,
and `arm_exec` agreeing per function across both arms. Stages **stack**: withdrawing one never disturbs
the ones already landed.

| stage | takes over | corpus ceiling | must remove | vs 9,588 | basis (measured pool) |
| --- | --- | ---: | ---: | ---: | --- |
| S45-a | routed and loop-free and call-free (130 functions) | **<= 9,150** | 438 | -4.6% | copies 417 + frame 282 = 699, take 63% |
| S45-b | + routed, loop-free, with calls (32 functions) | **<= 8,950** | 638 | -6.7% | pool 1,111, take 57% |
| S45-c | + routed with loops (24 functions) | **<= 8,550** | 1,038 | -10.8% | pool 2,300, take 45% (399 join moves are paid) |
| S45-d | in-place isel: three-address / shifted operands / `BIC` / narrow load / single-bit | **<= 8,150** | 1,438 | -15.0% | isel 157 + `and` 311 + `extend` 75 = 543, take 74% |
| S45-e | constants and addresses: literal pool / `add #imm` / memory folding | **<= 7,550** | 2,038 | -21.3% | constant/address pool 1,232, take 49% |

Each stage also freezes **two side conditions** (fail either and the stage is withdrawn, the ceiling is
not moved):

1. **No semantic trade for instruction count**: `arm_exec` must agree on return values and memory
   images per function across arms; new fixtures must cover every shape the stage takes over (at least
   leaf arithmetic, a call, recursion, `switch`, several exits, a bitfield, a five-argument call,
   `do-while`).
2. **No silently swallowed function**: the emitter must report "took n / fell back m", and n + m must
   equal the 186 of the routing census. Any failure mid-function falls the **whole** function back to
   the existing text path (byte for byte), never half-emitted.

**This section does not claim armcc parity.** All five stages landed is 7,550, still 1.34x armcc. Stage 6
(cross-call global allocation + ABI specialisation: amortise the save/restore cost of the 182 `bl`s and
turn >4-argument stack traffic into a register window) is registered only as a candidate and must be
re-measured after S45-e; no estimate is frozen now.

### 45.4 The model (what gets built, one line each)

1. **Values have names**: one vreg per SSA value; temporary slots no longer appear on the emission path.
2. **Liveness**: backward liveness over the CFG; a vreg's live range is definition -> last use; joins
   are **reconciled and charged** as in 44.2, and the reconciling `MOV`s go into the budget.
3. **Linear scan**: `r4`-`r11` are allocatable (`r0`-`r3` reserved for calls and arguments); only spills
   go to the stack. The measured corpus peak of simultaneously live values is <= 5 (44.2), so most
   functions should have **no** stack temporaries at all.
4. **Instruction selection table**: emit shapes by `(op, operand kinds)` - register, immediate, shifted
   operand, `[base, index, lsl #k]` addressing, `uxtb`/`sxth` narrowing, `ubfx`/`bfi` bitfields,
   `cmp #imm`, `cbz/cbnz`.
5. **Frame**: slots only for genuinely spilled vregs and callee-saved registers that must be preserved;
   `push`/`pop` in one register-list instruction.
6. **Constants**: `mov`/`movw`/`movt` when the value fits, otherwise the literal pool with **load once,
   use many times across blocks**.
7. **Fall back**: if any rule misses, or the function has a shape listed in 45.5, fall the **whole**
   function back to the existing text path.

### 45.5 Shapes that must be refused (byte-for-byte fall-back, never attempted)

`inline __asm`, VLAs, `long long`, floating point, variadic functions, functions with `>4` parameters,
`setjmp/longjmp`, and indirect calls whose argument count cannot be determined statically. The criterion
is 43.3's: refused shapes must be **byte-identical** in both arms, and refusals must be visible in the
census (silence is a bug).

### 45.6 Five anti-false-green checks (in `make test`, none optional)

1. **OFF IS OFF**: the switch is off by default; while off, the 95 TUs are **byte-identical** to
   today's output (reuse the 43.8 whole-corpus comparison).
2. **Per-shape must-take / must-refuse fixtures**: one fixture per shape; must-take shapes really get
   taken (the `route` line count is 1), must-refuse shapes really fall back (= 0), and both arms are
   byte-identical.
3. **Take-over count is conserved**: `taken + fell back = 186`, summed per TU and equal to the census;
   "emission failed but was not accounted" is a red light.
4. **Semantic double-run**: `arm_exec` runs every fixture and the corpus on `{off, on}`, with identical
   return values and memory images.
5. **Cropped**: a `-DARKCC_FEATURE_EMIT2=0` build refuses the switch by name (C3900U) and writes
   byte-identical text without it; all four `VREGEMIT x OPT_ALLOC x EMIT2` combinations must compile
   (the 43.4 lesson).

### 45.7 Known risk, stated up front (do not rediscover it after failing)

Section 38.3 measured it: **a second emission path starting from zero loses by 1.683x**, because today's
text layer already does the +1,026 / +466 / +609 / +100 instruction-equivalents of work. The answer is
not "be smarter than the text layer", it is that two things hold at once:

- after the new emitter takes a function, **the existing text passes still run on its output**
  (`constcache` / `slotreg` / `copyprop` / `addrfold` / `peephole` are text-level and
  source-agnostic), so those 2,201 equivalents need **not** be moved and are not lost;
- the ceilings in 45.3 are derived from the **measured excess over armcc**, not over ourselves, so
  "moving the work across" can never be counted as a win.

If S45-a lands with `arm_exec` green but the count going *up*, that is a **model failure**, not a
"tune it a bit more": withdraw per 45.3 and write the reason into section 46, exactly as section 42 did.

### 45.8 Reproduce

- Attribution table: `D:/tmp/bm/cf/gap45.py` (ours classified from GNU text, armcc classified by
  disassembling `D:/tmp/cfB/*armcc_O2.o`, same class definitions);
- Bucket table: `D:/tmp/bm/cf/gap45c.py` (split on function labels; loop = a backward branch that hits a
  label inside the same function, call = a `bl` appears);
- The older `mnem_cmp.py` still works but has coarser families; 45.1 is the authority;
- IR dump: `ARKCC_DUMP_IR=1` (host profiles; prints `irfunc <name> params=...` plus each IR
  instruction's `op/val/aux/line` to stderr, **not one byte of the product**, gated by check 7 of
  `tests/run_alloc_tests.py`); the paper-emission planner lives outside the repo at
  `D:/tmp/bm/cf/paper45.py`.

## 46 Paper emission, first pass: a planner that does not model the text layer gives the wrong answer (2026-11-27)

**What was built**: so that S45-a can be decided before an emitter exists, the compiler grew a
read-only IR dump (`ARKCC_DUMP_IR=1`, host profiles; prints `irfunc <name> params=... locals=...`
plus each instruction's `op/val/aux/line/name` to stderr, not one byte of the product, gated by check 7
of `tests/run_alloc_tests.py`), and a paper-emission planner lives outside the repo
(`D:/tmp/bm/cf/paper45.py`, `paper45b.py`): it prices every IR instruction under the V-6 value model and
compares the plan with today's measured count per function.

**Readings** (same 95 TUs, same best arm at 9,588):

| version | modelled functions | measured | planned | delta |
| --- | ---: | ---: | ---: | ---: |
| v1 (each IR instruction priced on its own, every local slot gets a slot) | 55 | 920 | 1,074 | **+154** |
| v2 (dead stores cost zero, no frame unless needed, params free in `r0`-`r3`) | 75 | 1,242 | 1,440 | **+198** |

Both are **worse** than today. Small functions improve clearly (`HAL_NVIC_GetPriority` -12,
`HAL_Delay` -8, `HAL_GetTick` -2); large ones get clearly worse (`DMA_CheckFifoParam` +52,
`HAL_RCC_GetSysClockFreq` +32) because the planner charges 2 for every address constant, 2 for every
conditional branch and 1 for every `RETURN`, while **today's emitter plus text passes already fold
those away** (`constcache` / `slotreg` / `copyprop` / `addrfold` / `peephole`).

**Conclusion (recorded)**: 45.7 is re-verified on paper - **a paper plan that does not model the text
layer's equivalents must answer "the new model is worse"**, which is 38.3's 1.683x reproduced inside the
planner. Therefore:

- S45-a is **not started**: until the planner can produce a credible estimate that charges the text
  layer's wins, the ceiling (<= 9,150) is neither shown reachable nor shown unreachable;
- the next step is not "tune the constants until it looks better" but to **make the planner price
  "emit, then run the existing passes"**: first tag, per shape, how much today's passes already fold
  (39.4's per-shape basis), then take the net;
- if that still yields no win, S45-a is withdrawn before implementation per 45.3 and the result is
  merged into 45 - **"the model sounds right" is not a reason to write the emitter.**

**This section claims no win**: the five tiers of 45 are unchanged; the section records only that the
judging instrument is not yet good enough.
## 47 Auditing S45-a's basis column: 417 is not "copies", and 438 is still enough (2026-11-27, basis corrected before implementation, criterion untouched)

45.3 justified S45-a with "that bucket has 417 copies + 282 stack = 699, take 63%". This section prices
those three numbers down to individual instructions. The result: **the ceiling of 9,150 and the 438
deletions stay as frozen, but the basis column is wrong** - 268 of the 417 are immediate materialisations
(armcc emits 392 `mov`-immediates on the same corpus, so they are not deletable at all), and the 282
counts `push`/`pop` only, without `SUB sp` / `MOV rX, sp` / `ADD sp`.

### 47.1 Class decomposition of the 130 functions (routed, no back edge, no call)

Same best-arm `.s`, 2,746 instructions, same class definitions as 45.1 (`D:/tmp/bm/cf/s47i.py`):

| class | count | class | count |
| --- | ---: | --- | ---: |
| `ldr` from memory | 505 | `str` to memory | 265 |
| stack frame (`push`/`pop`) | 282 | `mov`-imm + `movw/movt` | 268 |
| branch | 218 | `mov` register | **149** |
| `add #imm` | 186 | `str` to stack | 138 |
| `ldr` from stack | 114 | `and #imm` / `and reg` | 91 / 55 |
| `cmp` | 91 | shift | 84 |
| `sub #imm` | 78 | `orr` (imm/reg) | 40 / 40 |
| narrow `uxt/sxt` | 30 | the rest | 97 |

### 47.2 What the "417 copies" really are: 149 copies and 268 immediates

Split by operand shape (`D:/tmp/bm/cf/s47d.py`):

| shape | count |
| --- | ---: |
| `mov` immediate (`MOV rN, #k`) | 189 |
| `movw`/`movt` immediate | 79 |
| copy `lo <- lo` (between `r0`-`r7`) | 89 |
| copy `hi <- lo` | 44 |
| copy `lo <- hi` | 13 |
| copy `hi <- hi` | 3 |
| **total** | **417** |

The 268 immediate loads are constant materialisation; a value model still has to emit them (armcc spends
392 `mov`-immediates on the same job), so they are **not deletable**. Only 149 are real copies.

### 47.3 Measured deletable subsets: the text layer can delete 253, the rest needs the allocator

Four shapes, each measured on the same `.s` by dataflow or by offset, never estimated:

| shape | measured (this bucket / whole corpus) | script |
| --- | --- | --- |
| duplicate literal-pool load, intra-block | 2 / 9 | `s47f2.py` |
| duplicate literal-pool load, cross-block and safely deletable (predecessor intersection non-empty) | 40 / 57 | `s47g2.py` |
| whole frame deletable (no stack access, no call) | 160 / 194 | `s47c.py`, `s47e.py` |
| whole frame deletable **and** body stays in `r0`-`r3` (no callee-saved use) | - / **70** (29 functions) | `s47h.py` |
| adjacent copy (`MOV rX, rY` right after `rY`'s definition) | 29 / 126 | `s47b.py`, `s47e.py` |
| `str` + `ldr` on the stack (removable by keeping values in registers) | **252** / 453 | `s47i.py` |

Three readings:

1. **Text-layer deletion cannot deliver 438**: 57 + 70 + 126 = **253** (corpus-wide; inside this bucket 2 + 160 + 29 = 191); adding frame shrinking (54
   functions must keep a frame for callee-saved registers, at most 1-2 each) reaches just over 300.
2. **The pool itself does hold 438**: stack traffic 252 + frame 437 + copies 149 = **838**, and 438 is
   only 52% of it - the same order as 45.3's frozen 63%, but **built from different parts**. Those 438
   must be delivered by value residency (keeping temporaries in registers), not by deleting shapes.
3. **An independent check that 438 sits inside the headroom**: on the 112 functions that can be matched
   by name on the armcc side, armcc is 1,348 instructions and we are 2,351 - a gap of **1,003**; 52% of
   838 sits inside 1,003.

### 47.4 Verdict

**`stage_a_basis_corrected_target_still_reachable`** (basis rewritten by measurement, ceiling and target
unchanged).

- The criterion (<= 9,150, 438 deletions) is untouched; the five-tier table of 45.3 stays frozen;
- the basis column changes from "417 copies + 282 stack = 699" to "stack traffic 252 + frame 437 +
  copies 149 = 838, take 52%";
- S45-a's **implementation route is fixed** to a value-residency allocator (frame, stack temporaries and
  copies removed together), not to deleting shapes in the text layer; the 253 text-layer instructions
  cannot reach 9,150 even if all are taken;
- three prohibitions: never count the 268 immediate loads as deletable, never pad the pool with
  "the text layer could do it too", never raise the ceiling mid-implementation.

### 47.5 Next step (the first real number for this bucket)

The two largest parts of the 838 are stack traffic 252 and frame 437, and both depend on which stack
slots are stack-machine temporaries and which are real locals. On the IR this question has a definite
answer: a slot written by `IR_PUSH_VAR` / `IR_STORE` and never read again (or read only inside the same
expression) is a temporary; a slot that ever appears in `IR_PUSH_ADDR`, or that holds an array or a
struct, is a real local. 43.8's admission rules already excluded the three functions with `IR_PUSH_ADDR`,
so the temporary share inside this bucket should be high. The next step measures that share with a
read-only census (one more column under `ARKCC_ALLOC_STATS`) before deciding what the allocator's first
slice takes over.

### 47.6 Reproduction

- class decomposition: `D:/tmp/bm/cf/s47i.py` (four buckets x 20 classes; this bucket sums to 2,746, as in 45.2);
- `mov` shape split: `D:/tmp/bm/cf/s47d.py`;
- cross-block literal CSE: `D:/tmp/bm/cf/s47g.py` (forward must-analysis, `IN[b] = intersection of OUT[pred]`, converges in 5 iterations);
- whole-frame deletability: `D:/tmp/bm/cf/s47c.py`, `s47e.py`, `s47h.py` (the last one separates the
  functions whose body uses `r4`-`r11`, because their frame cannot be removed entirely);
- per-function armcc counts: `capstone` over `D:/tmp/cfB/*armcc_O2.o`, same convention as `gap45.py`.
## 48 The slot census: what is left in the frame, and what a single block can take (2026-11-27)

47.5 asked for the share of stack-machine temporaries before the allocator's first slice is chosen.
This slice adds a **read-only** slot census inside the `-fopt-alloc` block (emits nothing, changes no
byte, prints only under `ARKCC_ALLOC_STATS=1`) and corrects one counting convention from 47.3 on the way.

### 48.1 Readings (95 TUs, 212 functions)

| quantity | measured |
| --- | ---: |
| frame slots (distinct byte offsets touched by `IR_PUSH_VAR` / `IR_STORE`) | **354** |
| slot operations (one `IR_STORE` definition or one `IR_PUSH_VAR` read each) | **1,711** |
| single-block promotable slots (not address-taken, width <= 4, defined and read, every touch in one block) | **39** |
| operations on those slots | **120** (**7.0%** of the slot operations) |

The admission rules live in the `g_sl_*` comment in `backend_arm.c`: address-taken slots (`IR_PUSH_ADDR`),
eight-byte-and-wider slots, write-only slots and cross-block slots are not promotable. **The census does
not predict a win; it pins the size.**

### 48.2 Correction to 47.3: frame accesses must count the `r6` alias

47.3 counted "`str`/`ldr` on the stack" by `[sp`, which misses a shape this backend uses everywhere: after
the prologue's `MOV r6, sp`, every frame access is written `[r6, #off]`. Recounted through the alias
(`D:/tmp/bm/cf/s48b.py`, `s47j.py`):

| scope | `[sp` convention (47.3) | with the `r6` alias (this section) |
| --- | ---: | ---: |
| this bucket (130 functions) | 252 | **283** (`str` 150 + `ldr` 133) |
| whole corpus | 453 | **643** (`str` 366 + `ldr` 277) |

The pool changes accordingly: **283 + frame 437 + copies 149 = 869**, and 438 is **50%** of it (47.3 said
838 / 52%). The ceiling of 9,150 and the 438 deletions are unchanged; only the measured basis moves.

### 48.3 Reading: the stack machine's temporaries are two thirds of the story, and the rest is folded

The 1,711 slot operations reach the assembly as only 643 real frame accesses - **62% are already removed
at emission time by "keep the value in `r0`" (`ark_top_try`) and by the text passes (`slotreg` / `vstack` /
`copyprop`)**. That reading matters: the intuition "the IR is a stack machine, so every temporary crosses
memory" is simply false; most of that cost is already banked.
2. Of the remaining 643, only **120** are safely promotable inside one block (1.25% of the corpus). Against
45.3's 438, a single-block slice **cannot stand alone**; it needs CFG liveness.

### 48.4 Verdict

**`slot_promotion_single_block_below_slice_threshold`** (single-block promotion is below the slice threshold).

- single-block promotion is not a slice of its own: 120 instructions is under a third of 438, and it would
  add a second emission path (paying 38.3's 1.683x);
- S45-a's route is unchanged (47.4): a value-residency allocator over the CFG, taking frame 437, frame
  accesses 283 and copies 149 together;
- the pool of 869 against the target 438 (50%) still sits inside the tolerance of 45.3's frozen criterion,
  so **the criterion does not move**.

### 48.5 Gate

`tests/run_alloc_tests.py` gains two checks (group 2c) that pin `212 / 354 / 39 / 1,711 / 120` and a
self-check `0 < promotable_ops < stack_ops` (to catch both "everything is promotable" and "nothing is").
The gate now has **37 checks**; this slice measures EXIT=0, 37 ok, 0 FAIL (`D:/tmp/bm/alloc_gate_s47.log`).

### 48.6 Reproduction

- slot census: `-fopt-alloc` plus `ARKCC_ALLOC_STATS=1`, summary line `alloc-slots: ...`; per function
  with `ARKCC_ALLOC_NAMES=1` as `alloc-slots <name> slots=... promotable=... ops=... ops_promotable=...`;
- summary script: `D:/tmp/bm/cf/s48.py` (same best arm, 212 functions);
- frame accesses including the `r6` alias: `D:/tmp/bm/cf/s48b.py` (corpus), `s47j.py` (four buckets).
## 49 Slot residency is the wrong handle: a stack machine pays at the expression stack, not at frame slots (2026-11-27)

48 pinned the slot census. This section re-splits the same text by "prologue / expression stack / frame
slot" and kills a direction that is very easy to take: **parking frame slots in registers buys only 235 IR
operations, while the money sits in the `PUSH`/`POP` of the function body.**

### 49.1 Readings (95 TUs, 212 functions)

| quantity | measured | source |
| --- | ---: | --- |
| `push`/`pop` total | 769 | same convention as 45.1 |
| of which prologue (within the first 4 instructions) | 242 | `s49.py` |
| of which epilogue (within the last 4 instructions) | 203 | `s49.py` |
| **of which in the function body (expression stack)** | **324** | `s49.py` |
| single-register `PUSH {rN}` / `POP {rN}` in the body | 237 | `s49.py` |
| of which `{r0}` / `{r1}` | 210 / 22 | `s49.py` |
| frame accesses (`[sp]` or the `r6` alias) | 643 (`str` 366 + `ldr` 277) | 48.2 |
| IR slot operations (`IR_STORE` definitions + `IR_PUSH_VAR` reads) | 1,711 | 48.1 |
| **promotable by residency (CFG form: one defining block dominating every access)** | **73 slots / 235 ops (13.7%)** | new census in this section |

### 49.2 Why slot residency is the wrong handle

1. **The conversion rate from IR slot operations to assembly instructions is only 0.38**: 1,711 slot
   operations reach the text as 643 frame accesses. Turning one slot operation into "a register" removes
   **not a single assembly instruction** in most cases, because that access was never emitted in the first
   place (the value stayed in `r0` or `slotreg` folded it away). 235 x 0.38 is about **89 instructions** -
   far from 438.
2. **The stack machine's cost is the expression stack**: of the 324 body `push`/`pop`, 237 are
   single-register and 210 are `{r0}`; they all come from "push the left operand before evaluating the
   right one". armcc has only 154 `push`/`pop` on the same corpus; the difference of **615** is the visible
   price of exactly this.
3. The other two blocks are the 643 frame accesses (armcc 46) and the 2,005 register `mov` copies
   (armcc 219).

### 49.3 Verdict

**`slot_residency_is_the_wrong_handle`** (frame-slot residency is not the right handle).

- 48's finding (single-block promotion of 120 does not form a slice) and this section's finding (235 CFG
  operations, about 89 instructions) point at the same thing: **S45-a cannot be built as a "slot -> register"
  transform; it can only be built as a "value -> register" emitter**;
- the first cut of the next step is not an allocator but **registering the expression stack**: `ark_top_try`
  today places only the top of stack in `r0`, and the second level always goes to the machine stack. Putting
  the second level (and where needed the third) in callee-saved registers eats the bulk of the body
  `PUSH {r0}`.

### 49.4 New slice, pre-registered: `-fopt-rstack` (depth-2 expression stack, frozen criterion)

| item | frozen value |
| --- | --- |
| scope | inside the emitter (`ark_top_try` plus the common emission path); **no second emission path** |
| deletable pool (measured) | body `push`/`pop` **324** (237 single-register); this slice only eats the single-register shape |
| ceiling if fully realised | 9,588 - 324 = **9,264** |
| accept criterion | realisation >= **60%** => corpus **<= 9,394** (otherwise withdrawn) |
| not allowed | no counting prologue/epilogue `push`/`pop`; no trading semantics for fewer instructions; no touching 45.3's five stages |
| OFF IS OFF | switch off by default; off means byte-identical text to today on all 95 TUs |
| semantics | `arm_exec` must agree per function on both arms; new fixtures cover leaf arithmetic, nested binary expressions, five-argument calls, `switch`, bitfields |
| crop | `-DARKCC_FEATURE_OPT_RSTACK=0` rejects the switch by name (C3900U), and without the switch the text stays byte-identical |

**Stated up front**: even if fully realised (9,264) it **does not reach** 45's S45-a ceiling (9,150). This
slice **does not count toward 45's five stages**; it is an in-architecture gain with no 38.3 penalty, and it
removes half of the structural premise "every value must cross the machine stack", which lightens the load on
the later value-residency emitter.

### 49.5 Gate

The CFG counters of the slot census (`cfg_slots=73`, `cfg_ops=235`) are pinned in
`tests/run_alloc_tests.py`, with the self-check `promotable_ops < cfg_ops < stack_ops` (to catch a reading
where the CFG form is not larger than the single-block form). The gate now has **38 checks**; this slice
measures EXIT=0, 38 ok, 0 FAIL (`D:/tmp/bm/alloc_gate_s48.log`).

### 49.6 Reproduction

- `push`/`pop` three-way split (prologue / epilogue / body, single-register, `r0`/`r1`):
  `D:/tmp/bm/cf/s49.py`;
- slot-residency CFG census: `-fopt-alloc` plus `ARKCC_ALLOC_STATS=1`, the `alloc-slots: ... cfg_slots=...
  cfg_ops=...` line (per function with `ARKCC_ALLOC_NAMES=1` as `alloc-slotcfg <name> off=... ops=...`,
  only >= 4 listed);
- frame accesses: `D:/tmp/bm/cf/s48b.py` (corpus), `s47j.py` (four buckets).
## 50 `-fopt-rstack` measured and withdrawn: depth 2 saves register copies, not memory traffic (2026-11-27)

Implemented against the frozen criterion of 49.4, the depth-2 expression stack moves the corpus from
16,245 to 15,901 instructions on the same arm (-344, -2.1%), but **body `push`/`pop` falls by only 14**
(496 -> 482), an order of magnitude away from the 324-instruction pool the pre-registration named. This
section records where that difference comes from and **withdraws** the slice as a pre-registered
optimization (the code stays, default off).

### 50.1 Implementation

- The invariant: `*top` goes from 0/1 to 0/1/2; 2 means the top word lives in `r0` and the one under it in
  `r1`. Every change sits inside `ark_top_try()`, there is no second emission path, and any op that is not
  modelled first runs `ark_top_drain()` (`PUSH {r1}` then `PUSH {r0}`) and then takes its old path, so a
  wrong decision costs one op, not the backend.
- When depth 2 is entered (look-ahead): `ark_top_make_room()` may emit `MOV r1, r0` only when **the next IR
  op is a binary op it can handle**, otherwise it pushes as before. **The unconditional version measured
  17,281 instructions (+1,036, `PUSH`/`POP` 479/463 -> 847/779)**: almost every push first paid a `MOV` and
  then had to spill both levels.
- Consuming the pair: `emit_binary_swap()`. Commutative operators are spelled with two operands
  (`ADD/AND/ORR/EOR r0, r0, r1`, `MUL r0, r0, r1`), non-commutative ones use three registers
  (`SUB r0, r1, r0`, `SDIV r0, r1, r0`, `MOD` borrows `r2`, `LSL/LSR/ASR r0, r1, r0`), comparisons use
  `CMP r1, r0` followed by `emit_cmp_result`.
- Closing out: `IR_RETURN`, `IR_STORE`, `IR_POP`, `IR_DUP` and the 64-bit / complex `IR_UNARY` forms drain
  first when `*top==2`; `IR_LABEL` is a join point, so it drains and then hands back to the main switch.
- Instrumentation: `ARKCC_RSTACK_STATS=1` makes `codegen_arm` print
  `rstack: depth2=<n> pairs_saved=<n>` next to the existing `ark_alloc_report()`; without the variable
  nothing is printed, so no existing output can be disturbed.
- Cropping: `ARKCC_FEATURE_OPT_RSTACK` (0 under `STM32_MIN`); when cropped, `ark_rstack_enabled()` returns
  0 outright and the `#if !ARKCC_FEATURE_OPT_RSTACK` block in `src/main.c` rejects the switch by name with
  C3900U.

**A real defect fixed on the way (the internal Thumb-2 assembler)**: the three-operand register shift
`LSL Rd, Rn, Rs` with `Rn != Rd` was encoded as the 16-bit `Rdn <<= Rs`, silently dropping `Rn` -
measured: `LSL r0, r1, r0` with `r0=2, r1=12` gave 8 instead of 48. This slice is the first path to emit
that shape, which is why the defect surfaced now. Fix: the encode pass uses the 16-bit form only for the
immediate form; the register form stays 16-bit only when `Rd == Rn` and all three registers are <= 7,
everything else uses the 32-bit `LSL.W`; the size pass mirrors it (without the mirror it immediately
reports `assembler size pass disagrees with the emit pass (2046 vs 2054)`, which is its self-check).

### 50.2 Measurements (95 TUs, 212 functions, same-arm difference)

| quantity | `--reg-top` (arm A) | `+ -fopt-rstack` (arm B) | difference |
| --- | ---: | ---: | ---: |
| instructions | 16,245 | 15,901 | -344 (-2.1%) |
| text bytes | 299,991 | 295,993 | -3,998 |
| `PUSH` | 479 | 472 | -7 |
| `POP` | 463 | 456 | -7 |
| `push` + `pop` | 942 | 928 | -14 |
| of which in the body (outside prologue/epilogue) | 496 | 482 | -14 |
| `MOV rX, rY` (register copies) | 1,379 | 985 | -394 |
| depth-2 entries / consumed by the next op | - | 1,573 / 1,573 | no waste |
| largest per-TU growth | - | +3 (4 TUs) | see below |

Distribution over hunks (`difflib` aligned on instruction lines, 1,669 non-empty hunks):

| hunk delta | -26 ... -7 | -4 ... -1 | 0 | +1 ... +4 | +5 ... +25 |
| --- | ---: | ---: | ---: | ---: | ---: |
| hunks | 10 | 478 | **904** | 265 | 12 |

**904 of 1,669 hunks keep exactly their length and only rename a register**: `MOV r1, #52 / ADD r5, r8, r1`
becomes `MOV r0, #52 / ADD r5, r0, r8`. That is the whole story - the text layer (`-fopt-basefold`,
`-fopt-birthdest`, ...) **had already folded "push the left operand, load it back" into a register copy**
on arm A, so the `--reg-top` arm simply has no 324 body `push`/`pop` waiting to be deleted (of arm A's 942
`push`/`pop`, only 496 are body shapes this slice can reach, and most of those are not "left operand of a
binary" either).

Net difference by mnemonic (arm B minus arm A): `MOV` -329, `LDR` -14, `PUSH` -7, `POP` -7, `CMP` -2,
`AND` -3, `SUB` -1, `ADD` +13, `STR` +4, `MOVW` +2, everything else 0. 3,817 instructions are removed and
3,473 added, net -344.

The four TUs that grow (all <= +3): `stm32f4xx_hal.c` +1, `stm32f4xx_hal_dma_ex.c` +3,
`stm32f4xx_hal_pwr_ex.c` +3, `stm32f4xx_hal_rcc_ex.c` +3; the other 18 TUs that change all shrink or stay
flat.

### 50.3 Reconciliation with the 49.4 pre-registration

| pre-registered item | result |
| --- | --- |
| deletable pool 324 (body `push`/`pop`) | the same arm only offers 496 body shapes, and **14** are actually removed (4.3% of 324) |
| realisation >= 60% => corpus <= 9,394 | **not met**: 14 << 194; `<= 9,394` cannot be evaluated on the `--reg-top` arm (its baseline is 16,245, not 9,588) |
| never trade semantics for fewer instructions | honoured (both arms agree, see 50.5) |
| OFF IS OFF | honoured (0 TUs differ, in both directions) |
| cropping | honoured (`-DARKCC_FEATURE_OPT_RSTACK=0` rejects the flag by name, same text without it) |

The 49.4 pre-registration rested on the reading "the best arm (9,588) has 324 body `push`/`pop` to
delete", and that reading was taken on the arm **without** `--reg-top`, while `-fopt-rstack` can only live
inside the `--reg-top` model. The two arms' body `push`/`pop` are not the same instructions, so the
criterion cannot be evaluated literally once the implementation exists. The conclusion here: **neither
self-certify against the literal criterion nor move the goalposts afterwards** - it simply did not meet
the bar.

### 50.4 Verdict

**`rstack_is_withdrawn_its_pool_does_not_exist`**: `-fopt-rstack` is **withdrawn** as a pre-registered
optimization - it did not deliver "delete the body `push`/`pop`", and the 13,000-instruction gap is not in
this layer.

Three facts have to be stated together:

1. **It cannot touch the shipping arm.** `--reg-top` is off by default and the text-layer `H.BASE` does not
   include it; the shipping best arm is 9,588 (no `--reg-top`), and this slice changes not one byte there
   (50.5 item 2). The -344 buys nothing on the way to beating armcc.
2. **It saves register copies, not memory traffic.** -394 `MOV rX, rY` are largely offset by +13 `ADD` and
   a few stragglers; the 904 equal-length hunks say most sites were renamed, not reduced.
3. **The code stays, default off.** It is semantically correct, byte-identical when off, and it is the only
   triggering path for the assembler shift defect plus the carrier of that defect's fixture. If S51 does not
   re-target it at the real goal (register copies), it gets deleted - and deleting needs the user's consent
   first.

### 50.5 Gate

`tests/run_rstack_tests.py` has **14 checks**; this slice: EXIT=0, 14 ok, 0 FAIL, 0 skip:

1. OFF IS OFF, twice: on the `--reg-top` arm, 95 TUs with `-fno-opt-rstack` are byte-identical to the same
   arm without it, and the switch alone (without `--reg-top`) also changes no byte;
2. size pins: arm A `(16245, 299991, 479, 463, 1379)`, arm B `(15901, 295993, 472, 456, 985)`, body
   push/pop 496 -> 482, total -344;
3. growth pinned to `{hal.c:+1, hal_dma_ex.c:+3, hal_pwr_ex.c:+3, hal_rcc_ex.c:+3}` - the original
   "no translation unit grows" was an empty criterion (four TUs do grow), so it is replaced by the measured
   per-TU values;
4. sites 1,573 with `depth2 == pairs_saved` (the look-ahead never wastes a `MOV`);
5. a `unicorn` fixture (nested binary, five-argument call, runtime shifts, bitfield, `switch`): both arms
   return the same `r0`, the 40-word OUT matches the C source, and the RAM image is byte-identical;
6. the cropped build rejects `-fopt-rstack` by name and writes the same text as the full build when the
   switch is absent.

The existing `tests/run_alloc_tests.py` (38 checks) does not regress (EXIT=0).

### 50.6 Reproduction

- Three-arm readings: `D:/tmp/bm/rs/measure.py`, `measure2.py`; sites and waste: `counts.py`;
- hunk distribution and per-mnemonic net: `D:/tmp/bm/rs/hist.py`, `diffstat2.py`; per-TU growth: `grow.py`;
- site counter: `-fopt-rstack` with `ARKCC_RSTACK_STATS=1` (`rstack: depth2=... pairs_saved=...`);
- gate: `python tests/run_rstack_tests.py ./arkcc.exe` (needs `gcc` on `PATH`; the cropping check compiles);
- full regression: `env -u PYTHONPATH -u PYTHONHOME make test` (log `D:/tmp/bm/make_test_s50.log`).

### 50.7 Side finding (not fixed, registered as a later slice)

The `OUT[i++] = v;` shape gets the subscript wrong on the S16 line (the 33 passes, without `--reg-top`). The
**raw emitter is right** (no `-fopt-*` switch at all, `-O2` straight to an image gives `[11,22]`), and so is
the `--reg-top` arm. Running the images under `unicorn` narrows the failing arm to:

| Source (`OUT` = `(volatile int *)0x20010000`) | S16 line RAM | `--reg-top` |
| --- | --- | --- |
| `int i=0;` `OUT[i++] = 11;` | `[11]` | `[11]` |
| `int i=1;` `OUT[i++] = 22;` | `[0,22]` | `[0,22]` |
| `int i=0;` `OUT[i++] = 11; OUT[i] = 22;` | `[11,22]` | `[11,22]` |
| `int i=0;` `OUT[i++] = 11; i++; OUT[i] = 22;` | `[11,0,22]` | `[11,0,22]` |
| **`int i=0;` `OUT[i++] = 11; OUT[i++] = 22;`** | **`[11,0,22]`** | `[11,22]` |
| **`int a=0,b=1;` `OUT[a++] = 11; OUT[b++] = 22;`** | **`[11,0,22]`** | `[11,22]` |
| **`int i=0;` `OUT[0] = 11; OUT[i++] = 22;`** | **`[11,22]`** | `[22]` |

With three statements in a row the S16 line gives `[11,0,22,33]` while `--reg-top` gives `[11,22,33]`. The
trigger is **not** "the same variable" (the earlier reading of this section said so, and that is wrong - a
different variable fails just as well): the accurate shape is "**after the first subscript store in the
function, any later subscript store that post-increments**" - the later one takes its address from the value
**after** the increment.

The cause is the slot rename in `-fopt-vreg`. The greedy minimal triggering set is
`-fopt-peep -fopt-prop -fopt-vstack -fopt-vreg`; adding `-fno-opt-vreg` to `BASE` restores `[11,22]` at once.
The only difference between the two arms (a `-S` diff of prefix 15 against prefix 16) is:

```
-    LDR r7, [r6, #0]      ; the pre-increment i, parked in r7
-    LDR r0, [r6, #0]
-    ADD r0, r0, #1
-    STR r0, [r6, #0]
-    MOV r0, r7            ; the subscript uses the pre-increment value
-    LSL r7, r0, #2
+    ADD r8, r8, #1        ; the slot is renamed to r8
+    LSL r7, r8, #2        ; the subscript now reads r8, i.e. the post-increment value
```

The slot and the resident register are being treated as one value version, so the increment writes the old
value out of reach. The `IR` is still right (`ARKCC_DUMP_IR=1` is identical instruction for instruction on both
arms: `PUSH_INT base`, `PUSH_VAR i`, `PUSH_VAR i`, `PUSH_INT 1`, `BINARY +`, `STORE i`, `PUSH_INT 4`,
`BINARY *`, `BINARY +`, `PUSH_INT v`, `STORE_IDX`, `POP`); the defect is in a text pass, not in irgen (the
earlier reading of this section, which called it a "pre-existing irgen defect", is wrong and is corrected
here).

Fixing it needs its own slice: make vreg keep a version of the old value when "the slot is written in this
block" (or decline to keep this slot resident at all), then add a gate (the seven rows above plus both the
S16 and `--reg-top` arms plus a byte-for-byte RAM comparison via `arm_exec`) and run the full regression. The
fixtures in this section therefore always use explicit indices and do not carry the fix along.
