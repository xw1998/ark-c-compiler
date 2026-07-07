/* Ark C Compiler - lexer.h
 * ?????????????????????? Token ??????
 */
#ifndef ARK_LEXER_H
#define ARK_LEXER_H

#include "common.h"

typedef struct {
    TokenKind kind;
    long long       value;
    double    fvalue;
    char     *str;
    int       line;
    const char *src_start;  /* token ??????????????????? __asm ??????????? */
    int       is_imag;      /* C99 ?????????????????? i/I/j/J ????????? */
    int       is_float;     /* C99 float suffix (f/F): 1 = float literal, 0 = double */
} Token;

typedef struct {
    const char *input;
    const char *p;
    int         line;
    Token       current;
    Token       ahead;
} Lexer;

void  lexer_init(Lexer *lex, const char *input);
Token lexer_next(Lexer *lex);
Token lexer_peek(Lexer *lex);
Token lexer_peek2(Lexer *lex);
void  lexer_advance(Lexer *lex);
int   lexer_expect(Lexer *lex, TokenKind kind);

const char *token_kind_name(TokenKind k);

#endif /* ARK_LEXER_H */
