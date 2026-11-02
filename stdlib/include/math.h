/* Ark C Compiler stdlib - math.h
 * C99 7.12???????????????????????
 * ?????? host libc ?? stdlib/src/math.c?? */
#ifndef ARK_MATH_H
#define ARK_MATH_H

#include <stddef.h>
#include <float.h>   /* DBL_MIN/FLT_MIN ???? fpclassify ?? */

/* C99 7.12 7.2: float_t/double_t ?? ?????? float/double ??? */
#ifndef float_t
typedef float float_t;
#endif
#ifndef double_t
typedef double double_t;
#endif

/* ????????????????? C99 ?????? armcc/glibc ??????????? */
#ifndef M_PI
#define M_PI        3.14159265358979323846
#endif
#ifndef M_E
#define M_E         2.71828182845904523536
#endif
#ifndef M_SQRT2
#define M_SQRT2     1.41421356237309504880
#endif

/* ????????C99 7.12.3 / 7.12.4?? */
#define FP_INFINITE   1
#define FP_NAN        2
#define FP_NORMAL     3
#define FP_SUBNORMAL  4
#define FP_ZERO       5

#define FP_ILOGB0     (-1)
#define FP_ILOGBNAN   (-1)

/* huge_valf/huge_val */
#define HUGE_VALF 3.40282347e+38f
#define HUGE_VAL  1.7976931348623157e+308
#define HUGE_VALL ((long double)HUGE_VAL)

/* INFINITY / NAN */
#define INFINITY   HUGE_VALF
#define NAN        (0.0f/0.0f)

/* signbit???????????????? -0.0??
 * -0.0 < 0.0 ? false??IEEE754?????????? 1.0/x ???? ??0??
 *   1.0/(-0.0) = -inf < 0??1.0/(+0.0) = +inf > 0?? */
#define signbit(x)  (((x) < 0.0) || (((x) == 0.0) && ((1.0/((double)(x))) < 0.0)))

/* isinf????????inf - inf = nan ?? 0???????? x-x = 0??
 * ???? (x == x) ??? NaN?? */
#define isinf(x)    (((x) == (x)) && (((x) - (x)) != 0.0))
#define isnan(x)    ((x) != (x))
#define isfinite(x) (!isnan(x) && !isinf(x))

/* fpclassify??????????NaN/????/??/subnormal/normal????
 * subnormal ????????????? < DBL_MIN???????????????
 * ???-O2 ???????? FTZ??flush-to-zero????subnormal ????? 0??
 * ??????? FP_ZERO???????????? FPU ??????????????? */
#define fpclassify(x) (isnan(x) ? FP_NAN : \
                       isinf(x)  ? FP_INFINITE : \
                       ((x) == 0.0) ? FP_ZERO : \
                       (((x) < DBL_MIN) && ((x) > -DBL_MIN)) ? FP_SUBNORMAL : \
                       FP_NORMAL)

/* isnormal??????????????????????????????? NaN?? */
#define isnormal(x) (((double)(x) != 0.0) && !isnan(x) && !isinf(x))

/* C99 7.12.14 ?????? NaN ?????????? */
#define isgreater(x, y)      (((x) > (y)) ? 1 : 0)
#define isgreaterequal(x, y) (((x) >= (y)) ? 1 : 0)
#define isless(x, y)         (((x) < (y)) ? 1 : 0)
#define islessequal(x, y)    (((x) <= (y)) ? 1 : 0)
#define islessgreater(x, y)  ((((x) < (y)) || ((x) > (y))) ? 1 : 0)
#define isunordered(x, y)    ((isnan(x) || isnan(y)) ? 1 : 0)

/* ????????/???/???? */
double fabs(double x);
double sqrt(double x);
double floor(double x);
double ceil(double x);
double fmod(double x, double y);
double sin(double x);
double cos(double x);
double tan(double x);
double asin(double x);
double acos(double x);
double atan(double x);
double atan2(double y, double x);
double exp(double x);
double log(double x);
double log10(double x);
double pow(double x, double y);

/* ????????????? */
double copysign(double x, double y);
double fmax(double x, double y);
double fmin(double x, double y);
double fdim(double x, double y);
double fma(double x, double y, double z);
double scalbn(double x, int n);
double scalbln(double x, long n);
double ldexp(double x, int exp);
double frexp(double value, int *exp);
double modf(double value, double *iptr);
double nextafter(double x, double y);
double nexttoward(double x, long double y);
double nan(const char *s);
float nanf(const char *s);
long double nanl(const char *s);

/* ????????? */
double trunc(double x);
double round(double x);
long   lround(double x);
long long llround(double x);
double rint(double x);
long   lrint(double x);
double nearbyint(double x);
double remainder(double x, double y);
double remquo(double x, double y, int *quo);

/* ???/??????? */
double exp2(double x);
double expm1(double x);
double log2(double x);
double log1p(double x);
double logb(double x);

/* ????? */
double cbrt(double x);
double hypot(double x, double y);
double pow(double x, double y);

/* ????? / gamma */
double erf(double x);
double erfc(double x);
double lgamma(double x);
double tgamma(double x);

/* float / long double ?????? */
float  fabsf(float x);
float  sqrtf(float x);
float  floorf(float x);
float  ceilf(float x);
float  fmodf(float x, float y);
float  sinf(float x);
float  cosf(float x);
float  tanf(float x);
float  powf(float x, float y);

long double fabsl(long double x);
long double sqrtl(long double x);

#endif
