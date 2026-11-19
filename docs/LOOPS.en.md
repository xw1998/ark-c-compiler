# Loop optimisations (`--licm` / `--unroll`)

[中文](LOOPS.md) | English

0.8.6 adds two **loop-level** transforms to the middle end: loop-invariant code
motion (LICM) and complete unrolling of counted loops. They share the graph
substrate introduced for the three whole-program checks (`MirFunc` / `MirLoop`,
see [MIR_CFG.en.md](MIR_CFG.en.md)), but unlike those checks **these two really
modify the IR**.

| Switch | Default | Profile | Minimum `-O` |
| --- | :---: | --- | :---: |
| `--licm` / `--no-licm` | off | `full` (not in the MCU minimal profile) | 1 |
| `--unroll` / `--no-unroll` | off | `full` (not in the MCU minimal profile) | 1 |
| `licm` / `unroll` in `[features]` | `0` | the config-file spelling | — |
| `ARKCC_FEATURE_LICM` / `ARKCC_FEATURE_UNROLL` | `1` on the host, `0` under `ARKCC_PROFILE_STM32_MIN` or `ARKCC_FEATURE_MIR=0` | compile-time crop | — |

Both follow the rule this project keeps repeating: a shape that is not *proved*
safe is left exactly as it was. There is no "probably fine, change it anyway"
path, so neither pass can silently change a program's answer.

## 1. LICM: hoist the computation, leave the store

### 1.1 Why not the textbook form

The IR is a stack machine: a value exists only between the push and the next
instruction that consumes it, and the back edge of a loop carries no stack slot.
So "compute it once and keep it in a register" has nowhere to land.

What this pass does instead is **move the computation into a compiler temporary
and leave the store where it is**:

```
preheader:   t  = x * y            (new)
loop body:   s  = t                (was: s = x * y)
```

The temporary occupies an 8-byte frame slot appended after `local_size` is
rounded up to 8; each iteration is then just `PUSH_VAR t; STORE s`.

### 1.2 Zero iterations is a hard constraint

Leaving the store in place is what keeps a loop that never runs semantic: if the
whole assignment were hoisted, `while (0) { s = 1 / 1; }` would write `s = 1`
although the statement never executed. In the current shape a zero-iteration
loop writes only the temporary, and `s` is not touched at all. The gate pins this
down with `licm_case(0, 3, 5) * 1000 + licm_case(4, 3, 5) == 75`: if the value
leaked into `s`, the result would be in the thousands.

### 1.3 What may be moved (the whitelist)

| Instruction | Stack effect | Note |
| --- | :---: | --- |
| `IR_PUSH_INT` / `IR_PUSH_VAR` / `IR_PUSH_GLOBAL` | +1 | only named locals/globals |
| `IR_BINARY` | −1 | **`/` and `%` excluded** |
| `IR_UNARY` | 0 | negation, bitwise complement, ... |
| `IR_DUP` / `IR_SWAP` / `IR_NOP` | +1 / 0 / 0 | |

Everything else is immovable, and three exclusions are deliberate:

- **Division and modulo are out** because they can trap. Hoisting a trapping
  operation out of a loop that never runs would introduce a fault the
  unoptimised program never had.
- **volatile, `IR_AUX_COMPLEX`, `IR_AUX_SLOT64` and 8-byte pushes are out**: the
  word count is ABI-dependent, and miscounting it unbalances the evaluation
  stack — which is a silent wrong answer, not a crash.
- **Every access through a pointer (`IR_LOAD_IDX`, `IR_LOAD_FLD`,
  `IR_PUSH_ADDR`, ...) rejects the whole candidate**: that needs alias analysis,
  which this layer does not have.

### 1.4 What counts as invariant

A local at offset `off` is invariant iff

1. **no `IR_PUSH_ADDR` anywhere in the function takes that offset** — once the
   address escapes, a callee may write it, so "no direct store in the loop"
   proves nothing; and
2. the loop contains no `IR_STORE` to that offset.

A global named `name` is invariant iff

1. the loop contains no `IR_CALL` / `IR_ASM` / `IR_MEMCPY` / `IR_STORE_IDX` /
   `IR_STORE_FLD` / `IR_STORE_GLOBAL` / `IR_ALLOCA` / `IR_SMC` (anything that
   could write it indirectly), and
2. the loop contains no `IR_STORE_GLOBAL` of the same name.

### 1.5 Candidate length and termination

A candidate run must be **at least 3 instructions**. A two-instruction candidate
is exactly `push x; store y` — a plain copy, worth nothing to hoist — and
refusing it is also what makes the pass terminate: the pair left behind
(`PUSH_VAR t; STORE s`) is 2 instructions and is never a candidate again.

