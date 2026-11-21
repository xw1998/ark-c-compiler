/* Ark C Compiler - irgen.h
 * Generate IR from AST.
 */
#ifndef ARK_IRGEN_H
#define ARK_IRGEN_H

#include "ast.h"
#include "ir.h"

IrProgram *irgen_program(AstNode *prog);
/* 0.8.7 --ipo: append this unit's IR into an existing program instead of
 * starting a new one (see src/ipo.c).  `out` NULL keeps the single-unit
 * behaviour exactly.  The pools are index-addressed from the instructions,
 * so appending is the only merge that needs no renumbering. */
IrProgram *irgen_program_into(AstNode *prog, IrProgram *out);

/* Number of AST constructs IR generation could not lower. Non-zero means the
 * emitted IR is incomplete, so the driver must fail the compilation instead of
 * writing an image that silently computes the wrong answer. Reset on entry to
 * irgen_program(). */
extern int g_irgen_errors;

/* 设置 IR 生成是否使用 8 字节槽模型（C 后端）。
 * 启用后 irgen_widen_to_64 和 irgen_cond_to_bool 成为 no-op，
 * 因为 8 字节 long long 槽无需符号扩展或高低字合并。 */
void irgen_set_64bit_slots(int enabled);
/* Tell irgen that the target keeps a pointer in a single 8-byte stack word
 * even though the IR word is 32 bits wide (x86-64).  Off by default, so every
 * other target emits exactly the IR it emitted before.  See IR_AUX_SLOT64. */
void irgen_set_slot64_ptrs(int enabled);

/* Number of stack words a _Complex double occupies on the selected backend.
 * The C backend keeps a complex value in one 8-byte union slot (1); the
 * machine backends (ARM / RISC-V / x86-64) carry four 32-bit words (4).
 * Set before irgen_program(). Used to size discard/reload/dup of complex
 * values and to reject complex arguments/returns where the calling
 * convention cannot carry them. */
void irgen_set_complex_words(int words);

/* Words one parameter occupies on the wire for the current target, or -1 when
 * the IR inline expansion cannot reproduce the transfer.  Two shapes answer
 * -1: a composite (or _Complex) wider than 8 bytes travels as one *address*
 * word whose payload the callee memcpys, and the slot-image targets (C
 * backend's 8-byte slots, x86-64's one-word pointer) do not keep 4-byte IR
 * words at all.  src/opt.c asks this per parameter instead of reading
 * IR_GETARG's size field, which irgen stamps for *every* parameter and which
 * therefore made a plain `int` look exactly like a struct-by-value. */
int irgen_param_slots(Type *ptype);

#endif /* ARK_IRGEN_H */
