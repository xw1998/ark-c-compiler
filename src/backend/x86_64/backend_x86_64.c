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
 * This file also holds the real 64-bit backend ("x86_64", System V AMD64),
 * because the two share one built-in assembler.  amd64_emit_internal() keeps
 * the compiler's 4-byte stack-word model and layers the ABI on top of it:
 * pointer_size is 8 (so the type system lays out pointers/long/aggregates
 * correctly) while a pointer still occupies a single "word" whose machine
 * stack slot holds the whole 64-bit address (IR_AUX_SLOT64).  Integer
 * arguments go in rdi/rsi/rdx/rcx/r8/r9, floating ones in xmm0-xmm7, the rest
 * on the stack, and al carries the number of vector registers used.
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include "ir.h"
#include "diag.h"
/* On host, <stdlib.h> provides getenv() for the ARKCC_DUMP_SYMS symbol map
 * (see x86_assemble_mode); on STM32 getenv() does not exist. */
#if ARKCC_PROFILE != ARKCC_PROFILE_STM32_MIN
#  include <stdlib.h>
#endif

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

/* Set when the emitter produced text it knows is not assemblable. */
static int x86_emit_errors;

/* _Complex on this backend is limited to what a single expression needs:
 * a constant push, + - * /, and == / != .  Anything that has to move a whole
 * 16-byte object through a local, a global, an array element, a cast or a
 * copy used to be compiled as if it were a 4-byte scalar -- a silent wrong
 * answer that only showed up at run time.  Those paths are hard errors now:
 * x86_emit_errors makes the backend write no output at all. */
static void x86_complex_unsupported(AsmBuffer *b, const char *what) {
    ark_log("[x86] error: _Complex value not supported by the x86 backend (%s)\n", what);
    x86_emit_errors++;
    asmbuf_puts(b, "    # unsupported: _Complex ");
    asmbuf_puts(b, what);
    asmbuf_putc(b, '\n');
}

/* Size in bytes of a named global (0 when unknown). */
static int x86_global_size(IrProgram *prog, const char *name) {
    int i;
    if (!name) return 0;
    for (i = 0; i < prog->global_count; i++) {
        IrGlobal *g = prog->globals[i];
        if (g && g->name && ark_streq(g->name, name))
            return g->type ? type_size(g->type) : 0;
    }
    return 0;
}

/* Emit the read-only (string literal) and data (global object) sections.
 * Shared by the i386 and AMD64 emitters so the two cannot drift apart.
 * The emitted text is unchanged from when this lived inside
 * x86_emit_internal; only the buffer became a parameter. */
static void x86_emit_data_sections(AsmBuffer *buf, IrProgram *prog) {
    asmbuf_puts(buf, "    .section .rodata\n");
    {
        int i;
        for (i = 0; i < prog->string_count; i++) {
            IrString *s = prog->strings[i];
            asmbuf_puts(buf, "ark_str_");
            asmbuf_int(buf, s->id);
            asmbuf_puts(buf, ":\n    .asciz ");
            emit_str_literal_x(buf, s->data, s->len);
            asmbuf_putc(buf, '\n');
        }
    }
    asmbuf_puts(buf, "    .data\n");
    {
        int i;
        for (i = 0; i < prog->global_count; i++) {
            IrGlobal *g = prog->globals[i];
            if (g->is_extern) continue;  /* extern: no definition */
            /* Only non-static globals get external linkage. Emitting ".globl"
             * together with ".local" for the same symbol was contradictory (and
             * ".local" is rejected by the PE-targeted GNU as shipped with some
             * toolchains); a plain label is already local, so statics need no
             * directive at all. The ARM backend guards the same way. */
            if (!g->is_static) {
                asmbuf_puts(buf, "    .globl ");
                asmbuf_puts(buf, g->name);
                asmbuf_putc(buf, '\n');
            }
            asmbuf_puts(buf, g->name);
            asmbuf_puts(buf, ":\n");
            /* The x86_64 backend does not implement _Complex at all; a global
             * of that type must not quietly get its real part written as one
             * .quad and the imaginary half dropped. */
            if (g->type && ARK_IS_CX(g->type)) {
                x86_complex_unsupported(buf, "global object");
                asmbuf_puts(buf, "    .zero ");
                asmbuf_int(buf, g->type && type_size(g->type) > 0 ? type_size(g->type) : 16);
                asmbuf_putc(buf, '\n');
            } else if (g->is_float && g->has_init) {
                /* Float/double global: emit raw bits.
                 * float (4 bytes) -> .long; double (8 bytes) -> .quad */
                int tsz = g->type ? type_size(g->type) : 8;
                if (tsz <= 4) {
                    union { float f; int i; } u;
                    u.f = (float)g->init_float;
                    asmbuf_puts(buf, "    .long ");
                    asmbuf_int(buf, u.i);
                    asmbuf_putc(buf, '\n');
                } else {
                    union { double d; long long i; } u;
                    u.d = g->init_float;
                    asmbuf_puts(buf, "    .quad ");
                    asmbuf_int(buf, u.i);
                    asmbuf_putc(buf, '\n');
                }
            } else if (g->init_aggregate && g->has_init) {
                Type *gt = g->type ? g->type : 0;
                if (gt) {
                    emit_aggregate_init(buf, gt, g->init_aggregate);
                } else {
                    int sz = 4, k;
                    for (k = 0; k < sz; k++)
                        asmbuf_puts(buf, "    .long 0\n");
                }
            } else {
                /* Scalar init: choose directive by type size. */
                int tsz = g->type ? type_size(g->type) : 4;
                const char *dir = ".long";
                if (tsz <= 1) dir = ".byte";
                else if (tsz <= 2) dir = ".word";
                else if (tsz <= 4) dir = ".long";
                else dir = ".quad";
                asmbuf_puts(buf, "    ");
                asmbuf_puts(buf, dir);
                asmbuf_puts(buf, " ");
                asmbuf_int(buf, g->has_init ? g->init_int : 0);
                asmbuf_putc(buf, '\n');
                if (tsz > 8) {
                    int emitted = 8;
                    while (emitted < tsz) {
                        int chunk = (tsz - emitted >= 8) ? 8 : (tsz - emitted);
                        const char *pdir = ".quad";
                        if (chunk <= 1) pdir = ".byte";
                        else if (chunk <= 2) pdir = ".word";
                        else if (chunk <= 4) pdir = ".long";
                        asmbuf_puts(buf, "    ");
                        asmbuf_puts(buf, pdir);
                        asmbuf_puts(buf, " 0\n");
                        emitted += chunk;
                    }
                }
            }
        }
    }
}

