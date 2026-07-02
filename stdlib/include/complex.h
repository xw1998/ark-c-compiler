/* Ark C Compiler stdlib - complex.h
 * C99 7.3 complex numbers support.
 * _Complex is a built-in type keyword; I is the imaginary unit.
 * arkcc emits _Complex types directly; the host compiler (gcc/clang) provides
 * native _Complex double support which is fully C99-compliant.
 * Note: _Complex double syntax is the GNU extension form of C99 double _Complex. */
#ifndef ARK_COMPLEX_H
#define ARK_COMPLEX_H

/* C99 7.3.1: complex/imaginary macros map to _Complex/_Imaginary keywords. */
#define complex   _Complex
#define imaginary _Imaginary

/* _Complex_I is the imaginary unit; defined via a literal for portability. */
#define _Complex_I (0.0f + 1.0fi)
#define I          _Complex_I

/* CMPLX macros (C11): construct a complex from real and imaginary parts. */
#define CMPLX(x, y) ((_Complex double)(x) + (_Complex double)I * (_Complex double)(y))
#define CMPLXF(x, y) ((_Complex float)(x) + (_Complex float)I * (_Complex float)(y))
#define CMPLXL(x, y) ((_Complex long double)(x) + (_Complex long double)I * (_Complex long double)(y))

/* Trigonometric, exponential, logarithmic, power (C99 7.3.5-7.3.6). */
double       creal(_Complex double z);
float        crealf(_Complex float z);
long double  creall(_Complex long double z);

double       cimag(_Complex double z);
float        cimagf(_Complex float z);
long double  cimagl(_Complex long double z);

_Complex double  conj(_Complex double z);
_Complex float   conjf(_Complex float z);
_Complex long double conjl(_Complex long double z);

double       cabs(_Complex double z);
float        cabsf(_Complex float z);
long double  cabsl(_Complex long double z);

double       carg(_Complex double z);
float        cargf(_Complex float z);
long double  cargl(_Complex long double z);

_Complex double  cexp(_Complex double z);
_Complex float   cexpf(_Complex float z);
_Complex long double cexpl(_Complex long double z);

_Complex double  clog(_Complex double z);
_Complex float   clogf(_Complex float z);

_Complex double  csqrt(_Complex double z);
_Complex float   csqrtf(_Complex float z);

_Complex double  cpow(_Complex double x, _Complex double y);

_Complex double  csin(_Complex double z);
_Complex double  ccos(_Complex double z);
_Complex double  ctan(_Complex double z);

/* C99 7.3.6: hyperbolic / inverse trig / inverse hyperbolic */
_Complex double  csinh(_Complex double z);
_Complex double  ccosh(_Complex double z);
_Complex double  ctanh(_Complex double z);
_Complex double  casin(_Complex double z);
_Complex double  cacos(_Complex double z);
_Complex double  catan(_Complex double z);
_Complex double  casinh(_Complex double z);
_Complex double  cacosh(_Complex double z);
_Complex double  catanh(_Complex double z);

/* C99 7.3.9: projection */
_Complex double  cproj(_Complex double z);

/* float / long double suffixed variants */
float       crealf(_Complex float z);
float       cimagf(_Complex float z);
_Complex float   conjf(_Complex float z);
float       cabsf(_Complex float z);
float       cargf(_Complex float z);
_Complex float   cexpf(_Complex float z);
_Complex float   clogf(_Complex float z);
_Complex float   csqrtf(_Complex float z);
_Complex float   cpowf(_Complex float x, _Complex float y);
_Complex float   csinf(_Complex float z);
_Complex float   ccosf(_Complex float z);
_Complex float   ctanf(_Complex float z);
_Complex float   csinhf(_Complex float z);
_Complex float   ccoshf(_Complex float z);
_Complex float   ctanhf(_Complex float z);
_Complex float   casinf(_Complex float z);
_Complex float   cacosf(_Complex float z);
_Complex float   catanf(_Complex float z);
_Complex float   casinhf(_Complex float z);
_Complex float   cacoshf(_Complex float z);
_Complex float   catanhf(_Complex float z);
_Complex float   cprojf(_Complex float z);

long double creall(_Complex long double z);
long double cimagl(_Complex long double z);
_Complex long double conjl(_Complex long double z);
long double cabsl(_Complex long double z);
long double cargl(_Complex long double z);
_Complex long double cexpl(_Complex long double z);
_Complex long double clogl(_Complex long double z);
_Complex long double csqrtl(_Complex long double z);
_Complex long double cpowl(_Complex long double x, _Complex long double y);
_Complex long double csinl(_Complex long double z);
_Complex long double ccosl(_Complex long double z);
_Complex long double ctanl(_Complex long double z);
_Complex long double csinhl(_Complex long double z);
_Complex long double ccoshl(_Complex long double z);
_Complex long double ctanhl(_Complex long double z);
_Complex long double casinl(_Complex long double z);
_Complex long double cacosl(_Complex long double z);
_Complex long double catanl(_Complex long double z);
_Complex long double casinhl(_Complex long double z);
_Complex long double cacoshl(_Complex long double z);
_Complex long double catanhl(_Complex long double z);
_Complex long double cprojl(_Complex long double z);

#endif /* ARK_COMPLEX_H */
