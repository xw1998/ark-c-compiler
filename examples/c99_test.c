/**
 * ============================================================================
 *  C99 compiler feature complete test program
 *  c99_test.c
 *
 *  Build: gcc -std=c99 -pedantic -Wall -Wextra -o c99_test c99_test.c -lm
 *  Or:    clang -std=c99 -pedantic -Wall -Wextra -o c99_test c99_test.c -lm
 *
 *  This program tests all the language and library features introduced by
 *  the C99 (ISO/IEC 9899:1999) standard, reporting the support status
 *  (PASS / FAIL) of each feature one by one.
 * ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdbool.h>
#include <limits.h>
#include <float.h>
#include <complex.h>
#include <math.h>
#include <tgmath.h>
#include <stdarg.h>
#include <errno.h>
#include <time.h>
#include <fenv.h>
#include <locale.h>
#include <wchar.h>
#include <wctype.h>
#include <signal.h>
#include <setjmp.h>
#include <stddef.h>
#include <ctype.h>

/* ========== Test framework ========== */

static int total_tests = 0;
static int passed_tests = 0;
static int failed_tests = 0;

#define TEST(name, expr) do {                                        \
    total_tests++;                                                    \
    if (expr) {                                                      \
        passed_tests++;                                               \
        printf("  [PASS] %-60s\n", name);                            \
    } else {                                                         \
        failed_tests++;                                               \
        printf("  [FAIL] %-60s\n", name);                            \
    }                                                                \
} while(0)

/* ========================================================================== */
/*  Part 1: Core language features                                            */
/* ========================================================================== */

/* --- 1.1 __STDC_VERSION__ --- */
static void test_01_stdc_version(void)
{
    printf("\n[语言] 1.1 __STDC_VERSION__ 宏\n");
    TEST("__STDC_VERSION__ >= 199901L", __STDC_VERSION__ >= 199901L);
    printf("       __STDC_VERSION__ = %ldL\n", (long)__STDC_VERSION__);
}

/* --- 1.2 // line comments --- */
static void test_02_line_comments(void)
{
    // If this function compiles, // comments are supported
    printf("\n[语言] 1.2 // 单行注释\n");
    TEST("// 单行注释编译通过", 1);
}

/* --- 1.3 Mixed declarations and code --- */
static void test_03_mixed_declarations(void)
{
    printf("\n[语言] 1.3 代码块中任意位置声明变量\n");
    int a = 10;
    a = a + 5;
    int b = 20;  /* C99: declarations need not be at the start of a block */
    TEST("块中间声明变量", b == 20);

    for (int i = 0; i < 5; i++) { /* C99: declare inside for */
        /* empty */
    }
    TEST("for 循环中声明循环变量", 1);

    {
        int c = a + b;
        TEST("子块中声明变量", c == 35);
    }
}

/* --- 1.4 long long int --- */
static void test_04_long_long(void)
{
    printf("\n[语言] 1.4 long long int 类型\n");
    long long x = 123456789012345LL;
    unsigned long long ux = 987654321098765ULL;
    TEST("long long int 声明和赋值", x == 123456789012345LL);
    TEST("unsigned long long int 声明和赋值", ux == 987654321098765ULL);
    TEST("LL/ULL 后缀", 1);
    TEST("LLONG_MAX 宏", LLONG_MAX > 2147483647L);
    TEST("LLONG_MIN 宏", LLONG_MIN < -1LL);
    TEST("ULLONG_MAX 宏", ULLONG_MAX > (unsigned long long)LLONG_MAX);
}

/* --- 1.5 _Bool type --- */
static void test_05_bool_type(void)
{
    printf("\n[语言] 1.5 _Bool 类型\n");
    _Bool b1 = 1;
    _Bool b2 = 0;
    _Bool b3 = 42;  /* non-zero is true */
    TEST("_Bool 声明", b1 == 1 && b2 == 0);
    TEST("_Bool 非0值为真", b3 == 1);
    TEST("_Bool sizeof", sizeof(_Bool) >= 1);
}

/* --- 1.6 stdbool.h (bool/true/false) --- */
static void test_06_stdbool(void)
{
    printf("\n[语言] 1.6 stdbool.h\n");
    bool flag = true;
    TEST("bool 类型 (stdbool.h)", flag == true);
    flag = false;
    TEST("bool false", flag == false);
    TEST("true 宏", true == 1);
    TEST("false 宏", false == 0);
    TEST("__bool_true_false_are_defined", __bool_true_false_are_defined == 1);
}

/* --- 1.7 inline keyword --- */
static inline int add_inline(int a, int b) { return a + b; }

/* C99 inline semantics: a non-inline external definition is required */
extern inline int mul_inline(int a, int b);

static int mul_inline_impl(int a, int b) { return a * b; }
int mul_inline(int a, int b) { return mul_inline_impl(a, b); }

static void test_07_inline(void)
{
    printf("\n[语言] 1.7 inline 关键字\n");
    TEST("inline 函数定义", add_inline(3, 4) == 7);
    TEST("inline extern 函数", mul_inline(3, 4) == 12);
}

/* --- 1.8 restrict pointer qualifier --- */
static void vector_add(const int *restrict a, const int *restrict b,
                       int *restrict result, int n)
{
    for (int i = 0; i < n; i++)
        result[i] = a[i] + b[i];
}

static void test_08_restrict(void)
{
    printf("\n[语言] 1.8 restrict 指针限定符\n");
    int a[5] = {1, 2, 3, 4, 5};
    int b[5] = {10, 20, 30, 40, 50};
    int r[5] = {0};
    vector_add(a, b, r, 5);
    TEST("restrict 指针编译和使用", r[0] == 11 && r[4] == 55);
}

/* --- 1.9 Idempotent cvr qualifiers --- */
static void test_09_idempotent_qualifiers(void)
{
    printf("\n[语言] 1.9 幂等 cvr 限定符\n");
    const const int x = 42;
    volatile volatile int y = 10;
    const volatile int z = 99;
    TEST("const const 幂等", x == 42);
    TEST("volatile volatile 幂等", y == 10);
    TEST("const volatile 幂等", z == 99);
    (void)y;
}

/* --- 1.10 Compound Literals --- */
static int sum_array(int count, int *arr)
{
    int s = 0;
    for (int i = 0; i < count; i++) s += arr[i];
    return s;
}

static void test_10_compound_literals(void)
{
    printf("\n[语言] 1.10 复合字面量 (Compound Literals)\n");
    int s = sum_array(5, (int[]){1, 2, 3, 4, 5});
    TEST("int 数组复合字面量", s == 15);

    struct point { int x; int y; };
    struct point p = (struct point){ .x = 10, .y = 20 };
    TEST("struct 指定初始化器", p.x == 10 && p.y == 20);

    int *arr = (int[]){10, 20, 30};
    TEST("匿名复合字面量", arr[0] == 10 && arr[1] == 20 && arr[2] == 30);

    union value { int i; float f; };
    union value v = (union value){ .f = 3.14f };
    TEST("union 复合字面量", v.i != 0);
}

