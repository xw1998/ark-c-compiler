/* Ark C Compiler - parser.h */
#ifndef ARK_PARSER_H
#define ARK_PARSER_H

#include "common.h"
#include "lexer.h"
#include "ast.h"

typedef struct {
    Lexer *lex;
    int    error_count;
} Parser;

AstNode *parse_program(Lexer *lex);

#endif /* ARK_PARSER_H */
