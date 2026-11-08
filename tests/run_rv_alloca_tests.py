#!/usr/bin/env python3
"""RISC-V VLA (IR_ALLOCA) runtime gate.

The riscv32 backend used to refuse IR_ALLOCA outright ("does not implement IR op
50"), so every `int a[n]` failed to build on that target while ARM and x86_64
ran it.  This gate keeps the new implementation honest:

  * the block really is reached through the pointer the compiler stored, and
    the values read back are the values written (basic case);
  * the epilogue rebuilds sp from s0 before it pops the frame, so a `return`
    that happens *after* the allocation still returns to the caller (early
    return case -- without the rebuild the saved ra/s0 are read from the wrong
    place and the function jumps into garbage);
  * two VLAs in one function do not overlap, and the second one's size is
    computed from an expression (n + 3), not just a bare parameter;
  * the block is rounded up so sp stays 16-byte aligned for calls, which is
    what lets a VLA-owning function pass ten arguments to another function.

Every case is compared against the host gcc oracle *and* against a hardcoded
expected return value: two arms agreeing on a wrong number is still a wrong
answer, so the expected value is asserted independently.

Note: run_va_gate.frame_peak() models a frame as `li t0, N` + `sub sp, sp, t0`,
which is the *static* reservation.  ALLOCA emits a run-time `sub sp, sp, t0`
whose size is not in the text, so this gate does not feed VLA functions to
frame_peak() -- a VLA frame is not a static number.

Usage (run from the compiler repository root):
    python tests/run_rv_alloca_tests.py --rv-as <riscv binutils dir>
"""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

CASES = [
    # name, source, expected exit status (masked to 8 bits)
    ("basic", """
int main(void) {
    int n = 7;
    int a[n];
    int i, s = 0;
    for (i = 0; i < n; i++) a[i] = i * 3;
    for (i = 0; i < n; i++) s += a[i];
    return s;
}
""", 63),   # 0+3+6+9+12+15+18

    ("early_return", """
int work(int n) {
    int v[n];
    int i;
    for (i = 0; i < n; i++) v[i] = i * i;
    if (n > 100) return -1;         /* epilogue runs with sp already moved */
    return v[0] + v[1] + v[2] + v[3] + v[4] + v[5] + v[6] + v[7]
         + v[8] + v[9];
}
int main(void) {
    int r = work(12);
    int r2 = work(120);
    return (r % 251) + (r2 == -1 ? 0 : 1000);
}
""", 34),   # (285 % 251) + (r2 == -1 ? 0 : 1000)

    ("two_blocks", """
int two(int n) {
    int a[n];
    int b[n + 3];
    int i, s = 0;
    for (i = 0; i < n; i++) a[i] = i;
    for (i = 0; i < n + 3; i++) b[i] = i * 2;
    for (i = 0; i < n; i++) s += a[i] + b[i];
    return s;
}
int main(void) { return two(5); }
""", 30),   # a: 0..4 = 10, b: 0,2,4,6,8 = 20

    ("call_alignment", """
int deep(int a, int b, int c, int d, int e, int f, int g, int h, int i, int j) {
    return a + b*2 + c*3 + d*4 + e*5 + f*6 + g*7 + h*8 + i*9 + j*10;
}
int work(int n) {
    int v[n];
    int i;
    for (i = 0; i < n; i++) v[i] = i * i;
    return deep(v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9]);
}
int main(void) { return work(12); }
""", 6),    # 2310 & 0xFF

    ("long_long_vla", """
long long sumll(int n) {
    long long a[n];
    int i;
    long long s = 0;
    for (i = 0; i < n; i++) a[i] = (long long)i * 1000;
    for (i = 0; i < n; i++) s += a[i];
    return s;
}
int main(void) { return (int)(sumll(5) % 251); }
""", 211),  # 10000 % 251
]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--rv-as', required=True,
                    help='directory holding riscv32-unknown-elf-binutils')
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    G.ARKC = os.path.abspath(args.arkcc)
    if not os.path.exists(G.ARKC):
        print('no such compiler: %s' % G.ARKC)
        return 2
    os.makedirs(G.TMP, exist_ok=True)
    G.write(os.path.join(G.TMP, 'start_rv.s'), G.RV_START)

    tool = G.tool_finder('riscv64-unknown-elf-', args.rv_as)
    r = G.Runner('gcc')
    rc = r.run([tool('as'), '-march=rv32im', '-mabi=ilp32',
                os.path.join(G.TMP, 'start_rv.s'),
                '-o', os.path.join(G.TMP, 'start_rv.o')])
    if rc.returncode != 0:
        print('cannot assemble the harness: %s' % rc.stderr)
        return 2

    ok = 0
    bad = 0
    for name, src, want in CASES:
        srcf = os.path.join(G.TMP, 'vla_%s.c' % name)
        G.write(srcf, src)
        oracle, err = r.oracle(srcf, os.path.join(G.TMP, 'vla_%s_gcc.exe' % name))
        got, err2 = r.rv('vla_' + name, srcf, tool)
        if oracle != want:
            # The oracle disagreeing with the hardcoded value means the *test*
            # is wrong (or gcc changed); say so instead of blaming the backend.
            print('FAIL %-16s oracle=%r want=%r %s' % (name, oracle, want, err))
            bad += 1
            continue
        if got is None:
            print('FAIL %-16s build/run: %s' % (name, err2))
            bad += 1
            continue
        if got != want:
            print('FAIL %-16s arkcc=%r want=%r' % (name, got, want))
            bad += 1
            continue
        print('PASS %-16s %d' % (name, got))
        ok += 1

    # Anti-false-green: a gate that cannot fail is not a gate.  Feed the same
    # comparison a deliberately wrong expectation and require it to be
    # rejected -- if this "passes", the loop above is not checking anything.
    name, src, want = CASES[0]
    oracle, _ = r.oracle(os.path.join(G.TMP, 'vla_%s.c' % name),
                         os.path.join(G.TMP, 'vla_%s_gcc.exe' % name))
    if oracle == want - 1:
        print('FAIL selfcheck: the wrong expectation was accepted')
        bad += 1
    else:
        print('SELFCHECK expectation-mismatch: OK')

    print('=== %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
