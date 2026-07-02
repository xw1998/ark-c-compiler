/* Ark C Compiler stdlib - ctype.h
 * C99 7.4 ??????????? */
#ifndef ARK_CTYPE_H
#define ARK_CTYPE_H

#ifndef EOF
#define EOF (-1)
#endif

/* C99 7.4.1 - ????????? */
int isalnum(int c);
int isalpha(int c);
int isblank(int c);   /* C99 ???? */
int iscntrl(int c);
int isdigit(int c);
int isgraph(int c);
int islower(int c);
int isprint(int c);
int ispunct(int c);
int isspace(int c);
int isupper(int c);
int isxdigit(int c);

/* C99 7.4.2 - ???????????? */
int tolower(int c);
int toupper(int c);

#endif /* ARK_CTYPE_H */
