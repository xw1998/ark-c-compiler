# CI (continuous integration)

[中文](CI.md) | English

This repository carries two pipeline configurations that do exactly the same thing: **build arkcc
with the host gcc, then run `make test`**.

| File | Platform | Status |
| --- | --- | --- |
| `.workflow/main-pipeline.yml` | Gitee Go (the repository's main line lives on Gitee — **this is the one that really runs**) | Written against the official Gitee Go schema; it has to be enabled under *Services → Gitee Go* in the repository, and it counts as verified only once a run has gone green |
| `.github/workflows/ci.yml` | GitHub Actions (`ubuntu-latest`) | Runs only when the repository is mirrored to GitHub; the syntax is standard workflows format |

Both depend on nothing more than `gcc` + `make` + `python3` + the pip package `unicorn`. No cross
toolchain, no hardware.

---

## 1 What the pipeline does

```
gcc --version && make --version && python3 --version     # print the versions actually in use
python3 -m pip install unicorn                           # the only external dependency
python3 -c "import unicorn; print(unicorn.__version__)"   # read the version back to prove it installed
make CC=gcc                                              # build arkcc
./arkcc --list-backends                                  # are all five backends there?
make test PYTHON=python3                                 # every gate
```

After `--list-backends` the GitHub variant asserts a little more: all five of
`arm`/`x86`/`x86_64`/`riscv32`/`c` are present, `x86_64` reports `x86_64-unknown-linux-gnu` (not the
i386 triple), and the hyphenated spelling `-target x86-64` resolves to that same real backend. These
are the Linux equivalents of section 3b in `run_tests_x86.ps1`, which cannot run inside CI because it
is a PowerShell script.

`tools/install.py --dry-run` runs as its own step in the GitHub variant and asserts that the target
directory was not created — the install gate inside `make test` already covers it; this step exists
so that the contract "install in CI only prints, never writes" has an independent, visible step of
its own.

---

## 2 What `make test` covers in CI

| Target | What it does | Depends on |
| --- | --- | --- |
| `test-arm` | emits assembly for `examples/{hello,arith,func}.c` with `-target arm -S` | arkcc only |
| `test-c` | same, through the C backend, producing `*.gen.c` | arkcc only |
| `test-x86` | same with `-target x86` (i386 cdecl, only up to the emit stage) | arkcc only |
| `test-riscv` | same with `-target riscv32` | arkcc only |
| `test-stdlib` | 21 standard-library cases: compile → multi-object link → **really run** `main()` on unicorn's ARM M core | unicorn |
| `test-install` | `make install` into a temporary DESTDIR; byte comparison, a second run changing no mtime, `--dry-run` writing nothing, absolute PREFIX + DESTDIR rejected; then a program built from the **installed tree** must print 181 | unicorn |
| `test-reloc-text` | two objects are moved 0x1C070000 away from the address they were compiled for and string literals must still point at themselves; turning `--reloc-text` off must fall back to the old (wrong) address | arkcc only |
| `test-x86-64` | 35 programs compiled into flat 0x400000 images and run on a 64-bit unicorn core by calling `main`, each asserting a constant computed outside the program; every program is compiled a second time for 32-bit i386 and run again, and a mismatch FAILS; includes "an unresolved symbol must be rejected without leaving an image" and "an expectation off by +1 must be judged DIFF" | unicorn |
| `test-atomic` | `_Atomic` / `<stdatomic.h>` gate across five targets: exactly one target-identity macro, the 11 atomic operations must be compile-time errors on the four non-ARM targets with no artifact left behind, `atomic_init` must compile everywhere; the tail self-check requires the same source to be *not* rejected on arm | arkcc only |

The first four are **smoke** checks ("it still compiles"); the rest are **execution-level** ("it
actually computes the right answer"). The x86 / riscv32 smoke checks are in `make test` so that
"somebody broke a backend" cannot hide behind another backend's gate.

---

## 3 One non-portable construct that had to change

`test-arm` / `test-x86` / `test-riscv` used to pass `-S -o nul`. `nul` is a Windows device name; on
Linux it is an **ordinary file name**, so `make test` in CI wrote a file called `nul` into the
repository root and the intent of "emit only, do not write anything" quietly disappeared. The
Makefile now picks a variable per platform near the top:

```make
ifeq ($(OS),Windows_NT)
NULLDEV := nul
else
NULLDEV := /dev/null
endif
```

All nine `-o nul` occurrences became `-o $(NULLDEV)`. On Windows the behaviour is byte-identical
(still `nul`); on Linux it is `/dev/null`.

---

## 4 What CI does **not** run, and why

| Not run | Why |
| --- | --- |
| `run_full_test.ps1`, `run_tests_x86.ps1`, `run_link_test.ps1`, `run_asm_test.ps1`, `examples/run_tests.ps1` | all PowerShell scripts, Windows-only; CI runs Linux containers. They remain the main gates on a developer machine — coverage is listed in §6 of `docs/MANUAL.md` |
| `examples/run_va_gate.py`, `run_c11_keywords_tests.py`, `run_arm_int64_tests.py`, `run_arm_abi_mix_tests.py`, `run_rv_*_tests.py`, `asm_cases/run_asm_cmp.py` | they need cross toolchains (`arm-none-eabi-as` / `riscv32-unknown-elf-gcc` / `libgcc.a`), which cost hundreds of MB and are version-sensitive. Each script prints the reason and exits 2 when the toolchain is missing — it never fakes a pass |
| `tests/arm_exec/run_arm_exec.py` (the QEMU arm), `run_arm_exec_test.ps1` | needs `qemu-system-arm`; the same execution-level cases already run under unicorn inside `make test` (`test-stdlib`) |
| `tests/run_diag_tests.py` | needs the output of a **real armcc 5.06** to compare against byte for byte, which cannot be installed or licensed from CI |
| `make stm32` | needs `arm-none-eabi-gcc` |
| On-board self-hosting (compile on the H743, run on the board) | needs hardware in the loop. It is the most valuable chain in this repository and the one that can never go into a cloud CI — it only runs on a local machine |

The principle has not changed: **anything missing must be stated explicitly**. The gate scripts
themselves print `SKIP: <measured reason>`; the pipeline configuration is never allowed to turn a
missing dependency into a green light, and never uses `|| true` / `continue-on-error` to hide a
failure.

---

## 5 Reproducing locally (Linux / macOS)

```sh
sudo apt-get install -y gcc make python3 python3-pip     # Debian/Ubuntu
python3 -m pip install unicorn
make CC=gcc
make test PYTHON=python3
```

The equivalent on a developer machine (Windows / Git Bash):

```sh
export PATH="/d/mingw/MinGW/bin:$PATH"
make test PYTHON="C:/Users/<you>/AppData/Local/Programs/Python/Python310/python.exe"
```

> Note: on Windows the first `python` on `PATH` may be an old interpreter bundled with some IDE
> (it fails with `f-string: unmatched '('`). Either pass `PYTHON=` explicitly, or start a clean
> environment with `env -u PYTHONPATH -u PYTHONHOME`.

---

## 6 How to read the result

- exit code 0 and no `FAIL`: everything passed.
- `SKIP: ...` in the output is not a failure: it is a gate script giving up on one case **after
  measuring what is missing**, and printing the reason (for example the host emulator has no
  double-precision FPU, so the `strtod` case is skipped).
- `EXPECTED-FAIL`: only appears in the PowerShell gates (`run_full_test.ps1` /
  `examples/run_tests.ps1`), and means that a sample's failure is a **design decision** whose
  diagnostic text has been checked (today only `c99_armcc5_compat_test`, rejected by a single-object
  image because `errno`'s storage is defined in another translation unit). There is no
  `EXPECTED-FAIL` anywhere in the CI chain.