static int x86_emit_internal(IrProgram *prog, char *out, int cap, int abi) {
    AsmBuffer buf;
    int fi;
    (void)abi;  /* cdecl only; abi is always ARK_ABI_SYSV (0) */
    asmbuf_init(&buf);

    asmbuf_puts(&buf, "# Ark C Compiler - generated x86 32-bit (cdecl) assembly\n");
    asmbuf_puts(&buf, "    .intel_syntax noprefix\n");
    x86_emit_data_sections(&buf, prog);
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

        /* Static functions must stay file-local; exporting them as strong
         * globals made two translation units with same-named statics collide. */
        if (!f->is_static) {
            asmbuf_puts(&buf, "    .globl ");
            asmbuf_puts(&buf, f->name);
            asmbuf_putc(&buf, '\n');
        }
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
                    if ((I->aux & 0xFF) == 16) {
                        x86_complex_unsupported(&buf, "local variable");
                        break;
                    }
                    /* _Complex float is 8 bytes but occupies two doubles on the
                     * IR stack; a single dword load would be a silently short
                     * value, so refuse it here as well. */
                    if ((I->aux & IR_AUX_COMPLEX) && (I->aux & 0xFF) == 8) {
                        x86_complex_unsupported(&buf, "_Complex float local variable");
                        break;
                    }
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
                    if (x86_global_size(prog, I->name) == 16) {
                        x86_complex_unsupported(&buf, "global variable");
                        break;
                    }
                    if ((I->aux & IR_AUX_COMPLEX) &&
                        x86_global_size(prog, I->name) == 8) {
                        x86_complex_unsupported(&buf, "_Complex float global variable");
                        break;
                    }
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
                    if (x86_global_size(prog, I->name) == 16) {
                        x86_complex_unsupported(&buf, "global variable");
                        break;
                    }
                    if ((I->aux & IR_AUX_COMPLEX) &&
                        x86_global_size(prog, I->name) == 8) {
                        x86_complex_unsupported(&buf, "_Complex float global variable");
                        break;
                    }
                    asmbuf_puts(&buf, "    pop eax\n    mov [");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "], eax\n");
                    break;
                case IR_POP:
                    asmbuf_puts(&buf, "    add esp, 4\n");
                    break;
                case IR_DUP:
                    if (I->val > 1) {
                        /* 8/16-byte value: one dword copy would leave the rest
                         * of the value behind and drift the operand stack. */
                        x86_complex_unsupported(&buf, "duplicate");
                        break;
                    }
                    asmbuf_puts(&buf, "    mov eax, [esp]\n    push eax\n");
                    break;
                case IR_SWAP:
                    asmbuf_puts(&buf, "    pop eax\n    pop ecx\n    push eax\n    push ecx\n");
                    break;
                case IR_STORE:
                    if ((I->aux & ~(IR_AUX_VOLATILE | IR_AUX_COMPLEX)) == 16) {
                        x86_complex_unsupported(&buf, "store");
                        break;
                    }
                    if ((I->aux & IR_AUX_COMPLEX) &&
                        (I->aux & ~(IR_AUX_VOLATILE | IR_AUX_COMPLEX)) == 8) {
                        x86_complex_unsupported(&buf, "_Complex float store");
                        break;
                    }
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
                    if (es == 16) {
                        x86_complex_unsupported(&buf, "array element load");
                        break;
                    }
                    if (es == 8 && (I->aux & IR_AUX_COMPLEX)) {
                        x86_complex_unsupported(&buf, "_Complex float array element load");
                        break;
                    }
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
                        /* 4-byte (default): a dword load already writes all of
                         * eax, so signed and unsigned agree. "movsx eax, dword
                         * ptr [eax]" is a 32->32 sign extension, which does not
                         * exist and is rejected by GNU as, so never emit it. */
                        asmbuf_puts(&buf, "    mov eax, dword ptr [eax]\n");
                    }
                    asmbuf_puts(&buf, "    push eax\n");
                    break;
                }
                case IR_STORE_IDX: {
                    /* Pop value (edx), pop address (eax). Store value.
                     * I->val = element size (1/2/4/8). */
                    int es = I->val;
                    if (es == 16) {
                        x86_complex_unsupported(&buf, "array element store");
                        break;
                    }
                    if (es == 8 && (I->aux & IR_AUX_COMPLEX)) {
                        x86_complex_unsupported(&buf, "_Complex float array element store");
                        break;
                    }
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
                    if (I->aux & IR_AUX_COMPLEX) {
                        /* __builtin conj() of a _Complex value. */
                        x86_complex_unsupported(&buf, "conj");
                        break;
                    }
                    asmbuf_puts(&buf, "    pop eax\n");
                    /* val==1 is a float/double `-x`.  Both are held as a double
                     * on this stack with the HIGH dword on top, and that dword
                     * carries the sign bit, so the integer `neg` (which returns
                     * +0.0 for -0.0 and wrecks the exponent) is replaced by a
                     * sign-bit flip. */
                    if (I->val == 1 && I->aux == (int)TOK_MINUS)
                        asmbuf_puts(&buf, "    xor eax, 0x80000000\n");
                    else if (I->aux == (int)TOK_MINUS) asmbuf_puts(&buf, "    neg eax\n");
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

                    /* 16-byte alignment for the call (an external cdecl callee
                     * may use movaps).  It has to happen *before* the
                     * arguments are pushed: padding afterwards meant
                     * "and esp, -16" moved esp below the arguments it had just
                     * pushed, and the callee read padding as [ebp+8] -- i.e.
                     * every i386 call passed garbage whenever esp was not
                     * already aligned.  With N arguments pushed, the pad is
                     * (esp - 4N) mod 16, which leaves esp a multiple of 16 at
                     * the call instruction. */
                    asmbuf_puts(&buf, "    mov eax, esp\n");
                    if (stack_cnt > 0) {
                        asmbuf_puts(&buf, "    sub eax, ");
                        asmbuf_int(&buf, 4 * stack_cnt);
                        asmbuf_putc(&buf, '\n');
                    }
                    asmbuf_puts(&buf, "    and eax, 15\n    sub esp, eax\n");

                    /* Push stack args in reverse order (right to left) so
                     * leftmost arg is at [esp] (lowest address). */
                    for (k = stack_cnt - 1; k >= 0; k--) {
                        asmbuf_puts(&buf, "    push dword ptr [ebp-");
                        asmbuf_int(&buf, scratch_base + 16 + 4 * k);
                        asmbuf_puts(&buf, "]\n");
                    }

                    /* For direct calls, check if the callee returns void.
                     * If so, skip the push of the return value. */
                    if (!is_indirect) {
                        int fi2;
                        int found = 0;
                        for (fi2 = 0; fi2 < prog->func_count; fi2++) {
                            if (ark_streq(prog->funcs[fi2]->name, I->name)) {
                                Type *rt = prog->funcs[fi2]->ret_type;
                                found = 1;
                                if (rt && rt->kind == TYPE_VOID)
                                    is_void_ret = 1;
                                break;
                            }
                        }
                        /* Declared-only callee: irgen knows the prototype, so
                         * take the result shape from the call site. */
                        if (!found)
                            is_void_ret = (int)((I->val >> 33) & 1);
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

                /* IR_TRUNC: val = target width, aux = 1 zero-extend. */
                case IR_TRUNC:
                    asmbuf_puts(&buf, "    pop eax\n");
                    if (I->val == 8)
                        asmbuf_puts(&buf, I->aux ? "    movzx eax, al\n" : "    movsx eax, al\n");
                    else if (I->val == 16)
                        asmbuf_puts(&buf, I->aux ? "    movzx eax, ax\n" : "    movsx eax, ax\n");
                    asmbuf_puts(&buf, "    push eax\n");
                    break;

                /* IR_PUSH_FUNC: push the address of a function symbol. */
                case IR_PUSH_FUNC:
                    asmbuf_puts(&buf, "    lea eax, [");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "]\n    push eax\n");
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
                    /* IR_AUX_COMPLEX, not the old 0x400: irgen puts 0x200 too
                     * (a complex constant is a double pair), so this test has
                     * to run first, exactly like the ARM and RV backends. */
                    int is_complex = (I->aux & IR_AUX_COMPLEX) != 0;
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
                    /* cexp() is a single-operand op that irgen encodes on the
                     * IR_FADD slot with (aux & 0xF00) == 0x900.  Treating it as
                     * a binary complex add would pop one operand too many. */
                    if ((I->aux & 0xF00) == 0x900) {
                        x86_complex_unsupported(&buf, "cexp");
                        break;
                    }
                    /* _Complex double: two ops on real/imag parts */
                    if (I->aux & IR_AUX_COMPLEX) {
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
                    int is_complex = (I->aux & IR_AUX_COMPLEX) != 0;
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
                    if (I->aux & IR_AUX_COMPLEX) {
                        /* creal / cimag / cabs / carg of a _Complex value. */
                        x86_complex_unsupported(&buf, "creal/cimag/cabs/carg");
                        break;
                    }
                    asmbuf_puts(&buf, "    movq xmm0, [esp]\n    add esp, 8\n");
                    asmbuf_puts(&buf, "    cvttsd2si eax, xmm0\n    push eax\n");
                    break;
                }

                /* IR_I2F: int -> double */
                case IR_I2F: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    if (I->aux & IR_AUX_COMPLEX) {
                        /* widening a real value to _Complex double */
                        x86_complex_unsupported(&buf, "real to complex conversion");
                        break;
                    }
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
                        /* 64-bit left shift.  `shld`/`shl` use cl & 31, so the
                         * n >= 32 half has to be a separate path or 1ULL << 32
                         * silently answers 1 (the old code did exactly that):
                         *   n <  32:  hi = shld(hi,lo,n); lo = lo << n
                         *   n >= 32:  hi = lo << (n-32); lo = 0 (bits pushed
                         *             past bit 63 are discarded)
                         * The count comes from the low dword of b. */
                        asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n");  /* shift count, skip hi */
                        asmbuf_puts(&buf, "    pop eax\n    pop edx\n");  /* a (lo,hi) */
                        asmbuf_puts(&buf, "    mov ebx, ecx\n    and cl, 31\n");
                        asmbuf_puts(&buf, "    cmp ebx, 32\n    jb 1f\n");
                        asmbuf_puts(&buf, "    mov edx, eax\n    shl edx, cl\n    xor eax, eax\n    jmp 2f\n");
                        asmbuf_puts(&buf, "1:  shld edx, eax, cl\n    shl eax, cl\n");
                        asmbuf_puts(&buf, "2:  push edx\n    push eax\n");
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
                                /* 64-bit right shift, same n < 32 / n >= 32 split
                                 * as the left shift above (cl is masked to 5 bits
                                 * by the hardware, so a single shift is not enough):
                                 *   n <  32:  lo = shrd(lo,hi,n); hi = hi >> n
                                 *   n >= 32:  lo = hi >> (n-32); hi = 0 or sign(hi) */
                                asmbuf_puts(&buf, "    pop ecx\n    add esp, 4\n    pop eax\n    pop edx\n");
                                asmbuf_puts(&buf, "    mov ebx, ecx\n    and cl, 31\n");
                                asmbuf_puts(&buf, "    cmp ebx, 32\n    jb 1f\n");
                                if (I->aux & 0x100)
                                    asmbuf_puts(&buf, "    mov eax, edx\n    shr eax, cl\n    xor edx, edx\n    jmp 2f\n");
                                else
                                    asmbuf_puts(&buf, "    mov eax, edx\n    sar eax, cl\n    sar edx, 31\n    jmp 2f\n");
                                if (I->aux & 0x100)
                                    asmbuf_puts(&buf, "1:  shrd eax, edx, cl\n    shr edx, cl\n");
                                else
                                    asmbuf_puts(&buf, "1:  shrd eax, edx, cl\n    sar edx, cl\n");
                                asmbuf_puts(&buf, "2:  push edx\n    push eax\n");
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

                /* IR_ASM: inline assembly. The template is written out verbatim.
                 * Extended form ("@template : outs : ins : clobbers") carries the
                 * placeholders but not the operand -> register assignment, so the
                 * x86 backend cannot substitute %N the way the ARM backend does.
                 * Emitting the template anyway produced assembly that no assembler
                 * accepts, so report it as an error instead of shipping garbage. */
                case IR_ASM:
                    if (I->name) {
                        const char *s = I->name;
                        if (s[0] == '@') {
                            s++;
                            while (*s == ' ' || *s == '\t') s++;
                            if (*s == '"') {
                                const char *q = s + 1;
                                while (*q && *q != '"') {
                                    if (*q == '%' && q[1] >= '0' && q[1] <= '9') {
                                        ark_log("[x86] error: inline asm operand %%%c cannot be "
                                                "substituted by the x86 backend\n", q[1]);
                                        x86_emit_errors++;
                                        break;
                                    }
                                    q++;
                                }
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
        int errs = x86_emit_errors;
        x86_emit_errors = 0;
        if (errs) {
            ark_log("[x86] error: %d unsupported construct(s), no output written\n", errs);
            if (cap > 0) out[0] = 0;
            return -1;
        }
        if (n + 1 > cap) n = cap - 1;
        for (i = 0; i < n; i++) out[i] = buf.buf[i];
        out[n] = 0;
        return n;
    }
}

/* === x86-64 / System V emitter ===========================================
 *
 * The IR word is 32 bits wide, so every 8-byte value travels as TWO words
 * with the HIGH word on top.  A pointer is the one exception: the type model
 * says 8 bytes, but an address is a single object, so irgen marks it
 * IR_AUX_SLOT64 and it occupies ONE machine word.
 *
 * Every machine word is an 8-byte stack slot, and the high 32 bits of a slot
 * that carries a 32-bit payload MUST be zero.  That falls out of the 2-word
 * model: all 32-bit results are produced by a write to the 32-bit register
 * form (which zeroes the upper half of the 64-bit register), and sign
 * extension is never implicit -- irgen spells it out as
 * PUSH 0 / compare / negate, which is why a `long long` built from an `int`
 * is exact here even though nothing in the IR says whether the int was
 * signed.
 *
 * Frame (rbp-relative, and the stack grows towards lower addresses):
 *     [rbp-8]                hidden sret pointer (return buffer)
 *     [rbp-16]               rsp saved across a call
 *     [rbp-24] .. [rbp-48]   scratch
 *     [rbp-FRAMELO + off]    locals,  FRAMELO = 48 + round16(local_size)
 *     [rbp-FRAMELO-8*(k+1)]  64 argument spill slots
 * FRAME is a multiple of 16, so rsp is 16-byte aligned at every `call`.
 *
 * Register use: rax rcx rdx rsi rdi r8-r11 and xmm0-xmm7 -- no callee-saved
 * register is touched, so the prologue has nothing to preserve.  Floating
 * point travels as its bit pattern through the integer stack; a single
 * precision operation is widened to double, computed, and narrowed, because
 * this assembler has no addss/subss/mulss/divss and no movd.
 */

static int g_amd64_errors;

static void amd_unsupported(AsmBuffer *b, const char *what) {
    ark_log("[x86-64] error: %s is not supported by the x86_64 backend\n", what);
    g_amd64_errors++;
    asmbuf_puts(b, "    # unsupported: ");
    asmbuf_puts(b, what);
    asmbuf_putc(b, '\n');
}

/* "[rbp+delta]" / "[rbp-delta]" / "[rbp]" */
static void amd_addr(AsmBuffer *b, int delta) {
    asmbuf_puts(b, "[rbp");
    if (delta > 0) {
        asmbuf_putc(b, '+');
        asmbuf_int(b, delta);
    } else if (delta < 0) {
        asmbuf_putc(b, '-');
        asmbuf_int(b, -delta);
    }
    asmbuf_putc(b, ']');
}

/* "    <mn> <reg>, [<size> ptr] [rbp+delta]" */
static void amd_mem_rd(AsmBuffer *b, const char *mn, const char *reg,
                       const char *sz, int delta) {
    asmbuf_puts(b, "    ");
    asmbuf_puts(b, mn);
    asmbuf_putc(b, ' ');
    asmbuf_puts(b, reg);
    asmbuf_puts(b, ", ");
    if (sz && sz[0]) {
        asmbuf_puts(b, sz);
        asmbuf_puts(b, " ptr ");
    }
    amd_addr(b, delta);
    asmbuf_putc(b, '\n');
}

/* "    <mn> [<size> ptr] [rbp+delta], <reg>" */
static void amd_rd_mem(AsmBuffer *b, const char *mn, const char *sz,
                       int delta, const char *reg) {
    asmbuf_puts(b, "    ");
    asmbuf_puts(b, mn);
    asmbuf_putc(b, ' ');
    if (sz && sz[0]) {
        asmbuf_puts(b, sz);
        asmbuf_puts(b, " ptr ");
    }
    amd_addr(b, delta);
    asmbuf_puts(b, ", ");
    asmbuf_puts(b, reg);
    asmbuf_putc(b, '\n');
}

/* Push a 32-bit immediate as one zero-extended 8-byte slot. */
static void amd_push_imm32(AsmBuffer *b, long long v) {
    if (v >= -2147483648LL && v <= 2147483647LL) {
        asmbuf_puts(b, "    mov eax, ");
        asmbuf_int(b, v);
        asmbuf_puts(b, "\n    push rax\n");
    } else {
        asmbuf_puts(b, "    mov rax, ");
        asmbuf_int(b, v);
        asmbuf_puts(b, "\n    push rax\n");
    }
}

/* Push a 64-bit constant as TWO words: low first, high on top. */
static void amd_push_imm64(AsmBuffer *b, unsigned long long v) {
    asmbuf_puts(b, "    mov eax, ");
    asmbuf_int(b, (long long)(int)(unsigned int)(v & 0xFFFFFFFFULL));
    asmbuf_puts(b, "\n    push rax\n    mov eax, ");
    asmbuf_int(b, (long long)(int)(unsigned int)((v >> 32) & 0xFFFFFFFFULL));
    asmbuf_puts(b, "\n    push rax\n");
}

/* [.., lo, hi] -> r64 = (hi << 32) | lo.  r32 is r64's 32-bit name. */
/* Both helpers below need a scratch register for the other half of the value.
 * The scratch used to be hard-wired to rdx, which silently corrupted every
 * call that passed "rdx" as the value register: "mov rdx, rdx" left the value
 * in place but the following "shr rdx, 32" then destroyed it, and the pair
 * pushed onto the stack was (hi, hi) with the low word lost.  Pick a scratch
 * that is not the value register. */
static const char *amd_scratch_for(const char *r64) {
    return ark_streq(r64, "rdx") ? "rcx" : "rdx";
}

static void amd_pop64(AsmBuffer *b, const char *r64, const char *r32) {
    const char *s = amd_scratch_for(r64);
    asmbuf_puts(b, "    pop ");
    asmbuf_puts(b, s);
    asmbuf_puts(b, "\n    pop ");
    asmbuf_puts(b, r64);
    asmbuf_puts(b, "\n    mov ");
    asmbuf_puts(b, r32);
    asmbuf_puts(b, ", ");
    asmbuf_puts(b, r32);
    asmbuf_puts(b, "\n    shl ");
    asmbuf_puts(b, s);
    asmbuf_puts(b, ", 32\n    or ");
    asmbuf_puts(b, r64);
    asmbuf_puts(b, ", ");
    asmbuf_puts(b, s);
    asmbuf_puts(b, "\n");
}

/* r64 -> push lo, then hi on top.  r32 is r64's 32-bit name. */
static void amd_push64(AsmBuffer *b, const char *r64, const char *r32) {
    const char *s = amd_scratch_for(r64);
    asmbuf_puts(b, "    mov ");
    asmbuf_puts(b, s);
    asmbuf_puts(b, ", ");
    asmbuf_puts(b, r64);
    asmbuf_puts(b, "\n    shr ");
    asmbuf_puts(b, s);
    asmbuf_puts(b, ", 32\n    mov ");
    asmbuf_puts(b, r32);
    asmbuf_puts(b, ", ");
    asmbuf_puts(b, r32);
    asmbuf_puts(b, "\n    push ");
    asmbuf_puts(b, r64);
    asmbuf_puts(b, "\n    push ");
    asmbuf_puts(b, s);
    asmbuf_puts(b, "\n");
}

/* Load <size> ptr [rbp+delta] into a 64-bit register, zero-extending a narrow
 * load.  Used for a 1/2/4-byte local whose slot has to become one full word. */
static void amd_load_ext(AsmBuffer *b, int sz, int delta, int is_unsigned) {
    if (sz == 1) {
        asmbuf_puts(b, is_unsigned ? "    movzx eax, byte ptr " : "    movsx eax, byte ptr ");
        amd_addr(b, delta);
        asmbuf_putc(b, '\n');
    } else if (sz == 2) {
        asmbuf_puts(b, is_unsigned ? "    movzx eax, word ptr " : "    movsx eax, word ptr ");
        amd_addr(b, delta);
        asmbuf_putc(b, '\n');
    } else {
        asmbuf_puts(b, "    mov eax, dword ptr ");
        amd_addr(b, delta);
        asmbuf_putc(b, '\n');
    }
}

/* The SysV integer argument registers, in order. */
static const char *amd_argreg64[6] = { "rdi", "rsi", "rdx", "rcx", "r8", "r9" };
static const char *amd_argreg32[6] = { "edi", "esi", "edx", "ecx", "r8d", "r9d" };

/* The type of a named global, or NULL. */
static Type *amd_global_type(IrProgram *prog, const char *name) {
    int i;
    if (!name) return 0;
    for (i = 0; i < prog->global_count; i++) {
        IrGlobal *g = prog->globals[i];
        if (g && g->name && ark_streq(g->name, name)) return g->type;
    }
    return 0;
}

/* Compare two doubles in xmm0 (a) and xmm1 (b) and push 0/1.  ucomisd sets
 * PF for unordered operands, so ==/!=/<... each need the parity flag folded
 * in; the i386 emitter ignored it and answered "1" for NaN != NaN. */
static void amd_fcmp(AsmBuffer *b, int op) {
    asmbuf_puts(b, "    ucomisd xmm0, xmm1\n    ");
    switch (op) {
        case (int)TOK_EQ:
            asmbuf_puts(b, "sete al\n    setnp cl\n    and al, cl\n");
            break;
        case (int)TOK_NE:
            asmbuf_puts(b, "setne al\n    setp cl\n    or al, cl\n");
            break;
        case (int)TOK_LT:
            asmbuf_puts(b, "setb al\n    setnp cl\n    and al, cl\n");
            break;
        case (int)TOK_LE:
            asmbuf_puts(b, "setbe al\n    setnp cl\n    and al, cl\n");
            break;
        case (int)TOK_GT:
            asmbuf_puts(b, "seta al\n");
            break;
        case (int)TOK_GE:
            asmbuf_puts(b, "setae al\n");
            break;
        default:
            asmbuf_puts(b, "sete al\n    setnp cl\n    and al, cl\n");
            break;
    }
    asmbuf_puts(b, "    movzx eax, al\n    push rax\n");
}

/* Which TOK_* condition a 2-operand compare should use. */
static const char *amd_cc(int op, int is_unsigned) {
    switch (op) {
        case (int)TOK_EQ: return "sete";
        case (int)TOK_NE: return "setne";
        case (int)TOK_LT: return is_unsigned ? "setb" : "setl";
        case (int)TOK_GT: return is_unsigned ? "seta" : "setg";
        case (int)TOK_LE: return is_unsigned ? "setbe" : "setle";
        case (int)TOK_GE: return is_unsigned ? "setae" : "setge";
        default: return "sete";
    }
}

/* Emit floating <-> integer conversion result: the value is in xmm0 and the
 * destination is a float (one word) or a double (two words). */
static void amd_store_fp(AsmBuffer *b, int is_double) {
    if (is_double) {
        asmbuf_puts(b, "    movq rax, xmm0\n");
        amd_push64(b, "rax", "eax");
    } else {
        asmbuf_puts(b, "    cvtsd2ss xmm0, xmm0\n    movq rax, xmm0\n"
                       "    mov eax, eax\n    push rax\n");
    }
}

static int amd64_emit_internal(IrProgram *prog, char *out, int cap) {
    AsmBuffer buf;
    int fi;
    asmbuf_init(&buf);

    asmbuf_puts(&buf, "# Ark C Compiler - generated x86-64 (System V AMD64) assembly\n");
    asmbuf_puts(&buf, "    .intel_syntax noprefix\n");
    x86_emit_data_sections(&buf, prog);
    asmbuf_puts(&buf, "    .text\n");

    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        int i;
        int lsz = (f->local_size + 15) & ~15;
        int framelo;
        int frame;
        int sret_used = 0;
        int param_idx = 0;
        int body_ok = 1;
        if (lsz < 16) lsz = 16;
        framelo = 48 + lsz;
        frame = (framelo + 64 * 8 + 15) & ~15;

        if (f->ret_type &&
            (f->ret_type->kind == TYPE_STRUCT || f->ret_type->kind == TYPE_UNION) &&
            type_size(f->ret_type) > 8)
            sret_used = 1;

        if (!f->is_static) {
            asmbuf_puts(&buf, "    .globl ");
            asmbuf_puts(&buf, f->name);
            asmbuf_putc(&buf, '\n');
        }
        asmbuf_puts(&buf, f->name);
        asmbuf_puts(&buf, ":\n");
        asmbuf_puts(&buf, "    push rbp\n    mov rbp, rsp\n    sub rsp, ");
        asmbuf_int(&buf, frame);
        asmbuf_putc(&buf, '\n');
        if (sret_used) {
            asmbuf_puts(&buf, "    mov qword ptr [rbp-8], rdi\n");
        }

        /* A variadic definition needs a register save area and a va_list that
         * walks it; that is not implemented, so refuse instead of building a
         * callee whose va_arg reads the wrong memory. */
        if (f->is_variadic) {
            amd_unsupported(&buf, "definition of a variadic function");
            body_ok = 0;
        }

        /* Spill every incoming argument word into its frame slot first, so an
         * IR_GETARG that copies a large aggregate out of the argument registers
         * cannot clobber a register a later parameter still needs (the copy
         * uses rdi/rsi/rcx). */
        if (body_ok) {
            int int_used = sret_used ? 1 : 0;
            int sse_used = 0;
            int stk = 16;
            int k = 0, pi = 0, j;
            for (j = 0; j < f->code_count; j++) {
                IrInst *I = &f->code[j];
                Type *pt = 0;
                int is_sse;
                int tmp;
                if (I->op != IR_GETARG || I->val >= 8000) continue;
                if (f->param_types && pi < f->param_count) pt = f->param_types[pi];
                pi++;
                is_sse = (pt && (pt->kind == TYPE_FLOAT || pt->kind == TYPE_DOUBLE));
                tmp = -framelo - 8 * (k + 1);
                k++;
                if (is_sse) {
                    if (sse_used < 8) {
                        asmbuf_puts(&buf, "    movq rax, xmm");
                        asmbuf_int(&buf, sse_used);
                        asmbuf_puts(&buf, "\n");
                        amd_rd_mem(&buf, "mov", "qword", tmp, "rax");
                        sse_used++;
                    } else {
                        amd_mem_rd(&buf, "mov", "rax", "qword", stk);
                        amd_rd_mem(&buf, "mov", "qword", tmp, "rax");
                        stk += 8;
                    }
                } else {
                    if (int_used < 6) {
                        amd_rd_mem(&buf, "mov", "qword", tmp, amd_argreg64[int_used]);
                        int_used++;
                    } else {
                        amd_mem_rd(&buf, "mov", "rax", "qword", stk);
                        amd_rd_mem(&buf, "mov", "qword", tmp, "rax");
                        stk += 8;
                    }
                }
            }
        }

        for (i = 0; i < f->code_count && body_ok; i++) {
            IrInst *I = &f->code[i];
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END:
                case IR_NOP:
                case IR_ARG:
                case IR_LOCAL_ALLOC:
                /* The IR spells every widening out itself (PUSH 0 + compare +
                 * negate for signed, PUSH 0 for unsigned) and every narrowing
                 * as an explicit IR_TRUNC, so these three are no-ops -- the
                 * same contract the ARM and RISC-V backends work under. */
                case IR_SEXT:
                case IR_ZEXT:
                case IR_CDECL64:
                    break;

                case IR_GETARG: {
                    int sz;
                    int tmp;
                    int dst;
                    int k = param_idx++;
                    if (I->val >= 8000) {
                        amd_unsupported(&buf, "va_arg slot of a variadic function");
                        break;
                    }
                    sz = (int)((I->aux >> 8) & 0xFF);
                    if (sz <= 0) sz = 4;
                    tmp = -framelo - 8 * (k + 1);
                    dst = (int)I->val - framelo;
                    if (sz > 8) {
                        /* The wire carried the aggregate's address. */
                        amd_mem_rd(&buf, "mov", "rsi", "qword", tmp);
                        asmbuf_puts(&buf, "    lea rdi, ");
                        amd_addr(&buf, dst);
                        asmbuf_putc(&buf, '\n');
                        asmbuf_puts(&buf, "    mov ecx, ");
                        asmbuf_int(&buf, sz);
                        asmbuf_puts(&buf, "\n    rep movsb\n");
                    } else if (sz >= 5) {
                        amd_mem_rd(&buf, "mov", "rax", "qword", tmp);
                        amd_rd_mem(&buf, "mov", "qword", dst, "rax");
                    } else if (sz == 4) {
                        amd_mem_rd(&buf, "mov", "eax", "dword", tmp);
                        amd_rd_mem(&buf, "mov", "dword", dst, "eax");
                    } else if (sz == 2) {
                        amd_mem_rd(&buf, "mov", "eax", "dword", tmp);
                        amd_rd_mem(&buf, "mov", "word", dst, "ax");
                    } else {
                        amd_mem_rd(&buf, "mov", "eax", "dword", tmp);
                        amd_rd_mem(&buf, "mov", "byte", dst, "al");
                    }
                    break;
                }

                case IR_PUSH_INT:
                    amd_push_imm32(&buf, I->val);
                    break;

                case IR_PUSH_STR:
                    asmbuf_puts(&buf, "    lea rax, [ark_str_");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "]\n    push rax\n");
                    break;

                case IR_PUSH_VAR: {
                    int w = (int)(I->aux & 0xFF);
                    int slot64 = (I->aux & IR_AUX_SLOT64) != 0;
                    int d = (int)I->val - framelo;
                    if (w == 16) {
                        amd_unsupported(&buf, "16-byte local variable");
                        break;
                    }
                    if ((I->aux & IR_AUX_COMPLEX) && w == 8) {
                        amd_unsupported(&buf, "_Complex float local variable");
                        break;
                    }
                    if (slot64) {
                        amd_mem_rd(&buf, "mov", "rax", "qword", d);
                        asmbuf_puts(&buf, "    push rax\n");
                    } else if (w == 8) {
                        amd_mem_rd(&buf, "mov", "rax", "qword", d);
                        amd_push64(&buf, "rax", "eax");
                    } else {
                        amd_load_ext(&buf, w, d, (I->aux & 0x100) != 0);
                        asmbuf_puts(&buf, "    push rax\n");
                    }
                    break;
                }

                case IR_PUSH_ADDR: {
                    int d = (int)I->val - framelo;
                    asmbuf_puts(&buf, "    lea rax, ");
                    amd_addr(&buf, d);
                    asmbuf_puts(&buf, "\n    push rax\n");
                    break;
                }

                case IR_PUSH_GLOBAL: {
                    Type *t = amd_global_type(prog, I->name);
                    int sz = t ? type_size(t) : 4;
                    int uns = t ? t->is_unsigned : 0;
                    if (sz == 16) {
                        amd_unsupported(&buf, "16-byte global variable");
                        break;
                    }
                    if ((I->aux & IR_AUX_COMPLEX) && sz == 8) {
                        amd_unsupported(&buf, "_Complex float global variable");
                        break;
                    }
                    if (t && t->kind == TYPE_PTR) {
                        asmbuf_puts(&buf, "    mov rax, qword ptr [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "]\n    push rax\n");
                    } else if (sz >= 8) {
                        asmbuf_puts(&buf, "    mov rax, qword ptr [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "]\n");
                        amd_push64(&buf, "rax", "eax");
                    } else if (sz == 1) {
                        asmbuf_puts(&buf, uns ? "    movzx eax, byte ptr [" : "    movsx eax, byte ptr [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "]\n    push rax\n");
                    } else if (sz == 2) {
                        asmbuf_puts(&buf, uns ? "    movzx eax, word ptr [" : "    movsx eax, word ptr [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "]\n    push rax\n");
                    } else {
                        asmbuf_puts(&buf, "    mov eax, dword ptr [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "]\n    push rax\n");
                    }
                    break;
                }

                case IR_STORE_GLOBAL: {
                    Type *t = amd_global_type(prog, I->name);
                    int sz = t ? type_size(t) : 4;
                    if (sz == 16) {
                        amd_unsupported(&buf, "16-byte global variable");
                        break;
                    }
                    if ((I->aux & IR_AUX_COMPLEX) && sz == 8) {
                        amd_unsupported(&buf, "_Complex float global variable");
                        break;
                    }
                    if (t && t->kind == TYPE_PTR) {
                        asmbuf_puts(&buf, "    pop rax\n    mov qword ptr [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "], rax\n");
                    } else if (sz >= 8) {
                        /* mode64 rejects "[sym+disp]", so materialise the
                         * address first and use a register-relative form. */
                        asmbuf_puts(&buf, "    pop rdx\n    pop rax\n    lea rcx, [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "]\n    mov dword ptr [rcx], eax\n"
                                          "    mov dword ptr [rcx+4], edx\n");
                    } else if (sz == 1) {
                        asmbuf_puts(&buf, "    pop rax\n    mov byte ptr [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "], al\n");
                    } else if (sz == 2) {
                        asmbuf_puts(&buf, "    pop rax\n    mov word ptr [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "], ax\n");
                    } else {
                        asmbuf_puts(&buf, "    pop rax\n    mov dword ptr [");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "], eax\n");
                    }
                    break;
                }

                case IR_POP:
                    asmbuf_puts(&buf, "    add rsp, 8\n");
                    break;

                case IR_DUP: {
                    int nw = (int)I->val;
                    int k;
                    if (nw < 1) nw = 1;
                    if (nw > 4) {
                        amd_unsupported(&buf, "duplicate of more than four words");
                        break;
                    }
                    /* Snapshot first: pushing shifts rsp under the reads. */
                    for (k = 0; k < nw; k++) {
                        asmbuf_puts(&buf, "    mov rax, qword ptr [rsp+");
                        asmbuf_int(&buf, 8 * k);
                        asmbuf_puts(&buf, "]\n");
                        amd_rd_mem(&buf, "mov", "qword", -24 - 8 * k, "rax");
                    }
                    for (k = nw - 1; k >= 0; k--) {
                        amd_mem_rd(&buf, "mov", "rax", "qword", -24 - 8 * k);
                        asmbuf_puts(&buf, "    push rax\n");
                    }
                    break;
                }

                case IR_SWAP:
                    asmbuf_puts(&buf, "    pop rax\n    pop rcx\n    push rax\n    push rcx\n");
                    break;

                case IR_STORE: {
                    int w = (int)(I->aux & ~(IR_AUX_VOLATILE | IR_AUX_COMPLEX | IR_AUX_SLOT64));
                    int slot64 = (I->aux & IR_AUX_SLOT64) != 0;
                    int d = (int)I->val - framelo;
                    if (w == 16) {
                        amd_unsupported(&buf, "16-byte store");
                        break;
                    }
                    if ((I->aux & IR_AUX_COMPLEX) && w == 8) {
                        amd_unsupported(&buf, "_Complex float store");
                        break;
                    }
                    if (slot64) {
                        asmbuf_puts(&buf, "    pop rax\n");
                        amd_rd_mem(&buf, "mov", "qword", d, "rax");
                    } else if (w == 8) {
                        asmbuf_puts(&buf, "    pop rdx\n    pop rax\n");
                        amd_rd_mem(&buf, "mov", "dword", d, "eax");
                        amd_rd_mem(&buf, "mov", "dword", d + 4, "edx");
                    } else if (w == 1) {
                        asmbuf_puts(&buf, "    pop rax\n");
                        amd_rd_mem(&buf, "mov", "byte", d, "al");
                    } else if (w == 2) {
                        asmbuf_puts(&buf, "    pop rax\n");
                        amd_rd_mem(&buf, "mov", "word", d, "ax");
                    } else {
                        asmbuf_puts(&buf, "    pop rax\n");
                        amd_rd_mem(&buf, "mov", "dword", d, "eax");
                    }
                    break;
                }

                case IR_LOAD_IDX: {
                    int es = (int)I->val;
                    int uns = (I->aux & 0x1) != 0;
                    int slot64 = (I->aux & IR_AUX_SLOT64) != 0;
                    if (es == 16) {
                        amd_unsupported(&buf, "16-byte array element load");
                        break;
                    }
                    if (es == 8 && (I->aux & IR_AUX_COMPLEX)) {
                        amd_unsupported(&buf, "_Complex float array element load");
                        break;
                    }
                    asmbuf_puts(&buf, "    pop rcx\n    pop rax\n    movsxd rcx, ecx\n");
                    if (es == 2) asmbuf_puts(&buf, "    shl rcx, 1\n");
                    else if (es == 4) asmbuf_puts(&buf, "    shl rcx, 2\n");
                    else if (es == 8) asmbuf_puts(&buf, "    shl rcx, 3\n");
                    asmbuf_puts(&buf, "    add rax, rcx\n");
                    if (slot64) {
                        asmbuf_puts(&buf, "    mov rdx, qword ptr [rax]\n    push rdx\n");
                    } else if (es == 1) {
                        asmbuf_puts(&buf, uns ? "    movzx eax, byte ptr [rax]\n"
                                              : "    movsx eax, byte ptr [rax]\n");
                        asmbuf_puts(&buf, "    push rax\n");
                    } else if (es == 2) {
                        asmbuf_puts(&buf, uns ? "    movzx eax, word ptr [rax]\n"
                                              : "    movsx eax, word ptr [rax]\n");
                        asmbuf_puts(&buf, "    push rax\n");
                    } else if (es == 8) {
                        asmbuf_puts(&buf, "    mov rdx, qword ptr [rax]\n");
                        amd_push64(&buf, "rdx", "edx");
                    } else {
                        asmbuf_puts(&buf, "    mov eax, dword ptr [rax]\n    push rax\n");
                    }
                    break;
                }

                case IR_STORE_IDX: {
                    int es = (int)I->val;
                    int slot64 = (I->aux & IR_AUX_SLOT64) != 0;
                    if (es == 16) {
                        amd_unsupported(&buf, "16-byte array element store");
                        break;
                    }
                    if (es == 8 && (I->aux & IR_AUX_COMPLEX)) {
                        amd_unsupported(&buf, "_Complex float array element store");
                        break;
                    }
                    if (slot64) {
                        asmbuf_puts(&buf, "    pop rdx\n    pop rax\n"
                                          "    mov qword ptr [rax], rdx\n    push rdx\n");
                    } else if (es == 8) {
                        asmbuf_puts(&buf, "    pop rdx\n    pop rcx\n    pop rax\n"
                                          "    mov dword ptr [rax], ecx\n"
                                          "    mov dword ptr [rax+4], edx\n"
                                          "    push rcx\n    push rdx\n");
                    } else if (es == 1) {
                        asmbuf_puts(&buf, "    pop rdx\n    pop rax\n"
                                          "    mov byte ptr [rax], dl\n    push rdx\n");
                    } else if (es == 2) {
                        asmbuf_puts(&buf, "    pop rdx\n    pop rax\n"
                                          "    mov word ptr [rax], dx\n    push rdx\n");
                    } else {
                        asmbuf_puts(&buf, "    pop rdx\n    pop rax\n"
                                          "    mov dword ptr [rax], edx\n    push rdx\n");
                    }
                    break;
                }

                case IR_BINARY: {
                    int op = (int)(I->aux & 0xFF);
                    int uns = (I->aux & 0x100) != 0;
                    const char *bop = binop_x(op);
                    asmbuf_puts(&buf, "    pop rcx\n    pop rax\n");
                    if (bop) {
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, bop);
                        asmbuf_puts(&buf, " eax, ecx\n    push rax\n");
                    } else if (op == (int)TOK_MUL) {
                        asmbuf_puts(&buf, "    imul eax, ecx\n    push rax\n");
                    } else if (op == (int)TOK_DIV) {
                        asmbuf_puts(&buf, uns ? "    xor edx, edx\n    div ecx\n"
                                              : "    cdq\n    idiv ecx\n");
                        asmbuf_puts(&buf, "    push rax\n");
                    } else if (op == (int)TOK_MOD) {
                        asmbuf_puts(&buf, uns ? "    xor edx, edx\n    div ecx\n"
                                              : "    cdq\n    idiv ecx\n");
                        asmbuf_puts(&buf, "    push rdx\n");
                    } else if (op == (int)TOK_SHL) {
                        asmbuf_puts(&buf, "    shl eax, cl\n    push rax\n");
                    } else if (op == (int)TOK_SHR) {
                        asmbuf_puts(&buf, uns ? "    shr eax, cl\n    push rax\n"
                                              : "    sar eax, cl\n    push rax\n");
                    } else {
                        const char *cc = amd_cc(op, uns);
                        asmbuf_puts(&buf, "    cmp eax, ecx\n    ");
                        asmbuf_puts(&buf, cc);
                        asmbuf_puts(&buf, " al\n    movzx eax, al\n    push rax\n");
                    }
                    break;
                }

                case IR_UNARY: {
                    if (I->aux & IR_AUX_COMPLEX) {
                        amd_unsupported(&buf, "conj");
                        break;
                    }
                    asmbuf_puts(&buf, "    pop rax\n");
                    if (I->val == 1 && (int)I->aux == (int)TOK_MINUS) {
                        /* float: the only word holds the sign bit; double: the
                         * high word (on top) does.  Either way the top word is
                         * the one to flip. */
                        asmbuf_puts(&buf, "    xor eax, 0x80000000\n    push rax\n");
                    } else if (I->val == 2 &&
                               ((int)I->aux == (int)TOK_MINUS || (int)I->aux == (int)TOK_BNOT)) {
                        asmbuf_puts(&buf, "    mov rdx, rax\n");
                        asmbuf_puts(&buf, "    pop rax\n    mov eax, eax\n"
                                          "    shl rdx, 32\n    or rax, rdx\n");
                        asmbuf_puts(&buf, (int)I->aux == (int)TOK_MINUS ? "    neg rax\n"
                                                                       : "    not rax\n");
                        amd_push64(&buf, "rax", "eax");
                    } else {
                        if ((int)I->aux == (int)TOK_MINUS)
                            asmbuf_puts(&buf, "    neg eax\n");
                        else if ((int)I->aux == (int)TOK_BNOT)
                            asmbuf_puts(&buf, "    not eax\n");
                        else
                            asmbuf_puts(&buf, "    test eax, eax\n    sete al\n    movzx eax, al\n");
                        asmbuf_puts(&buf, "    push rax\n");
                    }
                    break;
                }

                case IR_TRUNC: {
                    asmbuf_puts(&buf, "    pop rax\n");
                    if (I->val == 8)
                        asmbuf_puts(&buf, I->aux ? "    movzx eax, al\n" : "    movsx eax, al\n");
                    else if (I->val == 16)
                        asmbuf_puts(&buf, I->aux ? "    movzx eax, ax\n" : "    movsx eax, ax\n");
                    asmbuf_puts(&buf, "    push rax\n");
                    break;
                }

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
                case IR_JNZ:
                    asmbuf_puts(&buf, "    pop rax\n    test rax, rax\n    ");
                    asmbuf_puts(&buf, I->op == IR_JZ ? "jz .L" : "jnz .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    break;

                case IR_CMP_JMP_EQ:
                    asmbuf_puts(&buf, "    mov rax, qword ptr [rsp]\n    cmp eax, ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    jne .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_puts(&buf, "_cje");
                    asmbuf_int(&buf, i);
                    asmbuf_puts(&buf, "\n    add rsp, 8\n    jmp .L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_putc(&buf, '_');
                    asmbuf_int(&buf, I->aux);
                    asmbuf_puts(&buf, "\n.L");
                    asmbuf_puts(&buf, f->name);
                    asmbuf_puts(&buf, "_cje");
                    asmbuf_int(&buf, i);
                    asmbuf_puts(&buf, ":\n");
                    break;

                case IR_CALL: {
                    int n = (int)I->val;
                    int argmask = (int)I->aux;
                    int is_indirect = (I->name && I->name[0] == '?');
                    const int *wires = (I->aux2 > 0) ? &prog->argbytes[I->aux2 - 1] : 0;
                    int same[64], cls[64], where[64];
                    int int_used = 0, sse_used = 0, nstk = 0;
                    int k;

                    if (is_indirect) {
                        asmbuf_puts(&buf, "    pop r11\n");
                        n -= 1;
                    }
                    if (n < 0) n = 0;
                    if (n > 64) {
                        amd_unsupported(&buf, "call with more than 64 arguments");
                        break;
                    }
                    /* Pop every argument into its frame slot, preserving the
                     * two-word order: high word first (it is on top). */
                    for (k = 0; k < n; k++) {
                        int b, w, slot64, tmp;
                        if (wires) {
                            b = wires[k] & 0xFFFF;
                            slot64 = (wires[k] & 0x20000) != 0;
                        } else {
                            b = (k < 16 && ((argmask >> (2 * k + 1)) & 1)) ? 8 : 4;
                            slot64 = 0;
                        }
                        if (b <= 0) b = 4;
                        w = slot64 ? 1 : (b > 4 ? 2 : 1);
                        tmp = -framelo - 8 * (k + 1);
                        if (w == 2) {
                            asmbuf_puts(&buf, "    pop rdx\n");
                            amd_rd_mem(&buf, "mov", "dword", tmp + 4, "edx");
                            asmbuf_puts(&buf, "    pop rax\n");
                            amd_rd_mem(&buf, "mov", "dword", tmp, "eax");
                        } else {
                            asmbuf_puts(&buf, "    pop rax\n");
                            amd_rd_mem(&buf, "mov", "qword", tmp, "rax");
                        }
                        same[k] = (k < 16 && ((argmask >> (2 * k)) & 1)) ? 1 : 0;
                    }
                    /* Assign each argument to a register or to a stack slot.
                     * SysV allocates the two register files independently: an
                     * argument goes to an integer register while fewer than 6
                     * are used, or to an SSE register while fewer than 8 are,
                     * and only spills to the stack when its own class is
                     * exhausted.
                     *
                     * cls[k]:  0 = integer register, 1 = SSE register,
                     *          2 = stack slot.  where[k]: register number,
                     *          or the stack slot index.
                     * These used to share one int ("-2 - i" for xmm, anything
                     * non-negative for both registers and stack), which made
                     * "stack" indistinguishable from "integer register": every
                     * stack argument was loaded into rdi/rsi/... and the real
                     * registers were overwritten. */
                    for (k = 0; k < n; k++) {
                        if (same[k] && sse_used < 8) {
                            cls[k] = 1; where[k] = sse_used++;
                        } else if (!same[k] && int_used < 6) {
                            cls[k] = 0; where[k] = int_used++;
                        } else {
                            cls[k] = 2; where[k] = nstk++;
                        }
                    }
                    asmbuf_puts(&buf, "    mov qword ptr [rbp-16], rsp\n");
                    if (nstk > 0) {
                        asmbuf_puts(&buf, "    sub rsp, ");
                        asmbuf_int(&buf, (8 * nstk + 15) & ~15);
                        asmbuf_putc(&buf, '\n');
                    }
                    /* Stack arguments, left to right, each in its own 8-byte slot. */
                    {
                        int next = 0;
                        for (k = 0; k < n; k++) {
                            int b, tmp;
                            if (cls[k] != 2) continue;
                            if (wires) b = wires[k] & 0xFFFF;
                            else b = (k < 16 && ((argmask >> (2 * k + 1)) & 1)) ? 8 : 4;
                            (void)b;
                            tmp = -framelo - 8 * (k + 1);
                            amd_mem_rd(&buf, "mov", "rax", "qword", tmp);
                            asmbuf_puts(&buf, "    mov qword ptr [rsp+");
                            asmbuf_int(&buf, 8 * next);
                            asmbuf_puts(&buf, "], rax\n");
                            next++;
                        }
                    }
                    /* Register arguments. */
                    for (k = 0; k < n; k++) {
                        int b, tmp;
                        if (cls[k] == 2) continue;
                        if (wires) b = wires[k] & 0xFFFF;
                        else b = (k < 16 && ((argmask >> (2 * k + 1)) & 1)) ? 8 : 4;
                        tmp = -framelo - 8 * (k + 1);
                        if (cls[k] == 1) {
                            asmbuf_puts(&buf, "    movq xmm");
                            asmbuf_int(&buf, where[k]);
                            asmbuf_puts(&buf, ", qword ptr ");
                            amd_addr(&buf, tmp);
                            asmbuf_putc(&buf, '\n');
                        } else if (b > 4) {
                            amd_mem_rd(&buf, "mov", amd_argreg64[where[k]], "qword", tmp);
                        } else {
                            amd_mem_rd(&buf, "mov", amd_argreg32[where[k]], "dword", tmp);
                        }
                    }
                    /* al = number of vector registers used (SysV varargs). */
                    asmbuf_puts(&buf, "    mov al, ");
                    asmbuf_int(&buf, sse_used);
                    asmbuf_putc(&buf, '\n');
                    if (is_indirect) {
                        asmbuf_puts(&buf, "    call r11\n");
                    } else {
                        asmbuf_puts(&buf, "    call ");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, '\n');
                    }
                    asmbuf_puts(&buf, "    mov rsp, qword ptr [rbp-16]\n");
                    {
                        int ret2 = (int)((I->val >> 32) & 1);
                        int retvoid = (int)((I->val >> 33) & 1);
                        int retfloat = (int)((I->val >> 53) & 1);
                        if (retvoid) break;
                        if (retfloat) {
                            asmbuf_puts(&buf, "    movq rax, xmm0\n    mov eax, eax\n    push rax\n");
                        } else if (ret2) {
                            /* A two-word result comes back as one full 64-bit
                             * value in rax (see IR_RETURN: amd_pop64 rebuilds
                             * it there).  Splitting it with "mov edx, edx"
                             * only worked while the callee happened to leave
                             * the high word in rdx: amd_pop64 leaves hi<<32
                             * there instead, so the high word read back as 0
                             * and every 64-bit result was truncated to its
                             * low 32 bits.  Split rax explicitly. */
                            asmbuf_puts(&buf, "    mov rdx, rax\n    shr rdx, 32\n"
                                              "    mov eax, eax\n    push rax\n    push rdx\n");
                        } else {
                            asmbuf_puts(&buf, "    push rax\n");
                        }
                    }
                    break;
                }

                case IR_RETURN: {
                    Type *rt = f->ret_type;
                    int two = (rt && (rt->kind == TYPE_LLONG || rt->kind == TYPE_DOUBLE)) ||
                              (rt && (rt->kind == TYPE_STRUCT || rt->kind == TYPE_UNION) &&
                               type_size(rt) > 4 && type_size(rt) <= 8);
                    if (two) {
                        amd_pop64(&buf, "rax", "eax");
                    } else {
                        asmbuf_puts(&buf, "    pop rax\n    mov eax, eax\n");
                    }
                    if (rt && (rt->kind == TYPE_FLOAT || rt->kind == TYPE_DOUBLE))
                        asmbuf_puts(&buf, "    movq xmm0, rax\n");
                    if (sret_used)
                        asmbuf_puts(&buf, "    mov rax, qword ptr [rbp-8]\n");
                    asmbuf_puts(&buf, "    mov rsp, rbp\n    pop rbp\n    ret\n");
                    break;
                }

                case IR_PUSH_FUNC:
                    asmbuf_puts(&buf, "    lea rax, [");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "]\n    push rax\n");
                    break;

                case IR_PUSH_GLOBAL_ADDR:
                    asmbuf_puts(&buf, "    lea rax, [");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "]\n    push rax\n");
                    break;

                case IR_MEMCPY:
                    /* irgen pushes dst, src and then dst again, so the two pops
                     * below are the whole cleanup. */
                    asmbuf_puts(&buf, "    pop rdi\n    pop rsi\n    mov ecx, ");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "\n    rep movsb\n");
                    break;

                case IR_ALLOCA:
                    asmbuf_puts(&buf, "    pop rax\n    add rax, 15\n    and rax, -16\n"
                                      "    sub rsp, rax\n    mov rax, rsp\n    push rax\n");
                    break;

                case IR_DIV:
                case IR_MOD:
                    asmbuf_puts(&buf, "    pop rcx\n    pop rax\n");
                    if (I->aux & 1)
                        asmbuf_puts(&buf, "    xor edx, edx\n    div ecx\n");
                    else
                        asmbuf_puts(&buf, "    cdq\n    idiv ecx\n");
                    asmbuf_puts(&buf, I->op == IR_DIV ? "    push rax\n" : "    push rdx\n");
                    break;

                case IR_PUSH_FLOAT: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    if (I->aux & IR_AUX_COMPLEX) {
                        amd_unsupported(&buf, "_Complex constant");
                        break;
                    }
                    if (is_dbl) {
                        double v = (I->val >= 0 && I->val < prog->float_count) ?
                                   prog->floats[I->val] : 0.0;
                        union { double d; unsigned long long i; } u;
                        u.d = v;
                        amd_push_imm64(&buf, u.i);
                    } else {
                        float fv = (I->val >= 0 && I->val < prog->float_count) ?
                                   (float)prog->floats[I->val] : 0.0f;
                        union { float f; unsigned int i; } u;
                        u.f = fv;
                        amd_push_imm32(&buf, (long long)u.i);
                    }
                    break;
                }

                case IR_FADD:
                case IR_FSUB:
                case IR_FMUL:
                case IR_FDIV: {
                    const char *op_s = "addsd";
                    int is_dbl;
                    if ((I->aux & 0xF00) == 0x900) {
                        amd_unsupported(&buf, "cexp");
                        break;
                    }
                    if (I->aux & IR_AUX_COMPLEX) {
                        amd_unsupported(&buf, "_Complex arithmetic");
                        break;
                    }
                    switch (I->op) {
                        case IR_FADD: op_s = "addsd"; break;
                        case IR_FSUB: op_s = "subsd"; break;
                        case IR_FMUL: op_s = "mulsd"; break;
                        case IR_FDIV: op_s = "divsd"; break;
                        default: break;
                    }
                    is_dbl = (I->aux & 0x200) != 0;
                    if (is_dbl) {
                        amd_pop64(&buf, "rax", "eax");   /* b */
                        amd_pop64(&buf, "rcx", "ecx");   /* a */
                        asmbuf_puts(&buf, "    movq xmm0, rcx\n    movq xmm1, rax\n    ");
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " xmm0, xmm1\n    movq rax, xmm0\n");
                        amd_push64(&buf, "rax", "eax");
                    } else {
                        /* No single-precision ALU in this assembler: widen both
                         * operands, compute in double, narrow back.  Rounding
                         * twice is exact for + - * / because 53 >= 2*24 + 2. */
                        asmbuf_puts(&buf, "    pop rax\n    pop rcx\n"
                                          "    movq xmm0, rcx\n    movq xmm1, rax\n"
                                          "    cvtss2sd xmm0, xmm0\n    cvtss2sd xmm1, xmm1\n    ");
                        asmbuf_puts(&buf, op_s);
                        asmbuf_puts(&buf, " xmm0, xmm1\n");
                        amd_store_fp(&buf, 0);
                    }
                    break;
                }

                case IR_FCMP: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    int op = (int)(I->aux & 0xFF);
                    if (I->aux & IR_AUX_COMPLEX) {
                        amd_unsupported(&buf, "_Complex comparison");
                        break;
                    }
                    if (is_dbl) {
                        amd_pop64(&buf, "rax", "eax");
                        amd_pop64(&buf, "rcx", "ecx");
                        asmbuf_puts(&buf, "    movq xmm0, rcx\n    movq xmm1, rax\n");
                    } else {
                        asmbuf_puts(&buf, "    pop rax\n    pop rcx\n"
                                          "    movq xmm0, rcx\n    movq xmm1, rax\n"
                                          "    cvtss2sd xmm0, xmm0\n    cvtss2sd xmm1, xmm1\n");
                    }
                    amd_fcmp(&buf, op);
                    break;
                }

                case IR_F2I: {
                    int src_dbl = (I->aux & 0x200) != 0;
                    int dst_uns = (I->aux & 0x400) != 0;
                    if (I->aux & IR_AUX_COMPLEX) {
                        amd_unsupported(&buf, "creal/cimag/cabs/carg");
                        break;
                    }
                    if (src_dbl) {
                        amd_pop64(&buf, "rax", "eax");
                        asmbuf_puts(&buf, "    movq xmm0, rax\n");
                    } else {
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm0, rax\n"
                                          "    cvtss2sd xmm0, xmm0\n");
                    }
                    if (dst_uns) {
                        /* The 64-bit form covers the whole unsigned 32-bit
                         * range; the low half is then the answer. */
                        asmbuf_puts(&buf, "    cvttsd2si rax, xmm0\n    mov eax, eax\n");
                    } else {
                        asmbuf_puts(&buf, "    cvttsd2si eax, xmm0\n");
                    }
                    asmbuf_puts(&buf, "    push rax\n");
                    break;
                }

                case IR_I2F: {
                    int dst_dbl = (I->aux & 0x200) != 0;
                    int src_uns = (I->aux & 0x400) != 0;
                    if (I->aux & IR_AUX_COMPLEX) {
                        amd_unsupported(&buf, "real to complex conversion");
                        break;
                    }
                    asmbuf_puts(&buf, "    pop rax\n");
                    if (src_uns)
                        asmbuf_puts(&buf, "    mov eax, eax\n");
                    else
                        asmbuf_puts(&buf, "    movsxd rax, eax\n");
                    asmbuf_puts(&buf, "    cvtsi2sd xmm0, rax\n");
                    amd_store_fp(&buf, dst_dbl);
                    break;
                }

                case IR_F2F: {
                    if (I->aux & 0x200) {
                        /* double -> float */
                        amd_pop64(&buf, "rax", "eax");
                        asmbuf_puts(&buf, "    movq xmm0, rax\n");
                        amd_store_fp(&buf, 0);
                    } else if (I->aux & 0x100) {
                        /* float -> double */
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm0, rax\n"
                                          "    cvtss2sd xmm0, xmm0\n    movq rax, xmm0\n");
                        amd_push64(&buf, "rax", "eax");
                    } else {
                        /* Same width: irgen does not emit it, but keep the
                         * value on the stack if it ever does. */
                    }
                    break;
                }

                case IR_64PUSH:
                    amd_push_imm64(&buf,
                                   ((unsigned long long)(unsigned int)(int)I->val << 32) |
                                   (unsigned int)I->aux);
                    break;

                case IR_64BINARY: {
                    int op = (int)(I->aux & 0xFF);
                    int uns = (I->aux & 0x100) != 0;
                    const char *bop = binop_x(op);
                    amd_pop64(&buf, "rcx", "ecx");   /* b */
                    amd_pop64(&buf, "rax", "eax");   /* a */
                    if (bop) {
                        asmbuf_puts(&buf, "    ");
                        asmbuf_puts(&buf, bop);
                        asmbuf_puts(&buf, " rax, rcx\n");
                        amd_push64(&buf, "rax", "eax");
                    } else if (op == (int)TOK_MUL || op == (int)TOK_DIV ||
                               op == (int)TOK_MOD || op == (int)TOK_SHL ||
                               op == (int)TOK_SHR) {
                        if (op == (int)TOK_MUL) {
                            asmbuf_puts(&buf, "    imul rax, rcx\n");
                        } else if (op == (int)TOK_DIV || op == (int)TOK_MOD) {
                            asmbuf_puts(&buf, uns ? "    xor edx, edx\n    div rcx\n"
                                                  : "    cqo\n    idiv rcx\n");
                            if (op == (int)TOK_MOD)
                                asmbuf_puts(&buf, "    mov rax, rdx\n");
                        } else if (op == (int)TOK_SHL) {
                            asmbuf_puts(&buf, "    shl rax, cl\n");
                        } else {
                            asmbuf_puts(&buf, uns ? "    shr rax, cl\n" : "    sar rax, cl\n");
                        }
                        amd_push64(&buf, "rax", "eax");
                    } else {
                        const char *cc = amd_cc(op, uns);
                        asmbuf_puts(&buf, "    cmp rax, rcx\n    ");
                        asmbuf_puts(&buf, cc);
                        asmbuf_puts(&buf, " al\n    movzx eax, al\n    push rax\n");
                    }
                    break;
                }

                case IR_64CMP: {
                    int op = (int)(I->aux & 0xFF);
                    int uns = (I->aux & 0x100) != 0;
                    const char *cc = amd_cc(op, uns);
                    amd_pop64(&buf, "rcx", "ecx");
                    amd_pop64(&buf, "rax", "eax");
                    asmbuf_puts(&buf, "    cmp rax, rcx\n    ");
                    asmbuf_puts(&buf, cc);
                    asmbuf_puts(&buf, " al\n    movzx eax, al\n    push rax\n");
                    break;
                }

                case IR_64F2I: {
                    int src_dbl = (I->aux & 0x200) != 0;
                    int dst_uns = (I->aux & 0x400) != 0;
                    if (src_dbl) {
                        amd_pop64(&buf, "rax", "eax");
                        asmbuf_puts(&buf, "    movq xmm0, rax\n");
                    } else {
                        asmbuf_puts(&buf, "    pop rax\n    movq xmm0, rax\n"
                                          "    cvtss2sd xmm0, xmm0\n");
                    }
                    if (dst_uns) {
                        asmbuf_puts(&buf, "    mov rax, 0x43E0000000000000\n"
                                          "    movq xmm1, rax\n    ucomisd xmm0, xmm1\n"
                                          "    jb .L");
                        asmbuf_puts(&buf, f->name);
                        asmbuf_puts(&buf, "_u2i");
                        asmbuf_int(&buf, i);
                        asmbuf_puts(&buf, "\n    subsd xmm0, xmm1\n"
                                          "    cvttsd2si rax, xmm0\n"
                                          "    mov rcx, 0x8000000000000000\n"
                                          "    or rax, rcx\n    jmp .L");
                        asmbuf_puts(&buf, f->name);
                        asmbuf_puts(&buf, "_u2id");
                        asmbuf_int(&buf, i);
                        asmbuf_puts(&buf, "\n.L");
                        asmbuf_puts(&buf, f->name);
                        asmbuf_puts(&buf, "_u2i");
                        asmbuf_int(&buf, i);
                        asmbuf_puts(&buf, ":\n    cvttsd2si rax, xmm0\n.L");
                        asmbuf_puts(&buf, f->name);
                        asmbuf_puts(&buf, "_u2id");
                        asmbuf_int(&buf, i);
                        asmbuf_puts(&buf, ":\n");
                    } else {
                        asmbuf_puts(&buf, "    cvttsd2si rax, xmm0\n");
                    }
                    amd_push64(&buf, "rax", "eax");
                    break;
                }

                case IR_64I2F: {
                    int dst_dbl = (I->aux & 0x200) != 0;
                    int src_uns = (I->aux & 0x400) != 0;
                    amd_pop64(&buf, "rax", "eax");
                    if (src_uns) {
                        asmbuf_puts(&buf, "    test rax, rax\n    jns .L");
                        asmbuf_puts(&buf, f->name);
                        asmbuf_puts(&buf, "_i2u");
                        asmbuf_int(&buf, i);
                        asmbuf_puts(&buf, "\n    mov rcx, rax\n    and eax, 1\n"
                                          "    shr rcx, 1\n    or rcx, rax\n"
                                          "    cvtsi2sd xmm0, rcx\n    addsd xmm0, xmm0\n"
                                          "    jmp .L");
                        asmbuf_puts(&buf, f->name);
                        asmbuf_puts(&buf, "_i2ud");
                        asmbuf_int(&buf, i);
                        asmbuf_puts(&buf, "\n.L");
                        asmbuf_puts(&buf, f->name);
                        asmbuf_puts(&buf, "_i2u");
                        asmbuf_int(&buf, i);
                        asmbuf_puts(&buf, ":\n    cvtsi2sd xmm0, rax\n.L");
                        asmbuf_puts(&buf, f->name);
                        asmbuf_puts(&buf, "_i2ud");
                        asmbuf_int(&buf, i);
                        asmbuf_puts(&buf, ":\n");
                    } else {
                        asmbuf_puts(&buf, "    cvtsi2sd xmm0, rax\n");
                    }
                    amd_store_fp(&buf, dst_dbl);
                    break;
                }

                case IR_STORE_FLD: {
                    int bit_off = (int)I->val;
                    int bw = (int)I->aux;
                    unsigned mask = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    asmbuf_puts(&buf, "    pop rax\n    pop rcx\n"
                                      "    mov edx, dword ptr [rcx]\n    and eax, ");
                    asmbuf_int(&buf, (long long)mask);
                    asmbuf_putc(&buf, '\n');
                    if (bit_off > 0) {
                        asmbuf_puts(&buf, "    shl eax, ");
                        asmbuf_int(&buf, bit_off);
                        asmbuf_puts(&buf, "\n    shl edx, ");
                        asmbuf_int(&buf, 32 - bit_off);
                        asmbuf_puts(&buf, "\n    shr edx, ");
                        asmbuf_int(&buf, 32 - bit_off);
                        asmbuf_puts(&buf, "\n    or eax, edx\n");
                    } else {
                        asmbuf_puts(&buf, "    and edx, ");
                        asmbuf_int(&buf, (long long)(unsigned int)~mask);
                        asmbuf_puts(&buf, "\n    or eax, edx\n");
                    }
                    asmbuf_puts(&buf, "    mov dword ptr [rcx], eax\n    push rax\n");
                    break;
                }

                case IR_LOAD_FLD: {
                    int bit_off = (int)I->val;
                    int bw = (int)I->aux;
                    unsigned mask = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    asmbuf_puts(&buf, "    pop rax\n    mov eax, dword ptr [rax]\n");
                    if (bit_off > 0) {
                        asmbuf_puts(&buf, "    shr eax, ");
                        asmbuf_int(&buf, bit_off);
                        asmbuf_putc(&buf, '\n');
                    }
                    asmbuf_puts(&buf, "    and eax, ");
                    asmbuf_int(&buf, (long long)mask);
                    asmbuf_puts(&buf, "\n    push rax\n");
                    break;
                }

                case IR_ASM:
                    if (I->name) {
                        const char *s = I->name;
                        if (s[0] == '@') {
                            s++;
                            while (*s == ' ' || *s == '\t') s++;
                            if (*s == '"') {
                                const char *q = s + 1;
                                while (*q && *q != '"') {
                                    if (*q == '%' && q[1] >= '0' && q[1] <= '9') {
                                        ark_log("[x86-64] error: inline asm operand %%%c cannot be "
                                                "substituted by the x86_64 backend\n", q[1]);
                                        g_amd64_errors++;
                                        break;
                                    }
                                    q++;
                                }
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

                case IR_SVC:
                case IR_SMC:
                case IR_SIMD_ADD16:
                case IR_SIMD_SUB16:
                case IR_SIMD_ADD8:
                case IR_SIMD_SUB8:
                    asmbuf_puts(&buf, "    # ARM-specific op (");
                    asmbuf_puts(&buf, ir_op_name(I->op));
                    asmbuf_puts(&buf, ") - not applicable on x86-64\n");
                    break;

                default:
                    asmbuf_puts(&buf, "    # unknown IR op: ");
                    asmbuf_puts(&buf, ir_op_name(I->op));
                    asmbuf_putc(&buf, '\n');
                    break;
            }
        }
        if (body_ok) {
            if (sret_used)
                asmbuf_puts(&buf, "    mov rax, qword ptr [rbp-8]\n");
            else
                asmbuf_puts(&buf, "    xor eax, eax\n");
            asmbuf_puts(&buf, "    mov rsp, rbp\n    pop rbp\n    ret\n\n");
        } else {
            asmbuf_puts(&buf, "    mov rsp, rbp\n    pop rbp\n    ret\n\n");
        }
    }

    {
        int n = buf.len;
        int i;
        int errs = g_amd64_errors;
        g_amd64_errors = 0;
        if (errs) {
            ark_log("[x86-64] error: %d unsupported construct(s), no output written\n", errs);
            if (cap > 0) out[0] = 0;
            return -1;
        }
        if (n + 1 > cap) n = cap - 1;
        for (i = 0; i < n; i++) out[i] = buf.buf[i];
        out[n] = 0;
        return n;
    }
}

