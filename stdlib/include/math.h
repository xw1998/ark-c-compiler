/* Ark C Compiler stdlib - math.h
 *
 * 精简版 math.h；对应 stdlib/src/math.c 中的最小实现。
 * 仅声明少量基础函数；生产代码建议链接 newlib / CMSIS DSP。 */
#ifndef ARK_MATH_H
#define ARK_MATH_H

/* 圆周率与常用常量（C99 并未强制要求 math.h 提供 M_PI，
 * 但 ARMCC5 / glibc 的 _GNU_SOURCE 下习惯性可用，这里显式定义）。 */
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

double fabs(double x);
double sqrt(double x);
double floor(double x);
double ceil(double x);
double fmod(double x, double y);
double sin(double x);
double cos(double x);
double pow(double x, double y);

#endif
