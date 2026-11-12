# arkCC + armcc5 STM32 build manual

[中文](STM32_BUILD.md) | English

> Audience: anyone who wants to build arkCC into an STM32 firmware on Windows with ARM Compiler 5 (armcc 5.06) and run the self-hosted compiler on an STM32H743 board
> Encoding: UTF-8 (no BOM)

---

## 1 Overview

arkCC is a self-hosted C compiler written in C99. This manual describes two build paths:

| Path | Toolchain | Input | Output | Purpose |
| --- | --- | --- | --- | --- |
| **A. armcc5 command line** (recommended) | armcc 5.06 + armlink + fromelf + armasm | all of arkCC's `.c` sources + MDK user files + startup assembly | `arkcc_stm32.{elf,hex,bin}` | flash onto an STM32H743, then compile C source on the board |
| **B. Keil MDK IDE** | same, but driven by the `.uvprojx` project file | same | same | build and debug inside the Keil IDE |

Path A is the "shortest possible flow" that a single PowerShell script completes; path B suits
situations that need ST-Link single-stepping.

> **What has actually run on the board**: both paths answer "compile the compiler itself into a
> firmware". "Compile several `.c` files on the board and then run the result on the same chip" is a
> different segment, and it has been taken end to end on 2026-11-05; the minimal example and its
> pass criteria live in [`examples/stm32_selfhost_build/`](../examples/stm32_selfhost_build/), and the
> position of that milestone among the three segments is in the root
> [README.md](../README.en.md#milestone-compiling-on-an-stm32-running-on-an-stm32).

---

## 2 Preparing the environment

### 2.1 Install Keil MDK 5.x

1. Download MDK-ARM 5.36+ from [keil.com](https://www.keil.com/download/) (it ships armcc 5.06 update 7).
2. Default install path: `D:\Keil_v5\`; the armcc toolchain lives in `D:\Keil_v5\ARM\ARMCC\bin\`.
3. Install the STM32H7 device pack: Keil → Pack Installer → search for `Keil.STM32H7_DFP`.

### 2.2 Verify the toolchain

Open PowerShell:

```powershell
& "D:\Keil_v5\ARM\ARMCC\bin\armcc.exe" --version
# the output should contain: ARM Compiler 5.06 update 7 (build 960)

& "D:\Keil_v5\ARM\ARMCC\bin\armlink.exe" --help | Select-String "scatter"
# you should see the --scatter option described
```

If `armcc.exe` is not on PATH, `build_stm32_armcc.ps1` probes `D:\Keil_v5\ARM\ARMCC\bin\` on its own.

### 2.3 Hardware

| Device | Purpose |
| --- | --- |
| STM32H743VIT6 development board | runs the arkCC firmware |
| ST-Link V2/V3 debug probe | flashing + debugging |
| W25Q128 SPI flash (on-board or external) | holds the `.c` sources to be compiled |
| USB-TTL serial module | shows the UART output (PA9/PA10, 115200 8N1) |

---

## 3 Path A: one-script build

### 3.1 Run the script

```powershell
cd "<ark-cc-repo-path>"
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
```

### 3.2 What the script does

1. **Locate armcc5**: try PATH first, then `D:\Keil_v5\ARM\ARMCC\bin\`.
2. **Compile the 18 core `.c` files** (`src/*.c`):
   - `compiler.c` `lexer.c` `parser.c` `sema.c` `ir.c` `irgen.c` `ast.c` `type.c`
   - `symtab.c` `memory.c` `preproc.c` `codegen_common.c` `cpu.c` `scatter.c` `config.c` `opt.c`
   - `diag.c` `diag_msg_table.c` (the diagnostics layer; the list is spelled out explicitly in the script's `$coreFiles`)
3. **Compile the 2 ARM backend files**: `backend/arm/backend_arm.c` + `backend/registry.c`
4. **Compile the 2 STM32 port files**: `port/stm32/platform_stm32.c` + `port/stm32/flash_fs_stm32.c`
5. **Compile the 5 MDK user files**: `mdk/STM32H743_ArkCC/User/{main,stm32h7xx_it,stm32h7xx_hal_msp,system_stm32h7xx,bsp_w25q}.c`
6. **Assemble the startup file**: `Startup/startup_stm32h743xx.s` (with `armasm`)
7. **Link with armlink**: `--scatter=Linker/STM32H743VITx_FLASH.sct` over all `.o` files
8. **Convert with fromelf**: produce `.hex` and `.bin`

### 3.3 Key armcc5 compile options

| Option | Meaning |
| --- | --- |
| `--cpu=Cortex-M7` | target CPU selection |
| `--thumb` | Thumb-2 mode (mandatory on Cortex-M) |
| `-O0` | optimiser off (easier debugging; switch to `-O2` or `-O3` to shrink the code) |
| `-g` | emit debug information |
| `--c99` | **mandatory**. armcc5 defaults to C90; arkCC's sources need C99 mixed declarations and statements |
| `--apcs=interwork` | ARM/Thumb interworking ABI |
| `-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` | selects the minimal STM32 profile, which brings buffer sizes down from host GB scale to KB scale |
| `-I..\..\include -I..\..\include\..\stdlib\include` | header search paths |

### 3.4 Key armlink options

| Option | Meaning |
| --- | --- |
| `--scatter=<sct>` | scatter-loading description file, defines the memory layout |
| `--map` | write a map file |
| `--symbols` | write a symbol table |
| `--info=totals,sizes,unused,summarysizes` | section size summaries |

**Semihosting**: the armcc5 C library uses semihosting by default, but scatter loading conflicts with
semihosting's `__user_initial_stackheap`. The fix is to provide a custom
`__user_initial_stackheap` in `system_stm32h7xx.c` that points the C library heap at
`ark_heap_buffer` (a 32 KB buffer in AXI SRAM). See
[6.1](#61-l6915e-the-semihosting-__user_initial_stackheap-cannot-reliably-set-up).

### 3.5 Output files

Output directory: `bootstrap_x86\armcc_objs\`

| File | Size (typical) | Purpose |
| --- | --- | --- |
| `arkcc_stm32.elf` | ~458 KB | full ELF (symbol table included, for debugging) |
| `arkcc_stm32.hex` | ~428 KB | Intel HEX format (for ST-Link Utility) |
| `arkcc_stm32.bin` | ~152 KB | raw binary (for openocd) |
| `arkcc_stm32.map` | - | link map file (memory layout analysis) |

### 3.6 Verify the build

```powershell
# check the entry points
& "D:\Keil_v5\ARM\ARMCC\bin\fromelf.exe" --text -s bootstrap_x86\armcc_objs\arkcc_stm32.elf | Select-String "Reset_Handler|main"
# you should see Reset_Handler @ 0x080xxxxx and main @ 0x080xxxxx

# check the file sizes
Get-ChildItem bootstrap_x86\armcc_objs\arkcc_stm32.* | Select-Object Name, Length
```

---

## 4 Path B: Keil MDK IDE build

### 4.1 Open the project

Open `mdk/STM32H743_ArkCC/ArkCC.uvprojx` with Keil µVision.

### 4.2 Configure the options

Project → Options for Target (Alt+F7):

| Tab | Setting |
| --- | --- |
| **Device** | STM32H743VIT6 (pick it from the STM32H7 DFP) |
| **Target** | ARM Compiler: **V5.06** (important: do not pick V6, V6 is armclang) |
| **Target** | Read/Only Memory Areas: as the scatter file says (usually the defaults are fine) |
| **Output** | Name of Executable: `arkcc_stm32` |
| **Listing** | tick `Map File` |
| **C/C++** | Optimization: `-O0` (debug) or `-O2` (release) |
| **C/C++** | C/C++ Language: choose **C99** |
| **C/C++** | Preprocessor Symbols: define `ARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` |
| **C/C++** | Include Paths: `..\..\include;..\..\include\..\stdlib\include;..\..\port\stm32;Drivers\CMSIS\Device\ST\STM32H7xx\Include;Drivers\CMSIS\Include` |
| **Asm** | same Include Paths as C/C++ |
| **Linker** | Use Memory Layout from Target Dialog: **clear the tick** |
| **Linker** | Scatter File: `Linker\STM32H743VITx_FLASH.sct` |
| **Linker** | tick `Use Linker Script` |
| **Debug** | ST-Link Debugger |

### 4.3 Build and flash

1. **Build**: Project → Build Target (F7)
2. **Download**: Flash → Download (F8)
3. **Debug**: Debug → Start/Stop Debug Session (Ctrl+F5)

### 4.4 Replacing HAL

The `Drivers/CMSIS/Device/ST/STM32H7xx/Include/` shipped with the project holds placeholder headers.
To use the real HAL:

1. Copy `Drivers/CMSIS/**` and `Drivers/STM32H7xx_HAL_Driver/**` from the STM32CubeH7 repository
   over the placeholders.
2. In Keil → Project → Manage → Project Items → Groups, add the `stm32h7xx_hal_*.c` files you need to
   the `Drivers/HAL` group.
3. Enable the HAL modules you need in `stm32h7xx_hal_conf.h`.

> Note: the current `system_stm32h7xx.c` and `stm32h7xx_hal_msp.c` provide **register-level**
> UART/SPI implementations, so the project works without HAL. Replacing HAL is optional.

---

## 5 Memory layout and the .sct file

### 5.1 STM32H743 memory regions

| Region | Start address | Size | Purpose |
| --- | --- | --- | --- |
| Flash | `0x08000000` | 2 MB | code + read-only data |
| DTCM | `0x20000000` | 128 KB | globals + stack |
| AXI SRAM | `0x24000000` | 512 KB | arkCC's large buffers |
| ITCM | `0x00000000` | 64 KB | (unused) |
| SRAM1/2/3 | `0x30000000` | 288 KB | (unused) |

### 5.2 Scatter file structure

File: `mdk/STM32H743_ArkCC/Linker/STM32H743VITx_FLASH.sct`

```text
LR_IROM1 0x08000000 0x00200000  {
  ER_IROM1 0x08000000 0x00200000 {        /* Flash: code + read-only data */
    *.o (RESET, +First)                   /* the vector table must come first */
    *(InRoot$$Sections)                  /* C library internal sections */
    .ANY (+RO)                           /* the remaining .text/.rodata */
    .ANY (+XO)                           /* execute-only sections, if any */
  }
  RW_IRAM1 0x20000000 0x00020000 {        /* DTCM 128K: globals */
    .ANY (+RW +ZI)                       /* .data + .bss */
  }
  RW_AXI 0x24000000 0x00080000 {          /* AXI SRAM 512K: large buffers */
    *(.ark_heap)                         /* arkCC memory pool */
    *(.ark_code)                          /* generated machine code */
    *(.ark_buf)                          /* large static arrays */
  }
}
```

### 5.3 Section-to-region mapping

arkCC routes its large static arrays to AXI SRAM with `__attribute__((section(".ark_buf")))`:

| Section | Source | Region |
| --- | --- | --- |
| `.text` + `.rodata` | code + constants | Flash |
| `.data` + `.bss` | globals | DTCM |
| `.ark_buf` | large arrays in `compiler.c`/`memory.c`/`preproc.c`/`backend_arm.c` | AXI SRAM |
| `.ark_code` | `ark_code_buffer[32K]` in `User/main.c` | AXI SRAM |
| `.ark_heap` | `ark_heap_buffer[32K]` in `User/main.c` | AXI SRAM |

### 5.4 Current memory use

| Region | Used | Capacity | Utilisation |
| --- | --- | --- | --- |
| Flash | 148.59 KB | 2 MB | 7.3% |
| DTCM | 19.3 KB | 128 KB | 15% |
| AXI SRAM | 64 KB | 512 KB | 12% (448 KB left, of which 60 KB is the window reserved for loading on-board build output) |
| SDRAM | 404 KB | 32 MB | 1.2% |

> This revision moved the whole `.ark_buf` block (the compiler's work buffers, about 311 KB
> initialised plus the rest zeroed) out to the external SDRAM at 0xC0000000, so AXI SRAM keeps only
> the two 32 KB windows `.ark_code`/`.ark_heap`. Details, switches and the rollback path are in §13.

**AXI SRAM breakdown**:

| Section | Size | Contents |
| --- | --- | --- |
| `.ark_buf` (compiler.o) | 160 KB | `g_src`(32K) + `g_asm`(64K) + `g_code`(32K) + `dep/ld/sct`(24K) + the rest(8K) |
| `.ark_buf` (memory.o) | 64 KB | the `g_pool` memory pool |
| `.ark_buf` (preproc.o) | 64 KB | `g_inc_bufs`(4×8K) + `out_buf`(32K) |
| `.ark_buf` (backend_arm.o) | 24 KB | `g_arm_syms`(12K) + `g_arm_relocs`(12K) |
| `.ark_code` | 32 KB | generated Thumb-2 machine code buffer |
| `.ark_heap` | 32 KB | armcc5 C library heap |

---

## 6 Common build errors

### 6.1 L6915E: The semihosting __user_initial_stackheap cannot reliably set up...

**Cause**: the armcc5 C library initialises heap/stack through semihosting by default, which conflicts
with scatter loading.

**Fix**: `mdk/STM32H743_ArkCC/User/system_stm32h7xx.c` already provides a
`__user_initial_stackheap` redirect:

```c
__value_in_regs struct __initial_stackheap __user_initial_stackheap(
        unsigned R0, unsigned SP, unsigned R2, unsigned SL) {
    struct __initial_stackheap config;
    config.heap_base  = ark_heap_buffer;
    config.heap_limit = ark_heap_buffer + 32 * 1024;
    config.stack_base  = (unsigned char *)(0x20000000 + 0x20000);
    config.stack_limit = (unsigned char *)(0x20000000 + 0x20000 - 0x8000);
    return config;
}
```

Make sure that file is part of the build, and that it is compiled with `--c99`.

### 6.2 L6220E: Load region RW_AXI size exceeds limit

**Cause**: AXI SRAM (512 KB) overflowed.

**Fix**: shrink the STM32 profile buffer sizes in `include/arkcc_config.h`:

```c
#ifndef ARK_POOL_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_POOL_SIZE          (64 * 1024)     /* can go down to 32K */
# else
#   define ARK_POOL_SIZE          (64 * 1024 * 1024)
# endif
#endif
```

The knobs:
- `ARK_POOL_SIZE` (64K by default)
- `PP_INC_BUF` × `PP_MAX_INC_DEPTH` (8K × 4 = 32K by default)
- `PP_BUF_SIZE` (32K by default)
- `ARK_ASM_BUF_SIZE` (64K by default)
- `ARK_CODE_BUF_SIZE` (32K by default)
- `ark_heap_buffer` ([User/main.c](../mdk/STM32H743_ArkCC/User/main.c), 32K by default)

### 6.3 #268: declaration may not appear after executable statement

**Cause**: armcc5 defaults to C90 mode, which forbids mixing declarations and statements.

**Fix**: `build_stm32_armcc.ps1` already passes `--c99`. When building in the Keil IDE, pick C99 under
Options → C/C++ → Language.

### 6.4 Undefined symbol arkcc_on_output

**Cause**: `flash_fs_stm32.c` calls `arkcc_on_output()` but nothing defines it.

**Fix**: `flash_fs_stm32.c` already provides an `__attribute__((weak))` default (it prints the bytes to
UART as hex). A user can override it with a strong definition in `main.c`.

### 6.5 Undefined symbol HAL_UART_Receive

**Cause**: the MDK `main.c` calls `HAL_UART_Receive()` but the placeholder headers did not declare it.

**Fix**: the declaration was added to `stm32h743xx.h`, and a register-level implementation was added to
`system_stm32h7xx.c`.

### 6.6 Multiply defined symbols (HAL_Init, HAL_UART_Transmit, ...)

**Cause**: the HAL functions were implemented in both `stm32h7xx_hal_msp.c` and `system_stm32h7xx.c`.

**Fix**: `stm32h7xx_hal_msp.c` was reverted to hold only empty MSP hook functions; all HAL
implementations now live in `system_stm32h7xx.c`.

### 6.7 Chinese path encoding (PowerShell)

**Cause**: the PowerShell script used absolute paths containing Chinese characters (`d:\工作\...`),
which produced mojibake.

**Fix**: `build_stm32_armcc.ps1` now uses relative paths and is run from the project root.

---

## 7 Removing the semihosting dependency

The armcc5 C library uses semihosting by default (traps into the debugger through a BKPT
instruction). On an STM32 without a debugger that raises a HardFault. arkCC's sources have removed
every semihosting dependency:

| Original dependency | Replacement | File |
| --- | --- | --- |
| `fopen/fread/fclose` | the `fs_read_file()` abstraction (host=stdio, STM32=W25Q) | `src/scatter.c` |
| `vsnprintf` | a custom `put_fmt()` (supports `%s`/`%X`/`%d`/`%c`/`%%`) | `src/scatter.c` |
| `snprintf("%.17g")` | a custom `sb_putf()` double-to-string | `src/irgen.c` |
| `getenv("ARKCC_DUMP_SYMS")` | the profile-aware global `g_arm_dump_syms` | `src/backend/arm/backend_arm.c` |
| `<stdio.h>` include | removed (not needed) | `src/compiler.c` `src/ir.c` `src/type.c` |
| `<stdlib.h>` include | removed (`realloc` replaced by `mem_realloc`) | `src/backend/arm/backend_arm.c` |

Together with the `__user_initial_stackheap` redirect, the arkCC firmware is completely free of
semihosting and runs standalone on a target board with no debugger attached.

---

## 8 Flashing and verifying

### 8.1 Flash with ST-Link Utility

1. Open STM32 ST-LINK Utility
2. Target → Connect
3. File → Open File: pick `arkcc_stm32.hex`
4. Target → Program & Verify
5. Reset the board

### 8.2 Flash with openocd

```bash
openocd -f interface/stlink.cfg -f target/stm32h7x.cfg \
    -c "program arkcc_stm32.bin 0x08000000 verify reset exit"
