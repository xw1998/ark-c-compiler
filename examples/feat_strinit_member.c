/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * A char array member initialized from a string literal must receive the
 * characters, not the low bits of the literal's address.
 * Expected exit code: 0
 */
/* feat_strinit_member.c - string literal initializing a char array member
 * Covers three shapes fixed together:
 *   - global struct with char member initialized by "abcd"
 *   - local   struct with char member initialized by "xyz"
 *   - local   char m[2][6] = {"ab", "cd"}  (array of char arrays)
 */
struct Q { int a; char s[6]; int z; };
struct Q gq = {3, "abcd", 9};

int main(void) {
    struct Q lq = {1, "xyz", 5};
    char m[2][6] = {"ab", "cd"};
    int r = 0;

    if (gq.a != 3 || gq.z != 9) r += 1;
    if (gq.s[0] != 'a' || gq.s[3] != 'd' || gq.s[4] != 0) r += 2;

    if (lq.a != 1 || lq.z != 5) r += 4;
    if (lq.s[0] != 'x' || lq.s[2] != 'z' || lq.s[3] != 0) r += 8;

    if (m[0][0] != 'a' || m[0][1] != 'b' || m[0][2] != 0) r += 16;
    if (m[1][0] != 'c' || m[1][1] != 'd' || m[1][2] != 0) r += 32;

    return r;
}
