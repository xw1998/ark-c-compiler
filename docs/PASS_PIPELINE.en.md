# The configurable pass pipeline (`--pipeline`)

English | [中文](PASS_PIPELINE.md)

Ark C ships in two shapes from one source tree: the **desktop build**
(`arkcc.exe` / `arkcc`, Windows and Linux) and the **MCU-trimmed build**
(`ARKCC_PROFILE_STM32_MIN`, self-hosting on an STM32H743).  Both share the
front end, the backends and the object format; the difference is only *how
much work one translation unit is allowed to do*.

`src/pipeline.c` is that sentence turned into code: **the stage table is
declared once, one loop executes it, and every skipped stage leaves a
reason behind.**

```c
/* up to 0.8.4: the decision lived in opt_run()'s #if / if ladders and in
 * every call site in compiler.c */
/* from 0.8.5: one table */
static const IrStage g_ir_stages[] = {
    { "ir.constfold", ARK_PROFILE_LITE, 1, GATE_FLAG_AND_LEVEL, ... opt_constfold_func, 0 },
    { "ir.dce",       ARK_PROFILE_LITE, 1, GATE_FLAG_AND_LEVEL, ... opt_dce_func,       0 },
    { "ir.dce-cfg",   ARK_PROFILE_FULL, 1, GATE_FLAG_AND_LEVEL, ... opt_dce_cfg_func,   0 },
    { "ir.inline",    ARK_PROFILE_FULL, 2, GATE_FLAG_AND_LEVEL, ... 0,            opt_inline },
    { "ir.vectorize", ARK_PROFILE_FULL, 2, GATE_FLAG_OR_LEVEL,  ... 0,       opt_vectorize },
};
```

## 1. Two profiles, not two code bases

| Profile | Spelling | Meaning |
| --- | --- | --- |
| `full` | `--pipeline=full`, or **no option at all** (default) | every stage still follows its *own* switch and `-O` level: the historical behaviour |
| `lite` | `--pipeline=lite` | only stages with `min_profile = lite` may run; the rest are skipped and recorded |

The point that makes this safe is that **`--pipeline=full` is byte-identical
to not writing the option at all**: a profile is only a ceiling, it does not
replace a stage's own gate.  `--pipeline=lite` does not turn `-O2` into `-O0`;
it removes the expensive stages (today `ir.dce-cfg`, `ir.inline`,
`ir.vectorize`).

The same key works in the config file (`[opt]` section of `arkcc.cfg`):

```ini
pipeline = full
```

An unknown value is never papered over: `pipeline = lti` in a config file emits
a warning and **keeps the previous value**; `--pipeline=lti` on the command line
fails with `C3900U`, because there is no previous value to keep and guessing
would be deciding for the user.

## 2. The table: order is execution order

| # | Stage | Profile | Gate | Why here |
| --- | --- | --- | --- | --- |
| 1 | `ast.memlint` | lite | `--warn-mem` | AST lint, no `-O` gate; before enumcheck only so the diagnostic order stays reproducible |
| 2 | `ast.enumcheck` | lite | `--warn-enum` | ditto; the two lints do not interact |
| 3 | `ast.unusedresult` | lite | `--warn-unused-result` | third AST lint, equally free of the CFG |
| 4 | `ir.unreachable` | lite | `--warn-unreachable` | warns and rewrites nothing: one MIR graph, built before any rewrite so the report describes the shape the source wrote |
| 5 | `ir.unused-static` | lite | `--warn-unused-static` | same graph, same reason |
| 6 | `ir.recursion` | lite | `--warn-recursion` | cycles in the call graph, still before any rewrite |
| 7 | `ir.constfold` | lite | `-O1` and switch | fold first, so DCE can eat the dead halves folding exposes |
| 8 | `ir.dce` | lite | `-O1` and switch | the cheap rule clears the obvious cases, leaving less for the reachability walk |
| 9 | `ir.dce-cfg` | full | `-O1` and `--dce-cfg` | builds a reachability graph: much more expensive than the linear rule |
| 10 | `ir.licm` | full | `-O1` and `--licm` | moves work without creating dead code, so after `dce` is early enough; also needs MIR |
| 11 | `ir.unroll` | full | `-O1` and `--unroll` | unrolling replaces the whole loop header and latch; before `dce-cfg` so that pass sweeps any unreachable tail it leaves |
| 12 | `ir.inline` | full | `-O2` and switch | followed by a linear DCE sweep (see below) |
| 13 | `ir.const-global` | full | `-O1` and `--const-global` | only once inlining has moved callee bodies in does a `const` global's definition share a program with the instruction that loads it |
| 14 | `ir.tailmerge` | full | `-O1` and `--tailmerge` | inlining and constant propagation leave several blocks ending in the same instruction run; block-tail merging removes that duplication, and no later pass creates more |
| 15 | `ir.vectorize` | full | `-O2` **or** switch | inlining exposes `a[i]=b[i]+c[i]`, so this stage runs last |

