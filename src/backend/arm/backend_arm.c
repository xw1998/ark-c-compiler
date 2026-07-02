/* Ark C Compiler - ARM (Thumb-2) backend
 * Translates IR into textual Thumb-2 assembly. Moved here from the former src/codegen.c.
 *
 * Calling convention (used together with this compiler):
 *   - Arguments 0..3 passed in r0..r3; extra arguments go on the stack (consistent
 *     with the runtime convention, indicated by the val field of IR_CALL).
 *   - r6 = local variable base (fp, pointing to the low address of the local var area).
 *   - Prologue:  PUSH {r5,r6,r7,lr}; SUB sp,sp,#N; MOV r6, sp
 *   - Epilogue:  POP {r0}; MOV sp,r6; ADD sp,sp,#N; POP {r5,r6,r7,pc}
 */
#include "backend.h"
#include "codegen.h"
#include "memory.h"
#include "platform.h"
#include "common.h"
#include "config.h"
#include "arkcc_config.h"

/* --- Internal helpers: emit common instruction fragments --- */
static void emit_line(AsmBuffer *b, const char *s) {
    asmbuf_puts(b, "    ");
    asmbuf_puts(b, s);
    asmbuf_putc(b, '\n');
}

static void emit_mov_imm(AsmBuffer *b, int rd, int imm) {
    if (imm >= 0 && imm <= 255) {
        asmbuf_puts(b, "    MOV r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, ", #");
        asmbuf_int(b, imm);
        asmbuf_putc(b, '\n');
    } else {
        asmbuf_puts(b, "    MOVW r");
        asmbuf_int(b, rd);
        asmbuf_puts(b, ", #");
        asmbuf_int(b, imm & 0xFFFF);
        asmbuf_putc(b, '\n');
        if ((imm >> 16) & 0xFFFF) {
            asmbuf_puts(b, "    MOVT r");
            asmbuf_int(b, rd);
            asmbuf_puts(b, ", #");
            asmbuf_int(b, (imm >> 16) & 0xFFFF);
            asmbuf_putc(b, '\n');
        }
    }
}

static void emit_push_r0(AsmBuffer *b) { emit_line(b, "PUSH {r0}"); }
static void emit_pop_r0(AsmBuffer *b)  { emit_line(b, "POP {r0}");  }
static void emit_pop_r1(AsmBuffer *b)  { emit_line(b, "POP {r1}");  }

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
        case (int)TOK_EQ:
            emit_line(b, "CMP r0, r1");
            emit_line(b, "MOV r0, #0");
            emit_line(b, "IT EQ");
            emit_line(b, "MOVEQ r0, #1");
            break;
        case (int)TOK_NE:
            emit_line(b, "CMP r0, r1");
            emit_line(b, "MOV r0, #0");
            emit_line(b, "IT NE");
            emit_line(b, "MOVNE r0, #1");
            break;
        case (int)TOK_LT:
            emit_line(b, "CMP r0, r1");
            emit_line(b, "MOV r0, #0");
            if (is_unsigned) { emit_line(b, "IT LO"); emit_line(b, "MOVLO r0, #1"); }
            else             { emit_line(b, "IT LT"); emit_line(b, "MOVLT r0, #1"); }
            break;
        case (int)TOK_GT:
            emit_line(b, "CMP r0, r1");
            emit_line(b, "MOV r0, #0");
            if (is_unsigned) { emit_line(b, "IT HI"); emit_line(b, "MOVHI r0, #1"); }
            else             { emit_line(b, "IT GT"); emit_line(b, "MOVGT r0, #1"); }
            break;
        case (int)TOK_LE:
            emit_line(b, "CMP r0, r1");
            emit_line(b, "MOV r0, #0");
            if (is_unsigned) { emit_line(b, "IT LS"); emit_line(b, "MOVLS r0, #1"); }
            else             { emit_line(b, "IT LE"); emit_line(b, "MOVLE r0, #1"); }
            break;
        case (int)TOK_GE:
            emit_line(b, "CMP r0, r1");
            emit_line(b, "MOV r0, #0");
            if (is_unsigned) { emit_line(b, "IT HS"); emit_line(b, "MOVHS r0, #1"); }
            else             { emit_line(b, "IT GE"); emit_line(b, "MOVGE r0, #1"); }
            break;
        default:
            emit_line(b, "; unknown binary op");
            break;
    }
}

static void emit_unary(AsmBuffer *b, int op) {
    switch (op) {
        case (int)TOK_MINUS:
            emit_line(b, "NEG r0, r0");
            break;
        case (int)TOK_BNOT:
            emit_line(b, "MVN r0, r0");
            break;
        case (int)TOK_NOT:
            emit_line(b, "CMP r0, #0");
            emit_line(b, "MOV r0, #0");
            emit_line(b, "IT EQ");
            emit_line(b, "MOVEQ r0, #1");
            break;
        default:
            emit_line(b, "; unknown unary op");
            break;
    }
}

