# The structural gap against armcc: an honest boundary note

> This file answers one question: **with all nineteen `-fopt-*` passes of 0.9.1 switched
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
| arkc (all nineteen `-fopt-*` on) | 13,517 | 34,932 |
| armcc 5.06u7 `-O2` | 5,619 | 13,920 |
| armclang `-O2` | 5,064 | 13,848 |
| armclang `-Oz` | 4,246 | 11,284 |

Against armcc `-O2` that is **2.40x instructions / 2.51x bytes**; against armclang `-O2`
2.67x / 2.52x, and against `-Oz` 3.18x / 3.10x.

**In one line**: of the 7,898 instruction gap, **4,875 (62%) sit in one group of
"value transport" categories** (section 3); the remaining 3,023 are spread over address
computation, comparisons, branches and barriers. This is not "some passes are missing" --
it is the model-level price of **every intermediate value crossing a register or memory**.

## 2 Instruction mix (three arms, same corpus)

Mnemonics are normalised first (condition codes and `S` suffixes folded, so `MOVS`/`MOVEQ`
all count as `MOV`), then `MOV` is split into register-to-register and immediate. The
percentages are of each arm's own total. The reproduction script is in section 7.

| Category | arkc | armcc `-O2` | armclang `-O2` |
| --- | ---: | ---: | ---: |
| `MOV` immediate | 2,003 (14.8%) | 412 (7.3%) | 693 (13.7%) |
| `MOVW`+`MOVT` | 338 (2.5%) | **0** | 380 (7.5%) |
| literal pool `LDR [pc]` | **701 (5.2%)** | 391 (7.0%) | **0** |
| `MOV` register to register | 1,241 (9.2%) | 191 (3.4%) | 109 (2.2%) |
| `PUSH`/`POP` | 1,239 (9.2%) | 154 (2.7%) | 144 (2.8%) |
| frame access `[r6, #n]` | 856 (6.3%) | 45 (0.8%) | 147 (2.9%) |
| other memory | 1,746 (12.9%) | 1,209 (21.5%) | 1,192 (23.5%) |
| `[sp]` access | 0 | 46 (0.8%) | 116 (2.3%) |
| `ADD`/`SUB`/`ADC`/`SBC`/`RSB`/`NEG` | 1,493 (11.0%) | 194 (3.5%) | 173 (3.4%) |
| compare `CMP`/`CMN`/`TST`/`TEQ` | 845 (6.3%) | 479 (8.5%) | 311 (6.1%) |
| branch (incl. `BX`) | 1,546 (11.4%) | 1,284 (22.9%) | 672 (13.3%) |
| `BL`/`BLX` | 182 (1.3%) | 153 (2.7%) | 115 (2.3%) |
| logic `AND`/`ORR`/`EOR`/`BIC`/`MVN`/`ORN` | 772 (5.7%) | 394 (7.0%) | 498 (9.8%) |
| shift | 219 (1.6%) | 231 (4.1%) | 250 (4.9%) |
| extend / bitfield / `REV` | 81 (0.6%) | 203 (3.6%) | 35 (0.7%) |
| `IT` blocks | 69 (0.5%) | 0 | 128 (2.5%) |
| barriers / system | 150 (1.1%) | 12 (0.2%) | 42 (0.8%) |
| other | 23 (0.2%) | 218 (3.9%) | 55 (1.1%) |
| **total** | **13,517** | **5,619** | **5,064** |

Two readings have to be stated up front:

- **armcc's `MOVW`/`MOVT` count is 0**: it puts every 32-bit constant in a literal pool
  (391 `LDR [pc]`). Before 0.9.1 we spent two instructions per constant; with
  `-fopt-litpool` this row dropped from 1,740 to 338 and the "literal pool" row now shows
  701 (310 more than armcc). Same strategy, different completeness -- of the 338 that
  remain (`MOVW` 236 + `MOVT` 102), 102 pairs still stand as pairs (**96** carry an
  `.arkdata` linker patch, **6** are different-register or non-adjacent), and the other
  134 are 16-bit constants that only ever needed one `MOVW` and are out of this pass's
  scope.
- **armcc's branch share (22.9%) is higher than ours**: its control flow is merged less
  and every function ends in `BX lr`. We are 262 instructions *ahead* in that row.

**One classification gap, recorded rather than papered over**: the rows above add up to
**13,504**, which is **13 instructions (0.1%)** short of the **13,517** total. Those 13
are shapes the categorising script does not match; the gap has existed since the previous
version (whose rows summed to 14,218) and is not caused by `-fopt-litpool`. No invented
row fills it.

