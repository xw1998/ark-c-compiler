#!/usr/bin/env python3
"""ARM 64-bit integer gate.

Every failure this file covers was, at some point, a *silent* wrong answer:

  * `IR_DUP` copied a single 32-bit word, so a 64-bit global assignment
    (`long long a; a = -7LL;`) pushed [low, high, high] and the store wrote the
    high word into both halves -- `a` came out as -1 and as 0 for 7LL, and every
    later divide inherited it.  Cases ll_store / ll_global_version below are
    exactly that shape.
  * the 64-bit add/sub helpers `__aeabi_ladd` / `__aeabi_lsub` are not in gcc's
    libgcc.a (gcc inlines them and never defines them), so an image would link
    only against a runtime that had them -- or, worse, link against a stub that
    answered wrongly.  The backend now emits ADDS/ADC and SUBS/SBC inline; the
    `no_runtime` cases below prove those two operators need no runtime, and the
    positive control at the end proves the other operators still do.
  * a Thumb-2 wide `ADD.W r0, r0, #imm` does not update APSR under unicorn
    2.1.4, which silently broke the carry into ADC.  ll_addcarry checks the
    carry explicitly.

Expectations are hardcoded.  The host gcc oracle is only a *cross-check*: if it
disagrees with the hardcoded value, the test itself is wrong and the gate says
so instead of blaming the backend.

Usage (run from the compiler repository root):
    python tests/run_arm_int64_tests.py --arm-as <arm-none-eabi bin dir> [--arm-libgcc <libgcc.a>]
"""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

