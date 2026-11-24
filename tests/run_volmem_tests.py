#!/usr/bin/env python3
"""Gate for volatile access marks and barriers outside the frame (-fopt-volbar, 0.9.1).

Two separate things are checked here, because they are easy to confuse.

MARK.  `IR_AUX_VOLATILE` has to be attached to *every* access to a volatile
object, not just to a volatile local: a global, a member of a volatile
aggregate, and a dereferenced pointer all carry the qualifier (C11 6.5.2.3p3:
the qualifier comes from the object, not from the member's own type).  The
optimizer honours that bit everywhere it exists (no CSE, no hoisting, no dead
store elimination), so a missing mark is the correctness risk: it lets a later
pass fold two accesses into one and change the number of bus transactions.
That part is *always* on and costs nothing.

BARRIER.  A `DMB SY` pair around those accesses is a different question.  A
barrier only orders transactions for another observer, and on ARMv7-M a single
core never reorders Device/Strongly-ordered accesses (ARM ARM B2.3.7), which is
why armcc, armclang, IAR and GCC(Cortex-M) emit no barrier for volatile at all.
Forcing the pair on the HAL corpus costs +40% instructions (12113 -> 17081 on
the corpus, 1 -> 2848 DMB), so it is a flag, off by default, for the multi-master
case where a second bus master relies on the compiler for ordering.

What the gate has to prove, one claim per check:

  1. OFF IS OFF.  `-O2` and `-O2 -fopt-volbar -fno-opt-volbar` are byte-identical.
  2. NO BARRIER BY DEFAULT.  A global, a volatile member and a dereferenced
     pointer all emit zero DMB SY in the default build.
  3. THE TRANSACTIONS ARE STILL THERE.  The default build keeps every load and
     store of those objects: the IR mark is what makes this true.
  4. THE FLAG ADDS THE PAIR.  With `-fopt-volbar` each access grows a DMB SY on
     both sides (before: prior memory ops ordered; after: subsequent ones).
  5. A PLAIN OBJECT IS UNTOUCHED.  A non-volatile fixture is byte-identical
     either way.
  6. THE ANSWER IS THE SAME.  Every fixture runs under unicorn and returns the
     value computed here in Python, in both arms.
  7. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_VOLBAR=0 refuses
     `-fopt-volbar` by name (C3900U) and still compiles without the flag.

Usage: run_volmem_tests.py [path-to-arkcc]
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

FLAG = '-fopt-volbar'
DEFINE = '-DARKCC_FEATURE_OPT_VOLBAR=0'
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
BASE = ['-fno-opt-inline']
INC = os.path.join(ROOT, 'stdlib', 'include')

# 2. A volatile global: nothing in the frame, no address-of in this function.
GLOBAL = """\
int vm_g_pad;
volatile int vm_g;
int f(int a)
{
    vm_g = a;
    return vm_g;
}
int main(void) { return f(7); }
"""

# 2. A member of a volatile aggregate.  `v` itself is not declared volatile;
#    the qualifier comes from `s` (C11 6.5.2.3p3), which is exactly the layer
#    that the lvalue path used to drop.
MEMBER = """\
int vm_m_pad;
struct vm_ms { int v; int w; };
volatile struct vm_ms vm_s;
int f(int a)
{
    vm_s.v = a;
    return vm_s.v;
}
int main(void) { return f(9); }
"""

# 2. A dereferenced pointer to a volatile object.
POINTER = """\
int vm_p_pad;
volatile int vm_pv;
int f(int a)
{
    volatile int *p = &vm_pv;
    *p = a;
    return *p;
}
int main(void) { return f(11); }
"""

# 3. Two reads and two writes of the same volatile object: a pass that does not
#    see the mark would keep only the last write and one read.
REPEAT = """\
int vm_r_pad;
volatile int vm_r;
int f(int a)
{
    vm_r = a;
    vm_r = a + 1;
    return vm_r + vm_r;
}
int main(void) { return f(3); }
"""

# 5. No volatile at all: the flag must be a no-op.
QUIET = """\
int vm_q_pad;
static int q(int a)
{
    int t = a * 3;
    return t + 1;
}
int main(void) { return q(2); }
"""

CASES = [
    ('global',  GLOBAL,  7),
    ('member',  MEMBER,  9),
    ('pointer', POINTER, 11),
    ('repeat',  REPEAT,  8),
    ('quiet',   QUIET,   7),
]

check = V.check
skip = V.skip
run = V.run


def fn_text(text, name):
    return V.split_functions(text).get(name, '')


def dmbs(text, name):
    return sum(1 for ln in fn_text(text, name).splitlines()
               if ln.strip() == 'DMB SY')


def memops(text, name):
    """Accesses to the volatile object itself.

    Its address is materialised into a register, so the access has no immediate
    offset and reads `LDR rX, [rY]` / `STR rX, [rY]`.  Frame traffic always
    carries an offset (`[r6, #0]`, `[sp, #4]`) and is excluded by that shape.
    """
    n = 0
    for ln in fn_text(text, name).splitlines():
        if re.match(r'^(LDR|STR)\s+r\d+, \[r\d+\]$', ln.strip()):
            n += 1
    return n


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_vom_')
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
    t_def, b_def, e1 = V.build(arkcc, work, 'global', BASE, 'global_def')
    t_fno, b_fno, e2 = V.build(
        arkcc, work, 'global', BASE + [FLAG, '-fno-opt-volbar'], 'global_fno')
    if e1 or e2:
        check(False, 'global: the default arms build', (e1 or e2)[0][:120])
    else:
        check(t_def == t_fno and b_def == b_fno,
              'global: -O2 and -O2 -fopt-volbar -fno-opt-volbar are byte-identical')

    # --- 2/3. no barrier by default, transactions kept --------------------
    for name, _, _ in CASES[:-1]:
        if not built[name]:
            continue
        off = built[name]['off'][0]
        fn = 'f'
        check(dmbs(off, fn) == 0,
              '%s: the default build emits no barrier outside the frame' % name,
              '%d barrier(s)' % dmbs(off, fn))
    if built['global']:
        check(memops(built['global']['off'][0], 'f') == 2,
              'global: one store and one load survive the default build',
              '%d memory op(s)' % memops(built['global']['off'][0], 'f'))
    if built['repeat']:
        n = memops(built['repeat']['off'][0], 'f')
        check(n >= 4,
              'repeat: both stores and both loads survive the default build',
              '%d memory op(s)' % n)

    # --- 4. the flag adds the pair ---------------------------------------
    for name, _, _ in CASES[:-1]:
        if not built[name]:
            continue
        on = dmbs(built[name]['on'][0], 'f')
        check(on > 0 and on % 2 == 0,
              '%s: -fopt-volbar adds barrier pairs' % name,
              '%d barrier(s)' % on)
        check(memops(built[name]['on'][0], 'f') ==
              memops(built[name]['off'][0], 'f'),
              '%s: the flag only adds barriers, it does not move accesses' % name)

    # --- 5. a plain object is untouched ----------------------------------
    if built['quiet']:
        off, on = built['quiet']['off'], built['quiet']['on']
        check(off[0] == on[0] and off[1] == on[1],
              'quiet: a function with no volatile access is byte-identical')
        check(dmbs(off[0], 'q') == 0 and dmbs(on[0], 'q') == 0,
              'quiet: no barrier is invented')

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
    trimmed, why = V.build_arkcc(work, [DEFINE], 'arkcc_novom')
    if trimmed is None:
        skip('a cropped build refuses -fopt-volbar', why)
    else:
        src = os.path.join(work, 'global.c')
        rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                             '-o', 't.s'] + BASE + [FLAG], work)
        check(rc != 0 and 'C3900U' in log and FLAG in log,
              'the cropped build refuses -fopt-volbar by name', 'rc=%d' % rc)
        rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                                             '-o', 't.s'] + BASE, work)
        check(rc == 0,
              'the cropped build still compiles without the flag', 'rc=%d' % rc)

    if V.failures:
        print('%d check(s) FAILED' % len(V.failures))
        return 1
    print('volmem: all checks passed%s'
          % ('' if not V.skips else ' (%d skipped)' % len(V.skips)))
    return 0


if __name__ == '__main__':
    sys.exit(main())
