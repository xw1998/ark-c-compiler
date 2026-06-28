/* Ark C Compiler stdlib - stddef.h */
#ifndef ARK_STDDEF_H
#define ARK_STDDEF_H

#ifndef NULL
#define NULL ((void *)0)
#endif

typedef unsigned int size_t;
typedef int          ptrdiff_t;

/* B2: wchar_t 宽字符类型。C 后端生成代码会再 #include <wchar.h>，
 * 由 gcc 的 wchar.h 重新定义 wchar_t；此处定义供 arkcc 自身类型推导使用。
 * 与 ARM 平台一致：32 位无符号整数。 */
#ifndef __cplusplus
typedef unsigned int wchar_t;
#endif

#define offsetof(type, member) ((size_t)&(((type *)0)->member))

#endif
