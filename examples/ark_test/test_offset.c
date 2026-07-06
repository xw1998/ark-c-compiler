/* Test struct member offset computation */
typedef struct {
    unsigned int ctrl;    /* offset 0 */
    unsigned int load;    /* offset 4 */
    unsigned int val;     /* offset 8 */
    unsigned int calib;   /* offset 12 */
} TestType;

#define TEST_BASE 0xE000E010u

volatile unsigned int *p_ctrl = &((TestType *)TEST_BASE)->ctrl;
volatile unsigned int *p_load = &((TestType *)TEST_BASE)->load;
volatile unsigned int *p_val  = &((TestType *)TEST_BASE)->val;
volatile unsigned int *p_calib = &((TestType *)TEST_BASE)->calib;

volatile unsigned int *p_simple;
volatile unsigned int *p_offset_4;
volatile unsigned int *p_offset_8;

void test(void) {
    p_simple = (volatile unsigned int *)TEST_BASE;
    p_offset_4 = (volatile unsigned int *)(TEST_BASE + 4);
    p_offset_8 = (volatile unsigned int *)(TEST_BASE + 8);
}
