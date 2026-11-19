# `--warn-mem`: an intra-procedural memory lint

[中文](MEMLINT.md) | English

`--warn-mem` is one pass over the AST that runs after semantic analysis. It does **two
things**:

1. **returning the address of an automatic object** — `return &x;`, `return local_array;`,
   `return &local.field;`, `return (T){...};`
2. **double free / use-after-free inside one function** — the object must be a pointer that
   came directly from `malloc`/`calloc`/`realloc`/`strdup`, never escaped and never
   reassigned.

The conclusion up front: **passing this lint does not mean the program is memory-safe.**
In C, "this pointer owns that block" is not part of the type system, so no analysis can turn
these two checks into a guarantee. Rust can, because it changed the language first (no
aliasing, ownership in the types). The goal here is to **report only what can be proven**:
missing a defect is the accepted failure mode, a wrong report is not.

Gate: `tests/run_memlint_tests.py` (`make test-memlint`, part of `make test`); 22 assertions,
all passing.

## 1. Check A: returning the address of an automatic object

The test is purely syntactic: after peeling type casts, the operand of `return` is

| Form | Reported | Note |
| --- | --- | --- |
| `return &x;` where `x` is a block-scope variable | yes | reported as `automatic object "x"` |
| `return &s.b;` where `s` is block scope | yes | `a.b` / `a[i]` are walked back to the root object `s` |
| `return a;` where `a` is a block-scope array | yes | the array decays to a pointer to itself |
| `return (int[]){1,2,3};` | yes | a block-scope compound literal is automatic too |
| `return (T*)&x;` | yes | a cast does not change which object was addressed |
| `return &g;` where `g` is file scope | no | it lives until the program ends |
| `return &s;` where `s` is `static` | no | static storage duration |
| `return &p->b;` where `p` is a **pointer parameter** | no | `b` is in the caller's object, not ours |
| `return &*p;` | no | no object is created by that expression |
| `return a[1];` | no | that is a copy of a value |

The only false-positive surface is a caller that never dereferences the result. That is still
a defect, which is why the message says "ceases to exist when this function returns" rather
than "this will crash".

## 2. Check B: double free / use-after-free

Only pointers whose whole lifetime is visible are tracked. Each name carries a three-valued
cell:

```
ALIVE   -- came straight from malloc/calloc/realloc/strdup, not yet released
DEAD    -- already freed
UNKNOWN -- not known (escaped, reassigned, branches disagreed, ...): stays silent
```

After `p = malloc(n);` the following are reported:

| Code | Reported | Text |
| --- | --- | --- |
| `free(p); free(p);` | yes | `"p" is freed twice` |
| `free(p); p[0] = 1;` | yes | `use of "p" after it was freed` |
| `free(p); *p = 0;` | yes | same |
| `free(p); p->a = 1;` | yes | same |

The following are **never** reported (each is a real program; the reason is the boundary):

| Code | Why silent |
| --- | --- |
| `free(p); p = 0; p[0] = 1;` | `p` no longer names that memory; reassignment drops the tracking |
| `p = realloc(p, n);` | `realloc` can revive; registered as ALIVE again |
| `free(p + 1);` | not the pointer value that was tracked |
| `if (c) free(p); p[0] = 1;` | DEAD on one path, ALIVE on the other: merged to UNKNOWN |
| `sink(p);` (passing `p` elsewhere) | ownership escaped, nothing is claimed afterwards |
| `free(p); p = malloc(16);` | new object, new lifetime |
| a function containing `goto`, a label, or `asm`/`__asm` | the **whole function is abandoned** |
| `free` called through a function pointer | not recognised (guessing once can guess wrong) |
| reference counts dropping to zero, setjmp/longjmp | outside the model |

Hard limits: **8 tracked pointers / 32 local names**. When a table is full the **whole
function is abandoned** — old entries are never evicted to keep guessing. Branches and loops
use "snapshot then merge": identical on both sides keeps the state, a disagreement becomes
UNKNOWN.

So the reading is: **what is reported is real (in the no-false-positive sense); what is not
reported is not thereby safe.**

## 3. Switches and trimming

Three layers, all off by default; with them off neither size nor behaviour changes:

