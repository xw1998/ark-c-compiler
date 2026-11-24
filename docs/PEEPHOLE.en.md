# Stack round-trip cleanup (`-fopt-peep`)

English | [中文](PEEPHOLE.md)

> The eighth optimization of 0.9.1. In one sentence: **the value-stack machine
> emits both "move a value to another register" and "read a just-stored slot
> straight back" as a detour through memory; both round trips can be removed at
> the text level without any risk.**
>
> Implementation: `src/backend/arm/backend_arm.c`, `ark_peep_function()` (four
> rules inside, `pp_r1` / `pp_r3` / `pp_r5` / `pp_r6`)
> Gate: `tests/run_peep_tests.py` (`make test-peep`), plus the whole
> `tests/arm_exec` corpus
> Switch: `-fopt-peep` / `-fno-opt-peep`, INI `opt-peep=` / `peep=`

---

## 1. Why, and at which layer

`-fopt-vstack` already ate most of the "adjacent `PUSH`/`POP` becomes a register
move" cases, but two shapes survive in the text:

**R1: copies through the stack.** `int y = x;` on a value-stack machine is
"push x, pop it back into another place":

```asm
    PUSH {r0}
    POP  {r0}          ; same register: both lines are dead
```

```asm
    PUSH {r0}
    MOV  r0, #1
    PUSH {r0}
    POP  {r1}          ; two registers: this is a MOV, the stack is pointless
    POP  {r0}
```

**R3: store then immediate read-back.**

```asm
    STR r0, [r6, #8]
    LDR r0, [r6, #8]   ; r0 still holds that very value
```

The name R3 is easy to misread: **the `LDR` is what gets deleted, the `STR` is
not touched at all**, so there is no risk of dropping a memory write.

## 2. The four rules

The scan is per function, line by line, on text with the indentation and the
trailing CR removed.

### R1 `PUSH {rX}` … `POP {rY}`

| Condition | Test |
| --- | --- |
| **C1 exact shape** | Both sides must be the single-register form `PUSH {rN}` / `POP {rN}` (`r0`..`r12`; `r12` is also accepted written as `ip`). A multi-register form such as `PUSH {r5, r6, r7, lr}` **does not match**, so the frame operations are safe by construction |
| **C2 only padding between** | Between the two lines only blank lines, `;`/`@` comments and `.`-prefixed directives/metadata (`.loc`, `.cfi_*`) are allowed; **a line ending in `:` is a label, not padding**, and any label in between aborts the match |
| **C3 inside the function** | "Inside" means the `[fstart, buffer_end)` range handed to `ark_peep_function()` |

All three pass => only two rewrites:

- `X == Y`: delete both lines;
- `X != Y`: replace them with a single `MOV rY, rX` (placed where the `POP` was).

### R3 `STR rX, [r6, #o]` … `LDR rX, [r6, #o]`

| Condition | Test |
| --- | --- |
| **C1 exact shape** | Must be `LDR\|STR[BH] rN, [r6, #off]`: width 1/2/4, base strictly `r6` (the frame pointer), offset an unsigned decimal. `LDRD`, `LDRSB`, `LDRSH`, and pre/post-indexed forms (`[r6, #4]!`, `[r6], #4`) are **all refused** |
| **C2 three fields equal** | same width, same offset, same register |
| **C3 adjacent** | only padding lines in between (same rule as R1; `.loc` may be crossed) |
| **C4 store first** | the `STR` comes first, the `LDR` second |

All three pass => **keep the `STR`, delete the `LDR`**. Within the same scan,
further reads of the same slot that follow immediately (still with only padding
between) are deleted too: nobody wrote that slot after the `STR`, so reading it
again cannot differ.

### R5 `ADD rD, rS, #0` becomes `MOV rD, rS`

| Condition | Test |
| --- | --- |
| **C1 exact shape** | Must be the three-operand `ADD rD, rS, #0`. `ADDS` does not match (`pp_add0()` rejects it outright with `strncmp(p, "ADD r", 5)`), and `ADD.W`, register operands and non-zero immediates are all refused |
| **C2 no liveness needed** | Neither side writes the flags (a plain `ADD` has no `S` suffix, and the 16-bit `MOV rD, rS` form `0x4600` does not either), so the rewrite is independent of "does anyone read the flags later" |

