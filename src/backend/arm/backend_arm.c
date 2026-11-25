/* Ark C Compiler - ARM (Thumb-2) backend
 * Translates IR into textual Thumb-2 assembly. Moved here from the former src/codegen.c.
 *
 * Calling convention (used together with this compiler):
 *   - Arguments 0..3 passed in r0..r3; extra arguments go on the stack (consistent
 *     with the runtime convention, indicated by the val field of IR_CALL).
 *   - r6 = local variable base (fp, pointing to the low address of the local var area).
 *   - Prologue:  PUSH {r5,r6,r7,lr}; SUB sp,sp,#N; MOV r6, sp
 *   - Epilogue:  POP {r0}; MOV sp,r6; ADD sp,sp,#N; POP {r5,r6,r7,pc}
 *   - Variadic functions push r0..r3 *before* the saved registers, so the four
 *     register argument words land directly below the caller's stack argument
 *     block and the va region becomes one contiguous image; the epilogue then
 *     has to add those 16 bytes back as well.
 */
#include <stdio.h>   /* snprintf: building "LDR r0, [sp, #N]" style lines */
#include <string.h>

#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include "config.h"
#include "diag.h"
#include "scatter.h"
#include "agginit.h"
#include "arkcc_config.h"
/* --rt-lazy 的文本压实用 memmove/memcmp（标准 C 库，宿主与板上都有实现）。 */
#include <string.h>
/* On host, <stdlib.h> provides getenv() for the ARKCC_DUMP_SYMS debug flag.
 * On STM32, getenv() is not available (semihosting); g_arm_dump_syms is used
 * instead, and mem_realloc (our own allocator) replaces realloc. */
#if ARKCC_PROFILE != ARKCC_PROFILE_STM32_MIN
#  include <stdlib.h>
#endif

/* --- Internal helpers: emit common instruction fragments --- */
static void emit_line(AsmBuffer *b, const char *s) {
    asmbuf_puts(b, "    ");
    asmbuf_puts(b, s);
    asmbuf_putc(b, '\n');
}
static void emit_add_sp(AsmBuffer *b, int amount) {
    asmbuf_puts(b, "    ADD sp, sp, #");
    asmbuf_int(b, amount);
    asmbuf_putc(b, '\n');
}

/* ThumbExpandImm() representability; the assembler far below defines it. */
static int thumb_imm12_a(unsigned val, unsigned *out_i, unsigned *out_imm3,
                         unsigned *out_imm8);

/* Materialise a 32-bit constant in rd, with the fewest instructions that
 * actually carry the whole value:
 *
 *   0..255       `MOV rd, #imm`   (16-bit MOVS for r0-r7, MOVW for r8-r15)
 *   <= 0xFFFF    `MOVW rd, #imm`  (one 32-bit insn; MOVW zero-extends)
 *   encodable    `MOV rd, #imm`   as a modified immediate (8 bits, rotated)
 *   ~encodable   `MVN rd, #imm`   (one insn: the complement *is* the value)
 *   otherwise    `MOVW` + `MOVT`  pair
 *
 * MOVW writes imm16 and zero-fills bits[31:16] (ARM ARM "MOV (immediate)",
 * T3), so the unconditional `MOVT rd, #0` this used to emit never changed a
 * bit -- it was one instruction of pure waste on every constant below 64 KiB.
 * The old comment claimed MOVW left the upper half stale and that the pair
 * was needed to *clear* it; that is not the architecture, and the 0x40022000
 * case it cites came from a MOVW whose low half was 0x2000 with a *later*
 * MOVT overwriting the high half -- not from MOVW itself.
 *
 * What each form does to the flags is unchanged: 0..255 still goes through the
 * 16-bit MOVS and sets them (every existing caller already sees that), and
 * MOVW / MOV.W / MVN set no flags, exactly like the pair they replace.  The
 * assembler encodes `MOV rd,#imm` for a modified immediate and `MVN rd,#imm`
 * as ORN with Rn = 1111, and pass 1 sizes both as 4 bytes, so the two passes
 * cannot disagree about a label offset. */
static void emit_mov_imm(AsmBuffer *b, int rd, int imm) {
    unsigned u = (unsigned)imm;
    unsigned i = 0, imm3 = 0, imm8 = 0;
    char t[64];
    if (imm >= 0 && imm <= 255) {
        snprintf(t, sizeof t, "    MOV r%d, #%d\n", rd, imm);
        asmbuf_puts(b, t);
        return;
    }
    if (u <= 0xFFFFu) {
        snprintf(t, sizeof t, "    MOVW r%d, #%u\n", rd, u);
        asmbuf_puts(b, t);
        return;
    }
    if (thumb_imm12_a(u, &i, &imm3, &imm8)) {
        snprintf(t, sizeof t, "    MOV r%d, #0x%08X\n", rd, u);
        asmbuf_puts(b, t);
        return;
    }
    if (thumb_imm12_a(~u, &i, &imm3, &imm8)) {
        snprintf(t, sizeof t, "    MVN r%d, #0x%08X\n", rd, ~u);
        asmbuf_puts(b, t);
        return;
    }
    snprintf(t, sizeof t, "    MOVW r%d, #%u\n    MOVT r%d, #%u\n",
             rd, u & 0xFFFFu, rd, (u >> 16) & 0xFFFFu);
    asmbuf_puts(b, t);
}

static void emit_push_r0(AsmBuffer *b) { emit_line(b, "PUSH {r0}"); }
static void emit_pop_r0(AsmBuffer *b)  { emit_line(b, "POP {r0}");  }
static void emit_pop_r1(AsmBuffer *b)  { emit_line(b, "POP {r1}");  }
#if ARKCC_FEATURE_DIVCONST
/* --- 0.9.1 P3: divide by a constant -> multiply by a magic number + shift ---
 *
 * IR_DIV/IR_MOD take the divisor from the stack top, so when IR_PUSH_INT sits
 * right in front of the divide the divisor is known at emission time and the
 * hardware divide can go away.  Nothing in the IR changes: the backend drops
 * that push and the divide emits the sequence below.
 *
 * Granlund-Montgomery with L = ceil(log2 d), d >= 2:
 *     m = ceil(2^(32+L) / d),  e = m*d - 2^(32+L),  e <= 2^L
 *     n / d = mulhi(n, m) >> L
 * m is at most 2^33; when it does not fit in 32 bits the add form is used:
 *     m' = m - 2^32,  t = mulhi(n, m'),
 *     n / d = (t + ((n - t) >> 1)) >> (L - 1)
 * Both forms were checked against exact division on 9.1M (d, n) pairs,
 * including d > 2^31 and the boundary dividends 0, 1, d-1, d, d+1, 2^31-1,
 * 2^31, 2^32-1.
 *
 * Signed division reuses the unsigned sequence through the magnitude trick
 *     sign = n >> 31 (arithmetic);  |n| = (n ^ sign) - sign
 * and applies it to the quotient as well, so INT_MIN is exact (its magnitude
 * 2^31 is representable as unsigned).  A negative divisor only flips the sign
 * register (MVN), because n / -d == -(n / d) and n % -d == n % d; the
 * remainder is finished with the *original* divisor.
 *
 * Refused, i.e. the hardware divide stays byte for byte: c == 0 (division by
 * zero is UB, and SDIV/UDIV is the behaviour we already document), c == 1,
 * signed c == -1 (INT_MIN / -1 overflows), signed |c| == 2^31 (magnitude not
 * representable as a positive int).
 */
typedef struct {
    int      is_unsigned;
    unsigned c;      /* divisor as written (bit pattern) */
    unsigned d;      /* magnitude used by the arithmetic */
    int      kind;   /* 1 = 2^k, 0 = m < 2^32, 2 = add form */
    unsigned M;      /* magic (or the mask, for kind == 1) */
    int      shift;  /* L, or k for kind == 1 */
} DivConst;

/* Fills *M / *shift; returns 1 = power of two, 0 = m < 2^32, 2 = add form,
 * -1 = this constant must keep the hardware divide. */
static int divconst_magic(unsigned d, unsigned *M, int *shift) {
    int L = 0;
    unsigned long long num, m, e;
    if (d < 2) return -1;
    if ((d & (d - 1)) == 0) {                  /* 2^k */
        int k = 0;
        while (k < 31 && ((unsigned)1u << (k + 1)) <= d) k++;
        *M = d;
        *shift = k;
        return 1;
    }
    while (((unsigned long long)1 << L) < (unsigned long long)d) L++;
    if (L <= 31) {
        num = (unsigned long long)1 << (32 + L);
        m = (num + (unsigned long long)d - 1) / (unsigned long long)d;
        e = m * (unsigned long long)d - num;
    } else {
        /* L == 32 means d > 2^31, so 2^64 is not representable.  Use
         * ceil(2^64 / d) = floor((2^64 - 1) / d) + 1; the wrapped product is
         * then exactly the error term (it is smaller than d <= 2^32). */
        m = 0xFFFFFFFFFFFFFFFFull / (unsigned long long)d + 1;
        e = m * (unsigned long long)d;
    }
    if (e > ((unsigned long long)1 << L)) return -1;
    *shift = L;
    if (m >= 0x100000000ull) {                 /* needs the add form */
        *M = (unsigned)(m - 0x100000000ull);
        return 2;
    }
    *M = (unsigned)m;
    return 0;
}

/* 1 when the divisor can be turned into a sequence at all.  Called where the
 * divisor push is seen, so a refused constant never disturbs the stack. */
static int divconst_prepare(DivConst *st, int is_unsigned, unsigned c) {
    int kind;
    st->is_unsigned = is_unsigned;
    st->c = c;
    st->M = 0;
    st->shift = 0;
    st->kind = 0;
    if (c == 0) return 0;                      /* UB: keep the divide */
    if (is_unsigned) {
        if (c == 1) return 0;
        st->d = c;
    } else {
        if (c == 1) return 0;
        if (c == 0xFFFFFFFFu) return 0;         /* -1: INT_MIN / -1 overflows */
        if (c == 0x80000000u) return 0;         /* |c| == 2^31 */
        st->d = (c & 0x80000000u) ? (0u - c) : c;
    }
    kind = divconst_magic(st->d, &st->M, &st->shift);
    if (kind < 0) return 0;
    st->kind = kind;
    return 1;
}

/* Quotient of the magnitudes: |n| (or the unsigned dividend) is in r0, the
 * quotient is left in r0.  Clobbers r1-r3. */
static void divconst_q(AsmBuffer *b, const DivConst *st) {
    if (st->kind == 1) {                       /* 2^k */
        asmbuf_puts(b, "    LSR r0, r0, #");
        asmbuf_int(b, st->shift);
        asmbuf_putc(b, '\n');
        return;
    }
    emit_mov_imm(b, 1, (int)st->M);
    emit_line(b, "UMULL r2, r3, r0, r1");
    if (st->kind == 0) {                       /* m < 2^32 */
        asmbuf_puts(b, "    LSR r0, r3, #");
        asmbuf_int(b, st->shift);
        asmbuf_putc(b, '\n');
        return;
    }
    /* add form (m >= 2^32); shift is L - 1 >= 1 because L == 1 would mean
     * d == 2, which is a power of two and never reaches here. */
    emit_line(b, "SUB r2, r0, r3");
    emit_line(b, "LSR r2, r2, #1");
    emit_line(b, "ADD r2, r3, r2");
    asmbuf_puts(b, "    LSR r0, r2, #");
    asmbuf_int(b, st->shift - 1);
    asmbuf_putc(b, '\n');
}

/* Emits one whole IR_DIV (is_mod == 0) / IR_MOD (is_mod == 1).  The divisor
 * push was already dropped, so the dividend is the stack top.  Pushes the
 * result back, exactly like the hardware-divide path it replaces. */
static void divconst_emit(AsmBuffer *b, const DivConst *st, int is_mod) {
    if (st->is_unsigned) {
        emit_pop_r0(b);                        /* dividend */
        if (is_mod && st->kind == 1) {          /* n & (2^k - 1) */
            unsigned mask = st->d - 1;
            if (mask <= 255) {
                asmbuf_puts(b, "    AND r0, r0, #");
                asmbuf_int(b, (long long)mask);
                asmbuf_putc(b, '\n');
            } else {
                emit_mov_imm(b, 1, (int)mask);
                emit_line(b, "AND r0, r0, r1");
            }
            emit_push_r0(b);
            return;
        }
        if (is_mod) emit_push_r0(b);           /* keep the dividend */
        divconst_q(b, st);
        if (is_mod) {
            emit_pop_r1(b);                    /* dividend */
            emit_mov_imm(b, 2, (int)st->d);
            emit_line(b, "MUL r0, r0, r2");
            emit_line(b, "SUB r0, r1, r0");
        }
        emit_push_r0(b);
        return;
    }
    /* signed: |n| / |d|, then put the quotient's sign back on. */
    emit_pop_r0(b);                            /* n */
    if (is_mod) emit_push_r0(b);               /* keep n for the remainder */
    emit_line(b, "ASR r1, r0, #31");
    emit_line(b, "EOR r0, r0, r1");
    emit_line(b, "SUB r0, r0, r1");            /* |n| */
    if (st->c & 0x80000000u)
        emit_line(b, "MVN r1, r1");            /* a negative divisor flips the quotient's sign */
    emit_line(b, "PUSH {r1}");                 /* the sign must survive divconst_q (r1-r3) */
    divconst_q(b, st);
    emit_pop_r1(b);
    emit_line(b, "EOR r0, r0, r1");
    emit_line(b, "SUB r0, r0, r1");            /* q */
    if (is_mod) {
        emit_pop_r1(b);                        /* n */
        emit_mov_imm(b, 2, (int)st->c);        /* arithmetic uses the real divisor */
        emit_line(b, "MUL r0, r0, r2");
        emit_line(b, "SUB r0, r1, r0");
    }
    emit_push_r0(b);
}
#endif /* ARKCC_FEATURE_DIVCONST */

/* --- C99 _Complex double on the expression stack ---------------------------
 * A complex value occupies four stack words, laid out exactly like the
 * 16-byte IR_STORE case writes the object: for a value X
 *     X_real_low = sp+4    X_real_high = sp+0    (real part on top)
 *     X_imag_low = sp+12   X_imag_high = sp+8
 * which is what pushing imag-low, imag-high, real-low, real-high produces.
 * Two operands therefore stack as B at sp+0..12 above A at sp+16..28.
 *
 * Every routine below only touches r0-r3 and sp, so nothing has to be saved
 * and the emitted sequence is the same with and without --reg-top.
 */
static void arm_push_reg(AsmBuffer *b, int reg) {
    char s[16];
    snprintf(s, sizeof s, "PUSH {r%d}", reg);
    emit_line(b, s);
}
static void arm_ldr_sp(AsmBuffer *b, int reg, int off) {
    char s[40];
    if (off) snprintf(s, sizeof s, "LDR r%d, [sp, #%d]", reg, off);
    else     snprintf(s, sizeof s, "LDR r%d, [sp]", reg);
    emit_line(b, s);
}
static void arm_str_sp(AsmBuffer *b, int reg, int off) {
    char s[40];
    if (off) snprintf(s, sizeof s, "STR r%d, [sp, #%d]", reg, off);
    else     snprintf(s, sizeof s, "STR r%d, [sp]", reg);
    emit_line(b, s);
}
static void arm_word_hex(AsmBuffer *b, unsigned int w) {
    char s[32];
    snprintf(s, sizeof s, "    .word 0x%08x", w);
    emit_line(b, s);
}
/* r0:r1 = double at [sp+alo]/[sp+ahi], r2:r3 = double at [sp+blo]/[sp+bhi],
 * then call helper (AAPCS soft-float: first double in r0:r1, second in r2:r3,
 * low word first). */
static void arm_dcall(AsmBuffer *b, const char *helper,
                      int alo, int ahi, int blo, int bhi) {
    char s[32];
    arm_ldr_sp(b, 0, alo);
    arm_ldr_sp(b, 1, ahi);
    arm_ldr_sp(b, 2, blo);
    arm_ldr_sp(b, 3, bhi);
    snprintf(s, sizeof s, "BL %s", helper);
    emit_line(b, s);
}
static void arm_call1(AsmBuffer *b, const char *helper) {
    char s[32];
    snprintf(s, sizeof s, "BL %s", helper);
    emit_line(b, s);
}
/* r0:r1 = real part, r2:r3 = imaginary part -> push as a complex value. */
static void arm_cplx_push4(AsmBuffer *b) {
    arm_push_reg(b, 2);
    arm_push_reg(b, 3);
    arm_push_reg(b, 0);
    arm_push_reg(b, 1);
}
/* complex + and -: componentwise, no interaction between the parts. */
static void arm_cplx_addsub(AsmBuffer *b, const char *helper) {
    /* Imaginary part first; its result is parked in an 8-byte scratch slot
     * because the real part's loads and the helper's own use of r0-r3 would
     * otherwise destroy it. After SUB sp,#8 the input block (and therefore
     * every offset below) has moved up by exactly 8 bytes. */
    arm_dcall(b, helper, 28, 24, 12, 8);          /* A_im / B_im */
    emit_line(b, "SUB sp, sp, #8");
    arm_str_sp(b, 0, 0);
    arm_str_sp(b, 1, 4);
    arm_dcall(b, helper, 28, 24, 12, 8);          /* A_re / B_re */
    arm_ldr_sp(b, 2, 0);
    arm_ldr_sp(b, 3, 4);
    emit_add_sp(b, 40);                            /* scratch + both operands */
    arm_cplx_push4(b);
}
/* (a+bi)(c+di) = (ac-bd) + (ad+bc)i */
static void arm_cplx_mul(AsmBuffer *b) {
    emit_line(b, "SUB sp, sp, #32");               /* operands now at sp+32 */
    arm_dcall(b, "__aeabi_dmul", 52, 48, 36, 32);   /* ac */
    arm_str_sp(b, 0, 0);
    arm_str_sp(b, 1, 4);
    arm_dcall(b, "__aeabi_dmul", 60, 56, 44, 40);   /* bd */
    emit_line(b, "MOV r2, r0");
    emit_line(b, "MOV r3, r1");
    arm_ldr_sp(b, 0, 0);
    arm_ldr_sp(b, 1, 4);
    arm_call1(b, "__aeabi_dsub");                   /* ac - bd = real */
    arm_str_sp(b, 0, 16);
    arm_str_sp(b, 1, 20);
    arm_dcall(b, "__aeabi_dmul", 52, 48, 44, 40);   /* ad */
    arm_str_sp(b, 0, 0);
    arm_str_sp(b, 1, 4);
    arm_dcall(b, "__aeabi_dmul", 60, 56, 36, 32);   /* bc */
    emit_line(b, "MOV r2, r0");
    emit_line(b, "MOV r3, r1");
    arm_ldr_sp(b, 0, 0);
    arm_ldr_sp(b, 1, 4);
    arm_call1(b, "__aeabi_dadd");                   /* ad + bc = imag */
    emit_line(b, "MOV r2, r0");
    emit_line(b, "MOV r3, r1");
    arm_ldr_sp(b, 0, 16);
    arm_ldr_sp(b, 1, 20);
    emit_add_sp(b, 64);                             /* scratch + both operands */
    arm_cplx_push4(b);
}
/* (a+bi)/(c+di) = ((ac+bd) + (bc-ad)i) / (c*c + d*d) */
static void arm_cplx_div(AsmBuffer *b) {
    emit_line(b, "SUB sp, sp, #40");               /* operands now at sp+40 */
    arm_dcall(b, "__aeabi_dmul", 44, 40, 44, 40);   /* c*c        -> S0 */
    arm_str_sp(b, 0, 0);
    arm_str_sp(b, 1, 4);
    arm_dcall(b, "__aeabi_dmul", 52, 48, 52, 48);   /* d*d        -> S1 */
    arm_str_sp(b, 0, 8);
    arm_str_sp(b, 1, 12);
    arm_dcall(b, "__aeabi_dadd", 0, 4, 8, 12);      /* den        -> S2 */
    arm_str_sp(b, 0, 16);
    arm_str_sp(b, 1, 20);
    arm_dcall(b, "__aeabi_dmul", 60, 56, 44, 40);   /* ac         -> S0 */
    arm_str_sp(b, 0, 0);
    arm_str_sp(b, 1, 4);
    arm_dcall(b, "__aeabi_dmul", 68, 64, 52, 48);   /* bd         -> S1 */
    arm_str_sp(b, 0, 8);
    arm_str_sp(b, 1, 12);
    arm_dcall(b, "__aeabi_dadd", 0, 4, 8, 12);      /* ac+bd      -> S3 */
    arm_str_sp(b, 0, 24);
    arm_str_sp(b, 1, 28);
    arm_dcall(b, "__aeabi_dmul", 68, 64, 44, 40);   /* bc         -> S1 */
    arm_str_sp(b, 0, 8);
    arm_str_sp(b, 1, 12);
    arm_dcall(b, "__aeabi_dmul", 60, 56, 52, 48);   /* ad         -> S0 */
    arm_str_sp(b, 0, 0);
    arm_str_sp(b, 1, 4);
    arm_dcall(b, "__aeabi_dsub", 8, 12, 0, 4);      /* bc-ad      -> S4 */
    arm_str_sp(b, 0, 32);
    arm_str_sp(b, 1, 36);
    arm_dcall(b, "__aeabi_ddiv", 24, 28, 16, 20);   /* real */
    arm_str_sp(b, 0, 24);
    arm_str_sp(b, 1, 28);
    arm_dcall(b, "__aeabi_ddiv", 32, 36, 16, 20);   /* imag */
    emit_line(b, "MOV r2, r0");
    emit_line(b, "MOV r3, r1");
    arm_ldr_sp(b, 0, 24);
    arm_ldr_sp(b, 1, 28);
    emit_add_sp(b, 72);                             /* scratch + both operands */
    arm_cplx_push4(b);
}
/* == / != on two complex operands (C99 6.5.9: nothing else is defined). */
static void arm_cplx_cmp(AsmBuffer *b, int want_ne) {
    /* Two complex values are equal when both parts are equal.  libgcc has no
     * __aeabi_dcmpne (checked with nm on the no-FPU v7-m libgcc.a: only
     * dcmpeq/dcmplt/dcmple/dcmpgt/dcmpge/dcmpun exist), so `!=` is built as
     * the negation of `==` instead of naming a helper that does not link.
     * It is also the NaN-correct form: dcmpeq answers 0 for an unordered
     * pair, so `z != z` is 1 for a complex NaN, as IEEE requires. */
    emit_line(b, "SUB sp, sp, #8");                /* operands now at sp+8 */
    arm_dcall(b, "__aeabi_dcmpeq", 12, 8, 28, 24);
    arm_str_sp(b, 0, 0);
    arm_dcall(b, "__aeabi_dcmpeq", 20, 16, 36, 32);
    arm_ldr_sp(b, 1, 0);
    emit_line(b, "ANDS r0, r0, r1");
    if (want_ne) emit_line(b, "EORS r0, r0, #1");
    emit_add_sp(b, 40);                             /* scratch + both operands */
    arm_push_reg(b, 0);
}

#if ARKCC_FEATURE_FPU_HW
/* Hardware VFP floating-point path helpers.
 * Convention: floating-point values are stored on the stack as integer bit patterns (single=1 slot, double=2 slots low/high).
 * Pop operands to r0/r1 (single) or r0/r1+r2/r3 (double), move them into VFP registers via VMOV,
 * perform the VFP operation, then move the result back to r0 (single) or r0/r1 (double) and push. */

/* Single-precision binary op: pop b(s1), a(s0), emit VOP.F32 s0,s0,s1, push result s0. */
static void emit_vfp_f32_binop(AsmBuffer *b, const char *vop) {
    emit_pop_r1(b); emit_pop_r0(b);
    emit_line(b, "VMOV s0, r0");
    emit_line(b, "VMOV s1, r1");
    asmbuf_puts(b, "    ");
    asmbuf_puts(b, vop);
    asmbuf_puts(b, ".F32 s0, s0, s1\n");
    emit_line(b, "VMOV r0, s0");
    emit_push_r0(b);
}

/* Double-precision binary op: pop b(d1), a(d0), emit VOP.F64 d0,d0,d1, push result d0. */
static void emit_vfp_f64_binop(AsmBuffer *b, const char *vop) {
    emit_line(b, "POP {r3}");  /* b_high */
    emit_line(b, "POP {r2}");  /* b_low  */
    emit_line(b, "POP {r1}");  /* a_high */
    emit_line(b, "POP {r0}");  /* a_low  */
    emit_line(b, "VMOV s0, r0");
    emit_line(b, "VMOV s1, r1");
    emit_line(b, "VMOV s2, r2");
    emit_line(b, "VMOV s3, r3");
    asmbuf_puts(b, "    ");
    asmbuf_puts(b, vop);
    asmbuf_puts(b, ".F64 d0, d0, d1\n");
    emit_line(b, "VMOV r0, s0");
    emit_line(b, "VMOV r1, s1");
    emit_push_r0(b);
    asmbuf_puts(b, "    PUSH {r1}\n");
}
#endif /* ARKCC_FEATURE_FPU_HW */

static void emit_label(AsmBuffer *b, const char *fn, int n) {
    asmbuf_puts(b, ".L_");
    asmbuf_puts(b, fn);
    asmbuf_putc(b, '_');
    asmbuf_int(b, n);
    asmbuf_puts(b, ":\n");
}

static void emit_b_label(AsmBuffer *b, const char *op, const char *fn, int n) {
    asmbuf_puts(b, "    ");
    asmbuf_puts(b, op);
    asmbuf_puts(b, " .L_");
    asmbuf_puts(b, fn);
    asmbuf_putc(b, '_');
    asmbuf_int(b, n);
    asmbuf_putc(b, '\n');
}

/* Emit binary operation. The high bit 0x100 of aux marks unsigned comparison/shift-right:
 *   - TOK_LT/GT/LE/GE: when unsigned, use LO/HI/LS/HS conditions instead of LT/GT/LE/GE
 *   - TOK_SHR: when unsigned, use LSR (logical shift right) instead of ASR (arithmetic shift right)
 * ARM Thumb-2 condition codes: LO=CC(3), HI(8), LS(9), HS=CS(2) */
/* The conditional-move tail shared by the six comparison ops: after CMP has
 * set the flags, produce 1 or 0 in r0.  Factored out because -fopt-imm needs
 * the same sequence behind "CMP r0, #imm" (see emit_binary_imm). */
static void emit_cmp_result(AsmBuffer *b, int base_op, int is_unsigned) {
    switch (base_op) {
        case (int)TOK_EQ:
            emit_line(b, "ITE EQ");
            emit_line(b, "MOVEQ r0, #1");
            emit_line(b, "MOVNE r0, #0");
            break;
        case (int)TOK_NE:
            emit_line(b, "ITE NE");
            emit_line(b, "MOVNE r0, #1");
            emit_line(b, "MOVEQ r0, #0");
            break;
        case (int)TOK_LT:
            if (is_unsigned) { emit_line(b, "ITE LO"); emit_line(b, "MOVLO r0, #1"); emit_line(b, "MOVHS r0, #0"); }
            else             { emit_line(b, "ITE LT"); emit_line(b, "MOVLT r0, #1"); emit_line(b, "MOVGE r0, #0"); }
            break;
        case (int)TOK_GT:
            if (is_unsigned) { emit_line(b, "ITE HI"); emit_line(b, "MOVHI r0, #1"); emit_line(b, "MOVLS r0, #0"); }
            else             { emit_line(b, "ITE GT"); emit_line(b, "MOVGT r0, #1"); emit_line(b, "MOVLE r0, #0"); }
            break;
        case (int)TOK_LE:
            if (is_unsigned) { emit_line(b, "ITE LS"); emit_line(b, "MOVLS r0, #1"); emit_line(b, "MOVHI r0, #0"); }
            else             { emit_line(b, "ITE LE"); emit_line(b, "MOVLE r0, #1"); emit_line(b, "MOVGT r0, #0"); }
            break;
        case (int)TOK_GE:
            if (is_unsigned) { emit_line(b, "ITE HS"); emit_line(b, "MOVHS r0, #1"); emit_line(b, "MOVLO r0, #0"); }
            else             { emit_line(b, "ITE GE"); emit_line(b, "MOVGE r0, #1"); emit_line(b, "MOVLT r0, #0"); }
            break;
        default:
            break;
    }
}

#if ARKCC_FEATURE_OPT_CBRANCH
/* --- -fopt-cbranch: the branch mnemonic for a comparison -------------------
 *
 * `if (a == b)` reaches the backend as IR_BINARY(TOK_EQ) followed by IR_JZ, so
 * the emitted code materialises the 0/1 result (ITE + two MOVs) and then tests
 * it again (CMP r0, #0 + BEQ) -- six instructions for something the flags left
 * by the first CMP can already answer.  When the comparison's result is
 * consumed by the very next conditional branch, the value is dead, so the
 * emitter can branch on the original condition directly.
 *
 * want_true = 1 means "branch when the comparison is true" (IR_JNZ), 0 means
 * "branch when it is false" (IR_JZ).  The six conditions are simply inverted
 * for the second case, with the unsigned forms LO/LS/HI/HS substituted for
 * LT/LE/GT/GE.  A non-comparison returns NULL and nothing changes. */
static const char *cbranch_mnemonic(int base_op, int is_unsigned, int want_true) {
    switch (base_op) {
        case (int)TOK_EQ: return want_true ? "BEQ" : "BNE";
        case (int)TOK_NE: return want_true ? "BNE" : "BEQ";
        case (int)TOK_LT:
            return want_true ? (is_unsigned ? "BLO" : "BLT")
                             : (is_unsigned ? "BHS" : "BGE");
        case (int)TOK_GT:
            return want_true ? (is_unsigned ? "BHI" : "BGT")
                             : (is_unsigned ? "BLS" : "BLE");
        case (int)TOK_LE:
            return want_true ? (is_unsigned ? "BLS" : "BLE")
                             : (is_unsigned ? "BHI" : "BGT");
        case (int)TOK_GE:
            return want_true ? (is_unsigned ? "BHS" : "BGE")
                             : (is_unsigned ? "BLO" : "BLT");
    }
    return 0;
}
#endif

static void emit_binary(AsmBuffer *b, int op) {
    int is_unsigned = (op & 0x100) != 0;
    int base_op = op & ~0x100;
    switch (base_op) {
        case (int)TOK_PLUS:  emit_line(b, "ADD r0, r0, r1"); break;
        case (int)TOK_MINUS: emit_line(b, "SUB r0, r0, r1"); break;
        case (int)TOK_MUL:   emit_line(b, "MUL r0, r1");     break;
        case (int)TOK_DIV:   emit_line(b, "SDIV r0, r0, r1"); break;
        case (int)TOK_MOD:
            emit_line(b, "SDIV r2, r0, r1");
            emit_line(b, "MUL r2, r1");
            emit_line(b, "SUB r0, r0, r2");
            break;
        case (int)TOK_BAND:  emit_line(b, "AND r0, r1");     break;
        case (int)TOK_BOR:   emit_line(b, "ORR r0, r1");     break;
        case (int)TOK_BXOR:  emit_line(b, "EOR r0, r1");     break;
        case (int)TOK_SHL:   emit_line(b, "LSL r0, r1");     break;
        case (int)TOK_SHR:
            /* Unsigned uses LSR (logical shift right), signed uses ASR (arithmetic shift right) */
            emit_line(b, is_unsigned ? "LSR r0, r1" : "ASR r0, r1");
            break;
        case (int)TOK_EQ: case (int)TOK_NE:
        case (int)TOK_LT: case (int)TOK_GT:
        case (int)TOK_LE: case (int)TOK_GE:
            emit_line(b, "CMP r0, r1");
            emit_cmp_result(b, base_op, is_unsigned);
            break;
        default:
            emit_line(b, "; unknown binary op");
            break;
    }
}

#if ARKCC_FEATURE_OPT_IMM
/* ThumbExpandImm() representability, defined with the assembler far below. */
static int thumb_imm12_a(unsigned val, unsigned *out_i, unsigned *out_imm3,
                         unsigned *out_imm8);

/* --- -fopt-imm: fold a constant operand into the instruction --------------
 *
 * The IR is a stack machine, so `a + 16` arrives as PUSH a / PUSH 16 / BINARY.
 * Emitting that literally puts 16 through the value stack (a MOV, a PUSH, a
 * POP and a register copy) before the ADD; on the HAL corpus that is where
 * most of the 5.7k "MOV rN, #imm" instructions go.  Nearly every ARM
 * data-processing instruction has an immediate form, so the constant push can
 * be dropped and the consumer emitted as `ADD r0, r0, #16`.
 *
 * Nothing about the value stack's shape changes on the refused paths: a
 * constant that is not encodable (or an op with no immediate form: MUL, DIV,
 * MOD, float) keeps the push and the register form exactly as before.
 *
 * `left` says the constant was the *left* operand (`16 + a`): only the
 * commutative ops are folded then, because the immediate always becomes the
 * right-hand one.  Comparisons are therefore excluded on that path.
 *
 * Returns 1 when the op has a foldable immediate form.  With emit == 0 it only
 * decides; the caller uses that to decide whether to swallow the push, so the
 * decision and the emission cannot disagree. */
static int emit_binary_imm(AsmBuffer *b, int op, int v, int left, int emit) {
    int is_unsigned = (op & 0x100) != 0;
    int base_op = op & ~0x100;
    char t[64];
    switch (base_op) {
    case (int)TOK_PLUS:
        if (!left && v >= 0 && v <= 4095) {
            if (emit) { snprintf(t, sizeof t, "ADD r0, r0, #%d", v); emit_line(b, t); }
            return 1;
        }
        /* a + (-k) is a - k: the same instruction with the sign moved into
         * the mnemonic, so -1 folds as readily as 1. */
        if (v < 0 && v >= -4095) {
            if (emit) { snprintf(t, sizeof t, "SUB r0, r0, #%d", -v); emit_line(b, t); }
            return 1;
        }
        return 0;
    case (int)TOK_MINUS:
        if (!left && v >= 0 && v <= 4095) {
            if (emit) { snprintf(t, sizeof t, "SUB r0, r0, #%d", v); emit_line(b, t); }
            return 1;
        }
        if (!left && v < 0 && v >= -4095) {
            if (emit) { snprintf(t, sizeof t, "ADD r0, r0, #%d", -v); emit_line(b, t); }
            return 1;
        }
        return 0;
    case (int)TOK_BAND:
    case (int)TOK_BOR:
    case (int)TOK_BXOR:
        if (v < 0) return 0;
        {
            unsigned a, c, d;
            if (!thumb_imm12_a((unsigned)v, &a, &c, &d)) return 0;
        }
        if (emit) {
            snprintf(t, sizeof t, "%s r0, r0, #%d",
                     base_op == (int)TOK_BAND ? "AND" : base_op == (int)TOK_BOR ? "ORR" : "EOR", v);
            emit_line(b, t);
        }
        return 1;
    case (int)TOK_SHL:
        if (v < 0 || v > 31) return 0;
        if (emit) { snprintf(t, sizeof t, "LSL r0, r0, #%d", v); emit_line(b, t); }
        return 1;
    case (int)TOK_SHR:
        if (v < 0 || v > 31) return 0;
        if (emit) { snprintf(t, sizeof t, "%s r0, r0, #%d", is_unsigned ? "LSR" : "ASR", v); emit_line(b, t); }
        return 1;
    case (int)TOK_EQ: case (int)TOK_NE:
    case (int)TOK_LT: case (int)TOK_GT:
    case (int)TOK_LE: case (int)TOK_GE: {
        unsigned a, c, d;
        if (left) return 0;                    /* not commutative */
        if (v < 0) return 0;
        /* CMP rn, #imm: the 16-bit form takes 0..255, the 32-bit form a
         * modified immediate.  Anything else would be an assembler error. */
        if (v > 255 && !thumb_imm12_a((unsigned)v, &a, &c, &d)) return 0;
        if (emit) {
            snprintf(t, sizeof t, "CMP r0, #%d", v);
            emit_line(b, t);
            emit_cmp_result(b, base_op, is_unsigned);
        }
        return 1;
    }
    default:
        return 0;
    }
}
#endif /* ARKCC_FEATURE_OPT_IMM */

static void emit_unary(AsmBuffer *b, int op) {
    switch (op) {
        case (int)TOK_MINUS:
            emit_line(b, "NEG r0, r0");
            break;
        case (int)TOK_BNOT:
            emit_line(b, "MVN r0, r0");
            break;
        case (int)TOK_NOT:
            /* FIX(logical-not): the old sequence was
               CMP / MOV r0,#0 / IT EQ / MOVEQ r0,#1.
               "MOV r0, #0" assembles to 16-bit "movs r0,#0" which
               overwrites the flags set by CMP, so IT EQ always fired
               and "!x" was constantly 1 (this deadlocked
               while(!__HAL_PWR_GET_FLAG(PWR_FLAG_VOSRDY)) on the H7).
               Use the same ITE + two conditional MOV shape as
               TOK_EQ/TOK_NE: conditional MOVs do not update flags. */
            emit_line(b, "CMP r0, #0");
            emit_line(b, "ITE EQ");
            emit_line(b, "MOVEQ r0, #1");
            emit_line(b, "MOVNE r0, #0");
            break;
        default:
            emit_line(b, "; unknown unary op");
            break;
    }
}

/* ------------------- frame accesses past the imm12 range -------------------
 * "[r6, #off]" carries a 12-bit byte offset.  A function whose frame is larger
 * than that cannot reach its high slots in one instruction -- and a single
 * `char buf[5000];` is enough to push every later local past 4095.  That used to
 * be encoded as "off & 0xFFF", i.e. a load or store of the *wrong* slot with no
 * diagnostic at all.
 *
 * The fix is the base computation the instruction needs:
 *     LDR r0, [r6, #5000]
 *   ->MOVW ip, #5000 / MOVT ip, #0 / ADD ip, r6, ip / LDR r0, [ip]
 * and the same for "ADD rX, r6, #off" (taking a local's address).  ip (r12) is
 * the only register no emitted sequence keeps alive across a local access.
 *
 * This is a correctness pass, not an optimisation: it runs unconditionally and
 * only touches lines that would otherwise be refused by the encoder. */
static void ark_fix_far_offset(AsmBuffer *b, int from) {
    AsmBuffer out;
    int pos = from;
    int changed = 0;
    char line[256];

    /* Cheap first look: most functions have no such access at all. */
    {
        int p2 = from, found = 0;
        while (p2 + 8 <= b->len) {
            if (b->buf[p2] == 'r' && b->buf[p2+1] == '6' && b->buf[p2+2] == ',' &&
                b->buf[p2+3] == ' ') {
                long n = 0;
                const char *q = b->buf + p2 + 4;   /* '#' of "r6, #" */
                int ok = 1;
                if (*q == '#') {
                    q++;
                    if (*q < '0' || *q > '9') ok = 0;
                    while (ok && *q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
                    if (ok && n > 4095) { found = 1; break; }
                }
            }
            p2++;
        }
        if (!found) return;
    }

    asmbuf_init(&out);
    for (pos = from; pos < b->len; ) {
        int len = 0, i;
        long n = 0;
        int big = 0;
        const char *br = 0;
        const char *s;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (len >= (int)sizeof(line)) {
            for (i = 0; i < len; i++) asmbuf_putc(&out, b->buf[pos + i]);
            asmbuf_putc(&out, '\n');
            pos += len + 1;
            continue;
        }
        for (i = 0; i < len; i++) line[i] = b->buf[pos + i];
        line[len] = 0;

        /* locate "r6, #<n>" and decide whether n is out of range */
        s = line;
        while (*s && !(s[0] == 'r' && s[1] == '6' && s[2] == ',' && s[3] == ' ')) s++;
        if (*s) {
            const char *q = s + 4;              /* '#' of "r6, #" */
            int ok = (*q == '#');
            if (ok) {
                q++;
                if (*q < '0' || *q > '9') ok = 0;
                while (ok && *q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
            }
            if (ok && n > 4095) {
                big = 1;
                br = s;              /* points at "r6, #..." */
                if (br > line && br[-1] == '[') br--;   /* include the '[' */
            }
        }

        if (!big) {
            for (i = 0; i < len; i++) asmbuf_putc(&out, b->buf[pos + i]);
            asmbuf_putc(&out, '\n');
            pos += len + 1;
            continue;
        }

        /* Emit the address computation, then the original instruction against
         * it.  Two shapes reach here and they need different rewrites:
         *   "    LDR r0, [r6, #4904]"  ->  MOVW/MOVT, ADD ip,r6,ip, "LDR r0, [ip]"
         *   "    ADD r0, r6, #4904"    ->  MOVW/MOVT,             "ADD r0, r6, ip"
         * The second shape takes the address of a far local, and a big frame
         * hits it first: every array past 4095 bytes is reached through its
         * address.  Two separate bugs came from treating it like the first:
         * copying the head and appending "[ip]" produced "ADD r0, [ip]", which
         * the assembler rejects; and emitting "ADD ip, r6, ip" first made the
         * next "ADD r0, r6, ip" compute r6 + (r6 + n), which faults at once.
         */
        asmbuf_puts(&out, "    MOVW ip, #");
        asmbuf_int(&out, (long)n & 0xFFFF);
        asmbuf_putc(&out, '\n');
        asmbuf_puts(&out, "    MOVT ip, #");
        asmbuf_int(&out, ((long)n >> 16) & 0xFFFF);
        asmbuf_putc(&out, '\n');
        if (br != s) {
            int head = (int)(br - line);   /* just before the '[' */
            asmbuf_puts(&out, "    ADD ip, r6, ip\n");
            for (i = 0; i < head; i++) asmbuf_putc(&out, line[i]);
            asmbuf_puts(&out, "[ip]\n");
        } else {
            int head = (int)(br - line);   /* "    ADD Rt, " */
            for (i = 0; i < head; i++) asmbuf_putc(&out, line[i]);
            asmbuf_puts(&out, "r6, ip\n");
        }
        changed++;
        pos += len + 1;
    }

    if (changed) {
        asmbuf_reserve(b, from + out.len);
        if (from + out.len + 1 <= b->cap) {
            int i;
            for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
            b->buf[from + out.len] = 0;
            b->len = from + out.len;
        }
    }
}

#if ARKCC_FEATURE_OPT_PEEP || ARKCC_FEATURE_OPT_COPYPROP || ARKCC_FEATURE_OPT_LIVE
/* --------------------------- peephole cleanup ----------------------------
 * Two copy-elimination rules over one function's emitted text.  Neither needs
 * liveness analysis, because each rule only turns a store/load round trip into
 * the register move it already was:
 *
 *   R1  PUSH {rX} <padding> POP {rY}   ->  MOV rY, rX   (nothing at all if X==Y)
 *       The stack machine materialises every intermediate with a PUSH and
 *       consumes it with a POP; with nothing in between the pair is a plain
 *       register copy routed through memory.  Padding (blank lines, comments,
 *       directives, .loc) may sit between the two; a label may not, because a
 *       branch could reach it with the value stack in a different state.  The
 *       pair is balanced (sp is unchanged) so deleting it is free of side
 *       effects on the frame.
 *
 *   R3  STR rX, [r6, #o] / LDR rX, [r6, #o]   ->  keep the STR, drop the LDR
 *       A load of the slot just written from the same register only repeats a
 *       value rX already holds.  The offset, the width and the register must
 *       all match, and the two lines must be adjacent: a volatile access is
 *       separated from its partner by a DMB SY, so it never matches, and the
 *       store itself is kept, so no memory write is ever removed.
 *
 *   R5  ADD rD, rS, #0   ->  MOV rD, rS        (deleted outright when D == S)
 *       The stack machine materialises a copy -- `x = y`, a frame base moved
 *       into a scratch, an address with a zero displacement -- as a three
 *       operand ADD with a zero immediate.  `ADD` without `S` writes no flags,
 *       so a zero displacement is exactly a copy; but that form has no 16-bit
 *       encoding for a zero immediate, so it costs four bytes and says nothing
 *       a two-byte `MOV` does not say.  The rewrite is done here rather than at
 *       emission because the later passes only know MOV: the liveness sweep
 *       deletes a dead `MOV` and copy propagation forwards a live one, and
 *       neither rule fires on an `ADD`.  Rewriting first is what turns those
 *       four-byte copies into zero instructions.
 */
#define PP_MAX_LINES 8192

static int pp_enabled(void) {
    return g_config.enable_opt_peep ? 1 : 0;
}

/* Copy one line without leading blanks and without a trailing CR.  Returns the
 * length, or -1 when it does not fit in dst. */
static int pp_trim(const char *ln, int len, char *dst, int cap) {
    int i = 0, o = 0;
    while (i < len && (ln[i] == ' ' || ln[i] == '\t')) i++;
    while (i < len) {
        char c = ln[i++];
        if (c == '\r') continue;
        if (o + 1 >= cap) return -1;
        dst[o++] = c;
    }
    dst[o] = 0;
    return o;
}

/* Exact "PUSH {rN}" / "POP {rN}" naming a single register, either as `rN` or
 * as `ip` -- the emitter spells r12 both ways depending on the site, and a
 * rule that only knows `r12` silently skips the pairs the emitter writes as
 * `POP {ip}` (nine of them in the STM32 corpus). */
static int pp_pushpop(const char *t, int *is_push, int *reg) {
    int i, r = 0;
    if (!((t[0] == 'P' && t[1] == 'U' && t[2] == 'S' && t[3] == 'H') ||
          (t[0] == 'P' && t[1] == 'O' && t[2] == 'P')))
        return 0;
    i = (t[1] == 'U') ? 4 : 3;      /* PUSH is four letters, POP is three */
    if (t[i] != ' ' || t[i + 1] != '{') return 0;
    i += 2;
    if (t[i] != 'r' || !t[i + 1]) return 0;
    i++;
    if (t[i] == 'i' && t[i + 1] == 'p') {
        r = 12;
        i += 2;
    } else if (t[i] >= '0' && t[i] <= '9') {
        while (t[i] >= '0' && t[i] <= '9') { r = r * 10 + (t[i] - '0'); i++; }
    } else {
        return 0;
    }
    if (r > 12 || t[i] != '}' || t[i + 1] != 0) return 0;
    *is_push = (t[1] == 'U');
    *reg = r;
    return 1;
}

/* The name the emitter prints for a register: `ip` for r12, `rN` otherwise. */
static void pp_rname(int r, char *buf, int cap) {
    if (r == 12) snprintf(buf, cap, "ip");
    else snprintf(buf, cap, "r%d", r);
}

/* Does this line name the register whose text is `name` as a whole token?
 * `r1` must not match inside `r10`, and `ip` must not match inside a label. */
static int pp_mentions(const char *t, const char *name) {
    int nl = ark_strlen(name), k;
    const char *p = t;
    while ((p = strstr(p, name)) != 0) {
        char before = (p == t) ? ' ' : p[-1];
        char after = p[nl];
        int bok = !((before >= 'a' && before <= 'z') ||
                    (before >= 'A' && before <= 'Z') ||
                    (before >= '0' && before <= '9') || before == '_');
        int aok = !((after >= 'a' && after <= 'z') ||
                    (after >= 'A' && after <= 'Z') ||
                    (after >= '0' && after <= '9') || after == '_');
        if (bok && aok) return 1;
        p += nl;
        k = 0; (void)k;
    }
    return 0;
}

/* A line that carries no code: blank, comment, or directive.  A label also
 * starts with '.' but ends with ':' and must not be treated as padding. */
static int pp_pad(const char *t) {
    int n;
    if (!t[0]) return 1;
    if (t[0] == ';' || t[0] == '@') return 1;
    if (t[0] == '.') {
        n = ark_strlen(t);
        if (n > 0 && t[n - 1] == ':') return 0;
        return 1;
    }
    return 0;
}

/* Exact "LDR|STR[BH] rN, [r6, #off]".  Returns 1 on a match.  Width is 1 for
 * byte, 2 for half, 4 for word; forms with no plain load/store twin (LDRD,
 * LDRSB, LDRSH, pre/post-indexed) are rejected. */
static int pp_mem(const char *t, int *is_ldr, int *width, int *reg, int *off) {
    int i = 3, w = 4, r = 0, o = 0, ld;
    if (t[0] == 'L' && t[1] == 'D' && t[2] == 'R') ld = 1;
    else if (t[0] == 'S' && t[1] == 'T' && t[2] == 'R') ld = 0;
    else return 0;
    if (t[i] == 'B') { w = 1; i++; }
    else if (t[i] == 'H') { w = 2; i++; }
    if (t[i] != ' ' || t[i + 1] != 'r') return 0;
    i += 2;
    if (t[i] < '0' || t[i] > '9') return 0;
    while (t[i] >= '0' && t[i] <= '9') { r = r * 10 + (t[i] - '0'); i++; }
    if (!(t[i] == ',' && t[i + 1] == ' ' && t[i + 2] == '[' && t[i + 3] == 'r' &&
          t[i + 4] == '6' && t[i + 5] == ',' && t[i + 6] == ' ' && t[i + 7] == '#'))
        return 0;
    i += 8;
    if (t[i] < '0' || t[i] > '9') return 0;
    while (t[i] >= '0' && t[i] <= '9') { o = o * 10 + (t[i] - '0'); i++; }
    if (t[i] != ']' || t[i + 1] != 0) return 0;
    *is_ldr = ld; *width = w; *reg = r; *off = o;
    return 1;
}

static int pp_split_lines(AsmBuffer *b, int from, int *ls, int *ll, int cap) {
    int n = 0, pos = from, len;
    while (pos < b->len) {
        len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (n >= cap) return -1;      /* function too large: leave it alone */
        ls[n] = pos;
        ll[n] = len;
        n++;
        pos += len + 1;
    }
    return n;
}

static void pp_copy_line(AsmBuffer *out, const char *p, int len) {
    int i;
    for (i = 0; i < len; i++) asmbuf_putc(out, p[i]);
    asmbuf_putc(out, '\n');
}

static void pp_splice(AsmBuffer *b, int from, AsmBuffer *out) {
    int i;
    asmbuf_reserve(b, from + out->len + 1);
    for (i = 0; i < out->len; i++) b->buf[from + i] = out->buf[i];
    b->buf[from + out->len] = 0;
    b->len = from + out->len;
}

static void pp_r1(AsmBuffer *b, int from) {
    static int ls[PP_MAX_LINES], ll[PP_MAX_LINES];
    AsmBuffer out;
    char t[256], u[256], mv[32];
    int n, i, changed = 0;
    n = pp_split_lines(b, from, ls, ll, PP_MAX_LINES);
    if (n < 0) return;
    asmbuf_init(&out);
    i = 0;
    while (i < n) {
        int isp = 0, reg = 0;
        if (ll[i] < (int)sizeof t &&
            pp_trim(b->buf + ls[i], ll[i], t, sizeof t) >= 0 &&
            pp_pushpop(t, &isp, &reg) && isp) {
            int j = i + 1, reg2 = 0;
            while (j < n) {
                if (ll[j] >= (int)sizeof u) break;
                if (pp_trim(b->buf + ls[j], ll[j], u, sizeof u) < 0) break;
                if (!pp_pad(u)) break;
                j++;
            }
            if (j < n && ll[j] < (int)sizeof u &&
                pp_trim(b->buf + ls[j], ll[j], u, sizeof u) >= 0) {
                int isp2 = 0;
                if (pp_pushpop(u, &isp2, &reg2) && !isp2) {
                    int k;
                    if (reg != reg2) {
                        snprintf(mv, sizeof mv, "    MOV r%d, r%d\n", reg2, reg);
                        asmbuf_puts(&out, mv);
                    }
                    for (k = i + 1; k < j; k++)
                        pp_copy_line(&out, b->buf + ls[k], ll[k]);
                    i = j + 1;
                    changed++;
                    continue;
                }
            }
        }
        pp_copy_line(&out, b->buf + ls[i], ll[i]);
        i++;
    }
    if (changed) pp_splice(b, from, &out);
}

static void pp_r3(AsmBuffer *b, int from) {
    static int ls[PP_MAX_LINES], ll[PP_MAX_LINES];
    AsmBuffer out;
    char t[256], u[256];
    int n, i, changed = 0;
    n = pp_split_lines(b, from, ls, ll, PP_MAX_LINES);
    if (n < 0) return;
    asmbuf_init(&out);
    i = 0;
    while (i < n) {
        int ld1, w1, r1, o1;
        if (ll[i] < (int)sizeof t &&
            pp_trim(b->buf + ls[i], ll[i], t, sizeof t) >= 0 &&
            pp_mem(t, &ld1, &w1, &r1, &o1) && !ld1) {
            int j = i + 1, match = 0;
            while (j < n) {
                int ld2, w2, r2, o2;
                if (ll[j] >= (int)sizeof u) break;
                if (pp_trim(b->buf + ls[j], ll[j], u, sizeof u) < 0) break;
                if (pp_pad(u)) { j++; continue; }   /* .loc etc. separates nothing */
                if (pp_mem(u, &ld2, &w2, &r2, &o2) && ld2 &&
                    w1 == w2 && o1 == o2 && r1 == r2) match = 1;
                break;
            }
            if (match) {
                int k;
                pp_copy_line(&out, b->buf + ls[i], ll[i]);   /* keep the store */
                for (k = i + 1; k < j; k++)
                    pp_copy_line(&out, b->buf + ls[k], ll[k]);
                k = j + 1;
                /* Repeat loads of the same slot are equally dead: only padding
                 * may separate them, so nothing can have overwritten it. */
                while (k < n) {
                    int ld2, w2, r2, o2;
                    if (ll[k] >= (int)sizeof u) break;
                    if (pp_trim(b->buf + ls[k], ll[k], u, sizeof u) < 0) break;
                    if (pp_pad(u)) {
                        pp_copy_line(&out, b->buf + ls[k], ll[k]);
                        k++;
                        continue;
                    }
                    if (pp_mem(u, &ld2, &w2, &r2, &o2) && ld2 &&
                        w1 == w2 && o1 == o2 && r1 == r2) {
                        k++;
                        continue;
                    }
                    break;
                }
                i = k;
                changed++;
                continue;
            }
        }
        pp_copy_line(&out, b->buf + ls[i], ll[i]);
        i++;
    }
    if (changed) pp_splice(b, from, &out);
}

/* Exact "ADD rD, rS, #0".  `ADDS` is rejected by the literal prefix, and so is
 * a `` symbol, which keeps the rule off label-looking text. */
static int pp_add0(const char *t, int *pd, int *ps) {
    const char *p = t;
    int d = 0, s = 0;
    if (strncmp(p, "ADD r", 5)) return 0;
    p += 5;
    if (*p < '0' || *p > '9') return 0;
    while (*p >= '0' && *p <= '9') { d = d * 10 + (*p - '0'); p++; }
    if (p[0] != ',' || p[1] != ' ' || p[2] != 'r') return 0;
    p += 3;
    if (*p < '0' || *p > '9') return 0;
    while (*p >= '0' && *p <= '9') { s = s * 10 + (*p - '0'); p++; }
    if (strcmp(p, ", #0")) return 0;
    if (d > 15 || s > 15) return 0;
    *pd = d;
    *ps = s;
    return 1;
}

/* R5: `ADD rD, rS, #0` -> `MOV rD, rS`, and nothing at all when D == S.
 * One line in, one line out, so nothing else in the function moves. */
static void pp_r5(AsmBuffer *b, int from) {
    static int ls[PP_MAX_LINES], ll[PP_MAX_LINES];
    AsmBuffer out;
    char t[256], mv[32];
    int n, i, changed = 0;
    n = pp_split_lines(b, from, ls, ll, PP_MAX_LINES);
    if (n < 0) return;
    asmbuf_init(&out);
    for (i = 0; i < n; i++) {
        int d = 0, s = 0;
        if (ll[i] < (int)sizeof t &&
            pp_trim(b->buf + ls[i], ll[i], t, sizeof t) >= 0 &&
            pp_add0(t, &d, &s)) {
            if (d != s) {
                snprintf(mv, sizeof mv, "    MOV r%d, r%d\n", d, s);
                asmbuf_puts(&out, mv);
            }
            changed++;
            continue;
        }
        pp_copy_line(&out, b->buf + ls[i], ll[i]);
    }
    if (changed) pp_splice(b, from, &out);
}

/* How far R6 looks for the matching POP.  The value stack pushes and pops
 * within a handful of instructions when the pool is short; a longer window
 * only risks reaching into unrelated code for no extra match. */
#define PP_R6_WINDOW 12

/* A line that ends R6's search: a label, anything that can transfer control,
 * a nested stack access, or any use of sp (a push, pop or `SUB sp` between
 * the halves would make the POP read a different slot). */
static int pp_r6_stops(const char *t) {
    int n = ark_strlen(t), k = 0;
    char mn[16];
    if (n > 0 && t[n - 1] == ':') return 1;
    while (t[k] && t[k] != ' ' && t[k] != '\t' && k < (int)sizeof mn - 1) {
        mn[k] = t[k];
        k++;
    }
    mn[k] = 0;
    if (pp_mentions(t, "sp")) return 1;
    if (mn[0] == 'B') return 1;              /* B, Bcc, BL, BLX, BX, BIC, BFI */
    if (mn[0] == 'I' && mn[1] == 'T') return 1;
    if (mn[0] == 'C' && (mn[1] == 'B')) return 1;
    if (mn[0] == 'P') return 1;              /* PUSH, POP handled by the caller */
    return 0;
}

/* R6: `PUSH {rX}` ... `POP {rY}` with real code in between, as long as
 * nothing there can observe the value.  The emitted shape is
 *
 *      PUSH {r0}          ; keep arg 1 while arg 0 is materialised
 *      MOV  r0, r8
 *      POP  {r1}          ; arg 1, one instruction late
 *
 * which is a register copy routed through memory: `MOV r1, r0` at the PUSH
 * does the same job and never touches sp.  Rewriting at the PUSH is sound
 * because rX still holds the pushed value there -- a later write to rX is
 * harmless -- so the only requirement is that rY is not mentioned between
 * the two halves (rY would see the value too early, or lose it).  When
 * X == Y the pair is a no-op and both lines go, but then rX itself must not
 * be mentioned either.  Labels, branches, calls, IT blocks, nested stack
 * accesses and any sp use end the search: they either reach the POP with a
 * different value stack or move the slot it reads. */
static void pp_r6(AsmBuffer *b, int from) {
    static int ls[PP_MAX_LINES], ll[PP_MAX_LINES];
    AsmBuffer out;
    char t[256], u[256], nx[8], ny[8], mv[32];
    int n, i, changed = 0;
    n = pp_split_lines(b, from, ls, ll, PP_MAX_LINES);
    if (n < 0) return;
    asmbuf_init(&out);
    i = 0;
    while (i < n) {
        int isp = 0, rx = 0;
        if (ll[i] < (int)sizeof t &&
            pp_trim(b->buf + ls[i], ll[i], t, sizeof t) >= 0 &&
            pp_pushpop(t, &isp, &rx) && isp) {
            int j, pop = -1, ry = 0, bad = 0, k;
            for (j = i + 1; j < n && j <= i + PP_R6_WINDOW; j++) {
                int isp2 = 0, r2 = 0;
                if (ll[j] >= (int)sizeof u) { bad = 1; break; }
                if (pp_trim(b->buf + ls[j], ll[j], u, sizeof u) < 0) { bad = 1; break; }
                if (pp_pad(u)) continue;
                if (pp_pushpop(u, &isp2, &r2)) {
                    if (!isp2) { pop = j; ry = r2; }
                    else bad = 1;
                    break;
                }
                if (pp_r6_stops(u)) { bad = 1; break; }
            }
            if (!bad && pop > 0) {
                pp_rname(ry, ny, (int)sizeof ny);
                pp_rname(rx, nx, (int)sizeof nx);
                for (k = i + 1; k < pop; k++) {
                    if (ll[k] >= (int)sizeof u) { bad = 1; break; }
                    if (pp_trim(b->buf + ls[k], ll[k], u, sizeof u) < 0) { bad = 1; break; }
                    if (pp_pad(u)) continue;
                    if (pp_mentions(u, ny)) { bad = 1; break; }
                    if (rx == ry && pp_mentions(u, nx)) { bad = 1; break; }
                }
            } else {
                bad = 1;
            }
            if (!bad) {
                /* The copy must come first: the code in between may
                 * overwrite rX, which is exactly what the PUSH protected. */
                if (rx != ry) {
                    snprintf(mv, sizeof mv, "    MOV %s, %s\n", ny, nx);
                    asmbuf_puts(&out, mv);
                }
                for (k = i + 1; k < pop; k++)
                    pp_copy_line(&out, b->buf + ls[k], ll[k]);
                changed++;
                i = pop + 1;
                continue;
            }
        }
        pp_copy_line(&out, b->buf + ls[i], ll[i]);
        i++;
    }
    if (changed) pp_splice(b, from, &out);
}

static void ark_peep_function(AsmBuffer *b, int from) {
    if (!pp_enabled()) return;
    pp_r5(b, from);
    pp_r6(b, from);
    pp_r1(b, from);
    pp_r3(b, from);
}

#if ARKCC_FEATURE_OPT_COPYPROP || ARKCC_FEATURE_OPT_LIVE
/* ------------------------ copy propagation (ECT family) ------------------
 * Two rules over one function's emitted text.  Both are the ones IAR ships
 * under "ECT CopyPropagation candidate" / "DefIntoMove" / "Dead MOV"
 * (see c_compiler/iar/docs/08-backend-passes.md and 06-optimizer.md):
 *
 *   A  `MOV rD, rS` (or `MOV rD, #imm`) whose rD is completely overwritten
 *      before anything reads it, inside one straight-line block, is dead.
 *      Deleting it cannot change any value or flag: MOV writes no flags.
 *      The block ends at a label, any branch, PUSH/POP, LDM/STM, an IT
 *      (its inner instructions are conditional), or the end of the function.
 *      A load, a store, a compare, an address ([r6, ...]) and a call all
 *      count as reads, so nothing that consumes the value is crossed.
 *
 *   B  `MOV rD, rS` followed (padding directives only in between) by
 *      `OP rD, rD, X` with rD != rS and X != rD becomes `OP rD, rS, X`.
 *      One instruction instead of two; the flags set are identical because
 *      the surviving OP keeps its own suffix and reads the same values.
 *      OP must write its first operand and must be a plain three-operand
 *      ALU op -- CMP/CMN/TST are excluded because they write no register,
 *      so deleting the MOV would leave rD holding a different value.
 *
 * Neither rule needs liveness analysis: A only removes writes that are
 * provably overwritten, B only forwards a value into its single consumer.
 */
typedef struct {
    char mn[16];
    int nops;
    char op[4][40];
} cp_ins;

/* "rN" and nothing else -> register number. */
static int cp_reg(const char *s, int *out) {
    int n = 0;
    if (s[0] != 'r' || !s[1]) return 0;
    s++;
    if (*s < '0' || *s > '9') return 0;
    while (*s >= '0' && *s <= '9') { n = n * 10 + (*s - '0'); s++; }
    if (*s) return 0;
    *out = n;
    return 1;
}

/* Is rN mentioned anywhere in this text as a whole token? */
static int cp_mentions(const char *t, int r) {
    const char *p = t;
    while (*p) {
        if (*p == 'r' && p[1] >= '0' && p[1] <= '9' &&
            !(p > t && ((p[-1] >= 'a' && p[-1] <= 'z') ||
                        (p[-1] >= 'A' && p[-1] <= 'Z') ||
                        (p[-1] >= '0' && p[-1] <= '9') || p[-1] == '_'))) {
            int n = 0;
            const char *q = p + 1;
            while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
            if (n == r) return 1;
            p = q;
            continue;
        }
        p++;
    }
    return 0;
}

static int cp_writes(const cp_ins *o, int *r);   /* defined below */

/* Is the first operand of this op write-only?  A three-operand ALU/load form
 * names its destination there; a two-operand form may well read it as well
 * (`UXTB r0, r0`, `MUL r0, r1`), so only the shapes the emitter is known to
 * emit with a bare destination may skip the read test. */
static int cp_dest_only(const cp_ins *o) {
    static const char *D[] = {
        "MOV", "MOVW", "MVN", "LDR", "LDRB", "LDRH", "LDRSB", "LDRSH",
        "REV", "REV16", "REVSH", "RRX", "CLZ",
        "UXTB", "UXTH", "SXTB", "SXTH", NULL
    };
    int i = 0;
    if (o->nops >= 3) return 1;
    while (D[i] && strcmp(o->mn, D[i])) i++;
    return D[i] != NULL;
}

/* Does this line read rR?  Every operand except a write-only destination is
 * a read: a store reads the register it stores (`STR r0, [r6, #8]`), a
 * compare reads both, and a copy reads its source. */
static int cp_reads(const cp_ins *o, int r) {
    int i, w;
    for (i = 1; i < o->nops; i++)
        if (cp_mentions(o->op[i], r)) return 1;
    if (o->nops > 0 && cp_mentions(o->op[0], r)) {
        if (!(cp_writes(o, &w) && w == r && cp_dest_only(o))) return 1;
    }
    return 0;
}

static void cp_trim_range(char *s) {
    int a = 0, b = 0, k = 0;
    while (s[a] == ' ' || s[a] == '\t') a++;
    while (s[b]) b++;
    while (b > a && (s[b - 1] == ' ' || s[b - 1] == '\t')) b--;
    while (a < b) s[k++] = s[a++];
    s[k] = 0;
}

static int cp_parse(const char *t, cp_ins *o) {
    int i = 0, n = 0, k, depth;
    while (t[i] && ((t[i] >= 'A' && t[i] <= 'Z') || (t[i] >= 'a' && t[i] <= 'z'))) {
        if (n < 15) o->mn[n++] = t[i];
        i++;
    }
    o->mn[n] = 0;
    if (!n || t[i] != ' ') return 0;
    i++;
    o->nops = 0;
    while (t[i] && o->nops < 4) {
        k = 0; depth = 0;
        while (t[i] && !(depth == 0 && t[i] == ',')) {
            /* '[..]' and '{..}' are both single operands.  Counting only
             * brackets used to split a register list at its commas, and
             * the four-operand cap then truncated anything longer than
             * {rA, rB, rC}: "POP {r5, r6, r7, r8, r9, pc}" came back as
             * op[3] = "r8, r9, pc}", so "pc" was never seen, the block was
             * not read as returning, and -fopt-live deleted the live copy
             * of the return value in front of the epilogue. */
            if (t[i] == '[' || t[i] == '{') depth++;
            else if (t[i] == ']' || t[i] == '}') depth--;
            if (k < 39) o->op[o->nops][k++] = t[i];
            i++;
        }
        o->op[o->nops][k] = 0;
        cp_trim_range(o->op[o->nops]);
        o->nops++;
        if (t[i] == ',') { i++; while (t[i] == ' ') i++; }
    }
    return 1;
}

#if ARKCC_FEATURE_OPT_COPYPROP  /* rules below are copy propagation only */
/* Anything that ends the straight-line block the two rules reason about. */
static int cp_is_boundary(const cp_ins *o) {
    const char *m = o->mn;
    if (!strcmp(m, "B") || !strcmp(m, "BL") || !strcmp(m, "BX") ||
        !strcmp(m, "BLX") || !strcmp(m, "PUSH") || !strcmp(m, "POP") ||
        !strcmp(m, "LDM") || !strcmp(m, "STM") || !strcmp(m, "LDMIA") ||
        !strcmp(m, "STMIA") || !strcmp(m, "CPS") || !strcmp(m, "BKPT"))
        return 1;
    if (m[0] == 'I' && m[1] == 'T') return 1;      /* IT, ITE, ITT, ITTE, ... */
    if (m[0] == 'B' && m[2] && !m[3] && strchr("NEGTLOSH", m[1]))
        return 1;                                   /* BNE BEQ BGT BGE BLT BLE BLO BHI BHS BLS */
    return 0;
}

/* Does this line fully overwrite its first operand?  MOVT is excluded: it
 * writes only the top half, so it does not kill the low half MOVW produced. */
static int cp_writes(const cp_ins *o, int *r) {
    static const char *W[] = {
        "MOV", "MOVW", "MVN", "ADD", "SUB", "AND", "ORR", "EOR", "BIC", "ORN",
        "LSL", "LSR", "ASR", "RSB", "SBC", "ADC", "RSC", "MUL", "UDIV", "SDIV",
        "UXTB", "UXTH", "SXTB", "SXTH", "REV", "REV16", "REVSH", "RRX", "CLZ",
        "LDR", "LDRB", "LDRH", "LDRSB", "LDRSH", "LDRD", NULL
    };
    int i = 0, n;
    if (o->nops < 1) return 0;
    while (W[i] && strcmp(o->mn, W[i])) i++;
    if (!W[i]) return 0;
    if (!cp_reg(o->op[0], &n)) return 0;
    *r = n;
    return 1;
}

/* Three-operand ALU ops that may absorb the copy.  CMP/CMN/TST are left out
 * on purpose (see rule B above), and so are ADC and SBC: their 16-bit forms
 * *require* Rd == Rn, so `ADC rD, rD, X` cannot become `ADC rD, rS, X` -- the
 * result is a three-distinct-register encoding this assembler does not emit.
 * (Found by the ARM execution gate on the 64-bit add in stdlib aeabi.c.) */
static int cp_op_ok(const char *m) {
    static const char *OK[] = {
        "LSL", "LSR", "ASR", "ADD", "SUB", "AND", "ORR", "EOR", "RSB",
        "MUL", "UDIV", "SDIV", "BIC", NULL
    };
    int i = 0;
    while (OK[i] && strcmp(m, OK[i])) i++;
    return OK[i] != NULL;
}

/* One walk over the function.  Returns the number of rewrites; the caller
 * repeats until it reaches zero, because a fold can expose another one. */
static int cp_pass(AsmBuffer *b, int from) {
    static int ls[PP_MAX_LINES], ll[PP_MAX_LINES];
    static char t[256], u[256];
    AsmBuffer out;
    int n, i, changed = 0;
    n = pp_split_lines(b, from, ls, ll, PP_MAX_LINES);
    if (n < 0) return 0;
    asmbuf_init(&out);
    i = 0;
    while (i < n) {
        cp_ins cu;
        int d, s, done = 0;
        if (ll[i] < (int)sizeof t &&
            pp_trim(b->buf + ls[i], ll[i], t, sizeof t) >= 0 &&
            cp_parse(t, &cu) && !strcmp(cu.mn, "MOV") && cu.nops == 2 &&
            cp_reg(cu.op[0], &d) && d <= 12) {
            /* Rule B first: the MOV the OP consumes is not dead. */
            if (cp_reg(cu.op[1], &s) && d != s) {
                int j = i + 1, hit = 0;
                cp_ins cv;
                while (j < n) {
                    if (ll[j] >= (int)sizeof u) break;
                    if (pp_trim(b->buf + ls[j], ll[j], u, sizeof u) < 0) break;
                    if (pp_pad(u)) { j++; continue; }      /* .loc / comment */
                    hit = 1;
                    break;
                }
                if (hit && cp_parse(u, &cv) && cv.nops == 3 && cp_op_ok(cv.mn)) {
                    int a, bb, xr;
                    if (cp_reg(cv.op[0], &a) && cp_reg(cv.op[1], &bb) &&
                        a == d && bb == d &&
                        !(cp_reg(cv.op[2], &xr) && xr == d)) {
                        int k;
                        char nw[128];
                        for (k = i + 1; k < j; k++)
                            pp_copy_line(&out, b->buf + ls[k], ll[k]);
                        snprintf(nw, sizeof nw, "    %s r%d, r%d, %s\n",
                                 cv.mn, d, s, cv.op[2]);
                        asmbuf_puts(&out, nw);
                        i = j + 1;
                        changed++;
                        done = 1;
                    }
                }
            }
            /* Rule A: dead copy, plain register or immediate alike. */
            if (!done) {
                int src_ok = 0;
                if (cp_reg(cu.op[1], &s) || cu.op[1][0] == '#') src_ok = 1;
                if (src_ok) {
                    int j;
                    for (j = i + 1; j < n; j++) {
                        cp_ins cv;
                        int w;
                        if (ll[j] >= (int)sizeof u) break;
                        if (pp_trim(b->buf + ls[j], ll[j], u, sizeof u) < 0) break;
                        if (!u[0]) continue;
                        if (u[0] == ';' || u[0] == '@') continue;
                        if (u[0] == '.') {
                            int m = ark_strlen(u);
                            if (m == 0 || u[m - 1] == ':') break;   /* label */
                            continue;                               /* directive */
                        }
                        if (!cp_parse(u, &cv)) break;
                        if (cp_is_boundary(&cv)) break;
                        if (cp_reads(&cv, d)) break;
                        if (cp_writes(&cv, &w) && w == d) { done = 2; break; }
                    }
                }
            }
        }
        if (done == 2) { changed++; i++; continue; }   /* drop the dead MOV */
        if (done == 1) continue;                        /* already emitted */
        pp_copy_line(&out, b->buf + ls[i], ll[i]);
        i++;
    }
    if (changed) pp_splice(b, from, &out);
    return changed;
}

static void ark_copyprop_function(AsmBuffer *b, int from) {
    int round;
    if (!g_config.enable_opt_copyprop) return;
    for (round = 0; round < 4; round++) {
        if (cp_pass(b, from) == 0) break;
    }
}
#endif /* ARKCC_FEATURE_OPT_COPYPROP (rules) */
#if ARKCC_FEATURE_OPT_LIVE
/* ------------------ liveness-driven register cleanup (-fopt-live) --------
 * The copy passes above are deliberately local: neither looks past a label or
 * a branch, because without liveness a register can look dead when it is not.
 * This pass pays for the analysis once and then prunes what only liveness can
 * see.  It builds the control-flow graph of the already emitted function,
 * computes register liveness to a fixed point, and afterwards applies four
 * rewrite rules that are each proved by the live-out set:
 *
 *   L1  `MOV rD, rS|#imm` with rD not live afterwards            -> delete
 *       (MOV writes no flags, so nothing observable changes)
 *   L2  `MOV rD, rS` followed by the instruction that reads rD, with rD not
 *       live after it and not written by it                      -> that
 *       instruction reads rS instead, the copy disappears.  Same values, same
 *       flags, one instruction fewer.
 *   L3  `MOV rT, #0` followed by an instruction that uses rT only as the index
 *       of an address, with rT not live afterwards               -> drop the
 *       index: `[rB, rT]` / `[rB, rT, LSL #n]` becomes `[rB]`
 *   L4  `MOVW rD,#lo` / `MOVT rD,#hi` / `MOV rX, rD` with rD not live after
 *       the copy                                                -> materialise
 *       the constant straight into rX (IAR's "DefIntoMove")
 *
 * What makes the analysis trustworthy is what it refuses:
 *   - a call reads r0-r3 (they are the arguments) and writes r0-r3, r12, lr;
 *   - a block with no successor returns r0-r3, because the caller reads them;
 *   - CBZ/CBNZ read their first operand, unlike every other `B...`;
 *   - `pc`, `lr`, `sp` are registers 15, 14, 13, so `POP {..., pc}` is an exit
 *     and `BX lr` is too;
 *   - nothing is rewritten inside an IT block (its instructions are
 *     conditional, so "not live" would have to hold on the not-taken path);
 *   - r6 (the frame pointer), sp, lr and pc are never a rewrite target;
 *   - every rewritten line is rebuilt and compared with the original text, so
 *     a parse that truncated an operand can never reach the output.
 *
 * Measured on the HAL corpus it removes ~900 instructions that no local rule
 * can see, most of them operand staging around branches and the address of a
 * global being materialised into a scratch register and then copied.
 */
/* How far L2 will look for the consumer of a staged copy.  Two or three
 * instructions is the useful range (a constant materialisation or a frame
 * address in between); further than that a rewrite is unlikely and the
 * scan is not free. */
#define LV_WINDOW 4
#define LV_MAX_BLOCKS 1024
#define LV_MAX_LABELS 256

typedef struct {
    unsigned use, def, in, out;
    int first, last;
    int succ[2];
} LvBlock;

static unsigned lv_bit(int r) {
    return (r >= 0 && r < 16) ? (1u << r) : 0u;
}

/* Register mask of one operand text.  Whole tokens only: "lr" is r14, "pc" is
 * r15, "sp" is r13, and "str0" or "r0x" are none of them. */
static unsigned lv_regs(const char *s) {
    unsigned m = 0;
    int i = 0;
    while (s[i]) {
        if ((s[i] >= 'a' && s[i] <= 'z') || (s[i] >= 'A' && s[i] <= 'Z')) {
            int j = i, L;
            char tok[8];
            while (s[j] && ((s[j] >= 'a' && s[j] <= 'z') ||
                            (s[j] >= 'A' && s[j] <= 'Z') ||
                            (s[j] >= '0' && s[j] <= '9') || s[j] == '_')) j++;
            L = j - i;
            if (L > 7) L = 7;
            memcpy(tok, s + i, L);
            tok[L] = 0;
            if ((tok[0] == 'r' || tok[0] == 'R') && tok[1] >= '0' && tok[1] <= '9') {
                /* "r0".."r15" only: one or two digits, then end of token. */
                int v = tok[1] - '0', nd = 1;
                if (tok[2] >= '0' && tok[2] <= '9') { v = v * 10 + (tok[2] - '0'); nd = 2; }
                if (v >= 0 && v < 16 && tok[nd + 1] == 0) m |= lv_bit(v);
            } else if (!strcmp(tok, "pc")) {
                m |= lv_bit(15);
            } else if (!strcmp(tok, "lr")) {
                m |= lv_bit(14);
            } else if (!strcmp(tok, "sp")) {
                m |= lv_bit(13);
            }
            i = j;
        } else {
            i++;
        }
    }
    return m;
}

/* The two-letter condition suffixes a Thumb branch may carry.  Only these
 * turn a three-letter `B...` mnemonic into a branch: BIC, BFI and BFC are
 * data-processing instructions whose names merely start with B.  Reading
 * them as conditional branches made the live pass treat their block as an
 * exit with an unknown target (every register live, block end) and made the
 * spill pass abandon the whole function when it could not resolve the
 * "target" `#0x10000` -- a silent precision loss, not a wrong answer, so it
 * survived until a bail-reason census showed 29 of 95 corpus units dropping
 * their entire spill analysis on a BIC. */
static int lv_cond_suffix(const char *s) {
    static const char *const t[] = { "EQ", "NE", "CS", "HS", "CC", "LO",
        "MI", "PL", "VS", "VC", "HI", "LS", "GE", "LT", "GT", "LE", "AL", 0 };
    int i;
    for (i = 0; t[i]; i++) if (!strcmp(s, t[i])) return 1;
    return 0;
}

/* 0 none, 1 unconditional branch, 2 conditional branch, 3 call, 4 BX/BLX r. */
static int lv_branch_kind(const char *m) {
    size_t L = strlen(m);
    /* CBZ/CBNZ read one register and jump conditionally, exactly like
     * a BEQ with the compare folded in.  Missing this made the block
     * that *ends* at a CBZ look like it ran on into the fallthrough,
     * so its target edge disappeared, the loop body looked unreachable
     * from the top and a parameter's prologue store was read as dead.
     * Measured with -fopt-cbz -fopt-vstack -fopt-vreg -fopt-live: the
     * promoted loop bound register was never written, and the loop
     * compared against garbage (`CMP r5, r9` with r9 never set). */
    if (!strcmp(m, "CBZ") || !strcmp(m, "CBNZ")) return 2;
    if (m[0] != 'B') return 0;
    if (L == 1) return 1;
    if (L == 2 && m[1] == 'L') return 3;
    if (L == 2 && m[1] == 'X') return 4;
    if (L == 3 && m[1] == 'L' && m[2] == 'X') return 3;
    if (L == 3) return lv_cond_suffix(m + 1) ? 2 : 0;
    return 0;
}

/* Mnemonics whose first operand is a pure destination: the write does not
 * also read the old value.  Everything else follows the "Rd is also a
 * source" convention of the 16-bit ALU/load-store forms. */
static int lv_dest_only(const char *m) {
    if (!strncmp(m, "MOV", 3)) return 1;        /* MOV/MOVW/MOVT/MOVcc */
    if (!strcmp(m, "MVN") || !strcmp(m, "NEG")) return 1;
    if (!strcmp(m, "UXTB") || !strcmp(m, "UXTH") ||
        !strcmp(m, "SXTB") || !strcmp(m, "SXTH")) return 1;
    if (!strcmp(m, "REV") || !strcmp(m, "REV16") ||
        !strcmp(m, "REVSH") || !strcmp(m, "RBIT")) return 1;
    if (!strcmp(m, "CLZ")) return 1;
    return 0;
}

/* Mnemonics whose 16-bit encoding requires Rd == Rn, so retargeting a
 * consumer onto another source register would ask for a 32-bit form this
 * assembler does not emit. */
static int lv_rd_eq_rn(const char *m) {
    return !strcmp(m, "ADC") || !strcmp(m, "SBC") || !strcmp(m, "RSC");
}

/* CBZ/CBNZ have only the 16-bit T1 encoding, and it reaches r0-r7 only.
 * A retarget (live L2, coalescing) that names a high register here would
 * produce an instruction the assembler cannot encode; worse, the encoder
 * masks the register with &7, so `CBNZ r8` would silently become `CBNZ r0`
 * -- a wrong answer on the board.  Decline such a rewrite instead. */
static int lv_lowreg_only(const char *m) {
    return !strcmp(m, "CBZ") || !strcmp(m, "CBNZ");
}

/* Registers read and written by one instruction. */
static void lv_rw(const cp_ins *o, unsigned *rd, unsigned *wr) {
    const char *m = o->mn;
    unsigned r = 0, w = 0;
    int i;
    *rd = *wr = 0;
    if (!strcmp(m, "BL") || !strcmp(m, "BLX")) {
        /* The callee reads its arguments out of r0-r3 even though no operand
         * names them.  Missing this is how a "dead" copy before a call gets
         * deleted -- the emulator catches it immediately. */
        r = 0xFu;
        for (i = 0; i < o->nops; i++) r |= lv_regs(o->op[i]);
        *rd = r;
        *wr = 0xFu | lv_bit(12) | lv_bit(14);
        return;
    }
    if (!strcmp(m, "B") || !strcmp(m, "BX")) {
        for (i = 0; i < o->nops; i++) r |= lv_regs(o->op[i]);
        *rd = r;
        return;
    }
    if (m[0] == 'B' && strlen(m) == 3) {        /* BEQ BNE ... : no operands */
        for (i = 0; i < o->nops; i++) r |= lv_regs(o->op[i]);
        *rd = r;
        return;
    }
    if (!strcmp(m, "CBZ") || !strcmp(m, "CBNZ")) {
        *rd = lv_regs(o->op[0]);
        return;
    }
    if (!strcmp(m, "CMP") || !strcmp(m, "CMN") || !strcmp(m, "TST") ||
        !strcmp(m, "TEQ")) {
        for (i = 0; i < o->nops; i++) r |= lv_regs(o->op[i]);
        *rd = r;
        return;
    }
    if (!strcmp(m, "PUSH") || !strncmp(m, "STM", 3) ||
        !strncmp(m, "STR", 3) || !strncmp(m, "VSTR", 4)) {
        for (i = 0; i < o->nops; i++) r |= lv_regs(o->op[i]);
        *rd = r;
        return;
    }
    if (!strcmp(m, "POP")) {
        for (i = 0; i < o->nops; i++) w |= lv_regs(o->op[i]);
        *wr = w;
        return;
    }
    if (!strncmp(m, "LDM", 3)) {
        if (o->nops > 0) r |= lv_regs(o->op[0]);
        for (i = 1; i < o->nops; i++) w |= lv_regs(o->op[i]);
        *rd = r;
        *wr = w;
        return;
    }
    if (!strncmp(m, "LDR", 3) || !strncmp(m, "VLDR", 4)) {
        if (o->nops > 0) w |= lv_regs(o->op[0]);
        for (i = 1; i < o->nops; i++) r |= lv_regs(o->op[i]);
        *rd = r;
        *wr = w;
        return;
    }
    if (o->nops > 0) {                          /* generic: op0 is the result */
        w = lv_regs(o->op[0]);
        for (i = 1; i < o->nops; i++) r |= lv_regs(o->op[i]);
        /* Two-operand ALU forms read their destination as well:
         *   `LSL r0, r4`  is  r0 = r0 << r4
         *   `AND r0, r1`  is  r0 = r0 & r1
         *   `MUL r0, r1`  is  r0 = r0 * r1
         * Missing this read is how a live `MOV r0, r7` ahead of
         * `LSL r0, r4` gets deleted -- a wrong answer, not a folding.
         * Only the ops whose destination is a pure output are exempt;
         * over-approximating a read can only cost a missed rewrite. */
        if (!lv_dest_only(m)) r |= w;
    }
    *rd = r;
    *wr = w;
}

/* Does this instruction end the block it sits in? */
static int lv_ends_block(const cp_ins *o) {
    int k = lv_branch_kind(o->mn);
    int i;
    if (k == 1 || k == 2 || k == 4) return 1;
    if (!strcmp(o->mn, "POP")) {
        for (i = 0; i < o->nops; i++)
            if (lv_regs(o->op[i]) & lv_bit(15)) return 1;
    }
    return 0;
}

/* An op that may appear with a '!' writeback (`LDR r0, [r1, #4]!`). */
static int lv_has_writeback(const cp_ins *o) {
    int i;
    for (i = 0; i < o->nops; i++) {
        const char *p = o->op[i];
        size_t L = strlen(p);
        if (L > 0 && p[L - 1] == '!') return 1;
    }
    return 0;
}

/* Rewrite one line from its parsed form; returns 0 if the rebuild would not
 * reproduce the original text exactly (a truncated or odd parse). */
static int lv_rebuild(char *dst, int cap, const cp_ins *o) {
    int k = 0, i;
    k += snprintf(dst + k, (size_t)(cap - k), "%s", o->mn);
    for (i = 0; i < o->nops && k < cap; i++)
        k += snprintf(dst + k, (size_t)(cap - k), "%s%s", i ? ", " : " ", o->op[i]);
    if (k < cap) dst[k] = 0;
    return k < cap;
}

/* Replace whole-token `rS` with `rD` inside one operand text. */
static int lv_repl_reg(char *dst, int cap, const char *src, int from, int to) {
    int k = 0, i = 0;
    while (src[i]) {
        if ((src[i] >= 'a' && src[i] <= 'z') || (src[i] >= 'A' && src[i] <= 'Z')) {
            int j = i, L;
            char tok[8];
            while (src[j] && ((src[j] >= 'a' && src[j] <= 'z') ||
                              (src[j] >= 'A' && src[j] <= 'Z') ||
                              (src[j] >= '0' && src[j] <= '9') || src[j] == '_')) j++;
            L = j - i;
            if (L > 7) L = 7;
            memcpy(tok, src + i, L);
            tok[L] = 0;
            if (!strcmp(tok, "r0") || !strcmp(tok, "r1") || !strcmp(tok, "r2") ||
                !strcmp(tok, "r3") || !strcmp(tok, "r4") || !strcmp(tok, "r5") ||
                !strcmp(tok, "r6") || !strcmp(tok, "r7") || !strcmp(tok, "r8") ||
                !strcmp(tok, "r9") || !strcmp(tok, "r10") || !strcmp(tok, "r11") ||
                !strcmp(tok, "r12")) {
                int v = (L == 2) ? (tok[1] - '0') : (10 + tok[2] - '0');
                if (v == from) {
                    k += snprintf(dst + k, (size_t)(cap - k), "r%d", to);
                    i = j;
                    continue;
                }
            }
            /* Copy the token in full: L is capped at 7 only for the
             * register-name comparison above, and copying the capped
             * length here silently truncated every longer identifier
             * -- a branch target `.L_HAL_RCC_OscConfig_0` came out as
             * `.L_HAL_R` (an undefined label the assembler can only
             * report, never repair). */
            if (k + (j - i) >= cap) return 0;
            memcpy(dst + k, src + i, (size_t)(j - i));
            k += j - i;
            i = j;
        } else {
            if (k + 1 >= cap) return 0;
            dst[k++] = src[i++];
        }
    }
    if (k < cap) { dst[k] = 0; return 1; }
    return 0;
}

/* Drop ", rT" (and an optional ", LSL #n") that indexes an address operand.
 * Returns 1 when the operand was rewritten. */
static int lv_drop_index(char *dst, int cap, const char *src, int t) {
    char pat[16];
    const char *p;
    snprintf(pat, sizeof pat, ", r%d", t);
    p = strstr(src, pat);
    while (p) {
        const char *q = p + strlen(pat);
        char tail[64];
        int tl = 0;
        if (*q == ']') {
            /* [rB, rT] -> [rB] */
        } else if (!strncmp(q, ", LSL #", 7)) {
            const char *e = q + 7;
            while (*e >= '0' && *e <= '9') e++;
            if (*e != ']') { p = strstr(p + 1, pat); continue; }
            tl = (int)(e - q);
            if (tl >= (int)sizeof tail) return 0;
            memcpy(tail, q, (size_t)tl);
            tail[tl] = 0;
            q += tl;
        } else {
            p = strstr(p + 1, pat);
            continue;
        }
        if (*q == ']' && strlen(src) + 1 <= (size_t)cap) {
            int pre = (int)(p - src);
            memcpy(dst, src, (size_t)pre);
            strcpy(dst + pre, q);
            return 1;
        }
        p = strstr(p + 1, pat);
    }
    return 0;
}

/* Does the parse of line `idx` rebuild to exactly that line's text?  This is
 * the anti-truncation guard: if a parse dropped or mangled an operand it can
 * never reach the output.  It must be called BEFORE any operand is modified. */
static int lv_same(AsmBuffer *b, const int *ls, const int *ll,
                   const cp_ins *o, int idx) {
    char t[256], r[256];
    if (pp_trim(b->buf + ls[idx], ll[idx], t, sizeof t) < 0) return 0;
    if (!lv_rebuild(r, sizeof r, o)) return 0;
    return !strcmp(r, t);
}

static int lv_pass(AsmBuffer *b, int from, unsigned retmask) {
    static int ls[PP_MAX_LINES], ll[PP_MAX_LINES];
    static cp_ins iv[PP_MAX_LINES];
    static unsigned char kd[PP_MAX_LINES];      /* 0 other, 1 instruction, 2 label */
    static unsigned char it[PP_MAX_LINES];
    static unsigned la[PP_MAX_LINES];
    static int bof[PP_MAX_LINES];
    static unsigned char bsx[LV_MAX_BLOCKS];   /* 1 = returns here, 2 = branch target lost */
    static LvBlock blk[LV_MAX_BLOCKS];
    static char lab[LV_MAX_LABELS][40];
    static int labline[LV_MAX_LABELS];
    static char t[256], nw[256], o2[256], o3[256];
    AsmBuffer out;
    int n, i, j, nb, nlab, changed = 0, prev_end, seen_label, iter;
    n = pp_split_lines(b, from, ls, ll, PP_MAX_LINES);
    if (n < 0) return 0;
    nlab = 0;
    for (i = 0; i < n; i++) {
        int L;
        kd[i] = 0; it[i] = 0; la[i] = 0; bof[i] = -1;
        if (ll[i] >= (int)sizeof t) continue;
        if (pp_trim(b->buf + ls[i], ll[i], t, sizeof t) < 0) continue;
        if (!t[0] || t[0] == ';' || t[0] == '@') continue;
        L = ark_strlen(t);
        if (L > 0 && t[L - 1] == ':') {
            if (nlab < LV_MAX_LABELS) {
                int k = 0;
                while (k < L - 1 && k < 39) { lab[nlab][k] = t[k]; k++; }
                lab[nlab][k] = 0;
                labline[nlab] = i;
                nlab++;
            }
            kd[i] = 2;
            continue;
        }
        if (t[0] == '.') continue;              /* directive */
        if (cp_parse(t, &iv[i])) kd[i] = 1;
    }
    /* Instructions under an IT: conditional, so never a rewrite candidate. */
    for (i = 0; i < n; i++) {
        if (kd[i] != 1) continue;
        if (iv[i].mn[0] == 'I' && iv[i].mn[1] == 'T' &&
            (iv[i].mn[2] == 0 || iv[i].mn[2] == 'T' || iv[i].mn[2] == 'E')) {
            int cnt = ark_strlen(iv[i].mn) - 1, c = 0;
            for (j = i + 1; j < n && c < cnt; j++) {
                if (kd[j] == 2) break;
                if (kd[j] == 1) { it[j] = 1; c++; }
            }
        }
    }
    /* Basic blocks. */
    nb = 0; prev_end = 1; seen_label = 0;
    for (i = 0; i < n; i++) {
        if (kd[i] == 2) { seen_label = 1; continue; }
        if (kd[i] != 1) continue;
        if (nb == 0 || prev_end || seen_label) {
            if (nb >= LV_MAX_BLOCKS) return 0;
            blk[nb].first = blk[nb].last = i;
            blk[nb].succ[0] = blk[nb].succ[1] = -1;
            blk[nb].use = blk[nb].def = blk[nb].in = blk[nb].out = 0;
            bsx[nb] = 0;
            nb++;
        } else {
            blk[nb - 1].last = i;
        }
        bof[i] = nb - 1;
        seen_label = 0;
        prev_end = lv_ends_block(&iv[i]);
    }
    if (nb <= 0) return 0;
    /* Successors. */
    for (i = 0; i < nb; i++) {
        const cp_ins *o = &iv[blk[i].last];
        int k = lv_branch_kind(o->mn), tgt = -1, q;
        if (k == 1 || k == 2) {
            for (q = 0; q < o->nops; q++) {
                const char *p = o->op[q];
                int m2;
                if (!p[0] || p[0] == '#' || p[0] == '[') continue;
                if (lv_regs(p)) continue;
                for (m2 = 0; m2 < nlab; m2++)
                    if (!strcmp(lab[m2], p)) { tgt = labline[m2]; break; }
                if (tgt >= 0) break;
            }
            if (tgt >= 0) {
                int L2;
                for (L2 = tgt; L2 < n; L2++)
                    if (bof[L2] >= 0) { tgt = bof[L2]; break; }
                if (L2 >= n) tgt = -1;
            }
        }
        if (k == 1) {
            blk[i].succ[0] = tgt;
            /* A branch whose label this pass could not find must not be read
             * as "the function returns here": nothing is known about where it
             * goes, so every register has to be treated as read. */
            bsx[i] = (tgt < 0) ? 2 : 0;
        } else if (k == 2) {
            blk[i].succ[0] = tgt;
            blk[i].succ[1] = (i + 1 < nb) ? i + 1 : -1;
            bsx[i] = (tgt < 0) ? 2 : 0;
        } else if (k == 4) {
            blk[i].succ[0] = -1;                /* BX lr / BX rM leaves */
            bsx[i] = 1;
        } else if (lv_ends_block(o)) {
            blk[i].succ[0] = -1;                /* POP {..., pc} returns */
            bsx[i] = 1;
        } else {
            blk[i].succ[0] = (i + 1 < nb) ? i + 1 : -1;
            bsx[i] = (i + 1 < nb) ? 0 : 1;
        }
    }
    /* use / def */
    for (i = 0; i < nb; i++) {
        unsigned u = 0, d = 0;
        for (j = blk[i].first; j <= blk[i].last; j++) {
            unsigned rd, wr;
            /* Only real instructions have a parse.  A block's line range
             * spans the directives between its first and last instruction
             * (".loc", ".arkdatasym", ...), and `iv[]` is written only when
             * kd == 1 -- so an unguarded read of iv[j] here picks up the
             * *previous function's* parse of the same line index.  Measured:
             * LL_mDelay left "MOVT r5, #57344" at index 9; the next function
             * had a directive at index 9, its liveness believed r5 was
             * clobbered there, and the live pass deleted "MOV r5, r0" --
             * leaving "STR r5, [r1]" reading a register nothing wrote. */
            if (kd[j] != 1) continue;
            lv_rw(&iv[j], &rd, &wr);
            u |= rd & ~d;
            d |= wr;
        }
        /* `u` must be the *upward-exposed* read set: a register the block reads
         * before anything in the block writes it.  The scan above therefore runs
         * forward, so `d` is what has been written *above* the current point and
         * `rd & ~d` counts only reads no earlier write shadows.  It used to run
         * backward with the same expression, which computes the mirror image
         * ("reads after which nothing below writes") and loses exactly one shape:
         * a value read at the top of a loop body and written at the bottom
         * (`MOV r0, r8` ... `MOV r8, r0`).  Liveness then called the bottom write
         * dead, -fopt-live deleted it, and the loop kept reading the stale
         * register.  Measured on the strinit_nul case with
         * `-fopt-vstack -fopt-vreg -fopt-live`: returned 0 instead of 311436.
         *
         * The result is not masked with `~d` either.  With the forward scan a read
         * that an earlier write shadows is already absent from `u`, so masking by
         * the whole def set only removes the case this analysis is for: a block
         * that reads a register *before* defining it is live-in on that register.
         * (The mask was added to stop `in` claiming r0..r3 live-in to almost every
         * block; the forward scan removes that leak at its source.) */
        blk[i].use = u;
        blk[i].def = d;
    }
    /* Liveness to a fixed point. */
    for (iter = 0; iter < 64; iter++) {
        int ch = 0;
        for (i = nb - 1; i >= 0; i--) {
            unsigned o = 0, u;
            if (blk[i].succ[0] >= 0) o |= blk[blk[i].succ[0]].in;
            if (blk[i].succ[1] >= 0) o |= blk[blk[i].succ[1]].in;
            if (blk[i].succ[0] < 0)
                o |= (bsx[i] == 2) ? 0xFu : retmask;  /* caller reads these on return */
            u = blk[i].use | (o & ~blk[i].def);
            if (u != blk[i].in || o != blk[i].out) {
                blk[i].in = u;
                blk[i].out = o;
                ch = 1;
            }
        }
        if (!ch) break;
    }
    /* Live-after per instruction. */
    for (i = 0; i < nb; i++) {
        unsigned live = blk[i].out;
        if (blk[i].succ[0] < 0) live |= (bsx[i] == 2) ? 0xFu : retmask;
        for (j = blk[i].last; j >= blk[i].first; j--) {
            unsigned rd, wr;
            if (kd[j] != 1) continue;   /* directive: no parse, no effect */
            lv_rw(&iv[j], &rd, &wr);
            la[j] = live;
            live = (live & ~wr) | rd;
        }
    }
    /* Rewrite walk. */
    asmbuf_init(&out);
    i = 0;
    while (i < n) {
        int d = -1, s = -1, done = 0;
        if (kd[i] != 1 || it[i] || lv_has_writeback(&iv[i])) {
            pp_copy_line(&out, b->buf + ls[i], ll[i]);
            i++;
            continue;
        }
        /* L1: the copy is dead. */
        if (g_config.enable_opt_live && !strcmp(iv[i].mn, "MOV") && iv[i].nops == 2 &&
            cp_reg(iv[i].op[0], &d) && d >= 0 && d <= 12 && d != 6 &&
            (cp_reg(iv[i].op[1], &s) || iv[i].op[1][0] == '#') &&
            !(la[i] & lv_bit(d))) {
            changed++;
            i++;
            continue;
        }
        /* L4: a constant materialisation, then a copy out of it.  Three
         * shapes, because -fopt-imm's emit_mov_imm now materialises many
         * constants with one instruction:
         *   MOVW rD,#lo / MOVT rD,#hi / MOV rX,rD  -> both halves into rX
         *   MOVW rD,#lo / MOV rX,rD                -> one MOVW into rX
         *   MVN  rD,#imm / MOV rX,rD               -> one MVN into rX
         * Retargeting a MOVW or an MVN keeps the width (4 bytes) and writes no
         * flags, so the single-instruction shapes are a pure win. */
        if (g_config.enable_opt_live &&
            (!strcmp(iv[i].mn, "MOVW") || !strcmp(iv[i].mn, "MVN")) &&
            iv[i].nops == 2 && iv[i].op[1][0] == '#' &&
            cp_reg(iv[i].op[0], &d) && d >= 0 && d <= 12 && d != 6) {
            int j1 = -1, j2 = -1, dd, xx, ss;
            for (j = i + 1; j < n; j++) {
                if (kd[j] == 2) break;
                if (kd[j] == 1) { j1 = j; break; }
            }
            if (j1 >= 0 && !strcmp(iv[j1].mn, "MOVT") &&
                cp_reg(iv[j1].op[0], &dd) && dd == d) {
                for (j = j1 + 1; j < n; j++) {
                    if (kd[j] == 2) break;
                    if (kd[j] == 1) { j2 = j; break; }
                }
                if (j2 >= 0 && !strcmp(iv[j2].mn, "MOV") && iv[j2].nops == 2 &&
                    cp_reg(iv[j2].op[0], &xx) && xx != d && xx <= 12 && xx != 6 &&
                    cp_reg(iv[j2].op[1], &ss) && ss == d &&
                    !(la[j2] & lv_bit(d))) {
                    if (lv_same(b, ls, ll, &iv[i], i) &&
                        lv_same(b, ls, ll, &iv[j1], j1) &&
                        lv_same(b, ls, ll, &iv[j2], j2)) {
                        snprintf(iv[i].op[0], sizeof iv[i].op[0], "r%d", xx);
                        snprintf(iv[j1].op[0], sizeof iv[j1].op[0], "r%d", xx);
                        lv_rebuild(nw, sizeof nw, &iv[i]);
                        lv_rebuild(o2, sizeof o2, &iv[j1]);
                        for (j = i + 1; j < j1; j++)
                            pp_copy_line(&out, b->buf + ls[j], ll[j]);
                        asmbuf_puts(&out, "    ");
                        asmbuf_puts(&out, nw);
                        asmbuf_putc(&out, '\n');
                        asmbuf_puts(&out, "    ");
                        asmbuf_puts(&out, o2);
                        asmbuf_putc(&out, '\n');
                        for (j = j1 + 1; j < j2; j++)
                            pp_copy_line(&out, b->buf + ls[j], ll[j]);
                        changed++;
                        i = j2 + 1;
                        done = 1;
                    }
                }
            }
            if (!done && iv[i].nops == 2) {
                /* Single-instruction materialisation followed by a copy out. */
                int j1 = -1, xx = -1, ss = -1;
                cp_ins tmp;
                for (j = i + 1; j < n; j++) {
                    if (kd[j] == 2) break;
                    if (kd[j] == 1) { j1 = j; break; }
                }
                if (j1 >= 0 && !strcmp(iv[j1].mn, "MOV") && iv[j1].nops == 2 &&
                    cp_reg(iv[j1].op[0], &xx) && xx != d && xx >= 0 && xx <= 12 &&
                    xx != 6 && cp_reg(iv[j1].op[1], &ss) && ss == d &&
                    !(la[j1] & lv_bit(d)) && !it[i] && !it[j1] &&
                    !lv_has_writeback(&iv[i]) && !lv_has_writeback(&iv[j1]) &&
                    lv_same(b, ls, ll, &iv[i], i) &&
                    lv_same(b, ls, ll, &iv[j1], j1)) {
                    tmp = iv[i];
                    snprintf(tmp.op[0], sizeof tmp.op[0], "r%d", xx);
                    if (lv_rebuild(nw, sizeof nw, &tmp)) {
                        for (j = i + 1; j < j1; j++)
                            pp_copy_line(&out, b->buf + ls[j], ll[j]);
                        asmbuf_puts(&out, "    ");
                        asmbuf_puts(&out, nw);
                        asmbuf_putc(&out, '\n');
                        changed++;
                        i = j1 + 1;
                        done = 1;
                    }
                }
            }
            if (done) continue;
        }
        /* L2 / L3: the very next instruction consumes the copy. */
        if (g_config.enable_opt_live && !strcmp(iv[i].mn, "MOV") && iv[i].nops == 2 &&
            cp_reg(iv[i].op[0], &d) && d >= 0 && d <= 12 && d != 6) {
            int j = -1, v, hasbrace = 0, gap_ok = 1, src2 = -1;
            unsigned src_bit = 0;
            if (cp_reg(iv[i].op[1], &src2) && src2 >= 0) src_bit = lv_bit(src2);
            /* Look past a short run of instructions that leave rD and rS alone
             * (`MOVW r1,#lo / MOVT r1,#hi` between a staged value and the store
             * that consumes it, for instance).  The consumer is the first
             * instruction that reads rD; the run in between must not write rD
             * (that would clobber the value), must not write rS (that would
             * change what the consumer sees), and must stay inside the same
             * basic block.  Anything else gives up and the copy stays. */
            for (j = i + 1; j < n && j <= i + LV_WINDOW; j++) {
                unsigned gr, gw;
                if (kd[j] == 2) break;               /* label: block boundary */
                if (kd[j] != 1) continue;            /* directive / blank line */
                if (bof[j] != bof[i]) break;
                lv_rw(&iv[j], &gr, &gw);
                if (gw & (lv_bit(d) | src_bit)) { gap_ok = 0; break; }
                if (gr & lv_bit(d)) break;           /* first reader of rD */
            }
            if (j >= n || j > i + LV_WINDOW || !gap_ok || kd[j] != 1) j = -1;
            /* A register list (`{...}`) is never a simple operand to retarget. */
            for (v = 0; j >= 0 && v < iv[j].nops; v++)
                if (strchr(iv[j].op[v], '{')) hasbrace = 1;
            if (j >= 0 && !it[j] && !lv_has_writeback(&iv[j]) && !hasbrace) {
                unsigned rd, wr;
                int touched = 0, done2 = 0, samej = 0;
                char save[4][40];
                cp_ins origj = iv[j];
                lv_rw(&iv[j], &rd, &wr);
                /* Snapshot the operand texts and note whether rD is read at
                 * all -- both must be captured before anything is rewritten. */
                for (v = 0; v < iv[j].nops; v++) {
                    memcpy(save[v], iv[j].op[v], sizeof save[0]);
                    if (cp_mentions(iv[j].op[v], d)) touched = 1;
                }
                samej = lv_same(b, ls, ll, &origj, j);
                if (!(la[j] & lv_bit(d)) && !(wr & lv_bit(d))) {
                    /* L3 first: a zero index disappears from the address. */
                    if (iv[i].op[1][0] == '#' && !strcmp(iv[i].op[1], "#0") &&
                        rd & lv_bit(d)) {
                        int hits = 0, other = 0;
                        for (v = 0; v < iv[j].nops; v++) {
                            if (v > 0 && lv_drop_index(o3, sizeof o3, iv[j].op[v], d)) {
                                hits++;
                                memcpy(iv[j].op[v], o3, sizeof iv[j].op[v]);
                            } else if (cp_mentions(iv[j].op[v], d)) {
                                other = 1;
                            }
                        }
                        if (hits && !other && samej &&
                            lv_rebuild(nw, sizeof nw, &iv[j])) {
                            for (v = i + 1; v < j; v++)
                                pp_copy_line(&out, b->buf + ls[v], ll[v]);
                            asmbuf_puts(&out, "    ");
                            asmbuf_puts(&out, nw);
                            asmbuf_putc(&out, '\n');
                            changed++;
                            i = j + 1;
                            done2 = 1;
                        }
                        /* Restore the operands before L2 tries them. */
                        for (v = 0; v < iv[j].nops; v++)
                            memcpy(iv[j].op[v], save[v], sizeof save[0]);
                    }
                    /* L2: retarget the consumer onto the copy's source. */
                    if (!done2 && touched && cp_reg(iv[i].op[1], &s) && s != d &&
                        (rd & lv_bit(d)) && !lv_rd_eq_rn(iv[j].mn) &&
                        !(lv_lowreg_only(iv[j].mn) && s > 7)) {
                        int ok = 1;
                        for (v = 0; ok && v < iv[j].nops; v++) {
                            if (!lv_repl_reg(o2, sizeof o2, iv[j].op[v], d, s)) ok = 0;
                            else memcpy(iv[j].op[v], o2, sizeof iv[j].op[v]);
                        }
                        if (ok && samej && lv_rebuild(nw, sizeof nw, &iv[j])) {
                            for (v = i + 1; v < j; v++)
                                pp_copy_line(&out, b->buf + ls[v], ll[v]);
                            asmbuf_puts(&out, "    ");
                            asmbuf_puts(&out, nw);
                            asmbuf_putc(&out, '\n');
                            changed++;
                            i = j + 1;
                            done2 = 1;
                        } else {
                            for (v = 0; v < iv[j].nops; v++)
                                memcpy(iv[j].op[v], save[v], sizeof save[0]);
                        }
                    }
                    if (done2) continue;
                }
            }
        }
        /* L5 (-fopt-coalesce): local copy coalescing -- rename the uses of
         * the copy target and drop the copy instead of staging a value through
         * a scratch register.
         *
         * The shape this exists for is what the value-stack pass leaves behind
         * a two-operand ALU instruction, whose Thumb-1 encoding needs Rd == Rn:
         *
         *     LDR  r5, [r6, #0]      ; a
         *     LDR  r7, [r6, #8]      ; b
         *     MOV  r0, r5            ; stage the left operand into r0
         *     AND  r0, r7            ; r0 = a & b   (Rd == Rn, so not "AND r5, r7")
         *     LSL  r0, r0, #16       ; the consumer
         *     STR  r0, [r6, #32]
         *
         * Renaming every occurrence of r0 in the run to r5 and deleting the
         * copy gives "AND r5, r7" / "LSL r5, r5, #16" / "STR r5, ...": same
         * values, same flags, one instruction fewer, and every instruction
         * stays 16-bit because only r0-r7 take part.
         *
         * The run is the straight-line stretch that follows the copy.  It
         * stops at a label, at a block boundary, at an IT instruction, at any
         * write-back or register-list form (shapes the operand list does not
         * fully describe) and at the first write of the copy source.
         *
         * Why the rename is sound:
         *   - before the target is redefined rD and rS hold the same value, so
         *     a line that reads either is unaffected by the rename;
         *   - a line that reads rD is the interesting case: after the rename it
         *     reads rS, which still holds that value;
         *   - a line that writes rD carries the staged value forward into rS,
         *     and from then on rD no longer gets a value at all, so any later
         *     read of rS that is not a read of rD would see a different value
         *     and is refused;
         *   - at the end of the run nothing may still want the copy: rD may not
         *     be live after the last rewritten line, and if the target was
         *     redefined inside the run then rS may not be live there either
         *     (its old value is gone);
         *   - only r0-r7 take part, so no rewritten instruction changes its
         *     register class and none of them grows a 32-bit encoding;
         *   - every rewritten line is checked against the original text before
         *     anything is mutated (`lv_same`), so a parse that truncated an
         *     operand can never reach the output. */
        if (g_config.enable_opt_coalesce && !strcmp(iv[i].mn, "MOV") &&
            iv[i].nops == 2 && !it[i] && !lv_has_writeback(&iv[i]) &&
            cp_reg(iv[i].op[0], &d) && cp_reg(iv[i].op[1], &s) &&
            d >= 0 && d <= 7 && s >= 0 && s <= 7 && d != s && d != 6 && s != 6) {
            int last = -1, ok5 = 1, wrote_d = 0, k;
            for (j = i + 1; j < n; j++) {
                unsigned rd, wr;
                int v, brace = 0;
                if (kd[j] == 2) break;              /* label: block boundary */
                if (kd[j] != 1) continue;           /* directive / blank line */
                if (bof[j] != bof[i] || it[j] || lv_has_writeback(&iv[j])) break;
                for (v = 0; v < iv[j].nops; v++)
                    if (strchr(iv[j].op[v], '{')) brace = 1;
                if (brace) break;                   /* register list: unparsed */
                if (iv[j].mn[0] == 'B' && iv[j].mn[1] == 'L') break;
                lv_rw(&iv[j], &rd, &wr);
                /* A register that is read or written without being named in
                 * the operand list (`BL` reads its arguments out of r0-r3)
                 * cannot be renamed by rewriting text: the copy would be
                 * deleted while the implicit reader still expects it there.
                 * Measured: `MOV r0, r5` staged a call argument, the callee
                 * then ran on whatever r0 happened to hold. */
                {
                    int ment = 0;
                    for (v = 0; v < iv[j].nops; v++)
                        if (cp_mentions(iv[j].op[v], d)) ment = 1;
                    if (!ment && ((rd | wr) & lv_bit(d))) { ok5 = 0; break; }
                }
                if (wr & lv_bit(s)) {
                    /* The copy source is overwritten: nothing after this point
                     * may be renamed, and a line that also reads rD would need
                     * the copy to survive, so this run cannot be done. */
                    if (rd & lv_bit(d)) ok5 = 0;
                    break;
                }
                if (wr & lv_bit(d)) {
                    if (rd & lv_bit(d)) {
                        wrote_d = 1;                /* value carried into rS */
                        last = j;
                        continue;
                    }
                    break;                          /* copy target overwritten */
                }
                if (rd & lv_bit(d)) {
                    last = j;
                    continue;
                }
                if (wrote_d && (rd & lv_bit(s))) {  /* stale read of rS */
                    ok5 = 0;
                    break;
                }
            }
            if (ok5 && last >= 0 &&
                !(la[last] & lv_bit(d)) &&
                (!wrote_d || !(la[last] & lv_bit(s)))) {
                /* Phase 1: nothing is mutated until every line that will be
                 * renamed is known to round-trip through the parser. */
                int bad = 0;
                for (k = i + 1; k <= last && !bad; k++) {
                    unsigned gr, gw;
                    if (kd[k] != 1) continue;
                    lv_rw(&iv[k], &gr, &gw);
                    if (!(gr & lv_bit(d)) && !(gw & lv_bit(d))) continue;
                    if (!lv_same(b, ls, ll, &iv[k], k)) bad = 1;
                }
                if (!bad) {
                    /* Phase 2: rename, rebuild, emit. */
                    AsmBuffer blk5;
                    asmbuf_init(&blk5);
                    for (k = i + 1; k <= last; k++) {
                        unsigned gr, gw;
                        int v;
                        char nw5[256];
                        if (kd[k] != 1) { pp_copy_line(&blk5, b->buf + ls[k], ll[k]); continue; }
                        lv_rw(&iv[k], &gr, &gw);
                        if (!(gr & lv_bit(d)) && !(gw & lv_bit(d))) {
                            pp_copy_line(&blk5, b->buf + ls[k], ll[k]); continue;
                        }
                        for (v = 0; v < iv[k].nops; v++) {
                            if (!cp_mentions(iv[k].op[v], d)) continue;
                            if (!lv_repl_reg(nw5, sizeof nw5, iv[k].op[v], d, s)) { bad = 1; break; }
                            memcpy(iv[k].op[v], nw5, sizeof iv[k].op[v]);
                        }
                        if (bad) break;
                        if (!lv_rebuild(nw5, sizeof nw5, &iv[k])) { bad = 1; break; }
                        asmbuf_puts(&blk5, "    ");
                        asmbuf_puts(&blk5, nw5);
                        asmbuf_putc(&blk5, '\n');
                    }
                    if (!bad) {
                        if (blk5.len > 0) asmbuf_puts(&out, blk5.buf);
                        changed++;
                        i = last + 1;
                        continue;
                    }
                }
            }
        }

        pp_copy_line(&out, b->buf + ls[i], ll[i]);
        i++;
    }
    if (changed) pp_splice(b, from, &out);
    return changed;
}

/* Which registers the caller actually reads when this function returns.
 *
 * Forcing r0-r3 live at every exit was the old rule, and it is wrong in the
 * direction that costs code: a value staged in r1-r3 anywhere in the function
 * looked live at the return, and that use propagated backwards through the
 * whole body (measured on HAL_Delay: the dead "MOV r0, r5" that stages a
 * comparison operand survived the loop because r0 was "live" out of it).
 * A void function returns nothing at all; a long long / double comes back in
 * r0:r1; a struct comes back as a hidden pointer in r0. */
static int ret_is_two_words(Type *t);   /* defined with the return paths below */

static unsigned ark_ret_mask(Type *rt) {
    if (!rt) return 0xFu;                      /* unknown: stay conservative */
    if (rt->kind == TYPE_VOID) return 0;
    if (ret_is_two_words(rt)) return 0x3u;
    return 0x1u;
}

static void ark_live_function(AsmBuffer *b, int from, unsigned retmask) {
    int round;
    if (!g_config.enable_opt_live && !g_config.enable_opt_coalesce) return;
    for (round = 0; round < 4; round++) {
        if (lv_pass(b, from, retmask) == 0) break;
    }
}
#endif /* ARKCC_FEATURE_OPT_LIVE */
#endif /* ARKCC_FEATURE_OPT_COPYPROP */
#endif /* ARKCC_FEATURE_OPT_PEEP || ARKCC_FEATURE_OPT_COPYPROP || ARKCC_FEATURE_OPT_LIVE */

#if ARKCC_FEATURE_OPT_SPILL && ARKCC_FEATURE_OPT_LIVE
/* ------------- cross-block stack round trips (-fopt-spill) ---------------
 * A `PUSH {rX}` whose only reader is a later `POP {rX}` on every path is a
 * copy routed through memory: nothing between the two names rX, and the pop
 * puts back exactly the value the push saved.  Deleting both halves leaves
 * rX holding that same value and keeps sp balance, so it is invisible to the
 * rest of the function.
 *
 * The shape this exists for is the diamond the reference model emits for a
 * conditional expression: each arm pushes its result, the merge point pops
 * it.  A linear scan cannot see that (two pushes, one pop looks like one
 * lost value), which is why docs/EXPR_MODEL.md S10's original 355-instruction
 * ceiling was wrong: with the CFG the corpus loses 331 lines (2.90% of the
 * 26-flag instruction count, -1.17% bytes) and only 3 real dead stores exist
 * (S10.5).  That is the 2-4% bucket, so the pass is registered and off by
 * default.
 *
 * What must hold, on every path between the push and the pop:
 *   - rX is not written (a write would be undone by the pop, so removing the
 *     pair would change the result -- and vice versa, keeping it is safe);
 *   - sp is not moved by anything but a constant `ADD/SUB sp, sp, #imm`
 *     (a `MOV sp, ...` makes the depth unknown, and the pass stops there);
 *   - no instruction addresses `[sp, ...]`; deleting a push moves sp for the
 *     instructions after it on that path, so an sp-relative access anywhere
 *     in the function disqualifies the whole function (0 occurrences in every
 *     artefact this compiler emits today -- the emitter always works through
 *     a frame base register);
 *   - no conditional-instruction block (IT) and no branch in or out of the
 *     region that the analysis cannot model;
 *   - a push whose value is popped by more than one pop is left alone, since
 *     deleting it would break the other reader.
 * Anything not provable leaves the pair in place: the pass never guesses.
 */
#define SP_MAX_LINES  PP_MAX_LINES   /* same ceiling as the live pass */
#define SP_MAX_LABELS 4096          /* LV_MAX_LABELS (256) is too small: one big
                                     * HAL function can carry >256 labels */
#define SP_LAB_LEN    64
#define SP_MAX_DEPTH  48
#define SP_MAX_PUSH  512   /* id, not a bit: 32-bit sets capped one big function */

typedef struct {
    int line;          /* instruction index of the PUSH */
    int reg;           /* the single register it saves */
    int depth;         /* words on the stack before the push */
    int ok;            /* every path pops it back into the same register */
    int claim;         /* how many POPs read this push's slot */
    int del;           /* 1 = the pair is removed this round */
} SpillPush;

static int      sp_n;
static int      sp_ls[SP_MAX_LINES], sp_ll[SP_MAX_LINES];
static cp_ins   sp_iv[SP_MAX_LINES];
static unsigned char sp_kd[SP_MAX_LINES];   /* 0 other, 1 instruction, 2 label */
static unsigned char sp_it[SP_MAX_LINES];
static int      sp_s0[SP_MAX_LINES], sp_s1[SP_MAX_LINES];
static int      sp_depth[SP_MAX_LINES];     /* words before the item, -1 unknown */
/* One word above the frame, described by the registers that may have pushed
 * it (0..15), whether any definition was seen at all, and whether some
 * definition is not a provable push of that word.  Joining paths is an OR. */
#define SP_SLOT_REGS(c)  ((c) & 0xFFFFu)
#define SP_SLOT_UNT      0x10000u
#define SP_SLOT_HAS      0x20000u
static unsigned *sp_st;                    /* sp_st_row(i)[s] = slot s of line i */
static int      sp_st_cap;
#define sp_st_row(i) (sp_st + (size_t)(i) * SP_MAX_DEPTH)

static int sp_st_reserve(int lines) {
    unsigned *p;
    if (lines <= sp_st_cap) return 1;
    p = (unsigned *)realloc(sp_st, (size_t)lines * SP_MAX_DEPTH * sizeof(unsigned));
    if (!p) return 0;
    sp_st = p;
    sp_st_cap = lines;
    return 1;
}
static unsigned char sp_has[SP_MAX_LINES];
static unsigned char sp_pdel[SP_MAX_LINES];  /* POP proved deletable this round */
static int      sp_strict;                   /* 1 = a POP counts only if deletable */
static unsigned char sp_vis[SP_MAX_LINES];
static char     sp_lab[SP_MAX_LABELS][SP_LAB_LEN];
static int      sp_labline[SP_MAX_LABELS];
static SpillPush sp_push[SP_MAX_PUSH];
static int      sp_npush;

static int sp_popcount(unsigned v) {
    int c = 0;
    while (v) { c += (int)(v & 1u); v >>= 1; }
    return c;
}

/* `{r0, r3, lr}` -> count, mask.  -1 if the list cannot be modelled exactly
 * (odd token, duplicate name, empty list). */
static int sp_reglist(const char *s, unsigned *mask) {
    int n = 0, i = 1, cnt;
    unsigned m = 0;
    if (s[0] != '{') return -1;
    for (;;) {
        int r = -1;
        while (s[i] == ' ' || s[i] == '\t') i++;
        if (s[i] == '}') { i++; break; }
        if (!s[i]) return -1;
        if (!strncmp(s + i, "lr", 2) && !(s[i + 2] >= 'a' && s[i + 2] <= 'z')) {
            r = 14; i += 2;
        } else if (!strncmp(s + i, "pc", 2) && !(s[i + 2] >= 'a' && s[i + 2] <= 'z')) {
            r = 15; i += 2;
        } else if (s[i] == 'r' && s[i + 1] >= '0' && s[i + 1] <= '9') {
            int v = s[i + 1] - '0';
            i += 2;
            if (s[i] >= '0' && s[i] <= '9') { v = v * 10 + (s[i] - '0'); i++; }
            r = v;
        } else {
            return -1;
        }
        if (r < 0 || r > 15) return -1;
        m |= lv_bit(r);
        n++;
        while (s[i] == ' ' || s[i] == '\t') i++;
        if (s[i] == ',') { i++; continue; }
        if (s[i] == '}') { i++; break; }
        return -1;
    }
    if (s[i]) return -1;
    cnt = sp_popcount(m);
    if (n == 0 || cnt != n) return -1;
    *mask = m;
    return n;
}

static int sp_is_sp(const char *s) { return !strcmp(s, "sp"); }

/* `#imm` -> bytes, -1 if not a plain decimal/hex immediate. */
static int sp_imm_bytes(const char *s) {
    int v = 0;
    if (s[0] != '#') return -1;
    s++;
    if (!*s) return -1;
    while (*s >= '0' && *s <= '9') { v = v * 10 + (*s - '0'); s++; }
    if (*s) return -1;
    return v;
}

/* 1 = this instruction addresses [sp, ...]. */
static int sp_reads_sp_mem(const cp_ins *o) {
    int i;
    for (i = 0; i < o->nops; i++)
        if (strstr(o->op[i], "[sp") || strstr(o->op[i], "[SP")) return 1;
    return 0;
}

/* Classify one push: 1 ok, 0 bad, 2 dead (every path leaves the function).
 * `d` is the depth before the push. */
static int sp_classify(int start, int reg, int d) {
    static int stack[SP_MAX_LINES];
    int top = 0, ok = 0, bad = 0, exit_ = 0;
    memset(sp_vis, 0, (size_t)sp_n);
    if (sp_s0[start] >= 0) stack[top++] = sp_s0[start];
    if (sp_s1[start] >= 0) stack[top++] = sp_s1[start];
    while (top > 0) {
        int j = stack[--top], cnt;
        unsigned mask, rd, wr;
        const cp_ins *o;
        if (sp_vis[j]) continue;
        sp_vis[j] = 1;
        if (sp_kd[j] != 1) {
            if (sp_s0[j] < 0) exit_ = 1;
            else stack[top++] = sp_s0[j];
            continue;
        }
        if (sp_it[j]) { bad = 1; break; }
        o = &sp_iv[j];
        if (!strcmp(o->mn, "POP") && o->nops == 1) {
            cnt = sp_reglist(o->op[0], &mask);
            if (cnt < 0) { bad = 1; break; }
            if (mask & lv_bit(15)) { exit_ = 1; continue; }
            if (sp_depth[j] < 0) { bad = 1; break; }
            if (sp_depth[j] - 1 == d && cnt == 1 && (mask & lv_bit(reg))) {
                /* Deleting the push without deleting this pop would leave the
                 * pop reading a slot nothing pushed, so a pop that is not in
                 * the delete set makes the whole path bad. */
                if (!sp_strict || sp_pdel[j]) ok = 1;
                else bad = 1;
                break;
            }
            if (sp_depth[j] - 1 >= d) { bad = 1; break; }
            if (sp_s0[j] >= 0) stack[top++] = sp_s0[j];
            continue;
        }
        if (!strcmp(o->mn, "PUSH")) {
            /* pushing more values does not touch rX: keep walking */
            if (sp_s0[j] >= 0) stack[top++] = sp_s0[j];
            continue;
        }
        if (!strcmp(o->mn, "POP") || sp_is_sp(o->op[0]) ||
            (o->nops >= 3 && sp_is_sp(o->op[1]))) {
            bad = 1;
            break;
        }
        lv_rw(o, &rd, &wr);
        if (wr & lv_bit(reg)) { bad = 1; break; }
        /* An unconditional `B` is a block end but has a real successor;
         * only a line with no successor (BX lr, POP {..pc}, RET) leaves the
         * function.  Reading `B` as an exit was why a diamond's first arm
         * never reached its pop. */
        if (sp_s0[j] < 0) { exit_ = 1; continue; }
        stack[top++] = sp_s0[j];
    }
    if (bad) return 0;
    if (!ok && exit_) return 2;
    if (!ok) return 0;
    return 1;
}

/* Is item i a single-register POP whose slot is defined, on every path, by
 * provable pushes of exactly the register it reads? */
static int sp_pop_valid(int i) {
    unsigned mask, cam;
    int cnt, top;
    if (sp_kd[i] != 1 || sp_it[i]) return 0;
    if (strcmp(sp_iv[i].mn, "POP") || sp_iv[i].nops != 1) return 0;
    cnt = sp_reglist(sp_iv[i].op[0], &mask);
    if (cnt != 1 || (mask & lv_bit(15))) return 0;
    if (!sp_has[i] || sp_depth[i] <= 0 || sp_depth[i] > SP_MAX_DEPTH) return 0;
    top = sp_depth[i] - 1;
    cam = sp_st_row(i)[top];
    if (!(cam & SP_SLOT_HAS) || (cam & SP_SLOT_UNT)) return 0;
    if (SP_SLOT_REGS(cam) != mask) return 0;
    return 1;
}

static int ark_spill_function(AsmBuffer *b, int from) {
    int i, j, n, nlab = 0, iter, round, deleted = 0, npair = 0, npair_pops = 0;
    int base_depth[16], base_writes[16];
    AsmBuffer out;
    n = pp_split_lines(b, from, sp_ls, sp_ll, SP_MAX_LINES);
    if (n <= 0) return 0;
    if (!sp_st_reserve(n)) return 0;
    sp_n = n;
    sp_npush = 0;
    for (i = 0; i < n; i++) {
        char t[256];
        int L;
        sp_kd[i] = 0; sp_it[i] = 0; sp_s0[i] = sp_s1[i] = -1;
        sp_depth[i] = -1; sp_has[i] = 0;
        if (sp_ll[i] >= (int)sizeof t) continue;
        if (pp_trim(b->buf + sp_ls[i], sp_ll[i], t, sizeof t) < 0) continue;
        if (!t[0] || t[0] == ';' || t[0] == '@') continue;
        L = ark_strlen(t);
        if (L > 0 && t[L - 1] == ':') {
            if (nlab < SP_MAX_LABELS) {
                int k = 0;
                while (k < L - 1 && k < SP_LAB_LEN - 1) { sp_lab[nlab][k] = t[k]; k++; }
                sp_lab[nlab][k] = 0;
                sp_labline[nlab] = i;
                nlab++;
            }
            sp_kd[i] = 2;
            continue;
        }
        if (t[0] == '.') continue;
        if (cp_parse(t, &sp_iv[i])) sp_kd[i] = 1;
    }
    /* Bail out of functions this analysis does not model: an sp-relative
     * access anywhere (deleting a push would move sp under it), VLA/alloca
     * (dynamic sp), or any instruction that itself moves sp by a register. */
    for (i = 0; i < n; i++) {
        if (sp_kd[i] != 1) continue;
        if (sp_reads_sp_mem(&sp_iv[i])) return 0;   /* deleting a push would move sp */
        if (!strcmp(sp_iv[i].mn, "ADD") || !strcmp(sp_iv[i].mn, "SUB")) {
            if (sp_iv[i].nops == 3 && sp_is_sp(sp_iv[i].op[0]) &&
                sp_is_sp(sp_iv[i].op[1]) && sp_imm_bytes(sp_iv[i].op[2]) < 0)
            return 0;   /* dynamic sp (VLA / alloca) */
        }
        if (!strcmp(sp_iv[i].mn, "ADD") && sp_is_sp(sp_iv[i].op[0]) &&
            sp_iv[i].nops >= 2 && sp_is_sp(sp_iv[i].op[2]))
            return 0;   /* sp moved by a register: depth not modellable */
    }
    /* IT membership: an instruction under an IT is conditional and cannot be
     * reasoned about one path at a time. */
    for (i = 0; i < n; i++) {
        if (sp_kd[i] != 1) continue;
        if (sp_iv[i].mn[0] == 'I' && sp_iv[i].mn[1] == 'T' &&
            (sp_iv[i].mn[2] == 0 || sp_iv[i].mn[2] == 'T' || sp_iv[i].mn[2] == 'E')) {
            int cnt = ark_strlen(sp_iv[i].mn) - 1, c = 0;
            for (j = i + 1; j < n && c < cnt; j++) {
                if (sp_kd[j] == 2) break;
                if (sp_kd[j] == 1) { sp_it[j] = 1; c++; }
            }
        }
    }
    /* Frame base register: a `MOV rB, sp` in the straight-line prologue whose
     * rB is written nowhere else makes every later `MOV sp, rB` restore the
     * stack to the depth rB was recorded at.  That is the only way the depth
     * survives past the first return for a compiler that leaves through a
     * base register; without it every push after that point is unknown. */
    {
        int lin = 0, seen_ins = 0, k;
        for (k = 0; k < 16; k++) { base_depth[k] = -1; base_writes[k] = 0; }
        for (i = 0; i < n; i++) {
            unsigned rd, wr;
            if (sp_kd[i] != 1) continue;
            lv_rw(&sp_iv[i], &rd, &wr);
            for (k = 0; k < 16; k++) if (wr & lv_bit(k)) base_writes[k]++;
            if (lin < 0) { seen_ins = 1; continue; }
            if (!strcmp(sp_iv[i].mn, "PUSH") && sp_iv[i].nops == 1) {
                unsigned mask;
                int cnt = sp_reglist(sp_iv[i].op[0], &mask);
                if (cnt < 0 || lin + cnt > SP_MAX_DEPTH) lin = -1;
                else lin += cnt;
            } else if (!strcmp(sp_iv[i].mn, "SUB") && sp_iv[i].nops == 3 &&
                       sp_is_sp(sp_iv[i].op[0]) && sp_is_sp(sp_iv[i].op[1])) {
                int nb = sp_imm_bytes(sp_iv[i].op[2]);
                if (nb < 0 || (nb & 3) || lin + nb / 4 > SP_MAX_DEPTH) lin = -1;
                else lin += nb / 4;
            } else if (!strcmp(sp_iv[i].mn, "MOV") && sp_iv[i].nops == 2 &&
                       sp_is_sp(sp_iv[i].op[1])) {
                int rb;
                if (cp_reg(sp_iv[i].op[0], &rb) && rb >= 0 && rb <= 12)
                    base_depth[rb] = lin;
            } else if (lv_branch_kind(sp_iv[i].mn) || lv_ends_block(&sp_iv[i])) {
                lin = -1;
            } else if (seen_ins && sp_is_sp(sp_iv[i].op[0])) {
                lin = -1;
            }
            seen_ins = 1;
        }
    }
    /* Item-level control flow. */
    for (i = 0; i < n; i++) {
        int k, tgt = -1, q, m2;
        if (sp_kd[i] != 1) {
            sp_s0[i] = (i + 1 < n) ? i + 1 : -1;
            continue;
        }
        k = lv_branch_kind(sp_iv[i].mn);
        if (k == 1 || k == 2) {
            for (q = 0; q < sp_iv[i].nops; q++) {
                const char *p = sp_iv[i].op[q];
                if (!p[0] || p[0] == '#' || p[0] == '[' || p[0] == '{') continue;
                if (lv_regs(p)) continue;
                for (m2 = 0; m2 < nlab; m2++)
                    if (!strcmp(sp_lab[m2], p)) { tgt = sp_labline[m2]; break; }
                if (tgt >= 0) break;
            }
            if (tgt < 0) return 0;   /* branch target not found: do not guess */
            while (tgt < n && sp_kd[tgt] == 2) tgt++;
            if (tgt >= n) return 0;
            sp_s0[i] = tgt;
            if (k == 2) sp_s1[i] = (i + 1 < n) ? i + 1 : -1;
            continue;
        }
        if (k == 4) { sp_s0[i] = -1; continue; }
        if (lv_ends_block(&sp_iv[i])) { sp_s0[i] = -1; continue; }
        sp_s0[i] = (i + 1 < n) ? i + 1 : -1;
    }
    /* Candidate pushes: one register, not lr/pc/sp. */
    for (i = 0; i < n && sp_npush < SP_MAX_PUSH; i++) {
        int cnt;
        unsigned mask;
        if (sp_kd[i] != 1 || sp_it[i]) continue;
        if (strcmp(sp_iv[i].mn, "PUSH") || sp_iv[i].nops != 1) continue;
        cnt = sp_reglist(sp_iv[i].op[0], &mask);
        if (cnt != 1) continue;
        if (mask & (lv_bit(13) | lv_bit(14) | lv_bit(15))) continue;
        sp_push[sp_npush].line = i;
        sp_push[sp_npush].reg = (mask & lv_bit(0)) ? 0 :
            (mask & lv_bit(1)) ? 1 : (mask & lv_bit(2)) ? 2 :
            (mask & lv_bit(3)) ? 3 : (mask & lv_bit(4)) ? 4 :
            (mask & lv_bit(5)) ? 5 : (mask & lv_bit(6)) ? 6 :
            (mask & lv_bit(7)) ? 7 : (mask & lv_bit(8)) ? 8 :
            (mask & lv_bit(9)) ? 9 : (mask & lv_bit(10)) ? 10 :
            (mask & lv_bit(11)) ? 11 : 12;
        sp_push[sp_npush].depth = -1;
        sp_push[sp_npush].ok = 0;
        sp_push[sp_npush].claim = 0;
        sp_push[sp_npush].del = 0;
        sp_npush++;
    }
/* Depth + slot-definition dataflow.
     *
     * sp_st_row(i)[s] describes word s above the frame at entry to item i:
     *   SP_SLOT_REGS(c)  one bit per register that may have pushed it,
     *   SP_SLOT_HAS      at least one definition was seen,
     *   SP_SLOT_UNT      some definition is not a provable push of that word.
     * Joining two paths is a plain OR: registers union, and one untracked
     * definition poisons the word for good.  A register bit mask (rather than
     * a set of push ids) is enough because the only question asked later is
     * "is every definition a push of the register this POP reads?".
     *
     * The flow runs more than once, because what a push contributes depends on
     * facts learned from the previous run:
     *   round 0  depths only (everything untracked); learns each push's depth
     *            and whether every path pops it back (sp_classify),
     *   round 1  a definition is clean only if that push is `ok`,
     *   round n  ... only if that push is `del` (delete set shrinks to a fixpoint).
     */
    for (round = 0; round < 8; round++) {
        int nd = 0, ndel = 0;
        for (i = 0; i < n; i++) { sp_has[i] = 0; sp_depth[i] = -1; }
        sp_has[0] = 1;
        sp_depth[0] = 0;
        for (iter = 0; iter < 64; iter++) {
            int ch = 0;
            for (i = 0; i < n; i++) {
                unsigned out[SP_MAX_DEPTH];
                int olen, s;
                if (!sp_has[i]) continue;
                olen = sp_depth[i];
                if (olen > 0) memcpy(out, sp_st_row(i), (size_t)olen * sizeof out[0]);
                if (sp_kd[i] == 1) {
                    const cp_ins *o = &sp_iv[i];
                    int rb0 = -1;
                    if (!sp_it[i] && !strcmp(o->mn, "MOV") && o->nops == 2 &&
                        sp_is_sp(o->op[0])) {
                        /* `MOV sp, rB` is an absolute restore: it re-establishes
                         * the depth rB was recorded at in the prologue, even when
                         * an earlier instruction left the depth unknown.  The slot
                         * contents are not followed across such a restore. */
                        if (cp_reg(o->op[1], &rb0) && rb0 >= 0 && rb0 <= 12 &&
                            base_depth[rb0] >= 0 && base_writes[rb0] == 1) {
                            olen = base_depth[rb0];
                            for (s = 0; s < olen; s++)
                                out[s] = SP_SLOT_HAS | SP_SLOT_UNT;
                        } else {
                            olen = -1;
                        }
                    } else if (sp_it[i]) {
                        /* An IT-guarded instruction that cannot touch sp leaves
                         * the depth alone; only a guarded sp write poisons it. */
                        unsigned rd2, wr2;
                        lv_rw(o, &rd2, &wr2);
                        if ((wr2 & lv_bit(13)) || !strcmp(o->mn, "PUSH") ||
                            !strcmp(o->mn, "POP"))
                            olen = -1;
                    } else if (olen < 0) {
                        /* already unknown: it stays unknown */
                    } else if (!strcmp(o->mn, "PUSH") && o->nops == 1) {
                        unsigned mask;
                        int cnt = sp_reglist(o->op[0], &mask), id = -1;
                        if (cnt < 0) { olen = -1; }
                        else if (olen + cnt > SP_MAX_DEPTH) { olen = -1; }
                        else {
                            if (cnt == 1) {
                                for (s = 0; s < sp_npush; s++)
                                    if (sp_push[s].line == i) { id = s; break; }
                            }
                            for (s = 0; s < cnt; s++) {
                                unsigned w = SP_SLOT_HAS | SP_SLOT_UNT;
                                if (id >= 0 && round > 0) {
                                    int clean = (round == 1) ? sp_push[id].ok
                                                             : sp_push[id].del;
                                    if (clean)
                                        w = SP_SLOT_HAS |
                                            (1u << sp_push[id].reg);
                                }
                                out[olen++] = w;
                            }
                        }
                    } else if (!strcmp(o->mn, "POP") && o->nops == 1) {
                        unsigned mask;
                        int cnt = sp_reglist(o->op[0], &mask);
                        if (cnt < 0) { olen = -1; }
                        else if (mask & lv_bit(15)) { olen = -2; }
                        else if (olen < cnt) { olen = -1; }
                        else olen -= cnt;
                    } else if (!strcmp(o->mn, "SUB") && o->nops == 3 &&
                               sp_is_sp(o->op[0]) && sp_is_sp(o->op[1])) {
                        int nbytes = sp_imm_bytes(o->op[2]);
                        if (nbytes < 0 || (nbytes & 3) || olen + nbytes / 4 > SP_MAX_DEPTH) {
                            olen = -1;
                        } else {
                            for (s = 0; s < nbytes / 4; s++)
                                out[olen++] = SP_SLOT_HAS | SP_SLOT_UNT;
                        }
                    } else if (!strcmp(o->mn, "ADD") && o->nops == 3 &&
                               sp_is_sp(o->op[0]) && sp_is_sp(o->op[1])) {
                        int nbytes = sp_imm_bytes(o->op[2]);
                        if (nbytes < 0 || (nbytes & 3) || nbytes / 4 > olen) {
                            olen = -1;
                        } else {
                            olen -= nbytes / 4;
                        }
                    }
                }
                if (olen == -2) continue;   /* POP {... pc}: leaves the function */
                if (sp_s0[i] >= 0) {
                    j = sp_s0[i];
                    if (!sp_has[j]) {
                        sp_has[j] = 1;
                        sp_depth[j] = olen;
                        if (olen > 0) memcpy(sp_st_row(j), out, (size_t)olen * sizeof out[0]);
                        ch = 1;
                    } else if (olen < 0 || sp_depth[j] < 0) {
                        if (sp_depth[j] >= 0) { sp_depth[j] = -1; ch = 1; }
                    } else if (sp_depth[j] != olen) {
                        return 0;   /* two paths disagree on the depth */
                    } else {
                        for (s = 0; s < olen; s++) {
                            unsigned u = sp_st_row(j)[s] | out[s];
                            if (u != sp_st_row(j)[s]) { sp_st_row(j)[s] = u; ch = 1; }
                        }
                    }
                }
                if (sp_s1[i] >= 0) {
                    j = sp_s1[i];
                    if (!sp_has[j]) {
                        sp_has[j] = 1;
                        sp_depth[j] = olen;
                        if (olen > 0) memcpy(sp_st_row(j), out, (size_t)olen * sizeof out[0]);
                        ch = 1;
                    } else if (olen < 0 || sp_depth[j] < 0) {
                        if (sp_depth[j] >= 0) { sp_depth[j] = -1; ch = 1; }
                    } else if (sp_depth[j] != olen) {
                        return 0;   /* two paths disagree on the depth */
                    } else {
                        for (s = 0; s < olen; s++) {
                            unsigned u = sp_st_row(j)[s] | out[s];
                            if (u != sp_st_row(j)[s]) { sp_st_row(j)[s] = u; ch = 1; }
                        }
                    }
                }
            }
            if (!ch) break;
        }
        if (round == 0) {
            /* Record the depth of every push, then ask whether every path from
             * it reads the slot back into the same register. */
            for (i = 0; i < sp_npush; i++) {
                int ln = sp_push[i].line;
                sp_push[i].ok = 0;
                sp_push[i].depth = -1;
                if (sp_depth[ln] < 0) continue;
                sp_push[i].depth = sp_depth[ln];
                sp_strict = 0;
                sp_push[i].ok = sp_classify(ln, sp_push[i].reg, sp_push[i].depth) == 1;
            }
            for (i = 0; i < n; i++) sp_pdel[i] = 0;
            for (i = 0; i < sp_npush; i++) sp_push[i].del = 0;
            continue;
        }
        /* A POP may go only when every definition of its slot is a clean push
         * of the very register it reads. */
        for (i = 0; i < n; i++) {
            int v = sp_pop_valid(i);
            if (v != (int)sp_pdel[i]) nd = 1;
            sp_pdel[i] = (unsigned char)v;
        }
        /* A push may go only when it is ok and every path from it ends in a
         * POP this pass is also deleting (sp_classify consults sp_pdel now). */
        sp_strict = 1;
        for (i = 0; i < sp_npush; i++) {
            int d = sp_push[i].ok &&
                    sp_classify(sp_push[i].line, sp_push[i].reg, sp_push[i].depth) == 1;
            if (d != sp_push[i].del) ndel = 1;
            sp_push[i].del = d;
        }
        if (round > 1 && !nd && !ndel) break;
    }
    npair = npair_pops = deleted = 0;
    asmbuf_init(&out);
    for (i = 0; i < n; i++) {
        int skip = 0;
        if (sp_kd[i] == 1) {
            int k;
            for (k = 0; k < sp_npush; k++)
                if (sp_push[k].del && sp_push[k].line == i) { skip = 1; npair++; break; }
            if (!skip && sp_pdel[i]) { skip = 1; npair_pops++; }
        }
        if (skip) { deleted++; continue; }
        pp_copy_line(&out, b->buf + sp_ls[i], sp_ll[i]);
    }
    /* Self-check, so a broken walk can never reach the output: every line
     * that disappeared must be a push this pass proved or a pop whose every
     * reaching definition was one of those pushes.  A pop implies at least
     * one push, so `deleted` must exceed `npair` by exactly the pops. */
    if (npair <= 0 || npair_pops <= 0 || deleted != npair + npair_pops) {
        return 0;
    }    pp_splice(b, from, &out);
    return deleted;
}
#endif /* ARKCC_FEATURE_OPT_SPILL && ARKCC_FEATURE_OPT_LIVE */

#if ARKCC_FEATURE_OPT_REGALLOC
/* --------------------------- register allocation -------------------------
 * What this is, exactly: after a function has been emitted, its text is walked
 * once and the hottest local slots are moved out of memory and into r8-r11.
 * "In a register" here means the emitted instruction changes shape, not that a
 * graph-colouring allocator has run:
 *      LDR r0, [r6, #off]   ->   MOV r0, rN
 *      STR r0, [r6, #off]   ->   MOV rN, r0
 * and rN joins the same PUSH/POP list the prologue already uses, so the frame
 * layout (and therefore every other offset) is untouched.
 *
 * Why a text pass instead of IR-level liveness: the IR stack machine has ~200
 * opcodes, and each one would have to learn about a new register.  A text pass
 * has exactly one rule to get right, and the rule is checked rather than
 * assumed -- a slot is only ever selected when *every* mention of it in the
 * whole function is one of the two lines above.  One mention in any other shape
 * (LDRB, STRH, "ADD r0, r6, #off", a 64-bit half, a struct field, a volatile
 * access) marks the slot as tainted and it stays in memory.  That is the whole
 * safety argument, and tests/run_regalloc_tests.py fails if it is ever wrong.
 *
 * r8-r11 are the registers: the backend never names them, and AAPCS makes them
 * callee-saved, so they survive calls to __aeabi_* helpers and to user code.
 *
 * The cost model, measured rather than assumed: a near slot ("LDR r0,[r6,#0..124]"
 * with a multiple-of-4 offset) is a 16-bit instruction, and so is "MOV r0, rN" --
 * moving a near slot saves *nothing*.  Only a far slot (offset > 124, or not a
 * multiple of 4) is 32-bit and saves 2 bytes.  The prologue/epilogue PUSH/POP
 * grow by 2 bytes each the moment a high register joins the list, so a function
 * pays 4 bytes once, no matter how many registers it takes.  Taking near slots
 * anyway was measured on src/irgen.c: 1853 slots moved, code grew 148 bytes.
 * Hence two modes:
 *   default              take a slot only when its byte savings pay for the
 *                        4-byte PUSH/POP widening -> the function never grows;
 *   -fopt-regalloc-near  also take near slots (>= 3 accesses): fewer memory
 *                        accesses in the hot path, at ~4 bytes per function.
 *
 * Two frame rules, both found by running the varargs gate with the pass on:
 *
 *   - the saved block anchors everything above the locals.  The prologue pushes
 *     r0-r3 (variadic) and {r5,r6,r7,lr} between sp_entry and the frame, so
 *     every offset above local_size names the saved block or the caller's
 *     argument image, and widening the saved PUSH moves all of them.  They are
 *     shifted, not left stale (ra_shift_line);
 *   - the saved block stays a multiple of 8 bytes.  An odd count of saved words
 *     leaves sp at 4 mod 8, which breaks AAPCS at every call and would unalign
 *     the va region too, so an odd count takes one spare register. */
#define RA_MAX_SLOTS 96
#define RA_MAX_REGS  4
#define RA_MIN_USES  3      /* 2 bytes saved per use, 4 bytes of PUSH/POP to pay */

typedef struct {
    int off;
    int uses;
    int saves;    /* bytes of instruction text this slot would save */
    int taint;
    int reg;
} RaSlot;

static int ra_enabled(void) {
    return g_config.enable_opt_regalloc ? 1 : 0;
}

static int ra_pre8(const char *s, const char *pat) {
    int i;
    for (i = 0; i < 8; i++)
        if (s[i] != pat[i]) return 0;
    return 1;
}

/* The prologue and the value-stack spills share a prefix: a spill that keeps
 * one value looks like `PUSH {r5}` while the frame save is `PUSH {r5, r6, r7,
 * lr}`.  Comparing a prefix therefore mistook a mid-function spill for the
 * frame save and widened it, wiping out the frame that was already there.  The
 * register list is compared with spaces removed and *in full*, so only the one
 * shape the epilogue can restore is accepted; the `r4` variant of the prologue
 * (a vstack-only shape) is deliberately not ours: it carries an extra pad word
 * whose alignment the widening would break.
 *
 *   prologue:  PUSH {r5, r6, r7, lr}
 *   epilogue:  POP  {r5, r6, r7, pc}   (normal)
 *              POP  {r5, r6, r7, lr}   (variadic, followed by ADD sp / BX lr) */
static int ra_list_is(const char *line, const char *want) {
    char flat[128];
    int i = 0, j = 0;
    while (line[i] && j < (int)sizeof(flat) - 1) {
        if (line[i] != ' ' && line[i] != '\t') flat[j++] = line[i];
        i++;
    }
    flat[j] = 0;
    return strcmp(flat, want) == 0;
}

static int ra_is_prologue_push(const char *line) {
    return ra_list_is(line, "PUSH{r5,r6,r7,lr}");
}

static int ra_is_epilogue_pop(const char *line) {
    return ra_list_is(line, "POP{r5,r6,r7,pc}") ||
           ra_list_is(line, "POP{r5,r6,r7,lr}");
}

/* Offset of the comma that starts the last element of a register list, so a
 * rewrite can keep the head (and any extra register the emitter put there) and
 * the tail (`pc}` vs `lr}`) exactly as they were.  -1 if there is no list. */
static int ra_last_elem_at(const char *line) {
    int n = (int)strlen(line), i;
    for (i = n - 1; i >= 0; i--)
        if (line[i] == '}') break;
    if (i <= 0) return -1;
    for (; i >= 0; i--)
        if (line[i] == ',') return i;
    return -1;
}

/* Is register `r` named as a whole token on this line?  A widened PUSH/POP
 * that names a register twice is silently deduplicated by the assembler, so
 * the word count -- and every offset derived from it -- would be wrong. */
static int ra_names_reg(const char *line, int r) {
    const char *p = line;
    while (*p) {
        if (p[0] == 'r' && p[1] >= '0' && p[1] <= '9' &&
            !(p > line && (((p[-1] >= 'a' && p[-1] <= 'z') ||
                            (p[-1] >= 'A' && p[-1] <= 'Z')) ||
                           (p[-1] >= '0' && p[-1] <= '9')))) {
            const char *q = p + 1;
            int n = 0;
            while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
            if (!(((q[0] >= 'a' && q[0] <= 'z') || (q[0] >= 'A' && q[0] <= 'Z')) ||
                  (q[0] >= '0' && q[0] <= '9')))
                if (n == r) return 1;
            p = q;
            continue;
        }
        p++;
    }
    return 0;
}

/* Classify one assembly line.
 *   -1  no "[r6, #<n>]" at all
 *    0  exactly "LDR r0, [r6, #n]"   (*off, *is_ldr = 1)
 *    1  exactly "STR r0, [r6, #n]"   (*off, *is_ldr = 0)
 *    2  names that slot in any other shape -- cannot be kept in a register */
static int ra_classify(const char *ln, int *off, int *is_ldr, int *wide) {
    const char *p = ln;
    const char *br;
    int n = 0;
    /* Any "r6, #n" at all -- not just "[r6, #n]".  "ADD r0, r6, #n" is the
     * address of the slot, and a slot whose address escapes cannot live in a
     * register: the pointer would keep writing to memory the variable no
     * longer uses. */
    while (p[0] && !(p[0] == 'r' && p[1] == '6' && p[2] == ',' && p[3] == ' '))
        p++;
    if (!p[0]) return -1;
    if (p == ln || p[-1] != '[') return 2;
    br = p - 1;
    p = br + 5;
    if (*p != '#') return 2;
    p++;
    if (*p < '0' || *p > '9') return 2;
    while (*p >= '0' && *p <= '9') { n = n * 10 + (*p - '0'); p++; }
    *off = n;
    if (*p != ']') return 2;
    p++;
    while (*p == ' ' || *p == '\t' || *p == '\r') p++;
    if (*p) return 2;                     /* trailing text: not the shape we model */
    /* Same rule the encoder uses: the 16-bit form covers offsets 0..124 that
     * are a multiple of 4.  Everything else is 32-bit, and only that case makes
     * replacing the access with a MOV smaller. */
    *wide = (n > 124 || (n & 3) != 0);
    {
        const char *s = ln;
        while (*s == ' ' || *s == '\t') s++;
        if (s + 8 == br && ra_pre8(s, "LDR r0, ")) { *is_ldr = 1; return 0; }
        if (s + 8 == br && ra_pre8(s, "STR r0, ")) { *is_ldr = 0; return 0; }
    }
    return 2;
}

static int ra_slot(RaSlot *slots, int *n, int off) {
    int i;
    for (i = 0; i < *n; i++)
        if (slots[i].off == off) return i;
    if (*n >= RA_MAX_SLOTS) return -1;    /* table full: treat as tainted */
    slots[*n].off = off;
    slots[*n].uses = 0;
    slots[*n].saves = 0;
    slots[*n].taint = 0;
    slots[*n].reg = 0;
    return (*n)++;
}

/* Write a non-negative decimal, return the new output index. */
static int ra_num_out(char *dst, int o, int v) {
    char num[12];
    int n = 0, t;
    if (v == 0) num[n++] = '0';
    while (v > 0) { num[n++] = (char)('0' + v % 10); v /= 10; }
    for (t = n - 1; t >= 0; t--) dst[o++] = num[t];
    return o;
}

/* The shape -fopt-vreg elides: a plain load of a frame slot into any register.
 * ra_classify() below only accepts r0 -- it is asked "is this slot entirely
 * one of the two shapes I can rewrite", which is the -fopt-regalloc proof, and
 * a value the stack model staged in r5 is not it.  The register-pool split
 * needs the opposite question ("how much traffic does this slot carry, whoever
 * holds it"), so it counts these separately, per slot and regardless of taint.
 * The count is an upper bound on what -fopt-vreg can elide. */
#define RA_MAX_ANY 96
static int ra_any_off[RA_MAX_ANY];
static int ra_any_cnt[RA_MAX_ANY];
static int ra_any_n;

static void ra_any_note(int off) {
    int i;
    for (i = 0; i < ra_any_n; i++)
        if (ra_any_off[i] == off) { ra_any_cnt[i]++; return; }
    if (ra_any_n >= RA_MAX_ANY) return;   /* table full: under-count, never taint */
    ra_any_off[ra_any_n] = off;
    ra_any_cnt[ra_any_n] = 1;
    ra_any_n++;
}

static int ra_any_max(void) {
    int i, m = 0;
    for (i = 0; i < ra_any_n; i++)
        if (ra_any_cnt[i] > m) m = ra_any_cnt[i];
    return m;
}

static int ra_ldr_any(const char *ln, int *off) {
    const char *p = ln;
    int n = 0;
    while (*p == ' ' || *p == '\t') p++;
    if (strncmp(p, "LDR r", 5) != 0) return 0;
    p += 5;
    if (*p < '0' || *p > '9') return 0;
    while (*p >= '0' && *p <= '9') p++;
    if (strncmp(p, ", [r6, #", 8) != 0) return 0;
    p += 8;
    if (*p < '0' || *p > '9') return 0;
    while (*p >= '0' && *p <= '9') { n = n * 10 + (*p - '0'); p++; }
    if (strncmp(p, "]", 1) != 0) return 0;
    p++;
    while (*p == ' ' || *p == '\t' || *p == '\r') p++;
    if (*p) return 0;
    *off = n;
    return 1;
}

/* Is this line "    ADD rX, r6, rX"?  emit_va_ptr() is the only emitter of
 * that shape: it materialises frame + offset in a register. */
static int ra_adds_r6(const char *ln, int reg) {
    int i = 0, r = 0;
    while (ln[i] == ' ') i++;
    if (!(ln[i] == 'A' && ln[i+1] == 'D' && ln[i+2] == 'D' && ln[i+3] == ' ')) return 0;
    i += 4;
    if (ln[i] != 'r') return 0;
    for (i++; ln[i] >= '0' && ln[i] <= '9'; i++) r = r * 10 + (ln[i] - '0');
    if (r != reg) return 0;
    if (!(ln[i] == ',' && ln[i+1] == ' ' && ln[i+2] == 'r' && ln[i+3] == '6' &&
          ln[i+4] == ',' && ln[i+5] == ' ')) return 0;
    i += 6;
    if (ln[i] != 'r') return 0;
    r = 0;
    for (i++; ln[i] >= '0' && ln[i] <= '9'; i++) r = r * 10 + (ln[i] - '0');
    return r == reg;
}

/* Rewrite the frame offsets of one rebuilt line.  Only two shapes can carry an
 * offset that sits above the locals:
 *
 *     [r6, #N]                          a caller stack argument, or the va region
 *     MOVW rX, #N  +  ADD rX, r6, rX    emit_va_ptr(): frame + va offset
 *
 * `next` is the following line ("" at the end of the function) -- the MOVW is
 * rewritten only when that pair is really an address computation.  `dst` must
 * hold 4*len bytes: a line is at most 255 characters and each rewrite adds at
 * most two digits.  Returns the new length. */
static int ra_shift_line(const char *ln, int len, const char *next,
                         int base, int delta, char *dst) {
    int i = 0, o = 0;

    if (len > 12 && ln[4] == 'M' && ln[5] == 'O' && ln[6] == 'V' && ln[7] == 'W' &&
        ln[8] == ' ' && ln[9] == 'r') {
        int k = 10, reg = 0, n = 0;
        while (k < len && ln[k] >= '0' && ln[k] <= '9') { reg = reg * 10 + (ln[k] - '0'); k++; }
        if (k + 2 < len && ln[k] == ',' && ln[k+1] == ' ' && ln[k+2] == '#') {
            int st = k + 3;
            k = st;
            while (k < len && ln[k] >= '0' && ln[k] <= '9') { n = n * 10 + (ln[k] - '0'); k++; }
            if (k > st && k == len && n >= base && ra_adds_r6(next, reg)) {
                for (i = 0; i < st; i++) dst[o++] = ln[i];
                o = ra_num_out(dst, o, n + delta);
                dst[o] = 0;
                return o;
            }
        }
    }

    while (i < len) {
        if (ln[i] == '[' && i + 6 <= len && ln[i+1] == 'r' && ln[i+2] == '6' &&
            ln[i+3] == ',' && ln[i+4] == ' ' && ln[i+5] == '#') {
            int k = i + 6, n = 0;
            while (k < len && ln[k] >= '0' && ln[k] <= '9') { n = n * 10 + (ln[k] - '0'); k++; }
            if (k > i + 6 && k < len && ln[k] == ']' && n >= base) {
                int t;
                for (t = i; t < i + 6; t++) dst[o++] = ln[t];   /* "[r6, #" */
                o = ra_num_out(dst, o, n + delta);
                i = k;
                continue;
            }
        }
        dst[o++] = ln[i++];
    }
    dst[o] = 0;
    return o;
}

/* Rewrite b->buf[from..b->len) in place.  Called once per emitted function, at
 * the moment its text is complete, so "the last slice of the buffer" really is
 * that function and nothing else. */

#if ARKCC_FEATURE_OPT_CONSTCACHE
/* ------------------ function-level 32-bit constant cache (S3a) -----------
 * A 32-bit constant is materialised as "MOVW rD, #lo" + "MOVT rD, #hi": two
 * instructions every time it is needed.  When one function needs the same pair
 * c times it is cheaper to build it once into a callee-saved register and copy
 * it per use: 2 + c instructions instead of 2c.
 *
 * Building it at function *entry* rather than at the first textual occurrence
 * is what makes the rewrite dominance-safe.  A textual first occurrence can sit
 * inside a branch that the second occurrence never takes; the cache register
 * would then hold whatever the entry left in it.  From the entry there is no
 * such path: every use is dominated by the materialisation.
 *
 * The account is gain = c - 2 and cost = one wider PUSH + one wider POP (two
 * instructions), paid only by a function that had no saved register yet -- once
 * -fopt-regalloc or this cache has widened the list, adding another register is
 * free because a PUSH naming any high register is 32-bit whatever its length.
 * The selection below therefore requires the total gain to cover that two.
 *
 * Registers come from r8-r11 *after* -fopt-regalloc has picked its slots, so the
 * two never share one, and only regalloc widens PUSH/POP and shifts the frame
 * offsets: exactly one owner of that code, which is the condition written down
 * in docs/OPERAND_ALLOC.md section 4. */
#define CC_MAX_CONSTS 24
#define CC_MIN_COUNT  5     /* c occurrences must cover the pair and the PUSH/POP */

typedef struct {
    unsigned lo;
    unsigned hi;
    int count;
    int reg;      /* 0 = not cached, else the callee-saved register holding it */
    int poison;   /* value is relocatable or unparsable: never cache it */
} CcConst;

static CcConst cc_tab[CC_MAX_CONSTS];
static int cc_n;
static int cc_hregs;   /* bit 0..3 = r8..r11 appear in this function's own text */

static int cc_on(void) {
    return g_config.enable_opt_constcache ? 1 : 0;
}

/* "    MOVW rN, #<decimal>" / "    MOVT rN, #<decimal>": the emitter prints
 * decimals only, and anything else (a symbol, a hex form, a comment) makes the
 * line not match, which is the conservative answer.  The destination may be
 * any register: use sites write r0-r7 (the value stack's scratch registers),
 * while only the materialisation this pass inserts at the entry writes a
 * callee-saved register -- so the *filler* is what moves the value into rN,
 * not this matcher. */
static int cc_pair_half(const char *line, const char *mn, int *rd, unsigned *val) {
    const char *p;
    int d = 0, nd = 0;
    unsigned v = 0;
    if (!(line[0] == ' ' && line[1] == ' ' && line[2] == ' ' && line[3] == ' '))
        return 0;
    p = line + 4;
    if (strncmp(p, mn, 4) != 0) return 0;
    p += 4;
    if (*p != ' ' || p[1] != 'r') return 0;
    p += 2;
    while (*p >= '0' && *p <= '9' && nd < 2) {
        d = d * 10 + (*p - '0');
        p++;
        nd++;
    }
    if (!nd) return 0;
    if (*p != ',' || p[1] != ' ' || p[2] != '#') return 0;
    p += 3;
    if (*p < '0' || *p > '9') return 0;
    while (*p >= '0' && *p <= '9') {
        v = v * 10u + (unsigned)(*p - '0');
        p++;
    }
    while (*p == ' ' || *p == '\r') p++;
    if (*p) return 0;
    *rd = d;
    *val = v;
    return 1;
}

static int cc_find(unsigned lo, unsigned hi) {
    int i;
    for (i = 0; i < cc_n; i++)
        if (cc_tab[i].lo == lo && cc_tab[i].hi == hi) return i;
    return -1;
}

static void cc_note(unsigned lo, unsigned hi) {
    int i = cc_find(lo, hi);
    if (i < 0) {
        if (cc_n >= CC_MAX_CONSTS) return;
        i = cc_n++;
        cc_tab[i].lo = lo;
        cc_tab[i].hi = hi;
        cc_tab[i].count = 0;
        cc_tab[i].reg = 0;
        cc_tab[i].poison = 0;
    }
    if (!cc_tab[i].poison) cc_tab[i].count++;
}

/* A value the linker rewrites must never be copied: the two halves are patched
 * at link time, so "the number in the text" is not the number the instruction
 * will carry.  The whole (lo,hi) key is refused, because a literal constant
 * with the same halves elsewhere in the function is indistinguishable from it. */
static void cc_poison(unsigned lo, unsigned hi) {
    int i = cc_find(lo, hi);
    if (i < 0) {
        if (cc_n >= CC_MAX_CONSTS) return;
        i = cc_n++;
        cc_tab[i].lo = lo;
        cc_tab[i].hi = hi;
        cc_tab[i].count = 0;
        cc_tab[i].reg = 0;
    }
    cc_tab[i].poison = 1;
    cc_tab[i].reg = 0;
}

static void cc_begin(void) {
    cc_n = 0;
    cc_hregs = 0;
}

/* "... .arkdata" / "... .arkdatasym foo": the directive that marks the
 * MOVW/MOVT pair right after it as a relocatable address. */
static int cc_is_reloc_dir(const char *line) {
    while (*line == ' ' || *line == '\t') line++;
    if (line[0] != '.') return 0;
    if (strncmp(line, ".arkdata", 8) == 0) return 1;
    if (strncmp(line, ".arkdatasym", 11) == 0) return 1;
    return 0;
}

/* Which of r8-r11 the function's own text mentions.  A register that already
 * appears anywhere -- -fopt-regalloc's slots, an inline asm block, anything --
 * is not a safe home for a value that must survive to every use site, so it is
 * excluded from the candidate set rather than analysed.  Conservative by
 * construction: a false hit only costs one register. */
static int cc_line_hregs(const char *line) {
    const char *p = line;
    int mask = 0;
    while (*p) {
        if (p[0] == 'r' && p[1] >= '0' && p[1] <= '9' &&
            !(p > line && p[-1] >= 'a' && p[-1] <= 'z')) {
            const char *q = p + 1;
            int n = 0;
            while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
            if (n >= 8 && n <= 11) mask |= 1 << (n - 8);
            p = q;
            continue;
        }
        p++;
    }
    return mask;
}
#define cc_any() (cc_on() && cc_n > 0)
#endif /* ARKCC_FEATURE_OPT_CONSTCACHE */
#if !ARKCC_FEATURE_OPT_CONSTCACHE
/* Built out (the STM32_MIN profile, or a build without -fopt-regalloc): the
 * pass is a no-op and every call site below still compiles. */
#define cc_on() 0
#define cc_any() 0
#endif

static void ark_regalloc_function(AsmBuffer *b, int from, IrFunc *f, int local_eff) {
    static RaSlot slots[RA_MAX_SLOTS];
    int nslots = 0;
    int pos, i, k;
    /* First frame byte above this frame's locals: the saved-register block
     * starts there, and the caller's argument image right after it.  Every
     * local lives below it, so an offset >= base is never a local. */
    int base = local_eff + 16;
    int extra;
    int made[RA_MAX_REGS];
    int nregs = 0;
    int have_prologue = 0;
    int done_push = 0;
    AsmBuffer out;
    char line[256];
    char nline[256];
    char pushline[64];               /* the frame save this pass will widen */

    pushline[0] = 0;
    ra_any_n = 0;
    if (!ra_enabled() && !cc_on()) return;

#if ARKCC_FEATURE_OPT_CONSTCACHE
    /* Constant-cache survey.  Runs before the slot walk and never consumes a
     * line from it (a MOVW/MOVT pair spans two lines but neither is a frame
     * access).  Both halves of the account live here: how often each 32-bit
     * constant is rebuilt, and which high registers the text already uses. */
    if (cc_on()) {
        int cpos;
        int prev_dir = 0;
        char pline[256];
        cc_begin();
        for (cpos = from; cpos < b->len; ) {
            int clen = 0, k2;
            while (cpos + clen < b->len && b->buf[cpos + clen] != '\n') clen++;
            if (clen >= (int)sizeof(line)) {
                cc_hregs |= 0x0F;   /* text we cannot parse: assume it uses them */
                prev_dir = 0;
                cpos += clen + 1;
                continue;
            }
            for (k2 = 0; k2 < clen; k2++) line[k2] = b->buf[cpos + k2];
            line[clen] = 0;
            cc_hregs |= cc_line_hregs(line);
            {
                int d1 = -1, d2 = -1;
                unsigned v1 = 0, v2 = 0;
                if (cc_pair_half(line, "MOVW", &d1, &v1)) {
                    int l2 = 0, p2 = cpos + clen + 1;
                    while (p2 + l2 < b->len && b->buf[p2 + l2] != '\n') l2++;
                    if (l2 > 0 && l2 < (int)sizeof(pline)) {
                        for (k2 = 0; k2 < l2; k2++) pline[k2] = b->buf[p2 + k2];
                        pline[l2] = 0;
                        if (cc_pair_half(pline, "MOVT", &d2, &v2) && d2 == d1) {
                            /* After .arkdata/.arkdatasym the pair is an address
                             * the linker patches, not a number. */
                            if (prev_dir) cc_poison(v1, v2);
                            else cc_note(v1, v2);
                            prev_dir = 0;
                            cpos = p2 + l2 + 1;
                            continue;
                        }
                    }
                }
            }
            prev_dir = cc_is_reloc_dir(line);
            cpos += clen + 1;
        }
    }
#endif

    /* Pass 1: every mention of every frame slot. */
    for (pos = from; pos < b->len; ) {
        int len = 0, off = 0, is_ldr = 0, wide = 0, kind;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (len >= (int)sizeof(line)) { pos += len + 1; continue; }
        for (i = 0; i < len; i++) line[i] = b->buf[pos + i];
        line[len] = 0;
        if (ra_is_prologue_push(line)) {
            int q;
            have_prologue = 1;
            for (q = 0; q < len && q < (int)sizeof(pushline) - 1; q++)
                pushline[q] = line[q];
            pushline[q] = 0;
        }
        {
            int aoff = 0;
            if (ra_ldr_any(line, &aoff)) ra_any_note(aoff);
        }
        kind = ra_classify(line, &off, &is_ldr, &wide);
        if (kind >= 0) {
            int s = ra_slot(slots, &nslots, off);
            if (s < 0) { pos += len + 1; continue; }
            if (kind == 2 || off >= base) {
                /* Outside this frame's locals -- a caller stack argument, or an
                 * address that escaped -- so it stays in memory.  Caching an
                 * incoming argument would also change what the function sees
                 * when the slot is written through a pointer. */
                slots[s].taint = 1;
            } else {
                slots[s].uses++;
                if (wide) slots[s].saves += 2;
            }
        }
        pos += len + 1;
    }
    /* Volatile locals go through the same two instruction shapes as ordinary
     * ones, so the text cannot tell them apart -- but keeping one in a register
     * would swallow exactly the accesses the keyword exists to preserve.  The
     * IR knows, so ask it rather than guessing from the listing. */
    if (f) {
        int k2;
        for (k2 = 0; k2 < f->code_count; k2++) {
            IrInst *I2 = &f->code[k2];
            int s;
            if (!(I2->aux & IR_AUX_VOLATILE)) continue;
            if (I2->op != IR_PUSH_VAR && I2->op != IR_STORE && I2->op != IR_PUSH_ADDR)
                continue;
            s = ra_slot(slots, &nslots, (int)I2->val);
            if (s >= 0) slots[s].taint = 1;
        }
    }

    if (!have_prologue) return;   /* __naked, or a prologue shape we do not own */
    if (nslots == 0 && !cc_any()) return;

    /* Pick the clean slots that pay for themselves.  Default: rank by bytes
     * saved and stop once the 4-byte PUSH/POP widening is covered, so a
     * function never grows.  -fopt-regalloc-near: rank by access count and take
     * near slots too.  Ties go to the lower offset, so the same source always
     * gets the same assignment. */
    {
        int budget = 4;            /* one wider PUSH + one wider POP */
        int near_mode = g_config.enable_opt_regalloc_near ? 1 : 0;
        for (k = 0; k < RA_MAX_REGS; k++) {
            int best = -1;
            for (i = 0; i < nslots; i++) {
                if (slots[i].reg || slots[i].taint) continue;
                if (near_mode) {
                    if (slots[i].uses < RA_MIN_USES) continue;
                } else {
                    if (slots[i].saves <= 0) continue;
                }
                if (best < 0) { best = i; continue; }
                if (near_mode) {
                    if (slots[i].uses > slots[best].uses ||
                        (slots[i].uses == slots[best].uses && slots[i].off < slots[best].off))
                        best = i;
                } else {
                    if (slots[i].saves > slots[best].saves ||
                        (slots[i].saves == slots[best].saves && slots[i].off < slots[best].off))
                        best = i;
                }
            }
            if (best < 0) break;
            if (!near_mode) {
                if (budget - slots[best].saves < 0 && nregs > 0) break;
                budget -= slots[best].saves;
            }
            slots[best].reg = 8 + k;
            made[nregs++] = 8 + k;
        }
        if (!near_mode && nregs > 0 && budget > 0) {
            /* The savings did not cover the wider PUSH/POP after all: hand the
             * registers back rather than grow the function. */
            int j, s2;
            for (j = 0; j < nregs; j++)
                for (s2 = 0; s2 < nslots; s2++)
                    if (slots[s2].reg == made[j]) slots[s2].reg = 0;
            nregs = 0;
        }
    }
#if ARKCC_FEATURE_OPT_CONSTCACHE
    /* Second consumer of the same saved-register block.  A constant built c
     * times costs 2c instructions; built once at the entry and copied per use
     * it costs 2 + c, so the account is (c - 1) per constant.  Binding the
     * block at all costs one wider PUSH and one wider POP -- two instructions
     * -- and only a function that had no saved register yet pays them, because
     * a PUSH naming any high register is 32-bit whatever the length of its
     * list.  Registers are taken after -fopt-regalloc has picked its slots,
     * and only from what the function's own text does not mention, so the two
     * never share one and this pass never has to widen or shift anything. */
    if (cc_on() && cc_n > 0) {
        int total = 0, selsum = 0, guard, j;
        int pushpop = (nregs == 0) ? 2 : 0;
        int slot_saving = 0;
        /* One pool, two consumers.  -fopt-vreg runs after this pass and puts
         * frame slots into whatever high registers are left, eliding about one
         * instruction per usable load; a cached constant is worth (count - 1).
         * The pool is four registers, so the split is decided here, once, from
         * the two accounts: constants are taken in count order and slots will
         * be taken in use order, so the handover is at the first slot that
         * beats the next constant, and every register past that point is left
         * free on purpose.  `uses` is every mention of the slot, which is an
         * upper bound on the loads -fopt-vreg can actually elide -- erring
         * towards the slot, because a slot with fewer uses than a constant is
         * never chosen below.  With -fopt-vreg off (or built out) the pool
         * stays with the constant cache exactly as before. */
#if ARKCC_FEATURE_OPT_VREG
        if (g_config.enable_opt_vreg) {
            slot_saving = ra_any_max() - 1;
        }
#endif
        for (guard = 0; guard < CC_MAX_CONSTS && nregs < RA_MAX_REGS; guard++) {
            int best = -1, r;
            for (i = 0; i < cc_n; i++) {
                if (cc_tab[i].reg || cc_tab[i].poison) continue;
                if (cc_tab[i].count < CC_MIN_COUNT) continue;
                if (best < 0 || cc_tab[i].count > cc_tab[best].count ||
                    (cc_tab[i].count == cc_tab[best].count &&
                     cc_tab[i].lo < cc_tab[best].lo))
                    best = i;
            }
            if (best < 0) break;
#if ARKCC_FEATURE_OPT_VREG
            /* Hand the rest of the pool to -fopt-vreg: measured on
             * HAL_DMAEx_MultiBufferStart_IT, slot 0 is read 276 times while
             * the hottest cachable constant is built 7 times.  Twice the
             * constant's saving, because `any` also counts loads the pass will
             * decline to elide (a region that ends before the use, an
             * IT-guarded access): the estimate has to stay an upper bound on
             * *that* pass's account, and a register is only handed over when
             * the margin survives the discount. */
            if (g_config.enable_opt_vreg && slot_saving > 2 * (cc_tab[best].count - 1))
                break;
#endif
            for (r = 8; r <= 11; r++) {
                int used = 0;
                for (j = 0; j < nregs; j++)
                    if (made[j] == r) used = 1;
                if (!used && !(cc_hregs & (1 << (r - 8)))) break;
            }
            if (r > 11) break;
            cc_tab[best].reg = r;
            made[nregs++] = r;
            total += cc_tab[best].count - 1;
            selsum++;
        }
        if (selsum == 0 || total - pushpop <= 0) {
            /* The selection did not pay for itself: hand the registers back. */
            for (i = 0; i < cc_n; i++) cc_tab[i].reg = 0;
            nregs -= selsum;
        }
    }
#endif
    /* The save list this pass widens is the one in the text; a candidate it
     * already names would make the assembler deduplicate the list silently,
     * leaving the real block shorter than `extra` below claims and every
     * offset shifted too far.  With the fixed prologue shape accepted above
     * this cannot fire today -- it is cheap insurance for the day the shape
     * grows. */
    if (have_prologue) {
        int j, n2 = 0;
        for (j = 0; j < nregs; j++)
            if (!ra_names_reg(pushline, made[j])) made[n2++] = made[j];
        nregs = n2;
    }
    if (nregs == 0) return;

    /* An odd number of saved words would leave sp at 4 mod 8 once the prologue
     * has run: AAPCS wants 8 at every BL, and the va region the prologue builds
     * is 8-aligned only because the saved block is.  Take one spare register
     * instead of giving up a useful one -- a PUSH that names any high register
     * is 32-bit whatever the length of its list, so the spare costs nothing. */
    if (nregs & 1) {
        int r;
        for (r = 8; r <= 11; r++) {
            int j, used = 0;
            for (j = 0; j < nregs; j++)
                if (made[j] == r) used = 1;
            if (!used) { made[nregs++] = r; break; }
        }
    }
    /* Bytes the widened PUSH adds above the frame pointer, and therefore the
     * amount every offset that names the saved block or the caller's argument
     * image has to grow (stage 3 below). */
    extra = 4 * nregs;

    /* Pass 2: rebuild the text of this function. */
    asmbuf_init(&out);
    for (pos = from; pos < b->len; ) {
        int len = 0, off = 0, is_ldr = 0, wide = 0, kind;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (len >= (int)sizeof(line)) {
            for (i = 0; i < len; i++) asmbuf_putc(&out, b->buf[pos + i]);
            asmbuf_putc(&out, '\n');
            pos += len + 1;
            continue;
        }
        for (i = 0; i < len; i++) line[i] = b->buf[pos + i];
        line[len] = 0;

#if ARKCC_FEATURE_OPT_CONSTCACHE
        /* A pair whose value sits in a cache register becomes a copy; when the
         * pair already wrote that very register both lines simply go away. */
        if (cc_on()) {
            int d1 = -1, d2 = -1;
            unsigned v1 = 0, v2 = 0;
            if (cc_pair_half(line, "MOVW", &d1, &v1)) {
                int l2 = 0, p2 = pos + len + 1;
                char pline[256];
                while (p2 + l2 < b->len && b->buf[p2 + l2] != '\n') l2++;
                if (l2 > 0 && l2 < (int)sizeof(pline)) {
                    for (i = 0; i < l2; i++) pline[i] = b->buf[p2 + i];
                    pline[l2] = 0;
                    if (cc_pair_half(pline, "MOVT", &d2, &v2) && d2 == d1) {
                        int ci = cc_find(v1, v2);
                        if (ci >= 0 && cc_tab[ci].reg) {
                            if (d1 != cc_tab[ci].reg) {
                                asmbuf_puts(&out, "    MOV r");
                                asmbuf_int(&out, d1);
                                asmbuf_puts(&out, ", r");
                                asmbuf_int(&out, cc_tab[ci].reg);
                                asmbuf_putc(&out, '\n');
                            }
                            pos = p2 + l2 + 1;
                            continue;
                        }
                    }
                }
            }
        }
#endif
        kind = -1;
        if (line[0] == ' ' && line[1] == ' ' && line[2] == ' ' && line[3] == ' ')
            kind = ra_classify(line, &off, &is_ldr, &wide);
        if (kind == 0 || kind == 1) {
            int s = ra_slot(slots, &nslots, off);
            int r = (s >= 0) ? slots[s].reg : 0;
            if (r) {
                asmbuf_puts(&out, is_ldr ? "    MOV r0, r" : "    MOV r");
                asmbuf_int(&out, r);
                asmbuf_puts(&out, is_ldr ? "\n" : ", r0\n");
                pos += len + 1;
                continue;
            }
        }
        if (!done_push && ra_is_prologue_push(line)) {
            /* Same list, plus the registers this function really holds.  Only
             * the first such line is the frame save; a spill later in the body
             * is a different list and is left alone. */
            int cut = ra_last_elem_at(line);
            if (cut < 0) cut = (int)strlen(line);
            done_push = 1;
            for (i = 0; i < cut; i++) asmbuf_putc(&out, line[i]);
            for (k = 0; k < nregs; k++) {
                asmbuf_puts(&out, ", r");
                asmbuf_int(&out, made[k]);
            }
            for (i = cut; i < (int)strlen(line); i++) asmbuf_putc(&out, line[i]);
            asmbuf_putc(&out, '\n');
#if ARKCC_FEATURE_OPT_CONSTCACHE
            /* Every cached constant is built once here, above every use site.
             * Building it at the first textual occurrence instead would not be
             * dominance-safe: that occurrence can sit inside a branch. */
            for (k = 0; k < cc_n; k++) {
                if (!cc_tab[k].reg) continue;
                asmbuf_puts(&out, "    MOVW r");
                asmbuf_int(&out, cc_tab[k].reg);
                asmbuf_puts(&out, ", #");
                asmbuf_int(&out, (int)cc_tab[k].lo);
                asmbuf_putc(&out, '\n');
                asmbuf_puts(&out, "    MOVT r");
                asmbuf_int(&out, cc_tab[k].reg);
                asmbuf_puts(&out, ", #");
                asmbuf_int(&out, (int)cc_tab[k].hi);
                asmbuf_putc(&out, '\n');
            }
#endif
            pos += len + 1;
            continue;
        }
        if (ra_is_epilogue_pop(line)) {
            /* Every return path restores the same block, so all of them are
             * widened.  A variadic function returns through POP {r5,r6,r7,lr}
             * and then ADD sp,#16 / BX lr (it has to drop the r0-r3 mirror
             * first), so rewriting that line to POP {..,pc} would jump out 16
             * bytes early with the pad still on the stack: the tail element is
             * kept verbatim rather than chosen here. */
            int cut = ra_last_elem_at(line);
            if (cut < 0) cut = (int)strlen(line);
            for (i = 0; i < cut; i++) asmbuf_putc(&out, line[i]);
            for (k = 0; k < nregs; k++) {
                asmbuf_puts(&out, ", r");
                asmbuf_int(&out, made[k]);
            }
            for (i = cut; i < (int)strlen(line); i++) asmbuf_putc(&out, line[i]);
            asmbuf_putc(&out, '\n');
            pos += len + 1;
            continue;
        }
        for (i = 0; i < len; i++) asmbuf_putc(&out, b->buf[pos + i]);
        asmbuf_putc(&out, '\n');
        pos += len + 1;
    }

    /* Stage 3: the saved block grew by `extra` bytes, so every frame offset at
     * or above `base` is that much too small -- the caller's stack arguments
     * and the va region <stdarg.h> walks.  Left alone, a variadic function or
     * one with more than four parameters reads the wrong words; both run in the
     * varargs gate with the pass on.  Locals are all below `base`, so no local
     * slot can be touched. */
    if (extra > 0) {
        AsmBuffer shf;
        int opos;
        asmbuf_init(&shf);
        for (opos = 0; opos < out.len; ) {
            int len = 0, nlen = 0, olen = 0;
            char shl[1024];
            const char *np;
            while (opos + len < out.len && out.buf[opos + len] != '\n') len++;
            if (len >= (int)sizeof(line)) {
                /* Unreachable: pass 2 slices by the same limit and never emits
                 * a longer line.  Copy verbatim rather than guess. */
                for (i = 0; i < len; i++) asmbuf_putc(&shf, out.buf[opos + i]);
                asmbuf_putc(&shf, '\n');
                opos += len + 1;
                continue;
            }
            for (i = 0; i < len; i++) line[i] = out.buf[opos + i];
            line[len] = 0;
            np = out.buf + opos + len;
            if (*np == '\n') np++;
            while (np[nlen] && np[nlen] != '\n' && nlen < (int)sizeof(nline) - 1) {
                nline[nlen] = np[nlen];
                nlen++;
            }
            nline[nlen] = 0;
            olen = ra_shift_line(line, len, nline, base, extra, shl);
            for (i = 0; i < olen; i++) asmbuf_putc(&shf, shl[i]);
            asmbuf_putc(&shf, '\n');
            opos += len + 1;
        }
        asmbuf_reserve(&out, shf.len + 1);
        for (i = 0; i < shf.len; i++) out.buf[i] = shf.buf[i];
        out.buf[shf.len] = 0;
        out.len = shf.len;
    }

    /* Splice back.  In the default mode the selected slots pay for the wider
     * PUSH/POP, so the result is never longer; the guard is here so a future
     * change cannot silently overflow the buffer.  The reserve is not optional
     * now: stage 3 can lengthen a line by a digit or two. */
    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 <= b->cap) {
        for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
        b->buf[from + out.len] = 0;
        b->len = from + out.len;
    }
}
#if ARKCC_FEATURE_OPT_VREG
/* ------------------ slot promotion to callee-saved registers (-fopt-vreg) --
 * docs/VREG.md section 10.5 pre-registers this as S6a's text-layer landing
 * form.  A slot is not "accessed through a register" (which would be a MOV, no
 * shorter than the LDR it replaces) but *promoted* -- its loads and stores
 * disappear from memory.  A store becomes "MOV rC, rS" (the same one
 * instruction the STR was); the load that feeds the very next instruction is
 * deleted outright and that instruction reads rC instead (rename elision),
 * which is the only form that removes an instruction.  A load whose consumer
 * cannot be renamed falls back to "MOV rD, rC" (same count).  So the pass never
 * adds an instruction: the whole win is the number of elided loads.
 *
 * The slot traffic is not always through r0: -fopt-vstack rewrites the value
 * stack into r5/r7, so a local is loaded into whichever scratch register the
 * previous pass chose ("LDR r5, [r6, #16]" feeding "MOV r0, r5").  The pass
 * therefore works on the register the load actually names and renames *that*
 * one in its consumer, for any of r0..r7.  r8-r11 are never destinations here,
 * so the cache register can never collide with a rewritten line.
 *
 * Safety is the same taint proof -fopt-regalloc and -fopt-slotreg rely on: a
 * slot is touched only when every mention of it in the whole function is
 * exactly "LDR rD, [r6,#o]" or "STR rS, [r6,#o]" below the local frame, it is
 * not volatile, no frame address at or below it escapes, and no mention sits
 * under an IT (a conditional access cannot become an unconditional copy).  One
 * mention in any other shape leaves the slot in memory.
 *
 * r8-r11 are the registers: the backend never names them and AAPCS makes them
 * callee-saved, so they survive calls.  -fopt-regalloc (and the constant cache
 * inside it) runs first and draws from the same four, so this pass reads the
 * register list, the frame base and the leftover registers off the text it is
 * given instead of assuming a four-word save: the prologue is widened, the
 * epilogue widened to match, and every offset at or above the new base is
 * shifted, exactly as -fopt-regalloc does. */
#define VG_MAX_SLOTS 128
#define VG_MAX_LINES 8192
#define VG_MAX_REGS  4

typedef struct {
    int off;
    int reads;
    int stores;
    int elid;      /* loads whose consumer can be renamed away          */
    int taint;
    int reg;       /* 8..11 when promoted, 0 otherwise                  */
} VgSlot;

static VgSlot         vg_slots[VG_MAX_SLOTS];
static unsigned short vg_ll[VG_MAX_LINES];
static short          vg_lo[VG_MAX_LINES];
static unsigned char  vg_lk[VG_MAX_LINES];   /* 0 other, 1 LDR, 2 STR, 3 barrier, 4 frame setup,
                                              * 5 call (a barrier the region scan may cross) */
static unsigned char  vg_it[VG_MAX_LINES];
static unsigned char  vg_dr[VG_MAX_LINES];   /* destination/source register of an LDR/STR */
static int            vg_ptr[VG_MAX_LINES];
static int            vg_cons[VG_MAX_LINES]; /* consumer line of an elidable LDR, else -1 */
static unsigned char  vg_act[VG_MAX_LINES];  /* 0 copy, 1 drop, 2 MOV rD<-rC, 3 MOV rC<-rS, 4 rename */
static signed char    vg_ren[VG_MAX_LINES];  /* register for act 2/3             */
static unsigned char  vg_rf[VG_MAX_LINES];   /* register to rename in act 4      */
/* S6b: one line can carry several renames (two loads live across it), so the
 * rename is kept as a small per-line map instead of a single pair. */
#define VG_MAX_MAP 4
static signed char    vg_mf[VG_MAX_LINES][VG_MAX_MAP];
static signed char    vg_mt[VG_MAX_LINES][VG_MAX_MAP];
static unsigned char  vg_mn[VG_MAX_LINES];
static int            vg_esc_lo;             /* lowest escaped frame offset      */

static int vg_isalpha(char c) {
    return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}
static char vg_upper(char c) { return (c >= 'a' && c <= 'z') ? (char)(c - 32) : c; }

/* "r0".."r11" into tok (>=5 bytes). */
static void vg_tok(int reg, char *tok) {
    tok[0] = 'r';
    if (reg >= 10) { tok[1] = (char)('0' + reg / 10); tok[2] = (char)('0' + reg % 10); tok[3] = 0; }
    else { tok[1] = (char)('0' + reg); tok[2] = 0; }
}

/* Uppercased mnemonic of an instruction line into mn (>=8 bytes); 0 when the
 * line is blank, a comment, a directive or a label. */
static int vg_mnem(const char *ln, char *mn) {
    const char *s = ln;
    int n = 0;
    while (*s == ' ' || *s == '\t') s++;
    if (!*s || *s == '.' || *s == '$' || *s == '@' || *s == ';') return 0;
    while (vg_isalpha(*s)) { if (n < 7) mn[n++] = vg_upper(*s); s++; }
    mn[n] = 0;
    if (n == 0) return 0;
    /* A label looks like "name:" with no space before the colon. */
    { const char *t = s; while (*t == ' ' || *t == '\t') t++; if (t == s && *t == ':') return 0; }
    return n;
}

/* A label, or any instruction with more than one exit: after it a cached
 * register's value is only known on this path, so it ends the rewrite region. */
static int vg_barrier(const char *ln) {
    char mn[8];
    static const char *const br_mn[] = {
        "B", "BEQ", "BNE", "BCC", "BCS", "BHS", "BLO", "BMI", "BPL", "BVS",
        "BVC", "BHI", "BLS", "BGE", "BLT", "BGT", "BLE", "BAL", "BX", "BL",
        "BLX", "CBZ", "CBNZ", "IT", "ITT", "ITE", "ITTT", "ITTE", "ITET",
        "ITEE", "ITTTT", "POP", "PUSH", "LDM", "LDMIA", "LDMFD", "STM",
        "STMIA", "STMDB", "STMFD", 0
    };
    const char *s = ln;
    int i, sp = 0;
    while (*s == ' ' || *s == '\t') s++;
    if (!*s) return 0;
    if (*s == '.' || *s == '$') {
        const char *t = s;
        while (*t) { if (*t == ' ' || *t == '\t') sp = 1; t++; }
        if (!sp && t > s && t[-1] == ':') return 1;   /* .Lxx: or $d: */
        if (*s == '$') return 1;
        return 0;
    }
    if (!vg_mnem(ln, mn)) {
        const char *t = s;
        while (*t) { if (*t == ' ' || *t == '\t') sp = 1; t++; }
        if (!sp && t > s && t[-1] == ':') return 1;   /* bare label */
        return 0;
    }
    for (i = 0; br_mn[i]; i++)
        if (strcmp(mn, br_mn[i]) == 0) return 1;
    return 0;
}

/* Classify one line against the frame pointer.
 *   0  exactly "LDR rD, [r6,#n]"      (*off, *dreg = D)
 *   1  exactly "STR rS, [r6,#n]"      (*off, *dreg = S)
 *   2  "r6, #n" in another shape      (*off when it parses, else -1)
 *   3  no "r6, " mention at all
 *   4  "MOV r6, sp" -- the frame pointer being set up
 * Only single-digit destinations are modelled: the emitter's frame traffic
 * uses r0/r5/r7 and the cache registers are r8-r11, so anything else is a
 * shape this pass does not own. */
static int vg_scan(const char *ln, int *off, int *dreg) {
    const char *s = ln;
    const char *p, *q;
    int n = 0, kind;
    *off = -1;
    *dreg = -1;
    while (*s == ' ' || *s == '\t') s++;
    if (s[0]=='M'&&s[1]=='O'&&s[2]=='V'&&s[3]==' '&&s[4]=='r'&&s[5]=='6'&&s[6]==','&&s[7]==' ')
        return 4;
    for (kind = 0; kind < 2; kind++) {
        if (strncmp(s, kind == 0 ? "LDR r" : "STR r", 5) != 0) continue;
        q = s + 4;
        if (q[1] < '0' || q[1] > '7') continue;
        if (q[2] != ',' || q[3] != ' ' || q[4] != '[') continue;
        if (!(q[5] == 'r' && q[6] == '6' && q[7] == ',' && q[8] == ' ' && q[9] == '#'))
            continue;
        p = q + 10;
        if (*p < '0' || *p > '9') continue;
        n = 0;
        while (*p >= '0' && *p <= '9') { n = n * 10 + (*p - '0'); p++; }
        if (*p != ']') continue;
        p++;
        while (*p == ' ' || *p == '\t' || *p == '\r') p++;
        if (*p) continue;
        *off = n;
        *dreg = (kind == 0) ? (q[1] - '0') : (q[1] - '0');
        return kind;
    }
    p = ln;
    while (p[0] && !(p[0]=='r'&&p[1]=='6'&&p[2]==','&&p[3]==' ')) p++;
    if (!p[0]) return 3;
    q = p + 4;
    if (*q == '#') {
        q++;
        if (*q >= '0' && *q <= '9') {
            while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
            *off = n;
        }
    }
    return 2;
}

/* Does this instruction write reg as its destination? */
static int vg_writes_reg(const char *ln, int reg) {
    const char *s = ln;
    char mn[8], tok[5];
    int i, n;
    static const char *const nodst[] = {
        "STR", "STRB", "STRH", "CMP", "CMN", "TST", "TEQ", "PUSH", "POP",
        "NOP", "DMB", "DSB", "ISB", "IT", "BX", "BL", "BLX", "CBZ", "CBNZ",
        "LDM", "LDMIA", "LDMFD", "STM", "STMIA", "STMDB", "STMFD", "B",
        "BEQ", "BNE", "BCC", "BCS", "BHS", "BLO", "BMI", "BPL", "BVS",
        "BVC", "BHI", "BLS", "BGE", "BLT", "BGT", "BLE", "BAL", 0
    };
    if (!vg_mnem(ln, mn)) return 0;
    for (i = 0; nodst[i]; i++)
        if (strcmp(mn, nodst[i]) == 0) return 0;
    while (*s == ' ' || *s == '\t') s++;
    while (vg_isalpha(*s)) s++;
    while (*s == ' ' || *s == '\t') s++;
    vg_tok(reg, tok);
    n = (int)strlen(tok);
    if (strncmp(s, tok, n) == 0 &&
        (s[n] == ',' || s[n] == ' ' || s[n] == '\0' || s[n] == '\r'))
        return 1;
    return 0;
}

/* Does reg appear as a whole token? */
static int vg_mentions_reg(const char *ln, int reg) {
    char tok[5];
    const char *p = ln;
    int n;
    vg_tok(reg, tok);
    n = (int)strlen(tok);
    while ((p = strstr(p, tok)) != 0) {
        char a = (p == ln) ? ' ' : p[-1];
        char b = p[n];
        if (!vg_isalpha(a) && !(a >= '0' && a <= '9') &&
            !vg_isalpha(b) && !(b >= '0' && b <= '9'))
            return 1;
        p += n;
    }
    return 0;
}

/* Does the instruction actually *read* reg?  vg_mentions_reg cannot tell a
 * destination from a source ("LDR r0, [r5]" writes r0 and reads only r5), and
 * the difference matters here: a write-only line ends a rename region while a
 * read-modify-write has to be renamed and kept.  Operands after the first are
 * always read; a two-operand data-processing form also reads its destination
 * (Thumb "ADD r0, r1" is "r0 = r0 + r1").  Erring towards "reads" is the safe
 * direction: the line is then renamed, so the cache register takes the same
 * value the low register would have. */
static int vg_reads_reg(const char *ln, int reg) {
    char mn[8];
    const char *s = ln, *p;
    int depth = 0, nops = 1, i;
    static const char *const twoop[] = {
        "ADD", "SUB", "AND", "ORR", "EOR", "ADC", "SBC", "RSB", "RSC",
        "MUL", "MLA", "BIC", "ORN", "LSL", "LSR", "ASR", "ROR", "RRX",
        "MVN", "NEG", 0
    };
    if (!vg_mnem(ln, mn)) return 0;
    while (*s == ' ' || *s == '\t') s++;
    while (vg_isalpha(*s)) s++;
    while (*s == ' ' || *s == '\t') s++;
    if (!*s) return 0;
    for (p = s; *p; p++) {
        if (*p == '[' || *p == '{') depth++;
        else if (*p == ']' || *p == '}') depth--;
        else if (*p == ',' && depth == 0) nops++;
    }
    depth = 0;
    for (p = s; *p; p++) {
        if (*p == '[' || *p == '{') depth++;
        else if (*p == ']' || *p == '}') depth--;
        else if (*p == ',' && depth == 0) break;
    }
    if (*p) {
        char tail[512];
        int k = 0;
        p++;
        while (*p && k < (int)sizeof(tail) - 1) tail[k++] = *p++;
        tail[k] = 0;
        if (vg_mentions_reg(tail, reg)) return 1;
    }
    if (nops == 2)
        for (i = 0; twoop[i]; i++)
            if (strcmp(mn, twoop[i]) == 0) return 1;
    return 0;
}

/* Bit 0..3 set for r8..r11 named anywhere in the line.  A register named in
 * the text may already be live (regalloc's slots and constant cache do not
 * always keep theirs in the list), so it is not available.
 *
 * The token boundary is part of the test: `Lr8_keep` or `r10_table` is a
 * symbol, not a register, so the 'r' must not follow an identifier character
 * and the last digit must not be followed by one.  -fopt-constcache asks the
 * same question in cc_line_hregs and scans exactly this way.
 *
 * 0.9.1-wip fix: the first version compared the character *after* the 'r'
 * against "not a digit", which is false for every register there is, so the
 * mask was always empty.  -fopt-vreg then believed r8..r11 were free and
 * appended registers the widened PUSH already named -- `PUSH {r5, r6, r7, r8,
 * r9, r8, r9, lr}` -- which the assembler silently deduplicates and which
 * therefore also threw off this pass's own word count. */
static int vg_hi_mask(const char *line) {
    const char *p = line;
    unsigned m = 0;
    while (*p) {
        if (p[0] == 'r' && p[1] >= '0' && p[1] <= '9' &&
            !(p > line && (((p[-1] >= 'a' && p[-1] <= 'z') ||
                            (p[-1] >= 'A' && p[-1] <= 'Z')) ||
                           (p[-1] >= '0' && p[-1] <= '9')))) {
            const char *q = p + 1;
            int n = 0;
            while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
            if (!(((q[0] >= 'a' && q[0] <= 'z') || (q[0] >= 'A' && q[0] <= 'Z')) ||
                  (q[0] >= '0' && q[0] <= '9')))
                if (n >= 8 && n <= 11) m |= 1u << (n - 8);
            p = q;
            continue;
        }
        p++;
    }
    return (int)m;
}

/* Replace every whole token "from" with "to".  Returns 1 if the line changed. */
static int vg_rename_reg(const char *in, int from, int to, char *dst) {
    char ftok[5], ttok[5];
    const char *p = in;
    int o = 0, changed = 0, n;
    vg_tok(from, ftok);
    vg_tok(to, ttok);
    n = (int)strlen(ftok);
    while (*p) {
        if (strncmp(p, ftok, n) == 0) {
            char a = (p == in) ? ' ' : p[-1];
            char b = p[n];
            if (!vg_isalpha(a) && !(a >= '0' && a <= '9') &&
                !vg_isalpha(b) && !(b >= '0' && b <= '9')) {
                int k;
                for (k = 0; ttok[k]; k++) dst[o++] = ttok[k];
                p += n;
                changed = 1;
                continue;
            }
        }
        dst[o++] = *p++;
    }
    dst[o] = 0;
    return changed;
}

static int vg_slot(int *n, int off) {
    int i;
    for (i = 0; i < *n; i++)
        if (vg_slots[i].off == off) return i;
    if (*n >= VG_MAX_SLOTS) return -1;
    vg_slots[*n].off = off;
    vg_slots[*n].reads = 0;
    vg_slots[*n].stores = 0;
    vg_slots[*n].elid = 0;
    vg_slots[*n].taint = (off >= vg_esc_lo);   /* an escaped address can reach it */
    vg_slots[*n].reg = 0;
    return (*n)++;
}

static int vg_is_ins_at(AsmBuffer *b, int idx) {
    char t[256], mn[8];
    int len = vg_ll[idx], k;
    if (len >= (int)sizeof(t) - 1) return 0;
    for (k = 0; k < len; k++) t[k] = b->buf[vg_ptr[idx] + k];
    t[len] = 0;
    return vg_mnem(t, mn) != 0;
}

/* Count the registers of a flattened PUSH/POP list. */
static int vg_list_regs(const char *line) {
    const char *p = strchr(line, '{');
    int n = 0;
    if (!p) return 0;
    p++;
    while (*p && *p != '}') {
        if (p[0] == 'r' && p[1] >= '0' && p[1] <= '9') {
            n++;
            p += 2;
            while (*p >= '0' && *p <= '9') p++;
        } else p++;
    }
    return n;
}

static int vg_list_has(const char *line, int reg) {
    const char *p = strchr(line, '{');
    if (!p) return 0;
    p++;
    while (*p && *p != '}') {
        if (p[0] == 'r' && p[1] >= '0' && p[1] <= '9') {
            int v = p[1] - '0';
            const char *q = p + 2;
            if (*q >= '0' && *q <= '9') { v = v * 10 + (*q - '0'); q++; }
            if (v == reg) return 1;
            p = q;
        } else p++;
    }
    return 0;
}

/* Flatten a register-list line (no spaces, no CR) into flat; 0 if too long. */
static int vg_flatten(const char *line, char *flat, int cap) {
    int i = 0, j = 0;
    while (line[i] && j < cap - 1) {
        if (line[i] != ' ' && line[i] != '\t' && line[i] != '\r') flat[j++] = line[i];
        i++;
    }
    flat[j] = 0;
    return i < cap;
}

/* The frame save of a function this pass may widen.  -fopt-regalloc runs
 * first and may already have added its own cache registers, so the shape is
 * "PUSH {r5, r6, r7[, rX...], lr}" rather than regalloc's original four-word
 * list.  The epilogue restores the same list and ends in pc (normal) or lr
 * (variadic). */
static int vg_is_frame_push(const char *line) {
    char flat[160];
    if (!vg_flatten(line, flat, (int)sizeof(flat))) return 0;
    if (strncmp(flat, "PUSH{", 5) != 0) return 0;
    if (!vg_list_has(flat, 5) || !vg_list_has(flat, 6) || !vg_list_has(flat, 7)) return 0;
    {
        int j = (int)strlen(flat);
        return j >= 3 && flat[j - 1] == '}' && flat[j - 2] == 'r' && flat[j - 3] == 'l';
    }
}

static int vg_is_frame_pop(const char *line) {
    char flat[160];
    if (!vg_flatten(line, flat, (int)sizeof(flat))) return 0;
    if (strncmp(flat, "POP{", 4) != 0) return 0;
    if (!vg_list_has(flat, 5) || !vg_list_has(flat, 6) || !vg_list_has(flat, 7)) return 0;
    {
        int j = (int)strlen(flat);
        if (j < 4 || flat[j - 1] != '}') return 0;
        return (flat[j - 2] == 'c' && flat[j - 3] == 'p') ||
               (flat[j - 2] == 'r' && flat[j - 3] == 'l');
    }
}

/* Does the path from line `j` on run into the frame epilogue?  Only a shared
 * return label and the frame teardown (`MOV sp, r6`, `ADD/SUB sp, sp, #n`) may
 * stand between the region and the POP; anything else means this is not the
 * exit tail. */
static int vg_ret_tail(AsmBuffer *b, int j, int nlines) {
    char line[256], flat[160];
    while (j < nlines) {
        int k2, len = vg_ll[j];
        if (len >= (int)sizeof(line) - 1) return 0;
        for (k2 = 0; k2 < len; k2++) line[k2] = b->buf[vg_ptr[j] + k2];
        line[len] = 0;
        if (vg_is_frame_pop(line)) return 1;
        if (!vg_is_ins_at(b, j)) { j++; continue; }    /* comment, .loc, label */
        if (!vg_flatten(line, flat, (int)sizeof(flat))) return 0;
        if (strncmp(flat, "MOVsp,r6", 8) == 0) { j++; continue; }
        if (strncmp(flat, "ADDsp,sp,#", 10) == 0) { j++; continue; }
        if (strncmp(flat, "SUBsp,sp,#", 10) == 0) { j++; continue; }
        return 0;
    }
    return 0;
}

/* Does this barrier line read `reg` without naming it in an operand list?  A
 * PUSH/STM list is the one barrier that reads the registers it names, and a
 * list names them in a place the S6b rename cannot rewrite. */
static int vg_barrier_reads(AsmBuffer *b, int j, int reg) {
    char line[256], flat[160];
    int k2, len = vg_ll[j];
    if (len >= (int)sizeof(line) - 1) return 0;
    for (k2 = 0; k2 < len; k2++) line[k2] = b->buf[vg_ptr[j] + k2];
    line[len] = 0;
    if (!vg_flatten(line, flat, (int)sizeof(flat))) return 0;
    if (strncmp(flat, "PUSH{", 5) != 0 && strncmp(flat, "STM", 3) != 0) return 0;
    return vg_list_has(flat, reg);
}

static void ark_vreg_function(AsmBuffer *b, int from, IrFunc *f, int local_eff) {
    int nslots = 0, nlines = 0, pos, i, k;
    int base;
    int nregs = 0, made[VG_MAX_REGS];
    int free_regs[VG_MAX_REGS], nfree = 0;
    int saved_words = 4;
    unsigned saved_mask = 0;                 /* registers the prologue preserves */
    unsigned used_mask = 0;
    int have_prologue = 0, have_frame = 0, done_push = 0;
    AsmBuffer out;
    char line[256];
    char mn[8];

    if (!g_config.enable_opt_vreg) return;
    vg_esc_lo = 0x7fffffff;

    /* Pass 1: split into lines. */
    for (pos = from; pos < b->len; ) {
        int len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (nlines >= VG_MAX_LINES) return;
        vg_ptr[nlines] = pos;
        vg_ll[nlines] = (unsigned short)(len < 65535 ? len : 65535);
        vg_lo[nlines] = -1;
        vg_lk[nlines] = 0;
        vg_it[nlines] = 0;
        vg_dr[nlines] = 0;
        vg_cons[nlines] = -1;
        vg_act[nlines] = 0;
        vg_ren[nlines] = -1;
        vg_rf[nlines] = 0;
        vg_mn[nlines] = 0;
        nlines++;
        pos += len + 1;
    }
    /* Pre-scan: the frame save's word count and every high register the text
     * already names.  -fopt-regalloc (and the constant cache inside it) runs
     * before this pass and takes its registers from the same four, so the pool
     * here is what it left over, and the base offset is where its widening put
     * it. */
    for (i = 0; i < nlines; i++) {
        int len = vg_ll[i];
        if (len >= (int)sizeof(line) - 1) return;
        for (k = 0; k < len; k++) line[k] = b->buf[vg_ptr[i] + k];
        line[len] = 0;
        if (!have_prologue && vg_is_frame_push(line)) {
            int k4;
            have_prologue = 1;
            /* The list always ends in lr (the epilogue in pc/lr), so the word
             * count is its registers plus that one. */
            saved_words = vg_list_regs(line) + 1;
            for (k4 = 4; k4 <= 11; k4++)
                if (vg_list_has(line, k4)) saved_mask |= 1u << k4;
        }
        used_mask |= (unsigned)vg_hi_mask(line);
    }
    /* The registers the prologue already saves are in use by definition, and
     * widening the list to name one twice would make the assembler deduplicate
     * it behind this pass's back: the real PUSH would then be shorter than
     * saved_words says, so both the frame base and the parity of the block
     * would be wrong.  Belt and braces next to the line scan above. */
    used_mask |= saved_mask;
    base = local_eff + 4 * saved_words;

    for (i = 0; i < nlines; i++) {
        int len = vg_ll[i];
        if (len < (int)sizeof(line) - 1) {
            for (k = 0; k < len; k++) line[k] = b->buf[vg_ptr[i] + k];
            line[len] = 0;
        } else {
            return;                      /* absurdly long line: leave the function */
        }
        if (vg_barrier(line)) {
            /* S6c: a call is not a wall for a promoted slot.  The cache
             * register is callee-saved (it is in the prologue's save list, or
             * this pass would not have taken it), and an untainted slot cannot
             * be reached by the callee at all -- no address of it ever escaped
             * into memory.  So the region scan below is allowed to walk through
             * a call when the value it renames sits in a callee-saved register
             * too.  Every other consumer of vg_lk still treats 5 as a barrier. */
            char m2[8];
            if (vg_mnem(line, m2) &&
                ((m2[0] == 'B' && m2[1] == 'L' && m2[2] == 0) ||
                 (m2[0] == 'B' && m2[1] == 'L' && m2[2] == 'X' && m2[3] == 0)))
                vg_lk[i] = 5;
            else
                vg_lk[i] = 3;
            continue;
        }
        {
            int off = -1, dr = -1, t = vg_scan(line, &off, &dr);
            if (t == 4) { vg_lk[i] = 4; have_frame = 1; }
            else if (t == 3) { vg_lk[i] = 0; }
            else if (t == 0 || t == 1) {
                if (off >= 0 && off < base) {
                    int s = vg_slot(&nslots, off);
                    if (s < 0) return;
                    vg_lo[i] = (short)s;
                    vg_dr[i] = (unsigned char)dr;
                    vg_lk[i] = (unsigned char)(t == 0 ? 1 : 2);
                    if (t == 0) vg_slots[s].reads++;
                    else vg_slots[s].stores++;
                }
            } else {                     /* t == 2: another shape naming a slot */
                if (off >= 0 && off < base) {
                    int s = vg_slot(&nslots, off);
                    int s3;
                    if (s < 0) return;
                    /* An address at or below this offset can reach it: a callee
                     * may write through it, so promotion is not sound. */
                    if (off < vg_esc_lo) vg_esc_lo = off;
                    for (s3 = 0; s3 < nslots; s3++)
                        if (vg_slots[s3].off >= off) vg_slots[s3].taint = 1;
                }
            }
        }
    }
    /* IT coverage: an IT block makes the next n instructions conditional. */
    for (i = 0; i < nlines; i++) {
        int len = vg_ll[i], cnt, c;
        if (len >= (int)sizeof(line) - 1) continue;
        for (k = 0; k < len; k++) line[k] = b->buf[vg_ptr[i] + k];
        line[len] = 0;
        if (!vg_mnem(line, mn)) continue;
        if (mn[0] != 'I' || mn[1] != 'T') continue;
        cnt = (int)strlen(mn) - 1;
        c = 0;
        for (k = i + 1; k < nlines && c < cnt; k++) {
            if (vg_lk[k] >= 3) break;
            if (vg_lk[k] == 1 || vg_lk[k] == 2) { vg_it[k] = 1; c++; }
            else if (vg_is_ins_at(b, k)) { vg_it[k] = 1; c++; }
        }
    }
    /* Volatile locals and in-IT mentions: keep in memory. */
    if (f) {
        int k2;
        for (k2 = 0; k2 < f->code_count; k2++) {
            IrInst *I2 = &f->code[k2];
            int s2;
            if (!(I2->aux & IR_AUX_VOLATILE)) continue;
            if (I2->op != IR_PUSH_VAR && I2->op != IR_STORE && I2->op != IR_PUSH_ADDR)
                continue;
            s2 = vg_slot(&nslots, (int)I2->val);
            if (s2 >= 0) vg_slots[s2].taint = 1;
        }
    }
    for (i = 0; i < nlines; i++) {
        if ((vg_lk[i] == 1 || vg_lk[i] == 2) && vg_it[i]) {
            int s = vg_lo[i];
            if (s >= 0) vg_slots[s].taint = 1;
        }
    }
    if (!have_prologue || !have_frame) return;
    if (nslots == 0) return;
    for (k = 8; k <= 11; k++)
        if (!(used_mask & (1u << (k - 8)))) free_regs[nfree++] = k;
    if (nfree == 0) return;

    /* Pass 2: which loads can be elided.  S6b widens the region from "the very
     * next instruction" to the rest of the basic block: the load is dropped and
     * every line inside the region that reads the load's destination reads the
     * cache register instead.  This is safe because the region has a single
     * path (the scan stops at any barrier, so a rename never crosses a branch
     * or a prologue/epilogue; S6c lets it cross a call, but only when the
     * destination is a callee-saved register this prologue really saves, so
     * the value survives the call) and the cache register already holds the
     * slot's value everywhere (every store became "MOV rC, rS").
     *
     * The scan also stops at any other frame access and at the first line that
     * *overwrites* the destination without reading it -- after that the low
     * register carries a different value.  A read-modify-write of the
     * destination is renamed and kept: the cache register then carries the
     * updated value down the same path. */
    for (i = 0; i < nlines; i++) {
        int j, s, dr, end, rmw = -1;
        vg_cons[i] = -1;
        if (vg_lk[i] != 1) continue;
        s = vg_lo[i];
        if (s < 0 || vg_slots[s].taint) continue;
        dr = vg_dr[i];
        if (dr < 0 || vg_it[i]) continue;
        end = -1;
        for (j = i + 1; j < nlines; j++) {
            int len = vg_ll[j];
            char cl[256];
            if (vg_lk[j] == 4) break;                   /* prologue / frame setup */
            if (vg_lk[j] == 5) {
                /* A call clobbers r0-r3 and preserves r4-r11, so the region can
                 * only continue when the value it renames lives in a register
                 * the callee is obliged to keep -- and that this function's own
                 * prologue really saves. */
                if (dr >= 4 && ((saved_mask >> dr) & 1u)) continue;
                end = j;
                break;
            }
            if (vg_lk[j] == 3) break;                   /* any other barrier */
            if (vg_lk[j] == 2) {
                /* A store whose source is this register has to be renamed as
                 * well, or it would write the pre-load value back.  A store of
                 * any other value does not touch this register at all. */
                if (vg_dr[j] != dr) continue;
                end = j + 1;
                continue;
            }
            if (vg_lk[j] == 1) {
                /* Another slot's load only ends the region when it overwrites
                 * this very register; otherwise it touches a different one. */
                if (vg_dr[j] == dr) { end = j; break; }
                continue;
            }
            if (!vg_is_ins_at(b, j)) continue;  /* blank or comment */
            if (len >= (int)sizeof(cl) - 1) { end = -1; break; }
            for (k = 0; k < len; k++) cl[k] = b->buf[vg_ptr[j] + k];
            cl[len] = 0;
            if (vg_writes_reg(cl, dr)) {
                if (!vg_reads_reg(cl, dr)) { end = j; break; }
                if (vg_mentions_reg(cl, dr)) end = j + 1;
                rmw = j;
                continue;                       /* read-modify-write: keep it */
            }
            if (vg_mentions_reg(cl, dr)) end = j + 1;
        }
        if (end < 0) continue;                  /* nothing to rename */
        if (rmw >= 0) {
            /* Renaming a read-modify-write makes the cache register carry the
             * result of that operation.  That is only sound when the result
             * really becomes the slot's new value -- i.e. when it is written
             * straight back to the slot (the counter idiom, whose store the
             * rewrite below turns into a self-move).  If the result goes
             * anywhere else the cache register is left holding a temporary
             * while the slot still holds its old value, and the *next* load
             * of that slot would be elided and read the temporary:
             * The stdlib's mul32x32() is exactly this shape -- `a0*b0` and `a0*b1` share
             * a0, each result goes to its own slot, so -fopt-pair
             * -fopt-vreg -fopt-vstack came back with `MUL r10, r1` twice and
             * the second one multiplied p00 by b1.  Fall back to
             * `MOV rd, rC`, which costs exactly what the load cost, and stop
             * the region in front of the read-modify-write so nothing inside
             * it is renamed either. */
            int q = rmw + 1;
            while (q < nlines && !vg_is_ins_at(b, q)) q++;
            if (!(q < nlines && vg_lk[q] == 2 && vg_lo[q] == s &&
                  vg_dr[q] == dr)) {
                vg_cons[i] = rmw;
                vg_rf[i] = 1;      /* keep the copy: act 2, not act 1 */
                continue;          /* not elided, so elid stays 0 */
            }
        }
        vg_cons[i] = end;
        vg_slots[s].elid++;
        /* The rename is only sound when nothing reads `dr` implicitly at the
         * region's edge, because a rename moves the value into the cache
         * register and leaves `dr` holding whatever it held before the load.
         * Three edges have such a reader, none of which the S6b rewrite can
         * touch:
         *   - a call reads r0-r3 without naming them, so an argument value
         *     stays live in `dr` (`n = work(n, 5)` passed the previous
         *     expression's value as the argument);
         *   - a PUSH/STM list names `dr` inside braces;
         *   - the epilogue returns in r0, so a region that runs into the exit
         *     tail leaves the return value in `dr` (`return t & 0xff`
         *     computed into the cache register and returned a stale r0).
         * Such a load is kept as "MOV rD, rC" with no rename at all -- the
         * same instruction count the load had, so nothing grows. */
        if (end < nlines) {
            if (vg_lk[end] == 5 && dr <= 3) vg_rf[i] = 1;
            else if (vg_lk[end] == 3 && vg_barrier_reads(b, end, dr)) vg_rf[i] = 1;
        }
        if (dr == 0 && !vg_rf[i] && vg_ret_tail(b, end, nlines)) vg_rf[i] = 1;
    }

    /* Pass 3: pick slots.  Rank by elided loads, take what the pool holds. */
    for (k = 0; k < nfree; k++) {
        int best = -1;
        for (i = 0; i < nslots; i++) {
            if (vg_slots[i].reg || vg_slots[i].taint) continue;
            if (vg_slots[i].elid < 2) continue;   /* must pay for itself in count */
            if (best < 0 || vg_slots[i].elid > vg_slots[best].elid ||
                (vg_slots[i].elid == vg_slots[best].elid && vg_slots[i].off < vg_slots[best].off))
                best = i;
        }
        if (best < 0) break;
        vg_slots[best].reg = free_regs[k];
        made[nregs++] = free_regs[k];
    }
    if (nregs == 0) return;
    if (nregs & 1) {
        /* The frame was 8-aligned before this pass, so an odd number of added
         * words would leave sp at 4 mod 8.  One spare high register costs
         * nothing (a PUSH naming any of r8-r11 is 32-bit either way). */
        int j;
        for (j = 0; j < nfree; j++) {
            int used = 0, q;
            for (q = 0; q < nregs; q++) if (made[q] == free_regs[j]) used = 1;
            if (!used) { made[nregs++] = free_regs[j]; break; }
        }
        if (nregs & 1) return;                   /* no spare left: leave the function */
    }

    /* Assign actions. */
    for (i = 0; i < nlines; i++) {
        int s, r;
        if (vg_lk[i] != 1 && vg_lk[i] != 2) continue;
        s = vg_lo[i];
        if (s < 0) continue;
        r = vg_slots[s].reg;
        if (!r) continue;
        if (vg_lk[i] == 1) {
            int ok = (vg_cons[i] > i + 0) ? 1 : 0, dr = vg_dr[i];
            int hits = 0;
            if (vg_rf[i]) ok = 0;                 /* implicit reader: keep the copy */
            if (ok) {
                int j;
                for (j = i + 1; j < vg_cons[i]; j++) {
                    int len = vg_ll[j];
                    char cl[256];
                    if (!vg_is_ins_at(b, j)) continue;
                    if (len >= (int)sizeof(cl) - 1) { ok = 0; break; }
                    for (k = 0; k < len; k++) cl[k] = b->buf[vg_ptr[j] + k];
                    cl[len] = 0;
                    if (!vg_mentions_reg(cl, dr)) continue;
                    if (vg_mn[j] >= VG_MAX_MAP) { ok = 0; break; }
                    vg_mf[j][vg_mn[j]] = (signed char)dr;
                    vg_mt[j][vg_mn[j]] = (signed char)r;
                    vg_mn[j]++;
                    hits++;
                }
            }
            if (ok && hits) {
                vg_act[i] = 1;                    /* drop the load; the region reads rC */
            } else {
                /* Any rename already recorded stays: it names the same slot's
                 * cache register, so it is just as correct as the MOV.
                 *
                 * `hits == 0` is the S6c-found case: the load's value is used
                 * only *implicitly* -- a call reads r0-r3 without naming them,
                 * and a branch carries the register to another block.  Nothing
                 * inside the region can be rewritten to read the cache
                 * register, so dropping the load would leave the low register
                 * holding whatever it held before the load, and the value would
                 * simply be gone (`n = work(n, 5)` passed `s` instead of `n`).
                 * The copy costs exactly what the load cost, so keeping it
                 * never grows the function. */
                vg_act[i] = 2;                    /* MOV rD, rC: same count */
                vg_ren[i] = (signed char)r;
            }
        } else {
            vg_act[i] = 3;                        /* MOV rC, rS: same count as STR */
            vg_ren[i] = (signed char)r;
        }
    }

    /* Pass 4: rebuild. */
    asmbuf_init(&out);
    for (i = 0; i < nlines; i++) {
        int len = vg_ll[i];
        if (vg_act[i] == 1) continue;
        for (k = 0; k < len; k++) line[k] = b->buf[vg_ptr[i] + k];
        line[len] = 0;
        if (vg_act[i] == 2) {
            asmbuf_puts(&out, "    MOV r");
            asmbuf_int(&out, vg_dr[i]);
            asmbuf_puts(&out, ", r");
            asmbuf_int(&out, vg_ren[i]);
            asmbuf_putc(&out, '\n');
            continue;
        }
        if (vg_act[i] == 3) {
            /* "MOV rC, rS".  If the source register was itself renamed (this
             * store sits inside another slot's region) the copy reads that
             * slot's cache register; and when the two names coincide the copy
             * is a no-op, which is one instruction saved. */
            char mv[128], rl[512], rl2[512];
            const char *res = mv;
            int m, p2 = 0, selfmove = 0;
            mv[p2++] = 'M'; mv[p2++] = 'O'; mv[p2++] = 'V'; mv[p2++] = ' ';
            mv[p2++] = 'r';
            if (vg_ren[i] >= 10) {
                mv[p2++] = (char)('0' + vg_ren[i] / 10);
                mv[p2++] = (char)('0' + vg_ren[i] % 10);
            } else mv[p2++] = (char)('0' + vg_ren[i]);
            mv[p2++] = ','; mv[p2++] = ' '; mv[p2++] = 'r';
            if (vg_dr[i] >= 10) {
                mv[p2++] = (char)('0' + vg_dr[i] / 10);
                mv[p2++] = (char)('0' + vg_dr[i] % 10);
            } else mv[p2++] = (char)('0' + vg_dr[i]);
            mv[p2] = 0;
            for (m = 0; m < vg_mn[i]; m++) {
                const char *in = (m == 0) ? mv : res;
                char *dst = (m & 1) ? rl2 : rl;
                if (vg_mf[i][m] == (signed char)vg_dr[i] &&
                    vg_mt[i][m] == (signed char)vg_ren[i]) selfmove = 1;
                if (!vg_rename_reg(in, vg_mf[i][m], vg_mt[i][m], dst)) return;
                res = dst;
            }
            if (selfmove) continue;              /* MOV rC, rC */
            asmbuf_puts(&out, "    ");
            asmbuf_puts(&out, res);
            asmbuf_putc(&out, '\n');
            continue;
        }
        if (vg_mn[i]) {                        /* S6b: renamed reads of a cache reg */
            /* Ping-pong buffers: "r8" is one character longer than "r3", so a
             * rename cannot write over the text it is still reading. */
            char rl[512], rl2[512];
            const char *res = line;
            int m;
            for (m = 0; m < vg_mn[i]; m++) {
                const char *in = (m == 0) ? line : res;
                char *dst = (m & 1) ? rl2 : rl;
                if (!vg_rename_reg(in, vg_mf[i][m], vg_mt[i][m], dst)) return;
                res = dst;
            }
            asmbuf_puts(&out, res);
            asmbuf_putc(&out, '\n');
            continue;
        }
        if (!done_push && vg_is_frame_push(line)) {
            int cut = ra_last_elem_at(line);
            done_push = 1;
            if (cut < 0) cut = (int)strlen(line);
            for (k = 0; k < cut; k++) asmbuf_putc(&out, line[k]);
            for (k = 0; k < nregs; k++) {
                asmbuf_puts(&out, ", r");
                asmbuf_int(&out, made[k]);
            }
            for (k = cut; k < (int)strlen(line); k++) asmbuf_putc(&out, line[k]);
            asmbuf_putc(&out, '\n');
            continue;
        }
        if (vg_is_frame_pop(line)) {
            int cut = ra_last_elem_at(line);
            if (cut < 0) cut = (int)strlen(line);
            for (k = 0; k < cut; k++) asmbuf_putc(&out, line[k]);
            for (k = 0; k < nregs; k++) {
                asmbuf_puts(&out, ", r");
                asmbuf_int(&out, made[k]);
            }
            for (k = cut; k < (int)strlen(line); k++) asmbuf_putc(&out, line[k]);
            asmbuf_putc(&out, '\n');
            continue;
        }
        for (k = 0; k < len; k++) asmbuf_putc(&out, line[k]);
        asmbuf_putc(&out, '\n');
    }

    /* The saved block grew by 4*nregs bytes: shift every offset at or above
     * base (caller args and the va region).  Locals are all below base. */
    if (4 * nregs > 0) {
        AsmBuffer shf;
        int opos;
        char nline[256];
        asmbuf_init(&shf);
        for (opos = 0; opos < out.len; ) {
            int len = 0, olen, nlen = 0;
            char shl[1024];
            const char *np;
            while (opos + len < out.len && out.buf[opos + len] != '\n') len++;
            if (len >= (int)sizeof(line)) {
                for (i = 0; i < len; i++) asmbuf_putc(&shf, out.buf[opos + i]);
                asmbuf_putc(&shf, '\n');
                opos += len + 1;
                continue;
            }
            for (i = 0; i < len; i++) line[i] = out.buf[opos + i];
            line[len] = 0;
            np = out.buf + opos + len;
            if (*np == '\n') np++;
            while (np[nlen] && np[nlen] != '\n' && nlen < (int)sizeof(nline) - 1) {
                nline[nlen] = np[nlen];
                nlen++;
            }
            nline[nlen] = 0;
            olen = ra_shift_line(line, len, nline, base, 4 * nregs, shl);
            for (i = 0; i < olen; i++) asmbuf_putc(&shf, shl[i]);
            asmbuf_putc(&shf, '\n');
            opos += len + 1;
        }
        asmbuf_reserve(&out, shf.len + 1);
        for (i = 0; i < shf.len; i++) out.buf[i] = shf.buf[i];
        out.buf[shf.len] = 0;
        out.len = shf.len;
    }

    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 <= b->cap) {
        for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
        b->buf[from + out.len] = 0;
        b->len = from + out.len;
    }
}
#endif /* ARKCC_FEATURE_OPT_VREG */

#endif /* ARKCC_FEATURE_OPT_REGALLOC */
#if ARKCC_FEATURE_OPT_CMAT
/* ------------------ constant materialisation cleanup (-fopt-cmat) --------
 * The value model materialises every constant twice: once into a scratch
 * register for the value stack, once into the register the consumer wants.
 * On the HAL corpus (19,066 instructions after the twelve switches) that is
 * 967 "MOV rN, #0", 943 adjacent MOV/MOV pairs and 981 MOVW/MOVT pairs, and
 * the second half of many of those pairs is a copy of a value that was just
 * built one line above.
 *
 * Seven rules, all inside one straight-line block.  A block ends at a label,
 * any branch (including CBZ/CBNZ and the conditional forms), IT, stack
 * traffic (PUSH / POP / LDM / STM) or any mnemonic this pass does not model --
 * an unknown instruction may write a register or set flags, so the block
 * state is dropped there too.  One refinement: a POP / LDM writes exactly the
 * registers its list names, so the state of every *other* register survives
 * it, which is what lets M2 fold an index that a POP walked over.  A block has
 * one entry, so a value written inside it and overwritten before a read is
 * dead on every path through it.
 *
 *   M1  `MOV rD, rS` where rS holds a constant known in this block becomes
 *       `MOV rD, #k` (0 <= k <= 255, the form the emitter itself prints).  On
 *       its own this saves nothing -- it is what lets M3 delete the
 *       materialisation that rS came from.
 *   M2  `LDR/STR[B/H] rT, [rB, rI(, LSL #s)]` where rI holds a constant k
 *       known in this block becomes `[rB, #k<<s]` (0 <= k<<s <= 4095 and
 *       rI != rB).  Same address, same flags, one operand fewer.
 *   M3  A flag-neutral write (MOV / MOVW+MOVT pair / three-operand
 *       LSL/LSR/ASR/ROR / MVN / UXT / SXT / CLZ / REV) whose destination is
 *       written again later in the same block before any read of it is
 *       dropped.  The requirement of a later write inside the block is what
 *       makes liveness analysis unnecessary.  The MOVW+MOVT pair is kept as a
 *       *single* unit on purpose: half of it alone leaves the register with a
 *       different value, so neither half may ever be dropped by itself.
 *   M4  `LSL/LSR/ASR rD, rS, #n` where rS holds a constant known in this block
 *       becomes `MOV rD, #k` with the folded value (0 <= k <= 255).  The
 *       three-operand shift is flag-neutral, so value and flags are unchanged
 *       and the result is a constant M1/M2/M3 can use.
 *   M5  The same fold through UXT / SXT.
 *   M6  `CMP rX, #k` with rX known, immediately followed by a conditional
 *       branch: the branch is decided here.  Always taken becomes `B`, never
 *       taken is dropped; the CMP itself stays, so no flag any later
 *       instruction could read changes.
 *   M7  `PUSH {rX}` and, with nothing but dead units in between, `POP {rX}`:
 *       the value stack stores a value and loads it straight back.  Once the
 *       dead writes are gone nothing runs in between, sp ends where it
 *       started, and both lines go.  A label, a call or any other live unit
 *       ends the search -- a branch could reach the POP with a different
 *       value stack.
 *
 * A first draft also de-duplicated a MOVW/MOVT pair whose value the register
 * already held.  Measured on the corpus it fires zero times (any read of the
 * register in between clears the state, and without such a read the first
 * pair was dead for a different reason), so the rule is gone rather than kept
 * as never-exercised code.
 *
 * Refused on purpose: ADD/SUB/AND/ORR/EOR (they can set flags, and the corpus
 * is full of `ADD rX, rB, #0` used as a copy), MUL (MULS sets N/Z), write-back
 * and shifted register indexes other than a plain `LSL #s`, offsets beyond
 * 4095, and every delete whose value could be live at the end of the block.
 *
 * Convention (same one the copy passes above already rely on): the text this
 * emitter prints spells a flag-setting move MOVS, so a plain MOV/MOVW/MOVT/
 * MVN/UXT/SXT/CLZ/REV or a three-operand shift leaves the flags alone.
 */
#define CM_MAX_LINES 4096
#define CM_MAX_UNITS 2048
#define CM_MN_LEN    16
#define CM_OPS_LEN   96

typedef struct {
    int   line;      /* index into cm_ls[] of the first line of this unit */
    int   nlines;    /* 1, or 2 for a fused MOVW/MOVT pair                */
    char  mn[CM_MN_LEN];
    char  ops[CM_OPS_LEN];
    signed char   dst;     /* register written, -1 when it writes none    */
    unsigned char neutral; /* deleting it cannot change a value or a flag */
    unsigned char rewrite; /* ops[] differs from the text of the line     */
    unsigned char dead;    /* every line of the unit is dropped           */
    unsigned char bar;     /* barrier: clears the block state             */
} CmUnit;

static int   cm_linestart[CM_MAX_LINES];
static int   cm_linelen[CM_MAX_LINES];
static CmUnit cm_units[CM_MAX_UNITS];
static short cm_owner[CM_MAX_LINES];
/* The unit count while the "dead write" test runs (cm_dies_later). */
static int   cm_nu;

/* Case-insensitive compare: the emitter prints a few mnemonics in lower case
 * ("bx", "rev16", "rrx"), and every mnemonic test below has to see them. */
static int cm_streq(const char *a, const char *b) {
    for (;;) {
        char x = *a++, y = *b++;
        if (x >= 'a' && x <= 'z') x = (char)(x - 'a' + 'A');
        if (y >= 'a' && y <= 'z') y = (char)(y - 'a' + 'A');
        if (x != y) return 0;
        if (!x) return 1;
    }
}

/* Copy one line without leading blanks and without a trailing CR. */
static int cm_trim(const char *ln, int len, char *dst, int cap) {
    int i = 0, o = 0;
    while (i < len && (ln[i] == ' ' || ln[i] == '\t')) i++;
    while (i < len) {
        char c = ln[i++];
        if (c == '\r') continue;
        if (o + 1 >= cap) return -1;
        dst[o++] = c;
    }
    dst[o] = 0;
    return o;
}

/* "rN" and nothing else (0..12: r13 sp / r14 lr / r15 pc are never slots). */
static int cm_reg(const char *s, int *out) {
    int n = 0;
    if ((s[0] != 'r' && s[0] != 'R') || !s[1]) return 0;
    s++;
    if (*s < '0' || *s > '9') return 0;
    while (*s >= '0' && *s <= '9') { n = n * 10 + (*s - '0'); s++; }
    if (*s || n > 12) return 0;
    *out = n;
    return 1;
}

/* "#<decimal>" and nothing else. */
static int cm_imm(const char *s, long long *out) {
    long long v = 0;
    if (s[0] != '#' || !s[1]) return 0;
    s++;
    if (*s < '0' || *s > '9') return 0;
    while (*s >= '0' && *s <= '9') {
        v = v * 10 + (*s - '0');
        if (v > 0x7fffffffLL) return 0;
        s++;
    }
    if (*s) return 0;
    *out = v;
    return 1;
}

/* Split "MN ops" into the two halves.  0 for a line with no mnemonic. */
static int cm_split(const char *t, char *mn, int mn_sz, char *ops, int ops_sz) {
    int i = 0, o = 0;
    if (!t[0]) return 0;
    if (t[0] == ';' || t[0] == '@' || t[0] == '.') return 0;
    while (t[i] && t[i] != ' ' && t[i] != '\t') {
        if (i + 1 >= mn_sz) return 0;
        mn[i] = t[i];
        i++;
    }
    mn[i] = 0;
    while (t[i] == ' ' || t[i] == '\t') i++;
    while (t[i]) {
        if (o + 1 >= ops_sz) return 0;
        ops[o++] = t[i++];
    }
    ops[o] = 0;
    return 1;
}

/* "rA, rest" -> register A and the rest of the operand string. */
static int cm_first_reg(const char *ops, int *r, const char **rest) {
    char t[8];
    int i = 0, o = 0;
    while (ops[i] == ' ') i++;
    while (ops[i] && ops[i] != ',' && o + 1 < (int)sizeof t) t[o++] = ops[i++];
    t[o] = 0;
    if (!cm_reg(t, r)) return 0;
    while (ops[i] == ' ') i++;
    if (ops[i] != ',') return 0;
    i++;
    while (ops[i] == ' ') i++;
    *rest = ops + i;
    return 1;
}

/* Mnemonics whose first operand is written. */
static int cm_write_first(const char *mn) {
    static const char *const w[] = {
        "MOV", "MOVW", "MOVT", "MVN", "ADD", "SUB", "AND", "ORR", "EOR",
        "MUL", "MLA", "RSB", "ADC", "SBC", "BIC", "LSL", "LSR", "ASR", "ROR",
        "UXTB", "UXTH", "SXTB", "SXTH", "CLZ", "REV", "REV16", "REVSH",
        "LDR", "LDRB", "LDRH", "LDRSB", "LDRSH", 0
    };
    int i;
    for (i = 0; w[i]; i++) if (cm_streq(mn, w[i])) return 1;
    return 0;
}

/* Every mnemonic this pass is willing to look at.  Anything else is a block
 * barrier, because an unmodelled instruction may write a register or set the
 * flags in a way the state below would not know about. */
static int cm_modelled(const char *mn) {
    static const char *const m[] = {
        "MOV", "MOVW", "MOVT", "MVN", "ADD", "SUB", "AND", "ORR", "EOR",
        "MUL", "MLA", "RSB", "ADC", "SBC", "BIC", "LSL", "LSR", "ASR", "ROR",
        "UXTB", "UXTH", "SXTB", "SXTH", "CLZ", "REV", "REV16", "REVSH",
        "LDR", "LDRB", "LDRH", "LDRSB", "LDRSH", "STR", "STRB", "STRH",
        "CMP", "CMN", "TST", "PUSH", "NOP", "ADR",
        /* CBZ/CBNZ are *modelled* but not "no register effect": a compare
         * folded into the branch still reads rN.  See cm_cond_branch. */
        "CBZ", "CBNZ", 0
    };
    int i;
    for (i = 0; m[i]; i++) if (cm_streq(mn, m[i])) return 1;
    return 0;
}

/* Mnemonics that cannot change the condition flags, so deleting one is never
 * observable by a conditional branch.  LSL/LSR/ASR/ROR count only in their
 * three-operand form; the two-operand Thumb form is the flag-setting one. */
static int cm_neutral(const char *mn, const char *ops) {
    static const char *const n[] = {
        "MOV", "MOVW", "MOVT", "MVN", "UXTB", "UXTH", "SXTB", "SXTH",
        "CLZ", "REV", "REV16", "REVSH", 0
    };
    int i, commas = 0;
    for (i = 0; n[i]; i++) if (cm_streq(mn, n[i])) return 1;
    if (cm_streq(mn, "LSL") || cm_streq(mn, "LSR") ||
        cm_streq(mn, "ASR") || cm_streq(mn, "ROR")) {
        for (i = 0; ops[i]; i++) if (ops[i] == ',') commas++;
        return commas >= 2;
    }
    return 0;
}

/* Does this instruction end the straight-line block? */
static int cm_boundary(const char *mn) {
    char c = mn[0];
    if (c >= 'a' && c <= 'z') c = (char)(c - 'a' + 'A');
    if (c == 'B') {
        /* Branches (B, B<cond>, BL, BLX, BX) end a block; BIC/BFI/BFC/BFX do
         * not, and they are the only "B..." mnemonics this emitter prints. */
        if (cm_streq(mn, "BIC") || cm_streq(mn, "BICS") ||
            cm_streq(mn, "BFI") || cm_streq(mn, "BFC") ||
            cm_streq(mn, "BFX")) return 0;
        return 1;
    }
    if ((mn[0] == 'I' || mn[0] == 'i') && (mn[1] == 'T' || mn[1] == 't')) return 1;
    /* A fused compare-and-branch ends its block exactly like BEQ does, and it
     * is modelled (so that its operand is seen as a use), so it needs its own
     * line here: the !cm_modelled fallback below no longer covers it. */
    if (cm_streq(mn, "CBZ") || cm_streq(mn, "CBNZ")) return 1;
    if (cm_streq(mn, "POP") || cm_streq(mn, "LDM") || cm_streq(mn, "LDMIA") ||
        cm_streq(mn, "LDMDB") || cm_streq(mn, "STM") || cm_streq(mn, "STMIA") ||
        cm_streq(mn, "STMDB") || cm_streq(mn, "TBB") || cm_streq(mn, "TBH"))
        return 1;
    if (!cm_modelled(mn)) return 1;
    return 0;
}

/* Every register named in the string. */
static unsigned cm_scan_regs(const char *ops) {
    unsigned m = 0;
    int i;
    for (i = 0; ops[i]; i++) {
        int v = 0;
        const char *p;
        if (ops[i] != 'r' && ops[i] != 'R') continue;
        if (i > 0 && ((ops[i - 1] >= 'a' && ops[i - 1] <= 'z') ||
                      (ops[i - 1] >= 'A' && ops[i - 1] <= 'Z') ||
                      (ops[i - 1] >= '0' && ops[i - 1] <= '9') ||
                      ops[i - 1] == '_')) continue;
        p = ops + i + 1;
        if (*p < '0' || *p > '9') continue;
        while (*p >= '0' && *p <= '9') { v = v * 10 + (*p - '0'); p++; }
        if (*p && ((*p >= 'a' && *p <= 'z') || (*p >= 'A' && *p <= 'Z') ||
                   (*p >= '0' && *p <= '9') || *p == '_')) continue;
        if (v <= 12) m |= 1u << v;
    }
    return m;
}

/* Read-modify-write forms: with two operands the assembler makes Rd the first
 * source as well (`MUL rD, rS` is Rd = Rd * Rs, `LSL rD, rS` is Rd = Rd << Rs,
 * and `ADD rD, rS` is Rd = Rd + Rs), so deleting an earlier write to Rd would
 * change what this instruction computes.  One comma is exactly the two-operand
 * form; three-operand ALU instructions and `Rd, #imm` are not affected. */
static int cm_is_rmw(const char *mn, int one_comma) {
    static const char *const r[] = {
        "ADD", "SUB", "ADC", "SBC", "AND", "ORR", "EOR", "BIC", "RSB",
        "MUL", "MLA", "LSL", "LSR", "ASR", "ROR", 0
    };
    int i;
    if (!one_comma) return 0;
    for (i = 0; r[i]; i++) if (cm_streq(mn, r[i])) return 1;
    return 0;
}

/* Registers the instruction reads.  The first operand is a pure output only
 * for the "write_first" mnemonics; for STR/CMP/CMN/TST/PUSH every operand is
 * a source, and the STR form is exactly why this distinction matters (`STR r0,
 * [r6, #24]` reads r0 even though it sits where a destination usually is).  A
 * superset of the true reads, which is the safe direction for every rule. */
static unsigned cm_uses(const char *mn, const char *ops, int dst) {
    unsigned m;
    int i, comma = -1, commas = 0;
    if (!cm_write_first(mn)) return cm_scan_regs(ops);
    for (i = 0; ops[i]; i++)
        if (ops[i] == ',') { commas++; if (comma < 0) comma = i; }
    m = cm_scan_regs(comma >= 0 ? ops + comma + 1 : ops);
    if (dst >= 0 && cm_is_rmw(mn, commas == 1)) m |= 1u << dst;
    return m;
}

/* "rT, [rB, rI]" / "rT, [rB, rI, LSL #s]" -> the four fields.  Every other
 * memory form (plain offset, write-back, post-index) is rejected. */
static int cm_mem_idx(const char *mn, const char *ops, int *rt, int *rb,
                      int *ri, int *sh) {
    char t[16];
    int i = 0, o = 0, a = -1, bb = -1, c = -1;
    if (!(cm_streq(mn, "LDR") || cm_streq(mn, "STR") || cm_streq(mn, "LDRB") ||
          cm_streq(mn, "STRB") || cm_streq(mn, "LDRH") || cm_streq(mn, "STRH")))
        return 0;
    while (ops[i] == ' ') i++;
    while (ops[i] && ops[i] != ',') {
        if (o + 1 >= (int)sizeof t) return 0;
        t[o++] = ops[i++];
    }
    t[o] = 0;
    if (!cm_reg(t, &a) || ops[i] != ',') return 0;
    i++;
    while (ops[i] == ' ') i++;
    if (ops[i] != '[') return 0;
    i++;
    while (ops[i] == ' ') i++;
    o = 0;
    while (ops[i] && ops[i] != ',' && ops[i] != ']') {
        if (o + 1 >= (int)sizeof t) return 0;
        t[o++] = ops[i++];
    }
    t[o] = 0;
    if (!cm_reg(t, &bb)) return 0;
    while (ops[i] == ' ') i++;
    if (ops[i] != ',') return 0;
    i++;
    while (ops[i] == ' ') i++;
    o = 0;
    while (ops[i] && ops[i] != ',' && ops[i] != ']') {
        if (o + 1 >= (int)sizeof t) return 0;
        t[o++] = ops[i++];
    }
    t[o] = 0;
    if (!cm_reg(t, &c)) return 0;
    while (ops[i] == ' ') i++;
    *sh = 0;
    if (ops[i] == ']') {
        if (ops[i + 1]) return 0;
        *rt = a; *rb = bb; *ri = c;
        return 1;
    }
    if (ops[i] != ',') return 0;
    i++;
    while (ops[i] == ' ') i++;
    if (!(ops[i] == 'L' && ops[i + 1] == 'S' && ops[i + 2] == 'L')) return 0;
    i += 3;
    while (ops[i] == ' ') i++;
    if (ops[i] != '#') return 0;
    i++;
    if (ops[i] < '0' || ops[i] > '9') return 0;
    {
        int s = 0;
        while (ops[i] >= '0' && ops[i] <= '9') { s = s * 10 + (ops[i] - '0'); i++; }
        while (ops[i] == ' ') i++;
        if (ops[i] != ']' || ops[i + 1] || s > 3) return 0;
        *sh = s;
    }
    *rt = a; *rb = bb; *ri = c;
    return 1;
}

/* "rD, rS, #n" -- the three-operand shift the emitter prints when it scales
 * an index ("LSL r1, r7, #2").  The two-operand Thumb form is the flag-setting
 * one and is refused here: nothing in these rules may change the flags. */
static int cm_shift3(const char *mn, const char *ops, int *rd, int *rs, int *sh) {
    const char *rest = 0;
    char t[8];
    int i = 0, o = 0, n = 0;
    if (!(cm_streq(mn, "LSL") || cm_streq(mn, "LSR") || cm_streq(mn, "ASR")))
        return 0;
    if (!cm_first_reg(ops, rd, &rest)) return 0;
    while (rest[i] && rest[i] != ',' && o + 1 < (int)sizeof t) t[o++] = rest[i++];
    t[o] = 0;
    if (!cm_reg(t, rs)) return 0;
    while (rest[i] == ' ') i++;
    if (rest[i] != ',') return 0;
    i++;
    while (rest[i] == ' ') i++;
    if (rest[i] != '#') return 0;
    i++;
    if (rest[i] < '0' || rest[i] > '9') return 0;
    while (rest[i] >= '0' && rest[i] <= '9') { n = n * 10 + (rest[i] - '0'); i++; }
    if (rest[i]) return 0;
    *sh = n;
    return 1;
}

/* "UXTB rD, rS" (and the three other extends): two operands, no flags. */
static int cm_extend2(const char *mn, const char *ops, int *rd, int *rs) {
    const char *rest = 0;
    if (!(cm_streq(mn, "UXTB") || cm_streq(mn, "UXTH") ||
          cm_streq(mn, "SXTB") || cm_streq(mn, "SXTH")))
        return 0;
    if (!cm_first_reg(ops, rd, &rest)) return 0;
    while (*rest == ' ') rest++;
    if (!cm_reg(rest, rs)) return 0;
    return 1;
}

/* Is the branch `mn` taken when the compare just executed was "rA - rB"?
 * Textbook condition evaluation; the 32-bit difference is computed exactly
 * (unsigned wrap for C/Z and a 64-bit subtraction for the signed overflow
 * bit), so nothing here depends on how the target computes flags.
 * -1 means "not a condition this rule understands". */
static int cm_cond_true(const char *mn, long long a, long long b) {
    unsigned ua = (unsigned)a, ub = (unsigned)b;
    unsigned ur = ua - ub;
    int n = ((int)ur < 0);
    int z = (ur == 0);
    int c = (ua >= ub);
    long long d = (long long)(int)ua - (long long)(int)ub;
    int v = (d > 2147483647LL || d < -2147483648LL);
    if (cm_streq(mn, "BEQ")) return z;
    if (cm_streq(mn, "BNE")) return !z;
    if (cm_streq(mn, "BCS") || cm_streq(mn, "BHS")) return c;
    if (cm_streq(mn, "BCC") || cm_streq(mn, "BLO")) return !c;
    if (cm_streq(mn, "BMI")) return n;
    if (cm_streq(mn, "BPL")) return !n;
    if (cm_streq(mn, "BVS")) return v;
    if (cm_streq(mn, "BVC")) return !v;
    if (cm_streq(mn, "BHI")) return c && !z;
    if (cm_streq(mn, "BLS")) return !c || z;
    if (cm_streq(mn, "BGE")) return n == v;
    if (cm_streq(mn, "BLT")) return n != v;
    if (cm_streq(mn, "BGT")) return !z && n == v;
    if (cm_streq(mn, "BLE")) return z || n != v;
    return -1;
}

/* "{r4,r5,r6}" -> a mask of the registers inside the braces; the return value
 * is the register count, or 0 when the operand is anything else (`PUSH
 * {r5,r6,r7,lr}` names lr, which this mask has no bit for, so it is refused
 * and the caller stays conservative). */
static int cm_list_mask(const char *ops, unsigned *mask) {
    unsigned m = 0;
    int i = 0, n = 0;
    while (ops[i] == ' ') i++;
    if (ops[i] != '{') return 0;
    i++;
    for (;;) {
        int v = 0;
        while (ops[i] == ' ') i++;
        if (ops[i] != 'r' && ops[i] != 'R') return 0;
        i++;
        if (ops[i] < '0' || ops[i] > '9') return 0;
        while (ops[i] >= '0' && ops[i] <= '9') { v = v * 10 + (ops[i] - '0'); i++; }
        if (v > 12) return 0;
        m |= 1u << v;
        n++;
        while (ops[i] == ' ') i++;
        if (ops[i] == '}') { i++; break; }
        if (ops[i] != ',') return 0;
        i++;
    }
    while (ops[i] == ' ') i++;
    if (ops[i]) return 0;
    *mask = m;
    return n;
}

/* "{rN}" naming exactly one low register. */
static int cm_one_reg(const char *ops, int *reg) {
    unsigned m = 0;
    int r;
    if (cm_list_mask(ops, &m) != 1) return 0;
    for (r = 0; r < 13; r++) if (m == (1u << r)) { *reg = r; return 1; }
    return 0;
}

/* M3's criterion, factored out so the folded-constant rules can reuse it: is
 * `reg` written again later in this block before anything reads it?  Then
 * every earlier write to it is dead. */
static int cm_dies_later(int j, int reg) {
    int i;
    for (i = j + 1; i < cm_nu; i++) {
        CmUnit *v = &cm_units[i];
        /* POP / LDM write exactly the registers in their list: a write to
         * `reg` here is the overwrite the caller is looking for, and a list
         * that does not name `reg` still ends the block (stack traffic is
         * outside what this pass models). */
        if (cm_streq(v->mn, "POP") || cm_streq(v->mn, "LDM") ||
            cm_streq(v->mn, "LDMIA")) {
            unsigned m = 0;
            if (v->dead) continue;
            if (!cm_list_mask(v->ops, &m)) break;   /* `LDM rB!, {...}` etc. */
            if ((m >> reg) & 1) return 1;           /* it overwrites reg   */
            continue;      /* it leaves reg alone, and so do its neighbours */
        }
        if (v->bar) break;
        if ((cm_uses(v->mn, v->ops, v->dst) >> reg) & 1) break;
        if (v->dst == reg) return 1;
    }
    return 0;
}

/* ---- M8: function-level liveness ------------------------------------------
 * M1..M7 all live inside one block, because a block has a single entry: a write
 * that the same block overwrites can never be seen.  M8 has to know whether a
 * register is live *anywhere else* in the function, so it builds the block graph
 * from the unit table, computes live-in / live-out by fixed point, and then
 * drops a `MOV rD, #imm` (or a copy `MOV rD, rS`) whose destination is dead.
 * Both forms are flag-neutral -- this emitter prints MOVS whenever it means to
 * set the flags -- so removing one changes neither a value nor a flag.
 *
 * Every unknown resolves to the *wider* set, in this direction and no other:
 *   - a conditional branch and CBZ/CBNZ reach their target *and* fall through;
 *     `B` reaches only its target (or the next block when the label is not in
 *     this function, i.e. a tail call);
 *   - a call reads r0-r3 and r12 (and r1 may carry a 64-bit return);
 *   - a return site (`POP {..., pc}`, `BX lr`) reads r0 and r1;
 *   - an instruction this pass does not model is taken to read every register
 *     and write none, which keeps everything before it live.
 * Missing an edge would be unsound; inventing one only costs an opportunity.
 *
 * An IT block is never touched: the instruction count is what the conditional
 * contract promises.
 */
#define CM_MAX_BLOCKS 1024
#define CM_ALL_REGS   0x1fffu

static int      cm_bs[CM_MAX_BLOCKS], cm_be[CM_MAX_BLOCKS];
static unsigned cm_buse[CM_MAX_BLOCKS], cm_bdef[CM_MAX_BLOCKS];
static unsigned cm_blin[CM_MAX_BLOCKS], cm_blout[CM_MAX_BLOCKS];
static short    cm_bsucc[CM_MAX_BLOCKS][2];
static unsigned char cm_bns[CM_MAX_BLOCKS];
static unsigned char cm_bskip[CM_MAX_BLOCKS];   /* unknown effect: reads all */
static unsigned char cm_itcov[CM_MAX_UNITS];
static int      cm_m9del[CM_MAX_BLOCKS + 4];   /* units M9 wants gone */
static short    cm_canon[CM_MAX_BLOCKS];       /* label-only blocks folded */

static int cm_is_label(const CmUnit *u) {
    int l;
    if (!u->bar) return 0;
    if (u->mn[0] == 0) return 1;                 /* indented label: text in ops */
    l = (int)strlen(u->mn);
    return u->mn[l - 1] == ':';                  /* column-0 label: text in mn  */
}

/* The text of a label unit, wherever step 2 happened to park it. */
static const char *cm_label_name(const CmUnit *u) {
    return u->mn[0] ? u->mn : u->ops;
}

/* A load-multiple that may write pc: POP, LDM, LDMIA, LDMDB, LDMFD, ... */
static int cm_is_pop(const char *mn) {
    if (cm_streq(mn, "POP")) return 1;
    return (mn[0] == 'l' || mn[0] == 'L') &&
           (mn[1] == 'd' || mn[1] == 'D') &&
           (mn[2] == 'm' || mn[2] == 'M');
}

/* A conditional branch: it reaches its label and falls through.  `BAL` is the
 * unconditional `B` spelled with a condition code. */
static int cm_cond_branch(const char *mn) {
    static const char *const c[] = {
        "BEQ", "BNE", "BCC", "BCS", "BHS", "BLO", "BMI", "BPL", "BVS", "BVC",
        "BHI", "BLS", "BGE", "BLT", "BGT", "BLE", "CBZ", "CBNZ", 0
    };
    int i;
    for (i = 0; c[i]; i++) if (cm_streq(mn, c[i])) return 1;
    return 0;
}

/* Instructions that end a block but touch no general register: the IT prefix
 * (its effect is on the *next* instruction's condition), the memory barriers,
 * and the branches (a branch reads the flags, or nothing at all). */
static int cm_no_reg_effect(const CmUnit *u) {
    const char *m = u->mn;
    if ((m[0] == 'I' || m[0] == 'i') && (m[1] == 'T' || m[1] == 't')) return 1;
    if (cm_streq(m, "DMB") || cm_streq(m, "DSB") || cm_streq(m, "ISB")) return 1;
    if (cm_streq(m, "B") || cm_streq(m, "BAL")) return 1;
    /* CBZ/CBNZ read rN.  Treating them as register-free made M8 delete the
     * `MOV rX, #0` that feeds them -- a wrong answer (see CBZ_FOLD.md). */
    if (cm_streq(m, "CBZ") || cm_streq(m, "CBNZ")) return 0;
    return cm_cond_branch(m);
}


/* The block that starts with this label, or -1. */
static int cm_label_block(int nb, const char *name) {
    int b;
    if (!name[0]) return -1;
    for (b = 0; b < nb; b++)
        if (cm_is_label(&cm_units[cm_bs[b]]) &&
            cm_streq(cm_label_name(&cm_units[cm_bs[b]]), name)) return b;
    return -1;
}

/* `rD, #imm` or `rD, rS`: the two forms M8 may delete. */
static int cm_mov_const(const char *ops) {
    const char *rest = 0;
    int rd = -1, rs = -1;
    long long v;
    if (!cm_first_reg(ops, &rd, &rest)) return 0;
    while (*rest == ' ') rest++;
    if (*rest == '#') return cm_imm(rest, &v);
    return cm_reg(rest, &rs);
}

/* `PUSH {rX}` for exactly the one-register list `mask`.  M9's only candidate
 * shape: a push whose whole payload is the value already sitting in the
 * register. */
static int cm_push_one(const CmUnit *u, unsigned mask) {
    unsigned m = 0;
    if (u->dead) return 0;
    if (!cm_streq(u->mn, "PUSH")) return 0;
    if (!cm_list_mask(u->ops, &m)) return 0;
    return m == mask;
}

/* The pass over one function's text. */
static void ark_cmat_function(AsmBuffer *b, int from) {
    static char t[CM_OPS_LEN + CM_MN_LEN + 8];
    AsmBuffer out;            /* (only touched when something changed)    */
    int n = 0, nu = 0, pos = from, len, i, j, changed = 0;
    long long cval[13];
    unsigned char cknown[13];
    int pcmp = -1;                 /* register a pending CMP compares (M6) */
    long long pcmpval = 0;         /* ... its known value                     */
    long long pcmpimm = 0;         /* ... and the immediate it compares with  */

    if (!g_config.enable_opt_cmat) return;

    /* 1. line table */
    while (pos < b->len) {
        len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (n >= CM_MAX_LINES) return;     /* function too large: leave alone */
        cm_linestart[n] = pos;
        cm_linelen[n] = len;
        n++;
        pos += len + 1;
    }
    if (n == 0) return;

    /* 2. one unit per line; MOVW+MOVT of the same register fused into one,
     *    because neither half is meaningful on its own. */
    for (i = 0; i < n; i++) cm_owner[i] = -1;
    for (i = 0; i < n; i++) {
        CmUnit *cu;
        char mn2[CM_MN_LEN], ops2[CM_OPS_LEN];
        if (nu >= CM_MAX_UNITS) return;
        cu = &cm_units[nu];
        cu->line = i;
        cu->nlines = 1;
        cu->dst = -1;
        cu->neutral = 0;
        cu->rewrite = 0;
        cu->dead = 0;
        cu->bar = 0;
        cu->mn[0] = 0;
        cu->ops[0] = 0;
        if (cm_trim(b->buf + cm_linestart[i], cm_linelen[i], t, sizeof t) < 0)
            return;                        /* a long line: do not touch it */
        if (!cm_split(t, cu->mn, sizeof cu->mn, cu->ops, sizeof cu->ops)) {
            int tl = (int)strlen(t);
            /* A label starts a new block.  Comments and directives do not:
             * they carry no register or flag side effect, so the state of the
             * block survives them (the copy passes above skip them too). */
            if (tl > 0 && t[tl - 1] == ':') {
                /* Keep the label itself: M8 resolves a branch to the block
                 * that starts here. */
                int q;
                for (q = 0; q + 1 < tl && q + 1 < (int)sizeof cu->ops; q++)
                    cu->ops[q] = t[q];
                cu->ops[q] = 0;
                cu->bar = 1;
                cm_owner[i] = (short)nu;
                nu++;
            }
            continue;
        }
        if (cm_boundary(cu->mn)) {
            cu->bar = 1;
            cm_owner[i] = (short)nu;
            nu++;
            continue;
        }
        /* MOVW followed by MOVT of the same destination: fuse. */
        if (cm_streq(cu->mn, "MOVW") && i + 1 < n) {
            int rd = -1, rd2 = -1;
            const char *rest = 0;
            long long v;
            if (cm_trim(b->buf + cm_linestart[i + 1], cm_linelen[i + 1],
                        t, sizeof t) >= 0 &&
                cm_split(t, mn2, sizeof mn2, ops2, sizeof ops2) &&
                cm_streq(mn2, "MOVT") &&
                cm_first_reg(cu->ops, &rd, &rest) && cm_imm(rest, &v) &&
                cm_first_reg(ops2, &rd2, &rest) && cm_imm(rest, &v) &&
                rd == rd2) {
                cu->nlines = 2;
                cu->dst = rd;
                cu->neutral = 1;
                cm_owner[i] = (short)nu;
                cm_owner[i + 1] = (short)nu;
                nu++;
                i++;
                continue;
            }
        }
        if (cm_write_first(cu->mn)) {
            const char *rest = 0;
            int r = -1;
            if (cm_first_reg(cu->ops, &r, &rest)) cu->dst = (signed char)r;
        }
        cu->neutral = (unsigned char)cm_neutral(cu->mn, cu->ops);
        cm_owner[i] = (short)nu;
        nu++;
    }

    /* 3. per-block walk: M1, M2, M4, M5 and M6 rewrite, and the constant state
     *    is kept only inside a block (a POP / LDM clears just the registers
     *    its list names). */
    for (i = 0; i < 13; i++) { cknown[i] = 0; cval[i] = 0; }
    cm_nu = nu;
    pcmp = -1;
    for (j = 0; j < nu; j++) {
        CmUnit *cu = &cm_units[j];
        unsigned rd, bmask;
        int r;
        if (cu->bar) {
            /* M6: a conditional branch whose compare had both operands known
             * is decided here -- it either always branches or never does.
             * The CMP itself is kept, so every flag the rest of the block
             * could still read is exactly what it was; only the branch line
             * changes (and it is the only consumer of those flags). */
            if (pcmp >= 0) {
                int taken = cm_cond_true(cu->mn, pcmpval, pcmpimm);
                if (taken == 1) {
                    if (!cm_streq(cu->mn, "B")) {
                        cu->mn[0] = 'B';
                        cu->mn[1] = 0;
                        cu->rewrite = 1;
                        changed++;
                    }
                } else if (taken == 0) {
                    cu->dead = 1;
                    changed++;
                }
            }
            pcmp = -1;
            /* A braced register-list barrier writes exactly the registers it
             * names, so the rest keep their known values: that is what lets
             * the index of `[rB, rI, LSL #s]` be folded across the PUSH/POP
             * dance the value stack leaves behind.  Any other barrier (a
             * branch, a call, an unmodelled instruction) may touch anything
             * and still clears the lot. */
            if ((cm_streq(cu->mn, "POP") || cm_streq(cu->mn, "LDM") ||
                 cm_streq(cu->mn, "LDMIA")) &&
                cm_list_mask(cu->ops, &bmask)) {
                for (r = 0; r < 13; r++)
                    if ((bmask >> r) & 1) cknown[r] = 0;
            } else {
                for (r = 0; r < 13; r++) cknown[r] = 0;
            }
            continue;
        }
        /* CMP rX, #k with rX holding a known constant: remember it for the
         * branch on the next line (M6).  Any other unit clears it. */
        {
            const char *crest = 0;
            long long cimm = 0;
            int cr = -1;
            pcmp = -1;
            if (cm_streq(cu->mn, "CMP") && cu->dst < 0 &&
                cm_first_reg(cu->ops, &cr, &crest) && cm_imm(crest, &cimm) &&
                cr >= 0 && cknown[cr]) {
                pcmp = cr;
                pcmpval = cval[cr];
                pcmpimm = cimm;
            }
        }
        rd = cm_uses(cu->mn, cu->ops, cu->dst);
        if (cu->nlines == 2) {
            /* MOVW+MOVT: the register now holds a value no small immediate can
             * express, so any remembered constant for it is gone. */
            if (cu->dst >= 0) cknown[cu->dst] = 0;
            continue;
        }
        if (cm_streq(cu->mn, "MOV") && cu->dst >= 0) {
            const char *rest = 0;
            int rd2 = -1, rs = -1;
            long long v;
            if (cm_first_reg(cu->ops, &rd2, &rest)) {
                if (cm_imm(rest, &v)) {
                    cknown[cu->dst] = 1;
                    cval[cu->dst] = v;
                    continue;
                }
                if (cm_reg(rest, &rs)) {
                    r = cu->dst;
                    if (cknown[rs] && cval[rs] >= 0 && cval[rs] <= 255) {
                        char nops[CM_OPS_LEN];
                        int o;
                        snprintf(nops, sizeof nops, "r%d, #%d", r, (int)cval[rs]);
                        o = (int)strlen(nops);
                        if (o < (int)sizeof cu->ops) {
                            memcpy(cu->ops, nops, (size_t)o + 1);
                            cu->rewrite = 1;
                            changed++;
                        }
                    }
                    if (cknown[rs]) { cknown[r] = 1; cval[r] = cval[rs]; }
                    else cknown[r] = 0;
                    continue;
                }
            }
        } else {
            int rt = -1, rb = -1, ri = -1, sh = 0;
            int srd = -1, srs = -1, shn = 0;
            int erd = -1, ers = -1;
            if (cm_shift3(cu->mn, cu->ops, &srd, &srs, &shn) && cknown[srs]) {
                /* M4: a constant through a three-operand shift.  The shift is
                 * flag-neutral (the flag-setting form is the two-operand one),
                 * so replacing it with a MOV of the folded value changes no
                 * value and no flag -- and it lets M2 fold the index of the
                 * access that consumes the result one line later. */
                long long v = cval[srs];
                int ok = 1;
                if (cm_streq(cu->mn, "LSL")) {
                    if (shn >= 32 || v > (0x7fffffffLL >> shn)) ok = 0;
                    else v = v << shn;
                } else if (cm_streq(cu->mn, "LSR")) {
                    if (shn >= 32) ok = 0;
                    else v = (long long)((unsigned)v >> shn);
                } else {
                    v = (long long)((int)v >> shn);
                    if (v < 0) ok = 0;      /* no negative immediate to print */
                }
                if (ok) {
                    if (v >= 0 && v <= 255) {
                        char nops[CM_OPS_LEN];
                        snprintf(nops, sizeof nops, "r%d, #%d", srd, (int)v);
                        if ((int)strlen(nops) < (int)sizeof cu->ops) {
                            memcpy(cu->ops, nops, strlen(nops) + 1);
                            cu->mn[0] = 'M'; cu->mn[1] = 'O'; cu->mn[2] = 'V';
                            cu->mn[3] = 0;
                            cu->rewrite = 1;
                            changed++;
                        }
                    }
                    cknown[srd] = 1;
                    cval[srd] = v;
                    continue;
                }
            }
            if (cm_extend2(cu->mn, cu->ops, &erd, &ers) && cknown[ers]) {
                /* M5: the same fold through a zero/sign extend.  It is what
                 * turns "MOV r0, #1 / UXTB r0, r0" into one instruction. */
                long long v = cval[ers], w = v;
                if (cm_streq(cu->mn, "UXTB")) w = v & 0xff;
                else if (cm_streq(cu->mn, "UXTH")) w = v & 0xffff;
                else if (cm_streq(cu->mn, "SXTB")) w = (int)(signed char)(v & 0xff);
                else w = (int)(short)(v & 0xffff);
                if (w >= 0 && w <= 255) {
                    char nops[CM_OPS_LEN];
                    snprintf(nops, sizeof nops, "r%d, #%d", erd, (int)w);
                    if ((int)strlen(nops) < (int)sizeof cu->ops) {
                        memcpy(cu->ops, nops, strlen(nops) + 1);
                        cu->mn[0] = 'M'; cu->mn[1] = 'O'; cu->mn[2] = 'V';
                        cu->mn[3] = 0;
                        cu->rewrite = 1;
                        changed++;
                    }
                }
                if (w >= 0) {
                    cknown[erd] = 1;
                    cval[erd] = w;
                } else {
                    cknown[erd] = 0;
                }
                continue;
            }
            if (cm_mem_idx(cu->mn, cu->ops, &rt, &rb, &ri, &sh)) {
                if (ri != rb && cknown[ri]) {
                    long long off = cval[ri] << sh;
                    if (off >= 0 && off <= 4095) {
                        char nops[CM_OPS_LEN];
                        int o;
                        snprintf(nops, sizeof nops, "r%d, [r%d, #%d]",
                                 rt, rb, (int)off);
                        o = (int)strlen(nops);
                        if (o < (int)sizeof cu->ops) {
                            memcpy(cu->ops, nops, (size_t)o + 1);
                            cu->rewrite = 1;
                            changed++;
                        }
                    }
                }
            }
        }
        /* whatever this unit touches is no longer known after it */
        for (r = 0; r < 13; r++) {
            if ((rd >> r) & 1) cknown[r] = 0;
        }
        if (cu->dst >= 0) cknown[cu->dst] = 0;
    }

    /* 4. M3: a flag-neutral write whose destination is written again later in
     *    the same block before any read.  Ascending order is enough: dropping
     *    a unit can never hide a later write from a unit still to come. */
    for (j = 0; j < nu; j++) {
        CmUnit *cu = &cm_units[j];
        int d = cu->dst;
        if (!cu->neutral || cu->dead || cu->bar || d < 0) continue;
        if (cm_dies_later(j, d)) { cu->dead = 1; changed++; }
    }

    /* 4b. M7: `PUSH {rX}` and, with nothing but dead units in between,
     *     `POP {rX}`.  The pair stores a value on the stack and loads it
     *     straight back into the same register, so both lines go: sp is
     *     unchanged and nothing runs in between once the dead units are
     *     dropped.  A label or any other live unit ends the search -- a
     *     branch could reach the POP with a different value stack, and a
     *     call must keep the stack it can see. */
    for (j = 0; j < nu; j++) {
        CmUnit *cu = &cm_units[j];
        int rp = -1, rq = -1, k;
        if (cu->dead || cu->bar) continue;
        if (!cm_streq(cu->mn, "PUSH") || !cm_one_reg(cu->ops, &rp)) continue;
        for (k = j + 1; k < nu; k++) {
            CmUnit *v = &cm_units[k];
            if (v->dead) continue;
            if (cm_streq(v->mn, "POP") && cm_one_reg(v->ops, &rq) && rq == rp) {
                cu->dead = 1;
                v->dead = 1;
                changed++;
            }
            break;          /* the first live unit decides, either way */
        }
    }

    /* 4c. M8: a constant or a copy whose destination is dead across the
     *     whole function.  Both halves of the value model leave those behind:
     *     an operand the consumer folded away, and a copy a later rule moved
     *     into place.  Only the two flag-neutral forms are considered, and
     *     never inside an IT block. */
    {
        int nb = 0, m8ok = 1, j2, pass;

        for (j2 = 0; j2 < nu; j2++) cm_itcov[j2] = 0;
        for (j2 = 0; j2 < CM_MAX_BLOCKS; j2++) {
            cm_blin[j2] = 0; cm_blout[j2] = 0; cm_bns[j2] = 0; cm_bskip[j2] = 0;
        }

        /* The units an IT block covers: the count is part of the contract. */
        for (j2 = 0; j2 < nu; j2++) {
            CmUnit *u = &cm_units[j2];
            if ((u->mn[0] == 'I' || u->mn[0] == 'i') &&
                (u->mn[1] == 'T' || u->mn[1] == 't')) {
                int cnt = (int)strlen(u->mn) - 1, c2 = 0, k2 = j2 + 1;
                while (k2 < nu && c2 < cnt) {
                    if (cm_units[k2].mn[0]) { cm_itcov[k2] = 1; c2++; }
                    k2++;
                }
            }
        }

        /* Blocks: a label starts one, a boundary unit ends one. */
        {
            int s2 = 0;
            for (j2 = 0; j2 < nu; j2++) {
                CmUnit *u = &cm_units[j2];
                if (cm_is_label(u)) {
                    if (j2 > s2) {
                        if (nb >= CM_MAX_BLOCKS) { m8ok = 0; break; }
                        cm_bs[nb] = s2; cm_be[nb] = j2 - 1; nb++;
                    }
                    s2 = j2;
                    continue;
                }
                if (cm_boundary(u->mn)) {
                    if (nb >= CM_MAX_BLOCKS) { m8ok = 0; break; }
                    cm_bs[nb] = s2; cm_be[nb] = j2; nb++;
                    s2 = j2 + 1;
                }
            }
            if (m8ok && s2 < nu) {
                if (nb >= CM_MAX_BLOCKS) m8ok = 0;
                else { cm_bs[nb] = s2; cm_be[nb] = nu - 1; nb++; }
            }
        }
        if (nb == 0) m8ok = 0;

        /* Successors. */
        for (j2 = 0; j2 < nb && m8ok; j2++) {
            CmUnit *u = &cm_units[cm_be[j2]];
            int nx = (j2 + 1 < nb) ? j2 + 1 : -1;
            int tg;
            cm_bns[j2] = 0;
            if (cm_is_label(u)) {
                if (nx >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)nx;
                continue;
            }
            tg = cm_label_block(nb, u->ops);
            if (cm_streq(u->mn, "B") || cm_streq(u->mn, "BAL")) {
                if (tg >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)tg;
                else if (nx >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)nx;
                continue;
            }
            if (cm_streq(u->mn, "BL") || cm_streq(u->mn, "BLX")) {
                if (nx >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)nx;
                continue;
            }
            if (cm_streq(u->mn, "BX")) {
                const char *p = u->ops;
                while (*p == ' ') p++;
                if (!cm_streq(p, "lr")) {          /* computed: unknown target */
                    cm_bskip[j2] = 1;
                    if (nx >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)nx;
                }
                continue;                          /* `BX lr` returns         */
            }
            if (cm_streq(u->mn, "CBZ") || cm_streq(u->mn, "CBNZ")) {
                /* `CBZ rN, .L_x`: the label is the second operand, not the
                 * first, so cm_label_block(u->ops) above could never resolve
                 * it and the branch edge was missing entirely. */
                const char *p = strchr(u->ops, ',');
                if (p) { if (p[1] == ' ') p++; tg = cm_label_block(nb, p); }
                else tg = -1;
                if (tg >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)tg;
                if (nx >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)nx;
                continue;
            }
            if (cm_cond_branch(u->mn)) {
                if (tg >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)tg;
                if (nx >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)nx;
                continue;
            }
            if (cm_is_pop(u->mn)) {
                if (!strstr(u->ops, "pc") && nx >= 0)
                    cm_bsucc[j2][cm_bns[j2]++] = (short)nx;
                continue;
            }
            if (nx >= 0) cm_bsucc[j2][cm_bns[j2]++] = (short)nx;
        }

        /* 4c-1. M9: a value pushed on every path into a join and popped again
         *       as the join's first instruction never went anywhere.  The join
         *       begins with `POP {rX}`; every predecessor ends with `PUSH {rX}`
         *       and then either branches to the join or falls into it.  rX is
         *       not touched in between -- the push is the last thing a
         *       predecessor does -- so it already holds the value the pop would
         *       load.  Both halves are dropped together, which keeps sp balanced
         *       on every path, and nothing can have read the stack in between. */
        {
            int m9ok = 1;
            for (j2 = 0; j2 < nu; j2++) {
                CmUnit *u = &cm_units[j2];
                if (cm_streq(u->mn, "TBB") || cm_streq(u->mn, "TBH")) { m9ok = 0; break; }
                if (cm_streq(u->mn, "BX")) {
                    const char *p = u->ops;
                    while (*p == ' ') p++;
                    if (!cm_streq(p, "lr")) { m9ok = 0; break; }   /* computed target */
                }
            }
            /* A run of consecutive labels produces blocks that hold nothing but
             * a label; walk them forward so a predecessor that branches to the
             * first label of a chain still meets the block that does the work. */
            for (j2 = 0; j2 < nb; j2++) {
                int k3 = j2, step = 0;
                while (step++ < nb) {
                    int e3, only_labels = 1;
                    for (e3 = cm_bs[k3]; e3 <= cm_be[k3]; e3++)
                        if (!cm_is_label(&cm_units[e3])) { only_labels = 0; break; }
                    if (!only_labels || cm_bns[k3] != 1) break;
                    k3 = cm_bsucc[k3][0];
                    if (k3 < 0 || k3 >= nb) break;
                }
                cm_canon[j2] = (short)k3;
            }
            for (j2 = 0; j2 < nb && m9ok; j2++) {
                CmUnit *pop;
                unsigned pmask = 0;
                int k2 = cm_bs[j2], p2, npred = 0, ndel = 0, ok = 1;
                if (cm_canon[j2] != j2) continue;                  /* folded away */
                while (k2 <= cm_be[j2] && cm_is_label(&cm_units[k2])) k2++;
                if (k2 > cm_be[j2]) continue;
                pop = &cm_units[k2];
                if (!cm_streq(pop->mn, "POP") || pop->dead || cm_itcov[k2]) continue;
                if (!cm_list_mask(pop->ops, &pmask)) continue;
                if (pmask == 0 || (pmask & (pmask - 1)) != 0) continue;  /* one reg */
                if (pmask & 0xe000u) continue;                    /* not sp / lr / pc */
                for (p2 = 0; p2 < nb; p2++) {
                    int e, ispred = 0;
                    CmUnit *term;
                    if (p2 == j2) continue;
                    for (e = 0; e < (int)cm_bns[p2]; e++) {
                        int t3 = cm_bsucc[p2][e];
                        if (t3 >= 0 && t3 < nb && cm_canon[t3] == j2) { ispred = 1; break; }
                    }
                    if (!ispred) continue;
                    npred++;
                    term = &cm_units[cm_be[p2]];
                    if (cm_streq(term->mn, "B") || cm_streq(term->mn, "BAL")) {
                        int q = cm_be[p2] - 1;
                        while (q >= cm_bs[p2] && cm_is_label(&cm_units[q])) q--;
                        if (q < cm_bs[p2] || cm_itcov[q] ||
                            !cm_push_one(&cm_units[q], pmask)) { ok = 0; break; }
                        cm_m9del[ndel++] = q;
                        continue;
                    }
                    if (p2 + 1 >= nb || cm_canon[p2 + 1] != j2 ||
                        cm_itcov[cm_be[p2]] || !cm_push_one(term, pmask)) { ok = 0; break; }
                    cm_m9del[ndel++] = cm_be[p2];
                }
                if (!ok || npred == 0) continue;
                for (p2 = 0; p2 < ndel; p2++) {
                    cm_units[cm_m9del[p2]].dead = 1;
                    changed++;
                }
                pop->dead = 1;
                changed++;
            }
        }

        /* use / def per block.  Units an earlier rule already deleted are not
         * in the output, so they neither define nor use anything. */
        for (j2 = 0; j2 < nb && m8ok; j2++) {
            unsigned uu = 0, dd = 0;
            int k2;
            for (k2 = cm_bs[j2]; k2 <= cm_be[j2]; k2++) {
                CmUnit *v = &cm_units[k2];
                if (cm_is_label(v)) continue;
                if (v->dead) continue;
                if (cm_streq(v->mn, "BL") || cm_streq(v->mn, "BLX")) {
                    uu |= (0x100fu & ~dd);         /* r0-r3, r12 are arguments */
                    dd |= 0x100fu;                 /* ... and are clobbered    */
                    continue;
                }
                if (cm_is_pop(v->mn)) {
                    unsigned m2 = 0;
                    if (strstr(v->ops, "pc")) uu |= (3u & ~dd);  /* return value */
                    else if (cm_list_mask(v->ops, &m2)) dd |= m2;
                    else cm_bskip[j2] = 1;
                    continue;
                }
                if (cm_streq(v->mn, "BX")) {
                    const char *p = v->ops;
                    while (*p == ' ') p++;
                    if (cm_streq(p, "lr")) uu |= (3u & ~dd);
                    else cm_bskip[j2] = 1;
                    continue;
                }
                if (cm_no_reg_effect(v)) continue;
                if (cm_modelled(v->mn)) {
                    uu |= (cm_uses(v->mn, v->ops, v->dst) & ~dd);
                    if (v->dst >= 0) dd |= 1u << v->dst;
                    continue;
                }
                cm_bskip[j2] = 1;                  /* unknown: it may read anything */
            }
            if (cm_bskip[j2]) { uu = CM_ALL_REGS; dd = 0; }
            cm_buse[j2] = uu;
            cm_bdef[j2] = dd;
        }

        /* live-in / live-out by fixed point over the block graph. */
        for (pass = 0; pass < nb + 2 && m8ok; pass++) {
            int ch = 0;
            for (j2 = nb - 1; j2 >= 0; j2--) {
                unsigned lo = 0, li;
                int t2;
                for (t2 = 0; t2 < (int)cm_bns[j2]; t2++)
                    lo |= cm_blin[cm_bsucc[j2][t2]];
                li = cm_buse[j2] | (lo & ~cm_bdef[j2]);
                if (lo != cm_blout[j2] || li != cm_blin[j2]) {
                    cm_blout[j2] = lo;
                    cm_blin[j2] = li;
                    ch = 1;
                }
            }
            if (!ch) break;
        }

        /* Walk each block backwards and drop the dead MOVs. */
        for (j2 = 0; j2 < nb && m8ok; j2++) {
            unsigned live = cm_blout[j2];
            int k2;
            for (k2 = cm_be[j2]; k2 >= cm_bs[j2]; k2--) {
                CmUnit *v = &cm_units[k2];
                if (cm_is_label(v)) continue;
                if (v->dead) continue;
                if (cm_streq(v->mn, "BL") || cm_streq(v->mn, "BLX")) {
                    live |= 0x100fu;
                    continue;
                }
                if (cm_is_pop(v->mn)) {
                    unsigned m2 = 0;
                    if (strstr(v->ops, "pc")) live |= 3u;
                    else if (cm_list_mask(v->ops, &m2)) live &= ~m2;
                    continue;
                }
                if (cm_streq(v->mn, "BX")) {
                    const char *p = v->ops;
                    while (*p == ' ') p++;
                    if (cm_streq(p, "lr")) live |= 3u;
                    continue;
                }
                if (cm_no_reg_effect(v)) continue;
                if (!cm_modelled(v->mn)) { live = CM_ALL_REGS; continue; }
                if (!cm_itcov[k2] && v->dst >= 0 && cm_streq(v->mn, "MOV") &&
                    cm_mov_const(v->ops) && !((live >> v->dst) & 1)) {
                    v->dead = 1;
                    changed++;
                    continue;          /* its sources are not read any more */
                }
                if (v->dst >= 0) live &= ~(1u << v->dst);
                live |= cm_uses(v->mn, v->ops, v->dst);
            }
        }
    }

    if (!changed) return;

    /* 5. rebuild the function text */
    asmbuf_init(&out);
    for (i = 0; i < n; i++) {
        int o = cm_owner[i];
        int k;
        if (o < 0) {                       /* line the pass did not model */
            for (k = 0; k < cm_linelen[i]; k++)
                asmbuf_putc(&out, b->buf[cm_linestart[i] + k]);
            asmbuf_putc(&out, '\n');
            continue;
        }
        if (cm_units[o].line != i) continue;          /* second half of pair */
        if (cm_units[o].dead) continue;
        if (cm_units[o].rewrite) {
            asmbuf_puts(&out, "    ");
            asmbuf_puts(&out, cm_units[o].mn);
            if (cm_units[o].ops[0]) {
                asmbuf_putc(&out, ' ');
                asmbuf_puts(&out, cm_units[o].ops);
            }
            asmbuf_putc(&out, '\n');
            continue;
        }
        for (k = 0; k < cm_linelen[i]; k++)
            asmbuf_putc(&out, b->buf[cm_linestart[i] + k]);
        asmbuf_putc(&out, '\n');
        if (cm_units[o].nlines == 2) {     /* the MOVT half of the pair */
            i++;
            for (k = 0; k < cm_linelen[i]; k++)
                asmbuf_putc(&out, b->buf[cm_linestart[i] + k]);
            asmbuf_putc(&out, '\n');
        }
    }
    /* Nothing changed?  Then leave the buffer exactly as it was. */
    if (out.len == b->len - from &&
        memcmp(out.buf, b->buf + from, (size_t)out.len) == 0) return;
    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 > b->cap) return;
    for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
    b->buf[from + out.len] = 0;
    b->len = from + out.len;
}
#endif /* ARKCC_FEATURE_OPT_CMAT */
#if ARKCC_FEATURE_OPT_FRAME
/* ------------------ callee-saved list trimming (-fopt-frame) ---------------
 *
 * The frame save is emitted before the body exists, so it is the union of
 * every register the allocators might touch.  By the time the text is final a
 * register that never appears between the PUSH and its POP is being saved and
 * restored for nothing.  This pass deletes exactly those slots -- and, when
 * that empties the frame, the four instructions that build it
 * (SUB sp / MOV base,sp / MOV sp,base / ADD sp) as well.
 *
 * Deleting a slot moves sp, so the alignment padding (AAPCS: sp is 8-byte
 * aligned at every call) is recomputed from the new register count.  A
 * function that names sp anywhere else -- a variadic argument block, an
 * sp-relative address -- and one whose padding would not come out even are
 * both left untouched: the pass only deletes what it can prove unused.
 */
#define FR_MAX_LINES 8192
#define FR_MAX_EPI   64

static int fr_ls[FR_MAX_LINES];
static int fr_ll[FR_MAX_LINES];
static int fr_epi[FR_MAX_EPI];             /* line of each return path's POP */
static unsigned char fr_fl[FR_MAX_LINES];  /* line restores sp for a return */
static unsigned char fr_eb[FR_MAX_EPI];    /* return path undoes the frame with MOV sp, base */

static int fr_ident(int c);

/* `MOV sp, <base>` -- the line that puts the caller's stack back before the
 * epilogue pops.  Every return path has its own copy. */
static int fr_is_mov_sp_base(const char *s, const char *base) {
    const char *d, *c;
    if (strncmp(s, "MOV", 3) != 0) return 0;
    d = s + 3;
    while (*d == ' ' || *d == '\t') d++;
    if (!(strncmp(d, "sp", 2) == 0 && !fr_ident((unsigned char)d[2]))) return 0;
    c = strchr(s, ',');
    if (!c) return 0;
    c++;
    while (*c == ' ' || *c == '\t') c++;
    if (!base[0] || strncmp(c, base, strlen(base)) != 0) return 0;
    return !fr_ident((unsigned char)c[strlen(base)]);
}

/* `ADD sp, sp, #<n>` -- the line that drops the frame's padding. */
static int fr_is_add_sp(const char *s) {
    const char *d, *c;
    if (strncmp(s, "ADD", 3) != 0) return 0;
    d = s + 3;
    while (*d == ' ' || *d == '\t') d++;
    if (!(strncmp(d, "sp", 2) == 0 && !fr_ident((unsigned char)d[2]))) return 0;
    c = strchr(d, ',');
    if (!c) return 0;
    c++;
    while (*c == ' ' || *c == '\t') c++;
    if (!(strncmp(c, "sp", 2) == 0 && !fr_ident((unsigned char)c[2]))) return 0;
    return strchr(c, '#') != NULL;
}

/* One line, minus the CRLF tail.  Returns -1 for an over-long line, and the
 * pass then refuses to touch the function. */
static int fr_trim(const char *p, int len, char *out, int cap) {
    int i = 0;
    while (i < len && p[i] != '\r' && p[i] != '\n') i++;
    if (i >= cap) return -1;
    memcpy(out, p, (size_t)i);
    out[i] = 0;
    return i;
}

static const char *fr_skip_ws(const char *s) {
    while (*s == ' ' || *s == '\t') s++;
    return s;
}

static int fr_ident(int c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
           (c >= '0' && c <= '9') || c == '_';
}

/* "PUSH {r4, r5, lr}" -> span of the brace list. */
static int fr_braces(const char *s, int *open, int *close) {
    const char *a = strchr(s, '{');
    const char *b = strchr(s, '}');
    if (!a || !b || b < a) return 0;
    *open = (int)(a - s) + 1;
    *close = (int)(b - s);
    return 1;
}

static int fr_names(const char *s, int open, int close, char names[][8], int max) {
    int n = 0, i = open;
    while (i < close) {
        int st, ln;
        while (i < close && (s[i] == ' ' || s[i] == '\t' || s[i] == ',')) i++;
        if (i >= close) break;
        st = i;
        while (i < close && s[i] != ',' && s[i] != ' ' && s[i] != '\t') i++;
        ln = i - st;
        if (ln <= 0 || ln >= 8 || n >= max) return -1;
        memcpy(names[n], s + st, (size_t)ln);
        names[n][ln] = 0;
        n++;
    }
    return n;
}

static int fr_has(char names[][8], int n, const char *want) {
    int i;
    for (i = 0; i < n; i++)
        if (strcmp(names[i], want) == 0) return 1;
    return 0;
}

static int fr_num(const char *s) {
    int v = 0;
    while (*s >= '0' && *s <= '9') { v = v * 10 + (*s - '0'); s++; }
    return v;
}

/* Mark the members of `names` that occur as standalone tokens in [p, p+len),
 * plus whether `base` does. */
static void fr_mark_used(const char *p, int len, char names[][8], int n,
                         int *used, const char *base, int *base_used) {
    int i;
    for (i = 0; i < n; i++) used[i] = 0;
    *base_used = 0;
    while (len > 0) {
        int j = 0;
        if (!fr_ident((unsigned char)p[0])) { p++; len--; continue; }
        while (j < len && fr_ident((unsigned char)p[j])) j++;
        for (i = 0; i < n; i++)
            if ((int)strlen(names[i]) == j && memcmp(p, names[i], (size_t)j) == 0)
                used[i] = 1;
        if (base && base[0] && (int)strlen(base) == j &&
            memcmp(p, base, (size_t)j) == 0)
            *base_used = 1;
        p += j; len -= j;
    }
}

static void ark_frame_function(AsmBuffer *b, int from) {
    int pos = from, n = 0, i, k;
    char t[512];
    char pn[16][8], qn[16][8];
    int np = 0, nq = 0, nepi = 0, popen = 0, pclose = 0, qopen = 0, qclose = 0;
    int used[16], base_used = 0;
    char base[8];
    int pi = -1, qi = -1, sub_i = -1, mov1_i = -1;
    int oldN = 0, nkeep = 0, newN = 0, dropped = 0, pad_done = 0;
    int keep_base = 0, need_base = 0;
    int keep[16];
    AsmBuffer body, out;

    /* 1. line table */
    while (pos < b->len) {
        int len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (n >= FR_MAX_LINES) return;
        fr_ls[n] = pos;
        fr_ll[n] = len;
        n++;
        pos += len + 1;
    }
    if (n < 4) return;

    /* 2. the frame save: one PUSH naming lr, and every return path's POP
     *    naming pc.  A function with several returns has one POP per path,
     *    and each of them restores the same registers -- so narrowing the
     *    PUSH without narrowing all of them leaves every later return popping
     *    a list the prologue never pushed.  That is how `__aeabi_lcmp` came
     *    back with a 6-word PUSH and 8-word POPs and took the emulator down
     *    with UC_ERR_EXCEPTION.  A second PUSH naming lr anywhere means this
     *    is not one function and the pass refuses.
     *
     *    A return path is also the only place a POP may name registers the
     *    prologue did not save; a POP naming pc that does is a tail call or
     *    something this pass does not model, and it refuses. */
    for (i = 0; i < n; i++) {
        const char *s;
        if (fr_trim(b->buf + fr_ls[i], fr_ll[i], t, sizeof t) < 0) return;
        s = fr_skip_ws(t);
        if (strncmp(s, "PUSH", 4) == 0 && fr_braces(s, &popen, &pclose)) {
            int m = fr_names(s, popen, pclose, pn, 16);
            if (m <= 0) return;
            if (!fr_has(pn, m, "lr")) continue;
            np = m;
            pi = i;
            break;
        }
    }
    if (pi < 0) return;
    for (i = pi + 1; i < n; i++) {
        const char *s;
        if (fr_trim(b->buf + fr_ls[i], fr_ll[i], t, sizeof t) < 0) return;
        s = fr_skip_ws(t);
        if (strncmp(s, "PUSH", 4) == 0 && fr_braces(s, &qopen, &qclose)) {
            int m = fr_names(s, qopen, qclose, qn, 16);
            if (m > 0 && fr_has(qn, m, "lr")) return;   /* a second frame save */
            continue;
        }
        if (strncmp(s, "POP", 3) == 0 && fr_braces(s, &qopen, &qclose)) {
            int m = fr_names(s, qopen, qclose, qn, 16), j2;
            if (m <= 0) return;
            if (!fr_has(qn, m, "pc")) continue;
            for (j2 = 0; j2 < m; j2++) {
                if (strcmp(qn[j2], "pc") == 0 || strcmp(qn[j2], "lr") == 0)
                    continue;
                if (!fr_has(pn, np, qn[j2])) return;     /* not this frame */
            }
            if (nepi >= FR_MAX_EPI) return;
            fr_epi[nepi++] = i;
        }
    }
    if (nepi == 0) return;
    qi = fr_epi[0];

    /* 3. the frame base, the padding and the two movs that build it */
    base[0] = 0;
    for (i = pi + 1; i < qi; i++) {
        const char *s;
        if (fr_trim(b->buf + fr_ls[i], fr_ll[i], t, sizeof t) < 0) return;
        s = fr_skip_ws(t);
        if (sub_i < 0 && strncmp(s, "SUB", 3) == 0 && strstr(s, "sp")) {
            const char *h = strrchr(s, '#');
            if (h) { oldN = fr_num(h + 1); sub_i = i; }
        }
        if (!base[0] && strncmp(s, "MOV", 3) == 0) {
            const char *c = strchr(s, ',');
            if (c) {
                const char *q = c + 1;
                const char *d = s + 3;
                int ln = 0;
                while (*q == ' ' || *q == '\t') q++;
                while (*d == ' ' || *d == '\t') d++;
                while (fr_ident((unsigned char)d[ln])) ln++;
                if (strncmp(q, "sp", 2) == 0 && !fr_ident((unsigned char)q[2]) &&
                    ln > 0 && ln < 8) {
                    memcpy(base, d, (size_t)ln);
                    base[ln] = 0;
                    mov1_i = i;
                }
            }
        }
    }
    if (!base[0] || sub_i < 0 || mov1_i < 0) return;

    /* 3b. the lines each return path uses to undo the frame: `MOV sp, base`
     *     and `ADD sp, sp, #n`, directly in front of its POP.  Marking them is
     *     what lets the whole function be scanned in step 4 without mistaking
     *     them for body code that names sp. */
    memset(fr_fl, 0, (size_t)n);
    for (i = 0; i < nepi; i++) {
        int q = fr_epi[i] - 1, seen = 0;
        fr_eb[i] = 0;
        while (q > pi && seen < 3) {
            const char *s;
            if (fr_trim(b->buf + fr_ls[q], fr_ll[q], t, sizeof t) < 0) goto bail;
            s = fr_skip_ws(t);
            if (*s == 0 || *s == '.') { q--; continue; }
            if (fr_is_mov_sp_base(s, base) || fr_is_add_sp(s)) {
                if (fr_is_mov_sp_base(s, base)) fr_eb[i] = 1;
                fr_fl[q] = 1;
                seen++;
                q--;
                continue;
            }
            break;
        }
    }

    /* 4. body text, minus directives, the frame instructions and any other
     *    mention of sp (which would make the padding load-bearing).  The whole
     *    function is scanned, not just the text in front of the first return:
     *    a register used only on a later path is still used. */
    asmbuf_init(&body);
    for (i = pi + 1; i < n; i++) {
        const char *s;
        if (i == mov1_i || i == sub_i || fr_fl[i]) continue;
        if (fr_trim(b->buf + fr_ls[i], fr_ll[i], t, sizeof t) < 0) goto bail;
        s = fr_skip_ws(t);
        if (*s == '.') continue;
        if (strncmp(s, "POP", 3) == 0 && fr_braces(s, &qopen, &qclose)) {
            int m = fr_names(s, qopen, qclose, qn, 16);
            if (m > 0 && fr_has(qn, m, "pc")) continue;     /* a return path */
        }
        if (strstr(s, "sp")) goto bail;
        asmbuf_puts(&body, s);
        asmbuf_putc(&body, '\n');
    }

    fr_mark_used(body.buf, body.len, pn, np, used, base, &base_used);

    /* 4b. every return path must arrive with the machine stack balanced.
     *
     * The frame base is what used to hide this: `MOV sp, base` restores sp from
     * a saved value, so a `PUSH` that no `POP` ever matched still left the
     * epilogue reading the right words.  With the base gone it does not --
     * `-fopt-vstack` can leave exactly such a push at a branch that jumps to
     * the common return block (`HAL_Init`: `MOV r0, #0` / `PUSH {r0}` /
     * `B .L_ret`), and trimming the epilogue then popped the saved r5 into pc.
     *
     * Linear word depth is enough to see it: on reaching a return path the
     * depth must be exactly the number of registers that POP names.  Anything
     * else and this pass asks for `keep_base`: it keeps `MOV sp, base` and the
     * base register slot, so every return path recomputes sp from the saved
     * base and a leaked `PUSH` cannot move the words its POP reads -- the leak
     * becomes harmless instead of fatal.  That only works when every path
     * really restores sp from the base (checked against fr_eb below); a path
     * that does not still bails.
     * A depth that looks wrong only because two arms of an if/else share text
     * order is a false bail, which costs code size and nothing else. */
    {
        int depth = np;
        for (i = pi + 1; i < n; i++) {
            const char *s;
            int m, isret = 0;
            if (i == mov1_i || i == sub_i || fr_fl[i]) continue;
            if (fr_trim(b->buf + fr_ls[i], fr_ll[i], t, sizeof t) < 0) goto bail;
            s = fr_skip_ws(t);
            if (*s == '.' || *s == 0) continue;
            if (strncmp(s, "PUSH", 4) == 0) {
                if (!fr_braces(s, &qopen, &qclose)) goto bail;
                m = fr_names(s, qopen, qclose, qn, 16);
                if (m <= 0) goto bail;
                depth += m;
            } else if (strncmp(s, "POP", 3) == 0) {
                if (!fr_braces(s, &qopen, &qclose)) goto bail;
                m = fr_names(s, qopen, qclose, qn, 16);
                if (m <= 0) goto bail;
                for (k = 0; k < nepi; k++)
                    if (fr_epi[k] == i) isret = 1;
                if (isret && depth != m) need_base = 1;
                depth -= m;
            }
        }
    }
    if (need_base) {
        /* keep_base only protects a leaked push if each path's sp is rebuilt
         * from the base frame pointer.  Any path that tears the frame down by
         * padding arithmetic alone is not covered, so it still bails. */
        for (k = 0; k < nepi; k++) if (!fr_eb[k]) goto bail;
        keep_base = 1;
    }

    /* 5. keep[]: the PUSH slots that are still needed */
    for (i = 0; i < np; i++) {
        keep[i] = 0;
        if (strcmp(pn[i], "lr") == 0) keep[i] = 1;
        else if (used[i]) keep[i] = 1;
        else if ((base_used || keep_base) && strcmp(pn[i], base) == 0) keep[i] = 1;
    }
    nkeep = 0;
    for (i = 0; i < np; i++) if (keep[i]) nkeep++;
    dropped = np - nkeep;
    if (dropped <= 0 && base_used && !keep_base) goto bail;

    /* 6. new padding: sp must stay 8-byte aligned (nkeep counts lr, which is
     *    4 bytes like every other slot). */
    if (keep_base && !base_used) {
        /* `MOV sp, base` alone restores sp, so the padding has nothing left
         * to cover and every byte of it can go: base is sp right after the
         * PUSH, and the epilogue unwinds straight from there.  The body never
         * names base, so no stack argument is read through it. */
        newN = 0;
    } else if (base_used) {
        /* The frame base is sp after the padding, so the incoming stack
         * arguments sit at [base, #(4*np + oldN) + k] -- the distance is the
         * PUSH list plus the padding.  Dropping slots therefore has to be
         * paid back into the padding, otherwise every stack argument of a
         * frame-using function moves up 4 bytes per dropped register:
         * `five(1, 2, 3, 4, 9)` came back as 11 that way.  The total frame
         * size is unchanged, so the previous alignment carries over. */
        if ((4 * np + oldN) % 8 != 0) goto bail;
        newN = oldN + 4 * dropped;
    } else {
        newN = (nkeep % 2 == 0) ? 0 : 4;
    }
    if (dropped <= 0 && newN == oldN) goto bail;

    /* 7. rebuild: the prologue, every return path, and the padding in front of
     *    each of them. */
    asmbuf_init(&out);
    for (i = 0; i < n; i++) {
        const char *s;
        int e, is_epi = 0;
        char en[16][8];
        int en_n = 0, j;
        if (fr_trim(b->buf + fr_ls[i], fr_ll[i], t, sizeof t) < 0) goto bail;
        s = fr_skip_ws(t);
        for (e = 0; e < nepi; e++) if (fr_epi[e] == i) is_epi = 1;

        if (i == pi) {
            asmbuf_puts(&out, "    PUSH {");
            k = 0;
            for (j = 0; j < np; j++) {
                if (!keep[j]) continue;
                if (k++) asmbuf_puts(&out, ", ");
                asmbuf_puts(&out, pn[j]);
            }
            asmbuf_puts(&out, "}\n");
            continue;
        }
        if (is_epi) {
            if (strncmp(s, "POP", 3) != 0 || !fr_braces(s, &qopen, &qclose))
                goto bail;
            en_n = fr_names(s, qopen, qclose, en, 16);
            if (en_n <= 0) goto bail;
            /* Undo the padding in front of the POP.  The old code only
             * rewrote an `ADD sp, sp, #n` it found in the text, which assumes
             * the input had one -- but when the frame was torn down by
             * `MOV sp, base` alone (the padding is covered by the base
             * restore), there is no such line, and dropping the base then
             * left `SUB sp, sp, #4` with nothing to undo it: HAL_SuspendTick
             * ended in `POP {r5, r7, pc}` off a 16-byte frame and popped the
             * saved r7 into pc. */
            if (newN > 0 && !pad_done) {
                asmbuf_puts(&out, "    ADD sp, sp, #");
                asmbuf_int(&out, newN);
                asmbuf_putc(&out, '\n');
            }
            pad_done = 0;
            asmbuf_puts(&out, "    POP {");
            k = 0;
            for (j = 0; j < en_n; j++) {
                int want = 1;
                if (strcmp(en[j], "pc") != 0 && strcmp(en[j], "lr") != 0) {
                    int m;
                    want = 0;
                    for (m = 0; m < np; m++)
                        if (keep[m] && strcmp(pn[m], en[j]) == 0) { want = 1; break; }
                }
                if (!want) continue;
                if (k++) asmbuf_puts(&out, ", ");
                asmbuf_puts(&out, en[j]);
            }
            asmbuf_puts(&out, "}\n");
            continue;
        }
        if (i == sub_i) {
            if (newN == 0) continue;
            if (newN != oldN) {
                asmbuf_puts(&out, "    SUB sp, sp, #");
                asmbuf_int(&out, newN);
                asmbuf_putc(&out, '\n');
                continue;
            }
        } else if (fr_is_add_sp(s)) {
            /* An `ADD sp, sp, #oldN` in front of a return path is the same
             * teardown this pass now synthesises for every path (see below);
             * emitting both would undo the padding twice. */
            if (newN == 0) continue;
            if (newN != oldN) {
                asmbuf_puts(&out, "    ADD sp, sp, #");
                asmbuf_int(&out, newN);
                asmbuf_putc(&out, '\n');
                pad_done = 1;
                continue;
            }
            pad_done = 1;
        } else if (!base_used && !keep_base && (i == mov1_i || fr_is_mov_sp_base(s, base))) {
            /* The frame base is only ever built by `MOV base, sp` and torn down
             * by `MOV sp, base`, and both are excluded from `body` above -- so
             * `base_used == 0` means the body never names the base, i.e. the
             * frame itself became dead and every slot can go.  Dropping the
             * slots but keeping these movs is what broke
             * `-fopt-vstack -fopt-vreg -fopt-peep -fopt-frame` on the strinit_nul
             * case: the base was no longer saved, the `MOV base, sp` still ran,
             * and the caller's frame pointer came back clobbered -- the
             * emulator died with UC_ERR_EXCEPTION instead of returning
             * 75065859.  With the frame gone its movs go with it, on every
             * return path. */
            continue;
        }
        if (t[0] != 0 && t[strlen(t) - 1] == ':') pad_done = 0;
        for (k = 0; k < fr_ll[i]; k++)
            asmbuf_putc(&out, b->buf[fr_ls[i] + k]);
        asmbuf_putc(&out, '\n');
    }
    /* Nothing changed?  Leave the buffer exactly as it was. */
    if (out.len == b->len - from &&
        memcmp(out.buf, b->buf + from, (size_t)out.len) == 0) goto bail;

    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 > b->cap) goto bail;
    for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
    b->buf[from + out.len] = 0;
    b->len = from + out.len;
    return;

bail:
    return;
}
#endif /* ARKCC_FEATURE_OPT_FRAME */
#if ARKCC_FEATURE_OPT_EXIT
/* ------------------ dead frame maintenance at the exits (-fopt-exit) -------
 *
 * Every function with a frame pointer prints `MOV <base>, sp` in the prologue
 * and `MOV sp, <base>` in front of every return POP: the epilogue rebuilds sp
 * from the saved base instead of trusting the body to leave the machine stack
 * balanced.  That is the right default -- a push leaked inside one arm of an
 * if would otherwise move the words its POP reads -- but it is pure overhead
 * when the body never touches sp at all, because then sp is still equal to the
 * base at every single return.
 *
 * This pass deletes, in exactly that case:
 *
 *   E1  every `MOV sp, <base>` -- the value it writes is the value sp already
 *       holds, so the instruction is a no-op, and
 *   E2  the prologue's `MOV <base>, sp` too, when the base register appears
 *       nowhere else in the function: the frame base was built and then
 *       thrown away without ever being read as a base.
 *
 * Both are deletions: no label is added, no branch is rewritten, and the frame
 * size is untouched, so the control flow, the literal-pool offsets and the
 * far-offset fixer below all see the same function they saw before.
 *
 * Every line after the prologue is classified, and anything not modelled makes
 * the whole function refuse:
 *   - a POP that names pc is a return path and is left alone,
 *   - `MOV sp, <base>` is E1's candidate; the `ADD sp, sp, #N` that may follow
 *     it is the epilogue's own frame teardown and is kept (sp has to walk back
 *     over the frame before the POP), but it is only accepted in that position,
 *   - PUSH, a POP without pc, `LDR sp` / `STR sp`, an sp adjustment anywhere
 *     else, in short any other mention of sp: the body moves the stack, so the
 *     base is load-bearing and nothing is deleted,
 *   - any other mention of the base register means the frame is really used,
 *     which only rules E2 out (a PUSH/POP naming it is its save slot, not a
 *     use, and those live in the prologue and the epilogues anyway).
 * Directives and blank lines are skipped; comments are not stripped, so a line
 * that only *mentions* sp in a comment simply makes the pass decline.  The
 * emitter does not put comments inside function bodies, so that costs nothing.
 *
 * HAL corpus (95 TUs, Cortex-M4, -O2, the other 24 switches on): E1 fires on
 * 139 of the 166 frame-pointer functions and deletes 185 lines, E2 fires on 48
 * more functions; 233 instructions in total, no TU grows.  See docs/EXIT.md.
 */
#define EX_MAX_LINES 8192

static int ex_ls[EX_MAX_LINES];
static int ex_ll[EX_MAX_LINES];
static unsigned char ex_del[EX_MAX_LINES];

static int ex_ident(int c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
           (c >= '0' && c <= '9') || c == '_';
}

/* One line, minus the CRLF tail.  Returns -1 for an over-long line, and the
 * pass then refuses to touch the function. */
static int ex_trim(const char *p, int len, char *out, int cap) {
    int i = 0;
    while (i < len && p[i] != '\r' && p[i] != '\n') i++;
    if (i >= cap) return -1;
    memcpy(out, p, (size_t)i);
    out[i] = 0;
    return i;
}

static const char *ex_skip_ws(const char *s) {
    while (*s == ' ' || *s == '\t') s++;
    return s;
}

/* "PUSH {r4, r5, lr}" -> span of the brace list. */
static int ex_braces(const char *s, int *open, int *close) {
    const char *a = strchr(s, '{');
    const char *b = strchr(s, '}');
    if (!a || !b || b < a) return 0;
    *open = (int)(a - s) + 1;
    *close = (int)(b - s);
    return 1;
}

static int ex_names(const char *s, int open, int close, char names[][8], int max) {
    int n = 0, i = open;
    while (i < close) {
        int st, ln;
        while (i < close && (s[i] == ' ' || s[i] == '\t' || s[i] == ',')) i++;
        if (i >= close) break;
        st = i;
        while (i < close && s[i] != ',' && s[i] != ' ' && s[i] != '\t') i++;
        ln = i - st;
        if (ln <= 0 || ln >= 8 || n >= max) return -1;
        memcpy(names[n], s + st, (size_t)ln);
        names[n][ln] = 0;
        n++;
    }
    return n;
}

static int ex_has(char names[][8], int n, const char *want) {
    int i;
    for (i = 0; i < n; i++)
        if (strcmp(names[i], want) == 0) return 1;
    return 0;
}

/* Does `s` name register `r` as a standalone token? */
static int ex_mentions(const char *s, const char *r) {
    size_t L = strlen(r);
    const char *p = s;
    while (*p) {
        const char *st;
        if (!ex_ident((unsigned char)*p)) { p++; continue; }
        st = p;
        while (*p && ex_ident((unsigned char)*p)) p++;
        if ((size_t)(p - st) == L && memcmp(st, r, L) == 0) return 1;
    }
    return 0;
}

/* `MOV <base>, sp` -- the line that builds the frame base. */
static int ex_is_mov_base_sp(const char *s, char *out, int cap) {
    const char *d, *c;
    int ln = 0;
    if (strncmp(s, "MOV", 3) != 0) return 0;
    d = s + 3;
    while (*d == ' ' || *d == '\t') d++;
    while (ex_ident((unsigned char)d[ln])) ln++;
    if (ln <= 0 || ln >= cap) return 0;
    c = strchr(s, ',');
    if (!c) return 0;
    c++;
    while (*c == ' ' || *c == '\t') c++;
    if (!(strncmp(c, "sp", 2) == 0 && !ex_ident((unsigned char)c[2]))) return 0;
    memcpy(out, d, (size_t)ln);
    out[ln] = 0;
    return 1;
}

/* `MOV sp, <base>` -- the line that tears the frame down. */
static int ex_is_mov_sp_base(const char *s, const char *base) {
    const char *d, *c;
    if (strncmp(s, "MOV", 3) != 0) return 0;
    d = s + 3;
    while (*d == ' ' || *d == '\t') d++;
    if (!(strncmp(d, "sp", 2) == 0 && !ex_ident((unsigned char)d[2]))) return 0;
    c = strchr(s, ',');
    if (!c) return 0;
    c++;
    while (*c == ' ' || *c == '\t') c++;
    if (!base[0] || strncmp(c, base, strlen(base)) != 0) return 0;
    return !ex_ident((unsigned char)c[strlen(base)]);
}

/* `ADD sp, sp, #N` -- the epilogue's own frame teardown, the line that walks
 * sp back over the frame so the POP reads the callee-saved words.  It is not a
 * no-op and it is *kept*: only `MOV sp, <base>` in front of it goes.  It is
 * legal only directly after such a `MOV`, because that is the emitter's
 * epilogue shape; anywhere else an sp adjustment means the body moves the
 * stack and the whole function is refused. */
static int ex_is_sp_adjust(const char *s) {
    const char *p;
    if (strncmp(s, "ADD", 3) != 0 && strncmp(s, "SUB", 3) != 0) return 0;
    p = ex_skip_ws(s + 3);
    if (!(p[0] == 's' && p[1] == 'p' && !ex_ident((unsigned char)p[2]))) return 0;
    p = ex_skip_ws(p + 2);
    if (*p != ',') return 0;
    p = ex_skip_ws(p + 1);
    if (!(p[0] == 's' && p[1] == 'p' && !ex_ident((unsigned char)p[2]))) return 0;
    p = ex_skip_ws(p + 2);
    if (*p != ',') return 0;
    p = ex_skip_ws(p + 1);
    return *p == '#';
}

/* A frame base is a callee-saved general register.  Anything else (r0-r3, sp,
 * pc) means this is not the shape the emitter produces for a frame and the
 * pass stays out. */
static int ex_is_base_reg(const char *r) {
    if (r[0] != 'r') return 0;
    if (r[1] >= '4' && r[1] <= '9' && r[2] == 0) return 1;
    if (r[1] == '1' && (r[2] == '0' || r[2] == '1') && r[3] == 0) return 1;
    return 0;
}

static void ark_exit_function(AsmBuffer *b, int from)
{
    int pos = from, n = 0, i, j, pi = -1, nret = 0, ncan = 0, base_used = 0;
    int epi = 0;
    char t[512], base[8], nm[16][8];
    AsmBuffer out;

    /* 1. line table */
    while (pos < b->len) {
        int len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (n >= EX_MAX_LINES) return;
        ex_ls[n] = pos;
        ex_ll[n] = len;
        n++;
        pos += len + 1;
    }
    if (n < 4) return;
    memset(ex_del, 0, (size_t)n);

    /* 2. the prologue: the first `MOV <base>, sp` */
    base[0] = 0;
    for (i = 0; i < n; i++) {
        const char *s;
        if (ex_trim(b->buf + ex_ls[i], ex_ll[i], t, sizeof t) < 0) return;
        s = ex_skip_ws(t);
        if (*s == '.') continue;
        if (!ex_is_mov_base_sp(s, base, sizeof base)) continue;
        pi = i;
        break;
    }
    if (pi < 0 || !ex_is_base_reg(base)) return;

    /* 3. everything after the prologue */
    for (i = pi + 1; i < n; i++) {
        const char *s;
        int open_, close_;
        if (ex_trim(b->buf + ex_ls[i], ex_ll[i], t, sizeof t) < 0) return;
        s = ex_skip_ws(t);
        if (*s == 0 || *s == '.' || *s == ';') continue;
        if (ex_is_mov_sp_base(s, base)) { ex_del[i] = 1; ncan++; epi = 1; continue; }
        if (epi && ex_is_sp_adjust(s)) { epi = 0; continue; }
        epi = 0;
        if (strncmp(s, "POP", 3) == 0 && ex_braces(s, &open_, &close_)) {
            int m = ex_names(s, open_, close_, nm, 16);
            if (m > 0 && ex_has(nm, m, "pc")) { nret++; continue; }
            return;                  /* a POP the epilogue does not own */
        }
        if (strncmp(s, "PUSH", 4) == 0) return;
        if (ex_mentions(s, "sp")) return;
        if (ex_mentions(s, base)) base_used = 1;
    }
    if (nret == 0 || ncan == 0) return;

    /* 4. E2: a base that is never read as a base never had to be built */
    if (!base_used) ex_del[pi] = 1;

    /* 5. rebuild */
    asmbuf_init(&out);
    for (i = 0; i < n; i++) {
        if (ex_del[i]) continue;
        for (j = 0; j < ex_ll[i]; j++) asmbuf_putc(&out, b->buf[ex_ls[i] + j]);
        asmbuf_putc(&out, '\n');
    }
    /* Nothing changed?  Leave the buffer exactly as it was. */
    if (out.len == b->len - from &&
        memcmp(out.buf, b->buf + from, (size_t)out.len) == 0) return;

    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 > b->cap) return;
    for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
    b->buf[from + out.len] = 0;
    b->len = from + out.len;
}
#endif /* ARKCC_FEATURE_OPT_EXIT */
#if ARKCC_FEATURE_OPT_LITPOOL
/* ------------------ 32-bit constants in a literal pool (-fopt-litpool) ------
 *
 * A 32-bit constant is materialised as "MOVW rD, #lo" + "MOVT rD, #hi": eight
 * bytes of code for four bytes of value.  Loading it out of a literal pool
 * ("LDR rD, <label>", four bytes) costs four bytes per site plus four bytes per
 * distinct constant, so a constant used c times costs 4c + 4 instead of 8c and
 * the saving is 4(c - 1): nothing for a single use, one instruction per extra
 * use.
 *
 * One pool per function is too coarse.  The load is a PC-relative LDR whose
 * 12-bit field reaches 4,095 bytes, so a single function bigger than roughly
 * 1,000 instructions can host no pool at all -- and on the 95-TU corpus two
 * such functions alone held 225 of the 707 convertible MOVW/MOVT pairs.  The
 * text is therefore cut into regions at every instruction that ends the
 * control flow (POP {.., pc} / BX / unconditional B), and consecutive regions
 * are merged forward while the accumulated size stays within LP_REACH_INS
 * instructions (counted at the conservative 4 bytes each).  A pool is appended
 * right after the terminator that closes its group, i.e. on a path control has
 * already left: no branch can reach it, because every branch targets a label
 * and every label follows the pool.
 *
 * Text-level on purpose.  It sees the final register names (so the pool load
 * can name any register) and it runs after every pass that could otherwise
 * have to reason about data in the middle of a function -- -fopt-cmat has
 * already folded a constant into an operand where it could, so what is left
 * here is the residue that really needs the pool.
 *
 * Refused on purpose:
 *   - a function whose text does not end in a terminator (POP {.., pc}, BX or
 *     an unconditional B).  The pool is data and control must never run into
 *     it; a function that falls off its last instruction has a bug anyway, and
 *     appending data would turn that bug into a jump into a constant.
 *   - a MOVW/MOVT pair whose value comes from .arkdata/.arkdatasym: the
 *     linker patches the pair's two halfwords, so the pair has to stay a pair.
 *     (See emit_mov_addr32().)
 *   - a region too large for LP_REACH_INS on its own: it is left unpooled,
 *     which is correct and merely less compact.
 *   - a distinct constant beyond LP_MAX_POOL in one pool: the site is left as
 *     it was, also correct and merely less compact.
 * ------------------------------------------------------------------------- */
#define LP_MAX_LINES  4096
#define LP_MAX_POOL   128
#define LP_MAX_GROUPS 1024
/* 4 * LP_REACH_INS + 4 * LP_MAX_POOL must stay below 4095, with slack for the
 * `.align 4` in front of the pool. */
#define LP_REACH_INS  800

static int      lp_ls[LP_MAX_LINES];    /* byte offset of each line */
static int      lp_ll[LP_MAX_LINES];    /* its length, without the newline */
static int      lp_site[LP_MAX_LINES];  /* site register, -1 none, -2 the MOVT half */
static short    lp_pool[LP_MAX_LINES];  /* pool index of that site */
static short    lp_grp[LP_MAX_LINES];   /* group of that line, -1 none */
static int      lp_rend[LP_MAX_LINES];  /* region: line index of its terminator */
static int      lp_rins[LP_MAX_LINES];  /* region: instruction count */
static int      lp_gstart[LP_MAX_GROUPS];
static int      lp_gcut[LP_MAX_GROUPS];
static int      lp_gcnt[LP_MAX_GROUPS]; /* distinct constants in that pool */
static unsigned lp_val[LP_MAX_POOL];    /* one word per distinct constant */
static int      lp_seq;                 /* makes the labels unique per function */

/* Copy one line with the leading blanks and the trailing CR removed. */
static int lp_trim(const char *ln, int len, char *dst, int cap) {
    int i = 0, o = 0;
    while (i < len && (ln[i] == ' ' || ln[i] == '\t')) i++;
    while (i < len) {
        if (o + 1 >= cap) return -1;
        dst[o++] = ln[i++];
    }
    while (o > 0 && (dst[o - 1] == ' ' || dst[o - 1] == '\t' || dst[o - 1] == '\r'))
        o--;
    dst[o] = 0;
    return o;
}

/* Is this trimmed line an instruction (not a label, not a directive)? */
static int lp_is_ins(const char *t) {
    int n;
    if (!t[0] || t[0] == '.') return 0;
    n = (int)strlen(t);
    if (n > 0 && t[n - 1] == ':') return 0;
    return 1;
}

/* "MOVW rD, #12345" around `mn` (four upper-case letters). */
static int lp_parse_mov(const char *t, const char *mn, int *reg, unsigned *imm) {
    int i, r = 0;
    unsigned v = 0;
    for (i = 0; i < 4; i++) {
        char c = t[i];
        if (c >= 'a' && c <= 'z') c = (char)(c - 'a' + 'A');
        if (c != mn[i]) return 0;
    }
    if (t[4] != ' ' && t[4] != '\t') return 0;
    i = 5;
    while (t[i] == ' ' || t[i] == '\t') i++;
    if (t[i] != 'r') return 0;
    i++;
    if (t[i] < '0' || t[i] > '9') return 0;
    while (t[i] >= '0' && t[i] <= '9') { r = r * 10 + (t[i] - '0'); i++; }
    if (r > 15) return 0;
    while (t[i] == ' ' || t[i] == '\t') i++;
    if (t[i] != ',') return 0;
    i++;
    while (t[i] == ' ' || t[i] == '\t') i++;
    if (t[i] != '#') return 0;
    i++;
    if (t[i] < '0' || t[i] > '9') return 0;
    while (t[i] >= '0' && t[i] <= '9') { v = v * 10u + (unsigned)(t[i] - '0'); i++; }
    /* Anything after the immediate is a shape this pass does not model; the
     * emitter never prints one, and guessing would change the value. */
    while (t[i] == ' ' || t[i] == '\t') i++;
    if (t[i]) return 0;
    *reg = r;
    *imm = v;
    return 1;
}

/* Does this instruction end the control flow?  Only the unconditional forms
 * count: "POPNE {.., pc}" and "BXEQ lr" come back, so a pool after them would
 * sit on a live path. */
static int lp_ends_flow(const char *t) {
    if ((t[0] == 'B' || t[0] == 'b') && (t[1] == 'X' || t[1] == 'x'))
        return t[2] == ' ' || t[2] == '\t';
    if ((t[0] == 'B' || t[0] == 'b') && (t[1] == ' ' || t[1] == '\t')) return 1;
    if ((t[0] == 'P' || t[0] == 'p') && (t[1] == 'O' || t[1] == 'o') &&
        (t[2] == 'P' || t[2] == 'p') && (t[3] == ' ' || t[3] == '\t')) {
        const char *p = t + 4;
        while (*p) {
            if ((p[0] == 'p' || p[0] == 'P') && (p[1] == 'c' || p[1] == 'C'))
                return 1;              /* POP {.., pc} returns */
            p++;
        }
    }
    return 0;
}

/* ".arkdata" / ".arkdatasym" / anything else the linker patches. */
static int lp_is_ark(const char *t) {
    return t[0] == '.' && (t[1] == 'a' || t[1] == 'A') &&
           (t[2] == 'r' || t[2] == 'R') && (t[3] == 'k' || t[3] == 'K');
}

static void lp_put_hex(AsmBuffer *b, unsigned v) {
    static const char hx[] = "0123456789abcdef";
    char s[9];
    int i;
    for (i = 7; i >= 0; i--) { s[i] = hx[v & 0xFu]; v >>= 4; }
    s[8] = 0;
    asmbuf_puts(b, s);
}

/* Register one group covering regions [r0, r1].  Returns 0 when the group
 * table is full. */
static int lp_group_make(int r0, int r1, int *ng) {
    int i, lo;
    if (r0 > r1) return 1;
    if (*ng >= LP_MAX_GROUPS) return 0;
    lo = (r0 == 0) ? 0 : lp_rend[r0 - 1] + 1;
    lp_gstart[*ng] = lo;
    lp_gcut[*ng] = lp_rend[r1];
    lp_gcnt[*ng] = 0;
    for (i = lo; i <= lp_rend[r1]; i++) lp_grp[i] = (short)(*ng);
    (*ng)++;
    return 1;
}

/* Collect the MOVW/MOVT pairs of one group into lp_val[].  Returns the number
 * of distinct constants (or -1 on a buffer that no longer parses).  With
 * `assign` set it also records lp_site[]/lp_pool[] for the group's sites.  The
 * two calls for a group walk the same lines in the same order, so a site's
 * pool index is the same both times. */
static int lp_group_scan(AsmBuffer *b, int g, int assign) {
    char t[160], t2[160];
    int i, r1, r2, pi, nval = 0, hi = lp_gcut[g];
    unsigned v1, v2, val;

    for (i = lp_gstart[g]; i + 1 <= hi; i++) {
        if (lp_grp[i] != (short)g || lp_site[i] != -1) continue;
        if (lp_trim(b->buf + lp_ls[i], lp_ll[i], t, (int)sizeof t) < 0) return -1;
        if (!lp_parse_mov(t, "MOVW", &r1, &v1)) continue;
        if (lp_grp[i + 1] != (short)g) continue;
        if (lp_trim(b->buf + lp_ls[i + 1], lp_ll[i + 1], t2, (int)sizeof t2) < 0)
            return -1;
        if (!lp_parse_mov(t2, "MOVT", &r2, &v2) || r2 != r1) continue;
        if (i > 0 &&
            lp_trim(b->buf + lp_ls[i - 1], lp_ll[i - 1], t2, (int)sizeof t2) >= 0 &&
            lp_is_ark(t2)) continue;
        val = ((v2 & 0xFFFFu) << 16) | (v1 & 0xFFFFu);
        for (pi = 0; pi < nval; pi++) if (lp_val[pi] == val) break;
        if (pi == nval) {
            if (nval >= LP_MAX_POOL) continue;   /* table full: leave it be */
            lp_val[nval++] = val;
        }
        if (assign) {
            lp_site[i] = r1;
            lp_pool[i] = (short)pi;
            lp_site[i + 1] = -2;                /* the MOVT half goes away */
            i++;
        }
    }
    return nval;
}

static void ark_litpool_function(AsmBuffer *b, int from) {
    AsmBuffer out;
    char t[160];
    int n = 0, pos, len, i, k, last, nreg, ng, acc, gfirst, r, g, curg, site;

    if (!g_config.enable_opt_litpool) return;

    /* 1. line table */
    pos = from;
    while (pos < b->len) {
        len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (n >= LP_MAX_LINES) return;      /* function too large: leave alone */
        lp_ls[n] = pos;
        lp_ll[n] = len;
        n++;
        pos += len + 1;
    }
    if (n < 3) return;

    /* 2. control must not run into a pool: the last instruction has to leave */
    last = -1;
    for (i = n - 1; i >= 0; i--) {
        if (lp_trim(b->buf + lp_ls[i], lp_ll[i], t, (int)sizeof t) < 0) return;
        if (!lp_is_ins(t)) continue;
        last = i;
        break;
    }
    if (last < 0) return;
    if (!lp_ends_flow(t)) return;

    /* 3. regions: one per terminating instruction */
    nreg = 0;
    acc = 0;
    for (i = 0; i <= last; i++) {
        if (lp_trim(b->buf + lp_ls[i], lp_ll[i], t, (int)sizeof t) < 0) return;
        if (!lp_is_ins(t)) continue;
        acc++;
        if (!lp_ends_flow(t)) continue;
        if (nreg >= LP_MAX_LINES) return;
        lp_rend[nreg] = i;
        lp_rins[nreg] = acc;
        nreg++;
        acc = 0;
    }
    if (!nreg || acc) return;               /* acc != 0 contradicts step 2 */

    /* 4. merge regions forward while the merged pool stays within one LDR's
     *    reach; a region too large on its own is left unpooled */
    for (i = 0; i < n; i++) { lp_grp[i] = -1; lp_site[i] = -1; }
    ng = 0;
    gfirst = 0;
    acc = 0;
    for (r = 0; r < nreg; r++) {
        if (lp_rins[r] > LP_REACH_INS) {
            if (!lp_group_make(gfirst, r - 1, &ng)) return;
            gfirst = r + 1;
            acc = 0;
            continue;
        }
        if (acc + lp_rins[r] > LP_REACH_INS) {
            if (!lp_group_make(gfirst, r - 1, &ng)) return;
            gfirst = r;
            acc = 0;
        }
        acc += lp_rins[r];
    }
    if (!lp_group_make(gfirst, nreg - 1, &ng)) return;
    if (!ng) return;

    /* 5. rebuild: one load per site, one pool after each group's terminator.
     *    A group's value table is rebuilt when its first line is reached, so
     *    lp_val[] still holds this group's constants when its terminator (and
     *    therefore its pool) comes round. */
    lp_seq++;
    asmbuf_init(&out);
    curg = -2;
    for (i = 0; i < n; i++) {
        site = (i <= last) ? lp_site[i] : -1;
        if (i <= last) {
            g = (int)lp_grp[i];
            if (g >= 0 && g != curg) {
                curg = g;
                lp_gcnt[g] = lp_group_scan(b, g, 1);
                if (lp_gcnt[g] < 0) return;
            }
        }
        if (site == -2) {
            /* the MOVT half goes away */
        } else if (site >= 0) {
            asmbuf_puts(&out, "    LDR r");
            asmbuf_int(&out, site);
            asmbuf_puts(&out, ", .Llit_");
            asmbuf_int(&out, lp_seq);
            asmbuf_putc(&out, '_');
            asmbuf_int(&out, (int)lp_grp[i]);
            asmbuf_putc(&out, '_');
            asmbuf_int(&out, (int)lp_pool[i]);
            asmbuf_putc(&out, '\n');
        } else {
            for (k = 0; k < lp_ll[i]; k++) asmbuf_putc(&out, b->buf[lp_ls[i] + k]);
            asmbuf_putc(&out, '\n');
        }
        if (i <= last) {
            g = (int)lp_grp[i];
            if (g >= 0 && lp_gcut[g] == i && lp_gcnt[g] > 0) {
                asmbuf_puts(&out, "    .align 4\n");
                for (k = 0; k < lp_gcnt[g]; k++) {
                    asmbuf_puts(&out, ".Llit_");
                    asmbuf_int(&out, lp_seq);
                    asmbuf_putc(&out, '_');
                    asmbuf_int(&out, g);
                    asmbuf_putc(&out, '_');
                    asmbuf_int(&out, k);
                    asmbuf_puts(&out, ":\n    .word 0x");
                    lp_put_hex(&out, lp_val[k]);
                    asmbuf_putc(&out, '\n');
                }
            }
        }
    }
    /* Nothing changed?  Then leave the buffer exactly as it was. */
    if (out.len == b->len - from &&
        memcmp(out.buf, b->buf + from, (size_t)out.len) == 0) return;
    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 > b->cap) return;
    for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
    b->buf[from + out.len] = 0;
    b->len = from + out.len;
}
#endif /* ARKCC_FEATURE_OPT_LITPOOL */
#if ARKCC_FEATURE_OPT_SLOTREG
/* ------------------ redundant frame access removal (-fopt-slotreg) ------
 * docs/SLOT_REGISTERS.md (section 3, amended 2026-11-23) pre-registered this
 * slice as "keep a slot in r8-r11".  The cost model was then measured before
 * the code was written, and the register half turned out to be worth nothing
 * in instruction count: replacing "LDR r0,[r6,#o]" with "MOV r0,r8" is one
 * instruction either way, which is exactly what the older -fopt-regalloc-near
 * had already measured (19,066 -> 19,066, only LDR/STR turned into MOV).  What
 * does remove instructions is the fact the model was built on: in a straight
 * line, r0 *is* the slot's register between a store and the next read.  So the
 * slice that was implemented deletes, inside one basic block:
 *
 *   R1  "LDR r0, [r6,#o]" when r0 provably already holds the value of slot o,
 *       i.e. the last mention of o on this straight-line path was a kept load
 *       or store of o and nothing since has written r0.  Flags are untouched
 *       by LDR, so the deletion is flag-neutral.
 *   R2  "STR r0, [r6,#o]" when the value can never be observed:
 *       (a) slot o is never loaded anywhere in the function, or
 *       (b) a later store to o in the same block reaches every exit before any
 *           load of o does (the block has one entry, so the earlier value is
 *           dead on every path through it).
 *
 * Selection is the same taint proof -fopt-regalloc already relies on, and it is
 * the whole safety argument: slot o is handled only if *every* mention of o in
 * the whole function is exactly "LDR r0, [r6,#o]" or "STR r0, [r6,#o]" with an
 * offset below the local frame.  One mention in any other shape (a byte/half
 * access, "ADD rX, r6, #o" taking the address, an indexed "[r6, rX]", a 64-bit
 * half, a caller argument above the locals, a volatile local the IR flags)
 * leaves the slot in memory.  With no address escaping, only these very
 * instructions can observe the slot, so R1 and R2 cannot change what the
 * function computes.
 *
 * No extra register, therefore no wider PUSH/POP and no frame-offset shift:
 * every deletion is a strict instruction win, which is why the pass has no
 * cost model to reason about.  Unmodelled text is left alone rather than
 * guessed at: a line that names r6 in a shape this pass does not recognise
 * abandons the whole function.
 */
#define SR_MAX_SLOTS 128
#define SR_MAX_LINES 3000

typedef struct {
    int off;
    int reads;    /* "LDR r0, [r6,#off]" count in the whole function    */
    int taint;    /* mentioned in any other shape: stays in memory      */
    int indirect; /* a frame address at or below this slot escaped:
                   * a callee may read it, so "no LDR" proves nothing    */
} SrSlot;

static SrSlot        sr_slots[SR_MAX_SLOTS];
static unsigned short sr_ll[SR_MAX_LINES];   /* line length                */
static short         sr_lo[SR_MAX_LINES];    /* slot index, -1 when none   */
static unsigned char sr_lk[SR_MAX_LINES];    /* 0 other, 1 LDR, 2 STR,
                                                3 barrier, 4 writes r0     */
static unsigned char sr_drop[SR_MAX_LINES];
static int           sr_esc_lo;             /* lowest escaped frame offset  */
static int           sr_ptr[SR_MAX_LINES];   /* line start in the buffer   */

static int sr_pre8(const char *s, const char *pat) {
    int i;
    for (i = 0; i < 8; i++)
        if (s[i] != pat[i]) return 0;
    return 1;
}

/* Classify one line against the frame pointer.
 *   0  no "r6, #<n>" mention at all
 *   1  exactly "LDR r0, [r6,#n]"          (*off)
 *   2  exactly "STR r0, [r6,#n]"          (*off)
 *   3  "r6, #<n>" in another shape        (*off when the number parses, else -1)
 *   4  "MOV r6, sp" -- the frame pointer being set up, not a slot use
 *   5  cannot be modelled (indexed access, write-back, no parseable offset)
 *
 * A "3" line also gets its own "does it write r0" answer, folded into the line
 * kind in pass 1: `LDR r0, [r6, #96]` and `ADD r0, r6, #16` both leave r0 with
 * something that is not the cached slot value, and forgetting that is exactly
 * how "r0 already holds slot 0" stops being true.
 */
/* Count the "r6" tokens in a line.  The pass only models accesses whose
 * base is r6 itself; `MOV r5, r6` followed by `LDR r5, [r5, r7, LSL #2]`
 * (a by-value struct parameter indexed from a copied base) is a frame
 * access this pass cannot see, and missing it is how a live store gets
 * deleted -- see the escape fixture in tests/run_slotreg_tests.py. */
static int sr_count_r6(const char *ln) {
    const char *p = ln;
    int c = 0;
    while (*p) {
        if (p[0] == 'r' && p[1] == '6' &&
            !(p[2] >= '0' && p[2] <= '9') &&
            !((p[2] >= 'a' && p[2] <= 'z') || (p[2] >= 'A' && p[2] <= 'Z')) &&
            (p == ln || !((p[-1] >= 'a' && p[-1] <= 'z') ||
                          (p[-1] >= 'A' && p[-1] <= 'Z') ||
                          (p[-1] >= '0' && p[-1] <= '9')))) {
            c++;
            p += 2;
            continue;
        }
        p++;
    }
    return c;
}

static int sr_scan_line(const char *ln, int *off) {
    const char *p = ln, *br;
    int n = 0;
    *off = -1;
    {
        const char *s = ln;
        while (*s == ' ' || *s == '\t') s++;
        if (s[0] == 'M' && s[1] == 'O' && s[2] == 'V' && s[3] == ' ' &&
            s[4] == 'r' && s[5] == '6' && s[6] == ',' && s[7] == ' ')
            return 4;
        /* "MOV sp, r6" tears the frame down: the frame pointer is being
         * copied back to sp, not aliased into a general register. */
        if (s[0] == 'M' && s[1] == 'O' && s[2] == 'V' && s[3] == ' ' &&
            s[4] == 's' && s[5] == 'p' && s[6] == ',' && s[7] == ' ' &&
            s[8] == 'r' && s[9] == '6')
            return 4;
    }
    {
        int nr = sr_count_r6(ln);
        if (nr == 0) return 0;               /* no frame mention       */
        if (nr > 1) return 5;                /* two frame mentions     */
    }
    while (p[0] && !(p[0] == 'r' && p[1] == '6' && p[2] == ',' && p[3] == ' '))
        p++;
    if (!p[0]) return 5;   /* r6 in a shape this pass does not model
                            * (`MOV r5, r6`, `MOV r0, r6`, ...): the base
                            * can be aliased and a later [rX, rY, LSL #2]
                            * reaches the frame invisibly.  Abandon the
                            * function rather than guess. */
    if (p == ln || p[-1] != '[') {
        const char *q = p + 4;
        if (*q == '#') {
            q++;
            if (*q >= '0' && *q <= '9') {
                while (*q >= '0' && *q <= '9') { n = n * 10 + (*q - '0'); q++; }
                *off = n;
                return 3;
            }
        }
        return 5;                     /* "[r6, rX]" or garbage */
    }
    br = p - 1;
    p = br + 5;
    if (*p != '#') return 5;
    p++;
    if (*p < '0' || *p > '9') return 5;
    while (*p >= '0' && *p <= '9') { n = n * 10 + (*p - '0'); p++; }
    *off = n;
    if (*p != ']') return 5;
    p++;
    while (*p == ' ' || *p == '\t' || *p == '\r') p++;
    if (*p) return 3;
    {
        const char *s = ln;
        while (*s == ' ' || *s == '\t') s++;
        if (s + 8 == br && sr_pre8(s, "LDR r0, ")) return 1;
        if (s + 8 == br && sr_pre8(s, "STR r0, ")) return 2;
    }
    return 3;
}

/* A label, or any instruction with more than one exit: after it the block
 * state is dropped, because the value in r0 is only known on this path. */
static int sr_barrier(const char *ln) {
    const char *s = ln;
    char mn[8];
    int n = 0, i, sp = 0;
    static const char *const br_mn[] = {
        "B", "BEQ", "BNE", "BCC", "BCS", "BHS", "BLO", "BMI", "BPL", "BVS",
        "BVC", "BHI", "BLS", "BGE", "BLT", "BGT", "BLE", "BAL", "BX", "BL",
        "BLX", "CBZ", "CBNZ", "IT", "POP", "PUSH", "LDM", "LDMIA", "LDMFD",
        "STM", "STMIA", "STMDB", "STMFD", 0
    };
    while (*s == ' ' || *s == '\t') s++;
    if (!*s) return 0;
    if (*s == '.') {
        /* .L...: and $d:/$t: are labels; .loc/.cfi/.type/.size are directives
         * and say nothing about the state. */
        const char *t = s;
        while (*t) { if (*t == ' ' || *t == '\t') sp = 1; t++; }
        if (!sp && t > s && t[-1] == ':') return 1;
        return 0;
    }
    if (*s == '$') return 1;
    while ((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z')) {
        if (n < 7) mn[n++] = (char)((*s >= 'a' && *s <= 'z') ? *s - 32 : *s);
        s++;
    }
    mn[n] = 0;
    for (i = 0; br_mn[i]; i++)
        if (strcmp(mn, br_mn[i]) == 0) return 1;
    return 0;
}

/* Does this instruction write r0?  First operand is the destination for every
 * mnemonic that is not in the list below. */
static int sr_writes_r0(const char *ln) {
    const char *s = ln;
    char mn[8];
    int n = 0, i;
    static const char *const nodst[] = {
        "STR", "STRB", "STRH", "CMP", "CMN", "TST", "TEQ", "PUSH", "POP",
        "NOP", "DMB", "DSB", "ISB", "IT", "BX", "BL", "BLX", "CBZ", "CBNZ",
        "LDM", "LDMIA", "LDMFD", "STM", "STMIA", "STMDB", "STMFD", "B",
        "BEQ", "BNE", "BCC", "BCS", "BHS", "BLO", "BMI", "BPL", "BVS",
        "BVC", "BHI", "BLS", "BGE", "BLT", "BGT", "BLE", "BAL", 0
    };
    while (*s == ' ' || *s == '\t') s++;
    if (*s == '.' || *s == '$' || !*s) return 0;
    while ((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z')) {
        if (n < 7) mn[n++] = (char)((*s >= 'a' && *s <= 'z') ? *s - 32 : *s);
        s++;
    }
    mn[n] = 0;
    for (i = 0; nodst[i]; i++)
        if (strcmp(mn, nodst[i]) == 0) return 0;
    while (*s == ' ' || *s == '\t') s++;
    if (s[0] == 'r' && s[1] == '0' &&
        (s[2] == ',' || s[2] == ' ' || s[2] == '\0' || s[2] == '\r'))
        return 1;
    return 0;
}

static int sr_slot(int *n, int off) {
    int i;
    for (i = 0; i < *n; i++)
        if (sr_slots[i].off == off) return i;
    if (*n >= SR_MAX_SLOTS) return -1;
    sr_slots[*n].off = off;
    sr_slots[*n].reads = 0;
    sr_slots[*n].taint = 0;
    sr_slots[*n].indirect = (off >= sr_esc_lo);
    return (*n)++;
}

/* Rewrite the last slice of the buffer.  Nothing is ever added, so the splice
 * cannot overflow; the pass only removes lines. */
static void ark_slotreg_function(AsmBuffer *b, int from, IrFunc *f, int local_size) {
    int nslots = 0, nlines = 0, pos, i, k;
    int base = local_size;
    AsmBuffer out;
    char line[256];

    if (!g_config.enable_opt_slotreg) return;

    sr_esc_lo = 0x7fffffff;

    /* Pass 1: classify every line and count the loads of every slot. */
    for (pos = from; pos < b->len; ) {
        int len = 0, off = 0, t, s;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (nlines >= SR_MAX_LINES) return;      /* too big: leave it alone */
        sr_ptr[nlines] = pos;
        sr_ll[nlines] = (unsigned short)len;
        sr_lo[nlines] = -1;
        sr_lk[nlines] = 0;
        sr_drop[nlines] = 0;
        if (len < (int)sizeof(line) - 1) {
            for (i = 0; i < len; i++) line[i] = b->buf[pos + i];
            line[len] = 0;
            if (sr_barrier(line)) {
                sr_lk[nlines] = 3;
            } else {
                t = sr_scan_line(line, &off);
                if (t == 1 || t == 2) {
                    if (off < base) {
                        s = sr_slot(&nslots, off);
                        if (s < 0) return;
                        sr_lo[nlines] = (short)s;
                        sr_lk[nlines] = (unsigned char)(t == 1 ? 1 : 2);
                        if (t == 1) sr_slots[s].reads++;
                    } else if (t == 1) {
                        /* A load of an incoming stack argument -- `LDR r0,
                         * [r6, #local_size+16]` in a function that spills its
                         * fifth word argument.  The slot is not ours, so there
                         * is nothing to remember about it, but the load still
                         * overwrites r0: leaving the line unclassified kept
                         * "r0 already holds slot 0" alive across it, and the
                         * next `LDR r0, [r6, #0]` was then deleted and the
                         * value of `e` reused as `a` (five(1,2,3,4,9) read
                         * back 11). */
                        sr_lk[nlines] = 6;
                    }
                } else if (t == 3 || t == 4) {
                    if (t == 3 && off < 0) return;  /* offset not parseable */
                    if (sr_writes_r0(line)) sr_lk[nlines] = 6;
                    else if (t == 4) sr_lk[nlines] = 4;
                    if (t == 3 && off < base) {
                        s = sr_slot(&nslots, off);
                        if (s < 0) return;
                        sr_slots[s].taint = 1;
                        /* The address of a local is now in a register and can
                         * be handed to a callee (memcpy, a by-value struct
                         * argument, an out-parameter).  That callee reaches
                         * every byte from `off` upwards, so for slots at or
                         * above it "no LDR reads this slot" stops being
                         * evidence of "no reader at all": dead-store removal
                         * must not fire there.  Redundant-load removal is
                         * unaffected -- computing an address does not write
                         * memory, and the only indirect writer the emitter can
                         * produce is a call, which is a block boundary. */
                        if (off < sr_esc_lo) {
                            int s3;
                            sr_esc_lo = off;
                            for (s3 = 0; s3 < nslots; s3++)
                                if (sr_slots[s3].off >= off)
                                    sr_slots[s3].indirect = 1;
                        }
                        if (sr_writes_r0(line)) sr_lk[nlines] = 6;
                    }
                } else if (t == 5) {
                    return;                      /* shape not modelled */
                } else if (t == 0) {
                    if (sr_writes_r0(line)) sr_lk[nlines] = 4;
                }
            }
        } else {
            sr_lk[nlines] = 3;                   /* absurdly long: boundary */
        }
        nlines++;
        pos += len + 1;
    }
    /* Volatile locals go through the same two instruction shapes as ordinary
     * ones, so the text cannot tell them apart -- but deleting one of their
     * accesses is exactly what the keyword exists to forbid.  The IR knows, so
     * ask it rather than guess from the listing (same rule as -fopt-regalloc). */
    if (f) {
        int k2;
        for (k2 = 0; k2 < f->code_count; k2++) {
            IrInst *I2 = &f->code[k2];
            int s2;
            if (!(I2->aux & IR_AUX_VOLATILE)) continue;
            if (I2->op != IR_PUSH_VAR && I2->op != IR_STORE &&
                I2->op != IR_PUSH_ADDR)
                continue;
            s2 = sr_slot(&nslots, (int)I2->val);
            if (s2 >= 0) sr_slots[s2].taint = 1;
        }
    }
    if (nslots == 0) return;
    /* A function with a frame pointer prints "MOV r6, sp" right after the
     * callee-saved PUSH, whatever list that PUSH names -- __naked functions and
     * leaf helpers without a frame have neither, and are left alone.  (The
     * saved list here is not rewritten, so unlike -fopt-regalloc this pass does
     * not care whether it starts at r5.) */
    {
        int have_frame = 0;
        for (i = 0; i < nlines; i++) {
            int len = sr_ll[i];
            if (len < (int)sizeof(line) - 1) {
                for (k = 0; k < len; k++) line[k] = b->buf[sr_ptr[i] + k];
                line[len] = 0;
                if (line[0] == ' ' && line[1] == ' ' && line[2] == ' ' &&
                    line[3] == ' ' && strncmp(line + 4, "MOV r6, ", 8) == 0)
                    have_frame = 1;
            }
        }
        if (!have_frame) return;
    }

    /* Pass 2: decide what can go.  R1 needs "r0 holds slot o"; R2 needs the
     * store to be unobservable. */
    {
        static unsigned char valid[SR_MAX_SLOTS];
        static int pending[SR_MAX_SLOTS];
        for (i = 0; i < nslots; i++) { valid[i] = 0; pending[i] = -1; }
        for (i = 0; i < nlines; i++) {
            int lk = sr_lk[i];
            int s = sr_lo[i];
            if (lk == 3) {
                for (k = 0; k < nslots; k++) { valid[k] = 0; pending[k] = -1; }
            } else if (lk == 1) {
                if (sr_slots[s].taint) { valid[s] = 0; continue; }
                if (valid[s]) { sr_drop[i] = 1; continue; }
                for (k = 0; k < nslots; k++) valid[k] = 0;
                valid[s] = 1;
                pending[s] = -1;                 /* the store is observable */
            } else if (lk == 2) {
                if (sr_slots[s].taint) {
                    /* Never selected: the line is only labelled when the slot
                     * was clean at the time it was scanned, and a later mention
                     * in another shape taints it. */
                    sr_drop[i] = 0;
                    valid[s] = 0;
                    continue;
                }
                if (sr_slots[s].reads == 0 && !sr_slots[s].indirect) {
                    /* Nothing in the whole function loads this slot, and no
                     * escaped frame address reaches it, so no store to it can
                     * ever be observed. */
                    sr_drop[i] = 1;
                    valid[s] = 0;
                    continue;
                }
                if (pending[s] >= 0) sr_drop[pending[s]] = 1;
                pending[s] = i;
                /* r0 now holds *this* slot's value and nothing else, so every
                 * other slot loses its claim.  (Keeping them was the bug that
                 * let "r0 already holds slot 0" survive a load of slot 96 in
                 * between: the load is a legitimate access, not a mention in
                 * an unmodelled shape, so nothing else cleared it.) */
                for (k = 0; k < nslots; k++) valid[k] = 0;
                valid[s] = 1;
            } else if (lk == 4 || lk == 6) {
                /* r0 lost the cached value (6) or the frame pointer itself was
                 * just set up (4).  A pending store is still a store: keep it. */
                for (k = 0; k < nslots; k++) valid[k] = 0;
            }
        }
    }

    /* Pass 3: rebuild. */
    asmbuf_init(&out);
    for (i = 0; i < nlines; i++) {
        int len = sr_ll[i];
        if (sr_drop[i]) continue;
        for (k = 0; k < len; k++) asmbuf_putc(&out, b->buf[sr_ptr[i] + k]);
        asmbuf_putc(&out, '\n');
    }
    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 <= b->cap) {
        for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
        b->buf[from + out.len] = 0;
        b->len = from + out.len;
    }
}
#endif /* ARKCC_FEATURE_OPT_SLOTREG */
#if ARKCC_FEATURE_OPT_LDHOIST
/* ------------------ S12-1: same-address load hoisting ---------------------
 * The reference model expands a chain of nested `?:` over the same lvalue into
 * one compare per level, and every level reloads the compared value:
 *
 *     LDR r0, [r8, #0]        ; hdma->Instance, once per level
 *     LDR r7, .Llit_2_0_6
 *     CMP r0, r7
 *     BNE .Lnext
 *     MOVW r0, #2048          ; the per-level result constant
 *     B .Ljoin
 *   .Lnext:
 *     LDR r0, [r8, #0]        ; ... and again
 *
 * HAL_DMAEx_MultiBufferStart_IT carries nineteen of these levels: 254
 * redundant loads in one function.  A local peephole cannot remove them --
 * each level's `MOV r0, #k` overwrites the register that held the value, which
 * is why the emission-level ceiling in docs/EXPR_MODEL.md S11-1 was only 1.01%.
 * What removes them is picking a register the function never names, loading
 * once into it, and letting the compares read that register.
 *
 * The rules are frozen in docs/EXPR_MODEL.md S12-1 and are implemented here
 * verbatim:
 *   1. a candidate is `LDR Rd, [Rb, #imm]`; widths are never mixed;
 *   2. the dedicated register D is the lowest of r4..r11 that the whole
 *      function never names (read, written, or listed in a PUSH/POP);
 *   3. the function must have one frame `PUSH {..., lr}` and every exit must
 *      be a `POP {..., pc}` restoring exactly the same set; D is added to all
 *      of them, plus one pad register when the parity demands it, so that sp
 *      stays 8-byte aligned (AAPCS) without touching the frame size;
 *   4. a region runs forward from a candidate load and ends at the first of:
 *      a write to D (impossible -- D is unnamed), a possibly-aliasing store, a
 *      call, a write to Rb, or a label with more than one predecessor;
 *   5. every later load of the same `(Rb, #imm)` inside the region is deleted;
 *      the uses of its destination, up to the next write of that destination,
 *      must be one of `CMP Rd,Rn` / `CMP Rn,Rd` / `MOV Rn2,Rd`, and its Rd
 *      becomes D there;
 *   6. the first candidate becomes `LDR D, [Rb, #imm]` and its uses are
 *      rewritten the same way -- no instruction is ever added anywhere;
 *   7. a deleted load whose destination is still read outside the region
 *      disqualifies the whole region.  The implementation only ever relies on
 *      "a write inside the region killed the old value"; it never infers
 *      liveness from the listing.
 * Anything not provable declines with a named reason and leaves the text as it
 * was.  Registered, off by default: docs/EXPR_MODEL.md S12-1.
 */
#define LDH_MAX_LINES   PP_MAX_LINES
#define LDH_MAX_LABELS  2048
#define LDH_LAB_LEN     72

static int      ldh_n;
static int      ldh_ls[LDH_MAX_LINES], ldh_ll[LDH_MAX_LINES];
static cp_ins   ldh_iv[LDH_MAX_LINES];
static unsigned char ldh_kd[LDH_MAX_LINES];   /* 0 other, 1 insn, 2 label */
static int      ldh_lidx[LDH_MAX_LINES];      /* label table index, else -1 */
static char     ldh_lname[LDH_MAX_LABELS][LDH_LAB_LEN];
static int      ldh_lat[LDH_MAX_LABELS];      /* line index of the label text */
static int      ldh_lhit[LDH_MAX_LABELS];     /* branches targeting it */
static int      ldh_ltgt[LDH_MAX_LABELS];     /* line of the last such branch */
static int      ldh_lpred[LDH_MAX_LABELS];    /* its single predecessor block  */
static int      ldh_nlab;
static unsigned char ldh_drop[LDH_MAX_LINES];
static unsigned char ldh_rep[LDH_MAX_LINES];  /* operand index + 1 */
static unsigned   ldh_pmask[LDH_MAX_LINES];   /* widened PUSH/POP mask, 0 = none */
static unsigned char ldh_plan_drop[LDH_MAX_LINES];
static unsigned char ldh_plan_rep[LDH_MAX_LINES];
static int      ldh_touched[LDH_MAX_LINES];
static int      ldh_ntouch;                   /* entries used in ldh_touched */
static int      ldh_dr;                       /* dedicated register D (r4..r11) */

/* `[rN, #imm]` or `[rN]` and nothing else -> base register and byte offset. */
static int ldh_mem(const char *s, int *rb, int *imm) {
    int i = 1, r = 0, v = 0;
    if (s[0] != '[' || s[i] != 'r') return 0;
    i++;
    if (s[i] < '0' || s[i] > '9') return 0;
    while (s[i] >= '0' && s[i] <= '9') { r = r * 10 + (s[i] - '0'); i++; }
    if (r > 15) return 0;
    if (s[i] == ']') {
        if (s[i + 1]) return 0;
        *rb = r; *imm = 0;
        return 1;
    }
    if (s[i] != ',' || s[i + 1] != ' ' || s[i + 2] != '#') return 0;
    i += 3;
    if (s[i] < '0' || s[i] > '9') return 0;
    while (s[i] >= '0' && s[i] <= '9') { v = v * 10 + (s[i] - '0'); i++; }
    if (s[i] != ']' || s[i + 1]) return 0;
    *rb = r; *imm = v;
    return 1;
}

/* A load this pass may hoist: one destination, a plain `[rN, #imm]` operand
 * with a base that is neither sp nor the destination, and an offset the
 * far-offset fixer below cannot rewrite into extra instructions. */
static int ldh_is_load(const cp_ins *o, int *rd, int *rb, int *imm) {
    if (strncmp(o->mn, "LDR", 3) != 0) return 0;
    if (o->nops != 2) return 0;           /* LDRD and writeback forms: no */
    if (!cp_reg(o->op[0], rd)) return 0;
    if (!ldh_mem(o->op[1], rb, imm)) return 0;
    if (*rd < 0 || *rb < 0 || *rd > 12 || *rb > 12) return 0;
    if (*rb == *rd) return 0;
    if (*imm > 4095) return 0;
    return 1;
}

/* A store that could alias any address: everything that writes memory except
 * PUSH, whose slot is always below sp and therefore below every frame-relative
 * or heap address this pass can name. */
static int ldh_is_store(const cp_ins *o) {
    const char *m = o->mn;
    if (!strncmp(m, "STR", 3) || !strncmp(m, "STM", 3)) return 1;
    if (!strncmp(m, "VSTR", 4) || !strncmp(m, "VSTM", 4)) return 1;
    return 0;
}

/* Does control fall through from the item at line j into the next one? */
static int ldh_falls(int j) {
    unsigned rd, wr;
    int k;
    if (ldh_kd[j] != 1) return 1;
    k = lv_branch_kind(ldh_iv[j].mn);
    if (k == 1 || k == 4) return 0;       /* B, BX: no fall-through */
    lv_rw(&ldh_iv[j], &rd, &wr);
    if (wr & lv_bit(15)) return 0;        /* POP {..pc}, MOV pc, .., LDM ..,pc */
    return 1;
}

static int ldh_labfind(const char *name) {
    int i;
    for (i = 0; i < ldh_nlab; i++)
        if (!strcmp(ldh_lname[i], name)) return i;
    return -1;
}

/* The label a branch targets, or -1 if it cannot be resolved exactly. */
static int ldh_target(const cp_ins *o) {
    int q;
    for (q = 0; q < o->nops; q++) {
        const char *p = o->op[q];
        if (!p[0] || p[0] == '#' || p[0] == '[' || p[0] == '{') continue;
        if (p[0] >= '0' && p[0] <= '9') continue;
        if (lv_regs(p)) continue;
        return ldh_labfind(p);
    }
    return -1;
}

/* Can this label be crossed without letting control enter the region from
 * outside?  Exactly one branch targets it, and that branch is either the item
 * immediately before it (so the fall-through is the branch's own) or the item
 * before it does not fall through.  Either way the only predecessor block is
 * the branch itself, which is recorded in ldh_lpred. */
static int ldh_safe_cross(int L) {
    int b, p, j;
    if (ldh_lhit[L] != 1) return 0;
    b = ldh_ltgt[L];
    p = -1;
    for (j = ldh_lat[L] - 1; j >= 0; j--)
        if (ldh_kd[j] == 1) { p = j; break; }
    if (p < 0) return 0;
    if (p != b && ldh_falls(p)) return 0;
    ldh_lpred[L] = b;
    return 1;
}

/* Is a read of rd2 by this instruction one of the three frozen shapes?  The
 * return value is the operand to rewrite, or -1 for "not one of them". */
static int ldh_shape(const cp_ins *o, int rd2) {
    int a = -1, b = -1;
    if (!strcmp(o->mn, "CMP") && o->nops == 2) {
        if (!cp_reg(o->op[0], &a) || !cp_reg(o->op[1], &b)) return -1;
        if (a == rd2 && b != rd2) return 0;
        if (b == rd2 && a != rd2) return 1;
        return -1;
    }
    if (!strcmp(o->mn, "MOV") && o->nops == 2) {
        if (!cp_reg(o->op[1], &b)) return -1;
        if (b == rd2 && !cp_mentions(o->op[0], rd2)) return 1;
        return -1;
    }
    return -1;
}

/* Plan one line.  1 = accepted (or already planned the same way), 0 = clash. */
static int ldh_put(int line, int drop, int opi) {
    if (drop) {
        if (ldh_plan_drop[line]) return 1;
        if (ldh_plan_rep[line]) return 0;
        ldh_plan_drop[line] = 1;
    } else {
        if (ldh_plan_rep[line]) return ldh_plan_rep[line] == (unsigned char)(opi + 1);
        if (ldh_plan_drop[line]) return 0;
        ldh_plan_rep[line] = (unsigned char)(opi + 1);
    }
    ldh_touched[ldh_ntouch++] = line;
    return 1;
}

/* `{r4, r5, lr}` -> ordered array.  -1 if the list is not modelled exactly. */
static int ldh_list(const char *s, int *regs) {
    int i = 1, n = 0;
    if (s[0] != '{') return -1;
    for (;;) {
        while (s[i] == ' ' || s[i] == '\t') i++;
        if (s[i] == '}') { i++; break; }
        if (!s[i]) return -1;
        if (!strncmp(s + i, "lr", 2) && !(s[i + 2] >= 'a' && s[i + 2] <= 'z') &&
            !(s[i + 2] >= '0' && s[i + 2] <= '9') && s[i + 2] != '_') {
            regs[n++] = 14; i += 2;
        } else if (!strncmp(s + i, "pc", 2) && !(s[i + 2] >= 'a' && s[i + 2] <= 'z') &&
                   !(s[i + 2] >= '0' && s[i + 2] <= '9') && s[i + 2] != '_') {
            regs[n++] = 15; i += 2;
        } else if (s[i] == 'r' && s[i + 1] >= '0' && s[i + 1] <= '9') {
            int v = s[i + 1] - '0';
            i += 2;
            if (s[i] >= '0' && s[i] <= '9') { v = v * 10 + (s[i] - '0'); i++; }
            if (v > 15) return -1;
            regs[n++] = v;
        } else {
            return -1;
        }
        if (n > 15) return -1;
        while (s[i] == ' ' || s[i] == '\t') i++;
        if (s[i] == ',') { i++; continue; }
        if (s[i] == '}') { i++; break; }
        return -1;
    }
    if (s[i]) return -1;
    return n;
}

/* Rebuild an instruction with operand k replaced by r. */
static void ldh_emit_rep(AsmBuffer *out, const cp_ins *o, int k, int r) {
    char tmp[8];
    int q;
    snprintf(tmp, sizeof tmp, "r%d", r);
    asmbuf_puts(out, "    ");
    asmbuf_puts(out, o->mn);
    asmbuf_puts(out, " ");
    for (q = 0; q < o->nops; q++) {
        if (q) asmbuf_puts(out, ", ");
        asmbuf_puts(out, (q == k) ? tmp : o->op[q]);
    }
    asmbuf_putc(out, '\n');
}

/* Rebuild a PUSH/POP brace list from a mask, ascending (the order the emitter
 * and both widening passes use, and the order that keeps PUSH and POP paired). */
static void ldh_emit_list(AsmBuffer *out, const char *mn, unsigned mask) {
    int r, first = 1;
    asmbuf_puts(out, "    ");
    asmbuf_puts(out, mn);
    asmbuf_puts(out, " {");
    for (r = 0; r < 16; r++) {
        char tmp[8];
        if (!(mask & lv_bit(r))) continue;
        if (!first) asmbuf_puts(out, ", ");
        first = 0;
        if (r == 13) { asmbuf_puts(out, "sp"); continue; }
        if (r == 14) { asmbuf_puts(out, "lr"); continue; }
        if (r == 15) { asmbuf_puts(out, "pc"); continue; }
        snprintf(tmp, sizeof tmp, "r%d", r);
        asmbuf_puts(out, tmp);
    }
    asmbuf_puts(out, "}\n");
}

static void ark_ldhoist_function(AsmBuffer *b, int from) {
    int i, j, n, del = 0;
    int ipush = -1, iframe = -1, fbytes = 0, kadd = 0, pad = -1;
    unsigned pushmask = 0, usedmask = 0;
    int regs[16], nregs, exmask = 0, nexits = 0, nfree = 0, freereg[8];
    AsmBuffer out;

    n = pp_split_lines(b, from, ldh_ls, ldh_ll, LDH_MAX_LINES);
    if (n <= 0) return;
    ldh_n = n;
    ldh_nlab = 0;
    for (i = 0; i < n; i++) {
        char t[256];
        int L;
        ldh_kd[i] = 0;
        ldh_lidx[i] = -1;
        ldh_drop[i] = 0; ldh_rep[i] = 0; ldh_pmask[i] = 0;
        ldh_plan_drop[i] = 0; ldh_plan_rep[i] = 0;
        if (ldh_ll[i] >= (int)sizeof t) return;      /* too long: leave it alone */
        if (pp_trim(b->buf + ldh_ls[i], ldh_ll[i], t, sizeof t) < 0) return;
        if (!t[0] || t[0] == ';' || t[0] == '@') continue;
        L = ark_strlen(t);
        if (L > 0 && t[L - 1] == ':') {
            if (ldh_nlab >= LDH_MAX_LABELS) return;
            if (L - 1 >= LDH_LAB_LEN) return;
            for (j = 0; j < L - 1; j++) ldh_lname[ldh_nlab][j] = t[j];
            ldh_lname[ldh_nlab][L - 1] = 0;
            ldh_lidx[i] = ldh_nlab;
            ldh_lat[ldh_nlab] = i;
            ldh_lhit[ldh_nlab] = 0;
            ldh_ltgt[ldh_nlab] = -1;
            ldh_lpred[ldh_nlab] = -1;
            ldh_nlab++;
            ldh_kd[i] = 2;
            continue;
        }
        if (t[0] == '.') continue;
        if (cp_parse(t, &ldh_iv[i])) ldh_kd[i] = 1;
    }

    /* Branch targets: count the branches that name each label. */
    for (i = 0; i < n; i++) {
        int k, L;
        if (ldh_kd[i] != 1) continue;
        k = lv_branch_kind(ldh_iv[i].mn);
        if (k != 1 && k != 2) continue;
        L = ldh_target(&ldh_iv[i]);
        if (L < 0) continue;
        ldh_lhit[L]++;
        ldh_ltgt[L] = i;
    }

    /* The frame save: one `PUSH {.., lr}` as the first instruction, then the
     * frame drop and `MOV r6, sp`.  Anything else (variadic, __naked, a body
     * that builds sp by hand) is not the shape this pass may widen. */
    for (i = 0; i < n; i++) {
        int cnt;
        if (ldh_kd[i] != 1) continue;
        if (strcmp(ldh_iv[i].mn, "PUSH") || ldh_iv[i].nops != 1) return;
        cnt = ldh_list(ldh_iv[i].op[0], regs);
        if (cnt < 2) return;
        for (j = 0; j < cnt; j++) {
            if (j && regs[j] <= regs[j - 1]) return;   /* not ascending: refuse */
            pushmask |= lv_bit(regs[j]);
        }
        if (regs[cnt - 1] != 14) return;               /* must end in lr */
        if (!(pushmask & lv_bit(5)) || !(pushmask & lv_bit(6)) ||
            !(pushmask & lv_bit(7))) return;
        ipush = i;
        nregs = cnt;
        break;
    }
    if (ipush < 0) return;
    /* frame bytes: `SUB sp, sp, #N` then `MOV r6, sp` */
    for (i = ipush + 1; i < n && iframe < 0; i++) {
        if (ldh_kd[i] != 1) continue;
        if (!strcmp(ldh_iv[i].mn, "SUB") && ldh_iv[i].nops == 3 &&
            !strcmp(ldh_iv[i].op[0], "sp") && !strcmp(ldh_iv[i].op[1], "sp")) {
            const char *p = ldh_iv[i].op[2];
            if (p[0] != '#') return;
            fbytes = 0; p++;
            if (!*p) return;
            while (*p >= '0' && *p <= '9') { fbytes = fbytes * 10 + (*p - '0'); p++; }
            if (*p) return;
            continue;
        }
        if (!strcmp(ldh_iv[i].mn, "MOV") && ldh_iv[i].nops == 2 &&
            !strcmp(ldh_iv[i].op[0], "r6") && !strcmp(ldh_iv[i].op[1], "sp")) {
            iframe = i;
            break;
        }
        return;                                  /* unexpected prologue shape */
    }
    if (iframe < 0) return;
    if (fbytes & 3) return;

    /* Every exit must be a `POP {.., pc}` restoring exactly the saved set. */
    for (i = 0; i < n; i++) {
        int cnt;
        unsigned m = 0;
        if (ldh_kd[i] != 1) continue;
        if (strcmp(ldh_iv[i].mn, "POP") || ldh_iv[i].nops != 1) continue;
        cnt = ldh_list(ldh_iv[i].op[0], regs);
        if (cnt < 1) return;
        for (j = 0; j < cnt; j++) {
            if (j && regs[j] <= regs[j - 1]) return;
            m |= lv_bit(regs[j]);
        }
        if (!(m & lv_bit(15))) continue;               /* value-stack pop: not an exit */
        if (regs[cnt - 1] != 15) return;
        if ((m & ~lv_bit(15)) != (pushmask & ~lv_bit(14))) return;
        ldh_pmask[i] = m;
        exmask |= m;
        nexits++;
    }
    if (nexits == 0) return;

    /* Registers the function names anywhere. */
    for (i = 0; i < n; i++) {
        int q;
        if (ldh_kd[i] != 1) continue;
        for (q = 0; q < ldh_iv[i].nops; q++) usedmask |= lv_regs(ldh_iv[i].op[q]);
    }
    for (j = 4; j <= 11; j++)
        if (!(usedmask & lv_bit(j))) freereg[nfree++] = j;
    if (nfree < 1) return;                                 /* ldhoist: no dedicated reg */
    /* Alignment: (nregs + k)*4 + fbytes must be a multiple of 8.  The frame
     * size is never touched, so every r6-relative offset stays valid. */
    {
        int m = ((fbytes % 8) == 4) ? 1 : 0;
        if (((nregs + 1) % 2) == m) kadd = 1;
        else if ((nregs % 2) == m) kadd = 2;
        else return;
    }
    if (nfree < kadd) return;
    ldh_dr = freereg[0];
    if (kadd == 2) pad = freereg[1];

    /* Regions. */
    for (i = 0; i < n; i++) {
        int rd, rb, imm, end, ndelete = 0, ok = 1;
        if (ldh_kd[i] != 1) continue;
        if (!ldh_is_load(&ldh_iv[i], &rd, &rb, &imm)) continue;
        end = n;
        for (j = i + 1; j < n; j++) {
            unsigned rr, ww;
            int k;
            if (ldh_kd[j] == 2) {
                int L = ldh_lidx[j];
                if (L < 0 || !ldh_safe_cross(L)) { end = j; break; }
                continue;
            }
            if (ldh_kd[j] != 1) continue;
            if (ldh_is_store(&ldh_iv[j])) { end = j; break; }
            k = lv_branch_kind(ldh_iv[j].mn);
            if (k == 3 || k == 4) { end = j; break; }
            lv_rw(&ldh_iv[j], &rr, &ww);
            if (ww & lv_bit(rb)) { end = j; break; }
        }
        if (end <= i + 1) continue;
        /* Every branch inside must stay inside, jump out, or reach a label
         * whose only predecessor is a branch inside the region. */
        for (j = i + 1; j < end && ok; j++) {
            int k, L;
            if (ldh_kd[j] != 1) continue;
            k = lv_branch_kind(ldh_iv[j].mn);
            if (k != 1 && k != 2) continue;
            L = ldh_target(&ldh_iv[j]);
            if (L < 0) { ok = 0; break; }
            if (ldh_lat[L] <= i) { ok = 0; break; }
            if (ldh_lat[L] >= end) continue;
            if (ldh_lhit[L] != 1) { ok = 0; break; }
            if (ldh_lpred[L] <= i || ldh_lpred[L] >= end) { ok = 0; break; }
        }
        if (!ok) continue;
        /* Plan: retarget the anchor, delete every later load of the same
         * address, and rewrite each one's consumer chain onto D. */
        ldh_ntouch = 0;
        for (j = i; j < end && ok; j++) {
            int rd2, rb2, imm2, q, killed = 0;
            if (ldh_kd[j] != 1) continue;
            if (!ldh_is_load(&ldh_iv[j], &rd2, &rb2, &imm2)) continue;
            if (rb2 != rb || imm2 != imm) continue;
            if (strcmp(ldh_iv[j].mn, ldh_iv[i].mn)) continue;
            for (q = j + 1; q < end; q++) {
                unsigned rr, ww;
                int k;
                if (ldh_kd[q] != 1) continue;
                lv_rw(&ldh_iv[q], &rr, &ww);
                if (rr & lv_bit(rd2)) {
                    k = ldh_shape(&ldh_iv[q], rd2);
                    if (k < 0 || (ww & lv_bit(rd2))) { ok = 0; break; }
                    if (!ldh_put(q, 0, k)) { ok = 0; break; }
                    continue;
                }
                if (ww & lv_bit(rd2)) { killed = 1; break; }
            }
            if (!ok) break;
            if (!killed) { ok = 0; break; }      /* rule 7: no write in region */
            if (j == i) {
                if (!ldh_put(j, 0, 0)) { ok = 0; break; }
            } else {
                if (!ldh_put(j, 1, 0)) { ok = 0; break; }
                ndelete++;
            }
        }
        if (!ok || ndelete == 0) {
            while (ldh_ntouch > 0) {
                int ln = ldh_touched[--ldh_ntouch];
                ldh_plan_drop[ln] = 0;
                ldh_plan_rep[ln] = 0;
            }
            continue;
        }
        while (ldh_ntouch > 0) {
            int ln = ldh_touched[--ldh_ntouch];
            ldh_drop[ln] = ldh_plan_drop[ln];
            ldh_rep[ln] = ldh_plan_rep[ln];
            ldh_plan_drop[ln] = 0;
            ldh_plan_rep[ln] = 0;
        }
        del += ndelete;
        i = end - 1;
    }
    if (del == 0) return;

    asmbuf_init(&out);
    for (j = 0; j < n; j++) {
        if (ldh_drop[j]) continue;
        if (j == ipush || ldh_pmask[j]) {
            unsigned m = ldh_pmask[j] ? ldh_pmask[j] : pushmask;
            m |= lv_bit(ldh_dr);
            if (pad >= 0) m |= lv_bit(pad);
            ldh_emit_list(&out, ldh_iv[j].mn, m);
            continue;
        }
        if (ldh_rep[j]) {
            ldh_emit_rep(&out, &ldh_iv[j], ldh_rep[j] - 1, ldh_dr);
            continue;
        }
        pp_copy_line(&out, b->buf + ldh_ls[j], ldh_ll[j]);
    }
    pp_splice(b, from, &out);
}
#endif /* ARKCC_FEATURE_OPT_LDHOIST */


#if ARKCC_FEATURE_OPT_VSTACK
/* ------------------- value stack -> register allocation -------------------
 * What this is: the IR is a stack machine, so the emitter spells every value
 * that has to survive across another computation as a real memory round trip:
 *
 *      LDR r0, [r6, #24]      ; a
 *      PUSH {r0}
 *      LDR r0, [r6, #8]       ; b
 *      PUSH {r0}
 *      POP {r1}               ; r1 = b
 *      POP {r0}               ; r0 = a
 *      ADD r0, r0, r1
 *
 * Two of every three instructions in such a chain are stack traffic, and on
 * the benchmark corpus (18 small embedded functions) PUSH+POP were 50% of the
 * whole function.  This pass keeps the value stack in registers instead:
 *
 *      LDR r5, [r6, #24]      ; a     (producer retargeted to the pool)
 *      LDR r7, [r6, #8]       ; b
 *      ADD r0, r5, r7         ; consumer reads the pool directly
 *
 * How it is safe.  This is a text pass over an already emitted function, with
 * a shadow model of the value stack (`skind`/`spool`) and of what each
 * register currently holds (`pend` = "rN holds pool slot k").  A value still
 * on the shadow stack at a label, a call or a branch is *pinned*: the
 * `PUSH {rN}` that created it is emitted for real, so the machine stack is
 * word for word the unoptimised one on every path into the boundary (a local
 * label such as `.L3:` counts as a label, not as a directive), the register
 * mappings are flushed, and the block after the boundary is optimised again
 * from an empty register state.
 *
 * A line whose shape is not in the table below, a multi-register PUSH/POP
 * that is not the prologue/epilogue, or a "[sp" access ends the rewrite at
 * that line: every value still in a pool register is pushed in stack order,
 * the pending register copies are spelled out, and the rest of the function
 * is copied through verbatim, so what was already rewritten is kept.  (That
 * needs the words already in memory to sit *below* the pooled ones; any other
 * shape, and a survey hit before the first line, still abandons the whole
 * function.)  A function can therefore never come out larger than it did
 * before the pass, and the worst case of a bug is "the pass declines", never
 * "the pass emits a wrong instruction".
 *
 * The pool is r5 and r7: the prologue already saves them for every function
 * (`PUSH {r5, r6, r7, lr}`), so using them costs zero extra frame bytes and
 * cannot disturb any frame offset.  A function that names r5 or r7 in its body
 * (struct-by-value and long-long return paths do) simply drops it from the
 * pool; if both are taken the pass still runs the PUSH/POP-pair peephole.
 *
 * The producer retarget (writing the pool register instead of r0) is only
 * taken when r0 is provably dead afterwards: the scan stops at the first
 * mention of r0 and only retargets when that mention is a write.  That is what
 * keeps `IR_DUP` (`PUSH {r0}` with the copy deliberately left in r0) correct.
 *
 * The pool is two registers by default (r5, r7).  When the body keeps three or
 * more values alive at once, the survey adds r4 -- this code generator never
 * uses it -- and the frame grows by the same word so sp stays 8-byte aligned.
 *
 * Cost, measured on the STM32F4 HAL corpus: see docs/RA_VSTACK.md.
 */
#define VS_MAX_POOL   3
#define VS_MAX_DEPTH  256
#define VS_MAX_OP     6
#define VS_OPLEN      96
#define VS_MAX_REG    16

enum {
    VS_F_NONE = 0,   /* no data effect: NOP, .loc, IT, sev ...                 */
    VS_F_W0R12,      /* Rd, Rn, Rm          : read 1,2   write 0               */
    VS_F_RW0R1,      /* Rd, Rm       (2-op) : read 0,1   write 0               */
    VS_F_W0R1,       /* Rd, Rm              : read 1     write 0               */
    VS_F_W0,         /* Rd, #imm            :            write 0               */
    VS_F_R01,        /* Rn, Rm / Rn, #imm   : read 0,1   (nothing written)     */
    VS_F_STR,        /* Rt, [Rn, #imm]      : read 0,1                         */
    VS_F_LDR,        /* Rt, [Rn, #imm]      : read 1     write 0               */
    VS_F_CALL,       /* BL / BLX            : barrier                          */
    VS_F_BRANCH,     /* B / Bcc / BX        : barrier                          */
    VS_F_IT          /* IT / ITE            : barrier for pending aliases       */
};

typedef struct {
    char *t;    /* line text, '\n' stripped, owned by the memory pool */
    int   del;  /* removed by the PUSH/POP-pair peephole */
    int   cross;/* value is still on the shadow stack at a label/branch/call:
                 * it must stay in memory so the machine state matches the
                 * original on every path into that boundary */
    const char *after; /* one extra line emitted immediately after this one
                 * (NULL = none).  Only the r4 prologue uses it: a frame-less
                 * function has no SUB/ADD sp, sp, #N to grow, so the 4-byte
                 * realignment after the bigger PUSH has to be inserted. */
} VsLine;

static int vs_streq(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}

static int vs_isdigit(char c) { return c >= '0' && c <= '9'; }

static int vs_isalnum(char c) {
    return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

static void vs_trim(char *s) {
    char *p = s;
    int n;
    while (*p == ' ' || *p == '\t') p++;
    if (p != s) {
        char *d = s;
        while (*p) *d++ = *p++;
        *d = 0;
    }
    n = (int)strlen(s);
    while (n > 0 && (s[n-1] == ' ' || s[n-1] == '\t' || s[n-1] == '\r')) s[--n] = 0;
}

/* Strip the "{...}" of a PUSH/POP operand list so "PUSH {r0}" and
 * "POP {r5, r6, r7, pc}" both end up with a bare register list. */
static void vs_unbrace(char *s) {
    int n, i;
    vs_trim(s);
    n = (int)strlen(s);
    if (n >= 2 && s[0] == '{' && s[n-1] == '}') {
        for (i = 1; i < n - 1; i++) s[i-1] = s[i];
        s[n-2] = 0;
        vs_trim(s);
    }
}

/* Split one line into mnemonic + comma separated operands (commas inside
 * "[...]" or "{...}" do not separate).  Returns 0 for a blank line. */
static int vs_parse(const char *line, char *mn, int mn_sz,
                    char ops[VS_MAX_OP][VS_OPLEN], int *nops,
                    int *is_dot, int *is_label)
{
    const char *p = line;
    int i;

    *nops = 0;
    *is_dot = 0;
    *is_label = 0;
    mn[0] = 0;
    while (*p == ' ' || *p == '\t') p++;
    if (!*p || *p == '\r') return 0;
    if (*p == '.') *is_dot = 1;
    {
        const char *e = p + strlen(p);
        while (e > p && (e[-1] == ' ' || e[-1] == '\t' || e[-1] == '\r')) e--;
        if (e > p && e[-1] == ':') { *is_label = 1; return 1; }
    }
    i = 0;
    while (*p && *p != ' ' && *p != '\t' && *p != '\r' && i < mn_sz - 1) mn[i++] = *p++;
    mn[i] = 0;
    while (*p == ' ' || *p == '\t') p++;
    while (*p && *p != '\r' && *nops < VS_MAX_OP) {
        int j = 0, br = 0;
        while (*p && *p != '\r') {
            if (*p == '[' || *p == '{') br++;
            else if (*p == ']' || *p == '}') br--;
            else if (*p == ',' && br == 0) break;
            if (j < VS_OPLEN - 1) ops[*nops][j++] = *p;
            p++;
        }
        ops[*nops][j] = 0;
        vs_trim(ops[*nops]);
        (*nops)++;
        if (*p == ',') p++;
        while (*p == ' ' || *p == '\t') p++;
    }
    if ((vs_streq(mn, "PUSH") || vs_streq(mn, "POP")) && *nops > 0)
        vs_unbrace(ops[0]);
    return 1;
}

/* Length of the "r<digits>" token at s, and its number; 0 if there is none. */
static int vs_regtok(const char *s, int *reg) {
    int i = 1, v = 0, n = 0;
    if (s[0] != 'r') return 0;
    if (!vs_isdigit(s[i])) return 0;
    while (vs_isdigit(s[i])) { v = v * 10 + (s[i] - '0'); i++; n++; }
    if (n > 2 || v >= VS_MAX_REG) return 0;
    *reg = v;
    return i;
}

static int vs_isboundary(char c) {
    return !(vs_isalnum(c) || c == '_' || c == '.');
}

/* Does this text mention register `reg` as a whole token? */
static int vs_txt_has(const char *s, int reg) {
    int i = 0;
    while (s[i]) {
        int r, n;
        int bnd = (i == 0) || vs_isboundary(s[i-1]);
        if (bnd && (n = vs_regtok(s + i, &r)) > 0) {
            char after = s[i + n];
            if (!(vs_isalnum(after) || after == '_')) {
                if (r == reg) return 1;
            }
            i += n;
            continue;
        }
        i++;
    }
    return 0;
}

/* Replace the whole-token mention of `reg` with a two-character register
 * name.  Only reg < 10, so the length never changes. */
static void vs_subst(char *s, int reg, const char *name2) {
    int i = 0;
    if (reg >= 10) return;
    while (s[i]) {
        int r, n;
        int bnd = (i == 0) || vs_isboundary(s[i-1]);
        if (bnd && (n = vs_regtok(s + i, &r)) > 0) {
            char after = s[i + n];
            if (!(vs_isalnum(after) || after == '_')) {
                if (r == reg) { s[i] = name2[0]; s[i+1] = name2[1]; return; }
            }
            i += n;
            continue;
        }
        i++;
    }
}

static int vs_whole_reg(const char *s, int *reg) {
    int n = vs_regtok(s, reg);
    return (n > 0 && s[n] == 0);
}

static void vs_rname(int reg, char *buf) {
    if (reg >= 10) {
        buf[0] = 'r'; buf[1] = (char)('0' + reg / 10);
        buf[2] = (char)('0' + reg % 10); buf[3] = 0;
    } else {
        buf[0] = 'r'; buf[1] = (char)('0' + reg); buf[2] = 0;
    }
}

static int vs_cc_suffix(const char *s) {
    static const char *const cc[] = {
        "EQ", "NE", "CS", "HS", "CC", "LO", "MI", "PL",
        "VS", "VC", "HI", "LS", "GE", "LT", "GT", "LE", "AL", 0
    };
    int i;
    for (i = 0; cc[i]; i++) if (vs_streq(s, cc[i])) return 1;
    return 0;
}

/* ADC / SBC / MUL have no 16-bit three-register form in this assembler:
 * they encode as Rd = Rd <op> Rm and refuse Rd != Rn.  A rewrite that puts
 * the pool register in the Rn slot would therefore make the line
 * unassemblable, so the pass copies the value into its own register there
 * instead of substituting it. */
static int vs_is_inplace3(const char *mn)
{
    char base[12];
    int n = (int)strlen(mn);
    if (n < 3 || n >= (int)sizeof base) return 0;
    memcpy(base, mn, n);
    base[n] = 0;
    if (n > 3 && vs_cc_suffix(base + n - 2)) { base[n - 2] = 0; n -= 2; }
    if (n > 3 && base[n - 1] == 'S') base[n - 1] = 0;
    return vs_streq(base, "ADC") || vs_streq(base, "SBC") ||
           vs_streq(base, "MUL");
}

static int vs_in(const char *m, const char *const *list) {
    int i;
    for (i = 0; list[i]; i++) if (vs_streq(m, list[i])) return 1;
    return 0;
}

static int vs_base_form(const char *m, int nops, char ops[VS_MAX_OP][VS_OPLEN]);

/* Instruction form of a mnemonic, condition suffix included.  Returns
 * VS_F_BAIL for anything this pass must not touch. */
static int vs_form(const char *mn, int nops, char ops[VS_MAX_OP][VS_OPLEN], int *cond)
{
    int n = (int)strlen(mn);
    int k, f;
    int i, j;

    *cond = 0;
    for (k = n - 2; k >= 1; k--) {
        char base[16];
        if (n - k > 4) continue;
        if (k >= (int)sizeof base) continue;
        if (!vs_cc_suffix(mn + k)) continue;
        memcpy(base, mn, k);
        base[k] = 0;
        f = vs_base_form(base, nops, ops);
        if (f >= 0) { *cond = 1; return f; }
    }
    f = vs_base_form(mn, nops, ops);
    if (f >= 0) return f;
    /* Unknown mnemonic: safe only when the line names no data register. */
    for (i = 0; i < nops; i++)
        for (j = 0; j < VS_MAX_REG; j++)
            if (vs_txt_has(ops[i], j)) return -1;
    return VS_F_NONE;
}

static int vs_base_form(const char *m, int nops, char ops[VS_MAX_OP][VS_OPLEN])
{
    static const char *const arith[] = {
        "ADD", "SUB", "RSB", "ADC", "SBC", "AND", "ORR", "EOR", "BIC",
        "LSL", "LSR", "ASR", "ROR", "MUL", "SDIV", "UDIV", 0
    };
    static const char *const movw[] = { "MOVW", "MOVT", 0 };
    static const char *const cmpx[] = { "CMP", "CMN", "TST", "TEQ", 0 };
    static const char *const ldrx[] = { "LDR", "LDRB", "LDRH", "LDRSB", "LDRSH", 0 };
    static const char *const strx[] = { "STR", "STRB", "STRH", 0 };
    static const char *const rw1[]  = { "UXTB", "SXTB", "UXTH", "SXTH", "NEG", "MVN", 0 };
    static const char *const nothing[] = {
        "NOP", "DSB", "ISB", "DMB", "SEV", "WFI", "YIELD",
        "SVC", "CPSID", "CPSIE", "MRS", "MSR", 0
    };
    char low[16];

    if (vs_in(m, arith)) {
        if (nops == 3) return VS_F_W0R12;
        if (nops == 2) return VS_F_RW0R1;
        return -1;
    }
    if (vs_streq(m, "MOV")) {
        if (nops != 2) return -1;
        return (ops[1][0] == '#') ? VS_F_W0 : VS_F_W0R1;
    }
    if (vs_in(m, movw))  return (nops == 2) ? VS_F_W0 : -1;
    if (vs_in(m, cmpx))  return VS_F_R01;
    if (vs_in(m, ldrx))  return (nops == 2 && ops[1][0] == '[') ? VS_F_LDR : VS_F_W0R1;
    if (vs_in(m, strx))  return (nops == 2 && ops[1][0] == '[') ? VS_F_STR : -1;
    if (vs_in(m, rw1))   return (nops == 2) ? VS_F_RW0R1 : -1;
    if (vs_in(m, nothing)) return VS_F_NONE;
    if (vs_streq(m, "BL") || vs_streq(m, "BLX")) return VS_F_CALL;
    if (vs_streq(m, "B")  || vs_streq(m, "BX"))  return VS_F_BRANCH;
    if (m[0] == 'I' && m[1] == 'T' && nops <= 1) return VS_F_IT;
    /* "ADDS"/"SUBS"/"LSLS"/"MOVS" ... : the S is a flag-setter, not a suffix
     * we model, so retry with it removed. */
    {
        int n = (int)strlen(m);
        if (n > 1 && m[n-1] == 'S' && n < (int)sizeof low) {
            memcpy(low, m, n - 1);
            low[n-1] = 0;
            if (vs_in(low, arith) || vs_streq(low, "MOV") ||
                vs_in(low, cmpx) || vs_in(low, rw1)) {
                int f = vs_base_form(low, nops, ops);
                if (f >= 0) return f;
            }
        }
    }
    return -1;
}

static void vs_masks(int form, int nops, int *rmask, int *wmask) {
    int i;
    for (i = 0; i < VS_MAX_OP; i++) { rmask[i] = 0; wmask[i] = 0; }
    switch (form) {
    case VS_F_W0R12:
        if (nops > 0) wmask[0] = 1;
        if (nops > 1) rmask[1] = 1;
        if (nops > 2) rmask[2] = 1;
        break;
    case VS_F_RW0R1:
        if (nops > 0) { rmask[0] = 1; wmask[0] = 1; }
        if (nops > 1) rmask[1] = 1;
        break;
    case VS_F_W0R1:
        if (nops > 0) wmask[0] = 1;
        if (nops > 1) rmask[1] = 1;
        break;
    case VS_F_W0:
        if (nops > 0) wmask[0] = 1;
        break;
    case VS_F_R01:
        if (nops > 0) rmask[0] = 1;
        if (nops > 1) rmask[1] = 1;
        break;
    case VS_F_STR:
        if (nops > 0) rmask[0] = 1;
        if (nops > 1) rmask[1] = 1;
        break;
    case VS_F_LDR:
        if (nops > 0) wmask[0] = 1;
        if (nops > 1) rmask[1] = 1;
        break;
    default:
        break;
    }
}

static void vs_put_line(AsmBuffer *o, const char *s) {
    asmbuf_puts(o, s);
    asmbuf_putc(o, '\n');
}

static void vs_put_ins(AsmBuffer *o, const char *mn,
                       char ops[VS_MAX_OP][VS_OPLEN], int nops, int *dest_off)
{
    int i;
    if (dest_off) *dest_off = -1;
    asmbuf_puts(o, "    ");
    asmbuf_puts(o, mn);
    for (i = 0; i < nops; i++) {
        asmbuf_puts(o, i == 0 ? " " : ", ");
        if (i == 0 && dest_off) *dest_off = o->len;
        asmbuf_puts(o, ops[i]);
    }
    asmbuf_putc(o, '\n');
}

static int vs_free_pool(const int *busy, int n) {
    int i;
    for (i = 0; i < n; i++) if (!busy[i]) return i;
    return -1;
}

/* One pool slot can be referenced from several places at once: a value
 * stack entry, the register mapping that the PUSH left behind, and the
 * register mapping a POP created.  Releasing the first consumer must not
 * hand the slot to somebody else while another reference is still alive
 * (`POP r0; PUSH r0; PUSH r0` -- a 5..8-byte struct return -- puts the
 * same slot on the stack twice), so slots are reference counted. */
static void vs_ref_add(int p, int *pref, int *pbusy)
{
    pref[p]++;
    pbusy[p] = 1;
}

static void vs_ref_rel(int p, int *pref, int *pbusy)
{
    if (p < 0) return;
    if (--pref[p] <= 0) {
        pref[p] = 0;
        pbusy[p] = 0;
    }
}

static void vs_flush_all(AsmBuffer *o, int *pend, int *pref, int *pbusy,
                         const int *pool) {
    char nm[8];
    int j;
    for (j = 0; j < VS_MAX_REG; j++) {
        if (pend[j] < 0) continue;
        vs_rname(pool[pend[j]], nm);
        asmbuf_puts(o, "    MOV r");
        asmbuf_int(o, j);
        asmbuf_puts(o, ", ");
        asmbuf_puts(o, nm);
        asmbuf_putc(o, '\n');
        vs_ref_rel(pend[j], pref, pbusy);
        pend[j] = -1;
    }
}

/* Every value still on the shadow stack already has its word in memory?
 * Then the machine stack matches the unoptimised code word for word, so a
 * label / call / branch can be crossed: flush the register mappings and copy
 * the rest of the function through unchanged. */
static int vs_all_mem(const int *skind, int depth) {
    int k;
    for (k = 0; k < depth; k++) if (skind[k] != 0) return 0;
    return 1;
}

/* Stop the rewrite in the middle of a function without giving up what has
 * already been emitted.  Before the rest is copied through verbatim the
 * machine stack has to look exactly like the unoptimised one at this
 * point: every value the shadow stack holds only in a pool register is
 * pushed for real, in stack order, and the register mappings are spelled
 * out.  A `POP` in the copied tail then finds its word, and a value read
 * from its register finds the copy.  The optimised prefix stays, so a
 * function can never come out larger than it did before this pass. */
/* Returns 1 when the shadow stack can be restored by pushing the pooled
 * entries on top, i.e. when no word already in memory sits above a pooled
 * one (`00..011..1`).  Any other shape would need the live words to be
 * pulled off and pushed back below the new ones, so the caller gives the
 * whole function up instead -- exactly the old behaviour, never worse. */
static int vs_cut_shape_ok(const int *skind, int depth)
{
    int k, seen_pool = 0;
    for (k = 0; k < depth; k++) {
        if (skind[k] == 1) seen_pool = 1;
        else if (seen_pool) return 0;
    }
    return 1;
}

static void vs_cut_verbatim(AsmBuffer *o, int depth, int *skind,
                            const int *spool, const int *pool,
                            int *pend, int *pref, int *pbusy, int *nmem)
{
    char nm[8];
    int k;
    for (k = 0; k < depth; k++) {
        if (skind[k] != 1) continue;
        vs_rname(pool[spool[k]], nm);
        asmbuf_puts(o, "    PUSH {");
        asmbuf_puts(o, nm);
        asmbuf_puts(o, "}\n");
        skind[k] = 0;              /* the word is in memory from here on */
        (*nmem)++;
    }
    vs_flush_all(o, pend, pref, pbusy, pool);
}

/* Keep the shadow stack exact while a cut tail is copied through.  The
 * cut made every live value a real push, so from there on the machine stack
 * is the unoptimised one and a single-register PUSH/POP is all it takes to
 * stay in step.  Returns 0 for a line this cannot model -- a register list,
 * anything that moves sp, or an instruction the pass does not know -- and the
 * caller then leaves the rest of the function verbatim, exactly as before. */
static int vs_txt_sp(const char *s)
{
    int i = 0;
    while (s[i]) {
        if ((i == 0 || vs_isboundary(s[i-1])) && s[i] == 's' && s[i+1] == 'p' &&
            !(vs_isalnum(s[i+2]) || s[i+2] == '_'))
            return 1;
        i++;
    }
    return 0;
}

static int vs_txt_pc(const char *s)
{
    int i = 0;
    while (s[i]) {
        if ((i == 0 || vs_isboundary(s[i-1])) && s[i] == 'p' && s[i+1] == 'c' &&
            !(vs_isalnum(s[i+2]) || s[i+2] == '_'))
            return 1;
        i++;
    }
    return 0;
}

static int vs_tail_track(const char *t, int *skind, int *pdepth, int *pnmem)
{
    char mn[24];
    char ops[VS_MAX_OP][VS_OPLEN];
    int nops, isdot, islab, f, cnd, j, r = -1;
    int rmask[VS_MAX_OP], wmask[VS_MAX_OP];

    if (!vs_parse(t, mn, sizeof mn, ops, &nops, &isdot, &islab)) return 0;
    if (isdot || islab) return 1;
    if (strncmp(mn, "LDM", 3) == 0 || strncmp(mn, "STM", 3) == 0) return 0;
    if (vs_streq(mn, "PUSH")) {
        if (nops != 1 || !vs_whole_reg(ops[0], &r)) return 0;
        if (*pdepth >= VS_MAX_DEPTH) return 0;
        skind[*pdepth] = 0;
        (*pdepth)++;
        (*pnmem)++;
        return 1;
    }
    if (vs_streq(mn, "POP")) {
        if (nops != 1 || !vs_whole_reg(ops[0], &r)) return 0;
        if (*pdepth <= 0) return 0;
        (*pdepth)--;
        (*pnmem)--;
        return 1;
    }
    f = vs_form(mn, nops, ops, &cnd);
    if (f < 0) return 0;
    if (f == VS_F_CALL || f == VS_F_BRANCH || f == VS_F_IT) return 1;
    vs_masks(f, nops, rmask, wmask);
    for (j = 0; j < nops; j++)
        if (wmask[j] && vs_txt_sp(ops[j])) return 0;
    return 1;
}

/* Is `reg` written before it is read, starting at line `from`?  Used to decide
 * whether the producer's destination can be moved into the pool: only when
 * nothing reads the old value first (IR_DUP keeps a live copy in r0). */
static int vs_read_before_write(VsLine *L, int nlines, int from, int reg)
{
    int i;
    for (i = from; i < nlines; i++) {
        char mn[24];
        char ops[VS_MAX_OP][VS_OPLEN];
        int nops, isdot, islab, f, cnd;
        int rmask[VS_MAX_OP], wmask[VS_MAX_OP];
        int rd = 0, wr = 0, j;

        if (L[i].del) continue;
        if (!vs_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
        if (isdot) continue;                 /* .loc / .cfi: no register effect */
        if (islab) return 1;
        if (vs_streq(mn, "PUSH") || vs_streq(mn, "POP")) {
            int pr = -1;
            if (nops == 1 && vs_whole_reg(ops[0], &pr)) {
                if (vs_streq(mn, "PUSH")) { if (pr == reg) return 1; }
                else { if (pr == reg) return 0; }   /* the value is overwritten */
            }
            continue;
        }
        f = vs_form(mn, nops, ops, &cnd);
        if (f < 0) return 1;
        if (f == VS_F_CALL) return (reg < 4 || reg == 12) ? 0 : 1;
        if (f == VS_F_BRANCH || f == VS_F_IT) return 1;
        vs_masks(f, nops, rmask, wmask);
        for (j = 0; j < nops; j++) {
            if (!vs_txt_has(ops[j], reg)) continue;
            if (rmask[j]) rd = 1;
            if (wmask[j]) wr = 1;
        }
        if (rd) return 1;
        if (wr) return 0;
    }
    return 1;
}

/* Small helpers for the r4 pool extension: parse "#<n>" and replace a line's
 * text (the text lives in the memory pool; the old copy is simply dropped). */
/* A frame-less function has no locals, so nothing may use r6 as a base.
 * This is the defensive half of the zero-frame r4 path: if any instruction
 * in the body mentions r6, the 4-byte realignment is only safe under
 * offsets this pass does not reason about, so the third slot is not taken.
 * `from` starts just past `MOV r6, sp` and `to` is the epilogue POP (which
 * itself lists r6, because r6 is callee-saved here), so the range is the body
 * only.  The epilogue's `MOV sp, r6` is the one expected r6 reference inside
 * that range and is skipped; every other one bails. */
static int vs_zero_frame_r6_used(VsLine *L, int from, int to) {
    int i;
    for (i = from; i < to; i++) {
        char mn[24];
        char ops[VS_MAX_OP][VS_OPLEN];
        int nops, isdot, islab;
        if (L[i].del) continue;
        if (!strstr(L[i].t, "r6")) continue;
        if (vs_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab) &&
            !isdot && !islab && vs_streq(mn, "MOV") && nops == 2 &&
            vs_streq(ops[0], "sp") && vs_streq(ops[1], "r6"))
            continue;               /* the frame epilogue, not a body use */
        return 1;
    }
    return 0;
}

static int vs_atou(const char *s) {
    int v = 0;
    if (*s == '#') s++;
    while (vs_isdigit(*s)) { v = v * 10 + (*s - '0'); s++; }
    return v;
}

static int vs_settext(VsLine *ln, const char *text)
{
    int n = (int)strlen(text);
    char *t = (char *)mem_pool_alloc(n + 1);
    if (!t) return 0;
    memcpy(t, text, n + 1);
    ln->t = t;
    return 1;
}

/* Widen the frame and keep every r6-relative offset honest.
 *
 * r6 points at the low address of the local area, so the caller's stack
 * arguments (5th, 6th, ... and the va region) sit at r6 + frame + 4 * saved
 * words.  Growing the saved block by one word therefore moves every slot at
 * or above `frame` up by four bytes: the argument-copy loads the front end
 * emitted (`LDR r0, [r6, #n]`, n = frame + 16) included.  A local lives below
 * `frame`, so it is never touched. */
static void vs_shift_r6(VsLine *L, int nlines, int frame, int delta) {
    int i;
    for (i = 0; i < nlines; i++) {
        const char *p, *q;
        char buf[256];
        int o = 0;
        if (L[i].del || !L[i].t) continue;
        p = L[i].t;
        for (;;) {
            const char *hit = strstr(p, "[r6, #");
            int n = 0;
            if (!hit) break;
            hit += 6;
            if (!vs_isdigit(*hit)) { p = hit; continue; }
            q = hit;
            while (vs_isdigit(*q)) { n = n * 10 + (*q - '0'); q++; }
            if (n < frame || *q != ']') { p = q; continue; }
            /* copy up to the digits, then the shifted number, then the rest */
            if (hit - L[i].t + 12 >= (int)sizeof buf) return;   /* too long */
            while (p < hit && o < (int)sizeof buf - 16) buf[o++] = *p++;
            o += snprintf(buf + o, sizeof buf - o, "%d", n + delta);
            p = q;
        }
        if (p != L[i].t && o > 0) {
            while (*p && o < (int)sizeof buf - 1) buf[o++] = *p++;
            buf[o] = 0;
            if (!vs_settext(&L[i], buf)) return;
        }
    }
}

static void ark_vstack_function(AsmBuffer *b, int from)
{
    VsLine *L = 0;
    int cap = 0, nlines = 0;
    int i, pos, pro_end = -1;
    int pool[VS_MAX_POOL], pbusy[VS_MAX_POOL], npool = 0;
    int skind[VS_MAX_DEPTH], spool[VS_MAX_DEPTH];
    int depth = 0, nmem = 0;
    int pend[VS_MAX_REG];      /* register -> pool slot holding its value */
    int pref[VS_MAX_POOL];     /* references per slot: stack entries + pend */
    int last_dest_off = -1, last_dest = -1;
    int verbf = 0;   /* boundary crossed with values live: copy the rest */
    int verbf_stuck = 0;  /* ... and the copied tail left an unmodelled stack */
    AsmBuffer out;
    int bail = 0;
    char nm[8];

    /* ---- slice the function text into lines ---- */
    pos = from;
    while (pos < b->len) {
        int len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (nlines >= cap) {
            int ncap = cap ? cap * 2 : 256;
            VsLine *grown = (VsLine *)mem_pool_alloc(ncap * (int)sizeof(VsLine));
            if (!grown) return;
            for (i = 0; i < nlines; i++) grown[i] = L[i];
            L = grown;
            cap = ncap;
        }
        L[nlines].t = (char *)mem_pool_alloc(len + 1);
        if (!L[nlines].t) return;
        for (i = 0; i < len; i++) L[nlines].t[i] = b->buf[pos + i];
        L[nlines].t[len] = 0;
        L[nlines].del = 0;
        L[nlines].cross = 0;
        L[nlines].after = 0;
        nlines++;
        pos += len + 1;
    }

    /* ---- find the end of the prologue: the "MOV r6, sp" that anchors it ---- */
    for (i = 0; i < nlines; i++) {
        char mn[24];
        char ops[VS_MAX_OP][VS_OPLEN];
        int nops, isdot, islab;
        if (!vs_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
        if (isdot || islab) continue;
        if (vs_streq(mn, "MOV") && nops == 2 &&
            vs_streq(ops[0], "r6") && vs_streq(ops[1], "sp")) {
            pro_end = i;
            break;
        }
    }
    if (pro_end < 0) return;   /* __naked or an unexpected prologue: leave it */

    /* ---- survey: pool availability and the bail conditions ---- */
    {
        int use5 = 0, use7 = 0, bad = 0;
        int use4 = 0, r4_pro = -1, r4_sub = -1, r4_add = -1, r4_pop = -1;
        int frame = -1, nsub = 0, nadd = 0;
        /* Peak number of values the body keeps on the machine stack at once.
         * With a two-register pool every value past the second one is spilled,
         * so a body that never goes deeper than two cannot profit from a third
         * pool register -- and r4 is not free: the prologue and epilogue each
         * grow by one word.  A call consumes its argument pushes, so it resets
         * the count instead of adding to it. */
        int sdepth = 0, sdmax = 0;
        for (i = pro_end + 1; i < nlines; i++) {
            char mn[24];
            char ops[VS_MAX_OP][VS_OPLEN];
            int nops, isdot, islab, f, cnd;
            if (!vs_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
            if (isdot || islab) continue;
            if (strstr(L[i].t, "[sp")) { bad = 1; break; }
            if (vs_streq(mn, "PUSH") || vs_streq(mn, "POP")) {
                if (nops == 1 && !strchr(ops[0], ',')) {
                    if (vs_txt_has(ops[0], 5)) use5 = 1;
                    if (vs_txt_has(ops[0], 7)) use7 = 1;
                    if (vs_streq(mn, "PUSH")) {
                        sdepth++;
                        if (sdepth > sdmax) sdmax = sdepth;
                    } else if (sdepth > 0) {
                        sdepth--;
                    }
                    continue;
                }
                /* multi-register: only the prologue PUSH and an epilogue POP
                 * (one that also pops pc or lr) are allowed through */
                if (vs_streq(mn, "POP") &&
                    (strstr(ops[0], "pc") || strstr(ops[0], "lr"))) continue;
                if (vs_streq(mn, "PUSH") && strstr(ops[0], "lr")) continue;
                bad = 1;
                break;
            }
            if (vs_txt_has(L[i].t, 5)) use5 = 1;
            if (vs_txt_has(L[i].t, 7)) use7 = 1;
            if (vs_txt_has(L[i].t, 4)) use4 = 1;
            f = vs_form(mn, nops, ops, &cnd);
            if (f < 0) { bad = 1; break; }
            if (f == VS_F_CALL) sdepth = 0;
        }
        if (bad) return;
        if (!use5) { pool[npool] = 5; npool++; }
        if (!use7) { pool[npool] = 7; npool++; }
        /* r4 is callee-saved, but this code generator saves only
         * r5/r6/r7/lr.  When the body keeps more than two values alive on the
         * stack -- so a third pool register actually saves a spill -- add r4
         * to the frame: push it in the prologue and grow the frame by 4 so the
         * total stays 8-byte aligned (16+8k becomes 20+8k+4).  Only with the
         * exact expected prologue/epilogue shapes and a single frame
         * allocation; otherwise the pass stays as it was and nothing grows. */
        if (npool < VS_MAX_POOL && !use4 && sdmax >= 3) {
            for (i = 0; i < nlines; i++) {
                char mn[24];
                char ops[VS_MAX_OP][VS_OPLEN];
                int nops, isdot, islab;
                if (!vs_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
                if (isdot || islab) continue;
                if (vs_streq(mn, "PUSH") && nops == 1 && vs_txt_has(ops[0], 5) &&
                    vs_txt_has(ops[0], 6) && vs_txt_has(ops[0], 7) &&
                    strstr(ops[0], "lr") && !vs_txt_has(ops[0], 4)) r4_pro = i;
                else if (vs_streq(mn, "SUB") && nops == 3 && vs_streq(ops[0], "sp") &&
                    vs_streq(ops[1], "sp") && ops[2][0] == '#') {
                    r4_sub = i; frame = vs_atou(ops[2]); nsub++;
                } else if (vs_streq(mn, "ADD") && nops == 3 && vs_streq(ops[0], "sp") &&
                    vs_streq(ops[1], "sp") && ops[2][0] == '#') {
                    r4_add = i; nadd++;
                } else if (vs_streq(mn, "POP") && nops == 1 && vs_txt_has(ops[0], 5) &&
                    vs_txt_has(ops[0], 6) && vs_txt_has(ops[0], 7) &&
                    strstr(ops[0], "pc") && !vs_txt_has(ops[0], 4)) r4_pop = i;
            }
            if (r4_pro >= 0 && r4_pop >= 0 && nsub == 0 && nadd == 0 &&
                !vs_zero_frame_r6_used(L, pro_end + 1, r4_pop)) {
                /* Frame-less function: the generator emitted no `SUB sp` /
                 * `ADD sp` at all (nothing to allocate), so there is no frame
                 * size to grow.  The epilogue restores sp with `MOV sp, r6`,
                 * which throws any padding away, so one inserted
                 * `SUB sp, sp, #4` right after `MOV r6, sp` is enough: with the
                 * 20-byte PUSH the incoming sp is 4 mod 8, and the body (which
                 * has no locals, hence no r6-relative offsets) sees an aligned
                 * sp again.  Same all-or-nothing rule as below. */
                char ptxt[64], qtxt[64];
                snprintf(ptxt, sizeof ptxt, "    PUSH {r4, r5, r6, r7, lr}");
                snprintf(qtxt, sizeof qtxt, "    POP {r4, r5, r6, r7, pc}");
                if (vs_settext(&L[r4_pro], ptxt) &&
                        vs_settext(&L[r4_pop], qtxt)) {
                    /* After `MOV r6, sp`, not before: the epilogue does
                     * `MOV sp, r6` and then pops 20 bytes, so r6 must hold
                     * the post-PUSH sp.  Padding before the MOV would leave
                     * sp 4 bytes below its entry value after the POP. */
                    L[pro_end].after = "    SUB sp, sp, #4";
                    pool[npool] = 4;
                    npool++;
                }
            } else if (r4_pro >= 0 && r4_sub >= 0 && r4_add >= 0 && r4_pop >= 0 &&
                nsub == 1 && nadd == 1 && frame >= 0 && (frame % 8) == 0 &&
                !vs_txt_has(L[r4_add].t, 0) /* ADD sp, sp, #frame only */) {
                /* All-or-nothing: a half-rewritten prologue with an
                 * unchanged frame size would break 8-byte alignment, so
                 * the four lines are only replaced once every allocation
                 * succeeded. */
                char ptxt[64], stxt[64], atxt[64], qtxt[64];
                if (vs_atou(strstr(L[r4_add].t, "#")) == frame) {
                    snprintf(ptxt, sizeof ptxt, "    PUSH {r4, r5, r6, r7, lr}");
                    snprintf(stxt, sizeof stxt, "    SUB sp, sp, #%d", frame + 4);
                    snprintf(atxt, sizeof atxt, "    ADD sp, sp, #%d", frame + 4);
                    snprintf(qtxt, sizeof qtxt, "    POP {r4, r5, r6, r7, pc}");
                    if (vs_settext(&L[r4_pro], ptxt) &&
                        vs_settext(&L[r4_sub], stxt) &&
                        vs_settext(&L[r4_add], atxt) &&
                        vs_settext(&L[r4_pop], qtxt)) {
                        /* +8, not +4: the PUSH grew by one word *and* the
                         * frame grew by four, so the caller's arguments move
                         * up by two words in total. */
                        vs_shift_r6(L, nlines, frame, 8);
                        pool[npool] = 4;
                        npool++;
                    }
                }
            }
        }
    }

    /* ---- peephole: "PUSH {rN}" immediately followed by "POP {rN}" is a
     * word stored and loaded straight back with sp and rN restored -- delete
     * both.  Correct with no pool at all, and it is the single biggest win on
     * expression-heavy code. ---- */
    for (i = pro_end + 1; i + 1 < nlines; i++) {
        char m1[24], m2[24];
        char o1[VS_MAX_OP][VS_OPLEN], o2[VS_MAX_OP][VS_OPLEN];
        int n1, n2, d1, d2, l1, l2, r1 = -1, r2 = -2;
        if (L[i].del || L[i+1].del) continue;
        if (!vs_parse(L[i].t, m1, sizeof m1, o1, &n1, &d1, &l1)) continue;
        if (!vs_parse(L[i+1].t, m2, sizeof m2, o2, &n2, &d2, &l2)) continue;
        if (d1 || l1 || d2 || l2) continue;
        if (n1 != 1 || n2 != 1) continue;
        if (!vs_streq(m1, "PUSH") || !vs_streq(m2, "POP")) continue;
        if (!vs_whole_reg(o1[0], &r1) || !vs_whole_reg(o2[0], &r2)) continue;
        if (r1 != r2) continue;
        L[i].del = 1;
        L[i+1].del = 1;
        i++;
    }

    /* ---- pre-scan: a value still on the shadow stack when control reaches a
     * label, a call or a branch must be physically in memory -- the machine
     * stack has to look exactly like the unoptimised one on every path into
     * that boundary, and a value left in a pool register cannot be
     * reconstructed there.  Mark the `PUSH {r}` that created such a value so
     * the rebuild below emits a real push for it. ---- */
    {
        int open[VS_MAX_DEPTH], nopen = 0, k;
        for (i = pro_end + 1; i < nlines; i++) {
            char mn[24];
            char ops[VS_MAX_OP][VS_OPLEN];
            int nops, isdot, islab, f, cnd;
            if (L[i].del) continue;
            if (!vs_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
            /* A local label such as `.L3:` is both a label and a line that
             * starts with a dot; test the label form first, exactly like the
             * rebuild does, or every branch target would be taken for a
             * directive and the values live across it never pinned to memory. */
            if (islab) {
                for (k = 0; k < nopen; k++) L[open[k]].cross = 1;
                continue;
            }
            if (isdot) continue;             /* .loc / .cfi / .word: no effect */
            if (vs_streq(mn, "PUSH") || vs_streq(mn, "POP")) {
                int pr = -1;
                if (nops == 1 && vs_whole_reg(ops[0], &pr)) {
                    if (vs_streq(mn, "PUSH")) {
                        if (nopen < VS_MAX_DEPTH) open[nopen++] = i;
                    } else if (nopen > 0) {
                        nopen--;
                    }
                } else if (vs_streq(mn, "POP") &&
                           (strstr(ops[0], "pc") || strstr(ops[0], "lr"))) {
                    nopen = 0;   /* epilogue POP: nothing of the frame is left */
                }
                continue;
            }
            if (vs_streq(mn, "MOV") && nops == 2 && vs_streq(ops[0], "sp"))
                continue;    /* epilogue: the rebuild checks the depth there */
            f = vs_form(mn, nops, ops, &cnd);
            if (f == VS_F_CALL || f == VS_F_BRANCH) {
                for (k = 0; k < nopen; k++) L[open[k]].cross = 1;
            }
        }
    }

    /* ---- rebuild ---- */
    asmbuf_init(&out);
    for (i = 0; i < VS_MAX_REG; i++) pend[i] = -1;
    for (i = 0; i < VS_MAX_POOL; i++) { pbusy[i] = 0; pref[i] = 0; }

    for (i = 0; i < nlines && !bail; i++) {
        char mn[24];
        char ops[VS_MAX_OP][VS_OPLEN];
        int nops, isdot, islab, f, cnd, j;

        if (i <= pro_end) {
            vs_put_line(&out, L[i].t);
            if (L[i].after) vs_put_line(&out, L[i].after);
            continue;
        }
        if (L[i].del) continue;
        if (!vs_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) {
            if (verbf) verbf_stuck = 1;
            vs_put_line(&out, L[i].t);
            continue;
        }
        if (verbf && islab) {
            /* A label whose stack model is still exact: the cut already put
             * every live value in memory and the copied tail only pushed and
             * popped single registers, so the block after the label is
             * optimised again instead of dragging the rest of the function
             * through verbatim.  Without the exact model the tail stays
             * verbatim, which is the old behaviour. */
            if (verbf_stuck) { vs_put_line(&out, L[i].t); continue; }
            verbf = 0;
        }
        if (verbf) {
            if (!vs_tail_track(L[i].t, skind, &depth, &nmem)) verbf_stuck = 1;
            vs_put_line(&out, L[i].t);
            continue;
        }
        if (islab) {
            /* A label can be reached from more than one path, so nothing
             * may be assumed about the registers here: every value still
             * live must be physically in memory, else the pass gives up.
             * Once it is, the machine stack matches the unoptimised code on
             * every path into the label, the register mappings are flushed
             * and the block after the label is optimised from an empty
             * register state -- no need to copy the rest of the function
             * through verbatim. */
            if (depth != 0 || nmem != 0) {
                if (!vs_all_mem(skind, depth)) {
                    if (!vs_cut_shape_ok(skind, depth)) { bail = 1; break; }
                    vs_cut_verbatim(&out, depth, skind, spool, pool, pend, pref, pbusy, &nmem);
                    verbf = 1;
                    vs_put_line(&out, L[i].t);
                    continue;
                }
            }
            vs_flush_all(&out, pend, pref, pbusy, pool);
            vs_put_line(&out, L[i].t);
            last_dest = -1;
            continue;
        }
        if (isdot) { vs_put_line(&out, L[i].t); continue; }

        if (vs_streq(mn, "MOV") && nops == 2 && vs_streq(ops[0], "sp")) {
            /* epilogue: everything after it until the next label is the
             * restore sequence and is copied through untouched.  sp is put
             * back to the frame base here, so every value the body kept on
             * the stack is dropped with the frame and the mappings can go. */
            int leaves = 0;
            vs_flush_all(&out, pend, pref, pbusy, pool);
            vs_put_line(&out, L[i].t);
            last_dest = -1;
            i++;
            while (i < nlines) {
                char m2[24];
                char o2[VS_MAX_OP][VS_OPLEN];
                int n2, d2, l2;
                if (vs_parse(L[i].t, m2, sizeof m2, o2, &n2, &d2, &l2) && l2) break;
                if (vs_parse(L[i].t, m2, sizeof m2, o2, &n2, &d2, &l2) &&
                    !d2 && (vs_txt_pc(L[i].t) ||
                            strncmp(m2, "BX", 2) == 0 ||
                            (vs_streq(m2, "MOV") && n2 == 2 && vs_streq(o2[0], "pc")) ||
                            vs_streq(m2, "B")))
                    leaves = 1;        /* the restore sequence leaves for good */
                vs_put_line(&out, L[i].t);
                i++;
            }
            i--;
            /* Once the sequence really leaves the function, the shadow stack
             * after the next label is the plain post-prologue one again: the
             * body values are gone with the frame and the restores pop the
             * prologue's words, which this pass never modelled.  So the model
             * is reset and the following block is optimised instead of being
             * dragged through verbatim.  A sequence that does not leave the
             * function (an sp move that is not an epilogue) still pins the
             * rest of the text, as before. */
            if (leaves) { depth = 0; nmem = 0; }
            else { verbf = 1; verbf_stuck = 1; }
            continue;
        }

        if (vs_streq(mn, "PUSH")) {
            int r = -1, p;
            if (nops != 1 || !vs_whole_reg(ops[0], &r)) {
                if (!vs_cut_shape_ok(skind, depth)) { bail = 1; break; }
                vs_cut_verbatim(&out, depth, skind, spool, pool, pend, pref, pbusy, &nmem);
                verbf = 1;
                vs_put_line(&out, L[i].t);
                continue;
            }
            if (depth >= VS_MAX_DEPTH) {
                if (!vs_cut_shape_ok(skind, depth)) { bail = 1; break; }
                vs_cut_verbatim(&out, depth, skind, spool, pool, pend, pref, pbusy, &nmem);
                verbf = 1;
                vs_put_line(&out, L[i].t);
                continue;
            }
            if (L[i].cross) {
                /* still live at a label/branch/call: the word has to be
                 * in memory there, so push it for real.  A value that
                 * only exists in the pool is pushed from the pool.
                 * register -- the register itself may never have held
                 * it. */
                if (pend[r] >= 0) {
                    vs_rname(pool[pend[r]], nm);
                    asmbuf_puts(&out, "    PUSH {");
                    asmbuf_puts(&out, nm);
                    asmbuf_puts(&out, "}\n");
                } else {
                    asmbuf_puts(&out, "    PUSH {r");
                    asmbuf_int(&out, r);
                    asmbuf_puts(&out, "}\n");
                }
                nmem++;
                skind[depth] = 0;
                spool[depth] = -1;
                depth++;
                last_dest = -1;
                continue;
            }
            if (pend[r] >= 0) {         /* the value already sits in a pool slot */
                skind[depth] = 1;
                spool[depth] = pend[r];
                vs_ref_add(pend[r], pref, pbusy);
                depth++;
                last_dest = -1;
                continue;
            }
            p = vs_free_pool(pbusy, npool);
            if (p >= 0) {
                vs_rname(pool[p], nm);
                if (last_dest == r && last_dest_off >= 0 &&
                    !vs_read_before_write(L, nlines, i + 1, r)) {
                    out.buf[last_dest_off]     = nm[0];
                    out.buf[last_dest_off + 1] = nm[1];
                } else {
                    asmbuf_puts(&out, "    MOV ");
                    asmbuf_puts(&out, nm);
                    asmbuf_puts(&out, ", r");
                    asmbuf_int(&out, r);
                    asmbuf_putc(&out, '\n');
                }
                vs_ref_add(p, pref, pbusy);            /* the value stack entry */
                skind[depth] = 1;
                spool[depth] = p;
                /* The value now lives in the pool as well, so a second
                 * `PUSH {r}` -- the same word on the stack twice, which is
                 * what a 5..8-byte struct return store does -- is free.  The
                 * mapping is dropped as soon as something writes r. */
                pend[r] = p;
                vs_ref_add(p, pref, pbusy);
            } else {
                asmbuf_puts(&out, "    PUSH {r");
                asmbuf_int(&out, r);
                asmbuf_puts(&out, "}\n");
                nmem++;
                skind[depth] = 0;
                spool[depth] = -1;
            }
            depth++;
            last_dest = -1;
            continue;
        }

        if (vs_streq(mn, "POP")) {
            int r = -1;
            if (nops != 1 || !vs_whole_reg(ops[0], &r)) {
                if (!vs_cut_shape_ok(skind, depth)) { bail = 1; break; }
                vs_cut_verbatim(&out, depth, skind, spool, pool, pend, pref, pbusy, &nmem);
                verbf = 1;
                vs_put_line(&out, L[i].t);
                continue;
            }
            if (depth <= 0) {
                if (!vs_cut_shape_ok(skind, depth)) { bail = 1; break; }
                vs_cut_verbatim(&out, depth, skind, spool, pool, pend, pref, pbusy, &nmem);
                verbf = 1;
                vs_put_line(&out, L[i].t);
                continue;
            }
            if (pend[r] >= 0) { vs_ref_rel(pend[r], pref, pbusy); pend[r] = -1; }
            depth--;
            if (skind[depth] == 1) {
                /* the entry's reference becomes the register's mapping: r
                 * is now the name for that slot, and the register itself is
                 * *not* written -- every later read has to be rewritten. */
                pend[r] = spool[depth];
            } else {
                asmbuf_puts(&out, "    POP {r");
                asmbuf_int(&out, r);
                asmbuf_puts(&out, "}\n");
                nmem--;
            }
            last_dest = -1;
            continue;
        }

        f = vs_form(mn, nops, ops, &cnd);
        if (f < 0) {
            if (!vs_cut_shape_ok(skind, depth)) { bail = 1; break; }
            vs_cut_verbatim(&out, depth, skind, spool, pool, pend, pref, pbusy, &nmem);
            verbf = 1;
            vs_put_line(&out, L[i].t);
            continue;
        }

        if (f == VS_F_CALL) {
            /* Same rule as a label: the callee may not clobber the words
             * already pushed above sp, and it must preserve the pool
             * registers (they are all callee-saved), so once every live
             * value is in memory the block after the call is optimised
             * normally.  Argument pushes cleaned up by a later
             * `ADD sp, sp, #N` simply stay in the shadow stack as pinned
             * entries, which keeps every later PUSH/POP pair aligned. */
            if (depth != 0 || nmem != 0) {
                if (!vs_all_mem(skind, depth)) {
                    if (!vs_cut_shape_ok(skind, depth)) { bail = 1; break; }
                    vs_cut_verbatim(&out, depth, skind, spool, pool, pend, pref, pbusy, &nmem);
                    verbf = 1;
                    vs_put_line(&out, L[i].t);
                    continue;
                }
            }
            vs_flush_all(&out, pend, pref, pbusy, pool);
            vs_put_ins(&out, mn, ops, nops, 0);
            last_dest = -1;
            continue;
        }
        if (f == VS_F_BRANCH) {
            /* The taken path leaves the same machine stack (the original
             * program is sp-consistent at the target), and the fall-through
             * path continues from pinned entries only, so a branch is just
             * a flush, not the end of the optimisation. */
            if (depth != 0 || nmem != 0) {
                if (!vs_all_mem(skind, depth)) {
                    if (!vs_cut_shape_ok(skind, depth)) { bail = 1; break; }
                    vs_cut_verbatim(&out, depth, skind, spool, pool, pend, pref, pbusy, &nmem);
                    verbf = 1;
                    vs_put_line(&out, L[i].t);
                    continue;
                }
            }
            vs_flush_all(&out, pend, pref, pbusy, pool);
            vs_put_ins(&out, mn, ops, nops, 0);
            last_dest = -1;
            continue;
        }
        if (f == VS_F_IT) {
            vs_flush_all(&out, pend, pref, pbusy, pool);
            vs_put_ins(&out, mn, ops, nops, 0);
            last_dest = -1;
            continue;
        }

        {
            int rmask[VS_MAX_OP], wmask[VS_MAX_OP];
            int dest_off = -1, cand = -1;

            vs_masks(f, nops, rmask, wmask);

            /* Consume the popped values.  A value that is read goes straight
             * from the pool into the consumer; a value whose register is
             * overwritten without being read is dead and the pool slot is
             * released; a value read *and* written in the same operand (the
             * 2-operand forms) is copied into its register first. */
            for (j = 0; j < VS_MAX_REG; j++) {
                int need_mov = 0, any_sub = 0, dead = 0, written = 0, k;
                if (pend[j] < 0) continue;
                for (k = 0; k < nops; k++) {
                    if (!vs_txt_has(ops[k], j)) continue;
                    if (wmask[k]) written = 1;
                    if (rmask[k] && wmask[k]) need_mov = 1;
                    else if (rmask[k]) any_sub = 1;
                    else if (wmask[k]) dead = 1;
                }
                /* Read in one operand and written in another (`ADD r0, r0, r1`
                 * with r0 in the pool): the slot is the only copy and the
                 * consumer overwrites the register, so materialise first. */
                if (!need_mov && written && any_sub) { need_mov = 1; any_sub = 0; }
                if (!need_mov && any_sub && vs_is_inplace3(mn) && nops == 3 &&
                    vs_txt_has(ops[1], j)) {
                    need_mov = 1;
                    any_sub = 0;
                }
                if (!need_mov && !any_sub && !dead) continue;
                vs_rname(pool[pend[j]], nm);
                if (need_mov) {
                    asmbuf_puts(&out, "    MOV r");
                    asmbuf_int(&out, j);
                    asmbuf_puts(&out, ", ");
                    asmbuf_puts(&out, nm);
                    asmbuf_putc(&out, '\n');
                } else if (any_sub) {
                    for (k = 0; k < nops; k++)
                        if (rmask[k] && !wmask[k] && vs_txt_has(ops[k], j))
                            vs_subst(ops[k], j, nm);
                }
                /* Read-only keeps the mapping: the register itself may hold
                 * nothing at all (a popped pool value is never copied back),
                 * so the next line that reads it must be rewritten the same
                 * way (`lo32` ends with STR r0,[r2,#0]; STR r1,[r2,#4] --
                 * two separate stores of the same base).  A line that also
                 * writes the register (`LDR r0,[r0,#0]`) makes the slot dead
                 * after it. */
                /* Nothing reads the register again before it is written --
                 * not even a `PUSH {r}`, which vs_read_before_write counts as
                 * a read -- so the mapping is dead and the slot can go back
                 * to the pool without paying for a copy. */
                if (need_mov || written || dead ||
                    !vs_read_before_write(L, nlines, i + 1, j)) {
                    vs_ref_rel(pend[j], pref, pbusy);
                    pend[j] = -1;
                }
            }

            /* A plain register destination that is not read can host the next
             * pushed value; remember where that token is so PUSH can retarget
             * it in place. */
            /* MOVW/MOVT come in pairs that build one value in one register;
             * retargeting just the second half would leave 0xFFFF in rN and
             * the high half in the pool register, so never let PUSH rewrite
             * either of them. */
            if (vs_streq(mn, "MOVW") || vs_streq(mn, "MOVT")) cand = -1;
            else if (!cnd && nops > 0 && wmask[0] && !rmask[0]) {
                int rr, n = vs_regtok(ops[0], &rr);
                if (n > 0 && ops[0][n] == 0 && rr < 10) cand = rr;
            }
            vs_put_ins(&out, mn, ops, nops, &dest_off);
            if (cand >= 0) {
                last_dest = cand;
                last_dest_off = dest_off;
            } else {
                last_dest = -1;
                last_dest_off = -1;
            }
        }
    }
    if (bail || (!verbf && (depth != 0 || nmem != 0))) {
        return;
    }
    /* Nothing changed?  Then leave the buffer exactly as it was. */
    if (out.len == b->len - from && memcmp(out.buf, b->buf + from, out.len) == 0) {
        return;
    }

    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 > b->cap) return;
    for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
    b->buf[from + out.len] = 0;
    b->len = from + out.len;
}
#endif /* ARKCC_FEATURE_OPT_VSTACK */


#if ARKCC_FEATURE_OPT_ADDR
/* ------------------- addressing-mode folding (-fopt-addr) ----------------
 * The IR is a stack machine, so one C array/pointer access is emitted as a
 * chain of independent instructions:
 *
 *      MOV r0, r5             ; copy the base out of the value-stack pool
 *      ADD r0, r0, r1         ; + index
 *      LDR r0, [r0, #0]       ; *(base + index)
 *
 * ARMv7-M already has those address modes, so all three lines are one:
 *
 *      LDR r0, [r5, r1]
 *
 * Measured on the STM32F4 HAL corpus: 42,365 instructions -> 40,996, i.e.
 * 1,369 fewer (-3.2%); before the pass 1,084 add-then-access pairs sit in
 * the object and none is left after it.
 * This pass is a text rewrite over an already emitted function -- the same
 * layer as ark_vstack_function -- and recognises three local shapes:
 *
 *   R1  ADD RB, RB, #imm            R2  ADD RB, RB, RI[, LSL #n]
 *       mem Rd, [RB(, #off)]             mem Rd, [RB]
 *       -> mem Rd, [RB, #imm+off]        -> mem Rd, [RB, RI(, LSL #n)]
 *
 *   R3  MOV RB, RS
 *       mem Rd, [RB(, #off)]
 *       -> mem Rd, [RS(, #off)]
 *
 * R1/R2 fold address arithmetic into the operand, R3 removes the copy that
 * puts the base into a low register.
 *
 * Both ARMv7-M write-back forms (`[Rn, #imm]!` and `[Rn], #imm`) are left out
 * on purpose: this codegen never asks for them, so a rule for either would be
 * dead and untested code.  `p++` stores the incremented pointer back into its
 * frame slot (`MOV r0, #4` / `ADD r0, r0, r1` / `STR r0, [r6, #0]`), so there is
 * no `ADD base, base, #imm` to fold; the only two such shapes in the HAL object
 * sit inside the hand-written `__arkcc_mcpy` runtime helper, which this pass
 * never visits.  Measured: 0 of each form emitted with the pass on.
 *
 * Every rule rewrites one line and deletes one line, and every rule only fires
 * when the intermediate register's value is provably not needed any more
 * (ad_dead_after) or when the write is folded into a write-back operand, so
 * the data flow is preserved.  Anything not recognised is left untouched: the
 * worst case of a mistake is a missed fold, never a wrong instruction.
 *
 * Never folded:
 *   - a conditional instruction or an IT-block member -- merging two
 *     conditional instructions would invalidate the IT mask;
 *   - a flag-setting form (ADDS / MOVS): deleting it would drop the flags,
 *     which ad_dead_after does not model;
 *   - a non-zero memory offset with a live base: [Rn, #imm]! leaves the base
 *     at Rn+imm, not Rn+imm+off, and Thumb has no register-indexed write-back;
 *   - a write-back whose base is the destination register (UNPREDICTABLE in
 *     ARMv7-M) or is r6/sp (frame pointer / stack);
 *   - anything across a label, branch or call: ad_dead_after stops there.
 *
 * Not done here on purpose: LDRD/STRD pairing (frame slots are 8 bytes apart
 * and need an even register pair plus 8-byte alignment; the assembler only
 * accepts them on the --asm-extra path) and merging independent LDR/STR into
 * LDM/STM (AC5 does not do it either, see docs/ADDR_FOLD.md).
 */
#define AD_MAX_OP   6
#define AD_OPLEN    96
#define AD_MAX_REG  16
#define AD_SCAN_MAX 64          /* forward scan cap for ad_dead_after */

typedef struct {
    char *t;    /* line text, '\n' stripped, owned by the memory pool */
    int   del;  /* removed by an earlier round */
} AdLine;

static int ad_streq(const char *a, const char *b)
{
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}
static int ad_isdigit(char c) { return c >= '0' && c <= '9'; }
static int ad_isalnum(char c)
{
    return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}
static int ad_isboundary(char c) { return !(ad_isalnum(c) || c == '_' || c == '.'); }

static void ad_trim(char *s)
{
    char *p = s;
    int n;
    while (*p == ' ' || *p == '\t') p++;
    if (p != s) {
        char *d = s;
        while (*p) *d++ = *p++;
        *d = 0;
    }
    n = (int)strlen(s);
    while (n > 0 && (s[n-1] == ' ' || s[n-1] == '\t' || s[n-1] == '\r')) s[--n] = 0;
}

/* Copy `in` to `out` with every space/tab removed, so the operand parsers
 * below only have to deal with one spelling. */
static void ad_nospace(const char *in, char *out, int cap)
{
    int j = 0;
    while (*in && j < cap - 1) {
        if (*in != ' ' && *in != '\t') out[j++] = *in;
        in++;
    }
    out[j] = 0;
}

/* Split one line into mnemonic + comma separated operands.  Commas inside
 * "[...]" or "{...}" do not separate.  Returns 0 for a blank line. */
static int ad_parse(const char *line, char *mn, int mn_sz,
                    char ops[AD_MAX_OP][AD_OPLEN], int *nops,
                    int *is_dot, int *is_label)
{
    const char *p = line;
    int i;

    *nops = 0;
    *is_dot = 0;
    *is_label = 0;
    mn[0] = 0;
    while (*p == ' ' || *p == '\t') p++;
    if (!*p || *p == '\r') return 0;
    if (*p == '.') *is_dot = 1;
    {
        const char *e = p + strlen(p);
        while (e > p && (e[-1] == ' ' || e[-1] == '\t' || e[-1] == '\r')) e--;
        if (e > p && e[-1] == ':') { *is_label = 1; return 1; }
    }
    i = 0;
    while (*p && *p != ' ' && *p != '\t' && *p != '\r' && i < mn_sz - 1) mn[i++] = *p++;
    mn[i] = 0;
    while (*p == ' ' || *p == '\t') p++;
    while (*p && *p != '\r' && *nops < AD_MAX_OP) {
        int j = 0, br = 0;
        while (*p && *p != '\r') {
            if (*p == '[' || *p == '{') br++;
            else if (*p == ']' || *p == '}') br--;
            else if (*p == ',' && br == 0) break;
            if (j < AD_OPLEN - 1) ops[*nops][j++] = *p;
            p++;
        }
        ops[*nops][j] = 0;
        ad_trim(ops[*nops]);
        (*nops)++;
        if (*p == ',') p++;
        while (*p == ' ' || *p == '\t') p++;
    }
    return 1;
}

/* Length of the "r<digits>" token at s and its number; 0 if there is none. */
static int ad_regtok(const char *s, int *reg)
{
    int i = 1, v = 0, n = 0;
    if (s[0] != 'r') return 0;
    if (!ad_isdigit(s[i])) return 0;
    while (ad_isdigit(s[i])) { v = v * 10 + (s[i] - '0'); i++; n++; }
    if (n > 2 || v >= AD_MAX_REG) return 0;
    *reg = v;
    return i;
}

static int ad_whole_reg(const char *s, int *reg)
{
    int n = ad_regtok(s, reg);
    return (n > 0 && s[n] == 0);
}

/* Does this text mention register `reg` as a whole token? */
static int ad_txt_has(const char *s, int reg)
{
    int i = 0;
    while (s[i]) {
        int r, n;
        int bnd = (i == 0) || ad_isboundary(s[i-1]);
        if (bnd && (n = ad_regtok(s + i, &r)) > 0) {
            char after = s[i + n];
            if (!(ad_isalnum(after) || after == '_')) {
                if (r == reg) return 1;
            }
            i += n;
            continue;
        }
        i++;
    }
    return 0;
}

static void ad_rname(int reg, char *buf)
{
    if (reg >= 10) {
        buf[0] = 'r'; buf[1] = (char)('0' + reg / 10);
        buf[2] = (char)('0' + reg % 10); buf[3] = 0;
    } else {
        buf[0] = 'r'; buf[1] = (char)('0' + reg); buf[2] = 0;
    }
}

static int ad_in(const char *m, const char *const *list)
{
    int i;
    for (i = 0; list[i]; i++) if (ad_streq(m, list[i])) return 1;
    return 0;
}

static const char *const ad_arith[] = {
    "ADD", "SUB", "RSB", "ADC", "SBC", "AND", "ORR", "EOR", "BIC",
    "LSL", "LSR", "ASR", "ROR", "MUL", "SDIV", "UDIV", 0
};
static const char *const ad_cmpx[] = { "CMP", "CMN", "TST", "TEQ", 0 };
static const char *const ad_ldrx[] = { "LDR", "LDRB", "LDRH", "LDRSB", "LDRSH", 0 };
static const char *const ad_strx[] = { "STR", "STRB", "STRH", 0 };
static const char *const ad_rw1[]  = { "UXTB", "SXTB", "UXTH", "SXTH", "NEG", "MVN", 0 };

static int ad_cc_suffix(const char *s)
{
    static const char *const cc[] = {
        "EQ", "NE", "CS", "HS", "CC", "LO", "MI", "PL",
        "VS", "VC", "HI", "LS", "GE", "LT", "GT", "LE", "AL", 0
    };
    int i;
    for (i = 0; cc[i]; i++) if (ad_streq(s, cc[i])) return 1;
    return 0;
}

/* A data mnemonic this pass reasons about (condition suffix or the flag-setting
 * S already removed). */
static int ad_known_base(const char *m)
{
    return ad_in(m, ad_arith) || ad_in(m, ad_cmpx) || ad_in(m, ad_ldrx) ||
           ad_in(m, ad_strx) || ad_in(m, ad_rw1) ||
           ad_streq(m, "MOV") || ad_streq(m, "MOVW") || ad_streq(m, "MOVT") ||
           ad_streq(m, "PUSH") || ad_streq(m, "POP");
}

/* Strip a condition suffix (returns 1 if there was one) and then a trailing
 * flag-setting S from the mnemonic. */
static int ad_split_base(const char *mn, char *base, int *cond)
{
    int n = (int)strlen(mn), k = 0;
    char tmp[16];
    *cond = 0;
    if (n <= 0 || n >= (int)sizeof tmp) { base[0] = 0; return 0; }
    memcpy(tmp, mn, n + 1);
    if (n >= 4 && ad_cc_suffix(tmp + n - 2)) {
        char b[16];
        memcpy(b, tmp, n - 2); b[n-2] = 0;
        if (ad_known_base(b)) { tmp[n-2] = 0; *cond = 1; n -= 2; }
    }
    if (n > 2 && tmp[n-1] == 'S') {
        char b[16];
        memcpy(b, tmp, n - 1); b[n-1] = 0;
        if (ad_known_base(b)) { tmp[n-1] = 0; n -= 1; }
    }
    while (tmp[k]) { base[k] = tmp[k]; k++; }
    base[k] = 0;
    return *cond;
}

static int ad_is_cond(const char *mn)
{
    char base[16];
    int cond;
    ad_split_base(mn, base, &cond);
    return cond;
}

static int ad_is_load(const char *mn)
{
    char base[16];
    int cond;
    ad_split_base(mn, base, &cond);
    return ad_in(base, ad_ldrx);
}

/* Read/write roles of register r in one instruction.  Anything not in the
 * table counts as both, i.e. live, so ad_dead_after declines instead of
 * guessing. */
static void ad_rw(const char *mn, int nops, char ops[AD_MAX_OP][AD_OPLEN],
                  int r, int *rd, int *wr)
{
    char base[16];
    int cond, k;
    *rd = 0; *wr = 0;
    ad_split_base(mn, base, &cond);
    if (ad_in(base, ad_arith)) {
        if (nops == 3) {
            if (ad_txt_has(ops[0], r)) *wr = 1;
            for (k = 1; k < 3; k++) if (ad_txt_has(ops[k], r)) *rd = 1;
        } else if (nops == 2) {
            if (ad_txt_has(ops[0], r)) { *rd = 1; *wr = 1; }
            if (ad_txt_has(ops[1], r)) *rd = 1;
        } else {
            *rd = 1; *wr = 1;
        }
        return;
    }
    if (ad_streq(base, "MOV")) {
        if (nops >= 1 && ad_txt_has(ops[0], r)) *wr = 1;
        if (nops >= 2 && ops[1][0] != '#' && ad_txt_has(ops[1], r)) *rd = 1;
        return;
    }
    if (ad_streq(base, "MOVW") || ad_streq(base, "MOVT")) {
        if (nops >= 1 && ad_txt_has(ops[0], r)) *wr = 1;
        return;
    }
    if (ad_in(base, ad_cmpx)) {
        for (k = 0; k < nops; k++) if (ad_txt_has(ops[k], r)) *rd = 1;
        return;
    }
    if (ad_in(base, ad_ldrx)) {
        if (nops >= 1 && ad_txt_has(ops[0], r)) *wr = 1;
        for (k = 1; k < nops; k++) if (ad_txt_has(ops[k], r)) *rd = 1;
        return;
    }
    if (ad_in(base, ad_strx)) {
        for (k = 0; k < nops; k++) if (ad_txt_has(ops[k], r)) *rd = 1;
        return;
    }
    if (ad_in(base, ad_rw1)) {
        if (nops >= 1 && ad_txt_has(ops[0], r)) *wr = 1;
        if (nops >= 2 && ad_txt_has(ops[1], r)) *rd = 1;
        return;
    }
    if (ad_streq(base, "PUSH")) {
        for (k = 0; k < nops; k++) if (ad_txt_has(ops[k], r)) *rd = 1;
        return;
    }
    if (ad_streq(base, "POP")) {
        /* POP writes its register list; it never reads one.  Modelling it
         * as a read (the old shared PUSH/POP branch) made every register
         * that a later POP reloads count as live, which silently blocked
         * the folds that only need "this value is not wanted again". */
        for (k = 0; k < nops; k++) if (ad_txt_has(ops[k], r)) *wr = 1;
        return;
    }
    *rd = 1; *wr = 1;
}

/* "[rB]" / "[rB, #off]" -> base/off.  A register index, a write-back or
 * anything else declines. */
static int ad_memop(const char *op, int *base, int *off)
{
    char b[AD_OPLEN];
    const char *p;
    int n;
    ad_nospace(op, b, (int)sizeof b);
    p = b;
    if (*p != '[') return 0;
    p++;
    n = ad_regtok(p, base);
    if (!n) return 0;
    p += n;
    *off = 0;
    if (*p == ',') {
        int neg = 0, v = 0;
        p++;
        if (*p != '#') return 0;         /* register index: not this form */
        p++;
        if (*p == '-') { neg = 1; p++; }
        if (!ad_isdigit(*p)) return 0;
        while (ad_isdigit(*p)) { v = v * 10 + (*p - '0'); p++; }
        *off = neg ? -v : v;
    }
    if (*p != ']') return 0;
    p++;
    return *p == 0;
}

/* "LSL #<0..3>" -> shift. */
static int ad_lsl_of(const char *op, int *shift)
{
    char b[AD_OPLEN];
    const char *p;
    int v = 0;
    ad_nospace(op, b, (int)sizeof b);
    p = b;
    if (p[0] != 'L' || p[1] != 'S' || p[2] != 'L' || p[3] != '#') return 0;
    p += 4;
    if (!ad_isdigit(*p)) return 0;
    while (ad_isdigit(*p)) { v = v * 10 + (*p - '0'); p++; }
    if (*p || v > 3) return 0;
    *shift = v;
    return 1;
}

/* Parse "[rB]" / "[rB, #off]" / "[rB, rI]" / "[rB, rI, LSL #n]".  A
 * write-back or anything else declines.  `idx` is -1 for the immediate form. */
static int ad_memop2(const char *op, int *base, int *off, int *idx, int *shf)
{
    char b[AD_OPLEN];
    const char *p;
    int n;
    ad_nospace(op, b, (int)sizeof b);
    p = b;
    *idx = -1; *shf = 0; *off = 0;
    if (*p != '[') return 0;
    p++;
    n = ad_regtok(p, base);
    if (!n) return 0;
    p += n;
    if (*p == ',') {
        int neg = 0, v = 0;
        p++;
        if (*p == '#') {
            p++;
            if (*p == '-') { neg = 1; p++; }
            if (!ad_isdigit(*p)) return 0;
            while (ad_isdigit(*p)) { v = v * 10 + (*p - '0'); p++; }
            *off = neg ? -v : v;
        } else {
            n = ad_regtok(p, idx);
            if (!n) return 0;
            p += n;
            if (*p == ',') {
                char sub[AD_OPLEN];
                int j = 0;
                p++;
                while (*p && *p != ']' && j < AD_OPLEN - 1) sub[j++] = *p++;
                sub[j] = 0;
                if (!ad_lsl_of(sub, shf)) return 0;
            }
        }
    }
    if (*p != ']') return 0;
    p++;
    return *p == 0;
}

/* If line text `t` is a plain word/byte/half access, report its parts.  `idx`
 * >= 0 selects the register-offset form and `off` is then unused; otherwise
 * `off` is the immediate offset.  Conditional lines and write-backs decline. */
static int ad_access(const char *t, char *mn, int mn_sz, int *dst, int *base,
                     int *off, int *idx, int *shf)
{
    char ops[AD_MAX_OP][AD_OPLEN];
    char b[16];
    int nops, isdot, islab, cond;
    if (!ad_parse(t, mn, mn_sz, ops, &nops, &isdot, &islab)) return 0;
    if (isdot || islab || nops < 2) return 0;
    if (ad_is_cond(mn)) return 0;
    ad_split_base(mn, b, &cond);
    if (!ad_in(b, ad_ldrx) && !ad_in(b, ad_strx)) return 0;
    if (!ad_whole_reg(ops[0], dst)) return 0;
    if (!ad_memop2(ops[1], base, off, idx, shf)) return 0;
    if (*dst < 0 || *dst > 12 || *base < 0 || *base > 12) return 0;
    if (*idx >= 0) {
        if (*idx > 12 || *idx == *base) return 0;
        /* only LDR/STR take a shifted index */
        if (*shf > 0 && !ad_streq(b, "LDR") && !ad_streq(b, "STR")) return 0;
    }
    return 1;
}

/* Is register `r` provably not read again from line `from` on?  Stops at the
 * first mention: a plain write there makes it dead, a read (or a label /
 * branch / call before that mention) makes it live.  Capped so the cost stays
 * linear-ish on very long straight-line bodies. */
static int ad_dead_after(AdLine *L, int nlines, int from, int r)
{
    int i, seen = 0;
    for (i = from; i < nlines && seen < AD_SCAN_MAX; i++, seen++) {
        char mn[24];
        char ops[AD_MAX_OP][AD_OPLEN];
        int nops, isdot, islab, rd, wr;
        if (L[i].del) continue;
        if (!ad_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
        if (islab) return 0;
        if (isdot) continue;
        if (ad_streq(mn, "B") || ad_streq(mn, "BL") ||
            ad_streq(mn, "BX") || ad_streq(mn, "BLX")) return 0;
        /* Barriers take no register operand; ad_rw() would otherwise treat an
         * unknown mnemonic as "reads and writes everything".  Without this a
         * volatile access (LDR ... / DMB / STR ...) never folds. */
        if (ad_streq(mn, "DMB") || ad_streq(mn, "DSB") || ad_streq(mn, "ISB")) continue;
        ad_rw(mn, nops, ops, r, &rd, &wr);
        if (!rd && !wr) continue;
        if (wr && !rd) return 1;
        return 0;
    }
    return 1;
}

static char *ad_dup(const char *s)
{
    int n = (int)strlen(s);
    char *p = (char *)mem_pool_alloc(n + 1);
    if (p) memcpy(p, s, n + 1);
    return p;
}

/* Rebuild one access line.  `index` >= 0 selects the register-offset form,
 * otherwise the immediate form with `off`. */
/* `ADD d, s, #imm` / `SUB d, s, #imm` with the same operand layout as the
 * emitter writes it, used by R0 to merge a MOV into the arithmetic that
 * follows it. */
static char *ad_arith_line(const char *mn, int dst, int src, int imm)
{
    AsmBuffer t;
    char nm[4];
    asmbuf_init(&t);
    asmbuf_puts(&t, "    ");
    asmbuf_puts(&t, mn);
    asmbuf_putc(&t, ' ');
    ad_rname(dst, nm);
    asmbuf_puts(&t, nm);
    asmbuf_puts(&t, ", ");
    ad_rname(src, nm);
    asmbuf_puts(&t, nm);
    asmbuf_puts(&t, ", #");
    asmbuf_int(&t, imm);
    return ad_dup(t.buf);
}

static char *ad_mem_line(const char *mn, int dst, int base,
                         int index, int shift, int off)
{
    AsmBuffer t;
    char nm[4];
    asmbuf_init(&t);
    asmbuf_puts(&t, "    ");
    asmbuf_puts(&t, mn);
    asmbuf_putc(&t, ' ');
    ad_rname(dst, nm);
    asmbuf_puts(&t, nm);
    asmbuf_puts(&t, ", [");
    ad_rname(base, nm);
    asmbuf_puts(&t, nm);
    if (index >= 0) {
        asmbuf_puts(&t, ", ");
        ad_rname(index, nm);
        asmbuf_puts(&t, nm);
        if (shift > 0) {
            asmbuf_puts(&t, ", LSL #");
            asmbuf_int(&t, shift);
        }
    } else {
        asmbuf_puts(&t, ", #");
        asmbuf_int(&t, off);
    }
    asmbuf_putc(&t, ']');
    return ad_dup(t.buf);   /* the line table holds no newline */
}

/* "#<imm>" (optionally negative) exactly; 0 if it is not an immediate. */
static int ad_imm_of(const char *op, int *imm)
{
    char b[AD_OPLEN];
    const char *p;
    int neg = 0, v = 0;
    ad_nospace(op, b, (int)sizeof b);
    p = b;
    if (*p != '#') return 0;
    p++;
    if (*p == '-') { neg = 1; p++; }
    if (!ad_isdigit(*p)) return 0;
    while (ad_isdigit(*p)) { v = v * 10 + (*p - '0'); p++; }
    if (*p) return 0;
    *imm = neg ? -v : v;
    return 1;
}

/* Immediate offsets the assembler encodes: 0..4095, or -255..-1. */
static int ad_off_ok(int off)
{
    return (off >= 0 && off <= 4095) || (off >= -255 && off <= -1);
}

/* ---- look ahead for the first access through an address register ----
 * The adjacent rules inside ark_addr_function only see the very next line.
 * The emitter routinely puts one or two unrelated instructions between the
 * address arithmetic and the access that consumes it, and those folds used to
 * be left on the floor (189 candidate sites in the 26-flag corpus, 2026-11-25;
 * 53 of them are actually paid here -- the rest end a block, and the death of
 * the address register at a block end is not provable from the text alone).
 * The window is deliberately tiny, and it closes on anything that
 * touches either register: a missed fold is free, a wrong fold is a
 * miscompile.
 *
 * Returns the line index of the first access whose memory base is `reg` (and
 * which has no index register), or -1 when the window ends first.  -1 is also
 * returned on a label, a conditional, a branch, a call, a write to `reg` or
 * `guard`, or a read of `reg` that is not that access: in every one of those
 * cases the definition of `reg` cannot simply disappear.  The caller still
 * checks that the access leaves `reg` dead (or writes it), exactly as the
 * adjacent rules do. */
#define AD_ACC_WINDOW 4
static int ad_first_access(AdLine *L, int nlines, int from, int reg, int guard,
                           int *pdst, char *nmn, int nsz,
                           int *poff, int *pidx, int *psh)
{
    int k, seen = 0;
    for (k = from; k < nlines && seen < AD_ACC_WINDOW; k++) {
        char mn[24], base[16];
        char ops[AD_MAX_OP][AD_OPLEN];
        int nops, isdot, islab, cond, rd, wr, dst, b, off, idx, sh;
        if (L[k].del) continue;
        if (!ad_parse(L[k].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
        if (islab) return -1;
        if (isdot) continue;
        seen++;
        if (ad_streq(mn, "DMB") || ad_streq(mn, "DSB") || ad_streq(mn, "ISB")) continue;
        ad_split_base(mn, base, &cond);
        if (cond) return -1;                       /* conditional: not ours */
        if (ad_streq(base, "B") || ad_streq(base, "BX") || ad_streq(base, "BL") ||
            ad_streq(base, "BLX") || ad_streq(base, "CBZ") || ad_streq(base, "CBNZ"))
            return -1;
        if (ad_access(L[k].t, nmn, nsz, &dst, &b, &off, &idx, &sh) && b == reg) {
            if (guard >= 0 && guard != reg) {
                ad_rw(mn, nops, ops, guard, &rd, &wr);
                if (wr) return -1;                 /* the base moved: stop here */
            }
            *pdst = dst; *poff = off; *pidx = idx; *psh = sh;
            return k;
        }
        ad_rw(mn, nops, ops, reg, &rd, &wr);
        if (wr || rd) return -1;                   /* our value is gone or wanted */
        if (guard >= 0 && guard != reg) {
            ad_rw(mn, nops, ops, guard, &rd, &wr);
            if (wr) return -1;
        }
    }
    return -1;
}

static void ark_addr_function(AsmBuffer *b, int from)
{
    AdLine *L = 0;
    int cap = 0, nlines = 0, i, pos, pro_end = -1, round;
    int last_nl = (b->len > from && b->buf[b->len - 1] == '\n');
    AsmBuffer out;

    /* ---- slice the function text into lines ---- */
    pos = from;
    while (pos < b->len) {
        int len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (nlines >= cap) {
            int ncap = cap ? cap * 2 : 256;
            AdLine *grown = (AdLine *)mem_pool_alloc(ncap * (int)sizeof(AdLine));
            if (!grown) return;
            for (i = 0; i < nlines; i++) grown[i] = L[i];
            L = grown;
            cap = ncap;
        }
        L[nlines].t = (char *)mem_pool_alloc(len + 1);
        if (!L[nlines].t) return;
        for (i = 0; i < len; i++) L[nlines].t[i] = b->buf[pos + i];
        L[nlines].t[len] = 0;
        L[nlines].del = 0;
        nlines++;
        pos += len + 1;
    }

    /* ---- nothing before "MOV r6, sp" is touched ---- */
    for (i = 0; i < nlines; i++) {
        char mn[24];
        char ops[AD_MAX_OP][AD_OPLEN];
        int nops, isdot, islab;
        if (!ad_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
        if (isdot || islab) continue;
        if (ad_streq(mn, "MOV") && nops == 2 &&
            ad_streq(ops[0], "r6") && ad_streq(ops[1], "sp")) {
            pro_end = i;
            break;
        }
    }
    if (pro_end < 0) {
        /* No frame pointer (a __naked body or one of the hand-emitted runtime
         * helpers): start right after the function label instead.  Nothing in
         * the prologue is foldable anyway, and every rule below stops at the
         * next label, so this cannot walk into the following function. */
        for (i = 0; i < nlines; i++) {
            char mn[24];
            char ops[AD_MAX_OP][AD_OPLEN];
            int nops, isdot, islab;
            if (!ad_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
            if (islab) { pro_end = i; break; }
        }
    }
    if (pro_end < 0) return;   /* nothing to anchor on: leave the function alone */

    for (round = 0; round < 6; round++) {
        int changed = 0;
        for (i = pro_end + 1; i < nlines; i++) {
            char mn[24], bmn[16], nmn[24];
            char ops[AD_MAX_OP][AD_OPLEN];
            int nops, isdot, islab, cond, nex, k;
            int ab0, ab1, mdst, mbase, moff, midx, msh;

            if (L[i].del) continue;
            if (!ad_parse(L[i].t, mn, sizeof mn, ops, &nops, &isdot, &islab)) continue;
            if (isdot || islab) continue;
            if (nops < 1) continue;
            if (ad_is_cond(mn)) continue;
            ad_split_base(mn, bmn, &cond);

            nex = -1;
            for (k = i + 1; k < nlines; k++) {
                if (!L[k].del) { nex = k; break; }
            }

            /* ---- R0: MOV RD, RS then ADD/SUB RD, RD, #imm ----
             * The emitter forms an address (or any biased value) by copying
             * the source out of the value-stack pool and then adding to the
             * copy.  Thumb-2 encodes both in one instruction, and the MOV is
             * dead the moment the ADD overwrites RD, so the merge needs no
             * liveness check at all: the flags and the result are the ones
             * the ADD already produced.  Only the unsigned 12-bit immediate
             * of the ADD/SUB encoding is accepted; anything else (a negative
             * bias, a register operand) is left alone. */
            if (nex > 0 && ad_streq(mn, "MOV") && nops == 2 &&
                ad_whole_reg(ops[0], &ab0) && ad_whole_reg(ops[1], &ab1) &&
                ab0 <= 12 && ab1 <= 12 && ab0 != ab1) {
                char mn2[24], bc[16];
                char o2[AD_MAX_OP][AD_OPLEN];
                int n2, dot2, lab2, c2, d2 = -1, s2r = -1, i2 = 0;
                if (ad_parse(L[nex].t, mn2, sizeof mn2, o2, &n2, &dot2, &lab2) &&
                    !dot2 && !lab2 && n2 == 3 &&
                    (ad_streq(mn2, "ADD") || ad_streq(mn2, "SUB"))) {
                    ad_split_base(mn2, bc, &c2);
                    if (!c2 &&
                        ad_whole_reg(o2[0], &d2) && ad_whole_reg(o2[1], &s2r) &&
                        d2 == ab0 && s2r == ab0 &&
                        ad_imm_of(o2[2], &i2) && i2 >= 0 && i2 <= 4095) {
                        L[nex].t = ad_arith_line(bc, ab0, ab1, i2);
                        L[i].del = 1; changed = 1; continue;
                    }
                }
            }

            /* ---- R1/R2: ADD RD, RB, <#imm | RI> then an access through RD ----
             * RB is the value being indexed; RD may be RB itself (the usual
             * shape) or a third register. */
            if (nex > 0 && ad_streq(mn, "ADD") && (nops == 3 || nops == 4) &&
                ad_whole_reg(ops[0], &ab0) && ad_whole_reg(ops[1], &ab1) &&
                ab0 <= 12 && ab1 <= 12) {
                int form = 0, aimm = 0, aidx = -1, ash = 0;
                if (nops == 3 && ad_imm_of(ops[2], &aimm)) form = 1;
                else if (nops == 3 && ad_whole_reg(ops[2], &aidx) && aidx <= 12) form = 2;
                else if (nops == 4 && ad_whole_reg(ops[2], &aidx) && aidx <= 12 &&
                         ad_lsl_of(ops[3], &ash)) form = 2;
                mdst = -1; mbase = -1; moff = 0; midx = -1; msh = 0;
                if (form && ad_access(L[nex].t, nmn, sizeof nmn, &mdst, &mbase,
                                      &moff, &midx, &msh) &&
                    mbase == ab0 && midx < 0) {
                    if (form == 1) {
                        int s = aimm + moff;
                        /* When the access writes into the base register, the
                         * ADD's value is consumed by the address itself, so it
                         * is dead whether or not the register is live after it. */
                        if (ad_off_ok(s) &&
                            ((mdst == ab0 && ad_is_load(nmn)) ||
                             ad_dead_after(L, nlines, nex + 1, ab0))) {
                            L[nex].t = ad_mem_line(nmn, mdst, ab1, -1, 0, s);
                            L[i].del = 1; changed = 1; continue;
                        }
                    } else if (moff == 0 &&
                               ((mdst == ab0 && ad_is_load(nmn)) ||
                                ad_dead_after(L, nlines, nex + 1, ab0))) {
                        L[nex].t = ad_mem_line(nmn, mdst, ab1, aidx, ash, 0);
                        L[i].del = 1; changed = 1; continue;
                    }
                }
            }

            /* ---- R1b: ADD RB, RS, #imm, then an access through RB up to a
             * few lines later ----
             * The same fold as R1, except the access no longer has to be the
             * very next line.  ad_first_access() closes the window on a label,
             * a branch, a call, or any other mention of RB/RS, so the only
             * shapes that fold are the ones where RB holds the address and
             * nothing else happens to it in between.  Measured 2026-11-25 on
             * the 26-flag corpus: 189 candidate sites, 53 paid; the rest end a
             * block, where the death of the address register is not provable
             * from the text alone and ad_dead_after() refuses. */
            if (g_config.enable_opt_addr && ad_streq(mn, "ADD") && nops == 3 &&
                ad_whole_reg(ops[0], &ab0) && ad_whole_reg(ops[1], &ab1) &&
                ab0 <= 12 && ab1 <= 12) {
                int aimm2 = 0;
                if (ad_imm_of(ops[2], &aimm2)) {
                    int acc, adst = -1, aoff = 0, aidx = -1, ash = 0;
                    char amn[24];
                    acc = ad_first_access(L, nlines, i + 1, ab0, ab1, &adst, amn,
                                          (int)sizeof amn, &aoff, &aidx, &ash);
                    if (acc > 0 && aidx < 0) {
                        int s2 = aimm2 + aoff;
                        if (ad_off_ok(s2) &&
                            ((adst == ab0 && ad_is_load(amn)) ||
                             ad_dead_after(L, nlines, acc + 1, ab0))) {
                            L[acc].t = ad_mem_line(amn, adst, ab1, -1, 0, s2);
                            L[i].del = 1; changed = 1; continue;
                        }
                    }
                }
            }

            /* ---- R3: MOV RB, RS then an access through RB ---- */
            if (nex > 0 && ad_streq(mn, "MOV") && nops == 2 &&
                ad_whole_reg(ops[0], &ab0) && ad_whole_reg(ops[1], &ab1) &&
                ab0 <= 12 && ab1 <= 12 && ab0 != ab1) {
                mdst = -1; mbase = -1; moff = 0; midx = -1; msh = 0;
                if (ad_access(L[nex].t, nmn, sizeof nmn, &mdst, &mbase, &moff,
                              &midx, &msh) &&
                    mbase == ab0 &&
                    ((mdst == ab0 && ad_is_load(nmn)) ||
                     ad_dead_after(L, nlines, nex + 1, ab0))) {
                    if (midx >= 0)
                        L[nex].t = ad_mem_line(nmn, mdst, ab1, midx, msh, 0);
                    else
                        L[nex].t = ad_mem_line(nmn, mdst, ab1, -1, 0, moff);
                    L[i].del = 1; changed = 1; continue;
                }
            }

#if ARKCC_FEATURE_OPT_STRENGTH
            /* ---- R4: LSL rS, rI, #n then an access indexed by rS ----
             * -fopt-strength only, because that is the pass that turns an
             * element index into a shift; with it off this shape never
             * exists and the rule must stay inert.  R2 above is what brings
             * the two lines together: the emitter writes
             *
             *      LSL r1, r1, #2      ; index * element size
             *      ADD r0, r0, r1      ; base + index
             *      LDR r0, [r0, #0]
             *
             * so first the ADD disappears into the operand and only then is
             * the shift adjacent.  The round loop takes care of the order.
             *
             *      LSL rS, rI, #n (n = 1..3)      ->  LDR rT, [rB, rI, LSL #n]
             *      LDR rT, [rB, rS]
             *
             * Why the conditions are what they are:
             *   - only LDR/STR: a byte or halfword register offset has no
             *     shift field at all, so the merged form would not encode;
             *   - rI != rB: Thumb has no [Rn, Rn, LSL #n];
             *   - rS dead afterwards: in the in-place form (rS == rI, the
             *     emitted one) removing the LSL puts the *unscaled* index
             *     back into the register, so anything that still reads it
             *     would see a different value.  A load into rS makes it dead
             *     by itself, exactly as in R1.
             * Anything else is left alone: the worst case is a missed fold. */
            if (g_config.enable_opt_strength && nex > 0 &&
                ad_streq(mn, "LSL") && nops == 3) {
                int s_dst, s_src, s_sh;
                char abase[16];
                if (ad_whole_reg(ops[0], &s_dst) && ad_whole_reg(ops[1], &s_src) &&
                    s_dst <= 12 && s_src <= 12 &&
                    ad_imm_of(ops[2], &s_sh) && s_sh >= 1 && s_sh <= 3) {
                    mdst = -1; mbase = -1; moff = 0; midx = -1; msh = 0;
                    if (ad_access(L[nex].t, nmn, sizeof nmn, &mdst, &mbase,
                                  &moff, &midx, &msh)) {
                        int sc = 0;
                        ad_split_base(nmn, abase, &sc);
                        (void)sc;
                        if (midx == s_dst && msh == 0 && moff == 0 &&
                            mbase != s_src &&
                            (ad_streq(abase, "LDR") || ad_streq(abase, "STR")) &&
                            ((mdst == s_dst && ad_is_load(nmn)) ||
                             ad_dead_after(L, nlines, nex + 1, s_dst))) {
                            L[nex].t = ad_mem_line(nmn, mdst, mbase, s_src, s_sh, 0);
                            L[i].del = 1; changed = 1; continue;
                        }
                    }
                }
            }
#endif /* ARKCC_FEATURE_OPT_STRENGTH */

        }
        if (!changed) break;
    }

    /* ---- rebuild ---- */
    asmbuf_init(&out);
    for (i = 0; i < nlines; i++) {
        if (L[i].del) continue;
        asmbuf_puts(&out, L[i].t);
        if (i + 1 < nlines || last_nl) asmbuf_putc(&out, '\n');
    }
    /* Nothing changed?  Then leave the buffer exactly as it was. */
    if (out.len == b->len - from && memcmp(out.buf, b->buf + from, out.len) == 0) {
        return;
    }
    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 > b->cap) return;
    for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
    b->buf[from + out.len] = 0;
    b->len = from + out.len;
}
#endif /* ARKCC_FEATURE_OPT_ADDR */

/* 16 for a variadic function: the prologue pushed r0-r3 in front of the saved
 * registers, so every epilogue of that function has 16 extra bytes to drop.
 * Zero for everything else, which keeps the non-variadic output byte-identical. */
#if ARKCC_FEATURE_OPT_CBZ
/* ------------------- CMP #0 + branch -> CBZ/CBNZ (-fopt-cbz) -------------
 * The IR is a stack machine, so `if (x)` / `if (!x)` reaches this layer as
 *
 *      POP {r0}            ; or MOV r0, r5 under -fopt-vstack
 *      CMP r0, #0
 *      BEQ .L_fn_N         ; IR_JZ        (BNE for IR_JNZ)
 *
 * Cortex-M has one two-byte instruction that tests and branches:
 * `CBZ rN, label` (CBNZ for the negated form).  This pass rewrites the pair
 * in the emitted text, in the same layer as -fopt-vstack and -fopt-addr; the
 * IR is untouched.
 *
 * Three conditions have to hold before a pair may be replaced:
 *
 *  1. the target is 0..62 bytes FORWARD of the CBZ.  T1 has nothing else:
 *     Rn is a 3-bit field (so r0-r7 only) and imm5 = offset/2, with bit 5
 *     carried into bit 9.  The pass runs on text, before the assembler has
 *     placed a single byte, so it uses an UPPER BOUND on the size of the
 *     region between the branch and the label: 4 bytes for an instruction,
 *     8 for `LDR rt, =sym` (which expands to MOVW+MOVT), 0 for a metadata
 *     directive.  A data directive inside the region -- `.word`, `.align`,
 *     ... -- makes the pass decline instead of guessing a size.  An upper
 *     bound can only make the pass decline more often; it can never let it
 *     emit an out-of-range CBZ, which the assembler would turn into a hard
 *     error.
 *
 *     The offset does not depend on how far the label is from the original
 *     CMP in the final image: the CMP goes away, so both ends move two bytes
 *     closer, and what is left is (region between branch and label) - 2.
 *     That is why only the region is measured.
 *
 *  2. the flags that `CMP r0, #0` sets are not read before the next writer.
 *     The backend emits every CMP for the branch that follows it, so in
 *     practice this only has to catch hand-written inline asm.  The scan
 *     walks forward from the branch -- through the region and past the label,
 *     because both paths reach the label -- and accepts on the first flag
 *     writer, declines on the first flag reader (a conditional instruction,
 *     ADC/SBC/RSC), and declines on a call or an unconditional branch: not
 *     because flags cannot survive one, but because the pass cannot prove
 *     they do, and declining is always the safe answer.
 *
 *  3. the label is defined inside the slice this pass sees (one function).
 *
 * Everything else is left alone.  Numbers on the STM32F4 HAL corpus, the
 * gate list and the GNU assembler cross-check are in docs/CBZ_FOLD.md.
 */
#define CBZ_MAX_REGION 64      /* offset = region - 2, so region <= 64 */

typedef struct {
    char *r;    /* the line exactly as it was, indentation included: the rebuild
                 * writes this back, so an untouched line stays byte-for-byte the
                 * line it was.  (Rebuilding from the trimmed copy made this pass
                 * look like it had rewritten 53,000 lines when it fused a few
                 * hundred, and it stripped the indentation of every instruction
                 * in the file.) */
    char *t;    /* r with the padding stripped: what the analysis reads */
    int   del;  /* the branch half of a pair that was fused */
} CbzLine;

static int cbz_ieq(const char *a, const char *b)
{
    while (*a && *b) {
        int x = (*a >= 'a' && *a <= 'z') ? *a - 32 : *a;
        int y = (*b >= 'a' && *b <= 'z') ? *b - 32 : *b;
        if (x != y) return 0;
        a++; b++;
    }
    return *a == *b;
}

static void cbz_trim(char *s)
{
    char *p = s;
    int n;
    while (*p == ' ' || *p == '\t') p++;
    if (p != s) { char *d = s; while (*p) *d++ = *p++; *d = 0; }
    n = (int)strlen(s);
    while (n > 0 && (s[n-1] == ' ' || s[n-1] == '\t' || s[n-1] == '\r')) s[--n] = 0;
}

/* "<MNEMONIC, uppercased>" + "<the rest, trimmed>".  0 means a blank line. */
static int cbz_head(const char *t, char *mn, int mn_sz, char *rest, int rest_sz)
{
    int i = 0, j = 0;
    while (t[i] && t[i] != ' ' && t[i] != '\t') {
        int c = (t[i] >= 'a' && t[i] <= 'z') ? t[i] - 32 : t[i];
        if (j < mn_sz - 1) mn[j++] = (char)c;
        i++;
    }
    mn[j] = 0;
    while (t[i] == ' ' || t[i] == '\t') i++;
    j = 0;
    while (t[i] && j < rest_sz - 1) rest[j++] = t[i++];
    rest[j] = 0;
    cbz_trim(rest);
    return mn[0] != 0;
}

static void cbz_nospace(const char *in, char *out, int cap)
{
    int j = 0;
    while (*in && j < cap - 1) {
        if (*in != ' ' && *in != '\t') out[j++] = *in;
        in++;
    }
    out[j] = 0;
}

/* "r<0..7>,#0" exactly.  CBZ T1 reaches r0-r7 only, so a wider CMP is
 * declined rather than down-converted. */
static int cbz_reg_zero(const char *ops, int *reg)
{
    int n = 0;
    if (ops[0] != 'r' && ops[0] != 'R') return 0;
    if (ops[1] < '0' || ops[1] > '9') return 0;
    if (ops[2] >= '0' && ops[2] <= '9') return 0;
    if (ops[1] > '7') return 0;
    if (!cbz_ieq(ops + 2, ",#0")) return 0;
    *reg = ops[1] - '0';
    (void)n;
    return 1;
}

/* "name:" -> name (without the colon).  0 when the line is not a label. */
static int cbz_label_name(const char *t, char *name, int name_sz)
{
    int n = (int)strlen(t), i;
    if (n < 2 || t[n-1] != ':') return 0;
    if (t[0] == '\0') return 0;
    for (i = 0; i < n - 1 && i < name_sz - 1; i++) name[i] = t[i];
    name[i] = 0;
    return 1;
}

static int cbz_dot_prefix(const char *mn, const char *pre)
{
    int i = 0;
    while (pre[i]) {
        int a = (mn[i] >= 'a' && mn[i] <= 'z') ? mn[i] - 32 : mn[i];
        if (a != pre[i]) return 0;
        i++;
    }
    return 1;
}

/* A directive that occupies no code bytes.  Anything else that starts with a
 * dot (`.word`, `.align`, `.skip`, ...) has a size the pass would have to
 * model, so a region containing one is declined. */
static int cbz_dot_meta(const char *mn)
{
    static const char *const pre[] = {
        ".CFI", ".LOC", ".FILE", ".TYPE", ".SIZE", ".GLOBAL", ".WEAK",
        ".THUMB", ".SECTION", ".TEXT", ".DATA", ".BSS", ".SET", ".EQU",
        ".SYMVER", ".IDENT", ".ARCH", ".CPU", ".FMX", ".EABI", ".CODE", 0
    };
    int i;
    for (i = 0; pre[i]; i++) if (cbz_dot_prefix(mn, pre[i])) return 1;
    return 0;
}

static int cbz_writes_flags(const char *mn)
{
    static const char *const w[] = {
        "CMP", "CMN", "TST", "TEQ",
        "ADDS", "SUBS", "ANDS", "ORRS", "EORS", "BICS", "MVNS",
        "LSLS", "LSRS", "ASRS", "RORS", "MULS", "MOVS", "NEGS", 0
    };
    int i;
    for (i = 0; w[i]; i++) if (cbz_ieq(mn, w[i])) return 1;
    return 0;
}

/* Does this line consume the flags?  Checked after cbz_writes_flags(),
 * because ADDS/MOVS/... end in a spelling that looks like a condition code. */
static int cbz_reads_flags(const char *mn)
{
    static const char *const cc[] = {
        "EQ", "NE", "CS", "HS", "CC", "LO", "MI", "PL",
        "VS", "VC", "HI", "LS", "GE", "LT", "GT", "LE", "AL", 0
    };
    int n = (int)strlen(mn), i;
    if (cbz_ieq(mn, "ADC") || cbz_ieq(mn, "SBC") || cbz_ieq(mn, "RSC")) return 1;
    if (n >= 2 && (mn[0] == 'I' || mn[0] == 'i') && (mn[1] == 'T' || mn[1] == 't'))
        return 1;              /* IT / ITE / ITT ... */
    if (n < 3) return 0;
    for (i = 0; cc[i]; i++) {
        int a = (mn[n-2] >= 'a' && mn[n-2] <= 'z') ? mn[n-2] - 32 : mn[n-2];
        int b = (mn[n-1] >= 'a' && mn[n-1] <= 'z') ? mn[n-1] - 32 : mn[n-1];
        if (a == cc[i][0] && b == cc[i][1]) return 1;
    }
    return 0;
}

/* Index of `label:` (the first one at or after `from`), or -1. */
static int cbz_find_label(CbzLine *L, int nlines, int from, const char *label)
{
    int k;
    char name[128];
    for (k = from; k < nlines; k++) {
        if (L[k].del) continue;
        if (cbz_label_name(L[k].t, name, sizeof name) && strcmp(name, label) == 0)
            return k;
    }
    return -1;
}

/* Is the flags state left by the CMP still unread when a writer reaches it?
 *
 * The walk follows both the fall-through and the target of an unconditional
 * `B` (bounded), because the emitted `if` body ends with `B .L_end` and the
 * code after that label is reached from both sides.  A return ends the walk
 * successfully: nothing in this function reads the flags after it.  A call
 * ends it the other way -- the pass cannot prove the callee leaves the flags
 * alone, and declining is the safe answer. */
static int cbz_flags_dead(CbzLine *L, int nlines, int from)
{
    int i, steps = 0, jumps = 0;
    for (i = from; i < nlines && steps < 64; i++, steps++) {
        char mn[24], rest[128], name[128];
        if (L[i].del) continue;
        if (!cbz_head(L[i].t, mn, sizeof mn, rest, sizeof rest)) continue;
        if (cbz_label_name(L[i].t, name, sizeof name)) continue;
        if (mn[0] == '.') continue;
        if (cbz_writes_flags(mn)) return 1;
        if (cbz_reads_flags(mn)) return 0;
        if (cbz_ieq(mn, "BX") || cbz_ieq(mn, "BLX")) return 1;  /* return / tail call */
        /* A plain call kills the flags: AAPCS does not preserve NZCV across a
         * call, so whatever CMP set cannot be relied on past a BL.  Treating
         * the call as "flags are dead from here" is what lets a CMP #0 + Bcc
         * pair fuse into CBZ when the fall-through path leads into a call. */
        if (cbz_ieq(mn, "BL")) return 1;
        if (cbz_ieq(mn, "B")) {
            int k = (rest[0] == '.') ? cbz_find_label(L, nlines, 0, rest) : -1;
            if (k < 0 || ++jumps > 4) return 0;
            i = k - 1;
            continue;
        }
        if (cbz_ieq(mn, "POP") && rest[0]) {
            int k = 0;
            while (rest[k]) {
                if ((rest[k] == 'p' || rest[k] == 'P') &&
                    (rest[k+1] == 'c' || rest[k+1] == 'C') &&
                    (rest[k+2] == 0 || rest[k+2] == ',' || rest[k+2] == '}' ||
                     rest[k+2] == ' '))
                    return 1;       /* POP {..., pc}: this is a return */
                k++;
            }
        }
    }
    return steps >= 64 ? 0 : 1;
}

static char *cbz_dup(const char *s)
{
    int n = (int)strlen(s);
    char *p = (char *)mem_pool_alloc(n + 1);
    if (p) memcpy(p, s, n + 1);
    return p;
}

static char *cbz_new_line(const char *op, int reg, const char *label)
{
    AsmBuffer t;
    asmbuf_init(&t);
    asmbuf_puts(&t, "    ");
    asmbuf_puts(&t, op);
    asmbuf_puts(&t, " r");
    asmbuf_int(&t, reg);
    asmbuf_puts(&t, ", ");
    asmbuf_puts(&t, label);
    return cbz_dup(t.buf);
}

static void ark_cbz_function(AsmBuffer *b, int from)
{
    CbzLine *L = 0;
    int cap = 0, nlines = 0, i, pos, fused = 0;
    int last_nl = (b->len > from && b->buf[b->len - 1] == '\n');
    AsmBuffer out;

    /* ---- slice the function text into trimmed lines ---- */
    pos = from;
    while (pos < b->len) {
        int len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (nlines >= cap) {
            int ncap = cap ? cap * 2 : 128;
            CbzLine *grown = (CbzLine *)mem_pool_alloc(ncap * (int)sizeof(CbzLine));
            if (!grown) return;
            for (i = 0; i < nlines; i++) grown[i] = L[i];
            L = grown;
            cap = ncap;
        }
        L[nlines].r = (char *)mem_pool_alloc(len + 1);
        L[nlines].t = (char *)mem_pool_alloc(len + 1);
        if (!L[nlines].r || !L[nlines].t) return;
        for (i = 0; i < len; i++) {
            L[nlines].r[i] = b->buf[pos + i];
            L[nlines].t[i] = b->buf[pos + i];
        }
        L[nlines].r[len] = 0;
        L[nlines].t[len] = 0;
        cbz_trim(L[nlines].t);
        L[nlines].del = 0;
        nlines++;
        pos += len + 1;
    }

    for (i = 0; i < nlines; i++) {
        char mn[24], rest[128], tmn[24], trest[128], name[128], lab[128], ops[64];
        int reg = 0, br = -1, lb = -1, k, bytes = 0, ninstr = 0, bad = 0;
        const char *cemit;
        char *nl;

        if (L[i].del) continue;
        if (!cbz_head(L[i].t, mn, sizeof mn, rest, sizeof rest)) continue;
        if (!cbz_ieq(mn, "CMP")) continue;
        cbz_nospace(rest, ops, sizeof ops);
        if (!cbz_reg_zero(ops, &reg)) continue;

        /* the very next live line has to be the branch half */
        for (k = i + 1; k < nlines; k++) if (!L[k].del) { br = k; break; }
        if (br < 0) continue;
        if (!cbz_head(L[br].t, tmn, sizeof tmn, trest, sizeof trest)) continue;
        if (cbz_ieq(tmn, "BEQ"))      cemit = "CBZ";
        else if (cbz_ieq(tmn, "BNE")) cemit = "CBNZ";
        else continue;
        /* a single symbol, and one of ours (".L_..."): nothing else here is a
         * label this function can resolve */
        if (trest[0] != '.') continue;
        for (k = 0; trest[k]; k++)
            if (trest[k] == ' ' || trest[k] == ',' || trest[k] == '[') break;
        if (trest[k]) continue;
        if ((int)strlen(trest) >= (int)sizeof lab) continue;
        for (k = 0; k <= (int)strlen(trest); k++) lab[k] = trest[k];

        /* find the definition, forward only (T1 has no backward form) */
        for (k = br + 1; k < nlines; k++) {
            if (L[k].del) continue;
            if (cbz_label_name(L[k].t, name, sizeof name) &&
                strcmp(name, lab) == 0) { lb = k; break; }
        }
        if (lb < 0) continue;

        /* upper bound on the bytes between the branch and the label */
        for (k = br + 1; k < lb; k++) {
            char m3[24], r3[128];
            if (L[k].del) continue;
            if (!cbz_head(L[k].t, m3, sizeof m3, r3, sizeof r3)) continue;
            if (cbz_label_name(L[k].t, name, sizeof name)) continue;
            if (m3[0] == '.') {
                if (cbz_dot_meta(m3)) continue;   /* no code bytes */
                bad = 1;                          /* data: size not modelled */
                break;
            }
            ninstr++;
            bytes += (cbz_ieq(m3, "LDR") && r3[0] && r3[1] == ',' && r3[2] == '=') ? 8 : 4;
            if (bytes > CBZ_MAX_REGION) break;
        }
        if (bad || ninstr == 0 || bytes > CBZ_MAX_REGION) continue;
        if (!cbz_flags_dead(L, nlines, br + 1)) continue;

        nl = cbz_new_line(cemit, reg, lab);
        if (!nl) continue;
        L[i].t = nl;
        L[i].r = nl;
        L[br].del = 1;
        fused++;
    }
    if (!fused) return;

    /* ---- rebuild ---- */
    asmbuf_init(&out);
    for (i = 0; i < nlines; i++) {
        if (L[i].del) continue;
        asmbuf_puts(&out, L[i].r);
        if (i + 1 < nlines || last_nl) asmbuf_putc(&out, '\n');
    }
    /* Nothing changed?  Then leave the buffer exactly as it was. */
    if (out.len == b->len - from &&
        memcmp(out.buf, b->buf + from, out.len) == 0) return;
    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 > b->cap) return;
    for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
    b->buf[from + out.len] = 0;
    b->len = from + out.len;
}
#endif /* ARKCC_FEATURE_OPT_CBZ */

/* ------------------ bitmask complement cleanup (-fopt-bitmask) -----------
 * `x &= ~mask` reaches this layer as three instructions, because the
 * frontend materialises the *complement* of the mask:
 *
 *      MOV r0, #mask          ; r0 = mask
 *      MVN r0, r0             ; r0 = ~mask
 *      AND r7, r0             ; r7 &= ~mask
 *
 * The mask is nearly always a field mask (1, 2, 4, 0x10000), and `BIC` takes
 * a modified immediate, so the whole thing is one 32-bit instruction:
 *
 *      BIC r7, r7, #mask
 *
 * Same story one instruction shorter for `x = ~mask`, which arrives as
 * `MOV rX, #mask` / `MVN rX, rX` / `MOV rY, rX` and becomes `MVN rY, #mask`.
 *
 * This is a text pass like -fopt-cmat, for the same reason: the shape is
 * produced by the emitter (constant materialisation) and survives regalloc
 * with its three lines adjacent, so no IR knowledge is needed.
 *
 * What has to hold before a triple may be replaced:
 *
 *  1. the three live lines are adjacent (`MOV rX,#imm`, `MVN rX,rX`, consumer),
 *     imm != 0 and representable as a modified immediate -- otherwise the
 *     replacement would need a literal pool or two instructions and there is
 *     nothing to win;
 *  2. the consumer is exactly `AND rY, rX` or `MOV rY, rX`: the two-operand
 *     forms, with rY written.  Anything else in rX's place is left alone;
 *  3. rX is dead after the consumer, unless rX == rY on the AND path (then
 *     the replacement writes the same value back to rX).  "Dead" is proved by
 *     walking forward to the first line that mentions rX: a plain write of rX
 *     as the first operand ends the walk successfully, a `POP` whose list
 *     contains rX is such a write too, and a label is simply stepped over --
 *     the walk only ever covers a branch-free stretch, so whatever enters it
 *     reaches the same write without reading rX in between.  An unconditional
 *     `B .Lx` is followed to its target (at most four hops); any other branch,
 *     a call, an unknown mnemonic that mentions rX, or 40 lines without a
 *     proof all decline.  Bounded, so a long body simply fails to prove
 *     anything.
 *
 * Everything else is left untouched, and the pass only rebuilds the slice when
 * at least one triple was folded -- a build without the flag is byte-identical
 * by construction.
 */
#if ARKCC_FEATURE_OPT_BITMASK
typedef struct {
    char *r;    /* the line as it was, indentation included */
    char *t;    /* r with padding stripped: what the analysis reads */
    int   del;  /* a line the fold swallowed */
} BmkLine;

static int bmk_ieq(const char *a, const char *b)
{
    while (*a && *b) {
        int x = (*a >= 'a' && *a <= 'z') ? *a - 32 : *a;
        int y = (*b >= 'a' && *b <= 'z') ? *b - 32 : *b;
        if (x != y) return 0;
        a++; b++;
    }
    return *a == *b;
}

static void bmk_trim(char *s)
{
    char *p = s;
    int n;
    while (*p == ' ' || *p == '\t') p++;
    if (p != s) { char *d = s; while (*p) *d++ = *p++; *d = 0; }
    n = (int)strlen(s);
    while (n > 0 && (s[n-1] == ' ' || s[n-1] == '\t' || s[n-1] == '\r')) s[--n] = 0;
}

static int bmk_head(const char *t, char *mn, int mn_sz, char *rest, int rest_sz)
{
    int i = 0, j = 0;
    while (t[i] && t[i] != ' ' && t[i] != '\t') {
        int c = (t[i] >= 'a' && t[i] <= 'z') ? t[i] - 32 : t[i];
        if (j < mn_sz - 1) mn[j++] = (char)c;
        i++;
    }
    mn[j] = 0;
    while (t[i] == ' ' || t[i] == '\t') i++;
    j = 0;
    while (t[i] && j < rest_sz - 1) rest[j++] = t[i++];
    rest[j] = 0;
    bmk_trim(rest);
    return mn[0] != 0;
}

static int bmk_label(const char *t, char *name, int name_sz)
{
    int n = (int)strlen(t), i;
    if (n < 2 || t[n-1] != ':') return 0;
    for (i = 0; i < n - 1 && i < name_sz - 1; i++) name[i] = t[i];
    name[i] = 0;
    return 1;
}

static void bmk_skipsp(const char **pp)
{
    while (**pp == ' ' || **pp == '\t') (*pp)++;
}

/* "rN", N in 0..15, not followed by a sign (that would be an addressing mode). */
static int bmk_reg(const char **pp, int *reg)
{
    const char *p = *pp;
    int v;
    if ((p[0] != 'r' && p[0] != 'R') || p[1] < '0' || p[1] > '9') return 0;
    v = p[1] - '0';
    p += 2;
    if (v == 1 && *p >= '0' && *p <= '9') { v = 10 + (*p - '0'); p++; }
    if (v > 15) return 0;
    if (*p == '+' || *p == '-') return 0;
    *reg = v;
    *pp = p;
    return 1;
}

/* "rN, #<number>" and nothing else. */
static int bmk_reg_imm(const char *s, int *reg, unsigned *imm)
{
    const char *p = s;
    char *end;
    unsigned long v;
    bmk_skipsp(&p);
    if (!bmk_reg(&p, reg)) return 0;
    bmk_skipsp(&p);
    if (*p != ',') return 0;
    p++;
    bmk_skipsp(&p);
    if (*p != '#') return 0;
    p++;
    bmk_skipsp(&p);
    if (*p < '0' || *p > '9') return 0;          /* no sign, no symbol */
    v = strtoul(p, &end, 0);
    if (end == p) return 0;
    p = end;
    bmk_skipsp(&p);
    if (*p != 0) return 0;
    if (v > 0xFFFFFFFFUL) return 0;
    *imm = (unsigned)v;
    return 1;
}

/* "rA, rB" and nothing else. */
static int bmk_reg_reg(const char *s, int *ra, int *rb)
{
    const char *p = s;
    bmk_skipsp(&p);
    if (!bmk_reg(&p, ra)) return 0;
    bmk_skipsp(&p);
    if (*p != ',') return 0;
    p++;
    bmk_skipsp(&p);
    if (!bmk_reg(&p, rb)) return 0;
    bmk_skipsp(&p);
    return *p == 0;
}

/* Does `reg` appear as a register token anywhere in `s`? */
static int bmk_mentions(const char *s, int reg)
{
    while (*s) {
        if (*s == 'r' || *s == 'R') {
            const char *p = s;
            int r;
            if (bmk_reg(&p, &r)) {
                if (r == reg) return 1;
                s = p;
                continue;
            }
        }
        s++;
    }
    return 0;
}

/* Mnemonics whose first operand is written.  A whitelist on purpose: an
 * unknown mnemonic that mentions rX declines instead of being assumed to
 * write it. */
static int bmk_writes_first(const char *mn)
{
    static const char *const w[] = {
        "MOV", "MOVW", "MOVT", "MVN", "ADD", "ADDW", "SUB", "SUBW", "RSB",
        "ADC", "SBC", "AND", "ORR", "EOR", "BIC", "ORN",
        "LSL", "LSR", "ASR", "ROR", "RRX", "MUL", "MLA", "MLS",
        "UDIV", "SDIV", "UXTB", "UXTH", "SXTB", "SXTH",
        "LDR", "LDRB", "LDRH", "LDRSB", "LDRSH", "ADR", "CLZ",
        "REV", "REV16", "REVSH", "NEG", 0
    };
    int i;
    for (i = 0; w[i]; i++) if (bmk_ieq(mn, w[i])) return 1;
    return 0;
}

static int bmk_is_branch(const char *mn)
{
    static const char *const b[] = {
        "B", "BL", "BX", "BLX", "CBZ", "CBNZ", "TBB", "TBH", 0
    };
    static const char *const cc[] = {
        "EQ", "NE", "CS", "HS", "CC", "LO", "MI", "PL",
        "VS", "VC", "HI", "LS", "GE", "LT", "GT", "LE", "AL", 0
    };
    int i;
    for (i = 0; b[i]; i++) if (bmk_ieq(mn, b[i])) return 1;
    if ((mn[0] == 'B' || mn[0] == 'b') && strlen(mn) == 3) {
        for (i = 0; cc[i]; i++) {
            int a = (mn[1] >= 'a' && mn[1] <= 'z') ? mn[1] - 32 : mn[1];
            int c = (mn[2] >= 'a' && mn[2] <= 'z') ? mn[2] - 32 : mn[2];
            if (a == cc[i][0] && c == cc[i][1]) return 1;
        }
    }
    return 0;
}

/* The value left in `reg` by the fold is gone: prove nothing reads it before
 * the next plain write.  The scan is linear and gives up at the first branch,
 * so the region it proves is branch-free; that is why crossing a label is
 * sound even when something jumps to it -- whatever path enters the region
 * reaches the same write without reading `reg` in between.  A branch, a call,
 * an unknown mnemonic that mentions `reg`, or 40 lines without a proof all
 * decline. */
static int bmk_dead_from(BmkLine *L, int n, int from, int reg, int jumps);

static int bmk_dead(BmkLine *L, int n, int from, int reg)
{
    return bmk_dead_from(L, n, from, reg, 0);
}

static int bmk_dead_from(BmkLine *L, int n, int from, int reg, int jumps)
{
    int i, steps = 0;
    for (i = from; i < n && steps < 40; i++, steps++) {
        char mn[24], rest[128], name[128];
        if (L[i].del) continue;
        if (!bmk_head(L[i].t, mn, sizeof mn, rest, sizeof rest)) continue;
        if (bmk_label(L[i].t, name, sizeof name)) continue;
        if (mn[0] == '.') continue;
        if (bmk_ieq(mn, "B") && rest[0] == '.' && jumps < 4) {
            /* An unconditional branch has one successor: proving the value
             * dead after its target proves it dead here too.  Anything more
             * involved (a condition, a computed target) declines below. */
            int k, lb = -1;
            char nm[128];
            for (k = 0; rest[k] && rest[k] != ' ' && rest[k] != ',' && k < (int)sizeof nm - 1; k++)
                nm[k] = rest[k];
            nm[k] = 0;
            for (k = 0; k < n; k++) {
                char n2[128];
                if (L[k].del) continue;
                if (bmk_label(L[k].t, n2, sizeof n2) && strcmp(n2, nm) == 0) { lb = k; break; }
            }
            if (lb < 0) return 0;
            return bmk_dead_from(L, n, lb + 1, reg, jumps + 1);
        }
        if (bmk_is_branch(mn)) return 0;
        if (bmk_ieq(mn, "POP")) {
            /* POP {…} writes every register in its list (it reads memory, not
             * registers; sp is never `reg`).  A list without `reg` says
             * nothing about it. */
            if (bmk_mentions(rest, reg)) return 1;
            continue;
        }
        if (!bmk_mentions(mn, reg) && !bmk_mentions(rest, reg)) continue;
        if (!bmk_mentions(mn, reg) && bmk_writes_first(mn)) {
            const char *q = rest;
            int r0;
            if (bmk_reg(&q, &r0) && r0 == reg) return 1;
        }
        return 0;
    }
    return steps >= 40 ? 0 : 1;
}

static char *bmk_dup(const char *s)
{
    int n = (int)strlen(s);
    char *p = (char *)mem_pool_alloc(n + 1);
    if (p) memcpy(p, s, n + 1);
    return p;
}

static char *bmk_new_line(const char *op, int rd, int rn, unsigned imm)
{
    char t[80];
    AsmBuffer b;
    if (rn < 0) snprintf(t, sizeof t, "    %s r%d, #0x%X", op, rd, imm);
    else        snprintf(t, sizeof t, "    %s r%d, r%d, #0x%X", op, rd, rn, imm);
    asmbuf_init(&b);
    asmbuf_puts(&b, t);
    return bmk_dup(b.buf);
}

static void ark_bitmask_function(AsmBuffer *b, int from)
{
    BmkLine *L = 0;
    int cap = 0, nlines = 0, i, pos, folded = 0;
    int last_nl = (b->len > from && b->buf[b->len - 1] == '\n');
    AsmBuffer out;

    pos = from;
    while (pos < b->len) {
        int len = 0;
        while (pos + len < b->len && b->buf[pos + len] != '\n') len++;
        if (nlines >= cap) {
            int ncap = cap ? cap * 2 : 128;
            BmkLine *grown = (BmkLine *)mem_pool_alloc(ncap * (int)sizeof(BmkLine));
            if (!grown) return;
            for (i = 0; i < nlines; i++) grown[i] = L[i];
            L = grown;
            cap = ncap;
        }
        L[nlines].r = (char *)mem_pool_alloc(len + 1);
        L[nlines].t = (char *)mem_pool_alloc(len + 1);
        if (!L[nlines].r || !L[nlines].t) return;
        for (i = 0; i < len; i++) {
            L[nlines].r[i] = b->buf[pos + i];
            L[nlines].t[i] = b->buf[pos + i];
        }
        L[nlines].r[len] = 0;
        L[nlines].t[len] = 0;
        bmk_trim(L[nlines].t);
        L[nlines].del = 0;
        nlines++;
        pos += len + 1;
    }

    for (i = 0; i < nlines; i++) {
        char mn[24], rest[128], mn2[24], rest2[128], mn3[24], rest3[128];
        int x = -1, y = -1, rm = -1, k, j1 = -1, j2 = -1;
        unsigned imm = 0;
        char *nl;
        if (L[i].del) continue;
        if (!bmk_head(L[i].t, mn, sizeof mn, rest, sizeof rest)) continue;
        if (!bmk_ieq(mn, "MOV")) continue;
        if (!bmk_reg_imm(rest, &x, &imm)) continue;
        if (imm == 0) continue;                 /* BIC #0 would be bigger */
        {
            unsigned a, c, d;
            if (!thumb_imm12_a(imm, &a, &c, &d)) continue;
        }
        /* the next live line has to be `MVN rX, rX` */
        for (k = i + 1; k < nlines; k++) if (!L[k].del) { j1 = k; break; }
        if (j1 < 0) continue;
        if (!bmk_head(L[j1].t, mn2, sizeof mn2, rest2, sizeof rest2)) continue;
        if (!bmk_ieq(mn2, "MVN")) continue;
        {
            int a1 = -1, a2 = -1;
            if (!bmk_reg_reg(rest2, &a1, &a2)) continue;
            if (a1 != x || a2 != x) continue;
        }
        /* and then the consumer, which has to name rX as its second operand */
        for (k = j1 + 1; k < nlines; k++) if (!L[k].del) { j2 = k; break; }
        if (j2 < 0) continue;
        if (!bmk_head(L[j2].t, mn3, sizeof mn3, rest3, sizeof rest3)) continue;
        if (!bmk_reg_reg(rest3, &y, &rm)) continue;
        if (rm != x) continue;
        if (bmk_ieq(mn3, "AND")) {
            /* rY &= ~imm  ->  BIC rY, rY, #imm */
            if (y != x && !bmk_dead(L, nlines, j2 + 1, x)) continue;
            nl = bmk_new_line("BIC", y, y, imm);
        } else if (bmk_ieq(mn3, "MOV")) {
            /* rY = ~imm  ->  MVN rY, #imm */
            if (y != x && !bmk_dead(L, nlines, j2 + 1, x)) continue;
            nl = bmk_new_line("MVN", y, -1, imm);
        } else {
            continue;
        }
        if (!nl) continue;
        L[j2].t = nl;
        L[j2].r = nl;
        L[i].del = 1;
        L[j1].del = 1;
        folded++;
    }
    if (!folded) return;

    asmbuf_init(&out);
    for (i = 0; i < nlines; i++) {
        if (L[i].del) continue;
        asmbuf_puts(&out, L[i].r);
        if (i + 1 < nlines || last_nl) asmbuf_putc(&out, '\n');
    }
    if (out.len == b->len - from &&
        memcmp(out.buf, b->buf + from, out.len) == 0) return;
    asmbuf_reserve(b, from + out.len + 1);
    if (from + out.len + 1 > b->cap) return;
    for (i = 0; i < out.len; i++) b->buf[from + i] = out.buf[i];
    b->buf[from + out.len] = 0;
    b->len = from + out.len;
}
#endif /* ARKCC_FEATURE_OPT_BITMASK */

static int g_va_epilogue_pad;

/* Frame adjustment that does not fit one encoding.  SUBW/ADDW take 0..4095 and
 * the 16-bit forms at most 508, but a function's frame can be larger than that:
 * preproc.c's process() reserves 17208 bytes.  That used to be emitted as a
 * single "SUB sp, sp, #17208", which the assembler truncated with "& 0x7F" and
 * turned into "sub sp, #312" -- a wrong answer on a stack pointer, and it is
 * now a hard error instead.  Split it into <=4095 pieces: a handful of extra
 * instructions, once per function. */
static void emit_sp_adjust(AsmBuffer *b, int amount, int is_sub) {
    while (amount > 0) {
        int piece = (amount > 4095) ? 4095 : amount;
        asmbuf_puts(b, is_sub ? "    SUB sp, sp, #" : "    ADD sp, sp, #");
        asmbuf_int(b, piece);
        asmbuf_putc(b, '\n');
        amount -= piece;
    }
}

static void emit_prologue(AsmBuffer *b, const char *fn_name, int local_size,
                          int va_lo, int va_pad, int is_irq, int is_naked, int dbg) {
    asmbuf_puts(b, fn_name);
    asmbuf_puts(b, ":\n");
    if (dbg) emit_line(b, ".cfi_startproc");
    if (is_naked) {
        /* __naked: emit no prologue; the function body is entirely the user's responsibility */
        return;
    }
    /* Variadic: save the register argument words that can still hold a
     * variadic argument -- r_va_lo .. r3, where va_lo is NCRN rounded down to
     * an even number.  They then sit at [sp_entry-va_pad, sp_entry) -- directly
     * below the caller's stack argument block -- so the va region is the
     * caller's argument image verbatim, and the epilogue has va_pad extra bytes
     * to drop (see emit_epilogue_return).  va_pad is a multiple of 8, so the
     * frame keeps the 8-byte alignment AAPCS requires; va_pad == 0 means the
     * caller already spends r0-r3 on named arguments and nothing is pushed. */
    if (va_pad > 0) {
        int r;
        asmbuf_puts(b, "    PUSH {");
        for (r = va_lo; r < 4; r++) {
            if (r != va_lo) asmbuf_puts(b, ", ");
            asmbuf_puts(b, "r");
            asmbuf_int(b, r);
        }
        asmbuf_puts(b, "}\n");
    }
    if (is_irq) {
        /* __irq: Cortex-M hardware auto-saves r0-r3, r12, lr, pc, xpsr on
         * exception entry. We only need to save r5, r6, r7 (arkcc's
         * callee-saved registers used as frame pointer etc.) and lr
         * (EXC_RETURN) so that POP {pc} triggers exception return. */
        emit_line(b, "PUSH {r5, r6, r7, lr}");
    } else {
        emit_line(b, "PUSH {r5, r6, r7, lr}");
    }
    if (local_size > 0) emit_sp_adjust(b, local_size, 1);
    emit_line(b, "MOV r6, sp");
}

static void emit_epilogue_return(AsmBuffer *b, int local_size,
                                 int is_irq, int is_naked, int value_in_r0) {
    if (is_naked) {
        /* __naked: just return, do not restore stack/registers */
        emit_line(b, "BX lr");
        return;
    }
    /* --reg-top: the return value is already in r0 (the IR stack top lives in
     * r0), so popping it back into r0 would be a no-op pair.  Off, or when the
     * caller did not model it, this is the original emit_pop_r0(). */
    if (!value_in_r0) emit_pop_r0(b);
    emit_line(b, "MOV sp, r6");
    if (local_size > 0) emit_sp_adjust(b, local_size, 0);
    if (g_va_epilogue_pad) {
        /* Variadic: the prologue pushed r_va_lo..r3 *below* the saved registers
         * (so that the register argument words stay contiguous with the
         * caller's stack arguments), so after restoring the saved registers
         * another g_va_epilogue_pad bytes have to be dropped before returning.
         * POP into lr, drop the words, then branch -- POP {.., pc} cannot be
         * followed by a stack adjustment.  For an __irq handler lr holds
         * EXC_RETURN, and BX lr performs the exception return on M-profile, so
         * this shape is correct there too.  When nothing was pushed (all four
         * register words are named arguments) this branch is not taken and the
         * plain POP {.., pc} below is used. */
        emit_line(b, "POP {r5, r6, r7, lr}");
        emit_add_sp(b, g_va_epilogue_pad);
        emit_line(b, "BX lr");
    } else if (is_irq) {
        emit_line(b, "POP {r5, r6, r7, pc}");
    } else {
        emit_line(b, "POP {r5, r6, r7, pc}");
    }
}

/* Global variable SRAM address allocation for ARM backend.
 * Globals are placed in SRAM starting at 0x20000000; __at variables keep
 * their absolute address. Codegen emits MOVW/MOVT to load these addresses
 * instead of LDR =label (which the minimal assembler doesn't fully support). */
static const char *g_gvar_names[ARM_MAX_GVARS];
static unsigned    g_gvar_addrs[ARM_MAX_GVARS];
static int         g_gvar_sizes[ARM_MAX_GVARS];  /* #6 FIX: track global variable sizes */
static int         g_gvar_count = 0;

/* Global objects this unit defines, exported to -link as data symbols so that
 * another object can name their address (see gvar_assign / arm_save_syms).
 * Only non-static objects are here: a static one may legitimately share its
 * name with a static in another unit. */
typedef struct ArmDataSym {
    const char *name;
    unsigned    addr;
} ArmDataSym;
static ArmDataSym  g_obj_dsyms[ARM_MAX_SYMBOLS];
static int         g_obj_dsym_count = 0;

/* SCT-1/SCT-3: Custom section address tracking. When a global has a
 * g->section (from #pragma arm section / __attribute__((section))),
 * gvar_assign looks up the section's exec region base from the scatter
 * description and allocates variables contiguously from that base. Each
 * entry tracks the next free offset for one named section. Reset per
 * compilation in gvar_assign. */
/* Named sections tracked for #pragma arm section / __attribute__((section)).
 * Host 128 / board 16, overridable with -DARK_MAX_CUSTOM_SECTIONS. */
#define ARM_MAX_CUSTOM_SECTIONS ARK_MAX_CUSTOM_SECTIONS
static struct {
    const char *name;     /* section name (points into IrGlobal, lives through codegen) */
    unsigned    cur_addr; /* next free address within this section's exec region */
} g_custom_sect[ARM_MAX_CUSTOM_SECTIONS];
static int g_custom_sect_count = 0;

/* F3/S5: Track .data/.bss boundaries for startup initialization */
static unsigned g_data_sram_start = 0;  /* First .data SRAM address */
static unsigned g_data_sram_end   = 0;  /* One past last .data SRAM address */
static unsigned g_bss_sram_start  = 0;  /* First .bss SRAM address */
static unsigned g_bss_sram_end    = 0;  /* One past last .bss SRAM address */

/* Does `addr` point into this translation unit's own .data/.bss window?
 *
 * This has to exist in every build, including the ones where --reloc-data is
 * compiled out (ARKCC_PROFILE_STM32_MIN sets ARKCC_FEATURE_ARM_RELOC_DATA to
 * 0): the ten call sites in the store/load paths are shared, and leaving them
 * pointing at a function that the preprocessor removed produced
 * "addr_in_own_data declared implicitly" warnings and a link error, not a
 * working build.  With the feature off the four boundaries stay 0, so the
 * answer is always "no" -- which is exactly "nothing gets marked".
 */
static int addr_in_own_data(unsigned addr) {
    if (g_data_sram_start != g_data_sram_end &&
        addr >= g_data_sram_start && addr < g_data_sram_end) return 1;
    if (g_bss_sram_start != g_bss_sram_end &&
        addr >= g_bss_sram_start && addr < g_bss_sram_end) return 1;
    return 0;
}

#if ARKCC_FEATURE_ARM_RELOC_DATA
/* --reloc-data: data-address patch sites.
 *
 * -link has always concatenated code but has never been able to move a data
 * section: every object laid its globals out from the same SRAM base, so two
 * objects that both declare RAM aliased each other and the link refused with
 * "SRAM overlap".  Moving the data means rewriting every absolute address
 * baked into the instruction stream, and only codegen knows which MOVW/MOVT
 * pairs came from gvar_find() rather than from an unrelated 32-bit constant:
 * the encoding of 0x20000004 does not say whether it is an array address or
 * an integer literal.
 *
 * So codegen marks those pairs with the .arkdata pseudo-op and the assembler
 * records the offsets as relocation type 6; the linker adds the object's data
 * delta to each.  With the option off, not one byte changes: the marker is not
 * emitted and emit_mov_addr32() falls straight through to emit_mov_imm().
 */
#endif

/* Materialise `addr` in rd, flagging it for the linker when `marked`.
 *
 * `marked` is passed by the caller rather than derived here, because two
 * different facts are being expressed:
 *   - a global from gvar_find(): relocatable iff it sits inside this unit's own
 *     window (a __at variable or a variable in another scatter region must NOT
 *     move, so the caller asks addr_in_own_data());
 *   - the .data/.bss bounds used by __arkcc_init_globals: always relocatable,
 *     including the one-past-the-end bound that addr_in_own_data() rejects.
 *
 * The MOVW/MOVT pair is forced in the marked case: a 16-bit MOV has no halfword
 * for the linker to patch, so an armcc-style short form would silently keep a
 * stale address. */
static void emit_mov_addr32(AsmBuffer *b, int rd, unsigned addr, int marked) {
#if ARKCC_FEATURE_ARM_RELOC_DATA
    if (g_config.enable_reloc_data && marked) {
        asmbuf_puts(b, "    .arkdata\n");
        asmbuf_puts(b, "    MOVW r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, ", #");
        asmbuf_int(b, (int)(addr & 0xFFFFu));
        asmbuf_putc(b, '\n');
        asmbuf_puts(b, "    MOVT r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, ", #");
        asmbuf_int(b, (int)((addr >> 16) & 0xFFFFu));
        asmbuf_putc(b, '\n');
        return;
    }
#else
    (void)marked;
#endif
    emit_mov_imm(b, rd, (int)addr);
}

/* Scatter (.sct) load description: when --scatter <file> is given, the parsed
 * regions drive address assignment instead of the hardcoded defaults below.
 * g_flash_base is the base for code labels (LR load address); g_data_base /
 * g_bss_base are the SRAM origins for .data (+RW) and .bss (+ZI). These are
 * refreshed by arm_scatter_load() at the start of each codegen_arm() call. */
static ScatterDesc g_scatter;
static int          g_scatter_loaded = 0;
static unsigned     g_flash_base = 0x08000000u;  /* default STM32F4 Flash base */
static unsigned     g_data_base  = 0x20000000u;  /* default SRAM base */
static unsigned     g_bss_base   = 0x20000000u;  /* default SRAM base (.bss follows .data) */

/* Debug flag: when set, arm_assemble dumps the symbol map and scatter layout
 * after assembly. On host it is latched from getenv("ARKCC_DUMP_SYMS") at
 * arkcc startup by arm_dump_syms_init(); on STM32 getenv() is unavailable
 * under semihosting, so the flag is instead set by the UART "debug syms"
 * command. Defined here (early) so arm_scatter_load() can read it. */
int g_arm_dump_syms = 0;

/* --vector-table: reserve ARM_VT_SIZE bytes at the front of the image for the
 * Cortex-M vector table, so the table can be written *into* the reserved gap
 * instead of being prepended at link time.  Prepending shifts every byte by
 * 0x400; PC-relative Thumb-2 branches survive that, absolute addresses baked
 * by the assembler do not.  0 = old behaviour, byte for byte. */
int g_arm_vt_reserve = 0;

/* 1 when the selected CPU has a *double-precision* FPU (Cortex-M7 DP).
 * Double <-> float conversion is the one place where single-precision
 * hardware cannot stand in: VCVT.F64.F32 does not exist on the M4F's
 * fpv4-sp-d16, so emitting it there produces an instruction the assembler
 * rejects (and the core would fault on).  The software helper __aeabi_f2d /
 * __aeabi_d2f is used unless this is set.  Default 0: no -cpu means the
 * conservative path. */
int g_arm_fpu_dp = 0;

/* _Complex float object access: the expression stack carries complex values
 * as two doubles (four words), while a _Complex float object is 8 bytes of two
 * floats.  These two helpers convert one half in place, and deliberately use
 * the same instruction sequence (and the same hardware-FPU condition) as
 * IR_F2F, so a build with a single-precision FPU still gets the software
 * __aeabi_* helper instead of a VCVT the core would fault on. */
static void arm_cvt_f2d(AsmBuffer *buf) {
    /* in: r0 = float bits;  out: r0 = low word, r1 = high word */
#if ARKCC_FEATURE_FPU_HW
    if (g_config.enable_fpu_hw && g_arm_fpu_dp) {
        emit_line(buf, "VMOV s0, r0");
        emit_line(buf, "VCVT.F64.F32 d0, s0");
        emit_line(buf, "VMOV r0, s0");
        emit_line(buf, "VMOV r1, s1");
        return;
    }
#endif
    emit_line(buf, "BL __aeabi_f2d");
}

static void arm_cvt_d2f(AsmBuffer *buf) {
    /* in: r0 = low word, r1 = high word;  out: r0 = float bits */
#if ARKCC_FEATURE_FPU_HW
    if (g_config.enable_fpu_hw && g_arm_fpu_dp) {
        emit_line(buf, "VMOV s0, r0");
        emit_line(buf, "VMOV s1, r1");
        emit_line(buf, "VCVT.F32.F64 s0, d0");
        emit_line(buf, "VMOV r0, s0");
        return;
    }
#endif
    emit_line(buf, "BL __aeabi_d2f");
}


/* Cortex-M vector table: 256 entries, 1 KB.  Declared here (not next to
 * arm_link) because both the assembler -- which reserves this many bytes at the
 * front of the image -- and the linker need it. */
#define ARM_VT_ENTRIES 256
#define ARM_VT_SIZE   (ARM_VT_ENTRIES * 4)

/* Parse g_config.scatter_file (if set) into g_scatter and derive the Flash /
 * data / bss base addresses from the described execution regions. Called once
 * per compilation so the backend places sections per the scatter layout. */
/* Derive the code / .data / .bss base addresses from an already parsed
 * scatter description. The .sct path and the -T/--linker-script path must
 * share this rule: when only the linker-script branch derived the bases,
 * "--scatter <file>" parsed fine but left every address at the hardcoded
 * defaults, i.e. it was a silent no-op for code generation. */
#if ARKCC_FEATURE_SCATTER
static void arm_scatter_derive_bases(void) {
    g_flash_base = scatter_get_flash_base(&g_scatter);
    /* +RW region is the load origin for .data; +ZI for .bss.
     * If a +ZI region exists separately, .bss starts there, otherwise it
     * follows .data (set bss_base = data_base; gvar_assign lays them out
     * contiguously and records the real bss_start boundary). */
    g_data_base = scatter_get_data_base(&g_scatter, SCATTER_ATTR_RW);
    if (scatter_find_er_by_attr(&g_scatter, SCATTER_ATTR_ZI)) {
        g_bss_base = scatter_get_data_base(&g_scatter, SCATTER_ATTR_ZI);
    } else {
        g_bss_base = g_data_base;
    }
}
#endif

static void arm_scatter_load(void) {
    g_scatter_loaded = 0;
    g_scatter.load_regions = 0;
    g_scatter.error_count = 0;
    g_flash_base = 0x08000000u;
    g_data_base  = 0x20000000u;
    g_bss_base   = 0x20000000u;
#if ARKCC_FEATURE_SCATTER
    if (g_config.scatter_file && g_config.scatter_file[0] &&
        scatter_parse_file(g_config.scatter_file, &g_scatter) == 0) {
        g_scatter_loaded = 1;
        arm_scatter_derive_bases();
    } else if (g_config.linker_script && g_config.linker_script[0] &&
               linker_script_parse_file(g_config.linker_script, &g_scatter) == 0) {
        /* -T/--linker-script: parse GNU ld script the same way as .sct */
        g_scatter_loaded = 1;
        arm_scatter_derive_bases();
    }
#if ARKCC_FEATURE_SCATTER_CHECK
    /* 布局能不能用，在“派生基址之后、生成任何代码之前”就要判定：一旦把错误
     * 布局烘焙进地址，事后无法分辨是用户写错还是编译器读错。 */
    if (g_scatter_loaded) {
        scatter_validate(&g_scatter, g_flash_base, g_arm_vt_reserve);
    }
#endif
    if (g_scatter_loaded && g_arm_dump_syms) {
        ark_log("[scatter] flash=0x%08X data=0x%08X bss=0x%08X\n",
                g_flash_base, g_data_base, g_bss_base);
        scatter_dump(&g_scatter);
    }
#endif
}

/* Globals this unit only *declares* (extern): name + declared size.
 *
 * gvar_assign() skips externs, so gvar_find() answers 0 for them, and the old
 * emit path turned that into "MOV r1,#0 / STR r0,[r1]" with no relocation and
 * no diagnostic -- measured: the store landed on the vector table at power-on
 * and -link reported nothing.  Two things are missing for a correct answer:
 * the declared type (an `extern long long` must not be read as 32 bits) and a
 * name, because only -link knows where the defining unit's data ended up. */
static const char *g_ext_names[ARM_MAX_GVARS];
static int         g_ext_sizes[ARM_MAX_GVARS];
static int         g_ext_count = 0;

static void gvar_note_extern(const char *name, int size) {
    int i;
    if (!name || !name[0]) return;
    for (i = 0; i < g_ext_count; i++)
        if (ark_streq(g_ext_names[i], name)) return;   /* first declaration wins */
    if (g_ext_count >= ARM_MAX_GVARS) return;          /* reported by the caller */
    g_ext_names[g_ext_count] = name;
    g_ext_sizes[g_ext_count] = size;
    g_ext_count++;
}

static unsigned gvar_find(const char *name) {
    int i;
    for (i = 0; i < g_gvar_count; i++)
        if (ark_streq(g_gvar_names[i], name)) return g_gvar_addrs[i];
    return 0;
}

/* Ask the aggregate filler to keep the four bytes at `off` for us.  irgen
 * walked the same initialiser against the same type and recorded that offset;
 * an offset it did not record means the two walks disagree, and the filler
 * then fails rather than letting an address land in the wrong field. */
static int arm_agg_addr_hook(void *ud, int off, Type *t) {
    IrGlobal *g = (IrGlobal *)ud;
    int i;
    (void)t;
    if (!g) return 0;
    for (i = 0; i < g->init_ref_count; i++)
        if (g->init_refs[i].offset == off) return 1;
    return 0;
}

/* #6 FIX: Find global variable size by name */
static int gvar_find_size(const char *name) {
    int i;
    for (i = 0; i < g_gvar_count; i++)
        if (ark_streq(g_gvar_names[i], name)) return g_gvar_sizes[i];
    /* Declared only: the declaration still says how wide the object is, and a
     * 64-bit extern read as one word is a wrong answer, not a small one. */
    for (i = 0; i < g_ext_count; i++)
        if (ark_streq(g_ext_names[i], name)) return g_ext_sizes[i];
    return 4;  /* default 4 bytes */
}

#if ARKCC_FEATURE_OPT_IMM
/* 1 when this IR instruction pushes exactly one word back on the value stack.
 * -fopt-imm uses it for the "constant is the left operand" shape: when the
 * push after the constant is one of these, the constant can be swallowed and
 * the consumer's immediate form used instead.  Anything that pushes two words
 * (64-bit, struct) or nothing at all is refused, because then the binary op
 * would not see the operand pairing this fold assumes. */
static int ir_pushes_one_word(IrInst *I) {
    if (!I) return 0;
    switch (I->op) {
    case IR_PUSH_INT:
        return 1;
    case IR_PUSH_VAR:
        /* width in the low byte; volatile reads fall back in the emitter and a
         * 64-bit value is two words */
        if ((I->aux & 0xFF) >= 8) return 0;
        return 1;
    case IR_PUSH_ADDR:
        return 1;
    case IR_PUSH_GLOBAL_ADDR:
        return 1;
    case IR_PUSH_GLOBAL:
        return gvar_find_size(I->name) < 8;
    default:
        return 0;
    }
}
#endif

/* 1 = defined in this translation unit (`addr` valid), 2 = declared only,
 * 0 = unknown to this unit. */
static int gvar_kind(const char *name, unsigned *addr, int *size) {
    int i;
    for (i = 0; i < g_gvar_count; i++) {
        if (ark_streq(g_gvar_names[i], name)) {
            if (addr) *addr = g_gvar_addrs[i];
            if (size) *size = g_gvar_sizes[i];
            return 1;
        }
    }
    for (i = 0; i < g_ext_count; i++) {
        if (ark_streq(g_ext_names[i], name)) {
            if (size) *size = g_ext_sizes[i];
            return 2;
        }
    }
    return 0;
}

/* Materialise the address of the global object `name` in rd.
 *
 * Defined here: unchanged, a constant --reloc-data may shift.
 *
 * Declared only: there is no address in this object.  With --reloc-data the
 * site is tagged `.arkdatasym <name>` and the pair starts at 0, so -link can
 * add the defining object's final address in one place (the delta trick cannot
 * express this: the target may live in a *different* window).  Without the
 * flag no channel exists -- a single-object image has nowhere to carry another
 * unit's data address -- so the reference is reported instead of being baked
 * as 0.
 */
static void emit_gvar_addr32(AsmBuffer *b, int rd, const char *name) {
    unsigned addr = 0;
    int size = 4;
    int kind = gvar_kind(name, &addr, &size);
    (void)size;
    if (kind != 2) {
        emit_mov_addr32(b, rd, addr, addr_in_own_data(addr));
        return;
    }
#if ARKCC_FEATURE_ARM_RELOC_DATA
    if (g_config.enable_reloc_data) {
        asmbuf_puts(b, "    .arkdatasym ");
        asmbuf_puts(b, name);
        asmbuf_putc(b, '\n');
        asmbuf_puts(b, "    MOVW r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, ", #0\n    MOVT r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, ", #0\n");
        return;
    }
#endif
    {
        /* One diagnostic per distinct name: `errno` may be referenced dozens of
         * times in one unit, and 40 copies of the same sentence bury it. */
        static const char *reported[8];
        static int reported_n = 0;
        int i, seen = 0;
        for (i = 0; i < reported_n; i++)
            if (ark_streq(reported[i], name)) seen = 1;
        if (!seen) {
            if (reported_n < 8) reported[reported_n++] = name;
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "reference to the global '%s', which this translation unit "
                      "only declares; a single-object image carries no channel for "
                      "another unit's data address - compile this unit with "
                      "-c --reloc-data and link it with the object that defines "
                      "'%s'",
                      name, name, 0,0,0,0);
        }
    }
    emit_mov_imm(b, rd, 0);
}

/* --- --reg-top: keep the top of the IR stack in r0 ------------------------
 *
 * Every IR op is translated mechanically: operands are popped off the machine
 * stack into r0/r1 and the result is pushed back.  For `t = a + b` that is four
 * instructions of stack traffic around one ADD, and a return emits `PUSH {r0}`
 * immediately followed by `POP {r0}`.
 *
 * The bounded fix is not a register allocator but one invariant: the value on
 * top of the IR stack may live in r0 instead of on the machine stack.  Only the
 * ops listed in ark_top_try() are modelled; any other op first spills r0 back
 * (ark_top_drain) and then runs its existing sequence unchanged, so the blast
 * radius of a mistake is one op, not the whole backend.
 *
 * Control-flow joins drain too: a label can be reached from two paths, and both
 * must agree on where the IR stack's top is.  That is why IR_LABEL and the
 * function entry/exit drain even though they emit nothing themselves.
 *
 * Invariant: when *top is 1, the IR stack top is in r0 and everything below it
 * is on the machine stack in the usual order.
 */
static int ark_top_enabled(void) {
    return g_config.enable_reg_top ? 1 : 0;
}

/* va region helpers (defined further down, next to aapcs_assign because they
 * explain the same word indexing). ark_top_try() runs before them, so their
 * prototypes live here. */
#define ARK_VA_BASE 8000
static void emit_va_ptr(AsmBuffer *b, int reg);
static int  is_va_ptr_sym(const char *name);

/* 1 while the function being emitted is variadic (set by codegen_arm before
 * the spill, cleared for every function, so it never leaks across). */
static int g_va_active;

/* Name of the function whose code is being emitted right now.  Only the
 * diagnostics that fire inside the instruction switch need it, but they fire
 * from two different places (the --reg-top peephole and the main switch), so
 * it is set once per function instead of threaded through both. */
static const char *g_cur_fn_name;

/* _ark_va_ptr outside a variadic function: <stdarg.h> was used where there is
 * no argument block to point at (va_start in a function that is not declared
 * with "...").  The honest answer is an error -- the behaviour this replaces
 * emitted `MOV r0,#0 / LDR r0,[r0]`, i.e. it read word 0 of the vector table
 * (the initial SP) and handed it back as an argument pointer. */
static void va_ptr_needs_variadic(void) {
    diag_tool(DIAG_SEV_ERROR, "arkcc",
              "'_ark_va_ptr' is read in '%s', which is not variadic: "
              "va_start/va_arg only mean something inside a function declared "
              "with '...'",
              g_cur_fn_name ? g_cur_fn_name : "?", 0, 0, 0, 0, 0);
}

static void ark_top_drain(AsmBuffer *b, int *top) {
    if (*top) {
        emit_push_r0(b);
        *top = 0;
    }
}

/* Returns 1 when the instruction was fully emitted and the switch must be
 * skipped, 0 when the caller falls through to the generic path (with *top
 * already drained unless the op is a join point).
 * *ret_in_r0 is set for IR_RETURN so its epilogue can skip the redundant pop. */
static int ark_top_try(AsmBuffer *b, IrInst *I, int *top, int *ret_in_r0) {
    switch (I->op) {
    case IR_FUNC_BEGIN:
        *top = 0;                       /* prologue owns the machine stack */
        return 1;
    case IR_FUNC_END:
        ark_top_drain(b, top);
        return 1;
    case IR_LABEL:
    case IR_LABEL_NAMED:
        ark_top_drain(b, top);          /* join point: let the switch emit it */
        return 0;
    case IR_RETURN:
        *ret_in_r0 = *top;              /* epilogue skips its pop when set */
        *top = 0;
        return 0;                       /* epilogue lives in the switch */
    case IR_PUSH_INT:
        ark_top_drain(b, top);
        emit_mov_imm(b, 0, I->val);
        *top = 1;
        return 1;
    case IR_PUSH_VAR: {
        int width = I->aux & 0xFF;
        /* 64-bit pushes two words; volatile reads need their DMB pair. Both
         * fall back so those paths stay exactly as they were -- but only after
         * putting r0 back on the stack: "fall back" means the IR stack top is
         * where the generic path expects it (on the machine stack). Skipping
         * the drain left the word in r0 and every later pop read one slot too
         * high (measured: `long long b = 200;` under --reg-top stored the stale
         * r0 as the low half and 200 as the high half). */
        if (width >= 8) { ark_top_drain(b, top); return 0; }
        if (I->aux & IR_AUX_VOLATILE) { ark_top_drain(b, top); return 0; }
        ark_top_drain(b, top);
        if (width == 1)
            asmbuf_puts(b, (I->aux & 0x100) ? "    LDRB r0, [r6, #"
                                            : "    LDRSB r0, [r6, #");
        else if (width == 2)
            asmbuf_puts(b, (I->aux & 0x100) ? "    LDRH r0, [r6, #"
                                            : "    LDRSH r0, [r6, #");
        else
            asmbuf_puts(b, "    LDR r0, [r6, #");
        asmbuf_int(b, I->val);
        asmbuf_puts(b, "]\n");
        *top = 1;
        return 1;
    }
    case IR_PUSH_ADDR:
        ark_top_drain(b, top);
        asmbuf_puts(b, "    ADD r0, r6, #");
        asmbuf_int(b, I->val);
        asmbuf_putc(b, '\n');
        *top = 1;
        return 1;
    case IR_PUSH_GLOBAL: {
        unsigned addr;
        if (is_va_ptr_sym(I->name)) {
            if (!g_va_active) va_ptr_needs_variadic();
            ark_top_drain(b, top);
            emit_va_ptr(b, 0);
            *top = 1;
            return 1;
        }
        if (gvar_find_size(I->name) >= 8) {           /* two words: fall back */
            ark_top_drain(b, top);
            return 0;
        }
        ark_top_drain(b, top);
        emit_gvar_addr32(b, 0, I->name);
        emit_line(b, "LDR r0, [r0]");
        *top = 1;
        return 1;
    }
    case IR_PUSH_GLOBAL_ADDR: {
        ark_top_drain(b, top);
        emit_gvar_addr32(b, 0, I->name);
        *top = 1;
        return 1;
    }
    case IR_BINARY:
        if (*top) {
            /* right operand is in r0, left one is on the stack under it */
            asmbuf_puts(b, "    MOV r1, r0\n");
            emit_pop_r0(b);
        } else {
            emit_pop_r1(b);
            emit_pop_r0(b);
        }
        emit_binary(b, I->aux);
        *top = 1;
        return 1;
    case IR_UNARY:
        /* 64-bit forms touch two stack slots (I->val carries the width) and a
         * float/double form is not a one-word integer either, so the one-word
         * model does not apply to either: fall back with the stack drained. */
        if (I->val == 1 || I->val == 2) { ark_top_drain(b, top); return 0; }
        if (I->aux & IR_AUX_COMPLEX) { ark_top_drain(b, top); return 0; }
        if (!*top) emit_pop_r0(b);
        emit_unary(b, I->aux);
        *top = 1;
        return 1;
    case IR_TRUNC:
        if (I->val == 8 || I->val == 16) {
            char op8[8];
            op8[0] = I->aux ? 'U' : 'S';
            op8[1] = 'X';
            op8[2] = 'T';
            op8[3] = (I->val == 8) ? 'B' : 'H';
            op8[4] = 0;
            if (!*top) emit_pop_r0(b);
            asmbuf_puts(b, "    ");
            asmbuf_puts(b, op8);
            asmbuf_puts(b, " r0, r0\n");
            *top = 1;
        }
        /* 32-bit widths need no work either way. */
        return 1;
    case IR_STORE_GLOBAL: {
        unsigned addr = gvar_find(I->name);
        if (gvar_find_size(I->name) >= 8) {
            ark_top_drain(b, top);                    /* two words: fall back */
            return 0;
        }
        if (!*top) emit_pop_r0(b);
        emit_gvar_addr32(b, 1, I->name);
        emit_line(b, "STR r0, [r1]");
        *top = 0;                        /* the store consumes the value */
        return 1;
    }
    case IR_STORE: {
        /* Local store: the generic path pops the value into r0 and writes it.
         * With the value already in r0 that is one whole push/pop pair saved
         * per assignment, which is the single most common IR pair in C code.
         * Only the plain 1/2/4-byte non-volatile forms are modelled. */
        int sw = I->aux & ~IR_AUX_VOLATILE;
        int is_volatile = (I->aux & IR_AUX_VOLATILE) != 0;
        if (sw == 0) sw = 4;
        if (is_volatile || sw >= 8) {
            ark_top_drain(b, top);                    /* not modelled: fall back */
            return 0;
        }
        if (!*top) emit_pop_r0(b);
        if (sw == 1) {
            asmbuf_puts(b, "    STRB r0, [r6, #");
            asmbuf_int(b, I->val);
            asmbuf_puts(b, "]\n");
        } else if (sw == 2) {
            asmbuf_puts(b, "    STRH r0, [r6, #");
            asmbuf_int(b, I->val);
            asmbuf_puts(b, "]\n");
        } else {
            asmbuf_puts(b, "    STR r0, [r6, #");
            asmbuf_int(b, I->val);
            asmbuf_puts(b, "]\n");
        }
        *top = 0;                        /* the store consumes the value */
        return 1;
    }
    case IR_POP:
        if (*top) *top = 0;              /* dropping a value in a register costs nothing */
        else emit_pop_r0(b);
        return 1;
    case IR_DUP:
        /* val > 1 asks for a multi-word duplicate (a long long is two stack
         * words); the register-top form can only model one word, so let the
         * generic emitter handle it. */
        if (I->val > 1) {
            ark_top_drain(b, top);
            return 0;
        }
        if (*top) {
            asmbuf_puts(b, "    PUSH {r0}\n");   /* one copy on the stack, one in r0 */
            return 1;
        }
        return 0;
    default:
        ark_top_drain(b, top);
        return 0;
    }
}

static int gvar_known(const char *name) {
    int i;
    for (i = 0; i < g_gvar_count; i++)
        if (ark_streq(g_gvar_names[i], name)) return 1;
    return 0;
}

/* SCT-1/SCT-3: Allocate `sz` bytes from the named custom section's exec region.
 * Looks up the section base via scatter_get_er_base_for_section the first time
 * the section is seen, then hands out consecutive addresses from that base.
 * Returns the assigned address, or 0 if the section is not described in the
 * scatter file (or no scatter is loaded) -- in that case the caller falls
 * back to the default .data/.bss sequential allocation. */
static unsigned custom_sect_alloc(const char *section_name, int sz) {
    int i;
    unsigned base, addr;
    /* Existing section: continue from the tracked offset. */
    for (i = 0; i < g_custom_sect_count; i++) {
        if (ark_streq(g_custom_sect[i].name, section_name)) {
            g_custom_sect[i].cur_addr = (g_custom_sect[i].cur_addr + 3) & ~3u;
            addr = g_custom_sect[i].cur_addr;
            g_custom_sect[i].cur_addr += sz;
            return addr;
        }
    }
    /* New section: resolve its base from the scatter description. */
    if (g_custom_sect_count >= ARM_MAX_CUSTOM_SECTIONS) {
        /* Returning 0 makes the caller fall back to default SRAM, i.e. the
         * variable lands at an address the scatter file did not ask for.
         * Report it so the build fails instead of shipping the wrong address. */
        char b1[12];
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "more than %s distinct named sections; raise "
                  "ARK_MAX_CUSTOM_SECTIONS and rebuild arkcc",
                  diag_num(b1, ARM_MAX_CUSTOM_SECTIONS), 0,0,0,0,0);
        return 0;
    }
#if ARKCC_FEATURE_SCATTER
    base = scatter_get_er_base_for_section(&g_scatter, section_name);
#else
    base = 0;
#endif
    if (base == 0) return 0;  /* not found: caller falls back to default */
    g_custom_sect[g_custom_sect_count].name = section_name;
    g_custom_sect[g_custom_sect_count].cur_addr = (base + 3) & ~3u;
    addr = g_custom_sect[g_custom_sect_count].cur_addr;
    g_custom_sect[g_custom_sect_count].cur_addr += sz;
    g_custom_sect_count++;
    return addr;
}

static void gvar_assign(IrProgram *prog) {
    unsigned data_sram = g_data_base;   /* .data origin (scatter +RW or 0x20000000) */
    unsigned bss_sram;                  /* .bss origin (computed below) */
    int gi;
    g_gvar_count = 0;
    /* Both passes below stop at ARM_MAX_GVARS, and a global without an address
     * is worse than a failure: the emit path either reports something obscure
     * or uses a stale address.  Count first, refuse once, name the macro. */
    {
        int need = 0, k;
        for (k = 0; k < prog->global_count; k++) {
            if (!prog->globals[k]->is_extern) need++;
        }
        if (need > ARM_MAX_GVARS) {
            char b1[12], b2[12];
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "%s global objects in this file but the address table holds "
                      "%s; raise ARM_MAX_GVARS and rebuild arkcc",
                      diag_num(b1, need), diag_num(b2, ARM_MAX_GVARS), 0,0,0,0);
            return;
        }
    }
    /* What this unit only declares: the declared type decides how many words
     * an access has to load, and the name is what -link resolves the address
     * against later. */
    g_ext_count = 0;
    for (gi = 0; gi < prog->global_count; gi++) {
        IrGlobal *g = prog->globals[gi];
        int esz;
        if (!g->is_extern || !g->name) continue;
        esz = g->type ? type_size(g->type) : 4;
        if (esz <= 0) esz = 4;
        gvar_note_extern(g->name, esz);
    }
    g_obj_dsym_count = 0;  /* rebuilt below, once every address is final */
    g_custom_sect_count = 0;  /* SCT-1/SCT-3: reset custom section tracking */
    g_data_sram_start = data_sram;  /* will be updated if .data globals exist */
    g_data_sram_end = data_sram;
    g_bss_sram_start = data_sram;
    g_bss_sram_end = data_sram;

    /* F3/S5: First pass - assign .data (initialized) globals to SRAM.
     * This ensures .data globals are contiguous, followed by .bss globals.
     * The startup code (__arkcc_init_globals) initializes .data and zeros .bss. */
    for (gi = 0; gi < prog->global_count && g_gvar_count < ARM_MAX_GVARS; gi++) {
        IrGlobal *g = prog->globals[gi];
        int sz;
        if (g->is_extern) continue;
        if (g->has_at) continue;  /* __at variables keep their absolute address */
        if (!g->has_init) continue;  /* skip .bss for now */
        /* Zero-initialized scalars go to .bss */
        if (!g->init_aggregate && !g->init_str && !g->init_sym && !g->is_float && g->init_int == 0) continue;
        sz = g->type ? type_size(g->type) : 4;
        if (sz <= 0) sz = 4;
        /* SCT-1/SCT-3: custom section globals get their address from the
         * scatter exec region rather than the default .data pool. */
        if (g->section && g_scatter_loaded) {
            unsigned caddr = custom_sect_alloc(g->section, sz);
            if (caddr) {
                g_gvar_names[g_gvar_count] = g->name;
                g_gvar_addrs[g_gvar_count] = caddr;
                g_gvar_sizes[g_gvar_count] = sz;
                g_gvar_count++;
                continue;
            }
            /* section not found in scatter: fall through to .data allocation */
        }
        /* Honour __align(n) / _Alignas(n) / __attribute__((aligned(n))):
         * an over-aligned object placed at 4 bytes would silently break
         * every DMA / cache-line assumption the program makes. */
        {
            unsigned req = (g->align_bytes > 4) ? (unsigned)g->align_bytes : 4u;
            unsigned rem = data_sram % req;
            if (rem) data_sram += req - rem;
        }
        g_gvar_names[g_gvar_count] = g->name;
        g_gvar_addrs[g_gvar_count] = data_sram;
        g_gvar_sizes[g_gvar_count] = sz;  /* #6 FIX */
        g_gvar_count++;
        data_sram += sz;
    }
    /* #BSS-ALIGN FIX: Align .data end / .bss start to 4 bytes so the
     * __arkcc_init_globals zeroing loop starts at an aligned address.
     * STR r2, [r0] on an unaligned r0 can fault on Cortex-M. */
    data_sram = (data_sram + 3) & ~3u;
    g_data_sram_end = data_sram;

    /* .bss origin: when scatter defines a separate +ZI region, .bss starts
     * there; otherwise it follows .data contiguously. Take the higher of the
     * +ZI base and the .data end so .data and .bss never overlap. */
    bss_sram = (g_bss_base > data_sram) ? g_bss_base : data_sram;
    g_bss_sram_start = bss_sram;

    /* Second pass - assign .bss (uninitialized/zero) globals after .data */
    for (gi = 0; gi < prog->global_count && g_gvar_count < ARM_MAX_GVARS; gi++) {
        IrGlobal *g = prog->globals[gi];
        int sz;
        if (g->is_extern) continue;
        if (g->has_at) {
            /* __at variables: add to lookup table with their absolute address */
            g_gvar_names[g_gvar_count] = g->name;
            g_gvar_addrs[g_gvar_count] = g->at_addr;
            g_gvar_sizes[g_gvar_count] = g->type ? type_size(g->type) : 4;  /* #6 FIX */
            g_gvar_count++;
            continue;
        }
        if (g->has_init) {
            /* Non-zero initialized globals were assigned in .data pass above.
             * Zero-initialized scalars (init_int==0, no aggregate/str/float) were
             * skipped in .data and should be assigned here in .bss. */
            if (!(g->init_aggregate || g->init_str || g->init_sym || g->is_float) && g->init_int == 0) {
                /* zero-initialized scalar: assign in .bss */
            } else {
                continue;  /* already assigned in .data */
            }
        }
        sz = g->type ? type_size(g->type) : 4;
        if (sz <= 0) sz = 4;
        /* SCT-1/SCT-3: custom section globals get their address from the
         * scatter exec region rather than the default .bss pool. */
        if (g->section && g_scatter_loaded) {
            unsigned caddr = custom_sect_alloc(g->section, sz);
            if (caddr) {
                g_gvar_names[g_gvar_count] = g->name;
                g_gvar_addrs[g_gvar_count] = caddr;
                g_gvar_sizes[g_gvar_count] = sz;
                g_gvar_count++;
                continue;
            }
            /* section not found in scatter: fall through to .bss allocation */
        }
        {
            unsigned req = (g->align_bytes > 4) ? (unsigned)g->align_bytes : 4u;
            unsigned rem = bss_sram % req;
            if (rem) bss_sram += req - rem;
        }
        g_gvar_names[g_gvar_count] = g->name;
        g_gvar_addrs[g_gvar_count] = bss_sram;
        g_gvar_sizes[g_gvar_count] = sz;  /* #6 FIX */
        g_gvar_count++;
        bss_sram += sz;
    }
    /* #BSS-ALIGN FIX: Align .bss end to 4 bytes. The __arkcc_init_globals
     * zeroing loop increments r0 by 4 and terminates with CMP r0, r1; BNE.
     * If the last .bss variable's size is not a multiple of 4 (e.g. a char
     * or uint8_t array), r0 would never equal r1, causing an infinite loop
     * that writes zeros past .bss into adjacent memory or HardFault. */
    g_bss_sram_end = (bss_sram + 3) & ~3u;

    /* Cross-object data symbols for -link.
     *
     * Object files used to carry code labels only, so a unit that referenced
     * `errno` had no way to name the object the *other* unit had defined.  Every
     * non-static global defined here is exported with type 1 and its absolute
     * address in the offset field (see arm_save_syms; the linker treats that
     * field differently from a code label's offset).  `__at` objects are skipped:
     * their address is fixed by the programmer and must not follow the window. */
    g_obj_dsym_count = 0;
    for (gi = 0; gi < prog->global_count; gi++) {
        IrGlobal *g = prog->globals[gi];
        unsigned a;
        if (g->is_extern || g->is_static || g->has_at) continue;
        if (!g->name || !g->name[0]) continue;
        a = gvar_find(g->name);
        if (a == 0) continue;
        if (g_obj_dsym_count >= ARM_MAX_SYMBOLS) {
            char b1[12], b2[12];
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "%s global objects did not fit the %s-entry object symbol "
                      "table; raise ARM_MAX_SYMBOLS and rebuild arkcc",
                      diag_num(b1, g_obj_dsym_count),
                      diag_num(b2, ARM_MAX_SYMBOLS), 0,0,0,0);
            break;
        }
        g_obj_dsyms[g_obj_dsym_count].name = g->name;
        g_obj_dsyms[g_obj_dsym_count].addr = a;
        g_obj_dsym_count++;
    }

    /* Scatter overflow check: warn (do not fail) if .data/.bss grew past their
     * declared execution-region size. Helps catch layout mistakes early. */
#if ARKCC_FEATURE_SCATTER
    if (g_scatter_loaded) {
        ScatterExecRegion *rw_er = scatter_find_er_by_attr(&g_scatter, SCATTER_ATTR_RW);
        ScatterExecRegion *zi_er = scatter_find_er_by_attr(&g_scatter, SCATTER_ATTR_ZI);
        if (rw_er && !scatter_er_fits(rw_er, g_data_sram_start,
                                      g_data_sram_end - g_data_sram_start))
            ark_log("[scatter] warning: .data (0x%X..0x%X) overflows %s (size 0x%X)\n",
                    g_data_sram_start, g_data_sram_end, rw_er->name, rw_er->size);
        if (zi_er && !scatter_er_fits(zi_er, g_bss_sram_start,
                                      g_bss_sram_end - g_bss_sram_start))
            ark_log("[scatter] warning: .bss (0x%X..0x%X) overflows %s (size 0x%X)\n",
                    g_bss_sram_start, g_bss_sram_end, zi_er->name, zi_er->size);
    }
#endif
}

#if ARKCC_FEATURE_RT_LAZY
/* 运行库按需发射（--rt-lazy）。
 *
 * 问题：每个翻译单元都会把全部 __aeabi_* 辅助函数打进产物，于是一个 56 字节的
 * 源文件也能编出 1578 字节代码，其中绝大多数是永远调用不到的 64 位与浮点辅助。
 * 链接器虽然能去重，但单个对象本身的体积仍然虚高。
 *
 * 做法：在汇编文本层面把每个辅助函数整块切下来，从"用户代码 + 已被判定需要的
 * 辅助函数"出发求一次可达闭包（辅助函数之间也会互相调用，例如
 * __aeabi_ldivmod 调 __aeabi_uldivmod），只保留可达的块。
 *
 * 为什么在文本层做而不是在 IR 层做：辅助函数是后端直接写死的汇编文本，没有对应
 * 的 IR 指令；在文本层按名字求闭包，判断依据只有一处（名字是否被引用），不会
 * 出现"IR 认为不需要、后端却发了 BL"的分裂。
 *
 * 安全性：只删「整块、且从未被保留代码引用」的辅助函数；名字匹配带前后边界，
 * 避免 __aeabi_ladd 误命中 __aeabi_laddx 这类前缀相同的情况。
 */
#define RT_MAX_BLOCKS 80

typedef struct {
    int         start;
    int         end;
    const char *name;
    int         name_len;
    int         used;
} RtBlock;

static int rt_is_ident_char(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
           (c >= '0' && c <= '9') || c == '_';
}

static int rt_refs_name(const char *s, int from, int to, const char *name, int nl) {
    int i;
    for (i = from; i + nl <= to; i++) {
        if (s[i] != name[0]) continue;
        if (memcmp(s + i, name, (unsigned)nl) != 0) continue;
        if (i > from && rt_is_ident_char(s[i - 1])) continue;
        if (i + nl < to && rt_is_ident_char(s[i + nl])) continue;
        return 1;
    }
    return 0;
}

static int rt_prune_asm_text(char *text, int len) {
    RtBlock blk[RT_MAX_BLOCKS];
    int n = 0, i, changed = 1;
    int user_end;

    /* 1. 切块：块首是行首的 ".global __aeabi_"，块尾是下一个行首的 ".global "
     *    或文件末尾。用 ".global " 而不是 ".global __aeabi_" 当结束标志，
     *    是因为最后一个 __aeabi_ 块之后可能紧跟 __arkcc_* 辅助函数
     *    （例如浮点比较用的 __arkcc_fcmp3），那些不属于可删范围。 */
    for (i = 0; i + 16 < len; i++) {
        if (i != 0 && text[i - 1] != '\n') continue;
        if (memcmp(text + i, ".global __aeabi_", 16) != 0) continue;
        {
            int ns = i + 8;
            int e = ns;
            while (e < len && text[e] != '\n' && text[e] != '\r') e++;
            blk[n].start = i;
            blk[n].end = len;
            blk[n].name = text + ns;
            blk[n].name_len = e - ns;
            blk[n].used = 0;
            n++;
            if (n >= RT_MAX_BLOCKS) break;
        }
    }
    if (n == 0) return len;

    for (i = 0; i + 1 < n; i++) blk[i].end = blk[i + 1].start;

    /* 2. 用户区（第一个辅助块之前）里出现的名字就是种子 */
    user_end = blk[0].start;
    for (i = 0; i < n; i++) {
        if (rt_refs_name(text, 0, user_end, blk[i].name, blk[i].name_len)) blk[i].used = 1;
    }

    /* 3. 可达闭包 */
    while (changed) {
        changed = 0;
        for (i = 0; i < n; i++) {
            int j;
            if (!blk[i].used) continue;
            for (j = 0; j < n; j++) {
                if (blk[j].used) continue;
                if (rt_refs_name(text, blk[i].start, blk[i].end, blk[j].name, blk[j].name_len)) {
                    blk[j].used = 1;
                    changed = 1;
                }
            }
        }
    }

    /* 4. 原地压实 */
    {
        int w = 0;
        int r = 0;
        for (i = 0; i < n; i++) {
            if (blk[i].start > r) {
                int gap = blk[i].start - r;
                if (w != r) memmove(text + w, text + r, (unsigned)gap);
                w += gap;
            }
            if (blk[i].used) {
                int sz = blk[i].end - blk[i].start;
                if (w != blk[i].start) memmove(text + w, text + blk[i].start, (unsigned)sz);
                w += sz;
            }
            r = blk[i].end;
        }
        if (len > r) {
            int tail = len - r;
            if (w != r) memmove(text + w, text + r, (unsigned)tail);
            w += tail;
        }
        len = w;
        text[len] = 0;
    }
    return len;
}
#endif /* ARKCC_FEATURE_RT_LAZY */

/* Does a value of this type come back in two core registers (r0:r1)?
 *
 * long long / double always do.  A composite of 5..8 bytes does too: AAPCS
 * puts a composite that fits in two words into r0:r1, and the caller reads it
 * back with IR_STORE_IDX/8.  A smaller composite comes back in r0 alone.
 * Before this the ARM backend only ever pushed r0 back for a struct return, so
 * the caller stored the struct's first word and the second word came from
 * whatever was left on the stack (measured: `struct P add(...)` assigned from
 * `c = add(a, b)` answered 2 instead of 10, and with a struct destination
 * address on the stack it wrote to an unmapped address instead). */
static int ret_is_two_words(Type *t) {
    if (!t) return 0;
    if (t->kind == TYPE_LLONG || t->kind == TYPE_DOUBLE) return 1;
    if (t->kind == TYPE_STRUCT || t->kind == TYPE_UNION) {
        int sz = type_size(t);
        return sz > 4 && sz <= 8;
    }
    return 0;
}

/* ---- va region ----------------------------------------------------------
 * One word per argument slot at frame + ARK_VA_BASE + 4*k, contiguous.
 *
 * irgen asks for the same region with a *stride of 8* (frame+8000+8k), which
 * is the C backend's convention: there one slot holds a whole `long long`
 * per argument (ordinal-indexed), so 8 bytes per slot is what stdarg.h walks.
 * This backend instead uses word-indexed contiguous slots, because AAPCS
 * already numbers arguments in 4-byte words (a 64-bit argument takes two
 * adjacent words) -- so a plain 32-bit walk reproduces the caller's layout
 * exactly, and a 64-bit read is just `*(long long*)ap` over two adjacent
 * words.  <stdarg.h> picks the matching convention through
 * __ARK_VA_WORD_SLOTS, which the driver defines for this target.
 *
 * The IR keeps the C-backend stride; the mapping to 4-byte stride happens in
 * codegen_arm(), in one place (the IR_GETARG case ignores these requests
 * entirely: see the "variadic region" branch there). */
/* Variadic region (ARM Thumb-2).
 *
 * The region is *the caller's own argument image*, not a copy of it: the four
 * register words are pushed at function entry (PUSH {r0-r3}) and the stack
 * words are already where the caller put them, immediately above.  So the
 * region is the 16 bytes at frame + local_size + 16, and word 4+k is the
 * k-th stack argument -- contiguous, nothing is copied, and there is no bound
 * on how many stack arguments a call may pass.
 *
 * The cost is 16 bytes of stack per variadic invocation, not 8 KB: the first
 * version of this mirrored 32 words into the frame, which put an 8 KB frame in
 * front of a printf-like function -- larger than the whole mini-app task stack
 * on the board (4 KB, APP_TASK_STACK_SIZE).  Measured: it could not run there.
 *
 * ARK_VA_BASE stays as the marker irgen uses for the C backend's 8-byte-slot
 * region requests (IR_GETARG with dst_off >= 8000); this backend ignores them
 * because it builds its own region. */

/* Set once per function (the spill runs in the prologue). */
static int g_va_named_words; /* words used by the named parameters     */
static int g_va_nsaa;        /* size of the named stack block, bytes   */
static int g_va_ncrn;        /* next core register after the named args */
static int g_va_ptr_off;     /* r6 + this = first variadic word        */

/* Materialise `frame + g_va_ptr_off` in `reg`. The offset is past 4095, so it
 * cannot be an ADD immediate; MOVW+ADD is two instructions and needs no
 * literal pool. Used for _ark_va_ptr, which stdarg.h reads as a variable. */
static void emit_va_ptr(AsmBuffer *b, int reg) {
    asmbuf_puts(b, "    MOVW r");
    asmbuf_int(b, reg);
    asmbuf_puts(b, ", #");
    asmbuf_int(b, g_va_ptr_off);
    asmbuf_puts(b, "\n    ADD r");
    asmbuf_int(b, reg);
    asmbuf_puts(b, ", r6, r");
    asmbuf_int(b, reg);
    asmbuf_putc(b, '\n');
}

/* _ark_va_ptr is how stdarg.h reaches the va region: it is declared extern
 * there and this backend answers it with a frame address instead of a real
 * global (the region lives in the caller's frame, one per invocation).
 * Same shape as the x86 backend's special case; must be handled in BOTH
 * codegen paths (--reg-top peephole and the main switch), otherwise the
 * output would differ depending on the optimisation level. */
static int is_va_ptr_sym(const char *name) {
    return (name && ark_streq(name, "_ark_va_ptr"));
}

/* AAPCS32 parameter assignment (base standard: core registers then stack).
 *
 * sizes[i] is how many bytes argument i occupies on the wire: 4 for one word,
 * 8 for a double-word scalar or composite (long long / double / a 5..8-byte
 * struct), and anything above 8 for a composite that travels inline through a
 * variadic call (see irgen: named parameters of that size go as one pointer
 * word instead).  Outputs are indexed by cumulative *slot* (one slot = one word),
 * which is what irgen stamps into IR_GETARG:
 *   reg[slot]  = r0..r3 for the word held in a register, -1 if it is on the stack
 *   soff[slot] = byte offset inside the caller's stack argument block for a
 *                stacked word, -1 if it is in a register
 * Returns the size of that block in bytes (NSAA), before the caller rounds it
 * so that sp is 8-byte aligned at the call.
 *
 * The rules (AAPCS32 5.5, base standard):
 *   * a double-word argument must start in an even-numbered core register and
 *     needs two of them; if there is no such pair left it goes on the stack,
 *     and NCRN is set to 4 (no further argument goes in a register);
 *   * a double-word argument on the stack is aligned to 8 bytes;
 *   * a single-word argument goes to the next core register while NCRN < 4,
 *     otherwise to the next word of the stack block.
 *
 * Caller and callee MUST agree, so both sides call this.  They used to keep
 * two hand-written versions of the same rule; the caller laid 64-bit stack
 * arguments out high-word-first while the callee read them low-word-first, so
 * `f(1LL, 2LL, 3LL)` summed the wrong halves (measured in unicorn). */
static int aapcs_assign(const int *sizes, const int *aligns, int n,
                        int ncrn_start, int *reg, int *soff) {
    int ncrn = ncrn_start;
    int nsaa = 0;
    int slot = 0;
    int i;
    for (i = 0; i < n; i++) {
        /* AAPCS32 5.5 stage C.3 rounds an argument that needs 8-byte
         * alignment up to an even core register and an 8-byte-aligned stack
         * slot.  The type's *alignment* decides, not its size -- measured
         * against arm-none-eabi-gcc 12.3 with `vf(int a, ...)`:
         *   struct { long long v; }       8 B / align 8 -> r2:r3         even
         *   struct { int a, b; }          8 B / align 4 -> r1:r2         NOT
         *   struct { double d; int i; }  16 B / align 8 -> r2,r3 + stack  even
         *   struct { int a,b,c,d; }      16 B / align 4 -> r1,r2,r3 + stk NOT
         *   _Complex float                8 B / align 4 -> r1,r2         NOT
         * The old "size == 8" test padded in front of an align-4 pair and
         * failed to pad an align-8 composite.  An align-4 composite whose
         * first word still fits in r3 splits across r3 and the stack
         * (`vf(a, b, c, (struct A4){b, c})` puts b in r3 and c on the stack),
         * so it takes the same word-by-word fill as a >8-byte composite; only
         * the 8-byte-aligned pair is all-or-nothing. */
        int a8 = aligns ? (aligns[i] >= 8) : (sizes[i] == 8);
        int w = (sizes[i] > 0) ? (sizes[i] + 3) / 4 : 1;
        int j;
        if (a8) {
            if (ncrn < 4 && (ncrn & 1)) ncrn++;      /* even core register */
            if (ncrn >= 4) nsaa = (nsaa + 7) & ~7;   /* 8-aligned stack slot */
        }
        if (w == 2 && a8) {
            int r = ncrn;                    /* even, from the step above */
            if (r <= 2) {
                reg[slot] = r;
                reg[slot + 1] = r + 1;
                soff[slot] = -1;
                soff[slot + 1] = -1;
                ncrn = r + 2;
            } else {
                ncrn = 4;                       /* nothing else in a register */
                nsaa = (nsaa + 7) & ~7;         /* 8-byte aligned on the stack */
                reg[slot] = -1;
                reg[slot + 1] = -1;
                soff[slot] = nsaa;
                soff[slot + 1] = nsaa + 4;
                nsaa += 8;
            }
            slot += 2;
        } else {
            /* One word, an align-4 pair, or a composite of any size: the words
             * fill the remaining core register(s) and then the stack in order.
             * Measured against arm-none-eabi-gcc 12.3 -- `f(1, s12)` with three
             * named words ahead of it puts word 0 in r3 and words 1,2 on the
             * stack.  An 8-byte-aligned composite already got its stack hole
             * from the a8 step above. */
            for (j = 0; j < w; j++) {
                if (ncrn < 4) {
                    reg[slot] = ncrn++;
                    soff[slot] = -1;
                } else {
                    reg[slot] = -1;
                    soff[slot] = nsaa;
                    nsaa += 4;
                }
                slot += 1;
            }
        }
    }
    return nsaa;
}

/* One place for "a C string as .asciz text": the string pool and the
 * pointer-global initialiser both need it. */
static void arm_put_escaped_str(AsmBuffer *b, const char *s) {
    int k;
    for (k = 0; s[k]; k++) {
        unsigned char c = (unsigned char)s[k];
        if (c == '\n') asmbuf_puts(b, "\\n");
        else if (c == '\t') asmbuf_puts(b, "\\t");
        else if (c == '\r') asmbuf_puts(b, "\\r");
        else if (c == '\\') asmbuf_puts(b, "\\\\");
        else if (c == '"')  asmbuf_puts(b, "\\\"");
        else if (c < 0x20 || c >= 0x7F) {
            char hb[8];
            const char *hh = "0123456789abcdef";
            hb[0] = '\\'; hb[1] = 'x';
            hb[2] = hh[(c >> 4) & 0xF]; hb[3] = hh[c & 0xF]; hb[4] = 0;
            asmbuf_puts(b, hb);
        } else asmbuf_putc(b, (char)c);
    }
}

#if ARKCC_FEATURE_OPT_PAIR
/* --- -fopt-pair: consume two one-word pushes and their binary op together ---
 *
 * The IR is a stack machine, so `a + b` arrives as PUSH a / PUSH b / BINARY and
 * the generic path emits, for every operand, a load followed by a PUSH, then two
 * POPs, the op and a final PUSH:
 *
 *     <a>            -> r0 ; PUSH {r0}
 *     <b>            -> r0 ; PUSH {r0}
 *     POP {r1} ; POP {r0} ; OP r0, r0, r1 ; PUSH {r0}
 *
 * Nothing between the two pushes reads the value stack, so the operands can go
 * straight into the two registers emit_binary() already expects -- left in r0,
 * right in r1 -- and the four stack words disappear:
 *
 *     <a> -> r0 ; <b> -> r1 ; OP r0, r0, r1 ; PUSH {r0}
 *
 * The recorded stack effect is identical (+1 word), so every later consumer and
 * every text pass downstream (vstack included) sees the same contract.
 *
 * Refused shapes take the generic path unchanged: anything that pushes more
 * than one word (64-bit, struct, _Complex), a volatile read (its DMB pair must
 * stay where the generic path puts it), a va_ptr global (its address comes from
 * a helper that hard-codes r0), or an operator emit_binary() does not know.
 */

/* The operators emit_binary() implements, so a pair is only formed when the
 * consumer is one of them.  The 0x100 "unsigned" bit is not part of the op. */
static int pair_op_ok(int op) {
    switch (op & ~0x100) {
    case (int)TOK_PLUS:  case (int)TOK_MINUS: case (int)TOK_MUL:
    case (int)TOK_DIV:   case (int)TOK_MOD:
    case (int)TOK_BAND:  case (int)TOK_BOR:   case (int)TOK_BXOR:
    case (int)TOK_SHL:   case (int)TOK_SHR:
    case (int)TOK_EQ:    case (int)TOK_NE:
    case (int)TOK_LT:    case (int)TOK_GT:
    case (int)TOK_LE:    case (int)TOK_GE:
        return 1;
    }
    return 0;
}

/* 1 when I is a one-word push that can be materialised in an arbitrary
 * register without writing any register but that one. */
static int pair_operand_ok(IrInst *I) {
    if (!I) return 0;
    switch (I->op) {
    case IR_PUSH_INT:
        return 1;
    case IR_PUSH_VAR:
        if ((I->aux & 0xFF) >= 8) return 0;       /* two words */
        if (I->aux & IR_AUX_VOLATILE) return 0;   /* needs its DMB pair */
        return 1;
    case IR_PUSH_ADDR:
        return 1;
    case IR_PUSH_GLOBAL_ADDR:
        return 1;
    case IR_PUSH_GLOBAL:
        if (is_va_ptr_sym(I->name)) return 0;     /* helper hard-codes r0 */
        return gvar_find_size(I->name) < 8;       /* 8+ bytes is two words */
    default:
        return 0;
    }
}

/* Materialise an accepted push into `rd`. */
static void pair_operand_emit(AsmBuffer *b, IrInst *I, int rd) {
    switch (I->op) {
    case IR_PUSH_INT:
        emit_mov_imm(b, rd, I->val);
        return;
    case IR_PUSH_VAR: {
        int width = I->aux & 0xFF;
        int is_unsigned = (I->aux & 0x100) != 0;
        asmbuf_puts(b, "    ");
        if (width == 1)      asmbuf_puts(b, is_unsigned ? "LDRB r" : "LDRSB r");
        else if (width == 2) asmbuf_puts(b, is_unsigned ? "LDRH r" : "LDRSH r");
        else                 asmbuf_puts(b, "LDR r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, ", [r6, #");
        asmbuf_int(b, I->val);
        asmbuf_puts(b, "]\n");
        return;
    }
    case IR_PUSH_ADDR:
        asmbuf_puts(b, "    ADD r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, ", r6, #");
        asmbuf_int(b, I->val);
        asmbuf_putc(b, '\n');
        return;
    case IR_PUSH_GLOBAL_ADDR:
        emit_gvar_addr32(b, rd, I->name);
        return;
    case IR_PUSH_GLOBAL:
        emit_gvar_addr32(b, rd, I->name);
        asmbuf_puts(b, "    LDR r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, ", [r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, "]\n");
        return;
    }
}

/* 1 when the *second* operand is a constant that -fopt-imm folds into the
 * instruction's immediate field on its own turn (it sees it as "PUSH k
 * right before the op").  Taking the pair then would put the constant in
 * a register and lose that fold -- measured on `a + 4`, where the pair
 * cost one extra MOV r1, #4 per site -- so the pair stands down. */
/* 1 when the consumer is a comparison.  -fopt-cbranch turns
 * "build 0/1, then test it" into a single CMP + branch, which is
 * the better shape whenever it applies, so the pair stands down
 * there (see pair_cbranch_preempted). */
static int pair_is_cmp(int op) {
    switch (op & ~0x100) {
    case (int)TOK_EQ: case (int)TOK_NE:
    case (int)TOK_LT: case (int)TOK_GT:
    case (int)TOK_LE: case (int)TOK_GE:
        return 1;
    }
    return 0;
}

/* 1 when -fopt-cbranch will consume this comparison directly.  The
 * branch rule lives in the IR_BINARY case, which the pair path
 * never reaches, so taking the pair here would forfeit it
 * (measured on HAL_GPIO_Init: four extra instructions per
 * comparison that fed an if). */
static int pair_cbranch_preempted(int op, IrInst *next) {
    if (!next) return 0;
    if (!g_config.enable_opt_cbranch) return 0;
    if (!pair_is_cmp(op)) return 0;
    return next->op == IR_JZ || next->op == IR_JNZ;
}

#if ARKCC_FEATURE_OPT_IMM
static int pair_imm_preempted(IrInst *I, int op) {
    if (!I || I->op != IR_PUSH_INT) return 0;
    return emit_binary_imm(0, op, (int)I->val, 0, 0);
}
#else
static int pair_imm_preempted(IrInst *I, int op) {
    (void)I; (void)op;
    return 0;
}
#endif
#endif

#if ARKCC_FEATURE_OPT_VOLDBM
/* ------------- volatile frame barriers (-fopt-voldmb) ---------------------
 *
 * A volatile access to a *frame slot* is emitted with a DMB SY pair.  That
 * barrier's only observable effect is the order in which the memory system
 * makes the access visible to another observer -- another master, a DMA
 * engine, a second core.  If this function never takes the object's address
 * nothing outside the frame can name it, so there is no other observer and
 * the pair is pure overhead: eleven of the fifteen HAL clock-enable blocks
 * spend two DMB SY (eight bytes) each on their `__IO uint32_t tmpreg`.
 * armcc, armclang and IAR emit no barrier at all here.
 *
 * The proof is per *object name*: IR_PUSH_ADDR already carries the name of
 * the object whose address is being taken (irgen.c), so a volatile access to
 * `x` keeps its barriers exactly when some `&x` exists in the same function.
 * An address-of whose name is empty cannot be attributed, and then the whole
 * function keeps every barrier -- the pass only deletes what it can prove.
 */
#define VDM_MAX 128
static const char *vdm_esc[VDM_MAX];
static int vdm_esc_n;
static int vdm_blind;

static void vdm_scan(IrFunc *f) {
    int i;
    vdm_esc_n = 0;
    vdm_blind = 0;
    if (!g_config.enable_opt_voldmb) return;
    for (i = 0; i < f->code_count; i++) {
        if (f->code[i].op != IR_PUSH_ADDR) continue;
        if (!f->code[i].name) { vdm_blind = 1; continue; }
        if (vdm_esc_n < VDM_MAX) vdm_esc[vdm_esc_n++] = f->code[i].name;
    }
}

/* 1 = this volatile frame access may drop its DMB SY pair. */
static int vdm_elide(const char *nm) {
    int i;
    if (!g_config.enable_opt_voldmb || vdm_blind || !nm) return 0;
    for (i = 0; i < vdm_esc_n; i++)
        if (ark_streq(vdm_esc[i], nm)) return 0;
    return 1;
}
#else
#define vdm_scan(f) ((void)0)
#define vdm_elide(nm) 0
#endif

#if ARKCC_FEATURE_OPT_VOLBAR
/* Volatile accesses that do not go through a frame slot: a global, or any
 * load/store through a computed address (struct member, array element, *p,
 * bit-field).  These get the same DMB SY pair the IR_PUSH_VAR / IR_STORE
 * cases emit.  The object lives outside the frame, so the compiler cannot
 * prove that no other master (DMA, a second core, a peripheral) sees it, and
 * the barrier's whole job is that ordering -- unlike a frame slot, whose
 * escape analysis -fopt-voldmb performs.
 *
 * Both barriers are needed: one before the access to keep the preceding
 * writes in front of it, one after so the access itself is not reordered
 * into the following code.  The IDX/FLD cases below have several exits, so
 * the trailing barrier is emitted once, after the switch.
 *
 * Not emitted by the riscv32 backend (it would need FENCE, which that
 * backend does not model) and unnecessary on x86/x86-64, whose memory
 * ordering is strong; both still honour the IR_AUX_VOLATILE marker so no
 * pass treats the access as dead or foldable. */
static int arm_vol_needs_barrier(int op) {
    return op == IR_LOAD_IDX  || op == IR_STORE_IDX ||
           op == IR_LOAD_FLD  || op == IR_STORE_FLD ||
           op == IR_PUSH_GLOBAL || op == IR_STORE_GLOBAL;
}
#endif

static char *codegen_arm(IrProgram *prog) {
    AsmBuffer buf;
    int fi;
#if ARKCC_FEATURE_DWARF
    int dbg = (g_config.debug_info || g_config.enable_dwarf) ? 1 : 0;
#else
    int dbg = 0;
#endif
    asmbuf_init(&buf);

    /* Load the scatter description (if --scatter was given) so the base
     * addresses for Flash/.data/.bss come from the .sct layout. Must happen
     * before gvar_assign, which places globals at g_data_base/g_bss_base. */
    arm_scatter_load();

    /* Assign SRAM addresses to all non-extern, non-__at globals.
     * This must happen before generating function code so IR_PUSH_GLOBAL etc.
     * can emit MOVW/MOVT with the correct SRAM address. */
    gvar_assign(prog);

    asmbuf_puts(&buf, "; Ark C Compiler - generated Thumb-2 assembly\n");
    asmbuf_puts(&buf, ".thumb\n");
    asmbuf_puts(&buf, ".text\n\n");

#if ARKCC_FEATURE_DWARF
    /* DWARF: declare the source file for later .loc 1 <line> references */
    if (dbg && prog->source_file) {
        asmbuf_puts(&buf, ".file 1 \"");
        asmbuf_puts(&buf, prog->source_file);
        asmbuf_puts(&buf, "\"\n");
    }
#endif

    /* String literal section */
    if (prog->string_count > 0) {
        int i;
        asmbuf_puts(&buf, ".section .rodata\n");
        for (i = 0; i < prog->string_count; i++) {
            IrString *s = prog->strings[i];
            asmbuf_puts(&buf, ".L_str_");
            asmbuf_int(&buf, s->id);
            asmbuf_puts(&buf, ":\n    .asciz \"");
            {
                int k;
                for (k = 0; k < s->len; k++) {
                    char c = s->data[k];
                    if (c == '\n') asmbuf_puts(&buf, "\\n");
                    else if (c == '\t') asmbuf_puts(&buf, "\\t");
                    else if (c == '\r') asmbuf_puts(&buf, "\\r");
                    else if (c == '\\') asmbuf_puts(&buf, "\\\\");
                    else if (c == '"')  asmbuf_puts(&buf, "\\\"");
                    else if (c == '\b') asmbuf_puts(&buf, "\\b");
                    else if (c == '\f') asmbuf_puts(&buf, "\\f");
                    else if (c == '\v') asmbuf_puts(&buf, "\\v");
                    else if (c == '\a') asmbuf_puts(&buf, "\\a");
                    else if (c == '\0') asmbuf_puts(&buf, "\\0");
                    else if ((unsigned char)c < 0x20 || (unsigned char)c >= 0x7F) {
                        char hb[8]; int hn = 0;
                        const char *hh = "0123456789abcdef";
                        hb[hn++] = '\\'; hb[hn++] = 'x';
                        hb[hn++] = hh[((unsigned char)c >> 4) & 0xF];
                        hb[hn++] = hh[(unsigned char)c & 0xF];
                        hb[hn] = 0;
                        asmbuf_puts(&buf, hb);
                    }
                    else asmbuf_putc(&buf, c);
                }
            }
            asmbuf_puts(&buf, "\"\n");
        }
        asmbuf_puts(&buf, ".text\n\n");
    }

    /* A pointer global can be initialised from a string literal
     * (`char *p = "hi";`).  That string is not in the pool -- the pool
     * is filled while emitting expressions -- and it is not a character
     * array either, so nothing used to emit it: the runtime initialiser
     * then wrote the bytes 'h','i' *into the pointer object* and left
     * the pointer itself uninitialised, i.e. `p` was a wild pointer.
     * Give each one a flash label and store its address instead. */
    {
        int gi, any = 0;
        for (gi = 0; gi < prog->global_count; gi++) {
            IrGlobal *g = prog->globals[gi];
            if (g->is_extern || !g->has_init || !g->init_str) continue;
            if (!g->type || g->type->kind != TYPE_PTR) continue;
            if (!any) { asmbuf_puts(&buf, ".section .rodata\n"); any = 1; }
            asmbuf_puts(&buf, ".L_gstr_");
            asmbuf_int(&buf, gi);
            asmbuf_puts(&buf, ":\n    .asciz \"");
            arm_put_escaped_str(&buf, g->init_str);
            asmbuf_puts(&buf, "\"\n");
        }
        /* Aggregate initialisers may also carry string literal elements
         * (`char *cs[2] = {"a", "b"};`).  Each needs its own flash label
         * keyed by the element byte offset in the object: the runtime
         * initialiser has to store a distinct pointer per element. */
        for (gi = 0; gi < prog->global_count; gi++) {
            IrGlobal *g2 = prog->globals[gi];
            int ri;
            if (g2->init_ref_count <= 0 || !g2->init_refs) continue;
            for (ri = 0; ri < g2->init_ref_count; ri++) {
                IrSymRef *r = &g2->init_refs[ri];
                if (!r->str) continue;
                if (!any) { asmbuf_puts(&buf, ".section .rodata\n"); any = 1; }
                asmbuf_puts(&buf, ".L_gstr_");
                asmbuf_int(&buf, gi);
                asmbuf_putc(&buf, '_');
                asmbuf_int(&buf, r->offset);
                asmbuf_puts(&buf, ":\n    .asciz \"");
                arm_put_escaped_str(&buf, r->str);
                asmbuf_puts(&buf, "\"\n");
            }
        }

        if (any) asmbuf_puts(&buf, ".text\n\n");
    }

    /* Floating-point constant section: emit both single-precision (.L_flt_<i>) and double-precision (.L_dbl_<i>) bit patterns.
     * The high bit 0x200 of IR_PUSH_FLOAT aux determines which to load:
     *   - 0x200 not set: single-precision, 4 bytes, uses __aeabi_f* family
     *   - 0x200 set: double-precision, 8 bytes, uses __aeabi_d* family
     * Stored uniformly as double; the single-precision version is truncated via (float). */
    if (prog->float_count > 0) {
        int i;
        asmbuf_puts(&buf, ".section .rodata\n");
        for (i = 0; i < prog->float_count; i++) {
            union { float f; unsigned int u; } u;
            union { double d; unsigned int u[2]; } du;
            unsigned int bits;
            char hex[9];
            int k;
            const char *hd = "0123456789abcdef";
            /* Single-precision: float bit pattern (4 bytes) */
            u.f = (float)prog->floats[i];
            bits = u.u;
            for (k = 7; k >= 0; k--) { hex[k] = hd[bits & 0xF]; bits >>= 4; }
            hex[8] = 0;
            asmbuf_puts(&buf, ".L_flt_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, ":\n    .word 0x");
            asmbuf_puts(&buf, hex);
            asmbuf_putc(&buf, '\n');
            /* Double-precision: double bit pattern (8 bytes, little-endian: low word first) */
            du.d = prog->floats[i];
            asmbuf_puts(&buf, ".L_dbl_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, ":\n    .word 0x");
            {
                unsigned int lo = du.u[0];
                char hex2[9]; int k2;
                for (k2 = 7; k2 >= 0; k2--) { hex2[k2] = hd[lo & 0xF]; lo >>= 4; }
                hex2[8] = 0;
                asmbuf_puts(&buf, hex2);
            }
            asmbuf_puts(&buf, "\n    .word 0x");
            {
                unsigned int hi = du.u[1];
                char hex2[9]; int k2;
                for (k2 = 7; k2 >= 0; k2--) { hex2[k2] = hd[hi & 0xF]; hi >>= 4; }
                hex2[8] = 0;
                asmbuf_puts(&buf, hex2);
            }
            asmbuf_putc(&buf, '\n');
        }
        asmbuf_puts(&buf, ".text\n\n");
    }

    /* Complex constant pool: real low, real high, imag low, imag high --
     * the same 16-byte layout IR_STORE writes to a frame slot. */
    if (prog->complex_count > 0) {
        int i;
        asmbuf_puts(&buf, ".section .rodata\n");
        for (i = 0; i < prog->complex_count; i++) {
            union { double d; unsigned int u[2]; } ru, iu;
            ru.d = prog->complexes[i].re;
            iu.d = prog->complexes[i].im;
            asmbuf_puts(&buf, ".L_cplx_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, ":\n");
            arm_word_hex(&buf, ru.u[0]);
            arm_word_hex(&buf, ru.u[1]);
            arm_word_hex(&buf, iu.u[0]);
            arm_word_hex(&buf, iu.u[1]);
        }
        asmbuf_puts(&buf, ".text\n\n");
    }

    /* sret (struct/union result > 8 bytes) is no longer discovered by
     * scanning the program for definitions.  irgen stamps the call site
     * itself -- bit 36 of IR_CALL's val says the callee returns a
     * struct/union larger than 8 bytes, bits 37..52 carry the payload size --
     * from the type of the call *expression*.  That is the only source that
     * also covers a call to a function that is declared here but defined in
     * another translation unit, and a call through a function pointer, both of
     * which used to be emitted with the AAPCS default (no hidden pointer) and
     * silently wrote the result over r0.  A _Complex object never uses the
     * hidden pointer: 8 bytes go in r0:r1 and 16 bytes in r0-r3, which is what
     * the soft-float AAPCS says for a composite of two doubles and what GCC
     * emits. */

    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        /* Names the function whose code is being emitted, for the diagnostics
         * that are raised deep inside the instruction switch (a reference to
         * _ark_va_ptr outside a variadic function, for instance). */
        g_cur_fn_name = f->name;
        vdm_scan(f);

        /* Variadic functions: the va region is spilled below, once per
         * function, right after the prologue (see "va region" further down).
         * Nothing to do here. */
        int local_size = f->local_size;
        int i;
        /* Variadic functions need no frame space for the va region: the four
         * register words are pushed in the prologue and the stack words stay
         * where the caller put them (see emit_prologue).  irgen does not
         * reserve the C backend's 8 KB slot area for this target either
         * (g_ir_va_slot_region), so a variadic frame is just its locals. */
        int is_sret = 0;
        int fstart = 0;              /* where this function's text begins */
        int sret_off = 0;
        int va_start_slot = 0;       /* first variadic word, in region words */
        int va_lo = 0;               /* first saved argument register (even)   */
        /* P1 FIX (sret caller side): pre-allocate sret buffers in this
         * function's frame so the sret space doesn't occupy SP+0 (where
         * the callee expects to read stack args). Each sret call site gets
         * its own buffer at a known r6-relative offset. */
        int sret_call_buf_off[ARK_MAX_SRET_FUNCS];
        int sret_call_n = 0;

        /* Detect sret: struct/union return > 8 bytes */
        {
            Type *rt = f->ret_type;
            if (rt && (rt->kind == TYPE_STRUCT || rt->kind == TYPE_UNION) &&
                type_size(rt) > 8) {
                is_sret = 1;
                local_size += 4;  /* slot for sret pointer */
                sret_off = local_size - 4;
            }
        }

        /* alias function: emit .global / .set directives, do not generate a function body */
        if (f->alias_target) {
            asmbuf_puts(&buf, ".global ");
            asmbuf_puts(&buf, f->name);
            asmbuf_putc(&buf, '\n');
            asmbuf_puts(&buf, ".set ");
            asmbuf_puts(&buf, f->name);
            asmbuf_puts(&buf, ", ");
            asmbuf_puts(&buf, f->alias_target);
            asmbuf_puts(&buf, "\n\n");
            continue;
        }

        /* --split_sections/-ffunction-sections: each function gets its own section .text.<name>,
         * so the linker can dead-strip unused code (--gc-sections). alias functions do not generate a section (only .set). */
        if (g_config.split_sections && !f->alias_target) {
            asmbuf_puts(&buf, ".section .text.");
            asmbuf_puts(&buf, f->name);
            asmbuf_puts(&buf, ", \"ax\", %progbits\n");
        }
        asmbuf_puts(&buf, ".global ");
        asmbuf_puts(&buf, f->name);
        asmbuf_putc(&buf, '\n');
        if (f->is_weak) {
            /* __weak: declare weak symbol before the label, allows override by a same-name strong symbol at link time */
            asmbuf_puts(&buf, ".weak ");
            asmbuf_puts(&buf, f->name);
            asmbuf_putc(&buf, '\n');
        }
        if (f->is_used) {
            /* __attribute__((used)): comment marker only; .global already ensures symbol export */
            asmbuf_puts(&buf, "@ __attribute__((used))\n");
        }
#if ARKCC_FEATURE_ARMCC_KEYWORDS
        /* armcc 5 compatibility function modifiers: comment markers only (ARM backend does not change calling convention).
         *   __value_in_regs / __pure / __interwork / __smc(n) / __global_reg(n) */
        if (f->is_value_in_regs) asmbuf_puts(&buf, "@ __value_in_regs\n");
        if (f->is_pure)          asmbuf_puts(&buf, "@ __pure\n");
        if (f->is_const_attr)    asmbuf_puts(&buf, "@ __attribute__((const))\n");
        if (f->is_interwork)     asmbuf_puts(&buf, "@ __interwork\n");
        if (f->smc_num > 0) {
            asmbuf_puts(&buf, "@ __smc(");
            asmbuf_int(&buf, f->smc_num);
            asmbuf_puts(&buf, ")\n");
        }
        if (f->global_reg >= 0) {
            asmbuf_puts(&buf, "@ __global_reg(");
            asmbuf_int(&buf, f->global_reg);
            asmbuf_puts(&buf, ")\n");
        }
#endif
        /* __asm whole-function body: emit label and user's raw assembly, skip prologue/epilogue */
        if (f->is_asm_func) {
            asmbuf_puts(&buf, f->name);
            asmbuf_puts(&buf, ":\n");
            if (f->asm_body) {
                const char *s = f->asm_body;
                /* Copy text line by line; add leading indent for GAS friendliness */
                int line_start = 1;
                while (*s) {
                    if (line_start) {
                        /* Skip leading whitespace so we can re-indent */
                        while (*s == ' ' || *s == '\t' || *s == '\r') s++;
                        if (*s == 0) break;
                        if (*s == '\n') { asmbuf_putc(&buf, '\n'); s++; continue; }
                        asmbuf_puts(&buf, "    ");
                        line_start = 0;
                    }
                    if (*s == '\n') { asmbuf_putc(&buf, '\n'); line_start = 1; s++; continue; }
                    asmbuf_putc(&buf, *s);
                    s++;
                }
                if (!line_start) asmbuf_putc(&buf, '\n');
            }
            asmbuf_putc(&buf, '\n');
            continue;
        }
#if ARKCC_FEATURE_DWARF
        if (dbg) {
            asmbuf_puts(&buf, ".type ");
            asmbuf_puts(&buf, f->name);
            asmbuf_puts(&buf, ", %function\n");
        }
#endif
        /* Pre-scan IR for sret calls: reserve a buffer in the frame for each.
         * The buffer is addressed via r6 (frame pointer) at the call site,
         * so SP stays at the stack args (callee reads them at SP+0).
         *
         * One buffer per *call site*, not one per function and not one shared
         * scratch area: `struct S a = f(), b = g();` and `h(g(), k())` both
         * need two live results at once.  The size comes from the IR (bits
         * 37..52 of IR_CALL's val), i.e. from the static type of the call
         * expression; a size that does not fit is a hard error rather than a
         * silent truncation.  Each buffer is 8-byte aligned because the
         * callee may store a double/long long member with STRD, which faults
         * on an unaligned address. */
        {
            int sci;
            for (sci = 0; sci < f->code_count; sci++) {
                IrInst *sci_I = &f->code[sci];
                if (sci_I->op == IR_CALL && ((sci_I->val >> 36) & 1)) {
                    int sz = (int)((sci_I->val >> 37) & 0xFFFF);
                    if (sz <= 0 || sz > 0xFFFF) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "call site in '%s' returns a structure of %s "
                                  "bytes; the arm backend needs 1..65535",
                                  f->name, diag_num(b1, sz), 0,0,0,0);
                        sz = 0;
                    }
                    sz = (sz + 7) & ~7;
                    if (sret_call_n >= ARK_MAX_SRET_FUNCS) {
                        char b1[12], b2[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "function '%s' has %s call sites returning a "
                                  "structure larger than 8 bytes; at most %s are "
                                  "supported; raise ARK_MAX_SRET_FUNCS and "
                                  "rebuild arkcc",
                                  f->name, diag_num(b1, sret_call_n + 1),
                                  diag_num(b2, ARK_MAX_SRET_FUNCS), 0,0,0);
                        break;
                    }
                    local_size += sz;
                    sret_call_buf_off[sret_call_n] = local_size - sz;
                    sret_call_n++;
                }
            }
        }
        /* AAPCS: SP must be 8-byte aligned at BL. irgen aligns f->local_size
         * to 8, but the sret adjustments above (sret pointer slot +4, sret call
         * buffers +sz) can leave local_size at 4 mod 8. Round up to 8 so the
         * prologue's SUB sp,sp,#local_size preserves the 8-byte alignment that
         * IR_CALL's need_align parity check relies on. The padding sits at the
         * top of the frame (between the last variable and saved regs); all
         * r6-relative offsets remain valid because the prologue SUB and the
         * stack-arg offset computation both use this padded value. */
        local_size = (local_size + 7) & ~7;
        /* NCRN / nsaa have to be known before the prologue, because the
         * prologue decides how many argument words to save.  This block used to
         * sit in the body loop; nothing in it emits code, so it simply moved
         * up. */
        g_va_epilogue_pad = 0;
        va_lo = 0;
        static int aapcs_map[64];
        static int aapcs_soff[64];
        {
            /* Slot -> register (aapcs_map) and slot -> byte offset in the
             * caller's stack argument block (aapcs_soff), from the one shared
             * rule in aapcs_assign() so the callee reads exactly what the
             * caller wrote. */
            static int psz[64];
            static int pal[64];     /* natural alignment, for AAPCS stage C.3 */
            int pj;
            for (pj = 0; pj < 64; pj++) { aapcs_map[pj] = -1; aapcs_soff[pj] = -1; }
            for (pj = 0; pj < f->param_count && pj < 64; pj++) {
                Type *pt = (f->param_types && pj < f->param_count)
                           ? f->param_types[pj] : 0;
                int sz = pt ? type_size(pt) : 4;
                int al = pt ? type_align(pt) : 4;
                if (sz <= 0) sz = 4;
                /* A struct passed by value travels as a pointer word, and so
                 * does a four-word _Complex value (irgen materialises it in a
                 * temporary and passes its address, matching IR_GETARG's
                 * >8-byte memcpy path).  Those are one ordinary word, so their
                 * alignment does not round anything. */
                if (pt && (pt->kind == TYPE_STRUCT || pt->kind == TYPE_UNION) && sz > 8) {
                    sz = 4;
                    al = 4;
                }
                if (pt && ARK_IS_CX(pt) && sz > 8) {
                    sz = 4;
                    al = 4;
                }
                psz[pj] = sz;
                pal[pj] = al;
            }
            g_va_nsaa = aapcs_assign(psz, pal,
                                    (f->param_count < 64) ? f->param_count : 64,
                                    is_sret ? 1 : 0, aapcs_map, aapcs_soff);
            /* Words used by the named parameters, and where the variadic
             * words start.
             *
             * The start is NOT "the number of named words": AAPCS continues
             * the argument numbering in the next core register, and any named
             * argument on the stack forces NCRN to 4 (everything after it is
             * stacked too). f(int a, long long b, ...) is the case that
             * separates the two: b needs an even register pair, r1 stays
             * unused, NCRN is 4, and a "named words" pointer would hand the
             * first va_arg r3 -- a named argument. Both numbers come out of
             * aapcs_assign(): register -1 marks a stacked named word, and the
             * highest register used plus one is NCRN.
             *
             * The variadic stack words begin at 4 + nsaa/4 in the flattened
             * region (see the spill below). */
            {
                int nw = 0, pj2, any_stack = 0, maxreg = -1;
                for (pj2 = 0; pj2 < f->param_count && pj2 < 64; pj2++)
                    nw += (psz[pj2] == 8) ? 2 : 1;
                for (pj2 = 0; pj2 < nw && pj2 < 64; pj2++) {
                    if (aapcs_map[pj2] < 0) any_stack = 1;
                    else if (aapcs_map[pj2] > maxreg) maxreg = aapcs_map[pj2];
                }
                g_va_named_words = nw;
                g_va_ncrn = any_stack ? 4 : maxreg + 1;
                if (is_sret && g_va_ncrn < 1) g_va_ncrn = 1;  /* r0 = sret */
                /* Only the register words that can still hold a variadic
                 * argument are saved: r_k .. r3 with k = NCRN rounded DOWN to
                 * an even number.  Four things ride on choosing k that way:
                 *
                 *   - the region stays the caller's argument image verbatim:
                 *     its base is always frame + local_size + 16, whatever k
                 *     is, because sp_entry = base + pushed bytes.  Zero copy,
                 *     and the caller's stack arguments stay contiguous with
                 *     the last pushed word, so there is still no limit on how
                 *     many arguments a variadic call may pass on the stack;
                 *   - "round ap up to 8" stays equivalent to "even AAPCS
                 *     argument word" for any k: word j sits at base + 4j, and
                 *     that is 8-aligned iff (j-k) is even, which is exactly
                 *     "k+j, the AAPCS word number, is even";
                 *   - k even makes the pushed byte count a multiple of 8, so
                 *     sp keeps the 8-byte alignment AAPCS requires.  An odd k
                 *     would still walk the region correctly but would leave
                 *     the frame at 4 mod 8, where an 8-byte local (or a
                 *     GCC-compiled callee) can fault;
                 *   - k == 4 pushes nothing: the epilogue goes back to a plain
                 *     POP {r5, r6, r7, pc} and the stack-argument base back to
                 *     local_size + 16.
                 *
                 * Measured cost per signature: int f(int a, ...) 16 B,
                 * int f(int a, int b, ...) 8 B, four named words 0 B. */
                if (f->is_variadic && !f->is_naked) {
                    va_lo = g_va_ncrn & ~1;
                    if (va_lo > 4) va_lo = 4;
                    g_va_epilogue_pad = 4 * (4 - va_lo);
                    va_start_slot = (g_va_ncrn >= 4) ? (g_va_nsaa / 4)
                                                     : (g_va_ncrn - va_lo);
                }
            }
        }
        fstart = buf.len;
        emit_prologue(&buf, f->name, local_size, va_lo, g_va_epilogue_pad,
                      f->is_irq, f->is_naked, dbg);
        /* #2 FIX: Auto-call __arkcc_init_globals at the start of Reset_Handler
         * to initialize .data and zero .bss before main() runs. */
        if (ark_streq(f->name, "Reset_Handler") &&
            (g_data_sram_start != g_data_sram_end ||
             g_bss_sram_start != g_bss_sram_end)) {
            asmbuf_puts(&buf, "    BL __arkcc_init_globals\n");
        }
        /* Save sret pointer (r0) to frame slot for struct-returning functions */
        if (is_sret) {
            asmbuf_puts(&buf, "    STR r0, [r6, #");
            asmbuf_int(&buf, sret_off);
            asmbuf_puts(&buf, "]\n");
        }

        {
        int cur_line = 0;
        int sret_call_idx = 0;
        /* Precompute AAPCS register assignment for each param slot.
         * Maps slot index (cumulative 4-byte slot count) to AAPCS register
         * number (r0-r3), accounting for 64-bit even-pair alignment.
         * -1 = slot not used (gap in struct-by-value slot space). */
        /* static: this compiler also runs on the target board, where the
         * code generator's stack is a tight budget.  codegen_arm() is not
         * recursive and is re-entered only once per function, and both tables
         * are re-initialised at the top of the loop, so a file-scope lifetime
         * changes nothing except the stack cost. */

        /* ---- va region (variadic functions only) ------------------------
         * The region IS the caller's argument image: the prologue pushed
         * r0-r3 at [frame + local_size + 16 .. +31] (r0 lowest), and the
         * caller's stack argument block starts at frame + local_size + 32.
         * So region word k is:
         *   k = 0..3   r0..r3
         *   k = 4+j    stack argument word j
         * which is exactly AAPCS's own numbering.  Nothing is copied here and
         * there is no size limit: <stdarg.h> walks 4-byte words and rounds a
         * 64-bit read up to an 8-byte boundary, which is the same rule AAPCS
         * uses for an even register pair and an 8-byte-aligned stack slot.
         * The base is 8-byte aligned because sp is (AAPCS: 8-byte aligned at
         * BL) and the prologue subtracted 16 and a multiple of 8.
         *
         * `_ark_va_ptr` therefore points at frame + local_size + 16 + 4*slot,
         * where slot counts AAPCS argument words (see va_start_slot). */
        g_va_active = 0;
        g_va_ptr_off = 0;
        if (f->is_variadic && !f->is_naked) {
            g_va_active = 1;
            g_va_ptr_off = local_size + 16 + 4 * va_start_slot;
        }

        /* --reg-top state: whether the IR stack top is in r0, and whether the
         * IR_RETURN being emitted can skip its pop.  Both stay 0 when the
         * option is off, so the generated code is byte-identical. */
        int rtop = 0;
        int rtop_ret = 0;
        /* P2: set when the instruction just emitted was a tail call, so the
         * IR_RETURN immediately after it emits nothing.  Always 0 in a build
         * without ARKCC_FEATURE_TAILCALL. */
        int tail_return_pending = 0;
#if ARKCC_FEATURE_DIVCONST
        /* P3: 1 while the divisor push has been swallowed and the divide that
         * consumes it has not been emitted yet.  Always 0 in a build without
         * ARKCC_FEATURE_DIVCONST, so the image does not change. */
        int divconst_live = 0;
        /* 1 while the unary minus that made the divisor negative must be
         * skipped as well (the constant is folded into the magic). */
        int divconst_skip = 0;
        DivConst divconst_st;
#endif
        /* -fopt-imm: 1 while a constant push has been swallowed and the binary
         * op that consumes it (immediately next, or next after one more push
         * when the constant is the left operand) has not been emitted yet.
         * Always 0 in a build without ARKCC_FEATURE_OPT_IMM (it is declared
         * outside the gate for that reason: -fopt-pair consults it even when
         * the fold is cropped out), and never set when the switch is off, so
         * the image is unchanged. */
        int imm_live = 0;
#if ARKCC_FEATURE_OPT_IMM
        /* imm_left marks the left-operand shape so only commutative ops fold. */
        int imm_left = 0;
        int imm_val = 0;
        int imm_op = 0;
#endif
        for (i = 0; i < f->code_count; i++) {
            IrInst *I = &f->code[i];
#if ARKCC_FEATURE_DWARF
            /* DWARF: emit .loc 1 <line> when the line number changes */
            if (dbg && I->line != 0 && I->line != cur_line) {
                cur_line = I->line;
                asmbuf_puts(&buf, ".loc 1 ");
                asmbuf_int(&buf, cur_line);
                asmbuf_putc(&buf, '\n');
            }
#endif
            rtop_ret = 0;
#if ARKCC_FEATURE_OPT_VOLBAR
            if ((I->aux & IR_AUX_VOLATILE) && g_config.enable_opt_volbar &&
                arm_vol_needs_barrier(I->op))
                emit_line(&buf, "DMB SY");  /* volatile: order prior memory ops */
#endif
            /* P2: the instructions verified to follow a tail call (the dummy
             * PUSH_INT 0 and the IR_RETURN) emit nothing -- the branch is the
             * return. */
            if (tail_return_pending) { tail_return_pending--; continue; }
#if ARKCC_FEATURE_DIVCONST
            if (divconst_skip) { divconst_skip--; continue; }
#endif
#if ARKCC_FEATURE_DIVCONST
            /* P3: the divisor of the divide right behind this push is a constant,
             * so drop the push and let IR_DIV/IR_MOD emit the magic sequence.
             * Anything divconst_prepare() refuses keeps both the push and the
             * hardware divide, i.e. the image is untouched. */
            if (g_config.enable_divconst && I->op == IR_PUSH_INT) {
                /* A negative constant divisor arrives as PUSH_INT k followed by
                 * the unary minus (`x / -5` -> PUSH 5, UNARY MINUS, DIV), so
                 * both shapes are recognised here and the NEG is skipped with
                 * the push.  The divisor is then the negated constant, which
                 * divconst_prepare() judges like any other. */
                int at = 0;
                unsigned dv = (unsigned)I->val;
                if (i + 1 < f->code_count &&
                    (f->code[i + 1].op == IR_DIV || f->code[i + 1].op == IR_MOD))
                    at = 1;
                else if (i + 2 < f->code_count &&
                         f->code[i + 1].op == IR_UNARY &&
                         f->code[i + 1].aux == (int)TOK_MINUS &&
                         f->code[i + 1].val == 0 &&
                         (f->code[i + 2].op == IR_DIV ||
                          f->code[i + 2].op == IR_MOD)) {
                    at = 2;
                    dv = 0u - dv;
                }
                if (at &&
                    divconst_prepare(&divconst_st,
                                     f->code[i + at].aux != 0, dv)) {
                    ark_top_drain(&buf, &rtop);
                    divconst_live = 1;
                    divconst_skip = at - 1;
                    continue;
                }
            }
#endif
#if ARKCC_FEATURE_OPT_IMM
            /* -fopt-imm: swallow a constant that the very next binary op can
             * take as an immediate, so it never travels through the value
             * stack.  Two shapes:
             *   PUSH k / BINARY           -> `POP r0 ; OP r0, r0, #k`
             *   PUSH k / <one push> / BINARY -> the same, k on the right
             *                                 (only commutative ops)
             * ir_pushes_one_word() and emit_binary_imm() decide; both refuse
             * everything they are not sure about, and then this block leaves
             * the push alone and the register form is emitted as before.
             * Not combined with --reg-top: that mode models the same pairing
             * itself and the two would double-skip a value. */
            if (g_config.enable_opt_imm && !ark_top_enabled() && !imm_live &&
                I->op == IR_PUSH_INT) {
                IrInst *n1 = (i + 1 < f->code_count) ? &f->code[i + 1] : 0;
                if (n1 && n1->op == IR_BINARY &&
                    emit_binary_imm(&buf, n1->aux, (int)I->val, 0, 0)) {
                    imm_live = 1;
                    imm_left = 0;
                    imm_val = (int)I->val;
                    imm_op = n1->aux;
                    continue;
                }
                if (n1 && ir_pushes_one_word(n1) && i + 2 < f->code_count &&
                    f->code[i + 2].op == IR_BINARY &&
                    emit_binary_imm(&buf, f->code[i + 2].aux, (int)I->val, 1, 0)) {
                    imm_live = 1;
                    imm_left = 1;
                    imm_val = (int)I->val;
                    imm_op = f->code[i + 2].aux;
                    continue;
                }
            }
#endif
#if ARKCC_FEATURE_OPT_PAIR
            /* -fopt-pair: two adjacent one-word pushes and the binary op that
             * consumes them go out as one sequence with the operands in
             * r0/r1.  Decided before anything is emitted, so a refusal leaves
             * the generic path exactly as it was.  Not combined with --reg-top
             * or -fopt-imm: both already model a value that has not reached
             * the machine stack yet. */
            if (g_config.enable_opt_pair && !ark_top_enabled() && !imm_live &&
                i + 2 < f->code_count &&
                f->code[i + 2].op == IR_BINARY &&
                pair_op_ok(f->code[i + 2].aux) &&
                pair_operand_ok(&f->code[i]) &&
                pair_operand_ok(&f->code[i + 1]) &&
                !pair_imm_preempted(&f->code[i + 1], f->code[i + 2].aux) &&
                !pair_cbranch_preempted(
                    f->code[i + 2].aux,
                    (i + 3 < f->code_count) ? &f->code[i + 3] : 0)) {
                pair_operand_emit(&buf, &f->code[i], 0);
                pair_operand_emit(&buf, &f->code[i + 1], 1);
                emit_binary(&buf, f->code[i + 2].aux);
                emit_push_r0(&buf);
                i += 2;
                continue;
            }
#endif
            if (ark_top_enabled() && ark_top_try(&buf, I, &rtop, &rtop_ret))
                continue;
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END:
                    break;
                case IR_GETARG: {
                    /* AAPCS: first 4 args in r0-r3, args 5+ on caller's stack.
                     * For sret functions, r0 holds the hidden sret pointer;
                     * real args start at r1. The aapcs_map[] (precomputed above)
                     * already accounts for sret by starting at r1, so arg_idx
                     * is used directly as the aapcs_map key — NO manual shift.
                     *
                     * Stack layout (upward from r6 = frame pointer):
                     *   [r6 + 0 .. local_size-1]            this frame's local vars
                     *   [r6 + local_size + 0..15]           saved r5/r6/r7/lr
                     *   [r6 + local_size + 16 .. +31]       variadic only: r0..r3
                     *   [r6 + local_size + 16 + k*4]        the (5+k)th stack arg
                     *                                       (+32, not +16, in a
                     *                                       variadic function)
                     *
                     * aux encoding: low 8 bits = slot index, high 24 bits = type size.
                     *   st_sz > 8  => struct-by-value: reg/stack holds a *pointer*
                     *   st_sz == 8 => 64-bit scalar (long long / double): two words
                     *   st_sz <= 4 => 32-bit or smaller: one word
                     * aapcs_map[slot] gives the AAPCS register (0-3) or -1 for gaps.
                     * For stack args, register number is 4+; offset = (reg-4)*4. */
                    int arg_idx = I->aux & 0xFF;
                    int st_sz   = (I->aux >> 8) & 0xFFFFFF;
                    int dst_off = I->val;
                    int reg     = (arg_idx < 64) ? aapcs_map[arg_idx] : -1;
                    /* A variadic prologue pushed r0-r3 into the frame, so the
                     * caller's stack argument block sits 16 bytes higher. */
                    /* Stack arguments start above the saved registers and
                     * above whatever the prologue pushed for the va region. */
                    int argbase = local_size + 16 + g_va_epilogue_pad;
                    /* The variadic region is spilled once in the prologue
                     * (contiguous words, see "va region spill" above), so
                     * these IR requests -- one per argument word, stamped
                     * with the C backend's 8-byte stride -- need nothing
                     * here. Cheap on purpose: a variadic function gets eight
                     * of them, and none of them must reach the r3 scratch
                     * path below (r0-r3 are gone by this point). */
                    if (dst_off >= ARK_VA_BASE) break;
                    if (st_sz > 8) {
                        /* Struct-by-value (> 8 bytes): register/stack holds a
                         * *pointer* to the source struct. memcpy into frame[dst_off]. */
                        if (reg >= 0 && reg < 4) {
                            asmbuf_puts(&buf, "    MOV r3, r");
                            asmbuf_int(&buf, reg);
                            asmbuf_puts(&buf, "\n");
                        } else {
                            int stack_off = argbase + aapcs_soff[arg_idx];
                            asmbuf_puts(&buf, "    LDR r3, [r6, #");
                            asmbuf_int(&buf, stack_off);
                            asmbuf_puts(&buf, "]\n");
                        }
                        if (st_sz <= 16) {
                            int off;
                            for (off = 0; off < st_sz; off += 4) {
                                asmbuf_puts(&buf, "    LDR r0, [r3, #");
                                asmbuf_int(&buf, off);
                                asmbuf_puts(&buf, "]\n");
                                asmbuf_puts(&buf, "    STR r0, [r6, #");
                                asmbuf_int(&buf, dst_off + off);
                                asmbuf_puts(&buf, "]\n");
                            }
                        } else {
                            /* __aeabi_memcpy clobbers r0-r3, but every argument
                             * after this one is still sitting in r1-r3: the
                             * prologue homes arguments in declaration order, so a
                             * struct placed before them would otherwise wreck
                             * them.  Save r1-r3 across the call.  lr is saved for
                             * the same reason, but the epilogue returns through
                             * the stacked lr into pc, so it is popped into r0 and
                             * dropped -- the trick this block always used. */
                            asmbuf_puts(&buf, "    PUSH {r1, r2, r3}\n    ADD r0, r6, #");
                            asmbuf_int(&buf, dst_off);
                            asmbuf_puts(&buf, "\n    MOV r1, r3\n");
                            emit_mov_imm(&buf, 2, st_sz);
                            asmbuf_puts(&buf, "    PUSH {lr}\n    BL __aeabi_memcpy\n    POP {r0}\n"
                                             "    POP {r1, r2, r3}\n");
                        }
                    } else if (st_sz > 4) {
                        /* Two words: a 64-bit scalar (long long / double) or a
                         * composite of 5..8 bytes, which AAPCS carries in an
                         * even register pair / two stack words.  The test used
                         * to be `st_sz == 8`, so a 5..7-byte struct fell into
                         * the one-word branch below and the callee kept only
                         * the low four bytes -- measured: `struct S5{char
                         * a,b,c,d,e;}` passed by value read s.e as 0 instead
                         * of 5.  alloc_local() rounds every slot up to 8
                         * bytes, so the second store stays inside this
                         * parameter's own slot.  Words come from the even
                         * register pair (r0/r1 or r2/r3) or the caller's
                         * stack. */
                        int reg_hi = (arg_idx + 1 < 64) ? aapcs_map[arg_idx + 1] : -1;
                        /* Low word */
                        if (reg >= 0 && reg < 4) {
                            asmbuf_puts(&buf, "    STR r");
                            asmbuf_int(&buf, reg);
                            asmbuf_puts(&buf, ", [r6, #");
                            asmbuf_int(&buf, dst_off);
                            asmbuf_puts(&buf, "]\n");
                        } else {
                            int soff = argbase + aapcs_soff[arg_idx];
                            asmbuf_puts(&buf, "    LDR r0, [r6, #");
                            asmbuf_int(&buf, soff);
                            asmbuf_puts(&buf, "]\n    STR r0, [r6, #");
                            asmbuf_int(&buf, dst_off);
                            asmbuf_puts(&buf, "]\n");
                        }
                        /* High word */
                        if (reg_hi >= 0 && reg_hi < 4) {
                            asmbuf_puts(&buf, "    STR r");
                            asmbuf_int(&buf, reg_hi);
                            asmbuf_puts(&buf, ", [r6, #");
                            asmbuf_int(&buf, dst_off + 4);
                            asmbuf_puts(&buf, "]\n");
                        } else {
                            int soff = argbase + aapcs_soff[arg_idx + 1];
                            asmbuf_puts(&buf, "    LDR r0, [r6, #");
                            asmbuf_int(&buf, soff);
                            asmbuf_puts(&buf, "]\n    STR r0, [r6, #");
                            asmbuf_int(&buf, dst_off + 4);
                            asmbuf_puts(&buf, "]\n");
                        }
                    } else {
                        /* 32-bit or smaller: one word */
                        if (reg >= 0 && reg < 4) {
                            asmbuf_puts(&buf, "    STR r");
                            asmbuf_int(&buf, reg);
                            asmbuf_puts(&buf, ", [r6, #");
                            asmbuf_int(&buf, dst_off);
                            asmbuf_puts(&buf, "]\n");
                        } else {
                            int soff = argbase + aapcs_soff[arg_idx];
                            asmbuf_puts(&buf, "    LDR r0, [r6, #");
                            asmbuf_int(&buf, soff);
                            asmbuf_puts(&buf, "]\n    STR r0, [r6, #");
                            asmbuf_int(&buf, dst_off);
                            asmbuf_puts(&buf, "]\n");
                        }
                    }
                    break;
                }
                case IR_PUSH_INT:
                    emit_mov_imm(&buf, 0, I->val);
                    emit_push_r0(&buf);
                    break;
                case IR_PUSH_STR:
                    asmbuf_puts(&buf, "    LDR r0, =.L_str_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    emit_push_r0(&buf);
                    break;
                case IR_PUSH_VAR: {
                    /* aux encodes width + signedness:
                     *   1 = char (LDRSB signed / LDRB unsigned)
                     *   2 = short (LDRSH signed / LDRH unsigned)
                     *   4 or 0 = int/ptr (LDR 4 bytes)
                     *   8 = 64-bit (long long / double): load two words, push both
                     *   0x100 bit = unsigned
                     *   0x10000 bit (IR_AUX_VOLATILE) = volatile read: emit
                     *     DMB SY barriers before and after to enforce ordering. */
                    int width = I->aux & 0xFF;
                    int is_unsigned = (I->aux & 0x100) != 0;
                    int is_volatile = (I->aux & IR_AUX_VOLATILE) != 0;
                    if (is_volatile && !vdm_elide(I->name))
                        emit_line(&buf, "DMB SY");  /* volatile: order prior memory ops */
                    if (width == 8 && (I->aux & IR_AUX_COMPLEX)) {
                        /* _Complex float: widen each float half into a double
                         * pair, imaginary first so the real high word ends on top. */
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, I->val + 4);
                        asmbuf_puts(&buf, "]\n");
                        arm_cvt_f2d(&buf);
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
                        arm_cvt_f2d(&buf);
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    } else if (width == 1) {
                        asmbuf_puts(&buf, is_unsigned
                            ? "    LDRB r0, [r6, #"
                            : "    LDRSB r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
                        emit_push_r0(&buf);
                    } else if (width == 2) {
                        asmbuf_puts(&buf, is_unsigned
                            ? "    LDRH r0, [r6, #"
                            : "    LDRSH r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
                        emit_push_r0(&buf);
                    } else if (width >= 16) {
                        /* _Complex double: four words, same order IR_STORE's
                         * 16-byte case reads them back. */
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, I->val + 8);
                        asmbuf_puts(&buf, "]\n    PUSH {r0}\n");   /* imag low  */
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, I->val + 12);
                        asmbuf_puts(&buf, "]\n    PUSH {r0}\n");   /* imag high */
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n    PUSH {r0}\n");   /* real low  */
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, I->val + 4);
                        asmbuf_puts(&buf, "]\n    PUSH {r0}\n");   /* real high */
                    } else if (width == 8) {
                        /* #5 FIX: 64-bit local variable read - load low and high words.
                         * Stack model: push low word first (bottom), then high word (top). */
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n    LDR r1, [r6, #");
                        asmbuf_int(&buf, I->val + 4);
                        asmbuf_puts(&buf, "]\n");
                        emit_push_r0(&buf);  /* push low word */
                        asmbuf_puts(&buf, "    PUSH {r1}\n");  /* push high word */
                    } else {
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
                        emit_push_r0(&buf);
                    }
                    if (is_volatile && !vdm_elide(I->name))
                        emit_line(&buf, "DMB SY");  /* volatile: order subsequent memory ops */
                    break;
                }
                case IR_PUSH_ADDR:
                    asmbuf_puts(&buf, "    ADD r0, r6, #");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    emit_push_r0(&buf);
                    break;
                case IR_PUSH_GLOBAL: {
                    int gsz;
                    if (is_va_ptr_sym(I->name)) {
                        if (!g_va_active) va_ptr_needs_variadic();
                        emit_va_ptr(&buf, 0);
                        emit_push_r0(&buf);
                        break;
                    }
                    gsz = gvar_find_size(I->name);
                    if (gsz == 8 && (I->aux & IR_AUX_COMPLEX)) {
                        /* _Complex float global: widen both halves.  The address is
                         * rebuilt after the call because r0/r1 hold the result. */
                        emit_gvar_addr32(&buf, 1, I->name);
                        emit_line(&buf, "LDR r0, [r1, #4]");
                        arm_cvt_f2d(&buf);
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                        emit_gvar_addr32(&buf, 1, I->name);
                        emit_line(&buf, "LDR r0, [r1, #0]");
                        arm_cvt_f2d(&buf);
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    } else if (gsz >= 16) {
                        /* _Complex double global: four words, imag first. */
                        emit_gvar_addr32(&buf, 1, I->name);
                        asmbuf_puts(&buf, "    LDR r0, [r1, #8]\n    PUSH {r0}\n");
                        asmbuf_puts(&buf, "    LDR r0, [r1, #12]\n    PUSH {r0}\n");
                        asmbuf_puts(&buf, "    LDR r0, [r1, #0]\n    PUSH {r0}\n");
                        asmbuf_puts(&buf, "    LDR r0, [r1, #4]\n    PUSH {r0}\n");
                    } else if (gsz >= 8) {
                        /* #6 FIX: 64-bit global read - load low and high words */
                        emit_gvar_addr32(&buf, 1, I->name);
                        asmbuf_puts(&buf, "    LDR r0, [r1, #0]\n");
                        asmbuf_puts(&buf, "    LDR r2, [r1, #4]\n");
                        emit_push_r0(&buf);  /* push low word */
                        asmbuf_puts(&buf, "    PUSH {r2}\n");  /* push high word */
                    } else {
                        emit_gvar_addr32(&buf, 0, I->name);
                        emit_line(&buf, "LDR r0, [r0]");
                        emit_push_r0(&buf);
                    }
                    break;
                }
                case IR_TRUNC:
                    /* val = target width, aux = 1 zero-extend (unsigned).
                     * 32-bit widths need no work: the stack word already holds
                     * exactly the truncated 32-bit pattern. */
                    if (I->val == 8 || I->val == 16) {
                        char op8[8];
                        op8[0] = I->aux ? 'U' : 'S';
                        op8[1] = 'X';
                        op8[2] = 'T';
                        op8[3] = (I->val == 8) ? 'B' : 'H';
                        op8[4] = 0;
                        emit_pop_r0(&buf);
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, op8);
                        asmbuf_puts(&buf, " r0, r0\n");
                        emit_push_r0(&buf);
                    }
                    break;
                case IR_PUSH_FUNC:
                    /* Address of a function = its label. Use the literal-pool
                     * pseudo-instruction the string/double pools already use. */
                    asmbuf_puts(&buf, "    LDR r0, =");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    emit_push_r0(&buf);
                    break;
                case IR_PUSH_GLOBAL_ADDR:
                    /* Take the global symbol address only (no dereference), for
                     * array/struct decay and compound literal scenarios.
                     * This is the path `table[i]` takes when `table` is an
                     * extern array: it used to emit MOV r0,#0 + the index
                     * offset, i.e. a read/write through the vector table with
                     * no relocation and no diagnostic (measured: an extern
                     * `int table[4]` store landed at address 0x8). */
                    emit_gvar_addr32(&buf, 0, I->name);
                    emit_push_r0(&buf);
                    break;
                case IR_STORE_GLOBAL: {
                    int gsz = gvar_find_size(I->name);
                    if (gsz == 8 && (I->aux & IR_AUX_COMPLEX)) {
                        /* _Complex float global: narrow each double pair back to a float. */
                        asmbuf_puts(&buf, "    POP {r1}\n");
                        emit_pop_r0(&buf);
                        arm_cvt_d2f(&buf);
                        emit_gvar_addr32(&buf, 2, I->name);
                        emit_line(&buf, "STR r0, [r2, #0]");
                        asmbuf_puts(&buf, "    POP {r1}\n");
                        emit_pop_r0(&buf);
                        arm_cvt_d2f(&buf);
                        emit_gvar_addr32(&buf, 2, I->name);
                        emit_line(&buf, "STR r0, [r2, #4]");
                    } else if (gsz >= 16) {
                        /* _Complex double global: the value is a dup'd copy of
                         * four stack words with the real high word on top; the
                         * object image is re_lo, re_hi, im_lo, im_hi.  The old
                         * `gsz >= 8` branch popped two of the four words and
                         * stored them as a single double, so `gz = 1+2i` wrote
                         * 1 and left the imaginary part at whatever the BSS
                         * held (measured: (int)(creal*10+cimag) answered 10,
                         * want 12). */
                        asmbuf_puts(&buf, "    POP {r1}\n");   /* re_hi */
                        emit_pop_r0(&buf);                      /* re_lo */
                        asmbuf_puts(&buf, "    POP {r3}\n");   /* im_hi */
                        asmbuf_puts(&buf, "    POP {r2}\n");   /* im_lo */
                        emit_gvar_addr32(&buf, 12, I->name);
                        asmbuf_puts(&buf, "    STR r0, [r12, #0]\n");
                        asmbuf_puts(&buf, "    STR r1, [r12, #4]\n");
                        asmbuf_puts(&buf, "    STR r2, [r12, #8]\n");
                        asmbuf_puts(&buf, "    STR r3, [r12, #12]\n");
                    } else if (gsz >= 8) {
                        /* #6 FIX: 64-bit global store - pop high then low, store both */
                        asmbuf_puts(&buf, "    POP {r1}\n");  /* high word */
                        emit_pop_r0(&buf);                     /* low word */
                        emit_gvar_addr32(&buf, 2, I->name);
                        asmbuf_puts(&buf, "    STR r0, [r2, #0]\n");
                        asmbuf_puts(&buf, "    STR r1, [r2, #4]\n");
                    } else {
                        emit_pop_r0(&buf);
                        emit_gvar_addr32(&buf, 1, I->name);
                        emit_line(&buf, "STR r0, [r1]");
                    }
                    break;
                }
                case IR_POP:
                    emit_pop_r0(&buf);
                    break;
                case IR_DUP: {
                    /* val = number of 32-bit words to duplicate (0/1 = one).
                     * A long long occupies two stack words with the high word on
                     * top, so duplicating just one word produced
                     * [low, high, high]; the 8-byte store that follows then wrote
                     * the high word into BOTH halves of the object.  Measured
                     * before the fix:
                     *     long long a; a = -7LL;  -> a == -1     (want -7)
                     *     long long a; a =  7LL;  -> a ==  0     (want  7)
                     * which in turn made every signed 64-bit division with a
                     * negative operand return garbage. */
                    int nw = I->val > 0 ? I->val : 1;
                    int i;
                    if (nw > 4) nw = 4;
                    for (i = 0; i < nw; i++) {
                        if (i == 0) {
                            emit_pop_r0(&buf);
                        } else {
                            asmbuf_puts(&buf, "    POP {r");
                            asmbuf_int(&buf, i);
                            asmbuf_puts(&buf, "}\n");
                        }
                    }
                    for (i = nw - 1; i >= 0; i--) {
                        if (i == 0) {
                            emit_push_r0(&buf);
                        } else {
                            asmbuf_puts(&buf, "    PUSH {r");
                            asmbuf_int(&buf, i);
                            asmbuf_puts(&buf, "}\n");
                        }
                    }
                    for (i = nw - 1; i >= 0; i--) {
                        if (i == 0) {
                            emit_push_r0(&buf);
                        } else {
                            asmbuf_puts(&buf, "    PUSH {r");
                            asmbuf_int(&buf, i);
                            asmbuf_puts(&buf, "}\n");
                        }
                    }
                    break;
                }
                case IR_SWAP:
                    /* Pop top two values and push them back in swapped order.
                     * r0 = top, r1 = next -> push r0, push r1 */
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, "    POP {r1}\n");
                    emit_push_r0(&buf);
                    asmbuf_puts(&buf, "    PUSH {r1}\n");
                    break;
                case IR_SEXT:
                case IR_ZEXT:
                case IR_CDECL64:
                    /* x86-cdecl-specific 64-bit arg passing conversion.
                     * ARM AAPCS passes 64-bit values in register pairs or
                     * 8-byte aligned stack slots as a unit; no conversion
                     * needed. Treat as no-op. */
                    break;
                case IR_STORE: {
                    /* aux encodes store width: 1=byte, 2=halfword, 4=word,
                     * 8=double word (two STRs), 16=complex (two 8-byte).
                     * Default (0) = 4 bytes.
                     * N1 FIX: mask off IR_AUX_VOLATILE (0x10000) bit before
                     * checking width — volatile uint32_t has aux=0x10004,
                     * which would wrongly match sw>=8 and sw>=16, causing
                     * 16-byte writes into an 8-byte slot and corrupting
                     * saved registers on the stack.
                     * N5 FIX: volatile stores emit DMB SY before (release) and
                     * after (full barrier) to enforce memory ordering. */
                    int sw = I->aux & ~(IR_AUX_VOLATILE | IR_AUX_COMPLEX);
                    /* An 8-byte _Complex float store still has to narrow the
                     * four double words down to two floats, so the flag is masked
                     * out of `sw` above and tested separately here. */
                    int cplx8 = (I->aux & IR_AUX_COMPLEX) && sw == 8;
                    int is_volatile = (I->aux & IR_AUX_VOLATILE) != 0;
                    if (sw == 0) sw = 4;
                    if (is_volatile && !vdm_elide(I->name))
                        emit_line(&buf, "DMB SY");  /* volatile: release barrier */
                        if (cplx8) {
                            asmbuf_puts(&buf, "    POP {r1}\n");
                            emit_pop_r0(&buf);
                            arm_cvt_d2f(&buf);
                            asmbuf_puts(&buf, "    STR r0, [r6, #");
                            asmbuf_int(&buf, I->val);
                            asmbuf_puts(&buf, "]\n");
                            asmbuf_puts(&buf, "    POP {r1}\n");
                            emit_pop_r0(&buf);
                            arm_cvt_d2f(&buf);
                            asmbuf_puts(&buf, "    STR r0, [r6, #");
                            asmbuf_int(&buf, I->val + 4);
                            asmbuf_puts(&buf, "]\n");
                        } else if (sw == 1) {
                        emit_pop_r0(&buf);
                        asmbuf_puts(&buf, "    STRB r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
                    } else if (sw == 2) {
                        emit_pop_r0(&buf);
                        asmbuf_puts(&buf, "    STRH r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
                    } else if (sw >= 8) {
                        /* 8+ bytes: pop high word then low word, store both */
                        asmbuf_puts(&buf, "    POP {r1}\n");  /* high word */
                        emit_pop_r0(&buf);                     /* low word */
                        asmbuf_puts(&buf, "    STR r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
                        asmbuf_puts(&buf, "    STR r1, [r6, #");
                        asmbuf_int(&buf, I->val + 4);
                        asmbuf_puts(&buf, "]\n");
                        if (sw >= 16) {
                            asmbuf_puts(&buf, "    POP {r1}\n");
                            emit_pop_r0(&buf);
                            asmbuf_puts(&buf, "    STR r0, [r6, #");
                            asmbuf_int(&buf, I->val + 8);
                            asmbuf_puts(&buf, "]\n");
                            asmbuf_puts(&buf, "    STR r1, [r6, #");
                            asmbuf_int(&buf, I->val + 12);
                            asmbuf_puts(&buf, "]\n");
                        }
                    } else {
                        emit_pop_r0(&buf);
                        asmbuf_puts(&buf, "    STR r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
                    }
                    if (is_volatile && !vdm_elide(I->name))
                        emit_line(&buf, "DMB SY");  /* volatile: full barrier */
                    break;
                }
                case IR_LOAD_IDX: {
                    int es = I->val;
                    /* Bug-I5 FIX: mask off IR_AUX_VOLATILE (0x10000) before
                     * checking the packed flag. The volatile bit is carried for
                     * optimizer/host-compiler correctness and does not affect
                     * the ARM load encoding. */
                    int packed = (I->aux & 0x400) ? 1 : 0;
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    if (es > 1) {
                        /* -fopt-strength: a power-of-two element size scales by
                         * a shift, one instruction instead of the MOV/MUL pair.
                         * The product is exact either way -- both forms keep the
                         * low 32 bits of r1 * es -- so this cannot change an
                         * answer.  Every size that is not a power of two keeps
                         * the multiply (Cortex-M4 multiplies in one cycle, and a
                         * shift/add chain for, say, 12 would be two instructions
                         * as well). */
                        if (g_config.enable_opt_strength && (es & (es - 1)) == 0) {
                            int sh = 0;
                            while ((1 << sh) < es) sh++;
                            asmbuf_puts(&buf, "    LSL r1, r1, #");
                            asmbuf_int(&buf, sh);
                            asmbuf_putc(&buf, '\n');
                        } else {
                            emit_mov_imm(&buf, 2, es);
                            emit_line(&buf, "MUL r1, r2");
                        }
                    }
                    emit_line(&buf, "ADD r0, r0, r1");
                    if (es == 8 && (I->aux & IR_AUX_COMPLEX)) {
                        /* _Complex float element: r0 is the element address.  Keep it
                         * on the stack across the first conversion and in r2 across the
                         * second one (r2 is caller-saved but nothing else needs it here). */
                        asmbuf_puts(&buf, "    PUSH {r0}\n");
                        emit_line(&buf, "LDR r0, [r0, #4]");
                        arm_cvt_f2d(&buf);
                        asmbuf_puts(&buf, "    POP {r2}\n");
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                        emit_line(&buf, "LDR r0, [r2, #0]");
                        arm_cvt_f2d(&buf);
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                        break;
                    }
                    if (es == 1) {
                        emit_line(&buf, "LDRB r0, [r0, #0]");
                    } else if (es == 2 && !packed) {
                        emit_line(&buf, "LDRSH r0, [r0, #0]");
                    } else if (packed) {
                        /* __packed pointer unaligned access: load byte by byte then assemble.
                         * es==2: LDRB x2 + LSL + ORR
                         * es==4: LDRB x4 + LSL + ORR chain
                         * r0=address, r2/r3 are scratch registers */
                        if (es == 2) {
                            emit_line(&buf, "LDRB r2, [r0, #0]");
                            emit_line(&buf, "LDRB r3, [r0, #1]");
                            emit_line(&buf, "LSL r3, r3, #8");
                            emit_line(&buf, "ORR r0, r2, r3");
                        } else if (es == 4) {
                            emit_line(&buf, "LDRB r2, [r0, #0]");
                            emit_line(&buf, "LDRB r3, [r0, #1]");
                            emit_line(&buf, "LSL r3, r3, #8");
                            emit_line(&buf, "ORR r2, r2, r3");
                            emit_line(&buf, "LDRB r3, [r0, #2]");
                            emit_line(&buf, "LSL r3, r3, #16");
                            emit_line(&buf, "ORR r2, r2, r3");
                            emit_line(&buf, "LDRB r3, [r0, #3]");
                            emit_line(&buf, "LSL r3, r3, #24");
                            emit_line(&buf, "ORR r0, r2, r3");
                        } else {
                            /* es == 8: assemble the low word, push it, then the
                             * high word and push that -- the same "low first,
                             * high on top" order the aligned path uses, so the
                             * consumer cannot tell the two apart.  This used to
                             * fall into the 4-byte branch above and hand back a
                             * silently short long long; it is now real. */
                            emit_line(&buf, "LDRB r2, [r0, #0]");
                            emit_line(&buf, "LDRB r3, [r0, #1]");
                            emit_line(&buf, "LSL r3, r3, #8");
                            emit_line(&buf, "ORR r2, r2, r3");
                            emit_line(&buf, "LDRB r3, [r0, #2]");
                            emit_line(&buf, "LSL r3, r3, #16");
                            emit_line(&buf, "ORR r2, r2, r3");
                            emit_line(&buf, "LDRB r3, [r0, #3]");
                            emit_line(&buf, "LSL r3, r3, #24");
                            emit_line(&buf, "ORR r2, r2, r3");
                            emit_line(&buf, "PUSH {r2}");
                            emit_line(&buf, "LDRB r2, [r0, #4]");
                            emit_line(&buf, "LDRB r3, [r0, #5]");
                            emit_line(&buf, "LSL r3, r3, #8");
                            emit_line(&buf, "ORR r2, r2, r3");
                            emit_line(&buf, "LDRB r3, [r0, #6]");
                            emit_line(&buf, "LSL r3, r3, #16");
                            emit_line(&buf, "ORR r2, r2, r3");
                            emit_line(&buf, "LDRB r3, [r0, #7]");
                            emit_line(&buf, "LSL r3, r3, #24");
                            emit_line(&buf, "ORR r2, r2, r3");
                            emit_line(&buf, "PUSH {r2}");
                            break;
                        }
                    } else if (es == 16) {
                        /* _Complex double element: four words.  Object layout in
                         * memory is the standard C one -- [0]=re_lo [4]=re_hi
                         * [8]=im_lo [12]=im_hi -- while the expression stack
                         * wants real on top, i.e. sp+0=re_hi sp+4=re_lo
                         * sp+8=im_hi sp+12=im_lo.  Push in the order that
                         * produces that: im_lo, im_hi, re_lo, re_hi. */
                        emit_line(&buf, "LDR r2, [r0, #8]");
                        emit_line(&buf, "PUSH {r2}");
                        emit_line(&buf, "LDR r2, [r0, #12]");
                        emit_line(&buf, "PUSH {r2}");
                        emit_line(&buf, "LDR r2, [r0, #0]");
                        emit_line(&buf, "PUSH {r2}");
                        emit_line(&buf, "LDR r2, [r0, #4]");
                        emit_line(&buf, "PUSH {r2}");
                        break;
                    } else if (es == 8) {
                        /* #A4 FIX: 8-byte element (long long/double): load low and high words.
                         * Stack convention (from IR_STORE): high word on top, low below.
                         * So push low first, then high. */
                        emit_line(&buf, "LDR r2, [r0, #0]");  /* r2 = low word */
                        emit_line(&buf, "LDR r3, [r0, #4]");  /* r3 = high word */
                        emit_line(&buf, "PUSH {r2}");  /* push low word */
                        emit_line(&buf, "PUSH {r3}");  /* push high word (on top) */
                        break;
                    } else {
                        emit_line(&buf, "LDR r0, [r0, #0]");
                    }
                    emit_push_r0(&buf);
                    break;
                }
                case IR_STORE_IDX: {
                    int es = I->val;
                    /* Bug-I5 FIX: mask off IR_AUX_VOLATILE (0x10000) before
                     * checking the packed flag. The volatile bit is carried for
                     * optimizer/host-compiler correctness and does not affect
                     * the ARM store encoding. */
                    int packed = (I->aux & 0x400) ? 1 : 0;
                    if (es == 8 && packed) {
                        /* 8-byte __packed store: the same three stack slots as
                         * the aligned path, but written one byte at a time --
                         * an aligned STR to an odd address faults.  r3 is the
                         * shift scratch; the value is pushed back so the store
                         * expression still has a value. */
                        emit_line(&buf, "POP {r1}");          /* r1 = high word (top) */
                        emit_pop_r0(&buf);                     /* r0 = low word */
                        emit_line(&buf, "POP {r2}");          /* r2 = addr */
                        emit_line(&buf, "STRB r0, [r2, #0]");
                        emit_line(&buf, "LSR r3, r0, #8");
                        emit_line(&buf, "STRB r3, [r2, #1]");
                        emit_line(&buf, "LSR r3, r0, #16");
                        emit_line(&buf, "STRB r3, [r2, #2]");
                        emit_line(&buf, "LSR r3, r0, #24");
                        emit_line(&buf, "STRB r3, [r2, #3]");
                        emit_line(&buf, "STRB r1, [r2, #4]");
                        emit_line(&buf, "LSR r3, r1, #8");
                        emit_line(&buf, "STRB r3, [r2, #5]");
                        emit_line(&buf, "LSR r3, r1, #16");
                        emit_line(&buf, "STRB r3, [r2, #6]");
                        emit_line(&buf, "LSR r3, r1, #24");
                        emit_line(&buf, "STRB r3, [r2, #7]");
                        emit_line(&buf, "PUSH {r0}");
                        emit_line(&buf, "PUSH {r1}");
                        break;
                    }
                    if (es == 8 && (I->aux & IR_AUX_COMPLEX)) {
                        /* _Complex float store.  Stack from sp:
                         *   [re_hi, re_lo, im_hi, im_lo, addr]
                         * The four words are read by offset, never popped before
                         * the narrowings: emitting the narrowing is a libgcc call
                         * (BL clobbers r0-r3) and the old code parked the real
                         * half with PUSH on top of the words it still had to read,
                         * so the imaginary half was served the parked word and
                         * `farr[1] = 2-3i` stored (0, re) instead of (re, im). */
                        emit_line(&buf, "LDR r1, [sp, #0]");     /* re_hi */
                        emit_line(&buf, "LDR r0, [sp, #4]");     /* re_lo */
                        arm_cvt_d2f(&buf);                       /* r0 = re32 */
                        emit_line(&buf, "LDR r2, [sp, #16]");    /* addr */
                        emit_line(&buf, "STR r0, [r2, #0]");
                        emit_line(&buf, "LDR r1, [sp, #8]");     /* im_hi */
                        emit_line(&buf, "LDR r0, [sp, #12]");    /* im_lo */
                        arm_cvt_d2f(&buf);                       /* r0 = im32 */
                        emit_line(&buf, "LDR r2, [sp, #16]");    /* addr (r2 was clobbered) */
                        emit_line(&buf, "STR r0, [r2, #4]");
                        emit_line(&buf, "ADD sp, sp, #20");      /* drop value + addr */
                        asmbuf_puts(&buf, "    PUSH {r2}\n");        /* park addr */
                        emit_line(&buf, "LDR r0, [r2, #4]");
                        arm_cvt_f2d(&buf);
                        asmbuf_puts(&buf, "    POP {r2}\n");
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                        emit_line(&buf, "LDR r0, [r2, #0]");
                        arm_cvt_f2d(&buf);
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                        break;
                    }
                    if (es == 16) {
                        /* _Complex double store.  Stack from sp is
                         * [re_hi, re_lo, im_hi, im_lo, addr]; the object is
                         * written in the standard C layout so the generic
                         * LOAD_IDX / IR_STORE / libgcc helpers all agree. */
                        emit_line(&buf, "POP {r1}");            /* r1 = re_hi */
                        emit_pop_r0(&buf);                       /* r0 = re_lo */
                        emit_line(&buf, "POP {r3}");            /* r3 = im_hi */
                        emit_line(&buf, "POP {r2}");            /* r2 = im_lo */
                        emit_line(&buf, "POP {r12}");            /* r12 = addr */
                        emit_line(&buf, "STR r0, [r12, #0]");
                        emit_line(&buf, "STR r1, [r12, #4]");
                        emit_line(&buf, "STR r2, [r12, #8]");
                        emit_line(&buf, "STR r3, [r12, #12]");
                        /* Push the value back in the same order the expression
                         * stack uses, so the store still yields the value. */
                        emit_line(&buf, "PUSH {r2}");
                        emit_line(&buf, "PUSH {r3}");
                        emit_line(&buf, "PUSH {r0}");
                        emit_line(&buf, "PUSH {r1}");
                        break;
                    }
                    if (es == 8) {
                        /* #A4 FIX: 8-byte element (long long/double): stack has
                         * [addr, value_low, value_high] (high on top, per IR_STORE
                         * convention). Pop high, low, addr; store both; push back. */
                        emit_line(&buf, "POP {r1}");          /* r1 = high word (top) */
                        emit_pop_r0(&buf);                     /* r0 = low word */
                        emit_line(&buf, "POP {r2}");          /* r2 = addr */
                        emit_line(&buf, "STR r0, [r2, #0]");
                        emit_line(&buf, "STR r1, [r2, #4]");
                        /* Push value back as expression result: low then high */
                        emit_line(&buf, "PUSH {r0}");
                        emit_line(&buf, "PUSH {r1}");
                        break;
                    }
                    emit_pop_r0(&buf);
                    emit_pop_r1(&buf);
                    if (es == 1) {
                        emit_line(&buf, "STRB r0, [r1, #0]");
                    } else if (es == 2 && !packed) {
                        emit_line(&buf, "STRH r0, [r1, #0]");
                    } else if (packed) {
                        /* __packed pointer unaligned store: write byte by byte.
                         * r0=value, r1=address, r2 is a scratch register */
                        if (es == 2) {
                            emit_line(&buf, "STRB r0, [r1, #0]");
                            emit_line(&buf, "LSR r2, r0, #8");
                            emit_line(&buf, "STRB r2, [r1, #1]");
                        } else {
                            emit_line(&buf, "STRB r0, [r1, #0]");
                            emit_line(&buf, "LSR r2, r0, #8");
                            emit_line(&buf, "STRB r2, [r1, #1]");
                            emit_line(&buf, "LSR r2, r0, #16");
                            emit_line(&buf, "STRB r2, [r1, #2]");
                            emit_line(&buf, "LSR r2, r0, #24");
                            emit_line(&buf, "STRB r2, [r1, #3]");
                        }
                    } else {
                        emit_line(&buf, "STR r0, [r1, #0]");
                    }
                    emit_push_r0(&buf);
                    break;
                }
                case IR_BINARY:
#if ARKCC_FEATURE_OPT_IMM
                    if (imm_live) {
                        /* the constant is gone; one real operand is on the stack */
                        imm_live = 0;
#if ARKCC_FEATURE_OPT_CBRANCH
                        /* -fopt-cbranch on the immediate path: the 0/1 result is
                         * consumed by the next branch, so compare against the
                         * constant and branch, with no materialisation at all.
                         * The constant cannot be the left operand here: that
                         * shape is only folded for commutative operators and a
                         * comparison is not one. */
                        if (g_config.enable_opt_cbranch && !ark_top_enabled() &&
                            !imm_left && i + 1 < f->code_count &&
                            (f->code[i + 1].op == IR_JZ ||
                             f->code[i + 1].op == IR_JNZ)) {
                            const char *mn = cbranch_mnemonic(
                                imm_op & ~0x100, (imm_op & 0x100) != 0,
                                f->code[i + 1].op == IR_JNZ);
                            if (mn) {
                                unsigned d_i, d_imm3, d_imm8;
                                int enc;
                                emit_pop_r0(&buf);
                                enc = imm_val >= 0 &&
                                      (imm_val <= 255 ||
                                       thumb_imm12_a((unsigned)imm_val, &d_i,
                                                     &d_imm3, &d_imm8));
                                if (enc) {
                                    asmbuf_puts(&buf, "    CMP r0, #");
                                    asmbuf_int(&buf, imm_val);
                                    asmbuf_putc(&buf, '\n');
                                } else {
                                    emit_mov_imm(&buf, 1, imm_val);
                                    emit_line(&buf, "CMP r0, r1");
                                }
                                emit_b_label(&buf, mn, f->name, f->code[i + 1].val);
                                i++;   /* the IR_JZ/IR_JNZ is emitted */
                                break;
                            }
                        }
#endif
                        emit_pop_r0(&buf);
                        if (!emit_binary_imm(&buf, imm_op, imm_val, imm_left, 1))
                            emit_line(&buf, "; imm fold inconsistent");
                        emit_push_r0(&buf);
                        break;
                    }
#endif
#if ARKCC_FEATURE_OPT_CBRANCH
                    /* -fopt-cbranch, register path: `if (a < b)` arrives as
                     * IR_BINARY(TOK_LT) / IR_JZ.  The result is dead, so branch
                     * on the comparison itself instead of building 0/1 and
                     * testing it again -- six instructions become three. */
                    if (g_config.enable_opt_cbranch && !ark_top_enabled() &&
                        i + 1 < f->code_count &&
                        (f->code[i + 1].op == IR_JZ ||
                         f->code[i + 1].op == IR_JNZ)) {
                        const char *mn = cbranch_mnemonic(
                            (int)(I->aux & ~0x100), (I->aux & 0x100) != 0,
                            f->code[i + 1].op == IR_JNZ);
                        if (mn) {
                            emit_pop_r1(&buf);
                            emit_pop_r0(&buf);
                            emit_line(&buf, "CMP r0, r1");
                            emit_b_label(&buf, mn, f->name, f->code[i + 1].val);
                            i++;   /* the IR_JZ/IR_JNZ is emitted */
                            break;
                        }
                    }
#endif
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    emit_binary(&buf, I->aux);
                    emit_push_r0(&buf);
                    break;
                case IR_UNARY:
                    if (I->aux & IR_AUX_COMPLEX) {
                        /* conj: flip the sign bit of the imaginary part, which
                         * is its high word at sp+8. */
                        arm_ldr_sp(&buf, 0, 8);
                        emit_line(&buf, "EOR r0, r0, #0x80000000");
                        arm_str_sp(&buf, 0, 8);
                        break;
                    }
                    if (I->val == 2 &&
                        (I->aux == (int)TOK_MINUS || I->aux == (int)TOK_BNOT)) {
                        /* 64-bit negate / complement (irgen marks the width in
                         * I->val: 2 = two stack slots).  Both words belong to one
                         * value, so both have to change -- the old single-word
                         * path flipped only the high half and left the low half
                         * as it was (measured: -100LL compared unequal to -100
                         * and shifted as +100).
                         * Negate is two's complement: invert both words, add one,
                         * and push the carry from the low word into the high one.
                         * The 16-bit ADD sets the flags the ADC needs. */
                        emit_pop_r1(&buf);
                        emit_pop_r0(&buf);
                        emit_line(&buf, "MVN r0, r0");
                        emit_line(&buf, "MVN r1, r1");
                        if (I->aux == (int)TOK_MINUS) {
                            /* Two-operand ADDS, not three-operand ADD: in
                             * unified syntax the three-operand form assembles to the
                             * 32-bit ADD.W.  That is architecturally equivalent, but
                             * the Unicorn-based gate harness does not update the flags
                             * for ADD.W (measured: with carry pre-set, ADC then added
                             * an extra 1 and -7LL came out as -8).  The 16-bit form
                             * sets the flags correctly on both hardware and the harness
                             * and is one instruction shorter. */
                            emit_line(&buf, "ADDS r0, #1");   /* ADDS, not ADD: GNU as encodes
                             * "add r0, r0, #imm"/"add r0, #imm" without
                             * the S as the 32-bit ADD.W, which leaves the
                             * flags alone (verified with objdump: `adds
                             * r0, #1` -> 3001, `add r0, #1` -> f100 0001),
                             * and the carry into the ADC below depends on
                             * them.  The built-in assembler accepts
                             * ADDS/SUBS unconditionally for this reason. */
                            emit_line(&buf, "MOV r2, #0");
                            emit_line(&buf, "ADC r1, r2");
                        }
                        asmbuf_puts(&buf, "    PUSH {r0}\n");
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                        break;
                    }
                    if (I->val == 1) {
                        /* Floating-point negation.  irgen tags `-x` on a float
                         * or a double with val=1, and this used to run it
                         * through the integer NEG: that mangles the exponent of
                         * every value and turns -0.0 into +0.0, where IEEE only
                         * flips the sign bit.  A float is one word on the stack
                         * and a double's HIGH word is on top -- that word holds
                         * the sign bit in both cases, so popping one word and
                         * flipping bit 31 is right for both, with no need to
                         * know which precision it is. */
                        emit_pop_r0(&buf);
                        if (I->aux == (int)TOK_MINUS) {
                            emit_line(&buf, "EOR r0, r0, #0x80000000");
                        } else {
                            char b1[12];
                            diag_tool(DIAG_SEV_ERROR, "arkcc",
                                      "the arm backend does not implement the "
                                      "floating-point unary operator %s "
                                      "(function '%s')",
                                      diag_num(b1, I->aux), f->name, 0,0,0,0);
                        }
                        emit_push_r0(&buf);
                        break;
                    }
                    emit_pop_r0(&buf);
                    emit_unary(&buf, I->aux);
                    emit_push_r0(&buf);
                    break;
                case IR_LABEL:
                    emit_label(&buf, f->name, I->val);
                    break;
                case IR_LABEL_NAMED:
                    asmbuf_puts(&buf, ".L_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, ":\n");
                    break;
                case IR_JMP:
                    emit_b_label(&buf, "B", f->name, I->val);
                    break;
                case IR_JMP_NAMED:
                    asmbuf_puts(&buf, "    B .L_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JZ:
                    emit_pop_r0(&buf);
                    emit_line(&buf, "CMP r0, #0");
                    emit_b_label(&buf, "BEQ", f->name, I->val);
                    break;
                case IR_JNZ:
                    emit_pop_r0(&buf);
                    emit_line(&buf, "CMP r0, #0");
                    emit_b_label(&buf, "BNE", f->name, I->val);
                    break;
                case IR_CMP_JMP_EQ:
                    emit_pop_r0(&buf);
                    emit_mov_imm(&buf, 1, I->val);
                    emit_line(&buf, "CMP r0, r1");
                    emit_b_label(&buf, "BEQ", f->name, I->aux);
                    break;
                /* === Floating-point ops: ARM soft-float ABI ===
                 * The high bit 0x200 of aux marks double-precision (double):
                 *   - single (float): args in r0/r1, result in r0, 1 stack slot (4B), uses __aeabi_f*
                 *   - double (double): args in r0/r1+r2/r3, result in r0/r1, 2 stack slots (8B), uses __aeabi_d*
                 * lr is already saved by the prologue; BL inside the body may freely clobber lr. */
                case IR_PUSH_FLOAT: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    if (I->aux & IR_AUX_COMPLEX) {
                        /* 16-byte complex constant. val indexes the complex
                         * pool, not the float pool -- the two used to share
                         * aux 0x200, which loaded a double as a complex. */
                        asmbuf_puts(&buf, "    LDR r0, =.L_cplx_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, "    LDR r1, [r0, #8]\n");
                        asmbuf_puts(&buf, "    PUSH {r1}\n");   /* imag low  */
                        asmbuf_puts(&buf, "    LDR r1, [r0, #12]\n");
                        asmbuf_puts(&buf, "    PUSH {r1}\n");   /* imag high */
                        asmbuf_puts(&buf, "    LDR r1, [r0, #0]\n");
                        asmbuf_puts(&buf, "    PUSH {r1}\n");   /* real low  */
                        asmbuf_puts(&buf, "    LDR r1, [r0, #4]\n");
                        asmbuf_puts(&buf, "    PUSH {r1}\n");   /* real high */
                        break;
                    }
                    if (is_dbl) {
                        /* Double-precision: load 8 bytes, push 2 slots (low word pushed first) */
                        asmbuf_puts(&buf, "    LDR r0, =.L_dbl_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_putc(&buf, '\n');
                        emit_line(&buf, "LDR r1, [r0]");       /* low word */
                        emit_line(&buf, "LDR r2, [r0, #4]");   /* high word */
                        asmbuf_puts(&buf, "    PUSH {r1}\n");  /* low word pushed first */
                        asmbuf_puts(&buf, "    PUSH {r2}\n");  /* high word pushed last (on top) */
                    } else {
                        /* Single-precision: load 32-bit float bit pattern from the float constant pool into r0 */
                        asmbuf_puts(&buf, "    LDR r0, =.L_flt_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_putc(&buf, '\n');
                        emit_line(&buf, "LDR r0, [r0]");
                        emit_push_r0(&buf);
                    }
                    break;
                }
                case IR_FADD: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    if ((I->aux & 0xF00) == 0x900) {
                        /* cexp: aux = TOK_PLUS | 0x900 (complex bit plus the
                         * 0x100 sub-op selector). exp(x)*(cos y + i sin y);
                         * the three libm calls are linked in, not inlined. */
                        emit_line(&buf, "SUB sp, sp, #24");   /* operands at sp+24 */
                        arm_ldr_sp(&buf, 0, 28);              /* z.re low  */
                        arm_ldr_sp(&buf, 1, 24);              /* z.re high */
                        arm_call1(&buf, "exp");
                        arm_str_sp(&buf, 0, 0);
                        arm_str_sp(&buf, 1, 4);
                        arm_ldr_sp(&buf, 0, 36);              /* z.im low  */
                        arm_ldr_sp(&buf, 1, 32);              /* z.im high */
                        arm_call1(&buf, "cos");
                        arm_str_sp(&buf, 0, 8);
                        arm_str_sp(&buf, 1, 12);
                        arm_dcall(&buf, "__aeabi_dmul", 0, 4, 8, 12);
                        arm_str_sp(&buf, 0, 16);
                        arm_str_sp(&buf, 1, 20);
                        arm_ldr_sp(&buf, 0, 36);
                        arm_ldr_sp(&buf, 1, 32);
                        arm_call1(&buf, "sin");
                        emit_line(&buf, "MOV r2, r0");
                        emit_line(&buf, "MOV r3, r1");
                        arm_ldr_sp(&buf, 0, 0);
                        arm_ldr_sp(&buf, 1, 4);
                        arm_call1(&buf, "__aeabi_dmul");
                        emit_line(&buf, "MOV r2, r0");
                        emit_line(&buf, "MOV r3, r1");
                        arm_ldr_sp(&buf, 0, 16);
                        arm_ldr_sp(&buf, 1, 20);
                        emit_add_sp(&buf, 24);
                        emit_add_sp(&buf, 16);
                        arm_cplx_push4(&buf);
                        break;
                    }
                    if (I->aux & IR_AUX_COMPLEX) {
                        arm_cplx_addsub(&buf, "__aeabi_dadd");
                        break;
                    }
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        if (is_dbl) emit_vfp_f64_binop(&buf, "VADD");
                        else        emit_vfp_f32_binop(&buf, "VADD");
                        break;
                    }
#endif
                    if (is_dbl) {
                        emit_line(&buf, "POP {r3}");
                        emit_line(&buf, "POP {r2}");
                        emit_line(&buf, "POP {r1}");
                        emit_line(&buf, "POP {r0}");
                        emit_line(&buf, "BL __aeabi_dadd");
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    } else {
                        emit_pop_r1(&buf); emit_pop_r0(&buf);
                        emit_line(&buf, "BL __aeabi_fadd");
                        emit_push_r0(&buf);
                    }
                    break;
                }
                case IR_FSUB: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    if (I->aux & IR_AUX_COMPLEX) {
                        arm_cplx_addsub(&buf, "__aeabi_dsub");
                        break;
                    }
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        if (is_dbl) emit_vfp_f64_binop(&buf, "VSUB");
                        else        emit_vfp_f32_binop(&buf, "VSUB");
                        break;
                    }
#endif
                    if (is_dbl) {
                        emit_line(&buf, "POP {r3}");
                        emit_line(&buf, "POP {r2}");
                        emit_line(&buf, "POP {r1}");
                        emit_line(&buf, "POP {r0}");
                        emit_line(&buf, "BL __aeabi_dsub");
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    } else {
                        emit_pop_r1(&buf); emit_pop_r0(&buf);
                        emit_line(&buf, "BL __aeabi_fsub");
                        emit_push_r0(&buf);
                    }
                    break;
                }
                case IR_FMUL: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    if (I->aux & IR_AUX_COMPLEX) {
                        arm_cplx_mul(&buf);
                        break;
                    }
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        if (is_dbl) emit_vfp_f64_binop(&buf, "VMUL");
                        else        emit_vfp_f32_binop(&buf, "VMUL");
                        break;
                    }
#endif
                    if (is_dbl) {
                        emit_line(&buf, "POP {r3}");
                        emit_line(&buf, "POP {r2}");
                        emit_line(&buf, "POP {r1}");
                        emit_line(&buf, "POP {r0}");
                        emit_line(&buf, "BL __aeabi_dmul");
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    } else {
                        emit_pop_r1(&buf); emit_pop_r0(&buf);
                        emit_line(&buf, "BL __aeabi_fmul");
                        emit_push_r0(&buf);
                    }
                    break;
                }
                case IR_FDIV: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    if (I->aux & IR_AUX_COMPLEX) {
                        arm_cplx_div(&buf);
                        break;
                    }
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        if (is_dbl) emit_vfp_f64_binop(&buf, "VDIV");
                        else        emit_vfp_f32_binop(&buf, "VDIV");
                        break;
                    }
#endif
                    if (is_dbl) {
                        emit_line(&buf, "POP {r3}");
                        emit_line(&buf, "POP {r2}");
                        emit_line(&buf, "POP {r1}");
                        emit_line(&buf, "POP {r0}");
                        emit_line(&buf, "BL __aeabi_ddiv");
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    } else {
                        emit_pop_r1(&buf); emit_pop_r0(&buf);
                        emit_line(&buf, "BL __aeabi_fdiv");
                        emit_push_r0(&buf);
                    }
                    break;
                }
                case IR_F2I: {
                    if (I->aux & IR_AUX_COMPLEX) {
                        /* Extraction from a four-word complex value. aux & 0x300:
                         *   0x000 creal   0x100 cimag
                         *   0x200 cabs    0x300 carg
                         * cabs/carg need libm (sqrt / atan2); they are emitted
                         * as calls so an arm target without libm fails to link
                         * instead of quietly producing a different number. */
                        int k = I->aux & 0x300;
                        if (k == 0x200) {
                            arm_dcall(&buf, "__aeabi_dmul", 4, 0, 4, 0);
                            emit_line(&buf, "SUB sp, sp, #8");
                            arm_str_sp(&buf, 0, 0);
                            arm_str_sp(&buf, 1, 4);
                            arm_dcall(&buf, "__aeabi_dmul", 20, 16, 20, 16);
                            emit_line(&buf, "MOV r2, r0");
                            emit_line(&buf, "MOV r3, r1");
                            arm_ldr_sp(&buf, 0, 0);
                            arm_ldr_sp(&buf, 1, 4);
                            arm_call1(&buf, "__aeabi_dadd");
                            emit_add_sp(&buf, 8);
                            emit_add_sp(&buf, 16);
                            arm_call1(&buf, "sqrt");
                            arm_push_reg(&buf, 0);
                            arm_push_reg(&buf, 1);
                        } else if (k == 0x300) {
                            arm_ldr_sp(&buf, 0, 12);   /* imag low  */
                            arm_ldr_sp(&buf, 1, 8);    /* imag high */
                            arm_ldr_sp(&buf, 2, 4);    /* real low  */
                            arm_ldr_sp(&buf, 3, 0);    /* real high */
                            emit_add_sp(&buf, 16);
                            arm_call1(&buf, "atan2");
                            arm_push_reg(&buf, 0);
                            arm_push_reg(&buf, 1);
                        } else if (k == 0x100) {
                            arm_ldr_sp(&buf, 0, 12);   /* imag low  */
                            arm_ldr_sp(&buf, 1, 8);    /* imag high */
                            emit_add_sp(&buf, 16);
                            arm_push_reg(&buf, 0);
                            arm_push_reg(&buf, 1);
                        } else {
                            arm_ldr_sp(&buf, 0, 4);    /* real low  */
                            arm_ldr_sp(&buf, 1, 0);    /* real high */
                            emit_add_sp(&buf, 16);
                            arm_push_reg(&buf, 0);
                            arm_push_reg(&buf, 1);
                        }
                        break;
                    }
                    /* float/double -> int (truncation toward zero) */
                    int is_dbl = (I->aux & 0x200) != 0;
                    /* F2I unsigned fix: 0x400 = unsigned destination; select
                     * __aeabi_d2uiz/__aeabi_f2uiz for unsigned targets. */
                    int is_unsigned = (I->aux & 0x400) != 0;
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        if (is_dbl) {
                            /* double: pop d0, VCVT.S32.F64 s0,d0, move back to r0 */
                            emit_line(&buf, "POP {r1}");  /* high */
                            emit_line(&buf, "POP {r0}");  /* low */
                            emit_line(&buf, "VMOV s0, r0");
                            emit_line(&buf, "VMOV s1, r1");
                            if (is_unsigned)
                                emit_line(&buf, "VCVT.U32.F64 s0, d0");
                            else
                                emit_line(&buf, "VCVT.S32.F64 s0, d0");
                            emit_line(&buf, "VMOV r0, s0");
                        } else {
                            emit_pop_r0(&buf);
                            emit_line(&buf, "VMOV s0, r0");
                            if (is_unsigned)
                                emit_line(&buf, "VCVT.U32.F32 s0, s0");
                            else
                                emit_line(&buf, "VCVT.S32.F32 s0, s0");
                            emit_line(&buf, "VMOV r0, s0");
                        }
                        emit_push_r0(&buf);
                        break;
                    }
#endif
                    if (is_dbl) {
                        emit_line(&buf, "POP {r1}");
                        emit_line(&buf, "POP {r0}");
                        if (is_unsigned)
                            emit_line(&buf, "BL __aeabi_d2uiz");
                        else
                            emit_line(&buf, "BL __aeabi_d2iz");
                    } else {
                        emit_pop_r0(&buf);
                        if (is_unsigned)
                            emit_line(&buf, "BL __aeabi_f2uiz");
                        else
                            emit_line(&buf, "BL __aeabi_f2iz");
                    }
                    emit_push_r0(&buf);
                    break;
                }
                case IR_I2F: {
                    if (I->aux & IR_AUX_COMPLEX) {
                        /* real -> complex widening, imaginary part 0.
                         * aux & 0x700: 0x000 float, 0x200 double,
                         * 0x100 int (0x400 more if unsigned). */
                        int k = I->aux & 0x700;
                        if (k == 0x100 || k == 0x500) {
                            emit_pop_r0(&buf);
                            arm_call1(&buf, k == 0x500 ? "__aeabi_ui2d" : "__aeabi_i2d");
                        } else if (k == 0x200) {
                            emit_line(&buf, "POP {r1}");
                            emit_pop_r0(&buf);
                        } else {
                            emit_pop_r0(&buf);
                            arm_call1(&buf, "__aeabi_f2d");
                        }
                        emit_line(&buf, "MOV r2, r0");
                        emit_line(&buf, "MOV r3, r1");
                        emit_line(&buf, "MOV r0, #0");
                        arm_push_reg(&buf, 0);
                        arm_push_reg(&buf, 0);
                        arm_push_reg(&buf, 2);
                        arm_push_reg(&buf, 3);
                        break;
                    }
                    /* int -> float/double */
                    int is_dbl = (I->aux & 0x200) != 0;
                    /* Bug-P1-7: 0x400 = unsigned source; select __aeabi_ui2d /
                     * __aeabi_ui2f instead of the signed __aeabi_i2d /
                     * __aeabi_i2f so that (double)(unsigned)v yields the
                     * correct positive value. */
                    int is_unsigned = (I->aux & 0x400) != 0;
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        emit_pop_r0(&buf);
                        emit_line(&buf, "VMOV s0, r0");
                        if (is_dbl) {
                            if (is_unsigned)
                                emit_line(&buf, "VCVT.F64.U32 d0, s0");
                            else
                                emit_line(&buf, "VCVT.F64.S32 d0, s0");
                            emit_line(&buf, "VMOV r0, s0");
                            emit_line(&buf, "VMOV r1, s1");
                            emit_push_r0(&buf);
                            asmbuf_puts(&buf, "    PUSH {r1}\n");
                        } else {
                            if (is_unsigned)
                                emit_line(&buf, "VCVT.F32.U32 s0, s0");
                            else
                                emit_line(&buf, "VCVT.F32.S32 s0, s0");
                            emit_line(&buf, "VMOV r0, s0");
                            emit_push_r0(&buf);
                        }
                        break;
                    }
#endif
                    emit_pop_r0(&buf);
                    if (is_dbl) {
                        emit_line(&buf, is_unsigned ? "BL __aeabi_ui2d" : "BL __aeabi_i2d");
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    } else {
                        emit_line(&buf, is_unsigned ? "BL __aeabi_ui2f" : "BL __aeabi_i2f");
                        emit_push_r0(&buf);
                    }
                    break;
                }
                case IR_64I2F: {
                    /* long long (64-bit) -> float/double.
                     * Stack model: [r0_low, r1_high] (high on top).
                     * AAPCS helpers: __aeabi_l2d/ul2d (-> r0/r1 double),
                     *                __aeabi_l2f/ul2f (-> r0 float). */
                    int is_dbl = (I->aux & 0x200) != 0;
                    int is_unsigned = (I->aux & 0x400) != 0;
                    emit_pop_r1(&buf);  /* high */
                    emit_pop_r0(&buf);  /* low */
                    if (is_dbl) {
                        emit_line(&buf, is_unsigned ? "BL __aeabi_ul2d" : "BL __aeabi_l2d");
                        /* double result: r0=low, r1=high */
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    } else {
                        emit_line(&buf, is_unsigned ? "BL __aeabi_ul2f" : "BL __aeabi_l2f");
                        emit_push_r0(&buf);
                    }
                    break;
                }
                case IR_64F2I: {
                    /* float/double -> long long (64-bit).
                     * For double: stack has [r0_low, r1_high]; pop both.
                     * For float:  stack has [r0]; pop one.
                     * AAPCS helpers: __aeabi_d2lz/d2ulz (double -> r0/r1),
                     *                __aeabi_f2lz/f2ulz (float  -> r0/r1). */
                    int is_dbl = (I->aux & 0x200) != 0;
                    int is_unsigned = (I->aux & 0x400) != 0;
                    if (is_dbl) {
                        emit_pop_r1(&buf);  /* high */
                        emit_pop_r0(&buf);  /* low */
                        emit_line(&buf, is_unsigned ? "BL __aeabi_d2ulz" : "BL __aeabi_d2lz");
                    } else {
                        emit_pop_r0(&buf);
                        emit_line(&buf, is_unsigned ? "BL __aeabi_f2ulz" : "BL __aeabi_f2lz");
                    }
                    /* 64-bit result: r0=low, r1=high */
                    emit_push_r0(&buf);
                    asmbuf_puts(&buf, "    PUSH {r1}\n");
                    break;
                }
                case IR_F2F: {
                    /* float <-> float cast. On the ARM soft-float stack:
                     *   double = [r0_low, r1_high] (2 slots, high on top)
                     *   float  = [r0]              (1 slot)
                     *   aux 0x200 = double->float (narrow): -1 slot
                     *   aux 0x100 = float->double (widen):  +1 slot
                     * Both directions go to the run-time library: widening is
                     * exact so it could be done here, but keeping one rule is
                     * simpler than explaining why half of this IR op is
                     * self-contained and half is not. */
                    int src_dbl = (I->aux & 0x200) != 0;
                    int dst_dbl = (I->aux & 0x100) != 0;
#if ARKCC_FEATURE_FPU_HW
                    /* A single-precision FPU cannot convert to or from double
                     * (VCVT.F64.* is ARMv8-M / M7 DP only), so those two
                     * directions stay on the software helpers even when
                     * hardware FP is enabled. */
                    if (g_config.enable_fpu_hw && g_arm_fpu_dp) {
                        if (src_dbl && !dst_dbl) {
                            /* double -> float */
                            emit_pop_r1(&buf);
                            emit_pop_r0(&buf);
                            emit_line(&buf, "VMOV s0, r0");
                            emit_line(&buf, "VMOV s1, r1");
                            emit_line(&buf, "VCVT.F32.F64 s0, d0");
                            emit_line(&buf, "VMOV r0, s0");
                            emit_push_r0(&buf);
                        } else if (!src_dbl && dst_dbl) {
                            /* float -> double */
                            emit_pop_r0(&buf);
                            emit_line(&buf, "VMOV s0, r0");
                            emit_line(&buf, "VCVT.F64.F32 d0, s0");
                            emit_line(&buf, "VMOV r0, s0");
                            emit_line(&buf, "VMOV r1, s1");
                            emit_push_r0(&buf);
                            asmbuf_puts(&buf, "    PUSH {r1}\n");
                        }
                        break;
                    }
#endif
                    if (src_dbl && !dst_dbl) {
                        /* double -> float */
                        emit_pop_r1(&buf);
                        emit_pop_r0(&buf);
                        emit_line(&buf, "BL __aeabi_d2f");
                        emit_push_r0(&buf);
                    } else if (!src_dbl && dst_dbl) {
                        /* float -> double */
                        emit_pop_r0(&buf);
                        emit_line(&buf, "BL __aeabi_f2d");
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    }
                    /* same-size: no-op */
                    break;
                }
                case IR_FCMP: {
                    /* aux encodes the comparison kind (low 8 bits) + precision flag (0x200);
                     * __aeabi_fcmpeq and __aeabi_dcmpeq family return 0/1.
                     * IR_AUX_COMPLEX marks a _Complex comparison: it compares the
                     * real parts and the imaginary parts and combines the two
                     * results (EQ => both equal, NE => either differs). */
                    int is_dbl = (I->aux & 0x200) != 0;
                    int op = I->aux & ~(0x200 | IR_AUX_COMPLEX);
                    if (I->aux & IR_AUX_COMPLEX) {
                        arm_cplx_cmp(&buf, op == (int)TOK_NE);
                        break;
                    }
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        const char *cond = "EQ";
                        /* r0 must be cleared after the operands are moved
                         * into the FPU registers and before VCMP, never
                         * between VMRS and the IT block: outside an IT block
                         * `MOV r0, #imm8` assembles to the 16-bit MOVS form and
                         * would overwrite the flags that VMRS has just loaded
                         * from FPSCR.  Both halves were measured on the board:
                         * with the MOV after VMRS every EQ test came out true
                         * (double_cmp returned 100, not 1001), and with it
                         * before the POPs r0 still held the low word of the
                         * left operand, so a *false* compare returned that word
                         * (7.9 >= 2^63 answered -1717986918 = 0x9999999A, and
                         * __aeabi_d2lz read it as "too large" and saturated). */
                        if (is_dbl) {
                            emit_line(&buf, "POP {r3}");
                            emit_line(&buf, "POP {r2}");
                            emit_line(&buf, "POP {r1}");
                            emit_line(&buf, "POP {r0}");
                            emit_line(&buf, "VMOV s0, r0");
                            emit_line(&buf, "VMOV s1, r1");
                            emit_line(&buf, "VMOV s2, r2");
                            emit_line(&buf, "VMOV s3, r3");
                            emit_mov_imm(&buf, 0, 0);
                            emit_line(&buf, "VCMP.F64 d0, d1");
                        } else {
                            emit_pop_r1(&buf); emit_pop_r0(&buf);
                            emit_line(&buf, "VMOV s0, r0");
                            emit_line(&buf, "VMOV s1, r1");
                            emit_mov_imm(&buf, 0, 0);
                            emit_line(&buf, "VCMP.F32 s0, s1");
                        }
                        emit_line(&buf, "VMRS APSR_nzcv, FPSCR");
                        switch (op) {
                            case (int)TOK_EQ: cond = "EQ"; break;
                            case (int)TOK_NE: cond = "NE"; break;
                            case (int)TOK_LT: cond = "LT"; break;
                            case (int)TOK_GT: cond = "GT"; break;
                            case (int)TOK_LE: cond = "LE"; break;
                            case (int)TOK_GE: cond = "GE"; break;
                            default: cond = "EQ"; break;
                        }
                        asmbuf_puts(&buf, "    IT ");
                        asmbuf_puts(&buf, cond);
                        asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, "    MOV");
                        asmbuf_puts(&buf, cond);
                        asmbuf_puts(&buf, " r0, #1\n");
                        emit_push_r0(&buf);
                        break;
                    }
#endif
                    {
                    const char *helper = "__aeabi_fcmpeq";
                    switch (op) {
                        case (int)TOK_EQ: helper = is_dbl ? "__aeabi_dcmpeq" : "__aeabi_fcmpeq"; break;
                        case (int)TOK_NE: helper = is_dbl ? "__aeabi_dcmpeq" : "__aeabi_fcmpeq"; break;
                        case (int)TOK_LT: helper = is_dbl ? "__aeabi_dcmplt" : "__aeabi_fcmplt"; break;
                        case (int)TOK_GT: helper = is_dbl ? "__aeabi_dcmpgt" : "__aeabi_fcmpgt"; break;
                        case (int)TOK_LE: helper = is_dbl ? "__aeabi_dcmple" : "__aeabi_fcmple"; break;
                        case (int)TOK_GE: helper = is_dbl ? "__aeabi_dcmpge" : "__aeabi_fcmpge"; break;
                        default: break;
                    }
                    if (is_dbl) {
                        emit_line(&buf, "POP {r3}");
                        emit_line(&buf, "POP {r2}");
                        emit_line(&buf, "POP {r1}");
                        emit_line(&buf, "POP {r0}");
                    } else {
                        emit_pop_r1(&buf); emit_pop_r0(&buf);
                    }
                    asmbuf_puts(&buf, "    BL ");
                    asmbuf_puts(&buf, helper);
                    asmbuf_putc(&buf, '\n');
                    /* NE: use fcmpeq/dcmpeq then flip the low bit */
                    if (op == (int)TOK_NE) emit_line(&buf, "EOR r0, r0, #1");
                    emit_push_r0(&buf);
                    break;
                    }
                }
                case IR_ASM:
                    /* Inline assembly written out as-is.
                     * Extended form with '@' prefix (assembled by irgen): skip past the quote and write the template,
                     * ignoring outputs/inputs/clobbers; also replace %0/%1/... with
                     * r0/r1/... (AAPCS operand index maps to register, armcc-style substitution). */
                    if (I->name && I->name[0] == '@') {
                        const char *s = I->name + 1;
                        /* Skip whitespace to find the first '"' */
                        while (*s == ' ' || *s == '\t') s++;
                        if (*s == '"') {
                            s++;
                            asmbuf_puts(&buf, "    ");
                            /* Copy template content (handle \n / \t escapes), stop at an unescaped '"' */
                            while (*s && *s != '"') {
                                if (*s == '\\' && s[1]) {
                                    if (s[1] == 'n') { asmbuf_putc(&buf, '\n'); asmbuf_puts(&buf, "    "); }
                                    else if (s[1] == 't') asmbuf_putc(&buf, '\t');
                                    else if (s[1] == '\\') asmbuf_putc(&buf, '\\');
                                    else if (s[1] == '"') asmbuf_putc(&buf, '"');
                                    else asmbuf_putc(&buf, s[1]);
                                    s += 2;
                                } else if (*s == '%' && s[1] >= '0' && s[1] <= '3') {
                                    /* Extended inline asm operand substitution: %0 -> r0, %1 -> r1, ... */
                                    asmbuf_putc(&buf, 'r');
                                    asmbuf_putc(&buf, s[1]);
                                    s += 2;
                                } else {
                                    asmbuf_putc(&buf, *s);
                                    s++;
                                }
                            }
                            asmbuf_putc(&buf, '\n');
                        }
                    } else if (I->name) {
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, '\n');
                    }
                    break;
                case IR_CALL: {
                    /* AAPCS: first 4 args go in r0-r3, args 5+ go on the stack.
                     * The stack-based IR pushes all args onto the stack (arg0 on top); here we pop the first 4
                     * into r0-r3, leaving the remaining stack_args on the stack for the callee to read.
                     * After the call the caller cleans up the stack args (caller cleanup).
                     * P1 FIX: When stack_args is odd, a 4-byte padding is inserted before BL
                     * and removed after, ensuring 8-byte SP alignment at BL per AAPCS. */
                    int n = I->val;
                    int k;
                    /* Indirect call (obj->fnptr()): I->name starts with '?'. The function
                     * pointer was pushed LAST (it's on top of stack). Pop it into ip (r12)
                     * first, then pop real args into r0-r3, then BLX ip. */
                    int is_indirect = (I->name && I->name[0] == '?');
                    int real_args = is_indirect ? n - 1 : n;
                    /* bit 36 of val: irgen saw a struct/union call result
                     * larger than 8 bytes, so the callee takes a hidden
                     * result pointer in r0 (AAPCS sret).  Taken from the IR
                     * rather than from a name table so that a declaration-only
                     * callee, a crossing-TU callee and a call through a
                     * function pointer are all covered. */
                    int is_sret_call = (int)((I->val >> 36) & 1);
                    /* bits 34..35 of val (stamped by irgen from the call
                     * expression's type): 1 = _Complex float result in r0:r1,
                     * 2 = _Complex double result through the sret buffer.
                     * A 16-byte complex result needs a buffer the caller owns,
                     * and the caller only knows where for a function it can see
                     * the definition of; anything else is refused rather than
                     * read as if r0 were the real half. */
#if ARKCC_FEATURE_COMPLEX
                    int cplx_ret = (int)((I->val >> 34) & 3);
#else
                    /* ARKCC_FEATURE_COMPLEX=0: irgen never stamps a complex
                     * return shape, so both `cplx_ret == n` branches below are dead
                     * and fold away. */
                    const int cplx_ret = 0;
#endif /* ARKCC_FEATURE_COMPLEX */
                    int sret_buf_off = 0;
                    /* P2 tail call (--tailcall): `return g(args)` whose arguments
                     * all fit in r0-r3.  IR_CALL is followed *directly* by
                     * IR_RETURN only when nothing has to be converted in
                     * between: an int->long long widening, a truncation and a
                     * _Complex reseating all insert instructions there, so the
                     * value left in r0/r1/r0-r3 is already this function's
                     * result and can be handed back unchanged.
                     * Excluded: indirect calls (the callee address itself sits
                     * on the stack that is about to be torn down), sret and
                     * _Complex results (the buffer lives in this frame),
                     * __naked/__irq/variadic functions (their frame shape is not
                     * the one restored below).  With ARKCC_FEATURE_TAILCALL
                     * compiled out the block disappears and the emitted text is
                     * byte-identical to a build without it. */
#if ARKCC_FEATURE_TAILCALL
                    int tail_call_ok = 0;
                    int tail_call_skip = 0;   /* instructions after the call to suppress */
                    if (g_config.enable_tailcall &&
                        !is_indirect && !is_sret_call && cplx_ret == 0 &&
                        !f->is_naked && !f->is_irq && !f->is_variadic &&
                        g_va_epilogue_pad == 0) {
                        if (i + 1 < f->code_count &&
                            f->code[i + 1].op == IR_RETURN) {
                            /* `return g(...)` -- the call's value IS the result. */
                            tail_call_ok = 1;
                        } else if (((I->val >> 33) & 1) && f->ret_type &&
                                   f->ret_type->kind == TYPE_VOID &&
                                   i + 2 < f->code_count &&
                                   f->code[i + 1].op == IR_PUSH_INT &&
                                   f->code[i + 1].val == 0 &&
                                   f->code[i + 2].op == IR_RETURN) {
                            /* `void f(void) { g(); }` -- irgen ends every body
                             * with PUSH_INT 0 / RETURN, and a void callee
                             * pushes nothing, so the shape is call, dummy word,
                             * return.  bit 33 of val is irgen's own "the call
                             * expression is void" stamp, taken from the
                             * prototype, so a declaration-only callee is
                             * covered too. */
                            tail_call_ok = 1;
                            tail_call_skip = 2;
                        }
                    }
#else
                    /* Trimmed build: the condition is a compile-time constant so
                     * the branch below folds away and nothing new is emitted. */
                    const int tail_call_ok = 0;
                    const int tail_call_skip = 0;
#endif

                    /* armcc intrinsic functions: emit inline instruction instead of BL.
                     * Arguments (if any) are already on the stack; pop and discard them. */
                    if (!is_indirect && (ark_streq(I->name, "__nop") ||
                        ark_streq(I->name, "__isb") ||
                        ark_streq(I->name, "__dsb") ||
                        ark_streq(I->name, "__dmb") ||
                        ark_streq(I->name, "__memory_changed") ||
                        ark_streq(I->name, "__schedule_barrier") ||
                        ark_streq(I->name, "__force_stores") ||
                        ark_streq(I->name, "__disable_irq") ||
                        ark_streq(I->name, "__enable_irq") ||
                        ark_streq(I->name, "__wfi") ||
                        ark_streq(I->name, "__wfe") ||
                        ark_streq(I->name, "__sev") ||
                        ark_streq(I->name, "__clz") ||
                        ark_streq(I->name, "__rbit") ||
                        ark_streq(I->name, "__arkcc_crit_save") ||
                        ark_streq(I->name, "__arkcc_crit_restore"))) {
                        int reg_args = (real_args > 4) ? 4 : real_args;
                        int stack_args = (real_args > 4) ? (real_args - 4) : 0;
                        for (k = 0; k < reg_args; k++) {
                            asmbuf_puts(&buf, "    POP {r");
                            asmbuf_int(&buf, k);
                            asmbuf_puts(&buf, "}\n");
                        }
                        if (stack_args > 0) {
                            asmbuf_puts(&buf, "    ADD sp, sp, #");
                            asmbuf_int(&buf, stack_args * 4);
                            asmbuf_putc(&buf, '\n');
                        }
                        if (ark_streq(I->name, "__nop"))         asmbuf_puts(&buf, "    NOP\n");
                        else if (ark_streq(I->name, "__isb"))    asmbuf_puts(&buf, "    ISB SY\n");
                        else if (ark_streq(I->name, "__dsb"))    asmbuf_puts(&buf, "    DSB SY\n");
                        else if (ark_streq(I->name, "__dmb"))    asmbuf_puts(&buf, "    DMB SY\n");
                        else if (ark_streq(I->name, "__memory_changed")) ; /* compiler barrier: no-op */
                        else if (ark_streq(I->name, "__schedule_barrier")) ; /* CMSIS barrier fence: no instruction */
                        /* armcc __force_stores: flush the compiler's pending
                         * stores. Our codegen always emits the store where the
                         * statement is, so there is nothing to flush and no
                         * instruction is required (it is not a hardware
                         * barrier; that is __dsb). */
                        else if (ark_streq(I->name, "__force_stores")) ;
                        else if (ark_streq(I->name, "__disable_irq")) asmbuf_puts(&buf, "    CPSID i\n");
                        else if (ark_streq(I->name, "__enable_irq"))  asmbuf_puts(&buf, "    CPSIE i\n");
                        else if (ark_streq(I->name, "__wfi"))    asmbuf_puts(&buf, "    WFI\n");
                        else if (ark_streq(I->name, "__wfe"))   asmbuf_puts(&buf, "    WFE\n");
                        else if (ark_streq(I->name, "__sev"))   asmbuf_puts(&buf, "    SEV\n");
                        else if (ark_streq(I->name, "__clz"))   asmbuf_puts(&buf, "    CLZ r0, r0\n");
                        /* armcc __rbit: CMSIS __RBIT maps onto it in the
                         * __CC_ARM branch, so vendor code (HAL_CRYP) calls it
                         * with one argument; the result is uint32_t. */
                        else if (ark_streq(I->name, "__rbit"))  asmbuf_puts(&buf, "    RBIT r0, r0\n");
                        /* C11 <stdatomic.h> critical section.  The target is a
                         * single core, so interrupt masking is a real mutual
                         * exclusion; reading PRIMASK first is what makes the
                         * pair nestable -- returning to a hardcoded "enabled"
                         * would unmask interrupts inside an outer critical
                         * section.  Both are emitted as instructions here, not
                         * as a runtime helper, so nothing has to be linked and
                         * no call clobbers r1-r3 (the caller's live values). */
                        else if (ark_streq(I->name, "__arkcc_crit_save")) {
                            asmbuf_puts(&buf, "    MRS r0, PRIMASK\n");
                            asmbuf_puts(&buf, "    CPSID i\n");
                        }
                        else if (ark_streq(I->name, "__arkcc_crit_restore")) {
                            asmbuf_puts(&buf, "    MSR PRIMASK, r0\n");
                        }
                        emit_push_r0(&buf);
                        break;
                    }

                    /* sret call: callee returns struct > 8 bytes via hidden pointer in r0.
                     * P1 FIX: sret buffer is pre-allocated in the caller's frame (via r6),
                     * NOT on the stack. This ensures:
                     *   1. Callee reads stack args at SP+0 (not sret space).
                     *   2. sret buffer survives the callee's PUSH (above SP, in the frame).
                     *   3. The sret pointer pushed after BL remains valid (buffer not freed).
                     * AAPCS: r0 = sret pointer, real args start at r1.
                     * 64-bit args align to even register pairs (r2/r3 only option). */
                    if (is_sret_call) {
                        /* An sret call goes through the *same* argument path as
                         * a regular call; only two things differ, and both are
                         * applied below at their own point in that path:
                         *   - r0 carries the result buffer, so argument
                         *     placement starts at r1 (the same ncrn_start the
                         *     callee's aapcs_assign uses);
                         *   - a 16-byte _Complex result is read back out of the
                         *     buffer instead of the address being pushed.
                         * It used to have a private pop loop that ignored
                         * aapcs_soff and left stack arguments in IR order, so a
                         * 64-bit argument that missed the registers arrived with
                         * its halves swapped (`return rr + ii * I;` with two
                         * doubles read the imaginary part as 0). */
                        sret_buf_off = (sret_call_idx < sret_call_n)
                                       ? sret_call_buf_off[sret_call_idx++] : 0;
                    }

                    /* Regular (non-sret) call.
                     * AAPCS: first 4 args in r0-r3, 64-bit args aligned to even
                     * register pairs (r0/r1 or r2/r3). Remaining args on stack.
                     * argmask bit(2*k+1)=1 marks 8-byte args (long long / double). */
                    {
                    int argmask = I->aux;
                    int aapcs_reg = 0;
                    int total_slots = 0;
                    int reg_slots = 0;
                    int stack_args;
                    int need_align;
                    int kk;

                    /* Indirect call: pop function pointer into ip (r12) first */
                    if (is_indirect) {
                        asmbuf_puts(&buf, "    POP {ip}\n");
                        asmbuf_puts(&buf, "    ORR ip, ip, #1\n");
                    }
                    /* Argument placement: one rule, shared with the callee
                     * (aapcs_assign).  The IR pushes arguments in reverse order
                     * (arg0 ends up on top) and pushes the two words of a
                     * 64-bit value high word first, so the stack arguments have
                     * to be *permuted* into the AAPCS block, not just padded:
                     * the block is laid out in argument order, each double-word
                     * argument low word first and 8-byte aligned.
                     *
                     * Before this the caller copied the pushed words straight
                     * through, so a 64-bit argument that missed the registers
                     * arrived with its halves swapped (`f(1LL, 2LL, 3LL)` summed
                     * garbage) and an argument that landed at an odd word offset
                     * was misaligned with respect to AAPCS. */
                    {
                        /* static for the same reason as aapcs_map above: 1.8 KiB
                         * of stack per call site would be a real cost on the
                         * board.  The tables are fully rewritten for every call
                         * (aapcs_assign fills the slots it uses and the loops
                         * below only read those). */
                        static int asz[64];
                        static int aal[64];   /* wire alignment, stage C.3 */
                        static int asplit[64]; /* a 2-word arg with one word in r3 */
                        static int aslot_reg[192];
                        static int aslot_soff[192];
                        static int areg[64];
                        static int abase[64];
                        static int awords[64];
                        int sl = 0;
                        int nsaa;
                        int i;
                        /* Per-argument wire size: from irgen's side table when
                         * the call has an argument the 2-bit argmask cannot
                         * describe (a >8-byte composite through `...`), from
                         * the argmask otherwise -- in which case the numbers,
                         * and therefore the code, are exactly what they were. */
                        const int *wires = (I->aux2 > 0)
                                           ? &prog->argbytes[I->aux2 - 1] : 0;
                        for (i = 0; i < 192; i++) { aslot_reg[i] = -1; aslot_soff[i] = -1; }
                        for (kk = 0; kk < real_args && kk < 64; kk++) {
                            int b = wires ? (wires[kk] & 0xFFFF)
                                          : (((argmask >> (2 * kk + 1)) & 1) ? 8 : 4);
                            int w;
                            if (b < 4) b = 4;
                            w = (b + 3) / 4;
                            asz[kk] = b;
                            asplit[kk] = 0;
                            /* bit 16 of a wires[] entry says "this argument
                             * needs 8-byte alignment" (see irgen).  Without a
                             * table the old rule is reproduced exactly: an
                             * 8-byte wire was the only even-padded shape. */
                            aal[kk] = (wires ? (((wires[kk] >> 16) & 1) != 0)
                                             : (b >= 8)) ? 8 : 4;
                            abase[kk] = sl;
                            awords[kk] = w;
                            sl += w;
                            total_slots += w;
                        }
                        if (sl > 192) {
                            char b1[12];
                            diag_tool(DIAG_SEV_ERROR, "arkcc",
                                      "call to '%s' passes %s argument words; "
                                      "the arm backend handles at most 192",
                                      I->name, diag_num(b1, sl), 0,0,0,0);
                        }
                        nsaa = aapcs_assign(asz, aal,
                                            (real_args < 64) ? real_args : 64,
                                            is_sret_call ? 1 : 0,
                                            aslot_reg, aslot_soff);
                        /* Pop the register arguments.  They are always the
                         * leading ones: once an argument is placed on the stack
                         * NCRN is 4, so every later argument is stacked too.
                         * A word argument (and any inline composite) has word 0
                         * on top, so the pops run in ascending word order; the
                         * two-word argument keeps its older convention, high
                         * word on top (irgen pushes it low word first). */
                        for (kk = 0; kk < real_args && kk < 64; kk++) {
                            int base = abase[kk], w = awords[kk], j;
                            if (w == 2) {
                                if (aslot_reg[base] < 0) break;
                                if (aslot_reg[base + 1] < 0) {
                                    /* Split: only the first word found a core
                                     * register, which happens when an align-4
                                     * two-word value arrives with exactly r3
                                     * left.  The image carries word 1 on top
                                     * and word 0 under it, so lift word 1 out
                                     * through r7, pop word 0 into its register
                                     * and put word 1 back: the image ends up
                                     * holding exactly the one word this
                                     * argument still needs on the stack, in
                                     * the same relative place. */
                                    asplit[kk] = 1;
                                    asmbuf_puts(&buf, "    POP {r7}\n");
                                    asmbuf_puts(&buf, "    POP {r");
                                    asmbuf_int(&buf, aslot_reg[base]);  /* low word */
                                    asmbuf_puts(&buf, "}\n");
                                    asmbuf_puts(&buf, "    PUSH {r7}\n");
                                    reg_slots += 1;
                                    break;
                                }
                                asmbuf_puts(&buf, "    POP {r");
                                asmbuf_int(&buf, aslot_reg[base] + 1);  /* high word */
                                asmbuf_puts(&buf, "}\n");
                                asmbuf_puts(&buf, "    POP {r");
                                asmbuf_int(&buf, aslot_reg[base]);      /* low word */
                                asmbuf_puts(&buf, "}\n");
                                reg_slots += 2;
                            } else {
                                int stacked = 0;
                                for (j = 0; j < w; j++) {
                                    if (aslot_reg[base + j] < 0) { stacked = 1; break; }
                                    asmbuf_puts(&buf, "    POP {r");
                                    asmbuf_int(&buf, aslot_reg[base + j]);
                                    asmbuf_puts(&buf, "}\n");
                                    reg_slots += 1;
                                }
                                if (stacked) break;
                            }
                        }
                        stack_args = total_slots - reg_slots;
                        if (stack_args < 0) stack_args = 0;
                        /* P2 tail call: every argument is in r0-r3 (the
                         * stack_args path below was not taken), so this frame
                         * has nothing left to contribute.  Restore the
                         * caller's sp exactly as the epilogue would, keep the
                         * return address in lr (a plain B does not overwrite
                         * it), and branch.  The callee's own POP {.., pc}
                         * returns straight to our caller, so two frames become
                         * one -- measured: `PUSH {r5,r6,r7,lr} / SUB sp / ... /
                         * BL / POP {pc}` collapses to `B g`.
                         * The IR_RETURN that follows must emit nothing; the
                         * branch above *is* the return. */
                        if (tail_call_ok && stack_args == 0) {
                            emit_line(&buf, "MOV sp, r6");
                            if (local_size > 0) emit_sp_adjust(&buf, local_size, 0);
                            emit_line(&buf, "POP {r5, r6, r7, lr}");
                            asmbuf_puts(&buf, "    B ");
                            asmbuf_puts(&buf, I->name);
                            asmbuf_putc(&buf, '\n');
                            tail_return_pending = tail_call_skip + 1;
                            break;
                        }
                        if (stack_args > 0) {
                            /* Build the block strictly below the pushed words
                             * and point sp at it.  r5 keeps the old sp and is
                             * also the copy source; r4 is the new sp; r7 is the
                             * data scratch.  r0-r3 already hold register
                             * arguments and r6 is the frame pointer, so none of
                             * those may be touched here. */
                            int si = 0;
                            /* r4 is the new sp of the block below and r4
                             * is callee-saved, so it has to be preserved
                             * across the call.  It used to be used raw: the
                             * callee clobbered the caller's r4 and nothing at
                             * the call site could see it (measured:
                             * __ark_ldiv64 read a dead r4 for its remainder and
                             * returned 0x2001febd where 100 % 3 == 1).  Saving
                             * it inside the call sequence instead of in the
                             * prologue means a function pays the 8 bytes only
                             * if it really passes more than 16 bytes. */
                            asmbuf_puts(&buf, "    PUSH {r4}\n");
                            asmbuf_puts(&buf, "    MOV r5, sp\n");
                            /* r5 must still point at the word image that
                             * the pops left behind; the saved r4 is the
                             * word just below it. */
                            asmbuf_puts(&buf, "    ADD r5, r5, #4\n");
                            asmbuf_puts(&buf, "    SUB r4, sp, #");
                            asmbuf_int(&buf, (nsaa > 0) ? nsaa : 4);
                            asmbuf_puts(&buf, "\n");
                            /* Round the new sp down to an 8-byte boundary.  The
                             * IR stack depth at the call is not tracked, so the
                             * AAPCS alignment is enforced instead of assumed;
                             * the extra word (if any) lands at the top of the
                             * block where nothing reads it. */
                            asmbuf_puts(&buf, "    MOV r7, #7\n");
                            asmbuf_puts(&buf, "    MVN r7, r7\n");
                            asmbuf_puts(&buf, "    AND r4, r7\n");
                            asmbuf_puts(&buf, "    MOV sp, r4\n");
                            for (kk = 0; kk < real_args && kk < 64; kk++) {
                                int base = abase[kk], w = awords[kk], j;
                                if (w == 2) {
                                    int s_off, d_off;
                                    if (asplit[kk]) {
                                        /* Only word 1 is left on the image
                                         * for this argument (see the pop loop). */
                                        s_off = 4 * si;
                                        d_off = aslot_soff[base + 1];
                                        asmbuf_puts(&buf, "    LDR r7, [r5, #");
                                        asmbuf_int(&buf, s_off);
                                        asmbuf_puts(&buf, "]\n");
                                        asmbuf_puts(&buf, "    STR r7, [r4, #");
                                        asmbuf_int(&buf, d_off);
                                        asmbuf_puts(&buf, "]\n");
                                        si += 1;
                                        continue;
                                    }
                                    if (aslot_reg[base] >= 0) continue;
                                    s_off = 4 * si;
                                    d_off = aslot_soff[base];
                                    asmbuf_puts(&buf, "    LDR r7, [r5, #");
                                    asmbuf_int(&buf, s_off + 4);  /* low word (pushed second) */
                                    asmbuf_puts(&buf, "]\n");
                                    asmbuf_puts(&buf, "    STR r7, [r4, #");
                                    asmbuf_int(&buf, d_off);
                                    asmbuf_puts(&buf, "]\n");
                                    asmbuf_puts(&buf, "    LDR r7, [r5, #");
                                    asmbuf_int(&buf, s_off);      /* high word */
                                    asmbuf_puts(&buf, "]\n");
                                    asmbuf_puts(&buf, "    STR r7, [r4, #");
                                    asmbuf_int(&buf, d_off + 4);
                                    asmbuf_puts(&buf, "]\n");
                                    si += 2;
                                } else {
                                    /* Word arguments and inline composites: the
                                     * words still on the image are, in
                                     * ascending address order, exactly the ones
                                     * that did not fit in a register (popping
                                     * the rest moved r5 up). */
                                    for (j = 0; j < w; j++) {
                                        int d_off = aslot_soff[base + j];
                                        if (aslot_reg[base + j] >= 0) continue;
                                        asmbuf_puts(&buf, "    LDR r7, [r5, #");
                                        asmbuf_int(&buf, 4 * si);
                                        asmbuf_puts(&buf, "]\n");
                                        asmbuf_puts(&buf, "    STR r7, [r4, #");
                                        asmbuf_int(&buf, d_off);
                                        asmbuf_puts(&buf, "]\n");
                                        si += 1;
                                    }
                                }
                            }
                        }
                    }
                    if (is_sret_call) {
                        /* r0 is free: the argument pops above only touched
                         * r1..r3 (ncrn_start == 1) and the stack block is
                         * addressed through r6. */
                        asmbuf_puts(&buf, "    ADD r0, r6, #");
                        asmbuf_int(&buf, sret_buf_off);
                        asmbuf_putc(&buf, '\n');
                    }
                    if (is_indirect) {
                        asmbuf_puts(&buf, "    BLX ip\n");
                    } else {
                        asmbuf_puts(&buf, "    BL ");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, '\n');
                    }
                    if (stack_args > 0) {
                        /* r5 holds the sp from before the argument block, and
                         * the saved r4 is the single word just below it, so
                         * the restore steps over that word first.  The words
                         * that stayed on
                         * the stack are still there, above sp, so they have to
                         * be dropped as well -- forgetting that left `extra`
                         * under the result and the next IR_STORE_IDX read it as
                         * a destination address (measured: a store to 0x63). */
                        int drop = stack_args * 4;
                        asmbuf_puts(&buf, "    MOV sp, r5\n");
                        asmbuf_puts(&buf, "    SUB sp, sp, #4\n");
                        asmbuf_puts(&buf, "    POP {r4}\n");
                        if (drop <= 252) {
                            asmbuf_puts(&buf, "    ADD sp, sp, #");
                            asmbuf_int(&buf, drop);
                            asmbuf_puts(&buf, "\n");
                        } else {
                            emit_mov_imm(&buf, 7, drop);
                            asmbuf_puts(&buf, "    ADD sp, sp, r7\n");
                        }
                    }
                    /* #9 FIX: Check if called function returns 64-bit (long long/double).
                     * If so, push both r0 (low) and r1 (high).
                     * For indirect calls, the return type is not in prog->funcs,
                     * so irgen encodes the 64-bit return flag in bit 32 of val.
                     * ROUND4-P2 FIX: For direct calls to void functions, skip
                     * the push entirely (the caller's AST_EXPR_STMT no longer
                     * emits IR_POP, so the stack stays balanced). Indirect
                     * calls conservatively push. */
                    {
                        int ret64 = 0;
                        int is_void_ret = 0;
                        if (is_sret_call) {
                            /* the shape is decided by cplx_ret below */
                        } else if (cplx_ret == 1) {
                            /* _Complex float result: r0 = real half, r1 =
                             * imaginary half, each an f32 in the low word --
                             * the same wire shape the parameter side uses for
                             * an 8-byte complex object.  The IR stack carries
                             * four words (re_hi, re_lo, im_hi, im_lo from the
                             * top), so each half is widened to a double and the
                             * two 8-byte results are written into one 16-byte
                             * scratch block inside the frame the pushes create.
                             * Parking a half above the pushes cannot work: ADDs
                             * to sp can only walk past the *lowest* words, so
                             * the parked word stayed in the value and the real
                             * half came out as 0 (measured, cplx_ret_f). */
                            asmbuf_puts(&buf, "    SUB sp, sp, #16\n"
                                              "    STR r0, [sp, #0]\n"    /* re32 */
                                              "    STR r1, [sp, #8]\n");  /* im32 */
                            asmbuf_puts(&buf, "    LDR r0, [sp, #0]\n");
                            emit_line(&buf, "BL __aeabi_f2d");   /* r0=re_lo */
                            asmbuf_puts(&buf, "    STR r1, [sp, #0]\n"
                                              "    STR r0, [sp, #4]\n");
                            asmbuf_puts(&buf, "    LDR r0, [sp, #8]\n");
                            emit_line(&buf, "BL __aeabi_f2d");   /* r0=im_lo */
                            asmbuf_puts(&buf, "    STR r1, [sp, #8]\n"
                                              "    STR r0, [sp, #12]\n");
                        } else if (!is_indirect) {
                            int fi2;
                            int found = 0;
                            for (fi2 = 0; fi2 < prog->func_count; fi2++) {
                                if (ark_streq(prog->funcs[fi2]->name, I->name)) {
                                    Type *rt = prog->funcs[fi2]->ret_type;
                                    found = 1;
                                    if (ret_is_two_words(rt)) {
                                        ret64 = 1;
                                    } else if (rt && rt->kind == TYPE_VOID) {
                                        is_void_ret = 1;
                                    }
                                    break;
                                }
                            }
                            /* Not defined in this translation unit: the return
                             * shape is whatever irgen saw in the prototype.  Use
                             * it instead of assuming one word -- that assumption
                             * unbalanced the stack for every void callee and
                             * dropped the high word of every long long callee. */
                            if (!found) {
                                ret64 = (int)((I->val >> 32) & 1);
                                is_void_ret = (int)((I->val >> 33) & 1);
                            }
                        } else {
                            ret64 = (int)((I->val >> 32) & 1);
                        }
                        if (cplx_ret == 2) {
                            /* _Complex double: a 16-byte composite comes back in
                             * r0-r3 (soft-float AAPCS), r0:r1 = real part,
                             * r2:r3 = imaginary part, low word first.  The IR
                             * stack wants the real high word on top, so push
                             * im_lo, im_hi, re_lo, re_hi.  No buffer is
                             * involved, so a declaration, an indirect call and
                             * a call into another translation unit all behave
                             * the same way. */
                            arm_push_reg(&buf, 2);
                            arm_push_reg(&buf, 3);
                            arm_push_reg(&buf, 0);
                            arm_push_reg(&buf, 1);
                        } else if (is_sret_call) {
                            emit_push_r0(&buf);   /* struct: the address */
                        } else if (cplx_ret == 1) {
                            /* the four words went on above */
                        } else if (ret64) {
                            emit_push_r0(&buf);              /* push low word */
                            asmbuf_puts(&buf, "    PUSH {r1}\n");  /* push high word */
                        } else if (!is_void_ret) {
                            emit_push_r0(&buf);              /* push r0 only if non-void */
                        }
                    }
                    }
                    break;
                }
                case IR_SVC: {
                    /* __svc(n) - args are on top of stack, pop to r0 then execute SVC */
                    int n = I->val;
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, "    SVC #");
                    asmbuf_int(&buf, n);
                    asmbuf_putc(&buf, '\n');
                    emit_push_r0(&buf);
                    break;
                }
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                case IR_SMC: {
                    /* __smc(n) - secure monitor call; args are on top of stack, pop to r0 then execute SMC */
                    int n = I->val;
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, "    SMC #");
                    asmbuf_int(&buf, n);
                    asmbuf_putc(&buf, '\n');
                    emit_push_r0(&buf);
                    break;
                }
#endif
                /* === Integer divide/modulo ===
                 * Top of stack is the divisor (r1), next is the dividend (r0); result pushed back to r0.
                 * Cortex-M4 (ARMv7E-M) has hardware SDIV/UDIV; use them instead of __aeabi_idiv
                 * so single-file .bin output works without linking libgcc. */
                case IR_DIV:
#if ARKCC_FEATURE_DIVCONST
                    if (divconst_live) {
                        divconst_live = 0;
                        divconst_emit(&buf, &divconst_st, 0);
                        break;
                    }
#endif
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, I->aux ? "    UDIV r0, r0, r1\n" : "    SDIV r0, r0, r1\n");
                    emit_push_r0(&buf);
                    break;
                case IR_MOD:
#if ARKCC_FEATURE_DIVCONST
                    if (divconst_live) {
                        divconst_live = 0;
                        divconst_emit(&buf, &divconst_st, 1);
                        break;
                    }
#endif
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, I->aux ? "    UDIV r2, r0, r1\n" : "    SDIV r2, r0, r1\n");
                    emit_line(&buf, "MUL r2, r2, r1");
                    emit_line(&buf, "SUB r0, r0, r2");
                    emit_push_r0(&buf);
                    break;
                /* === 64-bit ops: value occupies two stack slots, low word pushed first, high word pushed last (high word on top) ===
                 * Call __aeabi_l* helpers: a in r0/r1 (low/high), b in r2/r3 (low/high),
                 * result in r0/r1 (low/high). Pop order: b first (r3 high / r2 low), then a (r1 high / r0 low). */
                case IR_64PUSH:
                    /* val=high 32 bits, aux=low 32 bits; low word pushed first */
                    emit_mov_imm(&buf, 0, I->aux);
                    emit_push_r0(&buf);
                    emit_mov_imm(&buf, 0, I->val);
                    emit_push_r0(&buf);
                    break;
                case IR_64BINARY: {
                    /* #I2 FIX: Mask off unsigned flag (0x100) from op, and use
                     * correct AEABI helper names (__aeabi_ldivmod not __aeabi_ldiv). */
                    int is_unsigned = (I->aux & 0x100) != 0;
                    int op = I->aux & ~0x100;
                    const char *helper = 0;
                    int is_div = 0, is_mod = 0;
                    int is_add = 0, is_sub = 0;
                    switch (op) {
                        /* 64-bit add/sub are two instructions -- emit them
                         * inline instead of calling the AEABI helpers.
                         * __aeabi_ladd/__aeabi_lsub are *not* in gcc's
                         * libgcc.a any more (gcc >= 4.x inlines them, so the
                         * archive never defines them), which made every
                         * 64-bit add/sub image fail to link with
                         * "undefined reference to `__aeabi_ladd'". */
                        case (int)TOK_PLUS:  is_add = 1; break;
                        case (int)TOK_MINUS: is_sub = 1; break;
                        case (int)TOK_MUL:   helper = "__aeabi_lmul"; break;
                        case (int)TOK_DIV:   helper = is_unsigned ? "__aeabi_uldivmod" : "__aeabi_ldivmod"; is_div = 1; break;
                        case (int)TOK_MOD:   helper = is_unsigned ? "__aeabi_uldivmod" : "__aeabi_ldivmod"; is_mod = 1; break;
                        /* Shifts: value in r0:r1, count in r2 (0..63).  These are
                         * the standard AEABI helper names, so an image linked
                         * against a real runtime library also resolves them. */
                        case (int)TOK_SHL:   helper = "__aeabi_llsl"; break;
                        case (int)TOK_SHR:   helper = is_unsigned ? "__aeabi_llsr"
                                                                  : "__aeabi_lasr"; break;
                        default: break;
                    }
                    emit_line(&buf, "POP {r3}");
                    emit_line(&buf, "POP {r2}");
                    emit_line(&buf, "POP {r1}");
                    emit_line(&buf, "POP {r0}");
                    /* Bitwise AND/OR/XOR need no helper: both words are
                     * independent.  They used to fall through with no helper at
                     * all, i.e. the result was whatever happened to be in
                     * r0:r1 -- measured: `(-100LL & 1)` did not behave like 0,
                     * which quietly broke the standard "clear the low bit"
                     * idiom used by the reference code in the shift tests. */
                    if (op == (int)TOK_BAND) { emit_line(&buf, "AND r0, r2"); emit_line(&buf, "AND r1, r3"); }
                    else if (op == (int)TOK_BOR)  { emit_line(&buf, "ORR r0, r2"); emit_line(&buf, "ORR r1, r3"); }
                    else if (op == (int)TOK_BXOR) { emit_line(&buf, "EOR r0, r2"); emit_line(&buf, "EOR r1, r3"); }
                    /* ADDS/ADC and SUBS/SBC are emitted in their 16-bit
                     * two/three-operand forms on purpose: a Thumb-2 wide
                     * `ADD.W r0, r0, #imm` does not update APSR under
                     * unicorn 2.1.4, which would silently corrupt the carry
                     * into ADC (measured: -7LL + -1LL came out as -8LL).  The S is
                     * mandatory here: without it GNU as picks the 32-bit
                     * ADD.W/SUB.W (verified with objdump: `add r0, r0, r2` ->
                     * eb00 0002, `adds ...` -> 1880), which leaves the flags
                     * alone and breaks the carry chain.  The built-in assembler
                     * therefore accepts ADDS/SUBS without --asm-extra. */
                    if (is_add) {
                        emit_line(&buf, "ADDS r0, r0, r2");
                        emit_line(&buf, "ADC r1, r1, r3");
                    } else if (is_sub) {
                        emit_line(&buf, "SUBS r0, r0, r2");
                        emit_line(&buf, "SBC r1, r1, r3");
                    }
                    if (helper) {
                        asmbuf_puts(&buf, "    BL ");
                        asmbuf_puts(&buf, helper);
                        asmbuf_putc(&buf, '\n');
                    }
                    if (is_mod) {
                        /* __aeabi_ldivmod/uldivmod: quotient in r0/r1, remainder in r2/r3;
                         * take remainder to r0/r1 for MOD result. */
                        emit_line(&buf, "MOV r0, r2");
                        emit_line(&buf, "MOV r1, r3");
                    }
                    /* For DIV, quotient is already in r0/r1. */
                    emit_push_r0(&buf);                 /* result low 32 bits */
                    asmbuf_puts(&buf, "    PUSH {r1}\n"); /* result high 32 bits */
                    break;
                }
                case IR_64CMP: {
                    /* #I3 FIX: Check unsigned flag (0x100) to select __aeabi_ulcmp
                     * for unsigned comparison instead of always using __aeabi_lcmp. */
                    int is_unsigned = (I->aux & 0x100) != 0;
                    int op = I->aux & ~0x100;
                    const char *cmp_helper = is_unsigned ? "__aeabi_ulcmp" : "__aeabi_lcmp";
                    /* __aeabi_lcmp/ulcmp returns -1/0/1 (a<b / a==b / a>b) in r0;
                     * use conditional MOV to produce a 0/1 comparison result. */
                    emit_line(&buf, "POP {r3}");
                    emit_line(&buf, "POP {r2}");
                    emit_line(&buf, "POP {r1}");
                    emit_line(&buf, "POP {r0}");
                    asmbuf_puts(&buf, "    BL ");
                    asmbuf_puts(&buf, cmp_helper);
                    asmbuf_putc(&buf, '\n');
                    emit_line(&buf, "CMP r0, #0");
                    switch (op) {
                        case (int)TOK_EQ: emit_line(&buf, "ITE EQ"); emit_line(&buf, "MOVEQ r0, #1"); emit_line(&buf, "MOVNE r0, #0"); break;
                        case (int)TOK_NE: emit_line(&buf, "ITE NE"); emit_line(&buf, "MOVNE r0, #1"); emit_line(&buf, "MOVEQ r0, #0"); break;
                        case (int)TOK_LT: emit_line(&buf, "ITE LT"); emit_line(&buf, "MOVLT r0, #1"); emit_line(&buf, "MOVGE r0, #0"); break;
                        case (int)TOK_GT: emit_line(&buf, "ITE GT"); emit_line(&buf, "MOVGT r0, #1"); emit_line(&buf, "MOVLE r0, #0"); break;
                        case (int)TOK_LE: emit_line(&buf, "ITE LE"); emit_line(&buf, "MOVLE r0, #1"); emit_line(&buf, "MOVGT r0, #0"); break;
                        case (int)TOK_GE: emit_line(&buf, "ITE GE"); emit_line(&buf, "MOVGE r0, #1"); emit_line(&buf, "MOVLT r0, #0"); break;
                        default: break;
                    }
                    emit_push_r0(&buf);
                    break;
                }
                /* === Memory copy: top of stack is destination address, next is source; BL memcpy === */
                case IR_MEMCPY:
                    emit_pop_r0(&buf);                 /* dst */
                    emit_pop_r1(&buf);                 /* src */
                    emit_mov_imm(&buf, 2, I->val);     /* n bytes */
                    emit_line(&buf, "BL __aeabi_memcpy");
                    break;
                /* === Bitfield store/load ===
                 * val=bit offset, aux=bit width. mask = (1<<bw)-1. */
                case IR_STORE_FLD: {
                    int bit_off = I->val;
                    /* aux bit 0x10000 (IR_AUX_VOLATILE) marks the access, not
                     * the width, so it has to be masked out before bw is used
                     * as a shift count. */
                    int bw = I->aux & ~IR_AUX_VOLATILE;
                    unsigned mask = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    emit_pop_r0(&buf);                 /* value */
                    emit_pop_r1(&buf);                 /* addr */
                    emit_mov_imm(&buf, 2, (int)mask);  /* r2 = mask */
                    emit_line(&buf, "AND r0, r2");      /* truncate value to bw bits */
                    if (bit_off > 0) {
                        asmbuf_puts(&buf, "    LSL r0, r0, #");
                        asmbuf_int(&buf, bit_off);
                        asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, "    LSL r2, r2, #");
                        asmbuf_int(&buf, bit_off);
                        asmbuf_putc(&buf, '\n');
                    }
                    emit_line(&buf, "LDR r3, [r1]");
                    emit_line(&buf, "BIC r3, r2");      /* clear old bits */
                    emit_line(&buf, "ORR r3, r0");      /* set new bits */
                    emit_line(&buf, "STR r3, [r1]");
                    break;
                }
                case IR_LOAD_FLD: {
                    int bit_off = I->val;
                    int bw = I->aux & 0xFF;         /* #I6 FIX: mask off 0x100 signed flag */
                    int is_signed = (I->aux & 0x100) != 0;
                    unsigned mask = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    emit_pop_r0(&buf);                 /* addr */
                    emit_line(&buf, "LDR r0, [r0]");
                    if (bit_off > 0) {
                        asmbuf_puts(&buf, "    LSR r0, r0, #");
                        asmbuf_int(&buf, bit_off);
                        asmbuf_putc(&buf, '\n');
                    }
                    if (is_signed && bw < 32) {
                        /* #I6 FIX: Sign-extend signed bitfield using LSL+ASR.
                         * A 3-bit signed field with value 0x7 should become
                         * 0xFFFFFFFF (-1), not 0x00000007 (7). */
                        int shift = 32 - bw;
                        asmbuf_puts(&buf, "    LSL r0, r0, #");
                        asmbuf_int(&buf, shift);
                        asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, "    ASR r0, r0, #");
                        asmbuf_int(&buf, shift);
                        asmbuf_putc(&buf, '\n');
                    } else {
                        emit_mov_imm(&buf, 2, (int)mask);
                        emit_line(&buf, "AND r0, r2");      /* truncate to bw bits */
                    }
                    emit_push_r0(&buf);
                    break;
                }
                case IR_RETURN:
                    if (f->ret_type && ARK_IS_CX(f->ret_type) &&
                        !is_sret && type_size(f->ret_type) == 8) {
                        /* _Complex float: narrow the four-word value into the
                         * r0:r1 pair AAPCS uses for an 8-byte composite (real
                         * half in the low word) -- exactly the conversion the
                         * caller side of IR_CALL reverses.  Both halves are
                         * d2f calls, so the order matters: the imaginary word
                         * is parked on the stack across the real conversion
                         * because BL clobbers r0-r3. */
                        if (rtop_ret) { emit_push_r0(&buf); rtop_ret = 0; }
                        asmbuf_puts(&buf, "    LDR r1, [sp, #8]\n"
                                          "    LDR r0, [sp, #12]\n");
                        emit_line(&buf, "BL __aeabi_d2f");   /* r0 = im32 */
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    LDR r1, [sp, #4]\n"
                                          "    LDR r0, [sp, #8]\n");
                        emit_line(&buf, "BL __aeabi_d2f");   /* r0 = re32 */
                        asmbuf_puts(&buf, "    POP {r1}\n");      /* r1 = im32 */
                        emit_epilogue_return(&buf, local_size, f->is_irq,
                                             f->is_naked, 1);
                        break;
                    }
                    if (f->ret_type && ARK_IS_CX(f->ret_type) &&
                        type_size(f->ret_type) > 8) {
                        /* _Complex double: a 16-byte composite goes back in
                         * r0-r3 (soft-float AAPCS, same as GCC), r0:r1 = real
                         * part and r2:r3 = imaginary part, low word first.
                         * The four words on the IR stack are
                         * re_hi, re_lo, im_hi, im_lo from the top, which is
                         * not that order, so each one is loaded explicitly.
                         * The epilogue only restores r5-r7/pc, so r0-r3
                         * survive it. */
                        if (rtop_ret) { emit_push_r0(&buf); rtop_ret = 0; }
                        asmbuf_puts(&buf, "    LDR r1, [sp, #0]\n"
                                          "    LDR r0, [sp, #4]\n"
                                          "    LDR r3, [sp, #8]\n"
                                          "    LDR r2, [sp, #12]\n");
                        emit_epilogue_return(&buf, local_size, f->is_irq,
                                             f->is_naked, 1);
                        break;
                    }
                    if (is_sret && rtop_ret) {
                        /* The sret path pops the source address itself, so the
                         * register copy has to go back on the stack first, and
                         * the epilogue must pop it like it always did. */
                        emit_push_r0(&buf);
                        rtop_ret = 0;
                    }
                    if (is_sret) {
                        /* Struct return > 8 bytes: pop source address (r1),
                         * load sret pointer from frame, copy struct word-by-word,
                         * then return r0 = sret pointer per AAPCS. */
                        int rsz = type_size(f->ret_type);
                        int words = (rsz + 3) / 4;
                        int w;
                        emit_pop_r1(&buf);  /* r1 = source struct address */
                        /* Load sret pointer into r0 */
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, sret_off);
                        asmbuf_puts(&buf, "]\n");
                        /* Copy struct word by word */
                        for (w = 0; w < words; w++) {
                            asmbuf_puts(&buf, "    LDR r2, [r1, #");
                            asmbuf_int(&buf, w * 4);
                            asmbuf_puts(&buf, "]\n");
                            asmbuf_puts(&buf, "    STR r2, [r0, #");
                            asmbuf_int(&buf, w * 4);
                            asmbuf_puts(&buf, "]\n");
                        }
                        /* Manual epilogue: skip POP {r0} (r0 already holds sret ptr) */
                        emit_line(&buf, "MOV sp, r6");
                        /* Same split as the shared epilogue: this manual one
                         * was missed when emit_sp_adjust() was introduced, and
                         * src/lexer.c (frame 4256) then failed to assemble with
                         * "ADD immediate is out of range". */
                        if (local_size > 0) emit_sp_adjust(&buf, local_size, 0);
                        if (g_va_epilogue_pad) {
                            /* Variadic: drop the pushed argument words after
                             * the saved registers (same shape as the shared
                             * epilogue, same count). */
                            emit_line(&buf, "POP {r5, r6, r7, lr}");
                            emit_add_sp(&buf, g_va_epilogue_pad);
                            emit_line(&buf, "BX lr");
                        } else if (f->is_irq) {
                            emit_line(&buf, "POP {r5, r6, r7, pc}");
                        } else {
                            emit_line(&buf, "POP {r5, r6, r7, pc}");
                        }
                    } else {
                        /* 64-bit integer return value: AAPCS delivers it in
                         * r0:r1 (low:high).  irgen pushed the halves low first,
                         * so the high half has to come back into r1 before the
                         * epilogue pops the low half into r0 -- without this the
                         * caller reads r0 = high half and r1 = stale garbage
                         * (measured: `long long f(long long a){return a;}`
                         * returned 0 for f(7) instead of 7). */
                        if (ret_is_two_words(f->ret_type) && !f->is_naked) {
                            if (rtop_ret) {          /* not modeled for 64-bit */
                                emit_push_r0(&buf);
                                rtop_ret = 0;
                            }
                            emit_pop_r1(&buf);
                        }
                        emit_epilogue_return(&buf, local_size, f->is_irq, f->is_naked,
                                             rtop_ret);
                    }
                    break;
                case IR_ALLOCA: {
                    /* Bug S6 FIX (verified): VLA dynamic stack allocation.
                     * Pop byte count, align UP to 8 bytes (ADD+BIC rounds up,
                     * not down), subtract from sp, push the start address.
                     * irgen emits exactly: PUSH(size_expr); PUSH_INT(elem_sz);
                     * BINARY(MUL); IR_ALLOCA; IR_STORE. The ALLOCA pops 1 value
                     * (byte count) and pushes 1 value (start address) - balanced.
                     * The previously-reported extra PUSH {r0} + ADD sp,#4 does
                     * not exist in the current code; the bug was already fixed. */
                    emit_pop_r0(&buf);                  /* r0 = byte count */
                    emit_line(&buf, "ADD r0, r0, #7");
                    emit_line(&buf, "BIC r0, r0, #7");  /* align up to 8 (clear low 3 bits) */
                    emit_line(&buf, "SUB sp, sp, r0");  /* allocate on stack */
                    emit_line(&buf, "MOV r0, sp");      /* r0 = start address */
                    emit_push_r0(&buf);                 /* push start address */
                    break;
                }
                /* === 0.7.0: SIMD parallel ops (Cortex-M4/M7 DSP instructions) ===
                 * Stack semantics: pop r1 (right operand), pop r0 (left operand),
                 * perform the parallel op and push r0 back. SADD16/SSUB16/SADD8/SSUB8
                 * are ARMv6TE+ DSP extension instructions that add/subtract multiple
                 * signed sub-words within a 32-bit register in parallel. */
                case IR_SIMD_ADD16:
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    emit_line(&buf, "SADD16 r0, r0, r1");
                    emit_push_r0(&buf);
                    break;
                case IR_SIMD_SUB16:
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    emit_line(&buf, "SSUB16 r0, r0, r1");
                    emit_push_r0(&buf);
                    break;
                case IR_SIMD_ADD8:
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    emit_line(&buf, "SADD8 r0, r0, r1");
                    emit_push_r0(&buf);
                    break;
                case IR_SIMD_SUB8:
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    emit_line(&buf, "SSUB8 r0, r0, r1");
                    emit_push_r0(&buf);
                    break;
                default:
                    asmbuf_puts(&buf, "    ; unknown ir op ");
                    asmbuf_int(&buf, (int)I->op);
                    asmbuf_putc(&buf, '\n');
                    break;
            }
#if ARKCC_FEATURE_OPT_VOLBAR
            if ((I->aux & IR_AUX_VOLATILE) && g_config.enable_opt_volbar &&
                arm_vol_needs_barrier(I->op))
                emit_line(&buf, "DMB SY");  /* volatile: order subsequent memory ops */
#endif
        }
#if ARKCC_FEATURE_DWARF
        if (dbg) {
            emit_line(&buf, ".cfi_endproc");
            asmbuf_puts(&buf, ".size ");
            asmbuf_puts(&buf, f->name);
            asmbuf_puts(&buf, ", .-");
            asmbuf_puts(&buf, f->name);
            asmbuf_putc(&buf, '\n');
        }
#endif
        }
        asmbuf_putc(&buf, '\n');
#if ARKCC_FEATURE_OPT_VSTACK
        /* Keep the value stack in r5/r7 instead of memory.  Runs first, so the
         * slot rewriter below sees the already shortened function. */
        if (g_config.enable_opt_vstack) ark_vstack_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_ADDR
        /* Fold the address arithmetic into the operand: one access instead of
         * ADD + access (and one copy fewer).  Runs after vstack, so it sees the
         * shortened function; regalloc below then works on fewer instructions. */
        if (g_config.enable_opt_addr) ark_addr_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_CBZ
        /* `CMP r0, #0` + `BEQ/BNE` -> `CBZ/CBNZ`: one two-byte instruction
         * instead of two.  Last of the three text passes, so it sees the
         * shape vstack/addr left behind. */
        if (g_config.enable_opt_cbz) ark_cbz_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_PEEP
        /* Copy cleanup over the text the three structural passes left behind:
         * adjacent PUSH/POP pairs and a load of the slot just written.  Runs
         * before regalloc so the slot rewriter sees the shorter text. */
        if (g_config.enable_opt_peep) ark_peep_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_COPYPROP
        /* IAR's ECT family: drop dead register copies and forward a copy into
         * its single consumer.  Runs on the text peep left behind, still
         * before regalloc so the slot rewriter sees fewer instructions. */
        if (g_config.enable_opt_copyprop) ark_copyprop_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_LIVE
        /* With the control-flow graph and liveness in hand the copies that
         * only liveness can see -- a value staged around a branch, an address
         * copied out of a scratch register -- are finally removable. */
        if (g_config.enable_opt_live || g_config.enable_opt_coalesce)
            ark_live_function(&buf, fstart, ark_ret_mask(f->ret_type));
#endif
#if ARKCC_FEATURE_OPT_REGALLOC
        /* The text of this function is complete: it is the last slice of the
         * buffer, so the rewrite sees exactly this function and nothing else. */
        ark_regalloc_function(&buf, fstart, f, local_size);
#if ARKCC_FEATURE_OPT_VREG
        /* Slot promotion names the same r8-r11 pool, but it runs *after*
         * regalloc on purpose: the constant cache lives inside regalloc and
         * the frame save is already widened by the time this pass sees it, so
         * the two share one owner of PUSH/POP and one base offset instead of
         * replacing each other.  Neither pass is a barrier for the other. */
        if (g_config.enable_opt_vreg)
            ark_vreg_function(&buf, fstart, f, local_size);
#endif
#endif
#if ARKCC_FEATURE_OPT_SLOTREG
        /* Redundant frame access removal: a load that r0 already satisfies, and
         * a store the block overwrites before anything can read it.  Runs
         * before cmat so the constant that fed a dropped store is then seen as
         * a dead write by M3 and goes away in the same build. */
        if (g_config.enable_opt_slotreg) ark_slotreg_function(&buf, fstart, f, local_size);
#endif
#if ARKCC_FEATURE_OPT_CMAT
        /* Constant materialisation cleanup, last of the text passes: it
         * works on the final register names and the addresses regalloc
         * left behind, and its folded offsets are always within 4095 so
         * the far-offset fixer below has nothing to undo. */
        if (g_config.enable_opt_cmat) ark_cmat_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_BITMASK
        /* Bitmask cleanup, right after cmat: it eats the `MOV rX,#imm` /
         * `MVN rX,rX` pair the emitter produced for `x &= ~mask`, and cmat is
         * the pass that decides whether the mask is still materialised at
         * all.  Before litpool, so a 32-bit mask that litpool would move to a
         * pool word is still visible here as an immediate. */
        if (g_config.enable_opt_bitmask) ark_bitmask_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_LITPOOL
        /* 32-bit constants leave the instruction stream: a MOVW/MOVT pair
         * becomes one pool word plus a load per use.  Last of the text
         * passes, for the same reason cmat is: it only replaces a pair with a
         * single load, so every pass above has already seen the pair in its
         * original shape. */
        if (g_config.enable_opt_litpool) ark_litpool_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_LIVE
        /* Second liveness sweep.  The first one runs before regalloc, so every
         * copy the register allocator and the three passes after it create --
         * an operand staged out of a promoted slot, a constant materialised
         * into a scratch that is then copied -- is seen by nobody.  Running
         * the same analysis again on the final text removes exactly those.
         * Gated by -fopt-live, so a build without it is byte-identical. */
        if (g_config.enable_opt_live)
            ark_live_function(&buf, fstart, ark_ret_mask(f->ret_type));
#endif
#if ARKCC_FEATURE_OPT_PEEP
        /* Second peep, for the same reason as the second liveness sweep: a
         * PUSH/POP pair only becomes removable *after* the passes below this
         * point have renamed registers.  A pair whose two halves now name the
         * same register is a copy routed through memory, and the renames that
         * make them equal happen in regalloc, vreg, slotreg and coalescing --
         * all of which run after the first peep.  Same gates, same rules, only
         * the text is final now. */
        if (g_config.enable_opt_peep)
            ark_peep_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_ADDR
        /* Second addressing fold, for the same reason as the second liveness
         * sweep and the second peep: the copies this pass eats -- a base
         * staged out of a promoted slot, a scratch the register allocator
         * named -- are created by regalloc, vreg, slotreg and cmat, all of
         * which run after the first fold.  Same rule set, same gate. */
        if (g_config.enable_opt_addr)
            ark_addr_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_CBZ
        /* Second CBZ sweep, for the same reason as the second liveness, peep
         * and addressing sweeps: the `CMP rX, #0` + `BEQ/BNE` pair this pass
         * fuses is *created* by the passes above it -- cmat drops the constant
         * that fed the compare, slotreg deletes a load so the compare's operand
         * becomes a bare register, litpool turns a MOVW/MOVT pair into a LDR
         * that shortens the region between branch and label, and the renames
         * in regalloc/vreg move the compared register into r0-r7.  The first
         * sweep runs before all of them, so it never sees those pairs.  Same
         * rule set, same gate, and the pass declines whenever the region or
         * the flags cannot be proven, so a second run can only fuse more of
         * what became provable. */
        if (g_config.enable_opt_cbz) ark_cbz_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_SPILL && ARKCC_FEATURE_OPT_LIVE
        /* Cross-block stack round trips, last of the value-flow passes: the
         * diamond the reference model emits for `c ? a : b` is one PUSH per
         * arm plus one POP at the merge, i.e. a copy through memory.  Runs
         * after every renaming pass so the two halves already name the same
         * register, and before the frame trimmers so they see the final
         * body.  Registered, off by default: the honest count is 2.9% of
         * instructions, below the 4% S10 asked for (docs/EXPR_MODEL.md). */
        if (g_config.enable_opt_spill) ark_spill_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_FRAME
        /* Frame trimming is last: every pass above has already renamed
         * registers, and the far-offset fixer below must see the final
         * frame size. */
        if (g_config.enable_opt_frame) ark_frame_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_EXIT
        /* Dead frame maintenance, right after the frame trimmer: it sees the
         * final frame save list, and the far-offset fixer below sees the final
         * text.  It only deletes `MOV sp, base` / `MOV base, sp` when the body
         * provably never moves sp, so no other pass has anything to re-derive. */
        if (g_config.enable_opt_exit) ark_exit_function(&buf, fstart);
#endif
#if ARKCC_FEATURE_OPT_LDHOIST
        /* Same-address load hoisting (S12-1) runs last among the text passes:
         * it widens the frame PUSH/POP by a dedicated callee-saved register, so
         * it must come after -fopt-frame (which would otherwise delete a pad
         * register the body never mentions) and after -fopt-exit (which reads
         * the final save list).  It sits before the far-offset fixer, but only
         * ever touches "[Rb, #imm]" loads with imm <= 4095, so the fixer has
         * nothing to rewrite in what it produces. */
        if (g_config.enable_opt_ldhoist) ark_ldhoist_function(&buf, fstart);
#endif
        /* Correctness, not an option: a frame slot beyond 4095 bytes cannot be
         * reached by "[r6, #off]" at all. */
        ark_fix_far_offset(&buf, fstart);

        /* __attribute__((constructor/destructor)): register the function address in .init_array/.fini_array;
         * the C runtime startup code iterates and calls them before/after main.
         * armcc/MDK uses .init_array (not .ctors), consistent with ARMCC5. */
        if (f->is_constructor && !f->alias_target) {
            asmbuf_puts(&buf, ".section .init_array, \"aw\"\n");
            asmbuf_puts(&buf, ".align 2\n");
            asmbuf_puts(&buf, ".word ");
            asmbuf_puts(&buf, f->name);
            asmbuf_putc(&buf, '\n');
            asmbuf_puts(&buf, ".text\n");
        }
        if (f->is_destructor && !f->alias_target) {
            asmbuf_puts(&buf, ".section .fini_array, \"aw\"\n");
            asmbuf_puts(&buf, ".align 2\n");
            asmbuf_puts(&buf, ".word ");
            asmbuf_puts(&buf, f->name);
            asmbuf_putc(&buf, '\n');
            asmbuf_puts(&buf, ".text\n");
        }
    }

    /* F3/S5: Generate __arkcc_init_globals function that initializes .data globals
     * and zeros .bss at startup. The Reset_Handler should call this before main().
     * This replaces the need for a separate .data section in Flash and a linker. */
    if (g_data_sram_start != g_data_sram_end || g_bss_sram_start != g_bss_sram_end) {
        int gi;
        asmbuf_puts(&buf, ".global __arkcc_init_globals\n");
        asmbuf_puts(&buf, ".thumb_func\n");
        asmbuf_puts(&buf, "__arkcc_init_globals:\n");
        asmbuf_puts(&buf, "    PUSH {lr}\n");

        /* Initialize .data globals with their initial values */
        for (gi = 0; gi < prog->global_count; gi++) {
            IrGlobal *g = prog->globals[gi];
            unsigned addr;
            int sz;
            if (g->is_extern || g->has_at) continue;
            if (!g->has_init) continue;
            /* Skip zero-initialized scalars (they're in .bss, already zeroed) */
            if (!g->init_aggregate && !g->init_str && !g->init_sym && !g->is_float && g->init_int == 0) continue;
            addr = gvar_find(g->name);
            if (addr == 0) continue;
            sz = g->type ? type_size(g->type) : 4;
            if (sz <= 0) sz = 4;

            if (g->is_float) {
                /* Float/double initialization: convert to bit pattern.
                 *
                 * A _Complex object holds TWO scalars: the real part at offset 0
                 * and the imaginary part right after it.  The old code looked
                 * only at `kind == TYPE_DOUBLE`, so a _Complex type fell into
                 * the float branch and stored (float)3.0 as one 32-bit word --
                 * `double _Complex g = 3.0;` then read back a denormal real
                 * part and a neighbouring object as its imaginary part.  The
                 * base type decides the width now, init_is_complex decides that
                 * a second scalar has to be written, and the imaginary part is
                 * a plain +0.0 when only a real initialiser was given. */
                union { float f; unsigned int u; } fu;
                union { double d; unsigned int u[2]; } du;
                int cplx = (g->type && ARK_IS_CX(g->type));
                Type *bt = cplx ? (g->type ? g->type->base : 0) : g->type;
                int is_double = (bt && bt->kind == TYPE_DOUBLE);
                double imv = (cplx && g->init_is_complex) ? g->init_float_im : 0.0;
                if (is_double) {
                    du.d = g->init_float;
                    emit_mov_imm(&buf, 0, (int)du.u[0]);
                    emit_mov_addr32(&buf, 1, addr, addr_in_own_data(addr));
                    asmbuf_puts(&buf, "    STR r0, [r1]\n");
                    emit_mov_imm(&buf, 0, (int)du.u[1]);
                    asmbuf_puts(&buf, "    STR r0, [r1, #4]\n");
                    if (cplx) {
                        du.d = imv;
                        emit_mov_imm(&buf, 0, (int)du.u[0]);
                        asmbuf_puts(&buf, "    STR r0, [r1, #8]\n");
                        emit_mov_imm(&buf, 0, (int)du.u[1]);
                        asmbuf_puts(&buf, "    STR r0, [r1, #12]\n");
                    }
                } else {
                    fu.f = (float)g->init_float;
                    emit_mov_imm(&buf, 0, (int)fu.u);
                    emit_mov_addr32(&buf, 1, addr, addr_in_own_data(addr));
                    asmbuf_puts(&buf, "    STR r0, [r1]\n");
                    if (cplx) {
                        fu.f = (float)imv;
                        emit_mov_imm(&buf, 0, (int)fu.u);
                        asmbuf_puts(&buf, "    STR r0, [r1, #4]\n");
                    }
                }
            } else if (g->init_sym) {
                /* Address constant (C11 6.6p9): `int (*gp)(int,int) = add;`,
                 * `int *pg = &gv;`, `int *pe = &arr[2];`.
                 *
                 * The value is not a byte pattern -- the address of a function
                 * does not exist until the linker has placed it -- so the store
                 * carries a symbol reference instead of a number.  An object of
                 * this unit takes the same path as IR_PUSH_GLOBAL_ADDR (a
                 * relocatable MOVW/MOVT pair); a function takes the literal-pool
                 * load IR_PUSH_FUNC uses, and the call site sets bit0 itself,
                 * exactly as it does there.  Before this branch existed the
                 * initialiser fell through to the aggregate path, which could
                 * not parse it, so the object kept whatever the .data area
                 * already held. */
                if (g->init_sym_is_func) {
                    if (g->init_sym_off != 0) {
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the initialiser of the global '%s' adds a byte "
                                  "offset to the address of a function, which is "
                                  "not a constant expression",
                                  g->name, 0,0,0,0,0);
                        continue;
                    }
                    asmbuf_puts(&buf, "    LDR r0, =");
                    asmbuf_puts(&buf, g->init_sym);
                    asmbuf_putc(&buf, '\n');
                    emit_mov_addr32(&buf, 1, addr, addr_in_own_data(addr));
                    asmbuf_puts(&buf, "    STR r0, [r1]\n");
                } else {
                    unsigned oaddr = gvar_find(g->init_sym);
                    unsigned taddr;
                    if (oaddr == 0) {
                        /* This backend places every unit's .data at one fixed
                         * base and emits no relocation for its own objects, so
                         * another unit's object has no address it could name.
                         * Report it rather than store a wrong one. */
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the initialiser of the global '%s' takes the "
                                  "address of '%s', which this translation unit "
                                  "does not define; the arm backend gives every "
                                  "unit's data one fixed base address, so another "
                                  "unit's object cannot be named here",
                                  g->name, g->init_sym, 0,0,0,0);
                        continue;
                    }
                    taddr = oaddr + (unsigned)g->init_sym_off;
                    emit_mov_addr32(&buf, 0, taddr, addr_in_own_data(taddr));
                    emit_mov_addr32(&buf, 1, addr, addr_in_own_data(addr));
                    asmbuf_puts(&buf, "    STR r0, [r1]\n");
                }
            } else if (g->init_aggregate) {
                /* Aggregate initialiser: turn the text into bytes with the
                 * shared type-driven filler (src/agginit.c), then store them
                 * into the object.  The old code walked the text by counting
                 * commas and skipped string elements as zero, so a char array
                 * member came out full of NULs; anything else it could not
                 * resolve it also wrote as zero without a word of warning. */
                unsigned char *bytes = (unsigned char *)mem_pool_alloc(sz);
                int bad = 0, k;
                if (!bytes) bad = 1;
                else {
                    for (k = 0; k < sz; k++) bytes[k] = 0;
                    if (ark_agg_fill_ex(g->type, g->init_aggregate, bytes, sz,
                                        arm_agg_addr_hook, (void *)g) != 0)
                        bad = 1;
                }
                if (bad) {
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "the arm backend cannot turn the initialiser of "
                              "the global '%s' into data; this backend turns "
                              "integer and floating-point constants, string "
                              "literals for char arrays, and address constants "
                              "into bytes -- this initialiser is none of those",
                              g->name, 0,0,0,0,0);
                    continue;
                }
                /* Word stores on word-aligned runs, byte stores elsewhere.
                 * Every word is written, zeros included: the .data area in
                 * SRAM is not zeroed for us (only .bss is). */
                emit_mov_addr32(&buf, 1, addr, addr_in_own_data(addr));
                for (k = 0; k < sz; ) {
                    if (((k & 3) == 0) && k + 4 <= sz) {
                        int w = (int)((unsigned)bytes[k]
                                    | ((unsigned)bytes[k + 1] << 8)
                                    | ((unsigned)bytes[k + 2] << 16)
                                    | ((unsigned)bytes[k + 3] << 24));
                        emit_mov_imm(&buf, 0, w);
                        asmbuf_puts(&buf, "    STR r0, [r1");
                        if (k != 0) {
                            asmbuf_puts(&buf, ", #");
                            asmbuf_int(&buf, k);
                        }
                        asmbuf_puts(&buf, "]\n");
                        k += 4;
                    } else {
                        emit_mov_imm(&buf, 0, (int)bytes[k]);
                        asmbuf_puts(&buf, "    STRB r0, [r1, #");
                        asmbuf_int(&buf, k);
                        asmbuf_puts(&buf, "]\n");
                        k += 1;
                    }
                }
                /* Address elements: the byte loop above wrote zeros there, so
                 * store the symbol reference over them.  A function address is
                 * a code label (`LDR r0,=name`, a relocation in object mode);
                 * this unit's object address is an absolute number; another
                 * unit's object cannot be named here (same rule as a scalar
                 * address initialiser). */
                {
                    int ri;
                    for (ri = 0; ri < g->init_ref_count; ri++) {
                        IrSymRef *r = &g->init_refs[ri];
                        if (r->str) {
                            /* A string literal element: the bytes live in the
                             * pooled .rodata block emitted above. */
                            asmbuf_puts(&buf, "    LDR r0, =.L_gstr_");
                            asmbuf_int(&buf, gi);
                            asmbuf_putc(&buf, '_');
                            asmbuf_int(&buf, r->offset);
                            asmbuf_putc(&buf, '\n');
                        } else if (r->is_func) {
                            if (r->add != 0) {
                                diag_tool(DIAG_SEV_ERROR, "arkcc",
                                          "the initialiser of the global '%s' takes "
                                          "the address of the function '%s' plus a byte "
                                          "offset; a function type has no size, so that "
                                          "is not a constant expression (C11 6.5.6p2)",
                                          g->name, r->sym, 0,0,0,0);
                                continue;
                            }
                            asmbuf_puts(&buf, "    LDR r0, =");
                            asmbuf_puts(&buf, r->sym);
                            asmbuf_putc(&buf, '\n');
                        } else {
                            unsigned oaddr = gvar_find(r->sym);
                            unsigned taddr;
                            if (oaddr == 0) {
                                diag_tool(DIAG_SEV_ERROR, "arkcc",
                                          "the initialiser of the global '%s' takes the "
                                          "address of '%s', which this translation unit "
                                          "does not define; the arm backend gives every "
                                          "unit's data one fixed base address, so another "
                                          "unit's object cannot be named here",
                                          g->name, r->sym, 0,0,0,0);
                                continue;
                            }
                            taddr = oaddr + (unsigned)r->add;
                            emit_mov_addr32(&buf, 0, taddr, addr_in_own_data(taddr));
                        }
                        {
                            unsigned a2 = addr + (unsigned)r->offset;
                            emit_mov_addr32(&buf, 1, a2, addr_in_own_data(a2));
                        }
                        asmbuf_puts(&buf, "    STR r0, [r1]\n");
                    }
                }
            } else if (g->init_str && g->type && g->type->kind == TYPE_PTR) {
                /* Pointer initialised from a string literal: the bytes live
                 * in flash (see the .L_gstr_ block above), the object holds
                 * their address.  Writing the characters into the pointer
                 * was a silent wild pointer. */
                asmbuf_puts(&buf, "    LDR r0, =.L_gstr_");
                asmbuf_int(&buf, gi);
                asmbuf_putc(&buf, '\n');
                emit_mov_addr32(&buf, 1, addr, addr_in_own_data(addr));
                asmbuf_puts(&buf, "    STR r0, [r1]\n");
            } else if (g->init_str) {
                /* String initializer for char array.  Every byte of the object
                 * is written, the terminating NUL included.  This used to stop
                 * at the last character, so a global `char tag[] = "abc"`
                 * (size 4) had offset 3 left holding whatever SRAM powered up
                 * with: `sizeof` said 4, the init body wrote 3, and printing
                 * the tag ran on into uninitialised memory.  .data in SRAM is
                 * not zeroed for us (only .bss is), so the zero fill of a
                 * longer array (`char s[8] = "ab"`) is written here too,
                 * exactly as the aggregate path below does it. */
                int slen = ark_strlen(g->init_str);
                int si;
                if (sz < 4096) {
                    /* One base load, then STRB with an immediate offset. */
                    emit_mov_addr32(&buf, 1, addr, addr_in_own_data(addr));
                    for (si = 0; si < sz; si++) {
                        int ch = (si < slen)
                               ? (int)(unsigned char)g->init_str[si] : 0;
                        emit_mov_imm(&buf, 0, ch);
                        if (si == 0) {
                            asmbuf_puts(&buf, "    STRB r0, [r1]\n");
                        } else {
                            asmbuf_puts(&buf, "    STRB r0, [r1, #");
                            asmbuf_int(&buf, si);
                            asmbuf_puts(&buf, "]\n");
                        }
                    }
                } else {
                    /* Huge object: the byte offset no longer fits the STRB
                     * immediate, so recompute the address per byte. */
                    for (si = 0; si < sz; si++) {
                        int ch = (si < slen)
                               ? (int)(unsigned char)g->init_str[si] : 0;
                        emit_mov_imm(&buf, 0, ch);
                        emit_mov_addr32(&buf, 1, addr + (unsigned)si,
                                        addr_in_own_data(addr));
                        asmbuf_puts(&buf, "    STRB r0, [r1]\n");
                    }
                }
            } else {
                /* Integer scalar initialization */
                emit_mov_imm(&buf, 0, (int)g->init_int);
                emit_mov_addr32(&buf, 1, addr, addr_in_own_data(addr));
                if (sz == 1) {
                    asmbuf_puts(&buf, "    STRB r0, [r1]\n");
                } else if (sz == 2) {
                    asmbuf_puts(&buf, "    STRH r0, [r1]\n");
                } else if (sz >= 8) {
                    /* 64-bit: store low and high words (high=0 for now) */
                    asmbuf_puts(&buf, "    STR r0, [r1]\n");
                    emit_mov_imm(&buf, 0, (int)(g->init_int >> 32));
                    asmbuf_puts(&buf, "    STR r0, [r1, #4]\n");
                } else {
                    asmbuf_puts(&buf, "    STR r0, [r1]\n");
                }
            }
        }

        /* Zero .bss region */
        if (g_bss_sram_start != g_bss_sram_end) {
            emit_mov_addr32(&buf, 0, g_bss_sram_start, 1);
            emit_mov_addr32(&buf, 1, g_bss_sram_end, 1);
            asmbuf_puts(&buf, "    CMP r0, r1\n");
            asmbuf_puts(&buf, "    BEQ .L_bss_done\n");
            asmbuf_puts(&buf, "    MOV r2, #0\n");
            asmbuf_puts(&buf, ".L_bss_loop:\n");
            asmbuf_puts(&buf, "    STR r2, [r0]\n");
            asmbuf_puts(&buf, "    ADD r0, r0, #4\n");
            asmbuf_puts(&buf, "    CMP r0, r1\n");
            asmbuf_puts(&buf, "    BNE .L_bss_loop\n");
            asmbuf_puts(&buf, ".L_bss_done:\n");
        }

        /* Bug ROUND4-P3 FIX: Use POP {pc} for return instead of POP {r0}; BX r0.
         * In ARM Thumb mode, POP {pc} automatically sets the Thumb bit from
         * bit 0 of the stored LR (which is always 1 for Thumb code), so this
         * is the standard, more efficient epilogue pattern. */
        asmbuf_puts(&buf, "    POP {pc}\n\n");
    }

    /* AEABI run-time helpers.
     *
     * This backend used to emit its own implementations of the AEABI
     * soft-float and 64-bit integer helpers (__aeabi_ladd ... __aeabi_llsl,
     * __aeabi_uldivmod, __aeabi_ldivmod, __aeabi_fadd ... __aeabi_fdiv,
     * __aeabi_f2iz, __aeabi_fcmpeq, the whole d-family).  Running them
     * against the host oracle showed several of them are simply wrong:
     *
     *   __aeabi_f2iz     (int)2.0f                        -> 0    (want 2)
     *   __aeabi_fdiv     4.0f/2.0f == 2.0f                -> false
     *   __aeabi_uldivmod 1000ull/7ull                     -> wrong quotient
     *   __aeabi_ldivmod  1000000ll/1000ll & 127           -> 125  (want 104)
     *   __aeabi_dadd     (a+b)*(a-b)/(b+1) for (3.5,1.5)   -> 25   (want 144)
     *
     * Each of those is a silent wrong answer, the one outcome this compiler
     * refuses to produce.  The AEABI defines these symbols as part of the
     * *target run-time library*, and every real toolchain carries them:
     * arm-none-eabi-gcc ships libgcc.a, armcc ships armlib.  So they are no
     * longer emitted here.  An image that uses floating point, 64-bit
     * division or 64-bit <-> float conversion must link that library; one
     * that does not fails at link time with "undefined reference to
     * __aeabi_..." instead of computing something false.
     *
     * __aeabi_memcpy stays: no run-time library provides it for a
     * freestanding target, the byte loop below cannot be wrong, and struct
     * assignment / struct-by-value arguments would otherwise need libc.
     *
     * Emitted only when this unit actually calls it: every TU that includes
     * <string.h>-using code used to carry the routine whether or not it
     * branched to it (1,235 of the 1,780 dead helper instructions in the
     * 95-TU corpus).  The scan is over the text already emitted, which is
     * exactly the set of call sites that survive optimisation. */
    {
        int need_memcpy = 0, ms;
        static const char mcpy_needle[] = "BL __aeabi_memcpy";
        for (ms = 0; ms + (int)sizeof(mcpy_needle) - 1 <= buf.len; ms++) {
            if (memcmp(buf.buf + ms, mcpy_needle, sizeof(mcpy_needle) - 1) == 0) {
                need_memcpy = 1;
                break;
            }
        }
        if (need_memcpy) {
            /* __aeabi_memcpy: struct assignment, struct-by-value arguments and
             * array initialisation are all lowered to a `BL memcpy`.  That made
             * every one of them a link-time dependency on the C library, which a
             * freestanding target does not have -- the MiniApp SDK on the board
             * defines no memcpy, so `s = va_arg(ap, struct S)` (and any plain
             * `a = b` for structs) failed to link with "undefined reference to
             * memcpy".  Emitting the routine under the AEABI name it belongs to
             * (r0=dst, r1=src, r2=n, same convention as the real one) removes the
             * dependency and still satisfies a translation unit that only ever
             * sees `BL __aeabi_memcpy`.
             *
             * Byte-at-a-time on purpose: no alignment requirement, no tail, and
             * the assembler only has to encode 16-bit forms.  Structs in this
             * language are small; a word loop would be faster but would need the
             * unaligned-tail path proven first. */
            asmbuf_puts(&buf, ".global __aeabi_memcpy\n.thumb_func\n__aeabi_memcpy:\n");
            asmbuf_puts(&buf, "    PUSH {r4}\n");
            asmbuf_puts(&buf, "    MOV r4, r0\n");
            asmbuf_puts(&buf, "    CMP r2, #0\n");
            asmbuf_puts(&buf, "    BEQ .L_arkcc_mcpy_done\n");
            asmbuf_puts(&buf, ".L_arkcc_mcpy_loop:\n");
            asmbuf_puts(&buf, "    LDRB r3, [r1]\n");
            asmbuf_puts(&buf, "    STRB r3, [r4]\n");
            asmbuf_puts(&buf, "    ADD r4, r4, #1\n");
            asmbuf_puts(&buf, "    ADD r1, r1, #1\n");
            /* SUB + CMP, not `SUBS`: the internal assembler takes SUBS only with
             * --asm-extra, and this routine is emitted for every target build.
             * Measured on the board: `cc --pack` refused the whole unit with
             * "unknown mnemonic \"SUBS\"" -- the host gate assembles with GNU as,
             * which takes it, so this only showed up on the target. */
            asmbuf_puts(&buf, "    SUB r2, r2, #1\n");
            asmbuf_puts(&buf, "    CMP r2, #0\n");
            asmbuf_puts(&buf, "    BNE .L_arkcc_mcpy_loop\n");
            asmbuf_puts(&buf, ".L_arkcc_mcpy_done:\n");
            asmbuf_puts(&buf, "    POP {r4}\n");
            asmbuf_puts(&buf, "    BX lr\n\n");
        }                                       /* need_memcpy */
    }

    /* Globals: SRAM addresses are assigned by gvar_assign() above and loaded
     * via MOVW/MOVT in IR_PUSH_GLOBAL etc. .data globals are initialized at
     * startup by __arkcc_init_globals (generated above). .bss globals are
     * zeroed by the same function. __at variables use their absolute address.
     * Note: .set directives for alias functions are emitted in the function
     * code section above, not here. */
    if (0 && prog->global_count > 0) {
        int gi;
        int cur_sec = 0;  /* 0=.text, 1=.data, 2=.bss, 3=.rodata, 4=custom */
        for (gi = 0; gi < prog->global_count; gi++) {
            IrGlobal *g = prog->globals[gi];
            int sz;
            int want_sec = 0;
            const char *want_custom = 0;
            if (g->is_extern) continue;
            /* __at(addr): define the symbol directly as an absolute address constant (no storage allocated).
             *   .global name
             *   .set name, 0xADDR
             * This way every LDR rN, =name loads the MMIO physical address,
             * and subsequent LDR/STR [rN] accesses the peripheral register. */
            if (g->has_at) {
                if (!g->is_static) {
                    asmbuf_puts(&buf, ".global ");
                    asmbuf_puts(&buf, g->name);
                    asmbuf_putc(&buf, '\n');
                }
                asmbuf_puts(&buf, ".set ");
                asmbuf_puts(&buf, g->name);
                asmbuf_puts(&buf, ", 0x");
                {
                    unsigned a = g->at_addr;
                    char hex[9]; int k;
                    const char *hd = "0123456789abcdef";
                    for (k = 7; k >= 0; k--) { hex[k] = hd[a & 0xF]; a >>= 4; }
                    hex[8] = 0;
                    asmbuf_puts(&buf, hex);
                }
                asmbuf_putc(&buf, '\n');
                continue;
            }
            sz = g->type ? type_size(g->type) : 4;
            if (sz <= 0) sz = 4;
            /* Choose section: custom section > no-init (.bss) > const (.rodata) > .data */
            if (g->section) {
                want_custom = g->section;
            } else if (!g->has_init) {
                want_sec = 2;
            } else if (g->is_const) {
                want_sec = 3;
            } else {
                want_sec = 1;
            }
#if ARKCC_FEATURE_ARMCC_KEYWORDS
            /* __thread thread-local storage: use .tbss (no init) / .tdata (has init) instead.
             * These two sections are instantiated per-thread by the loader in each thread context. */
            if (g->is_tls) {
                if (!g->has_init || g->init_aggregate) {
                    want_sec = 5;  /* .tbss */
                } else {
                    want_sec = 6;  /* .tdata */
                }
            }
#endif
            /* Switch section (only emit section directive if different from current) */
            if (want_custom) {
                asmbuf_puts(&buf, ".section \"");
                asmbuf_puts(&buf, want_custom);
                asmbuf_puts(&buf, "\"");
#if ARKCC_FEATURE_SCATTER
                /* SCT-1: annotate the section's scatter exec region base so
                 * the resolved layout is visible in the emitted assembly. */
                if (g_scatter_loaded) {
                    unsigned sect_base =
                        scatter_get_er_base_for_section(&g_scatter, want_custom);
                    if (sect_base) {
                        char hex[9]; int k;
                        const char *hd = "0123456789ABCDEF";
                        asmbuf_puts(&buf, "  @ base 0x");
                        for (k = 7; k >= 0; k--) { hex[k] = hd[sect_base & 0xF]; sect_base >>= 4; }
                        hex[8] = 0;
                        asmbuf_puts(&buf, hex);
                    }
                }
#endif
                asmbuf_putc(&buf, '\n');
                cur_sec = 4;
            } else if (cur_sec != want_sec) {
                if (want_sec == 1) asmbuf_puts(&buf, ".data\n");
                else if (want_sec == 2) asmbuf_puts(&buf, ".bss\n");
                else if (want_sec == 3) asmbuf_puts(&buf, ".section .rodata\n");
#if ARKCC_FEATURE_ARMCC_KEYWORDS
                else if (want_sec == 5) asmbuf_puts(&buf, ".section .tbss,\"aw\",%nobits\n");
                else if (want_sec == 6) asmbuf_puts(&buf, ".section .tdata,\"aw\",%progbits\n");
#endif
                cur_sec = want_sec;
            }
            /* Symbol attributes + label */
            if (!g->is_static) {
                asmbuf_puts(&buf, ".global ");
                asmbuf_puts(&buf, g->name);
                asmbuf_putc(&buf, '\n');
            }
            /* Alignment: __align(n) / aligned(n) takes priority; otherwise default 4 bytes */
            if (g->align_bytes > 4) {
                asmbuf_puts(&buf, ".balign ");
                asmbuf_int(&buf, g->align_bytes);
                asmbuf_putc(&buf, '\n');
            } else {
                asmbuf_puts(&buf, ".align 4\n");
            }
            asmbuf_puts(&buf, g->name);
            asmbuf_puts(&buf, ":\n");
            /* Data */
            if (!g->has_init || g->init_aggregate) {
                /* Zero-init or aggregate (initialized at runtime): reserve space */
                asmbuf_puts(&buf, "    .zero ");
                asmbuf_int(&buf, sz);
                asmbuf_putc(&buf, '\n');
            } else if (g->is_float) {
                /* Float initialization: convert to single-precision bit pattern (consistent with IR_PUSH_FLOAT) */
                union { float f; unsigned int u; } u;
                unsigned int bits;
                char hex[9];
                int k;
                const char *hd = "0123456789abcdef";
                u.f = (float)g->init_float;
                bits = u.u;
                for (k = 7; k >= 0; k--) { hex[k] = hd[bits & 0xF]; bits >>= 4; }
                hex[8] = 0;
                asmbuf_puts(&buf, "    .word 0x");
                asmbuf_puts(&buf, hex);
                asmbuf_putc(&buf, '\n');
            } else if (g->init_str) {
                /* String array initialization: same escaping as IR_PUSH_STR.
                 * `.asciz` appends the NUL, so an array with exactly no room
                 * for it (`char s[4] = "abcd"`) must use `.ascii` -- otherwise
                 * the object emitted one byte more than it occupies and ran
                 * over whatever the next symbol was. */
                int slen = ark_strlen(g->init_str);
                int k;
                asmbuf_puts(&buf, (slen >= sz) ? "    .ascii \"" : "    .asciz \"");
                for (k = 0; k < slen; k++) {
                    char c = g->init_str[k];
                    if (c == '\n') asmbuf_puts(&buf, "\\n");
                    else if (c == '\t') asmbuf_puts(&buf, "\\t");
                    else if (c == '\\') asmbuf_puts(&buf, "\\\\");
                    else if (c == '"')  asmbuf_puts(&buf, "\\\"");
                    else if ((unsigned char)c < 0x20 || (unsigned char)c >= 0x7F) {
                        char hb[8]; int hn = 0;
                        const char *hh = "0123456789abcdef";
                        hb[hn++] = '\\'; hb[hn++] = 'x';
                        hb[hn++] = hh[((unsigned char)c >> 4) & 0xF];
                        hb[hn++] = hh[(unsigned char)c & 0xF];
                        hb[hn] = 0;
                        asmbuf_puts(&buf, hb);
                    } else {
                        asmbuf_putc(&buf, c);
                    }
                }
                asmbuf_puts(&buf, "\"\n");
                /* Pad remaining space with zeros (e.g. char[10] = "hi") */
                if (slen + 1 < sz) {
                    asmbuf_puts(&buf, "    .zero ");
                    asmbuf_int(&buf, sz - (slen + 1));
                    asmbuf_putc(&buf, '\n');
                }
            } else {
                /* Scalar initialization */
                asmbuf_puts(&buf, "    .word ");
                asmbuf_int(&buf, g->init_int);
                asmbuf_putc(&buf, '\n');
                if (sz > 4) {
                    asmbuf_puts(&buf, "    .zero ");
                    asmbuf_int(&buf, sz - 4);
                    asmbuf_putc(&buf, '\n');
                }
            }
        }
        /* Restore .text section for later manual appending */
        asmbuf_puts(&buf, ".text\n\n");
    }
#if ARKCC_FEATURE_DWARF_FULL
    /* DWARF debug info (enabled by --dwarf2/--dwarf3):
     * Emit .debug_info/.debug_abbrev/.debug_line sections recording the compilation unit,
     * function symbols and line number maps, for GDB/LLDB single-stepping. Uses a DWARF v2 subset:
     * only the CU header + per-function DIE + line number program; no variable location info (simplified).
     * Detailed type info references predefined DW_TAGs in .debug_abbrev via DW_FORM_ref4. */
    if (g_config.dwarf_version >= 2) {
        int fi2;
        const char *fname = prog->source_file ? prog->source_file : "input.c";
        /* .debug_abbrev: abbreviation table, defines DIE tag/attribute forms */
        asmbuf_puts(&buf, ".section .debug_abbrev,\"\",%progbits\n");
        asmbuf_puts(&buf, ".balign 4\n");
        asmbuf_puts(&buf, "    .byte 1\n");              /* abbrev code 1 */
        asmbuf_puts(&buf, "    .byte 17\n");             /* DW_TAG_compile_unit */
        asmbuf_puts(&buf, "    .byte 0\n");              /* DW_CHILDREN_yes */
        asmbuf_puts(&buf, "    .byte 3\n  .byte 8\n");   /* DW_AT_name, DW_FORM_string */
        asmbuf_puts(&buf, "    .byte 16\n  .byte 6\n");  /* DW_AT_stmt_list, DW_FORM_data4 */
        asmbuf_puts(&buf, "    .byte 0\n  .byte 0\n");   /* end attr/end form */
        asmbuf_puts(&buf, "    .byte 2\n");              /* abbrev code 2 */
        asmbuf_puts(&buf, "    .byte 46\n");             /* DW_TAG_subprogram */
        asmbuf_puts(&buf, "    .byte 0\n");              /* DW_CHILDREN_no */
        asmbuf_puts(&buf, "    .byte 3\n  .byte 8\n");   /* DW_AT_name, DW_FORM_string */
        asmbuf_puts(&buf, "    .byte 17\n  .byte 1\n");  /* DW_AT_low_pc, DW_FORM_addr */
        asmbuf_puts(&buf, "    .byte 18\n  .byte 1\n");  /* DW_AT_high_pc, DW_FORM_addr */
        asmbuf_puts(&buf, "    .byte 0\n  .byte 0\n");   /* end attr/end form */
        asmbuf_puts(&buf, "    .byte 0\n");              /* end abbrev table */
        /* .debug_info: compilation unit + per-function DIE */
        asmbuf_puts(&buf, ".section .debug_info,\"\",%progbits\n");
        asmbuf_puts(&buf, ".balign 4\n");
        asmbuf_puts(&buf, "    .word 0\n");              /* unit_length (placeholder, simplified) */
        asmbuf_puts(&buf, "    .half 2\n");              /* DWARF version 2 */
        asmbuf_puts(&buf, "    .word 0\n");              /* debug_abbrev_offset */
        asmbuf_puts(&buf, "    .byte 4\n");              /* address_size */
        asmbuf_puts(&buf, "    .byte 1\n");              /* abbrev 1 = compile_unit */
        asmbuf_puts(&buf, "    .asciz \"");
        asmbuf_puts(&buf, fname);
        asmbuf_puts(&buf, "\"\n");
        asmbuf_puts(&buf, "    .word 0\n");              /* stmt_list offset */
        for (fi2 = 0; fi2 < prog->func_count; fi2++) {
            IrFunc *f2 = prog->funcs[fi2];
            if (f2->alias_target) continue;
            asmbuf_puts(&buf, "    .byte 2\n");          /* abbrev 2 = subprogram */
            asmbuf_puts(&buf, "    .asciz \"");
            asmbuf_puts(&buf, f2->name);
            asmbuf_puts(&buf, "\"\n");
            asmbuf_puts(&buf, "    .word ");
            asmbuf_puts(&buf, f2->name);
            asmbuf_putc(&buf, '\n');                     /* low_pc */
            asmbuf_puts(&buf, "    .word ");
            asmbuf_puts(&buf, f2->name);
            asmbuf_puts(&buf, "_end\n");                 /* high_pc */
        }
        asmbuf_puts(&buf, "    .byte 0\n");              /* end DIE list */
        /* .debug_line: line number program (file name table + end entry only) */
        asmbuf_puts(&buf, ".section .debug_line,\"\",%progbits\n");
        asmbuf_puts(&buf, ".balign 4\n");
        asmbuf_puts(&buf, "    .word 0\n");              /* unit_length (placeholder) */
        asmbuf_puts(&buf, "    .half 2\n");              /* DWARF version 2 */
        asmbuf_puts(&buf, "    .word 0\n");              /* header_length */
        asmbuf_puts(&buf, "    .byte 4\n");              /* minimum_instruction_length */
        asmbuf_puts(&buf, "    .byte 0\n");              /* default_is_stmt */
        asmbuf_puts(&buf, "    .byte 1\n");              /* line_base */
        asmbuf_puts(&buf, "    .byte 1\n");              /* line_range */
        asmbuf_puts(&buf, "    .byte 13\n");             /* opcode_base */
        asmbuf_puts(&buf, "    .byte 0,1,1,0,1,0,0,1,1,1,1,1\n"); /* standard_opcode_lengths */
        asmbuf_puts(&buf, "    .asciz \"");
        asmbuf_puts(&buf, fname);
        asmbuf_puts(&buf, "\"\n");                       /* include_directories */
        asmbuf_puts(&buf, "    .byte 0\n");
        asmbuf_puts(&buf, "    .asciz \"");
        asmbuf_puts(&buf, fname);
        asmbuf_puts(&buf, "\"\n");                       /* file_names */
        asmbuf_puts(&buf, "    .byte 0,0,0\n");
        asmbuf_puts(&buf, "    .byte 0\n");              /* end file table */
        asmbuf_puts(&buf, "    .byte 0,9,2\n");          /* DW_LNE_end_sequence */
        asmbuf_puts(&buf, ".text\n");
    }
#endif
#if ARKCC_FEATURE_RT_LAZY
    /* --rt-lazy：只保留被引用到的 __aeabi_* 辅助函数。默认关闭时这段完全不执行，
     * 产物与旧版本逐字节相同。 */
    if (g_config.enable_rt_lazy && buf.len > 0) {
        buf.len = rt_prune_asm_text(buf.buf, buf.len);
    }
#endif
    return buf.buf;
}

/* === Minimal Thumb-2 text assembler === */
typedef struct AsmLabel {
    char *name;
    int   addr;
    int   is_weak;
    int   is_func;   /* defined in .text with a non-local name: its address
                      * is a Thumb function pointer, so LDR rd,=name must set
                      * bit 0.  Data and .L labels keep it clear. */
} AsmLabel;
/* --reloc-text: relocation type for a MOVW/MOVT pair that carries an address
 * inside this object's own code/rodata window (a string literal, usually).
 * Unlike types 1..4 this entry names no symbol: the linker adds
 * (the base it links this object at - the base this object was compiled
 * against), and it learns the latter from the __arkcc_text_base symbol the
 * object carries.  12 is the next free number after .arkdata (6), ADR (7),
 * CBZ/CBNZ (8, 9) and the cross-object LDR= sites (10 data / 11 function). */
#define ARM_RELOC_TEXT       12
#define ARM_RELOC_TEXT_NAME  ".arktext"
/* Cross-object reference to a *data* object: `extern int errno;` in a unit
 * that does not define it.  The MOVW/MOVT pair at the recorded offset has to
 * end up holding the final address of the named global, and that address is
 * only known after -link has placed every object's data window -- so the ref
 * carries the symbol name and the linker looks it up in the data-symbol table
 * instead of adding a delta.  15 is the next free number after .arkdata (6),
 * ADR (7), CBZ/CBNZ (8, 9), the cross-object LDR= sites (10, 11) and
 * .arktext (12). */
#define ARM_RELOC_DATA_SYM   15

typedef struct AsmRef   { int pc; char *name; int type; } AsmRef;
/* Literal pool entry: LDR rd,=label at ldr_pc needs a 4-byte literal at pool_offset */
typedef struct AsmLiteral { int ldr_pc; char *name; int pool_offset; } AsmLiteral;

#if ARKCC_FEATURE_OPT_BRANCH
/* -fopt-branch: one branch site as measured in the all-32-bit layout.
 * `pc` is where the branch sits in that layout, `cond` is -1 for B and the
 * 4-bit condition code otherwise, and `shrink` is the decision taken by
 * arm_decide_branches().  pass 2 walks this list by ordinal. */
typedef struct AsmBranch {
    int   pc;
    int   cond;
    char *name;
    int   shrink;
} AsmBranch;
#endif

typedef struct {
    const char    *src;
    unsigned char *out;
    int            pc;
    int            out_cap;
    AsmLabel      *labels;
    int            label_count, label_cap;
    AsmRef        *refs;
    int            ref_count, ref_cap;
    int            error_count;
    /* .set symbols (absolute addresses, e.g. __at variables, alias functions) */
    AsmLabel      *sets;
    int            set_count, set_cap;
    /* Literal pool for LDR rd,=label */
    /* Genuine assembly errors (unknown mnemonic, unresolvable internal label).
     * Kept separate from error_count, which also counts unresolved external
     * references that the linker may still satisfy. */
    int            hard_errors;
    AsmLiteral    *literals;
    int            literal_count, literal_cap;
    int            literal_pool_start;  /* pc where the pool begins (-1 = not yet) */
    /* .weak directive sets pending_weak; the next label defined inherits it. */
    int            pending_weak;
    /* Current section: 0=.text, 1=.data, 2=.bss, 3=.init_array, 4=.fini_array */
    int            cur_section;
    /* 1 while pass2_a runs.  Register-list diagnostics are reported
     * there only: pass 1 just measures instruction sizes, and reporting
     * from both passes would print every error twice. */
#if ARKCC_FEATURE_OPT_BRANCH
    /* -fopt-branch planning state (see arm_decide_branches). */
    AsmBranch     *branches;
    int            branch_count, branch_cap;
    int            branch_decided;  /* how many entries carry a decision */
    int            plan_branches;   /* 1 = pass 1 records and pass 2 shrinks */
    int            branch_ord;      /* pass-2 cursor into branches[] */
    int           *align_pcs;
    int            align_count, align_cap;
#endif
    int            pass2;
    /* Total byte count laid out by pass 1.  Pass 2 compares against its own
     * pc at the end; a disagreement means the two passes sized some line
     * differently, which shifts every label after it. */
    int            pass1_size;
} ArmAsm;

static int is_alpha_a(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_' || c == '.';
}
static int is_alnum_a(char c) {
    return is_alpha_a(c) || (c >= '0' && c <= '9');
}
static int is_space_a(char c) { return c == ' ' || c == '\t' || c == '\r'; }
static int my_toupper_a(int c) {
    if (c >= 'a' && c <= 'z') return c - 'a' + 'A';
    return c;
}
static int strieq_a(const char *a, const char *b) {
    while (*a && *b) {
        if (my_toupper_a(*a) != my_toupper_a(*b)) return 0;
        a++; b++;
    }
    return *a == 0 && *b == 0;
}
static int starts_with_a(const char *s, const char *prefix) {
    while (*prefix) {
        if (*s != *prefix) return 0;
        s++; prefix++;
    }
    return 1;
}
static void skip_space_a(const char **p) { while (is_space_a(**p)) (*p)++; }
static void skip_to_eol_a(const char **p) { while (**p && **p != '\n') (*p)++; }

static int read_word_a(const char **p, char *out, int cap) {
    int n = 0;
    skip_space_a(p);
    if (**p == '.') {
        /* Directive (e.g. ".text", ".global", ".L1"): include '.' in word */
        while (**p && is_alnum_a(**p) && n < cap - 1) {
            out[n++] = **p; (*p)++;
        }
    } else {
        /* Instruction/label (e.g. "VADD", "add_float"): stop at '.'
         * so VFP suffixes like ".F32" are NOT consumed as part of the
         * mnemonic.  Without this, "VADD.F32" is read as one word and
         * strieq_a(first,"VADD") fails, causing all VFP arithmetic
         * instructions to fall through to NOP. */
        while (**p && is_alnum_a(**p) && **p != '.' && n < cap - 1) {
            out[n++] = **p; (*p)++;
        }
    }
    out[n] = 0;
    return n;
}

static int parse_reg_a(const char **p) {
    int n = 0;
    skip_space_a(p);
    if ((**p == 'r' || **p == 'R')) {
        (*p)++;
        while (**p >= '0' && **p <= '9') {
            n = n * 10 + (**p - '0');
            (*p)++;
        }
        return n;
    }
    if ((**p == 's' || **p == 'S') && ((*p)[1] == 'p' || (*p)[1] == 'P')) { (*p) += 2; return 13; }
    if ((**p == 'l' || **p == 'L') && ((*p)[1] == 'r' || (*p)[1] == 'R')) { (*p) += 2; return 14; }
    if ((**p == 'p' || **p == 'P') && ((*p)[1] == 'c' || (*p)[1] == 'C')) { (*p) += 2; return 15; }
    if ((**p == 'i' || **p == 'I') && ((*p)[1] == 'p' || (*p)[1] == 'P')) { (*p) += 2; return 12; }
    if ((**p == 'f' || **p == 'F') && ((*p)[1] == 'p' || (*p)[1] == 'P')) { (*p) += 2; return 11; }
    return -1;
}

/* #1 FIX: Parse VFP single-precision register (s0-s31).
 * Returns register number 0-31, or -1 if not an S register.
 * Must not match 'sp' (handled by parse_reg_a). */
static int parse_vfp_sreg_a(const char **p) {
    int n = 0;
    skip_space_a(p);
    if ((**p == 's' || **p == 'S') &&
        ((*p)[1] >= '0' && (*p)[1] <= '9')) {
        (*p)++;
        while (**p >= '0' && **p <= '9') {
            n = n * 10 + (**p - '0');
            (*p)++;
        }
        if (n > 31) n = 31;
        return n;
    }
    return -1;
}

/* #1 FIX: Parse VFP double-precision register (d0-d15).
 * Returns register number 0-15, or -1 if not a D register. */
static int parse_vfp_dreg_a(const char **p) {
    int n = 0;
    skip_space_a(p);
    if (**p == 'd' || **p == 'D') {
        (*p)++;
        while (**p >= '0' && **p <= '9') {
            n = n * 10 + (**p - '0');
            (*p)++;
        }
        if (n > 15) n = 15;
        return n;
    }
    return -1;
}

/* #1 FIX: Read VFP instruction suffix (e.g. ".F32", ".F64", ".S32.F32").
 * Concatenates all suffix segments into out (e.g. "F32", "S32F32").
 * Advances p past the suffix. */
static void read_vfp_suffix_a(const char **p, char *out, int cap) {
    int n = 0;
    skip_space_a(p);
    while (**p == '.' && n < cap - 1) {
        (*p)++;
        /* Inner loop: read alnum but NOT '.' (dots are handled by outer loop).
         * Without excluding '.', is_alnum_a('.')==true would consume the
         * entire ".F32.S32" as one segment "F32.S32" (with embedded dot),
         * causing strieq_a(suf,"F32S32") to fail. */
        while (is_alnum_a(**p) && **p != '.' && n < cap - 1) {
            out[n++] = **p;
            (*p)++;
        }
    }
    out[n] = 0;
}


/* FIX(vfp-encode): Split an S/D register number into the two fields the VFP
 * encoders actually use.
 *
 * The classic ARM ARM shorthand "Sd = D:Vd" reads as if a single-precision
 * register number were (16 * half_bit + 4-bit field); that is what this file
 * originally assumed.  Measured against armasm 5.06
 * (--cpu Cortex-M7 --fpu=FPv5_D16, see h7test/v3.lst / v4.lst) the field holds
 * reg[4:1] and the separate "half" bit holds reg[0]:
 *     VADD.F32 S0, S0, S16 -> 0xEE300A08   (field 8 = 16>>1, half 0 = 16&1)
 *     VADD.F32 S0, S0, S1  -> 0xEE300A20   (field 0 =  1>>1, half 1 =  1&1)
 *     VADD.F32 S1, S2, S3  -> 0xEE710A21   (every field shifted the same way)
 * D0-D15 put the whole number in the 4-bit field and leave the half bit clear.
 * The half bit sits at bit22 for Vd, bit7 for Vn and bit5 for Vm. */
static unsigned ark_vfp_nib(int reg, int is_dbl) {
    if (reg < 0) reg = 0;
    return is_dbl ? (unsigned)(reg & 0xF) : (unsigned)((reg >> 1) & 0xF);
}
static unsigned ark_vfp_half(int reg, int is_dbl) {
    if (reg < 0) reg = 0;
    return is_dbl ? (unsigned)((reg >> 4) & 1) : (unsigned)(reg & 1);
}
static int parse_imm_a(const char **p) {
    int neg = 0;
    int v = 0;
    skip_space_a(p);
    if (**p != '#') return 0;
    (*p)++;
    if (**p == '-') { neg = 1; (*p)++; }
    if (**p == '0' && ((*p)[1] == 'x' || (*p)[1] == 'X')) {
        (*p) += 2;
        for (;;) {
            char c = **p;
            int d;
            if (c >= '0' && c <= '9') d = c - '0';
            else if (c >= 'a' && c <= 'f') d = c - 'a' + 10;
            else if (c >= 'A' && c <= 'F') d = c - 'A' + 10;
            else break;
            v = v * 16 + d;
            (*p)++;
        }
    } else {
        while (**p >= '0' && **p <= '9') {
            v = v * 10 + (**p - '0');
            (*p)++;
        }
    }
    return neg ? -v : v;
}

/* 32-bit immediate (`#0xFFFFFFFF`, `#-1`, `#4294967295`) for the operands that
 * can hold a whole word: MOV/MVN modified immediates.  parse_imm_a() returns an
 * int and computes its magnitude in int, so it cannot represent 0x80000000 and
 * overflows on any constant above 0x7FFFFFFF; unsigned arithmetic is
 * well-defined (it wraps), which is exactly the bit pattern we want. */
static int parse_imm_u32_a(const char **p, unsigned *out) {
    unsigned v = 0;
    int neg = 0, digits = 0;
    skip_space_a(p);
    if (**p != '#') return 0;
    (*p)++;
    skip_space_a(p);
    if (**p == '-') { neg = 1; (*p)++; }
    if (**p == '0' && ((*p)[1] == 'x' || (*p)[1] == 'X')) {
        (*p) += 2;
        for (;;) {
            char c = **p;
            unsigned d;
            if (c >= '0' && c <= '9') d = (unsigned)(c - '0');
            else if (c >= 'a' && c <= 'f') d = (unsigned)(c - 'a' + 10);
            else if (c >= 'A' && c <= 'F') d = (unsigned)(c - 'A' + 10);
            else break;
            v = v * 16u + d;
            digits++;
            (*p)++;
        }
    } else {
        while (**p >= '0' && **p <= '9') {
            v = v * 10u + (unsigned)(**p - '0');
            digits++;
            (*p)++;
        }
    }
    if (!digits) return 0;
    *out = neg ? (unsigned)(0u - v) : v;
    return 1;
}

/* Immediate operand where the '#' is optional (armasm accepts both
 * "SVC 0xAB" and "SVC #0xAB"). Returns 0 and clears *ok when no number is
 * present: parse_imm_a() would return 0 in that case as well, which turns a
 * mangled operand into a silent SVC #0. */
static int parse_imm_opt_hash_a(const char **p, int *ok) {
    int neg = 0;
    int v = 0;
    int digits = 0;
    skip_space_a(p);
    if (**p == '#') { (*p)++; skip_space_a(p); }
    if (**p == '-') { neg = 1; (*p)++; }
    if (**p == '0' && ((*p)[1] == 'x' || (*p)[1] == 'X')) {
        (*p) += 2;
        for (;;) {
            char c = **p;
            int d;
            if (c >= '0' && c <= '9') d = c - '0';
            else if (c >= 'a' && c <= 'f') d = c - 'a' + 10;
            else if (c >= 'A' && c <= 'F') d = c - 'A' + 10;
            else break;
            v = v * 16 + d;
            digits++;
            (*p)++;
        }
    } else {
        while (**p >= '0' && **p <= '9') {
            v = v * 10 + (**p - '0');
            digits++;
            (*p)++;
        }
    }
    *ok = (digits > 0);
    return neg ? -v : v;
}

static void eat_comma_a(const char **p) {
    skip_space_a(p);
    if (**p == ',') (*p)++;
    skip_space_a(p);
}

static void out16(ArmAsm *a, unsigned v) {
    if (a->pc + 2 > a->out_cap) { a->error_count++; return; }
    a->out[a->pc++] = (unsigned char)(v & 0xFF);
    a->out[a->pc++] = (unsigned char)((v >> 8) & 0xFF);
}

static void add_label_a(ArmAsm *a, const char *name, int addr) {
    if (a->label_count >= a->label_cap) {
        int nc = a->label_cap == 0 ? 32 : a->label_cap * 2;
        a->labels = (AsmLabel *)mem_realloc(a->labels,
            a->label_cap * (int)sizeof(AsmLabel),
            nc * (int)sizeof(AsmLabel));
        a->label_cap = nc;
    }
    a->labels[a->label_count].name = mem_strdup(name);
    a->labels[a->label_count].addr = addr;
    a->labels[a->label_count].is_weak = a->pending_weak;
    a->labels[a->label_count].is_func =
        (a->cur_section == 0 && !(name[0] == '.' && name[1] == 'L')) ? 1 : 0;
    a->pending_weak = 0;
    a->label_count++;
}
static int find_label_a(ArmAsm *a, const char *name) {
    int i;
    for (i = 0; i < a->label_count; i++)
        if (ark_streq(a->labels[i].name, name)) return a->labels[i].addr;
    return -1;
}

/* 1 if `name` is a function label (see AsmLabel.is_func). */
static int label_is_func_a(ArmAsm *a, const char *name) {
    int i;
    for (i = 0; i < a->label_count; i++)
        if (ark_streq(a->labels[i].name, name)) return a->labels[i].is_func;
    return 0;
}
static void add_ref_a(ArmAsm *a, int pc, const char *name, int type) {
    if (a->ref_count >= a->ref_cap) {
        int nc = a->ref_cap == 0 ? 32 : a->ref_cap * 2;
        a->refs = (AsmRef *)mem_realloc(a->refs,
            a->ref_cap * (int)sizeof(AsmRef),
            nc * (int)sizeof(AsmRef));
        a->ref_cap = nc;
    }
    a->refs[a->ref_count].pc = pc;
    a->refs[a->ref_count].name = mem_strdup(name);
    a->refs[a->ref_count].type = type;
    a->ref_count++;
}

#if ARKCC_FEATURE_OPT_BRANCH
/* ============ short-branch shrinking (-fopt-branch) ============
 * op_size_a() sizes every B/B<cond> at 4 bytes on purpose: a 16-bit branch
 * whose offset does not fit truncates silently, and that silent truncation is
 * how a loop back-edge once jumped into the middle of an instruction.  The
 * price is two wasted bytes at each branch that does fit.  This pass measures
 * the assembled function once at 4 bytes per branch, marks the sites whose
 * target is inside the 16-bit range, and has pass 2 emit the short form for
 * exactly those sites.
 *
 * One measuring round is enough because a shrink only ever shortens the span
 * between a branch and its target.  An `.align` directive inside the span
 * breaks that argument -- the padding absorbs the saving, so the distance can
 * even grow -- and such a branch is refused outright.  The final pass-1 run
 * re-lays every label with the chosen widths, which keeps alignment padding
 * exact.
 *
 * Encodings (offset is relative to pc+4 and must be even):
 *   B   T2 : 11100 imm11     , -2048..2046
 *   Bcc T1 : 1101 cond imm8  ,  -256.. 254
 */
static int branch_cond_a(const char *m) {
    if (strieq_a(m, "B"))   return -1;
    if (strieq_a(m, "BEQ")) return 0;
    if (strieq_a(m, "BNE")) return 1;
    if (strieq_a(m, "BCS") || strieq_a(m, "BHS")) return 2;
    if (strieq_a(m, "BCC") || strieq_a(m, "BLO")) return 3;
    if (strieq_a(m, "BHI")) return 8;
    if (strieq_a(m, "BLS")) return 9;
    if (strieq_a(m, "BGE")) return 10;
    if (strieq_a(m, "BLT")) return 11;
    if (strieq_a(m, "BGT")) return 12;
    if (strieq_a(m, "BLE")) return 13;
    return -2;   /* not a branch this pass knows how to shrink */
}

/* Returns the shrink flag this ordinal already carries (0 on the first
 * recording run), so pass 1 can lay the branch out at its final width. */
static int add_branch_a(ArmAsm *a, int pc, int cond, const char *name) {
    int idx = a->branch_count;
    int keep = 0;
    if (idx >= a->branch_cap) {
        int nc = a->branch_cap == 0 ? 32 : a->branch_cap * 2;
        a->branches = (AsmBranch *)mem_realloc(a->branches,
            a->branch_cap * (int)sizeof(AsmBranch),
            nc * (int)sizeof(AsmBranch));
        a->branch_cap = nc;
    }
    /* The list is rebuilt by every pass-1 run; the decision attached to an
     * ordinal must survive the rebuild, or the final run would erase it. */
    if (idx < a->branch_decided) keep = a->branches[idx].shrink;
    a->branches[idx].pc = pc;
    a->branches[idx].cond = cond;
    a->branches[idx].name = mem_strdup(name);
    a->branches[idx].shrink = keep;
    a->branch_count = idx + 1;
    return keep;
}

static void add_align_a(ArmAsm *a, int pc) {
    if (a->align_count >= a->align_cap) {
        int nc = a->align_cap == 0 ? 16 : a->align_cap * 2;
        a->align_pcs = (int *)mem_realloc(a->align_pcs,
            a->align_cap * (int)sizeof(int), nc * (int)sizeof(int));
        a->align_cap = nc;
    }
    a->align_pcs[a->align_count++] = pc;
}

/* Decide, from the all-32-bit layout, which branches fit.  Returns the number
 * of entries whose flag changed (0 means the plan is settled). */
static int arm_decide_branches(ArmAsm *a) {
    int i, changed = 0;
    for (i = 0; i < a->branch_count; i++) {
        AsmBranch *b = &a->branches[i];
        int tgt = find_label_a(a, b->name);
        int fit = 0;
        if (tgt >= 0) {
            int base = b->pc + 4;
            int off = tgt - base;
            int blocked = 0;
            int j;
            /* A forward target moves two bytes closer because this branch
             * itself is about to shrink; every other shrink between the two
             * shortens the span further, so this is an upper bound. */
            if (tgt >= base) off -= 2;
            for (j = 0; j < a->align_count; j++) {
                int ap = a->align_pcs[j];
                int lo = b->pc < tgt ? b->pc : tgt;
                int hi = b->pc < tgt ? tgt : b->pc;
                if (ap > lo && ap <= hi) { blocked = 1; break; }
            }
            if (!blocked && (off & 1) == 0) {
                if (b->cond < 0) fit = (off >= -2048 && off <= 2046);
                else             fit = (off >= -256 && off <= 254);
            }
        }
        if (fit != b->shrink) { b->shrink = fit; changed++; }
    }
    a->branch_decided = a->branch_count;
    return changed;
}

/* Emit the 16-bit form.  arm_decide_branches() guarantees the range; a
 * violation here means the plan and the layout disagree, which would be a
 * wrong branch, so it is reported instead of encoded. */
static void emit_b16_a(ArmAsm *a, int cond, int target) {
    int off = target - a->pc - 4;
    if (cond < 0) {
        if (off < -2048 || off > 2046 || (off & 1)) {
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "internal layout error: shrunk B does not fit its "
                      "16-bit range", 0,0,0,0,0,0);
            a->hard_errors++;
            out16(a, 0xBF00);
            return;
        }
        out16(a, 0xE000u | (unsigned)((off >> 1) & 0x7FF));
    } else {
        if (off < -256 || off > 254 || (off & 1)) {
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "internal layout error: shrunk Bcc does not fit its "
                      "16-bit range", 0,0,0,0,0,0);
            a->hard_errors++;
            out16(a, 0xBF00);
            return;
        }
        out16(a, 0xD000u | (unsigned)((cond & 0xF) << 8) |
                   (unsigned)((off >> 1) & 0xFF));
    }
}
#endif

/* .set symbol management (absolute addresses) */
static void add_set_a(ArmAsm *a, const char *name, int addr) {
    if (a->set_count >= a->set_cap) {
        int nc = a->set_cap == 0 ? 32 : a->set_cap * 2;
        a->sets = (AsmLabel *)mem_realloc(a->sets,
            a->set_cap * (int)sizeof(AsmLabel),
            nc * (int)sizeof(AsmLabel));
        a->set_cap = nc;
    }
    a->sets[a->set_count].name = mem_strdup(name);
    a->sets[a->set_count].addr = addr;
    a->set_count++;
}
static int find_set_a(ArmAsm *a, const char *name) {
    int i;
    for (i = 0; i < a->set_count; i++)
        if (ark_streq(a->sets[i].name, name)) return a->sets[i].addr;
    return -1;
}

/* Literal pool management */
static void add_literal_a(ArmAsm *a, int ldr_pc, const char *name) {
    if (a->literal_count >= a->literal_cap) {
        int nc = a->literal_cap == 0 ? 32 : a->literal_cap * 2;
        a->literals = (AsmLiteral *)mem_realloc(a->literals,
            a->literal_cap * (int)sizeof(AsmLiteral),
            nc * (int)sizeof(AsmLiteral));
        a->literal_cap = nc;
    }
    a->literals[a->literal_count].ldr_pc = ldr_pc;
    a->literals[a->literal_count].name = mem_strdup(name);
    a->literals[a->literal_count].pool_offset = -1;
    a->literal_count++;
}

/* Resolve a symbol: try .set first, then code labels */
static int resolve_symbol_a(ArmAsm *a, const char *name) {
    int addr = find_set_a(a, name);
    if (addr >= 0) return addr;
    addr = find_label_a(a, name);
    return addr;  /* may be -1 if unresolved */
}

/* Determine instruction size for LDR/STR/LDRB/STRB/LDRH/STRH/LDRSH/LDRSB
 * with immediate offset. Returns 2 (T1 16-bit) or 4 (T3 32-bit).
 * T1 limits: word imm5=(off>>2)&0x1F (max 124, step 4),
 *            byte imm5=off&0x1F (max 31),
 *            half imm5=(off>>1)&0x1F (max 62, step 2).
 * T3 supports imm12=off (max 4095 bytes). */
static int ldr_str_size_a(int imm, int is_byte, int is_half) {
    if (imm < 0) return 4;  /* negative offset always needs T3 */
    if (is_byte) {
        if (imm <= 31) return 2;
    } else if (is_half) {
        if (imm <= 62 && (imm % 2 == 0)) return 2;
    } else {
        if (imm <= 124 && (imm % 4 == 0)) return 2;
    }
    return 4;
}

#if ARKCC_FEATURE_ASM_EXTRA
/* --asm-extra: runtime switch and the set of mnemonics the extension adds.
 * Both live here (not at each branch) so that "off" is one decision, not
 * thirteen, and so that the off path can reproduce the old "unknown mnemonic"
 * diagnostic exactly. */
static int ark_asm_extra_on(void) {
    return g_config.enable_asm_extra ? 1 : 0;
}

static int ark_asm_extra_name(const char *op) {
    static const char *names[] = {
        /* ADDS/SUBS are deliberately NOT gated: the ARM backend emits them
         * for the 64-bit add/sub carry chain, so they have to assemble
         * without --asm-extra (otherwise the compiler cannot assemble its
         * own output for `long long` arithmetic).
         * CBZ/CBNZ are NOT gated either, now that -fopt-cbz emits them from
         * `CMP #0` + `BEQ/BNE` (same rule as ADDS/SUBS: the compiler has to
         * be able to assemble its own output).  Both are still covered by the
         * byte-for-byte comparison in tests/asm_cases/run_asm_cmp.py. */
        "ANDS", "ORRS", "EORS", "BICS", "MVNS", "MULS",
        "LSLS", "LSRS", "ASRS", "ADR",
        "LDM", "LDMIA", "LDMDB", "STM", "STMIA", "STMDB",
        "TBB", "TBH", "LDRD", "STRD",
        "MLA", "MLS", "SMULL", "SMLAL"
    };
    int i;
    for (i = 0; i < (int)(sizeof(names) / sizeof(names[0])); i++)
        if (strieq_a(op, names[i])) return 1;
    return 0;
}
#endif

/* armasm spells four of these differently.  Canonicalising the mnemonic, rather
 * than teaching every branch a second name, keeps the size pass and the emit
 * pass looking at exactly one spelling -- a rule they cannot disagree about. */
static void canon_alias_a(char *m) {
    const char *to = 0;
    if (strieq_a(m, "LDMFD"))      to = "LDMIA";
    else if (strieq_a(m, "STMFD")) to = "STMDB";
    else if (strieq_a(m, "LDMEA")) to = "LDMDB";
    else if (strieq_a(m, "STMEA")) to = "STMIA";
    if (to) {
        int i = 0;
        while (to[i]) { m[i] = to[i]; i++; }
        m[i] = '\0';
    }
}

/* AND / ORR / EOR / BIC / MVN, every shape the backend and hand-written
 * assembly use:
 *   OP Rd, Rm          (Rd = Rd OP Rm)
 *   OP Rd, #imm        (Rd = Rd OP imm)
 *   OP Rd, Rn, Rm
 *   OP Rd, Rn, #imm
 * Only the first shape has a 16-bit encoding, and only for low registers;
 * everything else is Thumb-2.  Before this existed the encoder assumed the
 * 16-bit form unconditionally and never looked past the second operand, so
 * "ORR ip, ip, #1" -- the Thumb-bit fixup in front of an indirect call --
 * was silently emitted as NOTHING (and an earlier attempt as "orrs r4,r4",
 * masking ip to r4 and dropping the immediate).  The program then branched
 * into the middle of an instruction.
 *
 * Pass 1 asks with emit=0 and pass 2 with emit=1; both get the size from the
 * same decision, so the two passes cannot disagree.
 *
 * ANDS/ORRS/EORS/BICS/MVNS stay in the --asm-extra branch further down: they
 * are opt-in mnemonics and must keep being rejected when the switch is off. */
/* Defined further down; the logical-op encoder above needs it. */
static int thumb_imm12_a(unsigned val, unsigned *out_i, unsigned *out_imm3,
                         unsigned *out_imm8);

static int logic_dp_a(ArmAsm *a, const char *op, const char **pp, int emit) {
    const char *p = *pp;
    int is_bic = strieq_a(op, "BIC");
    int is_orr = strieq_a(op, "ORR");
    int is_eor = strieq_a(op, "EOR");
    int is_mvn = strieq_a(op, "MVN");
    unsigned base_reg, base_imm;
    int rd, rn;

    /* Encode "Rd = Rn OP imm", the Thumb-2 immediate form. */
    /* (written as a macro-free block below because C89-era style here) */
    if (is_bic)      { base_reg = 0xEA20u; base_imm = 0xF020u; }
    else if (is_orr) { base_reg = 0xEA40u; base_imm = 0xF040u; }
    else if (is_eor) { base_reg = 0xEA80u; base_imm = 0xF080u; }
    /* MVN Rd, #imm exists as ORN with Rn = 1111 (measured with GAS:
     * "mvn r0, #1" assembles to f06f 0001), so that form keeps Rn fixed
     * in the opcode word instead of taking it from the text. */
    else if (is_mvn) { base_reg = 0xEA6Fu; base_imm = 0xF06Fu; }
    else             { base_reg = 0xEA00u; base_imm = 0xF000u; }  /* AND */

    rd = parse_reg_a(&p);
    eat_comma_a(&p);
    if (*p == '#') {
        unsigned imm = 0;
        unsigned i = 0, imm3 = 0, imm8 = 0;
        (void)parse_imm_u32_a(&p, &imm);
        if (!thumb_imm12_a(imm, &i, &imm3, &imm8)) {
            if (emit) {
                char b1[12];
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "%sq immediate %s cannot be encoded as a modified "
                          "immediate", op, diag_num(b1, (int)imm), 0,0,0,0);
                a->hard_errors++;
                out16(a, 0xBF00);
                out16(a, 0xBF00);
            }
            *pp = p;
            return 4;
        }
        if (emit) {
            unsigned rnw = is_mvn ? 0xFu : (unsigned)(rd & 0xF);
            out16(a, base_imm | ((i & 1) << 10) | rnw);
            out16(a, ((imm3 & 7) << 12) | ((unsigned)(rd & 0xF) << 8) | imm8);
        }
        *pp = p;
        return 4;
    }
    rn = parse_reg_a(&p);
    skip_space_a(&p);
    if (*p == ',') {
        int rm;
        p++; skip_space_a(&p);
        if (*p == '#') {
            unsigned imm = 0;
            unsigned i = 0, imm3 = 0, imm8 = 0;
            (void)parse_imm_u32_a(&p, &imm);
            if (!thumb_imm12_a(imm, &i, &imm3, &imm8)) {
                if (emit) {
                    char b1[12];
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "%sq immediate %s cannot be encoded as a "
                              "modified immediate", op, diag_num(b1, (int)imm),
                              0,0,0,0);
                    a->hard_errors++;
                    out16(a, 0xBF00);
                    out16(a, 0xBF00);
                }
                *pp = p;
                return 4;
            }
            if (emit) {
                unsigned rnw = is_mvn ? 0xFu : (unsigned)(rn & 0xF);
                out16(a, base_imm | ((i & 1) << 10) | rnw);
                out16(a, ((imm3 & 7) << 12) | ((unsigned)(rd & 0xF) << 8) | imm8);
            }
            *pp = p;
            return 4;
        }
        rm = parse_reg_a(&p);
        if (emit && rd >= 0 && rn >= 0 && rm >= 0) {
            out16(a, is_mvn ? 0xEA6Fu : (base_reg | (unsigned)(rn & 0xF)));
            out16(a, ((unsigned)(rd & 0xF) << 8) | (unsigned)(rm & 0xF));
        }
        *pp = p;
        return 4;
    }
    /* Two operands: the 16-bit form only knows low registers. */
    if (rd >= 0 && rd <= 7 && rn >= 0 && rn <= 7) {
        if (emit) {
            unsigned short16 = is_bic ? 0x4380u : is_orr ? 0x4300u :
                               is_eor ? 0x4040u : is_mvn ? 0x43C0u : 0x4000u;
            out16(a, short16 | ((unsigned)(rn & 7) << 3) | (unsigned)(rd & 7));
        }
        *pp = p;
        return 2;
    }
    /* Two operands with a high register: Thumb-2, Rn = Rd. */
    if (emit && rd >= 0 && rn >= 0) {
        out16(a, is_mvn ? 0xEA6Fu : (base_reg | (unsigned)(rd & 0xF)));
        out16(a, ((unsigned)(rd & 0xF) << 8) | (unsigned)(rn & 0xF));
    }
    *pp = p;
    return 4;
}

static int op_size_a(const char *op) {
    if (strieq_a(op, "BL"))   return 4;
    if (strieq_a(op, "MOVW")) return 4;
    if (strieq_a(op, "MOVT")) return 4;
    if (strieq_a(op, "ADDW") || strieq_a(op, "SUBW")) return 4;
#if ARKCC_FEATURE_ASM_VFP_LDSTM
    /* VFP multi-register load/store: one encoding, always 32 bits. */
    if (strieq_a(op, "VLDMIA") || strieq_a(op, "VLDM") || strieq_a(op, "VLDMDB") ||
        strieq_a(op, "VSTMIA") || strieq_a(op, "VSTM") || strieq_a(op, "VSTMDB") ||
        strieq_a(op, "VPUSH") || strieq_a(op, "VPOP")) return 4;
#endif
    if (strieq_a(op, "SDIV")) return 4;
    if (strieq_a(op, "UDIV")) return 4;
    if (strieq_a(op, "UMULL")) return 4;
    if (strieq_a(op, "B.W"))  return 4;
    /* Unconditional B uses 32-bit B.W (T4, +-1MB) to avoid +-2KB range
     * truncation in large functions (e.g. HAL_GPIO_Init is ~3.5KB;
     * 16-bit B T2 silently truncates imm11 causing the loop back-edge
     * to jump to a wrong address, breaking GPIO config). */
    if (strieq_a(op, "B"))    return 4;
    /* Conditional branches use 32-bit B<cond>.W (T3, +-1MB) to avoid
     * +-256B range truncation in large functions (e.g. HAL_RCC_OscConfig
     * is 8632 bytes; 16-bit B<cond> T1 silently truncates imm8 causing
     * branches to jump to wrong locations). T3 lo word bit12=0 (0x8000 base). */
    if (strieq_a(op, "BEQ") || strieq_a(op, "BNE") || strieq_a(op, "BCS") ||
        strieq_a(op, "BCC") || strieq_a(op, "BGE") || strieq_a(op, "BLT") ||
        strieq_a(op, "BGT") || strieq_a(op, "BLE") ||
        strieq_a(op, "BHI") || strieq_a(op, "BLS") ||
        strieq_a(op, "BLO") || strieq_a(op, "BHS")) return 4;
    /* Barriers DMB/DSB/ISB use 32-bit T1 encoding (0xF3BF 0x8F4x/5x/6x).
     * 16-bit T2 (0xBF50/60/70) is not standard ARMv7-M; use 32-bit form. */
    if (strieq_a(op, "DMB") || strieq_a(op, "DSB") || strieq_a(op, "ISB")) return 4;
    /* RRX is encoded as MOV Rd, Rm, RRX (32-bit T2 data-processing). */
    if (strieq_a(op, "RRX")) return 4;
    /* --asm-extra: multiply-accumulate and special-register moves are 32-bit
     * only.  Their size must be right in pass 1 or every later label and branch
     * in the file shifts by 2 bytes. */
    if (strieq_a(op, "MLA") || strieq_a(op, "MLS") ||
        strieq_a(op, "SMULL") || strieq_a(op, "SMLAL")) return 4;
    if (strieq_a(op, "MRS") || strieq_a(op, "MSR")) return 4;
    if (strieq_a(op, "ADR.W") || strieq_a(op, "CBZ.W") || strieq_a(op, "CBNZ.W")) return 4;
    /* --asm-extra: table branches and the 64-bit load/store pair have no
     * 16-bit encoding at all, so pass 1 must count 4 bytes for them. */
    if (strieq_a(op, "TBB") || strieq_a(op, "TBH") ||
        strieq_a(op, "LDRD") || strieq_a(op, "STRD")) return 4;
    /* CLZ, RBIT and SADD16 only exist as 32-bit Thumb-2 encodings. */
    if (strieq_a(op, "CLZ"))    return 4;
    if (strieq_a(op, "RBIT"))   return 4;
    if (strieq_a(op, "SADD16")) return 4;
    /* #1 FIX: VFP instructions are all 32-bit (two 16-bit halfwords).
     * Without this, pass1 counts 2 bytes but pass2 emits 4, causing
     * all subsequent labels/branches to be off by 2 bytes per VFP instr. */
    if (strieq_a(op, "VMOV") || strieq_a(op, "VADD") || strieq_a(op, "VSUB") ||
        strieq_a(op, "VMUL") || strieq_a(op, "VDIV") || strieq_a(op, "VCVT") ||
        strieq_a(op, "VCMP") || strieq_a(op, "VMRS") || strieq_a(op, "VSTR") ||
        strieq_a(op, "VLDR") || strieq_a(op, "VNEG") || strieq_a(op, "VABS") ||
        strieq_a(op, "VSQRT")) return 4;
    return 2;
}

/* ============================ LDR/STR family =============================
 * One parser and one encoder for LDR/STR/LDRB/STRB/LDRH/STRH/LDRSB/LDRSH.
 *
 * Address modes on ARMv7-M (all four measured against arm-none-eabi-as):
 *   [Rn]                 [Rn, #imm]            [Rn, Rm]
 *   [Rn, Rm, LSL #0..3]  [Rn, #imm]!           [Rn], #imm
 * Register-indexed *writeback* ([Rn, Rm]! and [Rn], Rm) does not exist in
 * Thumb at all -- GAS refuses those lines, and so does this assembler.
 *
 * Widths:
 *   kind 0 word   16-bit T1 (imm5 scaled by 4) | 32-bit T3 (imm12 in bytes)
 *   kind 1 byte   16-bit T1 (imm5)              | 32-bit T3
 *   kind 2 half   16-bit T1 (imm5 scaled by 2)  | 32-bit T3
 *   kind 3 ldrsb  no 16-bit immediate form, 32-bit only
 *   kind 4 ldrsh  same
 * The 32-bit imm12 is a plain 0..4095 byte offset for *every* width; only the
 * 16-bit T1 imm5 is scaled.  (Measured: GAS assembles `ldr.w r0,[r1,#128]` to
 * f8d1 0080, i.e. 0x80 -- scaling belongs to VLDR, not to LDR/STR.)
 * The 32-bit register-offset and writeback forms share one header word
 * (T3 base with bit 7 cleared); the immediate bits differ.
 *
 * Pass 1 asks ldr_str_size2_a() and pass 2 emits on the same answer, so the
 * two passes cannot disagree about a width -- getting that wrong shifts every
 * later label in the file.  */
typedef struct ArmMemOp {
    int rn;      /* base register, -1 = missing */
    int rm;      /* index register, -1 = none */
    int shift;   /* LSL amount for rm, 0..3 */
    int imm;     /* immediate offset, or the post-index value */
    int wb;      /* a writeback form: "!" or a post-index operand */
    int post;    /* post-indexed ([Rn], #imm) rather than pre-indexed */
} ArmMemOp;

/* 0 = LDR/STR, 1 = byte, 2 = halfword, 3 = LDRSB, 4 = LDRSH. -1 if not ours. */
static int ldr_str_kind_a(const char *m, int *is_load) {
    if (m[0] == 'S' || m[0] == 's') *is_load = 0; else *is_load = 1;
    if (strieq_a(m, "LDR") || strieq_a(m, "STR"))   return 0;
    if (strieq_a(m, "LDRB") || strieq_a(m, "STRB")) return 1;
    if (strieq_a(m, "LDRH") || strieq_a(m, "STRH")) return 2;
    if (strieq_a(m, "LDRSB")) return 3;
    if (strieq_a(m, "LDRSH")) return 4;
    return -1;
}

static int is_ldr_str_a(const char *m) {
    int dummy = 0;
    return ldr_str_kind_a(m, &dummy) >= 0;
}

/* quiet != 0 is pass 1: it only needs the same size answer, and reporting the
 * same error twice (once per pass) reads like two separate defects. */
static void parse_memop_a(ArmAsm *a, const char **p, ArmMemOp *m, int quiet) {
    m->rn = -1; m->rm = -1; m->shift = 0; m->imm = 0; m->wb = 0; m->post = 0;
    skip_space_a(p);
    if (**p == '[') { (*p)++; skip_space_a(p); }
    m->rn = parse_reg_a(p);
    skip_space_a(p);
    if (**p == ',') {
        (*p)++; skip_space_a(p);
        if (**p == '#') {
            m->imm = parse_imm_a(p);
        } else {
            m->rm = parse_reg_a(p);
            skip_space_a(p);
            if (**p == ',') {                  /* , LSL #imm2 */
                char opn[8];
                (*p)++; skip_space_a(p);
                read_word_a(p, opn, (int)sizeof(opn));
                skip_space_a(p);
                if (**p == '#') m->shift = parse_imm_a(p);
                if (!strieq_a(opn, "LSL") || m->shift < 0 || m->shift > 3) {
                    if (!quiet) {
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "a register offset may only use 'LSL #0'..'LSL #3' "
                                  "(other shifts and ASR/LSR do not exist here)",
                                  0,0,0,0,0,0);
                        a->hard_errors++;
                    }
                    m->shift = 0;
                }
            }
        }
    }
    skip_space_a(p);
    if (**p == ']') (*p)++;
    skip_space_a(p);
    if (**p == '!') {
        m->wb = 1;
        (*p)++;
    } else if (**p == ',') {                   /* post-indexed */
        (*p)++; skip_space_a(p);
        m->wb = 1;
        m->post = 1;
        if (**p == '#') m->imm = parse_imm_a(p);
        else            m->rm = parse_reg_a(p);
    }
}

/* 2 or 4 bytes. Both passes must get the same answer. */
static int ldr_str_size2_a(int kind, int rt, const ArmMemOp *m) {
    int low = (rt >= 0 && rt <= 7 && m->rn >= 0 && m->rn <= 7);
    if (m->rm >= 0) {
        if (low && m->rm <= 7 && m->shift == 0 && !m->wb) return 2;
        return 4;
    }
    if (m->wb) return 4;
    if (kind == 0 && rt >= 0 && rt <= 7 && m->imm >= 0 && m->imm <= 1020 &&
        (m->imm & 3) == 0 && (m->rn == 13 || m->rn == 15))
        return 2;                            /* SP-relative / literal pool */
    switch (kind) {
    case 1:  return (low && m->imm >= 0 && m->imm <= 31) ? 2 : 4;
    case 2:  return (low && m->imm >= 0 && m->imm <= 62 && (m->imm & 1) == 0) ? 2 : 4;
    case 0:  return (low && m->imm >= 0 && m->imm <= 124 && (m->imm & 3) == 0) ? 2 : 4;
    default: return 4;                       /* LDRSB/LDRSH: no imm16 form */
    }
}

static void emit_ldr_str_a(ArmAsm *a, int kind, int is_load, int rt,
                           const ArmMemOp *m) {
    /* 16-bit T1 bases: [kind][0] = store, [kind][1] = load. */
    static const unsigned t1_imm[5][2] = {
        {0x6000u, 0x6800u},   /* STR   / LDR  */
        {0x7000u, 0x7800u},   /* STRB  / LDRB */
        {0x8000u, 0x8800u},   /* STRH  / LDRH */
        {0x0000u, 0x0000u},   /* LDRSB: no 16-bit immediate form */
        {0x0000u, 0x0000u}    /* LDRSH: same */
    };
    static const unsigned t1_reg[5][2] = {
        {0x5000u, 0x5800u},   /* STR   / LDR  */
        {0x5400u, 0x5C00u},   /* STRB  / LDRB */
        {0x5200u, 0x5A00u},   /* STRH  / LDRH */
        {0x0000u, 0x5600u},   /* LDRSB (load only) */
        {0x0000u, 0x5E00u}    /* LDRSH (load only) */
    };
    static const unsigned t3[5][2] = {          /* 32-bit immediate form */
        {0xF8C0u, 0xF8D0u},   /* STR.W   / LDR.W  */
        {0xF880u, 0xF890u},   /* STRB.W  / LDRB.W */
        {0xF8A0u, 0xF8B0u},   /* STRH.W  / LDRH.W */
        {0x0000u, 0xF990u},   /* LDRSB.W */
        {0x0000u, 0xF9B0u}    /* LDRSH.W */
    };
    int sz;
    unsigned base;

    if (!is_load && (kind == 3 || kind == 4)) {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "LDRSB/LDRSH are loads only; there is no signed store", 0,0,0,0,0,0);
        a->hard_errors++;
        kind = 0;
    }
    if (rt < 0 || rt > 15) {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "LDR/STR needs a destination/source register", 0,0,0,0,0,0);
        a->hard_errors++;
        rt = 0;
    }
    if (m->rn < 0 || m->rn > 15) {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "LDR/STR needs a base register inside []", 0,0,0,0,0,0);
        a->hard_errors++;
    }
    if (m->rm >= 0 && m->rm > 15) {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "index register out of range", 0,0,0,0,0,0);
        a->hard_errors++;
    }
    if (m->wb && m->rm >= 0) {
        /* Thumb has no register-indexed writeback form: not "unimplemented",
         * simply absent from the architecture (GAS refuses the same lines). */
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "register-indexed writeback ([Rn, Rm]! / [Rn], Rm) does not "
                  "exist in Thumb; use an immediate offset or a separate ADD",
                  0,0,0,0,0,0);
        a->hard_errors++;
    }

    /* A writeback with a register index is unencodable: fall back to the plain
     * register-offset form so the object still has the right size. */
    {
        ArmMemOp mm = *m;
        if (mm.wb && mm.rm >= 0) mm.wb = 0;
        sz = ldr_str_size2_a(kind, rt, &mm);
        m = &mm;
    }
    base = t3[kind][is_load ? 1 : 0];

    if (sz == 2) {
        if (m->rm < 0 && m->rn == 13) {
            /* SP-relative T1: 1001 L imm8 | Rt | imm8/4 (word only). */
            out16(a, (is_load ? 0x9800u : 0x9000u) |
                      ((unsigned)(rt & 7) << 8) | (unsigned)((m->imm >> 2) & 0xFF));
            return;
        }
        if (m->rm < 0 && m->rn == 15) {
            /* PC-relative literal load, 01001 Rt imm8 (loads only). */
            out16(a, 0x4800u | ((unsigned)(rt & 7) << 8) |
                      (unsigned)((m->imm >> 2) & 0xFF));
            return;
        }
        if (m->rm >= 0) {
            out16(a, t1_reg[kind][is_load ? 1 : 0] |
                      ((unsigned)(m->rm & 7) << 6) |
                      ((unsigned)(m->rn & 7) << 3) | (unsigned)(rt & 7));
        } else {
            unsigned imm5;
            if (kind == 1)      imm5 = (unsigned)(m->imm & 0x1F);
            else if (kind == 2) imm5 = (unsigned)((m->imm >> 1) & 0x1F);
            else                imm5 = (unsigned)((m->imm >> 2) & 0x1F);
            out16(a, t1_imm[kind][is_load ? 1 : 0] | (imm5 << 6) |
                      ((unsigned)(m->rn & 7) << 3) | (unsigned)(rt & 7));
        }
        return;
    }

    /* 32-bit forms. */
    if (m->rm >= 0) {
        /* Register offset: same header as the writeback form. */
        out16(a, (base & ~0x80u) | (unsigned)(m->rn & 0xF));
        out16(a, ((unsigned)(rt & 0xF) << 12) |
                 ((unsigned)(m->shift & 3) << 4) | (unsigned)(m->rm & 0xF));
        return;
    }
    if (m->wb) {
        int pre = !m->post;
        int neg = (m->imm < 0);
        int mag = neg ? -m->imm : m->imm;
        if (mag > 255) {
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "a writeback offset must be within -255..255", 0,0,0,0,0,0);
            a->hard_errors++;
            mag = 0;
        }
        out16(a, (base & ~0x80u) | (unsigned)(m->rn & 0xF));
        out16(a, ((unsigned)(rt & 0xF) << 12) | 0x800u |
                 (unsigned)(pre ? 0x400 : 0) | (unsigned)(neg ? 0 : 0x200) |
                 0x100u | (unsigned)mag);
        return;
    }
    if (m->imm >= 0) {
        int off = m->imm;
        if (off > 4095) {
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "offset out of range: a 32-bit LDR/STR takes 0..4095 bytes",
                      0,0,0,0,0,0);
            a->hard_errors++;
            off = 0;
        }
        out16(a, base | (unsigned)(m->rn & 0xF));
        out16(a, ((unsigned)(rt & 0xF) << 12) | (unsigned)(off & 0xFFF));
        return;
    }
    {
        int mag = -m->imm;                       /* negative, no writeback */
        if (mag > 255) {
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "a negative offset must be within -255..-1", 0,0,0,0,0,0);
            a->hard_errors++;
            mag = 0;
        }
        out16(a, (base & ~0x80u) | (unsigned)(m->rn & 0xF));
        out16(a, ((unsigned)(rt & 0xF) << 12) | 0x800u | 0x400u | (unsigned)mag);
    }
}

/* Forward declaration: needed in pass1 to decide whether PUSH/POP is T1 or T2 encoded */
static int parse_reglist_a(ArmAsm *a, const char **p, int *has_lr, int *has_pc);
/* Forward declaration: pass 1 records branch targets for -fopt-branch. */
static int read_label_name_a(const char **p, char *buf, int cap);

static void pass1_a(ArmAsm *a) {
    a->pass2 = 0;
    const char *p = a->src;
    /* The reserved vector-table area counts as part of the section, so labels
     * inside it (there are none) and after it keep the addresses the final
     * image will really have. */
    int pc = g_arm_vt_reserve ? ARM_VT_SIZE : 0;
    a->label_count = 0;
    a->set_count = 0;
    a->literal_count = 0;
#if ARKCC_FEATURE_OPT_BRANCH
    a->branch_count = 0;
    a->align_count = 0;
#endif
    while (*p) {
        char first[64];
        int n;
        skip_space_a(&p);
        if (*p == '\n') { p++; continue; }
        if (*p == ';') { skip_to_eol_a(&p); continue; }
        if (*p == '\0') break;
        n = read_word_a(&p, first, (int)sizeof(first));
        canon_alias_a(first);
        if (n == 0) { skip_to_eol_a(&p); continue; }
        skip_space_a(&p);
        if (*p == ':') {
            add_label_a(a, first, pc);
            p++;
            skip_space_a(&p);
            if (*p == '\n' || *p == ';' || *p == '\0') { if (*p == ';') skip_to_eol_a(&p); if (*p == '\n') p++; continue; }
            n = read_word_a(&p, first, (int)sizeof(first));
            canon_alias_a(first);
            if (n == 0) { skip_to_eol_a(&p); continue; }
        }
        if (first[0] == '.') {
            /* Pseudo-directives: some affect pc, others are metadata-only */
            if (strieq_a(first, ".set") || strieq_a(first, ".equ")) {
                /* .set name, 0xADDR - record absolute address */
                char sym[64];
                skip_space_a(&p);
                n = read_word_a(&p, sym, (int)sizeof(sym));
                if (n > 0) {
                    skip_space_a(&p);
                    if (*p == ',') p++;
                    skip_space_a(&p);
                    if (*p == '0' && (p[1] == 'x' || p[1] == 'X')) {
                        unsigned addr = 0;
                        p += 2;
                        while ((*p >= '0' && *p <= '9') || (*p >= 'a' && *p <= 'f') || (*p >= 'A' && *p <= 'F')) {
                            char c = *p;
                            int v = (c >= '0' && c <= '9') ? c - '0' :
                                    (c >= 'a' && c <= 'f') ? c - 'a' + 10 : c - 'A' + 10;
                            addr = addr * 16 + v;
                            p++;
                        }
                        add_set_a(a, sym, (int)addr);
                    } else {
                        /* .set name, other_label - resolve later, store as ref */
                        char tgt[64];
                        n = read_word_a(&p, tgt, (int)sizeof(tgt));
                        (void)n; (void)tgt;
                        /* For alias functions, defer to resolve_refs via BL lookup */
                    }
                }
            } else if (strieq_a(first, ".zero") || strieq_a(first, ".skip") || strieq_a(first, ".space")) {
                /* .zero N - reserve N bytes */
                int sz = 0;
                skip_space_a(&p);
                if (*p == '#') p++;
                while (*p >= '0' && *p <= '9') { sz = sz * 10 + (*p - '0'); p++; }
                pc += sz;
            } else if (strieq_a(first, ".word") || strieq_a(first, ".long")) {
                /* .word value - 4 bytes (may have multiple comma-separated values) */
                int count = 1;
                const char *scan = p;
                while (*scan && *scan != '\n') { if (*scan == ',') count++; scan++; }
                pc += 4 * count;
            } else if (strieq_a(first, ".byte")) {
                int count = 1;
                const char *scan = p;
                while (*scan && *scan != '\n') { if (*scan == ',') count++; scan++; }
                pc += count;
            } else if (strieq_a(first, ".asciz")) {
                /* .asciz "string" - string length + NUL, aligned to 2 */
                int slen = 0;
                skip_space_a(&p);
                if (*p == '"') {
                    p++;
                    while (*p && *p != '"' && *p != '\n') {
                        if (*p == '\\') { slen++; p++; if (*p) p++; }
                        else { slen++; p++; }
                    }
                    if (*p == '"') p++;
                }
                slen++;  /* NUL terminator */
                if (slen & 1) slen++;  /* align to 2 */
                pc += slen;
            } else if (strieq_a(first, ".ascii")) {
                int slen = 0;
                skip_space_a(&p);
                if (*p == '"') {
                    p++;
                    while (*p && *p != '"' && *p != '\n') {
                        if (*p == '\\') { slen++; p++; if (*p) p++; }
                        else { slen++; p++; }
                    }
                    if (*p == '"') p++;
                }
                if (slen & 1) slen++;
                pc += slen;
            } else if (strieq_a(first, ".align") || strieq_a(first, ".balign")) {
                /* Align to N bytes */
                int align = 0;
                skip_space_a(&p);
                if (*p == '#') p++;
                while (*p >= '0' && *p <= '9') { align = align * 10 + (*p - '0'); p++; }
                if (align > 1) {
#if ARKCC_FEATURE_OPT_BRANCH
                    /* -fopt-branch: remember where padding may appear. */
                    if (a->plan_branches) add_align_a(a, pc);
#endif
                    int rem = pc % align;
                    if (rem != 0) pc += align - rem;
                }
            } else if (strieq_a(first, ".weak")) {
                /* .weak name - mark the next-defined label as weak.
                 * The symbol name argument is consumed but pending_weak
                 * applies to whichever label is defined next (the .weak
                 * directive always immediately precedes the label in our
                 * emission order: .global / .weak / label:). */
                char wname[64];
                skip_space_a(&p);
                n = read_word_a(&p, wname, (int)sizeof(wname));
                (void)n; (void)wname;
                a->pending_weak = 1;
            } else if (strieq_a(first, ".section")) {
                /* .section .text.foo, "ax", %progbits - track current section.
                 * Section tracking is metadata-only (pc unaffected); the
                 * assembler emits all code/data into a single linear buffer. */
                char sec[64];
                skip_space_a(&p);
                n = read_word_a(&p, sec, (int)sizeof(sec));
                if (n > 0) {
                    if (starts_with_a(sec, ".init_array")) a->cur_section = 3;
                    else if (starts_with_a(sec, ".fini_array")) a->cur_section = 4;
                    else if (starts_with_a(sec, ".data")) a->cur_section = 1;
                    else if (starts_with_a(sec, ".bss")) a->cur_section = 2;
                    else a->cur_section = 0;  /* .text or default */
                }
            } else if (strieq_a(first, ".text")) {
                a->cur_section = 0;
            } else if (strieq_a(first, ".data")) {
                a->cur_section = 1;
            } else if (strieq_a(first, ".bss")) {
                a->cur_section = 2;
            }
            /* .global, .type, .size, .thumb, .file, .loc, .cfi_*,
             * etc. are metadata-only and don't affect pc */
        } else {
            /* Optional ".W"/".N" width suffix (see pass 2): skip it before any
             * size decision.  It stays inside the instruction branch on purpose:
             * a pseudo-directive must never reach the size chain below, or it
             * would add 2 bytes per directive line and shift every label. */
            if (*p == '.' && (my_toupper_a(p[1]) == 'W' || my_toupper_a(p[1]) == 'N') &&
                !is_alnum_a(p[2])) {
                p += 2;
                skip_space_a(&p);
            }
            if (0) {
            } else if (is_ldr_str_a(first)) {
                /* Width comes from ldr_str_size2_a() and nothing else, so pass 1
                 * and pass 2 cannot disagree (a 2-byte disagreement shifts every
                 * later label in the file). */
                int is_load1 = 1;
                int kind1 = ldr_str_kind_a(first, &is_load1);
                int rt1 = parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == ',') { p++; skip_space_a(&p); }
                if (*p == '=') {
                    /* LDR rd, =label - emit MOVW+MOVT (8 bytes) in pass2 */
                    char name[64];
                    p++;
                    n = read_word_a(&p, name, (int)sizeof(name));
                    (void)n;
                    pc += 8;
                } else if (*p != '[') {
                    /* LDR rd, <label> -- -fopt-litpool's literal load.  The
                     * 32-bit PC-relative form is always four bytes, so the
                     * size does not depend on the distance, which pass 1
                     * cannot know anyway. */
                    char name[64];
                    n = read_word_a(&p, name, (int)sizeof(name));
                    (void)n;
                    pc += 4;
                } else {
                    ArmMemOp m1;
                    parse_memop_a(a, &p, &m1, 1);
                    pc += ldr_str_size2_a(kind1, rt1, &m1);
                }
            } else if (strieq_a(first, "MOV")) {
                /* Same rule as pass 2: the 16-bit form only covers r0-r7 with
                 * an 8-bit immediate; everything else is MOVW (4 bytes). */
                int rd1 = parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == ',') { p++; skip_space_a(&p); }
                if (*p == '#') {
                    unsigned u1 = 0;
                    (void)parse_imm_u32_a(&p, &u1);
                    /* Same rule as pass 2: MOVS r0-r7,#imm8 is 2 bytes, every
                     * other immediate shape (MOVW, MOV.W, MVN) is 4. */
                    pc += (rd1 >= 0 && rd1 <= 7 && u1 <= 255u) ? 2 : 4;
                } else {
                    (void)parse_reg_a(&p);
                    pc += 2;
                }
            } else if (strieq_a(first, "PUSH") || strieq_a(first, "POP")) {
                /* PUSH/POP may be 16-bit T1 (r0-r7 + lr/pc only) or 32-bit T2
                 * (includes r8-r12); size determined by the register list to keep pass1 offsets correct. */
                int has_lr = 0, has_pc = 0;
                int list = parse_reglist_a(a, &p, &has_lr, &has_pc);
                /* The 16-bit form has one bit that is LR in PUSH and PC in POP,
                 * so PUSH{..,pc} and POP{..,lr} only exist as T2 and are twice
                 * as wide.  Pass 2 makes the same decision; if the two ever
                 * disagree every label after this line moves. */
                if (strieq_a(first, "PUSH")) {
                    if (has_pc)                    pc += 0;   /* not encodable */
                    else if (list & 0x1F00)        pc += 4;   /* T2 */
                    else                           pc += 2;   /* T1 */
                } else {
                    if ((list & 0x1F00) || has_lr) pc += 4;   /* T2 */
                    else                           pc += 2;   /* T1 */
                }
            } else if (strieq_a(first, "ADD") || strieq_a(first, "SUB") ||
                       strieq_a(first, "ADDS") || strieq_a(first, "SUBS")) {
                /* ADD/SUB rd, rn, #imm: T1 (2 bytes) if imm<=7 and low regs,
                 * T3 (4 bytes) if imm>7 or high regs. Keep pass1 in sync with pass2.
                 * The flag-setting aliases ADDS/SUBS use the same widths. */
                int rd = parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == ',') { p++; skip_space_a(&p); }
                int rn = parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == ',') { p++; skip_space_a(&p); }
                if (*p == '#') {
                    int imm = parse_imm_a(&p);
                    if (rn < 0) rn = rd;                       /* two-operand form */
                    if (rd == 13 && rn == 13)                  /* ADD/SUB sp, #imm7*4 */
                        pc += (imm >= 0 && imm <= 508 && (imm & 3) == 0) ? 2 : 4;
                    else if (rd == rn && rd >= 0 && rd <= 7 &&
                             imm >= 0 && imm <= 255) pc += 2;  /* rd, #imm8 */
                    else if (imm >= 0 && imm <= 7 && rd >= 0 && rd <= 7 && rn >= 0 && rn <= 7)
                        pc += 2;                               /* T1 3-bit imm */
                    else pc += 4;                              /* ADDW / SUBW */
                } else {
                    /* Register forms: the 16-bit encodings only name r0-r7.
                     * ADD with Rd == Rn has a 16-bit form for every register;
                     * SUB has one only for low registers.  Same rule as pass 2. */
                    int rm1 = parse_reg_a(&p);
                    /* Two-operand `ADD/SUB Rd, Rm` doubles Rd as the source, so
                     * the register parsed as "rn" above is the source operand.
                     * Widths, exactly as pass 2 encodes them:
                     *   ADD (no flags)  -> 0x4400 T2, two bytes for ANY two
                     *                      registers, high ones included;
                     *   everything else -> two bytes only when both operands
                     *                      are r0-r7, four otherwise. */
                    int sets1 = strieq_a(first, "ADDS") || strieq_a(first, "SUBS");
                    int is_add1 = strieq_a(first, "ADD") || strieq_a(first, "ADDS");
                    if (rm1 < 0) {
                        if (is_add1 && !sets1)                             pc += 2;
                        else if (rd >= 0 && rd <= 7 && rn >= 0 && rn <= 7) pc += 2;
                        else                                               pc += 4;
                    } else if (rd >= 0 && rd <= 7 && rn >= 0 && rn <= 7 &&
                               rm1 >= 0 && rm1 <= 7)                       pc += 2;
                    else                                                       pc += 4;
                }
            } else if (strieq_a(first, "MUL") || strieq_a(first, "LSL") ||
                       strieq_a(first, "LSR") || strieq_a(first, "ASR")) {
                /* The 16-bit forms of MUL and of the shifts name r0-r7 only.
                 * A high register forces the 32-bit encoding, so pass 1 has to
                 * look at the registers instead of assuming two bytes -- the
                 * same rule pass 2 applies.  (It used to assume two bytes and
                 * pass 2 masked with 7, so "LSL r9, r9, #2" assembled as
                 * "LSLS r1, r1, #2": a silent wrong answer produced by this
                 * compiler's own -fopt-vreg renaming.) */
                int wide1;
                if (strieq_a(first, "MUL")) {
                    int rd1 = parse_reg_a(&p), rn1, rm1, second1;
                    eat_comma_a(&p); second1 = parse_reg_a(&p);
                    skip_space_a(&p);
                    if (*p == ',') { rn1 = second1; eat_comma_a(&p); rm1 = parse_reg_a(&p); }
                    else           { rn1 = rd1;     rm1 = second1; }
                    /* 16-bit MULS requires Rd == Rn and r0-r7; everything
                     * else (including three distinct registers) is the 32-bit
                     * T2 form.  This used to ignore rn1, so "MUL r1, r2, r3"
                     * was laid out at two bytes while pass 2 wrote four. */
                    wide1 = !(rd1 >= 0 && rd1 <= 7 && rn1 == rd1 &&
                              rm1 >= 0 && rm1 <= 7);
                } else {
                    int rd1 = parse_reg_a(&p), rm1, rs1 = -1;
                    eat_comma_a(&p); rm1 = parse_reg_a(&p);
                    skip_space_a(&p);
                    if (*p == ',') {
                        p++; skip_space_a(&p);
                        if (*p == '#') (void)parse_imm_a(&p);
                        else           rs1 = parse_reg_a(&p);
                    }
                    wide1 = !(rd1 >= 0 && rd1 <= 7 && rm1 >= 0 && rm1 <= 7 &&
                              (rs1 < 0 || rs1 <= 7));
                }
                pc += wide1 ? 4 : 2;
            } else if (strieq_a(first, "NEG") || strieq_a(first, "RSB")) {
                /* NEG Rd, Rm is RSB Rd, Rm, #0; the 16-bit form names r0-r7
                 * only, so a high register takes the 32-bit RSB. */
                int rd1 = parse_reg_a(&p), rm1;
                eat_comma_a(&p); rm1 = parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == ',') { p++; skip_space_a(&p); if (*p == '#') (void)parse_imm_a(&p); pc += 4; }
                else pc += (rd1 >= 0 && rd1 <= 7 && rm1 >= 0 && rm1 <= 7) ? 2 : 4;
            } else if (strieq_a(first, "LSLS") || strieq_a(first, "LSRS") ||
                       strieq_a(first, "ASRS")) {
                /* --asm-extra: 16-bit immediate / 16-bit two-operand register form,
                 * 32-bit only when a separate shift register is named.  Getting this
                 * wrong shifts every later label by 2 bytes, so it is decided the
                 * same way pass 2 decides it. */
                int third_is_reg = 0;
                (void)parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == ',') { p++; skip_space_a(&p); }
                (void)parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == ',') {
                    p++; skip_space_a(&p);
                    if (*p != '#') third_is_reg = 1;
                }
                pc += third_is_reg ? 4 : 2;
            } else if (strieq_a(first, "CMP")) {
                /* CMP Rn, #imm: T1 (2B) for imm 0-255, T2 (4B) for larger.
                 * CMP Rn, Rm: T2 (2B) names r0-r15 in Rn but only r0-r7 in
                 * Rm, so a high Rm takes the 32-bit form.  Assuming two bytes
                 * for every register form used to truncate r8-r11 to their low
                 * three bits (measured: "CMP r9, r7" became "CMP r1, r7").
                 * ONLY Rn is three bits wide in both 16-bit forms; the N bit
                 * of "01000101 N Rm Rn" carries bit 3 of Rm. */
                int rn = parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == ',') { p++; skip_space_a(&p); }
                if (*p == '#') {
                    int imm = parse_imm_a(&p);
                    if (rn >= 0 && rn <= 7 && imm >= 0 && imm <= 255) pc += 2;
                    else pc += 4;
                } else {
                    (void)parse_reg_a(&p);
                    pc += (rn >= 0 && rn <= 7) ? 2 : 4;
                }
            } else if (strieq_a(first, "MOVEQ") || strieq_a(first, "MOVNE") ||
                       strieq_a(first, "MOVLT") || strieq_a(first, "MOVGT") ||
                       strieq_a(first, "MOVLE") || strieq_a(first, "MOVGE") ||
                       strieq_a(first, "MOVLO") || strieq_a(first, "MOVHI") ||
                       strieq_a(first, "MOVLS") || strieq_a(first, "MOVHS") ||
                       strieq_a(first, "MOVCS") || strieq_a(first, "MOVCC")) {
                /* Conditional MOV in IT block: immediate form uses 32-bit MOV.W
                 * (4 bytes, no flag modification); register form uses 16-bit (2 bytes). */
                int rd = parse_reg_a(&p);
                (void)rd;
                skip_space_a(&p);
                if (*p == ',') { p++; skip_space_a(&p); }
                if (*p == '#') {
                    (void)parse_imm_a(&p);
                    pc += 4;  /* 32-bit MOV.W */
                } else {
                    (void)parse_reg_a(&p);
                    pc += 2;  /* 16-bit MOV */
                }
            } else if (strieq_a(first, "AND") || strieq_a(first, "ORR") ||
                       strieq_a(first, "EOR") || strieq_a(first, "BIC") ||
                       strieq_a(first, "MVN")) {
                /* Same decision function as pass 2: the 16-bit form only
                 * covers two low registers, so a high register or an
                 * immediate operand makes the instruction 4 bytes. */
                pc += logic_dp_a(a, first, &p, 0);
            } else if (strieq_a(first, "TST") ||
                       strieq_a(first, "SXTB") || strieq_a(first, "SXTH") ||
                       strieq_a(first, "UXTB") || strieq_a(first, "UXTH")) {
                /* Two-register forms: 16-bit T1 for r0-r7 operands, 32-bit T2
                 * when either register is high (r8-r15). Must match pass2. */
                int rd = parse_reg_a(&p);
                eat_comma_a(&p);
                {
                    int rm = parse_reg_a(&p);
                    if (rd >= 0 && rd <= 7 && rm >= 0 && rm <= 7) pc += 2;
                    else                                          pc += 4;
                }
            } else if (strieq_a(first, "MOVS")) {
                /* MOVS Rd,#imm: 16-bit for rd in r0-r7 and imm 0..255.
                 * MOVS Rd,Rm  : 16-bit for two low registers.
                 * Everything else takes the 32-bit form. */
                int rd = parse_reg_a(&p);
                eat_comma_a(&p);
                if (*p == '#') {
                    int imm = parse_imm_a(&p);
                    if (rd >= 0 && rd <= 7 && imm >= 0 && imm <= 255) pc += 2;
                    else                                              pc += 4;
                } else {
                    int rm = parse_reg_a(&p);
                    if (rd >= 0 && rd <= 7 && rm >= 0 && rm <= 7) pc += 2;
                    else                                          pc += 4;
                }
            } else if (strieq_a(first, "SVC")) {
                pc += 2;
            } else if (strieq_a(first, "PUSH") || strieq_a(first, "POP")) {
                /* PUSH/POP are STMDB/LDMIA on sp.  They were not in this
                 * chain at all, so pass 1 took the op_size_a() default of 2
                 * bytes even when pass 2 emitted the 32-bit form -- and the
                 * 32-bit form is exactly what a high register forces:
                 * "POP {ip}" is e8bd 1000.  Every such push/pop shifted every
                 * later label by 2, and because cross-object/label branches
                 * are resolved from pass-1 label addresses against pass-2
                 * code offsets, the branches landed past their target
                 * (measured: a bss-clear loop whose "BNE" jumped to its own
                 * CMP instead of the store, once a call through a function
                 * pointer added a "POP {ip}"). */
                int has_lr1 = 0, has_pc1 = 0, list1;
                list1 = parse_reglist_a(a, &p, &has_lr1, &has_pc1);
                if ((list1 & ~0xFF) == 0) pc += 2;
                else                      pc += 4;
            } else if (strieq_a(first, "LDMIA") || strieq_a(first, "LDM") ||
                       strieq_a(first, "STMIA") || strieq_a(first, "STM") ||
                       strieq_a(first, "LDMDB") || strieq_a(first, "STMDB")) {
                /* The 16-bit T1 form is available only for: base inside
                 * r0-r7, register list inside r0-r7, writeback present and
                 * increment-after addressing.  Everything else takes the
                 * 32-bit T2 form.  Pass 1 has to make the same decision as
                 * pass 2, or every later label in the file shifts by 2. */
                int rn = parse_reg_a(&p);
                int has_wb = 0, has_lr1 = 0, has_pc1 = 0, list1;
                int is_db1 = (first[3] == 'D' || first[3] == 'd');
                skip_space_a(&p);
                if (*p == '!') { has_wb = 1; p++; }
                eat_comma_a(&p);
                list1 = parse_reglist_a(a, &p, &has_lr1, &has_pc1);
                if (has_wb && !is_db1 && !has_lr1 && !has_pc1 &&
                    rn >= 0 && rn <= 7 && list1 != 0 && (list1 & ~0xFF) == 0)
                    pc += 2;
                else
                    pc += 4;
            }
#if ARKCC_FEATURE_OPT_BRANCH
            else if (a->plan_branches && branch_cond_a(first) >= -1) {
                /* -fopt-branch: remember the site in the all-32-bit
                 * layout; the decision is taken after this pass. */
                char bname[64];
                int bcond = branch_cond_a(first);
                read_label_name_a(&p, bname, sizeof(bname));
                /* The second recording round sees the decided flags and
                 * must lay the branch out at its final width, or every
                 * label after it would keep an address pass 2 no longer
                 * matches. */
                pc += add_branch_a(a, pc, bcond, bname) ? 2 : 4;
            }
#endif
            else {
                pc += op_size_a(first);
            }
        }
        skip_to_eol_a(&p);
        if (*p == '\n') p++;
    }
    /* LDR =label uses MOVW+MOVT (8 bytes), no literal pool needed */
    a->literal_pool_start = -1;
    a->pass1_size = pc;
#if defined(ARKCC_ASM_SIZECHECK_PROBE)
    /* Test-only: deliberately make the two passes disagree so the check below
     * can be shown to fire.  Compiled out of every real build (OFF IS OFF). */
    a->pass1_size += 2;
#endif
}

static int parse_reglist_a(ArmAsm *a, const char **p, int *has_lr, int *has_pc) {
    int list = 0;
    *has_lr = 0; *has_pc = 0;
    skip_space_a(p);
    if (**p != '{') return 0;
    (*p)++;
    while (**p && **p != '}') {
        int lo, hi, r;
        skip_space_a(p);
        if (**p == 0 || **p == '}') break;
        lo = parse_reg_a(p);
        if (lo < 0 || lo > 15) {
            /* Refuse rather than guess: a wrong register list is a wrong
             * prologue, i.e. a corrupted stack, and nothing downstream -- not
             * the assembler, not the linker, not the CPU -- would notice. */
            if (a && a->pass2) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "register list: expected r0-r15, lr, pc, sp, ip or fp", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            if (**p && **p != '}' && **p != ',' && **p != '\n') (*p)++;  /* skip unknown char */
            skip_space_a(p);
            if (**p == ',') (*p)++;
            continue;
        }
        hi = lo;
        skip_space_a(p);
        if (**p == '-') {
            /* rN-rM ranges are the ordinary way to name a callee-saved set.
             * This parser used to skip the '-' as an unknown character and
             * keep only the two endpoints: "PUSH {r4-r7, lr}" was encoded as
             * {r4, r7, lr} (b590), so r5/r6 were never saved and were restored
             * from whatever the frame happened to hold.  A silent wrong
             * answer in the prologue is the worst place for one. */
            (*p)++;
            skip_space_a(p);
            hi = parse_reg_a(p);
            if (hi < lo || hi > 15) {
                if (a && a->pass2) {
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "register list: descending or out-of-range register range", 0,0,0,0,0,0);
                    a->hard_errors++;
                }
                hi = lo;          /* keep the list well formed; the error stands */
            }
        }
        for (r = lo; r <= hi; r++) list |= (1 << r);
        skip_space_a(p);
        if (**p == ',') (*p)++;
    }
    if (**p == '}') (*p)++;
    if (list & (1 << 14)) *has_lr = 1;   /* lr / pc are also reachable as r14 / r15 */
    if (list & (1 << 15)) *has_pc = 1;
    return list;
}

/* Pre-indexed writeback (`[Rn, #imm]!`) and post-indexed addressing
 * (`[Rn], #imm`) have no encoder here.  Both are easy to ignore by accident:
 * the offset is consumed, the ']' ends the operand, and the instruction is
 * emitted as a plain access -- which silently drops the writeback.  Refuse
 * them instead, so the author writes the ADD out.
 * Called right after the closing ']' has been consumed. */
static void check_no_index_writeback_a(ArmAsm *a, const char **p) {
    skip_space_a(p);
    if (**p == '!') {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "pre-indexed writeback ([Rn, #imm]!) is not emitted; do the "
                  "address update with a separate ADD", 0,0,0,0,0,0);
        a->hard_errors++;
        (*p)++;
    } else if (**p == ',') {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "post-indexed addressing ([Rn], #imm) is not emitted; do the "
                  "address update with a separate ADD", 0,0,0,0,0,0);
        a->hard_errors++;
    }
}

static void emit_bl_a(ArmAsm *a, int target) {
    int offset = target - a->pc - 4;
    int off2 = offset >> 1;
    int s = (off2 >> 23) & 1;
    int i1 = (off2 >> 22) & 1;
    int i2 = (off2 >> 21) & 1;
    int imm10 = (off2 >> 11) & 0x3FF;
    int imm11 = off2 & 0x7FF;
    int j1 = (~(i1 ^ s)) & 1;
    int j2 = (~(i2 ^ s)) & 1;
    unsigned hi = 0xF000u | (unsigned)(s << 10) | (unsigned)imm10;
    unsigned lo = 0xD000u | (unsigned)(j1 << 13) | (unsigned)(j2 << 11) | (unsigned)imm11;
    out16(a, hi);
    out16(a, lo);
}

/* 32-bit unconditional B.W (T4 encoding) - range +-16MB.
 * hi: 0xF000 | (S<<10) | imm10
 * lo: 10 J1 1 J2 imm11  (bits[15:14]=10, bit12=1 for T4)
 *     BL T1 has bits[15:14]=11 (0xD000 base) - distinct from B.W
 * imm32 = SignExtend(S:I1:I2:imm10:imm11:0, 25)
 * NOTE: lo base MUST be 0x9000 (bit14=0, bit12=1). Using 0xD000
 * (bit14=1) encodes BL T1, which still branches but corrupts LR. */
static void emit_b_w_a(ArmAsm *a, int target) {
    int offset = target - a->pc - 4;
    int off2 = offset >> 1;
    int s = (off2 >> 23) & 1;
    int i1 = (off2 >> 22) & 1;
    int i2 = (off2 >> 21) & 1;
    int imm10 = (off2 >> 11) & 0x3FF;
    int imm11 = off2 & 0x7FF;
    int j1 = (~(i1 ^ s)) & 1;
    int j2 = (~(i2 ^ s)) & 1;
    unsigned hi = 0xF000u | (unsigned)(s << 10) | (unsigned)imm10;
    unsigned lo = 0x9000u | (unsigned)(j1 << 13) | (unsigned)(j2 << 11) | (unsigned)imm11;
    out16(a, hi);
    out16(a, lo);
}

/* 32-bit conditional B<cond>.W (T3 encoding) - range +-1MB.
 * hi: 0xF000 | (S<<10) | (cond<<6) | imm6
 * lo: 1 0 J1 0 J2 imm11[10:0]  (bit15=1, bit14=0, bit12=0 for T3)
 *     T4 B.W has lo bit12=1 (0x9000 base) — distinguishes from T3.
 *     BL T1  has lo bit14=1,bit12=1 (0xD000 base) — also different.
 * imm32 = SignExtend(S:I1:I2:imm6:imm11, 20) << 1
 * NOTE: T3 and T4 share the same hw2 bit layout (J1 at bit13, J2 at bit11,
 *       imm11 at bits[10:0]), but DIFFERENT J1/J2 decoding:
 *       - T4/BL: I1 = NOT(J1 EOR S)  (inverted)
 *       - T3:    I1 = J1             (direct copy, NO inversion)
 *       Verified empirically via MDK armasm:
 *         MDK forward BEQ.W = 0xF000 0x8046 (J1=0, J2=0) for offset +0x8C.
 *         With T4 formula that would give offset 0x18008C (wrong).
 *         With T3 formula (I1=J1) it gives offset 0x8C (correct).
 *       Using the T4 formula for T3 causes forward conditional branches to
 *       jump ~786KB forward (outside flash) → HardFault. */
static void emit_bcond_w_a(ArmAsm *a, int cond, int target) {
    int offset = target - a->pc - 4;
    int off2 = offset >> 1;
    int s = (off2 >> 19) & 1;
    int i1 = (off2 >> 18) & 1;
    int i2 = (off2 >> 17) & 1;
    int imm6 = (off2 >> 11) & 0x3F;
    int imm11 = off2 & 0x7FF;
    int j1 = i1;
    int j2 = i2;
    unsigned hi = 0xF000u | (unsigned)(s << 10) | (unsigned)(cond << 6) | (unsigned)imm6;
    /* T3 lo word: bit15=1, bit14=0, bit13=J1, bit12=0, bit11=J2, bits[10:0]=imm11 */
    unsigned lo = 0x8000u | (unsigned)(j1 << 13) | (unsigned)(j2 << 11) | (unsigned)imm11;
    out16(a, hi);
    out16(a, lo);
}

static int read_label_name_a(const char **p, char *buf, int cap) {
    int n = 0;
    skip_space_a(p);
    /* '\r' is a delimiter too: a CRLF source line ends the symbol here.
     * Leaving it out put the CR into the name, so a .s file uploaded with
     * CRLF produced relocations for "sym\r" that no definition matched
     * (measured on the board: aeabi_div.o referenced "__ark_udiv64\r"). */
    while (**p && **p != ' ' && **p != '\t' && **p != '\n' && **p != '\r' && **p != ';' && **p != ',' && n < cap - 1) {
        buf[n++] = **p; (*p)++;
    }
    buf[n] = 0;
    return n;
}

/* Reverse of the Thumb-2 ThumbExpandImm() function: split a 32-bit
 * constant into the (i, imm3, imm8) fields of a modified immediate.
 *   rot = i:imm3;   unrotated = ZeroExtend('1':imm8[6:0], 32)
 *   value = ROR(unrotated, rot * 8),  rot = 1..15
 *   rot == 0      : value = ZeroExtend(imm8)
 * Returns 1 when the constant is representable, 0 otherwise. Used by the
 * MOVS/CMP.W immediate forms so an unrepresentable constant is reported
 * instead of being silently truncated to 8 bits.
 *
 * Two details of the spec this used to get wrong.  Both only ever showed up
 * in --object mode: -S writes text that GNU as accepts, while the internal
 * assembler runs this check and turned a legal constant into a hard error.
 * `EOR r0, r0, #0x80000000` (what a double negation emits) was the first
 * thing to hit it.
 *
 *   - the unrotated value is '1':imm8[6:0] ZERO-EXTENDED, not bit7
 *     replicated into bits 31:8.  Building 0xFFFFFF00|imm8 made the
 *     round-trip check `ROR(cand, sh) == val` fail for every constant that
 *     needed a rotation, and made it succeed for values that are NOT
 *     representable (0xFFFFFF80 and its two rotations) -- i.e. the old check
 *     rejected everything legal and accepted four illegal constants.
 *   - rot is four bits (i:imm3) and counts *bits*, not bytes: the field
 *     goes into the instruction unchanged and the core rotates by exactly
 *     that many bits.  0x80000000 is ROR(0x80, 8), i.e. rot=8, imm8=0x80.
 *     Treating rot as 8-bit units made 0x8X000000/0x0000XX00 silently wrong. */
/* ThumbExpandImm_C, verified against *all* 4096 values of imm12 by running
 * each encoding ("movs.w r0,#imm12") on an ARM core model and comparing the
 * result.  Two properties the hand-written version got wrong, both of which
 * silently produced a different constant instead of an error:
 *
 *   - the four byte-pattern cases (imm12<11:10> == 00) put the byte at
 *     positions 0 / 0+2 / 1+3 / 0+1+2+3, i.e. imm8*0x00010001 and
 *     imm8*0x01000100 -- not "imm8<<8" and "imm8<<16|imm8".
 *   - in the general form the rotate count is FIVE bits, imm12<11:7>, and the
 *     constant is built from '1':imm12<6:0>.  So imm12<7> does not belong to
 *     the constant at all, it rotates it, and the constant only carries seven
 *     bits.  0x80000000 is rot=8 with imm8=0x00 (armasm: f080 4000), 0xFF00
 *     is rot=24 with imm8=0x7F (armasm: f440 407f).  The old code wrote the
 *     rotate into imm12<11:8> and took imm8 as eight bits, so
 *     "EOR r0,r0,#0x80000000" (double negation) came out as a legal-looking
 *     instruction holding a completely different constant.  Only --object
 *     mode reaches this encoder: -S writes text, so the image was wrong while
 *     the assembly looked right. */
static unsigned thumb_expand_imm_a(unsigned imm12) {
    unsigned imm8 = imm12 & 0xFFu;

    if (((imm12 >> 10) & 3u) == 0) {          /* byte pattern forms */
        switch ((imm12 >> 8) & 3u) {
        case 0:  return imm8;
        case 1:  return imm8 * 0x00010001u;
        case 2:  return imm8 * 0x01000100u;
        default: return imm8 * 0x01010101u;
        }
    }
    {
        unsigned v = 0x80u | (imm12 & 0x7Fu);   /* '1':imm12<6:0> */
        unsigned r = (imm12 >> 7) & 0x1Fu;      /* imm12<11:7> */

        if (r == 0) return v;
        return ((v >> r) | (v << (32u - r))) & 0xFFFFFFFFu;
    }
}

static int thumb_imm12_a(unsigned val, unsigned *out_i, unsigned *out_imm3,
                         unsigned *out_imm8) {
    unsigned imm12 = 0, found = 0, r;

    /* The byte patterns come first: they reach constants (0x0000FF00,
     * 0x01020300-style spreads) that no rotation of an 8-bit value can. */
    if ((val & 0xFFFFFF00u) == 0) {
        imm12 = val;                                        /* pos 0 */
        found = 1;
    } else if ((val & 0xFF00FF00u) == 0 &&
               ((val >> 16) & 0xFFu) == (val & 0xFFu) && (val & 0xFFu) != 0) {
        imm12 = (1u << 8) | (val & 0xFFu);                   /* pos 1 */
        found = 1;
    } else if ((val & 0x00FF00FFu) == 0 &&
               ((val >> 24) & 0xFFu) == ((val >> 8) & 0xFFu) &&
               ((val >> 8) & 0xFFu) != 0) {
        imm12 = (2u << 8) | ((val >> 8) & 0xFFu);            /* pos 2 */
        found = 1;
    } else if (val != 0 && (val & 0xFFu) == ((val >> 8) & 0xFFu) &&
               (val & 0xFFu) == ((val >> 16) & 0xFFu) &&
               (val & 0xFFu) == ((val >> 24) & 0xFFu)) {
        imm12 = (3u << 8) | (val & 0xFFu);                   /* pos 3 */
        found = 1;
    }

    /* General form: val = ROR('1':imm12<6:0>, imm12<11:7>), so look for the
     * rotation that brings the constant back into one byte with bit 7 set. */
    for (r = 1; !found && r < 32; r++) {
        unsigned unrot = ((val << r) | (val >> (32u - r))) & 0xFFFFFFFFu;

        if ((unrot & 0xFFFFFF00u) != 0) continue;
        if ((unrot & 0x80u) == 0) continue;
        imm12 = (((r >> 1) & 0xFu) << 8) | ((r & 1u) << 7) | (unrot & 0x7Fu);
        found = 1;
    }

    if (!found) return 0;
    /* Never emit an encoding that does not decode back to the wanted value. */
    if (thumb_expand_imm_a(imm12) != (val & 0xFFFFFFFFu)) return 0;

    *out_i = (imm12 >> 11) & 1u;
    *out_imm3 = (imm12 >> 8) & 7u;
    *out_imm8 = imm12 & 0xFFu;
    return 1;
}

/* ADDW/SUBW (T4): a plain 12-bit immediate, 0000..4095, no rotation and no
 * flags.  This is the form for every immediate that the 16-bit encodings cannot
 * take: the T3 form takes a *modified* immediate (an 8-bit value rotated by an
 * even amount), so writing a raw 12-bit value into its i:imm3:imm8 fields
 * encodes a different number -- "SUB sp,#2016" used to come out as 480. */
static void emit_addw_a(ArmAsm *a, int is_sub, int rd, int rn, int imm) {
    unsigned i = ((unsigned)imm >> 11) & 1;
    unsigned imm3 = ((unsigned)imm >> 8) & 7;
    unsigned imm8 = (unsigned)imm & 0xFF;
    out16(a, (unsigned)(is_sub ? 0xF2A0 : 0xF200) | (i << 10) | (unsigned)(rn & 0xF));
    out16(a, (imm3 << 12) | ((unsigned)(rd & 0xF) << 8) | imm8);
}

/* ADD/SUB (register) T2: the 32-bit form, where every operand may be any of
 * r0-r15 (SP included).  The 16-bit T1 form only names r0-r7 and silently masks
 * the rest: "ADD ip, r6, ip" came out as "adds r4, r6, r4", and a base address
 * became a write into nothing.  Measured with arm-none-eabi-as:
 *   add.w ip, r6, ip = eb06 0c0c    sub.w sp, sp, r7 = ebad 0d07 */
static void emit_addsub_reg_w_a(ArmAsm *a, int is_sub, int rd, int rn, int rm) {
    out16(a, (unsigned)(is_sub ? 0xEBA0 : 0xEB00) | (unsigned)(rn & 0xF));
    out16(a, ((unsigned)(rd & 0xF) << 8) | (unsigned)(rm & 0xF));
}

/* MOVW: a plain 16-bit immediate into any register. */
static void emit_movw_a(ArmAsm *a, int rd, int imm) {
    unsigned ii = ((unsigned)imm >> 11) & 1;
    unsigned imm4 = ((unsigned)imm >> 12) & 0xF;
    unsigned imm3 = ((unsigned)imm >> 8) & 7;
    unsigned imm8 = (unsigned)imm & 0xFF;
    out16(a, 0xF240u | (ii << 10) | imm4);
    out16(a, (imm3 << 12) | ((unsigned)(rd & 0xF) << 8) | imm8);
}

#if ARKCC_FEATURE_ASM_VFP_LDSTM
/* --------------------- VFP multi-register load/store ---------------------
 * VLDMIA/VLDMDB/VSTMIA/VSTMDB/VPUSH/VPOP.  The encoding carries only "first
 * register + how many", so a register list must be a contiguous run -- {s0-s3}
 * or {s8, s9}, never {s0, s2}.  All bit patterns below were taken from
 * arm-none-eabi-as output (see tests/asm_cases/09_vfp_ldstm.s).
 *
 *   hw1 = 1110 110 P U D W L Rn          0xEC00 | P<<8 | U<<7 | D<<6 | W<<5 | L<<4 | Rn
 *   hw2 = Vd 101 1 imm8  (double)        0x0B00 | count*2
 *         Vd 101 0 imm8  (single)        0x0A00 | count
 * IA sets U, DB sets P; VPUSH is VSTMDB sp! and VPOP is VLDMIA sp!.
 * D16-D31 are reachable through the D bit, but they only exist on an FPU with
 * 32 double registers (fpv5-d32); on fpv5-d16 the hardware has d0-d15 only. */
typedef struct ArmVfpList {
    int first;      /* first register number, -1 = none */
    int count;      /* how many registers */
    int is_double;  /* d-registers rather than s-registers */
    int ok;
} ArmVfpList;

static int parse_vfp_num_a(const char **p) {
    int v = 0, seen = 0;
    while (**p >= '0' && **p <= '9') { v = v * 10 + (**p - '0'); (*p)++; seen = 1; }
    return seen ? v : -1;
}

static ArmVfpList parse_vfplist_a(ArmAsm *a, const char **p, int quiet) {
    ArmVfpList l;
    int last;
    l.first = -1; l.count = 0; l.is_double = 0; l.ok = 0;
    last = -1;
    skip_space_a(p);
    if (**p != '{') {
        if (!quiet) {
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "a VFP register list looks like {s0-s3} or {d0-d1}", 0,0,0,0,0,0);
            a->hard_errors++;
        }
        return l;
    }
    (*p)++;
    for (;;) {
        int start, end, is_dbl;
        skip_space_a(p);
        if (**p == '}') { (*p)++; break; }
        if (**p != 's' && **p != 'S' && **p != 'd' && **p != 'D') {
            if (!quiet) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "a VFP register list names s0-s31 or d0-d31", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            while (**p && **p != '}') (*p)++;
            if (**p == '}') (*p)++;
            l.count = 0;
            return l;
        }
        is_dbl = (**p == 'd' || **p == 'D');
        (*p)++;
        start = parse_vfp_num_a(p);
        skip_space_a(p);
        if (**p == '-') {
            (*p)++; skip_space_a(p);
            /* GAS writes the kind on both ends: {s0-s3}, not {s0-3}. */
            if (**p == 's' || **p == 'S' || **p == 'd' || **p == 'D') (*p)++;
            end = parse_vfp_num_a(p);
        }
        else            end = start;
        if (start < 0 || end < 0 || end < start) {
            if (!quiet) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "malformed VFP register range", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            while (**p && **p != '}') (*p)++;
            if (**p == '}') (*p)++;
            l.count = 0;
            return l;
        }
        if (l.first < 0) { l.first = start; l.is_double = is_dbl; }
        else if (is_dbl != l.is_double || start != last + 1) {
            /* One encoding = one contiguous run of one kind.  Anything else
             * would silently load the wrong registers. */
            if (!quiet) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "a VFP load/store list must be one contiguous run of "
                          "the same register kind ({s0-s3}, {d0-d1}); the "
                          "encoding has no way to name a gap", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            l.count = 0;
        }
        last = end;
        if (l.count >= 0 && l.first >= 0) l.count = last - l.first + 1;
        skip_space_a(p);
        if (**p == ',') (*p)++;
    }
    if (l.first >= 0) {
        int top = l.is_double ? 31 : 31;
        if (last < 0 || last > top) {
            if (!quiet) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "VFP register number out of range (s0-s31, d0-d31)", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            l.count = 0;
        }
        if (l.is_double && l.count > 16) {
            if (!quiet) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "a VFP store/load moves at most 16 double registers", 0,0,0,0,0,0);
                a->hard_errors++;
            }
        }
    }
    l.ok = (l.count > 0);
    return l;
}

static void emit_vfp_ldstm_a(ArmAsm *a, int is_load, int is_db, int wb, int rn,
                             const ArmVfpList *l) {
    unsigned hw1, hw2;
    int vd, dbit, words;
    if (!l->ok || rn < 0 || rn > 15) {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "VLDM/VSTM needs a base register and a register list", 0,0,0,0,0,0);
        a->hard_errors++;
        out16(a, 0xBF00); out16(a, 0xBF00);
        return;
    }
    if (l->is_double) {
        vd = l->first & 0xF;
        dbit = (l->first >> 4) & 1;
        words = l->count * 2;
    } else {
        vd = l->first >> 1;
        dbit = l->first & 1;
        words = l->count;
    }
    hw1 = 0xEC00u | (unsigned)(is_db ? 0x100 : 0) | (unsigned)(is_db ? 0 : 0x80) |
          (unsigned)(dbit << 6) | (unsigned)(wb ? 0x20 : 0) |
          (unsigned)(is_load ? 0x10 : 0) | (unsigned)(rn & 0xF);
    hw2 = ((unsigned)(vd & 0xF) << 12) |
          (unsigned)(l->is_double ? 0x0B00 : 0x0A00) | (unsigned)(words & 0xFF);
    out16(a, hw1);
    out16(a, hw2);
}

#endif /* ARKCC_FEATURE_ASM_VFP_LDSTM */

static void pass2_a(ArmAsm *a) {
    a->pass2 = 1;
    const char *p = a->src;
    a->pc = g_arm_vt_reserve ? ARM_VT_SIZE : 0;
    a->ref_count = 0;
    while (*p) {
        char first[64];
        int n;
        skip_space_a(&p);
        if (*p == '\n') { p++; continue; }
        if (*p == ';') { skip_to_eol_a(&p); continue; }
        if (*p == '\0') break;
        n = read_word_a(&p, first, (int)sizeof(first));
        canon_alias_a(first);
        if (n == 0) { skip_to_eol_a(&p); continue; }
        skip_space_a(&p);
        if (*p == ':') {
            p++;
            skip_space_a(&p);
            if (*p == '\n' || *p == ';' || *p == '\0') {
                if (*p == ';') skip_to_eol_a(&p);
                if (*p == '\n') p++;
                continue;
            }
            n = read_word_a(&p, first, (int)sizeof(first));
            canon_alias_a(first);
            if (n == 0) { skip_to_eol_a(&p); continue; }
        }
        if (first[0] == '.') {
            /* Pseudo-directives: emit data for .zero/.word/.byte/.asciz, skip metadata */
            if (strieq_a(first, ".set") || strieq_a(first, ".equ")) {
                /* Already processed in pass1; skip */
            } else if (strieq_a(first, ".zero") || strieq_a(first, ".skip") || strieq_a(first, ".space")) {
                int sz = 0;
                skip_space_a(&p);
                if (*p == '#') p++;
                while (*p >= '0' && *p <= '9') { sz = sz * 10 + (*p - '0'); p++; }
                while (sz > 0 && a->pc < a->out_cap) { a->out[a->pc++] = 0; sz--; }
            } else if (strieq_a(first, ".word") || strieq_a(first, ".long")) {
                /* Output 4-byte values (comma-separated).
                 * Bug-A5 FIX: Also resolve symbol names (e.g. .word funcname
                 * for .init_array/.fini_array constructor/destructor entries)
                 * by looking them up in the label table. Previously only
                 * numeric literals were parsed, so .word funcname emitted
                 * 0x00000000, causing constructor iteration to jump to
                 * address 0 and HardFault. */
                while (*p && *p != '\n') {
                    int val = 0;
                    skip_space_a(&p);
                    if (*p == '0' && (p[1] == 'x' || p[1] == 'X')) {
                        p += 2;
                        while ((*p >= '0' && *p <= '9') || (*p >= 'a' && *p <= 'f') || (*p >= 'A' && *p <= 'F')) {
                            char c = *p;
                            int v = (c >= '0' && c <= '9') ? c - '0' :
                                    (c >= 'a' && c <= 'f') ? c - 'a' + 10 : c - 'A' + 10;
                            val = val * 16 + v;
                            p++;
                        }
                    } else if (*p == '-') {
                        p++;
                        while (*p >= '0' && *p <= '9') { val = val * 10 + (*p - '0'); p++; }
                        val = -val;
                    } else if (*p >= '0' && *p <= '9') {
                        while (*p >= '0' && *p <= '9') { val = val * 10 + (*p - '0'); p++; }
                    } else {
                        /* Bug-A5: Token is a symbol name, not a number.
                         * Read the name and look it up in the label table. */
                        char sym_name[128];
                        int sn = 0;
                        while (*p && *p != ',' && *p != '\n' &&
                               *p != '\r' &&
                               *p != ' ' && *p != '\t' &&
                               sn < (int)sizeof(sym_name) - 1) {
                            sym_name[sn++] = *p++;
                        }
                        sym_name[sn] = 0;
                        if (sn > 0) {
                            int addr = find_label_a(a, sym_name);
                            if (addr < 0) addr = find_set_a(a, sym_name);
                            if (addr >= 0) {
                                val = addr;
                            } else {
                                /* Symbol not yet defined; record a 4-byte
                                 * absolute reference (type 4 = R_ARM_ABS32)
                                 * at the current pc for late resolution
                                 * by resolve_refs_a. */
                                add_ref_a(a, a->pc, sym_name, 4);
                            }
                        }
                    }
                    if (a->pc + 3 < a->out_cap) {
                        a->out[a->pc++] = (unsigned char)(val & 0xFF);
                        a->out[a->pc++] = (unsigned char)((val >> 8) & 0xFF);
                        a->out[a->pc++] = (unsigned char)((val >> 16) & 0xFF);
                        a->out[a->pc++] = (unsigned char)((val >> 24) & 0xFF);
                    }
                    skip_space_a(&p);
                    if (*p == ',') p++;
                }
            } else if (strieq_a(first, ".arkdata")) {
                /* --reloc-data: the next instruction is a MOVW/MOVT pair whose
                 * value is an address inside this unit's .data/.bss window.
                 * Record its code offset as relocation type 6 so -link can add
                 * the object's data delta when it has to move the window.
                 * Pass-1 ignores this directive: it occupies no bytes, so the
                 * offsets it records are the ones the image really has. */
                add_ref_a(a, a->pc, ".arkdata", 6);
            } else if (strieq_a(first, ".arkdatasym")) {
                /* --reloc-data, cross-object data reference: the MOVW/MOVT
                 * pair that follows must hold the address of the named global,
                 * which is defined in another object.  Record the site with
                 * the symbol name (type 15) so -link can resolve it after the
                 * data windows are placed.  Zero bytes, like .arkdata. */
                char sym_name[128];
                int sn = 0;
                skip_space_a(&p);
                while (*p && *p != ',' && *p != '\n' &&
                       *p != '\r' &&
                       *p != ' ' && *p != '\t' &&
                       sn < (int)sizeof(sym_name) - 1) {
                    sym_name[sn++] = *p++;
                }
                sym_name[sn] = 0;
                if (sn > 0)
                    add_ref_a(a, a->pc, sym_name, ARM_RELOC_DATA_SYM);
            } else if (strieq_a(first, ".byte")) {
                while (*p && *p != '\n') {
                    int val = 0;
                    skip_space_a(&p);
                    if (*p == '0' && (p[1] == 'x' || p[1] == 'X')) {
                        p += 2;
                        while ((*p >= '0' && *p <= '9') || (*p >= 'a' && *p <= 'f') || (*p >= 'A' && *p <= 'F')) {
                            char c = *p;
                            int v = (c >= '0' && c <= '9') ? c - '0' :
                                    (c >= 'a' && c <= 'f') ? c - 'a' + 10 : c - 'A' + 10;
                            val = val * 16 + v;
                            p++;
                        }
                    } else if (*p == '\'') {
                        p++;
                        val = *p;
                        p++;
                        if (*p == '\'') p++;
                    } else {
                        while (*p >= '0' && *p <= '9') { val = val * 10 + (*p - '0'); p++; }
                    }
                    if (a->pc < a->out_cap) a->out[a->pc++] = (unsigned char)(val & 0xFF);
                    skip_space_a(&p);
                    if (*p == ',') p++;
                }
            } else if (strieq_a(first, ".asciz") || strieq_a(first, ".ascii")) {
                int is_asciz = strieq_a(first, ".asciz");
                skip_space_a(&p);
                if (*p == '"') {
                    p++;
                    while (*p && *p != '"' && *p != '\n') {
                        unsigned char c;
                        if (*p == '\\') {
                            p++;
                            switch (*p) {
                                case 'n': c = '\n'; break;
                                case 't': c = '\t'; break;
                                case 'r': c = '\r'; break;
                                case '\\': c = '\\'; break;
                                case '"': c = '"'; break;
                                case '0': c = '\0'; break;
                                case 'x': {
                                    int hv = 0;
                                    p++;
                                    if (*p && ((*p >= '0' && *p <= '9') || (*p >= 'a' && *p <= 'f') || (*p >= 'A' && *p <= 'F'))) {
                                        char ch = *p;
                                        hv = (ch >= '0' && ch <= '9') ? ch - '0' :
                                             (ch >= 'a' && ch <= 'f') ? ch - 'a' + 10 : ch - 'A' + 10;
                                        p++;
                                        if (*p && ((*p >= '0' && *p <= '9') || (*p >= 'a' && *p <= 'f') || (*p >= 'A' && *p <= 'F'))) {
                                            ch = *p;
                                            hv = hv * 16 + ((ch >= '0' && ch <= '9') ? ch - '0' :
                                                 (ch >= 'a' && ch <= 'f') ? ch - 'a' + 10 : ch - 'A' + 10);
                                            p++;
                                        }
                                    }
                                    c = (unsigned char)hv;
                                    p--;  /* compensate for p++ below */
                                    break;
                                }
                                default: c = (unsigned char)*p; break;
                            }
                            p++;
                        } else {
                            c = (unsigned char)*p;
                            p++;
                        }
                        if (a->pc < a->out_cap) a->out[a->pc++] = c;
                    }
                    if (*p == '"') p++;
                }
                if (is_asciz) {
                    if (a->pc < a->out_cap) a->out[a->pc++] = 0;
                    /* Align to 2 to match pass1 */
                    if (a->pc & 1) { if (a->pc < a->out_cap) a->out[a->pc++] = 0; }
                } else {
                    if (a->pc & 1) { if (a->pc < a->out_cap) a->out[a->pc++] = 0; }
                }
            } else if (strieq_a(first, ".align") || strieq_a(first, ".balign")) {
                int align = 0;
                skip_space_a(&p);
                if (*p == '#') p++;
                while (*p >= '0' && *p <= '9') { align = align * 10 + (*p - '0'); p++; }
                if (align > 1) {
                    int rem = a->pc % align;
                    if (rem != 0) {
                        int pad = align - rem;
                        while (pad > 0 && a->pc < a->out_cap) { a->out[a->pc++] = 0; pad--; }
                    }
                }
            }
            /* .section, .data, .bss, .text, .global, .type, .size, .thumb, .file, .loc,
             * .cfi_* etc. are metadata-only, skip */
            skip_to_eol_a(&p);
            if (*p == '\n') p++;
            continue;
        }
        skip_space_a(&p);
        /* Optional width suffix: "adds.w", "b.n", "lsls.w".  GAS accepts it and
         * hand-written sources use it; without this the suffix is read as the
         * first operand and every such instruction encodes as garbage.  Only
         * W/N are width hints -- a dotted suffix like ".F32" belongs to the
         * mnemonic and is read by that mnemonic's own encoder. */
        if (*p == '.' && (my_toupper_a(p[1]) == 'W' || my_toupper_a(p[1]) == 'N') &&
            !is_alnum_a(p[2])) {
            p += 2;
            skip_space_a(&p);
        }

        if (strieq_a(first, "PUSH")) {
            int has_lr=0, has_pc=0;
            int list = parse_reglist_a(a, &p, &has_lr, &has_pc);
            if (has_pc) {
                /* STM never stores pc, and the 16-bit PUSH bit at 8 means LR.
                 * Dropping it would leave the reader believing pc was saved. */
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "PUSH cannot store pc (only lr has a bit in this form)",
                          0,0,0,0,0,0);
                a->hard_errors++;
            } else if (list & 0x1F00) {
                /* A single high register cannot use the block form: QEMU (and
                 * whatever rules its Thumb-2 decoder follows) rejects
                 * "stmdb sp!, {r8}" = e92d 0100 outright, and GNU as itself
                 * canonicalises "pop {ip}" to the single-register form below
                 * rather than to e8bd 1000.  Both encodings are 4 bytes, so
                 * pass 1 does not have to know which one is chosen. */
                if ((list & (list - 1)) == 0 && !has_lr) {
                    int rt = 0;
                    while (rt < 16 && !(list & (1 << rt))) rt++;
                    out16(a, 0xF84D);
                    out16(a, ((unsigned)(rt & 0xF) << 12) | 0x0D00u | 4u);
                } else {
                    /* T2 STMDB SP!: can encode r0-r12 + lr */
                    unsigned w2 = (unsigned)(has_lr ? 0x4000 : 0) | (unsigned)(list & 0x1FFF);
                    out16(a, 0xE92D); out16(a, w2);
                }
            } else {
                out16(a, 0xB400 | (has_lr ? 0x0100 : 0) | (list & 0xFF));
            }
        }
        else if (strieq_a(first, "POP")) {
            int has_lr=0, has_pc=0;
            int list = parse_reglist_a(a, &p, &has_lr, &has_pc);
            /* The 16-bit POP has one bit at 8 and it means PC, not LR: the two
             * cannot be expressed in T1 at all.  This used to drop the register
             * on the floor (POP {r5,r6,r7,lr} assembled to bce0, i.e.
             * POP {r5,r6,r7}), which is a silently wrong return sequence -- the
             * variadic epilogue is exactly that shape and lost 4 bytes of stack
             * plus the restored lr on every return.  Refuse the impossible
             * combination instead of picking one. */
            if (has_lr && has_pc) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "POP cannot load both lr and pc", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            if ((list & 0x1F00) || has_lr) {
                /* Single high register: see the note on PUSH above.  "POP {ip}"
                 * is emitted by the indirect-call path, and e8bd 1000 does not
                 * execute (measured: UC_ERR_INSN_INVALID), so use
                 * "ldr.w Rt, [sp], #4" = f85d t004. */
                if ((list & (list - 1)) == 0 && !has_pc && !has_lr) {
                    int rt = 0;
                    while (rt < 16 && !(list & (1 << rt))) rt++;
                    out16(a, 0xF85D);
                    out16(a, ((unsigned)(rt & 0xF) << 12) | 0x0B00u | 4u);
                } else {
                    /* T2 LDMIA SP!: can encode r0-r12 + lr or pc */
                    unsigned w2 = (unsigned)(has_pc ? 0x8000 : 0) |
                                  (unsigned)(has_lr ? 0x4000 : 0) |
                                  (unsigned)(list & 0x1FFF);
                    out16(a, 0xE8BD); out16(a, w2);
                }
            } else {
                out16(a, 0xBC00 | (has_pc ? 0x0100 : 0) | (list & 0xFF));
            }
        }
        else if (strieq_a(first, "MOV")) {
            int rd = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                unsigned u = 0, i = 0, imm3 = 0, imm8 = 0;
                (void)parse_imm_u32_a(&p, &u);
                if (rd >= 0 && rd <= 7 && u <= 255u) {
                    out16(a, 0x2000 | ((rd & 7) << 8) | (int)u);  /* MOVS rd, #imm8 */
                } else if (u <= 0xFFFFu) {
                    /* 16-bit MOVS cannot name r8-r15 and its imm8 would turn
                     * "MOV r0, #300" into 44.  MOVW carries the whole value
                     * into any register (and does not touch the flags). */
                    emit_movw_a(a, rd, (int)u);
                } else if (thumb_imm12_a(u, &i, &imm3, &imm8)) {
                    /* MOV.W rd, #modified-imm: 11110 i 0 0010 0 S 1111 |
                     * 0 imm3 Rd imm8, S = 0 so it is safe inside an IT block
                     * (a 16-bit MOVS there is UNPREDICTABLE on ARMv7-M). */
                    out16(a, 0xF04Fu | ((i & 1u) << 10));
                    out16(a, ((imm3 & 7u) << 12) | ((unsigned)(rd & 0xF) << 8) | imm8);
                } else {
                    char b1[12];
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "MOV immediate is out of range (a 16-bit value or "
                              "a modified immediate) at code offset %s",
                              diag_num(b1, a->pc), 0,0,0,0,0);
                    a->hard_errors++;
                    emit_movw_a(a, rd < 0 ? 0 : rd, 0);
                }
            } else {
                int rm = parse_reg_a(&p);
                out16(a, 0x4600 | (((rd >> 3) & 1) << 7) | ((rm & 0xF) << 3) | (rd & 7));
            }
        }
        else if (strieq_a(first, "MOVEQ") || strieq_a(first, "MOVNE") ||
                 strieq_a(first, "MOVLT") || strieq_a(first, "MOVGT") ||
                 strieq_a(first, "MOVLE") || strieq_a(first, "MOVGE") ||
                 strieq_a(first, "MOVLO") || strieq_a(first, "MOVHI") ||
                 strieq_a(first, "MOVLS") || strieq_a(first, "MOVHS") ||
                 strieq_a(first, "MOVCS") || strieq_a(first, "MOVCC")) {
            /* Conditional MOV in IT block.
             * Immediate form: 32-bit MOV.W Rd, #imm8 (0xF04F base, no S bit,
             *   avoids UNPREDICTABLE MOVS-in-IT-block on ARMv7-M).
             * Register form: 16-bit MOV Rd, Rm (0x4600, no S bit, safe in IT). */
            int rd = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                /* 32-bit T2 MOV.W: 1111 0 i 0 0010 0 S 1111 | 0 imm3 Rd imm8
                 * For imm 0-255: i=0, imm3=0, S=0, Rn=1111 (MOV alias) */
                unsigned hi = 0xF04Fu;
                unsigned lo = ((unsigned)(rd & 0xF) << 8) | (unsigned)(imm & 0xFF);
                out16(a, hi);
                out16(a, lo);
            } else {
                int rm = parse_reg_a(&p);
                out16(a, 0x4600 | (((rd >> 3) & 1) << 7) | ((rm & 0xF) << 3) | (rd & 7));
            }
        }
        else if (strieq_a(first, "MOVW")) {
            int rd = parse_reg_a(&p);
            int imm;
            eat_comma_a(&p);
            imm = parse_imm_a(&p) & 0xFFFF;
            {
                unsigned ii = (imm >> 11) & 1;
                unsigned imm4 = (imm >> 12) & 0xF;
                unsigned imm3 = (imm >> 8) & 0x7;
                unsigned imm8 = imm & 0xFF;
                unsigned hi = 0xF240u | (ii << 10) | imm4;
                unsigned lo = (imm3 << 12) | ((rd & 0xF) << 8) | imm8;
                out16(a, hi); out16(a, lo);
            }
        }
        else if (strieq_a(first, "MOVT")) {
            int rd = parse_reg_a(&p);
            int imm;
            eat_comma_a(&p);
            imm = parse_imm_a(&p) & 0xFFFF;
            {
                unsigned ii = (imm >> 11) & 1;
                unsigned imm4 = (imm >> 12) & 0xF;
                unsigned imm3 = (imm >> 8) & 0x7;
                unsigned imm8 = imm & 0xFF;
                unsigned hi = 0xF2C0u | (ii << 10) | imm4;
                unsigned lo = (imm3 << 12) | ((rd & 0xF) << 8) | imm8;
                out16(a, hi); out16(a, lo);
            }
        }
        else if (strieq_a(first, "VLDMIA") || strieq_a(first, "VLDM") ||
                 strieq_a(first, "VLDMDB") || strieq_a(first, "VSTMIA") ||
                 strieq_a(first, "VSTM") || strieq_a(first, "VSTMDB") ||
                 strieq_a(first, "VPUSH") || strieq_a(first, "VPOP")) {
#if !ARKCC_FEATURE_ASM_VFP_LDSTM
            /* Trimmed on the board: the backend never emits these, so the only
             * loss is assembling hand-written .s.  Say so instead of letting the
             * mnemonic fall through as "unknown". */
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "VFP multi-register load/store is not compiled into this "
                      "build (ARKCC_FEATURE_ASM_VFP_LDSTM=0)", 0,0,0,0,0,0);
            a->hard_errors++;
            out16(a, 0xBF00); out16(a, 0xBF00);
#else
            int is_load, is_db = 0, wb = 0, rn;
            ArmVfpList vl;
            if (strieq_a(first, "VPUSH") || strieq_a(first, "VPOP")) {
                is_load = strieq_a(first, "VPOP");
                is_db = !is_load;             /* VPUSH = VSTMDB sp!, VPOP = VLDMIA sp! */
                wb = 1;
                rn = 13;
                eat_comma_a(&p);
            } else {
                is_load = (my_toupper_a(first[1]) == 'L');
                is_db = (strieq_a(first, "VLDMDB") || strieq_a(first, "VSTMDB"));
                rn = parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == '!') { wb = 1; p++; }
                eat_comma_a(&p);
            }
            vl = parse_vfplist_a(a, &p, 0);
            emit_vfp_ldstm_a(a, is_load, is_db, wb, rn, &vl);
#endif
        }
        else if (strieq_a(first, "ADDW") || strieq_a(first, "SUBW")) {
            /* Always the 32-bit form with a plain 12-bit immediate: never the
             * 16-bit ADD/SUB (which sets the flags) and never the rotated T3
             * immediate.  That is the whole point of spelling ADDW. */
            int is_sub_w = strieq_a(first, "SUBW");
            int rd = parse_reg_a(&p);
            int rn, imm = -1;
            eat_comma_a(&p);
            rn = parse_reg_a(&p);
            if (rn < 0) rn = rd;
            eat_comma_a(&p);
            if (*p == '#') imm = parse_imm_a(&p);
            if (rd < 0 || rn < 0 || imm < 0 || imm > 4095) {
                char b1[12];
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "ADDW/SUBW needs Rd, Rn and a 0..4095 immediate at code offset %s",
                          diag_num(b1, a->pc), 0,0,0,0,0);
                a->hard_errors++;
                emit_addw_a(a, is_sub_w, rd < 0 ? 0 : rd, rn < 0 ? 0 : rn, 0);
            } else {
                emit_addw_a(a, is_sub_w, rd, rn, imm);
            }
        }
        else if (strieq_a(first, "ADD")) {
            int rd = parse_reg_a(&p); int rn;
            eat_comma_a(&p);
            rn = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                if (rn < 0) rn = rd;      /* "ADD r0, #5" == "ADD r0, r0, #5" */
                if (rd == 13 && rn == 13 && imm >= 0 && imm <= 508 && (imm & 3) == 0)
                    out16(a, 0xB000 | (imm >> 2));            /* ADD sp, #imm7*4 */
                else if (rd == rn && rd >= 0 && rd <= 7 && imm >= 0 && imm <= 255)
                    out16(a, 0x3000 | ((rd & 7) << 8) | imm);  /* ADDS rdn, #imm8 */
                else if (imm >= 0 && imm <= 7 && rd >= 0 && rd <= 7 && rn >= 0 && rn <= 7)
                    out16(a, 0x1C00 | ((imm & 7) << 6) | ((rn & 7) << 3) | (rd & 7));
                else if (rd >= 0 && rn >= 0 && imm >= 0 && imm <= 4095)
                    emit_addw_a(a, 0, rd, rn, imm);       /* ADDW, plain imm12 */
                else {
                    char b1[12];
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "ADD immediate is out of range (0..4095) at code offset %s",
                              diag_num(b1, a->pc), 0,0,0,0,0);
                    a->hard_errors++;
                    emit_addw_a(a, 0, rd, rn, 0);
                }
            } else {
                /* Register forms: `ADD Rd, Rn, Rm` (T1) and the two-operand
                 * `ADD Rdn, Rm` (T2). The two-operand form used to fall into
                 * the three-operand encoder, which then read a *third* register
                 * operand past the end of the line: parse_reg_a returns -1
                 * there and (-1 & 7) == 7, so `ADD r1, r4` silently assembled
                 * as `ADD r1, r4, r7`. That is not theoretical -- __aeabi_lmul
                 * is written in exactly this shape, so every 64-bit multiply
                 * lost its carry fix-up: 0x123456789ABCDEF0 * 2 came out with
                 * a high word 1 too small (measured in unicorn). */
                int rm = parse_reg_a(&p);
                if (rd >= 0 && rn >= 0 && rm >= 0) {
                    if (rd <= 7 && rn <= 7 && rm <= 7) {
                        /* T1 -- note it sets the flags, which is exactly what
                         * the 64-bit helpers' "ADD low / ADC high" pair wants,
                         * and what this encoder has always done. */
                        out16(a, 0x1800 | ((rm & 7) << 6) | ((rn & 7) << 3) | (rd & 7));
                    } else {
                        /* T2: any registers, no flags.  The T1 path used to mask
                         * the operands with &7 here and silently add the wrong
                         * ones ("ADD ip, r6, ip" became "adds r4, r6, r4"). */
                        emit_addsub_reg_w_a(a, 0, rd, rn, rm);
                    }
                } else if (rm < 0 && rd >= 0 && rn >= 0) {
                    /* ADD (register) T2: 0100 0100 D Rm Rdn -- Rd = Rd + Rm,
                     * and unlike T1 it accepts the high registers r8-r15. */
                    out16(a, 0x4400 | (((rd >> 3) & 1) << 7) | ((rn & 0xF) << 3) | (rd & 7));
                } else {
                    char b1[12];
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "ADD needs a register or immediate operand at code offset %s",
                              diag_num(b1, a->pc), 0, 0, 0, 0, 0);
                    a->hard_errors++;
                    out16(a, 0xBF00);
                }
            }
        }
        else if (strieq_a(first, "SUB")) {
            int rd = parse_reg_a(&p); int rn;
            eat_comma_a(&p);
            rn = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                if (rn < 0) rn = rd;      /* "SUB sp, #12" == "SUB sp, sp, #12" */
                if (rd == 13 && rn == 13 && imm >= 0 && imm <= 508 && (imm & 3) == 0)
                    out16(a, 0xB080 | (imm >> 2));            /* SUB sp, #imm7*4 */
                else if (rd == rn && rd >= 0 && rd <= 7 && imm >= 0 && imm <= 255)
                    out16(a, 0x3800 | ((rd & 7) << 8) | imm);  /* SUBS rdn, #imm8 */
                else if (imm >= 0 && imm <= 7 && rd >= 0 && rd <= 7 && rn >= 0 && rn <= 7)
                    out16(a, 0x1E00 | ((imm & 7) << 6) | ((rn & 7) << 3) | (rd & 7));
                else if (rd >= 0 && rn >= 0 && imm >= 0 && imm <= 4095)
                    emit_addw_a(a, 1, rd, rn, imm);       /* SUBW, plain imm12 */
                else {
                    char b1[12];
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "SUB immediate is out of range (0..4095) at code offset %s",
                              diag_num(b1, a->pc), 0,0,0,0,0);
                    a->hard_errors++;
                    emit_addw_a(a, 1, rd, rn, 0);
                }
            } else {
                /* Same two shapes as ADD: `SUB Rd, Rn, Rm` (T1) and the
                 * two-operand `SUB Rdn, Rm`. Thumb has no high-register
                 * two-operand subtract, so that case is rejected rather than
                 * emitted with a silently wrong register. */
                int rm = parse_reg_a(&p);
                if (rd >= 0 && rn >= 0 && rm >= 0) {
                    if (rd <= 7 && rn <= 7 && rm <= 7) {
                        out16(a, 0x1A00 | ((rm & 7) << 6) | ((rn & 7) << 3) | (rd & 7));
                    } else {
                        emit_addsub_reg_w_a(a, 1, rd, rn, rm);
                    }
                } else if (rm < 0 && rd >= 0 && rd <= 7 && rn >= 0 && rn <= 7) {
                    /* SUB Rdn, Rm is SUB Rdn, Rdn, Rm */
                    out16(a, 0x1A00 | ((rn & 7) << 6) | ((rd & 7) << 3) | (rd & 7));
                } else if (rm < 0 && rd >= 0 && rn >= 0) {
                    /* high registers: no 16-bit two-operand SUB exists */
                    emit_addsub_reg_w_a(a, 1, rd, rd, rn);
                } else {
                    char b1[12];
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "two-operand SUB needs low registers at code offset %s",
                              diag_num(b1, a->pc), 0, 0, 0, 0, 0);
                    a->hard_errors++;
                    out16(a, 0xBF00);
                }
            }
        }
        else if (strieq_a(first, "MUL")) {
            /* MULS T1 (16-bit): MULS <Rdn>, <Rn>, <Rdm> with Rd == Rn.
             * The two-operand form MULS Rd, Rm is the same encoding (Rn = Rd).
             * Anything else -- a high register, or three distinct registers --
             * takes the 32-bit MUL T2 form, which names r0-r15 in all three
             * slots.  The third operand used to be dropped on the floor for
             * "MUL r2, r2, r1"; it is now encoded for real. */
            int rd = parse_reg_a(&p); int rn, rm, second;
            eat_comma_a(&p); second = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                rn = second;                  /* three-operand: Rd, Rn, Rm */
                eat_comma_a(&p); rm = parse_reg_a(&p);
            } else {
                rn = rd;                      /* two-operand: Rd = Rd * Rm */
                rm = second;
            }
            if (rd == rn && rd >= 0 && rd <= 7 && rm >= 0 && rm <= 7) {
                out16(a, 0x4340 | ((rm & 7) << 3) | (rd & 7));
            } else {
                /* MUL T2 (32-bit) names r0-r15: 0xFB00|Rn ; 0xF000|Rd<<8|Rm.
                 * pass 1 already widened the instruction when a high register
                 * was named, so emitting two bytes here would desynchronise
                 * every later label -- and masking with 7 would silently
                 * multiply the wrong register (-fopt-vreg produces
                 * "MUL r9, r9, r7"). */
                out16(a, 0xFB00u | (unsigned)(rn & 0xF));
                out16(a, 0xF000u | (unsigned)((rd & 0xF) << 8) |
                         (unsigned)(rm & 0xF));
            }
        }
        else if (strieq_a(first, "ADC") || strieq_a(first, "SBC")) {
            /* Carry-propagating add/subtract.  16-bit Thumb only has the
             * two-operand shape and always sets the flags:
             *   ADCS Rd, Rm   ==  Rd = Rd + Rm + C
             *   SBCS Rd, Rm   ==  Rd = Rd - Rm - !C
             * so the three-operand spelling "ADC Rd, Rn, Rm" is only
             * representable when Rd == Rn (the 32-bit form is not
             * emitted).  This branch used to read only two operands: the
             * third was dropped and the second encoded as the addend, so
             * "ADC r1, r1, r3" (what the 64-bit add tail emits) became
             * "ADCS r1, r1" -- the high word of every 64-bit add/sub was
             * silently off by one (measured: -100LL + 3LL carried
             * 0xFFFFFFFE into the high word and __aeabi_lcmp then said the
             * halves differed). */
            int is_sbc = strieq_a(first, "SBC");
            int rd = parse_reg_a(&p);
            int rn, rm, second;
            eat_comma_a(&p);
            second = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                rn = second;              /* three operands: Rd, Rn, Rm */
                eat_comma_a(&p);
                rm = parse_reg_a(&p);
            } else {
                rn = rd;                  /* two operands: Rd = Rd +/- Rm */
                rm = second;
            }
            if (rd >= 0 && rm >= 0 && rd != rn) {
                if (a->pass2) {
                    char b1[12], b2[12];
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "ADC/SBC with three distinct registers "
                              "(Rd=r%s, Rn=r%s) needs the 32-bit form, "
                              "not supported",
                              diag_num(b1, rd), diag_num(b2, rn), 0,0,0,0);
                    a->hard_errors++;
                }
                rm = rn;                  /* keep the encoding meaningful */
            }
            if (rd >= 0 && rm >= 0) {
                out16(a, (is_sbc ? 0x4180 : 0x4140) | ((rm & 7) << 3) | (rd & 7));
            } else {
                if (a->pass2) {
                    char b1[12];
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "ADC/SBC needs two register operands at "
                              "code offset %s",
                              diag_num(b1, a->pc), 0,0,0,0,0);
                    a->hard_errors++;
                }
                out16(a, 0xBF00);
            }
        }
        else if (strieq_a(first, "UMULL")) {
            /* UMULL T1 (32-bit): UMULL RdLo, RdHi, Rn, Rm
             * Encoding: 1111 1011 1010 Rn | RdLo RdHi 0000 Rm */
            int rdlo = parse_reg_a(&p); int rdhi, rn, rm;
            eat_comma_a(&p); rdhi = parse_reg_a(&p);
            eat_comma_a(&p); rn = parse_reg_a(&p);
            eat_comma_a(&p); rm = parse_reg_a(&p);
            out16(a, 0xFBA0 | (rn & 0xF));
            out16(a, ((rdlo & 0xF) << 12) | ((rdhi & 0xF) << 8) | (rm & 0xF));
        }
        else if (strieq_a(first, "SDIV") || strieq_a(first, "UDIV")) {
            int rd = parse_reg_a(&p);
            int rn, rm;
            eat_comma_a(&p);
            rn = parse_reg_a(&p);
            eat_comma_a(&p);
            rm = parse_reg_a(&p);
            {
                unsigned op = strieq_a(first, "SDIV") ? 0xFB90u : 0xFBB0u;
                out16(a, op | (rn & 0xF));
                out16(a, 0xF0F0u | ((rd & 0xF) << 8) | (rm & 0xF));
            }
        }
        else if (strieq_a(first, "AND") || strieq_a(first, "ORR") ||
                 strieq_a(first, "EOR") || strieq_a(first, "BIC") ||
                 strieq_a(first, "MVN")) {
            (void)logic_dp_a(a, first, &p, 1);
        }
        else if (strieq_a(first, "LSL") || strieq_a(first, "LSR") ||
                 strieq_a(first, "ASR")) {
            /* Three shapes, and every one of them has a 16-bit form that names
             * r0-r7 only and a 32-bit form that names r0-r15.  Masking with 7
             * used to turn "LSL r9, r9, #2" into "LSLS r1, r1, #2" -- a silent
             * wrong answer, and one this compiler produced itself once
             * -fopt-vreg started renaming frame slots into r8-r11.
             *   16-bit immediate : imm5<<6 | Rm<<3 | Rd        (type in 0x1800)
             *   32-bit immediate : EA4F ; imm3 Rd imm2 type Rm
             *   16-bit register  : 0x4080 | Rs<<3 | Rs          (type in 0x0040)
             *   32-bit register  : FA0x(0/20/40) Rn ; F000 Rd Rs
             */
            int is_lsr = strieq_a(first, "LSR");
            int is_asr = strieq_a(first, "ASR");
            int sh16 = is_lsr ? 0x0800 : (is_asr ? 0x1000 : 0x0000);
            int rg16 = is_lsr ? 0x40C0 : (is_asr ? 0x4100 : 0x4080);
            unsigned type2 = is_lsr ? 1u : (is_asr ? 2u : 0u);
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            skip_space_a(&p);
            {
                int is_imm = 0, imm = 0, rs = -1, rn_src, rs_amt;
                if (*p == ',') {
                    p++; skip_space_a(&p);
                    if (*p == '#') { imm = parse_imm_a(&p); is_imm = 1; }
                    else           rs = parse_reg_a(&p);
                }
                /* Operand roles, which are easy to get backwards:
                 *   Rd, Rn, Rs   -> result Rd, value Rn, amount Rs
                 *   Rd, Rn, #imm -> result Rd, value Rn
                 *   Rd, Rs       -> result Rd, value Rd (the destination is
                 *                   the shifted value), amount Rs
                 * The two-operand form used to set rn_src=Rs and rs_amt=Rd,
                 * which assembled the backend's own "LSL r0, r1" as
                 * "LSLS r0, r0, r0" -- it shifted a value by its own low
                 * byte (measured: 8 << 8 = 0x800 where 8 << 3 was meant). */
                if (rs >= 0)     { rn_src = rm; rs_amt = rs; }
                else if (is_imm) { rn_src = rm; rs_amt = rd; }
                else             { rn_src = rd; rs_amt = rm; }
                if (rd >= 0 && rd <= 7 && rm >= 0 && rm <= 7 && rs_amt >= 0 && rs_amt <= 7) {
                    if (is_imm) {
                        int imm5;
                        if (is_lsr || is_asr) imm5 = (imm >= 32) ? 0 : (imm & 0x1F);
                        else                  imm5 = imm & 0x1F;
                        out16(a, (unsigned)sh16 | (unsigned)(imm5 << 6) |
                                 ((rm & 7) << 3) | (rd & 7));
                    } else {
                        out16(a, (unsigned)rg16 | ((rs_amt & 7) << 3) | (rd & 7));
                    }
                } else if (is_imm) {
                    int imm5 = (is_lsr || is_asr)
                                   ? ((imm >= 32) ? 0 : (imm & 0x1F))
                                   : (imm & 0x1F);
                    out16(a, 0xEA4Fu);
                    out16(a, (unsigned)(((imm5 >> 2) & 7) << 12) |
                             (unsigned)((rd & 0xF) << 8) |
                             (unsigned)((imm5 & 3) << 6) |
                             (type2 << 4) | (unsigned)(rn_src & 0xF));
                } else {
                    /* LSL.W / LSR.W / ASR.W Rd, Rn, Rs */
                    out16(a, 0xFA00u | (type2 << 5) | (unsigned)(rn_src & 0xF));
                    out16(a, 0xF000u | (unsigned)((rd & 0xF) << 8) |
                             (unsigned)(rs_amt & 0xF));
                }
            }
        }
        else if (strieq_a(first, "MRS") || strieq_a(first, "MSR")) {
            /* MRS Rd, <spec> / MSR <spec>, Rn.
             * Deliberately NOT gated by --asm-extra, although the extension
             * list used to carry it: the ARM backend emits `MRS r0, PRIMASK`
             * and `MSR PRIMASK, r0` itself for the C11 <stdatomic.h> critical
             * section, so the compiler must be able to assemble its own output
             * with the option off (same rule as ADDS/SUBS above).
             * sysm: MSP=8, PSP=9, PRIMASK=16, FAULTMASK=17, BASEPRI=19,
             *       CONTROL=20.  Only these six are accepted: anything else
             *       would need a system register the M-profile core may not
             *       implement, and silently encoding a wrong sysm is worse than
             *       refusing. */
            int is_mrs = strieq_a(first, "MRS");
            char sp1[32], sp2[32];
            int sysm = -1;
            int rd, rn;
            if (is_mrs) {
                rd = parse_reg_a(&p);
                eat_comma_a(&p);
                read_label_name_a(&p, sp1, sizeof(sp1));
            } else {
                read_label_name_a(&p, sp2, sizeof(sp2));
                eat_comma_a(&p);
                rn = parse_reg_a(&p);
                rd = rn;
            }
            {
                const char *nm = is_mrs ? sp1 : sp2;
                if (strieq_a(nm, "MSP"))            sysm = 8;
                else if (strieq_a(nm, "PSP"))       sysm = 9;
                else if (strieq_a(nm, "PRIMASK"))   sysm = 16;
                else if (strieq_a(nm, "FAULTMASK")) sysm = 17;
                else if (strieq_a(nm, "BASEPRI"))   sysm = 19;
                else if (strieq_a(nm, "CONTROL"))   sysm = 20;
            }
            if (sysm < 0) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "MRS/MSR supports MSP, PSP, PRIMASK, FAULTMASK, "
                          "BASEPRI and CONTROL only", 0,0,0,0,0,0);
                a->hard_errors++;
                sysm = 16;
            }
            if (is_mrs) {
                out16(a, 0xF3EFu);
                out16(a, 0x8000u | (unsigned)((rd & 0xF) << 8) | (unsigned)sysm);
            } else {
                out16(a, 0xF380u | (unsigned)(rd & 0xF));
                out16(a, 0x8800u | (unsigned)sysm);
            }
        }
#if ARKCC_FEATURE_ASM_EXTRA
        else if (!ark_asm_extra_on() && ark_asm_extra_name(first)) {
            /* --no-asm-extra (or the feature compiled out): these mnemonics must
             * behave exactly as they did before the extension existed, i.e. be
             * rejected as unknown, so a build cannot quietly depend on them. */
            {
                char b1[12];
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "unknown mnemonic %sq at code offset %s "
                          "(--asm-extra is off; turn it on to assemble it)",
                          first, diag_num(b1, a->pc), 0,0,0,0);
            }
            a->hard_errors++;
            out16(a, 0xBF00);
            skip_to_eol_a(&p);
        }
        else if (strieq_a(first, "ADDS") || strieq_a(first, "SUBS")) {
            /* --asm-extra: flag-setting aliases of ADD/SUB.
             * Three operand shapes have to be told apart before anything can be
             * encoded: `ADDS Rd, Rn, Rm`, `ADDS Rd, Rn, #imm`, and the two
             * operand forms `ADDS Rd, Rm` / `ADDS Rd, #imm` (Rd = Rd +/- x).
             * The 16-bit data-processing forms always set the flags, so they
             * encode exactly like ADD/SUB; only the 32-bit form carries S as a
             * real bit (bit 4 of the first halfword), which is why the plain
             * ADD.W must keep writing S=0 and this branch exists separately. */
            int is_sub = strieq_a(first, "SUBS");
            int rd = parse_reg_a(&p);
            int rn = rd;
            int rm = -1;
            int imm = -1;
            eat_comma_a(&p);
            if (*p == '#') {
                imm = parse_imm_a(&p);                 /* ADDS Rd, #imm */
            } else {
                int r2 = parse_reg_a(&p);
                skip_space_a(&p);
                if (*p == ',') {
                    p++; skip_space_a(&p);
                    rn = r2;
                    if (*p == '#') imm = parse_imm_a(&p);   /* ADDS Rd, Rn, #imm */
                    else           rm  = parse_reg_a(&p);   /* ADDS Rd, Rn, Rm */
                } else {
                    rm = r2;                                /* ADDS Rd, Rm */
                }
            }
            if (imm >= 0) {
                if (rd == 13 && rn == 13) {
                    /* ADD/SUB sp, sp, #imm.  The 16-bit form carries a 7-bit
                     * scaled immediate (0..508, multiple of 4) and there is no
                     * flag-setting form for SP, so anything else used to be
                     * masked with 0x7F -- a wrong stack pointer.  Bigger
                     * adjustments use ADDW/SUBW sp, sp, #imm12 (S=0, since
                     * S=1 with Rd=SP is UNPREDICTABLE in ARMv7-M). */
                    if (imm >= 0 && imm <= 508 && (imm & 3) == 0) {
                        out16(a, (is_sub ? 0xB080u : 0xB000u) | (((imm + 3) / 4) & 0x7F));
                    } else if (imm >= 0 && imm <= 4095) {
                        int i = (imm >> 11) & 1;
                        int imm3 = (imm >> 8) & 7;
                        out16(a, (is_sub ? 0xF2A0u : 0xF200u) | (unsigned)(i << 10) |
                                 (unsigned)(rn & 0xF));
                        out16(a, (unsigned)((imm3 << 12) | ((13 & 0xF) << 8) | (imm & 0xFF)));
                    } else {
                        char b1[16];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "sp adjustment of %s bytes does not fit one encoding",
                                  diag_num(b1, imm), 0,0,0,0,0);
                        a->hard_errors++;
                    }
                } else if (rd == rn && rd >= 0 && rd <= 7 && imm >= 0 && imm <= 255) {
                    /* ADDS/SUBS rdn, #imm8 names r0-r7 only; a high register
                     * used to be masked with 7 and silently hit the wrong one. */
                    out16(a, (is_sub ? 0x3800u : 0x3000u) | ((rd & 7) << 8) | (imm & 0xFF));
                } else if (imm >= 0 && imm <= 7 && rd >= 0 && rd <= 7 && rn >= 0 && rn <= 7) {
                    out16(a, (is_sub ? 0x1E00u : 0x1C00u) | ((imm & 7) << 6) |
                             ((rn & 7) << 3) | (rd & 7));
                } else if (imm >= 0 && imm <= 4095 && rd >= 0 && rn >= 0) {
                    int i = (imm >> 11) & 1;
                    int imm3 = (imm >> 8) & 7;
                    unsigned base = is_sub ? 0xF1B0u : 0xF110u;  /* op=1101/1000, S=1 */
                    out16(a, base | (unsigned)(i << 10) | (unsigned)(rn & 0xF));
                    out16(a, (unsigned)((imm3 << 12) | ((rd & 0xF) << 8) | (imm & 0xFF)));
                } else {
                    char b1[16];
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "ADDS/SUBS immediate %s does not fit any encoding",
                              diag_num(b1, imm), 0,0,0,0,0);
                    a->hard_errors++;
                }
            } else if (rm >= 0) {
                if (rd >= 0 && rd <= 7 && rn >= 0 && rn <= 7 && rm <= 7) {
                    out16(a, (is_sub ? 0x1A00u : 0x1800u) | ((rm & 7) << 6) |
                             ((rn & 7) << 3) | (rd & 7));
                } else {
                    /* 32-bit T2 form.  The 16-bit encodings name r0-r7 only, so
                     * a high register used to be masked with 7 -- silently
                     * adding the wrong register while pass 1 had already laid
                     * the instruction out at four bytes.  S=1 for ADDS/SUBS:
                     * 0xEB1x = ADD (reg) T2, 0xEBBx = SUB (reg) T2. */
                    out16(a, (is_sub ? 0xEBB0u : 0xEB10u) | (unsigned)(rn & 0xF));
                    out16(a, (unsigned)(((rd & 0xF) << 8) | (rm & 0xF)));
                }
            } else {
                char b1[16];
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "%s at code offset %s has no source register",
                          first, diag_num(b1, a->pc), 0,0,0,0);
                a->hard_errors++;
            }
        }
        else if (strieq_a(first, "ANDS") || strieq_a(first, "ORRS") ||
                 strieq_a(first, "EORS") || strieq_a(first, "BICS") ||
                 strieq_a(first, "MVNS")) {
            /* --asm-extra: 16-bit data-processing forms all set the flags, so
             * ANDS/ORRS/EORS/BICS/MVNS are the same encodings as AND/ORR/EOR/
             * BIC/MVN with a register operand. */
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            {
                unsigned base;
                if (strieq_a(first, "ANDS"))      base = 0x4000u;
                else if (strieq_a(first, "EORS")) base = 0x4040u;
                else if (strieq_a(first, "ORRS")) base = 0x4300u;
                else if (strieq_a(first, "BICS")) base = 0x4380u;
                else                              base = 0x43C0u;   /* MVNS */
                out16(a, base | ((rm & 7) << 3) | (rd & 7));
            }
        }
        else if (strieq_a(first, "MULS")) {
            /* --asm-extra: MULS Rd, Rm (Rd = Rd * Rm); the 16-bit MUL always
             * sets the flags, so this is MUL's encoding. */
            int rd = parse_reg_a(&p); int rn, rm, second;
            eat_comma_a(&p); second = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                rn = second;
                eat_comma_a(&p); rm = parse_reg_a(&p);
            } else {
                rn = rd;
                rm = second;
            }
            if (rd != rn) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "MULS with three distinct registers needs the 32-bit form, "
                          "which this assembler does not emit", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            if (!(rd >= 0 && rd <= 7 && rm >= 0 && rm <= 7)) {
                /* MULS is --asm-extra only and pass 1 lays it out at two
                 * bytes; masking a high register with 7 would multiply the
                 * wrong register, so refuse instead ("MUL" spells the same
                 * instruction and does have the 32-bit form). */
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "MULS needs r0-r7 operands; use MUL for high registers",
                          0,0,0,0,0,0);
                a->hard_errors++;
            }
            out16(a, 0x4340u | ((rm & 7) << 3) | (rd & 7));
        }
        else if (strieq_a(first, "LSLS") || strieq_a(first, "LSRS") ||
                 strieq_a(first, "ASRS")) {
            /* --asm-extra: flag-setting shifts.  Three shapes:
             *   LSLS Rd, Rn, #imm  -> 16-bit immediate form (always S)
             *   LSLS Rd, Rm        -> 16-bit register form (Rdn <<= Rm)
             *   LSLS Rd, Rn, Rm    -> 32-bit register form (S in bit 4 of hi)
             * The third shape must NOT be encoded as the 16-bit form: that form
             * shifts Rd by Rn's value, not Rm's, so it silently computes
             * something else (GAS emits lsls.w here; measured). */
            unsigned type;
            int rd = parse_reg_a(&p);
            int rn, rm = -1, imm = -1;
            eat_comma_a(&p);
            rn = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                p++; skip_space_a(&p);
                if (*p == '#') imm = parse_imm_a(&p);
                else           rm = parse_reg_a(&p);
            }
            if (strieq_a(first, "LSLS"))      type = 0;
            else if (strieq_a(first, "LSRS")) type = 1;
            else                              type = 2;
            if (imm >= 0) {
                unsigned imm5 = (unsigned)(imm & 0x1F);
                if (imm >= 32) imm5 = 0;             /* encoded as 32 */
                out16(a, (type << 11) | (imm5 << 6) | ((rn & 7) << 3) | (rd & 7));
            } else if (rm >= 0) {
                out16(a, 0xFA00u | (type << 5) | (1u << 4) |
                         (unsigned)(rn & 0xF));
                out16(a, 0xF000u | (unsigned)((rd & 0xF) << 8) | (unsigned)(rm & 0xF));
            } else {
                out16(a, 0x4080u | (type << 6) | ((rn & 7) << 3) | (rd & 7));
            }
        }
        else if (strieq_a(first, "ADR")) {
            /* --asm-extra: ADR Rd, label -- T1, imm8*4 relative to Align(PC,4). */
            int rd = parse_reg_a(&p);
            char name[64];
            eat_comma_a(&p);
            read_label_name_a(&p, name, sizeof(name));
            {
                int addr = find_label_a(a, name);
                if (addr < 0) {
                    add_ref_a(a, a->pc, name, 7);
                    out16(a, 0xA000u | ((rd & 7) << 8));
                } else {
                    int base = (a->pc + 4) & ~3;
                    int off = addr - base;
                    if (off < 0 || off > 1020 || (off & 3) != 0) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "ADR target %sq is %s bytes from the aligned PC; "
                                  "the 16-bit form covers 0..1020 in steps of 4",
                                  name, diag_num(b1, off), 0,0,0,0);
                        a->hard_errors++;
                    }
                    out16(a, 0xA000u | ((rd & 7) << 8) | (unsigned)((off >> 2) & 0xFF));
                }
            }
        }
        else if (strieq_a(first, "CBZ") || strieq_a(first, "CBNZ")) {
            /* --asm-extra: CBZ/CBNZ Rd, label -- T1, forward only, 0..62 bytes.
             * imm5 = offset/2 with bit 5 carried in bit 9 of the halfword. */
            int is_nz = strieq_a(first, "CBNZ");
            int rd = parse_reg_a(&p);
            char name[64];
            eat_comma_a(&p);
            read_label_name_a(&p, name, sizeof(name));
            /* T1 encodes only r0-r7 in the three register bits; masking a
             * higher register with &7 would quietly assemble `CBZ r8` as
             * `CBZ r0` -- an error nobody could see in the listing. */
            if (rd < 0 || rd > 7) {
                char rb[12];
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "CBZ/CBNZ reach r0-r7 only (16-bit T1); r%s cannot be encoded",
                          diag_num(rb, rd), 0,0,0,0,0);
                a->hard_errors++;
            }
            {
                int addr = find_label_a(a, name);
                if (addr < 0) {
                    add_ref_a(a, a->pc, name, is_nz ? 9 : 8);
                    out16(a, (is_nz ? 0xB900u : 0xB100u) | (rd & 7));
                } else {
                    int off = addr - (a->pc + 4);
                    if (off < 0 || off > 62 || (off & 1) != 0) {
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "CBZ/CBNZ target %sq is out of the 16-bit forward "
                                  "range (0..62 bytes, even)", name, 0,0,0,0,0);
                        a->hard_errors++;
                    } else {
                        unsigned imm5 = (unsigned)(off >> 1);
                        out16(a, (is_nz ? 0xB900u : 0xB100u) |
                                 ((imm5 & 0x20u) << 4) | ((imm5 & 0x1Fu) << 3) | (rd & 7));
                    }
                }
            }
        }
        else if (strieq_a(first, "LDMIA") || strieq_a(first, "STMIA") ||
                 strieq_a(first, "LDM") || strieq_a(first, "STM") ||
                 strieq_a(first, "LDMDB") || strieq_a(first, "STMDB")) {
            /* --asm-extra: multiple load/store.
             *   T1  (16-bit) needs all four of: base in r0-r7, every register
             *       in the list in r0-r7, writeback on the base, increment-after.
             *   T2  (32-bit) covers the rest: high registers, lr/pc in the list,
             *       no writeback, and decrement-before.
             *     hw1 = 0xE880 | (DB<<7) | (W<<5) | (is_load<<4) | Rn
             *     hw2 = register list, bit n = rn, bit 14 = lr, bit 15 = pc
             *   Both bit patterns were taken from arm-none-eabi-as output and
             *   are checked instruction-for-instruction by tests/asm_cases. */
            int is_stm = (my_toupper_a(first[0]) == 'S');   /* source may be lowercase */
            int is_db  = (first[3] == 'D' || first[3] == 'd');
            int rn = parse_reg_a(&p);
            int has_lr = 0, has_pc = 0, list, has_bang = 0;
            skip_space_a(&p);
            if (*p == '!') { has_bang = 1; p++; }
            eat_comma_a(&p);          /* "r0!, {..}" - the comma is optional */
            list = parse_reglist_a(a, &p, &has_lr, &has_pc);
            if (rn < 0 || rn > 14) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "LDM/STM needs a base register of r0-r14", 0,0,0,0,0,0);
                a->hard_errors++;
                rn = 0;
            }
            if (list == 0) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "LDM/STM needs a non-empty register list", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            if (list & (1 << 13)) {
                /* Bit 13 is the one register a list cannot name: the ARM ARM
                 * makes sp in the list UNPREDICTABLE for every LDM/STM form. */
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "sp may not appear in a LDM/STM register list", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            if (rn >= 0 && rn <= 14 && (list & (1 << rn))) {
                /* ARM ARM: base register in the list together with writeback is
                 * UNPREDICTABLE; the core may store the old or the new base.
                 * arm-none-eabi-as refuses it, so refuse it here too. */
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "the base register may not appear in the list when the "
                          "instruction writes back (UNPREDICTABLE)", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            if (is_stm && has_pc) {
                /* ARM ARM: storing pc selects STM (user), which has no useful
                 * meaning on the M-profile; refusing beats encoding it. */
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "STM may not store pc", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            if (!is_db && has_bang && !has_lr && !has_pc && rn <= 7 &&
                list != 0 && (list & ~0xFF) == 0) {
                /* T1 */
                out16(a, (is_stm ? 0xC000u : 0xC800u) | ((rn & 7) << 8) | (list & 0xFF));
            } else {
                /* T2 */
                /* 0xE880 is the increment-after form; decrement-before clears
                 * U (bit 7) and sets P (bit 8) -> 0xE900.  Writing it as a
                 * base choice rather than an OR matters: bit 7 is already
                 * set in 0xE880, so "| 0x80" would encode IA. */
                unsigned hw1 = (unsigned)(is_db ? 0xE900 : 0xE880) |
                               (unsigned)(has_bang ? 0x20 : 0) |
                               (unsigned)(is_stm ? 0 : 0x10) |
                               (unsigned)(rn & 0xF);
                unsigned hw2 = (unsigned)(list & 0x1FFF) |
                               (unsigned)(has_lr ? 0x4000 : 0) |
                               (unsigned)(has_pc ? 0x8000 : 0);
                out16(a, hw1);
                out16(a, hw2);
            }
        }
        else if (strieq_a(first, "TBB") || strieq_a(first, "TBH")) {
            /* --asm-extra: table branch, 32-bit T1.
             *   TBB [Rn, Rm]        hw1 = 0xE8D0 | Rn   hw2 = 0xF000 | Rm
             *   TBH [Rn, Rm, LSL #1] hw1 = 0xE8D0 | Rn  hw2 = 0xF010 | Rm
             * Neither Rn nor Rm may be pc (UNPREDICTABLE), and TBB takes no
             * shift while TBH accepts exactly LSL #1 -- anything else would
             * change which byte is loaded, so it is an error, not a silence. */
            int is_tbh = strieq_a(first, "TBH");
            int rn, rm, shift = 0, has_shift = 0;
            skip_space_a(&p);
            if (*p == '[') { p++; skip_space_a(&p); }
            rn = parse_reg_a(&p);
            eat_comma_a(&p);
            rm = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                char opn[8];
                p++;
                skip_space_a(&p);
                has_shift = 1;
                read_word_a(&p, opn, (int)sizeof(opn));
                skip_space_a(&p);
                if (*p == '#') shift = parse_imm_a(&p);
                if (!strieq_a(opn, "LSL") || shift != 1) {
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "TBH accepts only 'LSL #1' as its shift", 0,0,0,0,0,0);
                    a->hard_errors++;
                }
            }
            skip_space_a(&p);
            if (*p == ']') p++;
            check_no_index_writeback_a(a, &p);
            if (has_shift && !is_tbh) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "TBB takes no shift; use TBH [Rn, Rm, LSL #1]",
                          0,0,0,0,0,0);
                a->hard_errors++;
            }
            if (rn < 0 || rn > 14 || rm < 0 || rm > 14) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "TBB/TBH needs two registers of r0-r14 (pc is "
                          "UNPREDICTABLE here)", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            out16(a, 0xE8D0u | (unsigned)(rn & 0xF));
            out16(a, (unsigned)(is_tbh ? 0xF010 : 0xF000) | (unsigned)(rm & 0xF));
        }
        else if (strieq_a(first, "LDRD") || strieq_a(first, "STRD")) {
            /* --asm-extra: LDRD/STRD Rt, Rt2, [Rn, #imm] -- 32-bit T1.
             *   hw1 = 0xE9C0 | (U<<7) | (is_load<<4) | Rn
             *   hw2 = (Rt<<12) | (Rt2<<8) | (|imm| >> 2)
             *   U=1 for a positive offset, U=0 for a negative one; the stored
             *   immediate is always the magnitude, hence the /4 round trip.
             * ARMv7-M makes an odd Rt, or Rt2 != Rt+1, UNPREDICTABLE, and
             * arm-none-eabi-as emits it anyway -- this assembler refuses, so a
             * typo cannot turn into a load of the wrong pair. */
            int is_load = (my_toupper_a(first[0]) == 'L');
            int rt = parse_reg_a(&p);
            int rt2, rn, imm = 0;
            eat_comma_a(&p);
            rt2 = parse_reg_a(&p);
            eat_comma_a(&p);
            skip_space_a(&p);
            if (*p == '[') { p++; skip_space_a(&p); }
            rn = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                p++;
                skip_space_a(&p);
                if (*p == '#') imm = parse_imm_a(&p);
                else {
                    /* Register-offset addressing ([Rn, Rm]) has no encoder
                     * here.  Ignoring Rm would silently address the base
                     * register instead, so refuse and let the author write
                     * the address arithmetic out. */
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "register-offset addressing ([Rn, Rm]) does "
                              "not exist for this instruction in Thumb; compute "
                              "the address with ADD first", 0,0,0,0,0,0);
                    a->hard_errors++;
                }
            }
            skip_space_a(&p);
            if (*p == ']') p++;
            check_no_index_writeback_a(a, &p);
            if (rn < 0 || rn > 15) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "LDRD/STRD needs a base register", 0,0,0,0,0,0);
                a->hard_errors++;
                rn = 0;
            }
            if (rt < 0 || rt2 < 0 || rt > 12 || rt2 > 14) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "LDRD/STRD needs two registers of r0-r14", 0,0,0,0,0,0);
                a->hard_errors++;
                rt = 0; rt2 = 1;
            } else if ((rt & 1) || rt2 != rt + 1) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "LDRD/STRD needs an even Rt and Rt2 == Rt+1 "
                          "(any other pair is UNPREDICTABLE on ARMv7-M)",
                          0,0,0,0,0,0);
                a->hard_errors++;
            }
            if ((imm & 3) != 0 || imm > 1020 || imm < -1020) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "LDRD/STRD offset must be a multiple of 4 in -1020..1020",
                          0,0,0,0,0,0);
                a->hard_errors++;
                imm = 0;
            }
            {
                int mag = imm < 0 ? -imm : imm;
                /* hw1 = 0xE940 | P(bit6) | U(bit7) | L(bit4) | Rn.
                 * U is 1 for a positive offset and 0 for a negative one;
                 * like LDM/STM above, the two bases differ in a bit that is
                 * set in both, so pick the base, do not OR a flag into it. */
                out16(a, (unsigned)(is_load ? (imm < 0 ? 0xE950 : 0xE9D0)
                                             : (imm < 0 ? 0xE940 : 0xE9C0)) |
                          (unsigned)(rn & 0xF));
                out16(a, (unsigned)((rt & 0xF) << 12) |
                          (unsigned)((rt2 & 0xF) << 8) |
                          (unsigned)((mag >> 2) & 0xFF));
            }
        }
        else if (strieq_a(first, "MLA") || strieq_a(first, "MLS")) {
            /* --asm-extra: MLA/MLS Rd, Rn, Rm, Ra -- 32-bit, hi=11111011000x Rn */
            int is_mls = strieq_a(first, "MLS");
            int rd = parse_reg_a(&p); int rn, rm, ra;
            eat_comma_a(&p); rn = parse_reg_a(&p);
            eat_comma_a(&p); rm = parse_reg_a(&p);
            eat_comma_a(&p); ra = parse_reg_a(&p);
            out16(a, 0xFB00u | (unsigned)(rn & 0xF));
            out16(a, ((unsigned)(ra & 0xF) << 12) | ((unsigned)(rd & 0xF) << 8) |
                     ((unsigned)(is_mls ? 1 : 0) << 4) | (unsigned)(rm & 0xF));
        }
        else if (strieq_a(first, "SMULL") || strieq_a(first, "SMLAL")) {
            /* --asm-extra: SMULL/SMLAL RdLo, RdHi, Rn, Rm -- 32-bit */
            int is_smlal = strieq_a(first, "SMLAL");
            int rdlo = parse_reg_a(&p); int rdhi, rn, rm;
            eat_comma_a(&p); rdhi = parse_reg_a(&p);
            eat_comma_a(&p); rn = parse_reg_a(&p);
            eat_comma_a(&p); rm = parse_reg_a(&p);
            out16(a, (is_smlal ? 0xFBC0u : 0xFB80u) | (unsigned)(rn & 0xF));
            out16(a, ((unsigned)(rdlo & 0xF) << 12) | ((unsigned)(rdhi & 0xF) << 8) |
                     (unsigned)(rm & 0xF));
        }
#endif
        else if (strieq_a(first, "NEG") || strieq_a(first, "RSB")) {
            /* NEG Rd, Rm == RSB Rd, Rm, #0.  The 16-bit form RSBS names
             * r0-r7 only; a high register takes the 32-bit RSB (immediate)
             * T2 encoding 0xF1C0|Rn ; Rd<<8 (imm8 = 0).  pass 1 already
             * widened on the same rule -- masking with 7 used to turn
             * "NEG r9, r7" into "RSBS r1, r7, #0" (-fopt-vreg emits that
             * shape once it promotes a slot into r8-r11). */
            int rd = parse_reg_a(&p); int rm;
            int neg_imm = -1, has_third = 0, third_is_imm = 0;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                p++; skip_space_a(&p);
                has_third = 1;
                if (*p == '#') { third_is_imm = 1; neg_imm = parse_imm_a(&p); }
                else           { (void)parse_reg_a(&p); }
            }
            if (!has_third && rd >= 0 && rd <= 7 && rm >= 0 && rm <= 7) {
                out16(a, 0x4240 | ((rm & 7) << 3) | (rd & 7));
            } else if (has_third && third_is_imm && neg_imm == 0) {
                out16(a, 0xF1C0u | (unsigned)(rm & 0xF));
                out16(a, (unsigned)((rd & 0xF) << 8));
            } else if (!has_third) {
                /* NEG Rd, Rm with a high register: RSB.W Rd, Rm, #0 */
                out16(a, 0xF1C0u | (unsigned)(rm & 0xF));
                out16(a, (unsigned)((rd & 0xF) << 8));
            } else {
                /* RSB Rd, Rm, #imm with imm != 0 needs ThumbExpandImm, which
                 * this assembler does not implement; a register third operand
                 * has no 32-bit "RSB register" form on ARMv7-M either.
                 * Refuse loudly, but still emit four bytes so that every
                 * later label keeps the address pass 1 assigned. */
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "RSB with an immediate other than #0 or a register "
                          "third operand is not supported", 0,0,0,0,0,0);
                a->hard_errors++;
                out16(a, 0xBF00);
                out16(a, 0xBF00);
            }
        }
        else if (strieq_a(first, "CMP")) {
            int rn = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                if (rn >= 0 && rn <= 7 && imm >= 0 && imm <= 255) {
                    /* T1 16-bit: CMP Rn, #imm8.  Rn is only three bits wide
                     * here, so masking with 7 used to turn "CMP r9, #4"
                     * into "CMP r1, #4" -- a silent wrong answer that
                     * -fopt-vreg provokes the moment a slot lives in r8-r11. */
                    out16(a, 0x2800 | ((rn & 7) << 8) | (imm & 0xFF));
                } else {
                    /* T2 32-bit: CMP.W Rn, #imm12 (ThumbExpandImm).
                     * hi: 0xF1B0 | i<<10 | Rn, lo: imm3<<12 | 0x0F00 | imm8.
                     * Was truncating the constant to its low 8 bits, which
                     * silently compared against the wrong value. */
                    unsigned i, imm3, imm8;
                    if (!thumb_imm12_a((unsigned)imm, &i, &imm3, &imm8)) {
                        {
                            char b1[12];
                            diag_tool(DIAG_SEV_ERROR, "arkcc",
                                      "CMP immediate %s cannot be encoded as a "
                                      "modified immediate", diag_num(b1, imm),
                                      0,0,0,0,0);
                        }
                        a->hard_errors++;
                        out16(a, 0xBF00);
                        out16(a, 0xBF00);
                    } else {
                        out16(a, 0xF1B0u | ((i & 1) << 10) | (unsigned)(rn & 0xF));
                        out16(a, ((imm3 & 7) << 12) | 0x0F00u | imm8);
                    }
                }
            } else {
                int rm = parse_reg_a(&p);
                if (rn >= 0 && rn <= 7 && rm >= 0 && rm <= 7) {
                    out16(a, 0x4280 | ((rm & 7) << 3) | (rn & 7));
                } else if (rn >= 0 && rn <= 7 && rm >= 0 && rm <= 14) {
                    /* T2 16-bit "01000101 0 Rm Rn": Rm is the full four-bit
                     * field at bits 6:3, Rn only three bits at 2:0, and bit 7
                     * (N) stays 0 for CMP -- gas assembles "CMP r1, r9" as
                     * 0x4549.  Two earlier spellings of this branch were
                     * wrong: masking Rm with 7 truncated r8-r14, and putting
                     * Rm's bit 3 into bit 7 made the decoder read the operands
                     * swapped ("CMP r9, r7" as cmp r1, r15), which is what
                     * broke the -fopt-coalesce merge fixture. */
                    out16(a, 0x4500 | ((unsigned)(rm & 0xF) << 3) |
                             (unsigned)(rn & 7));
                } else if (rn >= 0 && rn <= 14 && rm >= 0 && rm <= 14) {
                    /* 32-bit CMP.W Rn, Rm.  Both registers are full width,
                     * but PC is not an operand of CMP. */
                    out16(a, 0xEBB0u | (unsigned)(rn & 0xF));
                    out16(a, 0x0F00u | (unsigned)(rm & 0xF));
                } else {
                    /* r15 is not a legal CMP operand in either width.  Keep
                     * the byte count pass 1 assigned (two bytes when Rn is
                     * low) so no label downstream moves. */
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "CMP does not take PC as an operand",
                              0,0,0,0,0,0);
                    a->hard_errors++;
                    if (rn >= 0 && rn <= 7) { out16(a, 0xBF00); }
                    else { out16(a, 0xBF00); out16(a, 0xBF00); }
                }
            }
        }
        else if (is_ldr_str_a(first)) {
            int is_load = 1;
            int kind = ldr_str_kind_a(first, &is_load);
            int rd = parse_reg_a(&p);
            ArmMemOp m;
            eat_comma_a(&p);
            if (*p == '=') {
                /* LDR rd, =label - emit MOVW+MOVT to load absolute address.
                 * .set symbols (e.g. __at variables) use their absolute address directly;
                 * code/data labels (e.g. .L_str_N) use g_flash_base + offset.
                 * g_flash_base is the first LR load address when --scatter is
                 * given, otherwise the default 0x08000000 (STM32F4 Flash). */
                char sym[64];
                int addr;
                int sn;
                p++;  /* skip '=' */
                sn = read_word_a(&p, sym, (int)sizeof(sym));
                (void)sn;
                addr = find_set_a(a, sym);
                if (addr >= 0) {
                    /* .set symbol - absolute address already (e.g. 0x40020800, 0x20000000) */
                } else {
                    int is_func = label_is_func_a(a, sym);
                    int label_addr = find_label_a(a, sym);
                    if (label_addr < 0) {
                        /* Not in this object: a cross-object address.  Baking 0
                         * here used to be a hard error, which made a single
                         * object that merely *names* another object's function
                         * impossible to assemble -- src/compiler.c does exactly
                         * that when it fills its backend vtable.  Record a
                         * relocation instead and let the linker write the real
                         * address; resolve_refs_a() still counts it, so a
                         * single-file .bin build keeps refusing (a baked 0 in a
                         * .bin is an image that jumps to the vector table). */
                        add_ref_a(a, a->pc, sym, is_func ? 11 : 10);
                        addr = (int)g_flash_base;   /* placeholder base */
                    } else {
                        /* code/data label - add Flash base address (scatter-aware),
                         * and set bit 0 for a function: a Thumb function pointer
                         * must carry it, or BLX branches into ARM state and the
                         * core faults on the first instruction. */
                        addr = (int)g_flash_base + label_addr;
                        if (is_func) addr |= 1;
                        /* --reloc-text: the number above assumes this object
                         * sits at g_flash_base.  In a multi-object link the
                         * linker places it somewhere else, and this is the only
                         * moment anybody knows which instruction holds the
                         * value -- flag it so the linker can add the
                         * difference.  Both instructions emitted below are
                         * always MOVW+MOVT (never the short MOV form), so the
                         * site is always patchable. */
                        if (g_config.enable_reloc_text)
                            add_ref_a(a, a->pc, ARM_RELOC_TEXT_NAME,
                                      ARM_RELOC_TEXT);
                    }
                }
                /* Emit MOVW rd, #low16 */
                {
                    unsigned imm = (unsigned)(addr & 0xFFFF);
                    unsigned ii = (imm >> 11) & 1;
                    unsigned imm4 = (imm >> 12) & 0xF;
                    unsigned imm3 = (imm >> 8) & 0x7;
                    unsigned imm8 = imm & 0xFF;
                    unsigned hi = 0xF240u | (ii << 10) | imm4;
                    unsigned lo = (imm3 << 12) | ((rd & 0xF) << 8) | imm8;
                    out16(a, hi); out16(a, lo);
                }
                /* Emit MOVT rd, #high16 */
                {
                    unsigned imm = (unsigned)((addr >> 16) & 0xFFFF);
                    unsigned ii = (imm >> 11) & 1;
                    unsigned imm4 = (imm >> 12) & 0xF;
                    unsigned imm3 = (imm >> 8) & 0x7;
                    unsigned imm8 = imm & 0xFF;
                    unsigned hi = 0xF2C0u | (ii << 10) | imm4;
                    unsigned lo = (imm3 << 12) | ((rd & 0xF) << 8) | imm8;
                    out16(a, hi); out16(a, lo);
                }
                skip_to_eol_a(&p);
                if (*p == '\n') p++;
                continue;
            }
            if (rd >= 0 && *p != '[') {
                /* LDR rd, <label> -- -fopt-litpool's literal load.  Same
                 * reach rule as the VLDR pool below: the encoding covers
                 * 0..4095 bytes from the aligned PC in steps of four, and an
                 * unreachable target is an error rather than a wrong value. */
                char sym[64];
                int addr, pbase, off;
                read_word_a(&p, sym, (int)sizeof(sym));
                addr = find_label_a(a, sym);
                if (addr < 0) {
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "LDR literal-pool target %sq must be a label in "
                              "this file", sym, 0,0,0,0,0);
                    a->hard_errors++;
                    out16(a, 0xBF00); out16(a, 0xBF00);
                } else {
                    /* Unaligned PC base on purpose: the 32-bit form takes a
                     * byte offset (0..4095, unscaled), unlike the 16-bit T1
                     * form whose imm8 counts words. */
                    pbase = (a->pc + 4) & ~3;
                    off = addr - pbase;
                    if (off < 0 || off > 4095) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "LDR literal-pool target %sq is %s bytes from "
                                  "the aligned PC; the encoding covers 0..4095 "
                                  "bytes", sym, diag_num(b1, off),
                                  0,0,0,0);
                        a->hard_errors++;
                        off = 0;
                    }
                    out16(a, 0xF8D0u | 15u);            /* LDR.W rt, [pc, #off] */
                    out16(a, ((unsigned)(rd & 0xF) << 12) | (unsigned)(off & 0xFFF));
                }
            } else {
                parse_memop_a(a, &p, &m, 0);
                emit_ldr_str_a(a, kind, is_load, rd, &m);
            }
        }
        else if (strieq_a(first, "BX")) {
            int rm = parse_reg_a(&p);
            out16(a, 0x4700 | ((rm & 0xF) << 3));
        }
        else if (strieq_a(first, "NOP")) {
            out16(a, 0xBF00);
        }
        else if (strieq_a(first, "IT") || strieq_a(first, "ITT") ||
                 strieq_a(first, "ITE") || strieq_a(first, "ITTT")) {
            /* IT block: encoding 0xBF{firstcond}{mask}.
             * firstcond: EQ=0,NE=1,CS/HS=2,CC/LO=3,MI=4,PL=5,VS=6,VC=7,
             *            HI=8,LS=9,GE=10,LT=11,GT=12,LE=13,AL=14
             *
             * mask[3:0] encodes both the IT block length (position of the
             * least-significant 1 bit) and per-instruction condition inversion:
             *   - For instruction i (1-indexed), if mask bit == firstcond[0],
             *     the instruction uses firstcond (Then); otherwise it uses
             *     NOT(firstcond) (Else).
             *
             * Correct masks (cb = firstcond[0]):
             *   IT   (1 instr):              1000 = 0x8
             *   ITT  (2 instrs, Then-Then):  cb 1 0 0  -> (cb<<3)|0x4
             *   ITE  (2 instrs, Then-Else): ~cb 1 0 0  -> ((~cb&1)<<3)|0x4
             *   ITTT (3 instrs, T-T-T):      cb cb 1 0 -> (cb<<3)|(cb<<2)|0x2
             *
             * BUGFIX #1: previously emitted 0xBF00 (NOP), making conditional
             *   MOVs unconditional (delay loops never exited).
             * BUGFIX #2: previously used fixed masks (ITT=0xC, ITE=0x4) which
             *   are only correct when firstcond[0]==1 (NE,LO,PL,VC,LS,LT,LE).
             *   For firstcond[0]==0 (EQ,HS,MI,VS,HI,GE,GT,AL) the conditions
             *   were silently inverted. E.g. ITE HS emitted 0xBF24 (acts as
             *   ITE LO HS) instead of 0xBF2C, flipping comparison results
             *   and making SysTick 500ms blink toggle at 1ms (invisible). */
            char cond[8];
            int cv = 14;  /* default AL */
            int cb;       /* firstcond[0] */
            int mask;
            skip_space_a(&p);
            read_word_a(&p, cond, sizeof(cond));
            if      (strieq_a(cond, "EQ")) cv = 0;
            else if (strieq_a(cond, "NE")) cv = 1;
            else if (strieq_a(cond, "HS") || strieq_a(cond, "CS")) cv = 2;
            else if (strieq_a(cond, "LO") || strieq_a(cond, "CC")) cv = 3;
            else if (strieq_a(cond, "MI")) cv = 4;
            else if (strieq_a(cond, "PL")) cv = 5;
            else if (strieq_a(cond, "VS")) cv = 6;
            else if (strieq_a(cond, "VC")) cv = 7;
            else if (strieq_a(cond, "HI")) cv = 8;
            else if (strieq_a(cond, "LS")) cv = 9;
            else if (strieq_a(cond, "GE")) cv = 10;
            else if (strieq_a(cond, "LT")) cv = 11;
            else if (strieq_a(cond, "GT")) cv = 12;
            else if (strieq_a(cond, "LE")) cv = 13;
            cb = cv & 1;
            if      (strieq_a(first, "IT"))   mask = 0x8;
            else if (strieq_a(first, "ITT"))  mask = (cb << 3) | 0x4;
            else if (strieq_a(first, "ITE"))  mask = ((cb ^ 1) << 3) | 0x4;
            else                              mask = (cb << 3) | (cb << 2) | 0x2; /* ITTT */
            out16(a, 0xBF00 | (cv << 4) | mask);
        }
        else if (strieq_a(first, "BLX")) {
            /* BLX <Rm>: 16-bit 0x4780 | Rm<<3 (Thumb-2 T1). The backend emits
             * this for an indirect call (obj->fnptr()), so without it every
             * function-pointer call became an "unknown mnemonic" and the whole
             * image failed to assemble. Only the register form exists here:
             * the label form is 32-bit and is never emitted by this backend,
             * so a non-register operand is reported rather than mistranslated. */
            int rm = parse_reg_a(&p);
            if (rm < 0) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "BLX needs a register operand", 0,0,0,0,0,0);
                a->hard_errors++;
                out16(a, 0xBF00);
            } else {
                out16(a, 0x4780 | ((rm & 0xF) << 3));
            }
        }
        else if (strieq_a(first, "BL")) {
            char name[64];
            read_label_name_a(&p, name, sizeof(name));
            {
                int addr = find_label_a(a, name);
                if (addr < 0) {
                    add_ref_a(a, a->pc, name, 1);
                    out16(a, 0xF000);
                    out16(a, 0xD000);
                } else {
                    emit_bl_a(a, addr);
                }
            }
        }
        else if (strieq_a(first, "B") || strieq_a(first, "BEQ") ||
                 strieq_a(first, "BNE") || strieq_a(first, "BLT") ||
                 strieq_a(first, "BGT") || strieq_a(first, "BLE") ||
                 strieq_a(first, "BGE") || strieq_a(first, "BCC") ||
                 strieq_a(first, "BCS") || strieq_a(first, "BHI") ||
                 strieq_a(first, "BLS") || strieq_a(first, "BLO") ||
                 strieq_a(first, "BHS")) {
            char name[64];
            int cond = -1;
            int is_uncond = (first[1] == 0);
            if (!is_uncond) {
                if (strieq_a(first, "BEQ")) cond = 0;
                else if (strieq_a(first, "BNE")) cond = 1;
                else if (strieq_a(first, "BCS")) cond = 2;
                else if (strieq_a(first, "BCC")) cond = 3;
                else if (strieq_a(first, "BGE")) cond = 10;
                else if (strieq_a(first, "BLT")) cond = 11;
                else if (strieq_a(first, "BGT")) cond = 12;
                else if (strieq_a(first, "BLE")) cond = 13;
                /* Unsigned comparisons: HI=8, LS=9, LO(CC)=3, HS(CS)=2.
                 * Verified: BHI = 0xD8xx, BLS = 0xD9xx, BLO = 0xD3xx,
                 * BHS = 0xD2xx in the 16-bit T1 form. */
                else if (strieq_a(first, "BHI")) cond = 8;
                else if (strieq_a(first, "BLS")) cond = 9;
                else if (strieq_a(first, "BLO")) cond = 3;
                else if (strieq_a(first, "BHS")) cond = 2;
            }
            read_label_name_a(&p, name, sizeof(name));
            {
                int addr = find_label_a(a, name);
#if ARKCC_FEATURE_OPT_BRANCH
                /* -fopt-branch: the plan was recorded by pass 1 in the
                 * same text order.  When an entry does not line up, fall
                 * back to the 32-bit encoding: a short branch the layout
                 * never reserved would shift every later instruction. */
                int shrink = 0;
                if (a->plan_branches) {
                    if (a->branch_ord < a->branch_count) {
                        AsmBranch *pl = &a->branches[a->branch_ord];
                        if (pl->cond == cond && ark_streq(pl->name, name))
                            shrink = pl->shrink;
                    }
                    a->branch_ord++;
                }
#else
                int shrink = 0;
#endif
                if (addr < 0) {
                    /* Forward reference: emit placeholder, resolve later.
                     * type=2: 32-bit B.W (T4, +-1MB), type=3: 32-bit B<cond>.W (T3, +-1MB).
                     * For type=3, cond is encoded in placeholder hi word
                     * (bits[9:6]) so resolve_refs_a can recover it. */
                    if (is_uncond) {
                        /* 32-bit B.W (T4) forward ref: type=2, 4-byte placeholder.
                         * resolve_refs_a will call emit_b_w_a to fill in the encoding. */
                        add_ref_a(a, a->pc, name, 2);
                        out16(a, 0xF000);
                        out16(a, 0x9000);
                    } else {
                        /* 32-bit B<cond>.W (T3) forward ref: type=3, 4-byte placeholder.
                         * cond encoded in hi word bits[9:6] for resolve_refs_a. */
                        add_ref_a(a, a->pc, name, 3);
                        out16(a, 0xF000u | (unsigned)(cond << 6));
                        out16(a, 0x8000);
                    }
                }
#if ARKCC_FEATURE_OPT_BRANCH
                else if (shrink) {
                    /* -fopt-branch: 16-bit form, range guaranteed by the
                     * plan (both directions; local labels are all known
                     * here because pass 1 collected the whole file). */
                    emit_b16_a(a, cond, addr);
                }
#endif
                else {
                    /* 32-bit form: 1MB range, no truncation */
                    if (is_uncond) {
                        emit_b_w_a(a, addr);
                    } else {
                        emit_bcond_w_a(a, cond, addr);
                    }
                }
            }
        }
        else if (strieq_a(first, "CPSID") || strieq_a(first, "CPSIE")) {
            /* CPS T1 16-bit: bit4=change(1=ID,0=IE), bit1=affect_i, bit0=affect_f
             *   CPSID i = 0xB672, CPSIE i = 0xB662, CPSID f = 0xB671, CPSIE f = 0xB661
             * Note: base 0xB660 already has bit5=1; change is bit4 (0x10), NOT bit5.
             * Previously NOP'd, so Error_Handler's CPSID i failed to mask
             * interrupts and HAL_Init's CPSIE i failed to enable them. */
            int is_id = strieq_a(first, "CPSID");
            int affect_i = 0, affect_f = 0;
            skip_space_a(&p);
            while (*p && *p != '\n' && *p != ';') {
                if (*p == 'i' || *p == 'I') affect_i = 1;
                else if (*p == 'f' || *p == 'F') affect_f = 1;
                p++;
            }
            out16(a, 0xB660 | (is_id ? 0x10 : 0) | (affect_i ? 0x2 : 0) | (affect_f ? 0x1 : 0));
        }
        else if (strieq_a(first, "DMB") || strieq_a(first, "DSB") || strieq_a(first, "ISB")) {
            /* T1 32-bit barriers: 0xF3BF 0x8F4x/5x/6x, option=0xF for SY.
             *   DMB SY = F3BF 8F5F, DSB SY = F3BF 8F4F, ISB SY = F3BF 8F6F.
             * Pass1 op_size_a returns 4 for these. Previously NOP'd (2 bytes),
             * causing pass1/pass2 size mismatch and silent instruction drops. */
            unsigned lo_base;
            if      (strieq_a(first, "DMB")) lo_base = 0x8F50;
            else if (strieq_a(first, "DSB")) lo_base = 0x8F40;
            else                             lo_base = 0x8F60;  /* ISB */
            out16(a, 0xF3BF);
            out16(a, lo_base | 0xF);
        }
        else if (strieq_a(first, "SEV") || strieq_a(first, "WFE") || strieq_a(first, "WFI")) {
            /* 16-bit hint instructions (no operands).
             *   SEV = 0xBF40, WFE = 0xBF20, WFI = 0xBF30.
             * Used by HAL_PWR_EnterSLEEPMode/STOPMode/STANDBYMode. */
            if      (strieq_a(first, "SEV")) out16(a, 0xBF40);
            else if (strieq_a(first, "WFE")) out16(a, 0xBF20);
            else                             out16(a, 0xBF30);  /* WFI */
        }
        else if (strieq_a(first, "REV") || strieq_a(first, "REV16") || strieq_a(first, "REVSH")) {
            /* T1 16-bit: 1011 1010 op Rm Rd, where op=00(REV),01(REV16),11(REVSH).
             *   REV=0xBA00, REV16=0xBA40, REVSH=0xBAC0. */
            int rd = parse_reg_a(&p);
            int rm;
            unsigned base;
            eat_comma_a(&p);
            rm = parse_reg_a(&p);
            if      (strieq_a(first, "REV"))   base = 0xBA00;
            else if (strieq_a(first, "REV16")) base = 0xBA40;
            else                               base = 0xBAC0;  /* REVSH */
            out16(a, base | ((rm & 7) << 3) | (rd & 7));
        }
        else if (strieq_a(first, "RRX")) {
            /* 32-bit: MOV Rd, Rm, RRX = 0xEA4F (Rd<<12) 0x30 Rm.
             * Pass1 op_size_a returns 4. */
            int rd = parse_reg_a(&p);
            int rm;
            eat_comma_a(&p);
            rm = parse_reg_a(&p);
            out16(a, 0xEA4F);
            out16(a, (unsigned)((rd & 0xF) << 12) | 0x30 | (rm & 0xF));
        }
        /* ===== #1 FIX: VFP floating-point instruction encoders =====
         * Previously ALL VFP instructions fell through to NOP (0xBF00),
         * making every float operation a no-op. Now each is properly
         * encoded as a 32-bit Thumb-2 VFP instruction.
         *
         * VFP register encoding (S<n>, n=0..31 ; D<n>, n=0..15):
         *   the 4-bit register field holds n[4:1] for single precision and
         *   the whole n for double precision; the neighbouring "half" bit
         *   holds n[0] for single precision and is 0 for double.
         *     Vd = field at bits15:12, half at bit22
         *     Vn = field at bits19:16, half at bit7
         *     Vm = field at bits3:0,   half at bit5
         *   The split is done by ark_vfp_nib()/ark_vfp_half(); the bit
         *   positions above are the ones those helpers feed into.
         * sz bit (bit8): 0=F32 single, 1=F64 double. */
        else if (strieq_a(first, "VMOV")) {
            /* VMOV Sn, Rt (core -> VFP) or VMOV Rt, Sn (VFP -> core) */
            skip_space_a(&p);
            if (*p == 's' || *p == 'S') {
                /* VMOV Sn, Rt — core register to VFP single register */
                int sn = parse_vfp_sreg_a(&p);
                int rt;
                unsigned vn, n_bit, hi, lo;
                if (sn < 0) sn = 0;
                eat_comma_a(&p);
                rt = parse_reg_a(&p);
                vn = ark_vfp_nib(sn, 0);
                n_bit = ark_vfp_half(sn, 0);
                hi = 0xEE00u | vn;
                lo = 0x0A10u | (unsigned)((rt & 0xF) << 12) | (n_bit << 7);
                out16(a, hi);
                out16(a, lo);
            } else {
                /* VMOV Rt, Sn — VFP single register to core register */
                int rt = parse_reg_a(&p);
                int sn;
                unsigned vn, n_bit, hi, lo;
                eat_comma_a(&p);
                sn = parse_vfp_sreg_a(&p);
                if (sn < 0) sn = 0;
                vn = ark_vfp_nib(sn, 0);
                n_bit = ark_vfp_half(sn, 0);
                hi = 0xEE10u | vn;   /* bit20=1 means VFP->core */
                lo = 0x0A10u | (unsigned)((rt & 0xF) << 12) | (n_bit << 7);
                out16(a, hi);
                out16(a, lo);
            }
        }
        else if (strieq_a(first, "VADD") || strieq_a(first, "VSUB") ||
                 strieq_a(first, "VMUL") || strieq_a(first, "VDIV")) {
            /* VOP.F32 Sd,Sn,Sm  or  VOP.F64 Dd,Dn,Dm */
            char suf[16];
            int is_f64;
            unsigned base;
            int sd, sn, sm;
            unsigned d, vd, n_bit, vn, m, vm;
            unsigned hi, lo;
            read_vfp_suffix_a(&p, suf, (int)sizeof(suf));
            is_f64 = strieq_a(suf, "F64");
            if      (strieq_a(first, "VADD")) base = is_f64 ? 0xEE300B00u : 0xEE300A00u;
            else if (strieq_a(first, "VSUB")) base = is_f64 ? 0xEE300B40u : 0xEE300A40u;
            else if (strieq_a(first, "VMUL")) base = is_f64 ? 0xEE200B00u : 0xEE200A00u;
            /* FIX(vfp-encode): VDIV was 0xEE000A40/0xEE000B40 = VMLS, so every float division lost its division. */
            else                              base = is_f64 ? 0xEE800B00u : 0xEE800A00u;
            if (is_f64) {
                sd = parse_vfp_dreg_a(&p); eat_comma_a(&p);
                sn = parse_vfp_dreg_a(&p); eat_comma_a(&p);
                sm = parse_vfp_dreg_a(&p);
            } else {
                sd = parse_vfp_sreg_a(&p); eat_comma_a(&p);
                sn = parse_vfp_sreg_a(&p); eat_comma_a(&p);
                sm = parse_vfp_sreg_a(&p);
            }
            if (sd < 0) sd = 0; if (sn < 0) sn = 0; if (sm < 0) sm = 0;
            d     = ark_vfp_half(sd, is_f64);   /* bit22   = Sd[0] */
            vd    = ark_vfp_nib (sd, is_f64);   /* bits15:12 = Sd[4:1] */
            n_bit = ark_vfp_half(sn, is_f64);   /* bit7    = Sn[0] */
            vn    = ark_vfp_nib (sn, is_f64);   /* bits19:16 = Sn[4:1] */
            m     = ark_vfp_half(sm, is_f64);   /* bit5    = Sm[0] */
            vm    = ark_vfp_nib (sm, is_f64);   /* bits3:0 = Sm[4:1] */
            hi = (base >> 16) | (d << 6) | vn;
            lo = (base & 0xFFFF) | (vd << 12) | (n_bit << 7) | (m << 5) | vm;
            out16(a, hi);
            out16(a, lo);
        }
        else if (strieq_a(first, "VCVT")) {
            /* VCVT register conversions.  Every base below is the encoding for
             * the S0/D0 form, measured with armasm (h7test/v3.lst, v4.lst):
             *   VCVT.S32.F32 = 0xEEBD0AC0   VCVT.U32.F32 = 0xEEBC0AC0
             *   VCVT.F32.S32 = 0xEEB80AC0   VCVT.F32.U32 = 0xEEB80A40
             *   VCVT.S32.F64 = 0xEEBD0BC0   VCVT.U32.F64 = 0xEEBC0BC0
             *   VCVT.F64.S32 = 0xEEB80BC0   VCVT.F64.U32 = 0xEEB80B40
             *   VCVT.F32.F64 = 0xEEB70BC0   VCVT.F64.F32 = 0xEEB70AC0
             * FIX(vfp-encode): the U32 variants and the .F32.F64/.F64.F32 pairs
             * used to fall through to the S32.F32 base, so unsigned
             * conversions and float<->double casts silently became S32.F32. */
            char suf[32];
            unsigned base;
            int sd = 0, sm = 0;
            int dst_dbl, src_dbl;
            unsigned d, vd, m, vm;
            unsigned hi, lo;
            read_vfp_suffix_a(&p, suf, (int)sizeof(suf));
            if      (strieq_a(suf, "S32F32")) base = 0xEEBD0AC0u;
            else if (strieq_a(suf, "U32F32")) base = 0xEEBC0AC0u;
            else if (strieq_a(suf, "F32S32")) base = 0xEEB80AC0u;
            else if (strieq_a(suf, "F32U32")) base = 0xEEB80A40u;
            else if (strieq_a(suf, "S32F64")) base = 0xEEBD0BC0u;
            else if (strieq_a(suf, "U32F64")) base = 0xEEBC0BC0u;
            else if (strieq_a(suf, "F64S32")) base = 0xEEB80BC0u;
            else if (strieq_a(suf, "F64U32")) base = 0xEEB80B40u;
            else if (strieq_a(suf, "F32F64")) base = 0xEEB70BC0u;
            else if (strieq_a(suf, "F64F32")) base = 0xEEB70AC0u;
            else {
                /* Do not guess: an unknown suffix used to be encoded as
                 * VCVT.S32.F32, i.e. a silently wrong operation. */
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "unsupported VCVT suffix", 0,0,0,0,0,0);
                a->hard_errors++;
                base = 0xEEBD0AC0u;
            }
            dst_dbl = strieq_a(suf, "F64S32") || strieq_a(suf, "F64U32") ||
                      strieq_a(suf, "F64F32");
            src_dbl = strieq_a(suf, "S32F64") || strieq_a(suf, "U32F64") ||
                      strieq_a(suf, "F32F64");
            if (dst_dbl) { sd = parse_vfp_dreg_a(&p); eat_comma_a(&p); }
            else         { sd = parse_vfp_sreg_a(&p); eat_comma_a(&p); }
            if (src_dbl) sm = parse_vfp_dreg_a(&p);
            else         sm = parse_vfp_sreg_a(&p);
            if (sd < 0) sd = 0; if (sm < 0) sm = 0;
            d  = ark_vfp_half(sd, dst_dbl);
            vd = ark_vfp_nib (sd, dst_dbl);
            m  = ark_vfp_half(sm, src_dbl);
            vm = ark_vfp_nib (sm, src_dbl);
            hi = (base >> 16) | (d << 6);
            lo = (base & 0xFFFF) | (vd << 12) | (m << 5) | vm;
            out16(a, hi);
            out16(a, lo);
        }
        else if (strieq_a(first, "VCMP")) {
            /* VCMP.F32 Sd,Sm / VCMP.F64 Dd,Dm / VCMP.F32|F64 Sd,#0.0
             * Bases measured with armasm (h7test/v3.lst, v5.lst):
             *   VCMP.F32 Sd,Sm    = 0xEEB40A40 + regs
             *   VCMP.F64 Dd,Dm    = 0xEEB40B40 + regs
             *   VCMP.F32 Sd,#0.0  = 0xEEB50A40 + Sd
             *   VCMP.F64 Dd,#0.0  = 0xEEB50B40 + Dd
             * FIX(vfp-encode): "#0.0" used to make parse_vfp_sreg_a() return
             * -1, which was clamped to 0, i.e. the compare silently became
             * "against S0/D0".  It is now encoded properly, and any other
             * immediate is a hard error instead of a wrong answer. */
            char suf[16];
            int is_f64, cmp_zero = 0;
            unsigned base;
            int sd, sm = 0;
            unsigned d, vd, m, vm;
            unsigned hi, lo;
            read_vfp_suffix_a(&p, suf, (int)sizeof(suf));
            is_f64 = strieq_a(suf, "F64");
            base = is_f64 ? 0xEEB40B40u : 0xEEB40A40u;
            if (is_f64) sd = parse_vfp_dreg_a(&p);
            else        sd = parse_vfp_sreg_a(&p);
            if (sd < 0) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "bad destination register for VCMP", 0,0,0,0,0,0);
                a->hard_errors++;
                sd = 0;
            }
            eat_comma_a(&p);
            skip_space_a(&p);
            if (*p == '#') {
                int nonzero = 0, ndig = 0;
                p++;
                skip_space_a(&p);
                if (*p == '-') p++;
                while ((*p >= '0' && *p <= '9') || *p == '.') {
                    if (*p >= '1' && *p <= '9') nonzero = 1;
                    if (*p != '.') ndig++;
                    p++;
                }
                if (nonzero || ndig == 0) {
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "VCMP supports only #0.0 as an immediate operand",
                              0,0,0,0,0,0);
                    a->hard_errors++;
                }
                cmp_zero = 1;
                base = is_f64 ? 0xEEB50B40u : 0xEEB50A40u;
            } else if (is_f64) {
                sm = parse_vfp_dreg_a(&p);
            } else {
                sm = parse_vfp_sreg_a(&p);
            }
            if (!cmp_zero && sm < 0) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "bad operand register for VCMP", 0,0,0,0,0,0);
                a->hard_errors++;
                sm = 0;
            }
            d  = ark_vfp_half(sd, is_f64);
            vd = ark_vfp_nib (sd, is_f64);
            m  = cmp_zero ? 0u : ark_vfp_half(sm, is_f64);
            vm = cmp_zero ? 0u : ark_vfp_nib (sm, is_f64);
            hi = (base >> 16) | (d << 6);
            lo = (base & 0xFFFF) | (vd << 12) | (m << 5) | vm;
            out16(a, hi);
            out16(a, lo);
        }
        else if (strieq_a(first, "VMRS")) {
            /* VMRS APSR_nzcv, FPSCR = 0xEEF1FA10.
             * The T1 encoding is 1110 1110 1111 0001 1010 0001 1111 1111;
             * this used to write 0xFEF1 as the first halfword (bit 12 set),
             * which is not an instruction at all: every float comparison
             * raised UNDEFINSTR on the board (CFSR=0x00010000 at the VMRS,
             * measured on the H743 running a double comparison).
             * Only the APSR form is emitted by this backend, and it is the
             * only form encoded here: "VMRS Rn, FPSCR" asks for a different
             * instruction, so it is refused instead of silently rewritten. */
            char rn_m[32], sys_m[32];
            rn_m[0] = 0; sys_m[0] = 0;
            read_label_name_a(&p, rn_m, (int)sizeof(rn_m));
            if (*p == ',') {
                p++;
                read_label_name_a(&p, sys_m, (int)sizeof(sys_m));
            }
            if (!strieq_a(rn_m, "APSR_NZCV") || !strieq_a(sys_m, "FPSCR")) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "VMRS is encoded here only as 'VMRS APSR_nzcv, FPSCR'; "
                          "'VMRS %s, %s' would be a different instruction",
                          rn_m, sys_m, 0,0,0,0);
                a->hard_errors++;
            }
            out16(a, 0xEEF1);
            out16(a, 0xFA10);
        }
        else if (strieq_a(first, "VNEG") || strieq_a(first, "VABS") ||
                 strieq_a(first, "VSQRT")) {
            /* VNEG/VABS/VSQRT .F32 Sd,Sm  or  .F64 Dd,Dm */
            char suf[16];
            int is_f64;
            unsigned base;
            int sd, sm;
            unsigned d, vd, m, vm;
            unsigned hi, lo;
            read_vfp_suffix_a(&p, suf, (int)sizeof(suf));
            is_f64 = strieq_a(suf, "F64");
            /* FIX(vfp-encode): VNEG is 0xEEB10A40/0xEEB10B40 (0xEEB10AC0 is VSQRT). */
            if      (strieq_a(first, "VNEG"))  base = is_f64 ? 0xEEB10B40u : 0xEEB10A40u;
            else if (strieq_a(first, "VABS"))  base = is_f64 ? 0xEEB00BC0u : 0xEEB00AC0u;
            /* FIX(vfp-encode): VSQRT is 0xEEB10AC0/0xEEB10BC0 (0xEEB11AC0 does not exist). */
            else                               base = is_f64 ? 0xEEB10BC0u : 0xEEB10AC0u;
            if (is_f64) {
                sd = parse_vfp_dreg_a(&p); eat_comma_a(&p);
                sm = parse_vfp_dreg_a(&p);
            } else {
                sd = parse_vfp_sreg_a(&p); eat_comma_a(&p);
                sm = parse_vfp_sreg_a(&p);
            }
            if (sd < 0) sd = 0; if (sm < 0) sm = 0;
            d  = ark_vfp_half(sd, is_f64);
            vd = ark_vfp_nib (sd, is_f64);
            m  = ark_vfp_half(sm, is_f64);
            vm = ark_vfp_nib (sm, is_f64);
            hi = (base >> 16) | (d << 6);
            lo = (base & 0xFFFF) | (vd << 12) | (m << 5) | vm;
            out16(a, hi);
            out16(a, lo);
        }
        else if (strieq_a(first, "VLDR") || strieq_a(first, "VSTR")) {
            /* VLDR/VSTR Sd, [Rn, #imm]  — 32-bit T1 encoding.
             * Base: VLDR.F32 = 0xED900A00, VSTR.F32 = 0xED800A00.
             * imm8 = offset>>2 (word-aligned). F64 sets bit 8 (sz). */
            /* The register name, not the optional suffix, says whether this is
             * a single or a double transfer: reading only the suffix turned
             * every `vldr d0, ...` into a transfer of S0.  A suffix that
             * contradicts the register is a typo and is refused. */
            char suf[16];
            char sym[64];
            int is_f64;
            unsigned base;
            int sd, rn, imm;
            unsigned d, vd;
            unsigned hi, lo;
            unsigned imm8;
            int is_load = strieq_a(first, "VLDR");
            read_vfp_suffix_a(&p, suf, (int)sizeof(suf));
            /* armasm also accepts the ".32"/".64" spelling of the same suffix. */
            skip_space_a(&p);
            is_f64 = (p[0] == 'd' || p[0] == 'D');
            if ((strieq_a(suf, "F64") || strieq_a(suf, "64")) && !is_f64) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "VLDR/VSTR.F64 needs a D register", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            if ((strieq_a(suf, "F32") || strieq_a(suf, "32")) && is_f64) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "VLDR/VSTR.F32 needs an S register", 0,0,0,0,0,0);
                a->hard_errors++;
            }
            if (is_f64) sd = parse_vfp_dreg_a(&p);
            else        sd = parse_vfp_sreg_a(&p);
            if (sd < 0) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "VLDR/VSTR needs an S or D register", 0,0,0,0,0,0);
                a->hard_errors++;
                sd = 0;
            }
            if (is_f64) base = is_load ? 0xED900B00u : 0xED800B00u;
            else        base = is_load ? 0xED900A00u : 0xED800A00u;
            eat_comma_a(&p);
            skip_space_a(&p);
            imm = 0;
            if (*p == '[') {
                p++;
                skip_space_a(&p);
                rn = parse_reg_a(&p);
                if (rn < 0) {
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "VLDR/VSTR needs a base register inside []",
                              0,0,0,0,0,0);
                    a->hard_errors++;
                    rn = 15;
                }
                skip_space_a(&p);
                if (*p == ',') {
                    p++;
                    skip_space_a(&p);
                    if (*p == '#') imm = parse_imm_a(&p);
                    else {
                        /* Register-offset addressing ([Rn, Rm]) has no encoder
                         * here.  Ignoring Rm would silently address the base
                         * register instead, so refuse and let the author write
                         * the address arithmetic out. */
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "register-offset addressing ([Rn, Rm]) does "
                                  "not exist for this instruction in Thumb; compute "
                                  "the address with ADD first", 0,0,0,0,0,0);
                        a->hard_errors++;
                    }
                }
                skip_space_a(&p);
                if (*p == ']') p++;
                check_no_index_writeback_a(a, &p);
            } else {
                /* Literal pool: `vldr s0, =label` / `vldr s0, label`.  Both
                 * passes already know every label in the file, so this is
                 * resolved here rather than left to a relocation.  A target
                 * that is not in this file, or one too far away, is an error:
                 * encoding offset 0 instead would read the wrong address. */
                int addr;
                if (*p == '=') {
                    /* `=label` asks for the ADDRESS of the label, which is
                     * what LDR does; VLDR reads the value stored there, so a
                     * bare label is the right spelling and this one is a
                     * misunderstanding worth reporting. */
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "VLDR takes a bare label, not '=label': it loads "
                              "from that address", 0,0,0,0,0,0);
                    a->hard_errors++;
                    p++;
                }
                if (!is_load) {
                    /* VSTR <Dd>, <label> selects the pc-relative form, which the
                     * ARM ARM makes UNPREDICTABLE for stores. */
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "VSTR needs a base register ([Rn, #imm]); the "
                              "pc-relative store form is UNPREDICTABLE",
                              0,0,0,0,0,0);
                    a->hard_errors++;
                }
                skip_space_a(&p);
                read_word_a(&p, sym, (int)sizeof(sym));
                addr = find_label_a(a, sym);
                if (addr < 0) {
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "VLDR/VSTR literal-pool target %sq must be a label in "
                              "this file", sym, 0,0,0,0,0);
                    a->hard_errors++;
                } else {
                    int pbase = (a->pc + 4) & ~3;
                    imm = addr - pbase;
                    if (imm < 0 || imm > 1020 || (imm & 3) != 0) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "VLDR/VSTR target %sq is %s bytes from the aligned "
                                  "PC; the encoding covers 0..1020 in steps of 4",
                                  sym, diag_num(b1, imm), 0,0,0,0);
                        a->hard_errors++;
                        imm = 0;
                    }
                }
                rn = 15;
            }
            if (imm < 0 || imm > 1020 || (imm & 3) != 0) {
                char b1[12];
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "VLDR/VSTR offset %s is not encodable (0..1020, step 4)",
                          diag_num(b1, imm), 0,0,0,0,0);
                a->hard_errors++;
                imm = 0;
            }
            d  = ark_vfp_half(sd, is_f64);
            vd = ark_vfp_nib (sd, is_f64);
            imm8 = (unsigned)((imm >> 2) & 0xFF);
            hi = (base >> 16) | (d << 6) | (unsigned)(rn & 0xF);
            lo = (base & 0xFFFF) | (vd << 12) | imm8;
            out16(a, hi);
            out16(a, lo);
        }
        else if (strieq_a(first, "TST")) {
            /* TST (register): 16-bit T1 0100000000 Rm Rn for r0-r7,
             * 32-bit T2 0xEA1n_0F0m for high registers.
             * Encodings verified against armasm: TST r4,r1 = 0x420C,
             * TST r8,r9 = 0xEA180F09, TST r0,r12 = 0xEA100F0C. */
            int rn = parse_reg_a(&p);
            int rm;
            eat_comma_a(&p);
            rm = parse_reg_a(&p);
            if (rn >= 0 && rn <= 7 && rm >= 0 && rm <= 7) {
                out16(a, 0x4200 | ((rm & 7) << 3) | (rn & 7));
            } else if (rn >= 0 && rm >= 0) {
                out16(a, 0xEA10 | (rn & 0xF));
                out16(a, 0x0F00 | (rm & 0xF));
            } else {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "bad register operand for TST", 0,0,0,0,0,0);
                a->hard_errors++;
                out16(a, 0xBF00);
            }
        }
        else if (strieq_a(first, "CLZ")) {
            /* CLZ Rd, Rm: 32-bit T1 111110101011 Rm 1111 1000 Rd 0000.
             * Verified: CLZ r2,r0 = 0xFAB0F280, CLZ r12,r11 = 0xFABBFC8B. */
            int rd = parse_reg_a(&p);
            int rm;
            eat_comma_a(&p);
            rm = parse_reg_a(&p);
            if (rd >= 0 && rm >= 0) {
                out16(a, 0xFAB0 | (rm & 0xF));
                out16(a, 0xF080 | ((rd & 0xF) << 8) | (rm & 0xF));
            } else {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "bad register operand for CLZ", 0,0,0,0,0,0);
                a->hard_errors++;
                out16(a, 0xBF00);
                out16(a, 0xBF00);
            }
        }
        else if (strieq_a(first, "RBIT")) {
            /* RBIT Rd, Rm: 32-bit T1 111110101001 Rm 1111 Rd 1010 Rm.
             * Verified with armasm 5.06u7 (Cortex-M7):
             *   RBIT r0,r0  = 0xFA90F0A0   RBIT r3,r1   = 0xFA91F3A1
             *   RBIT r9,r12 = 0xFA9CF9AC */
            int rd = parse_reg_a(&p);
            int rm;
            eat_comma_a(&p);
            rm = parse_reg_a(&p);
            if (rd >= 0 && rm >= 0) {
                out16(a, 0xFA90 | (rm & 0xF));
                out16(a, 0xF0A0 | ((rd & 0xF) << 8) | (rm & 0xF));
            } else {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "bad register operand for RBIT", 0,0,0,0,0,0);
                a->hard_errors++;
                out16(a, 0xBF00);
                out16(a, 0xBF00);
            }
        }
        else if (strieq_a(first, "SXTB") || strieq_a(first, "SXTH") ||
                 strieq_a(first, "UXTB") || strieq_a(first, "UXTH")) {
            /* Sign/zero extend: 16-bit T1 (0xB240/0xB200/0xB2C0/0xB280)
             * for low registers, 32-bit T2 (0xFA4F/0xFA0F/0xFA5F/0xFA1F
             * F080 | Rd<<8 | Rm) otherwise.
             * Verified: SXTB r7,r5 = 0xB26F, SXTH r6,r3 = 0xB21E,
             *           UXTB r1,r2 = 0xB2D1, UXTH r0,r7 = 0xB2B8,
             *           SXTB r0,r8 = 0xFA4FF088, UXTH r9,r3 = 0xFA1FF983. */
            int rd = parse_reg_a(&p);
            int rm;
            unsigned lo_base = 0xB200u;
            unsigned hi_base = 0xFA0Fu;
            if (strieq_a(first, "SXTB")) { lo_base = 0xB240u; hi_base = 0xFA4Fu; }
            else if (strieq_a(first, "UXTB")) { lo_base = 0xB2C0u; hi_base = 0xFA5Fu; }
            else if (strieq_a(first, "UXTH")) { lo_base = 0xB280u; hi_base = 0xFA1Fu; }
            eat_comma_a(&p);
            rm = parse_reg_a(&p);
            if (rd >= 0 && rd <= 7 && rm >= 0 && rm <= 7) {
                out16(a, lo_base | ((rm & 7) << 3) | (rd & 7));
            } else if (rd >= 0 && rm >= 0) {
                out16(a, hi_base | (rm & 0xF));
                out16(a, 0xF080 | ((rd & 0xF) << 8) | (rm & 0xF));
            } else {
                {
                    char mn[9];
                    int mi;
                    for (mi = 0; mi < 8 && first[mi]; mi++) mn[mi] = first[mi];
                    mn[mi] = 0;
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "bad register operand for %s", mn, 0,0,0,0,0);
                }
                a->hard_errors++;
                out16(a, 0xBF00);
                out16(a, 0xBF00);
            }
        }
        else if (strieq_a(first, "BKPT")) {
            /* BKPT #imm8: 0xBE00 | imm8. On Cortex-M this - not SVC 0xAB -
             * is the semihosting trap: QEMU only intercepts SVC 0xAB for
             * A/R profile cores and sends BKPT 0xAB to the semihosting
             * monitor on M-profile. Verified: BKPT #0xab = 0xBEAB (armasm
             * 5.06 golden bytes). */
            int imm;
            int ok = 0;
            skip_space_a(&p);
            imm = parse_imm_opt_hash_a(&p, &ok);
            if (!ok || imm < 0 || imm > 255) {
                if (!ok)
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "BKPT needs a numeric immediate", 0,0,0,0,0,0);
                else
                    {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "BKPT immediate %s out of range 0..255",
                                  diag_num(b1, imm), 0,0,0,0,0);
                    }
                a->hard_errors++;
                imm = 0;
            }
            out16(a, 0xBE00 | (imm & 0xFF));
        }
        else if (strieq_a(first, "SVC")) {
            /* SVC #imm8: 0xDF00 | imm8. Verified: SVC #18 = 0xDF12.
             * The '#' is optional (armasm accepts "SVC 0xAB"), but the operand
             * must be a number: a missing operand used to encode SVC #0, which
             * silently breaks semihosting calls at run time. */
            int imm;
            int ok = 0;
            skip_space_a(&p);
            imm = parse_imm_opt_hash_a(&p, &ok);
            if (!ok || imm < 0 || imm > 255) {
                if (!ok)
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "SVC needs a numeric immediate", 0,0,0,0,0,0);
                else
                    {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "SVC immediate %s out of range 0..255",
                                  diag_num(b1, imm), 0,0,0,0,0);
                    }
                a->hard_errors++;
                imm = 0;
            }
            out16(a, 0xDF00 | (imm & 0xFF));
        }
        else if (strieq_a(first, "MOVS")) {
            /* MOVS Rd,#imm: 16-bit 0x2000|Rd<<8|imm8, 32-bit MOVS.W
             * (0xF05F base, S=1) otherwise.
             * MOVS Rd,Rm: 16-bit 0x0000|Rm<<3|Rd (LSLS Rd,Rm,#0 alias),
             * 32-bit 0xEA5F_0n0m for high registers.
             * Verified: MOVS r0,#42 = 0x202A, MOVS r5,#7 = 0x2507,
             *           MOVS r0,r1 = 0x0008, MOVS r12,r3 = 0xEA5F0C03. */
            int rd = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                if (rd >= 0 && rd <= 7 && imm >= 0 && imm <= 255) {
                    out16(a, 0x2000 | ((rd & 7) << 8) | (imm & 0xFF));
                } else {
                    unsigned i, imm3, imm8;
                    if (rd < 0 || !thumb_imm12_a((unsigned)imm, &i, &imm3, &imm8)) {
                        {
                            char b1[12], b2[12];
                            diag_tool(DIAG_SEV_ERROR, "arkcc",
                                      "MOVS immediate %s (Rd=r%s) cannot be encoded",
                                      diag_num(b1, imm), diag_num(b2, rd),
                                      0,0,0,0);
                        }
                        a->hard_errors++;
                        out16(a, 0xBF00);
                        out16(a, 0xBF00);
                    } else {
                        out16(a, 0xF05F | ((i & 1) << 10));
                        out16(a, ((imm3 & 7) << 12) | ((rd & 0xF) << 8) | imm8);
                    }
                }
            } else {
                int rm = parse_reg_a(&p);
                if (rd >= 0 && rd <= 7 && rm >= 0 && rm <= 7) {
                    out16(a, 0x0000 | ((rm & 7) << 3) | (rd & 7));
                } else if (rd >= 0 && rm >= 0) {
                    out16(a, 0xEA5F);
                    out16(a, ((rd & 0xF) << 8) | (rm & 0xF));
                } else {
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "bad register operand for MOVS", 0,0,0,0,0,0);
                    a->hard_errors++;
                    out16(a, 0xBF00);
                }
            }
        }
        else if (strieq_a(first, "SADD16")) {
            /* SADD16 Rd, Rn, Rm: 0xFA90_F000|Rn<<16|Rd<<8|Rm.
             * Verified: SADD16 r0,r0,r1 = 0xFA90F001,
             *           SADD16 r3,r7,r5 = 0xFA97F305. */
            int rd = parse_reg_a(&p);
            int rn, rm;
            eat_comma_a(&p);
            rn = parse_reg_a(&p);
            eat_comma_a(&p);
            rm = parse_reg_a(&p);
            if (rd >= 0 && rn >= 0 && rm >= 0) {
                out16(a, 0xFA90 | (rn & 0xF));
                out16(a, 0xF000 | ((rd & 0xF) << 8) | (rm & 0xF));
            } else {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "bad register operand for SADD16", 0,0,0,0,0,0);
                a->hard_errors++;
                out16(a, 0xBF00);
                out16(a, 0xBF00);
            }
        }
        else {
            /* Unknown mnemonic. This used to silently emit a 16-bit NOP, which
             * turned a typo or an unimplemented instruction into a program that
             * still compiled and linked but did something else. Report it and
             * keep failing at the end of assembly. A NOP is still emitted so
             * that label addresses stay close to the intent and later code does
             * not cascade with bogus addresses. */
            {
                char mn[33];
                char b1[12];
                int mi;
                for (mi = 0; mi < 32 && first[mi]; mi++) mn[mi] = first[mi];
                mn[mi] = 0;
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "unknown mnemonic %sq at code offset %s "
                          "(no instruction emitted)", mn, diag_num(b1, a->pc),
                          0,0,0,0);
            }
            a->hard_errors++;
            out16(a, 0xBF00);
        }
        skip_to_eol_a(&p);
        if (*p == '\n') p++;
    }
    /* Self-check: the size pass and the emit pass must agree on the total
     * length of the text.  A per-line disagreement moves every label after
     * that line by 2 or 4 bytes, which is how "ADDS r0, r0, r9" used to be
     * encoded as the two-byte "adds r0, r0, r1" while pass 1 had already
     * counted four -- a silent wrong answer that only showed up as a branch
     * landing two bytes off.  One comparison covers the whole class. */
    if (a->pc != a->pass1_size) {
        char b1[16], b2[16];
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "assembler size pass disagrees with the emit pass "
                  "(%s bytes laid out, %s emitted): some line is encoded at a "
                  "different width than pass 1 counted",
                  diag_num(b1, a->pass1_size), diag_num(b2, a->pc), 0,0,0,0);
        a->hard_errors++;
    }
}

/* Number of references this object could not resolve to a label.  In -c mode
 * they become linker relocations; in a single-file .bin build nobody will ever
 * resolve them, and the placeholder BL (F000 D000) decodes as a branch to
 * +0x0C000000 -- an image that faults far outside itself.  compiler.c therefore
 * refuses to write a .bin while this is non-zero. */
static int          g_arm_unresolved = 0;
static const char  *g_arm_unresolved_first = 0;

/* Defined below (near arm_patch_movw_movt); resolve_refs_a needs it to
 * rewrite a MOVW/MOVT pair once a cross-object symbol becomes known. */
static void mov_imm_encode_a(int is_movt, int rd, unsigned imm,
                            unsigned *hi, unsigned *lo);

static void resolve_refs_a(ArmAsm *a) {
    int i;
    g_arm_unresolved = 0;
    g_arm_unresolved_first = 0;
    for (i = 0; i < a->ref_count; i++) {
        AsmRef *r = &a->refs[i];
        int addr;
        if (r->type == 6 || r->type == ARM_RELOC_TEXT ||
            r->type == ARM_RELOC_DATA_SYM)
            continue;   /* .arkdata / .arktext / .arkdatasym: patch sites, not
                         * labels */
        addr = find_label_a(a, r->name);
        if (addr < 0) {
            /* Not a local label: this is a cross-object reference and has
             * already been kept as a relocation by arm_save_relocs(), so the
             * linker owns it from here. Reporting it as an error here would
             * make every -c compile of a multi-file program exit non-zero on
             * a valid object (see ARK_DIAG_UNRESOLVED_LOCAL). */
#if ARK_DIAG_UNRESOLVED_LOCAL
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "unresolved label %sq", r->name, 0,0,0,0,0);
#endif
            a->error_count++;
            g_arm_unresolved++;
            if (!g_arm_unresolved_first && r->name[0] != '.')
                g_arm_unresolved_first = r->name;
            continue;
        }
        if (r->type == 7) {
            /* --asm-extra ADR T1: imm8*4 is relative to Align(pc+4, 4). */
            int base = (r->pc + 4) & ~3;
            int off = addr - base;
            unsigned hi = (unsigned)a->out[r->pc] | ((unsigned)a->out[r->pc + 1] << 8);
            if (off < 0 || off > 1020 || (off & 3) != 0) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "ADR target %sq is out of the 16-bit range (0..1020, "
                          "step 4)", r->name, 0,0,0,0,0);
                a->hard_errors++;
            } else {
                hi = (hi & 0xFF00u) | (unsigned)((off >> 2) & 0xFF);
                a->out[r->pc]     = (unsigned char)(hi & 0xFF);
                a->out[r->pc + 1] = (unsigned char)((hi >> 8) & 0xFF);
            }
        } else if (r->type == 10 || r->type == 11) {
            /* LDR rd, =sym for a symbol defined in another object: the
             * placeholder was MOVW/MOVT of g_flash_base, so rewrite the pair
             * with the resolved address (plus the Thumb bit for a function). */
            unsigned imm = (unsigned)g_flash_base + (unsigned)addr;
            unsigned hi, lo, hi2, lo2;
            int rd = (int)((a->out[r->pc + 3] >> 0) & 0x0F);
            if (r->type == 11) imm |= 1u;
            mov_imm_encode_a(0, rd, imm & 0xFFFFu, &hi, &lo);
            mov_imm_encode_a(1, rd, (imm >> 16) & 0xFFFFu, &hi2, &lo2);
            a->out[r->pc]     = (unsigned char)(hi & 0xFF);
            a->out[r->pc + 1] = (unsigned char)((hi >> 8) & 0xFF);
            a->out[r->pc + 2] = (unsigned char)(lo & 0xFF);
            a->out[r->pc + 3] = (unsigned char)((lo >> 8) & 0xFF);
            a->out[r->pc + 4] = (unsigned char)(hi2 & 0xFF);
            a->out[r->pc + 5] = (unsigned char)((hi2 >> 8) & 0xFF);
            a->out[r->pc + 6] = (unsigned char)(lo2 & 0xFF);
            a->out[r->pc + 7] = (unsigned char)((lo2 >> 8) & 0xFF);
        } else if (r->type == 8 || r->type == 9) {
            /* --asm-extra CBZ (8) / CBNZ (9): forward only, 0..62, even. */
            int off = addr - (r->pc + 4);
            unsigned hi = (unsigned)a->out[r->pc] | ((unsigned)a->out[r->pc + 1] << 8);
            if (off < 0 || off > 62 || (off & 1) != 0) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "CBZ/CBNZ target %sq is out of the 16-bit forward range",
                          r->name, 0,0,0,0,0);
                a->hard_errors++;
            } else {
                unsigned imm5 = (unsigned)(off >> 1);
                hi = (hi & 0xF8C0u) | ((imm5 & 0x20u) << 4) | ((imm5 & 0x1Fu) << 3);
                a->out[r->pc]     = (unsigned char)(hi & 0xFF);
                a->out[r->pc + 1] = (unsigned char)((hi >> 8) & 0xFF);
            }
        } else if (r->type == 1) {
            /* BL: 32-bit, re-emit at saved pc */
            int saved = a->pc;
            a->pc = r->pc;
            emit_bl_a(a, addr);
            a->pc = saved;
        } else if (r->type == 2) {
            /* B.W: 32-bit unconditional, re-emit at saved pc */
            int saved = a->pc;
            a->pc = r->pc;
            emit_b_w_a(a, addr);
            a->pc = saved;
        } else if (r->type == 3) {
            /* B<cond>.W: 32-bit conditional, recover cond from placeholder hi word */
            unsigned hi = (unsigned)a->out[r->pc] | ((unsigned)a->out[r->pc + 1] << 8);
            int cond = (hi >> 6) & 0xF;
            int saved = a->pc;
            a->pc = r->pc;
            emit_bcond_w_a(a, cond, addr);
            a->pc = saved;
        } else if (r->type == 4) {
            /* Bug-A5: R_ARM_ABS32 - 4-byte absolute address reference
             * (e.g. .word funcname in .init_array/.fini_array).
             * Patch the 4 bytes at r->pc with the resolved address. */
            a->out[r->pc]     = (unsigned char)(addr & 0xFF);
            a->out[r->pc + 1] = (unsigned char)((addr >> 8) & 0xFF);
            a->out[r->pc + 2] = (unsigned char)((addr >> 16) & 0xFF);
            a->out[r->pc + 3] = (unsigned char)((addr >> 24) & 0xFF);
        } else {
            /* type=0: legacy 16-bit branch (B/B<cond>), patch 2 bytes.
             * Kept for safety; new code uses type 2/3 above. */
            int offset = (addr - r->pc - 4) >> 1;
            unsigned hi = (unsigned)a->out[r->pc] | ((unsigned)a->out[r->pc + 1] << 8);
            if ((hi & 0xF000) == 0xE000) hi = (hi & 0xF800) | (offset & 0x7FF);
            else                          hi = (hi & 0xFF00) | (offset & 0xFF);
            a->out[r->pc]     = hi & 0xFF;
            a->out[r->pc + 1] = (hi >> 8) & 0xFF;
        }
    }
}



static int arm_emit(IrProgram *m, char *out, int cap) {
    char *text = codegen_arm(m);
    int n = ark_strlen(text);
    int i;
    if (n + 1 > cap) {
        /* A truncated program is an answer nobody asked for:
         * the text would be cut mid-instruction and the
         * assembler would report a nonsense mnemonic (measured:
         * "unknown mnemonic P") instead of "buffer too small".
         * Refuse, so the driver can name ARK_ASM_BUF_SIZE. */
        if (cap > 0) out[0] = 0;
        return -1;
    }
    for (i = 0; i < n; i++) out[i] = text[i];
    out[n] = 0;
    return n;
}

static void arm_save_syms(ArmAsm *a);  /* forward decl */
static void arm_save_relocs(ArmAsm *a);  /* Bug-A2: forward decl */

/* Latch the ARKCC_DUMP_SYMS environment variable (host only) into
 * g_arm_dump_syms at arkcc startup, so the ARM backend has a single uniform
 * flag on both profiles. On STM32 getenv() is not available and this is a
 * no-op; the flag is set via UART there. Called from ark_compile(). */
void arm_dump_syms_init(void) {
#if ARKCC_PROFILE != ARKCC_PROFILE_STM32_MIN
    if (getenv("ARKCC_DUMP_SYMS")) g_arm_dump_syms = 1;
#endif
}

static int arm_assemble(const char *asm_text, unsigned char *out, int cap) {
    ArmAsm a;
    a.src = asm_text;
    a.out = out;
    a.pc = 0;
    a.out_cap = cap;
    a.labels = 0; a.label_count = 0; a.label_cap = 0;
    a.refs = 0; a.ref_count = 0; a.ref_cap = 0;
    a.error_count = 0;
    a.hard_errors = 0;
    a.sets = 0; a.set_count = 0; a.set_cap = 0;
    a.literals = 0; a.literal_count = 0; a.literal_cap = 0;
    a.literal_pool_start = -1;
    a.pending_weak = 0;
    a.cur_section = 0;
#if ARKCC_FEATURE_OPT_BRANCH
    a.branches = 0; a.branch_count = 0; a.branch_cap = 0;
    a.branch_decided = 0; a.branch_ord = 0;
    a.align_pcs = 0; a.align_count = 0; a.align_cap = 0;
    a.plan_branches = g_config.enable_opt_branch ? 1 : 0;
#endif
    /* --vector-table: hand the emitter a buffer whose first ARM_VT_SIZE bytes
     * are already claimed, zeroed.  The linker only fills the table in. */
    if (g_arm_vt_reserve) {
        int k;
        if (ARM_VT_SIZE > cap) return -1;
        for (k = 0; k < ARM_VT_SIZE; k++) out[k] = 0;
    }
#if ARKCC_FEATURE_OPT_BRANCH
    if (a.plan_branches) {
        /* Round 1 measures every branch at 4 bytes and decides which ones
         * fit.  Round 2 re-lays the labels with the chosen widths so that
         * alignment padding is exact; the decisions are kept because they
         * can only become more valid as spans shrink. */
        pass1_a(&a);
        if (arm_decide_branches(&a) != 0)
            pass1_a(&a);
    } else {
        pass1_a(&a);
    }
#else
    pass1_a(&a);
#endif
    a.pc = g_arm_vt_reserve ? ARM_VT_SIZE : 0;
    pass2_a(&a);
    resolve_refs_a(&a);
    /* Save symbol table for linker */
    arm_save_syms(&a);
    /* Bug-A2: Save unresolved cross-object references as relocations
     * for the linker to resolve. This must be called AFTER arm_save_syms
     * so that the global symbol/reloc arrays are populated before the
     * object file is written. */
    arm_save_relocs(&a);
    /* Debug: dump label addresses when g_arm_dump_syms is set. On host the
     * flag is latched from getenv("ARKCC_DUMP_SYMS") at arkcc startup (see
     * arm_dump_syms_init); on STM32 it is set via the UART "debug syms"
     * command, since getenv() is unavailable under semihosting. */
    if (g_arm_dump_syms) {
        {
            int di;
            ark_log("=== ARM Symbol Map (%d labels) ===\n", a.label_count);
            for (di = 0; di < a.label_count; di++) {
                if (a.labels[di].name[0] != '.')
                    ark_log("  %s 0x%X (%d)\n",
                            a.labels[di].name, a.labels[di].addr, a.labels[di].addr);
            }
            ark_log("=== End Symbol Map ===\n");
        }
    }
    /* Genuine assembly errors must fail the compile: continuing would hand
     * back machine code that does not match the source. Unresolved external
     * references are NOT in this counter (resolve_refs_a keeps them in
     * error_count), because the linker may satisfy them later.
     * Bug-A2: error_count alone therefore still does not fail the compile. */
    if (a.hard_errors > 0) {
        {
            char b1[12];
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "%s assembly error(s), no output written",
                      diag_num(b1, a.hard_errors), 0,0,0,0,0);
        }
        return -1;
    }
    return a.pc;
}

/* arm_link - per-object link stub (intentionally a no-op).
 *
 * Design rationale: arkcc splits linking responsibility across two stages.
 *
 *  1) Backend stage (this function): called once per object right after
 *     arm_assemble, with only that object's code and no link context
 *     (lc is always NULL today - see the call sites in compiler.c).
 *     Cross-object references cannot be resolved here because we only see
 *     one object; the unresolved refs were already captured by
 *     arm_save_relocs() into g_arm_relocs for later use.
 *
 *  2) Linker stage (compiler.c -link mode): the ARKOBJ2 binary linker
 *     merges code sections from every input object, builds a global
 *     symbol table with weak-symbol precedence (ld_add_sym), and
 *     patches cross-object relocations (ld_patch_ref for BL/B.W/
 *     B<cond>.W/R_ARM_ABS32). Unresolved symbols are reported but do
 *     not abort - they may be satisfied by an external library.
 *
 * Per-mode behaviour:
 *   -S      : emits GAS-compatible assembly; real linking is delegated
 *             to arm-none-eabi-ld / arm-none-eabi-gcc externally.
 *   -c      : writes an ARKOBJ2 object (code + symbol table + reloc
 *             table) for the -link stage to consume later.
 *   -link   : runs the ARKOBJ2 binary linker described above.
 *   -> .bin : single-file direct binary; cross-object refs are left
 *             unresolved (acceptable for self-contained units).
 *
 * Keeping this function a no-op is the correct division of labour:
 * the backend assembles and exports symbols/relocs; compiler.c links.
 * Making arm_link do real work would duplicate the -link logic and
 * still could not resolve cross-object refs without all objects.
 *
 * Exception: vector table generation is handled after symbol table is
 * built (see arm_link_impl below, called via the forward declaration). */
static int arm_link(unsigned char *code, int size, struct LinkContext *lc);  /* forward decl */

/* --- Symbol table export for linker --- */
typedef struct ArmSym {
    char *name;
    int   offset;   /* byte offset from start of code section */
    int   type;     /* 0=code label, 1=data/global */
    int   is_weak;  /* 1=weak symbol (overridable by a strong definition) */
} ArmSym;

static ArmSym  g_arm_syms[ARM_MAX_SYMBOLS] __attribute__((section(".ark_buf")));
static int     g_arm_sym_count = 0;

/* Bug-A2: Relocation table for cross-object references.
 * After resolve_refs_a, any ref whose target label was not found in the
 * current object is saved here as a relocation entry. The linker will
 * resolve these using the global symbol table. */
typedef struct ArmReloc {
    char *name;    /* target symbol name */
    int   offset;  /* byte offset within code section to patch */
    int   type;    /* 1=BL(T1), 2=B.W, 3=B<cond>.W, 4=R_ARM_ABS32 (.word) */
} ArmReloc;

static ArmReloc g_arm_relocs[ARM_MAX_RELOCS] __attribute__((section(".ark_buf")));
static int      g_arm_reloc_count = 0;

/* Save symbol table after assembly */
static void arm_save_syms(ArmAsm *a) {
    int i;
    int dropped = 0;
    g_arm_sym_count = 0;
    for (i = 0; i < a->label_count; i++) {
        /* Skip local labels (starting with .L) */
        if (a->labels[i].name[0] == '.' && a->labels[i].name[1] == 'L') continue;
        if (g_arm_sym_count >= ARM_MAX_SYMBOLS) { dropped++; continue; }
        g_arm_syms[g_arm_sym_count].name   = a->labels[i].name;
        g_arm_syms[g_arm_sym_count].offset = a->labels[i].addr;
        g_arm_syms[g_arm_sym_count].type   = 0;  /* code label */
        g_arm_syms[g_arm_sym_count].is_weak = a->labels[i].is_weak;
        g_arm_sym_count++;
    }
    /* Data objects: type 1, offset = absolute address (not a code offset).
     * Appended after the code labels so a reader that stops at the label count
     * it knows about still sees a valid table. */
    for (i = 0; i < g_obj_dsym_count; i++) {
        if (g_arm_sym_count >= ARM_MAX_SYMBOLS) { dropped++; continue; }
        g_arm_syms[g_arm_sym_count].name   = (char *)g_obj_dsyms[i].name;
        g_arm_syms[g_arm_sym_count].offset = (int)g_obj_dsyms[i].addr;
        g_arm_syms[g_arm_sym_count].type   = 1;  /* data/global */
        g_arm_syms[g_arm_sym_count].is_weak = 0;
        g_arm_sym_count++;
    }
    if (dropped) {
        /* A symbol missing from the object is a symbol -link cannot resolve. */
        char b1[12], b2[12];
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "%s symbols did not fit the %s-entry object symbol table; raise "
                  "ARM_MAX_SYMBOLS and rebuild arkcc",
                  diag_num(b1, dropped), diag_num(b2, ARM_MAX_SYMBOLS), 0,0,0,0);
        a->hard_errors++;
    }
}

/* Bug-A2: Save unresolved refs as relocations for the linker.
 * Called after resolve_refs_a; scans the ref table and saves any ref
 * whose target is not defined in the current object. */
static void arm_save_relocs(ArmAsm *a) {
    int i;
    int dropped = 0;
    g_arm_reloc_count = 0;
    for (i = 0; i < a->ref_count; i++) {
        AsmRef *r = &a->refs[i];
        int addr;
        if (r->type == 6 || r->type == ARM_RELOC_TEXT ||
            r->type == ARM_RELOC_DATA_SYM) {
            /* .arkdata / .arktext / .arkdatasym: not a reference to a label, but
             * the offset of a
             * MOVW/MOVT pair the -link stage may have to shift.  It is saved
             * whether or not the object ends up being relocated, so that the
             * decision stays with the linker (which knows every object). */
            /* Only an entry that is really dropped counts: a ref resolved
             * inside this object never reaches the table. Breaking out of the
             * loop instead would report a full table for a file that has few
             * cross-object refs but many local ones. */
            if (g_arm_reloc_count >= ARM_MAX_RELOCS) { dropped = 1; continue; }
            g_arm_relocs[g_arm_reloc_count].name   = r->name;
            g_arm_relocs[g_arm_reloc_count].offset = r->pc;
            g_arm_relocs[g_arm_reloc_count].type   = r->type;
            g_arm_reloc_count++;
            continue;
        }
        addr = find_label_a(a, r->name);
        if (addr < 0) {
            /* Unresolved: this is a cross-object reference.
             * Save it as a relocation for the linker. */
            if (g_arm_reloc_count >= ARM_MAX_RELOCS) { dropped = 1; continue; }
            g_arm_relocs[g_arm_reloc_count].name   = r->name;
            g_arm_relocs[g_arm_reloc_count].offset = r->pc;
            g_arm_relocs[g_arm_reloc_count].type   = r->type;
            g_arm_reloc_count++;
        }
    }
    if (dropped) {
        char b1[12];
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "more than %s cross-object relocations in this file; raise "
                  "ARM_MAX_RELOCS and rebuild arkcc",
                  diag_num(b1, ARM_MAX_RELOCS), 0,0,0,0,0);
        a->hard_errors++;
    }
}

/* Encode imm16 into a MOVW (is_movt=0) or MOVT (is_movt=1) halfword pair.
 * Same fields the pass-2 encoders above use; kept in one place so the linker's
 * relocation cannot drift from the assembler's encoding. */
static void mov_imm_encode_a(int is_movt, int rd, unsigned imm,
                            unsigned *hi, unsigned *lo) {
    unsigned ii   = (imm >> 11) & 1u;
    unsigned imm4 = (imm >> 12) & 0xFu;
    unsigned imm3 = (imm >> 8) & 7u;
    unsigned imm8 = imm & 0xFFu;
    *hi = (is_movt ? 0xF2C0u : 0xF240u) | (ii << 10) | imm4;
    *lo = (imm3 << 12) | ((unsigned)(rd & 0xF) << 8) | imm8;
}

/* Decode a MOVW/MOVT halfword pair back to imm16 + Rd.
 * Returns 0 on success, -1 if `hi` is not the MOVW/MOVT opcode the encoder
 * emits or `lo` does not look like its second halfword. */
static int mov_imm_decode_a(unsigned hi, unsigned lo,
                           int *is_movt, int *rd, unsigned *imm) {
    unsigned base = hi & 0xFBF0u;
    if (base != 0xF240u && base != 0xF2C0u) return -1;
    if ((lo & 0x8000u) != 0) return -1;          /* bit15 must be 0 */
    *is_movt = (base == 0xF2C0u);
    *rd = (int)((lo >> 8) & 0xFu);
    *imm = ((hi & 0xFu) << 12) | (((hi >> 10) & 1u) << 11) |
           (((lo >> 12) & 7u) << 8) | (lo & 0xFFu);
    return 0;
}

/* --reloc-data: shift the MOVW/MOVT pair at `off` by `delta`.
 *
 * Returns 0 when both halfwords were rewritten, -1 when the bytes are not the
 * pair the assembler marked (different register, wrong opcode, truncated
 * image).  The caller must refuse to write the image in that case: the object
 * was built without --reloc-data, and its baked address would stay stale. */
int arm_patch_movw_movt(unsigned char *code, int code_len, int off, int delta) {
    unsigned hi, lo, hi2, lo2, loimm = 0, hiimm = 0, imm;
    int is_movt = 0, rd = 0, is_movt2 = 0, rd2 = 0;
    if (off < 0 || off + 8 > code_len) return -1;
    hi  = (unsigned)code[off]     | ((unsigned)code[off + 1] << 8);
    lo  = (unsigned)code[off + 2] | ((unsigned)code[off + 3] << 8);
    hi2 = (unsigned)code[off + 4] | ((unsigned)code[off + 5] << 8);
    lo2 = (unsigned)code[off + 6] | ((unsigned)code[off + 7] << 8);
    if (mov_imm_decode_a(hi, lo, &is_movt, &rd, &loimm) != 0) return -1;
    if (is_movt) return -1;                       /* pair must start with MOVW */
    if (mov_imm_decode_a(hi2, lo2, &is_movt2, &rd2, &hiimm) != 0) return -1;
    if (!is_movt2 || rd2 != rd) return -1;        /* must be MOVT of the same Rd */
    imm = (loimm | (hiimm << 16)) + (unsigned)delta;
    mov_imm_encode_a(0, rd, imm & 0xFFFFu, &hi, &lo);
    mov_imm_encode_a(1, rd, (imm >> 16) & 0xFFFFu, &hi2, &lo2);
    code[off]     = (unsigned char)(hi & 0xFF);
    code[off + 1] = (unsigned char)((hi >> 8) & 0xFF);
    code[off + 2] = (unsigned char)(lo & 0xFF);
    code[off + 3] = (unsigned char)((lo >> 8) & 0xFF);
    code[off + 4] = (unsigned char)(hi2 & 0xFF);
    code[off + 5] = (unsigned char)((hi2 >> 8) & 0xFF);
    code[off + 6] = (unsigned char)(lo2 & 0xFF);
    code[off + 7] = (unsigned char)((lo2 >> 8) & 0xFF);
    return 0;
}

/* Unresolved references of the last assembly (see resolve_refs_a). */
int arm_get_unresolved_count(void) { return g_arm_unresolved; }
const char *arm_get_unresolved_name(void) { return g_arm_unresolved_first; }

/* Export symbol info for the linker */
int arm_get_symbol_count(void) { return g_arm_sym_count; }
const char *arm_get_symbol_name(int idx) { return g_arm_syms[idx].name; }
int arm_get_symbol_offset(int idx) { return g_arm_syms[idx].offset; }
int arm_get_symbol_type(int idx) { return g_arm_syms[idx].type; }
int arm_get_symbol_weak(int idx) { return g_arm_syms[idx].is_weak; }

/* SRAM window covered by this translation unit's .data + .bss (absolute
 * addresses; both equal g_data_base when the unit declares no RAM objects).
 * Exported so the -link stage can detect two objects that were each laid out
 * from the same SRAM base: -link concatenates code but does not relocate
 * data, so such a pair would silently alias its globals. */
unsigned arm_get_ram_start(void) { return g_data_sram_start; }
/* --reloc-text: the base every absolute address in this object was computed
 * against.  Written into the object as __arkcc_text_base so the linker can
 * work out how far it had to move this object. */
unsigned arm_get_text_base(void) { return (unsigned)g_flash_base; }
unsigned arm_get_ram_end(void)   { return g_bss_sram_end; }
/* Zero the .data/.bss window this translation unit reports to the linker.
 *
 * The four bounds above are written by codegen_arm() and by nothing else.  An
 * assembly-only input (cc -c x.s) never reaches codegen, so without this the
 * object inherited the window of whatever C file the same process compiled
 * before it.  The true statement for a unit like that is "no RAM window", and
 * it matters: -link then tries to move this object's window, finds no patch
 * site inside it, and refuses the whole image with "declares data but carries
 * no relocatable address" -- a diagnostic that blames the object for
 * something it never declared (measured: cc --pack over start.c / rt.c /
 * setjmp.s / sj.c, where object #2 is the .s file). */
void arm_reset_ram_window(void) {
    g_data_sram_start = 0; g_data_sram_end = 0;
    g_bss_sram_start  = 0; g_bss_sram_end  = 0;
}

/* Bug-A2: Export relocation info for the linker */
int arm_get_reloc_count(void) { return g_arm_reloc_count; }
const char *arm_get_reloc_name(int idx) { return g_arm_relocs[idx].name; }
int arm_get_reloc_offset(int idx) { return g_arm_relocs[idx].offset; }
int arm_get_reloc_type(int idx) { return g_arm_relocs[idx].type; }

/* === Vector table generation (single-file .bin mode) ===
 * If Reset_Handler is defined, generates a Cortex-M vector table at the start
 * of the binary. Safe because Thumb-2 branches use PC-relative offsets that
 * survive a uniform shift; absolute (.word) refs are already resolved by
 * resolve_refs_a within the object.
 *
 * Every entry must carry the Thumb bit (bit 0): on exception entry the core
 * loads EPSR.T from that bit, so an even address makes a Cortex-M core take
 * an INVSTATE UsageFault instead of running the handler. Real STM32 vector
 * tables are odd for the same reason. */
static const char *g_arm_vector_names[] = {
    NULL, "Reset_Handler", "NMI_Handler", "HardFault_Handler",
    "MemManage_Handler", "BusFault_Handler", "UsageFault_Handler",
    NULL, NULL, NULL, NULL,
    "SVC_Handler", "DebugMon_Handler", NULL,
    "PendSV_Handler", "SysTick_Handler"
};
#define ARM_SYSTEM_VECTOR_COUNT 16

static int arm_link(unsigned char *code, int size, struct LinkContext *lc) {
    int i, reset_idx = -1, default_idx = -1;
    unsigned flash_base, initial_sp;
    int new_size;
    (void)lc;

    /* Find Reset_Handler in symbol table */
    for (i = 0; i < g_arm_sym_count; i++) {
        if (ark_streq(g_arm_syms[i].name, "Reset_Handler")) { reset_idx = i; break; }
    }
    if (reset_idx < 0) return size;  /* no Reset_Handler: skip vector table */

    /* Find Default_Handler for filling unresolved entries */
    for (i = 0; i < g_arm_sym_count; i++) {
        if (ark_streq(g_arm_syms[i].name, "Default_Handler")) { default_idx = i; break; }
    }

    /* Determine flash_base and initial_sp from scatter or defaults */
    flash_base = g_flash_base;
    initial_sp = g_bss_base + 0x20000;  /* default: SRAM + 128KB */
#if ARKCC_FEATURE_SCATTER
    if (g_scatter_loaded) {
        ScatterExecRegion *er_rw = scatter_find_er_by_attr(&g_scatter, SCATTER_ATTR_RW);
        if (er_rw && er_rw->size > 0)
            initial_sp = er_rw->load_addr + er_rw->size;
    }
#endif

    if (g_arm_vt_reserve) {
        /* --vector-table: the emitter started at ARM_VT_SIZE, so the table
         * area is already in place and every address is already correct.
         * Moving anything here would shift the image away from the addresses
         * the assembler encoded (that was the bug this option exists to fix). */
        new_size = size;
    } else {
        new_size = size + ARM_VT_SIZE;
        if (new_size > ARK_CODE_BUF_SIZE) return -1;

        /* Move existing code right by ARM_VT_SIZE bytes */
        for (i = size - 1; i >= 0; i--) code[i + ARM_VT_SIZE] = code[i];

        /* Adjust all symbol offsets by ARM_VT_SIZE */
        for (i = 0; i < g_arm_sym_count; i++)
            g_arm_syms[i].offset += ARM_VT_SIZE;
    }

    /* Generate vector table at code[0] */
    {
        /* Bit 0 is the Thumb bit; a zero entry stays zero ("no handler"). */
        unsigned default_addr = (default_idx >= 0) ?
            ((flash_base + (unsigned)g_arm_syms[default_idx].offset) | 1u) : 0;
        /* Entry 0: initial SP */
        code[0] = (unsigned char)(initial_sp & 0xFF);
        code[1] = (unsigned char)((initial_sp >> 8) & 0xFF);
        code[2] = (unsigned char)((initial_sp >> 16) & 0xFF);
        code[3] = (unsigned char)((initial_sp >> 24) & 0xFF);
        /* Fill entries 1..N with Default_Handler (or 0) */
        for (i = 1; i < ARM_VT_ENTRIES; i++) {
            code[i*4]   = (unsigned char)(default_addr & 0xFF);
            code[i*4+1] = (unsigned char)((default_addr >> 8) & 0xFF);
            code[i*4+2] = (unsigned char)((default_addr >> 16) & 0xFF);
            code[i*4+3] = (unsigned char)((default_addr >> 24) & 0xFF);
        }
        /* Fill in known system exception handlers */
        for (i = 1; i < ARM_SYSTEM_VECTOR_COUNT; i++) {
            if (g_arm_vector_names[i]) {
                int j;
                for (j = 0; j < g_arm_sym_count; j++) {
                    if (ark_streq(g_arm_syms[j].name, g_arm_vector_names[i])) {
                        unsigned addr = (flash_base + (unsigned)g_arm_syms[j].offset) | 1u;
                        code[i*4]   = (unsigned char)(addr & 0xFF);
                        code[i*4+1] = (unsigned char)((addr >> 8) & 0xFF);
                        code[i*4+2] = (unsigned char)((addr >> 16) & 0xFF);
                        code[i*4+3] = (unsigned char)((addr >> 24) & 0xFF);
                        break;
                    }
                }
            }
        }
    }
    return new_size;
}

static const ArkBackend g_arm_backend = {
    "arm",
    "armv7m-thumb2-eabi",
    4,
    arm_emit,
    arm_assemble,
    arm_link,
    ARK_ABI_SYSV
};

const ArkBackend *ark_backend_arm(void) {
    return &g_arm_backend;
}
