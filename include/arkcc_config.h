/* Ark C Compiler - arkcc_config.h
 * Compile-time feature switches: decide which features are compiled into arkcc itself.
 * At runtime, g_config.enable_xxx further guards features when compiling user code.
 *
 * === Profile-based trimming ===
 * Define ARKCC_PROFILE to one of:
 *   ARKCC_PROFILE_HOST_FULL      - full host compiler (default): all backends, all features
 *   ARKCC_PROFILE_STM32_MIN     - STM32 self-hosted: only ARM backend, trimmed features
 *   ARKCC_PROFILE_CROSS_COMPILE - Windows cross-compiler for STM32: ARM+C backend, full features
 *
 * If ARKCC_PROFILE is undefined, defaults to ARKCC_PROFILE_HOST_FULL.
 *
 * IMPORTANT: Trimming only affects arkcc's own compilation. The trimmed arkcc still
 *   compiles STM32 user code correctly because core armcc compatibility (keywords,
 *   pragmas, scatter parsing) is always retained. The trim removes unused backends
 *   and optional optimizations, NOT language features needed for STM32 code.
 */
#ifndef ARKCC_CONFIG_H
#define ARKCC_CONFIG_H

/* ===========================================================================
 * 1. Profile selection
 * ========================================================================= */
#ifndef ARKCC_PROFILE
#define ARKCC_PROFILE ARKCC_PROFILE_HOST_FULL
#endif

#define ARKCC_PROFILE_HOST_FULL      0
#define ARKCC_PROFILE_STM32_MIN      1
#define ARKCC_PROFILE_CROSS_COMPILE  2

/* ===========================================================================
 * 2. Backend selection (controlled by profile; overridable via -D)
 *
 * A backend is enabled if its ARKCC_BACKEND_<NAME> macro is 1.
 * The Makefile/MDK project picks the right set via -DARKCC_PROFILE=...
 * or by overriding individual ARKCC_BACKEND_* macros.
 * ========================================================================= */
#ifndef ARKCC_BACKEND_ARM
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_BACKEND_ARM      1   /* STM32 self-hosted: ARM backend mandatory */
# elif ARKCC_PROFILE == ARKCC_PROFILE_CROSS_COMPILE
#   define ARKCC_BACKEND_ARM      1   /* Cross-compile to ARM for STM32 */
# else
#   define ARKCC_BACKEND_ARM      1
# endif
#endif
#ifndef ARKCC_BACKEND_X86_64
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_BACKEND_X86_64   0   /* Trim x86_64 on STM32 */
# elif ARKCC_PROFILE == ARKCC_PROFILE_CROSS_COMPILE
#   define ARKCC_BACKEND_X86_64   0
# else
#   define ARKCC_BACKEND_X86_64   1
# endif
#endif
#ifndef ARKCC_BACKEND_RISCV32
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_BACKEND_RISCV32  0   /* Trim RISC-V on STM32 */
# elif ARKCC_PROFILE == ARKCC_PROFILE_CROSS_COMPILE
#   define ARKCC_BACKEND_RISCV32  0
# else
#   define ARKCC_BACKEND_RISCV32  1
# endif
#endif
#ifndef ARKCC_BACKEND_C
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_BACKEND_C        0   /* Trim C backend on STM32 */
# elif ARKCC_PROFILE == ARKCC_PROFILE_CROSS_COMPILE
#   define ARKCC_BACKEND_C        1   /* Keep C backend for host-side debugging */
# else
#   define ARKCC_BACKEND_C        1
# endif
#endif

/* ===========================================================================
 * 3. Frontend language features
 *
 * These are ALWAYS enabled because STM32 user code depends on them.
 * Trimming them would break arkcc's ability to compile STM32 programs.
 * ========================================================================= */
#define ARKCC_FEATURE_VLA          1   /* variable-length array int a[n] */
#define ARKCC_FEATURE_WCHAR        1   /* wide character wchar_t / L"..." */
#define ARKCC_FEATURE_TRIGRAPH     1   /* trigraph ??= etc. */

/* ARKCC_FEATURE_COMPLEX: C99 _Complex.  Overridable with -D because it really
 * is removable: the bit that marks a complex operand is spelled 0 in a
 * no-complex build, every `aux & IR_AUX_COMPLEX` test then folds to a
 * constant, and the four-word value paths (materialise / creal / cimag /
 * widen / return register pair) fall out with it.  `_Complex` is refused by
 * the parser in that build, so the folded blocks were unreachable.
 *
 *   Default 1 everywhere, including STM32_MIN.  Measured on the H743
 *   firmware (example/stm32h743/kernel/ARKRTOS_TEST, -DARKCC_FEATURE_COMPLEX=0
 *   on the compile line, everything else unchanged): text 438812 -> 424988,
 *   i.e. -13824 B and FLASH 84.13% -> 81.49%; data/bss unchanged.
 *   tests/run_complex_gate.py proves both directions (full build accepts,
 *   trimmed build refuses with a reason, and code without _Complex is
 *   byte-identical in the two builds).
 *
 *   The default stays 1 on purpose: flipping a default is a behaviour change,
 *   so it has to be a deliberate decision, not a side effect of adding the
 *   switch.  A board build that wants the 13.8 KB passes the -D itself. */
#ifndef ARKCC_FEATURE_COMPLEX
#   define ARKCC_FEATURE_COMPLEX   1
#endif

/* ===========================================================================
 * 4. Backend code generation features
 * ========================================================================= */
#ifndef ARKCC_FEATURE_FPU_HW
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_FPU_HW    1   /* STM32H743 has VFPv5-D16 FPU */
# else
#   define ARKCC_FEATURE_FPU_HW    1
# endif
#endif
#ifndef ARKCC_FEATURE_DWARF
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_DWARF     0   /* Trim DWARF debug info on STM32 to save Flash */
# else
#   define ARKCC_FEATURE_DWARF     1
# endif
#endif
#ifndef ARKCC_FEATURE_DWARF_FULL
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_DWARF_FULL 0   /* No full DWARF tables on STM32 */
# else
#   define ARKCC_FEATURE_DWARF_FULL 1
# endif
#endif

/* ===========================================================================
 * 5. Optimization passes
 * ========================================================================= */
#ifndef ARKCC_FEATURE_OPT_CONSTFOLD
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_CONSTFOLD 1   /* Keep constant folding (cheap) */
# else
#   define ARKCC_FEATURE_OPT_CONSTFOLD 1
# endif
#endif
#ifndef ARKCC_FEATURE_OPT_DCE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_DCE       1   /* Keep dead code elimination (cheap) */
# else
#   define ARKCC_FEATURE_OPT_DCE        1
# endif
#endif
#ifndef ARKCC_FEATURE_OPT_REGALLOC
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_REGALLOC   0   /* 板上裁掉：省 Flash，板端本来也跑不到这条路径 */
# else
#   define ARKCC_FEATURE_OPT_REGALLOC   1   /* 宿主/交叉编译：-fopt-regalloc 才有得开 */
# endif
#endif
/* 运行期默认值仍然是 0（config.c: enable_opt_regalloc = ARKCC_FEATURE_...，
 * 但 --regalloc/-fopt-regalloc 才置 1）——见 config.c 的默认值设定 */
#ifndef ARKCC_FEATURE_OPT_ADDR
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_ADDR      0   /* 板上裁掉：寻址折叠只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_ADDR      1   /* 宿主/交叉编译：-fopt-addr 才有得开 */
# endif
#endif
#ifndef ARKCC_FEATURE_OPT_VSTACK
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_VSTACK    0   /* 板上裁掉：值栈寄存器分配只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_VSTACK    1   /* 宿主/交叉编译：-fopt-vstack 才有得开 */
# endif
#endif
/* ARKCC_FEATURE_OPT_STRENGTH: -fopt-strength, the IR peephole that rewrites a
 * multiplication by a power of two as a left shift (src/opt.c).  No table and no
 * allocation, but it is trimmed from the STM32 profile all the same: a board
 * build ships the behaviour of the default configuration, in which the pass is
 * off, so the code would only ever sit in Flash. */
#ifndef ARKCC_FEATURE_OPT_STRENGTH
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_STRENGTH  0   /* 板上裁掉：强度削减只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_STRENGTH  1   /* 宿主/交叉编译：-fopt-strength 才有得开 */
# endif
#endif
/* ARKCC_FEATURE_OPT_CBZ: -fopt-cbz, fusing `CMP rX, #0` + `BEQ/BNE` into a
 * single CBZ/CBNZ (src/backend/arm/backend_arm.c).  Same trimming rule as the
 * other text-level passes: a board build ships the default configuration, in
 * which the pass is off, so the code would only ever sit in Flash. */
#ifndef ARKCC_FEATURE_OPT_CBZ
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_CBZ       0   /* 板上裁掉：条件分支融合只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_CBZ       1   /* 宿主/交叉编译：-fopt-cbz 才有得开 */
# endif
#endif
/* ARKCC_FEATURE_OPT_BRANCH: -fopt-branch, shrinking a B/B<cond> that fits
 * the 16-bit range to its two-byte form (src/backend/arm/backend_arm.c).
 * Same trimming rule as the other text-level passes: a board build ships
 * the default configuration, in which the pass is off. */
