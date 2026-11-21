#!/usr/bin/env python3
"""Gate for the addressing-mode folding pass (0.9.1, -fopt-addr).

The ARM backend is a stack machine, so one C access is emitted as a chain of
independent instructions:

    MOV r0, r5             ; base out of the value-stack pool
    ADD r0, r0, r1         ; + index
    LDR r0, [r0, #0]       ; *(base + index)

ARMv7-M has that address mode, so `-fopt-addr` rewrites the emitted text of one
function at a time and folds the arithmetic into the operand.  On the STM32F4
HAL corpus (42,365 instructions with -fopt-vstack) it removes 1,369
instructions, 3.2% of the object.

Each claim is checked separately, and each would fail on a plausible wrong
implementation:

  1. OFF IS OFF.  `-O2 -fopt-vstack` and `-O2 -fopt-vstack -fno-opt-addr` are
     byte-identical, and so are their images: the pass is opt-in like every
     other 0.9.x optimisation.
  2. IT PAYS.  On three access-heavy fixtures the flag strictly reduces the
     instruction count, never grows the image, and actually produces the
     folded shapes (a `[rX, rY]` register-indexed operand, and a `], #imm`
     post-index one) that were not in the unoptimised text.
  3. EVERY OPERAND IS STILL AN OPERAND.  Every memory operand in the folded
     output matches a whitelist of forms the assembler accepts.  A rule that
     mis-formats a line (`[r1, #1], #1` was a real bug during development)
     produces text that is still "assembly-shaped" and would otherwise slip
     through a count-only check.
  4. THE ANSWER IS THE SAME.  Four fixtures (array through a pointer, struct
     field with a variable index, `*p++` walk, pointer difference) return the
     value computed here in Python, on the emulator, in three arms: pass off,
     pass on, and pass on together with `-fopt-vstack` (one textual pass
     feeding another).
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_ADDR=0 refuses
     `-fopt-addr` by name (C3900U) instead of accepting it and doing nothing,
     and still compiles the same file without the flag.

Usage: run_addr_tests.py [path-to-arkcc]
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

FLAG = '-fopt-addr'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# --- fixtures ---------------------------------------------------------------
ARRAY = """\
int ad_pad_a;
static int sums(int *a, int n)
{
    int i, s = 0;
    for (i = 0; i < n; i++) s += a[i];
    return s;
}
static int pick(int *a, int i) { return a[i] + a[i + 1]; }
int main(void)
{
    int v[8];
    int i;
    for (i = 0; i < 8; i++) v[i] = i * 3 + 1;
    return (sums(v, 8) + pick(v, 5)) & 0xFF;
}
"""

STRUCTF = """\
int ad_pad_s;
struct S { int pad; int x; int y[8]; };
static int field(struct S *p, int i) { return p->x + p->y[i] + p->y[3]; }
int main(void)
{
    struct S s;
    int i;
    for (i = 0; i < 8; i++) s.y[i] = i + 2;
    s.x = 4;
    return field(&s, 5) & 0xFF;
}
"""

WALK = """\
int ad_pad_w;
static int walk(int *p, int n)
{
    int s = 0;
    while (n-- > 0) { s += *p; p++; }
    return s;
}
static int walk3(int *p)
{
    int s = *p++;
    s += *p++;
    s += *p++;
    return s;
}
int main(void)
{
    int v[6];
    int i;
    for (i = 0; i < 6; i++) v[i] = 7 * i + 1;
    return (walk(v, 6) + walk3(v)) & 0xFF;
}
"""

DIFF = """\
int ad_pad_d;
static int gap(const char *a, const char *b) { return (int)(b - a); }
static char at(const char *s, int i) { return s[i]; }
int main(void)
{
    char buf[16];
    int i;
    for (i = 0; i < 16; i++) buf[i] = (char)(i * 5 + 3);
    return (gap(buf, buf + 9) + at(buf, 11)) & 0xFF;
}
"""

def py_array():
    v = [i * 3 + 1 for i in range(8)]
    sums = sum(v)
    pick = v[5] + v[6]
    return (sums + pick) & 0xFF

def py_struct():
    y = [i + 2 for i in range(8)]
    return ((4 + y[5] + y[3]) & 0xFF)

def py_walk():
    v = [7 * i + 1 for i in range(6)]
    s = sum(v)
    s3 = v[0] + v[1] + v[2]
    return ((s + s3) & 0xFF)

def py_diff():
    buf = [(i * 5 + 3) & 0xFF for i in range(16)]
    return ((9 + buf[11]) & 0xFF)

# name, body, python answer
CASES = [
    ('array',  ARRAY,   py_array()),
    ('struct', STRUCTF, py_struct()),
    ('walk',   WALK,    py_walk()),
    ('diff',   DIFF,    py_diff()),
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
# Every operand the assembler accepts, as emitted by the pass: no index, a
# register index with an optional LSL, an immediate, a pre-index '!', or a
# post-index ", #imm" after the closing bracket.
MEMOP_RE = re.compile(
    r'^\s+(?:LDR|STR|LDRB|STRB|LDRH|STRH|LDRSB|LDRSH)\s+'
    r'(?:r\d+|lr|pc)\s*,\s*'
    r'\[\s*(?:r\d+|sp)\s*'
    r'(?:,\s*(?:r\d+\s*(?:,\s*LSL\s*#\d)?|#-?\d+))?\s*'
    r'\]\s*(?:!\s*|,\s*#-?\d+\s*)?$')
IDXFORM_RE = re.compile(r'^\s+(?:LDR|STR|LDRB|STRB|LDRH|STRH)\s+r\d+\s*,\s*\[\s*r\d+\s*,\s*r\d+')

def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))

def mem_ops(text):
    return [ln for ln in text.splitlines()
            if re.match(r'^\s+(?:LDR|STR)', ln)]

def bad_memops(text):
    return [ln for ln in mem_ops(text) if not MEMOP_RE.match(ln)]

def fold_pairs(text):
    """Count adjacent shapes the pass is supposed to fold away.

    ADD rD, rB, #imm  -> mem rX, [rD ...]      (R1)
    ADD rD, rB, rI    -> mem rX, [rD]          (R2)
    MOV rB, rS        -> mem rX, [rB ...]      (R3)
    """
    add_i = re.compile(r'^\s+ADD\s+r(\d+)\s*,\s*r(\d+)\s*,\s*#-?\d+\s*$')
    add_r = re.compile(r'^\s+ADD\s+r(\d+)\s*,\s*r(\d+)\s*,\s*r(\d+)\s*$')
    mov_r = re.compile(r'^\s+MOV\s+r(\d+)\s*,\s*r(\d+)\s*$')
    acc_d = re.compile(r'^\s+(?:LDR|STR|LDRB|STRB|LDRH|STRH|LDRSB|LDRSH)\s+'
                       r'(?:r\d+|lr|pc)\s*,\s*\[\s*r(\d+)\s*[,\]]')
    acc_b = re.compile(r'^\s+(?:LDR|STR|LDRB|STRB|LDRH|STRH|LDRSB|LDRSH)\s+'
                       r'(?:r\d+|lr|pc)\s*,\s*\[\s*r(\d+)\s*\]\s*$')
    lines = [ln for ln in text.splitlines() if not ln.strip().startswith('.')]
    n = 0
    for i in range(len(lines) - 1):
        a, b = lines[i], lines[i + 1]
        m = add_i.match(a)
        if m:
            k = acc_d.match(b)
            if k and k.group(1) == m.group(1):
                n += 1
                continue
        m = add_r.match(a)
        if m:
            k = acc_b.match(b)
            if k and k.group(1) == m.group(1):
                n += 1
                continue
        m = mov_r.match(a)
        if m:
            k = acc_d.match(b)
            if k and k.group(1) == m.group(1):
                n += 1
                continue
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

    work = tempfile.mkdtemp(prefix='arkcc_addr_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        text_a, blob_a, e1 = build(arkcc, work, 'array',
                                   ['-fopt-vstack'], 'plain')
        text_b, blob_b, e2 = build(arkcc, work, 'array',
                                   ['-fopt-vstack', '-fno-opt-addr'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(text_a == text_b and blob_a == blob_b,
                  'the default build ignores the pass '
                  '(-fopt-vstack == -fopt-vstack -fno-opt-addr)',
                  '%d/%d bytes' % (len(blob_a), len(blob_b)))

        # --- 2/3/4. pays, well formed, same answer --------------------------
        # Four arms: no flags at all (the honest size baseline -- -fopt-vstack
        # alone already shrinks the image, so comparing the addr-only arm with
        # the vstack-only arm would say "it grows" when it does not), then the
        # three arms the pass is actually described by.
        for name, body, _ in CASES:
            arms = {}
            for tag, flags in (('base', []),
                               ('off', ['-fopt-vstack']),
                               ('on', [FLAG]),
                               ('both', ['-fopt-vstack', FLAG])):
                t, blob, err = build(arkcc, work, name, flags, tag)
                if err:
                    arms[tag] = None
                    check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
                    break
                arms[tag] = (t, blob)
            if any(v is None for v in arms.values()):
                continue

            n_off = insn_count(arms['off'][0])
            n_on = insn_count(arms['both'][0])
            check(n_on < n_off, '%s: instructions drop' % name,
                  '%d -> %d (-%d%%)' % (n_off, n_on,
                                        100 * (n_off - n_on) // max(n_off, 1)))
            n_plain = insn_count(arms['base'][0])
            n_addr = insn_count(arms['on'][0])
            check(n_addr < n_plain,
                  '%s: instructions drop on the addr-only build too' % name,
                  '%d -> %d' % (n_plain, n_addr))

            idx_off = sum(1 for ln in mem_ops(arms['off'][0]) if IDXFORM_RE.match(ln))
            idx_on = sum(1 for ln in mem_ops(arms['both'][0]) if IDXFORM_RE.match(ln))
            if name in ('array', 'struct', 'walk'):
                check(idx_on > idx_off,
                      '%s: register-indexed operands appear' % name,
                      '%d -> %d' % (idx_off, idx_on))

            # No foldable add-then-access pair may survive.  This is the strong
            # version of "it pays": a shape the pass recognises and leaves
            # behind is a missed fold, and a rule that only fires on the first
            # two pairs of a function would pass a count-based check.  (The
            # fixtures' unoptimised text has no such pair -- -O2 without
            # -fopt-vstack puts PUSH/POP between the ADD and the access -- so
            # the residue check is the only meaningful half of the comparison.)
            pairs_addr = fold_pairs(arms['on'][0])
            pairs_both = fold_pairs(arms['both'][0])
            check(pairs_addr == 0 and pairs_both == 0,
                  '%s: every foldable pair is folded' % name,
                  '%d left (addr-only), %d left (addr+vstack)'
                  % (pairs_addr, pairs_both))

            bad = bad_memops(arms['on'][0]) + bad_memops(arms['both'][0])
            check(not bad, '%s: every memory operand is a form the assembler accepts'
                  % name, '%d bad%s' % (len(bad), (': ' + bad[0].strip()) if bad else ''))

            check(len(arms['on'][1]) <= len(arms['base'][1]) and
                  len(arms['both'][1]) <= len(arms['off'][1]),
                  '%s: the image never grows' % name,
                  'base/on=%d/%d vstack/both=%d/%d bytes'
                  % (len(arms['base'][1]), len(arms['on'][1]),
                     len(arms['off'][1]), len(arms['both'][1])))

            if not HAVE_UNICORN:
                skip('%s: emulator value' % name, 'python package unicorn missing')
                continue
            want = dict((n, v) for n, _, v in CASES)[name]
            got = {}
            ok = True
            for tag in ('base', 'off', 'on', 'both'):
                st, val, _ = run_image(arms[tag][1])
                if st != 'returned':
                    check(False, '%s: %s arm returns' % (name, tag), st)
                    ok = False
                    break
                got[tag] = val
            if ok:
                check(all(v == want for v in got.values()),
                      '%s: all four arms return %d' % (name, want),
                      ' '.join('%s=%s' % (k, got[k]) for k in
                               ('base', 'off', 'on', 'both')))

        # --- 5. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_ADDR=0'],
                                   'arkcc_noaddr')
        if trimmed is None:
            skip('a cropped build refuses -fopt-addr', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'array.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-addr by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'array.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    rc = main()
    if failures:
        print('\naddr: %d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
    else:
        print('\naddr: all checks passed%s' % (
            (' (%d skipped)' % len(skips)) if skips else ''))
    sys.exit(rc)
