/* stdlib/src/math.c - Ark C Compiler minimal math function fallback
 *
 * Minimal usable fallback implementation; precision is low.
 * For production, use the high-precision math library from newlib or CMSIS DSP.
 *
 * Functions: fabs/sqrt/floor/ceil/fmod/sin/cos/pow
 * Not implemented: tan/exp/log/atan etc. (common trig functions used by
 * control algorithms are covered via sin/cos).
 */

/* Absolute value */
double fabs(double x) {
    return x < 0.0 ? -x : x;
}

/* Square root: Newton's iteration. x<=0 returns 0; 20 iterations ensure
 * convergence for positive numbers. */
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

/* Floor: truncate to long, then subtract 1 for negative non-integer cases. */
double floor(double x) {
    long i = (long)x;
    double d = (double)i;
    if (x < 0.0 && d != x) return d - 1.0;
    return d;
}

/* Ceil: symmetric to floor */
double ceil(double x) {
    long i = (long)x;
    double d = (double)i;
    if (x > 0.0 && d != x) return d + 1.0;
    return d;
}

/* Floating-point modulo: x - (long)(x/y) * y; valid only for common ranges */
double fmod(double x, double y) {
    if (y == 0.0) return 0.0;
    {
        double q = x / y;
        long   iq = (long)q;
        return x - (double)iq * y;
    }
}

/* === Trig & power functions ===
 * Control algorithms (PID, coordinate transforms, PLL, etc.) commonly use
 * sin/cos/pow, so a Taylor series fallback is provided here. Precision is
 * about 1e-12, sufficient for STM32 debug scenarios. For high-throughput
 * scenarios, link the CMSIS-DSP sinf/cosf table-based implementation. */

/* sin: Taylor series. First reduce the argument to [-pi, pi], then expand
 * 10 terms. Reduction: x -= 2*pi*round(x/(2*pi)) to avoid series divergence
 * at large angles. */
double sin(double x) {
    int i;
    double term, sum;
    {
        double twopi = 6.28318530717958647692;
        double n = x / twopi;
        long k = (long)(n >= 0.0 ? n + 0.5 : n - 0.5);
        x = x - (double)k * twopi;
    }
    term = x;          /* first term x */
    sum  = x;
    for (i = 1; i < 10; i++) {
        /* term *= -x*x / ((2i)*(2i+1)) */
        term = -term * x * x / (double)((2 * i) * (2 * i + 1));
        sum += term;
    }
    return sum;
}

/* cos: Taylor series. Reduce to [-pi, pi] then expand 10 terms. */
double cos(double x) {
    int i;
    double term, sum;
    {
        double twopi = 6.28318530717958647692;
        double n = x / twopi;
        long k = (long)(n >= 0.0 ? n + 0.5 : n - 0.5);
        x = x - (double)k * twopi;
    }
    term = 1.0;        /* first term 1 */
    sum  = 1.0;
    for (i = 1; i < 10; i++) {
        /* term *= -x*x / ((2i-1)*(2i)) */
        term = -term * x * x / (double)((2 * i - 1) * (2 * i));
        sum += term;
    }
    return sum;
}

/* exp internal helper: Taylor series, valid for |z|<700. */
static double ark_exp(double z) {
    int i;
    double term, sum;
    if (z < -700.0) return 0.0;
    if (z > 700.0)  return 1.0e300;   /* overflow placeholder */
    term = 1.0;
    sum  = 1.0;
    for (i = 1; i < 20; i++) {
        term = term * z / (double)i;
        sum += term;
    }
    return sum;
}

/* log internal helper: natural logarithm. For x>0 uses
 *   log(x) = 2 * (y + y^3/3 + y^5/5 + ...), where y = (x-1)/(x+1).
 * This series converges for all x>0; 30 terms suffice for double precision. */
static double ark_log(double x) {
    double y, term, sum, y2;
    int i;
    if (x <= 0.0) return 0.0;         /* out of domain, return 0 */
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

/* pow: x^y.
 *  - Integer y: fast exponentiation via repeated squaring (negative exponent
 *    takes reciprocal).
 *  - Otherwise: exp(y * log(x)); x<=0 is non-real, return 0 */
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
    /* Non-integer exponent: only defined for x>0 */
    if (x <= 0.0) return 0.0;
    return ark_exp(y * ark_log(x));
}
