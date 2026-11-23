# `-fopt-cmat`: cleaning up duplicated constant materialisation

English | [中文](CMAT.md)

> In one line: the value-stack backend materialises the same constant twice -- it
> copies it into a scratch register, and the consumer folds it back into the
> addressing mode -- and it also writes the scratch register twice in a row.
> `-fopt-cmat` removes those three shapes from a function's emitted text:
> **337 instructions fewer (-1.77%)** on the whole HAL corpus, `MOV` goes from
> 3,888 to 3,551, and no other mnemonic moves by one.

---

## 1. Why this exists

The 0.9.1 text passes already removed a lot of moving around, but the value
stack leaves one family nobody handled:

```asm
    MOV   r7, #0
    MOV   r1, r7                 ; copy a known constant into the index register
    LDR   r7, [r5, r1, LSL #2]   ; the hardware can encode [r5, #0] directly
```

```asm
    MOV   r7, #0          ; written once
    MOV   r1, r7          ; r7 overwritten again before any read
    ...
```

These shapes need no liveness analysis to be proved safe -- either the address
and the result are identical, or the value is provably overwritten before any
read inside the same block. That is the whole domain of this pass.

## 2. The three rules

### 2.1 M1: a copy of a known constant becomes an immediate

> `MOV rD, rS` where `rS` is known in this block to hold `k`, `0 <= k <= 255`
> becomes `MOV rD, #k`.

On its own this saves nothing (still one instruction). It exists so that M2 and
M3 can see through the copy: once it is an immediate, the register it copied
from is no longer read, and M3 may delete the materialisation that produced it.

The 255 limit is simply the form the emitter itself prints for small constants;
anything larger needs `MOVW` and would get longer.

### 2.2 M2: a known index is folded into the addressing mode

> `LDR/STR/LDRB/LDRH/STRB/STRH rT, [rB, rI(, LSL #s)]` where `rI` is known in
> this block to hold `k`, the byte offset `k << s` fits in 0..4095, and
> `rI != rB`, becomes `[rB, #k << s]`.

Same address, same flags, one operand (and one register read) fewer.

4095 is the Thumb-2 immediate-offset limit. `rI == rB` is excluded. Write-back and
post-indexed forms are outside the accepted shapes.

### 2.3 M3: a flag-neutral write overwritten before any read is dead

> A flag-neutral write (`MOV`, a `MOVW`+`MOVT` pair on the same register, a
> three-operand `LSL LSR ASR ROR`, `MVN`, `UXT*`, `SXT*`, `CLZ`, `REV*`) whose
> destination is written again later in the same block, before anything reads
> it, is dropped.

"Written again inside the block" is exactly why no liveness is needed: a block
has one entry, so the later write happens on every path through it, and no read
can observe the old value.

**A `MOVW`+`MOVT` pair is one unit.** Dropping half of it leaves a different
value in the register, so the implementation fuses the pair into a single unit
(`nlines == 2`) and the rebuild copies or drops it whole.

## 3. Block boundaries and the read set

A block ends (state is cleared) at:

- a label (`.L...:` / a function name);
- any branch: the `B` family, `BL`, `BX`, `BLX`, `CBZ`/`CBNZ`, the ten conditional forms;
- `IT` -- the instructions under it are conditional;
- `POP` / `LDM*` / `STM*`;
- **any mnemonic that is not on the whitelist** (an unknown instruction may write a
  register or set flags, so it is a boundary by default).

Comments, `.loc`/`.file` directives and blank lines are not boundaries: they have
no register or flag effect.

Mnemonic comparison is **case-insensitive**: the emitter prints `bx`, `rev16`,
`revsh`, `rrx` in lower case, and also prints conditional forms such as `MOVNE`,
`MOVEQ`, `MOVHI`, `MOVLS`, `MOVLT`, `MOVGE`. Conditional forms are not on the
whitelist, so they are boundaries.

### 3.1 The read set: two fatal mistakes that were caught

"Which operands count as reads" is the one real trap in this family. The first
version got it wrong twice, and both were **real miscompiles**:

1. **A two-operand ALU instruction reads its own destination.** `MUL r0, r7` is
   `r0 = r0 * r7`: `r0` is both destination and source. The first version took
   "everything minus the destination" as the read set, so in `MOV r0, r5` +
   `MUL r0, r7` the copy was treated as dead, deleted, and the program read a
   stale `r0`. Fix: the source part is only what follows the first comma, plus
   the destination when `cm_is_rmw()` says the form is a two-operand
   read-modify-write.
2. **The first operand of `STR` is a source.** The first version assumed
   `operands[0]` is always a pure destination, so `STR r0, [r6, #24]` looked like
   a write of `r0` and the `MOV r0, #0` in front of it was deleted -- the store
   wrote garbage. Fix: for `STR` / `STRB` / `STRH` / `CMP` / `CMN` / `TST` /
   `PUSH` / `NOP` the read set scans the **whole** operand string.

The `strfirst` fixture in the gate is the regression guard for the second
mistake: the only consumer of `MOV r5, r0` is `STR r5, [r1]`, so a pass that
treats `STR` as a write deletes the copy and stores something other than 5.

