#!/usr/bin/env python3
"""Gate for the strength-reduction pass (0.9.1, -fopt-strength).

A multiplication by a constant power of two is a left shift.  On this target
that is not a micro-optimisation detail but a third of the multiply traffic:
the STM32F4 HAL corpus holds 1,105 MUL instructions and 1,052 of them are the
stride scaling of `a[i]` (element size 4, or 2 for `short[]`), which the ARM
backend emits as a MOV/MUL pair *inside* IR_LOAD_IDX -- no IR multiply exists
for those, so the IR peephole alone cannot reach them.  With the flag the HAL
corpus goes 47,885 -> 46,779 instructions (-1,106, -2.3%) and the multiply
count 1,105 -> 12.

The rewrite happens in two places and both are covered here:

  * IR level (src/opt.c, opt_strength_func): the constant sits immediately in
    front of IR_BINARY(TOK_MUL), which is the shape of `x * 4`, of the
    `sizeof(*p)` scaling in pointer arithmetic and of the address computation
    of `a[i]` in a store.  The pair becomes PUSH_INT(sh) + IR_BINARY(TOK_SHL);
    `x * 1` drops both instructions.
  * Backend (backend_arm.c, IR_LOAD_IDX): a power-of-two element size scales
    with `LSL r1, r1, #sh` instead of `MOV r2, #es; MUL r1, r2`.

Each claim is checked separately:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-strength` are byte-identical, as
     assembly and as image: the pass is opt-in like every other 0.9.x pass.
  2. IT PAYS.  On the fixtures the instruction count strictly drops, the
     multiply count drops with it, and the shift shapes the pass is supposed
     to produce actually appear -- a rule that silently never fires would
     still pass a count-only check on a corpus that already had shifts.
  3. NOT A POWER OF TWO IS LEFT ALONE.  `x * 3` and `x * 5` keep their MUL:
     on Cortex-M4 a multiply is one cycle and a shift/add chain is not
     shorter, so rewriting them would trade size for nothing.
  4. THE ANSWER IS THE SAME.  Two fixtures (int array + short array + explicit
     `x * 4`/`x * 8`/`x * 1`; and an `x * 3`/`x * 5` one that must not move)
     return the value computed here in Python on the emulator, in five arms:
     no flags, pass off, pass on, -fopt-vstack+-fopt-addr, and the same two
     plus the pass (three passes over the same text).
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_STRENGTH=0
     refuses `-fopt-strength` by name (C3900U) instead of accepting it and
     doing nothing, and still compiles the same file without the flag.

Usage: run_strength_tests.py [path-to-arkcc]
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

FLAG = '-fopt-strength'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# --- fixtures ---------------------------------------------------------------
# Every multiply in POW2 is by 1, 2, 4 or 8, so the optimised arms must contain
# no MUL at all; every multiply in ODD is by 3 or 5, so its MULs must survive.
POW2 = """\
int st_pad_a;
static int sumi(int *a, int n)
{
    int i, s = 0;
    for (i = 0; i < n; i++) s += a[i];
    return s;
}
static int sumh(const short *a, int n)
{
    int i, s = 0;
    for (i = 0; i < n; i++) s += a[i];
    return s;
}
static int scale(int x) { return x * 4 + x * 8 + x * 1; }
static int walk(int *p, int n)
{
    int s = 0;
    while (n-- > 0) { s += *p; p = p + 1; }
    return s;
}
int main(void)
{
    int v[8];
    short h[6];
    int i;
    for (i = 0; i < 8; i++) v[i] = i + 1;
    for (i = 0; i < 6; i++) h[i] = (short)(i + 2);
    return (sumi(v, 8) + sumh(h, 6) + scale(3) + walk(v, 4)) & 0xFF;
}
"""

ODD = """\
int st_pad_b;
static int odd(int x) { return x * 3 + x * 5; }
int main(void) { return odd(7) & 0xFF; }
"""


def py_pow2():
    v = [i + 1 for i in range(8)]
    h = [(i + 2) & 0xFFFF for i in range(6)]
    total = sum(v) + sum(h) + (3 * 4 + 3 * 8 + 3 * 1) + sum(v[0:4])
    return total & 0xFF


def py_odd():
    return (7 * 3 + 7 * 5) & 0xFF


CASES = [
    ('pow2', POW2, py_pow2()),
    ('odd', ODD, py_odd()),
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
    """Compile one fixture twice: assembly text and a bootable image."""
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
# The two shapes the pass produces.  The backend one is tied to the register
# the stride sits in (r1 in IR_LOAD_IDX); the IR one has no fixed register.
SHIFT_IDX_RE = re.compile(r'^\s+LSL\s+r1\s*,\s*r1\s*,\s*#\d+\s*$')
MUL_RE = re.compile(r'^\s+MUL\s')
# A scale that should have been folded away: MOV rX, #2^k followed by a MUL.
MOV2K_MUL_RE = re.compile(
    r'^\s+MOV\s+r\d+\s*,\s*#(?:2|4|8|16|32|64|128|256)\s*$')


def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))


def count_mul(text):
    return sum(1 for ln in text.splitlines() if MUL_RE.match(ln))


def count_shift_idx(text):
    return sum(1 for ln in text.splitlines() if SHIFT_IDX_RE.match(ln))


def leftover_scale_pairs(text):
    """MOV rX, #2^k  immediately followed by MUL: a fold the pass missed."""
    lines = [ln.rstrip() for ln in text.splitlines()]
    n = 0
    for i in range(len(lines) - 1):
        if MOV2K_MUL_RE.match(lines[i]) and MUL_RE.match(lines[i + 1]):
            n += 1
    return n


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

    work = tempfile.mkdtemp(prefix='arkcc_strength_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        text_a, blob_a, e1 = build(arkcc, work, 'pow2', [], 'plain')
        text_b, blob_b, e2 = build(arkcc, work, 'pow2',
                                   ['-fno-opt-strength'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(text_a == text_b and blob_a == blob_b,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-strength)',
                  '%d/%d bytes' % (len(blob_a), len(blob_b)))

        # --- 2/3/4. pays, leaves odd factors alone, same answer -------------
        for name, body, _ in CASES:
            arms = {}
            for tag, flags in (('base', []),
                               ('off', ['-fno-opt-strength']),
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
            n_all = insn_count(arms['all'][0])
            m_base = count_mul(arms['base'][0])
            m_on = count_mul(arms['on'][0])
            m_all = count_mul(arms['all'][0])

            if name == 'pow2':
                check(n_on < n_base, 'pow2: instructions drop',
                      '%d -> %d' % (n_base, n_on))
                check(m_on == 0 and m_all == 0,
                      'pow2: every power-of-two multiply is gone',
                      'MUL base=%d on=%d all=%d' % (m_base, m_on, m_all))
                check(count_shift_idx(arms['on'][0]) >
                      count_shift_idx(arms['base'][0]),
                      'pow2: the element-size scale became a shift',
                      'LSL r1,r1,#n  base=%d on=%d'
                      % (count_shift_idx(arms['base'][0]),
                         count_shift_idx(arms['on'][0])))
                check(leftover_scale_pairs(arms['on'][0]) == 0 and
                      leftover_scale_pairs(arms['all'][0]) == 0,
                      'pow2: no MOV #2^k / MUL pair is left behind',
                      '%d left (on), %d left (all)'
                      % (leftover_scale_pairs(arms['on'][0]),
                         leftover_scale_pairs(arms['all'][0])))
                n_va = insn_count(arms['va'][0])
                check(n_all < n_va,
                      'pow2: it still pays on top of -fopt-vstack/-fopt-addr',
                      '%d -> %d' % (n_va, n_all))
            else:
                check(m_on == m_base and m_all == m_base,
                      'odd: x*3 and x*5 keep their MUL',
                      'base=%d on=%d all=%d' % (m_base, m_on, m_all))
                check(n_on == n_base,
                      'odd: nothing is rewritten for non-powers of two',
                      '%d -> %d' % (n_base, n_on))

            check(len(arms['on'][1]) <= len(arms['base'][1]) and
                  len(arms['all'][1]) <= len(arms['va'][1]),
                  '%s: the image never grows' % name,
                  'base/on=%d/%d va/all=%d/%d bytes'
                  % (len(arms['base'][1]), len(arms['on'][1]),
                     len(arms['va'][1]), len(arms['all'][1])))

            if not HAVE_UNICORN:
                skip('%s: emulator value' % name, 'python package unicorn missing')
                continue
            want = dict((n, v) for n, _, v in CASES)[name]
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
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_STRENGTH=0'],
                                   'arkcc_nostrength')
        if trimmed is None:
            skip('a cropped build refuses -fopt-strength', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'pow2.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-strength by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'pow2.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if failures:
        print('\nstrength: %d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
    else:
        print('\nstrength: all checks passed%s' % (
            (' (%d skipped)' % len(skips)) if skips else ''))
    sys.exit(rc)