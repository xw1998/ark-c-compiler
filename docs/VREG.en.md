# S6 pre-registration: IR-level virtual register allocation (`-fopt-vreg`, not implemented)

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
