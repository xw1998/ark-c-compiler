# `-fopt-live`: delete the copies only liveness can see

English | [中文](LIVE.md)

> In one sentence: `-fopt-copyprop` only sees one basic block. The copies that
> actually dominate real code are the ones staged around a branch and the ones
> that materialise an address into a scratch register only to copy it into a
> variable. `-fopt-live` builds a control-flow graph per function, iterates
> register liveness to a fixed point, and then applies four rewrite rules. On
> the full HAL corpus it removes another **1,329 instructions (−5.70%)** and
> **3,000 bytes (−5.40%)**.

---

## 1. Why

Both rules of `-fopt-copyprop` (see `docs/COPYPROP.md`) deliberately look no
further than one straight-line block: rule A only deletes a write that is
provably overwritten in the same block, rule B only pushes a copy into its
immediately following consumer. That is exactly why it can be proved safe --
and exactly its ceiling.

What is left in the corpus has a very regular shape:

```asm
    MOVW r0, #14384        ; the address of a global lands in r0
    MOVT r0, #16386
    MOV  r5, r0            ; and is copied into the value-stack pool register r5

    MOV  r7, #0            ; the index 0 is staged in r7
    MOV  r1, r7            ; then copied into r1 for the address
    LDR  r0, [r5, r1, LSL #2]
```

Answering "does anybody read `r5` later" or "is `r7` used only as an index"
requires knowing whether the value is **live after this point**, and liveness
requires a control-flow graph. IAR's counterpart is
`CgRegalPhase` / `CgLiverangePhase` (see `c_compiler/iar/docs/06-optimizer.md`
and `08-backend-passes.md`). arkc takes only its first layer here: **no
register allocation, only deletion and folding driven by liveness**.

## 2. The four rules

Every rule has the same precondition: `rD` is not live **after** the
instruction (`la[j]` is false) and the instruction does not write it back.

### L1 Dead copy

> `MOV rD, rS` or `MOV rD, #imm` with `rD` not live afterwards ⇒ delete the
> line.

`MOV` writes no condition flags, so deleting it changes neither a value nor a
flag. The only difference from copyprop rule A is the **scope**: there "after"
means the rest of the straight-line block, here it means the whole function --
which is what lets it delete staging that crosses a label or a branch:

```asm
    MOV r1, r7          ; nobody reads r1 after .L_f_2
.L_f_2:
    ...
    MOV r0, r5          ; a useless move before the function exit
    B   .L_f_0
```

### L2 Fold the copy into its consumer

> `MOV rD, rS` followed (padding only) by the single instruction that reads
> `rD`, where `rD` is not live after it and the instruction does not write
> `rD` ⇒ that instruction reads `rS` instead and the copy disappears.

Unlike copyprop rule B this does **not** require a three-operand ALU form; it
only requires "reads `rD`, does not write `rD`". So `LDR rD, [rD, ...]` (with
`rD` as the address base), `CMP rD, X` and `STR rD, [...]` all qualify.

```asm
    MOV r1, r4
    LDR r7, [r7, r1, LSL #2]     →     LDR r7, [r7, r4, LSL #2]
```

### L3 Drop a zero index from the addressing mode

> `MOV rT, #0` followed by an instruction in which `rT` appears **only** as an
> address index, with `rT` not live afterwards ⇒ drop the index:
> `[rB, rT]` / `[rB, rT, LSL #n]` becomes `[rB]`.

```asm
    MOV r0, #0
    MOV r1, r0                   ← already folded by L2
    LDR r0, [r5, r1, LSL #2]     →     LDR r0, [r5]
```

In the corpus the two rules always fire together: L2 folds `MOV r1, r7` into
`LDR ..., [r5, r7, ...]` and L3 then removes the zero index entirely. That is
why the `zero` fixture of the gate loses four instructions (two per staged
zero) rather than two.

### L4 Materialise a constant straight into its destination

