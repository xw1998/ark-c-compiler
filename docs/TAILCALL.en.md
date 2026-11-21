# Tail call -> jump (`--tailcall`)

[中文](TAILCALL.md) | English

> The second optimisation of 0.9.1. One sentence: **when every argument of `return g(args);`
> fits in r0-r3 and the value is handed back to our caller unchanged, tear this frame down
> first and turn `BL g` into `B g`**. Two frames become one.
>
> Where: `src/backend/arm/backend_arm.c`, at **emission time** (not a new pass)
> Gate: `tests/run_tailcall_tests.py` (`make test-tailcall`)
> Switch: `--tailcall` / `--no-tailcall`, INI `tailcall=` / `tail-call=`

---

## 1. Why emission time instead of a new IR opcode

`IR_CALL` *immediately followed by* `IR_RETURN` already means "the call's value is this
function's result" -- every transformation that would need care (int -> long long widening,
truncation, `_Complex` reseating, struct copy) **inserts instructions between the two**. So the
adjacency test needs no separate correctness proof.

The alternative -- an `IR_TAILCALL` opcode -- means touching four backends plus `irser` and
`MIR`, and proving in irgen that no inserting site is missed. The risk/benefit is the wrong way
round. Emission-time recognition is also **inherently "fail rather than answer wrong"**: when the
conditions do not hold, not one byte changes.

## 2. The two convertible shapes

`f->code` is linear; `i` is the index of the current `IR_CALL`.

| Shape | C source | IR shape | `tail_call_skip` |
| --- | --- | --- | --- |
| A | `int f(int x) { return g(x + 1); }` | `IR_CALL` -> `IR_RETURN` | 1 |
| B | `void f(int x) { g(x); }` | `IR_CALL` -> `IR_PUSH_INT 0` -> `IR_RETURN` | 2 |

Shape B has to be listed separately because **irgen appends `PUSH_INT 0 / IR_RETURN` to every
function body** (`return;` and "falling off the end" share one path). A void callee pushes
nothing, so what is left in the IR is a dummy word that exists only to satisfy "RETURN needs a
stack top".

The test uses bit 33 of `IR_CALL.val`, which **irgen stamps from the call expression's type**
(taken from the prototype, so a declaration-only callee is covered too). Nothing here is guessed.

The instructions that follow are suppressed with a counter, `tail_return_pending`, checked at the
top of the main loop (`if (tail_return_pending) { --; continue; }`) rather than by a conditional
inside `case IR_RETURN:` -- there may be **two** instructions to skip and the middle one
(`PUSH_INT`) is a different case entirely. The counter is permanently 0 in a build without the
feature.

## 3. Refusal conditions (each one has a concrete consequence)

Common precondition: `g_config.enable_tailcall && !is_indirect && !is_sret_call && cplx_ret == 0
&& !f->is_naked && !f->is_irq && !f->is_variadic && g_va_epilogue_pad == 0`.

| Refused | Consequence |
| --- | --- |
| `stack_args > 0` (more than four argument words, so some go on the stack) | Those words would have to be moved into the **caller's** stack-argument block, which is exactly what `MOV sp, r6` is about to tear down; writing them would land on this frame's saved registers / the caller's argument area |
| Indirect call (`is_indirect`) | The callee address lives in the frame being freed -- tear the frame down first and it reads garbage |
| sret (struct result through a caller buffer) | The buffer is allocated in this frame by this function; after a jump nobody can fill it |
| `_Complex` result | Same, four words through a caller-owned buffer |
| `__naked` / `__irq` | Their frame shape is not the one restored in section 4 |
| Variadic (`is_variadic`) | The va area lives in this frame and `g_va_epilogue_pad` reserves extra room in the epilogue |
| Result used after the call | The two instructions are not adjacent, so the shape does not hold at all |

**Only the safe subset `stack_args == 0` is implemented**; everything else is emitted exactly as
before and documented here instead of being half-done.

## 4. The emitted sequence

```asm
    MOV sp, r6            ; drop the locals -- identical to step one of the epilogue
    ADD sp, sp, #N        ; when local_size > 0
    POP {r5, r6, r7, lr}  ; restore callee-saved; lr still holds the callee's return address
    B   g                 ; a plain B does not touch lr, so the callee's POP {.., pc}
                          ; returns straight to *our* caller
```

Two points that are easy to get wrong:

- **`lr` must stay live.** That is why this emits `POP {r5, r6, r7, lr}` and not the epilogue's
  `POP {r5, r6, r7, pc}` -- the `pc` variant returns on the spot and the branch never happens.
- **`ark_regalloc_function` rewrites PUSH/POP lines afterwards.** Its rule is "a variant that keeps
  lr keeps lr and widens", which is compatible with what this pass emits; the gate has a check
  (`tf keeps lr live in its tail-call epilogue`) that watches exactly this.

## 5. Trimming (three layers, zero change when off)

