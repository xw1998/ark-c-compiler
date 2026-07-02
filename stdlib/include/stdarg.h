/* Ark C Compiler stdlib - stdarg.h
 * Varargs support for arkcc's stack-machine C backend.
 *
 * arkcc passes all arguments as `long long a0..a7`. For variadic functions
 * the C backend stores all 8 args at a fixed frame region (frame+8000..+64)
 * and declares a local `_ark_va_ptr` pointing to the first variadic arg.
 * va_start initializes ap from _ark_va_ptr; va_arg reads and advances by
 * 8 bytes (sizeof(long long)).
 *
 * The extern declaration below lets the semantic analyzer accept the
 * _ark_va_ptr reference in va_start; the C backend emits a real local
 * definition that shadows this extern inside variadic functions.
 *
 * Limitation: va_arg(double/float) would need bit-pattern reinterpret via
 * _ark_ll2d; this header handles the common integer/pointer case directly.
 * Use ark_va_arg_d for double varargs.
 */
#ifndef ARK_STDARG_H
#define ARK_STDARG_H

typedef long long *va_list;

/* Forward declaration so sema accepts va_start; the C backend provides the
 * actual definition (local to each variadic function). */
extern long long *_ark_va_ptr;

#define va_start(ap, last) ((void)((ap) = _ark_va_ptr))
#define va_arg(ap, type)   ((type)(*ap++))
#define va_end(ap)         ((void)0)
#define va_copy(d, s)      ((d) = (s))

/* Helper for double varargs: reads the long long bit pattern and reinterprets
 * it as double via _ark_ll2d (declared in the generated preamble). */
#define ark_va_arg_d(ap)   (_ark_ll2d(*ap++))

#endif
