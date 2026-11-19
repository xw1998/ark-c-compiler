#!/usr/bin/env python
"""Gates for --ipo / -flto (whole-program compilation across translation units).

What the option promises
------------------------
One invocation, several .c files, one program:
  * each file is parsed and lowered on its own (a `static` name in file A is
    not file B's `static` -- that is what C says),
  * the units are appended into a single IR program, statics are renamed so
    the boundary survives the merge, external names are resolved with the
    linker's rules (weak loses to strong, two strong definitions are an
    error, two tentative definitions of one object are one object),
  * the pass pipeline runs ONCE over the whole program, so a cross-file call
    can be inlined at -O2, which no per-file compilation can do,
  * file-scope code nothing refers to any more is dropped (size only).

Why the gate has to be built this way
-------------------------------------
"It compiles" says nothing here: a merge that silently binds file A's `helper`
to file B's `helper` also compiles, and returns the wrong number.  So each
check below is a case where a plausible shortcut produces a *different*
observable result: a return value on the ARM emulator, an unresolved-symbol
refusal, a missing definition, or a byte of assembly.

Anti-false-green
----------------
The gate must be able to fail:
  * default off -- without --ipo a single file's image is byte-identical to
    `--ipo` on that same file (so the flag is what changed the answer, and the
    flag off changes nothing);
  * a build with -DARKCC_FEATURE_IPO=0 refuses --ipo with a reason instead of
    pretending to merge;
  * the "two strong definitions" check is the same code path the static check
    depends on: if `static` names stopped being distinct, the two-static case
    would collapse into a duplicate-definition error, i.e. the check that
    guards mangling is exercised and would go red.

Usage: run_ipo_tests.py [path-to-arkcc]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
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

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7']
IMG = ARM + ['-O1', '--vector-table']

# --- 1. cross-file call: triple(7) + 7 = 28 -------------------------------
# No initialised global here on purpose: the startup below defines
# __arkcc_init_globals, which is the hook the compiler would otherwise use to
# store initialisers, so a `= 7` would silently stay 0 and the test would be
# measuring the startup, not the merge.
CROSS_MAIN = '''\
extern int triple(int x);
int main(void) { return triple(7) + 7; }
'''

CROSS_LIB = '''\
int triple(int x) { return x * 3; }
''' + STARTUP

# --- 2. same static name in two files: 2*10 + 3 = 23 ----------------------
STATIC_A = '''\
static int step(int x) { return x + 1; }
extern int use_b(int x);
int main(void) { return step(1) * 10 + use_b(1); }
'''

STATIC_B = '''\
static int step(int x) { return x + 2; }
int use_b(int x) { return step(x); }
''' + STARTUP

# --- 3. two strong definitions of one function -> error -------------------
DUP_A = '''\
int dup(void) { return 1; }
int main(void) { return dup(); }
'''

DUP_B = '''\
int dup(void) { return 2; }
'''

# --- 4. tentative definitions merge: g is 0, main returns 4 --------------
TENT_A = '''\
int g;
int main(void) { return g + 4; }
'''



TENT_B = '''\
int g;
''' + STARTUP

# --- 5. two initialised definitions of one object -> error ---------------
INIT_A = '''\
int g = 1;
int main(void) { return g; }
'''

INIT_B = '''\
int g = 1;
'''

# --- 6. undefined external is still refused ------------------------------
UNDEF = '''\
extern int missing(void);
int main(void) { return missing(); }
'''

# --- 7. pruning: `dead` is static and unreachable from anything ----------
PRUNE_MAIN = '''\
extern int keep(void);
int main(void) { return keep(); }
'''

PRUNE_LIB = '''\
static int dead(int x) { return x - 1; }
int keep(void) { return 9; }
'''

# --- 8. cross-file inlining evidence: `one` is small enough to expand -----
INL_MAIN = '''\
extern int one(void);
int main(void) { return one() * 2; }
'''

INL_LIB = '''\
int one(void) { return 1; }
''' + STARTUP

# --- 9. a file with no statics: --ipo must equal a plain compile ---------
PLAIN = '''\
int main(void) { return 42; }
'''

# --- 10. not C source: refused with the reason ---------------------------
ASM_INPUT = '''\
    .text
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


def asm_text(path):
    with open(path, 'r', errors='replace') as f:
        return f.read()


def image_value(arkcc, sources, work, flags, tag):
    """Compile `sources` in one --ipo invocation and run the image.
    Returns (value, detail) with value None on any failure."""
    img = os.path.join(work, tag + '.bin')
    rc, log = run(arkcc, IMG + flags + list(sources) + ['-o', img], work)
    if rc != 0:
        return None, 'compile: ' + log.strip()[:300]
    with open(img, 'rb') as f:
        status, value, detail = run_image(f.read())
    if status != 'returned':
        return None, 'emulator: %s %s' % (status, detail)
    return value, ''


def build_arkcc(where, defines, name):
    cc = os.environ.get('CC', 'gcc')
    if not shutil.which(cc):
        return None, 'no %s on PATH' % cc
    srcs = (sorted(__import__('glob').glob('src/*.c')) +
            sorted(__import__('glob').glob('src/backend/*/*.c')) +
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


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_ipo_')
    try:
        files = {
            'cross_main.c': CROSS_MAIN, 'cross_lib.c': CROSS_LIB,
            'stat_a.c': STATIC_A, 'stat_b.c': STATIC_B,
            'dup_a.c': DUP_A, 'dup_b.c': DUP_B,
            'tent_a.c': TENT_A, 'tent_b.c': TENT_B,
            'init_a.c': INIT_A, 'init_b.c': INIT_B,
            'undef.c': UNDEF,
            'prune_main.c': PRUNE_MAIN, 'prune_lib.c': PRUNE_LIB,
            'inl_main.c': INL_MAIN, 'inl_lib.c': INL_LIB,
            'plain.c': PLAIN,
            'thing.s': ASM_INPUT,
        }
        for name, text in files.items():
            write(os.path.join(work, name), text)

        # ---------------------------------------------------------- 1. dynamic
        if HAVE_UNICORN:
            v, why = image_value(arkcc, ['cross_main.c', 'cross_lib.c'], work,
                                 ['--ipo'], 'cross')
            check(v == 28, 'a cross-file call returns the callee\'s answer',
                  why or 'got %r' % (v,))

            v, why = image_value(arkcc, ['stat_a.c', 'stat_b.c'], work,
                                 ['--ipo'], 'statics')
            check(v == 23, 'two files each keep their own static of one name',
                  why or 'got %r' % (v,))

            v, why = image_value(arkcc, ['tent_a.c', 'tent_b.c'], work,
                                 ['--ipo'], 'tent')
            check(v == 4, 'two tentative definitions are one object',
                  why or 'got %r' % (v,))
        else:
            skip('the emulator checks', 'run_arm_exec unavailable')

        # ------------------------------------------------------- 2. refusals
        img = os.path.join(work, 'dup.bin')
        rc, log = run(arkcc, IMG + ['--ipo', 'dup_a.c', 'dup_b.c', '-o', img],
                      work)
        check(rc != 0 and 'multiple definition of function' in log
              and "'dup'" in log,
              'two strong definitions are an error that names the symbol',
              'rc=%d %s' % (rc, log.strip()[:160]))
        check(not os.path.exists(img),
              'a refused merge writes no image', 'dup.bin exists')

        rc, log = run(arkcc, IMG + ['--ipo', 'init_a.c', 'init_b.c',
                                    '-o', os.path.join(work, 'init.bin')], work)
        check(rc != 0 and 'multiple definition' in log and "'g'" in log,
              'two initialised definitions of one object are an error',
              'rc=%d %s' % (rc, log.strip()[:160]))

        rc, log = run(arkcc, IMG + ['--ipo', 'undef.c',
                                    '-o', os.path.join(work, 'undef.bin')], work)
        check(rc != 0 and 'cannot be resolved' in log,
              'an undefined external is still refused, not linked away',
              'rc=%d %s' % (rc, log.strip()[:160]))

        rc, log = run(arkcc, ARM + ['-O1', '--ipo', 'plain.c', 'thing.s',
                                    '-o', os.path.join(work, 'asm.bin')], work)
        check(rc != 0 and 'not a C source' in log and 'assembly source' in log,
              'an assembly input is refused with the reason',
              'rc=%d %s' % (rc, log.strip()[:160]))

        # ------------------------------------------------- 3. option refusals
        refusals = [
            (['--ipo', 'plain.c', '-c', '-o', 'x.o'], '-c'),
            (['--ipo', 'plain.c', '-E', '-o', 'x.i'], '-E'),
            (['--ipo', 'plain.c', '-g', '-o', 'x.bin'], '-g'),
            (['--ipo', 'plain.c', '-link', '-o', 'x.bin'], '-link'),
            (['--ipo', 'plain.c'], 'no -o'),
        ]
        for args, what in refusals:
            rc, log = run(arkcc, ARM + args, work)
            check(rc != 0 and '--ipo cannot be combined with ' + what in log,
                  '--ipo refuses %s with a reason' % what,
                  'rc=%d %s' % (rc, log.strip()[:160]))

        # ------------------------------------------------------ 4. static
        rc, log = run(arkcc, ARM + ['-O1', '--ipo', 'prune_main.c',
                                    'prune_lib.c', '-S', '-o', 'prune.s'], work)
        text = asm_text(os.path.join(work, 'prune.s')) if rc == 0 else ''
        check(rc == 0 and 'dead' not in text,
              'an unreachable static is dropped from the merged program',
              'rc=%d %s' % (rc, log.strip()[:120]))
        rc, log = run(arkcc, ARM + ['-O1', 'prune_lib.c', '-S',
                                    '-o', 'prune_alone.s'], work)
        text = asm_text(os.path.join(work, 'prune_alone.s')) if rc == 0 else ''
        check(rc == 0 and 'dead' in text,
              'the same static is kept by a plain single-file compile',
              'rc=%d' % rc)

        # ------------------------------------------------- 5. inline across TU
        rc, _ = run(arkcc, ARM + ['-O2', '--ipo', 'inl_main.c', 'inl_lib.c',
                                  '-S', '-o', 'inl_o2.s'], work)
        t2 = asm_text(os.path.join(work, 'inl_o2.s')) if rc == 0 else ''
        rc, _ = run(arkcc, ARM + ['-O1', '--ipo', 'inl_main.c', 'inl_lib.c',
                                  '-S', '-o', 'inl_o1.s'], work)
        t1 = asm_text(os.path.join(work, 'inl_o1.s')) if rc == 0 else ''
        check('BL one' in t1 and 'BL one' not in t2,
              '-O2 inlines a call into another file, -O1 leaves the call',
              'o1_has_bl=%s o2_has_bl=%s'
              % ('BL one' in t1, 'BL one' in t2))

        # ---------------------------------- 6. default off == plain compile
        rc1, _ = run(arkcc, ARM + ['-O1', '-S', '-o', 'plain_a.s', 'plain.c'],
                     work)
        rc2, _ = run(arkcc, ARM + ['-O1', '--ipo', '-S', '-o', 'plain_b.s',
                                   'plain.c'], work)
        same = (rc1 == 0 and rc2 == 0 and
                digest(os.path.join(work, 'plain_a.s')) ==
                digest(os.path.join(work, 'plain_b.s')))
        check(same, 'one file through --ipo is byte-identical to plain',
              'rc=%d/%d' % (rc1, rc2))

        rc1, _ = run(arkcc, ARM + ['-O1', '--vector-table', '-o', 'plain_a.bin',
                                   'plain.c'], work)
        rc2, _ = run(arkcc, ARM + ['-O1', '--vector-table', '--ipo',
                                   '-o', 'plain_b.bin', 'plain.c'], work)
        same = (rc1 == 0 and rc2 == 0 and
                digest(os.path.join(work, 'plain_a.bin')) ==
                digest(os.path.join(work, 'plain_b.bin')))
        check(same, 'and so is its image', 'rc=%d/%d' % (rc1, rc2))

        # ------------------------------------- 7. a cropped build refuses
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_IPO=0'],
                                   'arkcc_noipo')
        if not trimmed:
            skip('the cropped build refuses --ipo', why)
        else:
            rc, log = run(trimmed, ARM + ['-O1', '--ipo', 'plain.c',
                                          '-o', os.path.join(work, 'no.bin')],
                          work)
            check(rc != 0 and 'not compiled into this build' in log,
                  'the cropped build refuses --ipo instead of merging',
                  'rc=%d %s' % (rc, log.strip()[:160]))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    print()
    if failures:
        print('%d check(s) failed' % len(failures))
        return 1
    print('all --ipo checks passed%s'
          % (' (%d skipped)' % len(skips) if skips else ''))
    return 0


if __name__ == '__main__':
    sys.exit(main())
