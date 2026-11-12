# The diagnostics layer

[中文](DIAGNOSTICS.md) | English

One of arkc's goals is to be **byte-for-byte identical to armcc 5.06 in its diagnostic output**: for
the same source and the same options, what the user sees should diff cleanly against armcc's output.
This document explains how the diagnostics layer is organised, why it is organised that way, and where
to change things when a new diagnostic is added.

There is exactly one acceptance criterion: **the output of a real armcc can be compared byte for
byte**. Everything that cannot be compared that way, or that can only be made to "look similar", is
listed explicitly in §7 — no hedging with "roughly the same".

---

## 1. Layering: a diagnostic goes through four steps

```
stage code              diag.c                                     output
--------                ------                                     ----
diag_report(...)   ->   admit (suppression / limit policy)     ->  dropped if it does not pass
                        expand (template + argument array)     ->  the message body
                        emit_diag (layout of position/severity/code per style) -> one whole line
                        out_* (stderr or the --errors file)    ->  bytes on the wire
```

The key constraint: **stage code only describes "what is wrong"** (code, severity, location,
arguments); **all layout lives in `src/diag.c`**. So when the armcc layout changes, or
`--diag_style` gains a variant, exactly one file changes and nobody has to revisit format strings
scattered across two dozen source files.

Internally `report()` takes an **argument array plus a count**
(`const char *const *args, int nargs`) rather than three loose pointers. The public entry points keep
the fixed signature of at most three arguments (that is armcc's own limit); only `diag_tool()` allows
six, because the linker's "SRAM overlap between objects #0 and #1 …" message has to print four
addresses.

| File | Responsibility |
| --- | --- |
| `include/diag.h` | the public interface. Stage code includes only this header. |
| `src/diag.c` | policy, layout, source echo and caret, the summary line, output targets. |
| `tools/gen_diag_table.py` | extracts the code table from the reverse-engineered armcc artefacts and generates the next two files. |
| `include/diag_msg_table.h` | **generated**: `diag_msg_lookup()` and friends. |
| `src/diag_msg_table.c` | **generated**: the two code → template tables. |
| `tests/run_diag_tests.py` | gate: byte-for-byte comparison against a real armcc. |
| `tests/run_diag_boundary.py` | gate: the boundary contracts that byte comparison cannot reach (long lines, limits, CJK, tabs). |

Do not hand-edit the generated files: edit the curated list inside `tools/gen_diag_table.py` and
re-run the generator.

---

## 2. Public interface

```c
void diag_init(const char *main_file, const char *source_text);
void diag_set_source(const char *source_text);   /* the post-preprocessed text changed */
void diag_set_main_file(const char *main_file);  /* changes only "the file the user can act on" */
void diag_shutdown(void);
void diag_summary(void);

/* has an armcc code: look up the template */
void diag_report(int code, DiagSeverity sev, const DiagLoc *loc,
                 const char *a0, const char *a1, const char *a2);

/* same code, but anchored at "end of translation unit" (see §4, At end of source) */
void diag_report_at_eof(int code, DiagSeverity sev, const DiagLoc *loc);

/* no matching armcc code: borrow the layout, never invent a code */
void diag_report_msg(DiagSeverity sev, const DiagLoc *loc, const char *msg,
                     const char *a0, const char *a1, const char *a2);

/* driver-level codes (C####U / C####E / ...), severity inferred from the trailing letter */
void diag_driver(const char *code, const char *a0, const char *a1);

/* command-line diagnostics, with one extra "command-line:" segment */
void diag_command_line(int code, DiagSeverity sev,
                       const char *a0, const char *a1, const char *a2);

/* tool-stage (linker / scatter / ld script) diagnostics: the anchor is the output image, not a source line */
void diag_tool(DiagSeverity sev, const char *object, const char *msg,
               const char *a0, ... const char *a5);   /* six argument slots */

const char *diag_num(char *buf, int v);              /* number → stable string */
```

Five design decisions:

1. **Severity is inferred from the trailing letter of the code** (`diag_driver`). The code table is the
   single source of truth, so no call site can report `C3900U` as a warning.
2. **No code unless there is a code** (`DIAG_NO_CODE`). Any message whose code has not been measured
   from a real armcc goes through `diag_report_msg` and only shares the layout. Better to omit one
   `#N` than to guess one. The linker messages are exactly this case: we have **never measured**
   armlink's `L####` codes, so `diag_tool()` never carries a code and only keeps the
   `<object>: Error: <text>` shape.
3. **`DiagLoc.file` set to `DIAG_NO_SOURCE_TEXT`** (`"no source"`) means "this diagnostic is about the
   whole translation unit". The layout layer recognises that literal and does not substitute the main
   file name.
4. **`diag_set_main_file()` is separate from `diag_init()`.** In link mode "the file the user can act
   on" is the output image rather than a source file, but `diag_init()` cannot be called again at that
   point — it would clear the diagnostic counters already accumulated. Renaming without touching
   counters is the entire reason this function exists.
5. **The `-D` suffix follows the intrinsic category; the word follows the policy.** Measured:
   `--diag_error=177` prints `Error:  #177-D` (the `-D` stays), while `--diag_warning=101` has no
   observable effect on an error. So `code_to_str(code, intrinsic_sev, out)` uses "intrinsically a
   warning, or `d_tag` in the table" to decide the `-D`, while `override_severity()` (the
   `--diag_error` table) only decides which word is used.