`ir.inline`'s `cleanup_dce` flag deliberately **ignores `-fno-opt-dce`**:
expansion leaves the callee's dead tail at the call site, and that garbage was
created by inlining itself.  Gating the sweep on `enable_opt_dce` would let
`-fno-opt-dce -O2` keep instructions that inlining just invented.

## 3. Three gate shapes, all inherited

`GATE_FLAG_AND_LEVEL` (the default), `GATE_FLAG_OR_LEVEL` (only
`ir.vectorize`), and the AST form (`min_level = 0`, i.e. flag only).

These are not a design; each one is **what that pass has always done, written
down**.  Changing any of them changes generated code, so they are frozen in the
table and covered by the gate:

- `constfold` / `dce` do not run at `-O0`: folding changes what `-O0` output is
  expected to look like (`1+2` becomes `3`) and can fold undefined expressions
  such as `1/0` or `1<<40` into a *more specific* wrong answer.
- `vectorize` uses the OR gate: `--vectorize` is an explicit request and `-O2`
  turns it on by default; either one is enough, which is also why it runs at
  `-O0` on the host (see §7).
- `inline` keeps a hard `-O2` floor: expansion assumes parameters live in stack
  slots, which the ARM backend only guarantees on the `-O2` path.

## 4. Reading the decision: `--print-pipeline`

```
$ arkcc --print-pipeline -O2 examples/hello.c -o nul
[arkcc] pipeline:
  profile=full  level=-O2
  skip  ast.memlint  off (--warn-mem)
  skip  ast.enumcheck  off (--warn-enum)
  run   ir.constfold
  run   ir.dce
  skip  ir.dce-cfg  off (--dce-cfg)
  run   ir.inline
  run   ir.vectorize

$ arkcc --print-pipeline --pipeline=lite -O2 examples/hello.c -o nul
[arkcc] pipeline:
  profile=lite  level=-O2
  skip  ir.dce-cfg  skipped by --pipeline=lite
  skip  ir.inline  skipped by --pipeline=lite
  skip  ir.vectorize  skipped by --pipeline=lite

$ arkcc --print-pipeline examples/hello.c -o nul          # -O0
  skip  ir.constfold  needs a higher -O level
  skip  ir.dce  needs a higher -O level
  ...
  run   ir.vectorize
```

Three rules the output keeps:

1. **Every line is a decision, not an approximation.**  A skip must name the
   gate that actually failed (`off (-fno-opt-dce)` is never reported as
   `needs a higher -O level`).
2. **A trimmed-out stage still gets a line**: `not compiled into this build`.
   That is a different fact from "the switch is off", and merging the two would
   turn "this binary has no such pass" into "the user disabled it".
3. **No padding, no added parentheses**: the reason strings are sentences, and
   the gate splits the line on whitespace.

## 5. A defect this fixed on the way: two switches that did nothing

`-fno-opt-constfold` and `-fno-opt-dce` were **accepted but ignored** up to
0.8.4: the old `opt_run()` only looked at the `-O` level.  Accepting an option
and silently not following it is exactly the kind of answer this project
refuses.

The table gates both stages with `GATE_FLAG_AND_LEVEL`, so the switches work
now.  Both flags default to `1`, so **omitting them keeps the output
byte-identical to 0.8.4** (§8 has the reading).

