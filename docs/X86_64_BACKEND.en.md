# The x86-64 backend (SysV AMD64)

[中文](X86_64_BACKEND.md) | English

For a long time `-target x86_64` was nothing but an alias of `x86`: `backend_x86_64.c` contained a
single copy of the i386 cdecl code, so `long long`, pointers and `double` were all treated as 32-bit.
It is now a **real backend**, sharing one source file with i386
(`src/backend/x86_64/backend_x86_64.c`) but following two independent code-generation paths:

| Backend name | `pointer_size` | ABI | Assembler | Image base |
| --- | :---: | --- | --- | :---: |
| `x86` | 4 | i386 cdecl (`ARK_ABI_SYSV`) | `x86_assemble` | 0 (position-dependent; relocations are image-relative) |
| `x86_64` | 8 | SysV AMD64 | `x86_assemble64` | `0x400000` (data addressed RIP-relative, position-independent) |

Aliases: `x86-64`, `amd64` → `x86_64`; `i386`, `i686` → `x86`. `ark_backend_x86_64()` still returns
the i386 backend (historical compatibility); new code uses `ark_backend_amd64()`.

## 1. Code-generation model

No IR change and no front-end change: it is **still the "4 bytes per IR word" model with
`pointer_size = 8`**. The backend keeps two things apart — the IR word width is the compiler's
internal convention, while the physical width is decided by `pointer_size` and by the flags on
`wires[]`.

- Frame: `LSZ = (local_size + 15) & ~15` (at least 16), `FRAMELO = 48 + LSZ`,
  `FRAME = (FRAMELO + 512 + 15) & ~15`
- Scalar slots: `[rbp-8]` sret pointer, `[rbp-16]` saved rsp, `[rbp-24..rbp-48]` scratch
- Argument temp slot `k`: `-FRAMELO - 8*(k+1)`, `k = 0..63`
- Prologue `push rbp; mov rbp,rsp; sub rsp,FRAME`, epilogue `mov rsp,rbp; pop rbp; ret`
- Argument classification: integers/pointers go in `rdi rsi rdx rcx r8 r9`, `float`/`double` in
  `xmm0-7`; the two classes count independently and spill to the stack once exhausted (8 bytes per
  slot, right to left); `al` holds the number of xmm registers used by this call
- When `pointer_size == 8`, `irgen` marks pointers and "named parameters that are aggregates larger
  than 8 bytes" with `8 | IR_AUX_SLOT64` and forces registration of the `argbytes` side table
  (see §3.3)

## 2. Transfer conventions (internal)

- **Return values**: integers/pointers up to 8 bytes go in `rax`; a 64-bit result is **entirely in
  `rax`** (not "only the low half is valid in `rdx:rax`"); `float`/`double` go in `xmm0` (bit 53 of
  `IR_CALL`). Two-word results are split explicitly at the call site with
  `mov rdx,rax; shr rdx,32`.
- **sret**: aggregates larger than 8 bytes are allocated by the caller with the pointer in `rdi`,
  saved by the callee at `[rbp-8]`. The **receiving** direction is supported; the **initiating**
  direction (returning an aggregate larger than 8 bytes by value) is still on the error list.

## 3. Five silent wrong answers fixed in this round

All five share one property: **the compile exits 0, the image runs, and the answer is wrong.** The
first four live in the x86-64 backend; the fifth (§3.5) lives in the evaluation time of `sizeof` and
only surfaces during **self-hosting**.

### 3.1 A 64-bit return value truncated to its low 32 bits

The call site used to emit `mov eax,eax; mov edx,edx; push rax; push rdx`, treating `rdx` as the high
word. But the callee's `IR_RETURN` goes through `amd_pop64(rax)`, which rebuilds the full 64 bits in
`rax` while leaving `hi << 32` in `rdx`. So `(hi<<32) & 0xFFFFFFFF == 0` and the high word always read
as 0.

The fix stops relying on leftovers in `rdx`:

