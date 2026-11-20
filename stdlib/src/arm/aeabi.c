/* stdlib/src/arm/aeabi.c - 64-bit AEABI helpers for flat ("-o image.bin") ARM images
 *
 * Why this file exists
 * --------------------
 * A flat image has no linker and no library, so every helper the code
 * generator calls has to be inside the image.  The backend inlines 64-bit
 * add/sub and bitwise ops and uses the hardware SDIV/UDIV for 32-bit
 * division, but it deliberately does NOT hand-write 64-bit multiply, divide,
 * shift or compare helpers any more: the version that did produce five
 * classes of silent wrong answers and was removed rather than patched.  The
 * remaining calls are the standard AEABI names, so that the same .s output
 * also links against a real libgcc.a.  This file (plus aeabi_divmod.s) is the
 * "no library available" side of that contract.
 *
 * Why most of it is C and not assembly
 * ------------------------------------
 * Hand-written assembly cannot be checked by the compiler.  Everything here
 * is expressed with 32-bit operations only, which the backend already emits
 * correctly, so the helpers cannot recurse into themselves: 64-bit multiply
 * is four 16x16 partial products, 64-bit divide is a 64-iteration restoring
 * loop over 32-bit halves, 64-bit shifts are two 32-bit word shifts.  The one
 * exception is __aeabi_ldivmod/__aeabi_uldivmod, which must return the
 * quotient in r0:r1 AND the remainder in r2:r3 -- no portable C function can
 * return four registers, so those two live in aeabi_divmod.s (which in turn
 * calls the C helpers below; the assembly only marshals registers).
 *
 * How to use it
 * -------------
 *   arkcc -target arm -c -O2 stdlib/src/arm/aeabi.c        -o aeabi.obj
 *   arkcc -target arm -c     stdlib/src/arm/aeabi_divmod.s  -o aeabi_div.obj
 *   arkcc -target arm main.c aeabi.obj aeabi_div.obj --vector-table -o image.bin
 * The compiler never links this implicitly: an image that needs a helper and
 * does not provide it must fail to link (undefined reference), never run with
 * a guessed value.
 *
 * Division by zero: 64-bit helpers return 0 instead of trapping, matching the
 * "no exception model on bare metal" choice of the rest of the runtime.
 * Shifts by >= 64 (undefined behaviour in C) produce 0 / the sign fill rather
 * than reading a stale register.
 */

typedef unsigned int       u32;
typedef unsigned long long u64;

/* 64-bit <-> two 32-bit words.  The ARM backend stores a long long as two
 * little-endian words (low word first), which is what the union below reads;
 * tests/run_arm_int64_tests.py and tests/arm_exec (longlong64) check the
 * byte order by poking through an unsigned* and comparing halves. */
typedef union {
    u64 v;
    u32 w[2];
} u64pair;

static u32 lo32(u64 v)
{
    u64pair p;
    p.v = v;
    return p.w[0];
}

static u32 hi32(u64 v)
{
    u64pair p;
    p.v = v;
    return p.w[1];
}

static u64 mk64(u32 hi, u32 lo)
{
    u64pair p;
    p.w[0] = lo;
    p.w[1] = hi;
    return p.v;
}

/* Negate a 64-bit value given as two 32-bit words (two's complement, no
 * 64-bit operations, so this cannot call itself). */
static void neg64(u32 *hi, u32 *lo)
{
    u32 t = *lo;
    *lo = ~*lo + 1u;
    *hi = ~*hi + (t == 0 ? 1u : 0u);
}

/* Unsigned 64-bit divide with remainder, on 32-bit halves only.
 * Restoring division: shift the dividend out of the top and the quotient in
 * at the bottom, subtracting the divisor whenever the running remainder is
 * big enough.  clz-style shortcuts would be faster but need more of the
 * instruction set to be trusted than this loop does. */
