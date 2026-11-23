# An unreferenced `static` function is no longer emitted (on by default, no switch)

English | [中文](DEADSTATIC.md)

> In one line: a `static` function can only be called from its own translation unit. If this
> unit never mentions it, it cannot run -- its body is just bytes sitting in the object file.
> ARK used to emit code for every function body, so the most common shape, "the header is
> included but the helper is never called", dragged dead code along: **1,737 instructions
> (-9.57%)** on the 95-TU HAL corpus, **2,538 (-13.98%)** with `-fopt-vreg` stacked on top.
> The pass now runs once in the IR layer, so all four backends and every path
> (`-S` / `-c` / `--ipo` / `-link --lto`) see the same cleaned IR, at `-O0` too.

---

## 0 What this document answers

1. Why not emitting is a correctness fix rather than an optimisation (SS1);
2. What counts as "referenced" (SS2);
3. Which functions are never dropped (SS3);
4. How references inside raw assembly text are handled, and what happens when the text cannot
   be read (SS4);
5. The measured numbers and the gate (SS5, SS6);
6. How an author keeps a function, and how they still hear about an unused one (SS7);
7. What this pass does **not** do (SS8).

## 1 Why this is a correctness fix

C11 6.2.2p3: a `static` function has internal linkage, so no other translation unit can name it.
C11 6.7.4p6 requires a definition when one is used; it never requires one to be kept when it is
not. Dropping an unreachable `static` body is therefore allowed by any conforming
implementation.

In ARK it is also **necessary**. Dead header helpers reference external objects that the unit
only declares. The classic shape is CMSIS's

```c
__STATIC_INLINE uint32_t ITM_SendChar(uint32_t ch) { ... ITM_RxBuffer ... }
```

where `ITM_RxBuffer` is provided by the debugger and only `extern`-declared in the source. As
long as a definition of `ITM_SendChar` exists in the unit, the object writer refuses:

```
Error: reference to the global 'ITM_RxBuffer', which this translation unit only declares; ...
```

Code that can never run made a compile fail. Removing it takes the problem away with the dead
code. gcc has done this since `-O1`; armcc and IAR do the same -- this is what peers do, not a
radical step.

## 2 "Referenced" is a fixed point

`ir_drop_unused_static()` (`src/ir.c`) computes reachability at the IR level with five kinds of
edges:

| Edge | Source |
| --- | --- |
| Call | `IR_CALL` whose `name` is the candidate |
| Address taken | `IR_PUSH_FUNC` whose `name` is the candidate (`&f`, function-pointer tables, `_Generic` dispatch) |
| Global initialiser | `IrGlobal::init_sym` / `init_refs[]` (`int (*tab[])(void) = { h };`) |
| `alias` target | the `alias_target` of a kept function |
| Raw assembly text | the candidate's name occurs in an `IR_ASM` operand or in an `is_asm_func` body (SS4) |

The seeds are the functions kept for their own sake: everything that is not a candidate
(external linkage, `main`, entry-point names, functions carrying `used`/`weak`/`interrupt`...).
Reachability is then iterated to a fixed point, because one dead helper may be the only caller
of another -- the whole cluster has to disappear together.

A **candidate** has exactly one condition: `is_static` and not in the SS3 keep list.

## 3 The never-dropped list

| Kept because | Reason |
| --- | --- |
| `__attribute__((used))` / `__attribute__((unused))` | the author said the symbol itself matters |
| `weak` | a weak definition may be overridden at link time, or addressed from outside |
| `constructor` / `destructor` | the startup code calls them by section, not from C |
| `interrupt` (`is_irq`) / `naked` | the vector table names them; the body is raw assembly |
| `alias` target | `static void f(void) __attribute__((alias("g")));` |
| `main` | entry point |
| Entry-point names | `_start`, `Reset_Handler`, `NMI_Handler`, `HardFault_Handler`, `MemManage_Handler`, `BusFault_Handler`, `UsageFault_Handler`, `SVC_Handler`, `DebugMon_Handler`, `PendSV_Handler`, `SysTick_Handler`, `Default_Handler`, `__arkcc_init_globals` |

That last row is deliberate conservatism: a linker script, a vector table or startup code may
reference these **by name** without any C code doing so. A `static` `SysTick_Handler` is unusual
but legal; dropping it would at best produce an undefined symbol at link time and at worst make
a raw image jump into whatever bytes follow. This pass exists to save bytes, and that is not
worth the risk.

## 4 Inline assembly: keep what the text names, fail loudly when it cannot be read

