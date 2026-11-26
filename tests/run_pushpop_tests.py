#!/usr/bin/env python3
"""Gate for value-stack round-trip elimination (0.9.1, S19-a).

One switch, one shape analysis (`ark_pushpop_function`, backend_arm.c).  The
IR is a stack machine, so a value that has to survive across another
computation is written as a real machine-stack round trip:

        <def>             ; `MOV|MOVW rX, #imm`, `LDR rX, .Llit`, `MOV rX, rY`
        PUSH {rX}         ; save the value
        ...               ; the ladder / call that needs rX back
        POP {rY}          ; rY = the value again

The saved value is always something the text can produce again, so the round
trip is pure overhead.  The pass deletes the `PUSH` and rewrites the `POP`
either to nothing (when `rY == rX` and no instruction in the span names `rX`)
or to the definition itself.  The full rule, with every guard, is frozen in
docs/EXPR_MODEL.md section 27.3; the measurements and the verdict are in
sections 27.1 and 27.2.

What this gate pins:

  1. OFF IS OFF.  All 95 translation units of the corpus, with the switch
     off, come out byte-identical to the same build with
     `-fno-opt-pushpop`, and still total 10,106 instructions / 371,771 bytes.
  2. IT FIRES, AND ONLY BY THE RULE.  The switch-on text is compared against
     `tests/pp_oracle.py` -- a second implementation of the rule that shares
     no code and no constants with the compiler -- and comes out
     byte-identical for all 95 units: 10,059 / 371,354, 35 sites, 12 of them
     deleting both halves and 23 re-materialising the value at the `POP`.
  3. EVERY SITE IS RE-PROVED FROM THE SWITCH-ON TEXT.  Walking the two texts
     with a cursor: the definition line survives, the span between the
     `PUSH` and the `POP` is untouched, the `PUSH` line is gone, and the
     `POP` line is either gone (`rY == rX`, `rX` untouched) or reads exactly
     the definition again with the `POP`'s destination register -- same
     mnemonic, same operand text.  The sites are disjoint and ordered, and
     exactly one single-register `PUSH` disappears per site (202 -> 167).
  4. IT DECLINES WHEN IT MUST.  Every single-register `PUSH` in the corpus is
     classified from the switch-off text (35 sites, 141 without a
     re-buildable definition, 13 with a nested `PUSH` first, 8 with `sp`
     named in the span, 5 with a call in the span) and the reasons are
     pinned.  Four hand-written texts that each break one guard (definition
     that cannot be rebuilt, a label inside the span that is entered from
     outside, a `BL` inside the span, a `POP {pc}`) must produce no site at
     all, and three more must produce exactly one site of the expected kind.
  5. THE ANSWER DOES NOT CHANGE.  One emit-and-run fixture with two
     re-materialised sites (two different 32-bit peripheral addresses, so a
     lost or swapped constant changes the stored word) returns the same value
     in both arms over 12 inputs, leaves the same peripheral RAM snapshot,
     and matches an expectation computed in Python from the C source.  The
     switch-off arm really carries two sites and the switch-on arm none.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_PUSHPOP=0
     refuses the flag by name (C3900U) and still compiles the same text
     without it.

Usage: run_pushpop_tests.py [path-to-arkcc]
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
import pp_oracle

try:
    from unicorn import (Uc, UcError, UC_ARCH_ARM, UC_MODE_MCLASS,
                         UC_MODE_THUMB, UC_PROT_ALL,
                         UC_HOOK_MEM_FETCH_UNMAPPED)
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_SP, UC_ARM_REG_LR
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

FLAG = ['-fopt-pushpop']
NOFLAG = ['-fno-opt-pushpop']

WANT_OFF_INSNS = 10106
WANT_OFF_BYTES = 371771
WANT_ON_INSNS = 10059
WANT_ON_BYTES = 371354

WANT_SITES = 35
WANT_PAIR = 12
WANT_REMAT = 23
WANT_REMOVED = 2 * WANT_PAIR + WANT_REMAT
# Sites per translation unit.
WANT_TU = {'stm32f4xx_hal_dma.c': 9, 'stm32f4xx_hal_dma_ex.c': 22,
           'stm32f4xx_hal_exti.c': 4}
# Every single-register PUSH of the corpus, classified.
WANT_CENSUS = {'site': 35, 'no_definition': 141, 'nested_push': 13,
               'sp_in_span': 8, 'call_in_span': 5}
WANT_PUSHES = sum(WANT_CENSUS.values())
WANT_PUSHES_ON = WANT_PUSHES - WANT_SITES

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

    The switch-off text `a` is consumed in segments; the switch-on text `b`
    carries every segment except the two halves of each round trip.  Both
    sides get their own cursor, because after the first site the on side is
    shorter than the off side.
    """
    a, b = off_text.splitlines(), on_text.splitlines()
    bad = []
    oc = bc = 0                                 # off / on cursors
    for s in sites:
        p, q, d = s['push'], s['pop'], s['defn']
        # 1. everything before the definition is untouched
        n = d - oc
        if b[bc:bc + n] != a[oc:oc + n]:
            bad.append('%s: text before the site at %d changed' % (name, p))
            return bad
        oc += n
        bc += n
        # 2. the definition line survives as it was
        if b[bc] != a[oc]:
            bad.append('%s: the definition at %d changed: %r -> %r'
                       % (name, d, a[oc], b[bc]))
            return bad
        oc += 1
        bc += 1
        # 3. the lines between the definition and the PUSH are untouched
        n = p - oc
        if b[bc:bc + n] != a[oc:oc + n]:
            bad.append('%s: text between the definition at %d and the PUSH '
                       'at %d changed' % (name, d, p))
            return bad
        oc += n
        bc += n
        # 4. the PUSH line is gone
        st = b[bc].strip()
        if st.startswith('PUSH') or st.startswith('POP'):
            bad.append('%s: the round trip at %d is still there: %r'
                       % (name, p, b[bc]))
            return bad
        oc += 1                                 # step over the PUSH in `a`
        # 5. the span between PUSH and POP is untouched
        n = q - oc
        if b[bc:bc + n] != a[oc:oc + n]:
            bad.append('%s: the span after %d changed' % (name, p))
            return bad
        oc += n
        bc += n
        # 6. the POP line becomes the replacement, or is gone for a pair
        rep = s['rep']
        if rep is None:
            st = b[bc].strip()
            if st.startswith('PUSH') or st.startswith('POP'):
                bad.append('%s: the POP at %d is still there: %r'
                           % (name, q, b[bc]))
                return bad
        else:
            if b[bc] != rep:
                bad.append('%s: the POP at %d reads %r, expected %r'
                           % (name, q, b[bc], rep))
                return bad
            bc += 1
        oc = q + 1
    if b[bc:] != a[oc:]:
        bad.append('%s: the text after the last site changed' % name)
    return bad