static void udivmod64(u32 nh, u32 nl, u32 dh, u32 dl,
                      u32 *qh, u32 *ql, u32 *rh, u32 *rl)
{
    u32 qhi = 0, qlo = 0, rhi = 0, rlo = 0;
    int i;

    if (dh == 0 && dl == 0) {           /* division by zero: 0 remainder 0 */
        *qh = 0; *ql = 0; *rh = 0; *rl = 0;
        return;
    }
    for (i = 0; i < 64; i++) {
        /* r = (r << 1) | (n >> 63) */
        rhi = (rhi << 1) | (rlo >> 31);
        rlo = (rlo << 1) | (nh >> 31);
        /* n <<= 1 */
        nh = (nh << 1) | (nl >> 31);
        nl = nl << 1;
        /* q <<= 1 */
        qhi = (qhi << 1) | (qlo >> 31);
        qlo = qlo << 1;
        /* if (r >= d) { r -= d; q |= 1; } -- unsigned 64-bit compare done as
         * a 32-bit high-word compare plus a 32-bit low-word compare. */
        if (rhi > dh || (rhi == dh && rlo >= dl)) {
            u32 borrow = (rlo < dl) ? 1u : 0u;
            rlo = rlo - dl;
            rhi = rhi - dh - borrow;
            qlo = qlo | 1u;
        }
    }
    *qh = qhi; *ql = qlo; *rh = rhi; *rl = rlo;
}

/* Unsigned 64-bit multiply, low 64 bits: four 16x16 partial products.  A
 * 16x16 product always fits in 32 bits, so nothing here overflows. */
static void mul32x32(u32 a, u32 b, u32 *hi, u32 *lo)
{
    u32 a0 = a & 0xFFFFu, a1 = a >> 16;
    u32 b0 = b & 0xFFFFu, b1 = b >> 16;
    u32 p00 = a0 * b0, p01 = a0 * b1, p10 = a1 * b0, p11 = a1 * b1;
    u32 mid = (p00 >> 16) + (p01 & 0xFFFFu) + (p10 & 0xFFFFu);

    *lo = (p00 & 0xFFFFu) | (mid << 16);
    *hi = p11 + (p01 >> 16) + (p10 >> 16) + (mid >> 16);
}

/* ==== the helpers the backend calls ==================================== */

long long __aeabi_lmul(long long a, long long b)
{
    u32 al = lo32((u64)a), ah = hi32((u64)a);
    u32 bl = lo32((u64)b), bh = hi32((u64)b);
    u32 lo1, hi1, lo2, hi2, lo3, hi3;

    mul32x32(al, bl, &hi1, &lo1);       /* al*bl      -> contributes fully */
    mul32x32(al, bh, &hi2, &lo2);       /* al*bh << 32 -> low half only     */
    mul32x32(ah, bl, &hi3, &lo3);       /* ah*bl << 32 -> low half only     */
    (void)hi2; (void)hi3;               /* shifted out of the 64-bit result */

    return (long long)mk64(hi1 + lo2 + lo3, lo1);
}

/* Quotient only, unsigned.  Named __ark_* because AEABI has no "quotient
 * without remainder" entry point; __aeabi_uldivmod in aeabi_divmod.s uses
 * this and then recomputes the remainder from n - q*d. */
u64 __ark_udiv64(u64 n, u64 d)
{
    u32 qh, ql, rh, rl;

    udivmod64(hi32(n), lo32(n), hi32(d), lo32(d), &qh, &ql, &rh, &rl);
    (void)rh; (void)rl;
    return mk64(qh, ql);
}

/* Quotient only, signed.  C division truncates toward zero, which is exactly
 * "divide the magnitudes, then apply the sign" -- so no rounding fix-up is
 * needed (unlike a floor-based divider). */
long long __ark_ldiv64(long long n, long long d)
{
    u32 nh = hi32((u64)n), nl = lo32((u64)n);
    u32 dh = hi32((u64)d), dl = lo32((u64)d);
    u32 qh, ql, rh, rl;
    int neg = 0;

    if (nh >> 31) { neg = !neg; neg64(&nh, &nl); }
    if (dh >> 31) { neg = !neg; neg64(&dh, &dl); }
    udivmod64(nh, nl, dh, dl, &qh, &ql, &rh, &rl);
    (void)rh; (void)rl;
    if (neg) neg64(&qh, &ql);
    return (long long)mk64(qh, ql);
}

