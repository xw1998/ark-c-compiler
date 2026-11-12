# C11 `_Atomic` and `<stdatomic.h>`

[中文](ATOMIC.md) | English

This document records the compiler's **implementation boundary, diagnostic strategy and
execution-level evidence** for C11 atomic types. The essentials first:

- Exactly **one** target has a real atomic path: `arm` (Cortex-M, single core + PRIMASK critical
  section).
- On the other four targets — `x86` / `x86_64` / `riscv32` / `c` — every atomic operation except
  `atomic_init` (which is just an assignment) and the typedefs is a **compile-time error**, and the
  error text is itself the manual.
- Atomicity is not merely "use the library or not": `x += 1` and `x++` are **read-modify-write** in
  C11, and the compiler always rejects them rather than faking atomicity with LDR/ADD/STR.
- Memory ordering is always implemented as `seq_cst`, and it is **single-core interrupt-level
  mutual exclusion** — it says nothing about cross-core or cross-DMA visibility.

## 1. Why it must be "either truly atomic, or an error"

The easiest way for a C compiler to leave silent wrong answers in production is to quietly demote
atomic operations into ordinary loads and stores: on a single core, `atomic_store(p, v)` expanding to
`*p = v` looks entirely correct, and the loss of updates only shows up once there is real interrupt
nesting, a second core, or a DMA engine — and that class of bug reproduces on a monthly timescale.

This project therefore follows "rather an error than a wrong answer":

| Situation | Behaviour |
| --- | --- |
| `<stdatomic.h>` calls on the `arm` target | real implementation (critical section / indivisible single-word access) |
| atomic operations on the other four targets | compile-time error, `__arkcc_atomic_<op>_not_supported_on_this_target_use_a_mutex` |
| `+=` / `-=` / `*=` / … / `++` / `--` on an `_Atomic` object | compile-time error naming `atomic_fetch_*` |
| `_Atomic` applied to an array / function / `struct`·`union` | compile-time error (C11 6.7.2.4, plus "an aggregate needs a lock") |
| a plain assignment `x = 5` on an `_Atomic` object | allowed (that *is* an atomic store) |
| `atomic_init(&x, v)` | allowed on **all five targets** (it is one assignment, hence portable) |

## 2. Parsing layer

- `include/common.h` gains a dedicated token, `TOK_ATOMIC`; `src/lexer.c` recognises the `_Atomic`
  spelling.
- `parse_declspec()` in `src/parser.c` accepts both spellings — the qualifier form `_Atomic int x;`
  and the type-name form `_Atomic(int) x;` — and sets `g_decl_is_atomic` for both.
- **Atomicity lives on `Type`** (`Type::is_atomic`, see `include/type.h`), produced by a shallow copy
  in `type_atomic()`, structurally the same as `const` / `volatile`. This is not an implementation
  detail but a requirement:

  ```c
  typedef _Atomic int atomic_int;   /* every typedef in stdatomic.h is written this way */
  atomic_int g;                     /* is g still an atomic object here? */
  ```

  If `_Atomic` stopped at a parser-level flag, the `Type` of `atomic_int g;` would be identical to
  that of `int g;` and the read-modify-write checks downstream would have nothing to look at. **Every
  typedef in `stdlib/include/stdatomic.h` uses the `_Atomic` spelling** precisely so that atomicity
  propagates through typedefs.

- `type_atomic()` **shallow-copies and then marks**, it does not mutate a singleton:

  ```c
  Type *type_atomic(Type *t) {
      Type *q;
      if (!t) return t;
      if (t->is_atomic) return t;
      q = (Type *)mem_pool_alloc(sizeof(Type));
      *q = *t;
      q->is_atomic = 1;
      return q;
  }
  ```

  The reason is the same as for `type_qualified()`: one `_Atomic int x;` must not turn every later
  `int` into an atomic type.

- **Position decides meaning**: `type_atomic(base)` is applied at the end of `parse_declspec()`,
  **before** the declarator is parsed. So in `_Atomic int *p` the atomicity lands on the pointee
  (`p` is an ordinary pointer), which matches C11; `int *_Atomic p` (qualifier written after the `*`)
  is not supported in this round — see §7.

- `check_atomic_type()` is called in three places (members / declarators / resets) and produces three
  kinds of refusal:

  | Input | Diagnostic |
  | --- | --- |
  | `_Atomic int arr[3];` | `an array type cannot be _Atomic (C11 6.7.2.4)` |
  | `_Atomic int f(void);` | `_Atomic cannot be applied to a function type` |
  | `_Atomic struct S s;` | `atomic struct/union types are not supported (they need a lock; use one explicitly)` |

## 3. sema layer: read-modify-write is always rejected

C11 6.5.16.2p3 (compound assignment) and 6.5.2.4p2 (`++`/`--`) both define these as
read-modify-write on atomic objects. This compiler cannot emit exclusive instructions
(`LDREX`/`STREX` sequences) nor wrap a "load-compute-store" critical section, so both node kinds are
rejected directly in sema:

