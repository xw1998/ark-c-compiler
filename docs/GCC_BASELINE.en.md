# The yardstick changes: a gcc baseline (measured 2026-11-25)

English | [中文](GCC_BASELINE.md)

> One thing: **"beat armcc" has expired as a goal -- gcc 13.2.1 emits 20% fewer instructions
> than armcc 5.06u7 on this same 95-TU corpus. The first opponent after 0.9.1 is gcc.**
>
> This document does three things only: nails the gcc baseline down (section 1), spreads the
> gap over TUs and functions (section 2), and explains the root cause of the one function that
> carries 23.5% of the corpus (section 3). No implementation plan here.

---

## 1 Three-way baseline

**The measurement must be identical**: the same 95 TUs (`Core/Src` plus
`Drivers/STM32F4xx_HAL_Driver/Src` of `examples/ark_test`), the same `-I` list, only the
compiler changes.

| Arm | Version / flags | Instructions | asm text bytes |
| --- | --- | ---: | ---: |
| arkc (this repo, HEAD) | 26 flags (`sw24` + `-fopt-exit` + `-fopt-bitmask`) + `-O2` | **11,666** | **396,986** |
| armcc | 5.06u7, `-O2` | 5,619 | 13,920 (this is **image size**, not comparable) |
| **gcc** | **arm-none-eabi-gcc 13.2.1, `-mcpu=cortex-m4 -mthumb -O2 -S`** | **4,469** | **174,119** |
| gcc (size) | same, `-Os` | 4,303 | 169,681 |

Three sentences:

1. **arkc / gcc `-O2` = 2.61x**; arkc / armcc `-O2` = 2.08x.
2. **gcc is 20% better than armcc (4,469 vs 5,619)**, so using armcc as the yardstick
   understates our gap; the "reach 5,619" line in `docs/BOUNDARY.md` section 7 should read
   4,469.
3. The byte column is only comparable within a kind: arkc and gcc are `.s` text bytes
   (directives, labels, line markers included), armcc's 13,920 is ELF image size. Never put
   the two into one ratio.

Reproduce (read-only, not committed):

```bash
python -X utf8 D:/tmp/bm/gccbase.py       # -> D:/tmp/bm/gccbase/{O2,Os}/*.s, res.json
python -X utf8 D:/tmp/bm/gate_exit.py     # -> D:/tmp/bm/gate_exit/s9b_off/*.s
```

gcc command shape:

```bash
arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -O2 -S -o <tu>.s <tu>.c \
  -DSTM32F401xE -DUSE_HAL_DRIVER -I ...   # the same -I list as arkc
```

## 2 Spreading the gap

### 2.1 Per TU (only 18 TUs contain real code; the other 77 are empty shells)

| TU | arkc | gcc `-O2` | ratio |
| --- | ---: | ---: | ---: |
| `stm32f4xx_hal_dma_ex.c` | 2,745 | 341 | **8.05x** |
| `stm32f4xx_hal_rcc.c` | 1,828 | 701 | 2.61x |
| `stm32f4xx_hal_dma.c` | 1,501 | 703 | 2.14x |
| `stm32f4xx_hal_rcc_ex.c` | 733 | 340 | 2.16x |
| `stm32f4xx_hal_flash_ex.c` | 721 | 318 | 2.27x |
| `stm32f4xx_hal_flash.c` | 692 | 399 | 1.73x |
| `stm32f4xx_hal_gpio.c` | 617 | 295 | 2.09x |
| `stm32f4xx_hal_cortex.c` | 596 | 251 | 2.37x |
| `stm32f4xx_ll_utils.c` | 577 | 246 | 2.35x |
| `stm32f4xx_hal_exti.c` | 451 | 211 | 2.14x |
| `stm32f4xx_hal.c` | 312 | 176 | 1.77x |
| `stm32f4xx_hal_pwr_ex.c` | 269 | 138 | 1.95x |
| `stm32f4xx_hal_pwr.c` | 258 | 172 | 1.50x |
| `main.c` | 133 | 72 | 1.85x |
| `system_stm32f4xx.c` | 128 | 38 | 3.37x |
| `gpio.c` | 56 | 38 | 1.47x |
| (two more non-empty TUs) | 49 | 20 | 2.45x |
| **total** | **11,666** | **4,469** | **2.61x** |

### 2.2 One file eats a quarter of the corpus

`stm32f4xx_hal_dma_ex.c` alone is **2,745 instructions = 23.5% of the corpus**, while its gcc
build is 341. Inside it, the whole story is a single function:

| function | arkc | gcc `-O2` | ratio |
| --- | ---: | ---: | ---: |
| **`HAL_DMAEx_MultiBufferStart_IT`** | **2,632** | **292** | **9.0x** |
| `HAL_DMAEx_MultiBufferStart` | 66 | 41 | 1.61x |
| `DMA_MultiBufferSetConfig` | 29 | 0 (inlined into the caller) | -- |
| `HAL_DMAEx_ChangeMemory` | 18 | 8 | 2.25x |

**Those 2,632 instructions are 2,340 over gcc, which is 32.5% of the whole 7,197-instruction
gap.**

## 3 Root cause: `__HAL_DMA_CLEAR_FLAG`'s nested ternary, re-evaluated every time

Numbers first (`D:/tmp/bm/gate_exit/s9b_off/stm32f4xx_hal_dma_ex.c.s`, grouped by `.loc`):