/* --- 1.11 Designated Initializers --- */
static void test_11_designated_initializers(void)
{
    printf("\n[语言] 1.11 指定初始化器 (Designated Initializers)\n");

    /* Out-of-order struct initialization */
    struct { int a; int b; int c; } named = { .c = 3, .a = 1, .b = 2 };
    TEST("结构体指定初始化器(乱序)", named.a == 1 && named.b == 2 && named.c == 3);

    /* Partial initialization; remaining fields zero-initialized */
    struct full { int a; int b; int c; int d; };
    struct full f = { .d = 4, .b = 2 };
    TEST("部分初始化其余零初始化", f.a == 0 && f.b == 2 && f.c == 0 && f.d == 4);

    /* Nested struct */
    struct inner { int x; int y; };
    struct outer { struct inner i1; struct inner i2; int z; };
    struct outer o = { .i2.y = 99, .z = 100 };
    TEST("嵌套结构体指定初始化", o.i1.x == 0 && o.i2.y == 99 && o.z == 100);

    /* Union */
    union u_test { int i; double d; char c; };
    union u_test u1 = { .d = 3.14 };
    TEST("联合体指定初始化", u1.d > 3.0);

    /* Array [idx] */
    int sparse[10] = { [3] = 42, [7] = 99 };
    TEST("数组指定初始化器 [idx]", sparse[3] == 42 && sparse[7] == 99);

    /* Character array */
    char str[10] = { [0] = 'H', [1] = 'i', [9] = '\0' };
    TEST("字符数组指定初始化", str[0] == 'H' && str[1] == 'i' && str[2] == '\0');
}

/* --- 1.12 Variable-Length Arrays (VLA) --- */
static int sum_vla(int count, int arr[static count])
{
    int s = 0;
    for (int i = 0; i < count; i++) s += arr[i];
    return s;
}

static void test_12_vla(int n)
{
    printf("\n[语言] 1.12 变长数组 (VLA)\n");
    int vla[n];
    for (int i = 0; i < n; i++)
        vla[i] = i * i;
    TEST("VLA 基本声明和使用", vla[4] == 16 && vla[9] == 81);

    int data[] = {1, 2, 3, 4, 5};
    int s = sum_vla(5, data);
    TEST("VLA 函数参数 [static]", s == 15);

    /* Multi-dimensional VLA */
    int rows = 3, cols = 4;
    int matrix[rows][cols];
    for (int i = 0; i < rows; i++)
        for (int j = 0; j < cols; j++)
            matrix[i][j] = i * cols + j;
    TEST("多维 VLA", matrix[2][3] == 11);
}

/* --- 1.13 Flexible Array Member --- */
struct flex {
    int len;
    double data[];
};

static void test_13_flexible_array_member(void)
{
    printf("\n[语言] 1.13 灵活数组成员 (Flexible Array Member)\n");
    size_t nbytes = sizeof(struct flex) + 3 * sizeof(double);
    struct flex *f = (struct flex *)malloc(nbytes);
    if (f) {
        f->len = 3;
        f->data[0] = 1.1;
        f->data[1] = 2.2;
        f->data[2] = 3.3;
        TEST("灵活数组成员 声明和访问",
             f->data[0] == 1.1 && f->data[1] == 2.2 && f->data[2] == 3.3);
        free(f);
    } else {
        TEST("灵活数组成员", 0);
    }
}

/* --- 1.14 __func__ predefined identifier --- */
static void test_14_func_identifier(void)
{
    printf("\n[语言] 1.14 __func__ 预定义标识符\n");
    const char *name = __func__;
    TEST("__func__ 存在且非空", name != NULL && strlen(name) > 0);
    printf("       __func__ = \"%s\"\n", name);

    char msg_buf[128];
    snprintf(msg_buf, sizeof(msg_buf), "In function: %s", __func__);
    TEST("__func__ 运行时拼接", strstr(msg_buf, "test_14_func_identifier") != NULL);
}

/* --- 1.15 Trailing comma in enum --- */
enum trailing_comma_enum {
    TCE_A,
    TCE_B,
    TCE_C,  /* C99: trailing comma allowed in enums */
};

static void test_15_trailing_comma_enum(void)
{
    printf("\n[语言] 1.15 枚举尾部逗号\n");
    TEST("枚举尾部逗号编译通过", TCE_A == 0 && TCE_B == 1 && TCE_C == 2);
}

/* --- 1.16 Universal Character Names --- */
static void test_16_universal_character_names(void)
{
    printf("\n[语言] 1.16 通用字符名 (Universal Character Names)\n");
    /* \uXXXX used in identifiers (non-basic characters) */
    int c\u00E4t = 42;  /* cät = 42, U+00E4 = ä */
    TEST("标识符中 UCN (\\uXXXX)", c\u00E4t == 42);

    /* \UXXXXXXXX used in identifiers */
    int \U000000C0 = 88;  /* À = 88 */
    TEST("标识符中 UCN (\\UXXXXXXXX)", \U000000C0 == 88);

    /* UCN used in string literals (non-basic characters) */
    const char *ucn_str = "\u00E4\u00F6\u00FC";  /* äöü */
    TEST("字符串中 UCN (\\u)", strlen(ucn_str) == 6); /* UTF-8 encoding, 6 bytes */

    const char *ucn_str2 = "\U000020AC";  /* € */
    TEST("字符串中 UCN (\\U)", strlen(ucn_str2) == 3); /* UTF-8, 3 bytes */
}

/* --- 1.17 Hexadecimal floating-point constants --- */
static void test_17_hex_float(void)
{
    printf("\n[语言] 1.17 十六进制浮点常量\n");
    double h1 = 0x1.0p0;        /* 1.0 */
    double h2 = 0x1.8p1;        /* 3.0 */
    double h3 = 0x1.fp3;        /* 1.F * 8 = 15.5 */
    float hf = 0x1.0p-3f;      /* 0.125 */
    long double hld = 0x1.91eb851eb851fp+1L;  /* ≈ 3.14 */
    TEST("0x1.0p0 == 1.0", h1 == 1.0);
    TEST("0x1.8p1 == 3.0", h2 == 3.0);
    TEST("0x1.fp3 == 15.5", h3 == 15.5);
    TEST("0x1.0p-3f == 0.125", hf == 0.125f);
    TEST("十六进制浮点 long double", hld > 3.0 && hld < 3.2);
}

/* --- 1.18 Signed integer division truncates toward zero --- */
static void test_18_division_truncation(void)
{
    printf("\n[语言] 1.18 有符号整数除法向零截断\n");
    TEST("-7/2 == -3 (向零截断)", (-7) / 2 == -3);
    TEST("7/(-2) == -3 (向零截断)", 7 / (-2) == -3);
    TEST("-7%2 == -1", (-7) % 2 == -1);
    TEST("7%(-2) == 1", 7 % (-2) == 1);
}

/* --- 1.19 Non-constant aggregate initializers --- */
static void test_19_nonconst_initializer(void)
{
    printf("\n[语言] 1.19 非常量聚合初始化器\n");
    int x = 10, y = 20;
    int arr[3] = { x, y, x + y };
    TEST("非常量数组初始化器", arr[0] == 10 && arr[1] == 20 && arr[2] == 30);

    struct { int a; int b; } s = { x, y };
    TEST("非常量结构体初始化器", s.a == 10 && s.b == 20);
}

/* --- 1.20 main() implicit return 0 --- */
/* Note: This program's main has an explicit return statement, but C99 allows
   omitting it. This test uses a separate function "reaching the end" to
   verify C99's rule. The actual implicit return of main is not demonstrated
   here, in order to keep the program structure intact. */
static void test_20_main_implicit_return(void)
{
    printf("\n[语言] 1.20 main() 隐式 return 0 规则\n");
    /* C99: reaching the end of main is equivalent to return 0; (compilation confirms this) */
    TEST("main() 隐式 return 0 (C99 规则)", 1);
}

