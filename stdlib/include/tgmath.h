/* Ark C Compiler stdlib - tgmath.h
 * C99 7.22: type-generic math.
 * A proper implementation needs _Generic (C11), which is unavailable here, so
 * every function maps to its double form; float/long double calls therefore go
 * through double. c99_test.c checks that 4.0/4.0f/4.0L all work.
 *
 * arkcc limitation: without _Generic the argument is promoted to double,
 * so float/long double precision is lost; test_tgmath does not rely on it
 * (e.g. fabs(-3.0)==3.0 still holds). */
#ifndef ARK_TGMATH_H
#define ARK_TGMATH_H

#include <math.h>

/* sqrt and the other float entry points: without _Generic the macro
 * widens the argument to double and calls the C99 double version. */
#define sqrt(x)    sqrt((double)(x))
#define fabs(x)    fabs((double)(x))
#define sin(x)     sin((double)(x))
#define cos(x)     cos((double)(x))
#define tan(x)     tan((double)(x))
#define asin(x)    asin((double)(x))
#define acos(x)    acos((double)(x))
#define atan(x)    atan((double)(x))
#define atan2(y,x) atan2((double)(y), (double)(x))
#define exp(x)     exp((double)(x))
#define log(x)     log((double)(x))
#define log10(x)   log10((double)(x))
#define pow(x,y)   pow((double)(x), (double)(y))
#define ceil(x)    ceil((double)(x))
#define floor(x)   floor((double)(x))
#define fmod(x,y)  fmod((double)(x), (double)(y))

#endif /* ARK_TGMATH_H */
