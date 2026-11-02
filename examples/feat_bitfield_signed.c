/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * Signed bitfields must sign-extend on read, share one storage unit across
 * differing base types, and support compound assignment.
 * Expected exit code: 0
 */
/* feat_bitfield_signed.c - bitfield layout / sign extension / compound assign
 * Covers three defects fixed together:
 *   - `unsigned a:3; int c:4;` used to allocate two 32-bit units (sizeof 12)
 *   - `int c:4` stored -8 but read back 8 (no sign extension)
 *   - `b.c += 3` was silently a no-op
 */
struct BF { unsigned a : 3; int c : 4; unsigned d : 1; };

int main(void) {
    struct BF b;
    int r = 0;
    int sz = (int)sizeof(struct BF);

    b.a = 5;
    b.c = -8;
    b.d = 1;

    if (sz != 4) r += 1;                /* one 32-bit storage unit */
    if (b.a != 5) r += 2;
    if (b.c != -8) r += 4;              /* sign-extended read */

    b.c += 3;                           /* -8 + 3 = -5 */
    if (b.c != -5) r += 8;
    if (b.a != 5 || b.d != 1) r += 16;  /* neighbours untouched */

    return r;
}
