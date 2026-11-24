# The structural gap against armcc: an honest boundary note

> This file answers one question: **with all sixteen `-fopt-*` passes of 0.9.1 switched
> on, why can the compiler still not beat armcc?** The answer is not "a few passes are
> missing" -- it is that this code-generation model does not produce armcc's kind of
> code. The note splits the gap into checkable rows, states what is left to win as a
> bounded quantity, and says plainly what is **not** promised.
>
> The measurement contract is exactly the one in `docs/COMPARISON.en.md` section 1
> (95 valid TUs, Cortex-M4, `-O2`, no link-time optimisation, no library functions).
> The only difference is purpose: COMPARISON records what each optimisation earned,
> this note records what cannot be earned.

## 1 Verdict

| Compiler | Instructions | Code bytes |
| --- | ---: | ---: |
| arkc (all eighteen `-fopt-*` on) | 14,218 | 36,072 |
| armcc 5.06u7 `-O2` | 5,619 | 13,920 |
| armclang `-O2` | 5,064 | 13,848 |
| armclang `-Oz` | 4,246 | 11,284 |

Against armcc `-O2` that is **2.53x instructions / 2.59x bytes**; against armclang `-O2`
2.81x / 2.60x, and against `-Oz` 3.35x / 3.20x.

**In one line**: of the 8,599 instruction gap, **6,277 (73%) sit in one group of
"value transport" categories** (section 3); the remaining 2,322 are spread over address
computation, comparisons, branches and barriers. This is not "some passes are missing" --
it is the model-level price of **every intermediate value crossing a register or memory**.

## 2 Instruction mix (three arms, same corpus)

Mnemonics are normalised first (condition codes and `S` suffixes folded, so `MOVS`/`MOVEQ`
all count as `MOV`), then `MOV` is split into register-to-register and immediate. The
percentages are of each arm's own total. The reproduction script is in section 7.

| Category | arkc | armcc `-O2` | armclang `-O2` |
| --- | ---: | ---: | ---: |
| `MOV` immediate | 2,003 (14.1%) | 412 (7.3%) | 693 (13.7%) |
| `MOVW`+`MOVT` | 1,740 (12.2%) | **0** | 380 (7.5%) |
| literal pool `LDR [pc]` | **0** | 391 (7.0%) | **0** |
| `MOV` register to register | 1,241 (8.7%) | 191 (3.4%) | 109 (2.2%) |
| `PUSH`/`POP` | 1,239 (8.7%) | 154 (2.7%) | 144 (2.8%) |
| frame access `[r6, #n]` | 856 (6.0%) | 45 (0.8%) | 147 (2.9%) |
| other memory | 1,746 (12.3%) | 1,209 (21.5%) | 1,192 (23.5%) |
| `[sp]` access | 0 | 46 (0.8%) | 116 (2.3%) |
| `ADD`/`SUB`/`ADC`/`SBC`/`RSB`/`NEG` | 1,493 (10.5%) | 194 (3.5%) | 173 (3.4%) |
| compare `CMP`/`CMN`/`TST`/`TEQ` | 845 (5.9%) | 479 (8.5%) | 311 (6.1%) |
| branch (incl. `BX`) | 1,546 (10.9%) | 1,284 (22.9%) | 672 (13.3%) |
| `BL`/`BLX` | 182 (1.3%) | 153 (2.7%) | 115 (2.3%) |
| logic `AND`/`ORR`/`EOR`/`BIC`/`MVN`/`ORN` | 772 (5.4%) | 394 (7.0%) | 498 (9.8%) |
| shift | 219 (1.5%) | 231 (4.1%) | 250 (4.9%) |
| extend / bitfield / `REV` | 81 (0.6%) | 203 (3.6%) | 35 (0.7%) |
| `IT` blocks | 69 (0.5%) | 0 | 128 (2.5%) |
| barriers / system | 150 (1.1%) | 12 (0.2%) | 42 (0.8%) |
| other | 23 (0.2%) | 218 (3.9%) | 55 (1.1%) |
| **total** | **14,218** | **5,619** | **5,064** |

