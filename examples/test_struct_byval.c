/* test_struct_byval.c — 结构体按值传递/返回
 * 期望退出码：10
 */
struct P { int x, y; };

struct P add(struct P a, struct P b) {
    struct P r;
    r.x = a.x + b.x;
    r.y = a.y + b.y;
    return r;
}

int main(void) {
    struct P a = {1, 2};
    struct P b = {3, 4};
    struct P c = add(a, b);
    return c.x + c.y;   /* (1+3) + (2+4) = 10 */
}
