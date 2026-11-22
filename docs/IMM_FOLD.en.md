# Folding a constant operand into an immediate (`-fopt-imm`)

English | [中文](IMM_FOLD.md)

> The seventh optimization of 0.9.1, and the largest one. In one sentence:
> **when a `PUSH k` is immediately followed by an arithmetic or comparison
> operation, do not push the constant onto the value stack and pop it back --
> write it into the instruction's immediate field instead.**
>
> Implementation: `src/backend/arm/backend_arm.c`, at emission time
> (`emit_binary_imm()`, the "swallow the constant" block in the IR main loop)
> Gate: `tests/run_imm_tests.py` (`make test-imm`), plus the whole `tests/arm_exec`
> corpus
> Switch: `-fopt-imm` / `-fno-opt-imm`, INI `opt-imm=` / `imm=`

---

## 1. Why, and at which layer

The arkc ARM backend is a **value-stack machine**: the result of every
expression is really pushed onto the stack with `PUSH {r0}` and a binary
operator pops its two operands back with `POP r1` / `POP r0`. For constants
that is pure waste:

```c
int f(int a) { return a + 16; }
```

With `-O2` (no `-fopt-*`) we emit

```asm
    PUSH {r0}          ; a (already in r0, still pushed first)
    MOV  r0, #16       ; the constant
    PUSH {r0}          ; push the constant
    POP  r1            ; right operand = 16
    POP  r0            ; left operand  = a
    ADD  r0, r0, r1
    PUSH {r0}
```

while `ADD r0, r0, #16` is already one instruction. **Five of the six
value-stack actions are pure overhead.** The HAL corpus is full of this shape
(`HAL_Delay(10)`, `GPIO_PIN_5`, `RCC_CR_HSEON`, `if (state == 3)`), which is why
this one pass is worth −21.3% of the instruction count on its own (§6).

The layer differs from the first three passes: `-fopt-vstack` / `-fopt-addr` /
`-fopt-cbz` are all **text rebuilds after emission**, whereas this one is a
**decision taken at emission time**. There is exactly one reason:

> The text layer cannot reliably answer "is this `MOV r0, #16` the operand of
> some `PUSH`?" Once the code is `.s` text, the constant has already been
> materialised into a register, and the link between that register and "which
> value on the stack it is" is gone.

The IR has no such problem: the adjacency of `IR_PUSH_INT` and `IR_BINARY` is
exact, and `-fopt-divconst` already used the same technique (`divconst_live` /
`skip`), so the convention can be copied.

## 2. The two shapes

In the main emission loop, on `IR_PUSH_INT`, look at what follows:

| Shape | IR sequence | Folded into |
| --- | --- | --- |
| **right constant** | `PUSH k` / `BINARY` | `POP r0` / `<OP> r0, r0, #k` |
| **left constant** | `PUSH k` / `<one-word push>` / `BINARY` | same (the `k` is really on the left, so only **commutative** operators qualify) |

The left-constant form additionally requires that the middle instruction
**really pushes one word** (`ir_pushes_one_word()`: `IR_PUSH_INT` /
`IR_PUSH_ADDR` / `IR_PUSH_GLOBAL_ADDR`, plus a local or global narrower than a
word, i.e. `< 8` bits). If the width is unknown, nothing is folded -- "rather
miss than be wrong".

On a hit the main loop `continue`s past the push and sets `imm_live`; when the
real `IR_BINARY` arrives it takes the same immediate path:

```c
case IR_BINARY:
    if (imm_live) {
        imm_live = 0;
        emit_pop_r0(&buf);                    /* one real operand left on the stack */
        emit_binary_imm(&buf, imm_op, imm_val, imm_left, 1);
        emit_push_r0(&buf);
        break;
    }
```

**The decision and the emission are the same function**: `emit_binary_imm(...,
emit = 0)` only answers "can this be folded", `emit = 1` emits. That makes
"swallowed the push but cannot emit the immediate" structurally impossible, and
the `; imm fold inconsistent` fallback is unreachable in practice (gate group 5
asserts it never appears).

## 3. Encoding guard per operator

Every instruction has a different immediate field, and one wrong case turns a
valid C program into an assembly error. So each operator passes an encoding
gate before anything is folded:

