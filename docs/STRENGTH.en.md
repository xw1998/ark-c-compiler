# Strength reduction (`-fopt-strength`)

English | [中文](STRENGTH.md)

> The sixth optimisation of 0.9.1. In one sentence: **a multiply by a power of two does
> not need a multiply — a shift is enough; and on this corpus the multiplies that actually
> cost are not the `x * 4` in the source, they are the "element size × index" sequences the
> compiler itself emits for array subscripts.**
>
> Implementation: `src/opt.c` (`opt_strength_func()`, IR level) +
> `src/backend/arm/backend_arm.c` (`case IR_LOAD_IDX`, backend)
> Gate: `tests/run_strength_tests.py` (`make test-strength`)
> Switch: `-fopt-strength` / `-fno-opt-strength`, INI `opt-strength=` / `strength=`

---

## 1. Why one switch with two landing points

"Turn a multiply by a power of two into a shift" is **one idea**, but in this compiler it
shows up in two places, and neither covers the other:

| Landing point | Shape it sees | `MUL` count on the HAL corpus |
| --- | --- | --- |
| **A. IR peephole** | constant multiplies in the source: `x * 4`, `x * 1`, `n * 8` | 53 |
| **B. Backend `IR_LOAD_IDX`** | element-size scaling the compiler generates: `p[i]` → `i * sizeof(*p)` | 1,052 |

A cannot see B — B is computed **after** the IR, inside the backend's addressing code
generator. The IR only holds an `IR_LOAD_IDX(base, index, size)` node; there is no
`IR_PUSH_INT 4` plus `IR_BINARY MUL` anywhere. And B is the bulk: of the 1,105 `MUL`
instructions in the HAL corpus, 1,052 are `p[i]` stride scaling
(`MOV r2, #4` 1,043 times, `MOV r2, #2` 9 times); the source-level constant multiplies are
only 53 (`MUL r0, r1` 40, `MUL r0, r4` 8, `MUL r0, r7` 5).

Two flags would force users to remember to enable both before getting the full effect, so
**one `-fopt-strength` drives both places**.

## 2. Landing point A: the IR peephole

Matches two **adjacent** instructions:

```text
IR_PUSH_INT k            k is a power of two, 2 <= k <= 0x40000000
IR_BINARY  TOK_MUL   ->  IR_PUSH_INT log2(k)
                         IR_BINARY  TOK_SHL
```

When `k == 1` **both instructions are deleted**: multiplying by one is the identity, and
`PUSH 1` + `MUL` has a net stack effect of zero, so the stack shape is unchanged.

Deliberate non-goals:

| Not done | Reason |
| --- | --- |
| `k == 0` | the IR has no neutral "drop the top of stack" operation; deleting would unbalance the stack |
| `k < 0` | a negative constant needs an extra negate, a net loss |
| `3`, `5`, `10`, other non-powers | `MUL` is **one cycle** on Cortex-M4; an `LSL`+`ADD` chain is at least two instructions and never shorter (`x*3` becomes a single `ADD r0, r0, r0, LSL #1` in AC5, which has a full strength-reduction table; that is not this rule) |
| constant on the left (`4 * x`) | the rule only looks at two adjacent instructions; `4 * x` lowers to `PUSH x, PUSH 4, MUL` and the window misses it. Missing a case beats getting one wrong |

`IR_BINARY` has a "left operand, right operand" stack shape; multiplication is commutative
so either orientation would be safe, but the implementation still requires `PUSH k` to sit
immediately before `MUL` rather than guessing which side is constant.

## 3. Landing point B: the `IR_LOAD_IDX` stride

The backend used to emit, for every scaled index:

```asm
MOV  r2, #4          ; element size
MUL  r1, r2          ; index * sizeof(element)
```

When `es` is a power of two it now emits:

```asm
LSL  r1, r1, #2      ; one instruction
```

`sh` comes from `while ((1 << sh) < es) sh++;`. When `es == 1` neither instruction was
emitted in the first place, so no branch is needed.

This **saves one `MOV` and one `MUL`** (the `MUL` is single-cycle, but fetch and decode are
not), and it applies to code the compiler generates itself, so no source spelling can dodge it.

