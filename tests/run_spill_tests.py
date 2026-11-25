#!/usr/bin/env python3
"""Gate for cross-block stack round-trip elimination (0.9.1-wip, -fopt-spill).

The ARM backend materialises every intermediate value on the stack: `PUSH {rN}`
then `POP {rN}`.  Across a *block* boundary that is pure waste -- a `?:` emits

    CBZ  r0, .Lelse
    MOV  r0, #11
    PUSH {r0}          ; arm A
    B    .Lmerge
.Lelse:
    MOV  r0, #22
    PUSH {r0}          ; arm B
.Lmerge:
    POP  {r0}          ; both arms pop the same register

and the value never leaves r0, so all three instructions exist only to move a
register to memory and back.  The pass proves, per push, that *every* path
leaving it reaches a POP of the same register (and that the register is not
written in between), then deletes the matching push/pop pairs.

The proof is what makes this different from "delete any PUSH whose next
statement is a POP": a wrong implementation deletes a push whose value is
clobbered on one arm and the program then returns a wrong answer silently.
So the gate checks the *negative* cases with the same weight as the positive:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-spill` are byte-identical (assembly
     and image) on both a deletable and a non-deletable fixture.
  2. IT PAYS, AND ONLY BY DELETION.  On the diamond fixture the flag must
     lower the instruction count, add no line at all, remove only PUSH/POP
     lines, remove an equal-or-greater number of PUSHes than POPs, leave no
     `PUSH {rX}` / `POP {rX}` pair behind, and never grow the image.
  3. A CLOBBERED VALUE IS KEPT.  A diamond whose pushed register is written by
     a load before the POP must come out byte-identical (and the fixture is
     asserted to *contain* such a pair, so the check cannot pass vacuously).
  4. A POP OF ANOTHER REGISTER IS KEPT.  `PUSH {r5}` / `POP {ip}` (a function
     pointer call) and `PUSH {r0}` ... `POP {r1}` must stay.
  5. THE ANSWER IS THE SAME.  Both fixtures return the Python-computed value on
     the emulator in the off and on arms.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_SPILL=0 refuses
     `-fopt-spill` by name (C3900U) and still compiles the file without it.

Usage: run_spill_tests.py [path-to-arkcc]
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

FLAG = '-fopt-spill'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# The pass is measured on the shipped 0.9.1 flag set (the "sw" set frozen in
# docs/BUILD.md section 5.2), because that is the pipeline it ships in and the
# only one in which the back end emits the cross-block PUSH/POP shapes it is
# meant to remove.  A second, smaller section runs a naive `-O2 -fopt-live`
# build to show the pass also cleans up adjacent same-register pairs.
FULL = ['-O2', '-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
        '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
        '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop', '-fopt-slotreg',
        '-fopt-strength', '-fopt-vstack', '-fopt-vreg', '-fopt-cmat',
        '-fopt-pair', '-fopt-litpool', '-fopt-frame', '-fopt-voldmb',
        '-fopt-constcond', '-fopt-boolmat', '-fopt-exit', '-fopt-bitmask']
BASE = ['-O2', '-fopt-live']

# --- fixtures ---------------------------------------------------------------
# Two diamond merges inside one expression: each `?:` pushes in both arms and
# pops at the merge, so both arms are deletable.
DIAMOND = """\
int sp_pad_d;
static int diamond(int a, int b)
{
    int z = ((a & 1) ? 11 : 22) * 3 + ((b & 2) ? 33 : 44);
    return z + (a ^ b);
}
int main(void) { return diamond(5, 6) & 0xFF; }
"""

# A diamond whose pushed value is clobbered before the merge: the `g` call
# result is popped first, and the diamond's value survives two loads that write
# r0.  Every push here has to stay, so the whole function is byte-identical.
CLOBBER = """\
int sp_pad_c;
int sp_g = 6;
static int g(int x) { return x * 7 + 1; }
static int keep(int a)
{
    int z = ((a & 1) ? 11 : 22) + g(sp_g);
    return z + (a & 3);
}
int main(void) { return keep(5) & 0xFF; }
"""

# A function-pointer call: `PUSH {r5}` / `POP {ip}` pops a different register,
# and the `PUSH {r0}` around the call is popped into r0 after r0 was written by
# the loads.  Nothing may go.
CALLPTR = """\
int sp_pad_p;
static int inc(int a) { return a + 1; }
static int callit(int (*fp)(int), int a, int b)
{
    int s = ((a & 1) ? 1 : 2);
    s = fp(s);
    return s * (a - b + 2);
}
int main(void) { return callit(inc, 4, 1) & 0xFF; }
"""

# A diamond inside a function that also makes the back end emit a `BIC`:
# `x &= ~0x10000u` on a volatile word, under -fopt-cmat, materialises the mask
# as `BIC rD, rS, #imm` instead of `MVN` + `AND`.  The mnemonic starts with a
# 'B', so a branch classifier that only looks at the first letter reads BIC as
# a conditional branch, cannot resolve its operand `#0x10000` as a label, and
# the whole function loses its analysis -- a silent precision loss, never a
# wrong answer.  Measured (bail-reason census, 95 corpus units, 2026-11-25):
# 29 units bailed with `tgt-missing mn=BIC op2=[#0x10000]`, 93 candidate PUSH
# lines thrown away, and the live pass also lost 29 instructions corpus-wide.
# The check below is the anti-regression half: the fixture must really contain
# a BIC *and* its diamond must still be deleted.
BICMIX = """\
volatile unsigned sp_bic_reg;
int sp_pad_b;
static int bicmix(int a, int b)
{
    int z = ((a & 1) ? 11 : 22) * 3 + ((b & 2) ? 33 : 44);
    sp_bic_reg = sp_bic_reg & ~0x10000u;
    return z + a;
}
int main(void) { return bicmix(5, 6) & 0xFF; }
"""

def py_diamond(a=5, b=6):
    z = (11 if (a & 1) else 22) * 3 + (33 if (b & 2) else 44)
    return (z + (a ^ b)) & 0xFF

def py_clobber(a=5):
    return (((11 if (a & 1) else 22) + (6 * 7 + 1)) + (a & 3)) & 0xFF

def py_bicmix(a=5, b=6):
    z = (11 if (a & 1) else 22) * 3 + (33 if (b & 2) else 44)
    return (z + a) & 0xFF

def py_callptr(a=4, b=1):
    s = (1 if (a & 1) else 2)
    s = s + 1
    return (s * (a - b + 2)) & 0xFF

CASES = [
    ('diamond', DIAMOND, py_diamond()),
    ('clobber', CLOBBER, py_clobber()),
    ('callptr', CALLPTR, py_callptr()),
    ('bicmix', BICMIX, py_bicmix()),
]

PAYS = 'diamond'
KEEPS = ('clobber', 'callptr')

INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')
STKP_RE = re.compile(r'^\s+(PUSH|POP)\s+\{')
PAIR_RE = re.compile(r'^\s+PUSH\s+\{(\w+)\}\s*$')

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

def build(arkcc, work, name, flags, tag, base=None):
    """Compile one fixture twice: assembly text and a bootable image."""
    src = os.path.join(work, name + '.c')
    base = FULL if base is None else base
    asm = os.path.join(work, '%s_%s.s' % (name, tag))
    rc, log = run([arkcc] + ASM_ARM + base + ['-I', INC, src, '-o', asm] +
                  list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['asm failed']
    img = os.path.join(work, '%s_%s.bin' % (name, tag))
    rc, log = run([arkcc] + IMG_ARM + base + ['-I', INC, src, '-o', img] +
                  list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['image failed']
    with open(asm, encoding='utf-8') as fh:
        text = fh.read()
    with open(img, 'rb') as fh:
        blob = fh.read()
    return text, blob, None

def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))

def stack_ops(text):
    return sum(1 for ln in text.splitlines() if STKP_RE.match(ln))

def stack_pairs(text):
    """Adjacent `PUSH {rX}` / `POP {rX}` on the same register."""
    lines = text.splitlines()
    n = 0
    for i, ln in enumerate(lines[:-1]):
        m = PAIR_RE.match(ln)
        if not m:
            continue
        if re.match(r'^\s+POP\s+\{%s\}\s*$' % m.group(1), lines[i + 1]):
            n += 1
    return n

FIRST_OPERAND_WRITE = re.compile(r'^\s+[A-Z][A-Z0-9.]*\s+(%s)\b')

def clobbered_push(text, reg):
    """True when some `PUSH {reg}` is followed (before a `POP {reg}`) by an
    instruction whose first operand is `reg` -- i.e. the pushed value is
    overwritten, so deleting the pair would change the answer."""
    lines = text.splitlines()
    pushat = re.compile(r'^\s+PUSH\s+\{.*\b%s\}\s*$' % reg)
    popat = re.compile(r'^\s+POP\s+\{.*\b%s\}\s*$' % reg)
    writ = re.compile(r'^\s+[A-Z][A-Z0-9.]*\s+%s\s*,' % reg)
    for i, ln in enumerate(lines):
        if not pushat.match(ln):
            continue
        for ln2 in lines[i + 1:]:
            if popat.match(ln2):
                break
            if writ.match(ln2):
                return True
    return False

def removed_and_added(a, b):
    """Line diff (a = before, b = after) without needing difflib on Windows."""
    import difflib
    removed, added = [], []
    for ln in difflib.unified_diff(a.splitlines(), b.splitlines(),
                                   lineterm='', n=0):
        if ln.startswith('---') or ln.startswith('+++') or ln.startswith('@@'):
            continue
        if ln.startswith('-'):
            removed.append(ln[1:])
        elif ln.startswith('+'):
            added.append(ln[1:])
    return removed, added

def build_arkcc(where, defines, name):
    cc = os.environ.get('CC', 'gcc')
    if not shutil.which(cc):
        return None, 'no %s on PATH' % cc
    srcs = (sorted(glob.glob('src/*.c')) +
            sorted(glob.glob('src/backend/*/*.c')) +
            ['src/backend/registry.c', 'port/host/flash_fs_host.c',
             'port/host/platform_host.c', 'port/host/debug_host.c'])
    if not srcs or not os.path.exists('include/common.h'):
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

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_spill_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        for name in ('diamond', 'clobber'):
            ta, ba, e1 = build(arkcc, work, name, [], 'plain')
            tb, bb, e2 = build(arkcc, work, name, ['-fno-opt-spill'], 'nofl')
            if e1 or e2:
                check(False, '%s: the default build compiles' % name,
                      (e1 or e2)[0][:120])
                continue
            check(ta == tb and ba == bb,
                  '%s: the default build ignores the pass' % name,
                  'asm %d/%d bytes, image %d/%d bytes' %
                  (len(ta), len(tb), len(ba), len(bb)))

        # --- 2. it pays, and only by deletion -------------------------------
        off = {}
        on = {}
        for name, body, _ in CASES:
            off[name] = build(arkcc, work, name, [], 'off')
            on[name] = build(arkcc, work, name, [FLAG], 'on')
            if off[name][2] or on[name][2]:
                check(False, '%s: both arms build' % name,
                      (off[name][2] or on[name][2])[0][:120])

        if not off['diamond'][2] and not on['diamond'][2]:
            t_off, b_off = off['diamond'][0], off['diamond'][1]
            t_on, b_on = on['diamond'][0], on['diamond'][1]
            n_off, n_on = insn_count(t_off), insn_count(t_on)
            removed, added = removed_and_added(t_off, t_on)
            check(n_on < n_off, 'diamond: instructions drop',
                  '%d -> %d (-%d)' % (n_off, n_on, n_off - n_on))
            check(not added, 'diamond: the pass only deletes',
                  '%d added line(s)' % len(added))
            non_stk = [l for l in removed if not STKP_RE.match(l)]
            check(removed and not non_stk,
                  'diamond: every removed line is a PUSH/POP',
                  '%d removed, off-shape %s' % (len(removed), non_stk[:2] or 'none'))
            n_push = sum(1 for l in removed if l.strip().startswith('PUSH'))
            n_pop = sum(1 for l in removed if l.strip().startswith('POP'))
            check(n_push >= n_pop and n_pop > 0,
                  'diamond: pushes and pops both go',
                  '%d PUSH / %d POP' % (n_push, n_pop))
            check(stack_ops(t_on) < stack_ops(t_off),
                  'diamond: the PUSH/POP count drops',
                  '%d -> %d' % (stack_ops(t_off), stack_ops(t_on)))
            check(stack_pairs(t_on) == 0,
                  'diamond: no half-deleted same-register pair survives',
                  '%d adjacent pair(s) after the pass' % stack_pairs(t_on))
            check(len(b_on) <= len(b_off),
                  'diamond: the image never grows',
                  '%d -> %d bytes' % (len(b_off), len(b_on)))

        # --- 2b. a BIC in the function must not stop the analysis -----------
        if not off['bicmix'][2] and not on['bicmix'][2]:
            t_off, t_on = off['bicmix'][0], on['bicmix'][0]
            removed, added = removed_and_added(t_off, t_on)
            check('BIC ' in t_off,
                  'bicmix: the fixture really makes the back end emit a BIC',
                  '%d BIC line(s)' % t_off.count('BIC '))
            check(bool(removed) and not added and
                  all(STKP_RE.match(l) for l in removed),
                  'bicmix: a function containing a BIC is still analysed',
                  '%d removed (%s)' % (len(removed),
                                       removed[:1] if removed else 'none'))

        # --- 1b. the same pass on a naive pipeline --------------------------
        # An `-O2 -fopt-live` build has not been through vstack/vreg, so the
        # back end leaves plain adjacent `PUSH {r0}` / `POP {r0}` pairs behind
        # (a value stored and immediately reloaded).  Those are the simplest
        # case the pass handles, and deleting them must still not add a line
        # and must not change a non-PUSH/POP line.
        na_off = build(arkcc, work, 'clobber', [], 'naoff', BASE)
        na_on = build(arkcc, work, 'clobber', [FLAG], 'naon', BASE)
        if na_off[2] or na_on[2]:
            check(False, 'naive: both arms build', (na_off[2] or na_on[2])[0][:120])
        else:
            rm, ad = removed_and_added(na_off[0], na_on[0])
            bad = [l for l in rm if not STKP_RE.match(l)]
            check(rm and not ad and not bad,
                  'naive: only PUSH/POP lines are deleted, nothing is added',
                  '%d removed (%s), %d added' %
                  (len(rm), 'all push/pop' if not bad else bad[:2], len(ad)))
            check(insn_count(na_on[0]) < insn_count(na_off[0]),
                  'naive: the instruction count drops',
                  '%d -> %d' % (insn_count(na_off[0]), insn_count(na_on[0])))
            if not HAVE_UNICORN:
                skip('naive: emulator value', 'python package unicorn missing')
            else:
                st1, v1, _ = run_image(na_off[1])
                st2, v2, _ = run_image(na_on[1])
                check(st1 == st2 == 'returned' and v1 == v2 == py_clobber(),
                      'naive: off/on both return %d' % py_clobber(),
                      'off=%s on=%s' % (v1, v2))

        # --- 3/4. the negative cases are untouched --------------------------
        for name in KEEPS:
            if off[name][2] or on[name][2]:
                continue
            t_off, t_on = off[name][0], on[name][0]
            check(t_off == t_on,
                  '%s: byte-identical (a value that must be kept is kept)' % name,
                  '%d/%d bytes' % (len(t_off), len(t_on)))
        if not off['clobber'][2] and not on['clobber'][2]:
            check(clobbered_push(off['clobber'][0], 'r0'),
                  'clobber: the fixture really pushes a register it later writes',
                  'PUSH {r0} ... write r0 ... POP {r0} present')
        if not off['callptr'][2] and not on['callptr'][2]:
            txt = off['callptr'][0]
            check('POP {ip}' in txt and '{r5}' in txt and
                  clobbered_push(txt, 'r0'),
                  'callptr: the fixture really has a cross-register pop and a clobber',
                  'POP {ip} and PUSH {r0}..write..POP {r0} present')

        # --- 5. the answer is the same --------------------------------------
        for name, body, want in CASES:
            if off[name][2] or on[name][2]:
                continue
            if not HAVE_UNICORN:
                skip('%s: emulator value' % name, 'python package unicorn missing')
                continue
            got = {}
            ok = True
            for tag in ('off', 'on'):
                st, val, _ = run_image((off if tag == 'off' else on)[name][1])
                if st != 'returned':
                    check(False, '%s: %s arm returns' % (name, tag), st)
                    ok = False
                    break
                got[tag] = val
            if ok:
                check(all(v == want for v in got.values()),
                      '%s: off/on both return %d' % (name, want),
                      'off=%s on=%s' % (got['off'], got['on']))

        # --- 6. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_SPILL=0'],
                                   'arkcc_nospill')
        if trimmed is None:
            skip('a cropped build refuses -fopt-spill', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + BASE + ['-I', INC,
                          os.path.join(work, 'diamond.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-spill by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed, '-S'] + ASM_ARM + BASE + ['-I', INC,
                          os.path.join(work, 'diamond.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    rc = main()
    if failures:
        print('\nspill: %d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
    else:
        print('\nspill: all checks passed%s' % (
            (' (%d skipped)' % len(skips)) if skips else ''))
    sys.exit(rc)