| Layer | Mechanism | Guarantee when off |
| --- | --- | --- |
| Compile time | `ARKCC_FEATURE_TAILCALL` (`include/arkcc_config.h`; 0 for `STM32_MIN`) | The whole decision block folds away (`tail_call_ok` / `tail_call_skip` become constants 0), so the emitted text is **byte-identical** |
| Run time | `g_config.enable_tailcall`, `--tailcall` / `--no-tailcall`, INI `tailcall=` | Default 0; the default object hashes the same with the switch on and off (measured by the gate) |
| Profile | (not needed) | The optimisation lives at emission time, not in the `--pipeline` stage table, so it has no `min_profile` |

A cropped build **refuses** the option instead of pretending to optimise: with
`-DARKCC_FEATURE_TAILCALL=0`, both `--tailcall` and INI `tailcall=1` fail with `C3900U` naming
the macro (one guard per path, one gate check per guard).

Measured cost of the cropped build (host gcc -O2, compiling `backend_arm.c` alone):
`.text` 117084 -> 118100 B, i.e. **this feature is 1016 B of code and 0 B of data**; the symbol
count is 186 -> 186 (no new external symbol). The board project `mdk/STM32H743_ArkCC` uses
`ARKCC_PROFILE_STM32_MIN` (hence `ARKCC_FEATURE_TAILCALL=0`) and rebuilds with UV4 at 0 Error,
Program Size `Code=182820 RO-data=23696`.

## 6. Gate (`tests/run_tailcall_tests.py`, 29 checks)

Six groups, each able to fail on its own:

1. **The switch really does something**: the assembly text differs with `--tailcall`.
2. **The three positive shapes** (`tf` / `tf64` / `vt`): the target's body contains an exact
   `B <callee>` line (compared line by line, not by substring -- `BL leaf` contains `B leaf`,
   which would be a false green) and `POP {r5, r6, r7, lr}` before it, and **no** `BL <callee>`.
3. **Recursion**: `tsum`'s recursive call becomes `B tsum`. Internal labels (`.L_tsum_0:`) belong
   to the body and must not be treated as a function boundary (the first version of the test
   truncated there).
4. **Six refused shapes must stay byte-identical**: result used afterwards / five argument words
   (one on the stack) / int -> long long widening / sret / `_Complex` / indirect call; and no `B`
   may appear for any of them.
5. **Selectivity inside one TU**: `tn_fn` is rewritten, `tn_use` is untouched -- this rules out
   "the file never actually went through the pass".
6. **Dynamic + byte account + cropping**: the emulator returns the same non-trivial value with the
   switch on and off; off by default (byte-identical object); `--no-tailcall` restores the default
   product; a cropped build refuses the option while its default object hashes the same as the
   full build's; with the switch on the object is strictly smaller and both sizes are printed.

## 7. Measurements (0.9.1, host gcc/MinGW, `Cortex-M7`)

| Case | Reading |
| --- | --- |
| `tc.c` (`tf` / `tf64` / `vt` / `tsum` convertible; `neg_use` / `neg_args` not) | assembly 424 -> 413 lines; object 1171 -> 1157 B |
| `tf` | `BL leaf` + `PUSH {r0}` + `POP {r5,r6,r7,pc}` -> `POP {r5,r6,r7,lr}` + `B leaf` (23 -> 21 instructions) |
| `tf64` | same, plus the two-word result no longer gets pushed/popped (23 -> 19) |
| `vt` | drops `MOV r0, #0` and the dummy word's `PUSH`/`POP` (18 -> 15) |
| `tsum` (self recursion) | `POP {r1}` + `BL tsum` -> `B tsum` (55 -> 53) |
| `neg_use` / `neg_args` | byte-identical with the switch on and off |
| Emulator | `off=81 on=81`, and the value is non-trivial |

## 8. Deviations from the roadmap (recorded honestly)

`docs/OPTIMIZER_PLAN.md` section P2 said "from `-O1`". The implementation has **no `-O` gate**,
matching `--reg-top`: an explicit switch is itself the statement of intent, and adding a level
check on top only produces "I asked for it and it did not happen" at `-O0 --tailcall`. This
document is normative; the roadmap line now carries the measurements.

The other deviation is shape: the roadmap said "mark it as `IR_TAILCALL`", but it landed at
emission time (section 1).

## 9. Deliberately not done

- **Moving stack arguments**: the correctness argument would have to cover "the new argument block
  overlaps the old frame", for one extra shape. Not now.
- **Other backends**: the x86-64 and RISC-V backends have no meaning for this switch --
  `--tailcall` there is a harmless no-op (they never read `g_config.enable_tailcall`). Implementing
  it means re-deriving the argument for each ABI.
- **`musttail`-style semantics**: this pass is opportunistic and promises nothing.
- **`sp` realignment**: with `stack_args == 0` this frame passes no stack arguments, so after
  `MOV sp, r6` sp equals its value on entry and AAPCS 8-byte alignment is the caller's business.