/* stdlib/src/arm/aeabi_float.c - software floating point (AEABI) for ARM images
 *
 * Why this file exists
 * --------------------
 * On a core without an FPU (cortex-m0/m0plus/m1/m3, or an m4/m7 built with
 * -fpu=none) the backend emits the standard AEABI soft-float entry points for
 * every float/double operation, conversion and comparison.  Until now nothing
 * in this repository provided them: a flat image that did any floating point
 * arithmetic could not be linked at all, and on a board with no vendor runtime
 * there was nothing to link it against.  This file is that runtime.
 *
 * It is the floating-point twin of aeabi.c (64-bit integers): same contract,
 * same construction rules.
 *
 * How to use it
 * -------------
 *   arkcc -target arm -c -O2 stdlib/src/arm/aeabi_float.c -o aeabi_f.obj
 *   arkcc -target arm main.c aeabi_f.obj --vector-table -o image.bin
 * The compiler never links this implicitly: an image that needs a helper and
 * does not provide it must fail to link (undefined reference), never run with a
 * guessed value.
 *
 * How it is built (and why this way)
 * ----------------------------------
 * Nothing here is written in floating point -- if it were, the file would need
 * itself.  Everything is integer arithmetic on the IEEE-754 bit patterns:
 *
 *   - 32-bit operations only, plus `unsigned long long` used purely as a
 *     64-bit integer register.  64-bit add/sub/and/or are emitted inline by
 *     the backend; every 64-bit shift and compare is written out below on
 *     32-bit halves, so this file does not depend on aeabi.c either.
 *   - no recursion: a helper may call the static functions in this file, and
 *     nothing else.
 *   - one rounding step.  The exact result is carried as
 *
 *         V  = significand << 3          (three extra bits: guard, round, low)
 *         res = which side of V the exact value lies on
 *
 *     and rounded once, at the end, after the result has been placed at its
 *     final exponent (including a subnormal one).  Rounding twice is the
 *     classic way to produce a result one ulp off, so there is exactly one
 *     place in this file that rounds (round_sig()).
 *
 * The `res` invariant
 * -------------------
 * V is always *truncated*: either an operand was shifted right and bits fell
 * off, or a product/quotient was cut down to V's width.  So the exact value x
 * satisfies  V - 1 < x < V + 1  (in units of V's least significant bit), and
 * `res` records on which side: +1 for x > V, -1 for x < V, 0 for x == V.
 * Rounding then only needs `res` at an exact tie (V's low three bits == 100):
 *   - res == 0  -> round to even,
 *   - res >  0  -> x is above the midpoint, round up,
 *   - res <  0  -> x is below the midpoint, round down.
 * Away from a tie the three extra bits alone decide.  A right shift folds the
 * bit it drops into `res` (see normalize()), which keeps the invariant.
 *
 * Behaviour a caller may rely on
 * ------------------------------
 *   - round to nearest, ties to even -- the same mode the hardware FPUs and
 *     armcc's own runtime use;
 *   - a NaN operand, or an invalid operation (inf - inf, inf * 0, 0 / 0,
 *     inf / inf), produces the canonical quiet NaN (exponent all ones, top
 *     fraction bit set, sign 0).  Sign and payload of an input NaN are *not*
 *     propagated -- documenting that is cheaper than carrying payloads no
 *     caller in this project has ever looked at;
 *   - a float -> integer conversion saturates (like the hardware VCVT that
 *     armcc's runtime uses) and a NaN converts to 0.  C calls that undefined;
 *     a defined, documentable answer beats reading a stale register;
 *   - division by zero follows IEEE-754: +/-inf, and NaN for 0/0;
 *   - the sign of a zero result follows IEEE-754: (+0) + (-0) = +0,
 *     (-0) + (-0) = -0, x - x = +0.
 */

typedef unsigned int       u32;
typedef unsigned long long u64;

/* 64-bit <-> two 32-bit words.  The ARM backend stores a long long as two
 * little-endian words (low word first); this union reads them that way and is
 * the same trick aeabi.c uses, so the two files agree on the storage order. */
typedef union {
    u64 v;
    u32 w[2];
} u64pair;

static u32 lo32(u64 v) { u64pair p; p.v = v; return p.w[0]; }
static u32 hi32(u64 v) { u64pair p; p.v = v; return p.w[1]; }

static u64 mk64(u32 hi, u32 lo)
{
    u64pair p;
    p.w[0] = lo;
    p.w[1] = hi;
    return p.v;
}

/* ==== 64-bit primitives the backend would otherwise turn into calls ===== */

static u64 shl64(u64 v, int n)
{
    u32 hi = hi32(v), lo = lo32(v);

    if (n <= 0) return v;
    if (n >= 64) return mk64(0, 0);
    if (n >= 32) return mk64(lo << (n - 32), 0);
    return mk64((hi << n) | (lo >> (32 - n)), lo << n);
}

