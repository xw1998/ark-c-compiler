/* tests/softfloat_ref.c - host differential gate for stdlib/src/arm/aeabi_float.c
 *
 * Why this file exists
 * --------------------
 * The soft-float runtime is a piece of arithmetic that, when it is wrong, is
 * wrong *silently*: nothing crashes, the number is just off by an ulp (or by a
 * whole binade).  Reading the code cannot prove it right, and "it compiled"
 * proves nothing at all.  So every entry point is compared, bit for bit,
 * against the host CPU's own IEEE-754 result on a large pile of operands,
 * including the ones that break naive implementations: signed zeros,
 * subnormals, the largest finite value, infinities, NaNs, and the exact ties
 * that decide whether the rounding step is round-to-even or round-away.
 *
 * The host (x86-64 SSE2 in round-to-nearest-even) *is* the oracle here, which
 * is legitimate because the target is the same IEEE-754 binary32/binary64 with
 * the same default rounding mode.  NaN results are compared as "both are NaN"
 * (payloads are documented as not propagated); every other result must match
 * to the last bit.
 *
 * Build and run (from the repository root, MinGW or any host C compiler):
 *     gcc -std=c99 -O2 -ffp-contract=off -fno-fast-math -msse2 -mfpmath=sse
 *         tests/softfloat_ref.c stdlib/src/arm/aeabi_float.c -o sf_ref.exe
 *     ./sf_ref.exe [iterations] [seed]
 *
 * `-mfpmath=sse` is not optional on a 32-bit x86 host: the x87 unit computes
 * in 80 bits and rounds twice, which turns a tie into a wrong answer (the very
 * first division case below, 2^52 / DBL_MAX, comes out one ulp low).  main()
 * checks the oracle for exactly that at startup and refuses to run if the
 * build double-rounds -- otherwise the "host" would be the broken side and the
 * gate would blame the runtime for a compiler flag.
 *
 * Exit status 0 when every operation matched; 1 otherwise.  The last section
 * mutates expected results on purpose and requires the checker to notice --
 * a gate that cannot fail is not a gate.
 *
 * Nothing in this file is compiled for the target; it exists only to produce
 * evidence about the runtime.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <limits.h>

typedef unsigned int       u32;
typedef unsigned long long u64;

typedef union { double d; u64 u; } dbl;
typedef union { float  f; u32 u; } flt;

/* ---- the runtime under test ---------------------------------------- */
extern double __aeabi_dadd(double, double);
extern double __aeabi_dsub(double, double);
extern double __aeabi_dmul(double, double);
extern double __aeabi_ddiv(double, double);
extern float  __aeabi_fadd(float, float);
extern float  __aeabi_fsub(float, float);
extern float  __aeabi_fmul(float, float);
extern float  __aeabi_fdiv(float, float);

extern int __aeabi_dcmpeq(double, double);
extern int __aeabi_dcmpne(double, double);
extern int __aeabi_dcmplt(double, double);
extern int __aeabi_dcmple(double, double);
extern int __aeabi_dcmpgt(double, double);
extern int __aeabi_dcmpge(double, double);
extern int __aeabi_fcmpeq(float, float);
extern int __aeabi_fcmpne(float, float);
extern int __aeabi_fcmplt(float, float);
extern int __aeabi_fcmple(float, float);
extern int __aeabi_fcmpgt(float, float);
extern int __aeabi_fcmpge(float, float);

extern double __aeabi_i2d(int);
extern double __aeabi_ui2d(unsigned int);
extern double __aeabi_l2d(long long);
extern double __aeabi_ul2d(unsigned long long);
extern float  __aeabi_i2f(int);
extern float  __aeabi_ui2f(unsigned int);
extern float  __aeabi_l2f(long long);
extern float  __aeabi_ul2f(unsigned long long);
extern int    __aeabi_d2iz(double);
extern unsigned int __aeabi_d2uiz(double);
extern long long __aeabi_d2lz(double);
extern unsigned long long __aeabi_d2ulz(double);
extern int    __aeabi_f2iz(float);
extern unsigned int __aeabi_f2uiz(float);
extern long long __aeabi_f2lz(float);
extern unsigned long long __aeabi_f2ulz(float);
extern double __aeabi_f2d(float);
extern float  __aeabi_d2f(double);

