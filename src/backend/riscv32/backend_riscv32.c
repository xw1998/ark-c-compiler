/* Ark C Compiler - RISC-V (RV32I) backend
 *
 * Emits GAS-syntax RV32I assembly and assembles it to a flat image at
 * 0x08000000 (.text, then .rodata, then .data), so `arkcc -target
 * riscv32 x.c -o x.bin` needs no external GNU as/ld.  -c/-link still
 * hand the text to the user's toolchain: cross-object relocation is
 * not implemented for this target.
 *
 * Calling convention: arguments a0..a7; stack frame fp = s0; this backend
 * treats all local values as 4-byte slots.
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include "diag.h"
#include "agginit.h"
/* On host, <stdlib.h> provides getenv() for the ARKCC_DUMP_SYMS symbol map
 * (see rv_assemble); on STM32 getenv() does not exist. */
#if ARKCC_PROFILE != ARKCC_PROFILE_STM32_MIN
#  include <stdlib.h>
#endif

static const char *arg_reg_r(int i) {
    static const char *r[] = { "a0","a1","a2","a3","a4","a5","a6","a7" };
    if (i < 0 || i >= 8) return "a0";
    return r[i];
}

/* ---- frame layout -------------------------------------------------------
 * Every frame is a fixed 48-byte header followed by the locals, variadic or
 * not, so there is one layout to reason about:
 *
 *   s0-32+4k    argument image word k = a<k>, k = 0..7.  A variadic function
 *               spills the eight argument registers here once, in the
 *               prologue, before the body can clobber a0-a7.  The image ends
 *               exactly at s0, so a va_arg walk that runs off word 7 lands on
 *               s0+0 -- the caller's own first stack argument word.
 *   s0-36       saved ra
 *   s0-40       saved s0
 *   s0-48-local_size .. s0-49
 *               locals.  The IR offset `off` lives at LB+off with
 *               LB = s0-(48+local_size): offsets grow towards s0, the same
 *               direction as `base + off` everywhere else in the compiler.
 *               It used to be s0-(16+off), which grows *downwards*, so any
 *               local aggregate walked over the saved registers.
 *   sp          sp_size = align16(RV_LOCAL_BASE + local_size)
 *
 * The 256 bytes of slack the old frame carried existed only to hold a va
 * region at the bottom; that region is the 32-byte image above, so the slack
 * is gone.  <stdarg.h> walks the image as a plain word pointer
 * (__ARK_VA_WORD_SLOTS, and __ARK_VA_PACKED_WORDS because this backend
 * numbers argument words without alignment holes). */
#define RV_VA_WORDS     8
#define RV_REGION_OFF   32
#define RV_SAVE_RA_OFF  36
#define RV_SAVE_S0_OFF  40
#define RV_LOCAL_BASE   48

/* GNU as encodes a 12-bit signed displacement only, and a slot can sit far
 * more than 2 KB below s0, so the s0-relative slot address is materialised in
 * t2 with li/sub instead of being folded into the load or store.  That is one
 * extra instruction per access, and it is what makes the output assemble at
 * all for frames bigger than 2 KB. */
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
 * frame size are past the 12-bit immediate range for a big frame, so the
 * addresses are formed in t0 first. */
static void rv_pilogue(AsmBuffer *b, int sp_size, int dynamic) {
    /* A VLA lowers to IR_ALLOCA, which moves sp at run time; the saved
     * registers are then no longer at a fixed offset from the current sp.
     * s0 is the frame base, so rebuild sp from it before touching the frame. */
    if (dynamic) {
        asmbuf_puts(b, "    li t0, ");
        asmbuf_int(b, sp_size);
        asmbuf_puts(b, "\n    sub sp, s0, t0\n");
    }
    asmbuf_puts(b, "    li t0, ");
    asmbuf_int(b, sp_size - RV_SAVE_S0_OFF);
    asmbuf_puts(b, "\n    add t0, sp, t0\n    lw s0, 0(t0)\n    li t0, ");
    asmbuf_int(b, sp_size - RV_SAVE_RA_OFF);
    asmbuf_puts(b, "\n    add t0, sp, t0\n    lw ra, 0(t0)\n");
    rv_sp_adj(b, sp_size, 1);
    asmbuf_puts(b, "    ret\n");
}

/* 1 while the function being emitted is variadic, cleared for every function. */
static int g_rv_va_active;

/* A 64-bit value occupies two integer registers (a0:a1 and so on) with the low
 * word in the lower-numbered one.  Mirrors ret_is_two_words() in the ARM
 * backend: an 8-byte scalar, or a 5..8-byte composite. */
static int rv_ret_is_two_words(Type *t) {
    int sz;
    if (!t) return 0;
    if (t->kind == TYPE_LLONG || t->kind == TYPE_DOUBLE) return 1;
    if (t->kind == TYPE_STRUCT || t->kind == TYPE_UNION) {
        sz = type_size(t);
        return (sz > 4 && sz <= 8);
    }
    return 0;
}

/* Storage size of a global, from its declared type.  0 when the name is not in
 * this program's global table: the caller then keeps the one-word behaviour,
 * which is all a declaration can promise. */
static int rv_global_size(IrProgram *prog, const char *name) {
    int i;
    if (!prog || !name) return 0;
    for (i = 0; i < prog->global_count; i++) {
        IrGlobal *g = prog->globals[i];
        if (g->name && ark_streq(g->name, name))
            return g->type ? type_size(g->type) : 0;
    }
    return 0;
}

static void rv_emit_bytes(AsmBuffer *b, const unsigned char *p, int n) {
    int i;
    for (i = 0; i < n; i++) {
        if ((i % 16) == 0)
            asmbuf_puts(b, (i == 0) ? "    .byte " : "\n    .byte ");
        else
            asmbuf_puts(b, ", ");
        asmbuf_int(b, p[i]);
    }
    if (n > 0) asmbuf_putc(b, '\n');
}

/* A C string as assembler text, for .asciz. */
static void rv_put_cstr(AsmBuffer *b, const char *s) {
    int k;
    for (k = 0; s[k]; k++) {
        char c = s[k];
        if (c == '\n') asmbuf_puts(b, "\\n");
        else if (c == '\t') asmbuf_puts(b, "\\t");
        else if (c == '\r') asmbuf_puts(b, "\\r");
        else if (c == '\\') asmbuf_puts(b, "\\\\");
        else if (c == '"') asmbuf_puts(b, "\\\"");
        else asmbuf_putc(b, c);
    }
}

/* ---- soft-float helpers -------------------------------------------------
 * This target has no F extension, so every floating-point operation is a call
 * into libgcc's soft-float routines.  Under the ilp32 psABI a float travels in
 * one integer register (a0) and a double in two, with the LOW word in the
 * lower-numbered register; results come back the same way.  An image built for
 * this backend therefore has to be linked against libgcc.a.
 */
static const char *rv_fbin_helper(int op, int is_dbl) {
    switch (op) {
        case (int)TOK_PLUS:  return is_dbl ? "__adddf3" : "__addsf3";
        case (int)TOK_MINUS: return is_dbl ? "__subdf3" : "__subsf3";
        case (int)TOK_MUL:   return is_dbl ? "__muldf3" : "__mulsf3";
        case (int)TOK_DIV:   return is_dbl ? "__divdf3" : "__divsf3";
        default: return 0;
    }
}

/* The comparison helpers answer like strcmp -- negative / zero / positive --
 * with unordered pairs folded in per IEEE: 1 for eq/ne and for lt/le, -1 for
 * gt/ge.  That is exactly what C's six relational operators must return. */
static const char *rv_fcmp_helper(int op, int is_dbl) {
    switch (op) {
        case (int)TOK_EQ: return is_dbl ? "__eqdf2" : "__eqsf2";
        case (int)TOK_NE: return is_dbl ? "__nedf2" : "__nesf2";
        case (int)TOK_LT: return is_dbl ? "__ltdf2" : "__ltsf2";
        case (int)TOK_GT: return is_dbl ? "__gtdf2" : "__gtsf2";
        case (int)TOK_LE: return is_dbl ? "__ledf2" : "__lesf2";
        case (int)TOK_GE: return is_dbl ? "__gedf2" : "__gesf2";
        default: return 0;
    }
}

/* Pop two soft-float operands: the left one into a0 (a0:a1 for a double), the
 * right one into a2 (a2:a3).  The IR stack keeps a 64-bit value with its HIGH
 * word on top, while the psABI wants the low word in the lower register, so
 * the four words are shuffled through t0..t3. */
static void rv_fpop2(AsmBuffer *b, int is_dbl) {
    if (is_dbl) {
        asmbuf_puts(b, "    lw t3, 0(sp)\n    lw t2, 4(sp)\n"
                       "    lw t1, 8(sp)\n    lw t0, 12(sp)\n"
                       "    addi sp, sp, 16\n"
                       "    mv a0, t0\n    mv a1, t1\n    mv a2, t2\n    mv a3, t3\n");
    } else {
        asmbuf_puts(b, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 8\n"
                       "    mv a0, t0\n    mv a1, t1\n");
    }
}

/* Push a float result (a0) or a double result (a0:a1) back onto the IR stack,
 * high word last so it ends up on top. */
static void rv_fpush1(AsmBuffer *b, int is_dbl) {
    if (is_dbl)
        asmbuf_puts(b, "    addi sp, sp, -4\n    sw a0, 0(sp)\n"
                       "    addi sp, sp, -4\n    sw a1, 0(sp)\n");
    else
        asmbuf_puts(b, "    addi sp, sp, -4\n    sw a0, 0(sp)\n");
}

/* A 32-bit bit pattern as eight lowercase hex digits, for .word. */
static void rv_put_hex32(AsmBuffer *b, unsigned int v) {
    static const char *hd = "0123456789abcdef";
    char hex[9];
    int k;
    for (k = 7; k >= 0; k--) { hex[k] = hd[v & 0xF]; v >>= 4; }
    hex[8] = 0;
    asmbuf_puts(b, hex);
}

