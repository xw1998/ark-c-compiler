# Divide by a constant → multiply by a magic number + shift (`--divconst`)

> The third optimization of 0.9.1. One sentence: **when the divisor is known at
> compile time, replace `SDIV`/`UDIV` (or the call to `__aeabi_idiv`) with
> "multiply by a magic number, then shift right"**. ARM has no hardware divide,
> so a `x / const` drops from 20+ cycles to 3–6.
>
> Implementation: `src/backend/arm/backend_arm.c` (**emission time**, not a new pass)
> Gates: `tests/run_divconst_tests.py` (`make test-divconst`)
> Switch: `--divconst` / `--no-divconst`, INI `divconst=` / `div-const=`

---

## 1. Why emission time instead of a new pass

The decision rests on exactly one fact: **is the divisor a constant**. In the IR that
shows up as `IR_PUSH_INT c` immediately followed by `IR_DIV` / `IR_MOD`, because irgen
compiles `x / 3` as "push c, push x, divide". So the emitter can tell by looking at the
next instruction — no IR change, no four backends, no new `irser` field.

The price is that the sequence **cannot use MIR's register allocation**: it computes in
r0–r3 on its own. That is in line with how this backend already works (a stack machine
plus `emit_push_r0`/`pop_r0` shuffling), so the risk is contained.

Negative constants have one more layer: `x / -5` is **not** `PUSH_INT -5`, it is

```
IR_PUSH_INT 5      ; val = 5
IR_UNARY           ; aux = TOK_MINUS, val = 0  (32-bit negation)
IR_DIV
```

so the lookahead has to reach further: `at = 1` (the next instruction is already DIV/MOD)
or `at = 2` (the next is the 32-bit negating `IR_UNARY` and the one after that is DIV/MOD).
In the second case the divisor becomes `0u - dv` (the wraparound gives exactly the negative
bit pattern) and a counter `divconst_skip` swallows that negation — otherwise it would
negate the divisor while it sits on top of the stack.

## 2. The math: unsigned magic numbers

For an unsigned divisor `d ≥ 2`, take

```
L = ceil(log2 d)          ; the smallest L with 2^L >= d
m = ceil(2^(32+L) / d)
e = m*d - 2^(32+L)        ; 0 <= e <= 2^L always
```

Then for every `0 <= n < 2^32`, `floor(n/d) = floor((n*m) / 2^(32+L))`. Three shapes:

| Shape | Condition | Sequence |
| --- | --- | --- |
| shift | `d` is a power of two | `LSR r0, r0, #log2(d)` |
| multiply | `m < 2^32` | `UMULL r2,r3, r0, m` → `LSR r0, r3, #L` (`r3` is the high half) |
| add form | `m >= 2^32` | `t = mulhi(n, m-2^32)`; `q = (t + ((n-t) >> 1)) >> (L-1)` |

The add form is the textbook derivation: when `m >= 2^32`, `mulhi(n, m)` overflows, so
multiply by `m - 2^32` instead and add back that bit's contribution via
`t + ((n-t)>>1)`.

**The `L == 32` special case**: `2^(32+L) = 2^64` is not representable and
`m = ceil(2^64/d)` does not fit a 64-bit intermediate. Use `m = (2^64 - 1)/d + 1` and
`e = m*d` (the 64-bit unsigned product wraps, and the wrapped value is exactly the error
term) and stay on the add form. Divisors above 2^31 are the usual trigger; the gate
covers them with `3000000000u`.

Unsigned remainder: `r = n - q*d`, or `AND r0, r0, #(d-1)` when `d` is a power of two.

## 3. The math: signed division via magnitudes

Signed division does not use a signed magic number (that needs its own error proof);
instead it **reduces to the exhaustively verified unsigned result**:

```
sign = n >> 31 (arithmetic)   ; 0 or -1
|n|  = (n ^ sign) - sign
q'   = |n| / |c|              ; the unsigned sequence above
q    = (q' ^ s) - s           ; s = sign, s = ~sign when c < 0 (one MVN)
r    = n - q*c                ; the remainder uses the *original* divisor
```

- `c < 0` only flips the sign register (`n / -d == -(n/d)`, `n % -d == n % d`), no extra
  negation.
