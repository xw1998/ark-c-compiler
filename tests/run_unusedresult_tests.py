#!/usr/bin/env python
"""--warn-unused-result gates.

What this switch does, and what it does not:

  `--warn-unused-result` adds one check after semantics: if a function was
  declared with `__attribute__((warn_unused_result))` (GNU spelling
  `__warn_unused_result__`, kernel spelling `__must_check__`) and returns a
  value, then an expression statement whose entire expression is a call to it
  is reported. `(void)f();` is the documented way to discard a result on
  purpose and is silent; a call anywhere inside a larger expression is "used".

  It is deliberately local:
    * a call through a function pointer has no declaration to read the
      attribute from, so nothing is said;
    * a void function cannot lose a value, so the attribute is a no-op there;
    * the attribute sticks by name: a prototype in one place and the
      definition in another are the same function;
    * more than UR_MAX_FUNCS (256) annotated functions in one translation unit
      makes the pass report that it could not check completely instead of
      quietly checking only the first 256.

Source files here never `#include`: after preprocessing, arkc reports the line
inside the preprocessed buffer, so expectations are located by a stable ANCHOR
comment instead of hard-coded line numbers.

Anti-false-green checks (the gate must be able to fail):
  * the same defective source compiles silent without the switch   -> the pass,
    not something else, produced the warnings;
  * the legal twin of every reported shape is silent               -> the gate is
    not matching "there is a call at all";
  * --warn-unused-result / --no-warn-unused-result: last one wins  -> a run with
    the switch off must be silent;
  * a build with -DARKCC_FEATURE_UNUSEDRESULT=0 refuses the option -> the trim
    switch is real and says how to rebuild, instead of silently ignoring it.

Usage: run_unusedresult_tests.py [path-to-arkcc]
Exit 0 = every check behaved.
"""
import glob
import os
import re
import shutil
import subprocess
import sys
import tempfile

# ---------------------------------------------------------------- case sources

SRC_POS = r'''extern int __attribute__((warn_unused_result)) f(void);
extern int __attribute__((__must_check__)) g(int);

int __attribute__((warn_unused_result)) h(void);
int __attribute__((warn_unused_result)) h(void) { return 1; }

int use(void)
{
    f();                                    /* ANCHOR:call_f */
    g(3);                                   /* ANCHOR:call_g */
    h();                                    /* ANCHOR:call_h */
    {
        int i;
        for (i = 0; i < 2; i++)
            f();                            /* ANCHOR:call_in_loop */
    }
    switch (g(1)) {
    case 1:
        f();                                /* ANCHOR:call_in_switch */
        break;
    default:
        break;
    }
    return 0;
}
'''

SRC_FIXED = r'''extern int __attribute__((warn_unused_result)) f(void);

/* A void function cannot lose a value: the attribute says nothing there. */
extern void __attribute__((warn_unused_result)) v(void);

typedef int (*fp_t)(void);
extern fp_t getfp(void);
extern int plain(void);

int used_shapes(void)
{
    int (*p)(void) = getfp();
    int x;

    (void)f();              /* explicit discard: silent */
    x = f();                /* assigned: used */
    if (f()) x = 1;         /* condition: used */
    while (f()) break;      /* condition: used */
    x = plain() + f();      /* operand: used */
    p();                    /* no declaration to read: silent */
    v();                    /* void return: silent */
    plain();                /* not annotated: silent */
    return x;
}
'''

# Shapes the pass promises to leave alone entirely.
SRC_NEG = r'''typedef int (*fp_t)(void);
extern fp_t getfp(void);

int pointer_only(void)
{
    int (*p)(void) = getfp();
    p();
    return 0;
}
'''

POS_EXPECT = [
    ('call_f', "'f'"),
    ('call_g', "'g'"),
    ('call_h', "'h'"),
    ('call_in_loop', "'f'"),
    ('call_in_switch', "'f'"),
]

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

def line_of(src, anchor):
    """1-based line number of the unique line carrying `ANCHOR:<anchor>`."""
    hits = [i + 1 for i, ln in enumerate(src.splitlines()) if anchor in ln]
    if len(hits) != 1:
        raise AssertionError('anchor %r matched %d lines' % (anchor, len(hits)))
    return hits[0]

def warnings_in(log):
    m = re.findall(r':\s*(\d+)\s+warnings?,\s*(\d+)\s+errors?', log)
    return int(m[-1][0]) if m else 0

def errors_in(log):
    m = re.findall(r':\s*(\d+)\s+warnings?,\s*(\d+)\s+errors?', log)
    return int(m[-1][1]) if m else 0

def reported_lines(log):
    """Every `file`, line N: -- the coordinate the diagnostic carries."""
    return [int(n) for n in re.findall(r'",\s*line\s+(\d+):', log)]

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7', '-c']