#ifndef ARKCC_FEATURE_OPT_BRANCH
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_BRANCH     0   /* 板上裁掉：短分支只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_BRANCH     1   /* 宿主/交叉编译：-fopt-branch 才有得开 */
# endif
#endif
/* ARKCC_FEATURE_OPT_BITMASK: -fopt-bitmask, folding `MOV rX,#imm` +
 * `MVN rX,rX` + `AND rY,rX` into `BIC rY,rY,#imm` (and the `MOV rY,rX` variant
 * into `MVN rY,#imm`) (src/backend/arm/backend_arm.c).  Same trimming rule as
 * the other text-level passes: a board build ships the default configuration,
 * in which the pass is off, so the code would only ever sit in Flash. */
#ifndef ARKCC_FEATURE_OPT_BITMASK
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_BITMASK  0   /* 板上裁掉：位掩码折叠只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_BITMASK  1   /* 宿主/交叉编译：-fopt-bitmask 才有得开 */
# endif
#endif
/* ARKCC_FEATURE_OPT_IMM: -fopt-imm, folding a constant operand into the
 * instruction's immediate field instead of materialising it through the value
 * stack.  Same trimming rule as the other code-size passes. */
#ifndef ARKCC_FEATURE_OPT_IMM
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_IMM        0   /* 板上裁掉：立即数折叠只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_IMM        1
# endif
#endif
/* ARKCC_FEATURE_OPT_PEEP: -fopt-peep, removing register copies that travel
 * through the value stack (PUSH/POP pairs, pool constants, store/reload). */
#ifndef ARKCC_FEATURE_OPT_PEEP
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_PEEP       0
# else
#   define ARKCC_FEATURE_OPT_PEEP       1
# endif
#endif
/* ARKCC_FEATURE_OPT_CBRANCH: -fopt-cbranch, feeding a comparison result
 * straight into the conditional branch that consumes it instead of
 * materialising the 0/1 value and testing it again. */
#ifndef ARKCC_FEATURE_OPT_CBRANCH
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_CBRANCH    0
# else
#   define ARKCC_FEATURE_OPT_CBRANCH    1
# endif
#endif
/* ARKCC_FEATURE_OPT_PAIR: -fopt-pair, consuming two adjacent one-word
 * value-stack pushes together with the binary op that reads them, so
 * the operands go straight into r0/r1 instead of through the stack.
 * Same trimming rule as the other emitter-side passes. */
#ifndef ARKCC_FEATURE_OPT_PAIR
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_PAIR       0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_PAIR       1
# endif
#endif
/* ARKCC_FEATURE_OPT_PROP: -fopt-prop, IR-level local-slot constant
 * propagation (src/opt.c).  It needs a byte map the size of the frame, which
 * is trivially cheap on the host and pointless on a board build that ships the
 * default configuration (in which the pass is off). */
#ifndef ARKCC_FEATURE_OPT_PROP
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_PROP      0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_PROP      1
# endif
#endif
/* ARKCC_FEATURE_OPT_DEADPUSH: -fopt-deadpush, IR-level removal of a one-word
 * push that the next IR_POP discards (src/opt.c).  No extra memory at all --
 * a single pass over the instruction list -- but it is still a host-only
 * switch so the board build stays bit-for-bit what it was. */
#ifndef ARKCC_FEATURE_OPT_DEADPUSH
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_DEADPUSH   0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_DEADPUSH   1
# endif
#endif
/* ARKCC_FEATURE_OPT_CMAT: -fopt-cmat, the constant-materialisation cleanup
 * in src/backend/arm/backend_arm.c (M1 fold a copy of a known constant into an
 * immediate, M2 fold a constant index into the addressing mode, M3 drop a
 * flag-neutral write that is overwritten before a read in the same block).
 * It needs ~4 K-entry tables (~300 KB of static space), so it is off the
 * STM32 profile: a board build that ships the default configuration would
 * never enter the pass anyway. */
#ifndef ARKCC_FEATURE_OPT_CMAT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_CMAT      0   /* 板上裁掉：只在宿主/交叉编译用（静态表约 300 KB BSS） */
# else
#   define ARKCC_FEATURE_OPT_CMAT      1
# endif
#endif
/* ARKCC_FEATURE_OPT_COPYPROP: -fopt-copyprop, the IAR "ECT" family -- drop a
 * register copy whose destination is overwritten before any read, and forward
 * one that feeds a single three-operand ALU consumer. */
/* ARKCC_FEATURE_OPT_SLOTREG: -fopt-slotreg, block-local redundant frame
 * access removal (drop a "LDR r0, [r6,#o]" whose value r0 already holds, and a
 * "STR r0, [r6,#o]" that a later write in the same basic block overwrites --
 * or that nothing in the function ever reads).  See docs/SLOT_REGISTERS.md
 * section 3.  Small tables (~30 KB BSS), kept off the STM32 profile for the
 * same reason as the other text passes. */
#ifndef ARKCC_FEATURE_OPT_SLOTREG
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_SLOTREG   0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_SLOTREG   1
# endif
#endif
/* ARKCC_FEATURE_OPT_LDHOIST: -fopt-ldhoist, S12-1 load hoisting -- one
 * `LDR D, [Rb, #imm]` per region instead of one per level of a nested
 * ternary chain (docs/EXPR_MODEL.md S12-1).  It widens the frame
 * PUSH/POP by a dedicated callee-saved register, so it is purely a
 * text rewrite on registers the function never names.  Large tables
 * (8192 parsed lines ~1.4 MB + a 2048-entry label table ~144 KB BSS),
 * so it stays off the STM32 profile for the same reason as the other
 * text passes. */
#ifndef ARKCC_FEATURE_OPT_LDHOIST
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_LDHOIST   0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_LDHOIST   1
# endif
#endif
/* ARKCC_FEATURE_OPT_STACKFRAME: -fopt-stackframe, S13 frame bookkeeping --
 * delete `MOV r6, sp` / `MOV sp, r6` and address the frame through sp
 * instead, and delete a `SUB sp, sp, #N` / `ADD sp, sp, #N` pair that builds
 * a frame nothing reads (docs/EXPR_MODEL.md section 14.3).  Pure deletion of
 * a proof, plus a base-register rewrite; large tables (8192 parsed lines
 * ~1.4 MB BSS), so it stays off the STM32 profile like the other text
 * passes. */
#ifndef ARKCC_FEATURE_OPT_STACKFRAME
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_STACKFRAME 0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_STACKFRAME 1
# endif
#endif
/* ARKCC_FEATURE_OPT_DEADINS: -fopt-deadins, S13 block-local dead code --
 * delete a dead register write and a CMP/CMN/TST/TEQ whose flags nothing in
 * the same block reads (docs/EXPR_MODEL.md section 14.2).  Same tables as
 * -fopt-stackframe, off the STM32 profile for the same reason. */
#ifndef ARKCC_FEATURE_OPT_DEADINS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_DEADINS   0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_DEADINS   1
# endif
#endif
/* ARKCC_FEATURE_OPT_LADDER: -fopt-ladderload / -fopt-ladderstage, S15
 * comparison-ladder redundancy -- delete a `LDR Rb, [Rn, #0]` reloaded from
 * an address the enclosing ladder never writes, and delete a `MOV Rd, Rv`
 * staging copy that the taken arm of a `BNE` overwrites before any read
 * (docs/EXPR_MODEL.md section 17).  Two switches, one shape analysis, one
 * feature macro: the tables are the same as the other text passes (8192
 * parsed lines), so it is off the STM32 profile for the same reason. */
#ifndef ARKCC_FEATURE_OPT_LADDER
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_LADDER    0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_LADDER    1
# endif
#endif
/* ARKCC_FEATURE_OPT_REGBIRTH: -fopt-birthdest / -fopt-basefold, S16 result
 * born in its destination and base folded into the addressing mode -- merge
 * `OP r0, ...` + `MOV rD, r0` into one instruction, and fold a single-use
 * `ADD rB, rX, #imm` into the one access that consumes rB
 * (docs/EXPR_MODEL.md section 20).  Same line tables and the same forward
 * liveness test as the S15 ladder pass, so it shares that guard and is off
 * the STM32 profile for the same reason. */
#ifndef ARKCC_FEATURE_OPT_REGBIRTH
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_REGBIRTH 0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_REGBIRTH 1
# endif
#endif
/* ARKCC_FEATURE_OPT_CHAINFOLD: -fopt-chainfold, S17 same-value comparison
 * runs -- adjacent ladder layers that pick the same result value and share
 * one join keep only the last `MOV`/`B`; every earlier layer's `BNE` becomes a
 * `BEQ` into one fresh hit label (docs/EXPR_MODEL.md section 22).  Same line
 * tables and the same guard as the S15/S16 text passes, so it is off the
 * STM32 profile for the same reason. */
#ifndef ARKCC_FEATURE_OPT_CHAINFOLD
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_CHAINFOLD 0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_CHAINFOLD 1
# endif
#endif

/* ARKCC_FEATURE_OPT_FRAME: -fopt-frame, callee-saved list trimming.
 * A slot the body never mentions is deleted from PUSH/POP; when that
 * empties the frame the four instructions that build it go too, and the
 * alignment padding is recomputed from the new register count.  Pure
 * deletion -- it never invents an instruction.  Small tables (~64 KB BSS),
 * kept off the STM32 profile for the same reason as the other text
 * passes.  See docs/FRAME_TRIM.md. */