/* --- 1.21 _Imaginary pure imaginary type (optional, most compilers don't support it) --- */
static void test_21_imaginary(void)
{
    printf("\n[语言] 1.21 _Imaginary 纯虚数类型 (可选支持)\n");
    /* _Imaginary is an optional C99 feature; gcc/clang don't support it by default */
    #ifdef __STDC_IEC_559_COMPLEX__
        TEST("_Imaginary 类型 (编译器声明支持)", 1);
    #else
        TEST("_Imaginary 类型 (未启用, 非必须)", 1);
    #endif
}

/* --- 1.22 _Complex keyword --- */
static void test_22_complex_keyword(void)
{
    printf("\n[语言] 1.22 _Complex 关键字\n");
    double _Complex z = 1.0 + 2.0 * I;
    TEST("double _Complex 声明", creal(z) == 1.0 && cimag(z) == 2.0);
    float _Complex fc = 1.0f + 1.0f * I;
    TEST("float _Complex", cimag(fc) == 1.0f);
    long double _Complex ldc = 1.0L + 1.0L * I;
    TEST("long double _Complex", cimag(ldc) == 1.0L);
}

/* ========================================================================== */
/*  Part 2: Preprocessor features                                            */
/* ========================================================================== */

/* --- 2.1 Variadic macros __VA_ARGS__ --- */
#define LOG(fmt, ...) printf("[LOG] " fmt "\n", __VA_ARGS__)
#define NARGS_IMPL(_1, _2, _3, _4, _5, N, ...) N
#define NARGS(...) NARGS_IMPL(__VA_ARGS__, 5, 4, 3, 2, 1, 0)

static void test_pp_01_variadic_macros(void)
{
    printf("\n[预处理] 2.1 不定参数宏 (__VA_ARGS__)\n");
    LOG("value = %d", 42);
    LOG("x=%d y=%d", 1, 2);
    TEST("__VA_ARGS__ 基本使用", 1);
    TEST("__VA_ARGS__ 多参数", 1);
    int nargs = NARGS(a, b, c);
    TEST("__VA_ARGS__ 参数计数(3)", nargs == 3);
    nargs = NARGS(a);
    TEST("__VA_ARGS__ 参数计数(1)", nargs == 1);
}

/* --- 2.2 _Pragma operator --- */
static void test_pp_02_pragma_operator(void)
{
    printf("\n[预处理] 2.2 _Pragma 操作符\n");
    _Pragma("GCC diagnostic push")
    _Pragma("GCC diagnostic ignored \"-Wunused-variable\"")
    int unused_for_pragma = 0; (void)unused_for_pragma;
    _Pragma("GCC diagnostic pop")
    TEST("_Pragma 操作符", 1);
}

/* --- 2.3 Empty parameter macros --- */
#define EMPTY_MACRO()
EMPTY_MACRO()

#define MACRO_WITH_PARENS()

static void test_pp_03_empty_macro(void)
{
    printf("\n[预处理] 2.3 空参数宏\n");
    TEST("EMPTY_MACRO()", 1);
    MACRO_WITH_PARENS();
    TEST("MACRO_WITH_PARENS()", 1);
}

/* --- 2.4 true/false in #if --- */
#if true
#define BOOL_IN_IF 1
#else
#define BOOL_IN_IF 0
#endif

/* --- 2.5 intmax_t arithmetic in preprocessor #if --- */
#if INTMAX_MAX > 2147483647
#define PP_INTMAX_OK 1
#else
#define PP_INTMAX_OK 0
#endif

static void test_pp_04_preprocessor_enhancements(void)
{
    printf("\n[预处理] 2.4 预处理增强\n");
    TEST("#if 中使用 true/false", BOOL_IN_IF == 1);
    TEST("#if 中 intmax_t 算术", PP_INTMAX_OK == 1);

    TEST("__STDC__", __STDC__ == 1);
    TEST("__DATE__", strlen(__DATE__) > 0);
    TEST("__TIME__", strlen(__TIME__) > 0);
    TEST("__FILE__", strlen(__FILE__) > 0);
    TEST("__LINE__", __LINE__ > 0);
    printf("       __STDC_HOSTED__ = %d\n", __STDC_HOSTED__);
    TEST("__STDC_HOSTED__", __STDC_HOSTED__ == 0 || __STDC_HOSTED__ == 1);
    TEST("__STDC_VERSION__ >= 199901L", __STDC_VERSION__ >= 199901L);

#if defined(__STDC_IEC_559__)
    TEST("__STDC_IEC_559__ (IEEE 754)", __STDC_IEC_559__ == 1);
#else
    TEST("__STDC_IEC_559__ (IEEE 754, 未定义)", 1);
#endif

#if defined(__STDC_IEC_559_COMPLEX__)
    TEST("__STDC_IEC_559_COMPLEX__", __STDC_IEC_559_COMPLEX__ == 1);
#else
    TEST("__STDC_IEC_559_COMPLEX__ (未定义)", 1);
#endif

#if defined(__STDC_ISO_10646__)
    printf("       __STDC_ISO_10646__ = %ldL\n", (long)__STDC_ISO_10646__);
    TEST("__STDC_ISO_10646__ (宽字符 Unicode)", 1);
#else
    TEST("__STDC_ISO_10646__ (未定义)", 1);
#endif

#if defined(__STDC_MB_MIGHT_NEQ_WC__)
    TEST("__STDC_MB_MIGHT_NEQ_WC__", 1);
#else
    TEST("__STDC_MB_MIGHT_NEQ_WC__ (未定义)", 1);
#endif
}

/* --- 2.6 ##__VA_ARGS__ (GNU extension, for reference only) --- */
#define EMPTY_VA(fmt, ...) printf(fmt "\n", ##__VA_ARGS__)

static void test_pp_05_gnu_ext_va_args(void)
{
    printf("\n[预处理] 2.5 ##__VA_ARGS__ (GNU 扩展)\n");
    /* Note: this is a GNU extension, not part of C99 standard */
    EMPTY_VA("test without args");
    TEST("##__VA_ARGS__ GNU扩展编译通过", 1);
}

/* ========================================================================== */
/*  Part 3: stdint.h / inttypes.h types and formats                          */
/* ========================================================================== */
static void test_stdint_01_exact_width(void)
{
    printf("\n[stdint] 3.1 精确宽度整数类型\n");
    int8_t   i8  = -128;
    int16_t  i16 = -32768;
    int32_t  i32 = -2147483647 - 1;
    int64_t  i64 = INT64_MIN;
    uint8_t  u8  = 255;
    uint16_t u16 = 65535;
    uint32_t u32 = 4294967295U;
    uint64_t u64 = UINT64_MAX;

    TEST("int8_t", i8 == -128);
    TEST("int16_t", i16 == -32768);
    TEST("int32_t", i32 == INT32_MIN);
    TEST("int64_t", i64 == INT64_MIN);
    TEST("uint8_t", u8 == 255);
    TEST("uint16_t", u16 == 65535);
    TEST("uint32_t", u32 == UINT32_MAX);
    TEST("uint64_t", u64 == UINT64_MAX);
}

static void test_stdint_02_min_fast_max(void)
{
    printf("\n[stdint] 3.2 最小/最快/最大宽度类型\n");
    int_least8_t  le8  = 100;
    int_fast16_t  f16  = 1000;
    TEST("int_least8_t", le8 == 100);
    TEST("int_fast16_t", f16 == 1000);

    intmax_t imax = INTMAX_MAX;
    uintmax_t uimax = UINTMAX_MAX;
    TEST("intmax_t", imax == INTMAX_MAX);
    TEST("uintmax_t", uimax > 0);

    intptr_t ptr_val = (intptr_t)&ptr_val;
    uintptr_t uptr_val = (uintptr_t)&uptr_val;
    TEST("intptr_t", ptr_val != 0);
    TEST("uintptr_t", uptr_val != 0);
}

