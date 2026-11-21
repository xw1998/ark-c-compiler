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
   - tail merge: 289/278/244 lines
   - block merge: 168/159/137 lines
4. **Refusals**: `=10`, `=abc`, `=`, no value, `=-1`, `=5x` all exit 1 with
   `C3900U` and **write no object**; a cropped build refuses with
   `not compiled into` and prints no threshold line at all.
5. **Ini**: `size_weight=9` and `size-weight=9` both reach the table; an
   out-of-range 42 warns, keeps 5 and exits 0.
6. **Semantics**: `tail.c` / `xblock.c` / `unroll6.c` / `inline_mid_rt.c` return
   the same value at 0/5/9; the corpus shrinks 4544 → 3094 object bytes from the
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

## 6. Known debt: functions with parameters are never inlined

This is an existing defect; P6 does **not** fix it, because fixing it changes the
default `-O2` output (a separate decision). It is recorded here because anyone
reading `-O` output will otherwise misread it:

- `src/irgen.c` writes `aux = (size << 8) | slot` for `IR_GETARG`, **including
  scalars** (an `int` parameter gets `1 << 8`).
- `count_insts_and_check_recursion()` in `src/opt.c` treats `(aux >> 8) != 0` as
  "has a struct-by-value parameter", so **every function with a parameter is
  considered un-inlinable**.

Minimal reproduction (`arkcc -target arm -O2 -S`):

```c
int v;
static int g(int x) { int y = x + v; return y; }   /* byval=1 => no inlining */
int main(void) { return (g(1) + g(2)) & 0x7F; }    /* the output still has 2 BL g */
```

Drop the parameter (`static int g(void)`) and it inlines. `forceinline` does not
help either: it only bypasses the size rule, not the `has_struct_byval`
`continue`.

**Consequence for P6**: the inline dimension of the weight can only be observed on
**parameterless** callees, so the inline fixtures are parameterless
(`inline_small.c` / `inline_mid.c`) and the script says why. This is not evidence
that inlining is broken — instrumentation shows `can_inline=1` and
`inline h -> main` firing.

One related measurement trap: inlining is **single pass**. With a startup file
attached, the copy of `main` that was inlined into `Reset_Handler` still carries
its un-expanded `BL h`, so counting `BL h` over the whole file yields 2 and looks
like "not inlined". Count sites inside one specific function body, or use a
fixture with no second entry point.

## 7. Board

`mdk/STM32H743_ArkCC` is rebuilt with UV4 (`UV4 -b ArkCC.uvprojx -j0`) and gives
`Code=182828 RO-data=23740 RW-data=3431972 ZI-data=37144` — **identical** to the
P4 (`--xblock`) baseline, `0 Error(s)`.

That identity was earned, not accidental: the first version wrote the `#else`
branch as four functions returning the constants, and the board `Code` grew by
8 B at once (182828 -> 182836) — nobody calls them in a cropped build, but they
are global symbols and the linker does not drop those for you. With macros it
is 182828 again. So "switched off equals 0.9.0" is provable by size on the
board, not just by "it does not seem to run".
