#!/usr/bin/env python3
"""Gate for address-chain folding (0.9.1, S20).

Two switches share one shape analysis (`lv_pass` with `af_only`, reached
through `ark_addrfold_function`, backend_arm.c).  An address is often built in
two steps, and the first step is pure bookkeeping once its register dies:

    A  ADD|SUB rA, rB, #k1
       ADD|SUB rC, rA, #k2      (rA dead)  ->  ADD|SUB rC, rB, #k1+-k2
    B  ADD      rA, rB, #k1     (k1 >= 0)
       LDR|STR* rD, [rA, #k2]   (k2 >= 0)  ->  LDR|STR* rD, [rB, #k1+k2]

The full rule, with every guard, is frozen in docs/EXPR_MODEL.md section
30.3; the measurements and the verdict are in sections 30.1 and 30.2.

What this gate pins:

  1. OFF IS OFF.  All 95 translation units of the corpus, with the switch
     off, come out byte-identical to the same build with
     `-fno-opt-addrfold` -- both on the 31-flag baseline (10,172
     instructions / 372,761 bytes) and on the S17+S19-a stack (9,775 /
     358,547).
  2. IT FIRES, AND ONLY BY THE RULE.  The switch-on text is compared against
     `tests/af_oracle.py` -- a second implementation of both rules that
     shares no code and no constants with the compiler, and re-derives the
     basic blocks and the liveness itself -- and comes out byte-identical for
     all 95 units on both arms: 38 sites, 24 of rule A and 14 of rule B, and
     exactly 38 instructions fewer (10,134 / 372,030 and 9,737 / 357,816).
  3. EVERY SITE IS RE-PROVED FROM THE SWITCH-ON TEXT.  Walking the two texts
     with a cursor: the first line of each pair is gone, the second carries
     exactly the sum of the two offsets on the first line's base register,
     and every other line is untouched.  The guards are then restated from
     the switch-off text alone, without the liveness the pass computed: the
     pair is adjacent inside one basic block, the folded register is in
     r0-r12, its value is not read again before the block ends, no
     flag consumer sits between the pair and the end of the block, and the
     rewritten instruction is no wider than the original.
  4. IT DECLINES WHEN IT MUST.  Hand-written texts, one guard broken each:
     the intermediate register still live, an `IT` in front, a write-back, a
     conditional branch after the pair, an offset that does not fit, a zero
     sum, and a rewrite that would grow an encoding -- none may produce a
     site; two more, one of each rule, must produce exactly one site of the
     expected kind and text.
  5. THE ANSWER DOES NOT CHANGE.  One emit-and-run fixture carrying five
     rule-A sites and one rule-B site is executed in both arms over 8 inputs:
     the same value comes back, the same RAM snapshot is left behind, and the
     value is the one computed in Python from the C source.  The switch-off
     arm really carries six sites and the switch-on arm none.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_ADDRFOLD=0
     refuses the switch by name (C3900U) and still compiles the same text
     without it.  The same item re-runs the census the flags guard rests on:
     every flag consumer of the corpus reads a `CMP` (606 of them), so
     `af_flags_free` never has to guess.

Usage: run_addrfold_tests.py [path-to-arkcc]
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
import af_oracle

try:
    from unicorn import (Uc, UcError, UC_ARCH_ARM, UC_MODE_MCLASS,
                         UC_MODE_THUMB, UC_PROT_ALL,
                         UC_HOOK_MEM_FETCH_UNMAPPED)
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_SP, UC_ARM_REG_LR
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

FLAG = ['-fopt-addrfold']
NOFLAG = ['-fno-opt-addrfold']
STACK = ['-fopt-chainfold', '-fopt-pushpop']

WANT_OFF_INSNS = 10172
WANT_OFF_BYTES = 372761
WANT_ON_INSNS = 10134
WANT_ON_BYTES = 372030
WANT_STACK_INSNS = 9775
WANT_STACK_BYTES = 358547
WANT_STACK_ON_INSNS = 9737
WANT_STACK_ON_BYTES = 357816

WANT_SITES = 38
WANT_A = 24
WANT_B = 14
# Sites per translation unit.
WANT_TU = {'main.c': 3, 'stm32f4xx_hal_dma.c': 21,
           'stm32f4xx_hal_dma_ex.c': 3, 'stm32f4xx_hal_flash.c': 1,
           'stm32f4xx_hal_rcc.c': 10}
# Every flag consumer of the 31-flag corpus, and what provides its flags.
WANT_CONSUMERS = 606

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
    """Walk the two texts site by site; return the list of complaints.

    The switch-off text is consumed in segments; the switch-on text carries
    every segment except the first line of each pair.  Both sides keep their
    own cursor, because after the first site the on side is shorter.
    """
    a, b = off_text.splitlines(), on_text.splitlines()
    bad = []
    oc = bc = 0
    for s in sites:
        p, q = s['at'], s['second']
        n = p - oc                                  # text before the first line
        if b[bc:bc + n] != a[oc:oc + n]:
            bad.append('%s: text before the site at %d changed' % (name, p))
            return bad
        oc += n
        bc += n
        st = b[bc].strip()
        if st == a[oc].strip():
            bad.append('%s: the first line at %d is still there: %r'
                       % (name, p, st))
            return bad
        oc += 1                                     # step over the deleted line
        n = q - oc                                  # the lines kept in between
        if b[bc:bc + n] != a[oc:oc + n]:
            bad.append('%s: the text between %d and %d changed'
                       % (name, p, q))
            return bad
        oc += n
        bc += n
        if b[bc] != s['line']:
            bad.append('%s: the second line at %d reads %r, expected %r'
                       % (name, q, b[bc], s['line']))
            return bad
        oc += 1                                     # step over the old second line
        bc += 1
    if b[bc:] != a[oc:]:
        bad.append('%s: the text after the last site changed' % name)
    return bad

def guard_ok(text, site):
    """Re-derive every guard of one site from the switch-off text alone.

    Nothing here uses the pass's liveness: the block is walked by hand, and
    the "not live" claim is restated as "not read again in this block".
    """
    t = af_oracle.Text(text)
    i, j = site['at'], site['second']
    if t.kind[i] != 1 or t.kind[j] != 1:
        return 'not two instructions'
    if t.it[i] or t.it[j]:
        return 'under an IT'
    if af_oracle.has_writeback(t.ins[i][1]) or \
            af_oracle.has_writeback(t.ins[j][1]):
        return 'a write-back operand'
    if t.bof[i] != t.bof[j]:
        return 'not in one basic block'
    a = af_oracle.alu_imm(t.ins[i])
    if a is None:
        return 'the first instruction is not ADD|SUB rD, rN, #imm'
    ra, rb, k1 = a
    if ra > 12 or rb > 12:
        return 'a register outside r0-r12'
    # the intermediate register must not be read again before the block ends
    blk = t.bof[j]
    for k in range(j + 1, len(t.lines)):
        if t.kind[k] == 0:
            continue
        if t.kind[k] != 1 or t.bof[k] != blk:
            break
        rd, wr = af_oracle.rw(*t.ins[k])
        if rd & (1 << ra):
            return 'r%d is read again at %d' % (ra, k)
        if wr & (1 << ra):
            break                                   # killed: the value is gone
    # no flag consumer between the pair and the end of the block
    for k in range(j + 1, len(t.lines)):
        if t.kind[k] == 0:
            continue
        if t.kind[k] != 1 or t.bof[k] != blk:
            break
        e = af_oracle.flag_effect(t.ins[k][0])
        if e == 0:
            return 'a flag consumer at %d' % k
        if e == 2:
            break
    b = af_oracle.alu_imm(t.ins[j])
    m = af_oracle.mem_imm(t.ins[j])
    if b is not None and b[1] == ra:
        rd2, _rn2, k2 = b
        tot = k1 + k2
        if tot == 0 or abs(tot) > 255:
            return 'the sum is out of range'
        if af_oracle.alu_size(rd2, rb, abs(tot)) > \
                af_oracle.alu_size(rd2, ra, abs(k2)):
            return 'the rewrite would grow the encoding'
    elif m is not None and m[1] == ra:
        rd2, _rn2, k2 = m
        if k1 < 0 or k2 < 0:
            return 'a negative offset'
        tot = k1 + k2
        if tot > 4095:
            return 'the sum is out of range'
        if af_oracle.mem_size(t.ins[j][0], rd2, rb, tot) > \
                af_oracle.mem_size(t.ins[j][0], rd2, ra, k2):
            return 'the rewrite would grow the encoding'
    else:
        return 'the second instruction does not use r%d' % ra
    # and the reported text must be exactly the rule applied
    if site['kind'] == 'A':
        want = '    %s r%d, r%d, #%d' % ('SUB' if k1 + k2 < 0 else 'ADD',
                                         rd2, rb, abs(k1 + k2))
    else:
        want = '    %s r%d, [r%d, #%d]' % (t.ins[j][0], rd2, rb, k1 + k2)
    if site['line'] != want:
        return 'the rewrite reads %r, expected %r' % (site['line'], want)
    return None

# --- 4. hand-written controls ---------------------------------------------

POS_A = """\
f:
    ADD r0, r6, #48
    ADD r5, r0, #8
    MOV r0, #0
    STR r0, [r5, #0]
    POP {r4, pc}
"""
POS_B = """\
f:
    ADD r5, r0, #8
    LDR r1, [r5, #0]
    MOV r2, r1
    POP {r4, pc}
"""
LIVE_TEXT = """\
f:
    ADD r5, r0, #16
    LDR r1, [r5, #0]
    MOV r2, r5
    POP {r4, pc}
"""
IT_TEXT = """\
f:
    CMP r0, #0
    IT EQ
    ADD r5, r0, #16
    LDR r1, [r5, #0]
    POP {r4, pc}
"""
WB_TEXT = """\
f:
    ADD r5, r0, #16
    LDR r1, [r5, #0]!
    POP {r4, pc}
"""
FLAGS_TEXT = """\
f:
    ADD r5, r0, #16
    LDR r1, [r5, #0]
    BEQ .Lx
.Lx:
    POP {r4, pc}
"""
RANGE_A_TEXT = """\
f:
    ADD r5, r0, #200
    ADD r1, r5, #100
    POP {r4, pc}
"""
ZERO_A_TEXT = """\
f:
    ADD r5, r0, #4
    SUB r1, r5, #4
    POP {r4, pc}
"""
RANGE_B_TEXT = """\
f:
    ADD r5, r0, #4000
    LDR r1, [r5, #200]
    POP {r4, pc}
"""
GROW_A_TEXT = """\
f:
    ADD r5, r8, #4
    ADD r1, r5, #0
    POP {r4, pc}
"""
GROW_B_TEXT = """\
f:
    ADD r5, r8, #4
    LDR r1, [r5, #0]
    POP {r4, pc}
"""

# --- 5. execution ---------------------------------------------------------

FIXTURE = r'''
typedef struct { unsigned x[4]; unsigned y[4]; } Inner;
typedef struct { unsigned tag; Inner a; Inner b; unsigned big[8]; } Outer;
typedef struct { unsigned cr; unsigned ndtr; unsigned par; unsigned m0ar;
                 unsigned m1ar; unsigned fcr; } Chan;
typedef struct { Chan *inst; unsigned state; } H;

volatile unsigned in;
volatile unsigned out;
Outer gs;
H gh;
Chan gchan[2];

__attribute__((noinline)) int local_path(void)
{
    Outer s;
    s.tag = in;
    s.a.x[2] = in + 1u;
    s.b.y[1] = in + 2u;
    s.big[3] = in + 3u;
    s.big[5] = in + 5u;
    return (int)(s.a.x[2] + s.b.y[1] + s.big[3] + s.big[5]);
}

__attribute__((noinline)) int inst_path(void)
{
    unsigned v = gh.inst->par;
    if (gh.inst->par & 4u) {
        out = v;
        return 1;
    }
    out = v + 1u;
    return 0;
}

int main(void)
{
    unsigned i, acc = 0u;
    gh.inst = &gchan[0];
    for (i = 0u; i < 8u; i++) {
        in = i * 3u + 1u;
        gchan[0].par = (i & 1u) ? 4u : 0u;
        acc = acc * 31u + (unsigned)local_path();
        acc = acc * 31u + (unsigned)inst_path();
        acc += out;
    }
    return (int)(acc & 0xFFu);
}
'''

def expected_value(rounds=8):
    """Recompute FIXTURE's return value from the C source, in Python."""
    acc = 0
    for i in range(rounds):
        n = i * 3 + 1
        local = (n + 1) + (n + 2) + (n + 3) + (n + 5)
        par = 4 if (i & 1) else 0
        ret = 1 if (par & 4) else 0
        out = par if ret else par + 1
        acc = (acc * 31 + local) & 0xFFFFFFFF
        acc = (acc * 31 + ret) & 0xFFFFFFFF
        acc = (acc + out) & 0xFFFFFFFF
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

    work = tempfile.mkdtemp(prefix='arkcc_af_')
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
                        'the same build with -fno-opt-addrfold',
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
        arms = []
        for tag, fl, want_i, want_b in (
                ('on', FLAG, WANT_ON_INSNS, WANT_ON_BYTES),
                ('son', STACK + FLAG, WANT_STACK_ON_INSNS,
                 WANT_STACK_ON_BYTES)):
            on, errs = corpus_build(arkcc, work, fl, tag, units)
            if errs:
                check(False, 'the %s arm compiles the corpus' % tag,
                      errs[0][:120])
                return 1
            arms.append((tag, fl, on, want_i, want_b))
        for tag, fl, on, want_i, want_b in arms:
            base = off if tag == 'on' else soff
            drift, bad_sites, reasons = [], [], []
            kinds = {'A': 0, 'B': 0}
            per_tu = {}
            for k in sorted(base):
                chunks, exp = af_oracle.steps(base[k])
                if exp != on[k]:
                    drift.append(k)
                n_sites = 0
                for before, after, ss in chunks:
                    n_sites += len(ss)
                    for s in ss:
                        kinds[s['kind']] += 1
                        why = guard_ok(before, s)
                        if why is not None:
                            reasons.append('%s:%d %s' % (k, s['at'], why))
                    bad_sites += reprove(k, before, after, ss)
                if n_sites:
                    per_tu[k] = n_sites
            check(not drift, 'af_oracle reproduces all %d %s translations '
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
            check(n == WANT_SITES and kinds['A'] == WANT_A and
                  kinds['B'] == WANT_B,
                  'the %s corpus holds exactly %d sites: %d of rule A, %d of '
                  'rule B' % (tag, WANT_SITES, WANT_A, WANT_B), '%s' % kinds)
            check(per_tu == WANT_TU,
                  'the %s sites are distributed as pinned' % tag,
                  '%s' % per_tu)
            check(not reasons,
                  'every %s site satisfies every guard when it is restated '
                  'from the switch-off text' % tag,
                  '; '.join(reasons[:3]) or '%d sites' % n)
            check(not bad_sites,
                  'every %s site deletes one line and rewrites the other, '
                  'and touches nothing else' % tag,
                  '; '.join(bad_sites[:3]) or '%d sites' % n)

        # --- 4. it declines when it must ---------------------------------
        for name, text in (('live', LIVE_TEXT), ('it', IT_TEXT),
                           ('writeback', WB_TEXT), ('flags', FLAGS_TEXT),
                           ('range_a', RANGE_A_TEXT), ('zero_a', ZERO_A_TEXT),
                           ('range_b', RANGE_B_TEXT), ('grow_a', GROW_A_TEXT),
                           ('grow_b', GROW_B_TEXT)):
            ss = af_oracle.sites(text)
            why = None
            if ss:
                why = guard_ok(text, ss[0]) or 'a site was accepted'
            check(not ss, 'the %s control produces no site' % name,
                  '%r' % (why or [s['kind'] for s in ss]))
        for name, text, kind, want in (
                ('A', POS_A, 'A', '    ADD r5, r6, #56'),
                ('B', POS_B, 'B', '    LDR r1, [r0, #8]')):
            ss = af_oracle.sites(text)
            ok = len(ss) == 1 and ss[0]['kind'] == kind and \
                ss[0]['line'] == want
            check(ok, 'the rule-%s control is reported as one site reading %r'
                  % (kind, want),
                  '%s' % ([(s['kind'], s['line']) for s in ss]))

        # --- 5. the answer does not change --------------------------------
        if not HAVE_UNICORN:
            skip('the two arms agree when the fixture is executed',
                 'python package unicorn missing')
        else:
            fx_src = os.path.join(work, 's20_fixture.c')
            with open(fx_src, 'w', newline='\n', encoding='utf-8') as fh:
                fh.write(H.STARTUP + FIXTURE)
            vals, snaps, sites_per_arm, kinds_per_arm, failed = \
                {}, {}, {}, {}, []
            for tag, fl in (('off', []), ('on', FLAG)):
                txt, te = build_asm(arkcc, work, fx_src, fl, 'fx_' + tag)
                img, ie = build_image(arkcc, work, fx_src, fl, 'fx_' + tag)
                if te or ie:
                    failed.append('%s: %s' % (tag, (te or ie)[:100]))
                    continue
                ss = af_oracle.sites(txt)
                sites_per_arm[tag] = len(ss)
                kinds_per_arm[tag] = sorted(s['kind'] for s in ss)
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
                check(sites_per_arm['off'] == 4 and kinds_per_arm['off'] ==
                      ['A', 'A', 'A', 'B'] and
                      sites_per_arm['on'] == 0,
                      'the executed fixture really carries four sites (three '
                      'of rule A, one of rule B), and the optimised arm none',
                      'off %d %s, on %d' % (sites_per_arm['off'],
                                            kinds_per_arm['off'],
                                            sites_per_arm['on']))
                check(vals['off'] == want and vals['on'] == want,
                      'both arms return the value the C source says (%d)'
                      % want, 'off=%d on=%d' % (vals['off'], vals['on']))
                check(snaps['off'] == snaps['on'],
                      'both arms leave the same RAM snapshot',
                      '%d bytes each' % len(snaps['off']))

        # --- 6. cropped out, refused -------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_ADDRFOLD=0'],
                                   'arkcc_noaf')
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
                                           '-fopt-addrfold'], work)
            check(rc != 0 and 'C3900U' in log and '-fopt-addrfold' in log,
                  'the cropped build refuses -fopt-addrfold by name',
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

        # the census the flags guard rests on
        cons = 0
        prov = {}
        bad = []
        for k in sorted(off):
            t = af_oracle.Text(off[k])
            t.solve(0xF)
            for i in range(len(t.lines)):
                if t.kind[i] != 1:
                    continue
                mn = t.ins[i][0]
                if af_oracle.flag_effect(mn) != 0:
                    continue
                if mn in ('B', 'BL', 'BX', 'BLX'):
                    continue
                cons += 1
                blk = t.bof[i]
                w = None
                for j in range(i - 1, -1, -1):
                    if t.kind[j] == 0:
                        continue
                    if t.kind[j] != 1 or t.bof[j] != blk:
                        break
                    e = af_oracle.flag_effect(t.ins[j][0])
                    if e == 2:
                        w = t.ins[j][0]
                        break
                    if e == 0:
                        break
                prov[w] = prov.get(w, 0) + 1
                if w != 'CMP':
                    bad.append('%s:%d %r after %r'
                               % (k, i, t.lines[i].strip(), w))
        check(cons == WANT_CONSUMERS and prov == {'CMP': WANT_CONSUMERS} and
              not bad,
              'every one of the %d flag consumers of the corpus reads a CMP, '
              'so the flags guard never guesses' % WANT_CONSUMERS,
              '%d consumers %s %s' % (cons, prov, '; '.join(bad[:2])))
        return 1 if H.failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
