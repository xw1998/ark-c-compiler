#!/usr/bin/env python3
"""Gate for in-place instruction-selection peepholes (0.9.1, S54).

One switch, four rules (`ark_isel2_function`, backend_arm.c), each of which
deletes exactly one instruction and adds none:

    R1  AND rD, rS, #2^k / CMP rD, #2^k / B{EQ,NE}  ->  ANDS rD, rS, #2^k / B{swapped}
    R2  AND rD, rS, #m   / CMP rD, #0    / B{EQ,NE}  ->  ANDS rD, rS, #m    / B
    R3  MOV rT, rB       / OP rT, X                  ->  OP rT, rB, X
    R4  LDRB|LDRH|LDRSB|LDRSH rD, [...] / <same extension> rD, rD -> the load only

The rules and every guard are frozen in docs/EXPR_MODEL.md section 54.1; the
measurements, the withdrawals (R5 epilogue, R6 constant compare) and the
verdict are in 54.2 and 54.3.

What this gate pins:

  1. OFF IS OFF.  All 95 translation units on top of -fopt-chainfold
     -fopt-pushpop -fopt-remat, with the switch off, are byte-identical to the
     same build with `-fno-opt-isel2`, and still total 9,588 instructions /
     354,989 bytes.
  2. IT FIRES, AND ONLY BY THE RULE.  The switch-on text is compared against
     `tests/is2_oracle.py` -- a second implementation that shares no code with
     the compiler, re-parses the text and re-derives the rules and every guard
     -- and comes out byte-identical for all 95 units: 9,440 instructions /
     353,037 bytes, 148 sites (R1 35, R2 24, R3 70, R4 19), distributed over
     13 units exactly as pinned.  No unit grows in instructions or in bytes.
  3. IT DECLINES WHEN IT MUST.  Hand-written texts, one guard broken each --
     a referenced label between the instructions, an `IT`, a following
     instruction that reads the flags, an `AND`/`CMP` pair with no common
     value, a mismatched extension after a narrow load, an `sp` operand in
     R3's forwarded position -- produce no site, and four positive texts each
     produce exactly one site with the expected text.
  4. THE ANSWER DOES NOT CHANGE.  One emit-and-run fixture carrying four sites
     (two R1, one R3, one R4) is executed in both arms over an 8-round loop
     against a two-register peripheral page: the same value comes back, the
     same RAM snapshot is left behind, and the value is the one computed in
     Python from the C source.  The switch-off arm really carries the four
     sites and the switch-on arm none.
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_ISEL2=0 refuses
     the switch by name (C3900U) and still compiles the same text without it.

Usage: run_isel2_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import struct
import sys
import tempfile
import shutil

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import run_chainfold_tests as H        # the shared corpus harness
import is2_oracle as O

try:
    from unicorn import (Uc, UcError, UC_ARCH_ARM, UC_MODE_MCLASS,
                         UC_MODE_THUMB, UC_PROT_ALL,
                         UC_HOOK_MEM_FETCH_UNMAPPED)
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_SP, UC_ARM_REG_LR
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

FLAG = ['-fopt-isel2']
NOFLAG = ['-fno-opt-isel2']
STACK = ['-fopt-chainfold', '-fopt-pushpop', '-fopt-remat']

WANT_OFF_INSNS = 9588
WANT_OFF_BYTES = 354989
WANT_ON_INSNS = 9440
WANT_ON_BYTES = 353037

WANT_SITES = 148
WANT_RULES = {'R1': 35, 'R2': 24, 'R3': 70, 'R4': 19}
# Sites per translation unit (only the units that carry one).
WANT_TU = {'stm32f4xx_hal.c': 1, 'stm32f4xx_hal_cortex.c': 25,
           'stm32f4xx_hal_dma.c': 21, 'stm32f4xx_hal_exti.c': 7,
           'stm32f4xx_hal_flash.c': 9, 'stm32f4xx_hal_flash_ex.c': 14,
           'stm32f4xx_hal_gpio.c': 13, 'stm32f4xx_hal_pwr.c': 5,
           'stm32f4xx_hal_pwr_ex.c': 2, 'stm32f4xx_hal_rcc.c': 37,
           'stm32f4xx_hal_rcc_ex.c': 8, 'stm32f4xx_ll_utils.c': 3,
           'system_stm32f4xx.c': 3}

TU_DMA = 'stm32f4xx_hal_dma.c'

check = H.check
skip = H.skip
run = H.run
read_text = H.read_text
insn_count = H.insn_count
build_asm = H.build_asm
build_image = H.build_image
build_arkcc = H.build_arkcc
corpus_units = H.corpus_units
corpus_build = H.corpus_build

# --- 3. hand-written controls ---------------------------------------------

POS_R1 = """\
f:
    AND r0, r1, #128
    CMP r0, #128
    BNE .Lx
    POP {pc}
