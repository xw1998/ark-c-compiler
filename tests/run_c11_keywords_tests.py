#!/usr/bin/env python3
"""C11 keyword gate: _Alignof / _Alignas / _Static_assert.

Everything here is checked against a hardcoded expectation, and every runtime
case is decided by an address or a value the program computes itself -- a
directive in the assembly proves nothing (the ARM backend used to place global
objects with a flat 4-byte round-up regardless of `__align`, and the RISC-V
backend only ever emitted .align when align_bytes > the natural one).

What this gate is really protecting:

  * `_Alignof` must be folded at parse time from the *type*, not from the
    expression's default int (the size path had exactly that bug once: every
    `sizeof(call)` reported 4).
  * `_Alignas` may never weaken the natural alignment (C11 6.7.5p6).  The
    "never_weakens" case asks for _Alignas(2) on a double and requires the
    object to still be 8-aligned.
  * `_Alignas` at block scope above 8 bytes is *refused*, not silently
    dropped: the frame is built as `sp -= N; base = sp` with sp only 8-byte
    aligned, so honouring 16/32/64 there would be a fabricated answer.
  * `_Static_assert` must actually be *evaluated*.  The control pair below
    proves it: a true assertion compiles and a false one fails.  A compiler
    that merely skipped the construct would pass only the first half.

Usage (run from the compiler repository root):
    python tests/run_c11_keywords_tests.py --arm-as <arm-none-eabi bin dir>
        [--rv-as <riscv bin dir>]
"""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

# name, source, expected exit status (return code & 0xFF)
RUNTIME = [
    # 1 + 2 + 4 + 8 + 8 = 23
    ("alignof_scalars", """
int main(void) {
    int s = (int)_Alignof(char) + (int)_Alignof(short) + (int)_Alignof(int)
          + (int)_Alignof(long long) + (int)_Alignof(double);
    return s + 100;
}
""", 123),

    # struct 4 + union 8 + char[5] 1 + int* 4 + typedef'd int[4] 4 = 21
    ("alignof_derived", """
struct S { char c; int i; };
union U { char c; double d; };
typedef int vec4[4];
int main(void) {
    int s = (int)_Alignof(struct S) + (int)_Alignof(union U)
          + (int)_Alignof(char[5]) + (int)_Alignof(int*)
          + (int)_Alignof(vec4);
    return s + 100;
}
""", 121),

    # _Alignas on a member: offset 16, struct alignment 16, size 32
    ("alignas_member", """
struct A { char c; _Alignas(16) int x; };
_Static_assert(sizeof(struct A) == 32, "size");
_Static_assert(_Alignof(struct A) == 16, "align");
int main(void) {
    struct A a;
    char *p = (char *)&a;
    char *q = (char *)&a.x;
    return (int)(q - p) + 100;
}
""", 116),

    # A global 64-aligned: the flat layout used to round every object to 4,
    # which put this one at 0x20000004 and made the check fail.
    ("alignas_global", """
char pad;
_Alignas(64) int g;
int main(void) {
    return ((unsigned)&g & 63u) == 0 ? 42 : 0;
}
""", 42),

    # 8 is inside the frame guarantee, so it must be honoured.
    ("alignas_local_8", """
int main(void) {
    _Alignas(8) char buf[3];
    buf[0] = 1;
    if (((unsigned)buf & 7u) != 0) return 0;
    return buf[0] + 8;
}
""", 9),

    # 6.7.5p6: a weaker request never reduces the natural alignment.
    ("alignas_never_weakens", """
_Alignas(2) double d;
_Alignas(1) long long q;
int main(void) {
    int s = 0;
    if (((unsigned)&d & 7u) != 0) s += 1;
    if (((unsigned)&q & 7u) != 0) s += 2;
    return s == 0 ? 77 : s;
}
""", 77),

    # _Alignas(type-name) form.
    ("alignas_type_form", """
_Alignas(double) char c;
int main(void) {
    return ((unsigned)&c & 7u) == 0 ? 55 : 1;
}
""", 55),

    # File scope, block scope and an enum constant all fold.
    ("static_assert_ok", """
_Static_assert(sizeof(int) == 4, "int");
enum { N = 3 };
_Static_assert(N == 3, "N");
int main(void) {
    _Static_assert(1 + 1 == 2, "arith");
    return 42;
}
""", 42),

    # _Generic: the controlling expression is matched on its *declared* type.
    # char stays char (no promotion to int), long and double are distinct, and
    # an `int *` association must not be selected for an `int *` variable's
    # neighbour types.
    ("generic_select", """
int main(void) {
    char c = 0;
    int i = 0;
    long l = 0;
    double d;              /* only its type is asked for: _Generic is not evaluated */
    int *p = 0;
    int s = 0;
    s += _Generic(c, char: 1, int: 2, default: 4);
    s += _Generic(i, char: 8, int: 16, default: 32);
    s += _Generic(l, long: 32, default: 64);
    s += _Generic(d, float: 4, double: 8, default: 2);
    s += _Generic(p, int*: 16, default: 1);
    return s;
}
""", 73),

    # Conversions applied to the controlling expression (C11 6.5.1.1p2):
    # array-to-pointer, string literal, function-to-pointer -- and a *data*
    # pointer association must be rejected for a function designator, which is
    # the case the compiler used to answer wrongly (the symbol table only keeps
    # a function's return type).
    ("generic_conversions", """
static int f(int x) { return x; }
int main(void) {
    char buf[4];
    int s = 0;
    s += _Generic(buf, char *: 1, default: 100);
    s += _Generic("lit", char *: 2, default: 100);
    s += _Generic(f, int (*)(int): 4, default: 100);
    s += _Generic(&f, int (*)(int): 8, default: 100);
    s += _Generic(*f, int (*)(int): 16, default: 100);
    s += _Generic((char)0, char: 32, int: 100);
    s += _Generic(f, int *: 100, default: 1);
    return s;
}
""", 64),

    # A matching association beats `default`, and `default` is used when no
    # type-name is compatible (1.0f is a float, not a double).
    ("generic_default", """
int main(void) {
    int r = _Generic(1.0f, double: 5, default: 44);
    r += _Generic(3, default: 9, int: 11);
    return r;
}
""", 55),
]