/* ---- accounting ----------------------------------------------------- */
static long failures;
static long checks;

static void fail(const char *op, u64 a, u64 b, u64 got, u64 want)
{
    failures++;
    if (failures <= 40) {
        printf("  FAIL %-10s a=%016llx b=%016llx got=%016llx want=%016llx\n",
               op, (unsigned long long)a, (unsigned long long)b,
               (unsigned long long)got, (unsigned long long)want);
    }
}

static int is_nan_d(u64 bits) { return ((bits >> 52) & 0x7ff) == 0x7ff && (bits & 0xfffffffffffffULL) != 0; }
static int is_nan_f(u32 bits) { return ((bits >> 23) & 0xff) == 0xff && (bits & 0x7fffff) != 0; }

/* compare a double result: both NaN is a match, otherwise every bit */
static void chk_d(const char *op, u64 a, u64 b, u64 got, u64 want)
{
    checks++;
    if (is_nan_d(got) || is_nan_d(want)) {
        if (!(is_nan_d(got) && is_nan_d(want))) fail(op, a, b, got, want);
        return;
    }
    if (got != want) fail(op, a, b, got, want);
}

static void chk_f(const char *op, u64 a, u64 b, u32 got, u32 want)
{
    checks++;
    if (is_nan_f(got) || is_nan_f(want)) {
        if (!(is_nan_f(got) && is_nan_f(want))) fail(op, a, b, got, want);
        return;
    }
    if (got != want) fail(op, a, b, got, want);
}

/* ---- operand generators -------------------------------------------- */
static u64 rnd_state;
static u64 rnd64(void)
{
    rnd_state ^= rnd_state << 13;
    rnd_state ^= rnd_state >> 7;
    rnd_state ^= rnd_state << 17;
    return rnd_state;
}
static u32 rnd32(void) { return (u32)(rnd64() >> 17); }

static const u64 D_EDGE[] = {
    0x0000000000000000ULL, /* +0 */
    0x8000000000000000ULL, /* -0 */
    0x0000000000000001ULL, /* min subnormal */
    0x8000000000000001ULL, /* -min subnormal */
    0x000fffffffffffffULL, /* max subnormal */
    0x0010000000000000ULL, /* min normal */
    0x8010000000000000ULL, /* -min normal */
    0x3ff0000000000000ULL, /* 1.0 */
    0xbff0000000000000ULL, /* -1.0 */
    0x3ff0000000000001ULL, /* 1.0 + 1ulp */
    0x3fe0000000000000ULL, /* 0.5 */
    0x4000000000000000ULL, /* 2.0 */
    0x4330000000000000ULL, /* 2^52 */
    0x7fefffffffffffffULL, /* max finite */
    0xffefffffffffffffULL, /* -max finite */
    0x7ff0000000000000ULL, /* +inf */
    0xfff0000000000000ULL, /* -inf */
    0x7ff8000000000000ULL, /* qNaN */
    0x7ff0000000000001ULL, /* sNaN */
    0xfff8000000000000ULL, /* -qNaN */
    0x0000000000000002ULL, /* 2 * min subnormal */
};
#define D_EDGE_N ((int)(sizeof D_EDGE / sizeof D_EDGE[0]))

static const u32 F_EDGE[] = {
    0x00000000u, 0x80000000u, 0x00000001u, 0x80000001u,
    0x007fffffu, 0x00800000u, 0x80800000u,
    0x3f800000u, 0xbf800000u, 0x3f800001u, 0x3f000000u,
    0x40000000u, 0x4b000000u, 0x7f7fffffu, 0xff7fffffu,
    0x7f800000u, 0xff800000u, 0x7fc00000u, 0x7f800001u,
    0xffc00000u, 0x00000002u,
    0x3f800000u ^ 0x40000000u, /* 3.0 -- used with 1.0 to hit exact ties */
};
#define F_EDGE_N ((int)(sizeof F_EDGE / sizeof F_EDGE[0]))