Both pass => if `D == S` delete the whole line (`ADD r5, r5, #0` is an identity);
if `D != S` replace it with `    MOV rD, rS`. **Encoding width is the entire
reason for this rule**: in Thumb-2, `ADD rD, rS, #0` only takes the 16-bit
`0x3000` form when `D == S` and `rd <= r7` (and that form is `ADDS`, which writes
the flags), so `D != S` can only be encoded as a 32-bit `ADDW` (4 B), while
`MOV rD, rS` is 2 B (`add r5, r8, #0` = `08f1 0005`, `mov r5, r8` = `4600`,
measured with keystone).

The rewrite lives in the text layer rather than at emission time because the
downstream `-fopt-live` (L1) and `-fopt-coalesce` only recognise `MOV`: an `ADD`
matches nothing there, a `MOV` can be deleted or hoisted. One rewrite, two levels
of gain.

### R6 `PUSH {rX}` ... `POP {rY}` with code in between

R1 only covers "padding in between". What the value stack really emits is often
"push a value -> materialise another -> pop":

```asm
    PUSH {r0}          ; keep argument 1 while argument 0 is materialised
    MOV  r0, r8
    POP  {r1}          ; argument 1, one instruction late
```

Those three lines together are one **`MOV r1, r0` routed through memory**. R6
turns them into:

```asm
    MOV  r1, r0
    MOV  r0, r8
```

| Condition | Test |
| --- | --- |
| **C1 exact shape** | Both ends must be the single-register `PUSH {rX}` / `POP {rY}` (`rN` or `ip`). Multi-register forms and `PUSH {r5-r7, lr}` are refused (same `pp_pushpop()` as R1) |
| **C2 the middle does not stop the scan** | Only padding and lines that neither observe the stack nor transfer control are allowed. What **stops** the scan: a line ending in `:` (a label), any **whole-token** mention of `sp` (`PUSH`/`POP`/`SUB sp` would all move the slot), any `B*` prefix (`B`/`Bcc`/`BL`/`BLX`/`BX`, which also blocks `BIC`/`BFI`), an `IT` block, `CBZ`/`CBNZ`, and any `P*` (a nested `PUSH`/`POP`) |
| **C3 a 12-line window** | At most `PP_R6_WINDOW = 12` lines after the `PUSH`; beyond that the match is dropped (it misses, it never folds wrongly) |
| **C4 `rY` is not mentioned** | No line in between may name `rY` as a **whole token**; when `X == Y`, `rX` must not be named either |

All four pass => `X != Y`: emit one `MOV rY, rX` at the position of the `PUSH`,
then copy the middle lines verbatim and drop the `POP`. `X == Y`: delete both
lines.

Three equivalence arguments (all of them in the code comment):

- **The copy must be emitted at the `PUSH`**. The code in between is exactly what
  may clobber `rX` -- that is what the `PUSH` protects. Emitting at the `POP`
  would read the clobbered value.
- **`rY` must not be mentioned inside the window**. Otherwise it either receives
  the value too early (reading an argument that has not arrived) or consumes it;
  neither can be repaired by text analysis.
- **When `X == Y`, `rX` must not be mentioned either**, because then the rule has
  to prove "nobody observed `rX` during that stretch".

**This rule needs no liveness analysis**: C4 proves the observability of `rX`/`rY`
directly, and C2 guarantees no control-flow entry and no stack operation in
between. That is the "pure text equivalence" of section 3. `pp_mentions()` matches
on whole-token boundaries, so `r1` never hits inside `r10` and `ip` never hits
inside a label name.

Where `ip` comes from: the emitter sometimes spells `r12` as `r12` and sometimes
as `ip`. The older `pp_pushpop()`, which only knew `r12`, **silently skipped the
nine `POP {ip}` in the corpus** (and the matching R1 opportunities with them);
`pp_rname()` prints it back as `ip`.

**Measured (2026-11-24, 95 TUs, nineteen switches)**: 12,346 -> **12,304**
(-42 instructions / -54 bytes), and none of the 95 TUs grows. There are 30
candidate sites: 21 with `X != Y`, 8 with `X == Y`, and 1 `lr -> pc` that must be
excluded; the register pairs are `r0->r1` 12, `r0->r0` 8, `r0->ip` 7, `r5->ip` 1,
`r7->ip` 1.

### Why volatile is not affected

Volatile accesses always get a `DMB SY` inserted around them. `DMB SY` is
neither padding nor either end of these rules, so a sequence like
`STR` / `DMB SY` / `LDR` is stopped at C3 -- no separate taint table is needed
for volatile. `pp_mem()` also only accepts the `[r6, #off]` base form, so
far-offset accesses through `r12` (`LDR r0, [ip]`, produced by
`ark_fix_far_offset()`) never match.

## 3. Why only R1, R3, R5 and R6

