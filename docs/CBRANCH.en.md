# `-fopt-cbranch`: branch on a comparison instead of materialising it

English | [中文](CBRANCH.md)

> In one sentence: `if (a == b)` used to pay for the comparison **twice** — `CMP` +
> `ITE/MOVcc` to produce a 0/1 value, then `CMP r0, #0` at the branch.  With
> `-fopt-cbranch` the same program point is just `CMP` + `B<cond>`, which removes
> **2,601 instructions (-7.39%)** and **8,238 bytes (-10.0%)** over the whole HAL
> corpus.

---

## 1. Why this exists

arkc's IR is a stack machine, so `if (a == b)` becomes "push `a`, push `b`,
`IR_BINARY(==)`, `IR_JZ`".  The semantics of `IR_BINARY` is **to produce an int**
(0 or 1), so the backend has to materialise it:

```asm
; off (default)
    CMP  r0, r1
    ITE  EQ
    MOVEQ r0, #1
    MOVNE r0, #0
    PUSH {r0}
    POP  {r0}
    CMP  r0, #0
    BEQ  .L_f_0
```

**Eight instructions.**  The only consumer of that 0/1 value is the `IR_JZ` right
after it, so "compute it, then test it again" is pure waste:

```asm
; on
    CMP  r0, r1
    BNE  .L_f_0
```

**Two instructions**, which is exactly what armcc emits (see `docs/COMPARISON.md`
§4).  After 0.9.1 this was the single largest structural overhead left — every
`if (a == b)`, `if (p)` and `while (n)` paid it — and it is the item that
`docs/COMPARISON.md` §4 item 2 called "should be worth thousands of instructions".

## 2. Why it lives in IR emission, not in a text pass

A text pass cannot tell whether the 0/1 value has another consumer: after
`CMP` / `ITE` / `MOVcc` / `PUSH` / `POP`, the value may have been stored into a
variable or reused by a later expression.  In the IR the shape is unambiguous:

```
IR_BINARY(comparison, ...)   ; or IR_BINARY_imm
IR_JZ / IR_JNZ               ; the immediately following instruction
```

There is exactly one criterion: **the instruction after the comparison is
`IR_JZ` / `IR_JNZ`** (strictly adjacent).  If so, the value is dead and the pair
collapses into `CMP` + `B<cond>`; otherwise the old path runs unchanged.

## 3. Condition-code table

`want_true` means "the branch is taken when the comparison is true" (`IR_JNZ`);
otherwise the branch is taken when it is false (`IR_JZ`).  An unsigned
comparison marks its `base_op` with `+0x100`, and `cbranch_mnemonic()` uses that
to pick `BLO/BHS/BHI/BLS` instead of `BLT/BGE/BGT/BLE`.

| operator | branch if true | branch if false |
| --- | --- | --- |
| `==` | `BEQ` | `BNE` |
| `!=` | `BNE` | `BEQ` |
| `<`  (signed / unsigned) | `BLT` / `BLO` | `BGE` / `BHS` |
| `<=` (signed / unsigned) | `BLE` / `BLS` | `BGT` / `BHI` |
| `>`  (signed / unsigned) | `BGT` / `BHI` | `BLE` / `BLS` |
| `>=` (signed / unsigned) | `BGE` / `BHS` | `BLT` / `BLO` |

Note that the negation of `<` / `<=` is **not** `>` / `>=` — that would drop the
equality case — but `BGE` / `BGT`, which is also what the ARM condition codes
themselves give, so no extra inversion step is needed.

## 4. The two injection points

### 4.1 The immediate is still in hand

`-fopt-imm` folds "push a constant, compare" into `IR_BINARY_imm`, so the backend
already holds `imm_val`.  That shape emits:

```asm
    POP  {r0}
    CMP  r0, #<imm>       ; falls back to MOV r1, #k; CMP r0, r1 when the
                          ; constant does not fit the 12-bit immediate field
    B<cond> .L_<fn>_<n>
```

**Fallback**: if `thumb_imm12_a()` says the constant cannot be encoded in `CMP`'s
immediate field, we emit `MOV r1, #k` + `CMP r0, r1` and then branch.  In practice
`emit_binary_imm` has already guaranteed encodability; this layer is the "rather
one extra instruction than a wrong one" insurance, the same policy `-fopt-imm`
already applies to large constants.

### 4.2 The general shape: operands still on the value stack

```asm
    POP  {r1}
    POP  {r0}
    CMP  r0, r1
    B<cond> .L_<fn>_<n>
```

When `cbranch_mnemonic()` returns 0 (not a comparison) nothing happens and
`emit_binary` runs as before.

## 5. Mutual exclusion and stacking

- **Exclusive with `--reg-top`**: `--reg-top` models the top of the value stack
  to elide `PUSH/POP`; the same value gets skipped there, and if cbranch skipped
  it again the stack would get out of step.  Both injection points therefore
  carry a `!ark_top_enabled()` guard (same precedent as `-fopt-imm`).
- **Stacks with `-fopt-cbz`**: after cbranch there can still be a
  `CMP r0, #0` + `BEQ` shape (value comes from memory or a call result), and the
  text-level `-fopt-cbz` still turns that into `CBZ`.  The two do not conflict;
  the `cmp` probe shows no `#0` form left at a cbranch site.
- **Stacks with `-fopt-peep`**: the comparison value no longer travels through
  `PUSH/POP`, so peep finds fewer copy pairs to fold, but neither depends on the
  other and the order only affects the numbers (§7), not correctness.

## 6. What is deliberately *not* folded

- **A comparison stored in a variable**: `int x = (a < b); if (x) …` — the value
  has two consumers, so it must be materialised.  The gate checks exactly this
  with the `used` fixture (the `ITE` count must **not** change).
