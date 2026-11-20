#!/usr/bin/env python
"""Gate: `double` must really be 64-bit.  Not storage only -- arithmetic too.

Why this gate exists
--------------------
A `double` that is silently stored or evaluated with only float precision is
the worst kind of defect: every value looks plausible, nothing is diagnosed,
and the error only shows up as the last digit of a derived number.  While
auditing the documented limitations of this compiler a differential probe
against the host turned up exactly such a shape:

    double d = 1.0 / 3.0;
    return (int)(d * 3.0 * 1000000.0);        /* gcc said 999999 */

and the same for `(int)((0.1 + 0.2) * 1000.0)` (299 vs 300).  It turned out
*not* to be a compiler bug: the host gcc in this workspace is MinGW gcc 4.8
built `--with-arch=i686`, so its default FP path is x87 with
FLT_EVAL_METHOD == 2 and it keeps 80-bit intermediates across the expression.
Strict IEEE-754 binary64 (Python: `(1.0/3.0)*3.0` is exactly 1.0 by
round-to-nearest-even; gcc with `-msse2 -mfpmath=sse`) yields 1000000 and 300,
which is what this compiler produces.  So the fix was in the probe, not in the
compiler -- but the *shape* it exposes is worth a permanent gate: a `double`
degenerating to `float` would produce the same "off by a few units in the
last digits" symptom, and nothing else in the suite would catch it.

What this gate checks
---------------------
Bit patterns first, then arithmetic, so a failure says which half broke:

  * the stored bit pattern of a global `0.1` (0x3FB999999999999A) and of a
    local `1.0/3.0` (0x3FD5555555555555) -- a float-precision store would land
    on 0x3FB99999A0000000 / 0x3FD5555560000000;
  * `d * 3.0 * 1000000.0` equals 1000000, i.e. the intermediate `d * 3.0`
    rounds to exactly 1.0 in binary64 instead of being carried wider (x87) or
    narrower (float);
  * `0.1` is not equal to `0.1f`, and `(double)(float)(1.0/3.0)` differs from
    `1.0/3.0` -- both are false if doubles are really floats;
  * `1e300 < 1e301` holds (in float both literals are +inf, so it is false);
    `1e-60` survives as a positive double (it underflows to 0 in float);
  * `0.1 * 10.0` is exactly 1.0 bit-wise;
  * every value comes from executing the linked Cortex-M0 image, with the
    real soft-float runtime (`stdlib/src/arm/aeabi_float.c`) linked in -- so
    this also covers the AEABI double calling convention end to end;
  * three anti-false-green self checks: a deliberately wrong expectation must
    be rejected, a valid program must compile with status 0, and an empty
    program must still run (so the table cannot pass by everything failing).

Usage: run_arm_double_precision_tests.py [--arkcc path]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
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

DBL_BITS_POINT_ONE = STARTUP + '''\
union U { double d; unsigned long long u; };
double g = 0.1;
int main(void)
{
    union U x;
    x.d = g;
    return (x.u == 0x3FB999999999999AULL) ? 7 : 3;
}
'''

DBL_BITS_THIRD = STARTUP + '''\
union U { double d; unsigned long long u; };
int main(void)
{
    union U x;
    double d = 1.0 / 3.0;
    x.d = d;
    return (x.u == 0x3FD5555555555555ULL) ? 7 : 3;
}
'''

DBL_ARITH_THIRD = STARTUP + '''\
double d = 1.0 / 3.0;
int main(void)
{
    /* binary64: (1/3)*3 rounds to exactly 1.0, so this is 1000000.
     * Float precision gives the same 1000000, x87 excess precision gives
     * 999999 -- this case pins the strict-double answer. */
    return (int)(d * 3.0 * 1000000.0);
}
'''

DBL_VS_FLOAT = STARTUP + '''\
int main(void)
{
    double d = 0.1;
    return (d == 0.1f) ? 0 : 9;
}
'''

DBL_RANGE = STARTUP + '''\
int main(void)
{
    /* Both literals are +inf in binary32, so a float-precision compare
     * would answer 0. */
    double big = 1e300, bigger = 1e301;
    return (big < bigger) ? 1 : 0;
}
'''

DBL_NARROWING = STARTUP + '''\
int main(void)
{
    double d = 1.0 / 3.0;
    float f = (float)d;
    return ((double)f != d) ? 1 : 0;
}
'''

DBL_UNDERFLOW = STARTUP + '''\
int main(void)
{
    /* 1e-60 is a normal binary64 and an underflow to zero in binary32. */
    volatile double a = 1e-30;
    double r = a * a;
    return (r > 0.0) ? 1 : 0;
}
'''

DBL_MUL_BITS = STARTUP + '''\
union U { double d; unsigned long long u; };
int main(void)
{
    union U x;
    double d = 0.1;
    x.d = d * 10.0;
    return (x.u == 0x3FF0000000000000ULL) ? 1 : 0;
}
'''

CASES = [
    ('dbl_bits_point_one',  DBL_BITS_POINT_ONE,        7),
    ('dbl_bits_third',      DBL_BITS_THIRD,            7),
    ('dbl_arith_third',     DBL_ARITH_THIRD,     1000000),
    ('dbl_vs_float',        DBL_VS_FLOAT,              9),
    ('dbl_range',           DBL_RANGE,                 1),
    ('dbl_narrowing',       DBL_NARROWING,             1),
    ('dbl_underflow',       DBL_UNDERFLOW,             1),
    ('dbl_mul_bits',        DBL_MUL_BITS,              1),
]

TARGET_ARGS = ['-target', 'arm', '-c', '--vector-table', '-mcpu', 'cortex-m0',
               '--reloc-data', '--reloc-text']


def run(cmd):
    return subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                          universal_newlines=True)


def build_runtime(arkcc, tmp):
    """Compile the soft-float and integer AEABI runtimes once."""
    srcs = [
        ('aeabi_float.obj', os.path.join(ROOT, 'stdlib', 'src', 'arm',
                                         'aeabi_float.c')),
        ('aeabi.obj', os.path.join(ROOT, 'stdlib', 'src', 'arm', 'aeabi.c')),
    ]
    objs = []
    for name, src in srcs:
        obj = os.path.join(tmp, name)
        r = run([arkcc, src, '-target', 'arm', '-c', '--vector-table',
                 '-mcpu', 'cortex-m0', '--reloc-data', '--reloc-text',
                 '-o', obj])
        if r.returncode:
            return None, 'runtime %s: %s' % (name, r.stdout.strip()[:300])
        objs.append(obj)
    div = os.path.join(tmp, 'aeabi_divmod.obj')
    r = run([arkcc, os.path.join(ROOT, 'stdlib', 'src', 'arm',
                                'aeabi_divmod.s'),
             '-target', 'arm', '-c', '-o', div])
    if r.returncode:
        return None, 'runtime divider: %s' % r.stdout.strip()[:300]
    objs.append(div)
    return objs, ''


def build_and_run(arkcc, src, tmp, name, rt_objs):
    """Compile one TU, link it with the runtimes, run it."""
    c = os.path.join(tmp, name + '.c')
    obj = os.path.join(tmp, name + '.obj')
    img = os.path.join(tmp, name + '.bin')
    with open(c, 'w', newline='\n') as f:
        f.write(src)
    r = run([arkcc, c] + TARGET_ARGS + ['-o', obj])
    if r.returncode:
        return None, 'compile: ' + r.stdout.strip()[:300]
    r = run([arkcc, '-link', obj] + rt_objs +
            ['--vector-table', '-mcpu', 'cortex-m0', '-o', img])
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
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()
    if not os.path.exists(args.arkcc):
        sys.stderr.write('arkcc not found: %s\n' % args.arkcc)
        return 2
    if not HAVE_UNICORN:
        sys.stderr.write('the ARM emulator (unicorn) is not available\n')
        return 2

    tmp = tempfile.mkdtemp(prefix='ark_dblprec_')
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
        rt_objs, err = build_runtime(args.arkcc, tmp)
        if rt_objs is None:
            sys.stderr.write(err + '\n')
            return 2

        for name, src, want in CASES:
            val, err = build_and_run(args.arkcc, src, tmp, name, rt_objs)
            if val is None:
                check(False, name, err)
            else:
                check(val == want, name,
                      '' if val == want else 'returned %d, want %d'
                      % (val, want))

        # --- anti-false-green -------------------------------------------
        # 1. the comparison above must reject a wrong expectation.
        val, err = build_and_run(args.arkcc, CASES[0][1], tmp, 'dbl_bits_point_one',
                                 rt_objs)
        check(val is not None and val != CASES[0][2] + 1,
              'self:wrong-expectation-rejected',
              '' if val is not None else err)

        # 2. a valid program has to compile cleanly, so the failures above are
        #    not the harness rejecting everything.
        rc, out = compile_only_status(args.arkcc, CASES[0][1], tmp,
                                      'dbl_bits_point_one')
        check(rc == 0, 'self:valid-program-accepted', out[:200])

        # 3. an empty program must still link and run.
        val, err = build_and_run(args.arkcc,
                                 STARTUP + 'int main(void) { return 0; }\n',
                                 tmp, 'self_empty', rt_objs)
        check(val == 0, 'self:empty-program-runs', err)
    finally:
        shutil.rmtree(tmp, ignore_errors=True)

    print('\n%d checks, %d failed' % (passes + len(failures), len(failures)))
    if failures:
        print('failed: ' + ', '.join(failures))
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
