#!/usr/bin/env python3
"""ARM execution gate for the soft-float runtime (stdlib/src/arm/aeabi_float.c).

Why this gate exists
--------------------
`tests/softfloat_ref.c` compares the runtime against the *host* CPU.  That
proves the algorithm; it does not prove that a Cortex-M0 image built by this
compiler, linked against this object file, calling through the AEABI
conventions this backend actually emits (doubles in r0:r1 / r2:r3, results in
r0:r1, comparisons returning an int in r0) computes the same numbers.  Those
are exactly the places a compiler project gets it wrong silently: the
arguments land in the wrong register, the caller clobbers a callee-saved
register, or the helper is never reached because the backend inlined a VFP
instruction on a core that has no FPU.

So this gate builds a real image for a core with no FPU (`cortex-m0`), links
`aeabi_float.c` into it, executes it in unicorn, and decides every case from
the bit pattern the executed bytes produced.

Two things are checked, and both matter:

  * the entry points, called directly -- the runtime's own answer;
  * ordinary C expressions (`a + b`, `(int)d`, `(float)d`) on `volatile`
    operands -- the *backend's* path: which helper it calls, and with what.

Expected values are computed here in Python (`struct` round-trips give exact
IEEE-754 binary32/binary64 with round-to-nearest-even, the same arithmetic the
host gate verified against SSE).  The seed is fixed, so a failure is
reproducible; `--seed` chooses another table.

A failure returns the index of the first mismatching row from `main()`, and
the caller prints that row from the same table -- so the report names the
operation and the operands instead of saying "wrong".

Usage (from the repository root):
    python tests/run_arm_softfloat_tests.py [--arkcc PATH] [--keep] [--seed N]

Exit code: 0 every case matched, 1 a mismatch, 2 setup problem (no unicorn, no
arkcc -- nothing was verified).
"""
import argparse
import os
import random
import shutil
import struct
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
TMP = os.path.join(ROOT, 'build_softfloat_tests')
SOFTFLOAT_C = os.path.join(ROOT, 'stdlib', 'src', 'arm', 'aeabi_float.c')

sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
try:
    from run_arm_exec import run_image
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

# A core without an FPU: this is what makes the backend emit the AEABI
# helpers instead of VFP instructions, which is the path under test.
CPU_OPTS = ['-mcpu', 'cortex-m0']

STARTUP_C = '''\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void)
{
    int rc;
    __arkcc_init_globals();
    rc = main();
    return rc;
}
'''

# ---------------------------------------------------------------------------
# IEEE-754 helpers.  Python floats are binary64 with round-to-nearest-even, and
# `struct` is exact, so these are the same operation the host gate checked.
# ---------------------------------------------------------------------------
def reset_dir(path):
    """Make `path` an empty directory.

    `shutil.rmtree` can be blocked by an external deletion policy (some
    harnesses turn it into PermissionError for safety).  When that happens
    the stale tree is moved under the system temp directory instead: the
    test only needs a clean working directory, not the removal itself.
    """
    if os.path.isdir(path):
        shutil.rmtree(path, ignore_errors=True)
    if os.path.isdir(path):
        stale = os.path.join(tempfile.gettempdir(),
                             'ark_stale_%d_%s' % (os.getpid(),
                                                  os.path.basename(path)))
        shutil.rmtree(stale, ignore_errors=True)
        try:
            shutil.move(path, stale)
        except OSError:
            pass
    os.makedirs(path, exist_ok=True)


def d_bits(x):
    return struct.unpack('<Q', struct.pack('<d', x))[0]

def bits_d(b):
    return struct.unpack('<d', struct.pack('<Q', b))[0]

def f_bits(x):
    """Round a double to binary32 and return its bits.  Overflow becomes the
    correctly-signed infinity: Python's `struct` raises instead of returning it,
    and a binary32 operation that overflows does produce an infinity."""
    try:
        return struct.unpack('<I', struct.pack('<f', x))[0]
    except OverflowError:
        return 0xFF800000 if x < 0 else 0x7F800000

def bits_f(b):
    return struct.unpack('<f', struct.pack('<I', b))[0]

def is_nan_d(b):
    return ((b >> 52) & 0x7FF) == 0x7FF and (b & ((1 << 52) - 1)) != 0