## 4. Refused on purpose

- `ADD` / `SUB` / `AND` / `ORR` / `EOR`: they may set flags, and the corpus is
  full of `ADD rX, rB, #0` used as a copy -- treating it as a copy would change
  the value domain;
- `MUL`: `MULS` sets N/Z;
- write-back / post-indexed addressing;
- register indexes other than a plain `LSL #s` (`LSR`/`ASR`/`ROR` index, `RRX`);
- offsets beyond 4095;
- any deletion that would need liveness analysis to prove (end of block, across blocks).

## 5. One rule that did not survive

The first draft also had a fourth rule: drop a whole `MOVW`+`MOVT` pair when the
register already held that constant.

Measured on the corpus it fires **zero** times: between two pairs with the same
value there is always a read of the register (which clears the state), and when
there is no such read the first pair was dead for a different reason anyway.
Following "do not keep code that never fires", the rule and its state
(`pknown`/`pval`) were removed and the rules renumbered to M1/M2/M3. It is
recorded here because it is itself a conclusion: **this shape does not occur in
the corpus.**

## 6. Measurements (whole HAL corpus, 95 TUs, Cortex-M4, `-O2 --reloc-data`)

Baseline = the twelve 0.9.1 switches
(`vstack addr strength cbz branch imm peep cbranch copyprop live prop deadpush`):

| build | instructions | change |
| --- | ---: | ---: |
| baseline (twelve switches) | 19,066 | -- |
| + `-fopt-cmat` | **18,729** | **-337 (-1.77%)** |

Mnemonic account (counted line by line over the same `.s` files):

| mnemonic | baseline | + cmat | delta |
| --- | ---: | ---: | ---: |
| `MOV` | 3,888 | 3,551 | **-337** |
| everything else | 15,178 | 15,178 | 0 |

A full line-by-line diff splits the 337 into three sources:

| rule | hits | shape |
| --- | ---: | --- |
| M3 (drop neutral write) | **337** | 530 `MOV` lines deleted, 193 of them re-added by M1 |
| M1 (copy to immediate) | 193 | all `MOV rD, rS` -> `MOV rD, #k`, no count change |
| M2 (fold index) | 180 | `LDR` 168 + `LDRB` 12, same address, one operand fewer |

At 4 bytes per Thumb-2 instruction the code is about **1,348 bytes** smaller.
(This number is derived, not measured: the corpus is assembled per TU with `-S`,
so no linked image exists to measure.)

## 7. Where it lives

`src/backend/arm/backend_arm.c`, one `#if ARKCC_FEATURE_OPT_CMAT` block placed
right after `-fopt-regalloc` and before `ark_fix_far_offset()`:

| function | role |
| --- | --- |
| `cm_streq` | case-insensitive mnemonic compare |
| `cm_trim` | strip leading blanks and the trailing CR (give up if it does not fit) |
| `cm_split` | split into "mnemonic + rest" |
| `cm_reg` / `cm_imm` | `rN` (0..12) / `#decimal` |
| `cm_first_reg` | `rA, rest` |
| `cm_write_first` | is the first operand a pure destination |
| `cm_neutral` | is the mnemonic a flag-neutral write |
| `cm_boundary` | does it end the block |
| `cm_is_rmw` | two-operand read-modify-write (`MUL rD, rS`, `LSL rD, rS`, ...) |
| `cm_uses` | the read set (section 3.1) |
| `cm_mem_idx` | recognise `[rB, rI(, LSL #s)]` |
| `ark_cmat_function` | the pass: line table -> unit table (fusing MOVW/MOVT) -> walk the three rules -> rebuild |

`-fopt-cmat` is **off by default**. Under `ARKCC_PROFILE_STM32_MIN` the macro is
0, so neither the code nor the static tables are in the image, and a cropped
build refuses the flag (`C3900U`) while naming the macro. The static tables are
about 300 KB of BSS and exist only in host builds.

## 8. Gate (`make test-cmat`)

`tests/run_cmat_tests.py`, seventeen checks:

1. **OFF IS OFF**: the default build and `-fno-opt-cmat` are byte-identical;
2. **M2 fires**: the `LSL #2]` shape goes to zero, `[rB, #off]` becomes more
   frequent, the image never grows;
3. **M1 fires**: `MOV rX, rY` drops while `MOV r1, #0` appears;
4. **M3 fires**: the neutral write overwritten before any read disappears and
   the instruction count drops by at least two;
5. **anti-over-deletion**: `strfirst` (whose copy is read only by `STR`) and
   `big` (`MOVW`/`MOVT` pair) are **byte-identical** in both arms;
6. **the answers stay the same**: three fixtures x three arms (off / on / alone)
   return the Python answer on the emulator;
7. **labels survive**;
8. **a cropped build** refuses the flag by name (`C3900U` + macro) and still
   compiles without it.

As a stronger layer, `tests/arm_exec/run_arm_exec.py --extra=-fopt-cmat` ran the
whole execution suite (function pointers, 64-bit, soft-float, atomics, TLS,
setjmp, ...) on a build with cmat enabled: **0 failures**.