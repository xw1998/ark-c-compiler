/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * L'A'
 * Expected exit code: 65
 */
/* Wide character test: wchar_t + L"..." + L'...' */
#include <stddef.h>

int main(void) {
    wchar_t wc = L'A';
    return (int)wc;  /* 65 */
}