Non-power-of-two `es` (structs of 12, 20, 24 bytes) are left alone: `LSL` cannot express
them, and `ADD Rd, Rn, Rm, LSL #n` — the form that does ×3/×5/×(5·2^n) in one instruction —
is **not emitted by this repository's internal assembler** yet, so it stays a debt instead
of being forced in.

As of 0.9.1-wip the power-of-two case goes one step further: the second half of
`-fopt-strength` (R4, see §6.5) merges the adjacent `LSL` into the operand, producing
`[Rn, Rm, LSL #n]`. Non-powers of two are still left completely untouched.

## 4. Stage position: why it must sit at the end of the pipeline

`ir.strength` is listed in `src/pipeline.c` **after `ir.xblock` and before `ir.vectorize`**.

The first version sat right after `ir.dce` ("do it after constant folding / dead code").
The result was that **enabling it made the output bigger**: the `pow2` fixture went from
512 to 533 instructions and the image from 2128 to 2170 bytes (+42 B).

The rule itself was not at fault: deleting `x * 1` dropped a function's IR from 12 to 10
instructions, which fell just under the `opt_inline` threshold, so `scale()` got **inlined**
into its caller and the caller grew. In other words, running strength early changes
**later pass decisions**, and inline's cost/benefit is not part of this pass's contract.

Moving the whole stage row after `ir.xblock` means inline / const-global / tailmerge / xblock
see exactly the same IR shape as before, and only the final emission sees the shift form.
After the move: 512 → 503 and 2128 → 2110; the problem is gone.

The order is **measured, not assumed**; the reasoning lives in the comment in `src/pipeline.c`.

## 5. Evidence: what AC5 does

Running armcc on the same machine:

```bash
/d/Keil_v5/ARM/ARMCC/bin/armcc.exe --c99 -O2 -c --cpu Cortex-M4 /tmp/acc.c
/d/Keil_v5/ARM/ARMCC/bin/fromelf.exe --text -c /tmp/acc.o
```

```asm
; int sumi(int *p, int n) { ... *p++ ... }      ->  LDR  r4, [r3, r2, LSL #2]
; int m4(int x)  { return x * 4; }              ->  LSLS r0, r0, #2
; int m3(int x)  { return x * 3; }              ->  ADD  r0, r0, r0, LSL #1
```

Three conclusions:

1. AC5 does **not** emit `MUL` for `x * 4`; it emits `LSLS`.
2. AC5 emits a single scaled `ADD` for `x * 3` — it carries a whole strength-reduction
   table, while arkc only handles powers of two.
3. AC5 folds the scale **into the addressing mode** (`[r3, r2, LSL #2]`) — one step, two
   instructions shorter than arkc's current "`LSL` then `[r1]`". This is the known gap
   that remains after `-fopt-addr` + this pass (see §7).

The shape this pass emits (a standalone `LSL r1, r1, #n`) is the "correct first, shorter
later" waypoint.

## 6. Measurements

Instruction counts are the number of non-directive, non-label lines in the `.s`
(`grep -cE '^    [A-Za-z]'`); object sizes are `arkcc -c` whole `.o` files
(**including symbol table and section headers, not pure text**) used only for like-for-like
comparison.

Corpus: `examples/ark_test/ark_test_all.c` (STM32F401xE + HAL + CMSIS, `-O2 -mcpu Cortex-M4`)

### 6.1 On top of plain `-O2`

| Build | Instructions | Delta | `MUL` | `LSL` |
| --- | --- | --- | --- | --- |
| `-O2` | 47,884 | — | 1,105 | 125 |
| `-O2 -fopt-strength` | **46,779** | **−1,105 (−2.31%)** | **12** | 1,209 |

Breaking the 1,105 down: the 1,052 `LOAD_IDX` stride scales × 2 instructions = 2,104
replaced by 1,052 `LSL`s (net −1,052); the 41 IR constant multiplies × 2 = 82 replaced by
41 `LSL`s (net −41); deleting `x * 1` contributes the rest. Total −1,105.

