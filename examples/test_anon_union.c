/* test_anon_union.c - 匿名 union/struct 字段提升验证。
 * Timer 中：CR / EN(位域) / IE(位域) 在外层直接可访问；
 * 写入 EN=1, IE=1 后 CR 应为 3。
 */
typedef struct {
    union {
        unsigned int CR;
        struct {
            unsigned int EN:1;
            unsigned int IE:1;
        };
    };
} Timer;

int main(void) {
    Timer t;
    t.CR = 0;
    t.EN = 1;
    t.IE = 1;
    return (int)t.CR;  /* 3 */
}