long long __aeabi_llsl(long long v, int n)
{
    u32 hi = hi32((u64)v), lo = lo32((u64)v);

    if (n <= 0) return v;
    if (n >= 64) return 0;
    if (n >= 32) {
        hi = lo << (n - 32);
        lo = 0;
    } else {
        hi = (hi << n) | (lo >> (32 - n));
        lo = lo << n;
    }
    return (long long)mk64(hi, lo);
}

unsigned long long __aeabi_llsr(unsigned long long v, int n)
{
    u32 hi = hi32(v), lo = lo32(v);

    if (n <= 0) return v;
    if (n >= 64) return 0;
    if (n >= 32) {
        lo = hi >> (n - 32);
        hi = 0;
    } else {
        lo = (lo >> n) | (hi << (32 - n));
        hi = hi >> n;
    }
    return mk64(hi, lo);
}

long long __aeabi_lasr(long long v, int n)
{
    u32 hi = hi32((u64)v), lo = lo32((u64)v);

    if (n <= 0) return v;
    if (n >= 64) n = 63;                /* keep the sign fill, no stale bits */
    if (n >= 32) {
        lo = (u32)((int)hi >> (n - 32));
        hi = (u32)((int)hi >> 31);
    } else {
        lo = (lo >> n) | (hi << (32 - n));
        hi = (u32)((int)hi >> n);
    }
    return (long long)mk64(hi, lo);
}

/* Returns -1 / 0 / 1 as the AEABI specifies. */
int __aeabi_lcmp(long long a, long long b)
{
    int ah = (int)hi32((u64)a), bh = (int)hi32((u64)b);
    u32 al = lo32((u64)a), bl = lo32((u64)b);

    if (ah < bh) return -1;
    if (ah > bh) return 1;
    if (al < bl) return -1;
    if (al > bl) return 1;
    return 0;
}

int __aeabi_ulcmp(unsigned long long a, unsigned long long b)
{
    u32 ah = hi32(a), bh = hi32(b);
    u32 al = lo32(a), bl = lo32(b);

    if (ah < bh) return -1;
    if (ah > bh) return 1;
    if (al < bl) return -1;
    if (al > bl) return 1;
    return 0;
}

/* ==== long long <-> floating point =====================================
 *
 * These are not optional on an ARMv7-M: VCVT converts between a
 * floating-point register and a *32-bit* integer only, so the backend emits
 * a call for every 64-bit integer / floating-point conversion even when the
 * FPU is on (see IR_64I2F / IR_64F2I in the ARM backend).  Without them a
 * perfectly ordinary `long long v = (long long)d;` fails to link, which is
 * what the H743 gate found.
 *
 * Both directions are built from 32-bit halves so that nothing here depends
 * on a 64-bit integer operation the backend does not already inline.
 *
 * Rounding: the AAED specifies round toward zero for the f -> int direction
 * and round to nearest (ties to even) for the int -> f direction.  The
 * u64 -> double path below gets the second one for free: 2^32 * hi is exact,
 * lo is exact, and a single addition rounds the exact sum once.
 */

/* Unsigned 64 -> double.  Exact inputs, one rounding step: correct. */
double __aeabi_ul2d(unsigned long long v)
{
    u32 hi = hi32(v), lo = lo32(v);
    double dhi = (double)hi;            /* u32 -> double is exact */

    if (hi == 0) return (double)lo;
    return dhi * 4294967296.0 + (double)lo;
}

/* Signed 64 -> double: negate the magnitude, then reuse the unsigned path
 * (0 - v is the magnitude even for the most negative value, because the
 * arithmetic is modulo 2^64). */
double __aeabi_l2d(long long v)
{
    if (v < 0) return -__aeabi_ul2d(0ULL - (unsigned long long)v);
    return __aeabi_ul2d((unsigned long long)v);
}

