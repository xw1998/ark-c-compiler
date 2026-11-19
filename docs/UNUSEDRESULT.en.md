# Discarded return value (`--warn-unused-result`)

English | [中文](UNUSEDRESULT.md)

`__attribute__((warn_unused_result))` is one of the few things in C that can put
"there is a defect here" into a declaration. arkc has **accepted** the attribute
since 0.6.x and then dropped it into the same "silently ignored" bucket as
`may_alias` and `nothrow` — which is worse than not supporting it at all: the
declaration reads as if a check were active while nothing happens.

Since 0.8.6 it means what it says. The switch is `--warn-unused-result` and it
is **off** by default.

## 1. The rule

An expression statement whose **entire** expression is a call to an annotated
function is reported:

```c
extern int __attribute__((warn_unused_result)) f(void);

void g(void)
{
    f();            /* warning: f's value is thrown away */
    (void)f();      /* silent: explicit discard */
    int x = f();    /* silent: value used */
    if (f()) {}     /* silent: value used */
    h(f());         /* silent: value used */
}
```

A `(void)` cast is the documented GNU/clang way to say "I really do not want
this value", so it is the one explicit-discard channel.

### Spellings

All three spellings of the same attribute are recognised:

| Spelling | Where it comes from |
| --- | --- |
| `__attribute__((warn_unused_result))` | GCC / armcc 5 |
| `__attribute__((__warn_unused_result__))` | glibc headers |
| `__attribute__((__must_check__))` | how the Linux kernel's `__must_check` macro expands |

Note: a bare `__must_check` (without `__attribute__`) is **not** a language
keyword and arkc does not accept it — it is a kernel macro
`#define __must_check __attribute__((warn_unused_result))`, and the source file
has to bring that macro itself.

### The attribute sticks by name

The attribute is recorded per function name, so "declared in a header, defined
somewhere else" is the same function:

```c
extern int f(void) __attribute__((warn_unused_result));   /* annotated */
int f(void) { return 1; }                                /* not annotated */
void g(void) { f(); }                                    /* still warns */
```

## 2. What it deliberately does not do

| Shape | Behaviour | Why |
| --- | --- | --- |
| call through a function pointer, `p();` | silent | no declaration to read; the attribute is on no declaration |
| annotated function returning `void` | silent | there is no value to lose; the attribute is a no-op |
| call anywhere inside a larger expression | silent | the value is used — this is a statement-shape check, not data flow |
| more than 256 annotated functions | one warning that the check is incomplete | a truncated table would silently stop checking, which is worse |
| merged with `--warn-mem`'s double-free rule | no | the evidence is different (a declaration vs. the shape of a call) |

## 3. Trimming

```c
/* include/arkcc_config.h */
#ifndef ARKCC_FEATURE_UNUSEDRESULT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_UNUSEDRESULT 0   /* trim on the board: costs Flash */
# else
#   define ARKCC_FEATURE_UNUSEDRESULT 1
# endif
#endif
```

The whole pass is one self-contained source file (`src/unusedresult.c`): no heap,
no dynamic allocation, one 256-entry pointer table on the stack. In a build
without the feature:

- the command line `--warn-unused-result` is refused with `C3900U` plus the
  rebuild hint;
- the config key `warn_unused_result = 1` is refused the same way;
- `--no-warn-unused-result` is always accepted (asking for "no check" does not
  need the pass to exist).

**Off by default ⇒ the output is byte-identical to v0.8.5** (80 `examples/`
sources x 3 `-O` levels x 2 targets = 480 comparisons, `diffs=0`).

## 4. Relation to the pipeline

It is one AST stage row in `src/pipeline.c`:

```
  skip  ast.unusedresult  off (--warn-unused-result)
```

`--print-pipeline` prints it together with the other stages. It is a `lite`
stage (a cheap check like `ast.memlint` / `ast.enumcheck`, no `-O` gate), so
`--pipeline=lite` does not turn it off — `--warn-unused-result` is the only
switch that does.

## 5. Gate

`tests/run_unusedresult_tests.py` (`make test-unusedresult`), 19 assertions:

1. five positives hit the exact line, the text names the callee;
2. the legal twin of every reported shape (`(void)` cast / assignment /
   condition / operand / function pointer / void return / not annotated) is
   silent over a whole file;
3. a negative file (function-pointer call only) is silent;
4. the switch is three-in-one: silent without it, silent with
   `--warn-unused-result --no-warn-unused-result`, on again in the reverse order;
5. a build made with `-DARKCC_FEATURE_UNUSEDRESULT=0` refuses both the command
   line and the INI key.

## 6. Known limits

- Statement shape only, no data flow: `int x = f(); (void)x;` does not warn
  (the value *was* used). That is out of scope by design.
- No cross-translation-unit analysis: the attribute must appear on a declaration
  this TU can see. Prototypes from system headers arrive through the
  preprocessor, so they work as usual.
- The report is anchored on the call's line; when the call node carries no
  column the caret falls back to the line.
- Not compatible with armcc's `--diag_suppress`: this diagnostic carries no
  armcc code (no armcc wording for it was ever measured), so it can only be
  switched as a class, not suppressed by number.