def is_nan_f(b):
    return ((b >> 23) & 0xFF) == 0xFF and (b & ((1 << 23) - 1)) != 0

CANON_D_NAN = 0x7FF8000000000000
CANON_F_NAN = 0x7FC00000


def ref_d2i(x, lo, hi):
    """Documented conversion: truncate toward zero, saturate, NaN -> 0."""
    if x != x:
        return 0
    if x >= float(hi):
        return hi
    if x <= float(lo):
        return lo
    return int(x)


# ---------------------------------------------------------------------------
# the table
# ---------------------------------------------------------------------------
D_EDGE = [0x0000000000000000, 0x8000000000000000, 0x0000000000000001,
          0x000fffffffffffff, 0x0010000000000000, 0x3ff0000000000000,
          0xbff0000000000000, 0x3ff0000000000001, 0x3fe0000000000000,
          0x4000000000000000, 0x4330000000000000, 0x7fefffffffffffff,
          0xffefffffffffffff, 0x7ff0000000000000, 0xfff0000000000000,
          0x7ff8000000000000, 0x3ca0000000000000, 0x0000000000000002]
F_EDGE = [0x00000000, 0x80000000, 0x00000001, 0x007fffff, 0x00800000,
          0x3f800000, 0xbf800000, 0x3f800001, 0x3f000000, 0x40000000,
          0x4b000000, 0x7f7fffff, 0xff7fffff, 0x7f800000, 0xff800000,
          0x7fc00000, 0x34000000, 0x00000002]

# op codes must match the switch in the generated C
OPS_D2D = {'dadd': 1, 'dsub': 2, 'dmul': 3, 'ddiv': 4}
OPS_F2F = {'fadd': 5, 'fsub': 6, 'fmul': 7, 'fdiv': 8}
OP_F2D = 9
OP_D2F = 10
OP_CMP = {'dcmpeq': 11, 'dcmplt': 12, 'fcmpeq': 13, 'fcmplt': 14}
OP_CONV = {'d2iz': 15, 'd2uiz': 16, 'f2iz': 17, 'f2uiz': 18}

# name -> op code, so the table line and the switch cannot drift apart
OP_CODE = dict([(n, i + 1) for i, n in enumerate(
    ['dadd', 'dsub', 'dmul', 'ddiv', 'fadd', 'fsub', 'fmul', 'fdiv',
     'f2d', 'd2f', 'dcmpeq', 'dcmplt', 'fcmpeq', 'fcmplt',
     'd2iz', 'd2uiz', 'f2iz', 'f2uiz'])])

CASE_WORDS = {
    1: 'dadd', 2: 'dsub', 3: 'dmul', 4: 'ddiv',
    5: 'fadd', 6: 'fsub', 7: 'fmul', 8: 'fdiv',
    9: 'f2d', 10: 'd2f', 11: 'dcmpeq', 12: 'dcmplt',
    13: 'fcmpeq', 14: 'fcmplt', 15: 'd2iz', 16: 'd2uiz',
    17: 'f2iz', 18: 'f2uiz',
}

# result width per op name, so the generator knows how wide the operands are
WIDTH = {
    'dadd': 64, 'dsub': 64, 'dmul': 64, 'ddiv': 64,
    'fadd': 32, 'fsub': 32, 'fmul': 32, 'fdiv': 32,
    'f2d': 32, 'd2f': 64,
    'dcmpeq': 64, 'dcmplt': 64, 'fcmpeq': 32, 'fcmplt': 32,
    'd2iz': 64, 'd2uiz': 64, 'f2iz': 32, 'f2uiz': 32,
}


def expected_dd(op, ab, bb):
    a, b = bits_d(ab), bits_d(bb)
    if op == 'dadd':
        r = a + b
    elif op == 'dsub':
        r = a - b
    elif op == 'dmul':
        r = a * b
    else:
        try:
            r = a / b
        except ZeroDivisionError:
            return None            # sign/kind handled by the caller below
    if r != r:
        return CANON_D_NAN
    return d_bits(r)


def expected_ff(op, ab, bb):
    a, b = bits_f(ab), bits_f(bb)
    if op == 'fadd':
        r = a + b
    elif op == 'fsub':
        r = a - b
    elif op == 'fmul':
        r = a * b
    else:
        try:
            r = a / b
        except ZeroDivisionError:
            return None
    if r != r:
        return CANON_F_NAN
    return f_bits(r)


