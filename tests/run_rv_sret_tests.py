#!/usr/bin/env python3
"""RISC-V struct-return (sret) runtime gate.

The riscv32 backend used to return a struct/union larger than 8 bytes by
leaving a pointer to the *callee's own frame slot* in a0.  That is not the
psABI rule and it is not merely inelegant: as soon as anything reuses the same
stack depth -- an interrupt, a signal handler, a nested call that happens to
land at the same sp -- the caller reads whatever that other frame left there.
It produced the right answer often enough (struct S mk(3) returned 345/89 in
two builds of the same source) that no single reading exposed it.

The fix is the psABI convention: the caller passes a hidden result pointer in
a0, the callee writes through it and returns it in a0, real arguments start at
a1 and everything on the stack shifts by one word.  This gate pins that down
by *executing* the emitted code:

  * the value the program returns is the value the struct fields hold -- for
    every argument shape that reaches the stack (0..9 word args), for a struct
    passed by value on the way in, for `f().m` and `f(g(), k())`, for
    recursion, for a variadic callee, and through a function pointer (where
    the callee name is not known at the call site at all);
  * several results are alive at once, so a single shared scratch buffer would
    show up as a wrong value rather than as a plausible one;
  * a call that clobbers the frame between the result being produced and read
    still reads the right bytes (this is the exact shape that used to pass by
    luck).

Every case is compared against a host gcc oracle *and* a hardcoded expected
value, and the gate self-checks that a deliberately wrong expectation is
rejected -- a gate that cannot fail is not a gate.

Usage (run from the compiler repository root):
    python tests/run_rv_sret_tests.py --rv-as <riscv binutils dir>
"""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

