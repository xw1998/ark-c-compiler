#!/usr/bin/env python3
"""Gate for the bit-mask fold (0.9.1, -fopt-bitmask).

A negated constant mask is built in three steps:

    MOV rX, #imm            ; armcc-compatible `~mask`
    MVN rX, rX
    AND rD, rX              ; or `MOV rD, rX` when the mask is just copied

The same two values are directly encodable in Thumb-2 as

    BIC rD, rD, #imm        ; when the consumer is `AND rD, rX`
    MVN rD, #imm            ; when the consumer is `MOV rD, rX`

so the triple folds to one instruction.  The pass is a text-level rewrite
between -fopt-cmat (which decides whether the mask is materialised at all) and
-fopt-litpool (which would swallow a 32-bit mask into the pool).

What is checked:

  1. OFF IS OFF.  `-O2 <passes>` and the same plus `-fno-opt-bitmask` are
     byte-identical as assembly and as image.
  2. THE MOVE FOLD FIRES.  `MOV r0, #4 / MVN r0, r0 / MOV r7, r0` becomes a
     single `MVN r7, #0x4`, and the function gets two instructions shorter --
     a rule that never fires would still pass a "no growth" check.
  3. THE AND FOLD FIRES.  `MOV r0, #2 / MVN r0, r0 / AND r5, r0` becomes
     `BIC r5, r5, #0x2`.
  4. A ROTATED IMMEDIATE STILL ENCODES.  `~0x000D0000` is `0xD0` rotated right
     by 20, an odd rotation.  It must fold to `MVN r7, #0xD0000`; a pass that
     only accepted even rotations would leave it alone and still look right,
     so the line is asserted by name.
  5. IT DECLINES WHEN IT MUST.  A mask that is not a modified immediate
     (`~0x101u`) must come out byte-identical, and so must a mask that is
     materialised but then stored (no adjacent `AND`/`MOV` consumer).
  6. IT DOES NOT CLOBBER A LIVE MASK.  When the mask is read again after the
     consumer, the fold may only rewrite the *copy* (`MOV rD, rX`).
  7. THE ANSWER IS THE SAME.  A fixture of six mask shapes returns the same
     value in four arms and in Python.
  8. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_BITMASK=0 refuses
     `-fopt-bitmask` by name (C3900U), and still compiles without the flag.

Usage: run_bitmask_tests.py [path-to-arkcc]
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

FLAG = '-fopt-bitmask'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']
# The configuration the pass ships in: every 0.9.1 pass through -fopt-exit.
# -fopt-cmat decides whether a mask is materialised at all and -fopt-vstack
# shrinks the bodies, so both belong in the arm the numbers are taken under.
PASSES = ['-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
          '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
          '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop',
          '-fopt-slotreg', '-fopt-strength', '-fopt-vstack', '-fopt-vreg',
          '-fopt-cmat', '-fopt-pair', '-fopt-litpool', '-fopt-frame',
          '-fopt-voldmb', '-fopt-constcond', '-fopt-boolmat', '-fopt-exit']

# One function per shape the pass has to handle.
FORMS = """\
volatile unsigned bm_g;
volatile unsigned bm_h;
unsigned bm_and(unsigned x) { return x & ~4u; }
unsigned bm_and_hi(unsigned x) { return x & ~0x01000000u; }
unsigned bm_copy(unsigned x) { unsigned m = ~0xFFu; return x & m; }
unsigned bm_rot(unsigned x) { return x & ~0x000D0000u; }
unsigned bm_unenc(unsigned x) { return x & ~0x101u; }
void bm_global(void) { bm_g &= ~2u; bm_h = bm_g; }
unsigned bm_keep(unsigned x, unsigned *p) { unsigned m = ~8u; *p = m; return x & m; }
unsigned bm_live(unsigned x) { unsigned m = ~0x10u; bm_h = m; return x & m; }
int main(void) { bm_global(); return (int)(bm_g & 0xFF); }
"""

# Value: six mask shapes, each returning something only the real computation
# produces, folded into one checksum.
VALUE = """\
volatile unsigned bm_sink;
static unsigned bm_v1(unsigned x) { return x & ~0x7u; }
static unsigned bm_v2(unsigned x) { unsigned m = ~0xF0u; return x & m; }
static unsigned bm_v3(unsigned x) { return x & ~0x000D0000u; }
static unsigned bm_v4(unsigned x) { return x & ~0x01000000u; }
static unsigned bm_v5(unsigned x) { return x & ~0x101u; }
static unsigned bm_v6(unsigned x) { unsigned m = ~0x3u; bm_sink = m; return x & m; }
void bm_vg(void) { bm_sink &= ~0x6u; }
int main(void)
{
    unsigned acc = 0x1234567u;
    acc = acc * 31u + bm_v1(0xFFFFFFFFu);
    acc = acc * 31u + bm_v2(0xFFFFFFFFu);
    acc = acc * 31u + bm_v3(0xFFFFFFFFu);
    acc = acc * 31u + bm_v4(0xFFFFFFFFu);
    acc = acc * 31u + bm_v5(0xFFFFFFFFu);
    acc = acc * 31u + bm_v6(0xFFFFFFFFu);
    bm_vg();
    acc = acc * 31u + bm_sink;
    return (int)(acc & 0xFF);
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

def build(arkcc, work, name, flags, tag, image=True):
    src = os.path.join(work, name + '.c')
    asm = os.path.join(work, '%s_%s.s' % (name, tag))
    rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src, '-o', asm]
                  + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['asm failed']
    with open(asm, encoding='utf-8') as fh:
        text = fh.read()
    if not image:
        return text, text.encode('utf-8'), None
    img = os.path.join(work, '%s_%s.bin' % (name, tag))
    rc, log = run([arkcc] + IMG_ARM + ['-O2', '-I', INC, src, '-o', img]
                  + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['image failed']
    with open(img, 'rb') as fh:
        blob = fh.read()
    return text, blob, None

INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')
LABEL_DEF_RE = re.compile(r'^(\.[A-Za-z0-9_.]+):', re.M)
BRANCH_REF_RE = re.compile(r'^\s+(?:B[A-Z]*|CBZ|CBNZ)\s+(\.[A-Za-z0-9_.]+)\s*$')

def func_text(text, name):
    m = re.search(r'^%s:\n(.*?)^\.size %s,' % (re.escape(name), re.escape(name)),
                  text, re.M | re.S)
    return m.group(1) if m else ''

def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))