/* A "plausible" double: an exponent from a workable band, a random mantissa.
 * Pure random 64-bit patterns are ~99% huge numbers or NaN, which exercises
 * the special paths but never the ordinary arithmetic. */
static u64 gen_d(void)
{
    u64 r = rnd64();
    switch (r & 7) {
    case 0:                                   /* fully random bit pattern */
        return rnd64();
    case 1:                                   /* edge operand */
        return D_EDGE[rnd32() % D_EDGE_N];
    case 2:                                   /* tiny / subnormal region */
        return (rnd64() & 0x800fffffffffffffULL);
    case 3: {                                 /* normal, exponent in [-60, 60] */
        u64 sign = (rnd64() & 1) ? 0x8000000000000000ULL : 0;
        u64 exp  = 1023u + (u64)((int)(rnd32() % 121) - 60);
        return sign | (exp << 52) | (rnd64() & 0xfffffffffffffULL);
    }
    default: {                                /* near 1.0: dense cancellation */
        u64 sign = (rnd64() & 1) ? 0x8000000000000000ULL : 0;
        u64 exp  = 1023u + (u64)((int)(rnd32() % 5) - 2);
        return sign | (exp << 52) | (rnd64() & 0xfffffffffffffULL);
    }
    }
}

static u32 gen_f(void)
{
    u64 r = rnd64();
    switch (r & 7) {
    case 0:
        return rnd32();
    case 1:
        return F_EDGE[rnd32() % F_EDGE_N];
    case 2:
        return (rnd32() & 0x807fffffu);
    case 3: {
        u32 sign = (rnd32() & 1) ? 0x80000000u : 0;
        u32 exp  = 127u + (u32)((int)(rnd32() % 61) - 30);
        return sign | (exp << 23) | (rnd32() & 0x7fffffu);
    }
    default: {
        u32 sign = (rnd32() & 1) ? 0x80000000u : 0;
        u32 exp  = 127u + (u32)((int)(rnd32() % 5) - 2);
        return sign | (exp << 23) | (rnd32() & 0x7fffffu);
    }
    }
}

/* ---- the comparisons, checked against C's own operators -------------- */
static void cmp_d(u64 ab, u64 bb)
{
    volatile dbl a, b;
    double x, y;
    a.u = ab; b.u = bb;
    x = a.d; y = b.d;
    checks += 6;
    if (__aeabi_dcmpeq(x, y) != (x == y)) fail("dcmpeq", ab, bb, (u64)__aeabi_dcmpeq(x, y), (u64)(x == y));
    if (__aeabi_dcmpne(x, y) != (x != y)) fail("dcmpne", ab, bb, (u64)__aeabi_dcmpne(x, y), (u64)(x != y));
    if (__aeabi_dcmplt(x, y) != (x <  y)) fail("dcmplt", ab, bb, (u64)__aeabi_dcmplt(x, y), (u64)(x <  y));
    if (__aeabi_dcmple(x, y) != (x <= y)) fail("dcmple", ab, bb, (u64)__aeabi_dcmple(x, y), (u64)(x <= y));
    if (__aeabi_dcmpgt(x, y) != (x >  y)) fail("dcmpgt", ab, bb, (u64)__aeabi_dcmpgt(x, y), (u64)(x >  y));
    if (__aeabi_dcmpge(x, y) != (x >= y)) fail("dcmpge", ab, bb, (u64)__aeabi_dcmpge(x, y), (u64)(x >= y));
}

static void cmp_f(u32 ab, u32 bb)
{
    volatile flt a, b;
    float x, y;
    a.u = ab; b.u = bb;
    x = a.f; y = b.f;
    checks += 6;
    if (__aeabi_fcmpeq(x, y) != (x == y)) fail("fcmpeq", ab, bb, (u64)__aeabi_fcmpeq(x, y), (u64)(x == y));
    if (__aeabi_fcmpne(x, y) != (x != y)) fail("fcmpne", ab, bb, (u64)__aeabi_fcmpne(x, y), (u64)(x != y));
    if (__aeabi_fcmplt(x, y) != (x <  y)) fail("fcmplt", ab, bb, (u64)__aeabi_fcmplt(x, y), (u64)(x <  y));
    if (__aeabi_fcmple(x, y) != (x <= y)) fail("fcmple", ab, bb, (u64)__aeabi_fcmple(x, y), (u64)(x <= y));
    if (__aeabi_fcmpgt(x, y) != (x >  y)) fail("fcmpgt", ab, bb, (u64)__aeabi_fcmpgt(x, y), (u64)(x >  y));
    if (__aeabi_fcmpge(x, y) != (x >= y)) fail("fcmpge", ab, bb, (u64)__aeabi_fcmpge(x, y), (u64)(x >= y));
}