#ifndef ARKCC_FEATURE_OPT_FRAME
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_FRAME   0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_FRAME   1
# endif
#endif
/* ARKCC_FEATURE_OPT_PUSHPOP: -fopt-pushpop, S19-a value-stack round trips --
 * a `PUSH {rX}` whose value is a literal-pool load, an immediate or a
 * register copy is deleted and its matching `POP {rY}` re-materialises
 * the value (docs/EXPR_MODEL.md section 27).  Same line tables as the
 * other text passes, so it is off the STM32 profile for the same reason. */
#ifndef ARKCC_FEATURE_OPT_PUSHPOP
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_PUSHPOP 0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_PUSHPOP 1
# endif
#endif

/* ARKCC_FEATURE_OPT_ADDRFOLD: -fopt-addrfold, S20 address-chain folding --
 * an `ADD rA, rB, #k1` whose result the very next instruction consumes and
 * then leaves dead is deleted, its offset folded into either the next `ADD`
 * or the `[rA, #k2]` of the access that follows (docs/EXPR_MODEL.md
 * section 30).  Needs the live pass' basic blocks and liveness, so it is off
 * the STM32 profile together with it. */
#ifndef ARKCC_FEATURE_OPT_ADDRFOLD
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_ADDRFOLD 0  /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_ADDRFOLD 1
# endif
#endif

/* ARKCC_FEATURE_OPT_REMAT: -fopt-remat, S21 same-value re-materialisation --
 * a register that already holds a constant is not made to hold it again
 * (docs/EXPR_MODEL.md section 31).  Text level, no liveness needed, but it
 * only pays off on a real function body, so the board profile drops it. */
#ifndef ARKCC_FEATURE_OPT_REMAT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_REMAT 0  /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_REMAT 1
# endif
#endif

/* ARKCC_FEATURE_OPT_ISEL2: -fopt-isel2, in-place instruction-selection
 * peepholes on the finished text (docs/EXPR_MODEL.md section 54).  Each rule
 * replaces a two- or three-instruction shape with a one-instruction shape and
 * deletes what is left over; a site that fails any safety test keeps its text.
 * Off by default, and the board profile drops it: it only pays off on a real
 * function body. */
#ifndef ARKCC_FEATURE_OPT_ISEL2
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_ISEL2 0  /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_ISEL2 1
# endif
#endif

/* ARKCC_FEATURE_VREGEMIT: -fopt-vregemit, V-5 virtual-register emission
 * path.  The idea was to re-emit a function's body from IR with the value
 * stack held in registers instead of memory.  S42 implemented the straight-line
 * leaf form of it and measured -13 instructions / 0.14% on the 95-TU corpus:
 * `-fopt-vstack` already claims that budget, and a straight-line IR rule only
 * reaches 10 of 212 functions (the other 127 text-eligible ones have
 * multi-block control flow or calls).  The emitter block is therefore gone.
 * What is left is the routing census: the switch changes no byte at all and
 * only prints the candidate count (ARKCC_VREGEMIT_STATS=1).  Cropping it by
 * name still works.  See docs/EXPR_MODEL.md sections 41-42. */
#ifndef ARKCC_FEATURE_VREGEMIT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_VREGEMIT 0  /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_VREGEMIT 1
# endif
#endif

/* ARKCC_FEATURE_OPT_VOLDBM: -fopt-voldmb, elide the DMB SY pair around a
 * volatile access to a frame slot whose address this function never takes.
 * A barrier orders memory transactions as seen by *another* observer; with
 * no address taken no other observer can name the object, so the pair is
 * pure overhead (2 instructions / 8 bytes per volatile local access; the
 * HAL's `__IO uint32_t tmpreg` idiom is the whole population).  armcc,
 * armclang and IAR emit nothing here.  Pure deletion, ~2 KB of BSS for the
 * escaped-name table, so it stays off the STM32 profile like the other text
 * passes.  See docs/VOLDBM.md. */
#ifndef ARKCC_FEATURE_OPT_VOLDBM
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_VOLDBM  0
# else
#   define ARKCC_FEATURE_OPT_VOLDBM  1
# endif
#endif
/* ARKCC_FEATURE_OPT_CONSTCOND: -fopt-constcond, resolve a branch whose
 * condition is a compile-time literal at IR level.  `do { ... } while (0U)`
 * (every HAL macro) and `if (const)` (assert_param) currently cost a
 * materialisation plus a compare each -- 157 pairs / 2.6% of the final
 * instruction count on the 95-TU corpus.  Pure deletion, no tables, but kept
 * off the STM32 profile with the rest of the -fopt-* family so the crop table
 * stays one story (see docs/BUILD.md 5.2).  See docs/CONSTCOND.md. */
#ifndef ARKCC_FEATURE_OPT_CONSTCOND
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_CONSTCOND  0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_CONSTCOND  1
# endif
#endif
/* ARKCC_FEATURE_OPT_EXIT: -fopt-exit, drop frame maintenance that provably
 * rewrites a value the register already holds.  A function whose body never
 * touches sp arrives at every return with sp still equal to the frame base, so
 * the `MOV sp, base` in front of its POP is a no-op; and when the base is
 * never used as a base at all, the `MOV base, sp` that built it is dead too.
 * Pure deletion, no tables and no new labels.  Kept off the STM32 profile with
 * the rest of the -fopt-* family so the crop table stays one story (see
 * docs/BUILD.md 5.2).  See docs/EXIT.md. */
#ifndef ARKCC_FEATURE_OPT_EXIT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_EXIT  0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_EXIT  1
# endif
#endif
/* ARKCC_FEATURE_OPT_BOOLMAT: -fopt-boolmat, delete a one-word
 * `STORE v ; PUSH_VAR v` pair.  `int t = (a < b); if (t)` is two statements,
 * so irgen spills the comparison result and reads it back one instruction
 * later; the pair is a frame store plus a frame load that no later pass can
 * remove (-fopt-prop only folds constants, -fopt-live sees the load as a
 * reader, -fopt-deadpush needs an IR_POP).  Deleting it keeps the comparison
 * on the value stack, which is exactly the shape -fopt-cbranch turns into one
 * `CMP` plus one conditional branch.  Pure deletion, no tables, but kept off
 * the STM32 profile with the rest of the -fopt-* family so the crop table stays
 * one story (see docs/BUILD.md 5.2).  See docs/BOOLMAT.md. */
#ifndef ARKCC_FEATURE_OPT_BOOLMAT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_BOOLMAT    0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_BOOLMAT    1
# endif
#endif
/* ARKCC_FEATURE_OPT_VOLBAR: -fopt-volbar, also emit the DMB SY pair around a
 * volatile access to an object that is *not* a frame slot -- a global, a
 * volatile struct member reached through a pointer, or a dereferenced
 * pointer.  Those objects may be named by another observer (DMA engine, a
 * second core, an ISR), so the compiler cannot prove the barrier is
 * redundant.  Default off, because on ARMv7-M a single core never reorders
 * Device/Strongly-ordered accesses (ARM ARM B2.3.7), so armcc, armclang, IAR
 * and GCC(Cortex-M) all emit no barrier at all; forcing the pair costs about
 * +40% instructions on the HAL corpus (12304 -> 17264, 139 -> 2986 DMB).
 * Turn it on only when a second bus master relies on the compiler for
 * ordering.  The volatile qualifier itself is always honoured by the
 * optimizer (IR_AUX_VOLATILE), so this flag is about barriers only.
 * See docs/VOLMEM.md. */
#ifndef ARKCC_FEATURE_OPT_VOLBAR
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_VOLBAR  0
# else
#   define ARKCC_FEATURE_OPT_VOLBAR  1
# endif
#endif
/* ARKCC_FEATURE_OPT_VREG: -fopt-vreg (S6a), slot promotion to a callee-saved
 * register.  Loads whose consumer can be renamed are deleted, stores become
 * "MOV rC, r0"; the pass reuses the -fopt-regalloc frame machinery (PUSH/POP
 * widening and the single offset shift), so it is only compiled when that
 * feature is present too.  See docs/VREG.md section 10.5. */
#ifndef ARKCC_FEATURE_OPT_VREG
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_OPT_REGALLOC
#   define ARKCC_FEATURE_OPT_VREG      0   /* 板上裁掉；且必须与 regalloc 同时在场 */
# else
#   define ARKCC_FEATURE_OPT_VREG      1
# endif
#endif
/* ARKCC_FEATURE_OPT_CONSTCACHE: -fopt-constcache (S3a), a function-level cache
 * for 32-bit constants.  A constant materialised c times costs 2c instructions;
 * materialising it once at function entry into a callee-saved register and
 * copying it per use costs 2 + c plus one wider PUSH/POP, so the net gain is
 * c - 4 and the threshold is c >= 5.  It rides on the -fopt-regalloc frame
 * machinery (that pass owns the PUSH/POP widening and the one-and-only offset
 * shift), so it is only compiled when the regalloc feature is present too.
 * See docs/OPERAND_ALLOC.md section 3. */
#ifndef ARKCC_FEATURE_OPT_CONSTCACHE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_OPT_REGALLOC
#   define ARKCC_FEATURE_OPT_CONSTCACHE 0   /* 板上裁掉；且必须与 regalloc 同时在场 */
# else
#   define ARKCC_FEATURE_OPT_CONSTCACHE 1
# endif
#endif
/* ARKCC_FEATURE_OPT_LITPOOL: -fopt-litpool puts 32-bit constants in a
 * literal pool at the end of the function instead of materialising each one
 * with a MOVW/MOVT pair (see docs/LITPOOL.md).  The pass needs one 4096-entry
 * line table (~16 KB BSS) and the assembler learns one instruction form
 * ("LDR rd, <.Llabel>"), so it stays off the STM32 profile for the same reason
 * as the other text passes: a board build that ships the default configuration
 * never enters the pass. */
