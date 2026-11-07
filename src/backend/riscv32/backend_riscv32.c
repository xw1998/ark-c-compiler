/* Ark C Compiler - RISC-V (RV32I) backend
 *
 * Emits GAS-syntax RV32I assembly. The assemble stage is a stub; the user
 * subsequently runs `as -march=rv32i`.
 *
 * Calling convention: arguments a0..a7; stack frame fp = s0; this backend
 * treats all local values as 4-byte slots.
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "common.h"
#include "diag.h"

static const char *arg_reg_r(int i) {
    static const char *r[] = { "a0","a1","a2","a3","a4","a5","a6","a7" };
    if (i < 0 || i >= 8) return "a0";
    return r[i];
}

/* ---- va region ---------------------------------------------------------
 * One 4-byte word per argument register, at s0 - RV_VA_OFF + 4*k:
 *   word k = a<k>, k = 0..7
 * The frame pointer is s0 and the region is written once per variadic call,
 * in the prologue, before anything can clobber a0-a7.  <stdarg.h> walks it as
 * words (__ARK_VA_WORD_SLOTS, and __ARK_VA_PACKED_WORDS because this backend
 * numbers argument words without alignment holes). */
#define RV_VA_OFF   8192
#define RV_VA_WORDS 8

/* GNU as encodes a 12-bit signed displacement only, and both a variadic frame
 * (8 KB) and the va region are far past that, so the s0-relative slot address
 * is materialised in t2 with li/sub instead of being folded into the load or
 * store.  That is one extra instruction per access, and it is what makes the
 * output assemble at all for frames bigger than 2 KB. */
static void rv_s0_slot(AsmBuffer *b, int off) {
    asmbuf_puts(b, "    li t2, ");
    asmbuf_int(b, off < 0 ? -off : off);
    asmbuf_puts(b, off < 0 ? "\n    sub t2, s0, t2\n" : "\n    add t2, s0, t2\n");
}

/* sp += delta, for deltas past the 12-bit immediate range. */
static void rv_sp_adj(AsmBuffer *b, int delta, int upward) {
    asmbuf_puts(b, "    li t0, ");
    asmbuf_int(b, delta);
    asmbuf_puts(b, upward ? "\n    add sp, sp, t0\n" : "\n    sub sp, sp, t0\n");
}

/* Restore ra/s0 and pop the frame.  Both the saved-register offsets and the
 * frame size are past the 12-bit immediate range for an 8 KB frame, so the
 * addresses are formed in t0 first. */
static void rv_pilogue(AsmBuffer *b, int sp_size) {
    asmbuf_puts(b, "    li t0, ");
    asmbuf_int(b, sp_size - 8);
    asmbuf_puts(b, "\n    add t0, sp, t0\n    lw s0, 0(t0)\n    li t0, ");
    asmbuf_int(b, sp_size - 4);
    asmbuf_puts(b, "\n    add t0, sp, t0\n    lw ra, 0(t0)\n");
    rv_sp_adj(b, sp_size, 1);
    asmbuf_puts(b, "    ret\n");
}

/* 1 while the function being emitted is variadic, cleared for every function. */
static int g_rv_va_active;

