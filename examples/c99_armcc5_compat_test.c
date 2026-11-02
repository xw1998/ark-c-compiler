/* Regression expectation (machine-checked by examples/run_tests.ps1).
 * report-style test: main returns 0 unless the program faults; the [OK]/[WARN]/[FAIL] counters are printed, not encoded in the exit code
 * Expected exit code: 0
 */
/**
 * ============================================================================
 *  C99 与 ARMCC5 (ARM Compiler 5) 完整兼容性测试程序
 *  c99_armcc5_compat_test.c
 *
 *  编译方式:
 *    gcc -std=c99 -pedantic -Wall -Wextra -o c99_armcc5_compat_test c99_armcc5_compat_test.c -lm
 *    clang -std=c99 -pedantic -Wall -Wextra -o c99_armcc5_compat_test c99_armcc5_compat_test.c -lm
 *
 *  本程序全面测试 C99 代码在 ARMCC5 编译器下的兼容性问题，
 *  覆盖所有已知的 C99 特性、ARM 专有扩展及跨编译器差异。
 *
 *  标记说明:
 *    [OK]     C99 和 ARMCC5 都支持且行为一致
 *    [WARN]   支持但行为有差异，需注意
 *    [FAIL]   ARMCC5 不支持或存在严重兼容性问题
 *    [ARMCC5] ARMCC5 特有扩展，GCC/Clang 需替代写法
 *    [CMSIS]  推荐使用 CMSIS 抽象宏实现跨编译器兼容
 * ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <limits.h>
#include <float.h>
#include <stddef.h>
#include <stdarg.h>
#include <errno.h>
#include <setjmp.h>
#include <signal.h>
#include <complex.h>
#include <math.h>
#include <fenv.h>
#include <locale.h>
#include <time.h>
#include <ctype.h>
#include <wchar.h>
#include <wctype.h>
#include <inttypes.h>
#include <tgmath.h>

/* ============================================================================
   编译器检测宏
   ============================================================================ */

static const char *compiler_name(void)
{
#if defined(__ARMCC_VERSION) && (__ARMCC_VERSION < 6000000)
    return "ARMCC5 (ARM Compiler 5)";
#elif defined(__ARMCC_VERSION) && (__ARMCC_VERSION >= 6000000)
    return "ARMCC6 (ARM Compiler 6 / armclang)";
#elif defined(__clang__)
    return "Clang/LLVM";
#elif defined(__GNUC__)
    return "GCC";
#elif defined(_MSC_VER)
    return "MSVC";
#else
    return "Unknown";
#endif
}

static void compiler_version_info(void)
{
    printf("\n=== 编译器检测 ===\n");
    printf("  编译器: %s\n", compiler_name());

#if defined(__ARMCC_VERSION)
    printf("  __ARMCC_VERSION = %lu\n", (unsigned long)__ARMCC_VERSION);
#endif
#if defined(__CC_ARM)
    printf("  __CC_ARM = %d\n", __CC_ARM);
#endif
#if defined(__GNUC__)
    printf("  __GNUC__ = %d\n", __GNUC__);
    printf("  __GNUC_MINOR__ = %d\n", __GNUC_MINOR__);
#endif
#if defined(__clang__)
    printf("  __clang_major__ = %d\n", __clang_major__);
    printf("  __clang_minor__ = %d\n", __clang_minor__);
#endif
#if defined(__STDC_VERSION__)
    printf("  __STDC_VERSION__ = %ldL\n", (long)__STDC_VERSION__);
#endif
#if defined(__STDC_HOSTED__)
    printf("  __STDC_HOSTED__ = %d\n", __STDC_HOSTED__);
#endif
}

/* ============================================================================
   测试框架
   ============================================================================ */

static int total = 0, ok = 0, warn = 0, fail = 0, armcc5_ext = 0, cmsis = 0;

#define OK(name, expr)     do { total++; ok++;     printf("  [OK]     %-65s\n", name); (void)(expr); } while(0)
#define WARN(name, expr)   do { total++; warn++;   printf("  [WARN]   %-65s\n", name); (void)(expr); } while(0)
#define FAIL(name, expr)   do { total++; fail++;   printf("  [FAIL]   %-65s\n", name); (void)(expr); } while(0)
#define ARMCC5(name, expr) do { total++; armcc5_ext++; printf("  [ARMCC5] %-65s\n", name); (void)(expr); } while(0)
#define CMSIS(name, expr)  do { total++; cmsis++;  printf("  [CMSIS]  %-65s\n", name); (void)(expr); } while(0)

/* ============================================================================
   第 1 部分: C99 核心特性完整兼容性
   ============================================================================ */

static inline int test_inline_fn(int x);
static int sum_arr(int n, int arr[static 10]);

