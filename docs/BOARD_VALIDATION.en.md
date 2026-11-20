# On-board full validation (the 0.9.0 stability criterion)

English | [中文](BOARD_VALIDATION.md)

> Audience: anyone asking "what makes 0.9.0 a *stable* release", and anyone who has to re-run this gate later
> Encoding: UTF-8 (no BOM)

---

## 1 What this document is about

What separates 0.9.0 from the releases before it is not features but **evidence**: every code-generation
fact this compiler produces was checked by a *return value the STM32H743 actually computed*, not by
"the assembly looks plausible".

There is exactly one criterion:

```
tests/run_stm32_board_tests.py --port COM3 --opt 0,1,2   ->   162/162 case-runs passed
```

54 cases x 3 optimisation levels (`-O0` / `-O1` / `-O2`) = 162 rounds of "upload the source to the board,
let the board's own compiler compile it, link it, load it, execute it, print `main()`'s return value on the
UART, compare against the expected value".

The same cycle also requires the host gate to be green (`make test`, 30 targets, `0 failure(s)`): the board
exercises the same back end, the host exercises the front end, the middle end, the docs and the rejection
paths, and neither side may be red.

---

## 2 How the gate works

| Step | What it does | Why it has to be that way |
| --- | --- | --- |
| `demo` | installs `crt.c` + `app.sct` (clears the RAM slots) | every later link needs a scatter file and a startup |
| `runtime` | the board compiles `aeabi.c`, `aeabi_divmod.s` into `aeabi.o` / `aeabi_div.o` | the runtime that gets linked must be built **by the board compiler under test** |
| `put` + `sum` | feed the source line by line, then `sum` returns `size` + FNV-1a-32 | a byte count cannot catch a duplicated chunk; a hash mismatch is re-sent up to 3 times |
| `run` | board does `cc -c` -> `cc -link` -> load -> execute | prints `[arkcc] program returned N` |
| grade | `N` equals the expected value -> PASS | the expected value is computed **independently**, never by the implementation under test |

Three hard rules are baked into the gate:

1. **Self-check**: at the end the gate runs one deliberately wrong expectation (`expect 35`, real value 34)
   and it must be rejected. If it is not rejected the criterion is fake and the whole run is void -- this
   is "a gate must carry its own anti-false-green self-check".
2. **A dropped link is not a failure, but it must be visible**: when the UART goes silent or `put` is not
   accepted, the gate recovers with `reset_board()` -> `sync` -> `demo` -> `install_runtime()` and prints
   `[board] note: resetting the board and re-running <case> O<n> once`. After the retry the run is graded
   on its return value again; nothing is silently promoted to PASS.
3. **The return value must be read to the end of its line**: the `run` pattern includes the line
   terminator (see 6.3). One digit short is a wrong answer, not "a different right answer".

---

## 3 Measured readings (0.9.0)

| Item | Reading |
| --- | --- |
| Board, full run (release firmware c21, **first run right after flashing**) | **162/162 case-runs passed**, 1022.8 s (about 17 minutes); one case hit a visible reset-and-rerun (86.7 s) because the serial `put` was not accepted -- the known serial-RX byte-loss debt, not a compiler problem (see 8) |
| Board, targeted re-check (first run after flashing, 3 double cases) | `dbl_ull_cast` / `dbl_ll_frac` / `f_ull_cast` **3/3 PASS**, `runtime built on board: aeabi.o 12833 B (12028 code, 27 syms, 11 relocs, 11 .arktext)` |
| Negative control (firmware deliberately built with `enable_reloc_text = 0`) | `[arkcc] aeabi.o carries 0 .arktext relocations (26 syms, 0 relocs): it was built with --reloc-text off, ... Refusing to report the runtime as ready` -- the new check really can fail (see 5.1 row 7 and 6.5) |
| Firmware | `mdk/STM32H743_ArkCC` built and flashed through the UV4 batch command, `Verify OK`; `version` answers `Ark C Compiler v0.9.0` |
| Host gate | `make test`, 30 targets, `0 failure(s)` |
| Buffer gate | `tests/run_buffer_tests.py`, 7 checks, `all buffer checks passed` |
| Unresolved symbol | the board's linker answers `app.bin: Error: unresolved symbol "nope"`, `link failed: -8` |

> The previous round (same cases, same firmware, gate still carrying the prefix match of 6.3) read
> `160/162`. Both "failures" were the gate reading `11` as `1` and `68` as `6`; re-running those two
> cases on their own gave 4/4. The fix is 6.3.
>
> "First run right after flashing" is the qualifier that makes this section mean anything: the defect in
> 5.1 row 7 only shows up on the **first** `runtime` after a fresh flash (on the old firmware those three
> double cases answered 68 / -1 / 68). Rerunning makes it look fine. So 162/162 is only meaningful in the
> "flash once, run once, no rerun" reading -- which is exactly why this round moved the flag into `main()`
> and made `cmd_runtime()` read back the object it had just written (6.5).

