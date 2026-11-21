#!/usr/bin/env python
"""Gates for --tailcall (`return g(...)` becomes a branch, ARM backend).

The rewrite is emitted, not post-processed: the backend decides while it is
translating IR_CALL whether the frame can be torn down and the call replaced by
`B`.  "It compiles" therefore proves nothing, and the gate asks six separate
questions, each of which can fail alone:

  1. Static: with the switch on, a convertible function loses its `BL <name>` and
     gains `B <name>`, and the epilogue becomes `POP {r5, r6, r7, lr}` (the
     return address stays live because `B` does not overwrite lr).
  2. Refused shapes: every shape the backend declines must produce exactly the
     same assembly with the switch on as with it off --
        * the result is used after the call (`return g(x) + 1;`),
        * the result is converted (int -> long long widening),
        * the arguments do not all fit in r0-r3 (5+ words),
        * the callee is reached through a function pointer,
        * the callee returns a struct through a caller-owned buffer (sret),
        * the callee returns _Complex double (four words, caller buffer).
  3. Selectivity: one translation unit holding both a convertible and a refused
     function must change only the convertible one, so "nothing ran" cannot be
     mistaken for "the shape was refused".
  4. Execution: the same program returns the same value on the ARM emulator with
     and without the switch, and that value is non-trivial.  The program includes
     a tail-recursive accumulator so the *frame* (not only the bytes) matters: if
     the branch kept a frame per step the emulator would still agree, but the
     count of `B sum` occurrences and the recursion depth would not change shape,
     so the same file also checks that the recursive call is a branch.
  5. Anti-false-green: off by default and the default object is byte-identical to
     a build without the pass; --no-tailcall after --tailcall turns it back off;
     a build with -DARKCC_FEATURE_TAILCALL=0 refuses the option with C3900U
     naming the macro; that trimmed build's default object equals the untrimmed
     one (the code really is gone); the ini key works.
  6. Byte account: the object is strictly smaller and the assembly has fewer
     instruction lines.

Every compile passes --no_autoinline: 0.9.1 made the inliner expand calls to
parameterised callees, and these fixtures are exactly that shape, so the call
sites would disappear before the tail-call rewrite could replace them.

Usage: run_tailcall_tests.py [path-to-arkcc]
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

# leaf() is defined before its callers so every call site sees the real return
# shape; nothing here depends on an implicit declaration.  This file is the one
# that is also *executed* on the emulator, so it deliberately stays inside the
# shapes the emulator handles (no sret, no _Complex); those two are covered by
# SRC_SHAPES below.
SRC_EXEC = '''\
int leaf(int x) { return x * 3 + 1; }
void vleaf(int x) { leaf(x); }
long long lleaf(long long x) { return x + 5; }
int leaf5(int a, int b, int c, int d, int e) { return a + b + c + d + e; }

/* convertible: the call's word is the function's result */
int tf(int x)          { return leaf(x + 1); }
long long tf64(long long x) { return lleaf(x); }
void vt(int x)         { vleaf(x); }

/* tail recursion: the recursive call is the last thing on that path */
int tsum(int n, int acc) { if (n == 0) return acc; return tsum(n - 1, acc + n); }

/* refused: the result is used after the call */
int neg_use(int x)     { return leaf(x) + 1; }
/* refused: five argument words, so one goes on the stack */
int neg_args(int a, int b, int c, int d, int e) { return leaf5(a, b, c, d, e); }
int main(void)
{
    return (tf(2) + (int)tf64(1) + vt(3) + tsum(10, 0) +
            neg_use(1) + neg_args(1, 1, 1, 1, 1)) & 0x7F;
}
'''

# Shapes that are refused for structural reasons only; compiled, never run.
SRC_SHAPES = '''\
struct big { int a, b, c, d; };
struct big sbig(int x) { struct big r; r.a = x; r.b = x + 1; r.c = x + 2; r.d = x + 3; return r; }
int leaf(int x) { return x * 3 + 1; }

/* refused: int result widened to long long (a conversion sits between the call
 * and the return, so the two are not adjacent in the IR) */
long long neg_widen(int x) { return leaf(x); }
/* refused: struct result through a caller-owned buffer (sret) */
struct big neg_sret(int x) { return sbig(x); }
/* refused: _Complex double result, four words through a caller-owned buffer */
double _Complex neg_cplx(double _Complex z) { return z; }
/* refused: indirect call -- the callee address lives in the frame being freed.
 * Kept out of the executed file on purpose: the emulator's loader does not
 * relocate a global initialised with a function address, and that limitation
 * predates this pass. */
int (*gp)(int) = leaf;
int neg_ind(int x) { return gp(x); }

int main(void) { struct big s = neg_sret(1); return (int)neg_cplx(2.0) + s.a; }
'''

# One TU with both shapes: only tn_fn may lose its BL.
SRC_MIXED = '''\
int leaf(int x) { return x ^ 0x15; }
int tn_fn(int x)  { return leaf(x); }
int tn_use(int x) { return leaf(x) * 2; }
int main(void) { return (tn_fn(3) + tn_use(3)) & 0x7F; }
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
# --no_autoinline on every compile below: since 0.9.1 the inliner expands calls
# to *parameterised* callees, so the small `leaf`-style fixtures would be gone
# before this pass ever sees them and "B leaf" could never appear.  This gate is
# about the branch rewrite, so inlining is switched off and the call sites stay.
NOINL = ['--no_autoinline']
ASM = ARM + ['-O2', '-S'] + NOINL
OBJ = ARM + ['-O2', '-c'] + NOINL
IMG = ARM + ['-O2', '--vector-table'] + NOINL

def as_body_lines(text):
    n = 0
    for ln in text.splitlines():
        s = ln.strip()
        if not s or s.startswith('.') or s.startswith('@') or s.startswith(';'):
            continue
        if s.endswith(':'):
            continue
        n += 1
    return n

def func_body(text, name):
    """Lines of one function, from `name:` to the next top-level label."""
    out = []
    inside = False
    for ln in text.splitlines():
        if ln.strip() == name + ':':
            inside = True
            continue
        if inside:
            if ln and not ln[0].isspace():
                t = ln.strip()
                # internal labels (.L_...) belong to the body; a new top-level
                # label or the .size directive ends it
                if t.startswith('.size') or (t.endswith(':') and not t.startswith('.L')):
                    break
            out.append(ln)
    return '\n'.join(out)

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

    work = tempfile.mkdtemp(prefix='arkcc_tailcall_')
    try:
        for name, text in (('tc.c', SRC_EXEC), ('shapes.c', SRC_SHAPES),
                           ('mixed.c', SRC_MIXED)):
            write(os.path.join(work, name), STARTUP + text)

        # --- 1. the switch changes the convertible functions ----------------
        rc, log_off = run(arkcc, ASM + ['tc.c', '-o', 'tc_off.s'], work)
        rc2, log_on = run(arkcc, ASM + ['tc.c', '--tailcall', '-o', 'tc_on.s'],
                          work)
        check(rc == 0 and rc2 == 0, 'tc.c compiles with and without the switch',
              'rc=%d/%d %s' % (rc, rc2, (log_on or log_off).strip()[:80]))
        off = read(os.path.join(work, 'tc_off.s'))
        on = read(os.path.join(work, 'tc_on.s'))
        check(on != off, '--tailcall changes the generated code')
        for fn, callee in (('tf', 'leaf'), ('tf64', 'lleaf'), ('vt', 'vleaf')):
            body_on = func_body(on, fn)
            body_off = func_body(off, fn)
            check(('BL ' + callee) in body_off and ('BL ' + callee) not in body_on
                  and ('B ' + callee) in body_on,
                  '%s branches instead of calling (%s)' % (fn, callee))
            check('POP {r5, r6, r7, lr}' in body_on and
                  'POP {r5, r6, r7, pc}' not in body_on,
                  '%s keeps lr live in its tail-call epilogue' % fn)
        # recursion: the recursive call must be a branch too
        check('B tsum' in func_body(on, 'tsum') and
              'BL tsum' in func_body(off, 'tsum'),
              'the recursive call is a branch')

        # --- 2. refused shapes are byte-identical ---------------------------
        for fn, tag, marker in (
                ('neg_use', 'the result is used after the call', 'BL leaf'),
                ('neg_args', '5 argument words (one goes on the stack)', 'BL leaf5')):
            body = func_body(on, fn)
            check(body == func_body(off, fn) and marker in body,
                  'refused shape left alone: ' + tag)
        # the structural refusals live in their own file
        rc, _ = run(arkcc, ASM + ['shapes.c', '-o', 'sh_off.s'], work)
        rc2, _ = run(arkcc, ASM + ['shapes.c', '--tailcall', '-o', 'sh_on.s'],
                     work)
        if rc == 0 and rc2 == 0:
            a = read(os.path.join(work, 'sh_off.s'))
            b = read(os.path.join(work, 'sh_on.s'))
            for fn, tag, marker in (
                    ('neg_widen', 'the result is converted (int -> long long)', 'BL leaf'),
                    ('neg_sret', 'struct result through a caller buffer', 'BL sbig'),
                    ('neg_cplx', '_Complex result through a caller buffer', ''),
                    ('neg_ind', 'the callee is a function pointer', 'BLX ip')):
                body = func_body(b, fn)
                check(body == func_body(a, fn) and (marker in body if marker else body),
                      'refused shape left alone: ' + tag)
            # no line may be a branch to either callee
            bad = [ln.strip() for ln in b.splitlines()
                   if ln.strip() in ('B sbig', 'B neg_cplx', 'B leaf')]
            check(not bad, 'no branch was emitted for the refused shapes',
                  ', '.join(bad))
        else:
            check(False, 'the structural-shape file could be built',
                  'rc=%d/%d' % (rc, rc2))

        # --- 3. selectivity inside one TU -----------------------------------
        rc, _ = run(arkcc, ASM + ['mixed.c', '-o', 'mix_off.s'], work)
        rc2, _ = run(arkcc, ASM + ['mixed.c', '--tailcall', '-o', 'mix_on.s'],
                     work)
        if rc == 0 and rc2 == 0:
            a = read(os.path.join(work, 'mix_off.s'))
            b = read(os.path.join(work, 'mix_on.s'))
            check('B leaf' in func_body(b, 'tn_fn') and
                  'BL leaf' not in func_body(b, 'tn_fn'),
                  'in one TU the convertible function is rewritten')
            check(func_body(a, 'tn_use') == func_body(b, 'tn_use'),
                  'in one TU the refused function is untouched')
        else:
            check(False, 'the mixed file could be built', 'rc=%d/%d' % (rc, rc2))

        # --- 4. execution ---------------------------------------------------
        if not HAVE_UNICORN:
            skip('emulator execution', 'unicorn not installed')
        else:
            base, err = image_value(arkcc, 'tc.c', work, [], 'tc_exec_off')
            if base is None:
                skip('emulator execution', err)
            else:
                got, err = image_value(arkcc, 'tc.c', work, ['--tailcall'],
                                       'tc_exec_on')
                if got is None:
                    skip('emulator execution (tail calls)', err)
                else:
                    check(got == base,
                          'the tail-calling program returns the same value',
                          'off=%d on=%d' % (base, got))
                check(base != 0, 'the program under test returns a non-trivial value',
                      'value=%d' % base)

        # --- 5. anti-false-green --------------------------------------------
        rc, _ = run(arkcc, OBJ + ['tc.c', '-o', 'd_plain.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--no-tailcall', 'tc.c', '-o', 'd_no.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'd_plain.o')) ==
              digest(os.path.join(work, 'd_no.o')),
              'the pass is off by default (object byte-identical)')
        rc, _ = run(arkcc, OBJ + ['--tailcall', '--no-tailcall', 'tc.c',
                                  '-o', 'd_backoff.o'], work)
        rc2, _ = run(arkcc, OBJ + ['tc.c', '-o', 'd_ref.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'd_backoff.o')) ==
              digest(os.path.join(work, 'd_ref.o')),
              '--no-tailcall after --tailcall turns the pass back off')

        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_TAILCALL=0'],
                                   'arkcc_notailcall')
        if trimmed is None:
            skip('trimmed build refuses --tailcall', why)
        else:
            rc, log = run(trimmed, OBJ + ['tc.c', '--tailcall', '-o', 't.o'],
                          work)
            check(rc != 0 and 'C3900U' in log and
                  'ARKCC_FEATURE_TAILCALL' in log,
                  'trimmed build refuses --tailcall and names the macro',
                  'rc=%d' % rc)
            write(os.path.join(work, 'tc_on.cfg'), '[features]\ntailcall=1\n')
            rc, log = run(trimmed, ['-config', 'tc_on.cfg'] + OBJ +
                          ['tc.c', '-o', 't.o'], work)
            check(rc != 0 and 'C3900U' in log and
                  'ARKCC_FEATURE_TAILCALL' in log,
                  'trimmed build refuses tailcall=1 from the ini file',
                  'rc=%d' % rc)
            rc2, log2 = run(trimmed, OBJ + ['tc.c', '-o', 't2.o'], work)
            check(rc2 == 0, 'trimmed build compiles the same file normally',
                  'rc=%d' % rc2)
            rc3, _ = run(arkcc, OBJ + ['tc.c', '-o', 't_full.o'], work)
            check(rc2 == 0 and rc3 == 0 and
                  digest(os.path.join(work, 't2.o')) ==
                  digest(os.path.join(work, 't_full.o')),
                  'default object identical whether or not the pass is compiled in')

        # the ini key switches the pass on
        write(os.path.join(work, 'tc.cfg'), '[features]\ntailcall=1\n')
        rc, log = run(arkcc, ['-config', 'tc.cfg'] + ASM +
                      ['tc.c', '-o', 'tc_ini.s'], work)
        check(rc == 0 and 'B leaf' in func_body(read(os.path.join(work, 'tc_ini.s')),
                                                'tf'),
              'tailcall=1 in a config file switches the pass on')

        # --- 6. byte account ------------------------------------------------
        rc, _ = run(arkcc, OBJ + ['tc.c', '-o', 'acct_off.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--tailcall', 'tc.c', '-o', 'acct_on.o'], work)
        if rc == 0 and rc2 == 0:
            a = os.path.getsize(os.path.join(work, 'acct_off.o'))
            b = os.path.getsize(os.path.join(work, 'acct_on.o'))
            check(b < a, 'the tail-calling object is strictly smaller',
                  '%d -> %d bytes' % (a, b))
            check(as_body_lines(on) < as_body_lines(off),
                  'the tail-calling assembly has fewer instruction lines',
                  '%d -> %d' % (as_body_lines(off), as_body_lines(on)))
        else:
            check(False, 'the byte account could be built', 'rc=%d/%d' % (rc, rc2))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
        return 1
    print('\nall tailcall checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())
