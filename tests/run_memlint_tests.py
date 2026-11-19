#!/usr/bin/env python
"""--warn-mem (memory lint) gates.

What this switch does, and what it does not:

  `--warn-mem` adds two whole-function dataflow checks after semantics:

    1. returning the address of an automatic object -- `return &x;`,
       `return local_array;`, `return &local.member;`, `return (T){...};`
    2. double free / use after free inside one function, but only for a bare
       pointer that came straight out of malloc/calloc/realloc/strdup, never
       escaped (not passed to a call, not stored, not address-taken, not moved
       by pointer arithmetic) and was never reassigned.

  Everything outside that shape is deliberately silent: the pass would rather
  miss a defect than print a wrong line.  A clean run therefore does NOT mean
  "this program has no memory errors" -- it means none of the two shapes above
  was found.  The gates below are written to hold that line: each positive case
  is a shape the pass claims to see, each negative case is a neighbouring shape
  it promises to leave alone.

Source files here never `#include` anything: after preprocessing, arkc reports
the line number inside the preprocessed buffer, so a test that included a header
would have to encode that offset and would break the moment the header grew.
`malloc`/`free` are declared with `extern` instead, and expectations are located
by a stable ANCHOR comment rather than hard-coded line numbers, so editing the
case file does not silently re-point an assertion at another line.

Anti-false-green checks (the gate must be able to fail):
  * the same defective source compiles silent without --warn-mem  -> the pass,
    not something else, produced the warnings;
  * the same defects written in their legal form compile silent   -> the gate is
    not simply matching "a return of an address" or "two free() calls";
  * --warn-mem / --no-warn-mem are a switch, last one wins        -> a run with
    the switch off must be silent;
  * a build with -DARKCC_FEATURE_MEMLINT=0 refuses --warn-mem     -> the trim
    switch is real and says why, instead of silently ignoring the option.

Usage: run_memlint_tests.py [path-to-arkcc]
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

SRC_POS = r'''extern void *malloc(unsigned long);
extern void free(void *);

int g_cnt;
static int s_cnt;

struct S { int a; int b; };

int *ret_local(void);
int *ret_local(void)
{
    int x = 1;
    return &x;                  /* ANCHOR:ret_local */
}

char *ret_array(void);
char *ret_array(void)
{
    char a[4];
    a[0] = 0;
    return a;                   /* ANCHOR:ret_array */
}

int *ret_field(void);
int *ret_field(void)
{
    struct S s;
    s.a = 1;
    return &s.b;                /* ANCHOR:ret_field */
}

int *ret_complit(void);
int *ret_complit(void)
{
    return (int[]){1, 2, 3};    /* ANCHOR:ret_complit */
}

void dbl_free(void);
void dbl_free(void)
{
    char *p = (char *)malloc(8);
    free(p);
    free(p);                    /* ANCHOR:dbl_free */
}

void uaf_index(void);
void uaf_index(void)
{
    char *p = malloc(8);
    free(p);
    p[0] = 1;                   /* ANCHOR:uaf_index */
}

void uaf_arrow(void);
void uaf_arrow(void)
{
    struct S *p = (struct S *)malloc(8);
    free(p);
    p->a = 1;                   /* ANCHOR:uaf_arrow */
}

void uaf_deref(void);
void uaf_deref(void)
{
    char *p = malloc(8);
    free(p);
    *p = 0;                     /* ANCHOR:uaf_deref */
}
'''

POS_EXPECT = [
    # (anchor, message fragment)
    ('ret_local',   'address of the automatic object "x"'),
    ('ret_array',   'address of the automatic array "a"'),
    ('ret_field',   'address of the automatic object "s"'),
    ('ret_complit', 'address of a compound literal'),
    ('dbl_free',    '"p" is freed twice'),
    ('uaf_index',   'use of "p" after it was freed'),
    ('uaf_arrow',   'use of "p" after it was freed'),
    ('uaf_deref',   'use of "p" after it was freed'),
]

# The same defects, written correctly.  Every function here is the legal twin of
# the one with the same position in SRC_POS, so a gate that warns on the
# defect-shaped text rather than on the defect would light up here too.
SRC_FIXED = r'''extern void *malloc(unsigned long);
extern void free(void *);

int g_cnt;
static int s_cnt;

struct S { int a; int b; };

int *fx_local(void);
int *fx_local(void)
{
    return &g_cnt;              /* file-scope object outlives the call */
}

char *fx_array(void);
char *fx_array(void)
{
    static char a[4];
    a[0] = 0;
    return a;                   /* static storage: still alive */
}

int *fx_field(void);
int *fx_field(void)
{
    static struct S s;
    s.a = 1;
    return &s.b;
}

int *fx_complit(void);
int *fx_complit(void)
{
    static int t[3];
    return t;
}

void fx_dbl(void);
void fx_dbl(void)
{
    char *p = (char *)malloc(8);
    free(p);
    p = 0;
}

void fx_uaf(void);
void fx_uaf(void)
{
    char *p = malloc(8);
    p[0] = 1;
    free(p);
}

void fx_uaf_arrow(void);
void fx_uaf_arrow(void)
{
    struct S *p = (struct S *)malloc(8);
    p->a = 1;
    free(p);
}

void fx_uaf_deref(void);
void fx_uaf_deref(void)
{
    char *p = malloc(8);
    *p = 0;
    free(p);
}
'''

# Shapes the pass promises to leave alone.  Each one is a real program: they all
# compile and run, and every one of them is either safe or beyond what a single
# function's dataflow can decide.
SRC_NEG = r'''extern void *malloc(unsigned long);
extern void *realloc(void *p, unsigned long n);
extern void free(void *);
extern void sink(void *p);

int g_cnt;
static int s_cnt;

struct S { int a; int b; };

int *n_global(void);
int *n_global(void)
{
    return &g_cnt;
}

int *n_static(void);
int *n_static(void)
{
    static int s = 1;
    return &s;
}

int *n_param_member(struct S *p);
int *n_param_member(struct S *p)
{
    return &p->b;               /* b lives in the caller's object */
}

void n_reset(void);
void n_reset(void)
{
    char *p = malloc(8);
    free(p);
    p = 0;
    p[0] = 1;                   /* p no longer names freed memory */
}

void n_realloc(void);
void n_realloc(void)
{
    char *p = malloc(8);
    p = realloc(p, 16);
    p[0] = 1;
    free(p);
}

void n_arith(void);
void n_arith(void)
{
    char *p = malloc(8);
    free(p + 1);                /* not the pointer we tracked */
}

void n_partial(int c);
void n_partial(int c)
{
    char *p = malloc(8);
    if (c)
        free(p);
    p[0] = 1;                   /* freed on one path only: not decided */
}

void n_goto(int c);
void n_goto(int c)
{
    char *p = malloc(8);
    free(p);
    if (c)
        goto out;
    free(p);                    /* whole function is abandoned */
out:
    sink(p);
}

void n_revive(void);
void n_revive(void)
{
    char *p = malloc(8);
    free(p);
    p = malloc(16);
    p[0] = 1;
    free(p);
}

int *n_addr_of_deref(void);
int *n_addr_of_deref(void)
{
    int x = 1;
    int *p = &x;
    return &*p;                 /* no object created by this expression */
}

void n_escape(void);
void n_escape(void)
{
    char *p = malloc(8);
    free(p);
    sink(p);                    /* escaping: we stop owning it */
}

void n_plain(void);
void n_plain(void)
{
    char *p = malloc(8);
    free(p);
}
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

def line_of(src, anchor):
    """1-based line number of the unique line carrying `ANCHOR:<anchor>`."""
    hits = [i + 1 for i, ln in enumerate(src.splitlines()) if anchor in ln]
    if len(hits) != 1:
        raise AssertionError('anchor %r matched %d lines' % (anchor, len(hits)))
    return hits[0]

def warnings_in(log):
    """Total warning count from the summary line, or 0 when there is none."""
    m = re.findall(r':\s*(\d+)\s+warnings?,\s*(\d+)\s+errors?', log)
    return int(m[-1][0]) if m else 0

def errors_in(log):
    m = re.findall(r':\s*(\d+)\s+warnings?,\s*(\d+)\s+errors?', log)
    return int(m[-1][1]) if m else 0

def reported_lines(log):
    """Every `file`, line N: -- the coordinate the diagnostic carries."""
    return [int(n) for n in re.findall(r'",\s*line\s+(\d+):', log)]

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7', '-c']

def build_arkcc(where, define):
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
    out = os.path.join(where, 'arkcc_nomemlint.exe' if os.name == 'nt'
                       else 'arkcc_nomemlint')
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

    work = tempfile.mkdtemp(prefix='arkcc_memlint_')
    try:
        for name, text in (('pos.c', SRC_POS), ('fixed.c', SRC_FIXED),
                           ('neg.c', SRC_NEG)):
            with open(os.path.join(work, name), 'w', newline='') as f:
                f.write(text)

        # --- 1. every claimed shape is reported, on the right line -----------
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos.o', '--warn-mem'], work)
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

        # --- 2. the legal twin of those same shapes is silent ---------------
        rc, log = run(arkcc, ARM + ['fixed.c', '-o', 'fixed.o', '--warn-mem'],
                      work)
        check(rc == 0, 'fixed file compiles', 'rc=%d' % rc)
        check(warnings_in(log) == 0, 'fixed file is silent',
              '%d warning(s)' % warnings_in(log))

        # --- 3. the neighbouring shapes it promises to ignore ---------------
        rc, log = run(arkcc, ARM + ['neg.c', '-o', 'neg.o', '--warn-mem'], work)
        check(rc == 0, 'negative file compiles', 'rc=%d' % rc)
        check(warnings_in(log) == 0, 'negative file is silent',
              (log.strip().splitlines() or [''])[0][:90])

        # --- 4. anti-false-green: the switch is what produces them ----------
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos_off.o'], work)
        check(rc == 0 and warnings_in(log) == 0,
              'same defect file is silent without --warn-mem',
              '%d warning(s)' % warnings_in(log))
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos_off2.o', '--warn-mem',
                                    '--no-warn-mem'], work)
        check(rc == 0 and warnings_in(log) == 0,
              '--no-warn-mem after --warn-mem turns it back off',
              '%d warning(s)' % warnings_in(log))
        rc, log = run(arkcc, ARM + ['pos.c', '-o', 'pos_on.o', '--no-warn-mem',
                                    '--warn-mem'], work)
        check(warnings_in(log) == len(POS_EXPECT),
              '--warn-mem after --no-warn-mem turns it on again',
              '%d warning(s)' % warnings_in(log))

        # --- 5. anti-false-green: the trim switch is real -------------------
        trimmed, why = build_arkcc(work, '-DARKCC_FEATURE_MEMLINT=0')
        if trimmed is None:
            skip('trimmed build refuses --warn-mem', why)
        else:
            rc, log = run(trimmed, ARM + ['pos.c', '-o', 'tm.o', '--warn-mem'],
                          work)
            check(rc != 0 and 'C3900U' in log and 'ARKCC_FEATURE_MEMLINT' in log,
                  'trimmed build refuses --warn-mem and says how to enable it',
                  'rc=%d' % rc)
            rc2, log2 = run(trimmed, ARM + ['pos.c', '-o', 'tm2.o'], work)
            check(rc2 == 0 and warnings_in(log2) == 0,
                  'trimmed build compiles the same file normally',
                  'rc=%d' % rc2)

        # --- 6. the same switch through arkcc.cfg ---------------------------
        with open(os.path.join(work, 'warn.cfg'), 'w', newline='') as f:
            f.write('[features]\nwarn_mem=1\n')
        rc, log = run(arkcc, ['-config', 'warn.cfg'] + ARM +
                      ['pos.c', '-o', 'cfg.o'], work)
        check(warnings_in(log) == len(POS_EXPECT),
              'warn_mem=1 in a config file switches the pass on',
              '%d warning(s)' % warnings_in(log))
        if trimmed is None:
            skip('trimmed build refuses warn_mem=1 from a config file', why)
        else:
            rc, log = run(trimmed, ['-config', 'warn.cfg'] + ARM +
                          ['pos.c', '-o', 'cfg2.o'], work)
            check(rc != 0 and 'C3900U' in log,
                  'trimmed build refuses warn_mem=1 from a config file',
                  'rc=%d' % rc)
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        return 1
    print('\nall --warn-mem checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())
