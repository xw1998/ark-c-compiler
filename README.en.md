# Ark C Compiler

[中文](README.md) | English

A multi-target C99 compiler (plus a C11 subset: `_Static_assert` / `_Alignof` / `_Alignas` /
`_Generic` / `_Thread_local` / `_Atomic`, see [below](#c11-keywords-subset)). It builds and runs
with gcc on Windows / Linux / macOS, and it also **self-hosts natively on an STM32 (Cortex-M7)**:
it reads `.c` files from external SPI flash, compiles them in place, **and runs the result on the
same chip** (first end-to-end run 2026-11-05, see [milestones](#milestone-compiling-on-an-stm32-running-on-an-stm32)
and [`examples/stm32_selfhost_build/`](examples/stm32_selfhost_build/)).

It covers 98%+ of the commonly used ARM Compiler 5 (armcc) extensions (only C++ mode and advanced
optimisation are missing). **The STM32H743 + armcc5 toolchain path is complete**: compiling the
arkCC sources with armcc5 produces a flashable `arkcc_stm32.hex/.bin`; after boot the target board
reads `.c` sources from W25Q flash, compiles them in place and executes them.

## armcc5 full-compatibility roadmap

**Goal**: on a machine that has armcc5, arkCC is fully compatible with armcc5 — it can compile an
unmodified MDK project into an executable — and can then run on an STM32, i.e. compile STM32
programs on an STM32.

| Stage | Goal | Status |
| --- | --- | :---: |
| Stage 1 | arkCC itself compiled into STM32 firmware by armcc5 | ✅ done |
| Stage 2 | on-board arkCC compiles `.c` into a `.bin` | ✅ done |
| Stage 3a | on-board artifacts load and run on the board (RAM pool block borrowing, `mini run`) | ✅ done (2026-11-05) |
| Stage 3b | artifacts survive power loss (external QSPI NOR + littlefs) | ✅ done |
| Stage 3c | artifacts written back to **internal flash** and jumped to by the bootloader | ✅ done (2026-11-09, see [docs/STM32_BUILD.md](docs/STM32_BUILD.md) §15) |
| Stage 4 | unmodified MDK projects can be compiled directly by arkCC | ✅ done (`--uvprojx` extracts include paths and defines automatically; divide-by-zero protection in preprocessing) |
| Stage 5 | `__user_initial_stackheap`, HAL redirection, full scatter linking support | ✅ done (`__user_initial_stackheap` + `putchar`/`fputc` UART redirection + malloc/free + scatter-aware vector table generation) |

Build details for each roadmap stage are in [docs/STM32_BUILD.md](docs/STM32_BUILD.en.md) and
[docs/MANUAL.md](docs/MANUAL.en.md). To understand the implementation from scratch (rather than just
use it), read [docs/从零写一个C编译器.md](docs/从零写一个C编译器.md) — a 19-chapter textbook (Chinese
full text; [English summary](docs/from-scratch-c-compiler.en.md)): every
chapter has "goals / prerequisites / body / summary / exercises"; every assembly listing, byte and
size in the book was produced by actually running the thing, and the reproduction commands are in
the afterword.

## Milestone: compiling on an STM32, running on an STM32

The "everything on the board" line has five legs. **On 2026-11-05 it reached the end of legs ③ and
④ for the first time**, and the verdict was not "compilation succeeded" but characters that a
program running on the board printed over the serial port by itself.

| # | Milestone | Status | Board reading |
| --- | --- | :---: | --- |
| ① | arkcc itself built into STM32 firmware and running | ✅ | see [docs/STM32_BUILD.md](docs/STM32_BUILD.md) |
| ② | on the board, turn one `.c` into machine code (`.bin`) | ✅ | `cc hello.c` |
| ③ | **several `.c` → one loadable image → execute on the board** | ✅ 2026-11-05 | `make` emits `app.svcm` of 4776 B; `mini run` prints `ARKMAKE: link ok` / `ARKMAKE: cross-file add3=6` |
| ④ | artifacts survive power loss (external QSPI NOR + littlefs) | ✅ | artifacts live in `/mnt/nor`, still there after reset, and can be `mini run` directly |
| ⑤ | artifacts written back to **internal flash** and jumped to by the bootloader | ✅ 2026-11-09 | `app flash write /tmp/m5.bin` → 1452 B / crc `0x612B4A1E` lands at `0x081E0000` and reads back byte-for-byte; `app flash run` prints `M5 alive in flash`, log entry `0x081E0424` is inside the flash region; **after a reset** `/tmp` is empty and the same artifact still runs (the "survives power loss" verdict) |

Leg ③ deserves its own section because it rules out three classes of failure that **look like
success**:

- **a translation unit silently dropped at link time** — the image still links, it is just missing
  that TU. The verdict is that the cross-TU call really returns a value (`add3(1,2,3)==6`), not
  "it compiled".
- **the object being moved by the linker** — arkcc bakes absolute addresses into instructions at
  codegen time (`movw/movt` pairs, literal slots), and only external symbols are relocations. The
  old recipe "reserve a 0x400 vector table up front, then shift the whole image right" measured
  out as string pointers being 0x400 too low: **the image loads, prints nothing, and exits
  immediately**. Now the first object reserves a hole, `-link` only fills the table, and nothing is
  ever shifted.
- **the premise of the four-pass diff not holding** — if the linked result depends on the base
  address, then the byte differences between the four images are not "displacement caused by
  addresses" and the diff table would fold optimisation differences away as addresses. The verdict
  is that the four passes are byte-identical in size (all four rows `A/B/C/D` equal).

The minimal reproducible example is in
[`examples/stm32_selfhost_build/`](examples/stm32_selfhost_build/): two sources + one project
description + one `make` + one `mini run`, with five verdicts and "known limits" (4-source ceiling,
pool budget, unstable timing). The project-description layer comes from
[`ark_make`](https://gitee.com/xw19981010/ark_make), and `make`'s packing callback *is* `cc --pack`
— an image is only allowed one way of being produced, otherwise "what was verified on the board"
and "what make emits" will diverge sooner or later.

## Features (v0.8.2)

### C99 language features

| Area | Support | Notes |
| --- | :---: | --- |
| Basic types | yes | `void/char/short/int/long/long long/_Bool/float/double` + `signed/unsigned` |
| Pointers and arrays | yes | 1-D / multi-D arrays, pointers, function pointers, array decay; array dimensions accept constant expressions `int arr[SIZE+2]` |
| Variable-length arrays (VLA) | yes | `int a[n]` runtime-sized arrays, allocated on the stack via `IR_ALLOCA`; rounded up: 8 on ARM / x86_64, 16 on RV32I (the psABI requires 16-byte sp alignment before every call), and the RV32I epilogue rebuilds sp with `sub sp, s0, frame` before popping the frame whenever the function contains `IR_ALLOCA` — otherwise `return` reads `ra/s0` from the wrong place |
| Composite types | yes | `struct`/`union`/`enum`/`typedef`, bit-fields (really packed bit by bit), flexible array members `data[]`, anonymous struct/union field promotion |
| Complex types | yes | `_Complex double` / `_Complex float`: arithmetic, arguments, return values, implicit conversions and static initialisers all work; a 16-byte `_Complex double` return uses r0-r3 on ARM and a0-a3 on RV32I (soft-float AAPCS, **not sret**, interoperable with gcc callees); the x86 backends reject it explicitly, and passing it through `...` is rejected explicitly too. Details in `docs/MANUAL.md` §4.10 |
| Wide characters | yes | `wchar_t` + `L"..."` wide strings + `L'...'` wide character literals; width switched by `--wchar16`/`--wchar32` |
| Trigraphs | yes | all 9 C99 trigraphs (`??=`->`#`, `??(`->`[`, `??/`->`\`, `??)`->`]`, `??'`->`^`, `??<`->`{`, `??>`->`}`, `??!`->`|`, `??-`->`~`) |
| Qualifiers | yes | `const/volatile/restrict/inline` |
| Storage classes | yes | `static/extern/auto/register`; `static` at block scope persists; `__thread` (armcc) / `_Thread_local` (C11) thread-local storage |
| Control flow | yes | `if/else/while/for/do-while/switch/case/default/break/continue/goto/label/return` |
| Operators | yes | all C99 operators (arithmetic / comparison / short-circuit logic / bitwise / shifts / compound assignment / conditional / comma / sizeof / casts) |
| Functions | yes | many parameters (>4 go on the stack; scalar, 64-bit and struct parameters are assigned per AAPCS32: even register pairs, 8-byte alignment on the stack, numbering by the number of words actually transferred), prototype checking, variadic `...` (supported by all four backends; ARM / RV32I use 4-byte word slots, C / x86_64 use 8-byte slots — see §Backends and `examples/run_va_gate.py`), recursion, separate compilation + linking of multiple files |
| Literals | yes | integers (decimal/octal/hex + suffixes), characters + escapes, string concatenation, floating point |
| Floating point | yes | `float/double` arithmetic / comparison / conversion; the ARM backend supports a hardware FPU (VFP `VADD/VMUL/VCVT/VCMP`) or `__aeabi_f*`/`__aeabi_d*` soft-float stubs, and `double` is true 64-bit precision |
| 64-bit integers | yes | the full `long long` set: arithmetic / comparison / bitwise / unary minus / `++` / `--` / compound assignment / shifts (`__aeabi_l*` + `__aeabi_llsl/llsr/lasr` stubs); shifts and bitwise ops take the **left** operand width per C99 6.5.7; `printf` arguments are not truncated; stack 64-bit arguments are low word first, 8-byte aligned, per AAPCS |
| Division/modulo | yes | signed/unsigned `__aeabi_idiv/uidiv/idivmod/uidivmod` |
| Implicit conversions | yes | the full usual arithmetic conversions + integer promotions |
| Initialisation | yes | scalars, aggregates `{1,2,3}`, nested `{{1,2},{3,4}}`, designated initialisers `.x=1/[2]=5`, strings `char s[]="hi"`, non-literal global initialisers (constant-expression folding) |
| Compound literals | yes | `(int[]){1,2,3}` / `(struct P){.x=1,.y=2}` |
| Structs by value | yes | implemented with a hidden pointer parameter |
| Register allocation | optional | `-fopt-regalloc` (`ARKCC_FEATURE_OPT_REGALLOC`, host/cross 1, on-board 0, off by default): a post-emission text pass moves the hottest frame slots into `r8-r11`, and only slots where "every mention is `LDR r0,[r6,#n]` / `STR r0,[r6,#n]`" are moved; taking an address, `volatile`, and 8/16/64-bit accesses all stay in memory. On the hot case (`char pad[200]` pushes later locals past offset 124) `[r6,#]` references drop 22→13, and two negative cases stay byte-identical. Two cost models: the default only moves far slots and a **function never grows** (25 `.c` files of the H743 self-host project: −2398 B, −0.21%, no file grows); `-fopt-regalloc-near` / `--fregalloc-near` (implicitly enabling the base tier) also moves near slots, cutting stack accesses from 27 372 to 15 108 at the cost of 150 extra bytes and 14 files growing; **frame geometry**: the save block is the anchor — when it widens, the `[r6, #N]` immediates (N ≥ local area upper bound) and the `MOVW/ADD r6` immediates must shift together, and the save block must stay a multiple of 8 (an odd count automatically gets a spare `r8-r11`, at zero byte cost), otherwise a variadic function's `r0-r3` mirror and the caller's stack arguments all shift. Five tiers (default / `-O2` / regalloc / `-O2+regalloc` / `-O2+regtop+inline+regalloc`) run in one go via `examples/run_va_gate.py --opt-suite` |
| Assembler coverage | yes | all LDR/STR addressing modes (`[Rn]`/`[Rn,#imm]`/`[Rn,Rm]`/`[Rn,Rm,LSL #0..3]`/`[Rn,#imm]!`/`[Rn],#imm`, `[sp,#imm]`, `[pc,#imm]`), `VLDM/VSTM/VPUSH/VPOP`, `LDMFD/STMFD/LDMEA/STMEA` aliases, `ADDW/SUBW`; forms that do not exist in the architecture (`LDMIB/LDMDA/STMIB/STMDA`, register-indexed writeback) are explicit errors |
| Preprocessing | yes | object/function macros (`#/##`), `#if/#elif/#else/#endif/#ifdef/#ifndef/#undef/#error/#warning/#pragma`, nested `#include` (<=8 levels), `__VA_ARGS__`, `-I` paths, trigraph replacement |
| Comments | yes | `//` and `/* */` |

### C11 keywords (subset)

Only these six keywords are implemented; the rest of C11 (`<threads.h>`, `_Atomic` applied to
composite types, anonymous-struct-member variants, etc.) is out of scope and produces an ordinary
syntax error instead of being waved through as "probably works".

| Keyword | Support | Notes |
| --- | :---: | --- |
| `_Static_assert(expr[, "msg"])` | yes | works at file scope, block scope and inside structs; `expr` is folded **during parsing** by `eval_const_expr`, and a non-integer-constant expression is an error (`static assertion whose truth we cannot decide` is never let through); when the condition is 0 the `msg` is printed verbatim in the diagnostic |
| `_Alignof(type-name)` | yes | folded from the **type** (not from an expression's "default int" — `sizeof` once answered wrongly on that path); only the type-name form is accepted, `_Alignof(expr)` is an explicit error rather than a guess |
| `_Alignas(type-name)` / `_Alignas(const-expr)` | yes | at file scope any power of two (64 verified to take effect, and the flat ARM SRAM layout also honours `align_bytes` instead of always aligning to 4), on struct members (sets `align_override`, `sizeof` 32 / `align` 16 verified), at block scope ≤ 8 bytes (8 verified); it **never weakens** natural alignment (C11 6.7.5p6: `_Alignas(2) double` is still 8-aligned); non-powers of two and non-constants are errors |
| `_Generic(ctrl, type: expr, ..., default: expr)` | yes | the controlling expression gets the C11 6.5.1.1p2 treatment: lvalue conversion + array decay + **function-designator decay** (`f`, `&f`, `*f` all land on the function pointer type); **no integer promotion** (`char` stays `char`); no match and no `default` → error (returning 0 would be a fabricated answer), duplicate `default` → error; after selection sema squashes it into an ordinary expression, so downstream stages (irgen / global initialisers / every backend) never see it |
| `_Thread_local` | yes | same storage as `__thread` (bit `0x10000`), but validated per C11 6.7.1p4: at file scope it requires `static`/`extern`, cannot modify a function, cannot appear in a `typedef`, and cannot be combined with `auto`/`register`; **armcc's bare `__thread` stays exempt** (`examples/test_tls.c` relies on that). The four diagnostics are ordered most-specific-first, so `_Thread_local int f(void);` reports "applies to objects, not functions" instead of a generic storage-class error |
| `_Atomic` | yes (with limits) | both the qualifier and `_Atomic(type-name)` parse; `_Atomic` goes through `type_atomic()` into `Type::is_atomic` (a shallow copy plus a flag, so singletons are not polluted), which means atomicity **propagates through typedefs** — after `typedef _Atomic int atomic_int;` the object `atomic_int x;` is still atomic. It decides three things: which `<stdatomic.h>` implementation is used, which types are rejected outright, and that `sema` rejects every read-modify-write (`x += 1` / `x++` are errors per C11 6.5.16.2p3 / 6.5.2.4p2 and name `atomic_fetch_*`; `x = 5` is fine, that is one atomic store). Arrays / functions / `struct`·`union` are rejected per C11 (the array case cites 6.7.2.4; composites need a lock, so it refuses instead of pretending to access atomically). Real atomicity exists only on ARM (PRIMASK critical sections); on the other four targets **every atomic operation is a compile-time error**, failing as the undeclared identifier `__arkcc_atomic_<op>_not_supported_on_this_target_use_a_mutex` — it never silently degrades into a plain access. See [docs/ATOMIC.md](docs/ATOMIC.md) |

Block-scope `_Alignas(16/32/64)` is an **error**, not a silent downgrade: the frame is built as
`sp -= N; base = sp`, AAPCS only guarantees 8-byte `sp` alignment, and really supporting 16/32/64
would mean changing prologue/epilogue and dealing with the conflict where the variadic sequence
uses `r5` to hold the old `sp`. The choice here is "rather an error than a wrong answer".

The **semantic boundary** of `_Thread_local` must be stated: the `.tbss`/`.tdata` machinery is only
emitted on the hashed loading path of `ARKCC_FEATURE_ARMCC_KEYWORDS`, so **in a flat bare image
(`--vector-table`) TLS variables are ordinary `.data`/`.bss`** — they live in SRAM and are zeroed by
`__arkcc_init_globals()`; on a single-threaded bare-metal target the value semantics are correct,
but that is not thread-pointer relocation. The C backend emits `__thread` verbatim and leaves it to
the host gcc. Execution-level evidence: `tls_static_init` / `tls_block_static` / `tls_reject` in
`tests/arm_exec/run_arm_exec.py`.

The **semantic boundary** of `_Atomic` needs the same care. `stdlib/include/stdatomic.h` has two
branches: on ARM targets, load/store of 32-bit types are plain accesses (an aligned single-word
access on a single core is indivisible by itself), while `exchange` / `compare_exchange` and the
five RMWs go through `__arkcc_crit_save` / `__arkcc_crit_restore` (`MRS PRIMASK` + `CPSID i`)
critical sections; types that do not fit in a word (`long long`, `double`) route even load/store
through the critical section, and comparison is two-word equality rather than AEABI's vector
equality. Memory order is always `seq_cst` (critical section + the compiler barrier
`__memory_changed`), and **this is single-core interrupt-level mutual exclusion**: cross-core and
cross-DMA visibility is not its job — DMB orders accesses but does not fix cache coherency. On
non-ARM targets (x86 / x86_64 / riscv32 / c) everything except `atomic_init` (which is just an
assignment) and the typedefs is a compile-time error, with the reason written into the name. Three
explicitly stated gaps: `int *_Atomic p` (qualifier after the `*`) is unsupported; read-modify-write
through a pointer such as `*p += 1` is not caught (`is_atomic` does not propagate through
dereference — use `atomic_fetch_add(p, 1)`); `lock xadd` / `cmpxchg16b` on `x86_64` are not wired
up. Gates: `tests/run_atomic_tests.py` runs five targets × (target-identity macros, 11 atomic
operations that must be rejected, `atomic_init` that must compile), and
`tests/arm_exec/run_arm_exec.py`'s `atomic_rmw` / `atomic_nested_mask` / `atomic_wide` /
`atomic_reject` really execute the critical sections and the 64-bit path on unicorn.

### ARM Compiler 5 (armcc) compatibility extensions

#### armcc keywords

| Extension | Support | Emits |
| --- | :---: | --- |
| `__svc(n)` | yes | `SVC #n` |
| `__irq` | yes | interrupt prologue `PUSH {r0-r3,r12,lr}` / epilogue `POP {r0-r3,r12,pc}` |
| `__weak` | yes | `.weak <name>` |
| `__naked` | yes | no prologue/epilogue |
| `__packed` | yes | standalone keyword form + `__attribute__((packed))` + unaligned access through a `__packed` pointer (byte-wise load-and-stitch, 1/2/4/8 bytes; both ARM and RV32I do the full 8 bytes instead of only moving the low 4) |
| `__align(n)` | yes | alignment control that actually takes effect |
| `__at(addr)` | yes | absolute address (same as `__attribute__((at(addr)))` / `#pragma location=`) |
| `__forceinline` | yes | parsed (force-inline hint) |
| `__asm void fn() {...}` | yes | whole-function assembly body (armcc style) |
| `__value_in_regs` | yes | parsed (struct-in-registers return hint) |
| `__pure` | yes | parsed (side-effect-free hint) |
| `__interwork` | yes | parsed (ARM/Thumb interworking hint) |
| `__thread` | yes | thread-local storage (`.tbss`/`.tdata` sections) |
| `__global_reg` | yes | parsed (global register variable hint) |
| `__smc` | yes | parsed (SMC secure monitor call hint) |
| `__int64`/`__int32`/`__int16`/`__int8` | yes | fixed-width integer aliases |
| `__typedef` | yes | parsed (typedef compatibility prefix) |
| `__args`/`__return` | yes | parsed (argument/return register binding hints) |
| `__tp_soft` | yes | parsed (software thread pointer hint) |
| `__nothrow` | yes | parsed (no-exception hint) |
| `__deprecated` | yes | parsed (deprecation marker) |
| `__may_alias` | yes | parsed (alias-safe type hint) |
| `__softfp` | yes | parsed (soft-float ABI hint) |

#### `__attribute__` attributes

| Attribute | Support |
| --- | :---: |
| `section` | yes |
| `aligned`/`packed`/`noreturn` | yes |
| `used`/`unused` | yes |
| `alias("target")` | yes |
| `constructor`/`destructor` | yes |
| `deprecated`/`format(printf,...)` | yes |
| `may_alias`/`nothrow` | yes |
| `pure`/`const` | yes |
| `visibility("default/hidden")` | yes |
| `nonnull` | yes |
| `warn_unused_result` | yes |
| `sentinel` | yes |
| `malloc` | yes |
| `fastcall`/`stdcall`/`cdecl` | yes |

#### `#pragma`

| pragma | Support |
| --- | :---: |
| `#pragma pack(n)` | yes |
| `#pragma anon_unions` | yes |
| `#pragma location=addr` | yes |
| `#pragma diag_suppress` | yes |
| `#pragma arm/thumb` | yes |
| `#pragma import(__use_no_semihosting)` | yes |
| `#pragma push/pop` | yes |
| `#pragma O0/O2/O3`, `#pragma optimize` | yes |

#### Inline assembly

| Form | Support |
| --- | :---: |
| `asm/__asm__` inline assembly | yes — basic form + extended form (operands/constraints/clobbers); fully transparent on the C backend, passed through as text on the ARM backend |

### armcc-compatible predefined macros

| Macro | Value |
| --- | --- |
| `__ARMCC_VERSION` | armcc version number |
| `__arm__` / `__thumb__` | ARM/Thumb mode flags |
| `__arm` / `__thumb` | underscore-less forms (armcc compatibility) |
| `__TARGET_ARCH_7_M` / `__TARGET_ARCH_7E_M` | Cortex-M architecture flags |
| `__TARGET_FPU_VFP` | VFP flag |
| `__BIG_ENDIAN` / `__LITTLE_ENDIAN__` | byte order |
| `__sizeof_int` / `__sizeof_ptr` | type sizes |
| `__STDC_VERSION__` | `199901L` |
| `__STDC_HOSTED__` | `1` (hosted) / `0` (embedded) |
| `__SIZE_TYPE__` / `__PTRDIFF_TYPE__` / `__WCHAR_TYPE__` | GCC-style type macros |
| `__EDG__` | EDG front-end compatibility flag |
| `__APCS_INTERWORK` | APCS interworking flag |

### Code generation

| Feature | Support |
| --- | :---: |
| 32-bit immediates MOVW/MOVT | yes |
| Integer division SDIV / `__aeabi_idiv` | yes |
| 64-bit arithmetic `__aeabi_lmul/ldiv` | yes |
| Soft-float `__aeabi_f*` (single precision) | yes |
| Soft-float `__aeabi_d*` (double precision, `double` is true 64-bit) | yes |
| Hardware FPU instructions (VFP `VADD/VMUL/VCVT/VCMP` replacing the soft-float stubs) | yes |
| VLA dynamic stack allocation `IR_ALLOCA` | yes |
| `.data/.bss/.rodata` section separation | yes |
| Bit-field pack/unpack | yes |
| Compiling assembly files directly | yes (the ARM backend has a full Thumb-2 text assembler; triggered by the `.s`/`.S`/`.asm`/`.ASM` extensions, case-insensitive) |
| Strict AAPCS (>4 arguments on the stack) | yes |
| `setjmp/longjmp` support | yes |
| `.init_array`/`.fini_array` (constructors/destructors) | yes |
| Unaligned access through a `__packed` pointer | yes (1/2/4/8 bytes read and written byte-wise; for 8 bytes the low word is assembled and pushed, then the high word is assembled and pushed, matching the push order of the aligned path) |
| Full DWARF debug info (`.file/.loc/.cfi_startproc/.size` + `.debug_info`/`.debug_abbrev`/`.debug_line`) | yes |
| TLS thread-local storage (`.tbss`/`.tdata`) | yes |
| `--split_sections`, one section per function (`.text.fn`) | yes |
| Scatter loading-description parsing (`include/scatter.h` + `src/scatter.c`) | yes (parsing + scatter-aware linking + vector table generation; see the table below) |
| CPU selection (`-mcpu`/`--cpu`, `include/cpu.h` + `src/cpu.c`) | yes |
| Multi-object data-section relocation `--reloc-data` (`.arkdata` markers + link-time MOVW/MOVT rewriting) | yes (off by default; when off, the old behaviour of reporting an SRAM overlap is kept) |
| In-section absolute-address fixup at link time `--reloc-text` (`.arktext` markers + the object's own `__arkcc_text_base`; the linker computes the displacement per object) | yes (off by default; when off the output is byte-identical to older versions. It fixes code addresses baked into `MOVW/MOVT`, such as string literals) |
| On-demand runtime emission `--rt-lazy` (only reachable `__aeabi_*` blocks) | yes (off by default; `add3.c` 1578 → 60 bytes) |
| IR stack top in r0 `--reg-top` (bounded registerisation, not an allocator) | yes (off by default; 80 sample instructions −7.1%) |
| Explicit `float` ↔ `double` conversion (`VCVT.F32.F64` / `VCVT.F64.F32`) | yes |
| Floating-point constant-expression folding (`eval_const_fexpr` + `fconst_to_int`) | yes — two landing points: explicit conversion to an integer type (`(int)(2.5*4.0)`, `enum {E=(int)(1.5+1.5)}`, `int a[(int)(2.0*3.0)]`) and implicit conversion of global/static initialisers (C99 6.6, `int g = 2.5*4.0;`). NaN/infinity/out-of-range **is not folded** — it errors instead of inventing a value; `int a[2.5]` and `int a[(int)(1.0/0.0)]` report `array dimension is not an integer constant expression` instead of silently taking one element |
| Assembler extended instruction set `--asm-extra` (`ANDS`/`ORRS`/…/`MRS`/`MSR`, 32-bit and pre-decrement forms of `LDM`/`STM`, `TBB`/`TBH`, `LDRD`/`STRD` — 24 mnemonics plus `.W`/`.N` suffixes) | yes (off by default; when off they are unknown mnemonics. `ADDS`/`SUBS` are not on this list: the backend emits them itself, so they are unconditionally accepted — GNU as would assemble `ADD` without `S` as a 32-bit `ADD.W` and silently drop the flags) |
| Capacity limits (full on host / trimmable on board) | yes (`include/arkcc_config.h` §9, one definition with two sets of defaults, each item overridable with `-D`; anything over the limit is an error, never a silent drop) |

### `.sct` / `.s` support matrix

| Capability | Status | Notes |
| --- | :---: | --- |
| Parse `.sct` (scatter) files | ✅ | `scatter_parse_file()` (`src/scatter.c`) |
| Parse GNU `.ld` scripts | ✅ | `linker_script_parse_file()` (`src/scatter.c`) |
| `.sct` → `.ld` conversion | ✅ | emitted only in `-S` mode, `scatter_to_ld_script()` |
| `.ld` → `.sct` conversion | ✅ | emitted only in `-S` mode, `scatter_to_sct_file()` |
| Look up an execution address by section name | ✅ | `scatter_lookup_addr()` + `scatter_get_er_base_for_section()` |
| Actual section placement/linking with `.sct` | ✅ | scatter-aware: `-link` mode parses `.sct`/`.ld` → extracts flash_base/initial_sp → generates a 256-entry vector table → moves code → adjusts symbols/relocation offsets |
| Compile `.s`/`.S` assembly files | ✅ | `arm_assemble()`, a complete Thumb-2 text assembler, triggered by extension |
| Compile `.asm`/`.ASM` files | ✅ | equivalent to `.s`/`.S` (`is_asm_input()`, case-insensitive) |
| Output name when compiling `.asm`/`.ASM` | ✅ | without `-o` it derives `.bin` from the same name (same as `.s`) |
| `--scatter <file>` command-line option | ✅ | parsed in `-S`/`-link`/`-c` modes; participates in vector table generation in `-link` mode |
| `-T <file>` / `--linker-script` option | ✅ | same as `--scatter`; a GNU `.ld` script is converted into the internal scatter representation |
| `--uvprojx <file>` option | ✅ | automatically extracts `<IncludePath>`/`<Define>` from an MDK `.uvprojx` as `-I`/`-D` |

### Standard library subset

| Source file | Provides |
| --- | --- |
| `stdlib/src/printf.c` | a compact `printf` (`%d/%u/%x/%X/%s/%c/%p/%%` + width/zero padding, 64-bit `long long` not truncated) |
| `stdlib/src/string.c` | `memcpy/memset/memmove/memcmp/strlen/strcpy/strcmp` |
| `stdlib/src/math.c` | `sin/cos/sqrt/pow/fabs/floor/ceil/fmod` |
| `stdlib/src/setjmp.c` | `setjmp/longjmp` (portable simplified host implementation, host tests only) |
| `stdlib/src/arm/setjmp.s` | the **real ARM Thumb-2 implementation** of `setjmp/longjmp` (`jmp_buf` holds r4-r11/sp/lr, `longjmp(env,0)` reads back 1); why it must be assembly and cannot be a C wrapper is in the file header |
| `stdlib/src/stdlib.c` | conversions and integer arithmetic: `strtol/strtoul/strtoll/strtoull` (base 2..36, `errno=ERANGE` saturation, `endp` semantics), `atoi/atol/atoll`, `strtod/strtof/strtold/atof`, `labs/llabs`, `div/ldiv/lldiv`, `qsort` (insertion sort, stable, no recursion), `abs` |
| `stdlib/src/heap.c` | `malloc/free/calloc/realloc`: a static arena of `ARK_STDLIB_HEAP_SIZE` bytes (8 KB by default, change with `-DARK_STDLIB_HEAP_SIZE=…`), block splitting/adjacent coalescing; **returns `NULL` when exhausted** (no silently fabricated address), plus the read-only diagnostics `ark_heap_used/ark_heap_capacity` used by gates and the on-board `mem` command |
| `stdlib/src/errno.c` | `errno` as a real object (a single 4-byte global, shared by every TU's `extern int errno`; the `E*` macros live in `<errno.h>`, so renumbering is a header change) |
| `stdlib/src/exit.c` | `exit/_Exit/abort/atexit`: runs the `atexit` chain in reverse registration order, then calls the port hook `_ark_exit(status)` |
| `stdlib/src/exit_default.c` | weak definition of `_ark_exit` (infinite loop): a target project can override it, and only then does `exit()` really leave the image |
| `stdlib/src/signal.c` | `signal/raise` (subset): `SIGINT/SIGTERM/SIGABRT/SIGFPE/SIGSEGV/SIGILL`, `SIG_DFL` goes to `_ark_exit`, `SIG_IGN` ignores |
| `stdlib/src/putchar_default.c` | weak default `putchar` |
| `stdlib/src/arm/aeabi.c` | the 64-bit AEABI runtime for flat ARM images: `lmul` / `ldiv` / `udiv` / `llsl` / `llsr` / `lasr` / `lcmp` / `ulcmp`, all using 32-bit operators only (never recursing into itself), in C, compilable by arkc itself |
| `stdlib/src/arm/aeabi_divmod.s` | four-register-return wrappers for `__aeabi_ldivmod` / `__aeabi_uldivmod` (quotient `r0:r1`, remainder `r2:r3`) — C cannot express a four-register return (`__value_in_regs` is parsed but not code-generated), so this one piece must be assembly, reusing the arithmetic from `aeabi.c` |

`stdlib/include/` headers (23): subsets of `complex.h`/`ctype.h`/`errno.h`/`fenv.h`/`float.h`/
`inttypes.h`/`limits.h`/`locale.h`/`math.h` (with `M_PI` etc.)/`setjmp.h`/`signal.h`/`stdarg.h`/
`stdatomic.h`/`stdbool.h`/`stddef.h`/`stdint.h`/`stdio.h`/`stdlib.h`/`string.h`/`tgmath.h`/
`time.h`/`wchar.h`/`wctype.h`, all declared per C99/C11 — **declarations and implementations share
one source of truth**, and the gate compiles the implementation files against the prototypes in the
headers.

**Flat images (`-o image.bin` / `--vector-table`) and the two ARM runtimes above**: when compiling
`.c` to `.obj`, 64-bit multiply/divide/modulo/shift/compare emit external symbols such as
`__aeabi_lmul` (64-bit add/sub are already inlined as `ADDS`/`ADC`, `SUBS`/`SBC`, so they need no
runtime). **The compiler never implicitly links these two sources** — whether the image needs
soft-float / 64-bit runtime is the linker's decision. So a working flat-image command is three
steps:

```sh
./arkcc -target arm -c stdlib/src/arm/aeabi.c -o aeabi.obj
./arkcc -target arm -c stdlib/src/arm/aeabi_divmod.s -o aeabi_div.obj
./arkcc x.c -target arm -c --vector-table -o x.obj
./arkcc -link x.obj aeabi.obj aeabi_div.obj --vector-table -o out.bin
```

Linking these two sources prints one line, `[link] note: 1 duplicate compiler-runtime symbols
merged`: `aeabi.c` also carries 64-bit add/subtract functions to cover the "somebody calls this
object file directly" case, and they are same-name same-meaning as the runtime built into the
image, so merging is the expected behaviour.

**Known cost (a design choice, not a defect)**: `udivmod64` is a 64-iteration restoring division,
and under arkc's "every intermediate goes on the stack" code shape **one 64-bit division is about
12.8k instructions** (measured on the whole `shift64` case: 9.26M instructions). Soft division on
an M7 is still in the millisecond range at its clock rate, but latency-sensitive inner loops should
avoid 64-bit division.

**RV32I flat images (`-target riscv32 x.c -o x.bin`)**: this backend used to stop at "emit GAS
assembly"; to execute you had to wire up `as -march=rv32im` + `ld -Ttext=0x08000000` yourself. Now it
is an RV32I assembler in its own right and writes the image straight to `0x08000000`: `.text` →
`.rodata` → `.data` laid out consecutively (run `-S` first and you can match every instruction),
section bases 16-byte aligned, and the image **ends at the end of the last section that has any
bytes** (a pure code program is exactly the code length, with no extra alignment padding).
`ARKCC_DUMP_SYMS=1` prints `RV_SYM <name> 0x<address>` to stderr, which host tests use to locate
`main`.

This assembler **has no linker**, so it is stricter than GNU as about "half-finished" input: three
classes of problem are errors and produce no image — unknown mnemonics; branches beyond ±4 KB for
`beq/bne/blt/bge/bltu/bgeu` (±1 MB for `jal/j`); and **references to symbols this translation unit
does not define** (`a flat image has no linker to fill it in`) — leaving a half-written `auipc`
that jumps outside the image while exiting 0 is exactly the silent wrong answer this project
forbids.

**RV32I object mode (`-target riscv32 -c x.c -o x.ark_obj` + `-link`)**: `-c` produces an ARKOBJ2
object whose body holds **already-assembled machine code** (not assembly text), with cross-object
references left for the linker. RV32I's `la sym` / `call sym` are `auipc`+`addi|jalr` pairs, and
only both instructions together decide where the low 12 bits go, so relocations are recorded **in
pairs** (`RV_RELOC_AUIPC`, 8 bytes); `.word sym` wants an absolute address and gets its own kind
(`RV_RELOC_ABS32`). Rewriting only the top 20 bits of `auipc` is not enough — the `auipc` immediate
is shifted left by 12, so the carry out of the low bits must be folded into the following
instruction, which is why the two are always computed together.

Inside an object everything is PC-relative, so **every object can land at any offset in the image**:
the linker concatenates objects at 16-byte alignment, intra-object references hold naturally, and
only the cross-object entries in the table need patching. The one thing that cannot work is a
**cross-object branch** (RV32I has no relocatable 32-bit branch form); such code is an error that
suggests turning it into a call — an error is more honest than half an answer.

The export boundary is decided by an **export table**: only labels named by `.globl`/`.weak` (i.e.
non-`static` definitions at the C level) can be referenced across objects. Otherwise each
translation unit's `static helper` would collide at link time, and the linker's policy is "the first
duplicate strong symbol wins" — which would silently bind file A's static helper into file B's call,
another silent wrong answer.

Objects carry an ISA descriptor (`__arkcc_isa_riscv32`) that is checked in both directions at link
time: objects linked under `-target riscv32` must be RV, and RV objects must be linked under
`-target riscv32`. Without this step, `arkcc -link rv.obj` would take the ARM relocation path, write
Thumb branch encodings into a RISC-V image, and still exit 0. `-v` prints
`[link] object N: base 0x...`; together with `ARKCC_DUMP_SYMS` that is how you convert "offset
inside an object" into an address — a flat image has no symbol table of its own.

Known boundary: **cross-translation-unit function-pointer global initialisers**
(`int (*gp)(void) = f;`) are currently a hard error on the RV backend
(`cannot turn the initialiser of the global 'gp' into data`) — a pre-existing limitation; with
hand-written assembly `.word f` works (`RV_RELOC_ABS32`). Also, the linker still warns and takes the
first of **duplicate strong symbols** (ARM has the same policy; unchanged this round), so defining a
non-`static` global function/variable twice at the C level is not rejected.

`li` immediates accept the whole unsigned 32-bit range (`li t0, 4294967295` is -1, matching GNU as);
only going beyond 32 bits is an error.

**The last four IR classes on RV32I (inline assembly / `__svc` / `__smc` / auto-vectorisation)**:
after the backend's `default` branch became an error, any source using these four failed to compile
on RV — honest, but still a gap in "a complete C compiler". All four are implemented now:

- `IR_ASM`: `asm("...")` lands in the assembly output verbatim; the extended form
  (`asm("t" : outs : ins : clobbers)`, marked by irgen with an `@` prefix) maps `%0..%3` to
  `a0..a3` (`r0..r3` on ARM). This backend **has no operand allocator**, so outs/ins/clobbers are
  discarded — a known boundary, recorded in the gate's comments.
- `IR_SVC` / `IR_SMC`: the number goes into `a7`, the instruction is `ecall`. RV32I **has exactly
  one trap instruction**, so `__svc(n)` and `__smc(n)` are indistinguishable on RV; that is a
  property of the ISA, not a trick. Putting the number in `a7` follows the RISC-V syscall ABI / SBI
  convention, and the kernel side picks it up from there.
- `IR_SIMD_ADD16/SUB16/ADD8/SUB8`: the packed-lane operations produced by auto-vectorisation. The
  RV32I base ISA has no packed instructions, so they are **exactly emulated** with SWAR (per-lane
  signed wrap-around, never saturating — matching ARM's `SADD16/SSUB16/SADD8/SSUB8`). Two easy
  mistakes: the 16-bit family cannot use a byte mask (the carry out of `0x00FF + 1` would be lost,
  so you must mask whole half-words and then shift the carry away); the 8-bit family can group by
  `0x00FF00FF`, but **subtraction must set a guard bit at the start of each lane's gap**, otherwise a
  borrow out of the low byte crosses the gap and steals a 1 from the lane above (`0 - 1` yields
  `0xFFFFFFFF` instead of `0x000000FF`).

This path also uncovered and fixed a **silent wrong answer that existed in both backends**:
`opt_vectorize` widened `LOAD_IDX`/`STORE_IDX` to `es*W` and swapped `BINARY` for SIMD, but never
removed the `IR_TRUNC` left over from element narrowing, so the four lanes packed into one word were
narrowed down to lane 0 — `char a[8] + b[8]` under `-O2` computed `{1,2,3,4,5,6,7,8}` as
`{2,0,0,0,10,0,0,0}`. The fix raises the target width of adjacent `IR_TRUNC`s to 32 (32 is a no-op
in both backends, so no renumbering is needed) and rejects loops over `volatile` and `__packed`
(`aux & 0x200 / 0x400` — the former must not be merged, and the latter's byte-wise path is the very
implementation of unaligned access). Gate: `tests/run_rv_misc_ir_tests.py`.

The same path also exposed and fixed a backend defect: `irgen` records "operand is unsigned" in bit
8 of `aux` (`0x100`), the ARM backend masks that bit off first, but the RV32I backend switched on
`aux` directly, so **unsigned right shift and all four unsigned comparisons fell into the `default`
branch and emitted nothing** — both operands popped, the left operand pushed back, `u >> 4` silently
returned `u` and `a < b` silently returned `a`. Now the bit is masked off and the `srl` / `sltu`
family is selected, and the `default` branch is an error (an unknown operator may not silently
return the left operand).

### Backends

| Backend | Purpose |
| --- | --- |
| **ARM Thumb-2** | STM32 Cortex-M (default; soft-float/hardware FPU + section separation + double-precision stubs + AAPCS + full DWARF + TLS + split_sections + scatter) |
| **C source** | the host test main path (IR -> readable C, full inline-assembly operand pass-through) |
| **x86_64** | a real SysV AMD64 backend: 8-byte pointers, `rdi rsi rdx rcx r8 r9` + `xmm0-7` + right-to-left 8-byte stack slots, `al` carrying the number of xmm regs, 0x400000 flat images (RIP-relative loads), its own 64-bit encoder (`-target x86_64`; the aliases `x86-64`/`amd64` point here) |
| **x86** | i386 cdecl, emits GAS assembly (aliases `i386`/`i686`) |
| **RV32I** | emits RV32I assembly, and has its own flat-image assembler and object path (`arkcc -target riscv32 x.c -o x.bin` writes a whole image at 0x08000000; `-c`/`-link` produce machine-code objects that are concatenated, with no external `as`/`ld`) |

For the x86-64 ABI model, the four silent wrong answers fixed this round, the two deliberate
behaviour changes on i386 and the known-defect list, see
[docs/X86_64_BACKEND.md](docs/X86_64_BACKEND.md).

**The backends do not share one capability table: `stdarg.h` has two incompatible recipes.**

All four backends support variadic function definitions, but the **shape** of the argument mirror
differs, and driver-injected macros make `stdarg.h` pick one:

| Backend | Recipe | Layout |
| --- | --- | --- |
| C / x86 / x86_64 | 8-byte slots (default branch) | one 8-byte slot per argument, numbered by index, advance a `long long *` |
| ARM Thumb-2 | `__ARK_VA_WORD_SLOTS` | one 4-byte word per AAPCS argument word; `va_start` points at the first variadic word; a 64-bit argument is two adjacent words, so round the pointer up to 8 bytes before reading (absorbing the hole the caller left for an even register pair / 8-byte stack slot) |
| RV32I | `__ARK_VA_WORD_SLOTS` + `__ARK_VA_PACKED_WORDS` | same, but this backend's argument words have **no alignment holes** (a0..a7 are flat), so it does not round to 8 |

ARM's va area **is the caller's own argument mirror, not a copy of it**: the variadic function's
prologue pushes "the registers that may still hold variadic arguments" ahead of the saved
registers, so those words land exactly below the caller's stack-argument block, forming one
continuous run of words with it — word j of the area is r_(k+j), followed by words 0, 1, 2… of the
caller's stack-argument block. `k` is the first register number that may hold a variadic argument,
taken as `NCRN` rounded **down** to an even number:

| Named argument words (NCRN) | Prologue push | Cost per call | Epilogue |
|---|---|---|---|
| 0 or 1 | `PUSH {r0,r1,r2,r3}` | 16 B | `POP {..,lr}` + `ADD sp,#16` + `BX lr` |
| 2 or 3 | `PUSH {r2,r3}` | 8 B | `POP {..,lr}` + `ADD sp,#8` + `BX lr` |
| 4 (including "a named argument already on the stack") | nothing | 0 B | ordinary `POP {..,pc}`, stack-argument base back to `local_size+16` |

Rounding `k` to even has four reasons: the area base is always `frame + local_size + 16` (because
`sp_entry = base + pushed bytes`), so zero-copy still holds; "round ap up to 8" and "even AAPCS
argument word count" are equivalent for any even `k` (word j is at `base+4j`, which is 8-aligned iff
`(j-k)` is even, i.e. `k+j` is even); the pushed byte count is a multiple of 8, so `sp` keeps the
AAPCS 8-byte alignment (an odd `k` still walks the area correctly but leaves the frame top at 4 mod
8, which can break an 8-byte local or a gcc-compiled callee); and at `k=4` not a single byte needs
pushing. Stack arguments still have **no ceiling** and need no copy loop. `_ark_va_ptr` is not a real
variable: in `IR_PUSH_GLOBAL` the backend computes `frame + local_size + 16 + 4*slot` straight into a
register (`slot` being the starting word of the variadic argument in the area).

RV32I passes arguments only in a0-a7, so its va area is the 8 words at the **bottom of the frame**
(`s0 - sp_size + 4*k`, inside the 256-byte margin `sp_size` already reserves, costing no extra
stack), and `_ark_va_ptr = s0 - sp_size + 4*named-argument-words`.

**Structs crossing `...`: inlined by word, no address pushed.**

Named parameters wider than 8 bytes use this compiler's own convention (push one address word and
let the callee's `IR_GETARG` memcpy it into its own frame) — the callee sees the type, so a bilateral
convention is enough. Variadic arguments are not like that: **the callee has no type**, and
`<stdarg.h>` only walks consecutive argument words, so the payload itself must be on the wire. AAPCS
does not leave an indirection layer for this case either, and gcc inlines it too (measured:
`f(1, s12)` lands in r1,r2,r3). At the call site the struct is pushed word by word,
`ceil(size/4)` words (word 0 on top, consistent with "arg0 is above arg1"), and `aapcs_assign()`
assigns arguments wider than two words **word by word** — as many as fit go into the remaining
registers, the rest go on the stack (measured with gcc: a 12-byte struct after three named words is
r3 + two stack words, not the whole struct on the stack). The struct address is computed once
(`IR_DUP`/`IR_SWAP` keep it on the stack top and a final `IR_POP` drops it), so the call in
`f(1, mk_s3())` happens only once. Structs of 5..8 bytes keep the old two-word rule (even register
pair / 8-byte stack slot).

This is **ARM only**: RV32I has no stack arguments, and C/x86_64 use an 8-byte slot mirror where
inlined words would be read as something else, so `irgen` errors out there
(`passing a 12-byte structure through '...' is implemented for the arm target only`) instead of
producing a silent wrong value.

One **known deliberate deviation**: for a 16-byte, 8-byte-aligned struct (`struct {long long a,b;}`)
gcc rounds NCRN up to even before placing it; we do not — because `<stdarg.h>` can only judge
alignment by `sizeof` (`_Alignof` is implemented now, but `<stdarg.h>` still uses `sizeof == 8`, and
the call side does not round NCRN either, so this cell still has no alignment information) and the
hole left by rounding is invisible to it, which would read it as the first word. Both sides being
arkc is self-consistent (the `struct8a` case pins this cell); mixing with a gcc-compiled callee
misaligns this cell.

**A call has at most 64 arguments** (the per-backend argument table limit). The 65th used to be
silently dropped and is now a compile error; ARM additionally limits the total to 192 argument words
(also an error when exceeded, no silent truncation).

> This section used to be an 8 KB image area (`frame+8000..8127`) that copied the stack arguments
> into the frame on every variadic call. It passed every execution test and yet **could not run on
> the target board at all**: the on-board small-program task stack is only 4 KB
> (`APP_TASK_STACK_SIZE`) and an 8 KB frame overflows immediately. `run_va_gate.py` now asserts the
> **frame size** of every case too (`FRAME_CAP = 1024`), so "it runs" cannot get past this class.

All of this has been **executed**, not merely "emits assembly": `examples/run_va_gate.py` hands the
same source to gcc (to obtain the expected value) and to arkcc → GNU as → unicorn (to really run
it), then compares exit codes. It covers all-register arguments, register+stack, 64-bit in a
register pair, 64-bit on the stack, the **boundary** case where a 64-bit argument after three named
words is forced onto the stack by an odd register, 64-bit reads in both slimmed area shapes (8 bytes
/ 0 bytes), a long named integer forcing the whole tail onto the stack, `double`, and a `float`
argument promoted to `double` per the default argument promotions. There is also a case with 34
argument words (30 on the stack) pinning "no ceiling on stack arguments".

Five tiers in one run: `--opt-suite` runs default, `-O2`, `-fopt-regalloc`, `-O2 + -fopt-regalloc`
and `-O2 + -freg-top + -finline + -fopt-regalloc` and then aggregates the verdict. This tier is not
optional but required: `-fopt-regalloc` widens the save block from 16 bytes, the `r0-r3` mirror and
the caller's stack arguments shift up with it, and the `16` inside `va_start`'s two constants
(`local+16+…`) stops being true — without the shift, the near tier measured
`20 passed / 29 failed`, all of them numeric errors.

Every case also has to pass three static assertions, none of which depend on an external toolchain,
so the on-board path is watched too:

- **Frame size** (`FRAME_CAP = 1024`): consecutive `SUB sp, sp, #N` are **summed** per function
  before comparing. Earlier the code took "the single largest value", and a big frame is split into
  `4095+4095+810`, so a 9000-byte frame was recorded as 4095 and passed easily — this now has a
  self-check (the self-check plants a fake 9000-byte function).
- **Frame alignment**: every function's prologue (`PUSH…` + `SUB sp`) must add up to a multiple of
  8. It exists to catch changes like "pushing one word less looks free".
- **Area shape**: `int f(int a, ...)` must `PUSH {r0,r1,r2,r3}`, two/three named words must
  `PUSH {r2,r3}`, four named words must push **nothing**. Two further assertions check encodings and
  call results: the bytes of `POP {..,lr}` must be exactly `e0b5 bde8 e040 7047`, and calls to
  declared-but-undefined `extern void`/`extern long long` must push the right number of words.

What is left on RV32I is that backend's own boundary, not something va-specific: it passes arguments
only in a0-a7 (no stack arguments), so "more than 8 argument words" is **explicitly rejected**
(`stack arguments are not implemented`) instead of silently leaving a wrong value as before. 64-bit
arguments and 8-byte values in variadic arguments are genuinely two words (low word pushed first,
high word on top), unaligned 1/2/4/8-byte access through a `__packed` pointer is always byte-wise,
and aggregates >8 bytes crossing `...` are spread over consecutive argument words, where reading them
back uses an `IR_LOAD_IDX` offset that is an **element index**, scaled by the backend per element
width.

**Variadic calls and the `__asm` form**: `__asm int printf(const char*, ...)` — a declaration with
`...` whose body is a whole block of assembly — does not go through the va area (`is_asm_func`) and
works as before on all four backends. A `float` argument to a variadic call is promoted to `double`
per C99 6.5.2.2p6 first (`irgen` emits `IR_F2F`), so parameter widths are counted as 8 bytes.

### Runtime library dependencies: which symbols must come from outside

The backends **no longer carry** any AEABI soft-float / 64-bit integer helper routines, nor RV32I
soft-float routines. They belong to the target runtime library (that is literally how AEABI is
defined) and every real toolchain ships them: `libgcc.a` in `arm-none-eabi-gcc`, `armlib` in armcc.

| What is used | ARM Thumb-2 | RV32I |
| --- | --- | --- |
| `float`/`double` arithmetic (soft-float) | `__aeabi_f*` / `__aeabi_d*` (`add/sub/mul/div`, `cmpeq/cmpgt/...`) | `__addsf3/__subsf3/__mulsf3/__divsf3`, `__adddf3/__subdf3/__muldf3/__divdf3` |
| float ↔ integer / float conversions | `__aeabi_i2f` / `__aeabi_ui2d` / `__aeabi_f2iz` / `__aeabi_d2lz` … | `__extendsfdf2`, `__fixdf*` (chained internally by the soft-float implementation) |
| float comparisons | `__aeabi_fcmp*` / `__aeabi_dcmp*` | `__eqdf2/__nedf2/__ltdf2/__ledf2/__gtdf2/__gedf2` |
| 64-bit integer multiply / divide / modulo | `__aeabi_lmul`, `__aeabi_ldivmod`, `__aeabi_uldivmod` | `__muldi3` / `__divdi3` / `__udivdi3` (`libgcc`) |
| 64-bit integer logical shifts | `__aeabi_llsl` / `__aeabi_llsr` / `__aeabi_lasr` | inlined (`slli`/`srli` per word) |
| 64-bit integer add/subtract | **inlined** (`ADDS`/`ADCS` sequence, no library) | **inlined** (`sltu` + `add`/`sub` carry chains) |
| `memcpy` | the backend carries `__aeabi_memcpy` (struct assignment/passing and array initialisation all use it) | the backend carries a same-name block |
| Hardware FPU mode (ARM `--fpu=hard`) | all the soft-float above is replaced by `VADD/VMUL/VCVT/VCMP`, no runtime dependency | none (RV32I has no floating-point extension) |

Therefore: **an image that uses floating point, 64-bit division or 64-bit↔float conversion must be
linked with the runtime library**. Omitting it does not produce wrong values — it fails at link time
with `undefined reference to __aeabi_...` / `undefined reference to __adddf3`, and that is deliberate:
these helpers were once implemented inline, and five of them measured out as **silent wrong answers**
(`__aeabi_f2iz`, `__aeabi_fdiv`, `__aeabi_uldivmod`, `__aeabi_ldivmod`, `__aeabi_dadd`; see the
comment block in `src/backend/arm/backend_arm.c`), so the whole batch was deleted, turning "computes
it wrong" into "won't link". Pure-integer programs without 64-bit division remain zero-dependency.

The same holds on the RISC-V side: `arkcc -target riscv32 x.c -o x.bin` produces an image containing
only its own code; soft-float and 64-bit multiply/divide need `libgcc` linked separately (or emit
`.s` from the built-in assembler under `-target riscv32` and hand it to a complete toolchain).

## Directory layout

```
ark c compiler/
├── include/                Public headers (arkcc_config.h/config.h/opt.h/cpu.h/scatter.h)
├── src/                    Compiler core (lexer/parser/sema/ir/irgen/preproc/config/opt/cpu/scatter)
├── src/backend/arm/        ARM Thumb-2 backend (codegen + assembler + linker + soft-float/hard-FPU + full DWARF + TLS)
├── src/backend/c/          C source backend (host-side testing)
├── src/backend/x86_64/     Two x86 backends: i386 cdecl (`x86`) + SysV AMD64 (`x86_64`)
├── src/backend/riscv32/    RV32I assembler backend
├── stdlib/include/         Bundled standard library headers
├── port/host/              PC platform layer
├── port/stm32/             STM32 platform layer (platform/flash_fs/main_stm32 entry)
├── examples/               80 test samples (.c; run_tests.ps1 runs 75 of them)
├── examples/stm32_selfhost_build/  On-board self-hosting sample (multi-source .c → app.svcm → executes on the board)
├── mdk/STM32H743_ArkCC/    Keil MDK project
├── build_stm32_armcc.ps1   armcc5 script that builds the STM32 firmware (emits arkcc_stm32.hex/.bin)
├── arkcc.cfg               Default runtime configuration (INI format)
├── Makefile                gcc host build script
├── docs/MANUAL.md          User manual (Chinese, UTF-8)
├── docs/STM32_BUILD.md     STM32 + armcc5 build manual (Chinese, UTF-8)
├── docs/DIAGNOSTICS.md     Diagnostics layer: the byte-for-byte layout contract shared with armcc (Chinese, UTF-8)
├── docs/CI.md              Continuous integration: what runs, what is skipped, and why (Chinese, UTF-8)
├── docs/ATOMIC.md          C11 _Atomic: type-level propagation, read-modify-write rejection, the two <stdatomic.h> branches and their gate (Chinese, UTF-8)
├── docs/X86_64_BACKEND.md  x86-64 (SysV AMD64) backend: registers, stack slots, relocations, execution-level gate (Chinese, UTF-8)
├── docs/从零写一个C编译器.md  Textbook-style walkthrough: 19 chapters, from 30 lines to 30 000 (Chinese, UTF-8)
├── docs/from-scratch-c-compiler.en.md  English summary of that textbook (structure, chapter map, reading routes)
└── README.md               Project overview (Chinese, UTF-8)
```

English translations of the documents live next to their Chinese originals as
`docs/X.en.md` (`docs/X.md` stays Chinese); `README.en.md` is the English counterpart of
`README.md`. Each pair carries a one-line language switch at the top. Every document is covered this
way except the 8 740-line textbook, which has an English summary
([docs/from-scratch-c-compiler.en.md](docs/from-scratch-c-compiler.en.md)) rather than a full
translation.

## Building

### Option 1: gcc build (host development and testing)

```bash
make            # produces arkcc.exe
make test       # compiles examples + runs the reloc-text / stdlib / install / x86-64 gates
make clean
```

### `make install` (DESTDIR / PREFIX)

```bash
make install                                      # installs into PREFIX (default /usr/local)
make install PREFIX=$HOME/arkcc                    # different installation root
make install DESTDIR=/tmp/stage PREFIX=usr/local   # staging for packaging (files land in /tmp/stage/usr/local)
```

The resulting layout:

```
$PREFIX/bin/arkcc[.exe]        the compiler
$PREFIX/include/ark/*.h        22 standard headers
$PREFIX/lib/ark/src/*.c|*.s    library sources (not pre-compiled: which runtime an image needs is decided by the linker)
$PREFIX/lib/ark/src/arm/*      AEABI / setjmp assembly for flat ARM images
$PREFIX/lib/ark/README.md      how this library should be compiled for a given target
```

Three hard rules: **`DESTDIR` is a staging root and `PREFIX` must be a relative path inside it**
(passing `DESTDIR` together with an absolute `PREFIX` is an immediate error — otherwise
`os.path.join()` silently drops `DESTDIR` on Windows and the files are installed directly into
`PREFIX`); **no file is ever deleted**, only overwritten when its contents differ; and **every
installed file is read back and compared byte for byte**, failing on any mismatch. Re-running
`make install` does not re-stamp any file (all 38 mtimes stay identical), and `--dry-run` writes
not a single byte.

> Git Bash / MSYS rewrites `/usr/local` into `C:/…/PortableGit/usr/local` before the script ever
> sees it, so in such shells either use Windows-style paths
> (`make install PREFIX=C:/ArkCC`) or
> `MSYS_NO_PATHCONV=1 make install DESTDIR=/tmp/stage PREFIX=usr/local`.

### Option 2: armcc5 build (produces the STM32 firmware)

```powershell
# requires Keil MDK 5.x, with armcc.exe on PATH or under D:\Keil_v5\ARM\ARMCC\bin
powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1
# output: bootstrap_x86\armcc_objs\arkcc_stm32.{elf,hex,bin}
```

See [docs/STM32_BUILD.en.md](docs/STM32_BUILD.en.md) for details.

## Command line

```
arkcc <file.c|file.s> [options]
  -o <file>          output file
  -S                 emit assembly text only
  -c                 compile only, do not link (.ark_obj, ARKOBJ2 container)
  -E                 preprocess only
  -link a.o b.o      link several .ark_obj files (if more than one carries .data/.bss you get an SRAM overlap error)
  -v                 verbose
  -target <name>     arm | x86_64 | x86 | riscv32 | c (default arm; x86_64 is the real SysV AMD64
                     backend, i386 is an alias of x86, x86-64/amd64 are aliases of x86_64)
  -I <dir>           header search path
  -O0/-O1/-O2        optimisation level (0 = none, 1 = basic constant folding + DCE, 2 = aggressive)
  -g                 emit DWARF debug information
  -config <file>     load an INI configuration file (default arkcc.cfg)
  -f<feature>        enable a feature (vla/complex/wchar/trigraph/fpu/dwarf/...)
  -fno-<feature>     disable a feature
  -Wno-unused        suppress unused warnings
  --list-backends    list backends

  Diagnostics
  --diag_style <s>   arm (default) | ide; ide is uVision's File(line,col) style
  --errors <file>    write the whole diagnostic stream to a file (same as armcc)

  Target CPU selection
  -mcpu <name>       Cortex-M3/M4/M7/M33 etc.
  --cpu <name>       armcc-style synonym
  --thumb            force Thumb mode
  --arm              force ARM mode
  --fpu <type>       soft/hard (soft-float / hardware FPU)

  Dependency generation
  -MMD               emit a .d dependency file (like gcc)
  --depend           same as -MMD
  -MF <file>         set the dependency file name

  Sections and code generation
  --split_sections   one section per function (.text.<fn>)
  -ffunction-sections same as --split_sections

  Language compatibility options
  --dollar           allow `$` in identifiers
  --enum_is_int      force enum's underlying type to int
  --signed_chars     char is signed by default
  --unsigned_chars   char is unsigned by default
  --wchar16          wchar_t is 16 bits
  --wchar32          wchar_t is 32 bits

  DWARF version
  --dwarf2           DWARF v2
  --dwarf3           DWARF v3

  Added in the current round (all off by default; without the option the output is byte-identical to the previous release)
  --reloc-data       relocate data sections across objects (without it, several objects sharing a global
                     still report an SRAM overlap)
  --reloc-text       fix up absolute in-section addresses at link time (code addresses inside
                     MOVW/MOVT, string literals, …; required for multiple objects or whenever the image
                     is loaded somewhere other than the address it was compiled for, otherwise the
                     old base address is read)
  --rt-lazy          emit runtime helpers on demand (only reachable blocks)
  --reg-top          keep the IR stack top resident in r0
  --asm-extra        assembler extended instruction set; --no-asm-extra turns it off explicitly
  --dce-cfg          basic-block reachability DCE (deletes only code that is reachable but never executes)
  --build-date <s>   pin __DATE__ (e.g. "May 28 2026")
  --build-time <s>   pin __TIME__ (e.g. "20:26:40")
  --source-date-epoch <n>
                     derive both __DATE__ and __TIME__ from a Unix timestamp (reproducible builds)
```

Build timestamp, macro-redefinition checking, scatter-layout validation and the dependency-file
limit are compile-time only (see `include/arkcc_config.h`); their defaults and behaviour are
documented in appendix D.4 "switch reference table" of
[docs/从零写一个C编译器.md](docs/从零写一个C编译器.md).

## Configuration system

arkcc layers configuration three deep, with priority **command line > configuration file >
compile-time default**.

- **Compile-time switches** (`include/arkcc_config.h`): the `ARKCC_FEATURE_*` macros decide which
  features are compiled into arkcc itself.
- **Runtime configuration file** (`arkcc.cfg`, INI format): the `[features]` section toggles
  individual features, `[general]` controls the optimisation level and debug information. The
  `arkcc.cfg` in the current directory is loaded automatically at startup; `-config <file>`
  selects another one.
- **Command-line overrides**: `-O0/-O1/-O2`, `-g`, `-f<feature>`, `-fno-<feature>`, `--dollar`,
  `--enum_is_int`, `--signed_chars`/`--unsigned_chars`, `--wchar16`/`--wchar32`,
  `--dwarf2`/`--dwarf3` override whatever the file says.

An example `arkcc.cfg`:

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

## Optimisation

`-O1` and above enable the IR-level optimisation passes in `src/opt.c`:

- **Constant folding**: the triple `PUSH_INT a; PUSH_INT b; BINARY op` collapses into
  `PUSH_INT (a op b)`, scanning to a fixed point (at most 8 passes) so folding cascades.
  Division by zero and modulo by zero are deliberately left alone to preserve runtime behaviour.
- **Dead code elimination**: instructions between `RETURN/JMP/JMP_NAMED` and the next label are
  unreachable and are removed.

Each pass is guarded both by a compile-time `ARKCC_FEATURE_OPT_*` macro and by a runtime
`g_config.enable_opt_*` flag.

## Debug information

With `-g`, or `g_config.debug_info=1`, the ARM backend emits GNU-as-style DWARF directives and the
full set of debug sections into the assembly output:

- `.file 1 "<src>.c"` source-file registration
- `.cfi_startproc` / `.cfi_endproc` frame information
- `.loc 1 <line>` line mapping
- `.size <fn>, .-<fn>` function size
- `.type <fn>, %function` type annotation
- complete `.debug_info` / `.debug_abbrev` / `.debug_line` DWARF sections (`--dwarf2`/`--dwarf3`
  select the version)

## Tests

**Continuous integration**: `.workflow/main-pipeline.yml` (Gitee Go — the repository's main line
lives on Gitee, so this is the one that actually runs) and `.github/workflows/ci.yml` (GitHub
Actions, effective only when the repo is mirrored to GitHub) do the same thing: build arkcc with
the host gcc, `pip install unicorn`, then `make test`. Only gcc/make/python3 are required — no
cross toolchain, no hardware. The PowerShell gates (Windows only), `make stm32`, the differential
tests that need armcc or an ARM toolchain, and on-board self-hosting are all outside CI. What runs,
what is skipped and why is documented in [docs/CI.en.md](docs/CI.en.md).

```powershell
powershell -ExecutionPolicy Bypass -File examples\run_tests.ps1   # 75 cases (71 assertions + 4 skipped)
powershell -ExecutionPolicy Bypass -File run_full_test.ps1        # full regression over 73 samples
python tests/run_stdlib_tests.py                                  # standard-library gate (compile → multi-object link → really execute under unicorn): all 21 expected values are produced by the programs themselves; the `strtod` case is SKIPped with the measured reason printed (the host emulator has no double-precision FPU — that is the emulator, not the library)
python tests/run_x86_64_image_tests.py --arkcc ./arkcc.exe        # x86-64 gate: 35 programs compiled into flat 0x400000 images and run on a 64-bit unicorn core by calling main; every expected value is computed outside the program; also includes "an unresolved symbol must be rejected without leaving an image behind" and "an expected value off by +1 must be judged DIFF" as self-checks. Every program is then compiled a second time for 32-bit i386 and run again — an i386 result that differs from the expectation FAILS the case, it is no longer treated as a footnote
python tests/run_x86_64_selfhost.py                               # x86-64 execution-level self-host gate: the host arkcc compiles its own 24 translation units, the resulting image is executed inside unicorn, and that in-image arkcc compiles a probe; the object must be byte-identical to the host compiler's (2130 bytes, fnv=28c333dc, 877 lines of identical assembly)
python tests/run_install_tests.py                                 # `make install` gate: 38 files byte-identical to their sources, a second run changing no mtime, `--dry-run` writing nothing, absolute PREFIX + DESTDIR rejected; finally a program using malloc/div/qsort is built from the installed tree and must print 181 (host gcc on the same source also prints 181 — that is the oracle)
python tests/run_diag_tests.py                                    # diagnostic layout gate (needs armcc)
python tests/run_diag_boundary.py                                 # diagnostic boundary contract (long lines/limits/CJK/tab, no armcc needed)
powershell -ExecutionPolicy Bypass -File run_asm_test.ps1         # assembly-input gate (.s/.S/.asm/.ASM)
powershell -ExecutionPolicy Bypass -File run_arm_exec_test.ps1    # ARM execution level: compile → link → really run under QEMU (needs qemu-system-arm)
python tests/arm_exec/run_arm_exec.py                             # ARM execution level (unicorn; works without qemu; each case also runs a --reg-top arm)
python tests/asm_cases/run_asm_cmp.py                             # assembler differential: arkc vs arm-none-eabi-as, including the --asm-extra switch contract
python tests/run_atomic_tests.py --arkcc ./arkcc.exe               # or make test-atomic; _Atomic / <stdatomic.h> gate across five targets: exactly one target-identity macro, armcc's arm macro appears only on arm, the 11 atomic operations must be compile-time errors on the four non-ARM targets with no artifact left behind, atomic_init must compile everywhere; the tail self-check requires that the same source is *not* rejected on arm (otherwise "rejected" proves nothing)
python tests/run_c11_keywords_tests.py --arm-as <bin> [--rv-as <bin>]  # C11 keyword gate (ARM + RV32I, 32 items): every runtime case computes its own addresses/values (finding `.balign` in the assembly is not evidence), plus a true/false static-assert contrast and three self-checks
python tests/run_arm_int64_tests.py --arm-as <bin>                 # 64-bit data-path gate (ARM, 12 items): inline add/sub, shifts, comparisons, division/modulo through the runtime library, including a self-proof that the runtime library is still required
python tests/run_arm_abi_mix_tests.py --arm-as <bin>               # AAPCS mixed-call gate (ARM, 16 items × both directions): arkcc and arm-none-eabi-gcc each own one side, unicorn runs the same image, pinning "aggregates crossing `...` are rounded up by alignment", "8-byte align-4 aggregates may be split", and the holes between registers and stack; a pure-arkc oracle of the same shape (run_va_gate.py) cannot see this class of disagreement, hence this gate
python tests/run_rv_float_tests.py --arm-as <bin> --arm-libgcc <libgcc.a> --rv-as <bin>  # RV32I soft-float gate (22 items): floating-point arithmetic/comparison/conversion compared against gcc
python tests/run_capacity_tests.py                                 # capacity gate: 120 objects / 1200 headers / 520 -D / 129 -I (the host must have no artificial limits)
python tests/run_rv_alloca_tests.py --rv-as <bin>                  # RV32I VLA gate: 5 cases compared against gcc with hard-coded expectations asserted in each (both arms wrong is still wrong), covering early return (epilogue restoring sp), two VLAs, 10 stack arguments (alignment) and a `long long` VLA
python tests/run_rv_image_tests.py [--rv-as <bin>]                  # RV32I flat-image gate (8 cases): compile to an image, run `main` on RISCV32 unicorn and compare hard-coded expectations; verify the image tail is exactly the last section's contents (no stray alignment padding); three rejection cases (unknown mnemonic / branch out of range / undefined external symbol) must fail and must **not** produce an image; with `--rv-as` a GNU as/ld reference image is produced from an alignment-matched linker script and must be byte-identical
python tests/run_rv_link_tests.py                                  # RV32I object-mode gate (6 cases + 3 rejections + self-check): `-c` produces machine-code objects, `-link` joins them into one image; cross-TU calls / extern globals / reading arrays across objects / a `static helper` in two TUs that must not collide / `.word sym` absolute addresses / three objects. Unresolved symbols, cross-object branches and an RV object without `-target riscv32` must fail and produce **no** image; every case runs `main` on riscv32 unicorn against a hard-coded value, and a self-check requires that changing an operator changes the answer
python tests/run_rv_misc_ir_tests.py --rv-as <bin> [--arm-as <bin> --arm-libgcc <libgcc.a>]  # remaining RV32I IR gate (23 items): inline assembly, `__svc`/`__smc` (the RV side uses unicorn's `UC_HOOK_INTR` as the kernel and validates the whole a7/argument/return-value convention), and the four packed-lane operations (including cross-lane carry/borrow). Besides the values, every vectorised case requires the SWAR mask / `SADD*` mnemonics to actually appear in the assembly — matching values do not prove SIMD was used, scalar code gives the same numbers; plus two self-checks: a wrong expectation must be rejected, and turning vectorisation off must make the mask disappear
python tests/run_rv_packed_tests.py --rv-as <bin> [--arm-as <bin>]   # unaligned-access gate (RV32I + ARM; the ARM arm runs only when `--arm-as` is given): 7 cases × each arm, byte-level verification of where the store landed (never self-proved by reading back through the same path), 2-byte sign extension, no cross-talk on odd offsets, all 8 bytes of an 8-byte (`long long`, including negative) value with the high/low word order checked
python tests/run_regalloc_tests.py                                 # register-allocation gate: off means off / on really changes something / answers unchanged under unicorn, plus two negative cases (volatile and address-taken) that require the text to stay byte-identical
python tests/arm_exec/run_arm_exec.py --extra=-fopt-regalloc        # the same execution-level cases again, with register allocation on
python examples/run_va_gate.py --opt-suite --arm-as <bin> --rv-as <bin>  # variadic gate across all five switch positions (default/O2/regalloc/O2+regalloc/O2+regtop+inline+regalloc); any group going red fails the run
```

`tests/arm_exec/run_arm_exec.py` is the only host gate in this repository that **really executes
machine code**: it loads the raw image produced by arkc into unicorn (a QEMU core), starts at the
reset vector and reads `main()`'s return value. Semantic errors — one wrong instruction encoding, a
bad link-time address, a `--reg-top` fallback that does not restore state — are visible only on this
path; `run_tests.ps1` goes through the C backend and never sees ARM encodings. Without unicorn the
script reports `skipped` and exits 0 (the compiler itself does not depend on any Python package).

There are 29 cases today (the authoritative list is `CASES` and grows with the gate), each run once
on the baseline arm and once with `--reg-top`: `globals`, `reloc_data`, `reloc_data_off`,
`sub_word_access`, `longlong_args`, `shift64` (64-bit left/logical-right/arithmetic-right shifts with
counts 0/1/8/16/31/32/33/40/47/63, expected values computed by repeated doubling/halving rather
than by shifting), `abi_stack_args` (5/6/7/9-word arguments plus a 64-bit argument that spills to the
stack), `longlong64` (64-bit arithmetic/comparison/bitwise/unary minus/`++`/`--`/aggregates and
pointers/compound assignment), `struct_byval` (structs passed and returned by value, `f().m`,
`arr[i] = f()`, mixed scalar/struct/pointer arguments), `big_frame` (frames > 4095 bytes: a single
`SUB sp` cannot encode that, and the old `(N/4) & 0x7f` computed SP itself wrong), `far_addr` (taking
the **address** of a local whose frame offset exceeds 4095: `ADD Rt, r6, #off` cannot encode it, so it
became `MOVW/MOVT ip` + `ADD Rt, r6, ip`; the first version treated address-taking as loading the
value and emitted `ADD r0, [ip]`, which does not assemble, and the second shared `ADD ip, r6, ip` and
therefore computed `r6 + (r6 + n)` and wrote to a wild address). `const_fold_float` pins compile-time
floating-point folding (no VFP instruction may survive in the image), `tls_static_init` /
`tls_block_static` pin `_Thread_local` initial values and persistence across calls, `tls_reject` pins
the diagnostic text of its four constraints together with "an error must not leave an image behind",
and `atomic_rmw` / `atomic_nested_mask` / `atomic_wide` / `atomic_reject` pin the paired semantics of
`<stdatomic.h>` and the PRIMASK builtins (the value saved by nested entry must be 0,1,1,0 — blanket
mask-clearing on restore would silently re-enable interrupts). A good part of these cases are
regression pins for "compiles fine, then does not run or returns the wrong answer" — each one
corresponds to a defect that was really found and fixed.

`tests/asm_cases/run_asm_cmp.py` assembles every `--asm-extra` mnemonic twice, with two independent
assemblers, and compares **the instruction text produced by `objdump`**, not the bytes: the same
instruction often has several legal encodings (GAS prefers the mod-imm form), so unequal bytes do not
mean a mismatch — equal behaviour is what matters. A second table checks the other half of the switch:
with it off, all 30 mnemonics must be reported as unknown. A third table is the reverse contract — 15
lines that **must fail and must fail for the right reason** (nonexistent register index in a
write-back, non-contiguous VFP list, out-of-range immediate, `LDMIB`/`STMDA`), because these shapes
used to "compile but into a different instruction". Ten sample groups cover flag-setting arithmetic,
`LDM/STM` (16- and 32-bit forms, with and without write-back, increment-before and decrement-after,
high registers and `lr`/`pc`), multiply-accumulate, system registers, PC-relative, `TBB/TBH` and
`LDRD/STRD`, VFP single/double precision and the literal pool, every LDR/STR addressing mode, VFP
multi-register load/store, and armasm's four block-transfer aliases. Without a GNU ARM toolchain the
script exits 2 rather than pretending to pass.

`tests/run_regalloc_tests.py` guards three independent assertions about `-fopt-regalloc`: the default
text contains no `r8-r11` (off means off — the default output is byte-identical to the previous
release); turning it on really does reduce `[r6, #]` references in the hot cases (`far_slots` drops
from 22 to 13); and three cases really executed under unicorn return the same values as Python
(answers unchanged). Two further negative cases — a `volatile` local and an address-taken local —
require the text to stay **byte-identical**: the moment they start being rewritten, the taint rule
"every mention is one of those two shapes" has broken and the positive cases lose their meaning. That
rule did catch two real problems during implementation (address-taking emits `ADD r0, r6, #off`,
without brackets; `volatile` uses exactly the same two instructions).

`tests/run_capacity_tests.py` guards a different line: **the host must not have artificial limits**. It
generates 120 `.c` files, compiles each into an object and links them with `--reloc-data` into one
image; a translation unit that `#include`s 1200 distinct headers (with `-MMD`, so not one `.d` may be
missing); 500 `-D` flags that must compile while 520 must be rejected; and 129 `-I` flags, where the
129th must **fail** and name `ARK_PP_MAX_INC_DIRS`. All four are "the table filled up and the entry
was silently dropped" shapes: before the fix only 32 of 120 objects made it into the image (55 KB
instead of today's 206 KB), `.d` output stopped at 1024 entries, and every `-I` past the 16th simply
vanished — the symptom being a later "header not found", pointing at the wrong cause. The board build
still uses fixed-size tables (`ARKCC_MAX_INC_FILES` / 64 objects); `.bss` is byte-identical before and
after, and the trimming entry point is `-D` (see section 9 of `include/arkcc_config.h`). The image
buffer in the same batch grew from 256 KB to 8 MB (the host allocates it from a pool on demand, so it
does not grow the executable): a 1.2 MB image used to fail with `only 262143 could be read` and now
links normally.

`run_asm_test.ps1` checks extension routing for assembly input: four suffixes produce byte-identical
machine code, `-S` passes assembly input through unchanged, a missing file must fail, and `.c` still
goes through the normal front end (so extension sniffing cannot mistake C source for assembly).
`run_arm_exec_test.ps1` compiles C startup code, an assembly semihosting trap and a C workload, links
them into a bare-metal image and runs it on `qemu-system-arm -machine mps2-an385`, judging the result
by the semihosting exit code (two different workloads must return 8 and 3). The QEMU path defaults to
`D:\qemu\mingw64\bin\qemu-system-arm.exe` and can be overridden with the `ARKCC_QEMU` environment
variable or the `-Qemu` parameter; when QEMU cannot be found the script exits 2 instead of pretending
to pass. This gate caught and pinned fixes for three real defects: the vector table missing the Thumb
bit (Cortex-M enters INVSTATE lockup), `SVC`/`BKPT` immediates without `#` being silently encoded as
0, and `MUL r2, r2, r1` being encoded as `MUL r2, r2, r2` (which made every integer modulo evaluate as
q\*q).

`tests/run_diag_tests.py` compares arkc's diagnostics against those of a **real armcc 5.06** byte for
byte: cases that can be compared exactly are marked `exact`, cases where arkc's error recovery differs
and only the spelling of each line can be compared are marked `shape`, and `--errors` file output is
marked `sink`. The baseline is regenerated from the real armcc with `--regen`; with neither armcc nor a
baseline the exit code is 2 (refusing to pass falsely).

`tests/run_diag_boundary.py` covers the boundary contracts that byte comparison cannot reach: truncation
of over-long lines (`DIAG_LINE_MAX` 512) together with "if the caret cannot be drawn, do not draw it",
the 30-error cap, multiple diagnostics on one line each with their own caret, CJK counted in display
cells, and tabs replayed as-is. It does not need armcc; it asserts the behaviour arkc itself documents.
The layout rules and design notes are in [docs/DIAGNOSTICS.en.md](docs/DIAGNOSTICS.en.md).

All 71 assertion cases pass, 4 ARM-only cases skip the C-backend run (they only check ARM emission and
are not counted as passes), 0 fail (ARM assembly generation + C-backend compile-and-run, with expected
exit codes checked mechanically per file). Coverage: basic arithmetic, functions/recursion,
struct/union/enum, bit-fields, VLA, `_Complex`, `wchar_t`/`L"..."`, trigraphs, inline assembly (basic +
extended), the full `__attribute__` set, `__svc`/`__irq`/`__weak`/`__naked`/`__packed`/`__align`/`__at`/
`__forceinline`, `__asm` whole-function assembly bodies, `#pragma pack/anon_unions/location/...`, TLS,
`__packed` unaligned pointer access, `split_sections`, double precision, 64-bit integers, division and
modulo, compound literals, designated initialisers, structs passed by value, implicit conversions,
integer promotion, 64-bit `printf`, `setjmp/longjmp`, multi-file linking, CPU macros, debug information,
`$` identifiers and more.

## Porting to STM32

All you have to do is replace `port/host/*.c` with `port/stm32/*.c`; the entry point is
`port/stm32/main_stm32.c`. The MDK project lives in `mdk/STM32H743_ArkCC/`. The STM32 side is a
self-hosting configuration: it reads `.c` files straight from an external W25Q flash and compiles
them in place.

**armcc5 build**: `build_stm32_armcc.ps1` compiles the arkCC sources and links a flashable STM32
firmware on any Windows machine with armcc5 — no gcc required. See
[docs/STM32_BUILD.en.md](docs/STM32_BUILD.en.md) for details.

See [docs/MANUAL.en.md](docs/MANUAL.en.md) for the full manual.

## Version history

> Entries v0.8.2 and v0.8.1 are translated in full below. Earlier releases (v0.2.0–v0.8.0) are
> documented only in the Chinese [README.md](README.md) — they are long, and every one of them is
> covered by the documents under `docs/`.

- **v0.8.2**: every historical debt of the 32-bit x86 backend is cleared, and the gate no longer
  leaves it a loophole. (1) Local array indexing: the frame mapping became `[ebp - framelo + off]`,
  structurally identical to x86-64. (2) Structs passed and returned by value: the hidden return
  buffer pointer (sret) lives at `[ebp+8]` and real arguments start at `[ebp+12]`; `struct_sret40`
  used to read `[ebp+16]` because the callee also counted sret as an argument width, and got back
  all zeros. (3) Floating point: `x86_pair_swap_at` degenerated into a no-op at offset 0, so
  `(int)7.9` gave 0. (4) 64-bit integers: `IR_UNARY` ignored `I->val`, the `|a|` mask was written as
  `sar 31`, and the division shift used `add ecx,ecx`. Three wrong values from the C tier were fixed
  in the same round: float/double locals `++/--` were incremented as integers, `IR_BINARY` on 8-byte
  pointers did only 32-bit arithmetic, and pointer ↔ `long long` conversion was a no-op (a pointer is
  one stack word while `long long` is two, so the high half must be split and merged at the irgen
  layer, wired into cast / declaration initialisation / assignment / `return` / call arguments — five
  places). The x86-64 image gate grew from 33 to **35 programs**, and **each program is compiled a
  second time for 32-bit and run again**, with any i386 result that differs from the expectation
  judged FAIL (the old wording was a footnote, which is exactly why "a known 32-bit gap" never went
  red); the self-host gate is still byte-identical (2130 bytes, `fnv=28c333dc`, 877 identical lines
  of assembly). See §5 of `docs/X86_64_BACKEND.md`.
- **v0.8.1**: a real x86-64 backend (SysV AMD64 ABI; `--list-backends` now lists five backends), CI
  automation (GitHub Actions + Gitee Go, see `docs/CI.md`), C11 `_Thread_local` (storage class
  validated per 6.7.1p4, armcc's bare `__thread` stays exempt), and C11 `_Atomic` + `<stdatomic.h>`
  (a real critical section on ARM; compile-time rejection on the other four targets; `Type::is_atomic`
  makes atomicity propagate through typedefs, and `x += 1` / `x++` are always errors; 7 cases were
  added to the ARM execution gate for 29 in total; details in `docs/ATOMIC.md`). It also added an
  x86-64 execution-level **self-host gate** (`tests/run_x86_64_selfhost.py`,
  `make test-x86-64-selfhost`): the host arkcc compiles its own 24 translation units, the image runs
  inside unicorn, and the arkcc inside that image compiles a probe whose object is **byte-identical**
  to the host compiler's (2130 bytes, `fnv=28c333dc`, 877 identical lines of assembly text, 0 libc
  stub hits); x86-64 cases went from 26 to 33, and the front-end root cause behind §3.5 —
  "`sizeof` of a member array silently answered 4" — was fixed (evaluating `AST_MEMBER` during
  parsing fell back to `s = 4`; it is now evaluated in sema, so `sizeof(char sym[512])` goes from 4
  to 512 and the self-host object shrank from 2351 bytes back to 2130).

---

Earlier history in brief (Chinese README only): v0.8.0 made the ARM backend usable for real projects
(a 25-source self-hosting project with `failed=0`) together with the 64-bit data path, static argument
allocation tables, AAPCS struct passing/return, an extended assembler, two levels of register
allocation and the removal of every host-side capacity limit; v0.7.0 reached 98 %+ armcc keyword and
attribute coverage with full DWARF, TLS, scatter files and CPU selection; v0.6.0 added the three-layer
configuration system, VLA, wide characters, trigraphs, `_Complex`, hardware FPU instructions and IR
optimisation; v0.5.0 covered startup/vector tables, HAL/DMA/MMIO, control algorithms and RTOS-grade
projects; v0.4.0 completed C99 plus armcc compatibility; v0.3.0 added floating point, `__svc`, `.s`
compilation and multi-file linking; v0.2.0 introduced the multi-backend architecture; v0.1.0 was a
minimal single-backend ARM subset.
