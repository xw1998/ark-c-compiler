# Value stack -> register allocation (`-fopt-vstack`)

[中文](RA_VSTACK.md) | English

> The fourth optimisation block of 0.9.1. One sentence: **the ARM backend evaluates expressions by
> `PUSH`ing every intermediate value to the stack and `POP`ping it back; this pass keeps those
> values in r5/r7 instead, falling back to memory only when one value genuinely has to exist twice
> on the stack or the two-slot pool runs dry.**
>
> Where: `src/backend/arm/backend_arm.c`, `ark_vstack_function()`
> Gate: `tests/run_vstack_tests.py` (`make test-vstack`) plus the whole `tests/arm_exec` corpus
> Switch: `-fopt-vstack` / `-fno-opt-vstack`, INI `opt-vstack=` / `vstack=`

---

## 1. Why do it, and at which layer

The ARM backend emits like a **stack machine**: evaluating a binary expression left to right, it
`PUSH {r0}` after the first subexpression and `POP {r1}` / `POP {r0}` around the second. That shape
is **correct by construction** (no register conflicts to reason about) and costs two memory
accesses per intermediate value.

Three possible places to intervene:

| Layer | Cost | Verdict |
| --- | --- | --- |
| SSA + graph colouring on the IR | touches irgen / irser / MIR / four backends | a high-risk rewrite inside a 10k-line backend, not done |
| Maintain the value stack while emitting | would require rewriting the whole `gen_expr` recursion | a recursive emitter cannot "look ahead before writing", not done |
| **Function-level text rebuild after emission** | all-or-nothing; worst case one function stays byte-identical | **this pass** |

The third one wins because it is **"fail rather than answer wrong"** by construction: anything the
pass does not recognise makes the whole function come out exactly as it went in. It is the same
pattern as the existing `ark_regalloc_function()` (per function, bail-out, gate-able).

## 2. The shadow value stack

The pass makes one sweep over the function's assembly lines and maintains a **shadow value stack**:

```
skind[depth]  = 0 for a value that really sits in memory, 1 for a value in the pool
spool[depth]  = pool slot number (valid when skind == 1)
pend[r]       = which pool slot currently holds register r's *logical* value (-1 = none)
pref[p]       = reference count of slot p (stack entries and pend mappings each count once)
pbusy[p]      = derived: is slot p taken (kept around to find a free one quickly)
```

The important point: when `pend[r] >= 0`, **register r may not physically hold that value at
all** -- a `POP {r0}` from a register slot only records "r0's semantic value is pool slot p" and
emits no instruction. Every later use of r0 must therefore be rewritten, and that is where all the
difficulty of this pass comes from.

## 3. Why the pool is exactly r5/r7

| Candidate | Why not |
| --- | --- |
| r0-r3 | caller-saved; the value dies across `BL`, turning the win into a bug |
| r4 | would make `sp` misaligned to 8 bytes mid-function (AAPCS), breaking floats and `ldrd` |
| r5, r7 | the prologue already does `PUSH {r5, r6, r7, lr}` => **zero frame change**; callee-saved => valid across `BL` |
| r8-r11 | usable, but in this encoding they only have 32-bit forms, so instructions get bigger, fighting the P6 size weights |

If the function body already mentions r5 or r7, the survey drops that register from the pool
(better a smaller win than a changed meaning).

## 4. The four rewrite rules

| Input | Rewrite | Condition |
| --- | --- | --- |
| `PUSH {rN}` with a free slot | **retarget the previous producer's destination register** to the pool slot, or add `MOV p, rN` | the producer only writes its destination (`wmask[0] && !rmask[0]`), `last_dest == rN`, and nothing reads rN before it is next written |
| `PUSH {rN}` with `pend[rN] >= 0` | emit nothing; push the same slot onto the shadow stack again | -- |
| `POP {rN}` with a register slot on top | emit nothing; record `pend[rN] = p` | -- |
| a consumer that only reads an operand | rewrite `rN` in that operand text to the pool register name | that operand has `rmask && !wmask` |

### 4.1 The three shapes that must be materialised first

Textual substitution is not enough; in these three shapes the pool slot is the **only copy**, so a
plain substitution would leave the consumer's result in the wrong register:

1. **Read and written in the same operand**: `LDR r0, [r0, #0]` -- must `MOV r0, p` first.
2. **Read in one operand, written in another**: `ADD r0, r0, r1` -- must `MOV r0, p`, otherwise it
   becomes `ADD r7, r0, r7` with an entirely different meaning (really happened: a 64-bit multiply
   returned 0 unconditionally).
3. **In-place three-operand forms**: the 16-bit `ADC`/`SBC`/`MUL` shapes require `Rd == Rn`, so
   `vs_is_inplace3()` forces `MOV rN, p` (really happened: the assembler rejected
   `ADC r1, r1, r7` with three distinct registers).

