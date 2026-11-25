# Exact conversion of floating-point literals (one rounding, one implementation for host and board)

English | [中文](FLOATLIT.md)

> One of the "wrong answer" fixes in 0.9.1-wip. In one sentence: **a floating literal
> in the source denotes one specific IEEE-754 value (nearest, ties to even), and the
> compiler has to produce exactly that value, to the last bit.** The old lexer
> accumulated digits into a `double`, rounding at every step, and was 1 ulp off on
> long mantissas.
>
> Implementation: `src/lexer.c` (`lit_from_decimal` / `lit_from_hex` / `lit_round`,
> about 390 lines, all `static`, single threaded)
> Gate: `tests/run_floatlit_tests.py` (`make test-floatlit`, 419 cases)
> Switch: **none**. This is not an optimisation; it replaces "approximately" with
> "exactly". The on-board cropped profile compiles the same code.

---

## 1. The symptom: two 1-ulp wrong answers

```
double a = 123456789012345678.0;          // emitted 0x437b69b4ba630f36, should be ...0f35
double b = 0x1.0000000000000800000001p0;  // emitted 0x3ff0000000000000, should be ...0001
```

The second one is the nastier of the two: the emitted value *is* `1.0`, and the right
answer is only one ulp above it. Both are **silent wrong answers** -- compiles, runs,
result off in the last bit. Under this project's rule ("rather an error than a wrong
answer") that is worse than a refusal, which is why this went in before the 96-byte
size cleanup that had been queued ahead of it.

Conversely, the following are **not** bugs but correct results, listed so that nobody
"fixes" them next time:

| Literal | Correct value | Why |
| --- | --- | --- |
| `0x1.fffffffffffff8p0` | `2.0` | exactly halfway between `1.111...1 x 2^0` and `1.0 x 2^1`, ties to even, rounds up |
| `9e18` | `0x43df399b1438a100` | short mantissa; the old code got this right too |
| `0x1p1024` | `inf` | beyond the binary64 range; translation-time overflow, as C requires |

## 2. What the old implementation got wrong

Three places, all of them "rounding in the middle":

1. **Decimal, no exponent**: `intp = intp * 10.0 + digit`, fraction
   `fracp = fracp * 10.0 + digit; scale *= 10.0`, finally `intp + fracp / scale`.
   One `double` rounding per digit; past 19 digits it necessarily drifts.
2. **Decimal with an exponent**: went through the host's `strtod` (correct), but there
   is no libc on the board, so under `ARKCC_STM32` that branch degenerated into a
   `pow(10.0, e)` multiply -- two paths gave two answers, and **the board path is the
   one that actually ships**.
3. **Hex**: `fpart = fpart * 16.0 + digit`, `e *= 2.0`, the same step-by-step rounding.

## 3. The new implementation: a fixed-point bignum, rounded once

The idea is to turn the written decimal/hex number into an **exact integer times a
power of two** first, and then round it once into the target format. Everything in
between is integer arithmetic, so no intermediate floating value exists and double
rounding is impossible.

- Buffers: `LitBig` = 72 `unsigned int` = **2304 bits**, five of them (`lit_M` the
  digits, `lit_num` / `lit_den` / `lit_quo` / `lit_rem` for the division).
- Decimal:
  - `E10 >= 0`: `M x 10^E10`, multiplied in 10^9 chunks (`lit_mul_add`).
  - `E10 < 0`: `M / 10^k = (M / 5^k) x 2^-k`. `5^k` is built in 5^13 chunks, then
    divided out with a **binary long division** (`lit_divmod`). The dividend is shifted
    left so the quotient carries 56 bits -- that way the guard and sticky bits the
    final rounding sees mean what they say instead of the quotient being "long enough
    by luck".
  - The result is `quotient x 2^(-t-k)` and `sticky` is "the division had a remainder".
- Hex: `0x1.abcp±e` already is `integer x 2^(e - 4 x fraction digits)`, a pure shift,
  no division needed.
- Rounding: `lit_round(neg, num, e2, sticky, prec)`, nearest, ties to even, done once.
  `prec = 53` is binary64 (`emax 1023 / emin -1022 / granularity 2^-1074`),
  `prec = 24` is binary32 (`127 / -126 / 2^-149`); both share the same code and differ
  only in normalisation and the exponent bias.

### 3.1 Why an `f` suffix also uses prec=24

`float f = 0.1f;` rounded to binary64 first and then to binary32 is **double rounding**:
there are decimal strings where the first rounding lands on the far side of the second
rounding's midpoint, for a 1-ulp difference (the classic witness is
`1.0000000596046447753906251`). The whole class is removed here, and all it costs is
one extra `prec=24` call.

60k random binary32 cases agree with exact rational rounding **bit for bit** (so the
corpora do not contain a witness), but "we did not hit it" is not a guarantee, so the
code rounds once to the target format anyway.

### 3.2 Limits, stated as they are

| Parameter | Value | Consequence |
| --- | --- | --- |
| `LIT_MAXDIG` | 400 significant digits (decimal or hex) | further digits are not multiplied in; only `sticky` and the count are kept |
| exponent accumulator | clamped at 100000 | anything larger is still `inf` / `0`, the classification is unaffected |
| decimal magnitude pre-check | `> 310` gives `inf`, `< -330` gives `0` | good to within one decade; only used to skip pointless 5^k work |