---

## 3. The code table: extracted by reference, not the whole table

The armcc front end has 2428 message slots and the driver has another 316 `C####` codes. arkc uses a
small handful, so the table is **extracted by reference**:

- `tools/gen_diag_table.py` holds two curated lists: `FRONTEND_CODES`, `DRIVER_CODES`;
- only codes that arkc actually calls **and** that have been measured against a real armcc enter the
  table (currently 37 + 7);
- the board firmware is not blown up by 2428 strings;
- adding a diagnostic = adding one code to the list + re-running the generator.

```bash
python tools/gen_diag_table.py            # regenerate (source directory defaults to the reverse-engineered artefacts)
python tools/gen_diag_table.py --check    # CI: are the generated files consistent with the list?
python tools/gen_diag_table.py --source DIR
```

The 37 front-end codes currently in the table (`src/diag_msg_table.c` is the single source of truth;
the `-D` column marks codes where armcc appends `-D`, and measurement shows `--diag_error` changes the
word but not the suffix):

| Code | -D | Message |
| --- | --- | --- |
| 4 | | `out of memory` |
| 5 | | `cannot open %s input file %sq2: %s3` |
| 6 | | `comment unclosed at end of file` |
| 7 | | `unrecognized token` |
| 8 | | `missing closing quote` |
| 9 | | `nested comment is not allowed` |
| 11 | ✓ | `unrecognized preprocessing directive` |
| 12 | | `parsing restarts here after previous syntax error` |
| 13 | | `expected a file name` |
| 17 | | `expected a "]"` |
| 18 | | `expected a ")"` |
| 20 | | `identifier %sq is undefined` |
| 28 | | `expression must have a constant value` |
| 29 | | `expected an expression` |
| 35 | | `#error directive: %s` |
| 36 | | `the #if for this directive is missing` |
| 37 | | `the #endif for this directive is missing` |
| 38 | | `directive is not allowed -- an #else has already appeared` |
| 39 | | `division by zero` |
| 40 | | `expected an identifier` |
| 65 | | `expected a ";"` |
| 67 | | `expected a "}"` |
| 100 | | `duplicate parameter name` |
| 101 | | `%sq has already been declared in the current scope` |
| 117 | | `non-void %n should return a value` |
| 118 | | `a void function may not return a value` |
| 137 | | `expression must be a modifiable lvalue` |
| 140 | | `too many arguments in function call` |
| 148 | | `%n has already been initialized` |
| 165 | | `too few arguments in function call` |
| 174 | ✓ | `expression has no effect` |
| 177 | ✓ | `%n was declared but never referenced` |
| 179 | | `right operand of "%%" is zero` |
| 223 | ✓ | `function %sq declared implicitly` |
| 247 | | `%n has already been defined` |
| 992 | | `invalid macro definition: %s` |
| 1215 | ✓ | `#warning directive: %s` |

