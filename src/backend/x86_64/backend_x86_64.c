/* Ark C Compiler - x86 32-bit (cdecl ABI) backend
 *
 * Emits GAS-syntax x86 32-bit assembly. The goal of this backend is "syntactically
 * correct, human-readable, and can be further assembled by GNU as", so the
 * assemble stage is a stub (passes through text).
 *
 * Calling convention: cdecl — all arguments are passed on the stack (right to
 * left), caller cleans up. Uses a push/pop virtual operand stack (identical
 * to the IR); integers are treated as 4-byte. Local variables and parameters
 * are accessed via negative offsets from %ebp.
 *
 * Note: the file is named backend_x86_64.c for Makefile compatibility but
 * targets i386. The backend is registered under the name "x86".
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "common.h"
#include "ir.h"

/* cdecl has no integer-class argument registers; all args are on the stack. */
static const char *arg_reg(int i, int abi) {
    (void)i; (void)abi;
    return 0;
}

static int arg_reg_count(int abi) {
    (void)abi;
    return 0;
}

/* Byte offset (from ebp) of the (reg_idx)-th stack argument.
 * cdecl: stack args begin at [ebp+8] (above saved ebp + return addr),
 * each 4 bytes wide. */
static int stack_arg_offset(int reg_idx, int abi) {
    (void)abi;
    return 8 + reg_idx * 4;
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

/* === Bug-X5: aggregate initializer parser ===============================
 * Parses the init_aggregate string (C initializer syntax produced by
 * irgen's serialize_init) against the global's type tree, placing each
 * scalar value at its correct byte offset, then emits .byte/.word/.long/
 * .quad directives instead of the old ".quad 0" placeholder.
 *
 * Handles:
 *   - flat/nested brace lists for arrays and structs/unions
 *   - designators [idx]= and .field=
 *   - scalar constant expressions: decimal/hex numbers, -x, ~x, (a op b)
 *   - string literals (for char arrays)
 *   - identifiers (function/enum names) emitted as symbol relocations
 * Gaps are zero-filled. */

typedef struct {
    int offset;
    int size;
    const char *name;
    int namelen;
} AggSymRef;

typedef struct {
    const char *p;
    const char *end;
    AggSymRef refs[32];
    int ref_count;
    int error;
} AggParser;

static int agg_is_ident_start(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_';
}
static int agg_is_ident(char c) {
    return agg_is_ident_start(c) || (c >= '0' && c <= '9');
}

static void agg_skip_ws(AggParser *a) {
    while (a->p < a->end && (*a->p==' '||*a->p=='\t'||*a->p=='\n'||*a->p=='\r')) a->p++;
}

static long long agg_parse_expr(AggParser *a);

static long long agg_parse_primary(AggParser *a) {
    agg_skip_ws(a);
    if (a->p >= a->end) { a->error = 1; return 0; }
    char c = *a->p;
    if (c == '(') {
        a->p++;
        { long long v = agg_parse_expr(a);
          agg_skip_ws(a);
          if (a->p < a->end && *a->p == ')') a->p++;
          return v; }
    }
    if (c >= '0' && c <= '9') {
        long long v = 0;
        if (c == '0' && a->p + 1 < a->end && (a->p[1]=='x'||a->p[1]=='X')) {
            a->p += 2;
            while (a->p < a->end) {
                char d = *a->p; int dv;
                if (d>='0'&&d<='9') dv = d-'0';
                else if (d>='a'&&d<='f') dv = d-'a'+10;
                else if (d>='A'&&d<='F') dv = d-'A'+10;
                else break;
                v = v*16 + dv; a->p++;
            }
        } else {
            while (a->p < a->end && *a->p>='0' && *a->p<='9') {
                v = v*10 + (*a->p - '0'); a->p++;
            }
        }
        while (a->p < a->end && (*a->p=='u'||*a->p=='U'||*a->p=='l'||*a->p=='L')) a->p++;
        return v;
    }
    /* identifier in expression context: cannot evaluate -> 0 */
    if (agg_is_ident_start(c)) {
        while (a->p < a->end && agg_is_ident(*a->p)) a->p++;
        return 0;
    }
    a->error = 1;
    return 0;
}

static long long agg_parse_unary(AggParser *a) {
    agg_skip_ws(a);
    if (a->p >= a->end) { a->error = 1; return 0; }
    char c = *a->p;
    if (c == '-') { a->p++; return -agg_parse_unary(a); }
    if (c == '+') { a->p++; return agg_parse_unary(a); }
    if (c == '~') { a->p++; return ~agg_parse_unary(a); }
    if (c == '!') { a->p++; return !agg_parse_unary(a); }
    return agg_parse_primary(a);
}

static long long agg_parse_mul(AggParser *a) {
    long long l = agg_parse_unary(a);
    for (;;) {
        agg_skip_ws(a);
        if (a->p >= a->end) break;
        char c = *a->p;
        if (c == '*') { a->p++; l *= agg_parse_unary(a); }
        else if (c == '/') { a->p++; { long long r=agg_parse_unary(a); l = r? l/r : 0; } }
        else if (c == '%') { a->p++; { long long r=agg_parse_unary(a); l = r? l%r : 0; } }
        else break;
    }
    return l;
}

static long long agg_parse_add(AggParser *a) {
    long long l = agg_parse_mul(a);
    for (;;) {
        agg_skip_ws(a);
        if (a->p >= a->end) break;
        char c = *a->p;
        if (c == '+') { a->p++; l += agg_parse_mul(a); }
        else if (c == '-') { a->p++; l -= agg_parse_mul(a); }
        else break;
    }
    return l;
}

static long long agg_parse_shift(AggParser *a) {
    long long l = agg_parse_add(a);
    for (;;) {
        agg_skip_ws(a);
        if (a->p + 1 >= a->end) break;
        if (a->p[0]=='<' && a->p[1]=='<') { a->p += 2; { long long r=agg_parse_add(a); l <<= (r & 63); } }
        else if (a->p[0]=='>' && a->p[1]=='>') { a->p += 2; { long long r=agg_parse_add(a); l = (r>=64)? 0 : l>>r; } }
        else break;
    }
    return l;
}

static long long agg_parse_expr(AggParser *a) {
    long long l = agg_parse_shift(a);
    for (;;) {
        agg_skip_ws(a);
        if (a->p >= a->end) break;
        char c = *a->p;
        if (c == '&') { a->p++; l &= agg_parse_shift(a); }
        else if (c == '|') { a->p++; l |= agg_parse_shift(a); }
        else if (c == '^') { a->p++; l ^= agg_parse_shift(a); }
        else break;
    }
    return l;
}

static void agg_put_val(unsigned char *buf, int bufsz, int off, int sz, long long v) {
    int i;
    if (off < 0 || off + sz > bufsz) return;
    for (i = 0; i < sz; i++)
        buf[off + i] = (unsigned char)((v >> (8 * i)) & 0xFF);
}

/* Skip one initializer value (scalar, braced group, or string). */
static void agg_skip_value(AggParser *a) {
    agg_skip_ws(a);
    if (a->p >= a->end) return;
    if (*a->p == '{') {
        int depth = 0;
        while (a->p < a->end) {
            char c = *a->p;
            if (c == '{') depth++;
            else if (c == '}') { depth--; a->p++; if (depth == 0) return; }
            else if (c == '"') { a->p++; while (a->p<a->end && *a->p!='"'){ if(*a->p=='\\'&&a->p+1<a->end)a->p+=2; else a->p++; } if(a->p<a->end)a->p++; continue; }
            a->p++;
        }
    } else if (*a->p == '"') {
        a->p++;
        while (a->p < a->end && *a->p != '"') {
            if (*a->p=='\\' && a->p+1<a->end) a->p += 2; else a->p++;
        }
        if (a->p < a->end) a->p++;
    } else {
        int depth = 0;
        while (a->p < a->end) {
            char c = *a->p;
            if (c == '(') depth++;
            else if (c == ')') { if (depth > 0) depth--; }
            else if (c == '"') { a->p++; while(a->p<a->end && *a->p!='"'){ if(*a->p=='\\'&&a->p+1<a->end)a->p+=2; else a->p++; } if(a->p<a->end)a->p++; continue; }
            else if (depth == 0 && (c == ',' || c == '}')) break;
            a->p++;
        }
    }
}

/* Parse a scalar value at byte offset `off` (size `sz`). Bare identifiers
 * become symbol relocations; everything else is evaluated as a constant. */
static void agg_parse_scalar(AggParser *a, unsigned char *buf, int bufsz,
                             int off, int sz) {
    agg_skip_ws(a);
    if (a->p >= a->end) { a->error = 1; return; }
    if (agg_is_ident_start(*a->p)) {
        const char *start = a->p;
        while (a->p < a->end && agg_is_ident(*a->p)) a->p++;
        agg_skip_ws(a);
        if (a->p < a->end && *a->p == '(') {
            /* function-like expression: evaluate as 0 (cannot fold here) */
            agg_put_val(buf, bufsz, off, sz, 0);
            return;
        }
        if (a->ref_count < 32) {
            a->refs[a->ref_count].offset = off;
            a->refs[a->ref_count].size = sz;
            a->refs[a->ref_count].name = start;
            a->refs[a->ref_count].namelen = (int)(a->p - start);
            a->ref_count++;
        }
        return;
    }
    { long long v = agg_parse_expr(a);
      agg_put_val(buf, bufsz, off, sz, v); }
}

/* Recursively parse an initializer for type t, writing values into buf at
 * base offset `off`. */
static void agg_parse_type(AggParser *a, Type *t, unsigned char *buf,
                           int bufsz, int off) {
    agg_skip_ws(a);
    if (a->p >= a->end) return;
    if (*a->p == '{') {
        a->p++;
        if (t && t->kind == TYPE_ARRAY) {
            int elem_sz = type_size(t->base);
            int max = t->size;
            int idx = 0;
            if (elem_sz <= 0) elem_sz = 1;
            for (;;) {
                agg_skip_ws(a);
                if (a->p >= a->end || *a->p == '}') { if (a->p < a->end) a->p++; break; }
                if (*a->p == ',') { a->p++; continue; }
                if (*a->p == '[') {
                    a->p++;
                    { long long di = agg_parse_expr(a); idx = (int)di; }
                    agg_skip_ws(a);
                    if (a->p < a->end && *a->p == ']') a->p++;
                    if (a->p < a->end && *a->p == '=') a->p++;
                }
                if (idx < max) agg_parse_type(a, t->base, buf, bufsz, off + idx * elem_sz);
                idx++;
            }
        } else if (t && (t->kind == TYPE_STRUCT || t->kind == TYPE_UNION)) {
            StructField *f = t->fields;
            for (;;) {
                agg_skip_ws(a);
                if (a->p >= a->end || *a->p == '}') { if (a->p < a->end) a->p++; break; }
                if (*a->p == ',') { a->p++; continue; }
                if (*a->p == '.') {
                    char fname[64]; int fn = 0;
                    a->p++;
                    while (a->p < a->end && agg_is_ident(*a->p) && fn < 63) fname[fn++] = *a->p++;
                    fname[fn] = 0;
                    agg_skip_ws(a);
                    if (a->p < a->end && *a->p == '=') a->p++;
                    f = type_find_field(t, fname);
                }
                if (f) {
                    agg_parse_type(a, f->type, buf, bufsz, off + f->offset);
                    if (t->kind != TYPE_UNION) f = f->next;
                } else {
                    agg_skip_value(a);
                }
            }
        } else {
            /* scalar wrapped in braces: unwrap */
            agg_parse_type(a, t, buf, bufsz, off);
            agg_skip_ws(a);
            if (a->p < a->end && *a->p == '}') a->p++;
        }
        return;
    }
    if (*a->p == '"') {
        /* string literal for char/wide array */
        int elem_sz = (t && t->kind == TYPE_ARRAY && t->base) ? type_size(t->base) : 1;
        int max_n = (t && t->kind == TYPE_ARRAY) ? t->size : 0;
        int idx = 0;
        a->p++;
        while (a->p < a->end && *a->p != '"') {
            char c;
            if (*a->p == '\\' && a->p + 1 < a->end) {
                a->p++;
                switch (*a->p) {
                    case 'n': c = '\n'; break;
                    case 't': c = '\t'; break;
                    case 'r': c = '\r'; break;
                    case '0': c = '\0'; break;
                    case '\\': c = '\\'; break;
                    case '\'': c = '\''; break;
                    case '"': c = '"'; break;
                    case 'x': {
                        int hv = 0;
                        a->p++;
                        while (a->p < a->end) {
                            char d = *a->p; int dv;
                            if (d>='0'&&d<='9') dv = d-'0';
                            else if (d>='a'&&d<='f') dv = d-'a'+10;
                            else if (d>='A'&&d<='F') dv = d-'A'+10;
                            else break;
                            hv = hv*16 + dv; a->p++;
                        }
                        c = (char)hv;
                        a->p++;
                        goto put_char;
                    }
                    default: c = *a->p; break;
                }
                a->p++;
            } else {
                c = *a->p++;
            }
        put_char:
            if (max_n <= 0 || idx < max_n)
                agg_put_val(buf, bufsz, off + idx * elem_sz, elem_sz, (unsigned char)c);
            idx++;
        }
        if (a->p < a->end && *a->p == '"') a->p++;
        return;
    }
    /* scalar */
    { int sz = type_size(t);
      if (sz <= 0) sz = 4;
      agg_parse_scalar(a, buf, bufsz, off, sz); }
}

/* Emit a parsed aggregate initializer. Falls back to zero-fill on failure. */
static void emit_aggregate_init(AsmBuffer *out, Type *t, const char *init_str) {
    int sz = type_size(t);
    int off, i;
    unsigned char *bufmem;
    AggParser a;
    if (sz <= 0) sz = 4;
    bufmem = (unsigned char *)mem_pool_alloc(sz);
    for (i = 0; i < sz; i++) bufmem[i] = 0;
    a.p = init_str;
    a.end = init_str + ark_strlen(init_str);
    a.ref_count = 0;
    a.error = 0;
    agg_parse_type(&a, t, bufmem, sz, 0);

    off = 0;
    while (off < sz) {
        int ri, found = -1, chunk;
        const char *dir;
        for (ri = 0; ri < a.ref_count; ri++) {
            if (a.refs[ri].offset == off) { found = ri; break; }
        }
        if (found >= 0) {
            chunk = a.refs[found].size; if (chunk <= 0) chunk = 4;
            dir = (chunk <= 1) ? ".byte" : (chunk <= 2 ? ".word" : (chunk <= 4 ? ".long" : ".quad"));
            asmbuf_puts(out, "    ");
            asmbuf_puts(out, dir);
            asmbuf_puts(out, " ");
            for (i = 0; i < a.refs[found].namelen; i++)
                asmbuf_putc(out, a.refs[found].name[i]);
            asmbuf_putc(out, '\n');
            a.refs[found].offset = -1;  /* mark consumed */
        } else {
            if ((off % 8) == 0 && off + 8 <= sz) chunk = 8;
            else if ((off % 4) == 0 && off + 4 <= sz) chunk = 4;
            else if ((off % 2) == 0 && off + 2 <= sz) chunk = 2;
            else chunk = 1;
            dir = (chunk <= 1) ? ".byte" : (chunk <= 2 ? ".word" : (chunk <= 4 ? ".long" : ".quad"));
            { long long v = 0;
              for (i = 0; i < chunk; i++) v |= ((long long)bufmem[off + i]) << (8 * i);
              asmbuf_puts(out, "    ");
              asmbuf_puts(out, dir);
              asmbuf_puts(out, " ");
              asmbuf_int(out, v);
              asmbuf_putc(out, '\n'); }
        }
        off += chunk;
    }
}

static int x86_emit_internal(IrProgram *prog, char *out, int cap, int abi) {
    AsmBuffer buf;
    int fi;
    (void)abi;  /* cdecl only; abi is always ARK_ABI_SYSV (0) */
    asmbuf_init(&buf);

    asmbuf_puts(&buf, "# Ark C Compiler - generated x86 32-bit (cdecl) assembly\n");
    asmbuf_puts(&buf, "    .intel_syntax noprefix\n");
    asmbuf_puts(&buf, "    .section .rodata\n");
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
                /* Float/double global: emit raw bits.
                 * float (4 bytes) -> .long; double (8 bytes) -> .quad */
                int tsz = g->type ? type_size(g->type) : 8;
                if (tsz <= 4) {
                    union { float f; int i; } u;
                    u.f = (float)g->init_float;
                    asmbuf_puts(&buf, "    .long ");
                    asmbuf_int(&buf, u.i);
                    asmbuf_putc(&buf, '\n');
                } else {
                    union { double d; long long i; } u;
                    u.d = g->init_float;
                    asmbuf_puts(&buf, "    .quad ");
                    asmbuf_int(&buf, u.i);
                    asmbuf_putc(&buf, '\n');
                }
            } else if (g->init_aggregate && g->has_init) {
                Type *gt = g->type ? g->type : 0;
                if (gt) {
                    emit_aggregate_init(&buf, gt, g->init_aggregate);
                } else {
                    int sz = 4, k;
                    for (k = 0; k < sz; k++)
                        asmbuf_puts(&buf, "    .long 0\n");
                }
            } else {
                /* Scalar init: choose directive by type size. */
                int tsz = g->type ? type_size(g->type) : 4;
                const char *dir = ".long";
                if (tsz <= 1) dir = ".byte";
                else if (tsz <= 2) dir = ".word";
                else if (tsz <= 4) dir = ".long";
                else dir = ".quad";
                asmbuf_puts(&buf, "    ");
                asmbuf_puts(&buf, dir);
                asmbuf_puts(&buf, " ");
                asmbuf_int(&buf, g->has_init ? g->init_int : 0);
                asmbuf_putc(&buf, '\n');
                if (tsz > 8) {
                    int emitted = 8;
                    while (emitted < tsz) {
                        int chunk = (tsz - emitted >= 8) ? 8 : (tsz - emitted);
                        const char *pdir = ".quad";
                        if (chunk <= 1) pdir = ".byte";
                        else if (chunk <= 2) pdir = ".word";
                        else if (chunk <= 4) pdir = ".long";
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, pdir);
                        asmbuf_puts(&buf, " 0\n");
                        emitted += chunk;
                    }
                }
            }
        }
    }
    asmbuf_puts(&buf, "    .text\n");

    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        int i;
        int local_size = (f->local_size + 15) & ~15;
        if (local_size < 16) local_size = 16;
        /* sret detection: if the function returns a struct/union > 8 bytes,
         * cdecl passes a hidden first arg = return buffer pointer at [ebp+8]. */
        int sret_off = 0;
        if (f->ret_type &&
            (f->ret_type->kind == TYPE_STRUCT || f->ret_type->kind == TYPE_UNION) &&
            type_size(f->ret_type) > 8) {
            sret_off = local_size + 48 + 200;
        }

        asmbuf_puts(&buf, "    .globl ");
        asmbuf_puts(&buf, f->name);
        asmbuf_putc(&buf, '\n');
        asmbuf_puts(&buf, f->name);
        asmbuf_puts(&buf, ":\n");
        /* cdecl prologue: push ebp; mov ebp, esp; save callee-saved (ebx, esi,
         * edi); sub esp for locals + scratch. Locals at [ebp-48].
         * 3 pushes (12 bytes) + 36 padding = 48 byte gap before locals. */
        asmbuf_puts(&buf, "    push ebp\n");
        asmbuf_puts(&buf, "    mov ebp, esp\n");
        asmbuf_puts(&buf, "    push ebx\n    push esi\n    push edi\n");
        asmbuf_puts(&buf, "    sub esp, ");
        asmbuf_int(&buf, local_size + 300);
        asmbuf_putc(&buf, '\n');
        /* Save sret pointer if this function uses sret */
        if (sret_off) {
            asmbuf_puts(&buf, "    mov eax, [ebp+8]\n    mov [ebp-");
            asmbuf_int(&buf, sret_off);
            asmbuf_puts(&buf, "], eax\n");
        }

        /* cdecl: all args on stack at [ebp + 8 + idx * 4].
         * For sret functions, the hidden pointer is arg 0, so real args
         * start at index 1. param_idx tracks the original parameter index. */
        int arg_idx = sret_off ? 1 : 0;
        int param_idx = 0;
        for (i = 0; i < f->code_count; i++) {
            IrInst *I = &f->code[i];
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END:
                    break;
                case IR_GETARG: {
                    /* irgen encodes aux = (type_size << 8) | slot for regular
                     * params, and aux = k for variadic va_arg slots
                     * (val >= 8000). cdecl: all args on the stack. */
                    Type *pt = 0;
                    int reg_idx;
                    int max_int = arg_reg_count(abi);
                    if (I->val >= 8000) {
                        /* Bug-X4: variadic va_arg slot. aux is the raw integer
                         * arg index. All args on stack at [ebp + stack_arg_offset(k)]. */
                        reg_idx = I->aux & 0xFF;
                        if (reg_idx < max_int) {
                            /* cdecl: no register args, this branch is dead */
                            break;
                        } else {
                            int stk = stack_arg_offset(reg_idx, abi);
                            asmbuf_puts(&buf, "    mov eax, [ebp+");
                            asmbuf_int(&buf, stk);
                            asmbuf_puts(&buf, "]\n    mov [ebp-");
                            asmbuf_int(&buf, 48 + I->val);
                            asmbuf_puts(&buf, "], eax\n");
                        }
                        break;
                    }
                    /* Regular param: look up type */
                    if (f->param_types && param_idx < f->param_count)
                        pt = f->param_types[param_idx];
                    param_idx++;
                    /* cdecl: all params on stack, ignore float/int distinction */
                    reg_idx = arg_idx;
                    arg_idx++;
                    {
                        int stk = stack_arg_offset(reg_idx, abi);
                        asmbuf_puts(&buf, "    mov eax, [ebp+");
                        asmbuf_int(&buf, stk);
                        asmbuf_puts(&buf, "]\n    mov [ebp-");
                        asmbuf_int(&buf, 48 + I->val);
                        asmbuf_puts(&buf, "], eax\n");
                    }
                    break;
                }
                case IR_PUSH_INT:
                    asmbuf_puts(&buf, "    push ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_PUSH_STR:
                    asmbuf_puts(&buf, "    lea eax, [ark_str_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "]\n    push eax\n");
                    break;
                case IR_PUSH_VAR:
                    asmbuf_puts(&buf, "    push dword ptr [ebp-");
                    asmbuf_int(&buf, 48 + I->val);
                    asmbuf_puts(&buf, "]\n");
                    break;
                case IR_PUSH_ADDR:
                    asmbuf_puts(&buf, "    lea eax, [ebp-");
                    asmbuf_int(&buf, 48 + I->val);
                    asmbuf_puts(&buf, "]\n    push eax\n");
                    break;
                case IR_PUSH_GLOBAL:
                    /* Bug-X4: For variadic functions, _ark_va_ptr points to
                     * the variadic tail on the stack. */
                    if (f->is_variadic && I->name && ark_streq(I->name, "_ark_va_ptr")) {
                        asmbuf_puts(&buf, "    lea eax, [ebp+");
                        asmbuf_int(&buf, 8 + f->param_count * 4);
                        asmbuf_puts(&buf, "]\n    push eax\n");
                    } else {
                        asmbuf_puts(&buf, "    mov eax, [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "]\n    push eax\n");
                    }
                    break;
                case IR_STORE_GLOBAL:
                    asmbuf_puts(&buf, "    pop eax\n    mov [");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "], eax\n");
                    break;
                case IR_POP:
                    asmbuf_puts(&buf, "    add esp, 4\n");
                    break;
                case IR_DUP:
                    asmbuf_puts(&buf, "    mov eax, [esp]\n    push eax\n");
                    break;
                case IR_SWAP:
                    asmbuf_puts(&buf, "    pop eax\n    pop ecx\n    push eax\n    push ecx\n");
                    break;
                case IR_STORE:
                    asmbuf_puts(&buf, "    pop eax\n    mov [ebp-");
                    asmbuf_int(&buf, 48 + I->val);
                    asmbuf_puts(&buf, "], eax\n");
                    break;
                case IR_LOAD_IDX: {
                    /* Pop index (ecx), pop base (eax). Load element at
                     * base + index*es. I->val = element size (1/2/4/8).
                     * I->aux bit 0x1 = unsigned (use movzx vs movsx). */
                    int es = I->val;
                    int is_unsigned = (I->aux & 0x1) != 0;
                    asmbuf_puts(&buf, "    pop ecx\n    pop eax\n");
                    if (es > 1) {
                        asmbuf_puts(&buf, "    imul ecx, ");
                        asmbuf_int(&buf, es);
                        asmbuf_puts(&buf, "\n    add eax, ecx\n");
                    }
                    if (es == 1) {
                        if (is_unsigned)
                            asmbuf_puts(&buf, "    movzx eax, byte ptr [eax]\n");
                        else
                            asmbuf_puts(&buf, "    movsx eax, byte ptr [eax]\n");
                    } else if (es == 2) {
                        if (is_unsigned)
                            asmbuf_puts(&buf, "    movzx eax, word ptr [eax]\n");
                        else
                            asmbuf_puts(&buf, "    movsx eax, word ptr [eax]\n");
                    } else if (es == 8) {
                        /* 64-bit load: push low then high dword */
                        asmbuf_puts(&buf, "    mov edx, dword ptr [eax+4]\n");
                        asmbuf_puts(&buf, "    push edx\n");
                        asmbuf_puts(&buf, "    mov eax, dword ptr [eax]\n");
                        asmbuf_puts(&buf, "    push eax\n");
                        break;
                    } else {
                        /* 4-byte (default) */
                        if (is_unsigned)
                            asmbuf_puts(&buf, "    mov eax, dword ptr [eax]\n");
                        else
                            asmbuf_puts(&buf, "    movsx eax, dword ptr [eax]\n");
                    }
                    asmbuf_puts(&buf, "    push eax\n");
                    break;
                }
                case IR_STORE_IDX: {
                    /* Pop value (edx), pop address (eax). Store value.
                     * I->val = element size (1/2/4/8). */
                    int es = I->val;
                    if (es == 8) {
                        /* 64-bit store: pop low, pop high, store both */
                        asmbuf_puts(&buf, "    pop edx\n    pop ecx\n    pop eax\n");
                        asmbuf_puts(&buf, "    mov dword ptr [eax], edx\n");
                        asmbuf_puts(&buf, "    mov dword ptr [eax+4], ecx\n");
                        asmbuf_puts(&buf, "    push edx\n");
                    } else {
                        asmbuf_puts(&buf, "    pop edx\n    pop eax\n");
                        if (es == 1)
                            asmbuf_puts(&buf, "    mov byte ptr [eax], dl\n");
                        else if (es == 2)
                            asmbuf_puts(&buf, "    mov word ptr [eax], dx\n");
                        else
                            asmbuf_puts(&buf, "    mov dword ptr [eax], edx\n");
                        asmbuf_puts(&buf, "    push edx\n");
                    }
                    break;
                }
                case IR_BINARY: {
                    const char *op = binop_x(I->aux);
                    if (op) {
                        asmbuf_puts(&buf, "    pop ecx\n    pop eax\n    ");
                        asmbuf_puts(&buf, op);
                        asmbuf_puts(&buf, " eax, ecx\n    push eax\n");
                    } else if (I->aux == (int)TOK_MUL) {
                        asmbuf_puts(&buf, "    pop ecx\n    pop eax\n    imul eax, ecx\n    push eax\n");
                    } else if (I->aux == (int)TOK_DIV) {
                        asmbuf_puts(&buf, "    pop ecx\n    pop eax\n    cdq\n    idiv ecx\n    push eax\n");
                    } else if (I->aux == (int)TOK_MOD) {
                        asmbuf_puts(&buf, "    pop ecx\n    pop eax\n    cdq\n    idiv ecx\n    push edx\n");
                    } else if (I->aux == (int)TOK_SHL) {
                        asmbuf_puts(&buf, "    pop ecx\n    pop eax\n    shl eax, cl\n    push eax\n");
                    } else if (I->aux == (int)TOK_SHR) {
                        asmbuf_puts(&buf, "    pop ecx\n    pop eax\n    sar eax, cl\n    push eax\n");
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
                        asmbuf_puts(&buf, "    pop ecx\n    pop eax\n    cmp eax, ecx\n    ");
                        asmbuf_puts(&buf, cc);
                        asmbuf_puts(&buf, " al\n    movzx eax, al\n    push eax\n");
                    }
                    break;
                }
                case IR_UNARY:
                    asmbuf_puts(&buf, "    pop eax\n");
                    if (I->aux == (int)TOK_MINUS) asmbuf_puts(&buf, "    neg eax\n");
                    else if (I->aux == (int)TOK_BNOT) asmbuf_puts(&buf, "    not eax\n");
                    else if (I->aux == (int)TOK_NOT) asmbuf_puts(&buf, "    test eax, eax\n    sete al\n    movzx eax, al\n");
                    asmbuf_puts(&buf, "    push eax\n");
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
                    asmbuf_puts(&buf, "    pop eax\n    test eax, eax\n    jz .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_JNZ:
                    asmbuf_puts(&buf, "    pop eax\n    test eax, eax\n    jnz .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;
                case IR_CMP_JMP_EQ:
                    asmbuf_puts(&buf, "    mov eax, [esp]\n    cmp eax, ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    jne 1f\n    add esp, 4\n    jmp .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, "\n1:\n");
                    break;
                case IR_CALL: {
                    /* cdecl calling convention: all arguments passed on stack
                     * (right to left), caller cleans up via saved esp restore.
                     *   - Pop all args to scratch area
                     *   - Save esp
                     *   - Push args right-to-left from scratch
                     *   - Align to 16 bytes (for SSE)
                     *   - Call
                     *   - Restore esp (cleans up pushed args + alignment) */
                    int n = (int)I->val;
                    int argmask = I->aux;
                    int is_indirect = (I->name && I->name[0] == '?');
                    int k;
                    int stack_cnt = 0;
                    int scratch_base = 48 + local_size;
                    int is_void_ret = 0;
                    (void)argmask;  /* cdecl ignores float/int distinction for arg passing */

                    /* For indirect calls, the callee pointer was pushed last
                     * (arg n-1 on the virtual stack). Pop it into ecx
                     * (caller-saved scratch register). */
                    if (is_indirect) {
                        asmbuf_puts(&buf, "    pop ecx\n");
                        n = n - 1;
                    }

                    /* Pop args 0..n-1. Save each to scratch area (4-byte slots). */
                    for (k = 0; k < n; k++) {
                        asmbuf_puts(&buf, "    pop eax\n    mov [ebp-");
                        asmbuf_int(&buf, scratch_base + 16 + 4 * stack_cnt);
                        asmbuf_puts(&buf, "], eax\n");
                        stack_cnt++;
                    }

                    /* Save esp before stack adjustments. */
                    asmbuf_puts(&buf, "    mov [ebp-");
                    asmbuf_int(&buf, scratch_base);
                    asmbuf_puts(&buf, "], esp\n");

                    /* Push stack args in reverse order (right to left) so
                     * leftmost arg is at [esp] (lowest address). */
                    for (k = stack_cnt - 1; k >= 0; k--) {
                        asmbuf_puts(&buf, "    push dword ptr [ebp-");
                        asmbuf_int(&buf, scratch_base + 16 + 4 * k);
                        asmbuf_puts(&buf, "]\n");
                    }

                    /* Dynamic 16-byte alignment before call (for SSE). */
                    asmbuf_puts(&buf, "    and esp, -16\n");

                    /* For direct calls, check if the callee returns void.
                     * If so, skip the push of the return value. */
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

                    if (is_indirect) {
                        asmbuf_puts(&buf, "    call ecx\n");
                    } else {
                        asmbuf_puts(&buf, "    call ");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, '\n');
                    }

                    /* Restore esp from saved value (cleans up pushed args +
                     * alignment padding in one step). */
                    asmbuf_puts(&buf, "    mov esp, [ebp-");
                    asmbuf_int(&buf, scratch_base);
                    asmbuf_puts(&buf, "]\n");

                    if (!is_void_ret)
                        asmbuf_puts(&buf, "    push eax\n");
                    break;
                }
                case IR_RETURN:
                    if (sret_off) {
                        /* sret return: return the saved sret pointer in eax. */
                        asmbuf_puts(&buf, "    pop eax\n    mov eax, [ebp-");
                        asmbuf_int(&buf, sret_off);
                        asmbuf_puts(&buf, "]\n    lea esp, [ebp-12]\n    pop edi\n    pop esi\n    pop ebx\n    pop ebp\n    ret\n");
                    } else {
                        asmbuf_puts(&buf, "    pop eax\n    lea esp, [ebp-12]\n    pop edi\n    pop esi\n    pop ebx\n    pop ebp\n    ret\n");
                    }
                    break;
                /* === B1: Missing IR operations for completeness === */

                case IR_LOCAL_ALLOC:
                    break;
                case IR_ARG:
                    break;

                /* IR_PUSH_GLOBAL_ADDR: push &global (no dereference). */
                case IR_PUSH_GLOBAL_ADDR:
                    asmbuf_puts(&buf, "    lea eax, [");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "]\n    push eax\n");
                    break;

                /* IR_MEMCPY: pop dst, pop src, copy I->val bytes.
                 * Uses edi (dest), esi (src), ecx (count) — all saved in prologue. */
                case IR_MEMCPY:
                    asmbuf_puts(&buf, "    pop edi\n    pop esi\n    mov ecx, ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    rep movsb\n");
                    break;

                /* IR_ALLOCA: VLA dynamic stack alloc.
                 * Pop byte count, align to 16, subtract from esp, push base. */
                case IR_ALLOCA:
                    asmbuf_puts(&buf, "    pop eax\n    add eax, 15\n    and eax, -16\n");
                    asmbuf_puts(&buf, "    sub esp, eax\n    mov eax, esp\n    push eax\n");
                    break;

                /* IR_DIV / IR_MOD: integer division.
                 * aux=0 signed, aux=1 unsigned. */
                case IR_DIV:
                    asmbuf_puts(&buf, "    pop ecx\n    pop eax\n");
                    if (I->aux & 1)
                        asmbuf_puts(&buf, "    xor edx, edx\n    div ecx\n    push eax\n");
                    else
                        asmbuf_puts(&buf, "    cdq\n    idiv ecx\n    push eax\n");
                    break;
                case IR_MOD:
                    asmbuf_puts(&buf, "    pop ecx\n    pop eax\n");
                    if (I->aux & 1)
                        asmbuf_puts(&buf, "    xor edx, edx\n    div ecx\n    push edx\n");
                    else
                        asmbuf_puts(&buf, "    cdq\n    idiv ecx\n    push edx\n");
                    break;

                /* IR_PUSH_FLOAT: push a float/double constant.
                 * aux bit 0x200 = double.  val = index into prog->floats[].
                 * On x86-32, doubles are 8 bytes (pushed as two dwords). */
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
                            asmbuf_puts(&buf, "    mov eax, ");
                            asmbuf_int(&buf, (int)(ure.i & 0xFFFFFFFF));
                            asmbuf_puts(&buf, "\n    push eax\n");
                            asmbuf_puts(&buf, "    mov eax, ");
                            asmbuf_int(&buf, (int)((ure.i >> 32) & 0xFFFFFFFF));
                            asmbuf_puts(&buf, "\n    push eax\n");
                            asmbuf_puts(&buf, "    mov eax, ");
                            asmbuf_int(&buf, (int)(uim.i & 0xFFFFFFFF));
                            asmbuf_puts(&buf, "\n    push eax\n");
                            asmbuf_puts(&buf, "    mov eax, ");
                            asmbuf_int(&buf, (int)((uim.i >> 32) & 0xFFFFFFFF));
                            asmbuf_puts(&buf, "\n    push eax\n");
                        } else {
                            asmbuf_puts(&buf, "    push 0\n    push 0\n    push 0\n    push 0\n");
                        }
                    } else if (is_dbl) {
                        double v = (I->val >= 0 && I->val < prog->float_count) ?
                                   prog->floats[I->val] : 0.0;
                        union { double d; long long i; } u;
                        u.d = v;
                        asmbuf_puts(&buf, "    mov eax, ");
                        asmbuf_int(&buf, (int)((u.i >> 32) & 0xFFFFFFFF));
                        asmbuf_puts(&buf, "\n    push eax\n");
                        asmbuf_puts(&buf, "    mov eax, ");
                        asmbuf_int(&buf, (int)(u.i & 0xFFFFFFFF));
                        asmbuf_puts(&buf, "\n    push eax\n");
                    } else {
                        /* float: promote to double for uniform stack representation */
                        float fv = (float)((I->val >= 0 && I->val < prog->float_count) ?
                                   prog->floats[I->val] : 0.0);
                        double v = (double)fv;
                        union { double d; long long i; } u;
                        u.d = v;
                        asmbuf_puts(&buf, "    mov eax, ");
                        asmbuf_int(&buf, (int)((u.i >> 32) & 0xFFFFFFFF));
                        asmbuf_puts(&buf, "\n    push eax\n");
                        asmbuf_puts(&buf, "    mov eax, ");
                        asmbuf_int(&buf, (int)(u.i & 0xFFFFFFFF));
                        asmbuf_puts(&buf, "\n    push eax\n");
                    }
                    break;
                }

                /* IR_FADD/FSUB/FMUL/FDIV: floating-point arithmetic.
                 * Operands are doubles on the stack (8 bytes each = 2 dwords).
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
                        asmbuf_puts(&buf, "    movq xmm1, [esp]\n    add esp, 8\n");  /* imag b */
                        asmbuf_puts(&buf, "    movq xmm3, [esp]\n    add esp, 8\n");  /* real b */
                        asmbuf_puts(&buf, "    movq xmm2, [esp]\n    add esp, 8\n");  /* imag a */
                        asmbuf_puts(&buf, "    movq xmm0, [esp]\n    add esp, 8\n");  /* real a */
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " xmm0, xmm3\n    ");
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " xmm2, xmm1\n");
                        asmbuf_puts(&buf, "    sub esp, 8\n    movq [esp], xmm0\n");
                        asmbuf_puts(&buf, "    sub esp, 8\n    movq [esp], xmm2\n");
                    } else {
                        asmbuf_puts(&buf, "    movq xmm1, [esp]\n    add esp, 8\n");
                        asmbuf_puts(&buf, "    movq xmm0, [esp]\n    add esp, 8\n    ");
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " xmm0, xmm1\n    sub esp, 8\n    movq [esp], xmm0\n");
                    }
                    break;
                }

                /* IR_FCMP: compare two doubles, push 0 or 1. */
                case IR_FCMP: {
                    const char *cc = 0;
                    int is_complex = (I->aux & 0x400) != 0;
                    int cmp_op = I->aux & 0xFF;
                    if (is_complex) {
                        /* _Complex comparison: only == and != are meaningful */
                        asmbuf_puts(&buf, "    mov edx, [esp]\n    add esp, 4\n");  /* b imag hi */
                        asmbuf_puts(&buf, "    pop ecx\n");  /* b imag lo -> ecx */
                        asmbuf_puts(&buf, "    pop esi\n");  /* b real lo */
                        asmbuf_puts(&buf, "    pop edi\n");  /* b real hi */
                        asmbuf_puts(&buf, "    xor eax, eax\n    cmp edi, edx\n    sete al\n");
                        asmbuf_puts(&buf, "    mov ebx, eax\n    cmp esi, ecx\n    sete al\n");
                        asmbuf_puts(&buf, "    and eax, ebx\n");
                        if ((cmp_op & 0xF) == (int)TOK_NE) {
                            asmbuf_puts(&buf, "    xor eax, 1\n");
                        }
                        asmbuf_puts(&buf, "    movzx eax, al\n    push eax\n");
                    } else {
                        switch (cmp_op) {
                            case (int)TOK_EQ: cc = "sete";  break;
                            case (int)TOK_NE: cc = "setne"; break;
                            case (int)TOK_LT: cc = "setb";  break;
                            case (int)TOK_GT: cc = "seta";  break;
                            case (int)TOK_LE: cc = "setbe"; break;
                            case (int)TOK_GE: cc = "setae"; break;
                            default: cc = "sete"; break;
                        }
                        asmbuf_puts(&buf, "    movq xmm1, [esp]\n    add esp, 8\n");
                        asmbuf_puts(&buf, "    movq xmm0, [esp]\n    add esp, 8\n");
                        asmbuf_puts(&buf, "    ucomisd xmm0, xmm1\n    ");
                        asmbuf_puts(&buf, cc);
                        asmbuf_puts(&buf, " al\n    movzx eax, al\n    push eax\n");
                    }
                    break;
                }

                /* IR_F2I: double -> int (truncate toward zero) */
                case IR_F2I: {
                    asmbuf_puts(&buf, "    movq xmm0, [esp]\n    add esp, 8\n");
                    asmbuf_puts(&buf, "    cvttsd2si eax, xmm0\n    push eax\n");
                    break;
                }

                /* IR_I2F: int -> double */
                case IR_I2F: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    asmbuf_puts(&buf, "    pop eax\n    cvtsi2sd xmm0, eax\n");
                    if (!is_dbl) {
                        /* float: round to float precision then back to double */
                        asmbuf_puts(&buf, "    cvtsd2ss xmm0, xmm0\n    cvtss2sd xmm0, xmm0\n");
                    }
                    asmbuf_puts(&buf, "    sub esp, 8\n    movq [esp], xmm0\n");
                    break;
                }

                /* IR_64PUSH: push 64-bit immediate.
                 * val=high32, aux=low32. Pushed as two dwords (high then low). */
                case IR_64PUSH: {
                    long long v = ((long long)(int)I->val << 32) | (unsigned int)I->aux;
                    asmbuf_puts(&buf, "    mov eax, ");
                    asmbuf_int(&buf, (int)((v >> 32) & 0xFFFFFFFF));
                    asmbuf_puts(&buf, "\n    push eax\n");
                    asmbuf_puts(&buf, "    mov eax, ");
                    asmbuf_int(&buf, (int)(v & 0xFFFFFFFF));
                    asmbuf_puts(&buf, "\n    push eax\n");
                    break;
                }

                /* IR_64BINARY: 64-bit binary op. aux = TOK_xxx | (0x100 if unsigned).
                 * On x86-32, 64-bit ops work on two dword pairs on the stack. */
                case IR_64BINARY: {
                    int op = I->aux & 0xFF;
                    const char *bop = binop_x(op);
                    if (bop) {
                        /* add/sub/and/or/xor: operate on both dwords independently */
                        asmbuf_puts(&buf, "    pop ecx\n    pop ebx\n");  /* b (lo,hi) */
                        asmbuf_puts(&buf, "    pop eax\n    pop edx\n");  /* a (lo,hi) */
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, bop);
                        asmbuf_puts(&buf, " eax, ecx\n    ");
                        asmbuf_puts(&buf, bop);
                        asmbuf_puts(&buf, " edx, ebx\n");
                        asmbuf_puts(&buf, "    push edx\n    push eax\n");
                    } else if (op == (int)TOK_SHL) {
                        /* Simplified: shift count from low dword of b */
                        asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n");  /* shift count, skip hi */
                        asmbuf_puts(&buf, "    pop eax\n    pop edx\n");  /* a (lo,hi) */
                        asmbuf_puts(&buf, "    shld edx, eax, cl\n    shl eax, cl\n");
                        asmbuf_puts(&buf, "    push edx\n    push eax\n");
                    } else {
                        /* mul/div/mod/shr/comparisons: fall back to 32-bit behavior
                         * for syntactic validity. Full 64-bit would require a helper. */
                        const char *cc = 0;
                        switch (op) {
                            case (int)TOK_MUL:
                                asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    imul eax, ecx\n    push 0\n    push eax\n");
                                break;
                            case (int)TOK_DIV:
                                if (I->aux & 0x100)
                                    asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    xor edx, edx\n    div ecx\n    push 0\n    push eax\n");
                                else
                                    asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    cdq\n    idiv ecx\n    push edx\n    push eax\n");
                                break;
                            case (int)TOK_MOD:
                                if (I->aux & 0x100)
                                    asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    xor edx, edx\n    div ecx\n    push 0\n    push edx\n");
                                else
                                    asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    cdq\n    idiv ecx\n    push 0\n    push edx\n");
                                break;
                            case (int)TOK_SHR:
                                if (I->aux & 0x100)
                                    asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    shr eax, cl\n    push 0\n    push eax\n");
                                else
                                    asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    sar eax, cl\n    push edx\n    push eax\n");
                                break;
                            case (int)TOK_EQ: cc = "sete";  goto cmp64;
                            case (int)TOK_NE: cc = "setne"; goto cmp64;
                            case (int)TOK_LT: cc = (I->aux & 0x100) ? "setb" : "setl";  goto cmp64;
                            case (int)TOK_GT: cc = (I->aux & 0x100) ? "seta" : "setg";  goto cmp64;
                            case (int)TOK_LE: cc = (I->aux & 0x100) ? "setbe" : "setle"; goto cmp64;
                            case (int)TOK_GE: cc = (I->aux & 0x100) ? "setae" : "setge"; goto cmp64;
                            default: cc = "sete";  goto cmp64;
                        cmp64:
                            asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    cmp eax, ecx\n    ");
                            asmbuf_puts(&buf, cc);
                            asmbuf_puts(&buf, " al\n    movzx eax, al\n    push eax\n");
                            break;
                        }
                    }
                    break;
                }

                /* IR_64CMP: 64-bit compare. aux = TOK_xxx | (0x100 if unsigned). */
                case IR_64CMP: {
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
                    asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    add esp, 4\n    cmp eax, ecx\n    ");
                    asmbuf_puts(&buf, cc);
                    asmbuf_puts(&buf, " al\n    movzx eax, al\n    push eax\n");
                    break;
                }

                /* IR_64F2I / IR_64I2F: 64-bit float <-> 64-bit int.
                 * On x86-32 these operate on 8-byte stack slots. */
                case IR_64F2I:
                    asmbuf_puts(&buf, "    movq xmm0, [esp]\n    add esp, 8\n");
                    asmbuf_puts(&buf, "    cvttsd2si eax, xmm0\n    push 0\n    push eax\n");
                    break;
                case IR_64I2F:
                    asmbuf_puts(&buf, "    pop eax\n    add esp, 4\n    cvtsi2sd xmm0, eax\n");
                    asmbuf_puts(&buf, "    sub esp, 8\n    movq [esp], xmm0\n");
                    break;

                /* IR_STORE_FLD: bitfield store. val=bit_off, aux=bit_width. */
                case IR_STORE_FLD: {
                    int bit_off = I->val;
                    int bw = I->aux;
                    unsigned mask = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    asmbuf_puts(&buf, "    pop eax\n    pop ecx\n");  /* value, addr */
                    asmbuf_puts(&buf, "    mov edx, dword ptr [ecx]\n");
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
                    asmbuf_puts(&buf, "    mov dword ptr [ecx], eax\n    push eax\n");
                    break;
                }

                /* IR_LOAD_FLD: bitfield load. val=bit_off, aux=bit_width. */
                case IR_LOAD_FLD: {
                    int bit_off = I->val;
                    int bw = I->aux;
                    unsigned mask = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    asmbuf_puts(&buf, "    pop eax\n    mov eax, dword ptr [eax]\n");
                    if (bit_off > 0) {
                        asmbuf_puts(&buf, "    shr eax, ");
                        asmbuf_int(&buf, bit_off);
                        asmbuf_puts(&buf, "\n");
                    }
                    asmbuf_puts(&buf, "    and eax, ");
                    asmbuf_int(&buf, (int)mask);
                    asmbuf_puts(&buf, "\n    push eax\n");
                    break;
                }

                /* IR_ASM: inline assembly. Emit as-is. */
                case IR_ASM:
                    if (I->name) {
                        const char *s = I->name;
                        if (s[0] == '@') {
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

                /* IR_SVC / IR_SMC / IR_SIMD_*: ARM-specific, emit as comment */
                case IR_SVC:
                case IR_SMC:
                case IR_SIMD_ADD16:
                case IR_SIMD_SUB16:
                case IR_SIMD_ADD8:
                case IR_SIMD_SUB8:
                    asmbuf_puts(&buf, "    # ARM-specific op (");
                    asmbuf_puts(&buf, ir_op_name(I->op));
                    asmbuf_puts(&buf, ") - not applicable on x86\n");
                    break;

                default:
                    asmbuf_puts(&buf, "    # unknown IR op: ");
                    asmbuf_puts(&buf, ir_op_name(I->op));
                    asmbuf_puts(&buf, "\n");
                    break;
            }
        }
        /* Function-end epilogue (fallthrough return). For sret functions,
         * return the saved sret pointer in eax instead of 0. */
        if (sret_off) {
            asmbuf_puts(&buf, "    mov eax, [ebp-");
            asmbuf_int(&buf, sret_off);
            asmbuf_puts(&buf, "]\n    lea esp, [ebp-12]\n    pop edi\n    pop esi\n    pop ebx\n    pop ebp\n    ret\n\n");
        } else {
            asmbuf_puts(&buf, "    xor eax, eax\n    lea esp, [ebp-12]\n    pop edi\n    pop esi\n    pop ebx\n    pop ebp\n    ret\n\n");
        }
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

/* assemble and link are intentional pass-through stubs.
 * The emit_asm function produces GNU as-compatible (.intel_syntax noprefix)
 * assembly text. The user post-processes with external tools:
 *   arkcc -target x86 foo.c -o foo.s && gcc -m32 -c foo.s -o foo.o */
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

static int x86_emit_sysv(IrProgram *prog, char *out, int cap) {
    return x86_emit_internal(prog, out, cap, ARK_ABI_SYSV);
}

static const ArkBackend g_x86_backend = {
    "x86",
    "i386-pc-linux-cdecl",
    4,
    x86_emit_sysv,
    x86_assemble,
    x86_link,
    ARK_ABI_SYSV
};

const ArkBackend *ark_backend_x86_64(void) {
    return &g_x86_backend;
}

/* Stub retained for registry.c compatibility (MSVC variant removed).
 * Returns the main x86 backend; -target x86_64-msvc is no longer distinct. */
const ArkBackend *ark_backend_x86_64_msvc(void) {
    return &g_x86_backend;
}
