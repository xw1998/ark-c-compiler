/* Ark C Compiler - ast.h
 * ????????????????????
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
    double      fval;     /* ???????????????? type ? float/double ?? kind=AST_NUM ??????? */
    union {
        long long num_val;
        char *name;
        struct { AstNode *left; AstNode *right; int op; } binary;
        struct { AstNode *operand; int op; int is_postfix; } unary;
        struct { AstNode *cond; AstNode *true_expr; AstNode *false_expr; } ternary;
        struct { AstNode *cond; AstNode *then_stmt; AstNode *else_stmt; } if_stmt;
        struct { AstNode *cond; AstNode *body; } while_stmt;
        struct { AstNode *init; AstNode *cond; AstNode *step; AstNode *body; } for_stmt;
        struct { AstNode **stmts; int stmt_count; int stmt_capacity; int is_decl_list; } block;
        struct {
            char    *name;
            Type    *ret_type;
            AstNode **params;
            int      param_count;
            AstNode *body;
            int      is_external;
            int      is_static;
            int      is_variadic;
            int      svc_num;     /* __svc(n) ????0 ????? SVC ???? */
            int      is_irq;      /* __irq ??????? */
            int      is_weak;     /* __weak ?????? */
            int      is_naked;    /* __naked ???? */
            int      pack_align;  /* #pragma pack ???????0=??? */
            int      is_used;     /* __attribute__((used)) */
            int      is_unused;   /* __attribute__((unused)) */
            int      is_asm_func; /* __asm ???????? */
            int      forceinline; /* __forceinline */
            int      is_softfp;   /* __softfp */
            int      is_constructor; /* __attribute__((constructor)) */
            int      is_destructor;  /* __attribute__((destructor)) */
            int      is_deprecated;  /* __attribute__((deprecated)) */
            char    *alias_target;/* __attribute__((alias("xxx"))) */
            char    *asm_body;    /* __asm ??????????????? */
            /* 0.6.x??armcc 5 ????????????????????????????????????????? */
            int      is_value_in_regs; /* __value_in_regs */
            int      is_pure;          /* __pure / __attribute__((pure)) */
            int      is_const_attr;    /* __attribute__((const)) */
            int      is_interwork;     /* __interwork??????????*/
            int      smc_num;          /* __smc(n) ????-1=????? */
            int      global_reg;       /* __global_reg(n) ????????-1=????? */
        } func;
        struct {
            char    *name;
            Type    *var_type;
            AstNode *init;
            int      is_global;
            int      is_static;
            int      is_extern;
            int      is_const;   /* const ??????????? .rodata ????? */
            char    *section;    /* __attribute__((section("..."))) ????????0=??? */
            unsigned at_addr;    /* __at(addr) / #pragma location=addr??0=????? */
            int      has_at;     /* at_addr ??????? */
            int      align_bytes;/* __align(n) / __attribute__((aligned(n)))??0=??? */
            int      is_used;    /* __attribute__((used)) */
            int      is_unused;  /* __attribute__((unused)) */
            int      is_vla;     /* B3: ?????????var_type ????vla_size_expr ???????????? */
            AstNode *vla_size_expr; /* B3: VLA ???????????????? */
            /* 0.6.x??TLS / ??????????? */
            int      is_tls;     /* __thread ???????? */
            int      global_reg; /* __global_reg(n) ????????-1=????? */
        } var;
        struct { AstNode *array; AstNode *index; } array_access;
        struct { char *name; AstNode **args; int arg_count; int arg_capacity; AstNode *callee; } call;
        struct { AstNode **decls; int decl_count; int decl_capacity; } program;
        struct { AstNode *obj; char *member; int is_arrow; int offset; } member;
        struct { AstNode *expr; AstNode *body; AstNode **cases; int case_count; AstNode *default_case; } switch_stmt;
        struct { int value; AstNode *stmt; int label_id; } case_stmt;
        struct { char *name; AstNode *stmt; } label_stmt;
        struct { AstNode **items; int item_count; int item_capacity; } init_list;       /* AST_INIT_LIST */
        struct { char *field; int index; int has_field; int has_index; AstNode *value; } init_field; /* AST_INIT_FIELD */
        struct { char *text; char *outputs; char *inputs; char *clobbers; int is_volatile; } asm_stmt;
        struct { Type *lit_type; AstNode *init; } compound_lit;      /* AST_COMPOUND_LITERAL */
    } u;
};

AstNode *ast_new(AstNodeKind kind, int line);
AstNode *ast_num(long long val, int line);
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
