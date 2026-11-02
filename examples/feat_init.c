/* feat_init.c - Aggregate + designated initialization + string array init
 * Expected exit code: 119   (sum(1..5) = 15 + greet[0] ('h') = 104)
 * Actually we use sum + greeting_len + first_char, simplified to 15 + 5 + 'h'(=104) = 124
 */
int main(void) {
    int a[5] = {1, 2, 3, 4, 5};
    int b[5] = {[2] = 30, [4] = 50};
    struct P { int x; int y; int z; };
    struct P p = {.x = 1, .y = 2, .z = 3};
    char greet[6] = "hello";
    int sum = a[0] + a[1] + a[2] + a[3] + a[4];   /* 15 */
    int b_sum = b[2] + b[4];                       /* 80 */
    int s_field = p.x + p.y + p.z;                 /* 6 */
    int first = greet[0];                          /* 'h'=104 */
    (void)b_sum; (void)s_field;
    return sum + first;                            /* 15 + 104 = 119 */
}