static int rv_emit(IrProgram *prog, char *out, int cap) {
    AsmBuffer buf;
    int fi;
    asmbuf_init(&buf);
    asmbuf_puts(&buf, "# Ark C Compiler - generated RV32I assembly\n");
    asmbuf_puts(&buf, "    .option nopic\n    .text\n");

    /* String pool */
    if (prog->string_count > 0) {
        int i;
        asmbuf_puts(&buf, "    .section .rodata\n");
        for (i = 0; i < prog->string_count; i++) {
            IrString *s = prog->strings[i];
            asmbuf_puts(&buf, "ark_str_");
            asmbuf_int(&buf, s->id);
            asmbuf_puts(&buf, ":\n    .asciz \"");
            {
                int k;
                for (k = 0; k < s->len; k++) {
                    char c = s->data[k];
                    if (c == '\n') asmbuf_puts(&buf, "\\n");
                    else if (c == '\t') asmbuf_puts(&buf, "\\t");
                    else if (c == '\\') asmbuf_puts(&buf, "\\\\");
                    else if (c == '"')  asmbuf_puts(&buf, "\\\"");
                    else asmbuf_putc(&buf, c);
                }
            }
            asmbuf_puts(&buf, "\"\n");
        }
        asmbuf_puts(&buf, "    .text\n");
    }

    /* Globals */
    {
        int i;
        if (prog->global_count) asmbuf_puts(&buf, "    .data\n");
        for (i = 0; i < prog->global_count; i++) {
            IrGlobal *g = prog->globals[i];
            asmbuf_puts(&buf, "    .globl ");
            asmbuf_puts(&buf, g->name);
            asmbuf_putc(&buf, '\n');
            asmbuf_puts(&buf, g->name);
            asmbuf_puts(&buf, ":\n    .word ");
            asmbuf_int(&buf, g->has_init ? g->init_int : 0);
            asmbuf_putc(&buf, '\n');
        }
        if (prog->global_count) asmbuf_puts(&buf, "    .text\n");
    }

    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];

        int i;
        int local_size = ((f->local_size + 16) + 15) & ~15;
        int sp_size = local_size + 256;
        int va_named_words = 0;
        /* Words the named parameters occupy, counted exactly the way irgen
         * stamps the IR_GETARG slot numbers: a struct > 8 bytes travels as a
         * pointer word, a 5..8-byte struct as two, an array as a pointer, a
         * scalar of 8 bytes as two words, anything else as one. */
        if (f->is_variadic) {
            int pj;
            for (pj = 0; pj < f->param_count && pj < 64; pj++) {
                Type *pt = (f->param_types) ? f->param_types[pj] : 0;
                int sz = pt ? type_size(pt) : 4;
                if (sz <= 0) sz = 4;
                if (pt && (pt->kind == TYPE_STRUCT || pt->kind == TYPE_UNION))
                    va_named_words += (sz > 8) ? 1 : ((sz > 4) ? 2 : 1);
                else if (pt && pt->kind == TYPE_ARRAY)
                    va_named_words += 1;
                else
                    va_named_words += (sz >= 8) ? 2 : 1;
            }
            if (sp_size < RV_VA_OFF + 4 * RV_VA_WORDS + 16)
                sp_size = RV_VA_OFF + 4 * RV_VA_WORDS + 16;
            sp_size = (sp_size + 15) & ~15;
        }

        asmbuf_puts(&buf, "    .globl ");
        asmbuf_puts(&buf, f->name);
        asmbuf_putc(&buf, '\n');
        asmbuf_puts(&buf, f->name);
        asmbuf_puts(&buf, ":\n");
        rv_sp_adj(&buf, sp_size, 0);
        asmbuf_puts(&buf, "    li t0, ");
        asmbuf_int(&buf, sp_size - 4);
        asmbuf_puts(&buf, "\n    add t0, sp, t0\n    sw ra, 0(t0)\n    li t0, ");
        asmbuf_int(&buf, sp_size - 8);
        asmbuf_puts(&buf, "\n    add t0, sp, t0\n    sw s0, 0(t0)\n    li t0, ");
        asmbuf_int(&buf, sp_size);
        asmbuf_puts(&buf, "\n    add s0, sp, t0\n");
        /* va region: one word per argument register, written before the body
         * can touch a0-a7.  Words for named parameters are written too: they
         * are never read by va_arg (it starts at the first variadic word), but
         * keeping the whole register file in one array is what makes the walk
         * a plain word pointer. */
        g_rv_va_active = f->is_variadic ? 1 : 0;
        if (g_rv_va_active) {
            int k;
            asmbuf_puts(&buf, "    li t2, ");
            asmbuf_int(&buf, RV_VA_OFF);
            asmbuf_puts(&buf, "\n    sub t2, s0, t2\n");
            for (k = 0; k < RV_VA_WORDS; k++) {
                asmbuf_puts(&buf, "    sw ");
                asmbuf_puts(&buf, arg_reg_r(k));
                asmbuf_puts(&buf, ", ");
                asmbuf_int(&buf, 4 * k);
                asmbuf_puts(&buf, "(t2)\n");
            }
        }

        for (i = 0; i < f->code_count; i++) {
            IrInst *I = &f->code[i];
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END: break;
                case IR_GETARG: {
                    /* aux: low 8 bits = slot index, high bits = the size the
                     * parameter travels with (see irgen).  A 64-bit scalar
                     * occupies two slots, low word in the lower-numbered
                     * register; the old code passed the whole aux to
                     * arg_reg_r() and so read a0 for every 8-byte parameter. */
                    int slot = I->aux & 0xFF;
                    int psz  = (I->aux >> 8) & 0xFFFFFF;
                    rv_s0_slot(&buf, -(16 + I->val));
                    asmbuf_puts(&buf, "    sw ");
                    asmbuf_puts(&buf, arg_reg_r(slot));
                    asmbuf_puts(&buf, ", 0(t2)\n");
                    if (psz == 8) {
                        asmbuf_puts(&buf, "    sw ");
                        asmbuf_puts(&buf, arg_reg_r(slot + 1));
                        asmbuf_puts(&buf, ", 4(t2)\n");
                    }
                    break;
                }
                case IR_PUSH_INT:
                    asmbuf_puts(&buf, "    li t0, ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_64PUSH:
                    /* val=high32, aux=low32; push low first (bottom), high last (top) */
                    asmbuf_puts(&buf, "    li t0, ");
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    asmbuf_puts(&buf, "    li t0, ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_PUSH_STR:
                    asmbuf_puts(&buf, "    la t0, ark_str_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_PUSH_VAR:
                    rv_s0_slot(&buf, -(16 + I->val));
                    asmbuf_puts(&buf, "    lw t0, 0(t2)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_PUSH_ADDR:
                    rv_s0_slot(&buf, -(16 + I->val));
                    asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t2, 0(sp)\n");
                    break;
                case IR_TRUNC:
                    /* val = target width, aux = 1 zero-extend (unsigned). */
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n");
                    if (I->val == 8 || I->val == 16) {
                        asmbuf_puts(&buf, "    slli t0, t0, ");
                        asmbuf_int(&buf, I->val == 8 ? 24 : 16);
                        asmbuf_puts(&buf, "\n    ");
                        asmbuf_puts(&buf, I->aux ? "srli" : "srai");
                        asmbuf_puts(&buf, " t0, t0, ");
                        asmbuf_int(&buf, I->val == 8 ? 24 : 16);
                        asmbuf_putc(&buf, '\n');
                    }
                    asmbuf_puts(&buf, "    sw t0, 0(sp)\n");
                    break;
                case IR_PUSH_FUNC:
                    asmbuf_puts(&buf, "    la t0, ");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_PUSH_GLOBAL:
                    /* _ark_va_ptr is <stdarg.h>'s handle on the argument
                     * image: it is not a real variable, the address of the
                     * first variadic word is computed from s0. */
                    if (I->name && ark_streq(I->name, "_ark_va_ptr")) {
                        if (!g_rv_va_active) {
                            diag_tool(DIAG_SEV_ERROR, "arkcc",
                                      "'_ark_va_ptr' is read in '%s', which is "
                                      "not variadic: va_start/va_arg only mean "
                                      "something inside a function that is "
                                      "declared with '...'",
                                      f->name, 0,0,0,0,0);
                        }
                        /* The region grows *up* from s0-RV_VA_OFF (word k at
                         * +4k), so the first variadic word is 4*named_words
                         * above the base -- the same direction the spill
                         * writes in. */
                        asmbuf_puts(&buf, "    li t2, ");
                        asmbuf_int(&buf, RV_VA_OFF);
                        asmbuf_puts(&buf, "\n    sub t2, s0, t2\n    addi t2, t2, ");
                        asmbuf_int(&buf, 4 * va_named_words);
                        asmbuf_puts(&buf, "\n    addi sp, sp, -4\n    sw t2, 0(sp)\n");
                        break;
                    }
                    asmbuf_puts(&buf, "    la t1, ");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "\n    lw t0, 0(t1)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_STORE_GLOBAL:
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    addi sp, sp, 4\n    la t1, ");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "\n    sw t0, 0(t1)\n");
                    break;
                case IR_POP:
                    asmbuf_puts(&buf, "    addi sp, sp, 4\n");
                    break;
                case IR_DUP:
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_SWAP:
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    sw t1, 0(sp)\n    sw t0, 4(sp)\n");
                    break;
                case IR_SEXT:
                case IR_ZEXT:
                case IR_CDECL64:
                    /* x86-cdecl-specific 64-bit arg passing conversion.
                     * RISC-V ilp32 passes 64-bit values in register pairs;
                     * no conversion needed. Treat as no-op. */
                    break;
                case IR_STORE:
                    /* aux carries the store width; anything past 4 bytes needs
                     * a 64-bit value model this backend does not have.  It
                     * used to emit a plain `sw`, which wrote half of the value
                     * and left the other word on the IR stack (measured: the
                     * stack imbalance turned the next `ret` into a jump to 0). */
                    if ((I->aux & ~IR_AUX_VOLATILE) > 4) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "%s-byte stores are not implemented by the "
                                  "riscv32 backend (function '%s')",
                                  diag_num(b1, I->aux & ~IR_AUX_VOLATILE),
                                  f->name, 0,0,0,0);
                    }
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    addi sp, sp, 4\n");
                    rv_s0_slot(&buf, -(16 + I->val));
                    asmbuf_puts(&buf, "    sw t0, 0(t2)\n");
                    break;
                case IR_LOAD_IDX:
                    if (I->val > 4) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "%s-byte loads are not implemented by the "
                                  "riscv32 backend (function '%s')",
                                  diag_num(b1, (int)I->val), f->name, 0,0,0,0);
                    }
                    asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 8\n");
                    if (I->val == 1) {
                        asmbuf_puts(&buf, "    add t0, t0, t1\n    lb t0, 0(t0)\n");
                    } else {
                        asmbuf_puts(&buf, "    li t2, ");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "\n    mul t1, t1, t2\n    add t0, t0, t1\n    lw t0, 0(t0)\n");
                    }
                    asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_STORE_IDX:
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    addi sp, sp, 8\n");
                    if (I->val == 1) asmbuf_puts(&buf, "    sb t0, 0(t1)\n");
                    else             asmbuf_puts(&buf, "    sw t0, 0(t1)\n");
                    asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_BINARY:
                    asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 4\n");
                    switch (I->aux) {
                        case (int)TOK_PLUS:  asmbuf_puts(&buf, "    add t0, t0, t1\n"); break;
                        case (int)TOK_MINUS: asmbuf_puts(&buf, "    sub t0, t0, t1\n"); break;
                        case (int)TOK_MUL:   asmbuf_puts(&buf, "    mul t0, t0, t1\n"); break;
                        case (int)TOK_DIV:   asmbuf_puts(&buf, "    div t0, t0, t1\n"); break;
                        case (int)TOK_MOD:   asmbuf_puts(&buf, "    rem t0, t0, t1\n"); break;
                        case (int)TOK_BAND:  asmbuf_puts(&buf, "    and t0, t0, t1\n"); break;
                        case (int)TOK_BOR:   asmbuf_puts(&buf, "    or t0, t0, t1\n");  break;
                        case (int)TOK_BXOR:  asmbuf_puts(&buf, "    xor t0, t0, t1\n"); break;
                        case (int)TOK_SHL:   asmbuf_puts(&buf, "    sll t0, t0, t1\n"); break;
                        case (int)TOK_SHR:   asmbuf_puts(&buf, "    sra t0, t0, t1\n"); break;
                        case (int)TOK_EQ:    asmbuf_puts(&buf, "    sub t0, t0, t1\n    seqz t0, t0\n"); break;
                        case (int)TOK_NE:    asmbuf_puts(&buf, "    sub t0, t0, t1\n    snez t0, t0\n"); break;
                        case (int)TOK_LT:    asmbuf_puts(&buf, "    slt  t0, t0, t1\n"); break;
                        case (int)TOK_GT:    asmbuf_puts(&buf, "    slt  t0, t1, t0\n"); break;
                        case (int)TOK_LE:    asmbuf_puts(&buf, "    slt  t0, t1, t0\n    xori t0, t0, 1\n"); break;
                        case (int)TOK_GE:    asmbuf_puts(&buf, "    slt  t0, t0, t1\n    xori t0, t0, 1\n"); break;
                        default: break;
                    }
                    asmbuf_puts(&buf, "    sw t0, 0(sp)\n");
                    break;
                case IR_DIV:
                    /* Division and modulo are separate IR ops (irgen emits them
                     * for '/' and '%'), and this backend had neither: they fell
                     * into the "unknown" hole below, which left both operands
                     * on the stack and handed the next consumer the divisor.
                     * aux: 0 signed, 1 unsigned. */
                    asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 4\n");
                    asmbuf_puts(&buf, I->aux ? "    divu t0, t0, t1\n" : "    div t0, t0, t1\n");
                    asmbuf_puts(&buf, "    sw t0, 0(sp)\n");
                    break;
                case IR_MOD:
                    asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 4\n");
                    asmbuf_puts(&buf, I->aux ? "    remu t0, t0, t1\n" : "    rem t0, t0, t1\n");
                    asmbuf_puts(&buf, "    sw t0, 0(sp)\n");
                    break;
                case IR_UNARY:
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n");
                    if (I->aux == (int)TOK_MINUS) asmbuf_puts(&buf, "    neg t0, t0\n");
                    else if (I->aux == (int)TOK_BNOT) asmbuf_puts(&buf, "    not t0, t0\n");
                    else if (I->aux == (int)TOK_NOT)  asmbuf_puts(&buf, "    seqz t0, t0\n");
                    asmbuf_puts(&buf, "    sw t0, 0(sp)\n");
                    break;
                case IR_LABEL:
                    asmbuf_puts(&buf, ".L_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ":\n");
                    break;
                case IR_LABEL_NAMED:
                    asmbuf_puts(&buf, ".LN_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, ":\n");
                    break;
                case IR_JMP:
                    asmbuf_puts(&buf, "    j .L_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JMP_NAMED:
                    asmbuf_puts(&buf, "    j .LN_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JZ:
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    addi sp, sp, 4\n    beq t0, x0, .L_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JNZ:
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    addi sp, sp, 4\n    bne t0, x0, .L_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_CMP_JMP_EQ:
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    li t1, ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    bne t0, t1, 1f\n    addi sp, sp, 4\n    j .L_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, "\n1:\n");
                    break;
                case IR_CALL: {
                    int n = I->val;
                    int k;
                    int is_indirect = (I->name && I->name[0] == '?');
                    int is_void_ret = 0;
                    /* ROUND4-P2 FIX: For direct calls to void functions, skip
                     * the return-value push (caller no longer emits IR_POP). */
                    if (!is_indirect) {
                        int fi2;
                        for (fi2 = 0; fi2 < prog->func_count; fi2++) {
                            if (ark_streq(prog->funcs[fi2]->name, I->name)) {
                                Type *rt = prog->funcs[fi2]->ret_type;
                                if (rt && rt->kind == TYPE_VOID)
                                    is_void_ret = 1;
                                break;
                            }
                        }
                    }
                    /* n counts arguments, not words: a 64-bit argument is
                     * two words on the IR stack with the HIGH word on top, so
                     * it is popped into a<slot+1> first and a<slot> second.
                     * That keeps the image "low word in the lower-numbered
                     * register", which is what IR_GETARG and the va region
                     * both assume. */
                    {
                        int kk, slot = 0;
                        for (kk = 0; kk < n && kk < 16; kk++) {
                            int is64 = (I->aux >> (2 * kk + 1)) & 1;
                            if (is64) {
                                if (slot + 1 >= 8) {
                                    /* No stack-argument passing in this
                                     * backend: silently dropping the words
                                     * left the IR stack unbalanced and the
                                     * next `ret` jumped to whatever the
                                     * leftovers pointed at (measured: PC 0). */
                                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                                              "call to '%s' needs more than the "
                                              "8 argument words this backend "
                                              "passes in a0-a7: stack arguments "
                                              "are not implemented by the "
                                              "riscv32 backend",
                                              I->name ? I->name : "?", 0,0,0,0,0);
                                    break;
                                }
                                asmbuf_puts(&buf, "    lw ");
                                asmbuf_puts(&buf, arg_reg_r(slot + 1));
                                asmbuf_puts(&buf, ", 0(sp)\n    addi sp, sp, 4\n    lw ");
                                asmbuf_puts(&buf, arg_reg_r(slot));
                                asmbuf_puts(&buf, ", 0(sp)\n    addi sp, sp, 4\n");
                                slot += 2;
                            } else {
                                if (slot >= 8) {
                                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                                              "call to '%s' needs more than the "
                                              "8 argument words this backend "
                                              "passes in a0-a7: stack arguments "
                                              "are not implemented by the "
                                              "riscv32 backend",
                                              I->name ? I->name : "?", 0,0,0,0,0);
                                    break;
                                }
                                asmbuf_puts(&buf, "    lw ");
                                asmbuf_puts(&buf, arg_reg_r(slot));
                                asmbuf_puts(&buf, ", 0(sp)\n    addi sp, sp, 4\n");
                                slot += 1;
                            }
                        }
                        (void)k;
                    }
                    asmbuf_puts(&buf, "    call ");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    if (!is_void_ret)
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw a0, 0(sp)\n");
                    break;
                }
                case IR_RETURN:
                    asmbuf_puts(&buf, "    lw a0, 0(sp)\n    addi sp, sp, 4\n");
                    rv_pilogue(&buf, sp_size);
                    break;
                default:
                    /* Every op this backend does not implement used to be
                     * commented out, which left the IR stack unbalanced and
                     * turned into a wrong answer further down (measured: a
                     * '/ 4' inside <stdarg.h> poisoned the next va_arg).  An
                     * unimplemented op is now a build error. */
                    {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the riscv32 backend does not implement IR op "
                                  "%s (function '%s'); the emitted code would be "
                                  "wrong, so nothing is written",
                                  diag_num(b1, (int)I->op), f->name, 0,0,0,0);
                    }
                    asmbuf_puts(&buf, "    # unsupported IR op\n");
                    break;
            }
        }
        asmbuf_puts(&buf, "    li a0, 0\n");
        rv_pilogue(&buf, sp_size);
        asmbuf_putc(&buf, '\n');
    }
    {
        int n = buf.len;
        int i;
        if (n + 1 > cap) n = cap - 1;
        for (i = 0; i < n; i++) out[i] = buf.buf[i];
        out[n] = 0;
        return n;
    }
}

static int rv_assemble(const char *asm_text, unsigned char *out, int cap) {
    int n = ark_strlen(asm_text);
    int i;
    if (n > cap) n = cap;
    for (i = 0; i < n; i++) out[i] = (unsigned char)asm_text[i];
    return n;
}

static int rv_link(unsigned char *c, int s, struct LinkContext *lc) {
    (void)c; (void)s; (void)lc;
    return 0;
}

static const ArkBackend g_rv_backend = {
    "riscv32",
    "riscv32-unknown-elf",
    4,
    rv_emit,
    rv_assemble,
    rv_link,
    ARK_ABI_SYSV
};

const ArkBackend *ark_backend_riscv32(void) {
    return &g_rv_backend;
}