/* The float results go through the double path: converting to double first
 * is exact, so the only rounding is the final one.  That means these need
 * __aeabi_d2f / __aeabi_f2d, which are defined further down in this same
 * object -- a flat image takes every byte of every object it links, so an
 * object that *references* a helper has to *define* it, or every image that
 * links this file fails to link even when it never converts a float. */
float __aeabi_ul2f(unsigned long long v)
{
    return (float)__aeabi_ul2d(v);
}

float __aeabi_l2f(long long v)
{
    return (float)__aeabi_l2d(v);
}

/* double (already truncated toward zero) -> unsigned 64.  Splitting at 2^32
 * keeps every intermediate exact: h = trunc(d / 2^32) < 2^32, h * 2^32 has a
 * 32-bit significand, and d - h * 2^32 is an exact integer below 2^32. */
unsigned long long __aeabi_d2ulz(double d)
{
    double frac;
    u32 h, l;

    if (!(d > 0.0))                 /* NaN, +-0, or negative */
        return 0ULL;
    if (d >= 18446744073709551616.0) /* 2^64: outside the type */
        return ~0ULL;
    if (d < 4294967296.0)           /* whole value fits in the low word */
        return (unsigned long long)(u32)d;
    h = (u32)(d / 4294967296.0);
    frac = d - (double)h * 4294967296.0;
    l = (u32)frac;
    return ((unsigned long long)h << 32) | (unsigned long long)l;
}

/* Signed 64: the unsigned path on the magnitude, then negate.  -2^63 has no
 * positive counterpart, so it is answered directly. */
long long __aeabi_d2lz(double d)
{
    if (!(d > 0.0)) {
        if (d == 0.0) return 0;
        if (!(d < 0.0)) return 0;                        /* NaN */
        if (d <= -9223372036854775808.0)                 /* -2^63 (and below) */
            return (long long)0x8000000000000000ULL;
        return -(long long)__aeabi_d2ulz(-d);
    }
    if (d >= 9223372036854775808.0)                      /* 2^63 */
        return (long long)0x7FFFFFFFFFFFFFFFULL;
    return (long long)__aeabi_d2ulz(d);
}

/* float -> 64-bit: widening to double is exact, so it cannot change the
 * result of the truncating conversion. */
unsigned long long __aeabi_f2ulz(float f)
{
    return __aeabi_d2ulz((double)f);
}

long long __aeabi_f2lz(float f)
{
    return __aeabi_d2lz((double)f);
}

/* ==== float <-> double ==================================================
 *
 * Not here because a hardware-FPU build needs them: with VCVT.F32.F64 /
 * VCVT.F64.F32 available the backend emits the instruction (`--cpu
 * Cortex-M7` takes that path, g_arm_fpu_dp).  They are here because the
 * *software* path -- a single-precision-only FPU, and the host test gate,
 * which keeps the conservative path because unicorn cannot run FPU
 * instructions -- emits `BL __aeabi_f2d` / `BL __aeabi_d2f`, and the 64-bit
 * helpers above go through double: `__aeabi_ul2f` is
 * `(float)__aeabi_ul2d(v)` and `__aeabi_f2ulz` is
 * `__aeabi_d2ulz((double)f)`.
 *
 * Both functions work on bit patterns only, with no floating-point operation
 * at all, so a build whose core has no FPU can still execute them:
 *
 *   f2d  float -> double is exact (24 significant bits fit in 52) and every
 *        float is normal in double's exponent window, so this is a field
 *        shift with no rounding and no overflow.
 *
 *   d2f  needs round-to-nearest-even, overflow to infinity and gradual
 *        underflow into a subnormal float.  The 53-bit significand is
 *        shifted down to 24 bits with a guard/sticky round; for a subnormal
 *        result the shift grows by one bit per lost power of two, which
 *        makes the shifted-out value the integer significand itself.  A
 *        subnormal *double* is always below the smallest subnormal float, so
 *        it returns a signed zero.
 *
 * Correct rounding here is not cosmetic: `(float)(long long)` goes through
 * this path, and rounding twice (or truncating) would be a silent wrong
 * answer, which this project does not ship.
 */
