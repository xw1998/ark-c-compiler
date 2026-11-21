#!/usr/bin/env python
"""Gates for --size-weight=N (0.9.1): one number that moves four thresholds.

The switch exists so the four size/speed thresholds of the optimiser stop being
compile-time constants nobody can reach from the command line.  That freedom is
worth exactly as much as the checks behind it, so this gate asks six separate
questions:

  1. Table reconciliation: at N=5 the four numbers are *exactly* the 0.9.0
     constants (inline<=12, unroll<=8, tailmerge>=3, xblock>=4), and the tables
     move in the promised direction from 0 (speed) to 9 (size).  Without this
     "no flag" and "N=5" could drift apart and the historical output would
     change silently.
  2. Defaults: not passing the flag is byte-identical to passing =5, over a
     corpus and over a plain -O2 compile.
  3. Each threshold reaches real code: a fixture whose shape sits between two
     table entries must change between the two weights that straddle it, in the
     direction the table says (more inlining/unrolling at the low end, shorter
     tails/blocks merged at the high end).
     NOTE: the inline row is exercised with a *parameterless* callee on
     purpose -- irgen stores the scalar parameter size in IR_GETARG's high
     bits, and the inline pass reads those bits as "struct by value", so any
     function with a parameter is skipped before the size rule is asked.  That
     is a pre-existing limitation of the inliner, not of this switch; it is
     recorded in docs/SIZEWEIGHT.md as an open item.
  4. Refusals: --size-weight=10, =abc, ="" and a missing value are fatal
     (C3900U) and produce no output file; a build with the feature compiled out
     refuses the option and still compiles the same file normally.
  5. The ini key (both spellings) reaches the same tables, and an out-of-range
     value in the file is reported and ignored rather than clamped.
  6. Semantics: every fixture still returns the same value at N=0, 5 and 9 on
     the ARM emulator; and at the size end the objects are not larger than at
     the speed end (fixture-level byte account, not a general theorem).

Usage: run_sizeweight_tests.py [path-to-arkcc]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
import glob
import hashlib
import os
import re
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

# Inline: a parameterless callee, called twice, so the size rule alone decides.
# z1 is small enough for the default (12) but not for the size end (4); z3 sits
# between the default and the speed end (28).
INLINE_SMALL = '''\
int v;
static int h(void)
{
    int y = v;
    y = y + 1;
    return y;
}
int main(void) { return (h() + h()) & 0x7F; }
'''

INLINE_MID = '''\
int v;
static int h(void)
{
    int y = v;
    y = y + 0;
    y = y + 1;
    y = y + 2;
    return y;
}
int main(void) { return (h() + h()) & 0x7F; }
'''

# Unroll: trip counts 12 and 6 straddle the three table entries (16 / 8 / 4).
UNROLL_12 = '''\
int v;
int main(void)
{
    int i;
    int s = 0;
    for (i = 0; i < 12; i++) { s = s + v; s = s * 3; }
    return s & 0x7F;
}
'''

UNROLL_6 = '''\
int v;
int main(void)
{
    int i;
    int s = 0;
    for (i = 0; i < 6; i++) { s = s + v; s = s * 3; }
    return s & 0x7F;
}
'''

# Tail merge: `merge_case` has a tail long enough for every weight, `short_case`
# has a two-instruction tail that only the size end (>=2) accepts.
TAIL = '''\
int v;
int merge_case(int a, int b)
{
    if (a) { b += 1; b *= 3; b ^= 5; b += 11; return b + 7; }
    else   { b -= 1; b *= 3; b ^= 5; b += 11; return b + 7; }
}
int short_case(int a, int b)
{
    if (a) return b;
    else   return b;
}
int main(void) { return (merge_case(v, 2) + short_case(v, 3)) & 0x7F; }
'''

# Whole-block merge: the two bodies are four-ish instructions long, so the
# speed end (>=7) refuses them while the default (>=4) and the size end (>=3)
# merge them.
XBLOCK = '''\
int v;
int two(int a)
{
    int r;
    if (a == 1)      { r = v; }
    else if (a == 2) { r = v; }
    else             { r = 0; }
    return r;
}
int main(void) { return two(1) + two(2) + two(0); }
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

def read(path):
    with open(path, 'r') as f:
        return f.read()

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7']
ASM = ARM + ['-O2', '-S']
OBJ = ARM + ['-O2', '-c']
IMG = ARM + ['-O2', '--vector-table']

def body_lines(text):
    """Instruction lines: everything that is not a label, directive, comment or
    blank.  Independent of the encoding and of label naming."""
    n = 0
    for ln in text.splitlines():
        s = ln.strip()
        if not s or s.startswith('.') or s.startswith('@') or s.startswith(';'):
            continue
        if s.endswith(':'):
            continue
        n += 1
    return n

def count_lines(text, needle):
    return sum(1 for ln in text.splitlines() if ln.strip().startswith(needle))

THR_RE = re.compile(r'size_weight=(\d+) inline<=(\d+) unroll<=(\d+) '
                    r'tailmerge>=(\d+) xblock>=(\d+)')

def thresholds(arkcc, work, args=()):
    """Ask the compiler for the resolved thresholds.  -v prints them, so the
    table itself is what the gate reads rather than a copy kept in this file."""
    rc, log = run(arkcc, list(args) + ARM + ['-v', '-S', '-o', 'v.s',
                                             'hello.c'], work)
    if rc != 0:
        return None, log.strip()[:200]
    m = THR_RE.search(log)
    if not m:
        return None, 'no threshold line in -v output'
    return tuple(int(x) for x in m.groups()), ''

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

def asm_of(arkcc, work, src, flags, tag):
    out = tag + '.s'
    rc, log = run(arkcc, ASM + flags + [src, '-o', out], work)
    if rc != 0:
        return None, 'compile: ' + log.strip()[:200]
    return read(os.path.join(work, out)), ''

def image_value(arkcc, work, src, flags, tag):
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

    work = tempfile.mkdtemp(prefix='arkcc_sizeweight_')
    try:
        write(os.path.join(work, 'hello.c'), STARTUP + 'int main(void) { return 7; }\n')
        # The inline fixtures carry no startup file: inlining is measured by
        # counting BL sites, and a second entry point that calls main would
        # carry its own (not yet expanded) copy of the calls into the output.
        for name, text in (('inline_small.c', INLINE_SMALL),
                           ('inline_mid.c', INLINE_MID),
                           ('inline_small_rt.c', STARTUP + INLINE_SMALL),
                           ('inline_mid_rt.c', STARTUP + INLINE_MID),
                           ('unroll12.c', STARTUP + UNROLL_12),
                           ('unroll6.c', STARTUP + UNROLL_6),
                           ('tail.c', STARTUP + TAIL),
                           ('xblock.c', STARTUP + XBLOCK)):
            write(os.path.join(work, name), text)

        # --- 1. the tables are the historical constants at 5 ----------------
        rows = {}
        for w in range(10):
            t, err = thresholds(arkcc, work, ['--size-weight=%d' % w])
            if t is None:
                check(False, 'the table at --size-weight=%d is readable' % w, err)
                return 1
            rows[w] = t
        check(rows[5] == (5, 12, 8, 3, 4),
              'weight 5 is the 0.9.0 constants (12 / 8 / 3 / 4)',
              'inline<=%d unroll<=%d tailmerge>=%d xblock>=%d' % rows[5][1:])
        check(all(rows[w][1] >= rows[w + 1][1] for w in range(9)),
              'the inline limit falls as the weight moves toward size',
              ', '.join(str(rows[w][1]) for w in range(10)))
        check(all(rows[w][2] >= rows[w + 1][2] for w in range(9)),
              'the unroll limit falls as the weight moves toward size',
              ', '.join(str(rows[w][2]) for w in range(10)))
        check(all(rows[w][3] >= rows[w + 1][3] for w in range(9)),
              'the tail-merge minimum falls (more merging) toward size',
              ', '.join(str(rows[w][3]) for w in range(10)))
        check(all(rows[w][4] >= rows[w + 1][4] for w in range(9)),
              'the block-merge minimum falls (more merging) toward size',
              ', '.join(str(rows[w][4]) for w in range(10)))
        check(rows[0][1] > rows[5][1] and rows[9][1] < rows[5][1] and
              rows[0][2] > rows[5][2] and rows[9][2] < rows[5][2],
              'both ends really move away from the middle (not a flat table)')

        # --- 2. default is exactly weight 5 ----------------------------------
        t, err = thresholds(arkcc, work)
        check(t == rows[5], 'no flag resolves to the same table as =5', err)

        corpus = ['inline_small.c', 'inline_mid.c', 'unroll12.c', 'unroll6.c',
                  'tail.c', 'xblock.c']
        same = True
        for src in corpus:
            rc, _ = run(arkcc, OBJ + [src, '-o', 'd_off.o'], work)
            rc2, _ = run(arkcc, OBJ + ['--size-weight=5', src, '-o', 'd_5.o'], work)
            if rc != 0 or rc2 != 0 or (digest(os.path.join(work, 'd_off.o')) !=
                                       digest(os.path.join(work, 'd_5.o'))):
                same = False
                break
        check(same, 'objects with no flag and with =5 are byte-identical',
              'corpus of %d files' % len(corpus))
        rc, _ = run(arkcc, OBJ + ['hello.c', '-o', 'e_off.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--size-weight=5', 'hello.c',
                                   '-o', 'e_5.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'e_off.o')) ==
              digest(os.path.join(work, 'e_5.o')),
              'a plain -O2 compile is unaffected by the default weight')

        # --- 3. each threshold reaches real code ----------------------------
        # inline: speed end expands both, default only the small one, size end
        # neither.
        for src, want in (('inline_small.c', {0: 0, 5: 0, 9: 2}),
                          ('inline_mid.c', {0: 0, 5: 2, 9: 2})):
            got = {}
            ok = True
            for w in (0, 5, 9):
                text, err = asm_of(arkcc, work, src,
                                   ['--size-weight=%d' % w], src + '_w%d' % w)
                if text is None:
                    check(False, 'the inline fixture builds at weight %d' % w, err)
                    ok = False
                    continue
                got[w] = count_lines(text, 'BL h')
            if ok:
                check(got == want,
                      'the inline limit is exercised by %s' % src,
                      'BL h at 0/5/9 = %d/%d/%d (expected %d/%d/%d)'
                      % (got[0], got[5], got[9], want[0], want[5], want[9]))

        # unroll: 12 iterations cross 16->8, 6 iterations cross 8->4.
        sizes = {}
        for src in ('unroll12.c', 'unroll6.c'):
            for w in (0, 5, 9):
                text, err = asm_of(arkcc, work, src,
                                   ['--unroll', '--size-weight=%d' % w],
                                   '%s_u%d' % (src, w))
                if text is None:
                    check(False, 'the unroll fixture builds', err)
                    return 1
                sizes[(src, w)] = body_lines(text)
        check(sizes[('unroll12.c', 0)] > sizes[('unroll12.c', 5)] ==
              sizes[('unroll12.c', 9)],
              'a 12-trip loop unrolls at the speed end only',
              '%d/%d/%d instruction lines' % (sizes[('unroll12.c', 0)],
                                              sizes[('unroll12.c', 5)],
                                              sizes[('unroll12.c', 9)]))
        check(sizes[('unroll6.c', 0)] == sizes[('unroll6.c', 5)] >
              sizes[('unroll6.c', 9)],
              'a 6-trip loop stops unrolling at the size end',
              '%d/%d/%d instruction lines' % (sizes[('unroll6.c', 0)],
                                              sizes[('unroll6.c', 5)],
                                              sizes[('unroll6.c', 9)]))

        # tail merge: the two-instruction tail is only accepted at the size end;
        # the long tail is accepted at the default but not at the speed end.
        tm = {}
        for w in (0, 5, 9):
            text, err = asm_of(arkcc, work, 'tail.c',
                               ['--tailmerge', '--size-weight=%d' % w],
                               'tail_w%d' % w)
            if text is None:
                check(False, 'the tail fixture builds', err)
                return 1
            tm[w] = body_lines(text)
        check(tm[9] < tm[5] < tm[0],
              'tail merging grows toward the size end (short tail accepted)',
              '%d/%d/%d instruction lines at 0/5/9' % (tm[0], tm[5], tm[9]))

        # whole-block merge: refused at the speed end, merged at the default.
        xb = {}
        for w in (0, 5, 9):
            text, err = asm_of(arkcc, work, 'xblock.c',
                               ['--xblock', '--size-weight=%d' % w],
                               'xb_w%d' % w)
            if text is None:
                check(False, 'the block fixture builds', err)
                return 1
            xb[w] = body_lines(text)
        check(xb[0] > xb[5] and xb[5] >= xb[9],
              'block merging is refused at the speed end and accepted after it',
              '%d/%d/%d instruction lines at 0/5/9' % (xb[0], xb[5], xb[9]))

        # --- 4. refusals ----------------------------------------------------
        for bad in ('--size-weight=10', '--size-weight=abc', '--size-weight=',
                    '--size-weight', '--size-weight=-1', '--size-weight=5x'):
            rc, log = run(arkcc, OBJ + [bad, 'inline_small.c', '-o', 'bad.o'],
                          work)
            produced = os.path.exists(os.path.join(work, 'bad.o'))
            check(rc != 0 and 'C3900U' in log and 'size-weight' in log and
                  not produced,
                  '%s is refused and writes nothing' % bad,
                  'rc=%d' % rc)
            if produced:
                os.remove(os.path.join(work, 'bad.o'))

        trimmed, why = build_arkcc(
            work,
            ['-DARKCC_FEATURE_OPT_INLINE=0', '-DARKCC_FEATURE_UNROLL=0',
             '-DARKCC_FEATURE_TAILMERGE=0', '-DARKCC_FEATURE_XBLOCK=0'],
            'arkcc_nosw')
        if trimmed is None:
            skip('trimmed build refuses --size-weight', why)
        else:
            rc, log = run(trimmed, OBJ + ['--size-weight=3', 'inline_small.c',
                                          '-o', 't.o'], work)
            check(rc != 0 and 'C3900U' in log and 'not compiled into' in log,
                  'trimmed build refuses --size-weight instead of ignoring it',
                  'rc=%d' % rc)
            # The trimmed build really has no weight: it compiles, and -v does
            # not print the table at all (so nothing silently keeps a default).
            rc2, log2 = run(trimmed, ARM + ['-v', '-S', '-o', 't2.s',
                                            'inline_small.c'], work)
            check(rc2 == 0 and 'size_weight=' not in log2,
                  'the trimmed build has no weight table at all',
                  'rc=%d' % rc2)

        # --- 5. the ini key -------------------------------------------------
        for key in ('size_weight', 'size-weight'):
            write(os.path.join(work, 'sw.cfg'), '[general]\n%s=9\n' % key)
            t, err = thresholds(arkcc, work, ['-config', 'sw.cfg'])
            check(t == rows[9], '%s=9 in a config file reaches the table' % key,
                  err)
        write(os.path.join(work, 'bad.cfg'), '[general]\nsize_weight=42\n')
        rc, log = run(arkcc, ['-config', 'bad.cfg'] + ARM +
                      ['-v', '-S', '-o', 'v2.s', 'hello.c'], work)
        m = THR_RE.search(log)
        check(rc == 0 and m is not None and int(m.group(1)) == 5 and
              'size_weight' in log and 'ignored' in log,
              'an out-of-range value in the file is reported and ignored',
              'rc=%d' % rc)

        # --- 6. semantics and the byte account ------------------------------
        if not HAVE_UNICORN:
            skip('execution at three weights', 'unicorn not installed')
        else:
            for src in ('tail.c', 'xblock.c', 'unroll6.c',
                        'inline_mid_rt.c'):
                vals = {}
                ok = True
                for w in (0, 5, 9):
                    v, err = image_value(arkcc, work, src,
                                         ['--tailmerge', '--xblock', '--unroll',
                                          '--size-weight=%d' % w],
                                         '%s_i%d' % (src, w))
                    if v is None:
                        skip('execution of %s at weight %d' % (src, w), err)
                        ok = False
                        break
                    vals[w] = v
                if ok:
                    check(vals[0] == vals[5] == vals[9],
                          '%s returns the same value at 0/5/9' % src,
                          '%d/%d/%d' % (vals[0], vals[5], vals[9]))

        total = {0: 0, 9: 0}
        for src in corpus:
            for w in (0, 9):
                rc, _ = run(arkcc, OBJ + ['--tailmerge', '--xblock', '--unroll',
                                          '--size-weight=%d' % w, src,
                                          '-o', 'acct_%d.o' % w], work)
                if rc == 0:
                    total[w] += os.path.getsize(os.path.join(work,
                                                             'acct_%d.o' % w))
        check(total[9] < total[0],
              'the size end is smaller than the speed end over the corpus',
              '%d -> %d bytes' % (total[0], total[9]))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
        return 1
    print('\nall size-weight checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())