- `n = INT_MIN` is automatically right: `|n| = 0x80000000` is a legitimate unsigned 2^31,
  and negating back wraps to `INT_MIN`, which is exactly what C asks for.
- The remainder goes through `q*c` rather than a mask: for negative `n`, `% 8` is **not**
  `n & 7` (gate item `m8` exists for this; the first implementation got it wrong and that
  gate caught it).

The math was verified in Python before any code was written: 9,150,609 unsigned `(d, n)`
pairs and 4,030,257 signed ones (including `INT_MIN`, negative divisors, negative powers
of two) — **0 failures**.

## 4. The refusal list (a refusal is byte-identical output)

| Refused | Why |
| --- | --- |
| `c == 0` | division by zero is UB; keep the existing behaviour (really emit the divide) |
| unsigned `c == 1` | nothing to save, and an empty sequence would blur the "refused" accounting |
| signed `c == 1` | same |
| signed `c == -1` | `INT_MIN / -1` overflows (UB); the magnitude path would produce a wrong value when `|n| = 2^31` |
| signed `|c| == 2^31` | `|c|` is not representable as a positive int32 |

The gate for refusals compares the **whole file byte for byte** (not "no magic number
appeared"): recompile with the switch on and SHA-compare against the off version.

## 5. The emitted sequences (measured, `-O2`)

Signed `x / 3`:

```asm
    POP  {r0}              ; dividend
    ASR  r1, r0, #31
    EOR  r0, r0, r1
    SUB  r0, r0, r1        ; |n|
    PUSH {r1}              ; save the sign
    MOVW r1, #21846
    MOVT r1, #21845        ; m = 0x55555556
    UMULL r2, r3, r0, r1
    SUB  r2, r0, r3
    LSR  r2, r2, #1
    ADD  r2, r3, r2
    LSR  r0, r2, #1
    POP  {r1}
    EOR  r0, r0, r1
    SUB  r0, r0, r1        ; q
    PUSH {r0}
```

Signed `/ 8` (a power of two) keeps only `LSR r0, r0, #3` in the middle; signed `% 3` adds
`MOV r2, #3` / `MUL r0, r0, r2` / `SUB r0, r1, r0` after q.

Unsigned `/ 7u`: `MOVW`/`MOVT` for `m`, `UMULL r2,r3`, then `SUB`/`LSR #1`/`ADD`/`LSR #2`.
Unsigned `/ 8u` is just `LSR r0, r0, #3`; unsigned `% 8u` is just `AND r0, r0, #7`
(for masks above 255 the compiler emits `MOV r1, #mask` + `AND r0, r0, r1`).

Two implementation details:

- **The in-house assembler only accepts the 16-bit `MUL Rd, Rn, Rm` form with `Rd == Rn`**,
  so the remainder sequence is written `MUL r0, r0, r2` and then `SUB r0, r1, r0`; it
  cannot be `MUL r3, r0, r2`.
- `MVN r1, r1` is the only extra instruction for negative divisors, and it has to happen
  **before** `PUSH {r1}` — otherwise the stale sign is saved.

## 6. Trimming (three layers, zero change when off)

| Layer | Mechanism | Guarantee when off |
| --- | --- | --- |
| compile time | `ARKCC_FEATURE_DIVCONST` (`include/arkcc_config.h`, `STM32_MIN` ⇒ 0) | the lookahead block and the emitter disappear; `divconst_live` is a constant 0 and the DIV/MOD `if` folds away |
| run time | `g_config.enable_divconst`, `--divconst` / `--no-divconst`, INI `divconst=` | defaults to 0; the default object is byte-identical to a build without the feature (gated) |
| profile | (none needed) | emission-time optimization, not in the `--pipeline` stage table |

A trimmed build **refuses** the option rather than pretending: with
`-DARKCC_FEATURE_DIVCONST=0`, both `--divconst` and INI `divconst=1` report `C3900U`
naming the macro.

Measured cost of the feature (host gcc 4.8.0 `-O2`, `backend_arm.c` only): `.text`
93376 → 95056 B, i.e. **1680 B of code, 0 B of data**; symbol count 186 → 189 (three of
the four static functions were not inlined; no new external symbols). The board project
`mdk/STM32H743_ArkCC` uses `ARKCC_PROFILE_STM32_MIN`, so the emission-time code is gone entirely (UV4 rebuild: 0 Error):
`Code=182820 -> 182824`, `ZI-data=37136 -> 37140`. The extra 4+4 bytes come from the
config layer -- the INI key `divconst=` and the extra `--print-config` item are not guarded by
the feature macro (same shapes as `tailcall`).

## 7. Gates (`tests/run_divconst_tests.py`, 45 items)

Six groups, each able to fail on its own:

1. **Static shapes**: a translation unit full of constant divides has zero `SDIV`/`UDIV`,
   and each of the 16 cases hits its own documented marker (add form / shift / mask / `q*d`
   / flips the sign register / `L == 32`).
2. **Selectivity inside one TU**: in the same file the constant divides are rewritten while
   the variable divisors keep `SDIV`/`UDIV` — this rules out "the file was never processed".
3. **Refusals are byte-identical**: the five refused constants plus unsigned `1u` produce
   exactly the same `.s` with the switch on and off.
4. **Execution agrees three ways**: 16 constant divides × 66 dividends (±`INT_MIN`/`INT_MAX`,
   255/256/65535, 123456789 and an LCG sweep) run on the emulator, and the checksum must match
   both "switch off" and an exact Python model of C truncating division; the checksum is also
   asserted to be non-trivial. `--reg-top`, `--divconst --reg-top` and `--divconst --tailcall`
   must all produce the same checksum.
5. **Anti-false-green**: off by default (byte-identical object), `--no-divconst` restores it,
   a trimmed build refuses the option while its default object equals the untrimmed one, and
   the INI key works.
6. **Honest byte account**: the object and instruction-line deltas are printed in both
   directions; only the unsigned 2^k divide and remainder are asserted to get *shorter*.
   No blanket "an optimization must shrink code" claim.

## 8. Measurements (0.9.1, host gcc + emulator, `Cortex-M7`)

| Reading | Value |
| --- | --- |
| Gate items | 45, all PASS |
| Execution checksum | `0x40F32C43` (off / on / Python agree) |
| `--reg-top` / `--tailcall` combinations | same checksum |
| Object size (the 16-divide TU) | 4293 → 4533 B (**+240 B**) |
| Instruction lines | 1743 → 1836 (**+93 lines**) |

The size goes up, and here is why: `SDIV`/an `__aeabi_idiv` call is 2–4 bytes while a magic
sequence is 8–12 bytes. This optimization trades **cycles**, not **bytes** — only the two
power-of-two shapes shrink. Shrinking the rest needs P4 (block-level duplicate elimination)
or the later `--size` weight (P6); this pass does not pretend otherwise.

## 9. Deviations from the roadmap (recorded as-is)

- The roadmap said "`ir.divconst` (a new IR pass)". The implementation lives at **emission
  time**: the IR has no notion of a 64-bit high-multiply, so a pass would touch four
  backends plus `irser` and `MIR`, while the emitter can just write `UMULL`.
- The roadmap said "signed uses a round-up correction". The implementation uses the
  **magnitude method** instead, so correctness is inherited directly from the exhaustively
  verified unsigned result and neither `INT_MIN` nor negative divisors need a separate proof.
- Like the other optimizations here, there is **no `-O` level gate**: an explicit
  `--divconst` is the intent. The `-O2` in the roadmap heading therefore only means
  "part of the default pipeline"; this document is authoritative.

## 10. Deliberately not done

- **No 64-bit division**: `long long / const` goes through `__aeabi_ldivmod` and needs a
  64×64 multiply with a 128-bit intermediate — a separate round with its own proof.
- **No floating point**: `double / const` needs a much stronger round-to-nearest proof (and
  the board has no FPU).
- **No other backends**: x86-64 and RISC-V have hardware divide, so `--divconst` is a
  harmless no-op there.
- **No compile-time error for `d == 0`**: that is a diagnostic (`-Wdiv-by-zero`), not an
  optimization boundary. This pass only promises not to change UB behaviour.
- **No inflated size claims**: see group 6 of section 7.