typedef union { float f; u32 u; } f32bits;
typedef union { double d; u64 v; } f64bits;

/* m >> k, rounded to nearest with ties to even.  k >= 1.  The result is a u32
 * because every caller asks for at most 24 significant bits. */
static u32 rshift_rne(u64 m, int k)
{
    u64 q, half;

    if (k >= 64) {
        /* Only the leading bit can carry, and only when it is strictly above
         * the halfway point.  k == 64 with m == 2^63 is an exact tie, which
         * rounds to the even (zero) result. */
        return (k == 64 && m > 0x8000000000000000ULL) ? 1u : 0u;
    }
    q = m >> k;
    half = (u64)1 << (k - 1);
    if ((m - (q << k)) > half || ((m - (q << k)) == half && (q & 1)))
        q++;
    return (u32)q;
}

double __aeabi_f2d(float x)
{
    f32bits a;
    f64bits r;
    u32 sign, exp, man;
    int e;

    a.f = x;
    sign = a.u >> 31;
    exp  = (a.u >> 23) & 0xFF;
    man  = a.u & 0x7FFFFF;

    if (exp == 0xFF) {                  /* infinity or NaN: keep the payload */
        r.v = ((u64)sign << 63) | ((u64)0x7FF << 52) | ((u64)man << 29);
        return r.d;
    }
    if (exp == 0) {
        if (man == 0) {                 /* +-0 */
            r.v = (u64)sign << 63;
            return r.d;
        }
        /* Subnormal float: normalise until the hidden bit appears.  The
         * exponent really does go below 1, and double holds it. */
        e = 1;
        while ((man & 0x800000) == 0) { man <<= 1; e--; }
        man &= 0x7FFFFF;
    } else {
        e = (int)exp;
    }
    r.v = ((u64)sign << 63) | ((u64)(e + 896) << 52) | ((u64)man << 29);
    return r.d;
}

float __aeabi_d2f(double x)
{
    f64bits a;
    f32bits r;
    u64 sign, exp, man, mant;
    int e, k;
    u32 mf;

    a.d = x;
    sign = a.v >> 63;
    exp  = (a.v >> 52) & 0x7FF;
    man  = a.v & 0xFFFFFFFFFFFFFULL;

    if (exp == 0x7FF) {                 /* infinity or NaN */
        u32 q = (u32)(sign << 31) | 0x7F800000u | (u32)(man >> 29);
        if (!(man == 0) && (q & 0x7FFFFFFFu) == 0x7F800000u)
            q |= 0x00400000u;           /* a NaN must stay a NaN */
        r.u = q;
        return r.f;
    }
    if (exp == 0) {                     /* zero or subnormal double */
        r.u = (u32)(sign << 31);
        return r.f;
    }

    e = (int)exp - 1023;                /* value in [2^e, 2^(e+1)) */
    mant = man | ((u64)1 << 52);        /* 2^52 <= mant < 2^53 */

    if (e > 127) {                      /* beyond the float range */
        r.u = (u32)(sign << 31) | 0x7F800000u;
        return r.f;
    }

    k = 29;                             /* 52 - 23 bits: 24 to keep */
    if (e < -126)
        k += (-126 - e);                /* one more per lost power of two */
    mf = rshift_rne(mant, k);

    if (e < -126) {
        /* Subnormal result: mf is the integer significand (no hidden bit).
         * Rounding up to 0x800000 is the smallest *normal* float, and that
         * bit pattern is exactly what 0x800000 in this field means. */
        r.u = (u32)(sign << 31) | (mf & 0xFFFFFFu);
        return r.f;
    }
    if (mf >= 0x01000000u) {            /* rounding carried out of 24 bits */
        mf >>= 1;
        e++;
    }
    if (e > 127) {                      /* carried all the way to infinity */
        r.u = (u32)(sign << 31) | 0x7F800000u;
        return r.f;
    }
    r.u = (u32)(sign << 31) | ((u32)(e + 127) << 23) | (mf & 0x7FFFFFu);
    return r.f;
}