static u64 shr64(u64 v, int n)
{
    u32 hi = hi32(v), lo = lo32(v);

    if (n <= 0) return v;
    if (n >= 64) return mk64(0, 0);
    if (n >= 32) return mk64(0, hi >> (n - 32));
    return mk64(hi >> n, (lo >> n) | (hi << (32 - n)));
}

static int zero64(u64 v) { return hi32(v) == 0 && lo32(v) == 0; }

/* Unsigned compare: 1 when a >= b.  Written out because `a >= b` on a long
 * long would be a call to __aeabi_ulcmp, i.e. a dependency this file does not
 * want. */
static int ge64(u64 a, u64 b)
{
    u32 ah = hi32(a), bh = hi32(b);

    if (ah != bh) return ah > bh;
    return lo32(a) >= lo32(b);
}

static int lt64(u64 a, u64 b) { return !ge64(a, b); }

/* Number of significant bits (0 for zero). */
static int bitlen64(u64 v)
{
    u32 hi = hi32(v), x;
    int n = 0;

    if (hi) { x = hi; n = 32; } else { x = lo32(v); }
    while (x) { x >>= 1; n++; }
    return n;
}

/* Right shift that reports whether anything was lost.  Every shift that could
 * drop a bit goes through here, because a dropped bit is exactly what `res`
 * has to know about. */
static u64 shr64_sticky(u64 v, int n, int *sticky)
{
    if (n <= 0) return v;
    if (n >= 64) {
        if (!zero64(v)) *sticky = 1;
        return mk64(0, 0);
    }
    if (n < 32) {
        if (lo32(v) & ((1u << n) - 1u)) *sticky = 1;
    } else if (n > 32) {
        if (lo32(v) != 0 || (hi32(v) & ((1u << (n - 32)) - 1u))) *sticky = 1;
    } else {
        if (lo32(v) != 0) *sticky = 1;
    }
    return shr64(v, n);
}

/* Unsigned 32x32 -> 64: four 16x16 partial products, so nothing can overflow
 * a 32-bit intermediate.  Same construction as aeabi.c. */
static void mul32x32(u32 a, u32 b, u32 *phi, u32 *plo)
{
    u32 a0 = a & 0xFFFFu, a1 = a >> 16;
    u32 b0 = b & 0xFFFFu, b1 = b >> 16;
    u32 p00 = a0 * b0, p01 = a0 * b1, p10 = a1 * b0, p11 = a1 * b1;
    u32 mid = (p00 >> 16) + (p01 & 0xFFFFu) + (p10 & 0xFFFFu);

    *plo = (p00 & 0xFFFFu) | (mid << 16);
    *phi = p11 + (p01 >> 16) + (p10 >> 16) + (mid >> 16);
}

/* Full 128-bit product of two 64-bit values, as a high/low pair.  Only the
 * parts that can survive are accumulated: for mantissas of at most 53 bits the
 * product is at most 106 bits, so the two "shifted by 64" terms only need
 * their low halves. */
static void mul64_full(u64 a, u64 b, u64 *hi, u64 *lo)
{
    u64 p00, p01, p10, p11, t, u, l, carry = 0, sum;
    u32 h, lw;

    mul32x32(lo32(a), lo32(b), &h, &lw); p00 = mk64(h, lw);
    mul32x32(lo32(a), hi32(b), &h, &lw); p01 = mk64(h, lw);
    mul32x32(hi32(a), lo32(b), &h, &lw); p10 = mk64(h, lw);
    mul32x32(hi32(a), hi32(b), &h, &lw); p11 = mk64(h, lw);

    /* Column addition: the two cross products contribute their low halves to
     * the low word and their high halves to the high word. */
    t = shl64(p01, 32);
    u = shl64(p10, 32);
    l = p00 + t;
    carry = lt64(l, p00) ? 1 : 0;        /* wrapped? p00 + t < p00 */
    sum = l + u;
    carry = carry + (lt64(sum, l) ? 1 : 0);
    l = sum;

    *lo = l;
    *hi = p11 + shr64(p01, 32) + shr64(p10, 32) + carry;
}

/* ==== the two formats ================================================== */

#define F32_MB    24      /* mantissa bits including the implicit one */
#define F32_EB    8       /* exponent field width */
#define F32_BIAS  127
#define F64_MB    53
#define F64_EB    11
#define F64_BIAS  1023

/* A number taken apart.  `cls`: 0 zero, 1 finite non-zero, 2 infinity, 3 NaN.
 * For cls 1, value = m * 2^(exp - BIAS - (MB-1)); a subnormal has exp == 1 and
 * m without the implicit bit, which makes the same formula hold for it. */
typedef struct {
    int sign;
    int cls;
    int exp;
    u64 m;
} fnum;

static int fmt_maxe(int ebits) { return (int)((1u << ebits) - 1u); }

