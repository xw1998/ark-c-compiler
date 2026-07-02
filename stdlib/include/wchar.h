/* Ark C Compiler stdlib - wchar.h
 * C99 7.24 wide character utilities.
 * wchar_t is defined in <stddef.h>; we re-declare only the library functions. */
#ifndef ARK_WCHAR_H
#define ARK_WCHAR_H

#include <stddef.h>
#include <stdarg.h>
#include <stdint.h>
#include <inttypes.h>

#ifndef WCHAR_MAX
#define WCHAR_MAX ((wchar_t)~0u)
#endif
#ifndef WCHAR_MIN
#define WCHAR_MIN ((wchar_t)0)
#endif

#ifndef WEOF
/* WEOF must match the value returned by host libc.
 * mingw wint_t is 16-bit wide, so WEOF = (wint_t)-1 = 0xFFFF = 65535;
 * btowc(EOF)/fgetwc return 0xFFFF. Using 0xFFFFFFFF would not match 65535. */
#define WEOF (0xFFFF)
#endif

typedef int wint_t;
typedef int mbstate_t;

size_t    wcslen(const wchar_t *s);
int       wcscmp(const wchar_t *s1, const wchar_t *s2);
int       wcsncmp(const wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t  *wcscpy(wchar_t *dest, const wchar_t *src);
wchar_t  *wcsncpy(wchar_t *dest, const wchar_t *src, size_t n);
wchar_t  *wcscat(wchar_t *dest, const wchar_t *src);
wchar_t  *wcsncat(wchar_t *dest, const wchar_t *src, size_t n);
wchar_t  *wcschr(const wchar_t *s, wchar_t c);
size_t    wcscspn(const wchar_t *s1, const wchar_t *s2);
size_t    wcsspn(const wchar_t *s1, const wchar_t *s2);

wchar_t  *wcstok(wchar_t *s1, const wchar_t *s2, wchar_t **ptr);
long      wcstol(const wchar_t *s, wchar_t **endp, int base);
unsigned long wcstoul(const wchar_t *s, wchar_t **endp, int base);
long long wcstoll(const wchar_t *s, wchar_t **endp, int base);
unsigned long long wcstoull(const wchar_t *s, wchar_t **endp, int base);
intmax_t  wcstoimax(const wchar_t *s, wchar_t **endp, int base);
uintmax_t wcstoumax(const wchar_t *s, wchar_t **endp, int base);
double    wcstod(const wchar_t *s, wchar_t **endp);
float     wcstof(const wchar_t *s, wchar_t **endp);
long double wcstold(const wchar_t *s, wchar_t **endp);

int       swprintf(wchar_t *s, size_t n, const wchar_t *fmt, ...);
int       vswprintf(wchar_t *s, size_t n, const wchar_t *fmt, va_list ap);
int       wprintf(const wchar_t *fmt, ...);
int       fwprintf(void *stream, const wchar_t *fmt, ...);
int       swscanf(const wchar_t *s, const wchar_t *fmt, ...);
int       wscanf(const wchar_t *fmt, ...);
int       fwscanf(void *stream, const wchar_t *fmt, ...);
wint_t    fputwc(wchar_t c, void *stream);
wint_t    getwc(void *stream);
wint_t    ungetwc(wint_t c, void *stream);

size_t    mbrtowc(wchar_t *pwc, const char *s, size_t n, mbstate_t *ps);
size_t    wcrtomb(char *s, wchar_t wc, mbstate_t *ps);
size_t    mbstowcs(wchar_t *dest, const char *src, size_t n);
size_t    wcstombs(char *dest, const wchar_t *src, size_t n);
int       mbsinit(const mbstate_t *ps);

int       wctob(wint_t c);
wint_t    btowc(int c);

#endif /* ARK_WCHAR_H */