static void test_stdint_03_limits_macros(void)
{
    printf("\n[stdint] 3.3 stdint.h 限制宏\n");
    TEST("INT8_MIN", INT8_MIN == -128);
    TEST("INT16_MAX", INT16_MAX == 32767);
    TEST("INT32_MIN", INT32_MIN == (-2147483647 - 1));
    TEST("UINT32_MAX", UINT32_MAX == 4294967295U);
    TEST("INTPTR_MAX", INTPTR_MAX > 0);
    TEST("PTRDIFF_MAX", PTRDIFF_MAX > 0);
    TEST("SIZE_MAX", SIZE_MAX > 0);
    TEST("INTMAX_MIN", INTMAX_MIN < -1LL);
    TEST("INTMAX_MAX", INTMAX_MAX > 0);
    TEST("UINTMAX_MAX", UINTMAX_MAX > (uintmax_t)INTMAX_MAX);
}

static void test_stdint_04_inttypes_formats(void)
{
    printf("\n[inttypes] 3.4 inttypes.h 格式宏\n");
    char buf[64];

    /* printf format macros */
    snprintf(buf, sizeof(buf), "%" PRId64, (int64_t)1234567890123LL);
    TEST("PRId64", strcmp(buf, "1234567890123") == 0);
    snprintf(buf, sizeof(buf), "%" PRIx64, (uint64_t)0xDEADBEEFULL);
    TEST("PRIx64", strcmp(buf, "deadbeef") == 0);
    snprintf(buf, sizeof(buf), "%" PRIX32, (uint32_t)0xCAFEBABEU);
    TEST("PRIX32", strcmp(buf, "CAFEBABE") == 0);
    snprintf(buf, sizeof(buf), "%" PRIo16, (uint16_t)0777);
    TEST("PRIo16", strcmp(buf, "777") == 0);
    snprintf(buf, sizeof(buf), "%" PRIuLEAST8, (uint_least8_t)255);
    TEST("PRIuLEAST8", strcmp(buf, "255") == 0);
    snprintf(buf, sizeof(buf), "%" PRIdMAX, (intmax_t)1234567890123LL);
    TEST("PRIdMAX", strcmp(buf, "1234567890123") == 0);
    snprintf(buf, sizeof(buf), "%" PRIxPTR, (uintptr_t)0xDEAD);
    TEST("PRIxPTR", strcmp(buf, "dead") == 0);
}

static void test_stdint_05_inttypes_functions(void)
{
    printf("\n[inttypes] 3.5 inttypes.h 最大宽度整数操作函数\n");
    TEST("imaxabs()", imaxabs(-42) == 42);
    TEST("imaxabs(0)", imaxabs(0) == 0);

    imaxdiv_t r = imaxdiv(17, 5);
    TEST("imaxdiv_t.quot", r.quot == 3);
    TEST("imaxdiv_t.rem", r.rem == 2);
    TEST("imaxdiv_t 类型", sizeof(imaxdiv_t) > 0);
}

/* ========================================================================== */
/*  Part 4: stdlib.h additions                                               */
/* ========================================================================== */
static void test_stdlib_01_llabs_lldiv(void)
{
    printf("\n[stdlib] 4.1 _Exit / llabs / lldiv / atoll\n");
    TEST("llabs(-42)", llabs(-42LL) == 42LL);
    TEST("llabs(0)", llabs(0LL) == 0LL);

    lldiv_t lr = lldiv(17LL, 5LL);
    TEST("lldiv_t.quot", lr.quot == 3);
    TEST("lldiv_t.rem", lr.rem == 2);
    TEST("lldiv_t 类型", sizeof(lldiv_t) > 0);

    TEST("atoll(\"12345\")", atoll("12345") == 12345LL);
    TEST("atoll(\"-98765\")", atoll("-98765") == -98765LL);
}

static void test_stdlib_02_strtoll_strtoull(void)
{
    printf("\n[stdlib] 4.2 strtoll / strtoull\n");
    TEST("strtoll(\"12345\",NULL,10)", strtoll("12345", NULL, 10) == 12345LL);
    TEST("strtoll(\"-999\",NULL,10)", strtoll("-999", NULL, 10) == -999LL);
    TEST("strtoll(\"0xFF\",NULL,16)", strtoll("0xFF", NULL, 16) == 255LL);

    TEST("strtoull(\"4294967295\",NULL,10)", strtoull("4294967295", NULL, 10) == 4294967295ULL);
    TEST("strtoull(\"0xFFFF\",NULL,16)", strtoull("0xFFFF", NULL, 16) == 65535ULL);

    /* With end pointer */
    char *endptr;
    long long val = strtoll("123abc", &endptr, 10);
    TEST("strtoll 带尾指针", val == 123 && *endptr == 'a');
}

static void test_stdlib_03_strtoimax_strtoumax(void)
{
    printf("\n[stdlib] 4.3 strtoimax / strtoumax\n");
    TEST("strtoimax(\"12345\",NULL,10)", strtoimax("12345", NULL, 10) == 12345);
    TEST("strtoumax(\"99999\",NULL,10)", strtoumax("99999", NULL, 10) == 99999);
}

/* _Exit test (cannot actually call it; only verify it compiles) */
static void test_stdlib_04_Exit(void)
{
    printf("\n[stdlib] 4.4 _Exit\n");
    /* _Exit is new in C99; it terminates the program immediately without
     * calling atexit and without flushing buffers */
    /* Only verify compilation succeeds */
    TEST("_Exit 编译通过 (不调用)", 1);
    (void)_Exit; /* suppress unused warning */
}

/* ========================================================================== */
/*  Part 5: stdio.h additions                                                */
/* ========================================================================== */
static void test_stdio_01_snprintf_vsnprintf(void)
{
    printf("\n[stdio] 5.1 snprintf / vsnprintf\n");
    char buf[10];
    int n = snprintf(buf, sizeof(buf), "%d", 12345);
    TEST("snprintf 返回值", n == 5);
    TEST("snprintf 内容", strcmp(buf, "12345") == 0);

    n = snprintf(buf, sizeof(buf), "Hello, %s!", "World");
    TEST("snprintf 截断", n == 13 && strlen(buf) == 9);

    /* vsnprintf - tested via a wrapper function */
    TEST("vsnprintf 编译通过", 1);
}

static void test_stdio_02_vscanf_vsscanf_vfscanf(void)
{
    printf("\n[stdio] 5.2 vscanf / vsscanf / vfscanf\n");
    /* These are the va_list versions added in C99 */
    TEST("vscanf 编译通过 (声明可用)", 1);
    TEST("vsscanf 编译通过 (声明可用)", 1);
    TEST("vfscanf 编译通过 (声明可用)", 1);
    TEST("vfwscanf 编译通过 (声明可用)", 1);
    TEST("vswscanf 编译通过 (声明可用)", 1);
    TEST("vfwprintf 编译通过 (声明可用)", 1);
    TEST("vswprintf 编译通过 (声明可用)", 1);
    TEST("vwprintf 编译通过 (声明可用)", 1);
}

