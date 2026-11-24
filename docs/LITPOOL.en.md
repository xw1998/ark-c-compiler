# 32-bit constants in a literal pool (`-fopt-litpool`)

English | [中文](LITPOOL.md)

> The second optimization of 0.9.1 (after [DIVCONST.en.md](DIVCONST.en.md)). One
> sentence: **turn a 32-bit constant's "`MOVW` + `MOVT`" (two instructions) into
> "one `LDR` from a PC-relative literal pool"**. `MOVW`+`MOVT` is eight bytes of
> code to move four bytes of value; with a pool every site costs four bytes, plus
> four bytes once in the pool.
>
> Implementation: `src/backend/arm/backend_arm.c` (`ark_litpool_function()`, a
> **text-level pass**)
> New assembler form: `LDR rd, <label>` (a single 32-bit encoding)
> Gates: `tests/run_litpool_tests.py` (`make test-litpool`, 21 checks)
> Switch: `-fopt-litpool` / `-litpool`, INI `opt-litpool=` / `litpool=`

---

## 1. The profit model: `4(c - 1)`

A 32-bit constant used `c` times:

| Scheme | Code |
| --- | --- |
| `MOVW`+`MOVT`, one copy per site | `8c` bytes, `2c` instructions |
| Literal pool, one copy in the pool | `4c + 4` bytes, `c + 1` instructions |

The saving is `4(c - 1)` bytes and `c - 1` instructions.

Two consequences, spelled out so the numbers cannot be misread:

- **`c = 1` is byte-neutral** (4 + 4 = 8); it only saves one instruction. So this pass
  **does not filter by use count**: a constant used once is pooled too, and its profit
  is "one instruction", not size.
- **`c = 0` cannot happen** (an unused constant has no `MOVW`/`MOVT`), so there is no
  negative case.

On real code, "the same 32-bit constant materialised several times" is common: the 807
`MOVW`/`MOVT` pairs in the 95-TU corpus cover only on the order of 125 distinct
constants (the older estimate was 6.42 uses per constant). That is exactly what a pool
eats.

## 2. Why a text-level pass and not a new IR pass

For the same reasons as `-fopt-cmat` and `-fopt-slotreg`:

- **It has to see the final register names.** A pool load is `LDR rD, <label>`, and `rD`
  must be the post-allocation name; doing it on the IR would mean carrying the register
  assignment back up.
- **It has to run after `-fopt-cmat`.** cmat's M1/M2 already handle "the constant is in a
  register" and "the constant folds into the addressing mode"; what is left is the residue
  that genuinely needs a value in memory. Pooling first would turn sites cmat could have
  folded into an `LDR`, a wasted instruction.
- **It has to run after every pass that rewrites text** (`-fopt-vreg`, `-fopt-slotreg`,
  `-fopt-cmat`): those passes insert and delete lines, and deleting lines after a pool was
  built would leave the pool referenced by nobody.

Pass order (`ark_emit_program`): vstack → addr → cbz → peep → copyprop → live/coalesce
→ regalloc (with constcache inside) → vreg → slotreg → cmat → **litpool** →
`ark_fix_far_offset` → `.init_array` / `.fini_array` → `__arkcc_init_globals` (emitted
separately, never through a text pass).

## 3. The new assembler form: `LDR rd, <label>`

The internal assembler already took `LDR rd, =label`, but that expands into `MOVW` +
`MOVT` — precisely the shape this pass removes, so it is useless here. A second form was
added:

```
    LDR  r3, .Llit_7_2_0
```

- **Fixed 32-bit encoding**: `hi = 0xF8DF`, `lo = (rd << 12) | imm12`, i.e. `LDR Rt, [PC, #imm]`
  with `pbase = (pc + 4) & ~3` (Thumb reads PC as "this instruction + 4", then word-aligns)
  and `imm12` a **byte** offset in 0..4095.
- **Why the size is fixed**: pass 1 counts sizes before the pool exists and therefore cannot
  know the distance. A width that floats with distance would make pass 1 and pass 2 disagree
  and shift every label. Fixed 32 bits is the cheap, correct choice, and its 4 bytes are
  exactly the 4 in the profit model.
- **Out of range is an error, not a silent truncation**: when `imm12 > 4095`, or the label is
  not in this file, `diag_tool(DIAG_SEV_ERROR)` reports it and two `0xBF00` (`NOP`) fill the
  four bytes so the size and every later label stay correct. **An error beats a wrong
  answer.**

## 4. Where the pool goes: regions, not one pool per function

`LDR [pc, #imm]` reaches only 4,095 bytes — roughly 1,000 instructions. **A large function
cannot host a single pool** (two of them exist in the 95-TU corpus, and together they hold
225 of the 711 convertible pairs). So the text is cut into **regions**, one pool per group
of regions:

1. **A region ends at an instruction that ends the control flow**: `POP {..., pc}`,
   `BX ...`, unconditional `B ...`.
