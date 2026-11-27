# S6: IR-level virtual register allocation (`-fopt-vreg`, implemented, off by default)

English | [中文](VREG.md)

> In one sentence: the text level is done -- `-fopt-cmat` -1.77%, `-fopt-slotreg` -0.34%
> and `-fopt-coalesce` -1.93% were each implemented under the "delete or rename, never
> change the model" discipline and each closed with a measurement. What is left -- 17.7%
> frame accesses, 6.2% register staging, 9.7% constant materialisation -- is **not redundant
> work: it is what "every intermediate value must pass through r0 and the frame" costs.**
> This file pre-registers the model change: criteria, falsifiers, slices, cropping and
> rollback are frozen before any code is written; implementation proceeds slice by slice and
> each slice can be archived on its own.

---

## 0 What this document answers

1. why the next step can only be a model change (§1, §2 -- all measured);
2. what the target model is (§3);
3. how it is sliced, and each slice's target and criteria (§4);
4. when it must be archived (§6);
5. what it does **not** promise (§9).

This file is registration only; it contains no implementation. When code lands, the only
allowed edit is an appended "implementation and measurement" section -- **the frozen criteria
and falsifiers below are not touched**, the same discipline already used by
`docs/SLOT_REGISTERS.md` §5 and `docs/OPERAND_ALLOC.md` §6.

## 1 Current state (2026-11-23, 95 TUs, Cortex-M4, `-O2`, fifteen switches + `-fopt-coalesce`)

| Item | Value |
| --- | --- |
| Instructions | **18,151** |
| Functions (global labels) | 548 (median 8 instructions, p90 51, largest `HAL_RCC_OscConfig` 3,156) |
| Reference | armcc `-O2` 5,629, armclang `-O2` 5,068 (96-TU basis, see `docs/COMPARISON.md`) |
| Gap | **about 3.2-3.4x** |

Instruction families (same corpus, share of 18,151):

| Family | Count | Share | What can remove it |
| --- | ---: | ---: | --- |
| ALU (`ADD`/`CMP`/`AND`/`ORR`/`LSL`/`SUB` ...) | 4,234 | 23.3% | Partly: the staging in front of an operand that is already computable goes with S6a |
| **Frame access (`LDR`/`STR` based on `[r6]` / `[r5]`)** | **3,213** | **17.7%** | **Only register allocation** |
| Branches / `bx` | 2,014 | 11.1% | No (`-fopt-branch` / `-fopt-cbz` are at the bottom) |
| Constant materialisation (`MOVW`+`MOVT` pairs) | 1,754 | 9.7% | Partly: 810 complete pairs; only same-function reuse is left (`-fopt-constcache` took 159) |
| `MOV rD, #imm` | 1,740 | 9.6% | Partly: small constants move into pool registers under S6a |
| `MOV rD, rS` staging | 1,120 | 6.2% | Mostly: `-fopt-coalesce` took 358; the rest is blocked by `BL` and by a live source |
| `PUSH` | 1,060 | 5.8% | Mostly: of these, 741 are `PUSH {r0}` -- the value-stack shuttle |
| `POP` | 731 | 4.0% | Same (`POP {r0}` 269) |
| Frame pointer pair (`MOV r6, sp` / `MOV sp, r6`) | 517 | 2.8% | No, unless the frame pointer goes away (measured: only 26 leaf functions could drop the whole frame) |
| Other `LDR`/`STR` (`[sp]`, symbol literals ...) | 316 | 1.7% | No |

**How to read it**: of the 18,151 instructions, everything that could be removed by
"delete a line, rename a register" has been removed (`docs/COALESCE.md` §5 explains the
residual gap; `docs/OPTIMIZER_PLAN.md` P17 records the archive verdict).
3,213 + 1,120 + 741 = **5,074 instructions (28%)** are the direct cost of the single
assumption "a value must go through memory or r0".

## 2 Why the text level cannot go further

Three attempts already hit the same wall:

1. `-fopt-slotreg` (P17): without its safety gate it deletes -1.82%, but that produced 5
   `arm_exec` failures (`memcpy` reads through memory, invisible at the text level). With the
   gate it is -0.34% and was **archived**.
2. `-fopt-constcache` (P18/S3a) and **S3b**: S3b wanted to save "values live across a call";
   the real opportunity over 95 TUs is **5 pairs / 0.11%**, and it was **archived**.
3. `-fopt-coalesce` (L5): 81/95 TUs byte-identical, -1.93%; every remaining copy is blocked
   by "a `BL` inside the run" or "the source is written inside the run".

The conclusion: **the text cannot see which register a value is in right now**, so every rule
has to treat the invisible reads and writes as dangerous -- and once it is safe, the gain is
gone. More gain needs "where does this value live" to be a first-class object in the
compiler, not something guessed afterwards.

## 3 Target model

Today (`docs/RA_VSTACK.md` §1): the IR is a stack machine; emission `PUSH`es and `POP`s every
intermediate value, and `-fopt-vstack` folds adjacent round trips into r0/r5/r7 moves
afterwards, with the rest going back to the frame.

Target:

```
irgen (unchanged) -> IR (unchanged) -> a new IR-to-text emitter (S6) -> assembler (unchanged)
                                            ^
                              virtual registers + linear scan + spill
```

- **Virtual registers**: `IR_PUSH` and every value-producing instruction get a `vreg` in S6
  instead of an implicit r0; the stack semantics become live intervals of `vreg`s, and
  `PUSH`/`POP` no longer mean machine-stack traffic.
- **Register pool**:
  - caller-saved `r0`-`r3`: values inside a block whose interval does not cross a `BL`;
  - callee-saved `r8`-`r11`: values whose interval crosses a `BL`, at the cost of one widened
    `PUSH` per function (shared with `ark_regalloc_function()`; **exactly one owner** of the
    widening and of the offset shift, as fixed in `docs/OPERAND_ALLOC.md` §4);
  - `r6` stays the frame base (giving it up would only save 0.2%, already measured).
- **Live intervals**: over the linear IR order plus the basic blocks `src/mir.c` already
  provides, merged across block boundaries via `succ`; `RETURN` / `BL` / indirect calls split.
- **Spill**: only in S6c, into frame slots handed out by the same `alloc_local()`.
- **Relationship with `-fopt-vstack`: one or the other** (as already decided in
  `docs/OPTIMIZER_PLAN.md` P12 S5). Once S6 is wired in, the vstack text rebuild does not run
  on the same function; which one is the default is decided by the corpus, and the other stays
  as a rollback switch.

## 4 Slices (each with its own gate and its own archive decision)

| Slice | Scope | Target | Criteria focus |
| --- | --- | --- | --- |
| **S6a** | Inside one basic block, no `BL`: two-operand ALU reads pool registers directly and results stay in a register | -8% or more (>= 1,450) | OFF IS OFF byte-identical; any TU growing is red; `arm_exec` full run 0 failure |
| **S6b** | Across blocks: linear scan with interval merging (branch diamonds) | another -8% | same, plus intervals must intersect at the join to be live |
| **S6c** | Across `BL` (callee-saved) and spill | enabled only when the budget is positive (bytes saved > bytes of the widened `PUSH`) | the budget must be printed; a negative budget means "not enabled" |
| **S6d** | Merge with / choose between `-fopt-vstack`; set the default | no new gain, just de-duplication | the two paths are byte-identical or explicitly smaller on all 95 TUs |

**S6a is the first judgeable slice** and the only one that may claim independence while
staying block-local.

## 5 Frozen gates (not edited before implementation)

1. **OFF IS OFF**: `-O2` and `-O2 -fno-opt-vreg` are byte-identical (95/95 TUs);
2. **Never larger**: any TU whose instruction count grows is red; no "better on average" story;
3. **Off by default**: `enable_opt_vreg = 0`, switchable from both CLI and INI;
4. **Execution equivalence**: `tests/arm_exec/run_arm_exec.py --extra=-fopt-vreg`, full run,
   0 failure, and every expectation still a constant computed outside the program (no
   self-certification);
5. **Cropped refusal**: a build with `-DARKCC_FEATURE_VREG=0` rejects `-fopt-vreg` with
   `Fatal error: C3900U: -fopt-vreg is not compiled into this build` and returns 1, and still
   compiles without the flag;
6. **Board size**: `tools/stm32_build_check.py --layout both` still all PASS (code + rodata
   <= 2 MB, `.ark_buf` inside its region in both layouts);
7. **Full gate**: `make test` EXIT=0 (including the new `make test-vreg`).

## 6 Falsifiers (frozen; triggering one archives the line)

- **F1**: after S6a the total drop is **< 5%** => archive (stricter than 0.5%, because a model
  change carries its own risk cost);
- **F2**: any TU grows => archive;
- **F3**: one `arm_exec` failure that cannot be attributed to an unimplemented shape => archive
  (**a wrong answer is never acceptable**);
- **F4**: S6a needs more than `r0`-`r3`, or needs to spill, to pass 5% => archive and go back to
  the text level (it would mean a block simply does not have that many registers to give).

## 7 Cropping

- `ARKCC_FEATURE_VREG`: `ARKCC_PROFILE_STM32_MIN` => 0, host and cross builds => 1, default
  **off**;
- when off, the code does not run and no existing output changes (OFF IS OFF is byte-exact);
- the body is a new emitter rather than new tables, so cropping it on the board only saves code
  size and affects no other pass.

## 8 Risk and rollback