static fnum unpack(u64 bits, int ebits, int mb)
{
    fnum r;
    int fb = mb - 1;
    u32 e = (u32)(lo32(shr64(bits, fb)) & ((1u << ebits) - 1u));
    u64 frac = bits & (shl64(1u, fb) - 1u);

    r.sign = (int)(lo32(shr64(bits, ebits + fb)) & 1u);
    r.exp = 0;
    r.m = 0;

    if ((int)e == fmt_maxe(ebits)) {
        r.cls = zero64(frac) ? 2 : 3;
        return r;
    }
    if (e == 0) {
        if (zero64(frac)) { r.cls = 0; return r; }
        r.cls = 1;
        r.exp = 1;                      /* subnormal: same scale as exp 1 */
        r.m = frac;
        return r;
    }
    r.cls = 1;
    r.exp = (int)e;
    r.m = frac | shl64(1u, fb);
    return r;
}

static u64 pack(fnum v, int ebits, int mb)
{
    int fb = mb - 1;
    u64 sign = shl64((u64)(u32)v.sign, ebits + fb);

    if (v.cls == 3) {
        /* Canonical quiet NaN: all ones exponent, top fraction bit set. */
        return sign | shl64((u64)(u32)fmt_maxe(ebits), fb) | shl64(1u, fb - 1);
    }
    if (v.cls == 2) return sign | shl64((u64)(u32)fmt_maxe(ebits), fb);
    if (v.cls == 0) return sign;
    {
        u64 imp = shl64(1u, fb);

        if (ge64(v.m, imp)) return sign | shl64((u64)(u32)v.exp, fb) | (v.m - imp);
        return sign | v.m;              /* subnormal: exponent field 0 */
    }
}

/* ==== normalize, round, finish ======================================== */

/* Shift V so that its implicit bit lands at bit mb+2 (V is `significand << 3`,
 * so that is mb+3 bits wide), adjusting exp with it.  A shift right drops a bit
 * into the residual; a shift left never loses anything.
 *
 * Whether the right shift runs at all depends on how a caller built V: an add
 * can carry into bit mb+3, a product can land one bit high.  The left shift
 * runs while the result is denormalized and the exponent has not bottomed out
 * at 1 -- once exp == 1 the scale is fixed and a short mantissa *is* the
 * subnormal representation, which is why the loop simply stops there. */
static u64 normalize(u64 V, int *res, int *exp, int mb)
{
    u64 one = shl64(1u, mb + 3);
    u64 imp = shl64(1u, mb + 2);

    while (ge64(V, one)) {
        int bit = (int)(lo32(V) & 1u);

        V = shr64(V, 1);
        if (bit) *res = 1;              /* x > V stays true; a 0 bit keeps res */
        (*exp)++;
    }
    /* exp below 1 means the result is subnormal in the target format: the
     * scale cannot go any lower, so the significand gives up bits instead.
     * Every dropped bit goes into `res`, so the single rounding step still
     * knows whether the value is above the last kept unit. */
    while (*exp < 1) {
        int bit = (int)(lo32(V) & 1u);

        V = shr64(V, 1);
        if (bit) *res = 1;
        (*exp)++;
        if (zero64(V)) { *exp = 1; break; }
    }
    while (*exp > 1 && lt64(V, imp)) {
        V = shl64(V, 1);
        (*exp)--;
    }
    return V;
}

/* The only place in this file that rounds. */
static u64 round_sig(u64 V, int res, int mb, int *exp)
{
    u64 mant = shr64(V, 3);
    u32 frac = lo32(V) & 7u;
    int up = 0;

    if (frac > 4u) {
        up = 1;
    } else if (frac == 4u) {
        if (res == 0) up = (int)(lo32(mant) & 1u);   /* exact tie: to even */
        else          up = (res > 0);
    }
    if (up) {
        mant = mant + 1u;
        if (ge64(mant, shl64(1u, mb))) {   /* carry out of the mantissa */
            mant = shr64(mant, 1);
            (*exp)++;
        }
    }
    return mant;
}

/* Round, apply overflow, pack.  Every arithmetic result ends here. */
static u64 finish(int sign, int exp, u64 V, int res, int ebits, int mb)
{
    fnum r;
    u64 mant;

    r.sign = sign;
    r.exp = 0;
    r.m = 0;
    if (zero64(V)) { r.cls = 0; return pack(r, ebits, mb); }

    mant = round_sig(V, res, mb, &exp);
    if (exp >= fmt_maxe(ebits)) { r.cls = 2; return pack(r, ebits, mb); }
    if (zero64(mant)) { r.cls = 0; return pack(r, ebits, mb); }
    r.cls = 1;
    r.exp = exp;
    r.m = mant;
    return pack(r, ebits, mb);
}

/* `sign` is the sign of V.  x > V when res > 0, x < V when res < 0. */
static u64 finish_signed(int sign, int exp, u64 V, int res, int ebits, int mb)
{
    return finish(sign, exp, V, res, ebits, mb);
}

/* ==== addition and subtraction ======================================== */

