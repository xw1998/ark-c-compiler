/* Ark C Compiler stdlib - stdarg.h
 * 极简实现：我们的运行时 va_list 仅占位，真正可变参数通过 host libc 转发。
 */
#ifndef ARK_STDARG_H
#define ARK_STDARG_H

typedef char *va_list;

#define va_start(ap, last) ((void)0)
#define va_arg(ap, type)   (*(type *)0)
#define va_end(ap)         ((void)0)
#define va_copy(d, s)      ((void)0)

#endif