Two readings have to be stated up front:

- **armcc's `MOVW`/`MOVT` count is 0**: it puts 32-bit constants in a literal pool
  (391 `LDR [pc]`), while we spend two instructions per constant. That is not "armcc
  optimises better", it is **two different constant-materialisation strategies**.
- **armcc's branch share (22.9%) is higher than ours**: its control flow is merged less
  and every function ends in `BX lr`. We are 262 instructions *ahead* in that row.

## 3 Decomposition of the gap: 73% is value transport

Adding up the five rows of section 2 that move a value from where it is produced to where
it is used:

| Category | arkc | armcc | difference |
| --- | ---: | ---: | ---: |
| `MOV` immediate | 2,003 | 412 | +1,591 |
| `MOVW`+`MOVT` | 1,740 | 0 | +1,740 |
| `MOV` register to register | 1,241 | 191 | +1,050 |
| `PUSH`/`POP` | 1,239 | 154 | +1,085 |
| frame access `[r6, #n]` | 856 | 45 | +811 |
| **subtotal** | **7,079 (49.8%)** | **802 (14.3%)** | **+6,277** |

**Those 6,277 instructions are 73.0% of the 8,599 total gap.** The other 27%:

| Category | difference |
| --- | ---: |
| `ADD`/`SUB` etc. (address recomputed every time) | +1,299 |
| other memory | +537 |
| logic | +378 |
| compare | +366 |
| branch | +262 |
| barriers / system | +138 |
| `IT` blocks | +69 |
| `BL` | +29 |
| multiply | +10 |
| literal pool | -391 |
| extend / bitfield | -122 |
| shift | -12 |
| other | -195 |
| **subtotal** | **+2,322** |

## 4 Three structural causes (each maps to the numbers above)

### 4.1 The value stack: every expression node really spills

The backend evaluates expressions on a value stack: push a value, pop two, push the
result. `-fopt-vstack` folds **adjacent** `PUSH`/`POP` pairs into register moves, and
`-fopt-vreg` promotes every slot mentioned only as `LDR`/`STR [r6, #n]` into `r8-r11`;
together they cut frame accesses from 3,213 to 856 (-73%). But **the model is unchanged**:
an intermediate value that lives past one statement boundary can only go to a frame slot
or a pool register, so `MOV` immediate 2,003 + `MOV` register 1,241 + `PUSH`/`POP` 1,239
stay right where they were. armcc keeps intermediates in `r0-r3`; its three rows total 757.

### 4.2 Every intermediate value passes through `r0`

The backend is single-accumulator: any "result the next node will consume" goes through
`r0`. Of the 411 `MOV rX, r0`, only 66 directly follow a `BL`; of the 376 `MOV r0, rX`,
only 31 sit within three lines of a `BL` -- the rest are nodes handing values to each
other. The 532 `PUSH {… r0 …}` are the direct bill for this design: only 46 of them are
followed by a matching `POP {r0}` within six lines, so the other 486 really do **store an
intermediate to memory and load it back**.

### 4.3 Addresses are recomputed every time

`ADD`/`SUB` 1,493 against armcc's 194 (+1,299). Every struct-field access recomputes
"base + offset"; there is no "keep the base in a register, put the offset straight into
the addressing mode". This shares its cause with 4.1: the base is an intermediate value
too, and the value stack drops it back into the frame.

## 5 What is left to win (bounded quantities)

The four items below are **measured on the current binary**, not estimated. Each carries
its price, so that "do it or not" is a checkable decision rather than a feeling.

### 5.1 Constant pool: -803 instructions / -2,712 bytes (the only two-digit win)

`MOVW`+`MOVT` occur 803 times (1,606 instructions) and cover only **125 distinct 32-bit
constants** (6.42 materialisations per constant). Going through a pc-relative literal pool
turns each use site into one `LDR`:

- instructions: 1,606 -> 803, **-803 (-5.6%)**;
- bytes: 6,424 -> 3,712 (803 x 4 + 125 x 4), **-2,712 B (-7.5%)**.

