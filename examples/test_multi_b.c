/* test_multi_b.c - Together with test_multi_a.c, verifies multi-file linkage
 * Expected exit code: 3
 */
extern int g_counter;
extern void inc_counter(void);

int main(void) {
    inc_counter();
    inc_counter();
    inc_counter();
    return g_counter;
}
