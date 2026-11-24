English | [中文](VOLMEM.md)

# Volatile accesses: the mark and the barrier (`-fopt-volbar`)

0.9.1-wip. Two things that must be read separately: the **volatile mark** (always on, zero
cost) and the **volatile barrier** (off by default, opted into with `-fopt-volbar`). Mixing
them up produces two wrong readings: "the code size did not move, so nothing was fixed" and
"it was fixed, so we pay 41% more instructions".

## 1 The gap

`arkcc` used to treat volatile asymmetrically:

| Access | Optimizer sees volatile? | Backend emits `DMB SY`? |
| --- | --- | --- |
| frame-local `volatile int v; ... v` | yes (`IR_AUX_VOLATILE`) | yes, a pair (`-fopt-voldmb` drops it when the address never escapes) |
| global `volatile int g;` | **no** | **no** |
| member of a volatile aggregate `s.v` (`s` is a volatile struct) | **no** | **no** |
| dereferenced pointer `*p` (`volatile int *p`) | **no** | **no** |
| bitfield of the same shapes | **no** | **no** |

"Optimizer sees nothing" is the red-line half. Without `IR_AUX_VOLATILE`, IR-only passes
(`copyprop`, `slotreg`, `cmat`, `live`) are entitled to merge two accesses into one, to hoist
a load out of a loop, or to drop a store whose value is never read back -- that changes the
number of bus transactions and **returns a wrong answer**.

"Backend emits nothing" is not a red line. A `DMB` only orders transactions as seen by
*another observer*. ARMv7-M (ARM ARM B2.3.7) guarantees a single core does not reorder
Device / Strongly-ordered accesses, so no barrier at all is safe here; armcc, armclang, IAR
and GCC (Cortex-M) all emit none.

## 2 Root cause

Every lvalue path in `src/irgen.c` tested `L->type->is_volatile` only. Per C11 6.5.2.3p3 the
qualifier comes from the **object**, not from the member's own type: in
`struct S { int v; }; volatile struct S s;` the access `s.v` is volatile, yet `L->type`
(`int`) carries no `is_volatile`. Consequences:

- mark: `aux` is 0 on those IR ops, so the optimizer does not know they are volatile;
- barrier: the ARM backend only ever emitted `DMB SY` on the frame-slot paths
  (`IR_PUSH_VAR` / `IR_STORE`); `IR_PUSH_GLOBAL`, `IR_STORE_GLOBAL`, `IR_LOAD_IDX`,
  `IR_STORE_IDX`, `IR_LOAD_FLD` and `IR_STORE_FLD` emitted nothing.

Measured before the change (`struct S{volatile int v;}` store + address-of + read, a
`volatile int g` read/write, `*p`, `p->v`): **zero `DMB` on all four shapes**, while the
number and order of loads and stores were preserved. In other words, there was no observable
wrong answer -- what was missing was the mark and the hardware barrier.

## 3 The mark (always on)

Two helpers were added:

```c
static int irgen_lvalue_volatile(AstNode *l);   /* volatile: own type, or base object is a volatile aggregate */
static int irgen_global_aux(Type *t);           /* global access: complex-float bit plus volatile bit */
```

All sites now go through them instead of testing `L->type->is_volatile` directly: global
read / plain store / compound assignment / `++` / `--`, `*p` read and store, `arr[i]` read
and store, `s.v` read and store, `s.f OP=`, address-form `++`/`--`, and the four bitfield
shapes (read, store, compound, `++`/`--`).

`IR_STORE_FLD` carries its bit width in `aux`, so the backend must take the width as
`int bw = I->aux & ~IR_AUX_VOLATILE;` -- otherwise 0x10000 would be read as a width. That is
fixed too.

**Cost: zero.** Against the `7d5c0d0` build, the same 95 HAL/Core TUs under the 21-switch
default set (`-fopt-frame -fopt-voldmb` included) are **95/95 byte-identical** (12,113
instructions either way). The mark is pure insurance: it closes the future risk of an
IR-only pass folding accesses to a non-frame volatile object without changing a single line
today.

