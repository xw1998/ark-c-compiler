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
| r4 | unused before, because it would make `sp` misaligned to 8 bytes mid-function (AAPCS), breaking floats and `ldrd`; now used **conditionally** as a third slot, see 3.1 |
| r5, r7 | the prologue already does `PUSH {r5, r6, r7, lr}` => **zero frame change**; callee-saved => valid across `BL` |
| r8-r11 | usable, but in this encoding they only have 32-bit forms, so instructions get bigger, fighting the P6 size weights |

If the function body already mentions r5 or r7, the survey drops that register from the pool
(better a smaller win than a changed meaning).

### 3.1 r4 as a third slot (conditional)

When two slots cannot hold three simultaneously live values, the third one falls back to a real
`PUSH`.  r4 is callee-saved and this code generator **never uses it** (`ark_regalloc_function()`
only goes up from r8), so it can be the third slot -- provided the cost is paid honestly:

- **Gate**: the survey simulates the shadow depth and records the **peak number of values held on
  the machine stack at once** (`sdmax`; a `BL` resets it, because a call consumes its argument
  pushes).  r4 is only taken when `sdmax >= 3`: a function that never goes deeper than two saves
  not one instruction, so an extra saved register is a pure loss.  In a HAL count taken before
  crossing was introduced, only 59 of the 203 rewritable functions passed; the other 63 "deep
  enough" functions saved exactly -- 0 instructions each, so the gate is not a conservative guess
  but a measurement.  (Crossing changes which functions reach the pass, so this count only answers
  "should the gate exist at all"; it is not meant to be added to the later totals.)
- **The frame has to grow by one word**: `PUSH {r5, r6, r7, lr}` is 16 bytes, adding r4 makes 20,
  so `sp` is 4 (mod 8) and the AAPCS 8-byte alignment is broken on the spot; therefore
  `SUB sp, sp, #N` and `ADD sp, sp, #N` must both become `N+4` (`N` is a multiple of 8 by
  construction, and `frame % 8 == 0` is one of the assertions).
- **All or nothing**: the four lines (prologue, `SUB`, `ADD`, epilogue) are formatted first and only
  replaced once all four allocations succeeded; if any step fails the whole path is abandoned, so
  there is never a "pushed r4 but kept the old frame" half-state.
- **One shape only**: the scan must find exactly one `PUSH {r5, r6, r7, lr}`, exactly one
  `SUB sp, sp, #N` / `ADD sp, sp, #N` pair with the same `N`, exactly one `POP {r5, r6, r7, pc}`,
  and no r4 anywhere in the body.  Functions whose big frame is split into several `SUB`/`ADD`
  pieces (`nsub != 1 || nadd != 1`) fall out automatically.

### 3.2 Frame-less functions (`frame == 0`)

A function with no parameters and no locals gets no frame at all from the code generator: the
prologue is `PUSH {r5, r6, r7, lr}` followed by `MOV r6, sp` (there is no `SUB sp`), and the
epilogue is `MOV sp, r6` followed by `POP {r5, r6, r7, pc}`.  The first r4 implementation in 0.9.1
could not reach them, because the whole path hinged on rewriting `SUB sp, sp, #N` to `#N+4` -- and
there is no `SUB` to rewrite.  In the same pre-crossing HAL count, 81 of the 203 rewritable
functions were frame-less; closing this gap put 28 more functions over the depth threshold (that
count exists to justify the path, not as a figure to quote next to the later totals).

The frame-less path touches three things: `PUSH`/`POP` become five-register forms, and **one**
`SUB sp, sp, #4` is added.

- **No `ADD`.**  The epilogue's `MOV sp, r6` already restores sp to its post-`PUSH` value, so the
  4 padding bytes are simply discarded there.  An `ADD` after it would move sp 4 bytes *above*
  where it started.
- **The `SUB` must sit after `MOV r6, sp`, never before.**  r6 has to hold the post-`PUSH` sp;
  padding before the `MOV` would leave sp 4 bytes below its entry value after the `POP`, so every
  call would leak one word of the caller's stack.  The `VsLine::after` field exists to emit one
  extra line after a chosen one.
