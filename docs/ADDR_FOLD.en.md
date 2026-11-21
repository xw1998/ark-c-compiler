# Addressing-mode folding (`-fopt-addr`)

English | [中文](ADDR_FOLD.md)

> The fifth optimisation of 0.9.1. One sentence: **the stack-machine emitter
> spreads one array/pointer access over `MOV` + `ADD` + `LDR/STR`; this pass
> folds the address arithmetic into the operand so that one `LDR r0, [r5, r1]`
> does the work of three.**
>
> Implementation: `src/backend/arm/backend_arm.c`, `ark_addr_function()`
> Gate: `tests/run_addr_tests.py` (`make test-addr`), plus the whole
> `tests/arm_exec` corpus
> Switch: `-fopt-addr` / `-fno-opt-addr`, INI `opt-addr=` / `addr=`

---

## 1. Why, and at which layer

The ARM backend of `arkc` is a **stack machine**: every intermediate value lands
in a "current register", and an address is an ordinary computed value. So one
`p->y[i]` comes out as

```asm
MOV  r0, r5            ; move the base out of the value-stack pool
ADD  r0, r0, r1        ; + index
LDR  r0, [r0, #0]      ; *(base + index)
```

ARMv7-M already has `[Rn, Rm, LSL #n]`, `[Rn, #imm]!` and `[Rn], #imm`, so the
three lines above are one `LDR r0, [r5, r1]`. What is saved is **instruction
count** (fetch, decode and issue all cost time), not bytes: `LDR r0,[r5,r1]` and
`LDR r0,[r0,#0]` are both 16 bits.

The layer is the same one `-fopt-vstack` uses: a **per-function text rewrite
after emission**, not address-mode selection on the IR. Same reason as well --
doing it on the IR would touch irgen/irser/MIR and all four backends, whereas at
the text layer anything unrecognised is left alone, so **the worst case is a
missed fold, never a wrong instruction**.

## 2. The three rules

The pass scans the assembly lines of a function. `RB` = base register,
`RI` = index register, `Rt` = data register.

| Rule | Original | Rewritten | Note |
| --- | --- | --- | --- |
| **R1** | `ADD RD, RB, #imm`<br>`mem Rt, [RD(, #off)]` | `mem Rt, [RB, #imm+off]` | fold an immediate offset, drop `ADD` |
| **R2** | `ADD RD, RB, RI[, LSL #n]`<br>`mem Rt, [RD]` (`off` must be 0) | `mem Rt, [RB, RI[, LSL #n]]` | fold a register index, drop `ADD` |
| **R3** | `MOV RB, RS`<br>`mem Rt, [RB(, #off / , RI)]` | `mem Rt, [RS(, …)]` | drop the copy that puts the base in a low register |

R1/R2 are **address-arithmetic folding**, R3 is **copy elimination**. Every rule
rewrites one line and deletes one line; none of them introduces an instruction.

R3 is usually **pulled in by R1/R2**: `MOV r0, r5` and `ADD r0, r0, r1` are
separated by other lines until the fold deletes the `ADD`, and then the next
round sees them adjacent. Hence the fixed point runs up to 6 rounds (measured:
1-3 per function with `-fopt-addr`).

The shift in R2 is only legal for `LDR/STR` (`LDRB/LDRH/STRB/STRH` allow only
`LSL #0` for a register index in Thumb); `ad_access()` decides that from a
mnemonic whitelist.

## 3. Safety: when the `ADD` may be deleted

An `ADD` may be deleted only if **nothing needs the value it produced**. Two
criteria:

1. **`ad_dead_after(nex+1, RD)`**: scan forward from the next line (at most 64
   lines); if, before hitting a label, `B`/`Bcc`/`BX`/`BL`, `IT`, or any line
   that **writes** `RD`, no line **reads** `RD`, the value is dead. Reaching a
   boundary counts as "still live" (conservative).
2. **"eaten by the address" exemption**: in `ADD RD, RB, #imm` followed by
   `LDR RD, [RD, #off]` the value written by `ADD` is consumed **only** by the
   address part of that load (same register as `Rd`, address first, write-back
   after), so the fold is safe unconditionally and `ad_dead_after` is not needed.

Criterion 2 holds for **loads only**: in `STR r0, [r0]` the r0 on the address
side is a base and the r0 on the data side is the value being stored; folding
them would emit a wrong instruction. Hence the exemption requires
`mdst == RD && ad_is_load(mn)`.