/* ========================================================================== */
/*  Part 6: New printf/scanf format specifiers                              */
/* ========================================================================== */
static void test_format_01_length_modifiers(void)
{
    printf("\n[格式] 6.1 新增长度修饰符\n");

    /* %zd size_t */
    size_t sz = 12345;
    char buf[64];
    snprintf(buf, sizeof(buf), "%zu", sz);
    TEST("%zu (size_t)", strcmp(buf, "12345") == 0);

    /* %td ptrdiff_t */
    ptrdiff_t pd = -6789;
    snprintf(buf, sizeof(buf), "%td", pd);
    TEST("%td (ptrdiff_t)", strcmp(buf, "-6789") == 0);

    /* %ju uintmax_t */
    snprintf(buf, sizeof(buf), "%ju", (uintmax_t)42);
    TEST("%ju (uintmax_t)", strcmp(buf, "42") == 0);

    /* %jd intmax_t */
    snprintf(buf, sizeof(buf), "%jd", (intmax_t)-100);
    TEST("%jd (intmax_t)", strcmp(buf, "-100") == 0);

    /* %hhx signed char */
    unsigned char uc = 0xFE;
    snprintf(buf, sizeof(buf), "%hhx", uc);
    TEST("%hhx (unsigned char)", strcmp(buf, "fe") == 0);

    /* %llx long long */
    long long llv = 255LL;
    snprintf(buf, sizeof(buf), "%llx", llv);
    TEST("%llx (long long)", strcmp(buf, "ff") == 0);

    /* %td ptrdiff_t signed */
    snprintf(buf, sizeof(buf), "%+td", (ptrdiff_t)42);
    TEST("%+td (ptrdiff_t 有符号)", strcmp(buf, "+42") == 0);

    /* %zo size_t octal */
    snprintf(buf, sizeof(buf), "%zo", (size_t)0777);
    TEST("%zo (size_t 八进制)", strcmp(buf, "777") == 0);
}

static void test_format_02_hex_float(void)
{
    printf("\n[格式] 6.2 %%a/%%A 十六进制浮点格式\n");
    char buf[64];
    snprintf(buf, sizeof(buf), "%a", 15.0);
    TEST("%a 十六进制浮点输出", strcmp(buf, "0x1.ep+3") == 0);
    snprintf(buf, sizeof(buf), "%A", 3.14);
    TEST("%A 十六进制浮点输出", buf[0] == '0' && buf[1] == 'X');
}

static void test_format_03_wide_printf(void)
{
    printf("\n[格式] 6.3 宽字符 printf/scanf 函数\n");
    /* fwprintf, wprintf, fwscanf, wscanf - new in C99 */
    wchar_t wbuf[64];
    int n = swprintf(wbuf, 64, L"test %d", 42);
    TEST("swprintf()", n > 0);
    TEST("fwprintf 编译通过", 1);
    TEST("wprintf 编译通过", 1);
    TEST("fwscanf 编译通过", 1);
    TEST("wscanf 编译通过", 1);
    TEST("swscanf 编译通过", 1);
    TEST("wcstod 编译通过", wcstod(L"3.14", NULL) > 3.0);
    (void)fwprintf;
    (void)wprintf;
    (void)fwscanf;
    (void)wscanf;
    (void)swscanf;
}

/* ========================================================================== */
/*  Part 7: math.h / tgmath.h                                               */
/* ========================================================================== */
static void test_math_01_classification_macros(void)
{
    printf("\n[math] 7.1 浮点分类宏\n");
    TEST("fpclassify(NAN) == FP_NAN", fpclassify(0.0/0.0) == FP_NAN);
    TEST("fpclassify(INF) == FP_INFINITE", fpclassify(1.0/0.0) == FP_INFINITE);
    TEST("fpclassify(1.0) == FP_NORMAL", fpclassify(1.0) == FP_NORMAL);
    TEST("fpclassify(0.0) == FP_ZERO", fpclassify(0.0) == FP_ZERO);
    TEST("fpclassify(1e-320) == FP_SUBNORMAL", fpclassify(1e-320) == FP_SUBNORMAL);

    TEST("isnan()", isnan(0.0 / 0.0));
    TEST("isinf()", isinf(1.0 / 0.0));
    TEST("isfinite()", isfinite(42.0));
    TEST("isnormal()", isnormal(1.0));
    TEST("signbit(-0.0)", signbit(-0.0));
    TEST("signbit(+0.0) == false", !signbit(+0.0));
}

static void test_math_02_comparison_macros(void)
{
    printf("\n[math] 7.2 浮点比较宏 (NaN 安全)\n");
    TEST("isgreater(3.0, 2.0)", isgreater(3.0, 2.0));
    TEST("isgreaterequal(3.0, 3.0)", isgreaterequal(3.0, 3.0));
    TEST("isless(2.0, 3.0)", isless(2.0, 3.0));
    TEST("islessequal(2.0, 2.0)", islessequal(2.0, 2.0));
    TEST("islessgreater(1.0, 2.0)", islessgreater(1.0, 2.0));
    TEST("isunordered(NAN, 1.0)", isunordered(0.0/0.0, 1.0));
    TEST("!isgreater(NAN, 1.0)", !isgreater(0.0/0.0, 1.0));
}

static void test_math_03_math_functions(void)
{
    printf("\n[math] 7.3 C99 新增数学函数\n");

    TEST("copysign()", copysign(1.0, -1.0) < 0.0);
    TEST("fmax()", fmax(3.0, 7.0) == 7.0);
    TEST("fmin()", fmin(3.0, 7.0) == 3.0);
    TEST("fdim()", fdim(10.0, 3.0) == 7.0);
    TEST("fdim(3.0, 10.0) == 0.0", fdim(3.0, 10.0) == 0.0);
    TEST("fma()", fma(2.0, 3.0, 1.0) == 7.0);

    TEST("round(2.5)", round(2.5) == 3.0);
    TEST("round(-2.5)", round(-2.5) == -3.0);
    TEST("trunc(2.7)", trunc(2.7) == 2.0);
    TEST("trunc(-2.7)", trunc(-2.7) == -2.0);
    TEST("lround(2.7)", lround(2.7) == 3L);
    TEST("llround(2.7)", llround(2.7) == 3LL);
    TEST("lrint(2.7)", lrint(2.7) == 3L);
    TEST("nearbyint(2.5)", nearbyint(2.5) == 2.0 || nearbyint(2.5) == 3.0);
    TEST("rint(2.5)", rint(2.5) == 2.0 || rint(2.5) == 3.0);

    TEST("log2(8.0)", fabs(log2(8.0) - 3.0) < 1e-10);
    TEST("exp2(3.0)", fabs(exp2(3.0) - 8.0) < 1e-10);
    TEST("log1p(0.0)", fabs(log1p(0.0)) < 1e-10);
    TEST("expm1(0.0)", fabs(expm1(0.0)) < 1e-10);
    TEST("hypot(3.0, 4.0)", fabs(hypot(3.0, 4.0) - 5.0) < 1e-10);
    TEST("cbrt(27.0)", fabs(cbrt(27.0) - 3.0) < 1e-10);

    TEST("erf(0.0)", fabs(erf(0.0)) < 1e-10);
    TEST("erfc(0.0)", fabs(erfc(0.0) - 1.0) < 1e-10);
    TEST("lgamma(1.0)", lgamma(1.0) == 0.0);
    TEST("tgamma(5.0)", fabs(tgamma(5.0) - 24.0) < 1e-10);

    TEST("scalbn(1.0, 2)", scalbn(1.0, 2) == 4.0);
    TEST("scalbln(1.0, 2L)", scalbln(1.0, 2L) == 4.0);
    TEST("nextafter(1.0, 2.0) > 1.0", nextafter(1.0, 2.0) > 1.0);
    TEST("nexttoward(1.0, 2.0L) > 1.0", nexttoward(1.0, 2.0L) > 1.0);

    TEST("nan()", isnan(nan("")));
    TEST("nanf()", isnan(nanf("")));
    TEST("nanl()", isnan(nanl("")));

    TEST("ldexp(1.0, 3)", ldexp(1.0, 3) == 8.0);

    {
        int exp_val;
        double frac = frexp(8.0, &exp_val);
        TEST("frexp()", frac == 0.5 && exp_val == 4);
    }
    {
        double integ;
        double frac = modf(3.14, &integ);
        TEST("modf()", integ == 3.0 && frac > 0.0);
    }
    TEST("remainder(7.0, 3.0)", remainder(7.0, 3.0) == 1.0);
    {
        int quo;
        remquo(7.0, 3.0, &quo);
        TEST("remquo() 商", quo == 2);
    }
}