.Lx:
    POP {pc}
"""
POS_R2 = """\
f:
    AND r2, r3, #6
    CMP r2, #0
    BEQ .Lx
    POP {pc}
.Lx:
    POP {pc}
"""
POS_R3 = """\
f:
    MOV r0, r5
    EOR r0, r7
    POP {pc}
"""
POS_R4 = """\
f:
    LDRSB r1, [r2, #3]
    SXTB r1, r1
    POP {pc}
"""
# A referenced label between the `AND` and the `CMP`: a branch lands on the
# compare, so deleting it would delete code that entry needs.
NEG_REFLAB = """\
f:
    AND r0, r1, #4
    B .Lmid
.Lmid:
    CMP r0, #0
    BEQ .Lx
    POP {pc}
.Lx:
    POP {pc}
"""
NEG_IT = """\
f:
    CMP r4, #0
    IT EQ
    AND r0, r1, #4
    CMP r0, #0
    BEQ .Lx
    POP {pc}
.Lx:
    POP {pc}
"""
# The instruction after the branch reads the flags the rewrite would change.
NEG_FLAGS = """\
f:
    AND r0, r1, #4
    CMP r0, #0
    BEQ .Lx
    BNE .Ly
.Lx:
    POP {pc}
.Ly:
    POP {pc}
"""
NEG_VALUE = """\
f:
    AND r0, r1, #3
    CMP r0, #5
    BEQ .Lx
    POP {pc}
.Lx:
    POP {pc}
"""
# A *different* extension is not the one the load performed.
NEG_EXT = """\
f:
    LDRB r1, [r2]
    SXTB r1, r1
    POP {pc}
"""
NEG_SP = """\
f:
    MOV r0, r5
    ADD r0, sp
    POP {pc}
"""

# --- 4. execution ---------------------------------------------------------

FIXTURE = r'''
typedef struct { unsigned char b[8]; } S;
volatile unsigned in;
volatile unsigned out;
S gs;

__attribute__((noinline)) unsigned bit_path(unsigned x)
{
    unsigned r = 0u;
    if ((x & 0x100u) == 0x100u) r = 1u;
    if ((x & 0x01000000u) == 0x01000000u) r |= 2u;
    return r;
}

__attribute__((noinline)) unsigned byte_path(unsigned char *p)
{
    unsigned i, acc = 0u;
    for (i = 0u; i < 8u; i++)
        acc = acc | p[i];
    return acc;
}

__attribute__((noinline)) unsigned or_path(unsigned char *p)
{
    unsigned acc = 0u;
    acc = acc | p[0];
    acc = acc | p[1];
    acc = acc | p[2];
    return acc;
}

int main(void)
{
    unsigned i, j, x, acc = 0u, v;
    for (i = 0u; i < 8u; i++) {
        x = i * 37u + 5u;
        for (j = 0u; j < 8u; j++)
            gs.b[j] = (unsigned char)((x >> j) & 0xFFu);
        v = bit_path(x) + byte_path(gs.b) + or_path(gs.b);
        acc = acc * 31u + v;
    }
    out = acc;
    return (int)(acc & 0xFFu);
}
'''

ROUNDS = 8


def expected_value():
    """Recompute FIXTURE's return value from the C source, in Python."""
    acc = 0
    for i in range(ROUNDS):
        x = i * 37 + 5
        b = [(x >> j) & 0xFF for j in range(8)]
        r = 0
        if x & 0x100 == 0x100:
            r = 1
        if x & 0x01000000 == 0x01000000:
            r |= 2
        bp = 0
        for v in b:
            bp |= v
        op = b[0] | b[1] | b[2]
        acc = (acc * 31 + r + bp + op) & 0xFFFFFFFF
    return acc & 0xFF


def run_image(blob, max_insn=2000000):
    """Execute an arkc image; return (status, r0, snapshot, detail)."""
    if len(blob) < 8:
        return 'fault', 0, b'', 'image shorter than a vector table'
    sp = struct.unpack_from('<I', blob, 0)[0]
    entry = struct.unpack_from('<I', blob, 4)[0]
    if (entry & 1) == 0:
        return 'fault', 0, b'', 'reset vector has no Thumb bit'
    uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB | UC_MODE_MCLASS)
    uc.mem_map(0x08000000, (len(blob) + 0xFFF) & ~0xFFF, UC_PROT_ALL)
    uc.mem_write(0x08000000, blob)
    uc.mem_map(0x20000000, 0x20000, UC_PROT_ALL)
    uc.mem_map(0x40000000, 0x40000, UC_PROT_ALL)     # the fixture's registers
    sentinel = 0x10000000
    state = {'status': None, 'detail': ''}

    def on_bad_fetch(uc_, access, address, size, value, user):
        if (address & ~1) == sentinel:
            state['status'] = 'returned'
        else:
            state['status'] = 'fault'
            state['detail'] = 'fetch from unmapped 0x%08X' % address
        return False

    uc.hook_add(UC_HOOK_MEM_FETCH_UNMAPPED, on_bad_fetch)
    uc.reg_write(UC_ARM_REG_SP, sp)
    uc.reg_write(UC_ARM_REG_LR, sentinel | 1)
    try:
        uc.emu_start(entry, 0, count=max_insn)
    except UcError:
        if state['status'] is None:
            return 'fault', 0, b'', 'unhandled exception'
    value = uc.reg_read(UC_ARM_REG_R0)
    snap = bytes(uc.mem_read(0x20000000, 0x100))
    if state['status'] == 'fault':
        return 'fault', value, snap, state['detail']
    if state['status'] == 'returned':
        return 'returned', value, snap, ''
    return 'limit', value, snap, 'instruction budget spent'