| Layer | Name | Default | Effect |
| --- | --- | --- | --- |
| compile time | `ARKCC_FEATURE_MEMLINT` | host profile `1`, `ARKCC_PROFILE_STM32_MIN` `0` | at `0` the pass is not compiled at all and costs no Flash |
| run time | `--warn-mem` / `--no-warn-mem` | off | the last one on the command line wins |
| config file | `[features]` section, `warn_mem=1` | off | same as the switch; the command line wins |

To have the check on the board, rebuild with:

```sh
gcc ... -DARKCC_FEATURE_MEMLINT=1        # or change the profile default in arkcc_config.h
```

**When the feature is compiled out, both entries refuse instead of pretending the check
ran:**

```
Fatal error: C3900U: --warn-mem is not compiled into this build (rebuild with -DARKCC_FEATURE_MEMLINT=1)
```

The command-line switch and `warn_mem=1` in a config file take the same path and produce the
same diagnostic. `--no-warn-mem` is accepted by every build (it only asks for the default).

### Measured numbers (the caliber is written next to each one)

| Metric | Reading | Caliber |
| --- | --- | --- |
| code size cost | `-O2`: `+5,424 B` text; `-Os`: `+4,436 B` text | host x86-64 gcc, same sources, only `-DARKCC_FEATURE_MEMLINT=0/1` differs, `size`'s `text` column; **not** Cortex-M7 bytes — Thumb-2 ratios differ, the magnitude is the same |
| data/BSS cost | `0` | same measurement: `data` and `bss` columns are identical; no global table, no allocation |
| stack | about `900 B` fixed frame per analysed function | `MlPtr p[8]` + `MlLocal loc[32]`, released when the function returns |
| default output | **byte-identical** | 12 `.o` files: `examples/{hello,arith,func}.c` × `arm`/`x86`/`riscv32`/`x86-64`, all `cmp`-identical against an `arkcc` rebuilt from `5350048` with the same gcc command |

## 4. Relation to `--diag_suppress`

Neither diagnostic carries an armcc code (project rule: codes are used only for measured
armcc behaviour), so `--diag_suppress <code>` cannot target them. Turning them off means
turning `--warn-mem` off.

## 5. What the gate actually checks

`tests/run_memlint_tests.py` embeds three source files, none of which `#include` anything
(after preprocessing arkc reports line numbers in the preprocessed buffer — existing
behaviour — and self-contained `extern` declarations keep the offsets at zero). Expected
lines are located by `ANCHOR:` comments rather than hard-coded numbers.

| Group | Assertions |
| --- | --- |
| positives | the 8 shapes are each reported once, on the right line, with the right text; the **total is exactly 8** (over-reporting also fails); still `0 errors`, exit code 0 |
| negatives | the 12 shapes from the "never reported" table in one file: **zero output** |
| legal twins | the 8 defects rewritten correctly: zero output (so the gate cannot just be matching the shape of the text) |
| switch | the same defective file is silent without `--warn-mem`; `--warn-mem --no-warn-mem` is silent; the reverse order turns it back on |
| trimming | rebuilds arkcc on the spot with `-DARKCC_FEATURE_MEMLINT=0`: `--warn-mem` **and** `warn_mem=1` from a config file must both give `rc != 0` plus `C3900U`, while the same file compiles normally with zero warnings |

The rebuild step needs a host C compiler (`CC`, default `gcc`). Without one that group prints
`SKIP` with the reason instead of passing silently.

## 6. Known limits

- Cross-function ownership (`char *f(void)` returning heap, `void g(char *p)` taking
  ownership) is **not** modelled.
- Structure members that are pointers, arrays of pointers, `void **` out-parameters: not
  tracked.
- `goto`/`asm`/table overflow abandon the **whole function**, so other certain defects in the
  same function are missed too.
- Independent of `-fopt-*`: the pass runs on the AST before code generation, so no optimizer
  switch changes its output.
- Not a sanitizer: it does not instrument anything and adds nothing at run time.

## 7. Where this sits in the project

arkcc's diagnostic rule is "rather an error than a wrong answer". `--warn-mem` extends that
rule to **static analysis**: report only what can be proven, stay silent otherwise, and write
the silent region down — which is exactly the table in section 2.
