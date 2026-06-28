/* _Complex 复数类型测试 */
int main(void) {
    _Complex double z;
    /* 验证 sizeof(_Complex double) == 16 (2 * 8) */
    return (int)sizeof(z) / 8;  /* 16/8 = 2 */
}