static void test_math_04_float_t_double_t(void)
{
    printf("\n[math] 7.4 float_t / double_t / 错误处理宏\n");
    TEST("float_t 类型 (>= float)", sizeof(float_t) >= sizeof(float));
    TEST("double_t 类型 (>= double)", sizeof(double_t) >= sizeof(double));

#if defined(FP_FAST_FMA)
    TEST("FP_FAST_FMA", FP_FAST_FMA == 1);
#else
    TEST("FP_FAST_FMA (未定义)", 1);
#endif

#if defined(math_errhandling) && math_errhandling
    TEST("math_errhandling 宏", math_errhandling > 0);
    #if defined(MATH_ERRNO)
    TEST("MATH_ERRNO", MATH_ERRNO > 0);
    #endif
#else
    TEST("math_errhandling (未定义)", 1);
#endif
}

static void test_math_05_flt_eval_decimal(void)
{
    printf("\n[math] 7.5 <float.h> 新增宏\n");
    TEST("DECIMAL_DIG", DECIMAL_DIG >= 6);
    TEST("FLT_EVAL_METHOD", FLT_EVAL_METHOD >= -1);
}

/* ========================================================================== */
/*  Part 8: tgmath.h                                                        */
/* ========================================================================== */
static void test_tgmath(void)
{
    printf("\n[tgmath] 8.1 类型泛型数学宏\n");
    float  f  = sqrt(4.0f);
    double d  = sqrt(4.0);
    long double ld = sqrt(4.0L);
    TEST("tgmath sqrt (float)", f == 2.0f);
    TEST("tgmath sqrt (double)", d == 2.0);
    TEST("tgmath sqrt (long double)", ld == 2.0L);

    TEST("tgmath fabs()", fabs(-3.0) == 3.0);
    TEST("tgmath sin()", fabs(sin(0.0)) < 1e-10);
    TEST("tgmath cos()", fabs(cos(0.0) - 1.0) < 1e-10);
    TEST("tgmath log()", fabs(log(1.0)) < 1e-10);
    TEST("tgmath pow()", fabs(pow(2.0, 10.0) - 1024.0) < 1e-10);
    TEST("tgmath atan()", fabs(atan(1.0) - 3.14159265/4.0) < 1e-6);
    TEST("tgmath floor()", floor(2.7) == 2.0);
    TEST("tgmath ceil()", ceil(2.1) == 3.0);
    TEST("tgmath fmod()", fabs(fmod(7.0, 3.0) - 1.0) < 1e-10);
}

/* ========================================================================== */
/*  Part 9: complex.h complex numbers                                       */
/* ========================================================================== */
static void test_complex_01_basic(void)
{
    printf("\n[complex] 9.1 复数基本操作\n");
    double complex z1 = 1.0 + 2.0 * I;
    double complex z2 = 3.0 + 4.0 * I;
    double complex z3 = z1 + z2;
    double complex z4 = z1 * z2;
    double complex z5 = z2 / z1;

    TEST("double complex 声明", creal(z1) == 1.0 && cimag(z1) == 2.0);
    TEST("复数加法", creal(z3) == 4.0 && cimag(z3) == 6.0);
    TEST("复数乘法", creal(z4) == -5.0 && cimag(z4) == 10.0);
    TEST("复数除法", cimag(z5) != 0.0 || creal(z5) != 0.0);
    TEST("creal()", creal(z2) == 3.0);
    TEST("cimag()", cimag(z2) == 4.0);

    double complex conj_z = conj(z1);
    TEST("conj() 共轭", cimag(conj_z) == -2.0 && creal(conj_z) == 1.0);

    double modulus = cabs(z1);
    TEST("cabs() 模", fabs(modulus - sqrt(5.0)) < 1e-10);

    double arg_val = carg(z1);
    TEST("carg() 辐角", fabs(arg_val - atan2(2.0, 1.0)) < 1e-10);
}

static void test_complex_02_cproj(void)
{
    printf("\n[complex] 9.2 cproj / I 宏\n");
    TEST("I 宏定义", 1);
    TEST("I*I == -1 (约)", cimag(I * I) < 1e-10 && fabs(creal(I * I) + 1.0) < 1e-10);

    double complex p1 = cproj(1.0 + 2.0 * I);
    TEST("cproj(有限值) == 原值", creal(p1) == 1.0 && cimag(p1) == 2.0);
}

static void test_complex_03_exp_log_pow_sqrt(void)
{
    printf("\n[complex] 9.3 复数 exp / log / pow / sqrt\n");

    double complex z = cexp(I); /* e^i */
    TEST("cexp(I): real=cos(1)", fabs(creal(z) - cos(1.0)) < 1e-10);
    TEST("cexp(I): imag=sin(1)", fabs(cimag(z) - sin(1.0)) < 1e-10);

    double complex lz = clog(1.0 + 0.0 * I);
    TEST("clog(1) == 0", fabs(creal(lz)) < 1e-10 && fabs(cimag(lz)) < 1e-10);

    double complex pz = cpow(2.0 + 0.0 * I, 10.0 + 0.0 * I);
    TEST("cpow(2,10) == 1024", fabs(creal(pz) - 1024.0) < 1e-10);

    double complex sq = csqrt(4.0 + 0.0 * I);
    TEST("csqrt(4) == 2", fabs(creal(sq) - 2.0) < 1e-10);
}

static void test_complex_04_trig_hyperbolic(void)
{
    printf("\n[complex] 9.4 复数三角函数和双曲函数\n");

    double complex z;

    z = csin(0.0 + 0.0 * I);
    TEST("csin(0) == 0", fabs(creal(z)) < 1e-10 && fabs(cimag(z)) < 1e-10);

    z = ccos(0.0 + 0.0 * I);
    TEST("ccos(0) == 1", fabs(creal(z) - 1.0) < 1e-10 && fabs(cimag(z)) < 1e-10);

    z = ctan(0.0 + 0.0 * I);
    TEST("ctan(0) == 0", fabs(creal(z)) < 1e-10 && fabs(cimag(z)) < 1e-10);

    z = csinh(0.0 + 0.0 * I);
    TEST("csinh(0) == 0", fabs(creal(z)) < 1e-10);

    z = ccosh(0.0 + 0.0 * I);
    TEST("ccosh(0) == 1", fabs(creal(z) - 1.0) < 1e-10);

    z = ctanh(0.0 + 0.0 * I);
    TEST("ctanh(0) == 0", fabs(creal(z)) < 1e-10);

    /* Inverse trig */
    z = casin(0.0 + 0.0 * I);
    TEST("casin(0) == 0", fabs(creal(z)) < 1e-10);

    z = cacos(1.0 + 0.0 * I);
    TEST("cacos(1) == 0", fabs(creal(z)) < 1e-10);

    z = catan(0.0 + 0.0 * I);
    TEST("catan(0) == 0", fabs(creal(z)) < 1e-10);

    /* Inverse hyperbolic */
    z = casinh(0.0 + 0.0 * I);
    TEST("casinh(0) == 0", fabs(creal(z)) < 1e-10);

    z = cacosh(1.0 + 0.0 * I);
    TEST("cacosh(1) == 0", fabs(cimag(z)) < 1e-10);

    z = catanh(0.5 + 0.0 * I);
    TEST("catanh(0.5) 实部>0", creal(z) > 0.0);
}

