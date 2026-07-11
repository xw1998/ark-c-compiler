/* Minimal test: struct long long field access */
typedef struct {
    int op;
    long long val;
    int aux;
} TestStruct;

int main(void) {
    TestStruct s;
    TestStruct *p = &s;
    p->op = 1;
    p->val = 42;
    p->aux = 99;
    if (p->val != 42) return 1;
    if (p->aux != 99) return 2;
    return (int)p->val;
}