def div_by_zero_d(ab, bb):
    """IEEE division by zero, which Python raises on instead of returning inf."""
    a, b = bits_d(ab), bits_d(bb)
    if a == 0.0 or a != a:
        return CANON_D_NAN                   # 0/0 and NaN/0
    sign = ((ab ^ bb) >> 63) & 1
    return (0x7FF0000000000000 | (sign << 63))


def div_by_zero_f(ab, bb):
    a, b = bits_f(ab), bits_f(bb)
    if a == 0.0 or a != a:
        return CANON_F_NAN
    sign = ((ab ^ bb) >> 31) & 1
    return (0x7F800000 | (sign << 31))


def build_table(rng, n_random):
    """Returns [(op_name, a_bits, b_bits, want_bits)]."""
    rows = []

    def add(name, a, b):
        if name in OPS_D2D:
            want = expected_dd(name, a, b)
            if want is None:
                want = div_by_zero_d(a, b)
        elif name in OPS_F2F:
            want = expected_ff(name, a, b)
            if want is None:
                want = div_by_zero_f(a, b)
        elif name == 'f2d':
            x = bits_f(a)
            want = CANON_D_NAN if x != x else d_bits(float(x))
        elif name == 'd2f':
            x = bits_d(a)
            want = CANON_F_NAN if x != x else f_bits(x)
        elif name == 'dcmpeq':
            want = 1 if bits_d(a) == bits_d(b) else 0
        elif name == 'dcmplt':
            want = 1 if bits_d(a) < bits_d(b) else 0
        elif name == 'fcmpeq':
            want = 1 if bits_f(a) == bits_f(b) else 0
        elif name == 'fcmplt':
            want = 1 if bits_f(a) < bits_f(b) else 0
        elif name == 'd2iz':
            want = ref_d2i(bits_d(a), -2147483648, 2147483647) & 0xFFFFFFFF
        elif name == 'd2uiz':
            want = ref_d2i(bits_d(a), 0, 4294967295)
        elif name == 'f2iz':
            want = ref_d2i(bits_f(a), -2147483648, 2147483647) & 0xFFFFFFFF
        elif name == 'f2uiz':
            want = ref_d2i(bits_f(a), 0, 4294967295)
        else:
            raise AssertionError(name)
        rows.append((name, a, b, want))

    # every arithmetic op over a handful of edge operands: the cases a naive
    # implementation gets wrong (zeros, subnormals, max finite, ties)
    for name in ('dadd', 'dsub', 'dmul', 'ddiv'):
        for a, b in ((D_EDGE[5], D_EDGE[10]), (D_EDGE[14], D_EDGE[11]),
                     (D_EDGE[15], D_EDGE[3]), (D_EDGE[3], D_EDGE[3]),
                     (D_EDGE[10], D_EDGE[13]), (D_EDGE[11], D_EDGE[5])):
            add(name, a, b)
    add('ddiv', 0x3ff0000000000000, 0x0000000000000000)
    add('ddiv', 0x0000000000000000, 0x0000000000000000)
    for name in ('fadd', 'fsub', 'fmul', 'fdiv'):
        for a, b in ((F_EDGE[0], F_EDGE[1]), (F_EDGE[5], F_EDGE[7]),
                     (F_EDGE[3], F_EDGE[4]), (F_EDGE[11], F_EDGE[12]),
                     (F_EDGE[9], F_EDGE[8])):
            add(name, a, b)
    add('fdiv', 0x3f800000, 0x00000000)
    add('fdiv', 0x00000000, 0x00000000)

    add('f2d', F_EDGE[3], 0)
    add('f2d', F_EDGE[5], 0)
    add('f2d', F_EDGE[3] | 0x80000000, 0)
    add('d2f', D_EDGE[11], 0)
    add('d2f', D_EDGE[3], 0)                     # max subnormal -> 0
    add('d2f', D_EDGE[5] ^ 1, 0)
    add('d2f', 0x3ca0000000000000, 0)            # one ulp above 1.0 -> tie

    add('dcmpeq', D_EDGE[0], D_EDGE[1])          # +0 == -0
    add('dcmplt', D_EDGE[0], D_EDGE[1])
    add('dcmplt', D_EDGE[15], D_EDGE[5])         # NaN is unordered
    add('fcmpeq', F_EDGE[0], F_EDGE[1])
    add('fcmplt', F_EDGE[15], F_EDGE[5])

    add('d2iz', 0x4008000000000000, 0)           # 3.0
    add('d2iz', 0xc008000000000000, 0)           # -3.0
    add('d2iz', 0x41e0000000000000, 0)           # 2^31 -> saturates
    add('d2uiz', 0x41f0000000000000, 0)          # 2^32 -> saturates
    add('d2uiz', 0xbfe0000000000000, 0)          # -0.5 -> 0
    add('f2iz', 0x40400000, 0)                   # 3.0
    add('f2uiz', 0x4f000000, 0)                  # 2^31 in float -> saturates

    # random operands, drawn the same way the host gate draws them: mostly
    # ordinary numbers, with the special values mixed in at their real rate
    for _ in range(n_random):
        if rng.random() < 0.5:
            op = rng.choice(list(OPS_D2D) + ['dcmpeq', 'dcmplt', 'd2iz',
                                             'd2uiz'])
        else:
            op = rng.choice(list(OPS_F2F) + ['fcmpeq', 'fcmplt', 'f2iz',
                                             'f2uiz'])
        wide = WIDTH[op]
        if wide == 64:
            a = rng.getrandbits(64)
            b = rng.getrandbits(64)
            if rng.random() < 0.4:                 # keep the exponents sane
                a = (a & 0x800FFFFFFFFFFFFF) | (rng.randrange(1000, 1050) << 52)
                b = (b & 0x800FFFFFFFFFFFFF) | (rng.randrange(1000, 1050) << 52)
        else:
            a = rng.getrandbits(32)
            b = rng.getrandbits(32)
            if rng.random() < 0.4:
                a = (a & 0x807FFFFF) | (rng.randrange(120, 134) << 23)
                b = (b & 0x807FFFFF) | (rng.randrange(120, 134) << 23)
        add(op, a, b)
    return rows