---

## 4 Coverage

54 cases, each betting on exactly **one** code-generation fact. Eight groups:

| Group | Cases | What is at stake |
| --- | --- | --- |
| Calling convention | `int_args_9`(34), `mixed_8_args`(22), `struct_byval`(45), `struct_sret24`(38), `struct_sret40`(19), `func_ptr`(42), `fptr_table`(14), `ptr_llong_arg`(41), `varargs_copy`(20) | six integer registers plus stack arguments; 8/24/40-byte aggregates passed and returned; function-pointer tables; a pointer is one word while a `long long` is two |
| 64-bit integers | `ll_mul`(7), `ull_div`(74), `ull_loop`(187), `llong_local_init`(1288), `dbl_ull_cast`(187), `dbl_ll_frac`(7), `f_ull_cast`(31) | every `__aeabi_lmul/ldiv/uldiv/ldivmod` path; double -> integer must truncate toward zero (the high half may not round up) |
| Integer semantics | `promo_uchar`(3), `neg_div`(29), `signed_div`(68), `unsigned_shift_right`(1), `unsigned_shift_right_var`(1), `unsigned_relational`(15), `bitfield_neg`(7), `bitfield_signed`(112), `bitfield_incdec`(220) | integer promotion, C99 6.5.5p6 truncation toward zero, `shr` rather than `sar`, unsigned comparisons, bit-field sign extension and neighbouring fields left alone |
| Aggregates | `struct_cond`(34), `struct_cond_arg`(12), `struct_ll_field`(21), `struct_copy16`(11), `sizeof_member_array`(0), `designator_chain_local`(15), `designator_chain_global`(79) | a `?:` of struct type yields a value, not an lvalue (so it is materialised); a 16-byte aggregate copy really goes through `__aeabi_memcpy`; `sizeof` of a member array is not 4; designator chains |
| Pointers and arrays | `ptr_walk`(84), `ptr_diff`(51), `ptr_llong_roundtrip`(5), `ptr_array_init`(0), `data_array_init`(30), `rodata_ptr`(35), `ptr_local_init_null`(11) | 8-byte pointer arithmetic and difference, pointer <-> `long long` must create and drop the high half, both halves of a pointer element in an initialiser list |
| Floating point | `float_mul`(23), `float_add`(16), `double_cmp`(1001), `double_precision_bits`(7), `double_precision_arith`(45), `double_local_init_from_int`(46), `uint_to_double`(4000), `double_to_uint`(3500), `uint_to_float32`(4000), `fconv_rne`(42) | the single- and double-precision paths, the `VCMP` + `VMRS` compare chain, binary64 bit patterns, unsigned <-> floating point (signed instructions need the 2^31 split and bias), all four `float <-> double` rounding ties |
| VLAs and run-time sizes | `vla_sizeof_at_declaration`(7), `vla_length_conversion`(7), `vla_outer_dim_2d`(10) | `sizeof` answers what the declaration computed; the length expression goes through its own conversions; a variable *outer* dimension |
| Control flow and symbols | `fib_switch`(99), `x86_sym_plus_disp`(7) | recursion plus a jump table, `[symbol+disp]` fetching the high word of a 64-bit global |

> The table lives in `tests/stm32_board/board_cases.py`; every case carries a sentence saying why that
> number is only reachable with the right code generation, and picks an expectation that a wrong answer
> would *not* also produce (`double_cmp`'s 1001 = 1 + 1000, one bit per comparison, so any one mistake
> misses).

---

## 5 Root causes fixed for this "stable" release

### 5.1 Fixed in this cycle (0.9.0)

