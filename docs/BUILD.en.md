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
# PASS  code + rodata fits the 2 MB flash  [378796 / 2097152 bytes (18.1%)]
# PASS  ordinary .data/.bss fits SRAM1-3 (288 KB)  [30944 / 294912 bytes (10%)]
# --- layout: sdram ---
# PASS  .ark_buf fits its sdram region  [29434192 / 33554432 bytes (88%)]
# ...
# all checks passed (2 layout(s))
```

| Layout | Where `.ark_buf` goes | Measured | Note |
|--------|----------------------|----------|------|
| `sdram` (deployed) | `0xC0000000` UNINIT, 32 MB | 29,434,192 B (88%) | 15 measured overrides (sec. 5.1); the profile defaults are far too small; SDRAM is brought up by `SystemInit()` |
| `sram` (no-SDRAM fallback) | from `0x24000000`, 508 KB | 475,192 B (91%) | has to be trimmed, see §5 |

Code plus read-only data is **378,768 (sdram) -- 378,796 B (sram) / 18.1%** and barely differs
between the two layouts, because what gets trimmed is the **zero-initialised working set**,
not code. In the SDRAM layout `.ark_buf` is `UNINIT`, so 29.4 MB of working set
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

Three walls that must not be lowered:

- **`ARK_ASM_BUF_SIZE` >= 96 KB**: the board compiles `stdlib/src/arm/aeabi.c`
  itself, and its `-O0` assembly is 92,259 B. When the buffer was short the old
  code **silently truncated** (the assembler then said "unknown mnemonic P");
  `*_emit` now refuses instead.
- **`ARK_SRC_BUF_SIZE` >= 32 KB**: the same `aeabi.c` is 17,847 B, and the 16 KB
  setting answered "input file is 17847 bytes, larger than the 16384-byte source
  buffer".
- **`PP_BUF_SIZE` must hold the whole preprocessed TU**: overflow used to drop
  bytes **silently** (a real incident: `stm32f4xx_hal_gpio.c` produced 537 B of
  assembly and exit code 0); it now fails with
  "preprocessed output does not fit the N-byte PP_BUF_SIZE; ... refused".

`RAMFS_SLOTS` / `RAMFS_SLOT_SIZE` only became overridable in this round (they
used to be hard-coded in `port/stm32/flash_fs_stm32.c`), which is what makes the
AXI tier trimmable at all.

### 5.1 The SDRAM deployment profile (measured)

The SDRAM tier is not "the defaults are enough"; the sizes have to be **given
explicitly** -- the STM32 defaults are budgeted for a 64 KB arena and cannot
compile a single HAL unit. The 15 values in `LAYOUTS["sdram"]` of
`tools/stm32_build_check.py` are all measured, not rounded up:

| Macro | Deployment | Basis (measured) |
|-------|-----------|------------------|
| `ARK_POOL_SIZE` | 8 MB | arena peak over 95 HAL/Core TUs is 7,664 -- 4,292,040 B; the dearest is `stm32f4xx_ll_utils.c` at 4.29 MB |
| `ARK_SRC_BUF_SIZE` | 512 KB | largest source is `stm32f4xx_hal_fmpi2c.c`, 267,050 B |
| `ARK_ASM_BUF_SIZE` | 1 MB | assembler text for one TU |
| `ARK_CODE_BUF_SIZE` | 256 KB | machine code |
| `ARK_OBJ_BUF_SIZE` | 64 KB | one object image |
| `ARK_LINK_BUF_SIZE` | 64 KB | link input (arena >= 2x) |
| `PP_BUF_SIZE` | 4 MB | `stm32f4xx_hal_gpio.c` preprocesses to well over 256 KB (44,888 B of assembly) |
| `PP_INC_BUF` | 768 KB | `stm32f4xx.h` preprocesses to 644,303 B |
| `PP_MAX_INC_DEPTH` | 16 | the CMSIS header chain nests deeper than 8 |
| `ARK_LINK_MAX_SYMS` / `_RELOCS` | 4096 / 4096 | link symbol/relocation tables |
| `ARM_MAX_SYMBOLS` / `_RELOCS` / `_GVARS` | 4096 / 4096 / 2048 | ARM backend tables |
| `ARKCC_FEATURE_OPT_INLINE` | 1 | **keep the inliner**: with it compiled out, 8 of the 95 TUs differ from the host `-O2` build |

`.ark_buf` totals **29,434,192 / 33,554,432 B (88%)**, code + read-only is
378,768 B (18.1%), and ordinary RW/ZI is 86,244 B (29%, on the separate 288 KB
SRAM1-3 block).

The arena is 8 MB rather than 4.5 MB because the 4.29 MB peak still has to leave
headroom for "several TUs at once" uses such as `--ipo`; the SDRAM has 32 MB, so
shrinking the arena to 4.5 MB would only take `.ark_buf` from 88% to 76%, which
buys nothing against the risk of one more refit.

**Byte-for-byte agreement**: a host executable built with exactly these settings
(`-DARKCC_PROFILE_STM32_MIN` plus the table above) was compared against the full
host `-O2` build over **95 HAL/Core TUs**; after dropping the
`.file/.loc/.type/.size/.cfi_*` lines, **95/95 are identical**, with a maximum
arena peak of 4,292,040 B. The board therefore emits the same assembly as the
workstation, which is what makes a board bug reproducible locally.

### 5.2 What was cropped must be **refused**, not silently degraded (26/26 measured)

The danger of trimming is not "it will not build" -- it is "it builds but behaves
differently". So every optimisation the profile crops has to be **refused by name**
(diagnostic `C3900U`), not accepted and quietly ignored.

Method: build a real binary from the same sources with the **host gcc** plus
`-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` (and `-DARKCC_BACKEND_X86_64=0`
`-DARKCC_BACKEND_RISCV32=0` `-DARKCC_BACKEND_C=0`), then try each flag:

| Check | Result |
| --- | --- |
| full host build, default profile (`make`) | 0 error |
| STM32_MIN profile host build | 0 error, runnable binary |
| the 26 `-fopt-*` (addr/bitmask/boolmat/branch/cbranch/cbz/cmat/coalesce/constcache/constcond/copyprop/deadpush/exit/frame/imm/litpool/live/pair/peep/prop/slotreg/strength/volbar/voldmb/vreg/vstack) | **26/26 refused with `C3900U` and the flag named** |
| conversely: `constfold` / `dce` / `inline` / `regalloc` / `vectorize` are **kept** in the profile (not in the crop table) | `rc=0` with the flag |
| the same source with no `-fopt-*` at all | exit 0, valid Thumb-2 assembly |
| `make stm32-check` (armclang + real scatter, both layouts) | see section 4, all PASS |

The last two rows only mean something together: **a refused flag is not a broken
compiler** -- without the flags it still compiles `stm32f4xx`-shaped code into correct
assembly. The profile build also proves something relevant to this round's defect: with
`-fopt-live` cropped out the backend still emits high-register forms (`adds.w`/`subs.w`),
through exactly the same encoder as the host, so the assembler's two-pass size self-check
(section 16.3 of `docs/VREG.md`) guards one and the same thing on all three platforms. Check 6 of `tests/run_vreg_tests.py` freezes the `-fopt-vreg` case as a regular
gate (a `-DARKCC_FEATURE_OPT_VREG=0` build must refuse the flag and still compile without it).

#### 5.2.1 A misspelling must be refused too (0.9.1-wip)

The section above is about passes that exist but were cropped. The inverse case was
simply wrong: **a name that does not exist at all** was accepted, dropped, and the file
compiled anyway (`./arkcc -fopt-bogus hello.c` returned 0 and produced output
byte-identical to the build without the flag). `-fopt-*` is this compiler's own family --
gcc has no such spelling -- so a name inside that family which matches no pass is a
**misspelling**, not a foreign flag.

What the driver does now:

| Input | Result |
| --- | --- |
| `-fopt-bogus` / `-fno-opt-bogus` / a bare `-fopt-` | `C3900U`, the token echoed exactly as typed, exit 1, **no output file written** |
| `-fopt-vreg -fopt-bogus` (valid and invalid together) | the diagnostic names `-fopt-bogus`, not the valid flag next to it |
| `-fbogus` / `-fvreg` / `-fno-strict-aliasing` (gcc-style bare `-fxxx`) | still silently tolerated, assembly and image **byte-identical** |
| each of the 26 real `-fopt-*` names on its own | all `rc=0` (anti-false-positive: one typo in the table would become `C3900U`) |

Both halves have to hold together: **the refusal targets a misspelling in our own
family, it does not push gcc command lines back**. The unrecognised name is recorded in
`config_apply_args()` and refused in the `-f` fallback branch of `main.c`, so the name
table is not duplicated. The gate `tests/run_option_tests.py` (`make test-option`) pins
all four rows and carries its own anti-false-green: the same test run against the old
binary must go red (9 checks FAILED when measured this round; all green on the new one).
One documentation misspelling is corrected along the way: the constant-division pass is
spelled `--divconst`, and `IMM_FOLD` / `STRENGTH` used to call it `-fopt-divconst` --
which under this rule is now refused.

### 5.3 Verification status of the three platforms (honest)

| Platform | How it was checked | Status |
| --- | --- | --- |
| Windows host (MinGW gcc) | `make` + the forty-odd gate groups + the 95-TU diff | **verified** |
| STM32H743 (armclang + armlink + real scatter) | `make stm32-check`, sram and sdram layouts | **verified** (section 4) |
| Linux host | no usable Linux environment on this machine (WSL has no distro, no clang/docker/`arm-none-eabi-gcc`) | **not verified**; only the three static checks in section 3 |

The Linux cell is not written as "it should run": `port/host/*.c` is 154 lines and includes
only `stdio`-family headers, and the non-Windows branch of the `Makefile` only swaps the
artifact name / `RM` / the null device, so it is **expected** to match Windows -- but
"expected" is not "ran". On a Linux box, run `make && make test`.

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
- `ordinary .data/.bss fits SRAM1-3`: real RW/ZI is only 30,944 B without SDRAM (86,244 B with it), but it lives
  in the **other** 288 KB SRAM1-3 block, so AXI headroom cannot pay for it.

`tests/run_buffer_tests.py` now also watches `PP_BUF_SIZE` (a 4 KB setting must
**refuse** rather than truncate), which brings it to 10 cases together with the
existing arena/source/assembly/link buffer cases.

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
- How big a TU the no-SDRAM tier can compile now has a quantitative answer: it
  **cannot compile any HAL unit**. The first walls are `ARK_SRC_BUF_SIZE`
  (32 KB vs the 42,704 B of `stm32f4xx_ll_adc.c`) and `PP_INC_BUF` (8 KB vs the
  12,683 B header reached by `stm32f4xx_hal_gpio.c`); past those the arena wall
  follows (arena peak over the 95 TUs is 7,664--4,292,040 B, mostly far above
  64 KB). What it does compile is application TUs up to ~1 KB:
  `examples/hello.c` (162 B source) peaks at 10,816 B and
  `tests/stm32_board/tmp_pai.c` (422 B) at 63,344 B, i.e. right up against the
  64 KB. **An AEABI self-build has to use the SDRAM tier**: `stdlib/src/arm/aeabi.c`
  (17,351 B source) needs 495,728 (`-O0`) / 496,032 (`-O2`) B of arena.
- The AXI tier does not split `.ark_buf` across the spare SRAM1-3 space (10%
  used). Doing that properly means splitting by access frequency, not squeezing
  AXI harder.