#ifndef ARKCC_FEATURE_OPT_LITPOOL
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_LITPOOL   0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_LITPOOL   1
# endif
#endif
#ifndef ARKCC_FEATURE_OPT_COPYPROP
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_COPYPROP   0
# else
#   define ARKCC_FEATURE_OPT_COPYPROP   1
# endif
#endif
/* ARKCC_FEATURE_OPT_LIVE: -fopt-live, liveness-driven register cleanup.  It
 * builds a control-flow graph and a ~1.5 MB static workspace, so it is kept
 * off the STM32 profile; MCU builds simply cannot afford the tables. */
#ifndef ARKCC_FEATURE_OPT_LIVE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_LIVE      0
# else
#   define ARKCC_FEATURE_OPT_LIVE      1
# endif
#endif
/* ARKCC_FEATURE_OPT_COALESCE: -fopt-coalesce, local copy coalescing.  A
 * straight-line `MOV rD, rS` whose uses can all read rS instead is deleted and
 * the uses are renamed; the proof is the liveness the -fopt-live pass already
 * computes (rD must not be live past the last renamed use, rS must not be
 * written inside the run).  No extra tables: it rides on lv_pass(). */
#ifndef ARKCC_FEATURE_OPT_COALESCE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_OPT_LIVE
#   define ARKCC_FEATURE_OPT_COALESCE   0   /* 板上裁掉；且必须与 live 同时在场（骑在 lv_pass 上） */
# else
#   define ARKCC_FEATURE_OPT_COALESCE   1
# endif
#endif
/* ARKCC_FEATURE_OPT_SPILL: -fopt-spill, cross-block stack round trips.  A
 * `PUSH {rX}` whose only reader on every path is a later `POP {rX}` is a
 * copy routed through memory; deleting both halves changes no value and no
 * stack balance.  It rides on the control-flow graph and the liveness
 * helpers -fopt-live builds, so it is trimmed together with them, and it is
 * off by default: measured 2.9% of instructions, below the 4% S10 asked for
 * (docs/EXPR_MODEL.md S10). */
#ifndef ARKCC_FEATURE_OPT_SPILL
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_OPT_LIVE
#   define ARKCC_FEATURE_OPT_SPILL     0   /* 板上裁掉；且骑在 live 的 CFG/活跃性辅助上 */
# else
#   define ARKCC_FEATURE_OPT_SPILL     1
# endif
#endif
#ifndef ARKCC_FEATURE_OPT_INLINE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_INLINE    0   /* Trim auto-inline on STM32 (costs Flash) */
# else
#   define ARKCC_FEATURE_OPT_INLINE    1
# endif
#endif
#ifndef ARKCC_FEATURE_OPT_VECTORIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_VECTORIZE 0   /* Trim SIMD vectorization on STM32 */
# else
#   define ARKCC_FEATURE_OPT_VECTORIZE 1
# endif
#endif

/* ARKCC_FEATURE_MEMLINT: the --warn-mem pass (return of an automatic address,
 * double free, use after free). See include/memlint.h and docs/MEMLINT.md.
 *
 * Trimmable by construction: it is a self-contained source file with no table
 * and no dynamic allocation (one ~900-byte stack frame per function analysed),
 * so "off" removes the whole thing from the image and "on" is affordable on a
 * target with a few KB of stack. It is off in the STM32 profile by default
 * because Flash is the scarce resource there (measured delta in docs/MEMLINT.md),
 * not because the pass needs memory; -DARKCC_FEATURE_MEMLINT=1 turns it back on
 * for an on-board build at the cost of that Flash.
 *
 * The runtime switch is separate and defaults to off on every profile, so the
 * shipped behaviour is unchanged even where the code is compiled in. */
#ifndef ARKCC_FEATURE_MEMLINT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_MEMLINT       0   /* Trim on the board: costs Flash */
# else
#   define ARKCC_FEATURE_MEMLINT       1
# endif
#endif

/* ARKCC_FEATURE_ENUMCHECK: the --warn-enum pass (a switch over an enum that
 * does not name every enumerator). See include/enumcheck.h and docs/ENUMCHECK.md.
 *
 * Trimmable by construction: one self-contained source file, no table, no
 * dynamic allocation -- two small arrays on the stack per switch analysed.
 * Off in the STM32 profile because Flash is the scarce resource there, not
 * because the check needs RAM; -DARKCC_FEATURE_ENUMCHECK=1 brings it back.
 *
 * The runtime switch (--warn-enum) is separate and defaults to off on every
 * profile, so the shipped behaviour is unchanged even where the code is
 * compiled in. */
#ifndef ARKCC_FEATURE_ENUMCHECK
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_ENUMCHECK     0   /* Trim on the board: costs Flash */
# else
#   define ARKCC_FEATURE_ENUMCHECK     1
# endif
#endif

/* ARKCC_FEATURE_UNUSEDRESULT: the --warn-unused-result pass (a discarded
 * return value of a function declared warn_unused_result / __must_check).
 * See include/unusedresult.h and docs/UNUSEDRESULT.md.
 *
 * Trimmable by construction: one self-contained source file, no heap, one
 * pointer table (256 entries) on the stack. Off in the STM32 profile because
 * Flash is the scarce resource there, not because the check needs RAM;
 * -DARKCC_FEATURE_UNUSEDRESULT=1 brings it back.
 *
 * The runtime switch (--warn-unused-result) is separate and defaults to off on
 * every profile, so the shipped behaviour is unchanged even where the code is
 * compiled in. */
#ifndef ARKCC_FEATURE_UNUSEDRESULT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_UNUSEDRESULT 0   /* Trim on the board: costs Flash */
# else
#   define ARKCC_FEATURE_UNUSEDRESULT 1
# endif
#endif

/* ARKCC_FEATURE_MIR: the MIR checks -- --warn-unreachable,
 * --warn-unused-static and --warn-recursion. See include/mir.h,
 * include/mirpass.h and docs/MIR_CFG.md.
 *
 * One switch for three checks because they share src/mir.c: the graph
 * builders and the three readers are one module. Splitting the switch would
 * let a build carry a graph builder for a check it cannot run, which is the
 * false-alive shape this project keeps refusing.
 *
 * Trimmable by construction: two arrays on the arena per function analysed
 * (a block per leader plus one slot per instruction), no realloc, and the
 * Tarjan pass has an explicit frame stack so deep call graphs cannot blow a
 * 4 KB task stack. Off in the STM32 profile because Flash is the scarce
 * resource there, not because the checks need RAM;
 * -DARKCC_FEATURE_MIR=1 brings all three back.
 *
 * The runtime switches (--warn-unreachable, --warn-unused-static,
 * --warn-recursion) are separate and each defaults to off on every profile,
 * so the shipped behaviour is unchanged even where the code is compiled in. */
#ifndef ARKCC_FEATURE_MIR
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_MIR           0   /* Trim on the board: costs Flash */
# else
#   define ARKCC_FEATURE_MIR           1
# endif
#endif
/* ARKCC_FEATURE_OPT_ALLOC: -fopt-alloc, V-4' stage A -- emit a function body
 * from IR through a real CFG allocator (liveness + linear scan + constant
 * residency) instead of the one-shot value stack.  Off by default, and when
 * off it must change not one byte.  It needs the MIR CFG (src/mir.c), so a
 * build without ARKCC_FEATURE_MIR cannot carry it; the driver then refuses
 * -fopt-alloc by name (C3900U) instead of accepting a switch that does
 * nothing.  See docs/EXPR_MODEL.md section 43. */
#ifndef ARKCC_FEATURE_OPT_ALLOC
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_MIR
#   define ARKCC_FEATURE_OPT_ALLOC 0  /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_ALLOC 1
# endif
#endif

/* ARKCC_FEATURE_OPT_RSTACK: -fopt-rstack, the depth-2 expression stack
 * (docs/EXPR_MODEL.md section 49).  Extends --reg-top from "the top of the IR
 * stack lives in r0" to "the top two words live in r0/r1", so the left operand
 * of a binary expression no longer has to cross the machine stack.  It is a
 * change to the emitter, not a text pass; off by default, and when off the
 * text must be byte-identical.  Trimmable on its own: -DARKCC_FEATURE_OPT_RSTACK=0
 * makes the driver refuse the switch by name (C3900U) instead of accepting a
 * switch that does nothing. */
#ifndef ARKCC_FEATURE_OPT_RSTACK
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OPT_RSTACK 0  /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_RSTACK 1
# endif
#endif

/* ARKCC_FEATURE_OPT_VEMIT: -fopt-vemit, the S53 value-resident emitter.
 *
 * For a function it can model end to end (leaf, no 64-bit/float/complex,
 * value stack never deeper than four levels, joins agreeing on depth) the
 * IR value stack is emitted straight into r0..r3 instead of the machine
 * stack, so the PUSH/POP round trips are never written.  Off by default; off
 * means byte-identical text.  Trimmable on its own: -DARKCC_FEATURE_OPT_VEMIT=0
 * makes the driver refuse the switch by name (C3900U) instead of accepting a
 * switch that does nothing, and the board profile drops it (the census costs
 * a CFG per function).
 *
 * It needs the MIR CFG (src/mir.c): whole-function admission walks the
 * block graph to prove every join agrees on the value-stack depth.  A
 * build without ARKCC_FEATURE_MIR therefore cannot carry it -- and would
 * not link if it tried, since ve_can_take() calls mir_build() -- so the
 * derived default is off whenever MIR is off, on the same rule as
 * ARKCC_FEATURE_OPT_ALLOC above. */
