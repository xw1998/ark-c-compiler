#!/usr/bin/env python3
"""Gate for how the driver treats an -fopt-* name (0.9.1-wip).

The compiler ships a family of its own switches spelled -fopt-<pass>.  gcc has
no such spelling, so a name inside that family which matches no pass is a
misspelling, not a foreign flag.  Until this change the driver accepted
`-fopt-bogus` and compiled with the flag silently dropped -- exactly the one
answer this compiler refuses to give ("an error, never a wrong answer").

What is checked:

  1. REFUSED BY NAME.  `-fopt-bogus`, `-fno-opt-bogus` and the bare `-fopt-`
     exit non-zero, quote C3900U, echo the spelling the user typed, and write
     no output file.
  2. THE RIGHT ONE IS NAMED.  `-fopt-vreg -fopt-bogus` names `-fopt-bogus` in
     the diagnostic and not the valid flag sitting next to it.
  3. POSITION DOES NOT MATTER.  A bad name in front of `-o` is refused the same
     way as one at the end.
  4. GCC-STYLE NAMES STILL PASS.  `-fbogus`, `-fvreg` and `-fno-strict-aliasing`
     exit 0 and produce byte-identical assembly and image to a build with no
     -f flag at all.  That is the property that made the old tolerance worth
     keeping: an unknown bare -fxxx has always been a no-op, not a refusal.
  5. EVERY REAL PASS STILL PARSES (anti-false-positive).  Each of the 26 names
     in the shipped flag set is accepted on its own; a typo in the table would
     otherwise turn a working build into C3900U.
  6. THE DOC SPELLING IS THE REAL ONE.  `-fopt-divconst` is refused while
     `--divconst` is not reported as unrecognized: the pass that exists is
     spelled `--divconst` (main.c), and docs used to call it `-fopt-divconst`.

Usage: run_option_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# The shipped 26 names (the list docs/BUILD.md section 5.2 freezes for the crop table).  Listed here rather than imported so the gate does not
# depend on a scratch script staying around.
PASSES = ['-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
          '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
          '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop',
          '-fopt-slotreg', '-fopt-strength', '-fopt-vstack', '-fopt-vreg',
          '-fopt-cmat', '-fopt-pair', '-fopt-litpool', '-fopt-frame',
          '-fopt-voldmb', '-fopt-volbar', '-fopt-constcond', '-fopt-boolmat',
          '-fopt-exit', '-fopt-bitmask']

BAD = ['-fopt-bogus', '-fno-opt-bogus', '-fopt-']

# Ordinary -f names gcc command lines carry.  They are not this compiler's
# family, so they stay silently tolerated (check 4 measures that on output).
FOREIGN = ['-fbogus', '-fvreg', '-fno-strict-aliasing']

FIXTURE = """\
volatile int opt_sink;
static int opt_scale(int a, int b)
{
    int x = a * 3 + b;
    int y = x - (a >> 1);
    opt_sink = y;
    return x + y;
}
int main(void)
{
    return opt_scale(7, 5) & 0xFF;
}
"""

failures, skips = [], []


def check(cond, what, detail=''):
    if cond:
        print('[ok  ] %s%s' % (what, ('  (%s)' % detail) if detail else ''))
    else:
        print('[FAIL] %s%s' % (what, ('  (%s)' % detail) if detail else ''))
        failures.append(what)
    return bool(cond)


def skip(what, why=''):
    print('[skip] %s%s' % (what, ('  (%s)' % why) if why else ''))
    skips.append(what)


def run(argv, cwd):
    p = subprocess.run(argv, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


def emit(arkcc, work, name, flags, tag):
    """Assembly + image bytes for one arm; (text, blob, rc, log)."""
    src = os.path.join(work, 'fixture.c')
    asm = os.path.join(work, '%s.s' % tag)
    rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src, '-o', asm]
                  + list(flags), work)
    if rc != 0:
        return None, None, rc, log
    img = os.path.join(work, '%s.bin' % tag)
    rc, log = run([arkcc] + IMG_ARM + ['-O2', '-I', INC, src, '-o', img]
                  + list(flags), work)
    if rc != 0:
        return None, None, rc, log
    with open(asm, encoding='utf-8') as fh:
        text = fh.read()
    with open(img, 'rb') as fh:
        blob = fh.read()
    return text, blob, 0, ''


def main():
    arkcc = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else './arkcc.exe')
    if not os.path.exists(arkcc):
        print('setup: no compiler at %s' % arkcc)
        return 2
    if not os.path.isdir(os.path.join(ROOT, 'src')):
        print('setup: run me from the repository root')
        return 2
    work = tempfile.mkdtemp(prefix='arkopt_')
    try:
        with open(os.path.join(work, 'fixture.c'), 'w',
                  newline='\n', encoding='utf-8') as fh:
            fh.write(FIXTURE)

        # --- 1. a bad -fopt-* name is refused, echoed, and writes nothing ---
        for bad in BAD:
            out = os.path.join(work, 'refused.s')
            rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'fixture.c'), '-o', out, bad], work)
            check(rc != 0 and 'C3900U' in log and bad in log,
                  '%s is refused by name' % bad, 'rc=%d' % rc)
            check(not os.path.exists(out),
                  '%s writes no output file' % bad)
            if os.path.exists(out):
                os.remove(out)

        # --- 2. the diagnostic names the bad spelling, not its neighbour ----
        out = os.path.join(work, 'named.s')
        rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC,
                      os.path.join(work, 'fixture.c'), '-o', out,
                      '-fopt-vreg', '-fopt-bogus'], work)
        check(rc != 0 and '-fopt-bogus' in log and '-fopt-vreg' not in log,
              'the diagnostic names -fopt-bogus, not -fopt-vreg',
              'rc=%d' % rc)

        # --- 3. position in argv does not matter ----------------------------
        out = os.path.join(work, 'front.s')
        rc, log = run([arkcc, '-fopt-bogus'] + ASM_ARM + ['-O2', '-I', INC,
                      os.path.join(work, 'fixture.c'), '-o', out], work)
        check(rc != 0 and 'C3900U' in log,
              'a bad name in front of -o is refused too', 'rc=%d' % rc)

        # --- 4. gcc-style -f names stay no-ops ------------------------------
        base_t, base_b, rc, log = emit(arkcc, work, 'fixture', [], 'none')
        if rc != 0:
            check(False, 'the fixture builds with no -f flag at all', log[:120])
        else:
            for flag in FOREIGN:
                t, b, rc, log = emit(arkcc, work, 'fixture', [flag],
                                     'f_' + flag.strip('-').replace('-', '_'))
                check(rc == 0, '%s is accepted' % flag, 'rc=%d' % rc)
                if rc == 0:
                    check(t == base_t and b == base_b,
                          '%s leaves assembly and image byte-identical' % flag,
                          'asm=%d img=%d bytes' % (len(t), len(b)))

        # --- 5. every real pass still parses (anti-false-positive) ----------
        bad_real = []
        for flag in PASSES:
            rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'fixture.c'), '-o',
                          os.path.join(work, 'p.s'), flag], work)
            if rc != 0 or 'C3900U' in log:
                bad_real.append(flag)
        check(not bad_real,
              'all %d shipped -fopt-* names are accepted one by one' % len(PASSES),
              ' '.join(bad_real))

        # --- 6. the documented spelling of divconst is --divconst -----------
        rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC,
                      os.path.join(work, 'fixture.c'), '-o',
                      os.path.join(work, 'd.s'), '-fopt-divconst'], work)
        check(rc != 0 and 'C3900U' in log,
              '-fopt-divconst is refused (the pass is spelled --divconst)',
              'rc=%d' % rc)
        rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC,
                      os.path.join(work, 'fixture.c'), '-o',
                      os.path.join(work, 'd2.s'), '--divconst'], work)
        check('Unrecognized option' not in log,
              '--divconst is known to the driver (compiled in or refused as '
              'cropped, never as a misspelling)', 'rc=%d' % rc)

        if skips:
            print('\n%d check(s) skipped' % len(skips))
        if failures:
            print('\n%d check(s) FAILED' % len(failures))
            return 1
        print('option: all checks passed%s'
              % (' (%d skipped)' % len(skips) if skips else ''))
        return 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    sys.exit(main())
