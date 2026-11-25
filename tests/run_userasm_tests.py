#!/usr/bin/env python3
"""Gate for the user-assembly exemption of the post-emission text passes.

The text passes work on the assembly text, and `__asm` is emitted as plain
text (`"    " + template`), so a pass cannot tell a user line from one it
emitted itself.  Measured before the fix: `-fopt-live` and `-fopt-cmat`
silently deleted `__asm volatile("MOV r4, #11")` (docs/EXPR_MODEL.md S15.6),
and other passes could just as easily rename registers inside user code.

The fix is a per-function exemption: a function whose body contains any
`__asm` is skipped by the whole text pipeline (`ark_fix_far_offset` still
runs -- it only widens what is already there).  This gate pins that:

  1. THE USER TEXT SURVIVES EVERY FLAG.  Each pass flag, applied on its own,
     leaves the assembly-bearing function byte-identical to the no-flag
     build -- that is exactly what "the passes may not touch it" means.
  2. ALL FLAGS AT ONCE DO THE SAME, and the image still runs.
  3. THE EXEMPTION IS PER FUNCTION.  A second function in the same file that
     has no assembly still gets shorter with the flags on.
  4. IT IS NOT A NO-OP ON THE CORPUS: the flags really are enabled in this
     build (checked through the shrinking function of check 3).

Usage: run_userasm_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
try:
    from run_arm_exec import STARTUP, run_image, HAVE_UNICORN
except Exception:                                        # pragma: no cover
    STARTUP, run_image, HAVE_UNICORN = '', None, False

INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# Every text pass that ships in the 0.9.1 line.  `-fopt-live` and
# `-fopt-cmat` are the two that were measured swallowing user lines; the
# rest are here because the exemption is not supposed to be a list.
PASSES = ['-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
          '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
          '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop', '-fopt-slotreg',
          '-fopt-strength', '-fopt-vstack', '-fopt-vreg', '-fopt-cmat',
          '-fopt-pair', '-fopt-litpool', '-fopt-frame', '-fopt-voldmb',
          '-fopt-constcond', '-fopt-boolmat', '-fopt-exit', '-fopt-bitmask',
          '-fopt-spill', '-fopt-ldhoist', '-fopt-stackframe', '-fopt-deadins']

USER_LINES = ['MOVS r1, #9', 'MOVW r0, #0', 'MOVT r0, #8192',
              'STR r1, [r0, #32]']

FIXTURE = r'''
/* One initialised global: the single-file image build only emits the
 * .data/.bss init body (which --vector-table's Reset_Handler calls) when
 * the translation unit has something to initialise. */
unsigned ua_dummy_init = 1;

/* The user assembly writes 9 to 0x20000020; main reads it back, so a pass
 * that deletes or rewrites any of these four lines changes the answer. */
unsigned ua_asm(void)
{
    __asm volatile("    MOVS r1, #9");
    __asm volatile("    MOVW r0, #0");
    __asm volatile("    MOVT r0, #8192");
    __asm volatile("    STR r1, [r0, #32]");
    return 0u;
}

/* No assembly: this one must still be optimised. */
unsigned ua_plain(unsigned x)
{
    unsigned a = x * 3u;
    unsigned b = a + x;
    unsigned c = b - 1u;
    return c + 0u;
}

int main(void)
{
    ua_asm();
    return (int)(*(volatile unsigned *)0x20000020u);
}
'''

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


def write(path, text):
    with open(path, 'w', newline='\n', encoding='utf-8') as fh:
        fh.write(STARTUP + text)


def run(argv, cwd):
    p = subprocess.run(argv, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


def build(arkcc, work, flags, tag, image=False):
    src = os.path.join(work, 'ua.c')
    out = os.path.join(work, 'ua_%s.%s' % (tag, 'bin' if image else 's'))
    head = IMG_ARM if image else ASM_ARM
    rc, log = run([arkcc] + head + ['-O2', '-I', INC, src, '-o', out]
                  + list(flags), work)
    if rc != 0:
        return None, log.strip().splitlines()[:1] or ['build failed']
    with open(out, 'rb') as fh:
        blob = fh.read()
    return (blob, None) if image else (blob.decode('utf-8', 'replace'), None)


INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')


def func_text(text, name):
    m = re.search(r'^%s:\n(.*?)^\.size %s,' % (re.escape(name), re.escape(name)),
                  text, re.M | re.S)
    return m.group(1) if m else ''


def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))


def main():
    global INC
    if not os.path.isdir(INC):
        INC = os.path.join(os.getcwd(), 'stdlib', 'include')

    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_ua_')
    try:
        write(os.path.join(work, 'ua.c'), FIXTURE)

        # --- 1. the baseline: the user text is there at all ----------------
        base, err = build(arkcc, work, [], 'none')
        if err:
            check(False, 'the no-flag build compiles the fixture', err[0][:120])
            return 1
        body0 = func_text(base, 'ua_asm')
        missing = [ln for ln in USER_LINES if ln not in body0]
        if not check(bool(body0) and not missing,
                     'the no-flag build emits every user assembly line',
                     'missing: ' + (', '.join(missing) or 'none')):
            return 1

        # --- 2. each flag on its own leaves the function untouched ---------
        bad = []
        for flag in PASSES:
            text, err = build(arkcc, work, [flag], flag.lstrip('-'))
            if err:
                bad.append('%s (build failed: %s)' % (flag, err[0][:60]))
                continue
            if func_text(text, 'ua_asm') != body0:
                bad.append(flag)
        check(not bad,
              'every pass flag leaves the assembly function byte-identical',
              '%d/%d clean%s' % (len(PASSES) - len(bad), len(PASSES),
                                 '' if not bad else ': ' + ', '.join(bad[:4])))

        # --- 3. all of them at once, and the image still runs --------------
        on, err = build(arkcc, work, PASSES, 'all')
        onb, err2 = build(arkcc, work, PASSES, 'all', image=True)
        offb, err3 = build(arkcc, work, [], 'none', image=True)
        if err or err2 or err3:
            check(False, 'the all-flags build compiles the fixture',
                  (err or err2 or err3)[0][:120])
            return 1
        check(func_text(on, 'ua_asm') == body0,
              'all pass flags together leave the assembly function untouched',
              '%d/%d bytes' % (len(func_text(on, 'ua_asm')), len(body0)))

        p0 = func_text(base, 'ua_plain')
        p1 = func_text(on, 'ua_plain')
        check(bool(p0) and bool(p1) and insn_count(p1) < insn_count(p0),
              'a function without assembly in the same file is still optimised',
              'ua_plain %d -> %d insns' % (insn_count(p0), insn_count(p1)))

        if not HAVE_UNICORN:
            skip('the image returns 9', 'python package unicorn missing')
        else:
            got = {}
            ok = True
            for tag, blob in (('off', offb), ('on', onb)):
                st, val, _ = run_image(blob)
                if st != 'returned':
                    check(False, '%s arm returns' % tag, st)
                    ok = False
                    break
                got[tag] = val
            if ok:
                check(all(v == 9 for v in got.values()),
                      'both arms return 9, the value the user assembly writes '
                      '(off=9 on=9)', ' '.join('%s=%s' % (k, got[k])
                                               for k in ('off', 'on')))

        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    sys.exit(main())
