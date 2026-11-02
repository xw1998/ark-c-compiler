/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * sizeof applied to a call expression must use the callee's return type,
 * not the "unknown expression" default of 4 bytes.
 * Expected exit code: 0
 */
/* feat_sizeof_call.c - sizeof(call expression)
 * Folding happens during parsing, so the parser has to know the callee's
 * return type. `double g(void)` used to yield sizeof(g()) == 4.
 */
static double g(void);
static int    h(void);

int main(void) {
    int r = 0;

    if (sizeof(g()) != 8) r += 1;      /* double */
    if (sizeof(h()) != 4) r += 2;      /* int */
    if ((int)(g() * 2.0) != 3) r += 4;
    if (h() != 7) r += 8;

    return r;
}

static double g(void) { return 1.5; }
static int    h(void) { return 7; }