**`MUL` goes 1,105 → 12**, and not one of those 12 is a constant multiply: they are all
value-times-value (fixed-point/ratio arithmetic in the HAL). In other words, the
"constant multiply" category is emptied on this corpus.

### 6.2 On top of `-fopt-vstack -fopt-addr` (full chain)

| Build | Instructions | Delta |
| --- | --- | --- |
| `-fopt-vstack` | 37,976 | (−20.71% vs plain `-O2`) |
| `+ -fopt-addr` | 36,524 | −3.82% |
| `+ -fopt-strength` | 35,424 | −1,100 (−3.01%) |
| `+ -fopt-strength`, second half R4 active | **34,500** | **−924 (−2.61%)** |

Full chain: **47,884 → 37,976 → 36,524 → 35,424 → 34,500 (−27.95% cumulative)**.

R4 gets its own row only to keep the accounting readable: it is the *same* switch as the
row above. A user who passes `-fopt-strength` gets both halves; there is no second flag
(same reasoning as "one switch, two landing points" in §1).

### 6.3 Object bytes (same TU, `-c`)

| Build | Bytes | Delta |
| --- | --- | --- |
| `-O2` | 115,090 | — |
| `-O2 -fopt-strength` | 112,878 | **−2,212 B (−1.92%)** |
| `-fopt-vstack -fopt-addr` | 92,408 | — |
| `+ -fopt-strength` | 90,208 | **−2,200 B (−2.38%)** |

The absolute sizes differ but the relative drop is similar, so the gain does not depend on
the shape the previous two passes left behind.

**R4 does not change the object bytes**: the `all` arm is **90,208 B** both before and after
R4. That is not a no-op — every merge is "two 16-bit instructions become one 32-bit
instruction". The instruction count drops by 924 while the byte count does not move by a
single byte. The only honest way to state R4's gain is *instruction count*; it is not
"smaller".

### 6.4 Fixtures

| Fixture | Off | On | Note |
| --- | --- | --- | --- |
| `pow2` (`int` array sum + `short` array sum + `x*4 + x*8 + x*1` + pointer walk) | 512 insn / 2128 B | 503 insn / 2110 B | returns 112 |
| same, on top of vstack+addr | 333 insn / 1768 B | 326 insn / 1754 B | returns 112 |
| `odd` (`x*3 + x*5`) | 124 insn / 1298 B | 124 insn / 1298 B | **byte-identical**, returns 56 |

The `odd` row is this pass's **boundary evidence**: non-powers of two are untouched to the byte.

### 6.5 R4: fold the index scale into `[Rn, Rm, LSL #n]`

Section §3 turns `index * 4` into `LSL r1, r1, #2`, but the access that follows is still
`LDR r0, [r4, r1]` — two instructions. AC5 emits one. R4 closes that last step:

```asm
LSL  r1, r1, #2            LDR  r0, [r4, r1, LSL #2]
LDR  r0, [r4, r1]    →
```

**This is not a `-fopt-addr` rule**; it is the second half of `-fopt-strength`. The shape
only exists when strength is on (the shift is emitted there), and putting the rule in addr
would make addr recognise a shape it never produces, breaking addr's "OFF IS OFF"
invariant. It lives in `ark_addr_function()`'s round loop, after R2/R3, gated *both* by
`ARKCC_FEATURE_OPT_STRENGTH` and by the runtime `g_config.enable_opt_strength`. With the
default (off) the behaviour is unchanged — the `va` arm still measures 36,524, byte-for-byte
what it was before this work.

Four safety conditions, all required:

| Condition | Why |
| --- | --- |
| only `LDR` / `STR` | the byte/halfword register-offset forms have **no shift field**, so the merged encoding does not exist |
| `0 <= n <= 3` | the Thumb-2 register offset carries a 2-bit `LSL` |
| `rI != rB` | Thumb has no `[Rn, Rn, LSL #n]` |
| `rS` is dead after the access (or the load writes `rS`) | the emitted form is the in-place `LSL r1, r1, #2`; deleting it leaves the **unscaled** index in the register, and any later reader would see a different value |

