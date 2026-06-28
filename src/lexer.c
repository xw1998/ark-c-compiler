/* Ark C Compiler - lexer
 * 词法分析器实现。
 *
 * 支持要点：
 *   - 全套 C99 关键字（含 _Bool/inline/restrict）
 *   - 八进制 0755、十六进制 0xFF、整数后缀 u/U/l/L
 *   - 浮点字面量：1.5、1.5e-3、.5、1.5f
 *   - 字符串与字符的完整转义：\n \t \r \\ \' \" \0 \xNN \NNN \a \b \f \v
 *   - 相邻字符串字面量拼接
 *   - 注释 // 与块注释
 *   - . / -> / ...
 */
#include "lexer.h"
#include "memory.h"
#include "platform.h"
#include "config.h"
#include "arkcc_config.h"
#include "type.h"

static Token lexer_read_token(Lexer *lex);

/* 包装 lexer_read_token：在调用前记录当前位置作为 token 起点，
 * 供 parser 抓取原始源码片段（如 __asm 函数体）。 */
static Token lexer_read_token_with_pos(Lexer *lex) {
    const char *p_before;
    Token t;
    /* 跳过空白与注释，定位到 token 第一个字符 */
    /* 复用 lexer_read_token 内的 skip 逻辑会导致重复跳过，因此这里手动
     * 在 lexer_read_token 里设置 src_start；为简化，直接调用并在 token
     * src_start 上写入：lexer_read_token 在 EOF 分支已写入，其余分支
     * 由本函数补充——我们记下调用前 p 的位置（包含空白）但 token
     * 实际起点在跳过空白后，因此先 inline 跳空白。 */
    {
        /* 复制 skip_ws_and_comments 的轻量版本：仅前移 p */
        while (*lex->p) {
            char c = *lex->p;
            if (c == ' ' || c == '\t' || c == '\r') lex->p++;
            else if (c == '\n') { lex->line++; lex->p++; }
            else if (c == '/' && lex->p[1] == '/') {
                while (*lex->p && *lex->p != '\n') lex->p++;
            } else if (c == '/' && lex->p[1] == '*') {
                lex->p += 2;
                while (*lex->p && !(lex->p[0]=='*' && lex->p[1]=='/')) {
                    if (*lex->p == '\n') lex->line++;
                    lex->p++;
                }
                if (*lex->p) lex->p += 2;
            } else break;
        }
    }
    p_before = lex->p;
    t = lexer_read_token(lex);
    if (!t.src_start) t.src_start = p_before;
    return t;
}

static int is_alpha(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_';
}
static int is_digit(char c) { return c >= '0' && c <= '9'; }
static int is_alnum(char c) { return is_alpha(c) || is_digit(c); }
static int is_hex(char c) {
    return is_digit(c) || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F');
}
static int is_oct(char c) { return c >= '0' && c <= '7'; }

static int hex_val(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    return c - 'A' + 10;
}

static Token make_token(TokenKind kind, int line) {
    Token t;
    t.kind = kind; t.value = 0; t.fvalue = 0.0; t.str = 0; t.line = line;
    t.src_start = 0;
    return t;
}

static Token make_number(int val, int line) {
    Token t = make_token(TOK_NUM, line);
    t.value = val;
    return t;
}

static Token make_ident(const char *start, int len, int line) {
    Token t = make_token(TOK_IDENT, line);
    t.str = mem_strndup(start, len);
    return t;
}

/* 关键字表 */
typedef struct { const char *s; TokenKind k; } Keyword;