/* ---- float -> integer: the documented behaviour (saturate, NaN -> 0) -
 * The reference is written out rather than taken from a C cast, because
 * out-of-range conversion is undefined in C and a UB oracle is no oracle.
 * It matches the ARM VCVT semantics armcc's runtime has. */
static int ref_d2iz(double x)
{
    if (x != x) return 0;
    if (x >= 2147483647.0) return INT_MAX;
    if (x <= -2147483648.0) return INT_MIN;
    return (int)x;
}
static unsigned int ref_d2uiz(double x)
{
    if (x != x) return 0;
    if (x >= 4294967295.0) return UINT_MAX;
    if (x <= 0.0) return 0;
    return (unsigned int)x;
}
static long long ref_d2lz(double x)
{
    if (x != x) return 0;
    if (x >= 9223372036854775807.0) return LLONG_MAX;
    if (x <= -9223372036854775808.0) return LLONG_MIN;
    return (long long)x;
}
static unsigned long long ref_d2ulz(double x)
{
    if (x != x) return 0;
    if (x >= 18446744073709551615.0) return ULLONG_MAX;
    if (x <= 0.0) return 0;
    return (unsigned long long)x;
}

static void conv_d(double x)
{
    dbl v;
    v.d = x;
    checks += 4;
    if (__aeabi_d2iz(x)  != ref_d2iz(x))  fail("d2iz",  v.u, 0, (u64)(u32)__aeabi_d2iz(x),  (u64)(u32)ref_d2iz(x));
    if (__aeabi_d2uiz(x) != ref_d2uiz(x)) fail("d2uiz", v.u, 0, (u64)__aeabi_d2uiz(x),     (u64)ref_d2uiz(x));
    if (__aeabi_d2lz(x)  != ref_d2lz(x))  fail("d2lz",  v.u, 0, (u64)__aeabi_d2lz(x),      (u64)ref_d2lz(x));
    if (__aeabi_d2ulz(x) != ref_d2ulz(x)) fail("d2ulz", v.u, 0, __aeabi_d2ulz(x),          ref_d2ulz(x));
}

static void conv_f(float x)
{
    flt v;
    v.f = x;
    checks += 4;
    if (__aeabi_f2iz(x)  != ref_d2iz((double)x))  fail("f2iz",  v.u, 0, (u64)(u32)__aeabi_f2iz(x),  (u64)(u32)ref_d2iz((double)x));
    if (__aeabi_f2uiz(x) != ref_d2uiz((double)x)) fail("f2uiz", v.u, 0, (u64)__aeabi_f2uiz(x),     (u64)ref_d2uiz((double)x));
    if (__aeabi_f2lz(x)  != ref_d2lz((double)x))  fail("f2lz",  v.u, 0, (u64)__aeabi_f2lz(x),      (u64)ref_d2lz((double)x));
    if (__aeabi_f2ulz(x) != ref_d2ulz((double)x)) fail("f2ulz", v.u, 0, __aeabi_f2ulz(x),          ref_d2ulz((double)x));
}