| Operator | Folds when | Emits |
| --- | --- | --- |
| `+` | `k` in `0..4095` | `ADD r0, r0, #k` (ADDW) |
| `+` | `k` in `−4095..−1` | `SUB r0, r0, #−k` (`a + (−k)` is `a − k`) |
| `−` | `k` in `0..4095` | `SUB r0, r0, #k` |
| `−` | `k` in `−4095..−1` | `ADD r0, r0, #−k` |
| `&` `\|` `^` | `k ≥ 0` **and** `thumb_imm12_a(k)` passes | `AND/ORR/EOR r0, r0, #k` (modified immediate) |
| `<<` | `0..31` | `LSL r0, r0, #k` |
| `>>` | `0..31` | `LSR` (unsigned) / `ASR` (signed) |
| `==` `!=` `<` `>` `<=` `>=` | right constant only; `k ≥ 0` and (`k ≤ 255` or `thumb_imm12_a(k)`) | `CMP r0, #k` + the usual `emit_cmp_result()` |

The 4095 limit for `ADD/SUB` is not conservatism but a hard boundary: a 12-bit
unsigned immediate, and the assembler will not accept `SUB #4096`.
`AND/ORR/EOR` go through a "modified immediate" (8-bit value rotated right by an
even amount), so `0xFF000000` folds while `0x12345678` does not -- the easiest
place to get this wrong outside `--reloc-data`.

Comparisons need the **extra** gate `k ≤ 255 || thumb_imm12_a(k)`: the 16-bit
form of `CMP` only takes `0..255`, and a larger value either lands in the 32-bit
modified immediate or has no encoding at all (`CMP #256` does not exist).
Comparisons also **exclude a left constant** -- comparison is not commutative and
`16 < a` must not become `CMP a, #16`.

## 4. What is refused

All of the following stay exactly as they were (neither the push nor the
register form changes):

- `*` `/` `%`: there is no immediate form (the `MUL` immediate has to be in a
  register already; division goes through `-fopt-divconst`, a different
  magic-number scheme, see `docs/DIVCONST.md`);
- floating point: `VADD` and friends do not take an integer immediate;
- `k` does not fit the field (`ADD #4096`, `AND #0x12345678`, `SHL #32`);
- comparisons with a left constant, and non-commutative operators;
- the middle push is not exactly one word, or its width is unknown;
- `--reg-top` is enabled, which skips the whole block (§5).

## 5. Mutual exclusion with `--reg-top`

`--reg-top` is a different model, in which the top of the value stack lives in a
register; it also pairs `PUSH`/`BINARY`. With both paths active the **same value
would be skipped twice**, the stack depth would drift, and that kind of error
does not report anything -- it just computes the wrong answer. Hence the entry
condition `!ark_top_enabled()`:

```c
if (g_config.enable_opt_imm && !ark_top_enabled() && !imm_live && I->op == IR_PUSH_INT)
```

Gate group 6 turns both switches on and asserts that the build still compiles
and the answer is still right (`--reg-top` alone already covers most of the
gain, so nothing is lost by the exclusion).

## 6. Measurements

Corpus: `examples/ark_test/Core/Src/*.c` + `Drivers/STM32F4xx_HAL_Driver/Src/*.c`,
96 translation units (three `*_template.c` produce empty code in all three
compilers and are skipped symmetrically -> 93 effective).
Flags: `-O2 -mcpu Cortex-M4`, the baseline additionally adds
`-fopt-vstack -fopt-addr -fopt-strength -fopt-cbz -fopt-branch`; the counts are
the lines in the `.s` that are neither directives nor labels.

| Build | Instructions | Relative to baseline |
| --- | --- | --- |
| baseline (five passes) | 35,211 | 1.000× |
| baseline + `-fopt-peep` | 33,730 | 0.958× (−1,481, −4.21%) |
| baseline + `-fopt-imm` | **27,716** | 0.787× (**−7,495**) |
| baseline + `-fopt-imm -fopt-peep` | **26,316** | 0.747× (**−8,895, −25.26%**) |

`-fopt-imm` alone is **−21.3%** -- the largest single item of the six 0.9.1
passes, slightly ahead of `-fopt-vstack` at −20.0%. Both together are −25.26%,
which is 81 instructions less than the sum of the two parts (some of the
adjacent `PUSH/POP` pairs that `-fopt-peep` would otherwise eat have already
been removed together with their constant by `-fopt-imm`).

