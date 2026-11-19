# Partial link (`-r`): merging several ARKOBJ2 objects into one

English | [中文](PARTIAL_LINK.md)

`-r` is a modifier for `-link`. It reads N `ARKOBJ2` objects and merges the
**machine code, symbol table and relocation table** into a **new `ARKOBJ2`
object** — not an image, no vector table, no address layout decided.

```bash
arkcc -c -target arm --cpu Cortex-M7 -O2 a.c -o a.o
arkcc -c -target arm --cpu Cortex-M7 -O2 b.c -o b.o
arkcc -r -link a.o b.o -o ab.o          # merge into one object
arkcc -link ab.o --vector-table -o app.bin
```

The second command produces exactly the same bytes as
`arkcc -link a.o b.o --vector-table -o app.bin` — one gate does a plain `cmp`
on it. That is the whole point of `-r`: it must be a **substitutable** middle
step, not yet another path that quietly changes the result.

| Option | Default | Profile | Notes |
| --- | :---: | --- | --- |
| `-r` | off | `full` | must accompany `-link`; may be written before or after it |
| `ARKCC_FEATURE_PARTIAL_LINK` | host `1`, `ARKCC_PROFILE_STM32_MIN` `0` | trim switch | `-DARKCC_FEATURE_PARTIAL_LINK=0/1` overrides |

---

## 1. Which of the two is authoritative: machine code

An object built with `-c --obj-ir` carries both machine code and an IR payload
(see [OBJ_IR.en.md](OBJ_IR.en.md)). `-r` merges the **machine code**, not the IR:

- merging two pre-pipeline IRs requires inventing a third intermediate format
  (how do two translation units' type tables, constant pools and global tables
  merge?), and every answer changes what later optimisation sees;
- the machine code is already in the object; merging it only means **changing
  addresses**, and those semantics are fully defined by the relocation table.

The price: a merged object can **not** later go through `-link --lto` (the
payload was not inherited). That is refused by name rather than hidden — an
object carrying an IR payload is rejected with:

```
error: -r merges machine code and cannot carry the IR payload this object
       holds; use -link --lto to recompile the units, or rebuild the object
       without --obj-ir
```

Silently dropping the payload would make "LTO still works afterwards" a lie, and
you would learn otherwise at link time, far from the cause.

## 2. Merge rules

### 2.1 Code

Concatenated in command-line order:

```
base(object i) = bytes placed so far
```

`-v` prints `[r] object 0: base 0x0, 1188 bytes` per object for accounting.

A `riscv32` object is padded to 16 bytes once an ISA tag has been seen (same as
`-link`: it is PC-relative and can live anywhere, but 16-byte alignment keeps
the section alignment the assembler assumed). ARM objects stay back to back.

### 2.2 Symbols

| Symbol type in the object | What `-r` does |
| --- | --- |
| plain label (type 0) | `offset += base`; duplicates follow strong/weak (strong vs strong is an error, weak yields) |
| `OBJ_SYM_TYPE_DATA` (global object) | **address unchanged**, recorded only; data is never moved |
| `OBJ_SYM_TYPE_RAM` (`__arkcc_ram_start/end`) | **descriptor kept as-is** (at most one pair per object) |
| `OBJ_SYM_TYPE_TEXT` (`--reloc-text` base) | recorded; all inputs must agree, otherwise refused |
| `OBJ_SYM_TYPE_ISA` (`__arkcc_isa_riscv32`) | recorded; emitted only if every input carries it |
| unknown type | refused, with the numeric type printed |

### 2.3 Relocations

Site `offset += base`, kept with the **same type**, to be interpreted by the
final `-link`.

The one exception handled in place is `X86_RELOC_SELF_BASE`: the site already
holds the object's own offset for a label it defines and only the base is
missing — which `-r` knows right here. The base is added and the record dropped,
byte-for-byte what `-link` does, so the merged object carries the same bytes.

### 2.4 Data

`-r` **does not move** `.data`/`.bss`. A global's offset is its absolute address
and goes into the merged object unchanged; `--reloc-data` / `--reloc-text`
rewriting is left to the final `-link`.

