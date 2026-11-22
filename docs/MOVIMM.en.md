# One instruction per constant

English | [中文](MOVIMM.md)

> In one sentence: the old path emitted `MOVW` + `MOVT` for **every constant above
> 255**, and one of those two was always pure waste -- `MOVT rd, #0` cannot change a
> single bit, because `MOVW (immediate)` T3 zero-fills bits[31:16] (ARM ARM). Choosing
> the shortest form per value range took the same 95-translation-unit HAL corpus at
> `-O2` from **51,416 instructions / 116,380 bytes** down to
> **50,965 / 114,576** (**-451 instructions / -0.88%**, **-1,804 bytes / -1.55%**).
>
> Implementation: `src/backend/arm/backend_arm.c` -> `emit_mov_imm()`, at emission
> time; it writes assembly text and runs no pass
> Gate: `tests/run_movimm_tests.py` (`make test-movimm`, 20 checks)
> Switch: **none**. This is not an optimisation experiment, it is fixing something
> that was wrong, so `-O0`, `-O2` and every profile take the same path, and the board
> benefits exactly like the host.

---

## 1. What was wrong with the old shape

```asm
    MOVW r0, #20000          ; low half
    MOVT r0, #0              ; this one always writes 0 and is never needed
```

The old comment claimed the opposite: "MOVW only sets bits[15:0]; without MOVT,
bits[31:16] retain stale values from previous operations, causing incorrect
constants (e.g. 0x40022000 instead of 0x00002000 for `1u << 13`)." The causality is
backwards -- `MOVW` writes the low half and **zero-fills bits[31:16]**, it retains
nothing. The real source of that 0x40022000 was a *later* `MOVT` overwriting the high
half, not garbage left behind by `MOVW`.

So the old code over-paid on three classes of constants:

| constant | old shape | waste |
|---|---|---|
| `20000` (fits 16 bits) | `MOVW` + `MOVT #0` | 1 instruction |
| `1u << 29` = `0x20000000` (modified immediate) | `MOVW #0` + `MOVT #0x2000` | 1 instruction |
| `0x00FFFFFF` (complementable) | `MOVW #0xFFFF` + `MOVT #0` | 1 instruction |

Those three classes occur 192, 258 and 1 times, respectively, in the HAL corpus:
**451 instructions**, matching the measurement in section 5 exactly.

## 2. Five tiers

`emit_mov_imm(b, rd, imm)` tries the value ranges top to bottom; the first form that
carries the whole value wins:

| range | form | width | flags |
|---|---|---|---|
| `0..255` | `MOV rd, #imm` (16-bit `MOVS` for r0-r7, `MOVW` for r8-r15) | 2 / 4 | r0-r7 **set NZ**; `MOVW` sets nothing |
| `<= 0xFFFF` | `MOVW rd, #imm` | 4 | nothing |
| ThumbExpandImm-encodable | `MOV.W rd, #imm` | 4 | nothing (`S = 0`) |
| `~v` ThumbExpandImm-encodable | `MVN rd, #~v` | 4 | nothing |
| otherwise | `MOVW` + `MOVT` | 8 | nothing |

Two rules are frozen:

1. **`0..255` still goes through the 16-bit `MOVS` and therefore still sets the
   flags.** That is bit-for-bit the old behaviour, so no existing caller sees a
   different flag state; a non-setting variant would have to be a separate path.
2. **The other four tiers set no flags at all**, exactly like the `MOVW`+`MOVT` pair
   they replace.

One mnemonic, one meaning: this function only carries "write this 32-bit value into
`rd`". It does not pick a register, it does not fold the next instruction (that is
`-fopt-live`'s L4), and it does not fold into an arithmetic immediate field (that is
`-fopt-imm`).

## 3. Both passes have to agree

The assembler runs twice: pass 1 only accumulates instruction widths to place labels
and branch offsets, pass 2 does the encoding. Both must decide the same width for the
same line, or every address after that line is wrong.

The selection rule is written with the same condition on both sides:

```c
pc += (rd1 >= 0 && rd1 <= 7 && u1 <= 255u) ? 2 : 4;   /* pass 1 */
```

```c
if (rd >= 0 && rd <= 7 && u <= 255u)  { /* 16-bit MOVS */ }
else if (u <= 0xFFFFu)                { /* MOVW        */ }
else if (thumb_imm12_a(u, ...))       { /* MOV.W       */ }
else if (thumb_imm12_a(~u, ...))      { /* MVN         */ }
else                                  { /* MOVW+MOVT   */ }
```

`MOV.W` and `MVN` are both four bytes, a width `logic_dp_a()` reports from a single
place, and pass 1 calls that same function, so those two tiers cannot disagree.

This also removed one piece of undefined behaviour: the new path prints wide values
as 32-bit hex (`MOV r0, #0xFF000000`, `MVN r0, #0x000000FF`), while the old
`parse_imm_a()` accumulated into a signed `int` -- anything at or above `0x80000000`
is integer overflow and only "happened" to yield the right bit pattern through
two's-complement wraparound. The unsigned `parse_imm_u32_a()` no longer depends on
wraparound. (This is latent-defect cleanup, not an observed wrong output; the
measurements are in section 5.)