def rep_ok(t, s):
    """A re-materialising line must be exactly the definition's mnemonic and
    operand, retargeted to the POP's destination register.  A pair has no
    replacement line, so there is nothing to check."""
    if s['rep'] is None:
        return True
    rx = pp_oracle.push_reg(t.ins[s['push']])
    ry = pp_oracle.pop_reg(t.ins[s['pop']])
    dfn = pp_oracle.definition(t.ins[s['defn']], rx)
    if ry is None or dfn is None:
        return False
    want = '    %s r%d, %s' % (dfn[0], ry, dfn[1])
    return s['rep'] == want

# --- 5. execution ----------------------------------------------------------

FIXTURE = r'''
volatile unsigned in;
volatile unsigned out;

#define FLAG(v) \
    ((v == 0x40026458u) ? 0x00200000u : \
     (v == 0x40026410u) ? 0x00210000u : \
     (v == 0x40026070u) ? 0x00220000u : \
     (v == 0x40026470u) ? 0x00230000u : 0x00100000u)

#define NOTFLAG(v) \
    ((v == 0x40026458u) ? 0x00001111u : \
     (v == 0x40026410u) ? 0x00002222u : \
     (v == 0x40026070u) ? 0x00003333u : \
     (v == 0x40026470u) ? 0x00004444u : 0x00005555u)

__attribute__((noinline)) void store_flag(void)
{
    *(volatile unsigned *)0x40026458u = FLAG(in);
}

__attribute__((noinline)) void store_not(void)
{
    *(volatile unsigned *)0x40026070u = NOTFLAG(in);
}

int main(void)
{
    static const unsigned src[6] = { 0x40026458u, 0x40026410u, 0x40026070u,
                                     0x40026470u, 0u, 1u };
    unsigned i, acc = 0u;
    for (i = 0u; i < 12u; i++) {
        in = src[i % 6u];
        store_flag();
        store_not();
        acc = acc * 31u + (*(volatile unsigned *)0x40026458u >> 12)
                        + (*(volatile unsigned *)0x40026070u >> 8);
    }
    return (int)(acc & 0xFFu);
}
'''

