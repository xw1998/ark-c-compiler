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
