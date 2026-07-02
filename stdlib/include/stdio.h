/* Ark C Compiler stdlib - stdio.h
 * C99 7.9??????????? */
#ifndef ARK_STDIO_H
#define ARK_STDIO_H

#include <stddef.h>
#include <stdarg.h>

typedef struct _iobuf FILE;

extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;

#define EOF (-1)

#define BUFSIZ  256
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

int   printf(const char *fmt, ...);
int   fprintf(FILE *fp, const char *fmt, ...);
int   sprintf(char *buf, const char *fmt, ...);
int   snprintf(char *buf, size_t n, const char *fmt, ...);
int   vprintf(const char *fmt, va_list ap);
int   vfprintf(FILE *fp, const char *fmt, va_list ap);
int   vsprintf(char *buf, const char *fmt, va_list ap);
int   vsnprintf(char *buf, size_t n, const char *fmt, va_list ap);

int   putchar(int c);
int   puts(const char *s);
int   fputc(int c, FILE *fp);
int   fputs(const char *s, FILE *fp);
int   fgetc(FILE *fp);
int   getchar(void);
char *fgets(char *s, int n, FILE *fp);
int   fputs(const char *s, FILE *fp);

int   fputs(const char *s, FILE *fp);
FILE *fopen(const char *path, const char *mode);
int   fclose(FILE *fp);
size_t fread(void *ptr, size_t size, size_t nmemb, FILE *fp);
size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *fp);
int   fseek(FILE *fp, long off, int whence);
long  ftell(FILE *fp);
void  rewind(FILE *fp);
int   fflush(FILE *fp);

#endif
