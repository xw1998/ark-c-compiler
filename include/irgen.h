/* Ark C Compiler - irgen.h
 * Generate IR from AST.
 */
#ifndef ARK_IRGEN_H
#define ARK_IRGEN_H

#include "ast.h"
#include "ir.h"

IrProgram *irgen_program(AstNode *prog);

#endif /* ARK_IRGEN_H */
