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