```

### 8.3 Check the serial output

Connect PA9(TX) / PA10(RX) to the USB-TTL module, 115200 8N1:

```
=== Ark C Compiler on STM32H743 ===
Compiling /app/main.c from W25Q...
Exit code: 42
```

Seeing that output means arkCC has successfully self-hosted a compile of `/app/main.c` on the STM32.

### 8.4 Preparing the source file on W25Q

W25Q128 needs a minimal file index table plus the file data:

```text
0x000000   FileEntry[32]   each entry 32 B = char name[24] + uint32 offset + uint32 size
0x010000   /app/main.c     the user source
```

A host-side Python script generates the image:

```python
import struct
def make_image(files):
    table = bytearray(32 * 32)
    body = bytearray()
    base = 0x010000
    for i, (name, data) in enumerate(files):
        n = name.encode()[:24].ljust(24, b'\0')
        struct.pack_into('<24sII', table, i*32, n, base, len(data))
        body += data
        base += (len(data) + 4095) & ~4095
    return bytes(table) + bytes(0x10000 - len(table)) + bytes(body)

with open('w25q_image.bin', 'wb') as f:
    f.write(make_image([('/app/main.c', b'int main(void){return 42;}\n')]))
```

Then write the image into W25Q through ST-Link / serial / USB (remember the 4 KB sector erase).

---

## 9 Tuning the buffer sizes

Every large buffer size is controlled by the `ARKCC_PROFILE` macro in
[include/arkcc_config.h](../include/arkcc_config.h):

| Macro | STM32_MIN | HOST_FULL | Purpose |
| --- | --- | --- | --- |
| `ARK_POOL_SIZE` | 64 KB | 64 MB | AST/IR/symbol-table memory pool |
| `ARK_ASM_BUF_SIZE` | 64 KB | 1 MB | assembly text buffer |
| `ARK_CODE_BUF_SIZE` | 32 KB | 1 MB | machine code buffer |
| `ARK_OBJ_BUF_SIZE` | 4 KB | 256 KB | object file buffer |
| `ARK_LINK_BUF_SIZE` | 4 KB | 256 KB | link buffer |
| `ARK_SRC_BUF_SIZE` | 32 KB | 1 MB | source read buffer |
| `PP_BUF_SIZE` | 32 KB | 4 MB | preprocessor output buffer |
| `PP_INC_BUF` | 8 KB | 1 MB | buffer per included file |
| `PP_MAX_INC_DEPTH` | 4 | 32 | include nesting depth |
| `ARM_MAX_SYMBOLS` | 1024 | 4096 | symbol table entries |
| `ARM_MAX_RELOCS` | 1024 | 4096 | relocation entries |
| `ARM_MAX_GVARS` | 512 | 2048 | global variable entries |

**STM32 total-footprint formula**:
```
AXI = ARK_POOL_SIZE + ARK_ASM_BUF_SIZE + ARK_CODE_BUF_SIZE + ARK_OBJ_BUF_SIZE
    + ARK_LINK_BUF_SIZE + ARK_SRC_BUF_SIZE + PP_BUF_SIZE
    + PP_INC_BUF * PP_MAX_INC_DEPTH
    + ARM_MAX_SYMBOLS * 12 + ARM_MAX_RELOCS * 12
    + ark_heap_buffer + ark_code_buffer