- **r6 is no longer a base.**  A frame-less function has no locals, hence no `[r6, #off]`, so
  turning sp into 4 (mod 8) changes no addressing.  Defensively, if the body (`MOV r6, sp` up to
  the epilogue `POP`) still mentions r6 -- the epilogue's `MOV sp, r6` excepted -- the whole path
  is abandoned.

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

## 5. Safety rails: any hit cuts the rewrite at that line

- an unknown mnemonic with a register token (`vs_form()` returns `VS_F_UNKNOWN`)
- `[sp` appears in the body, or `sp` is used as an operand
- multi-register `PUSH`/`POP` (except the prologue's `PUSH {r5,r6,r7,lr}` and the epilogue's `POP {..,pc}`)
- at a label / `B` / `Bcc` / `BX` / `BL` / `IT`: the shadow stack is not empty **and** cannot be
  materialised entirely into memory (§5.1)
- `MOV sp, r6` with a non-empty shadow stack

Whatever `pend` mappings are still alive at those boundaries are materialised by `vs_flush_all()`
with `MOV rN, p` before being dropped (a conditional instruction before `IT` may not execute, so
everything is materialised unconditionally).

**A hit no longer abandons the whole function** (since 0.9.1): it copies everything from that line
to the end of the function through verbatim and keeps the already rewritten prefix; see §5.2.  The
whole function falls back only when the optimised prefix cannot be turned back into the original
machine stack.

`MOVW`/`MOVT` are **never retargeted**: the pair builds one value in one register, and rewriting
only the second half leaves `0xFFFF` in the low half (really happened: `__aeabi_lmul(-3, 7)`
returned 0).

### 5.1 Crossing boundaries when the live values are already in memory

The rule above ("any non-empty stack at a boundary bails the whole function") was too tight: many
functions have already written **every** value back to the machine stack by the time they reach a
label (every shadow-stack entry is `MEM`), so there is no private register convention to protect.
The rule is relaxed as follows -- **cross only when the condition holds, otherwise bail as before**:

1. **A pre-scan tags `cross`**: starting at the function body (`pro_end + 1`), count `PUSH`/`POP`
   as open brackets; on a label / `VS_F_CALL` / `VS_F_BRANCH`, tag every currently **unclosed**
   `PUSH` line with `cross`. This is a lexical approximation (it may over-tag, never under-tag),
   and over-tagging only makes the result more conservative.
2. **A `cross` line emits a real `PUSH`**: while rebuilding, such a line does not keep the value in
   a pool register but emits a genuine `PUSH {r}` (if `pend[r] >= 0` for that slot, it pushes the
   value out of that pool register), then `nmem++` and the slot returns to the pool. **Why**: a value
   still on the shadow stack must physically be in memory -- when several paths rejoin at a label,
   the machine stack has to match the original code word for word, and pool registers cannot be
   reconstructed (the other path does not know what they hold).
3. **Check `vs_all_mem()` at the boundary**: at a label / `CALL` / `BRANCH`, if `depth != 0` or
   `nmem != 0`, only an **entirely `MEM`** shadow stack lets the pass `vs_flush_all()` and then
   **keep optimising the next basic block from an empty register state**; anything else is cut
   per §5.2.  The epilogue (`MOV sp, r6`) is different: the shadow stack is reset to empty and
   optimisation continues -- provided the restore sequence really leaves the function (a `pop`
   containing `pc`, `BX*`, `MOV pc, ...` or a bare `B`); otherwise it stays verbatim per §5.3.
4. **The pre-scan must test the label form before the directive form**: `.L3:` is both a label and
   a line starting with a dot.  The pre-scan once skipped it as `isdot` first, so no `B`/`Bcc`
   target was ever tagged `cross`, the values live across those boundaries were never pinned to
   memory, and 18 HAL functions fell back entirely (a net loss of 2,659 instructions).  The test
   order now matches the rebuild side.

The final check therefore went from "bail if `depth != 0 || nmem != 0`" to
"`bail || (!verbf && (depth != 0 || nmem != 0))`".

Most functions had their values back in memory at the boundary all along; nobody just checked.
Checking is only half of it: the pass now also keeps optimising after the boundary and keeps the
prefix when it later meets a shape it cannot rebuild (§5.2).  Together those two changes save a
further 1,445 instructions on the HAL corpus (37,977 → 36,532, -3.8%): 30 functions change and
none grows.

