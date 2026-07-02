/* test_implicit_conv.c - C99 implicit type conversion + integer promotion
 *
 * Covers:
 *   1) unsigned char compared with int: after integer promotion compared
 *      as signed int
 *      unsigned char c = 0xff; c > 0xfe should be true (255 > 254)
 *   2) int compared with unsigned: usual arithmetic conversion to unsigned
 *      int a = -1; unsigned b = 1; a < b should be false
 *      (-1 converted to unsigned becomes 0xFFFFFFFF = 4294967295, greater than 1)
 *   3) short arithmetic-promoted to int, result can be negative
 *
 * Expected exit code: each case sets a bit; all pass = 1|2|4 = 7 */
int main(void) {
    int result = 0;

    /* Case 1: unsigned char compared with int literal; after promotion compared as int */
    {
        unsigned char c = 0xff;
        if (c > 0xfe) result |= 1;
    }

    /* Case 2: int compared with unsigned; usual arithmetic conversion to unsigned */
    {
        int a = -1;
        unsigned b = 1;
        if (!(a < b)) result |= 2;
    }

    /* Case 3: short - short promoted to int, can represent negative difference */
    {
        short s1 = 100;
        short s2 = 130;
        int diff = s1 - s2;   /* promoted to int: 100 - 130 = -30 */
        if (diff == -30) result |= 4;
    }

    return result;  /* expected 7 */
}