> `MOVW rD, #lo` / `MOVT rD, #hi` / `MOV rX, rD` with `rD` not live after the
> copy ⇒ `MOVW rX, #lo` / `MOVT rX, #hi` (IAR's `DefIntoMove`).

```asm
    MOVW r0, #14384
    MOVT r0, #16386
    MOV  r5, r0            →     MOVW r5, #14384
                                 MOVT r5, #16386
```

This is the biggest single block in the corpus: the baseline text contains
**712** such triples, each worth one instruction.

## 3. How the analysis works

### 3.1 Building the graph

The unit is the **already emitted function text** (`from` = first line of the
function, `b->len` is exactly the end of it):

1. parse each line into a `cp_ins` (reusing copyprop's `cp_parse`), skipping
   `.loc` / `.file` / blank lines;
2. every label opens a block; `B<cond>` / `CBZ` / `CBNZ` / `IT` split blocks by
   their semantics;
3. edges: an unconditional `B` has only its target; a conditional branch has
   "target + next line"; `POP {..., pc}` / `BX lr` / `BL` have no successor.

### 3.2 Liveness

After summarising `use` / `def` per block, iterate

```
out = ∪ succ.in
in  = use ∪ (out − def)
```

to a fixed point (at most `LV_MAX_BLOCKS` = 1024 blocks). Then walk each block
backwards to get "which registers are live after line j", i.e. the per-line
`la[j]`.

### 3.3 The refusal list (safety boundary)

| Case | Treatment | Why |
| --- | --- | --- |
| `BL` / `BLX` | reads `r0–r3`, writes `r0–r3` / `r12` / `lr` | argument and return conventions are invisible in the operands |
| a block with no successor | `out` = `r0–r3` | function exit; the caller reads the return value |
| `CBZ` / `CBNZ` | first operand is a read | they do not look like `B<cond>`, easy to miss |
| `pc` / `lr` / `sp` | 15 / 14 / 13 | `POP {..., pc}` is an exit, so is `BX lr` |
| anything inside an `IT` block | never rewritten | conditional execution: "not live" would have to hold on the not-taken path |
| rewrite target | never `r6` / `sp` / `lr` / `pc` | `r6` is this backend's frame pointer and the frame relies on it |
| two-operand ALU forms | the first operand is **also a read** | see §4.1 |
| every rewritten line | compared byte-for-byte with the original first (`lv_same`) | a truncated operand can never reach the output |

### 3.4 `LV_MAX_BLOCKS` and memory

The `LvBlock` table, the line table and the label table are `static` arrays
totalling roughly **1.5 MB**, so `ARKCC_PROFILE_STM32_MIN` sets
`ARKCC_FEATURE_OPT_LIVE` to 0 (see §9).

## 4. Three real defects the tests found

None of these is a design problem; each is a "can this ship" problem. They are
recorded in order because every one of them produces either a compiling program
with a different answer or a pass that silently never fires.

### 4.1 Two-operand ALU forms: the first operand is also a read

`LSL r0, r4` in the 16-bit encoding is `r0 = r0 << r4`; the two-operand forms of
`AND` / `ORR` / `MUL` / `ADD` / `SUB` / `LSR` / `NEG` are the same. The first
version treated `operands[0]` as a pure destination everywhere, so

```asm
    MOV r0, r5
    LSL r0, r7          ; really r0 = r0 << r7
```

was judged "`r0` is overwritten ⇒ the preceding `MOV r0, r5` is dead" and
deleted -- **a wrong answer**.

The fix is an explicit pure-destination whitelist `lv_dest_only()`
(`MOV*` / `MVN` / `NEG` / `UXTB` / `UXTH` / `SXTB` / `SXTH` / `REV` / `REV16` /
`REVSH` / `RBIT` / `CLZ`); for every other mnemonic the first operand is both a
write and a read.

After the fix the corpus deletion count fell from −474 to −98: most of those
376 instructions had been deleted by this bug. The `shift` fixture of the gate
(`1 << (x & 31)`) is the permanent control for it and must stay byte-identical.

### 4.2 `pp_trim` strips leading whitespace

The text helper `pp_trim` returns the line **without leading whitespace**. The
first `lv_rebuild` produced `"    MOV r0, r5"` (four spaces) and compared it
byte-for-byte with `pp_trim`'s result -- never equal, so L2/L3/L4 never fired and
only L1 worked. The symptom is "the numbers improve, but far less than
expected", which is easy to mistake for "the rules are weak".

Fix: `lv_rebuild` emits only the instruction (no indentation) and the output
path adds `asmbuf_puts(&out, "    ")`.

### 4.3 Comparison timing: compare before rewriting

The first version rebuilt the line **after** modifying the operands and then
compared with the original -- again never equal. The fix moves the comparison
into its own function `lv_same()`, called with the original operand snapshot
before anything is rewritten; L4 checks each of its three lines, L2/L3 keep a
`cp_ins origj = iv[j]` snapshot and compute `samej = lv_same(...)`.

### 4.4 Follow-up: `ADC` / `SBC` cannot become a three-register form

After `-fopt-live` was written, the ARM execution gate reported on
`stdlib/src/arm/aeabi.c` (64-bit addition):

```
arkcc: Error: ADC/SBC with three distinct registers (Rd=r1, Rn=r7)
        needs the 32-bit form, not supported
```

The root cause is the same class of folding inside `-fopt-copyprop` rule B:
`ADC rD, rD, X` folded into `ADC rD, rS, X` has three distinct registers, while
the 16-bit encoding **requires `Rd == Rn`** and this assembler does not emit the
32-bit form. Two fixes: drop `ADC` / `SBC` from `cp_op_ok()`'s whitelist, and add
`lv_rd_eq_rn()` to the L2 condition so consumers named `ADC` / `SBC` / `RSC` are
not rewritten.

Both had to be fixed together: fixing one still fails on the same source file
through the other pass.

## 5. Division of labour with `-fopt-copyprop`

| Aspect | `-fopt-copyprop` | `-fopt-live` |
| --- | --- | --- |
| Scope | one straight-line block | the whole function (control-flow graph) |
| Basis | local overwrite / adjacent consumer | liveness (`in`/`out` fixed point) |
| Copies it can remove | dead copies in the same block, three-operand ALU forwarding | dead copies across blocks, forwarding into any single-instruction consumer, zero indices, constant triples |
| Cost | one scan, no tables | ~1.5 MB of static tables plus iteration |
| Cropped build | off in `STM32_MIN` | off in `STM32_MIN` (tables too big) |

Order: copyprop first, live second. copyprop resolves what one look can resolve,
live then sees cleaner text and converges faster (at most four rounds per
function).

## 6. Measurements (full HAL corpus, 96 TUs / 93 valid, Cortex-M4, `-O2 --reloc-data`)

Baseline = the nine 0.9.1 switches
(`vstack addr strength cbz branch imm peep cbranch copyprop`),
23,304 instructions / 55,608 bytes:

| Build | Instructions | Code bytes | Change |
| --- | ---: | ---: | ---: |
| Baseline (nine switches) | 23,304 | 55,608 | — |
| + `-fopt-live` | **21,975** | **52,608** | **−1,329 (−5.70%) / −3,000 (−5.40%)** |

Against the original five-switch baseline (35,211 / 82,404) the cumulative
figure is −13,236 (−37.6%) / −29,796 (−36.2%).

Shape accounting: the baseline text contains **712** `MOVW/MOVT/MOV` triples
(all hit by L4, one instruction each); the remaining 617 instructions come from
L2 forwarding and the L3 zero-index folds it triggers.

The same function before and after (`D:/tmp/cbrLV/all_000.s` vs `lv_000.s`):

```asm
                              ┌─ baseline ─────────────────────────
                              │    MOVW r0, #14384
                              │    MOVT r0, #16386
                              │    MOV r5, r0
                              │    MOV r7, #0
                              │    MOV r1, r7
                              │    LDR r0, [r5, r1, LSL #2]
                              ├─ -fopt-live ───────────────────────
                              │    MOVW r5, #14384
                              │    MOVT r5, #16386
                              │    LDR r0, [r5]
```

Six lines become three, with exactly the same meaning: `r5` is the address and
`r0` receives the loaded value.

## 7. Where the code lives

`src/backend/arm/backend_arm.c`, its own `#if ARKCC_FEATURE_OPT_LIVE` section
(the text helpers and `cp_parse` are still shared with peep / copyprop under the
common guard).

| Function | Purpose |
| --- | --- |
| `lv_bit` | register number → bit mask |
| `lv_regs` | register set of a piece of text (whole tokens; `lr`/`pc`/`sp` recognised, `str0` not) |
| `lv_dest_only` | is the first operand a pure destination (§4.1) |
| `lv_rd_eq_rn` | does the mnemonic require `Rd == Rn` (§4.4) |
| `lv_branch_kind` | 0 none / 1 unconditional / 2 conditional / 3 call / 4 `BX`·`BLX` |
| `lv_rw` | read set and write set of one instruction |
| `lv_ends_block` | does the line have no successor |
| `lv_has_writeback` | does the addressing mode have a `!` writeback |
| `lv_rebuild` | instruction → text (no indentation, §4.2) |
| `lv_same` | byte-for-byte comparison before rewriting (§4.3) |
| `lv_repl_reg` | replace `rA` with `rB` inside an operand |
| `lv_drop_index` | remove `, rT` / `, rT, LSL #n` from an address operand |
| `lv_pass` | build the graph, solve liveness, apply the four rules; returns the change count |
| `ark_live_function` | at most four rounds until `lv_pass` returns 0 |

## 8. Gate (`tests/run_live_tests.py`, `make test-live`)

| Group | Assertion |
| --- | --- |
| 1 | **OFF IS OFF**: `-O2` and `-O2 -fno-opt-live` are byte-identical (1,220/1,220 B) |
| 2 | `dead` (L1): −2 instructions, `MOV rX, rY` 8 → 6, `MOVT` unchanged, labels 8/8 |
| 3 | `fwd` (L2): −2 instructions, `MOV rX, rY` 4 → 2, still one indexed `LDR` (base changed, form unchanged) |
| 4 | `zero` (L3): −4 instructions, indexed `LDR` 2 → 0, plain `LDR rX, [rB]` 0 → 2, `MOV rX, rY` 5 → 3 |
| 5 | `addr` (L4): −2 instructions, `MOV rX, rY` 3 → 1, `MOVT` 7/7 unchanged |
| 6 | **anti-over-deletion**: `shift` (`MOV r0, r5` + `LSL r0, r7`) stays byte-identical, 123 lines -- the permanent control for §4.1 |
| 7 | five fixtures × three arms (off / on / on-alone with no other pass) return the Python answer on the emulator (0 / 7 / 12 / 0 / 35) |
| 8 | label counts unchanged on every fixture |
| 9 | a cropped build (`-DARKCC_FEATURE_OPT_LIVE=0`) refuses `-fopt-live` by name (`C3900U`, rc=1) |
| 10 | the same cropped build still compiles without the flag (rc=0) |

The fixtures must be built with the full nine switches: the L3/L4 shapes come
from the value-stack pool registers and address materialisation and do not
appear without `-fopt-vstack` / `-fopt-copyprop`.

In addition `tests/arm_exec` runs every execution case with `--extra=-fopt-live`
(plus the other nine switches): **0 failures**. That run is the only way §4.4
was found -- the gate fixtures themselves never touch 64-bit addition.

## 9. Cropping

`ARKCC_FEATURE_OPT_LIVE` is set per profile in `include/arkcc_config.h`:

- `ARKCC_PROFILE_STM32_MIN` ⇒ `0`;
- host / cross builds ⇒ `1`.

A cropped build given `-fopt-live` reports
`Fatal error: C3900U: -fopt-live is not compiled into this build (rebuild with -DARKCC_FEATURE_OPT_LIVE=1)`
and returns 1 -- the same refusal semantics as every other `-fopt-*`.

## 10. Position in the pipeline

```
vstack → addr → strength → cbz → peep → copyprop → live → regalloc → fix_far_offset
```

Before `regalloc`: the slot rewriter ranks by access count and copies that are
already dead must not be counted. Both live and copyprop only rewrite text and
never change the frame shape, so their order is interchangeable (both preserve
semantics), but running copyprop first lets live converge faster.

## 11. Not done (registered)

- **Real local-variable register allocation.** Today the pass only deletes and
  folds; it never keeps a variable resident in a register. That is the next big
  step and needs live ranges (`CgLiverangePhase`) plus conflict-graph colouring
  (AC5's `LSregalloc` + `graph_colour_twoclash`).
- **Interprocedural `cross-jump` / `cross-call`.** IAR's
  `EbkInterproceduralCrossJumpHelper` / `EbkCrossCallHandler`
  (`c_compiler/iar/docs/07-crossjump-and-tbaa.md`), the biggest single "smaller"
  win, needs IPO-level analysis.
- **`LDRD` / `STRD` merging.** Two adjacent 32-bit accesses into one 64-bit
  access: no byte saving under the 16-bit encodings, not worth a project.
- **Alias analysis / TBAA.** This backend has no loop vectorisation, so the
  payoff does not justify the complexity.
