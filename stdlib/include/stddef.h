/* Ark C Compiler stdlib - stddef.h */
#ifndef ARK_STDDEF_H
#define ARK_STDDEF_H

#ifndef NULL
#define NULL ((void *)0)
#endif

typedef unsigned int size_t;
typedef int          ptrdiff_t;

#define offsetof(type, member) ((size_t)&(((type *)0)->member))

#endif
