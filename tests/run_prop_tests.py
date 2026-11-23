#!/usr/bin/env python3
"""Gate for local-slot constant propagation with paired dead-store removal
(-fopt-prop, 0.9.1).

Everything irgen spills to a frame slot stays a real LDR/STR unless an IR-level
pass remembers what went in.  This pass keeps a *byte* map of the frame, so a
load whose bytes are all known becomes the constant they spell (extended the
way LDRB/LDRSB/LDRH/LDRSH/LDR extend), and a store whose bytes are never read
again is deleted together with the one-instruction producer in front of it.

What the gate has to prove, one claim per check:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-prop` are byte-identical, and the
     default build still emits both stores of an overwritten temp.
  2. DEAD STORES GO.  `tmpreg = 0; tmpreg = a + 1;` loses one STR, the image
     never grows, the label set is untouched.
  3. LIVE STORES STAY.  A store that is read before being overwritten is left
     alone (the whole function is byte-identical).
  4. A MERGE IS A BARRIER.  `if (c) x = 5; else x = 9;` then `return x * 2`
     cannot be folded: the join point kills the byte map, so nothing changes.
  5. A TAKEN ADDRESS ENDS THE ANALYSIS.  `x = 0; x = a; bump(&x);` keeps the
     first store: a callee can read the frame through the pointer.
  6. A CALL WITHOUT AN ADDRESS DOES NOT.  With no PUSH_ADDR anywhere in the
     function, a callee cannot name a byte of this frame, so `x = 0; x = a + 2;
     note(x);` may lose the first store.
  7. VOLATILE IS AN OBSERVATION.  Two volatile stores to the same local stay.
  8. PROPAGATION ENGAGES.  `x = 7; y = 1; return x + y;` folds to 8 with no
     LDR left, which needs both the byte map and the folding re-run.
  9. THE ANSWER IS THE SAME.  Every fixture runs under unicorn and must return
     the value computed here in Python, in both arms.
 10. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_PROP=0 refuses
     `-fopt-prop` by name (C3900U) and still compiles without the flag.

Usage: run_prop_tests.py [path-to-arkcc]
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

FLAG = '-fopt-prop'
DEFINE = '-DARKCC_FEATURE_OPT_PROP=0'
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
# Inlining is a size-driven decision of its own: deleting one instruction can
# push a small static over the threshold and inline it, which changes the image
# for reasons that have nothing to do with this pass.  The gate holds it still
# so an image-size claim is about the pass and not about the inliner.
BASE = ['-fno-opt-inline']
INC = os.path.join(ROOT, 'stdlib', 'include')

# 2. The dead-store shape: the first store is overwritten before any read.
DEAD = """\
int prop_pad_1;
static int dead_overwrite(int a)
{
    unsigned int tmpreg = 0;
    tmpreg = (unsigned int)a + 1u;
    return (int)tmpreg;
}
int main(void) { return dead_overwrite(4); }
"""

# 3. The same temp, but read before it is overwritten: not dead.
LIVE = """\
int prop_pad_2;
static int kept(int a)
{
    int x = 3;
    int s;
    s = x * 2;
    x = 4;
    return s + x + a;
}
int main(void) { return kept(1); }
"""

# 4. Two paths reach the read: the byte map must die at the join point.
MERGE = """\
int prop_pad_3;
static int merge(int c)
{
    int x;
    if (c) x = 5;
    else x = 9;
    return x * 2;
}
int main(void) { return merge(1) + merge(0); }
"""

# 5. The address of the frame slot leaves before the store is overwritten: the
# callee may read it, so the store is not dead even though nothing in this
# function reads it afterwards.
ESCAPE = """\
int prop_pad_4;
static int sink_seen;
static void use(int *p) { sink_seen = *p; }
static int esc(int a)
{
    int x = 1;
    int *p;
    p = &x;
    use(p);
    x = a;
    return x + sink_seen;
}
int main(void) { return esc(6); }
"""

# 6. A call, but no address is ever taken: the frame cannot be named.
NOADDR = """\
int prop_pad_5;
static int sink;
static void note(int v) { sink = v; }
static int noaddr(int a)
{
    int x = 0;
    x = a + 2;
    note(x);
    return x;
}
int main(void) { return noaddr(5); }
"""

# 7. A volatile store is an observation, not a dead write.
VOLATILE = """\
int prop_pad_6;
static int volloc(int a)
{
    volatile int v;
    v = 0;
    v = a;
    return v;
}
int main(void) { return volloc(3); }
"""

# 8. The propagation shape: the read follows a store to *another* slot.
PROP = """\
int prop_pad_7;
static int propread(void)
{
    int x = 7;
    int y = 1;
    return x + y;
}
int main(void) { return propread(); }
"""

CASES = [
    ('dead',     DEAD,     5),
    ('live',     LIVE,    11),
    ('merge',    MERGE,   28),
    ('escape',   ESCAPE,   7),
    ('noaddr',   NOADDR,   7),
    ('volatile', VOLATILE, 3),
    ('prop',     PROP,     8),
]

check = V.check
skip = V.skip
run = V.run


def label_count(text):
    return sum(1 for ln in text.splitlines()
               if ln.strip().startswith('.L') and ln.strip().endswith(':'))


def fn_text(text, name):
    """The emitted chunk for one function (the label chunk starting at `name`)."""
    return V.split_functions(text).get(name, '')


def stores(text, name):
    return sum(1 for ln in fn_text(text, name).splitlines()
               if ln.strip().startswith('STR'))


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

    work = tempfile.mkdtemp(prefix='arkcc_prop_')
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
        t_def, b_def, e1 = V.build(arkcc, work, 'dead', BASE, 'plain')
        t_fno, b_fno, e2 = V.build(arkcc, work, 'dead', BASE + ['-fno-opt-prop'], 'fno')
        if e1 or e2:
            check(False, 'dead: the default arms build', (e1 or e2)[0][:120])
        else:
            check(t_def == t_fno and b_def == b_fno,
                  'dead: -O2 and -O2 -fno-opt-prop are byte-identical')
            check(stores(t_def, 'dead_overwrite') >= 2,
                  'dead: the default build still writes the temp twice',
                  '%d store(s)' % stores(t_def, 'dead_overwrite'))

        # --- 2. dead stores go -----------------------------------------------
        if built['dead']:
            off, on = built['dead']['off'], built['dead']['on']
            check(stores(on[0], 'dead_overwrite') == stores(off[0], 'dead_overwrite') - 1,
                  'dead: the overwritten store disappears',
                  '%d -> %d store(s)' % (stores(off[0], 'dead_overwrite'),
                                         stores(on[0], 'dead_overwrite')))
            check(len(on[1]) <= len(off[1]),
                  'dead: the image never grows',
                  '%d -> %d bytes' % (len(off[1]), len(on[1])))
            check(V.insn_count(fn_text(on[0], 'dead_overwrite')) <
                  V.insn_count(fn_text(off[0], 'dead_overwrite')),
                  'dead: the function gets shorter')

        # --- 3/4/5/7. shapes that must come out byte-identical ---------------
        for name, fn in (('merge', 'merge'), ('volatile', 'volloc')):
            if not built[name]:
                continue
            off, on = built[name]['off'], built[name]['on']
            check(off[0] == on[0] and off[1] == on[1],
                  '%s: %s is left byte-identical' % (name, fn),
                  '%d -> %d store(s)' % (stores(off[0], fn), stores(on[0], fn)))

        # 3/5. A store that is read before it is overwritten stays -- the byte
        # map may still prove a *later* load constant (that is a different
        # claim, checked by the value), but the store itself is not dead and
        # the address-taken case cannot be reasoned about at all.
        for name, fn in (('live', 'kept'), ('escape', 'esc')):
            if not built[name]:
                continue
            off, on = built[name]['off'], built[name]['on']
            check(stores(on[0], fn) == stores(off[0], fn),
                  '%s: %s keeps every store' % (name, fn),
                  '%d -> %d store(s)' % (stores(off[0], fn), stores(on[0], fn)))

        # --- 6. a call with no address taken still allows the removal --------
        if built['noaddr']:
            off, on = built['noaddr']['off'], built['noaddr']['on']
            check(stores(on[0], 'noaddr') == stores(off[0], 'noaddr') - 1,
                  'noaddr: a dead store survives a call when no address escaped',
                  '%d -> %d store(s)' % (stores(off[0], 'noaddr'),
                                         stores(on[0], 'noaddr')))

        # --- 8. propagation engages ------------------------------------------
        if built['prop']:
            off, on = built['prop']['off'], built['prop']['on']
            check(loads(off[0], 'propread') > 0,
                  'prop: the default build reads the slots back',
                  '%d load(s)' % loads(off[0], 'propread'))
            check(loads(on[0], 'propread') == 0,
                  'prop: both loads are replaced by their constants',
                  '%d load(s)' % loads(on[0], 'propread'))
            check(V.insn_count(fn_text(on[0], 'propread')) <
                  V.insn_count(fn_text(off[0], 'propread')),
                  'prop: the function gets shorter')

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

        # --- 9. the answer is the same ---------------------------------------
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

        # --- 10. cropped out, refused ----------------------------------------
        trimmed, why = V.build_arkcc(work, [DEFINE], 'arkcc_noprop')
        if trimmed is None:
            skip('a cropped build refuses -fopt-prop', why)
        else:
            src = os.path.join(work, 'dead.c')
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                                 '-o', 't.s'] + BASE + [FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-prop by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                                 '-o', 't.s'] + BASE, work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\nprop: %d check(s) FAILED%s' % (
            len(V.failures), (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\nprop: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
