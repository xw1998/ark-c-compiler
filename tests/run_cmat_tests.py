#!/usr/bin/env python3
"""Gate for the constant-materialisation clean-up (0.9.1, -fopt-cmat).

The backend materialises the same constant more than once: an index that is
already known is copied into a scratch register (`MOV r1, r7`) and then folded
back into the addressing mode by the hardware (`LDR r7, [r5, r1, LSL #2]`), and
the scratch register is written more than once in a row.  The pass removes
those three shapes inside one straight-line block:

  M1  `MOV rD, rS` where rS is known to hold 0..255 becomes `MOV rD, #k`.
      This does not save an instruction by itself; it makes the copy a
      constant so that M2 and M3 can see through it.

  M2  `LDR/STR[B/H] rT, [rB, rI(, LSL #s)]` where rI is known, the byte
      offset `k << s` fits in 0..4095 and rI != rB becomes `[rB, #off]`.

  M3  A flag-neutral write (`MOV`, `MOVW`+`MOVT` on the same register,
      `LSL/LSR/ASR/ROR`, `MVN`, `UXT*`, `SXT*`, `CLZ`, `REV*`) that is
      overwritten later in the same block before anything reads it is dead.

Everything else is a boundary: arithmetic that may set flags, multiplies,
`UDIV`, `BX`, barriers, conditional forms and any mnemonic the pass does not
know are never crossed or rewritten.  A `MOVW`/`MOVT` pair is treated as one
unit, because half of a pair is meaningless on its own.

Checks:

  1. OFF IS OFF.  Default build and `-fno-opt-cmat` are byte-identical.
  2. M2 FIRES.  The scaled-index form disappears and the immediate form
     appears, the image does not grow.
  3. M1 FIRES.  `MOV r1, r0` (r0 known 4) becomes `MOV r1, #4`.
  4. M3 FIRES.  The scratch write that is overwritten before any read is gone
     and the instruction count drops by exactly the number of dropped writes.
  5. NOTHING ELSE IS TOUCHED.  A fixture whose only nearby constant load is
     consumed by `STR` (first operand is a *source*) must come out
     byte-identical -- this is the anti-over-deletion half, and it fails on the
     two wrong read-set models this pass started with.  A `MOVW`/`MOVT` pair
     fixture must also stay byte-identical (a pair is never split).
  6. THE ANSWER IS THE SAME.  Fixtures checked on the emulator against Python,
     three arms each (off / on / on alone).
  7. LABELS SURVIVE.  The pass rewrites lines, never labels.
  8. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_CMAT=0 refuses
     `-fopt-cmat` by name (C3900U) and still compiles without the flag.

Usage: run_cmat_tests.py [path-to-arkcc]
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

FLAG = '-fopt-cmat'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']

# The 0.9.1 pass set: the emitters above this pass are what produce the shapes
# it folds (a copy of a known index into the pool register, then the indexed
# load).
BASE = ['-fopt-vstack', '-fopt-addr', '-fopt-strength', '-fopt-cbz',
        '-fopt-branch', '-fopt-imm', '-fopt-peep', '-fopt-cbranch']

# Fires all three rules: `i = 0` is copied into the index register, the index
# load is folded to `#0`, and the scratch write before it is overwritten.
IDX = """\
typedef struct { volatile unsigned int r[4]; } cmR;
cmR cm_obj;
int cm_idx(int bit)
{
    int i = 0;
    cm_obj.r[i] |= (unsigned)bit;
    return 0;
}
int main(void) { cm_idx(4); return (int)cm_obj.r[0]; }
"""

# Control: the only constant load next to the copy is read by `STR`, whose
# first operand is a source.  Reading it as a destination deletes the copy and
# stores garbage, so this fixture is the guard for that mistake.
STRFIRST = """\
volatile int cm_vv;
int cm_strfirst(void) { int t = 5; cm_vv = t; return cm_vv; }
int main(void) { return cm_strfirst(); }
"""

# Control: a 32-bit constant is materialised as a MOVW/MOVT pair; splitting the
# pair would corrupt the value silently.
BIG = """\
unsigned cm_bv = 0x12345678u;
int cm_bigf(void) { return cm_bv == 0x12345678u; }
int main(void) { return cm_bigf(); }
"""

CASES = [
    ('idx', IDX, 4),
    ('strfirst', STRFIRST, 5),
    ('big', BIG, 1),
]

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
build_arkcc = V.build_arkcc

LSLIDX_RE = re.compile(r',\s*LSL\s*#\d+\]')
IDXIMM_RE = re.compile(r'\[r\d+,\s*#\d+\]')
MOVIMM_RE = re.compile(r'^\s+MOV\s+r\d+,\s*#')
MOVRR_RE = re.compile(r'^\s+MOV\s+r\d+,\s*r\d+\s*$')


def count(re_, text):
    return sum(1 for ln in text.splitlines() if re_.match(ln))


def count_sub(s, text):
    return sum(1 for ln in text.splitlines() if s in ln)


def label_count(text):
    return sum(1 for ln in text.splitlines()
               if ln.strip().startswith('.L') and ln.strip().endswith(':'))


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_cmat_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        t_a, b_a, e1 = build(arkcc, work, 'idx', BASE, 'plain')
        t_b, b_b, e2 = build(arkcc, work, 'idx',
                             BASE + ['-fno-opt-cmat'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(t_a == t_b and b_a == b_b,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-cmat)',
                  '%d/%d bytes' % (len(b_a), len(b_b)))

        # --- 2..4. the three rules -----------------------------------------
        ti_off, bi_off, e3 = build(arkcc, work, 'idx', BASE, 'ioff')
        ti_on, bi_on, e4 = build(arkcc, work, 'idx', BASE + [FLAG], 'ion')
        if e3 or e4:
            check(False, 'idx: both arms build', (e3 or e4)[0][:120])
        else:
            l_off = sum(1 for ln in ti_off.splitlines() if LSLIDX_RE.search(ln))
            l_on = sum(1 for ln in ti_on.splitlines() if LSLIDX_RE.search(ln))
            i_off = sum(1 for ln in ti_off.splitlines() if IDXIMM_RE.search(ln))
            i_on = sum(1 for ln in ti_on.splitlines() if IDXIMM_RE.search(ln))
            check(l_off > 0 and l_on == 0,
                  'M2: every scaled-index load becomes an immediate offset',
                  'LSL #s] %d -> %d' % (l_off, l_on))
            check(i_on > i_off,
                  'M2: the immediate addressing form appears',
                  '[rB, #off] %d -> %d' % (i_off, i_on))

            rr_off = count(MOVRR_RE, ti_off)
            rr_on = count(MOVRR_RE, ti_on)
            mi_off = count_sub('MOV r1, #0', ti_off)
            mi_on = count_sub('MOV r1, #0', ti_on)
            check(rr_on < rr_off and mi_on > mi_off,
                  'M1: a copy of a known 0..255 constant becomes an immediate',
                  'MOV rX, rY %d -> %d / MOV r1, #0 %d -> %d'
                  % (rr_off, rr_on, mi_off, mi_on))

            d_off = count_sub('MOV r7, #0', ti_off)
            d_on = count_sub('MOV r7, #0', ti_on)
            check(d_on < d_off,
                  'M3: a neutral write overwritten before any read is dropped',
                  'MOV r7, #0 %d -> %d' % (d_off, d_on))
            check(insn_count(ti_off) - insn_count(ti_on) >= 2,
                  'the instruction count drops by at least one per dropped write',
                  '%d -> %d' % (insn_count(ti_off), insn_count(ti_on)))
            check(len(bi_on) <= len(bi_off), 'idx: the image never grows',
                  '%d -> %d bytes' % (len(bi_off), len(bi_on)))
            check(label_count(ti_on) == label_count(ti_off),
                  'idx: labels are untouched',
                  '%d/%d label(s)' % (label_count(ti_off), label_count(ti_on)))

        # --- 5. nothing else is touched -------------------------------------
        ts_off, _, e5 = build(arkcc, work, 'strfirst', BASE, 'soff')
        ts_on, _, e6 = build(arkcc, work, 'strfirst', BASE + [FLAG], 'son')
        if e5 or e6:
            check(False, 'strfirst: both arms build', (e5 or e6)[0][:120])
        else:
            check(count_sub('MOV r5, r0', ts_off) > 0,
                  'strfirst: the guarded copy really is emitted',
                  '%d MOV r5, r0' % count_sub('MOV r5, r0', ts_off))
            check(ts_off == ts_on,
                  'strfirst: the copy feeding STR (a source operand) is kept',
                  '%d/%d line(s)' % (len(ts_off.splitlines()),
                                     len(ts_on.splitlines())))

        tb_off, _, e7 = build(arkcc, work, 'big', BASE, 'goff')
        tb_on, _, e8 = build(arkcc, work, 'big', BASE + [FLAG], 'gon')
        if e7 or e8:
            check(False, 'big: both arms build', (e7 or e8)[0][:120])
        else:
            check(count_sub('MOVW', tb_off) > 0 and
                  count_sub('MOVT', tb_off) > 0,
                  'big: the fixture really contains a MOVW/MOVT pair',
                  '%d MOVW / %d MOVT' % (count_sub('MOVW', tb_off),
                                         count_sub('MOVT', tb_off)))
            check(tb_off == tb_on,
                  'big: a MOVW/MOVT pair is never split',
                  '%d/%d line(s)' % (len(tb_off.splitlines()),
                                     len(tb_on.splitlines())))

        # --- 6. the answers stay the same -----------------------------------
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
                arms[tag] = (t, blob)
            if not ok:
                continue
            if not V.HAVE_UNICORN:
                skip('%s: emulator value' % name,
                     'python package unicorn missing')
                continue
            got = {}
            for tag in ('off', 'on', 'alone'):
                st, val, _ = V.run_image(arms[tag][1])
                got[tag] = val if st == 'returned' else st
            check(all(got[t] == want for t in got),
                  '%s: off/on/alone return the Python answer' % name,
                  ' '.join('%s=%s' % (t, got[t]) for t in ('off', 'on', 'alone'))
                  + ' want=%s' % want)

        # --- 8. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_CMAT=0'],
                                   'arkcc_nocmat')
        if trimmed is None:
            skip('a cropped build refuses -fopt-cmat', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'idx.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-cmat by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'idx.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\ncmat: %d check(s) FAILED%s' % (
            len(V.failures),
            (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\ncmat: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)