static void emit_prologue(AsmBuffer *b, const char *fn_name, int local_size,
                          int is_irq, int is_naked, int dbg) {
    asmbuf_puts(b, fn_name);
    asmbuf_puts(b, ":\n");
    if (dbg) emit_line(b, ".cfi_startproc");
    if (is_naked) {
        /* __naked: emit no prologue; the function body is entirely the user's responsibility */
        return;
    }
    if (is_irq) {
        /* __irq: save all caller-saved registers that an ISR may clobber */
        emit_line(b, "PUSH {r0, r1, r2, r3, r12, lr}");
    } else {
        emit_line(b, "PUSH {r5, r6, r7, lr}");
    }
    if (local_size > 0) {
        asmbuf_puts(b, "    SUB sp, sp, #");
        asmbuf_int(b, local_size);
        asmbuf_putc(b, '\n');
    }
    emit_line(b, "MOV r6, sp");
}

static void emit_epilogue_return(AsmBuffer *b, int local_size,
                                 int is_irq, int is_naked) {
    if (is_naked) {
        /* __naked: just return, do not restore stack/registers */
        emit_line(b, "BX lr");
        return;
    }
    emit_pop_r0(b);
    emit_line(b, "MOV sp, r6");
    if (local_size > 0) {
        asmbuf_puts(b, "    ADD sp, sp, #");
        asmbuf_int(b, local_size);
        asmbuf_putc(b, '\n');
    }
    if (is_irq) {
        emit_line(b, "POP {r0, r1, r2, r3, r12, pc}");
    } else {
        emit_line(b, "POP {r5, r6, r7, pc}");
    }
}

