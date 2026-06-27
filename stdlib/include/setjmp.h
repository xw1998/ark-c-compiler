/* Ark C Compiler stdlib - setjmp.h
 * 非局部跳转接口。
 *
 * 说明：
 *   - 编译器把 setjmp/longjmp 当作普通函数调用处理，无需特殊 IR。
 *   - ARM 上需要汇编实现以正确保存/恢复 r4-r11、sp、lr 等调用者保存
 *     相关寄存器；此头文件仅提供声明与 jmp_buf 类型。
 *   - host 测试可链接 stdlib/src/setjmp.c 的可移植简化实现。
 *   - jmp_buf 大小 20 个 int (80 字节)：足够保存 ARM 的 r4-r11、sp、lr、
 *     pc 以及 flag/sign 等附加状态。
 */
#ifndef ARK_SETJMP_H
#define ARK_SETJMP_H

typedef int jmp_buf[20];

int  setjmp(jmp_buf env);
void longjmp(jmp_buf env, int val);

#endif /* ARK_SETJMP_H */
