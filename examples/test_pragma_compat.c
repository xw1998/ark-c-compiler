/* test_pragma_compat.c — armcc 兼容 pragma 静默吸收
 * 验证 arkcc 不被以下 pragma 阻塞：diag_suppress / import / push / pop / O0
 * 期望退出码：0
 */
#pragma diag_suppress 1
#pragma import(__use_no_semihosting)
#pragma push
#pragma pop
#pragma O0

int main(void) { return 0; }