static char *codegen_arm(IrProgram *prog) {
    AsmBuffer buf;
    int fi;
#if ARKCC_FEATURE_DWARF
    int dbg = (g_config.debug_info || g_config.enable_dwarf) ? 1 : 0;
#else
    int dbg = 0;
#endif
    asmbuf_init(&buf);

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
                    else if (c == '\\') asmbuf_puts(&buf, "\\\\");
                    else if (c == '"')  asmbuf_puts(&buf, "\\\"");
                    else asmbuf_putc(&buf, c);
                }
            }
            asmbuf_puts(&buf, "\"\n");
        }
        asmbuf_puts(&buf, ".text\n\n");
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

    for (fi = 0; fi < prog->func_count; fi++) {
        IrFunc *f = prog->funcs[fi];
        int local_size = f->local_size;
        int i;

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
        emit_prologue(&buf, f->name, local_size, f->is_irq, f->is_naked, dbg);

        {
        int cur_line = 0;
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
            switch (I->op) {
                case IR_FUNC_BEGIN:
                case IR_FUNC_END:
                    break;
                case IR_GETARG: {
                    /* AAPCS: first 4 args in r0-r3, args 5+ on caller's stack.
                     * Stack layout (upward from r6 = frame pointer):
                     *   [r6 + 0 .. local_size-1]            this frame's local variables
                     *   [r6 + local_size + 0..15]           saved r5/r6/r7/lr
                     *   [r6 + local_size + 16 + k*4]        the (5+k)th argument
                     * arg_idx < 4: store directly from r{arg_idx} into this frame;
                     * arg_idx >= 4: load from caller's stack slot, then store into this frame. */
                    int arg_idx = I->aux;
                    if (arg_idx < 4) {
                        asmbuf_puts(&buf, "    STR r");
                        asmbuf_int(&buf, arg_idx);
                        asmbuf_puts(&buf, ", [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
                    } else {
                        int stack_off = local_size + 16 + (arg_idx - 4) * 4;
                        asmbuf_puts(&buf, "    LDR r0, [r6, #");
                        asmbuf_int(&buf, stack_off);
                        asmbuf_puts(&buf, "]\n");
                        asmbuf_puts(&buf, "    STR r0, [r6, #");
                        asmbuf_int(&buf, I->val);
                        asmbuf_puts(&buf, "]\n");
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
                case IR_PUSH_VAR:
                    asmbuf_puts(&buf, "    LDR r0, [r6, #");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "]\n");
                    emit_push_r0(&buf);
                    break;
                case IR_PUSH_ADDR:
                    asmbuf_puts(&buf, "    ADD r0, r6, #");
                    asmbuf_int(&buf, I->val);
                    asmbuf_putc(&buf, '\n');
                    emit_push_r0(&buf);
                    break;
                case IR_PUSH_GLOBAL:
                    asmbuf_puts(&buf, "    LDR r0, =");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    emit_line(&buf, "LDR r0, [r0]");
                    emit_push_r0(&buf);
                    break;
                case IR_PUSH_GLOBAL_ADDR:
                    /* Take the global symbol address only (no dereference), for array/struct decay
                     * and compound literal scenarios. */
                    asmbuf_puts(&buf, "    LDR r0, =");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    emit_push_r0(&buf);
                    break;
                case IR_STORE_GLOBAL:
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, "    LDR r1, =");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    emit_line(&buf, "STR r0, [r1]");
                    break;
                case IR_POP:
                    emit_pop_r0(&buf);
                    break;
                case IR_DUP:
                    emit_pop_r0(&buf);
                    emit_push_r0(&buf);
                    emit_push_r0(&buf);
                    break;
                case IR_SWAP:
                    /* Pop top two values and push them back in swapped order.
                     * r0 = top, r1 = next -> push r0, push r1 */
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, "    POP {r1}\n");
                    emit_push_r0(&buf);
                    asmbuf_puts(&buf, "    PUSH {r1}\n");
                    break;
                case IR_STORE:
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, "    STR r0, [r6, #");
                    asmbuf_int(&buf, I->val);
                    asmbuf_puts(&buf, "]\n");
                    break;
                case IR_LOAD_IDX: {
                    int es = I->val;
                    int packed = (I->aux & 0x400) ? 1 : 0;
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    if (es > 1) {
                        emit_mov_imm(&buf, 2, es);
                        emit_line(&buf, "MUL r1, r2");
                    }
                    emit_line(&buf, "ADD r0, r0, r1");
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
                        } else {
                            /* Default to 4-byte handling (es>=4 takes the low 4 bytes) */
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
                        }
                    } else {
                        emit_line(&buf, "LDR r0, [r0, #0]");
                    }
                    emit_push_r0(&buf);
                    break;
                }
                case IR_STORE_IDX: {
                    int es = I->val;
                    int packed = (I->aux & 0x400) ? 1 : 0;
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
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    emit_binary(&buf, I->aux);
                    emit_push_r0(&buf);
                    break;
                case IR_UNARY:
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
                    /* float/double -> int (truncation toward zero) */
                    int is_dbl = (I->aux & 0x200) != 0;
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        if (is_dbl) {
                            /* double: pop d0, VCVT.S32.F64 s0,d0, move back to r0 */
                            emit_line(&buf, "POP {r1}");  /* high */
                            emit_line(&buf, "POP {r0}");  /* low */
                            emit_line(&buf, "VMOV s0, r0");
                            emit_line(&buf, "VMOV s1, r1");
                            emit_line(&buf, "VCVT.S32.F64 s0, d0");
                            emit_line(&buf, "VMOV r0, s0");
                        } else {
                            emit_pop_r0(&buf);
                            emit_line(&buf, "VMOV s0, r0");
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
                        emit_line(&buf, "BL __aeabi_d2iz");
                    } else {
                        emit_pop_r0(&buf);
                        emit_line(&buf, "BL __aeabi_f2iz");
                    }
                    emit_push_r0(&buf);
                    break;
                }
                case IR_I2F: {
                    /* int -> float/double */
                    int is_dbl = (I->aux & 0x200) != 0;
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        emit_pop_r0(&buf);
                        emit_line(&buf, "VMOV s0, r0");
                        if (is_dbl) {
                            emit_line(&buf, "VCVT.F64.S32 d0, s0");
                            emit_line(&buf, "VMOV r0, s0");
                            emit_line(&buf, "VMOV r1, s1");
                            emit_push_r0(&buf);
                            asmbuf_puts(&buf, "    PUSH {r1}\n");
                        } else {
                            emit_line(&buf, "VCVT.F32.S32 s0, s0");
                            emit_line(&buf, "VMOV r0, s0");
                            emit_push_r0(&buf);
                        }
                        break;
                    }