### 5.2 Keeping the optimised prefix when the pass gives up

Relaxing the boundary is not enough: a few functions still cannot continue past a `POP {ip}`, a
`PUSH` depth overflow or an unparsable instruction.  The old behaviour bailed the whole function
and threw away hundreds of already rewritten instructions -- `HAL_DMA_IRQHandler` ended up 262
instructions *larger* than the untransformed code (the rewritten prologue saved r4 but the gain
was never collected).  The pass now **cuts** instead:

- `vs_cut_shape_ok(skind, depth)` requires the shadow-stack shape to be `00...011...1`, i.e. every
  `MEM` word sits **below** every pool-register word.  Then a single run of `PUSH {pool reg}` in
  shadow-stack order reconstructs the machine stack word for word, with no pop-then-push dance.
- `vs_cut_verbatim()` materialises the pool-resident shadow entries in stack order, then
  `vs_flush_all()` emits the remaining register mappings; from there the line and everything after
  it are copied through verbatim.
- Only when the shape fails (`MEM` and pool words interleaved) does the pass `bail` and emit the
  whole function untouched.

That gives the pass its **never-worse guarantee**: a function can only end up (a) fully rewritten
with fewer or equally many instructions, (b) rewritten up to some line and copied verbatim after
it (the prefix only ever has fewer instructions), or (c) emitted unchanged.  The per-function HAL
diff is therefore "203 functions change, 0 grow".

### 5.3 Per-block resume: `verbf` is no longer a function-wide permanent flag

In the earlier form of §5.1, once a boundary set `verbf`, **everything after it in that
function** was copied through for good -- labels included, and the restore sequence after
`MOV sp, r6` too. There is work left to do there: tracing the whole corpus shows only one site
ever sets `verbf` (the `epi-all` case on `MOV sp, r6`), while the loss is spread over every
instruction after it (1,066 instructions / 2,182 bytes on the ten-switch arm when it landed).

`verbf` now only becomes permanent when the tail cannot be modelled; two places **resume**:

1. **At a label**: the rebuild loop parses first; if the line is a label and `verbf` is not
   stuck, `verbf` is cleared and optimisation continues from an empty register state.
   `vs_cut_verbatim()` has already `PUSH`ed the pool values into the machine stack and flushed
   every mapping, so the machine stack at the label is word-for-word what the unoptimised code
   produces; continuing from "all MEM" is therefore equivalent to the original (the same
   state the `vs_all_mem()` path produces). Materialising a pool entry also sets `skind[k]=0`
   and `nmem++`, i.e. "that word is already in memory".
2. **After an epilogue that really leaves the function**: `MOV sp, <reg>` no longer sets
   `verbf` directly. It does `vs_flush_all` + emit + drain up to the next label, and while
   draining checks whether the restore sequence `leaves` (a `pop` containing `pc`, `BX*`,
   `MOV pc, ...`, a bare `B`). `leaves` => `depth = 0; nmem = 0;` -- the frame is gone, body
   values die with it, and the restore pops the words the prologue saved (never modelled by
   this pass) -- so optimisation continues after the next label. Not `leaves` =>
   `verbf = 1; verbf_stuck = 1`, i.e. stay verbatim.

**The shadow stack is tracked during the verbatim tail** (`vs_tail_track`): a single-register
`PUSH`/`POP` adjusts `depth`/`nmem`; `LDM`/`STM`, any instruction that **writes `sp`** (per the
`vs_masks` write mask), an unknown form (`vs_form() < 0`) or a parse failure => return 0 =>
`verbf_stuck = 1` and the old verbatim behaviour for the rest of the function. This is
conservative: **the worst case is no worse than before**. Even if the shadow stack is off, a
later `POP` hitting `depth <= 0` falls back to `cut_verbatim`, which is fail-safe.

### 5.4 Shadow-stack depth cap: 24 -> 256

`VS_MAX_DEPTH` used to be just **24**: the moment the shadow stack hit the cap the pass took the
`push-deep` cut (the same cut as §5.2) and the whole suffix fell back to verbatim copying. The
clearest HAL case is `HAL_DMAEx_MultiBufferStart_IT`, which hits the cap four times. The cap has
nothing to do with the register pool (that is still r5/r7 plus an optional r4); it only limits
**how many levels the shadow stack can remember**, so hitting it is a modelling limit, not a
resource limit.

