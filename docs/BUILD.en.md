# Building arkcc on Windows, Linux and the STM32H743

English | [中文](BUILD.md)

> One sentence: the compiler core is C99 plus `stdio/string/stdlib` only, so the
> same sources build in all three places. What actually differs is the **memory
> budget** -- a 256 MB arena on a host, versus either 32 MB of SDRAM or a
> 508 KB AXI block on the H743. Both of those paths are measured by a gate here,
> not promised in a comment.

---

## 1. Three targets, four build paths

| Target | Command | Toolchain | Output |
|--------|---------|-----------|--------|
| Windows host | `make` | MinGW gcc | `arkcc.exe` |
| Linux host | `make CC=gcc` | system gcc | `arkcc` |
| H743 stand-alone image (no SDRAM) | `make stm32-check` | armclang + armlink | size/RAM accounting |
| H743 board firmware | Keil `mdk/STM32H743_ArkCC/ArkCC.uvprojx` | ARM Compiler 6 | `.hex` |

The first two are **the compiler itself** (front end plus every backend); the
last two are the **trimmed profile** (`ARKCC_PROFILE_STM32_MIN`: ARM backend
only, no x86_64 / riscv32 / C backend, no 1.5 MB liveness tables, `-fopt-live`
compiled out).

---

## 2. Windows host

```sh
export PATH="/d/mingw/MinGW/bin:$PATH"
make -j4
./arkcc.exe examples/hello.c -target arm -S -o hello.s
```

With `OS=Windows_NT` the `Makefile` switches the output name to `arkcc.exe` and
`RM` to `del /Q`; everything else is identical to POSIX. Gates:

```sh
make test          # forty-odd groups, test-live is the last one
```

The Python steps use `$(PYTHON)`, default `python`. If your shell exports a
`PYTHONPATH`/`PYTHONHOME` that breaks the interpreter, pass
`make PYTHON="C:/.../python.exe -X utf8"`.

---

## 3. Linux host

```sh
make CC=gcc -j4
./arkcc examples/hello.c -target arm -S -o hello.s
```

No source change is needed. Three reasons, strongest first:

1. `src/`, `include/` and `port/host/` contain **no** `windows.h` / `_WIN32` /
   `unistd.h` / `dirent.h` / `sys/stat.h`, and no `mkdir`, `fork` or `dlopen`.
   Reading files, printing and exiting all go through `stdio`
   (`port/host/*.c` is 154 lines in total).
2. The non-Windows branch of the `Makefile` already switches the output name,
   `RM` and the null device; `install` goes through `tools/install.py`, which is
   pure Python and verifies every copied file byte for byte.
3. The same sources compile under MinGW gcc *and* armclang -- two unrelated sets
   of headers and ABIs -- which means they use the C99 intersection rather than
   one libc's extensions.

**The verification status has to be stated honestly: there is no usable Linux
environment on this machine** (WSL has no distro installed, and there is no
arm-none-eabi-gcc, clang or docker). So reasons 1 and 3 are a static review plus
real compilations, not "it ran on Linux once". To confirm on Linux, run
`make && make test`; nothing in the test suite branches on platform.

---

## 4. H743: two memory layouts

Board: STM32H743 (2 MB flash / 128 KB DTCM / 512 KB AXI / 32 MB SDRAM). The
compiler is self-hosted, so what has to fit is **a C compiler**: a bump arena,
a source buffer, an assembler-text buffer, a machine-code buffer, RAM file
slots and the link symbol tables. All of them live in `.ark_buf`, and the
scatter file decides where that goes.

`make stm32-check` compiles the same source set and then links it once through a
scatter file that encodes the real board memory, so armlink itself answers
"does it fit":

```sh
make stm32-check
# toolchain: D:/Keil_v5/ARM/ARMCLANG/bin/armclang.exe
# --- layout: sram ---
# PASS  every STM32 profile source compiles  [34 file(s), 0 failed]
# PASS  .ark_buf fits its sram region  [475192 / 520192 bytes (91%)]
# PASS  code + rodata fits the 2 MB flash  [375904 / 2097152 bytes (17.9%)]
# PASS  ordinary .data/.bss fits SRAM1-3 (288 KB)  [30908 / 294912 bytes (10%)]
# --- layout: sdram ---
# PASS  .ark_buf fits its sdram region  [1298768 / 33554432 bytes (4%)]
# ...
# all checks passed (2 layout(s))
```

| Layout | Where `.ark_buf` goes | Measured | Note |
|--------|----------------------|----------|------|
| `sdram` (deployed) | `0xC0000000` UNINIT, 32 MB | 1,298,768 B (4%) | profile defaults, no trimming; SDRAM is brought up by `SystemInit()` |
| `sram` (no-SDRAM fallback) | from `0x24000000`, 508 KB | 475,192 B (91%) | has to be trimmed, see §5 |

Code plus read-only data is **375,904 B / 17.9%** and barely differs between the
two layouts, because what gets trimmed is the **zero-initialised working set**,
not code. In the SDRAM layout `.ark_buf` is `UNINIT`, so 1.3 MB of working set
**never enters the flash image**; that is asserted by the gate too
(`the arena is not loaded as initialised data`).

