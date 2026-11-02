/* Ark C Compiler stdlib - stdint.h
 * C99 7.18: exact, minimum and fast width integer types.
 * int is 32 bits, long long is 64 bits and pointers are 32 bits (32-bit host). */
#ifndef ARK_STDINT_H
#define ARK_STDINT_H

/* Exact width types */
typedef signed char        int8_t;
typedef unsigned char      uint8_t;
typedef short              int16_t;
typedef unsigned short     uint16_t;
typedef int                int32_t;
typedef unsigned int       uint32_t;
typedef long long          int64_t;
typedef unsigned long long uint64_t;

/* Minimum width types */
typedef signed char        int_least8_t;
typedef unsigned char      uint_least8_t;
typedef short              int_least16_t;
typedef unsigned short     uint_least16_t;
typedef int                int_least32_t;
typedef unsigned int       uint_least32_t;
typedef long long          int_least64_t;
typedef unsigned long long uint_least64_t;

/* Fastest minimum width types */
typedef signed char        int_fast8_t;
typedef unsigned char      uint_fast8_t;
typedef int                int_fast16_t;
typedef unsigned int       uint_fast16_t;
typedef int                int_fast32_t;
typedef unsigned int       uint_fast32_t;
typedef long long          int_fast64_t;
typedef unsigned long long uint_fast64_t;

/* Pointer-sized integers */
typedef int                intptr_t;
typedef unsigned int       uintptr_t;

/* Widest integer types */
typedef long long          intmax_t;
typedef unsigned long long uintmax_t;

/* Limits of the exact width types */
#define INT8_MIN    (-128)
#define INT8_MAX    127
#define UINT8_MAX   255
#define INT16_MIN   (-32768)
#define INT16_MAX   32767
#define UINT16_MAX  65535
#define INT32_MIN   (-2147483647 - 1)
#define INT32_MAX   2147483647
#define UINT32_MAX  4294967295u
#define INT64_MIN   (-9223372036854775807LL - 1)
#define INT64_MAX   9223372036854775807LL
#define UINT64_MAX  18446744073709551615ull

/* Limits of the minimum width types */
#define INT_LEAST8_MIN   (-128)
#define INT_LEAST8_MAX   127
#define UINT_LEAST8_MAX  255
#define INT_LEAST16_MIN  (-32768)
#define INT_LEAST16_MAX  32767
#define UINT_LEAST16_MAX 65535
#define INT_LEAST32_MIN  (-2147483647 - 1)
#define INT_LEAST32_MAX  2147483647
#define UINT_LEAST32_MAX 4294967295u
#define INT_LEAST64_MIN  (-9223372036854775807LL - 1)
#define INT_LEAST64_MAX  9223372036854775807LL
#define UINT_LEAST64_MAX 18446744073709551615ull

/* Limits of the fast width types */
#define INT_FAST8_MIN    (-128)
#define INT_FAST8_MAX    127
#define UINT_FAST8_MAX   255
#define INT_FAST16_MIN   (-2147483647 - 1)
#define INT_FAST16_MAX   2147483647
#define UINT_FAST16_MAX  4294967295u
#define INT_FAST32_MIN   (-2147483647 - 1)
#define INT_FAST32_MAX   2147483647
#define UINT_FAST32_MAX  4294967295u
#define INT_FAST64_MIN   (-9223372036854775807LL - 1)
#define INT_FAST64_MAX   9223372036854775807LL
#define UINT_FAST64_MAX  18446744073709551615ull

/* Limits of the pointer-sized types */
#define INTPTR_MIN   (-2147483647 - 1)
#define INTPTR_MAX   2147483647
#define UINTPTR_MAX  4294967295u

/* Limits of the widest types */
#define INTMAX_MIN   (-9223372036854775807LL - 1)
#define INTMAX_MAX   9223372036854775807LL
#define UINTMAX_MAX  18446744073709551615ull

/* ptrdiff_t / size_t limits (C99 7.18.3) */
#define PTRDIFF_MIN (-2147483647 - 1)
#define PTRDIFF_MAX  2147483647
#define SIZE_MAX    4294967295u

/* Constant macros (C99 7.18.4) */
#define INT8_C(x)    (x)
#define UINT8_C(x)   (x)
#define INT16_C(x)   (x)
#define UINT16_C(x)  (x)
#define INT32_C(x)   (x)
#define UINT32_C(x)  (x##u)
#define INT64_C(x)   (x##ll)
#define UINT64_C(x)  (x##ull)
#define INTMAX_C(x)  (x##ll)
#define UINTMAX_C(x) (x##ull)

#endif