static int amd64_emit_sysv(IrProgram *prog, char *out, int cap) {
    return amd64_emit_internal(prog, out, cap);
}

/* === Built-in x86 32-bit assembler ===
 *
 * Encodes Intel-syntax (.intel_syntax noprefix) assembly text into x86
 * machine code. Two-pass design: pass1 computes instruction sizes and
 * collects label addresses; pass2 emits bytes and records forward refs;
 * resolve_refs patches the refs. All jumps use near (4-byte disp32) form
 * so pass1 sizes are fixed regardless of branch distance.
 *
 * Relocation types (for cross-object refs, consumed by the ARKOBJ2 linker):
 *   4 = absolute 32-bit address (R_386_32, same encoding as ARM R_ARM_ABS32)
 *   5 = PC-relative 32-bit disp  (R_386_PC32, for jmp/call/jcc disp32) */

typedef struct { char *name; int addr; int is_weak; } X86AsmLabel;
typedef struct { int pc; char *name; int type; } X86AsmRef;

typedef struct {
    const char    *src;
    unsigned char *out;
    int            pc;
    int            out_cap;
    X86AsmLabel   *labels;
    int            label_count, label_cap;
    X86AsmRef     *refs;
    int            ref_count, ref_cap;
    int            error_count;
    int            cur_section;  /* 0=.text, 1=.data, 2=.rodata */
    int            pending_weak;
    int            dry_run;      /* 1=pass1 (count only), 0=pass2 (emit) */
    int            mode64;       /* 1=AMD64 encoding (REX + rip-relative) */
} X86Asm;