Measured per step (95 TUs, all ten switches, instructions / code bytes):

| `VS_MAX_DEPTH` | instructions | code bytes |
| ---: | ---: | ---: |
| 24 (old) | 20,234 | 48,466 |
| 40 | 20,138 | 48,242 |
| 64 | 19,994 | 47,906 |
| 128 | 19,623 | 47,036 |
| **256 (current)** | **19,112** | **45,760** |
| 1024 | 19,068 | 45,662 |

24 -> 256 is **-1,122 instructions / -2,706 bytes**; going on to 1024 buys only 44 / 98 more,
i.e. it has flattened out. 256 it is: three `int` arrays (`skind` / `spool` / `open`) of 256
entries each, about 3 KB of **host** stack. The on-board profile crops the whole pass (§9), so
it costs the MCU nothing.

## 6. One peephole

Before the rebuild there is a **strictly adjacent pair** elimination: `PUSH {rN}` immediately
followed by `POP {rN}` deletes both. It is a single pass (no re-pairing after a deletion), so it
only eats pairs that were already adjacent.

## 7. Measurements

| Corpus | off | on | change |
| --- | --- | --- | --- |
| STM32F4 HAL (`examples/ark_test/ark_test_all.c`, `-O2 -mcpu Cortex-M4`, non-directive non-label lines) | 47,449 insns | 33,284 insns (third slot, crossing, per-block resume, a 256-deep shadow stack and cut-prefix included) | **-29.85%** |
| same corpus, `-fopt-addr` on top of vstack (see `docs/ADDR_FOLD.md`) | 33,284 insns | 31,218 insns | -6.21% |
| same corpus, `-fopt-strength` on top (see `docs/STRENGTH.en.md`) | 31,218 insns | 29,204 insns | -6.45% |
| arith fixture, instructions | 170 | 120 | -29% |
| same, `PUSH`/`POP` count | 88 | 12 | -86% |
| same, image bytes | 1,388 | 1,288 | -7.2% |
| loop fixture, instructions | 200 | 137 | -31% |
| same, `PUSH`/`POP` count | 100 | 12 | -88% |
| same, image bytes | 1,468 | 1,342 | -8.6% |
| struct fixture, image bytes | 1,396 | 1,290 | -7.6% |
| variadic fixture, image bytes | 1,552 | 1,418 | -8.6% |
| deep fixture (three nested levels), image bytes | 1,380 | 1,350 | -2.2% |
| shallow fixture (`a + b`), image bytes | 1,270 | 1,220 | -3.9% |
| branch fixture (resume past a label), instructions / `PUSH`/`POP` | 151 / 74 | 115 / 18 | -23% / -76% |
| callptr fixture (`POP {ip}` cut-prefix), instructions / `PUSH`/`POP` | 157 / 78 | 126 / 30 | -19% / -62% |
| retpaths fixture (multiple return paths), instructions / `PUSH`/`POP` | 218 / 118 | 147 / 20 | -32% / -83% |

The HAL row is the only reproducible headline (the corpus is in the repo, command at the end of
this section); the `bench_opt/bench1.c` figures quoted earlier came from a temporary corpus in an
old session that is **not in this repository**, so they are no longer listed as evidence.

**The image never grows** is a hard criterion (asserted fixture by fixture in
`tests/run_vstack_tests.py`): retargeting and substitution each express the same work in fewer or
equal bytes.

The command behind the HAL row (from the repository root):

```
./arkcc.exe -target arm -S -O2 -mcpu Cortex-M4 -D STM32F401xE \
  -I examples/ark_test \
  -I examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Inc \
  -I examples/ark_test/Core/Inc \
  -I examples/ark_test/Drivers/CMSIS/Device/ST/STM32F4xx/Include \
  -I examples/ark_test/Drivers/CMSIS/Core/Include \
  -I include -I src -I stdlib/include -D USE_HAL_DRIVER \
  examples/ark_test/ark_test_all.c -o hal.s
# count lines that are neither '.' directives/labels nor ':' label lines
```