#ifndef ARKCC_FEATURE_OPT_VEMIT
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_MIR
#   define ARKCC_FEATURE_OPT_VEMIT 0   /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_OPT_VEMIT 1
# endif
#endif

/* ARKCC_FEATURE_RMIR: the 0.9.2 register-machine IR (docs/EXPR_MODEL.md
 * section 55), alpha-1.  Builds the explicit three-address form of a function
 * -- every value a virtual register, every instruction naming its sources and
 * destination -- and verifies it (single assignment for temporaries, every use
 * dominated by its definition).  It emits nothing and changes no output byte;
 * it only measures, and only when ARKCC_RMIR_COV / ARKCC_RMIR_DUMP asks, so a
 * default build pays one getenv() per function and nothing else.
 *
 * It needs the MIR CFG (src/mir.c) to prove joins agree on the value stack, so
 * a build without ARKCC_FEATURE_MIR cannot carry it; the derived default is
 * off whenever MIR is off, on the same rule as ARKCC_FEATURE_OPT_ALLOC and
 * ARKCC_FEATURE_OPT_VEMIT above.  The board profile drops it as well. */
#ifndef ARKCC_FEATURE_RMIR
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_MIR
#   define ARKCC_FEATURE_RMIR 0        /* 板上裁掉：只在宿主/交叉编译用 */
# else
#   define ARKCC_FEATURE_RMIR 1
# endif
#endif

/* ARKCC_FEATURE_IPO: --ipo / -flto, whole-program compilation (src/ipo.c).
 *
 * One front end run per input file inside one process, all units' IR
 * accumulated in one program, then a single codegen.  What it buys over
 * one-object-per-file + -link is the only thing the linker cannot do:
 * cross-file optimisation.  An ARKOBJ2 object carries machine code, a symbol
 * table and relocations; the IR is gone by the time -link sees it, so
 * inlining, unused-static removal and constant propagation have no subject
 * there.
 *
 * Trimmable by construction: the code lives in src/ipo.c behind this switch
 * and ark_ipo_compile() keeps its symbol (it refuses with C3900U) when the
 * switch is 0, so a build that cannot do it says so instead of pretending.
 * OFF in the STM32 profile: whole-program mode needs every unit's IR alive at
 * once, and the board's arena is 128 KB for one unit already.
 * -DARKCC_FEATURE_IPO=1 brings it back.
 *
 * The runtime switch is separate and defaults to off, so the shipped
 * behaviour is unchanged even where the code is compiled in. */
#ifndef ARKCC_FEATURE_IPO
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_IPO           0   /* Trim on the board: pool size */
# else
#   define ARKCC_FEATURE_IPO           1
# endif
#endif
/* ARKCC_FEATURE_PIPELINE_DUMP: the strings and the printer behind
 * --print-pipeline.  The stage tables and the execution loop are compiled in
 * unconditionally -- src/pipeline.c is the driver now, not an optional pass --
 * so only the human-readable half is trimmed on the board.  Turning this off
 * makes --print-pipeline refuse with C3900U instead of printing an empty
 * table, which is the only honest behaviour for a query this build cannot
 * answer. */
/* ARKCC_FEATURE_OBJ_IR: the IR payload in an ARKOBJ2 object (`-c --obj-ir`)
 * and link-time optimisation over those payloads (`-link --lto`).
 *
 * What it is: an object normally carries machine code, symbols and
 * relocations, and the IR is consumed by codegen and thrown away.  That is
 * why the linker can only concatenate and patch -- cross-file inlining and
 * constant propagation have no subject there.  --ipo solves it by compiling
 * every file in one process, which requires all the sources at once.  --obj-ir
 * solves the same problem on the object path: the serialised IR rides along
 * in the object (after the relocation table, so older readers are unaffected),
 * and `-link --lto` re-compiles the merged IR instead of patching code.
 *
 * OFF in the STM32 profile: the payload needs a per-unit IR-sized buffer and
 * a whole-program merge, and the board's arena holds one unit already.
 * -DARKCC_FEATURE_OBJ_IR=1 brings it back.
 *
 * Both runtime switches default to off, so a build with the feature compiled
 * in behaves exactly as before unless asked. */
#ifndef ARKCC_FEATURE_OBJ_IR
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_OBJ_IR         0
# else
#   define ARKCC_FEATURE_OBJ_IR         1
# endif
#endif

#ifndef ARKCC_FEATURE_PIPELINE_DUMP
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_PIPELINE_DUMP 0
# else
#   define ARKCC_FEATURE_PIPELINE_DUMP 1
# endif
#endif


/* ===========================================================================
 * 6. ARMCC 5 compatibility
 *
 * These are ALWAYS enabled: STM32 user code (CMSIS, HAL, startup) depends on
 * armcc 5 syntax (__irq, __weak, __packed, __asm, #pragma pack, scatter .sct).
 * Trimming these would break compilation of STM32 programs.
 * ========================================================================= */
#define ARKCC_FEATURE_ARMCC_ASM_FUNC  1   /* __asm function body */
#define ARKCC_FEATURE_ARMCC_PRAGMA    1   /* #pragma compatibility */
#define ARKCC_FEATURE_ARMCC_KEYWORDS  1   /* __irq/__weak/__naked etc. */
#define ARKCC_FEATURE_ENUM_IS_INT     1   /* --enum_is_int / -fenum-is-int */
#define ARKCC_FEATURE_SCATTER         1   /* scatter load description file parsing */

/* ===========================================================================
 * 7. Diagnostics
 *
 * DIAG_SINK is the only part of the diagnostic layer that needs stdio (the
 * --errors=<file> sink). On STM32 there is no stdio, so diagnostics go to
 * ark_log() only and diag_open_sink() reports failure.
 * ========================================================================= */
/* DIAG is the master switch for the diagnostic layer (codes, layout, echo,
 * caret, counting, suppression, --errors sink, the generated message table).
 *
 *   1  the shipped behaviour: armcc-compatible presentation (docs/DIAGNOSTICS.md)
 *   0  minimal last resort for footprint-sensitive builds: every entry point
 *      keeps its signature, but a message is printed as one ark_log() line --
 *      no code, no source echo, no caret, no summary, no suppression, no sink,
 *      and src/diag_msg_table.c compiles to nothing. Errors and warnings are
 *      still counted, so the driver's exit code is unchanged.
 *
 * Default 1. The switch exists so the layer can be measured and removed; it is
 * not a runtime option (a runtime flag would have to keep all the code). */
/* ---------------------------------------------------------------------------
 * 0.8.0 预处理器的三处可配置点
 *
 * 三项都遵守同一条纪律：默认关闭时编译产物与旧行为逐字节相同；打开后必须
 * 有真正走到该分支的用例（见 tests/features/）。
 *
 *  ARKCC_FEATURE_MACRO_REDEF_CHECK  C99 6.10.3p2：同名宏的重定义只有在「形式、
 *                                   形参、替换列表全部相同」时才合法，否则要
 *                                   告警。arkc 之前一律静默覆盖。
 *  ARKCC_FEATURE_MACRO_BODY_DYN     替换文本超过栈缓冲时改为从内存池翻倍扩容，
 *                                   不再截断。硬上限由 ARKCC_MACRO_BODY_MAX 定。
 *  ARKCC_MAX_INC_FILES              -MMD 依赖文件能记录的 #include 个数。之前固定
 *                                   64 且超出后静默丢弃。
 *  ARKCC_FEATURE_CAST_F64F32        float<->double 之间插入 IR_F2F。关掉时恢复
 *                                   旧行为（不插转换节点，两种精度被当成同一表示）。
 *  ARKCC_FEATURE_FCONST_FOLD        浮点常量表达式折叠。关掉时全局浮点初值回到
 *                                   "求不出值就写 0"的旧路径。
 * ------------------------------------------------------------------------- */
/* 0.8.0 的新开关（默认值就是“新行为是否默认生效”的答案）：
 *   ARKCC_FEATURE_OPT_DCE_CFG    基本块级可达性 DCE。默认 0：线性 DCE 已足够，
 *                                CFG 版要用户显式 --dce-cfg 打开。
 *   ARKCC_FEATURE_ARM_RELOC_DATA 多目标文件的数据段可搬迁。默认 0：需要
 *                                --reloc-data，老的单对象流程逐字节不变。
 *   ARKCC_FEATURE_OPT_REG_TOP    栈顶值常驻 r0。默认 0：--reg-top 打开。
 *   ARKCC_FEATURE_RT_LAZY        运行库按需发射。默认 0：--rt-lazy 打开。
 *   ARKCC_FEATURE_ASM_EXTRA      汇编器扩展指令集。默认 0：--asm-extra 打开。 */
