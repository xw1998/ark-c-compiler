/* Ark C Compiler - symtab
 * 符号表：作用域嵌套的 hash 表。
 *
 * 注意：为支持 typedef 与 struct tag，符号表同时存储类型名与变量名。
 * 离开作用域时只移除高层符号，不影响外层。
 */
#include "symtab.h"
#include "memory.h"

#define SYM_HASH_SIZE 128

static Symbol *g_table[SYM_HASH_SIZE];
static int     g_current_scope;

void sym_init(void) {
    int i;
    for (i = 0; i < SYM_HASH_SIZE; i++) g_table[i] = 0;
    g_current_scope = 0;
}

static unsigned sym_hash(const char *s) {
    unsigned h = 0;
    while (*s) {
        h = h * 31 + (unsigned char)*s;
        s++;
    }
    return h % SYM_HASH_SIZE;
}

void sym_enter_scope(void) { g_current_scope++; }

void sym_leave_scope(void) {
    int i;
    for (i = 0; i < SYM_HASH_SIZE; i++) {
        Symbol **pp = &g_table[i];
        while (*pp) {
            if ((*pp)->scope_level >= g_current_scope) {
                *pp = (*pp)->next;
            } else {
                pp = &(*pp)->next;
            }
        }
    }
    if (g_current_scope > 0) g_current_scope--;
}

int sym_current_scope(void) { return g_current_scope; }

Symbol *sym_find(const char *name) {
    unsigned h = sym_hash(name);
    Symbol *s;
    for (s = g_table[h]; s; s = s->next) {
        if (ark_streq(s->name, name)) return s;
    }
    return 0;
}

Symbol *sym_find_current(const char *name) {
    unsigned h = sym_hash(name);
    Symbol *s;
    for (s = g_table[h]; s; s = s->next) {
        if (s->scope_level == g_current_scope && ark_streq(s->name, name))
            return s;
    }
    return 0;
}

Symbol *sym_add(SymKind kind, const char *name, Type *type, int offset) {
    unsigned h = sym_hash(name);
    Symbol *s = (Symbol *)mem_pool_alloc(sizeof(Symbol));
    s->kind = kind;
    s->name = mem_strdup(name);
    s->type = type;
    s->scope_level = g_current_scope;
    s->offset = offset;
    s->is_defined = 0;
    s->param_count = 0;
    s->is_variadic = 0;
    s->is_static = 0;
    s->is_extern = 0;
    s->enum_value = 0;
    s->svc_num = 0;
    s->is_irq = 0;
    s->is_weak = 0;
    s->is_naked = 0;
    s->is_used = 0;
    s->is_unused = 0;
    s->is_asm_func = 0;
    s->forceinline = 0;
    s->alias_target = 0;
    s->next = g_table[h];
    g_table[h] = s;
    return s;
}

int sym_is_typedef(const char *name) {
    Symbol *s = sym_find(name);
    return s && s->kind == SYM_TYPEDEF;
}
