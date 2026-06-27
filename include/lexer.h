/* Ark C Compiler - lexer.h
 * 词法分析器：把源代码切成 Token 序列。
 */
#ifndef ARK_LEXER_H
#define ARK_LEXER_H

#include "common.h"

typedef struct {
    TokenKind kind;
    int       value;
    double    fvalue;
    char     *str;
    int       line;
    const char *src_start;  /* token 在源码中的起始指针；用于 __asm 函数体抓取原文 */
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