/* 编译期：这几段代码是否进入产物。板上（STM32_MIN）默认裁掉以省 Flash；
 * 宿主/交叉编译保留，于是运行时开关 --xxx 才有的可开。
 * 运行时的默认值一律是 0（见 config.c），所以默认行为与旧版本逐字节相同。
 *
 * 例外：ARKCC_FEATURE_ARM_RELOC_DATA 在板上也必须编进去。它不是"省 Flash 的
 * 优化项"，而是"多目标文件能不能链接"的硬条件——板上 build 的最小演示就是
 * 两个 .c 各带 .data 链成一个镜像。裁掉它的后果不是"这个开关无效"，而是
 * 后端不发 .arkdata 站点（emit_mov_addr32 的 marked 分支整个被编译掉），
 * 链接期 ld_relocate_data 于是 patch 到 0 个站点、报 "declares data but
 * carries no relocatable address"，而运行时 --reloc-data 明明已经 on。
 * 当时把它当成"可选优化"裁掉，正是板上 m2-cross-tu-link 反复失败的真因。
 * 代价很小（一个分支 + 标记发射），运行时不打开时输出仍逐字节不变。 */
#ifndef ARKCC_FEATURE_OPT_DCE_CFG
#   if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#       define ARKCC_FEATURE_OPT_DCE_CFG      0
#   else
#       define ARKCC_FEATURE_OPT_DCE_CFG      1
#   endif
#endif
#ifndef ARKCC_FEATURE_ARM_RELOC_DATA
#   define ARKCC_FEATURE_ARM_RELOC_DATA       1
#endif
/* 0.8.0: 段内绝对地址也能交给链接器修正（--reloc-text）。
 *
 * 后端把 g_flash_base + offset 直接编进 MOVW/MOVT，于是"这个对象会被链接到
 * 哪里"在编译期就被写死在指令里。单对象、且基址恰好等于 LR 基址时没问题；
 * 多对象拼接、或镜像被装到别处时那些地址全部偏掉——字符串字面量（.rodata）
 * 最明显，因为它既不是全局变量、也没有跨对象符号可用来解析。
 *
 * 打开后：本地 label 的 LDR rd, =label 记一条 type 12 重定位，对象尾部附一个
 * __arkcc_text_base 符号告诉链接器"我是按哪个基址编的"，链接器再用
 * (它给这个对象的基址 - 那个基址) 去 patch 那对 MOVW/MOVT。
 *
 * 与 ARKCC_FEATURE_ARM_RELOC_DATA 不同，这一项要编进板端产物：板上 build
 * 命令正是靠它把两个对象里的字面量地址纠正过来。代码量很小（一个分支 +
 * 一次 patch 循环），所以 STM32_MIN 也保留；真正的开关是运行时的
 * --reloc-text，默认 0，关掉时一个字节都不变。 */
#ifndef ARKCC_FEATURE_ARM_RELOC_TEXT
#   define ARKCC_FEATURE_ARM_RELOC_TEXT       1
#endif
#ifndef ARKCC_FEATURE_OPT_REG_TOP
#   define ARKCC_FEATURE_OPT_REG_TOP          1
#endif
#ifndef ARKCC_FEATURE_RT_LAZY
#   define ARKCC_FEATURE_RT_LAZY              1
#endif
/* 手写汇编才用得到的形态（VLDM/VSTM/VPUSH/VPOP 多寄存器存取）。后端自己
 * 从来不发射它们，所以板端裁掉只损失"能汇编手写的 .s"，不损失"能编译 .c"；
 * 裁掉时这几条助记符会明确报"not compiled into this build"，而不是变成
 * unknown mnemonic 让人以为拼错了。 */
#ifndef ARKCC_FEATURE_ASM_VFP_LDSTM
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_ASM_VFP_LDSTM   0
# else
#   define ARKCC_FEATURE_ASM_VFP_LDSTM   1
# endif
#endif

#ifndef ARKCC_FEATURE_ASM_EXTRA
#   define ARKCC_FEATURE_ASM_EXTRA            1
#endif

#ifndef ARKCC_FEATURE_SCATTER_CHECK
#   define ARKCC_FEATURE_SCATTER_CHECK    1   /* 分散文件布局校验 */
#endif
#ifndef ARKCC_FEATURE_BUILD_TIME
#   define ARKCC_FEATURE_BUILD_TIME       1   /* --build-date/--build-time/--source-date-epoch */
#endif

#ifndef ARKCC_FEATURE_CAST_F64F32
#   define ARKCC_FEATURE_CAST_F64F32      1   /* float<->double 插 IR_F2F */
#endif

#ifndef ARKCC_FEATURE_FCONST_FOLD
#   define ARKCC_FEATURE_FCONST_FOLD      1   /* 浮点常量表达式折叠 */
#endif

#ifndef ARKCC_FEATURE_MACRO_REDEF_CHECK
#   define ARKCC_FEATURE_MACRO_REDEF_CHECK 1
#endif

/* ARKCC_FEATURE_EOF_NL_WARN: armcc's #1-D "last line of file ends without a
 * newline". Default 1 on every profile: a build that reports a different set
 * of warnings than armcc on the same sources is not a drop-in replacement, and
 * this one costs one pass over each file's bytes at read time.
 *
 * Set to 0 to get back the 0.8.6 behaviour exactly (no #1-D, warning counts as
 * before). Both directions are asserted by tests/run_diag_tests.py
 * (eofnewline*), which fails if the warning is missing or misplaced. */
#ifndef ARKCC_FEATURE_EOF_NL_WARN
#   define ARKCC_FEATURE_EOF_NL_WARN      1
#endif

#ifndef ARKCC_FEATURE_MACRO_BODY_DYN
#   define ARKCC_FEATURE_MACRO_BODY_DYN    1
#endif

#ifndef ARKCC_MACRO_BODY_MAX
#   if ARKCC_PROFILE == ARKCC_PROFILE_HOST_FULL || ARKCC_PROFILE == ARKCC_PROFILE_CROSS_COMPILE
#       define ARKCC_MACRO_BODY_MAX (1024 * 1024)   /* 1 MiB：池是 64 MB，够大 */
#   else
#       define ARKCC_MACRO_BODY_MAX 16383           /* 板端池只有 80 KB，守住 16 KB */
#   endif
#endif

#ifndef ARKCC_MAX_INC_FILES
#   if ARKCC_PROFILE == ARKCC_PROFILE_HOST_FULL
#       define ARKCC_MAX_INC_FILES 1024
#   else
#       define ARKCC_MAX_INC_FILES 64
#   endif
#endif

#ifndef ARKCC_FEATURE_DIAG
#   define ARKCC_FEATURE_DIAG 1
#endif

#if !ARKCC_FEATURE_DIAG
#   undef  ARKCC_FEATURE_DIAG_SINK
#   define ARKCC_FEATURE_DIAG_SINK 0
#endif
#ifndef ARKCC_FEATURE_DIAG_SINK
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_DIAG_SINK  0   /* no stdio on the target */
# else
#   define ARKCC_FEATURE_DIAG_SINK  1
# endif
#endif

/* ===========================================================================
 * 8. Runtime memory budget (tunable per profile)
 *
 * These are pool/buffer sizes for arkcc's own arena allocator.
 * STM32 profile uses smaller pools to fit in RAM budget.
 * Override via -DARK_POOL_SIZE=... etc. on the command line if needed.
 * ========================================================================= */
#ifndef ARK_POOL_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_POOL_SIZE          (64 * 1024)     /* 64 KB arena for STM32 (was 128K to fit 512KB AXI) */
# else
#   define ARK_POOL_SIZE          (256 * 1024 * 1024) /* 256 MB for host: the
                                                   * -link path carves two
                                                   * ARK_LINK_BUF_SIZE buffers
                                                   * out of this arena, so at
                                                   * 64 MB arena + 64 MB link
                                                   * buffer the first -link
                                                   * aborted with "memory pool
                                                   * exhausted" before reading
                                                   * a single object */
# endif
#endif
/* The host -link path allocates its two image buffers from the arena:
 * they are not static arrays, because 2 x ARK_LINK_BUF_SIZE of zeroed .bss is
 * dead weight in every non-link run.  That makes ARK_LINK_BUF_SIZE a hard
 * constraint on ARK_POOL_SIZE -- and the failure mode was "memory pool
 * exhausted" with no hint of which knob to turn, so it is a build error now. */
#if ARK_POOL_SIZE < 2 * ARK_LINK_BUF_SIZE
#error "ARK_POOL_SIZE must be at least 2 * ARK_LINK_BUF_SIZE (the -link path allocates both image buffers from the arena)"
#endif

#ifndef ARK_SRC_BUF_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_SRC_BUF_SIZE       (32 * 1024)     /* 32 KB source buffer.
                                                   * g_src lives in .ark_buf (SDRAM, UNINIT), so
                                                   * this costs no flash and no AXI RAM.  16 KB was
                                                   * measured short: the AEABI runtime the board has
                                                   * to compile itself (stdlib/src/arm/aeabi.c) is
                                                   * 17.8 KB, and `runtime` answered "input file is
                                                   * 17847 bytes, larger than the 16384-byte source
                                                   * buffer" -- a silent gap, not a compile error. */
# else
#   define ARK_SRC_BUF_SIZE       (1024 * 1024)   /* 1 MB source buffer */
# endif
#endif
#ifndef ARK_ASM_BUF_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_ASM_BUF_SIZE     (256 * 1024)      /* 256 KB asm buffer.
                                                   * g_asm lives in .ark_buf (SDRAM, UNINIT),
                                                   * so the size is not a flash or AXI cost.
                                                   * 64 KB was measured short: -O0 assembly for
                                                   * the AEABI runtime (stdlib/src/arm/aeabi.c,
                                                   * 17.8 KB of source) is 92,259 bytes, and the
                                                   * overflow used to be *silent* -- the text was
                                                   * cut mid-line and the assembler answered
                                                   * "unknown mnemonic P" instead of "buffer too
                                                   * small".  *_emit now refuses (see compiler.c). */
