/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * C99 6.10.3.2 stringification: no leading/trailing blanks, internal runs of
 * whitespace collapse to one space, even through two levels of macros.
 * Expected exit code: 0
 */
/* feat_stringify.c - # operator whitespace handling
 * XSTR(MULTI(1,2)) expands MULTI first, then stringifies "1 + 2". The
 * replacement list of MULTI carries leading indentation in the source, which
 * used to leak into the resulting literal.
 */
#define STR(x)     #x
#define XSTR(x)    STR(x)
#define MULTI(a,b) a + b

int main(void) {
    const char *s = STR(hello);
    const char *t = XSTR(MULTI(1, 2));
    const char *u = STR(  spaced   out  );
    int r = 0;

    if (s[0] != 'h' || s[4] != 'o' || s[5] != 0) r += 1;

    if (t[0] != '1') r += 2;            /* no leading blank */
    if (t[1] != ' ') r += 4;
    if (t[2] != '+') r += 8;
    if (t[3] != ' ') r += 16;
    if (t[4] != '2' || t[5] != 0) r += 32;

    if (u[0] != 's') r += 64;           /* surrounding blanks dropped */
    if (u[5] != 'd' || u[6] != ' ') r += 128;  /* "spaced" then one space */
    if (u[7] != 'o' || u[9] != 't' || u[10] != 0) r += 256;

    return r;
}
