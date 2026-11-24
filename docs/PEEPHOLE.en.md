# Stack round-trip cleanup (`-fopt-peep`)

English | [中文](PEEPHOLE.md)

> The eighth optimization of 0.9.1. In one sentence: **the value-stack machine
> emits both "move a value to another register" and "read a just-stored slot
> straight back" as a detour through memory; both round trips can be removed at
> the text level without any risk.**
>
> Implementation: `src/backend/arm/backend_arm.c`, `ark_peep_function()` (two
> rules inside, `pp_r1` / `pp_r3`)
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

## 2. The two rules

The scan is per function, line by line, on text with the indentation and the
trailing CR removed.

### R1 `PUSH {rX}` … `POP {rY}`

| Condition | Test |
| --- | --- |
| **C1 exact shape** | Both sides must be the single low-register form `PUSH {rN}` / `POP {rN}` (`r0`..`r12`). A multi-register form such as `PUSH {r5, r6, r7, lr}` **does not match**, so the frame operations are safe by construction |
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

### Why volatile is not affected

Volatile accesses always get a `DMB SY` inserted around them. `DMB SY` is
neither padding nor either end of these rules, so a sequence like
`STR` / `DMB SY` / `LDR` is stopped at C3 -- no separate taint table is needed
for volatile. `pp_mem()` also only accepts the `[r6, #off]` base form, so
far-offset accesses through `r12` (`LDR r0, [ip]`, produced by
`ark_fix_far_offset()`) never match.

## 3. Why only R1 and R3

Two more candidates were deliberately dropped:

| Dropped rule | Why |
| --- | --- |
| **R2**: after `MOV rM, #k`, rewrite all uses of `rM` to `#k` | Needs backwards liveness (can this constant register be killed at all); getting it wrong emits wrong instructions, and `-fopt-imm` (at emission time) already covers most of the same gain |
| **R4**: fuse `MOV rD, r0` with the following three-operand instruction | Needs cross-instruction read/write analysis, again a liveness problem |

What R1, R3 and R5 share is that they are **pure text equivalences**: no
instruction's operand meaning changes, and nothing has to be known about whether
some other register is still live. That is the only reason they could go into
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
ark_peep_function()        # only here do the remaining stack round trips show up (R5, R1, R3)
ark_regalloc_function()    # finally pick registers on a shorter instruction stream
ark_fix_far_offset()       # correctness backstop, always last
```

Running after `-fopt-cbz` has a concrete reason: cbz deletes `CMP`, and `CMP` is
very often exactly the line sitting between `PUSH` and `POP` -- **only after cbz
are the two sides adjacent**.

`pp_r5` runs first, `pp_r1` second, `pp_r3` last: R5 rewrites single lines and neither
creates nor destroys an opportunity for R1; R1 inserts a `MOV rY, rX`, which is neither
`STR` nor `LDR`, so it never creates a false opportunity for R3; conversely, deleting
`LDR`s in R3 never creates one for R1.

**The second peephole run**: the renames done by `-fopt-live` and `-fopt-coalesce` create
*fresh* adjacent `PUSH {rX}` / `POP {rX}` dead pairs **in the final text** (on the corpus
34 such pairs had 25 same-register ones before the value-stack work; afterwards only 9
pairs are left and none of them is same-register). So `ark_emit_program()` calls
`ark_peep_function()` once more, after the second liveness run and before
`ark_fix_far_offset()` -- same gate, same rule set, worth -52 instructions / -108 B. It
has to be before `ark_fix_far_offset()`: afterwards frame offsets become indirect
accesses through `r12` and there is no `[r6, #off]` left to pair.

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
