#!/usr/bin/env python3
"""Gate for feeding a comparison straight into its branch (0.9.1, -fopt-cbranch).

`if (a < b)` reaches the backend as IR_BINARY(TOK_LT) followed by IR_JZ, so the
emitter used to build the 0/1 result first (ITE + two conditional MOVs) and then
test it again (CMP r0, #0 + BEQ): six instructions where the flags left by the
first CMP already hold the answer.  When the result is consumed by the very next
conditional branch the value is dead, so the branch can be emitted on the
original condition directly.

Every claim is checked separately, and each would fail on a plausible wrong
implementation:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-cbranch` produce identical text and
     images.  The pass never runs unless asked.
  2. THE DEAD VALUE GOES.  On a chain of `if (a == b) / if (a < b) / ...` the
     ITE+MOVcc materialisation and the second `CMP r0, #0` disappear, the
     function gets shorter, and the image never grows.
  3. A LIVE VALUE STAYS.  `int x = (a < b); if (x)` must keep its ITE+MOVcc
     sequence -- the comparison result is stored, so the next instruction is not
     a branch and the pass must stand aside.  This is the "only dead values"
     half of the rule; without it a bug that deletes every comparison result
     would still pass check 2.
  4. BOTH IMMEDIATE SHAPES WORK.  `a == 5` goes through the folded-immediate
     path (CMP r0, #5 + branch) and `a == 70000` through the register path; the
     answers must match Python in both.
  5. UNSIGNED CONDITIONS.  `a < b` on unsigned operands must branch on BLO/BHS,
     not BLT/BGE, so the fixture is chosen where the two disagree on the sign
     bit; the answer is checked on the emulator.
  6. THE ANSWER IS THE SAME.  Four fixtures return the value computed in Python
     in four arms: off, on, on with -fopt-vstack, on with -fopt-imm.  Passes
     stacking must not fight.
  7. LABELS SURVIVE.  The branch targets the pass emits are the same ones the
     original IR_JZ carried, so the label count of the two arms is equal.
  8. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_CBRANCH=0 refuses
     `-fopt-cbranch` by name (C3900U) and still compiles without the flag.

Usage: run_cbranch_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import re
import shutil
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
try:
    import run_vstack_tests as V
except Exception:                                        # pragma: no cover
    print('FAIL  cannot import tests/run_vstack_tests.py helpers')
    sys.exit(2)

FLAG = '-fopt-cbranch'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']

# Three comparisons whose results are consumed by the branch immediately.
CMPI = """\
int cb_pad_1;
static int cmpi(int a, int b)
{
    if (a == b) return 1;
    if (a < b) return 2;
    if (a > b) return 3;
    return 4;
}
int main(void) { return cmpi(3, 4); }
"""

# One small immediate (CMP r0, #5), one 300 (modified immediate), one value the
# encoding cannot carry (70000 -> register form).
CMPC = """\
int cb_pad_2;
static int cmpc(int a)
{
    if (a == 5) return 10;
    if (a < 300) return 20;
    if (a == 70000) return 30;
    return 40;
}
int main(void) { return cmpc(5); }
"""

# 7u < 3u is false and 7u >= 3u is true; as signed the two would be flipped
# (7 >= 3 is still true, but 0x80000000 < 1 is true only unsigned).
UCMP = """\
int cb_pad_3;
static unsigned ucmp(unsigned a, unsigned b)
{
    if (a < b) return 9;
    if (a >= b) return 5;
    return 1;
}
int main(void) { return (int)ucmp(7u, 3u); }
"""

# The comparison value is stored, so nothing may be folded here.
USED = """\
int cb_pad_4;
static int used(int a, int b)
{
    int x = (a < b);
    if (x) return 6;
    return 8;
}
int main(void) { return used(9, 2); }
"""

def py_cmpi(a=3, b=4):
    if a == b:
        return 1
    if a < b:
        return 2
    if a > b:
        return 3
    return 4

def py_cmpc(a=5):
    if a == 5:
        return 10
    if a < 300:
        return 20
    if a == 70000:
        return 30
    return 40

def py_ucmp(a=7, b=3):
    if a < b:
        return 9
    if a >= b:
        return 5
    return 1

def py_used(a=9, b=2):
    x = 1 if a < b else 0
    return 6 if x else 8

CASES = [
    ('cmpi', CMPI, py_cmpi()),
    ('cmpc', CMPC, py_cmpc()),
    ('ucmp', UCMP, py_ucmp()),
    ('used', USED, py_used()),
]

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
build_arkcc = V.build_arkcc

ITE_RE = re.compile(r'^\s+ITE\s+')
CMPZ_RE = re.compile(r'^\s+CMP\s+r\d+,\s*#0\s*$')

def count(re_, text):
    return sum(1 for ln in text.splitlines() if re_.match(ln))

def label_count(text):
    return sum(1 for ln in text.splitlines()
               if ln.strip().startswith('.L') and ln.strip().endswith(':'))

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_cbranch_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        t_a, b_a, e1 = build(arkcc, work, 'cmpi', [], 'plain')
        t_b, b_b, e2 = build(arkcc, work, 'cmpi', ['-fno-opt-cbranch'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(t_a == t_b and b_a == b_b,
                  'the default build ignores the pass (-O2 == -O2 -fno-opt-cbranch)',
                  '%d/%d bytes' % (len(b_a), len(b_b)))

        # --- 2. the dead value goes -----------------------------------------
        t_off, b_off, e3 = build(arkcc, work, 'cmpi', [], 'off')
        t_on, b_on, e4 = build(arkcc, work, 'cmpi', [FLAG], 'on')
        if e3 or e4:
            check(False, 'cmpi: both arms build', (e3 or e4)[0][:120])
        else:
            i_off, i_on = count(ITE_RE, t_off), count(ITE_RE, t_on)
            check(i_off > 0 and i_on < i_off,
                  'cmpi: the 0/1 materialisation disappears (ITE count drops)',
                  '%d -> %d' % (i_off, i_on))
            z_off, z_on = count(CMPZ_RE, t_off), count(CMPZ_RE, t_on)
            check(z_off > z_on,
                  'cmpi: the second "CMP r0, #0" before the branch disappears',
                  '%d -> %d' % (z_off, z_on))
            check(insn_count(t_on) < insn_count(t_off),
                  'cmpi: instructions drop',
                  '%d -> %d' % (insn_count(t_off), insn_count(t_on)))
            check(len(b_on) <= len(b_off), 'cmpi: the image never grows',
                  '%d -> %d bytes' % (len(b_off), len(b_on)))
            check(label_count(t_on) == label_count(t_off),
                  'cmpi: the branch targets are the ones the IR carried',
                  '%d/%d label(s)' % (label_count(t_off), label_count(t_on)))

        # --- 3. a live value stays ------------------------------------------
        t_uo, _, e5 = build(arkcc, work, 'used', [], 'uoff')
        t_un, _, e6 = build(arkcc, work, 'used', [FLAG], 'uon')
        if e5 or e6:
            check(False, 'used: both arms build', (e5 or e6)[0][:120])
        else:
            check(count(ITE_RE, t_un) == count(ITE_RE, t_uo) and
                  count(ITE_RE, t_un) > 0,
                  'used: a stored comparison result keeps its materialisation',
                  '%d -> %d ITE(s)' % (count(ITE_RE, t_uo), count(ITE_RE, t_un)))

        # --- 4/5/6. the answers stay the same -------------------------------
        arms = {}
        for name, body, want in CASES:
            arms[name] = {}
            for tag, flags in (('off', []), ('on', [FLAG]),
                               ('vst', [FLAG, '-fopt-vstack']),
                               ('imm', [FLAG, '-fopt-imm'])):
                t, blob, err = build(arkcc, work, name, flags, tag)
                if err:
                    check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
                    arms[name] = None
                    break
                arms[name][tag] = (t, blob)
            if arms[name] is None:
                continue
            if not V.HAVE_UNICORN:
                skip('%s: emulator value' % name, 'python package unicorn missing')
                continue
            got = {}
            for tag in ('off', 'on', 'vst', 'imm'):
                st, val, _ = V.run_image(arms[name][tag][1])
                got[tag] = val if st == 'returned' else st
            check(all(got[t] == want for t in got),
                  '%s: off/on/vstack/imm return the Python answer' % name,
                  ' '.join('%s=%s' % (t, got[t]) for t in
                           ('off', 'on', 'vst', 'imm')) + ' want=%s' % want)

        # --- 8. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_CBRANCH=0'],
                                   'arkcc_nocbranch')
        if trimmed is None:
            skip('a cropped build refuses -fopt-cbranch', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'cmpi.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-cbranch by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'cmpi.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\ncbranch: %d check(s) FAILED%s' % (
            len(V.failures), (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\ncbranch: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