/* Set while xa_process_line runs, so the operand parsers can accept the
 * AMD64-only register names without threading X86Asm through every call. */
static int g_xa64 = 0;

/* Operand kinds */
enum { XOP_NONE, XOP_REG, XOP_IMM, XOP_MEM };

typedef struct {
    int  kind;
    int  reg;        /* register code 0-7 (XOP_REG) */
    int  reg_size;   /* 1=byte, 2=word, 4=dword (XOP_REG) */
    long long imm;   /* immediate value (XOP_IMM) */
    /* memory: [base + index*scale + disp] or [symbol] */
    int  base;       /* base register code, -1=none (XOP_MEM) */
    int  index;      /* index register code, -1=none (XOP_MEM) */
    int  scale;      /* 1,2,4,8 (XOP_MEM) */
    int  disp;       /* displacement (XOP_MEM) */
    int  has_sym;    /* 1 if [symbol] (XOP_MEM) */
    char sym[64];    /* symbol name (XOP_MEM) */
    int  mem_size;   /* 0=auto, 1=byte, 2=word, 4=dword (from size prefix) */
} X86Operand;

/* --- character / token helpers --- */
static int xa_is_alpha(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_' || c == '.';
}
static int xa_is_alnum(char c) {
    return xa_is_alpha(c) || (c >= '0' && c <= '9');
}
static int xa_is_space(char c) { return c == ' ' || c == '\t' || c == '\r'; }
static int xa_toupper(int c) { return (c >= 'a' && c <= 'z') ? c - 'a' + 'A' : c; }
static int xa_strieq(const char *a, const char *b) {
    while (*a && *b) { if (xa_toupper(*a) != xa_toupper(*b)) return 0; a++; b++; }
    return *a == 0 && *b == 0;
}
/* Case-insensitive prefix check: does *p start with prefix (followed by space
 * or '[')?  Needed because xa_strieq requires exact match but "dword ptr [...]"
 * has trailing content after "dword". */
