# An IR payload in the object, and code generation at link time (`--obj-ir` / `-link --lto`)

English | [中文](OBJ_IR.md)

0.8.7 gives `ARKOBJ2` objects an **optional IR payload**: `-c --obj-ir` serialises
the whole pre-pipeline program (type table, three constant pools, the argument-length
table, globals, functions) and appends it to the object; `-link --lto` reads it back,
merges, runs the pipeline once and generates code again.  The result is that
**`--lto` and `--ipo` are byte-identical** -- same pipeline, same IR, same pool layout.

Together the two switches close the gap recorded in [IPO_LTO.md](IPO_LTO.en.md) §1
("objects carry no IR, so real LTO is out of reach").  This is still **not** a
linker-internal LTO of the GCC/Clang kind; the boundary is spelled out in §6.

| Switch | Default | Profile | Note |
| --- | :---: | --- | --- |
| `--obj-ir` / `--no-obj-ir` | off | `full` | only meaningful under `-c`; `--no-` exists so an ini can turn it back off |
| `--lto` | off | `full` | only meaningful under `-link`; **must be written before `-link`** |
| `ARKCC_FEATURE_OBJ_IR` | host `1`, `0` under `ARKCC_PROFILE_STM32_MIN` | build crop | override on the command line with `-DARKCC_FEATURE_OBJ_IR=0/1` |

```bash
# 1) compile per file, every object carrying its IR
arkcc -c --obj-ir -target arm --cpu Cortex-M7 -O2 main.c -o main.o
arkcc -c --obj-ir -target arm --cpu Cortex-M7 -O2 util.c -o util.o

# 2) merge the IR, run the pipeline, emit again (the same as one --ipo run)
arkcc --lto -link main.o util.o -target arm --cpu Cortex-M7 -O2 --vector-table -o app.bin
```

`--lto` and `--ipo` are the same job with two input shapes:

```bash
arkcc --ipo -O2 main.c util.c -S -o ipo.s          # eats source
arkcc --lto -link main.o util.o -O2 -S -o lto.s    # eats objects
cmp ipo.s lto.s                                     # must be empty
```

---

## 1. Why the payload is the *pre-pipeline* IR

`--ipo` runs the pipeline **once** over the merged program.  If `-c --obj-ir`
optimised before serialising, `--lto` would be a "second optimisation" whose input
already depends on how the program happened to be split -- which is exactly where
LTO goes wrong (compile the same source as one file or two, get different code).

So the hook sits in `ark_frontend_unit()` **before** `pipeline_run_ir()`:

```
each .c -> frontend -> IR (unoptimised) -> [--obj-ir: serialise and stash]
                                            |
                              --ipo: append to one big program -> run the pipeline once
                              --lto: read back from objects -> merge -> run the pipeline once
```

That choice buys a strong assertion that can be written as a gate: **`--lto` is
byte-identical to `--ipo`**.  Not "close" -- `cmp` is empty.  It is hard *not* to
achieve: both paths must be holding the same IR when they reach the pipeline entry.

## 2. Object layout

The existing `ARKOBJ2` layout is untouched; the payload is **appended after the
relocation table**:

```
"ARKOBJ2\n"        8 B
u32 code length
code bytes
u32 symbol count + (name len / name / offset / type / is_weak) each
u32 reloc count  + (name len / name / offset / type) each   <- only when relocs exist
[payload]                                                   <- optional, --obj-ir only
```

An old reader stops at the relocation table and never looks at the extra bytes, so
**an object with a payload still links under plain `-link`, producing an image
byte-identical to the payload-free one** (the gate has a check for exactly this).

The payload itself:

```
"ARKIR1\n"          8 B magic
u32 version         = 1
u32 body length
body:
  u32 ntypes   + each type (kind / base / nfields + fields / nparams + params ...)
  u32 nstrings + each
  u32 nfloats  + each (8-byte bit pattern)
  u32 ncomplex + each (two doubles)
  u32 nargbytes + each (u8)
  source_file (nullable string)
  u32 nglobals + each (name / type / flags / init / init_sym / init_refs[])
  u32 nfuncs   + each (name / return type / params / locals / instruction stream)
```

Strings are written as `i32 present (0 = NULL) + u32 length + bytes`: `NULL` and
the empty string are two different things in the IR and both must round-trip.

