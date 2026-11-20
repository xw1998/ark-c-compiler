#!/usr/bin/env python
"""Gate for bit-field read-modify-write: ++/-- and compound assignment.

What the bug was
----------------
`++`/`--` on a bit-field member went through the generic lvalue path, which
treats the member as a word of its own type: it loaded the whole storage unit,
added the step to *that word*, and stored it back.  Every neighbouring field
therefore moved with it.  Measured with

    struct S { unsigned a:4; unsigned b:5; int c:6; };
    struct S s; s.a = 1; s.b = 2; s.c = 3; s.b++;

the result was a = 2, b = 2 instead of a = 1, b = 3 -- a wrong answer with no
diagnostic, and the same shape as the compound-assign bug that the
IR_LOAD_FLD/IR_STORE_FLD path fixed earlier for `s.b += 1`.

What this gate checks
---------------------
  * postfix `++`/`--` (the value of the expression is the *old* one), including
    a field that wraps at its width boundary -- the field wraps but the
    expression must still yield the pre-increment value;
  * prefix `++`/`--` on signed fields (the sign bit has to come back through
    IR_LOAD_FLD's 0x100 flag) and on an unsigned field that wraps;
  * the same operations through a pointer (`p->b++`), on an array element
    (`v[i].a++`), and next to a plain word member that must not move;
  * compound assignment (`s.a += 3`, `s.c *= -2`) as the neighbouring path --
    it shares the address/result discipline and must not regress;
  * every value is produced by running the linked image on the ARM emulator,
    so a wrong field position or a wrong width is a wrong number, not a
    printout that has to be read;
  * three anti-false-green self checks: the harness must reject a deliberately
    wrong expectation, a valid program must compile with exit status 0 (so the
    checks are not passing because everything fails), and an empty program
    must still run.

Usage: run_bitfield_tests.py [--arkcc path]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
import argparse
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
try:
    from run_arm_exec import run_image
    HAVE_UNICORN = True
except Exception:                                       # pragma: no cover
    HAVE_UNICORN = False

# A local stub for __arkcc_init_globals would win the duplicate-symbol merge
# and leave every global at 0 (see run_complit_tests.py), so the startup only
# declares it.
STARTUP = '''\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void) { __arkcc_init_globals(); return main(); }
'''

BF_COMPOUND = STARTUP + '''\
struct S { unsigned a:4; unsigned b:5; int c:6; };
int main(void)
{
    struct S s = {1, 2, 3};
    s.a += 3;            /* 4 */
    s.b++;               /* 3 */
    s.c *= -2;           /* -6 */
    if (s.a != 4) return 91;
    if (s.b != 3) return 92;
    if (s.c != -6) return 93;
    return s.a * 25 + s.b * 5 + (s.c + 6);   /* 100 + 15 + 0 = 115 */
}
'''

BF_COMPOUND_WRAP = STARTUP + '''\
struct S { unsigned a:4; unsigned b:4; };
int main(void)
{
    struct S s = {0xF, 0x3};
    s.a += 1;            /* wraps to 0, b must stay 3 */
    if (s.b != 3) return 91;
    if (s.a != 0) return 92;
    return 20;
}
'''

BF_POSTFIX_WRAP = STARTUP + '''\
struct S { unsigned a:4; unsigned b:5; int c:6; };
int main(void)
{
    struct S s;
    s.a = 1; s.b = 31; s.c = 3;
    int r1 = s.b++;          /* 31, field wraps to 0 */
    int r2 = s.b;            /* 0 */
    int r3 = s.a--;          /* 1, a -> 0 */
    int r4 = s.a;            /* 0 */
    if (s.c != 3) return 91; /* the neighbour must not move */
    return r1 * 7 + r2 * 5 + r3 * 3 + r4;   /* 217 + 0 + 3 + 0 = 220 */
}
'''

BF_PREFIX_SIGNED = STARTUP + '''\
struct S { signed int a:4; signed int b:5; unsigned c:3; };
int main(void)
{
    struct S s;
    s.a = 6; s.b = -3; s.c = 5;
    int r1 = ++s.a;          /* 7 */
    int r2 = --s.b;          /* -4 */
    int r3 = ++s.c;          /* 6 */
    if (s.a != 7 || s.b != -4 || s.c != 6) return 91;
    return r1 * 10 + r2 + 40 + r3;          /* 70 - 4 + 40 + 6 = 112 */
}
'''

BF_THROUGH_POINTER = STARTUP + '''\
struct S { unsigned a:4; unsigned b:5; unsigned c:7; };
int step(struct S *p)
{
    unsigned x = p->b++;
    unsigned y = ++p->c;
    return (int)(x * 10 + y * 100 + p->a + p->b);
}
int main(void)
{
    struct S s; s.a = 2; s.b = 30; s.c = 5;
    int r = step(&s);
    if (s.b != 31) return 91;
    if (s.c != 6) return 92;
    return r % 251;                          /* 300 + 600 + 2 + 31 = 933 % 251 = 180 */
}
'''

BF_IN_ARRAY = STARTUP + '''\
struct S { unsigned a:3; unsigned b:6; };
int main(void)
{
    struct S v[3];
    int i;
    for (i = 0; i < 3; i++) { v[i].a = i; v[i].b = 60 + i; }
    v[1].a++;                /* 1 -> 2 */
    v[2].b++;                /* 62 -> 63 */
    v[0].b--;                /* 60 -> 59 */
    if (v[0].b != 59) return 91;
    if (v[1].a != 2) return 92;
    if (v[2].b != 63) return 93;
    return v[0].b + v[1].a * 10 + v[2].b;    /* 59 + 20 + 63 = 142 */
}
'''

BF_PLAIN_WORD_NEIGHBOUR = STARTUP + '''\
struct S { unsigned a:4; unsigned b:5; int c; };
int main(void)
{
    struct S s; s.a = 1; s.b = 2; s.c = 1000;
    s.b++;
    s.a--;
    if (s.a != 0) return 91;
    if (s.b != 3) return 92;
    if (s.c != 1000) return 93;
    return 7;
}
'''

BF_EXPRESSION_VALUE = STARTUP + '''\
struct S { int hi:8; int lo:8; };
int main(void)
{
    struct S s; s.hi = 10; s.lo = -1;
    /* The value of a prefix/postfix expression is used in a larger
     * expression: both have to carry the field's own signed value. */
    int a = s.lo++ + 100;        /* -1 + 100 = 99, lo becomes 0 */
    int b = ++s.lo;              /* 1 */
    int c = s.hi-- * 2;          /* 20, hi becomes 9 */
    if (s.hi != 9) return 91;
    return a + b + c;            /* 99 + 1 + 20 = 120 */
}
'''

CASES = [
    ('bf_compound',            BF_COMPOUND,            115),
    ('bf_compound_wrap',       BF_COMPOUND_WRAP,        20),
    ('bf_postfix_wrap',        BF_POSTFIX_WRAP,        220),
    ('bf_prefix_signed',       BF_PREFIX_SIGNED,       112),
    ('bf_through_pointer',     BF_THROUGH_POINTER,     180),
    ('bf_in_array',            BF_IN_ARRAY,            142),
    ('bf_plain_word_neighbour', BF_PLAIN_WORD_NEIGHBOUR, 7),
    ('bf_expression_value',    BF_EXPRESSION_VALUE,    120),
]

TARGET_ARGS = ['-target', 'arm', '-c', '--vector-table', '-mcpu', 'cortex-m0']


def run(cmd):
    return subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                          universal_newlines=True)


def build_and_run(arkcc, src, tmp, name):
    """Compile one TU, link it alone, run it.  Returns (value, error)."""
    c = os.path.join(tmp, name + '.c')
    obj = os.path.join(tmp, name + '.obj')
    img = os.path.join(tmp, name + '.bin')
    with open(c, 'w', newline='\n') as f:
        f.write(src)
    r = run([arkcc, c] + TARGET_ARGS + ['-o', obj])
    if r.returncode:
        return None, 'compile: ' + r.stdout.strip()[:300]
    r = run([arkcc, '-link', obj, '--vector-table', '-mcpu', 'cortex-m0',
             '-o', img])
    if r.returncode:
        return None, 'link: ' + r.stdout.strip()[:300]
    with open(img, 'rb') as f:
        data = f.read()
    try:
        status, val, detail = run_image(data, 40000000)
    except Exception as exc:                            # pragma: no cover
        return None, 'run: %s' % exc
    if status != 'returned':
        return None, 'run: emulator %s %s' % (status, detail)
    return val, ''


def compile_only_status(arkcc, src, tmp, name):
    c = os.path.join(tmp, name + '.c')
    obj = os.path.join(tmp, name + '.obj')
    with open(c, 'w', newline='\n') as f:
        f.write(src)
    r = run([arkcc, c] + TARGET_ARGS + ['-o', obj])
    return r.returncode, r.stdout.strip()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc', default=os.path.join(os.path.dirname(HERE),
                                                    'arkcc.exe'))
    args = ap.parse_args()
    if not os.path.exists(args.arkcc):
        sys.stderr.write('arkcc not found: %s\n' % args.arkcc)
        return 2
    if not HAVE_UNICORN:
        sys.stderr.write('the ARM emulator (unicorn) is not available\n')
        return 2

    tmp = tempfile.mkdtemp(prefix='ark_bitfield_')
    passes = 0
    failures = []

    def check(ok, name, why=''):
        nonlocal passes
        if ok:
            passes += 1
            print('ok   %s' % name)
        else:
            failures.append(name)
            print('FAIL %s  %s' % (name, why))

    try:
        for name, src, want in CASES:
            val, err = build_and_run(args.arkcc, src, tmp, name)
            if val is None:
                check(False, name, err)
            else:
                check(val == want, name,
                      '' if val == want else 'returned %d, want %d' % (val, want))

        # --- anti-false-green -------------------------------------------
        # 1. the comparison above must reject a wrong expectation.
        val, err = build_and_run(args.arkcc, CASES[0][1], tmp, 'bf_compound')
        check(val is not None and val != CASES[0][2] + 1,
              'self:wrong-expectation-rejected',
              '' if val is not None else err)

        # 2. a valid program has to compile cleanly, so the failures above are
        #    not the harness rejecting everything.
        rc, out = compile_only_status(args.arkcc, CASES[0][1], tmp, 'bf_compound')
        check(rc == 0, 'self:valid-program-accepted', out[:200])

        # 3. an empty program must still link and run.
        val, err = build_and_run(args.arkcc,
                                 STARTUP + 'int main(void) { return 0; }\n',
                                 tmp, 'self_empty')
        check(val == 0, 'self:empty-program-runs', err)
    finally:
        import shutil
        shutil.rmtree(tmp, ignore_errors=True)

    print('\n%d checks, %d failed' % (passes + len(failures), len(failures)))
    if failures:
        print('failed: ' + ', '.join(failures))
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
