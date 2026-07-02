/* ptr_test.c - Pointers, arrays and address-of
 * Expected: a[3] = 30
 */
int main(void) {
    int a[5];
    int *p;
    int i;
    int v;
    for (i = 0; i < 5; i = i + 1) a[i] = i * 10;
    p = &a[0];
    v = p[3];
    return v;
}