### 4.1 Board firmware (Keil)

```
mdk/STM32H743_ArkCC/ArkCC.uvprojx
```

- `Linker/STM32H743VITx_FLASH.sct`: `.ark_buf` in the 32 MB SDRAM (default)
- `Linker/STM32H743VITx_FLASH_sram.sct`: `.ark_buf` in AXI (fallback)
- The two switches have to move **together**: the scatter file and
  `ARK_SDRAM_BUFS` in `system_stm32h7xx.c`

---

## 5. The trimming ladder

`include/arkcc_config.h` defines one profile and every size can be overridden
with `-D`. The three columns below are three real configurations: host default,
STM32 profile default, and the no-SDRAM fallback (the one the gate uses).

| Macro | Host | STM32 default | No-SDRAM fallback | What it is |
|-------|------|---------------|-------------------|------------|
| `ARK_POOL_SIZE` | 256 MB | 64 KB | 64 KB | bump arena (`-link` carves two link buffers from it) |
| `ARK_SRC_BUF_SIZE` | 1 MB | 32 KB | 32 KB | source text (AEABI runtime is 17.8 KB; 16 KB measured short) |
| `ARK_ASM_BUF_SIZE` | 8 MB | 256 KB | 96 KB | assembler text (AEABI `-O0` measured 92,259 B) |
| `ARK_CODE_BUF_SIZE` | 4 MB | 32 KB | 32 KB | machine code |
| `ARK_OBJ_BUF_SIZE` | 8 MB+16 | 16 KB | 16 KB | one object image |
| `ARK_LINK_BUF_SIZE` | 64 MB | 16 KB | 16 KB | largest input object / linked image (`arena >= 2x`) |
| `RAMFS_SLOTS` x `RAMFS_SLOT_SIZE` | -- | 12 x 32 KB | 2 x 16 KB | on-board RAM file slots |
| `ARK_LINK_MAX_SYMS` / `_RELOCS` | 16384 | 512 | 128 / 128 | link symbol/relocation tables (136/140 B per entry) |
| `PP_BUF_SIZE` | 4 MB | 64 KB | 24 KB | preprocessed output |
| `PP_INC_BUF` x `PP_MAX_INC_DEPTH` | 1 MB x 32 | 16 KB x 8 | 8 KB x 4 | per-include buffer |

Two walls that must not be lowered:

- **`ARK_ASM_BUF_SIZE` >= 96 KB**: the board compiles `stdlib/src/arm/aeabi.c`
  itself, and its `-O0` assembly is 92,259 B. When the buffer was short the old
  code **silently truncated** (the assembler then said "unknown mnemonic P");
  `*_emit` now refuses instead.
- **`ARK_SRC_BUF_SIZE` >= 32 KB**: the same `aeabi.c` is 17,847 B, and the 16 KB
  setting answered "input file is 17847 bytes, larger than the 16384-byte source
  buffer".

`RAMFS_SLOTS` / `RAMFS_SLOT_SIZE` only became overridable in this round (they
used to be hard-coded in `port/stm32/flash_fs_stm32.c`), which is what makes the
AXI tier trimmable at all.

---

## 6. What the gate is defending against

`tools/stm32_build_check.py` checks two things, both of the form "it compiles is
not it runs":

1. **Every TU compiles** (34 files). Dialect differences between armcc and
   armclang surface here -- this round caught one: `port/stm32/platform_stm32.c`
   used the `__value_in_regs` keyword, which neither armclang nor gcc knows; it
   now expands per compiler in three branches.
2. **The link goes into real memory**: the region sizes are written into the
   scatter file, and armlink itself fails with
   `L6220E ... exceeds limit` when they overflow. That is the machine verdict
   for "it does not fit the board", not a comment.

Two more assertions that are easy to miss:

- `the arena is not loaded as initialised data`: the zero bytes of `.ark_buf`
  must not enter the flash image (the SDRAM layout does this with `UNINIT`).
- `ordinary .data/.bss fits SRAM1-3`: real RW/ZI is only 30,908 B, but it lives
  in the **other** 288 KB SRAM1-3 block, so AXI headroom cannot pay for it.

When the toolchain is absent the gate prints `SKIP` and returns 0 -- "no cross
toolchain" is not "passed", so it says so instead of passing quietly. To point it
at a toolchain:

```sh
python tools/stm32_build_check.py --layout both \
    --armclang /path/to/armclang --armlink /path/to/armlink --fromelf /path/to/fromelf
```

---

## 7. Not done

- `make stm32` (the arm-none-eabi-gcc path) is still there, but **no gcc cross
  toolchain is installed here**, so it was not verified this round; the verified
  path is armclang. Both build the same source set and differ only in the linker
  script (`.sct` vs `.ld`).
- The no-SDRAM tier only proves it **fits**; it does not prove it can compile
  `aeabi.c` on the board. Whether a 64 KB arena is enough needs one `runtime`
  round on the hardware. That stays on the debt list in
  `docs/BOARD_VALIDATION.md`.
- The AXI tier does not split `.ark_buf` across the spare SRAM1-3 space (10%
  used). Doing that properly means splitting by access frequency, not squeezing
  AXI harder.
