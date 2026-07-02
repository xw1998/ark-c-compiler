/* Wide character test: wchar_t + L"..." + L'...' */
#include <stddef.h>

int main(void) {
    wchar_t wc = L'A';
    return (int)wc;  /* 65 */
}