# name, source, substring that MUST appear in the diagnostic
DIAG = [
    ("static_assert_false",
     '_Static_assert(1 == 2, "boom");\nint main(void) { return 0; }\n',
     "static assertion failed: boom"),
    ("static_assert_nonconst",
     'int x;\n_Static_assert(x, "x");\nint main(void) { return 0; }\n',
     "not an integer constant expression"),
    ("alignof_expression",
     'int main(void) { int x = 0; return _Alignof(x); }\n',
     "_Alignof requires a type name"),
    ("alignas_not_power_of_two",
     '_Alignas(3) int g;\nint main(void) { return 0; }\n',
     "power-of-two"),
    ("alignas_nonconst",
     'int n;\n_Alignas(n) int g;\nint main(void) { return 0; }\n',
     "_Alignas requires an integer constant expression"),
    ("alignas_local_too_big",
     'int main(void) {\n    _Alignas(32) char buf[8];\n    return buf[0];\n}\n',
     "block-scope _Alignas above 8 bytes is not supported"),
    ("generic_no_match",
     'int main(void) { int i = 0; return _Generic(i, double: 1); }\n',
     "no type in the _Generic association list matches"),
    ("generic_two_defaults",
     'int main(void) { int i = 0; return _Generic(i, int: 1, default: 2, default: 3); }\n',
     "more than one default association"),
]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arm-as', required=True,
                    help='directory holding arm-none-eabi binutils')
    ap.add_argument('--rv-as', default=None,
                    help='directory holding riscv32 binutils (optional)')
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    G.ARKC = os.path.abspath(args.arkcc)
    if not os.path.exists(G.ARKC):
        print('no such compiler: %s' % G.ARKC)
        return 2
    os.makedirs(G.TMP, exist_ok=True)
    G.write(os.path.join(G.TMP, 'start_arm.s'), G.ARM_START)
    G.write(os.path.join(G.TMP, 'start_rv.s'), G.RV_START)

    r = G.Runner('gcc')
    ok = bad = 0
    targets = []

    arm_tool = G.tool_finder('arm-none-eabi-', args.arm_as)
    if not arm_tool:
        print('cannot find arm-none-eabi binutils in %s' % args.arm_as)
        return 2
    r.arm_rc = r.run([arm_tool('as'), '-mcpu=cortex-m4',
                      os.path.join(G.TMP, 'start_arm.s'),
                      '-o', os.path.join(G.TMP, 'start_arm.o')])
    if r.arm_rc.returncode != 0:
        print('cannot assemble the ARM harness: %s' % r.arm_rc.stderr)
        return 2
    targets.append(('arm', arm_tool))

    if args.rv_as:
        rv_tool = G.tool_finder('riscv64-unknown-elf-', args.rv_as)
        if not rv_tool:
            print('cannot find riscv binutils in %s' % args.rv_as)
            return 2
        rc = r.run([rv_tool('as'), '-march=rv32im', '-mabi=ilp32',
                    os.path.join(G.TMP, 'start_rv.s'),
                    '-o', os.path.join(G.TMP, 'start_rv.o')])
        if rc.returncode != 0:
            print('cannot assemble the RV harness: %s' % rc.stderr)
            return 2
        targets.append(('rv32', rv_tool))

    # ---- runtime cases ---------------------------------------------------
    for tgt, tool in targets:
        run = r.arm if tgt == 'arm' else r.rv
        for name, src, want in RUNTIME:
            tag = 'c11_%s_%s' % (tgt, name)
            srcf = os.path.join(G.TMP, tag + '.c')
            G.write(srcf, src)
            if tgt == 'arm':
                oracle, err = r.oracle(srcf, os.path.join(G.TMP, tag + '_gcc.exe'))
                # The host gcc here is MinGW32 GCC 4.8 -- it predates C11 and
                # cannot parse _Alignas/_Alignof at all, so a missing oracle is
                # an environment fact, not a sign that the test is wrong.  When
                # it does produce a number, a disagreement still fails the case.
                if oracle is not None and oracle != want:
                    print('FAIL %-10s %-24s oracle=%r want=%r (the test is '
                          'wrong: %s)' % (tgt, name, oracle, want, err.strip()[:70]))
                    bad += 1
                    continue
                if oracle is None:
                    print('note %-10s %-24s no host oracle (gcc predates C11); '
                          'hardcoded expectation used' % (tgt, name))
            got, err2 = run(tag, srcf, tool)
            if got is None:
                print('FAIL %-10s %-24s build/run: %s'
                      % (tgt, name, err2.strip()[:160]))
                bad += 1
                continue
            if got != want:
                print('FAIL %-10s %-24s arkcc=%r want=%r' % (tgt, name, got, want))
                bad += 1
                continue
            print('PASS %-10s %-24s %d' % (tgt, name, got))
            ok += 1

    # ---- diagnostics -----------------------------------------------------
    # These must be *refused*.  A compiler that ignored the construct would
    # build them happily, so "compiles" is the failure mode here.
    for name, src, needle in DIAG:
        srcf = os.path.join(G.TMP, 'c11_diag_%s.c' % name)
        G.write(srcf, src)
        err = r.compile('arm', srcf, os.path.join(G.TMP, 'c11_diag_%s.s' % name))
        if not err:
            print('FAIL diag     %-24s compiled, expected an error' % name)
            bad += 1
            continue
        if needle not in err:
            print('FAIL diag     %-24s missing %r in: %s'
                  % (name, needle, err.strip().replace('\n', ' | ')[:160]))
            bad += 1
            continue
        print('PASS diag     %-24s %s' % (name, needle))
        ok += 1

    # ---- controls --------------------------------------------------------
    # (1) _Static_assert is really evaluated: the same assertion with a true
    #     condition must build.  Without this pair the failing case above could
    #     be satisfied by a compiler that rejected everything.
    good = '_Static_assert(_Alignof(int) == 4, "ok");\nint main(void) { return 0; }\n'
    srcf = os.path.join(G.TMP, 'c11_ctrl_true.c')
    G.write(srcf, good)
    err = r.compile('arm', srcf, os.path.join(G.TMP, 'c11_ctrl_true.s'))
    if err:
        print('FAIL control  true _Static_assert rejected: %s'
              % err.strip()[:160])
        bad += 1
    else:
        print('SELFCHECK static_assert-is-evaluated: OK')

    # (2) _Alignof/_Static_assert must be folded from types, not from a
    #     constant-4 default: char is 1 and a wrong answer has to be refused.
    wrong = '_Static_assert(_Alignof(char) == 4, "no");\nint main(void) { return 0; }\n'
    srcf = os.path.join(G.TMP, 'c11_ctrl_wrong.c')
    G.write(srcf, wrong)
    err = r.compile('arm', srcf, os.path.join(G.TMP, 'c11_ctrl_wrong.s'))
    if not err or '_Alignof' not in err:
        print('FAIL control  _Alignof(char)==4 was accepted -- _Alignof is not '
              'producing a real alignment: %s' % err.strip()[:120])
        bad += 1
    else:
        print('SELFCHECK alignof-not-default-4: OK')

    # (3) Anti-false-green: the comparison must be able to tell the expected
    #     value from a neighbour.
    name, src, want = RUNTIME[0]
    srcf = os.path.join(G.TMP, 'c11_selfcheck.c')
    G.write(srcf, src)
    got, _ = r.arm('c11_selfcheck', srcf, arm_tool)
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