static Keyword g_keywords[] = {
    /* C89 */
    {"int",      TOK_INT},
    {"char",     TOK_CHAR},
    {"void",     TOK_VOID},
    {"return",   TOK_RETURN},
    {"if",       TOK_IF},
    {"else",     TOK_ELSE},
    {"while",    TOK_WHILE},
    {"for",      TOK_FOR},
    {"break",    TOK_BREAK},
    {"continue", TOK_CONTINUE},
    {"do",       TOK_DO},
    /* C99 扩展 */
    {"short",    TOK_SHORT},
    {"long",     TOK_LONG},
    {"signed",   TOK_SIGNED},
    {"unsigned", TOK_UNSIGNED},
    {"float",    TOK_FLOAT},
    {"double",   TOK_DOUBLE},
    {"_Bool",    TOK_BOOL},
    {"const",    TOK_CONST},
    {"volatile", TOK_VOLATILE},
    {"restrict", TOK_RESTRICT},
    {"inline",   TOK_INLINE},
    {"static",   TOK_STATIC},
    {"extern",   TOK_EXTERN},
    {"auto",     TOK_AUTO},
    {"register", TOK_REGISTER},
    {"struct",   TOK_STRUCT},
    {"union",    TOK_UNION},
    {"enum",     TOK_ENUM},
    {"typedef",  TOK_TYPEDEF},
    {"sizeof",   TOK_SIZEOF},
    {"switch",   TOK_SWITCH},
    {"case",     TOK_CASE},
    {"default",  TOK_DEFAULT},
    {"goto",     TOK_GOTO},
    /* 0.3.0 GNU 扩展关键字 */
    {"__attribute__", TOK_ATTRIBUTE},
    {"asm",           TOK_ASM},
    {"__asm",         TOK_ASM},
    {"__asm__",       TOK_ASM},
    {"__inline",      TOK_INLINE},
    {"__inline__",    TOK_INLINE},
    {"__volatile__",  TOK_VOLATILE},
    {"__const",       TOK_CONST},
    {"__restrict",    TOK_RESTRICT},
    {"__svc",         TOK_SVC},     /* ARM Compiler 5 SVC 声明 */
    {"__irq",         TOK_IRQ},     /* ARM Compiler 5 中断函数 */
    {"__weak",        TOK_WEAK},    /* ARM Compiler 5 弱符号 */
    {"__naked",       TOK_NAKED},   /* ARM Compiler 5 裸函数 */
    {"__packed",      TOK_PACKED_KW},  /* ARM Compiler 5 紧凑结构关键字 */
    {"__align",       TOK_ALIGN_KW},   /* ARM Compiler 5 对齐关键字 */
    {"__at",          TOK_AT},         /* ARM Compiler 5 绝对地址定位关键字 */
    {"__softfp",      TOK_SOFTFP},     /* ARM Compiler 5 软浮点 ABI */
    {"__forceinline", TOK_FORCEINLINE},/* ARM Compiler 5 强制内联 */
    /* B4: _Complex 关键字（C99）*/
    {"_Complex",      TOK_COMPLEX},
    {"__complex__",   TOK_COMPLEX},
    /* __asm 词法上仍归为 TOK_ASM；parser 通过上下文区分内联 asm 语句与
     * armcc 风格整函数体汇编（__asm void fn(){...}）。 */
    {0, TOK_EOF}
};

static int kw_eq(const char *s, int len, const char *kw) {
    int i;
    for (i = 0; i < len; i++) {
        if (s[i] != kw[i]) return 0;
        if (kw[i] == 0) return 0;
    }
    return kw[len] == 0;
}

static int check_keyword(const char *s, int len) {
    int i;
    for (i = 0; g_keywords[i].s; i++) {
        if (kw_eq(s, len, g_keywords[i].s)) return (int)g_keywords[i].k;
    }
    return -1;
}

static void skip_ws_and_comments(Lexer *lex) {
    while (*lex->p) {
        char c = *lex->p;
        if (c == ' ' || c == '\t' || c == '\r') {
            lex->p++;
        } else if (c == '\n') {
            lex->line++;
            lex->p++;
        } else if (c == '/' && lex->p[1] == '/') {
            while (*lex->p && *lex->p != '\n') lex->p++;
        } else if (c == '/' && lex->p[1] == '*') {
            lex->p += 2;
            while (*lex->p && !(lex->p[0]=='*' && lex->p[1]=='/')) {
                if (*lex->p == '\n') lex->line++;
                lex->p++;
            }
            if (*lex->p) lex->p += 2;
        } else {
            break;
        }
    }
}

/* 处理 \xNN \NNN \n \t 等单个转义字符，返回处理后的字符值，并推进 *pp。
 * pp 指向 '\' 后的字符位置（即第一个转义说明字符）。
 */
static int read_escape(const char **pp) {
    char e = **pp;
    int v;
    if (e == 'x') {
        (*pp)++;
        v = 0;
        while (is_hex(**pp)) { v = v * 16 + hex_val(**pp); (*pp)++; }
        return v & 0xFF;
    }
    if (e >= '0' && e <= '7') {
        int n = 0;
        v = 0;
        while (n < 3 && is_oct(**pp)) {
            v = v * 8 + (**pp - '0');
            (*pp)++;
            n++;
        }
        return v & 0xFF;
    }
    (*pp)++;
    switch (e) {
        case 'n':  return '\n';
        case 't':  return '\t';
        case 'r':  return '\r';
        case '\\': return '\\';
        case '\'': return '\'';
        case '"':  return '"';
        case '?':  return '?';
        case 'a':  return 7;
        case 'b':  return 8;
        case 'f':  return 12;
        case 'v':  return 11;
        case '0':  return 0;
        default:   return e;
    }
}

