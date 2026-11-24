#!/usr/bin/env python3
"""Gate for resolving a branch whose condition is a literal (-fopt-constcond, 0.9.1).

The front end really hands literal conditions to the emitter: every
`do { ... } while (0U)` wrapper (the HAL lock macros, `assert_param`), every
`if (0)` guard and every `while (0)` ends up as a `PUSH_INT k` followed by a
`JZ`/`JNZ` against it.  Deciding such a branch is pure bookkeeping -- `k` is a
literal in the IR and the net stack effect of the pair is zero -- so it can be
done with no guess.  The pass runs right before dead-code elimination, so the
code that the new unconditional jump makes unreachable is cleared in the same
breath.

What the gate has to prove, one claim per check:

  1. OFF IS OFF.  `-O2` and `-O2 -fopt-constcond -fno-opt-constcond` are
     byte-identical (assembly and image).
  2. THE DEAD BODY GOES.  `if (0)` keeps no branch and no body instructions.
  3. THE TAKEN BODY STAYS.  `if (1)` keeps the body but has no branch on a
     literal.
  4. THE EMPTY LOOP GOES.  `while (0)` keeps no back-edge.
  5. THE ONE-SHOT LOOP GOES.  `do { } while (0)` keeps the body, drops the
     back-edge.
  6. A REAL CONDITION IS UNTOUCHED.  A function branching on a parameter is
     byte-identical either way, in the same translation unit as a folded one.
  7. THE ANSWER IS THE SAME.  Every fixture runs under unicorn and returns the
     value computed here in Python, in both arms.
  8. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_CONSTCOND=0
     refuses `-fopt-constcond` by name (C3900U) and still compiles without it.

Usage: run_constcond_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import re
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

FLAG = '-fopt-constcond'
DEFINE = '-DARKCC_FEATURE_OPT_CONSTCOND=0'
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
BASE = ['-fno-opt-inline']
INC = os.path.join(ROOT, 'stdlib', 'include')

# 2. A literal-false guard: the body must disappear, the tail must stay.
IFZERO = """\
int cc_pad_0;
int cc_g0;
int f(int a)
{
    if (0) { cc_g0 = a * 7; }
    return a + 1;
}
int main(void) { return f(5) & 0xFF; }
"""

# 3. A literal-true guard: the body stays, but no branch on a literal.
IFONE = """\
int cc_pad_1;
int cc_g1;
int f(int a)
{
    if (1) { cc_g1 = a * 3; }
    return a + 2;
}
int main(void) { return f(5) & 0xFF; }
"""

# 4. A loop that never runs: no back-edge, no body.
WHZERO = """\
int cc_pad_2;
int cc_g2;
int f(int a)
{
    while (0) { cc_g2 = a * 5; }
    return a + 3;
}
int main(void) { return f(5) & 0xFF; }
"""

# 5. The HAL macro shape `do { ... } while (0)`: the body runs once, the
#    back-edge is dead.
DOWHILE = """\
int cc_pad_3;
int cc_g3;
int f(int a)
{
    do { cc_g3 = a * 9; } while (0);
    return a + 4;
}
int main(void) { return f(5) & 0xFF; }
"""

# 6. A real condition next to a folded one in the same translation unit.
MIXED = """\
int cc_pad_4;
int cc_g4;
int cc_h4;
int folded(int a)
{
    if (1) { cc_g4 = a; }
    return a + 6;
}
int real(int a)
{
    if (a) { cc_h4 = a * 2; }
    return a + 7;
}
int main(void) { return (folded(5) + real(3)) & 0xFF; }
"""

CASES = [
    ('ifzero',  IFZERO,  6),
    ('ifone',   IFONE,   7),
    ('whzero',  WHZERO,  8),
    ('dowhile', DOWHILE, 9),
    ('mixed',   MIXED,  21),
]

check = V.check
skip = V.skip
run = V.run


def fn_text(text, name):
    """The whole body of `name`, from its label to its `.size` directive.

    `V.split_functions` also cuts at every local label, which would hide the
    body behind the first `.L_...`; a fold on a literal moves exactly that
    boundary, so the region has to span the entire function.
    """
    lines = text.splitlines()
    out, inside = [], False
    for ln in lines:
        s = ln.strip()
        if not inside and s == name + ':':
            inside = True
            continue
        if inside and (s.startswith('.size') and s.split()[1].rstrip(',') == name):
            break
        if inside:
            out.append(ln)
    return '\n'.join(out)


def insns(text, name):
    return V.insn_count(fn_text(text, name))


def branches(text, name):
    """Branches inside a function (labels for the ends are not counted)."""
    n = 0
    for ln in fn_text(text, name).splitlines():
        s = ln.strip()
        if re.match(r'^(B|B[A-Z]{2}|CBZ|CBNZ)\s+\.?L', s):
            n += 1
    return n


def literal_branch(text, name):
    """A `CMP rX, #0` that decides a branch -- the shape the pass removes."""
    lines = fn_text(text, name).splitlines()
    n = 0
    for i, ln in enumerate(lines[:-1]):
        if re.match(r'^CMP\s+r\d+, #0$', ln.strip()) and \
           re.match(r'^(B|B[A-Z]{2})\s+\.?L', lines[i + 1].strip()):
            n += 1
    return n


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_cc_')
    for name, body, _ in CASES:
        V.write(os.path.join(work, name + '.c'), body)

    built = {}
    for name, _, _ in CASES:
        arms = {}
        for tag, flags in (('off', BASE), ('on', BASE + [FLAG])):
            t, b, err = V.build(arkcc, work, name, flags, tag)
            if err:
                check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
                arms = None
                break
            arms[tag] = (t, b)
        built[name] = arms

    # --- 1. off is off ---------------------------------------------------
    t_def, b_def, e1 = V.build(arkcc, work, 'ifone', BASE, 'ifone_def')
    t_fno, b_fno, e2 = V.build(
        arkcc, work, 'ifone', BASE + [FLAG, '-fno-opt-constcond'], 'ifone_fno')
    if e1 or e2:
        check(False, 'ifone: the default arms build', (e1 or e2)[0][:120])
    else:
        check(t_def == t_fno and b_def == b_fno,
              'off is off: -O2 and -O2 -fopt-constcond -fno-opt-constcond '
              'are byte-identical')

    # --- 2. the dead body goes -------------------------------------------
    if built['ifzero'] and built['ifzero']['off'] and built['ifzero']['on']:
        off, on = built['ifzero']['off'][0], built['ifzero']['on'][0]
        check(branches(on, 'f') < branches(off, 'f'),
              'ifzero: the branch on the literal is gone',
              '%d -> %d branch(es)' % (branches(off, 'f'), branches(on, 'f')))
        check(insns(on, 'f') < insns(off, 'f'),
              'ifzero: the dead body is dropped by the following DCE',
              '%d -> %d insn' % (insns(off, 'f'), insns(on, 'f')))
        check('cc_g0' not in on and 'cc_g0' not in fn_text(on, 'f'),
              'ifzero: no store into the dead body survives')

    # --- 3. the taken body stays -----------------------------------------
    if built['ifone'] and built['ifone']['off'] and built['ifone']['on']:
        off, on = built['ifone']['off'][0], built['ifone']['on'][0]
        check(literal_branch(on, 'f') == 0,
              'ifone: no branch is left on a literal',
              '%d literal branch(es)' % literal_branch(on, 'f'))
        check(literal_branch(off, 'f') >= 1,
              'ifone: the un-folded arm still branches on the literal',
              '%d literal branch(es)' % literal_branch(off, 'f'))

    # --- 4. the empty loop goes ------------------------------------------
    if built['whzero'] and built['whzero']['off'] and built['whzero']['on']:
        off, on = built['whzero']['off'][0], built['whzero']['on'][0]
        check(literal_branch(on, 'f') == 0,
              'whzero: the guard on the literal is gone',
              '%d literal branch(es)' % literal_branch(on, 'f'))
        check(insns(on, 'f') < insns(off, 'f'),
              'whzero: the loop body is unreachable and dropped',
              '%d -> %d insn' % (insns(off, 'f'), insns(on, 'f')))

    # --- 5. the one-shot loop goes ---------------------------------------
    if built['dowhile'] and built['dowhile']['off'] and built['dowhile']['on']:
        off, on = built['dowhile']['off'][0], built['dowhile']['on'][0]
        check(branches(on, 'f') < branches(off, 'f'),
              'dowhile: the `while (0)` back-edge is gone',
              '%d -> %d branch(es)' % (branches(off, 'f'), branches(on, 'f')))
        check('cc_g3' in on or 'STR' in fn_text(on, 'f'),
              'dowhile: the body still runs once')

    # --- 6. a real condition is untouched --------------------------------
    if built['mixed'] and built['mixed']['off'] and built['mixed']['on']:
        off, on = built['mixed']['off'][0], built['mixed']['on'][0]
        check(fn_text(off, 'real') == fn_text(on, 'real'),
              'mixed: a branch on a parameter is byte-identical')
        check(fn_text(off, 'folded') != fn_text(on, 'folded'),
              'mixed: the literal-condition function in the same TU does change')

    # --- 7. the answer is the same ---------------------------------------
    if not V.HAVE_UNICORN:
        skip('all fixtures: emulator value', 'python package unicorn missing')
    else:
        for name, _, want in CASES:
            if not built[name]:
                continue
            got = {}
            ok = True
            for tag in ('off', 'on'):
                st, val, _ = V.run_image(built[name][tag][1])
                if st != 'returned':
                    check(False, '%s: the %s image runs' % (name, tag), st)
                    ok = False
                    break
                got[tag] = val
            if not ok:
                continue
            check(all(got[t] == want for t in ('off', 'on')),
                  '%s: off/on return the Python answer' % name,
                  ' '.join('%s=%s' % (t, got[t]) for t in ('off', 'on'))
                  + ' want=%s' % want)

    # --- 8. cropped out, refused -----------------------------------------
    trimmed, why = V.build_arkcc(work, [DEFINE], 'arkcc_nocc')
    if trimmed is None:
        skip('a cropped build refuses -fopt-constcond', why)
    else:
        src = os.path.join(work, 'ifone.c')
        rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                             '-o', 't.s'] + BASE + [FLAG], work)
        check(rc != 0 and 'C3900U' in log and FLAG in log,
              'the cropped build refuses -fopt-constcond by name', 'rc=%d' % rc)
        rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                             '-o', 't.s'] + BASE, work)
        check(rc == 0,
              'the cropped build still compiles without the flag', 'rc=%d' % rc)

    if V.failures:
        print('%d check(s) FAILED' % len(V.failures))
        return 1
    print('constcond: all checks passed%s'
          % ('' if not V.skips else ' (%d skipped)' % len(V.skips)))
    return 0


if __name__ == '__main__':
    sys.exit(main())