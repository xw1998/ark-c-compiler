/* Ark C Compiler stdlib - ctype.h
 * C99 7.4: character classification and conversion. */
#ifndef ARK_CTYPE_H
#define ARK_CTYPE_H

#ifndef EOF
#define EOF (-1)
#endif

/* C99 7.4.1 - character classification */
int isalnum(int c);
int isalpha(int c);
int isblank(int c);   /* C99 addition */
int iscntrl(int c);
int isdigit(int c);
int isgraph(int c);
int islower(int c);
int isprint(int c);
int ispunct(int c);
int isspace(int c);
int isupper(int c);
int isxdigit(int c);

/* C99 7.4.2 - character conversion */
int tolower(int c);
int toupper(int c);

#endif /* ARK_CTYPE_H */
