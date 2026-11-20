#!/usr/bin/env python
"""Gate for a function-local string literal initialiser on a freestanding target.

What the bug was
----------------
`char a[] = "hello";` inside a function, and a string literal filling a char
array *member* of a block-scope aggregate, were lowered to a real call:

    irgen: IR_PUSH_INT n; IR_PUSH_STR; IR_PUSH_ADDR; IR_CALL 3, "memcpy"

A call, not `IR_MEMCPY`.  On the host that linked against libc, so every
existing gate passed; on a freestanding target it is an undefined symbol.  The
ARM backend emits its own `__aeabi_memcpy` for `IR_MEMCPY` precisely so struct
copies need no libc, but `BL memcpy` goes around that and stays unresolved --
measured: the three programs below failed to link with
`unresolved symbol "memcpy"` until the two irgen sites were changed to
`IR_MEMCPY`.

What this gate checks
---------------------
  1. every program links with **no runtime object at all** (one TU, nothing
     else on the link line) and answers the number it computed, on the
     emulator;
  2. the ARM assembly carries no `BL memcpy` (it may carry `__aeabi_memcpy`,
     which the backend emits itself);
  3. the riscv32 assembly carries no call to `memcpy` either (that backend
     inlines the copy);
  4. resolution: a program that *does* declare and call `memcpy` must still
     fail to link with "unresolved symbol" -- that is what makes (1) mean
     "there is no libc here", instead of "the linker found one".

Usage: run_str_init_tests.py [--arkcc path]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
import argparse
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
try:
    from run_arm_exec import run_image
    HAVE_UNICORN = True
except Exception:                                       # pragma: no cover
    HAVE_UNICORN = False

STARTUP = '''\
void __arkcc_init_globals(void) {}
int main(void);
int Reset_Handler(void) { return main(); }
'''

# --- the three shapes ---------------------------------------------------
SIMPLE = STARTUP + '''\
int main(void)
{
    char a[] = "hello";
    char b[8] = "hey";
    int i, s = 0;
    for (i = 0; a[i]; i++) s += a[i];
    if (!(a[5] == 0 && b[0] == 'h' && b[3] == 0 && b[7] == 0)) return 0;
    return s & 0x7f;              /* "hello" = 532, low 7 bits = 20 */
}
'''

MEMBER = STARTUP + '''\
struct Q { int x; char s[6]; int y; };
int main(void)
{
    struct Q q = { 3, "abcd", 5 };
    if (!(q.x == 3 && q.s[0] == 'a' && q.s[3] == 'd' && q.s[4] == 0)) return 0;
    return q.y * 2;                      /* 10 */
}
'''

ELIDED = STARTUP + '''\
struct E { char s[4]; int k; };
int main(void)
{
    struct E e[2] = { "ab", 1, "cd", 2 };
    if (!(e[0].s[0] == 'a' && e[0].s[2] == 0 && e[1].k == 2)) return 0;
    return e[0].k + e[1].s[1];           /* 1 + 'd' = 101 */
}
'''

# --- resolution control: a real libc call must still be unresolved ------
REAL_CALL = STARTUP + '''\
void *memcpy(void *d, const void *s, unsigned n);
int main(void)
{
    char a[4] = "abc";
    char b[4];
    memcpy(b, a, 4);
    return b[0];
}
'''


def run(cmd):
    return subprocess.run(cmd, capture_output=True, text=True)


def build(arkcc, src, tmp, name, target, extra_flags):
    c = os.path.join(tmp, name + '.c')
    open(c, 'w').write(src)
    obj = os.path.join(tmp, name + '.obj')
    img = os.path.join(tmp, name + '.bin')
    r = run([arkcc, c, '-target', target, '-c'] + extra_flags +
            ['-o', obj, '-I', os.path.join(ROOT, 'stdlib', 'include')])
    if r.returncode:
        return None, None, 'compile failed: %s' % (r.stdout + r.stderr)[:300]
    r = run([arkcc, '-link', obj] + extra_flags + ['-o', img])
    if r.returncode:
        return None, None, 'link failed: %s' % (r.stdout + r.stderr)[:300]
    return img, obj, None


def asm(arkcc, src, tmp, name, target, extra_flags):
    c = os.path.join(tmp, name + '.c')
    open(c, 'w').write(src)
    s = os.path.join(tmp, name + '.s')
    r = run([arkcc, c, '-target', target, '-S'] + extra_flags +
            ['-o', s, '-I', os.path.join(ROOT, 'stdlib', 'include')])
    if r.returncode:
        return None, 'assembly failed: %s' % (r.stdout + r.stderr)[:300]
    return open(s, 'r', errors='replace').read(), None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()
    arkcc = os.path.abspath(args.arkcc)
    if not os.path.exists(arkcc):
        print('setup: no compiler at %s' % arkcc)
        return 2
    if not HAVE_UNICORN:
        print('setup: run_arm_exec (unicorn) unavailable')
        return 2

    checks = 0
    fails = 0

    def check(ok, what, detail=''):
        nonlocal checks, fails
        checks += 1
        if not ok:
            fails += 1
        print('%s  %s%s' % ('PASS' if ok else 'FAIL', what,
                            ('  [' + detail + ']') if detail else ''))

    tmp = tempfile.mkdtemp(prefix='arkcc_strinit_')
    arm_flags = ['--vector-table', '-mcpu', 'cortex-m0']
    try:
        # 1. link + run, no runtime object on the link line
        for name, src, want in (('simple', SIMPLE, 20),
                                ('member', MEMBER, 10),
                                ('elided', ELIDED, 101)):
            img, obj, err = build(arkcc, src, tmp, name, 'arm', arm_flags)
            if err:
                check(False, '%s: links with no runtime object' % name, err)
                continue
            check(True, '%s: links with no runtime object' % name)
            st, val, det = run_image(open(img, 'rb').read(), 40000000)
            check(st == 'returned' and val == want,
                  '%s: answers %d on the ARM emulator' % (name, want),
                  'state=%s val=%s %s' % (st, val, det))

        # 2. no `BL memcpy` in the ARM assembly
        for name, src in (('simple', SIMPLE), ('member', MEMBER),
                          ('elided', ELIDED)):
            text, err = asm(arkcc, src, tmp, name, 'arm', arm_flags)
            if err:
                check(False, '%s: ARM assembly generated' % name, err)
                continue
            bad = [l for l in text.splitlines()
                   if l.strip().startswith('BL memcpy')]
            check(not bad, '%s: ARM assembly makes no libc memcpy call' % name,
                  '; '.join(bad[:2]))

        # 3. riscv32 assembly carries no memcpy call
        text, err = asm(arkcc, SIMPLE, tmp, 'simple_rv', 'riscv32', [])
        check(err is None and 'memcpy' not in text,
              'riscv32 assembly carries no memcpy call',
              err or '')
        # 4. resolution: an explicit libc call must still be unresolved
        img, obj, err = build(arkcc, REAL_CALL, tmp, 'realcall', 'arm',
                              arm_flags)
        check(err is not None and 'memcpy' in err,
              'an explicit memcpy call is still an unresolved symbol',
              (err or 'linked unexpectedly')[:160])

        # 5. anti-false-green: the detector used in (2) must have a positive
        #    sample.  REAL_CALL really does emit `BL memcpy`, so if check (2)
        #    ever finds nothing because the pattern went stale, this one goes
        #    red instead of the gate silently passing everything.
        text, err = asm(arkcc, REAL_CALL, tmp, 'realcall', 'arm', arm_flags)
        planted = [l for l in (text or '').splitlines()
                   if l.strip().startswith('BL memcpy')]
        ok = (err is None and bool(planted))
        check(ok, 'detector self-check: a planted libc call is visible in the asm',
              '' if ok else (err or 'no BL memcpy line found'))
    finally:
        for f in os.listdir(tmp):
            try:
                os.remove(os.path.join(tmp, f))
            except OSError:
                pass
        try:
            os.rmdir(tmp)
        except OSError:
            pass

    print('\n%d check(s), %d failed' % (checks, fails))
    return 1 if fails else 0


if __name__ == '__main__':
    sys.exit(main())
