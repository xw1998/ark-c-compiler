# Zero-compare branch folding (`-fopt-cbz`)

English | [中文](CBZ_FOLD.md)

> The sixth optimization of 0.9.1, in one sentence: **when a `CMP rX, #0` is
> immediately followed by `BEQ/BNE`, the pair becomes a single `CBZ/CBNZ` --
> one instruction less, four bytes less, same meaning.**
>
> Implementation: `src/backend/arm/backend_arm.c`, `ark_cbz_function()`
> Gate: `tests/run_cbz_tests.py` (`make test-cbz`), plus the whole `tests/arm_exec`
> corpus
> Switch: `-fopt-cbz` / `-fno-opt-cbz`, INI `opt-cbz=` / `cbz=`

---

## 1. Why, and at which layer

`x == 0` is the most common comparison in C: `if (!p)`, `while (n)`, `if (state)`,
a pointer null check. The emitter dutifully spends two instructions on it:

```asm
CMP  r0, #0        ; 16 bits
BEQ  .L_end        ; 32 bits (B<cond>.W, T3)
```

ARMv7-M has an instruction pair made exactly for this: `CBZ rX, label` (branch
if zero) and `CBNZ rX, label` (branch if not zero). Both are 16 bits, `rX` is
the register that was compared, and the `#0` does not need an instruction of
its own. So the two lines above become one:

```asm
CBZ  r0, .L_end    ; 16 bits
```

What is saved is **one instruction and four bytes** (see §6: this backend
always emits the conditional branch in the 32-bit T3 form, so `CMP` + `Bcc` is
2 + 4 while `CBZ` is 2).

The layer is the same as `-fopt-vstack` / `-fopt-addr`: **function-level text
rebuild after emission**. The reasoning is the same too -- doing it in the IR
would mean touching irgen/MIR and all four backends, whereas a text pass that
does not recognise a shape leaves it alone, so **the worst case is a missed
fold, never a wrong instruction**.

## 2. The rule

Scan the function's assembly lines in order. For every `CMP rX, #0`:

| Condition | Test |
| --- | --- |
| **C1 adjacency** | the next line that is neither blank nor metadata is `BEQ` or `BNE` (metadata lines such as `.loc`/`.CFI` may sit in between; they emit no bytes) |
| **C2 operands** | the two operands of the `CMP` are exactly `r0`..`r7` and `#0`; the branch target is a single symbol starting with `.` with no space, comma or `[` |
| **C3 forward and bounded** | that symbol is defined **later**, and the upper bound on the bytes between the branch and the label is at most 64 |
| **C4 flags are dead** | scanning forward from the line after the branch, a flag writer, a return, or the function exit is reached before any flag reader |

All four hold ⇒ rewrite the `CMP` line as `CBZ rX, .L_x` (`CBNZ` for `BNE`) and
mark the branch line for deletion.

`r8`..`r12` are never folded even if they appear in the `CMP`: `Rn` is a
**three-bit field** in the T1 encoding and only covers `r0`--`r7`. An early
design note had this wrong (it said r0--r12); the encoding table corrected it.

## 3. Why the offset is "region bytes − 2"

The T1 encoding is `imm5 = offset / 2`, and `offset` is relative to **PC**
(address of this instruction + 4). Every address shifts when the pair is
fused, which is easy to get wrong, so the derivation is written down here.

Let the `CMP` sit at `p`, the branch at `p+2`, and let there be `R` bytes
between the branch and the label. The label is at `p+2+4+R = p+6+R`.

After folding the `CBZ` sits at `p` (it reuses the two bytes the `CMP` had),
the four bytes of the branch are gone, so the label moves to `p+2+R`, while the
`CBZ`'s PC is `p+4`. Therefore

```
offset = (p+2+R) - (p+4) = R - 2
```

**independent of how far the label was from the `CMP` originally** -- the
deleted `CMP` and the deleted branch sit at the two ends and their shifts
cancel. So only `R` has to be measured: `R ≤ 64` ⇒ `offset ≤ 62` (the T1
limit), and "at least one instruction in the region" gives `R ≥ 2`, i.e.
`offset ≥ 0`.

## 4. Conservative upper bound: why the bytes are not counted exactly

