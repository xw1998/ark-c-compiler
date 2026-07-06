typedef struct {
    unsigned int ctrl;    /* offset 0 */
    unsigned int load;    /* offset 4 */
    unsigned int val;     /* offset 8 */
    unsigned int calib;   /* offset 12 */
} TestType;

#define TEST_BASE 0xE000E010u

void test_struct_member(void) {
    volatile TestType *s = (volatile TestType *)TEST_BASE;
    s->ctrl = 1;
    s->load = 2;
    s->val = 3;
    s->calib = 4;
}

void test_direct_cast(void) {
    ((volatile TestType *)TEST_BASE)->ctrl = 1;
    ((volatile TestType *)TEST_BASE)->load = 2;
    ((volatile TestType *)TEST_BASE)->val = 3;
    ((volatile TestType *)TEST_BASE)->calib = 4;
}