Seven driver codes (severity comes from the trailing letter: `U` = usage/fatal, and `E`/`W`/`I` as in
armcc):

| Code | Message |
| --- | --- |
| `C3900U` | `Unrecognized option '%s%s'.` |
| `C3901U` | `Missing argument for option '%s'.` |
| `C3903U` | `Argument '%s' not permitted for option '%s'.` |
| `C4056E` | `bad option '%s'` |
| `C4065E` | `type of input file '%s' unknown` |
| `C4079E` | `%s command with no effect` |
| `C4486W` | `option '-%c' causes input file '%s' to be ignored` |

The six codes added to the table in this round (17 / 18 / 67 / 137 / 140 / 165) plus `C3901U` were all
measured against a real armcc first: `#137` is what both `(a+1) = 2` and `(a+1) += 2` produce;
`#140`/`#165` dispatch on too many / too few arguments; `#67` appears only for a missing `}` at end of
file and uses the At end of source form of §5.3.

The expected output of `gen_diag_table.py --check`:

```
up to date (37 frontend, 7 driver)
```

Placeholder rules (`check_placeholders()`): only `%s %sq %n %c %d %u %%` plus the numbered forms
`%sq2 %s3` (1-based indices, required by three-argument messages such as `#5`) are accepted, and only
when arkc can render them correctly. Anything like `%t1` or `%nfd` ("print a type name") is a **hard
failure** and produces no table at all — a half-correct table would look usable and print the wrong
text.

---

## 4. Layout: the two styles are not "a prefix"

Measured (details in `tests/diag_baseline/*.expected`, all generated by a real armcc):

| Situation | ARM (default) | IDE (`--diag_style=ide`) |
| --- | --- | --- |
| front-end diagnostic | `"f.c", line 4: Error:  #20: identifier "c" is undefined` | `f.c(4,22) : error  #20: identifier "c" is undefined` |
| missing token at end | `"f.c", line 3: Error: At end of source:  #67: expected a "}"` | not measured; laid out as a file diagnostic |
| file known, line unknown | `"f.c": Error: At end of source:  #65: expected a ";"` | `f.c : error  #65: ...` |
| no source file | `"no source": Error:  #5: cannot open source input file "x": ...` | `no source : error  #5: ...` |
| command line | `"no source": Error: command-line:  #992: invalid macro definition: x` | `no source : error command-line:  #992: ...` |
| tool stage | `out.bin: Error: SRAM overlap between objects #0 and #1: ...` | same (tool stage has no code and no line number) |
| driver / fatal | `Fatal error: C3900U: Unrecognized option '-x'.` | `armcc : Fatal error C3900:  Unrecognized option '-x'.` |

Note the places in the IDE column that are **not a mechanical mapping**:

- the severity word carries **no colon** (`error`, not `Error:`);
- the driver code **drops its trailing letter** (`C3900U` → `C3900`);
- after the colon in a driver message there are **two spaces**, whereas a front-end diagnostic has two
  spaces after the severity word;
- the `armcc : ` prefix appears only on **driver** diagnostics in IDE style;
- IDE style **does not echo source and does not draw a caret** (one line per diagnostic; uVision
  navigates by line and column).

Three more behaviour rules:

- **A fatal diagnostic suppresses the summary line**; an ordinary `Error` does not. `diag_summary()`
  prints nothing when `counts[FATAL] > 0`.
- `--diag_style` is a **runtime global** and is scanned before the option loop proper: measurement
  shows `armcc -x --diag_style=ide` still reports `-x` in IDE style.