## 7. What the gate says

`make test-imm` (`tests/run_imm_tests.py`) runs two fixtures × six arms, 33
checks, all ok:

- `FOLD`: `f_add/f_sub/f_and/f_or/f_xor/f_shl/f_shr/f_lt/f_eq`, `main` returns 125;
- `REJECT`: `r_and 0x12345678`, `r_add 70000`, `r_mul 5`, `r_div 3` (all must
  **not** fold), `main` returns 245.

Six groups of assertions:

1. **OFF IS OFF**: the images of `-O2` and `-O2 -fno-opt-imm` are byte-identical.
2. **The nine immediates really appear**: `ADD r0, r0, #16`, `SUB r0, r0, #7`,
   `AND/ORR/EOR`, `LSL/LSR`, `CMP r0, #5` are each found by grep.
3. **The matching `MOV r0, #k` really disappears**: asserting only "the immediate
   appeared" would miss a half fold in which the immediate is emitted *and* the
   constant is still pushed -- that error does not show up at assembly time, only
   as a wrong answer at run time.
4. **Semantics**: the `off / on / vstack / imm` arms agree with the Python
   reference (two fixtures, four arms each).
5. **The refusal path is byte-identical**: `REJECT` has the same image under
   `off` and `on`, and the whole file contains no `; imm fold inconsistent`.
6. **The `--reg-top` combination**: with both on it compiles, answers correctly
   and leaves no fallback marker; a **cropped build** refuses `-fopt-imm` by name
   (`C3900U`, exit code 1) while still compiling the same program without it.

There is also a whole-corpus execution equivalence run:
`run_arm_exec.py --extra=-fopt-imm` (with the other six switches), 0 failures.

## 8. Trimming

`ARKCC_FEATURE_OPT_IMM` in `include/arkcc_config.h`: 0 under
`ARKCC_PROFILE_STM32_MIN`, 1 for host / cross builds. When it is 0 both
`emit_binary_imm()` and the "swallow the constant" block are preprocessed away,
and `src/main.c` rejects the flag with
`C3900U: -fopt-imm is not compiled into this build` (rejected, not silently
ignored).

The run-time default is **off** (`g_config.enable_opt_imm = 0`), so a build
without the flag is byte-identical to 0.9.0 (192 outputs compared OFF-IS-OFF,
`bad 0`).

## 9. Position: emission time, not a pass

```
IR main loop (emission)
  ├─ -fopt-imm: swallow the constant push, emit the immediate form
  └─ after each function is emitted
       ├─ -fopt-vstack
       ├─ -fopt-addr
       ├─ -fopt-cbz
       ├─ -fopt-peep
       └─ -fopt-regalloc
```

Being at emission time has a second benefit: **the later passes see shorter
text**. Once the constant pushes are gone, the pool pressure seen by
`-fopt-vstack`, the adjacent-pair statistics of `-fopt-peep` and the slot heat of
`-fopt-regalloc` are all computed on a stream closer to the real code.

## 10. Deliberately not done

| Not done | Why |
| --- | --- |
| Folding constant-with-constant (`k1 op k2` -> `k`) | That is a different job (constant folding), already partly done by `src/opt.c` before the IR; this pass only handles "one constant + one run-time value" |
| Merging `MOV r0, #k` with the following `CMP`/`ADD` in the text | The text layer cannot tell whose constant register it is, see §1 |
| The reversed `SUB` form (`k − a` -> `RSB r0, r0, #k`) | An immediate `RSB` exists and saves the same push, but it would need one more encoding path and one more gate; noted here first |
| Literal-pooling large constants (`LDR r0, =k`) | `MOVW/MOVT` is already handled by the assembler; the literal pool is another route (`--literal-pool`) |

## 11. Known costs

- The size and instruction gains are **measured**, with no per-site attribution
  of "how many instructions each site saved";
- It cannot be combined with `--reg-top` (§5). That is a real loss of
  expressiveness, but each path already covers most of the gain on its own;
- The immediate guards are written against the **actual encoding capability of
  the built-in assembler**, not against the general ARM rules: `ADD #4095`
  relies on `ADDW`, `AND` on the modified immediate. If the assembler ever gains
  a new immediate form (say something beyond `SUB.W #4095`), these guards have to
  be relaxed in step -- otherwise they only cause missed folds.