```

To shrink the AXI footprint further, reduce `ARK_POOL_SIZE` (it bounds how large a source file can be
compiled) or `PP_INC_BUF * PP_MAX_INC_DEPTH` (it bounds the include nesting depth).

---

## 10 armcc5 compatibility roadmap

**Goal**: on a machine with armcc5 installed, arkCC is fully compatible with armcc5 — it can compile
an executable out of an MDK project without any change to that project — and arkCC then runs on an
STM32, so that STM32 compiles programs for STM32.

| Stage | Goal | Status |
| --- | --- | :---: |
| Stage 1 | arkCC itself compiles into an STM32 firmware with armcc5 | ✅ done |
| Stage 2 | the on-board arkCC compiles `.c` source into a `.bin` | ✅ done |
| Stage 3 | the on-board build output can be flashed back into Flash and jumped to | ✅ done (executes from the Flash application area at `0x081E0000` and survives a reset; see §12 and §15) |
| Stage 4 | an unmodified MDK project can be compiled directly by arkCC | ✅ done (`--uvprojx` extracts include paths and macro definitions automatically; divide-by-zero protection in the preprocessor) |
| Stage 5 | full support for `__user_initial_stackheap`, HAL redirection and scatter linking | ✅ done (`__user_initial_stackheap` + `putchar`/`fputc` UART redirect + malloc/free + scatter-aware vector table generation) |

**Stages 1-2 were delivered by `build_stm32_armcc.ps1`, stages 4-5 are complete**, and everything this
manual describes has been verified on real hardware. The third segment of stage 3 (flash the output
back into internal Flash and jump to it) was closed on 2026-11-09; see §15.

---

## 11 References

- [docs/MANUAL.md](MANUAL.en.md): the complete arkCC user manual
- [README.md](../README.en.md): project overview and feature list
- [include/arkcc_config.h](../include/arkcc_config.h): buffer size configuration
- [build_stm32_armcc.ps1](../build_stm32_armcc.ps1): the armcc5 build script
- [mdk/STM32H743_ArkCC/](../mdk/STM32H743_ArkCC/): the Keil MDK project
- ARM Compiler 5 documentation: [developer.arm.com/tools-and-software/software-development-tools/legacy-compiler-tools](https://developer.arm.com/tools-and-software/software-development-tools/legacy-compiler-tools)

## 12 Compiling and running a POSIX hello world on the board (stage 3 progress)

Goal: the compiler loads a program **into RAM and runs it** on the STM32H743, with the UART as the
witness. The chain is: `demo` (writes `unistd.h` / `hello.c` / `crt.c` / `app.sct` into RAM file slots) →
`build` (on-board `-c hello.c`, `-c crt.c`, `-link ... --scatter app.sct`, with the image landing
directly at `0x24070000`) → take vector table `[1]` as a function pointer and call it (returning goes
back to the shell).

### 12.1 Measured output (already working)

```
arkcc> demo
[arkcc] installing sources into RAM file slots...
  unistd.h 198 bytes (ram) / hello.c 382 bytes (ram)
  crt.c 710 bytes (ram)     / app.sct 361 bytes (ram)