static Token lexer_read_token(Lexer *lex) {
    const char *start;
    int line;
    char c;
    Token tk;

    skip_ws_and_comments(lex);
    start = lex->p;
    line = lex->line;
    c = *lex->p;

    if (c == '\0') { tk = make_token(TOK_EOF, line); tk.src_start = start; return tk; }

#if ARKCC_FEATURE_WCHAR
    /* B2: 宽字符串 L"..." 与宽字符 L'...'。
     * 编译期 + 运行时双重守护。L 后紧跟 " 或 ' 才视为宽字面量；
     * 否则按普通标识符处理（如变量名 L）。 */
    if (g_config.enable_wchar && c == 'L' &&
        (lex->p[1] == '"' || lex->p[1] == '\'')) {
        if (lex->p[1] == '"') {
            /* 宽字符串：复用 TOK_STR，value 置 1 作为宽字符串标记 */
            Token t = make_token(TOK_STR, line);
            int cap = 32, len = 0;
            char *buf = (char *)mem_pool_alloc(cap);
            lex->p += 2; /* 跳过 L" */
            while (*lex->p && *lex->p != '"') {
                int ch;
                if (*lex->p == '\\' && lex->p[1]) {
                    lex->p++;
                    ch = read_escape(&lex->p);
                } else {
                    ch = (unsigned char)*lex->p;
                    lex->p++;
                }
                if (len + 1 >= cap) {
                    int nc = cap * 2;
                    buf = (char *)mem_realloc(buf, cap, nc);
                    cap = nc;
                }
                buf[len++] = (char)ch;
            }
            if (*lex->p == '"') lex->p++;
            buf[len] = 0;
            t.str = buf;
            t.value = 1;  /* 宽字符串标记 */
            return t;
        } else {
            /* 宽字符 L'...'：C 语义下为整型常量，按 TOK_NUM 返回 */
            int val = 0;
            lex->p += 2; /* 跳过 L' */
            if (*lex->p == '\\') {
                lex->p++;
                val = read_escape(&lex->p);
            } else if (*lex->p) {
                val = (unsigned char)*lex->p;
                lex->p++;
            }
            if (*lex->p == '\'') lex->p++;
            return make_number(val, line);
        }
    }
#endif

    /* 标识符 / 关键字 */
    if (is_alpha(c)) {
        int len, kw;
        while (is_alnum(*lex->p)) lex->p++;
        len = (int)(lex->p - start);
        kw = check_keyword(start, len);
        if (kw >= 0) return make_token((TokenKind)kw, line);
        return make_ident(start, len, line);
    }

    /* 数字（含浮点） */
    if (is_digit(c) || (c == '.' && is_digit(lex->p[1]))) {
        int is_float = 0;
        int val = 0;
        double fval = 0.0;

        if (c == '0' && (lex->p[1] == 'x' || lex->p[1] == 'X')) {
            /* 十六进制 */
            lex->p += 2;
            while (is_hex(*lex->p)) {
                val = val * 16 + hex_val(*lex->p);
                lex->p++;
            }
            /* 跳过整数后缀 */
            while (*lex->p == 'u' || *lex->p == 'U' ||
                   *lex->p == 'l' || *lex->p == 'L') lex->p++;
            return make_number(val, line);
        }

        if (c == '0' && is_oct(lex->p[1])) {
            /* 八进制 */
            lex->p++;
            while (is_oct(*lex->p)) {
                val = val * 8 + (*lex->p - '0');
                lex->p++;
            }
            while (*lex->p == 'u' || *lex->p == 'U' ||
                   *lex->p == 'l' || *lex->p == 'L') lex->p++;
            return make_number(val, line);
        }

        /* 十进制整数或浮点 */
        while (is_digit(*lex->p)) {
            val = val * 10 + (*lex->p - '0');
            lex->p++;
        }
        if (*lex->p == '.') {
            is_float = 1;
            lex->p++;
            while (is_digit(*lex->p)) lex->p++;
        }
        if (*lex->p == 'e' || *lex->p == 'E') {
            is_float = 1;
            lex->p++;
            if (*lex->p == '+' || *lex->p == '-') lex->p++;
            while (is_digit(*lex->p)) lex->p++;
        }
        if (is_float) {
            /* 解析浮点：用简单累乘法 */
            const char *q = start;
            double sign = 1.0;
            double intp = 0.0, fracp = 0.0, frac_scale = 1.0;
            int has_exp = 0, exp_neg = 0, exp_v = 0;
            int i;
            if (*q == '-') { sign = -1.0; q++; }
            while (is_digit(*q)) { intp = intp * 10.0 + (*q - '0'); q++; }
            if (*q == '.') {
                q++;
                while (is_digit(*q)) {
                    fracp = fracp * 10.0 + (*q - '0');
                    frac_scale *= 10.0;
                    q++;
                }
            }
            if (*q == 'e' || *q == 'E') {
                has_exp = 1;
                q++;
                if (*q == '-') { exp_neg = 1; q++; }
                else if (*q == '+') q++;
                while (is_digit(*q)) { exp_v = exp_v * 10 + (*q - '0'); q++; }
            }
            fval = sign * (intp + fracp / frac_scale);
            if (has_exp) {
                double e = 1.0;
                for (i = 0; i < exp_v; i++) e *= 10.0;
                if (exp_neg) fval /= e; else fval *= e;
            }
            if (*lex->p == 'f' || *lex->p == 'F' ||
                *lex->p == 'l' || *lex->p == 'L') lex->p++;
            {
                Token t = make_token(TOK_FCONST, line);
                t.fvalue = fval;
                t.value = (int)fval;
                return t;
            }
        }
        /* 整数后缀 */
        while (*lex->p == 'u' || *lex->p == 'U' ||
               *lex->p == 'l' || *lex->p == 'L') lex->p++;
        return make_number(val, line);
    }

    /* 字符字面量 */
    if (c == '\'') {
        int val = 0;
        lex->p++;
        if (*lex->p == '\\') {
            lex->p++;
            val = read_escape(&lex->p);
        } else if (*lex->p) {
            val = (unsigned char)*lex->p;
            lex->p++;
        }
        if (*lex->p == '\'') lex->p++;
        return make_number(val, line);
    }

    /* 字符串字面量（含相邻拼接） */
    if (c == '"') {
        Token t = make_token(TOK_STR, line);
        int cap = 32, len = 0;
        char *buf = (char *)mem_pool_alloc(cap);
        for (;;) {
            lex->p++; /* 跳过开引号 */
            while (*lex->p && *lex->p != '"') {
                int ch;
                if (*lex->p == '\\' && lex->p[1]) {
                    lex->p++;
                    ch = read_escape(&lex->p);
                } else {
                    ch = (unsigned char)*lex->p;
                    lex->p++;
                }
                if (len + 1 >= cap) {
                    int nc = cap * 2;
                    buf = (char *)mem_realloc(buf, cap, nc);
                    cap = nc;
                }
                buf[len++] = (char)ch;
            }
            if (*lex->p == '"') lex->p++;
            /* 相邻字符串拼接 */
            {
                const char *q = lex->p;
                while (*q == ' ' || *q == '\t' || *q == '\r' || *q == '\n') {
                    if (*q == '\n') lex->line++;
                    q++;
                }
                if (*q == '"') {
                    lex->p = q;
                    continue;
                }
            }
            break;
        }
        buf[len] = 0;
        t.str = buf;
        return t;
    }

    lex->p++;
    switch (c) {
        case '(': return make_token(TOK_LPAREN, line);
        case ')': return make_token(TOK_RPAREN, line);
        case '{': return make_token(TOK_LBRACE, line);
        case '}': return make_token(TOK_RBRACE, line);
        case '[': return make_token(TOK_LBRACKET, line);
        case ']': return make_token(TOK_RBRACKET, line);
        case ';': return make_token(TOK_SEMICOLON, line);
        case ',': return make_token(TOK_COMMA, line);
        case '?': return make_token(TOK_QUESTION, line);
        case ':': return make_token(TOK_COLON, line);
        case '#': return make_token(TOK_HASH, line);
        case '~': return make_token(TOK_BNOT, line);
        case '.':
            if (lex->p[0] == '.' && lex->p[1] == '.') {
                lex->p += 2;
                return make_token(TOK_ELLIPSIS, line);
            }
            return make_token(TOK_DOT, line);
        case '^':
            if (*lex->p == '=') { lex->p++; return make_token(TOK_XOR_ASSIGN, line); }
            return make_token(TOK_BXOR, line);
        case '+':
            if (*lex->p == '+') { lex->p++; return make_token(TOK_INC, line); }
            if (*lex->p == '=') { lex->p++; return make_token(TOK_ADD_ASSIGN, line); }
            return make_token(TOK_PLUS, line);
        case '-':
            if (*lex->p == '-') { lex->p++; return make_token(TOK_DEC, line); }
            if (*lex->p == '=') { lex->p++; return make_token(TOK_SUB_ASSIGN, line); }
            if (*lex->p == '>') { lex->p++; return make_token(TOK_ARROW, line); }
            return make_token(TOK_MINUS, line);
        case '*':
            if (*lex->p == '=') { lex->p++; return make_token(TOK_MUL_ASSIGN, line); }
            return make_token(TOK_MUL, line);
        case '/':
            if (*lex->p == '=') { lex->p++; return make_token(TOK_DIV_ASSIGN, line); }
            return make_token(TOK_DIV, line);
        case '%':
            if (*lex->p == '=') { lex->p++; return make_token(TOK_MOD_ASSIGN, line); }
            return make_token(TOK_MOD, line);
        case '=':
            if (*lex->p == '=') { lex->p++; return make_token(TOK_EQ, line); }
            return make_token(TOK_ASSIGN, line);
        case '!':
            if (*lex->p == '=') { lex->p++; return make_token(TOK_NE, line); }
            return make_token(TOK_NOT, line);
        case '<':
            if (*lex->p == '=') { lex->p++; return make_token(TOK_LE, line); }
            if (*lex->p == '<') {
                lex->p++;
                if (*lex->p == '=') { lex->p++; return make_token(TOK_SHL_ASSIGN, line); }
                return make_token(TOK_SHL, line);
            }
            return make_token(TOK_LT, line);
        case '>':
            if (*lex->p == '=') { lex->p++; return make_token(TOK_GE, line); }
            if (*lex->p == '>') {
                lex->p++;
                if (*lex->p == '=') { lex->p++; return make_token(TOK_SHR_ASSIGN, line); }
                return make_token(TOK_SHR, line);
            }
            return make_token(TOK_GT, line);
        case '&':
            if (*lex->p == '&') { lex->p++; return make_token(TOK_AND, line); }
            if (*lex->p == '=') { lex->p++; return make_token(TOK_AND_ASSIGN, line); }
            return make_token(TOK_BAND, line);
        case '|':
            if (*lex->p == '|') { lex->p++; return make_token(TOK_OR, line); }
            if (*lex->p == '=') { lex->p++; return make_token(TOK_OR_ASSIGN, line); }
            return make_token(TOK_BOR, line);
        default:
            ark_log("[lexer] line %d: unknown char '%c' (0x%02X)\n", line, c, (unsigned char)c);
            return make_token(TOK_EOF, line);
    }
}

