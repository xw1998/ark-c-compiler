#!/usr/bin/env python3
"""Gate for taking a pair of value-stack pushes together (-fopt-pair, 0.9.1).

The IR is a stack machine, so `a & b` arrives as

    PUSH {r0}          ; left value
    PUSH {r0}          ; right value
    POP {r1}
    POP {r0}
    AND r0, r1

Two pushes and two pops that only exist to stage two operands for one operator
become two loads straight into r0/r1 and the operator -- four instructions
where there were eight, no memory traffic at all.

The pass is off by default and must never grow code, so every claim is checked
on its own:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-pair` produce identical text and
     images, and the default text still carries the staged pushes.
  2. PAIR ENGAGES.  On `a & b` the two push/pop pairs and their register
     shuffling disappear, the function gets shorter, the image never grows and
     the label set is untouched.
  3. IMM STANDS DOWN.  `a + 4` is a folded immediate (`ADD r0, r0, #4`), which
     is one instruction cheaper than a register form; the pair pass must keep
     its hands off, with and without `-fopt-imm`.
  4. CBRANCH STANDS DOWN.  A comparison whose consumer is the very next branch
     belongs to `-fopt-cbranch` (CMP+Bcc instead of materialise-and-test); with
     that pass on, `if (a < b)` must come out byte-identical whether the pair
     pass is on or off.  Without `-fopt-cbranch` the pair pass does handle the
     same comparison, which shows the stand-down is the rule and not a refusal
     to look at comparisons at all.
  5. REFUSALS HOLD.  Shapes the pass may not model -- a 64-bit bitwise and and
     a volatile local read -- are byte-identical in both arms.
  6. THE ANSWER IS THE SAME.  Every fixture is executed under unicorn and must
     return the value computed here in Python.
  7. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_PAIR=0 refuses
     `-fopt-pair` by name (C3900U) and still compiles without the flag.

Usage: run_pair_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import sys
import tempfile
import shutil

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
try:
    import run_vstack_tests as V
except Exception:                                        # pragma: no cover
    print('FAIL  cannot import tests/run_vstack_tests.py helpers')
    sys.exit(2)

FLAG = '-fopt-pair'
DEFINE = '-DARKCC_FEATURE_OPT_PAIR=0'
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
INC = os.path.join(ROOT, 'stdlib', 'include')

# The one shape the pass exists for: a non-commutative-friendly binary operator
# with two plain stack operands.  Nothing else may claim it first.
AND2 = """\
int pair_pad_1;
static int and2(int a, int b)
{
    return a & b;
}
int main(void) { return and2(6, 3); }
"""

# A constant second operand is the folded-immediate case; the pair pass must
# let it stand down even though it could have handled the two pushes.
ADDI = """\
int pair_pad_2;
static int addi(int a)
{
    return a + 4;
}
int main(void) { return addi(3); }
"""

# A comparison consumed by the next branch belongs to -fopt-cbranch.
LT = """\
int pair_pad_3;
static int lt(int a, int b)
{
    if (a < b) return 1;
    return 0;
}
int main(void) { return lt(3, 4); }
"""

# 64-bit values live in register pairs, not in one stack word: refuse.
LLAND = """\
int pair_pad_4;
static long long lland(long long a, long long b)
{
    return a & b;
}
int main(void) { return (int)lland(6LL, 3LL); }
"""

# A volatile read is an observation, not a value the pass may re-schedule.
VOL = """\
int pair_pad_5;
static int vol(int b)
{
    volatile int x;
    x = 5;
    return x & b;
}
int main(void) { return vol(3); }
"""

CASES = [
    ('and2', AND2, 2),
    ('addi', ADDI, 7),
    ('lt',   LT,   1),
    ('lland', LLAND, 2),
    ('vol',  VOL,  1),
]

check = V.check
skip = V.skip
run = V.run


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

    work = tempfile.mkdtemp(prefix='arkcc_pair_')
    try:
        for name, body, _ in CASES:
            V.write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off ---------------------------------------------------
        t_def, b_def, e1 = V.build(arkcc, work, 'and2', [], 'defoff')
        t_off, b_off, e2 = V.build(arkcc, work, 'and2', ['-fno-opt-pair'], 'fno')
        t_on, b_on, e3 = V.build(arkcc, work, 'and2', [FLAG], 'on')
        if e1 or e2 or e3:
            check(False, 'and2: all three arms build', (e1 or e2 or e3)[0][:120])
            return 1
        check(t_def == t_off and b_def == b_off,
              'and2: -O2 and -O2 -fno-opt-pair are byte-identical')
        # The two operand pushes are not adjacent pushes/pops, so count stack
        # traffic inside the function itself: it is all staging.
        f_def = V.split_functions(t_def).get('and2', '')
        f_on = V.split_functions(t_on).get('and2', '')
        p_def, p_on = V.stack_ops(f_def), V.stack_ops(f_on)
        check(p_def > 0,
              'and2: the default build still stages the operands',
              '%d stack op(s)' % p_def)

        # --- 2. pair engages -------------------------------------------------
        check(p_def - p_on == 4,
              'and2: exactly the two staging push/pop pairs disappear',
              '%d -> %d stack op(s)' % (p_def, p_on))
        check('AND r0, r1' in f_on,
              'and2: the operator reads r0 and r1 directly')
        check(V.insn_count(f_on) < V.insn_count(f_def),
              'and2: instructions drop',
              '%d -> %d' % (V.insn_count(f_def), V.insn_count(f_on)))
        check(len(b_on) <= len(b_def),
              'and2: the image never grows',
              '%d -> %d bytes' % (len(b_def), len(b_on)))
        check(label_count(t_on) == label_count(t_def),
              'and2: the label set is untouched',
              '%d/%d' % (label_count(t_def), label_count(t_on)))

        # --- 3. imm stands down ----------------------------------------------
        for tag, flags in (('plain', []), ('imm', ['-fopt-imm'])):
            a_t, a_b, ea = V.build(arkcc, work, 'addi', flags, tag + 'off')
            b_t, b_b, eb = V.build(arkcc, work, 'addi', flags + [FLAG], tag + 'on')
            if ea or eb:
                check(False, 'addi/%s: both arms build' % tag, (ea or eb)[0][:120])
                continue
            check(a_t == b_t and a_b == b_b,
                  'addi/%s: a folded immediate is left alone by the pair pass' % tag)

        # --- 4. cbranch stands down ------------------------------------------
        for tag, flags in (('cbranch', ['-fopt-cbranch']), ('nocbr', [])):
            a_t, a_b, ea = V.build(arkcc, work, 'lt', flags, tag + 'off')
            b_t, b_b, eb = V.build(arkcc, work, 'lt', flags + [FLAG], tag + 'on')
            if ea or eb:
                check(False, 'lt/%s: both arms build' % tag, (ea or eb)[0][:120])
                continue
            same = a_t == b_t and a_b == b_b
            if tag == 'cbranch':
                check(same, 'lt: -fopt-cbranch keeps its comparison from the pair pass')
            else:
                check(not same,
                      'lt: without -fopt-cbranch the pair pass does take the comparison')

        # --- 5. refusals hold ------------------------------------------------
        for name in ('lland', 'vol'):
            a_t, a_b, ea = V.build(arkcc, work, name, [], 'roff')
            b_t, b_b, eb = V.build(arkcc, work, name, [FLAG], 'ron')
            if ea or eb:
                check(False, '%s: both arms build' % name, (ea or eb)[0][:120])
                continue
            check(a_t == b_t and a_b == b_b,
                  '%s: a shape the pass cannot model is left byte-identical' % name)

        # --- 6. the answer is the same ---------------------------------------
        if not V.HAVE_UNICORN:
            skip('all fixtures: emulator value', 'python package unicorn missing')
        else:
            got = {}
            ok = True
            for name, body, want in CASES:
                got[name] = {}
                for tag, flags in (('off', []), ('on', [FLAG])):
                    t, blob, err = V.build(arkcc, work, name, flags, 'ans' + tag)
                    if err:
                        check(False, '%s: %s arm builds for the run' % (name, tag),
                              err[0][:120])
                        ok = False
                        break
                    st, val, _ = V.run_image(blob)
                    got[name][tag] = val if st == 'returned' else st
                if not ok:
                    break
                check(all(got[name][t] == want for t in ('off', 'on')),
                      '%s: off/on return the Python answer' % name,
                      ' '.join('%s=%s' % (t, got[name][t]) for t in ('off', 'on'))
                      + ' want=%s' % want)

        # --- 7. cropped out, refused ----------------------------------------
        trimmed, why = V.build_arkcc(work, [DEFINE], 'arkcc_nopair')
        if trimmed is None:
            skip('a cropped build refuses -fopt-pair', why)
        else:
            src = os.path.join(work, 'and2.c')
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                                 '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-pair by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                                 '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\npair: %d check(s) FAILED%s' % (
            len(V.failures), (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\npair: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)