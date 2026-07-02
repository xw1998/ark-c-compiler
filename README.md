# Ark C Compiler

A multi-target C99 compiler that can be built and run on Windows / Linux / macOS with gcc,
and can also **natively self-host** on STM32 (Cortex-M7) to compile `.c` files from external SPI Flash and execute them in place.
It covers more than 98% of the commonly used ARM Compiler 5 (armcc) extensions (only C++ mode and advanced optimizations are missing).

## Features (v0.7.0)

### C99 Standard Language Features

| Aspect | Support | Notes |
| --- | :---: | --- |
| Basic types | Yes | `void/char/short/int/long/long long/_Bool/float/double` + `signed/unsigned` |
| Pointers and arrays | Yes | One-/multi-dimensional arrays, pointers, function pointers, array decay; array dimensions support constant expressions `int arr[SIZE+2]` |
| Variable-length arrays (VLA) | Yes | `int a[n]` runtime VLA, allocated via `IR_ALLOCA` on the stack (8-byte aligned) |
| Composite types | Yes | `struct`/`union`/`enum`/`typedef`, bitfields (true bit packing), flexible array members `data[]`, anonymous struct/union field promotion |
| Complex types | Yes | `_Complex double`/`_Complex float`, passed through to gcc (`sizeof(_Complex double)==16`) |
| Wide characters | Yes | `wchar_t` + `L"..."` wide strings + `L'...'` wide char literals; switch width via `--wchar16`/`--wchar32` |
| Trigraphs | Yes | All 9 C99 trigraphs (`??=`->`#`, `??(`->`[`, `??/`->`\`, `??)`->`]`, `??'`->`^`, `??<`->`{`, `??>`->`}`, `??!`->`|`, `??-`->`~`) |
| Qualifiers | Yes | `const/volatile/restrict/inline` |
| Storage classes | Yes | `static/extern/auto/register`; `static` persists inside functions; `__thread` TLS |
| Control flow | Yes | `if/else/while/for/do-while/switch/case/default/break/continue/goto/label/return` |
| Operators | Yes | All C99 operators (arithmetic/comparison/logical short-circuit/bitwise/shift/compound assignment/ternary/comma/sizeof/cast) |
| Functions | Yes | Multi-argument (>4 go on stack, strict AAPCS), prototype checks, varargs `...`, recursion, multi-file separate compilation + linking |
| Literals | Yes | Integers (decimal/octal/hex + suffixes), chars + escapes, string concatenation, floats |
| Floating point | Yes | `float/double` arithmetic/comparison/conversion; ARM backend supports hardware FPU (VFP `VADD/VMUL/VCVT/VCMP`) or `__aeabi_f*`/`__aeabi_d*` soft-float stubs, `double` is true 64-bit precision |
| 64-bit integers | Yes | `long long` operations via `__aeabi_l*` stubs; `printf` arguments are not truncated (64-bit long long passed correctly) |
| Division / modulo | Yes | Signed/unsigned `__aeabi_idiv/uidiv/idivmod/uidivmod` |
| Implicit type conversion | Yes | Full usual arithmetic conversions + integer promotion |
| Initialization | Yes | Scalars, aggregates `{1,2,3}`, nested `{{1,2},{3,4}}`, designated `.x=1/[2]=5`, strings `char s[]="hi"`, non-literal initializers for globals (constant-expression folding) |
| Compound literals | Yes | `(int[]){1,2,3}` / `(struct P){.x=1,.y=2}` |
| Passing structs by value | Yes | Implemented via a hidden pointer parameter |
| Preprocessing | Yes | Object/function macros (`#/##`), `#if/#elif/#else/#endif/#ifdef/#ifndef/#undef/#error/#warning/#pragma`, nested `#include` (<=8 levels), `__VA_ARGS__`, `-I` paths, trigraph replacement |
| Comments | Yes | `//` and `/* */` |

### ARM Compiler 5 (armcc) Compatibility Extensions

#### armcc keywords