static u64 add_bits(u64 ab, u64 bb, int ebits, int mb)
{
    fnum a = unpack(ab, ebits, mb);
    fnum b = unpack(bb, ebits, mb);
    fnum r;
    u64 A, B, V;
    int d, res = 0, exp, sign, lost = 0;

    if (a.cls == 3 || b.cls == 3) { r.sign = 0; r.cls = 3; r.exp = 0; r.m = 0;
                                    return pack(r, ebits, mb); }
    if (a.cls == 2 || b.cls == 2) {
        if (a.cls == 2 && b.cls == 2 && a.sign != b.sign) {
            r.sign = 0; r.cls = 3; r.exp = 0; r.m = 0;
            return pack(r, ebits, mb);          /* inf - inf */
        }
        if (a.cls == 2) return pack(a, ebits, mb);
        return pack(b, ebits, mb);
    }
    if (a.cls == 0 && b.cls == 0) {
        /* (+0) + (+0) = +0, (-0) + (-0) = -0, mixed = +0. */
        r.sign = (a.sign == b.sign) ? a.sign : 0;
        r.cls = 0; r.exp = 0; r.m = 0;
        return pack(r, ebits, mb);
    }
    if (a.cls == 0) return pack(b, ebits, mb);
    if (b.cls == 0) return pack(a, ebits, mb);

    /* Order by exponent so that only b is shifted (and only b loses bits). */
    if (a.exp < b.exp) { fnum t = a; a = b; b = t; }
    d = a.exp - b.exp;
    exp = a.exp;
    sign = a.sign;

    A = shl64(a.m, 3);
    B = shl64(b.m, 3);
    if (d >= 64) {
        lost = !zero64(B);
        B = mk64(0, 0);
    } else {
        B = shr64_sticky(B, d, &lost);
    }

    if (a.sign == b.sign) {
        V = A + B;
        res = lost ? 1 : 0;             /* sum of truncated operands is low */
    } else if (ge64(A, B)) {
        V = A - B;
        res = lost ? -1 : 0;            /* differ by less than one unit */
    } else {
        V = B - A;
        sign = b.sign;
        res = lost ? -1 : 0;
    }
    if (zero64(V) && res == 0) {
        r.sign = 0;                     /* x - x is +0 in round-to-nearest */
        r.cls = 0; r.exp = 0; r.m = 0;
        return pack(r, ebits, mb);
    }

    V = normalize(V, &res, &exp, mb);
    return finish_signed(sign, exp, V, res, ebits, mb);
}

static u64 sub_bits(u64 ab, u64 bb, int ebits, int mb)
{
    /* Flip b's sign and add.  A NaN keeps its class either way, so the flip is
     * harmless for every input. */
    u64 flip = shl64(1u, ebits + mb - 1);

    return add_bits(ab, bb ^ flip, ebits, mb);
}

/* ==== multiplication ================================================== */

/* Widen a finite non-zero significand to the full mb bits by shifting it left
 * and lowering the exponent.  The value is unchanged -- value =
 * m * 2^(exp - BIAS - (mb-1)) does not require exp >= 1, which is why a
 * subnormal can be described either as a short mantissa at exp 1 or as a full
 * mantissa at a lower exponent.  mul/div need the second form: with both
 * operands full width the product/quotient lands in a known window, and the
 * result never has to be shifted up by dozens of bits (which would push the
 * exponent far below what the format can hold). */
static fnum widen(fnum a, int mb)
{
    int len;

    if (a.cls != 1) return a;
    len = bitlen64(a.m);
    if (len < mb) {
        a.m = shl64(a.m, mb - len);
        a.exp -= (mb - len);
    }
    return a;
}

static u64 mul_bits(u64 ab, u64 bb, int ebits, int mb, int bias)
{
    fnum a = unpack(ab, ebits, mb);
    fnum b = unpack(bb, ebits, mb);
    fnum r;
    u64 phi, plo, V;
    int res = 0, exp, sign;

    if (a.cls == 3 || b.cls == 3) { r.sign = 0; r.cls = 3; r.exp = 0; r.m = 0;
                                    return pack(r, ebits, mb); }
    sign = a.sign ^ b.sign;
    if (a.cls == 2 || b.cls == 2) {
        /* inf * 0 is invalid. */
        if ((a.cls == 2 && b.cls == 0) || (b.cls == 2 && a.cls == 0)) {
            r.sign = 0; r.cls = 3; r.exp = 0; r.m = 0;
            return pack(r, ebits, mb);
        }
        r.sign = sign; r.cls = 2; r.exp = 0; r.m = 0;
        return pack(r, ebits, mb);
    }
    if (a.cls == 0 || b.cls == 0) {
        r.sign = sign; r.cls = 0; r.exp = 0; r.m = 0;
        return pack(r, ebits, mb);
    }

    a = widen(a, mb);
    b = widen(b, mb);
    mul64_full(a.m, b.m, &phi, &plo);
    /* V = P >> (mb-3): mb+3 bits, guard bits included. */
    {
        int k = mb - 3;

        V = shr64_sticky(plo, k, &res);
        V = V | shl64(phi, 64 - k);
        res = res ? 1 : 0;              /* truncation: the exact value is above */
    }
    exp = a.exp + b.exp - bias + 1;
    V = normalize(V, &res, &exp, mb);
    return finish_signed(sign, exp, V, res, ebits, mb);
}