```c
static void err_atomic_rmw(AstNode *node, const char *form, const char *use) {
    DiagLoc loc = loc_of(node);
    diag_report_msg(DIAG_SEV_ERROR, &loc,
                    "%s on an _Atomic object is a read-modify-write (C11), which "
                    "this compiler does not lower atomically; use %s from <stdatomic.h>",
                    form, use, 0);
    g_errors++;
}
```

Call sites:

- `case AST_ASSIGN`: `op != TOK_ASSIGN` and the lvalue `type->is_atomic` →
  `form = "a compound assignment"`, `use = "atomic_fetch_add/sub/and/or/xor()"`.
- `case AST_UNARY`: `op == TOK_INC || op == TOK_DEC` and the operand `is_atomic` →
  `form = "an increment or decrement"`, `use = "atomic_fetch_add/sub()"`.

Measured matrix (`atomic_int` comes from a typedef, so this also verifies that `is_atomic`
propagates):

| Source | Result |
| --- | --- |
| `atomic_int g; g += 1;` | error (compound assignment) |
| `atomic_int g; g++;` | error (increment) |
| `atomic_int g; g = 5;` | **no error** — a plain assignment *is* an atomic store |
| block scope `atomic_int x; x += 1;` | error (typedef propagation in effect) |
| `_Atomic int *p;` | no error (`p` is not an atomic object) |
| `_Atomic int q; q = 7;` | no error |

The five RMW bodies in `<stdatomic.h>` are written as `*p = (T)(old + v);` and **not** as compound
assignments, so the library itself is not caught by this new diagnostic — which is exactly why the
implementation deliberately avoids `+=`.

## 4. The two branches of `<stdatomic.h>`

`stdlib/include/stdatomic.h` (about 21 KB) splits on `__ARKCC_TARGET_ARM`.

### 4.1 The ARM branch (real implementation)

Three template macro sets, dispatching on `_Generic(*(p), ...)`:

| Macro | Types covered | Implementation |
| --- | --- | --- |
| `__ARKCC_ATOMIC_SMALL` | 32 bits and below: `_Bool, char, signed/unsigned char, short, unsigned short, int, unsigned int, long, unsigned long, float` | `load`/`store` are plain accesses (an aligned single-word access on a single core is already indivisible); `exchange`/`compare_exchange` go through the critical section |
| `__ARKCC_ATOMIC_LARGE` | `long long` / `unsigned long long` / `double` | load/store/xchg/cas **all** go through the critical section (they do not fit in one word) |
| `__ARKCC_ATOMIC_RMW` | the five `fetch_add/sub/and/or/xor` | "read-compute-write" inside the critical section, body `*p = (T)(old + v)` |

Supporting details:

- The critical section comes from the backend builtins `__arkcc_crit_save()` (`MRS r0, PRIMASK` +
  `CPSID i`, returning the **previous** PRIMASK) and `__arkcc_crit_restore(int)` (`MSR PRIMASK, r0`).
  They were moved out of the `ARKCC_FEATURE_ASM_EXTRA` area, so they work without `--asm-extra`.
  The `atomic_nested_mask` case specifically verifies that nesting semantics are `0,1,1,0` — "restore
  always clears the mask" also compiles, it just re-enables interrupts the caller never asked for.
- `__arkcc_eq8(const volatile void *, const void *)` compares two words for equality so that
  `long long ==` does not drag `__aeabi_lcmp` into a bare image.
- `atomic_flag` is `struct atomic_flag_s { _Atomic int __arkcc_flag; }`, `ATOMIC_FLAG_INIT` = `{ 0 }`,
  `ATOMIC_VAR_INIT(v)` = `(v)`, `kill_dependency(y)` = `(y)`.
- `atomic_is_lock_free(p)` = `((int)(sizeof(*(p)) <= 4))`.
- `atomic_thread_fence` = `__dmb()`, `atomic_signal_fence` = `__memory_changed()` (a compiler
  barrier).

### 4.2 The non-ARM branch (every name is a compile-time error)

Apart from `atomic_init` / the typedefs / `atomic_is_lock_free`, every name expands to
`__arkcc_atomic_<what>_not_supported_on_this_target_use_a_mutex`, where `<what>` ∈
`load / store / exchange / compare_exchange / fetch_add / fetch_sub / fetch_and / fetch_or /
fetch_xor / flag_test_and_set / flag_clear / thread_fence / signal_fence`.

A real error looks like this:

```
"n1.c", line 343: Error:  #20: identifier "__arkcc_atomic_load_not_supported_on_this_target_use_a_mutex" is undefined
```

**Why an undeclared identifier instead of `#error`**: `#error` would detonate on any
`#include <stdatomic.h>`, even in a translation unit that uses no atomic operation at all; expanding
to a name fails only on an **actual call**, and the failure text says directly which operation failed
and what to do instead.

## 5. Memory ordering

Everything is implemented as `seq_cst`: the write side is a critical section / single-word access,
barriers use `__memory_changed()` (a compiler barrier), and on ARM there is additionally `__dmb()` for
`atomic_thread_fence`. Three boundaries are stated explicitly here:

1. This is **single-core interrupt-level mutual exclusion**. `CPSID i` masks this core's interrupts;
   it cannot stop another core from writing the same address concurrently.