- **The error limit is 30** (`DIAG_LIMIT_DEFAULT`). Measured with 40 duplicate declarations: armcc
  prints 30 and then **neither prints nor counts any more**, with no "too many errors" trailer, and
  arkc follows. armcc has **no** option for it (`--diag_limit=5` is rejected with `C3900U`), so arkc
  does not offer one either (`diag_at_limit()` is a query only; the limit is a constant).
  The limit doubles as a **parse stopping condition**: `parse_program` and `parse_block` stop parsing
  when `diag_at_limit()` is true (the file is already incomprehensible, and continuing to build an AST
  only burns memory). There is a more fundamental guard as well: if statement parsing **consumed no
  token at all**, force one `lexer_advance` — otherwise the same error repeats forever on the same
  token. Measured on the board: `cc -S va.c` without `-I` (`<stdarg.h>` not found) let
  `u.v = va_arg(ap, long long);` spray #65/#29 on the same line for 595 ms and then stop at
  `[arkc] FATAL: memory pool exhausted`, burying the real cause (a missing include) under the last
  line; now it stops after 30 errors, returns in 226 ms, and never touches the allocator.

---

## 5. Source echo and the caret

Measured shape:

```
"f.c", line 1: Error:  #20: identifier "c" is undefined
  int f(void){ int b = c; return b; }
                       ^
```

- the gutter is a fixed 2 spaces, and the source is printed as-is (**tabs stay tabs**);
- the caret line is rebuilt by **display width**: ASCII counts 1 column, CJK counts 2, a tab counts 1
  column and is emitted as-is;
- only the **main file** is echoed. Lines pulled in by `#include` cannot be located in the current
  buffer, so they are not echoed — **not echoing is more honest than echoing the wrong line**;
- the echoed text must be the **post-preprocessed** one (lexer line numbers are counted on it), which
  is why `diag_init()` only receives the source after `preproc_process()`.

### 5.1 Columns are "display units", not bytes

`Token.col` and `DiagLoc.col` are both **1-based display columns**: a CJK character takes 2 columns, a
2-byte UTF-8 character such as `é` takes 1, and a tab takes 1. The reason is immediate: the caret line
is drawn by display width, so if columns were counted in bytes, one line of Chinese comment would push
the caret several positions to the right of the target character. `lex_col()` in `src/lexer.c`
maintains an incremental cursor and continues from left to right, so each token costs "the number of
characters between it and the previous token", not a full-line rescan.

(armcc counts bytes, so on the same CJK-containing source its caret sits further left. That is an
**intentional** difference — see §7.)

### 5.2 Semantic-phase columns come from the AST

`AstNode.col` is filled in by the parser: nodes built directly from a token (identifier, number,
string, float, unary, binary, assignment, call, member, subscript, postfix increment) record the
token's start column; derived nodes inherit the column of the sub-expression they represent (`anchor()`
in the parser). A few details calibrated by measurement:

- for `#137` on `(a+1) = 2`, armcc's caret sits on the `(` ⇒ a parenthesised expression **forces** the
  column of the `(` (even when an inner node already has a column);
- the caret for `#165 too few arguments` sits on the closing `)` (measured with `g()`, `g(1)` and
  `g( 1 , 2 )`) ⇒ a call node records the column of its `)`;
- the caret for `#140 too many arguments` sits on **the first superfluous argument** ⇒ sema re-anchors
  to `args[param_count]` and falls back to the call site only when no column is available.

When the column is unknown (0) the source is echoed without a caret. **When the caret cannot be drawn,
the whole caret line is dropped**: if the target column falls past the end of the line (a truncated
long line), or the caret line itself would exceed `DIAG_LINE_MAX` (512), `echo_source()` emits no
caret line at all — a caret in the wrong place is worse than none.

### 5.3 The two forms of a missing token at end of file

When the stream has already reached `TOK_EOF`, `lexer_expect()` goes through `diag_report_at_eof()`:

- the line number is **the line of the last newline** (`current.line - 1`; measured to hold for 1-, 3-
  and 5-line files), not the line the EOF token itself is on;
- an ` At end of source:` marker is appended to the position, with **no echo and no caret** (there is no
  character to point at);
- outside EOF, a missing `)` `]` `}` `;` maps to 18 / 17 / 67 / 65.

---

## 6. Command-line diagnostic policy options (each measured)