/* ==== division ======================================================== */

static u64 div_bits(u64 ab, u64 bb, int ebits, int mb, int bias)
{
    fnum a = unpack(ab, ebits, mb);
    fnum b = unpack(bb, ebits, mb);
    fnum r;
    u64 rem, q, V;
    int i, bit, res, exp, sign;

    if (a.cls == 3 || b.cls == 3) { r.sign = 0; r.cls = 3; r.exp = 0; r.m = 0;
                                    return pack(r, ebits, mb); }
    sign = a.sign ^ b.sign;
    if (a.cls == 2) {
        if (b.cls == 2) {                       /* inf / inf */
            r.sign = 0; r.cls = 3; r.exp = 0; r.m = 0;
            return pack(r, ebits, mb);
        }
        r.sign = sign; r.cls = 2; r.exp = 0; r.m = 0;
        return pack(r, ebits, mb);
    }
    if (b.cls == 2) {                           /* finite / inf = signed zero */
        r.sign = sign; r.cls = 0; r.exp = 0; r.m = 0;
        return pack(r, ebits, mb);
    }
    if (b.cls == 0) {
        if (a.cls == 0) {                       /* 0 / 0 */
            r.sign = 0; r.cls = 3; r.exp = 0; r.m = 0;
            return pack(r, ebits, mb);
        }
        r.sign = sign; r.cls = 2; r.exp = 0; r.m = 0;   /* x / 0 */
        return pack(r, ebits, mb);
    }
    if (a.cls == 0) {
        r.sign = sign; r.cls = 0; r.exp = 0; r.m = 0;
        return pack(r, ebits, mb);
    }

    a = widen(a, mb);
    b = widen(b, mb);

    /* Restoring division.  Both operands are full width, so ma/mb lies in
     * (1/2, 2): one leading subtraction takes the 1 in front away and leaves
     * ma < mb, which is what the loop's invariant needs.  The loop then
     * appends mb+4 fraction bits, i.e.
     *
     *     q = floor(ma * 2^(mb+4) / mb)      (mb+4 or mb+5 bits)
     *
     * and normalize() shifts the occasional extra bit back out.  The running
     * remainder stays below mb, so it always fits in 64 bits. */
    rem = a.m;
    q = mk64(0, 0);
    if (ge64(rem, b.m)) {
        rem = rem - b.m;
        q = mk64(0, 1);
    }
    for (i = 0; i < mb + 4; i++) {
        rem = shl64(rem, 1);
        bit = ge64(rem, b.m);
        if (bit) rem = rem - b.m;
        q = shl64(q, 1) | mk64(0, (u32)(bit != 0));
    }
    V = q;
    res = zero64(rem) ? 0 : 1;          /* quotient truncated: exact is above */
    exp = a.exp - b.exp + bias - 2;
    V = normalize(V, &res, &exp, mb);
    return finish_signed(sign, exp, V, res, ebits, mb);
}

/* ==== comparison ====================================================== */

/* -2 = unordered, otherwise -1 / 0 / 1. */
static int cmp_bits(u64 ab, u64 bb, int ebits, int mb)
{
    fnum a = unpack(ab, ebits, mb);
    fnum b = unpack(bb, ebits, mb);
    int m;

    if (a.cls == 3 || b.cls == 3) return -2;
    if (a.cls == 0 && b.cls == 0) return 0;             /* +0 == -0 */
    if (a.cls == 0) return b.sign ? 1 : -1;
    if (b.cls == 0) return a.sign ? -1 : 1;
    if (a.cls == 2 || b.cls == 2) {
        if (a.cls == 2 && b.cls == 2) {
            if (a.sign == b.sign) return 0;
            return a.sign ? -1 : 1;
        }
        if (a.cls == 2) return a.sign ? -1 : 1;
        return b.sign ? 1 : -1;
    }
    if (a.sign != b.sign) return a.sign ? -1 : 1;
    if (a.exp != b.exp) m = (a.exp < b.exp) ? -1 : 1;
    else if (lt64(a.m, b.m)) m = -1;
    else if (lt64(b.m, a.m)) m = 1;
    else m = 0;
    return a.sign ? -m : m;
}

/* ==== conversions ===================================================== */

/* Build a result from a mantissa of `mb_src` significant bits whose value is
 * m * 2^(exp - bias_src - (mb_src-1)) -- i.e. the same shape as fnum, but for a
 * source format that may be wider (double -> float) or narrower (float ->
 * double, integer -> float).  `exp` is already expressed in the *target*
 * format's bias. */