static int xa_starts_with(const char *p, const char *prefix) {
    while (*prefix) {
        if (xa_toupper(*p) != xa_toupper(*prefix)) return 0;
        p++; prefix++;
    }
    return 1;
}
static void xa_skip_space(const char **p) { while (xa_is_space(**p)) (*p)++; }
static void xa_skip_to_eol(const char **p) { while (**p && **p != '\n') (*p)++; }

/* Read a word (mnemonic, directive, or label name). */
static int xa_read_word(const char **p, char *out, int cap) {
    int n = 0;
    xa_skip_space(p);
    while (**p && xa_is_alnum(**p) && n < cap - 1) { out[n++] = **p; (*p)++; }
    out[n] = 0;
    return n;
}

/* --- label / ref management --- */
static void xa_add_label(X86Asm *a, const char *name, int addr) {
    if (a->label_count >= a->label_cap) {
        int nc = a->label_cap == 0 ? 64 : a->label_cap * 2;
        a->labels = (X86AsmLabel *)mem_realloc(a->labels,
            a->label_cap * (int)sizeof(X86AsmLabel), nc * (int)sizeof(X86AsmLabel));
        a->label_cap = nc;
    }
    a->labels[a->label_count].name = mem_strdup(name);
    a->labels[a->label_count].addr = addr;
    a->labels[a->label_count].is_weak = a->pending_weak;
    a->pending_weak = 0;
    a->label_count++;
}
static int xa_find_label(X86Asm *a, const char *name) {
    int i;
    for (i = 0; i < a->label_count; i++)
        if (ark_streq(a->labels[i].name, name)) return a->labels[i].addr;
    return -1;
}
static void xa_add_ref(X86Asm *a, int pc, const char *name, int type) {
    if (a->ref_count >= a->ref_cap) {
        int nc = a->ref_cap == 0 ? 64 : a->ref_cap * 2;
        a->refs = (X86AsmRef *)mem_realloc(a->refs,
            a->ref_cap * (int)sizeof(X86AsmRef), nc * (int)sizeof(X86AsmRef));
        a->ref_cap = nc;
    }
    a->refs[a->ref_count].pc = pc;
    a->refs[a->ref_count].name = mem_strdup(name);
    a->refs[a->ref_count].type = type;
    a->ref_count++;
}

/* --- byte emission (respects dry_run) --- */
static void xa_emit(X86Asm *a, unsigned char b) {
    if (!a->dry_run && a->pc < a->out_cap) a->out[a->pc] = b;
    a->pc++;
}
static void xa_emit16(X86Asm *a, int v) {
    xa_emit(a, (unsigned char)(v & 0xFF));
    xa_emit(a, (unsigned char)((v >> 8) & 0xFF));
}
static void xa_emit32(X86Asm *a, int v) {
    xa_emit(a, (unsigned char)(v & 0xFF));
    xa_emit(a, (unsigned char)((v >> 8) & 0xFF));
    xa_emit(a, (unsigned char)((v >> 16) & 0xFF));
    xa_emit(a, (unsigned char)((v >> 24) & 0xFF));
}
static void xa_emit64(X86Asm *a, long long v) {
    xa_emit32(a, (int)(v & 0xFFFFFFFFLL));
    xa_emit32(a, (int)((v >> 32) & 0xFFFFFFFFLL));
}

/* Emit a REX prefix when needed.  In 32-bit mode this is a no-op, so the
 * i386 output stays byte-for-byte identical.  w = REX.W (64-bit operand),
 * regf = ModR/M.reg register code, base/index = rm operand register codes. */
static void xa_rex(X86Asm *a, int w, int regf, int base, int index) {
    int r, x, b;
    if (!a->mode64) return;
    r = (regf >= 8);
    x = (index >= 8);
    b = (base >= 8);
    if (!w && !r && !x && !b) return;
    xa_emit(a, (unsigned char)(0x40 | (w ? 8 : 0) | (r ? 4 : 0) | (x ? 2 : 0) | (b ? 1 : 0)));
}
/* REX for an instruction whose rm operand is a memory operand (or a reg). */
static void xa_rex_rm(X86Asm *a, int w, int regf, X86Operand *rm) {
    int base = -1, index = -1;
    if (rm->kind == XOP_MEM) { base = rm->base; index = rm->index; }
    else if (rm->kind == XOP_REG) { base = rm->reg; }
    xa_rex(a, w, regf, base, index);
}
/* Operand width in bytes (0 = unknown). */
static int xa_opsize(X86Operand *op) {
    if (op->kind == XOP_REG) return op->reg_size;
    if (op->kind == XOP_MEM) return op->mem_size;
    return 0;
}
/* 1 if either operand is a 64-bit GPR / 8-byte memory operand. */
static int xa_is64(X86Operand *x, X86Operand *y) {
    return xa_opsize(x) == 8 || xa_opsize(y) == 8;
}

/* --- register parsing ---
 * Returns register code (0-7), sets *size (1=byte,2=word,4=dword), or -1.
 * 32-bit: eax=0,ecx=1,edx=2,ebx=3,esp=4,ebp=5,esi=6,edi=7
 * 16-bit: ax=0,cx=1,dx=2,bx=3,sp=4,bp=5,si=6,di=7
 * 8-bit:  al=0,cl=1,dl=2,bl=3,ah=4,ch=5,dh=6,bh=7 */
static int xa_parse_reg(const char **p, int *size) {
    char w[8];
    int n = 0;
    const char *s = *p;
    xa_skip_space(p);
    s = *p;
    while (xa_is_alnum(**p) && n < (int)sizeof(w) - 1) { w[n++] = **p; (*p)++; }
    w[n] = 0;
    if (n == 0) return -1;
    /* --- AMD64-only register names (gated so i386 output is unchanged) --- */
    if (g_xa64) {
        /* xmm0 .. xmm15 : reg_size 16 marks "SSE register" for the emitter */
        if (n >= 4 && w[0] == 'x' && w[1] == 'm' && w[2] == 'm') {
            int i = 3, v = 0, digits = 0;
            while (i < n && w[i] >= '0' && w[i] <= '9') { v = v * 10 + (w[i] - '0'); i++; digits++; }
            if (i == n && digits >= 1 && v <= 15) { *size = 16; return v; }
        }
        /* r8 .. r15 (with optional d / w / b suffix) */
        if (w[0] == 'r' && n >= 2 && n <= 4) {
            int i = 1, v = 0, digits = 0;
            int sfx = 0;  /* 0=none(64), 'd'=32, 'w'=16, 'b'=8 */
            while (i < n && w[i] >= '0' && w[i] <= '9') { v = v * 10 + (w[i] - '0'); i++; digits++; }
            if (digits >= 1 && i < n) {
                if (i == n - 1) {
                    if (w[i] == 'd') sfx = 4;
                    else if (w[i] == 'w') sfx = 2;
                    else if (w[i] == 'b') sfx = 1;
                    else sfx = -1;
                } else sfx = -1;
                i = n;
            }
            if (digits >= 1 && i == n && sfx >= 0 && v >= 8 && v <= 15) {
                *size = sfx ? sfx : 8;
                return v;
            }
        }
        /* rax rcx rdx rbx rsp rbp rsi rdi  (rip is not a general register) */
        if (n == 3 && w[0] == 'r') {
            if (w[1] == 'a' && w[2] == 'x') { *size = 8; return 0; }
            if (w[1] == 'c' && w[2] == 'x') { *size = 8; return 1; }
            if (w[1] == 'd' && w[2] == 'x') { *size = 8; return 2; }
            if (w[1] == 'b' && w[2] == 'x') { *size = 8; return 3; }
            if (w[1] == 's' && w[2] == 'p') { *size = 8; return 4; }
            if (w[1] == 'b' && w[2] == 'p') { *size = 8; return 5; }
            if (w[1] == 's' && w[2] == 'i') { *size = 8; return 6; }
            if (w[1] == 'd' && w[2] == 'i') { *size = 8; return 7; }
            if (w[1] == 'i' && w[2] == 'p') { *p = s; return -1; }
        }
    }
    /* 32-bit registers (3 chars).  This used to test w[1]=='a' only, i.e. it
     * recognised eax and nothing else, so a line as ordinary as
     * "mov ecx, [rbp-8]" failed to parse and the emitter reported
     * "unsupported mov operand combination".  Match the whole name. */
    if (n == 3 && w[0] == 'e') {
        if (w[1] == 'a' && w[2] == 'x') { *size = 4; return 0; }
        if (w[1] == 'c' && w[2] == 'x') { *size = 4; return 1; }
        if (w[1] == 'd' && w[2] == 'x') { *size = 4; return 2; }
        if (w[1] == 'b' && w[2] == 'x') { *size = 4; return 3; }
        if (w[1] == 's' && w[2] == 'p') { *size = 4; return 4; }
        if (w[1] == 'b' && w[2] == 'p') { *size = 4; return 5; }
        if (w[1] == 's' && w[2] == 'i') { *size = 4; return 6; }
        if (w[1] == 'd' && w[2] == 'i') { *size = 4; return 7; }
    }
    /* 16-bit registers (2 chars) */
    if (n == 2) {
        if (w[0] == 'a' && w[1] == 'x') { *size = 2; return 0; }
        if (w[0] == 'c' && w[1] == 'x') { *size = 2; return 1; }
        if (w[0] == 'd' && w[1] == 'x') { *size = 2; return 2; }
        if (w[0] == 'b' && w[1] == 'x') { *size = 2; return 3; }
        if (w[0] == 's' && w[1] == 'p') { *size = 2; return 4; }
        if (w[0] == 'b' && w[1] == 'p') { *size = 2; return 5; }
        if (w[0] == 's' && w[1] == 'i') { *size = 2; return 6; }
        if (w[0] == 'd' && w[1] == 'i') { *size = 2; return 7; }
    }
    /* 8-bit registers (2 chars) */
    if (n == 2) {
        if (w[0] == 'a' && w[1] == 'l') { *size = 1; return 0; }
        if (w[0] == 'c' && w[1] == 'l') { *size = 1; return 1; }
        if (w[0] == 'd' && w[1] == 'l') { *size = 1; return 2; }
        if (w[0] == 'b' && w[1] == 'l') { *size = 1; return 3; }
        if (w[0] == 'a' && w[1] == 'h') { *size = 1; return 4; }
        if (w[0] == 'c' && w[1] == 'h') { *size = 1; return 5; }
        if (w[0] == 'd' && w[1] == 'h') { *size = 1; return 6; }
        if (w[0] == 'b' && w[1] == 'h') { *size = 1; return 7; }
    }
    /* Not a register - restore position */
    *p = s;
    return -1;
}

/* --- immediate parsing ---
 * Handles decimal, hex (0x), and leading '-' / '+'. */
static int xa_parse_imm(const char **p, long long *out) {
    long long v = 0;
    int neg = 0;
    xa_skip_space(p);
    if (**p == '+') (*p)++;
    if (**p == '-') { neg = 1; (*p)++; }
    if (**p == '0' && ((*p)[1] == 'x' || (*p)[1] == 'X')) {
        (*p) += 2;
        if (!( (**p >= '0' && **p <= '9') ||
               (**p >= 'a' && **p <= 'f') ||
               (**p >= 'A' && **p <= 'F') )) return 0;
        while ((**p >= '0' && **p <= '9') ||
               (**p >= 'a' && **p <= 'f') ||
               (**p >= 'A' && **p <= 'F')) {
            char c = **p;
            int dv = (c >= '0' && c <= '9') ? c - '0' :
                     (c >= 'a' && c <= 'f') ? c - 'a' + 10 : c - 'A' + 10;
            v = v * 16 + dv;
            (*p)++;
        }
    } else if (**p >= '0' && **p <= '9') {
        while (**p >= '0' && **p <= '9') { v = v * 10 + (**p - '0'); (*p)++; }
    } else {
        return 0;
    }
    /* skip suffixes (u, l, L) */
    while (**p == 'u' || **p == 'U' || **p == 'l' || **p == 'L') (*p)++;
    *out = neg ? -v : v;
    return 1;
}

/* Parse a register-or-symbol name (for labels in jmp/call). */
static int xa_read_ident(const char **p, char *out, int cap) {
    int n = 0;
    xa_skip_space(p);
    if (**p == '.') {
        while (xa_is_alnum(**p) && n < cap - 1) { out[n++] = **p; (*p)++; }
    } else if (xa_is_alpha(**p)) {
        while (xa_is_alnum(**p) && n < cap - 1) { out[n++] = **p; (*p)++; }
    }
    out[n] = 0;
    return n;
}

/* --- memory operand parsing ---
 * Parses [base+index*scale+disp] or [symbol]. Handles optional
 * size prefix (dword ptr / byte ptr / word ptr) before the bracket. */
