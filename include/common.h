/* Ark C Compiler - common.h
 * 公共类型、Token 种类、AST 节点种类、IR 操作枚举与错误处理宏。
 *
 * 注意：TokenKind 中 TOK_PLUS..TOK_SHR_ASSIGN 的数值会被 codegen/irgen
 * 当作运算符 op-id 使用。新增 token 必须追加到枚举末尾，不要插队。
 */
#ifndef ARK_COMMON_H
#define ARK_COMMON_H

#include <stddef.h>
#include <stdint.h>

#define ARK_VERSION "0.2.0"

/* 错误码 */
#define ARK_OK              0
#define ARK_ERR_IO          -1
#define ARK_ERR_LEX         -2
#define ARK_ERR_PARSE       -3
#define ARK_ERR_SEMA        -4
#define ARK_ERR_IRGEN       -5
#define ARK_ERR_CODEGEN     -6
#define ARK_ERR_ASM         -7
#define ARK_ERR_LINK        -8
#define ARK_ERR_OOM         -9
#define ARK_ERR_ARG         -10

/* Token 种类 */
typedef enum {
    TOK_EOF = 0,

    /* C89 关键字 */
    TOK_INT, TOK_CHAR, TOK_VOID, TOK_RETURN,
    TOK_IF, TOK_ELSE, TOK_WHILE, TOK_FOR,
    TOK_BREAK, TOK_CONTINUE, TOK_DO,

    /* 字面量与标识符 */
    TOK_NUM,
    TOK_STR,
    TOK_IDENT,

    /* 运算符 */
    TOK_PLUS, TOK_MINUS, TOK_MUL, TOK_DIV, TOK_MOD,
    TOK_ASSIGN,
    TOK_EQ, TOK_NE,
    TOK_LT, TOK_GT, TOK_LE, TOK_GE,
    TOK_AND, TOK_OR, TOK_NOT,
    TOK_BAND, TOK_BOR, TOK_BXOR, TOK_BNOT,
    TOK_SHL, TOK_SHR,

    /* 复合赋值 */
    TOK_ADD_ASSIGN, TOK_SUB_ASSIGN,
    TOK_MUL_ASSIGN, TOK_DIV_ASSIGN,
    TOK_MOD_ASSIGN,
    TOK_AND_ASSIGN, TOK_OR_ASSIGN, TOK_XOR_ASSIGN,
    TOK_SHL_ASSIGN, TOK_SHR_ASSIGN,

    /* 自增自减 */
    TOK_INC, TOK_DEC,

    /* 分隔符 */
    TOK_LPAREN, TOK_RPAREN,
    TOK_LBRACE, TOK_RBRACE,
    TOK_LBRACKET, TOK_RBRACKET,
    TOK_SEMICOLON, TOK_COMMA,
    TOK_COLON, TOK_QUESTION,

    TOK_HASH,

    /* === 以下为 0.2.0 新增，必须保持在末尾 === */
    /* C99 关键字 */
    TOK_SHORT, TOK_LONG, TOK_SIGNED, TOK_UNSIGNED,
    TOK_FLOAT, TOK_DOUBLE,
    TOK_BOOL,             /* _Bool */
    TOK_CONST, TOK_VOLATILE, TOK_RESTRICT, TOK_INLINE,
    TOK_STATIC, TOK_EXTERN, TOK_AUTO, TOK_REGISTER,
    TOK_STRUCT, TOK_UNION, TOK_ENUM, TOK_TYPEDEF,
    TOK_SIZEOF,
    TOK_SWITCH, TOK_CASE, TOK_DEFAULT,
    TOK_GOTO,
    TOK_FCONST,           /* 浮点字面量（值放在 t.fvalue） */

    /* 成员访问 */
    TOK_DOT, TOK_ARROW,
    /* 变参省略号 */
    TOK_ELLIPSIS,

    /* === 0.3.0 新增（必须保持在末尾） === */
    TOK_ATTRIBUTE,        /* __attribute__ */
    TOK_ASM,              /* asm / __asm / __asm__ */
    TOK_FUNC_NAME,        /* __func__ -> 由 lexer 直接产生为字符串字面量；保留枚举占位 */
    TOK_SVC,              /* __svc (ARM Compiler 5 SVC 声明) */
    TOK_IRQ,              /* __irq (ARM Compiler 5 中断函数) */
    TOK_WEAK,             /* __weak (ARM Compiler 5 弱符号) */
    TOK_NAKED,            /* __naked (ARM Compiler 5 裸函数) */
    TOK_PACKED_KW,        /* __packed (ARM Compiler 5 紧凑结构) */
    TOK_ALIGN_KW,         /* __align(n) (ARM Compiler 5 对齐) */
    TOK_AT,               /* __at(addr) (ARM Compiler 5 绝对地址) */
    TOK_SOFTFP,           /* __softfp */
    TOK_FORCEINLINE,      /* __forceinline */
    TOK_ASM_FN,           /* __asm 函数体 (ARM Compiler 5) */

    TOK__SENTINEL
} TokenKind;