static int rv_emit(IrProgram *prog, char *out, int cap) {
    AsmBuffer buf;
    int fi;
    asmbuf_init(&buf);
    asmbuf_puts(&buf, "# Ark C Compiler - generated RV32I assembly\n");
    asmbuf_puts(&buf, "    .option nopic\n"
                    "    .option norelax\n    .text\n");

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

    /* Floating-point constant pool.  Every constant gets both bit patterns --
     * .L_flt_<i> (the double rounded to float, which is what `(float)c` means)
     * and .L_dbl_<i> -- and IR_PUSH_FLOAT's aux bit 0x200 picks which one is
     * loaded, so one index serves a constant used as a float in one place and
     * as a double in another.  Each word is .balign 4 so `lw` is legal. */
    if (prog->float_count > 0) {
        int i;
        asmbuf_puts(&buf, "    .section .rodata\n");
        for (i = 0; i < prog->float_count; i++) {
            union { float f; unsigned int u; } uf;
            union { double d; unsigned int u[2]; } ud;
            uf.f = (float)prog->floats[i];
            ud.d = prog->floats[i];
            asmbuf_puts(&buf, "    .balign 4\n.L_flt_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, ":\n    .word 0x");
            rv_put_hex32(&buf, uf.u);
            asmbuf_puts(&buf, "\n    .balign 4\n.L_dbl_");
            asmbuf_int(&buf, i);
            asmbuf_puts(&buf, ":\n    .word 0x");
            rv_put_hex32(&buf, ud.u[0]);
            asmbuf_puts(&buf, "\n    .word 0x");
            rv_put_hex32(&buf, ud.u[1]);
            asmbuf_putc(&buf, '\n');
        }
        asmbuf_puts(&buf, "    .text\n");
    }

    /* Global definitions.  One storage block per object, sized from its
     * declared type, with its initialiser turned into data: the old emitter
     * wrote a single zero word for every global, so an initialised array, a
     * long long, a struct, and even `char c = 'a'` (a 4-byte store inside a
     * 1-byte object) were all wrong.  Anything that cannot be resolved into
     * bytes is reported -- writing the storage without the initialiser would
     * invent zeroes, which is a wrong answer, not a missing feature. */
    if (prog->global_count) {
        int i;
        /* A string that is only ever the initialiser of a pointer has no pool
         * entry (the pool is filled while emitting expressions), so give each
         * one a local label in .rodata. */
        for (i = 0; i < prog->global_count; i++) {
            IrGlobal *g = prog->globals[i];
            int ptr_like;
            if (g->is_extern || !g->has_init || !g->init_str) continue;
            if (g->type && (g->type->kind == TYPE_ARRAY ||
                            g->type->kind == TYPE_STRUCT ||
                            g->type->kind == TYPE_UNION)) continue;
            ptr_like = (g->type && g->type->kind == TYPE_PTR);
            if (!ptr_like) continue;
            asmbuf_puts(&buf, "    .section .rodata\n.Lgstr_");
            asmbuf_puts(&buf, g->name);
            asmbuf_puts(&buf, ":\n    .asciz \"");
            rv_put_cstr(&buf, g->init_str);
            asmbuf_puts(&buf, "\"\n    .text\n");
        }
        asmbuf_puts(&buf, "    .data\n");
        for (i = 0; i < prog->global_count; i++) {
            IrGlobal *g = prog->globals[i];
            Type *t = g->type;
            int gsz = t ? type_size(t) : 4;
            int al = t ? type_align(t) : 4;
            int kind = t ? t->kind : TYPE_INT;
            int is_agg;
            if (gsz <= 0) gsz = 4;
            is_agg = (kind == TYPE_ARRAY || kind == TYPE_STRUCT ||
                      kind == TYPE_UNION);
            if (g->is_extern) continue;       /* a declaration is not a definition */
            if (al < 4) al = 4;
            if (al > 8) al = 8;
            if (g->align_bytes > al) al = g->align_bytes;
            if (!g->is_static) {
                asmbuf_puts(&buf, "    .globl ");
                asmbuf_puts(&buf, g->name);
                asmbuf_putc(&buf, '\n');
            }
            asmbuf_puts(&buf, "    .balign ");
            asmbuf_int(&buf, al);
            asmbuf_putc(&buf, '\n');
            asmbuf_puts(&buf, g->name);
            asmbuf_puts(&buf, ":\n");
            if (is_agg && g->has_init &&
                (g->init_aggregate || g->init_str)) {
                unsigned char *bytes = (unsigned char *)mem_pool_alloc(gsz);
                int bad = 0;
                int k;
                for (k = 0; k < gsz; k++) bytes[k] = 0;
                if (g->init_aggregate) {
                    if (ark_agg_fill(t, g->init_aggregate, bytes, gsz) != 0)
                        bad = 1;
                } else if (kind == TYPE_ARRAY && t && t->base &&
                           type_size(t->base) == 1) {
                    ark_agg_fill_cstr(g->init_str, bytes, gsz);
                } else {
                    bad = 1;
                }
                if (bad) {
                    diag_tool(DIAG_SEV_ERROR, "arkcc",
                              "the riscv32 backend cannot turn the initialiser "
                              "of the global '%s' into data; only integer "
                              "constants in arrays and structures, string "
                              "literals for char arrays, and a string literal "
                              "for a pointer are implemented",
                              g->name, 0,0,0,0,0);
                    asmbuf_puts(&buf, "    .space ");
                    asmbuf_int(&buf, gsz);
                    asmbuf_putc(&buf, '\n');
                } else {
                    rv_emit_bytes(&buf, bytes, gsz);
                }
            } else if (is_agg) {
                asmbuf_puts(&buf, "    .space ");
                asmbuf_int(&buf, gsz);
                asmbuf_putc(&buf, '\n');
            } else if (kind == TYPE_PTR && g->has_init && g->init_str) {
                asmbuf_puts(&buf, "    .word .Lgstr_");
                asmbuf_puts(&buf, g->name);
                asmbuf_putc(&buf, '\n');
            } else if (g->has_init && g->init_aggregate) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "the riscv32 backend cannot turn the initialiser of "
                          "the global '%s' into data (it is not a plain "
                          "constant this backend can resolve)",
                          g->name, 0,0,0,0,0);
                asmbuf_puts(&buf, "    .word 0\n");
            } else if (gsz > 4) {
                unsigned long long v = 0ULL;
                if (g->has_init) {
                    if (g->is_float && kind == TYPE_DOUBLE) {
                        union { double d; unsigned long long u; } du;
                        du.d = g->init_float;
                        v = du.u;
                    } else {
                        v = (unsigned long long)g->init_int;
                    }
                }
                asmbuf_puts(&buf, "    .word ");
                asmbuf_int(&buf, (int)(v & 0xFFFFFFFFULL));
                asmbuf_puts(&buf, "\n    .word ");
                asmbuf_int(&buf, (int)((v >> 32) & 0xFFFFFFFFULL));
                asmbuf_putc(&buf, '\n');
            } else if (gsz == 2) {
                asmbuf_puts(&buf, "    .short ");
                asmbuf_int(&buf, (int)(g->has_init ? g->init_int : 0));
                asmbuf_putc(&buf, '\n');
            } else if (gsz == 1) {
                asmbuf_puts(&buf, "    .byte ");
                asmbuf_int(&buf, (int)(g->has_init ? g->init_int : 0));
                asmbuf_putc(&buf, '\n');
            } else {
                unsigned int w32 = 0;
                if (g->has_init) {
                    if (g->is_float && kind == TYPE_FLOAT) {
                        union { float f; unsigned int u; } fu;
                        fu.f = (float)g->init_float;
                        w32 = fu.u;
                    } else {
                        w32 = (unsigned int)g->init_int;
                    }
                }
                asmbuf_puts(&buf, "    .word ");
                asmbuf_int(&buf, w32);
                asmbuf_putc(&buf, '\n');
            }
        }
        asmbuf_puts(&buf, "    .text\n");
    }
    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];

        int i;
        int fsize = RV_LOCAL_BASE + f->local_size;
        /* Whether the body lowers a VLA anywhere: that is what decides if the
         * epilogue may assume sp still sits at the bottom of the fixed frame. */
        int has_alloca = 0;
        for (i = 0; i < f->code_count; i++)
            if (f->code[i].op == IR_ALLOCA) { has_alloca = 1; break; }
        int sp_size = (fsize + 15) & ~15;
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
            sp_size = (sp_size + 15) & ~15;
        }

        /* A file-scope `static` function is not a link symbol.  A flat image
         * never noticed the difference -- `.globl` is decoration when nothing
         * links -- but `-c` must be honest about it: two translation units that
         * each contain `static int helper(void)` would otherwise collide at
         * -link with a duplicate-definition error that the source never
         * implies. */
        if (!f->is_static) {
            asmbuf_puts(&buf, f->is_weak ? "    .weak " : "    .globl ");
            asmbuf_puts(&buf, f->name);
            asmbuf_putc(&buf, '\n');
        }
        asmbuf_puts(&buf, f->name);
        asmbuf_puts(&buf, ":\n");
        rv_sp_adj(&buf, sp_size, 0);
        asmbuf_puts(&buf, "    li t0, ");
        asmbuf_int(&buf, sp_size - RV_SAVE_RA_OFF);
        asmbuf_puts(&buf, "\n    add t0, sp, t0\n    sw ra, 0(t0)\n    li t0, ");
        asmbuf_int(&buf, sp_size - RV_SAVE_S0_OFF);
        asmbuf_puts(&buf, "\n    add t0, sp, t0\n    sw s0, 0(t0)\n    li t0, ");
        asmbuf_int(&buf, sp_size);
        asmbuf_puts(&buf, "\n    add s0, sp, t0\n");
        /* argument image: one word per argument register, written before the
         * body can touch a0-a7.  Words for named parameters are written too:
         * they are never read by va_arg (it starts at the first variadic
         * word), but keeping the whole register file in one array is what
         * makes the walk a plain word pointer. */
        g_rv_va_active = f->is_variadic ? 1 : 0;
        if (g_rv_va_active) {
            int k;
            asmbuf_puts(&buf, "    li t2, ");
            asmbuf_int(&buf, RV_REGION_OFF);
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
                    /* aux: low 8 bits = the argument word the value starts
                     * at, high 24 bits = the size it travels with (see
                     * irgen): >8 means the word holds the address of the
                     * payload, 8 means two words, anything else one word. */
                    int slot = I->aux & 0xFF;
                    int st_sz = (I->aux >> 8) & 0xFFFFFF;
                    int dst = (int)I->val;
                    int k;
                    if (st_sz > 8) {
                        /* the payload travels by address: copy it into the
                         * local slot so the callee owns its own copy */
                        int o = 0;
                        if (slot < RV_VA_WORDS) {
                            asmbuf_puts(&buf, "    mv t4, ");
                            asmbuf_puts(&buf, arg_reg_r(slot));
                            asmbuf_putc(&buf, '\n');
                        } else {
                            asmbuf_puts(&buf, "    lw t4, ");
                            asmbuf_int(&buf, 4 * (slot - RV_VA_WORDS));
                            asmbuf_puts(&buf, "(s0)\n");
                        }
                        rv_s0_slot(&buf, dst - fsize);
                        while (o < st_sz) {
                            asmbuf_puts(&buf, "    lw t0, ");
                            asmbuf_int(&buf, o);
                            asmbuf_puts(&buf, "(t4)\n    sw t0, ");
                            asmbuf_int(&buf, o);
                            asmbuf_puts(&buf, "(t2)\n");
                            o += (st_sz - o >= 4) ? 4 : (st_sz - o);
                        }
                        break;
                    }
                    /* one or two words; a stack word is read from s0+0, which
                     * is where the caller left it */
                    rv_s0_slot(&buf, dst - fsize);
                    for (k = 0; k < ((st_sz == 8) ? 2 : 1); k++) {
                        int w = slot + k;
                        asmbuf_puts(&buf, "    ");
                        if (w < RV_VA_WORDS) {
                            asmbuf_puts(&buf, "sw ");
                            asmbuf_puts(&buf, arg_reg_r(w));
                        } else {
                            asmbuf_puts(&buf, "lw t3, ");
                            asmbuf_int(&buf, 4 * (w - RV_VA_WORDS));
                            asmbuf_puts(&buf, "(s0)\n    sw t3");
                        }
                        asmbuf_puts(&buf, ", ");
                        asmbuf_int(&buf, 4 * k);
                        asmbuf_puts(&buf, "(t2)\n");
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
                case IR_PUSH_VAR: {
                    /* aux low byte = the width the variable is declared with,
                     * 0x100 = unsigned (see irgen).  Reading a char or short
                     * variable as a full word picks up the neighbouring bytes,
                     * so the load has to match the declaration. */
                    int width = I->aux & 0xFF;
                    int uns = (I->aux & 0x100) != 0;
                    if (width > 8) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "%s-byte variables are not implemented by the "
                                  "riscv32 backend (function '%s')",
                                  diag_num(b1, width), f->name, 0,0,0,0);
                        break;
                    }
                    rv_s0_slot(&buf, (int)I->val - fsize);
                    if (width == 8) {
                        /* low word first, so the high word ends up on top */
                        asmbuf_puts(&buf, "    lw t0, 0(t2)\n    lw t1, 4(t2)\n"
                                          "    addi sp, sp, -4\n    sw t0, 0(sp)\n"
                                          "    addi sp, sp, -4\n    sw t1, 0(sp)\n");
                    } else if (width == 1) {
                        asmbuf_puts(&buf, uns ? "    lbu t0, 0(t2)\n" : "    lb t0, 0(t2)\n");
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    } else if (width == 2) {
                        asmbuf_puts(&buf, uns ? "    lhu t0, 0(t2)\n" : "    lh t0, 0(t2)\n");
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    } else {
                        asmbuf_puts(&buf, "    lw t0, 0(t2)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    }
                    break;
                }
                case IR_PUSH_ADDR:
                    rv_s0_slot(&buf, (int)I->val - fsize);
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
                case IR_PUSH_GLOBAL: {
                    int gsz = rv_global_size(prog, I->name);
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
                        /* The image grows *up* from s0-32 (word k at +4k), so
                         * the first variadic word is 4*named_words above that
                         * base -- the same direction the prologue spills in. */
                        asmbuf_puts(&buf, "    li t2, ");
                        asmbuf_int(&buf, RV_REGION_OFF);
                        asmbuf_puts(&buf, "\n    sub t2, s0, t2\n    addi t2, t2, ");
                        asmbuf_int(&buf, 4 * va_named_words);
                        asmbuf_puts(&buf, "\n    addi sp, sp, -4\n    sw t2, 0(sp)\n");
                        break;
                    }
                    if (gsz > 8) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the riscv32 backend cannot load the "
                                  "%s-byte global '%s' by value",
                                  diag_num(b1, gsz), I->name, 0,0,0,0);
                        break;
                    }
                    asmbuf_puts(&buf, "    la t1, ");
                    asmbuf_puts(&buf, I->name);
                    if (gsz == 8) {
                        /* low word first, high word on top */
                        asmbuf_puts(&buf, "\n    lw t0, 0(t1)\n    lw t2, 4(t1)\n"
                                          "    addi sp, sp, -4\n    sw t0, 0(sp)\n"
                                          "    addi sp, sp, -4\n    sw t2, 0(sp)\n");
                    } else {
                        asmbuf_puts(&buf, "\n    lw t0, 0(t1)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    }
                    break;
                }
                case IR_STORE_GLOBAL: {
                    int gsz = rv_global_size(prog, I->name);
                    if (gsz > 8) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the riscv32 backend cannot store the "
                                  "%s-byte global '%s' by value",
                                  diag_num(b1, gsz), I->name, 0,0,0,0);
                        break;
                    }
                    if (gsz == 8) {
                        /* 0(sp) = high, 4(sp) = low */
                        asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    addi sp, sp, 8\n    la t2, ");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, "\n    sw t1, 0(t2)\n    sw t0, 4(t2)\n");
                    } else {
                        asmbuf_puts(&buf, "    lw t0, 0(sp)\n    addi sp, sp, 4\n    la t1, ");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_puts(&buf, gsz == 1 ? "\n    sb t0, 0(t1)\n" :
                                           (gsz == 2 ? "\n    sh t0, 0(t1)\n" :
                                                       "\n    sw t0, 0(t1)\n"));
                    }
                    break;
                }
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
                case IR_STORE: {
                    /* aux low byte = the store width, 0x10000 = volatile (see
                     * irgen).  A 64-bit value sits on the IR stack as two words
                     * with the high word on top, and `off` addresses the low
                     * word.  A plain `sw` here wrote half of a long long and
                     * left the other word on the IR stack (measured: the
                     * imbalance turned the next `ret` into a jump to 0). */
                    int sw = I->aux & 0xFF;
                    if (sw == 0) sw = 4;
                    if (sw > 8) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "%s-byte stores are not implemented by the "
                                  "riscv32 backend (function '%s')",
                                  diag_num(b1, sw), f->name, 0,0,0,0);
                        break;
                    }
                    if (sw == 8) {
                        asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    addi sp, sp, 8\n");
                        rv_s0_slot(&buf, (int)I->val - fsize);
                        asmbuf_puts(&buf, "    sw t1, 0(t2)\n    sw t0, 4(t2)\n");
                    } else {
                        asmbuf_puts(&buf, "    lw t0, 0(sp)\n    addi sp, sp, 4\n");
                        rv_s0_slot(&buf, (int)I->val - fsize);
                        if (sw == 1)      asmbuf_puts(&buf, "    sb t0, 0(t2)\n");
                        else if (sw == 2) asmbuf_puts(&buf, "    sh t0, 0(t2)\n");
                        else              asmbuf_puts(&buf, "    sw t0, 0(t2)\n");
                    }
                    break;
                }
                case IR_LOAD_IDX: {
                    /* 0(sp) = index, 4(sp) = address; the index is already a
                     * byte offset, irgen scales it before emitting.  val is
                     * the element width, which is also the width to load.
                     *
                     * aux bit 0x400: the pointer is __packed (or the aggregate
                     * is under-aligned), so the address is not guaranteed to
                     * suit the width.  RISC-V raises a misaligned-access
                     * exception instead of quietly doing something, and this
                     * case used to ignore the flag and emit a plain load -- a
                     * wrong answer that only waits for the right address.  The
                     * bytes are now assembled by hand.  An 8-byte packed load is
                     * refused rather than half-done: reading four bytes and
                     * calling it a long long is exactly the kind of silent
                     * short value the rest of this backend refuses to emit. */
                    int es = (int)I->val;
                    int packed = (I->aux & 0x400) ? 1 : 0;
                    if (es != 1 && es != 2 && es != 4 && es != 8) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "%s-byte loads are not implemented by the "
                                  "riscv32 backend (function '%s')",
                                  diag_num(b1, es), f->name, 0,0,0,0);
                        break;
                    }
                    asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 8\n");
                    /* The pushed index is an *element* index, not a byte
                     * offset: IR_LOAD_IDX scales it by the element size, the
                     * same way the arm backend emits MUL r1, r2.  Without
                     * this an aggregate written as consecutive words through
                     * '...' was reassembled from base+j instead of base+4j
                     * (measured: a 12-byte struct read s.b from base+2 and
                     * s.c from base+1).  es==1 needs no scaling, and every
                     * other producer of IR_LOAD_IDX pushes index 0, so the
                     * added shift leaves those cases untouched. */
                    if (es == 2)
                        asmbuf_puts(&buf, "    slli t1, t1, 1\n");
                    else if (es == 4)
                        asmbuf_puts(&buf, "    slli t1, t1, 2\n");
                    else if (es == 8)
                        asmbuf_puts(&buf, "    slli t1, t1, 3\n");
                    asmbuf_puts(&buf, "    add t0, t0, t1\n");
                    if (packed && es == 2) {
                        asmbuf_puts(&buf, "    lbu t1, 0(t0)\n    lbu t2, 1(t0)\n"
                                          "    slli t2, t2, 8\n    or t0, t1, t2\n"
                                          "    slli t0, t0, 16\n    srai t0, t0, 16\n");
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    } else if (packed && es == 4) {
                        asmbuf_puts(&buf, "    lbu t1, 0(t0)\n    lbu t2, 1(t0)\n"
                                          "    slli t2, t2, 8\n    or t1, t1, t2\n"
                                          "    lbu t2, 2(t0)\n    slli t2, t2, 16\n"
                                          "    or t1, t1, t2\n"
                                          "    lbu t2, 3(t0)\n    slli t2, t2, 24\n"
                                          "    or t0, t1, t2\n");
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    } else if (es == 8 && packed) {
                        /* 8-byte __packed load: assemble both words from bytes.
                         * Same push order as the aligned path below (low word
                         * first, then high), so the consumer is unaffected. */
                        asmbuf_puts(&buf, "    lbu t1, 0(t0)\n    lbu t3, 1(t0)\n"
                                          "    slli t3, t3, 8\n    or t1, t1, t3\n"
                                          "    lbu t3, 2(t0)\n    slli t3, t3, 16\n    or t1, t1, t3\n"
                                          "    lbu t3, 3(t0)\n    slli t3, t3, 24\n    or t1, t1, t3\n");
                        asmbuf_puts(&buf, "    lbu t2, 4(t0)\n    lbu t3, 5(t0)\n"
                                          "    slli t3, t3, 8\n    or t2, t2, t3\n"
                                          "    lbu t3, 6(t0)\n    slli t3, t3, 16\n    or t2, t2, t3\n"
                                          "    lbu t3, 7(t0)\n    slli t3, t3, 24\n    or t2, t2, t3\n");
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t1, 0(sp)\n"
                                          "    addi sp, sp, -4\n    sw t2, 0(sp)\n");
                    } else if (es == 8) {
                        asmbuf_puts(&buf, "    lw t1, 0(t0)\n    lw t2, 4(t0)\n"
                                          "    addi sp, sp, -4\n    sw t1, 0(sp)\n"
                                          "    addi sp, sp, -4\n    sw t2, 0(sp)\n");
                    } else {
                        asmbuf_puts(&buf, es == 1 ? "    lb t0, 0(t0)\n" :
                                           (es == 2 ? "    lh t0, 0(t0)\n" :
                                                      "    lw t0, 0(t0)\n"));
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    }
                    break;
                }

                case IR_STORE_IDX: {
                    /* es == 8: 0(sp) = high, 4(sp) = low, 8(sp) = address
                     * (irgen pushes value, address, then the value again, so
                     * the expression result is the stored value).  Otherwise
                     * 0(sp) = value, 4(sp) = address.
                     *
                     * aux 0x400 = __packed store: same reasoning as the matching
                     * load -- RISC-V traps on a misaligned halfword/word store,
                     * so the bytes have to be written one at a time. */
                    int es = (int)I->val;
                    int packed = (I->aux & 0x400) ? 1 : 0;
                    if (es == 8 && packed) {
                        /* 8-byte __packed store: byte by byte, then push the
                         * value back (low word first) exactly like the aligned
                         * path below. */
                        asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    lw t2, 8(sp)\n    addi sp, sp, 12\n");
                        asmbuf_puts(&buf, "    sb t1, 0(t2)\n"
                                          "    srli t3, t1, 8\n    sb t3, 1(t2)\n"
                                          "    srli t3, t1, 16\n    sb t3, 2(t2)\n"
                                          "    srli t3, t1, 24\n    sb t3, 3(t2)\n");
                        asmbuf_puts(&buf, "    sb t0, 4(t2)\n"
                                          "    srli t3, t0, 8\n    sb t3, 5(t2)\n"
                                          "    srli t3, t0, 16\n    sb t3, 6(t2)\n"
                                          "    srli t3, t0, 24\n    sb t3, 7(t2)\n");
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t1, 0(sp)\n"
                                          "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                        break;
                    }
                    if (es == 8) {
                        asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    lw t2, 8(sp)\n    addi sp, sp, 12\n");
                        asmbuf_puts(&buf, "    sw t1, 0(t2)\n    sw t0, 4(t2)\n");
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t1, 0(sp)\n"
                                          "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    } else if (es == 1 || es == 2 || es == 4) {
                        asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    addi sp, sp, 8\n");
                        if (packed && es == 2) {
                            asmbuf_puts(&buf, "    sb t0, 0(t1)\n"
                                              "    srli t2, t0, 8\n    sb t2, 1(t1)\n");
                        } else if (packed && es == 4) {
                            asmbuf_puts(&buf, "    sb t0, 0(t1)\n"
                                              "    srli t2, t0, 8\n    sb t2, 1(t1)\n"
                                              "    srli t2, t0, 16\n    sb t2, 2(t1)\n"
                                              "    srli t2, t0, 24\n    sb t2, 3(t1)\n");
                        } else {
                            asmbuf_puts(&buf, es == 1 ? "    sb t0, 0(t1)\n" :
                                               (es == 2 ? "    sh t0, 0(t1)\n" :
                                                          "    sw t0, 0(t1)\n"));
                        }
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    } else {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "%s-byte indexed stores are not implemented by "
                                  "the riscv32 backend (function '%s')",
                                  diag_num(b1, es), f->name, 0,0,0,0);
                    }
                    break;
                }

                case IR_BINARY: {
                    /* aux holds the operator, and bit 8 (0x100) means "the
                     * operands are unsigned" -- irgen sets it for unsigned
                     * comparisons and for >>.  Switching on aux directly made
                     * every unsigned compare and every unsigned right shift
                     * miss all the cases, land in the default arm and
                     * disappear: both operands were popped and the left one
                     * pushed back, so `u >> 4` silently returned `u` and
                     * `a < b` on unsigned silently returned `a` (nonzero =
                     * "true").  Mask the flag and pick the u-variants. */
                    int is_uns = (I->aux & 0x100) != 0;
                    asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 4\n");
                    switch (I->aux & ~0x100) {
                        case (int)TOK_PLUS:  asmbuf_puts(&buf, "    add t0, t0, t1\n"); break;
                        case (int)TOK_MINUS: asmbuf_puts(&buf, "    sub t0, t0, t1\n"); break;
                        case (int)TOK_MUL:   asmbuf_puts(&buf, "    mul t0, t0, t1\n"); break;
                        case (int)TOK_DIV:   asmbuf_puts(&buf, "    div t0, t0, t1\n"); break;
                        case (int)TOK_MOD:   asmbuf_puts(&buf, "    rem t0, t0, t1\n"); break;
                        case (int)TOK_BAND:  asmbuf_puts(&buf, "    and t0, t0, t1\n"); break;
                        case (int)TOK_BOR:   asmbuf_puts(&buf, "    or t0, t0, t1\n");  break;
                        case (int)TOK_BXOR:  asmbuf_puts(&buf, "    xor t0, t0, t1\n"); break;
                        case (int)TOK_SHL:   asmbuf_puts(&buf, "    sll t0, t0, t1\n"); break;
                        case (int)TOK_SHR:
                            asmbuf_puts(&buf, is_uns ? "    srl t0, t0, t1\n"
                                                     : "    sra t0, t0, t1\n");
                            break;
                        case (int)TOK_EQ:    asmbuf_puts(&buf, "    sub t0, t0, t1\n    seqz t0, t0\n"); break;
                        case (int)TOK_NE:    asmbuf_puts(&buf, "    sub t0, t0, t1\n    snez t0, t0\n"); break;
                        case (int)TOK_LT:    asmbuf_puts(&buf, is_uns ? "    sltu t0, t0, t1\n"
                                                                     : "    slt  t0, t0, t1\n"); break;
                        case (int)TOK_GT:    asmbuf_puts(&buf, is_uns ? "    sltu t0, t1, t0\n"
                                                                     : "    slt  t0, t1, t0\n"); break;
                        case (int)TOK_LE:    asmbuf_puts(&buf, is_uns ? "    sltu t0, t1, t0\n    xori t0, t0, 1\n"
                                                                     : "    slt  t0, t1, t0\n    xori t0, t0, 1\n"); break;
                        case (int)TOK_GE:    asmbuf_puts(&buf, is_uns ? "    sltu t0, t0, t1\n    xori t0, t0, 1\n"
                                                                     : "    slt  t0, t0, t1\n    xori t0, t0, 1\n"); break;
                        default: {
                            /* Never fall through silently: an operator this
                             * backend does not know must fail the build, not
                             * quietly return the left operand. */
                            char opbuf[12];
                            diag_tool(DIAG_SEV_ERROR, "arkcc",
                                      "the riscv32 backend does not implement binary "
                                      "operator %s (function '%s')",
                                      diag_num(opbuf, I->aux & ~0x100), f->name, 0, 0, 0, 0);
                            break;
                        }
                    }
                    asmbuf_puts(&buf, "    sw t0, 0(sp)\n");
                    break;
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
                /* ---- floating point (soft-float through libgcc) ---- */
                case IR_PUSH_FLOAT: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    if (I->aux & 0x400) {
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the riscv32 backend does not implement complex "
                                  "constants (function '%s')",
                                  f->name, 0,0,0,0,0);
                    } else if (is_dbl) {
                        asmbuf_puts(&buf, "    la t0, .L_dbl_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "\n    lw t1, 0(t0)\n    lw t2, 4(t0)\n"
                                          "    addi sp, sp, -4\n    sw t1, 0(sp)\n"
                                          "    addi sp, sp, -4\n    sw t2, 0(sp)\n");
                    } else {
                        asmbuf_puts(&buf, "    la t0, .L_flt_");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "\n    lw t0, 0(t0)\n"
                                          "    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    }
                    break;
                }
                case IR_FADD:
                case IR_FSUB:
                case IR_FMUL:
                case IR_FDIV: {
                    int is_dbl = (I->aux & 0x200) != 0;
                    const char *h = rv_fbin_helper(I->aux & ~0x200, is_dbl);
                    if (!h) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the riscv32 backend does not implement the "
                                  "floating-point operator %s (function '%s')",
                                  diag_num(b1, I->aux & ~0x200), f->name, 0,0,0,0);
                        break;
                    }
                    rv_fpop2(&buf, is_dbl);
                    asmbuf_puts(&buf, "    call ");
                    asmbuf_puts(&buf, h);
                    asmbuf_putc(&buf, '\n');
                    rv_fpush1(&buf, is_dbl);
                    break;
                }
                case IR_FCMP: {
                    /* aux: low bits = the operator, 0x200 = double.  The helper
                     * returns strcmp-style, so the boolean is a sign test. */
                    int is_dbl = (I->aux & 0x200) != 0;
                    int op = I->aux & ~0x200;
                    const char *h = rv_fcmp_helper(op, is_dbl);
                    if (!h) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the riscv32 backend does not implement the "
                                  "floating-point comparison %s (function '%s')",
                                  diag_num(b1, op), f->name, 0,0,0,0);
                        break;
                    }
                    rv_fpop2(&buf, is_dbl);
                    asmbuf_puts(&buf, "    call ");
                    asmbuf_puts(&buf, h);
                    asmbuf_putc(&buf, '\n');
                    switch (op) {
                        case (int)TOK_EQ: asmbuf_puts(&buf, "    seqz a0, a0\n"); break;
                        case (int)TOK_NE: asmbuf_puts(&buf, "    snez a0, a0\n"); break;
                        case (int)TOK_LT: asmbuf_puts(&buf, "    slti a0, a0, 0\n"); break;
                        case (int)TOK_GT: asmbuf_puts(&buf, "    slt a0, x0, a0\n"); break;
                        case (int)TOK_LE: asmbuf_puts(&buf, "    slti a0, a0, 1\n"); break;
                        case (int)TOK_GE: asmbuf_puts(&buf, "    slti a0, a0, 0\n"
                                                          "    xori a0, a0, 1\n"); break;
                        default: break;
                    }
                    asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw a0, 0(sp)\n");
                    break;
                }
                case IR_F2I: {
                    /* float/double -> int, truncated toward zero.
                     * aux: 0x200 = double source, 0x400 = unsigned target. */
                    int is_dbl = (I->aux & 0x200) != 0;
                    int is_unsigned = (I->aux & 0x400) != 0;
                    const char *h = is_dbl
                        ? (is_unsigned ? "__fixunsdfsi" : "__fixdfsi")
                        : (is_unsigned ? "__fixunssfsi" : "__fixsfsi");
                    if (is_dbl)
                        asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n"
                                          "    addi sp, sp, 8\n"
                                          "    mv a0, t0\n    mv a1, t1\n");
                    else
                        asmbuf_puts(&buf, "    lw a0, 0(sp)\n    addi sp, sp, 4\n");
                    asmbuf_puts(&buf, "    call ");
                    asmbuf_puts(&buf, h);
                    asmbuf_putc(&buf, '\n');
                    asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw a0, 0(sp)\n");
                    break;
                }
                case IR_I2F: {
                    /* int -> float/double.
                     * aux: 0x200 = double destination, 0x400 = unsigned source. */
                    int is_dbl = (I->aux & 0x200) != 0;
                    int is_unsigned = (I->aux & 0x400) != 0;
                    const char *h = is_dbl
                        ? (is_unsigned ? "__floatunsidf" : "__floatsidf")
                        : (is_unsigned ? "__floatunsisf" : "__floatsisf");
                    asmbuf_puts(&buf, "    lw a0, 0(sp)\n    addi sp, sp, 4\n    call ");
                    asmbuf_puts(&buf, h);
                    asmbuf_putc(&buf, '\n');
                    rv_fpush1(&buf, is_dbl);
                    break;
                }
                case IR_64I2F: {
                    /* long long -> float/double.
                     * aux: 0x200 = double destination, 0x400 = unsigned source. */
                    int is_dbl = (I->aux & 0x200) != 0;
                    int is_unsigned = (I->aux & 0x400) != 0;
                    const char *h = is_dbl
                        ? (is_unsigned ? "__floatundidf" : "__floatdidf")
                        : (is_unsigned ? "__floatundisf" : "__floatdisf");
                    asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n"
                                      "    addi sp, sp, 8\n"
                                      "    mv a0, t0\n    mv a1, t1\n    call ");
                    asmbuf_puts(&buf, h);
                    asmbuf_putc(&buf, '\n');
                    rv_fpush1(&buf, is_dbl);
                    break;
                }
                case IR_64F2I: {
                    /* float/double -> long long.  A 64-bit result comes back in
                     * a0:a1 (low word first), which is the same pair rv_fpush1
                     * pushes for a double, so it is reused here.
                     * aux: 0x200 = double source, 0x400 = unsigned target. */
                    int is_dbl = (I->aux & 0x200) != 0;
                    int is_unsigned = (I->aux & 0x400) != 0;
                    const char *h = is_dbl
                        ? (is_unsigned ? "__fixunsdfdi" : "__fixdfdi")
                        : (is_unsigned ? "__fixunssfdi" : "__fixsfdi");
                    if (is_dbl)
                        asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n"
                                          "    addi sp, sp, 8\n"
                                          "    mv a0, t0\n    mv a1, t1\n");
                    else
                        asmbuf_puts(&buf, "    lw a0, 0(sp)\n    addi sp, sp, 4\n");
                    asmbuf_puts(&buf, "    call ");
                    asmbuf_puts(&buf, h);
                    asmbuf_putc(&buf, '\n');
                    rv_fpush1(&buf, 1);
                    break;
                }
                case IR_F2F: {
                    /* float <-> double cast.
                     * aux: 0x200 = double source (narrowing), 0x100 = double
                     * destination (widening); neither means same width. */
                    int src_dbl = (I->aux & 0x200) != 0;
                    int dst_dbl = (I->aux & 0x100) != 0;
                    if (src_dbl && !dst_dbl) {
                        asmbuf_puts(&buf, "    lw t1, 0(sp)\n    lw t0, 4(sp)\n"
                                          "    addi sp, sp, 8\n    mv a0, t0\n    mv a1, t1\n"
                                          "    call __truncdfsf2\n");
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw a0, 0(sp)\n");
                    } else if (!src_dbl && dst_dbl) {
                        asmbuf_puts(&buf, "    lw a0, 0(sp)\n    addi sp, sp, 4\n"
                                          "    call __extendsfdf2\n");
                        rv_fpush1(&buf, 1);
                    }
                    break;
                }
                case IR_UNARY: {
                    /* val: 0 = 32-bit, 1 = float (unimplemented here),
                     * 2 = 64-bit integer.  aux = the operator. */
                    if (I->val == 2) {
                        int op = I->aux & ~0x400;
                        /* high word on top, low word below */
                        asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n");
                        if (op == (int)TOK_MINUS) {
                            asmbuf_puts(&buf, "    sltu t2, x0, t1\n    sub t1, x0, t1\n"
                                              "    sub t0, x0, t0\n    sub t0, t0, t2\n");
                        } else if (op == (int)TOK_BNOT) {
                            asmbuf_puts(&buf, "    not t0, t0\n    not t1, t1\n");
                        } else if (op == (int)TOK_NOT) {
                            asmbuf_puts(&buf, "    or t0, t0, t1\n    seqz t0, t0\n"
                                              "    addi sp, sp, 4\n    mv t1, x0\n");
                        } else {
                            char b1[12];
                            diag_tool(DIAG_SEV_ERROR, "arkcc",
                                      "the riscv32 backend does not implement the "
                                      "64-bit unary operator %s (function '%s')",
                                      diag_num(b1, op), f->name, 0,0,0,0);
                        }
                        asmbuf_puts(&buf, "    sw t0, 0(sp)\n    sw t1, 4(sp)\n");
                    } else if (I->val == 1) {
                        /* Floating-point negation.  `-x` on a float/double is a
                         * sign-bit flip, NOT an integer negate: the latter turns
                         * -0.0 into +0.0 and mangles the exponent of every other
                         * value.  val==1 means float; aux bit 0x200 marks a
                         * double, whose sign bit sits in the HIGH word -- which
                         * is the word on top of the stack, so one sequence does
                         * both. */
                        int op = I->aux & ~0x200;
                        if (op != (int)TOK_MINUS) {
                            char b1[12];
                            diag_tool(DIAG_SEV_ERROR, "arkcc",
                                      "the riscv32 backend does not implement the "
                                      "floating-point unary operator %s in '%s'",
                                      diag_num(b1, op), f->name, 0,0,0,0);
                        } else {
                            asmbuf_puts(&buf, "    lw t0, 0(sp)\n"
                                              "    li t1, -2147483648\n"
                                              "    xor t0, t0, t1\n    sw t0, 0(sp)\n");
                        }
                    } else {
                        asmbuf_puts(&buf, "    lw t0, 0(sp)\n");
                        if (I->aux == (int)TOK_MINUS) asmbuf_puts(&buf, "    neg t0, t0\n");
                        else if (I->aux == (int)TOK_BNOT) asmbuf_puts(&buf, "    not t0, t0\n");
                        else if (I->aux == (int)TOK_NOT)  asmbuf_puts(&buf, "    seqz t0, t0\n");
                        asmbuf_puts(&buf, "    sw t0, 0(sp)\n");
                    }
                    break;
                }
                case IR_64BINARY: {
                    /* 0(sp) = b.high, 4 = b.low, 8 = a.high, 12 = a.low: the
                     * IR stack keeps a 64-bit value with its high word on top.
                     * Afterwards addi sp,sp,8 leaves a's two words in place as
                     * the result slot (high at 0(sp), low at 4(sp)). */
                    int op = I->aux & ~0x100;
                    int uns = (I->aux & 0x100) != 0;
                    asmbuf_puts(&buf, "    lw t2, 0(sp)\n    lw t3, 4(sp)\n"
                                      "    lw t0, 8(sp)\n    lw t1, 12(sp)\n"
                                      "    addi sp, sp, 8\n");
                    if (op == (int)TOK_PLUS) {
                        asmbuf_puts(&buf, "    add t1, t1, t3\n    sltu t4, t1, t3\n"
                                          "    add t0, t0, t2\n    add t0, t0, t4\n");
                    } else if (op == (int)TOK_MINUS) {
                        asmbuf_puts(&buf, "    sltu t4, t1, t3\n    sub t1, t1, t3\n"
                                          "    sub t0, t0, t2\n    sub t0, t0, t4\n");
                    } else if (op == (int)TOK_BAND) {
                        asmbuf_puts(&buf, "    and t0, t0, t2\n    and t1, t1, t3\n");
                    } else if (op == (int)TOK_BOR) {
                        asmbuf_puts(&buf, "    or t0, t0, t2\n    or t1, t1, t3\n");
                    } else if (op == (int)TOK_BXOR) {
                        asmbuf_puts(&buf, "    xor t0, t0, t2\n    xor t1, t1, t3\n");
                    } else if (op == (int)TOK_MUL) {
                        /* low: al*bl; high: mulhu(al,bl) + al*bh + ah*bl */
                        asmbuf_puts(&buf, "    mulhu t4, t1, t3\n    mul t5, t1, t2\n"
                                          "    mul t6, t0, t3\n    add t4, t4, t5\n"
                                          "    add t4, t4, t6\n    mul t1, t1, t3\n"
                                          "    mv t0, t4\n");
                    } else if (op == (int)TOK_SHL) {
                        asmbuf_puts(&buf, "    andi t3, t3, 63\n    beqz t3, 21f\n"
                                          "    li t4, 32\n    bgeu t3, t4, 23f\n"
                                          "    li t4, 32\n    sub t4, t4, t3\n"
                                          "    srl t4, t1, t4\n    sll t0, t0, t3\n"
                                          "    or t0, t0, t4\n    sll t1, t1, t3\n"
                                          "    j 21f\n"
                                          "23:\n    addi t3, t3, -32\n    sll t0, t1, t3\n"
                                          "    li t1, 0\n"
                                          "21:\n");
                    } else if (op == (int)TOK_SHR) {
                        /* signed >> is arithmetic, unsigned >> is logical */
                        asmbuf_puts(&buf, "    andi t3, t3, 63\n    beqz t3, 31f\n"
                                          "    li t4, 32\n    bgeu t3, t4, 33f\n"
                                          "    li t4, 32\n    sub t4, t4, t3\n"
                                          "    sll t4, t0, t4\n");
                        asmbuf_puts(&buf, uns ? "    srl t1, t1, t3\n" : "    sra t1, t1, t3\n");
                        asmbuf_puts(&buf, "    or t1, t1, t4\n");
                        asmbuf_puts(&buf, uns ? "    srl t0, t0, t3\n" : "    sra t0, t0, t3\n");
                        asmbuf_puts(&buf, "    j 31f\n33:\n    addi t3, t3, -32\n");
                        asmbuf_puts(&buf, uns ? "    srl t1, t0, t3\n    li t0, 0\n"
                                              : "    sra t1, t0, t3\n    srai t0, t0, 31\n");
                        asmbuf_puts(&buf, "31:\n");
                    } else if (op == (int)TOK_DIV || op == (int)TOK_MOD) {
                        /* 64-bit divide, written out rather than calling
                         * __divdi3: this backend is also used for images that
                         * link no libgcc, so a helper the gate cannot resolve
                         * would make the case unverifiable.  64 rounds of
                         * shift-and-subtract; the callee-saved registers are
                         * borrowed and put back.
                         *   s0:s1 = |a|   s2:s3 = |b|   s4:s5 = quotient
                         *   s6:s7 = remainder           t4/t5 = sign(a)/sign(b)
                         *   t6 = counter */
                        asmbuf_puts(&buf, "    addi sp, sp, -32\n    sw s0, 0(sp)\n"
                                          "    sw s1, 4(sp)\n    sw s2, 8(sp)\n"
                                          "    sw s3, 12(sp)\n    sw s4, 16(sp)\n"
                                          "    sw s5, 20(sp)\n    sw s6, 24(sp)\n"
                                          "    sw s7, 28(sp)\n"
                                          "    mv s0, t0\n    mv s1, t1\n"
                                          "    mv s2, t2\n    mv s3, t3\n"
                                          "    li t4, 0\n    li t5, 0\n");
                        if (!uns) {
                            asmbuf_puts(&buf, "    srli t4, s0, 31\n    srli t5, s2, 31\n");
                            asmbuf_puts(&buf, "    beqz t4, 41f\n    sltu t0, x0, s1\n"
                                              "    sub s1, x0, s1\n    add s0, s0, t0\n"
                                              "    sub s0, x0, s0\n41:\n");
                            asmbuf_puts(&buf, "    beqz t5, 42f\n    sltu t0, x0, s3\n"
                                              "    sub s3, x0, s3\n    add s2, s2, t0\n"
                                              "    sub s2, x0, s2\n42:\n");
                        }
                        asmbuf_puts(&buf, "    li s4, 0\n    li s5, 0\n    li s6, 0\n    li s7, 0\n"
                                          "    li t6, 64\n43:\n");
                        /* a <<= 1, keeping the shifted-out bit in t0 */
                        asmbuf_puts(&buf, "    srli t0, s0, 31\n    srli t1, s1, 31\n"
                                          "    slli s0, s0, 1\n    or s0, s0, t1\n"
                                          "    slli s1, s1, 1\n");
                        /* r = (r << 1) | bit */
                        asmbuf_puts(&buf, "    srli t1, s7, 31\n    slli s6, s6, 1\n"
                                          "    or s6, s6, t1\n    slli s7, s7, 1\n"
                                          "    or s7, s7, t0\n");
                        /* if (r >= b) { r -= b; bit = 1 } else bit = 0 */
                        asmbuf_puts(&buf, "    bltu s6, s2, 44f\n    bne s6, s2, 45f\n"
                                          "    bltu s7, s3, 44f\n45:\n"
                                          "    sltu t1, s7, s3\n    sub s7, s7, s3\n"
                                          "    sub s6, s6, s2\n    sub s6, s6, t1\n"
                                          "    li t2, 1\n    j 46f\n44:\n    li t2, 0\n46:\n");
                        /* q = (q << 1) | bit */
                        asmbuf_puts(&buf, "    srli t1, s5, 31\n    slli s4, s4, 1\n"
                                          "    or s4, s4, t1\n    slli s5, s5, 1\n"
                                          "    or s5, s5, t2\n"
                                          "    addi t6, t6, -1\n    bnez t6, 43b\n");
                        if (op == (int)TOK_MOD)
                            asmbuf_puts(&buf, "    mv t0, s6\n    mv t1, s7\n");
                        else
                            asmbuf_puts(&buf, "    mv t0, s4\n    mv t1, s5\n");
                        if (!uns) {
                            /* remainder takes the sign of a, quotient the xor */
                            if (op == (int)TOK_MOD)
                                asmbuf_puts(&buf, "    beqz t4, 47f\n");
                            else
                                asmbuf_puts(&buf, "    xor t4, t4, t5\n    beqz t4, 47f\n");
                            asmbuf_puts(&buf, "    sltu t2, x0, t1\n    sub t1, x0, t1\n"
                                              "    add t0, t0, t2\n    sub t0, x0, t0\n47:\n");
                        }
                        asmbuf_puts(&buf, "    lw s0, 0(sp)\n    lw s1, 4(sp)\n"
                                          "    lw s2, 8(sp)\n    lw s3, 12(sp)\n"
                                          "    lw s4, 16(sp)\n    lw s5, 20(sp)\n"
                                          "    lw s6, 24(sp)\n    lw s7, 28(sp)\n"
                                          "    addi sp, sp, 32\n");
                    } else {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the riscv32 backend does not implement the "
                                  "64-bit operator %s (function '%s')",
                                  diag_num(b1, op), f->name, 0,0,0,0);
                    }
                    asmbuf_puts(&buf, "    sw t0, 0(sp)\n    sw t1, 4(sp)\n");
                    break;
                }
                case IR_64CMP: {
                    int op = I->aux & ~0x100;
                    int uns = (I->aux & 0x100) != 0;
                    /* same layout as IR_64BINARY; the result is one word, so
                     * the net effect is three words fewer on the IR stack */
                    asmbuf_puts(&buf, "    lw t2, 0(sp)\n    lw t3, 4(sp)\n"
                                      "    lw t0, 8(sp)\n    lw t1, 12(sp)\n"
                                      "    addi sp, sp, 12\n");
                    if (op == (int)TOK_EQ || op == (int)TOK_NE) {
                        asmbuf_puts(&buf, "    xor t0, t0, t2\n    xor t1, t1, t3\n    or t0, t0, t1\n");
                        asmbuf_puts(&buf, op == (int)TOK_EQ ? "    seqz t0, t0\n" : "    snez t0, t0\n");
                    } else if (op == (int)TOK_LT || op == (int)TOK_GE) {
                        asmbuf_puts(&buf, "    bne t0, t2, 51f\n    sltu t4, t1, t3\n    j 52f\n51:\n");
                        asmbuf_puts(&buf, uns ? "    sltu t4, t0, t2\n" : "    slt t4, t0, t2\n");
                        asmbuf_puts(&buf, "52:\n    mv t0, t4\n");
                        if (op == (int)TOK_GE) asmbuf_puts(&buf, "    xori t0, t0, 1\n");
                    } else if (op == (int)TOK_GT || op == (int)TOK_LE) {
                        asmbuf_puts(&buf, "    bne t2, t0, 53f\n    sltu t4, t3, t1\n    j 54f\n53:\n");
                        asmbuf_puts(&buf, uns ? "    sltu t4, t2, t0\n" : "    slt t4, t2, t0\n");
                        asmbuf_puts(&buf, "54:\n    mv t0, t4\n");
                        if (op == (int)TOK_LE) asmbuf_puts(&buf, "    xori t0, t0, 1\n");
                    } else {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the riscv32 backend does not implement the "
                                  "64-bit comparison %s (function '%s')",
                                  diag_num(b1, op), f->name, 0,0,0,0);
                    }
                    asmbuf_puts(&buf, "    sw t0, 0(sp)\n");
                    break;
                }
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
                    int n = (int)I->val;
                    int nargs = n;
                    int is_indirect = (I->name && I->name[0] == '?');
                    /* irgen encodes both shapes of the result in val: bit 32
                     * set = two words, bit 33 set = void.  Reading them from
                     * the call expression is the same thing irgen_discard_result
                     * uses to decide how many words to pop, so the two sides
                     * cannot disagree (a lookup in prog->funcs only sees
                     * functions defined in this translation unit). */
                    int is_void_ret = (int)((I->val >> 33) & 1);
                    int is_ret64    = (int)((I->val >> 32) & 1);
                    int kk, total = 0, inreg, off;
                    int abase[64];
                    int awords[64];
                    char b1[12];
                    char b2[12];
                    const int *wires = (I->aux2 > 0) ? &prog->argbytes[I->aux2 - 1] : 0;

                    if (is_indirect) {
                        /* the callee address was pushed after the arguments, so
                         * it is on top */
                        asmbuf_puts(&buf, "    lw t4, 0(sp)\n    addi sp, sp, 4\n");
                        nargs = n - 1;
                    }
                    if (nargs < 0) nargs = 0;
                    if (nargs > 64) {
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "call to '%s' passes %s arguments; the riscv32 "
                                  "backend handles 64",
                                  is_indirect ? "(indirect)" : (I->name ? I->name : "?"),
                                  diag_num(b1, nargs), 0,0,0,0);
                        nargs = 64;
                    }
                    /* Word size of every argument, in argument order.  wires[]
                     * carries the sizes argmask cannot state (a composite wider
                     * than 8 bytes through `...`); argmask itself only covers
                     * the first 16 arguments. */
                    for (kk = 0; kk < nargs; kk++) {
                        int b;
                        if (wires) b = wires[kk];
                        else if (kk < 16 && ((I->aux >> (2 * kk + 1)) & 1)) b = 8;
                        else b = 4;
                        if (b <= 0) b = 4;
                        /* A composite wider than two words reaches here only
                         * through `...` (irgen rejects it for the slot-image
                         * backends).  It is a run of ceil(b/4) consecutive
                         * argument words, word 0 first -- exactly what irgen
                         * pushed, and exactly what <stdarg.h> walks on this
                         * target.  It used to be an error ("passes at most two
                         * words per argument"), which made printf-style code
                         * with a 12-byte structure fail to build on RV32I while
                         * ARM built and ran it.  Only an absurd width is
                         * refused, so the word count cannot overflow the
                         * per-argument arrays below. */
                        if (b > 4 * 60) {
                            diag_tool(DIAG_SEV_ERROR, "arkcc",
                                      "argument %s of the call to '%s' is %s bytes "
                                      "wide; the riscv32 backend passes at most "
                                      "60 words per argument",
                                      diag_num(b1, kk),
                                      is_indirect ? "(indirect)" : (I->name ? I->name : "?"),
                                      diag_num(b2, b), 0,0,0);
                            b = 4 * 60;
                        }
                        abase[kk] = total;
                        awords[kk] = (b + 3) / 4;
                        total += awords[kk];
                    }
                    /* The IR stack holds arg0 on top, and inside a 64-bit value
                     * the high word on top.  Swapping the two words of every
                     * two-word argument turns the whole block into exactly the
                     * hardware word order -- word k at 4*k from sp -- so the
                     * register part is a straight walk and, once eight words
                     * are consumed, sp already points at the first stack
                     * argument word.  That is the same address the callee sees
                     * as 0(s0), so no separate copy step is needed. */
                    off = 0;
                    for (kk = 0; kk < nargs; kk++) {
                        if (awords[kk] == 2) {
                            asmbuf_puts(&buf, "    lw t0, ");
                            asmbuf_int(&buf, off);
                            asmbuf_puts(&buf, "(sp)\n    lw t1, ");
                            asmbuf_int(&buf, off + 4);
                            asmbuf_puts(&buf, "(sp)\n    sw t1, ");
                            asmbuf_int(&buf, off);
                            asmbuf_puts(&buf, "(sp)\n    sw t0, ");
                            asmbuf_int(&buf, off + 4);
                            asmbuf_puts(&buf, "(sp)\n");
                        }
                        off += 4 * awords[kk];
                    }
                    inreg = (total < 8) ? total : 8;
                    for (kk = 0; kk < inreg; kk++) {
                        asmbuf_puts(&buf, "    lw ");
                        asmbuf_puts(&buf, arg_reg_r(kk));
                        asmbuf_puts(&buf, ", ");
                        asmbuf_int(&buf, 4 * kk);
                        asmbuf_puts(&buf, "(sp)\n");
                    }
                    if (inreg > 0) {
                        asmbuf_puts(&buf, "    addi sp, sp, ");
                        asmbuf_int(&buf, 4 * inreg);
                        asmbuf_puts(&buf, "\n");
                    }
                    if (is_indirect) asmbuf_puts(&buf, "    jalr ra, t4, 0\n");
                    else {
                        asmbuf_puts(&buf, "    call ");
                        asmbuf_puts(&buf, I->name);
                        asmbuf_putc(&buf, '\n');
                    }
                    /* drop the stack arguments the callee read */
                    if (total > inreg) rv_sp_adj(&buf, 4 * (total - inreg), 1);
                    if (is_ret64)
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw a0, 0(sp)\n"
                                          "    addi sp, sp, -4\n    sw a1, 0(sp)\n");
                    else if (!is_void_ret)
                        asmbuf_puts(&buf, "    addi sp, sp, -4\n    sw a0, 0(sp)\n");
                    break;
                }
                case IR_RETURN:
                    if (rv_ret_is_two_words(f->ret_type))
                        asmbuf_puts(&buf, "    lw a1, 0(sp)\n    addi sp, sp, 4\n"
                                          "    lw a0, 0(sp)\n    addi sp, sp, 4\n");
                    else
                        asmbuf_puts(&buf, "    lw a0, 0(sp)\n    addi sp, sp, 4\n");
                    rv_pilogue(&buf, sp_size, has_alloca);
                    break;
                case IR_PUSH_GLOBAL_ADDR:
                    /* the address of a global, without reading its value */
                    asmbuf_puts(&buf, "    la t0, ");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_puts(&buf, "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n");
                    break;
                case IR_MEMCPY: {
                    /* whole-object copy: 0(sp) = destination, 4(sp) = source,
                     * val = byte count.  Two words in, *none* out: the C, x86
                     * and arm backends all pop both and push nothing (the C
                     * backend's stack-effect table records "-2", i.e. pop two), and
                     * and a struct-assignment expression keeps its value by
                     * pushing the destination a third time in irgen.  This case
                     * used to push the destination back, so a declaration
                     * initialiser -- `struct S s = va_arg(ap, struct S)`, which
                     * pushes only two words and never pops a result -- leaked one
                     * stack word.  The epilogue then read the saved ra from sp+60
                     * while sp was already 4 bytes low, and `ret` jumped into RAM
                     * (measured as UC_ERR_EXCEPTION at 0x20080004).
                     */
                    int nbytes = (int)I->val;
                    if (nbytes < 0) nbytes = 0;
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    addi sp, sp, 8\n    li t2, 0\n    li t5, ");
                    asmbuf_int(&buf, nbytes & ~3);
                    asmbuf_puts(&buf, "\n    li t6, ");
                    asmbuf_int(&buf, nbytes);
                    asmbuf_puts(&buf, "\n61:\n    bgeu t2, t5, 62f\n"
                                      "    add t3, t1, t2\n    lw t4, 0(t3)\n"
                                      "    add t3, t0, t2\n    sw t4, 0(t3)\n"
                                      "    addi t2, t2, 4\n    j 61b\n"
                                      "62:\n    bgeu t2, t6, 63f\n"
                                      "    add t3, t1, t2\n    lb t4, 0(t3)\n"
                                      "    add t3, t0, t2\n    sb t4, 0(t3)\n"
                                      "    addi t2, t2, 1\n    j 62b\n63:\n");
                    break;
                }
                case IR_LOAD_FLD: {
                    /* bitfield load: val = bit offset within the word, aux low
                     * byte = width, 0x100 = signed.  The field is assumed not to
                     * straddle a word boundary, which is how it was laid out. */
                    int bo = (int)I->val;
                    int bw = I->aux & 0xFF;
                    int sgn = (I->aux & 0x100) != 0;
                    int sh;
                    if (bw <= 0 || bw > 32) {
                        char b1[12];
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "bitfield width %s cannot be emitted by the "
                                  "riscv32 backend (function '%s')",
                                  diag_num(b1, bw), f->name, 0,0,0,0);
                        break;
                    }
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t0, 0(t0)\n");
                    if (bo > 0) {
                        asmbuf_puts(&buf, "    srli t0, t0, ");
                        asmbuf_int(&buf, bo);
                        asmbuf_putc(&buf, '\n');
                    }
                    sh = 32 - bw;
                    if (sh > 0) {
                        asmbuf_puts(&buf, "    slli t0, t0, ");
                        asmbuf_int(&buf, sh);
                        asmbuf_puts(&buf, "\n    ");
                        asmbuf_puts(&buf, (sgn ? "srai" : "srli"));
                        asmbuf_puts(&buf, " t0, t0, ");
                        asmbuf_int(&buf, sh);
                        asmbuf_putc(&buf, '\n');
                    }
                    asmbuf_puts(&buf, "    sw t0, 0(sp)\n");
                    break;
                }
                case IR_STORE_FLD: {
                    /* 0(sp) = value, 4(sp) = address; val = bit offset within
                     * the word, aux = width. */
                    int bo = (int)I->val;
                    int bw = I->aux & 0xFF;
                    unsigned mask_raw, mask_full;
                    char b1[12];
                    if (bw <= 0 || bw > 32) {
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "bitfield width %s cannot be emitted by the "
                                  "riscv32 backend (function '%s')",
                                  diag_num(b1, bw), f->name, 0,0,0,0);
                        break;
                    }
                    mask_raw = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    mask_full = (unsigned)(mask_raw << bo);
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    addi sp, sp, 8\n");
                    asmbuf_puts(&buf, "    li t2, ");
                    asmbuf_int(&buf, (int)mask_raw);
                    asmbuf_puts(&buf, "\n    and t0, t0, t2\n");
                    if (bo > 0) {
                        asmbuf_puts(&buf, "    slli t0, t0, ");
                        asmbuf_int(&buf, bo);
                        asmbuf_putc(&buf, '\n');
                    }
                    asmbuf_puts(&buf, "    li t3, ");
                    asmbuf_int(&buf, (int)mask_full);
                    asmbuf_puts(&buf, "\n    not t3, t3\n    lw t4, 0(t1)\n"
                                      "    and t4, t4, t3\n    or t4, t4, t0\n"
                                      "    sw t4, 0(t1)\n");
                    break;
                }
                case IR_ALLOCA: {
                    /* VLA: irgen emits PUSH(count); PUSH_INT(elem_size);
                     * BINARY(MUL); ALLOCA; STORE.  Pop the byte count, round
                     * it UP to 16 so sp stays call-aligned (the psABI requires
                     * 16 at every call, and a VLA can outlive a call), drop sp
                     * and push the block address.  One pop in, one push out.
                     * `andi` takes a 12-bit signed immediate, so -16 fits.
                     * The matching epilogue rebuilds sp from s0 whenever the
                     * function contains this op. */
                    asmbuf_puts(&buf, "    lw t0, 0(sp)\n"
                                      "    addi t0, t0, 15\n    andi t0, t0, -16\n"
                                      "    sub sp, sp, t0\n    addi sp, sp, -4\n"
                                      "    addi t1, sp, 4\n    sw t1, 0(sp)\n");
                    break;
                }
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
        rv_pilogue(&buf, sp_size, has_alloca);
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

