/* Ark C Compiler - memory.h
 * Bump allocator, used as the memory pool for AST/IR/symbol tables.
 */
#ifndef ARK_MEMORY_H
#define ARK_MEMORY_H

#include "common.h"

/* Default 8MB memory pool (host); redefinable at compile time.
 * The pool backs all AST/IR/symbol allocations via a bump allocator that
 * never frees until mem_pool_reset. 8MB gives headroom for large files
 * with many #include directives (observed peak ~4.0MB for a 48KB test with
 * 20 includes: ~2.7MB parse + ~0.1MB sema + ~1.2MB irgen).
 * STM32 overrides via -DARK_POOL_SIZE=262144. */
#ifndef ARK_POOL_SIZE
#define ARK_POOL_SIZE (64 * 1024 * 1024)
#endif

void  mem_pool_reset(void);
void *mem_pool_alloc(int size);
char *mem_strdup(const char *s);
char *mem_strndup(const char *s, int n);
void *mem_realloc(void *old_ptr, int old_size, int new_size);
int   mem_pool_used(void);

#endif /* ARK_MEMORY_H */
