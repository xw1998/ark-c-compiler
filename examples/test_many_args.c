/* test_many_args.c - Function call with more than 4 args (AAPCS stack passing)
 * Expected exit code: 21   (1+2+3+4+5+6 through a 6-argument call)
 */
int sum6(int a, int b, int c, int d, int e, int f) {
    return a + b + c + d + e + f;
}

int main(void) { return sum6(1, 2, 3, 4, 5, 6); }  /* 21 */