static int xa_parse_mem(const char **p, X86Operand *op) {
    xa_skip_space(p);
    op->mem_size = 0;
    /* Check for size prefix: "dword ptr" / "byte ptr" / "word ptr" */
    {
        const char *save = *p;
        if (xa_starts_with(*p, "dword")) {
            *p += 5; xa_skip_space(p);
            if (xa_starts_with(*p, "ptr")) { *p += 3; xa_skip_space(p); op->mem_size = 4; }
            else { *p = save; }
        } else if (xa_starts_with(*p, "byte")) {
            *p += 4; xa_skip_space(p);
            if (xa_starts_with(*p, "ptr")) { *p += 3; xa_skip_space(p); op->mem_size = 1; }
            else { *p = save; }
        } else if (xa_starts_with(*p, "word")) {
            *p += 4; xa_skip_space(p);
            if (xa_starts_with(*p, "ptr")) { *p += 3; xa_skip_space(p); op->mem_size = 2; }
            else { *p = save; }
        } else if (g_xa64 && xa_starts_with(*p, "qword")) {
            *p += 5; xa_skip_space(p);
            if (xa_starts_with(*p, "ptr")) { *p += 3; xa_skip_space(p); op->mem_size = 8; }
            else { *p = save; }
        }
    }
    if (**p != '[') return 0;
    (*p)++;
    op->kind = XOP_MEM;
    op->base = -1;
    op->index = -1;
    op->scale = 1;
    op->disp = 0;
    op->has_sym = 0;
    op->sym[0] = 0;

    /* Parse interior: sequence of terms separated by + or - */
    {
        int sign = 1;  /* +1 for '+' prefix, -1 for '-' */
        int got_term = 0;
        for (;;) {
            xa_skip_space(p);
            if (**p == ']') { (*p)++; break; }
            if (**p == '+') { sign = 1; (*p)++; xa_skip_space(p); continue; }
            if (**p == '-') { sign = -1; (*p)++; xa_skip_space(p); continue; }
            /* Try register */
            {
                int rsize;
                const char *save = *p;
                int rc = xa_parse_reg(p, &rsize);
                if (rc >= 0) {
                    /* Check for *scale */
                    xa_skip_space(p);
                    if (**p == '*') {
                        (*p)++;
                        xa_skip_space(p);
                        {
                            long long sc;
                            if (!xa_parse_imm(p, &sc)) sc = 1;
                            op->index = rc;
                            op->scale = (int)sc;
                        }
                    } else {
                        if (op->base < 0 && sign > 0) op->base = rc;
                        else if (op->index < 0) { op->index = rc; op->scale = 1; }
                        else { *p = save; break; } /* too many regs */
                    }
                    sign = 1;
                    got_term = 1;
                    continue;
                }
            }
            /* Try immediate (displacement) */
            {
                long long v;
                const char *save = *p;
                if (xa_parse_imm(p, &v)) {
                    op->disp += (int)(sign * v);
                    sign = 1;
                    got_term = 1;
                    continue;
                }
                /* Try symbol name */
                {
                    char name[64];
                    const char *sv2 = *p;
                    if (xa_read_ident(p, name, (int)sizeof(name)) && name[0]) {
                        /* If this is the first term and no base/index, it's [symbol] */
                        if (!got_term && op->base < 0 && op->index < 0) {
                            /* Check if next char is ']' or '+' or '-' */
                            xa_skip_space(p);
                            if (**p == ']' || **p == '+' || **p == '-') {
                                op->has_sym = 1;
                                /* copy symbol name */
                                {
                                    int k;
                                    for (k = 0; name[k] && k < (int)sizeof(op->sym) - 1; k++)
                                        op->sym[k] = name[k];
                                    op->sym[k] = 0;
                                }
                                sign = 1;
                                got_term = 1;
                                continue;
                            }
                        }
                        /* symbol + disp: treat symbol as disp32 reference */
                        op->has_sym = 1;
                        {
                            int k;
                            for (k = 0; name[k] && k < (int)sizeof(op->sym) - 1; k++)
                                op->sym[k] = name[k];
                            op->sym[k] = 0;
                        }
                        sign = 1;
                        got_term = 1;
                        continue;
                    }
                    *p = sv2;
                }
                *p = save;
            }
            break;  /* unrecognized token */
        }
    }
    return 1;
}

/* Parse one operand (register, immediate, or memory). */
static int xa_parse_operand(const char **p, X86Operand *op) {
    xa_skip_space(p);
    if (**p == 0 || **p == '\n' || **p == ',') return 0;
    /* Try memory operand (with optional size prefix) */
    if (**p == '[' || xa_starts_with(*p, "dword") || xa_starts_with(*p, "byte") ||
        xa_starts_with(*p, "word") || (g_xa64 && xa_starts_with(*p, "qword"))) {
        return xa_parse_mem(p, op);
    }
    /* Try register */
    {
        int rsize;
        const char *save = *p;
        int rc = xa_parse_reg(p, &rsize);
        if (rc >= 0) {
            op->kind = XOP_REG;
            op->reg = rc;
            op->reg_size = rsize;
            return 1;
        }
        *p = save;
    }
    /* Try immediate */
    {
        long long v;
        if (xa_parse_imm(p, &v)) {
            op->kind = XOP_IMM;
            op->imm = v;
            return 1;
        }
    }
    /* Try label/symbol (for jmp/call targets) */
    {
        char name[64];
        if (xa_read_ident(p, name, (int)sizeof(name)) && name[0]) {
            op->kind = XOP_MEM;
            op->base = -1;
            op->index = -1;
            op->scale = 1;
            op->disp = 0;
            op->has_sym = 1;
            {
                int k;
                for (k = 0; name[k] && k < (int)sizeof(op->sym) - 1; k++)
                    op->sym[k] = name[k];
                op->sym[k] = 0;
            }
            op->mem_size = 0;
            return 1;
        }
    }
    return 0;
}

/* --- ModR/M encoding --- */
/* Emit ModR/M for reg-reg (mod=11). */
static void xa_modrm_reg(X86Asm *a, int reg, int rm) {
    xa_emit(a, (unsigned char)(0xC0 | ((reg & 7) << 3) | (rm & 7)));
}

/* Emit ModR/M + optional SIB + displacement for a memory operand.
 * reg_field is the /r field (register or opcode extension). */
static void xa_modrm_mem(X86Asm *a, int reg_field, X86Operand *mem) {
    int base = mem->base;
    int index = mem->index;
    int disp = mem->disp;
    /* rsp/r12 as base, or rbp/r13 as base with mod==0, need the (base&7) test. */
    int needs_sib = (base >= 0 && (base & 7) == 4) || (index >= 0);

    /* [symbol] with no base/index: mod=00, rm=101, disp32 = symbol addr */
    if (mem->has_sym && base < 0 && index < 0) {
        if (disp != 0) {
            /* RIP-relative relocations carry no addend in this object format,
             * so [sym+32] cannot be encoded; refuse instead of guessing. */
            a->error_count++;
            diag_tool(DIAG_SEV_ERROR, "arkcc", "[symbol+disp] is not supported", 0,0,0,0,0,0);
            return;
        }
        /* In 64-bit mode mod=00 rm=101 means RIP-relative: the disp32 field is
         * patched by the same reloc type 5 (target-(pc+4)) the linker already
         * implements, which is exactly the RIP-relative semantic. */
        xa_emit(a, (unsigned char)(((reg_field & 7) << 3) | 5));
        xa_add_ref(a, a->pc, mem->sym, a->mode64 ? 5 : 4);
        xa_emit32(a, 0);  /* placeholder; patched by resolve_refs */
        return;
    }
    /* [symbol + base]: symbol contributes to disp32 (absolute reloc). */
    if (mem->has_sym && base >= 0) {
        xa_emit(a, (unsigned char)((0x02 << 6) | ((reg_field & 7) << 3) | (needs_sib ? 4 : (base & 7))));
        if (needs_sib) {
            int sb = (base >= 0) ? base : 5;
            int si = (index >= 0) ? index : 4;
            int sc = (mem->scale == 2) ? 1 : (mem->scale == 4) ? 2 : (mem->scale == 8) ? 3 : 0;
            xa_emit(a, (unsigned char)((sc << 6) | ((si & 7) << 3) | (sb & 7)));
        }
        xa_add_ref(a, a->pc, mem->sym, 4);
        xa_emit32(a, disp);
        return;
    }

    /* Determine mod field */
    {
        int mod;
        if (disp == 0 && !(base >= 0 && (base & 7) == 5)) {
            mod = 0;
        } else if (disp >= -128 && disp <= 127) {
            mod = 1;
        } else {
            mod = 2;
        }
        /* ebp/r13 (base&7 == 5) needs at least mod=01 (mod=00 rm=101 = [disp32]) */
        if (base >= 0 && (base & 7) == 5 && mod == 0) mod = 1;

        if (needs_sib) {
            int sb = (base >= 0) ? base : 5;  /* 5 in mod=00 means no base (disp32) */
            int si = (index >= 0) ? index : 4;  /* 4 = no index */
            int sc = (mem->scale == 2) ? 1 : (mem->scale == 4) ? 2 : (mem->scale == 8) ? 3 : 0;
            xa_emit(a, (unsigned char)((mod << 6) | ((reg_field & 7) << 3) | 4));
            xa_emit(a, (unsigned char)((sc << 6) | ((si & 7) << 3) | (sb & 7)));
        } else {
            xa_emit(a, (unsigned char)((mod << 6) | ((reg_field & 7) << 3) | (base & 7)));
        }
        if (mod == 1) {
            xa_emit(a, (unsigned char)(disp & 0xFF));
        } else if (mod == 2) {
            xa_emit32(a, disp);
        }
    }
}

/* --- ALU instruction emitter (add/sub/cmp/and/or/xor/adc/sbb) ---
 * op_rm_r:  r/m, r form opcode (e.g. 0x01 for add)
 * op_r_rm:  r, r/m form opcode (e.g. 0x03 for add)
 * op_eax:   eax, imm32 special opcode (e.g. 0x05 for add)
 * sub_op:   /n extension (0=add, 1=or, 4=and, 5=sub, 6=xor, 7=cmp) */
static int xa_imm_fits32(long long v) {
    return v >= -2147483648LL && v <= 2147483647LL;
}

static void xa_alu(X86Asm *a, int op_rm_r, int op_r_rm, int op_eax, int sub_op,
                   X86Operand *dst, X86Operand *src) {
    int w = xa_is64(dst, src) ? 1 : 0;
    if (dst->kind == XOP_REG && src->kind == XOP_REG) {
        xa_rex(a, w, src->reg, dst->reg, -1);
        xa_emit(a, (unsigned char)op_rm_r);
        xa_modrm_reg(a, src->reg, dst->reg);
    } else if (dst->kind == XOP_REG && src->kind == XOP_IMM) {
        long long imm = src->imm;
        if (!xa_imm_fits32(imm)) {
            /* 0x81 takes an imm32 that is sign-extended; silently truncating a
             * wider constant would produce a wrong answer, so refuse. */
            a->error_count++;
            diag_tool(DIAG_SEV_ERROR, "arkcc", "immediate out of 32-bit range for alu op", 0,0,0,0,0,0);
            return;
        }
        if (imm >= -128 && imm <= 127) {
            xa_rex(a, w, sub_op, dst->reg, -1);
            xa_emit(a, 0x83);
            xa_modrm_reg(a, sub_op, dst->reg);
            xa_emit(a, (unsigned char)(imm & 0xFF));
        } else if ((dst->reg & 7) == 0) {  /* eax/rax */
            xa_rex(a, w, 0, dst->reg, -1);
            xa_emit(a, (unsigned char)op_eax);
            xa_emit32(a, (int)imm);
        } else {
            xa_rex(a, w, sub_op, dst->reg, -1);
            xa_emit(a, 0x81);
            xa_modrm_reg(a, sub_op, dst->reg);
            xa_emit32(a, (int)imm);
        }
    } else if (dst->kind == XOP_REG && src->kind == XOP_MEM) {
        xa_rex_rm(a, w, dst->reg, src);
        xa_emit(a, (unsigned char)op_r_rm);
        xa_modrm_mem(a, dst->reg, src);
    } else if (dst->kind == XOP_MEM && src->kind == XOP_REG) {
        xa_rex_rm(a, w, src->reg, dst);
        xa_emit(a, (unsigned char)op_rm_r);
        xa_modrm_mem(a, src->reg, dst);
    } else if (dst->kind == XOP_MEM && src->kind == XOP_IMM) {
        long long imm = src->imm;
        if (!xa_imm_fits32(imm)) {
            a->error_count++;
            diag_tool(DIAG_SEV_ERROR, "arkcc", "immediate out of 32-bit range for alu op", 0,0,0,0,0,0);
            return;
        }
        if (imm >= -128 && imm <= 127) {
            xa_rex_rm(a, w, sub_op, dst);
            xa_emit(a, 0x83);
            xa_modrm_mem(a, sub_op, dst);
            xa_emit(a, (unsigned char)(imm & 0xFF));
        } else {
            xa_rex_rm(a, w, 0, dst);
            xa_emit(a, 0xC7);
            xa_modrm_mem(a, 0, dst);
            xa_emit32(a, (int)imm);
        }
    } else {
        a->error_count++;
    }
}

/* Emit a branch (jmp/call/jcc) with a label operand.
 * opcode2 is 0 for single-byte opcodes (E8/E9), or the second byte for 0F-prefixed jcc. */
static void xa_branch(X86Asm *a, unsigned char op1, unsigned char op2, const char *label) {
    int disp_pc;
    if (op2) {
        xa_emit(a, 0x0F);
        xa_emit(a, op2);
    } else {
        xa_emit(a, op1);
    }
    disp_pc = a->pc;
    xa_add_ref(a, disp_pc, label, 5);  /* type 5: PC-relative disp32 */
    xa_emit32(a, 0);  /* placeholder */
}

/* Parse a string literal ".asciz" / ".ascii" content and emit bytes. */
static void xa_emit_string(X86Asm *a, const char **p, int with_nul) {
    xa_skip_space(p);
    if (**p != '"') return;
    (*p)++;
    while (**p && **p != '"' && **p != '\n') {
        if (**p == '\\') {
            (*p)++;
            switch (**p) {
                case 'n':  xa_emit(a, '\n'); (*p)++; break;
                case 't':  xa_emit(a, '\t'); (*p)++; break;
                case 'r':  xa_emit(a, '\r'); (*p)++; break;
                case '0':  xa_emit(a, 0);    (*p)++; break;
                case '\\': xa_emit(a, '\\'); (*p)++; break;
                case '"':  xa_emit(a, '"');  (*p)++; break;
                case 'x': {
                    int v = 0; (*p)++;
                    while (**p) {
                        int dv;
                        if (**p >= '0' && **p <= '9') dv = **p - '0';
                        else if (**p >= 'a' && **p <= 'f') dv = **p - 'a' + 10;
                        else if (**p >= 'A' && **p <= 'F') dv = **p - 'A' + 10;
                        else break;
                        v = v * 16 + dv; (*p)++;
                    }
                    xa_emit(a, (unsigned char)v);
                    break;
                }
                default: xa_emit(a, (unsigned char)**p); (*p)++; break;
            }
        } else {
            xa_emit(a, (unsigned char)**p);
            (*p)++;
        }
    }
    if (**p == '"') (*p)++;
    if (with_nul) xa_emit(a, 0);
}

/* Emit a .byte/.word/.long/.quad value (numeric or symbol reference). */
static void xa_emit_data(X86Asm *a, const char **p, int size) {
    xa_skip_space(p);
    {
        long long v;
        const char *save = *p;
        if (xa_parse_imm(p, &v)) {
            if (size == 1) xa_emit(a, (unsigned char)(v & 0xFF));
            else if (size == 2) xa_emit16(a, (int)v);
            else if (size == 4) xa_emit32(a, (int)v);
            else { xa_emit32(a, (int)v); xa_emit32(a, 0); }
        } else {
            /* Symbol reference (for .long symbol etc.) */
            char name[64];
            *p = save;
            if (xa_read_ident(p, name, (int)sizeof(name)) && name[0]) {
                if (size == 4) {
                    xa_add_ref(a, a->pc, name, 4);
                    xa_emit32(a, 0);
                } else if (size == 8) {
                    xa_add_ref(a, a->pc, name, 4);
                    xa_emit32(a, 0);
                    xa_emit32(a, 0);
                } else {
                    xa_emit(a, 0);
                }
            }
        }
    }
}

/* ============================ AMD64 emission helpers ======================
 * These exist so the instruction dispatch chain below stays readable while
 * still handling both the i386 (mode64==0) and the AMD64 (mode64==1) forms.
 * Every REX emission is a no-op in 32-bit mode, so the i386 output stays
 * byte-for-byte identical to what this assembler produced before. */

/* movq: xmm <-> gpr64, xmm <-> m64, xmm <-> xmm. */
static void xa_emit_movq(X86Asm *a, X86Operand *d, X86Operand *s) {
    int d_xmm = (d->kind == XOP_REG && d->reg_size == 16);
    int s_xmm = (s->kind == XOP_REG && s->reg_size == 16);
    if (d_xmm && s_xmm) {
        /* F3 0F 7E /r : movq xmm, xmm */
        xa_emit(a, 0xF3);
        xa_rex(a, 0, d->reg, s->reg, -1);
        xa_emit(a, 0x0F); xa_emit(a, 0x7E);
        xa_modrm_reg(a, d->reg, s->reg);
    } else if (d_xmm && s->kind == XOP_REG) {
        /* 66 REX.W 0F 6E /r : movq xmm, r64 */
        xa_emit(a, 0x66);
        xa_rex(a, 1, d->reg, s->reg, -1);
        xa_emit(a, 0x0F); xa_emit(a, 0x6E);
        xa_modrm_reg(a, d->reg, s->reg);
    } else if (d_xmm && s->kind == XOP_MEM) {
        /* F3 0F 7E /r : movq xmm, m64 */
        xa_emit(a, 0xF3);
        xa_rex_rm(a, 0, d->reg, s);
        xa_emit(a, 0x0F); xa_emit(a, 0x7E);
        xa_modrm_mem(a, d->reg, s);
    } else if (d->kind == XOP_REG && s_xmm) {
        /* 66 REX.W 0F 7E /r : movq r64, xmm */
        xa_emit(a, 0x66);
        xa_rex(a, 1, s->reg, d->reg, -1);
        xa_emit(a, 0x0F); xa_emit(a, 0x7E);
        xa_modrm_reg(a, s->reg, d->reg);
    } else if (d->kind == XOP_MEM && s_xmm) {
        /* 66 0F D6 /r : movq m64, xmm */
        xa_emit(a, 0x66);
        xa_rex_rm(a, 0, s->reg, d);
        xa_emit(a, 0x0F); xa_emit(a, 0xD6);
        xa_modrm_mem(a, s->reg, d);
    } else {
        a->error_count++;
        diag_tool(DIAG_SEV_ERROR, "arkcc", "movq needs an xmm operand", 0,0,0,0,0,0);
    }
}

/* SSE/SSE2 two-operand instruction: legacy prefix + optional REX + 0F op2. */
static void xa_sse(X86Asm *a, int pfx, int op2, X86Operand *d, X86Operand *s) {
    int w = xa_is64(d, s) ? 1 : 0;
    int regf = (d->kind == XOP_REG) ? d->reg : 0;
    xa_emit(a, (unsigned char)pfx);
    xa_rex_rm(a, w, regf, s);
    xa_emit(a, 0x0F);
    xa_emit(a, (unsigned char)op2);
    if (s->kind == XOP_REG) xa_modrm_reg(a, regf, s->reg);
    else xa_modrm_mem(a, regf, s);
}

/* Shift / rotate group 2: ext=4 shl, 5 shr, 7 sar. */
static void xa_shift(X86Asm *a, int ext, X86Operand *d, X86Operand *s) {
    int w = (xa_opsize(d) == 8) ? 1 : 0;
    int by_cl = (s->kind == XOP_REG && s->reg_size == 1 && (s->reg & 7) == 1);
    if (by_cl) {
        xa_rex_rm(a, w, ext, d);
        xa_emit(a, 0xD3);
    } else if (s->kind == XOP_IMM) {
        xa_rex_rm(a, w, ext, d);
        xa_emit(a, 0xC1);
    } else {
        a->error_count++;
        diag_tool(DIAG_SEV_ERROR, "arkcc", "shift needs cl or an immediate", 0,0,0,0,0,0);
        return;
    }
    if (d->kind == XOP_REG) xa_modrm_reg(a, ext, d->reg);
    else xa_modrm_mem(a, ext, d);
    if (!by_cl) xa_emit(a, (unsigned char)(s->imm & 0xFF));
}