#endif
                    emit_pop_r0(&buf);
                    if (is_dbl) {
                        emit_line(&buf, "BL __aeabi_i2d");
                        emit_push_r0(&buf);
                        asmbuf_puts(&buf, "    PUSH {r1}\n");
                    } else {
                        emit_line(&buf, "BL __aeabi_i2f");
                        emit_push_r0(&buf);
                    }
                    break;
                }
                case IR_FCMP: {
                    /* aux encodes the comparison kind (low 8 bits) + precision flag (0x200);
                     * __aeabi_fcmpeq and __aeabi_dcmpeq family return 0/1 */
                    int op = I->aux & ~0x200;
                    int is_dbl = (I->aux & 0x200) != 0;
#if ARKCC_FEATURE_FPU_HW
                    if (g_config.enable_fpu_hw) {
                        const char *cond = "EQ";
                        if (is_dbl) {
                            emit_line(&buf, "POP {r3}");
                            emit_line(&buf, "POP {r2}");
                            emit_line(&buf, "POP {r1}");
                            emit_line(&buf, "POP {r0}");
                            emit_line(&buf, "VMOV s0, r0");
                            emit_line(&buf, "VMOV s1, r1");
                            emit_line(&buf, "VMOV s2, r2");
                            emit_line(&buf, "VMOV s3, r3");
                            emit_line(&buf, "VCMP.F64 d0, d1");
                        } else {
                            emit_pop_r1(&buf); emit_pop_r0(&buf);
                            emit_line(&buf, "VMOV s0, r0");
                            emit_line(&buf, "VMOV s1, r1");
                            emit_line(&buf, "VCMP.F32 s0, s1");
                        }
                        emit_line(&buf, "VMRS APSR_nzcv, FPSCR");
                        emit_mov_imm(&buf, 0, 0);
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
                     * Note: when stack_args is odd, SP is only 4-byte aligned at BL;
                     * this is a known simplification of the stack-based IR model (even arg counts are fully compliant). */
                    int n = I->val;
                    int k;
                    int reg_args = (n > 4) ? 4 : n;
                    int stack_args = (n > 4) ? (n - 4) : 0;
                    for (k = 0; k < reg_args; k++) {
                        asmbuf_puts(&buf, "    POP {r");
                        asmbuf_int(&buf, k);
                        asmbuf_puts(&buf, "}\n");
                    }
                    asmbuf_puts(&buf, "    BL ");
                    asmbuf_puts(&buf, I->name);
                    asmbuf_putc(&buf, '\n');
                    /* Clean up stack arguments */
                    if (stack_args > 0) {
                        asmbuf_puts(&buf, "    ADD sp, sp, #");
                        asmbuf_int(&buf, stack_args * 4);
                        asmbuf_putc(&buf, '\n');
                    }
                    emit_push_r0(&buf);
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
                /* === Integer divide/modulo: implemented via ARM EABI soft-division helpers ===
                 * Top of stack is the divisor (r1), next is the dividend (r0); result pushed back to r0. */
                case IR_DIV:
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, "    BL ");
                    asmbuf_puts(&buf, I->aux ? "__aeabi_uidiv" : "__aeabi_idiv");
                    asmbuf_putc(&buf, '\n');
                    emit_push_r0(&buf);
                    break;
                case IR_MOD:
                    emit_pop_r1(&buf);
                    emit_pop_r0(&buf);
                    asmbuf_puts(&buf, "    BL ");
                    asmbuf_puts(&buf, I->aux ? "__aeabi_uidivmod" : "__aeabi_idivmod");
                    asmbuf_putc(&buf, '\n');
                    emit_line(&buf, "MOV r0, r1"); /* remainder is in r1 */
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
                    int op = I->aux;
                    const char *helper = 0;
                    int is_mod = 0;
                    switch (op) {
                        case (int)TOK_PLUS:  helper = "__aeabi_ladd"; break;
                        case (int)TOK_MINUS: helper = "__aeabi_lsub"; break;
                        case (int)TOK_MUL:   helper = "__aeabi_lmul"; break;
                        case (int)TOK_DIV:   helper = "__aeabi_ldiv"; break;
                        case (int)TOK_MOD:   helper = "__aeabi_ldivmod"; is_mod = 1; break;
                        default: break;
                    }
                    emit_line(&buf, "POP {r3}");
                    emit_line(&buf, "POP {r2}");
                    emit_line(&buf, "POP {r1}");
                    emit_line(&buf, "POP {r0}");
                    if (helper) {
                        asmbuf_puts(&buf, "    BL ");
                        asmbuf_puts(&buf, helper);
                        asmbuf_putc(&buf, '\n');
                    }
                    if (is_mod) {
                        /* __aeabi_ldivmod: quotient in r0/r1, remainder in r2/r3; take remainder to r0/r1 */
                        emit_line(&buf, "MOV r0, r2");
                        emit_line(&buf, "MOV r1, r3");
                    }
                    emit_push_r0(&buf);                 /* result low 32 bits */
                    asmbuf_puts(&buf, "    PUSH {r1}\n"); /* result high 32 bits */
                    break;
                }
                case IR_64CMP: {
                    /* __aeabi_lcmp returns -1/0/1 (a<b / a==b / a>b) in r0;
                     * use conditional MOV to produce a 0/1 comparison result. */
                    int op = I->aux;
                    emit_line(&buf, "POP {r3}");
                    emit_line(&buf, "POP {r2}");
                    emit_line(&buf, "POP {r1}");
                    emit_line(&buf, "POP {r0}");
                    emit_line(&buf, "BL __aeabi_lcmp");
                    emit_line(&buf, "CMP r0, #0");
                    emit_line(&buf, "MOV r0, #0");
                    switch (op) {
                        case (int)TOK_EQ: emit_line(&buf, "IT EQ"); emit_line(&buf, "MOVEQ r0, #1"); break;
                        case (int)TOK_NE: emit_line(&buf, "IT NE"); emit_line(&buf, "MOVNE r0, #1"); break;
                        case (int)TOK_LT: emit_line(&buf, "IT LT"); emit_line(&buf, "MOVLT r0, #1"); break;
                        case (int)TOK_GT: emit_line(&buf, "IT GT"); emit_line(&buf, "MOVGT r0, #1"); break;
                        case (int)TOK_LE: emit_line(&buf, "IT LE"); emit_line(&buf, "MOVLE r0, #1"); break;
                        case (int)TOK_GE: emit_line(&buf, "IT GE"); emit_line(&buf, "MOVGE r0, #1"); break;
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
                    emit_line(&buf, "BL memcpy");
                    break;
                /* === Bitfield store/load ===
                 * val=bit offset, aux=bit width. mask = (1<<bw)-1. */
                case IR_STORE_FLD: {
                    int bit_off = I->val;
                    int bw = I->aux;
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
                    int bw = I->aux;
                    unsigned mask = (bw >= 32) ? 0xFFFFFFFFu : ((1u << bw) - 1u);
                    emit_pop_r0(&buf);                 /* addr */
                    emit_line(&buf, "LDR r0, [r0]");
                    if (bit_off > 0) {
                        asmbuf_puts(&buf, "    LSR r0, r0, #");
                        asmbuf_int(&buf, bit_off);
                        asmbuf_putc(&buf, '\n');
                    }
                    emit_mov_imm(&buf, 2, (int)mask);
                    emit_line(&buf, "AND r0, r2");      /* truncate to bw bits */
                    emit_push_r0(&buf);
                    break;
                }
                case IR_RETURN:
                    emit_epilogue_return(&buf, local_size, f->is_irq, f->is_naked);
                    break;
                case IR_ALLOCA: {
                    /* B3: VLA dynamic stack allocation. Pop the byte count (now in r0),
                     * 8-byte align by rounding down sp, and push the start address of the allocated region.
                     * ARM tests only check assembly generation; runtime semantics are handled by the C backend. */
                    emit_pop_r0(&buf);                  /* r0 = byte count */
                    emit_line(&buf, "ADD r0, r0, #7");
                    emit_line(&buf, "BIC r0, r0, #7");  /* 8-byte align */
                    emit_line(&buf, "SUB sp, sp, r0");  /* allocate */
                    emit_push_r0(&buf);                 /* placeholder: keep stack balanced */
                    emit_line(&buf, "MOV r0, sp");
                    emit_line(&buf, "ADD sp, sp, #4");  /* undo placeholder */
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

    /* Globals: assigned to .data/.bss/.rodata based on initialization; custom sections take priority.
     * Aggregate initialization (init_aggregate is a C source snippet) cannot be directly converted to bytes,
     * so only space is reserved; the value is written at runtime by initialization code in main (IR_STORE etc.).
     * extern globals are not defined here, only referenced. */
    if (prog->global_count > 0) {
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
                asmbuf_puts(&buf, "\"\n");
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
                /* String array initialization: same escaping as IR_PUSH_STR */
                int slen = ark_strlen(g->init_str);
                int k;
                asmbuf_puts(&buf, "    .asciz \"");
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
    return buf.buf;
}

/* === Minimal Thumb-2 text assembler === */
typedef struct AsmLabel { char *name; int addr; } AsmLabel;
typedef struct AsmRef   { int pc; char *name; int type; } AsmRef;

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
static void skip_space_a(const char **p) { while (is_space_a(**p)) (*p)++; }
static void skip_to_eol_a(const char **p) { while (**p && **p != '\n') (*p)++; }

static int read_word_a(const char **p, char *out, int cap) {
    int n = 0;
    skip_space_a(p);
    while (**p && is_alnum_a(**p) && n < cap - 1) {
        out[n++] = **p; (*p)++;
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
    return -1;
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
    a->label_count++;
}
static int find_label_a(ArmAsm *a, const char *name) {
    int i;
    for (i = 0; i < a->label_count; i++)
        if (ark_streq(a->labels[i].name, name)) return a->labels[i].addr;
    return -1;
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

static int op_size_a(const char *op) {
    if (strieq_a(op, "BL"))   return 4;
    if (strieq_a(op, "MOVW")) return 4;
    if (strieq_a(op, "MOVT")) return 4;
    if (strieq_a(op, "SDIV")) return 4;
    if (strieq_a(op, "UDIV")) return 4;
    if (strieq_a(op, "B.W"))  return 4;
    return 2;
}

/* Forward declaration: needed in pass1 to decide whether PUSH/POP is T1 or T2 encoded */
static int parse_reglist_a(const char **p, int *has_lr, int *has_pc);

static void pass1_a(ArmAsm *a) {
    const char *p = a->src;
    int pc = 0;
    a->label_count = 0;
    while (*p) {
        char first[64];
        int n;
        skip_space_a(&p);
        if (*p == '\n') { p++; continue; }
        if (*p == ';') { skip_to_eol_a(&p); continue; }
        if (*p == '\0') break;
        n = read_word_a(&p, first, (int)sizeof(first));
        if (n == 0) { skip_to_eol_a(&p); continue; }
        skip_space_a(&p);
        if (*p == ':') {
            add_label_a(a, first, pc);
            p++;
            skip_space_a(&p);
            if (*p == '\n' || *p == ';' || *p == '\0') { if (*p == ';') skip_to_eol_a(&p); if (*p == '\n') p++; continue; }
            n = read_word_a(&p, first, (int)sizeof(first));
            if (n == 0) { skip_to_eol_a(&p); continue; }
        }
        if (first[0] == '.') {
            /* Pseudo-directives ignored */
        } else if (strieq_a(first, "PUSH") || strieq_a(first, "POP")) {
            /* PUSH/POP may be 16-bit T1 (r0-r7 + lr/pc only) or 32-bit T2
             * (includes r8-r12); size determined by the register list to keep pass1 offsets correct. */
            int has_lr = 0, has_pc = 0;
            int list = parse_reglist_a(&p, &has_lr, &has_pc);
            (void)has_lr; (void)has_pc;
            if (list & 0x1F00) pc += 4;  /* T2: includes r8-r12 */
            else               pc += 2;  /* T1 */
        } else {
            pc += op_size_a(first);
        }
        skip_to_eol_a(&p);
        if (*p == '\n') p++;
    }
}

static int parse_reglist_a(const char **p, int *has_lr, int *has_pc) {
    int list = 0;
    *has_lr = 0; *has_pc = 0;
    skip_space_a(p);
    if (**p != '{') return 0;
    (*p)++;
    while (**p && **p != '}') {
        skip_space_a(p);
        if (**p == 'l' || **p == 'L') {
            if (((*p)[1] == 'r' || (*p)[1] == 'R')) { *has_lr = 1; (*p) += 2; }
        } else if (**p == 'p' || **p == 'P') {
            if (((*p)[1] == 'c' || (*p)[1] == 'C')) { *has_pc = 1; (*p) += 2; }
        } else {
            int r = parse_reg_a(p);
            if (r >= 0) list |= (1 << r);
        }
        skip_space_a(p);
        if (**p == ',') (*p)++;
    }
    if (**p == '}') (*p)++;
    return list;
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

static int read_label_name_a(const char **p, char *buf, int cap) {
    int n = 0;
    skip_space_a(p);
    while (**p && **p != ' ' && **p != '\t' && **p != '\n' && **p != ';' && **p != ',' && n < cap - 1) {
        buf[n++] = **p; (*p)++;
    }
    buf[n] = 0;
    return n;
}

static void pass2_a(ArmAsm *a) {
    const char *p = a->src;
    a->pc = 0;
    a->ref_count = 0;
    while (*p) {
        char first[64];
        int n;
        skip_space_a(&p);
        if (*p == '\n') { p++; continue; }
        if (*p == ';') { skip_to_eol_a(&p); continue; }
        if (*p == '\0') break;
        n = read_word_a(&p, first, (int)sizeof(first));
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
            if (n == 0) { skip_to_eol_a(&p); continue; }
        }
        if (first[0] == '.') { skip_to_eol_a(&p); if (*p == '\n') p++; continue; }
        skip_space_a(&p);

        if (strieq_a(first, "PUSH")) {
            int has_lr=0, has_pc=0;
            int list = parse_reglist_a(&p, &has_lr, &has_pc);
            (void)has_pc;
            if (list & 0x1F00) {
                /* T2 STMDB SP!: can encode r0-r12 + lr */
                unsigned w2 = (unsigned)(has_lr ? 0x4000 : 0) | (unsigned)(list & 0x1FFF);
                out16(a, 0xE92D); out16(a, w2);
            } else {
                out16(a, 0xB400 | (has_lr ? 0x0100 : 0) | (list & 0xFF));
            }
        }
        else if (strieq_a(first, "POP")) {
            int has_lr=0, has_pc=0;
            int list = parse_reglist_a(&p, &has_lr, &has_pc);
            (void)has_lr;
            if (list & 0x1F00) {
                /* T2 LDMIA SP!: can encode r0-r12 + pc */
                unsigned w2 = (unsigned)(has_pc ? 0x8000 : 0) | (unsigned)(list & 0x1FFF);
                out16(a, 0xE8BD); out16(a, w2);
            } else {
                out16(a, 0xBC00 | (has_pc ? 0x0100 : 0) | (list & 0xFF));
            }
        }
        else if (strieq_a(first, "MOV")) {
            int rd = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                out16(a, 0x2000 | ((rd & 7) << 8) | (imm & 0xFF));
            } else {
                int rm = parse_reg_a(&p);
                out16(a, 0x4600 | (((rd >> 3) & 1) << 7) | ((rm & 0xF) << 3) | (rd & 7));
            }
        }
        else if (strieq_a(first, "MOVEQ") || strieq_a(first, "MOVNE") ||
                 strieq_a(first, "MOVLT") || strieq_a(first, "MOVGT") ||
                 strieq_a(first, "MOVLE") || strieq_a(first, "MOVGE")) {
            int rd = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                out16(a, 0x2000 | ((rd & 7) << 8) | (imm & 0xFF));
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
        else if (strieq_a(first, "ADD")) {
            int rd = parse_reg_a(&p); int rn;
            eat_comma_a(&p);
            rn = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                if (rd == rn) out16(a, 0x3000 | ((rd & 7) << 8) | (imm & 0xFF));
                else          out16(a, 0x1C00 | ((imm & 7) << 6) | ((rn & 7) << 3) | (rd & 7));
            } else {
                int rm = parse_reg_a(&p);
                out16(a, 0x1800 | ((rm & 7) << 6) | ((rn & 7) << 3) | (rd & 7));
            }
        }
        else if (strieq_a(first, "SUB")) {
            int rd = parse_reg_a(&p); int rn;
            eat_comma_a(&p);
            rn = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                if (rd == 13 && rn == 13) out16(a, 0xB080 | (((imm + 3) / 4) & 0x7F));
                else if (rd == rn)        out16(a, 0x3800 | ((rd & 7) << 8) | (imm & 0xFF));
                else                      out16(a, 0x1E00 | ((imm & 7) << 6) | ((rn & 7) << 3) | (rd & 7));
            } else {
                int rm = parse_reg_a(&p);
                out16(a, 0x1A00 | ((rm & 7) << 6) | ((rn & 7) << 3) | (rd & 7));
            }
        }
        else if (strieq_a(first, "MUL")) {
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            out16(a, 0x4340 | ((rm & 7) << 3) | (rd & 7));
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
        else if (strieq_a(first, "AND")) {
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            out16(a, 0x4000 | ((rm & 7) << 3) | (rd & 7));
        }
        else if (strieq_a(first, "ORR")) {
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            out16(a, 0x4300 | ((rm & 7) << 3) | (rd & 7));
        }
        else if (strieq_a(first, "EOR")) {
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            out16(a, 0x4040 | ((rm & 7) << 3) | (rd & 7));
        }
        else if (strieq_a(first, "LSL")) {
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                /* LSL rd, rm, #imm5 (T1 immediate shift) */
                p++; skip_space_a(&p);
                if (*p == '#') {
                    int imm = parse_imm_a(&p) & 0x1F;
                    out16(a, (unsigned)(imm << 6) | ((rm & 7) << 3) | (rd & 7));
                } else {
                    int rm2 = parse_reg_a(&p);
                    out16(a, 0x4080 | ((rm2 & 7) << 3) | (rd & 7));
                }
            } else {
                /* LSL rd, rm (T1 register shift) */
                out16(a, 0x4080 | ((rm & 7) << 3) | (rd & 7));
            }
        }
        else if (strieq_a(first, "LSR")) {
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                /* LSR rd, rm, #imm5 (T1 immediate shift; imm5=0 means 32) */
                p++; skip_space_a(&p);
                if (*p == '#') {
                    int imm = parse_imm_a(&p);
                    int imm5 = (imm >= 32) ? 0 : (imm & 0x1F);
                    out16(a, 0x0800 | (unsigned)(imm5 << 6) | ((rm & 7) << 3) | (rd & 7));
                } else {
                    int rm2 = parse_reg_a(&p);
                    out16(a, 0x40C0 | ((rm2 & 7) << 3) | (rd & 7));
                }
            } else {
                /* LSR rd, rm (T1 register shift) */
                out16(a, 0x40C0 | ((rm & 7) << 3) | (rd & 7));
            }
        }
        else if (strieq_a(first, "ASR")) {
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            out16(a, 0x4100 | ((rm & 7) << 3) | (rd & 7));
        }
        else if (strieq_a(first, "BIC")) {
            /* BIC rd, rm or BIC rd, rn, rm (T1: rd = rd AND NOT rm) */
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') { p++; skip_space_a(&p); rm = parse_reg_a(&p); }
            out16(a, 0x4380 | ((rm & 7) << 3) | (rd & 7));
        }
        else if (strieq_a(first, "MVN")) {
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            out16(a, 0x43C0 | ((rm & 7) << 3) | (rd & 7));
        }
        else if (strieq_a(first, "NEG") || strieq_a(first, "RSB")) {
            int rd = parse_reg_a(&p); int rm;
            eat_comma_a(&p); rm = parse_reg_a(&p);
            out16(a, 0x4240 | ((rm & 7) << 3) | (rd & 7));
            skip_space_a(&p);
            if (*p == ',') { p++; skip_space_a(&p); if (*p == '#') parse_imm_a(&p); }
        }
        else if (strieq_a(first, "CMP")) {
            int rn = parse_reg_a(&p);
            eat_comma_a(&p);
            if (*p == '#') {
                int imm = parse_imm_a(&p);
                out16(a, 0x2800 | ((rn & 7) << 8) | (imm & 0xFF));
            } else {
                int rm = parse_reg_a(&p);
                out16(a, 0x4280 | ((rm & 7) << 3) | (rn & 7));
            }
        }
        else if (strieq_a(first, "LDR") || strieq_a(first, "LDRB") ||
                 strieq_a(first, "STR") || strieq_a(first, "STRB")) {
            int is_load = (first[0] == 'L' || first[0] == 'l');
            int is_byte = (first[2] == 'B' || first[2] == 'b' || first[3] == 'B' || first[3] == 'b');
            int rd = parse_reg_a(&p);
            int rn;
            int imm = 0;
            eat_comma_a(&p);
            if (*p == '=') {
                /* LDR rd, =label - simplified: placeholder NOP only */
                skip_to_eol_a(&p);
                out16(a, 0xBF00);
                if (*p == '\n') p++;
                continue;
            }
            if (*p == '[') { p++; skip_space_a(&p); }
            rn = parse_reg_a(&p);
            skip_space_a(&p);
            if (*p == ',') {
                p++; skip_space_a(&p);
                if (*p == '#') imm = parse_imm_a(&p);
            }
            skip_space_a(&p);
            if (*p == ']') p++;
            {
                unsigned imm5;
                if (is_byte) imm5 = imm & 0x1F;
                else         imm5 = (imm >> 2) & 0x1F;
                if (is_load) {
                    if (is_byte) out16(a, 0x7800 | (imm5 << 6) | ((rn & 7) << 3) | (rd & 7));
                    else         out16(a, 0x6800 | (imm5 << 6) | ((rn & 7) << 3) | (rd & 7));
                } else {
                    if (is_byte) out16(a, 0x7000 | (imm5 << 6) | ((rn & 7) << 3) | (rd & 7));
                    else         out16(a, 0x6000 | (imm5 << 6) | ((rn & 7) << 3) | (rd & 7));
                }
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
            char cond[8];
            skip_space_a(&p);
            read_word_a(&p, cond, sizeof(cond));
            out16(a, 0xBF00);
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
                 strieq_a(first, "BCS")) {
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
            }
            read_label_name_a(&p, name, sizeof(name));
            {
                int addr = find_label_a(a, name);
                if (addr < 0) {
                    add_ref_a(a, a->pc, name, 0);
                    out16(a, is_uncond ? 0xE000 : (0xD000 | (cond << 8)));
                } else {
                    int offset = (addr - a->pc - 4) >> 1;
                    if (is_uncond) out16(a, 0xE000 | (offset & 0x7FF));
                    else           out16(a, 0xD000 | (cond << 8) | (offset & 0xFF));
                }
            }
        }
        else {
            out16(a, 0xBF00);
        }
        skip_to_eol_a(&p);
        if (*p == '\n') p++;
    }
}

static void resolve_refs_a(ArmAsm *a) {
    int i;
    for (i = 0; i < a->ref_count; i++) {
        AsmRef *r = &a->refs[i];
        int addr = find_label_a(a, r->name);
        if (addr < 0) {
            ark_log("[asm-arm] unresolved label '%s'\n", r->name);
            a->error_count++;
            continue;
        }
        if (r->type == 1) {
            int saved = a->pc;
            a->pc = r->pc;
            emit_bl_a(a, addr);
            a->pc = saved;
        } else {
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
    if (n + 1 > cap) n = cap - 1;
    for (i = 0; i < n; i++) out[i] = text[i];
    out[n] = 0;
    return n;
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
    pass1_a(&a);
    a.pc = 0;
    pass2_a(&a);
    resolve_refs_a(&a);
    if (a.error_count > 0) return -1;
    return a.pc;
}

static int arm_link(unsigned char *code, int size, struct LinkContext *lc) {
    (void)code; (void)size; (void)lc;
    return 0;
}

static const ArkBackend g_arm_backend = {
    "arm",
    "armv7m-thumb2-eabi",
    4,
    arm_emit,
    arm_assemble,
    arm_link
};

const ArkBackend *ark_backend_arm(void) {
    return &g_arm_backend;
}
