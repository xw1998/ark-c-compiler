/* Ark C Compiler - ipo.h
 * Whole-program compilation (--ipo / -flto) and the shared front end entry.
 */
#ifndef ARK_IPO_H
#define ARK_IPO_H

#include "compiler.h"
#include "ir.h"
#include "backend.h"
#include "arkcc_config.h"

/* Front end for one translation unit: preprocess -> lex -> parse -> sema ->
 * AST lint stage -> irgen -> IR pass pipeline.  Defined in src/compiler.c;
 * lifted out of ark_compile() verbatim so --ipo runs the same setup for every
 * file.  `shared` non-NULL appends the unit's IR into that program.  On
 * success *out_ir is the program (NULL for -E, which already wrote its
 * output) and *out_be the selected backend.  The caller resets the memory
 * pool once before the first unit and must not reset it between units when
 * the IR is shared. */
int ark_frontend_unit(const ArkOptions *opts, IrProgram *shared,
                      IrProgram **out_ir, const ArkBackend **out_be);

/* Backend emit + assemble + write for a finished program (src/compiler.c).
 * Shared by the single-unit path and --ipo so both answer "what does this
 * build write" identically. */
int ark_emit_program(const ArkOptions *opts, IrProgram *ir, const ArkBackend *be);

/* --ipo driver: compile every opts->ipo_inputs[] file into one program, merge
 * the units, run the pass pipeline over the merged program and emit a single
 * image (or -S text).  Defined in src/ipo.c.  When ARKCC_FEATURE_IPO is 0 the
 * symbol still exists and refuses with a driver diagnostic, so a trimmed build
 * cannot silently accept the option. */
int ark_ipo_compile(const ArkOptions *opts);

#endif /* ARK_IPO_H */
