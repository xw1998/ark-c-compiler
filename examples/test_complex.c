/* _Complex complex type test */
int main(void) {
    _Complex double z;
    /* Verify sizeof(_Complex double) == 16 (2 * 8) */
    return (int)sizeof(z) / 8;  /* 16/8 = 2 */
}