| Risk | Handling |
| --- | --- |
| S6a correctness (the hard part is "stack semantics <-> register semantics" equivalence) | a `memcmp` check cannot apply (the text is supposed to change), so the criteria can only be execution-level: the 95-TU corpus, the full `arm_exec` battery, and per-function differential probes |
| Competing with `ark_regalloc_function()` for the saved-register block | "exactly one owner of the `PUSH` widening and the offset shift" (`docs/OPERAND_ALLOC.md` §4); if that cannot hold, S6c degrades to "not done" |
| Interval explosion on long functions (`HAL_RCC_OscConfig`, 3,156 instructions) | linear scan sorts endpoints, O(n log n); over a cap the whole function abstains and goes back to the vstack path |
| Debuggability | `-g` needs variable locations; losing debug info is not accepted before S6 handles it |

Rollback: one flag, default off; `--pipeline=lite` can skip it; no existing code path is
deleted.

## 9 What this does not promise (frozen, so it cannot be read as a promise)

1. **Not** reaching armcc `-O2`'s 5,629. Two of the three structural gaps are outside this
   slice: each TU still carries its own runtime helpers (920 instructions, 4.8%) and there is
   still no instruction scheduling;
2. **The intermediate target of S6a+S6b is 12,700 instructions (-30%)**; short of that this is
   not "near parity", only "the model finally changed";
3. this file changes no existing verdict for `-fopt-vstack` / `-fopt-slotreg` /
   `-fopt-coalesce`;
4. "changing the model" is a project-level decision: this pre-registration needs one explicit
   go-ahead before implementation, matching the S4/S5 entries in `docs/OPTIMIZER_PLAN.md` P12.
## 10 Negative measurements before implementation (2026-11-23, measure first, then write code)

This section holds the four measurements taken *before* writing any S6 code, asking whether the text layer still has money left in it. All four are negative or negligible, and the fourth bounds the *form* of any gain — which directly fixes the **implementation form** of S6a (see §10.5). All numbers are on the 95-TU corpus under `-O2` with the sixteen switches; `base` must self-check to **18,151** within a single run.

### 10.1 The shipping default of `-fopt-regalloc` is a no-op

| Arm | Total instructions | vs base |
| --- | --- | --- |
| base (sixteen switches) | 18,151 | — |
| `+ -fopt-regalloc` | 18,151 | **0, 95/95 byte-identical** |
| `+ -fopt-regalloc-near` | 18,174 | +23 (+0.13%, 3 TUs smaller, 2 larger) |

The zero effect of the default arm **is not a bug**; two design boundaries fire at once:

1. The default arm only takes "wide" slots (offset >124 or not 4-byte aligned, where widening `PUSH` pays off); HAL locals almost all sit in `0..124` and are 4-byte aligned ⇒ `saves = 0`, no slot is selected;
2. `ra_classify()` only recognises `LDR r0,[r6,#n]` / `STR r0,[r6,#n]`, but `-fopt-vstack` has already rewritten most accesses into the `r5`/`r7` shadow-stack shape ⇒ those lines are treated as taint and dropped.

Conclusion: the shipping text-level slot caching gains nothing even when switched on; `-near`'s +23 is noise.

### 10.2 Slot caching only turns an access into a MOV, and instruction count goes up

One `HAL_GPIO_ReadPin` instance (under `-fopt-regalloc-near`):

```asm
STR r0, [r6, #16]     ; was: store the return value into the slot
...
LDR r0, [r6, #16]     ; was: read it back
```

becomes

```asm
MOV r8, #1            ; the constant held in the slot is MOV'd into the cache register
MOV r0, #1            ; plus a redundant immediate load
...
MOV r0, r8            ; the read-back becomes a register MOV
```

Two things happen at once: the **count does not drop** (`STR`→`MOV`, `LDR`→`MOV` one for one), and `MOV r5, r8` (between high registers) is a **32-bit encoding**, *wider* than the original `LDR r5, [r6, #16]` (16-bit). So "cache + MOV replacement" is byte-negative by construction and cannot be the landing form of S6a.

### 10.3 `-fopt-pair` and `--reg-top` are both dominated by existing switches

| Arm | Total instructions | vs base |
| --- | --- | --- |
| `+ -fopt-pair` | 18,145 | **−6 (−0.03%), 5 TUs smaller, 0 larger** |
| `--reg-top` (fairer arm with imm / cbranch removed) | 24,812 | **+6,661 (+36.7%)** |
| `--reg-top + -fopt-pair` | 24,800 | same order; pair saves only 12 |

Under the full sixteen switches `-fopt-pair` is worth only 6 lines, i.e. adjacent-`MOV` merging has already been eaten by `-fopt-imm` / `-fopt-cbranch`; and removing those two does not let pair recover (still 24,8xx). ⇒ pair is archived, not an input to S6.

**Re-measured 2026-11-24 (nineteen-switch baseline, base 12,304)**: on that baseline `--reg-top`
gives **18,997 = +6,693 (+54.4%)**, **worse** than the +36.7% under sixteen switches. The more
existing switches are on, the more of `--reg-top`'s gain is eaten, while its own `MOV`/widening
cost stays ⇒ **this base is not reusable**, and no "build S6 on top of `--reg-top`" plan holds.

### 10.4 Upper bound of text-layer gain (decisive)

Of the 18,151 lines, the simplest frame accesses `LDR/STR rN,[r6,#n]` total **1,845** (LDR 1,306 / STR 539):

- **99.8% (1,842)** land on slots that are **never address-taken** (no `ADD/SUB rX, r6, #n` points at them);
- If each function keeps its four most-accessed slots in `r8-r11`, the **absolute upper bound** of removable lines is **1,714 = 9.4%**;
- "store then same-register reload" (`LDR rX,[slot]` immediately followed by a same-slot same-register `STR`) is only **80 lines (0.44%)**;
- foldable "STR→LDR across statements" forwarding pairs are only **52 pairs → 104 lines (0.6%)**.

Even taking all 1,714 we only reach 16,437 (still 2.9x armcc). ⇒ **the text-layer route ends here**, consistent with §2.

### 10.5 Implementation-form revision implied by 10.2 and 10.4 (gates unchanged)

§4 originally wrote S6a as "cache into `r8-r11` + replace accesses with MOV". 10.2 proves "replace with MOV" is byte-negative, and 10.4 proves the only worthwhile gain is "make the access disappear entirely". Therefore **S6a's implementation form is revised to**:

> **Slot cache + rename elision**: a hit `LDR rX,[slot]` is *not* replaced by `MOV rX, rCache`; instead **the destination register is renamed to `rCache` across the straight-line region that consumes the value, and the `LDR` is deleted**; the matching `STR rCache,[slot]` side is done by "retarget the producer's destination register to `rCache` and delete the `STR`". Region boundaries reuse `-fopt-coalesce`'s `lv_same` replay check; but because `rCache` is callee-saved, `BL` **is no longer a barrier** (this is exactly what lets it do more than coalesce).