One **liveness-model defect had to be fixed alongside it**: `ad_rw()` used to handle `PUSH`
and `POP` in the same branch and treat `POP`'s register list as a *read*. So `POP {r1}` kept
r1 alive forever and `ad_dead_after()` could never call it dead. The fix splits the two
branches and counts `POP`'s operands as **writes**. This one fix serves R1/R2/R3/R4 alike;
patching only R4 would not cure the disease. Fold count on the HAL corpus before/after the
fix: **243 → 924**.

Measurements (HAL corpus, `all` arm = `-fopt-vstack -fopt-addr -fopt-strength`):

| Quantity | Value |
| --- | --- |
| `LSL rX, rY, #1..3` count (`on` arm → `all` arm) | 1,052 → 126 |
| folds into the addressing mode | **924**, every one of them `LSL #2` |
| `[rB, rI, LSL #n]` operands | 0 → **924** |
| residue | 158 lines in `all` (1 in the fixture), all from `ad_dead_after()` bailing out conservatively at a label/branch |

The nine `#1` lines (byte/halfword accesses around LDRSH) have no shift field at all and are
skipped correctly — that is not a missed fold. The 158 residue is **not** chased: widening
`ad_dead_after()` across branches would turn the analysis into a guess. Missing 158 folds is
preferable to an unsound fold.

**The encoding is confirmed by a third party**: `tests/asm_cases/08_ldr_str_addr.s` contains
`ldr r3, [r4, r5, lsl #2]`, and its output is byte-identical to GNU `arm-none-eabi-as`
(39 instructions all identical), so this is not our assembler talking to itself.

## 7. Known gaps versus AC5

1. **The index scale is not folded into the addressing mode** — **resolved (0.9.1-wip)**.
   The original wording was: AC5 emits `LDR r4, [r3, r2, LSL #2]` while arkc emitted
   `LSL r1, r1, #2` + `LDR r0, [r4, r1]`, and the judgement at the time was that this
   belonged to `-fopt-addr`'s R2 rule and would break its "only delete, never rewrite"
   invariant. The actual fix differs: the rule sits in the second half of
   `-fopt-strength` (R4), because the shape only exists when strength is on, so addr on its
   own is unaffected. See §6.5. The cost is that the instruction stream gets shorter while
   the byte count stays the same.
2. **Non-powers of two**: AC5 has a full table for 3/5/9; arkc only has powers of two. The
   payoff depends on how much struct-array indexing the corpus has; `es = 12/20/24` accesses
   are rare in the HAL corpus.
   Checked one level further: **the premise does not hold, so this is not done (negative
   result)**. `ADD Rd, Rn, Rm, LSL #n` can only compute `Rn + Rm·2^n`, so strides of the
   `2^k ± 1` family (3/5/9) do fit in one scaled `ADD`, while 12/20/24 still need two
   instructions (`LSL` + `ADD`) at the same cost as `MUL` -- and 12/20/24 are exactly what the
   HAL corpus uses. Porting AC5's 3/5/9 table would cover only the rare sizes: a whole table
   for 0.1%, so it is not done.
3. **Left-hand constants**: `4 * x` is untouched (see §2).

## 8. What the gate says

`make test-strength` (`tests/run_strength_tests.py`), **18 checks** over two fixtures and five arms:

arms = `base` (`-O2`), `off` (`-O2 -fno-opt-strength`), `on` (`-O2 -fopt-strength`),
`va` (`-fopt-vstack -fopt-addr`), `all` (`va` + strength).

1. **OFF IS OFF**: `base` and `off` images are **byte-identical** (2128/2128) — the default
   build cannot see this pass.
2. **IT PAYS**: on `pow2`, `on` has fewer instructions than `base` (512 → 503).
3. **NO POWER-OF-TWO MUL**: on `pow2` the `MUL` count is `base=10 → on=0`, `all=0`.
4. **THE SCALE BECAME A SHIFT**: the `LSL r1, r1, #n` `IR_LOAD_IDX` form goes `base=0 → on=3`.
   An implementation that only does the IR level and misses the backend point fails this.
5. **NO RESIDUE**: the in-place `PUSH #2^k` + `MUL` pattern is **0** in `on` and `all`.
6. **IT PAYS ON TOP OF VSTACK/ADDR**: `all` has fewer instructions than `va` (333 → 326).
   (An earlier version compared `on` against `va`, which is not a valid baseline; there is
   now an independent `va` arm.)