```
    mov rdx, rax
    shr rdx, 32
    mov eax, eax
    push rax
    push rdx
```

### 3.2 Scratch-register collision in `amd_push64`/`amd_pop64`

Both helpers hard-coded `rdx` as scratch, so `amd_push64("rdx","edx")` (exactly what `IR_LOAD_IDX`
does when reading an 8-byte field) destroyed itself: `mov rdx,rdx` was a no-op, `shr rdx,32` wrecked
the value, and the two words pushed were both the high half. The new helper

```c
static const char *amd_scratch_for(const char *r64) {
    return ark_streq(r64, "rdx") ? "rcx" : "rdx";
}
```

is used by both throughout, which removes the whole "passing rdx self-destructs" class at the root.

### 3.3 Pointer / large-aggregate parameters did not register the `argbytes` side table

`wires[i] = 8 | 0x20000` means "8 bytes but only 1 IR word". The call site needs the `argbytes` side
table to know "this slot is 64-bit", and the side table is **only registered when `wire_extra` is
true**. Both the pointer branch and the large-aggregate branch forgot to set `wire_extra = 1`, so the
call site fell back to `argmask` and loaded a 32-bit address with `mov edi, dword ptr [tmp]` — which
still appears to work as long as every address fits in 32 bits, but is already semantically wrong.
The fix:

```c
    wires[i] = 8 | 0x20000;
    wire_extra = 1;                                  /* TYPE_PTR branch */
    ...
    else if (ssz > 8 && pt != 0 && g_irgen_slot64_ptrs) {
        wires[i] = 8 | 0x20000;                      /* a large named aggregate is passed by pointer */
        wire_extra = 1;
    }
```

### 3.4 `rep movsb` emitted only the prefix byte

The built-in assembler's generic operand scan consumed `movsb` as an operand, so by the time the
`rep` branch read the line again it was at end-of-line; only an isolated `0xF3` was emitted (which
then became an invalid prefix of the next instruction) and `IR_MEMCPY` **copied nothing**. The
disassembly shows it plainly: `mov ecx,0x10` is followed directly by `add rsp,8`.

The fix rewinds to before the operand scan, re-reads the mnemonic and looks it up
(`movsb/movsw/movsd/movsq/stosb/stosd/stosq/lodsb/scasb/cmpsb`); on a hit it emits `0xF3`
(+ optional `0x66`/REX.W) and the opcode, and on a miss it **always** does `error_count++` plus an
error message, never a bare prefix. The i386 backend had been silently dropping the copy in the same
way.

### 3.5 `sizeof` of a member array folded to 4 (only visible when self-hosting)

This one is not a backend defect: it is **the front end answering 4 for something it does not know**,
and since the host arkcc built by GCC never takes that path, it stayed invisible to the x86-64
execution gate for a long time.

**Symptom**: the "arkcc compiled by arkcc" inside the self-host image compiles the whole payload and
produces a 2351-byte object, while the host compiler gives 2130 bytes. The self-host side has **20
relocations** (the host has 3), and the relocation symbol names are **only the first 3 characters**:
`accumulate`→`acc`, `classify`→`cla`, `g_items`→`g_i`, `g_names`→`g_n`, `.Lclassify_1`→`.Lc`.

**Localisation**: first made the probe dump the generated assembly text as well (`g_asmout`); the
result was that the **self-hosted and host `-S` outputs are identical over 877 lines** ⇒ the fault is
not in irgen but in the **assembler**. Going one level down: the loop in `xa_parse_operand` that
copies a symbol name into `op->sym` is bounded by `sizeof(op->sym) - 1`; the host-built machine code
is `mov eax, 512; sub eax, 1` while the self-hosted one is `mov eax, 4; sub eax, 1` ⇒ **only 3 bytes
are copied**.