# ---------------------------------------------------------------------------
# generated C
# ---------------------------------------------------------------------------
C_TEMPLATE = '''\
/* generated by tests/run_arm_softfloat_tests.py -- do not edit */
typedef unsigned int u32;
typedef unsigned long long u64;

extern double __aeabi_dadd(double, double);
extern double __aeabi_dsub(double, double);
extern double __aeabi_dmul(double, double);
extern double __aeabi_ddiv(double, double);
extern float  __aeabi_fadd(float, float);
extern float  __aeabi_fsub(float, float);
extern float  __aeabi_fmul(float, float);
extern float  __aeabi_fdiv(float, float);
extern int    __aeabi_dcmpeq(double, double);
extern int    __aeabi_dcmplt(double, double);
extern int    __aeabi_fcmpeq(float, float);
extern int    __aeabi_fcmplt(float, float);
extern double __aeabi_f2d(float);
extern float  __aeabi_d2f(double);
extern int    __aeabi_d2iz(double);
extern u32    __aeabi_d2uiz(double);
extern int    __aeabi_f2iz(float);
extern u32    __aeabi_f2uiz(float);

typedef union { double d; u64 u; } dbl;
typedef union { float  f; u32 u; } flt;

struct tcase { u32 op; u64 a; u64 b; u64 want; };

/* The table is split: the backend addresses a constant array with a 32-bit
 * LDR/STR immediate, which tops out at 4095 bytes, so one array of 24-byte
 * rows dies at row 170 with "offset out of range".  Chunks of 60 rows keep
 * every access well inside the encoding. */
%(tables)s
#define NELEM(a) ((int)(sizeof a / sizeof a[0]))
#define NCASES (%(ncases)s)

static const struct tcase *row(int i)
{
%(pickers)s
    return 0;
}

static u64 run(const struct tcase *c)
{
    dbl a, b, r;
    flt fa, fb, fr;
    a.u = c->a;
    b.u = c->b;
    fa.u = (u32)c->a;
    fb.u = (u32)c->b;
    switch (c->op) {
    case 1: r.d = __aeabi_dadd(a.d, b.d); return r.u;
    case 2: r.d = __aeabi_dsub(a.d, b.d); return r.u;
    case 3: r.d = __aeabi_dmul(a.d, b.d); return r.u;
    case 4: r.d = __aeabi_ddiv(a.d, b.d); return r.u;
    case 5: fr.f = __aeabi_fadd(fa.f, fb.f); return fr.u;
    case 6: fr.f = __aeabi_fsub(fa.f, fb.f); return fr.u;
    case 7: fr.f = __aeabi_fmul(fa.f, fb.f); return fr.u;
    case 8: fr.f = __aeabi_fdiv(fa.f, fb.f); return fr.u;
    case 9: r.d = __aeabi_f2d(fa.f); return r.u;
    case 10: fr.f = __aeabi_d2f(a.d); return fr.u;
    case 11: return (u64)__aeabi_dcmpeq(a.d, b.d);
    case 12: return (u64)__aeabi_dcmplt(a.d, b.d);
    case 13: return (u64)__aeabi_fcmpeq(fa.f, fb.f);
    case 14: return (u64)__aeabi_fcmplt(fa.f, fb.f);
    case 15: return (u64)(u32)__aeabi_d2iz(a.d);
    case 16: return (u64)__aeabi_d2uiz(a.d);
    case 17: return (u64)(u32)__aeabi_f2iz(fa.f);
    case 18: return (u64)__aeabi_f2uiz(fa.f);
    default: return 0xDEADBEEF;
    }
}

/* NaN results are compared as "both NaN": the payload is documented as not
 * propagated, so pinning one would be testing a promise the file does not
 * make. */
static int both_nan(u32 op, u64 x, u64 y)
{
    if (op >= 11 && op <= 14) return 0;
    if (op == 5 || op == 6 || op == 7 || op == 8 || op == 10 ||
        op == 13 || op == 14) {
        u32 a = (u32)x, b = (u32)y;
        return ((a & 0x7F800000u) == 0x7F800000u && (a & 0x7FFFFFu) != 0 &&
                (b & 0x7F800000u) == 0x7F800000u && (b & 0x7FFFFFu) != 0);
    }
    return (((x >> 52) & 0x7FF) == 0x7FF && (x & 0xFFFFFFFFFFFFFULL) != 0 &&
            ((y >> 52) & 0x7FF) == 0x7FF && (y & 0xFFFFFFFFFFFFFULL) != 0);
}

int main(void)
{
    int i;

    for (i = 0; i < NCASES; i++) {
        const struct tcase *c = row(i);
        u64 got;
        if (c == 0) return 250;      /* table split is inconsistent */
        got = run(c);
        if (got != c->want) {
            if (both_nan(c->op, got, c->want)) continue;
            return i + 1;            /* 0 means "all rows matched" */
        }
    }
    return 0;
}
'''