Symbols inside assembly statements are invisible to the control-flow graph, so a reference such
as `__asm("bl helper");` has to be found in the text. For every candidate that is not already
kept, the pass does one substring search (`ir_text_names`):

- `bl helper`, `ldr r0, =helper` and `.word helper` all hit;
- the search is a **substring**, not a word match, so `helper2` also keeps `helper` -- a false
  positive costs one kept body, a false negative costs a link error;
- a whole-function `__asm` body (`asm_body`) goes through the same scan.

What about the shape that truly cannot be read (an assembler macro that concatenates the name)?
The name never appears in the IR, the `static` definition is dropped, and the link fails with
**undefined symbol**. That is a **loud** failure, never a wrong image -- which is the project
rule: "rather an error than a wrong answer".

## 5 Measurements (95 TUs, STM32F401xE HAL, Cortex-M4, `-O2`)

Counting rule: `^\s+[A-Za-z][A-Za-z0-9.]*\s` (no labels, no directives, no comments).

| Configuration | Before | Now | Delta |
| --- | ---: | ---: | ---: |
| Sixteen switches (no vreg) | 18,151 | **16,414** | **-1,737 (-9.57%)** |
| Same + `-fopt-vreg` | 18,151 / 17,350 | **15,613** | **-2,538 (-13.98%)** |

- **All 95 TUs got smaller**, not one got bigger;
- empty-shell TUs drop to zero (`stm32f4xx_hal_adc.c` and friends: 19 -> 0 instructions);
- everything removed was a function body with no incoming edge (the CMSIS
  `__REV16` / `__REVSH` / `__RRX` `__STATIC_INLINE __ASM` helpers ship one copy per TU).

## 6 The gate

`tests/run_deadinline_tests.py` (`make test-deadinline`, **24 checks**):

- both a dead `static inline` and a dead plain `static` disappear (`-c` and `-S` agree);
- a live function is kept, and so is anything a dead function did call;
- the `ITM_SendChar` shape (dead code referencing a declared-only object) now compiles;
- every keep reason has an anti-false-green case: `used`, `weak`, `constructor`, `interrupt`,
  `alias` and an entry-point name (`static void SysTick_Handler`) all survive;
- "the same plain `static` plus `used` still reports only-declares" -- proof that keeping is
  driven by the attribute, not by luck;
- `__asm("bl keep_by_asm")` naming the candidate keeps it (still only-declares); when the asm
  does not name it, the dead inline is still dropped.

`tests/arm_exec` (default arm and `-fopt-vreg` arm, 39 cases each, 0 failures) covers real
execution: dropping a live path anywhere would show up as a wrong answer in the emulator.

## 7 Two escape hatches for the author

1. **`__attribute__((used))`** keeps a `static` with no C reference (an ISR, a table entry taken
   by a linker script, an implementation only called from assembly).
2. **`--warn-unused-static`** runs earlier in the pipeline (the MIR/CFG stage), so the author
   still hears "this static is never used" even though the body is no longer emitted. Removing
   code is not the same as hiding the fact.

## 8 What this pass does not do

- **No non-`static` function is dropped**: an external symbol can be referenced from another TU
  that this unit cannot see.
- **No global variable is dropped**: an unreferenced `static` global is still emitted (its
  initialiser may have side effects, and `volatile` / section attributes weigh more). Separate
  work item.
- **Compiler runtime helpers such as `__aeabi_memcpy` are untouched**: they are not in the IR;
  the ARM backend already emits them on demand, only when a `BL __aeabi_memcpy` actually occurs.
- **This is not an optimisation switch**: no flag, active at `-O0`. Giving it an off switch
  would only let the "off" side walk back into the `ITM_RxBuffer` compile failure.

## 9 Where it lives

| File | Change |
| --- | --- |
| `src/ir.c` | `ir_drop_unused_static()` (the reachability fixed point), `ir_is_droppable_static()` (candidate rule), `ir_name_is_entry_point()` (the entry-point list), `ir_text_names()` (assembly substring search) |
| `include/ir.h` | declaration and the rules in comments |
| `src/compiler.c` | the single call site inside `ark_emit_program()`; `-v` prints `dropped %d unreachable static function(s)` |
| `tests/run_deadinline_tests.py` | 24 checks |

It hangs off `ark_emit_program()`, the single choke point, so `-S`, `-c`, `--ipo`,
`-link --lto` and all five backends (arm / i386 / x86_64 / rv32 / c) see the same cleaned IR.