| Option | Measured behaviour (armcc 5.06u7) | arkc |
| --- | --- | --- |
| `--diag_suppress=177` | that one message is not printed, rc unchanged | same |
| `--diag_suppress=177,177` | accepted (duplicates harmless) | same (comma or space separated) |
| `--diag_suppress=abc` / `=9999` | **silently ignored**, rc unchanged | same (non-numeric or out-of-range are skipped) |
| `--diag_suppress` (no value) | `Fatal error: C3901U: Missing argument for option 'diag_suppress'.`, rc=1 | same |
| `--diag_remark=177` | **indistinguishable** from suppress | reuses the same suppression bits |
| `--diag_error=177` | printed as `Error:  #177-D`, rc=1 | same (`diag_force_error()`, `-D` preserved) |
| `--diag_error=177,101` | accepted | same |
| `--diag_warning=177` | **no observable change at all** | accepted, no-op (rejecting it would break armcc compatibility, and inventing downgrade semantics would be wrong) |
| `--diag_limit=5` | `C3900U` unrecognised option (armcc has no limit option) | not offered |
| `--diag_style=ide` | `f.c(1,17) : warning  #177-D: ...` + `armcc : f.c: 1 warning, 0 errors` | same |

All four options are pre-scanned **before the main option loop**, because style and suppression must be
in place before the first diagnostic appears; inside the main loop they are handled by an empty
"already processed" branch.

---

## 7. Known differences from armcc (the parts deliberately not chased)

These differences are **intentional** or **have no measured basis** — they are not unfinished work:

1. **Error recovery differs.** The arkc parser recovers along its own path after the first syntax error,
   so the **number** of messages can differ from armcc. In `run_diag_tests.py` such cases are marked
   `shape` (asserting only the spelling of each line); those comparable byte for byte are marked
   `exact`. In addition, arkc stops entering sema / IR / assembly **after any front-end error**
   (`compiler.c` checks `diag_errors()` after parse and after sema). armcc also stops in the front end,
   but at a different recovery point; the purpose of this gate is to eliminate follow-on messages such
   as "unresolved label" or "could not be lowered" that only exist because of the first error.
2. **`#1-D: last line of file ends without a newline` is not implemented.** armcc emits that warning
   (with a `-D` suffix) for a file without a trailing newline; arkc does not. It was left out because
   it would change warning counts in existing projects and is therefore a behaviour change that needs
   its own decision.
3. **Implicit function declarations.** In `int f(void){ return nope(1); }` armcc reports
   `#223-D: function "nope" declared implicitly` and **compiles successfully**; arkc does not
   implement implicit declarations and fails when the symbol is unresolved. This is a language-feature
   gap, not a layout difference.
4. **CJK columns are computed differently.** arkc counts display units (CJK = 2), armcc counts bytes.
   With UTF-8 source in a UTF-8 terminal arkc's caret lines up; with GBK source armcc's does. See §5.1
   and the `cjk` case in `tests/run_diag_boundary.py`.
5. **The caret of a lexical diagnostic can be off by one column.** For `#7: unrecognized token`,
   measurement shows armcc's IDE column is 24 while the ARM caret is drawn at 23; arkc always draws at
   the column number.
6. **The granularity of `#pragma diag_suppress`.** arkc preprocesses first, so suppression degrades to
   "in force for the whole translation unit" instead of armcc's "from this point to the next pragma".
7. **`--diag_style` does not retroactively apply.** Bytes already written to stderr cannot change
   style; only pre-scanning the options covers "the style option appears later" (already implemented).
8. **arkc's own messages carry no `#N`.** See the second item of §2. Linker, assembler and configuration
   file errors all fall in this class: `<object>: Error: <text>`, with no invented `L####`.
9. **On a clean compile, `--errors` still creates an empty file**, whereas armcc creates no file at
   all. arkc opens the sink during option scanning (so that no later diagnostic can be missed).
10. **Over-wide bit-fields are not reported.** Measurement shows armcc reports **nothing at all** for
    `struct S{ int a:40; }` and `struct S{ char a:9; }`; arkc keeps its own stricter diagnostic, which
    is why those two messages carry no armcc code.
