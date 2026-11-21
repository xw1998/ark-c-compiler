# `--size-weight`: one continuous size/speed weight (0.9.1)

`--size-weight=N` uses a single integer 0..9 to move the **thresholds** of four
existing optimisation passes at once. The default is 5, and the four thresholds
at 5 are equal to the 0.9.0 compile-time constants one by one — that is the
whole basis for "a build that never writes this option is byte-identical to
0.9.0".

```text
--size-weight=N      0 = favour speed (loosest limits: more inlining/unrolling)
                     5 = default, equal to the 0.9.0 constants (12 / 8 / 3 / 4)
                     9 = favour size (less inlining/unrolling, easier merging)
```

`-v` prints the resolved thresholds; that line is the only input the gate reads:

```text
  size_weight=5 inline<=12 unroll<=8 tailmerge>=3 xblock>=4
```

## 1. The four tables

| weight | 0 | 1 | 2 | 3 | 4 | **5** | 6 | 7 | 8 | 9 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| inline limit (IR insts ≤) | 28 | 24 | 20 | 17 | 14 | **12** | 10 | 8 | 6 | 4 |
| unroll limit (trips ≤) | 16 | 14 | 12 | 10 | 9 | **8** | 7 | 6 | 5 | 4 |
| tail-merge minimum length (≥) | 6 | 6 | 5 | 5 | 4 | **3** | 3 | 2 | 2 | 2 |
| block-merge minimum length (≥) | 7 | 7 | 6 | 6 | 5 | **4** | 4 | 3 | 3 | 3 |

Read it as: **towards 9 means "favour size"**. The inline/unroll ceilings go down
(less work), while the tail-merge and block-merge **minimum lengths** go down too
(more merging, and merging is what saves size). The word "threshold" therefore
means opposite directions in the two halves of the table; trust the table over a
rule of thumb.

The tables live at the end of `src/config.c`, and four accessors are the only
read points:

| read point | file | meaning |
| --- | --- | --- |
| `ark_inline_threshold()` | `src/opt.c` | inline when `cnt <= limit` (`forceinline` bypasses the size rule) |
| `ark_unroll_max()` | `src/opt_loop.c` | unroll when trips `<= limit` (body cap stays 64) |
| `ark_tailmerge_min_len()` | `src/opt_tailmerge.c` | merge a tail when its length `>= limit` |
| `ark_xblock_min_len()` | `src/opt_tailmerge.c` | merge a block when its length `>= limit` |

**The four old macros are gone** (`ARK_INLINE_THRESHOLD` / `ARK_UNROLL_MAX` /
`ARK_TAILMERGE_MIN_LEN` / `ARK_XBLOCK_MIN_LEN`). Keeping them would leave a knob
that changes nothing; "report an error rather than a wrong answer" requires one
source of truth per value.

## 2. Why there is no `-Oz` / `-Os` / `-Ot`

The first draft followed IAR's `-s0..9` / `-z0..9` with three named levels. On
arkc that is misleading: `-O0/-O1/-O2` decides **which passes run**, while these
four limits only tune **the trade-off inside** one pass. A new `-Oz` would invite
the reasonable assumption that it also changes the `-O` level (say, drops LICM) —
it would not. So there is exactly one numeric weight, orthogonal to `-O`, and
this document states that relationship. **Different from the draft; changed.**

## 3. Three layers of cropping

| layer | mechanism | when off |
| --- | --- | --- |
| compile time | `ARKCC_FEATURE_SIZEWEIGHT` (**derived** from the four pass macros) | the option is refused with `C3900U`, and `-v` does not print the line at all |
| run time | `--size-weight=N` / ini `size_weight=` | default 5, byte-identical to not writing it |
| profile | each pass keeps its own stage row (`ir.inline`, …) | a skipped pass never reads a threshold |

The derived macro in `include/arkcc_config.h`:

```c
#ifdef ARKCC_FEATURE_SIZEWEIGHT
/* derived switch; a direct -D would leave the accessors undefined */
# undef ARKCC_FEATURE_SIZEWEIGHT
#endif
#if ARKCC_FEATURE_OPT_INLINE || ARKCC_FEATURE_UNROLL || \
    ARKCC_FEATURE_TAILMERGE || ARKCC_FEATURE_XBLOCK
#  define ARKCC_FEATURE_SIZEWEIGHT   1
#else
#  define ARKCC_FEATURE_SIZEWEIGHT   0
#endif
```