- **Across basic blocks**: comparison in one block, branch in the next (a label or
  already-emitted code in between) is not two adjacent IR instructions, so it is
  left alone.
- **`&&` / `||` short-circuit blocks**: the IR already expands them into several
  `IR_JZ/IR_JNZ` plus temporaries; the parts that match are folded, the rest is
  untouched.

## 7. Measurements (whole HAL corpus, 96 TUs / 93 valid, Cortex-M4, `-O2 --reloc-data`)

Baseline = `-fopt-vstack -fopt-addr -fopt-strength -fopt-cbz -fopt-branch`,
35,211 instructions / 82,404 bytes:

| build | instructions | code bytes | vs baseline |
| --- | ---: | ---: | ---: |
| baseline | 35,211 | 82,404 | — |
| + `-fopt-cbranch` | **32,610** | **74,166** | **-2,601 (-7.4%) / -8,238 (-10.0%)** |
| + `-fopt-imm` | 27,716 | — | -7,495 |
| + `-fopt-peep` | 33,730 | — | -1,481 |
| + `imm` + `peep` | 26,316 | 64,682 | -8,895 |
| + `imm` + `peep` + `cbranch` | **23,692** | **56,384** | **-11,519 (-32.7%) / -26,020 (-31.6%)** |

All three arms report `fails 3` (the symmetrically skipped `*_template.c`) and
`empty 0`, the same accounting as the other passes.

Corpus-wide shape change (counted in the same `.s` files):

| marker | baseline | + cbranch | meaning |
| --- | ---: | ---: | --- |
| `ITE` | 824 | 69 | the materialisation blocks are almost gone |
| `CMP r0, #0` | 409 | 73 | the "test it again" that follows them goes with them |

The 69 surviving `ITE`s are all the §6 "value has a second consumer" case.

Single site (`D:/tmp/cbprobe.c`): 8 lines → 2.  Fixture `cmpi`: 135 → 117
instructions, 1,338 → 1,290 bytes, `ITE` 3 → 0, `CMP r0,#0` 5 → 2, labels 11/11
unchanged.

## 8. Gate (`tests/run_cbranch_tests.py`, `make test-cbranch`, 13 checks)

| group | assertion |
| --- | --- |
| 1 | **OFF IS OFF**: `-O2` and `-O2 -fno-opt-cbranch` are byte-identical |
| 2 | `cmpi`'s `ITE` count drops (3 → 0) |
| 3 | `cmpi`'s `CMP rN, #0` count drops (5 → 2) |
| 4 | `cmpi`'s instruction count drops (135 → 117) |
| 5 | `cmpi`'s image never grows (1,338 → 1,290 B) |
| 6 | the label set is unchanged (11/11) and branches target what the IR carried |
| 7 | **anti-false-green**: `int x = (a<b); if (x)` keeps its `ITE` count, still > 0 (2 → 2) |
| 8 | all four arms `off / on / vstack / imm` compute the expected answer in the emulator (`cmpi`=2, `cmpc`=10, `ucmp`=5, `used`=8) |
| 9 | unsigned comparisons use unsigned condition codes (`7u<3u` false, `7u>=3u` true) |
| 10 | the large immediate 70000 takes the register fallback and still computes the right answer |
| 11 | a cropped build (`-DARKCC_FEATURE_OPT_CBRANCH=0`) refuses `-fopt-cbranch` by name (rc=1) |
| 12 | the same cropped build still compiles without the flag (rc=0) |

Group 7 is the one place where a false green would be easy: an implementation
that only looks at "next instruction is a branch" without confirming the value is
dead would fold the `used` fixture, still print the right answer, and silently
break the meaning of `x`.  The gate pins it down by asserting the `ITE` count is
unchanged.

## 9. Cropping

`ARKCC_FEATURE_OPT_CBRANCH` is set per profile in `include/arkcc_config.h`:

- `ARKCC_PROFILE_STM32_MIN` ⇒ `0`: neither `cbranch_mnemonic()` nor the two
  injection points are compiled in;
- host / cross profiles ⇒ `1`.

Passing `-fopt-cbranch` to a cropped build yields
`Fatal error: C3900U: -fopt-cbranch is not compiled into this build (rebuild with -DARKCC_FEATURE_OPT_CBRANCH=1)`
and exit code 1 — the same refusal semantics as `-fopt-imm` / `-fopt-peep`, never
a silent ignore.

## 10. Where it sits in the pipeline

`-fopt-cbranch` is **not** a text pass; it acts in place inside the main emission
loop of `backend_arm.c`, in `case IR_BINARY`.  The text pass chain is unchanged:

```
vstack → addr → cbz → peep → regalloc → fix_far_offset
```

So there is no ordering question with the other passes: it changes the instruction
sequence that the text layer receives in the first place.

## 11. Known costs

- Branch density goes up (`B<cond>` instead of an `ITE` block), which is slightly
  less friendly to a sequential-execution predictor.  No cycle model was measured
  on this corpus, so we claim **no performance benefit**, only instruction count
  and size.
- The immediate path keeps one `POP` because `IR_BINARY_imm` may already have
  folded the constant so only the left operand is on the stack — the same stack
  shape as with the pass off, so no extra cost.

## 12. Not done (registered)

- **Reusing a comparison across basic blocks**: needs liveness analysis to know the
  next block starts by consuming it.
- **Allowing instructions between `CMP` and `B<cond>`**: we require strict
  adjacency; relaxing it needs a dependency check, and this backend has no
  scheduler.
- **T1 short conditional branches**: see `docs/COMPARISON.md` §4 — that needs a
  layout fixpoint iteration and is a separate item.
