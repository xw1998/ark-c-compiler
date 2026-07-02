/* test_designated.c - Designated initializer full implementation
 * Expected exit code: 1+0+3+10+30 = 44
 */
struct S { int a, b, c; };
struct S s = {.a = 1, .c = 3};
int arr[5] = {[1] = 10, [3] = 30};

int main(void) {
    return s.a + s.b + s.c + arr[1] + arr[3];  /* 44 */
}