arkcc> build
[arkcc] cc -c hello.c -o hello.o
[arkcc] wrote object 'hello.o' (3028 bytes code, 43 syms, 2 relocs)
[arkcc] cc -c crt.c -o crt.o
[arkcc] wrote object 'crt.o' (2810 bytes code, 43 syms, 2 relocs)
[arkcc] cc -link hello.o crt.o -o app.bin --scatter app.sct
[link] vector table written into the 1024-byte hole the first object reserved
       (SP=0x2407F000, entry=0x2407102B)
[arkcc] linked 2 objects -> app.bin (5838 bytes, 45 syms, 4 relocs)
[arkcc] image loaded at 24070000, 5838 bytes
--- program output -------------------------------------------
hello, world
\x00D!..A..O..\x0b#..CP..\x04^..R..\x04[...
...
--------------------------------------------------------------
[arkcc] program returned 0
```

That is: **compile on the board → link on the board → load → execute → return 0 → back to the
shell**, all the way through. The `hello, world` printed by the first `write(1, msg, ...)` goes
through `write()` in `crt.c` → `0x2407F001` (the `ark_board_putn` trampoline) → USART1.

**Note**: this output is from after §14 fixed `--reloc-text`. Before the 0.8.0 preview, several lines
of garbage followed `hello, world`: the second `write()` takes a **string literal** rather than the
`msg[]` array, which hits the `.rodata` absolute-address defect recorded in §12.3 (baked in at
compile time as `0x08000000`, while the image actually lives at `0x24070000`). The fix and its
evidence are in §12.3 and §14.

### 12.2 The five real defects fixed in that round

| # | Symptom | Root cause | Fix |
|---|------|------|------|
| 1 | `build` hits `*** CPU FAULT ***`, CFSR=0x00080000, as soon as it starts compiling | **NOCP**: the prologue of `lexer_read_token` is `VPUSH {d8-d13}`, but CP10/CP11 in CPACR are not enabled | `*(volatile unsigned*)0xE000ED88 \|= 0xF<<20` in `SystemInit()`, then DSB/ISB (the project has no core_cm7.h, so the barriers are inline assembly in `__asm void`) |
| 2 | `cannot store hello.o (4162 bytes)` | `RAMFS_SLOTS` had only 4 slots and `demo` already used all of them (`unistd.h/hello.c/crt.c/app.sct`) | slots 4 → 8, per-slot 4096 → 8192 |
| 3 | `object file is 4162 bytes but only 4095 could be read` | `ARK_LINK_BUF_SIZE` is 4 KB under the STM32 profile | 16 KB (`out_buf` has the same size and accumulates the image) |
| 4 | a 4162-byte object into a 4 KB `ARK_OBJ_BUF_SIZE` | **silently writes 66 bytes out of bounds** (the symbol-table loop has no bounds check) | 4 KB → 16 KB under the STM32 profile |
| 5 | INVSTATE (CFSR=0x00020000) the moment the loaded image runs | `cmd_build` clears bit0 before calling the entry (`entry & ~1u`), so BLX to an even address switches to ARM state | keep the Thumb bit: `fn = (int(*)(void))entry` |

One **semantic bug** in the compiler itself was fixed as well: `sizeof("literal")` folded to the
pointer size 4. C11 6.5.3.4 says a string literal has type `char[n+1]`, so `sizeof("abc")==4`. The old
code evaluated `sizeof("written by arkcc ...")-1` to **3**, so `write()` sent only 3 bytes. `ast_str()`
sets the node type to `char*` first, so this check **must come before the generic `e->type` branch**
(placed after it, it is never reached — which is exactly why the first attempt at the fix did
nothing). After the fix the host build emits `MOV r0, #51`.

