/* test_packed_ptr.c - __packed pointer unaligned access semantics test
 * Verifies that when __packed qualifies a pointer, dereference uses
 * byte-by-byte access (LDRB+LSL+ORR).
 * Expected exit code: 120   (0x12345678 & 0xff = 0x78)
 */
__packed int *p;
int main(void) {
    static int data = 0x12345678;
    p = (__packed int *)&data;
    return (*p) & 0xff;  /* 0x78 */
}
