/* Ark C Compiler - x86_64 (System V ABI) backend
 *
 * Emits GAS-syntax x86_64 assembly. The goal of this backend is "syntactically
 * correct, human-readable, and can be further assembled by GNU as", so the
 * assemble stage is a stub (passes through text).
 *
 * Calling convention: arguments are passed via rdi, rsi, rdx, rcx, r8, r9;
 * the rest go on the stack. Uses a push/pop virtual operand stack (identical
 * to the IR); integers are all treated as 8-byte. Local variables and
 * parameters are accessed via negative offsets from %rbp.
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "common.h"
#include "ir.h"

static const char *arg_reg(int i) {
    static const char *r[] = { "rdi", "rsi", "rdx", "rcx", "r8", "r9" };
    if (i < 0 || i >= 6) return "rax";
    return r[i];
}

static void emit_str_literal_x(AsmBuffer *b, const char *data, int len) {
    int i;
    asmbuf_putc(b, '"');
    for (i = 0; i < len; i++) {
        unsigned char c = (unsigned char)data[i];
        switch (c) {
            case '\n': asmbuf_puts(b, "\\n"); break;
            case '\t': asmbuf_puts(b, "\\t"); break;
            case '\r': asmbuf_puts(b, "\\r"); break;
            case '\\': asmbuf_puts(b, "\\\\"); break;
            case '"':  asmbuf_puts(b, "\\\""); break;
            default:
                if (c < 0x20 || c >= 0x7F) {
                    const char *hex = "0123456789abcdef";
                    asmbuf_puts(b, "\\x");
                    asmbuf_putc(b, hex[(c>>4)&0xF]);
                    asmbuf_putc(b, hex[c&0xF]);
                } else {
                    asmbuf_putc(b, (char)c);
                }
                break;
        }
    }
    asmbuf_putc(b, '"');
}

static const char *binop_x(int op) {
    switch (op) {
        case (int)TOK_PLUS:  return "add";
        case (int)TOK_MINUS: return "sub";
        case (int)TOK_BAND:  return "and";
        case (int)TOK_BOR:   return "or";
        case (int)TOK_BXOR:  return "xor";
        default:             return 0;
    }
}

static int x86_emit(IrProgram *prog, char *out, int cap) {
    AsmBuffer buf;
    int fi;
    asmbuf_init(&buf);

    asmbuf_puts(&buf, "# Ark C Compiler - generated x86_64 (System V) assembly\n");
    asmbuf_puts(&buf, "    .intel_syntax noprefix\n");
    asmbuf_puts(&buf, "    .section .rodata\n");
    {
        int i;
        for (i = 0; i < prog->string_count; i++) {
            IrString *s = prog->strings[i];
            asmbuf_puts(&buf, "ark_str_");
            asmbuf_int(&buf, s->id);
            asmbuf_puts(&buf, ":\n    .asciz ");
            /* .asciz "..." still works under intel_syntax */
            emit_str_literal_x(&buf, s->data, s->len);
            asmbuf_putc(&buf, '\n');
        }
    }
    asmbuf_puts(&buf, "    .data\n");
    {
        int i;
        for (i = 0; i < prog->global_count; i++) {
            IrGlobal *g = prog->globals[i];
            if (g->is_extern) continue;  /* extern: no definition */
            asmbuf_puts(&buf, "    .globl ");
            asmbuf_puts(&buf, g->name);
            asmbuf_putc(&buf, '\n');
            if (g->is_static) {
                asmbuf_puts(&buf, "    .local ");
                asmbuf_puts(&buf, g->name);
                asmbuf_putc(&buf, '\n');
            }
            asmbuf_puts(&buf, g->name);
            asmbuf_puts(&buf, ":\n");
            if (g->is_float && g->has_init) {
                /* Float/double global: emit raw bits */
                union { double d; long long i; } u;
                u.d = g->init_float;
                asmbuf_puts(&buf, "    .quad ");
                asmbuf_int(&buf, u.i);
                asmbuf_putc(&buf, '\n');
            } else if (g->init_aggregate && g->has_init) {
                /* Aggregate initializer: emit as .quad 0 (simplified).
                 * The C backend handles full aggregate init; for x86_64 asm
                 * we emit a placeholder. Real aggregate init would require
                 * parsing the init_aggregate string. */
                int sz = g->type ? type_size(g->type) : 8;
                int n = (sz + 7) / 8;
                int k;
                for (k = 0; k < n; k++) {
                    asmbuf_puts(&buf, "    .quad 0\n");
                }
            } else {
                asmbuf_puts(&buf, "    .quad ");
                asmbuf_int(&buf, g->has_init ? g->init_int : 0);
                asmbuf_putc(&buf, '\n');
            }
        }
    }
    asmbuf_puts(&buf, "    .text\n");

    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        int i;
        int local_size = (f->local_size + 15) & ~15;
        if (local_size < 16) local_size = 16;

        asmbuf_puts(&buf, "    .globl ");
        asmbuf_puts(&buf, f->name);
        asmbuf_putc(&buf, '\n');
        asmbuf_puts(&buf, f->name);
        asmbuf_puts(&buf, ":\n");
        asmbuf_puts(&buf, "    push rbp\n");
        asmbuf_puts(&buf, "    mov rbp, rsp\n");
        asmbuf_puts(&buf, "    sub rsp, ");
        asmbuf_int(&buf, local_size + 256);
        asmbuf_putc(&buf, '\n');

        for (i = 0; i < f->code_count; i++) {
            IrInst *I = &f->code[i];
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END:
                    break;
                case IR_GETARG:
                    asmbuf_puts(&buf, "    mov [rbp-");
                    asmbuf_int(&buf, 8 + I->val);
                    asmbuf_puts(&buf, "], ");
                    asmbuf_puts(&buf, arg_reg(I->aux));
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_PUSH_INT:
                    asmbuf_puts(&buf, "    push ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_PUSH_STR:
                    asmbuf_puts(&buf, "    lea rax, [rip+ark_str_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "]\n    push rax\n");
                    break;
                case IR_PUSH_VAR:
                    asmbuf_puts(&buf, "    push qword ptr [rbp-");
                    asmbuf_int(&buf, 8 + I->val);
                    asmbuf_puts(&buf, "]\n");
                    break;
                case IR_PUSH_ADDR:
                    asmbuf_puts(&buf, "    lea rax, [rbp-");
                    asmbuf_int(&buf, 8 + I->val);
                    asmbuf_puts(&buf, "]\n    push rax\n");
                    break;
                case IR_PUSH_GLOBAL:
                    asmbuf_puts(&buf, "    mov rax, [rip+");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "]\n    push rax\n");
                    break;
                case IR_STORE_GLOBAL:
                    asmbuf_puts(&buf, "    pop rax\n    mov [rip+");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "], rax\n");
                    break;
                case IR_POP:
                    asmbuf_puts(&buf, "    add rsp, 8\n");
                    break;
                case IR_DUP:
                    asmbuf_puts(&buf, "    mov rax, [rsp]\n    push rax\n");
                    break;
                case IR_SWAP:
                    asmbuf_puts(&buf, "    pop rax\n    pop rcx\n    push rax\n    push rcx\n");
                    break;
                case IR_STORE:
                    asmbuf_puts(&buf, "    pop rax\n    mov [rbp-");
                    asmbuf_int(&buf, 8 + I->val);
                    asmbuf_puts(&buf, "], rax\n");
                    break;
                case IR_LOAD_IDX:
                    asmbuf_puts(&buf, "    pop rcx\n    pop rax\n");
                    if (I->val == 1) asmbuf_puts(&buf, "    movsx rax, byte ptr [rax+rcx]\n");
                    else { asmbuf_puts(&buf, "    imul rcx, "); asmbuf_int(&buf, I->val);
                           asmbuf_puts(&buf, "\n    mov eax, dword ptr [rax+rcx]\n    movsx rax, eax\n"); }
                    asmbuf_puts(&buf, "    push rax\n");
                    break;
                case IR_STORE_IDX:
                    asmbuf_puts(&buf, "    pop rdx\n    pop rax\n");
                    if (I->val == 1) asmbuf_puts(&buf, "    mov byte ptr [rax], dl\n");
                    else asmbuf_puts(&buf, "    mov dword ptr [rax], edx\n");
                    asmbuf_puts(&buf, "    push rdx\n");
                    break;
                case IR_BINARY: {
                    const char *op = binop_x(I->aux);
                    if (op) {
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    ");
                        asmbuf_puts(&buf, op);
                        asmbuf_puts(&buf, " rax, rcx\n    push rax\n");
                    } else if (I->aux == (int)TOK_MUL) {
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    imul rax, rcx\n    push rax\n");
                    } else if (I->aux == (int)TOK_DIV) {
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    cqo\n    idiv rcx\n    push rax\n");
                    } else if (I->aux == (int)TOK_MOD) {
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    cqo\n    idiv rcx\n    push rdx\n");
                    } else if (I->aux == (int)TOK_SHL) {
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    shl rax, cl\n    push rax\n");
                    } else if (I->aux == (int)TOK_SHR) {
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    sar rax, cl\n    push rax\n");
                    } else {
                        const char *cc = 0;
                        switch (I->aux) {
                            case (int)TOK_EQ: cc = "sete";  break;
                            case (int)TOK_NE: cc = "setne"; break;
                            case (int)TOK_LT: cc = "setl";  break;
                            case (int)TOK_GT: cc = "setg";  break;
                            case (int)TOK_LE: cc = "setle"; break;
                            case (int)TOK_GE: cc = "setge"; break;
                            default: cc = "sete"; break;
                        }
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    cmp rax, rcx\n    ");
                        asmbuf_puts(&buf, cc);
                        asmbuf_puts(&buf, " al\n    movzx rax, al\n    push rax\n");
                    }
                    break;
                }
                case IR_UNARY:
                    asmbuf_puts(&buf, "    pop rax\n");
                    if (I->aux == (int)TOK_MINUS) asmbuf_puts(&buf, "    neg rax\n");
                    else if (I->aux == (int)TOK_BNOT) asmbuf_puts(&buf, "    not rax\n");
                    else if (I->aux == (int)TOK_NOT) asmbuf_puts(&buf, "    test rax, rax\n    sete al\n    movzx rax, al\n");
                    asmbuf_puts(&buf, "    push rax\n");
                    break;
                case IR_LABEL:
                    asmbuf_puts(&buf, ".L");
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
                    asmbuf_puts(&buf, "    jmp .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JMP_NAMED:
                    asmbuf_puts(&buf, "    jmp .LN_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JZ:
                    asmbuf_puts(&buf, "    pop rax\n    test rax, rax\n    jz .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JNZ:
                    asmbuf_puts(&buf, "    pop rax\n    test rax, rax\n    jnz .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_CMP_JMP_EQ:
                    asmbuf_puts(&buf, "    mov rax, [rsp]\n    cmp rax, ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    jne 1f\n    add rsp, 8\n    jmp .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, "\n1:\n");
                    break;
                case IR_CALL: {
                    int n = I->val;
                    int k;
                    int reg_args = (n > 6) ? 6 : n;
                    int stack_args = (n > 6) ? (n - 6) : 0;
                    /* SysV ABI requires rsp 16-byte aligned at call instruction.
                     * Our push/pop stack means rsp is 8 mod 16 after prologue
                     * (push rbp). Each push subtracts 8. We need to compute
                     * alignment before popping register args.
                     * Strategy: pop reg args, then if stack_args is odd, the
                     * total pushed args (reg_args + stack_args) parity determines
                     * if we need padding. */
                    /* Pop register args from stack (they were pushed in reverse) */
                    for (k = 0; k < reg_args; k++) {
                        asmbuf_puts(&buf, "    pop ");
                        asmbuf_puts(&buf, arg_reg(k));
                        asmbuf_putc(&buf, '\n');
                    }
                    /* Stack args (args 7+) are already on the stack in correct
                     * order. After popping reg args, stack_args items remain.
                     * SysV: caller pushes stack args, callee reads [rbp+16+].
                     * We need 16-byte alignment at call. If stack_args is odd,
                     * sub rsp, 8 before call, add rsp, 8 after. */
                    if (stack_args > 0) {
                        /* stack_args are on stack; need to align rsp to 16 */
                        asmbuf_puts(&buf, "    sub rsp, 8\n");
                        asmbuf_puts(&buf, "    xor eax, eax\n    call ");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "\n    add rsp, 8\n");
                        /* clean up stack_args (caller cleanup) */
                        asmbuf_puts(&buf, "    add rsp, ");
                        asmbuf_int(&buf, stack_args * 8);
                        asmbuf_putc(&buf, '\n');
                    } else {
                        asmbuf_puts(&buf, "    xor eax, eax\n    call ");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, '\n');
                    }
                    asmbuf_puts(&buf, "    push rax\n");
                    break;
                }
                case IR_RETURN:
                    asmbuf_puts(&buf, "    pop rax\n    mov rsp, rbp\n    pop rbp\n    ret\n");
                    break;
                /* === B1: Missing IR operations for completeness === */

                /* IR_LOCAL_ALLOC: no-op on x86_64; locals are pre-allocated in
                 * the frame via sub rsp.  Used by opt_inline for offset tracking. */
                case IR_LOCAL_ALLOC:
                    break;
                /* IR_ARG: legacy, never emitted by irgen. */
                case IR_ARG:
                    break;

                /* IR_PUSH_GLOBAL_ADDR: push &global (no dereference).
                 * Needed for array/struct decay and compound literals. */
                case IR_PUSH_GLOBAL_ADDR:
                    asmbuf_puts(&buf, "    lea rax, [rip+");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "]\n    push rax\n");
                    break;

                /* IR_MEMCPY: pop dst, pop src, copy I->val bytes.
                 * Used for struct assignment and pass-by-value. */
                case IR_MEMCPY:
                    asmbuf_puts(&buf, "    pop rdi\n    pop rsi\n    mov rcx, ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    rep movsb\n");
                    break;

                /* IR_ALLOCA: VLA dynamic stack alloc.
                 * Pop byte count, align to 16, subtract from rsp, push base. */
                case IR_ALLOCA:
                    asmbuf_puts(&buf, "    pop rax\n    add rax, 15\n    and rax, -16\n");
                    asmbuf_puts(&buf, "    sub rsp, rax\n    mov rax, rsp\n    push rax\n");
                    break;

                /* IR_DIV / IR_MOD: integer division.
                 * aux=0 signed, aux=1 unsigned. */
                case IR_DIV:
                    asmbuf_puts(&buf, "    pop rcx\n    pop rax\n");
                    if (I->aux & 1)
                        asmbuf_puts(&buf, "    xor edx, edx\n    div rcx\n    push rax\n");
                    else
                        asmbuf_puts(&buf, "    cqo\n    idiv rcx\n    push rax\n");
                    break;
                case IR_MOD:
                    asmbuf_puts(&buf, "    pop rcx\n    pop rax\n");
                    if (I->aux & 1)
                        asmbuf_puts(&buf, "    xor edx, edx\n    div rcx\n    push rdx\n");
                    else
                        asmbuf_puts(&buf, "    cqo\n    idiv rcx\n    push rdx\n");
                    break;

                /* IR_PUSH_FLOAT: push a float/double constant.
                 * aux bit 0x200 = double.  val = index into prog->floats[].
                 * On x86_64, doubles are 8 bytes, so we push the raw bits. */
                case IR_PUSH_FLOAT: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    int is_complex = (I->aux & 0x400) != 0;
                    if (is_complex) {
                        /* _Complex double: push real then imag (2 slots) */
                        int cid = I->val;
                        if (cid >= 0 && cid < prog->complex_count) {
                            double re = prog->complexes[cid].re;
                            double im = prog->complexes[cid].im;
                            union { double d; long long i; } ure, uim;
                            ure.d = re; uim.d = im;
                            asmbuf_puts(&buf, "    movabs rax, ");
                            asmbuf_int(&buf, ure.i);
                            asmbuf_puts(&buf, "\n    push rax\n");
                            asmbuf_puts(&buf, "    movabs rax, ");
                            asmbuf_int(&buf, uim.i);
                            asmbuf_puts(&buf, "\n    push rax\n");
                        } else {
                            asmbuf_puts(&buf, "    push 0\n    push 0\n");
                        }
                    } else if (is_dbl) {
                        double v = (I->val >= 0 && I->val < prog->float_count) ?
                                   prog->floats[I->val] : 0.0;
                        union { double d; long long i; } u;
                        u.d = v;
                        asmbuf_puts(&buf, "    movabs rax, ");
                        asmbuf_int(&buf, u.i);
                        asmbuf_puts(&buf, "\n    push rax\n");
                    } else {
                        /* float: promote to double for uniform stack representation */
                        float fv = (float)((I->val >= 0 && I->val < prog->float_count) ?
                                   prog->floats[I->val] : 0.0);
                        double v = (double)fv;
                        union { double d; long long i; } u;
                        u.d = v;
                        asmbuf_puts(&buf, "    movabs rax, ");
                        asmbuf_int(&buf, u.i);
                        asmbuf_puts(&buf, "\n    push rax\n");
                    }
                    break;
                }

                /* IR_FADD/FSUB/FMUL/FDIV: floating-point arithmetic.
                 * Operands are doubles on the stack (8 bytes each).
                 * Uses SSE2 for computation. */
                case IR_FADD:
                case IR_FSUB:
                case IR_FMUL:
                case IR_FDIV: {
                    const char *op_s = 0;
                    switch (I->op) {
                        case IR_FADD: op_s = "addsd"; break;
                        case IR_FSUB: op_s = "subsd"; break;
                        case IR_FMUL: op_s = "mulsd"; break;
                        case IR_FDIV: op_s = "divsd"; break;
                        default: break;
                    }
                    /* _Complex double (aux & 0x400): two ops on real/imag parts */
                    if (I->aux & 0x400) {
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm1, rax\n");  /* imag b */
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm3, rax\n");  /* real b */
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm2, rax\n");  /* imag a */
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm0, rax\n");  /* real a */
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " xmm0, xmm3\n    ");  /* real = a.r op b.r */
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " xmm2, xmm1\n");      /* imag = a.i op b.i */
                        asmbuf_puts(&buf, "    movq rax, xmm0\n    push rax\n");
                        asmbuf_puts(&buf, "    movq rax, xmm2\n    push rax\n");
                    } else {
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm1, rax\n");
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm0, rax\n    ");
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " xmm0, xmm1\n    movq rax, xmm0\n    push rax\n");
                    }
                    break;
                }

                /* IR_FCMP: compare two doubles, push 0 or 1.
                 * aux = TOK_EQ/TOK_NE/TOK_LT/TOK_GT/TOK_LE/TOK_GE */
                case IR_FCMP: {
                    const char *cc = 0;
                    int is_complex = (I->aux & 0x400) != 0;
                    int cmp_op = I->aux & 0xFF;
                    if (is_complex) {
                        /* _Complex comparison: only == and != are meaningful */
                        asmbuf_puts(&buf, "    pop rax\n    pop rcx\n");  /* b (imag,real) */
                        asmbuf_puts(&buf, "    pop rdx\n    pop r8\n");   /* a (imag,real) */
                        asmbuf_puts(&buf, "    xor eax, eax\n    cmp r8, rcx\n    sete al\n");
                        asmbuf_puts(&buf, "    mov r9d, eax\n    cmp rdx, rax\n    sete al\n");
                        asmbuf_puts(&buf, "    and eax, r9d\n");
                        if ((cmp_op & 0xF) == (int)TOK_NE) {
                            asmbuf_puts(&buf, "    xor eax, 1\n");
                        }
                        asmbuf_puts(&buf, "    movzx rax, al\n    push rax\n");
                    } else {
                        switch (cmp_op) {
                            case (int)TOK_EQ: cc = "sete";  break;
                            case (int)TOK_NE: cc = "setne"; break;
                            case (int)TOK_LT: cc = "seta";  break;  /* b<a for ucomisd */
                            case (int)TOK_GT: cc = "setb";  break;
                            case (int)TOK_LE: cc = "setae"; break;
                            case (int)TOK_GE: cc = "setbe"; break;
                            default: cc = "sete"; break;
                        }
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm1, rax\n");
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm0, rax\n");
                        asmbuf_puts(&buf, "    ucomisd xmm0, xmm1\n    ");
                        asmbuf_puts(&buf, cc);
                        asmbuf_puts(&buf, " al\n    movzx rax, al\n    push rax\n");
                    }
                    break;
                }

                /* IR_F2I: double -> int (truncate toward zero) */
                case IR_F2I: {
                    /* 0x400 = unsigned destination. cvttsd2si to 64-bit rax
                     * correctly handles the full 32-bit unsigned range
                     * (0..2^32-1 fits in a signed 64-bit int). The result
                     * is then truncated to 32 bits by the caller. */
                    asmbuf_puts(&buf, "    pop rax\n    movq xmm0, rax\n");
                    asmbuf_puts(&buf, "    cvttsd2si rax, xmm0\n    push rax\n");
                    break;
                }

                /* IR_I2F: int -> double */
                case IR_I2F: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    asmbuf_puts(&buf, "    pop rax\n    cvtsi2sd xmm0, rax\n    movq rax, xmm0\n    push rax\n");
                    if (!is_dbl) {
                        /* float: round to float precision then back to double */
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm0, rax\n");
                        asmbuf_puts(&buf, "    cvtsd2ss xmm0, xmm0\n    cvtss2sd xmm0, xmm0\n");
                        asmbuf_puts(&buf, "    movq rax, xmm0\n    push rax\n");
                    }
                    break;
                }

                /* IR_64PUSH: push 64-bit immediate.
                 * val=high32, aux=low32. */
                case IR_64PUSH: {
                    long long v = ((long long)(int)I->val << 32) | (unsigned int)I->aux;
                    asmbuf_puts(&buf, "    movabs rax, ");
                    asmbuf_int(&buf, v);
                    asmbuf_puts(&buf, "\n    push rax\n");
                    break;
                }

                /* IR_64BINARY: 64-bit binary op. aux = TOK_xxx | (0x100 if unsigned).
                 * On x86_64, all integers are already 8 bytes, so this is the same
                 * as IR_BINARY. */
                case IR_64BINARY: {
                    int op = I->aux & 0xFF;
                    const char *bop = binop_x(op);
                    if (bop) {
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    ");
                        asmbuf_puts(&buf, bop);
                        asmbuf_puts(&buf, " rax, rcx\n    push rax\n");
                    } else if (op == (int)TOK_MUL) {
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    imul rax, rcx\n    push rax\n");
                    } else if (op == (int)TOK_DIV) {
                        if (I->aux & 0x100)
                            asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    xor edx, edx\n    div rcx\n    push rax\n");
                        else
                            asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    cqo\n    idiv rcx\n    push rax\n");
                    } else if (op == (int)TOK_MOD) {
                        if (I->aux & 0x100)
                            asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    xor edx, edx\n    div rcx\n    push rdx\n");
                        else
                            asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    cqo\n    idiv rcx\n    push rdx\n");
                    } else if (op == (int)TOK_SHL) {
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    shl rax, cl\n    push rax\n");
                    } else if (op == (int)TOK_SHR) {
                        if (I->aux & 0x100)
                            asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    shr rax, cl\n    push rax\n");
                        else
                            asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    sar rax, cl\n    push rax\n");
                    } else {
                        const char *cc = 0;
                        switch (op) {
                            case (int)TOK_EQ: cc = "sete";  break;
                            case (int)TOK_NE: cc = "setne"; break;
                            case (int)TOK_LT: cc = (I->aux & 0x100) ? "setb" : "setl";  break;
                            case (int)TOK_GT: cc = (I->aux & 0x100) ? "seta" : "setg";  break;
                            case (int)TOK_LE: cc = (I->aux & 0x100) ? "setbe" : "setle"; break;
                            case (int)TOK_GE: cc = (I->aux & 0x100) ? "setae" : "setge"; break;
                            default: cc = "sete"; break;
                        }
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    cmp rax, rcx\n    ");
                        asmbuf_puts(&buf, cc);
                        asmbuf_puts(&buf, " al\n    movzx rax, al\n    push rax\n");
                    }
                    break;
                }

                /* IR_64CMP: 64-bit compare. aux = TOK_xxx | (0x100 if unsigned). */
                case IR_64CMP:
                    /* Same as 64BINARY comparison path */
                    {
                        int op = I->aux & 0xFF;
                        const char *cc = 0;
                        switch (op) {
                            case (int)TOK_EQ: cc = "sete";  break;
                            case (int)TOK_NE: cc = "setne"; break;
                            case (int)TOK_LT: cc = (I->aux & 0x100) ? "setb" : "setl";  break;
                            case (int)TOK_GT: cc = (I->aux & 0x100) ? "seta" : "setg";  break;
                            case (int)TOK_LE: cc = (I->aux & 0x100) ? "setbe" : "setle"; break;
                            case (int)TOK_GE: cc = (I->aux & 0x100) ? "setae" : "setge"; break;
                            default: cc = "sete"; break;
                        }
                        asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    cmp rax, rcx\n    ");
                        asmbuf_puts(&buf, cc);
                        asmbuf_puts(&buf, " al\n    movzx rax, al\n    push rax\n");
                    }
                    break;

                /* IR_64F2I / IR_64I2F: 64-bit float <-> 64-bit int.
                 * On x86_64 these are the same as F2I/I2F since long long is 8 bytes. */
                case IR_64F2I:
                    asmbuf_puts(&buf, "    pop rax\n    movq xmm0, rax\n    cvttsd2si rax, xmm0\n    push rax\n");
                    break;
                case IR_64I2F:
                    asmbuf_puts(&buf, "    pop rax\n    cvtsi2sd xmm0, rax\n    movq rax, xmm0\n    push rax\n");
                    break;

                /* IR_STORE_FLD: bitfield store. val=bit_off, aux=bit_width.
                 * Pop value, pop addr, mask+insert into 32-bit word at addr. */
                case IR_STORE_FLD: {
                    int bit_off = I->val;
                    int bw = I->aux;
                    unsigned mask = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    asmbuf_puts(&buf, "    pop rax\n    pop rcx\n");  /* value, addr */
                    asmbuf_puts(&buf, "    mov edx, dword ptr [rcx]\n");
                    asmbuf_puts(&buf, "    and eax, ");
                    asmbuf_int(&buf, (int)mask);
                    asmbuf_puts(&buf, "\n");
                    if (bit_off > 0) {
                        asmbuf_puts(&buf, "    shl eax, ");
                        asmbuf_int(&buf, bit_off);
                        asmbuf_puts(&buf, "\n");
                        asmbuf_puts(&buf, "    shl edx, ");
                        asmbuf_int(&buf, 32 - bit_off);
                        asmbuf_puts(&buf, "\n    shr edx, ");
                        asmbuf_int(&buf, 32 - bit_off);
                        asmbuf_puts(&buf, "\n    or eax, edx\n");
                    } else {
                        asmbuf_puts(&buf, "    and edx, ");
                        asmbuf_int(&buf, (int)(~mask));
                        asmbuf_puts(&buf, "\n    or eax, edx\n");
                    }
                    asmbuf_puts(&buf, "    mov dword ptr [rcx], eax\n    push rax\n");
                    break;
                }

                /* IR_LOAD_FLD: bitfield load. val=bit_off, aux=bit_width.
                 * Pop addr, load 32-bit word, extract bitfield. */
                case IR_LOAD_FLD: {
                    int bit_off = I->val;
                    int bw = I->aux;
                    unsigned mask = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    asmbuf_puts(&buf, "    pop rax\n    mov eax, dword ptr [rax]\n");
                    if (bit_off > 0) {
                        asmbuf_puts(&buf, "    shr eax, ");
                        asmbuf_int(&buf, bit_off);
                        asmbuf_puts(&buf, "\n");
                    }
                    asmbuf_puts(&buf, "    and eax, ");
                    asmbuf_int(&buf, (int)mask);
                    asmbuf_puts(&buf, "\n    movzx rax, eax\n    push rax\n");
                    break;
                }

                /* IR_ASM: inline assembly.  On x86_64, emit as-is.
                 * The name field contains the template (possibly with @ prefix
                 * for extended asm).  For x86_64 we write the template directly. */
                case IR_ASM:
                    if (I->name) {
                        const char *s = I->name;
                        if (s[0] == '@') {
                            /* Extended asm: skip to first quote, write content */
                            s++;
                            while (*s == ' ' || *s == '\t') s++;
                            if (*s == '"') {
                                s++;
                                while (*s && *s != '"') {
                                    asmbuf_putc(&buf, *s);
                                    s++;
                                }
                            }
                        } else {
                            asmbuf_puts(&buf, s);
                        }
                        asmbuf_putc(&buf, '\n');
                    }
                    break;

                /* IR_SVC / IR_SMC / IR_SIMD_*: ARM-specific, emit as comment on x86_64 */
                case IR_SVC:
                case IR_SMC:
                case IR_SIMD_ADD16:
                case IR_SIMD_SUB16:
                case IR_SIMD_ADD8:
                case IR_SIMD_SUB8:
                    asmbuf_puts(&buf, "    # ARM-specific op (");
                    asmbuf_puts(&buf, ir_op_name(I->op));
                    asmbuf_puts(&buf, ") - not applicable on x86_64\n");
                    break;

                default:
                    asmbuf_puts(&buf, "    # unknown IR op: ");
                    asmbuf_puts(&buf, ir_op_name(I->op));
                    asmbuf_puts(&buf, "\n");
                    break;
            }
        }
        asmbuf_puts(&buf, "    xor eax, eax\n    mov rsp, rbp\n    pop rbp\n    ret\n\n");
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

static int x86_assemble(const char *asm_text, unsigned char *out, int cap) {
    int n = ark_strlen(asm_text);
    int i;
    if (n > cap) n = cap;
    for (i = 0; i < n; i++) out[i] = (unsigned char)asm_text[i];
    return n;
}

static int x86_link(unsigned char *c, int s, struct LinkContext *lc) {
    (void)c; (void)s; (void)lc;
    return 0;
}

static const ArkBackend g_x86_backend = {
    "x86_64",
    "x86_64-linux-sysv",
    8,
    x86_emit,
    x86_assemble,
    x86_link
};

const ArkBackend *ark_backend_x86_64(void) {
    return &g_x86_backend;
}



