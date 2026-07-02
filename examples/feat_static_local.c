/* feat_static_local.c - Function-local static variable
 * Expected: static counter equals 3 after 3 calls, returns 3
 */
int counter(void) {
    static int c = 0;
    c = c + 1;
    return c;
}

int main(void) {
    counter();
    counter();
    return counter();   /* 3 */
}