static u64 assemble(int sign, int exp, u64 m, int mb_src, int mb, int ebits)
{
    int res = 0;
    u64 V;

    if (zero64(m)) return finish(sign, 0, mk64(0, 0), 0, ebits, mb);
    if (mb_src > mb + 3) {
        /* Keep mb+3 bits, i.e. the mantissa plus the three guard bits: the
         * guard bits have to be the source's real low bits, otherwise the one
         * rounding step sees frac == 0 and can never round up. */
        V = shr64_sticky(m, mb_src - (mb + 3), &res);
        res = res ? 1 : 0;
    } else if (mb_src > mb) {
        V = shl64(m, (mb + 3) - mb_src);
    } else {
        V = shl64(m, (mb - mb_src) + 3);
    }
    V = normalize(V, &res, &exp, mb);
    /* The value may be below the target's smallest subnormal (a double
     * subnormal converted to float, say): shift it down to the subnormal
     * scale, folding every dropped bit into the residual, and let the one
     * rounding step decide between zero and the smallest subnormal. */
    while (exp < 1) {
        int lost = 0;
        u32 bit = lo32(V) & 1u;

        V = shr64_sticky(V, 1, &lost);
        if (bit) res = 1;
        else if (lost) res = (res < 0) ? -1 : 1;
        exp++;
    }
    return finish_signed(sign, exp, V, res, ebits, mb);
}

/* Unsigned magnitude -> floating point. */
static u64 u64_to_fp(u64 u, int sign, int ebits, int mb, int bias)
{
    int p, exp, res = 0;
    u64 V;

    if (zero64(u)) return finish(sign, 0, mk64(0, 0), 0, ebits, mb);
    p = bitlen64(u) - 1;
    exp = p + bias;
    if (p > mb + 2) V = shr64_sticky(u, p - (mb + 2), &res);
    else            V = shl64(u, (mb + 2) - p);
    res = res ? 1 : 0;                  /* bits dropped: exact value is above */
    V = normalize(V, &res, &exp, mb);
    return finish_signed(sign, exp, V, res, ebits, mb);
}

/* Floating point -> unsigned magnitude, saturating at `bits` bits.  `neg` is
 * filled with the value's sign; a NaN yields 0 with neg = 0. */
static u64 fp_to_u64(u64 bits, int ebits, int mb, int bias, int width, int *neg)
{
    fnum a = unpack(bits, ebits, mb);
    int s;
    u64 mag;

    *neg = 0;
    if (a.cls == 3) return mk64(0, 0);            /* NaN -> 0 */
    if (a.cls == 2) { *neg = a.sign; return mk64(0xFFFFFFFFu, 0xFFFFFFFFu); }
    if (a.cls == 0) return mk64(0, 0);
    s = a.exp - bias - (mb - 1);
    if (s >= 0) {
        if (s + bitlen64(a.m) > width) {
            *neg = a.sign;
            return mk64(0xFFFFFFFFu, 0xFFFFFFFFu);
        }
        mag = shl64(a.m, s);
    } else {
        if (-s >= 64) return mk64(0, 0);
        mag = shr64(a.m, -s);           /* truncation toward zero */
    }
    *neg = a.sign;
    return mag;
}

/* ==== the AEABI entry points ========================================== */

typedef union { double d; u64 u; } dbl;
typedef union { float  f; u32 u; } flt;

#define D_ADD(a, b) add_bits((a).u, (b).u, F64_EB, F64_MB)
#define D_SUB(a, b) sub_bits((a).u, (b).u, F64_EB, F64_MB)
#define D_MUL(a, b) mul_bits((a).u, (b).u, F64_EB, F64_MB, F64_BIAS)
#define D_DIV(a, b) div_bits((a).u, (b).u, F64_EB, F64_MB, F64_BIAS)
#define F_ADD(a, b) add_bits((u64)(a).u, (u64)(b).u, F32_EB, F32_MB)
#define F_SUB(a, b) sub_bits((u64)(a).u, (u64)(b).u, F32_EB, F32_MB)
#define F_MUL(a, b) mul_bits((u64)(a).u, (u64)(b).u, F32_EB, F32_MB, F32_BIAS)
#define F_DIV(a, b) div_bits((u64)(a).u, (u64)(b).u, F32_EB, F32_MB, F32_BIAS)

double __aeabi_dadd(double x, double y)
{
    dbl a, b, r;
    a.d = x; b.d = y; r.u = D_ADD(a, b);
    return r.d;
}

double __aeabi_dsub(double x, double y)
{
    dbl a, b, r;
    a.d = x; b.d = y; r.u = D_SUB(a, b);
    return r.d;
}

double __aeabi_dmul(double x, double y)
{
    dbl a, b, r;
    a.d = x; b.d = y; r.u = D_MUL(a, b);
    return r.d;
}

double __aeabi_ddiv(double x, double y)
{
    dbl a, b, r;
    a.d = x; b.d = y; r.u = D_DIV(a, b);
    return r.d;
}

float __aeabi_fadd(float x, float y)
{
    flt a, b, r;
    a.f = x; b.f = y; r.u = (u32)F_ADD(a, b);
    return r.f;
}

float __aeabi_fsub(float x, float y)
{
    flt a, b, r;
    a.f = x; b.f = y; r.u = (u32)F_SUB(a, b);
    return r.f;
}