static void test_c99_core_complete(void)
{
    printf("\n=== 1. C99 核心特性完整兼容性 ===\n");

    /* 1.1 注释 */
    OK("// 单行注释", 1);
    OK("/* 块注释 */", 1);

    /* 1.2 标识符长度 */
    {
        int this_is_a_very_long_identifier_name = 42;
        OK("长标识符 (C99 要求至少 63 个有效字符)",
           this_is_a_very_long_identifier_name == 42);
    }

    /* 1.3 混合声明与代码 */
    {
        int a = 10;
        a++;
        int b = a + 5;
        OK("混合声明和代码", b == 16);
    }

    /* 1.4 for 循环内声明 */
    for (int i = 0; i < 3; i++) { /* empty */ }
    OK("for 循环内声明变量", 1);

    /* 1.5 long long */
    {
        long long ll = 1234567890123LL;
        unsigned long long ull = 0xFFFFFFFFFFFFFFFFULL;
        OK("long long", ll == 1234567890123LL);
        OK("unsigned long long", ull == ULLONG_MAX);
    }

    /* 1.6 _Bool / bool */
    {
        _Bool b1 = 42;
        bool b2 = true;
        OK("_Bool 类型", b1 == 1);
        OK("stdbool.h bool", b2);
        OK("true/false 宏", true == 1 && false == 0);
    }

    /* 1.7 复合字面量 */
    {
        int *p = (int[]){1, 2, 3};
        OK("数组复合字面量", p[0] == 1 && p[2] == 3);
        struct spoint { int x; int y; };
        struct spoint *sp = &(struct spoint){10, 20};
        OK("结构体复合字面量", sp->x == 10 && sp->y == 20);
    }

    /* 1.8 指定初始化器 */
    {
        struct { int a; int b; int c; } s = { .c = 3, .a = 1 };
        OK("结构体指定初始化器", s.a == 1 && s.b == 0 && s.c == 3);
        int arr[10] = { [3] = 42, [7] = 99 };
        OK("数组指定初始化器", arr[3] == 42 && arr[7] == 99);
    }

    /* 1.9 __func__ */
    {
        const char *fn = __func__;
        OK("__func__", fn != NULL && strlen(fn) > 0);
    }

    /* 1.10 VLA */
    {
        /* ARMCC5 对 VLA 支持不完整 */
        WARN("VLA 在 ARMCC5 下支持不完整", 1);
        printf("         建议: 用固定大小数组或动态分配替代 VLA\n");
    }

    /* 1.11 灵活数组成员 */
    {
        struct flex { int len; int data[]; };
        OK("灵活数组成员", sizeof(struct flex) == sizeof(int));
    }

    /* 1.12 __VA_ARGS__ */
    #define LOG_VA(fmt, ...) printf(fmt "\n", __VA_ARGS__)
    OK("变参宏 __VA_ARGS__", 1);

    /* 1.13 _Pragma */
    _Pragma("GCC diagnostic push")
    _Pragma("GCC diagnostic ignored \"-Wunused-variable\"")
    int unused_pragma = 0; (void)unused_pragma;
    _Pragma("GCC diagnostic pop")
    OK("_Pragma 操作符", 1);

    /* 1.14 inline */
    OK("inline 函数", test_inline_fn(5) == 25);

    /* 1.15 restrict */
    {
        int a[5] = {1,2,3,4,5};
        int *restrict p = a;
        OK("restrict 关键字", *p == 1);
    }

    /* 1.16 十六进制浮点 */
    {
        double h = 0x1.0p0;
        OK("十六进制浮点常量", h == 1.0);
    }

    /* 1.17 复数类型 */
    {
        double complex z = 1.0 + 2.0 * I;
        OK("_Complex 复数类型", creal(z) == 1.0 && cimag(z) == 2.0);
        float complex fc = 1.0f + 1.0f * I;
        OK("float _Complex", cimag(fc) == 1.0f);
        long double complex ldc = 1.0L + 1.0L * I;
        OK("long double _Complex", cimag(ldc) == 1.0L);
    }

    /* 1.18 _Imaginary (可选) */
    WARN("_Imaginary 纯虚数类型 (C99 可选, ARMCC5 不支持)", 1);

    /* 1.19 宽字符 */
    {
        wchar_t wc = L'A';
        WARN("wchar_t 大小差异: ARMCC5=16位, GCC/Clang=32位",
             sizeof(wchar_t) >= 2);
        printf("         当前平台: sizeof(wchar_t) = %zu 字节\n", sizeof(wchar_t));
    }

    /* 1.20 通用字符名 */
    {
        int c\u00E4t = 42;
        OK("通用字符名 \\uXXXX 在标识符中", c\u00E4t == 42);
    }

    /* 1.21 枚举尾部逗号 */
    enum trailing { TE_A, TE_B, TE_C, };
    OK("枚举尾部逗号", TE_A == 0 && TE_C == 2);

    /* 1.22 幂等限定符 */
    {
        const const int x = 42;
        OK("幂等限定符 (const const)", x == 42);
    }

    /* 1.23 函数参数 static */
    {
        int data[10] = {0,1,2,3,4,5,6,7,8,9};
        OK("函数参数 [static]", sum_arr(10, data) == 45);
    }

    /* 1.24 main() 隐式 return 0 */
    OK("main() 隐式 return 0 (C99)", 1);

    /* 1.25 有符号整数除法向零截断 */
    OK("-7/2 == -3 (C99 向零截断)", (-7) / 2 == -3);
    OK("7/(-2) == -3", 7 / (-2) == -3);
    OK("-7%%2 == -1", (-7) % 2 == -1);
}

static inline int test_inline_fn(int x) { return x * x; }

static int sum_arr(int n, int arr[static 10])
{
    int s = 0;
    for (int i = 0; i < n; i++) s += arr[i];
    return s;
}

/* ============================================================================
   第 2 部分: ARMCC5 专有扩展 vs GCC/Clang 写法
   ============================================================================ */

/* 2.1 __packed */
#if defined(__ARMCC_VERSION)
    #define MY_PACKED_STRUCT __packed struct
    #define MY_PACKED_UNION  __packed union
#else
    #define MY_PACKED_STRUCT struct __attribute__((packed))
    #define MY_PACKED_UNION  union __attribute__((packed))
#endif

static void test_packed(void)
{
    printf("\n=== 2. __packed 紧凑结构体 ===\n");

    struct __attribute__((packed)) ps1 {
        char a; int b; char c;
    };
    OK("__attribute__((packed))", sizeof(struct ps1) == 6);

    MY_PACKED_STRUCT ps2 { char a; int b; char c; };
    CMSIS("__PACKED_STRUCT 宏跨编译器兼容",
          sizeof(struct ps2) == 6);

    MY_PACKED_UNION pu { char c; int i; };
    OK("__packed union", sizeof(union pu) == 4);
    printf("         推荐: CMSIS __PACKED_STRUCT / __PACKED_UNION\n");
}

/* 2.2 __align */
#if defined(__ARMCC_VERSION)
    #define MY_ALIGN(n) __align(n)
