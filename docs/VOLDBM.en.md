# `-fopt-voldmb`: dropping volatile barriers no one can observe

English | [中文](VOLDBM.md)

> In one line: an access to a **frame-local** volatile object is emitted with a
> `DMB SY` pair (before + after). If **the function never takes that object's
> address**, nothing outside the frame can name it, the barrier has no observable
> effect and is pure overhead. This pass runs an address-escape analysis keyed on
> the object name and deletes those pairs. On the whole HAL corpus it saves
> **170 instructions (-1.38%) and 616 bytes (-1.88%)**, with `bigger TU 0`.
>
> **Verdict: landed, off by default.** This is the one certain item this round
> that trades a certain, larger cost for a certain win. The flag is off by
> default and cropped in the STM32_MIN build (refused by name with `C3900U`).

---

## 1 Where the cost comes from

HAL is full of this idiom:

```c
__IO uint32_t tmpreg;          /* __IO = volatile */
tmpreg = RCC->CR;              /* read the peripheral */
RCC->CR = tmpreg;              /* write it back */
```

`tmpreg` is a frame-local `volatile`. In the C abstract machine every access to
it is an observable side effect, so `arkcc` conservatively emits a `DMB SY` pair
per access (before + after the read, before + after the write). Census over
12,304 instructions:

| quantity | reading |
|---|---|
| total `DMB` | **139** |
| immediately adjacent to a `[r6` frame access | **138 (99.3%)** |
| emitted for a global volatile (peripheral register, via pointer) | **0** (never emitted) |

That is, over 95% of all `DMB`s are spent on the single `__IO` local idiom, eight
bytes per pair.

## 2 Why it can go

`DMB` only constrains **the order in which memory transactions become visible to
other observers**. A frame local's address is known only inside this function, and
the function never takes it => no other observer (another core, DMA, a peripheral)
can name it => the ordering constraint is vacuous.

Cross-checked: `armcc -O2`, `armclang -O2` and `IAR iccarm -Ohs` emit **no
barrier at all** for this idiom.

## 3 Implementation: escape analysis by object name

A frame offset cannot express "how wide this object is" (the extent of `&s` is
unknown), so the pass does **not** use offset ranges; it uses names -- `irgen.c`
already attaches the name of the object whose address is taken to `IR_PUSH_ADDR`
(`node->u.name`).

- an `&name` exists in the same function => **all** of `name`'s barriers stay;
- an `IR_PUSH_ADDR` with an empty name cannot be attributed => set `vdm_blind`
  and **keep every barrier in the whole function**;
- otherwise the volatile accesses to that object may drop their `DMB` pair.

All four emission points (inside `codegen_arm()`) share the guard
`if (is_volatile && !vdm_elide(I->name))`. **Delete-only, never insert**, and the
rule is "delete only what is proven"; an unprovable function falls back whole.

## 4 Measured

Four arms over 95 TUs:

| arm | insns | bytes |
|---|---|---|
| base | 12,304 | 32,690 |
| `-fopt-frame` | 12,275 (-29) | 32,606 (-84) |
| `-fopt-voldmb` | **12,134 (-170, -1.38%)** | **32,074 (-616, -1.88%)** |
| both | **12,105 (-199)** | **31,990 (-700)** |

All arms `bigger TU 0`; the both arm `smaller TU 16 / identical 79`. The 170
instructions agree with the census (139 `DMB`s, both directions, minus the
functions that keep theirs because of an escaping `&`).

## 5 Interaction with `-fopt-copyprop` (safe)

`copyprop` uses `DMB` as its "barrier for volatile accesses" evidence, so dropping
the `DMB` may let it forward the value of a volatile local. **That is still
correct**: this pass's criterion is exactly "the address does not escape" => no
one can observe => forwarding has no side effect. The two safety conditions
coincide here.

## 6 Gate (`tests/run_voldmb_tests.py`, 16 checks green)

| check | reading |
|---|---|
| `plain`: the default build emits a pair per volatile access | 6 barriers |
| `plain`: every barrier goes when nothing can name the object | 6 -> 0 |
| `plain`: one instruction shorter per deleted barrier | yes |
| `plain`: the image never grows | 1,192 -> 1,168 B |
| `leaked`: with `&v` present the barriers stay **byte for byte** | 4 barriers |
| `blind`: an **unrelated** `&s.a` does not disable the pass (`&s.a` belongs to `s` only) | 6 -> 0 |
| `quiet`: a function with no volatile access is byte-identical | yes |
| all four fixtures off=on=Python answer | 5/6/2/7 all equal |
| the cropped build refuses `-fopt-voldmb` by name | `rc=1` |
| the cropped build compiles without the flag | `rc=0` |

Also: 95 TUs with 0 err; `tests/arm_exec` 0 failure in both arms; **OFF IS
OFF** (the default build is byte-identical to the pre-change binary on `.s`/`.o`).

## 7 Known gap (closed by `-fopt-volbar`, see `docs/VOLMEM.md`)

What was logged here: `volatile` **struct member** accesses (`s.v`), `volatile` globals and
dereferenced pointers (`*p`) emit no `DMB` at all (0 barriers in the probe fixtures).

That has to be read in two layers, otherwise "not fixed" and "must not be emitted" get
confused:

- **The mark was the real gap, and it is fixed.** The lvalue paths in `src/irgen.c` tested
  `L->type->is_volatile` only, dropping the "base object is a volatile aggregate" layer of
  C11 6.5.2.3p3, so those accesses carried no `IR_AUX_VOLATILE` and an IR-only pass was
  entitled to fold or hoist them -- that is what returns a wrong answer. Every site is
  marked now, at zero cost (95 TUs byte-identical).
- **The barrier is still not emitted by default, deliberately.** A single ARMv7-M core does
  not reorder Device/Strongly-ordered accesses (ARM ARM B2.3.7), and armcc, armclang, IAR
  and GCC (Cortex-M) emit no barrier for volatile; forcing the pair costs **+41.0%**
  instructions (12,113 -> 17,081) and 1 -> 2,848 `DMB`. Use `-fopt-volbar` when a second bus
  master relies on the compiler for ordering.

Details, measurement tables and the 24-check gate are in `docs/VOLMEM.md`.

## 8 Not done / known limits

- No cross-function escape analysis (a `static` frame quantity whose address is
  passed out still keeps its barriers);
- functions with an unattributable `IR_PUSH_ADDR` name fall back whole (conservative,
  prefer doing less);
- Linux host not really run; STM32H743 only `--layout both` build; not on the board.