/* integer -> float: exact for the widths involved, so it is a plain compare */
static void conv_int(u64 r)
{
    volatile int i = (int)(u32)r;
    volatile unsigned int ui = (u32)(r >> 32);
    volatile long long l = (long long)r;
    volatile unsigned long long ul = r;
    dbl d1, d2, d3, d4, e1, e2, e3, e4;
    flt f1, f2, f3, f4, g1, g2, g3, g4;

    d1.d = __aeabi_i2d(i);    e1.d = (double)i;
    d2.d = __aeabi_ui2d(ui);  e2.d = (double)ui;
    d3.d = __aeabi_l2d(l);    e3.d = (double)l;
    d4.d = __aeabi_ul2d(ul);  e4.d = (double)ul;
    checks += 4;
    if (d1.u != e1.u) fail("i2d",  r, 0, d1.u, e1.u);
    if (d2.u != e2.u) fail("ui2d", r, 0, d2.u, e2.u);
    if (d3.u != e3.u) fail("l2d",  r, 0, d3.u, e3.u);
    if (d4.u != e4.u) fail("ul2d", r, 0, d4.u, e4.u);

    f1.f = __aeabi_i2f(i);    g1.f = (float)i;
    f2.f = __aeabi_ui2f(ui);  g2.f = (float)ui;
    f3.f = __aeabi_l2f(l);    g3.f = (float)l;
    f4.f = __aeabi_ul2f(ul);  g4.f = (float)ul;
    checks += 4;
    /* (float)long long rounds to nearest even, same rule as the runtime */
    if (f1.u != g1.u) fail("i2f",  r, 0, f1.u, g1.u);
    if (f2.u != g2.u) fail("ui2f", r, 0, f2.u, g2.u);
    if (f3.u != g3.u) fail("l2f",  r, 0, f3.u, g3.u);
    if (f4.u != g4.u) fail("ul2f", r, 0, f4.u, g4.u);
}

/* ---- targeted cases: the arithmetic identities and signed zeros ------ */
static void targeted(void)
{
    dbl a, b, r, w;
    flt af, bf, rf, wf;
    long i, j;

    /* every pair of edge operands, both ways round */
    for (i = 0; i < D_EDGE_N; i++) {
        for (j = 0; j < D_EDGE_N; j++) {
            a.u = D_EDGE[i]; b.u = D_EDGE[j];
            r.d = __aeabi_dadd(a.d, b.d); w.d = a.d + b.d; chk_d("dadd",  a.u, b.u, r.u, w.u);
            r.d = __aeabi_dsub(a.d, b.d); w.d = a.d - b.d; chk_d("dsub",  a.u, b.u, r.u, w.u);
            r.d = __aeabi_dmul(a.d, b.d); w.d = a.d * b.d; chk_d("dmul",  a.u, b.u, r.u, w.u);
            r.d = __aeabi_ddiv(a.d, b.d); w.d = a.d / b.d; chk_d("ddiv",  a.u, b.u, r.u, w.u);
            cmp_d(a.u, b.u);
        }
    }
    for (i = 0; i < F_EDGE_N; i++) {
        for (j = 0; j < F_EDGE_N; j++) {
            af.u = F_EDGE[i]; bf.u = F_EDGE[j];
            rf.f = __aeabi_fadd(af.f, bf.f); wf.f = af.f + bf.f; chk_f("fadd", af.u, bf.u, rf.u, wf.u);
            rf.f = __aeabi_fsub(af.f, bf.f); wf.f = af.f - bf.f; chk_f("fsub", af.u, bf.u, rf.u, wf.u);
            rf.f = __aeabi_fmul(af.f, bf.f); wf.f = af.f * bf.f; chk_f("fmul", af.u, bf.u, rf.u, wf.u);
            rf.f = __aeabi_fdiv(af.f, bf.f); wf.f = af.f / bf.f; chk_f("fdiv", af.u, bf.u, rf.u, wf.u);
            cmp_f(af.u, bf.u);
        }
    }

    /* f2d / d2f over the edge sets */
    for (i = 0; i < F_EDGE_N; i++) {
        af.u = F_EDGE[i];
        r.d = __aeabi_f2d(af.f); w.d = (double)af.f;
        chk_d("f2d", af.u, 0, r.u, w.u);
    }
    for (i = 0; i < D_EDGE_N; i++) {
        a.u = D_EDGE[i];
        rf.f = __aeabi_d2f(a.d); wf.f = (float)a.d;
        chk_f("d2f", a.u, 0, rf.u, wf.u);
        conv_d(a.d);
    }

    /* the ties that decide the rounding rule: 1.0 + 1ulp-half values.
     * (2^53+1) cannot be represented, so 1.0 + 2^-53 must round to 1.0,
     * and 1.0 + 3*2^-53 must round to 1.0+2^-52. */
    {
        u64 one = 0x3ff0000000000000ULL;
        u64 half_ulp = 0x3ca0000000000000ULL;   /* 2^-53 */
        u64 t;
        a.u = one; b.u = half_ulp;
        r.d = __aeabi_dadd(a.d, b.d); w.d = a.d + b.d;
        chk_d("tie-even", a.u, b.u, r.u, w.u);
        /* 1.0 + 1.5*2^-52 should round up (above the tie) */
        t = 0x3cb8000000000000ULL;              /* 1.5 * 2^-53 */
        b.u = t;
        r.d = __aeabi_dadd(a.d, b.d); w.d = a.d + b.d;
        chk_d("tie-up", a.u, b.u, r.u, w.u);
        /* 1.0 + 2^-52 + 2^-53: a tie that must round to even (up, to 1+2^-52) */
        b.u = 0x3cb0000000000000ULL;            /* 2^-52 */
        a.u = one;
        r.d = __aeabi_dadd(a.d, b.d); w.d = a.d + b.d;
        chk_d("tie-upto", a.u, b.u, r.u, w.u);
    }

    /* signed zero identities (documented, so pinned here explicitly) */
    {
        u64 pz = 0x0000000000000000ULL, nz = 0x8000000000000000ULL, got;
        a.u = pz; b.u = nz; got = ((dbl){.d = __aeabi_dadd(a.d, b.d)}).u;
        checks++; if (got != pz) fail("zero:+0+-0", pz, nz, got, pz);
        a.u = nz; b.u = nz; got = ((dbl){.d = __aeabi_dadd(a.d, b.d)}).u;
        checks++; if (got != nz) fail("zero:-0+-0", nz, nz, got, nz);
        a.u = 0x3ff0000000000000ULL; b.u = a.u;
        got = ((dbl){.d = __aeabi_dsub(a.d, b.d)}).u;
        checks++; if (got != pz) fail("zero:x-x", a.u, b.u, got, pz);
        /* float side */
        af.u = 0x00000000u; bf.u = 0x80000000u;
        checks++; if (((flt){.f = __aeabi_fadd(af.f, bf.f)}).u != 0x00000000u) fail("zero:f+", af.u, bf.u, 0, 0);
        bf.u = 0x80000000u;
        checks++; if (((flt){.f = __aeabi_fadd(bf.f, bf.f)}).u != 0x80000000u) fail("zero:f-", bf.u, bf.u, 0, 0);
    }
}

