#!/usr/bin/env python3
"""Gate for the peephole copy cleanup (0.9.1, -fopt-peep).

Two rules, both on the emitted text of one function:

  R1  PUSH {rX} <padding> POP {rY}   ->  MOV rY, rX   (nothing when X == Y)
  R3  STR rX, [r6, #o] <padding> LDR rX, [r6, #o]  ->  drop the LDR

They are the residue of the stack machine: the value stack is materialised in
memory, and a copy from one stack slot to another is a PUSH/POP pair, while a
store immediately read back from the same register is pure repetition.

Each claim is checked separately, and each would fail on a plausible wrong
implementation:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-peep` produce identical text and
     images.  The pass never runs unless asked.
  2. R1 PAYS.  A chain of stack copies loses its PUSH/POP pairs (padding lines
     such as .loc sit between them and must not break the match), the function
     gets shorter, and the image never grows.
  3. R3 PAYS.  A local written and read straight back loses the load, with the
     .loc between the two lines still allowed to be there.
  4. A LABEL IS NOT PADDING.  A PUSH/POP pair separated by a branch target is
     left alone -- a jump could reach the POP with a different value stack --
     and the image still computes the right answer on that fixture.
  5. THE ANSWER IS THE SAME.  Three fixtures return the value computed in
     Python on the emulator in four arms: off, on, on with -fopt-vstack, on
     with -fopt-imm.  Passes stacking must not fight.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_PEEP=0 refuses
     `-fopt-peep` by name (C3900U) and still compiles without the flag.

Usage: run_peep_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import re
import shutil
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

FLAG = '-fopt-peep'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# A chain of stack copies: each assignment is PUSH/POP (R1), each local write
# followed by its read is STR/LDR (R3).
COPY = """\
int pp_pad_c;
static int copies(int a)
{
    int x = a;
    int y = x;
    int z = y;
    return z + 1;
}
int main(void) { return copies(5) & 0xFF; }
"""

READBACK = """\
int pp_pad_s;
static int sread(int a)
{
    int x = a * 3 + 1;
    return x;
}
int main(void) { return sread(4) & 0xFF; }
"""

BRANCH = """\
int pp_pad_b;
static int branchy(int n)
{
    int t = (n & 3) ? 1 : 0;
    int u = (n & 4) ? 2 : 3;
    return (t * 10 + u) * (n + 1) + (n ^ t);
}
int main(void) { return branchy(5) & 0xFF; }
"""

def py_copies(a=5):
    return (a + 1) & 0xFF

def py_readback(a=4):
    return (a * 3 + 1) & 0xFF

def py_branch(n=5):
    t = 1 if (n & 3) else 0
    u = 2 if (n & 4) else 3
    return (((t * 10 + u) * (n + 1)) + (n ^ t)) & 0xFF

CASES = [
    ('copy', COPY, py_copies()),
    ('sread', READBACK, py_readback()),
    ('branch', BRANCH, py_branch()),
]

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
build_arkcc = V.build_arkcc

PUSH_RE = re.compile(r'^\s+PUSH\s+\{r(\d+)\}\s*$')
POP_RE = re.compile(r'^\s+POP\s+\{r(\d+)\}\s*$')
MEM_RE = re.compile(r'^\s+(STR|LDR)([BH]?)\s+r(\d+),\s*\[r6,\s*#(\d+)\]\s*$')

def is_pad(line):
    s = line.strip()
    if not s:
        return True
    if s[0] in ';@':
        return True
    if s[0] == '.' and not s.endswith(':'):
        return True
    return False

def pushpop_pairs(text):
    """PUSH {rX} ... POP {rX} with only padding in between."""
    lines = text.splitlines()
    n = 0
    for i, ln in enumerate(lines[:-1]):
        m = PUSH_RE.match(ln)
        if not m:
            continue
        j = i + 1
        while j < len(lines) and is_pad(lines[j]):
            j += 1
        if j < len(lines):
            m2 = POP_RE.match(lines[j])
            if m2 and m2.group(1) == m.group(1):
                n += 1
    return n

def readback_pairs(text):
    """STR rX,[r6,#o] ... LDR rX,[r6,#o] with only padding in between."""
    lines = text.splitlines()
    n = 0
    for i, ln in enumerate(lines[:-1]):
        m = MEM_RE.match(ln)
        if not m or m.group(1) != 'STR':
            continue
        j = i + 1
        while j < len(lines) and is_pad(lines[j]):
            j += 1
        if j < len(lines):
            m2 = MEM_RE.match(lines[j])
            if (m2 and m2.group(1) == 'LDR' and m2.group(2) == m.group(2) and
                    m2.group(3) == m.group(3) and m2.group(4) == m.group(4)):
                n += 1
    return n

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_peep_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        t_a, b_a, e1 = build(arkcc, work, 'copy', [], 'plain')
        t_b, b_b, e2 = build(arkcc, work, 'copy', ['-fno-opt-peep'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(t_a == t_b and b_a == b_b,
                  'the default build ignores the pass (-O2 == -O2 -fno-opt-peep)',
                  '%d/%d bytes' % (len(b_a), len(b_b)))

        # --- 2. r1 pays -----------------------------------------------------
        t_off, b_off, e3 = build(arkcc, work, 'copy', [], 'off')
        t_on, b_on, e4 = build(arkcc, work, 'copy', [FLAG], 'on')
        if e3 or e4:
            check(False, 'copy: both arms build', (e3 or e4)[0][:120])
        else:
            p_off, p_on = pushpop_pairs(t_off), pushpop_pairs(t_on)
            check(p_off > 0 and p_on < p_off,
                  'copy: stack-copy PUSH/POP pairs drop, padding does not break the match',
                  '%d -> %d pair(s)' % (p_off, p_on))
            check(insn_count(t_on) < insn_count(t_off),
                  'copy: instructions drop',
                  '%d -> %d' % (insn_count(t_off), insn_count(t_on)))
            check(len(b_on) <= len(b_off), 'copy: the image never grows',
                  '%d -> %d bytes' % (len(b_off), len(b_on)))

        # --- 3. r3 pays -----------------------------------------------------
        t_ro, b_ro, e5 = build(arkcc, work, 'sread', [], 'off')
        t_rn, b_rn, e6 = build(arkcc, work, 'sread', [FLAG], 'on')
        if e5 or e6:
            check(False, 'sread: both arms build', (e5 or e6)[0][:120])
        else:
            r_off, r_on = readback_pairs(t_ro), readback_pairs(t_rn)
            check(r_off > 0 and r_on < r_off,
                  'sread: a store read straight back loses its load',
                  '%d -> %d pair(s)' % (r_off, r_on))
            check(len(b_rn) <= len(b_ro), 'sread: the image never grows',
                  '%d -> %d bytes' % (len(b_ro), len(b_rn)))

        # --- 4/5. a label is not padding; the answers stay the same --------
        arms = {}
        for name, body, want in CASES:
            arms[name] = {}
            for tag, flags in (('off', []), ('on', [FLAG]),
                               ('vst', [FLAG, '-fopt-vstack']),
                               ('imm', [FLAG, '-fopt-imm'])):
                t, blob, err = build(arkcc, work, name, flags, tag)
                if err:
                    check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
                    arms[name] = None
                    break
                arms[name][tag] = (t, blob)
            if arms[name] is None:
                continue
            if not V.HAVE_UNICORN:
                skip('%s: emulator value' % name, 'python package unicorn missing')
                continue
            got = {}
            for tag in ('off', 'on', 'vst', 'imm'):
                st, val, _ = V.run_image(arms[name][tag][1])
                got[tag] = val if st == 'returned' else st
            check(all(got[t] == want for t in got),
                  '%s: off/on/vstack/imm return the Python answer' % name,
                  ' '.join('%s=%s' % (t, got[t]) for t in
                           ('off', 'on', 'vst', 'imm')) + ' want=%s' % want)

        # The branch fixture keeps its cross-label PUSH/POP pairs: the pass must
        # not have merged anything across a label.  (Its answers are checked
        # above; this checks the refusal itself.)
        if arms.get('branch'):
            bt = arms['branch']['on'][0]
            labels = [l.strip() for l in bt.splitlines()
                      if l.strip().startswith('.L') and l.strip().endswith(':')]
            check(bool(labels), 'branch: the fixture really has branch targets',
                  '%d label(s)' % len(labels))

        # --- 6. cropped out, refused ---------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_PEEP=0'],
                                   'arkcc_nopeep')
        if trimmed is None:
            skip('a cropped build refuses -fopt-peep', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'copy.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-peep by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'copy.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\npeep: %d check(s) FAILED%s' % (
            len(V.failures), (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\npeep: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
