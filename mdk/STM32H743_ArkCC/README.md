# Ark C Compiler - STM32H743 MDK Project

This directory provides a Keil MDK-ARM 5.x project template that runs the
**Ark C Compiler** as a **self-hosted compiler** on the **STM32H743VIT6**.

> Project path: `mdk/STM32H743_ArkCC/ArkCC.uvprojx`
> Target compiler: ARM Compiler 6 (armclang)
> Target chip: STM32H743VITx (Cortex-M7, 2 MB Flash, 1 MB RAM)

## 1. Directory Structure

```
mdk/STM32H743_ArkCC/
|-- ArkCC.uvprojx                       Keil project file
|-- ArkCC.uvoptx                        Keil options file
|-- RTE/_ArkCC/RTE_Components.h         RTE placeholder header
|-- Drivers/
|   |-- CMSIS/
|   |   |-- Device/ST/STM32H7xx/Include/   minimized stm32h7xx.h / stm32h743xx.h
|   |   \-- Include/                        minimized core_cm7.h / cmsis_compiler.h
|   \-- STM32H7xx_HAL_Driver/README.txt    HAL empty-folder note
|-- User/
|   |-- main.c                          application entry
|   |-- stm32h7xx_it.c                  interrupt vectors
|   |-- stm32h7xx_hal_msp.c             HAL MSP hooks
|   |-- system_stm32h7xx.c              SystemInit / HAL placeholders
|   |-- bsp_w25q.c                      W25Q128 SPI Flash driver
|   \-- Inc/bsp_w25q.h
|-- Startup/startup_stm32h743xx.s       startup file (armclang asm)
\-- Linker/STM32H743VITx_FLASH.sct      scatter file
```

The compiler core source code is **not copied**; instead it is referenced
directly via relative paths:

| Keil group       | Referenced path                                          |
|------------------|----------------------------------------------------------|
| ArkCC/Core       | `..\..\src\*.c`                                          |
| ArkCC/Backend    | `..\..\src\backend\registry.c` and `..\..\src\backend\arm\backend_arm.c` |
| ArkCC/Port       | `..\..\port\stm32\platform_stm32.c` and `..\..\port\stm32\flash_fs_stm32.c` |

After modifying the source code in the repository root, rebuild in Keil to sync.

## 2. Compiler/Linker Configuration Highlights

| Item               | Value                                                    |
|--------------------|----------------------------------------------------------|
| Compiler           | ARM Compiler 6 (`uAC6=1`)                                |
| Language standard  | C99 (`uC99=1`)                                           |
| Optimization       | `-O2` (`Optim=3`) + `-fno-common -ffunction-sections -fdata-sections` |
| FPU                | double precision (`RvdsVP=2`)                            |
| Preprocessor macros| `USE_HAL_DRIVER, STM32H743xx, ARK_TARGET_STM32H7`         |
| Include paths      | `..\..\include; ..\..\stdlib\include; .\User\Inc; .\Drivers\CMSIS\Device\ST\STM32H7xx\Include; .\Drivers\CMSIS\Include; .\Drivers\STM32H7xx_HAL_Driver\Inc; .\RTE\_ArkCC` |
| Linker scatter     | `.\Linker\STM32H743VITx_FLASH.sct`                       |
| Debugger           | ST-Link (`BIN\STLink.dll`)                              |

The scatter file places the ArkCC heap/code buffers separately in AXI SRAM:

- DTCM `0x20000000 + 128KB` -> ordinary RW/ZI/stack
- AXI  `0x24000000 + 512KB` -> `.ark_heap`, `.ark_code` dedicated sections
- Flash `0x08000000 + 2MB`  -> program code

In `User/main.c`:

```c
__attribute__((section(".ark_heap"))) unsigned char ark_heap_buffer[64 * 1024];
__attribute__((section(".ark_code"))) unsigned char ark_code_buffer[32 * 1024];
```

## 3. User Workflow (5 Steps)

