
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
| `--const-global` (§8) | off | `full` | `-O1` and above, see §8 |
| `ARKCC_FEATURE_CONST_GLOBAL` | host `1`, `ARKCC_PROFILE_STM32_MIN` `0` | crop switch | overridable with `-DARKCC_FEATURE_CONST_GLOBAL=0/1` |

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
- **Cross-TU constant propagation needs `--const-global` explicitly** (§8): merging
  only makes it *possible*; by default not a single byte of code shape changes (the
  gate compares byte for byte). **No global-value theorem**: non-`const` globals
  never participate, even if the whole program never writes them.
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

## 8. Cross-TU constant propagation (`--const-global`)

Once `--ipo` has appended several TUs into one `IrProgram`, "is this `const` object
really a constant" becomes answerable **in full** for the first time: the definition
lives in `a.c`, the reader in `b.c`, and both are now in the same program.
`--const-global` turns that into instructions -- the load of a constant object
becomes an immediate.

The switches are `--const-global` / `--no-const-global` (the latter to turn it back
off when an ini enables it by default); they require `-O1` or above and do **not**
require `--ipo` -- a `static const` in a single file folds too (§8.5 has a check for
exactly that).  A cropped build uses `ARKCC_FEATURE_CONST_GLOBAL=0`, and then the
option reports "not compiled into this build".

```bash
arkcc --ipo main.c limits.c -target arm --cpu Cortex-M7 -O1 --const-global -o app.bin
```

### 8.1 What counts as a constant

An object folds only if **every** condition below holds; any one of them failing
keeps the load (correct but slow):

- declared `const` **and** carrying a scalar integer initialiser (`has_init`, not
  `init_str` / aggregate / symbol address);
- **not** `extern` -- the definition must be visible in this unit, otherwise
  "somewhere else it could be `int`" cannot be ruled out;
- never written: no `IR_STORE_GLOBAL` anywhere in the program names it;
- address never escapes: no `IR_PUSH_GLOBAL_ADDR` names it, and it does not appear
  in another object's `init_sym` / `init_refs[]`.  **Once the address is out, who
  writes through the pointer can no longer be proven**;
- not `volatile`; not an array / `struct` / `union` / function; `type_size == 4`
  (`IR_PUSH_INT` pushes one word; `long long` / `double` take two);
- no `__at`, no `section`, not `__thread`, not `__global_reg`.

Erring on the conservative side is deliberate: a missed fold saves one `LDR` less,
a wrong fold is a wrong answer.

### 8.2 Why it sits after `ir.inline`

Only after cross-file inlining has moved the callee body in do the "read this
`const`" instructions and the evidence for whether it is constant share one view.
And because the `--ipo` pipeline **runs once and does not iterate** (§4), this pass
calls `opt_constfold_func()` itself after each modified function so that `LIMIT*2+1`
collapses within the same round instead of waiting for a next constant-folding round.

### 8.3 What the fold looks like

```
/* limits.c */  const int LIMIT = 100;
/* main.c   */  int limit(void) { return LIMIT; }

# with --const-global            # without
limit:                          limit:
    MOV r0, #100                    MOVW r0, #...
                                    MOVT r0, #...
                                    LDR  r0, [r0]
```

`--print-pipeline` (needs `ARKCC_FEATURE_PIPELINE_DUMP`) prints
`run   ir.const-global`; with the flag off it prints
`skip  ir.const-global  off (--const-global)`.

### 8.4 What it does not do

- **It does not delete the folded `const` object**: an externally-linked `const`
  still needs a definition when the image is `-link`ed with other objects; `static`
  ones are handled by the pruning in §3.3.
- **No global-value theorem**: a non-`const` global may still be written through
  assembly, an external object or a signal path even if the whole program never
  writes it.  Only the provable `const` path is taken here.
- **No cross-width expansion**: `long long` / `double` occupy two words; widening is
  a separate job, so the load stays.

### 8.5 Gate (`tests/run_constglobal_tests.py`)

`make test-constglobal`.  Fifteen checks:

| Group | Check | Why this one can fail |
| --- | --- | --- |
| fold happened | a `const` read from another unit becomes `MOV r0, #100`, no `LDR` in the body | the pass is not wired, or the candidate test was widened to "looks constant" |
| anti-false-green | **without the flag** the same source still has a `LDR` | proves the shape change comes from the switch, not another optimisation |
| dynamic (ARM emulator) | both the folded and the unfolded image return 103 | a wrong fold (address as value) goes red |
| static | `-O0 --const-global` still loads | the pass has `min_level` 1 |
| static | `--print-pipeline` reports `run ir.const-global` and `off (--const-global)` | the switch and the stage table drifted apart |
| conservative ×5 | address taken (6), store through it (9), `volatile` (6), array (3), `long long` | each maps to one condition in §8.1; widening any one goes red |
| single file | `static const int P = 7; P*2+1` has no `LDR`, returns 15 | folding without re-running constant folding stops the cascade halfway |
| refuse | a `-DARKCC_FEATURE_CONST_GLOBAL=0` cropped build rejects the option | cropping does not hide an empty implementation |
| anti-false-green | with the switch off, a full build and a cropped build emit **byte-identical** `.s` for `examples/*.c` × `{-O1,-O2}` | default-off must change nothing (compared=10, diff=0) |

The "store through the address" row is also the guard for the §8.1 address-escape
condition: if address-taken detection broke, that check would go red with 5 instead
of 9.

## 9. Later (not done -- listed so it is not read as "supported")

1. **Global-value theorem**: constant-ness of non-`const` globals first needs an
   answer to "can an external object or assembly text write it", see §8.4.
2. **Preconditions for real object-level LTO**: an optional IR payload section in
   `ARKOBJ2`; rebuilding IR at link time (renumbering three pools); a version
   compatibility policy.  All three need "a backend runs inside the linker"
   demonstrated on the board first.
3. **Partial link (`-r`)**: several `--ipo` units producing an intermediate
   object, linked at the end -- again blocked on "objects carry no IR".
