
# Whole-Program Compilation (`--ipo` / `-flto`)

[中文](IPO_LTO.md) | English

0.8.7 adds `--ipo` (alias `-flto`): **one invocation takes several `.c` files and
produces one program**.  It is *not* link-time optimization done inside the
linker -- the reason is in §1; what it does is in §3, and what it does not do is
listed item by item in §6 instead of being papered over as "LTO-like".

| Switch | Default | Profile | Requirement |
| --- | :---: | --- | --- |
| `--ipo` / `-flto` | off | `full` (not in the MCU minimal profile) | `-o` is required |
| `ARKCC_FEATURE_IPO` | host `1`, `ARKCC_PROFILE_STM32_MIN` `0` | crop switch | overridable with `-DARKCC_FEATURE_IPO=0/1` |

`--ipo` **changes the analysis scope, not the meaning of `-O`**: cross-file
inlining still needs `-O2` (or `--autoinline`), exactly as with a single file.

---

## 1. Why this is not object-level LTO

Real LTO re-optimises at link time: the linker receives the intermediate
representation inside each object, merges them, and then runs optimisation and
code generation again.  This project's object format is `ARKOBJ2`:

```
"ARKOBJ2\n" | u32 code size | code bytes | symbol table | relocations (4=abs, 5=pc-rel)
```

**There is no IR in an object.**  Real LTO would mean adding an optional IR
payload section, rebuilding N copies of the IR at link time, renumbering the
string / float / label pools, and re-running the backend inside the linker --
a different contract (object format, linker, debug info, version compatibility),
and the premise "a whole backend can run inside the linker" would itself have to
be demonstrated on the board first.

So this stage implements **compile-time whole-program compilation**: the
compiler reads every source in one process, performs all cross-file optimisation
inside one `IrProgram`, and generates code once.  To the user the shape is
"several sources -> one image", but the mechanism differs from link-time LTO and
so does the product (`--ipo` refuses `-c` and `-link`).

## 2. Usage

```bash
# two sources into one image (the common case)
arkcc --ipo main.c util.c -target arm --cpu Cortex-M7 -O2 --vector-table -o app.bin

# look at the merged assembly (this is where cross-file inlining shows up)
arkcc -flto main.c util.c -target arm -O2 -S -o merged.s
```

Requirements:

- **Give `-o`**: with several inputs there is no single name to derive the
  output from, and a missing one is refused;
- **Inputs must be C source**: `.s` (assembly) and `.o` / `.ark_obj` (objects)
  are refused by name; objects are what `-link` is for;
- `-c` / `-E` / `-g` / `-link` are refused, each with its own reason (§5).

A single file may also be given to `--ipo`: the result is **byte-identical** to a
plain compile (the gate diffs it), because merging, de-duplication and pruning
have nothing to do for one file.

## 3. Merge semantics

Each file still goes through the **whole frontend on its own** (preprocess ->
lex/parse -> sema -> AST checks); its IR is then **appended** to one
`IrProgram`.  Appending rather than "build two finished programs and merge them"
is deliberate: the IR's string pool, float pool and label numbers are
**index-addressed**, so merging finished programs means renumbering (high risk;
a mistake silently cross-wires constants) or changing pool ownership.

Appending creates two immediate problems, each with one rule:

### 3.1 Renaming file-scope symbols

Two files' `static int step` are **two different functions** in C.  With two
objects the linker guarantees this automatically (each object's local symbols are
its own); after merging into one program that boundary is gone, so it has to be
spelled into the name:

```
static int step(...)         ->  __ipo0f_step        (function from unit 0)
static int table[4];         ->  __ipo1g_table       (object from unit 1)
```

The generated name is checked against the whole program; if it is taken (a user
really did write `__ipo0f_step`), another `_` is appended until it is not.  If
that fails 64 times, the compile fails with a diagnostic instead of gambling.

Only the **5 opcodes that carry a symbol name** are rewritten: `IR_CALL`,
`IR_PUSH_FUNC`, `IR_PUSH_GLOBAL`, `IR_STORE_GLOBAL`, `IR_PUSH_GLOBAL_ADDR`,
plus `IrFunc.alias_target`, `IrGlobal.init_sym` and `init_refs[].sym`.  The other
`name`-bearing opcodes mean something else and **touching them is a wrong
answer**:

| opcode | what `name` holds | treatment |
| --- | --- | --- |
| `IR_PUSH_STR` | the string's bytes | untouched |
| `IR_LABEL_NAMED` / `IR_JMP_NAMED` | a `goto` label (already function-qualified by every backend) | untouched |
| `IR_ASM` | assembly text | untouched (see §3.3) |

### 3.2 Resolving external names

When one name appears several times, the linker's rules decide:

| Shape | Result |
| --- | --- |
| two `static`s | already renamed, independent (§3.1) |
| one strong + some weak functions | the strong one wins |
| several weak functions | the first is kept |
| **two strong functions** | **error**: `multiple definition of function 'x' across the --ipo inputs` |
| `int g;` twice (tentative) | one object (C 6.9.2p2) |
| `int g = 1;` twice | **error**: `multiple definition of 'g' ...` |
| `extern int g;` + `int g = 1;` | the definition wins, initialiser kept |
| only `extern int g;`, never defined | one extern entry survives; if code still references it the image build refuses (no silent image) |

