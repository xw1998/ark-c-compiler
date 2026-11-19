# `--warn-enum`: a `switch` that misses an enumerator

[中文](ENUMCHECK.md) | English

`--warn-enum` is one pass over the AST after semantic analysis. It does exactly one thing:
**when a `switch` controls on an enum type, has no `default:` label, and its `case` labels do
not cover every enumerator of that enum, report a warning.**

```c
enum Color { RED, GREEN, BLUE };

void f(enum Color c)
{
    switch (c) {
    case RED:   break;
    case BLUE:  break;
    }                 /* -> warning: missing GREEN */
}
```

The boundary first: **this is a lint, not a guarantee that the switch handles every value.**
In C an enum-typed variable may legally hold a value no enumerator names (an `int` converted to
the enum type), and it will still take `default` (or do nothing when there is none). This pass
answers a smaller question that *is* decidable: **is every enumerator the source itself
declared named here?**

## 1. The criteria

All four must hold; otherwise the pass stays silent:

| Condition | Note |
| --- | --- |
| the controlling expression has enum type | `switch` on a plain `int` over enum constants is **not** checked — the type is what says "this value comes from that set" |
| the enum **definition** is visible in this translation unit | a tag that only appears in a declaration has no enumerator list |
| the switch has no `default:` label | `default` is C's spelling of "everything else"; writing it is a decision |
| enumerators and `case` labels fit the tables | `EC_MAX_ENUM` = 64, `EC_MAX_CASES` = 64 |

**Values, not names**: `case 0:` and `case RED:` cover the same enumerator, and two enumerators
with the same value (`enum E { A = 1, B = 1 };`) are covered together — matching the runtime
`switch`.

**Nested switches are judged independently**: collecting `case` labels stops at an inner
`switch`, otherwise the inner labels would falsely complete the outer set.

**Over the table means silence**: a set too large to hold is skipped entirely; a truncated
comparison could claim a value is missing when it is merely beyond the table, which is the one
kind of wrong answer this project refuses to give.

## 2. The diagnostic

```
line 6: Warning: switch on enum 'Color' does not handle every enumerator (missing: GREEN); add a case label or a default label
line 27: Warning: switch on an anonymous enum does not handle every enumerator (missing: B2); add a case label or a default label
```

Missing values are listed in declaration order, at most 4, then `, ...` — the *judgement* is
never truncated, only the display. Line and column point at the `switch` keyword.

## 3. Switches and trimming

Three layers, all off by default; with them off there is no code and no behaviour change:

| Layer | Name | Default | Effect |
| --- | --- | --- | --- |
| compile time | `ARKCC_FEATURE_ENUMCHECK` | host `1`, `ARKCC_PROFILE_STM32_MIN` `0` | at `0` the pass is not compiled in and costs no flash |
| run time | `--warn-enum` / `--no-warn-enum` | off | the last one on the command line wins |
| config file | `[features]` `warn_enum=1` | off | same as the command line; the command line wins |

**Where the pass is compiled out, both entry points refuse instead of pretending the check ran:**

```
Fatal error: C3900U: --warn-enum is not compiled into this build (rebuild with -DARKCC_FEATURE_ENUMCHECK=1)
```

`--no-warn-enum` is accepted by every build (it only asks for the default).

## 4. Measured cost

| Metric | Reading | Basis |
| --- | --- | --- |
| code size | `-O2`: `+1,852 B` text; `-Os`: `+1,548 B` text | host x86-64 gcc, same sources, only `-DARKCC_FEATURE_ENUMCHECK=0/1` toggled, `size` `text` column; **not** Cortex-M7 bytes — the Thumb-2 ratio differs, the order of magnitude does not |
| data / bss | `0` | no global table; two small stack arrays (`EcCases` / `EcNames`) per switch |
| default object code | **byte-identical** | with `--warn-enum` off the call in `compiler.c` never runs |
| what it needs | `Type.enumerators` | `parser.c` records it in `parse_enum` and `type_enum_definition()` looks it up by tag — every `enum E x;` builds a fresh `Type`, so identity has to go through the tag |

## 5. What the gate checks

`tests/run_enumcheck_tests.py` (`make test-enumcheck`, part of `make test`), 19 assertions:

| Group | Assertions |
| --- | --- |
| positive | each of the 5 shapes is reported once, on the right line, with the right text, **and the total is exactly 5**: one missing value / two missing / anonymous enum / nested (only the outer is reported) / a `switch` inside a loop |
| legal twins | full coverage, a `default:` label, switching on an `int`, enumerators sharing a value, numeric `case 0:` labels, a file with no `switch` at all — the whole file silent |
| negative | a tag that is only declared, and 70 enumerators (over the table) — whole file silent |
| switches | the same defect file is silent without `--warn-enum`; `--warn-enum --no-warn-enum` is silent; the reverse turns it back on |
| trimming | an `-DARKCC_FEATURE_ENUMCHECK=0` build refuses both the command line and the config file with `rc!=0` + `C3900U`, while the same sources compile normally and silently |

The cases contain no `#include` (after preprocessing the diagnostic line numbers are buffer
lines, the established convention in this repo) and anchor expected lines with `ANCHOR:`
comments instead of hard numbers, so editing a case does not require editing expectations.

## 6. Known limits

- Only `switch` on an enum **type**; a `typedef` of an enum still classifies as an enum (the
  type is unchanged), but `switch ((int)c)` is not checked.
- Enumerator lists defined outside this translation unit are not checked.
- More than 64 enumerators or 64 `case` labels: the switch is skipped entirely.
- Non-constant `case` expressions (a GNU extension) are unsupported; `case` values come from
  the parser's `eval_const_expr` via `AST_CASE`.
- Duplicate or out-of-range enumerator values are a different question and are not checked.

## 7. Why it deserves its own switch

Rust's `match` exhaustiveness is a **language guarantee**; C's `switch` has none, and no
compiler is obliged to hint. But "added an enumerator, forgot one `switch`" is one of the most
common silent defects in embedded code, and it appears **only on the day the enumerator is
added** — the right way to use this check is to turn it on while adding enumerators, not to
leave it on. Hence default off, trimmable, and reachable from the INI file, the same shape as
`--warn-mem`.
