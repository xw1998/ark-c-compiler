/* string_test.c - Strings, printf, strlen */
#include <stdio.h>
#include <string.h>

int main(void) {
    const char *msg = "hello, ark!\n";
    printf("%s", msg);
    printf("len = %d\n", strlen(msg));
    return strlen(msg);
}