In practice criterion 2 is where most of the win comes from: with criterion 1
alone the HAL corpus loses 484 instructions; with criterion 2 as well it loses
1,369.

## 4. Never folded

| Case | Reason |
| --- | --- |
| conditional instructions, `IT`-block members | merging two conditional instructions breaks the `IT` mask |
| flag-setting forms (`ADDS`/`MOVS`) | deleting them drops the flags, which `ad_dead_after` does not model; only exact `ADD`/`MOV` are matched |
| across a label / branch / call | `ad_dead_after` stops there and reports "live" |
| an unknown mnemonic that mentions the register | `ad_rw()` treats anything it cannot classify as "reads and writes everything": rather miss a fold |

The single exception is the barriers: `DMB`/`DSB`/`ISB` have no register operand,
so `ad_dead_after` steps over them. This came out of measurement -- three
`volatile` accesses in the HAL corpus look like

```asm
ADD r0, r0, r1
LDR r5, [r0, #0]
DMB SY
STR r5, [r6, #0]
```

Without the barrier opening those three never fold and the residue count sticks
at 3; with it the count is 0.

The fixed-point iteration runs at most 6 rounds (a fold can expose a new
adjacency). `AD_MAX_OP 6 / AD_OPLEN 96 / AD_MAX_REG 16 / AD_SCAN_MAX 64` are the
only limits; nothing is allocated dynamically.

Functions with no `MOV r6, sp` (`__naked`, hand-written runtime helpers) degrade
to "start after the first label"; if even that is missing (`pro_end < 0`) the
whole function is left alone.

## 5. Three things deliberately not done

| Not done | Reason |
| --- | --- |
| both write-back forms (`[Rn, #imm]!`, `[Rn], #imm`) | this emitter **never produces** either shape: `p++` stores the incremented pointer back into its frame slot (`MOV r0, #4` / `ADD r0, r0, r1` / `STR r0, [r6, #0]`), so there is no `ADD base, base, #imm` to fold. Measured 0 in the whole HAL corpus; the only two in the object sit in the hand-written `__arkcc_mcpy` runtime helper, which this pass never visits. A rule for them would be dead code, so it is not written |
| `LDRD`/`STRD` pairing | frame slots are 8 bytes apart and require an even register pair plus 8-byte alignment; the assembler accepts these two only on the `--asm-extra` path |
| merging independent `LDR`/`STR` into `LDM`/`STM` | AC5 does not do it either (see the negative reading in `08-backend-passes.md` §3.3); the win has to be measured on silicon first |
| cosmetic `[r6, #0]` → `[r6]` | saves no bytes, only adds diff noise |

## 6. Measurements

Counts are the number of non-directive, non-label lines in the `.s`.

| Corpus | `-fopt-vstack` | plus `-fopt-addr` | Change |
| --- | --- | --- | --- |
| STM32F4 HAL (`examples/ark_test/ark_test_all.c`, `-O2 -mcpu Cortex-M4`) | 38,004 instructions | 36,553 instructions | **−1,451 (−3.82%)** |
| same, "`ADD` immediately followed by an access through that register" | 1,075 | **0** | all folded by R2 |
| same, "`MOV` immediately followed by an access through that register" | 0 | 0 | nothing foldable |

The residual detector only recognises the adjacent shape "`ADD` then one `[rD]`
with no offset", so 1,075 is a **lower bound for the register-index form**. The
total reduction of 1,451 is larger; the remainder was not attributed rule by rule,
so no claim is made about it. The baseline is the 38,004 instructions **after**
`-fopt-vstack` (the crossing version, third slot included), not the 47,885 of
plain `-O2`; do not mix the two.

The HAL corpus is a floor for this layer, not a ceiling: it is almost entirely
short functions such as `HAL_GPIO_WritePin` plus register writes, with little
pointer walking. Pointer-heavy code (linked lists, arrays of structs, parsers)
gains more.

## 7. What the gate says

`make test-addr` (`tests/run_addr_tests.py`) runs **four arms** per fixture: no
flags at all (`base`, the only honest size baseline), `-fopt-vstack` only
(`off`), `-fopt-addr` only (`on`), and both (`both`).

1. **OFF IS OFF**: the assembly text and the image of `-fopt-vstack` and of
   `-fopt-vstack -fno-opt-addr` are **byte-identical** -- a default build cannot
   see this pass at all.
2. **IT PAYS**: `both` has fewer instructions than `off`, `on` has fewer than
   `base`, and `array`/`struct`/`walk` show `[rX, rY]` index forms.