| Extension | Support | Generated |
| --- | :---: | --- |
| `__svc(n)` | Yes | `SVC #n` |
| `__irq` | Yes | Interrupt prologue `PUSH {r0-r3,r12,lr}` / epilogue `POP {r0-r3,r12,pc}` |
| `__weak` | Yes | `.weak <name>` |
| `__naked` | Yes | No prologue/epilogue |
| `__packed` | Yes | Standalone keyword form + `__attribute__((packed))` + unaligned access via `__packed` pointer |
| `__align(n)` | Yes | Actually effective alignment control |
| `__at(addr)` | Yes | Absolute address (same as `__attribute__((at(addr)))` / `#pragma location=`) |
| `__forceinline` | Yes | Parsed (forced inline hint) |
| `__asm void fn() {...}` | Yes | Whole-function body assembly (armcc style) |
| `__value_in_regs` | Yes | Parsed (struct-returned-in-registers hint) |
| `__pure` | Yes | Parsed (no-side-effect pure-function hint) |
| `__interwork` | Yes | Parsed (ARM/Thumb interworking hint) |
| `__thread` | Yes | Thread-local storage (`.tbss`/`.tdata` sections) |
| `__global_reg` | Yes | Parsed (global register variable hint) |
| `__smc` | Yes | Parsed (SMC secure monitor call hint) |
| `__int64`/`__int32`/`__int16`/`__int8` | Yes | Fixed-width integer type aliases |
| `__typedef` | Yes | Parsed (typedef-compat prefix) |
| `__args`/`__return` | Yes | Parsed (argument/return register binding hints) |
| `__tp_soft` | Yes | Parsed (software thread pointer hint) |
| `__nothrow` | Yes | Parsed (function does not throw hint) |
| `__deprecated` | Yes | Parsed (deprecation marker) |
| `__may_alias` | Yes | Parsed (alias-safe type hint) |
| `__softfp` | Yes | Parsed (soft-float ABI hint) |

#### `__attribute__` attributes

| Attribute | Support |
| --- | :---: |
| `section` | Yes |
| `aligned`/`packed`/`noreturn` | Yes |
| `used`/`unused` | Yes |
| `alias("target")` | Yes |
| `constructor`/`destructor` | Yes |
| `deprecated`/`format(printf,...)` | Yes |
| `may_alias`/`nothrow` | Yes |
| `pure`/`const` | Yes |
| `visibility("default/hidden")` | Yes |
| `nonnull` | Yes |
| `warn_unused_result` | Yes |
| `sentinel` | Yes |
| `malloc` | Yes |
| `fastcall`/`stdcall`/`cdecl` | Yes |

#### `#pragma`

| pragma | Support |
| --- | :---: |
| `#pragma pack(n)` | Yes |
| `#pragma anon_unions` | Yes |
| `#pragma location=addr` | Yes |
| `#pragma diag_suppress` | Yes |
| `#pragma arm/thumb` | Yes |
| `#pragma import(__use_no_semihosting)` | Yes |
| `#pragma push/pop` | Yes |
| `#pragma O0/O2/O3`, `#pragma optimize` | Yes |

#### Inline assembly

| Form | Support |
| --- | :---: |
| `asm/__asm__` inline assembly | Yes basic form + extended form (operands/constraints/clobber); C backend fully transparent, ARM backend text passthrough |

### armcc-compatible predefined macros

| Macro | Value |
| --- | --- |
| `__ARMCC_VERSION` | armcc version number |
| `__arm__` / `__thumb__` | ARM/Thumb mode flag |
| `__arm` / `__thumb` | Underscore-less form (armcc compatible) |
| `__TARGET_ARCH_7_M` / `__TARGET_ARCH_7E_M` | Cortex-M architecture flag |
| `__TARGET_FPU_VFP` | VFP flag |
| `__BIG_ENDIAN` / `__LITTLE_ENDIAN__` | Byte order |
| `__sizeof_int` / `__sizeof_ptr` | Type sizes |
| `__STDC_VERSION__` | `199901L` |
| `__STDC_HOSTED__` | `1` (host) / `0` (embedded) |
| `__SIZE_TYPE__` / `__PTRDIFF_TYPE__` / `__WCHAR_TYPE__` | GCC-style type-size macros |
| `__EDG__` | EDG frontend compatibility flag |
| `__APCS_INTERWORK` | APCS interworking flag |

### Code generation