/* prints a value through both the runtime and the host, so a human reading
 * the log can see the diverging pattern instead of two hex numbers */
static void show(const char *op, u64 ab, u64 bb, u64 got, u64 want)
{
    dbl a, b, g, w;
    a.u = ab; b.u = bb; g.u = got; w.u = want;
    printf("    %s: %.17g op %.17g -> runtime %.17g host %.17g\n", op, a.d, b.d, g.d, w.d);
}

int main(int argc, char **argv)
{
    long n = (argc > 1) ? atol(argv[1]) : 200000;
    u64 seed = (argc > 2) ? strtoull(argv[2], 0, 0) : 0x9e3779b97f4a7c15ULL;
    long i;

    if (n <= 0) n = 200000;
    rnd_state = seed ? seed : 1;

    /* ---- oracle sanity: is this host rounding exactly once? ----------
     * 2^52 / DBL_MAX is just above the midpoint between 2^-972 and its
     * successor, so a single rounding must give ...001.  An x87 build gives
     * ...000 (double rounding).  Refusing to run beats producing a report
     * that blames the runtime for the compiler's code generation. */
    {
        volatile double na = 4503599627370496.0;      /* 2^52 */
        volatile double nb = 1.7976931348623157e308;  /* DBL_MAX */
        dbl o;
        o.d = na / nb;
        if (o.u != 0x0330000000000001ULL) {
            printf("ORACLE UNAVAILABLE: the host does not round once "
                   "(got %016llx, need 0330000000000001).\n"
                   "Rebuild with -msse2 -mfpmath=sse (32-bit x86 defaults to "
                   "x87, which rounds twice).\n",
                   (unsigned long long)o.u);
            return 2;
        }
    }

    printf("softfloat host differential: %ld pairs, seed %016llx\n",
           n, (unsigned long long)rnd_state);

    targeted();
    printf("  targeted edge matrix done (%ld checks so far)\n", checks);

    for (i = 0; i < n; i++) {
        u64 ab = gen_d(), bb = gen_d();
        dbl a, b, r, w;
        u32 af = gen_f(), bf = gen_f();
        flt fa, fb, fr, fw;

        a.u = ab; b.u = bb;
        r.d = __aeabi_dadd(a.d, b.d); w.d = a.d + b.d; chk_d("dadd", ab, bb, r.u, w.u);
        r.d = __aeabi_dsub(a.d, b.d); w.d = a.d - b.d; chk_d("dsub", ab, bb, r.u, w.u);
        r.d = __aeabi_dmul(a.d, b.d); w.d = a.d * b.d; chk_d("dmul", ab, bb, r.u, w.u);
        r.d = __aeabi_ddiv(a.d, b.d); w.d = a.d / b.d; chk_d("ddiv", ab, bb, r.u, w.u);
        cmp_d(ab, bb);

        fr.f = __aeabi_d2f(a.d); fw.f = (float)a.d; chk_f("d2f", ab, 0, fr.u, fw.u);

        fa.u = af; fb.u = bf;
        fr.f = __aeabi_fadd(fa.f, fb.f); fw.f = fa.f + fb.f; chk_f("fadd", af, bf, fr.u, fw.u);
        fr.f = __aeabi_fsub(fa.f, fb.f); fw.f = fa.f - fb.f; chk_f("fsub", af, bf, fr.u, fw.u);
        fr.f = __aeabi_fmul(fa.f, fb.f); fw.f = fa.f * fb.f; chk_f("fmul", af, bf, fr.u, fw.u);
        fr.f = __aeabi_fdiv(fa.f, fb.f); fw.f = fa.f / fb.f; chk_f("fdiv", af, bf, fr.u, fw.u);
        cmp_f(af, bf);

        r.d = __aeabi_f2d(fa.f); w.d = (double)fa.f; chk_d("f2d", af, 0, r.u, w.u);

        conv_d(a.d);
        conv_f(fa.f);
        conv_int(rnd64());

        if ((i % 50000) == 0 && i) printf("  ... %ld/%ld, %ld failures\n", i, n, failures);
    }

    /* a sample of diverging cases in decimal, for any human reading the log */
    if (failures) {
        u64 ab = D_EDGE[13], bb = D_EDGE[15];
        dbl a, b, r, w;
        a.u = ab; b.u = bb;
        r.d = __aeabi_dadd(a.d, b.d); w.d = a.d + b.d;
        show("sample dadd", ab, bb, r.u, w.u);
    }

    printf("host differential: %ld checks, %ld failures\n", checks, failures);
    if (failures) return 1;

    /* ---- anti-false-pass self check ---------------------------------
     * If the comparison helpers cannot notice a wrong answer, every run would
     * be green.  Feed them a value that is deliberately off and require them
     * to complain. */
    {
        long before = failures;
        u64 x = 0x3ff0000000000000ULL;          /* 1.0 */
        u64 y = 0x0000000000000001ULL;          /* min subnormal */
        u64 wrong = 0x4000000000000000ULL;      /* 2.0 -- not 1.0 + 2^-1074 */
        u64 right = ((dbl){.d = ((dbl){.u = x}).d + ((dbl){.u = y}).d}).u;
        chk_d("selftest", x, y, wrong, right);
        if (failures == before) {
            printf("SELF CHECK FAILED: the comparator accepted a wrong result\n");
            return 1;
        }
        printf("self check: comparator rejects a wrong answer (ok)\n");
        failures = before;                       /* that one was intentional */
    }

    printf("PASS: soft-float runtime matches the host on %ld checks\n", checks);
    return 0;
}