The price is real: the pool must **never be reached by fall-through** (jump around it, or
place it after the function's `BX lr`), needs 16/32-bit alignment, needs link-time
relocation (and the interaction with `--reloc-data` has to be re-tested), and needs a
crop macro `ARKCC_FEATURE_LITPOOL`. Both the bound and the work are known: **this is the
only item worth its own slice**.

### 5.2 `PUSH {… r0 …}` 532 (3.7%)

Only 46 of them are followed by `POP {r0}`. Removing the other 486 means changing the
value-stack model (keeping the intermediate in a register) -- the same thing as 4.1,
bounded by the F1 falsifier (close the slice if under 5%).

### 5.3 Repeated constant materialisation 1,865 (13.1%)

`MOV r0, #imm` 999 + `MOV rX, #imm` 866. This **must not be double counted** with 5.1:
after pooling most of these sites still need one `LDR`; what can still go is only "the
same constant materialised several times in one basic block" (`-fopt-constcache` already
took 159, the rest is unmeasured).

### 5.4 Register copies 1,241 (8.7%)

`-fopt-copyprop` / `-fopt-coalesce` / `-fopt-live` already removed the redundant copies
that do not cross a block boundary; what remains needs **inter-block** liveness (the S6b-2
range), and the win is under 5%.

### 5.5 Registered but not done

- **`DMB SY` 139** (armcc 12): every `volatile` write is followed by a barrier, while
  armcc merges them. Whether they can be merged is a semantics question, not an
  optimisation question; **not touched before that is proven**.
- **Short conditional branches (`B<cond>` T1)**: the backend always emits the 32-bit T3
  form; going to T1 needs layout iteration (+/-256 bytes). Same conclusion as
  `docs/COMPARISON.en.md` section 4: the risk is out of proportion to the win.

## 6 What is already done (do not re-invest)

| Stage | Content | Reading |
| --- | --- | --- |
| M1-M9 | constant materialisation, addressing modes, strength reduction, `CBZ`, compare-to-branch, immediates, peephole, copy propagation, liveness | 49,186 -> about 18,7xx |
| S6a | point elision (slot cache + rename elision) | 18,151 -> 17,736 (-415) |
| S6b | whole-block renaming | 18,151 -> 17,350 (-801) |
| S6c | region crosses a call (callee-saved release + two implicit-reader defects) | seventeen switches 14,954 -> eighteen 14,218 (-736) |
| rest | `-fopt-vstack` / `-fopt-cmat` / `-fopt-slotreg` / `-fopt-constcache` / `-fopt-pair` etc. | see `docs/COMPARISON.en.md` section 5 |

All sixteen `-fopt-*` switches are **off by default**, and each one has an OFF IS OFF gate
(with the switch absent the output is byte-identical to the baseline, 95/95 TUs).

## 7 Not promised, and how to re-measure

- **Reaching 5,619 is not promised.** Getting there needs a different code-generation
  model (value stack -> graph-colouring register allocation + constant pool + base reuse);
  that is 0.9.2 work at the earliest. This note changes no criterion and closes no
  already-closed falsifier.
- **Every number here can be re-measured**:
  - instruction mix: `D:/tmp/fr/cmpark_keep.py` (three arkc arms) and
    `D:/tmp/fr/cmp_arm.py` (six armcc/armclang arms) produce the `.s` / `.o` files, then
    `measure_mix2.py` categorises them;
  - constant-pool bound: `measure_gap.py` (counts `MOVW`/`MOVT` pairs and distinct
    constants);
  - three-arm totals: `cmpark_keep.json` / `cmpark_vreg17.json` / `cmp_arm.json`.
- **This table must not be read as** "arkc is unusable": it compiles itself, compiles the
  HAL, and has run on the STM32H743 and the F401 (`docs/BOARD_VALIDATION.en.md`); semantic
  correctness is verified instruction by instruction by `tests/arm_exec` on unicorn. Only
  one dimension is shown here: instruction count and code bytes.
