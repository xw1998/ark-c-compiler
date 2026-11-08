#!/usr/bin/env python3
"""RISC-V RV32I soft-float gate.

RV32I has no floating-point instructions, so the backend lowers every float
operation to a libgcc call.  Two things can go wrong there and both are silent:

  * the psABI argument order.  A double travels in an integer register pair with
    the LOW word in the lower-numbered register, while the IR stack keeps the
    HIGH word on top.  Getting that backwards produces numbers that are merely
    wrong (a double whose halves are swapped is a tiny denormal, not a crash),
    so every case here is compared against the host gcc oracle AND against a
    hardcoded expectation;
  * the comparison helpers.  libgcc answers strcmp-style and folds unordered
    pairs in per IEEE -- eq/ne and lt/le answer 1 for a NaN, gt/ge answer -1.
    Reading that as a plain true/false (instead of testing the sign) flips
    every NaN comparison to the wrong answer while looking perfectly healthy.

Because the emitted image calls libgcc, the link step here adds libgcc.a; the
path is derived from the binutils directory unless --rv-libgcc says otherwise.
Nothing is verified without it, so a missing libgcc is reported as an error and
not as a pass.

Usage (run from the compiler repository root):
    python tests/run_rv_float_tests.py --rv-as <riscv binutils dir> [--rv-libgcc <libgcc.a>]
"""
import argparse
import glob
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

CASES = [
    # name, source, expected exit status (masked to 8 bits)
    ("double_arith", """
double mix(double a, double b) { return (a + b) * (a - b) / (b + 1.0); }
int main(void) { return (int)(mix(3.5, 1.5) * 100.0); }
""", 144),   # (5.0 * 2.0 / 2.5) * 100 = 400 -> 400 & 0xFF

    ("single_arith", """
float f(float a, float b) { return a * b - b / a; }
int main(void) { return (int)(f(2.0f, 4.0f) * 10.0f); }
""", 60),    # 8 - 2 = 6 -> 60

    ("f2i_trunc", """
int main(void) { return ((int)3.9) + ((int)-3.9) + ((int)0.5) + ((int)-0.5) + 200; }
""", 200),   # truncation toward zero: 3 + -3 + 0 + 0

    ("i2f", """
int main(void) { double d = (double)7 + 0.25; float f = (float)3 + 0.5f;
                 return (int)(d * 4) + (int)(f * 2); }
""", 36),    # 29 + 7

    ("unsigned_cast", """
unsigned int ud(double x) { return (unsigned int)x; }
int main(void) { return (int)(ud(4000000000.0) % 251u); }
""", 246),   # __fixunsdfsi, not __fixdfsi (which would saturate at INT_MAX)

    ("ll_cast", """
long long to_ll(double x) { return (long long)x; }
double from_ll(long long v) { return (double)v; }
int main(void) {
    long long a = to_ll(-1234567.0);
    double b = from_ll(1000000LL);
    return (int)(a % 251) + (int)(b / 1000.0) + 125;
}
""", 208),   # -149 + 1000 + 125 = 976 -> 976 & 0xFF

    ("widen_narrow", """
double w(float f) { return (double)f; }
float n(double d) { return (float)d; }
int main(void) { return (int)(w(1.5f) * 4) + (int)(n(2.75) * 4) + 10; }
""", 27),    # 6 + 11 + 10

    ("cmp_double", """
int cmp(double a, double b) {
    return (a == b) + (a != b)*2 + (a < b)*4 + (a > b)*8 + (a <= b)*16 + (a >= b)*32;
}
int main(void) { return cmp(1.5, 2.5) + cmp(2.5, 2.5) * 2; }
""", 120),   # 22 + 49*2

    ("cmp_nan", """
int main(void) {
    double z = 0.0, n = z / z;
    return (n != n) + (n == n)*2 + (n < 1.0)*4 + (n > 1.0)*8
         + (n <= 1.0)*16 + (n >= 1.0)*32;
}
""", 1),     # every relation but '!=' must be false for NaN

    ("negate_zero", """
double negd(double x) { return -x; }
float negf(float x) { return -x; }
int main(void) {
    double a = negd(0.0);
    int s0 = (1.0 / a < 0.0) ? 1 : 0;
    double b = negd(3.5);
    float c = negf(0.0f);
    int s1 = (1.0f / c < 0.0f) ? 1 : 0;
    return s0 + s1 * 2 + (int)(b * 2) + 100;
}
""", 96),    # -0.0 must stay negative: 1 + 2 - 7 + 100 (an integer NEG gives +0.0)

    ("const_pool", """
int main(void) { double d = 0.5; float f = 0.5f; return (int)(d * 100) + (int)(f * 100); }
""", 100),   # one constant index serves both precisions
]