| Feature | Support |
| --- | :---: |
| 32-bit immediate MOVW/MOVT | Yes |
| Integer division SDIV / `__aeabi_idiv` | Yes |
| 64-bit arithmetic `__aeabi_lmul/ldiv` | Yes |
| Soft float `__aeabi_f*` (single precision) | Yes |
| Soft float `__aeabi_d*` (double precision, `double` is true 64-bit) | Yes |
| Hardware FPU instructions (VFP `VADD/VMUL/VCVT/VCMP`, replacing soft-float stubs) | Yes |
| VLA dynamic stack allocation `IR_ALLOCA` | Yes |
| `.data/.bss/.rodata` section separation | Yes |
| Bitfield bit packing/unpacking | Yes |
| Direct compilation of `.s` assembly files | Yes |
| Strict AAPCS (>4 args on stack) | Yes |
| `setjmp/longjmp` support | Yes |
| `.init_array`/`.fini_array` (constructor/destructor) | Yes |
| Unaligned access via `__packed` pointer | Yes |
| Full DWARF debug info (`.file/.loc/.cfi_startproc/.size` + `.debug_info`/`.debug_abbrev`/`.debug_line`) | Yes |
| TLS thread-local storage (`.tbss`/`.tdata`) | Yes |
| `--split_sections` one section per function (`.text.fn`) | Yes |
| scatter load description file (`include/scatter.h` + `src/scatter.c`) | Yes |
| CPU selection (`-mcpu`/`--cpu`, `include/cpu.h` + `src/cpu.c`) | Yes |

### Standard library subset

| Source file | Provides |
| --- | --- |
| `stdlib/src/printf.c` | Slim `printf` (`%d/%u/%x/%X/%s/%c/%p/%%` + width/0-padding, 64-bit long long not truncated) |
| `stdlib/src/string.c` | `memcpy/memset/memmove/memcmp/strlen/strcpy/strcmp` |
| `stdlib/src/math.c` | `sin/cos/sqrt/pow/fabs/floor/ceil/fmod` |
| `stdlib/src/setjmp.c` | `setjmp/longjmp` (portable simplified host implementation) |
| `stdlib/src/putchar_default.c` | `putchar` weak default implementation |

Header files in `stdlib/include/`: `stdint.h`/`stdbool.h`/`stddef.h`/`stdarg.h`/`string.h`/`stdio.h`/`stdlib.h`/`math.h` (includes `M_PI` and other constants)/`setjmp.h`.

### Backends

| Backend | Use |
| --- | --- |
| **ARM Thumb-2** | STM32 Cortex-M (default, includes soft-float/hardware FPU + section separation + double-precision stubs + AAPCS + full DWARF + TLS + split_sections + scatter) |
| **C source** | Host testing main path (IR -> readable C, full support for inline-assembly operand passthrough) |
| **x86_64** | Emits GAS assembly |
| **RV32I** | Emits RV32I assembly |

## Directory layout

```
ark c compiler/
?????? include/                Public headers (incl. arkcc_config.h/config.h/opt.h/cpu.h/scatter.h)
?????? src/                    Compiler core (lexer/parser/sema/ir/irgen/preproc/config/opt/cpu/scatter)
?????? src/backend/arm/        ARM Thumb-2 backend (codegen + assembler + linker + soft-float/hardware FPU + full DWARF + TLS)
?????? src/backend/c/          C source backend (host testing)
?????? src/backend/x86_64/     x86_64 assembly backend
?????? src/backend/riscv32/    RV32I assembly backend
?????? stdlib/include/         Built-in standard library headers
?????? port/host/              PC platform layer
?????? port/stm32/             STM32 platform layer (platform/flash_fs/main_stm32 entry point)
?????? examples/               62 tests (.c + .s)
?????? mdk/STM32H743_ArkCC/    Keil MDK project
?????? arkcc.cfg               Default runtime configuration (INI format)
?????? Makefile
?????? docs/MANUAL.md          User manual
?????? README.md
```

## Build

```bash
make            # produces arkcc.exe
make test       # compiles examples
make clean
```

## Command line

