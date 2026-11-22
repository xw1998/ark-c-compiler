# Side-by-side with armcc / armclang (0.9.1)

English | [中文](COMPARISON.md)

> In one sentence: **on the full STM32F4 HAL corpus, arkc with every
> optimization on is 4.7× the instruction count and 4.6× the code bytes of
> armcc `-O2`; the gap is not encoding quality, it is structural -- a value-stack
> machine, no liveness analysis, and booleans materialised and then re-tested.**
>
> Measurement script: `D:/tmp/cmp_final.py` (not in the repository). The whole
> table below comes from one run of it, on the same source files with the same
> macros and include paths.

---

## 1. Corpus and method

- **Sources**: `examples/ark_test/Core/Src/*.c` + `Drivers/STM32F4xx_HAL_Driver/Src/*.c`,
  99 translation units. Three `*_template.c` produce empty code in all three
  compilers, so they are **skipped symmetrically** => 96 effective.
- **Macros and headers**: `-D STM32F401xE -D USE_HAL_DRIVER`, `-I examples/ark_test`,
  HAL `Inc`, `Core/Inc`, CMSIS `Device`/`Core`, `-I include`.
- **CPU**: `-mcpu Cortex-M4` (`--target=arm-arm-none-eabi -mcpu=cortex-m4` for
  armclang).
- **Instruction count**: for arkc, the lines in the `.s` that are non-empty, not
  directives and not labels; for armcc / armclang, `fromelf --text -c` on the
  executable sections, excluding `DCD/DCW/DCB/DCQ/ALIGN/SPACE/FIELD/EQU/DCI`.
- **Code bytes**: arkc takes the code byte count from its own object header;
  armcc / armclang sum the `Size` of the `SHF_EXECINSTR` sections reported by
  `fromelf`.
- **Toolchains**: ARM Compiler 5.06 update 7 (armcc/armasm/fromelf), ARM Compiler 6
  (armclang).

This method only compares "the code produced by compiling this batch of `.c`": no
link-time optimization (LTO), no library functions. **Each arkc translation unit
carries its own run-time helpers** (`__aeabi_memcpy`, `__arkcc_init_globals`,
floating-point glue, ...), whereas armcc/armclang take the same routines from the C
library -- on the arkc side that item is **1,325 instructions / 5.0%**, and without
it arkc's user code is **24,991 instructions**. The table does not deduct it,
because that is Flash really occupied.

## 2. Results

Totals over the 96 effective translation units:

| Compiler | Options | Instructions | Code bytes |
| --- | --- | ---: | ---: |
| **arkc** | `-O2` | 51,463 | 116,480 |
| **arkc** | `-O2` + all `-fopt-*` (see §3) | **26,316** | **64,682** |
| armcc | `-O0` | 7,969 | 18,788 |
| armcc | `-O1` | 6,061 | 14,910 |
| armcc | `-O2` | 5,629 | 13,942 |
| armcc | `-O3 -Otime` | 5,750 | 15,322 |
| armcc | `-O3 -Ospace` | 5,642 | 14,102 |
| armclang | `-O2` | 5,068 | 13,856 |
| armclang | `-Oz` | 4,250 | 11,292 |

Relative to armcc `-O2`:

| Comparison | Instructions | Code bytes |
| --- | ---: | ---: |
| arkc `-O2` (no `-fopt-*`) | 9.1× | 8.4× |
| arkc `-O2` + all `-fopt-*` | **4.7×** | **4.6×** |

**The eight optimization switches of 0.9.1 take the gap from 9.1× down to 4.7×**
(−48.9% instructions, −44.5% code bytes).

**IAR does not take part**: there is no `iccarm.exe` on this machine (neither
under `/c/Program Files*/IAR Systems` nor `/d/IAR*`). **No IAR numbers are
estimated** -- without compiled bytes there is nothing to compare.

## 3. Which eight switches "all `-fopt-*`" means

```
-fopt-tailmerge -fopt-tailcall -fopt-divconst -fopt-xblock -fopt-sizeweight
-fopt-inline   -fopt-vstack    -fopt-addr     -fopt-strength -fopt-cbz
-fopt-branch   -fopt-imm       -fopt-peep     -fopt-regalloc
```

The table actually uses the ones **that do something on this corpus**:
`-fopt-vstack -fopt-addr -fopt-strength -fopt-cbz -fopt-branch -fopt-imm -fopt-peep`.