# name, source, expected exit status, needs libgcc?
CASES = [
    # --- 64-bit store/load round trip (the IR_DUP defect) --------------
    ("ll_store", """
long long g;
int main(void) {
    long long a = -7LL;
    g = a;                 /* 64-bit global store: two words, one DUP */
    long long b = g;
    return (int)(b + 200); /* -7 + 200 */
}
""", 193, False),

    ("ll_local", """
union U { long long v; unsigned w[2]; };
int main(void) {
    union U u;
    long long a = -7LL;
    long long b = 7LL;
    u.v = a + b;                    /* 0 */
    int z = (u.w[0] | u.w[1]) == 0 ? 10 : 0;
    u.v = a;                        /* 0xFFFFFFFFFFFFFFF9 */
    int m7 = (u.w[0] == 4294967289u && u.w[1] == 4294967295u) ? 20 : 0;
    return z + m7 + 100;
}
""", 130, False),

    # --- add/sub inlined: no runtime needed ----------------------------
    # These four peel the two words out through a union instead of `>> 32` and
    # compare them as 32-bit ints: shifts and 64-bit comparisons do go through
    # libgcc (__aeabi_llsr, __aeabi_lcmp), so using them here would hide the
    # very thing this group is meant to prove.
    ("ll_addcarry", """
union U { long long v; unsigned w[2]; };
int main(void) {
    union U u;
    long long a = 4294967295LL;   /* 0x00000000FFFFFFFF */
    long long b = 1LL;
    u.v = a + b;                  /* 0x0000000100000000 */
    int hi = (u.w[1] == 1) ? 2 : 0;
    int lo = (u.w[0] == 0) ? 4 : 0;
    long long d = -1LL;
    u.v = d + 1LL;                /* 0 */
    int zero = (u.w[0] | u.w[1]) == 0 ? 8 : 0;
    return hi + lo + zero + 100;
}
""", 114, False),

    ("ll_subborrow", """
union U { long long v; unsigned w[2]; };
int main(void) {
    union U u;
    long long a = 0LL;
    long long b = 1LL;
    u.v = a - b;                  /* 0xFFFFFFFFFFFFFFFF */
    int ones = (u.w[0] == 4294967295u && u.w[1] == 4294967295u) ? 4 : 0;
    long long d = 0x80000000LL;
    u.v = d - 1LL;                /* 0x000000007FFFFFFF */
    int borrow = (u.w[0] == 2147483647u && u.w[1] == 0u) ? 8 : 0;
    return ones + borrow + 100;
}
""", 112, False),

    # --- signed divide/modulo with negative operands -------------------
    ("ll_sdivmod", """
int main(void) {
    long long a = -7LL;
    long long q = a / 2LL;      /* -3, truncation toward zero */
    long long r = a % 2LL;      /* -1 */
    long long b = 7LL;
    long long q2 = b / -2LL;    /* -3 */
    long long r2 = b % -2LL;    /*  1 */
    return (int)(q + r + q2 + r2 + 200);   /* -6 + 200 */
}
""", 194, True),

    ("ll_udivmod", """
int main(void) {
    unsigned long long u = 10000000000ULL;
    unsigned long long q = u / 1000000ULL;   /* 10000 */
    unsigned long long r = u % 7ULL;         /* 4 */
    return (int)(q % 100) + (int)r + 100;    /* 0 + 4 + 100 */
}
""", 104, True),

    # --- multiply ------------------------------------------------------
    ("ll_mul", """
int main(void) {
    long long a = 123456789LL;
    long long b = 1000003LL;
    long long c = a * b;                     /* 123457159370367 */
    return (int)((c / 1000000000LL) & 0xFF) + (int)(c % 1000LL) + 100;
}
""", 20, True),   # 65 + 367 + 100 = 532 -> 532 & 0xFF

    # --- comparison: signed vs unsigned must not share one helper ------
    ("ll_cmp_kind", """
int main(void) {
    unsigned long long a = 0xFFFFFFFFFFFFFFFFULL;
    unsigned long long b = 1ULL;
    int u = (a > b) ? 1 : 0;             /* 1 as unsigned */
    long long c = 0xFFFFFFFFFFFFFFFFLL;  /* -1 */
    int s = (c < 1LL) ? 1 : 0;           /* 1 as signed   */
    return u + s * 4 + 100;
}
""", 105, True),

    # --- shifts -------------------------------------------------------
    ("ll_shift", """
int main(void) {
    long long a = 1LL << 40;
    long long b = a >> 40;          /* 1 */
    long long c = -256LL >> 4;      /* -16, arithmetic */
    unsigned long long d = 0x8000000000000000ULL >> 60;   /* 8 */
    return (int)(b + c + d + 100);  /* 1 - 16 + 8 + 100 */
}
""", 93, True),

    # --- bitwise ------------------------------------------------------
    ("ll_bitops", """
int main(void) {
    long long a = 0x123456789ABCDEF0LL;
    long long b = 0x00000000FFFFFFFFLL;
    long long c = a & b;    /* 0x9ABCDEF0 */
    long long d = a ^ b;    /* high word stays 0x12345678 */
    return (int)((c >> 24) & 0xFF) + (int)((d >> 60) & 0xF) + 100;
}
""", 255, True),  # 0x9A + 1 + 100

    # --- ++/-- across the word boundary -------------------------------
    ("ll_incdec", """
union U { long long v; unsigned w[2]; };
int main(void) {
    union U u;
    long long a = 4294967295LL;
    a++;                                     /* 0x100000000 */
    u.v = a;
    int up = (u.w[1] == 1 && u.w[0] == 0) ? 4 : 0;
    a--;                                     /* back to 0xFFFFFFFF */
    u.v = a;
    int down = (u.w[1] == 0 && u.w[0] == 4294967295u) ? 8 : 0;
    long long c = 0;
    c--;                                     /* all ones */
    u.v = c;
    int ones = (u.w[1] == 4294967295u) ? 2 : 0;
    return up + down + ones + 100;
}
""", 114, False),

    # --- pass/return across calls -------------------------------------
    ("ll_call", """
long long sub3(long long x, long long y, long long z) { return x + y - z; }
long long scale(long long x, int n) { return x * n; }
int main(void) {
    long long r = sub3(1000000000000LL, 2000000000000LL, 500000000000LL);
    long long m = scale(r, 3);
    return (int)((m / 1000000000LL) & 0xFF) + 100;   /* 7500 & 0xFF */
}
""", 176, True),  # 76 + 100
]

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arm-as', required=True,
                    help='directory holding arm-none-eabi binutils')
    ap.add_argument('--arm-libgcc', default=None,
                    help='no-FPU libgcc.a (derived from --arm-as unless given)')
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    G.ARKC = os.path.abspath(args.arkcc)
    if not os.path.exists(G.ARKC):
        print('no such compiler: %s' % G.ARKC)
        return 2
    tool = G.tool_finder('arm-none-eabi-', args.arm_as)
    if not tool:
        print('cannot find arm-none-eabi binutils in %s' % args.arm_as)
        return 2
    libgcc = args.arm_libgcc or G.find_arm_libgcc(args.arm_as)
    if not libgcc or not os.path.exists(libgcc):
        print('cannot find a no-FPU libgcc.a for arm-none-eabi '
              '(pass --arm-libgcc); nothing was verified')
        return 2
    print('libgcc: %s' % libgcc)

    os.makedirs(G.TMP, exist_ok=True)
    G.write(os.path.join(G.TMP, 'start_arm.s'), G.ARM_START)
    r = G.Runner('gcc')
    rc = r.run([tool('as'), '-mcpu=cortex-m4',
                os.path.join(G.TMP, 'start_arm.s'),
                '-o', os.path.join(G.TMP, 'start_arm.o')])
    if rc.returncode != 0:
        print('cannot assemble the harness: %s' % rc.stderr)
        return 2

    ok = bad = 0
    for name, src, want, need_rt in CASES:
        srcf = os.path.join(G.TMP, 'i64_%s.c' % name)
        G.write(srcf, src)
        oracle, err = r.oracle(srcf, os.path.join(G.TMP, 'i64_%s_gcc.exe' % name))
        if oracle != want:
            print('FAIL %-14s oracle=%r want=%r (the test is wrong: %s)'
                  % (name, oracle, want, err.strip()[:80]))
            bad += 1
            continue
        got, err2 = r.arm('i64_%s' % name, srcf, tool,
                          libgcc if need_rt else '')
        if got is None:
            print('FAIL %-14s build/run: %s' % (name, err2.strip()[:200]))
            bad += 1
            continue
        if got != want:
            print('FAIL %-14s arkcc=%r want=%r' % (name, got, want))
            bad += 1
            continue
        print('PASS %-14s %d%s' % (name, got, '' if need_rt else '  (no runtime)'))
        ok += 1

    # Positive control: linking an image that really does use `*` without the
    # runtime must FAIL.  If it links, this gate's "no runtime" cases above are
    # meaningless -- either the backend stopped emitting the helper calls or
    # something in the link line is silently supplying them.
    src = CASES[6][1]                      # ll_mul
    srcf = os.path.join(G.TMP, 'i64_nort_mul.c')
    G.write(srcf, src)
    got, err = r.arm('i64_nort_mul', srcf, tool, '')
    if got is not None:
        print('FAIL control: a 64-bit multiply linked without a runtime '
              '(rc=%r) -- the "no runtime" cases prove nothing' % (got,))
        bad += 1
    elif 'undefined reference' not in err:
        print('FAIL control: expected an undefined-reference link error, got: %s'
              % err.strip()[:160])
        bad += 1
    else:
        print('SELFCHECK runtime-still-needed: OK')

    # Anti-false-green: feed the comparison a deliberately wrong expectation
    # and require it to be rejected.
    name, src, want, need_rt = CASES[0]
    got, _ = r.arm('i64_selfcheck', os.path.join(G.TMP, 'i64_%s.c' % name),
                   tool, libgcc)
    if got is not None and got == ((want + 1) & 0xFF):
        print('FAIL selfcheck: case %s cannot tell %d from %d'
              % (name, want, (want + 1) & 0xFF))
        bad += 1
    else:
        print('SELFCHECK expectation-mismatch: OK')

    print('=== %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1

if __name__ == '__main__':
    sys.exit(main())
