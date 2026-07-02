/* goto_test.c - goto + label
 * Expected: loop 0..9, sum = 45
 */
int main(void) {
    int i = 0;
    int sum = 0;
loop:
    if (i >= 10) goto done;
    sum = sum + i;
    i = i + 1;
    goto loop;
done:
    return sum;
}