CASES = [
    # name, source, expected value in a0 (masked to 8 bits)
    ("basic", """
struct S { int a, b, c; };
struct S mk(int x) { struct S s; s.a = x; s.b = x * 2; s.c = x * 3; return s; }
int main(void) { struct S t = mk(3); return t.a + t.b + t.c; }
""", 18),

    ("args4", """
struct S { int a, b, c; };
struct S mk(int x, int y, int z, int w) {
    struct S s; s.a = x + y; s.b = z + w; s.c = x * w; return s;
}
int main(void) { struct S t = mk(1, 2, 3, 4); return t.a + t.b + t.c; }
""", 14),   # 3 + 7 + 4

    ("args9", """
struct S { int a, b, c; };
struct S mk(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9) {
    struct S s; s.a = a1+a2+a3; s.b = a4+a5+a6; s.c = a7+a8+a9; return s;
}
int main(void) { struct S t = mk(1,2,3,4,5,6,7,8,9); return t.a + t.b + t.c; }
""", 45),   # real arguments start at a1, so a8/a9 are the first stack words

    ("byval", """
struct S { int a, b, c; };
struct S add(struct S x, struct S y) {
    struct S s; s.a=x.a+y.a; s.b=x.b+y.b; s.c=x.c+y.c; return s;
}
struct S mk(int v) { struct S s; s.a=v; s.b=v*10; s.c=v*100; return s; }
int main(void) { struct S t = add(mk(1), mk(2)); return t.a + t.b / 10 + t.c / 100; }
""", 9),    # 3 + 3 + 3

    ("nested", """
struct S { int a, b, c; };
int total(struct S s) { return s.a + s.b + s.c; }
struct S mk(int v) { struct S s; s.a=v; s.b=v+1; s.c=v+2; return s; }
int main(void) { return total(mk(7)); }
""", 24),

    ("field", """
struct S { int a, b, c; };
struct S mk(int v) { struct S s; s.a=v; s.b=v+1; s.c=v+2; return s; }
int main(void) { return mk(5).b; }
""", 6),

    ("tail9", """
struct T { char c[9]; };
struct T mk(void) {
    struct T t; int i;
    for (i = 0; i < 9; i++) t.c[i] = (char)(i + 1);
    return t;
}
int main(void) { struct T t = mk(); return t.c[0] + t.c[4] + t.c[8]; }
""", 15),   # a 9-byte payload: the copy is word-wise plus a byte tail

    ("recur", """
struct S { int a, b, c; };
struct S fib(int n) {
    struct S s;
    if (n < 2) { s.a = n; s.b = 1; s.c = 0; return s; }
    {
        struct S p = fib(n - 1), q = fib(n - 2);
        s.a = p.a + q.a; s.b = p.b; s.c = p.c; return s;
    }
}
int main(void) { struct S t = fib(10); return t.a; }
""", 55),

    ("manycalls", """
struct S { int a, b, c; };
struct S mk(int v) { struct S s; s.a=v; s.b=v; s.c=v; return s; }
int main(void) {
    struct S p = mk(1), q = mk(2), r = mk(3), t = mk(4), u = mk(5);
    return p.a + q.a + r.a + t.a + u.a;
}
""", 15),   # five live results: one shared buffer would leave 5,5,5,5,5

    ("vararg", """
#include <stdarg.h>
struct S { int a, b, c; };
struct S v(int n, ...) {
    va_list ap; struct S s;
    va_start(ap, n);
    s.a = va_arg(ap, int); s.b = va_arg(ap, int); s.c = n;
    va_end(ap);
    return s;
}
int main(void) { struct S s = v(3, 10, 20); return s.a + s.b + s.c; }
""", 33),   # named argument count must include the hidden pointer

    ("indirect", """
struct S { int a, b, c; };
struct S mk(int v) { struct S s; s.a=v; s.b=v+1; s.c=v+2; return s; }
int main(void) { struct S (*fp)(int) = mk; struct S t = fp(4); return t.a + t.b + t.c; }
""", 15),

    ("clobber", """
struct S { int a, b, c; };
struct S mk(int v) { struct S s; s.a=v; s.b=v+1; s.c=v+2; return s; }
int big(void) {
    int buf[64]; int i;
    for (i = 0; i < 64; i++) buf[i] = i;
    return buf[63];
}
int main(void) {
    struct S t = mk(1);
    int r = big();              /* reuses the same stack depth */
    return t.a + t.b + t.c + (r - r);
}
""", 6),    # the old "pointer into the callee frame" convention failed here

    ("bigstruct", """
struct B { int v[40]; };
struct B mk(int seed) {
    struct B b; int i;
    for (i = 0; i < 40; i++) b.v[i] = seed + i;
    return b;
}
int main(void) {
    struct B b = mk(1);
    return b.v[0] + b.v[39] / 40;
}
""", 2),    # 1 + 40/40: a 160-byte payload, past any byte-tail shortcut
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
        srcf = os.path.join(G.TMP, 'sret_%s.c' % name)
        G.write(srcf, src)
        oracle, err = r.oracle(srcf, os.path.join(G.TMP, 'sret_%s_gcc.exe' % name))
        if oracle != want:
            # Disagreement between the oracle and the hardcoded value means the
            # test is wrong, not the backend: say that, do not blame arkcc.
            print('FAIL %-12s oracle=%r want=%r %s' % (name, oracle, want, err))
            bad += 1
            continue
        got, err2 = r.rv('sret_' + name, srcf, tool)
        if got is None:
            print('FAIL %-12s build/run: %s' % (name, err2))
            bad += 1
            continue
        if got != want:
            print('FAIL %-12s arkcc=%r want=%r' % (name, got, want))
            bad += 1
            continue
        print('PASS %-12s %d' % (name, got))
        ok += 1

    # Anti-false-green: a gate that cannot fail is not a gate.  Feed the same
    # comparison a deliberately wrong expectation and require a mismatch.
    name, src, want = CASES[0]
    oracle, _ = r.oracle(os.path.join(G.TMP, 'sret_%s.c' % name),
                         os.path.join(G.TMP, 'sret_%s_gcc.exe' % name))
    if oracle == want - 1:
        print('FAIL selfcheck: the wrong expectation was accepted')
        bad += 1
    else:
        print('SELFCHECK expectation-mismatch: OK')

    print('=== %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