```
arkcc <file.c|file.s> [options]
  -o <file>          Output file
  -S                 Emit assembly text only
  -c                 Compile only, do not link (.ark_obj)
  -E                 Preprocess only
  -link a.o b.o      Link multiple .ark_obj
  -v                 Verbose mode
  -target <name>     arm | x86_64 | riscv32 | c (default arm)
  -I <dir>           Include search path
  -O0/-O1/-O2        Optimization level (0=none, 1=basic constant folding + DCE, 2=aggressive)
  -g                 Emit DWARF debug info
  -config <file>     Load INI config file (default arkcc.cfg)
  -f<feature>        Enable feature (vla/complex/wchar/trigraph/fpu/dwarf/...)
  -fno-<feature>     Disable feature
  -Wno-unused        Suppress unused warnings
  --list-backends    List backends

  Target CPU selection
  -mcpu <name>       Cortex-M3/M4/M7/M33 etc.
  --cpu <name>       armcc-style synonym
  --thumb            Force Thumb mode
  --arm              Force ARM mode
  --fpu <type>       soft/hard (soft-float / hardware FPU)

  Dependency generation
  -MMD               Generate .d dependency file (same as gcc)
  --depend           Same as -MMD
  -MF <file>         Specify dependency file name

  Sections and code generation
  --split_sections   One section per function (.text.<fn>)
  -ffunction-sections Same as --split_sections

  Language compatibility options
  --dollar           Allow identifiers to contain `$`
  --enum_is_int      Force enum underlying type to int
  --signed_chars     char is signed by default
  --unsigned_chars   char is unsigned by default
  --wchar16          wchar_t is 16-bit
  --wchar32          wchar_t is 32-bit

  DWARF debug version
  --dwarf2           DWARF v2
  --dwarf3           DWARF v3
```

## Configuration system

arkcc supports a three-layer configuration, with priority: **command line > config file > compile-time defaults**.

- **Compile-time switches** (`include/arkcc_config.h`): `ARKCC_FEATURE_*` macros that decide which features are compiled into arkcc itself.
- **Runtime config file** (`arkcc.cfg`, INI format): the `[features]` section toggles each feature; the `[general]` section controls the optimization level and debug info. `arkcc.cfg` in the current directory is loaded automatically at startup; you can also specify one with `-config <file>`.
- **Command-line overrides**: `-O0/-O1/-O2`, `-g`, `-f<feature>`, `-fno-<feature>`, `--dollar`, `--enum_is_int`, `--signed_chars`/`--unsigned_chars`, `--wchar16`/`--wchar32`, `--dwarf2`/`--dwarf3` override the file settings.

`arkcc.cfg` example:

```ini
[features]
vla               = 1
complex           = 1
wchar             = 1
trigraph          = 1
fpu_hw            = 1
dwarf             = 1
opt_constfold     = 1
opt_dce           = 1
opt_regalloc      = 0
enum_is_int       = 0
dollar_in_identifiers = 0
split_sections    = 0
signed_chars      = 0
wchar16           = 1
wchar32           = 0
dwarf_version     = 2

[general]
opt_level   = 0
debug_info  = 0
```

## Optimization

`-O1` and above enable IR-level optimization passes (`src/opt.c`):

- **Constant folding**: `PUSH_INT a; PUSH_INT b; BINARY op` triplets are folded into `PUSH_INT (a op b)`, scanned in multiple passes to a fixed point (up to 8 passes) with cascading folds. Division by zero / modulo by zero are not folded, to preserve runtime behavior.
- **Dead code elimination**: removes unreachable instructions after `RETURN/JMP/JMP_NAMED` and before the next label.

Each pass is guarded by both the compile-time `ARKCC_FEATURE_OPT_*` macros and the runtime `g_config.enable_opt_*` flags.

## Debug info

When `-g` or `g_config.debug_info=1` is set, the ARM backend emits GNU-as-style DWARF pseudo-ops and complete debug sections in its assembly output:

- `.file 1 "<src>.c"` source file registration
- `.cfi_startproc` / `.cfi_endproc` function frame info
- `.loc 1 <line>` line-number mapping
- `.size <fn>, .-<fn>` function size
- `.type <fn>, %function` type annotation
- `.debug_info` / `.debug_abbrev` / `.debug_line` complete DWARF sections (switch versions with `--dwarf2`/`--dwarf3`)

## Tests

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
```

All 62 tests pass (ARM assembly generation + C backend compile-and-run), covering: basic arithmetic, functions/recursion, struct/union/enum, bitfields, VLA, `_Complex`, `wchar_t`/`L"..."`, trigraphs, inline assembly (basic + extended), the full `__attribute__` set, `__svc`/`__irq`/`__weak`/`__naked`/`__packed`/`__align`/`__at`/`__forceinline`, `__asm` whole-function-body assembly, `#pragma pack/anon_unions/location/...`, TLS, unaligned access via `__packed` pointer, `split_sections`, double-precision float, 64-bit integers, division/modulo, compound literals, designated initializers, struct-by-value, implicit conversions, integer promotion, 64-bit `printf`, `setjmp/longjmp`, multi-file linking, CPU macros, debug info, `$` identifiers, etc.

