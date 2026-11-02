/* Ark C Compiler stdlib - wctype.h
 * C99 7.25: wide character classification and conversion. */
#ifndef ARK_WCTYPE_H
#define ARK_WCTYPE_H

#include <stddef.h>

#ifndef WEOF
#define WEOF ((wint_t)-1)
#endif

typedef int wint_t;
typedef int wctype_t;
typedef int wctrans_t;

int iswalpha(wint_t wc);
int iswdigit(wint_t wc);
int iswspace(wint_t wc);
int iswupper(wint_t wc);
int iswlower(wint_t wc);
int iswxdigit(wint_t wc);
int iswalnum(wint_t wc);
int iswcntrl(wint_t wc);
int iswgraph(wint_t wc);
int iswprint(wint_t wc);
int iswpunct(wint_t wc);
int iswblank(wint_t wc);  /* C99 addition */

wint_t towupper(wint_t wc);
wint_t towlower(wint_t wc);

wctype_t    wctype(const char *property);
int         iswctype(wint_t wc, wctype_t desc);
wctrans_t   wctrans(const char *property);
wint_t      towctrans(wint_t wc, wctrans_t desc);

#endif /* ARK_WCTYPE_H */
