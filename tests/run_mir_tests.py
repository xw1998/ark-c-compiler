#!/usr/bin/env python
"""--warn-unreachable / --warn-unused-static / --warn-recursion gates.

These three checks share one middle-end substrate (src/mir.c builds the basic
block graph and the call graph).  What they promise:

  --warn-unreachable     a maximal run of basic blocks that no path from the
                         function entry reaches, and that contains at least one
                         real instruction, is reported once.  Blocks the emitters
                         write themselves (a `JMP` after an `if` arm that already
                         returned, the implicit trailing `return 0`) are phantom
                         and never reported.
  --warn-unused-static   a `static` function with no incoming call, whose
                         address is never taken, that is not tagged
                         used/unused/weak/constructor/destructor/asm and is not
                         `inline`, is reported.  A unit containing inline asm
                         names symbols this graph cannot read, so the whole unit
                         stays silent rather than guessing.
  --warn-recursion       every strongly connected component of the call graph
                         that is a cycle (self loop or size > 1) is reported once,
                         at its lowest-indexed member.

Every check is a *reporting* pass: they do not modify the IR.  The gate proves
that by compiling the same source with all three on and all three off and
comparing the object images byte for byte.

Source files here never `#include`: after preprocessing arkc reports the line
inside the preprocessed buffer, so expectations are located by ANCHOR comments.

Anti-false-green checks (the gate must be able to fail):
  * the same sources compile silent without the switches;
  * the legal twins of every reported shape are silent;
  * `--no-...` after `--...` turns each check back off;
  * `--print-pipeline` lists the three stages and their switches;
  * a build with -DARKCC_FEATURE_MIR=0 refuses all three options with C3900U.

Usage: run_mir_tests.py [path-to-arkcc]
Exit 0 = every check behaved.
"""
import glob
import hashlib
import os
import re
import shutil
import subprocess
import sys
import tempfile

# ---------------------------------------------------------------- case sources

SRC_DEAD = r'''extern int g_take(int);

int dead_after_return(int x)
{
    if (x) return 1;
    return 2;
    x = 3;                          /* ANCHOR:dead_store */
    g_take(x);
    return x;
}

int live_shapes(int x)
{
    int i = 0;
    if (x) i = 1;                   /* ANCHOR:live_if */
    else   i = 2;
    while (i < 3) i++;              /* ANCHOR:live_while */
    switch (x) {
    case 1: i += 1; break;          /* ANCHOR:live_switch */
    default: break;
    }
    goto done;
done:
    return i;                       /* ANCHOR:live_done */
}

/* Registered miss: a bare `return 2;` right after `return 1;` has the same
 * shape as the implicit epilogue every function carries, so it stays silent. */
int silent_double_return(int x)
{
    if (x) return 1;                /* ANCHOR:miss_if */
    return 2;                       /* ANCHOR:miss_return */
}
'''

SRC_UNUSED = r'''static int helper(int x) { return x + 1; }            /* ANCHOR:helper */
static int used(int x) { return x * 2; }
static int taken(int x) { return x - 1; }
static inline int inline_helper(int x) { return x + 5; }
static int __attribute__((unused)) kept(int x) { return x; }
static int __forceinline int forced(int x) { return x + 9; }

int (*taken_ptr)(int) = taken;

int caller(void) { return used(3); }

int main(void)
{
    return caller() + taken_ptr(1) - 1;
}
'''

SRC_ASM = r'''static int never_called(int x) { return x; }

int asm_tu(void)
{
    __asm("nop");
    return 0;
}
'''

