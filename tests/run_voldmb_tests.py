#!/usr/bin/env python3
"""Gate for volatile frame barriers (-fopt-voldmb, 0.9.1).

A volatile access to a *local* is emitted with a DMB SY pair.  The barrier's
only observable effect is the order in which the memory system makes the
access visible to another observer, and a frame slot whose address this
function never takes has no other observer: nothing outside the frame can name
it.  The pass therefore drops the pair exactly when the accessed object's name
never appears in an IR_PUSH_ADDR.  armcc, armclang and IAR emit no barrier at
all for the HAL's `__IO uint32_t tmpreg` idiom, which is this pass's whole
population.

What the gate has to prove, one claim per check:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-voldmb` are byte-identical.
  2. THE PAIR GOES.  A volatile local whose address is never taken loses both
     DMB SY, the function gets shorter, and the image never grows.
  3. A LEAKED OBJECT KEEPS ITS PAIR.  `&v` in the same function puts the two
     barriers back, byte for byte -- the object is now nameable from outside.
  4. ONLY THE NAMED OBJECT COUNTS.  `&s.a` names `s`, so an unrelated
     volatile local `k` in the same function still loses its pair -- the
     proof is per object, not per function.
  5. A PLAIN LOCAL IS UNTOUCHED.  A non-volatile function is byte-identical
     either way: this pass only ever deletes a barrier.
  6. THE ANSWER IS THE SAME.  Every fixture runs under unicorn and returns the
     value computed here in Python, in both arms.
  7. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_VOLDBM=0 refuses
     `-fopt-voldmb` by name (C3900U) and still compiles without the flag.

Usage: run_voldmb_tests.py [path-to-arkcc]
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

FLAG = '-fopt-voldmb'
DEFINE = '-DARKCC_FEATURE_OPT_VOLDBM=0'
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
BASE = ['-fno-opt-inline']
INC = os.path.join(ROOT, 'stdlib', 'include')

# 2. The HAL idiom, shrunk: a volatile local that nothing can name.
PLAIN = """\
int vm_pad_1;
static int plain(int a)
{
    volatile int v;
    v = a + 1;
    return v;
}
int main(void) { return plain(4); }
"""

# 3. The same shape, but this function hands &v to a callee: the barriers must
#    stay, because another observer can now reach the object.
LEAKED = """\
int vm_pad_2;
static int sink(volatile int *p) { return *p; }
static int leaked(int a)
{
    volatile int v;
    v = a + 1;
    return sink(&v);
}
int main(void) { return leaked(5); }
"""

# 4. `&s.a` takes the address of `s`, not of the volatile local `k`: an
#    unrelated address-of must not disable the pass for the whole function.
BLIND = """\
int vm_pad_3;
struct vm_s { int a; int b; };
static int take(int *p) { return *p; }
static int blind(int a)
{
    volatile int k;
    struct vm_s s;
    k = a;
    s.a = 1;
    s.b = 2;
    return k + take(&s.a);
}
int main(void) { return blind(1); }
"""

# 5. No volatile at all: the pass must be a no-op.
QUIET = """\
int vm_pad_4;
static int quiet(int a)
{
    int t = a * 3;
    return t + 1;
}
int main(void) { return quiet(2); }
"""

CASES = [
    ('plain',  PLAIN,  5),
    ('leaked', LEAKED, 6),
    ('blind',  BLIND,  2),
    ('quiet',  QUIET,  7),
]

check = V.check
skip = V.skip
run = V.run


def fn_text(text, name):
    return V.split_functions(text).get(name, '')


def dmbs(text, name):
    return sum(1 for ln in fn_text(text, name).splitlines()
               if ln.strip() == 'DMB SY')


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_vm_')
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
    t_def, b_def, e1 = V.build(arkcc, work, 'plain', BASE, 'plain_def')
    t_fno, b_fno, e2 = V.build(arkcc, work, 'plain', BASE + ['-fno-opt-voldmb'], 'plain_fno')
    if e1 or e2:
        check(False, 'plain: the default arms build', (e1 or e2)[0][:120])
    else:
        check(t_def == t_fno and b_def == b_fno,
              'plain: -O2 and -O2 -fno-opt-voldmb are byte-identical')
        check(dmbs(t_def, 'plain') == 6,
              'plain: the default build emits a pair per volatile access',
              '%d barrier(s)' % dmbs(t_def, 'plain'))

    # --- 2. the pair goes ------------------------------------------------
    if built['plain']:
        off, on = built['plain']['off'], built['plain']['on']
        check(dmbs(off[0], 'plain') == 6 and dmbs(on[0], 'plain') == 0,
              'plain: every barrier goes when nothing can name the object',
              '%d -> %d' % (dmbs(off[0], 'plain'), dmbs(on[0], 'plain')))
        check(V.insn_count(fn_text(on[0], 'plain')) ==
              V.insn_count(fn_text(off[0], 'plain')) - 6,
              'plain: the function is exactly one instruction shorter per '
              'deleted barrier')
        check(len(on[1]) <= len(off[1]),
              'plain: the image never grows',
              '%d -> %d bytes' % (len(off[1]), len(on[1])))

    # --- 3. a leaked object keeps its pair -------------------------------
    if built['leaked']:
        off, on = built['leaked']['off'], built['leaked']['on']
        check(dmbs(off[0], 'leaked') > 0,
              'leaked: the default build emits barriers',
              '%d barrier(s)' % dmbs(off[0], 'leaked'))
        check(fn_text(off[0], 'leaked') == fn_text(on[0], 'leaked'),
              'leaked: &v keeps the barriers byte for byte')

    # --- 4. an unnamed address-of blinds the function --------------------
    if built['blind']:
        off, on = built['blind']['off'], built['blind']['on']
        check(dmbs(off[0], 'blind') > 0,
              'blind: the default build emits barriers for the volatile local',
              '%d barrier(s)' % dmbs(off[0], 'blind'))
        check(dmbs(on[0], 'blind') < dmbs(off[0], 'blind'),
              'blind: an unrelated &s.a does not disable the pass',
              '%d -> %d barrier(s)' % (dmbs(off[0], 'blind'),
                                       dmbs(on[0], 'blind')))
        check(len(on[1]) <= len(off[1]),
              'blind: the image never grows',
              '%d -> %d bytes' % (len(off[1]), len(on[1])))

    # --- 5. a plain local is untouched -----------------------------------
    if built['quiet']:
        off, on = built['quiet']['off'], built['quiet']['on']
        check(off[0] == on[0] and off[1] == on[1],
              'quiet: a function with no volatile access is byte-identical')

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

    # --- 7. cropped out, refused -----------------------------------------
    trimmed, why = V.build_arkcc(work, [DEFINE], 'arkcc_novm')
    if trimmed is None:
        skip('a cropped build refuses -fopt-voldmb', why)
    else:
        src = os.path.join(work, 'plain.c')
        rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                             '-o', 't.s'] + BASE + [FLAG], work)
        check(rc != 0 and 'C3900U' in log and FLAG in log,
              'the cropped build refuses -fopt-voldmb by name', 'rc=%d' % rc)
        rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                             '-o', 't.s'] + BASE, work)
        check(rc == 0,
              'the cropped build still compiles without the flag', 'rc=%d' % rc)

    if V.failures:
        print('%d check(s) FAILED' % len(V.failures))
        return 1
    print('voldmb: all checks passed%s'
          % ('' if not V.skips else ' (%d skipped)' % len(V.skips)))
    return 0

if __name__ == '__main__':
    sys.exit(main())
