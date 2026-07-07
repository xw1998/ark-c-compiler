/* Ark C Compiler - x86 (32-bit, cdecl ABI) backend
 *
 * Emits GAS-syntax AT&T x86 assembly for 32-bit targets (i686-mingw32/i386-linux).
 * The assemble stage passes through text to be assembled by GNU as.
 *
 * Calling convention (cdecl): all arguments passed on stack (right-to-left),
 * caller cleanup. Uses a push/pop virtual operand stack. Local variables
 * and parameters accessed via negative offsets from %ebp.
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "common.h"
#include "ir.h"
#include <stdio.h>

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
        case (int)TOK_PLUS:  return "addl";
        case (int)TOK_MINUS: return "subl";
        case (int)TOK_BAND:  return "andl";
        case (int)TOK_BOR:   return "orl";
        case (int)TOK_BXOR:  return "xorl";
        default:             return 0;
    }
}

static const char *shiftop_x(int op) {
    switch (op) {
        case (int)TOK_SHL: return "shll";
        case (int)TOK_SHR: return "shrl";
        default:           return 0;
    }
}

/* Emit a symbol name with PE/COFF leading underscore (cdecl convention
 * on i686-mingw32: C symbols are prefixed with '_'). */
static void emit_sym(AsmBuffer *b, const char *name) {
    asmbuf_putc(b, '_');
    asmbuf_puts(b, name);
}

/* Parse and emit an aggregate initializer for the x86 backend.
 * The init_aggregate string is in C-syntax format produced by irgen's
 * serialize_init(): {val1,val2,...} where each val is:
 *   "string"    -> add to string pool, emit .long ark_str_N
 *   number      -> emit .long number
 *   identifier  -> emit .long _identifier (function/var pointer)
 *   {nested}    -> recurse
 *   (expr)      -> evaluate inner expression
 * All scalar values are 4 bytes on 32-bit x86 (pointers, ints, function ptrs). */
static const char *parse_agg_value(AsmBuffer *b, IrProgram *prog, const char *p);

static const char *parse_agg_list(AsmBuffer *b, IrProgram *prog, const char *p) {
    /* p points to '{' */
    p++; /* skip '{' */
    while (*p && *p != '}') {
        /* Skip designated initializers: .field= or [idx]= */
        if (*p == '.') {
            p++;
            while (*p && *p != '=') p++;
            if (*p == '=') p++;
        } else if (*p == '[') {
            p++;
            while (*p && *p != ']') p++;
            if (*p == ']') p++;
            if (*p == '=') p++;
        }
        p = parse_agg_value(b, prog, p);
        while (*p == ' ' || *p == '\t') p++;
        if (*p == ',') { p++; continue; }
        break;
    }
    if (*p == '}') p++;
    return p;
}

static const char *parse_agg_value(AsmBuffer *b, IrProgram *prog, const char *p) {
    while (*p == ' ' || *p == '\t' || *p == '\n') p++;
    if (*p == '{') {
        return parse_agg_list(b, prog, p);
    } else if (*p == '"') {
        /* String literal: parse it, add to string pool, emit pointer */
        char strbuf[1024];
        int slen = 0;
        p++; /* skip opening " */
        while (*p && *p != '"' && slen < (int)sizeof(strbuf) - 1) {
            if (*p == '\\') {
                p++;
                switch (*p) {
                    case 'n': strbuf[slen++] = '\n'; break;
                    case 't': strbuf[slen++] = '\t'; break;
                    case 'r': strbuf[slen++] = '\r'; break;
                    case '"': strbuf[slen++] = '"';  break;
                    case '\\': strbuf[slen++] = '\\'; break;
                    case '0': strbuf[slen++] = '\0'; break;
                    case 'x': {
                        int hi = -1, lo = -1;
                        p++;
                        if (*p >= '0' && *p <= '9') hi = *p - '0';
                        else if (*p >= 'a' && *p <= 'f') hi = *p - 'a' + 10;
                        else if (*p >= 'A' && *p <= 'F') hi = *p - 'A' + 10;
                        if (hi >= 0) {
                            p++;
                            if (*p >= '0' && *p <= '9') lo = *p - '0';
                            else if (*p >= 'a' && *p <= 'f') lo = *p - 'a' + 10;
                            else if (*p >= 'A' && *p <= 'F') lo = *p - 'A' + 10;
                            if (lo >= 0) { strbuf[slen++] = (char)(hi * 16 + lo); }
                            else { strbuf[slen++] = (char)hi; p--; }
                        } else p--;
                        break;
                    }
                    default: strbuf[slen++] = *p; break;
                }
                p++;
            } else {
                strbuf[slen++] = *p++;
            }
        }
        if (*p == '"') p++;
        strbuf[slen] = 0;
        {
            int sid = ir_program_add_string(prog, strbuf, slen);
            asmbuf_puts(b, "    .long ark_str_");
            asmbuf_int(b, sid);
            asmbuf_putc(b, '\n');
        }
        return p;
    } else if (*p == '-' || *p == '~' || (*p >= '0' && *p <= '9')) {
        /* Number literal (possibly negated/bitted) */
        long long val = 0;
        int neg = 0;
        int bnot = 0;
        if (*p == '-') { neg = 1; p++; }
        if (*p == '~') { bnot = 1; p++; }
        if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X')) {
            p += 2;
            while (*p) {
                int d = -1;
                if (*p >= '0' && *p <= '9') d = *p - '0';
                else if (*p >= 'a' && *p <= 'f') d = *p - 'a' + 10;
                else if (*p >= 'A' && *p <= 'F') d = *p - 'A' + 10;
                if (d < 0) break;
                val = val * 16 + d;
                p++;
            }
        } else {
            while (*p >= '0' && *p <= '9') {
                val = val * 10 + (*p - '0');
                p++;
            }
        }
        if (neg) val = -val;
        if (bnot) val = ~val;
        asmbuf_puts(b, "    .long ");
        asmbuf_int(b, (int)val);
        asmbuf_putc(b, '\n');
        return p;
    } else if (*p == '(') {
        /* Parenthesized expression - skip parens, parse inner */
        p++;
        p = parse_agg_value(b, prog, p);
        while (*p && *p != ')') p++;
        if (*p == ')') p++;
        return p;
    } else if ((*p >= 'a' && *p <= 'z') || (*p >= 'A' && *p <= 'Z') || *p == '_') {
        /* Identifier: function or variable name.
         * serialize_const_expr() in irgen prepends "ark_" to function names
         * (a C-backend convention). The x86 backend doesn't use this convention,
         * so strip the "ark_" prefix if present to get the real symbol name. */
        char name[128];
        int nl = 0;
        while ((*p >= 'a' && *p <= 'z') || (*p >= 'A' && *p <= 'Z') ||
               (*p >= '0' && *p <= '9') || *p == '_') {
            if (nl < (int)sizeof(name) - 1) name[nl++] = *p;
            p++;
        }
        name[nl] = 0;
        /* Strip "ark_" prefix added by irgen's serialize_const_expr for
         * function symbols (C-backend convention, not used on x86). */
        {
            const char *emit_name = name;
            if (nl > 4 && name[0]=='a' && name[1]=='r' && name[2]=='k' && name[3]=='_') {
                emit_name = name + 4;
            }
            asmbuf_puts(b, "    .long ");
            emit_sym(b, emit_name);
            asmbuf_putc(b, '\n');
        }
        return p;
    } else if (*p == 0) {
        return p;
    } else {
        /* Unknown character - skip it */
        p++;
        return p;
    }
}

