/* Ark C Compiler - memory.h
 * Bump Allocator（碰撞分配器），用作 AST/IR/符号表内存池。
 */
#ifndef ARK_MEMORY_H
#define ARK_MEMORY_H

#include "common.h"

/* 默认 1MB 内存池（host），编译期可重定义 */
#ifndef ARK_POOL_SIZE
#define ARK_POOL_SIZE (1024 * 1024)
#endif

void  mem_pool_reset(void);
void *mem_pool_alloc(int size);
char *mem_strdup(const char *s);
char *mem_strndup(const char *s, int n);
void *mem_realloc(void *old_ptr, int old_size, int new_size);
int   mem_pool_used(void);

#endif /* ARK_MEMORY_H */