The text layer cannot see the layout (instruction widths are decided by the
assembler's first pass), so `R` is estimated: **every instruction counts as 4
bytes, metadata lines as 0, `LDR rX, =sym` (expanded to `MOVW`+`MOVT`) as 8**.
That is an upper bound, hence

- upper bound ≤ 64 ⇒ the real `R` is certainly ≤ 64 ⇒ the emitted `CBZ` is
  certainly in range;
- when the upper bound exceeds 64 the site may still have been fusable; it is
  simply given up.

If the region contains any data directive (`.word`/`.align`/`.skip`/`.ascii`),
the candidate is dropped outright -- their width is not "one instruction, 4
bytes" and nothing about them is guessed.

Missing a fold beats emitting a wrong one; that is this pass's first design
constraint. The price is that a region made entirely of 16-bit instructions is
over-estimated by 2× and some sites that would have fitted are refused (hence
394 out of 814 in §6).

## 5. The flag scan (C4): why "the compiler never reads stale flags" is not enough

The only purpose of the `CMP` is to write the flags, so folding is legal only
if nobody reads them afterwards. The emitter does not, but this assembly may
contain

- inline assembly (`__asm`) -- whatever the user wrote;
- hand-written runtime helpers;
- an `ADC`/`SBC` or an `IT` block inserted by some future pass.

Hence C4 scans instead of assuming:

| Encountered | Verdict |
| --- | --- |
| flag writer: `CMP/CMN/TST/TEQ`, any `S`-suffixed ALU (`ADDS/SUBS/ANDS/…`) | **safe**, stop scanning |
| flag reader: `ADC/SBC/RSC`, `IT`, any conditionally executed instruction | **unsafe**, drop the candidate |
| return: `BX lr`, `BLX`, `POP {…, pc}` | **safe** (this function never looks at the flags again) |
| `BL` | **safe** (AAPCS does not preserve NZCV across a call, so the old `CMP` result cannot be read past it; see section 14) |
| unconditional `B .L_x` | **follow** the target and keep scanning (at most 4 hops, 64 steps) |
| anything else | keep scanning; reaching the end of the function still undecided ⇒ safe |

Following `B` is not a nicety, it is **required**: every `if` body ends with a
`B .L_end`, and the first version treated `B` as unsafe, which fused exactly
zero sites in the HAL corpus. Following the target fused 5/5 in the fixture.

## 6. Measurements

Instruction counts are the non-directive, non-label lines of the `.s`; bytes are
the whole `.o` (in our object format the text section is the raw bytes and the
symbol table is small).

| Corpus | plain `-O2` | `+ -fopt-cbz` | Change |
| --- | --- | --- | --- |
| STM32F4 HAL (`examples/ark_test/ark_test_all.c`, `-O2 -mcpu Cortex-M4`) | 47,885 | **47,491** | **−394** |
| same, on top of `-fopt-vstack -fopt-addr -fopt-strength` | 32,901 | **32,478** | **−423** |
| same, object bytes (plain `-O2`) | 115,090 B | **113,506 B** | **−1,584 B** |
| same, object bytes (full chain) | 86,940 B | **85,240 B** | **−1,700 B** |

The byte columns are measured, not `count × 4`: the deleted pair varies in width
(16-bit `CMP` + 16-bit `B` saves 2 bytes, 16-bit `CMP` + 32-bit `B` saves 4, and a
wide `CMP.W` with a wide branch saves 6), so the average lands just above four bytes
per fusion. The instruction-count column is the reproducible criterion. §1 explains
why the pair costs what it costs: a 16-bit
`CMP` plus a 32-bit conditional branch is 6 bytes, `CBZ` is 2.

**Why 394 and not all of them**: the HAL corpus contains **814** adjacent
"`CMP rX,#0` followed by `BEQ/BNE`, local label, register in r0--r7" pairs; 394
were fused. The rest fall into three bounds:

- **the 64-byte upper bound**: a large `if` body does not fit (T1 has ±62 bytes
  and nothing else);
- **the flags are still read** (§5), typically because the body contains `BL`;
- a top-level `if (x == 0) { ... }` whose label sits at the end of the function,
  where the region is often hundreds of bytes.

The split between the three was not attributed site by site, so no split is
reported here.

## 7. What the gate says

`make test-cbz` (`tests/run_cbz_tests.py`) runs two fixtures over five arms:

- `short`: 6 fusable sites (including `if (s == 0) s = 7;` and one call);
- `long`: an `if` body of 20 statements, upper bound 80 bytes -- **none of it
  may be folded**;
- arms: `base` (`-O2`), `off` (`-O2 -fno-opt-cbz`), `on` (`-O2 -fopt-cbz`),
  `va` (`-fopt-vstack -fopt-addr`), `all` (plus `-fopt-cbz`).

14 checks, all ok:

1. **OFF IS OFF**: `-O2` and `-O2 -fno-opt-cbz` produce byte-identical images
   (1716/1716).
2. **CBZ only with the flag**: `base=0 / on=6`.
3. **The count really drops**: `310 → 304`.
4. **The adjacent pairs are consumed**: `CMP #0`+`BEQ/BNE` adjacent pairs
   `base=6 / on=0`.
5. **It still pays on top of the others**: `va` 216 → `all` 210.
6. **The pass runs after the other two**: `CBZ=6` in the `all` arm (the other
   order would have its work rewritten by vstack/addr).
7. **The image never grows**: `base/on = 1716/1692`, `va/all = 1528/1504`.
8. **All five arms agree**: `23/23/23/23/23`.
9. **An out-of-range body is not folded**: `on=0 / all=0` on `long`.
10. **Nothing is rewritten when the target is too far**: `357 → 357`.
11. **The image does not change because of the refusal**: `1768/1768`,
    `1450/1450`.
12. **All five arms agree (long body)**: `195 × 5`.
13. **A cropped build refuses the flag by name** (`C3900U`, exit code 1).
14. **A cropped build still compiles without the flag** (exit code 0).

There is also a whole-corpus execution equivalence run:

```
tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-cbz"
```

Checks 3/4 matter: asserting only "CBZ appeared" would miss a half fusion
(`CMP` deleted, branch left), and a half fusion assembles happily while the
conditional branch silently takes the wrong path on hardware. Checks 9/10/11
guard the upper bound -- a wrong bound produces an out-of-range `CBZ` which the
assembler rejects as a hard error, but that still means breaking a program that
had to compile.

The defect actually hit during development was **rebuilding from the trimmed
lines**: the indentation of the whole function vanished and it looked as if
fifty thousand lines had changed (the instruction count fell from 47,885 to
13,966). Each line now keeps both the original text (what the rebuild writes)
and the trimmed text (what the analysis reads); only the fused line is
replaced.

## 8. Cropping

`ARKCC_FEATURE_OPT_CBZ` in `include/arkcc_config.h`: 0 under
`ARKCC_PROFILE_STM32_MIN`, 1 for host / cross builds. At 0 the whole
`ark_cbz_function()` is preprocessed away and `src/main.c` rejects the flag with
`C3900U: -fopt-cbz is not compiled into this build` (rejected rather than
silently ignored).

It is off at run time by default (`g_config.enable_opt_cbz = 0`), so a build
without the flag is byte-identical to 0.9.0.

**`CBZ`/`CBNZ` are not in the `--asm-extra` list**: the assembler accepts both
mnemonics unconditionally. The reason is the same convention that governs
`ADDS`/`SUBS`/`MRS`/`MSR` -- **the compiler has to be able to assemble its own
output** -- and `ARKCC_FEATURE_ASM_EXTRA` is 1 in every profile, so leaving them
in the list only spelled "unconditional" as "conditional". Their encodings are
still checked byte for byte by `tests/asm_cases/05_pcrel.s`.

## 9. Pass order

```
ark_vstack_function()      # shorten the function first: drop PUSH/POP
ark_addr_function()        # then fold ADD/MOV into addressing modes
ark_cbz_function()         # look for CMP #0 + branch in the final shape (first sweep)
ark_regalloc_function()    # then allocate registers on the shorter stream
...                        # peep / copyprop / live / vreg / slotreg / cmat / litpool
ark_cbz_function()         # sweep once more after every rename (second sweep, §12)
ark_frame_function()       # frame trimming, last
```

Two practical reasons for running last:

- vstack/addr delete the lines between `CMP` and the branch (`MOV`/`ADD`); run
  cbz first and it sees a pair that is not adjacent and gives up. The other way
  round, after cbz removes the `CMP` there is nothing left for vstack to do.
- `regalloc` pins values to fixed registers, after which whether `rX` happens to
  land in r0--r7 is arbitrary; running first uses the emitter's own numbering.

**No four-way order comparison was run**, so no "how much does the order cost"
number is reported.

Only the first half of this diagram is about ordering. The second sweep is not an
ordering question at all: it targets sites the first sweep cannot see. Reasons and
numbers are in §12.

## 10. Three things deliberately not done

| Not done | Why |
| --- | --- |
| folding `TST rX, rX` + `BEQ/BNE` into `CBZ/CBNZ` | the emitter always emits a zero comparison as `CMP rX, #0` (0 `TST` out of the 814 adjacent pairs measured), so the rule would be dead code |
| a short conditional branch (`B<cond>` T1, 16 bits) | that is **a different job**: this backend always emits the 32-bit T3 form (see the comment in `size_pass`: it avoids ±256-byte truncation in large functions). Doing T1 needs a layout fixed point. This fusion eats a share of it incidentally (the 32-bit branch disappears) but there is no separate short-branch pass |
| the 32-bit T2 `CBZ` (±64 KB, any `r0`--`r15`) | the saving is the same (one instruction) but it costs another encoding path and another gate; T1 covers 99% of `if`s |

## 11. Known cost

The region upper bound counts 4 bytes per instruction, so a site whose whole
body is 16-bit instructions is over-estimated by 2× and a fusable site is
refused. That is the other side of "miss rather than err", the same character
as the 64-instruction forward scan limit in `-fopt-addr`.## 12. The second sweep: run it again on the final text

### 12.1 Why one sweep is not enough

The first `ark_cbz_function()` runs after `vstack` / `addr` but *before* `peep` /
`copyprop` / `live` / `regalloc` / `vreg` / `slotreg` / `cmat` / `litpool`. That is
the position §9 argues for (work on the shortest text), and the price is that it
cannot see the `CMP rX, #0` + `BEQ/BNE` pairs those passes **create**:

- `cmat` drops the constant materialisation that fed the compare, so the `CMP`
  operand becomes a bare register;
- `slotreg` deletes a load that `rX` already satisfied, which makes the `CMP` and
  the branch adjacent;
- `litpool` turns a `MOVW`/`MOVT` pair into one `LDR`, shortening the byte distance
  from branch to label, so a site that was over the 64-byte bound falls back into
  range;
- the renames in `regalloc` / `vreg` move the compared register into `r0`--`r7`, and
  the T1 form of `CBZ` only takes low registers. This is the most direct of the four.

These are not guesses: in the corpus census, **180** adjacent `CMP rX, #0` + conditional
branch pairs were still present after the first sweep had fused everything it could
prove.

### 12.2 How

Call `ark_cbz_function()` a second time, after the second `live`, the second `peep`
and the second `addr`, and before `frame` trimming:

```c
/* Second CBZ sweep, for the same reason as the second liveness, peep
 * and addressing sweeps: ... */
if (g_config.enable_opt_cbz) ark_cbz_function(&buf, fstart);
```

Same flag (`-fopt-cbz`), same rule set: **no new option**, so the cropping table, the
`--asm-extra` list and the switch inventory in `docs/BUILD.md` are untouched (still
23). With the flag off the block does not run at all, so the byte-identical
`OFF IS OFF` assertion is unaffected.

Safety comes from the rule itself: when the region bound cannot be proven or the
flags are read inside the body (§4, §5), this sweep declines the site exactly like
the first one. A second run can therefore only fuse what *became* provable since —
the same argument as for the second liveness, peep and addressing sweeps.

### 12.3 Measurements

95 translation units (STM32F4 HAL + application), `-O2 -mcpu Cortex-M4`, switches =
the 19-switch set + `frame` / `voldmb` / `constcond` (22 `-fopt-` switches).
`-fopt-volbar` is deliberately outside this accounting: it is a semantics switch that
really emits the barriers the front end marks (2,848 `DMB SY` on this corpus), not a
size optimisation.

| | before second sweep | after second sweep | change |
| --- | --- | --- | --- |
| instructions | 12,266 | **12,215** | **−51 (−0.42%)** |
| object bytes | 405,514 B | **404,970 B** | **−544 B (−0.13%)** |
| compile errors | 0 | 0 | — |
| `DMB SY` | 1 | 1 | — |

Both readings come from the same binary: the second-sweep call was commented out,
the compiler was rebuilt, and the corpus re-measured, so −51 is a same-build delta and
not a cross-build comparison. No single translation unit grew.

Census re-check on the same build: adjacent `CMP #0` + conditional branch pairs fall
from **146** to **95**, which is exactly the 51 the second sweep fused. The remaining
95 are still blocked by the 64-byte bound of §4, by flags being read inside the body
(§5), and by bodies whose target label sits at the end of the function — they are
refused, not missed.

> **Why the older numbers are not directly comparable.** This section used to record
> 12,034 → 11,966 (−68). Those were measured on a build *before* the miscompiles in the
> second `-fopt-addr` sweep (dropped immediate offset), `-fopt-frame` (frame-base
> offset), `-fopt-slotreg` (out-of-frame load) and `-fopt-vreg` (read-modify-write
> rename) were fixed — see `docs/ADDR_FOLD.en.md` §12, `docs/FRAME_TRIM.en.md` §6,
> `docs/SLOTREG.en.md` §11, `docs/VREG.md` §18.6. Fixing them stops a number of sites
> from being folded incorrectly, so the instruction count rises to 12,266. The two
> numbers are not the same code and must not be subtracted to claim a win.

### 12.4 Gates

All 14 checks of `make test-cbz` pass (same assertions: `base=0 / on=6`,
`va 216 → all 210`, the `long` arm fuses nothing, the cropped build answers
`C3900U`); `tests/arm_exec` reports 0 failures over the whole corpus; the cropping
self-check still reports 23/23 `C3900U`.
## 13. Revision (2026-11-25): three more real defects when combined with `-fopt-cmat` / `-fopt-live`

`-fopt-cbz` itself is not wrong; the defects are in the shape it hands to two other
text passes, which then misread it. All three were real miscompiles or hard errors and are
fixed.

### 13.1 cmat's M8 read set missed the `CBZ`/`CBNZ` register

`cm_modelled` did not list `CBZ`/`CBNZ` and `cm_no_reg_effect` called them branches that
read nothing, so M8's per-block use set had no operand for them; the successor search used
`cm_label_block(nb, u->ops)` over the *whole* operand string, while the target of
`CBZ r0, .L_x` sits after the comma, so the branch edge was **missing entirely**. Result:
`if ((a==b)&&(b==c))` under `-fopt-cbz -fopt-cmat` lost the `MOV r0, #0` before the join as
a dead write, `CBZ r0` read a stale `r0`, and `&&` returned 1 instead of 0.

Fix (four places): list `CBZ`/`CBNZ` in `cm_modelled`; keep them block boundaries in
`cm_boundary`; make `cm_no_reg_effect` report that they read op0; add a CBZ/CBNZ successor
branch that takes the label after the comma. See `docs/CMAT.md` section 3.2.

### 13.2 live did not treat `CBZ`/`CBNZ` as branches

See `docs/LIVE.md` section 14, item 1: `lv_branch_kind` only knew `B`-prefixed mnemonics, so
the block end and the target edge were both missing, `-fopt-vreg` promoted a loop bound
register without its prologue copy, and the loop compared garbage (17 -> 2).

### 13.3 `CBZ r8`: live retarget plus encoder masking

See `docs/LIVE.md` section 14, items 2 and 3. In short: L2 retargeted `CBNZ r0` onto `r8`,
T1 only encodes r0-r7 and the encoder masks with `&7`, so it **silently** became `CBNZ r0`;
and `lv_repl_reg` cut long labels to 7 characters, turning `.L_HAL_RCC_OscConfig_0` into
`.L_HAL_R` (an undefined label). Both fixed; the assembler now rejects `CBZ r8` by name.

### 13.4 Readings and gates

Same build, 95 TUs, 23 switches: 12,239 -> 12,266 instructions (+27), 405,426 -> 405,833 B
(+407); no TU shrank. The growth is the `MOV r0,#0/#1` restored at joins and the parameter
stores that are no longer deleted by mistake.

`make test-cbz` gains sections 6 and 7: a six-switch fixture (long function name plus a
promoted parameter) returns 17, the output contains no `CBZ/CBNZ r8-r12`, every branch target
is defined, and the assembler refuses `CBZ r8`. Against the pre-fix binary all three go red.

## 14. Revision (2026-11-25): `BL` means "flags are dead", not "flags unknown"

Section 5 used to treat `BL` as **unsafe**, on the grounds that "the flag state
after the call is unknown".  That sentence is true; the conclusion was backwards.
It is *because* the flags after a call are not the ones `CMP` set that **nobody
reads** them, which is exactly what makes the fusion legal.  AAPCS lists NZCV as
**not preserved across a call** (caller-saved), so past a `BL` the flags belong
to the callee and this function cannot depend on the old `CMP`.

The change is one line in `cbz_flags_dead()`:

```c
- if (cbz_ieq(mn, "BL")) return 0;   /* conservative: state unknown after the call */
+ /* A plain call kills the flags: AAPCS does not preserve NZCV across a
+  * call, so whatever CMP set cannot be relied on past a BL.  Treating
+  * the call as "flags are dead from here" is what lets a CMP #0 + Bcc
+  * pair fuse into CBZ when the fall-through path leads into a call. */
+ if (cbz_ieq(mn, "BL")) return 1;
```

Conditional calls (`BLEQ` and friends) never reach this line: a condition suffix
makes `cbz_reads_flags()` classify them as flag readers first, so only an
*unconditional* call was relaxed.

### 14.1 The old rule was not the safer one

Treating `BL` as unsafe assumes the function might rely on flags surviving a
call.  Under AAPCS such code is not portable in the first place (the callee may
`CMP` freely), and arkc's emitter never produces it: every conditional branch is
preceded by a fresh `CMP`.  So the old rule protected no real code -- it only
made the most common shape, `if (cond) { ...call... }`, impossible to fuse.

### 14.2 Readings

95 TUs, 24 switches (without `-fopt-exit`), `-O2 -mcpu Cortex-M4`, same build
differentially:

| | before | after | change |
| --- | --- | --- | --- |
| instructions | 12,146 | **12,110** | **-36** |
| object bytes | 403,994 B | **403,620 B** | **-374 B** |
| TUs touched | -- | 8 | all shrank, none grew, 0 errors, 0 dangling |
| `CMP rX,#0` + branch left over | 100 | **62** | -38 |

Per TU (instructions): `stm32f4xx_hal_rcc` -12, `stm32f4xx_hal_rcc_ex` -12,
`hal_pwr_ex` -4, `main` -2, `hal_flash` -2, `ll_utils` -2, `hal_dma` -1,
`hal_flash_ex` -1.

On top of the 25-switch chain (adding `-fopt-exit`): 11,913 -> **11,877**
instructions, 400,499 -> **400,125** B, same direction, and the -233 instructions
from `-fopt-exit` are unchanged (the two passes do not interfere).

### 14.3 Two more pairs than instructions, and why that is not a miscount

The leftover pairs drop by 38 while instructions drop by 36.  The two extra come
from **high-register sites**:

```asm
CMP r10, #0        ; T2, 4 bytes
BEQ.W .L_x         ; 4 bytes
        ->
MOV r0, r10        ; 2 bytes
CBZ r0, .L_x       ; 2 bytes
```

Two instructions replace two -- no instruction saved, four bytes saved.  This
shape is produced when the first `cbz` sweep fuses the site and `-fopt-live`
then forwards the value into the `CBZ` (see `docs/LIVE.md` section 14), so the
number of fused sites need not equal the instruction drop.  The verdict is read
off instructions and bytes; site counts are commentary.

### 14.4 Gates: 29 checks, and they go red if you revert

`make test-cbz` grows from 19 to **29** checks; the original 19 readings are
unchanged (`base=0 / on=6`, `short 310 -> 304`, `long` fuses nothing).  Two new
sections:

- **8. A call kills the flags.**  Fixture `CALL`: `if (a) g_cbzbl = cbzbl_callee(3);`
  -- the body is "fetch argument + `BL` + store back", comfortably inside the T1
  range, so the only open question is the flags.  Asserts: the `off` arm has 3 of
  its 4 pairs whose fall-through reaches a `BL` first, the `on` arm turns all 3
  into `CBZ/CBNZ`, `cbz-before-call off=0 / on=3`, instructions 229 -> 226, the
  image never grows, and **both arms return 20** (the call really happens; it was
  not deleted as if it were a branch).
- **9. A fall-through that reads the flags keeps the pair.**  Fixture `FLAGREAD`:
  the body opens with inline asm `ITE EQ / MOVEQ / MOVNE`, i.e. it consumes the
  very flags `CMP` set.  Asserts: pairs `base=1 / on=1`, `on` and `off` are
  **byte-identical** (2,223 bytes of text, 1,224 bytes of image), and it returns 1.

Both are "revert it and they go red" shapes, verified: switching `return 1` back
to `return 0` and rebuilding turns the four section-8 assertions red
(`cbz-before-call on=0`, `pairs 4 -> 4`, `cbz 0 -> 0`, `229 -> 229`) while section
9 stays green (it guards the other direction).

Whole-corpus execution equivalence (`tests/arm_exec`, single flag and a nine-flag
combination) reports 0 failures; `make test` exits 0.