/* AST 节点种类 */
typedef enum {
    AST_PROGRAM = 0,
    AST_FUNC_DEF,
    AST_FUNC_DECL,
    AST_VAR_DECL,
    AST_BLOCK,
    AST_RETURN,
    AST_IF,
    AST_WHILE,
    AST_FOR,
    AST_DO_WHILE,
    AST_BREAK,
    AST_CONTINUE,
    AST_BINARY,
    AST_UNARY,
    AST_TERNARY,
    AST_ASSIGN,
    AST_NUM,
    AST_VAR,
    AST_ARRAY_ACCESS,
    AST_FUNC_CALL,
    AST_EXPR_STMT,

    /* === 0.2.0 新增 === */
    AST_STR,           /* 字符串字面量；u.name 保存内容（已解转义） */
    AST_CAST,          /* (T)expr；u.unary.operand = expr，node->type 即目标类型 */
    AST_MEMBER,        /* expr.member 或 expr->member */
    AST_SIZEOF,        /* sizeof(T) 或 sizeof(expr)；u.num_val = 字节数 */
    AST_SWITCH,
    AST_CASE,
    AST_DEFAULT,
    AST_GOTO,
    AST_LABEL,
    AST_COMMA,         /* 逗号表达式 */
    AST_TYPEDEF,       /* 顶层 typedef，无运行时含义 */

    /* === 0.3.0 新增 === */
    AST_INIT_LIST,     /* { e1, e2, .field=ev, [i]=ev } */
    AST_INIT_FIELD,    /* .field = expr 或 [index] = expr 之初始化项 */
    AST_ASM,           /* 内联汇编 */
    AST_COMPOUND_LITERAL, /* (T){...} */

    /* === 0.4.0 新增 === */
    AST_ASM_FUNC       /* __asm void fn(...) { ... } 整函数体汇编 */
} AstNodeKind;

/* IR 操作 */
typedef enum {
    IR_NOP = 0,
    IR_PUSH_INT,
    IR_PUSH_VAR,
    IR_PUSH_ADDR,
    IR_POP,
    IR_STORE,
    IR_STORE_IDX,
    IR_LOAD_IDX,
    IR_BINARY,
    IR_UNARY,
    IR_CALL,
    IR_RETURN,
    IR_LABEL,
    IR_JMP,
    IR_JZ,
    IR_JNZ,
    IR_FUNC_BEGIN,
    IR_FUNC_END,
    IR_LOCAL_ALLOC,
    IR_ARG,
    IR_GETARG,

    /* === 0.2.0 新增 === */
    IR_PUSH_STR,       /* name = 字符串内容；val = strpool 索引 */
    IR_PUSH_GLOBAL,    /* name = 全局变量名 */
    IR_STORE_GLOBAL,   /* name = 全局变量名 */
    IR_DUP,            /* 栈顶复制 */
    IR_LABEL_NAMED,    /* name = 用户标签 */
    IR_JMP_NAMED,      /* name = 用户标签 */
    IR_CMP_JMP_EQ,     /* 出栈一个值与立即数 val 比较，相等则跳到 aux 标签 */

    /* === 0.3.0 新增 === */
    IR_PUSH_FLOAT,     /* aux 索引到 program->floats[]；C 后端按 double 处理 */
    IR_FADD,           /* 浮点四则 */
    IR_FSUB,
    IR_FMUL,
    IR_FDIV,
    IR_FCMP,           /* aux = TOK_EQ / TOK_NE / TOK_LT ... */
    IR_F2I,            /* 浮点 -> 整数 */
    IR_I2F,            /* 整数 -> 浮点 */
    IR_ASM,            /* 内联汇编片段；name = 模板原文 */
    IR_SVC,            /* ARM SVC 指令；val = SVC 编号 */
    IR_DIV,            /* 整数除法；aux=0 有符号, aux=1 无符号 */
    IR_MOD,            /* 取模；aux=0 有符号, aux=1 无符号 */
    IR_64BINARY,       /* 64 位二元运算；aux = TOK_xxx */
    IR_64PUSH,         /* 推入 64 位立即数；val=高32位, aux=低32位 */
    IR_64CMP,          /* 64 位比较；aux = TOK_xxx */
    IR_64F2I,          /* 64 位浮点 -> 64 位整数 */
    IR_64I2F,          /* 64 位整数 -> 64 位浮点 */
    IR_MEMCPY,         /* 内存拷贝；val=字节数（结构体赋值/按值传递） */
    IR_STORE_FLD,      /* 位域存储；val=位偏移, aux=位宽 */
    IR_LOAD_FLD,       /* 位域读取；val=位偏移, aux=位宽 */
    IR_PUSH_GLOBAL_ADDR /* 取全局变量地址；name = 全局变量名（不加载值） */
} IrOp;

/* 简单字符串比较，避免依赖 string.h */
int ark_streq(const char *a, const char *b);
int ark_strlen(const char *s);

#endif /* ARK_COMMON_H */
