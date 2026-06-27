/* test_nested_init.c — 嵌套聚合初始化
 * 期望退出码：6
 */
int matrix[2][3] = {{1, 2, 3}, {4, 5, 6}};

struct Point { int x, y; };
struct Point pts[] = {{1, 2}, {3, 4}};

int main(void) {
    int a = matrix[1][2];        /* 6 */
    int b = pts[1].y;            /* 4 */
    return a + b - 4;            /* 6 */
}
