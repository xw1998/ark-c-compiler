/* test_int_types.c - armcc fixed-width integer type test
 * Expected exit code: 10
 */
int main(void) {
    __int8 a = 1;
    __int16 b = 2;
    __int32 c = 3;
    __int64 d = 4;
    return (int)(a + b + c + (int)d);  /* 10 */
}