| # | Symptom | Root cause | Where |
| --- | --- | --- | --- |
| 1 | A large source file was silently truncated on the board, producing "runs but means something else" machine code | the board profile still had a 1 KB source buffer and an 8 KB assembly buffer, too small for the real cases | `include/arkcc_config.h`: the STM32 profile now has **32 KB source / 256 KB assembly** (with `ARK_OBJ_BUF_SIZE = asm + 16`) |
| 2 | When a buffer was genuinely overrun, all four back ends truncated at `%.*s` and emitted anyway | nothing refused | `backend_arm.c` / `backend_c.c` / `backend_riscv32.c` / `backend_x86_64.c` each check the negative length at emit time and **refuse**; `compiler.c` names `ARK_ASM_BUF_SIZE` in the diagnostic |
| 3 | Regression gate for the above | -- | `tests/run_buffer_tests.py` (`make test-buffers`, 7 checks): a 4 KB assembly buffer refuses a bigger program, a 1 KB source buffer refuses a bigger file, no object is left behind, and the normal build still compiles the same program |
| 4 | `fconv_rne` returned 95 (expected 42) at `-O0/-O1` | **the test's expectation had the wrong bit pattern**: `0x47EFFFFFE0000000` is exactly `FLT_MAX`, which converts to `0x7F7FFFFF`, not infinity; the real "`FLT_MAX` plus half an ulp, tie to infinity" is `0x47EFFFFFF0000000` | `tests/stm32_board/board_cases.py`; the host gate's copy of the same table was already right (cross-checked) |
| 5 | The full run lost the board at case 158 (`put` not accepted) | the UART RX FIFO swallowed a command line / a test image killed the shell -- **not a compiler problem** (isolated re-run 2/2 PASS) | the gate gained `reset_board()` + `bring_back()` + one automatic retry per case |
| 6 | The gate read `11` as `1` and `68` as `6` | the pattern `program returned (-?\d+)` matched **as soon as the first digit arrived**, grading half a number | the pattern now carries the line terminator (6.3) |
| 7 | On the first run after flashing, three double-conversion cases answered wrongly (`dbl_ull_cast` 68, `dbl_ll_frac` -1, `f_ull_cast` 68); the same firmware passed them on a re-run | On the board, `runtime` compiled the AEABI helpers while `g_config.enable_reloc_text` was still 0 (the switch was only set inside `build` / `run`), so `aeabi.o` came out as **12607 B / 26 syms / 0 relocs**: every absolute address in its constant pool was baked for `0x08000000` while the image runs at `0x24070000`, so the helpers read firmware bytes out of internal flash. The re-run passed because `g_config` had been flipped to 1 by the earlier `run`, and `install_runtime` then rebuilt the good object: **12833 B / 27 syms / 11 `.arktext` entries** | `User/main.c`: `main()` sets `g_config.enable_reloc_text = 1` right after `config_init()`; `cmd_runtime()` now **walks the object it just wrote** and refuses to report the runtime as ready when `.arktext` is 0 (see 6.5) |

### 5.2 Fixed in earlier cycles (traceable in git)

| Commit | What it fixed |
| --- | --- |
| `ed06a73` | ARM soft-float AEABI runtime (30 entries, pure integer); the function prologue's `__aeabi_memcpy` clobbering the incoming r1-r3 when copying a struct-by-value argument; the Thumb-2 modified-immediate encoder using a three-bit rotation (`0x80000000`-class immediates encoded wrong) |
| `4f8d014` | the real on-board loop: compile -> link -> load -> execute, one layout per invocation |
| `544736a` | MDK (STM32H743) project linking |
| `be63198` and friends | four shared defects: the high half rounding up in `double -> 64-bit integer`, struct-typed `?:` materialisation, inserting a cast for `ptr -> long long`, and the i386 backend ignoring the unsigned bits (`shr`, `seta`) |

---

## 6 Five lessons the gate itself taught

### 6.1 A test's expected value can be wrong, and it is easier to get wrong

`fconv_rne`'s 95 was not the compiler's answer, it was the test calling `FLT_MAX` "just overflowing". What
that shape looks like is **wrong at one level and right at the others**, so the first move is to
cross-check "what does the same case say at another level / in another gate", not to edit
`__aeabi_d2f`.

### 6.2 A dead UART must be separated from a program that really hangs

Both look identical in the log (no return value). The discriminator is an isolated re-run: 2/2 on its own
means the wire, still broken means the code. The recovery (reset + reinstall `demo` + `runtime`) must be
**printed**, because a reset wipes the RAM disk, and the reinstall exists so that the "the disk is still
there" assumption cannot turn some case into a wrong answer.

### 6.3 "Half a number" is the nastiest kind of false failure

Until the third round the pattern was `\[arkcc\] program returned (-?\d+)`. The port hands text to the host
in chunks, so the two bytes of `68` can arrive in two reads; the regex succeeds on the `6` alone and the
run is graded `returned 6`. It shows up as **random, low-frequency, and most visible when a digit repeats**
(`11` -> `1`, `68` -> `6`), and an isolated re-run passes.

The fix is to put the line terminator in the pattern: `\[arkcc\] program returned (-?\d+)\r?\n`. The board
prints `\r\n` immediately after `put_int_dec(rc)`, so "waited for the newline" *is* "the number is
complete", with no extra protocol. The same sweep checked the other two numeric parses:
`[put] stored (\d+) bytes` and `[sum] ... size=(\d+) fnv=0x%08x` both carry a fixed suffix (` bytes`, eight
hex digits) and cannot match on a prefix.

