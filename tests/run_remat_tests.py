#!/usr/bin/env python3
"""Gate for same-value re-materialisation (0.9.1, S21).

One switch, one rule (`ark_remat_function`, backend_arm.c): a constant put
into a register twice along the same straight line, with nothing writing the
register in between, is kept once and deleted after that:

    MOV rX, #imm   /  MOVW rX, #imm        MOV rX, #imm   /  MOVW rX, #imm
    ...              nothing writes rX     ...
    MOV rX, #imm   /  MOVW rX, #imm   ->   (deleted)
    or the same pair of `LDR rX, .Llit_k` loads from the literal pool.

The rule, with every guard, is frozen in docs/EXPR_MODEL.md section 31.2; the
measurements and the verdict are in sections 32.1 and 32.2.

What this gate pins:

  1. OFF IS OFF.  All 95 translation units, with the switch off, come out
     byte-identical to the same build with `-fno-opt-remat` -- both on the
     31-flag baseline (10,172 instructions / 372,761 bytes) and on the
     S17+S19-a stack (9,775 / 358,547).
  2. IT FIRES, AND ONLY BY THE RULE.  The switch-on text is compared against
     `tests/rm_oracle.py` -- a second implementation that shares no code with
     the compiler, re-parses the text and re-derives the rule -- and comes
     out byte-identical for all 95 units on both arms: 115 sites, 53 of them
     `MOV` and 62 `LDR` from the pool, and exactly 115 instructions fewer
     (10,057 / 370,454 and 9,660 / 356,240).
  3. EVERY SITE IS RE-PROVED FROM THE SWITCH-OFF TEXT.  Both texts are walked
     with a cursor: the second line of each pair is gone, every other line is
     untouched, and the surviving first line still carries the value.  The
     guards are then restated from the switch-off text alone: the two lines
     materialise the same value into the same register, nothing between them
     writes that register, no label a branch can land on sits between them,
     no branch, return or call does either, and neither line is under an IT.
  4. IT DECLINES WHEN IT MUST.  Hand-written texts, one guard broken each: a
     write of another value in between, a branch in between, a referenced
     label in between, an IT in between, and a different immediate (and a
     MOV/MOVW mismatch) -- none may produce a site; two more, one of each
     form, must produce exactly one site with the expected text.
  5. THE ANSWER DOES NOT CHANGE.  One emit-and-run fixture carrying seven
     sites (four `MOV`, three `LDR` from the pool) is executed in both arms
     over 8 inputs against a mapped peripheral page: the same value comes
     back, the same RAM snapshot is left behind, and the value is the one
     computed in Python from the C source.  The switch-off arm really carries
     seven sites and the switch-on arm none.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_REMAT=0 refuses
     the switch by name (C3900U) and still compiles the same text without it.

Usage: run_remat_tests.py [path-to-arkcc]
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
import af_oracle as A
import rm_oracle

try:
    from unicorn import (Uc, UcError, UC_ARCH_ARM, UC_MODE_MCLASS,
                         UC_MODE_THUMB, UC_PROT_ALL,
                         UC_HOOK_MEM_FETCH_UNMAPPED)
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_SP, UC_ARM_REG_LR
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

FLAG = ['-fopt-remat']
NOFLAG = ['-fno-opt-remat']
STACK = ['-fopt-chainfold', '-fopt-pushpop']

WANT_OFF_INSNS = 10172
WANT_OFF_BYTES = 372761
WANT_ON_INSNS = 10057
WANT_ON_BYTES = 370454
WANT_STACK_INSNS = 9775
WANT_STACK_BYTES = 358547
WANT_STACK_ON_INSNS = 9660
WANT_STACK_ON_BYTES = 356240

WANT_SITES = 115
WANT_MOV = 53
WANT_LDR = 62
# Sites per translation unit.
WANT_TU = {'main.c': 18, 'stm32f4xx_hal_dma.c': 16,
           'stm32f4xx_hal_flash_ex.c': 14, 'stm32f4xx_hal_flash.c': 13,
           'stm32f4xx_hal_rcc.c': 13, 'stm32f4xx_hal_rcc_ex.c': 9,
           'gpio.c': 8, 'stm32f4xx_hal.c': 7, 'stm32f4xx_hal_dma_ex.c': 3,
           'stm32f4xx_hal_gpio.c': 3, 'stm32f4xx_ll_utils.c': 3,
           'stm32f4xx_hal_msp.c': 2, 'stm32f4xx_hal_pwr_ex.c': 2,
           'system_stm32f4xx.c': 1, 'stm32f4xx_hal_cortex.c': 1,
           'stm32f4xx_hal_exti.c': 1, 'stm32f4xx_hal_pwr.c': 1}

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

# --- 3. per-site re-proof --------------------------------------------------

def reprove(name, off_text, on_text, sites):
    """Walk the two texts; return the list of complaints.

    The switch-off text loses the second line of every pair and keeps the
    first -- sites that share an `at` share that kept line and each lose their
    own `second`.  The switch-on text is the surviving text; both sides are
    walked with one cursor over the kept lines, so any other change shows up
    at once.
    """
    a, b = off_text.splitlines(), on_text.splitlines()
    gone = set()
    for s in sites:
        gone.add(s['second'])
    kept = [i for i in range(len(a)) if i not in gone]
    if len(kept) != len(b):
        return ['%s: on side has %d lines, the kept lines number %d'
                % (name, len(b), len(kept))]
    bad = []
    for k, i in enumerate(kept):
        if a[i] != b[k]:
            bad.append('%s: switch-on line %d reads %r, expected %r'
                       % (name, k, b[k], a[i]))
            return bad
    for s in sites:
        if a[s['at']].strip() != a[s['second']].strip():
            bad.append('%s: the pair at %d/%d is not the same line'
                       % (name, s['at'], s['second']))
            return bad
        if a[s['second']].strip() != s['line']:
            bad.append('%s: the site at %d reports %r, the text says %r'
                       % (name, s['second'], s['line'],
                          a[s['second']].strip()))
            return bad
    return bad

def guard_ok(text, site):
    """Re-derive every guard of one site from the switch-off text alone.

    Nothing here reuses the pass: the straight line is walked by hand, and
    "nothing writes rX" is restated as a scan over the instructions in
    between, with an earlier duplicate -- which is deleted in its own right --
    counted as harmless.
    """
    t = A.Text(text)
    i, j = site['at'], site['second']
    if t.kind[i] != 1 or t.kind[j] != 1:
        return 'not two instructions'
    if t.it[i] or t.it[j]:
        return 'under an IT'
    ida, idb = rm_oracle.ident(t.ins[i]), rm_oracle.ident(t.ins[j])
    if ida is None:
        return 'the first line does not materialise a constant'
    if idb is None or idb[0] != ida[0] or idb[1] != ida[1]:
        return 'the second line is not the same value in the same register'
    rx = ida[0]
    if site['reg'] != rx:
        return 'the site reports r%d, the text says r%d' % (site['reg'], rx)
    refs = rm_oracle.label_refs(t)
    for k in range(i + 1, j):
        if t.kind[k] == 2:
            if k in refs:
                return 'the label %r at %d can be entered' % (
                    t.lines[k].strip(), k)
            continue
        if t.kind[k] != 1:
            continue
        if t.it[k]:
            return 'an IT at %d' % k
        mn, ops = t.ins[k]
        if A.branch_kind(mn) or A.ends_block(mn, ops):
            return 'a branch at %d (%s)' % (k, mn)
        nxt = rm_oracle.ident(t.ins[k])
        if nxt is not None and nxt[0] == rx and nxt[1] == ida[1]:
            continue                       # its own duplicate, deleted too
        _rd, wr = A.rw(mn, ops)
        if wr & (1 << rx):
            return 'r%d is written at %d (%s)' % (rx, k, mn)
    if t.lines[i].strip() != t.lines[j].strip():
        return 'the two lines do not read the same'
    if site['line'] != t.lines[j].strip():
        return 'the reported line differs'
    return None

# --- 4. hand-written controls ---------------------------------------------

POS_MOV = """\
f:
    MOV r0, #0
    STR r0, [r6, #4]
    MOV r0, #0
    STR r0, [r6, #8]
    POP {pc}
"""
POS_LDR = """\
f:
    LDR r5, .Llit_1_0_0
    LDR r0, [r5, #0]
    LDR r5, .Llit_1_0_0
    LDR r0, [r5, #0]
    POP {pc}
"""
WRITE_TEXT = """\
f:
    MOV r0, #1
    MOV r0, #2
    MOV r0, #1
    POP {pc}
"""
BRANCH_TEXT = """\
f:
    MOV r2, #7
    B .Lx
    MOV r2, #7
.Lx:
    POP {pc}
"""
REFLAB_TEXT = """\
f:
    CMP r1, #0
    BEQ .Lx
    MOV r2, #7
.Lx:
    MOV r2, #7
    POP {pc}
"""
IT_TEXT = """\
f:
    MOV r2, #7
    CMP r1, #0
    IT EQ
    MOV r2, #7
    POP {pc}
"""
DIFF_TEXT = """\
f:
    MOV r0, #1
    MOV r0, #2
    POP {pc}
"""
MIX_TEXT = """\
f:
    MOV r0, #1
    MOVW r0, #1
    POP {pc}
"""

# --- 5. execution ---------------------------------------------------------

FIXTURE = r'''
typedef struct { unsigned a, b, c, d; } S;
volatile unsigned in;
volatile unsigned out;
S gs;
#define REG (*(volatile unsigned *)0x40023830u)

__attribute__((noinline)) unsigned zero_path(S *p)
{
    p->a = 0u; p->b = 0u; p->c = 0u; p->d = 0u;
    return in;
}

__attribute__((noinline)) unsigned reg_path(void)
{
    REG = in;
    REG = in | 1u;
    REG = in & 3u;
    return REG;
}

int main(void)
{
    unsigned i, acc = 0u, t;
    for (i = 0u; i < 8u; i++) {
        in = i * 5u + 1u;
        t = zero_path(&gs);
        acc = acc * 31u + t + gs.a + gs.d;
        acc = acc * 31u + reg_path();
    }
    out = acc;
    return (int)(acc & 0xFFu);
}
'''

def expected_value(rounds=8):
    """Recompute FIXTURE's return value from the C source, in Python."""
    acc = 0
    for i in range(rounds):
        n = i * 5 + 1
        acc = (acc * 31 + n + 0 + 0) & 0xFFFFFFFF
        acc = (acc * 31 + (n & 3)) & 0xFFFFFFFF
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
    uc.mem_map(0x40000000, 0x40000, UC_PROT_ALL)     # the fixture's register
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

    work = tempfile.mkdtemp(prefix='arkcc_rm_')
    try:
        # --- 1. off is off ------------------------------------------------
        off, errs = corpus_build(arkcc, work, [], 'off', units)
        offb, errs2 = corpus_build(arkcc, work, NOFLAG, 'offb', units)
        soff, errs3 = corpus_build(arkcc, work, STACK, 'soff', units)
        soffb, errs4 = corpus_build(arkcc, work, STACK + NOFLAG, 'soffb', units)
        if errs or errs2 or errs3 or errs4:
            check(False, 'the corpus compiles with the switch off',
                  (errs + errs2 + errs3 + errs4)[0][:120])
            return 1
        diff = [k for k in off if off[k] != offb[k]]
        check(not diff, 'with the switch off the text is byte-identical to '
                        'the same build with -fno-opt-remat',
              '%d file(s) differ' % len(diff))
        sdiff = [k for k in soff if soff[k] != soffb[k]]
        check(not sdiff, 'the same holds on top of -fopt-chainfold '
                         '-fopt-pushpop',
              '%d file(s) differ' % len(sdiff))
        total_i = sum(insn_count(t) for t in off.values())
        total_b = sum(len(t.encode('utf-8')) for t in off.values())
        check(total_i == WANT_OFF_INSNS and total_b == WANT_OFF_BYTES,
              'the unoptimised corpus still totals %d instructions / %d bytes'
              % (WANT_OFF_INSNS, WANT_OFF_BYTES),
              '%d insns / %d bytes' % (total_i, total_b))
        stack_i = sum(insn_count(t) for t in soff.values())
        stack_b = sum(len(t.encode('utf-8')) for t in soff.values())
        check(stack_i == WANT_STACK_INSNS and stack_b == WANT_STACK_BYTES,
              'the S17+S19-a baseline still totals %d instructions / %d bytes'
              % (WANT_STACK_INSNS, WANT_STACK_BYTES),
              '%d insns / %d bytes' % (stack_i, stack_b))

        # --- 2. it fires, and only by the rule ----------------------------
        for tag, fl, base, want_i, want_b in (
                ('on', FLAG, off, WANT_ON_INSNS, WANT_ON_BYTES),
                ('son', STACK + FLAG, soff, WANT_STACK_ON_INSNS,
                 WANT_STACK_ON_BYTES)):
            on, errs = corpus_build(arkcc, work, fl, tag, units)
            if errs:
                check(False, 'the %s arm compiles the corpus' % tag,
                      errs[0][:120])
                return 1
            drift, bad_sites, reasons = [], [], []
            kinds = {'MOV': 0, 'LDR': 0}
            per_tu = {}
            for k in sorted(base):
                chunks = rm_oracle.one_pass(base[k])
                if chunks[0] != on[k]:
                    drift.append(k)
                ss = chunks[1]
                for s in ss:
                    kinds[s['key'].split()[0]] += 1
                    why = guard_ok(base[k], s)
                    if why is not None:
                        reasons.append('%s:%d %s' % (k, s['at'], why))
                bad_sites += reprove(k, base[k], on[k], ss)
                if ss:
                    per_tu[k.split('/')[-1]] = len(ss)
            check(not drift, 'rm_oracle reproduces all %d %s translations '
                             'byte for byte' % (len(base), tag),
                  '; '.join(drift[:3]) or 'no drift')
            on_i = sum(insn_count(t) for t in on.values())
            on_b = sum(len(t.encode('utf-8')) for t in on.values())
            check(on_i == want_i and on_b == want_b,
                  'the %s arm totals %d instructions / %d bytes'
                  % (tag, want_i, want_b),
                  '%d insns / %d bytes' % (on_i, on_b))
            check(on_i == sum(insn_count(t) for t in base.values()) - WANT_SITES,
                  'the %s arm removes exactly %d instructions'
                  % (tag, WANT_SITES), '%d' % on_i)
            n = sum(kinds.values())
            check(n == WANT_SITES and kinds['MOV'] == WANT_MOV and
                  kinds['LDR'] == WANT_LDR,
                  'the %s corpus holds exactly %d sites: %d MOV, %d pool LDR'
                  % (tag, WANT_SITES, WANT_MOV, WANT_LDR), '%s' % kinds)
            check(per_tu == WANT_TU,
                  'the %s sites are distributed as pinned' % tag,
                  '%s' % per_tu)
            check(not reasons,
                  'every %s site satisfies every guard when it is restated '
                  'from the switch-off text' % tag,
                  '; '.join(reasons[:3]) or '%d sites' % n)
            check(not bad_sites,
                  'every %s site deletes the duplicate and touches nothing '
                  'else' % tag, '; '.join(bad_sites[:3]) or '%d sites' % n)

        # --- 4. it declines when it must ---------------------------------
        for name, text in (('write', WRITE_TEXT), ('branch', BRANCH_TEXT),
                           ('ref_label', REFLAB_TEXT), ('it', IT_TEXT),
                           ('diff', DIFF_TEXT), ('mix', MIX_TEXT)):
            ss = rm_oracle.one_pass(text)[1]
            why = None
            if ss:
                why = guard_ok(text, ss[0]) or 'a site was accepted'
            check(not ss, 'the %s control produces no site' % name,
                  '%r' % (why or [s['line'] for s in ss]))
        for name, text, want in (
                ('MOV', POS_MOV, 'MOV r0, #0'),
                ('LDR', POS_LDR, 'LDR r5, .Llit_1_0_0')):
            ss = rm_oracle.one_pass(text)[1]
            ok = len(ss) == 1 and ss[0]['line'] == want and \
                guard_ok(text, ss[0]) is None
            check(ok, 'the %s control is reported as one site reading %r'
                  % (name, want),
                  '%s' % ([(s['at'], s['second'], s['line']) for s in ss]))

        # --- 5. the answer does not change --------------------------------
        if not HAVE_UNICORN:
            skip('the two arms agree when the fixture is executed',
                 'python package unicorn missing')
        else:
            fx_src = os.path.join(work, 's21_fixture.c')
            with open(fx_src, 'w', newline='\n', encoding='utf-8') as fh:
                fh.write(H.STARTUP + FIXTURE)
            vals, snaps, sites_per_arm, failed = {}, {}, {}, []
            for tag, fl in (('off', []), ('on', FLAG)):
                txt, te = build_asm(arkcc, work, fx_src, STACK + fl, 'fxr_' + tag)
                img, ie = build_image(arkcc, work, fx_src, STACK + fl,
                                      'fxri_' + tag)
                if te or ie:
                    failed.append('%s: %s' % (tag, (te or ie)[:100]))
                    continue
                ss = rm_oracle.one_pass(txt)[1]
                sites_per_arm[tag] = ss
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
                kk = {}
                for s in sites_per_arm['off']:
                    kk[s['key'].split()[0]] = kk.get(s['key'].split()[0], 0) + 1
                check(len(sites_per_arm['off']) == 7 and kk == {'MOV': 4,
                      'LDR': 3} and not sites_per_arm['on'],
                      'the executed fixture really carries seven sites (four '
                      'MOV, three pool LDR), and the optimised arm none',
                      'off %d %s, on %d' % (len(sites_per_arm['off']), kk,
                                            len(sites_per_arm['on'])))
                check(vals['off'] == want and vals['on'] == want,
                      'both arms return the value the C source says (%d)'
                      % want, 'off=%d on=%d' % (vals['off'], vals['on']))
                check(snaps['off'] == snaps['on'],
                      'both arms leave the same RAM snapshot',
                      '%d bytes each' % len(snaps['off']))

        # --- 6. cropped out, refused -------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_REMAT=0'],
                                   'arkcc_norm')
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
                                           '-fopt-remat'], work)
            check(rc != 0 and 'C3900U' in log and '-fopt-remat' in log,
                  'the cropped build refuses -fopt-remat by name',
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