### 12.3 Closed: the .rodata absolute address was baked in at compile time

> **Status (0.8.0 preview)**: done via **option 2** below, behind the switch
> `--reloc-text` (default off). On the board the second line now prints
> `written by arkcc running on the STM32H743 itself` correctly; see §14.
> The original "two candidate convergence paths" text is kept here because it records the reasoning
> of that moment.

After the `sizeof` fix the second line's length really did become 50, but the content was still
garbage. Disassembly localised it:

```
24070474  movw r0, #0x400
24070478  movt r0, #0x800      ; -> 0x08000400, not 0x24070400
```

`.L_str_0` was resolved inside the object as `g_flash_base(0x08000000) + 0x400`, and that absolute
address **is not a relocation entry** (hello.o has only 2 relocs, both `BL write`), so the linker
cannot correct it; the image really sits at `0x24070000`, hence the bytes read back came from
`0x08000400` inside the firmware's own Flash.

The RAM side is the same story: the address of `static const char msg[]` was written as `0x20000000`
(the default `g_data_base`), but `__arkcc_init_globals()` also writes initial values to
`0x20000000`, so the two sides happen to agree and it is "accidentally right" in DTCM. That also
explains why the first line was right and the second one wrong.

Two candidate convergence paths (option 2 is implemented, option 1 was rejected):