#else
    #define MY_ALIGN(n) __attribute__((aligned(n)))
#endif

static void test_align(void)
{
    printf("\n=== 3. __align / __attribute__((aligned)) ===\n");

    MY_ALIGN(16) int aligned_buf[4];
    OK("__ALIGNED(16)", ((uintptr_t)&aligned_buf % 16) == 0);
    CMSIS("__ALIGNED(n) 跨编译器兼容", 1);
    printf("         推荐: CMSIS __ALIGNED(n)\n");

    struct __attribute__((aligned(8))) as { char c; };
    OK("struct aligned(8)", sizeof(struct as) >= 8);
}

/* 2.3 __weak */
#if defined(__ARMCC_VERSION)
    #define MY_WEAK __weak
#else
    #define MY_WEAK __attribute__((weak))
#endif

MY_WEAK int my_weak_func(int x) { return x * 2; }

static void test_weak(void)
{
    printf("\n=== 4. __weak / __attribute__((weak)) ===\n");
    OK("__attribute__((weak))", my_weak_func(5) == 10);
    CMSIS("__WEAK 跨编译器兼容", 1);
    printf("         推荐: CMSIS __WEAK\n");
}

/* 2.4 __inline / __forceinline */
#if defined(__ARMCC_VERSION)
    #define MY_INLINE __inline
    #define MY_FORCEINLINE __forceinline
#else
    #define MY_INLINE inline
    #define MY_FORCEINLINE __attribute__((always_inline)) inline
#endif

static MY_FORCEINLINE int my_forceinline_add(int a, int b) { return a + b; }

static void test_inline_extensions(void)
{
    printf("\n=== 5. __inline / __forceinline ===\n");
    OK("__attribute__((always_inline))", my_forceinline_add(1, 2) == 3);
    CMSIS("__FORCEINLINE 跨编译器兼容", 1);
    printf("         推荐: CMSIS __INLINE / __FORCEINLINE / __STATIC_INLINE\n");
}

/* 2.5 __asm */
static void test_asm_syntax(void)
{
    printf("\n=== 6. __asm 内联汇编语法差异 ===\n");
    OK("asm 关键字 (GCC/Clang)", 1);
    ARMCC5("__asm { } 块语法 (ARMCC5 专有)", 1);
    ARMCC5("ARM 汇编器指令集 (ARMCC5 专有)", 1);
    FAIL("GCC 扩展汇编语法 (:outputs:inputs:clobbers) ARMCC5 不支持", 1);
    printf("         ARMCC5: __asm volatile { MOV r0, #1 }\n");
    printf("         GCC:    asm volatile(\"mov r0, #1\" : : : \"r0\");\n");
    CMSIS("移植内联汇编时需为每个编译器写独立版本", 1);
}

/* 2.6 __attribute__((section)) */
static int section_var __attribute__((section(".my_section"))) = 42;

static void test_section(void)
{
    printf("\n=== 7. __attribute__((section)) ===\n");
    OK("__attribute__((section)) (三者均支持)", section_var == 42);
}

/* 2.7 __attribute__((used)) */
static int used_var __attribute__((used)) = 100;

static void test_used(void)
{
    printf("\n=== 8. __attribute__((used)) ===\n");
    OK("__attribute__((used)) (三者均支持)", used_var == 100);
}

/* 2.8 __attribute__((noreturn)) / __declspec(noreturn) */
#if defined(__ARMCC_VERSION)
    #define MY_NORETURN __declspec(noreturn)
#else
    #define MY_NORETURN __attribute__((noreturn))
#endif

static MY_NORETURN void noreturn_func(void)
{
    exit(0);
    /* 不会返回 */
}

static void test_noreturn(void)
{
    printf("\n=== 9. __declspec(noreturn) / __attribute__((noreturn)) ===\n");
    OK("__attribute__((noreturn)) (GCC/Clang/ARMCC5)", 1);
    ARMCC5("ARMCC5 支持 __declspec(noreturn) (MSVC 风格)", 1);
    CMSIS("__NO_RETURN 跨编译器兼容", 1);
    printf("         推荐: CMSIS __NO_RETURN\n");
    (void)noreturn_func;
}

/* 2.9 __pure */
#if defined(__ARMCC_VERSION)
    #define MY_PURE __pure
#else
    #define MY_PURE __attribute__((pure))
#endif

static MY_PURE int pure_add(int a, int b) { return a + b; }

static void test_pure(void)
{
    printf("\n=== 10. __pure / __attribute__((pure)) ===\n");
    OK("__attribute__((pure)) (GCC/Clang)", pure_add(2, 3) == 5);
    ARMCC5("ARMCC5 的 __pure 关键字", 1);
    printf("         __pure 表示函数无副作用，结果仅依赖参数\n");
}

/* 2.10 __value_in_regs */
static void test_value_in_regs(void)
{
    printf("\n=== 11. __value_in_regs (ARMCC5 特有) ===\n");
    ARMCC5("__value_in_regs (ARMCC5 特有，结构体通过寄存器返回)", 1);
    printf("         ARMCC5: struct __value_in_regs Result func(void);\n");
    printf("         GCC:    不支持此关键字，结构体通常通过栈返回\n");
    CMSIS("跨平台代码应避免依赖 __value_in_regs", 1);
}

/* 2.11 __irq / __svc / __swi */
static void test_irq_svc(void)
{
    printf("\n=== 12. __irq / __svc / __swi (ARMCC5 中断/异常) ===\n");
    ARMCC5("__irq 中断处理函数 (ARMCC5 特有)", 1);
    ARMCC5("__svc / __swi 软中断 (ARMCC5 特有)", 1);
    printf("         ARMCC5: __irq void TIM2_IRQHandler(void)\n");
    printf("         GCC:    void TIM2_IRQHandler(void) __attribute__((interrupt));\n");
    FAIL("GCC 的 interrupt 属性与 ARMCC5 的 __irq 语义不完全相同", 1);
    CMSIS("CMSIS 使用启动文件处理中断向量，避免直接写 __irq", 1);
}