Hence a hard rule: **one `-r` may merge at most one RAM-owning object** (one
carrying `__arkcc_ram_start/end`). Two of them would overlap in absolute
addresses, and after merging `-link` can no longer see that there were two
blocks. Refused rather than guessed.

## 3. Refusals

Each is a shape that "produces a result that looks fine and is not":

| Input | Result |
| --- | --- |
| object with an `--obj-ir` payload | refused by name, points at `-link --lto` |
| two or more RAM owners | refused; merge the translation units or keep one per partial link |
| riscv32 mixed with non-riscv32 | refused (their relocation numbers mean different things) |
| a file that is not `ARKOBJ2` | refused |
| truncated symbol/relocation table | refused |
| stray bytes after the tables (not an IR payload) | refused (object is damaged) |
| same strong symbol at two different addresses | refused |
| `--reloc-text` bases differ | refused |
| symbol/relocation entries over the limit | refused, points at `ARK_LINK_MAX_SYMS` / `ARK_LINK_MAX_RELOCS` |

**No refusal writes an output file** — the object *is* the deliverable, so
"error plus half a file" is worse than either alone; every error path returns
before the write.

Option-level checks (all in `src/main.c`, all `C3900U`):

| Combination | Result |
| --- | --- |
| `-r` without `-link` | refused |
| `-r` together with `--lto` | refused (one merges machine code, the other recompiles IR) |
| `-r` with `-c` / `-S` / `-E` / `-MMD` | refused |
| `-r` without `-o` | refused (no unique derived name for N inputs; a default would make "the object is called .bin" the next trap) |
| `-link` with no objects | refused |
| build with `-DARKCC_FEATURE_PARTIAL_LINK=0` | refused, asks for a rebuild |

## 4. What `-r` does not do

- **No symbol pruning**: unreferenced globals still go into the object; that
  decision belongs to the final link.
- **No IR payload inheritance** (see §1).
- **No data section moving** (see §2.4).
- **No vector table**: `--vector-table` is an image-time hole; `-r` outputs an
  object.
- **No ISA conversion**: mixing is refused.

## 5. Properties that must hold

1. **Substitutable**: `-link (a.o b.o)` and `-link (-r a.o b.o)` are identical
   byte for byte (gated with `cmp`).
2. **Idempotent**: `-r` over an `-r` output equals a single direct `-r`.
3. **Inputs untouched**: sha256 of each input before and after is equal.
4. **Still an object**: output starts with `ARKOBJ2\n`, `code_len` is the sum of
   the inputs (modulo RV padding), symbol offsets fall inside the new code.
5. **Late definitions allowed**: a referenced name may still be undefined in the
   merged object — the final `-link` supplies it. `-r` never invents it.

## 6. Gates

`tests/run_partiallink_tests.py`, 27 checks, wired into `make test` as
`test-partiallink`:

```bash
make test-partiallink PYTHON=...python.exe      # 27 PASS / 0 FAIL / 0 SKIP
```

Covered: merge with code/symbol/relocation rebasing, `g_init`'s absolute address
unchanged, RAM descriptor preserved, merged-vs-direct link byte identity,
emulator actually answering 13, idempotence, inputs unmodified, merging without
`main` (a library unit), same-named file statics keeping their own values, a
definition arriving later (answers 41), and payload / two-RAM / non-object /
mixed-ISA / truncated inputs all "non-zero exit and no file written", the five
option checks, plus a cropped-build check that `-r` is refused while `-c` and
`-link` products stay byte-identical to the full build.

## 7. Trimming

`ARKCC_FEATURE_PARTIAL_LINK` is separate from `ARKCC_FEATURE_OBJ_IR`: they are
different features and an unused one should not be resident.
`ARKCC_PROFILE_STM32_MIN` defaults it to `0`, the whole `ld_partial_link()` body
is inside `#if`, and a cropped build rejects `-r` at option parsing with
`C3900U` — "compiled in but behaving differently" cannot happen.

Trimming evidence: with `-DARKCC_FEATURE_PARTIAL_LINK=0`, `-c` and `-link`
products are **byte-identical** to the full build (last gate).
