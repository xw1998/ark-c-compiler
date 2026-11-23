#!/usr/bin/env python3
"""Gate for dead push elimination (-fopt-deadpush, 0.9.1).

An assignment keeps its value on the IR stack for the enclosing expression, so
irgen stores the value and then reloads it (`AST_ASSIGN`: "Re-load the stored
value").  When the assignment is a statement of its own, the caller pops that
value one instruction later, and the reload was a real LDR.  The pass deletes
a push that the following IR_POP (or POP chain, for a two-word value) throws
away: a one-word push has no side effect, so the pair is exactly dead, and the
store itself stays -- only the throw-away read disappears.

What the gate has to prove, one claim per check:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-deadpush` are byte-identical and the
     default build still reads the stored value back.
  2. THE THROW-AWAY READ GOES.  A statement assignment loses exactly the reload
     it never uses: one LDR fewer, a shorter function, an image that never
     grows, an untouched label set.
  3. A USED VALUE STAYS.  `z = (y = a + 1) + 2;` keeps the inner reload (the
     outer expression reads it) and loses only the outer throw-away one.
  4. VOLATILE IS AN OBSERVATION.  `volatile int v; v = a;` keeps its read-back
     pair byte for byte: the read is required, not dead.
  5. A TWO-WORD VALUE GOES TOO.  `long long h; h = a;` pushes two words and the
     statement pops two; both reloads disappear and the value is unchanged.
  6. THE ANSWER IS THE SAME.  Every fixture runs under unicorn and returns the
     value computed here in Python, in both arms.
  7. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_DEADPUSH=0 refuses
     `-fopt-deadpush` by name (C3900U) and still compiles without the flag.

Usage: run_deadpush_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
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

FLAG = '-fopt-deadpush'
DEFINE = '-DARKCC_FEATURE_OPT_DEADPUSH=0'
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
# Inlining is size-driven: deleting one instruction can inline a small static
# and change the image for reasons that have nothing to do with this pass.
BASE = ['-fno-opt-inline']
INC = os.path.join(ROOT, 'stdlib', 'include')

# 2. The statement assignment: the stored value is reloaded and discarded.
STMT = """\
int dp_pad_1;
static int stmt(int a)
{
    int x;
    x = a + 1;
    return x;
}
int main(void) { return stmt(4); }
"""

# 3. The inner assignment's value feeds the outer expression: only the outer
# throw-away reload may go.
USED = """\
int dp_pad_2;
static int used(int a)
{
    int y;
    int z;
    z = (y = a + 1) + 2;
    return z + y;
}
int main(void) { return used(4); }
"""

# 4. A volatile read is an observation; its push must stay.
VOLATILE = """\
int dp_pad_3;
static int volloc(int a)
{
    volatile int v;
    v = a;
    return 0;
}
int main(void) { return volloc(3) + 0; }
"""

# 5. A two-word value: the push is two words and the statement pops two.
WIDE = """\
int dp_pad_4;
static int wide(int a)
{
    long long h;
    h = a;
    return (int)h;
}
int main(void) { return wide(4); }
"""

CASES = [
    ('stmt',     STMT,     5),
    ('used',     USED,    12),
    ('volatile', VOLATILE, 0),
    ('wide',     WIDE,     4),
]

check = V.check
skip = V.skip
run = V.run

def label_count(text):
    return sum(1 for ln in text.splitlines()
               if ln.strip().startswith('.L') and ln.strip().endswith(':'))

def fn_text(text, name):
    return V.split_functions(text).get(name, '')

def loads(text, name):
    return sum(1 for ln in fn_text(text, name).splitlines()
               if ln.strip().startswith('LDR'))

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_dp_')
    try:
        for name, body, _ in CASES:
            V.write(os.path.join(work, name + '.c'), body)

        built = {}
        for name, _, _ in CASES:
            arm = {}
            for tag, flags in (('off', BASE), ('on', BASE + [FLAG])):
                t, b, err = V.build(arkcc, work, name, flags, tag)
                if err:
                    check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
                    arm = None
                    break
                arm[tag] = (t, b)
            built[name] = arm

        # --- 1. off is off ---------------------------------------------------
        t_def, b_def, e1 = V.build(arkcc, work, 'stmt', BASE, 'plain')
        t_fno, b_fno, e2 = V.build(arkcc, work, 'stmt', BASE + ['-fno-opt-deadpush'], 'fno')
        if e1 or e2:
            check(False, 'stmt: the default arms build', (e1 or e2)[0][:120])
        else:
            check(t_def == t_fno and b_def == b_fno,
                  'stmt: -O2 and -O2 -fno-opt-deadpush are byte-identical')
            check(loads(t_def, 'stmt') >= 2,
                  'stmt: the default build reloads the stored value',
                  '%d load(s)' % loads(t_def, 'stmt'))

        # --- 2. the throw-away read goes -------------------------------------
        if built['stmt']:
            off, on = built['stmt']['off'], built['stmt']['on']
            check(loads(on[0], 'stmt') == loads(off[0], 'stmt') - 1,
                  'stmt: exactly the discarded reload disappears',
                  '%d -> %d load(s)' % (loads(off[0], 'stmt'),
                                        loads(on[0], 'stmt')))
            check(V.insn_count(fn_text(on[0], 'stmt')) <
                  V.insn_count(fn_text(off[0], 'stmt')),
                  'stmt: the function gets shorter')
            check(len(on[1]) <= len(off[1]),
                  'stmt: the image never grows',
                  '%d -> %d bytes' % (len(off[1]), len(on[1])))

        # --- 3. a used value stays -------------------------------------------
        if built['used']:
            off, on = built['used']['off'], built['used']['on']
            check(loads(on[0], 'used') == loads(off[0], 'used') - 1,
                  'used: only the outer throw-away reload disappears',
                  '%d -> %d load(s)' % (loads(off[0], 'used'),
                                        loads(on[0], 'used')))
            check('LDR r0, [r6, #8]' in on[0] or 'LDR r5, [r6, #8]' in on[0]
                  or 'LDR r7, [r6, #8]' in on[0],
                  'used: the inner reload (the value the outer expression reads) stays')

        # --- 4. volatile is an observation -----------------------------------
        if built['volatile']:
            off, on = built['volatile']['off'], built['volatile']['on']
            # The prelude (Reset_Handler calls main and keeps its result) has a
            # discard of its own, and this pass is entitled to remove it.  The
            # claim here is about the volatile function, so compare that region
            # rather than the whole file.
            check(fn_text(off[0], 'volloc') == fn_text(on[0], 'volloc'),
                  'volatile: volloc is left byte-identical')
            check(loads(on[0], 'volloc') == loads(off[0], 'volloc'),
                  'volatile: the read-back of the volatile local stays',
                  '%d -> %d load(s)' % (loads(off[0], 'volloc'),
                                        loads(on[0], 'volloc')))

        # --- 5. a two-word value ---------------------------------------------
        if built['wide']:
            off, on = built['wide']['off'], built['wide']['on']
            check(loads(on[0], 'wide') == loads(off[0], 'wide') - 2,
                  'wide: both reloads of the two-word value disappear',
                  '%d -> %d load(s)' % (loads(off[0], 'wide'),
                                        loads(on[0], 'wide')))
            check(V.insn_count(fn_text(on[0], 'wide')) <
                  V.insn_count(fn_text(off[0], 'wide')),
                  'wide: the function gets shorter')

        # --- label set and image size, all fixtures --------------------------
        for name, _, _ in CASES:
            if not built[name]:
                continue
            off, on = built[name]['off'], built[name]['on']
            check(label_count(on[0]) == label_count(off[0]),
                  '%s: the label set is untouched' % name,
                  '%d/%d' % (label_count(off[0]), label_count(on[0])))
            check(len(on[1]) <= len(off[1]),
                  '%s: the image never grows' % name,
                  '%d -> %d bytes' % (len(off[1]), len(on[1])))

        # --- 6. the answer is the same ---------------------------------------
        if not V.HAVE_UNICORN:
            skip('all fixtures: emulator value', 'python package unicorn missing')
        else:
            for name, _, want in CASES:
                if not built[name]:
                    continue
                got = {}
                ok = True
                for tag in ('off', 'on'):
                    blob = built[name][tag][1]
                    st, val, _ = V.run_image(blob)
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

        # --- 7. cropped out, refused -----------------------------------------
        trimmed, why = V.build_arkcc(work, [DEFINE], 'arkcc_nodp')
        if trimmed is None:
            skip('a cropped build refuses -fopt-deadpush', why)
        else:
            src = os.path.join(work, 'stmt.c')
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                                 '-o', 't.s'] + BASE + [FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-deadpush by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                                 '-o', 't.s'] + BASE, work)
            check(rc == 0,
                  'the cropped build still compiles without the flag', 'rc=%d' % rc)
    finally:
        pass

    if V.failures:
        print('%d check(s) FAILED' % len(V.failures))
        return 1
    print('deadpush: all checks passed%s'
          % ('' if not V.skips else ' (%d skipped)' % len(V.skips)))
    return 0


if __name__ == '__main__':
    sys.exit(main())