**The only way to be 1 ulp off is to write more than 400 significant digits and have
the truncated tail land exactly on a rounding midpoint.** That is written here rather
than buried in the code: it is the implementation's single approximation, and 400
digits is far past any literal that occurs in real source (2304 bits is about 693
decimal digits, so 400 leaves headroom).

## 4. What it costs on the board

This code ships inside arkc on the STM32H743 (`mdk/STM32H743_ArkCC/ArkCC.uvprojx`
compiles `..\..\src\lexer.c` directly -- the same source as the host, with no feature
macro in between):

| Item | Reading | Why |
| --- | --- | --- |
| `.bss` | **1,464 B** | 5 x 292 B (`LitBig`) + 4 B (`lit_overflow`) |
| `.data` | 0 | no initialiser tables |
| stack | 0 | the five buffers are `static` -- a board app has a 4 KB stack and one `LitBig` is 292 B, five on the stack would blow it |
| libc | not needed | no `strtod`, no `pow`, no `long double` |
| intermediate maths | all integer | a floating type appears only in the final `union` bit-pattern store; `lit_round` returns `double` so the caller gets the value directly |

Measured by building each version once with the same tools:

| Build | Reading | Delta |
| --- | --- | --- |
| host x86-64, `gcc -O2`, `lexer.c` alone | `.text 14,504 -> 18,180`, `.bss 0 -> 1,632` | `+3,676 B` / `+1,632 B` |
| board profile `tools/stm32_build_check.py --layout sdram` (armclang + armlink, real memory layout) | `code 346,042 -> 349,466`, `ro 33,162 -> 33,014`, `zi 84,452 -> 85,916` | **`+3,424 B` code, `-148 B` rodata, `+1,464 B` zi** |

The `zi` delta is exactly 1,464 B -- the five `LitBig`s plus one `int`, to the byte. Flash
occupancy goes 18.1% -> 18.2%, and all eight checks pass in both layouts (`sram` and
`sdram`).

**The 95-TU HAL corpus is byte-identical** (405,426 B; `asm_sw23` before and after are
the same files): the corpus has no long-mantissa literals, so on existing output this
fix costs zero bytes and only spends the few microseconds when such a literal actually
appears.

## 5. The gate

`tests/run_floatlit_tests.py` (`make test-floatlit`, 419 cases, pure compile + assembly
text parsing, no unicorn needed):

- Cases: 39 hand-picked hard ones (22 decimal + 9 hex + 8 binary32: both regressions,
  subnormal boundaries, ties, overflow, very long mantissas, `16777217.0f`,
  `0x1p-149`), plus 220 random decimal, 80 random hex and 80 random binary32 -- 419 in
  total.
- How it judges: it finds the `LDR r0, =.L_dbl_k` the generated function body **actually
  references** and compares that pool entry's two `.word`s. So a wrong pool index or a
  body that loaded some other constant is red.
- Three anti-false-green self checks:
  1. the table must first disagree with **the old accumulator** (the script carries a
     copy, `naive_decimal`) on at least one case -- otherwise the table does not even
     catch the bug it exists for;
  2. the independent binary32 reference (`Fraction` exact rounding) must first
     reproduce four known bit patterns;
  3. every function must end up with a pool reference; a pool that quietly became empty
     is red, not "nothing to compare".
- Negative literals: the lexer only ever sees the digits, the sign is applied at run
  time (`EOR r0, r0, #0x80000000`). The gate therefore checks two things for `-x`: the
  pool holds the correct bit pattern of the **magnitude**, and the body really does
  contain that sign fix-up.

### 5.1 Independent cross-check

The same implementation compiled as a standalone host program (`litref`), compared
against Python's correctly rounded `float()` / `float.fromhex()` / `Fraction`:

| Batch | Cases | Mismatches |
| --- | --- | --- |
| binary64 random decimal (signs, `e`/`E`, exponents ±345, 1..25 digits) | 59,236 | **0** |
| binary64 random hex (signs, `p` exponents -1090..1050) | 60,000 | **0** |
| binary32 random decimal (`Fraction` exact rounding as reference) | 59,313 | **0** |
| total (seed 7) | **178,549** | **0** |
| total (seed 8) | 178,552 | **0** |

(60,000 per batch were generated; a handful of very short literals fall below the host
probe's line filter and are not compared, so the table lists the counts that were
actually compared.)

Boundary probes (`.5`, `5.`, `00012.5`, `-0.0`, `0e999999999`, `1e±1000000`,
`0x1p-1074`, `0x3p-1075`, `0x1p1024`, `0x1.fffffffffffffp1023`) are all correct:
overflow gives `inf`, underflow rounds to `0` or the smallest subnormal, and the sign
bit of `-0` is kept.

## 6. Reproducing

```sh
make test-floatlit                      # 419 bit-for-bit comparisons
./arkcc -S -target arm -o t.s t.c       # inspect .L_dbl_* / .L_flt_* .word lines
```

```c
double a(void) { return 123456789012345678.0; }          /* low word 0xba630f35 */
double b(void) { return 0x1.0000000000000800000001p0; }   /* 0x3ff0000000000001 */
```

## 7. Related files

- `src/lexer.c` -- the `lit_*` primitives, `lit_round`, `lit_from_decimal`,
  `lit_from_hex`, and the two call sites (hex and decimal branches; after the suffix
  loop the value is recomputed at prec=24 when an `f` suffix was seen)
- `tests/run_floatlit_tests.py`, `Makefile` (`test-floatlit`, hooked into the `test:`
  aggregate)
- `docs/BOARD_VALIDATION.en.md` section 8 item 2 (this debt is now closed)