Instruction fields are written **in struct order** (`op, val, name, aux, line,
aux2`) and `name` is preserved **unconditionally**.  This was a real trap:
`IR_FUNC_BEGIN` uses `name` for the function name, and `IR_GETARG` / `IR_PUSH_ADDR`
/ `IR_PUSH_VAR` / `IR_STORE` / `IR_PUSH_INT` / `IR_SMC` / `IR_SVC` also carry a
`name` in practice, so a whitelist of "opcodes allowed to have a name" only kills
valid IR.  Serialisation must be lossless; the reader does not apply that whitelist.

## 3. Merging

`ir_program_append_unit(dst, unit, index, who)`:

1. record the current positions of the four pools as `base`;
2. **append** the unit's string / float / complex / arg-length pools to the target;
3. **remap** the pool indices in every instruction (`IR_PUSH_STR.val` is a strings
   index; `IR_PUSH_FLOAT.val` selects the complex or the float pool by
   `aux & 0x800`; `IR_CALL.aux2` is `1 + arg-length index`, `0` meaning no table);
4. add the unit's functions.

Pools are **not deduplicated** (append, id = post-append position).  That is what
`--ipo` does, so "merge the objects in command-line order" reproduces `--ipo`'s
pool layout and hence its machine code.

After the merge the three `--ipo` steps run unchanged: `ipo_mangle_unit` (file-scope
symbols become `__ipo<unit>f_/g__<name>` with collision handling, so two objects that
each carry a `static helper` still carry two), `ipo_dedupe_funcs` /
`ipo_dedupe_globals` (external names arbitrated by the linker rules), then
`ipo_prune_statics`.  `--lto` reuses those functions from `src/ipo.c` because they
are `static` there -- there is no second implementation to drift.

## 4. Command-line shape

**`--lto` must be written before `-link`.**  The reason is the `-link` input
collection rule: after `-link`, consecutive arguments that do not start with `-` are
taken as objects, and a `-` argument stops collection.  Writing
`-link --lto a.o b.o` lets `--lto` truncate the collection and you get
`--lto needs at least one object file`.

```bash
arkcc --lto -link a.o b.o -O2 -o app.bin     # right
arkcc -link a.o b.o --lto -O2 -o app.bin     # also right (after the objects)
arkcc -link --lto a.o b.o -O2 -o app.bin     # wrong: nothing after --lto
```

The remaining switches (`-target` / `--cpu` / `-O` / `--const-global` / `-S` / `-o`)
mean what they mean anywhere else; with `-S` you get assembly, otherwise an image.

## 5. Refusals and diagnostics

**A named error rather than a wrong answer**: a link that silently drops one unit's
code produces an image that runs and does half the work, which is far more dangerous
than a failed link.  So a missing, corrupt or mis-versioned payload is always a named
error, and **no output file is written**.

`--lto` refuses:

| Combination | Message |
| --- | --- |
| `-c` | `--lto cannot be combined with -c: --lto generates code from IR and writes a program` |
| `-E` | `--lto cannot be combined with -E: an object is already preprocessed` |
| `-g` | `--lto cannot be combined with -g: a merged program has one source_file, so every unit's lines would be labelled with the first object's name` |
| no `-o` | `--lto cannot be combined with no -o: with several objects there is no single name to derive the output from` |
| no inputs | `--lto needs at least one object file` |

`-c --obj-ir` refuses:

| Input | Message |
| --- | --- |
| a `.s` assembly input | `--obj-ir needs a C source: an assembly input has no IR` |
| a text backend such as `-target c` | `--obj-ir needs an object backend (arm/x86/x86_64/riscv32): the 'c' backend writes text, not a linkable object` |

Payload-level diagnostics (all naming the file):

```
cannot stat object: ...
object is <N> bytes but this arkcc reads at most <M>; raise ARK_LINK_BUF_SIZE and rebuild arkcc
only <N> of <M> bytes could be read; raise ARK_LINK_BUF_SIZE and rebuild arkcc
not an ARKOBJ2 object; --lto reads the objects produced by `-c --obj-ir`
this object carries no IR payload, so -link --lto cannot use it; rebuild it with -c --obj-ir
not an IR payload                  (bad magic)
IR payload is version <N> but this arkcc reads version 1
payload length does not match the file
```

In a cropped build (`-DARKCC_FEATURE_OBJ_IR=0`) both switches still exist and are
refused as "not compiled into this build", so the reader is not sent looking for a
typo:

```
Fatal error: C3900U: --obj-ir is not compiled into this build (rebuild with -DARKCC_FEATURE_OBJ_IR=1)
Fatal error: C3900U: --lto is not compiled into this build (rebuild with -DARKCC_FEATURE_IPO=1 -DARKCC_FEATURE_OBJ_IR=1)
```

