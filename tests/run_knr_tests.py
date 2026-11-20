#!/usr/bin/env python
"""Gate for K&R (C89 6.5.1) style function definitions.

What the bug was
----------------
    int add(a, b) int a; int b; { return a + b; }

was rejected outright: `expected param type` / `#18: expected a ")"`.  That is
a legal C89 definition and still legal in C99 (obsolescent, removed only in
C23), so a compiler that claims to take C99 has to read it.  The hard part is
that the parameter *types* are not in the declarator at all -- they follow the
')' as an ordinary declaration list, and a parameter that is never declared
there is `int`.  So the parameter list can only record the *names* while the
declarator is being read, and the definition parser has to finish the job once
it sees the declarations.

What this gate checks
---------------------
  * declared types, undeclared parameters defaulting to int, a `char`
    parameter (the value must survive the narrow slot), a pointer parameter
    with a second integer parameter, several declarators in one declaration
    (`int a, b;`), and a `long` parameter;
  * every value is produced by running the linked image on the ARM emulator,
    so a wrong type shows up as a wrong number rather than as a printout;
  * the three forms that must be *rejected*: a prototype with an identifier
    list (`int f(a, b);`), a declaration for a name that is not in the list,
    and the same parameter declared twice;
  * two anti-false-green self checks: the harness must reject a deliberately
    wrong expectation, and a rejected program must actually come back with a
    non-zero compiler exit code (an "error" that still compiles would make
    every rejection case vacuous).

Usage: run_knr_tests.py [--arkcc path]
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

# The compiler emits __arkcc_init_globals; the startup calls it instead of
# defining an empty stub (a stub wins the duplicate-symbol merge and every
# global then reads back as 0 -- see the note in run_complit_tests.py).
STARTUP = '''\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void) { __arkcc_init_globals(); return main(); }
'''

# --- definitions that must compile and run -------------------------------

KNR_ADD = STARTUP + '''\
int add(a, b) int a; int b; { return a + b; }
int main(void) { return add(3, 4); }
'''

KNR_DEFAULT_INT = STARTUP + '''\
/* No declarations at all: every parameter is int (C89 6.5.1). */
int mul(a, b) { return a * b; }
int main(void) { return mul(6, 7); }
'''

KNR_CHAR = STARTUP + '''\
int first(c) char c; { return c; }
int main(void) { return first('A'); }        /* 65, not -191 or 0 */
'''

KNR_PTR = STARTUP + '''\
int tail(p, n) char *p; int n; { return p[n]; }
int diff(a, b) int a, b; { return a - b; }
int main(void)
{
    if (tail("hello", 4) != 'o') return 99;
    return diff(50, 8);
}
'''

KNR_LONG = STARTUP + '''\
long plus1(n) long n; { return n + 1; }
int main(void) { return (int)plus1(41); }
'''

# --- definitions that must be rejected -----------------------------------

ERR_PROTOTYPE = '''\
int f(a, b);
int main(void) { return 0; }
'''

ERR_UNKNOWN_NAME = '''\
int f(a) int x; { return x; }
int main(void) { return 0; }
'''

ERR_DOUBLE_DECL = '''\
int f(a) int a; long a; { return 0; }
int main(void) { return 0; }
'''

CASES = [
    ('knr_add',         KNR_ADD,         7),
    ('knr_default_int', KNR_DEFAULT_INT, 42),
    ('knr_char',        KNR_CHAR,        65),
    ('knr_ptr',         KNR_PTR,         42),
    ('knr_long',        KNR_LONG,        42),
]

REJECT_CASES = [
    ('reject_prototype_identifier_list', ERR_PROTOTYPE),
    ('reject_name_not_in_list',          ERR_UNKNOWN_NAME),
    ('reject_parameter_declared_twice',  ERR_DOUBLE_DECL),
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

    tmp = tempfile.mkdtemp(prefix='ark_knr_')
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

        for name, src in REJECT_CASES:
            rc, out = compile_only_status(args.arkcc, src, tmp, name)
            check(rc != 0, name, 'accepted the program (no diagnostic)')
            if rc != 0:
                check('Error' in out, name + '_has_diagnostic',
                      'exit status was non-zero but no "Error" line: %r' % out[:120])

        # --- anti-false-green -------------------------------------------
        # 1. the comparison above must reject a wrong expectation.
        val, err = build_and_run(args.arkcc, CASES[0][1], tmp, 'knr_add')
        check(val is not None and val != CASES[0][2] + 1,
              'self:wrong-expectation-rejected',
              '' if val is not None else err)

        # 2. an accepted-but-wrong program must not be mistaken for a rejected
        #    one: a valid case has to come back with exit status 0, so the
        #    rejection checks are not passing because *everything* fails.
        rc, out = compile_only_status(args.arkcc, CASES[0][1], tmp, 'knr_add')
        check(rc == 0, 'self:valid-program-accepted', out[:200])

        # 3. an empty program must still link; guards against a harness that
        #    reports "rejected" for every input because the setup is broken.
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
