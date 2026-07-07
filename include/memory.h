/* Ark C Compiler - memory.h
 * Bump allocator, used as the memory pool for AST/IR/symbol tables.
 */
#ifndef ARK_MEMORY_H
#define ARK_MEMORY_H

#include "common.h"
#include "arkcc_config.h"   /* brings in profile-aware ARK_POOL_SIZE */

/* ARK_POOL_SIZE is defined by arkcc_config.h (profile-aware):
 *   STM32 profile: 128 KB
 *   Host profile:   64 MB
 * Override via -DARK_POOL_SIZE=<bytes> on the command line if needed. */

void  mem_pool_reset(void);
void *mem_pool_alloc(int size);
char *mem_strdup(const char *s);
char *mem_strndup(const char *s, int n);
void *mem_realloc(void *old_ptr, int old_size, int new_size);
int   mem_pool_used(void);

#endif /* ARK_MEMORY_H */