1. **Complete the official CMSIS / HAL**
   - From [STM32CubeH7](https://github.com/STMicroelectronics/STM32CubeH7)
     copy `Drivers/CMSIS/Device/ST/STM32H7xx/Include/*` over
     `Drivers/CMSIS/Device/ST/STM32H7xx/Include/`;
   - Copy `Drivers/CMSIS/Include/core_cm7.h` etc. over
     `Drivers/CMSIS/Include/`;
   - Copy `Drivers/STM32H7xx_HAL_Driver/Inc + Src` over
     `Drivers/STM32H7xx_HAL_Driver/`, and in Keil's `Drivers/HAL` group
     add the required `stm32h7xx_hal*.c` (at least: `stm32h7xx_hal.c`,
     `_hal_cortex.c`, `_hal_gpio.c`, `_hal_rcc.c`, `_hal_pwr_ex.c`,
     `_hal_uart.c`, `_hal_spi.c`).
2. **Replace the placeholder code**
   - Regenerate `HAL_Init / SystemClock_Config / MX_GPIO_Init /
     MX_USART1_UART_Init / MX_SPI1_Init` in `User/system_stm32h7xx.c`,
     `User/stm32h7xx_hal_msp.c`, and `User/main.c` with STM32CubeMX, or
     implement them manually per these requirements:
       - HSE 25 MHz -> PLL1 -> SYSCLK **480 MHz**
       - USART1 = 115200 8N1, PA9 (TX) / PA10 (RX)
       - SPI1 master mode, PA5/PA6/PA7 + PA4 (CS)
3. **Prepare the W25Q128 data**
   - Using a USB programmer, first write the `FileEntry[MAX_FILES]` index
     table to SPI Flash at `0x000000` (each entry is 32 bytes:
     `name[24] + offset(u32) + size(u32)`);
   - Then append each `.c` source file (e.g. `/app/main.c`, `/app/blink.c`).
   - See `port/stm32/flash_fs_stm32.c` for the file table format.
4. **Open the project and build**
   - Open `mdk/STM32H743_ArkCC/ArkCC.uvprojx` with Keil MDK 5.36+;
   - Select ARM Compiler 6.16+;
   - `Project -> Build Target`; the output is in `Objects/ArkCC.axf / .hex`.
5. **Flash and use the interactive shell**
   - Flash with ST-Link;
   - Connect the serial port 115200 (PA9/PA10) to a PC terminal (e.g. PuTTY, TeraTerm);
   - After boot an interactive shell prompt appears:

     ```
     === Ark C Compiler on STM32H743 ===
     Heap @ 24000000, Code @ 24010000
     Type 'help' for commands.

     arkcc> help
     === ArkCC Shell Commands ===
       help              - show this help
       ls                - list files on flash FS
       cat <file>        - print file content
       compile <file>    - compile .c source to ARM binary
       run <file>        - compile and execute .c source
       echo <text>      - echo text back
       version           - show compiler version
     =============================
     arkcc> ls
     Files on flash FS:
       /app/main.c               1024 bytes
       /app/blink.c               512 bytes
     arkcc> compile /app/blink.c
     [arkcc] compiling /app/blink.c...
     [arkcc] cpu=Cortex-M7 arch_m=7 dsp=1 fpu=1
     [arkcc] target=arm, source=512 bytes
     Exit code: 0
     arkcc>
     ```

### Shell Command Reference

| Command           | Description                                              |
|-------------------|----------------------------------------------------------|
| `help`            | Show available commands                                  |
| `ls`              | List all files on the W25Q flash filesystem              |
| `cat <file>`      | Print the content of a file                             |
| `compile <file>`  | Compile a `.c` source file to ARM Thumb-2 binary        |
| `run <file>`      | Compile and (skeleton) execute a `.c` source file       |
| `echo <text>`     | Echo text back (loopback test for UART)                 |
| `version`         | Show compiler version and target info                   |

### Example: Compiling a Blink Program on STM32

1. Pre-load `/app/blink.c` onto W25Q128 flash (via USB programmer):
   ```c
   /* /app/blink.c - blink LED on PB0 */
   #define RCC_AHB4ENR (*((volatile unsigned int*)0x580244E0))
   #define GPIOB_MODER (*((volatile unsigned int*)0x58020400))
   #define GPIOB_ODR    (*((volatile unsigned int*)0x58020414))
   void main(void) {
       int i;
       RCC_AHB4ENR |= (1u << 1);
       GPIOB_MODER = (GPIOB_MODER & ~(3u)) | (1u);
       while (1) {
           GPIOB_ODR |= (1u << 0);
           for (i = 0; i < 1000000; i++) {}
           GPIOB_ODR &= ~(1u << 0);
           for (i = 0; i < 1000000; i++) {}
       }
   }
   ```
2. In the serial terminal: `compile /app/blink.c`
3. The compiler outputs the binary to the `ark_code_buffer` section in AXI SRAM.
4. Use `run /app/blink.c` to compile and execute (skeleton; real hardware needs VTOR setup).

## 4. Known Limitations

- `Drivers/CMSIS/**` and `Drivers/STM32H7xx_HAL_Driver/**` are currently
  **minimal placeholders**, only ensuring the project structure opens and the
  ArkCC core can be compiled standalone. **You must fill in the official code.**
- The `SystemInit` / `HAL_*MspInit` / `MX_*_Init` in `system_stm32h7xx.c` and
  `stm32h7xx_hal_msp.c` are placeholders that do not actually initialize the
  480 MHz PLL, USART1, or SPI1. After flashing, they must be replaced with
  STM32CubeMX-generated or hand-written initialization.
- Only the **ARM backend** (`backend_arm.c`) is compiled. The x86_64 / RISC-V / C
  backends are disabled to save Flash; to enable one, add the corresponding
  `src/backend/<arch>/*.c` to the `ArkCC/Backend` group.
- `startup_stm32h743xx.s` only provides a minimal vector table (NMI~SysTick) and
  declares no peripheral IRQs. For USART1/SPI1 interrupt-driven use, extend the
  vector table and ISRs.
- Some secondary fields in the project file (pack version, Flash algorithm ID,
  etc.) use generic defaults; Keil may prompt for an auto-update on first open --
  just confirm it.
- Requirements: Keil MDK 5.36+ / ARM Compiler 6.16+.

## 4.1 Build Status (verified 2026-11-19)

`UV4.exe -b ArkCC.uvprojx` was run from a clean tree and now finishes with
**0 errors** (11 warnings, all benign: unused statics in the trimmed profile and
two files without a trailing newline).

```
Program Size: Code=174296  RO-data=21144  RW-data=695404  ZI-data=102720
```

What had to be fixed for that to be true, in case you are diffing against an
older checkout:

- **Link-time tables moved into `.ark_buf`.** `g_ld_syms` / `g_ld_relocs` /
  `g_ld_dsyms` are 512 entries of 136/140 bytes each at the `STM32_MIN`
  profile, i.e. ~213 KB of plain `.bss`. Together with the rest of `.data/.bss`
  that overflowed the 288 KB SRAM1-3 region (`L6407E: Sections of aggregate size
  0x8ecc bytes could not fit`). They now carry
  `__attribute__((section(".ark_buf")))` like every other large buffer, so the
  scatter file puts them in SDRAM/AXI. Both counters are reset at the start of
  every link, so this costs nothing at runtime.
  Note that `.ark_buf` is emitted as *initialised* data by ARMCC, which is why
  `RW-data` is 695 KB: the image carries zeros and `__main` copies them. Flash
  still fits (code + RO + RW = ~870 KB of 2 MB).
  The fallback layout (`STM32H743VITx_FLASH_sram.sct`, AXI only, 512 KB) can no
  longer hold the whole `.ark_buf`; if you switch to it, also build with
  `-DARK_LINK_MAX_SYMS=256 -DARK_LINK_MAX_RELOCS=256`.
- **`opt_dce_cfg_func` was named unconditionally** in `src/pipeline.c` while
  `ARKCC_FEATURE_OPT_DCE_CFG` is 0 at `STM32_MIN`, so the trimmed build failed
  with "Undefined symbol opt_dce_cfg_func". The row is now inside `#if`, like
  the LICM/unroll rows.
- **`g_x86_obj_mode` was written unconditionally** in `src/compiler.c` while the
  x86_64 backend is trimmed at `STM32_MIN`. The three assignments are now
  inside `#if ARKCC_BACKEND_X86_64`.
- **`src/ipo.c` and `src/irser.c` were missing from the project.** Both keep
  their exported symbols (`ark_ipo_compile`, `ir_stashed_payload`) in a trimmed
  build on purpose -- they are the "refuse with a diagnostic instead of
  disappearing" stubs -- so they must always be compiled. Added to the
  `ArkCC/Core` group.

The host build is unaffected: with the full profile the two `#if` blocks compile
the same tokens as before, and `make test` reports the same 344 PASS / 0 FAIL /
1 SKIP.

One discrepancy worth knowing: `ArkCC.uvprojx` has `<uAC6>0</uAC6>`, so the
project builds with **ARM Compiler 5.06 update 7** (ARMCC) even though step 4
above says to select ARM Compiler 6. The verified build above used V5.06.

## 4.2 Self-hosted compile -> link -> run, verified on hardware (2026-11-19)

`build` and `run <file>` used to be advertised in `help` but ended at a `printf`
placeholder. They now perform the whole chain **on the chip**: compile the
sources to `ARKOBJ2` objects, link them against `app.sct`, load the image into
AXI SRAM at `0x24070000` and call its reset handler. The log below is copied
from a USART1 capture (PA9/PA10, 115200 8N1) at 22:07 on an STM32H743VIT6.
The firmware that produced it builds with
`Code=175540 RO-data=21628 RW-data=695412 ZI-data=102720` (AC5.06, 0 errors):

```
arkcc> build
[arkcc] cc -c hello.c -o hello.o
[arkcc] cpu=Cortex-M7 arch_m=7 dsp=1 fpu=1
[arkcc] target=arm, source=382 bytes
[scatter] parsed app.sct
[arkcc] wrote object 'hello.o' (1290 bytes code, 3 syms, 3 relocs)
[arkcc] cc -c crt.c -o crt.o
[arkcc] wrote object 'crt.o' (146 bytes code, 3 syms, 2 relocs)
[arkcc] cc -link hello.o crt.o -o app.bin --scatter app.sct
[link] object 0: base 0x0, 1290 bytes
[link] object 1: base 0x50A, 146 bytes
[link] note: 1 duplicate compiler-runtime symbols merged (first definition kept)
[scatter] parsed app.sct
[link] vector table written into the 1024-byte hole the first object reserved (SP=0x2407C000, entry=0x24070560)
[arkcc] linked 2 objects -> app.bin (1436 bytes, 5 syms, 5 relocs)
[arkcc] image loaded at 24070000, 1436 bytes

--- program output -------------------------------------------
hello, world
written by arkcc running on the STM32H743 itself

--------------------------------------------------------------
[arkcc] program returned 0
```

`run hello.c` goes through the same three stages (`run.o` + `crt.o` -> same
image) and prints the same two lines, so the returned 0 is a real `main()`
return, not a canned message.

### 4.2.1 What had to be fixed (four defects, all silent)

1. **Uninitialised option fields.** `ArkOptions` grew fields in 0.8.7
   (`ipo_mode`, `ipo_inputs[]`, `object_ir`, `lto_link`, `partial_link`, ...);
   the shell's `opts_reset()` still listed them by hand and missed the new
   ones. Because the struct lives on the stack, a non-zero `ipo_mode` left over
   from the previous call made `build` answer
   `--ipo is not compiled into this build`. `opts_reset()` now starts with
   `memset(o, 0, sizeof(*o))` (host `reset_opts()` too), and `cmd_compile()`
   calls `opts_reset()` instead of keeping its own copy of the field list.
2. **Objects compiled without the layout.** `build_object()` did not pass
   `--scatter app.sct`, so the objects baked in the default data window
   (`0x20000000`) and the linker refused them. Each object is now compiled with
   the same scatter file it is later linked with, and only the *first* object
   gets `--vector-table` (the 1 KB hole belongs to the image, not to every
   unit).
3. **No RESET selector in the embedded scatter text.** `--vector-table` is
   rejected when the layout defines no `RESET` section
   (`scatter_validate()` -> `er_holds_reset()`), and the demo text had none.
   `app.sct` now carries `*.o (RESET, +First)`, exactly like the canonical
   shape used by `tests/run_reloc_text_tests.py`.
4. **Initial SP landed on executable memory.** With one region
   (`ER_APP 0x24070000 0x0000F000 ... +RW +ZI`) the linker derived
   `initial_sp = load_addr + size = 0x2407F000` -- the address of the console
   trampoline. The image therefore started with a stack pointer pointing at
   code. The text is now split into
   `ER_APP 0x24070000 0x0000B000 (+RO)` and
   `ER_IRAM1 0x2407B000 0x00001000 (+RW +ZI)`, so `SP = 0x2407C000`, i.e. the
   top of the RAM region -- unused RAM, as the ABI requires.

### 4.2.2 How the image gets onto the chip and actually runs

The board is a bare STM32H743VIT6 reached through a CMSIS-DAP probe. Two
findings are worth recording because both look like firmware bugs:

- **pyocd does not work on this part.** CoreSight ROM-table discovery fails
  before any flash operation (`no cores found`), for every clock/connect mode
  tried. Keil's own flash algorithm does work.
- **`UV4 -f -j0 <project>` flashes correctly but leaves the core halted.**
  The log says `Erase Done.Programming Done.Verify OK`, the vector table reads
  back correctly (`0x08000000 = 0x20020000`, `0x08000004 = 0x08000085`,
  `CFSR = HFSR = 0`), yet USART1 stays silent. `UV4 -d <project> -j0` with an
  init file whose single command is `EXIT` downloads, verifies, leaves debug
  mode and *then* runs the target -- that is the command sequence used for the
  capture above. The MCP tool that wraps it is
  `batch_debug_script(commands=["EXIT"])`.

### 4.2.3 One layout per call

`g_config` outlives a single `ark_compile()`; the shell compiles several images
per power cycle. The `--scatter`/`-T` bridge in `src/compiler.c` used to install
a layout only when `g_config.scatter_file` was still empty, so `build` followed
by `compile hello.c` parsed `app.sct` for a request that never mentioned it
(the log line `[scatter] parsed app.sct` appeared out of nowhere). The bridge is
now re-evaluated on every call and remembers by pointer which value it installed
itself, so a caller that writes `g_config` directly keeps working while a value
installed by an earlier call is dropped. Verified on the board: after `build`
and `run hello.c`, `compile hello.c` and `compile crt.c` no longer print the
scatter line and still report the expected
`2 reference(s) cannot be resolved in a single-file image`.

## 5. Compiler Invocation Interface

The shell in `User/main.c` uses `ark_compile()` directly with `target=arm`
and `cpu=Cortex-M7` options:

```c
ArkOptions opts;
opts.input_path = "/app/blink.c";
opts.target = "arm";
opts.cpu = "Cortex-M7";
opts.verbose = 1;
/* ... other fields zero-initialized ... */
int rc = ark_compile(&opts);  /* returns ARK_OK (0) on success */
```

For convenience, `ark_compile_and_run(path)` is also available as a
one-liner that compiles with default settings (no explicit target).

### Scatter / Linker Script Support (0.7.0+)

ArkCC supports both ARM scatter (`.sct`) and GNU ld (`.ld`) linker scripts:

```c
opts.scatter_file  = "/app/layout.sct";  /* ARM scatter file */
opts.linker_script  = "/app/layout.ld";  /* GNU ld script   */
```

When a scatter file is provided, the compiler:
1. Parses the scatter description (LR/ER regions, selectors)
2. Converts `.sct` -> `.ld` (for arm-none-eabi-ld compatibility)
3. Converts `.ld` -> `.sct` (for armlink compatibility)

The generated script is written next to the output file with the
corresponding extension (`.ld` or `.sct`).

See `test_stm32.sct` and `test_stm32.ld` in the repository root for
complete examples matching the STM32H743 memory map.

### Build Profiles (arkcc_config.h)

The compiler can be configured at build time via `include/arkcc_config.h`:

| Profile         | Macro              | Backends       | Use Case                          |
|-----------------|--------------------|----------------|-----------------------------------|
| HOST_FULL (0)   | `ARKCC_PROFILE=0`  | arm+x86+riscv+c | Full host compiler              |
| STM32_MIN (1)   | `ARKCC_PROFILE=1`  | arm only      | Self-hosted on STM32              |
| CROSS_COMPILE(2)| `ARKCC_PROFILE=2`  | arm+c          | Windows cross-compile to STM32    |

Frontend features (VLA, _Complex, wchar_t, trigraphs) and armcc
compatibility (keywords, pragmas, asm func) are **always enabled** to
ensure the compiler can still build STM32 programs in any profile.