1. **Carry the layout through both steps**: `build_object()` also passes `scatter_file` for `-c`, so
   that `g_flash_base / g_data_base` at compile time match the final layout. Smallest change, but it
   requires knowing the layout at compile time (a different philosophy from MDK's "relocation").
2. **Turn absolute references into relocations**: the backend emits a reloc for section-internal
   absolute addresses such as `.L_str_N`, and the linker corrects them from the `LR` load address.
   Structurally more correct, but it touches the ARKOBJ2 reloc kinds and the linker's patch logic.
   ← **this one was taken**

Option 1 was rejected because it only holds for the **first** object file: after passing the same
`--scatter` to `-c`, `hello.o`'s base happens to equal the LR base, but `crt.o` is concatenated after
`hello.o`, so every offset inside it is off by exactly the size of `hello.o` — it looks fixed, but it
is a different wrong answer. **Criterion**: after the fix one must be able to state the address of
"object N" as well; see check 3 in §14.3.

---

## 13 Stage 4: external SDRAM working, and the compiler's work buffers moved into SDRAM

Board: 反客 (Fanke) FK743M5-XIH6 (STM32H743XIH6 TFBGA240 + W9825G6 32 MB 16-bit SDRAM, FMC SDRAM bank1 @
`0xC0000000`, HSE 25 MHz). This firmware still runs from HSI at 64 MHz, so `fmc_ker_ck = HCLK = 64 MHz`
and `SDCLK = HCLK/2 = 32 MHz`.

### 13.1 Symptom: touching SDRAM gives IMPRECISERR

With the first driver (pure registers, `User/bsp_sdram.c`) and the `SDCMR` command sequence written,
`FMC_SDSR` stayed 0, `FMC_SDRTR` read back 0 after being written, and the first write to
`0xC0000006` gave

```
*** CPU FAULT ***   CFSR=0x00000400 (IMPRECISERR)  HFSR=0x40000000 (FORCED)
```

Flashing the vendor example onto the same board passed everything (32 MB write 145 ms / read 251 ms,
and the 8-bit NBL path also passed) ⇒ the hardware is fine, the configuration was wrong.

### 13.2 Method: read the registers of the firmware that works

No documentation reading, no guessing: flash the vendor firmware, stop it at the point where the test
passes, and read the registers:

| Register | Vendor (passes) | First version (fails) |
| --- | --- | --- |
| `FMC_SDCR1` | `0x000039D9` | `0x00003158` |
| `FMC_SDTR1` | `0x00126361` | `0x02237472` |
| `FMC_SDRTR` | `0x0000072C` (918<<1) | `0x00000000` (cannot be written) |
| `RCC_D1CCIPR` | `0x00000000` (FMCSEL=00=HCLK) | same |
| `FMC_BCR1` | `0x800030DB` (FMCEN=1) | reset value `0x000030DB` (FMCEN=0) |

Then reproduce step by step "when does `SDRTR` become writable": not writable after reset → still not
writable after enabling `RCC_AHB3ENR.FMCEN` → still not writable after setting `FMC_BCR1.FMCEN`. In the
vendor state it is writable. The only remaining difference is the contents of `SDCR1`/`SDTR1`.

### 13.3 Root cause: `SDCR1.SDCLK = 00` means "clock off", not HCLK/2

The constants in `stm32h7xx_ll_fmc.h` are the authority:

```
FMC_SDRAM_CLOCK_DISABLE  0x00000000   <-- what the first version used
FMC_SDRAM_CLOCK_PERIOD_2 0x00000800   (= HCLK/2, what the vendor used)
FMC_SDRAM_CLOCK_PERIOD_3 0x00000C00
```

With the SDRAM clock disabled the whole command generator does nothing: writes to `SDCMR` do not
count, `SDRTR` is not accepted, and `0xC0000000` returns the default slave AXI error ⇒ an imprecise
bus fault. Two other fields had the same kind of mistake (checked against the `FMC_SDRAM_*`
constants):

| Field | First version | True value | Consequence |
| --- | --- | --- | --- |
| `NC` | 00 (= **8** columns) | 01 (9 columns) | the 9th column address bit is not decoded, half a row is unreachable |
| `CAS` | 10 (= **2**) | 11 (3) | latency does not match |
| `SDCLK` | 00 (= **off**) | 10 (HCLK/2) | the whole block does nothing |

### 13.4 Final register values (field by field)

```
FMC_SDCR1 = 0x000039D9
  NC=01 NR=10 MWID=01 NB=1 CAS=11 WP=0 SDCLK=10 RBURST=1 RPIPE=01
FMC_SDTR1 = 0x00126361        // fields are "cycles - 1" (the vendor HAL subtracts 1 from each)
  TMRD=1 TXSR=6 TRAS=3 TRC=6 TWR=2 TRP=1 TRCD=0
FMC_SDRTR = 230 << 1 = 0x1CC  // recomputed from the real SDCLK of 32 MHz, not copied from the vendor's 918
```

The refresh count uses `(SDCLK_kHz × 64) / 8192 - 20`, which gives 230 at 32 MHz; the vendor's 918
only corresponds to 120 MHz, and copying it directly computes a refresh rate 4.7× too fast.

The `SDTR1` fields are **copied from the readings on the working board** rather than re-derived: at
32 MHz those cycle counts convert to even longer ns values (the shortest, TRCD = 1 cycle = 31 ns,
while the W9825G6 requires ≥18 ns), so they are certainly legal; that way getting it working the
first time does not turn into a second experiment.

### 13.5 Measurements (the `sdram` command)

```
[sdram] SDCR1=0x000039D9 SDTR1=0x00126361 SDRTR=0x000001CC SDSR=0x00000000
[sdram] command ran: busy_seen=0, SDSR after LOAD_MODE=0x00000000
[sdram] SDCLK = 32000 kHz (HCLK/2), refresh count = 230
[sdram] BCR1 before=0x000030DB after=0x800030DB, D1CCIPR=0x00000000 AHB3ENR=0x00001000
[sdram] written in 1312 ms (24.39 MB/s)
[sdram] 16-bit verify OK in 7130 ms (4.48 MB/s)
[sdram] 8-bit probe OK (NBL0/NBL1 are wired correctly)
[sdram] SDRAM OK: 32 MB usable at 0xC0000000
```

`busy_seen=0` is expected: at 32 MHz a PALL takes only a few cycles, so by the time the CPU reads
`SDSR` the `BUSY` bit is long clear — this probe therefore cannot prove "the command executed". What
really proves execution is the **data**: a full 32 MB write-then-read-back comparison plus the 8-bit
byte-lane probe.

Reads being 5× slower than writes is not a defect: this window still has the ARMv7-M default
**Device** attribute at that point (no caching, no merging, no unaligned access), so every read is a
separate AXI transaction; after §13.6 switches it to Normal the reads are still one at a time (D-Cache
is off), they are merely allowed to merge.

### 13.6 Memory layout: `.ark_buf` moves into SDRAM

`Linker/STM32H743VITx_FLASH.sct`:

```
RW_AXI   0x24000000 0x00070000   { *(.ark_code)  *(.ark_heap) }   // 64 KB
ARK_TRAMP 0x2407F000 0x00000100  { *(.ark_tramp) }               // fixed address
RW_SDRAM 0xC0000000 0x02000000   { *(.ark_buf) }                 // 404 KB
RW_SRAM  0x30000000 0x00048000   { .ANY (+RW +ZI) }
```

Three accompanying changes, all of them necessary:

1. **Initialise SDRAM inside `SystemInit()`** (`bsp_sdram_init()` + `bsp_sdram_selftest()` +
   `bsp_sdram_mpu_config()`). `__main` has to copy/zero `.ark_buf` per the scatter file before
   `main()`, so this can only happen in `SystemInit()`. If the self-test fails the firmware stops
   right there (`for(;;)`) instead of letting the scatter loader eat an imprecise bus fault.
2. **MPU region**: 32 MB starting at `0xC0000000` set to Normal, non-cacheable, full access
   (`RASR = 0x03080031`, region 0, `MPU_CTRL = 0x5`). ARMv7-M treats this block as Device by default,
   and **Device memory does not allow unaligned accesses** — the compiler does mixed byte/halfword/word
   accesses on its own buffers, and one unaligned access is a UsageFault. This is not a performance
   optimisation, it is correctness.
3. **`RW_AXI` limit narrowed from 0x80000 to 0x70000**: `0x24070000` is the window where on-board build
   output is loaded, and the old limit let static data grow up to `0x24080000`, right on top of it.

**Switches** (both must be flipped together):

| Location | Value | Meaning |
| --- | --- | --- |
| `system_stm32h7xx.c` | `#define ARK_SDRAM_BUFS 1` | 1 = initialise SDRAM at startup and enable the MPU; 0 = not one statement runs |
| `ArkCC.uvprojx` `<ScatterFile>` | `STM32H743VITx_FLASH.sct` | switch to `..._sram.sct` to go back to the old layout with all buffers in AXI SRAM |

`ARK_SDRAM_BUFS 1` with the old `_sram.sct` still boots (SDRAM is initialised and then idle, behaviour
unchanged); conversely 0 with the new sct faults during scatter loading — so the two must move
together.

**Anti-false-green**: the layout is not taken on "I trust the linker"; the boot banner reads it out:

```
=== Ark C Compiler on STM32H743 ===
Heap @ 24008000, Code @ 24000000
Bufs @ c0012000 (compiler work buffers in SDRAM)
Type 'help' for commands.
```

`Bufs @` prints `arkcc_buf_addr()` (the address of `g_src` in `src/compiler.c`) and decides which region
it falls in against `0xC0000000..0xC2000000`; switching back to `_sram.sct` makes it print
`in on-chip RAM` by itself.

After the move `demo` + `build` still work (compile, link, load, execute, return 0 on the board),
which shows that "the compiler's whole working set lives on the external SDRAM" is usable rather than
a paper conclusion.

### 13.7 What was still open at that point (closed in §14)

The **string literal** argument of the second `write()` in `hello.c` was still a bad address (§12.3):
at compile time the `.rodata` address is baked in as `g_flash_base + offset`, i.e. something like
`0x08000400`, while the image really sits at `0x24070000`. Moving the memory layout does not touch it
— it is a **code address** with no relocation entry, not a data address. The two candidate fixes are
in §12.3; **option 2 is done** (the backend emits a reloc for section-internal absolute addresses and
the linker corrects them from the actual base), behind the switch `--reloc-text`; the mechanism and
the gate are in §14.

---

## 14 Stage 5: section-internal absolute addresses handed to the linker (`--reloc-text`)

### 14.1 Restating the problem

To "take the address of a label" the backend emits `MOVW rd,#lo16` + `MOVT rd,#hi16` with the value
`g_flash_base + offset`, where `g_flash_base` is the base assumed at **compile time** (default
`0x08000000`, or the LR base given by `--scatter`). That value is not a relocation entry, so the linker
cannot see it:

* single object whose base happens to equal the LR base → the number is right;
* multiple objects (the second starts after the first) → the whole second object is off by one object's
  size;
* the image loaded somewhere else (on the board: `0x24070000`) → everything is off, string literals
  most visibly.

### 14.2 Mechanism: the object carries its base, the linker computes the difference

| Step | What it does |
| --- | --- |
| Backend | when `LDR rd, =label` resolves to a label **inside this object**, it emits the MOVW/MOVT and also records a `type 12` relocation (`.arktext`) whose offset is the position of the MOVW instruction |
| Object | appends a `__arkcc_text_base` symbol at the end, with the compile-time base as its value (same pattern as `__arkcc_ram_start/end` — it still uses "the symbol's offset field as an absolute address") |
| Linker | while loading it records each object's start `g_ld_code_base[i]` in the merged buffer plus a descriptor; once scatter loading has resolved the image base, for each object it computes `delta = (image_base + code_base) - text_base` and adds it into that MOVW/MOVT pair with `arm_patch_movw_movt()` |

> The `.arktext` in the name is just a placeholder in the relocation entry's name field (the same
> trick as `.arkdata`); it is **not** a pseudo-op written into the `.s`: the site is decided when the
> assembler resolves `LDR rd, =label`, so it does not appear in `-S` output and a reassembly decides
> again according to the switch in force at that time. That way the single path "codegen emits text →
> assembler resolves it" has exactly one decision point.