/* ---- RV32I assembler --------------------------------------------------
 *
 * Turns the GAS text this backend emits into a flat RV32I image, so that
 * `arkcc -target riscv32 hello.c -o hello.bin` produces machine code instead
 * of a copy of the assembly text.  The layout is the one a bare
 * `ld -Ttext=0x08000000` gives a single object: .text at the image base, then
 * .rodata, then .data, each aligned.
 *
 * There is no linker behind this stage, so a reference to a symbol this
 * translation unit does not define is an error, not a placeholder.  A flat
 * image that kept a half-written auipc would jump nowhere while arkcc still
 * exited 0, which is exactly the class of silent wrong answer this compiler
 * must not produce.
 *
 * Every RV32I instruction is 4 bytes.  Only the pseudo-instructions are
 * longer, and their length is decided from the immediate alone (`li`) or is
 * fixed (`la` and `call` are 8 bytes), so pass 1 can measure the image
 * without knowing a single address and pass 2 can encode directly.  Numeric
 * local labels (`41:` / `41f` / `43b`) are supported; they are resolved in
 * pass 2 by definition order.
 */
#define RV_IMAGE_BASE   0x08000000
#define RV_SEC_TEXT     0
#define RV_SEC_RODATA   1
#define RV_SEC_DATA     2
#define RV_SEC_COUNT    3

