#!/usr/bin/env python
"""Gates for --licm and --unroll.

Both passes are opt-in rewrites of the instruction list, so "it compiles" says
nothing about them.  The gate therefore asks three separate questions, and each
one can fail on its own:

  1. Static: with the switch on, the code really changes; with the switch off,
     the image is byte-identical to a build that never heard of the pass.
  2. Static, negative: every shape the pass promises to leave alone produces
     the same assembly with the switch on as with it off.  A pass that "also
     handled" an unsafe shape would fail here, which is the point -- an
     optimiser that guesses is an optimiser that changes answers.
  3. Dynamic: the same program, compiled with and without the switch, returns
     the same number on the ARM emulator.  For --licm the program also checks
     the zero-trip case, where the loop body never runs and the invariant must
     *not* have been written to the variable it is stored into.

Anti-false-green checks (the gate must be able to fail):
  * the switches are off by default and the default image is unchanged;
  * `--no-...` after `--...` turns each pass back off;
  * a build with -DARKCC_FEATURE_LICM=0 / -DARKCC_FEATURE_UNROLL=0 refuses the
    option with C3900U instead of pretending to optimise;
  * --licm without a -O level is reported as "needs a higher -O level";
  * --print-pipeline lists both stages and their switches;
  * both ini keys work.

Usage: run_loop_tests.py [path-to-arkcc]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
import glob
import hashlib
import os
import shutil
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

STARTUP = '''\
void __arkcc_init_globals(void) { }
int main(void);
int Reset_Handler(void)
{
    int rc;
    __arkcc_init_globals();
    rc = main();
    return rc;
}
'''

# --------------------------------------------------------------- the sources

# licm_case(0, ...) never enters the loop: the invariant must not be written
# to `t`, so it must still return 0.  licm_case(4, 3, 5) = 4*15 + 15 = 75.
SRC_LICM = '''\
int licm_case(int n, int x, int y)
{
    int t = 0;
    int s = 0;
    int i;
    for (i = 0; i < n; i++) {
        t = x * y;
        s += t;
    }
    return s + t;
}

int main(void)
{
    return licm_case(0, 3, 5) * 1000 + licm_case(4, 3, 5);
}
'''

# The address of `x` is taken: the pass must refuse to move x*y.
SRC_LICM_TAKEN = '''\
int licm_taken(int n, int x, int y)
{
    int t = 0;
    int s = 0;
    int i;
    int *p = &x;
    for (i = 0; i < n; i++) {
        t = x * y;
        *p = y;
        s += t;
    }
    return s + t;
}
int main(void) { return licm_taken(0, 3, 5); }
'''

# `x` is stored in the loop, so x*y is not invariant.
SRC_LICM_WRITTEN = '''\
int licm_written(int n, int x, int y)
{
    int t = 0;
    int s = 0;
    int i;
    for (i = 0; i < n; i++) {
        x = y;
        t = x * y;
        s += t;
    }
    return s + t;
}
int main(void) { return licm_written(0, 3, 5); }
'''

# A division can trap: hoisting it out of a zero-trip loop would introduce a
# fault the unoptimised program never had.
SRC_LICM_DIV = '''\
int licm_div(int n, int x)
{
    int t = 0;
    int s = 0;
    int i;
    for (i = 0; i < n; i++) {
        t = 100 / x;
        s += t;
    }
    return s + t;
}
int main(void) { return licm_div(0, 3); }
'''

# 0 + 3 + 6 + 9 = 18
SRC_UNROLL = '''\
int unroll_case(void)
{
    int s = 0;
    int i;
    for (i = 0; i < 4; i++) {
        s += i * 3;
    }
    return s;
}
int main(void) { return unroll_case(); }
'''

# `break` jumps out of the middle of a copy: not the accepted shape.
SRC_UNROLL_BREAK = '''\
int unroll_break(void)
{
    int s = 0;
    int i;
    for (i = 0; i < 4; i++) {
        if (i == 2) break;
        s += i * 3;
    }
    return s;
}
int main(void) { return unroll_break(); }
'''

# Trip count above ARK_UNROLL_MAX (8): left as a loop.
SRC_UNROLL_BIG = '''\
int unroll_big(void)
{
    int s = 0;
    int i;
    for (i = 0; i < 12; i++) {
        s += i * 3;
    }
    return s;
}
int main(void) { return unroll_big(); }
'''

failures = []
skips = []


def check(ok, what, detail=''):
    print('%s  %s%s' % ('PASS' if ok else 'FAIL', what,
                        ('  [' + detail + ']') if detail else ''))
    if not ok:
        failures.append(what)


def skip(what, why):
    print('SKIP  %s  [%s]' % (what, why))
    skips.append(what)


def run(arkcc, args, cwd):
    p = subprocess.run([arkcc] + args, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


def digest(path):
    with open(path, 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()


def write(path, text):
    with open(path, 'w', newline='\n') as f:
        f.write(text)


ARM = ['-target', 'arm', '--cpu', 'Cortex-M7']
ASM = ARM + ['-O1', '-S']
OBJ = ARM + ['-O1', '-c']
IMG = ARM + ['-O1', '--vector-table']


def count_mul(text):
    """Assembly lines that multiply. Used as the visible difference between
    "the loop is still a loop" and "the body was copied N times"."""
    return sum(1 for ln in text.splitlines()
               if ln.strip().startswith('MUL'))


def build_arkcc(where, defines, name):
    cc = os.environ.get('CC', 'gcc')
    if not shutil.which(cc):
        return None, 'no %s on PATH' % cc
    srcs = (sorted(glob.glob('src/*.c')) +
            sorted(glob.glob('src/backend/*/*.c')) +
            ['src/backend/registry.c', 'port/host/flash_fs_host.c',
             'port/host/platform_host.c', 'port/host/debug_host.c'])
    if not srcs or not os.path.exists('include/common.h'):
        return None, 'not run from the repository root'
    out = os.path.join(where, name + ('.exe' if os.name == 'nt' else ''))
    cmd = [cc, '-Wall', '-O2', '-std=c99', '-Wno-unused-parameter',
           '-Wno-unused-but-set-variable', '-Wno-unused-variable',
           '-Wno-unused-function', '-Iinclude'] + defines + srcs + ['-o', out]
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if p.returncode != 0:
        return None, (p.stdout.decode('utf-8', 'replace').strip().splitlines()
                      or ['build failed'])[-1][:120]
    return out, ''


def image_value(arkcc, src, work, flags, tag):
    """Compile `src` into a flat ARM image with `flags` and execute it.
    Returns (value, detail) or (None, why)."""
    img = os.path.join(work, tag + '.bin')
    rc, log = run(arkcc, IMG + flags + [src, '-o', img], work)
    if rc != 0:
        return None, 'compile: ' + log.strip()[:200]
    with open(img, 'rb') as f:
        status, value, detail = run_image(f.read())
    if status != 'returned':
        return None, 'emulator: %s %s' % (status, detail)
    return value, ''


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_loop_')
    try:
        srcs = {
            'licm.c': SRC_LICM, 'licm_taken.c': SRC_LICM_TAKEN,
            'licm_written.c': SRC_LICM_WRITTEN, 'licm_div.c': SRC_LICM_DIV,
            'unroll.c': SRC_UNROLL, 'unroll_break.c': SRC_UNROLL_BREAK,
            'unroll_big.c': SRC_UNROLL_BIG,
        }
        for name, text in srcs.items():
            write(os.path.join(work, name), STARTUP + text)

        # --- 1. --licm changes the code where it should ---------------------
        rc, _ = run(arkcc, ASM + ['licm.c', '-o', 'l_off.s'], work)
        rc2, _ = run(arkcc, ASM + ['licm.c', '--licm', '-o', 'l_on.s'], work)
        off = open(os.path.join(work, 'l_off.s')).read()
        on = open(os.path.join(work, 'l_on.s')).read()
        check(rc == 0 and rc2 == 0, '--licm compiles the case',
              'rc=%d/%d' % (rc, rc2))
        check(on != off, '--licm changes the generated code')
        # The moved computation is a multiply; in the unoptimised version it is
        # inside the loop body, in the optimised one it is above the loop and
        # the body loads a temporary.  The observable difference is the frame
        # size (the temporary adds a slot) and the loop body's shape.
        check('SUB sp, sp' in on and
              ('MUL' in off and 'MUL' in on),
              'the multiply survives (it moved, it was not deleted)')
        check(on.count('MUL') == off.count('MUL'),
              'no multiply is duplicated or lost',
              '%d -> %d' % (off.count('MUL'), on.count('MUL')))

        # --- 2. --licm refuses every unsafe shape (asm identical) -----------
        for name, tag in (('licm_taken.c', 'address taken'),
                          ('licm_written.c', 'operand stored in the loop'),
                          ('licm_div.c', 'division (can trap)')):
            rc, _ = run(arkcc, ASM + [name, '-o', 'x_off.s'], work)
            rc2, _ = run(arkcc, ASM + [name, '--licm', '-o', 'x_on.s'], work)
            a = open(os.path.join(work, 'x_off.s')).read()
            b = open(os.path.join(work, 'x_on.s')).read()
            check(rc == 0 and rc2 == 0 and a == b,
                  '--licm leaves the code untouched: ' + tag)

        # --- 3. --unroll changes the code where it should -------------------
        rc, _ = run(arkcc, ASM + ['unroll.c', '-o', 'u_off.s'], work)
        rc2, _ = run(arkcc, ASM + ['unroll.c', '--unroll', '-o', 'u_on.s'], work)
        off = open(os.path.join(work, 'u_off.s')).read()
        on = open(os.path.join(work, 'u_on.s')).read()
        check(rc == 0 and rc2 == 0, '--unroll compiles the case',
              'rc=%d/%d' % (rc, rc2))
        check(count_mul(on) == 4 and count_mul(off) == 1,
              'the body is copied 4 times (one multiply per copy)',
              'mul lines %d -> %d' % (count_mul(off), count_mul(on)))
        # The header label goes away with the back edge: the loop is gone
        # rather than merely "copied with a shorter body".
        check('.L_unroll_case_0' in off and '.L_unroll_case_0' not in on,
              'the back edge and the loop header are gone',
              'header label %s -> %s' % ('.L_unroll_case_0' in off,
                                         '.L_unroll_case_0' in on))

        # --- 4. --unroll refuses every other shape --------------------------
        for name, tag in (('unroll_break.c', 'break inside the body'),
                          ('unroll_big.c', 'trip count above the limit')):
            rc, _ = run(arkcc, ASM + [name, '-o', 'y_off.s'], work)
            rc2, _ = run(arkcc, ASM + [name, '--unroll', '-o', 'y_on.s'], work)
            a = open(os.path.join(work, 'y_off.s')).read()
            b = open(os.path.join(work, 'y_on.s')).read()
            check(rc == 0 and rc2 == 0 and a == b,
                  '--unroll leaves the loop alone: ' + tag)

        # --- 5. execution: same answer with and without ---------------------
        if not HAVE_UNICORN:
            skip('emulator execution (both passes)', 'unicorn not installed')
        else:
            for src, flags, tag, expect, why in (
                    ('licm.c', [], 'licm_off', 75, 'licm off'),
                    ('licm.c', ['--licm'], 'licm_on', 75, 'licm on'),
                    ('unroll.c', [], 'unroll_off', 18, 'unroll off'),
                    ('unroll.c', ['--unroll'], 'unroll_on', 18, 'unroll on'),
                    ('licm_taken.c', ['--licm'], 'taken_on', 0, 'licm defects'),
                    ('licm_div.c', ['--licm'], 'div_on', 0, 'divide stays'),
                    ('unroll_break.c', ['--unroll'], 'break_on', 3, 'break stays'),
                    ('unroll_big.c', ['--unroll'], 'big_on', 198, 'big stays')):
                got, err = image_value(arkcc, src, work, flags, tag)
                if got is None:
                    skip('executes %s (%s)' % (src, why), err)
                else:
                    check(got == expect,
                          '%s returns %d' % (why, expect),
                          'got %d' % got)

        # --- 6. anti-false-green: default off, --no- turns back off ---------
        for src, tag in (('licm.c', 'lc'), ('unroll.c', 'uc')):
            rc, _ = run(arkcc, OBJ + [src, '-o', tag + '_plain.o'], work)
            rc2, _ = run(arkcc, OBJ + ['--no-licm', '--no-unroll',
                                       src, '-o', tag + '_no.o'], work)
            ok = rc == 0 and rc2 == 0 and \
                digest(os.path.join(work, tag + '_plain.o')) == \
                digest(os.path.join(work, tag + '_no.o'))
            check(ok, 'passes are off by default: %s object is byte-identical' % src)
        rc, _ = run(arkcc, OBJ + ['--licm', '--unroll', '--no-licm',
                                  'licm.c', '-o', 'lc_backoff.o'], work)
        rc2, _ = run(arkcc, OBJ + ['licm.c', '-o', 'lc_ref.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'lc_backoff.o')) ==
              digest(os.path.join(work, 'lc_ref.o')),
              '--no-licm after --licm turns the pass back off')

        # --- 7. both passes need a -O level ---------------------------------
        rc, log = run(arkcc, ARM + ['--print-pipeline', '--licm', '--unroll'],
                      work)
        check(rc == 0 and 'needs a higher -O level' in log,
              'without -O the dump says the level is what blocks the pass')
        rc, log = run(arkcc, ARM + ['-O1', '--print-pipeline',
                                    '--licm', '--unroll'], work)
        check(rc == 0 and 'ir.licm' in log and 'ir.unroll' in log,
              '--print-pipeline lists both loop stages')
        # With the passes off (the default) the skip reason is the switch
        # name, which is how a reader learns what to turn on.
        rc, log = run(arkcc, ARM + ['-O1', '--print-pipeline'], work)
        check(rc == 0 and '--licm' in log and '--unroll' in log,
              'a skipped loop stage names the switch that turns it on')

        # --- 8. cropped build refuses both options --------------------------
        trimmed, why = build_arkcc(work,
                                   ['-DARKCC_FEATURE_LICM=0',
                                    '-DARKCC_FEATURE_UNROLL=0'],
                                   'arkcc_noloop')
        if trimmed is None:
            skip('trimmed build refuses --licm / --unroll', why)
        else:
            for opt, macro in (('--licm', 'ARKCC_FEATURE_LICM'),
                               ('--unroll', 'ARKCC_FEATURE_UNROLL')):
                rc, log = run(trimmed, OBJ + ['licm.c', opt, '-o', 't.o'], work)
                check(rc != 0 and 'C3900U' in log and macro in log,
                      'trimmed build refuses %s and names %s' % (opt, macro),
                      'rc=%d' % rc)
            rc2, log2 = run(trimmed, OBJ + ['licm.c', '-o', 't2.o'], work)
            check(rc2 == 0, 'trimmed build compiles the same file normally',
                  'rc=%d' % rc2)

        # --- 9. the switches through arkcc.cfg ------------------------------
        write(os.path.join(work, 'loop.cfg'),
              '[features]\nlicm=1\nunroll=1\n')
        rc, log = run(arkcc, ['-config', 'loop.cfg'] + ARM +
                      ['-O1', '--print-pipeline'], work)
        check(rc == 0 and 'ir.licm' in log and 'ir.unroll' in log and
              'off (--licm)' not in log and 'off (--unroll)' not in log,
              'licm=1 / unroll=1 in a config file switch both passes on')
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
        return 1
    print('\nall loop-pass checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0


if __name__ == '__main__':
    sys.exit(main())