float __aeabi_fmul(float x, float y)
{
    flt a, b, r;
    a.f = x; b.f = y; r.u = (u32)F_MUL(a, b);
    return r.f;
}

float __aeabi_fdiv(float x, float y)
{
    flt a, b, r;
    a.f = x; b.f = y; r.u = (u32)F_DIV(a, b);
    return r.f;
}

/* Comparisons.  AEABI spells these as int-returning predicates; NaN makes all
 * of them false except "ne". */
#define D_CMP(x, y) cmp_bits((x).u, (y).u, F64_EB, F64_MB)
#define F_CMP(x, y) cmp_bits((u64)(x).u, (u64)(y).u, F32_EB, F32_MB)

int __aeabi_dcmpeq(double x, double y) { dbl a, b; a.d = x; b.d = y; return D_CMP(a,b) == 0; }
int __aeabi_dcmpne(double x, double y) { dbl a, b; a.d = x; b.d = y; return D_CMP(a,b) != 0; }
int __aeabi_dcmplt(double x, double y) { dbl a, b; a.d = x; b.d = y; return D_CMP(a,b) == -1; }
int __aeabi_dcmple(double x, double y) { dbl a, b; a.d = x; b.d = y; { int c = D_CMP(a,b); return c == 0 || c == -1; } }
int __aeabi_dcmpgt(double x, double y) { dbl a, b; a.d = x; b.d = y; return D_CMP(a,b) == 1; }
int __aeabi_dcmpge(double x, double y) { dbl a, b; a.d = x; b.d = y; { int c = D_CMP(a,b); return c == 0 || c == 1; } }

int __aeabi_fcmpeq(float x, float y) { flt a, b; a.f = x; b.f = y; return F_CMP(a,b) == 0; }
int __aeabi_fcmpne(float x, float y) { flt a, b; a.f = x; b.f = y; return F_CMP(a,b) != 0; }
int __aeabi_fcmplt(float x, float y) { flt a, b; a.f = x; b.f = y; return F_CMP(a,b) == -1; }
int __aeabi_fcmple(float x, float y) { flt a, b; a.f = x; b.f = y; { int c = F_CMP(a,b); return c == 0 || c == -1; } }
int __aeabi_fcmpgt(float x, float y) { flt a, b; a.f = x; b.f = y; return F_CMP(a,b) == 1; }
int __aeabi_fcmpge(float x, float y) { flt a, b; a.f = x; b.f = y; { int c = F_CMP(a,b); return c == 0 || c == 1; } }

/* int -> floating point. */
double __aeabi_i2d(int n)
{
    dbl r;
    u64 u = (u64)(u32)(n < 0 ? (int)(0u - (u32)n) : n);

    r.u = u64_to_fp(u, n < 0, F64_EB, F64_MB, F64_BIAS);
    return r.d;
}

double __aeabi_ui2d(unsigned int n)
{
    dbl r;

    r.u = u64_to_fp((u64)n, 0, F64_EB, F64_MB, F64_BIAS);
    return r.d;
}

double __aeabi_l2d(long long n)
{
    dbl r;
    u64 u = (u64)n;
    int neg = (int)(hi32(u) >> 31);

    if (neg) u = mk64(0, 0) - u;
    r.u = u64_to_fp(u, neg, F64_EB, F64_MB, F64_BIAS);
    return r.d;
}

double __aeabi_ul2d(unsigned long long n)
{
    dbl r;

    r.u = u64_to_fp(n, 0, F64_EB, F64_MB, F64_BIAS);
    return r.d;
}

float __aeabi_i2f(int n)
{
    flt r;
    u64 u = (u64)(u32)(n < 0 ? (int)(0u - (u32)n) : n);

    r.u = (u32)u64_to_fp(u, n < 0, F32_EB, F32_MB, F32_BIAS);
    return r.f;
}

float __aeabi_ui2f(unsigned int n)
{
    flt r;

    r.u = (u32)u64_to_fp((u64)n, 0, F32_EB, F32_MB, F32_BIAS);
    return r.f;
}

float __aeabi_l2f(long long n)
{
    flt r;
    u64 u = (u64)n;
    int neg = (int)(hi32(u) >> 31);

    if (neg) u = mk64(0, 0) - u;
    r.u = (u32)u64_to_fp(u, neg, F32_EB, F32_MB, F32_BIAS);
    return r.f;
}

float __aeabi_ul2f(unsigned long long n)
{
    flt r;

    r.u = (u32)u64_to_fp(n, 0, F32_EB, F32_MB, F32_BIAS);
    return r.f;
}

/* floating point -> int, saturating. */
int __aeabi_d2iz(double x)
{
    dbl a;
    int neg;
    u64 mag;

    a.d = x;
    mag = fp_to_u64(a.u, F64_EB, F64_MB, F64_BIAS, 32, &neg);
    if (neg == 0 && !lt64(mag, mk64(0, 0x80000000u))) {
        return (int)0x7FFFFFFF;                       /* saturate + */
    }
    if (neg && !lt64(mag, mk64(0, 0x80000001u))) {
        return (int)0x80000000;                       /* saturate - */
    }
    if (neg) return (int)(0u - lo32(mag));
    return (int)lo32(mag);
}

