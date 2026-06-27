/* feat_div.c — 整数除法、取模、大立即数
 * 期望：100 / 7 = 14；100 % 7 = 2；14 + 2 + 84 = 100
 */
int main(void) {
    int a = 100;
    int b = 7;
    int q = a / b;       /* 14 */
    int r = a % b;       /* 2  */
    int big = 0x12345;   /* 74565 */
    int low = big & 0xFF; /* 0x45 = 69 */
    return q + r + low + 15;  /* 14 + 2 + 69 + 15 = 100 */
}