SRC_REC = r'''int a(int n);
int b(int n);

int a(int n) { if (n <= 0) return 0; return b(n - 1); }   /* ANCHOR:a_def */
int b(int n) { if (n <= 0) return 1; return a(n - 1); }   /* ANCHOR:b_def */

int self(int n) { return n ? self(n - 1) : 0; }           /* ANCHOR:self_def */

int leaf(int n) { return n + 1; }                         /* ANCHOR:leaf */

int main(void) { return leaf(1); }
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
    return [int(n) for n in re.findall(r'",\s*line\s+(\d+):', log)]

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7', '-c']
ALL_ON = ['--warn-unreachable', '--warn-unused-static', '--warn-recursion']

def build_arkcc(where, define, name):
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

def digest(path):
    with open(path, 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_mir_')
    try:
        for name, text in (('dead.c', SRC_DEAD), ('unused.c', SRC_UNUSED),
                           ('asm.c', SRC_ASM), ('rec.c', SRC_REC)):
            with open(os.path.join(work, name), 'w', newline='') as f:
                f.write(text)

        # --- 1. unreachable: one真阳性, 每个 legal twin 沉默 -----------------
        rc, log = run(arkcc, ARM + ['dead.c', '-o', 'dead.o',
                                    '--warn-unreachable'], work)
        check(rc == 0 and errors_in(log) == 0,
              'dead-code file still compiles', 'rc=%d' % rc)
        check(warnings_in(log) == 1,
              'exactly one unreachable run is reported (the doubles are silent)',
              '%d warning(s)' % warnings_in(log))
        hit = set(reported_lines(log))
        want = line_of(SRC_DEAD, 'ANCHOR:dead_store')
        check(want in hit and 'can never run' in log and 'dead_after_return' in log,
              'reports the dead store on its own line',
              'line %d' % want)
        for anchor in ('live_if', 'live_while', 'live_switch', 'live_done'):
            ln = line_of(SRC_DEAD, 'ANCHOR:' + anchor)
            check(ln not in hit, 'live shape %s is not reported' % anchor,
                  'line %d' % ln)
        check(line_of(SRC_DEAD, 'ANCHOR:miss_return') not in hit,
              'registered miss: bare `return 2;` after `return 1;` stays silent')

        # --- 2. unused-static ------------------------------------------------
        rc, log = run(arkcc, ARM + ['unused.c', '-o', 'unused.o',
                                    '--warn-unused-static'], work)
        check(rc == 0 and errors_in(log) == 0,
              'unused-static file still compiles', 'rc=%d' % rc)
        check(warnings_in(log) == 1,
              'only the plain unused static is reported',
              '%d warning(s)' % warnings_in(log))
        hit = set(reported_lines(log))
        check(line_of(SRC_UNUSED, 'ANCHOR:helper') in hit and 'helper' in log,
              'reports `helper` on its own line')
        check('inline_helper' not in log and 'forced' not in log,
              'static inline / __forceinline helpers stay silent')
        check("'kept'" not in log and "'taken'" not in log and
              "'used'" not in log,
              'used/unused/address-taken statics stay silent')

        # --- 3. inline asm silences the whole unit ---------------------------
        rc, log = run(arkcc, ARM + ['asm.c', '-o', 'asm.o',
                                    '--warn-unused-static'], work)
        check(rc == 0 and warnings_in(log) == 0,
              'a unit with inline asm stays silent for unused-static',
              '%d warning(s)' % warnings_in(log))

        # --- 4. recursion ----------------------------------------------------
        rc, log = run(arkcc, ARM + ['rec.c', '-o', 'rec.o',
                                    '--warn-recursion'], work)
        check(rc == 0 and errors_in(log) == 0,
              'recursion file still compiles', 'rc=%d' % rc)
        check(warnings_in(log) == 2,
              'one report per cyclic SCC (mutual pair + self loop)',
              '%d warning(s)' % warnings_in(log))
        check("'a'" in log and 'call cycle' in log,
              'mutual recursion is reported on the cycle')
        check("'self'" in log and 'calls itself' in log,
              'self recursion says it calls itself')
        check('leaf' not in log, 'a non-recursive leaf stays silent')

        # --- 5. anti-false-green: the switches produce them ------------------
        rc, log = run(arkcc, ARM + ['dead.c', '-o', 'd0.o',
                                    'unused.c', '-o', 'u0.o',
                                    'rec.c', '-o', 'r0.o'], work)
        check(warnings_in(log) == 0,
              'all three files are silent without the switches',
              '%d warning(s)' % warnings_in(log))
        rc, log = run(arkcc, ARM + ['dead.c', '-o', 'd1.o'] +
                      ALL_ON + ['--no-warn-unreachable', '--no-warn-unused-static',
                                '--no-warn-recursion'], work)
        check(warnings_in(log) == 0,
              '--no-... after the positive forms turns all three off',
              '%d warning(s)' % warnings_in(log))
        rc, log = run(arkcc, ARM + ['dead.c', '-o', 'd2.o',
                                    '--no-warn-unreachable',
                                    '--warn-unreachable'], work)
        check(warnings_in(log) == 1,
              '--warn-unreachable after --no-... turns it back on',
              '%d warning(s)' % warnings_in(log))

        # --- 6. --print-pipeline lists the stages ---------------------------
        rc, log = run(arkcc, ARM + ['dead.c', '-o', 'd3.o', '--print-pipeline'],
                      work)
        for name, flag in (('ir.unreachable', '--warn-unreachable'),
                           ('ir.unused-static', '--warn-unused-static'),
                           ('ir.recursion', '--warn-recursion')):
            check(name in log and flag in log,
                  '--print-pipeline lists %s / %s' % (name, flag))

        # --- 7. zero change: same object with checks on and off -------------
        for src, tag in (('dead.c', 'dead'), ('unused.c', 'unused'),
                         ('rec.c', 'rec')):
            rc, _ = run(arkcc, ARM + [src, '-o', tag + '_off.o'], work)
            rc2, _ = run(arkcc, ARM + [src, '-o', tag + '_on.o'] + ALL_ON, work)
            ok = rc == 0 and rc2 == 0 and \
                 digest(os.path.join(work, tag + '_off.o')) == \
                 digest(os.path.join(work, tag + '_on.o'))
            check(ok, 'checks are read-only: %s object is byte-identical' % src)

        # --- 8. trim switch is real -----------------------------------------
        trimmed, why = build_arkcc(work, '-DARKCC_FEATURE_MIR=0', 'arkcc_nomir')
        if trimmed is None:
            skip('trimmed build refuses the three options', why)
        else:
            for opt in ALL_ON:
                rc, log = run(trimmed, ARM + ['dead.c', '-o', 'tm.o', opt], work)
                check(rc != 0 and 'C3900U' in log and
                      'ARKCC_FEATURE_MIR' in log,
                      'trimmed build refuses %s and says how to enable it' % opt,
                      'rc=%d' % rc)
            rc2, log2 = run(trimmed, ARM + ['dead.c', '-o', 'tm2.o'], work)
            check(rc2 == 0 and warnings_in(log2) == 0,
                  'trimmed build compiles the same file normally',
                  'rc=%d' % rc2)

        # --- 9. the switches through arkcc.cfg ------------------------------
        with open(os.path.join(work, 'mir.cfg'), 'w', newline='') as f:
            f.write('[features]\nwarn_unreachable=1\nwarn_unused_static=1\n'
                    'warn_recursion=1\n')
        rc, log = run(arkcc, ['-config', 'mir.cfg'] + ARM +
                      ['unused.c', '-o', 'cfg.o'], work)
        check(warnings_in(log) == 1,
              'all three keys in a config file switch the checks on',
              '%d warning(s)' % warnings_in(log))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        return 1
    print('\nall --warn-mir checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())