typedef struct RvLabel {
    char *name;      /* named label, or the digits of a numeric local label */
    int   sec;
    int   off;       /* byte offset inside its section */
    int   num;       /* -1 for a named label, else the numeric label's value */
} RvLabel;

/* ---- object mode (-c) --------------------------------------------------
 * A flat image has no linker, so an undefined symbol is an error.  `-c` emits
 * an ARKOBJ2 object instead, where such a reference becomes a relocation the
 * -link driver fills in.  Two kinds cover everything this emitter produces:
 *
 *   RV_RELOC_AUIPC (13): an `auipc rd, hi20` + `addi/jalr rd, rd, lo12` pair
 *       starting at `off`.  At link time d = S - (base + off); the linker
 *       rewrites hi20 as (d + 0x800) >> 12 and lo12 as d - (hi20 << 12).
 *       The displacement is recomputed from the real site, never from an
 *       assembler-time guess, so the two instructions stay where they are.
 *   RV_RELOC_ABS32 (14): a 4-byte absolute address (`.word sym`).  The value
 *       written is image_base + S: a data word carries the address itself, so
 *       there is no base to subtract.
 *
 * A branch (beq/j/jal) to a symbol outside the unit stays an error: its payload
 * is a PC-relative distance limited to +-4 KB / +-1 MB and RV32I has no
 * "materialise then jump" form the assembler could retarget afterwards.
 *
 * Only labels named by `.globl`/`.weak` are exported.  That is what keeps two
 * translation units that both contain `static int helper(void)` from colliding
 * at -link, and it is why the emitter now says so instead of gluing `.globl`
 * onto every function. */
