#!/usr/bin/env python3
"""Gate for the copy-propagation pass (0.9.1, -fopt-copyprop).

This is the IAR "ECT" family (c_compiler/iar/docs/08-backend-passes.md:
`ECT CopyPropagation candidate`, `DefIntoMove`, `Dead MOV`) reduced to the two
rules that can be proved without liveness analysis:

  A  `MOV rD, X` whose rD is completely overwritten before anything reads it,
     inside one straight-line block, is dead.  Nothing about the value or the
     flags can change, because MOV writes no flags.

  B  `MOV rD, rS` followed by `OP rD, rD, X` becomes `OP rD, rS, X`.  The
     surviving instruction reads exactly the values the pair did, and it keeps
     its own suffix, so the flags are unchanged too.

Each claim is checked on its own, and each fails on a plausible wrong
implementation:

  1. OFF IS OFF.  Default build and `-fno-opt-copyprop` are byte-identical.
  2. RULE A FIRES.  Four `__dsb(0xF)/__isb(0xF)` barriers materialise an
     argument nobody reads: `MOV r0, #15` before each.  All four disappear,
     the barrier instructions do not, and the answer does not change.
  3. RULE B FIRES.  Two `MOV rD, rS` + `ADD rD, rD, X` pairs collapse into one
     `ADD rD, rS, X` each, so both the register-copy count and the instruction
     count drop by exactly two.
  4. NOTHING ELSE IS TOUCHED.  A fixture full of register copies that are all
     read (a pointer retargeted then indexed) must come out byte-identical --
     this is the anti-over-deletion half; without it a pass that deleted every
     copy would still pass checks 2 and 3.
  5. THE ANSWER IS THE SAME.  Three fixtures, three arms (off / on / on alone,
     no other pass), values checked on the emulator against Python.
  6. LABELS SURVIVE.  The pass rewrites lines, never labels.
  7. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_COPYPROP=0 refuses
     `-fopt-copyprop` by name (C3900U) and still compiles without the flag.

Usage: run_copyprop_tests.py [path-to-arkcc]
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

FLAG = '-fopt-copyprop'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']

# The 0.9.1 pass set.  -fopt-vstack is what puts a value in the pool register,
# which is the shape rule B folds (MOV r0, r5 + ADD r0, r0, r7).
BASE = ['-fopt-vstack', '-fopt-addr', '-fopt-strength', '-fopt-cbz',
        '-fopt-branch', '-fopt-imm', '-fopt-peep', '-fopt-cbranch']

# Rule A: the barrier builtins take an argument the instruction never reads.
BARRIER = """\
#define __DSB() __dsb(0xF)
#define __ISB() __isb(0xF)
int cp_bar_v = 11;
int f(void)
{
    __DSB();
    __ISB();
    __DSB();
    __ISB();
    return cp_bar_v;
}
int main(void) { return f(); }
"""

# Rule B: `t = t + g` loads t into the pool register and g into the other, so
# the pair arrives as MOV r0, r5 / ADD r0, r0, r7.
FUSE = """\
int cp_fuse_g = 5; int cp_fuse_h = 7;
int fuse(int a,int b){ int t=a; t=b; t=t+cp_fuse_g; return t+cp_fuse_h; }
int main(void){ return fuse(3,8); }
"""

# Control: copies that are all read (the pointer is retargeted and then used).
KEEP = """\
int cp_keep_a[8];
int cp_keep_b[8] = {1, 2, 9};
static int keep(int i)
{
    int *p = cp_keep_a;
    p = cp_keep_b;
    return p[i] * 2;
}
int main(void) { return keep(2); }
"""

def py_barrier():
    return 11

def py_fuse():
    t = 3
    t = 8
    t = t + 5
    return t + 7

def py_keep():
    return 9 * 2

CASES = [
    ('bar', BARRIER, py_barrier()),
    ('fuse', FUSE, py_fuse()),
    ('keep', KEEP, py_keep()),
]

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
build_arkcc = V.build_arkcc

MOVIMM_RE = re.compile(r'^\s+MOV\s+r\d+,\s*#')
MOVRR_RE = re.compile(r'^\s+MOV\s+r\d+,\s*r\d+\s*$')
BARRIER_RE = re.compile(r'^\s+(DSB|ISB|DMB)\s')

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

    work = tempfile.mkdtemp(prefix='arkcc_copyprop_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        t_a, b_a, e1 = build(arkcc, work, 'fuse', BASE, 'plain')
        t_b, b_b, e2 = build(arkcc, work, 'fuse',
                             BASE + ['-fno-opt-copyprop'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(t_a == t_b and b_a == b_b,
                  'the default build ignores the pass (-O2 == -O2 -fno-opt-copyprop)',
                  '%d/%d bytes' % (len(b_a), len(b_b)))

        # --- 2. rule A ------------------------------------------------------
        ta_off, ba_off, e3 = build(arkcc, work, 'bar', BASE, 'aoff')
        ta_on, ba_on, e4 = build(arkcc, work, 'bar', BASE + [FLAG], 'aon')
        if e3 or e4:
            check(False, 'bar: both arms build', (e3 or e4)[0][:120])
        else:
            i_off, i_on = count(MOVIMM_RE, ta_off), count(MOVIMM_RE, ta_on)
            # Four `MOV r0, #15` inside f(); the count is not absolute because
            # main also materialises a return value, so compare the delta.
            check(i_off - i_on == 4,
                  'bar: the four dead barrier arguments are gone',
                  'MOV #imm %d -> %d (delta %d, want 4)'
                  % (i_off, i_on, i_off - i_on))
            check(count(BARRIER_RE, ta_on) == count(BARRIER_RE, ta_off) == 4,
                  'bar: the barriers themselves are kept',
                  '%d -> %d' % (count(BARRIER_RE, ta_off),
                                count(BARRIER_RE, ta_on)))
            check(insn_count(ta_off) - insn_count(ta_on) == 4,
                  'bar: exactly the four copies drop out',
                  '%d -> %d' % (insn_count(ta_off), insn_count(ta_on)))
            check(len(ba_on) < len(ba_off), 'bar: the image shrinks',
                  '%d -> %d bytes' % (len(ba_off), len(ba_on)))
            check(label_count(ta_on) == label_count(ta_off),
                  'bar: labels are untouched',
                  '%d/%d label(s)' % (label_count(ta_off), label_count(ta_on)))

        # --- 3. rule B ------------------------------------------------------
        tb_off, bb_off, e5 = build(arkcc, work, 'fuse', BASE, 'boff')
        tb_on, bb_on, e6 = build(arkcc, work, 'fuse', BASE + [FLAG], 'bon')
        if e5 or e6:
            check(False, 'fuse: both arms build', (e5 or e6)[0][:120])
        else:
            m_off, m_on = count(MOVRR_RE, tb_off), count(MOVRR_RE, tb_on)
            check(m_off - m_on == 2,
                  'fuse: both pool copies are folded into their consumer',
                  'MOV rX, rY %d -> %d' % (m_off, m_on))
            check(insn_count(tb_off) - insn_count(tb_on) == 2,
                  'fuse: exactly two instructions drop out',
                  '%d -> %d' % (insn_count(tb_off), insn_count(tb_on)))
            check(len(bb_on) <= len(bb_off), 'fuse: the image never grows',
                  '%d -> %d bytes' % (len(bb_off), len(bb_on)))
            check(count(MOVIMM_RE, tb_on) == count(MOVIMM_RE, tb_off),
                  'fuse: no immediate copy was touched here',
                  '%d/%d' % (count(MOVIMM_RE, tb_off),
                             count(MOVIMM_RE, tb_on)))

        # --- 4. nothing else is touched -------------------------------------
        tk_off, _, e7 = build(arkcc, work, 'keep', BASE, 'koff')
        tk_on, _, e8 = build(arkcc, work, 'keep', BASE + [FLAG], 'kon')
        if e7 or e8:
            check(False, 'keep: both arms build', (e7 or e8)[0][:120])
        else:
            check(count(MOVRR_RE, tk_off) > 0,
                  'keep: the control fixture really contains register copies',
                  '%d MOV rX, rY' % count(MOVRR_RE, tk_off))
            check(tk_off == tk_on,
                  'keep: copies that are all read are left alone',
                  '%d/%d line(s)' % (len(tk_off.splitlines()),
                                     len(tk_on.splitlines())))

        # --- 5. the answers stay the same -----------------------------------
        for name, _body, want in CASES:
            arms = {}
            ok = True
            for tag, flags in (('off', BASE), ('on', BASE + [FLAG]),
                               ('alone', [FLAG])):
                t, blob, err = build(arkcc, work, name, flags, 'v' + tag)
                if err:
                    check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
                    ok = False
                    break
                arms[tag] = (t, blob)
            if not ok:
                continue
            if not V.HAVE_UNICORN:
                skip('%s: emulator value' % name, 'python package unicorn missing')
                continue
            got = {}
            for tag in ('off', 'on', 'alone'):
                st, val, _ = V.run_image(arms[tag][1])
                got[tag] = val if st == 'returned' else st
            check(all(got[t] == want for t in got),
                  '%s: off/on/alone return the Python answer' % name,
                  ' '.join('%s=%s' % (t, got[t]) for t in ('off', 'on', 'alone'))
                  + ' want=%s' % want)

        # --- 7. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_COPYPROP=0'],
                                   'arkcc_nocopyprop')
        if trimmed is None:
            skip('a cropped build refuses -fopt-copyprop', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'fuse.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-copyprop by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'fuse.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\ncopyprop: %d check(s) FAILED%s' % (
            len(V.failures), (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\ncopyprop: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