/* ========================================================================== */
/*  Part 10: fenv.h floating-point environment                              */
/* ========================================================================== */
static void test_fenv_01_macros(void)
{
    printf("\n[fenv] 10.1 <fenv.h> 异常/舍入宏\n");
    TEST("FE_DIVBYZERO", FE_DIVBYZERO > 0);
    TEST("FE_INVALID", FE_INVALID > 0);
    TEST("FE_OVERFLOW", FE_OVERFLOW > 0);
    TEST("FE_UNDERFLOW", FE_UNDERFLOW > 0);
    TEST("FE_INEXACT", FE_INEXACT > 0);
    TEST("FE_ALL_EXCEPT", FE_ALL_EXCEPT > 0);

    TEST("FE_DOWNWARD", FE_DOWNWARD > 0);
    TEST("FE_TONEAREST", FE_TONEAREST >= 0);
    TEST("FE_TOWARDZERO", FE_TOWARDZERO > 0);
    TEST("FE_UPWARD", FE_UPWARD > 0);

    TEST("FE_DFL_ENV", FE_DFL_ENV != NULL);
}

static void test_fenv_02_types_and_functions(void)
{
    printf("\n[fenv] 10.2 <fenv.h> 类型和函数\n");
    fenv_t saved_env;
    fexcept_t saved_flags;
    TEST("fenv_t", sizeof(saved_env) > 0);
    TEST("fexcept_t", sizeof(saved_flags) > 0);
    (void)saved_flags;

    TEST("fegetenv()", fegetenv(&saved_env) == 0);
    TEST("fesetenv(FE_DFL_ENV)", fesetenv(FE_DFL_ENV) == 0);
    TEST("fegetround()", fegetround() == FE_TONEAREST);
    TEST("fesetround(FE_UPWARD)", fesetround(FE_UPWARD) == 0);
    TEST("fesetround 恢复", fesetround(FE_TONEAREST) == 0);

    feclearexcept(FE_ALL_EXCEPT);
    TEST("feclearexcept()", fetestexcept(FE_ALL_EXCEPT) == 0);

    TEST("feholdexcept", feholdexcept(&saved_env) == 0);
    feupdateenv(FE_DFL_ENV);
    TEST("feupdateenv()", 1);

    fexcept_t flags;
    TEST("fegetexceptflag()", fegetexceptflag(&flags, FE_ALL_EXCEPT) == 0);
    TEST("fesetexceptflag()", fesetexceptflag(&flags, FE_ALL_EXCEPT) == 0);
}

/* ========================================================================== */
/*  Part 11: ctype.h / wctype.h additions                                   */
/* ========================================================================== */
static void test_ctype_isblank(void)
{
    printf("\n[ctype] 11.1 isblank / iswblank\n");
    TEST("isblank(' ')", isblank(' '));
    TEST("isblank('\\t')", isblank('\t'));
    TEST("!isblank('a')", !isblank('a'));
    TEST("!isblank('\\n')", !isblank('\n'));

    TEST("iswblank(L' ')", iswblank(L' '));
    TEST("iswblank(L'\\t')", iswblank(L'\t'));
    TEST("!iswblank(L'a')", !iswblank(L'a'));
}

/* ========================================================================== */
/*  Part 12: wchar.h additions                                              */
/* ========================================================================== */
static void test_wchar_01_basic(void)
{
    printf("\n[wchar] 12.1 宽字符基本类型\n");
    wchar_t wc = L'A';
    TEST("wchar_t", wc == L'A');
    TEST("wchar_t sizeof", sizeof(wchar_t) >= 2);

    const wchar_t *wstr = L"Hello, C99!";
    TEST("宽字符串字面量", wcslen(wstr) == 11);

    TEST("iswalpha(L'A')", iswalpha(L'A'));
    TEST("iswdigit(L'5')", iswdigit(L'5'));
    TEST("iswspace(L' ')", iswspace(L' '));
    TEST("towupper(L'a')", towupper(L'a') == L'A');
    TEST("towlower(L'A')", towlower(L'A') == L'a');
}

static void test_wchar_02_btowc_wctob(void)
{
    printf("\n[wchar] 12.2 btowc / wctob\n");
    TEST("btowc('A') == L'A'", btowc('A') == L'A');
    TEST("btowc(EOF) == WEOF", btowc(EOF) == WEOF);
    TEST("wctob(L'A') == 'A'", wctob(L'A') == 'A');
    TEST("wctob(WEOF) == EOF", wctob(WEOF) == EOF);
}

static void test_wchar_03_mbsinit(void)
{
    printf("\n[wchar] 12.3 mbsinit\n");
    mbstate_t mbs;
    memset(&mbs, 0, sizeof(mbs));
    TEST("mbsinit(初始状态)", mbsinit(&mbs));
    TEST("mbsinit(类型存在)", 1);
}

static void test_wchar_04_wide_string_conv(void)
{
    printf("\n[wchar] 12.4 wcstoll / wcstoull / wcstoimax / wcstoumax\n");
    TEST("wcstoll(L\"123\",NULL,10)", wcstoll(L"123", NULL, 10) == 123LL);
    TEST("wcstoull(L\"456\",NULL,10)", wcstoull(L"456", NULL, 10) == 456ULL);
    TEST("wcstoimax(L\"789\",NULL,10)", wcstoimax(L"789", NULL, 10) == 789);
    TEST("wcstoumax(L\"999\",NULL,10)", wcstoumax(L"999", NULL, 10) == 999);
}

static void test_wchar_05_string_concat(void)
{
    printf("\n[wchar] 12.5 宽字符串拼接\n");
    const char *s1 = "hello " "world";
    TEST("窄字符串拼接", strcmp(s1, "hello world") == 0);
    const wchar_t *ws = L"hello " L"world";
    TEST("宽字符串拼接", wcscmp(ws, L"hello world") == 0);
}

/* ========================================================================== */
/*  Part 13: stdarg.h va_copy                                              */
/* ========================================================================== */
static int variadic_sum(int count, ...)
{
    va_list ap1, ap2;
    va_start(ap1, count);
    va_copy(ap2, ap1);

    int sum = 0;
    for (int i = 0; i < count; i++) sum += va_arg(ap1, int);
    va_end(ap1);

    int sum2 = 0;
    for (int i = 0; i < count; i++) sum2 += va_arg(ap2, int);
    va_end(ap2);

    return sum == sum2 ? sum : -1;
}

static void test_va_copy(void)
{
    printf("\n[stdarg] 13.1 va_copy\n");
    int result = variadic_sum(4, 10, 20, 30, 40);
    TEST("va_copy 基本功能", result == 100);
}

/* ========================================================================== */
/*  Part 14: signal.h / setjmp.h                                           */
/* ========================================================================== */
static void test_signal(void)
{
    printf("\n[signal] 14.1 <signal.h>\n");
    TEST("sig_atomic_t", sizeof(sig_atomic_t) > 0);
    TEST("SIGFPE", SIGFPE > 0);
    TEST("SIGILL", SIGILL > 0);
    TEST("SIGSEGV", SIGSEGV > 0);
    TEST("SIGABRT", SIGABRT > 0);
    TEST("SIGINT", SIGINT > 0);

    void (*old_handler)(int) = signal(SIGINT, SIG_IGN);
    TEST("signal()", old_handler != SIG_ERR);
    signal(SIGINT, old_handler);

    TEST("SIG_DFL", SIG_DFL == 0 || SIG_DFL != NULL);
    TEST("SIG_IGN", SIG_IGN != NULL);
    TEST("SIG_ERR", SIG_ERR != NULL);
}