typedef struct RvReloc {
    int  off;
    int  type;
    char name[96];
} RvReloc;

typedef struct RvExport {
    char name[96];
    int  weak;
} RvExport;

typedef struct RvAsm {
    const char    *src;
    unsigned char *out;
    int            out_cap;
    int            sec_pc[RV_SEC_COUNT];    /* bytes measured in each section */
    int            sec_base[RV_SEC_COUNT];  /* image offset of each section */
    int            cur_sec;
    RvLabel       *labels;
    int            label_count, label_cap;
    int            hard_errors;
    int            overflow_reported;
    int            line;
    int            emit;   /* 0 = pass 1 (measure), 1 = pass 2 (encode) */
    int            seen;   /* label definitions met so far in pass 2 */
    int            obj;    /* 1 = -c: undefined symbols become relocations */
    RvReloc       *relocs;
    int            reloc_count, reloc_cap;
    RvExport      *exports;   /* names declared by .globl / .weak */
    int            export_count, export_cap;
} RvAsm;

static int rv_a_alpha(int c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_' || c == '.';
}
static int rv_a_digit(int c) { return c >= '0' && c <= '9'; }
static int rv_a_hex(int c) {
    return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F');
}
static int rv_a_ident(int c) {
    return rv_a_alpha(c) || rv_a_digit(c) || c == '$';
}
static void rv_skip_ws(const char **p) {
    while (**p == ' ' || **p == '\t') (*p)++;
}
static int rv_streq_(const char *a, const char *b) {
    while (*a && *b) {
        if (*a != *b) return 0;
        a++; b++;
    }
    return *a == 0 && *b == 0;
}
static int rv_align16(int v) { return (v + 15) & ~15; }

/* Every diagnostic carries the assembly line number as its first argument;
 * a0/a1 are the two optional values of the message's other placeholders. */
static void rv_error(RvAsm *a, const char *msg, const char *a0, const char *a1) {
    char b1[12];
    a->hard_errors++;
    diag_tool(DIAG_SEV_ERROR, "arkcc", msg, diag_num(b1, a->line), a0, a1, 0, 0, 0);
}

static void rv_add_label(RvAsm *a, const char *name, int num) {
    if (a->label_count >= a->label_cap) {
        int nc = a->label_cap == 0 ? 64 : a->label_cap * 2;
        a->labels = (RvLabel *)mem_realloc(a->labels,
            a->label_cap * (int)sizeof(RvLabel),
            nc * (int)sizeof(RvLabel));
        a->label_cap = nc;
    }
    a->labels[a->label_count].name = mem_strdup(name);
    a->labels[a->label_count].sec = a->cur_sec;
    a->labels[a->label_count].off = a->sec_pc[a->cur_sec];
    a->labels[a->label_count].num = num;
    a->label_count++;
}

/* Offset of the current position inside the object/blob. This is the
 * coordinate relocations are recorded in: the linker adds the object's base,
 * so RV_IMAGE_BASE must not be in it (it cancels on both sides of a PC-relative
 * displacement, and a .word gets it added explicitly). */
static int rv_here_off(RvAsm *a) {
    return a->sec_base[a->cur_sec] + a->sec_pc[a->cur_sec];
}

static void rv_add_reloc(RvAsm *a, const char *name, int off, int type) {
    int k;
    if (a->reloc_count >= a->reloc_cap) {
        int nc = a->reloc_cap == 0 ? 16 : a->reloc_cap * 2;
        a->relocs = (RvReloc *)mem_realloc(a->relocs,
            a->reloc_cap * (int)sizeof(RvReloc),
            nc * (int)sizeof(RvReloc));
        a->reloc_cap = nc;
    }
    a->relocs[a->reloc_count].off  = off;
    a->relocs[a->reloc_count].type = type;
    for (k = 0; k < (int)sizeof(a->relocs[0].name) - 1 && name[k]; k++)
        a->relocs[a->reloc_count].name[k] = name[k];
    a->relocs[a->reloc_count].name[k] = 0;
    a->reloc_count++;
}

/* .globl / .weak both run in pass 1 and pass 2, so the same name arrives
 * twice; a second declaration only ever upgrades local -> weak -> strong in
 * practice being impossible (the emitter says one thing per symbol), so the
 * first entry wins except for the weak flag, which a repeat must not clobber. */
static void rv_add_export(RvAsm *a, const char *name, int weak) {
    int k, n;
    for (k = 0; k < a->export_count; k++)
        if (rv_streq_(a->exports[k].name, name)) {
            if (!weak) a->exports[k].weak = 0;
            return;
        }
    if (a->export_count >= a->export_cap) {
        int nc = a->export_cap == 0 ? 16 : a->export_cap * 2;
        a->exports = (RvExport *)mem_realloc(a->exports,
            a->export_cap * (int)sizeof(RvExport),
            nc * (int)sizeof(RvExport));
        a->export_cap = nc;
    }
    n = a->export_count++;
    for (k = 0; k < (int)sizeof(a->exports[0].name) - 1 && name[k]; k++)
        a->exports[n].name[k] = name[k];
    a->exports[n].name[k] = 0;
    a->exports[n].weak = weak;
}

static int rv_exported(RvAsm *a, const char *name, int *weak) {
    int k;
    for (k = 0; k < a->export_count; k++)
        if (rv_streq_(a->exports[k].name, name)) {
            if (weak) *weak = a->exports[k].weak;
            return 1;
        }
    return 0;
}

/* Absolute address of a named label, or -1 when this unit does not define it. */
static int rv_named_addr(RvAsm *a, const char *name) {
    int i;
    for (i = 0; i < a->label_count; i++) {
        if (a->labels[i].num >= 0) continue;
        if (rv_streq_(a->labels[i].name, name))
            return RV_IMAGE_BASE + a->sec_base[a->labels[i].sec] + a->labels[i].off;
    }
    return -1;
}

