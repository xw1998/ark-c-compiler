/* Ark C Compiler stdlib - limits.h
 * Limits of the integer types (C99 5.2.4.2.1).
 * c99_test.c checks these against the host compiler. */
#ifndef ARK_LIMITS_H
#define ARK_LIMITS_H

#define CHAR_BIT    8
#define SCHAR_MIN   (-128)
#define SCHAR_MAX   127
#define UCHAR_MAX   255
#define CHAR_MAX    127
#define CHAR_MIN    (-128)

#define SHRT_MIN    (-32768)
#define SHRT_MAX    32767
#define USHRT_MAX   65535

#define INT_MIN     (-2147483647 - 1)
#define INT_MAX     2147483647
#define UINT_MAX    4294967295u

#define LONG_MIN    (-2147483647L - 1)
#define LONG_MAX    2147483647L
#define ULONG_MAX   4294967295ul

#define LLONG_MIN   (-9223372036854775807LL - 1)
#define LLONG_MAX   9223372036854775807LL
#define ULLONG_MAX  18446744073709551615ull

#define MB_LEN_MAX  1

#endif /* ARK_LIMITS_H */