11. **The IDE style for `At end of source` has not been measured**; arkc lays it out as a file
    diagnostic without any extra processing.

---

## 8. Steps for adding a diagnostic

1. First obtain the output of a real armcc (put a minimal case in `tests/diag_baseline/`).
2. If armcc's code is to be used: add the code to the curated list in `tools/gen_diag_table.py` and
   re-run the generator. If armcc has no such message (or it has not been measured): do not invent a
   code, use `DIAG_NO_CODE`.
3. Call `diag_report()` / `diag_report_at_eof()` / `diag_report_msg()` / `diag_tool()` from the stage
   code, taking the token's line and column from that stage; pass `0` for "line unknown".
4. Add a case to `CASES` (byte-comparable), `SHAPE_CASES` (spelling only) or `SINK_CASES` (asserting
   the message lands in the `--errors` file with nothing leaking to the console) in
   `tests/run_diag_tests.py`; if it is one of arkc's own contracts (line truncation, limits, CJK, tabs),
   add it to `tests/run_diag_boundary.py` instead.
5. `python tests/run_diag_tests.py --regen` to generate the baseline, then
   `python tests/run_diag_tests.py`; the boundary cases are just
   `python tests/run_diag_boundary.py` (it needs no armcc).

The gate has three exit codes: `0` all green, `1` a regression, `2` **undecidable** (neither armcc nor
a stored baseline is available). The second tier is deliberate: without evidence nothing is allowed to
"pass".

Baseline files use the `.expected` suffix rather than `.out`, because the repository's `.gitignore`
contains `*.out` (build artefacts). Using `.out` would make the baseline **silently stay out of the
repository**, leaving nothing but `[SKIP]` in CI.

---

## 9. Configuration switches

`include/arkcc_config.h` holds two switches:

- **`ARKCC_FEATURE_DIAG`** (master switch, default 1). When 0, `src/diag.c` compiles only a
  **minimal fallback implementation** (about 90 lines, with its own 512-byte buffer and positional
  `%s/%sq/%n/%d/%c` expansion, emitting through `ark_log("[arkcc] ...")`): it still counts and still
  decides the exit code, but has **no** codes, styles, echo, caret, suppression, limit or sink.
  Measured (`src/diag.o`, gcc -O2 x86_64, 2026-11-04): **14645 → 4397 bytes**; the whole executable goes
  from 127877965 to 127868520 bytes (a full `-DARKCC_FEATURE_DIAG=0` build links fine, and the exit
  codes of the `#warning` / duplicate-declaration / clean-file cases match the full build).
  The switch defaults to 1, so the default build's size and behaviour are exactly what they were
  without the switch. The fallback **deliberately shares no code** with the full implementation —
  sharing machinery saves no bytes, and an independent implementation is easier to see is correct;
  the code table (`diag_msg_table.c`) is kept, because the wording is data, not layout.
  With `ARKCC_FEATURE_DIAG=0`, `ARKCC_FEATURE_DIAG_SINK` is forced to 0.
- **`ARKCC_FEATURE_DIAG_SINK`** (`--errors <file>` and output-target switching). It is 0 in the
  `STM32_MIN` profile (to save flash); then `diag_open_sink()` always fails and diagnostics go only
  through `ark_log`.

**Two pitfalls already hit:**

- Neither `diag.h` nor `common.h` includes `arkcc_config.h`, so `src/diag.c` must include it itself.
  Without that line, `#if ARKCC_FEATURE_DIAG_SINK` reads as 0 in **every** profile (an undefined macro
  is 0 inside `#if`), all sink code is silently compiled out, while `--help` and the configuration
  switches still claim support. `SINK_CASES` is the guard for exactly that.
- A switch-like feature needs at least one case that **really exercises** it; otherwise "turned off /
  compiled out" and "working" look identical in the tests. The guard for the master switch is "a full
  `-DARKCC_FEATURE_DIAG=0` build plus four hand-run cases with unchanged exit codes" — small, but every
  step really goes through the fallback implementation.
