/* test_int_types.c — armcc 定宽整数类型测试
 * 期望退出码：10
 */
int main(void) {
    __int8 a = 1;
    __int16 b = 2;
    __int32 c = 3;
    __int64 d = 4;
    return (int)(a + b + c + (int)d);  /* 10 */
}