/* Absolute address of the nearest numeric label `num` in direction `dir`
 * (1 = forward, -1 = backward), or -1.  Definition order is the array order,
 * and `a->seen` counts the definitions pass 2 has already walked past. */
static int rv_numeric_addr(RvAsm *a, int num, int dir) {
    int i;
    if (dir > 0) {
        for (i = a->seen; i < a->label_count; i++)
            if (a->labels[i].num == num)
                return RV_IMAGE_BASE + a->sec_base[a->labels[i].sec] + a->labels[i].off;
    } else {
        for (i = a->seen - 1; i >= 0; i--)
            if (a->labels[i].num == num)
                return RV_IMAGE_BASE + a->sec_base[a->labels[i].sec] + a->labels[i].off;
    }
    return -1;
}

static int rv_read_ident(const char **p, char *buf, int cap) {
    int n = 0;
    rv_skip_ws(p);
    while (rv_a_ident((unsigned char)**p)) {
        if (n < cap - 1) buf[n] = **p;
        n++;
        (*p)++;
    }
    buf[n < cap ? n : cap - 1] = 0;
    return n;
}

static int rv_read_ll(const char **p, long long *out) {
    const char *s = *p;
    unsigned long long v = 0ULL;
    int neg = 0, any = 0, base = 10, d;
    rv_skip_ws(&s);
    if (*s == '-') { neg = 1; s++; }
    else if (*s == '+') s++;
    if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X')) { base = 16; s += 2; }
    while (*s) {
        if (rv_a_digit((unsigned char)*s)) d = *s - '0';
        else if (base == 16 && rv_a_hex((unsigned char)*s))
            d = (*s >= 'a') ? (*s - 'a' + 10) : (*s >= 'A') ? (*s - 'A' + 10) : (*s - '0');
        else break;
        v = v * (unsigned)base + (unsigned)d;
        s++;
        any++;
    }
    if (!any) return 0;
    *out = neg ? -(long long)v : (long long)v;
    *p = s;
    return 1;
}

static int rv_read_reg(const char **p) {
    static const struct { const char *n; int r; } tab[] = {
        {"zero",0},{"ra",1},{"sp",2},{"gp",3},{"tp",4},
        {"t0",5},{"t1",6},{"t2",7},{"s0",8},{"fp",8},{"s1",9},
        {"a0",10},{"a1",11},{"a2",12},{"a3",13},{"a4",14},{"a5",15},
        {"a6",16},{"a7",17},{"s2",18},{"s3",19},{"s4",20},{"s5",21},
        {"s6",22},{"s7",23},{"s8",24},{"s9",25},{"s10",26},{"s11",27},
        {"t3",28},{"t4",29},{"t5",30},{"t6",31}
    };
    const char *s = *p;
    char name[8];
    int n, i;
    n = rv_read_ident(&s, name, (int)sizeof(name));
    if (n == 0) return -1;
    if (name[0] == 'x' && name[1]) {
        long long v = 0;
        const char *q = name + 1;
        if (!rv_read_ll(&q, &v) || *q) return -1;
        if (v < 0 || v > 31) return -1;
        *p = s;
        return (int)v;
    }
    for (i = 0; i < (int)(sizeof(tab) / sizeof(tab[0])); i++)
        if (rv_streq_(tab[i].n, name)) { *p = s; return tab[i].r; }
    return -1;
}

/* off(base) */
static int rv_read_mem(const char **p, int *off, int *base_reg) {
    long long v = 0;
    int r;
    const char *s = *p;
    rv_skip_ws(&s);
    if (!rv_read_ll(&s, &v)) return 0;
    rv_skip_ws(&s);
    if (*s != '(') return 0;
    s++;
    r = rv_read_reg(&s);
    if (r < 0) return 0;
    rv_skip_ws(&s);
    if (*s != ')') return 0;
    s++;
    *off = (int)v;
    *base_reg = r;
    *p = s;
    return 1;
}

/* A symbol operand: a named label, or a numeric local label spelled `41f` /
 * `43b`.  `dir_out` is 0 for a named label, +1 for f, -1 for b. */
static int rv_read_symbol(const char **p, char *buf, int cap, int *dir_out) {
    const char *s = *p;
    int n = 0;
    rv_skip_ws(&s);
    *dir_out = 0;
    if (rv_a_digit((unsigned char)*s)) {
        while (rv_a_digit((unsigned char)*s)) {
            if (n < cap - 1) buf[n] = *s;
            n++;
            s++;
        }
        buf[n < cap ? n : cap - 1] = 0;
        if (*s == 'f' || *s == 'b') {
            *dir_out = (*s == 'f') ? 1 : -1;
            *p = s + 1;
            return 1;
        }
        return 0;
    }
    if (!rv_a_alpha((unsigned char)*s)) return 0;
    rv_read_ident(&s, buf, cap);
    *p = s;
    return 1;
}

static void rv_put32(RvAsm *a, int sec, int off, unsigned int w) {
    int idx = a->sec_base[sec] + off;
    if (!a->emit) return;
    if (idx < 0 || idx + 4 > a->out_cap) {
        if (!a->overflow_reported) {
            a->overflow_reported = 1;
            rv_error(a, "line %s: the riscv32 image does not fit the output buffer",
                     "", "");
        }
        a->hard_errors++;
        return;
    }
    a->out[idx]     = (unsigned char)(w & 0xFF);
    a->out[idx + 1] = (unsigned char)((w >> 8) & 0xFF);
    a->out[idx + 2] = (unsigned char)((w >> 16) & 0xFF);
    a->out[idx + 3] = (unsigned char)((w >> 24) & 0xFF);
}
static void rv_put8(RvAsm *a, int sec, int off, unsigned char b) {
    int idx = a->sec_base[sec] + off;
    if (!a->emit) return;
    if (idx < 0 || idx + 1 > a->out_cap) {
        if (!a->overflow_reported) {
            a->overflow_reported = 1;
            rv_error(a, "line %s: the riscv32 image does not fit the output buffer",
                     "", "");
        }
        a->hard_errors++;
        return;
    }
    a->out[idx] = b;
}
static void rv_advance(RvAsm *a, int bytes) { a->sec_pc[a->cur_sec] += bytes; }
static int rv_here(RvAsm *a) {
    return RV_IMAGE_BASE + a->sec_base[a->cur_sec] + a->sec_pc[a->cur_sec];
}

/* ---- instruction encoders -------------------------------------------- */
static unsigned int rv_enc_r(int f7, int rs2, int rs1, int f3, int rd, int op) {
    return ((unsigned)(f7 & 0x7F) << 25) | ((unsigned)(rs2 & 0x1F) << 20) |
           ((unsigned)(rs1 & 0x1F) << 15) | ((unsigned)(f3 & 0x7) << 12) |
           ((unsigned)(rd & 0x1F) << 7) | (unsigned)(op & 0x7F);
}
static unsigned int rv_enc_i(int imm, int rs1, int f3, int rd, int op) {
    return ((unsigned)(imm & 0xFFF) << 20) | ((unsigned)(rs1 & 0x1F) << 15) |
           ((unsigned)(f3 & 0x7) << 12) | ((unsigned)(rd & 0x1F) << 7) |
           (unsigned)(op & 0x7F);
}
static unsigned int rv_enc_s(int imm, int rs2, int rs1, int f3, int op) {
    unsigned u = (unsigned)imm;
    return (((u >> 5) & 0x7F) << 25) | ((unsigned)(rs2 & 0x1F) << 20) |
           ((unsigned)(rs1 & 0x1F) << 15) | ((unsigned)(f3 & 0x7) << 12) |
           ((u & 0x1F) << 7) | (unsigned)(op & 0x7F);
}
static unsigned int rv_enc_b(int imm, int rs2, int rs1, int f3, int op) {
    unsigned u = (unsigned)imm;
    return (((u >> 12) & 0x1) << 31) | (((u >> 5) & 0x3F) << 25) |
           ((unsigned)(rs2 & 0x1F) << 20) | ((unsigned)(rs1 & 0x1F) << 15) |
           ((unsigned)(f3 & 0x7) << 12) | (((u >> 1) & 0xF) << 8) |
           (((u >> 11) & 0x1) << 7) | (unsigned)(op & 0x7F);
}
static unsigned int rv_enc_u(int imm, int rd, int op) {
    return ((unsigned)(imm & 0xFFFFF) << 12) | ((unsigned)(rd & 0x1F) << 7) |
           (unsigned)(op & 0x7F);
}
static unsigned int rv_enc_j(int imm, int rd, int op) {
    unsigned u = (unsigned)imm;
    return (((u >> 20) & 0x1) << 31) | (((u >> 1) & 0x3FF) << 21) |
           (((u >> 11) & 0x1) << 20) | (((u >> 12) & 0xFF) << 12) |
           ((unsigned)(rd & 0x1F) << 7) | (unsigned)(op & 0x7F);
}

#define RV_OP_RTYPE   0x33
#define RV_OP_IMM     0x13
#define RV_OP_LOAD    0x03
#define RV_OP_STORE   0x23
#define RV_OP_BRANCH  0x63
#define RV_OP_JAL     0x6F
#define RV_OP_JALR    0x67
#define RV_OP_LUI     0x37
#define RV_OP_AUIPC   0x17

/* Write one 4-byte instruction and advance the section cursor. */
static void rv_ins(RvAsm *a, unsigned int w) {
    rv_put32(a, a->cur_sec, a->sec_pc[a->cur_sec], w);
    rv_advance(a, 4);
}

/* lui + addi pair that materialises a 32-bit constant in `rd` (8 bytes). */
static void rv_li32(RvAsm *a, int rd, unsigned int u) {
    unsigned int hi = (unsigned int)((((unsigned long long)u + 0x800ULL) >> 12) & 0xFFFFF);
    int lo = (int)(u & 0xFFF);
    if (lo & 0x800) lo -= 0x1000;
    rv_ins(a, rv_enc_u((int)hi, rd, RV_OP_LUI));
    rv_ins(a, rv_enc_i(lo, rd, 0, rd, RV_OP_IMM));
}
static int rv_li_needs_pair(int v) { return !(v >= -2048 && v <= 2047); }

/* auipc + addi / auipc + jalr pair reaching `addr` from `pc` (8 bytes). */
static void rv_pcrel_pair(RvAsm *a, int rd, int addr, int pc, int use_jalr) {
    long long d = (long long)addr - (long long)pc;
    long long hi = (d + 0x800) >> 12;
    int lo = (int)(d - (hi << 12));
    rv_ins(a, rv_enc_u((int)(hi & 0xFFFFF), rd, RV_OP_AUIPC));
    if (use_jalr) rv_ins(a, rv_enc_i(lo, rd, 0, rd, RV_OP_JALR));
    else          rv_ins(a, rv_enc_i(lo, rd, 0, rd, RV_OP_IMM));
}

/* Resolve a symbol operand to an absolute address, or -1. */
static int rv_sym_addr(RvAsm *a, const char *name, int dir) {
    int num = 0, k = 0;
    if (dir) {
        while (name[k]) { num = num * 10 + (name[k] - '0'); k++; }
        return rv_numeric_addr(a, num, dir);
    }
    return rv_named_addr(a, name);
}