2. **Only the unconditional forms count.** Control comes back after `POPNE {.., pc}` and
   after `BXEQ lr`, so `lp_ends_flow()` requires a blank or tab right after `BX` / `POP`
   (which excludes `BXNE` and `POPNE`). This is a hard constraint: the pool is data and
   control must never run into it.
3. **Greedy forward merging**: adjacent regions are merged into one group while the total
   stays within `LP_REACH_INS = 800` instructions. The 800 comes from
   `4 × 800 + 4 × 128 = 3,712 < 4,095`, which leaves slack for the `.align 4` in front of
   the pool.
4. **A single region larger than 800 instructions is left unpooled.** Safety first: a
   straight-line region with no terminator has nowhere to put a pool; skipping it is
   correct and merely less compact.
5. **The pool sits right after its group's terminator**, preceded by `.align 4`. Control has
   already left at that point, every branch targets a label, and every label comes after the
   pool — so **no branch can fall into a pool**.

## 5. What is refused

| Refusal | Reason |
| --- | --- |
| The function's last instruction is not a terminator | A pool is data; a function that falls off its end is a bug already and appending data would turn it into a jump into a constant |
| The line before a `MOVW`/`MOVT` pair is `.arkdata` / `.arkdatasym` | The linker patches both halfwords (reloc type 6/15), so the pair must stay a pair |
| A single region over `LP_REACH_INS` (800 instructions) | Nowhere to put the pool; skipped |
| More than `LP_MAX_POOL` (128) distinct constants in one pool | That site stays as it was (`MOVW`/`MOVT` untouched) |
| A function over `LP_MAX_LINES` (4096) lines | The whole function is left alone (static table limit; correct, merely less compact) |

The third and fifth are **table limits**, not conservative guesses: the tables are static
arrays (compiled out entirely under the STM32_MIN profile, see §7), with no dynamic
allocation.

## 6. Measurements (0.9.1-wip, host build, 95 valid TUs, Cortex-M4)

| Reading | 18 switches | 19 switches (+`-fopt-litpool`) | Delta |
| --- | ---: | ---: | ---: |
| Instructions | 14,271 | **13,566** | **-705** |
| Code bytes | 36,114 | **34,980** | **-1,134** |

- **Instructions** -705 (-4.94%), **bytes** -1,134 B (-3.14%).

The byte bill reconciles line by line (counted with `grep -c` on the `.s` files the
19-switch build produces): **705 sites** (`LDR rD, .Llit_*`) and **359 pools**
(`.Llit_*:` definitions). Each site goes 8 → 4 bytes, i.e. -4, total **-2,820**; each pool
costs 4 bytes, total **+1,436**; the `.align 4` in front of the pools pads **250** bytes in
total. So

```
-2,820  +  1,436  +  250  =  -1,134  B   (matches the measured difference exactly)
```

Fewer pools means more saving — which is why regions are merged greedily (one pool per
group rather than one per terminator).

Pair audit (same corpus, `MOVW rX` immediately followed by `MOVT rX`):

| Item | Count |
| --- | ---: |
| Adjacent same-register `MOVW`/`MOVT` pairs with 18 switches | **807** |
| Of those marked by `.arkdata` (the linker patches them) | 96 |
| Of those with different registers or not adjacent (not a real pair) | 0 |
| Poolable (`807 - 96`) | 711 |
| **Converted** | **705** (the other 6 sit in long regions / large functions the pass refuses) |
| Remaining `MOVW` / `MOVT` with 19 switches | 236 / 102 (338 = 1,740 - 1,402) |

`807 - 96 = 711` poolable, 705 actually converted, matching the measured instruction
difference exactly. The old `docs/BOUNDARY.en.md` section 5.1 estimated -803 instructions /
-2,712 B by assuming every pair converts and each constant gets one pool. The measurement
is smaller, for three reasons: 96 pairs are linker patches (untouchable), 6 are refused by
the region/function limits, and **every region group builds its own pool** (the same
constant can occupy one word per group).

One function, `HAL_RCC_OscConfig()` (`stm32f4xx_hal_rcc.c`):

| Setting | Instructions in that function | TU total |
| --- | ---: | ---: |
| 18 switches | 1,256 | 2,171 |
| 19 switches | **1,229** | **2,085** |

That function is large enough to need four groups — the region mechanism showing up on real
code.

## 7. Cropping (three layers, zero change when off)

| Layer | Mechanism | Guarantee when off |
| --- | --- | --- |
| Compile time | `ARKCC_FEATURE_OPT_LITPOOL` (`include/arkcc_config.h`; 0 under `ARKCC_PROFILE_STM32_MIN`) | The pass and all its static tables disappear; the `enable_opt_litpool` references fold away |
| Run time | `g_config.enable_opt_litpool`, `-fopt-litpool` / `-litpool`, INI `opt-litpool=` / `litpool=` | Default **0**; with the flag off the output is byte-identical to a build without the feature (measured by the gate) |
| Profile | none needed (text-level pass, not in the `--pipeline` table) | — |