Two more candidates were deliberately dropped:

| Dropped rule | Why |
| --- | --- |
| **R2**: after `MOV rM, #k`, rewrite all uses of `rM` to `#k` | Needs backwards liveness (can this constant register be killed at all); getting it wrong emits wrong instructions, and `-fopt-imm` (at emission time) already covers most of the same gain |
| **R4**: fuse `MOV rD, r0` with the following three-operand instruction | Needs cross-instruction read/write analysis, again a liveness problem |

What R1, R3, R5 and R6 share is that they are **pure text equivalences**: no
instruction's operand changes meaning, and nothing has to be known about whether
some other register is still live (R6's C4 proves the window's observability
outright). That is the only reason they could go into
0.9.1. R5 is a notch weaker than R1/R3 -- it does not even need "two adjacent
instructions", it looks at a single line; that `ADD #0` with `D != S` exists at all
is because the value stack materialises copies and zero-displacement addresses as
a three-operand `ADD` (see `docs/VREG.md` section 17). R2 and R4 stay out, for the
same reasons as before.

## 4. Measurements

Corpus and flags as in `docs/IMM_FOLD.md` §6: 96 translation units (93
effective), `-O2 -mcpu Cortex-M4`, baseline
`-fopt-vstack -fopt-addr -fopt-strength -fopt-cbz -fopt-branch`.

| Build | Instructions | Relative to baseline |
| --- | --- | --- |
| baseline (five passes) | 35,211 | 1.000× |
| baseline + `-fopt-peep` | **33,730** | 0.958× (**−1,481, −4.21%**) |
| baseline + `-fopt-imm` | 27,716 | 0.787× |
| baseline + both | **26,316** | 0.747× (**−8,895, −25.26%**) |

`-fopt-peep` alone is −4.21%, far more than the initial −0.6% estimate: in the
first implementation the mnemonic length of `POP` was computed wrong (`POP` has
three letters, the code took a four-letter offset), so **R1 never matched
anything** and only R3 was working. After the fix the copies through the stack
in the HAL corpus really are eaten.

Both together are 81 instructions less than the sum of the parts: once
`-fopt-imm` swallows the constant push, the sites that would have formed an
adjacent `PUSH`/`POP` pair no longer exist -- that is overlap between the two
passes, not interference.

**The ladder since then (95 TUs, all nineteen switches; contract in
`docs/COMPARISON.en.md` section 1)**:

| Stage | Instructions | Bytes |
| --- | ---: | ---: |
| + R5 + second peephole run (commit `b2e915c`) | 12,795 | 33,464 |
| + second addressing fold (see `docs/ADDR_FOLD.en.md` section 11) | 12,346 | 32,744 |
| **+ R6 and `ip` recognition** | **12,304** | **32,690** |

R6's own share is **-42 instructions / -54 bytes** (0.34% / 0.16%) on top of a
baseline that already contains the second addr fold. It is small, but it removes
the last batch of "the value stack routes a copy through memory" shapes that pure
text can decide.

## 5. What the gate says

`make test-peep` (`tests/run_peep_tests.py`) runs three fixtures × several arms,
12 checks, all ok:

- `COPY` (`copies`, returns 6): back-to-back copies through the stack;
- `READBACK` (`sread`, returns 13): store then immediate read-back;
- `BRANCH` (`branchy(5)`, returns 76): branches, labels, loops -- **used to prove
  that a `PUSH`/`POP` pair spanning a label is never mis-paired**.

Key assertions:

1. **OFF IS OFF**: the images of `-O2` and `-O2 -fno-opt-peep` are byte-identical
   (1298/1298).
2. **R1 really hits**: adjacent `PUSH`/`POP` pairs `13 → 0` (`COPY` fixture).
3. **The count really drops**: `124 → 83`.
4. **The image only shrinks**: `1298 → 1216` bytes.
5. **R3 really hits**: `STR`/`LDR` pairs `6 → 0`, image `1290 → 1228` bytes.
6. **Semantics**: the `off / on / vstack / imm` arms are correct on all three
   fixtures (`6/6`, `13/13`, `76/76`).
7. **The fixture really has branch targets**: `9` labels -- otherwise the
   "no match across a label" assertion would be vacuous.
8. **A cropped build** refuses `-fopt-peep` by name (`C3900U`, exit code 1) while
   still compiling without the flag.

Items 3 and 6 must both be present: asserting only "the pair disappeared" would
miss "the pairing was wrong and someone else's `POP` was deleted" -- that error
does not show up at assembly time; at run time it corrupts the stack.