**Root cause**: the `sizeof expr` branch in `src/parser.c` evaluates at **parse time**, relying on
`e->type`; but the type of an `AST_MEMBER` (`s.f` / `p->f`) only exists after **sema** ⇒ it falls
into the fallback `if (s <= 0) s = 4;` ⇒ `sizeof` of a `char sym[512]` member **silently answers 4**.
(The host side miscomputes it too, but the host is built by GCC and its assembler is not arkcc, so the
wrong answer stayed underwater.)

**The fix** (4 files; the principle is "if you do not know, do not say 4"):

- `include/ast.h`: add `AstNode *sizeof_operand;` (NULL = already folded) and declare
  `ast_sizeof_pending()`
- `src/ast.c`: `ast_new` initialises that field (`ast_new` does not clear the union, so a new field
  must be zeroed explicitly); add `ast_sizeof_pending()` (`u.num_val = 0`,
  `sizeof_operand = operand`)
- `src/parser.c`: `sizeof expr` gains an `s_known` flag — the five qualifiable fast paths (string
  literal, expression with an existing `type`, `AST_VAR`, function return value, array element) behave
  exactly as before, everything else becomes `ast_sizeof_pending()` and is handed to sema
- `src/sema.c`: for `AST_SIZEOF`, if `sizeof_operand` is non-NULL, run `sema_expr` on the operand,
  back-fill with `type_size` and clear the field; when `type_size <= 0` report
  `'sizeof' applied to an incomplete or untyped operand` instead of answering 4. `eval_const_expr`
  returns 0 for an unevaluated sizeof ⇒ code using it as an array dimension or case label now **fails
  explicitly** instead of quietly computing with 4.

**Verification**: `sizeof(s.sym)` / `sizeof(p->sym)` go from 4 to 512, `sizeof(struct S)` is 516; the
gate gains `sizeof_member_array`; the self-host object goes from 2351 bytes back to **2130 bytes,
3 relocations, `fnv=28c333dc` (identical to the host)**.

## 4. Two intentional behaviour changes on i386

These are bug fixes, not regressions. Comparing byte for byte against the old binary at `d6000a0`,
21 of 80 sources produce different i386 output, and **every difference belongs to item ①** (item ②
only appears in sources with aggregate copies, and none of those 21 have one).

① **Alignment before a call**: previously arguments were `push`ed first and then `and esp,-16`, which
pushed the freshly pushed arguments **below `esp`**, so the callee read garbage at `[ebp+8]`.

```
old:  push dword ptr [ebp-80]
      and esp, -16
      call factorial
new:  mov eax, esp
      sub eax, <total argument bytes>
      and eax, 15
      sub esp, eax
      push dword ptr [ebp-80]
      call factorial
```

② **`rep movsb` now really emits bytes** (see §3.4), so aggregate copies start working.

## 5. The four historical i386 debts: all cleared

The four former defect classes (`movq needs an xmm operand`, 64-bit arithmetic `UC_ERR_EXCEPTION`,
structs passed by value returning huge numbers, local array indexing reading the wrong element) are
**all fixed**, and i386 and x86-64 now run the same programs with the same answers. The tables in this
section are the historical record; below them are the measured post-fix readings, and the x86-64 gate
no longer marks any class as SKIP.

### 5.1 Local array indexing: the frame mapping became structurally identical to x86-64

The root cause was that the 32-bit emitter located locals as `[ebp - (48 + off)]` (computed that way in
four places: `IR_STORE`, `IR_PUSH_VAR`, `IR_PUSH_ADDR`, `IR_GETARG`): frame offset up ⇒ address down,
whereas `IR_LOAD_IDX` and `&obj + k` walk the address space as `base + i*es`, so "initialising writes"
and "indexed reads" went in opposite directions. The 32-bit frame mapping became
`[ebp - framelo + off]` (`framelo = 48 + round16(local_size)`), structurally identical to x86-64;
`sret_area_off`, the variadic area and the scratch layout shifted with it.

Measured (the array family in `tests/run_x86_64_image_tests.py`, asserted per case on both backends):

