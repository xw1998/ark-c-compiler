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

static const char *arg_reg_r(int i) {
    static const char *r[] = { "a0","a1","a2","a3","a4","a5","a6","a7" };
    if (i < 0 || i >= 8) return "a0";
    return r[i];
}

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

        asmbuf_puts(&buf, "    .globl ");
        asmbuf_puts(&buf, f->name);
        asmbuf_putc(&buf, '\n');
        asmbuf_puts(&buf, f->name);
        asmbuf_puts(&buf, ":\n");
        asmbuf_puts(&buf, "    addi sp, sp, -");
        asmbuf_int(&buf, sp_size);
        asmbuf_puts(&buf, "\n    sw ra, ");
        asmbuf_int(&buf, sp_size - 4);
        asmbuf_puts(&buf, "(sp)\n    sw s0, ");
        asmbuf_int(&buf, sp_size - 8);
        asmbuf_puts(&buf, "(sp)\n    addi s0, sp, ");
        asmbuf_int(&buf, sp_size);
        asmbuf_putc(&buf, '\n');

        for (i = 0; i < f->code_count; i++) {
            IrInst *I = &f->code[i];
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END: break;
                case IR_GETARG:
                    asmbuf_puts(&buf, "    sw ");
                    asmbuf_puts(&buf, arg_reg_r(I->aux));
                    asmbuf_puts(&buf, ", -");
                    asmbuf_int(&buf, 16 + I->val);
                    asmbuf_puts(&buf, "(s0)\n");
                    break;
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
                    asmbuf_puts(&buf, "    lw t0, -");
                    asmbuf_int(&buf, 16 + I->val);
                    asmbuf_puts(&buf, "(s0)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_PUSH_ADDR:
                    asmbuf_puts(&buf, "    addi t0, s0, -");
                    asmbuf_int(&buf, 16 + I->val);
                    asmbuf_puts(&buf, "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_PUSH_GLOBAL:
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
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    addi sp, sp, 4\n    sw t0, -");
                    asmbuf_int(&buf, 16 + I->val);
                    asmbuf_puts(&buf, "(s0)\n");
                    break;
                case IR_LOAD_IDX:
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
                    for (k = 0; k < n && k < 8; k++) {
                        asmbuf_puts(&buf, "    lw ");
                        asmbuf_puts(&buf, arg_reg_r(k));
                        asmbuf_puts(&buf, ", 0(sp)\n    addi sp, sp, 4\n");
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
                    asmbuf_puts(&buf, "    lw s0, ");
                    asmbuf_int(&buf, sp_size - 8);
                    asmbuf_puts(&buf, "(sp)\n    lw ra, ");
                    asmbuf_int(&buf, sp_size - 4);
                    asmbuf_puts(&buf, "(sp)\n    addi sp, sp, ");
                    asmbuf_int(&buf, sp_size);
                    asmbuf_puts(&buf, "\n    ret\n");
                    break;
                default:
                    asmbuf_puts(&buf, "    # unknown\n");
                    break;
            }
        }
        asmbuf_puts(&buf, "    li a0, 0\n    lw s0, ");
        asmbuf_int(&buf, sp_size - 8);
        asmbuf_puts(&buf, "(sp)\n    lw ra, ");
        asmbuf_int(&buf, sp_size - 4);
        asmbuf_puts(&buf, "(sp)\n    addi sp, sp, ");
        asmbuf_int(&buf, sp_size);
        asmbuf_puts(&buf, "\n    ret\n\n");
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