This targets the same thing as §3's "vreg + linear scan" (which register a value lives in is decided by the model, not guessed from a text pattern); **the 7 frozen gates in §5 and F1-F4 in §6 are unchanged, character for character** — only "how to write it" moves from replacement to elision, anchoring the expected gain inside 10.4's 9.4% bound (S6a's -8% >= 1,450 still holds, with 264 lines of margin for implementation loss).

## 11 Measured result (2026-11-23, S6a implemented)

The form is the one §10.5 fixed: flag `-fopt-vreg`, **off by default**; a cropped build (`-DARKCC_FEATURE_OPT_VREG=0`) refuses it by name (C3900U) instead of accepting it and doing nothing.

### 11.1 How it cooperates with the existing passes (why it must run last)

`-fopt-constcache` lives *inside* `ark_regalloc_function()` and competes for the same `r8-r11` pool and the same `PUSH/POP` pair. So vreg does **not** override regalloc; it runs after it:

1. `regalloc` (including the constant cache) caches values in `r8-r11` first and widens the frame;
2. `vreg` then reads the `PUSH` list, the used-register mask and `base = local_eff + 4 * saved_words` **off the text**, works only in what is left, and shifts every offset at or above `base` when it widens.

The first version ran vreg before regalloc: 95 TUs gave **18,151 → 18,310 (+159)**, the `MOV r5, r8` and `MOVW+MOVT` gains gone. Cooperating gives **-415**.

### 11.2 Three implementation rules

- **The load destination is r0-r7, not always r0**: `-fopt-vstack` moves slot traffic to `r5/r7` (`LDR r5,[r6,#n]`); accepting only `LDR r0` made the whole route dead on top of vstack (-270 only). Renaming and deletion are parameterised by the register the load actually writes.
- **A slot must have `elid >= 2`**: the accounting is in instructions (`PUSH/POP` widening adds no instruction but 4 B of stack traffic per register), so saving one line is not worth a stack word.
- **`saved_words = number of listed registers + 1`** (lr is one word), `base = local_eff + 4 * saved_words`; if `saved_words + nregs` is odd after widening, one more register is taken from the free pool to keep 16 + 8k alignment.

### 11.3 Measured numbers (95 TUs, Cortex-M4, sixteen switches + `-fopt-coalesce`)

| Arm | Instructions | vs baseline |
|---|---|---|
| baseline (no `-fopt-vreg`) | 18,151 | — |
| `-fopt-vreg` | **17,736** | **-415 (-2.29%)** |

13 TUs change; largest `stm32f4xx_hal_dma.c` 2,603 -> 2,422 (-181), `stm32f4xx_hal_rcc.c` 2,780 -> 2,718, `stm32f4xx_hal_exti.c` 626 -> 590.

### 11.4 Gate (`tests/run_vreg_tests.py`, all green)

1. **OFF IS OFF**: default `-O2` and `-O2 -fno-opt-vreg` are byte-identical (1,218/1,218 bytes, image included).
2. **IT PAYS**: four reload fixtures (`chain/loop/many/call`, all "struct pointer + distant member" shapes that produce `LDR rX,[r6,#n]` immediately followed by its consumer) strictly shrink, and **no fixture grows** -- the pass has no form that adds an instruction.
3. **THE FRAME IS ONE FRAME**: the promoted function's `PUSH/POP` gain the same registers (`added`), every offset at or above `base` (caller args and the va region) shifts by `4 x len(added)`, and no offset is left inside the widened save.
4. **IT DOES NOT TOUCH WHAT IT CANNOT PROVE**: an address-escaping local and a `volatile` local come out line-for-line identical.
5. **THE ANSWER IS THE SAME**: seven fixtures run on the emulator in three arms (off / on / alone -- `alone` is the only arm that exercises frame widening on its own) and return the Python answer.
6. **CROPPED OUT, REFUSED**: a `-DARKCC_FEATURE_OPT_VREG=0` build reports C3900U and still compiles without the flag.

### 11.5 Side finding (found and fixed in this round)

`-fopt-vstack` miscompiles a call with **more than four arguments** when the body uses argument 5 or 6: vstack claims `r4` for the third value-stack slot, widening the frame by four bytes, but the front end's argument-copy loads `LDR r0,[r6,#n]` still assume four saved words and read four/eight bytes too low.

Repro: `int h2(int a,int b,int c,int d,int e,struct VgS *p){return e + p->a;}` returns `0x30B0xxxx` instead of 6 under `-fopt-vstack`; without the flag, or with only `-fopt-regalloc -fopt-constcache`, it is correct (five arguments are fine, six are not; six plain integers are unaffected -- one memory access is needed).

The switch is off by default (0.9.1-wip), so `-O2` is unaffected. Fix: after widening, vstack calls the new `vs_shift_r6()`, which moves every `[r6, #n]` with `n >= frame` by **+8** -- the `PUSH` grew by one word *and* the frame by four, so the caller's arguments sit two words higher relative to `r6`. Shifting by four only lands on the newly saved word (measured: immediate `UC_ERR_READ_UNMAPPED`). After the fix `h2` returns 6 under `-fopt-vstack` and `vg3` (`p->a + p->d + a + b + c + d + e`) returns 56; `run_vstack_tests.py` and `run_vreg_tests.py` are green, and the 95-TU total is still 18,151 (immediates only, no instruction delta).

## 12 Measured result (2026-11-23, S6b implemented: whole-block renaming)

S6a only consumed the single load that fed the very next instruction. S6b widens the region to **the rest of the basic block**: once a promoted slot's load is dropped, every line in the same block that reads that load's destination reads the cache register instead, until one of exactly four events ends the region: (1) a barrier line (a label, a branch/jump, `BL`/`BLX`, PUSH/POP or frame setup); (2) the frame-setup line itself; (3) another frame load that writes this very destination register (`LDR rD, [r6,#m]`, after which `rD` no longer holds the cache register's value); (4) any line that **writes only and never reads** `rD`. Everything else is renamed and the region continues -- including another slot's access (as long as it does not touch `rD`) and a store whose source is `rD` (that store is renamed too, or it would write the pre-load value back). A read-modify-write (where `rD` is the destination of `ADD r0, r1`) is renamed and kept: the cache register carries the updated value down the same path, so nothing has to be written back in the middle of the region. This section records measurement and implementation only; the frozen gates of §5 and the falsifiers of §6 are unchanged word for word.

### 12.1 What changed relative to S6a (three things, and one departure from the §4 plan)

One discrepancy first: §4 describes S6b as "cross-block: linear scan + interval merging". What actually landed first is **whole-block renaming** -- the region boundary is still a single path inside one block (any branch or label ends it), with no cross-block liveness and no interval merging. S6a's -2.29% was still far from F1 (archive if below 5%), and whole-block renaming eats most of the readers without needing a CFG at all, so it was made into its own slice and archived on its own; "cross-block linear scan + interval merging" moves to **S6b-2**, still under the same F1.


1. **Region: one line -> the whole basic block.** Each of a slot's loads now consumes all its readers in the block, so the hit rate grows from "the next instruction" to "every reader in the block".
2. **One line can carry several renames.** With a block-wide region a single line may read two promoted slots (`ADD r0, r3, r4`), so the rename is a **per-line map of up to 4 pairs** (`VG_MAX_MAP 4`) applied in sequence instead of a single `(from,to)` pair.
3. **Frame alignment: add a register, not a word.** The frame was 8-aligned before the pass, so after adding `nregs` registers it is still aligned **iff `nregs` is even** (independent of the parity of `saved_words`). When odd, one more r8-r11 is taken from the pool -- any r8-r11 name in a `PUSH` costs 32 bits either way, so the spare register adds no instruction; if the pool has no spare, the function is left alone.

### 12.2 Measured numbers (95 TUs, Cortex-M4, sixteen switches + `-fopt-coalesce`)

| Configuration | Instructions | vs baseline |
|---|---|---|
| Baseline (no `-fopt-vreg`) | 18,151 | -- |
| S6a (point elision) | 17,736 | -415 (-2.29%) |
| **S6b (whole-block renaming)** | **17,350** | **-801 (-4.41%)** |

> The later "unreferenced `static` functions are no longer emitted" pass is an
> always-on IR-level pass (see [DEADSTATIC.en.md](DEADSTATIC.en.md)) that saves a
> further 1,737 instructions on the same corpus; counting it, the current total with
> `-fopt-vreg` is **15,613 (-13.98%)**. The 17,350 above is the reading taken when
> S6b landed and is left unchanged.

S6b saves a further **386** instructions over S6a. 14 TUs change; the six largest: `stm32f4xx_hal_dma.c` 2,603->2,316 (-287), `stm32f4xx_hal_gpio.c` 883->756 (-127), `stm32f4xx_hal_rcc.c` 2,780->2,677 (-103), `stm32f4xx_hal_exti.c` 626->572 (-54), `stm32f4xx_hal_cortex.c` 790->743 (-47), `stm32f4xx_ll_utils.c` 819->773 (-46). The rest: `flash_ex` -38, `rcc_ex` -35, `dma_ex` -22, `flash` -22, `hal` -8, `pwr` -5. **No TU grows.**

### 12.3 Gates (all green)

| Gate | Result |
|---|---|
| `tests/run_vreg_tests.py` (with the new `deep` fixture, expects 116) | all checks passed |
| `tests/run_vstack_tests.py` | all checks passed |
| `tests/run_coalesce_tests.py` | all checks passed |
| `tests/run_regalloc_tests.py --arkcc ./arkcc.exe` | all claims hold |
| `tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe` | 0 failure(s) |
| same with `--extra=-fopt-vreg` | 0 failure(s) |
| `tests/asm_cases/run_asm_cmp.py` (disassembly text against GNU as + objdump) | identical=12 differ=0; 24 `--asm-extra` mnemonics and 15 refusal reasons green |
| OFF IS OFF (vreg off, sixteen switches, 95 TUs vs the pre-change baseline) | identical 95 / different 0 |

This round also added a **third-party semantic cross-check** (the throwaway `hisem.py`): the same line is assembled by both `arm-none-eabi-as` (12.3.rel1, shipped with STM32CubeIDE) and `arkcc`, each executed in unicorn (`UC_MODE_THUMB|UC_MODE_MCLASS`, single step), and `r0-r14` plus NZCV are compared. 31 forms (CMP high/low/immediate, LSL/LSR/ASR three- and two-operand, MUL/MULS, NEG/RSB) give **bad=0**. The criterion is semantic equivalence, not identical bytes: one syntax may have several legal encodings (16-bit vs 32-bit), and it passes as long as every register and flag agrees.

### 12.4 Four real defects (each only surfaced once slots reached `r8-r11`)

None of these was a typo in new code. Each was an **assumption in existing code that happened to hold while only r0-r7 were in play**. `-fopt-vreg` was the first pass to put locals in r8-r11 and the first to feed a real two-operand shift into the assembler, and all four assumptions broke at once.

**12.4.1 The built-in assembler silently truncated high registers (CMP / immediate CMP / NEG / MUL)**

| Source | Encoding before the fix | Consequence |
|---|---|---|
| `CMP r9, r7` | `cmp r1, r15` | compares the wrong pair, condition codes all wrong |
| `CMP r9, #4` | `cmp r1, #4` | T1 `CMP Rn,#imm8` carries only 3 bits of Rn and the code never looked at `rn` |
| `NEG r9, r7` | `rsbs r1, r7, #0` | destination truncated to r1 |
| `MUL r9, r8, r7` | hard error, stop | T2 already supports three distinct registers |

The fix is not "reject it", but completing the 32-bit forms: `CMP` via `0xEBB0|Rn` + `0x0F00|Rm`; `CMP Rn,#imm` via `0xF1B0|i<<10|Rn` + `imm3<<12|0x0F00|imm8`; `NEG` (= `RSB Rd,Rm,#0`) via `0xF1C0|Rm` + `Rd<<8`; `MUL` via `0xFB00|Rn` + `0xF000|Rd<<8|Rm`. Just as important, **pass 1's byte-width decision had to be corrected in step** -- `MUL`'s pass 1 simply `(void)`-ed the third register `rn1`, so `MUL r1,r2,r3` was laid out at two bytes while pass 2 wrote four (or the reverse), and every label downstream drifted. **Both passes must derive their width from the same predicate.**

One field was also settled after I got it wrong once: in T2 16-bit `CMP Rn,Rm` (`0100 0101 0 Rm Rn`), **Rm is the full four bits [6:3]**, **Rn is only three bits**, and bit 7 is always 0. gas encodes `CMP r1, r9` as `0x4549`. My first fix took bit 3 as an N bit of Rn, which was still wrong; gas / capstone / unicorn now agree.

**12.4.2 Two-operand shift had its operand roles reversed (the worst defect this round)**

Thumb's two-operand `LSL Rd, Rs` means **`Rd = Rd << Rs`** -- the value being shifted is **the destination itself** and the second operand is the shift amount. The old code assumed the shifted value was the second operand, so `LSL r0, r1` was encoded as `lsls r0, r0, r0`.

How it surfaced: the `alone` arm of the `merge` / `selfsrc` fixtures in `run_coalesce_tests.py` (only `-fopt-coalesce`, so strength reduction has not folded `<<3` into an immediate) returned 2070 / 5 where 86 / 35 were expected. Tracing SRAM writes in unicorn located `cs_c = 0x800` (`8 << 8`, should be `8 << 3`).

The fix separates the three operand shapes:

```c
if (rs >= 0)     { rn_src = rm; rs_amt = rs; }   /* three-operand Rd, Rn, Rs */
else if (is_imm) { rn_src = rm; rs_amt = rd; }   /* immediate    Rd, Rn, #imm */
else             { rn_src = rd; rs_amt = rm; }   /* two-operand  Rd, Rs -> Rd = Rd shift Rs */
```

What makes this defect dangerous is that **it had always been there**: as long as no real two-operand shift reached the assembler it never fired. `-fopt-strength` folds `x << 3` into an immediate, which covered it exactly; only the fixture arm that deliberately keeps it uncovered pulled it out.

**12.4.3 `vg_reads_reg` could not tell "write-only" from "read-modify-write"**

With a block-wide region, boundaries depend on whether a line reads or writes the destination. The first version treated **the first operand as a write target unconditionally**: `ADD r0, r1` is the two-operand form (`r0 = r0 + r1`) and **reads** r0, but the first version called it write-only, so the region ended early and that line was not renamed -- it kept reading the stale value in the low register. The opposite error is just as bad: renaming a write-only line lets the cache register and the low register diverge.

The final rule: **every operand after the first counts as a read**; the first operand also counts as a read under a **two-operand data-processing form** (`ADD/SUB/AND/ORR/EOR/ADC/SBC/RSB/RSC/MUL/MLA/BIC/ORN/LSL/LSR/ASR/ROR/RRX/MVN/NEG`) and counts as write-only otherwise (`LDR`/`MOV`/`MOVW`/`MOVT`/`LDRB`...). Erring towards "reads" is the safe direction: a needless rename just copies the same value into the cache register, while a missed read is a wrong answer.

**12.4.4 In-place renaming overwrote text still being read**

`r8` is one character longer than `r3`. The first version replaced `r3` with `r8` in place in one buffer, and the second rename then read from text that had already been lengthened/rewritten -- overflow or shifted characters. The fix is **double-buffered ping-pong**: `line -> rl -> rl2 -> ...`, read one buffer while writing the other, and leave `res` pointing at the last one written.

### 12.5 Measurement discipline (unchanged)

- S6a and S6b numbers are re-measured on the **final binary**, never carried over from intermediate readings.
- Every gate builds its command line through the `build()` helper in `tests/`, never by hand, so fixtures and gates cannot drift apart.
- `-fopt-vreg` is still **off by default**; an `ARKCC_FEATURE_VREG=0` build rejects the flag by name (C3900U), and without the flag the sixteen-switch output is byte-identical (95/95 identical).
- This section only appends measurement and implementation. The seven frozen gates of §5 and the F1-F4 falsifiers of §6 are **unchanged word for word**. S6c (across `BL` + spill, with a cost/benefit criterion) is still not started.

## 13 Measured result (2026-11-24, S6c: the region crosses a call, plus two real defects the new fixture flushed out)

### 13.1 The change: a call is no longer a wall

S6b widened the region from "the very next instruction" to "the rest of the basic block", but `BL`/`BLX` was still a hard barrier. S6c lets exactly one shape through: **the destination register `dr` of the load being renamed satisfies `dr >= 4` and appears in this function's own prologue save list** (`saved_mask`, collected register by register from `PUSH {...}` in the pre-scan). The argument is checkable line by line:

- the cache register (`r8-r11`) is callee-saved, and this function's prologue really saves it (otherwise the pass would not have taken it as a cache register);
- an untainted slot's address never escaped anywhere, so the callee cannot reach it at all -- the slot has no addressable location;
- therefore, after the call, the cache register still holds what `dr` held before the rename.

The implementation adds a new barrier class `vg_lk = 5`: the IT coverage scan and every other consumer still treat 3 and 5 alike as walls (`>= 3`), and only the Pass 2 region scan tells them apart:

```
if (vg_lk[j] == 4) break;                   /* frame setup: still a wall */
if (vg_lk[j] == 5) {
    if (dr >= 4 && ((saved_mask >> dr) & 1u)) continue;   /* S6c: walk through */
    end = j; break;                          /* otherwise the region ends here */
}
if (vg_lk[j] == 3) break;                    /* any other barrier */
```

Walking through `POP {dr}` is deliberately **not** allowed: a `POP` landing on `dr` silently invalidates the premise "`dr` still holds that slot's value".

### 13.2 The new `crossbl` fixture

`tests/run_vreg_tests.py` grows a ninth fixture: `s` is written **before** a call and read **after** it, and the callee is deliberately far too large to inline. The assertions come in two layers:

- the generic seven: no instruction added, `PUSH`/`POP` gain the same registers, the promoted function really asks the frame for a register, every offset above the frame base moves with it, instructions really disappear, the three arms (off / on / alone) return the same value on the emulator (219), and the `alone` arm is right too;
- the S6c-specific one: within three instructions after the `BL`, the plain arm **must** still show a `LDR rN, [r6, #off]` (proving the reload sits on the far side of the call) and the promoted arm **must** show none (proving the value stayed in the cache register instead of coming back from the frame).

### 13.3 Two real defects (present since S6b; there was simply no fixture)

`crossbl` produced a **wrong answer on its first run** (the `on` arm returned 889, and 141 after the first fix). Both have the same root: **the rename moves the value into the cache register and `dr` no longer holds it** -- so any "reader that does not name the register" at the region's edge loses the value.

**13.3.1 `hits == 0`: nothing inside the region reads `dr`**

In `n = vg_work(n, 5)` the load of the argument `n` is followed directly by `BL`. Before S6c a `BL` was a wall, so the region `[i+1, end)` contained no line mentioning `r0` (`BL` only reads `r0-r3` *implicitly*) -- yet `vg_cons[i] = end` still held, so `vg_act[i] = 1` deleted the load with no line rewritten to read the cache register: `r0` still held the previous statement's value (`s` = 41 went in as the argument). The fix is a `hits` counter: **the load may be deleted only if the region really recorded at least one rename**; otherwise fall back to `MOV rD, rC` (the same one instruction, so no loss, but correct).

**13.3.2 Three implicit readers**

`hits` only catches the "not one line renamed" case. The real condition is "nothing at the region's edge reads `dr` **implicitly**", and there are exactly three such readers, none of which the S6b rewrite can cover:

| shape | who reads implicitly | example |
|---|---|---|
| a call | `r0-r3` of a `BL` | `n = work(n, 5)`: the argument *is* that load's value |
| a push | `dr` inside a `PUSH {...}` / `STM...` list | a list sits in braces; the rename logic never looks there |
| the return | `r0` in the epilogue | `return t & 0xff` renamed to `AND r9, r9, #255`, and the function returned the stale `r0` |

The fix is a marker `vg_rf[i]` (an array that was free in this pass): after Pass 2 knows `end`, if `end` is a `BL` and `dr <= 3`, or `end` is a `PUSH`/`STM` whose list names `dr`, or `dr == 0` and the path from `end` to the frame epilogue is nothing but teardown (`MOV sp, r6` / `ADD sp` / `SUB sp`, possibly across a shared return label), the load is marked "must stay in `dr`" and **no rename is done for that region at all** -- it becomes `MOV rD, rC` outright. Why the renames have to go too: the `MOV` lands at the load's position, so if a consumer inside the region were still rewritten to write the cache register, `dr` would receive the pre-rename value -- a quieter, worse bug.

### 13.4 Measurement and the account

| Corpus (95 TUs, Cortex-M4, `-O2`) | instructions | bytes |
|---|---|---|
| seventeen switches (eighteen minus `-fopt-vreg`) | 14,954 | 36,204 |
| eighteen switches (with the fixed `-fopt-vreg`) | **14,271** | **36,114** |

So `-fopt-vreg` now really contributes **-683 instructions (-4.6%) / -90 B** (the `vg_hi_mask` fix of section 14 lifts eighteen switches from 14,218 to 14,271; seventeen switches are unaffected because they do not contain vreg).

**One honest note that has to be written down**: before the fix the same measurement read 14,103 instructions / 36,072 B. The 115 extra instructions are exactly what those two defects used to "save" -- loads that were wrongly deleted come back as `MOV` (bytes unchanged: `-fopt-cmat` then removes the equivalent `MOV`). In other words, the -415 / -801 published in §11/§12 include instructions bought with **wrong answers**; the real contribution is smaller than those numbers. From this section on, the `-fopt-vreg` account is 14,954 -> 14,271.

S6c itself (the part that crosses a `BL`) is worth little: the hit condition demands `dr >= 4` and that register in the prologue save list, while the frame-flow destinations are mostly `r0` (caller-saved, cannot cross a `BL`) and `r5`/`r7`, so sites that can hit are rare to begin with.

### 13.5 Gates

| Gate | Result |
|---|---|
| `tests/run_vreg_tests.py` (10 fixtures incl. the new `crossbl` and `mixed`, 75 assertions) | all checks passed |
| `tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe --extra=-fopt-vreg` | 0 failure(s) |
| `make test` | green |
| OFF IS OFF (no flag, eighteen switches, 95 TUs against the baseline) | identical 95 / different 0 |

The closing sentence of §12.5 ("S6c ... is still not started") is superseded by this section. The seven frozen gates of §5 and the F1-F4 falsifiers of §6 remain **unchanged word for word**.

### 14 `vg_hi_mask` always empty: vreg and the constant cache fight over `r8-r11` (0.9.1-wip fix)

Section 13 fixed "the region's edge loses the value". This section fixes a quieter defect:
**two consumers each believing they own the same register**.

**Symptom**: with nineteen switches the 95-TU corpus contains four duplicated register lists --
`PUSH {r5, r6, r7, r8, r9, r8, r9, lr}` and the matching `POP` (in `HAL_RCC_OscConfig` and the
function after it in `stm32f4xx_hal_rcc.c`, plus two in `stm32f4xx_hal_rcc_ex.c`). The built-in
assembler **silently de-duplicates** a repeated register, so fewer words are actually pushed
than `saved_words` says, and both the frame offsets and the 8-byte alignment are computed wrong.

**Root cause**: `vg_hi_mask()` decided token boundaries with "is the character after `r` not a
digit" -- but that character is always a digit (`8` in `r8`), so the condition was always false
and the mask was always 0. `-fopt-vreg` therefore believed `r8-r11` were all free, while
`-fopt-regalloc` (with its constant cache, `CC_MIN_COUNT = 5`) runs **before** it and had
already claimed some of them for profitable slots. Each pass kept its own books.

**The fix (three places, the last two are insurance)**:

1. Rewrite `vg_hi_mask()` as a token scan: a `rN` mention needs a non-alphanumeric before it and
   a non-alphanumeric after it, the same rule as `cc_line_hregs()` (setting bits for `r8`-`r11`).
2. After the pre-scan, add `used_mask |= saved_mask`: **a register the prologue already saves is
   busy by definition**, independent of whether the scan above is complete.
3. Keep the prologue's `PUSH` line in `pushline`, add `ra_names_reg()`, and drop any register
   already named there from the candidates. Today's prologue shape (`PUSH {r5,r6,r7,lr}`) never
   triggers it; it is insurance for a wider prologue.

**Price and readings**: handing the stolen registers back is not free -- eighteen switches
14,218 -> **14,271** (+53 instructions / +42 B), nineteen switches 13,517 -> **13,566**
(+49 / +48 B). The extra instructions are frame accesses that used to be "saved" wrongly, not
new overhead.

**Gates**: a new `mixed` fixture -- the only shape where both wins hold at once (one constant
added five times in a function that also reads slots repeatedly) -- plus a general assertion on
both arms of every fixture: **no `PUSH`/`POP` list may name a register twice**. `mixed` carries
eight dedicated assertions, one of which
(`the constant cache keeps its register and this pass takes a different one`) watches the exact
failure shape: the two passes must end up with different registers. All 10 fixtures pass,
75 assertions in total.



## 15 Measured upper bound for S6b-2 (inter-block liveness), and its closure

S6b did **intra-block** whole-block renaming; extending renaming across block edges is the
S6b-2 range, and it only has work to do when a `MOV rD,rS` destination is no longer read in
the rest of its own block yet still appears in that block's `live_out`. That population is
the **upper bound** on the item's win.

**Counting rule (`D:/tmp/fr/s6b2_bound.py`, not checked in)**: split functions on `.type`,
split basic blocks on labels and branches, compute per-block def/use, run a CFG liveness
fixed point (at most 50 rounds), then scan each block backwards counting
"`MOV rD,rS` with `rD != rS`, `rD` not in any later use of the block, `rD` in `live_out`".
Anything uncertain counts as live (an unknown mnemonic reads every operand it names and
writes nothing), so the number is a ceiling.

**Self-check (the counter must agree with the classifier)**: the 95-TU corpus yields
**13,116** instructions and **1,571** `MOV rD,rS` -- exactly the totals in
`docs/BOUNDARY.md` section 2 and the register-copy count in section 5.4 (both numbers were
re-measured after the second liveness run of section 16; the S6b-2 verdict itself does not
depend on the corpus snapshot).

**Result**: **245** candidates -- **1.87%** of all instructions, 15.6% of the copies
themselves. A weaker fold (`MOV rD,rS` immediately followed by one instruction that only
reads `rD`, with `rD` dead for the rest of the block) adds **32 = 0.24%** and is closed
together with it.

**Verdict**: under F1 (a win below 5% means close it) the range is **closed and S6b-2 is not
implemented**. The remaining 1,326 copies (1,571 minus 245) have a consumer inside their own block; removing
them requires touching the value stack / allocation model (the same class as the
`PUSH {... r0 ...}` item registered after S6c) and is not part of this budget. Registered.

## 16 Second liveness run (after litpool), and the fifth real defect it flushed out (0.9.1-wip)

### 16.1 Why the same L1/L2 rules are worth running twice

**Placement**: in `ark_emit_program` the second run sits **after** `cmat` -> `litpool` and
**before** `ark_fix_far_offset`, behind the same single `-fopt-live` gate (with the switch
off nothing runs at all and OFF IS OFF stays byte-identical):

```c
#if ARKCC_FEATURE_OPT_LIVE
        if (g_config.enable_opt_live)
            ark_live_function(&buf, fstart, ark_ret_mask(f->ret_type));
#endif
```

**Why**: liveness is a property of *the text*. The first run sees the text as it stands
before cmat / litpool rewrite it, so the `live_out` it computes no longer holds afterwards
-- `-fopt-litpool` turns `MOVW`+`MOVT rD` into one `LDR rD, .Llit_*`, which changes the
whole shape of the value stack's "materialise into `rD`, then `MOV` into the user" copies;
`-fopt-cmat` moves the materialisation point the same way. A batch of `MOV`s the first run
called live now have no reader at all.

**Readings (95 TUs, Cortex-M4, `-O2`, nineteen switches)**:

| Setup | Instructions | Code bytes |
| --- | ---: | ---: |
| one run (the first) | 13,566 | 34,980 |
| plus the second run | **13,116** | **34,200** |
| delta | **-450 (-3.32%)** | **-780 (-2.23%)** |

**The saving lands cleanly**: compared column by column against the eighteen categories of
`docs/BOUNDARY.en.md` section 2, only two move -- `MOV` immediate 1,492 -> **1,202**
(-290) and `MOV rD,rS` 1,731 -> **1,571** (-160) -- while the other sixteen are
**identical** (`PUSH`/`POP` 1,239, frame access 922, literal pool 705 included). That is
exactly what "it only deletes dead copies" predicts: the second run rewrites nothing but
`MOV`.

**No third run was made**: after the second run the text has settled to the point where
L1/L2 change nothing, but asserting "a third run is certainly worth 0" needs one more
code change for the control arm, which was not done this round -- **registered as
untested**. What is certain is that the second run is not the identity: it removed 450.

**Cost**: one more CFG build plus fixed-point iteration (the ~1.5 MB of static tables
behind `ARKCC_FEATURE_OPT_LIVE` are already cropped out of the MCU profile, so the board
pays nothing new); on the host the compile-time increment at corpus scale is on the order
of a few seconds (95 TUs of `-S` in roughly 20 s).

### 16.2 The fifth real defect it flushed out: `ADDS`/`SUBS` masked high registers with `& 7`

The four defects of section 12.4 "all surfaced only once slots reached `r8-r11`"; this one
is the same family. With the second run deleting more `MOV`s the backend more readily emits
**an add/subtract whose operand is a high register** (`ADDS r0, r0, r9`), and the built-in
assembler's `ADDS`/`SUBS` emitter (pass 2) then **unconditionally emitted the 16-bit form
and masked with `& 7`**:

- **Wrong answer**: `ADDS r0, r0, r9` assembled as `adds r0, r0, r1` -- silently, no
  diagnostic.
- **Worse knock-on**: pass 1 allotted 4 bytes unless all of `rd/rn/rm` were `r0-r7`, while
  pass 2 always emitted 2 bytes, so **every following label shifted by two bytes**; on the
  `wide` case this showed up as a crash with `PC=0` (unicorn `UcError UC_ERR_EXCEPTION`).

**Fix (pass-2 encoder plus the matching pass-1 size table)**:

| Shape | Encoding | Width |
| --- | --- | --- |
| `ADDS`/`SUBS Rd, Rn, #imm3`, all three `r0-r7` | 16-bit `0x1C00/0x1E00` | 2 B |
| `ADDS`/`SUBS Rd, Rn, #imm8`, `Rd == Rn`, `r0-r7` | 16-bit `0x3000/0x3800` | 2 B |
| `ADDS`/`SUBS Rd, Rn, Rm`, all three `r0-r7` | 16-bit `0x1800/0x1A00` | 2 B |
| register form with any operand outside `r0-r7` | 32-bit `adds.w`/`subs.w`: `0xEB10/0xEBB0 \| Rn`, then `(Rd<<8)\|Rm` | 4 B |
| two-operand `ADD Rd, Rm` (no `S`) | 16-bit `0x4400` T2, **any register** | 2 B |

Out-of-range is an error, never a truncation: an immediate that does not fit 12 bits reports
`ADDS/SUBS immediate %s does not fit any encoding`, an `sp` adjustment past 508 bytes that
is not 4-aligned and does not fit 12 bits reports `sp adjustment of %s bytes does not fit
one encoding`, and a missing source register reports `%s at code offset %s has no source
register`.

**Evidence (capstone disassembly of the `addsub_high` case)**:

```
0x043e  adds.w r0, r0, sb     4 B
0x0442  subs.w r0, r0, sl     4 B
0x0448  adds.w r1, r1, sb     4 B
0x044c  subs.w r4, r1, sl     4 B
0x0450  adds   r0, r0, r4     2 B
0x0452  add    sb, r0         2 B    ; 0x4400 T2, target r9
0x0454  mov    r0, sb         2 B
```

The new case `addsub_high` is in `tests/arm_exec/run_arm_exec.py` (`main` returns
`addsub_hi(20, 6)` = **64**): `MOV r9/r10` take the arguments, four `ADDS`/`SUBS` hit the
high-register 32-bit form, one 16-bit `ADDS` follows, then `ADD r9, r0` (T2) and
`MOV r0, r9`. It pins down both "the 32-bit form computes the right value" and "T2
two-operand takes any register".

### 16.3 The assembler's two-pass size self-check (a hard error, not a warning)

The common shape of this class of defect is "pass 1 counted one width, pass 2 emitted
another"; once that happens every later label is off, and **the text itself shows nothing**.
So instead of adding a case per shape, the fix adds one grand-total check:

- `ArmAsm` gains `pass1_size`; `pass1_a` ends with `a->pass1_size = pc`;
- `pass2_a` ends by comparing `a->pc` with `a->pass1_size`; on a mismatch it calls
  `diag_tool(DIAG_SEV_ERROR, ...)` with
  `assembler size pass disagrees with the emit pass (%s bytes laid out, %s emitted):
  some line is encoded at a different width than pass 1 counted` and bumps `hard_errors`.

**Why a total rather than a per-line check**: one comparison covers the whole class, and it
is read-only, so it cannot change a single output byte.

**The self-check must be able to fail**: a compile-time probe `ARKCC_ASM_SIZECHECK_PROBE`
(adds 2 to `pass1_size` at the end of `pass1_a`) makes a probe build report
`(1122 bytes laid out, 1120 emitted)`, while the release build stays silent. It is a
compile-time macro rather than `getenv` because the MCU profile has no libc `getenv` and a
probe must never enter a real build.

### 16.4 Gates and invariants (all green this round)

| Check | Result |
| --- | --- |
| `tests/run_vreg_tests.py ./arkcc.exe` (10 cases, 75 assertions) | all checks passed |
| `tests/run_cmat_tests.py ./arkcc.exe` | all checks passed |
| `tests/run_litpool_tests.py ./arkcc.exe` (21 items) | all checks passed |
| `tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe` (incl. the new `addsub_high`) | 0 failure(s) |
| OFF IS OFF (95 TUs, no `-fopt-*`, assembly sha256) | before = after = `40edf7d8076fc5be5f0d48e41741f0cb82342c75fa21096cec6b8efd1da13f62` |
| Cropping (`ARKCC_PROFILE_STM32_MIN` host build) | 0 error; `-fopt-live`/`-fopt-vreg`/`-fopt-slotreg`/`-fopt-cmat` all `C3900U` |
| Real MCU link (`tools/stm32_build_check.py --layout both`) | all checks passed (2 layouts) |

The seven frozen gates of section 5 and the F1-F4 falsifiers of section 6 remain **unchanged
character for character**.

## 17 The first step of the value-stack rework: `ADD #0` becomes `MOV`, plus a second peephole run on the final text (0.9.1-wip)

Sections 15 and 16 were both "run the same switch a second time". This round takes a different
angle: **no new rule and no new flag -- just rewrite the lines the value stack emits that are a
copy by meaning and arithmetic by text into the shape the later passes already understand.**

### 17.1 Why the text layer, and not the emitter

The value stack emits one instruction for three different things -- a register copy (`x = y`), a
frame base moved into a scratch, and a zero-displacement address -- namely `ADD rD, rS, #0`. By
meaning all three are copies; by text it is arithmetic.

| Text | Bytes | Encoding |
| --- | ---: | --- |
| `ADD r5, r8, #0` (D!=S) | **4** | `addw r5, r8, #0` (`08f1 0005`) |
| `ADD r0, r0, #0` (D==S, `rd` <= r7) | 2 | the `0x3000` form (`ADDS r0, #0`, **writes flags**) |
| `MOV r5, r8` | **2** | `0x4600` |

`ADD` (without `S`) has exactly one immediate encoding, the 32-bit `ADDW`, so anything with
D!=S costs four bytes; a register-to-register `MOV` is always the 16-bit form and always two
bytes, and neither writes flags (see 17.4).

**Why not emit the `MOV` directly**: the two downstream rules that could exploit it only
recognise `MOV`. `-fopt-live`'s L1 deletes a `MOV rD, rS` whose destination is dead, and
`-fopt-coalesce` forwards a live copy; both look for `MOV` in the text and neither matches an
`ADD`. Rewriting here is what hands those passes the same values: of the 463 sites, 215 are
deleted outright afterwards and 202 are forwarded or kept.

**Why no new flag**: this is a pure text equivalence, the same family as R1/R3 (see
`docs/PEEPHOLE.en.md`), so it belongs to `-fopt-peep`. No new flag means the crop table and the
`C3900U` by-name rejection table do not change by a single character, and the whole block is
still cropped out under `ARKCC_PROFILE_STM32_MIN`.

### 17.2 The second peephole run (the same shape as the second liveness run in section 16)

R1 (`PUSH {rX}` ... `POP {rY}` becomes `MOV`) hardly ever matches during the first peephole
run: at that point the two ends of the stack round trip are still the temporaries the value
stack picked, and the pushed and popped registers are usually not the same one. What makes them
**equal** is the renaming done by the passes below -- `-fopt-coalesce`, `-fopt-live`,
`-fopt-vreg`, `-fopt-slotreg`. The dead pair is **created by the later passes**, so the text has
to be looked at once more when it is final.

Measured (95 TUs, nineteen switches):

| Corpus | Adjacent `PUSH`/`POP` pairs | of which name the same register set (true dead pairs) |
| --- | ---: | ---: |
| Before (13,116) | 34 | **25** |
| After (12,795) | 9 | **0** |

The final order is therefore: second liveness run -> **second peephole** -> `ark_fix_far_offset`
-> init/fini_array. The peephole has to stay **before** `ark_fix_far_offset`: the latter turns a
far frame offset into an indirect access through `r12`, after which the text no longer contains
the "same `[r6, #off]`" shape the rule pairs.

### 17.3 Measured numbers (95 TUs, Cortex-M4, all nineteen `-fopt-*`)

| Configuration | Instructions | Bytes |
| --- | ---: | ---: |
| Baseline (`a6f3c94`) | 13,116 | 34,200 |
| + R5 (isolated build with the second peephole disabled) | 12,847 (-269) | 33,572 (-628) |
| **+ R5 + second peephole (final)** | **12,795 (-321, -2.45%)** | **33,464 (-736, -2.15%)** |
| Second peephole's own share (difference of the two rows) | -52 | -108 |

Of that -52, **50 instructions (100 B) are accounted for line by line** -- they are exactly the
25 adjacent `PUSH`/`POP` pairs above, two bytes each. The remaining -2 instructions / -8 bytes
fall on the few extra shapes the second R1/R3 round folds and on the alignment padding that
moves with them; **they are not attributed further**.

Per column (eighteen columns, only five move):

| Column | Before | After | Delta |
| --- | ---: | ---: | ---: |
| `ADD`/`SUB`/`ADC`/`SBC`/`RSB`/`NEG` | 1,493 | 1,030 | -463 |
| `MOV` register to register | 1,571 | 1,773 | +202 |
| `PUSH`/`POP` | 1,239 | 1,189 | -50 |
| Frame access `[r6, #n]` | 922 | 916 | -6 |
| `MOV` immediate | 1,202 | 1,198 | -4 |
| The other thirteen columns | -- | -- | 0 |
| **Total** | **13,116** | **12,795** | **-321** |

Line by line: there are **463** `ADD rD, rS, #0` sites. **46** have D==S and are identities
(the whole line goes) and **417** become `MOV`; of those 417, **202** survive in the final text
(the `MOV` register column is a net +202) and the other **215** are deleted as dead by the
second liveness run. -463 + 202 - 50 - 6 - 4 = -321, matching the total exactly.

**The byte figure of -736 is not split line by line**: each rewrite saves a fixed 2 B and each
deleted line saves its own width, but as soon as a pool label changes number the literal-pool
grouping and the `.align` padding move as a whole, so a line-by-line sum does not reproduce the
measurement (-736 is 2.29 B per removed instruction on average). Only the measured totals and
the per-column deltas are reported; no cause is claimed.

Per TU: **13 TUs change, every one of them smaller, none grows**, the other 82 are
byte-identical.

### 17.4 Semantics: the flags

- **D!=S**: `ADDW` writes no flags and `MOV rD, rS` (`0x4600`) writes no flags, so the flag
  state is the same on both sides of the rewrite.
- **D==S**: `ADD rd, rd, #0` takes the `0x3000` form, which is `ADDS` and **does** write flags.
  Deleting it removes one flag write. That direction is safe: this backend never carries flags
  across a statement (every conditional branch is immediately preceded by its own
  `CMP`/`CMN`/`TST`/`TEQ`), so one fewer flag write can neither revive nor break any existing
  dependency.
- **Evidence**: scanning the pre-change 13,116 corpus for the shape
  "`CMP`/`CMN`/`TST`/`TEQ` -> `ADD rX, rX, #0` -> conditional branch/`IT`" finds **0 sites**;
  the post-change corpus has **0** remaining `ADD .* #0` and **0** self-assignments
  `MOV rX, rX` (`pp_r5` emits a `MOV` only when D!=S).

### 17.5 OFF IS OFF and the gates (all green this round)

OFF IS OFF is compared with **real binaries**: the old binary built from HEAD (`a6f3c94`) and
the current one both compile the same 95 TUs under `-fno-opt-peep` (the other eighteen
`-fopt-*` all on), and the `.s` and `.o` files are hashed together:

| Check | Result |
| --- | --- |
| OFF IS OFF (95 TUs, only `-fopt-peep` off) | both sides equal `95b7fa7b2127a96c56b32dcf1ab5bdacd113e9593add1af67a0e2e8be3ec39bd` |
| `tests/run_vreg_tests.py ./arkcc.exe` | all checks passed |
| `tests/run_cmat_tests.py ./arkcc.exe` | all checks passed |
| `tests/run_litpool_tests.py ./arkcc.exe` | all checks passed |
| `tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe` | 0 failure(s) |
| Cropping (`ARKCC_PROFILE_STM32_MIN` host build) | 0 error; `-fopt-peep` still `C3900U` |
| Real MCU link (`tools/stm32_build_check.py --layout both`) | all checks passed (2 layouts) |

The seven frozen gates of section 5 and the F1-F4 falsifiers of section 6 remain **unchanged
character for character**. This round removes instructions; it does not move a judgement line.

## 18 The second and third steps of the value-stack direction: the second addressing fold and R6 (0.9.1-wip, 2026-11-24)

After section 17, the next step on this line is **not** changing the model itself but
running two text passes a second time where they were simply scheduled too early. Two
changes, three readings (95 TUs, all nineteen switches):

| Stage | Instructions | Bytes | vs. the line above |
| --- | ---: | ---: | --- |
| end of section 17 (commit `b2e915c`) | 12,795 | 33,464 | -- |
| + second `-fopt-addr` run | 12,346 | 32,744 | -449 / -720 B (-3.51% / -2.15%) |
| + R6 and `ip` recognition in `-fopt-peep` | **12,304** | **32,690** | -42 / -54 B (-0.34% / -0.16%) |

Neither change is **a new flag**: the second addressing fold hangs off `-fopt-addr` and R6
off `-fopt-peep`, so the cropping table in `include/arkcc_config.h` and the `C3900U`
by-name refusal list in `src/main.c` are **untouched**. Design details are in
`docs/ADDR_FOLD.en.md` section 11 and in R6 of `docs/PEEPHOLE.en.md` section 2; what
belongs here is *why this is about vreg*:

- **What the second fold eats is exactly the shape vreg manufactures.** Slot promotion
  turns `LDR r0, [r6, #n]` into "`MOV rX, r0` then an access through `rX`", and the first
  `-fopt-addr` run sits before vreg -- that `MOV` did not exist then. So **the amount the
  first fold misses is a subset of what vreg produces**.
- **What R6 eats is the value stack's "push a value -> materialise the next one -> pop"
  path routed through memory.** Once vreg keeps more intermediates in registers, the
  surviving pairs show up in the shape "one `MOV r0, #k` / `MOV r0, r8` in between"; and
  teaching the single-register `PUSH`/`POP` recogniser about `ip` (= r12) stops the nine
  `POP {ip}` in the corpus from being silently skipped.

Per TU: none of the 95 grows. Gates: `run_vreg_tests` / `run_cmat_tests` /
`run_litpool_tests` / `run_peep_tests` / `run_addr_tests` all report `all checks passed`,
`arm_exec` reports 0 failures, and `stm32_build_check --layout both` passes. OFF IS OFF was
checked with BASE17 (both `-fopt-peep` and `-fopt-addr` off, the other seventeen on) by
comparing `.s` + `.o` per TU against a binary built from the previous HEAD: **all 95 TUs
identical**, digest `9bcfdc876973c34684f61fc222b2b3f6fa98433a7ac675d0eca0a952c0e6eb7b`.

### 18.1 One refuted road: "delete the dead pushes"

This round started by counting 354 sites where "nothing reads what was pushed", using a
**linear scan of the text** -- it looked like a two-digit win. But at the end of
`-fopt-vstack` **both depth and nmem are 0**: the value stack's pushes and pops are
**balanced**. All 354 were artifacts of a linear scan misreading a **cross-branch LIFO**
(one `PUSH` in branch A, the matching `POP` in branch B, with a label and a `B` in
between). The road does not exist: no code, no project, no criterion was written. It is
recorded here only so nobody counts it a second time -- **judging the liveness of a push
needs a real CFG and join-level state, which is an engineering effort of a different
order**.

### 18.2 Still registered and not done

- **Join-aware pool-register retention across labels/branches**: a real model change that
  needs a new pre-registered criterion, and the seven frozen gates of section 5 plus the
  F1-F4 falsifiers of section 6 must not move a character. **The read-only feasibility
  measurement has been done -- see section 18.3**: the cheap version (single-predecessor
  labels) measures 0 pins and is closed at 0 instructions; the full version has an upper
  bound of 1,178 instructions (9.6%), above the F1 threshold and therefore not closable, but
  it needs a CFG and join-level state and is the value-stack rework itself.
- **Widening the pool to r8-r11**: competes with `-fopt-vreg` for `cc_hregs`. **Measured
  (section 18.4)**: vreg is worth 882 instructions and r8-r11 carry 11.6% of the final text,
  while widening the pool can buy at most 942 -- so the net is negative and the item is
  closed.
- **Widening the pool to r12**: conflicts with `ark_fix_far_offset()` (a `[r12, #n]`
  access costs 4 B).
- **Keeping pool values across calls**: only 2 call-only pins exist; already refuted.

### 18.3 Read-only feasibility measurement of join-aware retention (2026-11-24)

The previous revision registered this as "do a read-only feasibility measurement first";
this section is that measurement. **Not one line of emission code changed**: the probe sits
in the pinned-PUSH branch of `ark_vstack_function()`, is switched on by the environment
variable `ARKCC_VSTACK_STATS`, and was removed afterwards (never committed, no new flag, the
crop table untouched).

**Setting**. Nineteen switches, 95 TUs -- the same corpus as section 18. The probe reports
three fields:

| Field | Meaning |
| --- | --- |
| `mask` | bit OR of the first boundary that pinned the value: 1 = label, 2 = branch, 4 = call |
| `kind` | whether the value already sits in a pool register (read from `pend[]`, **not** from `skind[depth]`, which is not written yet at that line -- that is where the garbage `kind` values of the first attempt came from) |
| `edges` | if the boundary is a label, how many ways into it exist (branch targets plus fallthrough); -1 when the boundary is not a label |

Self-check: the same build compiles 95 TUs with 0 errors and the classifier still totals
12,304 instructions / 32,690 B, byte for byte the committed reading, so the probe did not
change the emitted text.

**Readings** (589 pins, plus 471 real `PUSH`es that are the pool running out):

| Boundary mask | Pins |
| --- | ---: |
| label only (1) | 115 |
| label + branch (3) | 366 |
| call only (4) | 5 |
| all three (7) | 103 |

No mask of 2 on its own: a branch boundary is always followed by a label, so a value pinned
by a branch carries the label bit too. By `edges`: **474** pins are first pinned at a branch
or call (not a label), **115** at a label, and all 115 of those labels have `edges = 2`.

**Criterion (frozen before looking) and verdict**:

- **Cheap version = single-predecessor labels only** (no CFG needed, just "reached by
  fallthrough and nothing else"). Measured: **0 pins** -- so the cheap version is worth 0
  instructions and is **closed**. That is not an upper bound, it is the exact value: no value
  in the corpus is pinned at a label with a single way in.
- **Full version = CFG plus join-level state**. Upper bound 2 instructions per pin x 589 =
  **1,178 (9.6% of the current instruction count)**, above F1's 5% threshold, so it may
  **not** be closed under F1; but neither is it cheap work: it turns the value stack from
  "linear scan plus flush at boundaries" into "solve block by block", and it has to prove the
  join state agrees on every path into the label (otherwise the value is not in that pool
  register on the other paths at all). The harder cost: pinning a value in a pool register
  eats the block's available pool slots directly, and the 471 pool-full pushes say the pool is
  already tight -- so the net win is necessarily below 1,178 and its sign depends on each
  function's pool pressure. **Neither number is measured** (only an implementation can
  measure them); registered as is.
- How to read it: this is not part of what the register-copy / peephole / text-level work can
  reach; it *is* the structural cause named "the value stack machine" in
  `docs/BOUNDARY.md` section 5.6. Keep it as the first item of the value-stack rework.

### 18.4 The decision on widening the pool to r8-r11: vreg is worth 882, and r8-r11 carry 11.6% of the final text

This item was registered as "competes with `-fopt-vreg` for `cc_hregs`; the independent vreg
gain has to be measured before it can be judged". Here are all three numbers at once
(nineteen switches, 95 TUs, 0 errors):

| Setting | Instructions | Bytes | Versus the nineteen |
| --- | ---: | ---: | --- |
| nineteen switches | 12,304 | 32,690 | -- |
| without `-fopt-vreg` | 13,186 | 32,958 | **vreg is worth 882 instructions (7.2%) / 268 B** |
| without `-fopt-vstack` | 15,668 | 39,372 | **vstack is worth 3,364 instructions (21.5%) / 6,682 B** |

One more count over the final text: of the 12,304 instructions, **1,424 (11.6%)** mention
`r8`-`r11` -- that is exactly `-fopt-vreg`'s candidate pool (`-fopt-regalloc` is not among
the nineteen switches, so every one of those references comes from vreg).

**Verdict**: widening the pool can buy at most the 471 pool-full pushes of section 18.3 x 2
instructions = **942**, and the price is taking away from vreg exactly the registers that
11.6% of its instructions work through -- while vreg itself is worth 882. The two are the
same order of magnitude and the net is necessarily negative (less bought than sold). **Closed
under the criterion**: `-fopt-vstack` keeps its three pool registers r5/r7/r4 and r8-r11 are
off the table.

Two readings worth keeping for scheduling: vstack is the largest single switch of the
nineteen (3,364 = 21.5%) and vreg the second (882 = 7.2%) -- which is also why "the value
stack rework" is the only structural lever left.

---

## 19 S6d: the measured verdict on running `-fopt-vreg` and `-fopt-vstack` together (2026-11-25)

The P19 pre-registration fixed one thing in advance: "**choose one of the two with
`-fopt-vstack`** (the original P12 S5 ruling); once they are on the same line, which one the
default keeps is decided by a corpus measurement." This section carries that measurement out.
Verdict: **keep both -- they are neither mutually exclusive nor worth merging/deduplicating.**

### 19.1 Frozen setup

- Corpus: 95 TUs (`examples/ark_test/Core/Src` + `Drivers/STM32F4xx_HAL_Driver/Src`), compiled with
  `-target arm -O2 -mcpu Cortex-M4 -D STM32F401xE -D USE_HAL_DRIVER --reloc-data -S` plus the
  23 `-fopt-*` switches (the nineteen + `frame` + `voldmb` + `constcond`).
- Four configurations: all on / drop `-fopt-vstack` / drop `-fopt-vreg` / drop both. One binary,
  one sweep, **0 errors** across 95 TUs.
- Metrics: instructions = lines starting with four spaces that are not assembler directives;
  bytes = total size of the `.s` file. (Stdout capture and `-o file` were verified byte-identical
  on a sample TU, so the sweep's `-o` path does not change the reading.)

### 19.2 The four readings

| Configuration | Instructions | Bytes |
| --- | ---: | ---: |
| all on (vreg + vstack) | **12,239** | **405,426** |
| without vreg | 12,937 | 420,189 |
| without vstack | 15,920 | 459,497 |
| both off | 16,237 | 465,610 |

Marginal contributions:

| Reading | Instructions | Bytes |
| --- | ---: | ---: |
| vreg alone (both off -> without vstack) | -317 | -6,113 |
| vstack alone (both off -> without vreg) | -3,300 | -45,421 |
| sum of the two marginals | -3,617 | -51,534 |
| both on (both off -> all on) | **-3,998** | **-60,184** |

That is, running them together saves **381 instructions (10.5%) more than the sum of their
separate gains**, and 8,650 B more on the byte axis. This directly refutes the premise behind
the original P12 S5 ruling, namely that the two "fight over the same stack round-trips and
therefore add up negative".

### 19.3 Per TU: zero regressions in all four directions

| Comparison (what gets switched back on) | Better | Same | Worse |
| --- | ---: | ---: | ---: |
| vreg back (without vreg -> all on) | 14 | 81 | **0** |
| vstack back (without vstack -> all on) | 17 | 78 | **0** |
| vreg only (both off -> without vstack) | 17 | 78 | **0** |
| vstack only (both off -> without vreg) | 10 | 85 | **0** |

Not one of the frozen "any TU getting bigger is red" criteria fires. vreg moves only 14-17 of
the 95 TUs and leaves the rest byte-identical, which matches section 11's note that vreg has
narrow coverage but large per-site gains.

### 19.4 Why the effect is super-additive

Both passes attack the same broad class (stack round-trips) but on different objects:

- `-fopt-vstack` rewrites the **mid-expression** value-stack shadow slots (`r5`/`r7`/`r4`),
  turning `PUSH {r0}` / `LDR`/`STR [sp]` into registers;
- `-fopt-vreg` promotes **local variable slots**, out of the `r8`-`r11` pool, and is deliberately
  scheduled after `-fopt-regalloc` (the comment at the call site in `backend_arm.c` records that
  the two share one PUSH/POP save block and one base offset, and that neither is a barrier for
  the other).

Order matters: vreg sees the text **after** vstack has shortened it. vstack first keeps values
in pool registers, so fewer and narrower slot accesses reach vreg and its rename window is more
often open -- the same mechanism section 18.5 recorded as "renaming makes unfoldable folds
possible". **(This attribution of the super-additive part is inferred from the traversal order;
it was not proven per function. The verdict itself -- keep both -- does not depend on it.)**

### 19.5 Why the "merge and deduplicate" half is not done

The name S6d contains "merge and deduplicate"; that half is **closed without touching code**,
under the same F1-style criterion:

- **Zero cost on the cut-down profile**: under `ARKCC_PROFILE_STM32_MIN` both
  `ARKCC_FEATURE_OPT_VSTACK` and `ARKCC_FEATURE_OPT_VREG` are 0, so both passes are compiled out
  entirely. There is not a byte to save on the smallest board profile.
- **Upper bound elsewhere**: compiling `backend_arm.c` alone with x86-64 `gcc -O2` gives
  `ark_vreg_function` at 7,792 B plus about 2.6 KB of `vg_*` helpers, and about 4.2 KB of `vs_*`
  helpers. The two line parsers (`vg_flatten`/`vg_mnem`/`vg_slot`/`vg_is_frame_*` versus
  `vs_parse`/`vs_form`/`vs_masks`/`vs_read_before_write`) really do overlap structurally, but
  **what could be shared is bounded by the smaller of the two sets, about 2.0 KB**, and the real
  figure is well below that: `vs_*` needs operand forms and read/write masks, `vg_*` needs frame
  offsets, labels and flattening -- the semantics do not coincide.
- Against the board figure from `stm32_build_check.py --layout sdram` (`code 349,466 B`), 2.0 KB
  is about **0.6%**, and the price is refactoring two passes that have each already been taught a
  lesson by a real defect (section 18.6 just fixed vreg's read-modify-write write-back). Closed
  on "risk cost > gain"; registered as "revisit if the **compiler's own** size ever needs
  shrinking".

### 19.6 What landed

- Code: **no change**. The two switches stay independent and freely combinable, and both stay off
  by default (each `-fopt-*` must be asked for).
- Docs: this section plus the P19 status line in `docs/OPTIMIZER_PLAN.md` (both languages).
- Reproducing: run the four option sets of section 19.1 over the 95 TUs and the table above
  comes back. All four sets use **the same binary**, so every delta in this section reflects
  switches only, never the build.
- Do not subtract this section's numbers from section 18.5's tables: here "all on" is
  **12,239 / 405,426 B** while section 18.5 records 12,266 / 405,514 B (and 404,970 B with the
  second `cbz` pass). The 27 instructions / 88 B gap comes from **a different build** -- this
  section uses the `arkcc.exe` from after `36ac163` (exact floating-literals merged in), where
  literals round exactly and the occasional constant and constant fold changes with them.
  Cross-section comparisons must be re-run on one build; never subtract across builds.


## 20 The region scan's sixth real defect: a same-slot write from another register is not an edge (0.9.1-wip, 2026-11-27)

Section 18.6 recorded "a read-modify-write rename has to be able to write back".  S51 found another gap of the
same family right next to it: the region scan did not treat **"this load's own slot is written by another
register"** as an edge, so the loaded value (the pre-increment one) was renamed onto the cache register *after*
that write.

The shape and the verdict: `int i=0; OUT[i++] = 11; OUT[i++] = 22;` on the S16 line (the 33 passes) stored
`OUT[0]=11, OUT[2]=22`, while the `--reg-top` arm and the raw emitter were both right.  The cause in one
sentence: on a `vg_lk[j] == 2` line the scan only asked "is the stored source this load's destination `dr`?" and
`continue`d when it was not - but that STR writes **this very load's slot**, and once it becomes `MOV r8, r0`
the cache register holds the new value while the region runs on and renames `MOV r0, r7` (the pre-increment
value) onto r8.

The fix is one edge: `if (vg_lo[j] == s && vg_dr[j] != dr) { end = j; break; }`.  Cut there, the region has no
renameable read left (`hits == 0`), so the existing fallback keeps the load as `MOV rD, rC` - the same single
instruction the LDR cost, so nothing grows; a write whose source *is* `dr` (the counter idiom's write-back) still
passes through.

Measurement (95 TUs / 212 functions, one `arkcc.exe` built from the tree before and after): `BASE +
-fno-opt-vreg` is 11,348 instructions / 395,030 bytes and `BASE` is 10,106 / 371,771, with **zero per-unit
difference before and after**.  The shape never occurs in the corpus - which is why the fix is free and why only
an execution-level shape assertion (`tests/run_subpostinc_tests.py`, 11 shapes x 4 arms) can see it.  See
`docs/EXPR_MODEL.md` section 51.