### 1.6 Inner loops first, rebuild every round

`opt_licm_func` rebuilds the CFG (`mir_build` + `mir_loops`) every round, takes
the innermost loop by ascending block count, and hoists one run before
rebuilding. Nested loops are therefore handled as "hoist the inner run into the
inner preheader, then let the next round do the outer one", which avoids the
index conflicts of a single multi-run rewrite.

## 2. UNROLL: complete unrolling, one accepted shape

The pass accepts exactly the shape irgen emits for

```c
for (i = c; i < N; i++) body;        /* c and N are integer constants */
```

which is these four basic blocks:

```
B0  LABEL start ; PUSH_VAR i ; PUSH_INT N ; BINARY(<) ; JZ end
B1  <body: straight line, no label, no jump, no return>
B2  LABEL cont  ; [PUSH_VAR i] ; PUSH_VAR i ; PUSH_INT 1 ; BINARY(+)
                ; STORE i ; [POP] ; JMP start
B3  LABEL end   ; ...
```

(The bracketed instructions in B2 are the "old value + POP" irgen leaves when
`i++` is used as a discarded expression; accepted but not required.)

Every one of the following must hold, or the loop is untouched:

- those three blocks are the whole loop (B1's only successor is B2, B2's only
  successor is B0) and the header test is `i < N`;
- `start` and `end` are referenced only by those two jumps — any `break`,
  `continue` or `goto` rejects the loop (a `break` would land in the middle of a
  copy, which the rewrite does not model);
- `i` has exactly two stores in the whole function — `i = c` outside the loop, in
  a block that dominates the header, and the latch — and its address is never
  taken (the copies substitute the induction value with a constant);
- `1 <= N - c <= ARK_UNROLL_MAX` (default 8) and the body is at most
  `ARK_UNROLL_MAX_BODY` IR instructions (default 64);
- the body has no inline asm, no `alloca` and no self-modifying-code marker.

The rewrite replaces B0..B2 with `N-c` copies of the body, each preceded by
`i = c+k` (and every `PUSH_VAR i` inside the body replaced by `PUSH_INT c+k`),
then appends `i = c+N` so the value the loop leaves behind is the same. B3 and
everything after it are kept verbatim, so the header and back-edge labels
disappear with the loop.

Both limits can be overridden at compile time:

```
-DARK_UNROLL_MAX=16 -DARK_UNROLL_MAX_BODY=128
```

Under `ARKCC_PROFILE_STM32_MIN` neither pass is even compiled in: `--licm` /
`--unroll` are refused with `C3900U` naming the missing macro, while the `--no-`
forms are always accepted.

## 3. Gate

`tests/run_loop_tests.py` (`make test-loop`), 29 checks:

| Group | What is checked |
| --- | --- |
| 1 | `--licm` changes the code; the multiply is neither deleted nor duplicated (same count before and after) |
| 2 | three unsafe shapes (address taken / operand stored in the loop / division) leave the assembly **byte-identical** |
| 3 | `--unroll` copies the body 4 times (`MUL` 1 → 4); the header and back-edge labels are gone |
| 4 | `break` and an above-limit trip count leave the assembly byte-identical |
| 5 | the emulator runs eight cases; the answers match with the switches on and off (75 / 18 / 0 / 0 / 3 / 198) |
| 6 | default-off and `--no-` produce a **byte-identical** `.o` |
| 7 | without `-O` the dump says `needs a higher -O level`; `--print-pipeline` lists both stages; a skipped stage names the switch that turns it on |
| 8 | a cropped build (`-DARKCC_FEATURE_LICM=0 -DARKCC_FEATURE_UNROLL=0`) refuses and names the macro, and still compiles the same file normally |
| 9 | `licm=1` / `unroll=1` in `arkcc.cfg` have the same effect |

Group 3's "header label gone" is not decoration: it separates "really unrolled"
from "copied once and kept the loop". The four cases `licm_taken`, `licm_div`,
`unroll_break` and `unroll_big` in group 5 are the anti-false-green side: they
require that the optimisation did **not** fire, so a future loosening of the
shape checks changes a return value.

## 4. Known limits

- No alias analysis: any access through a pointer ends a LICM candidate, so
  `p[i]` is never hoisted.
- LICM moves arithmetic only, not loads (except `IR_PUSH_GLOBAL`): a loop-invariant
  memory read is still re-read every iteration.
- UNROLL handles one level, canonical, constant-bound `for` loops only; `while`,
  `do-while`, a step other than 1 and a non-constant bound are all refused —
  deliberately, not for lack of code.
- Neither pass models code size: `--unroll` grows the text linearly with the trip
  count, which the user should weigh on a small-flash target.