## 6. What it does not do

- **Not a linker-internal LTO**: no `-r` partial link, no "machine code and IR both
  present with each path taking half", and no cross-language participation -- `--lto`
  only eats objects produced by `-c --obj-ir`, and an assembly object mixed in is
  refused by name as having no IR payload.
- **No version compatibility policy**: the version check is strict equality.  A 0.8.7
  object can only be read by a 0.8.7 `--lto`; any format change bumps the version and
  old objects are refused by name rather than "parsed as best we can".
- **No symbol table merge**: `--lto` does not arbitrate using the object's symbol or
  relocation tables; it emits from IR, and external names are arbitrated in the IR
  layer (`ipo_dedupe_*`).  That is also why `-c --lto` has no meaning.
- **No incremental / cached**: every `--lto` runs the pipeline from the start.  For
  MCU-sized programs that is a few hundred milliseconds; caching would only introduce
  a second question ("when does it go stale").
- **The payload is neither compressed nor pruned**: it is the full IR (including
  unused `static`s); pruning happens after the read-back.  Compress-then-decompress
  adds a second bug surface to save a few KB.

## 7. Gate (`tests/run_objir_tests.py`)

`make test-objir`.  Twenty-six checks:

| Group | Check | Why this one can fail |
| --- | --- | --- |
| payload written | the `-c --obj-ir` object contains `ARKIR1\n` | the hook is not wired, or serialisation was cropped out |
| prefix unchanged | the first N bytes equal the payload-free object **byte for byte** | the payload was written in front, or the existing layout moved |
| reference | in the `--ipo` `-S`, `main`'s body has no `BL one` and does have `MOV r0, #100` | if the reference did not inline or fold, the later "identical" is an empty equality |
| byte-for-byte | `--lto` and `--ipo` `.s` are identical | a wrong pool remap, a line-number leak, an inconsistent `static` rename |
| dynamic | the merged image returns 102 (`1*2+100`) | a wrong fold, link or pool index all move this number |
| image | `--lto` and `--ipo` `-o bin` are identical | vector-table reservation or init-table order, any of them, goes red |
| same-named statics | both objects' `helper` are still `__ipo1f_helper` / `__ipo2f_helper`, and the two arms' text is equal | the merge skipped unit renaming, or the rename was lost in the round trip |
| dynamic | that program returns 79 (`7*10+9`) | if the two `helper`s were merged into one the answer becomes 70 or 90 |
| no `main` | two units without `main` merge the same as `--ipo` | the merge secretly depends on an entry point |
| payload located | the payload header is found inside the object | the search hard-codes an offset |
| damage ×4 | truncated / bad magic / version 99 / body length +64: each a named error and **no output file** | any "parse as best we can" silently produces a wrong image |
| payload-free object | refused by `--lto` by name (`no IR payload`) | silently dropping a unit is a wrong answer |
| source file as object | refused as `not an ARKOBJ2 object` | the magic check was bypassed |
| does not disturb | plain `-link` over payload / no-payload objects gives the **same image** | an old reader walked into the payload area |
| option refusals ×4 | `-c` / `-E` / no `-o` / no inputs | any missing one is silently wrong semantics |
| `--obj-ir` refusals ×2 | assembly input / text backend | producing an object nobody can ever use |
| cropped build | `-DARKCC_FEATURE_OBJ_IR=0` refuses both switches | the crop hid an empty implementation |
| default off is zero change | a full build and a cropped build emit **byte-identical** `-c` objects for `examples/*.c` | default off must not change a single byte (compared=5, diff=0) |

`-g` is refused too (see the table in §5) but is not its own gate row, because it
takes the same `lto_refuse()` path as `-c` and `-E`.

The two `--lto` vs `--ipo` comparisons (`-S` and `-o bin`) *are* the correctness
definition of this feature: as long as the results match, the implementation is free
to do anything in between; if they do not, it is not finished.

## 8. Running on an STM32

`ARKCC_FEATURE_OBJ_IR` defaults to `0` under `ARKCC_PROFILE_STM32_MIN`: the on-board
compiler is not short of serialisation code, it is short of RAM.  Turning it on costs
`ARK_LINK_BUF_SIZE` (64 MB on the host) -- on the board that constant has to drop to
whatever the available RAM allows, see [STM32_BUILD.md](STM32_BUILD.en.md).

The usual arrangement is: **the board only does `-c`, the link-time recompile happens
on the host**.  The board emits payload-carrying objects with `--obj-ir` and the host
runs `--lto` to build the image, so the board never pays for a second pipeline run.