## Porting to STM32

Just replace `port/host/*.c` with `port/stm32/*.c`; the entry point is `port/stm32/main_stm32.c`. See `mdk/STM32H743_ArkCC/` for the MDK project. The STM32 side is a self-hosted configuration that can directly read `.c` files from the external W25Q Flash and compile-and-execute them in place.
See [docs/MANUAL.md](docs/MANUAL.md) for details.

## Versions

- v0.7.0: armcc compatibility covers 98%+, STM32 self-hosting is stable. New: armcc keywords (`__value_in_regs`/`__pure`/`__interwork`/`__thread`/`__global_reg`/`__smc`/`__int64`..`__int8`/`__typedef`/`__args`/`__return`/`__tp_soft`/`__nothrow`/`__deprecated`/`__may_alias`/`__softfp`), `__attribute__` attribute extensions (`may_alias/nothrow/pure/const/visibility/nonnull/warn_unused_result/sentinel/malloc/fastcall/stdcall/cdecl`), predefined macros (`__arm`/`__thumb`/`__STDC_VERSION__`/`__STDC_HOSTED__`/`__SIZE_TYPE__`/`__PTRDIFF_TYPE__`/`__WCHAR_TYPE__`/`__EDG__`/`__APCS_INTERWORK`), full DWARF (`.debug_info`/`.debug_abbrev`/`.debug_line`), TLS (`.tbss`/`.tdata`), unaligned access via `__packed` pointer, `--split_sections` one section per function, scatter load description file (`include/scatter.h`+`src/scatter.c`), CPU selection (`-mcpu`/`--cpu`+`include/cpu.h`+`src/cpu.c`), command-line extensions (`-MMD`/`--depend`/`-MF`/`--dollar`/`--enum_is_int`/`--fpu`/`--thumb`/`--arm`/`--dwarf2`/`--dwarf3`/`--signed_chars`/`--unsigned_chars`/`--wchar16`/`--wchar32`), config-item extensions (`enum_is_int`/`dollar_in_identifiers`/`split_sections`/`signed_chars`/`wchar16`/`wchar32`/`dwarf_version`). All 62 tests pass.
- v0.6.0: Configuration system + optimization passes + debug info + frontend/backend strengthening. New: three-layer config system (`arkcc_config.h` compile-time macros + `arkcc.cfg` INI runtime config + `-O/-g/-f/-fno-/-config` command line), VLA (`IR_ALLOCA`), wide chars `wchar_t`/`L"..."`/`L'...'`, trigraphs (all 9 C99 trigraphs), `_Complex` complex types, hardware FPU instructions (VFP `VADD/VMUL/VCVT/VCMP` replacing soft-float stubs), DWARF debug info (`.file/.loc/.cfi_startproc/.size`), IR-level constant folding + dead-code elimination (`src/opt.c`), bug fix for comma-separated local declaration scoping. All 56 tests pass.
- v0.5.0: Four waves of must-have features (startup/interrupt vectors, HAL/DMA/MMIO, control algorithms/printf debugging, RTOS/full project). New: `__asm` whole-function-body assembly, `__attribute__((used/unused/alias/constructor/destructor/deprecated/format))`, actually effective `__align`/`__at`/`__packed`/`__forceinline`, anonymous union field promotion, `#pragma anon_unions/location/diag_suppress/arm/thumb/import/push/pop/O0-O3/optimize`, armcc predefined macros, complete implicit conversions and integer promotion, `double` true 64-bit precision, constant-expression initializers for globals, constant-expression array dimensions, 64-bit non-truncating `printf`, strict AAPCS, `setjmp/longjmp`, standard library string.c/math.c/setjmp.c
- v0.4.0: Full C99 + armcc compatibility (`__irq`/`__weak`/`__naked`/bitfield packing/64-bit/division/section separation/compound literals/flexible array/struct by value/pragma pack)
- v0.3.0: Floating-point arithmetic, `__svc`, `.s` compilation, static locals, multi-file linking
- v0.2.0: Multi-backend architecture, C99 subset, standard-library subset
- v0.1.0: Single ARM backend minimal C subset