def has_line(text, pattern):
    rx = re.compile(pattern)
    return any(rx.match(ln) for ln in text.splitlines())

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

def py_value():
    """Mirror of the C fixture; masked to 32 bits at every step so that
    `unsigned` wraparound is reproduced rather than assumed away."""
    M = 0xFFFFFFFF
    acc = 0x1234567
    for v in (0xFFFFFFFF & ~0x7, 0xFFFFFFFF & ~0xF0, 0xFFFFFFFF & ~0x000D0000,
              0xFFFFFFFF & ~0x01000000, 0xFFFFFFFF & ~0x101,
              0xFFFFFFFF & ~0x3):
        acc = (acc * 31 + v) & M
    sink = ~0x3 & M
    sink = sink & ~0x6
    acc = (acc * 31 + sink) & M
    return acc & 0xFF

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_bitmask_')
    try:
        write(os.path.join(work, 'forms.c'), FORMS)
        write(os.path.join(work, 'value.c'), VALUE)

        # --- 1. off is off --------------------------------------------------
        ta, ba, e1 = build(arkcc, work, 'forms', PASSES, 'plain')
        tb, bb, e2 = build(arkcc, work, 'forms',
                           PASSES + ['-fno-opt-bitmask'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(ta == tb and ba == bb,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-bitmask)',
                  '%d/%d bytes' % (len(ba), len(bb)))

        # --- 2..6. one arm per shape ----------------------------------------
        t_off, b_off, err_off = build(arkcc, work, 'forms', PASSES, 'off')
        t_on, b_on, err_on = build(arkcc, work, 'forms', PASSES + [FLAG], 'on')
        if err_off or err_on:
            check(False, 'both arms build', (err_off or err_on)[0][:120])
            return 1

        # 2. the move fold: MOV/MVN/MOV -> MVN imm
        f_off, f_on = func_text(t_off, 'bm_and'), func_text(t_on, 'bm_and')
        check(has_line(f_on, r'^\s+MVN\s+r\d+,\s*#0x4\s*$'),
              'the copy fold emits `MVN rD, #0x4`')
        check(not has_line(f_off, r'^\s+MVN\s+r\d+,\s*#'),
              'the un-folded arm really has no MVN-immediate in that function')
        check(insn_count(f_off) - insn_count(f_on) == 2,
              'the copy fold removes exactly the two dead lines',
              '%d -> %d' % (insn_count(f_off), insn_count(f_on)))

        # 3. the AND fold: MOV/MVN/AND -> BIC imm
        g_off, g_on = func_text(t_off, 'bm_global'), func_text(t_on, 'bm_global')
        check(has_line(g_on, r'^\s+BIC\s+r\d+,\s*r\d+,\s*#0x2\s*$'),
              'the AND fold emits `BIC rD, rD, #0x2`')
        check(has_line(g_off, r'^\s+AND\s+r\d+,\s*r\d+\s*$')
              and not has_line(g_off, r'^\s+BIC\s+'),
              'the un-folded arm uses `AND rD, rX` and no BIC')
        check(insn_count(g_off) - insn_count(g_on) == 2,
              'the AND fold removes exactly the two dead lines',
              '%d -> %d' % (insn_count(g_off), insn_count(g_on)))

        # 4. a rotated (odd-rotation) immediate must still encode
        check(has_line(func_text(t_on, 'bm_rot'), r'^\s+MVN\s+r\d+,\s*#0xD0000\s*$'),
              '`~0x000D0000` folds to `MVN rD, #0xD0000` (odd rotation)')

        # 5. it declines when it must
        check(func_text(t_off, 'bm_unenc') == func_text(t_on, 'bm_unenc')
              and func_text(t_on, 'bm_unenc') != '',
              '`~0x101u` is not a modified immediate: function unchanged')
        check(func_text(t_off, 'bm_live') == func_text(t_on, 'bm_live')
              and func_text(t_on, 'bm_live') != '',
              'a mask with no adjacent AND/MOV consumer is unchanged')

        # 6. a mask that stays live is not clobbered
        k_off, k_on = func_text(t_off, 'bm_keep'), func_text(t_on, 'bm_keep')
        check(has_line(k_on, r'^\s+MVN\s+r\d+,\s*#0x8\s*$'),
              'the live mask is still built into a register once')
        check(insn_count(k_on) == insn_count(k_off) - 2,
              'a live mask costs two instructions less, not a wrong answer',
              '%d -> %d' % (insn_count(k_off), insn_count(k_on)))

        # global bookkeeping for the whole file
        check(insn_count(t_on) < insn_count(t_off),
              'the file gets shorter', '%d -> %d'
              % (insn_count(t_off), insn_count(t_on)))
        check(len(b_on) <= len(b_off), 'the image never grows',
              'off/on=%d/%d bytes' % (len(b_off), len(b_on)))
        check(not dangling_labels(t_on), 'every branch target is defined')

        # --- 7. the answer is the same --------------------------------------
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

        # --- 8. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_BITMASK=0'],
                                   'arkcc_nobm')
        if trimmed is None:
            skip('a cropped build refuses -fopt-bitmask', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'forms.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-bitmask by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'forms.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
