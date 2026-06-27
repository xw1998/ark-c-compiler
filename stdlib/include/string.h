/* Ark C Compiler stdlib - string.h */
#ifndef ARK_STRING_H
#define ARK_STRING_H

#include <stddef.h>

int   strlen(const char *s);
int   strcmp(const char *a, const char *b);
char *strcpy(char *dst, const char *src);
void *memset(void *p, int c, size_t n);
void *memcpy(void *d, const void *s, size_t n);

#endif