# else
#   define ARK_ASM_BUF_SIZE      (8 * 1024 * 1024)  /* 8 MB asm buffer */
# endif
#endif
#ifndef ARK_CODE_BUF_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_CODE_BUF_SIZE     (32 * 1024)      /* 32 KB code buffer */
# else
#   define ARK_CODE_BUF_SIZE     (4 * 1024 * 1024)  /* 4 MB code buffer */
# endif
#endif
#ifndef ARK_LINK_BUF_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_LINK_BUF_SIZE     (16 * 1024)      /* 16 KB: holds the largest object read
                                                   * and the linked image on the board */
# else
#   define ARK_LINK_BUF_SIZE     (64 * 1024 * 1024) /* 64 MB: a real STM32H743
#                                        * image is 1-2 MB, and this buffer
#                                        * holds both the largest object and
#                                        * the linked image (host only).
                                        * 64 MB because a self-hosted
                                        * arkcc link is 15 MB of
                                        * objects plus a 15 MB image;
                                        * at 8 MB that link failed on
                                        * the buffer, not on the code */
# endif
#endif
#ifndef ARK_OBJ_BUF_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_OBJ_BUF_SIZE      (16 * 1024)      /* 16 KB: a hello-world object is 4.2 KB;
                                                   * at 4 KB the symbol table silently wrote
                                                   * 66 bytes past the end of obj_buf */
# else
#   define ARK_OBJ_BUF_SIZE      (ARK_ASM_BUF_SIZE + 16)
# endif
#endif

/* Preprocessor buffer sizes (used by preproc.c). STM32 uses smaller buffers
 * to fit in the AXI SRAM budget. */
#ifndef PP_BUF_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define PP_BUF_SIZE           (64 * 1024)      /* 64 KB preprocessed output */
# else
#   define PP_BUF_SIZE           (4 * 1024 * 1024) /* 4 MB */
# endif
#endif
#ifndef PP_MAX_INC_DEPTH
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define PP_MAX_INC_DEPTH      8                /* 8 levels of #include nesting */
# else
#   define PP_MAX_INC_DEPTH      32
# endif
#endif

/* ARM backend symbol/relocation table sizes. STM32 self-hosted builds only
 * compile small programs, so 1024 entries are plenty. */
#ifndef ARM_MAX_SYMBOLS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARM_MAX_SYMBOLS       1024
# else
#   define ARM_MAX_SYMBOLS       4096
# endif
#endif
#ifndef ARM_MAX_RELOCS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARM_MAX_RELOCS        1024
# else
#   define ARM_MAX_RELOCS        4096
# endif
#endif
#ifndef ARM_MAX_GVARS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARM_MAX_GVARS         512
# else
#   define ARM_MAX_GVARS         2048
# endif
#endif

/* Binary linker tables. A symbol that did not fit used to be dropped without
 * a word, which made -link build an image whose Reset_Handler was missing (no
 * vector table) while still exiting 0; exceeding them is now a hard link
 * error, so the fix is to raise these. LdSym / LdReloc are ~136 bytes each. */
#ifndef ARK_LINK_MAX_SYMS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_LINK_MAX_SYMS     512
# else
#   define ARK_LINK_MAX_SYMS     16384
# endif
#endif
#ifndef ARK_LINK_MAX_RELOCS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_LINK_MAX_RELOCS   512
# else
#   define ARK_LINK_MAX_RELOCS   16384
# endif
#endif

/* Report assembler references that no label in the current translation unit
 * can satisfy. With -c (object) mode this is the NORMAL case: the symbol is
 * cross-object and has been recorded as a relocation for -link, so reporting
 * it as an error only makes noise and sets a failing exit code on a file that
 * produced a perfectly good object. Default 0 = stay quiet, -link reports the
 * symbols that really stay unresolved. Set to 1 to debug a missing *local*
 * label (e.g. a codegen bug that loses a label). */
#ifndef ARK_DIAG_UNRESOLVED_LOCAL
# define ARK_DIAG_UNRESOLVED_LOCAL 0
#endif

/* ===========================================================================
 * 9. 容量上限 -- host is complete, the board trims by configuration
 *
 * 原则：**宿主/交叉编译不许有会挡住真实工程的人为上限**；板端的每一处上限都是
 * 一个可 -D 覆盖的宏，裁剪掉的是"这张板子放不下的量"，不是"语言能力"。
 *
 * 每一项都在越界时**报错并拒绝产出**（不是静默丢弃），所以把数字调小只是
 * 更早失败，不会生成一个看起来成功的错镜像。
 *
 * 覆盖方法（板端裁剪的正式入口）：
 *     make CFLAGS+="-DARK_LINK_MAX_OBJS=32 -DARK_PP_MAX_INC_DIRS=8"
 * ========================================================================= */
/* -link 一次能合并的目标文件个数。宿主 1024（真实 STM32 工程常见 100~300 个），
 * 板端 64。超过就报错，而不是静默跳过按对象的 RAM 处理。 */
#ifndef ARK_LINK_MAX_OBJS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_LINK_MAX_OBJS     64
# else
#   define ARK_LINK_MAX_OBJS     1024
# endif
#endif
/* -I 搜索路径条数。旧实现满 16 条后**静默丢弃**，症状是
 * "cannot open source input file"；宿主给 128。 */
#ifndef ARK_PP_MAX_INC_DIRS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_PP_MAX_INC_DIRS   16
# else
#   define ARK_PP_MAX_INC_DIRS   128
# endif
#endif
/* -D 预定义宏条数。宿主 512（Makefile 驱动的工程常常一次给几十上百个），
 * 板端 64，可 -D 覆盖。 */
#ifndef ARK_MAX_PRE_DEFINES
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_MAX_PRE_DEFINES   64
# else
#   define ARK_MAX_PRE_DEFINES   512
# endif
#endif
/* 一个声明里最多的数组维数（C 标准只要求支持实现定义的上限）。宿主 16 / 板端 8。 */
#ifndef ARK_MAX_ARRAY_DIMS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_MAX_ARRAY_DIMS    8
# else
#   define ARK_MAX_ARRAY_DIMS    16
# endif
#endif
/* 一个函数里“按值返回大结构体（struct/union，size > 8）的调用站点”个数上限。
 * 每个站点在后端要给调用者帧里开一块结果缓冲，所以这是**调用点**计数，
 * 不是函数个数、也不是嵌套深度；超了报错而不是少开一块缓冲。
 * 宿主 256 / 板端 64。 */
#ifndef ARK_MAX_SRET_FUNCS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_MAX_SRET_FUNCS    64
# else
#   define ARK_MAX_SRET_FUNCS    256
# endif
#endif
/* --scatter 里能跟踪的命名段个数（#pragma arm section / __attribute__((section)) 的落点）。 */
#ifndef ARK_MAX_CUSTOM_SECTIONS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_MAX_CUSTOM_SECTIONS 16
# else
#   define ARK_MAX_CUSTOM_SECTIONS 128
# endif
#endif
/* -target c 后端：函数内标签数上限（只影响宿主上的可读性调试输出）。 */
#ifndef ARK_C_MAX_LABELS
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_C_MAX_LABELS      4096
# else
#   define ARK_C_MAX_LABELS      16384
# endif
#endif
/* 符号表哈希桶数。只影响查找速度：128 桶在几千个符号时退化成链表扫描。 */
#ifndef ARK_SYM_HASH_SIZE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARK_SYM_HASH_SIZE     128
# else
#   define ARK_SYM_HASH_SIZE     4096
# endif
#endif
/* ---------------------------------------------------------------------------
 * 0.8.6 循环优化：LICM 与完全展开
 *
 * 两者都靠 MIR 的自然循环检测，所以 MIR 被裁掉时它们也必须跟着裁掉——
 * 没有 CFG 就没有环路可言，留着只会编出一个“开关能开、但永远不动”的假选项。
 *
 * 运行时默认一律关（见 config.c）：不开 --licm / --unroll 时产出的镜像与
 * 不含这个文件的构建逐字节相同。
 * ------------------------------------------------------------------------- */
#ifndef ARKCC_FEATURE_LICM
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_MIR
#   define ARKCC_FEATURE_LICM          0   /* 板端/无 MIR：裁掉省 Flash */
# else
#   define ARKCC_FEATURE_LICM          1
# endif
#endif
#ifndef ARKCC_FEATURE_UNROLL
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_MIR
#   define ARKCC_FEATURE_UNROLL        0
# else
#   define ARKCC_FEATURE_UNROLL        1
# endif
#endif
/* 完全展开的规模上限：展开份数由 --size-weight 的表格给出（src/config.c，
 * 默认权重 5 对应历史值 8），被复制的循环体指令数仍由常量决定。超过任何一条
 * 都不展开——宁可保留循环，也不把函数膨胀成看不懂的样子。 */
#ifndef ARK_UNROLL_MAX_BODY
#   define ARK_UNROLL_MAX_BODY        64
#endif
/* ---------------------------------------------------------------------------
 * 0.9.1 块尾合并（块级 cross-jump）
 *
 * 只需要 MIR 的基本块划分，所以 MIR 被裁掉时它也必须跟着裁掉。
 * 运行时默认关：不开 --tailmerge 时产出的镜像与不含这个文件的构建逐字节相同。
 * ------------------------------------------------------------------------- */
