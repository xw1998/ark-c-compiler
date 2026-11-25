#!/usr/bin/env python3
"""Gate for the dead-frame-maintenance pass (0.9.1, -fopt-exit).

Every function with a frame pointer prints the frame base twice:

    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #16
    MOV r6, sp              ; build the base      <- E2's candidate
    ...
    MOV sp, r6              ; rebuild sp          <- E1's candidate
    ADD sp, sp, #16         ; walk back over the frame (kept)
    POP {r5, r6, r7, pc}

Rebuilding sp from the base is the *safe* default: it survives a push leaked
inside one arm of an if.  When the body provably never moves sp, though, sp is
still equal to the base at every return and `MOV sp, r6` writes a value the
register already holds.  When the base is never read as a base either, the
`MOV r6, sp` that built it is dead as well.

What is checked:

  1. OFF IS OFF.  `-O2 <passes>` and the same plus `-fno-opt-exit` are
     byte-identical, as assembly text and as image.
  2. E1 FIRES.  In a function with locals the `MOV sp, <base>` lines are gone
     and the instruction count drops; a rule that never fires would still pass
     a "no growth" check, so the drop is asserted, not just the absence.
  3. E2 FIRES.  In a parameterless function the prologue `MOV <base>, sp` goes
     too, i.e. two lines per function instead of one.
  4. THE TEARDOWN STAYS.  `ADD sp, sp, #N` in front of the POP is *not* a
     no-op: sp has to walk back over the frame before the POP reads the
     callee-saved words.  The number of those lines and of `POP {..., pc}`
     must be unchanged.
  5. IT DECLINES WHEN IT MUST.  A variable-length array and an inline `sub sp`
     move the stack inside the body; those functions must come out
     byte-identical (the base is load-bearing there).
  6. THE ANSWER IS THE SAME.  A fixture mixing a recursive frame function, a
     two-return epilogue, a `void` function with no frame use and a VLA
     returns the same value in four arms and in Python.
  7. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_EXIT=0 refuses
     `-fopt-exit` by name (C3900U) instead of accepting it and doing nothing,
     and still compiles the same file without the flag.

Usage: run_exit_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import glob
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

FLAG = '-fopt-exit'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']
# The frame trimmer is what turns `MOV sp, base` into a lone epilogue line, and
# -fopt-vstack is what makes the bodies small enough to qualify; both stay in
# the arm so that the gate measures the pass in the configuration it ships in.
PASSES = ['-fopt-vstack', '-fopt-addr', '-fopt-frame']

# E1 only: locals are read and written through the base, so the base is real.
FRAMED = """\
int ex_pad_a;
static int ex_framed(int a, int b)
{
    int x = a * 3;
    int y = b + x;
    x = y - a;
    ex_pad_a = x;
    return x + y;
}
int main(void) { return ex_framed(2, 3) & 0xFF; }
"""

# E1 + E2: no parameters, no locals, no frame slot -- the base is built and
# never read, so both lines go.
NOBASE = """\
volatile int ex_sink_a;
void ex_irq(void) { ex_sink_a = 1; }
int main(void) { ex_irq(); return ex_sink_a; }
"""

# Must be left alone: the body moves sp.
STACKMOVE = """\
static int ex_vla(int n)
{
    int a[n];
    int i;
    for (i = 0; i < n; i++) a[i] = i + 1;
    return a[n - 1] + a[0];
}
static int ex_asm(void)
{
    __asm volatile ("sub sp, sp, #4" ::: "memory");
    return 1;
}
int main(void) { return (ex_vla(4) + ex_asm()) & 0xFF; }
"""

# Value: every shape the pass can meet at once, and each one returns something
# only the real computation produces.
VALUE = """\
volatile int ex_sink_b;
static int ex_acc(int n)
{
    int a = n * 3;
    int b = a + 2;
    if (n <= 0) return b;
    return b + ex_acc(n - 1);
}
static int ex_epi(int a, int b)
{
    if (a > b) { int t = a - b; return t * 2 + 1; }
    return a + b;
}
void ex_void(void) { ex_sink_b = 3; }
static int ex_vla(int n)
{
    int a[n];
    int i;
    for (i = 0; i < n; i++) a[i] = i + 1;
    return a[n - 1] + a[0];
}
int main(void)
{
    ex_void();
    return (ex_acc(3) + ex_epi(5, 2) + ex_epi(2, 5) + ex_vla(4) + ex_sink_b) & 0xFF;
}
"""

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

def build(arkcc, work, name, flags, tag):
    src = os.path.join(work, name + '.c')
    asm = os.path.join(work, '%s_%s.s' % (name, tag))
    rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src, '-o', asm]
                  + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['asm failed']
    img = os.path.join(work, '%s_%s.bin' % (name, tag))
    rc, log = run([arkcc] + IMG_ARM + ['-O2', '-I', INC, src, '-o', img]
                  + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['image failed']
    with open(asm, encoding='utf-8') as fh:
        text = fh.read()
    with open(img, 'rb') as fh:
        blob = fh.read()
    return text, blob, None

def build_asm(arkcc, work, name, flags, tag):
    """Assembly only, for fixtures whose image would not run on its own."""
    src = os.path.join(work, name + '.c')
    asm = os.path.join(work, '%s_%s.s' % (name, tag))
    rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src, '-o', asm]
                  + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['asm failed']
    with open(asm, encoding='utf-8') as fh:
        text = fh.read()
    return text, text.encode('utf-8'), None

INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')
SP_MOV_RE = re.compile(r'^\s+MOV\s+sp,\s*(r\d+)\s*$')
BASE_MOV_RE = re.compile(r'^\s+MOV\s+(r\d+),\s*sp\s*$')
TEARDOWN_RE = re.compile(r'^\s+(?:ADD|SUB)\s+sp,\s*sp,\s*#')
RETPOP_RE = re.compile(r'^\s+POP\s+\{[^}]*\bpc\b[^}]*\}')
LABEL_DEF_RE = re.compile(r'^(\.[A-Za-z0-9_.]+):', re.M)
BRANCH_REF_RE = re.compile(r'^\s+(?:B[A-Z]*|CBZ|CBNZ)\s+(\.[A-Za-z0-9_.]+)\s*$')

def func_text(text, name):
    """The assembly of one function, so the counts below are about that
    function and not about the harness (`main`, the reset handler) that the
    fixture is linked with."""
    m = re.search(r'^%s:\n(.*?)^\.size %s,' % (re.escape(name), re.escape(name)),
                  text, re.M | re.S)
    return m.group(1) if m else ''

def count(regex, text):
    return sum(1 for ln in text.splitlines() if regex.match(ln))

def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))

def dangling_labels(text):
    defs = set(LABEL_DEF_RE.findall(text))
    refs = set()
    for ln in text.splitlines():
        m = BRANCH_REF_RE.match(ln)
        if m:
            refs.add(m.group(1))
    return refs - defs

def build_arkcc(where, defines, name):
    cc = os.environ.get('CC', 'gcc')
    if not shutil.which(cc):
        return None, 'no %s on PATH' % cc
    srcs = (sorted(glob.glob('src/*.c')) +
            sorted(glob.glob('src/backend/*/*.c')) +
            ['src/backend/registry.c', 'port/host/flash_fs_host.c',
             'port/host/platform_host.c', 'port/host/debug_host.c'])
    if not srcs:
        return None, 'not run from the repository root'
    out = os.path.join(where, name + ('.exe' if os.name == 'nt' else ''))
    cmd = [cc, '-Wall', '-O2', '-std=c99', '-Wno-unused-parameter',
           '-Wno-unused-but-set-variable', '-Wno-unused-variable',
           '-Wno-unused-function', '-Iinclude'] + defines + srcs + ['-o', out]
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if p.returncode != 0:
        return None, (p.stdout.decode('utf-8', 'replace').strip().splitlines()
                      or ['build failed'])[-1][:160]
    return out, ''

# --- expected value of VALUE, computed here -------------------------------
def py_value():
    """Mirror of the C fixture, one plain function per shape."""
    def acc(n):
        a = n * 3
        b = a + 2
        if n <= 0:
            return b
        return b + acc(n - 1)
    def epi(a, b):
        if a > b:
            return (a - b) * 2 + 1
        return a + b
    def vla(n):
        a = [i + 1 for i in range(n)]
        return a[n - 1] + a[0]

    fails = [0]
    def ck(got, want):
        if got != want:
            fails[0] = (fails[0] * 31 + (got - want + 7)) & 0xFFFFFFFF
    ck(acc(3), 26)
    ck(acc(1), 7)
    ck(acc(0), 2)
    ck(epi(5, 2), 7)
    ck(epi(2, 5), 7)
    ck(vla(4), 5)
    # The mirror must agree with the hand-computed values before its answer is
    # worth comparing against the machine code.
    assert fails[0] == 0, 'the Python mirror disagrees with itself: %d' % fails[0]
    return (acc(3) + epi(5, 2) + epi(2, 5) + vla(4) + 3) & 0xFF

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_exit_')
    try:
        for name, body in (('framed', FRAMED), ('nobase', NOBASE),
                           ('stackmove', STACKMOVE), ('value', VALUE)):
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        ta, ba, e1 = build(arkcc, work, 'value', PASSES, 'plain')
        tb, bb, e2 = build(arkcc, work, 'value', PASSES + ['-fno-opt-exit'],
                           'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(ta == tb and ba == bb,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-exit)',
                  '%d/%d bytes' % (len(ba), len(bb)))

        # --- 2/3/4. E1 fires, E2 fires, the teardown stays ------------------
        for name, func, want_epilogue in (('framed', 'ex_framed', False),
                                          ('nobase', 'ex_irq', True)):
            arms = {}
            for tag, flags in (('off', PASSES),
                               ('on', PASSES + [FLAG])):
                t, blob, err = build(arkcc, work, name, flags, tag)
                if err:
                    check(False, '%s: %s arm builds' % (name, tag),
                          err[0][:120])
                    arms = None
                    break
                arms[tag] = (t, blob)
            if arms is None:
                continue

            off_t = func_text(arms['off'][0], func)
            on_t = func_text(arms['on'][0], func)
            if not off_t or not on_t:
                check(False, '%s: %s is in the assembly' % (name, func))
                continue
            n_sp_off, n_sp_on = count(SP_MOV_RE, off_t), count(SP_MOV_RE, on_t)
            n_b_off, n_b_on = count(BASE_MOV_RE, off_t), count(BASE_MOV_RE, on_t)
            n_t_off, n_t_on = count(TEARDOWN_RE, off_t), count(TEARDOWN_RE, on_t)
            n_r_off, n_r_on = count(RETPOP_RE, off_t), count(RETPOP_RE, on_t)

            check(n_sp_off > 0 and n_sp_on == 0,
                  '%s: every `MOV sp, base` is gone' % name,
                  '%d -> %d' % (n_sp_off, n_sp_on))
            check(insn_count(on_t) < insn_count(off_t),
                  '%s: instructions drop' % name,
                  '%d -> %d' % (insn_count(off_t), insn_count(on_t)))
            if want_epilogue:
                check(n_b_off > 0 and n_b_on == 0,
                      '%s: the unused frame base is not built at all' % name,
                      'MOV base,sp %d -> %d' % (n_b_off, n_b_on))
                check(insn_count(off_t) - insn_count(on_t) == 2 * n_b_off,
                      '%s: exactly two lines per function go' % name,
                      '-%d for %d functions'
                      % (insn_count(off_t) - insn_count(on_t), n_b_off))
            else:
                check(n_b_on == n_b_off,
                      '%s: a base that is really read is kept' % name,
                      'MOV base,sp %d -> %d' % (n_b_off, n_b_on))
            check(n_t_on == n_t_off and n_r_on == n_r_off,
                  '%s: the `ADD sp, sp, #N` teardown and every return POP stay'
                  % name,
                  'teardown %d/%d, ret-pop %d/%d'
                  % (n_t_off, n_t_on, n_r_off, n_r_on))
            check(len(arms['on'][1]) <= len(arms['off'][1]),
                  '%s: the image never grows' % name,
                  'off/on=%d/%d bytes'
                  % (len(arms['off'][1]), len(arms['on'][1])))
            check(not dangling_labels(on_t),
                  '%s: every branch target is defined' % name)

        # --- 5. it declines when the body moves sp --------------------------
        st_on, sblob_on, serr_on = build_asm(arkcc, work, 'stackmove',
                                             PASSES + [FLAG], 'on')
        st_off, sblob_off, serr_off = build_asm(arkcc, work, 'stackmove',
                                                PASSES, 'off')
        if serr_on or serr_off:
            check(False, 'the stack-moving fixture builds',
                  (serr_on or serr_off)[0][:120])
        else:
            check(st_on == st_off and sblob_on == sblob_off,
                  'a body that adjusts sp (VLA, inline `sub sp`) is left '
                  'byte-identical',
                  'on/off=%d/%d bytes' % (len(sblob_on), len(sblob_off)))

        # --- 6. the answer is the same --------------------------------------
        want = py_value()
        arms = {}
        for tag, flags in (('base', []),
                           ('off', PASSES),
                           ('on', PASSES + [FLAG]),
                           ('all', PASSES + ['-fopt-cbranch', '-fopt-live',
                                             '-fopt-vreg', '-fopt-boolmat',
                                             FLAG])):
            t, blob, err = build(arkcc, work, 'value', flags, tag)
            if err:
                check(False, 'value: %s arm builds' % tag, err[0][:120])
                arms = None
                break
            arms[tag] = (t, blob)
        if arms is not None:
            if not HAVE_UNICORN:
                skip('value: emulator value', 'python package unicorn missing')
            else:
                got, ok = {}, True
                for tag in ('base', 'off', 'on', 'all'):
                    st, val, _ = run_image(arms[tag][1])
                    if st != 'returned':
                        check(False, 'value: %s arm returns' % tag, st)
                        ok = False
                        break
                    got[tag] = val
                if ok:
                    check(all(v == want for v in got.values()),
                          'value: every arm returns %d (Python agrees)' % want,
                          ' '.join('%s=%s' % (k, got[k]) for k in
                                   ('base', 'off', 'on', 'all')))

        # --- 7. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_EXIT=0'],
                                   'arkcc_noex')
        if trimmed is None:
            skip('a cropped build refuses -fopt-exit', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'value.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-exit by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'value.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
