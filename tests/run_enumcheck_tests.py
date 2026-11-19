#!/usr/bin/env python
"""--warn-enum (enum exhaustiveness) gates.

What this switch does, and what it does not:

  `--warn-enum` adds one check after semantics: a `switch` whose controlling
  expression has enum type, that has no `default:` label, and that does not
  carry a case for every enumerator of the definition. Nothing else.

  The check is a set comparison, not flow analysis:
    * coverage is decided by VALUE, not by spelling -- `case 0:` covers the
      enumerator whose value is 0, and two enumerators sharing a value are
      covered together;
    * a switch on a plain `int` is not checked even when its labels are enum
      constants: the type is what says "this value comes from that set";
    * an enum whose definition is not in this translation unit has no list to
      compare against, so nothing is said about it;
    * a set larger than EC_MAX_ENUM (or a switch with more labels than
      EC_MAX_CASES) is skipped entirely -- a truncated comparison could call a
      value missing when it is merely beyond the table.

Source files here never `#include`: after preprocessing, arkc reports the line
inside the preprocessed buffer, so expectations are located by a stable ANCHOR
comment instead of hard-coded line numbers.

Anti-false-green checks (the gate must be able to fail):
  * the same defective source compiles silent without --warn-enum  -> the pass,
    not something else, produced the warnings;
  * the complete spellings of the same switches are silent         -> the gate
    is not matching "there is a switch at all";
  * --warn-enum / --no-warn-enum are a switch, last one wins       -> a run with
    the switch off must be silent;
  * a build with -DARKCC_FEATURE_ENUMCHECK=0 refuses --warn-enum   -> the trim
    switch is real and says why, instead of silently ignoring the option.

Usage: run_enumcheck_tests.py [path-to-arkcc]
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

SRC_POS = r'''enum Color { RED, GREEN, BLUE };

int one_missing(enum Color c);
int one_missing(enum Color c)
{
    switch (c) {                    /* ANCHOR:one_missing */
    case RED: return 1;
    case BLUE: return 3;
    }
    return 0;
}

int two_missing(enum Color c);
int two_missing(enum Color c)
{
    switch (c) {                    /* ANCHOR:two_missing */
    case RED: return 1;
    }
    return 0;
}

typedef enum { STATE_IDLE, STATE_BUSY, STATE_FAULT } state_t;

int anon2(state_t s);
int anon2(state_t s)
{
    switch (s) {                    /* ANCHOR:anon2 */
    case STATE_IDLE: return 1;
    }
    return 0;
}

enum Mode { MODE_A, MODE_B };
enum Flag { FLAG_X, FLAG_Y };

int nested(enum Mode m, enum Flag f);
int nested(enum Mode m, enum Flag f)
{
    switch (m) {                    /* covers both: no warning here */
    case MODE_A:
        switch (f) {                /* ANCHOR:nested_inner */
        case FLAG_X: return 1;
        }
        return 2;
    case MODE_B:
        return 3;
    }
    return 0;
}

int in_loop(enum Color c);
int in_loop(enum Color c)
{
    int i;
    for (i = 0; i < 2; i++) {
        switch (c) {                /* ANCHOR:in_loop */
        case RED: break;
        }
    }
    return 0;
}
'''

SRC_FIXED = r'''enum Color { RED, GREEN, BLUE };
enum Dup { D0 = 0, D0B = 0, D1 = 1 };
enum Mode { MODE_A, MODE_B };

int complete(enum Color c);
int complete(enum Color c)
{
    switch (c) {
    case RED: return 1;
    case GREEN: return 2;
    case BLUE: return 3;
    }
    return 0;
}

int with_default(enum Color c);
int with_default(enum Color c)
{
    switch (c) {
    case RED: return 1;
    default: return 0;
    }
}

int switch_on_int(int i);
int switch_on_int(int i)
{
    switch (i) {                    /* int, not enum: not this pass's business */
    case RED: return 1;
    }
    return 0;
}

int shared_value(enum Dup d);
int shared_value(enum Dup d)
{
    switch (d) {                    /* D0 covers D0B (same value) */
    case D0: return 1;
    case D1: return 2;
    }
    return 0;
}

int numeric_labels(enum Color c);
int numeric_labels(enum Color c)
{
    switch (c) {                    /* coverage is by value, not by name */
    case 0: return 1;
    case 1: return 2;
    case 2: return 3;
    }
    return 0;
}

int no_switch(enum Color c);
int no_switch(enum Color c)
{
    if (c == GREEN) return 1;
    return 0;
}
'''

# Neighbouring shapes the pass promises to leave alone: an enum that is only
# declared (no definition in this TU) and a set too large to compare
# exhaustively. The big enum is generated so the count is not a magic number in
# the text.
BIG_ENUM_N = 70
_big_enum = ('enum Big {\n' +
             ',\n'.join('    BIG_%d' % i for i in range(BIG_ENUM_N)) +
             '\n};\n')

SRC_NEG = r'''enum Undefined x;                   /* tag never defined in this TU */

int undeclared_set(enum Undefined v);
int undeclared_set(enum Undefined v)
{
    switch (v) {                     /* nothing to compare against: silent */
    case 0: return 1;
    }
    return 0;
}

''' + _big_enum + r'''
int big_one_case(enum Big b);
int big_one_case(enum Big b)
{
    switch (b) {                     /* larger than the table: silent */
    case BIG_0: return 1;
    }
    return 0;
}
'''

POS_EXPECT = [
    ('one_missing', 'missing: GREEN'),
    ('two_missing', 'missing: GREEN, BLUE'),
    ('anon2', 'missing: STATE_BUSY, STATE_FAULT'),
    ('nested_inner', 'missing: FLAG_Y'),
    ('in_loop', 'missing: GREEN, BLUE'),
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

    work = tempfile.mkdtemp(prefix='arkcc_enumcheck_')
    try:
        for name, text in (('pos.c', SRC_POS), ('fixed.c', SRC_FIXED),
                           ('neg.c', SRC_NEG)):
            with open(os.path.join(work, name), 'w', newline='') as f:
                f.write(text)

        # --- 1. every claimed shape is reported, on the right line -----------
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos.o', '--warn-enum'],
                      work)
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

        # --- 2. the complete spellings of the same switches are silent ------
        rc, log = run(arkcc, ARM + ['fixed.c', '-o', 'fixed.o', '--warn-enum'],
                      work)
        check(rc == 0, 'fixed file compiles', 'rc=%d' % rc)
        check(warnings_in(log) == 0, 'fixed file is silent',
              '%d warning(s)' % warnings_in(log))

        # --- 3. the neighbouring shapes it promises to ignore ---------------
        rc, log = run(arkcc, ARM + ['neg.c', '-o', 'neg.o', '--warn-enum'],
                      work)
        check(rc == 0, 'negative file compiles', 'rc=%d' % rc)
        check(warnings_in(log) == 0, 'negative file is silent',
              (log.strip().splitlines() or [''])[0][:90])

        # --- 4. anti-false-green: the switch is what produces them ----------
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos_off.o'], work)
        check(rc == 0 and warnings_in(log) == 0,
              'same defect file is silent without --warn-enum',
              '%d warning(s)' % warnings_in(log))
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos_off2.o', '--warn-enum',
                                    '--no-warn-enum'], work)
        check(rc == 0 and warnings_in(log) == 0,
              '--no-warn-enum after --warn-enum turns it back off',
              '%d warning(s)' % warnings_in(log))
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos_on.o', '--no-warn-enum',
                                    '--warn-enum'], work)
        check(warnings_in(log) == len(POS_EXPECT),
              '--warn-enum after --no-warn-enum turns it on again',
              '%d warning(s)' % warnings_in(log))

        # --- 5. anti-false-green: the trim switch is real -------------------
        trimmed, why = build_arkcc(work, '-DARKCC_FEATURE_ENUMCHECK=0',
                                   'arkcc_noenumcheck')
        if trimmed is None:
            skip('trimmed build refuses --warn-enum', why)
        else:
            rc, log = run(trimmed, ARM + ['pos.c', '-o', 'tm.o', '--warn-enum'],
                          work)
            check(rc != 0 and 'C3900U' in log and
                  'ARKCC_FEATURE_ENUMCHECK' in log,
                  'trimmed build refuses --warn-enum and says how to enable it',
                  'rc=%d' % rc)
            rc2, log2 = run(trimmed, ARM + ['pos.c', '-o', 'tm2.o'], work)
            check(rc2 == 0 and warnings_in(log2) == 0,
                  'trimmed build compiles the same file normally',
                  'rc=%d' % rc2)

        # --- 6. the same switch through arkcc.cfg ---------------------------
        with open(os.path.join(work, 'warn.cfg'), 'w', newline='') as f:
            f.write('[features]\nwarn_enum=1\n')
        rc, log = run(arkcc, ['-config', 'warn.cfg'] + ARM +
                      ['pos.c', '-o', 'cfg.o'], work)
        check(warnings_in(log) == len(POS_EXPECT),
              'warn_enum=1 in a config file switches the pass on',
              '%d warning(s)' % warnings_in(log))
        if trimmed is None:
            skip('trimmed build refuses warn_enum=1 from a config file', why)
        else:
            rc, log = run(trimmed, ['-config', 'warn.cfg'] + ARM +
                          ['pos.c', '-o', 'cfg2.o'], work)
            check(rc != 0 and 'C3900U' in log,
                  'trimmed build refuses warn_enum=1 from a config file',
                  'rc=%d' % rc)
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        return 1
    print('\nall --warn-enum checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0


if __name__ == '__main__':
    sys.exit(main())
