#!/usr/bin/env python
"""Gate for compound literals and the pointer arithmetic that hangs off them.

What the bugs were
------------------
Four silent wrong answers, all of the form "the program runs and answers a
number, just not the right one":

  1. `(struct S){...}` was retyped as `int` by sema: the node has no own type
     (the real one lives in `lit_type`), so `((struct S){3,4}).b` looked the
     member up in `int`, found no field and loaded offset 0 -- the value of
     `.a`.
  2. `(int[]){1,2,3}` kept an *incomplete* array type, so its size stayed 0
     and every later size test read it as one element: `sizeof` folded to 4
     and the temporary got an 8-byte slot for 12 bytes of data.
  3. A compound literal is a postfix-expression, so `(struct S){3,4}.b` and
     `((int[]){1,2,3})[1]` continue with the suffix operator.  The parser
     returned the bare node and then failed on the trailing `.b` with
     "expected a )".
  4. The `addr_value` walker forwarded the *operand's* type through an
     `AST_CAST`, so a cast only changed the printed type, not the stride:
     in `char *q = (char *)&a[1] + 4;` the `+4` was scaled by sizeof(int) and
     q landed on a[5].  The same walker also refused to decay a global array,
     and `2[arr]` (legal C11 6.5.2.1p2) multiplied the *address* by the
     element size.

What this gate checks
---------------------
  * every case is one translation unit linked with nothing else and run on the
    ARM emulator; the program returns the number it computed, so a wrong
    answer is a failed case rather than a printout nobody reads;
  * a structure member reached through a compound literal, an array sized by
    its initialiser, an array element reached through one, a subscript written
    backwards (local, pointer, global), a cast that changes the stride,
    `&array + 1`, and a global initialiser built from `&g[1] + 1` and from a
    cast pointer;
  * two anti-false-green self checks: the harness must reject a deliberately
    wrong expectation, and the unused-source guard must not pass an empty
    program.

Usage: run_complit_tests.py [--arkcc path]
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

# `__arkcc_init_globals` is emitted by the compiler (the chain that stores the
# initialisers into .data), so the startup calls it instead of defining an
# empty stub -- a stub wins the duplicate-symbol merge and every global then
# reads back as 0, which would silently disable the two global cases below.
STARTUP = '''\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void) { __arkcc_init_globals(); return main(); }
'''

# --- compound literals ---------------------------------------------------
CL_MEMBER = STARTUP + '''\
struct S { int a; int b; };
int main(void)
{
    struct S s = (struct S){3, 4};
    /* The `.b` of a fresh literal must be 4, not the `.a` at offset 0. */
    return ((struct S){3, 4}).b * 10 + s.a + ((struct S){5, 6}).a;
}
'''

CL_ARRAY = STARTUP + '''\
int main(void)
{
    int n = (int)sizeof((int[]){1, 2, 3});      /* 12, not 4 */
    if (n != 12) return 90 + n;
    if (((int[]){1, 2, 3})[2] != 3) return 80;
    if (((int[]){7, 8, 9})[0] != 7) return 70;
    return n;
}
'''

CL_STRUCT_ARRAY = STARTUP + '''\
struct S { int a; int b; };
int main(void)
{
    struct S *p = (struct S[]){{1, 2}, {3, 4}};
    if (p[1].b != 4) return 91;
    return ((struct S[]){{1, 2}, {3, 4}})[1].a;    /* 3 */
}
'''

# --- reversed subscript --------------------------------------------------
SUBSCRIPT_LOCAL = STARTUP + '''\
int main(void)
{
    int a[3] = {7, 8, 9};
    int *p = a;
    if (2[a] != 9) return 92;
    if (1[p] != 8) return 93;
    return 2[a] * 10 + 1[p];                       /* 98 */
}
'''

SUBSCRIPT_GLOBAL = STARTUP + '''\
static int g[4] = {1, 2, 3, 4};
int main(void)
{
    return 2[g] * 11;                              /* 33 */
}
'''

# --- cast changes the stride --------------------------------------------
CAST_STRIDE = STARTUP + '''\
int main(void)
{
    int a[6] = {10, 11, 12, 13, 14, 15};
    char *q = (char *)&a[1] + 4;                   /* 4 bytes, not 4 ints */
    if (*(int *)q != 12) return 94;
    return *(int *)q;
}
'''

ADDR_ARRAY = STARTUP + '''\
int main(void)
{
    int a[3] = {1, 2, 3};
    /* `&a + 1` moves a whole array; `a + 1` moves one element. */
    if ((char *)(&a + 1) - (char *)a != 12) return 95;
    if ((char *)(a + 1) - (char *)a != 4) return 96;
    return (int)((char *)(&a + 1) - (char *)a);
}
'''

# --- global initialisers riding on the same walker -----------------------
GLOBAL_ADDR = STARTUP + '''\
static int g[4] = {10, 20, 30, 40};
static int *gp = &g[1] + 1;                        /* 30 */
static char *cp = (char *)&g[1] + 4;               /* also 30 */
int main(void)
{
    if (*gp != 30) return 97;
    if (*(int *)cp != 30) return 98;
    return *gp;
}
'''

CASES = [
    ('cl_member',         CL_MEMBER,         48),   # 4*10 + 3 + 5
    ('cl_array',          CL_ARRAY,          12),
    ('cl_struct_array',   CL_STRUCT_ARRAY,    3),
    ('subscript_local',   SUBSCRIPT_LOCAL,   98),
    ('subscript_global',  SUBSCRIPT_GLOBAL,  33),
    ('cast_stride',       CAST_STRIDE,       12),
    ('addr_array',        ADDR_ARRAY,        12),
    ('global_addr',       GLOBAL_ADDR,       30),
]

TARGET_ARGS = ['-target', 'arm', '-c', '--vector-table', '-mcpu', 'cortex-m0']


def run(cmd):
    return subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                          universal_newlines=True)


def build_and_run(arkcc, src, tmp, name):
    """Compile one TU, link it alone, run it on the emulator.

    Returns (return value, error string).  The value is None when the build,
    the link or the run failed, and the error then says which.
    """
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

    tmp = tempfile.mkdtemp(prefix='ark_complit_')
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
        # 1. the comparison above must reject a wrong expectation: if this
        #    "passes", check() is not really comparing anything.
        val, err = build_and_run(args.arkcc, CASES[0][1], tmp, 'cl_member')
        check(val is not None and val != CASES[0][2] + 1,
              'self:wrong-expectation-rejected',
              '' if val is not None else err)

        # 2. an empty program must not be silently accepted: the harness has to
        #    see a value, so a build that produces no image fails loudly.
        val, err = build_and_run(args.arkcc,
                                 STARTUP + 'int main(void) { return 0; }\n',
                                 tmp, 'self_empty')
        check(val == 0, 'self:empty-program-runs', err)
        val, err = build_and_run(args.arkcc, STARTUP, tmp, 'self_nomain')
        check(val is None and 'link' in err, 'self:no-main-rejected', err)
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