3. **NO RESIDUE**: in `on` and `both` the three local shapes ("`ADD` then an
   access through that register", immediate and register forms, and "`MOV rX,
   rY` then an access through rX") must be **0**. This is much stronger than
   "the count goes down": a rule that folds only the first two pairs of a
   function passes a count-based check.
4. **EVERY OPERAND IS STILL AN OPERAND**: every rewritten memory operand is
   validated against `MEMOP_RE`, catching malformed shapes such as
   `[r1, #1], #1` (offset printed twice).
5. **SAME ANSWER**: the `array` / `struct` / `walk` / `diff` fixtures return the
   Python-computed expectation on **all four arms**.
6. **CROPPED OUT**: a `-DARKCC_FEATURE_OPT_ADDR=0` build refuses `-fopt-addr`
   with `C3900U` and still compiles normally without the flag.

The size assertion compares against the **honest baseline**: `on <= base` and
`both <= off`. An earlier version compared `on` with `off` and reported "grows by
78 bytes" -- that was comparing it with an image `-fopt-vstack` had already
shrunk, not the pass getting fatter.

On top of that the whole ARM execution corpus is run every time:

```
tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-addr"
tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-vstack -fopt-addr"
```

Both report 0 failures. Checks 3/4 and this corpus are not optional: the real
defects hit during development (`ad_memop2` parsing the whole `rD, [rB, #off]`
as if it were `[...]`, so nothing folded at all; `ad_mem_line` printing the
write-back offset twice, producing `[r1, #1], #1`) were caught by exactly these.

## 8. Trimming

`ARKCC_FEATURE_OPT_ADDR` in `include/arkcc_config.h`: 0 under
`ARKCC_PROFILE_STM32_MIN`, 1 for host/cross builds. When 0 the whole
`ark_addr_function()` block is preprocessed away and `src/main.c` refuses the
flag with `C3900U: -fopt-addr is not compiled into this build` (refused, not
silently ignored). Measured: a `-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN` build
compiles cleanly, refuses `-fopt-addr`, and behaves unchanged without it.

At run time the pass is **off** by default (`g_config.enable_opt_addr = 0`), so a
build without the flag is byte-identical to 0.9.0.

## 9. Pass order

```
ark_vstack_function()      # shorten the function first, drop PUSH/POP
ark_addr_function()        # then see which ADD/MOV can fold into an operand
ark_regalloc_function()    # allocate registers on the shorter stream
ark_fix_far_offset()       # finally handle far offsets
```

Two reasons for the order:

- **after `vstack`**: vstack first deletes the `PUSH/POP`s and keeps values in
  pool registers, so fewer instructions separate `MOV r0, r5` from the access
  and the adjacency R1/R2/R3 need is more often there. Folding first would leave
  vstack rewriting those lines afterwards, and the fold would no longer be the
  final shape.
- **before `regalloc`**: once regalloc has pinned values to fixed registers,
  "is this `ADD`'s value still live" is harder to prove, because
  `ad_dead_after` sees post-allocation numbering.

Those two are design reasons, not a four-way measured comparison -- that
comparison was not run, so no "the order is worth N instructions" number is
claimed here.

**Relation to `-fopt-strength`**: after R2 folds, the shape

```asm
LSL  r1, r1, #2      ; -fopt-strength turned index * 4 into this
LDR  r0, [r4, r1]    ; R2 already removed the ADD, so the shift is adjacent
```

leaves the shift right next to the access, which is exactly what the second half
of `-fopt-strength` (R4) merges into a single `LDR r0, [r4, r1, LSL #2]`. So addr
does not own that merge: it only deletes the `ADD` and exposes the shape. The
merge belongs to strength, because strength is what emitted the shift. **addr on
its own is unchanged** (`-fopt-vstack -fopt-addr` still measures 36,553 on this
corpus, byte-for-byte what it was before R4).

There is also one liveness fix shared with R1-R3: `ad_rw()` used to put `PUSH`
and `POP` in the same branch and count `POP`'s operands as reads, so `POP {r1}`
kept r1 alive forever and `ad_dead_after()` would never call it dead. The two
branches are now split and `POP` counts as a write. This does not change addr's
own instruction count on this corpus, but it is a prerequisite for R1-R4 alike.

## 10. Known cost

The 64-line forward-scan cap in `ad_dead_after` means that if the intermediate
register is used more than 64 instructions later, the fold is dropped. That is
the other side of "rather miss than be wrong".
