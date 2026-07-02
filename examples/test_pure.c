/* test_pure.c - __pure pure function test
 * Expected exit code: 9
 */
__pure int square(int x) { return x * x; }
int main(void) { return square(3); }  /* 9 */