Run it once more with `-fopt-vstack`; the difference between the two counts is the -29.85% in the
table.  With `-fopt-vstack -fopt-addr` it is 31,218, and with all three flags (adding
`-fopt-strength`) it is 29,204.  The r4 third slot, crossing, per-block resume, the shadow-stack
cap and the cut-prefix are all internal to the pass, so 33,284 is what that same `-fopt-vstack`
command produces.  The per-function diff (functions split on `name:`, 208 shared functions) shows
**203 functions changing and none growing**: the biggest drops are
`HAL_DMAEx_MultiBufferStart_IT` 9,266 -> 7,057, `HAL_RCC_OscConfig` 4,902 -> 3,742,
`HAL_GPIO_Init` 1,560 -> 999 and `HAL_DMA_IRQHandler` 2,518 -> 2,055.  The byte accounting for the r4 third slot and the frame-less
`SUB sp, sp, #4` was measured when those features landed (see 3.1 / 3.2) and was not re-measured
here.

## 8. What the gate actually says

`make test-vstack` (53 checks):

- **the default build ignores the pass**: `-O2` and `-O2 -fno-opt-vstack` objects are byte-identical (1392/1392);
- **it really saves**: instruction and `PUSH`/`POP` counts drop, the image does not grow;
- **no rewritten function keeps a lone PUSH/POP pair** (asserted per function, `leftovers none`);
- **the answer is the same**: arith / loop / struct / variadic return 73 / 85 / 12 / 24 identically
  from the off, the on and the on+regalloc builds;
- **the third slot is asked for, not assumed**: the `deep` fixture (three nested levels) must show
  `PUSH {r4, r5, r6, r7, lr}` / `POP {r4, r5, r6, r7, pc}` and a frame `SUB sp, sp, #N` with
  `N % 8 == 4` (16+8k has to become 20+8k+4 to stay 8-byte aligned), while the `shallow` fixture
  (`a + b`) must **not** have r4 in its prologue -- a function that saves no instruction pays a
  word for nothing;
- **frame-less functions get it too**: the `frameless_deep` fixture (no parameters, no locals,
  three nested levels) must show `PUSH {r4, r5, r6, r7, lr}`, `MOV r6, sp`, `SUB sp, sp, #4`,
  `MOV sp, r6` and `POP {r4, r5, r6, r7, pc}` -- **in exactly that order** (the `SUB` after
  `MOV r6, sp`, see 3.2) -- while `frameless_shallow` (two values) must not have r4 in its
  prologue; both arms (off/on) return 29;
- **optimising continues past a boundary**: the `branch` fixture (two `?:` with the value already
  in memory at the label) must drop both instructions and `PUSH/POP` (82 -> 58, 46 -> 8) and never
  grow the image;
- **the prefix survives a cut**: the `callptr` fixture (`PUSH {r}; POP {ip}; BLX ip`; `POP {ip}` is
  a shape the pass cannot name) must keep `POP {ip}` verbatim, must have no leftover adjacent
  PUSH/POP pair before it, and must still return 70 -- all three together separate "keep the
  prefix" from "fall back for the whole function";
- **it keeps going after a return**: the `retpaths` fixture (three return paths) must (a) rewrite
  the block after the first `return` (85 -> 52 instructions), (b) leave no `PUSH`/`POP` pair on
  any return path (0 pairs) and (c) return 65 on all three arms.  The old code copied everything
  verbatim after the first `MOV sp, r6`; only these three together separate "per-block resume"
  from "stops at the first return";
- **it can be cropped**: a `-DARKCC_FEATURE_OPT_VSTACK=0` build refuses `-fopt-vstack` with
  `C3900U`, and still compiles without the flag.

Every change also runs the **whole ARM execution corpus**:
`tests/arm_exec/run_arm_exec.py --arkcc ./arkcc.exe "--extra=-fopt-vstack"` -- 39 cases, 0
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

The pool has two slots by default, and r4 joins as a third one only when three values are alive at once and
the function shape allows it; a live `pend` mapping pins its slot, and when the pool runs dry the
pass falls back to a real `PUSH`. So it is **friendly to chained evaluation** and tends to zero on
register-hungry expressions -- but it never produces worse code than the original sequence, which
is the line the "image never grows" criterion guards.