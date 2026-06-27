/* Ark C Compiler - ast.h
 * 抽象语法树节点定义与构造接口。
 */
#ifndef ARK_AST_H
#define ARK_AST_H

#include "common.h"
#include "type.h"

typedef struct AstNode AstNode;

struct AstNode {
    AstNodeKind kind;
    Type       *type;
    int         line;
    double      fval;     /* 浮点字面量；仅当 type 为 float/double 且 kind=AST_NUM 时有意义 */
    union {
        int   num_val;
        char *name;
        struct { AstNode *left; AstNode *right; int op; } binary;
        struct { AstNode *operand; int op; int is_postfix; } unary;
        struct { AstNode *cond; AstNode *true_expr; AstNode *false_expr; } ternary;
        struct { AstNode *cond; AstNode *then_stmt; AstNode *else_stmt; } if_stmt;
        struct { AstNode *cond; AstNode *body; } while_stmt;
        struct { AstNode *init; AstNode *cond; AstNode *step; AstNode *body; } for_stmt;
        struct { AstNode **stmts; int stmt_count; } block;
        struct {
            char    *name;
            Type    *ret_type;
            AstNode **params;
            int      param_count;
            AstNode *body;
            int      is_external;
            int      is_static;
            int      is_variadic;
            int      svc_num;     /* __svc(n) 编号；0 表示非 SVC 函数 */
            int      is_irq;      /* __irq 中断函数 */
            int      is_weak;     /* __weak 弱符号 */
            int      is_naked;    /* __naked 裸函数 */
            int      pack_align;  /* #pragma pack 对齐值；0=默认 */
            int      is_used;     /* __attribute__((used)) */
            int      is_unused;   /* __attribute__((unused)) */
            int      is_asm_func; /* __asm 整函数体 */
            int      forceinline; /* __forceinline */
            int      is_softfp;   /* __softfp */
            int      is_constructor; /* __attribute__((constructor)) */
            int      is_destructor;  /* __attribute__((destructor)) */
            int      is_deprecated;  /* __attribute__((deprecated)) */
            char    *alias_target;/* __attribute__((alias("xxx"))) */
            char    *asm_body;    /* __asm 函数体的原始汇编文本 */
        } func;
        struct {
            char    *name;
            Type    *var_type;
            AstNode *init;
            int      is_global;
            int      is_static;
            int      is_extern;
            int      is_const;   /* const 限定符（用于 .rodata 段选择） */
            char    *section;    /* __attribute__((section("..."))) 自定义段；0=默认 */
            unsigned at_addr;    /* __at(addr) / #pragma location=addr；0=未指定 */
            int      has_at;     /* at_addr 是否有效 */
            int      align_bytes;/* __align(n) / __attribute__((aligned(n)))；0=默认 */
            int      is_used;    /* __attribute__((used)) */
            int      is_unused;  /* __attribute__((unused)) */
        } var;
        struct { AstNode *array; AstNode *index; } array_access;
        struct { char *name; AstNode **args; int arg_count; AstNode *callee; } call;
        struct { AstNode **decls; int decl_count; } program;
        struct { AstNode *obj; char *member; int is_arrow; int offset; } member;
        struct { AstNode *expr; AstNode *body; AstNode **cases; int case_count; AstNode *default_case; } switch_stmt;
        struct { int value; AstNode *stmt; int label_id; } case_stmt;
        struct { char *name; AstNode *stmt; } label_stmt;
        struct { AstNode **items; int item_count; } init_list;       /* AST_INIT_LIST */
        struct { char *field; int index; int has_field; int has_index; AstNode *value; } init_field; /* AST_INIT_FIELD */
        struct { char *text; char *outputs; char *inputs; char *clobbers; int is_volatile; } asm_stmt;
        struct { Type *lit_type; AstNode *init; } compound_lit;      /* AST_COMPOUND_LITERAL */
    } u;
};

AstNode *ast_new(AstNodeKind kind, int line);
AstNode *ast_num(int val, int line);
AstNode *ast_str(const char *content, int line);
AstNode *ast_var(const char *name, int line);
AstNode *ast_binary(int op, AstNode *left, AstNode *right, int line);
AstNode *ast_unary(int op, AstNode *operand, int line);
AstNode *ast_assign(int op, AstNode *left, AstNode *right, int line);
AstNode *ast_if(AstNode *cond, AstNode *then_stmt, AstNode *else_stmt, int line);
AstNode *ast_while(AstNode *cond, AstNode *body, int line);
AstNode *ast_for(AstNode *init, AstNode *cond, AstNode *step, AstNode *body, int line);
AstNode *ast_block(int line);
void     block_add_stmt(AstNode *block, AstNode *stmt);
AstNode *ast_func_def(char *name, Type *ret_type, AstNode **params, int param_count, AstNode *body, int line);
AstNode *ast_var_decl(char *name, Type *var_type, AstNode *init, int line);
AstNode *ast_func_call(char *name, AstNode **args, int arg_count, int line);
AstNode *ast_array_access(AstNode *array, AstNode *index, int line);
AstNode *ast_member(AstNode *obj, const char *member, int is_arrow, int line);
AstNode *ast_cast(Type *target, AstNode *expr, int line);
AstNode *ast_sizeof_val(int bytes, int line);

#endif /* ARK_AST_H */