unsigned int __aeabi_d2uiz(double x)
{
    dbl a;
    int neg;
    u64 mag;

    a.d = x;
    mag = fp_to_u64(a.u, F64_EB, F64_MB, F64_BIAS, 32, &neg);
    if (neg && !zero64(mag)) return 0u;
    if (hi32(mag) != 0) return 0xFFFFFFFFu;
    return lo32(mag);
}

long long __aeabi_d2lz(double x)
{
    dbl a;
    int neg;
    u64 mag;
    u64 lim = mk64(0x80000000u, 0x00000000u);

    a.d = x;
    mag = fp_to_u64(a.u, F64_EB, F64_MB, F64_BIAS, 64, &neg);
    if (!neg && ge64(mag, lim)) return (long long)mk64(0x7FFFFFFFu, 0xFFFFFFFFu);
    if (neg && !lt64(mag, lim)) return (long long)lim;      /* -2^63 floor */
    if (neg) return (long long)(mk64(0, 0) - mag);
    return (long long)mag;
}

unsigned long long __aeabi_d2ulz(double x)
{
    dbl a;
    int neg;
    u64 mag;

    a.d = x;
    mag = fp_to_u64(a.u, F64_EB, F64_MB, F64_BIAS, 64, &neg);
    if (neg && !zero64(mag)) return mk64(0, 0);
    return mag;
}

int __aeabi_f2iz(float x)
{
    flt a;
    int neg;
    u64 mag;

    a.f = x;
    mag = fp_to_u64((u64)a.u, F32_EB, F32_MB, F32_BIAS, 32, &neg);
    if (neg == 0 && !lt64(mag, mk64(0, 0x80000000u))) return (int)0x7FFFFFFF;
    if (neg && !lt64(mag, mk64(0, 0x80000001u))) return (int)0x80000000;
    if (neg) return (int)(0u - lo32(mag));
    return (int)lo32(mag);
}

unsigned int __aeabi_f2uiz(float x)
{
    flt a;
    int neg;
    u64 mag;

    a.f = x;
    mag = fp_to_u64((u64)a.u, F32_EB, F32_MB, F32_BIAS, 32, &neg);
    if (neg && !zero64(mag)) return 0u;
    if (hi32(mag) != 0) return 0xFFFFFFFFu;
    return lo32(mag);
}

long long __aeabi_f2lz(float x)
{
    flt a;
    int neg;
    u64 mag;
    u64 lim = mk64(0x80000000u, 0x00000000u);

    a.f = x;
    mag = fp_to_u64((u64)a.u, F32_EB, F32_MB, F32_BIAS, 64, &neg);
    if (!neg && ge64(mag, lim)) return (long long)mk64(0x7FFFFFFFu, 0xFFFFFFFFu);
    if (neg && !lt64(mag, lim)) return (long long)lim;
    if (neg) return (long long)(mk64(0, 0) - mag);
    return (long long)mag;
}

unsigned long long __aeabi_f2ulz(float x)
{
    flt a;
    int neg;
    u64 mag;

    a.f = x;
    mag = fp_to_u64((u64)a.u, F32_EB, F32_MB, F32_BIAS, 64, &neg);
    if (neg && !zero64(mag)) return mk64(0, 0);
    return mag;
}

/* float <-> double.  Widening is exact (a float's 24 bits fit in 53), so the
 * rounding step is a no-op there -- but it goes through the same code as the
 * narrowing direction rather than a second implementation that could drift. */
double __aeabi_f2d(float x)
{
    flt a;
    dbl r;
    fnum v;
    int exp;

    a.f = x;
    v = unpack((u64)a.u, F32_EB, F32_MB);
    if (v.cls == 3 || v.cls == 2 || v.cls == 0) {
        fnum w;
        w.sign = v.sign;
        w.cls = v.cls;
        w.exp = 0;
        w.m = 0;
        r.u = pack(w, F64_EB, F64_MB);
        return r.d;
    }
    exp = v.exp - F32_BIAS + F64_BIAS;
    r.u = assemble(v.sign, exp, v.m, F32_MB, F64_MB, F64_EB);
    return r.d;
}

float __aeabi_d2f(double x)
{
    dbl a;
    flt r;
    fnum v;
    int exp;

    a.d = x;
    v = unpack(a.u, F64_EB, F64_MB);
    if (v.cls == 3 || v.cls == 2 || v.cls == 0) {
        fnum w;
        w.sign = v.sign;
        w.cls = v.cls;
        w.exp = 0;
        w.m = 0;
        r.u = (u32)pack(w, F32_EB, F32_MB);
        return r.f;
    }
    exp = v.exp - F64_BIAS + F32_BIAS;
    r.u = (u32)assemble(v.sign, exp, v.m, F64_MB, F32_MB, F32_EB);
    return r.f;
}
