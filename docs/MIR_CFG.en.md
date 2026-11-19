# MIR/CFG and the three whole-program checks

[中文](MIR_CFG.md) | English

Before 0.8.5 the middle end of arkc was a set of scans over the flat `IrInst`
array. The three checks that genuinely need a graph — unreachable code,
unused static functions, and call cycles — would otherwise each carry their own
edge walker, unaware of the others.

From 0.8.6 on they share one substrate: `src/mir.c` turns an `IrFunc` into
basic blocks and an `IrProgram` into a call graph; `src/mirpass.c` only reads
those graphs and prints. **No IR instruction is modified** — which is why
"enabling every check produces the same object file" is a fact the gate proves
byte for byte.

Three independent switches, all default **off**:

```
--warn-unreachable      unreachable code
--warn-unused-static    static function nobody calls
--warn-recursion        call cycles (including self recursion)
```

## 1. The two graphs

### 1.1 Basic block graph (`MirFunc`)

- Leaders: instruction 0, every `IR_LABEL`/`IR_LABEL_NAMED` target, and the
  instruction after every terminator (`JMP/JMP_NAMED/JZ/JNZ/CMP_JMP_EQ/RETURN/FUNC_END`).
- Blocks are numbered in instruction order, so `[start,end)` intervals are
  contiguous and cover the whole function.
- `succ[2]`: two for `JZ/JNZ`, one otherwise.
- Predecessors are flattened into `pred_start[]/pred_count[]` — no per-block lists.
- `mir_inst_block()` maps an instruction back to its block.

Invariants (`mir_verify()`):

1. block intervals cover `0..code_count` with `start<end`;
2. every block except the last ends with a terminator;
3. both ends of every edge exist and the target block starts at the jump target;
4. `pred` and `succ` agree — `b` is in `succ[a]` iff `a` is in `pred[b]`.

`mir_verify` is a development-time assertion after `mir_build` (enabled by
`MIR_DEBUG_VERIFY`), not a separate gate case: it exists so "the graph is
wrong" and "the verdict is wrong" can be told apart.

### 1.2 Call graph (`MirCallGraph`)

- Nodes are the functions of the program. An `IR_CALL` that resolves by name to
  a function of this translation unit adds an edge; anything else (function
  pointer calls, external symbols) counts in `unresolved_calls`.
- `addr_taken[i]`: `IR_PUSH_FUNC`, global initialisers (`init_sym`,
  `init_refs[]`) and `alias_target`.
- `saw_inline_asm`: the unit contains `IR_ASM` or an `is_asm_func` body.

## 2. The three verdicts

### 2.1 `--warn-unreachable`

BFS from block 0; each **maximal contiguous run** of unreachable blocks is
reported once, counting only real instructions (`mp_is_real_inst`: labels,
`FUNC_BEGIN/END`, `NOP` don't count).

**Phantom-block rule** (the central trade-off): a block made only of pushes,
`JMP`, `RETURN`, labels, `FUNC_*` and `NOP` is never reported. Not because it
is reachable, but because irgen writes exactly such blocks itself:

- the `JMP end_l` emitted after an `if` arm that already returned;
- the implicit trailing `PUSH_INT 0; RETURN` of every function.

These are indistinguishable from hand-written dead code, and reporting them
would fire in every function of every program. The price is a **registered
miss**: a lone `return 2;` after `return 1;` is silent. The gate asserts that
miss on purpose.

### 2.2 `--warn-unused-static`

Reported when all hold: `is_static`, no incoming edge, address never taken,
not `used`/`unused`/`weak`/`constructor`/`destructor`/`asm`, and neither
`inline` nor `__forceinline`.

- `inline`/`__forceinline` stay silent, matching GCC's `-Wunused-function`
  (the `_Generic` helpers in `<stdarg.h>` are exactly that shape: only the
  selected association produces a call). 0.8.6 therefore added `is_inline` to
  `IrFunc` — the parser used to throw `inline` away.
- A unit containing inline asm is silent as a whole: symbols named inside asm
  text are invisible to this graph, and guessing an edge is giving a wrong answer.

### 2.3 `--warn-recursion`

Tarjan on the call graph (iterative, explicit frame stack — the recursive
version overflows a 4 KB MCU stack), one report per cyclic SCC:

- `size > 1` → `'a' is in a call cycle with 1 other function(s) ...`;
- `size == 1` with a self loop → `'self' calls itself ...`.

The report goes to the lowest-indexed member of the SCC. Function-pointer calls
only ever hide an edge, so they can cause a miss but never a false positive;
no silencing is needed.

## 3. Deliberate non-reports

| Shape | Behaviour | Why |
| --- | --- | --- |
| lone `return 2;` / pure-`JMP` dead block | silent | phantom rule, §2.1 |
| unused `static` variable | not reported | AST/link level, not the call graph |
| discarded value other than `(void)` | not reported | that is `--warn-unused-result`'s job |
| function-pointer / external calls | miss only | no edge exists; never guess |
| unused-static in a unit with inline asm | whole unit silent | asm symbols are invisible |
| recursive but inlined / tail-called | still reported | a source-level fact, independent of optimisation |

## 4. Position and trimming

All three sit **before** `constfold` in the IR stage table, because a lint must
describe the **source**. `constfold` turns `if (0)` into an unconditional jump;
what is unreachable afterwards is the optimiser's product, not the program's.

They share `ARKCC_FEATURE_MIR` (all live on `src/mir.c`; separate switches would
only ship an unused graph builder):

```c
/* include/arkcc_config.h */
#ifndef ARKCC_FEATURE_MIR
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_MIR 0      /* trimmed on MCU */
# else
#   define ARKCC_FEATURE_MIR 1
# endif
#endif
```

Without the feature: the three positive options and INI keys are rejected with
`C3900U` plus the rebuild hint; the three `--no-` forms are always accepted.

## 5. Gate

`tests/run_mir_tests.py` (`make test-mir`):

1. unreachable: one report for the real dead store, correct line; `if/else`,
   `while`, `switch`, `goto` twins silent; the registered miss silent;
2. unused-static: only the uncalled static reported; called / address-taken /
   `unused` / `inline` / `__forceinline` silent; inline-asm unit silent;
3. recursion: mutual pair and self loop each reported once with distinct text;
   non-recursive leaf silent;
4. anti-false-green: silent without the switches, `--no-` turns off, positive
   form turns back on;
5. `--print-pipeline` lists the three stage names and switches;
6. **zero change**: the same source compiles to byte-identical `.o` with all
   three on and all three off (sha256);
7. trimming: a `-DARKCC_FEATURE_MIR=0` build rejects all three options and
   still compiles the same file;
8. all three keys in `arkcc.cfg` switch the checks on.

## 6. Known limitations

- Blocks are numbered in instruction order; a dead run spanning several lines is
  reported once, at the first block's start line.
- The call graph ignores reachability of call sites: a never-called caller
  still counts as a caller, which can only hide an unused-static report.
- `alias_target` marks the address as taken but adds no reverse "alias call"
  edge, so the aliased function can be missed.
- No data-flow analysis: unreachability is control flow only. `while (0)` bodies
  are reported; `if (0)` is already folded during IR generation, exactly as in
  earlier releases.