## 6. Trimming: `ARKCC_FEATURE_PIPELINE_DUMP`

The stage tables and the execution loop are **always compiled in** --
`pipeline.c` is the driver now, not an optional pass.  Only the human-readable
half can be trimmed: the stage names and the reason strings.

```c
#if ARKCC_FEATURE_PIPELINE_DUMP
#  define PIPE_NAME(s) (s)
#else
#  define PIPE_NAME(s) ""
#endif
```

The default for `ARKCC_PROFILE_STM32_MIN` is `0`.  `--print-pipeline` then
refuses with `C3900U` and says how to rebuild, instead of printing an empty
table -- an empty table reads as "nothing runs", which is a wrong answer.

Measured with `-target arm -c --reloc-data` on the same `src/pipeline.c`:

| Configuration | Object size |
| --- | --- |
| default (strings and both lints compiled in) | 8,342 B |
| `-DARKCC_FEATURE_PIPELINE_DUMP=0` | 7,096 B |
| `-DARKCC_FEATURE_MEMLINT=0 -DARKCC_FEATURE_ENUMCHECK=0` (strings kept) | 7,830 B |
| all three trimmed | 6,616 B |
| host x86-64 default | 9,135 B |

So the **dump strings cost 1,246 B** (8,342 → 7,096) and that is exactly what
the MCU profile drops; the two lint tables and their calls take another 512 B
(8,342 → 7,830).

## 7. Known limits (stated here instead of left to the reader)

- **`ir.vectorize` runs at host `-O0` too.**  The OR gate is the historical
  behaviour; changing it would move `-O0` output, so this release keeps it and
  records it.
- **`lite` is not `-O0`.**  `lite` is a stage ceiling, `-O0` is a level gate;
  they are independent, and `--pipeline=lite -O2` still runs `constfold` and
  `dce`.
- **No `none` profile**, on purpose: turning everything off is already spelled
  `-O0` with no lint flags, and inventing a second spelling would give two ways
  to produce one image.
- **The pipeline does not change semantics.**  This release is a scheduling
  refactor -- who runs, in what order, is unchanged from 0.8.4 (§8).  The new
  capabilities are only "read it, trim it, pick lite".

## 8. Zero change: a number, not a slogan

```
$ bash cmp_old_new.sh          # 0.8.4's arkcc vs this build
compared=480 diffs=0
```

Scope: `examples/*.c` × `-O0/-O1/-O2` × `arm/x86-64`, all with `-S`,
**assembly text compared byte for byte** (exit codes too);
`480 = 80 example sources × 3 levels × 2 targets`.  Under the default profile
all 480 outputs are identical.

Then the heavier one: the self-host gate (27 of the compiler's own translation
units → flat image → the self-compiled compiler runs on unicorn → its object is
compared **byte for byte** with the host's) still passes, at
`fnv=28c333dc` / 2,130 B -- the same baseline number as 0.8.4.

## 9. Gate: `tests/run_pipeline_tests.py`

```
make test-pipeline
python tests/run_pipeline_tests.py --arkcc ./arkcc.exe
```

27 assertions in four groups:

| Group | What it holds |
| --- | --- |
| text | every line of `--print-pipeline` (run/skip plus reason) across `-O0/-O1/-O2`, `full/lite` and the lint switch combinations |
| effect | `-O2` and `-O2 --pipeline=lite` **must differ** (inlining really goes away), and `lite` equals `full` minus the inline stage |
| refusal | `--pipeline=lti` fails with `C3900U` and **leaves no output file**; `--print-pipeline` refuses the same way |
| ini | `pipeline=lite` in a config file is applied; a bad value warns and keeps the old value; after rebuilding with `ARKCC_FEATURE_PIPELINE_DUMP=0`, `--print-pipeline` refuses, compilation still works, and the `--pipeline` loop is still there |

The last group is the false-green check: if the refusal only failed because of
some unrelated error, the gate would prove nothing.  So those cases check the
exit code, the `C3900U` text *and* that no output file exists.
