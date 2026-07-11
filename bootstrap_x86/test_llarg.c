/* Test: long long argument passing */
typedef struct {
    int op;
    long long val;
    int aux;
} TestStruct;

static int check_val(long long v) {
    if (v == 42) return 1;
    return 0;
}

int main(void) {
    TestStruct s;
    TestStruct *p = &s;
    p->val = 42;
    if (check_val(p->val)) return 0;
    return 1;
}