| Source | Expected | x86_64 | x86 |
| --- | :---: | :---: | :---: |
| `int a[3]={1,2,3}; return a[0]+10*a[1]+100*a[2];` | 321 | 321 | 321 |
| `const char *p[2]={"ab","cd"}; return p[1][0];` | 99 | 99 | 99 |
| `int a[3]={1,2,3}; int b[3]={4,5,6}; return a[1]+10*b[1];` | 52 | 52 | 52 |
| `int a[4][3]; … nested indexing` | 43 | 43 | 43 |
| reading a member of `struct {int v;} a[2]` | 987 | 987 | 987 |

### 5.2 Structs passed and returned by value (sret)

Structs **larger than 8 bytes** use a hidden return buffer plus address passing; **8 bytes or less**
use `edx:eax`. Measured: five groups 765 / 321 / 987 / 777 are identical on both backends, and the two
`sret` / `sret2` probes agree case by case.

**The last remnant (`struct_sret40`, 40 bytes returned by value)**: on i386, `T5 x = mk5(3)` came back
all zeros. The root cause was that the callee's argument-reading loop used `reg_idx` as its bound:

```c
for (j = 0; j < reg_idx && j < 64; j++)      /* for sret functions reg_idx also counts the hidden pointer */
    stk += width_of(param_types[j]);
```

Inside an sret function `reg_idx` is one larger than the real argument index (the hidden return-buffer
pointer occupies index 0), so this "accumulate the widths of the preceding arguments" loop also added
**the current argument's own width**: `v` of `mk5(int v)` lives at `[ebp+12]` but was read at
`[ebp+16]`, which is exactly the high half of the return-buffer pointer (0) — hence `x.a`, `x.b` and
`x.c[0..3]` were all 0 and only `x.c[4]` was 4. The fix replaces the bound with "the number of real
preceding arguments" (`param_idx - 1`, `param_idx` having already been incremented); in non-sret
functions the two are equal by construction ⇒ zero change everywhere else.

After the fix the six fine-grained probes agree on both backends (`s_a=3`, `s_b=6`, `s_c0=3`,
`s_c4=7`, `s_all=19`, `s_ptr=16`), `struct_sret40`'s i386 value goes from 4 to 19, the old
`(known 32-bit backend gap)` note on that line is gone, and **the gate was upgraded so that an i386
result differing from the expectation FAILS** — the old wording treated i386 as a footnote, which is
exactly the loophole that let regressions stay green.

### 5.3 Floating point: `x86_pair_swap_at` was a no-op at offset 0

A `double` travels on the stack "high word on top", so the two words must be swapped before
`movq xmm0,[esp]`. `x86_pair_swap_at(&buf, off)` used to read `if (off) { print [esp+off+4] }`, so with
`off == 0` **both reads addressed `[esp]`**, the swap degenerated into a no-op and `movq` loaded
hi:lo as lo:hi into xmm0. Measured: `double d=7.9; (int)d;` gave 0. The fix is to always print both
displacements.

After the fix the 17 floating-point cases (9 in `f32` + 8 in `f32b`) agree, including compound
expressions of the "compute then convert" kind such as `g3=59`, `g4=6`, `g5=7`, `g8=10`.

### 5.4 64-bit integers: four root causes

| Root cause | Symptom | Fix |
| --- | --- | --- |
| `IR_UNARY` ignored `I->val` | `-1000000000LL` became +1000000000 (only the high word was negated, and the stack drifted by 4 bytes) | new `I->val == 2` branch (64-bit neg / bnot / logical not) |
| the `|a|` mask in 64-bit division was written `sar esi,31` | every division with a negative dividend was wrong (`-1000000000LL/1000000` gave 140463611) | became `neg esi`: `esi` holds the 0/1 sign bit, and `sar 31` of it is 0 ⇒ `|a|` was never taken |
| the division shift chain used `add ecx,ecx` | every 64-bit division answered 0 | all four words use an `add/adc` chain |
| `IR_PUSH_INT` has only 1 word | 64-bit constants go through `IR_64PUSH` (val=high32, aux=low32) | the front end already splits this way; recorded here as the convention |

