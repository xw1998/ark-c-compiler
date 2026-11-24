# Side-by-side with armcc / armclang (0.9.1)

English | [中文](COMPARISON.md)

> In one sentence: **on the full STM32F4 HAL corpus, arkc with every
> optimization on is 2.5× the instruction count and 2.6× the code bytes of
> armcc `-O2`; the gap is not encoding quality, it is structural -- a value-stack
> machine, liveness used only to delete copies, and intermediate results still
> going through the frame.**
>
> Measurement scripts: `D:/tmp/fr/cmp_arm.py` (the six armcc/armclang arms) and
> `D:/tmp/fr/cmpark_all.py` (the two arkc arms) -- neither is in the repository,
> but both use the same counting regex and `ARKOBJ2` header as `docs/CMAT.md`
> section 6. The whole table below comes from one run of each, on the same source
> files with the same macros and include paths.

---

## 1. Corpus and method

- **Sources**: `examples/ark_test/Core/Src/*.c` (5) + `Drivers/STM32F4xx_HAL_Driver/Src/*.c`
  (94), 99 translation units. Four `*_template.c` produce empty code in all three
  compilers, so they are **skipped symmetrically** => **95 effective units**.
- **Macros and headers**: `-D STM32F401xE -D USE_HAL_DRIVER`, `-I examples/ark_test`,
  HAL `Inc`, `Core/Inc`, CMSIS `Device`/`Core`, `-I include`.
- **CPU**: `-mcpu Cortex-M4` (`--target=arm-arm-none-eabi -mcpu=cortex-m4` for
  armclang).
- **Instruction count**: for arkc, the lines in the `.s` that are non-empty, not
  directives and not labels (regex `^\s+[A-Za-z][A-Za-z0-9.]*\s`); for
  armcc / armclang, `fromelf --text -c` on the executable sections, excluding
  `DCD/DCW/DCB/DCQ/ALIGN/SPACE/FIELD/EQU/DCI`.
- **Code bytes**: arkc takes the code-section length from its own object header
  (`ARKOBJ2`); armcc / armclang sum the `Size` of the `SHF_EXECINSTR` sections
  reported by `fromelf`.
- **Toolchains**: ARM Compiler 5.06 update 7 (`D:/Keil_v5/ARM/ARMCC/bin`), ARM
  Compiler 6 (`D:/Keil_v5/ARM/ARMCLANG/bin`).

This method only compares "the code produced by compiling this batch of `.c`": no
link-time optimization (LTO), no library functions. **An arkc translation unit may
carry its own run-time helpers** (`__aeabi_memcpy`, `__arkcc_init_globals`,
`__REV16` and friends), whereas armcc/armclang take the same routines from the C
library. Two always-on, switchless mechanisms have already pushed that item down:
(1) unreferenced `static` functions are no longer emitted
([DEADSTATIC.en.md](DEADSTATIC.en.md)); (2) `__aeabi_memcpy` is emitted on demand.
The table does **not** deduct it, because that Flash really is occupied.

## 2. Results

Totals over the 95 effective units:

| compiler | options | instructions | code bytes |
| --- | --- | ---: | ---: |
| **arkc** | `-O2` (no `-fopt-*`) | 49,186 | 110,468 |
| **arkc** | `-O2` + all eighteen `-fopt-*` (see section 3) | **14,121** | **36,106** |
| armcc | `-O1` | 6,051 | 14,888 |
| armcc | `-O2` | 5,619 | 13,920 |
| armcc | `-O3 -Otime` | 5,740 | 15,300 |
| armcc | `-O3 -Ospace` | 5,632 | 14,080 |
| armclang | `-O2` | 5,064 | 13,848 |
| armclang | `-Oz` | 4,246 | 11,284 |

Against armcc `-O2` (5,619 instructions / 13,920 B):

| comparison | instructions | code bytes |
| --- | ---: | ---: |
| arkc `-O2` (no `-fopt-*`) | 8.8× | 7.9× |
| arkc `-O2` + every `-fopt-*` | **2.51×** | **2.59×** |

**The switches take the gap from 8.8× down to 2.5×** (instructions -71.3%, code
bytes -67.3%).