void lexer_init(Lexer *lex, const char *input) {
    lex->input = input;
    lex->p = input;
    lex->line = 1;
    lex->current = lexer_read_token_with_pos(lex);
    lex->ahead = lexer_read_token_with_pos(lex);
}

Token lexer_peek(Lexer *lex)  { return lex->current; }
Token lexer_peek2(Lexer *lex) { return lex->ahead; }

Token lexer_next(Lexer *lex) {
    Token t = lex->current;
    lex->current = lex->ahead;
    lex->ahead = lexer_read_token_with_pos(lex);
    return t;
}

void lexer_advance(Lexer *lex) {
    (void)lexer_next(lex);
}

int lexer_expect(Lexer *lex, TokenKind kind) {
    if (lex->current.kind != kind) {
        ark_log("[parser] line %d: expected token kind %d but got %d\n",
                lex->current.line, (int)kind, (int)lex->current.kind);
        return 0;
    }
    lexer_advance(lex);
    return 1;
}

const char *token_kind_name(TokenKind k) {
    switch (k) {
        case TOK_EOF: return "EOF";
        case TOK_IDENT: return "ident";
        case TOK_NUM: return "num";
        case TOK_STR: return "str";
        case TOK_FCONST: return "fconst";
        default: return "tok";
    }
}
