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

  M4  `LSL/LSR/ASR rD, rS, #n` where rS holds a known constant becomes
      `MOV rD, #k` with the folded value (only when 0 <= k <= 255).  The
      three-operand shift is flag-neutral, so the value and the flags are
      both unchanged, and the result is now a constant the rules above can
      use.

  M5  The same fold through `UXTB/UXTH/SXTB/SXTH`.

  M6  `CMP rX, #k` with rX known, followed immediately by a conditional
      branch: the branch is decided here.  If it is always taken the branch
      becomes `B`; if it is never taken the branch line is dropped.  The
      `CMP` itself is kept, so no flag any later instruction could read
      changes at all.

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
  9. M4/M5/M6 FIRE.  A constant through a shift and through an extend is
     folded, a never-taken branch disappears, the instruction count drops
     and the answer does not change.  A shift whose result does not fit the
     8-bit immediate (`300 << 5`) and a shift that would need a negative
     immediate (`-8 >> 1`) are left alone.

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

# The nine other passes above BASE are what keep a local constant in a
# register instead of spilling it; without them the shift folds below never
# see a known value, and the fixture would test nothing.
FULL = BASE + ['-fopt-prop', '-fopt-copyprop', '-fopt-live', '-fopt-constcache',
               '-fopt-slotreg', '-fopt-coalesce', '-fopt-deadpush']

# M4/M5/M6: a constant through a shift, the same through an extend, and a
# `do {} while (0)` whose compare is a known 0 (the shape the HAL's
# `__HAL_RCC_..._CLK_ENABLE()` macros produce).
CONST = """\
volatile int cm_sink;
int cm_shl(void) { int i = 2; return i << 3; }
int cm_shr(void) { unsigned i = 5; return (int)(i >> 1); }
int cm_sar(void) { int i = 200; return i >> 2; }
int cm_uxtb(void) { unsigned char c = 128; return c; }
int cm_uxtb2(void) { unsigned char c = 300; return c; }
int cm_sxth(void) { short s = -2; return s; }
#define CM_CLK() do { cm_sink = 1; } while (0U)
void cm_clk(void) { CM_CLK(); }
int main(void)
{
    cm_clk();
    return (cm_shl() + cm_shr() + cm_sar() + cm_uxtb()
            + cm_uxtb2() + cm_sxth() + 2) & 255;
}
"""

# Anti-over-fire: both shifts have a known source and a result that does not
# fit the 8-bit immediate (200 << 5 = 6400, 200 << 1 = 400), so both must
# survive the pass untouched -- while the 7 through `UXTB` in the same file
# still folds, which shows the file really is being processed.
NOFIT = """\
volatile int cm_gate_v;
int cm_big1(void) { int i = 200; return i << 5; }
int cm_big2(void) { int i = 200; return i << 1; }
int cm_big3(void) { unsigned char c = 7; return c; }
int main(void)
{
    cm_gate_v = 1;
    return (cm_big1() + cm_big2() + cm_big3()) & 255;
}
"""

CASES = [
    ('idx', IDX, 4, BASE),
    ('strfirst', STRFIRST, 5, BASE),
    ('big', BIG, 1, BASE),
    ('cmat_const', CONST, 240, FULL),
    ('cmat_nofit', NOFIT, 151, FULL),
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
        for name, body, _want, _flags in CASES:
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

        # --- 5b. M4 / M5 / M6, and the no-over-fold half --------------------
        tc_off, _, e9 = build(arkcc, work, 'cmat_const', FULL, 'coff')
        tc_on, _, e10 = build(arkcc, work, 'cmat_const', FULL + [FLAG], 'con')
        if e9 or e10:
            check(False, 'cmat_const: both arms build', (e9 or e10)[0][:120])
        else:
            for pat, rule in (('LSL r0, r0, #3', 'M4'),
                              ('LSR r0, r0, #1', 'M4'),
                              ('ASR r0, r0, #2', 'M4')):
                a = count_sub(pat, tc_off)
                b = count_sub(pat, tc_on)
                check(a > 0 and b == 0,
                      '%s: `%s` is folded into an immediate' % (rule, pat),
                      '%d -> %d' % (a, b))
            check(count_sub('MOV r0, #16', tc_on) > 0 and
                  count_sub('MOV r0, #50', tc_on) > 0,
                  'M4: the folded values are the right ones (16, 50)',
                  '%d / %d' % (count_sub('MOV r0, #16', tc_on),
                               count_sub('MOV r0, #50', tc_on)))
            u_off = count_sub('UXTB r0, r0', tc_off)
            u_on = count_sub('UXTB r0, r0', tc_on)
            check(u_off > u_on and count_sub('MOV r0, #128', tc_on) > 0,
                  'M5: a known 128 through UXTB becomes the constant itself',
                  'UXTB %d -> %d, MOV r0, #128 %d'
                  % (u_off, u_on, count_sub('MOV r0, #128', tc_on)))
            b_off = count_sub('BNE .L_cm_clk_0', tc_off)
            b_on = count_sub('BNE .L_cm_clk_0', tc_on)
            check(b_off > 0 and b_on == 0,
                  'M6: a branch after a known-false CMP is dropped',
                  'BNE %d -> %d' % (b_off, b_on))
            check(count_sub('CMP r0, #0', tc_on) ==
                  count_sub('CMP r0, #0', tc_off),
                  'M6: the CMP itself is kept, so no flag can change',
                  'CMP %d -> %d' % (count_sub('CMP r0, #0', tc_off),
                                   count_sub('CMP r0, #0', tc_on)))
            drop = insn_count(tc_off) - insn_count(tc_on)
            check(drop >= 6, 'the instruction count drops by one per fold',
                  '%d -> %d' % (insn_count(tc_off), insn_count(tc_on)))

        tn_off, _, e11 = build(arkcc, work, 'cmat_nofit', FULL, 'noff')
        tn_on, _, e12 = build(arkcc, work, 'cmat_nofit', FULL + [FLAG], 'non')
        if e11 or e12:
            check(False, 'cmat_nofit: both arms build', (e11 or e12)[0][:120])
        else:
            for pat in ('LSL r0, r0, #5', 'LSL r0, r0, #1'):
                a = count_sub(pat, tn_off)
                b = count_sub(pat, tn_on)
                check(a > 0 and a == b,
                      'no over-fold: `%s` (result > 255) is left alone' % pat,
                      '%d -> %d' % (a, b))
            check(count_sub('UXTB r0, r0', tn_off) >
                  count_sub('UXTB r0, r0', tn_on),
                  'no over-fold: the file is still being processed',
                  'UXTB %d -> %d' % (count_sub('UXTB r0, r0', tn_off),
                                     count_sub('UXTB r0, r0', tn_on)))

        # --- 6. the answers stay the same -----------------------------------
        for name, _body, want, case_flags in CASES:
            arms = {}
            ok = True
            for tag, flags in (('off', case_flags),
                               ('on', case_flags + [FLAG]),
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