## 6. Trimming

`ARKCC_FEATURE_OPT_PEEP` in `include/arkcc_config.h`: 0 under
`ARKCC_PROFILE_STM32_MIN`, 1 for host / cross builds. When it is 0 the `pp_*`
helpers and `ark_peep_function()` are preprocessed away entirely, and
`src/main.c` rejects the flag with
`C3900U: -fopt-peep is not compiled into this build`.

The run-time default is **off** (`g_config.enable_opt_peep = 0`).

## 7. Pass order

```
ark_vstack_function()      # first remove the cheapest layer of adjacent PUSH/POP
ark_addr_function()        # then fold ADD/MOV into addressing
ark_cbz_function()         # then CMP #0 + branch -> CBZ
ark_peep_function()        # only here do the remaining stack round trips show up (R5 -> R6 -> R1 -> R3)
ark_regalloc_function()    # finally pick registers on a shorter instruction stream
ark_fix_far_offset()       # correctness backstop, always last
```

Running after `-fopt-cbz` has a concrete reason: cbz deletes `CMP`, and `CMP` is
very often exactly the line sitting between `PUSH` and `POP` -- **only after cbz
are the two sides adjacent**.

`pp_r5` runs first, `pp_r6` second, `pp_r1` third and `pp_r3` last:

- **R5 rewrites single lines** and neither creates nor destroys any pair, so it goes first.
- **R6 before R1**: R6 handles "code in between", R1 handles "padding in between". Running
  R1 first would not eat R6's shape anyway (its C2 demands pure padding), so the two do not
  overlap; but R6 replaces `PUSH ... POP` with one `MOV`, which lets R1/R3 afterwards see
  shorter, more adjacent text.
- **R1 inserts a `MOV rY, rX`** that is neither `STR` nor `LDR`, so it never creates a false
  opportunity for R3; conversely, deleting `LDR`s in R3 never creates one for R1. The order
  of R1 and R3 therefore does not change the result; R1 first is fixed only for
  reproducibility.

**The second peephole run**: the renames done by `-fopt-live` and `-fopt-coalesce` create
*fresh* adjacent `PUSH {rX}` / `POP {rX}` dead pairs **in the final text** (on the corpus
34 such pairs had 25 same-register ones before the value-stack work; afterwards only 9
pairs are left and none of them is same-register). So `ark_emit_program()` calls
`ark_peep_function()` once more, after the second liveness run and before
`ark_fix_far_offset()` -- same gate, same rule set, worth -52 instructions / -108 B. It
has to be before `ark_fix_far_offset()`: afterwards frame offsets become indirect
accesses through `r12` and there is no `[r6, #off]` left to pair. Right after that second
peephole run and still before `ark_fix_far_offset()`, `ark_addr_function()` runs **once
more**: R5/R6 together with the renames manufacture fresh "`MOV rX, r0` feeding an access
through `rX`" shapes, which is exactly what the second addressing fold eats (see
`docs/ADDR_FOLD.en.md` section 11). The relative order is
`peep(2) -> addr(2) -> ark_fix_far_offset()`, and `ark_fix_far_offset()` is always last.

## 8. Deliberately not done

| Not done | Why |
| --- | --- |
| Pairing `PUSH`/`POP` across a label | The two lines must be in the same basic block to be equivalent; across a label control flow can enter in the middle |
| Pairing multi-register `PUSH {r0, r1}` | Would need a per-register analysis of the stack layout, and `PUSH {r5-r7, lr}` is a frame operation; mixing them up is fatally wrong |
| R3 when an unrelated instruction sits between `STR` and `LDR` | Only strict adjacency (padding aside) proves `rX` was not modified |
| Dead-store elimination (nobody reads after the `STR`) | Needs liveness / alias analysis, outside 0.9.1 |

## 9. Known costs

- Every call to `ark_peep_function()` statically allocates two
  `PP_MAX_LINES = 8192` `int` arrays (`ls` / `ll`, 64 KB in total, `static` so not
  on the stack). A function longer than 8192 lines is skipped entirely -- not
  optimised, but never wrong.
- Two runs: one after `-fopt-cbz`, one after the second liveness run (see section 7).
  The first run's output is the second run's input; no state is shared between them, so
  every extra run is another full function scan.
- Only the emitter's own text shapes are recognised. If the emitter ever changes
  a line length or a mnemonic spelling (say `STR` becomes `STR.W`), the matching
  rule silently stops firing -- which is why both rules use **exact matching**
  rather than prefixes: when in doubt, miss the fold rather than guess.
