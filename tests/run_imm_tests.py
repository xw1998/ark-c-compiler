#!/usr/bin/env python3
"""Gate for the constant-operand folding pass (0.9.1, -fopt-imm).

The ARM backend is a stack machine: `a + 16` arrives as PUSH a / PUSH 16 /
BINARY.  Emitted literally that costs a `MOV r0, #16`, a `PUSH {r0}`, a
`POP {r1}` and a `POP {r0}` around the `ADD` -- four instructions to add a
number the instruction set can carry itself.  In the 0.9.1 HAL corpus "MOV
rN, #imm" is 16% of every instruction emitted, so this is the second largest
single waste after PUSH/POP.

The pass swallows the constant push at the IR layer and emits the consumer
with an immediate operand instead.  It is opt-in and all-or-nothing per
instruction: a constant that is not encodable, or an op with no immediate form,
keeps the register form byte for byte.

Each claim is checked separately, and each would fail on a plausible wrong
implementation:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-imm` produce identical text and
     identical images.  The pass never runs unless asked.
  2. IT PAYS.  Every foldable form (+ - & | ^ << >> and the six comparisons)
     emits an immediate instruction instead of the MOV/PUSH/POP dance, the
     function gets shorter, and the "MOV r0, #<k>" that fed the push is gone.
  3. THE ANSWER IS THE SAME.  The whole fixture returns the value computed in
     Python, on the emulator, in two arms (off, on) -- and in a third arm
     together with -fopt-vstack, because two textual/IR passes in a row must
     not fight over the same value.
  4. NOT ENCODABLE, NOT FOLDED.  A mask that is not a Thumb-2 modified
     immediate (0x12345678), an ADD beyond the 12-bit range (70000), MUL and
     DIV have no immediate form here and must keep the original text exactly.
     No "; imm fold inconsistent" line may appear either: a refused fold is
     not a broken one.
  5. NO DOUBLE-COUNT WITH --reg-top.  --reg-top keeps its own value in r0, so
     the pass must stand aside there rather than swallow a push the other
     path will also consume.  The image must still compute the right answer.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_IMM=0 refuses
     `-fopt-imm` by name (C3900U) instead of accepting it and doing nothing,
     and still compiles the same file normally without the flag.

Usage: run_imm_tests.py [path-to-arkcc]
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

FLAG = '-fopt-imm'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# --- fixtures ---------------------------------------------------------------
# One function per foldable form so each instruction can be checked in the
# body it was emitted into.  The bodies are deliberately tiny: a big one would
# let a wrong pass hide behind an average.  They are `used` on purpose: at -O2
# every call is inlined, and an inlined `static` with no remaining reference is
# no longer emitted at all (the IR-level dead-static pass), which would leave
# the body this gate wants to read empty.
FOLD = """\
int imm_pad_f;
static __attribute__((used)) int f_add(int a) { return a + 16; }
static __attribute__((used)) int f_sub(int a) { return a - 7; }
static __attribute__((used)) int f_and(int a) { return a & 0x0F; }
static __attribute__((used)) int f_or(int a)  { return a | 0x30; }
static __attribute__((used)) int f_xor(int a) { return a ^ 3; }
static __attribute__((used)) int f_shl(int a) { return a << 4; }
static __attribute__((used)) int f_shr(unsigned a) { return a >> 3; }
static __attribute__((used)) int f_lt(int a)  { return a < 5; }
static __attribute__((used)) int f_eq(int a)  { return a == 9; }
int main(void)
{
    return (f_add(1) + f_sub(20) + f_and(0x1ff) + f_or(0) + f_xor(5) +
            f_shl(1) + f_shr(64) + f_lt(3) + f_eq(9)) & 0xFF;
}
"""

# Every body here must come out of the pass byte for byte unchanged.  Same
# `used` reason as above: these bodies exist to be compared.
REJECT = """\
int imm_pad_r;
static __attribute__((used)) int r_and(int a) { return a & 0x12345678; }
static __attribute__((used)) int r_add(int a) { return a + 70000; }
static __attribute__((used)) int r_mul(int a) { return a * 5; }
static __attribute__((used)) int r_div(int a) { return a / 3; }
int main(void)
{
    return (r_and(0xffffffff) + r_add(0) + r_mul(2) + r_div(9)) & 0xFF;
}
"""

def py_fold():
    total = ((1 + 16) + (20 - 7) + (0x1ff & 0x0F) + (0 | 0x30) + (5 ^ 3) +
             (1 << 4) + (64 >> 3) + (1 if 3 < 5 else 0) + (1 if 9 == 9 else 0))
    return total & 0xFF

def py_reject():
    return (0x12345678 + 70000 + 10 + 3) & 0xFF

# function name -> the immediate instruction the pass must have emitted
FOLDED = {
    'f_add': 'ADD r0, r0, #16',
    'f_sub': 'SUB r0, r0, #7',
    'f_and': 'AND r0, r0, #15',
    'f_or':  'ORR r0, r0, #48',
    'f_xor': 'EOR r0, r0, #3',
    'f_shl': 'LSL r0, r0, #4',
    'f_shr': 'LSR r0, r0, #3',
    'f_lt':  'CMP r0, #5',
    'f_eq':  'CMP r0, #9',
}

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
split_functions = V.split_functions
build_arkcc = V.build_arkcc

def body_of(text, name):
    """Body of one top-level label, or ''."""
    funcs = split_functions(text)
    return funcs.get(name, '')

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_imm_')
    try:
        write(os.path.join(work, 'fold.c'), FOLD)
        write(os.path.join(work, 'reject.c'), REJECT)

        # --- 1. off is off --------------------------------------------------
        t_a, b_a, e1 = build(arkcc, work, 'fold', [], 'plain')
        t_b, b_b, e2 = build(arkcc, work, 'fold', ['-fno-opt-imm'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(t_a == t_b and b_a == b_b,
                  'the default build ignores the pass (-O2 == -O2 -fno-opt-imm)',
                  '%d/%d bytes' % (len(b_a), len(b_b)))

        # --- 2. it pays -----------------------------------------------------
        arms = {}
        for tag, flags in (('off', []), ('on', [FLAG]),
                           ('vst', [FLAG, '-fopt-vstack'])):
            t, blob, err = build(arkcc, work, 'fold', flags, tag)
            if err:
                check(False, 'fold: %s arm builds' % tag, err[0][:120])
                arms[tag] = None
            else:
                arms[tag] = (t, blob)
        if all(arms.get(k) for k in ('off', 'on', 'vst')):
            off_t = arms['off'][0]
            on_t = arms['on'][0]
            n_off, n_on = insn_count(off_t), insn_count(on_t)
            check(n_on < n_off, 'fold: instructions drop',
                  '%d -> %d (-%d%%)' % (n_off, n_on,
                                        100 * (n_off - n_on) // n_off))
            check('; imm fold inconsistent' not in on_t,
                  'fold: the decision and the emission agree',
                  'no inconsistent marker')
            for fname, want in FOLDED.items():
                ob = body_of(off_t, fname)
                nb = body_of(on_t, fname)
                if not ob or not nb:
                    check(False, 'fold: %s has a body in both arms' % fname, '')
                    continue
                check(any(l.strip() == want for l in nb.splitlines()),
                      'fold: %s emits "%s"' % (fname, want),
                      'found' if want in nb else 'missing')
                mov = 'MOV r0, #%s' % want.rsplit('#', 1)[1]
                check(mov in ob and mov not in nb,
                      'fold: %s drops the "%s" that fed the push' % (fname, mov),
                      'off-only' if mov in ob and mov not in nb else
                      'off=%s on=%s' % (mov in ob, mov in nb))

            # --- 3. the answer is the same ----------------------------------
            if not V.HAVE_UNICORN:
                skip('fold: emulator value', 'python package unicorn missing')
            else:
                got = {}
                for tag in ('off', 'on', 'vst'):
                    st, val, _ = V.run_image(arms[tag][1])
                    got[tag] = val if st == 'returned' else st
                want = py_fold()
                check(got['off'] == want and got['on'] == want and
                      got['vst'] == want,
                      'fold: off/on/vstack return the Python answer',
                      'off=%s on=%s vst=%s want=%s' % (
                          got['off'], got['on'], got['vst'], want))

        # --- 4. not encodable, not folded -----------------------------------
        r_off, rb_off, e3 = build(arkcc, work, 'reject', [], 'off')
        r_on, rb_on, e4 = build(arkcc, work, 'reject', [FLAG], 'on')
        if e3 or e4:
            check(False, 'reject: both arms build', (e3 or e4)[0][:120])
        else:
            for fname in ('r_and', 'r_add', 'r_mul', 'r_div'):
                bo = body_of(r_off, fname)
                bn = body_of(r_on, fname)
                check(bo and bo == bn,
                      'reject: %s is left byte-for-byte unchanged' % fname,
                      'same' if bo == bn else 'changed')
            check('; imm fold inconsistent' not in r_on,
                  'reject: no inconsistent marker anywhere',
                  'clean' if '; imm fold inconsistent' not in r_on else 'found')
            if not V.HAVE_UNICORN:
                skip('reject: emulator value', 'python package unicorn missing')
            else:
                st_o, v_o, _ = V.run_image(rb_off)
                st_n, v_n, _ = V.run_image(rb_on)
                check(st_o == st_n == 'returned' and v_o == v_n == py_reject(),
                      'reject: off/on return the Python answer',
                      'off=%s on=%s want=%s' % (v_o, v_n, py_reject()))

        # --- 5. no double-count with --reg-top ------------------------------
        t_rt, b_rt, e5 = build(arkcc, work, 'fold', [FLAG, '--reg-top'], 'rt')
        if e5:
            check(False, 'reg-top: the combined build compiles', e5[0][:120])
        else:
            check('; imm fold inconsistent' not in t_rt,
                  'reg-top: the pass stands aside cleanly',
                  'clean' if '; imm fold inconsistent' not in t_rt else 'found')
            if not V.HAVE_UNICORN:
                skip('reg-top: emulator value', 'python package unicorn missing')
            else:
                st, val, _ = V.run_image(b_rt)
                check(st == 'returned' and val == py_fold(),
                      'reg-top: the combined build returns the Python answer',
                      'got=%s want=%s' % (val, py_fold()))

        # --- 6. cropped out, refused ---------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_IMM=0'],
                                   'arkcc_noimm')
        if trimmed is None:
            skip('a cropped build refuses -fopt-imm', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'fold.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-imm by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'fold.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\nimm: %d check(s) FAILED%s' % (
            len(V.failures), (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\nimm: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
