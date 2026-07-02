/* test_multi_a.c - Multi-.c linkage (C backend) support verification, file 1
 * Expected to return 3 after linking with test_multi_b.c.
 */
int g_counter = 0;
void inc_counter(void) { g_counter++; }