| `.loc` line | instructions | what it is |
| --- | ---: | --- |
| 27,897 | 419 | `__HAL_DMA_CLEAR_FLAG(hdma, ...)` |
| 27,898 | 419 | same |
| 27,899 | 494 | same |
| 27,900 | 537 | same |
| 27,901 | 540 | same |
| the other 24 `.loc`s | 223 | the function's real logic |
| **total** | **2,632** | |

Five statements = **2,409 instructions = 91.5% of the function**, and they are not five
different pieces of code but **one macro, expanded five times**:

```c
/* stm32f4xx_hal_dma_ex.c, preprocessed lines 27,897-27,901; one statement per line */
__HAL_DMA_CLEAR_FLAG(hdma, __HAL_DMA_GET_TC_FLAG_INDEX(hdma));
```

The macro body (`stm32f4xx_hal_dma.h`) writes "which register plus which mask bit" as **one**
giant conditional: the outer level picks `HIFCR/LIFCR` by which DMA controller
`hdma->Instance` belongs to (4 arms), and each arm carries a **13-way**
`hdma->Instance == &DMAx_StreamY ? mask : ...` chain. So **one statement = 4 x 13 = 52 pointer
comparisons**, each of them three instructions:

```asm
    LDR r0, [r6, #0]        ; reload the hdma parameter from its frame slot
    LDR r5, [r0, #0]        ; re-read hdma->Instance
    LDR r7, .Llit_2_2_5     ; re-materialise the stream address from the literal pool
    CMP r5, r7
    MOV r0, r5              ; <- dead copy
    MOV r1, r7              ; <- dead copy
    BNE .L_..._325
```

gcc's version of the same stretch (`D:/tmp/bm/gccbase/O2/stm32f4xx_hal_dma_ex.c.s`) loads
`hdma->Instance` into r4 **once**, walks the 13-way chain with `adds r3, r3, #24` (0x18 stride)
and compares with `cmp r4, r3` / `beq`. The whole function is 292 instructions.

Instruction census of that function:

| | arkc | gcc |
| --- | ---: | ---: |
| LD/ST (`LDR/STR/LDRB/...`) | 840 | 111 |
| MOV | 587 | 89 |
| branches (`B`/`Bcc`) | 529 | 33 |
| PUSH | 324 | 3 |
| CMP | 266 | 21 |
| POP | 70 | 3 |
| total | 2,632 | 304 (8 of them `.word`) |

Four attack points, largest ceiling first:

1. **No CSE of repeated loads**: `hdma` is a frame-slot parameter and `hdma->Instance` a plain
   pointer member; both are re-read 52 times inside one statement with **no store in between**
   (the only write is the final assignment of that conditional expression). A
   same-statement, no-call-no-store CSE is semantically safe.
2. **The same constant address is materialised four times per statement**: the 13 stream
   addresses are loaded again in each of the 4 outer arms. `-fopt-constcache` covers
   immediates and a few literals, not this cross-block repetition.
3. **Two dead copies before every compare** (`MOV r0, r5` / `MOV r1, r7`): operand staging
   inherited from the value-stack three-address shape, while both sides of the branch write
   `r0` first and `r1` is never read.
4. **No strength reduction along the address chain**: the 13 neighbouring streams differ by
   0x18 bytes; gcc steps with `adds`, we reload each from scratch.

## 4 Acceptance of the first slice (written down before implementation)

The object is exactly that one function, because it alone is 23.5% of the corpus and 32.5% of
the gap to gcc, and **a single function's count tells us whether the direction is right**
without waiting for the whole corpus.

- **primary**: `HAL_DMAEx_MultiBufferStart_IT` from 2,632 down to **<= 1,400 instructions**
  (-47% or better);
- **secondary**: 26-flag corpus **>= 5%** (11,666 -> <= 11,083) **with bytes not increasing**;
- **correctness**: 95 TUs compile, `tests/arm_exec` four arms 0 failure,
  `run_peep_tests.py` / `run_addr_tests.py` / `run_vreg_tests.py` / `run_cmat_tests.py` /
  `run_litpool_tests.py` / `run_bitmask_tests.py` all green;
- **OFF IS OFF**: with the new switch off, the 95 TU output is **byte-identical** to today;
- **gating**: the new switch is 0 under `ARKCC_PROFILE=STM32_MIN`, rejected by name (`C*`),
  default-profile size unchanged;
- below 5%: register it or withdraw it per repo discipline, do not leave it in the tree as
  "sort of useful".

## 5 Relation to existing documents

| Document | Relation |
| --- | --- |
| `docs/BOUNDARY.md` sections 1/7 | the three-way comparison and "reaching 5,619 needs a new model"; this document swaps the opponent from armcc to gcc (4,469) |
| `docs/RA_MODEL.md` sections 1/10 | the per-class difference table and the final account at 26 flags, same measurement (11,666 / 396,986) |
| `docs/EXPR_MODEL.md` section 9 | S9b's negative result: statement-local three-address emission is worth 0.137% on HAL; section 3 here explains why -- the waste is in **repeated loads and operand staging**, not in arithmetic |
| `docs/ADDR_FOLD.md` section 13 | address folding's third round (R1b/R0) paid 100 instructions; point 4 in section 3 says the remaining address waste is "the same constant address materialised repeatedly" |