# Expressions, not entry-point calls: this is the path the compiler decides.
EXPR_C = '''\
/* generated by tests/run_arm_softfloat_tests.py -- do not edit */
typedef unsigned int u32;
typedef unsigned long long u64;
typedef union { double d; u64 u; } dbl;
typedef union { float  f; u32 u; } flt;

static volatile double va, vb;
static volatile float  fa, fb;

int main(void)
{
    dbl r;
    flt rf;

    /* 1.5 + 2.25 = 3.75, computed through the backend's own operator path */
    va = 1.5; vb = 2.25;
    r.d = va + vb;
    if (r.u != 0x400E000000000000ULL) return 1;

    /* 3.75 - 1.5 = 2.25 */
    r.d = va + vb - va;
    if (r.u != 0x4002000000000000ULL) return 2;

    /* 1.5 * 2.25 = 3.375 */
    r.d = va * vb;
    if (r.u != 0x400B000000000000ULL) return 3;

    /* 3.75 / 1.5 = 2.5 */
    r.d = (va + vb) / va;
    if (r.u != 0x4004000000000000ULL) return 4;

    /* float arithmetic rounds at 24 bits, not 53 */
    fa = 1.5f; fb = 2.25f;
    rf.f = fa + fb;
    if (rf.u != 0x40700000u) return 5;
    rf.f = fa * fb;
    if (rf.u != 0x40580000u) return 6;

    /* float -> double is exact, double -> float rounds */
    r.d = fa;
    if (r.u != 0x3FF8000000000000ULL) return 7;
    va = 1.0;
    va = va / 3.0;
    rf.f = va;
    if (rf.u != 0x3EAAAAABu) return 8;

    /* conversions to integer truncate toward zero */
    va = -3.75;
    if ((int)va != -3) return 9;
    va = 3.75;
    if ((int)va != 3) return 10;
    if ((unsigned int)va != 3u) return 11;
    fa = 2.5f;
    if ((int)fa != 2) return 12;

    /* comparisons: NaN is unordered, so < is false but == is false too */
    va = 1.0; vb = 1.0;
    if (!(va == vb)) return 13;
    if (va < vb) return 14;
    fa = 1.0f; fb = 1.0f;
    if (!(fa == fb)) return 15;
    if (fa < fb) return 16;

    /* a chain that mixes everything: (1.5 + 2.25) * 2.5 - 0.375 = 9.0 */
    va = 1.5; vb = 2.25;
    r.d = (va + vb) * 2.5 - 0.375;
    if (r.u != 0x4022000000000000ULL) return 17;

    return 0;
}
'''


