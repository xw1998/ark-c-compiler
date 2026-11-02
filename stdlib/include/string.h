/* Ark C Compiler stdlib - string.h
 * C99 7.21: string handling. */
#ifndef ARK_STRING_H
#define ARK_STRING_H

#include <stddef.h>

int    strlen(const char *s);
size_t strnlen(const char *s, size_t n);
int    strcmp(const char *a, const char *b);
int    strncmp(const char *a, const char *b, size_t n);
int    strcasecmp(const char *a, const char *b);
int    strncasecmp(const char *a, const char *b, size_t n);
char  *strcpy(char *dst, const char *src);
char  *strncpy(char *dst, const char *src, size_t n);
char  *strcat(char *dst, const char *src);
char  *strncat(char *dst, const char *src, size_t n);
char  *strdup(const char *s);
char  *strchr(const char *s, int c);
char  *strrchr(const char *s, int c);
char  *strstr(const char *s, const char *sub);
char  *strpbrk(const char *s, const char *accept);
char  *strtok(char *s, const char *delim);
size_t strspn(const char *s, const char *accept);
size_t strcspn(const char *s, const char *reject);
int    memcmp(const void *a, const void *b, size_t n);
int    strcoll(const char *a, const char *b);
size_t strxfrm(char *dst, const char *src, size_t n);
char  *strerror(int errnum);

void  *memset(void *p, int c, size_t n);
void  *memcpy(void *d, const void *s, size_t n);
void  *memmove(void *d, const void *s, size_t n);
void  *memchr(const void *s, int c, size_t n);

#endif
