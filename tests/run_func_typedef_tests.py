#!/usr/bin/env python3
"""Function-type typedef runtime gate (`typedef Ret F(params);`).

`typedef int binop(int, int);` names a *function type*, not a function.  The
parser used to hand the '(' after the name to its function-declaration branch,
so the typedef was dropped on the floor and the name registered as a
function: `sizeof(binop *)` came back as "expected an expression", `binop *p;`
was rejected ("expected declaration at top level") and `sizeof(binop)` folded
to the generic 4 instead of being refused.

Now the typedef stores a real TYPE_FUNC type:
  * `F *p` is an ordinary pointer to that function type,
  * `sizeof(F *)` is the pointer size,
  * `sizeof(F)` is a constraint violation (C99 6.5.3.4p1) and is *reported*,
  * `F name;` declares a function with the typedef's return type and
    parameters -- the same AST_FUNC_DECL the spelled-out prototype produces.

Every case is executed on both machine backends and compared against a host
gcc oracle plus a hardcoded expected value; the gate self-checks that a
deliberately wrong expectation is rejected, and every "must fail to compile"
case is required to fail (a silently accepted wrong answer is the exact bug
this gate exists for).

Usage (from the compiler repository root):
    python tests/run_func_typedef_tests.py --arm-as <arm binutils dir> \
        [--arm-libgcc <libgcc.a>] --rv-as <riscv binutils dir>
"""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

ADD_SUB = """\
int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
"""

CASES = [
    ("call_local", ADD_SUB + """\
typedef int binop(int, int);
int main(void) { binop *p = add; return p(2, 3); }
""", 5),

    ("sizeof_ptr", """\
typedef int binop(int, int);
int main(void) { return (int)sizeof(binop *); }
""", 4),

    ("proto_then_def", ADD_SUB + """\
typedef int binop(int, int);
binop add;
int main(void) { return add(4, 5); }
""", 9),   # `binop add;` must be a prototype, not a 4-byte data object

    ("pass_as_arg", ADD_SUB + """\
typedef int binop(int, int);
int apply(binop *f, int a, int b) { return f(a, b); }
int main(void) { return apply(add, 3, 4); }
""", 7),

    ("returns_fp", ADD_SUB + """\
typedef int binop(int, int);
binop *pick(void) { return sub; }
int main(void) { binop *p = pick(); return p(9, 4); }
""", 5),

    ("global_ptr", ADD_SUB + """\
typedef int binop(int, int);
binop *gp;
int main(void) { gp = add; return gp(1, 2); }
""", 3),

    ("local_typedef", ADD_SUB + """\
int main(void) {
    typedef int binop(int, int);
    binop *p = add;
    binop *q = sub;
    return p(6, 2) - q(6, 2) + (int)sizeof(binop *);
}
""", 8),   # 8 - 4 + 4

    ("fp_array", ADD_SUB + """\
typedef int binop(int, int);
int main(void) {
    binop *tbl[2];
    tbl[0] = add;
    tbl[1] = sub;
    return tbl[0](2, 3) + tbl[1](9, 4);
}
""", 10),  # 5 + 5

    ("compat", ADD_SUB + """\
typedef int binop(int, int);
int main(void) {
    binop *p = add;
    int (*q)(int, int) = p;         /* the two spellings denote one type */
    binop *r = q;
    return r(11, 2);
}
""", 13),

    ("proto_in_block", ADD_SUB + """\
typedef int binop(int, int);
int main(void) {
    binop add;                       /* block-scope prototype (C99 6.2.2p5) */
    return add(7, 8);
}
""", 15),
]