These decisions **must be made before optimisation**: handing two same-named
strong functions to the backend yields two same-named labels, and what the
assembler does with them is not a decision this compiler made.

### 3.3 Pruning: only what is provably unused

After cross-file inlining some `static` functions have no callers left; a
per-object build cannot drop them (an object carries no "unused" bit), so pruning
them here is a size win.  The keep-list is hard:

- `used`, `constructor`, `destructor`: the definition is the use;
- `alias_target`: another symbol names it;
- `__at()` (`has_at`) and `section` on objects: placement is externally visible;
- **any `IR_ASM` anywhere in the program** -> pruning is skipped entirely.  Symbol
  names inside assembly text are not parsed; guessing would be a silent wrong
  answer.

Functions are removed first, references recomputed, then static objects -- else
"an object only a dead function referred to" is judged wrongly.

## 4. The pipeline runs once

This is where all of `--ipo`'s value comes from: `pipeline_run_ir()` runs **once
over the merged program**, and `ir.inline` is already whole-program scoped
(`opt_inline(prog)` looks names up in `prog->funcs[]`).  So as soon as several
units' IR share one program, **cross-file inlining is free** -- no new pass was
written for it.

Measured (`tests/run_ipo_tests.py`): `main` calls `one()` from another file; at
`-O2` the assembly has no `BL one`, at `-O1` it does -- because `ir.inline`'s
`min_level` is 2, the same rule a single file follows.

## 5. Refused combinations and why

Refusing beats shipping something that only looks like it works:

| Combination | Reason |
| --- | --- |
| `--ipo -c` | An object holding N units must answer what "an undefined external in unit A defined in unit B" means at the object level (today: a relocation), and renamed statics cannot be undone by the linker. That is a different contract, not this stage |
| `--ipo -E` | Preprocessing is per file by definition; `-E` each file instead |
| `--ipo -g` | A merged program has **one** `source_file`, so every unit's lines would be labelled with the first file's name -- a wrong answer; refuse |
| `--ipo -link` | `-link` takes objects, `--ipo` takes sources |
| `--ipo` without `-o` | No single name to derive the output from |
| `.s` / `.o` input | Assembly has nothing to parse; objects carry no IR (that is `-link`) |

## 6. Known limits

- **Not object-level LTO**: no cross-boundary optimisation of third-party
  `.ark_obj` / `.a`; source is required.
- **No cross-TU constant propagation / global-value numbering**: merging only lets
  existing passes see more code; no new "cross-TU-only" transform was written.
- **`-g` unsupported** (§5): debug info still comes from per-file compiles.
- **`-MMD` output name**: each unit writes the same dependency file and the last
  one wins; ask for per-file dependencies with `-MMD -MF` per file.
- **Memory**: all units' IR is resident at once.  The 64 MB host pool is fine;
  the 128 KB board pool is not, so the STM32 minimal profile turns
  `ARKCC_FEATURE_IPO` off -- and then `--ipo` reports "not compiled into this
  build" rather than "unknown option".
- **Size and time**: one optimisation pass over the merged program; at `-O2` size
  grows with the inline threshold, the same trade-off a single file makes.

## 7. Gate (`tests/run_ipo_tests.py`)

`make test-ipo`.  Nineteen checks in four groups:

| Group | Check | Why this one can fail |
| --- | --- | --- |
| dynamic (ARM emulator) | cross-file call returns 28 | a mis-merged name returns another number |
| dynamic | two files each own a same-named `static`; result 23 | no renaming -> collision (error) or the wrong one (wrong value) |
| dynamic | two tentative definitions become one object; result 4 | no merge -> redefinition error |
| static/refuse | two strong functions -> error naming the symbol, and **no image** | a silent merge puts the error into the image |
| static/refuse | two `int g = 1;` -> error | same |
| static/refuse | undefined extern still refused | "if it links, link it" yields an image missing code |
| static/refuse | `.s` input refused by name | running the preprocessor over a binary yields nonsense diagnostics |
| static/refuse | `-c`/`-E`/`-g`/`-link`/missing `-o`: one reason each | silently ignoring claims work that did not happen |
| static | an uncalled `static` disappears from the merge, stays in a single-file compile | over-pruning deletes live functions |
| static | `-O2` has no `BL one`, `-O1` has | whether the pipeline ran, and how many times, is visible at once |
| anti-false-green | single file through `--ipo` is **byte-identical** to a plain compile (`.s` and `.bin`) | proves the difference comes from merging, not from the switch |
| anti-false-green | a `-DARKCC_FEATURE_IPO=0` cropped build refuses `--ipo` | cropping does not hide an empty implementation |

The "two strong functions must be an error" check is also the **guard for the
renaming logic**: if §3.1 stopped renaming, the two `static step`s would become
same-named strong definitions and the static case would go red with a duplicate
definition.  In other words, one check exists so that the failure of another is
visible.

## 8. Later (not done -- listed so it is not read as "supported")

1. **Cross-TU constant propagation / global-value numbering**: the merge already
   gathers the information; the pass is missing.
2. **Preconditions for real object-level LTO**: an optional IR payload section in
   `ARKOBJ2`; rebuilding IR at link time (renumbering three pools); a version
   compatibility policy.  All three need "a backend runs inside the linker"
   demonstrated on the board first.
3. **Partial link (`-r`)**: several `--ipo` units producing an intermediate
   object, linked at the end -- again blocked on "objects carry no IR".