def build_arkcc(where, define, name):
    """Rebuild arkcc from this tree with an extra -D; None if no compiler."""
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
           '-Wno-unused-function', '-Iinclude', define] + srcs + ['-o', out]
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if p.returncode != 0:
        return None, (p.stdout.decode('utf-8', 'replace').strip().splitlines()
                      or ['build failed'])[-1][:100]
    return out, ''

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_unusedresult_')
    try:
        for name, text in (('pos.c', SRC_POS), ('fixed.c', SRC_FIXED),
                           ('neg.c', SRC_NEG)):
            with open(os.path.join(work, name), 'w', newline='') as f:
                f.write(text)

        # --- 1. every claimed shape is reported, on the right line -----------
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos.o',
                                    '--warn-unused-result'], work)
        check(rc == 0, 'defect file still compiles (warnings are not errors)',
              'rc=%d' % rc)
        check(errors_in(log) == 0, 'defect file reports no errors',
              'errors=%d' % errors_in(log))
        got = warnings_in(log)
        check(got == len(POS_EXPECT), 'warning count matches the case list',
              '%d vs %d expected' % (got, len(POS_EXPECT)))
        hit = set(reported_lines(log))
        for anchor, frag in POS_EXPECT:
            want = line_of(SRC_POS, 'ANCHOR:' + anchor)
            ok = want in hit and frag in log
            check(ok, 'reports %s' % anchor,
                  'line %d%s' % (want, '' if frag in log else ', text missing'))

        # --- 2. every legal way to use or discard the value is silent -------
        rc, log = run(arkcc, ARM + ['fixed.c', '-o', 'fixed.o',
                                    '--warn-unused-result'], work)
        check(rc == 0, 'legal-twin file compiles', 'rc=%d' % rc)
        check(warnings_in(log) == 0, 'legal-twin file is silent',
              '%d warning(s)' % warnings_in(log))

        # --- 3. the neighbouring shapes it promises to ignore ---------------
        rc, log = run(arkcc, ARM + ['neg.c', '-o', 'neg.o',
                                    '--warn-unused-result'], work)
        check(rc == 0, 'negative file compiles', 'rc=%d' % rc)
        check(warnings_in(log) == 0, 'negative file is silent',
              (log.strip().splitlines() or [''])[0][:90])

        # --- 4. anti-false-green: the switch is what produces them ----------
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos_off.o'], work)
        check(rc == 0 and warnings_in(log) == 0,
              'same defect file is silent without --warn-unused-result',
              '%d warning(s)' % warnings_in(log))
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos_off2.o',
                                    '--warn-unused-result',
                                    '--no-warn-unused-result'], work)
        check(rc == 0 and warnings_in(log) == 0,
              '--no-warn-unused-result after the positive form turns it off',
              '%d warning(s)' % warnings_in(log))
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos_on.o',
                                    '--no-warn-unused-result',
                                    '--warn-unused-result'], work)
        check(warnings_in(log) == len(POS_EXPECT),
              '--warn-unused-result after the negative form turns it on again',
              '%d warning(s)' % warnings_in(log))

        # --- 5. anti-false-green: the trim switch is real -------------------
        trimmed, why = build_arkcc(work, '-DARKCC_FEATURE_UNUSEDRESULT=0',
                                   'arkcc_nounusedresult')
        if trimmed is None:
            skip('trimmed build refuses --warn-unused-result', why)
        else:
            rc, log = run(trimmed, ARM + ['pos.c', '-o', 'tm.o',
                                          '--warn-unused-result'], work)
            check(rc != 0 and 'C3900U' in log and
                  'ARKCC_FEATURE_UNUSEDRESULT' in log,
                  'trimmed build refuses the option and says how to enable it',
                  'rc=%d' % rc)
            rc2, log2 = run(trimmed, ARM + ['pos.c', '-o', 'tm2.o'], work)
            check(rc2 == 0 and warnings_in(log2) == 0,
                  'trimmed build compiles the same file normally',
                  'rc=%d' % rc2)

        # --- 6. the same switch through arkcc.cfg ---------------------------
        with open(os.path.join(work, 'warn.cfg'), 'w', newline='') as f:
            f.write('[features]\nwarn_unused_result=1\n')
        rc, log = run(arkcc, ['-config', 'warn.cfg'] + ARM +
                      ['pos.c', '-o', 'cfg.o'], work)
        check(warnings_in(log) == len(POS_EXPECT),
              'warn_unused_result=1 in a config file switches the pass on',
              '%d warning(s)' % warnings_in(log))
        if trimmed is None:
            skip('trimmed build refuses the ini key', why)
        else:
            rc, log = run(trimmed, ['-config', 'warn.cfg'] + ARM +
                          ['pos.c', '-o', 'cfg2.o'], work)
            check(rc != 0 and 'C3900U' in log,
                  'trimmed build refuses warn_unused_result=1 from a config file',
                  'rc=%d' % rc)
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        return 1
    print('\nall --warn-unused-result checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())