Measured: `i64` 14 cases, `i64b` 4 cases, `neg` 6 cases all agree on both backends
(`p_sub=4294966296`, `p_mod=182`, `p_shl=8`, `p_add=4000`, `n5` (`-1e9LL>>20`)=4294966342).

### 5.5 Three wrong values in the C tier (fixed in the same round)

| Defect | Trigger | Fix |
| --- | --- | --- |
| float/double local `++`/`--` added integer 1 | `double d=1.5; d++` added 1 to the bit pattern and stored only 1 word | the `AST_VAR` branch of irgen gained a floating-point path (`irgen_push_step` + `IR_FADD` + 8-byte store) |
| `IR_BINARY` did only 32-bit arithmetic on 8-byte pointers | `p+n` truncated at 4 GB, `p<q` compared only the low halves | irgen sets `IR_AUX_SLOT64`, the x86-64 emitter uses the `rax/rcx` form |
| pointer ↔ `long long` conversion was a no-op | `char *q=p+4; (long long)q` gave 0 (want 5) — a pointer is 1 word and `long long` is 2, so the high half was stack garbage | irgen gained `irgen_ptr_to_int64`/`irgen_int64_to_ptr`, wired into cast / declaration initialisation / assignment / `return` / call arguments; x86-64 splits and merges that word with `IR_SEXT`/`IR_ZEXT` + `IR_AUX_SLOT64`, 32-bit targets use `PUSH 0`/`POP` |

The measured pointer family (11 constructs, asserted on both backends; a 32-bit pointer cannot hold
more than 4 GB, so two cases differ by ISA):

| Source | x86_64 | x86 |
| --- | :---: | :---: |
| `q=p+4; (long long)q` | 5 | 5 |
| `long long d=q;` (implicit assignment) | 5 | 5 |
| `(long long)q >> 32` (`p=(char*)0x100000000LL`) | 1 | 0 |
| `long long d; d=q; d=d+1;` | 6 | 6 |
| `(char*)5LL + 2` | 7 | 7 |
| `(char*)0x300000000LL != 0` | 1 | 0 |
| `f((long long)q)` / `f(q)` (`long long f(long long)`) | 6 | 6 |
| return value of `long long f(char *q){return (long long)q;}` | 10 | 10 |
| `(char*)(long long)p == p` | 1 | 1 |

> Convention: converting `0x100000000LL` to a 32-bit pointer necessarily truncates to 0 — that is an
> ISA fact, not a backend difference. On x86-64, `(long long)q >> 32` must give 1, which is precisely
> the discriminating point for "the high half cannot be zero-filled".

## 6. Single-file images refuse unresolved symbols

When `resolve_refs_x` cannot find a label it leaves the disp32 as all zeros, so `call foo` becomes
`call +0`: the image calls itself and spins forever while `arkcc` exits 0. A bare image has no linker
to patch this up, so `compiler.c` got the same check for `x86` / `x86_64` that already existed for
`arm` (via `x86_get_reloc_count()` / `x86_get_reloc_name()`): an unresolved reference is an error and
**no image is written**. `-c` keeps relocations and `-link` resolves them, so neither is affected.

## 7. Gates

```
make test-x86-64                  # already part of make test
python tests/run_x86_64_image_tests.py --arkcc ./arkcc.exe
```

