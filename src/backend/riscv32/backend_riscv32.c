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
#include "agginit.h"

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

        asmbuf_puts(&buf, "    .globl ");
        asmbuf_puts(&buf, f->name);
        asmbuf_putc(&buf, '\n');
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
                        diag_tool(DIAG_SEV_ERROR, "arkcc",
                                  "the riscv32 backend has no floating point: the "
                                  "unary operator in '%s' cannot be emitted",
                                  f->name, 0,0,0,0,0);
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
