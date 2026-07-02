/* test_cpu_macros.c - Non-underscore predefined macro test
 * Verifies that armcc-compatible __arm / __thumb macros without trailing
 * underscore exist.
 * Expected exit code: 0
 */
int main(void) {
    /* Verify the non-underscore macros exist */
#ifdef __arm
    return 0;
#else
    return 1;
#endif
}