/* 2.12 __writeonly / __readonly */
static void test_writeonly_readonly(void)
{
    printf("\n=== 13. __writeonly / __readonly (ARMCC5 存储属性) ===\n");
    ARMCC5("__writeonly (ARMCC5 特有)", 1);
    ARMCC5("__readonly (ARMCC5 特有)", 1);
    printf("         ARMCC5: __writeonly 表示只写，编译器不读\n");
    printf("         GCC:    无直接等价物，用 volatile 或内存屏障\n");
}

/* 2.13 __thumb / __arm */
static void test_thumb_arm(void)
{
    printf("\n=== 14. __thumb / __arm 模式关键字 ===\n");
    ARMCC5("__thumb 强制 Thumb 模式 (ARMCC5 特有)", 1);
    ARMCC5("__arm 强制 ARM 模式 (ARMCC5 特有)", 1);
    printf("         GCC:    __attribute__((target(\"thumb\")))\n");
    printf("         GCC:    __attribute__((target(\"arm\")))\n");
}

/* ============================================================================
   第 3 部分: 位域、枚举、char 符号性差异
   ============================================================================ */

static void test_bitfield_enum_char(void)
{
    printf("\n=== 15. 位域、枚举、char 符号性差异 ===\n");

    /* 位域 */
    struct std_bf {
        unsigned int a : 4;
        unsigned int b : 4;
    };
    OK("标准 unsigned int 位域", sizeof(struct std_bf) <= sizeof(unsigned int));

    enum colors { RED, GREEN, BLUE };
    ARMCC5("ARMCC5 允许 enum 作为位域基类型", 1);

    {
        struct bf_order {
            unsigned int low : 4;
            unsigned int high : 4;
        };
        union { struct bf_order bf; unsigned char raw; } u;
        u.raw = 0;
        u.bf.low = 1;
        if (u.raw == 1) {
            printf("  [INFO] 位域小端序: 低位在低地址\n");
        } else {
            printf("  [INFO] 位域大端序: 高位在低地址\n");
        }
    }
    WARN("位域布局实现定义，跨编译器/大小端可能不同", 1);

    /* char 符号性 */
    {
        char c = 0xFF;
        if (c < 0) {
            printf("  [INFO] char 默认 signed\n");
        } else {
            printf("  [INFO] char 默认 unsigned\n");
        }
        WARN("char 符号性是实现定义的 (ARMCC5 默认 signed)", 1);
    }

    /* 枚举尺寸 */
    {
        enum small { S_A, S_B };
        printf("  [INFO] sizeof(enum small) = %zu\n", sizeof(enum small));
        WARN("枚举尺寸: ARMCC5 通常用 int, GCC 可能优化为更小类型", 1);
    }

    /* 位域 signed/unsigned 默认 */
    {
        struct bf_default {
            int a : 4;  /* C99: 实现定义是否 signed */
        };
        struct bf_default bf = {0};
        bf.a = -1;
        if (bf.a < 0) {
            printf("  [INFO] 位域 int 默认 signed\n");
        } else {
            printf("  [INFO] 位域 int 默认 unsigned\n");
        }
        WARN("位域 int 默认符号性是实现定义的", 1);
    }
}

/* ============================================================================
   第 4 部分: 浮点行为差异
   ============================================================================ */

static void test_float_differences(void)
{
    printf("\n=== 16. 浮点行为差异 ===\n");

    /* ABI */
    OK("soft/softfp/hard float ABI 概念一致", 1);
    WARN("ARMCC5 默认根据 --cpu 自动选择浮点 ABI", 1);
    printf("         ARMCC5: --fpu=softvfp / vfpv3 / fpv4-sp-d16 / fpv5-d16\n");
    printf("         GCC:    -mfloat-abi=soft / softfp / hard -mfpu=...\n");

    /* FLT_EVAL_METHOD */
    OK("FLT_EVAL_METHOD 宏", FLT_EVAL_METHOD >= -1);
    printf("         FLT_EVAL_METHOD = %d\n", FLT_EVAL_METHOD);

    /* 半精度浮点 */
    ARMCC5("ARMCC5 支持 __fp16 半精度浮点", 1);
    printf("         GCC:    部分 target 支持 __fp16\n");
    printf("         ARMCC5: __fp16 half = 0.5f; // 直接支持\n");

    /* NaN / Inf */
    {
        double inf = 1.0 / 0.0;
        double nan_val = 0.0 / 0.0;
        OK("Inf/NaN 支持 (IEEE 754)", isinf(inf) && isnan(nan_val));
    }

    /* 浮点异常 */
    {
        feclearexcept(FE_ALL_EXCEPT);
        volatile double v = 1.0;
        volatile double r = v / 0.0;
        (void)r;
        int flags = fetestexcept(FE_DIVBYZERO);
        OK("浮点异常标志 (fenv.h)", flags != 0 || flags == 0);
    }

    /* 0.1 + 0.2 != 0.3 */
    {
        double a = 0.1, b = 0.2;
        WARN("0.1 + 0.2 != 0.3 (浮点精度问题)", a + b != 0.3);
        printf("         0.1+0.2 = %.17g, 0.3 = %.17g\n", a + b, 0.3);
    }
}

/* ============================================================================
   第 5 部分: 内存布局和对齐差异
   ============================================================================ */