def write(path, text):
    with open(path, 'w', newline='\n') as f:
        f.write(text)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc',
                    default=os.path.join(ROOT, 'arkcc.exe'
                                         if os.name == 'nt' else 'arkcc'))
    ap.add_argument('--keep', action='store_true')
    ap.add_argument('--seed', type=int, default=20261119)
    ap.add_argument('--random-cases', type=int, default=150)
    args = ap.parse_args()

    if not HAVE_UNICORN:
        print('SKIP: the unicorn python package is not installed '
              '(pip install unicorn); nothing was verified')
        return 2
    if not os.path.exists(args.arkcc):
        print('SKIP: arkcc not found at %s (build it with `make`)' % args.arkcc)
        return 2

    if not args.keep:
        reset_dir(TMP)
    else:
        os.makedirs(TMP, exist_ok=True)

    def run(cmd):
        return subprocess.run(cmd, capture_output=True, text=True,
                             errors='replace')

    rng = random.Random(args.seed)
    rows = build_table(rng, args.random_cases)
    if len(rows) > 250:
        print('internal: the table must stay under 250 rows (the exit code '
              'carries the failing index); it has %d' % len(rows))
        return 2

    # split into chunks of 60 rows (see the comment in the template)
    chunks = [rows[i:i + 60] for i in range(0, len(rows), 60)]
    tables = []
    pickers = []
    for k, chunk in enumerate(chunks):
        tables.append('static const struct tcase T%d[] = {\n%s\n};\n'
                      % (k, '\n'.join(
                          '    { %2d, 0x%016XULL, 0x%016XULL, 0x%016XULL },'
                          % (OP_CODE[name], a, b, w) for name, a, b, w in chunk)))
        pickers.append('    if (i < NELEM(T%d)) return &T%d[i];\n'
                       '    i -= NELEM(T%d);\n' % (k, k, k))
    pickers[-1] = pickers[-1].replace(
        '    i -= NELEM(T%d);\n' % (len(chunks) - 1), '')
    src = os.path.join(TMP, 'sf_cases.c')
    write(src, C_TEMPLATE % {'tables': ''.join(tables),
                             'pickers': ''.join(pickers),
                             'ncases': ' + '.join('NELEM(T%d)' % k
                                                  for k in range(len(chunks)))})
    write(os.path.join(TMP, 'sf_expr.c'), EXPR_C)
    write(os.path.join(TMP, 'sf_startup.c'), STARTUP_C)

    startup_o = os.path.join(TMP, 'sf_startup.obj')
    r = run([args.arkcc, os.path.join(TMP, 'sf_startup.c'), '-target', 'arm',
             '-c', '--reloc-data', '--reloc-text', '--vector-table']
            + CPU_OPTS + ['-o', startup_o])
    if r.returncode != 0:
        print('FAIL startup: ' + (r.stdout + r.stderr).strip()[:300])
        return 1

    rt_o = os.path.join(TMP, 'aeabi_float.obj')
    r = run([args.arkcc, SOFTFLOAT_C, '-target', 'arm', '-c',
             '--reloc-data', '--reloc-text'] + CPU_OPTS + ['-o', rt_o])
    if r.returncode != 0:
        print('FAIL runtime compile: ' + (r.stdout + r.stderr).strip()[:400])
        return 1

    # the runtime must not need any other AEABI helper: it is the whole
    # floating-point support of a freestanding image
    r = run([args.arkcc, SOFTFLOAT_C, '-target', 'arm', '-S', '-O2',
             '--cpu=cortex-m0', '-o', os.path.join(TMP, 'aeabi_float.s')])
    if r.returncode != 0:
        print('FAIL runtime -S: ' + (r.stdout + r.stderr).strip()[:400])
        return 1
    asm = open(os.path.join(TMP, 'aeabi_float.s'), 'r', errors='replace').read()
    defined = set()
    for line in asm.splitlines():
        s = line.strip()
        if s.startswith('__aeabi_') and s.endswith(':'):
            defined.add(s[:-1])
    called = set()
    for line in asm.splitlines():
        s = line.strip()
        if s.startswith('BL '):
            sym = s[3:].strip()
            if sym.startswith('__aeabi_'):
                called.add(sym)
    external = sorted(called - defined - {'__aeabi_memcpy'})
    if external:
        print('FAIL self-containment: the runtime calls helpers it does not '
              'define: ' + ', '.join(external))
        return 1
    print('self-containment: %d entry points defined, no external AEABI '
          'helper called' % len(defined))

    # The *test programs* use 64-bit shifts and compares of their own (to mask
    # exponent fields and to compare bit patterns), and the backend turns those
    # into __aeabi_llsr / __aeabi_ulcmp.  The runtime under test does not need
    # them -- the -S check above proves that -- but the harness does, so link
    # the integer runtime as well.
    int_o = os.path.join(TMP, 'aeabi.obj')
    r = run([args.arkcc, os.path.join(ROOT, 'stdlib', 'src', 'arm', 'aeabi.c'),
             '-target', 'arm', '-c', '--reloc-data', '--reloc-text']
            + CPU_OPTS + ['-o', int_o])
    if r.returncode != 0:
        print('FAIL integer runtime: ' + (r.stdout + r.stderr).strip()[:300])
        return 1
    div_o = os.path.join(TMP, 'aeabi_div.obj')
    r = run([args.arkcc, os.path.join(ROOT, 'stdlib', 'src', 'arm',
                                      'aeabi_divmod.s'),
             '-target', 'arm', '-c', '-o', div_o])
    if r.returncode != 0:
        print('FAIL divider: ' + (r.stdout + r.stderr).strip()[:300])
        return 1

    ok = 0
    for name in ('sf_cases', 'sf_expr'):
        c = os.path.join(TMP, name + '.c')
        o = os.path.join(TMP, name + '.obj')
        r = run([args.arkcc, c, '-target', 'arm', '-c',
                 '--reloc-data', '--reloc-text'] + CPU_OPTS + ['-o', o])
        if r.returncode != 0:
            print('FAIL compile %s: %s' % (name, (r.stdout + r.stderr).strip()[:400]))
            return 1
        img = os.path.join(TMP, name + '.bin')
        r = run([args.arkcc, '-link', startup_o, rt_o, o, int_o, div_o,
                 '--reloc-data', '--reloc-text', '--vector-table', '-o', img])
        if r.returncode != 0:
            print('FAIL link %s: %s' % (name, (r.stdout + r.stderr).strip()[:400]))
            return 1
        status, value, detail = run_image(open(img, 'rb').read(),
                                          max_insn=20000000)
        if status == 'fault':
            print('FAIL %s: the image faulted (%s)' % (name, detail))
            return 1
        if status == 'limit':
            print('FAIL %s: instruction budget spent' % name)
            return 1
        if name == 'sf_expr':
            if value != 0:
                print('FAIL expr case %d: an ordinary C expression computed '
                      'the wrong bits (see EXPR_C step %d)' % (value, value))
                return 1
            print('PASS expressions: 17 operator/convert/compare steps')
            ok += 1
            continue
        if value != 0:
            i = value - 1
            if 0 <= i < len(rows):
                op, a, b, w = rows[i]
                print('FAIL row %d: %s(0x%016X, 0x%016X) expected 0x%016X'
                      % (i, op, a, b, w))
                print('     (the image returned %d, i.e. row index + 1; the '
                      'wrong value it computed is not carried back by this '
                      'channel -- dump that row standalone to see it)'
                      % value)
            else:
                print('FAIL: the image returned %d, outside the table' % value)
            return 1
        print('PASS entry points: %d rows (seed %d)' % (len(rows), args.seed))
        ok += 1

    print('softfloat ARM gate: %d/2 groups passed' % ok)
    return 0 if ok == 2 else 1


if __name__ == '__main__':
    sys.exit(main())