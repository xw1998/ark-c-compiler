/* Ark C Compiler - x86_64 (System V ABI) backend
 *
 * 输出 GAS 语法 x86_64 汇编。本后端的目标是"语法正确、人类可读、
 * 可继续用 GNU as 汇编"，所以 assemble 阶段是 stub（透传文本）。
 *
 * 调用约定：参数通过 rdi, rsi, rdx, rcx, r8, r9 传递；其余走栈。
 * 使用一个 push/pop 的虚拟运算栈（与 IR 完全一致），整数都按 8 字节处理。
 * 局部变量与参数通过 %rbp 的负偏移访问。
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "common.h"

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
            /* intel_syntax 下仍可用 .asciz "..." */
            emit_str_literal_x(&buf, s->data, s->len);
            asmbuf_putc(&buf, '\n');
        }
    }
    asmbuf_puts(&buf, "    .data\n");
    {
        int i;
        for (i = 0; i < prog->global_count; i++) {
            IrGlobal *g = prog->globals[i];
            asmbuf_puts(&buf, "    .globl ");
            asmbuf_puts(&buf, g->name);
            asmbuf_putc(&buf, '\n');
            asmbuf_puts(&buf, g->name);
            asmbuf_puts(&buf, ":\n    .quad ");
            asmbuf_int(&buf, g->has_init ? g->init_int : 0);
            asmbuf_putc(&buf, '\n');
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
                    asmbuf_puts(&buf, "    mov QWORD PTR [rbp-");
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
                    asmbuf_puts(&buf, "    push QWORD PTR [rbp-");
                    asmbuf_int(&buf, 8 + I->val);
                    asmbuf_puts(&buf, "]\n");
                    break;
                case IR_PUSH_ADDR:
                    asmbuf_puts(&buf, "    lea rax, [rbp-");
                    asmbuf_int(&buf, 8 + I->val);
                    asmbuf_puts(&buf, "]\n    push rax\n");
                    break;
                case IR_PUSH_GLOBAL:
                    asmbuf_puts(&buf, "    mov rax, QWORD PTR [rip+");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "]\n    push rax\n");
                    break;
                case IR_STORE_GLOBAL:
                    asmbuf_puts(&buf, "    pop rax\n    mov QWORD PTR [rip+");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "], rax\n");
                    break;
                case IR_POP:
                    asmbuf_puts(&buf, "    add rsp, 8\n");
                    break;
                case IR_DUP:
                    asmbuf_puts(&buf, "    mov rax, [rsp]\n    push rax\n");
                    break;
                case IR_STORE:
                    asmbuf_puts(&buf, "    pop rax\n    mov QWORD PTR [rbp-");
                    asmbuf_int(&buf, 8 + I->val);
                    asmbuf_puts(&buf, "], rax\n");
                    break;
                case IR_LOAD_IDX:
                    asmbuf_puts(&buf, "    pop rcx\n    pop rax\n");
                    if (I->val == 1) asmbuf_puts(&buf, "    movsx rax, BYTE PTR [rax+rcx]\n");
                    else { asmbuf_puts(&buf, "    imul rcx, "); asmbuf_int(&buf, I->val);
                           asmbuf_puts(&buf, "\n    mov eax, DWORD PTR [rax+rcx]\n    movsx rax, eax\n"); }
                    asmbuf_puts(&buf, "    push rax\n");
                    break;
                case IR_STORE_IDX:
                    asmbuf_puts(&buf, "    pop rdx\n    pop rax\n");
                    if (I->val == 1) asmbuf_puts(&buf, "    mov BYTE PTR [rax], dl\n");
                    else asmbuf_puts(&buf, "    mov DWORD PTR [rax], edx\n");
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
                    /* 弹出 n 个参数到 rdi..r9 */
                    for (k = 0; k < n && k < 6; k++) {
                        asmbuf_puts(&buf, "    pop ");
                        asmbuf_puts(&buf, arg_reg(k));
                        asmbuf_putc(&buf, '\n');
                    }
                    asmbuf_puts(&buf, "    xor eax, eax\n    call ");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "\n    push rax\n");
                    break;
                }
                case IR_RETURN:
                    asmbuf_puts(&buf, "    pop rax\n    mov rsp, rbp\n    pop rbp\n    ret\n");
                    break;
                default:
                    asmbuf_puts(&buf, "    # unknown\n");
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
