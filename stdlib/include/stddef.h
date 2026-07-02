/* Ark C Compiler stdlib - stddef.h */
#ifndef ARK_STDDEF_H
#define ARK_STDDEF_H

#ifndef NULL
#define NULL ((void *)0)
#endif

typedef unsigned int size_t;
typedef int          ptrdiff_t;

/* B2: wchar_t wide-character type. The C backend re-includes <wchar.h>,
 * where gcc's wchar.h redefines wchar_t; this definition is for arkcc's own
 * type deduction. Matches the ARM platform: 32-bit unsigned integer. */
#ifndef __cplusplus
typedef unsigned int wchar_t;
#endif

#define offsetof(type, member) ((size_t)&(((type *)0)->member))

#endif