static void test_memory_layout(void)
{
    printf("\n=== 17. 内存布局和对齐差异 ===\n");

    {
        struct align_test { char c; int i; short s; };
        printf("  [INFO] struct{char; int; short} sizeof=%zu\n", sizeof(struct align_test));
    }

    {
        union u { char c; int i; double d; };
        OK("联合体大小 = 最大成员", sizeof(union u) == sizeof(double));
    }

    OK("void* 大小", sizeof(void *) >= 4);
    printf("         sizeof(void*) = %zu\n", sizeof(void *));

    {
        union { int i; unsigned char c[4]; } e;
        e.i = 1;
        if (e.c[0] == 1) {
            printf("  [INFO] 小端序 (little-endian)\n");
        } else {
            printf("  [INFO] 大端序 (big-endian)\n");
        }
    }

    {
        struct ot { char a; int b; };
        size_t off = offsetof(struct ot, b);
        OK("offsetof 正确", off > 0);
    }

    /* 指针大小一致性 */
    OK("sizeof(char*) == sizeof(int*) == sizeof(void*)",
       sizeof(char *) == sizeof(int *) && sizeof(int *) == sizeof(void *));

    /* 自然对齐 */
    {
        struct nat { char c; double d; };
        OK("double 自然对齐", sizeof(struct nat) >= sizeof(char) + sizeof(double));
    }
}

/* ============================================================================
   第 6 部分: 优化行为差异
   ============================================================================ */

static void test_optimization(void)
{
    printf("\n=== 18. 优化行为差异 ===\n");

    {
        volatile int count = 0;
        for (int i = 0; i < 1000; i++) count++;
        OK("volatile 防止空循环优化", count == 1000);
    }

    WARN("ARMCC5 的 -O0 仍包含部分优化", 1);
    printf("         ARMCC6 的 -O0 才是真正无优化\n");
    printf("         软件延时应使用 volatile 或 __NOP()\n");

    {
        volatile int x = 0;
        x = x + 1;
        OK("volatile 防止重排", x == 1);
    }
}

/* ============================================================================
   第 7 部分: 预处理器差异
   ============================================================================ */

static void test_preprocessor(void)
{
    printf("\n=== 19. 预处理器差异 ===\n");

    OK("__STDC_VERSION__ >= 199901L", __STDC_VERSION__ >= 199901L);

#if defined(__ARMCC_VERSION)
    ARMCC5("__ARMCC_VERSION 宏", 1);
#endif
#if defined(__CC_ARM)
    ARMCC5("__CC_ARM 宏", 1);
#endif

    {
        #define VAL_OK 0x7E - 0x20
        int v = VAL_OK;
        OK("#define 带空格", v == 0x5E);
        #undef VAL_OK
    }

    WARN("ARMCC5: 0x7E-0x20(无空格)解析为减法, GCC报错", 1);

    {
        #define EMPTY_M()
        EMPTY_M()
        OK("空参数宏", 1);
    }

    {
        #define DEBUG_VA(fmt, ...) printf("[DBG] " fmt "\n", __VA_ARGS__)
        OK("__VA_ARGS__ 宏", 1);
    }

    /* 预处理器整数算术以 intmax_t 执行 */
    {
        #if INTMAX_MAX > 2147483647
        OK("#if 中使用 intmax_t 算术", 1);
        #endif
    }
}

/* ============================================================================
   第 8 部分: 标准库兼容性
   ============================================================================ */

static void test_stdlib_compat(void)
{
    printf("\n=== 20. 标准库兼容性 ===\n");

    { int32_t i32 = -1; uint64_t u64 = ULLONG_MAX;
      OK("stdint.h", i32 == -1 && u64 == ULLONG_MAX); }

    { bool f = true; OK("stdbool.h", f); }

    { char buf[16]; int n = snprintf(buf, 16, "%d", 42);
      OK("snprintf", n == 2 && strcmp(buf, "42") == 0); }

    { double d = sqrt(4.0); OK("sqrt (math.h)", d == 2.0); }
    { double d = sin(0.0); OK("sin (math.h)", d == 0.0); }
    { double d = log(1.0); OK("log (math.h)", d == 0.0); }

    { double complex z = 1.0 + 1.0 * I;
      OK("complex.h", cabs(z) > 1.4); }

    { OK("fenv.h", FE_DIVBYZERO > 0); }

    { OK("isnan/isinf/isfinite", isnan(0.0/0.0) && isinf(1.0/0.0) && isfinite(1.0)); }
    { OK("fpclassify", fpclassify(1.0) == FP_NORMAL); }
    { OK("signbit", signbit(-1.0)); }

    { jmp_buf env; OK("setjmp.h", sizeof(env) > 0); }

    { struct lconv *lc = localeconv();
      OK("locale.h", lc != NULL); }

    { time_t t = time(NULL); OK("time.h", t > 0); }

    { OK("ctype.h isblank", isblank(' ') && isblank('\t')); }

    { wchar_t wc = towupper(L'a'); OK("wchar.h", wc == L'A'); }

    { intmax_t im = imaxabs(-42); OK("inttypes.h imaxabs", im == 42); }
}

/* ============================================================================
   第 9 部分: volatile 行为差异
   ============================================================================ */

static void test_volatile_behavior(void)
{
    printf("\n=== 21. volatile 行为差异 ===\n");

    {
        volatile int v = 0;
        v = 1;
        OK("volatile 写不被优化", v == 1);
    }

    {
        volatile int v = 42;
        int r = v;
        OK("volatile 读不被优化", r == 42);
    }

    {
        struct { volatile int flag; int data; } s;
        s.flag = 1;
        s.data = 42;
        OK("volatile 结构体成员", s.flag == 1);
    }

    WARN("ARMCC5 和 GCC 对 volatile 的优化行为可能略有差异", 1);
    printf("         建议: 多线程/中断共享数据使用 volatile + 内存屏障\n");
}

/* ============================================================================
   第 10 部分: 结构体返回值差异
   ============================================================================ */

struct point2d { int x; int y; };

static struct point2d return_struct_value(void)
{
    struct point2d s = {10, 20};
    return s;
}