**The static tables cost memory**: `LP_MAX_LINES = 4096` gives seven line tables of
4096 × (4+4+4+2+2+4+4) ≈ 96 KB, plus three 1,024-entry group tables ≈ 12 KB and a 512 B
pool table, about **108 KB** in total. Irrelevant on a PC, not on STM32H743 RAM, so the
on-board profile (`ARKCC_PROFILE_STM32_MIN`) **crops it by default**; the host and the
Linux/Windows cross builds keep it.

A cropped build **refuses the flag** rather than pretending to optimise:
`-DARKCC_FEATURE_OPT_LITPOOL=0` makes `-fopt-litpool` report

```
Fatal error: C3900U: -fopt-litpool is not compiled into this build
(rebuild with -DARKCC_FEATURE_OPT_LITPOOL=1)
```

and compiling without the flag behaves exactly like the full build (gate group 6).

## 8. Gates (`tests/run_litpool_tests.py`, 21 checks)

`make test-litpool`. Fixtures and assertions:

1. **OFF IS OFF**: no flag and a cropped build (`-DARKCC_FEATURE_OPT_LITPOOL=0`) produce a
   byte-identical `.s`.
2. **Repeated constant (`REUSE`)**: one constant at three sites plus one more pair ⇒ the
   instruction drop equals the number of adjacent same-register `MOVW`/`MOVT` pairs in that
   fixture; the image (`ARKOBJ2` header) shrinks.
3. **Single use (`ONCE`)**: each materialisation loses one instruction and the **byte count
   does not change** (8 → 4 + 4 in the pool).
4. **Pool placement**: every pool is introduced by `.align 4` and the instruction right
   before it is a terminator.
5. **Labels unique and self-consistent**: each `.Llit_` definition appears once and every
   site's label is defined.
6. **Multiple regions (`region_src(80)`, about 3,000 instructions / 79 pools / 4 groups)**:
   at least two pools exist and at least one lands mid-function (not only at the end), and
   the file still assembles (the reach gate).
7. **`.arkdata` untouched**: under `--reloc-data` the only `MOVW`/`MOVT` is the linker pair;
   the `.arkdata` + `MOVW` + `MOVT` triple is byte-identical and all 30/30 lines of that
   function are unchanged.
8. **Execution agrees three ways**: three fixtures run on unicorn under off / on /
   on-only builds produce the Python expected values.
9. **Crop gate**: a `-DARKCC_FEATURE_OPT_LITPOOL=0` build rejects `-fopt-litpool` with
   `C3900U` and still compiles without the flag.
10. **Selectivity**: in one TU the materialisations are rewritten while variables and
    `.arkdata` pairs are preserved — ruling out "the file never actually ran".

The full execution suite is also run:
`tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe --extra=-fopt-litpool` ⇒ **0 failure(s)**;
`run_cmat_tests.py` and `run_vreg_tests.py` are green.

## 9. Division of labour with `-fopt-constcache`

Both handle "one 32-bit constant materialised repeatedly", but the mechanisms differ and are
**not substitutes**:

| | `-fopt-constcache` | `-fopt-litpool` |
| --- | --- | --- |
| Where the value lives | a callee-saved register (`r8`-`r11`) | a word in the literal pool |
| Cost per site | `MOV rD, rC` (2 bytes) | `LDR rD, [pc, #imm]` (4 bytes) |
| Up-front cost | one `MOVW`+`MOVT` at entry plus save/restore | 4 bytes in the pool (no runtime instruction) |
| Threshold | >= 5 uses in one function | none (`c >= 1` is enough) |
| Conflicts | gives up when no register is free | needs no register |

In principle "constcache takes the hot constants, litpool takes the rest" is stronger, but
the constants constcache already took would have been one word in the pool too, and letting
both act on the same constant would make constcache's 2-byte `MOV` lose to a 4-byte `LDR`.
The order is therefore fixed at **constcache first, litpool second** (regalloc runs before
litpool in the pass order), and the pool only takes sites constcache did not. This is one
reason the measured gain is below the theoretical bound.

## 10. Deliberately not done

- **No assembler-level pool** (`.ltorg`, automatic `LDR =imm` collection): only the code
  generator knows which constant is worth pooling and which group should own a pool; an
  assembler-level scheme would also be unable to participate in the 4,095-byte budget.
- **No pool shared across functions**: that needs linker cooperation and section layout, and
  a shared pool that becomes unreachable is dead weight.
- **No 16-bit `LDR` (T1, `imm8 × 4`)**: it reaches only 1,020 bytes, so regions would shatter
  into one pool per ~250 instructions and the per-constant pool cost would eat the gain; T1
  can only target `r0`-`r7` anyway.
- **No `.arkdata` pairs**: see §5.
- **No claim that pooling makes code smaller in general**: a single-use constant is
  **byte-neutral** and only saves an instruction; the document and the gates use exactly
  that wording.
- **Not implemented for the x86-64 / RISC-V backends**: that trade-off does not exist there,
  so `-fopt-litpool` is a harmless no-op.