# The two macros above, evaluated in Python (not from any build).
FLAG_TABLE = [0x00200000, 0x00210000, 0x00220000, 0x00230000, 0x00100000,
              0x00100000]
NOT_TABLE = [0x00001111, 0x00002222, 0x00003333, 0x00004444, 0x00005555,
             0x00005555]

# text-level controls: (name, source, expected number of sites, kind, rep)
PAIR_TEXT = """\
f:
    MOV r0, #4
    PUSH {r0}
    LDR r1, [r8, #96]
    POP {r0}
    MUL r0, r1
    POP {r4, pc}
"""
COPY_TEXT = """\
f:
    MOV r0, r1
    PUSH {r0}
    LDR r2, [r8, #96]
    MOV r0, #0
    POP {r3}
    MUL r2, r3
    POP {r4, pc}
"""
REMAT_TEXT = """\
f:
    LDR r0, .Llit_0
    PUSH {r0}
    LDR r0, [r6, #24]
    AND r1, r0, #3
    POP {r0}
    MUL r0, r1
    POP {r4, pc}
"""
# one guard broken per text: nothing may be reported
NO_DEF_TEXT = """\
f:
    ADD r0, r0, #8
    PUSH {r0}
    LDR r1, [r8, #96]
    POP {r0}
    MUL r0, r1
    POP {r4, pc}
"""
OUTSIDE_TEXT = """\
f:
    CMP r5, #0
    BEQ .Linside
    MOV r0, #4
    PUSH {r0}
    LDR r1, [r8, #96]
    B .Lskip
.Linside:
    MOV r2, #7
.Lskip:
    POP {r0}
    MUL r0, r1
    POP {r4, pc}
"""
CALL_TEXT = """\
f:
    MOV r0, #4
    PUSH {r0}
    BL g
    POP {r0}
    POP {r4, pc}
"""
PC_TEXT = """\
f:
    MOV r0, #4
    PUSH {r0}
    LDR r1, [r8, #96]
    POP {pc}
"""


def run_image(blob, max_insn=2000000):
    """Execute an arkc image; return (status, r0, snapshot, detail).

    The fixture stores to two absolute peripheral addresses, so the whole
    0x40020000..0x40030000 window is mapped and snapshotted along with the
    low RAM the compiler's globals live in.
    """
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
    uc.mem_map(0x40020000, 0x10000, UC_PROT_ALL)
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
    snap = (bytes(uc.mem_read(0x40020000, 0x8000)) +
            bytes(uc.mem_read(0x20000000, 0x100)))
    if state['status'] == 'fault':
        return 'fault', value, snap, state['detail']
    if state['status'] == 'returned':
        return 'returned', value, snap, ''
    return 'limit', value, snap, 'instruction budget spent'


