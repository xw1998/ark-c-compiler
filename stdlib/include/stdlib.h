/* Ark C Compiler stdlib - stdlib.h
 * C99 7.20: general utilities. */
#ifndef ARK_STDLIB_H
#define ARK_STDLIB_H

#include <stddef.h>

#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1
#define RAND_MAX     32767

void   abort(void);
void   exit(int status);
int    atexit(void (*func)(void));
int    system(const char *s);
char  *getenv(const char *name);

void  *malloc(size_t n);
void  *calloc(size_t n, size_t size);
void  *realloc(void *p, size_t n);
void   free(void *p);

int    abs(int j);
long   labs(long j);
long long llabs(long long j);

typedef struct { int quot; int rem; } div_t;
typedef struct { long quot; long rem; } ldiv_t;
typedef struct { long long quot; long long rem; } lldiv_t;

div_t    div(int numer, int denom);
ldiv_t   ldiv(long numer, long denom);
lldiv_t  lldiv(long long numer, long long denom);

void   _Exit(int status);

int    atoi(const char *s);
long   atol(const char *s);
long long atoll(const char *s);
double atof(const char *s);
double strtod(const char *s, char **endp);
float  strtof(const char *s, char **endp);
long double strtold(const char *s, char **endp);

long   strtol(const char *s, char **endp, int base);
long long strtoll(const char *s, char **endp, int base);
unsigned long strtoul(const char *s, char **endp, int base);
unsigned long long strtoull(const char *s, char **endp, int base);

void   srand(unsigned int seed);
int    rand(void);

void  *bsearch(const void *key, const void *base, size_t n, size_t sz,
               int (*cmp)(const void *, const void *));
void   qsort(void *base, size_t n, size_t sz,
             int (*cmp)(const void *, const void *));

char  *itoa(int value, char *s, int base);

#endif