2. `DMB` only fixes **ordering**, not cache coherency. Cross-core visibility needs MPU/cache
   maintenance or hardware coherency.
3. `seq_cst` is the strongest ordering and the only one implemented; the implementation does not
   optimise each order separately. Writing `memory_order_relaxed` compiles, but you still get
   `seq_cst` strength.

## 6. Gates and evidence

### 6.1 `tests/run_atomic_tests.py` (cross-target matrix, five targets)

Four stages; any failure exits non-zero:

1. `check_identity`: expand with `-E` and check that `__ARKCC_TARGET_NAME` equals
   `"arm" | "x86" | "x86_64" | "riscv32" | "c"`; that the number of `defined(__ARKCC_TARGET_*)` is
   **exactly 1**; and that `__arm__` / `__thumb__` / `__ARMCC_VERSION` appear only on `arm`.
2. `check_refusal`: four non-ARM targets × **11** atomic operations; each must fail to compile, must
   hit `__arkcc_atomic_<what>_not_supported_on_this_target_use_a_mutex`, and must leave **no** `-o`
   artifact behind.
3. `check_init`: `atomic_init` must compile on all five targets.
4. `selfcheck`: the same source must **not** be refused on `arm` — otherwise "refused" has no
   resolution (anti-false-green).

### 6.2 `tests/arm_exec/run_arm_exec.py` (execution level under unicorn)

| Case | Expected | Meaning |
| --- | --- | --- |
| `atomic_rmw` | 10 | load/store, exchange, both CAS paths (success writes the object; failure writes the **`expected` operand** back), `atomic_flag`, the five RMWs |
| `atomic_nested_mask` | 6 | nested saved values encoded bitwise as `0,1,1,0` ⇒ `1<<1 | 1<<2` = 6, aimed squarely at "restore always clears the mask" |
| `atomic_wide` | 6 | the 64-bit path: `12/2 + 4300000000%2 = 6`, reachable only if a failing CAS leaves the object untouched and reports failure correctly |
| `atomic_reject` | 3 diagnostics | the three refusals (array / function / struct), with no image left behind |

In `atomic_wide`'s expected value, `4300000000u` doubles as a regression point for the integer
literal candidate table (C99 6.4.4.1p5: decimal with `u` ⇒ `unsigned long long`) — the old
implementation truncated it to `0x004CA300` here.

### 6.3 How to run

```
make test-atomic PYTHON="<path-to-python>"
python tests/run_atomic_tests.py --arkcc ./arkcc.exe
python tests/arm_exec/run_arm_exec.py            # needs unicorn; 29 cases in total
```

## 7. Registered limitations (written boundaries, not TODOs)

1. **`int *_Atomic p` (qualifier after the `*`) is unsupported**: `_Atomic` is only recognised in
   declspec, so only `_Atomic type` and `_Atomic(type-name)` are covered.
2. **Read-modify-write through a pointer is not intercepted**: in `*p += 1` where `p` points at an
   `_Atomic` object, sema looks at the expression type of `*p` and `is_atomic` does not propagate
   through the dereference, so no error is reported. Use `atomic_fetch_add(p, 1)`.
3. **Aggregate atomic types are unsupported**: `_Atomic struct` needs a lock, and it is rejected on
   the spot instead of pretending the access can be atomic.
4. **There is no `<threads.h>`**: `thrd_create` and friends are out of scope; `_Atomic`'s value in
   this project is interrupt-level synchronisation, not multithreading.
5. **Line numbers are post-preprocessing**: the preprocessor emits no line markers, so diagnostics
   after `#include <stdatomic.h>` land on the expanded stream (pre-existing behaviour, not specific
   to `_Atomic`).
6. **Only `arm` has a real implementation**: `lock xadd` / `cmpxchg16b` are not wired into the
   `x86_64` backend; that is a separate piece of work, in the same batch as the RV64 / ARM64
   backends.

## 8. Change list

| Location | Change |
| --- | --- |
| `include/common.h` | `TOK_ATOMIC` |
| `include/type.h` · `src/type.c` | `Type::is_atomic`, `type_atomic()` |
| `src/lexer.c` | the `_Atomic` keyword |
| `src/parser.c` | `g_decl_is_atomic`, `check_atomic_type()`, `type_atomic(base)` at the end of declspec |
| `src/sema.c` | `err_atomic_rmw()` + rejection of compound assignment / `++` `--` |
| `src/backend/arm/backend_arm.c` | `MRS`/`MSR` freed from the `--asm-extra` gate; `__arkcc_crit_save` / `__arkcc_crit_restore` builtins |
| `include/preproc.h` · `src/preproc.c` · `src/compiler.c` | `preproc_set_target()`, `__ARKCC_TARGET_*` identity macros, and the whole armcc macro set undefined on non-arm targets |
| `stdlib/include/stdatomic.h` | the complete atomic interface (real on ARM / compile-time refusal elsewhere) |
| `tests/run_atomic_tests.py` · `tests/arm_exec/run_arm_exec.py` · `tests/run_install_tests.py` | the gate and the install manifest (39 files) |