/* ---- one instruction -------------------------------------------------- */
static void rv_insn(RvAsm *a, const char **pp) {
    static const struct { const char *n; int f3; int f7; } rtab[] = {
        {"add",0x0,0x00},{"sub",0x0,0x20},{"sll",0x1,0x00},{"slt",0x2,0x00},
        {"sltu",0x3,0x00},{"xor",0x4,0x00},{"srl",0x5,0x00},{"sra",0x5,0x20},
        {"or",0x6,0x00},{"and",0x7,0x00},
        {"mul",0x0,0x01},{"div",0x4,0x01},{"divu",0x5,0x01},
        {"rem",0x6,0x01},{"remu",0x7,0x01}
    };
    static const struct { const char *n; int f3; } itab[] = {
        {"addi",0x0},{"slti",0x2},{"sltiu",0x3},{"xori",0x4},
        {"ori",0x6},{"andi",0x7}
    };
    static const struct { const char *n; int f3; int sh; } stab[] = {
        {"slli",0x1,0x00},{"srli",0x5,0x00},{"srai",0x5,0x20}
    };
    static const struct { const char *n; int f3; } ltab[] = {
        {"lb",0x0},{"lh",0x1},{"lw",0x2},{"lbu",0x4},{"lhu",0x5}
    };
    static const struct { const char *n; int f3; } sstab[] = {
        {"sb",0x0},{"sh",0x1},{"sw",0x2}
    };
    static const struct { const char *n; int f3; } btab[] = {
        {"beq",0x0},{"bne",0x1},{"blt",0x4},{"bge",0x5},{"bltu",0x6},{"bgeu",0x7}
    };
    const char *p = *pp;
    char mn[16];
    int i, n;
    long long imm = 0;
    char sym[96];
    int dir = 0, addr;

    rv_skip_ws(&p);
    n = rv_read_ident(&p, mn, (int)sizeof(mn));
    if (n == 0) {
        rv_error(a, "line %s: expected an instruction", "", "");
        return;
    }

    /* ---- pseudo-instructions ------------------------------------------ */
    if (rv_streq_(mn, "li")) {
        int rd = rv_read_reg(&p);
        int v;
        if (rd < 0) { rv_error(a, "line %s: 'li' needs a register", "", ""); return; }
        rv_skip_ws(&p);
        if (*p++ != ',') { rv_error(a, "line %s: 'li' needs a comma", "", ""); return; }
        if (!rv_read_ll(&p, &imm)) {
            rv_error(a, "line %s: 'li' needs an immediate", "", "");
            return;
        }
        /* The emitter prints a word constant as the unsigned 32-bit value
         * it is (`li t0, 4294967295` for -1), and GNU as accepts that by
         * taking the low 32 bits.  Do the same, but nothing wider: a value
         * that cannot be a 32-bit pattern is a real error. */
        if (imm < -2147483647LL - 1 || imm > 4294967295LL) {
            rv_error(a, "line %s: the 'li' immediate does not fit 32 bits", "", "");
            return;
        }
        v = (int)(unsigned int)(unsigned long long)imm;
        if (!rv_li_needs_pair(v)) rv_ins(a, rv_enc_i(v, 0, 0, rd, RV_OP_IMM));
        else rv_li32(a, rd, (unsigned int)v);
        *pp = p;
        return;
    }
    if (rv_streq_(mn, "la") || rv_streq_(mn, "call")) {
        int is_call = rv_streq_(mn, "call");
        int rd = 1;
        if (!is_call) {
            rd = rv_read_reg(&p);
            if (rd < 0) { rv_error(a, "line %s: 'la' needs a register", "", ""); return; }
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: 'la' needs a comma", "", ""); return; }
        }
        if (!rv_read_symbol(&p, sym, (int)sizeof(sym), &dir)) {
            rv_error(a, "line %s: the operand must be a symbol", "", "");
            return;
        }
        if (!a->emit) { rv_advance(a, 8); *pp = p; return; }
        addr = rv_sym_addr(a, sym, dir);
        if (addr < 0) {
            if (a->obj && dir == 0) {
                /* Object mode: record the site and emit a zero displacement.
                 * A zero here is not a wrong answer -- it is an unrelocated
                 * site, and -link refuses to write an image while one is left
                 * (or while the symbol it names is missing). */
                rv_add_reloc(a, sym, rv_here_off(a), RV_RELOC_AUIPC);
                rv_ins(a, rv_enc_u(0, rd, RV_OP_AUIPC));
                if (is_call) rv_ins(a, rv_enc_i(0, rd, 0, rd, RV_OP_JALR));
                else         rv_ins(a, rv_enc_i(0, rd, 0, rd, RV_OP_IMM));
                *pp = p;
                return;
            }
            rv_error(a, "line %s: '%s' is not a symbol this translation unit "
                        "defines; a flat image has no linker to fill it in", sym, "");
            return;
        }
        rv_pcrel_pair(a, rd, addr, rv_here(a), is_call);
        *pp = p;
        return;
    }
    if (rv_streq_(mn, "mv")) {
        int rd = rv_read_reg(&p), rs;
        rv_skip_ws(&p);
        if (*p++ != ',') { rv_error(a, "line %s: 'mv' needs a comma", "", ""); return; }
        rs = rv_read_reg(&p);
        if (rd < 0 || rs < 0) { rv_error(a, "line %s: 'mv' needs two registers", "", ""); return; }
        rv_ins(a, rv_enc_i(0, rs, 0, rd, RV_OP_IMM));
        *pp = p;
        return;
    }
    if (rv_streq_(mn, "ret")) {
        rv_ins(a, rv_enc_i(0, 1, 0, 0, RV_OP_JALR));
        *pp = p;
        return;
    }
    if (rv_streq_(mn, "nop")) {
        rv_ins(a, rv_enc_i(0, 0, 0, 0, RV_OP_IMM));
        *pp = p;
        return;
    }
    if (rv_streq_(mn, "jr")) {
        int rs = rv_read_reg(&p);
        if (rs < 0) { rv_error(a, "line %s: 'jr' needs a register", "", ""); return; }
        rv_ins(a, rv_enc_i(0, rs, 0, 0, RV_OP_JALR));
        *pp = p;
        return;
    }
    if (rv_streq_(mn, "j") || rv_streq_(mn, "beqz") || rv_streq_(mn, "bnez") ||
        rv_streq_(mn, "beq") || rv_streq_(mn, "bne") || rv_streq_(mn, "blt") ||
        rv_streq_(mn, "bge") || rv_streq_(mn, "bltu") || rv_streq_(mn, "bgeu") ||
        rv_streq_(mn, "jal")) {
        int rs1 = -1, rs2 = -1, f3 = 0, is_j = 0, is_jal = 0;
        int rel;
        if (rv_streq_(mn, "j") || rv_streq_(mn, "jal")) {
            is_j = rv_streq_(mn, "j");
            is_jal = !is_j;
            if (is_jal) {
                rs2 = rv_read_reg(&p);   /* rd, actually */
                if (rs2 < 0) { rv_error(a, "line %s: 'jal' needs a register", "", ""); return; }
                rv_skip_ws(&p);
                if (*p++ != ',') { rv_error(a, "line %s: 'jal' needs a comma", "", ""); return; }
            }
        } else if (rv_streq_(mn, "beqz") || rv_streq_(mn, "bnez")) {
            rs1 = rv_read_reg(&p);
            f3 = (mn[2] == 'q') ? 0x0 : 0x1;
            if (rs1 < 0) { rv_error(a, "line %s: the branch needs a register", "", ""); return; }
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: the branch needs a label", "", ""); return; }
        } else {
            rs1 = rv_read_reg(&p);
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: the branch needs a comma", "", ""); return; }
            rs2 = rv_read_reg(&p);
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: the branch needs a label", "", ""); return; }
            if (rs1 < 0 || rs2 < 0) {
                rv_error(a, "line %s: the branch needs two registers", "", "");
                return;
            }
            for (i = 0; i < (int)(sizeof(btab) / sizeof(btab[0])); i++)
                if (rv_streq_(btab[i].n, mn)) f3 = btab[i].f3;
        }
        if (!rv_read_symbol(&p, sym, (int)sizeof(sym), &dir)) {
            rv_error(a, "line %s: the operand must be a label", "", "");
            return;
        }
        if (!a->emit) { rv_advance(a, 4); *pp = p; return; }
        addr = rv_sym_addr(a, sym, dir);
        if (addr < 0) {
            if (a->obj && dir == 0)
                rv_error(a, "line %s: the branch to '%s' cannot cross objects: "
                            "RV32I encodes it as a PC-relative distance, so the "
                            "target has to be defined in this translation unit "
                            "(call it as a function instead)", sym, "");
            else
                rv_error(a, "line %s: '%s' is not a label this translation unit "
                            "defines", sym, "");
            return;
        }
        rel = addr - rv_here(a);
        if (is_j || is_jal) {
            if (rel < -(1 << 20) || rel >= (1 << 20) || (rel & 1)) {
                rv_error(a, "line %s: the jump to '%s' is outside the 21-bit "
                            "RV32I jal displacement", sym, "");
                return;
            }
            rv_ins(a, rv_enc_j(rel, is_j ? 0 : rs2, RV_OP_JAL));
        } else {
            if (rel < -4096 || rel > 4094 || (rel & 1)) {
                rv_error(a, "line %s: the branch to '%s' is outside the 13-bit "
                            "RV32I displacement", sym, "");
                return;
            }
            rv_ins(a, rv_enc_b(rel, rs2 < 0 ? 0 : rs2, rs1, f3, RV_OP_BRANCH));
        }
        *pp = p;
        return;
    }
    if (rv_streq_(mn, "seqz") || rv_streq_(mn, "snez") || rv_streq_(mn, "not") ||
        rv_streq_(mn, "neg")) {
        int rd = rv_read_reg(&p), rs;
        rv_skip_ws(&p);
        if (*p++ != ',') { rv_error(a, "line %s: the operand list needs a comma", "", ""); return; }
        rs = rv_read_reg(&p);
        if (rd < 0 || rs < 0) {
            rv_error(a, "line %s: the pseudo-instruction needs two registers", "", "");
            return;
        }
        if (rv_streq_(mn, "seqz"))      rv_ins(a, rv_enc_i(1, rs, 0x3, rd, RV_OP_IMM));
        else if (rv_streq_(mn, "snez")) rv_ins(a, rv_enc_r(0x00, rs, 0, 0x3, rd, RV_OP_RTYPE));
        else if (rv_streq_(mn, "not"))  rv_ins(a, rv_enc_i(-1, rs, 0x4, rd, RV_OP_IMM));
        else                            rv_ins(a, rv_enc_r(0x20, rs, 0, 0x0, rd, RV_OP_RTYPE));
        *pp = p;
        return;
    }
    if (rv_streq_(mn, "lui") || rv_streq_(mn, "auipc")) {
        int rd = rv_read_reg(&p);
        rv_skip_ws(&p);
        if (*p++ != ',') { rv_error(a, "line %s: the operand list needs a comma", "", ""); return; }
        if (rd < 0 || !rv_read_ll(&p, &imm)) {
            rv_error(a, "line %s: needs a register and an immediate", "", "");
            return;
        }
        if (imm < -2147483648LL || imm > 4294967295LL) {
            rv_error(a, "line %s: the immediate does not fit 32 bits", "", "");
            return;
        }
        rv_ins(a, rv_enc_u((int)((unsigned long long)imm & 0xFFFFF),
                           rd, rv_streq_(mn, "lui") ? RV_OP_LUI : RV_OP_AUIPC));
        *pp = p;
        return;
    }
    if (rv_streq_(mn, "jalr")) {
        int rd = rv_read_reg(&p), rs = -1, off = 0;
        const char *save;
        if (rd < 0) { rv_error(a, "line %s: 'jalr' needs a register", "", ""); return; }
        rv_skip_ws(&p);
        if (*p++ != ',') { rv_error(a, "line %s: 'jalr' needs a comma", "", ""); return; }
        save = p;
        if (!rv_read_mem(&p, &off, &rs)) {
            p = save;
            rs = rv_read_reg(&p);
            if (rs < 0) { rv_error(a, "line %s: 'jalr' needs a register", "", ""); return; }
            rv_skip_ws(&p);
            if (*p == ',') {
                p++;
                if (!rv_read_ll(&p, &imm) || imm < -2048 || imm > 2047) {
                    rv_error(a, "line %s: the 'jalr' offset is outside the 12-bit "
                                "immediate", "", "");
                    return;
                }
                off = (int)imm;
            }
        }
        rv_ins(a, rv_enc_i(off, rs, 0, rd, RV_OP_JALR));
        *pp = p;
        return;
    }

    /* ---- base instruction forms --------------------------------------- */
    for (i = 0; i < (int)(sizeof(rtab) / sizeof(rtab[0])); i++) {
        if (rv_streq_(rtab[i].n, mn)) {
            int rd = rv_read_reg(&p), rs1, rs2;
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: the operand list needs a comma", "", ""); return; }
            rs1 = rv_read_reg(&p);
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: this instruction needs three registers", "", ""); return; }
            rs2 = rv_read_reg(&p);
            if (rd < 0 || rs1 < 0 || rs2 < 0) {
                rv_error(a, "line %s: this instruction needs three registers", "", "");
                return;
            }
            rv_ins(a, rv_enc_r(rtab[i].f7, rs2, rs1, rtab[i].f3, rd, RV_OP_RTYPE));
            *pp = p;
            return;
        }
    }
    for (i = 0; i < (int)(sizeof(itab) / sizeof(itab[0])); i++) {
        if (rv_streq_(itab[i].n, mn)) {
            int rd = rv_read_reg(&p), rs1;
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: the operand list needs a comma", "", ""); return; }
            rs1 = rv_read_reg(&p);
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: this instruction needs an immediate", "", ""); return; }
            if (rd < 0 || rs1 < 0 || !rv_read_ll(&p, &imm)) {
                rv_error(a, "line %s: this instruction needs two registers and an "
                            "immediate", "", "");
                return;
            }
            if (imm < -2048 || imm > 2047) {
                rv_error(a, "line %s: the immediate is outside the 12-bit signed "
                            "range of this instruction", "", "");
                return;
            }
            rv_ins(a, rv_enc_i((int)imm, rs1, itab[i].f3, rd, RV_OP_IMM));
            *pp = p;
            return;
        }
    }
    for (i = 0; i < (int)(sizeof(stab) / sizeof(stab[0])); i++) {
        if (rv_streq_(stab[i].n, mn)) {
            int rd = rv_read_reg(&p), rs1;
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: the operand list needs a comma", "", ""); return; }
            rs1 = rv_read_reg(&p);
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: this instruction needs a shift amount", "", ""); return; }
            if (rd < 0 || rs1 < 0 || !rv_read_ll(&p, &imm)) {
                rv_error(a, "line %s: this instruction needs two registers and a "
                            "shift amount", "", "");
                return;
            }
            if (imm < 0 || imm > 31) {
                rv_error(a, "line %s: the shift amount must be 0..31", "", "");
                return;
            }
            rv_ins(a, rv_enc_i((stab[i].sh << 5) | (int)(imm & 0x1F), rs1,
                               stab[i].f3, rd, RV_OP_IMM));
            *pp = p;
            return;
        }
    }
    for (i = 0; i < (int)(sizeof(ltab) / sizeof(ltab[0])); i++) {
        if (rv_streq_(ltab[i].n, mn)) {
            int rd = rv_read_reg(&p), rb = -1, off = 0;
            if (rd < 0) { rv_error(a, "line %s: the load needs a register", "", ""); return; }
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: the operand list needs a comma", "", ""); return; }
            if (!rv_read_mem(&p, &off, &rb)) {
                rv_error(a, "line %s: the load needs an offset(base) operand", "", "");
                return;
            }
            if (off < -2048 || off > 2047) {
                rv_error(a, "line %s: the load offset is outside the 12-bit signed "
                            "range", "", "");
                return;
            }
            rv_ins(a, rv_enc_i(off, rb, ltab[i].f3, rd, RV_OP_LOAD));
            *pp = p;
            return;
        }
    }
    for (i = 0; i < (int)(sizeof(sstab) / sizeof(sstab[0])); i++) {
        if (rv_streq_(sstab[i].n, mn)) {
            int rs2 = rv_read_reg(&p), rb = -1, off = 0;
            if (rs2 < 0) { rv_error(a, "line %s: the store needs a register", "", ""); return; }
            rv_skip_ws(&p);
            if (*p++ != ',') { rv_error(a, "line %s: the operand list needs a comma", "", ""); return; }
            if (!rv_read_mem(&p, &off, &rb)) {
                rv_error(a, "line %s: the store needs an offset(base) operand", "", "");
                return;
            }
            if (off < -2048 || off > 2047) {
                rv_error(a, "line %s: the store offset is outside the 12-bit signed "
                            "range", "", "");
                return;
            }
            rv_ins(a, rv_enc_s(off, rs2, rb, sstab[i].f3, RV_OP_STORE));
            *pp = p;
            return;
        }
    }
    rv_error(a, "line %s: unknown riscv32 mnemonic '%s'", mn, "");
    *pp = p;
}

/* ---- string literal --------------------------------------------------- */
static void rv_string(RvAsm *a, const char **pp, int zero_terminated) {
    const char *p = *pp;
    rv_skip_ws(&p);
    if (*p != '"') {
        rv_error(a, "line %s: expected a quoted string", "", "");
        return;
    }
    p++;
    while (*p && *p != '"') {
        int c = (unsigned char)*p++;
        if (c == '\\') {
            int e = (unsigned char)*p;
            if (e == 0) break;
            p++;
            if (e == 'n') c = 10;
            else if (e == 't') c = 9;
            else if (e == 'r') c = 13;
            else if (e == '0') c = 0;
            else if (e == 'a') c = 7;
            else if (e == 'b') c = 8;
            else if (e == 'f') c = 12;
            else if (e == 'v') c = 11;
            else if (e == '\\') c = 92;
            else if (e == '"') c = 34;
            else if (e >= '0' && e <= '7') {
                int v = e - '0', k = 1;
                while (k < 3 && *p >= '0' && *p <= '7') { v = v * 8 + (*p - '0'); p++; k++; }
                c = v & 0xFF;
            } else if (e == 'x') {
                int v = 0, k = 0;
                while (k < 2 && rv_a_hex((unsigned char)*p)) {
                    v = v * 16 + ((*p >= 'a') ? (*p - 'a' + 10)
                                 : (*p >= 'A') ? (*p - 'A' + 10) : (*p - '0'));
                    p++;
                    k++;
                }
                c = v & 0xFF;
            } else c = e;
        }
        rv_put8(a, a->cur_sec, a->sec_pc[a->cur_sec], (unsigned char)c);
        rv_advance(a, 1);
    }
    if (*p == '"') p++;
    else rv_error(a, "line %s: unterminated string literal", "", "");
    if (zero_terminated) {
        rv_put8(a, a->cur_sec, a->sec_pc[a->cur_sec], 0);
        rv_advance(a, 1);
    }
    *pp = p;
}

