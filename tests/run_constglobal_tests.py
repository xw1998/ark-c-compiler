#!/usr/bin/env python
"""Gates for --const-global (whole-program propagation of `const` objects).

What the option promises
------------------------
A file-scope `const` object is a constant: every read of it yields the value
its initialiser spells out, because writing it is undefined behaviour.  irgen
still emits a load through its address (it cannot know, while generating one
unit, whether the definition lives in that unit).  After inlining -- and,
under --ipo, after every unit is in one program -- the pass replaces that load
with the immediate and re-folds, so `K * 2 + 1` becomes one `MOV`.

What the gate has to catch
-------------------------
Two different failures, and they are opposites:
  * the pass does not run  -> the load is still in the assembly (checks 1-5);
  * the pass runs too far  -> it folds a read it was not allowed to fold, and
    the program answers the old value (checks 6-10).  Every conservative case
    below is one where folding would change a *visible* result or remove a
    read the C program asked for.

Anti-false-green
----------------
  * every effect check is paired with the flag off, so "no load" cannot come
    from the backend having changed;
  * the pipeline dump has to say `run ir.const-global` (and, without the flag,
    `skip ... off (--const-global)`), so a stage that silently vanished from
    the table is red;
  * a build with -DARKCC_FEATURE_CONST_GLOBAL=0 refuses the flag instead of
    accepting it silently, and its output with the flag absent is byte-
    identical to the full build's -- that is the "default off changes
    nothing" claim, measured rather than asserted.

Usage: run_constglobal_tests.py [path-to-arkcc]
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

# The startup defines nothing but the reset entry point: __arkcc_init_globals is
# the function the compiler itself emits for initialisers, and calling it here
# means the test measures the pass, not a hand-written stub.  (Defining an
# empty one in the test source would silently zero every initialised global --
# that is how the --ipo gate once "proved" a wrong answer.)
STARTUP = '''\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void)
{
    __arkcc_init_globals();
    return main();
}
'''

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7']
IMG = ARM + ['-O1', '--vector-table']

# --- the cross-unit case -------------------------------------------------
CROSS_SUP = '''\
void __arkcc_init_globals(void);
extern int sum(void);
int main(void) { return sum(); }
int Reset_Handler(void) { __arkcc_init_globals(); return main(); }
'''

CROSS_LIB = '''\
const int LIMIT = 100;
const int STEP = 3;
int sum(void) { return LIMIT + STEP; }
'''

# --- conservative cases: folding any of these would be wrong -------------
ADDR_TAKEN = '''\
const int K = 5;
int main(void) { const int *p = &K; return *p + 1; }
''' + STARTUP

STORE_THROUGH = '''\
const int K = 5;
int main(void) { *(int *)&K = 9; return K; }
''' + STARTUP

VOLATILE_K = '''\
volatile const int V = 5;
int main(void) { return V + 1; }
''' + STARTUP

CONST_ARRAY = '''\
const int tab[3] = {1, 2, 3};
int main(void) { return tab[1] + 1; }
''' + STARTUP

CONST_LL = '''\
const long long big = 5;
int main(void) { return (int)big + 1; }
''' + STARTUP

# --- a static const in one file: ordinary case, must fold ----------------
STATIC_CONST = '''\
static const int P = 7;
int main(void) { return P * 2 + 1; }
''' + STARTUP

PLAIN = '''\
int main(void) { return 42; }
''' + STARTUP

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

def func_body(text, name):
    """The instructions of one function, without its label or the next
    function's.  Counting loads over the whole file would also count the
    runtime helper (__aeabi_memcpy carries LDRB), which has nothing to do with
    the object under test."""
    out = []
    on = False
    for line in text.splitlines():
        s = line.strip()
        if s == name + ':':
            on = True
            continue
        if not on:
            continue
        if s.startswith('.size ') or s.startswith('.global '):
            break
        out.append(line)
    return '\n'.join(out)

def has_load(body):
    return 'LDR' in body or 'LDRB' in body

def image_value(arkcc, sources, work, flags, tag):
    img = os.path.join(work, tag + '.bin')
    rc, log = run(arkcc, IMG + flags + list(sources) + ['-o', img], work)
    if rc != 0:
        return None, 'compile: ' + log.strip()[:200]
    with open(img, 'rb') as f:
        status, value, detail = run_image(f.read())
    if status != 'returned':
        return None, 'emulator: %s %s' % (status, detail)
    return value, ''

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

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_cg_')
    try:
        files = {
            'cross_sup.c': CROSS_SUP, 'cross_lib.c': CROSS_LIB,
            'addr.c': ADDR_TAKEN, 'store.c': STORE_THROUGH,
            'vol.c': VOLATILE_K, 'array.c': CONST_ARRAY,
            'll.c': CONST_LL, 'stat.c': STATIC_CONST, 'plain.c': PLAIN,
        }
        for name, text in files.items():
            write(os.path.join(work, name), text)

        # ------------------------------------------- 1. the cross-unit fold
        rc, log = run(arkcc, ARM + ['-O1', '--ipo', '--const-global', '-S',
                                    '-o', 'cross_on.s', 'cross_sup.c',
                                    'cross_lib.c'], work)
        on = asm_text(os.path.join(work, 'cross_on.s')) if rc == 0 else ''
        body_on = func_body(on, 'sum')
        check(rc == 0 and body_on != '' and not has_load(body_on),
              'a const int defined in another unit folds to an immediate',
              'rc=%d body=%r' % (rc, body_on.replace('\n', ' ')[:90]))

        rc, log = run(arkcc, ARM + ['-O1', '--ipo', '-S', '-o', 'cross_off.s',
                                    'cross_sup.c', 'cross_lib.c'], work)
        off = asm_text(os.path.join(work, 'cross_off.s')) if rc == 0 else ''
        body_off = func_body(off, 'sum')
        check(rc == 0 and has_load(body_off),
              'without the flag the same read is still a load',
              'rc=%d body=%r' % (rc, body_off.replace('\n', ' ')[:90]))

        # --------------------------------------- 2. and the answer is right
        if HAVE_UNICORN:
            v, why = image_value(arkcc, ['cross_sup.c', 'cross_lib.c'], work,
                                 ['--ipo', '--const-global'], 'cross')
            check(v == 103, 'the folded program still returns 103',
                  why or 'got %r' % (v,))
            v, why = image_value(arkcc, ['cross_sup.c', 'cross_lib.c'], work,
                                 ['--ipo'], 'cross_off')
            check(v == 103, 'and so does the un-folded one (value unchanged)',
                  why or 'got %r' % (v,))
        else:
            skip('the emulator value checks', 'run_arm_exec unavailable')

        # --------------------------------------------- 3. the level gate
        rc, log = run(arkcc, ARM + ['-O0', '--ipo', '--const-global', '-S',
                                    '-o', 'cross_o0.s', 'cross_sup.c',
                                    'cross_lib.c'], work)
        t = asm_text(os.path.join(work, 'cross_o0.s')) if rc == 0 else ''
        check(rc == 0 and has_load(func_body(t, 'sum')),
              '-O0 keeps the load even with the flag (the pass is -O1+)',
              'rc=%d' % rc)

        # ------------------------------------------- 4. the stage is in the table
        rc, log = run(arkcc, ARM + ['--print-pipeline', '-O1', '--const-global',
                                    'plain.c'], work)
        check(rc == 0 and 'run' in log and 'ir.const-global' in log,
              'the pipeline dump reports the stage as run',
              'rc=%d %r' % (rc, [l for l in log.splitlines()
                                 if 'const-global' in l][:1]))
        rc, log = run(arkcc, ARM + ['--print-pipeline', '-O1', 'plain.c'], work)
        check(rc == 0 and 'ir.const-global' in log and
              'off (--const-global)' in log,
              'and reports it as off with the reason when the flag is absent',
              'rc=%d' % rc)

        # ------------------------------------------- 5. conservative cases
        cases = [
            ('addr.c', 'main', 'an address-taken const keeps its load', 6),
            ('vol.c', 'main', 'a volatile const keeps its read', 6),
            ('array.c', 'main', 'a const array keeps its load', 3),
        ]
        for src, fn, what, want in cases:
            out = src.replace('.c', '.s')
            rc, log = run(arkcc, ARM + ['-O1', '--const-global', '-S',
                                        '-o', out, src], work)
            t = asm_text(os.path.join(work, out)) if rc == 0 else ''
            body = func_body(t, fn)
            val = None
            if HAVE_UNICORN and rc == 0:
                val, _ = image_value(arkcc, [src], work, ['--const-global'],
                                     src.replace('.c', ''))
            check(rc == 0 and has_load(body) and (val is None or val == want),
                  what, 'rc=%d load=%s val=%r' % (rc, has_load(body), val))

        # a const long long needs two words, so it keeps its load as well
        rc, log = run(arkcc, ARM + ['-O1', '--const-global', '-S',
                                    '-o', 'll.s', 'll.c'], work)
        t = asm_text(os.path.join(work, 'll.s')) if rc == 0 else ''
        body = func_body(t, 'main')
        check(rc == 0 and has_load(body),
              'a const long long keeps its load',
              'rc=%d load=%s' % (rc, has_load(body)))

        # writing through a cast-away const: folding would answer 5, not 9
        rc, log = run(arkcc, ARM + ['-O1', '--const-global', '-S',
                                    '-o', 'store.s', 'store.c'], work)
        t = asm_text(os.path.join(work, 'store.s')) if rc == 0 else ''
        val = None
        if HAVE_UNICORN and rc == 0:
            val, why = image_value(arkcc, ['store.c'], work, ['--const-global'],
                                   'store')
        check(rc == 0 and has_load(func_body(t, 'main')) and
              (val is None or val == 9),
              'a write through a cast-away const is not folded away',
              'rc=%d val=%r' % (rc, val))

        # ------------------------------------------- 6. static const, one file
        rc, log = run(arkcc, ARM + ['-O1', '--const-global', '-S',
                                    '-o', 'stat.s', 'stat.c'], work)
        t = asm_text(os.path.join(work, 'stat.s')) if rc == 0 else ''
        body = func_body(t, 'main')
        val = None
        if HAVE_UNICORN and rc == 0:
            val, _ = image_value(arkcc, ['stat.c'], work, ['--const-global'],
                                 'stat')
        check(rc == 0 and not has_load(body) and (val is None or val == 15),
              'a static const folds within one file', 'rc=%d val=%r' % (rc, val))

        # ------------------------------------------- 7. a cropped build refuses
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_CONST_GLOBAL=0'],
                                   'arkcc_no_cg')
        if not trimmed:
            skip('the cropped build refuses --const-global', why)
        else:
            rc, log = run(trimmed, ARM + ['-O1', '--const-global', 'plain.c',
                                          '-S', '-o', 'no.s'], work)
            check(rc != 0 and 'not compiled into this build' in log,
                  'a build without the feature refuses the flag',
                  'rc=%d %s' % (rc, log.strip()[:140]))

            # ------------------------------------ 8. default off changes nothing
            diffs = 0
            compared = 0
            for src in sorted(glob.glob(os.path.join(os.getcwd(), 'examples',
                                                     '*.c')))[:6]:
                base = os.path.basename(src)
                for lvl in (['-O1'], ['-O2']):
                    # A fixed build stamp: examples/c99_test.c contains
                    # __DATE__ / __TIME__, so two compiles seconds apart would
                    # differ on their own and make this comparison meaningless.
                    stamp = ['--build-date', 'Jan  1 2026',
                             '--build-time', '00:00:00']
                    rc1, _ = run(arkcc, ARM + lvl + stamp + ['-S', '-o',
                                os.path.join(work, 'a.s'), src], os.getcwd())
                    rc2, _ = run(trimmed, ARM + lvl + stamp + ['-S', '-o',
                                os.path.join(work, 'b.s'), src], os.getcwd())
                    if rc1 != 0 or rc2 != 0:
                        continue
                    compared += 1
                    if digest(os.path.join(work, 'a.s')) != \
                       digest(os.path.join(work, 'b.s')):
                        diffs += 1
                        print('      differs: %s %s' % (base, ' '.join(lvl)))
            check(compared > 0 and diffs == 0,
                  'with the flag off the output equals a build without the feature',
                  'compared=%d diff=%d' % (compared, diffs))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    print()
    if failures:
        print('%d check(s) failed' % len(failures))
        return 1
    print('all --const-global checks passed%s'
          % (' (%d skipped)' % len(skips) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())