static void emit_aggregate_init_x(AsmBuffer *b, IrProgram *prog, const char *init) {
    const char *p = init;
    while (*p == ' ' || *p == '\t' || *p == '\n') p++;
    if (*p == '{') {
        parse_agg_list(b, prog, p);
    } else {
        parse_agg_value(b, prog, p);
    }
}

static int x86_emit(IrProgram *prog, char *out, int cap) {
    AsmBuffer buf;
    int fi;
    asmbuf_init(&buf);

    asmbuf_puts(&buf, "# Ark C Compiler - generated x86 (32-bit cdecl) assembly\n");
    /* Emit .data first: aggregate initializers may add new strings to the
     * pool (via ir_program_add_string). Forward references to ark_str_N
     * labels are resolved by the assembler. */
    asmbuf_puts(&buf, "    .data\n");
    {
        int i;
        for (i = 0; i < prog->global_count; i++) {
            IrGlobal *g = prog->globals[i];
            if (g->is_extern) continue;
            asmbuf_puts(&buf, "    .globl ");
            emit_sym(&buf, g->name);
            asmbuf_putc(&buf, '\n');
            emit_sym(&buf, g->name);
            asmbuf_puts(&buf, ":\n");
            if (g->is_float && g->has_init) {
                union { double d; long long i; } u;
                u.d = g->init_float;
                asmbuf_puts(&buf, "    .long ");
                asmbuf_int(&buf, (int)(u.i & 0xFFFFFFFF));
                asmbuf_putc(&buf, '\n');
                asmbuf_puts(&buf, "    .long ");
                asmbuf_int(&buf, (int)(u.i >> 32));
                asmbuf_putc(&buf, '\n');
            } else if (g->init_aggregate && g->has_init) {
                /* Aggregate init: parse the C-syntax init string and emit
                 * data for each field (strings, ints, function pointers). */
                emit_aggregate_init_x(&buf, prog, g->init_aggregate);
            } else if (g->has_init && g->init_str) {
                /* String array init: emit asciz then pad to full size. */
                int slen = g->init_str ? ark_strlen(g->init_str) : 0;
                int sz = g->type ? type_size(g->type) : slen + 1;
                asmbuf_puts(&buf, "    .asciz ");
                emit_str_literal_x(&buf, g->init_str, slen);
                asmbuf_putc(&buf, '\n');
                if (slen + 1 < sz) {
                    asmbuf_puts(&buf, "    .zero ");
                    asmbuf_int(&buf, sz - (slen + 1));
                    asmbuf_putc(&buf, '\n');
                }
            } else if (g->has_init) {
                /* Scalar init: emit first word, then zero-pad remaining bytes.
                 * Using .zero avoids emitting millions of .long 0 lines for
                 * large arrays (e.g. g_pool[64MB]). */
                int sz = g->type ? type_size(g->type) : 4;
                asmbuf_puts(&buf, "    .long ");
                asmbuf_int(&buf, (int)g->init_int);
                asmbuf_putc(&buf, '\n');
                if (sz > 4) {
                    asmbuf_puts(&buf, "    .zero ");
                    asmbuf_int(&buf, sz - 4);
                    asmbuf_putc(&buf, '\n');
                }
            } else {
                /* Uninitialized: reserve full size with .zero (BSS-like). */
                int sz = g->type ? type_size(g->type) : 4;
                asmbuf_puts(&buf, "    .zero ");
                asmbuf_int(&buf, sz);
                asmbuf_putc(&buf, '\n');
            }
        }
    }
    asmbuf_puts(&buf, "    .section .rdata,\"dr\"\n");
    {
        int i;
        for (i = 0; i < prog->string_count; i++) {
            IrString *s = prog->strings[i];
            asmbuf_puts(&buf, "ark_str_");
            asmbuf_int(&buf, s->id);
            asmbuf_puts(&buf, ":\n    .asciz ");
            emit_str_literal_x(&buf, s->data, s->len);
            asmbuf_putc(&buf, '\n');
        }
    }
    asmbuf_puts(&buf, "    .text\n");

    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        int i;
        int local_size = (f->local_size + 15) & ~15;
        if (local_size < 16) local_size = 16;

        if (!f->is_static) {
            asmbuf_puts(&buf, "    .globl ");
            emit_sym(&buf, f->name);
            asmbuf_putc(&buf, '\n');
        }
        emit_sym(&buf, f->name);
        asmbuf_puts(&buf, ":\n");
        asmbuf_puts(&buf, "    pushl %ebp\n");
        asmbuf_puts(&buf, "    movl %esp, %ebp\n");
        /* Stack probing: Windows commits stack pages lazily via a guard page.
         * If we subl a large amount and then write far below ESP, we can
         * skip the guard page and hit uncommitted memory, causing
         * STATUS_ACCESS_VIOLATION (0xC0000005) without triggering SEH.
         * Probe each 4KB page by writing a dummy byte before the final subl. */
        {
            int total = local_size + 256;
            if (total > 4096) {
                int probed = 0;
                while (probed + 4096 < total) {
                    probed += 4096;
                    asmbuf_puts(&buf, "    subl $4096, %esp\n");
                    asmbuf_puts(&buf, "    movl $0, (%esp)\n");
                }
                asmbuf_puts(&buf, "    subl $");
                asmbuf_int(&buf, total - probed);
                asmbuf_puts(&buf, ", %esp\n");
            } else {
                asmbuf_puts(&buf, "    subl $");
                asmbuf_int(&buf, total);
                asmbuf_puts(&buf, ", %esp\n");
            }
        }

        /* For variadic functions, the IR emits IR_GETARG ops with val>=8000
         * to copy a0..a7 into the C backend's virtual "frame+8000" region.
         * On x86 cdecl, variadic args are already on the stack at
         * [ebp+8+4*k]; we skip those GETARGs and instead expose the variadic
         * tail by storing the address of the first variadic arg (i.e.
         * ebp+8+4*param_count) into the global __ark_va_ptr. stdarg.h's
         * va_start(ap, last) expands to (ap = _ark_va_ptr), so this makes
         * va_start/va_arg/va_end work correctly. */
        if (f->is_variadic) {
            asmbuf_puts(&buf, "    leal ");
            asmbuf_int(&buf, 8 + f->param_count * 4);
            asmbuf_puts(&buf, "(%ebp), %eax\n");
            asmbuf_puts(&buf, "    movl %eax, __ark_va_ptr\n");
        }

        for (i = 0; i < f->code_count; i++) {
            IrInst *I = &f->code[i];
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END:
                    break;
                case IR_GETARG: {
                    /* cdecl: args at [ebp+8+4*arg_idx].
                     * I->val = destination local frame offset,
                     * I->aux & 0xFF = argument slot index,
                     * (I->aux >> 8) & 0xFF = parameter size in bytes. */
                    int arg_idx = I->aux & 0xFF;
                    int psz = (I->aux >> 8) & 0xFF;
                    /* Skip the variadic-region IR_GETARG ops (val >= 8000):
                     * they are C-backend-specific copies into the virtual
                     * frame+8000 area. The x86 prologue handles variadic
                     * args via __ark_va_ptr instead. */
                    if (I->val >= 8000) break;
                    if (psz >= 8) {
                        /* 64-bit param: read low and high 32-bit halves */
                        asmbuf_puts(&buf, "    movl ");
                        asmbuf_int(&buf, 8 + arg_idx * 4);
                        asmbuf_puts(&buf, "(%ebp), %eax\n    movl %eax, -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp)\n");
                        asmbuf_puts(&buf, "    movl ");
                        asmbuf_int(&buf, 8 + arg_idx * 4 + 4);
                        asmbuf_puts(&buf, "(%ebp), %eax\n    movl %eax, -");
                        asmbuf_int(&buf, 8 + local_size - (I->val + 4));
                        asmbuf_puts(&buf, "(%ebp)\n");
                    } else {
                        asmbuf_puts(&buf, "    movl ");
                        asmbuf_int(&buf, 8 + arg_idx * 4);
                        asmbuf_puts(&buf, "(%ebp), %eax\n    movl %eax, -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp)\n");
                    }
                    break;
                }
                case IR_PUSH_INT: {
                    /* aux low byte = size: 8 for long long (push 8 bytes),
                     * 0 for int (push 4 bytes). When 8, push low (below)
                     * then high (on top) to match the internal stack model
                     * that IR_STORE/IR_64BINARY expect.
                     * For 4-byte push, the value must be truncated to 32 bits
                     * because pushl only accepts a 32-bit immediate. If the
                     * source expression was a 64-bit negative literal (e.g.
                     * -1LL) used in a 32-bit context, I->val would be the
                     * full 64-bit value; we mask to 32 bits and re-sign-extend
                     * so the assembler accepts it. */
                    int isz = I->aux & 0xFF;
                    if (isz >= 8) {
                        unsigned long long uv = (unsigned long long)I->val;
                        asmbuf_puts(&buf, "    pushl $");
                        asmbuf_int(&buf, (long long)(unsigned int)(uv & 0xFFFFFFFFu));
                        asmbuf_puts(&buf, "\n    pushl $");
                        asmbuf_int(&buf, (long long)(unsigned int)((uv >> 32) & 0xFFFFFFFFu));
                        asmbuf_putc(&buf, '\n');
                    } else {
                        /* Truncate to 32-bit for pushl immediate.
                         * I->val is long long; pushl only accepts 32-bit.
                         * Cast to int then back to long long for asmbuf_int. */
                        int v32;
                        v32 = (int)I->val;
                        asmbuf_puts(&buf, "    pushl $");
                        asmbuf_int(&buf, (long long)v32);
                        asmbuf_putc(&buf, '\n');
                    }
                    break;
                }
                case IR_PUSH_STR:
                    asmbuf_puts(&buf, "    leal ark_str_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ", %eax\n    pushl %eax\n");
                    break;
                case IR_PUSH_VAR: {
                    /* aux low byte = size (0=default 4, 1=char, 2=short, 8=long long/double).
                     * bit8 (0x100) = unsigned. bit16 (0x10000) = volatile. */
                    int vsz = I->aux & 0xFF;
                    if (vsz >= 8) {
                        /* 64-bit variable: push low then high (high on top).
                         * This matches IR_64BINARY/IR_STORE/IR_STORE_IDX which
                         * all expect HIGH word on top of stack. */
                        asmbuf_puts(&buf, "    pushl -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp)\n    pushl -");
                        asmbuf_int(&buf, 8 + local_size - (I->val + 4));
                        asmbuf_puts(&buf, "(%ebp)\n");
                    } else if (vsz == 1) {
                        asmbuf_puts(&buf, "    movzbl -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp), %eax\n    pushl %eax\n");
                    } else if (vsz == 2) {
                        asmbuf_puts(&buf, "    movzwl -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp), %eax\n    pushl %eax\n");
                    } else {
                        asmbuf_puts(&buf, "    pushl -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp)\n");
                    }
                    break;
                }
                case IR_PUSH_ADDR:
                    asmbuf_puts(&buf, "    leal -");
                    asmbuf_int(&buf, 8 + local_size - I->val);
                    asmbuf_puts(&buf, "(%ebp), %eax\n    pushl %eax\n");
                    break;
                case IR_PUSH_GLOBAL:
                    asmbuf_puts(&buf, "    movl ");
                    emit_sym(&buf, I->name);
                    asmbuf_puts(&buf, ", %eax\n    pushl %eax\n");
                    break;
                case IR_STORE_GLOBAL:
                    asmbuf_puts(&buf, "    popl %eax\n    movl %eax, ");
                    emit_sym(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_PUSH_GLOBAL_ADDR:
                    asmbuf_puts(&buf, "    movl $");
                    emit_sym(&buf, I->name);
                    asmbuf_puts(&buf, ", %eax\n    pushl %eax\n");
                    break;
                case IR_STORE: {
                    /* aux low byte = store size (0=default 4, 1=char, 2=short,
                     * 4=int, 8=long long/double, 16=complex).
                     * bit16 (0x10000) = volatile (ignored here, handled by not
                     * optimizing away the store). */
                    int ssz = I->aux & 0xFF;
                    if (ssz >= 8) {
                        /* 64-bit store: pop high, pop low, store both */
                        asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n");
                        asmbuf_puts(&buf, "    movl %eax, -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp)\n    movl %edx, -");
                        asmbuf_int(&buf, 8 + local_size - (I->val + 4));
                        asmbuf_puts(&buf, "(%ebp)\n");
                    } else if (ssz == 1) {
                        asmbuf_puts(&buf, "    popl %eax\n    movb %al, -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp)\n");
                    } else if (ssz == 2) {
                        asmbuf_puts(&buf, "    popl %eax\n    movw %ax, -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp)\n");
                    } else {
                        asmbuf_puts(&buf, "    popl %eax\n    movl %eax, -");
                        asmbuf_int(&buf, 8 + local_size - I->val);
                        asmbuf_puts(&buf, "(%ebp)\n");
                    }
                    break;
                }
                case IR_POP:
                    asmbuf_puts(&buf, "    addl $4, %esp\n");
                    break;
                case IR_DUP:
                    asmbuf_puts(&buf, "    popl %eax\n    pushl %eax\n    pushl %eax\n");
                    break;
                case IR_SWAP:
                    asmbuf_puts(&buf, "    popl %eax\n    popl %ecx\n    pushl %eax\n    pushl %ecx\n");
                    break;
                case IR_SEXT:
                    /* Pop int (32-bit), sign-extend to long long in cdecl order:
                     *   [ESP]=low (int), [ESP+4]=high (sign-extended).
                     * Internal stack had int at top; pop it, push high then push int. */
                    asmbuf_puts(&buf, "    popl %eax\n    movl %eax, %edx\n    sarl $31, %edx\n    pushl %edx\n    pushl %eax\n");
                    break;
                case IR_ZEXT:
                    /* Pop int (32-bit), zero-extend to long long in cdecl order:
                     *   [ESP]=low (int), [ESP+4]=0. */
                    asmbuf_puts(&buf, "    popl %eax\n    pushl $0\n    pushl %eax\n");
                    break;
                case IR_CDECL64:
                    /* Convert long long from internal model (high on top) to cdecl
                     * order (low on top): swap two 4-byte words. Same as IR_SWAP. */
                    asmbuf_puts(&buf, "    popl %eax\n    popl %ecx\n    pushl %eax\n    pushl %ecx\n");
                    break;
                case IR_LABEL:
                    asmbuf_puts(&buf, ".L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ":\n");
                    break;
                case IR_JMP:
                    asmbuf_puts(&buf, "    jmp .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JZ:
                    asmbuf_puts(&buf, "    popl %eax\n    cmpl $0, %eax\n    je .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JNZ:
                    asmbuf_puts(&buf, "    popl %eax\n    cmpl $0, %eax\n    jne .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_BINARY: {
                    const char *op = binop_x(I->aux);
                    if (op) {
                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    ");
                        asmbuf_puts(&buf, op);
                        asmbuf_puts(&buf, " %ecx, %eax\n    pushl %eax\n");
                    } else {
                        const char *shop = shiftop_x(I->aux);
                        if (shop) {
                            asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    ");
                            asmbuf_puts(&buf, shop);
                            asmbuf_puts(&buf, " %cl, %eax\n    pushl %eax\n");
                        } else {
                            int is_unsigned = 0;
                            switch (I->aux) {
                                case (int)TOK_EQ:
                                    asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    sete %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    break;
                                case (int)TOK_NE:
                                    asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setne %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    break;
                                case (int)TOK_LT:
                                    if (is_unsigned)
                                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setb %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    else
                                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setl %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    break;
                                case (int)TOK_LE:
                                    if (is_unsigned)
                                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setbe %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    else
                                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setle %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    break;
                                case (int)TOK_GT:
                                    if (is_unsigned)
                                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    seta %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    else
                                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setg %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    break;
                                case (int)TOK_GE:
                                    if (is_unsigned)
                                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setae %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    else
                                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cmpl %ecx, %eax\n    setge %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    break;
                                case (int)TOK_AND:
                                    asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    testl %ecx, %ecx\n    setne %cl\n    testl %eax, %eax\n    setne %al\n    andb %cl, %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    break;
                                case (int)TOK_OR:
                                    asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    testl %ecx, %ecx\n    setne %cl\n    testl %eax, %eax\n    setne %al\n    orb %cl, %al\n    movzbl %al, %eax\n    pushl %eax\n");
                                    break;
                                case (int)TOK_MUL:
                                    asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    imull %ecx, %eax\n    pushl %eax\n");
                                    break;
                                case (int)TOK_DIV:
                                    asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cdq\n    idivl %ecx\n    pushl %eax\n");
                                    break;
                                case (int)TOK_MOD:
                                    asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cdq\n    idivl %ecx\n    pushl %edx\n");
                                    break;
                            }
                        }
                    }
                    break;
                }
                case IR_UNARY: {
                    /* Pop operand, apply unary op, push result.
                     * I->val: 0=32-bit int, 1=float (x87), 2=64-bit int (2 slots).
                     * TOK_MINUS = arithmetic negation
                     * TOK_BNOT  = bitwise NOT (one's complement)
                     * TOK_NOT   = logical NOT (returns 0 or 1) */
                    int is_64 = (I->val == 2);
                    int is_flt = (I->val == 1);
                    switch (I->aux) {
                        case (int)TOK_MINUS:
                            if (is_64) {
                                /* 64-bit negation: -v = ~v + 1.
                                 * Stack model: [low, high] with high on top.
                                 * negl %eax gives ~L+1 with CF=1 if L!=0.
                                 * adcl $0,%edx then negl %edx gives -H-CF. */
                                asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n    negl %eax\n    adcl $0, %edx\n    negl %edx\n    pushl %eax\n    pushl %edx\n");
                            } else if (is_flt) {
                                /* float/double: load to st0, fchs, store back.
                                 * Treat as 4-byte float by default; if 8-byte
                                 * double is needed, irgen must signal it
                                 * (currently not done — float unary is rare). */
                                asmbuf_puts(&buf, "    flds (%esp)\n    fchs\n    fstps (%esp)\n");
                            } else {
                                asmbuf_puts(&buf, "    popl %eax\n    negl %eax\n    pushl %eax\n");
                            }
                            break;
                        case (int)TOK_BNOT:
                            if (is_64) {
                                asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n    notl %eax\n    notl %edx\n    pushl %eax\n    pushl %edx\n");
                            } else {
                                asmbuf_puts(&buf, "    popl %eax\n    notl %eax\n    pushl %eax\n");
                            }
                            break;
                        case (int)TOK_NOT:
                            if (is_64) {
                                /* logical NOT of 64-bit: result is 32-bit 0/1. */
                                asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n    orl %edx, %eax\n    cmpl $0, %eax\n    sete %al\n    movzbl %al, %eax\n    pushl %eax\n");
                            } else {
                                asmbuf_puts(&buf, "    popl %eax\n    cmpl $0, %eax\n    sete %al\n    movzbl %al, %eax\n    pushl %eax\n");
                            }
                            break;
                        default:
                            asmbuf_puts(&buf, "    # unknown unary aux\n");
                            break;
                    }
                    break;
                }
                case IR_LOAD_IDX: {
                    /* Pop index (ecx), pop base (eax). Compute base + index*es,
                     * load value, push result. For 8-byte, push low then high. */
                    int es = I->val;
                    asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n");
                    if (es > 1) {
                        asmbuf_puts(&buf, "    imull $");
                        asmbuf_int(&buf, es);
                        asmbuf_puts(&buf, ", %ecx\n    addl %ecx, %eax\n");
                    }
                    if (es == 1)
                        asmbuf_puts(&buf, "    movsbl (%eax), %eax\n    pushl %eax\n");
                    else if (es == 2)
                        asmbuf_puts(&buf, "    movswl (%eax), %eax\n    pushl %eax\n");
                    else if (es == 8) {
                        /* 8-byte: push low word first, then high word (high on top).
                         * Matches IR_64BINARY/IR_STORE which expect HIGH on top. */
                        asmbuf_puts(&buf, "    movl (%eax), %ecx\n    movl 4(%eax), %edx\n    pushl %ecx\n    pushl %edx\n");
                    } else
                        asmbuf_puts(&buf, "    movl (%eax), %eax\n    pushl %eax\n");
                    break;
                }
                case IR_DIV:
                    if (I->aux) {
                        /* unsigned */
                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    xorl %edx, %edx\n    divl %ecx\n    pushl %eax\n");
                    } else {
                        /* signed */
                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cdq\n    idivl %ecx\n    pushl %eax\n");
                    }
                    break;
                case IR_MOD:
                    if (I->aux) {
                        /* unsigned */
                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    xorl %edx, %edx\n    divl %ecx\n    pushl %edx\n");
                    } else {
                        /* signed */
                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n    cdq\n    idivl %ecx\n    pushl %edx\n");
                    }
                    break;
                case IR_STORE_IDX: {
                    /* Pop value, then address. Store value to address.
                     * For 8-byte: stack is [addr, val_low, val_high]. */
                    int es = I->val;
                    if (es == 8) {
                        asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n    popl %ecx\n");
                        asmbuf_puts(&buf, "    movl %eax, (%ecx)\n    movl %edx, 4(%ecx)\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %edx\n");
                    } else {
                        asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n");
                        if (es == 1)
                            asmbuf_puts(&buf, "    movb %dl, (%eax)\n");
                        else if (es == 2)
                            asmbuf_puts(&buf, "    movw %dx, (%eax)\n");
                        else
                            asmbuf_puts(&buf, "    movl %edx, (%eax)\n");
                        asmbuf_puts(&buf, "    pushl %edx\n");
                    }
                    break;
                }
                case IR_CALL: {
                    int n = I->val;
                    int is_indirect = (I->name && I->name[0] == '?');
                    int real_args = is_indirect ? n - 1 : n;
                    int argmask = I->aux;
                    /* cdecl: args already on stack in correct order (arg0 on top).
                     * Indirect call: function pointer was pushed last (on top).
                     * Pop it into eax, then call through eax. */
                    if (is_indirect) {
                        asmbuf_puts(&buf, "    popl %eax\n    call *%eax\n");
                    } else {
                        asmbuf_puts(&buf, "    call ");
                        emit_sym(&buf, I->name);
                        asmbuf_putc(&buf, '\n');
                    }
                    if (real_args > 0) {
                        /* Compute cleanup size: 8 bytes per long long arg,
                         * 4 bytes per regular arg. argmask bit(2*i+1)=1 means
                         * arg i is long long (occupies 2 stack slots). */
                        int cleanup = 0;
                        int i;
                        for (i = 0; i < real_args; i++) {
                            if (argmask & (1 << (2 * i + 1)))
                                cleanup += 8;
                            else
                                cleanup += 4;
                        }
                        asmbuf_puts(&buf, "    addl $");
                        asmbuf_int(&buf, cleanup);
                        asmbuf_puts(&buf, ", %esp\n");
                    }
                    asmbuf_puts(&buf, "    pushl %eax\n");
                    break;
                }
                case IR_RETURN:
                    asmbuf_puts(&buf, "    popl %eax\n    movl %ebp, %esp\n    popl %ebp\n    ret\n");
                    break;
                case IR_LOCAL_ALLOC:
                    break;
                case IR_ARG:
                    break;
                case IR_ALLOCA:
                    asmbuf_puts(&buf, "    popl %eax\n    addl $15, %eax\n    andl $-16, %eax\n    subl %eax, %esp\n    movl %esp, %eax\n    pushl %eax\n");
                    break;
                case IR_MEMCPY: {
                    int sz = I->val;
                    asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n");
                    if (sz > 0) {
                        int off = 0;
                        while (off + 4 <= sz) {
                            asmbuf_puts(&buf, "    movl ");
                            asmbuf_int(&buf, off);
                            asmbuf_puts(&buf, "(%eax), %edx\n    movl %edx, ");
                            asmbuf_int(&buf, off);
                            asmbuf_puts(&buf, "(%ecx)\n");
                            off += 4;
                        }
                        while (off < sz) {
                            asmbuf_puts(&buf, "    movb ");
                            asmbuf_int(&buf, off);
                            asmbuf_puts(&buf, "(%eax), %dl\n    movb %dl, ");
                            asmbuf_int(&buf, off);
                            asmbuf_puts(&buf, "(%ecx)\n");
                            off += 1;
                        }
                    }
                    asmbuf_puts(&buf, "    pushl %eax\n");
                    break;
                }
                case IR_PUSH_FLOAT: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    int is_complex = (I->aux & 0x400) != 0;
                    if (is_complex) {
                        /* _Complex: push real and imaginary parts */
                        asmbuf_puts(&buf, "    movl .L_dbl_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ", %eax\n    pushl %eax\n");
                        asmbuf_puts(&buf, "    movl .L_dbl_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "+4, %eax\n    pushl %eax\n");
                        asmbuf_puts(&buf, "    movl .L_dbl_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "+8, %eax\n    pushl %eax\n");
                        asmbuf_puts(&buf, "    movl .L_dbl_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "+12, %eax\n    pushl %eax\n");
                    } else if (is_dbl) {
                        asmbuf_puts(&buf, "    movl .L_dbl_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ", %eax\n    pushl %eax\n");
                        asmbuf_puts(&buf, "    movl .L_dbl_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "+4, %eax\n    pushl %eax\n");
                    } else {
                        /* float: 4 bytes (1 stack slot), like int.
                         * Not 8 bytes — floats and ints both occupy 1 slot. */
                        asmbuf_puts(&buf, "    movl .L_flt_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, ", %eax\n    pushl %eax\n");
                    }
                    break;
                }
                case IR_FADD:
                case IR_FSUB:
                case IR_FMUL:
                case IR_FDIV: {
                    /* Float/double binary op via x87 FPU.
                     * Stack (float):    [lhs(4), rhs(4)]  -> [result(4)]
                     * Stack (double):   [lhs_lo,lhs_hi,rhs_lo,rhs_hi] (hi on top)
                     *                   -> [result_lo, result_hi] (hi on top)
                     * x87 fldl/fstpl/faddl etc. expect little-endian (low at
                     * lower address) — swap before fldl/fstpl.
                     * aux 0x200 = double. Low bits = operator (TOK_PLUS etc). */
                    int is_dbl = (I->aux & 0x200) != 0;
                    const char *op_s = 0;
                    switch (I->op) {
                        case IR_FADD: op_s = is_dbl ? "faddl" : "fadds"; break;
                        case IR_FSUB: op_s = is_dbl ? "fsubl" : "fsubs"; break;
                        case IR_FMUL: op_s = is_dbl ? "fmull" : "fmuls"; break;
                        case IR_FDIV: op_s = is_dbl ? "fdivl" : "fdivs"; break;
                        default: break;
                    }
                    if (is_dbl) {
                        /* Swap rhs (on top) to little-endian in place. */
                        asmbuf_puts(&buf, "    movl (%esp), %eax\n    movl 4(%esp), %ecx\n    movl %ecx, (%esp)\n    movl %eax, 4(%esp)\n");
                        /* Swap lhs to little-endian in place. */
                        asmbuf_puts(&buf, "    movl 8(%esp), %eax\n    movl 12(%esp), %ecx\n    movl %ecx, 8(%esp)\n    movl %eax, 12(%esp)\n");
                        /* st0 = lhs; st0 = st0 OP rhs. */
                        asmbuf_puts(&buf, "    fldl 8(%esp)\n    ");
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " (%esp)\n");
                        /* Pop rhs (8 bytes); store result over lhs. */
                        asmbuf_puts(&buf, "    addl $8, %esp\n    fstpl (%esp)\n");
                        /* Swap result to high-on-top model. */
                        asmbuf_puts(&buf, "    popl %eax\n    popl %ecx\n    pushl %eax\n    pushl %ecx\n");
                    } else {
                        /* float: st0 = lhs (esp+4), st0 OP rhs (esp+0). */
                        asmbuf_puts(&buf, "    flds 4(%esp)\n    ");
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " (%esp)\n    addl $4, %esp\n    fstps (%esp)\n");
                    }
                    break;
                }
                case IR_FCMP: {
                    /* Float/double compare via x87. Result is 32-bit 0/1.
                     * Stack (float):  [lhs(4), rhs(4)]  -> [int(4)]
                     * Stack (double): [lhs_lo,lhs_hi,rhs_lo,rhs_hi] -> [int(4)]
                     * fcomps/fcompl sets C0/C2/C3; fstsw+sahf move to EFLAGS.
                     * IMPORTANT: setX must come BEFORE addl (which clobbers
                     * flags). Use leal for stack cleanup if needed after setX.
                     *   st0 == mem: ZF=1,CF=0  st0 > mem: ZF=0,CF=0
                     *   st0 < mem: ZF=0,CF=1   unordered: ZF=1,PF=1,CF=1 */
                    int is_dbl = (I->aux & 0x200) != 0;
                    int op = I->aux & ~0x200;
                    const char *set_op = "sete";
                    switch (op) {
                        case (int)TOK_EQ: set_op = "sete"; break;
                        case (int)TOK_NE: set_op = "setne"; break;
                        case (int)TOK_LT: set_op = "setb"; break;
                        case (int)TOK_GT: set_op = "seta"; break;
                        case (int)TOK_LE: set_op = "setbe"; break;
                        case (int)TOK_GE: set_op = "setae"; break;
                        default: break;
                    }
                    if (is_dbl) {
                        asmbuf_puts(&buf, "    movl (%esp), %eax\n    movl 4(%esp), %ecx\n    movl %ecx, (%esp)\n    movl %eax, 4(%esp)\n");
                        asmbuf_puts(&buf, "    movl 8(%esp), %eax\n    movl 12(%esp), %ecx\n    movl %ecx, 8(%esp)\n    movl %eax, 12(%esp)\n");
                        asmbuf_puts(&buf, "    fldl 8(%esp)\n    fcompl (%esp)\n");
                        asmbuf_puts(&buf, "    fstsw %ax\n    sahf\n");
                        /* setX BEFORE leal (which preserves flags) */
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, set_op);
                        asmbuf_puts(&buf, " %al\n    leal 16(%esp), %esp\n    movzbl %al, %eax\n    pushl %eax\n");
                    } else {
                        asmbuf_puts(&buf, "    flds 4(%esp)\n    fcomps (%esp)\n");
                        asmbuf_puts(&buf, "    fstsw %ax\n    sahf\n");
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, set_op);
                        asmbuf_puts(&buf, " %al\n    leal 8(%esp), %esp\n    movzbl %al, %eax\n    pushl %eax\n");
                    }
                    break;
                }
                case IR_F2I: {
                    /* float/double -> int (4 bytes).
                     *   float  = 4 bytes (1 slot), like int. Net: 0 bytes.
                     *   double = 8 bytes (2 slots, high on top). Net: -4 bytes.
                     * Internal stack model has HIGH on top for doubles, but
                     * x87 fldl expects little-endian memory order (low at
                     * lower address) — swap before fldl. */
                    int is_dbl = (I->aux & 0x200) != 0;
                    if (is_dbl) {
                        asmbuf_puts(&buf, "    popl %eax\n    popl %ecx\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %ecx\n");
                        asmbuf_puts(&buf, "    fldl (%esp)\n");
                        asmbuf_puts(&buf, "    addl $8, %esp\n");
                        asmbuf_puts(&buf, "    subl $4, %esp\n");
                        asmbuf_puts(&buf, "    fistpl (%esp)\n");
                    } else {
                        asmbuf_puts(&buf, "    flds (%esp)\n");
                        asmbuf_puts(&buf, "    fistpl (%esp)\n");
                    }
                    break;
                }
                case IR_I2F: {
                    /* int (4 bytes) -> float/double.
                     *   float  = 4 bytes (1 slot). Net: 0 bytes.
                     *   double = 8 bytes (2 slots, high on top). Net: +4 bytes.
                     * Use x87 FPU: fildl to load int, fstps/fstpl to store. */
                    int is_dbl = (I->aux & 0x200) != 0;
                    if (is_dbl) {
                        /* int -> double: pop int, make 8 bytes, fildl, fstpl.
                         * Result: [low, high] with high on top. */
                        asmbuf_puts(&buf, "    popl %eax\n");
                        asmbuf_puts(&buf, "    subl $8, %esp\n");
                        asmbuf_puts(&buf, "    movl %eax, (%esp)\n");
                        asmbuf_puts(&buf, "    fildl (%esp)\n");
                        asmbuf_puts(&buf, "    fstpl (%esp)\n");
                        /* Swap to internal model: high on top */
                        asmbuf_puts(&buf, "    popl %eax\n    popl %ecx\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %ecx\n");
                    } else {
                        /* int -> float: in-place fildl + fstps (4 bytes) */
                        asmbuf_puts(&buf, "    fildl (%esp)\n");
                        asmbuf_puts(&buf, "    fstps (%esp)\n");
                    }
                    break;
                }
                case IR_F2F: {
                    /* float <-> float cast.
                     *   float  = 4 bytes (1 slot)
                     *   double = 8 bytes (2 slots, high on top)
                     * Internal stack model has HIGH on top for doubles, but
                     * x87 fldl expects little-endian memory order (low at lower
                     * address) — swap before fldl.
                     *   double->float (aux=0x200): swap, fldl, pop 8, push 4. Net: -4.
                     *   float ->double (aux=0x100): flds, pop 4, push 8 (swap to high-on-top). Net: +4. */
                    int src_dbl = (I->aux & 0x200) != 0;
                    int dst_dbl = (I->aux & 0x100) != 0;
                    if (src_dbl && !dst_dbl) {
                        /* double -> float. Stack: [low, high] (high on top).
                         * Swap to [high, low] (low on top) for fldl, then
                         * pop 8 bytes and push 4 bytes. */
                        asmbuf_puts(&buf, "    popl %eax\n    popl %ecx\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %ecx\n");
                        asmbuf_puts(&buf, "    fldl (%esp)\n");
                        asmbuf_puts(&buf, "    addl $8, %esp\n");
                        asmbuf_puts(&buf, "    subl $4, %esp\n");
                        asmbuf_puts(&buf, "    fstps (%esp)\n");
                    } else if (!src_dbl && dst_dbl) {
                        /* float -> double. Stack: [float_bits] (4 bytes).
                         * Load float, pop 4, push 8 (in high-on-top order).
                         * fstpl stores little-endian: [low, high] (low at
                         * lower address, high at higher). Internal model wants
                         * high on top, so push high first then low. */
                        asmbuf_puts(&buf, "    flds (%esp)\n");
                        asmbuf_puts(&buf, "    addl $4, %esp\n");
                        asmbuf_puts(&buf, "    subl $8, %esp\n");
                        asmbuf_puts(&buf, "    fstpl (%esp)\n");
                        /* Reorder: stack is [low, high] (low at esp+0,
                         * high at esp+4). Internal model wants [low, high]
                         * with high on top (high at esp+0). Swap them. */
                        asmbuf_puts(&buf, "    popl %eax\n    popl %ecx\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %ecx\n");
                    }
                    /* same-size: no-op (should not occur, irgen filters) */
                    break;
                }
                case IR_64PUSH:
                    asmbuf_puts(&buf, "    pushl $0\n    pushl $");
                    asmbuf_int(&buf, (int)(I->val >> 32));
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_64BINARY: {
                    /* 64-bit binary operation. Stack: [a_lo, a_hi, b_lo, b_hi]
                     * Result: [res_lo, res_hi] (hi on top).
                     * For DIV/MOD, call libgcc runtime (__udivdi3 etc.) via cdecl.
                     * For ADD/SUB/BAND/BOR/BXOR, inline with carry/borrow.
                     * For MUL, call __muldi3.
                     * aux bit 0x100 = unsigned. */
                    int op = I->aux & 0xFF;
                    int is_unsigned = (I->aux & 0x100) != 0;
                    /* NOTE: ebx/esi/edi are callee-saved on cdecl (i686-mingw32)
                     * and are NOT saved in our prologue. We must only use
                     * eax/ecx/edx (caller-saved scratch) here.
                     * Stack layout: [a_lo, a_hi, b_lo, b_hi] (b_hi on top).
                     * Strategy for ADD/SUB/AND/OR/XOR: pop b into ecx:eax,
                     * operate on a in-place via (%esp)/4(%esp), then pop result. */
                    if (op == (int)TOK_PLUS) {
                        asmbuf_puts(&buf, "    popl %ecx\n");   /* b_hi */
                        asmbuf_puts(&buf, "    popl %eax\n");   /* b_lo */
                        asmbuf_puts(&buf, "    addl %eax, 4(%esp)\n");  /* a_lo += b_lo */
                        asmbuf_puts(&buf, "    adcl %ecx, (%esp)\n");    /* a_hi += b_hi + C */
                        asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %edx\n");
                    } else if (op == (int)TOK_MINUS) {
                        asmbuf_puts(&buf, "    popl %ecx\n");   /* b_hi */
                        asmbuf_puts(&buf, "    popl %eax\n");   /* b_lo */
                        asmbuf_puts(&buf, "    subl %eax, 4(%esp)\n");  /* a_lo -= b_lo */
                        asmbuf_puts(&buf, "    sbbl %ecx, (%esp)\n");    /* a_hi -= b_hi - B */
                        asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %edx\n");
                    } else if (op == (int)TOK_BAND) {
                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n");
                        asmbuf_puts(&buf, "    andl %eax, 4(%esp)\n    andl %ecx, (%esp)\n");
                        asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %edx\n");
                    } else if (op == (int)TOK_BOR) {
                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n");
                        asmbuf_puts(&buf, "    orl %eax, 4(%esp)\n    orl %ecx, (%esp)\n");
                        asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %edx\n");
                    } else if (op == (int)TOK_BXOR) {
                        asmbuf_puts(&buf, "    popl %ecx\n    popl %eax\n");
                        asmbuf_puts(&buf, "    xorl %eax, 4(%esp)\n    xorl %ecx, (%esp)\n");
                        asmbuf_puts(&buf, "    popl %edx\n    popl %eax\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %edx\n");
                    } else if (op == (int)TOK_MUL || op == (int)TOK_DIV || op == (int)TOK_MOD) {
                        /* Call libgcc 64-bit runtime via cdecl.
                         * Stack: [a_lo, a_hi, b_lo, b_hi] (b_hi on top at esp+0).
                         * cdecl needs a at lowest address: [a_lo, a_hi, b_lo, b_hi]
                         * with a_lo on top (pushed last). Swap pairs using only
                         * eax/edx (caller-saved): swap [esp+0]<->[esp+12] and
                         * [esp+4]<->[esp+8]. All reads happen before writes per pair. */
                        const char *fname = "__muldi3";
                        if (op == (int)TOK_DIV) fname = is_unsigned ? "__udivdi3" : "__divdi3";
                        if (op == (int)TOK_MOD) fname = is_unsigned ? "__umoddi3" : "__moddi3";
                        asmbuf_puts(&buf, "    movl 0(%esp), %eax\n");   /* eax = b_hi */
                        asmbuf_puts(&buf, "    movl 12(%esp), %edx\n");  /* edx = a_lo */
                        asmbuf_puts(&buf, "    movl %edx, 0(%esp)\n");  /* [esp+0] = a_lo */
                        asmbuf_puts(&buf, "    movl %eax, 12(%esp)\n");  /* [esp+12] = b_hi */
                        asmbuf_puts(&buf, "    movl 4(%esp), %eax\n");   /* eax = b_lo */
                        asmbuf_puts(&buf, "    movl 8(%esp), %edx\n");   /* edx = a_hi */
                        asmbuf_puts(&buf, "    movl %edx, 4(%esp)\n");   /* [esp+4] = a_hi */
                        asmbuf_puts(&buf, "    movl %eax, 8(%esp)\n");   /* [esp+8] = b_lo */
                        asmbuf_puts(&buf, "    call ");
                        emit_sym(&buf, fname);
                        asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, "    addl $16, %esp\n");
                        asmbuf_puts(&buf, "    pushl %eax\n    pushl %edx\n");
                    } else {
                        asmbuf_puts(&buf, "    # 64BINARY unsupported op\n");
                        /* Pop 8 bytes (b), leave a as result */
                        asmbuf_puts(&buf, "    addl $8, %esp\n");
                    }
                    break;
                }
                case IR_64CMP: {
                    /* 64-bit comparison. Stack: [a_lo, a_hi, b_lo, b_hi]
                     * Result: 4-byte int (1 or 0) on stack.
                     * Compare high words first; only check low if highs equal.
                     * Uses only eax/ecx/edx (caller-saved). a_lo stays on stack
                     * at (%esp) until we clean it up before pushing the result.
                     * Labels are unique per (function, instruction index). */
                    int op = I->aux & 0xFF;
                    int is_unsigned = (I->aux & 0x100) != 0;
                    asmbuf_puts(&buf, "    popl %ecx\n");   /* b_hi */
                    asmbuf_puts(&buf, "    popl %eax\n");   /* b_lo */
                    asmbuf_puts(&buf, "    popl %edx\n");   /* a_hi */
                    /* Stack: [a_lo] at (%esp) */
                    if (op == (int)TOK_EQ || op == (int)TOK_NE) {
                        /* EQ: differ -> 0; match -> 1. NE: differ -> 1; match -> 0.
                         * Both use "jne" (jump if differ). EQ jumps to "f"(alse),
                         * NE jumps to "t"(rue). Fall-through is the match case. */
                        const char *tgt = (op == (int)TOK_EQ) ? "f" : "t";
                        int match_val  = (op == (int)TOK_EQ) ? 1 : 0;
                        int differ_val = (op == (int)TOK_EQ) ? 0 : 1;
                        asmbuf_puts(&buf, "    cmpl %ecx, %edx\n    jne .L64");
                        asmbuf_puts(&buf, tgt); asmbuf_putc(&buf, '_'); asmbuf_puts(&buf, f->name);
                        asmbuf_putc(&buf, '_'); asmbuf_int(&buf, i); asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, "    cmpl %eax, (%esp)\n    jne .L64");
                        asmbuf_puts(&buf, tgt); asmbuf_putc(&buf, '_'); asmbuf_puts(&buf, f->name);
                        asmbuf_putc(&buf, '_'); asmbuf_int(&buf, i); asmbuf_putc(&buf, '\n');
                        /* Match: fall through */
                        asmbuf_puts(&buf, "    addl $4, %esp\n    pushl $");
                        asmbuf_int(&buf, match_val); asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, "    jmp .L64e_"); asmbuf_puts(&buf, f->name);
                        asmbuf_putc(&buf, '_'); asmbuf_int(&buf, i); asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, ".L64"); asmbuf_puts(&buf, tgt); asmbuf_putc(&buf, '_');
                        asmbuf_puts(&buf, f->name); asmbuf_putc(&buf, '_'); asmbuf_int(&buf, i);
                        asmbuf_puts(&buf, ":\n    addl $4, %esp\n    pushl $");
                        asmbuf_int(&buf, differ_val); asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, ".L64e_"); asmbuf_puts(&buf, f->name); asmbuf_putc(&buf, '_');
                        asmbuf_int(&buf, i); asmbuf_puts(&buf, ":\n");
                    } else {
                        /* LT/GT/LE/GE: compare high words, then low if equal.
                         * cmpl src, dst computes dst - src (AT&T). */
                        const char *jhi_t, *jhi_f, *jlo_t;
                        int eq_true = 0;
                        switch (op) {
                            case (int)TOK_LT:
                                jhi_t = is_unsigned ? "jb"  : "jl";
                                jhi_f = is_unsigned ? "ja"  : "jg";
                                jlo_t = is_unsigned ? "jb"  : "jl";
                                break;
                            case (int)TOK_GT:
                                jhi_t = is_unsigned ? "ja"  : "jg";
                                jhi_f = is_unsigned ? "jb"  : "jl";
                                jlo_t = is_unsigned ? "ja"  : "jg";
                                break;
                            case (int)TOK_LE:
                                jhi_t = is_unsigned ? "jb"  : "jl";
                                jhi_f = is_unsigned ? "ja"  : "jg";
                                jlo_t = is_unsigned ? "jbe" : "jle";
                                eq_true = 1;
                                break;
                            case (int)TOK_GE:
                                jhi_t = is_unsigned ? "ja"  : "jg";
                                jhi_f = is_unsigned ? "jb"  : "jl";
                                jlo_t = is_unsigned ? "jae" : "jge";
                                eq_true = 1;
                                break;
                            default:
                                jhi_t = jhi_f = jlo_t = "jmp";
                                break;
                        }
                        /* a_hi vs b_hi: cmpl %ecx, %edx = edx - ecx = a_hi - b_hi */
                        asmbuf_puts(&buf, "    cmpl %ecx, %edx\n    ");
                        asmbuf_puts(&buf, jhi_t); asmbuf_puts(&buf, " .L64t_");
                        asmbuf_puts(&buf, f->name); asmbuf_putc(&buf, '_'); asmbuf_int(&buf, i); asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, jhi_f); asmbuf_puts(&buf, " .L64f_");
                        asmbuf_puts(&buf, f->name); asmbuf_putc(&buf, '_'); asmbuf_int(&buf, i); asmbuf_putc(&buf, '\n');
                        /* a_lo vs b_lo: cmpl %eax, (%esp) = (%esp) - %eax = a_lo - b_lo */
                        asmbuf_puts(&buf, "    cmpl %eax, (%esp)\n    ");
                        asmbuf_puts(&buf, jlo_t); asmbuf_puts(&buf, " .L64t_");
                        asmbuf_puts(&buf, f->name); asmbuf_putc(&buf, '_'); asmbuf_int(&buf, i); asmbuf_putc(&buf, '\n');
                        if (eq_true) {
                            asmbuf_puts(&buf, "    je .L64t_"); asmbuf_puts(&buf, f->name);
                            asmbuf_putc(&buf, '_'); asmbuf_int(&buf, i); asmbuf_putc(&buf, '\n');
                        }
                        asmbuf_puts(&buf, ".L64f_"); asmbuf_puts(&buf, f->name); asmbuf_putc(&buf, '_');
                        asmbuf_int(&buf, i); asmbuf_puts(&buf, ":\n    addl $4, %esp\n    pushl $0\n    jmp .L64e_");
                        asmbuf_puts(&buf, f->name); asmbuf_putc(&buf, '_'); asmbuf_int(&buf, i); asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, ".L64t_"); asmbuf_puts(&buf, f->name); asmbuf_putc(&buf, '_');
                        asmbuf_int(&buf, i); asmbuf_puts(&buf, ":\n    addl $4, %esp\n    pushl $1\n");
                        asmbuf_puts(&buf, ".L64e_"); asmbuf_puts(&buf, f->name); asmbuf_putc(&buf, '_');
                        asmbuf_int(&buf, i); asmbuf_puts(&buf, ":\n");
                    }
                    break;
                }
                case IR_64F2I: {
                    /* double (8 bytes) -> int (4 bytes).
                     * fldl loads 8-byte double to st0, then adjust stack and fistpl. */
                    asmbuf_puts(&buf, "    fldl (%esp)\n");
                    asmbuf_puts(&buf, "    addl $8, %esp\n");
                    asmbuf_puts(&buf, "    subl $4, %esp\n");
                    asmbuf_puts(&buf, "    fistpl (%esp)\n");
                    break;
                }
                case IR_64I2F: {
                    /* long long (8 bytes) -> double (8 bytes).
                     * fildll loads 8-byte int to st0, fstpl stores as double. */
                    asmbuf_puts(&buf, "    fildll (%esp)\n");
                    asmbuf_puts(&buf, "    fstpl (%esp)\n");
                    break;
                }
                case IR_STORE_FLD:
                case IR_LOAD_FLD:
                    asmbuf_puts(&buf, "    # bitfield op (placeholder)\n");
                    break;
                case IR_ASM:
                    if (I->name) {
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, '\n');
                    }
                    break;
                case IR_SVC:
                case IR_SMC:
                case IR_SIMD_ADD16:
                case IR_SIMD_SUB16:
                case IR_SIMD_ADD8:
                case IR_SIMD_SUB8:
                    asmbuf_puts(&buf, "    # ARM-specific op - not applicable on x86\n");
                    break;
                case IR_NOP:
                    break;
                case IR_LABEL_NAMED:
                    asmbuf_puts(&buf, ".L_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, ":\n");
                    break;
                case IR_JMP_NAMED:
                    asmbuf_puts(&buf, "    jmp .L_");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_CMP_JMP_EQ:
                    asmbuf_puts(&buf, "    popl %eax\n    cmpl $");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, ", %eax\n    je .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->aux);
                    asmbuf_putc(&buf, '\n');
                    break;
                default:
                    asmbuf_puts(&buf, "    # unknown IR op\n");
                    break;
            }
        }
        asmbuf_puts(&buf, "    xorl %eax, %eax\n    movl %ebp, %esp\n    popl %ebp\n    ret\n\n");
    }

    /* Floating-point constant pool: emit both single-precision (.L_flt_<i>)
     * and double-precision (.L_dbl_<i>) bit patterns for each float in
     * prog->floats[]. The high bit 0x200 of IR_PUSH_FLOAT aux selects which
     * to load. Stored uniformly as double; single is truncated via (float). */
    if (prog->float_count > 0) {
        int i;
        const char *hd = "0123456789abcdef";
        asmbuf_puts(&buf, "    .section .rdata,\"dr\"\n");
        for (i = 0; i < prog->float_count; i++) {
            union { float f; unsigned int u; } u;
            union { double d; unsigned int u[2]; } du;
            unsigned int bits;
            char hex[9];
            int k;
            /* Single-precision: 4 bytes */
            u.f = (float)prog->floats[i];
            bits = u.u;
            for (k = 7; k >= 0; k--) { hex[k] = hd[bits & 0xF]; bits >>= 4; }
            hex[8] = 0;
            asmbuf_puts(&buf, ".L_flt_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, ":\n    .long 0x");
            asmbuf_puts(&buf, hex);
            asmbuf_putc(&buf, '\n');
            /* Double-precision: 8 bytes, little-endian (low word first) */
            du.d = prog->floats[i];
            asmbuf_puts(&buf, ".L_dbl_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, ":\n    .long 0x");
            {
                unsigned int lo = du.u[0];
                char hex2[9]; int k2;
                for (k2 = 7; k2 >= 0; k2--) { hex2[k2] = hd[lo & 0xF]; lo >>= 4; }
                hex2[8] = 0;
                asmbuf_puts(&buf, hex2);
            }
            asmbuf_puts(&buf, "\n    .long 0x");
            {
                unsigned int hi = du.u[1];
                char hex2[9]; int k2;
                for (k2 = 7; k2 >= 0; k2--) { hex2[k2] = hd[hi & 0xF]; hi >>= 4; }
                hex2[8] = 0;
                asmbuf_puts(&buf, hex2);
            }
            asmbuf_putc(&buf, '\n');
        }
        asmbuf_puts(&buf, "    .text\n");
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
    "i386-pc-mingw32-cdecl",
    4,
    x86_emit,
    x86_assemble,
    x86_link
};

const ArkBackend *ark_backend_x86_64(void) {
    return &g_x86_backend;
}