/* ---- one directive ---------------------------------------------------- */
static void rv_directive(RvAsm *a, const char **pp) {
    const char *p = *pp;
    char d[24];
    long long v = 0;
    int n;
    char sym[96];
    int dir = 0, addr;

    p++;    /* the '.' */
    n = rv_read_ident(&p, d, (int)sizeof(d));
    if (n == 0) { rv_error(a, "line %s: malformed directive", "", ""); return; }

    if (rv_streq_(d, "text")) { a->cur_sec = RV_SEC_TEXT; *pp = p; return; }
    if (rv_streq_(d, "data")) { a->cur_sec = RV_SEC_DATA; *pp = p; return; }
    if (rv_streq_(d, "section")) {
        char sec[24];
        rv_skip_ws(&p);
        if (!rv_read_ident(&p, sec, (int)sizeof(sec))) {
            rv_error(a, "line %s: '.section' needs a name", "", "");
            return;
        }
        if (rv_streq_(sec, ".rodata")) a->cur_sec = RV_SEC_RODATA;
        else if (rv_streq_(sec, ".text")) a->cur_sec = RV_SEC_TEXT;
        else if (rv_streq_(sec, ".data")) a->cur_sec = RV_SEC_DATA;
        else {
            rv_error(a, "line %s: the riscv32 assembler has no section '%s' "
                        "(only .text, .rodata and .data)", sec, "");
            return;
        }
        *pp = p;
        return;
    }
    if (rv_streq_(d, "globl") || rv_streq_(d, "global")) {
        /* A flat image ignores this (nothing links, so every label is
         * reachable); -c keeps it, because it is the only statement the text
         * makes about which labels leave the translation unit. */
        if (rv_read_ident(&p, sym, (int)sizeof(sym)) == 0) {
            rv_error(a, "line %s: '.%s' needs a symbol name", d, "");
            return;
        }
        rv_add_export(a, sym, 0);
        *pp = p;
        return;
    }
    if (rv_streq_(d, "weak")) {
        if (rv_read_ident(&p, sym, (int)sizeof(sym)) == 0) {
            rv_error(a, "line %s: '.weak' needs a symbol name", "", "");
            return;
        }
        rv_add_export(a, sym, 1);
        *pp = p;
        return;
    }
    if (rv_streq_(d, "type") || rv_streq_(d, "size") || rv_streq_(d, "option") ||
        rv_streq_(d, "file") || rv_streq_(d, "ident")) {
        /* nothing a flat image or an ARKOBJ2 object needs */
        *pp = p;
        return;
    }
    if (rv_streq_(d, "balign") || rv_streq_(d, "p2align")) {
        int al;
        if (!rv_read_ll(&p, &v) || v < 1 || v > 16) {
            rv_error(a, "line %s: the alignment must be a power of two, 1..16", "", "");
            return;
        }
        if (rv_streq_(d, "p2align")) v = 1LL << v;
        al = (int)v;
        while (a->sec_pc[a->cur_sec] % al) {
            rv_put8(a, a->cur_sec, a->sec_pc[a->cur_sec], 0);
            rv_advance(a, 1);
        }
        *pp = p;
        return;
    }
    if (rv_streq_(d, "space") || rv_streq_(d, "zero")) {
        long long i;
        if (!rv_read_ll(&p, &v) || v < 0) {
            rv_error(a, "line %s: the size must be a non-negative count", "", "");
            return;
        }
        for (i = 0; i < v; i++) {
            rv_put8(a, a->cur_sec, a->sec_pc[a->cur_sec], 0);
            rv_advance(a, 1);
        }
        *pp = p;
        return;
    }
    if (rv_streq_(d, "byte") || rv_streq_(d, "short") || rv_streq_(d, "half") ||
        rv_streq_(d, "word") || rv_streq_(d, "long")) {
        int size = (rv_streq_(d, "byte")) ? 1
                 : (rv_streq_(d, "short") || rv_streq_(d, "half")) ? 2 : 4;
        for (;;) {
            const char *save;
            rv_skip_ws(&p);
            save = p;
            if (rv_a_digit((unsigned char)*p) || *p == '-' || *p == '+') {
                if (!rv_read_ll(&p, &v)) {
                    rv_error(a, "line %s: the data directive needs a constant", "", "");
                    return;
                }
                {
                    unsigned long long u = (unsigned long long)v;
                    int k;
                    for (k = 0; k < size; k++) {
                        rv_put8(a, a->cur_sec, a->sec_pc[a->cur_sec],
                                (unsigned char)((u >> (8 * k)) & 0xFF));
                        rv_advance(a, 1);
                    }
                }
            } else {
                p = save;
                if (!rv_read_symbol(&p, sym, (int)sizeof(sym), &dir)) {
                    rv_error(a, "line %s: the data directive needs a constant or a "
                                "symbol", "", "");
                    return;
                }
                if (size != 4) {
                    rv_error(a, "line %s: the symbol '%s' needs a .word", sym, "");
                    return;
                }
                if (!a->emit) {
                    rv_advance(a, 4);
                } else {
                    addr = rv_sym_addr(a, sym, dir);
                    if (addr < 0 && a->obj && dir == 0) {
                        /* .word sym in an object is an absolute address the
                         * linker writes once the symbol has one. */
                        rv_add_reloc(a, sym, rv_here_off(a), RV_RELOC_ABS32);
                        rv_put32(a, a->cur_sec, a->sec_pc[a->cur_sec], 0u);
                        rv_advance(a, 4);
                    } else if (addr < 0) {
                        rv_error(a, "line %s: '%s' is not a symbol this translation "
                                    "unit defines; a flat image has no linker to "
                                    "fill it in", sym, "");
                        return;
                    } else {
                        rv_put32(a, a->cur_sec, a->sec_pc[a->cur_sec],
                                 (unsigned int)addr);
                        rv_advance(a, 4);
                    }
                }
            }
            rv_skip_ws(&p);
            if (*p != ',') break;
            p++;
        }
        *pp = p;
        return;
    }
    if (rv_streq_(d, "asciz") || rv_streq_(d, "string") || rv_streq_(d, "ascii")) {
        int zt = !rv_streq_(d, "ascii");
        for (;;) {
            rv_string(a, &p, zt);
            rv_skip_ws(&p);
            if (*p != ',') break;
            p++;
        }
        *pp = p;
        return;
    }
    rv_error(a, "line %s: unsupported riscv32 directive '.%s'", d, "");
    *pp = p;
}

/* ---- one pass over the text ------------------------------------------- */
static void rv_pass(RvAsm *a) {
    const char *p = a->src;
    int i;
    for (i = 0; i < RV_SEC_COUNT; i++) a->sec_pc[i] = 0;
    a->seen = 0;
    a->cur_sec = RV_SEC_TEXT;
    while (*p) {
        a->line++;
        rv_skip_ws(&p);
        if (*p == '#' || *p == '\r' || *p == '\n' || *p == 0) {
            /* blank line or comment */
        } else if (rv_a_digit((unsigned char)*p)) {
            char name[16];
            int k = 0;
            while (rv_a_digit((unsigned char)*p)) {
                if (k < (int)sizeof(name) - 1) name[k] = *p;
                k++;
                p++;
            }
            name[k < (int)sizeof(name) ? k : (int)sizeof(name) - 1] = 0;
            if (*p == ':') {
                p++;
                if (a->emit) a->seen++;
                else {
                    int q = 0, val = 0;
                    while (name[q]) { val = val * 10 + (name[q] - '0'); q++; }
                    rv_add_label(a, name, val);
                }
            } else {
                rv_error(a, "line %s: '%s' is not a label definition", name, "");
            }
        } else if (rv_a_alpha((unsigned char)*p)) {
            const char *mark = p;
            char name[96];
            rv_read_ident(&p, name, (int)sizeof(name));
            rv_skip_ws(&p);
            if (*p == ':') {
                p++;
                if (a->emit) a->seen++;
                else rv_add_label(a, name, -1);
            } else {
                p = mark;
                if (name[0] == '.') rv_directive(a, &p);
                else rv_insn(a, &p);
            }
        } else if (*p == '.') {
            rv_directive(a, &p);
        } else {
            char one[2];
            one[0] = *p;
            one[1] = 0;
            rv_error(a, "line %s: unexpected '%s' at the start of a line", one, "");
            p++;
        }
        while (*p && *p != '\n') p++;
        if (*p == '\n') p++;
    }
}

/* ---- tables for write_ark_obj() ---------------------------------------
 * The assembler keeps them in its own RvAsm while it runs; these copies exist
 * because write_ark_obj() asks for them after assemble() has returned. */
static RvLabel  *g_rv_labels;
static int       g_rv_label_count;
static int       g_rv_sec_base[RV_SEC_COUNT];
static RvReloc  *g_rv_relocs;
static int       g_rv_reloc_count;
static int      *g_rv_sym_idx;
static int      *g_rv_sym_weak;
static int       g_rv_sym_count;

static int rv_assemble(const char *asm_text, unsigned char *out, int cap) {
    RvAsm a;
    int i, total;

    a.src = asm_text;
    a.out = out;
    a.out_cap = cap;
    a.labels = 0;
    a.label_count = 0;
    a.label_cap = 0;
    a.hard_errors = 0;
    a.overflow_reported = 0;
    a.line = 0;
    a.emit = 0;
    a.seen = 0;
    a.cur_sec = RV_SEC_TEXT;
    a.obj = g_rv_obj_mode ? 1 : 0;
    a.relocs = 0;
    a.reloc_count = 0;
    a.reloc_cap = 0;
    a.exports = 0;
    a.export_count = 0;
    a.export_cap = 0;

    rv_pass(&a);
    if (a.hard_errors) return -1;

    a.sec_base[RV_SEC_TEXT] = 0;
    a.sec_base[RV_SEC_RODATA] = rv_align16(a.sec_pc[RV_SEC_TEXT]);
    a.sec_base[RV_SEC_DATA] =
        rv_align16(a.sec_base[RV_SEC_RODATA] + a.sec_pc[RV_SEC_RODATA]);
    /* The image ends at the last section that actually has bytes. An empty
     * trailing section must not drag its 16-byte alignment pad into the file:
     * a .text-only program then stays exactly as long as its code. */
    total = a.sec_pc[RV_SEC_TEXT];
    if (a.sec_pc[RV_SEC_RODATA] > 0)
        total = a.sec_base[RV_SEC_RODATA] + a.sec_pc[RV_SEC_RODATA];
    if (a.sec_pc[RV_SEC_DATA] > 0)
        total = a.sec_base[RV_SEC_DATA] + a.sec_pc[RV_SEC_DATA];
    if (total > cap) {
        char b1[12], b2[12];
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "the riscv32 image needs %s bytes, the output buffer holds %s",
                  diag_num(b1, total), diag_num(b2, cap), 0, 0, 0, 0);
        return -1;
    }
    for (i = 0; i < total; i++) out[i] = 0;

    a.line = 0;
    a.emit = 1;
    a.seen = 0;
    rv_pass(&a);
    if (a.hard_errors) return -1;

#if ARKCC_PROFILE != ARKCC_PROFILE_STM32_MIN
    /* ARKCC_DUMP_SYMS=1 prints the label map: the only way a host-side test
     * can find `main` in a flat image that carries no symbol table. */
    if (getenv("ARKCC_DUMP_SYMS")) {
        for (i = 0; i < a.label_count; i++) {
            if (a.labels[i].num >= 0) continue;
            if (a.labels[i].name[0] == '.' && a.labels[i].name[1] == 'L') continue;
            ark_log("RV_SYM %s 0x%X\n", a.labels[i].name,
                    RV_IMAGE_BASE + a.sec_base[a.labels[i].sec] + a.labels[i].off);
        }
    }
#endif
    /* Publish the tables write_ark_obj() needs.  They live in the compiler
     * pool and are never freed, so the driver may read them right after this
     * call returns; -c is the only caller that asks. */
    g_rv_labels      = a.labels;
    g_rv_label_count = a.label_count;
    g_rv_relocs      = a.relocs;
    g_rv_reloc_count = a.reloc_count;
    g_rv_sec_base[RV_SEC_TEXT]   = a.sec_base[RV_SEC_TEXT];
    g_rv_sec_base[RV_SEC_RODATA] = a.sec_base[RV_SEC_RODATA];
    g_rv_sec_base[RV_SEC_DATA]   = a.sec_base[RV_SEC_DATA];

    /* Link symbols = labels this unit declared with .globl/.weak.  A `.L`
     * label is local by construction and a numeric label is not even a name,
     * so both are skipped before the export test. */
    g_rv_sym_count = 0;
    g_rv_sym_idx   = 0;
    g_rv_sym_weak  = 0;
    if (a.obj) {
        int cap = a.label_count > 0 ? a.label_count : 1;
        int *idx  = (int *)mem_pool_alloc(cap * (int)sizeof(int));
        int *weak = (int *)mem_pool_alloc(cap * (int)sizeof(int));
        for (i = 0; i < a.label_count; i++) {
            int w = 0;
            if (a.labels[i].num >= 0) continue;
            if (a.labels[i].name[0] == '.' && a.labels[i].name[1] == 'L') continue;
            if (!rv_exported(&a, a.labels[i].name, &w)) continue;
            idx[g_rv_sym_count]  = i;
            weak[g_rv_sym_count] = w;
            g_rv_sym_count++;
        }
        g_rv_sym_idx  = idx;
        g_rv_sym_weak = weak;
    }
    return total;
}

int rv_get_symbol_count(void) { return g_rv_sym_count; }

const char *rv_get_symbol_name(int i) {
    if (i < 0 || i >= g_rv_sym_count) return "";
    return g_rv_labels[g_rv_sym_idx[i]].name;
}

int rv_get_symbol_offset(int i) {
    RvLabel *L;
    if (i < 0 || i >= g_rv_sym_count) return 0;
    L = &g_rv_labels[g_rv_sym_idx[i]];
    return g_rv_sec_base[L->sec] + L->off;
}

int rv_get_symbol_type(int i) {
    (void)i;
    return 0;     /* code or data: the linker only needs the address */
}

int rv_get_symbol_weak(int i) {
    if (i < 0 || i >= g_rv_sym_count) return 0;
    return g_rv_sym_weak[i];
}

int rv_get_reloc_count(void) { return g_rv_reloc_count; }

const char *rv_get_reloc_name(int i) {
    if (i < 0 || i >= g_rv_reloc_count) return "";
    return g_rv_relocs[i].name;
}

int rv_get_reloc_offset(int i) {
    if (i < 0 || i >= g_rv_reloc_count) return 0;
    return g_rv_relocs[i].off;
}

int rv_get_reloc_type(int i) {
    if (i < 0 || i >= g_rv_reloc_count) return 0;
    return g_rv_relocs[i].type;
}

/* Apply one riscv32 relocation to the merged image.  `off` is the site and
 * `target` the symbol, both as offsets inside the image, so the flash base
 * cancels in target - off and only reappears where it belongs (an absolute
 * .word).  Returns 0 on success, -1 when the site does not hold the instruction
 * pair the relocation describes or the displacement does not fit -- the caller
 * must then refuse to write the image rather than ship one that jumps nowhere. */
int rv_patch_reloc(unsigned char *code, int code_size, int off, int target,
                   int type, unsigned image_base) {
    unsigned w0, w1;
    long long d, hi;
    int lo;
    if (type == RV_RELOC_AUIPC) {
        if (off < 0 || off + 8 > code_size) return -1;
        w0 = (unsigned)code[off] | ((unsigned)code[off + 1] << 8) |
             ((unsigned)code[off + 2] << 16) | ((unsigned)code[off + 3] << 24);
        w1 = (unsigned)code[off + 4] | ((unsigned)code[off + 5] << 8) |
             ((unsigned)code[off + 6] << 16) | ((unsigned)code[off + 7] << 24);
        if ((w0 & 0x7Fu) != RV_OP_AUIPC) return -1;
        if ((w1 & 0x7Fu) != RV_OP_JALR && (w1 & 0x7Fu) != RV_OP_IMM) return -1;
        d  = (long long)target - (long long)off;
        hi = (d + 0x800) >> 12;
        if (hi < -(1LL << 19) || hi > (1LL << 19) - 1) return -1;
        lo = (int)(d - (hi << 12));
        w0 = (w0 & 0x00000FFFu) | (((unsigned)hi & 0xFFFFFu) << 12);
        w1 = (w1 & 0x000FFFFFu) | (((unsigned)lo & 0xFFFu) << 20);
        code[off]     = (unsigned char)(w0 & 0xFF);
        code[off + 1] = (unsigned char)((w0 >> 8) & 0xFF);
        code[off + 2] = (unsigned char)((w0 >> 16) & 0xFF);
        code[off + 3] = (unsigned char)((w0 >> 24) & 0xFF);
        code[off + 4] = (unsigned char)(w1 & 0xFF);
        code[off + 5] = (unsigned char)((w1 >> 8) & 0xFF);
        code[off + 6] = (unsigned char)((w1 >> 16) & 0xFF);
        code[off + 7] = (unsigned char)((w1 >> 24) & 0xFF);
        return 0;
    }
    if (type == RV_RELOC_ABS32) {
        unsigned v = image_base + (unsigned)target;
        if (off < 0 || off + 4 > code_size) return -1;
        code[off]     = (unsigned char)(v & 0xFF);
        code[off + 1] = (unsigned char)((v >> 8) & 0xFF);
        code[off + 2] = (unsigned char)((v >> 16) & 0xFF);
        code[off + 3] = (unsigned char)((v >> 24) & 0xFF);
        return 0;
    }
    return -1;
}

/* 1 = the driver is producing an ARKOBJ2 object (-c) instead of a flat image.
 * Declared in backend.h; read only by rv_assemble(), which changes exactly one
 * thing: an undefined symbol becomes a relocation instead of a hard error. */
int g_rv_obj_mode = 0;

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
