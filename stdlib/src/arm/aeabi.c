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
