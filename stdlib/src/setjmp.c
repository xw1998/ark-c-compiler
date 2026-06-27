/* Ark C Compiler - stdlib/src/setjmp.c
 * setjmp/longjmp 的可移植简化实现（仅供 host 测试参考）。
 *
 * 说明：
 *   - setjmp/longjmp 在严格意义上无法用纯 C 实现，必须借助编译器内置
 *     或汇编。本文件利用宿主 <setjmp.h> 提供的 setjmp/longjmp，把上层
 *     jmp_buf（int[20]）指针重解释为宿主 jmp_buf 后转发。
 *   - 宿主 jmp_buf 尺寸（mingw-w64/glibc）均 <= 80 字节，int[20]=80B 足够。
 *   - ARM 裸机目标需要汇编实现：保存 r4-r11、sp、lr 等到 jmp_buf，
 *     longjmp 时恢复并跳转。本文件不覆盖 ARM 场景。
 *   - 该文件不会被 Makefile 默认编译；host 测试通过 C 后端在 .gen.c 中
 *     直接展开宿主 setjmp/longjmp 调用，无需链接本文件。
 *   - 代码风格遵循 C99，可被 gcc 直接编译。
 */
#include <setjmp.h>

int setjmp(jmp_buf env) {
    /* 转发到宿主 setjmp；env 已是 jmp_buf 类型，直接调用。 */
    return setjmp(env);
}

void longjmp(jmp_buf env, int val) {
    /* val==0 在 C 标准中会被改为 1；宿主 longjmp 已做此处理。 */
    longjmp(env, val);
}