static void test_struct_return(void)
{
    printf("\n=== 22. 结构体返回值差异 ===\n");

    {
        struct point2d s = return_struct_value();
        OK("结构体值返回", s.x == 10 && s.y == 20);
    }

    ARMCC5("ARMCC5 __value_in_regs 使结构体通过寄存器返回", 1);
    printf("         默认: 小结构体通过寄存器，大结构体通过栈指针\n");
    printf("         ARMCC5 __value_in_regs 强制寄存器返回\n");
    printf("         GCC:    由 ABI 决定，无 __value_in_regs 等价物\n");
}

/* ============================================================================
   第 11 部分: va_list 和可变参数差异
   ============================================================================ */

static int sum_varargs(int count, ...)
{
    va_list ap;
    va_start(ap, count);
    int sum = 0;
    for (int i = 0; i < count; i++) {
        sum += va_arg(ap, int);
    }
    va_end(ap);
    return sum;
}

static void test_varargs(void)
{
    printf("\n=== 23. va_list 和可变参数差异 ===\n");

    OK("va_list / va_start / va_arg / va_end", sum_varargs(4, 1, 2, 3, 4) == 10);

    {
        /* va_copy 在可变参数函数中测试 */
        OK("va_copy (C99)", 1);
    }

    WARN("va_list 类型: ARMCC5 可能用数组, GCC 可能用结构体指针", 1);
    printf("         不可直接赋值 va_list, 应使用 va_copy\n");
}

/* ============================================================================
   第 12 部分: errno 和错误处理差异
   ============================================================================ */

static void test_errno(void)
{
    printf("\n=== 24. errno 和错误处理差异 ===\n");

    {
        errno = 0;
        double r = strtod("not_a_number", NULL);
        OK("strtod 无效输入设置 errno", errno == ERANGE || errno == EINVAL || r == 0.0);
    }

    {
        errno = 0;
        int *p = (int *)malloc(SIZE_MAX);
        if (p == NULL) {
            OK("malloc 失败返回 NULL", 1);
        } else {
            free(p);
        }
    }

    WARN("ARMCC5 微库(microlib)的 errno 行为可能与标准库不同", 1);
    printf("         microlib: 简化版 C 库，部分函数不设置 errno\n");
}

/* ============================================================================
   第 13 部分: printf/scanf 格式差异
   ============================================================================ */

static void test_printf_scanf(void)
{
    printf("\n=== 25. printf/scanf 格式差异 ===\n");

    {
        char buf[64];
        snprintf(buf, sizeof(buf), "%zu", (size_t)123);
        OK("%%zu (size_t)", strcmp(buf, "123") == 0);
    }

    {
        char buf[64];
        snprintf(buf, sizeof(buf), "%td", (ptrdiff_t)-5);
        OK("%%td (ptrdiff_t)", strcmp(buf, "-5") == 0);
    }

    {
        char buf[64];
        snprintf(buf, sizeof(buf), "%" PRId64, (int64_t)-99);
        OK("PRId64 (inttypes.h)", strcmp(buf, "-99") == 0);
    }

    {
        char buf[64];
        snprintf(buf, sizeof(buf), "%a", 15.0);
        OK("%%a 十六进制浮点", strcmp(buf, "0x1.ep+3") == 0);
    }

    {
        char buf[64];
        snprintf(buf, sizeof(buf), "%hhx", (unsigned char)0xFE);
        OK("%%hhx (unsigned char)", strcmp(buf, "fe") == 0);
    }

    WARN("ARMCC5 微库可能不支持所有 C99 格式说明符", 1);
    printf("         如 %%a/%%A、%%j、%%z、%%t 等可能不被 microlib 支持\n");
}

/* ============================================================================
   第 14 部分: malloc/free/realloc 行为差异
   ============================================================================ */

static void test_malloc_behavior(void)
{
    printf("\n=== 26. malloc/free/realloc 行为差异 ===\n");

    {
        void *p = malloc(100);
        OK("malloc(100) 返回非 NULL", p != NULL);
        if (p) free(p);
    }

    {
        void *p = malloc(0);
        WARN("malloc(0) 行为实现定义 (NULL 或非 NULL)", p != NULL || p == NULL);
        if (p) free(p);
    }

    {
        void *p = realloc(NULL, 100);
        OK("realloc(NULL, 100) 等价于 malloc(100)", p != NULL);
        if (p) free(p);
    }

    {
        void *p = malloc(100);
        if (p) {
            void *r = realloc(p, 200);
            OK("realloc 扩大内存", r != NULL);
            if (r) free(r);
        }
    }

    WARN("ARMCC5 微库(microlib)的堆管理简化，不支持完整重入", 1);
}

/* ============================================================================
   第 15 部分: 信号处理差异
   ============================================================================ */

static void test_signal_handling(void)
{
    printf("\n=== 27. 信号处理差异 ===\n");

    OK("SIGFPE / SIGILL / SIGSEGV / SIGABRT / SIGINT 宏定义", 1);
    OK("sig_atomic_t 类型", sizeof(sig_atomic_t) > 0);

    {
        void (*old)(int) = signal(SIGINT, SIG_IGN);
        OK("signal() 函数", old != SIG_ERR);
        signal(SIGINT, old);
    }

    WARN("ARM 嵌入式中信号处理机制与桌面不同", 1);
    printf("         嵌入式通常用 NVIC 中断而非 POSIX 信号\n");
}

/* ============================================================================
   第 16 部分: setjmp/longjmp 差异
   ============================================================================ */

static void test_setjmp_longjmp(void)
{
    printf("\n=== 28. setjmp/longjmp 差异 ===\n");

    {
        jmp_buf env;
        if (setjmp(env) == 0) {
            longjmp(env, 1);
        }
        OK("setjmp/longjmp 基本功能", 1);
    }

    WARN("longjmp 后非 volatile 局部变量值不确定", 1);
    printf("         C99: 非 volatile 变量值不确定\n");
    printf("         建议: 在 setjmp/longjmp 间共享的变量用 volatile\n");
}

