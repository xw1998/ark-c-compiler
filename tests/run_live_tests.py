#!/usr/bin/env python3
"""Gate for the liveness pass (0.9.1, -fopt-live).

Liveness is the first pass in this backend that looks past one basic block.
`-fopt-copyprop` could only drop a copy whose destination was overwritten in
the same straight line; the copies that dominate real code are the ones staged
around a branch, or written into a scratch register and read again after a
label.  This pass builds a control-flow graph per function, solves
`in/out = use | (def-complement & union(succ))`, and then applies four rules:

  L1  `MOV rD, rS|#imm` where rD is dead afterwards -> the line is deleted.
  L2  `MOV rD, rS` immediately followed by an instruction that reads rD, where
      rD dies there and the consumer does not write rD -> the consumer reads rS
      and the copy is deleted.  (IAR `DefIntoMove`.)
  L3  `MOV rT, #0` immediately followed by an instruction that only uses rT as
      an address index -> the index is dropped (`[rB, rT, LSL #2]` -> `[rB]`).
  L4  `MOVW rD, #lo / MOVT rD, #hi / MOV rX, rD` -> the constant is materialised
      straight into rX.

Each claim is checked on its own, and each would fail on a plausible wrong
implementation:

  1. OFF IS OFF.  The default build and `-fno-opt-live` are byte-identical.
  2. L1 FIRES ALONE.  `dead` keeps a value in a scratch register across a loop
     back edge and never reads it: the dead `MOV rX, rY` copies disappear, no
     other line changes, and the instruction count drops by exactly five (the
     loop copies plus the dead return staging the pass now sees).
  3. L2 FIRES ALONE.  `fwd` indexes an array through a pointer that was copied
     one instruction earlier: the copies fold into their consumer (the consumer
     may sit two or three instructions later, so the staged zero index and the
     pointer copy both go), the instruction count drops by two, the indexed
     load becomes a plain one, and nothing else moves.
  4. L3 FIRES ALONE.  `zero` reads element 0: two `[rB, rX, LSL #2]` become
     `[rB]`, the staged-zero copies go with them, and the count drops by five.
  5. L4 FIRES ALONE.  `addr` stores `&global`: two three-line address
     materialisations become two-line ones without growing anything; the count
     drops by three.
  6. NOTHING ELSE IS TOUCHED.  `shift` is built around `MOV r0, r5 / LSL r0, r7`
     -- a two-operand ALU instruction whose real source *is* its destination.
     A pass that treats the first operand as a pure destination deletes the
     copy and silently produces a different answer, so the `MOV rX, rY / LSL
     rX, rY` pair must survive untouched.  Only the two copies that stage a
     *non-return* register for a function that returns in r0 may go, and every
     removed line must be one of those.
  6b. THE RETURN MASK IS THE RETURN TYPE.  `vstage` compares two arguments in a
     void function and in an int one.  The arguments are staged through r0..r3;
     in a void function none of them is live out, so the staging copies must
     disappear, while the value the int function really returns must survive.
     Reading the return mask as a constant `0xF` leaves all three staged copies
     in place.
  7. THE ANSWER IS THE SAME.  Five fixtures, three arms (off / on / on alone,
     no other pass), values checked on the emulator against Python.
  7b. NO LEAK THROUGH A DIRECTIVE.  A block's line range spans the directives
     (".loc", ".arkdatasym") between its first and last instruction, and the
     per-line parse `iv[]` is written only for real instructions.  Scanning a
     directive must therefore not pick up the *previous* function's parse of
     the same line index.  Measured on the real ST LL driver: `LL_mDelay` left
     a `MOVT r5` parse at index 9, the next function (`LL_SetSystemCoreClock`)
     had a directive at index 9, and the scan believed r5 was clobbered there
     -- so L1 deleted its `MOV r5, r0` and the store read a register nothing
     had written.  The fixture is the real file because the argument only
     stages through r5 in that corpus; the off arm must show the staging, the
     on arm must keep the store on r0.
  8. LABELS SURVIVE.  The pass rewrites lines, never labels.
  9. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_LIVE=0 refuses
     `-fopt-live` by name (C3900U) and still compiles without the flag.

Usage: run_live_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import io
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

FLAG = '-fopt-live'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']

# The 0.9.1 pass set.  -fopt-vstack is what puts values in the pool registers,
# -fopt-copyprop is the sibling pass that only sees one basic block, so live
# has to run on top of it and clean up what is left.
BASE = ['-fopt-vstack', '-fopt-addr', '-fopt-strength', '-fopt-cbz',
        '-fopt-branch', '-fopt-imm', '-fopt-peep', '-fopt-cbranch',
        '-fopt-copyprop']

# L1: the old sum is kept in a scratch register across the back edge and then
# never read; the loop only writes the global.
DEAD = """\
int lv_dead_s;
int f(int n)
{
    int i;
    for (i = 0; i < n; i++) lv_dead_s += i * lv_dead_s;
    return lv_dead_s;
}
int main(void) { return f(4); }
"""

# L2: the pointer is copied one instruction before it is indexed.
FWD = """\
int lv_fwd_a[8] = {5, 6, 7, 8};
int f(int i) { int *p = lv_fwd_a; return p[i]; }
int main(void) { return f(2); }
"""

# L3: element 0 plus element i -- the zero index is staged in a register.
ZERO = """\
int lv_zero_a[8] = {5, 6, 7, 8};
int f(int i) { int *p = lv_zero_a; return p[0] + p[i]; }
int main(void) { return f(2); }
"""

# L4: the address of a global is materialised and then copied into a variable.
ADDR = """\
int lv_addr_v = 7;
int *lv_addr_p;
void f(void) { lv_addr_p = &lv_addr_v; }
int main(void) { f(); return 0; }
"""

# Control: `MOV r0, r5 / LSL r0, r7` -- the two-operand form reads its
# destination, so the copy must survive.  `1 << (x & 31)` is the smallest
# expression that produces it.
SHIFT = """\
int lv_shift_v = 3;
int f(int x) { return (1 << (x & 31)) + lv_shift_v; }
int main(void) { return f(5); }
"""

# Regression for the return-register mask: the compare staging copies of the
# arguments in a void function are dead, the ones in an int function are not.
VSTAGE = """\
int lv_vstage_g;
void fv(int a, int b) { if (a > b) lv_vstage_g = 1; else lv_vstage_g = 2; }
int fi(int a, int b) { if (a > b) return 1; return 2; }
int main(void) { fv(3, 2); return fi(3, 2); }
"""

CASES = [
    ('dead', DEAD, 0),
    ('fwd', FWD, 7),
    ('zero', ZERO, 12),
    ('addr', ADDR, 0),
    ('shift', SHIFT, 35),
    ('vstage', VSTAGE, 1),
]

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
build_arkcc = V.build_arkcc

MOVRR_RE = re.compile(r'^\s+MOV\s+r\d+,\s*r\d+\s*$')
MOVT_RE = re.compile(r'^\s+MOVT\s')
IDXLDR_RE = re.compile(r'^\s+LDR\s+r\d+,\s*\[r\d+,\s*r\d+,\s*LSL #2\]\s*$')
PLAINLDR_RE = re.compile(r'^\s+LDR\s+r\d+,\s*\[r\d+\]\s*$')
LSLRR_RE = re.compile(r'^\s+LSL\s+r\d+,\s*r\d+\s*$')
# `MOV r0..r3, rX` right after a compare: the comparison is staged into the
# argument registers before the branch.
CMPSTAGE_RE = re.compile(r'^\s+MOV\s+r[0-3],\s*r\d+\s*$')


# The ARM backend emits __aeabi_memcpy only when a `BL __aeabi_memcpy` really
# occurs, so a compiler-runtime helper may or may not be sitting at the end of
# the file.  It is not fixtured code, and counting it would make these tallies
# depend on whether some unrelated part of the unit needed memcpy, so it is cut
# out before anything is counted.
RUNTIME_NAMES = ('__aeabi_memcpy',)

def drop_runtime(text):
    out, skipping = [], False
    for ln in text.splitlines():
        s = ln.strip()
        if s.startswith('.global ') and s[8:].strip() in RUNTIME_NAMES:
            skipping = True
            continue
        if skipping:
            if not s:
                skipping = False
            continue
        out.append(ln)
    return '\n'.join(out)


def count(re_, text):
    return sum(1 for ln in drop_runtime(text).splitlines() if re_.match(ln))


def cmp_stage_count(text):
    lines = text.splitlines()
    return sum(1 for i, ln in enumerate(lines)
               if CMPSTAGE_RE.match(ln) and i and
               lines[i - 1].strip().startswith('CMP'))


def label_count(text):
    return sum(1 for ln in text.splitlines()
               if ln.strip().startswith('.L') and ln.strip().endswith(':'))


def both(arkcc, work, name, tag):
    """Build one fixture in the off and on arms; report a failure if either
    arm does not compile."""
    off = build(arkcc, work, name, BASE, tag + 'o')
    on = build(arkcc, work, name, BASE + [FLAG], tag + 'n')
    err = off[2] or on[2]
    if err:
        check(False, '%s: both arms build' % name, err[0][:120])
        return None
    return off, on


def rule_check(arkcc, work, name, tag, delta, want_movrr, want_idxldr,
               want_plainldr, what):
    pair = both(arkcc, work, name, tag)
    if pair is None:
        return
    (t_off, _, _), (t_on, b_on, _) = pair
    n_off, n_on = insn_count(t_off), insn_count(t_on)
    check(n_off - n_on == delta,
          '%s: the instruction count drops by %d' % (name, delta),
          '%d -> %d' % (n_off, n_on))
    m_off, m_on = count(MOVRR_RE, t_off), count(MOVRR_RE, t_on)
    check(m_on == want_movrr,
          '%s: %s' % (name, what),
          'MOV rX, rY %d -> %d (want %d)' % (m_off, m_on, want_movrr))
    check(count(IDXLDR_RE, t_on) == want_idxldr,
          '%s: indexed loads left = %d' % (name, want_idxldr),
          '%d -> %d' % (count(IDXLDR_RE, t_off), count(IDXLDR_RE, t_on)))
    check(count(PLAINLDR_RE, t_on) == want_plainldr,
          '%s: plain loads left = %d' % (name, want_plainldr),
          '%d -> %d' % (count(PLAINLDR_RE, t_off), count(PLAINLDR_RE, t_on)))
    check(count(MOVT_RE, t_on) == count(MOVT_RE, t_off),
          '%s: the constant hi-halves are untouched' % name,
          '%d/%d' % (count(MOVT_RE, t_off), count(MOVT_RE, t_on)))
    check(label_count(t_on) == label_count(t_off),
          '%s: labels are untouched' % name,
          '%d/%d label(s)' % (label_count(t_off), label_count(t_on)))


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_live_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        t_a, b_a, e1 = build(arkcc, work, 'fwd', BASE, 'plain')
        t_b, b_b, e2 = build(arkcc, work, 'fwd', BASE + ['-fno-opt-live'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(t_a == t_b and b_a == b_b,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-live)',
                  '%d/%d bytes' % (len(b_a), len(b_b)))

        # --- 2..5. one rule each -------------------------------------------
        # The `want` numbers are MOV rX, rY tallies of the fixture's own code
        # only (drop_runtime cuts the on-demand __aeabi_memcpy out).  They were
        # one higher while the runtime helper was emitted unconditionally.
        rule_check(arkcc, work, 'dead', 'd', 5, 2, 0, 3,
                   'the dead copies are gone')
        # The folded form is an *indexed* load, not a plain `[rB]`: fwd ends at
        # `LDR r0, [r5, r0, LSL #2]` and zero at `LDR r5, [r0, #0]` plus
        # `LDR r7, [r7, r0, LSL #2]`.  The earlier numbers assumed the index was
        # folded into a plain base register; the pass now puts it back into the
        # load's own addressing mode, which removes more instructions (fwd
        # 6 staging lines -> 1, zero 12 -> 3) and leaves one indexed load.
        rule_check(arkcc, work, 'fwd', 'f', 5, 1, 1, 0,
                   'the copies fold into their consumer')
        rule_check(arkcc, work, 'zero', 'z', 9, 0, 1, 0,
                   'the staged zero indices fold away')
        rule_check(arkcc, work, 'addr', 'a', 3, 0, 0, 0,
                   'the address copies are gone')

        # --- 6. nothing else is touched ------------------------------------
        pair = both(arkcc, work, 'shift', 's')
        if pair is not None:
            (t_off, _, _), (t_on, _, _) = pair
            check(count(MOVRR_RE, t_off) > 0 and count(LSLRR_RE, t_off) > 0,
                  'shift: the control fixture really has MOV+two-operand LSL',
                  '%d MOV rX, rY, %d LSL rX, rY'
                  % (count(MOVRR_RE, t_off), count(LSLRR_RE, t_off)))
            gone = [ln for ln in t_off.splitlines()
                    if ln not in t_on.splitlines()]
            stray = [ln for ln in gone if not CMPSTAGE_RE.match(ln)
                     and not re.match(r'^\s+MOV\s+r[1-3],\s*r\d+\s*$', ln)]
            check(not stray,
                  'shift: only the dead non-return staging copies are removed',
                  ('removed: %s' % '; '.join(l.strip() for l in gone))
                  if gone else 'nothing removed')
            check(count(MOVRR_RE, t_on) == 4 and count(LSLRR_RE, t_on)
                  == count(LSLRR_RE, t_off),
                  'shift: a two-operand ALU destination is not a dead copy',
                  'MOV rX, rY %d -> %d, LSL %d -> %d'
                  % (count(MOVRR_RE, t_off), count(MOVRR_RE, t_on),
                     count(LSLRR_RE, t_off), count(LSLRR_RE, t_on)))

        # --- 6b. the return mask follows the return type ---------------------
        pair = both(arkcc, work, 'vstage', 'v')
        if pair is not None:
            (t_off, _, _), (t_on, _, _) = pair
            check(cmp_stage_count(t_off) >= 3,
                  'vstage: the void function really stages its compare',
                  '%d staged copy/copies' % cmp_stage_count(t_off))
            check(cmp_stage_count(t_on) == 0,
                  'vstage: the compare staging in a void function is dead',
                  '%d -> %d' % (cmp_stage_count(t_off), cmp_stage_count(t_on)))

        # --- 7b. no leak through a directive -------------------------------
        # `iv[]` is written only for real instructions (kd == 1), but a block's
        # line range spans the directives between its first and last
        # instruction.  Scanning a directive used to read the *previous*
        # function's parse of the same index and hallucinate a write, which
        # killed a live argument.  The real ST LL driver is the smallest input
        # that reproduces it: without the pass `LL_SetSystemCoreClock` stages
        # its argument in r5 (`MOV r5, r0`), with the pass the store must stay
        # on r0 and r5 must not appear before it is written.
        leak_src = os.path.join(ROOT, 'examples', 'ark_test', 'Drivers',
                                'STM32F4xx_HAL_Driver', 'Src',
                                'stm32f4xx_ll_utils.c')
        if not os.path.exists(leak_src):
            skip('no leak through a directive',
                 'examples/ark_test corpus is not present')
        else:
            ll_flags = ['-D', 'STM32F401xE', '-D', 'USE_HAL_DRIVER',
                        '--reloc-data']
            for rel in ('examples/ark_test',
                        'examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Inc',
                        'examples/ark_test/Core/Inc',
                        'examples/ark_test/Drivers/CMSIS/Device/ST/'
                        'STM32F4xx/Include',
                        'examples/ark_test/Drivers/CMSIS/Core/Include',
                        'include', 'src', 'stdlib/include'):
                ll_flags += ['-I', os.path.join(ROOT, rel)]

            def leak_body(flags, tag):
                out = os.path.join(work, 'leak_' + tag + '.s')
                rc, log = run([arkcc] + ASM_ARM + ['-O2'] + ll_flags
                              + flags + [leak_src, '-o', out], work)
                if rc != 0:
                    return None, log[-200:]
                txt = io.open(out, encoding='utf-8', errors='replace').read()
                m = re.search(r'^LL_SetSystemCoreClock:\n(.*?)\.size\s+'
                              r'LL_SetSystemCoreClock', txt, re.S | re.M)
                return (m.group(1) if m else ''), ''

            off_b, e_off = leak_body(BASE, 'off')
            on_b, e_on = leak_body(BASE + [FLAG], 'on')
            if off_b is None or on_b is None:
                check(False, 'the directive-leak fixture builds',
                      (e_off or e_on)[:120])
            else:
                check('MOV r5, r0' in off_b and 'STR r5, [r1]' in off_b,
                      'the leak fixture really stages the argument in r5 '
                      'without the pass',
                      'off arm: %s' % ' '.join(
                          l.strip() for l in off_b.splitlines()
                          if 'r5' in l))
                check('STR r5, [r1]' not in on_b,
                      'a directive does not leak the previous parse into '
                      'liveness',
                      'on arm still stores r5: %s' % ' '.join(
                          l.strip() for l in on_b.splitlines()
                          if 'STR r5' in l))
                check('STR r0, [r1]' in on_b,
                      'the pass leaves the argument store intact',
                      'on arm: %s' % ' '.join(
                          l.strip() for l in on_b.splitlines()
                          if 'STR' in l))

        # --- 7. the answers stay the same -----------------------------------
        for name, _body, want in CASES:
            arms = {}
            ok = True
            for tag, flags in (('off', BASE), ('on', BASE + [FLAG]),
                               ('alone', [FLAG])):
                t, blob, err = build(arkcc, work, name, flags, 'v' + tag)
                if err:
                    check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
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
                  ' '.join('%s=%s' % (t, got[t]) for t in ('off', 'on', 'alone'))
                  + ' want=%s' % want)

        # --- 9. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_LIVE=0'],
                                   'arkcc_nolive')
        if trimmed is None:
            skip('a cropped build refuses -fopt-live', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'fwd.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-live by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'fwd.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\nlive: %d check(s) FAILED%s' % (
            len(V.failures), (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\nlive: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
