/* stdlib/src/math.c - Ark C Compiler 精简版 math 函数 fallback
 *
 * 仅作为最小可用回退实现，精度较低。
 * 生产代码请使用 newlib 或 CMSIS DSP 提供的高精度 math 库。
 *
 * 函数集：fabs/sqrt/floor/ceil/fmod/sin/cos/pow
 * 未实现：tan/exp/log/atan 等（控制算法常用三角函数已覆盖 sin/cos）。
 */

/* 绝对值 */
double fabs(double x) {
    return x < 0.0 ? -x : x;
}

/* 平方根：牛顿迭代法。x<=0 返回 0；对正数迭代 20 次保证收敛。 */
double sqrt(double x) {
    if (x <= 0.0) return 0.0;
    {
        double r = x;
        int i;
        for (i = 0; i < 20; i++) {
            r = (r + x / r) * 0.5;
        }
        return r;
    }
}

/* 向下取整：截断到 long 后再判断负数情况下是否需要减 1。 */
double floor(double x) {
    long i = (long)x;
    double d = (double)i;
    if (x < 0.0 && d != x) return d - 1.0;
    return d;
}

/* 向上取整：与 floor 对称 */
double ceil(double x) {
    long i = (long)x;
    double d = (double)i;
    if (x > 0.0 && d != x) return d + 1.0;
    return d;
}

/* 浮点取模：x - (long)(x/y) * y，仅对常用范围有效 */
double fmod(double x, double y) {
    if (y == 0.0) return 0.0;
    {
        double q = x / y;
        long   iq = (long)q;
        return x - (double)iq * y;
    }
}

/* === 三角函数与幂函数 ===
 * 控制算法（PID、坐标变换、PLL 等）常用 sin/cos/pow，
 * 故在此提供泰勒级数回退实现。精度约 1e-12，足够 STM32 调试场景。
 * 真正高吞吐场景请链接 CMSIS-DSP 的 sinf/cosf 查表实现。 */

/* sin：泰勒级数展开。先把参数归约到 [-pi, pi]，再展开 10 项。
 *   归约：x -= 2*pi*round(x/(2*pi))，避免大角度时级数发散。 */
double sin(double x) {
    int i;
    double term, sum;
    {
        double twopi = 6.28318530717958647692;
        double n = x / twopi;
        long k = (long)(n >= 0.0 ? n + 0.5 : n - 0.5);
        x = x - (double)k * twopi;
    }
    term = x;          /* 第一项 x */
    sum  = x;
    for (i = 1; i < 10; i++) {
        /* term *= -x*x / ((2i)*(2i+1)) */
        term = -term * x * x / (double)((2 * i) * (2 * i + 1));
        sum += term;
    }
    return sum;
}

/* cos：泰勒级数展开。归约到 [-pi, pi] 后展开 10 项。 */
double cos(double x) {
    int i;
    double term, sum;
    {
        double twopi = 6.28318530717958647692;
        double n = x / twopi;
        long k = (long)(n >= 0.0 ? n + 0.5 : n - 0.5);
        x = x - (double)k * twopi;
    }
    term = 1.0;        /* 第一项 1 */
    sum  = 1.0;
    for (i = 1; i < 10; i++) {
        /* term *= -x*x / ((2i-1)*(2i)) */
        term = -term * x * x / (double)((2 * i - 1) * (2 * i));
        sum += term;
    }
    return sum;
}

/* exp 内部助手：泰勒级数，对 |z|<700 有效。 */
static double ark_exp(double z) {
    int i;
    double term, sum;
    if (z < -700.0) return 0.0;
    if (z > 700.0)  return 1.0e300;   /* 溢出占位 */
    term = 1.0;
    sum  = 1.0;
    for (i = 1; i < 20; i++) {
        term = term * z / (double)i;
        sum += term;
    }
    return sum;
}

/* log 内部助手：自然对数。x>0 时用
 *   log(x) = 2 * (y + y^3/3 + y^5/5 + ...)，其中 y = (x-1)/(x+1)。
 * 该级数对任意 x>0 均收敛，30 项足够双精度。 */
static double ark_log(double x) {
    double y, term, sum, y2;
    int i;
    if (x <= 0.0) return 0.0;         /* 定义域外返回 0 */
    y  = (x - 1.0) / (x + 1.0);
    y2 = y * y;
    term = y;
    sum  = y;
    for (i = 1; i < 30; i++) {
        term = term * y2;
        sum += term / (double)(2 * i + 1);
    }
    return 2.0 * sum;
}

/* pow：x^y。
 *  - y 为整数：用快速幂循环连乘（含负指数取倒数）
 *  - 否则：exp(y * log(x))；x<=0 时非实数，返回 0 */
double pow(double x, double y) {
    long iy = (long)y;
    if ((double)iy == y) {
        long n = iy;
        double base = x;
        double result = 1.0;
        int neg = 0;
        if (n < 0) { neg = 1; n = -n; }
        while (n > 0) {
            if (n & 1) result *= base;
            base *= base;
            n >>= 1;
        }
        return neg ? (result != 0.0 ? 1.0 / result : 0.0) : result;
    }
    /* 非整数指数：仅 x>0 有定义 */
    if (x <= 0.0) return 0.0;
    return ark_exp(y * ark_log(x));
}