/* Group 3 unary: ext=2 not, 3 neg, 6 div, 7 idiv (F7 /ext). */
static void xa_grp3(X86Asm *a, int ext, X86Operand *d) {
    int w = (xa_opsize(d) == 8) ? 1 : 0;
    xa_rex_rm(a, w, ext, d);
    xa_emit(a, (unsigned char)((xa_opsize(d) == 1) ? 0xF6 : 0xF7));
    if (d->kind == XOP_REG) xa_modrm_reg(a, ext, d->reg);
    else xa_modrm_mem(a, ext, d);
}

/* setcc: accepts an explicit 8-bit destination (defaults to al). */
static void xa_setcc(X86Asm *a, int op2, X86Operand *d) {
    int r = (d->kind == XOP_REG) ? d->reg : 0;
    xa_rex(a, 0, 0, r, -1);
    xa_emit(a, 0x0F);
    xa_emit(a, (unsigned char)op2);
    xa_modrm_reg(a, 0, r);
}

/* mov with full 64-bit support; xmm operands are routed to xa_emit_movq. */
static void xa_emit_mov(X86Asm *a, X86Operand *d, X86Operand *s) {
    int sz = xa_opsize(d) ? xa_opsize(d) : xa_opsize(s);
    int w = (sz == 8) ? 1 : 0;
    if ((d->kind == XOP_REG && d->reg_size == 16) ||
        (s->kind == XOP_REG && s->reg_size == 16)) {
        xa_emit_movq(a, d, s);
        return;
    }
    if (d->kind == XOP_REG && s->kind == XOP_REG) {
        xa_rex(a, w, s->reg, d->reg, -1);
        xa_emit(a, (unsigned char)((sz == 1) ? 0x88 : 0x89));
        xa_modrm_reg(a, s->reg, d->reg);
    } else if (d->kind == XOP_REG && s->kind == XOP_IMM) {
        long long imm = s->imm;
        if (sz == 1) {
            xa_rex(a, 0, 0, d->reg, -1);
            xa_emit(a, (unsigned char)(0xB0 + (d->reg & 7)));
            xa_emit(a, (unsigned char)(imm & 0xFF));
        } else if (sz == 2) {
            xa_emit(a, 0x66);
            xa_rex(a, 0, 0, d->reg, -1);
            xa_emit(a, (unsigned char)(0xB8 + (d->reg & 7)));
            xa_emit16(a, (int)(imm & 0xFFFF));
        } else if (w) {
            if (xa_imm_fits32(imm)) {
                xa_rex(a, 1, 0, d->reg, -1);
                xa_emit(a, 0xC7);
                xa_modrm_reg(a, 0, d->reg);
                xa_emit32(a, (int)imm);
            } else {
                xa_rex(a, 1, 0, d->reg, -1);
                xa_emit(a, (unsigned char)(0xB8 + (d->reg & 7)));
                xa_emit64(a, imm);
            }
        } else {
            if (!xa_imm_fits32(imm)) {
                a->error_count++;
                diag_tool(DIAG_SEV_ERROR, "arkcc", "mov reg, imm32 out of range", 0,0,0,0,0,0);
                return;
            }
            xa_emit(a, (unsigned char)(0xB8 + (d->reg & 7)));
            xa_emit32(a, (int)imm);
        }
    } else if (d->kind == XOP_REG && s->kind == XOP_MEM) {
        int byte_load = (sz == 1 && a->mode64);
        xa_rex_rm(a, w, d->reg, s);
        xa_emit(a, (unsigned char)(byte_load ? 0x8A : 0x8B));
        xa_modrm_mem(a, d->reg, s);
    } else if (d->kind == XOP_MEM && s->kind == XOP_REG) {
        xa_rex_rm(a, w, s->reg, d);
        xa_emit(a, (unsigned char)((sz == 1) ? 0x88 : 0x89));
        xa_modrm_mem(a, s->reg, d);
    } else if (d->kind == XOP_MEM && s->kind == XOP_IMM) {
        long long imm = s->imm;
        int msz = d->mem_size;
        if (!xa_imm_fits32(imm)) {
            a->error_count++;
            diag_tool(DIAG_SEV_ERROR, "arkcc", "mov [mem], wide immediate needs a register", 0,0,0,0,0,0);
            return;
        }
        if (msz == 1) {
            xa_rex_rm(a, 0, 0, d);
            xa_emit(a, 0xC6);
            xa_modrm_mem(a, 0, d);
            xa_emit(a, (unsigned char)(imm & 0xFF));
        } else if (msz == 2) {
            xa_emit(a, 0x66);
            xa_rex_rm(a, 0, 0, d);
            xa_emit(a, 0xC7);
            xa_modrm_mem(a, 0, d);
            xa_emit16(a, (int)(imm & 0xFFFF));
        } else {
            xa_rex_rm(a, (msz == 8) ? 1 : 0, 0, d);
            xa_emit(a, 0xC7);
            xa_modrm_mem(a, 0, d);
            xa_emit32(a, (int)imm);
        }
    } else {
        a->error_count++;
        diag_tool(DIAG_SEV_ERROR, "arkcc", "unsupported mov operand combination", 0,0,0,0,0,0);
    }
}

/* --- process one line of assembly ---
 * Shared by pass1 (dry_run=1) and pass2 (dry_run=0). */
static void xa_process_line(X86Asm *a, const char *line) {
    const char *p = line;
    g_xa64 = a->mode64;
    char mn[32];
    X86Operand ops[2];
    int nop = 0;

    xa_skip_space(&p);
    if (*p == '\n' || *p == 0 || *p == '#') return;

    /* Read mnemonic or directive */
    if (xa_read_word(&p, mn, (int)sizeof(mn)) == 0) return;
    xa_skip_space(&p);

    /* Label definition: "name:" */
    if (*p == ':') {
        xa_add_label(a, mn, a->pc);
        p++;
        xa_skip_space(&p);
        if (*p == '\n' || *p == 0 || *p == '#') return;
        /* Read the actual mnemonic after the label */
        if (xa_read_word(&p, mn, (int)sizeof(mn)) == 0) return;
        xa_skip_space(&p);
    }

    /* Where the operand text starts.  "rep movsb" is two mnemonics on one
     * line, and the generic scan below eats the second one as if it were an
     * operand, so the rep branch rewinds to here to read it. */
    const char *opstart = p;

    /* Parse operands (up to 2, comma-separated) */
    {
        int i;
        for (i = 0; i < 2; i++) {
            ops[i].kind = XOP_NONE;
            if (xa_parse_operand(&p, &ops[i])) {
                nop++;
                xa_skip_space(&p);
                if (*p == ',') { p++; continue; }
                break;
            }
            break;
        }
    }

    /* --- Directives --- */
    if (mn[0] == '.') {
        if (xa_strieq(mn, ".intel_syntax")) { xa_skip_to_eol(&p); return; }
        if (xa_strieq(mn, ".text"))    { a->cur_section = 0; return; }
        if (xa_strieq(mn, ".data"))    { a->cur_section = 1; return; }
        if (xa_strieq(mn, ".section")) {
            xa_skip_space(&p);
            if (xa_starts_with(p, ".rodata")) a->cur_section = 2;
            else if (xa_starts_with(p, ".data")) a->cur_section = 1;
            else if (xa_starts_with(p, ".text")) a->cur_section = 0;
            else a->cur_section = 0;
            xa_skip_to_eol(&p);
            return;
        }
        if (xa_strieq(mn, ".globl") || xa_strieq(mn, ".global")) {
            /* Mark symbol as global (next label defined). For the ARKOBJ2
             * format, all non-.L labels are exported, so this is metadata. */
            return;
        }
        if (xa_strieq(mn, ".local")) { return; }
        if (xa_strieq(mn, ".weak")) { a->pending_weak = 1; return; }
        if (xa_strieq(mn, ".align") || xa_strieq(mn, ".balign") || xa_strieq(mn, ".p2align")) {
            long long align = 0;
            xa_parse_imm(&p, &align);
            if (align > 1) {
                int rem = a->pc % (int)align;
                if (rem) { int pad; for (pad = 0; pad < (int)align - rem; pad++) xa_emit(a, 0); }
            }
            return;
        }
        if (xa_strieq(mn, ".asciz") || xa_strieq(mn, ".ascii")) {
            xa_emit_string(a, &p, xa_strieq(mn, ".asciz"));
            return;
        }
        if (xa_strieq(mn, ".byte"))  { xa_emit_data(a, &p, 1); return; }
        if (xa_strieq(mn, ".word") || xa_strieq(mn, ".short")) { xa_emit_data(a, &p, 2); return; }
        if (xa_strieq(mn, ".long") || xa_strieq(mn, ".int")) { xa_emit_data(a, &p, 4); return; }
        if (xa_strieq(mn, ".quad")) { xa_emit_data(a, &p, 8); return; }
        if (xa_strieq(mn, ".zero") || xa_strieq(mn, ".skip") || xa_strieq(mn, ".space")) {
            long long n = 0;
            xa_parse_imm(&p, &n);
            { int k; for (k = 0; k < n; k++) xa_emit(a, 0); }
            return;
        }
        if (xa_strieq(mn, ".set") || xa_strieq(mn, ".equ")) { return; }
        /* Unknown directive: skip */
        return;
    }

    /* --- Instructions --- */
    if (xa_strieq(mn, "mov")) {
        xa_emit_mov(a, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "movq")) {
        xa_emit_movq(a, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "movsxd")) {
        xa_rex_rm(a, 1, ops[0].reg, &ops[1]);
        xa_emit(a, 0x63);
        if (ops[1].kind == XOP_REG) xa_modrm_reg(a, ops[0].reg, ops[1].reg);
        else xa_modrm_mem(a, ops[0].reg, &ops[1]);
    } else if (xa_strieq(mn, "add")) {
        xa_alu(a, 0x01, 0x03, 0x05, 0, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "sub")) {
        xa_alu(a, 0x29, 0x2B, 0x2D, 5, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "cmp")) {
        xa_alu(a, 0x39, 0x3B, 0x3D, 7, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "xor")) {
        xa_alu(a, 0x31, 0x33, 0x35, 6, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "and")) {
        xa_alu(a, 0x21, 0x23, 0x25, 4, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "or")) {
        xa_alu(a, 0x09, 0x0B, 0x0D, 1, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "adc")) {
        xa_alu(a, 0x11, 0x13, 0x15, 2, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "sbb")) {
        xa_alu(a, 0x19, 0x1B, 0x1D, 3, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "push")) {
        if (ops[0].kind == XOP_REG) {
            xa_rex(a, 0, 0, ops[0].reg, -1);
            xa_emit(a, (unsigned char)(0x50 + (ops[0].reg & 7)));
        } else if (ops[0].kind == XOP_IMM) {
            int imm = (int)ops[0].imm;
            if (imm >= -128 && imm <= 127) {
                xa_emit(a, 0x6A);
                xa_emit(a, (unsigned char)(imm & 0xFF));
            } else {
                xa_emit(a, 0x68);
                xa_emit32(a, imm);
            }
        } else if (ops[0].kind == XOP_MEM) {
            xa_rex_rm(a, 0, 6, &ops[0]);
            xa_emit(a, 0xFF);
            xa_modrm_mem(a, 6, &ops[0]);
        } else {
            a->error_count++;
        }
    } else if (xa_strieq(mn, "pop")) {
        if (ops[0].kind == XOP_REG) {
            xa_rex(a, 0, 0, ops[0].reg, -1);
            xa_emit(a, (unsigned char)(0x58 + (ops[0].reg & 7)));
        } else if (ops[0].kind == XOP_MEM) {
            xa_rex_rm(a, 0, 0, &ops[0]);
            xa_emit(a, 0x8F);
            xa_modrm_mem(a, 0, &ops[0]);
        } else {
            a->error_count++;
        }
    } else if (xa_strieq(mn, "lea")) {
        if (ops[0].kind == XOP_REG && ops[1].kind == XOP_MEM) {
            xa_rex_rm(a, (xa_opsize(&ops[0]) == 8) ? 1 : 0, ops[0].reg, &ops[1]);
            xa_emit(a, 0x8D);
            xa_modrm_mem(a, ops[0].reg, &ops[1]);
        } else {
            a->error_count++;
            diag_tool(DIAG_SEV_ERROR, "arkcc", "lea needs reg, mem", 0,0,0,0,0,0);
        }
    } else if (xa_strieq(mn, "not")) {
        xa_grp3(a, 2, &ops[0]);
    } else if (xa_strieq(mn, "neg")) {
        xa_grp3(a, 3, &ops[0]);
    } else if (xa_strieq(mn, "test")) {
        int w = xa_is64(&ops[0], &ops[1]) ? 1 : 0;
        if (ops[0].kind == XOP_REG && ops[1].kind == XOP_REG) {
            xa_rex(a, w, ops[1].reg, ops[0].reg, -1);
            xa_emit(a, 0x85);
            xa_modrm_reg(a, ops[1].reg, ops[0].reg);
        } else if (ops[0].kind == XOP_REG && ops[1].kind == XOP_IMM) {
            long long imm = ops[1].imm;
            if (!xa_imm_fits32(imm)) { a->error_count++; diag_tool(DIAG_SEV_ERROR, "arkcc", "test immediate out of range", 0,0,0,0,0,0); return; }
            if ((ops[0].reg & 7) == 0 && !w) {  /* eax */
                xa_emit(a, 0xA9);
                xa_emit32(a, (int)imm);
            } else {
                xa_rex_rm(a, w, 0, &ops[0]);
                xa_emit(a, 0xF7);
                xa_modrm_reg(a, 0, ops[0].reg);
                xa_emit32(a, (int)imm);
            }
        } else if (ops[0].kind == XOP_MEM && ops[1].kind == XOP_IMM) {
            long long imm = ops[1].imm;
            if (!xa_imm_fits32(imm)) { a->error_count++; diag_tool(DIAG_SEV_ERROR, "arkcc", "test immediate out of range", 0,0,0,0,0,0); return; }
            xa_rex_rm(a, w, 0, &ops[0]);
            xa_emit(a, 0xF7);
            xa_modrm_mem(a, 0, &ops[0]);
            xa_emit32(a, (int)imm);
        } else {
            a->error_count++;
            diag_tool(DIAG_SEV_ERROR, "arkcc", "unsupported test form", 0,0,0,0,0,0);
        }
    } else if (xa_strieq(mn, "imul")) {
        int w = xa_is64(&ops[0], &ops[1]) ? 1 : 0;
        if (ops[0].kind == XOP_REG && ops[1].kind == XOP_REG) {
            xa_rex(a, w, ops[0].reg, ops[1].reg, -1);
            xa_emit(a, 0x0F); xa_emit(a, 0xAF);
            xa_modrm_reg(a, ops[0].reg, ops[1].reg);
        } else if (ops[0].kind == XOP_REG && ops[1].kind == XOP_IMM) {
            long long imm = ops[1].imm;
            if (!xa_imm_fits32(imm)) { a->error_count++; diag_tool(DIAG_SEV_ERROR, "arkcc", "imul immediate out of range", 0,0,0,0,0,0); return; }
            xa_rex(a, w, ops[0].reg, ops[0].reg, -1);
            xa_emit(a, 0x69);
            xa_modrm_reg(a, ops[0].reg, ops[0].reg);
            xa_emit32(a, (int)imm);
        } else if (ops[0].kind == XOP_REG && ops[1].kind == XOP_MEM) {
            xa_rex_rm(a, w, ops[0].reg, &ops[1]);
            xa_emit(a, 0x0F); xa_emit(a, 0xAF);
            xa_modrm_mem(a, ops[0].reg, &ops[1]);
        } else {
            a->error_count++;
            diag_tool(DIAG_SEV_ERROR, "arkcc", "unsupported imul form", 0,0,0,0,0,0);
        }
    } else if (xa_strieq(mn, "idiv")) {
        xa_grp3(a, 7, &ops[0]);
    } else if (xa_strieq(mn, "div")) {
        xa_grp3(a, 6, &ops[0]);
    } else if (xa_strieq(mn, "cdq")) {
        xa_emit(a, 0x99);
    } else if (xa_strieq(mn, "cqo")) {
        xa_rex(a, 1, -1, -1, -1);
        xa_emit(a, 0x99);
    } else if (xa_strieq(mn, "cdqe")) {
        xa_rex(a, 1, -1, -1, -1);
        xa_emit(a, 0x98);
    } else if (xa_strieq(mn, "cbw")) {
        xa_emit(a, 0x66); xa_emit(a, 0x98);
    } else if (xa_strieq(mn, "cwd") || xa_strieq(mn, "cwde")) {
        xa_emit(a, 0x98);
    } else if (xa_strieq(mn, "shl") || xa_strieq(mn, "sal")) {
        xa_shift(a, 4, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "shr")) {
        xa_shift(a, 5, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "sar")) {
        xa_shift(a, 7, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "rol")) {
        xa_shift(a, 0, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "ror")) {
        xa_shift(a, 1, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "movzx")) {
        int w = (xa_opsize(&ops[0]) == 8) ? 1 : 0;
        unsigned char op2 = (xa_opsize(&ops[1]) == 2) ? 0xB7 : 0xB6;
        xa_rex_rm(a, w, ops[0].reg, &ops[1]);
        xa_emit(a, 0x0F); xa_emit(a, op2);
        if (ops[1].kind == XOP_REG) xa_modrm_reg(a, ops[0].reg, ops[1].reg);
        else xa_modrm_mem(a, ops[0].reg, &ops[1]);
    } else if (xa_strieq(mn, "movsx") || xa_strieq(mn, "movsxd")) {
        int dsz = xa_opsize(&ops[0]);
        int ssz = xa_opsize(&ops[1]);
        int w = (dsz == 8) ? 1 : 0;
        unsigned char op2;
        if (dsz == 8 && ssz != 2 && ssz != 1 && ssz != 8) {
            /* movsxd: 63 /r */
            xa_rex_rm(a, 1, ops[0].reg, &ops[1]);
            xa_emit(a, 0x63);
            if (ops[1].kind == XOP_REG) xa_modrm_reg(a, ops[0].reg, ops[1].reg);
            else xa_modrm_mem(a, ops[0].reg, &ops[1]);
            return;
        }
        op2 = (ssz == 2) ? 0xBF : 0xBE;
        xa_rex_rm(a, w, ops[0].reg, &ops[1]);
        xa_emit(a, 0x0F); xa_emit(a, op2);
        if (ops[1].kind == XOP_REG) xa_modrm_reg(a, ops[0].reg, ops[1].reg);
        else xa_modrm_mem(a, ops[0].reg, &ops[1]);
    } else if (xa_strieq(mn, "jmp")) {
        if (ops[0].kind == XOP_REG) {
            xa_rex(a, 0, 0, ops[0].reg, -1);
            xa_emit(a, 0xFF); xa_modrm_reg(a, 4, ops[0].reg);
        } else if (ops[0].has_sym) {
            xa_branch(a, 0xE9, 0, ops[0].sym);
        } else { a->error_count++; }
    } else if (xa_strieq(mn, "je") || xa_strieq(mn, "jz")) {
        xa_branch(a, 0, 0x84, ops[0].sym);
    } else if (xa_strieq(mn, "jne") || xa_strieq(mn, "jnz")) {
        xa_branch(a, 0, 0x85, ops[0].sym);
    } else if (xa_strieq(mn, "jl")) {
        xa_branch(a, 0, 0x8C, ops[0].sym);
    } else if (xa_strieq(mn, "jge")) {
        xa_branch(a, 0, 0x8D, ops[0].sym);
    } else if (xa_strieq(mn, "jle")) {
        xa_branch(a, 0, 0x8E, ops[0].sym);
    } else if (xa_strieq(mn, "jg")) {
        xa_branch(a, 0, 0x8F, ops[0].sym);
    } else if (xa_strieq(mn, "jb") || xa_strieq(mn, "jc")) {
        xa_branch(a, 0, 0x82, ops[0].sym);
    } else if (xa_strieq(mn, "jae") || xa_strieq(mn, "jnc")) {
        xa_branch(a, 0, 0x83, ops[0].sym);
    } else if (xa_strieq(mn, "jbe")) {
        xa_branch(a, 0, 0x86, ops[0].sym);
    } else if (xa_strieq(mn, "ja")) {
        xa_branch(a, 0, 0x87, ops[0].sym);
    } else if (xa_strieq(mn, "js")) {
        xa_branch(a, 0, 0x88, ops[0].sym);
    } else if (xa_strieq(mn, "jns")) {
        xa_branch(a, 0, 0x89, ops[0].sym);
    } else if (xa_strieq(mn, "jp")) {
        xa_branch(a, 0, 0x8A, ops[0].sym);
    } else if (xa_strieq(mn, "jnp")) {
        xa_branch(a, 0, 0x8B, ops[0].sym);
    } else if (xa_strieq(mn, "sete") || xa_strieq(mn, "setz")) {
        xa_setcc(a, 0x94, &ops[0]);
    } else if (xa_strieq(mn, "setne") || xa_strieq(mn, "setnz")) {
        xa_setcc(a, 0x95, &ops[0]);
    } else if (xa_strieq(mn, "setl")) {
        xa_setcc(a, 0x9C, &ops[0]);
    } else if (xa_strieq(mn, "setge")) {
        xa_setcc(a, 0x9D, &ops[0]);
    } else if (xa_strieq(mn, "setle")) {
        xa_setcc(a, 0x9E, &ops[0]);
    } else if (xa_strieq(mn, "setg")) {
        xa_setcc(a, 0x9F, &ops[0]);
    } else if (xa_strieq(mn, "setb") || xa_strieq(mn, "setc")) {
        xa_setcc(a, 0x92, &ops[0]);
    } else if (xa_strieq(mn, "setae") || xa_strieq(mn, "setnc")) {
        xa_setcc(a, 0x93, &ops[0]);
    } else if (xa_strieq(mn, "setbe")) {
        xa_setcc(a, 0x96, &ops[0]);
    } else if (xa_strieq(mn, "seta")) {
        xa_setcc(a, 0x97, &ops[0]);
    } else if (xa_strieq(mn, "setp")) {
        xa_setcc(a, 0x9A, &ops[0]);
    } else if (xa_strieq(mn, "setnp")) {
        xa_setcc(a, 0x9B, &ops[0]);
    } else if (xa_strieq(mn, "call")) {
        if (ops[0].kind == XOP_REG) {
            xa_rex(a, 0, 0, ops[0].reg, -1);
            xa_emit(a, 0xFF); xa_modrm_reg(a, 2, ops[0].reg);
        } else if (ops[0].has_sym) {
            xa_branch(a, 0xE8, 0, ops[0].sym);
        } else { a->error_count++; }
    } else if (xa_strieq(mn, "ret")) {
        xa_emit(a, 0xC3);
    } else if (xa_strieq(mn, "nop")) {
        xa_emit(a, 0x90);
    } else if (xa_strieq(mn, "addsd")) {
        xa_sse(a, 0xF2, 0x58, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "subsd")) {
        xa_sse(a, 0xF2, 0x5C, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "mulsd")) {
        xa_sse(a, 0xF2, 0x59, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "divsd")) {
        xa_sse(a, 0xF2, 0x5E, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "sqrtsd")) {
        xa_sse(a, 0xF2, 0x51, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "ucomisd")) {
        xa_sse(a, 0x66, 0x2E, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "comisd")) {
        xa_sse(a, 0x66, 0x2F, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "cvttsd2si")) {
        xa_sse(a, 0xF2, 0x2C, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "cvtsi2sd")) {
        xa_sse(a, 0xF2, 0x2A, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "cvtsd2ss")) {
        xa_sse(a, 0xF2, 0x5A, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "cvtss2sd")) {
        xa_sse(a, 0xF3, 0x5A, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "xorpd") || xa_strieq(mn, "pxor")) {
        xa_sse(a, 0x66, xa_strieq(mn, "pxor") ? 0xEF : 0x57, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "andpd")) {
        xa_sse(a, 0x66, 0x54, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "orpd")) {
        xa_sse(a, 0x66, 0x56, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "movapd")) {
        xa_sse(a, 0x66, 0x28, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "movsd") && nop == 2) {
        /* F2 0F 10 /r (load) or F2 0F 11 /r (store) */
        if (ops[0].kind == XOP_MEM) xa_sse(a, 0xF2, 0x11, &ops[1], &ops[0]);
        else xa_sse(a, 0xF2, 0x10, &ops[0], &ops[1]);
    } else if (xa_strieq(mn, "rep") || xa_strieq(mn, "repe") || xa_strieq(mn, "repz")) {
        /* rep movsb / rep stosb / etc.  Two mnemonics share the line and the
         * operand scan above already consumed the second one, so start over
         * from opstart.  Before this the prefix byte 0xF3 was emitted on its
         * own and the string instruction vanished: "rep movsb" assembled to a
         * single stray prefix, so IR_MEMCPY copied nothing and every struct
         * assignment silently produced the destination unchanged. */
        static const struct { const char *name; int prefix; unsigned char op; } xa_reps[] = {
            { "movsb", 0,   0xA4 },
            { "movsw", 0x66, 0xA5 },
            { "movsd", 0,   0xA5 },
            { "movsq", 64,  0xA5 },
            { "stosb", 0,   0xAA },
            { "stosd", 0,   0xAB },
            { "stosq", 64,  0xAB },
            { "lodsb", 0,   0xAC },
            { "scasb", 0,   0xAE },
            { "cmpsb", 0,   0xA6 }
        };
        char sub[16];
        int k, hit = -1;
        sub[0] = 0;
        p = opstart;
        xa_skip_space(&p);
        if (xa_read_word(&p, sub, (int)sizeof(sub))) {
            for (k = 0; k < (int)(sizeof(xa_reps) / sizeof(xa_reps[0])); k++) {
                if (xa_strieq(sub, xa_reps[k].name)) { hit = k; break; }
            }
        }
        if (hit < 0) {
            /* Never emit a bare prefix: that turns a missing instruction into
             * a silently valid but wrong encoding. */
            a->error_count++;
            diag_tool(DIAG_SEV_ERROR, "arkcc", "unsupported rep-prefixed instruction",
                      0,0,0,0,0,0);
        } else {
            xa_emit(a, 0xF3);
            if (xa_reps[hit].prefix == 64) xa_rex(a, 1, -1, -1, -1);
            else if (xa_reps[hit].prefix != 0) xa_emit(a, (unsigned char)xa_reps[hit].prefix);
            xa_emit(a, xa_reps[hit].op);
        }
    } else if (xa_strieq(mn, "movsb")) { xa_emit(a, 0xA4); }
    else if (xa_strieq(mn, "movsd")) { xa_emit(a, 0xA5); }
    else if (xa_strieq(mn, "stosb")) { xa_emit(a, 0xAA); }
    else if (xa_strieq(mn, "stosd")) { xa_emit(a, 0xAB); }
    else if (xa_strieq(mn, "leave")) { xa_emit(a, 0xC9); }
    else if (xa_strieq(mn, "int")) {
        if (ops[0].kind == XOP_IMM) { xa_emit(a, 0xCD); xa_emit(a, (unsigned char)(ops[0].imm & 0xFF)); }
    } else if (xa_strieq(mn, "xchg")) {
        int w = xa_is64(&ops[0], &ops[1]) ? 1 : 0;
        if (ops[0].kind == XOP_REG && ops[1].kind == XOP_REG) {
            if ((ops[0].reg & 7) == 0) {
                xa_rex(a, w, 0, ops[1].reg, -1);
                xa_emit(a, (unsigned char)(0x90 + (ops[1].reg & 7)));
            } else if ((ops[1].reg & 7) == 0) {
                xa_rex(a, w, 0, ops[0].reg, -1);
                xa_emit(a, (unsigned char)(0x90 + (ops[0].reg & 7)));
            } else {
                xa_rex(a, w, ops[0].reg, ops[1].reg, -1);
                xa_emit(a, 0x87); xa_modrm_reg(a, ops[0].reg, ops[1].reg);
            }
        } else { a->error_count++; }
    } else if (xa_strieq(mn, "inc")) {
        if (ops[0].kind == XOP_REG) { xa_rex(a, (ops[0].reg_size == 8) ? 1 : 0, 0, ops[0].reg, -1); xa_emit(a, 0xFF); xa_modrm_reg(a, 0, ops[0].reg); }
        else { xa_rex_rm(a, (ops[0].mem_size == 8) ? 1 : 0, 0, &ops[0]); xa_emit(a, 0xFF); xa_modrm_mem(a, 0, &ops[0]); }
    } else if (xa_strieq(mn, "dec")) {
        if (ops[0].kind == XOP_REG) { xa_rex(a, (ops[0].reg_size == 8) ? 1 : 0, 0, ops[0].reg, -1); xa_emit(a, 0xFF); xa_modrm_reg(a, 1, ops[0].reg); }
        else { xa_rex_rm(a, (ops[0].mem_size == 8) ? 1 : 0, 0, &ops[0]); xa_emit(a, 0xFF); xa_modrm_mem(a, 1, &ops[0]); }
    } else {
        /* Unknown instruction: emit nop to keep pc advancing */
        a->error_count++;
        diag_tool(DIAG_SEV_ERROR, "arkcc", "unknown instruction %sq", mn,
                  0,0,0,0,0);
    }
    (void)nop;
}

