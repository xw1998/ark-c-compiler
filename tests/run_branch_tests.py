#!/usr/bin/env python3
"""Gate for the short-branch pass (0.9.1, -fopt-branch).

op_size_a() sizes every B/B<cond> at 4 bytes: a 16-bit branch whose offset
does not fit truncates silently, and that is how a loop back-edge once jumped
into the middle of an instruction.  The backend is right to be conservative by
default.  `-fopt-branch` measures the function once at 4 bytes per branch,
marks the sites whose target is inside the 16-bit range, and has pass 2 emit
the two-byte form for exactly those.  It is opt-in like every other 0.9.x
pass: without the flag the output is byte-identical.

What is checked:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-branch` are byte-identical, as
     assembly text and as image.
  2. IT PAYS, AND ONLY IN WIDTH.  A tight loop plus a small `if` gets smaller,
     the instruction count is unchanged (this is a width change, not a
     rewrite), and the saving is a positive even number of bytes.
  3. IT DECLINES WHEN IT MUST.  A conditional target more than 256 bytes away
     and an unconditional target more than 2048 bytes away keep their 32-bit
     forms.  Every image also carries the arkcc runtime helpers (the globals
     zeroing loop and the memcpy loop), which do own a handful of genuinely
     short branches; a minimal reference program measures exactly that
     baseline saving, and the far fixtures must not save a single byte more.
  4. THE ANSWER IS THE SAME.  Every fixture returns the value computed here in
     Python on the emulator, in five arms; a wrong offset would take the wrong
     path (or fetch from the middle of an instruction).
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_BRANCH=0 refuses
     `-fopt-branch` by name (C3900U) instead of accepting it and doing
     nothing, and still compiles the same file without the flag.

Usage: run_branch_tests.py [path-to-arkcc]
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

FLAG = '-fopt-branch'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

NEAR = """\
int br_pad_n;
static int near_fn(int n)
{
    int s = 0, i;
    for (i = 0; i < n; i++) s += i;
    if (s > 20) s -= 3;
    return s;
}
int main(void) { return near_fn(10) & 0xFF; }
"""

# A loop over 200 statements: each `s += k` is a load, an add and a store, so
# both the exit test (past T1's 256 bytes) and the back-edge (past T2's 2048
# bytes) are out of range.  200 rather than 100 because -fopt-vstack makes a
# statement three times shorter, and the body has to stay past T2 in that arm
# too.  A plain `if` looks simpler but its body ends in a zero-offset jump to
# the join point, and shrinking that one is correct.
FAR_STMTS = '\n'.join('        s += %d;' % (i + 1) for i in range(200))
FAR = """\
int br_pad_f;
static int far_fn(int n)
{
    int s = 0;
    while (n) {
%s
        n--;
    }
    return s;
}
int main(void) { return far_fn(1) & 0xFF; }
""" % FAR_STMTS

# The same idea for the unconditional branch: a 300-statement loop body puts
# the back-edge past the 2048-byte T2 range, and the exit test past T1 too.
VFAR_STMTS = '\n'.join('        s += %d;' % (i + 1) for i in range(300))
VFAR = """\
int br_pad_v;
static int vfar_fn(int n)
{
    int s = 0, i;
    for (i = 0; i < n; i++) {
%s
    }
    return s;
}
int main(void) { return vfar_fn(1) & 0xFF; }
""" % VFAR_STMTS


# Reference program for the "keep" cases: it contains no user branch at all,
# so whatever the flag saves here is the runtime helpers alone.
MINI = """\
int br_pad_m;
int main(void) { return 7; }
"""

def py_near():
    s = 0
    for i in range(10):
        s += i
    if s > 20:
        s -= 3
    return s & 0xFF


def py_far():
    return sum(range(1, 201)) & 0xFF


def py_vfar():
    return sum(range(1, 301)) & 0xFF


CASES = [
    ('near', NEAR, py_near(), 'shrink'),
    ('far', FAR, py_far(), 'keep'),
    ('vfar', VFAR, py_vfar(), 'keep'),
]

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
    rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src, '-o', asm] + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['asm failed']
    img = os.path.join(work, '%s_%s.bin' % (name, tag))
    rc, log = run([arkcc] + IMG_ARM + ['-O2', '-I', INC, src, '-o', img] + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['image failed']
    with open(asm, encoding='utf-8') as fh:
        text = fh.read()
    with open(img, 'rb') as fh:
        blob = fh.read()
    return text, blob, None


INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')


def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))


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


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_branch_')
    try:
        for name, body, _, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        text_a, blob_a, e1 = build(arkcc, work, 'near', [], 'plain')
        text_b, blob_b, e2 = build(arkcc, work, 'near', ['-fno-opt-branch'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(text_a == text_b and blob_a == blob_b,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-branch)',
                  '%d/%d bytes' % (len(blob_a), len(blob_b)))

        # Baseline saving of the runtime helpers, measured on a program that
        # has no user-written branch at all.
        ref_save = ref_save_all = 0
        write(os.path.join(work, 'mini.c'), MINI)
        _, r_base, e1 = build(arkcc, work, 'mini', [], 'plain')
        _, r_on, e2 = build(arkcc, work, 'mini', [FLAG], 'on')
        _, r_va, e3 = build(arkcc, work, 'mini',
                            ['-fopt-vstack', '-fopt-addr'], 'va')
        _, r_all, e4 = build(arkcc, work, 'mini',
                             ['-fopt-vstack', '-fopt-addr', FLAG], 'all')
        if e1 or e2 or e3 or e4:
            check(False, 'the reference program compiles',
                  (e1 or e2 or e3 or e4)[0][:120])
        else:
            ref_save = len(r_base) - len(r_on)
            ref_save_all = len(r_va) - len(r_all)
            check(ref_save > 0 and ref_save % 2 == 0,
                  'the reference program isolates the helper branches',
                  'save=%d save_all=%d' % (ref_save, ref_save_all))

        for name, body, want, mode in CASES:
            arms = {}
            for tag, flags in (('base', []),
                               ('off', ['-fno-opt-branch']),
                               ('on', [FLAG]),
                               ('va', ['-fopt-vstack', '-fopt-addr']),
                               ('all', ['-fopt-vstack', '-fopt-addr', FLAG])):
                t, blob, err = build(arkcc, work, name, flags, tag)
                if err:
                    arms[tag] = None
                    check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
                    break
                arms[tag] = (t, blob)
            if any(v is None for v in arms.values()):
                continue

            n_base = insn_count(arms['base'][0])
            n_on = insn_count(arms['on'][0])
            save = len(arms['base'][1]) - len(arms['on'][1])
            save_all = len(arms['va'][1]) - len(arms['all'][1])

            if mode == 'shrink':
                check(n_on == n_base,
                      '%s: the instruction count is unchanged' % name,
                      '%d -> %d' % (n_base, n_on))
                check(save > 0 and save % 2 == 0,
                      '%s: the image shrinks by whole 2-byte branches' % name,
                      'base=%d on=%d (save %d)'
                      % (len(arms['base'][1]), len(arms['on'][1]), save))
                check(len(arms['on'][1]) < len(arms['base'][1]),
                      '%s: instruction count same but bytes drop' % name)
                check(save_all > 0,
                      '%s: it still pays on top of -fopt-vstack/-fopt-addr' % name,
                      '%d -> %d bytes' % (len(arms['va'][1]), len(arms['all'][1])))
            else:
                # The helpers that are appended to every image hold a few
                # short branches of their own, so "save == 0" is not the right
                # test.  Compare against a program with no user branch: any
                # extra byte saved by this fixture means the long target was
                # wrongly squeezed into 16 bits.
                check(save == ref_save,
                      '%s: an out-of-range target keeps its 32-bit form' % name,
                      'base=%d on=%d save=%d ref=%d'
                      % (len(arms['base'][1]), len(arms['on'][1]),
                         save, ref_save))
                check(save_all == ref_save_all,
                      '%s: same on top of -fopt-vstack/-fopt-addr' % name,
                      '%d -> %d bytes, save=%d ref=%d'
                      % (len(arms['va'][1]), len(arms['all'][1]),
                         save_all, ref_save_all))

            check(len(arms['on'][1]) <= len(arms['base'][1]) and
                  len(arms['all'][1]) <= len(arms['va'][1]),
                  '%s: the image never grows' % name)

            if not HAVE_UNICORN:
                skip('%s: emulator value' % name, 'python package unicorn missing')
                continue
            got = {}
            ok = True
            for tag in ('base', 'off', 'on', 'va', 'all'):
                st, val, _ = run_image(arms[tag][1])
                if st != 'returned':
                    check(False, '%s: %s arm returns' % (name, tag), st)
                    ok = False
                    break
                got[tag] = val
            if ok:
                check(all(v == want for v in got.values()),
                      '%s: all five arms return %d' % (name, want),
                      ' '.join('%s=%s' % (k, got[k]) for k in
                               ('base', 'off', 'on', 'va', 'all')))

        # --- 5. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_BRANCH=0'], 'arkcc_nobr')
        if trimmed is None:
            skip('a cropped build refuses -fopt-branch', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'near.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-branch by name', 'rc=%d' % rc)
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'near.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    sys.exit(main())
