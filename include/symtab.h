/* Ark C Compiler - symtab.h
 * 符号表：支持作用域嵌套，hash + 链表实现。
 */
#ifndef ARK_SYMTAB_H
#define ARK_SYMTAB_H

#include "common.h"
#include "type.h"

typedef enum {
    SYM_VAR = 0,
    SYM_FUNC,
    SYM_PARAM,
    SYM_GLOBAL,
    SYM_TYPEDEF,
    SYM_ENUM_CONST,
    SYM_STRUCT_TAG,
    SYM_UNION_TAG,
    SYM_ENUM_TAG
} SymKind;

typedef struct Symbol {
    SymKind        kind;
    char          *name;
    Type          *type;
    int            scope_level;
    int            offset;       /* 局部变量为相对 fp 的偏移；全局/枚举常量另作用 */
    int            is_defined;
    int            param_count;
    int            is_variadic;
    int            is_static;
    int            is_extern;
    int            enum_value;
    int            svc_num;      /* __svc(n) 编号；0 表示非 SVC 函数 */
    int            smc_num;      /* __smc(n) 编号；0 表示非 SMC 函数 */
    int            is_irq;       /* __irq 中断函数 */
    int            is_weak;      /* __weak 弱符号 */
    int            is_naked;     /* __naked 裸函数 */
    int            is_used;      /* __attribute__((used)) */
    int            is_unused;    /* __attribute__((unused)) */
    int            is_asm_func;  /* __asm 整函数体 */
    int            forceinline;  /* __forceinline */
    char          *alias_target; /* __attribute__((alias("xxx"))) */
    struct Symbol *next;
} Symbol;

void    sym_init(void);
void    sym_enter_scope(void);
void    sym_leave_scope(void);
int     sym_current_scope(void);
Symbol *sym_find(const char *name);
Symbol *sym_find_current(const char *name);
Symbol *sym_add(SymKind kind, const char *name, Type *type, int offset);
int     sym_is_typedef(const char *name);

#endif /* ARK_SYMTAB_H */