**IAR did not take part**: IAR EWARM 9.70 is installed on this machine
(`D:\tools\IAR_EWARM_9.70\arm\bin\iccarm.exe`, V9.70.1.475/W64) but **has no
license** -- every compile stops at `Fatal error[LMS001]: License check failed` and
not one byte comes out. **So no IAR figure is estimated**: without compiled bytes
there is nothing to compare. The way to line up with IAR is to implement the
mechanisms reverse-engineered into `D:/工作/git_project/c_compiler/iar/docs/`
(`-fopt-cbranch`, `-fopt-copyprop` and M6/M7 of `-fopt-cmat` came from there), not
to invent a number.

## 3. Which eighteen switches "all `-fopt-*`" means

```
-fopt-vstack  -fopt-addr     -fopt-strength -fopt-cbz      -fopt-branch
-fopt-imm     -fopt-peep     -fopt-cbranch  -fopt-copyprop -fopt-live
-fopt-prop    -fopt-deadpush -fopt-coalesce -fopt-slotreg  -fopt-constcache
-fopt-vreg    -fopt-cmat     -fopt-pair
```

All of them are **off by default**; each has its own cropping macro in its own
document (`-fopt-cmat` is `ARKCC_FEATURE_OPT_CMAT`, `-fopt-slotreg` is
`ARKCC_FEATURE_OPT_SLOTREG`, `-fopt-constcache` is `ARKCC_FEATURE_OPT_CONSTCACHE`).

Four of them are new relative to the previous version of this table: `-fopt-cmat`
(nine rules, -1,802 instructions / -4,062 B, see [CMAT.en.md](CMAT.en.md)),
`-fopt-slotreg` (-64 instructions, archived by its pre-registered falsifier, see
[SLOTREG.en.md](SLOTREG.en.md)), `-fopt-constcache` (-159 instructions, see
[OPERAND_ALLOC.en.md](OPERAND_ALLOC.en.md) section 8) and `-fopt-pair`
(-10 instructions). `-fopt-vreg` / `-fopt-coalesce` / `-fopt-prop` /
`-fopt-deadpush` are described in [VREG.en.md](VREG.en.md) and their own documents.

## 4. Where the gap comes from: four structural reasons

Take `HAL_RCC_OscConfig()` (`stm32f4xx_hal_rcc.c`): 2,166 instructions with arkc
fully optimized (2,177 before `-fopt-live`), 336 with armcc `-O2`. Look at the opening
`if (RCC_OscInitStruct == 0)`:

```asm
; arkc, fully optimized (with -fopt-cbranch -fopt-cbz)
    CBNZ r0, .L_HAL_RCC_OscConfig_0
```

```asm
; the armcc -O2 equivalent
    CMP  r0, #0
    BEQ  .L
```

**One instruction against two** -- the materialisation block is gone thanks to
`-fopt-cbranch`, and `-fopt-cbz` then folds `CMP r0, #0` + `BNE` into `CBNZ`.
What remains is not that item any more; it is the shape of the code generator:

1. **Value-stack machine: every value really enters the stack.** `-fopt-vstack`
   folds adjacent `PUSH/POP` into register moves, but "the intermediate result of
   an expression" still often lands back in the frame (`STR r0, [r6, #8]` /
   `LDR r0, [r6, #8]`). The register-to-register layer of copies that are written
   and never used has already been removed by `-fopt-copyprop` (see
   `docs/COPYPROP.md`); what is left is the memory round trip. The real fix is
   **local-variable register allocation** (needs liveness analysis), not a text pass.
2. ~~Booleans are materialised to 0/1 and then re-tested~~ -- **fixed by
   `-fopt-cbranch`** (0.9.1). On the HAL corpus `ITE` went from 824 to 69 and
   `CMP r0,#0` from 409 to 73, worth 2,601 instructions / 8,238 bytes (see
   `docs/CBRANCH.md`). The 69 survivors are the "comparison stored in a variable"
   case where the value has two consumers, which needs liveness analysis to push
   further.
3. **No liveness, no scheduling.** Every access to a slot is an independent memory
   access; there is no notion of "this value is still in `r3`", and no reordering
   of independent instructions into pipeline slots.
4. **Each translation unit carries its own run-time helpers.** 920 instructions
   / 4.8% (§1). armcc uses the library.

Two further ceilings that were **quantified and judged not worth doing**:

- **Frame-less leaf functions**: only 26 functions in the whole corpus can really
  drop the entire frame (about 78 instructions, 0.2%).
- **Short conditional branches (`B<cond>` T1)**: this backend always emits the
  32-bit T3 form; switching to T1 needs a layout fixed-point iteration (±256
  bytes), and the gain is out of proportion to the risk; `-fopt-cbz` already eats
  part of it along the way.

