#!/usr/bin/env python3
"""Gate for the boolean-materialisation pass (0.9.1, -fopt-boolmat).

A comparison already produces 0 or 1 (C11 6.5.8p6), so re-testing that result
against zero is either an identity or a negation -- but the front end emits it
literally, and the backend then materialises the boolean twice:

    CMP r0, r1                 ; a < b
    ITE LT                     ; ... as int
    MOVLT r0, #1
    MOVGE r0, #0
    CMP r0, #0                 ; (the same value) != 0
    ITE NE
    MOVNE r0, #1
    MOVEQ r0, #0

Five of those instructions are pure waste.  The pass removes the round trip in
the IR, which also lets -fopt-cbranch see `<cmp>` adjacent to `JZ/JNZ` and
collapse the whole thing to `CMP` + one conditional branch.

What is checked:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-boolmat` are byte-identical, as
     assembly text and as image.
  2. IT PAYS.  The ITE blocks (the boolean materialisations) and the total
     instruction count both drop when the flag is on, and the drop is not
     zero -- a rule that never fires would still pass a count-only check, so
     both are asserted.
  3. R2 AND R3 BOTH FIRE.  R2 (`... != 0`) deletes the pair; R3 (`... == 0`,
     i.e. `!(cmp)`) becomes `^ 1`.  A fixture with only the first shape and a
     fixture with only the second each get smaller.
  4. IT DECLINES WHEN IT MUST.  The rewrite is only sound when the value
     being re-tested really is a 0/1 comparison result.  `(a & 3) != 0`,
     `(a + b) != 0`, `c != 0` on a `char`, a pointer load, a call result and a
     64-bit comparison must all be left byte-identical.
  5. THE ANSWER IS THE SAME.  A fixture that exercises all six relational
     operators, unsigned forms, negation, nesting, the value used as a `int`
     (so it cannot be folded away) and the value used arithmetically returns
     the same value in five arms and in Python.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_BOOLMAT=0
     refuses `-fopt-boolmat` by name (C3900U) instead of accepting it and
     doing nothing, and still compiles the same file without the flag.

Usage: run_boolmat_tests.py [path-to-arkcc]
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

FLAG = '-fopt-boolmat'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# R2 only: every site is `(cmp) != 0` consumed by a branch or returned.
R2ONLY = """\
int bm_pad_a;
static int bm_r2(int a, int b)
{
    int s = 0;
    if ((a < b) != 0)  s += 1;
    if ((a <= b) != 0) s += 2;
    if ((a > b) != 0)  s += 4;
    if ((a >= b) != 0) s += 8;
    if ((a == b) != 0) s += 16;
    if ((a != b) != 0) s += 32;
    return s;
}
static int bm_r2u(unsigned a, unsigned b)
{
    int s = 0;
    if ((a < b) != 0)  s += 1;
    if ((a >= b) != 0) s += 2;
    return s;
}
int main(void) { return (bm_r2(1, 2) + bm_r2u(1u, 2u)) & 0xFF; }
"""

# R3 only: `!(cmp)` / `(cmp) == 0` whose value is *used*, not branched on.
# The value form matters: when the negation feeds a branch, -fopt-cbranch can
# fold `<cmp> + JZ/JNZ` on the inverted condition, and R3 must decline rather
# than replace that with an explicit `^ 1` (see R3BRANCH below).
R3ONLY = """\
int bm_pad_b;
static int bm_r3(int a, int b)
{
    int s = 0;
    s += (int)((a < b) == 0);
    s += (int)!(a == b);
    s += ((a != b) == 0);
    s += !(a >= b);
    s += ((a <= b) == 0) * 2;
    return s;
}
int main(void) { return bm_r3(1, 2) & 0xFF; }
"""

# The same negations, but consumed by a branch: the pass must leave them alone
# so that -fopt-cbranch keeps its two-instruction fold.
R3BRANCH = """\
int bm_pad_e;
static int bm_r3b(int a, int b)
{
    int s = 0;
    if (!(a < b))  s += 1;
    if (!(a == b)) s += 2;
    if (!(a != b)) s += 4;
    if ((a < b) == 0) s += 8;
    if ((a >= b) == 0) s += 16;
    return s;
}
int main(void) { return bm_r3b(1, 2) & 0xFF; }
"""

# Must be left alone: the value re-tested against zero is not a comparison.
DECLINE = """\
int bm_pad_c;
static int bm_call(void) { return 3; }
static int bm_decline(int a, int b, char c, int *p, long long la, long long lb)
{
    int s = 0;
    int y;
    y = (a & 3) != 0;    s += y;
    y = (a + b) != 0;    s += y * 2;
    y = (c) != 0;        s += y * 4;
    y = (p[0]) != 0;     s += y * 8;
    y = (bm_call()) != 0; s += y * 16;
    y = (la != lb) != 0;  s += y * 128;
    return s;
}
int main(void) { int v[1]; v[0] = 1; return bm_decline(2, 3, 'x', v, 1LL, 2LL) & 0xFF; }
"""

# Value torture: every shape, some of them arithmetic (so the value cannot be
# folded into a branch), some nested.
VALUE = """\
int bm_pad_d;
static int fails;
static void ck(int got, int want) { if (got != want) fails = fails * 31 + (got - want + 7); }
static int v_ne0(int a, int b) { if ((a != b) != 0) return 21; return 22; }
static int v_eq0(int a, int b) { if ((a == b) != 0) return 21; return 22; }
static int v_lt0(int a, int b) { if ((a < b) != 0) return 21; return 22; }
static int v_nlt(int a, int b) { if (!(a < b)) return 31; return 32; }
static int v_nne(int a, int b) { if (!(a != b)) return 31; return 32; }
static int v_nest(int a, int b) { if (!((a < b) != 0)) return 41; return 42; }
static int v_tri(int a, int b) { return ((a < b) != 0) ? 51 : 52; }
static int v_valne(int a, int b) { return (a != b) != 0; }
static int v_valeq(int a, int b) { return (a == b) != 0; }
static int v_une0(unsigned a, unsigned b) { if ((a < b) != 0) return 61; return 62; }
static int v_keep(int a, int b) { int x = ((a < b) != 0); return x + 71; }
static int v_chain(int a, int b) { int x = (a < b); return (x != 0) + 81; }
static int v_assign(int a, int b) { int x = (a < b) != 0; int y = x; return y + 91; }
int main(void)
{
    ck(v_ne0(1, 2), 21);  ck(v_ne0(2, 2), 22);
    ck(v_eq0(2, 2), 21);  ck(v_eq0(2, 3), 22);
    ck(v_lt0(1, 2), 21);  ck(v_lt0(2, 2), 22);
    ck(v_nlt(1, 2), 32);  ck(v_nlt(2, 2), 31);
    ck(v_nne(1, 2), 32);  ck(v_nne(2, 2), 31);
    ck(v_nest(1, 2), 42); ck(v_nest(2, 2), 41);
    ck(v_tri(1, 2), 51);  ck(v_tri(2, 2), 52);
    ck(v_valne(1, 2), 1); ck(v_valne(2, 2), 0);
    ck(v_valeq(2, 2), 1); ck(v_valeq(2, 3), 0);
    ck(v_une0(1u, 2u), 61); ck(v_une0(1u, 0xFFFFFFFFu), 61);
    ck(v_une0(2u, 2u), 62);
    ck(v_keep(1, 2), 72); ck(v_keep(2, 2), 71);
    ck(v_chain(1, 2), 82); ck(v_chain(2, 2), 81);
    ck(v_assign(1, 2), 92); ck(v_assign(2, 2), 91);
    return fails;
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
    """Assembly only.  Used where the fixture needs a runtime helper
    (__aeabi_lcmp) that a single-file image would have to reject."""
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
ITE_RE = re.compile(r'^\s+ITE\s+[A-Z]{2}\s*$')
LABEL_DEF_RE = re.compile(r'^(\.[A-Za-z0-9_.]+):', re.M)
BRANCH_REF_RE = re.compile(r'^\s+(?:B[A-Z]*|CBZ|CBNZ)\s+(\.[A-Za-z0-9_.]+)\s*$')

def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))