Both details were learned the hard way:

- **Cropping only this macro (`-DARKCC_FEATURE_SIZEWEIGHT=0`) does not link.** The
  four passes' code is not cropped by their own flags (they are only left out of
  the stage table), so `src/opt.c` still calls `ark_inline_threshold()` in a
  cropped build. The first gate run took exactly that `ld returned 1 exit status`
  as a SKIP.
- So the `#else` branch must still resolve those four calls. It uses **macros**
  returning the historical constants (`# define ark_inline_threshold() 12`, …)
  rather than functions: a function is a symbol, and the linker keeps it in a
  cropped build (measured on the board: +8 B of Code, see §7), while a macro
  leaves nothing behind. A cropped build refuses `--size-weight` and behaves
  like 0.9.0.

Board builds (`STM32_MIN`) and builds without any MIR optimisation pass land on
the `#else` side: these four limits only belong to host-side optimisation, and
keeping the switch there would be a knob that "turns on but never moves".

## 4. The gate

`tests/run_sizeweight_tests.py`, 31 checks, `make test-sizeweight`:

1. **Tables**: all ten weights readable; `5 == (12,8,3,4)`; each table monotone;
   both ends really leave the middle (not a flat table).
2. **Default**: no flag resolves to the same table as `=5`; six fixture objects
   are byte-identical with no flag and with `=5`; same for `hello.c`.
3. **Every threshold reaches real code** (`-S` text plus equal values through the
   ARM executor):
   - inline `BL h` counts: small fixture 0/0/2, mid fixture 0/2/2 (at 0/5/9)
   - unroll: a 12-trip loop 467/135/135 lines; a 6-trip loop 275/275/135
   - tail merge: 313/302/244 lines
   - block merge: 353/159/137 lines
4. **Refusals**: `=10`, `=abc`, `=`, no value, `=-1`, `=5x` all exit 1 with
   `C3900U` and **write no object**; a cropped build refuses with
   `not compiled into` and prints no threshold line at all.
5. **Ini**: `size_weight=9` and `size-weight=9` both reach the table; an
   out-of-range 42 warns, keeps 5 and exits 0.
6. **Semantics**: `tail.c` / `xblock.c` / `unroll6.c` / `inline_mid_rt.c` return
   the same value at 0/5/9; the corpus shrinks 5040 → 3094 object bytes from the
   speed end to the size end.

Two anti-false-green guards: the gate first proves the table does not collapse to
a flat one (last check of item 1), and that a cropped build has no `-v` line at
all (otherwise item 4 could just be reading a default).

## 5. Measurements

- **Account**: all 80 files of `examples/*.c`, compiled with HEAD (0.9.0 +
  P1/P2/P3/P4) and with the P6 tree (`-target arm -S -O2 --tailmerge --xblock
  --unroll --licm --divconst`): **0 differences**.
- **Table**: `-v` gives `28/16/6/7` at `=0`, `4/4/2/3` at `=9`, `12/8/3/4` by
  default.
- **Board**: see §7 (UV4 rebuild of `mdk/STM32H743_ArkCC`, Program Size account).

## 6. Functions with parameters inline (fixed in 0.9.1-wip)

This section used to be the debt: `src/irgen.c` writes `aux = (size << 8) | slot` for
`IR_GETARG` (**scalars included**), and `count_insts_and_check_recursion()` in `src/opt.c`
read `(aux >> 8) != 0` as "has a struct-by-value parameter", so **every function with a
parameter was considered un-inlinable** -- `forceinline` included. It was left alone because
fixing it changes the default `-O2` output.

The decision now comes from the parameter *types*:

- `irgen_param_slots(Type *)` (`include/irgen.h` / `src/irgen.c`) uses the same rule irgen
  lays the arguments out with (`irgen_param_words()`): a composite above 8 bytes or a 16-byte
  `_Complex` travels by address => `-1`; a 5..8-byte composite, `long long` or `double` => two
  words; everything else one word. The C backend (8-byte slots) and x86-64 (a pointer is one
  word) always answer `-1`.