## 4. Encoding on the assembler side

- **`MOV.W rd, #imm`** (modified immediate): `11110 i 0 0010 0 S 1111 | 0 imm3 Rd imm8`
  with `S = 0`. The `S = 0` is deliberate: the 16-bit `MOVS` is UNPREDICTABLE inside
  an IT block, while `MOV.W` with `S = 0` is safe there.
- **`MVN rd, #imm`**: there is no standalone `MVN (immediate)` encoding; it is
  `ORN (immediate)` with `Rn = 1111` (measured with GAS: `mvn r0, #1` gives
  `f06f 0001`). The assembly text prints **the number being complemented**, with its
  high bit clear: materialising `0xFFFFFF00` reads `MVN r0, #0x000000FF`, which is
  what a human and armasm expect to see.
- **Out of range is never truncated**: when a `MOV` immediate is neither a 16-bit
  value nor a modified immediate, the compiler reports a hard error ("MOV immediate is
  out of range (a 16-bit value or a modified immediate)") and falls back to `MOVW #0`
  instead of silently truncating. That is the "rather an error than a wrong answer"
  rule.

## 5. Measurement

To keep the accounting clean the baseline is not a historical reading: HEAD's
`backend_arm.c` was taken out on its own and compiled against the current rest of the
tree into `arkcc_head.exe`, and both binaries ran the same 95 translation units with
the same flags (`-target arm -mcpu Cortex-M4 -O2 --reloc-data`):

| arm | instructions | code bytes |
|---|---|---|
| HEAD backend | 51,416 | 116,380 |
| current | **50,965** | **114,576** |
| delta | **-451 / -0.88%** | **-1,804 B / -1.55%** |

A shape census over the same corpus at `-O2` splits the 451 exactly:

| shape | HEAD | current | saved |
|---|---|---|---|
| `MOVW` | 1,432 | 1,173 | -- |
| `MOVT` | 1,432 | 981 | -- |
| of which pairs (`MOVW`+`MOVT`) | 1,432 | 981 | -- |
| standalone `MOVW` (16-bit value) | 0 | 192 | -192 |
| `MOV.W` (modified immediate) | 0 | 258 | -258 |
| `MVN` (complement) | 0 | 1 | -1 |
| remaining `MOVT rd, #0` | 1,432 | 29 | -- |

- 192 + 258 + 1 = **451**, matching the table above exactly.
- The remaining 29 `MOVT rd, #0` lines are **not** waste: every one of them follows an
  `.arkdatasym`, i.e. it is a `--reloc-data` relocation pair whose two instructions the
  linker patches with an address. They must stay.
- Because no switch is involved, the `-O2` row moves even with every `-fopt-*` off, and
  the all-ten-switches row moves with it; the authoritative step-by-step chain is
  `docs/COMPARISON.md` section 5 (current end point: 21,300 instructions / 50,648 bytes).

## 6. Gate: `tests/run_movimm_tests.py` (20 checks)

The fixture is seven one-line functions (`c_255`, `c_ffff`, `c_imm`, `c_mvn`,
`c_pair`, `c_all`, `c_mvn2`), each returning one constant, plus a `main` that adds
them up:

1. **Three checks per constant class** (15 in total): the function was really emitted,
   the target mnemonic and immediate match exactly, and **no wider form** appears. For
   example `c_255` requires `MOV r0, #255` with no `MOVW`/`MOVT`/`MVN` anywhere in the
   body, and `c_ffff` requires a single `MOVW r0, #65535` with no `MOVT`.
2. **`c_pair`'s high half is `MOVT`**: a truly wide value is still a pair, so the new
   path did not break the fallback.
3. **`-O0` takes the same path**: at `-O0`, `c_ffff` is still a single `MOVW` with no
   `MOVT`.
4. **Two self-checks**: the fixture really emits `MOVW` and `MOVT`. Counting is limited
   to the **bodies of the seven fixture functions**, so it cannot be satisfied by the
   prologue (function prologues emit `MOVW` too, which is why a whole-file count would
   be measuring the prologue instead). These two exist to prove the fixture covers both
   mnemonics; they deliberately do not pin an exact count, since that would break every
   time the prologue changes.
5. **Bit-for-bit answers**: the fixture is built into an image, run on unicorn, and the
   seven constants must add up to `1`. This is the real conclusion gate -- a right shape
   does not imply a right value.

## 7. Where this ends and `-fopt-imm` begins

Both sound like "do not spend instructions on constants", but they work on different
layers:

| | `-fopt-imm` (`docs/IMM_FOLD.md`) | this document (`emit_mov_imm`) |
|---|---|---|
| what it fixes | a `PUSH k` immediately followed by arithmetic/comparison becomes an immediate field | **how a constant gets into a register** |
| layer | an emission-time pass after the IR, behind a switch | basic correctness of the emitter, no pass, no switch |
| when off | byte-for-byte identical to the switch not existing | there is no "off" |
| on the board | on by default | always on |

Precisely because it has no switch, it also improves `-O0`/`-O2` with every `-fopt-*`
off: a board profile that can only afford a small custom feature set still keeps this
gain.