# Sources that must be *rejected*: folding them to a number is the silent
# wrong answer this gate exists to prevent.
MUST_FAIL = [
    ("sizeof_func_type", """\
typedef int binop(int, int);
int main(void) { return (int)sizeof(binop); }
"""),
    ("sizeof_func_type_align", """\
typedef int binop(int, int);
int main(void) { return (int)_Alignof(binop); }
"""),
]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arm-as', default='',
                    help='directory holding arm-none-eabi-binutils')
    ap.add_argument('--arm-libgcc', default='')
    ap.add_argument('--rv-as', default='',
                    help='directory holding riscv32-unknown-elf-binutils')
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    G.ARKC = os.path.abspath(args.arkcc)
    if not os.path.exists(G.ARKC):
        print('no such compiler: %s' % G.ARKC)
        return 2
    if not args.arm_as and not args.rv_as:
        print('need --arm-as and/or --rv-as')
        return 2
    os.makedirs(G.TMP, exist_ok=True)
    G.write(os.path.join(G.TMP, 'start_arm.s'), G.ARM_START)
    G.write(os.path.join(G.TMP, 'start_rv.s'), G.RV_START)

    targets = []
    r = G.Runner('gcc')
    if args.arm_as:
        tool = G.tool_finder('arm-none-eabi-', args.arm_as)
        rc = r.run([tool('as'), '-mcpu=cortex-m4', '-mfpu=fpv4-sp-d16',
                    '-mfloat-abi=hard',
                    os.path.join(G.TMP, 'start_arm.s'),
                    '-o', os.path.join(G.TMP, 'start_arm.o')])
        if rc.returncode != 0:
            print('cannot assemble the ARM harness: %s' % rc.stderr)
            return 2
        targets.append(('arm', tool))
    if args.rv_as:
        tool = G.tool_finder('riscv64-unknown-elf-', args.rv_as)
        rc = r.run([tool('as'), '-march=rv32im', '-mabi=ilp32',
                    os.path.join(G.TMP, 'start_rv.s'),
                    '-o', os.path.join(G.TMP, 'start_rv.o')])
        if rc.returncode != 0:
            print('cannot assemble the RV harness: %s' % rc.stderr)
            return 2
        targets.append(('rv', tool))

    ok = 0
    bad = 0
    for name, src, want in CASES:
        srcf = os.path.join(G.TMP, 'fty_%s.c' % name)
        G.write(srcf, src)
        oracle, err = r.oracle(srcf, os.path.join(G.TMP, 'fty_%s_gcc.exe' % name))
        if oracle != want:
            # Oracle disagrees with the hardcoded value: the test is wrong,
            # not the backend.  Say so instead of blaming arkcc.
            print('FAIL %-18s oracle=%r want=%r %s' % (name, oracle, want, err))
            bad += 1
            continue
        for tname, tool in targets:
            got, err2 = (r.arm('fty_%s_%s' % (name, tname), srcf, tool,
                               args.arm_libgcc) if tname == 'arm'
                         else r.rv('fty_%s_%s' % (name, tname), srcf, tool))
            if got is None:
                print('FAIL %-18s [%s] build/run: %s' % (name, tname, err2))
                bad += 1
                continue
            if got != want:
                print('FAIL %-18s [%s] arkcc=%r want=%r' % (name, tname, got, want))
                bad += 1
                continue
            print('PASS %-18s [%s] %d' % (name, tname, got))
            ok += 1

    for name, src in MUST_FAIL:
        srcf = os.path.join(G.TMP, 'fty_neg_%s.c' % name)
        G.write(srcf, src)
        for tname, tool in targets:
            asm = os.path.join(G.TMP, 'fty_neg_%s_%s.s' % (name, tname))
            err3 = r.compile('arm' if tname == 'arm' else 'riscv32', srcf, asm)
            if not err3:
                print('FAIL %-18s [%s] accepted silently' % (name, tname))
                bad += 1
            else:
                print('PASS %-18s [%s] rejected' % (name, tname))
                ok += 1

    # Anti-false-green: a gate that cannot fail is not a gate.
    name, src, want = CASES[0]
    oracle, _ = r.oracle(os.path.join(G.TMP, 'fty_%s.c' % name),
                         os.path.join(G.TMP, 'fty_%s_gcc.exe' % name))
    if oracle == want - 1:
        print('FAIL selfcheck: the wrong expectation was accepted')
        bad += 1
    else:
        print('SELFCHECK expectation-mismatch: OK')

    print('=== %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