def find_libgcc(rv_bin):
    """libgcc.a for rv32im/ilp32, next to the binutils directory."""
    # rv_bin is <toolchain>/bin/<prefix>as[.exe]; libgcc lives at
    # <toolchain>/lib/gcc/<triple>/<version>/rv32im/ilp32/libgcc.a.
    top = os.path.dirname(os.path.dirname(os.path.abspath(rv_bin)))
    pat = os.path.join(top, 'lib', 'gcc', '*', '*', 'rv32im', 'ilp32', 'libgcc.a')
    hits = sorted(glob.glob(pat))
    return hits[0] if hits else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--rv-as', required=True,
                    help='directory holding riscv32 binutils')
    ap.add_argument('--rv-libgcc', default=None,
                    help='libgcc.a to link the RV soft-float helpers from')
    ap.add_argument('--arm-as', default=None,
                    help='directory holding arm-none-eabi binutils; turns on '
                         'the ARM arm of the gate')
    ap.add_argument('--arm-libgcc', default=None,
                    help='no-FPU libgcc.a for arm-none-eabi (derived from '
                         '--arm-as unless given here)')
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    G.ARKC = os.path.abspath(args.arkcc)
    if not os.path.exists(G.ARKC):
        print('no such compiler: %s' % G.ARKC)
        return 2
    tool = G.tool_finder('riscv64-unknown-elf-', args.rv_as)
    libgcc = args.rv_libgcc or find_libgcc(tool('as'))
    if not libgcc or not os.path.exists(libgcc):
        print('cannot find libgcc.a for rv32im/ilp32 (pass --rv-libgcc); '
              'nothing was verified')
        return 2
    print('rv   libgcc: %s' % libgcc)

    os.makedirs(G.TMP, exist_ok=True)
    G.write(os.path.join(G.TMP, 'start_rv.s'), G.RV_START)
    r = G.Runner('gcc')
    rc = r.run([tool('as'), '-march=rv32im', '-mabi=ilp32',
                os.path.join(G.TMP, 'start_rv.s'),
                '-o', os.path.join(G.TMP, 'start_rv.o')])
    if rc.returncode != 0:
        print('cannot assemble the harness: %s' % rc.stderr)
        return 2

    def run_rv(name, srcf):
        """arkcc -S, then as/ld(+libgcc)/objcopy, then unicorn."""
        asm = os.path.join(G.TMP, 'rf_%s.s' % name)
        obj = os.path.join(G.TMP, 'rf_%s.o' % name)
        elf = os.path.join(G.TMP, 'rf_%s.elf' % name)
        binf = os.path.join(G.TMP, 'rf_%s.bin' % name)
        err = r.compile('riscv32', srcf, asm)
        if err:
            return None, err
        out = r.run([tool('as'), '-march=rv32im', '-mabi=ilp32', asm, '-o', obj])
        if out.returncode != 0:
            return None, 'as: ' + out.stderr.strip()
        out = r.run([tool('ld'), '-m', 'elf32lriscv', '-Ttext=0x08000000',
                     '-e', '_start', os.path.join(G.TMP, 'start_rv.o'),
                     obj, libgcc, '-o', elf])
        if out.returncode != 0:
            return None, 'ld: ' + out.stderr.strip()
        out = r.run([tool('objcopy'), '-O', 'binary', elf, binf])
        if out.returncode != 0:
            return None, 'objcopy: ' + out.stderr.strip()
        return r.exec_rv(binf, elf, tool)

    # ---- ARM arm -------------------------------------------------------
    # Same cases, same expectations: the ARM backend also lowers every float
    # operation to an AEABI/libgcc call (it carries no helpers of its own any
    # more), so a wrong register pair or a wrong helper name must be caught on
    # both targets by the same numbers.
    arm_tool = None
    arm_libgcc = ''
    if args.arm_as:
        arm_tool = G.tool_finder('arm-none-eabi-', args.arm_as)
        if not arm_tool:
            print('cannot find arm-none-eabi binutils in %s' % args.arm_as)
            return 2
        arm_libgcc = args.arm_libgcc or G.find_arm_libgcc(args.arm_as)
        if not arm_libgcc or not os.path.exists(arm_libgcc):
            print('cannot find a no-FPU libgcc.a for arm-none-eabi '
                  '(pass --arm-libgcc); nothing was verified on ARM')
            return 2
        print('arm  libgcc: %s' % arm_libgcc)
        G.write(os.path.join(G.TMP, 'start_arm.s'), G.ARM_START)
        rc = r.run([arm_tool('as'), '-mcpu=cortex-m4',
                    os.path.join(G.TMP, 'start_arm.s'),
                    '-o', os.path.join(G.TMP, 'start_arm.o')])
        if rc.returncode != 0:
            print('cannot assemble the ARM harness: %s' % rc.stderr)
            return 2

    def run_arm(name, srcf):
        return r.arm('rf_arm_%s' % name, srcf, arm_tool, arm_libgcc)

    def sweep(tag, build, opt):
        """Run every case and report.  `opt` is the arkcc flag set for it."""
        r.opt = opt
        ok = bad = 0
        first = None
        for name, src, want in CASES:
            srcf = os.path.join(G.TMP, 'rf_%s_%s.c' % (tag, name))
            G.write(srcf, src)
            oracle, err = r.oracle(
                srcf, os.path.join(G.TMP, 'rf_%s_%s_gcc.exe' % (tag, name)))
            got, err2 = build(name, srcf)
            if first is None:
                first = (srcf, got)
            if oracle != want:
                # The oracle disagreeing with the hardcoded value means the
                # *test* is wrong (or gcc changed); say so instead of blaming
                # the backend.
                print('FAIL %-3s %-14s oracle=%r want=%r %s'
                      % (tag, name, oracle, want, err))
                bad += 1
                continue
            if got is None:
                print('FAIL %-3s %-14s build/run: %s' % (tag, name, err2))
                bad += 1
                continue
            if got != want:
                print('FAIL %-3s %-14s arkcc=%r want=%r' % (tag, name, got, want))
                bad += 1
                continue
            print('PASS %-3s %-14s %d' % (tag, name, got))
            ok += 1

        # Anti-false-green: a gate that cannot fail is not a gate.  Re-run the
        # first case and require the comparison to reject a neighbouring wrong
        # value -- if it accepts it, the loop above is not checking anything.
        name, _, want = CASES[0]
        got = first[1]
        if got is None:
            got, _ = build(name, os.path.join(G.TMP, 'rf_%s_%s.c' % (tag, name)))
        if got is not None and got == ((want + 1) & 0xFF):
            print('FAIL selfcheck[%s]: case %s cannot tell %d from %d'
                  % (tag, name, want, (want + 1) & 0xFF))
            bad += 1
        else:
            print('SELFCHECK[%s] expectation-mismatch: OK' % tag)
        print('=== %s: %d passed, %d failed ===' % (tag, ok, bad))
        return ok, bad

    ok = bad = 0
    a, b = sweep('rv', run_rv, [])
    ok += a
    bad += b
    if arm_tool:
        a, b = sweep('arm', run_arm, ['-fno-fpu'])
        ok += a
        bad += b

    print('=== TOTAL %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1

if __name__ == '__main__':
    sys.exit(main())
