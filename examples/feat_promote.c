/* feat_promote.c - char/short implicit promotion
 * Expected: 50
 */
int main(void) {
    char c = 10;
    short s = 20;
    int  i = 5;
    /* c + s promoted to int, result 30 */
    int sum = c + s + i + 15;  /* 50 */
    return sum;
}