## 4 The barrier (off by default)

Unconditionally emitting the `DMB SY` pair around non-frame volatile accesses costs, on the
same 95 TUs and the same switch set:

| Arm | Instructions | `DMB SY` in the corpus |
| --- | --- | --- |
| default (no `-fopt-volbar`) | **12,113** | **1** |
| `-fopt-volbar` | 17,081 (**+4,968, +41.0%**) | 2,848 |

Hottest translation units (added lines):

| TU | default | volbar | delta |
| --- | --- | --- | --- |
| `stm32f4xx_hal_dma_ex.c` | 2,766 | 3,797 | +1,031 |
| `stm32f4xx_hal_dma.c` | 1,640 | 2,644 | +1,004 |
| `stm32f4xx_hal_rcc.c` | 1,860 | 2,829 | +969 |
| `stm32f4xx_hal_flash.c` | 721 | 1,105 | +384 |
| `stm32f4xx_hal_rcc_ex.c` | 755 | 1,080 | +325 |

78 TUs do not change at all; the whole cost sits in the HAL modules dense with
`hdma->Instance->CR`-style "pointer to volatile member" accesses. Turning those barriers on
by default would destroy the beat-armcc size goal, and would contradict all three reference
compilers.

So:

- **Default behaviour = armcc / armclang / IAR / GCC (Cortex-M)**: honour the qualifier,
  emit no barrier.
- **`-fopt-volbar`**: emit a `DMB SY` pair around each non-frame volatile access (before:
  let prior memory operations complete; after: let the following ones issue later). For the
  multi-master case where a DMA engine, a second core or another ISR context relies on the
  compiler for ordering.
- This is the same design as `-fopt-voldmb`: a frame slot whose address provably never
  escapes makes the pair pure overhead, so it can go; a non-frame object cannot be proven,
  so the compiler follows the reference compilers instead of making the user pay +41% for a
  conservative choice they may not want.
- Cropping: `ARKCC_FEATURE_OPT_VOLBAR` is 0 under `ARKCC_PROFILE_STM32_MIN`, and such a
  build **refuses `-fopt-volbar` by name** (`C3900U`) while still compiling without it.

## 5 Not done / known limits

- **The riscv32 backend emits no `FENCE`**: the mark is applied (the optimizer-side guarantee
  holds), the hardware ordering is not. RV32 is a weaker model than ARMv7-M and needs its own
  gate (e.g. `fence iorw,iorw`) before it can be claimed.
- **x86 / x86-64**: strongly ordered and does not reorder volatile, so no instruction is
  needed; the mark is honoured the same way.
- **STM32H743 has not been run on the board**: this round rests on the host build, the 95-TU
  corpus, `tools/stm32_build_check.py --layout both` and `tests/arm_exec` (unicorn).
- Bitfield barriers are counted per read-modify-write of the whole storage unit; two fields in
  one unit are not distinguished.

## 6 Gate (`tests/run_volmem_tests.py`, 24 checks green)

| Check | Reading |
| --- | --- |
| `-O2` vs `-O2 -fopt-volbar -fno-opt-volbar` | byte-identical |
| default `DMB` count of `global` / `member` / `pointer` / `repeat` | 0 / 0 / 0 / 0 |
| `global` keeps one store and one load by default | 2 memory ops |
| `repeat` keeps two stores and two loads by default | 4 memory ops |
| `-fopt-volbar` yields balanced pairs per fixture | 4 / 4 / 4 / 8 |
| the flag adds barriers without moving accesses | equal counts in both arms |
| a function with no volatile access is byte-identical | yes |
| every fixture returns the Python answer in both arms | 7/9/11/8/7 |
| a cropped build refuses `-fopt-volbar` by name | `rc=1`, `C3900U` |
| the cropped build still compiles without the flag | `rc=0` |

Regression run alongside: `copyprop` / `atomic` / `vstack` / `vreg` / `slotreg` / `peep` /
`pipeline` / `regalloc` / `live` / `voldmb` all green; `tests/arm_exec` (0 failures);
`tools/stm32_build_check.py --layout both` (all PASS).