#ifndef ARKCC_FEATURE_TAILMERGE
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_MIR
#   define ARKCC_FEATURE_TAILMERGE     0   /* 板端/无 MIR：裁掉省 Flash */
# else
#   define ARKCC_FEATURE_TAILMERGE     1
# endif
#endif
/* 块尾合并的最短尾部长度（指令条数）由 --size-weight 的表格给出
 * （src/config.c，默认权重 5 对应历史值 3）：太短的尾部合并后省不回字节。 */
/* ---------------------------------------------------------------------------
 * 0.9.1 块级重复块消除（cross-jump 的整块形态，--xblock）
 *
 * 与块尾合并共用深度模型与指令匹配器，只是候选生成器不同：整块指令序列
 * 完全相同就只留一份，其余改成跳过去。同样只需要 MIR，因此 MIR 被裁掉时
 * 也一起裁掉。运行时默认关。
 *
 * 比块尾合并多三条硬条件（见 src/opt_tailmerge.c 顶部）：入口求值栈深度为 0、
 * 块体里不能有标签、块必须以显式终结指令收尾——最后一条是「块体相同 ⇒ 后继
 * 相同」成立的前提，fallthrough 的后继由块在指令表中的位置决定，不在块体里。
 * ------------------------------------------------------------------------- */
#ifndef ARKCC_FEATURE_XBLOCK
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN || !ARKCC_FEATURE_MIR
#   define ARKCC_FEATURE_XBLOCK        0   /* 板端/无 MIR：裁掉省 Flash */
# else
#   define ARKCC_FEATURE_XBLOCK        1
# endif
#endif
/* 可共享块的最短长度（指令条数）由 --size-weight 的表格给出（src/config.c，
 * 默认权重 5 对应历史值 4）：替换成一条 JMP，太短的块省不回字节。 */
/* ---------------------------------------------------------------------------
 * 0.9.1 体积/速度连续权重（--size-weight=N）
 *
 * 0 = 速度优先（尽量内联、尽量展开），9 = 体积优先（保守），5 = 历史常量。
 * 这个开关只调四个「门槛」数值，不改变任何 pass 的正确性前提；四个门槛都属于
 * 宿主上的优化 pass，所以 STM32_MIN 或没有 MIR 时它们一起被裁掉——留着只会
 * 编出一个「开关能开、但永远不动」的假选项。
 * ------------------------------------------------------------------------- */
#ifdef ARKCC_FEATURE_SIZEWEIGHT
/* 派生开关，不接受 -D 直接设定：单独裁掉它会让访问器没有定义 */
# undef ARKCC_FEATURE_SIZEWEIGHT
#endif
#if ARKCC_FEATURE_OPT_INLINE || ARKCC_FEATURE_UNROLL || \
    ARKCC_FEATURE_TAILMERGE || ARKCC_FEATURE_XBLOCK
#  define ARKCC_FEATURE_SIZEWEIGHT   1
#else
#  define ARKCC_FEATURE_SIZEWEIGHT   0
#endif
/* ---------------------------------------------------------------------------
 * 0.9.1 尾调用 -> 跳转（--tailcall）
 *
 * 只发生在 ARM 后端的发射阶段：IR_CALL 后面紧跟 IR_RETURN，且全部实参都装
 * 进 r0-r3 时，本帧已经没有要保存的东西——恢复调用者的 sp、把返回地址留在
 * lr、直接 B 过去。收益是每处一条指令加一整个栈帧（实测 4 B + 帧大小）。
 *
 * 板端（STM32_MIN）用不到这个优化就不驻留：裁掉后不会引用任何新符号，产物
 * 与不含这段代码的构建逐字节相同。运行时默认关（--tailcall 才开）。
 * ------------------------------------------------------------------------- */
#ifndef ARKCC_FEATURE_TAILCALL
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_TAILCALL      0
# else
#   define ARKCC_FEATURE_TAILCALL      1
# endif
#endif
/* ---------------------------------------------------------------------------
 * 0.9.1 除以常数 -> 乘魔数 + 移位（--divconst）
 *
 * 发射期优化：IR_PUSH_INT c 紧跟 IR_DIV/IR_MOD 时除数是编译期已知的，于是把
 * 硬件除法换成「乘出高半 + 移位」（c 是 2 的幂时直接移位 / 取掩码）。IR 不变，
 * 产物在开关关闭时逐字节等于上一版。
 *
 * 板端（STM32_MIN）这整段不驻留：裁掉后不引用任何新符号。运行时默认关
 * （--divconst 才开）。
 * ------------------------------------------------------------------------- */
#ifndef ARKCC_FEATURE_DIVCONST
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_DIVCONST      0
# else
#   define ARKCC_FEATURE_DIVCONST      1
# endif
#endif
/* -MMD 依赖表的文件名数组：宿主按需翻倍扩容（没有人为条数上限），板端用
 * ARKCC_MAX_INC_FILES 的定长表并在越界时告警一次。 */
#ifndef ARKCC_FEATURE_DEP_FILES_DYN
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_DEP_FILES_DYN 0
# else
#   define ARKCC_FEATURE_DEP_FILES_DYN 1
# endif
#endif

/* ---------------------------------------------------------------------------
 * 0.8.7 全程序常量传播（--const-global）
 *
 * 一个文件作用域的 const 对象在 C 语义下就是常量：任何地方读它都得到初始化
 * 表达式写下的那个值，因为写它是未定义行为。irgen 仍然发 IR_PUSH_GLOBAL
 * （按地址取值），因为它在生成那一刻并不知道定义是否落在本翻译单元里；
 * 等 inlining 之后（--ipo 时则是合并成单一程序之后）答案已知，这次读取可以
 * 直接变成立即数。
 *
 * 代码很小（一次线性扫描），但板端的规矩是「不用的特性不驻留」，所以
 * STM32_MIN 档裁掉它；运行期默认也关，不开 --const-global 时产物逐字节不变。
 * ------------------------------------------------------------------------- */
#ifndef ARKCC_FEATURE_CONST_GLOBAL
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_CONST_GLOBAL   0
# else
#   define ARKCC_FEATURE_CONST_GLOBAL   1
# endif
#endif
/* -------------------------------------------------------------------------
 * ARKCC_FEATURE_PARTIAL_LINK: `-r` -- merge objects into one object.
 *
 * -link concatenates code and writes an image, which is a one-way trip: the
 * symbol table is resolved and thrown away.  -r is the same merge one step
 * earlier -- code, symbols and relocations are combined into a new ARKOBJ2
 * object that still names every external reference, so a later -link (with
 * more objects) can finish the job, or another -r can merge again.
 *
 * OFF in the STM32 profile: it is a host-side build-management feature and
 * costs two more passes over the object set.  -DARKCC_FEATURE_PARTIAL_LINK=1
 * brings it back; a build without it refuses -r with C3900U rather than
 * accepting an option it cannot honour.
 *
 * Runtime switch defaults to off: without -r nothing changes.
 * ---------------------------------------------------------------------- */
#ifndef ARKCC_FEATURE_PARTIAL_LINK
# if ARKCC_PROFILE == ARKCC_PROFILE_STM32_MIN
#   define ARKCC_FEATURE_PARTIAL_LINK   0
# else
#   define ARKCC_FEATURE_PARTIAL_LINK   1
# endif
#endif

/* ----------------------------------------------------------------------
 * ARKCC_NEED_LV / ARKCC_NEED_SP: helper families that several text passes
 * share.
 *
 * The live-register helpers (lv_bit / lv_regs / lv_rw / lv_branch_kind /
 * lv_ends_block) and the register-list reader sp_reglist() were born inside
 * one pass each -- -fopt-live and -fopt-spill.  Their definitions therefore
 * sat inside that pass's #if, while the passes that reuse them (remat,
 * ldhoist, stackframe, deadins, pushpop) call them from their own blocks.
 * Cropping the owning feature out and keeping a caller produced a build that
 * did not link at all:
 *
 *   -DARKCC_FEATURE_OPT_LIVE=0  -> lv_bit / lv_regs / lv_rw /
 *                                  lv_branch_kind / lv_ends_block undefined
 *   -DARKCC_FEATURE_OPT_SPILL=0 -> sp_reglist undefined (pushpop calls it)
 *
 * A derived switch fixes that without giving up the crop: a feature that
 * calls the helpers turns them on here, and a build that crops every caller
 * still gets rid of them.  Both are pure functions of the feature macros
 * above, so -D on the command line moves them too.
 * ---------------------------------------------------------------------- */
#if ARKCC_FEATURE_OPT_PEEP || ARKCC_FEATURE_OPT_COPYPROP || \
    ARKCC_FEATURE_OPT_LIVE || ARKCC_FEATURE_OPT_ADDRFOLD || \
    ARKCC_FEATURE_OPT_REMAT || ARKCC_FEATURE_OPT_LDHOIST || \
    ARKCC_FEATURE_OPT_STACKFRAME || ARKCC_FEATURE_OPT_DEADINS || \
    ARKCC_FEATURE_OPT_PUSHPOP || ARKCC_FEATURE_OPT_ISEL2
#  define ARKCC_NEED_LV     1
#else
#  define ARKCC_NEED_LV     0
#endif

#if (ARKCC_FEATURE_OPT_SPILL && ARKCC_FEATURE_OPT_LIVE) || \
    ARKCC_FEATURE_OPT_PUSHPOP
#  define ARKCC_NEED_SP     1
#else
#  define ARKCC_NEED_SP     0
#endif

#endif /* ARKCC_CONFIG_H */