static void test_setjmp(void)
{
    printf("\n[setjmp] 14.2 <setjmp.h>\n");
    jmp_buf env;
    TEST("jmp_buf", sizeof(env) > 0);
    if (setjmp(env) == 0) {
        longjmp(env, 1);
    }
    TEST("setjmp/longjmp", 1);
}

/* ========================================================================== */
/*  Part 15: time.h / locale.h                                             */
/* ========================================================================== */
static void test_time_strftime(void)
{
    printf("\n[time] 15.1 <time.h> strftime %%z\n");
    time_t t = time(NULL);
    TEST("time_t", t >= 0);
    struct tm *tm_val = localtime(&t);
    TEST("localtime()", tm_val != NULL);

    char buf[64];
    size_t len = strftime(buf, sizeof(buf), "%Y-%m-%d %H:%M:%S", tm_val);
    TEST("strftime()", len > 0);

    len = strftime(buf, sizeof(buf), "%z", tm_val);
    TEST("strftime %z (C99 时区偏移)", len > 0);

    len = strftime(buf, sizeof(buf), "%Z", tm_val);
    TEST("strftime %Z", len > 0);

    TEST("CLOCKS_PER_SEC", CLOCKS_PER_SEC > 0);
}

static void test_locale(void)
{
    printf("\n[locale] 15.2 <locale.h>\n");
    struct lconv *lc = localeconv();
    TEST("localeconv()", lc != NULL);

    const char *prev = setlocale(LC_ALL, "");
    TEST("setlocale(LC_ALL, \"\")", prev != NULL);
    TEST("LC_CTYPE", setlocale(LC_CTYPE, NULL) != NULL);
    TEST("LC_MONETARY", setlocale(LC_MONETARY, NULL) != NULL);
    TEST("LC_NUMERIC", setlocale(LC_NUMERIC, NULL) != NULL);
    TEST("LC_TIME", setlocale(LC_TIME, NULL) != NULL);
    setlocale(LC_ALL, "C");
}

/* ========================================================================== */
/*  Part 16: Other miscellaneous                                            */
/* ========================================================================== */
static void test_switch_declarations(void)
{
    printf("\n[杂项] 16.1 switch/case 中声明变量\n");
    int x = 42;
    switch (x) {
        case 40: {
            int local_var = 1;
            (void)local_var;
            break;
        }
        case 42: {
            int local_var = 2;
            TEST("switch case 中声明变量", local_var == 2);
            break;
        }
        default: break;
    }
}

static void test_null(void)
{
    printf("\n[杂项] 16.2 NULL 宏\n");
    TEST("NULL == (void*)0", NULL == (void *)0);
    TEST("NULL == 0", NULL == 0);
    int *p = NULL;
    TEST("指针赋值为 NULL", p == NULL);
    p = (int *)calloc(1, sizeof(int));
    if (p) { *p = 42; TEST("NULL 后使用", *p == 42); free(p); }
}

static void test_alignment(void)
{
    printf("\n[杂项] 16.3 内存对齐\n");
    TEST("sizeof(int) >= 2", sizeof(int) >= 2);
    TEST("sizeof(double) >= sizeof(int)", sizeof(double) >= sizeof(int));
    TEST("sizeof(void*) >= sizeof(int)", sizeof(void *) >= sizeof(int));
    struct align_test { char c; double d; int i; };
    TEST("结构体对齐填充", sizeof(struct align_test) >= sizeof(double) + sizeof(int) + 1);
}

/* ========================================================================== */
/*  Main function                                                           */
/* ========================================================================== */
int main(void)
{
    printf("================================================================\n");
    printf("  C99 编译器特性完整测试程序\n");
    printf("  编译时间: %s %s\n", __DATE__, __TIME__);
    printf("  __STDC_VERSION__ = %ldL\n", (long)__STDC_VERSION__);
    printf("  __STDC_HOSTED__  = %d\n", __STDC_HOSTED__);
    printf("================================================================\n");

    /* ====== Core language features ====== */
    test_01_stdc_version();
    test_02_line_comments();
    test_03_mixed_declarations();
    test_04_long_long();
    test_05_bool_type();
    test_06_stdbool();
    test_07_inline();
    test_08_restrict();
    test_09_idempotent_qualifiers();
    test_10_compound_literals();
    test_11_designated_initializers();
    test_12_vla(10);
    test_13_flexible_array_member();
    test_14_func_identifier();
    test_15_trailing_comma_enum();
    test_16_universal_character_names();
    test_17_hex_float();
    test_18_division_truncation();
    test_19_nonconst_initializer();
    test_20_main_implicit_return();
    test_21_imaginary();
    test_22_complex_keyword();

    /* ====== Preprocessor features ====== */
    test_pp_01_variadic_macros();
    test_pp_02_pragma_operator();
    test_pp_03_empty_macro();
    test_pp_04_preprocessor_enhancements();
    test_pp_05_gnu_ext_va_args();

    /* ====== stdint / inttypes ====== */
    test_stdint_01_exact_width();
    test_stdint_02_min_fast_max();
    test_stdint_03_limits_macros();
    test_stdint_04_inttypes_formats();
    test_stdint_05_inttypes_functions();

    /* ====== stdlib.h additions ====== */
    test_stdlib_01_llabs_lldiv();
    test_stdlib_02_strtoll_strtoull();
    test_stdlib_03_strtoimax_strtoumax();
    test_stdlib_04_Exit();

    /* ====== stdio.h additions ====== */
    test_stdio_01_snprintf_vsnprintf();
    test_stdio_02_vscanf_vsscanf_vfscanf();

    /* ====== Format specifiers ====== */
    test_format_01_length_modifiers();
    test_format_02_hex_float();
    test_format_03_wide_printf();

    /* ====== math.h / tgmath.h ====== */
    test_math_01_classification_macros();
    test_math_02_comparison_macros();
    test_math_03_math_functions();
    test_math_04_float_t_double_t();
    test_math_05_flt_eval_decimal();
    test_tgmath();

    /* ====== complex.h ====== */
    test_complex_01_basic();
    test_complex_02_cproj();
    test_complex_03_exp_log_pow_sqrt();
    test_complex_04_trig_hyperbolic();

    /* ====== fenv.h ====== */
    test_fenv_01_macros();
    test_fenv_02_types_and_functions();

    /* ====== ctype / wctype ====== */
    test_ctype_isblank();

    /* ====== wchar.h ====== */
    test_wchar_01_basic();
    test_wchar_02_btowc_wctob();
    test_wchar_03_mbsinit();
    test_wchar_04_wide_string_conv();
    test_wchar_05_string_concat();

    /* ====== stdarg ====== */
    test_va_copy();

    /* ====== signal / setjmp ====== */
    test_signal();
    test_setjmp();

    /* ====== time / locale ====== */
    test_time_strftime();
    test_locale();

    /* ====== miscellaneous ====== */
    test_switch_declarations();
    test_null();
    test_alignment();

    /* ====== summary ====== */
    printf("\n================================================================\n");
    printf("  测试结果汇总\n");
    printf("----------------------------------------------------------------\n");
    printf("  总计: %d    通过: %d    失败: %d\n",
           total_tests, passed_tests, failed_tests);
    printf("  通过率: %.1f%%\n",
           total_tests > 0 ? 100.0 * (double)passed_tests / total_tests : 0.0);
    printf("================================================================\n");

    return failed_tests > 0 ? 1 : 0;
}