/* --- pass1: compute sizes, collect labels --- */
static void pass1_x(X86Asm *a) {
    const char *p = a->src;
    a->dry_run = 1;
    a->pc = 0;
    a->label_count = 0;
    a->ref_count = 0;
    while (*p) {
        const char *line = p;
        /* Find end of line */
        while (*p && *p != '\n') p++;
        xa_process_line(a, line);
        if (*p == '\n') p++;
    }
}

/* --- pass2: emit machine code, record refs --- */
static void pass2_x(X86Asm *a) {
    const char *p = a->src;
    a->dry_run = 0;
    a->pc = 0;
    a->ref_count = 0;  /* reset refs for pass2 */
    while (*p) {
        const char *line = p;
        while (*p && *p != '\n') p++;
        xa_process_line(a, line);
        if (*p == '\n') p++;
    }
}

/* --- resolve_refs: patch forward references --- */
static void resolve_refs_x(X86Asm *a) {
    int i;
    for (i = 0; i < a->ref_count; i++) {
        X86AsmRef *r = &a->refs[i];
        int addr = xa_find_label(a, r->name);
        if (addr < 0) {
            /* Unresolved: will be handled as a cross-object relocation */
            continue;
        }
        if (r->type == 5) {
            /* PC-relative disp32: disp = target - (ref_pc + 4) */
            int disp = addr - (r->pc + 4);
            if (!a->dry_run) {
                a->out[r->pc]     = (unsigned char)(disp & 0xFF);
                a->out[r->pc + 1] = (unsigned char)((disp >> 8) & 0xFF);
                a->out[r->pc + 2] = (unsigned char)((disp >> 16) & 0xFF);
                a->out[r->pc + 3] = (unsigned char)((disp >> 24) & 0xFF);
            }
        } else if (r->type == 4) {
            /* Absolute 32-bit address */
            if (!a->dry_run) {
                a->out[r->pc]     = (unsigned char)(addr & 0xFF);
                a->out[r->pc + 1] = (unsigned char)((addr >> 8) & 0xFF);
                a->out[r->pc + 2] = (unsigned char)((addr >> 16) & 0xFF);
                a->out[r->pc + 3] = (unsigned char)((addr >> 24) & 0xFF);
            }
        }
    }
}

/* --- symbol/reloc export for the linker --- */
typedef struct { char *name; int offset; int type; int is_weak; } X86Sym;
typedef struct { char *name; int offset; int type; } X86Reloc;

static X86Sym   g_x86_syms[ARM_MAX_SYMBOLS]   __attribute__((section(".ark_buf")));
static int      g_x86_sym_count = 0;
static X86Reloc g_x86_relocs[ARM_MAX_RELOCS]  __attribute__((section(".ark_buf")));
static int      g_x86_reloc_count = 0;

static void x86_save_syms(X86Asm *a) {
    int i;
    g_x86_sym_count = 0;
    for (i = 0; i < a->label_count && g_x86_sym_count < ARM_MAX_SYMBOLS; i++) {
        if (a->labels[i].name[0] == '.' && a->labels[i].name[1] == 'L') continue;
        g_x86_syms[g_x86_sym_count].name    = a->labels[i].name;
        g_x86_syms[g_x86_sym_count].offset   = a->labels[i].addr;
        g_x86_syms[g_x86_sym_count].type     = 0;
        g_x86_syms[g_x86_sym_count].is_weak  = a->labels[i].is_weak;
        g_x86_sym_count++;
    }
}

static void x86_save_relocs(X86Asm *a) {
    int i;
    g_x86_reloc_count = 0;
    for (i = 0; i < a->ref_count && g_x86_reloc_count < ARM_MAX_RELOCS; i++) {
        X86AsmRef *r = &a->refs[i];
        if (xa_find_label(a, r->name) < 0) {
            g_x86_relocs[g_x86_reloc_count].name   = r->name;
            g_x86_relocs[g_x86_reloc_count].offset  = r->pc;
            g_x86_relocs[g_x86_reloc_count].type    = r->type;
            g_x86_reloc_count++;
        }
    }
}

int x86_get_symbol_count(void) { return g_x86_sym_count; }
const char *x86_get_symbol_name(int idx) { return g_x86_syms[idx].name; }
int x86_get_symbol_offset(int idx) { return g_x86_syms[idx].offset; }
int x86_get_symbol_type(int idx) { return g_x86_syms[idx].type; }
int x86_get_symbol_weak(int idx) { return g_x86_syms[idx].is_weak; }

int x86_get_reloc_count(void) { return g_x86_reloc_count; }
const char *x86_get_reloc_name(int idx) { return g_x86_relocs[idx].name; }
int x86_get_reloc_offset(int idx) { return g_x86_relocs[idx].offset; }
int x86_get_reloc_type(int idx) { return g_x86_relocs[idx].type; }

/* x86_assemble: encode Intel-syntax assembly text into x86 machine code.
 * Two-pass design: pass1 computes sizes + labels; pass2 emits bytes + refs;
 * resolve_refs patches forward references. All jumps use near (disp32) form
 * so pass1 sizes are fixed. Exports symbol/reloc tables for the ARKOBJ2 linker. */
static int x86_assemble_mode(const char *asm_text, unsigned char *out, int cap, int mode64) {
    X86Asm a;
    a.src = asm_text;
    a.out = out;
    a.pc = 0;
    a.out_cap = cap;
    a.labels = 0; a.label_count = 0; a.label_cap = 0;
    a.refs = 0; a.ref_count = 0; a.ref_cap = 0;
    a.error_count = 0;
    a.cur_section = 0;
    a.pending_weak = 0;
    a.dry_run = 0;
    a.mode64 = mode64;
    pass1_x(&a);
    pass2_x(&a);
    resolve_refs_x(&a);
    x86_save_syms(&a);
#if ARKCC_PROFILE != ARKCC_PROFILE_STM32_MIN
    /* ARKCC_DUMP_SYMS=1 prints the label map.  A flat image carries no symbol
     * table, so this is the only way a host-side test can find `main` in it --
     * the same contract the riscv32 backend publishes as RV_SYM. */
    if (getenv("ARKCC_DUMP_SYMS")) {
        int li;
        for (li = 0; li < a.label_count; li++) {
            if (a.labels[li].name[0] == '.') continue;
            ark_log("X86_SYM %s 0x%X\n", a.labels[li].name, a.labels[li].addr);
        }
    }
#endif
    x86_save_relocs(&a);
    a.mode64 = 0;
    g_xa64 = 0;
    return a.pc;
}

static int x86_assemble(const char *asm_text, unsigned char *out, int cap) {
    return x86_assemble_mode(asm_text, out, cap, 0);
}

static int x86_assemble64(const char *asm_text, unsigned char *out, int cap) {
    return x86_assemble_mode(asm_text, out, cap, 1);
}

/* No-op link: cross-object linking is handled by compiler.c's -link mode
 * (ARKOBJ2 binary linker with symbol resolution + relocation patching). */
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

/* The real 64-bit backend: SysV x86-64 (AMD64) in place of i386 cdecl.
 * pointer_size 8 is what makes type.c lay out pointers, longs and aggregates
 * the way the ABI does; amd64_emit_internal() keeps the compiler's 4-byte
 * stack-word model on top of that, so a pointer is still one "word" but its
 * slot holds the full 64-bit value (IR_AUX_SLOT64). */
static const ArkBackend g_amd64_backend = {
    "x86_64",
    "x86_64-unknown-linux-gnu",
    8,
    amd64_emit_sysv,
    x86_assemble64,
    x86_link,
    ARK_ABI_SYSV
};

/* Kept under its original name because registry.c and compiler.c call it: it
 * is the 32-bit i386 backend. ark_backend_i386() is the name that says so. */
const ArkBackend *ark_backend_x86_64(void) {
    return &g_x86_backend;
}

const ArkBackend *ark_backend_i386(void) {
    return &g_x86_backend;
}

const ArkBackend *ark_backend_amd64(void) {
    return &g_amd64_backend;
}

/* Stub retained for registry.c compatibility (MSVC variant removed).
 * Returns the main x86 backend; -target x86_64-msvc is no longer distinct. */
const ArkBackend *ark_backend_x86_64_msvc(void) {
    return &g_x86_backend;
}