7. **THE IMAGE NEVER GROWS**: `base/on = 2128/2110`, `va/all = 1768/1754`.
8. **SAME ANSWER**: all five arms return 112 under unicorn.
9. **NO REWRITE FOR NON-POWERS-OF-TWO**: on `odd`, `MUL` stays `base=on=all=4`, instruction
   count 124 → 124, image 1298 → 1298 / 1244 → 1244. This exists to stop a later
   "helpful" change from extending the rule to 3/5.
10. **CROPPED OUT**: a `-DARKCC_FEATURE_OPT_STRENGTH=0` build refuses `-fopt-strength` with
    `C3900U`, yet still compiles the same program without the flag.
11. **THE SCALE IS FOLDED INTO THE OPERAND**: on `pow2`, the `[rB, rI, LSL #n]` form is
    `all=1`, `on=0` — an implementation that only does "shift instead of multiply" and skips
    the later merge fails this.
12. **THE FOLD NEEDS ADDR**: the same form must be **0** on the `on` arm
    (`-O2 -fopt-strength`, no addr). This stops a later change from moving the rule outside
    addr and letting strength alone rewrite addressing.
13. **THE FOLD NEEDS STRENGTH**: the `va` arm (`-fopt-vstack -fopt-addr`, no strength) must
    be **0**. Symmetric with check 12: it pins down where the shape comes from.
14. **THE MERGE CONSUMES THE SHIFTS**: `LSL rX, rY, #1..3` is 3 on `on` and only 2 on `all`,
    i.e. the merge really eats the scaling shift. The assertion is "strictly fewer", not
    "zero": one shift in the fixture may still be reachable after a label, and
    `ad_dead_after()` conservatively refuses to fold it — correct behaviour. The gate prints
    the residue count, so it reads as an honest claim rather than a hidden one.

Checks 3/4/5 are an inseparable trio: an implementation that only measures "fewer
instructions" can pass through side effects. `MUL` at zero, `LSL` appearing and no residue
must all hold at once.

Every run also goes through the whole ARM execution corpus:

```
tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-strength"
tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-vstack -fopt-addr -fopt-strength"
```

Both report **0 failure(s)**. The fixtures check the shape; the corpus checks the
semantics: "a shift equals a multiply in the low 32 bits" only counts once signed /
unsigned, `short` promotion and pointer-difference cases have actually run.

## 9. Cropping

`ARKCC_FEATURE_OPT_STRENGTH` in `include/arkcc_config.h`: 0 under
`ARKCC_PROFILE_STM32_MIN`, 1 for host/cross builds.

Unlike earlier passes, **cropping this one out of the board profile is correct**: the pass is
off by default at run time, so on the board it would only sit in Flash unused. When 0,
`opt_strength_func()` and the backend branch are preprocessed away, and `src/main.c` refuses
the flag with `C3900U: -fopt-strength is not compiled into this build`.

At run time the pass is **off** by default (`g_config.enable_opt_strength = 0`), so builds
without the flag are byte-identical to 0.9.0 (`cmp`-verified: `BASE-IDENTICAL`, `VA-IDENTICAL`).

## 10. Relation to other passes

```
...  ir.constglobal -> ir.tailmerge -> ir.xblock
     ir.strength        # this pass: rewrites only the last IR step, never inline decisions
     ir.vectorize
     ...  emission -> ark_vstack_function() -> ark_addr_function() -> ...
```

- **After `ir.xblock`**: see §4.
- **Division of labour with `-fopt-addr`**: strength shortens the multiply inside address
  arithmetic; addr folds an already-computed address into an addressing mode. Adjacent but
  not overlapping; strength lives in the IR layer and addr in the assembly text, so the
  pipeline order follows from the architecture.
- **Relation to `-fopt-divconst`**: that one handles division by constants (long divide →
  multiply + shift), a different quadrant. Both replace an expensive instruction with a
  cheaper one, but divconst's predicate is a deterministic magic-number formula while this
  pass's predicate is exactly "is a power of two".