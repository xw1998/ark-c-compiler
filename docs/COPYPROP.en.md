# `-fopt-copyprop`: drop dead copies, forward copies into their consumer

English | [中文](COPYPROP.md)

> In one sentence: register-to-register `MOV`s that are written and never read,
> or that are immediately recomputed into the same destination, are pure
> overhead. `-fopt-copyprop` removes or folds them over a function's already
> emitted text: **388 fewer instructions (−1.64%)** and **776 fewer bytes
> (−1.38%)** on the full HAL corpus, while `MOV` drops from 6,180 to 5,792 and
> every other mnemonic stays put.

---

## 1. Why this pass exists

After 0.9.1 the optimizer was compared layer by layer against the IAR optimizer
reverse-engineered in `D:/工作/git_project/c_compiler/iar/docs/`.
`08-backend-passes.md` and `06-optimizer.md` describe a family of passes whose
subject is the copy:

- `ECT CopyPropagation candidate` — decides which copies are candidates;
- `DefIntoMove` — lands a definition directly as a `MOV` (IAR's wording);
- `Dead MOV` — removes a `MOV` nobody reads.

Reduced to what can be proved safe without liveness analysis, that is two rules
in arkc's text backend, behind one switch (`ARKCC_FEATURE_OPT_COPYPROP`).

`MOV` is the third most common mnemonic in this corpus (6,180 of 23,692
instructions, 26% of the fully optimised output), and a large part of it is the
value-stack machine talking:

```asm
    MOV  r0, #15        ; the barrier takes an argument the instruction never reads
    DSB  SY

    MOV  r0, r5         ; move the value-stack pool register into r0
    ADD  r0, r0, r7     ; then immediately compute back into r0
```

The first pair is dead outright (rule A); the second collapses into
`ADD r0, r5, r7` (rule B).

## 2. The two rules

### 2.1 Rule A: dead copy

> `MOV rD, rS` (or `MOV rD, #imm`) whose `rD` is **completely overwritten**
> before anything reads it, inside one straight-line block, is dead. Removing it
> changes no value and no flag.

No flag can change because `MOV` writes no flags. No value can change because
`rD` is overwritten before it is read.

The straight-line block ends at:

- a label (`.L...:` or a function name);
- any branch: `B` / `BL` / `BX` / `BLX` / the ten `B<cond>` forms;
- `PUSH` / `POP` / `LDM` / `STM` (including `LDMIA` / `STMIA`);
- the `IT` family (`IT` / `ITE` / `ITT` / `ITTE` ...) — its inner instructions are
  conditional, so "it is definitely read" does not hold;
- `CPS` / `BKPT`;
- the end of the function.

Directives such as `.loc` / `.file` and blank lines are padding and may be
crossed.

**How a read is decided** is the only real trap in this rule; see §4.

### 2.2 Rule B: forward the copy into its consumer

> `MOV rD, rS` followed (padding only in between) by `OP rD, rD, X`, with
> `rD != rS` and `X != rD`, becomes `OP rD, rS, X`.

Safety matches item by item:

- the new instruction reads exactly the values the pair read (`rS` and `X`);
- it keeps its own suffix (`s`, condition code), so the flags written are exactly
  those of the original `OP`;
- it is one instruction instead of two, and the removed `MOV` wrote no flags, so
  the flag sequence is unchanged.

`OP` accepts only the plain three-operand ALU shapes:

```
LSL LSR ASR ADD SUB AND ORR EOR RSB SBC ADC MUL UDIV SDIV BIC
```

**`CMP` / `CMN` / `TST` are excluded on purpose**: they write no register, so
deleting the preceding `MOV` would leave `rD` holding a different value.

`MOVT` is not accepted as a "complete overwrite" either — it writes only the top
half.

## 3. Why no liveness analysis is needed

This is what lets the pass live in the text layer with unquestionable
correctness:

- rule A only removes writes that are provably overwritten; it never reasons
  about whether the value is read later;
- rule B only forwards a copy into its single, immediately adjacent consumer; it
  never moves or crosses anything.

Neither needs to know whether a value is live at a point. Real register
allocation (`CgRegalPhase` / `CgLiverangePhase`) does need liveness; that is a
different job (see `docs/COMPARISON.md` §4 and `docs/OPTIMIZER_PLAN.md`).

## 4. An error the emulator caught: the first operand can be a read too

The first version defined "reads `rD`" as "any operand after the first top-level
comma mentions `rD`", i.e. it assumed `operands[0]` is a write-only destination.
That holds for three-operand ALU shapes and is wrong in general:

```asm
    STR  r0, [r6, #8]     ; store -- r0 is read
    CMP  r0, r1           ; compare -- both operands are reads
    MOV  r0, r1           ; copy -- the source is operands[1]
    MUL  r0, r1           ; two-operand form, operands[0] is also a read
    UXTB r0, r0           ; self-updating, operands[0] is a read
```

So "`MOV r0, #15` followed by `STR r0, [...]`" was classified dead and deleted,
and `tests/arm_exec` reported **9 failures**:

```
struct_cond    3221225560 (want 46)
longlong_args  48/50      shift64      11/50
longlong64     4/50       struct_byval 1/50
big_frame      218/82     aeabi_runtime 4/50
fconv_rne      105/0      atomic_wide  5032707/6
```

The fix names the write-only destinations explicitly (`cp_dest_only()`):

- three or more operands => the first one is write-only;
- otherwise only mnemonics that are known to be emitted with a bare destination
  qualify:
  `MOV MOVW MVN LDR LDRB LDRH LDRSB LDRSH REV REV16 REVSH RRX CLZ UXTB UXTH SXTB SXTH`.

`cp_reads()` then reads:

> any of `operands[1..]` mentions `rD` => read; `operands[0]` mentions `rD` and
> it is **not** one of the write-only shapes above => read.

After the fix `arm_exec` reports 0 failures. This is also why the gate needs the
anti-over-deletion control fixture (§8 group 4): without it, an implementation
that deletes every `MOV` would pass "the four barrier arguments are gone" just
as well.

## 5. Division of labour with `-fopt-peep`

| Dimension | `-fopt-peep` | `-fopt-copyprop` |
| --- | --- | --- |
| Subject | Memory round trip: `PUSH {rX}` / `POP {rX}` pairs, `STR`+`LDR` to the same address | Register copies: `MOV rD, rS` / `MOV rD, #imm` |
| Action | Turns two lines into one `MOV` (**creates** copies) | Removes dead copies, forwards copies (**consumes** copies) |
| Needs | Pairing and a fixed window | A straight-line block scan |

peep runs first: it folds `PUSH/POP` into `MOV`s, which gives copyprop more
copies to remove or fold. The other order is also semantically valid, but the
numbers get worse.

## 6. Measurements (full HAL corpus, 96 TUs / 93 effective, Cortex-M4, `-O2 --reloc-data`)

Baseline = the eight 0.9.1 switches (`vstack addr strength cbz branch imm peep
cbranch`), 23,692 instructions / 56,384 bytes:

| Build | Instructions | Code bytes | Change |
| --- | ---: | ---: | ---: |
| baseline (eight switches) | 23,692 | 56,384 | — |
| + `-fopt-copyprop` | **23,304** | **55,608** | **−388 (−1.64%) / −776 (−1.38%)** |

Against the original five-switch baseline (35,211 / 82,404) the cumulative
figure is −11,907 (−33.8%) / −26,796 (−32.5%).

Mnemonic ledger (counted line by line over the same `.s` files):

| Mnemonic | baseline | + copyprop | delta |
| --- | ---: | ---: | ---: |
| `MOV` | 6,180 | 5,792 | **−388** |
| everything else | 17,512 | 17,512 | 0 |

**Not one instruction more or less** — only `MOV` moves, which is exactly the
domain of the two rules.

### 6.1 How 388 splits into 147 + 241

A model with the same semantics as the C implementation was replayed over the
baseline `.s`:

| Rule | Hits | Dominant shape |
| --- | ---: | --- |
| A (dead copy) | **147** | all `MOV rD, #imm` immediately followed by another write to `rD`: `MOV r0, #15` + `DSB SY`, `MOV r0, #0` + `MOVW r0, #4` |
| B (forward) | **241** | `LSL` 207, `SUB` 16, `UDIV` 11, `ADD` 5, `ORR` 2 |

`LSL` dominates rule B because scaling through the value-stack pool register
always emits `MOV r0, r5` + `LSL r0, r0, r7` (and `-fopt-strength` turning
`*2^k` into a shift makes that shape more common).

### 6.2 Why the first estimate of 1,141 was wrong

The first scanning script checked "writes" before "reads", so it treated
self-updating instructions (`LSL rD, rD, X`, `UXTB rD, rD`, `AND rD, rD, X`,
`ORR rD, rD, X`, ...) as killers of `rD`, and counted 900 dead `MOV`s. Rescanned
with the correct semantics the upper bound is **601**, and after the block
boundaries (`PUSH`/`POP`/labels) cut it down, the model reproduces exactly
**147**. The old number is withdrawn; the 388 in this document is aligned
instruction by instruction with the compiler's own output.

Dead `MOVW` was evaluated as a candidate too: **0** hits on this corpus, so no
code was added for it.

## 7. Where it lives

`src/backend/arm/backend_arm.c`, sharing the source guard with peep
(`ARKCC_FEATURE_OPT_PEEP || ARKCC_FEATURE_OPT_COPYPROP`) and reusing the text
helpers `pp_split_lines` / `pp_trim` / `pp_copy_line` / `pp_splice` / `pp_pad` /
`PP_MAX_LINES`.

| Function | Job |
| --- | --- |
| `cp_parse` | split a line into "mnemonic + up to 4 top-level comma-separated operands" (commas inside `[...]` do not split) |
| `cp_reg` | `rN` and nothing else => register number (`r6,` / `[r6]` do not count) |
| `cp_mentions` | appears as a whole token (so `lr`, `str0` do not match) |
| `cp_writes` | does this line **completely overwrite** its first operand (`MOVT` does not) |
| `cp_dest_only` | is the first operand a write-only destination (§4) |
| `cp_reads` | does this line read a given register (§4) |
| `cp_is_boundary` | does this line end the straight-line block |
| `cp_op_ok` | the ALU whitelist rule B may absorb |
| `cp_pass` | one walk, returns the number of rewrites |
| `ark_copyprop_function` | up to 4 rounds until `cp_pass` returns 0 (one fold can expose another) |

Every rewritten line is rebuilt with `snprintf` as `    OP rD, rS, X\n` with the
same 4-space indent the emitter uses; labels and directives always go through
`pp_copy_line` verbatim, so **labels can never be renamed or dropped**.

## 8. Gate (`tests/run_copyprop_tests.py`, `make test-copyprop`, 17 checks)

| Group | Assertion |
| --- | --- |
| 1 | **OFF IS OFF**: `-O2` and `-O2 -fno-opt-copyprop` are byte-identical (1,194/1,194 B) |
| 2 | `bar`: the four barrier arguments vanish (`MOV #imm` delta 4), `DSB/ISB` still 4, instructions −4, image shrinks, labels 3/3 |
| 3 | `fuse`: both pool copies fold into their `ADD` (`MOV rX, rY` 6 → 4), instructions −2, image never grows, immediate copies untouched |
| 4 | **anti-over-deletion**: the `keep` fixture (pointer retargeted then indexed, every copy read) is identical line by line (135/135) |
| 5 | three fixtures × three arms (off / on / on alone without the other passes) return the Python answer in the emulator (11 / 20 / 18) |
| 6 | a cropped build (`-DARKCC_FEATURE_OPT_COPYPROP=0`) refuses `-fopt-copyprop` by name (rc=1) |
| 7 | the same cropped build still compiles without the flag (rc=0) |

Group 4 is the only place this gate could go falsely green; see the end of §4.

**Note**: the fixtures must carry `-fopt-vstack`. Rule B's shape comes from the
value-stack pool register (`MOV r0, r5` + `ADD r0, r0, r7`); without it the
emitter goes straight to `PUSH/POP`, `POP` is a boundary, and rule B never
fires. For the same reason every statement in the `fuse` fixture sits on **one
line** — splitting them changes the emitted shape (a `PUSH {r0}` appears in
between).

## 9. Cropping

`ARKCC_FEATURE_OPT_COPYPROP` is set per profile in `include/arkcc_config.h`:

- `ARKCC_PROFILE_STM32_MIN` => `0`; the whole copyprop block and its call site
  are not compiled;
- host / cross profiles => `1`.

Passing `-fopt-copyprop` to a cropped build yields
`Fatal error: C3900U: -fopt-copyprop is not compiled into this build (rebuild with -DARKCC_FEATURE_OPT_COPYPROP=1)`
and exit code 1 — the same refusal semantics as `-fopt-imm` / `-fopt-peep` /
`-fopt-cbranch`.

## 10. Position in the pipeline

```
vstack → addr → cbz → peep → copyprop → regalloc → fix_far_offset
```

Before `regalloc`, for the same reason as peep: the slot rewriter should see the
shorter text, so its "access count" statistics are not polluted by copies that
are already dead.

## 11. Not done (logged)

- **Dead copies across basic blocks**: needs liveness (or at least a CFG) to know
  whether another path reads the value.
- **Dead `MOVW`**: zero hits on this corpus; not started.
- **Copy propagation through `LDR`/`STR`**: treating "store then read back
  verbatim" as a copy needs alias analysis; `-fopt-peep` only handles the strict,
  adjacent, same-address case.
- **IAR's cross-jump / cross-call**: that is jump merging across blocks and
  functions (`EbkInterproceduralCrossJumpHelper` / `EbkCrossCallHandler`, see
  `c_compiler/iar/docs/07-crossjump-and-tbaa.md`), not a copy problem, and is a
  separate project (see `docs/OPTIMIZER_PLAN.md`).