### 6.4 A child process's cwd can shadow a standard-library module

`reset_board()` runs `python -m pyocd` through `subprocess`. If the cwd happens to be a temp directory
holding an old script named `cmd.py` (or `dis.py`), `python -m pyocd` imports it first and dies with
`module 'cmd' has no attribute 'Cmd'`. The fix is to pass `cwd=tests/` and to clear `PYTHONPATH` /
`PYTHONHOME`.

### 6.5 Two "legal" objects: linking is not running

This is the last root cause of 0.9.0 and the most reusable one: **one `aeabi.c`, one compiler, two
different objects -- and both link**. 

| State | `aeabi.o` | Tables | Symptom |
| --- | --- | --- | --- |
| Freshly flashed (`enable_reloc_text=0`) | 12607 B | 26 syms / 0 relocs | three double-conversion cases answer wrongly |
| Later (`enable_reloc_text=1`) | 12833 B | 27 syms / 11 relocs | all correct |

The **code sections are byte-identical** (12028 B both times); the 226 B difference is entirely
symbol/relocation table. So any criterion that only asks "did it compile / did it link" cannot see
it -- and `link` did report `4 objects -> app.bin`; the addresses inside were just pointing at
`0x08000000`.

How it was pinned down, by treating "same source, two objects" as the evidence itself:

1. read the object's **size + symbol count + reloc count** (`sum` / `link` output) instead of the
   exit code;
2. reproduce the split on the host: `-mcpu Cortex-M7 -c` gives 12607 B / 0 relocs, adding
   `--reloc-text` gives 12833 B / 11 `.arktext` entries -- so the whole difference is one switch;
3. put the criterion at the **producer**, not in the log: `cmd_runtime()` walks the ARKOBJ2 tables
   of the file it just wrote and refuses to say "ready" when `.arktext` is 0; the gate grades the
   numbers in that line.

Lesson: **a feature switch opened in one entry point lets every other entry point produce a
wrong artifact silently**, and this project's criteria have to read the artifact, never the intent.

---

## 7 On-board evidence for "rather an error than a wrong answer"

What the board's linker prints for an undefined symbol (`put` a file with `extern int nope(void);`, then
`run`):

```
[link] vector table written into the 1024-byte hole the first object reserved (SP=0x2407C000, entry=0x24070478)
app.bin: Error: unresolved symbol "nope"
[arkcc] link failed: -8
```

No image, no return value, non-zero exit code. This is worth its own evidence because "silently succeeds"
is the failure mode this project fears most: the symbol would be `0x00000000` in the running image, and the
program would jump into the vector table.

---

## 8 Known debts (not part of the 0.9.0 criterion)

| # | Debt | Status |
| --- | --- | --- |
| 1 | about 1.3 KB of arena per statement | large functions are still RAM limited on the board; unchanged |
| 2 | long `double` literals are off by 1 ulp (e.g. `.L_dbl_9` = `1:0x43e00000`) | recorded, not fixed; no case depends on it |
| 3 | `aeabi_float.c` (30 soft-float entries) is not uploaded to the board | every board case goes through VFP or integer paths; soft float is covered by the host `test-softfloat` gate |
| 4 | the UART occasionally drops a byte / the board occasionally goes silent | the gate's automatic reset is the fallback; not localised to a specific register |
| 5 | `pyocd -m` needs a fixed cwd | fixed inside `reset_board()` |

---

## 9 Reproducing

```bash
# 1) host: the compiler itself plus every gate
export PATH="/d/mingw/MinGW/bin:$PATH"
env -u PYTHONPATH -u PYTHONHOME make PYTHON="<python>" test

# 2) firmware: build + flash (UV4 batch; -j0 keeps warnings from failing the build)
"D:/Keil_v5/UV4/UV4.exe" -b ArkCC.uvprojx -j0 -o build.log      # run inside mdk/STM32H743_ArkCC/
"D:/Keil_v5/UV4/UV4.exe" -f ArkCC.uvprojx -j0 -o flash.log      # EXIT=0 and "Verify OK" in the log
pyocd commander -t stm32h743xx -c "reset" -c "go"               # UV4 leaves the core halted

# 3) full board run (about 16 minutes, the port is exclusive)
env -u PYTHONPATH -u PYTHONHOME python -X utf8 tests/run_stm32_board_tests.py \
    --port COM3 --opt 0,1,2
# expect the last two lines:
#   [board] 162/162 case-runs passed in <n>s
#   PASS selfcheck: an expectation of <x> was rejected (the real value is <x-1>)

# 4) just a few cases (the usual thing after touching one back end)
... --only struct_copy16,fconv_rne --opt 1,2
```
