/* Ark C Compiler stdlib - fenv.h
 * C99 7.6: floating point environment.
 * Most functions are only stubs here; the host libc or the CRT supplies the real ones. */
#ifndef ARK_FENV_H
#define ARK_FENV_H

/* Exception flags */
#define FE_DIVBYZERO  0x01
#define FE_INEXACT    0x02
#define FE_INVALID    0x04
#define FE_OVERFLOW   0x08
#define FE_UNDERFLOW  0x10
#define FE_ALL_EXCEPT (FE_DIVBYZERO | FE_INEXACT | FE_INVALID | FE_OVERFLOW | FE_UNDERFLOW)

/* Rounding modes */
#define FE_DOWNWARD   0x400
#define FE_TONEAREST  0x000
#define FE_TOWARDZERO 0xC00
#define FE_UPWARD     0x800

typedef int fexcept_t;
typedef int fenv_t;

/* C99 7.6.7: FE_DFL_ENV is not a real object here; -1 avoids an extern
 * definition. mingw's host libc has no real fesetenv, and the STM32 stub
 * fesetenv only needs a non-NULL pointer to restore the default environment,
 * so the "FE_DFL_ENV != NULL" test keeps working. */
#define FE_DFL_ENV ((const fenv_t *)-1)

int fegetenv(fenv_t *envp);
int fesetenv(const fenv_t *envp);
int feclearexcept(int excepts);
int fetestexcept(int excepts);
int feraiseexcept(int excepts);
int fegetexceptflag(fexcept_t *flagp, int excepts);
int fesetexceptflag(const fexcept_t *flagp, int excepts);
int fegetround(void);
int fesetround(int round);
int feholdexcept(fenv_t *envp);
int feupdateenv(const fenv_t *envp);

#endif /* ARK_FENV_H */