- `inline_param_words()` in `src/opt.c` sums that per parameter; `-1` or `> 4` means no
  expansion. The expansion stores the arguments **grouped per parameter and in reverse word
  order** (the IR stack keeps a parameter's high word on top), and `IR_GETARG` copies one or
  two words by `aux >> 8 > 4`. `IR_CALL.val` is the *argument count*, not the word count: a
  site whose count disagrees with `param_count` keeps its call.

| shape | result |
| --- | --- |
| one-word parameter (`int`, pointer) | inlined |
| two-word parameter (`long long`, `double`, 5..8-byte composite) | inlined (word offsets accumulate per parameter) |
| `__forceinline` with parameters, body above the limit | inlined (the size bypass is unchanged) |
| composite above 8 bytes (carried by address) | call kept |
| five or more parameters, recursion, `...` | call kept |
| `-target c` (8-byte slots), `-target x86_64` (pointer in one word) | call kept |

Gate: `tests/run_inline_tests.py` (`make test-inline`, 25 checks). At `-O2`
`static int add1(int)` has no `BL add1` while `--no_autoinline` keeps both calls (so "the pass
did not run" cannot pass as "inlined"); the same fixture at `--size-weight=9` (inline<=4) is a
call again; a `__forceinline` body with parameters above the size limit inlines while the
identical body without the attribute does not; a two-word parameter followed by a one-word
parameter and a 5-byte struct whose *second* word is read both land correctly (the `long long`
fixture returns 7 and the struct fixture 9 on the emulator, in both arms); the four refused
shapes and the two refused targets keep their calls; nine fixtures return the same value in all
three arms (default / `--no_autoinline` / `--size-weight=9`); and a build cropped with
`-DARKCC_FEATURE_OPT_INLINE=0` refuses `--autoinline` with `C3900U` while still compiling the
same file to plain calls when the flag is absent.

Three things worth remembering: (1) P6's "all 80 files of `examples/*.c`, 0 differences" holds
for that round only -- inlining a parameterised callee changes the default `-O2` output from
0.9.1-wip on; (2) the `--tailcall` gate now always passes `--no_autoinline`, because its
fixtures are exactly the parameterised-small-callee shape and `B leaf` would be inlined away
before the rewrite could happen; (3) the `--xblock` gate needs it for the same reason -- the
full `make test` caught exactly that: its fixture calls `g()` twice from `two()` and twice from
`three()`, inlining erases the duplicate blocks, all seven checks failed at once, and with
`--no_autoinline` they return (object 865 -> 763 bytes).

One related measurement trap stays: inlining is **single pass**. With a startup file attached,
the copy of `main` inlined into `Reset_Handler` still carries its un-expanded `BL h`, so
counting `BL h` over the whole file yields 2 and looks like "not inlined". Count sites inside
one specific function body, or use a fixture with no second entry point.

## 7. Board

`mdk/STM32H743_ArkCC` is rebuilt with UV4 (`UV4 -r ArkCC.uvprojx -j0`), `0 Error(s)`:

| build | Code | RO-data | RW-data | ZI-data |
| --- | --- | --- | --- | --- |
| P4 baseline (`--xblock`) | 182828 | 23740 | 3431972 | 37144 |
| `--size-weight` only (`ae3dd8c`, built in a separate worktree) | **182828** | 23740 | 3431972 | 37144 |
| plus the parameterised-inline fix (this work tree) | 183064 | 23740 | 3431972 | 37144 |

**Rows one and two are byte-identical, and that identity was earned.** The first
version wrote the `#else` branch as four functions returning the constants and
the board `Code` grew by 8 B at once (182828 -> 182836) — nobody calls them in a
cropped build, but they are global symbols and the linker does not drop those for
you. As **macros** in `#else` it is 182828 again. So "switched off equals 0.9.0"
is provable by size on the board, not just by "it does not seem to run".

**The +236 bytes in row three all come from the parameterised-inline fix**
(section 6) and none from the weight: under `STM32_MIN` the four passes are
already 0 (`ARKCC_FEATURE_OPT_INLINE/UNROLL/TAILMERGE/XBLOCK` all cropped), so
the weight tables, the `-v` line and the usage text never reach the board. But
the expansion code in `src/opt.c` and `irgen_param_slots()` in `src/irgen.c` are
**not** cropped by those flags (the passes are only left out of the stage
table), so a cropped build still links them. Making those 236 bytes disappear
as well means wrapping the body of `opt_inline()` in
`#if ARKCC_FEATURE_OPT_INLINE` — a separate decision, recorded as debt and not
done in this round: first make the fix fully usable on the host, then talk about
0.13% of board Flash.
