# Ark C Compiler user manual

[中文](MANUAL.md) | English

> Version: v0.8.2
> Audience: embedded developers, compiler-construction students, and anyone who wants to run a
> "self-hosting C compiler" on an STM32
> Author: the Ark C Compiler project

---

## Contents

1. [Project overview](#1-project-overview)
2. [Getting started](#2-getting-started)
3. [Command-line reference](#3-command-line-reference)
4. [Supported C language features](#4-supported-c-language-features)
5. [The multi-backend architecture](#5-multi-backend-architecture)
6. [Testing on Windows](#6-testing-on-windows)
7. [The STM32H743 + Keil MDK project](#7-stm32h743--keil-mdk-project)
8. [Code organisation and porting guide](#8-code-organisation-and-porting-guide)
9. [Extension development guide](#9-extension-development-guide)
10. [The standard-library subset](#10-standard-library-subset)
11. [FAQ](#11-frequently-asked-questions)
12. [Known limitations](#12-known-limitations)
13. [Appendix A: internal data flow](#appendix-a-internal-data-flow)
14. [Appendix B: glossary](#appendix-b-glossary)
15. [Appendix C: source and document encoding rules](#appendix-c-source-and-documentation-encoding-rules)
16. [Appendix D: the armcc5 toolchain and MDK build in detail](#appendix-d-armcc5-toolchain-and-the-mdk-build-in-detail)

---

## 1 Project overview

**Ark C Compiler** (abbreviated `arkcc`) is a minimal C compiler written in C99. Version v0.8.2 covers
more than 98 % of the ARM Compiler 5 (armcc) extensions in common use (only C++ mode and advanced
optimisation are missing). Design goals:

- **Embedded self-hosting**: the compiler itself can run **natively** on a Cortex-M7 such as the
  STM32H743, read `.c` sources from an external SPI flash, generate machine code in place and then jump
  straight into it. `port/stm32/main_stm32.c` provides a standalone entry point that closes the
  "compile-link-execute" loop with no PC-side toolchain at all.
- **Multiple backends**: the core front end produces only target-independent stack-VM intermediate code
  (IR), and the backend can be switched freely between `arm` / `x86_64` (SysV AMD64) / `x86`
  (i386 cdecl) / `riscv32` / `c`. `x86_64` used to be an alias of `x86`; it is now an independent
  backend (see [X86_64_BACKEND.en.md](X86_64_BACKEND.en.md)).
- **Easy to extend**: every layer (lexer/parser/sema/irgen/codegen/asm/linker) lives in its own file,
  and adding a keyword, an AST node or a target platform has clear extension points.
- **Easy to test on Windows**: the built-in `c` backend translates IR back into readable C that the
  host gcc can compile and run directly — no emulator and no real hardware needed.

### 1.1 The overall pipeline

```
   source .c
      |
      v
+----------+    +--------+    +--------+    +--------+
| preproc  |--> | lexer  |--> | parser |--> |  sema  |
+----------+    +--------+    +--------+    +--------+
                                                |
                                                v
                                            +--------+
                                            | irgen  |
                                            +--------+
                                                |
                                                v
                   backend = arm | x86_64 | x86 | riscv32 | c
                                                |
                                                v
                           +---------------+--------------+
                           |    emit_asm   |  assemble    |  link
                           +---------------+--------------+
                                                |
                                                v
                                  .S (assembly) / .bin (machine code) / .gen.c
                                                |
                                                v  (on the STM32: jump straight into the machine code)
```

The ARM backend pipeline additionally covers: CPU selection (`-mcpu`/`--cpu`, which affects the
instruction set and the default alignment), scatter-file parsing (`src/scatter.c`), TLS section
generation (`.tbss`/`.tdata`) and the full set of DWARF debug sections
(`.debug_info`/`.debug_abbrev`/`.debug_line`).

### 1.2 Directory overview

```
ark c compiler/
├── include/                  public headers (front end + backend interface + cpu.h + scatter.h)
├── src/                      the compiler core (target-independent front end + cpu.c + scatter.c)
│   └── backend/              all backends
│       ├── registry.c        the backend registry
│       ├── arm/              ARM Cortex-M Thumb-2 backend
│       ├── x86_64/           the two x86 backends: i386 cdecl (x86) + SysV AMD64 (x86_64)
│       ├── riscv32/          RV32I GAS backend
│       └── c/                host-test backend (IR -> C)
├── stdlib/                   the compiler's own minimal standard library
│   ├── include/              headers (stdint/string/stdio/math/setjmp and so on)
│   └── src/                  optional implementation sources
├── port/
│   ├── host/                 PC platform abstraction (stdio)
│   └── stm32/                STM32 platform abstraction (HAL UART + W25Q + the main_stm32.c self-host entry)
├── examples/                 80 test samples (.c; the regression script runs 75 of them)
├── mdk/STM32H743_ArkCC/      Keil MDK project (STM32H743VIT6)
├── arkcc.cfg                 default runtime configuration (INI format)
├── Makefile                  host build script
├── docs/MANUAL.md            this manual
└── README.md                 project overview
```

---

## 2 Getting started

### 2.1 Environment (Windows)

1. Install **MSYS2** or **MinGW-w64** and make sure `gcc` is on `PATH`:
   ```powershell
   gcc --version
   ```
2. Optional: the **STM32 embedded part** needs **Keil MDK-ARM 5.36+**, and optionally an ST-Link
   debugger and an STM32H743 board.

### 2.2 Build and test in three minutes

```powershell
cd "<ark-cc-repo-path>"

# 1. build arkcc itself
make
# equivalent to: gcc -Wall -Wextra -O2 -std=c99 -Iinclude -Istdlib/include `
#                src/*.c src/backend/*/*.c port/host/*.c -o arkcc.exe

# 2. run one sample (emits Thumb-2 assembly)
.\arkcc.exe examples\hello.c -target arm -S

# 3. run the full test set through the c backend (recommended)
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
```

For each sample the test script:

1. checks with `-target arm -S` that the ARM backend does not crash;
2. generates `*.gen.c` with `-target c -S`;
3. compiles and runs `*.gen.exe` with the host gcc, checking the exit code.

The output looks like:

```
[arm] hello.c
[c]   hello.c   exit=42
[arm] arith.c
[c]   arith.c   exit=900
...
```

**All 71 assertion cases pass, 4 cases skip the C-backend run, 0 fail** (the four skipped ones are
ARM-only: two inline-assembly samples and two STM32 hardware-access samples; the script only performs
the ARM emission check on them and does **not** count them as passes). The `Expected exit code` in each
sample's header is parsed by the script and compared against the real exit code; any mismatch is a
failure.

### 2.3 Compiling your own .c file

Create `myprog.c`:

```c
int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}
int main(void) {
    return factorial(6);
}
```

Compile and run:

```powershell
.\arkcc.exe myprog.c -target c -S -o myprog.gen.c
gcc myprog.gen.c -o myprog.exe
.\myprog.exe; echo $LASTEXITCODE   # should print 720
```

---

## 3 Command-line reference

```
arkcc <file.c|file.s> [options]
```

### 3.1 General options

| Option | Meaning |
| --- | --- |
| `-o <file>` | output file; defaults to `<input>.bin` (machine code) or `<input>.gen.c` (c backend + `-S`) |
| `-S` | emit textual assembly/source only, no assembling or linking |
| `-c` | compile without linking, producing a `.ark_obj` (ARKOBJ2 container). C sources and `.s/.S/.asm` assembly sources take the same path |
| `-E` | preprocess only |
| `-link a.o b.o` | link several `.ark_obj` files; if any object carries `.data/.bss` the SRAM windows are checked for overlap and an overlap is an error with no output |
| `-target <name>` | choose the backend: `arm` (default), `x86_64`, `x86`, `riscv32`, `c`. Aliases: `amd64`/`x86-64` → `x86_64`; `i386`/`i686`/`x86_64-msvc`/`x86-msvc` → `x86` |
| `-I <dir>` | add an extra `#include` search path (repeatable) |
| `-v` | verbose: print the time and output size of every stage |
| `-O0/-O1/-O2` | optimisation level (0 = none, 1 = basic constant folding + DCE, 2 = aggressive + inlining) |
| `-g` | emit DWARF debug information, equivalent to `--dwarf2`; add `--dwarf3` for v3 |
| `-config <file>` | load an INI configuration file (default `arkcc.cfg`) |
| `-f<feature>` / `-fno-<feature>` | enable/disable a feature (vla/complex/wchar/trigraph/fpu/dwarf/opt-inline/opt-dce/opt-constfold/...) |
| `-Wno-unused` | suppress unused warnings |
| `--list-backends` | list every available backend |
| `--diag_style <arm\|ide>` | diagnostic layout: `arm` (default, same as armcc's default) or `ide` (uVision's `file(line,col) : error code: message` style) |
| `--diag_suppress=<n>[,<n>]` | suppress the given codes (as armcc: non-numeric or out-of-range codes are silently ignored; no value reports `C3901U`) |
| `--diag_remark=<n>[,<n>]` | indistinguishable from `--diag_suppress` (measured to be the same in armcc); reuses the same suppression bits |
| `--diag_error=<n>[,<n>]` | promote the given codes to error; the `-D` suffix is still kept according to the code's intrinsic category |
| `--diag_warning=<n>[,<n>]` | accepted but a no-op (measurement shows armcc has no observable change on the same error either) |
| `--errors <file>` | write the whole diagnostic stream to a file instead of stderr |
| `-h`, `--help` | show help |

### 3.2 Target CPU selection

| Option | Meaning |
| --- | --- |
| `-mcpu <name>` | select Cortex-M3/M4/M7/M33 etc.; affects the instruction set and default alignment |
| `--cpu <name>` | armcc-style synonym |
| `--thumb` | force Thumb mode (the Cortex-M default) |
| `--arm` | force ARM mode |
| `--fpu <type>` | `soft` (software floating point) / `hard` (hardware FPU, VFP) |

CPU selection is implemented in `include/cpu.h` + `src/cpu.c` and sets the corresponding predefined
macros automatically (`__TARGET_ARCH_7_M`, `__TARGET_ARCH_7E_M`, `__TARGET_FPU_VFP`, …).

**Double-precision FPU follows `-mcpu` only**: the Cortex-M7 FPU is VFPv5-**D16** (with double
precision), while M4/M33 are single-precision only. With `-mcpu Cortex-M7` the implicit conversions
`double`↔`float` emit `VCVT.F64.F32` / `VCVT.F32.F64` directly; without it (or with M4/M33) the
compiler takes the conservative path and emits `BL __aeabi_f2d` / `BL __aeabi_d2f`, and **those two
symbols must come from the runtime library** (libgcc or an equivalent). On a bare-metal small program
that has only single-precision hardware and does not link libgcc, the latter becomes a link-time
`unresolved symbol "__aeabi_f2d"` — the right answer there is to tell the compiler the target CPU,
not to patch in a soft-float helper. (This used to be a defect: the switch computed from `-mcpu` was
zeroed during later initialisation, so `-mcpu Cortex-M7` looked accepted while `__aeabi_f2d` was still
emitted. Fixed; see also Q5 in this chapter.)

### 3.3 Dependency generation

| Option | Meaning |
| --- | --- |
| `-MMD` | emit a `.d` dependency file (behaviour matches gcc) |
| `--depend` | same as `-MMD` |
| `-MF <file>` | set the dependency file name |

### 3.4 Sections and code generation

| Option | Meaning |
| --- | --- |
| `--split_sections` | one section per function (`.text.<fn>`), which helps the linker drop dead code |
| `-ffunction-sections` | same as `--split_sections` |

### 3.5 Language compatibility options

| Option | Meaning |
| --- | --- |
| `--dollar` | allow `$` inside identifiers |
| `--enum_is_int` | force the underlying enum type to `int` |
| `--signed_chars` | `char` is signed by default |
| `--unsigned_chars` | `char` is unsigned by default |
| `--wchar16` | `wchar_t` is 16 bits |
| `--wchar32` | `wchar_t` is 32 bits |

### 3.6 DWARF version

| Option | Meaning |
| --- | --- |
| `--dwarf2` | emit DWARF v2 debug sections |
| `--dwarf3` | emit DWARF v3 debug sections |

### 3.7 Common command combinations

| Goal | Command |
| --- | --- |
| quick check that lexing/parsing is fine | `arkcc x.c -target c -S -o /dev/null` |
| debug IR -> assembly translation | `arkcc x.c -target arm -S` |
| produce a host-runnable executable | `arkcc x.c -target c -S -o out.c && gcc out.c -o out` |
| generate Cortex-M7 + hardware FPU code | `arkcc x.c -target arm -mcpu=cortex-m7 --fpu=hard -S` |
| emit DWARF v3 debug information | `arkcc x.c -target arm -g --dwarf3 -S` |
| one section per function (easier dead-code removal) | `arkcc x.c -target arm --split_sections -S` |
| generate Makefile dependencies | `arkcc x.c -MMD -MF x.d` |
| write into STM32 W25Q for execution | `arkcc x.c -target arm -o /app/main.bin` (then flash it with a host tool) |

---

## 4 Supported C language features

This section lists what the compiler really supports, using ISO/IEC 9899:1999 (C99) as the reference.
The compiler implements the full C99 set and covers more than 98 % of the common armcc extensions; six
further C11 keywords (`_Static_assert` / `_Alignof` / `_Alignas` / `_Generic` / `_Thread_local` /
`_Atomic`) are covered in 4.9.

### 4.1 The type system

| Category | Supported | Notes |
| --- | :---: | --- |
| `void` `char` `short` `int` `long` `long long` | yes | `int` is 32-bit, `long long` is 64-bit |
| `signed` / `unsigned` modifiers | yes | sema distinguishes signed/unsigned; `--signed_chars`/`--unsigned_chars` control `char`'s default signedness |
| `_Bool` / `bool/true/false` from `<stdbool.h>` | yes | |
| `float` / `double` / `long double` | yes | the ARM backend supports either hardware FPU (VFP) or `__aeabi_f*`/`__aeabi_d*` soft-float stubs; `double` is true 64-bit precision |
| `_Complex` / `_Imaginary` | yes | `_Complex double`/`_Complex float` are passed straight to gcc (`sizeof(_Complex double)==16`) |
| one- and multi-dimensional arrays | yes | dimensions may be constant expressions |
| pointers, multi-level pointers | yes | |
| function pointers | yes | full syntax and call support |
| `struct` / `union` | yes | field offsets, `.`/`->`, bit-fields (truly packed at the bit level), flexible array members, anonymous struct/union field promotion |
| `enum` | yes | treated as a set of int constants; `--enum_is_int` forces an int underlying type |
| `typedef` | yes | including recursive typedefs |
| type qualifiers `const` `volatile` `restrict` | yes | parsed and used during semantic analysis |
| storage classes `static` `extern` `auto` `register` | yes | `static/extern` affect linkage; a function-local `static` has persistent lifetime |
| `inline` | yes | parsed (as a hint) |
| `__thread` (TLS) | yes | thread-local storage, emitting `.tbss`/`.tdata` (on the scatter-loading path) |
| `_Thread_local` (C11 TLS) | yes | shares the same storage bit as `__thread` (`0x10000`) plus the C11 6.7.1p4 storage-class checks; equivalent to plain `.data`/`.bss` in a flat bare-metal image — semantic boundary in 4.9 |
| casts `(type)expr` | yes | |
| `sizeof(type)` / `sizeof expr` | yes | evaluated at compile time |
| VLA (variable-length arrays) | yes | `int a[n]` allocates a runtime VLA on the stack through `IR_ALLOCA`, rounded up: 8 on ARM / x86_64, 16 on RV32I (the psABI requires sp to be 16-byte aligned before every call). Any RV32I function containing `IR_ALLOCA` rebuilds sp with `sub sp, s0, frame_size` in its epilogue before popping the frame, otherwise `return` reads `ra`/`s0` from the wrong offset. Gate: `tests/run_rv_alloca_tests.py --rv-as <bin>` |
| `__packed` unaligned access | yes | byte-by-byte load-and-stitch covering 1/2/4/8 bytes (ARM and RV32I). 8 bytes means `long long`/`double`: the low word is assembled and pushed first, then the high word, matching the push order of the aligned path. Gate: `tests/run_rv_packed_tests.py --rv-as <bin> [--arm-as <bin>]` |

### 4.2 Literals

| Form | Example | Supported |
| --- | --- | :---: |
| decimal integers | `42` | yes |
| octal | `0755` | yes |
| hexadecimal | `0xFF` | yes |
| integer suffixes | `42u 42L 42ull` | yes |
| character | `'a' '\n' '\xFF' '\0'` | yes |
| string | `"hello\n"`, adjacent concatenation supported | yes |
| floating point | `1.5 1.5e-3 .5 2.0f` | yes |
| wide character / wide string | `L'a' L"..."` | yes (`--wchar16`/`--wchar32` switch the width) |

An integer literal's type is chosen from the two C99 6.4.4.1p5 candidate tables: a **decimal** spelling
(`42`, `42L`) without `u` walks `int → long → long long` and never becomes unsigned, while
**octal/hexadecimal** (`0xFF`, `0755`) walk the bit pattern through `int → unsigned int → long →
unsigned long → long long → unsigned long long`. `Token.lit_dec` records the spelling form, and the
choice is made in one place, `int_literal_type()` in `parser.c`.

That table is the crux of a patch-level fix: without it, any `unsigned` suffix was mapped to
`unsigned int`, so `4300000000u` was silently truncated to `0x004CA300 = 5032704` and
`x != 4300000000u` was true for every `x`.

### 4.3 Operators

| Category | Supported |
| --- | :---: |
| arithmetic `+ - * / %` | yes |
| comparison `== != < > <= >=` | yes |
| logical `&& \|\| !` (short-circuit) | yes |
| bitwise `& \| ^ ~ << >>` | yes |
| assignment `=` and all compound assignments `+= -= *= /= %= &= \|= ^= <<= >>=` | yes |
| increment/decrement `++ --` (prefix + postfix) | yes |
| conditional `?:` | yes |
| comma `,` (in expression context) | yes |
| address-of `&` / dereference `*` | yes |
| member access `.` / `->` | yes |
| `sizeof` | yes |

### 4.4 Statements

| Statement | Supported |
| --- | :---: |
| expression statements, declaration statements | yes |
| `if / else` | yes |
| `while / do-while / for` | yes |
| `switch / case / default` | yes |
| `break / continue / return` | yes |
| `goto` + labels | yes |
| declarations anywhere in a block (the C99 relaxation) | yes |
| declarations in `for (int i = 0; ...; ...)` | yes |

### 4.5 Functions

| Feature | Supported |
| --- | :---: |
| definition, declaration, call, recursion | yes |
| more than 4 parameters | yes (the extras go on the stack, strictly AAPCS) |
| prototypes and argument-count checking | yes |
| variadics `...` | yes (all four backends: ARM / RV32I use 4-byte word slots, C / x86_64 use 8-byte slots — see the backend section and the "variadics" entry) |
| calling through function pointers | yes |
| argument conversion for indirect calls | yes (C99 6.5.2.2p7 applies to **all** calls, not just direct ones) |

Direct calls have always cast arguments to the parameter type with `sema_implicit_cast`, but indirect
calls (`fp(x)`, `(*fp)(x)`, or a designator selected by `_Generic` or a conditional expression) used to
**skip that step**, so an `int` argument occupied only one stack word while the backend's
`IR_SEXT`/`IR_ZEXT` are no-ops on the machine backends (they only fix word order for values that are
already two words). When the callee read a 64-bit parameter it took the neighbouring word as the high
half — wrong numbers on ARM, and the function-pointer arm even read a wild address. The fix is in sema,
not in the backend: `sema_callee_proto()` first strips leading `*` via `sema_callee_func_sym()`, looks
at both arms of a conditional expression, and resolves `AST_VAR` through the symbol table to a
`Symbol` (a function's return type and parameter list live on its `Symbol`, not on the expression
type); without a prototype the arguments are left alone. The same family of return-type problems was
fixed at the same time: a designator call's return type used to be downgraded to `int`, so
`atomic_load()` returning `unsigned long long` pushed only one register.
| `inline` | yes (as a hint) |
| old-style K&R parameters | yes |
| structs passed/returned by value | yes (through a hidden pointer parameter) |

### 4.6 The preprocessor

| Directive | Supported |
| --- | :---: |
| object-like macros `#define NAME body` | yes |
| function-like macros `#define MAX(a,b) ((a)>(b)?(a):(b))` | yes |
| `#` stringification, `##` pasting | yes |
| line continuation `\` | yes |
| `#if / #elif / #else / #endif` | yes |
| `#ifdef / #ifndef` | yes |
| `#undef / #error / #warning` | yes |
| `#pragma` (details in 9.4) | yes |
| nested `#include` (up to 8 levels) | yes |
| search paths `-I` | yes |
| trigraphs (all nine C99 trigraphs) | yes |
| predefined macros `__FILE__` `__LINE__` `__STDC__` `__ARK_CC__` | yes |
| `__STDC_VERSION__` `__STDC_HOSTED__` | yes |
| `__func__` `__DATE__` `__TIME__` | yes |
| variadic macros `__VA_ARGS__` | yes |

### 4.7 Initialisation and linking

| Feature | Supported |
| --- | :---: |
| globals, internal/external linkage | yes |
| initialised local variables | yes |
| aggregate initialisers `{1,2,3}` | yes |
| nested aggregate initialisers `{{1,2},{3,4}}` | yes |
| designated initialisers `.x=1` `[2]=5` | yes |
| string initialisers `char s[]="hi"` | yes |
| global initialisers that are not literals (constant-expression folding) | yes |
| compound literals `(int[]){1,2,3}` / `(struct P){.x=1,.y=2}` | yes |
| TLS initialisation (`__thread` / `_Thread_local`) | yes |

### 4.8 Inline assembly

| Form | Supported |
| --- | :---: |
| basic form `asm("...")` / `__asm__("...")` | yes |
| extended form `asm("..." : outputs : inputs : clobbers)` | yes |
| `__asm void fn() {...}` whole-function assembly (armcc style) | yes |

The C backend passes inline assembly through completely (including operand substitution); the ARM
backend passes the text through.

---

### 4.9 C11 keywords (subset)

Six C11 keywords were added after v0.8.0; the remaining C11 features (`<threads.h>`, `_Atomic` on
aggregates, and so on) are out of scope. The entry points are in three places — the lexer (keyword
table), the parser (folding and node construction) and sema (`_Generic` arm selection); the first four
are invisible downstream, `_Thread_local` costs one extra storage bit, and `_Atomic` lands on
`Type::is_atomic` (structurally like `const`/`volatile`, so that declarations after
`typedef _Atomic int atomic_int;` know they are atomic objects) and makes `sema` reject every
read-modify-write.

| Keyword | Supported | Implementation notes |
| --- | :---: | --- |
| `_Static_assert(expr[, "msg"])` | yes | three entry points: file scope / block scope / struct member; `expr` is folded at parse time with `eval_const_expr`, a non-integer-constant expression is an immediate error, and when the condition is 0 the `msg` goes into the diagnostic. No AST node — on success it produces nothing |
| `_Alignof(type-name)` | yes | folded from the **type** (`type_align()`), not from the expression's default int; only type names are accepted, `_Alignof(expr)` is an error (C11 does not allow it either) |
| `_Alignas(type-name)` / `_Alignas(const-expr)` | yes | non-power-of-two or non-constant is an error; **does not weaken** natural alignment (C11 6.7.5p6); globals go through `g_attr_align_bytes` (the ARM flat SRAM layout places them by `align_bytes`), members set `Type::align_override`, and block scope is capped at 8 bytes (see below) |
| `_Generic(ctrl, T: e, ..., default: e)` | yes | the controlling expression gets the C11 6.5.1.1p2 lvalue conversion + array decay + function-designator decay; no integer promotion; no match and no `default` → error; duplicate `default` → error; once selected, sema squashes the node with `*node = *sel`, and irgen has a defensive branch (if sema were skipped it errors instead of emitting 0) |
| `_Thread_local` | yes | its own `TOK_THREAD_LOCAL` (not reusing `TOK_THREAD`, otherwise "which spelling was it" is lost); storage bits `0x10000` = TLS and `0x20000` = spelled `_Thread_local` (the C11 constraint applies only to the latter, so armcc's bare `__thread` stays exempt). Constraints ordered most-specific first: typedef → function → needs `static`/`extern` → may not combine with `auto`/`register` |
| `_Atomic` | yes (with boundaries) | its own `TOK_ATOMIC`; at the end of `parse_declspec()`, `g_decl_is_atomic` becomes `Type::is_atomic` through `type_atomic()` (shallow copy then mark, never polluting a singleton), so atomicity **propagates through typedefs**. It decides three things: which `<stdatomic.h>` implementation applies, which types are rejected outright, and that `sema` rejects read-modify-write. `x += 1` and `x++` are read-modify-write per C11 6.5.16.2p3 / 6.5.2.4p2 and are always errors naming `atomic_fetch_add/sub/and/or/xor()` (a plain `x = 5` is not an error — that *is* an atomic store). `check_atomic_type()` rejects arrays (C11 6.7.2.4), function types and `struct`/`union` (an aggregate needs a lock, so it is rejected rather than pretending the access can be atomic) and is called in three places (members / declarators / resets). Real atomicity exists only on ARM: `stdlib/include/stdatomic.h` builds critical sections from `__arkcc_crit_save` / `__arkcc_crit_restore` (`MRS PRIMASK` + `CPSID i`, backend builtins that do not need `--asm-extra`) |

Five **explicitly written** limitations:

1. **Block-scope `_Alignas(> 8)` is an error**, never a silent downgrade: the frame is built with
   `sp -= N; base = sp` and AAPCS only guarantees 8-byte `sp` alignment; really supporting
   16/32/64 would mean changing the prologue/epilogue and resolving the conflict with the variadic
   sequence, which uses `r5` to save the old `sp`. Diagnostic text:
   `block-scope _Alignas above 8 bytes is not supported (the frame is 8-byte aligned)`.
2. **`_Generic` associated types do not compare function signatures**: when `parse_declarator` parses
   `(*fp)(params)` it keeps the parameter list on the pointer type (so call sites can judge argument
   widths, see 4.10), but type identity only compares the `is_func_ptr` flag and the return type, not
   the parameter list. So `int (*)(int)` and `int (*)(double)` still cannot be distinguished in an
   association list. For that reason `_Generic` matching additionally requires the `is_func_ptr` flag
   to agree (otherwise a plain `int *` matches a function designator — a wrong-arm selection this
   repository really hit).
3. **Function-designator decay for the controlling expression only covers "identifier / unary `*` /
   unary `&`"**: sema parses shallowly and the symbol table only stores a function's return type, so
   the decay logic is completed inside the `_Generic` branch by symbol kind; more complex
   function-designator expressions (for example a conditional expression with functions on both arms)
   are out of scope and fall back to the ordinary expression type.
4. **`_Thread_local` only reaches "the storage class is TLS and the checks follow C11"; there is no
   thread-pointer relocation**: only the scatter-loading path (`ARKCC_FEATURE_ARMCC_KEYWORDS`) emits
   `.tbss`/`.tdata`; in a flat bare-metal image (`--vector-table`) it is ordinary `.data`/`.bss`, placed
   in SRAM and zeroed by `__arkcc_init_globals()`, which is the correct value semantics on a
   single-threaded bare machine. The C backend emits `__thread` verbatim for the host compiler.
   Execution-level evidence: `tls_static_init` (8), `tls_block_static` (6) and `tls_reject` (four
   diagnostics + no image left behind) in `tests/arm_exec/run_arm_exec.py`.
5. **`_Atomic` has a real atomic path only on ARM; the other four targets fail at compile time**: this is
   deliberate — expanding `atomic_store(p, v)` into `*p = v` "looks right" on a single core, and becomes
   a silent wrong answer the moment there are interrupts or a second core. In the non-ARM branch every
   name expands to the undeclared identifier
   `__arkcc_atomic_<op>_not_supported_on_this_target_use_a_mutex`, so the error text is itself the
   manual. To be precise about `Type`: atomicity **has** landed on `Type::is_atomic` (otherwise
   `atomic_int x; x += 1;` after `typedef _Atomic int atomic_int;` could not be caught), but
   "participating in type identity" is still not implemented — this compiler compares `kind` / width /
   `is_const` and the other existing flags, and `is_atomic` takes no part. Three more explicitly
   written gaps: `int *_Atomic p` (qualifier after the `*`) is unsupported; read-modify-write through a
   pointer such as `*p += 1` is not intercepted (`is_atomic` does not propagate through dereference —
   use `atomic_fetch_add(p, 1)`); and `lock xadd` / `cmpxchg16b` are not wired into `x86_64`. Memory
   ordering is always `seq_cst` (critical section + the `__memory_changed()` compiler barrier) and is
   **single-core interrupt-level mutual exclusion**; cross-core / cross-DMA visibility is outside it.
   Execution-level evidence: `atomic_rmw` (10), `atomic_nested_mask` (6: the nested saved value must be
   0,1,1,0), `atomic_wide` (6) and `atomic_reject` (three diagnostics + no image left behind); the
   cross-target matrix is `tests/run_atomic_tests.py` and `docs/ATOMIC.en.md`.

Gate: `python tests/run_c11_keywords_tests.py --arm-as <bin> [--rv-as <bin>]` — 30 items across the ARM
and RV32I targets (11 runtime cases × 2 targets + 8 diagnostic cases), plus three self-checks (a
true/false static-assert contrast, `_Alignof` must not equal the default 4, and a mismatched expectation
must go red).

### 4.10 Complex types (`_Complex`)

`_Complex float` is 8 bytes and `_Complex double` is 16 bytes. Inside an **object** the real part comes
first and the imaginary part second, each stored byte-for-byte at its own floating-point width (little
endian, so the real part of a `double` is its four bytes `[lo, hi]` first):

| Type | Offset 0 | Offset 4 | Offset 8 | Offset 12 |
| --- | --- | --- | --- | --- |
| `_Complex float` (8 B) | `re_f32` | `im_f32` | — | — |
| `_Complex double` (16 B) | `re_lo` | `re_hi` | `im_lo` | `im_hi` |

`sizeof`/`_Alignof` match gcc (8/16, alignment 4/8); a static initial value (such as
`double _Complex g = 3.0 - 2.0i;`) is constant-folded by the front end and written into `.data`, and both
machine backends share the same filling implementation.

**IR value-stack shape**: inside a machine backend a complex value occupies 4 IR words, with the stack top
at the low address, `sp+0 = re_hi, sp+4 = re_lo, sp+8 = im_hi, sp+12 = im_lo` (`_Complex float` only uses
the re/im slots). Taking the real or imaginary part, widening `float <-> double`, and complex conjugation
are all encoded inside a single IR instruction by the `IR_AUX_COMPLEX` aux family, without going through a
function call.

**Return-value ABI**: a 16-byte `_Complex double` does **not** go through sret; it uses the return-value
registers directly:

| Target | `_Complex float` (8 B) | `_Complex double` (16 B) |
| --- | --- | --- |
| ARM (Thumb-2, soft float) | `r0 = re_f32`, `r1 = im_f32` | `r0:r1 = re(lo,hi)`, `r2:r3 = im(lo,hi)` |
| RV32I | `a0 = re_f32`, `a1 = im_f32` | `a0..a3 = re_lo, re_hi, im_lo, im_hi` |
| x86_64 / C backend | rejected (see below) | rejected (see below) |

This matches the soft-float AAPCS of arm-none-eabi-gcc (under soft float a 16-byte composite type is just
two register pairs), so functions compiled by arkc can call library functions compiled by gcc and vice
versa. **sret is used only for struct/union (size > 8)**. The direct reason for choosing return-value
registers instead of sret for complex numbers: the caller does not have to prepare a buffer for the return
value, so all three shapes — "call through a declaration", "call through a function pointer", "call across
translation units" — work automatically. Under sret each of the three needs its own bookkeeping, and
missing any one of them is a silently wrong value (struct/union used to leak exactly like that; see the
passage below).

**Argument ABI**: C99 6.5.2.2 requires arguments to be converted to the parameter type first. If the
converted value is a 16-byte complex value, `irgen` materialises it into a temporary object and pushes
**a single address word**; the callee's `IR_GETARG` sees the size marked on `aux` (> 8) and `memcpy`s it
into the frame from that address. Two notes:

- An 8-byte `_Complex float` travels as a "two-word value", not an address word (same shape as `long
  long`);
- Function-pointer calls are covered too: `parse_declarator` now keeps the parameter types of
  `(*fp)(parameter list)` on the pointer type, so a call through
  `double _Complex (*fp)(double _Complex);` knows the parameter is 16 bytes (earlier versions skipped the
  parameter list as balanced parentheses, so such calls were honestly rejected).

**Explicitly rejected (better an error than a wrong answer)**:

- The x86_64 backend rejects complex global objects and complex operations outright (`_Complex value not
  supported by the x86 backend`) and produces no image; the C backend prints the initial value as-is into C
  source and hands it to the host gcc.
- Passing a complex value through `...`: `va_arg` can only walk consecutive argument **words** and the
  callee has no type information, so the call site reports
  `passing a _Complex value without a _Complex parameter type ...` instead of materialising only half of
  it.
- Global address-constant initial values (function pointers, object pointers, array/member addresses) are
  supported, see the section "Global address-constant initialisers (C11 6.6p9)" below; any initialiser not
  in that form is an error, never a silent zero.

**Function-type typedefs (`typedef Ret F(args);`)**

A typedef name records the real `TYPE_FUNC` type (C99 6.7.1 + 6.7.5: the declared type is "a function
returning Ret"), not a function. Therefore:

- `F *p` is an ordinary pointer to that function type, and `sizeof(F *)` is the target pointer size;
- `F name;` is a function **declaration** — return type, parameter list, the `...` marker, block-scope
  linkage (C99 6.2.2p5), and argument conversion at call sites all behave exactly as if the prototype had
  been written out;
- `F name { ... }` is not valid C (6.9.1 requires an identifier declarator in a definition); it is an error
  rather than a guess;
- `sizeof(F)` / `_Alignof(F)` are errors (6.5.3.4p1 forbids sizeof / alignment of a function type) instead
  of returning a default of 4.

Older versions handed the `(` after the name of `typedef Ret F(args);` to the "function definition /
declaration" branch, discarded the typedef and registered the name as a function; the symptoms were
`sizeof(F *)` reporting `expected an expression`, `F *p;` reporting `expected declaration at top level`,
and `sizeof(F)` silently returning 4. Regression gate: `tests/run_func_typedef_tests.py` (10 runtime cases
per machine backend + 2 "must be rejected" cases).

**Global address-constant initialisers (C11 6.6p9)**

A file-scope pointer object may be initialised with "address of an object with static storage duration ±
integer constant" or with a function address. The implementation does not bake the address into bytes (a
function address does not even exist before linking); it records a `(symbol, byte offset)` triple
(`IrGlobal.init_sym / init_sym_off / init_sym_is_func`) and each backend emits its own symbol reference:

| Initialiser form | ARM (Thumb-2) | RV32I | Note |
| --- | --- | --- | --- |
| `int (*p)(int,int) = add;` | `LDR r0,=add` | `.word add` | function designator |
| `int (*p)(int,int) = &add;` | same | same | `&` does not change function-address semantics |
| `typedef int binop(int,int); binop *p = sub;` | same | same | both the `TYPE_FUNC` and the `is_func_ptr` forms of a typedef are recognised |
| `int gv; int *p = &gv;` | `MOVW/MOVT addr` | `.word gv` | object in this TU |
| `int a[4]; int *p = &a[2];` | `addr + 8` | `.word a + 8` | element stride applied |
| `int *p = &a[1] + 2;` | `addr + 12` | `.word a + 12` | address ± integer constant |
| `int *p = a;` | `addr` | `.word a` | array decays to the first element |
| `char c[8]; char *p = &c[1];` | `addr + 1` | `.word c + 1` | stride from the element type (1 for char) |
| `struct S{int k,j;} s; int *p = &s.j;` | `addr + 4` | `.word s + 4` | member address |
| `int *p = (int*)&a[3];` | `addr + 12` | `.word a + 12` | a cast does not change the address value |
| `int *p=&gv; int **pp=&p;` | `addr` | `.word p` | address of the pointer object itself |
| `static int sv; int *p=&sv;` | `addr` | `.word sv` | static object |
| `static int h(void); int (*q)(void)=h;` | `LDR r0,=h` | `.word h` | static function |

**Forms that must be rejected (implemented; each reports an error and produces no image):**

- `int (*p)(int,int) = add + 1;` — a function type has no stride (C11 6.5.6p2 requires the pointer to
  point at a complete object type); reports `is an address that is not a constant expression (C11 6.6p9)`;
- `int x = f();` — a function call is not a constant expression; reports `the initialiser of the global
  '...' is not a constant expression this build can place in data` (older versions silently wrote 0);
- **ARM object address across translation units** (`extern int other; int *p = &other;`) — ARM global
  objects are not in an ELF symbol table; the data section is laid out sequentially from the fixed base
  `0x20000000`, so another unit's object cannot be named before linking; reports `another unit's object
  cannot be named here`. Cross-TU **function** addresses are exempt (they go through an `R_ARM_ABS32`
  relocation).
- **RV32I object mode "relocation + non-zero offset"** — the ARKOBJ2 relocation table has no addend field,
  so under `-c`, `.word ext + 4` reports `ARKOBJ2 relocation carries no addend; define the symbol in this
  translation unit`; assembly/flat mode (`.s`/`-S`/direct `.bin`) is not restricted, and a cross-TU `.word
  ext` itself works.

Regression gate: `tests/run_func_ptr_global_tests.py` (16 runtime cases × 2 backends, cross-checked against
the host gcc + 3 "must be rejected" cases + 2 groups of cross-TU `-c`/`-link`).

**Address elements inside aggregate initialisers (C11 6.6p9)**

Aggregate initial values may also hold address constants, as long as **the braces are written out level by
level**:

| Form | ARM (Thumb-2) | RV32I |
| --- | --- | --- |
| `int (*tab[2])(int,int) = { add, sub };` | `LDR r0,=add` then `STR` per element | `.word add` / `.word sub` |
| `int gv; int *pa[2] = { &gv, &gv };` | same (`MOVW/MOVT`) | `.word gv` |
| `struct S{int n; int (*f)(int,int); int *p;} s = {3, add, &gv};` | written at member offsets | segmented `.byte` / `.word` at member offsets |
| `struct C t[2] = { {1, add}, {2, sub} };` | same | same |
| `char c[8]; char *cs[2] = { &c[1], &c[2] };` | stride from the element type (1 for char) | same as left |

The implementation is a **cross-check of two independently derived walks**, not duplicated work:

1. `src/irgen.c` walks the AST again (`IrGlobal.init_refs`, one `(byte offset, symbol, addend, is_func)`
   per entry), with offsets computed from the type tree;
2. `src/agginit.c` still fills bytes from "text + type"; for any element where no number can be read but
   the type is a pointer or a function, it asks a backend hook (the `addr_hook` of `ark_agg_fill_ex()`),
   and the backend looks the offset up in `init_refs`: if found it writes a zero placeholder and later
   overwrites it with the real address; if not found it rejects
   (`cannot turn the initialiser ... into data`) instead of silently writing the address as 0.

**Designators and `union` are supported too** (`int *pa[2] = { [1] = &gv };`,
`struct S s = { .a = 3, .p = &gv };`, `union U u = { .p = &gv };`): the walk (`irgen_agg_addr_walk`) drives
offsets with **two cursors** — one `cur` for arrays (`[k]=` sets `cur=k` directly, and each placed value
does `cur++`) and one `f` for structs (walked in declaration order, `.name` repositions to that member) —
and its semantics are exactly those of `ark_agg_fill()`, which fills the bytes. If the two cursors ever
disagree, the hook fails to find an entry at the offset the byte-filling side asks about,
`ark_agg_fill_ex()` returns -1 and rejects, so **the offset reconciliation is itself the safety net** and
nothing is silently zeroed. `union` allows only one active member (more than one is still rejected) because
it has only one offset.

A designator subscript must be an **integer constant expression** (C99 6.6p6), so `[0 + 1]` and
`[1 << 2]` fold; `[i]` (variable), `[]` (empty) and `[-1]` (negative) report
`a designator index must be an integer constant expression` / the same / `a designator index must not be
negative`. This used to accept only a bare literal (`lexer_peek(...).kind == TOK_NUM`); with a non-literal
it left `has_index` at 0 yet still did `expect "]"`, then recursed repeatedly on the misplaced token and
finally ended in `[arkcc] FATAL: memory pool exhausted` — a crash-level failure that violates "better an
error". The current `parse_designator_index()` reports one clear error when constant folding fails, skips
tokens up to the `]`, lets initialiser parsing continue, and fails the build via `error_count`.

**Forms that must be rejected (implemented; each reports an error and produces no image):**

- **Address of an automatic variable**: `static int *pa[2] = { &local, &gv };` — reports `is an address
  that is not a constant expression (C11 6.6p9)` (the object name in that message is the internal symbol
  name, e.g. `ark_sl_main_pa`);
- **Function + offset**: `int (*t[2])(int,int) = { add + 1, sub };` — same.

**String-literal elements are supported too** (`char *cs[2] = { "xy", "cd" };`): an element stores the
literal's **address**, not its characters. Each element needs an **independent** pooled-literal label named
after the element's byte offset — otherwise two elements point at the same string (`cs[1][0]` reads `'x'`
instead of `'c'`), a mistake that compiles, runs, and is only numerically wrong.

| Target | Label name | Data side |
| --- | --- | --- |
| ARM (Thumb-2) | `.L_gstr_<global id>_<offset>` | `LDR r0,=.L_gstr_<gi>_<off>` then `STR` |
| RV32I | `.Lgstr_<object name>_<offset>` | `.word .Lgstr_<name>_<off>` |

Note that the label naming follows each backend's **existing** prefixes (`.L_gstr_` with an underscore on
ARM, `.Lgstr_` without on RV); do not unify them — each shares its prefix with the scalar pooled literal of
`char *p = "hi";`, and renaming would collide.

**Narrow strings only**: `char *cs[2] = { L"xy", "cd" };` reports `is a wide string literal; only narrow
string literals can be pooled as address constants here` — a wide literal would have to be widened
byte-by-byte and the initialiser text does not carry that information. The designator form
(`{ [1] = "x" }`) works too, and **the label offset follows the designator**:
`char *cs[2] = { [1] = "x" };` pools to `.L_gstr_<gi>_4` / `.Lgstr_cs_4` (offset 4), not `_0` — writing
`_0` would still assemble and run, but `cs[1][0]` would read the wrong byte, which is why the RV assembly
assertion pins this case.

In the implementation, string elements and symbol elements **share the same `init_refs` table**: each entry
has either a `sym` or a `str` (`IrSymRef.str`), and the backend dispatches on lookup by offset. No parallel
table is needed and the offset reconciliation mechanism is reused unchanged.

**Function-pointer array declarators** are supported as well: in `int (*tab[2])(int,int);` the `[2]` sits
inside the parentheses (`(*tab[2])`), and the old parser did `expect ")"` directly after the name, reporting
`#18: expected a ")"`; now the array dimension inside the parentheses is parsed first (an integer constant
dimension only, else `the dimension of an array of function pointers must be an integer constant
expression`) and then the outer parameter list is attached to the pointer type.

Regression gate: `tests/run_agg_addr_tests.py` (32 runtime cases × 2 backends, cross-checked against the
host gcc, 9 of them brace elision; 8 "must be rejected" cases; 3 RV assembly assertions: `.word` `add` /
`.word sub`, the string case must contain two `.asciz` and two different `.word .Lgstr_cs_<off>`, and the
designator case must be `.word .Lgstr_cs_4` — guarding against three false greens that run but are wrong:
"folding the address into a number", "two elements sharing one label", "the subscript read but never
applied to the offset"). The trailing SELFCHECK verifies once each for `fp_array` (46), `str_ptr_array`
(240), `ptr_designator` (0) and `ptr_designator_gap` (17) that a wrong answer would be caught.

**Brace elision (C99 6.7.9p20) is supported**

Inner braces may be omitted; values fill the flattened layout in order:

| Form | Result |
| --- | --- |
| `int a[2][2] = {1, 2, 3, 4};` | `a[1][1] == 4` (the cursor must wrap to the next row once one is full) |
| `struct T { int a, b; } t[1] = { 1, 2 };` | `t[0].b == 2` |
| `struct T { int *p, *q; } t[1] = { &gv, &gv };` | each member gets an address |
| `char m[2][6] = { "ab", "cd" };` | one string per row (a string is itself one element) |
| `int x = { 5 };` | redundant braces around a scalar (C99 6.7.9p11) |
| `int a[][2] = { 1, 2, 3, 4 };` | infers 2 rows (from "values per element", not from the item count) |
| `struct B { int a:3, b:5; } x = { 1, 2 };` (block scope) | `a==1`, `b==2` (bitfields go through `IR_STORE_FLD`) |

Three walks must change together; miss one and you get "some forms work, some report an error":

- `src/agginit.c` (global data, text driven) and the two AST walks in `src/irgen.c` (global address
  elements `AaggWalk`, block scope `LocalAggWalk`) are all **one cursor per level, handing leftover values
  back to the caller once a subobject is full**: full means `return` (not an error), and the level that
  owns the closing brace checks for "values not consumed". Writing `return -1` would make
  `int a[2][2] = {1,2,3,4}` fail at the second row; writing "keep consuming the next level's values" would
  write 3 and 4 into `a[0]`.
- The struct branch `if (!f) return;` (a non-braced run hands back to the caller) and the block-scope
  `if (!braced) return;` are two spellings of the same rule; changing the local side to continue with
  `w->i++` would eat the caller's values and leave `t[0].b` at 0.
- In `ark_agg_object()` a string counts as "carrying its own level of braces" only when the **element type
  is an array**; an unconditional shortcut would make `struct S { char n[4]; } s[] = {"ab"}` fail with
  "missing braces".
- `walk` must **skip but not bail** on a string element (the bytes belong to `ark_agg_fill`), otherwise the
  case "the same aggregate has both strings and addresses" would never record the address.
- A block-scope string initialisation expands into a `memcpy` call, so the gate start-up (`ARM_START` /
  `RV_START` in `examples/run_va_gate.py`) must provide `memcpy` — without it such cases fail at link time,
  which amounts to never having tested them.

Boundaries still rejected (error, no image):

- **Designator + elided braces**: array top level `int a[2] = { [0] = 1, 2 };` (gcc rejects it too);
- **A string mixed with bare scalars in the same struct element, with the array dimension unspecified**:
  `struct S { char n[4]; int *p; } s[] = {"ab", &gv};` — how many values one element consumes depends on
  which member the string lands in, and guessing wrong means a wrong `sizeof`; better an error;
- **More than one value for a scalar**: `int x = { 5, 6 };` reports
  `has too many values: a scalar takes exactly one` (same at block scope);
  `double _Complex z = {3.0, 4.0};` reports `is a scalar; '{re, im}' is not a brace-elided form` — a scalar
  initial value can only be one expression, and GCC merely warns and drops the imaginary part, a wrong
  answer we do not copy;
- **Extra values for an array or struct**: block scope used to **silently discard** extra elements with no
  diagnostic at all; it now emits a GCC-style warning
  `excess elements in the initialiser are ignored: the array holds only 2` (`the object holds only N` for a
  struct), warns once, stays at `rc=0`, and **leaves the bytes written unchanged** (official accounting for
  the new diagnostic: host `text 556 740 → 557 100`, H743 firmware `text 438 812 → 439 060`). The global
  `int a[2] = {1,2,3}` still reports `cannot turn the initialiser ... into data` (a correct but not the most
  apt wording; a known item).

**struct/union (larger than 8 bytes) return values: both machine backends use sret (a hidden buffer pointer)**

| Target | Who allocates the buffer | In / out | First argument | Stack arguments |
| --- | --- | --- | --- | --- |
| ARM (Thumb-2, soft float) | caller frame (`r6`-relative offset) | passed in `r0`, returned in `r0` | `r1` | not shifted |
| RV32I (psABI) | caller frame | passed in `a0`, returned in `a0` | `a1` | shifted by one word |

The buffer is **one per call site**, not one per function and not one shared: `f(mk(1), mk(2))`,
`struct S a = f(), b = g();` and `mk(1).field` all require several results to be alive at once; sharing one
buffer would let the later overwrite the earlier, and putting the buffer below `sp` would let the callee's
own frame clobber it. Each buffer is **8-byte aligned** — the callee may use `STRD` to store `double` /
`long long` members, and an unaligned address faults outright on ARMv7-M.

**Whether a call site is sret is decided by bits in the `val` field of `IR_CALL`**: bit 36 = this call
returns a struct/union with `size > 8`; bits 37..52 = payload byte count (> 0xFFFF is an error in `irgen`,
never silently truncated). These bits are stamped by `irgen` from **the type of the call expression** (C99
6.5.2.2: the type of a call expression is the return type of the called function), so all three shapes
"visible at the call site, invisible in the definition" are automatically right:

- only declared, defined in **another translation unit**;
- called through **a function pointer** (the callee's name does not exist at the call site at all);
- appearing only in a forward declaration, never defined in this unit.

This path replaces the ARM backend's earlier approach of "scan this translation unit's function
definitions, build a name table, look up by name". The table lookup missed all three shapes above, so they
were emitted as the AAPCS default (**without** the hidden pointer) while the callee wrote through `r0` as
sret — measured in a cross-TU `tu1.s`, `BL mk` has no `ADD r0, r6, #N` in front of it and `r0` holds the
first argument `3`. RV32I's earlier approach was even more subtle: it put **an address inside the callee's
frame** into `a0`. Single-threaded, the caller `memcpy`s out immediately afterwards and the callee's stack
has not been reused yet, so it measured correctly (returning `struct S{a,b,c}` gives 345, 89 after
masking); but after the callee's `ret` that address is dead, and **an interrupt or signal reusing the same
stack reads stale data**. This debt has been implemented per psABI and retired.

Limit and diagnostics: each function has at most 64 sret call sites (`sret_call_buf_off[64]`); beyond that
it reports `sret call sites ... at most 64` instead of quietly allocating one buffer too few. Complex values
do not take this path (they return directly in `r0/r1/(r2/r3)` or `a0..a3`).

Gates:
- `python tests/run_rv_sret_tests.py --rv-as <bin>` — 13 RV32I cases actually executed (0/4/9 arguments,
  a by-value parameter, `f().m`, `f(g(),k())`, recursion, variadic, function pointer, same-depth stack
  reuse, a 160-byte payload) plus an expected-value self-check;
- `python tests/arm_exec/run_arm_exec.py --selfcheck` — ARM actually executed, where
  `sret_cross_tu` / `sret_indirect` / `sret_live_results` / `sret_recur` target the table above. Every case
  is recompiled once more with `--reg-top`, and the value must not change with the code path.

Gate: `python tests/run_complex_tests.py --arm-as <bin> --arm-libgcc <libgcc.a> --rv-as <bin>`, 38 cases × 2
targets (ARM and RV32I each assemble → link → really run under unicorn, comparing the **run exit code**
rather than "did it report an error"). The soft-float helpers (ARM `__aeabi_f2d`/`__aeabi_d2f`, RV
`__extendsfdf2`/`__truncdfsf2`) come from libgcc, so **the runtime library must be linked**.
Trimmed-build gate:
`python tests/run_complex_gate.py --arkcc <full binary> --arkcc-off <ARKCC_FEATURE_COMPLEX=0 binary>` —
verifies at once that "the full build accepts / the trimmed build rejects with a reason / the trimmed build
still accepts ordinary C / a source without `_Complex` assembles byte-for-byte identically in both builds /
`-fno-complex` reports an error".

## 5 Multi-backend architecture

### 5.1 Backend interface

File: [include/backend.h](../include/backend.h)

```c
typedef struct ArkBackend {
    const char *name;
    const char *triple;
    int pointer_size;
    int (*emit_asm)(IrProgram *m, char *out, int cap);
    int (*assemble)(const char *asm_text, unsigned char *out, int cap);
    int (*link)(unsigned char *code, int size, struct LinkContext *lc);
} ArkBackend;
```

- `emit_asm`: translates IR into textual assembly (or target C code), writes it into `out`, and returns the
  byte count.
- `assemble`: encodes textual assembly into machine code. The `c` backend passes the assembly text through
  to the host toolchain; `riscv32` emits GAS text and encodes it with its own flat-image assembler; `x86` /
  `x86_64` use their own encoders (`%N` operands are rejected, and an unknown mnemonic with a `rep` prefix
  likewise reports an error instead of emitting a bare prefix).
- `link`: relocates cross-function symbols (the ARM backend uses it to backfill `BL` offsets).

### 5.2 Implemented backends

| Backend | Directory | Entry symbol | Main purpose |
| --- | --- | --- | --- |
| `arm` | [src/backend/arm/](../src/backend/arm) | `ark_backend_arm()` | STM32 Cortex-M3/M4/M7/M33 (Thumb-2), full DWARF + TLS + Scatter |
| `x86_64` | [src/backend/x86_64/](../src/backend/x86_64) | `ark_backend_amd64()` | SysV AMD64: 8-byte pointers, `rdi rsi rdx rcx r8 r9` + `xmm0-7` + 8-byte stack slots, 0x400000 flat image; carries its own 64-bit encoder. Aliases `amd64`/`x86-64` |
| `x86` | [src/backend/x86_64/](../src/backend/x86_64) | `ark_backend_x86_64()` | i386 (32-bit, cdecl) GAS assembly; aliases `i386`/`i686`/`x86_64-msvc`/`x86-msvc` |
| `riscv32` | [src/backend/riscv32/](../src/backend/riscv32) | `ark_backend_riscv32()` | Emits RV32I assembly (GAS) |
| `c` | [src/backend/c/](../src/backend/c) | `ark_backend_c()` | IR -> readable C source (the main host-testing path) |

Registry: [src/backend/registry.c](../src/backend/registry.c).
Adding a backend means adding one registration line there. Aliases (`g_backend_aliases[]`) are resolved
only as a fallback after an exact match fails and do not occupy extra registration slots, so
`--list-backends` still shows each backend once and prints its aliases on the `aliases:` line.

### 5.3 Choosing a backend

```powershell
.\arkcc.exe --list-backends
.\arkcc.exe foo.c -target x86 -S -o foo.s
.\arkcc.exe foo.c -target x86_64 -S -o foo.s      # alias, equivalent to the line above
.\arkcc.exe foo.c -target riscv32 -S -o foo.s
.\arkcc.exe foo.c -target c -S -o foo.gen.c
```

`--list-backends` also prints each backend's aliases, for example:

```
Available targets:
  arm        armv7m-thumb2-eabi
    aliases: thumb, thumb2, cortex-m
  x86        i386-pc-linux-cdecl
    aliases: x86_64-msvc, x86-msvc, i386, i686
  x86_64     x86_64-unknown-linux-gnu
    aliases: amd64, x86-64
  riscv32    riscv32-unknown-elf
  c          host-c-source
```

An unknown backend name does `exit 1` directly and prints `[arkcc] unknown target '...'`.

### 5.4 CPU selection

The ARM backend can switch instruction set and default alignment by CPU name:

```powershell
.\arkcc.exe foo.c -target arm -mcpu=cortex-m7 --fpu=hard -S
.\arkcc.exe foo.c -target arm --cpu=Cortex-M4 --thumb -S
```

CPU selection lives in `include/cpu.h` + `src/cpu.c` and sets the corresponding predefined macros
automatically (see 9.5 for details).

### 5.5 Scatter description files

The ARM backend can parse armcc-style Scatter files (`.sct`); the implementation is in `include/scatter.h`
+ `src/scatter.c`. A Scatter file describes the physical and execution addresses of each section
(`.text`/`.data`/`.bss`/`.ark_heap`/`.ark_code` and so on), and is commonly used in embedded systems with
several memory regions (for example the DTCM / AXI SRAM / Flash partitions of an STM32H7).

**Currently supported**:
- ✅ Parsing `.sct` (`scatter_parse_file`) and GNU `.ld` (`linker_script_parse_file`)
- ✅ Conversion both ways: `.sct` ↔ `.ld` (in `-S` mode)
- ✅ Looking up an execution address by section name (`scatter_lookup_addr`,
  `scatter_get_er_base_for_section`)
- ✅ **Scatter-aware linking**: in `-link` mode it parses `.sct`/`.ld` → extracts flash_base/initial_sp →
  generates a 256-entry Cortex-M vector table → moves the code → adjusts symbol/relocation offsets
- ✅ Single-file `.bin` mode: `arm_link()` performs vector-table generation and offset adjustment
- Command line: `--scatter <file>`, `-T <file>`, `--linker-script <file>`, `--script <file>`,
  `--uvprojx <file>`

**Who actually places the sections?** On the armcc5 path armlink does it (through the `--scatter=<sct>`
option) and arkCC only emits assembly/object code. On the self-hosted path (arkCC running on an STM32
board, in `-link` mode or single-file `-c`/`-o .bin`), arkCC's own `arm_link()` parses the scatter file,
generates the Cortex-M vector table and performs the symbol/relocation offset adjustment, with the machine
code placed in `.ark_code` and routed to AXI SRAM by the scatter file.

### 5.6 Assembly files (`.s`/`.S`/`.asm`) as input

arkCC can compile `.s`/`.S`/`.asm` assembly files directly into machine code; the ARM backend has a full
Thumb-2 textual assembler (`arm_assemble()`):

```powershell
.\arkcc.exe startup.s -target arm -o startup.bin
.\arkcc.exe myfunc.S -target arm -c -o myfunc.ark_obj
.\arkcc.exe main_asm.asm -target arm -o main_asm.bin   # armasm / MSVC spelling, equivalent
```

**Trigger rule**: decided by file extension, accepting `.s`, `.S` (the traditional spelling) and `.asm`,
`.ASM` (the armasm / MSVC spelling), case-insensitively; the decision is centralised in `is_asm_input()`
(`src/compiler.c`). On a hit the front-end pipeline (preproc/lex/parse/sema/irgen) is skipped and
`be->assemble()` is called directly.

**Assembler capability**: two-pass assembly plus relocation, recognising
`.thumb`/`.thumb_func`/`.global`/`.section`/`.text`/`.data`/`.bss`/`.type`/`.size`/`.word` and similar
directives, and encoding Thumb-2 instructions as 16/32-bit binary.

**How it differs from `-S`**: `-S` is an **output** mode (generate assembly text), whereas a `.s` file
input is an "assembly → machine code" path. If `-S` is also given for a `.s` input, the assembly text is
emitted as-is (equivalent to a copy).

**Assembly errors are not silent**: on an unknown mnemonic, an illegal register operand, or an immediate
that cannot be encoded, the assembler prints `[asm-arm] error: ...` and exits non-zero, **writing no
output at all** (it internally emits NOP placeholders only to keep scanning subsequent lines, so one run
reports more than one error). That way "the assembly passed" is never an empty claim.

### 5.7 Object format (`-c` / `-link`)

`-c` produces an ARKOBJ2 container: `"ARKOBJ2\n"`(8B) + u32 code length + code body + u32 symbol count +
symbols (name_len/name/offset/type/weak) + u32 relocation count + relocations. Both C sources and assembly
sources go through this one writer, so the object format is identical on both paths.

Objects produced by `-c` from `.c` and `.s` inputs can be mixed and handed to `-link` directly:

```powershell
.\arkcc.exe a.c     -target arm -c -o a.ark_obj
.\arkcc.exe b.s     -target arm -c -o b.ark_obj
.\arkcc.exe -link a.ark_obj b.ark_obj -target arm -o ab.bin
```

Three rules at link time:

1. **Each translation unit places its own `.data`/`.bss`**, and the object declares the SRAM window it
   occupies using the reserved symbols `__arkcc_ram_start`/`__arkcc_ram_end` (`type=2`, value is an
   absolute address) at the tail of its symbol table. An older reader can simply ignore those last two
   entries; the header format is unchanged.
2. **Two objects that both carry a RAM window are an immediate error**: the data area does not participate
   in relocation, so as soon as `[start,end)` overlaps it prints
   `[link] error: SRAM overlap between objects #i and #j` and does `exit -8`, producing no image — because
   silently producing an image would give a broken binary with "two sets of globals stacked on the same
   address". With only one object carrying RAM (or none) linking proceeds normally.
3. **Duplicate definitions of compiler-private runtime symbols (names starting with `__`, such as
   `__aeabi_*`) are merged silently**, followed by one line
   `[link] note: N duplicate compiler-runtime symbols merged`; a user symbol with a duplicate strong
   definition is still warned about individually.

### 5.8 Base-address contract for multi-object linking (`--reloc-data` / `--reloc-text`)

arkc bakes the **absolute addresses** of `.data`/`.bss`/`.rodata` into the instruction stream
(`MOVW`+`MOVT`), so an object is only valid for the layout it assumed at compile time. The correct way to
link several objects is therefore not "compile ad hoc and let the linker sort it out":

```sh
# compile every object against the same .sct (data base = that .sct's +RW region)
.\arkcc.exe a.c -target arm --scatter app.sct --reloc-data --reloc-text --vector-table -c -o a.obj
.\arkcc.exe b.c -target arm --scatter app.sct --reloc-data --reloc-text -c -o b.obj
# link: --reloc-data moves b's data window after a and rewrites b's addresses;
#       --reloc-text fixes intra-section absolute addresses (string literals, etc.) object by object
.\arkcc.exe -link a.obj b.obj -target arm --scatter app.sct --reloc-data --reloc-text --vector-table -o app.bin
```

Both switches mean "**record the sites at compile time + rewrite by delta at link time**"; with them off,
the output is byte-for-byte unchanged (that is, the old behaviour).

- `--reloc-data`: makes **the second and later** objects each occupy their own SRAM range (8-byte aligned,
  placed after the previous one) and changes their `.data`/`.bss` addresses to the new base; at the same
  time it **chains the `__arkcc_init_globals` of all objects together** — otherwise duplicate-symbol
  merging keeps only the first copy and the later objects' initial values are never written (the symptom is
  globals stuck at 0 and a wrong answer with no error reported).
- `--reloc-text`: fixes, object by object, the absolute addresses inside the code section that point at
  **this object's own code / read-only data**. The first object keeps its original base, so single-object
  linking is unaffected.

**Base-address consistency is guarded**: if an object's declared SRAM window falls outside the scatter
file's `+RW` region — typically because `--scatter` was forgotten at compile time and the default
`0x20000000` is still in effect — `-link` no longer produces an image and instead reports

```
object #0 puts .data/.bss at 0x20000000 but the scatter file puts RW at 0x24072000: ...
```

That error is valuable: the corresponding bad image shows up on hardware as `CFSR=0x82` (`DACCVIOL`) and
`MMFAR=0x20000000` on the first write to a global. **It is only caught when exactly one object carries
RAM** (when both do, the overlap check already fails first), which is precisely the easiest case to miss.

The default values of the on-board `cc` follow the command line: whenever `-link` or `--scatter` appears,
`--reloc-data` / `--reloc-text` are **on** by default; `--no-reloc-data` / `--no-reloc-text` revert to the
old output.

### 5.x Flat images must link their own 64-bit/AEABI runtime

The backend inlines 64-bit add/sub as `ADDS`/`ADC` and `SUBS`/`SBC` (no runtime dependency); the remaining
64-bit operations (`*`, `/`, `%`, `<<`, `>>`, comparisons) emit the standard AEABI symbols
(`__aeabi_lmul`, `__aeabi_ldivmod`, `__aeabi_uldivmod`, `__aeabi_llsl`, `__aeabi_llsr`, `__aeabi_lasr`,
`__aeabi_lcmp`, `__aeabi_ulcmp`). **The compiler will not implicitly pack those implementations into the
image**, so a flat image must link them itself:

```sh
./arkcc -target arm -c stdlib/src/arm/aeabi.c          -o aeabi.obj
./arkcc -target arm -c stdlib/src/arm/aeabi_divmod.s   -o aeabi_div.obj
./arkcc app.c -target arm -c --vector-table -o app.obj
./arkcc -link app.obj aeabi.obj aeabi_div.obj --vector-table -o app.bin
```

`aeabi_divmod.s` must be assembly: `__aeabi_ldivmod`/`__aeabi_uldivmod` must return four registers
(quotient `r0:r1`, remainder `r2:r3`), and `__value_in_regs` is only parsed by this compiler, not honoured
in codegen. Division by zero returns 0; a shift count ≥ 64 returns 0 (arithmetic right shift fills with the
sign bit) — all explicit conventions, never random values.

Cost profile: `udivmod64` is a 64-iteration restoring division; measured, **one 64-bit division is about
12.8k instructions** (the whole `shift64` case is 9.26M instructions). That is a "correctness first"
choice, not a defect; where performance matters, avoid 64-bit division in inner loops.

---

## 6 Testing on Windows

### 6.1 Recommended flow: the C backend

The `c` backend translates IR into standard C source. This is the test channel **furthest from the
hardware and fastest to give feedback**, and it is strongly recommended for day-to-day development:

```powershell
.\arkcc.exe examples\struct_test.c -target c -S -o out.gen.c
gcc out.gen.c -o out.exe
.\out.exe
echo $LASTEXITCODE
```

`examples\run_tests.ps1` automates the steps above:

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1
```

**Gate scripts in the repository** (all are directly re-runnable and exit non-zero on failure; the numbers
are measured values from 2026-11-02):

| Gate | What it covers | Criterion | Measured |
| --- | --- | --- | --- |
| `run_full_test.ps1` | 73 samples: ARM emit + C-backend execution | the exit code of each sample must not be negative (a crash), plus an IR-generation gate self-check; a sample that by design cannot be emitted as one object must be recorded as `EXPECTED-FAIL` with the reason written out | `PASS=73 FAIL=0 CRASH=0` (the ARM side of `c99_armcc5_compat_test.c` is `EXPECTED-FAIL`: `errno`'s storage is defined in `stdlib/src/errno.c`, and a single-object image has no channel that carries another compilation unit's data address), `SELFCHECK irgen-gate: OK` |
| `examples\run_tests.ps1` | 75 samples: ARM emit + C-backend execution | the exit code must equal the sample's header `Expected exit code: N`; skips and passes are counted separately | `asserted pass 71 / failed 0 / skipped 4` |
| `run_asm_test.ps1` | the `.s/.asm` input path | artefact size + ARKOBJ2 header + byte-for-byte identity with the armasm golden bytes (including `BKPT` and three-operand `MUL`) + an unknown mnemonic and a three-register `MUL` must both fail | `pass=17 fail=0` |
| `run_tests_x86.ps1` | the `x86` / `x86_64` backends | emit succeeds, GAS accepts the syntax, the real aliases of `x86` (`i386`/`i686`/`*-msvc`) are byte-equivalent, `x86_64` **must not** be an alias of `x86` and its output must contain 64-bit registers, plus three negative controls | `pass=85 fail=0 skip=2` (the two SKIPs when `gcc` is not on PATH) |
| `tests/run_x86_64_image_tests.py` | `x86_64` execution level | the `main` return value of 35 programs equals a constant computed outside the program (including the three **static absolute addressing** anchors — initialised global arrays / string pointers / static function pointer table — and three anchors only exposed during self-hosting: `sizeof` of a member array, an `sret` copy, and pointer-array initialisation); one two-object `-c` + `-link` cross-TU case; an unresolved symbol must be refused with no image left behind; an expected value of +1 must be judged DIFF | `35 passed, 0 failed` (`make test-x86-64`), see 6.3.1 for details |
| `tests/run_x86_64_selfhost.py` | `x86_64` **self-hosting** | the compiler compiles its own 24 TUs into objects, links them into a flat image, runs it under unicorn, has it compile one more payload, and the artefact must be **byte-identical** to the host object (length + fnv-1a); the assembly text of the same payload is compared separately, to attribute any difference to code generation versus the assembler | `PASS self-host: byte-identical object` (2130 B / `fnv=28c333dc`), `make test-x86-64-selfhost`, see [X86_64_BACKEND.md](X86_64_BACKEND.md) §7.1 |
| `run_link_test.ps1` | `-c` + `-link` with several objects | ARKOBJ2 header, RAM descriptor, **the output is not a raw concatenation of objects**, image length == the sum of the two objects' code lengths, overlap must be reported with no artefact left behind | `pass=17 fail=0` |
| `run_arm_exec_test.ps1` | ARM **execution level** (compile → link → really run under QEMU) | the vector table SP/reset vector are legal (the reset vector must carry the Thumb bit), two different payloads return 8 and 3 respectively, and the negative control must be rejected; `exit 2` when QEMU is missing | `pass=13 fail=0` |

### 6.2 Verifying the ARM backend without hardware

**What is available on this machine** (the development box has no `arm-none-eabi-*`, WSL is disabled too,
and QEMU must be installed separately — see layer 4), so the ARM side relies on the following four layers,
all of which are re-runnable gates inside the repository:

1. **Assembly-level smoke test**: `examples/run_tests.ps1` runs `-target arm -S` on every sample, and any
   sample the backend cannot emit assembly for counts as a failure.
2. **Byte-exact evidence for the assembly encoding**: `run_asm_test.ps1` embeds a **golden byte string**
   obtained from armcc5 `armasm` for 22 instructions (TST/CLZ/SXTB/SXTH/UXTB/UXTH/SVC/MOVS/SADD16/BKPT/MUL,
   including high-register forms) and requires arkCC's binary output to match it byte for byte. How the
   evidence was obtained (reproducible):

```powershell
# Keil is installed in D:\Keil_v5 (not C:\Keil_v5); do not write the THUMB attribute on the AREA line,
# thumb is decided by the command line --thumb, otherwise you get A1221E.
& "D:\Keil_v5\ARM\ARMCC\bin\armasm.exe" --thumb --cpu Cortex-M4 ref.s -o ref.o
& "D:\Keil_v5\ARM\ARMCC\bin\fromelf.exe" -c ref.o    # --bin produces no file for ET_REL
```

   The hex column of the `fromelf -c` disassembly listing is the golden byte (little-endian halfword order).
   The check **does not depend** on whether Keil is installed on the machine, because the golden bytes are
   baked into the script.
3. **Assembly-input gate**: `run_asm_test.ps1` also verifies the artefact size for `.s` inputs, the
   ARKOBJ2 header, and that "an unknown mnemonic must fail loudly" (a negative control).
4. **Execution-level verification**: `run_arm_exec_test.ps1` compiles three objects (C start-up code / an
   assembly semihosting trap / a C workload) with `-c`, links them with `-link --scatter` into a bare
   image, and hands it to `qemu-system-arm` to **actually run**; the workload's result comes back as the
   semihosting exit code. The criteria are a legal vector table (SP=0x20040000, reset vector carrying the
   Thumb bit) plus two **different** payloads returning 8 and 3 respectively (a constant or ignoring the
   exit code cannot pass), plus a negative control (comparing against 9 must be judged a failure). When
   QEMU is missing the script does `exit 2` and prints `SKIP cannot verify`; it never turns green silently.

```powershell
$env:ARKCC_QEMU = 'D:\qemu\mingw64\bin\qemu-system-arm.exe'   # or use the -Qemu argument
powershell -ExecutionPolicy Bypass -File run_arm_exec_test.ps1
```

**Four hard facts about the QEMU side** (measured this round or confirmed from source):

- MSYS2's `qemu` package has **only** `qemu-system-*`, no user-mode `qemu-arm.exe`. Bare-metal execution
  needs system mode anyway, and `-machine mps2-an385` (Cortex-M3, code base 0) is enough:
  `-kernel <raw.bin>` places the bare binary at 0, together with
  `-nographic -semihosting-config enable=on,target=native`.
- **The Cortex-M semihosting trap is `BKPT 0xAB`, not `SVC 0xAB`**: QEMU routes SVC to semihosting only
  when `!ARM_FEATURE_M`, while M-profile goes through `trans_BKPT` with `imm==0xab`
  (`target/arm/tcg/translate.c`). The fixture `tests/arm_exec/sh_call.s` therefore uses `BKPT 0xAB`.
- **Addresses in the vector table must have the Thumb bit set**: exception entry loads EPSR.T from vector
  bit0, and an even address enters INVSTATE UsageFault and locks up immediately. A real STM32 vector table
  also holds odd addresses, so this is fixed in the compiler (`arm_link()` and `ld_build_vector_table()`),
  not in the fixture.
- The exit code uses `SYS_EXIT_EXTENDED(0x20)` + `{reason=0x20026, code}`; `SYS_EXIT(0x18)` degenerates to
  0 on some versions and cannot be used.

**Three compiler defects caught at this layer** (all fixed, with regressions in the corresponding gates):
① the vector table did not set the Thumb bit — no real board would ever boot; ② the assembler silently
encoded `SVC`/`BKPT` as 0 when the immediate had no `#` (`SVC 0xAB`); ③ the assembler parsed only two
operands for `MUL`, so `MUL r2, r2, r1` was encoded as `MUL r2, r2, r2`, making **every integer modulo
compute q\*q** (`308 % 61` returned 27 instead of 3).

**Remaining gap**: there is no STM32 hardware here, so the layer "burn the on-board artefact back into
Flash and jump to it" is unverified; the x86 side still does not run programs (MinGW `gcc -m32` can only
assemble, not link), see 6.3.

### 6.3 Testing the x86 / RISC-V backends

The `x86` backend emits **i386 (32-bit) cdecl** GAS assembly, not x86-64:

```powershell
.\arkcc.exe foo.c -target x86 -S -o foo.s
gcc -m32 -c foo.s -o foo.o    # only checks that GAS accepts it (MinGW here has no 32-bit CRT, so no link/run)
```

`-target x86_64` used to be an alias of the same backend; it is now an **independent SysV AMD64 backend**:
8-byte pointers, `rdi rsi rdx rcx r8 r9` + `xmm0-7` + 8-byte stack slots from right to left, a 0x400000
flat image (data accessed RIP-relative) and its own 64-bit encoder. The two byte outputs are no longer
identical, and there is no such thing as "equivalent" any more.

```powershell
.\arkcc.exe foo.c -target x86_64 -o foo.bin        # flat image, runs directly on a 64-bit core
.\arkcc.exe foo.c -target x86_64 -S -o foo.s       # look at the SysV assembly
```

**Execution-level verification**: `tests/run_x86_64_image_tests.py` (`make test-x86-64`) compiles 35
programs into 0x400000 images, runs `main` on unicorn's 64-bit core and asserts, one by one, a constant
**computed outside the program**; there are also two self-checks — an undefined external symbol must be
refused with no image left behind (otherwise `call foo` degenerates into `call +0`, the image calls itself,
and arkcc still exits 0), and "expected value + 1" must be judged DIFF.

**Self-hosting verification**: `tests/run_x86_64_selfhost.py` (`make test-x86-64-selfhost`) uses the x86-64
backend to compile the compiler's own 24 source files into objects, links them with the probes and a libc
stub into a flat image, **runs that self-hosted compiler** on unicorn's 64-bit core, and has it compile one
payload; the produced object must be **byte-identical** to the host arkcc object (currently 2130 bytes,
`fnv=28c333dc`). What it proves is "the backend covers the entire language subset / IR / assembler syntax
that the compiler itself uses", **not** "a compiler binary that runs directly on a real operating system
was produced" — the flat image has no ELF/PE header and no system-call layer, and both `main` and libc are
supplied by the probes. See [X86_64_BACKEND.md](X86_64_BACKEND.md) §7.1 for details.

**The execution-level gap on the i386 side**: MinGW's `gcc -m32` can only assemble, not link (no 32-bit crt,
and no `_main`/`_printf` prefixing), so i386 only reaches the layer "emit succeeds / GAS accepts the syntax
/ negative controls". It also had four historical defects (float `movq needs an xmm operand`, 64-bit
arithmetic `UC_ERR_EXCEPTION`, structs larger than 8 bytes passed by value giving wrong results, and **a
local array subscript reading the wrong element** — the 32-bit frame mapping was `[ebp-(48+off)]`, where
increasing frame offset means decreasing address while subscripts increase with address). In the x86-64
gate these are now judged against the same expected values, so a wrong i386 answer fails the case; see
[X86_64_BACKEND.md](X86_64_BACKEND.md) §5.

#### 6.3.1 Image load base and self-base relocation inside objects

A flat image (`-target x86_64 -o a.bin`) has no loader, so **the base address is baked in at compile
time**:

| Target | Image load base | Global references in code |
| --- | --- | --- |
| `x86` (i386 cdecl) | `0` | 32-bit absolute addresses (matching the reference arm, which mem_maps the image at 0) |
| `x86_64` (SysV AMD64) | `0x400000` | code/data accesses are RIP-relative (position independent), but **static absolute pointers** (`const char *msg = "hi";`, a static function pointer table, initialisers of the form `&g`) store `0x400000 + offset` |

i386 keeps base 0 so that the behaviour of the 32-bit reference arm stays unchanged in one place; the
`0x400000` of x86_64 is the same constant as `IMAGE_BASE` in `tests/run_x86_64_image_tests.py`. The ARM
side likewise bakes the flash base (`0x08000000`) into the image, with identical semantics — an absolute
address in a static initialiser **cannot** be made position independent, and writing the base down and
documenting it is more honest than leaving behind an illusion of "looks relocatable".

**Object mode (`-c` + `-link`)**: at link time an object body is concatenated after some base, so the
absolute references inside an object cannot be "image base + intra-object offset" but must be "**the
object's own base** + intra-object offset". In the implementation such sites are written with an
object-relative offset at `-c` time and marked with relocation type `X86_RELOC_SELF_BASE` (7); the linker
**when reading the object in** (when the base is known and the body is already in the output buffer) adds
the base in place directly and does not put it in the relocation table — so it is never judged an
"unresolved symbol", and local quantities do not need a global symbol name (naming them would pollute the
namespace and could collide into a duplicate strong symbol). An out-of-range site is `ARK_ERR_LINK` with an
explicit diagnostic and no image.

The three pitfalls hit on this path remain in the gate as anti-false-green anchors: `data_array_init`
(`int g[4]={1,2,3,4}`: `.quad` once wrote the high halfword as 0 ⇒ `{1,0,3,0}`), `rodata_ptr`
(`const char *msg="hello"`: a cross-object reference once left 0), `fptr_table` (a static function pointer
table: all entries once pointed at the image start), and `globals_two_objs` (cross-TU global data + a
string). The common root cause of the first three is that the x86 built-in assembler's **operand
pre-parser swallowed the whole line**, so directives (`.long/.quad/.byte/.word/.zero/.skip/.space/.asciz`)
were parsed starting from the end of the line ⇒ not a single byte was emitted, the label was in the right
place but had 0 bytes behind it; the `-S` text path goes through GAS and shows none of this, so it only
surfaces when an execution-level gate runs on the byte-level artefact of `-o`/`-c`.

```powershell
.\arkcc.exe foo.c -target riscv32 -S -o foo.s
riscv32-unknown-elf-gcc foo.s -o foo.elf    # install the matching toolchain yourself; not installed here
```

### 6.4 CI (continuous integration)

The repository has two pipeline configurations that do exactly the same thing: **build arkcc with the host
gcc → `pip install unicorn` → `make test`**.

| File | Platform |
| --- | --- |
| `.workflow/main-pipeline.yml` | Gitee Go (the `build@gcc` plugin, Ubuntu image) — the main line lives on Gitee, so this is the one that really runs |
| `.github/workflows/ci.yml` | GitHub Actions (`ubuntu-latest`), active only once mirrored to GitHub |

CI covers everything in `make test`: emit smoke tests for the four backends + four execution-level gates
(stdlib on unicorn ARM; build and run against the installation tree after `make install`; `--reloc-text`;
the x86-64 flat image). It does **not** cover: the PowerShell gates (Windows only), the cross-checks
requiring `arm-none-eabi-as` / `riscv32-unknown-elf-gcc` / `libgcc.a`, the byte-level diagnostic comparison
against a real armcc, `make stm32`, or on-board self-hosting. Any gate missing its toolchain prints
`SKIP: <measured reason>` itself; there is no `|| true` in the pipeline configuration, so a missing
dependency never becomes a green light. See [CI.md](CI.md) for details.

To that end nine `-o nul` occurrences in the Makefile became `-o $(NULLDEV)` (`nul` on Windows, `/dev/null`
elsewhere), and `test-x86` / `test-riscv` were hooked into `test` as well.

---

## 7 STM32H743 + Keil MDK project

The project lives in [mdk/STM32H743_ArkCC/](../mdk/STM32H743_ArkCC).

### 7.1 Project overview

| Item | Value |
| --- | --- |
| Chip | STM32H743VIT6 (Cortex-M7, 2 MB Flash, 1 MB SRAM, 480 MHz) |
| Compiler | **ARM Compiler 5 (armcc 5.06 update 7, build 960)**; armclang also works |
| Scatter | [Linker/STM32H743VITx_FLASH.sct](../mdk/STM32H743_ArkCC/Linker/STM32H743VITx_FLASH.sct) |
| Start-up file | [Startup/startup_stm32h743xx.s](../mdk/STM32H743_ArkCC/Startup/startup_stm32h743xx.s) |
| User program | [User/main.c](../mdk/STM32H743_ArkCC/User/main.c) |
| STM32 self-hosting entry | [port/stm32/main_stm32.c](../port/stm32/main_stm32.c) |
| Flash region | `0x08000000 0x00200000` |
| DTCM region | `0x20000000 0x00020000` (128 KB) |
| AXI SRAM | `0x24000000 0x00080000` (512 KB), holding `.ark_heap` + `.ark_code` + `.ark_buf` |
| armcc5 build script | [build_stm32_armcc.ps1](../build_stm32_armcc.ps1) |
| ARM backend only | to save Flash |

#### 7.1.1 Key armcc5 command-line options

`build_stm32_armcc.ps1` uses the following armcc5 options:

| Option | Meaning |
| --- | --- |
| `--cpu=Cortex-M7` | target CPU selection |
| `--thumb` | Thumb-2 mode |
| `-O0` | optimisations off (easier debugging) |
| `-g` | generate debug information |
| `--c99` | C99 mode (armcc5 defaults to C90; the arkCC sources need C99 mixed declarations) |
| `--apcs=interwork` | ARM/Thumb interworking ABI |
| `-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` | enable the minimal STM32 profile |

Key armlink option: `--scatter=<sct>`, with semihosting dependencies removed by the
`__user_initial_stackheap` redirection in `system_stm32h7xx.c`.

Project file list (organised as Keil "Source Groups"):

- **Application/User**: `main.c` `stm32h7xx_it.c` `stm32h7xx_hal_msp.c` `system_stm32h7xx.c` `bsp_w25q.c`
- **Application/Startup**: `startup_stm32h743xx.s`
- **ArkCC/Core**: `..\..\src\compiler.c` `lexer.c` `parser.c` `sema.c` `ir.c` `irgen.c` `ast.c` `type.c` `symtab.c` `memory.c` `preproc.c` `codegen_common.c` `cpu.c` `scatter.c` `config.c` `opt.c` `diag.c` `diag_msg_table.c`
- **ArkCC/Backend**: `..\..\src\backend\registry.c` `..\..\src\backend\arm\backend_arm.c`
- **ArkCC/Port**: `..\..\port\stm32\platform_stm32.c` `..\..\port\stm32\flash_fs_stm32.c`
- **Drivers/HAL**: placeholder headers live in `Drivers/CMSIS/Device/ST/STM32H7xx/Include/`

> Note: on the armcc5 path `port/stm32/main_stm32.c` does not take part in the build; MDK's
> `User/main.c` provides its own `main()`, which calls `ark_compile()` and then writes the generated
> machine code to the UART through `arkcc_on_output()`.

### 7.2 Five-step start-up

#### Route A: build from the armcc5 command line (recommended)

No Keil IDE needed; one PowerShell script does the whole build:

1. **Install Keil MDK 5.x (with armcc 5.06 update 7)**
   Make sure `D:\Keil_v5\ARM\ARMCC\bin\armcc.exe`, `armlink.exe`, `fromelf.exe` and `armasm.exe` exist and
   are on PATH (the script also probes that path automatically).
2. **Run the build script**
   ```powershell
   cd "<ark-cc-repo-path>"
   powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
   ```
   The script compiles 16 core `.c` files + 2 ARM backend + 2 STM32 port + 5 MDK user `.c` files + 1
   start-up `.s`, and links into:
   - `bootstrap_x86\armcc_objs\arkcc_stm32.elf`
   - `bootstrap_x86\armcc_objs\arkcc_stm32.hex`
   - `bootstrap_x86\armcc_objs\arkcc_stm32.bin`
3. **Flash the firmware**: use ST-Link Utility / Keil FlashTool / openocd to burn `arkcc_stm32.hex` to
   0x08000000.
4. **Prepare the source files on W25Q** (see [7.3 Burning files to W25Q](#73-burning-files-to-w25q)).
5. **Watch the output on the serial port**: connect PA9/PA10 at 115200 baud and you should see:
   ```
   === Ark C Compiler on STM32H743 ===
   Compiling /app/main.c from W25Q...
   Exit code: <int>
   ```

#### Route B: build in the Keil MDK IDE

1. **Drop in the official CMSIS / HAL**
   Overwrite the project's placeholder files with `Drivers/CMSIS/**` and `Drivers/STM32H7xx_HAL_Driver/**`
   from STM32CubeH7; then add the `stm32h7xx_hal_*.c` files you need to the `Drivers/HAL` group in Keil.
2. **Complete the initialisation code**
   Generate it with STM32CubeMX, or write the following functions by hand (under `User/`):
   - `SystemClock_Config` (480 MHz PLL)
   - `MX_GPIO_Init`
   - `MX_USART1_UART_Init` (115200 8N1, PA9/PA10)
   - `MX_SPI1_Init` (SCK PA5, MISO PA6, MOSI PA7, CS PA4)
   - add the MSP hooks in `stm32h7xx_hal_msp.c`.
3. **Prepare the source files on W25Q**
   See [7.3 Burning files to W25Q](#73-burning-files-to-w25q).
4. **Build and flash**
   Open `mdk/STM32H743_ArkCC/ArkCC.uvprojx` in Keil, Build -> Download.
5. **Watch the output on the serial port**
   Connect PA9/PA10 at 115200 baud and you should see:
   ```
   === Ark C Compiler on STM32H743 ===
   Compiling /app/main.c from W25Q...
   Exit code: <int>
   ```

### 7.3 Burning files to W25Q

W25Q128 needs a very small file index table + file data:

```text
0x000000   FileEntry[32]   each entry 32 B = char name[24] + uint32 offset + uint32 size
0x010000   /app/main.c     user source code
0x050000   /app/lib.h      ...
```

The `FileEntry` structure is in
[port/stm32/flash_fs_stm32.c](../port/stm32/flash_fs_stm32.c).

A minimal host-side script (Python, extend it as you like):

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
```

Then write the image into W25Q through ST-Link / the serial port (remember 4 KB sector erases).

### 7.4 Memory and buffers

arkCC uses three memory regions on the STM32:

| Section | Region | Size | Purpose |
| --- | --- | --- | --- |
| `.text` (with `.rodata`) | Flash @ 0x08000000 | ~148 KB | code (about 7.3% of Flash) |
| `.data` + `.bss` (DTCM) | DTCM @ 0x20000000 | ~19 KB | globals, stack (about 15% of DTCM) |
| `.ark_buf` + `.ark_code` + `.ark_heap` | AXI SRAM @ 0x24000000 | ~440 KB | large static buffers, code buffer, memory pool |

**Detailed AXI SRAM layout** (512 KB total, ~440 KB used, 72 KB left):

| Section | Size | Contents |
| --- | --- | --- |
| `.ark_buf` (compiler.o) | 160 KB | `g_src`(32K) + `g_asm`(64K) + `g_code`(32K) + `dep/ld/sct`(24K) + other(8K) |
| `.ark_buf` (memory.o) | 64 KB | the `g_pool` memory pool (originally 128K, halved to fit 512KB) |
| `.ark_buf` (preproc.o) | 64 KB | `g_inc_bufs`(4×8K=32K) + `out_buf`(32K) (reduced from 8×16K=128K) |
| `.ark_buf` (backend_arm.o) | 24 KB | `g_arm_syms`(12K) + `g_arm_relocs`(12K) |
| `.ark_code` | 32 KB | buffer for generated Thumb-2 machine code |
| `.ark_heap` | 32 KB | armcc5 C library heap (redirected via `__user_initial_stackheap`) |

**Key design: eliminating semihosting**
- Every semihosting dependency in the arkCC sources (`fopen/fread/fclose/vsnprintf/snprintf/getenv`, ...)
  has been removed or redirected:
  - `scatter.c` uses the `fs_read_file()` abstraction instead of `fopen/fread`
  - `irgen.c` has a custom `sb_putf` instead of `snprintf("%.17g")`
  - `scatter.c` has a custom `put_fmt` instead of `vsnprintf`
  - `backend_arm.c` uses the global flag `g_arm_dump_syms` instead of `getenv("ARKCC_DUMP_SYMS")`
- `system_stm32h7xx.c` provides the `__user_initial_stackheap` redirection that points the C library heap
  at `ark_heap_buffer`

**Buffer sizes adapt automatically**: [include/arkcc_config.h](../include/arkcc_config.h)
distinguishes `ARKCC_PROFILE_STM32_MIN` and `ARKCC_PROFILE_HOST_FULL` through the `ARKCC_PROFILE` macro, and
every large buffer size is chosen per profile. Adding `-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` on the
command line enables the STM32 configuration.

Before jumping to the generated code you must call `SCB_CleanDCache_by_Addr` + `SCB_InvalidateICache` (a
call template is in [User/main.c](../mdk/STM32H743_ArkCC/User/main.c)).

### 7.5 Debugger and serial port

- Debugger: ST-Link (Keil option `Debug -> ST-Link Debugger`)
- Serial port: USART1, 115200, 8N1, PA9-TX / PA10-RX
- Recommended tools: MobaXterm, Tabby, or any serial terminal

---

## 8 Code organisation and porting guide

### 8.1 File list

| Path | Purpose |
| --- | --- |
| [include/common.h](../include/common.h) | the main TokenKind / AstKind / IrOp enums |
| [include/platform.h](../include/platform.h) | `ark_log` / `ark_logf` / `ark_abort` |
| [include/flash_fs.h](../include/flash_fs.h) | `fs_read_file(path, buf, cap)` |
| [include/memory.h](../include/memory.h) | bump allocator |
| [include/lexer.h](../include/lexer.h) | lexical analysis |
| [include/ast.h](../include/ast.h) | AST nodes |
| [include/type.h](../include/type.h) | type system |
| [include/symtab.h](../include/symtab.h) | symbol table |
| [include/parser.h](../include/parser.h) | syntax analysis |
| [include/sema.h](../include/sema.h) | semantic analysis |
| [include/ir.h](../include/ir.h) | IR data structures |
| [include/irgen.h](../include/irgen.h) | AST -> IR |
| [include/backend.h](../include/backend.h) | backend interface |
| [include/preproc.h](../include/preproc.h) | preprocessor |
| [include/compiler.h](../include/compiler.h) | top-level entry `ark_compile` / `ark_compile_and_run` |
| [include/arkcc_config.h](../include/arkcc_config.h) | compile-time feature switches |
| [include/config.h](../include/config.h) | runtime configuration structures |
| [include/opt.h](../include/opt.h) | optimisation pass interface |
| [include/cpu.h](../include/cpu.h) | CPU selection (Cortex-M3/M4/M7/M33) |
| [include/scatter.h](../include/scatter.h) | Scatter description file parser |
| [src/main.c](../src/main.c) | PC command-line entry |
| [src/compiler.c](../src/compiler.c) | pipeline scheduling |
| [src/config.c](../src/config.c) | INI configuration loading |
| [src/opt.c](../src/opt.c) | IR optimisation passes (constant folding + DCE + inlining) |
| [src/cpu.c](../src/cpu.c) | CPU selection implementation |
| [src/scatter.c](../src/scatter.c) | Scatter file parser implementation |
| [include/diag.h](../include/diag.h) | diagnostics-layer interface (each stage includes only this header) |
| [src/diag.c](../src/diag.c) | diagnostic layout: style / source echo / caret / summary / suppression / limit |
| [src/diag_msg_table.c](../src/diag_msg_table.c) | code -> message template table (**generated**, see `tools/gen_diag_table.py`) |
| [src/backend/registry.c](../src/backend/registry.c) | backend registry |
| [port/stm32/main_stm32.c](../port/stm32/main_stm32.c) | STM32 self-hosting entry (replaces the PC `main.c`) |

### 8.2 Platform abstraction layer

Each target platform only has to implement two interfaces:

```c
/* platform.h */
void ark_log(const char *s);
void ark_logf(const char *fmt, ...);
void ark_abort(const char *msg);

/* flash_fs.h */
int fs_read_file(const char *path, char *buf, int cap);
```

Host side: [port/host/platform_host.c](../port/host/platform_host.c) / [port/host/flash_fs_host.c](../port/host/flash_fs_host.c); STM32 side: [port/stm32/](../port/stm32).

### 8.3 The STM32 self-hosting entry

`port/stm32/main_stm32.c` is the stand-alone entry on the STM32 side (replacing the PC's `src/main.c`).
It does three things:

1. reads the source file `/app/main.c` from the external W25Q Flash into a memory buffer;
2. calls `ark_compile()` to compile it into Thumb-2 machine code in the `.ark_code` section;
3. jumps to the generated machine code and writes its return value to the UART.

This entry needs no PC toolchain at all — once the Keil project has been built and downloaded, the user can
edit the `.c` file in W25Q and immediately recompile and run it.

### 8.4 Porting to another platform

Porting the compiler to Linux / an ESP32 / a RISC-V board only needs:

1. copy [port/host/](../port/host) to `port/<myplat>/`
2. change the output implementation in `platform_<myplat>.c` to the target's UART/syscalls
3. change the file-reading implementation in `flash_fs_<myplat>.c` to a local file system / SD card / network
4. write a `main_<myplat>.c` entry (model it on `main_stm32.c`)
5. add `port/<myplat>/*.c` to the build script

No file under `src/` has to be touched.

---

## 9 Extension development guide

### 9.1 Adding a keyword / token

In [include/common.h](../include/common.h):
1. add `TOK_XXX` to the `TokenKind` enum.
2. associate the string with `TOK_XXX` in `check_keyword()` in
   [src/lexer.c](../src/lexer.c).
3. if necessary, handle the token in
   [src/parser.c](../src/parser.c).

### 9.2 Adding an AST node

1. add `AST_XXX` in [include/common.h](../include/common.h).
2. add a field to the `AstNode.u` union in
   [include/ast.h](../include/ast.h).
3. implement the `ast_xxx_new(...)` constructor in
   [src/ast.c](../src/ast.c).
4. call the constructor from the corresponding production in
   [src/parser.c](../src/parser.c).
5. add the type checking in [src/sema.c](../src/sema.c).
6. translate it into IR in [src/irgen.c](../src/irgen.c).

### 9.3 Adding an IR instruction

1. add `IR_XXX` in [include/common.h](../include/common.h).
2. extend the switch case in each backend's `emit_asm`.

### 9.4 Adding a backend (mips as the example)

A 5-step template:

1. `mkdir src/backend/mips`
2. create `src/backend/mips/backend_mips.c`:
   ```c
   #include "backend.h"
   static int mips_emit_asm(IrProgram *m, char *out, int cap) { /* ... */ }
   static int mips_assemble(const char *s, unsigned char *o, int c) { /* ... */ }
   static int mips_link(unsigned char *c, int s, struct LinkContext *l) { return 0; }
   static const ArkBackend g_mips_backend = {
       "mips", "mips32-elf", 4, mips_emit_asm, mips_assemble, mips_link
   };
   const ArkBackend *ark_backend_mips(void) { return &g_mips_backend; }
   ```
3. declare `ark_backend_mips()` in [include/backend.h](../include/backend.h).
4. register it in [src/backend/registry.c](../src/backend/registry.c).
5. `make` picks it up automatically (the Makefile uses a wildcard).

Done: `arkcc foo.c -target mips -S`.

### 9.5 armcc compatibility extensions (the full v0.8.0 list)

v0.8.0 covers more than 98% of the commonly used armcc 5 extensions. The tables below list every supported
item.

#### 9.5.1 armcc keywords

| Keyword | Behaviour |
| --- | --- |
| `__svc(n)` | emits `SVC #n` |
| `__irq` | interrupt prologue `PUSH {r0-r3,r12,lr}` / epilogue `POP {r0-r3,r12,pc}` |
| `__weak` | `.weak <name>` |
| `__naked` | no prologue and no epilogue |
| `__packed` | the stand-alone keyword form + `__attribute__((packed))` + unaligned access through a `__packed` pointer |
| `__align(n)` | genuinely effective alignment control |
| `__at(addr)` | absolute address (same as `__attribute__((at(addr)))` / `#pragma location=`) |
| `__forceinline` | parsed (forced-inlining hint) |
| `__asm void fn() {...}` | whole-function assembly body (armcc style) |
| `__value_in_regs` | parsed (struct-return-in-registers hint) |
| `__pure` | parsed (side-effect-free pure-function hint) |
| `__interwork` | parsed (ARM/Thumb interworking hint) |
| `__thread` | thread-local storage (`.tbss`/`.tdata` sections) |
| `__global_reg` | parsed (global register variable hint) |
| `__smc` | parsed (SMC secure monitor call hint) |
| `__int64` / `__int32` / `__int16` / `__int8` | fixed-width integer aliases |
| `__typedef` | parsed (typedef-compatible prefix) |
| `__args` / `__return` | parsed (argument/return register binding hints) |
| `__tp_soft` | parsed (software thread pointer hint) |
| `__nothrow` | parsed (function does not throw hint) |
| `__deprecated` | parsed (deprecation marker) |
| `__may_alias` | parsed (alias-safe type hint) |
| `__softfp` | parsed (soft-float ABI hint) |

#### 9.5.2 `__attribute__` attributes

| Attribute | Behaviour |
| --- | --- |
| `section("name")` | emits a `.section` directive |
| `aligned(n)` / `packed` / `noreturn` | genuinely effective |
| `used` / `unused` | prevents trimming / suppresses the warning |
| `alias("target")` | function alias |
| `constructor` / `destructor` | emits `.init_array` / `.fini_array` |
| `deprecated` / `format(printf, ...)` | passed through |
| `may_alias` / `nothrow` | parsed (passed through to the backend) |
| `pure` / `const` | parsed (pure-function hint) |
| `visibility("default/hidden")` | parsed (visibility hint) |
| `nonnull` | parsed (non-null pointer argument hint) |
| `warn_unused_result` | parsed (the result must be used hint) |
| `sentinel` | parsed (trailing NULL sentinel on variadics hint) |
| `malloc` | parsed (allocation function hint) |
| `fastcall` / `stdcall` / `cdecl` | parsed (calling convention hints) |

#### 9.5.3 `#pragma`

| pragma | Behaviour |
| --- | --- |
| `#pragma pack(n)` | struct alignment control |
| `#pragma anon_unions` | anonymous union compatibility |
| `#pragma location=addr` | absolute address |
| `#pragma diag_suppress` | diagnostic suppression |
| `#pragma arm` / `#pragma thumb` | instruction-set switch hint |
| `#pragma import(__use_no_semihosting)` | disable semihosting |
| `#pragma push` / `#pragma pop` | compile-option stack |
| `#pragma O0` / `O2` / `O3`, `#pragma optimize` | optimisation-level hints |

#### 9.5.4 Predefined macros

| Macro | Value / meaning |
| --- | --- |
| `__ARMCC_VERSION` | armcc version number |
| `__arm__` / `__thumb__` | ARM/Thumb mode flags |
| `__arm` / `__thumb` | the underscore-less forms (armcc compatible) |
| `__TARGET_ARCH_7_M` / `__TARGET_ARCH_7E_M` | Cortex-M architecture flags (set by `-mcpu`/`--cpu`) |
| `__TARGET_FPU_VFP` | VFP flag (set by `--fpu=hard`) |
| `__BIG_ENDIAN` / `__LITTLE_ENDIAN__` | endianness |
| `__sizeof_int` / `__sizeof_ptr` | type sizes |
| `__STDC_VERSION__` | `199901L` |
| `__STDC_HOSTED__` | `1` (host) / `0` (embedded) |
| `__SIZE_TYPE__` / `__PTRDIFF_TYPE__` / `__WCHAR_TYPE__` | GCC-style type-size macros |
| `__EDG__` | EDG front-end compatibility flag |
| `__APCS_INTERWORK` | APCS interworking flag |
| `__FILE__` / `__LINE__` / `__func__` / `__DATE__` / `__TIME__` / `__STDC__` / `__ARK_CC__` | standard and project macros |

#### 9.5.5 Command-line options

| Option | armcc/gcc equivalent | Behaviour |
| --- | --- | --- |
| `-mcpu <name>` | gcc `-mcpu` | Cortex-M3/M4/M7/M33 and so on |
| `--cpu <name>` | armcc `--cpu` | same as `-mcpu` |
| `--thumb` / `--arm` | armcc | force Thumb / ARM mode |
| `--fpu <type>` | armcc `--fpu` | `soft` / `hard` |
| `-MMD` / `--depend` / `-MF <file>` | gcc | generate a `.d` dependency file |
| `--split_sections` / `-ffunction-sections` | armcc `--split_sections` | one section per function |
| `--dollar` | armcc `--dollar` | identifiers may contain `$` |
| `--enum_is_int` | armcc `--enum_is_int` | enum underlying type is int |
| `--signed_chars` / `--unsigned_chars` | armcc | default signedness of char |
| `--wchar16` / `--wchar32` | armcc | `wchar_t` width |
| `--dwarf2` / `--dwarf3` | armcc `--dwarf2`/`--dwarf3` | DWARF debug version |

---

## 10 Standard library subset

Directory: [stdlib/include/](../stdlib/include)

| Header | Provides |
| --- | --- |
| `stdint.h` | `int8_t..int64_t / uint8_t..uint64_t / intptr_t / uintptr_t` |
| `stdbool.h` | `bool true false` |
| `stddef.h` | `size_t NULL ptrdiff_t offsetof` |
| `stdarg.h` | `va_list va_start va_arg va_end va_copy ark_va_arg_d`. The two walking schemes are chosen by macros injected by the driver: C / x86_64 use 8-byte slots (`long long *`, indexed by argument number); ARM / RV32I use 4-byte word slots (`unsigned int *`, indexed by AAPCS argument words), where ARM rounds the pointer up to 8 bytes before a 64-bit argument to swallow the alignment hole, while RV32I (`__ARK_VA_PACKED_WORDS`) has no hole and therefore does no rounding. `_ark_va_ptr` is not defined as a variable on either backend; the frame address is computed directly at the point of reference |
| `string.h` | `strlen strcmp strcpy strncpy memset memcpy memmove` |
| `stdio.h` | `printf puts putchar` |
| `stdlib.h` | `abort exit malloc free` (declarations) |
| `math.h` | `sin cos sqrt pow fabs floor ceil fmod` + constants such as `M_PI` (implemented in `stdlib/src/math.c`) |
| `setjmp.h` | `jmp_buf setjmp longjmp` (the ARM implementation is `stdlib/src/arm/setjmp.s`: a real Thumb-2 function with `jmp_buf[0..7]=r4-r11`, `[8]=sp`, `[9]=lr`; a C wrapper cannot do it, because the sp/lr it sees belong to its own frame. `stdlib/src/setjmp.c` is only a portable simplified implementation for host testing, forwarding to the host `<setjmp.h>`) |

> With the `c` backend these functions route straight to the host libc; with the `arm` backend you have to
> provide implementations in the STM32 user code, link newlib-nano, or use the sources under `stdlib/src/`
> directly.

---

## 11 Frequently asked questions

**Q1: Why is the `.gen.c` emitted by `-target c` not nice human-readable code?**
A: the C backend translates from IR, not from the AST; it aims at "semantic equivalence", not "pretty
style". It is very well suited to regression testing.

**Q2: Can arkcc still run on Windows without gcc?**
A: building arkcc itself needs gcc / MinGW / MSVC. With MSVC you have to change the Makefile to use
`cl.exe`. VS Code + clangd is also a common choice.

**Q3: Can it compile an STM32 project written for Keil/MDK?**
A: v0.8.0 covers more than 98% of the common armcc extensions. The `__attribute__`, `__packed`, `__align`,
inline assembly, `#pragma pack/anon_unions/location/...`, `__irq`/`__weak`/`__naked` and the like found in
HAL/CMSIS are all supported. **The armcc5 path is fully wired up**: `build_stm32_armcc.ps1` can use armcc
5.06 to compile the arkCC sources directly into `arkcc_stm32.hex/.bin` for burning into an STM32H743 (see
[Appendix D](#appendix-d-armcc5-toolchain-and-the-mdk-build-in-detail)). A few extreme macro tricks and the
C++ mode are still unsupported; the recommendation is to compile HAL/CMSIS with the official compiler
first and then compile the application layer with arkcc.

**Q3.1: Can arkCC parse MDK `.sct` files?**
A: it can parse them, convert them both ways (`.sct` ↔ `.ld`) and **take part in actual section placement /
linking**. On the armcc5 path section placement is done by armlink from the `.sct` (see
[5.5](#55-scatter-description-files) and [Appendix D.5](#d5-sct-files-and-armlink)). On the self-hosted path
(arkCC running on an STM32, `-link` mode or single-file `-c`/`-o .bin`), `arm_link()` parses the scatter
file, extracts flash_base/initial_sp, generates the Cortex-M vector table and adjusts the
symbol/relocation offsets (see [5.5](#55-scatter-description-files)).

**Q3.2: Can arkCC compile `.s` assembly files?**
A: yes. The ARM backend has a full Thumb-2 textual assembler (`arm_assemble()`). It is triggered by file
extension: `.s`/`.S`/`.asm`/`.ASM` are all recognised as assembly input, skipping the front end and
assembling straight to machine code (see [5.6](#56-assembly-files-ssasm-as-input) for details).

**Q4: How do I make a compiled program call HAL on the STM32?**
A: through an external declaration + link relocation. The compiled code declares
`extern void HAL_Delay(uint32_t)`; at runtime the ARM backend linker backfills the target address of
`BL HAL_Delay` with the real address of the HAL function (an address table is required). A simpler approach:
hard-code those function addresses into an array and let arkcc call them through function pointers.

**Q5: Does the ARM backend use the FPU?**
A: yes. With `--fpu=hard`, or `fpu_hw=1` in `arkcc.cfg`, the ARM backend emits VFP instructions
(`VADD/VMUL/VCVT/VCMP`) directly instead of the `__aeabi_f*`/`__aeabi_d*` soft-float stubs; by default the
soft-float stubs are used for compatibility with Cortex-M3 parts without an FPU. `double` is always true
64-bit precision.

**The `double`↔`float` conversion is controlled separately by `-mcpu`** (independent of `--fpu`):
`-mcpu Cortex-M7` says the target has VFPv5-D16 and the conversion emits `VCVT.F64.F32`/`VCVT.F32.F64`
directly; with no CPU specified it emits `BL __aeabi_f2d`/`BL __aeabi_d2f`, which requires the runtime
library to provide those two symbols. On a bare-metal small program that does not link libgcc, the latter
reports `unresolved symbol "__aeabi_f2d"` at link time — add `-mcpu` rather than adding a soft-float helper
(see [3.2](#32-target-cpu-selection)).

**Q6: What do I do about "out of memory" when compiling a large file?**
A: the bump allocator defaults to 256 KB. You can raise `ARK_POOL_SIZE` in
[include/memory.h](../include/memory.h); or on the
STM32 side enlarge the `.ark_heap` section to 128 KB+ (note that the H743 AXI SRAM is 512 KB in total).

**Q7: Can it link across translation units like GCC?**
A: yes, only the object format is its own ARKOBJ2 rather than ELF. `-c` produces objects and
`-link a.obj b.obj` performs symbol merging, cross-object branch backfilling, the address rewriting of
`--reloc-text`/`--reloc-data` and the multi-object SRAM overlap check; RV32I has `-c`/`-link` too. What is
still unsupported: feeding ELF `.o` files directly (that would go through `arm-none-eabi-ld`), and, on
RV32I, cross-object branches and cross-TU function-pointer global initialisers (both report an error
clearly). See 5.7 / 5.8 and [12 Known limitations](#12-known-limitations) for details.

**Q8: Can GDB/LLDB read the DWARF debug information?**
A: v0.8.0 emits the full set of DWARF sections (`.debug_info`/`.debug_abbrev`/`.debug_line` +
`.file/.loc/.cfi_startproc/.size`), with the version selectable via `--dwarf2` or `--dwarf3`. Basic
line-level debugging is recognised by GDB; inspecting variable values (`-print var`) is not fully supported
yet.

**Q9: Does a `__packed` pointer really do unaligned accesses?**
A: yes. A `__packed` pointer (such as `__packed int *p`) generates byte-by-byte load-and-stitch code that
handles unaligned addresses correctly, covering 1/2/4/8 bytes (both ARM and RV32I handle all 8 bytes —
earlier ARM moved only the low 4 bytes of an 8-byte value, a silent short value, now fixed). An ordinary
pointer that violates alignment is undefined behaviour.

**Q10: How do I verify the compiler by self-hosting?**
A: the project provides the `bootstrap_build.ps1` self-hosting script: it uses arkcc to compile its own 24
source files into `.gen.c`, then gcc to compile those into `.o` and link `arkcc_bootstrap.exe`; you can then
compile arkcc with `arkcc_bootstrap.exe` once more, reaching a stable three-generation bootstrap
(bootstrap13/14/15). v0.8.0 has passed the full three-generation bootstrap verification.

The x86-64 side has an additional **execution-level** self-hosting gate: `make test-x86-64-selfhost`
(`tests/run_x86_64_selfhost.py`). It borrows no host C compiler: arkcc uses `-target x86_64 -c` to compile
its own 24 TUs into objects, `-link`s them into a flat image, runs **that self-hosted compiler** on
unicorn's 64-bit core, and has it compile one payload; only if the artefact is byte-identical to the host
arkcc object (2130 bytes, `fnv=28c333dc`) does it pass. It also compares the assembly text generated by the
self-hosted compiler line by line against the host `-S`, to tell "the difference is in code generation"
from "the difference is in the assembler" — the eleventh silent wrong answer of 2026-11-12 (`sizeof` of a
member array folded to 4) was narrowed from a 221-byte difference down to three characters of a symbol name
exactly by this comparison. Boundary: the image has no ELF/PE header and no system-call layer, so this gate
proves "the backend covers the compiler itself", not "a directly executable compiler binary was produced".

---

## 12 Known limitations

v0.8.0 implements the complete C99 set plus more than 98% of the common armcc extensions; only the
limitations below remain:

### Not supported at all

- **C++ mode** (`--cpp`): this project is a C99 compiler and does not parse C++ syntax such as
  `class`/templates/exceptions. That switch exists only to report `C++ (--cpp) is not supported` as an
  **error** and make the exit code non-zero — "telling you it is not done" and then exiting 0 is exactly
  the kind of silent wrong answer this project's diagnostics layer exists to eliminate.
- **ELF `.o` as link input**: `-c` produces its own ARKOBJ2 and `-link` only understands that format (to
  feed ELF you have to go through `arm-none-eabi-ld`).

> Auto-vectorisation is **not** in this table: it really is implemented, under `--vectorize` /
> `--no_vectorize` (on by default on the host, off in the board profile), it just covers only one loop
> shape — see "the two boundaries of auto-vectorisation" under "partially supported" below. Loops outside
> that shape simply get scalar code generation, not an error.

### Experimental (off by default)

- **Register allocation**: the stack IR currently gives every variable one stack slot by default; an
  experimental linear-scan register allocator can be enabled with `opt_regalloc=1`, and is off by default to
  keep things stable. Two frame rules on the ARM side: the save block is the anchor of the frame geometry —
  when the save block gets wider, the immediate of `[r6, #N]` (N ≥ the local-area upper bound) and of
  `MOVW/ADD r6` must shift together, and the save block width must stay a multiple of 8 (an odd count gains
  one spare `r8-r11` at zero byte cost), otherwise a variadic function reading the `r0-r3` mirror and the
  caller's stack arguments is shifted as a whole; `examples/run_va_gate.py --opt-suite` runs all five switch
  positions once and summarises the verdicts.

### Partially supported

- **The runtime library must be linked (soft float / 64-bit multiply-divide)**: the backend **no longer
  ships its own** AEABI helper routines such as `__aeabi_f*`/`__aeabi_d*`,
  `__aeabi_ldivmod`/`__aeabi_uldivmod` and `__aeabi_llsl` (there is a line-by-line note in
  [src/backend/arm/backend_arm.c](../src/backend/arm/backend_arm.c):
  the five home-grown versions `__aeabi_f2iz`, `__aeabi_fdiv`, `__aeabi_uldivmod`, `__aeabi_ldivmod`,
  `__aeabi_dadd` all measured as silently wrong). By the AEABI definition they belong to the target runtime
  library — `libgcc.a` in `arm-none-eabi-gcc`, `armlib` in armcc. Therefore: **an image that uses floating
  point, 64-bit division or 64-bit↔float conversion must link the runtime library**, otherwise linking fails
  with `undefined reference to __aeabi_...` (deliberately so, turning "computes it wrong" into "will not
  link"). RV32I is the same: soft float uses the `__adddf3`/`__muldf3`/`__divdf3`/`__eqdf2` family and
  64-bit multiply-divide uses `__muldi3`/`__divdi3`, and `libgcc` must be linked there too. Still built in:
  `__aeabi_memcpy` (struct assignment/argument passing/array initialisation all use it, and a freestanding
  target has no libc `memcpy`); 64-bit **add/sub** is inlined (ARM `ADDS/ADCS`, RV `sltu` carry chain) and
  needs no library. Hardware FPU mode (ARM `--fpu=hard`) replaces soft float with
  `VADD/VMUL/VCVT/VCMP`, and that dependency disappears as well.
- **RV32I inline assembly, `__svc`/`__smc`, and packed-lane arithmetic**: `asm("...")` is emitted as-is, and
  in the extended form (`asm("t" : outs : ins : clobbers)`) `%0..%3` become `a0..a3` (`r0..r3` on ARM) —
  neither backend **has an operand allocator**, so outs/ins/clobbers are discarded and operands have to be
  named explicitly in the template. `__svc(n)`/`__smc(n)` both compile to `li a7, n` + `ecall` on RV32I:
  the RV base instruction set has only one trap instruction and its number goes into `a7` per the RISC-V
  syscall ABI / SBI convention, so the two are indistinguishable on RV (on ARM they remain `SVC #n` /
  `SMC #n`). The `IR_SIMD_ADD16/SUB16/ADD8/SUB8` produced by auto-vectorisation is emulated exactly with SWAR
  on RV (per-lane signed wraparound, no saturation), at the cost of about 10 base instructions per lane
  operation. Gate: `python tests/run_rv_misc_ir_tests.py --rv-as <bin> [--arm-as <bin> --arm-libgcc <libgcc.a>]`.
- **The two boundaries of auto-vectorisation**: it only handles loops that are exactly "two `LOAD_IDX` + one
  `+`/`-` + one `STORE_IDX`, 1- or 2-byte elements, a trip count that is an integer multiple of the lane
  count"; `volatile` and `__packed` loops **do not** enter vectorisation. It is on by default on the host
  even at `-O0` (`ARKCC_FEATURE_OPT_VECTORIZE=1`), set to 0 in the board profile, and can be switched
  explicitly with `--vectorize` / `--no_vectorize`. This area once had a silent wrong answer: after
  widening, the element-narrowing `IR_TRUNC` was not removed, so only lane 0 of four survived and
  `char a[8]+b[8]` computed `{2,0,0,0,10,0,0,0}` (exit 0, no warning). Fixed — the target width of adjacent
  `IR_TRUNC`s is raised to 32 (i.e. a no-op). If vectorisation is ever changed again, re-verify with shapes
  other than `examples/test_vectorize.c`.
- **Cross-translation-unit linking (ARKOBJ2, not ELF)**: `-c` produces arkCC's own object container ARKOBJ2
  and `-link` only understands that format (`ELF .o` is unsupported). `-link` does symbol merging +
  relocation backfilling + a multi-object SRAM overlap check; data sections are by default **not** moved —
  so each object's `.data/.bss` must fall inside its own window, and when two objects both carry globals it
  reports an SRAM overlap and produces nothing rather than quietly stacking them; to move them, pass
  `--reloc-data` (the on-board `cc` turns it on by default whenever `-link` or `--scatter` appears), which
  places the second and later objects after the previous one at 8-byte alignment and rewrites the
  MOVW/MOVT sites in place, each still keeping one `.data` initialisation body while the images are joined
  into a call chain at the end. See 5.7 / 5.8. RV32I has `-c`/`-link` too (the object body holds already
  assembled machine code, not assembly text): everything inside an object is PC-relative, so it can sit at
  any image offset, and the linker merely concatenates at 16-byte alignment and backfills `RV_RELOC_AUIPC`
  (13) / `RV_RELOC_ABS32` (14); export boundaries are decided by `.globl`/`.weak`, and cross-object branches
  and cross-TU function-pointer global initialisers still report an error directly (see "RV32I object mode"
  in the README).
- **`%N` operands in x86 inline assembly are rejected**: the ARM backend roughly maps `%0..%3` to `r0..r3`,
  and x86 cdecl has no corresponding operand→register convention, so a rough mapping would silently produce
  wrong values; therefore the x86 backend reports an error and produces nothing when it finds `%0..%9` in the
  assembly text (`test_asm_operand.c` is the expected failure for this).
- **Incomplete IR generation counts as failure**: `irgen` accumulates `g_irgen_errors` when it meets an
  assignment target it cannot lower, and the driver sees a non-zero count, returns `ARK_ERR_IRGEN` and
  produces no image (previously it logged one line and pushed a 0, producing a silently wrong binary).
- **`sizeof(long double)` is 8**: this compiler uses the LLP64 data model (the same as the armcc default),
  so `long double` is 8 bytes like `double`, whereas it is 12 on a 32-bit x86 host GCC. Code that relies on
  `sizeof(long double)` to distinguish precision is not portable, and when comparing `sizeof` results across
  platforms you must judge by the target model, not the host model.
- **Bitfield width is capped at 32 bits**: `IR_LOAD_FLD`/`IR_STORE_FLD` read and write a 32-bit container,
  and `long long x:40` would read back a wrong value. So parsing reports an error directly
  (`bit-field width 40 exceeds 32`) and generates no code, never a silent truncation.
- **Aggregate initialisers only accept things that can become bytes (both machine backends share one
  implementation)**: global aggregate initialisation goes through `ark_agg_fill()` in
  [include/agginit.h](../include/agginit.h), which
  writes bytes in a type-driven way at the declared offsets, so it supports integer/character constants,
  string filling of `char` arrays (including row-wise forms like `char m[2][6] = {"ab","cd"}`), nested
  `{}`, `.field=` and `[idx]=` designators, and **address-constant elements**
  (`int (*tab[2])(int,int) = {add,sub};`, `char *cs[2] = {"xy","cd"};` — elements from which no number can be
  read and whose type is a pointer/function are handed to a backend hook and reconciled by offset against
  `IrGlobal.init_refs`, with string elements additionally getting one label per element offset in
  `.rodata`; see the section "Address elements inside aggregate initialisers"). **Any initial value that
  cannot be turned into bytes is an explicit error**: a **floating-point literal** inside an aggregate
  (`struct S{double d;} s = {1.5};` reports
  `the arm backend cannot turn the initialiser of the global 's' into data ...`), and any initial value not
  representable as a literal, is never replaced by a zero. `union` is supported: per C99 6.7.8p10 only
  **one** active member is taken (the first without a designator, `.f=` selects another, more than one
  member is still an error), and the member itself may be a pointer (`union U u = { .p = &gv };`) or a
  character array (`union U u = { .b = "abc" };`); bitfields are supported too
  (`struct B{int a:3; int b:5;} b = {1,2};` lands bit by bit, and arrays of bitfields likewise). Both
  backends call the same implementation, so ARM and RV32I produce the same bytes here — ARM's own earlier
  "walk by commas" parser skipped string elements and stored 0, turning every member of
  `struct Q gq = {3, "abcd", 9}` into NUL.
- **Block-scope `_Alignas` is capped at 8 bytes**: 16/32/64 are all errors
  (`block-scope _Alignas above 8 bytes is not supported`), because the frame only guarantees 8-byte
  alignment of `sp`; file scope and struct members have no such limit.
- **`va_arg` assumes a little-endian target**: the `va_arg` in `stdlib/include/stdarg.h` fetches values by
  "reinterpreting the slot address" (`*(type *)(...)`), which handles integers/pointers/`double` alike, but
  requires a little-endian target. ARM Thumb-2 and every host satisfy this; a big-endian target needs
  type-dispatched handling.
- **The two variadic mirror shapes cannot be mixed**: C/x86_64 use one 8-byte slot per argument (starting at
  `frame+8000`, the prologue mirrors a0..a7 into them, and `g_ir_va_slot_region` in `irgen` reserves 8064
  bytes); ARM / RV32I (and i386 cdecl) use 4-byte word slots and **do not mirror**: ARM pushes in the
  prologue the registers that "may still hold variadic arguments" `r_k..r3` (`k = NCRN` rounded down to an
  even number) so that they land exactly below the caller's stack argument block (word j in the region
  follows word j of the stack block, naturally contiguous), costing 16 / 8 / 0 bytes depending on the
  signature; RV32I drops a0..a7 into the 32 bytes at the bottom of the frame (using the slack `sp_size`
  already reserved), at address `s0 - sp_size + 4*k`. i386 cdecl (`-target x86`) is a third kind: the call
  site pushes every argument as one 4-byte word from right to left, and `_ark_va_ptr` is
  `ebp+8+4*param_count`, i.e. **the caller's own stack argument block**, also flat with no holes.
  `stdarg.h` selects the scheme via `__ARK_VA_WORD_SLOTS` and distinguishes "has an alignment hole (ARM)"
  from "flat (RV32I / x86)" via `__ARK_VA_PACKED_WORDS`. x86 was once left out of both, so it fell into the
  8-byte-slot default branch: the cursor advanced by 8 bytes while the region held 4-byte words, and
  `sum(3,10,20,30)` read 10, 30 and ran out of bounds (returning 40 instead of 60) with no diagnostic. It is
  now in the same class as RV32I and integer/pointer variadics measure correctly (the i386 reference arm of
  `tests/run_x86_64_image_tests.py` changed from 40/33/4/36/8 to 60/45/7/78/20); **`double` variadics still
  do not work on i386**, because it simply lacks an SSE double-precision path (assembly-time
  `movq needs an xmm operand`) — that is a reported rejection, not a wrong value.
  **The variadic frames of these two backends must stay small**: `irgen`'s 8064-byte reservation is turned
  off by the driver per backend (`g_ir_va_slot_region`), because a small program's task stack on the board
  is only 4 KB — an 8 KB mirror region was all green on the host and guaranteed to overflow on the board.
  `examples/run_va_gate.py` now asserts the frame size for every case (`FRAME_CAP = 1024`) and gives the same
  source to both gcc and arkcc→as→unicorn, comparing the **run result** rather than "did it report an
  error".
- **`_ark_va_ptr` is only meaningful inside a variadic function**: both backends report an error when it is
  referenced in a non-variadic function (it used to take the pointer from address 0 and silently produce a
  wrong answer).
- **ARM stack arguments have no count limit**: the va region is simply the caller's own argument mirror, so
  `va_arg` just walks up the stack arguments and no "are 28 words enough" check is needed. The cost is tiered
  by signature: one named argument word pushes 4 words (16 B, plus one `ADD sp, sp, #16` before returning),
  two or three push `{r2,r3}` (8 B), four or more named words push 0 bytes (the epilogue returns to an
  ordinary `POP {..,pc}`). A non-zero tier needs `POP {r5,r6,r7,lr}` followed by `BX lr`, because nothing can
  adjust the stack after `POP {.., pc}`. In `run_va_gate.py`, `arm/many_stack` uses 34 argument words (30 on
  the stack) to pin "no limit", four `asm/region` cases pin "which registers get pushed", and
  `arm/s2_ll` / `arm/s3_ll` / `arm/s4_int` pin that 64-bit and 32-bit reads are both right in the slimmed
  region.
- **Why `k` must be even**: the number of pushed bytes must be a multiple of 8, otherwise the top of the
  frame becomes 4 mod 8 and 8-byte locals or a GCC-compiled callee may go wrong. Note that "an odd k makes
  the region traversal wrong" is **false** — word j in the region is at `base+4j`, which is 8-aligned iff
  `(j-k)` is even, exactly AAPCS's "argument word is even", and that holds for any k. The gate's
  `frame_align_problems` turns this into a static assertion (the prologue's PUSH+SUB total must be a multiple
  of 8).
- **`float` arguments are promoted to `double`** (C99 6.5.2.2p6, `irgen` emits `IR_F2F`), so a variadic
  call's parameter width counts as 8 bytes; `irgen` sets the corresponding 8-byte bit in `argmask` as well.
- **RV32I's own boundaries**: it passes arguments only in a0-a7 and has no two-word value model, so calls
  with more than 8 argument words and 64-bit arguments are explicitly rejected instead of leaving a wrong
  value.
- **Structs passed through `...` are inlined word by word**: a struct larger than 8 bytes among the named
  parameters is passed as **an address word** (the callee's `IR_GETARG` memcpys using the size in the high
  bits of `aux`), but variadics differ — the callee has no types and `va_arg` only walks consecutive
  argument words, so the payload must be on the wire. The call site pushes `ceil(size/4)` words (word 0
  topmost), `aapcs_assign()` allocates word by word for arguments longer than two words (fitting into the
  remaining registers, the rest onto the stack), and the address is computed once with `IR_DUP`/`IR_SWAP`
  and finally discarded with `IR_POP`. Structs of 5..8 bytes still follow the old two-word rule. **ARM only**;
  the other three backends make `irgen` report an error
  (`passing a N-byte structure through '...' is implemented for the arm target only`).
- **Composites passed through `...` are made even by *alignment*, and 8-byte align-4 composites may be
  split**: the AAPCS32 even condition for NCRN is the argument **type's 8-byte alignment**, not its size.
  Measurement on `arm-none-eabi-gcc 12.3` gives decisive evidence: `struct A8{long long v;}` (8 B/align 8)
  starts at r2:r3, `struct A4{int a,b;}` (8 B/align 4) starts at r1:r2 without rounding, `struct
  B8{double;int;}` (16 B/align 8) rounds, `struct B4{4×int}` (16 B/align 4) does not, and `_Complex float`
  (8 B/align 4) does not. `irgen` therefore sets **bit 16** in `wires[i]` to mean "this argument needs
  8-byte alignment" (the low 16 bits are still the byte count); a variadic `float` has already been promoted
  to `double`, so this is judged by 8 rather than by `float`'s 4. `aapcs_assign()` consumes the alignment
  array `aligns[]` shared by caller and callee, and rounding is decided only by it (without that array it
  falls back to the old `size == 8` semantics). An 8-byte align-4 composite **is split** when only one
  register remains (word 0 → that register, word 1 → the stack), not all-or-nothing: the caller uses
  `POP {r7}; POP {r<reg>}; PUSH {r7}` to lift word 0 off the stack top while word 1 stays there, and the
  block copy then moves only word 1 to the stack slot per `asplit[]`.
  `stdarg.h`'s `ark_va__take` therefore now uses **`_Alignof(type) >= 8`** to decide "does this slot sit at an
  8-aligned position" (the old code used `sizeof(type) == 8`, which skips an extra slot for a type like A4
  that is 8 B/align 4, shifting everything when mixed with a gcc callee). Interoperability is pinned by
  `tests/run_arm_abi_mix_tests.py`: arkcc and `arm-none-eabi-gcc` each hold one side, unicorn runs the same
  image, and 16 cases (`a8/a4/b4/b8` × odd/even within three words, the `a4_split` split, and `b8_hole`
  holes between registers and the stack) pass in both directions, with a `SELFCHECK` — a deliberately wrong
  expected value must fail, otherwise the harness is declared unable to see a difference. `_Complex` through
  `...` is still rejected (see the next item), so there are no cases for that family.
- **Complex values do not go through sret and may not pass through `...`**: a 16-byte `_Complex double` uses
  the return registers (ARM `r0-r3`, RV32I `a0-a3`), and sret is reserved for struct/union with size > 8;
  passing a complex value through `...` is an error at the call site, because `va_arg` can only walk
  consecutive argument words and the callee has no type information. The full matrix is in 4.10.
- **`_Complex` really can be trimmed now** (`ARKCC_FEATURE_COMPLEX=0`): in the earlier `+15 560 B` board
  delta, the machine backends' four-word value path was compiled in unconditionally and only one bit flag,
  `IR_AUX_COMPLEX`, marked it; that bit is now stitched per build — with the gate off, `IR_AUX_COMPLEX`
  expands to the constant `0`, so every `I->aux & IR_AUX_COMPLEX` folds to `if (0)` and the whole block,
  together with the `arm_cplx_*` static helpers it calls, is discarded. Likewise `ARK_IS_CX(t)` expands to
  the constant `0` with the gate off, folding the `kind == TYPE_COMPLEX` comparisons in the 1700-line
  `irgen_expr` and the 3500-line `codegen_arm` away, without inserting 40 `#if`s. The remaining value-driven
  paths (the complex constant pool, the complex return shape `cplx_ret`, complex global initial values,
  `eval_const_cexpr`, `irgen_try_complex_init`) are wrapped directly in `#if`. With the gate off the parser
  **hard-errors** on `_Complex` (`is not available in this build: it was configured out`), so "TYPE_COMPLEX
  cannot occur with the gate off" is closed, and the folded blocks were unreachable anyway.
  - Measured (H743 firmware, `ARKRTOS_TEST`, `-DARKCC_FEATURE_COMPLEX=0` through `OPTFLAGS`, all other
    compile options unchanged): `text 438 812 → 424 988` (**−13 824 B**, FLASH 84.13% → 81.49%),
    `data 2 260`/`bss 463 532` unchanged.
  - Host x86-64 (all four backends compiled): `text 556 740 → 535 484` (−21 256 B).
  - ARM target set (same `STM32_CFLAGS` as the firmware, per-file `-c` then summing `size`):
    `246 554 → 232 926` (−13 628 B); per target `backend_arm.o −8 664`, `irgen.o −4 264`, `sema.o −608`,
    `parser.o −92`.
  - The difference against the historical `+15 560 B` (about 1.7 KB) is the **shared double-precision path
    and constant serialisation** — they also serve `double`, so the gate cannot remove them — plus the
    wiring of the `init_is_complex` field and the runtime diagnostic added this round (see the next item,
    +88 B). This document does not describe "−13 824" as "−15 560".
  - **Behaviour change**: the run-time `-fno-complex` used to **ignore** the `_Complex` keyword, silently
    turning `double _Complex z` into `double z` (a wrong answer); it now reports
    `` `_Complex` is switched off by the run-time configuration (complex=0) ``. That +88 B is deliberately
    new this round.
  - The default is still **1** (host / cross / board alike). Flipping the default is a behaviour change that
    must be released together with the measured sizes, so only the switch is provided here and the default is
    not changed.
  - Gate: `tests/run_complex_gate.py --arkcc <full> --arkcc-off <trimmed>` pins five things at once — the
    full build accepts `_Complex`, the trimmed build rejects it **with a reason**, the trimmed build still
    accepts ordinary C, a source without `_Complex` assembles **byte-for-byte identically** in both builds,
    and `-fno-complex` errors rather than ignoring (plus a "self-check of the self-check": ordinary source
    must not contain the trimmed build's message).
- **At most 64 arguments per call**: each backend's argument table stops at 64 and the 65th used to be
  silently dropped; now `irgen` reports an error. ARM's total argument-word limit is 192 (beyond that the
  backend reports an error instead of truncating).

### Compatibility notes

### Verification boundaries

- **ARM execution semantics**: verified by `run_arm_exec_test.ps1` on
  `qemu-system-arm -machine mps2-an385` (compile → link → really run → semihosting exit code, two different
  payloads giving 8/3); what is **still unverified** is the layer "burn the on-board artefact back into
  Flash and jump to it" (no hardware). Details in 6.2.
- **x86-64 execution semantics verified**: 35 cases really run `main` on unicorn's 64-bit core and assert
  independently computed constants, see 6.3 and [X86_64_BACKEND.md](X86_64_BACKEND.md).
- **i386 execution semantics unverified**: MinGW `gcc -m32` here can only assemble, not link; i386 only
  verifies emit / GAS syntax / negative controls, and its float, 64-bit arithmetic and large-struct-by-value
  passing still had historical defects, see 6.3.
- **`__at` / `__global_reg` degrade to comments in the `c` backend**: both are ARM-specific placement
  semantics, so the C backend emits `__at(addr)` as a comment and merely parses `__global_reg` (a hint
  keyword) without changing the generated code. Use `-target arm` for them to take effect.

- Some advanced optimisations (loop unrolling, loop-invariant hoisting, PHI merging, and so on) are not
  implemented yet; for performance-sensitive code, use `__forceinline` to control it manually.
- A few rare armcc builtins (the `__builtin_*` family) are not covered yet; use `__asm` inline assembly
  instead where needed.

---

## Appendix A: Internal data flow

```
source .c
   |
   v
+--------+      #include expansion, #define replacement, conditional compilation, trigraph replacement
| preproc|
+--------+
   |
   v
+--------+      characters -> tokens, line tracking
| lexer  |
+--------+
   |
   v
+--------+      recursive descent, builds the AST, all nodes allocated from the bump pool
| parser |
+--------+
   |
   v
+--------+      symbol table, type inference, redefinition/undefined detection
|  sema  |
+--------+
   |
   v
+--------+      AST -> stack-machine quadruple IR (target independent)
| irgen  |
+--------+
   |
   v
+--------+      optional: constant folding + dead code elimination + function inlining (src/opt.c)
|  opt   |
+--------+
   |
   v
+-----------+    choose CPU / Scatter / FPU / DWARF version
| backend.* |--- emit_asm  -> textual assembly / .gen.c
|           |--- assemble  -> 16/32-bit machine code (fully implemented for arm)
|           |--- link      -> BL relocation (arm)
+-----------+
   |
   v
.bin / .S / .gen.c / jump and execute directly (jump into the .ark_code section on the STM32)
```

---

## Appendix B: Glossary

| Term | Meaning |
| --- | --- |
| AST | Abstract Syntax Tree |
| IR | Intermediate Representation |
| Bump allocator | pointer-increment allocation, freed all at once, no fragmentation |
| Thumb-2 | the ARM 32-bit mixed-length instruction set, the main instruction set of Cortex-M3/M4/M7 |
| AAPCS | ARM Architecture Procedure Call Standard, the ARM calling convention |
| AXI SRAM | the 512 KB SRAM on the STM32H7 AXI bus, starting at `0x24000000` |
| Scatter file | the ARM Compiler linker script (`.sct`), defining the memory layout |
| TLS | Thread-Local Storage, corresponding to the `.tbss`/`.tdata` sections |
| DWARF | the standard debug information format, v2/v3 chosen by `--dwarf2`/`--dwarf3` |
| MSP | MCU Support Package, the hardware initialisation hooks of the STM32 HAL |
| FileEntry | this project's own minimal Flash file index entry (32 bytes) |
| APCS | ARM Procedure Call Standard, the earlier ARM calling convention |
| EDG | Edison Design Group, the vendor of the early armcc front end; `__EDG__` is the compatibility macro |

---

## Appendix C: Source and documentation encoding rules

To make collaboration across several operating systems and editors easy, this project adopts the following
conventions for file encoding:

### C.1 Documentation files

- All `docs/*.md` and `README.md` use **UTF-8** (without BOM).
- Documentation prose is written in Chinese, while code blocks and command-line examples stay as they are
  (English/ASCII).

### C.2 Source files

- All source files such as `src/**/*.c`, `src/**/*.h`, `include/*.h`, `port/**/*.c` use a
  **GB2312-compatible encoding**, i.e. **pure ASCII content**.
- Since pure ASCII is the common subset of GB2312 and UTF-8, this convention satisfies both kinds of editor
  view at once.
- **No non-ASCII byte may appear in source code** (including Chinese punctuation, full-width spaces, a UTF-8
  BOM, and leftover mojibake bytes).
- All source comments must be **pure English**. A tool check:

  ```powershell
  $files = Get-ChildItem -Recurse -Include *.c,*.h -Path src,include,port
  foreach ($f in $files) {
      $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
      foreach ($b in $bytes) { if ($b -gt 127) { Write-Host "Non-ASCII in $($f.FullName)"; break } }
  }
  ```

### C.3 Why it is specified this way

- The compiler itself, as the v0.8.0 self-hosting target, has to run in embedded environments such as the
  STM32, where the editors/terminals often do not support UTF-8; pure ASCII source guarantees readability
  and editability across platforms.
- Chinese documentation in UTF-8 is the norm for the Markdown ecosystem and for web rendering, so it
  displays correctly in GitHub, VS Code, Obsidian and similar tools.
- Keeping source comments in English avoids an editor mis-detecting the encoding, mangling the comments and
  then polluting merges, diffs, greps and other workflows.

---

## Appendix D: armcc5 toolchain and the MDK build in detail

This appendix explains in detail how to compile the arkCC sources on Windows with ARM Compiler 5 (armcc
5.06) into burnable STM32 firmware, and how to build the MDK project. The full tutorial is in
[docs/STM32_BUILD.md](STM32_BUILD.md).

### D.1 Toolchain preparation

| Tool | Location (default installation) | Purpose |
| --- | --- | --- |
| `armcc.exe` | `D:\Keil_v5\ARM\ARMCC\bin\` | compiling C sources |
| `armlink.exe` | same | linking |
| `fromelf.exe` | same | ELF → hex/bin conversion |
| `armasm.exe` | same | assembling the start-up file `startup_stm32h743xx.s` |

Confirm the armcc5 version:
```powershell
& "D:\Keil_v5\ARM\ARMCC\bin\armcc.exe" --version
# the output should contain "ARM Compiler 5.06 update 7 (build 960)"
```

If the tools are not on the system PATH, `build_stm32_armcc.ps1` probes the default paths above
automatically.

### D.2 One-command build

```powershell
cd "<ark-cc-repo-path>"
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
```

What the script does:
1. compile the 16 core `.c` files (`src/*.c`)
2. compile the 2 ARM backend files (`src/backend/arm/backend_arm.c` + `src/backend/registry.c`)
3. compile the 2 STM32 port files (`port/stm32/platform_stm32.c` + `port/stm32/flash_fs_stm32.c`)
4. compile the 5 MDK user files (`mdk/STM32H743_ArkCC/User/*.c`)
5. assemble the start-up file (`Startup/startup_stm32h743xx.s`)
6. armlink does the link and fromelf produces the `.hex` / `.bin`

Output directory: `bootstrap_x86\armcc_objs\`

| File | Purpose |
| --- | --- |
| `arkcc_stm32.elf` | full ELF (with the symbol table, for debugging) |
| `arkcc_stm32.hex` | Intel HEX format (for ST-Link Utility) |
| `arkcc_stm32.bin` | raw binary (for openocd) |
| `*.map` | link map file (memory layout analysis) |

### D.3 Building the MDK project (uvprojx)

To use the Keil IDE instead of the script:

1. open `mdk/STM32H743_ArkCC/ArkCC.uvprojx`
2. Project → Options for Target:
   - **Device**: STM32H743VIT6
   - **Target**: ARM Compiler 5 (note: the default may be V5.06; you can switch in Keil → Components →
     Manage → Project Components)
   - **C/C++**: tick C99, add the macro `ARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN`, and add
     `..\..\include;..\..\include\..\stdlib\include` to Include Paths
   - **Link**: point Scatter File at `Linker\STM32H743VITx_FLASH.sct`
3. Build → Build Target (F7)
4. Build → Download (F8) to flash it

### D.4 Common build errors

#### L6915E: The semihosting __user_initial_stackheap cannot reliably set up...

**Cause**: the armcc5 C library initialises heap/stack through semihosting by default, which conflicts with
scatter loading.

**Fix**: `system_stm32h7xx.c` already provides a `__user_initial_stackheap` redirection that points the C
library heap at `ark_heap_buffer` (AXI SRAM). Make sure that file takes part in the build and that it is
compiled with `--c99` rather than C90.

#### L6220E: Load region RW_AXI size exceeds limit

**Cause**: AXI SRAM (512 KB) overflow. The map file shows RW_AXI Size > 0x80000.

**Fix**: reduce the STM32-profile buffer sizes in
[include/arkcc_config.h](../include/arkcc_config.h):
- `ARK_POOL_SIZE` (default 64K)
- `PP_INC_BUF` × `PP_MAX_INC_DEPTH` (default 8K × 4 = 32K)
- `PP_BUF_SIZE` (default 32K)
- `ark_heap_buffer` ([User/main.c](../mdk/STM32H743_ArkCC/User/main.c), default 32K)

#### #268: declaration may not appear after executable statement

**Cause**: armcc5 defaults to C90 mode, which does not allow mixing declarations and statements.

**Fix**: `build_stm32_armcc.ps1` already passes `--c99`. When building in the Keil IDE, choose C99 under
Options → C/C++ → Language.

#### Undefined symbol arkcc_on_output

**Cause**: `flash_fs_stm32.c` calls `arkcc_on_output()` without a definition.

**Fix**: `flash_fs_stm32.c` already provides an `__attribute__((weak))` default implementation, and the user
can override it with a strong definition in `main.c`.

### D.5 .sct files and armlink

arkCC already implements **scatter-aware linking** (see [5.5](#55-scatter-description-files)):
- **armcc5 path**: arkCC itself does not take part in section placement; armlink places the sections from
  the `.sct` file;
- **self-hosted path** (arkCC running on the STM32, `-link` mode or single-file `-c`/`-o .bin`): `arm_link()`
  parses `.sct`/`.ld`, extracts flash_base/initial_sp, generates the 256-entry Cortex-M vector table, moves
  the code and adjusts the symbol/relocation offsets.

A typical `.sct` on the armcc5 path:

```text
LR_IROM1 0x08000000 0x00200000  {
  ER_IROM1 0x08000000 0x00200000 {        /* Flash: code + read-only data */
    *.o (RESET, +First)
    *(InRoot$$Sections)
    .ANY (+RO)
    .ANY (+XO)
  }
  RW_IRAM1 0x20000000 0x00020000 {        /* DTCM 128K: globals */
    .ANY (+RW +ZI)
  }
  RW_AXI 0x24000000 0x00080000 {          /* AXI SRAM 512K: large buffers */
    *(.ark_heap)
    *(.ark_code)
    *(.ark_buf)
  }
}
```

**Section-to-region mapping**:
- `.text` + `.rodata` → ER_IROM1 (Flash)
- `.data` + `.bss` → RW_IRAM1 (DTCM)
- `.ark_heap` + `.ark_code` + `.ark_buf` → RW_AXI (AXI SRAM)

arkCC marks section membership with `.section` directives when it generates assembly/objects; armlink routes
the contents to the right memory region based on those section names.

### D.6 Self-hosting verification: compiling an STM32 program on the STM32

Once the arkCC firmware is flashed, the target board reads `/app/main.c` from the W25Q Flash and compiles and
executes it in place. Verification steps:

1. prepare a test program, for example `/app/main.c`:
   ```c
   int main(void) {
       volatile int *led = (int *)0x48000014;  /* GPIOA ODR */
       *led = 1;  /* light the LED */
       return 42;
   }
   ```
2. use the host-side tool to write that `.c` into W25Q Flash (see [7.3](#73-burning-files-to-w25q)).
3. reset the STM32; the serial port should print:
   ```
   === Ark C Compiler on STM32H743 ===
   Compiling /app/main.c from W25Q...
   Exit code: 42
   ```
4. check whether the LED lights up.

---

For questions about this manual or the code, reading the sources one by one is welcome. By design no file
exceeds 1000 lines and the stages are independent, which makes "pick one module and read it on its own"
easy.