### 4.2 Reference counting: why a slot cannot be returned on first use

One pool slot can be referenced from **several** places at once: a shadow-stack entry, the `pend`
mapping a `PUSH` left behind, the `pend` mapping a `POP` created. Returning the slot to the pool
after the first consumer would hand the second one somebody else's value.

The canonical case is the return-and-store sequence of a 5..8-byte struct (`POP r0; PUSH r0;
PUSH r0` -- the same word must appear twice on the stack). `pref[p]` counts every reference and
the slot is only freed at zero; `vs_ref_add()` / `vs_ref_rel()` are the only entry points.

## 5. Safety rails: any hit leaves the whole function untouched

- an unknown mnemonic with a register token (`vs_form()` returns `VS_F_UNKNOWN`)
- `[sp` appears in the body, or `sp` is used as an operand
- multi-register `PUSH`/`POP` (except the prologue's `PUSH {r5,r6,r7,lr}` and the epilogue's `POP {..,pc}`)
- at a label / `B` / `Bcc` / `BX` / `BL` / `IT`: the shadow stack or the memory stack is not empty
- `MOV sp, r6` with a non-empty shadow stack

Whatever `pend` mappings are still alive at those boundaries are materialised by `vs_flush_all()`
with `MOV rN, p` before being dropped (a conditional instruction before `IT` may not execute, so
everything is materialised unconditionally).

`MOVW`/`MOVT` are **never retargeted**: the pair builds one value in one register, and rewriting
only the second half leaves `0xFFFF` in the low half (really happened: `__aeabi_lmul(-3, 7)`
returned 0).

## 6. One peephole

Before the rebuild there is a **strictly adjacent pair** elimination: `PUSH {rN}` immediately
followed by `POP {rN}` deletes both. It is a single pass (no re-pairing after a deletion), so it
only eats pairs that were already adjacent.

## 7. Measurements

| Corpus | off | on | change |
| --- | --- | --- | --- |
| `bench_opt/bench1.c` (18 small embedded functions, Cortex-M4, `-O2`) | 1024 insns | 813 insns | **-20.6%** |
| arith fixture, instructions | 171 | 137 | -19% |
| same, `PUSH`/`POP` count | 88 | 36 | -59% |
| same, image bytes | 1392 | 1324 | -4.9% |
| loop fixture, instructions | 203 | 152 | -25% |
| same, `PUSH`/`POP` count | 100 | 28 | -72% |
| struct fixture, image bytes | 1400 | 1308 | -6.6% |
| variadic fixture, image bytes | 1556 | 1542 | -0.9% |

**The image never grows** is a hard criterion (asserted fixture by fixture in
`tests/run_vstack_tests.py`): retargeting and substitution each express the same work in fewer or
equal bytes.

## 8. What the gate actually says

`make test-vstack` (21 checks):

- **the default build ignores the pass**: `-O2` and `-O2 -fno-opt-vstack` objects are byte-identical (1392/1392);
- **it really saves**: instruction and `PUSH`/`POP` counts drop, the image does not grow;
- **no rewritten function keeps a lone PUSH/POP pair** (asserted per function, `leftovers none`);
- **the answer is the same**: arith / loop / struct / variadic return 73 / 85 / 12 / 24 identically
  from the off, the on and the on+regalloc builds;
- **it can be cropped**: a `-DARKCC_FEATURE_OPT_VSTACK=0` build refuses `-fopt-vstack` with
  `C3900U`, and still compiles without the flag.

Every change also runs the **whole ARM execution corpus**:
`tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-vstack"` -- 36 cases, 0
failures. That one is not optional: **all five** semantic defects this pass ever had (cross-operand
read+write, same-operand read+write, releasing a slot after a read-only use, half-retargeting
`MOVW`/`MOVT`, and `PUSH`ing a stale register twice) were found by it. Fixture-by-fixture byte
comparison sees none of them.

## 9. Cropping

`ARKCC_FEATURE_OPT_VSTACK` in `include/arkcc_config.h`: 0 under `ARKCC_PROFILE_STM32_MIN`, 1 on the
host. At 0 the whole of `ark_vstack_function()` is preprocessed away and `src/main.c` rejects the
flag with `C3900U: -fopt-vstack is not compiled into this build` (rejects rather than silently
ignoring). The runtime default is **off** (`g_config.enable_opt_vstack = 0`), so output without the
flag is byte-identical to 0.9.0.

## 10. Known cost

The pool has two slots and a live `pend` mapping pins its slot; when the pool runs dry the pass
falls back to a real `PUSH`. So it is **friendly to chained evaluation** and tends to zero on
register-hungry expressions -- but it never produces worse code than the original sequence, which
is the line the "image never grows" criterion guards.