`-fopt-regalloc` was also measured this round, but it **changes not a single
instruction on this corpus** (identical instruction count and code bytes in both
configurations). The reason is in its selection rule: the default mode only takes
slots whose access width exceeds the 16-bit addressing form (offset > 124 or not a
multiple of 4), because this pass does not rely on liveness and has to earn back
the 4 extra bytes of the widened `PUSH/POP` by turning a wide access into a `MOV`.
HAL locals almost all fall in `0..124` and are 4-byte aligned, so `saves = 0` and
no slot is selected. **That is not a defect but its current design boundary**
(`-fopt-regalloc-near` is the other mode, which takes near slots by access count
and does change these functions).

## 4. Where the gap comes from: four structural reasons

Take `HAL_RCC_OscConfig()` (`stm32f4xx_hal_rcc.c`): 4,853 instructions with arkc
fully optimized, 336 with armcc `-O2`. Look at the opening
`if (RCC_OscInitStruct == 0)`:

```asm
; arkc, fully optimized
    CMP  r0, #0
    ITE  EQ
    MOVEQ  r0, #1
    MOVNE  r0, #0
    CBZ  r0, .L_HAL_RCC_OscConfig_0
```

```asm
; the armcc -O2 equivalent
    CMP  r0, #0
    BEQ  .L
```

**Six instructions against two.** That is not a gap register allocation can close;
it is the shape of the code generator:

1. **Value-stack machine: every value really enters the stack.** `-fopt-vstack`
   folds adjacent `PUSH/POP` into register moves, but "the intermediate result of
   an expression" still often lands back in the frame (`STR r0, [r6, #8]` /
   `LDR r0, [r6, #8]`). The real fix is **local-variable register allocation**
   (needs liveness analysis), not a text pass.
2. **Booleans are materialised to 0/1 and then re-tested.** `x == y` first does
   `CMP` + `ITE/MOVcc` to produce 0 or 1, and then `if` does `CMP r0, #0` + branch.
   One comparison paid for twice -- **the single largest item today**;
   `if (a == b)`, `if (p)` and `while (n)` all hit it.
3. **No liveness, no scheduling.** Every access to a slot is an independent memory
   access; there is no notion of "this value is still in `r3`", and no reordering
   of independent instructions into pipeline slots.
4. **Each translation unit carries its own run-time helpers.** 1,325 instructions
   / 5.0% (§1). armcc uses the library.

Two further ceilings that were **quantified and judged not worth doing**:

- **Frame-less leaf functions**: only 26 functions in the whole corpus can really
  drop the entire frame (about 78 instructions, 0.2%).
- **Short conditional branches (`B<cond>` T1)**: this backend always emits the
  32-bit T3 form; switching to T1 needs a layout fixed-point iteration (±256
  bytes), and the gain is out of proportion to the risk; `-fopt-cbz` already eats
  part of it along the way.

## 5. Per-optimization measurements (same corpus)

Baseline = `-fopt-vstack -fopt-addr -fopt-strength -fopt-cbz -fopt-branch`,
35,211 instructions:

| Build | Instructions | Change |
| --- | ---: | ---: |
| baseline | 35,211 | — |
| + `-fopt-peep` | 33,730 | −1,481 (−4.2%) |
| + `-fopt-imm` | 27,716 | −7,495 (−21.3%) |
| + both | **26,316** | **−8,895 (−25.3%)** |

`-fopt-imm` alone accounts for more than sixty percent of the whole 0.9.1 gain
(see `docs/IMM_FOLD.md`), `-fopt-peep` is the second block (see
`docs/PEEPHOLE.md`). Figures for the five earlier passes are in
`docs/OPTIMIZER_PLAN.md` and the individual `docs/*_FOLD.md` / `docs/STRENGTH.md`.

## 6. How to reproduce

```bash
# 1) three arkc arms + five armcc arms + two armclang arms, all in one run
python D:/tmp/cmp_final.py          # prints the summary, detail goes to D:/tmp/cmp_final.json

# 2) just arkc's four steps (base / peep / imm / imm+peep)
python D:/tmp/peep_total.py
```

Both scripts assume: current directory is the repository root, `./arkcc.exe` is a
fresh `make` output, and Keil is installed at `D:/Keil_v5`. The corpus paths are
hard-coded in the scripts; change the `srcs` line to use another corpus.

## 7. What this table must not be read as

- **Not "arkc is unusable"**: it compiles itself, compiles HAL, and has run on
  STM32H743 and F401 (see `docs/BOARD_VALIDATION.md`); semantic correctness is
  verified instruction by instruction by `tests/arm_exec` under unicorn. The table
  is **size / instruction count** only, one dimension.
- **Not "armcc's advantage is out of reach"**: reason 2 in §4 (feeding a
  comparison result straight into a branch) is a pure code-generation change and
  should remove several thousand instructions from the HAL corpus whether or not
  liveness analysis exists; reason 1 does need liveness and is real engineering
  work.
- **Not "IAR is worse or better"**: it was not measured, there are no numbers,
  so there is nothing to say here.