# --- main ------------------------------------------------------------------

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2
    units = corpus_units()
    if len(units) != 95:
        print('FAIL  corpus is %d files, expected 95' % len(units))
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_is2_')
    try:
        # --- 1. off is off ------------------------------------------------
        off, errs = corpus_build(arkcc, work, STACK, 'soff', units)
        offb, errs2 = corpus_build(arkcc, work, STACK + NOFLAG, 'soffb', units)
        if errs or errs2:
            check(False, 'the corpus compiles with the switch off',
                  (errs + errs2)[0][:120])
            return 1
        sdiff = [k for k in off if off[k] != offb[k]]
        check(not sdiff, 'with the switch off the text is byte-identical to '
                         'the same build with -fno-opt-isel2',
              '%d file(s) differ' % len(sdiff))
        off_i = sum(insn_count(t) for t in off.values())
        off_b = sum(len(t.encode('utf-8')) for t in off.values())
        check(off_i == WANT_OFF_INSNS and off_b == WANT_OFF_BYTES,
              'the switch-off baseline still totals %d instructions / '
              '%d bytes' % (WANT_OFF_INSNS, WANT_OFF_BYTES),
              '%d insns / %d bytes' % (off_i, off_b))

        # --- 2. it fires, and only by the rule ----------------------------
        on, errs = corpus_build(arkcc, work, STACK + FLAG, 'son', units)
        if errs:
            check(False, 'the switch-on arm compiles the corpus', errs[0][:120])
            return 1
        drift, per_tu, rules, grew = [], {}, {}, []
        for k in sorted(off):
            exp, c = O.apply_text(off[k])
            if exp != on[k]:
                drift.append(k)
            for name, n in c.items():
                rules[name] = rules.get(name, 0) + n
            n = sum(c.values())
            if n:
                per_tu[k.split('/')[-1]] = n
            if insn_count(on[k]) > insn_count(off[k]) or \
                    len(on[k].encode('utf-8')) > len(off[k].encode('utf-8')):
                grew.append(k)
        check(not drift, 'is2_oracle reproduces all %d translations byte for '
                         'byte' % len(off), '; '.join(drift[:3]) or 'no drift')
        on_i = sum(insn_count(t) for t in on.values())
        on_b = sum(len(t.encode('utf-8')) for t in on.values())
        check(on_i == WANT_ON_INSNS and on_b == WANT_ON_BYTES,
              'the switch-on arm totals %d instructions / %d bytes'
              % (WANT_ON_INSNS, WANT_ON_BYTES),
              '%d insns / %d bytes' % (on_i, on_b))
        check(on_i == off_i - WANT_SITES,
              'the switch removes exactly %d instructions' % WANT_SITES,
              '%d removed' % (off_i - on_i))
        check(rules == WANT_RULES,
              'the corpus holds exactly the pinned rule mix %s' % WANT_RULES,
              '%s' % rules)
        check(per_tu == WANT_TU,
              'the sites are distributed over the units as pinned',
              '%d unit(s) differ' % len(set(per_tu.items()) ^
                                         set(WANT_TU.items())))
        check(not grew, 'no unit grows in instructions or bytes',
              '%d unit(s) grew' % len(grew))

        # --- 3. it declines when it must ----------------------------------
        for name, text in (('ref_label', NEG_REFLAB), ('it', NEG_IT),
                           ('flags', NEG_FLAGS), ('value', NEG_VALUE),
                           ('extension', NEG_EXT), ('sp', NEG_SP)):
            out, c = O.apply_text(text)
            check(out == text and not c,
                  'the %s control produces no site' % name,
                  '%s' % (c or 'text changed'))
        for name, text, want, rule in (
                ('R1', POS_R1, '    ANDS r0, r1, #128\n    BEQ .Lx', 'R1'),
                ('R2', POS_R2, '    ANDS r2, r3, #6\n    BEQ .Lx', 'R2'),
                ('R3', POS_R3, '    EOR r0, r5, r7', 'R3'),
                ('R4', POS_R4, 'f:\n    LDRSB r1, [r2, #3]', 'R4')):
            out, c = O.apply_text(text)
            ok = c == {rule: 1} and want in out
            check(ok, 'the %s control is reported as one site' % name,
                  '%s -> %r' % (c, out))

        # --- 4. the answer does not change --------------------------------
        if not HAVE_UNICORN:
            skip('the two arms agree when the fixture is executed',
                 'python package unicorn missing')
        else:
            fx_src = os.path.join(work, 's54_fixture.c')
            with open(fx_src, 'w', newline='\n', encoding='utf-8') as fh:
                fh.write(H.STARTUP + FIXTURE)
            vals, snaps, sites_per_arm, failed = {}, {}, {}, []
            for tag, fl in (('off', []), ('on', FLAG)):
                txt, te = build_asm(arkcc, work, fx_src, STACK + fl, 'fxi_' + tag)
                img, ie = build_image(arkcc, work, fx_src, STACK + fl,
                                      'fxii_' + tag)
                if te or ie:
                    failed.append('%s: %s' % (tag, (te or ie)[:100]))
                    continue
                _, sites_per_arm[tag] = O.apply_text(txt)
                st, val, snap, det = run_image(img)
                if st != 'returned':
                    failed.append('%s arm did not return (%s %s)'
                                  % (tag, st, det))
                    continue
                vals[tag], snaps[tag] = val, snap
            if failed:
                check(False, 'the two arms execute the fixture',
                      '; '.join(failed[:2]))
            else:
                want = expected_value()
                check(sites_per_arm['off'] == {'R1': 2, 'R3': 1, 'R4': 1} and
                      not sites_per_arm['on'],
                      'the executed fixture really carries four sites '
                      '(two R1, one R3, one R4), and the optimised arm none',
                      'off %s, on %s' % (sites_per_arm['off'],
                                         sites_per_arm['on']))
                check(vals['off'] == want and vals['on'] == want,
                      'both arms return the value the C source says (%d)'
                      % want, 'off=%d on=%d' % (vals['off'], vals['on']))
                check(snaps['off'] == snaps['on'],
                      'both arms leave the same RAM snapshot',
                      '%d bytes each' % len(snaps['off']))

        # --- 5. cropped out, refused -------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_ISEL2=0'],
                                   'arkcc_is2')
        if trimmed is None:
            skip('a cropped build refuses the switch', why)
        else:
            real = os.path.join(ROOT, 'examples/ark_test/Drivers',
                                'STM32F4xx_HAL_Driver/Src', TU_DMA)
            inc = []
            for d in H.INC_DIRS:
                inc += ['-I', d]
            rc, log = run([trimmed, '-S'] + H.ASM_ARM + H.COMMON +
                          ['-O2'] + inc + [real, '-o', 't.s',
                                           '-fopt-isel2'], work)
            check(rc != 0 and 'C3900U' in log and '-fopt-isel2' in log,
                  'the cropped build refuses -fopt-isel2 by name',
                  'rc=%d' % rc)
            rc2, log2 = run([trimmed, '-S'] + H.ASM_ARM + H.COMMON +
                            ['-O2'] + inc + [real, '-o', 't2.s'] + H.BASE,
                            work)
            rc3, log3 = run([arkcc, '-S'] + H.ASM_ARM + H.COMMON +
                            ['-O2'] + inc + [real, '-o', 't3.s'] + H.BASE,
                            work)
            if rc2 != 0 or rc3 != 0:
                check(False, 'the cropped build still compiles the fixture',
                      (log2 or log3).strip().splitlines()[:1])
            else:
                check(read_text(os.path.join(work, 't2.s')) ==
                      read_text(os.path.join(work, 't3.s')),
                      'the cropped build writes the same text as the full '
                      'build when the switch is absent')
        return 1 if H.failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