`delta` **must be computed per object**: computing one global difference and applying it to every
object is right for object 0 and wrong for object 1 — which is precisely the shape check 3 in §14.3
watches for.

The decision is taken in the linker rather than aligned at compile time because only the linker knows
where the objects finally land; letting compile time guess (candidate 1) turns "both rules must agree"
into an implicit convention nobody checks.

### 14.3 Gate (one of the `make test` cases)

`tests/run_reloc_text_tests.py`, two objects, image base `0x1C070000` away from the compile base:

```
PASS  object carries __arkcc_text_base with --reloc-text
PASS  object carries no descriptor without --reloc-text
PASS  object #0 literal address corrected  [24070400]
PASS  object #1 literal address corrected  [24070BD4]
PASS  without the flag the old base is still baked in  [08000400]
PASS  image size unchanged by the pass  [4940 vs 4940]
PASS  object #1 really is linked after object #0  [+0xBD4 vs +0x400]
```

Each of the checks guards against one way of passing falsely:

1. no descriptor → the linker has nothing to correct with, so it must be visible;
2. with the switch off there must be **no** descriptor → the default output stays byte-identical;
3. objects 0 and 1 **both** have to be correct → a global delta can only pass the first;
4. turning the switch off must reproduce the **old error** (`0x08000400`) → proving the test measures
   the feature rather than a coincidence;
5. the image size is unchanged → this step only rewrites immediates, it does not move the layout;
6. object 1 really is placed after object 0 → otherwise check 3 is checking the same thing twice.

### 14.4 Off by default = byte-identical (measured)

A `git worktree` build of the previous commit was used as the reference `arkcc`, with the same sources
and the same options (switch off):

```
IDENTICAL  hello.o  (4162 bytes)
IDENTICAL  crt.o    (2874 bytes)
IDENTICAL  app.bin  (4814 bytes)
```

The image size is the same with the switch on and off (`4940` vs `4940`); only the two immediates at
`+0x474` / `+0xC9C` differ:

| | object 0 literal | object 1 literal |
| --- | --- | --- |
| off | `0x08000400` (wrong) | `0x08000000` (wrong) |
| on | `0x24070400` ✓ | `0x24070BD4` ✓ |

### 14.5 Measured on the board

`cmd_build()` explicitly sets `g_config.enable_reloc_text = 1` (on the board this link is necessarily
"multiple objects + displacement", and enabling it here does not affect older uses such as `cc -S` or
single objects):

```
[arkcc] wrote object 'hello.o' (3028 bytes code, 43 syms, 3 relocs)   <- 2 -> 3, the extra one is type 12
[arkcc] wrote object 'crt.o'   (2810 bytes code, 43 syms, 2 relocs)
[link] vector table written into the 1024-byte hole the first object reserved (SP=0x2407F000, entry=0x2407102A)
[arkcc] linked 2 objects -> app.bin (5838 bytes, 45 syms, 5 relocs)   <- 4 -> 5
[arkcc] image loaded at 24070000, 5838 bytes
--- program output -------------------------------------------
hello, world
written by arkcc running on the STM32H743 itself
--------------------------------------------------------------
[arkcc] program returned 0
```

The image size is the same as before the fix (5838); only the immediates inside the instructions
changed.

### 14.6 A real defect fixed along the way (`opts_reset`)

On the board, `opts_reset()` was missing four fields: `vector_table`, `build_date`, `build_time` and
`build_epoch`. `vector_table` decides whether the linker writes the vector table into the 0x400 hole
the first object reserves: it had **never been assigned**, and the board kept working because that
stack slot happened to be non-zero — adding one local variable could have turned it into 0, after
which the linker switches to the "the image must carry its own vector table" branch, changing
behaviour with no code change at all. It is now `vector_table = 1` (an on-board link always wants that
table written), and the other three are explicitly set to 0.

This is the second appearance of the same class of problem: in this round the `--reloc-text` "object
descriptor" was at first also recorded before `p_text_base` was assigned, so the object ended up with
no descriptor and the linker refused to link (refusing was correct, but the error came far too late).
That combination — "order dependency + no diagnostic" — can only be held down by gates.

## 15 Stage 3c: the output is flashed into internal Flash and executed (`app flash`)

### 15.1 Why this step

Both direct-run paths of stage 3 stop at "the output lives in RAM":

| Path | Where the image comes from | After power loss |
| --- | --- | --- |
| `app run <path>` (fixed window) | taken from the VFS, loaded into the 8 KB window at `0x24070000` | gone (ramfs is volatile) |
| `mini run` (four-pass differential packing) | taken from the VFS, loaded into any free block of the RAM pool | gone |

The compiler can already build images on the board, but they live exactly as long as that RAM does.
Stage 3c supplies the last segment: **the image lands in internal Flash, is still there after a
reset, and can be executed directly**.

### 15.2 Shape: a kernel launcher starts a task, which fetches instructions from Flash

The bootloader shape (bare jump to VTOR + a once-and-for-all takeover with `NVIC_SystemReset`) is
deliberately **not** reused. What is used instead is the apprun path that has already been verified on
real hardware:

```
app flash write <path>
        │  scan + shape check (verify before erase)
        ▼
   Flash application area 0x081E0000 .. 0x08200000   ← tail of bank2, 128 KB
        │  a fixed 32 B metadata record at the area tail (magic / len / crc / version)
        ▼
app flash run
        │  read metadata + re-check entry/prologue → mini_alloc borrows a RAM window → task_register
        ▼
   unprivileged task, PC at 0x081E0***, MPU code window = the Flash application area,
   data window = 0x24072000
```

The benefit is that power-loss retention holds naturally, while **no** second copy of
scheduling/exception handling/exit paths is introduced: the task leaves through the same `SVC 0x1B`
exit, and the data window goes back to the pool as usual.

> Honest boundary: this is not a bootloader that "takes over the machine". The kernel is still there,
> the shell is still there, and the program in Flash is a **task**, not an independent firmware.

### 15.3 Partition and MPU windows

`config/stm32h743/arkrtos_partition.h`:

```c
KERNEL      0x08000000 + 512K    (bank1)
CONFIG      0x08080000 + 128K
IMAGE_POOL  0x080A0000 + 1280K   (= CHIP_FLASH_SIZE - BOOT - KERNEL - CONFIG - FLASHAPP)
FLASHAPP    0x081E0000 + 128K    (= IMAGE_POOL_END, tail of bank2)
             end 0x08200000
```

Three hard constraints, all checked at compile time in the header
(`arkrtos_flashapp_layout_check`):

1. **The FlashApp area must be subtracted from `IMAGE_POOL_SIZE`**, it must not be "reserved inside
   the pool". The sector at the top of the pool is the compaction margin, so dynamic use would
   inevitably collide.
2. **It must fall in bank2**. The H743 has two banks; while bank2 is being erased/written the kernel
   keeps fetching from bank1 (read-while-write), and the kernel must not stop during a flash write.
3. **`ARKRTOS_MPU_IMAGE_POOL_SIZE` must cover both the pool and FlashApp**
   (change it to `(CHIP_FLASH_BASE + CHIP_FLASH_SIZE) - IMAGE_POOL_BASE`). It previously covered only
   the pool: the FlashApp task's `rom_start` fell outside the window, and `arkrtos_mpu_rom_window()`
   **silently falls back to the kernel Flash window**, faulting on the first instruction fetch.

### 15.4 Metadata at the area tail, not at the image head

`flashapp_meta_t` is fixed at `FLASHAPP_END - 32`:

```c
magic  'FLAP' (0x50414C46)   len   crc32   version=1   rsv[4]
```

It lives at the area tail rather than at the payload head because Cortex-M requires **the vector table
at image +0**: SP must be the first 4 bytes of the image and Reset the 5th..8th. Any header would push
SP back, and the shape check is exactly what uses SP to decide "was this image linked against this
address chain".

The CRC uses a bitwise algorithm (IEEE reflected `0xEDB88320`) rather than a 1 KB table: the kernel
has only eleven-odd KB of RAM left.

### 15.5 Write path: verify before erase + read-back verification

The order inside `arkrtos_flashapp_write()` is **deliberate**:

```
argument/VFS check → busy check → flashapp_scan() (single streaming pass computing len + CRC, reject immediately past MAX_IMAGE)
             → flashapp_check_shape()
                  SP == top of the RAM window
                  entry inside [BASE, BASE+len)
                  first two bytes at the entry == 0xB5E0 (the arkc prologue PUSH {r5-r7,lr})
             → sched_lock → erase the whole area → read and write in blocks
             → read back and compare byte by byte → write metadata → read metadata back → unlock
```

Two decisions that are less than obvious:

* **The shape check runs before the erase.** An obviously wrong file must not wipe the image in the
  area that still runs. Once erasing has started, a failure means "the area is now empty", and the
  shell says exactly that instead of fabricating compensation.
* **Read back and compare byte by byte.** `arkrtos_port_flash_write()` is read-modify-write over
  32 B flash words, and the same 32 B block can only be written once; having written is not the same
  as having written correctly, and only a read-back can prove it.

### 15.6 Usage and error codes

```
app flash write <path>     flash the image into the Flash application area (prints its own verified reading)
app flash run              start a task from the Flash application area
app flash info             metadata + entry (read only, CRC not checked)
app flash erase            erase the whole area
```

| Code | Name | Meaning |
| --- | --- | --- |
| -40 | BUSY | a FlashApp task is already running |
| -41 | WINDOW | shape check: SP is not the top of the RAM window / the entry is outside the image |
| -42 | LAYOUT | image length out of range / coordinates do not match |
| -43 | PROLOGUE | the first two bytes at the entry are not `0xB5E0` |
| -44 | META | there is no image in the area (wrong magic) |
| -45 | VERIFY | the read-back comparison failed |
| -46 | FLASH | the erase/write layer reported an error |

When `info` prints the entry it clears the Thumb bit (`ent & ~1u`), otherwise it would differ from the
`run` log by one.

### 15.7 Measured readings on the board

```
cc /tmp/m5.c --scatter /tmp/m5.sct --vector-table -o /tmp/m5.bin
    cc: done in 58 ms                       -> 1452 B

app flash write /tmp/m5.bin
    FLASHAPP:410 /tmp/m5.bin: 1452 B, crc 0x612B4A1E -> 0x081E0000..0x081E05AC (verified)

app flash info
    flash app: 1452 B, crc 0x612B4A1E, entry 0x081E0424, area 0x081E0000 +128K

app flash run
    FLASHAPP:412 1452 B from flash 0x081E0000, entry 0x081E0424,
                 data 0x24072000 (8192 B), task 4
    M5 alive in flash
    M5 tag bravo
    FLASHAPP:413 task 4 exited, data window returned to the pool
```

After a reset (ramfs cleared, so `ls /tmp` no longer lists `m5.bin`) `info` / `run` still succeed —
this is the only thing that distinguishes "burnt into Flash" from "read into RAM".

Firmware size (with `USE_FLASHAPP=1` fully on): `FLASH 497700 B / 512 KB / 94.93%`,
`RAM 309360 B / 68.66%`.

### 15.8 Regression and anti-false-green

Two board-level cases (`tools/final_app.py`):

* **`m5-flashapp`**: on an empty area `info` reports `-44` → `cc` → `write`(verified) → `info` →
  `run` (**the log entry point must be at `0x081E0***` and the program must print a string unique to
  its source; neither alone is enough**) → Reset → `ls /tmp` shows no `m5.bin` → `info`/`run` still
  succeed → `erase` → `run` reports `-44` → `app flash bogus` prints usage → no exception.
  The string alone is not enough: copying the image into RAM and running it would print it too, so
  the entry point must be checked as well.
* **`m5-wrong-window`**: first `write` a good image successfully, then `write` a bad image whose RAM
  window is shifted by 4 KB; it must report `-42` **and the image in the area must still `info` /
  `run`** — that is the criterion for "verify before erase", rather than just looking at the error
  code.

When off by default (`ARKRTOS_USE_FLASHAPP=0`) none of the code is compiled in and the command table
has no `flash` subcommand. One thing deliberately does **not** follow the switch: **those 128 KB stay
reserved in the partition layout** (measured `492956 B`, 16 B more than without the reservation, and
the pool loses one sector). The partition is a static board-level decision; the `.sct` / `.ld`
generators and C must see the same number — making it follow the switch would mean one header telling
different tools different things. If the land is not needed, pass
`-DARKRTOS_FLASHAPP_SIZE=0` on the compile command line (the header uses `#ifndef`, so they do not
fight), but then the generator must be pointed at the same configuration as well.
`USE_FLASHAPP=1` requires `USE_APPRUN=1` and `USE_VFS=1`; `arkrtos_features.h` has an `#error` that
enforces this hard, and `config/kconfig/Kconfig.features` has the same `depends on`.

Regression summary: `all 16 cases PASS`; structural gate `12 check(s) passed, 0 failed`.