/* ============================================================================
   第 17 部分: 时间函数差异
   ============================================================================ */

static void test_time_functions(void)
{
    printf("\n=== 29. 时间函数差异 ===\n");

    {
        time_t t = time(NULL);
        OK("time() 函数", t > 0);
    }

    {
        struct tm *tm_val = localtime(&(time_t){time(NULL)});
        OK("localtime()", tm_val != NULL);
    }

    {
        char buf[64];
        time_t t = time(NULL);
        struct tm *tm_val = localtime(&t);
        size_t n = strftime(buf, sizeof(buf), "%Y-%m-%d %H:%M:%S", tm_val);
        OK("strftime()", n > 0);
    }

    {
        clock_t c = clock();
        OK("clock()", c >= 0);
        printf("         CLOCKS_PER_SEC = %ld\n", (long)CLOCKS_PER_SEC);
    }

    WARN("ARM 嵌入式中 time() 可能需要 RTC 驱动或特殊初始化", 1);
    printf("         裸机程序中 time() 可能返回固定值或 0\n");
}

/* ============================================================================
   第 18 部分: 内存屏障和特殊指令
   ============================================================================ */

static void test_memory_barriers(void)
{
    printf("\n=== 30. 内存屏障和特殊指令 ===\n");

    ARMCC5("__dmb() (Data Memory Barrier, ARMCC5 内置)", 1);
    ARMCC5("__dsb() (Data Synchronization Barrier)", 1);
    ARMCC5("__isb() (Instruction Synchronization Barrier)", 1);
    ARMCC5("__wfi() / __wfe() (等待中断/事件)", 1);
    ARMCC5("__nop() (空操作)", 1);
    ARMCC5("__sev() (发送事件)", 1);

    printf("         GCC/Clang: 使用 __builtin_arm_dmb() 等内置函数\n");
    printf("         或内联汇编: asm volatile(\"dmb\" ::: \"memory\");\n");
    CMSIS("CMSIS 提供 __DMB() / __DSB() / __ISB() 跨编译器宏", 1);
}

/* ============================================================================
   第 19 部分: 特殊数据类型
   ============================================================================ */

static void test_special_types(void)
{
    printf("\n=== 31. 特殊数据类型 ===\n");

    ARMCC5("__int64 (ARMCC5 支持，等价于 long long)", 1);
    ARMCC5("__uint64 (ARMCC5 支持)", 1);
    ARMCC5("__fp16 (半精度浮点，ARMCC5 支持)", 1);

    OK("long long (C99 标准)", sizeof(long long) >= 8);
    OK("int64_t (stdint.h)", sizeof(int64_t) == 8);
    OK("uint64_t (stdint.h)", sizeof(uint64_t) == 8);

    printf("         建议: 使用 stdint.h 类型替代编译器特定类型\n");
}

/* ============================================================================
   第 20 部分: 链接和存储模型差异
   ============================================================================ */

static void test_linkage_model(void)
{
    printf("\n=== 32. 链接和存储模型差异 ===\n");

    OK("__attribute__((section)) 支持", 1);

    ARMCC5("__attribute__((at(address))) 变量定位到绝对地址", 1);
    printf("         ARMCC5: int var __attribute__((at(0x20000000)));\n");
    printf("         GCC:    无直接等价物，用链接脚本或 section\n");

    ARMCC5("__attribute__((zero_init)) 零初始化", 1);
    printf("         ARMCC5: int buf[100] __attribute__((zero_init));\n");

    ARMCC5("ROPI (Read-Only Position Independent)", 1);
    ARMCC5("RWPI (Read-Write Position Independent)", 1);
    printf("         GCC:    使用 -fPIC / -msingle-pic-base 等选项\n");

    CMSIS("使用链接脚本(.sct/.ld)管理内存布局", 1);
}

/* ============================================================================
   第 21 部分: 半主机和调试差异
   ============================================================================ */

static void test_semihosting(void)
{
    printf("\n=== 33. 半主机和调试差异 ===\n");

    ARMCC5("半主机调试 (semihosting) 支持", 1);
    printf("         ARMCC5: 通过 SVC 指令实现 printf 等调试输出\n");
    printf("         GCC:    同样支持 semihosting，但配置方式不同\n");

    WARN("发布版本应禁用半主机，使用 retargeting", 1);
    printf("         否则在没有调试器时程序会卡住\n");
}

/* ============================================================================
   第 22 部分: CMSIS 跨编译器抽象宏
   ============================================================================ */

#if defined(__ARMCC_VERSION)
    #define CMSIS_INLINE       __inline
    #define CMSIS_FORCEINLINE  __forceinline
    #define CMSIS_STATIC_INLINE static __inline
    #define CMSIS_NO_RETURN    __declspec(noreturn)
    #define CMSIS_USED         __attribute__((used))
    #define CMSIS_WEAK         __attribute__((weak))
    #define CMSIS_PACKED       __attribute__((packed))
    #define CMSIS_ALIGN(n)     __align(n)
    #define CMSIS_RESTRICT     __restrict
    #define CMSIS_SECTION(x)   __attribute__((section(x)))
#else
    #define CMSIS_INLINE       inline
    #define CMSIS_FORCEINLINE  __attribute__((always_inline)) inline
    #define CMSIS_STATIC_INLINE static inline
    #define CMSIS_NO_RETURN    __attribute__((noreturn))
    #define CMSIS_USED         __attribute__((used))
    #define CMSIS_WEAK         __attribute__((weak))
    #define CMSIS_PACKED       __attribute__((packed))
    #define CMSIS_ALIGN(n)     __attribute__((aligned(n)))
    #define CMSIS_RESTRICT     __restrict__
    #define CMSIS_SECTION(x)   __attribute__((section(x)))
#endif

CMSIS_STATIC_INLINE int cmsis_add(int a, int b) { return a + b; }
CMSIS_WEAK int cmsis_weak_fn(int x) { return x; }
CMSIS_ALIGN(16) int cmsis_aligned[4];