35 programs are compiled into flat 0x400000 images and run by calling `main` on a 64-bit unicorn core,
each asserting a **constant computed outside the program** (host gcc is not used as an oracle); the
same program is **then compiled again for 32-bit and run on a 32-bit unicorn core**, and an `i386`
column that differs from the expectation is a FAIL (it used to be a footnote, which is why "a known
32-bit gap" never went red). The table below lists anchor cases only, not the whole set:

| Case | Coverage | Expected |
| --- | --- | :---: |
| `int_args_9` | 6 register arguments + 3 stack arguments | 34 |
| `ll_mul` | 64-bit result in rax, split at the call site | 7 |
| `ull_div` | unsigned 64-bit division (high half participates) | 74 |
| `struct_ll_field` | reading an 8-byte field through a pointer | 21 |
| `ptr_walk` | 8-byte pointer arithmetic | 84 |
| `float_mul` | a `double` argument in xmm, result in xmm0 | 23 |
| `float_add` | single-precision path | 16 |
| `struct_byval` | 8-byte struct returned by value + 24-byte struct passed by value | 45 |
| `func_ptr` | indirect call through a 64-bit function pointer | 42 |
| `fib_switch` | recursion + jump table | 99 |
| `struct_copy16` | 16-byte aggregate copy (`rep movsb` really emitting bytes) | 11 |
| `ull_loop` | 40 iterations of 64-bit multiply-add | 187 |
| `signed_div` | truncating division and remainder with negatives | 68 |
| `double_cmp` | the four `double` comparisons | 1001 |
| `mixed_8_args` | `int`/`long long` interleaved across the 6 integer registers | 22 |
| `data_array_init` | `int g[4]={1,2,3,4}`: `.quad` must emit both half-words (the high half used to be dropped ⇒ `{1,0,3,0}`) | 30 |
| `rodata_ptr` | `const char *msg="hello"`: a static absolute pointer must include the image base (it used to stay 0) | 35 |
| `fptr_table` | a static function-pointer table: every entry must point at the real function (they all used to point at the image start) | 14 |
| `struct_sret24` / `struct_sret40` | 24/40-byte structs returned by value: the callee must really copy the payload into `*sret` (the copy used to be dropped entirely) | 38 / 19 |
| `ptr_array_init` | initialising local and file-scope pointer arrays: each element occupies a full 8 bytes, and both indices and contents must be right | 0 |
| `sizeof_member_array` | `sizeof(s.sym)` / `sizeof(p->sym)` are the member array's size, not 4 (§3.5) | 0 |
| `ptr_llong_roundtrip` | pointer ↔ `long long` in both directions: the high half must be filled and dropped (it used to be all zeros, §5.5) | 5 |
| `ptr_llong_arg` | a pointer passed as a 64-bit argument and returned as a 64-bit result | 41 |

Plus three further stages that make those PASSes mean something:

- **`-c` / `-link` across TUs**: `globals_two_objs` (an initialised global array + a string + two
  functions) is split into two source files, each compiled with `-c` and then joined with `-link` and
  run, expecting 23. It also pins `X86_RELOC_SELF_BASE`(7): an absolute reference inside an object must
  be settled against **the object's own base**, which is not known yet when `-c` writes the object.
- **refusals**: referencing an undefined external function must fail the build and leave no image
- **selfcheck**: one case is re-run with an "expectation + 1" and must be judged DIFF. A harness that
  cannot detect a wrong answer proves nothing about any pass

Current measurement: `35 passed, 0 failed, 0 skipped`.

### 7.1 The self-host gate: turning "it runs once" into "it reproduces the host object byte for byte"

```
make test-x86-64-selfhost
python tests/run_x86_64_selfhost.py --arkcc ./arkcc.exe
```

This gate has four steps, each of which can fail independently:

1. **Self-compilation**: the x86-64 arm uses `-c` to compile **24 of its own translation units**
   (`src/*.c` minus `main.c`/`registry.c`, plus the four backends and `registry.c`); any single one
   failing to compile is a FAIL, with no downgrade.
2. **Link the image**: the 24 objects + `tests/selfhost/selfprobe.c` (standing in for `port/host/*`) +
   `tests/selfhost/libcstub.c` (standing in for libc's memory/string/`vsnprintf` entry points; any real
   file or stream call records `g_stub_hits`, and the gate requires it to be 0) are joined with
   `-link -v` into a roughly 6.0 MB flat image at base 0x400000.
3. **Run the self-hosted compiler under unicorn**: the probe puts the payload source in
   `g_payload_src` and writes output into a RAM buffer, so the whole "read file / write file" host I/O
   is replaced — what remains is exactly **front end / optimisation / backend / assembler / object
   writer**. The probe also records `g_stub_hits`; the moment the self-hosted compiler touches any libc
   stub the gate FAILs (that would mean the path is not implemented in this image).
4. **Compare**: the same payload is compiled again by the **host** arkcc, and the two ARKOBJ2 files are
   compared **byte for byte** (length + fnv-1a). Only equality is a PASS.

It does one more diagnostic thing along the way: the probe also stores the **assembly text** the
self-hosted compiler produced and compares it line by line with the host's `-S` output. Equal text but
unequal bytes ⇒ the difference is in the assembler; unequal text ⇒ it is in code generation. On
2026-11-12 this is exactly what shrank §3.5 from "a 221-byte difference" to "`sizeof` of a member
array".

Current measurement:

```
self-compiled 24 translation units
built self-host image: 6256161 bytes
asm  : text identical (877 lines)
probe: ark_compile rc=0 object=2130 bytes fnv=28c333dc
probe: libc stubs hit 0 (expected 0), unknown printf conversions 0
host : object=2130 bytes fnv=28c333dc
PASS self-host: byte-identical object
```

**What this gate proves and does not prove** (anything less would be an overstatement):

- It proves: the compiler can compile itself into x86-64 machine code, can link, can **run on a 64-bit
  core and complete a full compilation**, with an object byte-identical to the host's. In other words
  the x86-64 backend covers "the entire language subset the compiler itself uses + the entire IR + the
  entire assembly syntax".
- It does **not** prove: that a compiler **binary** can execute directly on a real operating system. A
  flat image has no ELF/PE header, no dynamic linking and no OS syscall layer; `main` and libc are both
  provided by the probe. Running on a platform additionally needs "image + loader + syscall adapter",
  which is outside this gate.
- It also does not prove: that optimisation levels beyond `-O`, `_Complex`, or variadic function
  **definitions** (the shapes explicitly unsupported in §8) hold on the self-host path — neither the
  payload nor the self sources use them.

## 8. Explicitly unsupported (an error at construction time, never a silent downgrade)

First, a fact that is **no longer a gap** (this section used to say "variadic function definitions are
unsupported", which no longer holds): both x86-64 and i386 support variadic function **definitions**,
and `va_arg` with `int` / `long long` / pointers / `double` / aggregates up to 8 bytes has really run in
the gate or in probes — `sum2(4,1,2,3,4)=20` (gate case `varargs_copy`), `sd(3,1.5,2.5,3.0)=7`,
`sl(1,3000000000LL)%251=59`, `ss(1,{1,2})=3`. Passing and returning aggregates larger than 8 bytes by
value is also supported (`struct_byval=45`, `struct_sret24=38`, `struct_sret40=19`, and a 64-byte return
body), and an 18-argument call (9 registers + 9 stack slots) compiles as well.

What is genuinely unsupported is only the following, all **errored at construction time**:

| Unsupported shape | Current behaviour |
| --- | --- |
| every `_Complex` shape | both backends error during code generation (`real to complex conversion is not supported by the x86_64 backend` / `_Complex float store is not supported` / `[x86] _Complex value not supported`) |
| `va_list` as a **file-scope object** | `__builtin_va_list g_ap;` reports `expected declaration at top level`; `va_list` inside a function is fully usable |
| a single 16-byte load/store, `IR_DUP > 4`, more than 64 parameters | internal IR/emitter limits. The only C shape that needs a 16-byte read or write is a 16-byte aggregate, and aggregates are copied with `rep movsb` (`struct_copy16=11`), so they are unaffected |

`sizeof(long double) == 8` (`long double` equals `double`) is deliberate: C99 only requires long
double's value set to be **at least** that of double, so equality is legal and is not a downgrade.

C++ is out of scope. One known unguarded spot: `.cpp`/`.cxx` input is compiled as C without an error,
which means you get C semantics (no `bool` type name, no classes, no overloading, no references) — do
not use it as a C++ compiler.
