#!/usr/bin/env python3
"""Build-time gate for ARKCC_FEATURE_COMPLEX (the `_Complex` feature gate).

Why this file exists
--------------------
`ARKCC_FEATURE_COMPLEX=0` is supposed to remove C99 `_Complex` from the
compiler and, with it, ~13 KB of machine-backend code on the STM32 profile.
The danger of a build-time gate is that it fails *silently in the easy
direction*: the macro is misspelled, one include is missing, the flag never
reaches the compile line, and the "trimmed" binary is byte-identical to the
full one while every test still passes.  So this gate does not only ask
"does the trimmed build reject `_Complex`?" -- it also pins the two
directions that a broken gate would leave untouched:

  1. FULL build accepts `_Complex`            (the feature still works)
  2. TRIMMED build rejects it, and says WHY   (not a parse error, not a crash)
  3. TRIMMED build accepts ordinary C         (nothing else was cut)
  4. Code that does not mention `_Complex` is byte-identical in both builds
     (zero change when the feature is unused -- the "default off = no change"
     rule, checked at the level of emitted assembly)
  5. The run-time switch `-fno-complex` reports an error instead of silently
     dropping the keyword (it used to compile `double _Complex z` as
     `double z`, which is a wrong answer, not a rejection)

Both binaries must be supplied explicitly; this script never builds anything
and never guesses which binary is which.  Print of the two paths is part of
the output so a log always says what was measured.

Usage (from the repository root):
    python tests/run_complex_gate.py \
        --arkcc ./arkcc.exe --arkcc-off ./arkcc_off.exe
    # add --arm-as <binutils dir> --arm-libgcc <libgcc.a> --rv-as <dir> to also
    # re-run the full _Complex semantic suite against the FULL build.
"""
import argparse
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)

# Text the trimmed build must contain.  Kept in sync with src/parser.c.
MSG_OFF = 'is not available in this build'
MSG_RUNTIME = 'switched off by the run-time configuration'

CPLX_SRC = """#include <complex.h>
int main(void) {
    double _Complex z = 1.0 + 2.0i;
    return (int)(creal(z) * 10.0 + cimag(z));
}
"""

# Same shape, but nothing complex: doubles, a struct, a pointer, varargs.
PLAIN_SRC = """#include <stdarg.h>
struct pt { int x, y; };
static double scale(double v) { return v * 2.0 + 0.5; }
static int sum(int n, ...) {
    va_list ap; int i, s = 0;
    va_start(ap, n);
    for (i = 0; i < n; i++) s += va_arg(ap, int);
    va_end(ap);
    return s;
}
struct pt mk(int x, int y) { struct pt p; p.x = x; p.y = y; return p; }
int main(void) {
    struct pt p = mk(3, 4);
    double d = scale((double)p.x);
    return (int)d + sum(3, 1, 2, 3) + p.y;
}
"""


class Gate:
    def __init__(self):
        self.checks = 0
        self.failures = []

    def check(self, name, ok, detail=''):
        self.checks += 1
        if ok:
            print('PASS %-42s %s' % (name, detail))
        else:
            print('FAIL %-42s %s' % (name, detail))
            self.failures.append(name)
        return ok


def run(exe, args, cwd=None):
    try:
        p = subprocess.run([exe] + args, cwd=cwd, stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT, timeout=300)
        return p.returncode, p.stdout.decode('utf-8', 'replace')
    except OSError as e:
        return 127, 'cannot execute %s: %s' % (exe, e)