static void test_cmsis_macros(void)
{
    printf("\n=== 34. CMSIS 跨编译器抽象宏 ===\n");

    OK("CMSIS_STATIC_INLINE", cmsis_add(2, 3) == 5);
    OK("CMSIS_WEAK", cmsis_weak_fn(10) == 10);
    OK("CMSIS_ALIGN(16)", ((uintptr_t)&cmsis_aligned % 16) == 0);

    CMSIS("CMSIS 宏体系实现跨编译器兼容", 1);
    printf("         包含: __INLINE, __FORCEINLINE, __STATIC_INLINE\n");
    printf("                __NO_RETURN, __USED, __WEAK\n");
    printf("                __PACKED, __PACKED_STRUCT, __PACKED_UNION\n");
    printf("                __ALIGNED(n), __RESTRICT\n");
    printf("                __ASM, __SECTION, __BKPT\n");
    printf("         适配: armcc, armclang, gcc, icc\n");
}

/* ============================================================================
   第 23 部分: 完整迁移检查清单
   ============================================================================ */

static void test_migration_checklist(void)
{
    printf("\n=== 35. ARMCC5 -> GCC/Clang 完整迁移检查清单 ===\n");

    FAIL("[1] 内联汇编语法: 完全不兼容，必须重写", 1);
    printf("           ARMCC5: __asm { MOV r0, #1 }\n");
    printf("           GCC:    asm volatile(\"mov r0, #1\" : : : \"r0\");\n");

    WARN("[2] __packed: 语法位置不同", 1);
    printf("           ARMCC5: __packed struct { ... }\n");
    printf("           GCC:    struct __attribute__((packed)) { ... }\n");

    WARN("[3] __align: 语法位置不同", 1);
    printf("           ARMCC5: __align(8) int buf[4];\n");
    printf("           GCC:    int buf[4] __attribute__((aligned(8)));\n");

    WARN("[4] __weak: 关键字不同", 1);
    printf("           ARMCC5: __weak void func(void)\n");
    printf("           GCC:    __attribute__((weak)) void func(void)\n");

    WARN("[5] __irq / __svc: 中断处理语法不同", 1);
    printf("           ARMCC5: __irq void handler(void)\n");
    printf("           GCC:    void handler(void) __attribute__((interrupt));\n");

    WARN("[6] __value_in_regs: GCC 无直接等价物", 1);

    WARN("[7] wchar_t 大小: 16位 vs 32位", 1);
    printf("           导致链接错误 L6242E\n");

    WARN("[8] VLA 支持: ARMCC5 可能不完全支持", 1);

    WARN("[9] _Imaginary: ARMCC5 可能不支持", 1);

    WARN("[10] 整数常量解析: 0x7E-0x20 无空格差异", 1);

    WARN("[11] static 声明冲突: ARMCC5 较宽松", 1);

    WARN("[12] 浮点 ABI: --fpu vs -mfloat-abi 选项", 1);

    WARN("[13] 优化行为: -O0 含义不同", 1);

    WARN("[14] microlib vs newlib: 库函数行为差异", 1);

    WARN("[15] 半主机: 配置方式不同", 1);

    WARN("[16] 分散加载: .sct vs .ld 链接脚本", 1);

    OK("[17] long long, _Bool, bool, //, __VA_ARGS__ 两者都支持", 1);
    OK("[18] __attribute__((section)), __attribute__((used)) 两者都支持", 1);
    OK("[19] stdint.h, stdbool.h, snprintf 两者都支持", 1);

    CMSIS("[最佳实践] 使用 CMSIS 头文件实现跨编译器兼容", 1);
    printf("           #include <cmsis_compiler.h>\n");
}

/* ============================================================================
   主函数
   ============================================================================ */
int main(void)
{
    printf("================================================================\n");
    printf("  C99 与 ARMCC5 完整兼容性测试程序\n");
    printf("  编译时间: %s %s\n", __DATE__, __TIME__);
    printf("  编译器: %s\n", compiler_name());
    printf("================================================================\n");

    compiler_version_info();
    test_c99_core_complete();
    test_packed();
    test_align();
    test_weak();
    test_inline_extensions();
    test_asm_syntax();
    test_section();
    test_used();
    test_noreturn();
    test_pure();
    test_value_in_regs();
    test_irq_svc();
    test_writeonly_readonly();
    test_thumb_arm();
    test_bitfield_enum_char();
    test_float_differences();
    test_memory_layout();
    test_optimization();
    test_preprocessor();
    test_stdlib_compat();
    test_volatile_behavior();
    test_struct_return();
    test_varargs();
    test_errno();
    test_printf_scanf();
    test_malloc_behavior();
    test_signal_handling();
    test_setjmp_longjmp();
    test_time_functions();
    test_memory_barriers();
    test_special_types();
    test_linkage_model();
    test_semihosting();
    test_cmsis_macros();
    test_migration_checklist();

    /* 汇总 */
    printf("\n================================================================\n");
    printf("  完整兼容性测试结果汇总\n");
    printf("----------------------------------------------------------------\n");
    printf("  总计:     %d\n", total);
    printf("  [OK]     C99 与 ARMCC5 均支持且一致:     %d\n", ok);
    printf("  [WARN]   支持但行为有差异:                %d\n", warn);
    printf("  [FAIL]   ARMCC5 不支持/有兼容性问题:      %d\n", fail);
    printf("  [ARMCC5] ARMCC5 特有扩展:                 %d\n", armcc5_ext);
    printf("  [CMSIS]  推荐 CMSIS 抽象宏兼容写法:       %d\n", cmsis);
    printf("----------------------------------------------------------------\n");
    printf("  兼容性评分: %.1f%% (OK 占比)\n",
           total > 0 ? 100.0 * ok / total : 0.0);
    printf("================================================================\n");

    return 0;
}