## 5. Per-optimization measurements (same corpus)

> **This section is the historical ladder**: it is the reading taken when the ten
> switches landed, accumulated one at a time, and it exists to explain what each
> rule is worth. **The current total is section 2** (14,121 instructions /
> 36,106 B); the ladder no longer adds up to it, because dead-static suppression
> and the on-demand run-time helper landed in between and four more tables were
> added.

**Cumulative** (each row adds one switch on top of the row above), 95 valid TUs,
`-O2 --reloc-data -mcpu Cortex-M4`:

| Build (cumulative) | Instructions | Code bytes |
| --- | ---: | ---: |
| `-O2` (no `-fopt-*`) | 50,965 | 114,576 |
| + `-fopt-vstack` | 36,101 | 84,848 |
| + `-fopt-addr` | 33,957 | 80,542 |
| + `-fopt-strength` | 31,865 | 78,262 |
| + `-fopt-cbz` | 31,421 | 76,486 |
| + `-fopt-branch` | 31,421 | 73,906 |
| + `-fopt-imm` | 25,663 | 62,890 |
| + `-fopt-peep` | 25,033 | 61,628 |
| + `-fopt-cbranch` | 22,438 | 53,404 |
| + `-fopt-copyprop` | 21,915 | 52,358 |
| + `-fopt-live` | **19,112** | **45,760** |

The ten switches together: **−31,853 instructions (−62.5%)**,
**−68,816 code bytes (−60.1%)**. Note that `-fopt-branch` only changes encoding
width, not the number of instructions, so its row is flat in the instruction
column and −2,580 in the byte column.

Per step: `-fopt-vstack` −14,864, `-fopt-imm` −5,758, `-fopt-cbranch` −2,595,
`-fopt-live` −2,803, `-fopt-peep` −630, `-fopt-addr` −2,144,
`-fopt-strength` −2,092, `-fopt-cbz` −444, `-fopt-copyprop` −523. Designs and
criteria are in `docs/RA_VSTACK.md`, `docs/IMM_FOLD.md`, `docs/CBRANCH.md`,
`docs/LIVE.md`, `docs/PEEPHOLE.md`, `docs/ADDR_FOLD.md`, `docs/STRENGTH.md`,
`docs/CBZ_FOLD.md`, `docs/COPYPROP.md`. Constant materialisation itself (on with
no switch at all, see `docs/MOVIMM.md`) moved the `-O2` row from
51,416 instructions / 116,380 bytes down to 50,965 / 114,576 (-451 instructions /
-0.88%, -1,804 bytes / -1.55%).

**A note on the measurement basis**: the table inside each `-fopt-*` document is
the reading taken the day that pass landed (when constant materialisation still
emitted `MOVW` + `MOVT` + `MOVT #0`, and before vstack had per-block resume and a
256-deep shadow stack), so its absolute numbers differ from this table. **This table is the
authoritative reading for the current binary.**

## 6. How to reproduce

```bash
# 1) the six armcc/armclang arms in one run (detail -> D:/tmp/fr/cmp_arm.json)
python D:/tmp/fr/cmp_arm.py

# 2) the two arkc arms: -O2 with no flag / all eighteen -fopt-*
python D:/tmp/fr/cmpark_all.py
```

Both scripts assume: `D:/工作/git_project/ark c compiler` is the repository root,
`arkcc.exe` is a fresh `make` output, and Keil is installed at `D:/Keil_v5`. The
corpus paths are hard-coded in the scripts; change the `srcs` line to use another
corpus.

## 7. What this table must not be read as

- **Not "arkc is unusable"**: it compiles itself, compiles HAL, and has run on
  STM32H743 and F401 (see `docs/BOARD_VALIDATION.md`); semantic correctness is
  verified instruction by instruction by `tests/arm_exec` under unicorn. The table
  is **size / instruction count** only, one dimension.
- **Not "armcc's advantage is out of reach"**: reason 2 in §4 (feeding a
  comparison result straight into a branch) is done and removed 2,601 instructions;
  it was pure code generation with no liveness involved. What is left is reason 1
  (intermediate results spilling to the frame), which does need liveness and is
  real engineering work.
- **Not "IAR is worse or better"**: it is installed but unlicensed, so it cannot
  be measured; there are no numbers, so there is nothing to say here. Its
  reverse-engineered mechanisms are what the newer passes follow.