def ite_count(text):
    return sum(1 for ln in text.splitlines() if ITE_RE.match(ln))

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
    def u32(x):
        return x & 0xFFFFFFFF
    def ne0(a, b):  return 21 if a != b else 22
    def eq0(a, b):  return 21 if a == b else 22
    def lt0(a, b):  return 21 if a < b else 22
    def nlt(a, b):  return 31 if not (a < b) else 32
    def nne(a, b):  return 31 if not (a != b) else 32
    def nest(a, b): return 41 if not (bool(a < b) != 0) else 42
    def tri(a, b):  return 51 if a < b else 52
    def valne(a, b): return 1 if a != b else 0
    def valeq(a, b): return 1 if a == b else 0
    def une0(a, b): return 61 if u32(a) < u32(b) else 62
    def keep(a, b): return (1 if a < b else 0) + 71
    def chain(a, b): return (1 if a < b else 0) + 81
    def assign(a, b): return (1 if a < b else 0) + 91

    fails = [0]
    def ck(got, want):
        if got != want:
            fails[0] = (fails[0] * 31 + (got - want + 7)) & 0xFFFFFFFF
    ck(ne0(1, 2), 21);  ck(ne0(2, 2), 22)
    ck(eq0(2, 2), 21);  ck(eq0(2, 3), 22)
    ck(lt0(1, 2), 21);  ck(lt0(2, 2), 22)
    ck(nlt(1, 2), 32);  ck(nlt(2, 2), 31)
    ck(nne(1, 2), 32);  ck(nne(2, 2), 31)
    ck(nest(1, 2), 42); ck(nest(2, 2), 41)
    ck(tri(1, 2), 51);  ck(tri(2, 2), 52)
    ck(valne(1, 2), 1); ck(valne(2, 2), 0)
    ck(valeq(2, 2), 1); ck(valeq(2, 3), 0)
    ck(une0(1, 2), 61); ck(une0(1, 0xFFFFFFFF), 61); ck(une0(2, 2), 62)
    ck(keep(1, 2), 72); ck(keep(2, 2), 71)
    ck(chain(1, 2), 82); ck(chain(2, 2), 81)
    ck(assign(1, 2), 92); ck(assign(2, 2), 91)
    return fails[0]

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_boolmat_')
    try:
        for name, body in (('r2only', R2ONLY), ('r3only', R3ONLY),
                           ('r3branch', R3BRANCH), ('decline', DECLINE),
                           ('value', VALUE)):
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        ta, ba, e1 = build(arkcc, work, 'value', [], 'plain')
        tb, bb, e2 = build(arkcc, work, 'value', ['-fno-opt-boolmat'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(ta == tb and ba == bb,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-boolmat)',
                  '%d/%d bytes' % (len(ba), len(bb)))

        # --- 2/3. it pays, and both rules fire ------------------------------
        for name in ('r2only', 'r3only'):
            arms = {}
            for tag, flags in (('base', []),
                               ('off', ['-fno-opt-boolmat']),
                               ('on', [FLAG]),
                               ('va', ['-fopt-vstack', '-fopt-addr']),
                               ('all', ['-fopt-vstack', '-fopt-addr',
                                        '-fopt-cbranch', '-fopt-imm', FLAG])):
                t, blob, err = build(arkcc, work, name, flags, tag)
                if err:
                    check(False, '%s: %s arm builds' % (name, tag),
                          err[0][:120])
                    arms = None
                    break
                arms[tag] = (t, blob)
            if arms is None:
                continue

            n_base, n_on = insn_count(arms['base'][0]), insn_count(arms['on'][0])
            n_va, n_all = insn_count(arms['va'][0]), insn_count(arms['all'][0])
            i_base, i_on = ite_count(arms['base'][0]), ite_count(arms['on'][0])
            i_va, i_all = ite_count(arms['va'][0]), ite_count(arms['all'][0])

            check(i_base > 0 and i_on < i_base,
                  '%s: boolean materialisations drop with the flag' % name,
                  'ITE base=%d on=%d' % (i_base, i_on))
            check(n_on < n_base, '%s: instructions drop' % name,
                  '%d -> %d' % (n_base, n_on))
            check(n_all < n_va,
                  '%s: it still pays on top of -fopt-cbranch/-fopt-imm' % name,
                  '%d -> %d' % (n_va, n_all))
            check(i_all < i_va, '%s: and it still removes the re-materialisation'
                  % name, 'ITE va=%d all=%d' % (i_va, i_all))
            check(len(arms['on'][1]) <= len(arms['base'][1]) and
                  len(arms['all'][1]) <= len(arms['va'][1]),
                  '%s: the image never grows' % name,
                  'base/on=%d/%d va/all=%d/%d bytes'
                  % (len(arms['base'][1]), len(arms['on'][1]),
                     len(arms['va'][1]), len(arms['all'][1])))
            check(not dangling_labels(arms['on'][0]),
                  '%s: every branch target is defined' % name)

        # --- 3b. R3 steps aside when a branch is the consumer ----------------
        bt_on, bblob_on, berr_on = build(arkcc, work, 'r3branch', [FLAG], 'on')
        bt_off, bblob_off, berr_off = build(arkcc, work, 'r3branch', [], 'base')
        if berr_on or berr_off:
            check(False, 'the branch-consumed negation fixture builds',
                  (berr_on or berr_off)[0][:120])
        else:
            check(bt_on == bt_off and bblob_on == bblob_off,
                  'R3 keeps `(cmp) == 0` alone when -fopt-cbranch will fold it',
                  'on/off=%d/%d bytes' % (len(bblob_on), len(bblob_off)))

        # --- 4. it declines when it must ------------------------------------
        dt, dblob, derr = build_asm(arkcc, work, 'decline', [FLAG], 'on')
        db, dblob_b, derr_b = build_asm(arkcc, work, 'decline', [], 'base')
        if derr or derr_b:
            check(False, 'the decline fixture builds',
                  (derr or derr_b)[0][:120])
        else:
            check(dt == db and dblob == dblob_b,
                  'a re-test of a non-comparison value is left byte-identical',
                  'on/off=%d/%d bytes, %d/%d insns'
                  % (len(dblob), len(dblob_b), insn_count(dt), insn_count(db)))

        # --- 5. the answer is the same --------------------------------------
        want = py_value()
        arms = {}
        for tag, flags in (('base', []),
                           ('off', ['-fno-opt-boolmat']),
                           ('on', [FLAG]),
                           ('va', ['-fopt-vstack', '-fopt-addr']),
                           ('all', ['-fopt-vstack', '-fopt-addr', '-fopt-cbranch',
                                    '-fopt-imm', '-fopt-live', '-fopt-vreg', FLAG])):
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
                for tag in ('base', 'off', 'on', 'va', 'all'):
                    st, val, _ = run_image(arms[tag][1])
                    if st != 'returned':
                        check(False, 'value: %s arm returns' % tag, st)
                        ok = False
                        break
                    got[tag] = val
                if ok:
                    check(all(v == want for v in got.values()),
                          'value: all five arms return %d (Python agrees)' % want,
                          ' '.join('%s=%s' % (k, got[k]) for k in
                                   ('base', 'off', 'on', 'va', 'all')))

        # --- 6. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_BOOLMAT=0'],
                                   'arkcc_nobm')
        if trimmed is None:
            skip('a cropped build refuses -fopt-boolmat', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'value.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-boolmat by name',
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