def write(d, name, text):
    p = os.path.join(d, name)
    with open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(text)
    return p


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc', required=True,
                    help='compiler built with ARKCC_FEATURE_COMPLEX=1')
    ap.add_argument('--arkcc-off', required=True,
                    help='compiler built with ARKCC_FEATURE_COMPLEX=0')
    ap.add_argument('--arm-as', default=os.environ.get('ARKCC_ARM_AS', ''))
    ap.add_argument('--arm-libgcc', default=os.environ.get('ARKCC_ARM_LIBGCC', ''))
    ap.add_argument('--rv-as', default=os.environ.get('ARKCC_RV_AS', ''))
    args = ap.parse_args()

    on = os.path.abspath(args.arkcc)
    off = os.path.abspath(args.arkcc_off)
    print('FULL    : %s' % on)
    print('TRIMMED : %s' % off)
    for p in (on, off):
        if not os.path.isfile(p):
            print('FATAL: %s does not exist' % p)
            return 2

    g = Gate()
    tmp = tempfile.mkdtemp(prefix='arkc_cplxgate_')
    cx = write(tmp, 'cplx.c', CPLX_SRC)
    plain = write(tmp, 'plain.c', PLAIN_SRC)

    # ---- 1. full build accepts the feature (positive control) ----
    rc, out = run(on, ['-target', 'arm', '-S', cx, '-o', os.path.join(tmp, 'cplx_on.s')])
    g.check('full/accepts-complex', rc == 0 and os.path.getsize(
        os.path.join(tmp, 'cplx_on.s')) > 0, 'rc=%d' % rc)

    # ---- 2. trimmed build rejects it, with the configured-out reason ----
    rc, out = run(off, ['-target', 'arm', '-S', cx, '-o', os.path.join(tmp, 'cplx_off.s')])
    g.check('trimmed/rejects-complex', rc != 0, 'rc=%d' % rc)
    g.check('trimmed/reason-is-configured-out', MSG_OFF in out,
            'saw %d line(s) of output' % len(out.splitlines()))
    g.check('trimmed/not-a-crash', ('Segmentation' not in out) and
            ('signal' not in out.lower()), '')

    # ---- 3. trimmed build still accepts ordinary C ----
    rc, out = run(off, ['-target', 'arm', '-S', plain, '-o', os.path.join(tmp, 'plain_off.s')])
    g.check('trimmed/accepts-plain-C', rc == 0, 'rc=%d' % rc)

    # ---- 4. unused feature => byte-identical assembly ----
    rc_on, _ = run(on, ['-target', 'arm', '-S', plain, '-o', os.path.join(tmp, 'plain_on.s')])
    a = open(os.path.join(tmp, 'plain_on.s'), 'rb').read() if rc_on == 0 else b''
    b = open(os.path.join(tmp, 'plain_off.s'), 'rb').read() if rc == 0 else b''
    g.check('both/plain-asm-identical', a == b and len(a) > 0,
            '%d vs %d bytes' % (len(a), len(b)))

    # ---- 5. run-time switch -fno-complex must report, not ignore ----
    rc, out = run(on, ['-target', 'arm', '-S', '-fno-complex', cx,
                       '-o', os.path.join(tmp, 'cplx_fno.s')])
    g.check('full/-fno-complex-is-an-error', rc != 0 and MSG_RUNTIME in out,
            'rc=%d' % rc)

    # ---- 6. self-check of the self-check: the message test can fail ----
    rc, out = run(off, ['-target', 'arm', '-S', plain, '-o', os.path.join(tmp, 'pc.s')])
    g.check('selfcheck/plain-build-has-no-config-msg', MSG_OFF not in out,
            'stdout must not contain the trimmed-build message')

    # ---- 7. optional: full _Complex semantic suite on the FULL build ----
    if args.arm_as or args.rv_as:
        suite = os.path.join(HERE, 'run_complex_tests.py')
        cmd = [sys.executable, suite, '--arkcc', on]
        if args.arm_as:
            cmd += ['--arm-as', args.arm_as]
        if args.arm_libgcc:
            cmd += ['--arm-libgcc', args.arm_libgcc]
        if args.rv_as:
            cmd += ['--rv-as', args.rv_as]
        try:
            p = subprocess.run(cmd, cwd=ROOT, stdout=subprocess.PIPE,
                               stderr=subprocess.STDOUT, timeout=1800)
            txt = p.stdout.decode('utf-8', 'replace')
            tail = [l for l in txt.splitlines() if 'passed' in l or 'failed' in l]
            ok = (p.returncode == 0 and '0 failed' in txt)
            g.check('full/complex-semantic-suite', ok,
                    tail[-1] if tail else 'rc=%d' % p.returncode)
        except subprocess.TimeoutExpired:
            g.check('full/complex-semantic-suite', False, 'timeout')
    else:
        print('SKIP full/complex-semantic-suite  (no --arm-as/--rv-as given)')

    print()
    if g.failures:
        print('=== %d check(s), %d FAILED: %s ===' %
              (g.checks, len(g.failures), ', '.join(g.failures)))
        return 1
    print('=== %d checks, all green ===' % g.checks)
    return 0


if __name__ == '__main__':
    sys.exit(main())