def expected_value(rounds=12):
    """Recompute FIXTURE's return value from the C source, in Python."""
    acc = 0
    for i in range(rounds):
        k = i % 6
        acc = (acc * 31 + (FLAG_TABLE[k] >> 12) +
               (NOT_TABLE[k] >> 8)) & 0xFFFFFFFF
    return acc & 0xFF


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

    work = tempfile.mkdtemp(prefix='arkcc_pp_')
    try:
        # --- 1. off is off ------------------------------------------------
        off, errs = corpus_build(arkcc, work, [], 'off', units)
        offb, errs2 = corpus_build(arkcc, work, NOFLAG, 'offb', units)
        if errs or errs2:
            check(False, 'the corpus compiles with the switch off',
                  (errs + errs2)[0][:120])
            return 1
        diff = [k for k in off if off[k] != offb[k]]
        check(not diff, 'with the switch off the text is byte-identical to '
                        'the same build with -fno-opt-pushpop',
              '%d file(s) differ' % len(diff))
        total_i = sum(insn_count(t) for t in off.values())
        total_b = sum(len(t.encode('utf-8')) for t in off.values())
        check(total_i == WANT_OFF_INSNS and total_b == WANT_OFF_BYTES,
              'the unoptimised corpus still totals %d instructions / %d bytes'
              % (WANT_OFF_INSNS, WANT_OFF_BYTES),
              '%d insns / %d bytes' % (total_i, total_b))

        # --- 2. it fires, and only by the rule ----------------------------
        on, errs = corpus_build(arkcc, work, FLAG, 'on', units)
        if errs:
            check(False, 'the -fopt-pushpop arm compiles the corpus',
                  errs[0][:120])
            return 1
        kinds = {'pair': 0, 'copy': 0, 'remat': 0}
        per_tu = {}
        all_sites = {}
        census = {}
        drift = []
        bad_sites = []
        for k in sorted(off):
            t = pp_oracle.Text(off[k])
            ss = pp_oracle.sites(t)
            all_sites[k] = ss
            exp, _ = pp_oracle.transform(off[k])
            if exp != on[k]:
                drift.append(k)
            for s in ss:
                kinds[s['kind']] += 1
            per_tu[k] = len(ss)
            for i in range(len(t.lines)):
                if t.kind[i] == 1 and pp_oracle.push_reg(t.ins[i]) is not None:
                    why = pp_oracle.explain(t, i)
                    census['site' if why is None else why] = \
                        census.get('site' if why is None else why, 0) + 1
            bad_sites += reprove(k, off[k], on[k], ss)
        check(not drift, 'pp_oracle reproduces all %d optimised translations '
                         'byte for byte' % len(off),
              '; '.join(drift[:3]) or 'no drift')
        on_i = sum(insn_count(t) for t in on.values())
        on_b = sum(len(t.encode('utf-8')) for t in on.values())
        check(on_i == WANT_ON_INSNS and on_b == WANT_ON_BYTES,
              'the optimised corpus totals %d instructions / %d bytes'
              % (WANT_ON_INSNS, WANT_ON_BYTES),
              '%d insns / %d bytes' % (on_i, on_b))
        check(on_i == total_i - WANT_REMOVED,
              'the removed instructions are exactly %d' % WANT_REMOVED,
              '%d - %d = %d' % (total_i, WANT_REMOVED, on_i))
        n_sites = sum(kinds.values())
        check(n_sites == WANT_SITES and kinds['pair'] == WANT_PAIR and
              kinds['remat'] == WANT_REMAT and kinds['copy'] == 0,
              'the corpus holds exactly %d sites: %d delete both halves, %d '
              're-materialise the value' % (WANT_SITES, WANT_PAIR,
                                            WANT_REMAT),
              '%s' % kinds)
        touched = dict((k, v) for k, v in per_tu.items() if v)
        check(touched == WANT_TU, 'the sites are distributed as pinned',
              '%s' % touched)

        # --- 3. every site is re-proved from the switch-on text ----------
        check(not bad_sites,
              'every site is re-proved from the optimised text (the '
              'definition survives, the span is untouched, the PUSH is gone '
              'and the POP carries the same operand)',
              '; '.join(bad_sites[:3]) or '%d sites' % n_sites)
        bad_rep = ['%s:%d' % (k, s['pop']) for k in all_sites
                   for s in all_sites[k]
                   if not rep_ok(pp_oracle.Text(off[k]), s)]
        check(not bad_rep, 'every re-materialising line carries the '
                           'definition\'s own operand and the POP\'s '
                           'destination register',
              '; '.join(bad_rep[:3]) or '%d lines' % WANT_REMAT)
        push_off = sum(1 for k in off for ln in off[k].splitlines()
                       if pp_oracle.push_reg(_ins(ln)) is not None)
        push_on = sum(1 for k in on for ln in on[k].splitlines()
                      if pp_oracle.push_reg(_ins(ln)) is not None)
        check(push_off == WANT_PUSHES and push_on == WANT_PUSHES_ON,
              'exactly one single-register PUSH disappears per site '
              '(%d -> %d)' % (WANT_PUSHES, WANT_PUSHES_ON),
              '%d -> %d' % (push_off, push_on))

        # --- 4. it declines when it must ---------------------------------
        check(census == WANT_CENSUS, 'every single-register PUSH is '
                                     'classified, and the reasons are pinned',
              '%s' % census)
        for name, text, want_kind in (
                ('pair', PAIR_TEXT, 'pair'),
                ('copy', COPY_TEXT, 'copy'),
                ('remat', REMAT_TEXT, 'remat')):
            ss = pp_oracle.sites(text)
            ok = len(ss) == 1 and ss[0]['kind'] == want_kind
            check(ok, 'the %s control is reported as one %s site'
                  % (name, want_kind), '%s' % [s['kind'] for s in ss])
            if ok and want_kind == 'pair':
                check(ss[0]['rep'] is None,
                      'the pair control deletes both halves', '%r'
                      % ss[0]['rep'])
            if ok and want_kind == 'copy':
                check(ss[0]['rep'] == '    MOV r3, r1',
                      'the copy control re-derives the source r1 for r3',
                      repr(ss[0]['rep']))
            if ok and want_kind == 'remat':
                check(ss[0]['rep'] == '    LDR r0, .Llit_0',
                      'the remat control re-loads the literal', repr(
                          ss[0]['rep']))
        for name, text in (('no_definition', NO_DEF_TEXT),
                           ('label_entered_from_outside', OUTSIDE_TEXT),
                           ('call_in_span', CALL_TEXT),
                           ('pop_pc', PC_TEXT)):
            ss = pp_oracle.sites(text)
            check(not ss, 'the %s control produces no site' % name,
                  '%s' % [s['kind'] for s in ss])
            why = pp_oracle.explain(pp_oracle.Text(text),
                                    _push_line(text))
            check(why is not None, 'the %s control has a re-derivable reason'
                  % name, '%r' % why)

        # --- 5. the answer does not change --------------------------------
        if not HAVE_UNICORN:
            skip('the two arms agree when the fixture is executed',
                 'python package unicorn missing')
        else:
            fx_src = os.path.join(work, 's19a_fixture.c')
            with open(fx_src, 'w', newline='\n', encoding='utf-8') as fh:
                fh.write(H.STARTUP + FIXTURE)
            vals, snaps, sites_per_arm, failed = {}, {}, {}, []
            for tag, fl in (('off', []), ('on', FLAG)):
                txt, te = build_asm(arkcc, work, fx_src, fl, 'fx_' + tag)
                img, ie = build_image(arkcc, work, fx_src, fl, 'fx_' + tag)
                if te or ie:
                    failed.append('%s: %s' % (tag, (te or ie)[:100]))
                    continue
                sites_per_arm[tag] = len(pp_oracle.sites(txt))
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
                check(sites_per_arm['off'] == 2 and sites_per_arm['on'] == 0,
                      'the executed fixture really carries two sites, and the '
                      'optimised arm carries none',
                      'off %d, on %d' % (sites_per_arm['off'],
                                         sites_per_arm['on']))
                check(vals['off'] == want and vals['on'] == want,
                      'both arms return the value the C source says (%d)'
                      % want, 'off=%d on=%d' % (vals['off'], vals['on']))
                check(snaps['off'] == snaps['on'],
                      'both arms leave the same peripheral RAM snapshot',
                      '%d bytes each' % len(snaps['off']))
                words = (struct.unpack_from('<I', snaps['on'], 0x6458)[0],
                         struct.unpack_from('<I', snaps['on'], 0x6070)[0])
                check(words == (FLAG_TABLE[5], NOT_TABLE[5]),
                      'the two stored words are the two different constants '
                      'of the last round (0x%08X / 0x%08X)' % words,
                      '0x%08X / 0x%08X' % words)

        # --- 6. cropped out, refused --------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_PUSHPOP=0'],
                                   'arkcc_nopp')
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
                                           '-fopt-pushpop'], work)
            check(rc != 0 and 'C3900U' in log and '-fopt-pushpop' in log,
                  'the cropped build refuses -fopt-pushpop by name',
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


def _ins(line):
    s = line.strip()
    if not s or s[0] in ';@.':
        return None
    return pp_oracle.parse(s)


def _push_line(text):
    """Index of the first single-register PUSH line in `text`."""
    t = pp_oracle.Text(text)
    for i in range(len(t.lines)):
        if t.kind[i] == 1 and pp_oracle.push_reg(t.ins[i]) is not None:
            return i
    return -1


if __name__ == '__main__':
    sys.exit(main())