## 3 Decomposition of the gap: 73% is value transport

Adding up the five rows of section 2 that move a value from where it is produced to where
it is used:

| Category | arkc | armcc | difference |
| --- | ---: | ---: | ---: |
| `MOV` immediate | 2,003 | 412 | +1,591 |
| `MOVW`+`MOVT` | 338 | 0 | +338 |
| `MOV` register to register | 1,241 | 191 | +1,050 |
| `PUSH`/`POP` | 1,239 | 154 | +1,085 |
| frame access `[r6, #n]` | 856 | 45 | +811 |
| **subtotal** | **5,677 (42.0%)** | **802 (14.3%)** | **+4,875** |

**Those 4,875 instructions are 61.7% of the 7,898 total gap.** The other 38%:

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
| literal pool (ours is 310 higher) | +310 |
| extend / bitfield | -122 |
| shift | -12 |
| other | -195 |
| **subtotal** | **+3,023** |

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

Of the four items below, **the first is done and measured** (`-fopt-litpool`); the other
three are still **measured on the current binary**, not estimated. Each carries its price,
so that "do it or not" is a checkable decision rather than a feeling.

### 5.1 Constant pool: -701 instructions / -1,140 bytes (**done**, `-fopt-litpool`)

The previous version of this note estimated "-803 instructions / -2,712 B". It is now
**built and measured** at **-701 instructions / -1,140 B** (95 TUs: 14,218 / 36,072 ->
**13,517 / 34,932**). Same readings as [LITPOOL.en.md](LITPOOL.en.md); only the conclusion
and the reconciliation live here:

- With eighteen switches there are **803** adjacent same-register `MOVW`/`MOVT` pairs.
  **96** carry an `.arkdata` marker (the linker patches both halfwords, so the pair cannot
  become an `LDR`), **6** are not real pairs (different register or non-adjacent), so
  **701 convert**, matching the instruction difference exactly (`803 - 96 - 6 = 701`).
- The byte bill: 701 sites each save 4 (**-2,804**), 355 pools each cost 4 (**+1,420**),
  and the `.align 4` in front of each pool pads 244 on average (**+244**) => **-1,140**,
  matching the measurement exactly.
- The gap to the old estimate (-803 vs -701) comes from the untouchable `.arkdata` pairs
  and from the fact that **every region group builds its own pool** (one word per group
  for the same constant) -- which is exactly what keeps large functions inside the
  4,095-byte reach of `LDR [pc, #imm]`.

So "the only two-digit win" was the right call, but it is 13% smaller than estimated.
Design, refusal list, region cutting and the 21 gates are in
[LITPOOL.en.md](LITPOOL.en.md); **this item moves from "to do" to "done"**.

### 5.2 `PUSH {… r0 …}` 532 (3.9%)

Only 46 of them are followed by `POP {r0}`. Removing the other 486 means changing the
value-stack model (keeping the intermediate in a register) -- the same thing as 4.1,
bounded by the F1 falsifier (close the slice if under 5%).

### 5.3 Repeated constant materialisation 1,865 (13.8%)

`MOV r0, #imm` 999 + `MOV rX, #imm` 866. This **must not be double counted** with 5.1:
after pooling most of these sites still need one `LDR`; what can still go is only "the
same constant materialised several times in one basic block" (`-fopt-constcache` already
took 159, the rest is unmeasured).

### 5.4 Register copies 1,241 (9.2%)

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
| `-fopt-litpool` | 32-bit constants into a literal pool (region-shaped, one pool per group) | eighteen switches 14,218 -> **nineteen 13,517** (-701 / -1,140 B) |
| rest | `-fopt-vstack` / `-fopt-cmat` / `-fopt-slotreg` / `-fopt-constcache` / `-fopt-pair` etc. | see `docs/COMPARISON.en.md` section 5 |

All nineteen `-fopt-*` switches are **off by default**, and each one has an OFF IS OFF gate
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
  - constant-pool measurement: `D:/tmp/fr/cmpark_lp.py` (eighteen / nineteen switch arms,
    writing `cmpark_lp.json` and `cmpark_lp/*_all18.s|*_all19.s`);
  - three-arm totals: `cmpark_keep.json` / `cmpark_vreg17.json` / `cmp_arm.json`.
- **This table must not be read as** "arkc is unusable": it compiles itself, compiles the
  HAL, and has run on the STM32H743 and the F401 (`docs/BOARD_VALIDATION.en.md`); semantic
  correctness is verified instruction by instruction by `tests/arm_exec` on unicorn. Only
  one dimension is shown here: instruction count and code bytes.
