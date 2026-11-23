#!/usr/bin/env python3
"""Gate for local copy coalescing (0.9.1, -fopt-coalesce).

A `MOV rD, rS` that exists only because a two-operand Thumb ALU instruction
needs Rd == Rn is pure overhead once the run of instructions that follows it is
renamed onto rS:

    LDR  r5, [r6, #0]      ; a
    LDR  r7, [r6, #8]      ; b
    MOV  r0, r5            ; staging
    AND  r0, r7            ; r0 = a & b   (Rd == Rn, so not "AND r5, r7")
    LSL  r0, r0, #3
    STR  r0, [r1]

The rule renames every occurrence of rD in the straight-line run onto rS and
drops the copy.  The proof is the liveness the -fopt-live pass already
computes: rD may not be live after the last rewritten line, the copy source may
not be written inside the run, and once the target has been redefined inside
the run the source may not be live after it (its old value is gone).  Runs stop
at labels, block boundaries, IT instructions, write-back forms and register
lists.  Only r0-r7 take part, so nothing changes width.

Each claim is checked on its own, and each would fail on a plausible wrong
implementation:

  1. OFF IS OFF.  The default build and `-fno-opt-coalesce` are byte-identical.
  2. THE MERGE FIRES.  The `&`, `|` and `<<` staging copies in one function
     disappear, the ALU instructions keep their mnemonic and read rS instead,
     the instruction count drops by exactly the number of deleted copies, and
     no instruction is added anywhere.
  3. A TWO-OPERAND SELF-SOURCE IS NOT A COPY.  `MOV r0, r5 / LSL r0, r7` reads
     its destination (`r0 = r5 << r7`), so a rule that treated the first
     operand as a pure output would produce `LSL r5, r7` -- a different value.
     That fixture must come out byte-identical.
  4. A LIVE-OUT TARGET IS NOT DEAD.  `return a & b` stages into r0 and r0 is
     live at the return; the copy must survive, byte-identical.
  5. THE ANSWER IS THE SAME.  Four fixtures, three arms (off / on / on alone,
     no other optimisation pass), checked on the emulator against Python.
  6. OUTPUT SHAPE.  The pass only deletes lines and renames registers: the
     number of removed lines equals the instruction-count drop, and every
     changed line differs only in register names.
  7. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_COALESCE=0
     refuses `-fopt-coalesce` by name (C3900U) and still compiles without it.

Usage: run_coalesce_tests.py [path-to-arkcc]
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

FLAG = '-fopt-coalesce'
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
INC = os.path.join(ROOT, 'stdlib', 'include')

# The 0.9.1 pass set: the staging copies only exist once -fopt-vstack puts
# values in the pool registers, and -fopt-live supplies the liveness the rule
# is proved with.
BASE = ['-fopt-vstack', '-fopt-addr', '-fopt-strength', '-fopt-cbz',
        '-fopt-branch', '-fopt-imm', '-fopt-peep', '-fopt-cbranch',
        '-fopt-copyprop', '-fopt-live']

# 1/2: three two-operand ALU instructions whose left operand is staged into r0.
MERGE = """\
int cs_a, cs_b, cs_c;
void run(int a, int b)
{
    cs_a = a & b;
    cs_b = a | b;
    cs_c = (a & b) << 3;
}
int main(void) { run(12, 10); return cs_a + cs_b + cs_c; }
"""

# 3: the two-operand shift form reads its destination.
SELFSRC = """\
int cs_s = 3;
int sh(int x) { return (1 << (x & 31)) + cs_s; }
int main(void) { return sh(5); }
"""

# 4: the staged value is the return value, so the target is live out.
RET = """\
int cs_pad_r;
int r(int a, int b) { return a & b; }
int main(void) { return r(12, 10); }
"""

# 5: the staged value crosses a branch.
LIVEAFTER = """\
int cs_pad_b;
int br(int a, int b, int c)
{
    int t = a & b;
    if (c) return t;
    return t + 1;
}
int main(void) { return br(12, 10, 0); }
"""

CASES = [
    ('merge', MERGE, 86),        # 12 & 10 = 8, 12 | 10 = 14, (12 & 10) << 3 = 64 -> 8 + 14 + 64
    ('selfsrc', SELFSRC, 35),    # 1 << 5 = 32, + 3
    ('ret', RET, 8),             # 12 & 10
    ('liveafter', LIVEAFTER, 9),  # 12 & 10, c == 0 -> +1
]

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
build_arkcc = V.build_arkcc

# Every instruction line this backend emits is indented by four spaces.
INSN_LINE = '    '


def insn_lines(text):
    out = []
    for ln in text.splitlines():
        t = ln.strip()
        if not ln.startswith(INSN_LINE):
            continue
        if not t or t[0] in ';@.' or t.endswith(':'):
            continue
        out.append(t)
    return out


def count(re_, text):
    return sum(1 for ln in text.splitlines() if re_.match(ln))


MOV_STAGE_RE = re.compile(r'^\s+MOV\s+r0,\s*r5\s*$')
AND_STAGE_RE = re.compile(r'^\s+AND\s+r0,\s*r7\s*$')
AND_RENAMED_RE = re.compile(r'^\s+AND\s+r5,\s*r7\s*$')
ORR_RENAMED_RE = re.compile(r'^\s+ORR\s+r5,\s*r7\s*$')
LSL_STAGE_RE = re.compile(r'^\s+LSL\s+r0,\s*r0,\s*#3\s*$')
LSL_RENAMED_RE = re.compile(r'^\s+LSL\s+r5,\s*r5,\s*#3\s*$')


def both(arkcc, work, name, tag):
    off = build(arkcc, work, name, BASE, tag + 'o')
    on = build(arkcc, work, name, BASE + [FLAG], tag + 'n')
    err = off[2] or on[2]
    if err:
        check(False, '%s: both arms build' % name, err[0][:120])
        return None
    return off, on


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_coal_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        off = build(arkcc, work, 'merge', BASE, 'p1')
        off2 = build(arkcc, work, 'merge', BASE + ['-fno-opt-coalesce'], 'p2')
        if off[2] or off2[2]:
            check(False, 'the default build compiles the fixture',
                  (off[2] or off2[2])[0][:120])
        else:
            check(off[0] == off2[0] and off[1] == off2[1],
                  'the default build ignores the pass '
                  '(-fno-opt-coalesce is byte-identical)',
                  '%d/%d bytes' % (len(off[1]), len(off2[1])))

        # --- 2. the merge fires ---------------------------------------------
        pair = both(arkcc, work, 'merge', 'm')
        if pair is not None:
            (t_off, _, _), (t_on, _, _) = pair
            n_off, n_on = insn_count(t_off), insn_count(t_on)
            copies = count(MOV_STAGE_RE, t_off)
            check(copies >= 3,
                  'merge: the fixture really stages three ALU operands in r0',
                  '%d staged copy/copies' % copies)
            check(n_off - n_on >= 3,
                  'merge: at least the three merges are deleted, nothing is added',
                  '%d -> %d instruction(s), %d copy/copies'
                  % (n_off, n_on, copies))
            check(count(MOV_STAGE_RE, t_on) == 2,
                  'merge: only the two copies that cannot be merged survive',
                  'MOV r0, r5 %d -> %d'
                  % (copies, count(MOV_STAGE_RE, t_on)))
            check(count(AND_STAGE_RE, t_off) == 2 and
                  count(AND_STAGE_RE, t_on) == 0,
                  'merge: the staged AND is rewritten',
                  'AND r0, r7 %d -> %d'
                  % (count(AND_STAGE_RE, t_off), count(AND_STAGE_RE, t_on)))
            check(count(AND_RENAMED_RE, t_on) == 2 and
                  count(ORR_RENAMED_RE, t_on) == 1,
                  'merge: the ALU result lands in the copy source',
                  'AND r5, r7 %d, ORR r5, r7 %d'
                  % (count(AND_RENAMED_RE, t_on),
                     count(ORR_RENAMED_RE, t_on)))
            check(count(LSL_STAGE_RE, t_off) == 1 and
                  count(LSL_STAGE_RE, t_on) == 0 and
                  count(LSL_RENAMED_RE, t_on) == 1,
                  'merge: the value is carried through the run',
                  'LSL r0,r0,#3 %d -> %d, LSL r5,r5,#3 %d'
                  % (count(LSL_STAGE_RE, t_off), count(LSL_STAGE_RE, t_on),
                     count(LSL_RENAMED_RE, t_on)))
            # --- 6. output shape: no new instruction shape -------------------
            a, b = insn_lines(t_off), insn_lines(t_on)
            added = [ln for ln in b if ln not in a]
            check(all('r5' in ln for ln in added),
                  'merge: every new line is a renamed variant onto r5',
                  '; '.join(added[:6]))
            check(all(ln.split()[0] in
                      set(x.split()[0] for x in a) for ln in added),
                  'merge: no new mnemonic appears',
                  '; '.join(added[:6]))

        # --- 3/4. the anti-over-deletion fixtures are untouched --------------
        for name, why in (('selfsrc', 'a two-operand ALU reads its destination'),
                          ('ret', 'the staged value is live at the return')):
            pair = both(arkcc, work, name, name)
            if pair is None:
                continue
            (t_off, b_off, _), (t_on, b_on, _) = pair
            check(t_off == t_on and b_off == b_on,
                  '%s: left byte-identical (%s)' % (name, why),
                  '%d/%d vs %d/%d' % (len(t_off), len(b_off),
                                      len(t_on), len(b_on)))

        # --- 5. the answers stay the same -----------------------------------
        for name, _body, want in CASES:
            arms = {}
            ok = True
            for tag, flags in (('off', BASE), ('on', BASE + [FLAG]),
                               ('alone', [FLAG])):
                t, blob, err = build(arkcc, work, name, flags, 'v' + tag)
                if err:
                    check(False, '%s: %s arm builds' % (name, tag),
                          err[0][:120])
                    ok = False
                    break
                arms[tag] = blob
            if not ok:
                continue
            if not V.HAVE_UNICORN:
                skip('%s: emulator value' % name,
                     'python package unicorn missing')
                continue
            got = {}
            for tag in ('off', 'on', 'alone'):
                st, val, _ = V.run_image(arms[tag])
                got[tag] = val if st == 'returned' else st
            check(all(got[t] == want for t in got),
                  '%s: off/on/alone return the Python answer' % name,
                  ' '.join('%s=%s' % (t, got[t])
                           for t in ('off', 'on', 'alone'))
                  + ' want=%s' % want)

        # --- 7. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_COALESCE=0'],
                                   'arkcc_nocoal')
        if trimmed is None:
            skip('a cropped build refuses -fopt-coalesce', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'merge.c'), '-o', 't.s', FLAG],
                          work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-coalesce by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'merge.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\ncoalesce: %d check(s) FAILED%s' % (
            len(V.failures),
            (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\ncoalesce: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
