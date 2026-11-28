#!/usr/bin/env python3
"""Gate for the 0.9.2 alpha-1 register-machine IR (ARKCC_FEATURE_RMIR, S55).

docs/EXPR_MODEL.md section 55 pre-registered the 0.9.2 line: the text layer is
at its floor (section 54 census left 39 candidate sites, 0.4%), and
docs/RA_MODEL.md 4.1a prices a *perfect* text-layer allocator at 1.78x, so
matching armcc has to move allocation before emission.  Alpha-1 does not emit
anything.  It translates a function's IR into explicit three-address form --
every value a virtual register, every instruction naming its sources and its
destination -- and verifies that the form is well formed.  The single number
it exists to produce is "how much of the corpus the register machine can
express at all", because alpha-2 (linear scan) and alpha-3 (emission) are only
worth building for the covered set.

This gate pins that set, and pins the two properties the whole line rests on:

  1. OFF IS OFF.  All 95 units are byte-identical with and without the
     measurement running, and the corpus still carries the pinned 9,588
     instructions / 354,989 bytes of the S17+S19-a+S21 stack.  A measurement
     may not leak a byte into the emitted text.
  2. THE CENSUS IS PINNED.  Summed over the corpus: 212 functions seen, 181
     translated, 31 refused, 6,884 of 17,540 IR instructions covered, 5,942
     RMIR instructions produced, 0 verifier violations.  The refusals are 27
     joins (a phi would be needed) and 4 64-bit functions; float, inline asm,
     alloca and memcpy do not appear on this corpus but are pinned by the
     fixtures in check 4.  Both directions of the separation are asserted --
     a translation that accepted nothing or everything would pass a
     hand-picked pin, so 0 < translated < functions.
  3. THE VERIFIER CAN FAIL.  ARKCC_RMIR_SELFTEST corrupts one read per
     function to name a virtual register that is never defined; the verifier
     must then report a violation.  Without this check the pinned "0
     violations" would be a guarantee about nothing.  The corruption must
     also leave the emitted text byte-identical, which proves the self-test
     cannot escape the measurement.
  4. REFUSALS BY NAME.  Five shapes -- float, long long, inline __asm,
     struct copy (memcpy) and VLA (alloca) -- must each be refused with the
     reason the stage-A census already gives, and each fixture's text must be
     the same with and without the measurement.
  5. THE CROP MATRIX COMPILES.  backend_arm.c must compile with
     -DARKCC_FEATURE_RMIR=0 and =1 (both with MIR available): the module needs
     the MIR CFG, so a build that drops MIR must drop RMIR with it, and a
     configuration nobody builds is a configuration nobody catches.  Skipped
     only when no C compiler is on PATH.
  6. ALPHA-2 IS PINNED.  ARKCC_RMIR_LS computes conservative live intervals
     for every value (temporaries and frame slots) and runs a linear scan over
     them.  Over the 181 translated functions: 3,869 values, peak 8, 154
     functions inside 5 registers, 27 above them with 36 spills in total; with
     the 8-register pool (r4-r11) the whole set allocates with zero spills.
     The scan must also be load-bearing, so spills(5) > 0 = spills(8) is
     asserted: a constant answer would make both numbers equal.

Usage: run_rmir_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import subprocess
import sys
import tempfile
import shutil

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import run_chainfold_tests as H        # the shared corpus harness

STACK = ['-fopt-chainfold', '-fopt-pushpop', '-fopt-remat']

# 1. OFF IS OFF, pinned on the S17+S19-a+S21 stack.
WANT_INSNS = 9588
WANT_BYTES = 354989

# 2. the translation census over the 95 units (measured, see 55.5).
WANT_FUNCS = 212
WANT_TRANSLATED = 181
WANT_REFUSED = 31
WANT_IR = 17540
WANT_COVERED = 6884
WANT_INST = 5942
WANT_VERIFY_BAD = 0
WANT_REFUSE = {'join': 27, '64-bit': 4}

# 6. alpha-2: live intervals + linear scan over the translated set.
WANT_LS_VALUES = 3869
WANT_LS_PEAK_MAX = 8
WANT_LS_HIST = {0: 6, 1: 27, 2: 5, 3: 30, 4: 65, 5: 21, 6: 19, 7: 7, 8: 1}
WANT_LS_UNDER5 = 154          # functions whose peak interval overlap is <= 5
WANT_LS_SPILL5 = 36
WANT_LS_SPILL5_FNS = 27
WANT_LS_SPILL8 = 0
WANT_LS_ACROSS_CALL = 43
# alpha-2b (S57): joins whose shapes differ only on a temporary get a
# synthetic phi slot; a join with a genuinely missing word stays refused.
WANT_PHI_FUNCS = 212
WANT_PHI_TRANSLATED = 207
WANT_PHI_REFUSED = 5
WANT_PHI_IR = 17540
WANT_PHI_COVERED = 16354
WANT_PHI_INST = 15906
WANT_PHI_VERIFY_BAD = 0
WANT_PHI_REFUSE = {'join': 1, '64-bit': 4}
WANT_PHI_SLOTS = 397
WANT_PHI_STORES = 794
WANT_PHI_MULTI = 0
WANT_PHI_LS_VALUES = 9957
WANT_PHI_LS_PEAK_MAX = 19
WANT_PHI_LS_UNDER5 = 162
WANT_PHI_LS_SPILL5 = 316
WANT_PHI_LS_SPILL5_FNS = 45
WANT_PHI_LS_SPILL8 = 161
WANT_PHI_LS_SPILL8_FNS = 6
WANT_PHI_LS_ACROSS_CALL = 111
WANT_PHI_JOIN_REFUSED = {'HAL_DMA_IRQHandler'}

check = H.check
skip = H.skip
read_text = H.read_text
insn_count = H.insn_count
corpus_units = H.corpus_units

ARKCC = None


def run_env(argv, cwd, extra_env=None):
    env = dict(os.environ)
    if extra_env:
        env.update(extra_env)
    p = subprocess.run(argv, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT, env=env)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


def unit_argv(arkcc, work, src, extra=(), outname='u.s'):
    out = os.path.join(work, outname)
    cmd = [arkcc] + H.ASM_ARM + H.COMMON + ['-S', '-o', out, src]
    for d in H.INC_DIRS:
        cmd += ['-I', d]
    return cmd + list(H.BASE) + list(extra), out


def census_unit(arkcc, work, src, extra_env):
    """Run one unit with the measurement on; return ({counters}, refuse, log)."""
    cmd, out = unit_argv(arkcc, work, src)
    rc, log = run_env(cmd, work, extra_env)
    if rc != 0:
        return None, None, ' '.join(log.strip().splitlines()[:1])
    got, ref = None, {}
    for ln in log.splitlines():
        if ln.startswith('rmir: '):
            got = dict((k, int(v)) for k, v in
                       (kv.split('=') for kv in ln[len('rmir: '):].split()))
        elif ln.startswith('rmir-refuse:'):
            for kv in ln[len('rmir-refuse:'):].split():
                k, v = kv.split('=')
                ref[k] = ref.get(k, 0) + int(v)
    if got is None:
        return None, None, 'no rmir census line'
    return got, ref, log


def main():
    global ARKCC
    ARKCC = os.path.abspath(sys.argv[1] if len(sys.argv) > 1
                            else os.path.join(ROOT, 'arkcc.exe'))
    if not os.path.isfile(ARKCC):
        print('setup: %s is not a file' % ARKCC)
        return 2
    work = tempfile.mkdtemp(prefix='rmir_')
    try:
        # --- 1. OFF IS OFF ------------------------------------------------
        off, errs = H.corpus_build(ARKCC, work, list(H.BASE) + STACK,
                                   'off', corpus_units())
        if errs:
            check(False, 'the corpus builds with the measurement off', errs[:1])
            return 1
        # The second arm is the same command with the environment set.  It is
        # built one unit at a time because H.build_asm does not carry extra
        # environment.
        meas, merrs = {}, []
        for src in corpus_units():
            cmd, out = unit_argv(ARKCC, work, src, STACK)
            rc, log = run_env(cmd, work, {'ARKCC_RMIR_COV': '1'})
            if rc != 0:
                merrs.append('%s: %s' % (os.path.basename(src),
                                         ' '.join(log.strip().splitlines()[:1])))
                continue
            meas[os.path.basename(src)] = read_text(out)
        check(not merrs, 'every unit builds with ARKCC_RMIR_COV', merrs[:1])
        diff = [k for k in off if off[k] != meas.get(k)]
        check(not diff,
              'the measurement changes no byte of the 95 units',
              '%d of 95 differ' % len(diff))
        off_text = '\n'.join(off[k] for k in sorted(off))
        check(insn_count(off_text) == WANT_INSNS,
              'the corpus carries the pinned %d instructions' % WANT_INSNS,
              '%d' % insn_count(off_text))
        check(sum(len(off[k].encode('utf-8', 'replace')) for k in off)
              == WANT_BYTES,
              'the corpus carries the pinned %d bytes' % WANT_BYTES,
              '%d' % sum(len(off[k].encode('utf-8', 'replace')) for k in off))

        # --- 2. the translation census ------------------------------------
        agg = dict((k, 0) for k in ('functions', 'translated', 'refused',
                                    'ir', 'covered', 'inst', 'verify_bad'))
        ref = {}
        missing = []
        for src in corpus_units():
            got, r, why = census_unit(ARKCC, work, src, {'ARKCC_RMIR_COV': '1'})
            if got is None:
                missing.append('%s: %s' % (os.path.basename(src), why))
                continue
            for k in agg:
                agg[k] += got.get(k, 0)
            for k, v in r.items():
                ref[k] = ref.get(k, 0) + v
        check(not missing, 'every unit reports an rmir census line', missing[:1])
        want = {'functions': WANT_FUNCS, 'translated': WANT_TRANSLATED,
                'refused': WANT_REFUSED, 'ir': WANT_IR,
                'covered': WANT_COVERED, 'inst': WANT_INST}
        bad = ['%s=%d want %d' % (k, agg[k], want[k])
               for k in want if agg[k] != want[k]]
        check(not bad,
              'the register machine translates %d of %d functions, %d of %d '
              'IR instructions' % (WANT_TRANSLATED, WANT_FUNCS,
                                   WANT_COVERED, WANT_IR), bad)
        check(agg['verify_bad'] == WANT_VERIFY_BAD,
              'the verifier reports %d violations over the corpus'
              % WANT_VERIFY_BAD, '%d' % agg['verify_bad'])
        # The instrument must not be a constant.
        check(0 < agg['translated'] < agg['functions'],
              'the census separates translated from refused functions',
              '%d of %d' % (agg['translated'], agg['functions']))
        check(agg['covered'] <= agg['ir'] and agg['inst'] <= agg['covered'],
              'coverage is a part of the IR and the RMIR is not inflated',
              '%d <= %d, %d <= %d' % (agg['inst'], agg['covered'],
                                      agg['covered'], agg['ir']))
        bad = ['%s=%d want %d' % (k, ref.get(k, 0), v)
               for k, v in sorted(WANT_REFUSE.items())
               if ref.get(k, 0) != v]
        extra = [k for k in ref if k not in WANT_REFUSE and ref[k]]
        bad += ['unexpected %s=%d' % (k, ref[k]) for k in extra]
        check(not bad,
              'the refusals are the pinned ones (join, 64-bit)', bad)

        # --- 3. the verifier can fail -------------------------------------
        leaf = os.path.join(work, 'rm_leaf.c')
        with open(leaf, 'w', encoding='utf-8') as fh:
            fh.write('int add(int a, int b) { return a + b; }\n'
                     'int loop(int n) { int s = 0; int i;\n'
                     '  for (i = 0; i < n; i++) s += i * 3; return s; }\n')
        o1 = os.path.join(work, 'self_off.s')
        o2 = os.path.join(work, 'self_on.s')
        rc1, log1 = run_env([ARKCC] + H.ASM_ARM + H.COMMON +
                            ['-S', '-o', o1, leaf] + list(H.BASE), work)
        rc2, log2 = run_env([ARKCC] + H.ASM_ARM + H.COMMON +
                            ['-S', '-o', o2, leaf] + list(H.BASE), work,
                            {'ARKCC_RMIR_SELFTEST': '1'})
        if rc1 != 0 or rc2 != 0:
            check(False, 'the self-test fixture builds both ways', log1 or log2)
        else:
            lines = [ln for ln in log2.splitlines()
                     if ln.startswith('rmir-selftest ')]
            check(len(lines) == 2 and all(' 0 violation' not in ln
                                          for ln in lines),
                  'the verifier reports the planted defect in both functions',
                  '; '.join(lines[:2]) or 'no rmir-selftest line')
            check(read_text(o1) == read_text(o2),
                  'the self-test changes no byte of the emitted text')

        # --- 4. refusals by name ------------------------------------------
        fixtures = [
            ('flt.c', 'float f(float a, float b) { return a * b + 1.0f; }\n',
             'float'),
            ('llong.c', 'long long f(long long a) { return a + 1; }\n',
             '64-bit'),
            ('asm.c', 'int f(int a) { __asm("nop"); return a; }\n',
             'inline-asm'),
            ('memcpy.c', 'struct S { int a[8]; };\n'
             'void f(struct S *p, struct S *q) { *p = *q; }\n', 'memcpy'),
            ('vla.c', 'int f(int n) { int a[n]; a[0] = n; return a[0]; }\n',
             'alloca'),
        ]
        for name, body, why in fixtures:
            src = os.path.join(work, name)
            with open(src, 'w', encoding='utf-8') as fh:
                fh.write(body)
            got, r, log = census_unit(ARKCC, work, src,
                                      {'ARKCC_RMIR_COV': '1',
                                       'ARKCC_RMIR_DUMP': '1'})
            if got is None:
                check(False, 'the %s fixture reports an rmir census line'
                      % name, log)
                continue
            check(got['translated'] == 0 and r.get(why, 0) == 1,
                  'the %s fixture is refused as %s' % (name, why),
                  'translated=%d %s' % (got['translated'], r))
            a, oa = unit_argv(ARKCC, work, src, STACK, 'fx_off.s')
            rc1, l1 = run_env(a, work)
            b, ob = unit_argv(ARKCC, work, src, STACK, 'fx_on.s')
            rc2, l2 = run_env(b, work, {'ARKCC_RMIR_COV': '1'})
            if rc1 != 0 or rc2 != 0:
                check(False, 'the %s fixture builds both ways' % name, l1 or l2)
            else:
                check(read_text(oa) == read_text(ob),
                      'the %s fixture is byte-identical either way' % name)

        # --- 6. alpha-2: live intervals and linear scan --------------------
        # Section 55.6 pre-registered alpha-2 as "peak live interval <= 5 per
        # function, no spills".  What the corpus answers is pinned here: the
        # 5-register pool (r4-r8) leaves 27 functions over budget with 36
        # spills in all, and the 8-register pool (r4-r11) needs none.
        ls = []
        ls_names = []
        lserrs = []
        lsdiff = []
        for src in corpus_units():
            base = os.path.basename(src)
            cmd, out = unit_argv(ARKCC, work, src, STACK)
            rc, log = run_env(cmd, work, {'ARKCC_RMIR_COV': '1',
                                          'ARKCC_RMIR_LS': '1',
                                          'ARKCC_RMIR_DUMP': '1'})
            if rc != 0:
                lserrs.append('%s: %s' % (base, ' '.join(
                    log.strip().splitlines()[:1])))
                continue
            if base in off and read_text(out) != off[base]:
                lsdiff.append(base)
            for ln in log.splitlines():
                if ln.startswith('rmir-ls ') and ': values=' in ln:
                    _name, rest = ln[len('rmir-ls '):].split(': ', 1)
                    d = dict((k, int(v)) for k, v in
                             (kv.split('=') for kv in rest.split()))
                    ls.append(d)
                    ls_names.append(_name)
        check(not lserrs, 'every unit measures live intervals', lserrs[:1])
        check(not lsdiff, 'the linear scan changes no byte of the 95 units',
              '%d of 95 differ' % len(lsdiff))
        check(len(ls) == WANT_TRANSLATED,
              'all %d translated functions report a live-interval line'
              % WANT_TRANSLATED, '%d' % len(ls))
        if ls:
            hist = {}
            for d in ls:
                hist[d['peak']] = hist.get(d['peak'], 0) + 1
            vals = sum(d['values'] for d in ls)
            peak = max(d['peak'] for d in ls)
            under = sum(1 for d in ls if d['peak'] <= 5)
            sp5 = sum(d['spills'] for d in ls)
            sp5f = sum(1 for d in ls if d['spills'])
            sp8 = sum(d['spills8'] for d in ls)
            across = sum(d['across_call'] for d in ls)
            bad = []
            if vals != WANT_LS_VALUES:
                bad.append('values=%d want %d' % (vals, WANT_LS_VALUES))
            if peak != WANT_LS_PEAK_MAX:
                bad.append('peak_max=%d want %d' % (peak, WANT_LS_PEAK_MAX))
            if hist != WANT_LS_HIST:
                bad.append('hist=%s' % sorted(hist.items()))
            if under != WANT_LS_UNDER5:
                bad.append('under5=%d want %d' % (under, WANT_LS_UNDER5))
            if sp5 != WANT_LS_SPILL5:
                bad.append('spills=%d want %d' % (sp5, WANT_LS_SPILL5))
            if sp5f != WANT_LS_SPILL5_FNS:
                bad.append('spill_fns=%d want %d' % (sp5f, WANT_LS_SPILL5_FNS))
            if sp8 != WANT_LS_SPILL8:
                bad.append('spills8=%d want %d' % (sp8, WANT_LS_SPILL8))
            if across != WANT_LS_ACROSS_CALL:
                bad.append('across_call=%d want %d' % (across,
                                                      WANT_LS_ACROSS_CALL))
            check(not bad,
                  'the live intervals are the pinned ones (%d values, peak %d, '
                  '%d/%d under 5 registers)'
                  % (WANT_LS_VALUES, WANT_LS_PEAK_MAX, WANT_LS_UNDER5,
                     WANT_TRANSLATED), bad)
            # The scan must be load-bearing: if it ignored the register count,
            # the 5- and 8-register answers would be identical.
            check(sp5 > 0 and sp8 == 0,
                  'the register count changes the answer (5 regs spill, 8 do '
                  'not)', 'spills=%d spills8=%d' % (sp5, sp8))
            check(0 < peak <= 32 and under < len(ls),
                  'the pressure reading separates easy from hard functions',
                  'peak=%d under5=%d of %d' % (peak, under, len(ls)))

        # --- 7. alpha-2b: joins materialised into phi slots ----------------
        # Section 57 pre-registered alpha-2b as "a join whose two predecessors
        # agree on depth and differ only on a temporary gets a synthetic phi
        # slot, so the merge is materialised before the branch; a join that is
        # missing a word outright stays refused".  The corpus answers 207 of
        # 212 functions (was 181), 397 slots / 794 stores, and leaves exactly
        # one join refusal: HAL_DMA_IRQHandler, whose blk66 POP underflows once
        # the entry depth is cut to the minimum of its predecessors.  Cutting
        # the depth to the min is what makes the extra words dead, so the
        # underflow means one predecessor really gave no value: refuse, do not
        # guess.
        phi_agg = dict((k, 0) for k in ('functions', 'translated', 'refused',
                                        'ir', 'covered', 'inst',
                                        'verify_bad'))
        phi_ref = {}
        phi_slots = phi_stores = phi_multi = phi_fns = 0
        phi_errs, phi_diff = [], []
        phi_ls, phi_fix, phi_join_refused = [], [], set()
        for src in corpus_units():
            base = os.path.basename(src)
            cmd, out = unit_argv(ARKCC, work, src, STACK)
            rc, log = run_env(cmd, work, {'ARKCC_RMIR_COV': '1',
                                          'ARKCC_RMIR_PHI': '1',
                                          'ARKCC_RMIR_LS': '1',
                                          'ARKCC_RMIR_DUMP': '1'})
            if rc != 0:
                phi_errs.append('%s: %s' % (base, ' '.join(
                    log.strip().splitlines()[:1])))
                continue
            if base in off and read_text(out) != off[base]:
                phi_diff.append(base)
            seen = False
            for ln in log.splitlines():
                if ln.startswith('rmir: '):
                    seen = True
                    for kv in ln[len('rmir: '):].split():
                        k, v = kv.split('=')
                        phi_agg[k] += int(v)
                elif ln.startswith('rmir-refuse:'):
                    for kv in ln[len('rmir-refuse:'):].split():
                        k, v = kv.split('=')
                        phi_ref[k] = phi_ref.get(k, 0) + int(v)
                elif ln.startswith('rmir-refuse ') and ': ' in ln:
                    _n, rest = ln[len('rmir-refuse '):].split(': ', 1)
                    if rest.split(' (')[0].strip() == 'join':
                        phi_join_refused.add(_n)
                elif ln.startswith('rmir-phi: '):
                    for kv in ln[len('rmir-phi: '):].split():
                        k, v = kv.split('=')
                        if k == 'functions':
                            phi_fns += int(v)
                        elif k == 'slots':
                            phi_slots += int(v)
                        elif k == 'stores':
                            phi_stores += int(v)
                        elif k == 'multi':
                            phi_multi += int(v)
                elif ln.startswith('rmir-phi ') and ': slots=' in ln:
                    _n, rest = ln[len('rmir-phi '):].split(': ', 1)
                    d = dict((k, int(v)) for k, v in
                             (kv.split('=') for kv in rest.split()))
                    phi_fix.append((base, _n, d['slots'], d['stores']))
                elif ln.startswith('rmir-ls ') and ': values=' in ln:
                    _n, rest = ln[len('rmir-ls '):].split(': ', 1)
                    phi_ls.append(dict((k, int(v)) for k, v in
                                       (kv.split('=') for kv in rest.split())))
            if not seen:
                phi_errs.append('%s: no rmir census line' % base)
        check(not phi_errs, 'every unit reports an alpha-2b census line',
              phi_errs[:1])
        check(not phi_diff,
              'the phi materialisation changes no byte of the 95 units',
              '%d of 95 differ' % len(phi_diff))
        want = {'functions': WANT_PHI_FUNCS,
                'translated': WANT_PHI_TRANSLATED,
                'refused': WANT_PHI_REFUSED, 'ir': WANT_PHI_IR,
                'covered': WANT_PHI_COVERED, 'inst': WANT_PHI_INST}
        bad = ['%s=%d want %d' % (k, phi_agg[k], want[k])
               for k in want if phi_agg[k] != want[k]]
        check(not bad,
              'the phi materialisation translates %d of %d functions, %d of '
              '%d IR instructions'
              % (WANT_PHI_TRANSLATED, WANT_PHI_FUNCS, WANT_PHI_COVERED,
                 WANT_PHI_IR), bad)
        check(phi_agg['verify_bad'] == WANT_PHI_VERIFY_BAD,
              'the verifier reports %d violations with phi slots'
              % WANT_PHI_VERIFY_BAD, '%d' % phi_agg['verify_bad'])
        bad = ['%s=%d want %d' % (k, phi_ref.get(k, 0), v)
               for k, v in sorted(WANT_PHI_REFUSE.items())
               if phi_ref.get(k, 0) != v]
        bad += ['unexpected %s=%d' % (k, phi_ref[k])
                for k in phi_ref if k not in WANT_PHI_REFUSE and phi_ref[k]]
        check(not bad, 'the alpha-2b refusals are the pinned ones', bad)
        check(phi_join_refused == WANT_PHI_JOIN_REFUSED,
              'the only join left refused is %s'
              % ', '.join(sorted(WANT_PHI_JOIN_REFUSED)),
              ', '.join(sorted(phi_join_refused)) or 'none')
        # The instrument must move when the switch does.
        check(phi_agg['translated'] == WANT_PHI_TRANSLATED
              and phi_agg['translated'] > WANT_TRANSLATED
              and phi_ref.get('join', 0) < WANT_REFUSE['join'],
              'turning the phi slots on translates more than alpha-2 did',
              '%d vs %d functions, %d vs %d join refusals'
              % (phi_agg['translated'], WANT_TRANSLATED,
                 phi_ref.get('join', 0), WANT_REFUSE['join']))
        bad = []
        if phi_slots != WANT_PHI_SLOTS:
            bad.append('slots=%d want %d' % (phi_slots, WANT_PHI_SLOTS))
        if phi_stores != WANT_PHI_STORES:
            bad.append('stores=%d want %d' % (phi_stores, WANT_PHI_STORES))
        if phi_multi != WANT_PHI_MULTI:
            bad.append('multi=%d want %d' % (phi_multi, WANT_PHI_MULTI))
        check(not bad,
              'the plan allocates %d slots and %d edge stores'
              % (WANT_PHI_SLOTS, WANT_PHI_STORES), bad)
        check(phi_fns == WANT_PHI_TRANSLATED and len(phi_fix)
              == WANT_PHI_TRANSLATED,
              'all %d translated functions report a phi plan'
              % WANT_PHI_TRANSLATED,
              'census=%d dump=%d' % (phi_fns, len(phi_fix)))
        # Every slot is written once per predecessor, so stores == 2*slots
        # holds per function only for two-way joins; over the corpus it is
        # exact, which says no slot was allocated and then never stored.
        check(phi_slots > 0 and phi_stores == 2 * phi_slots,
              'each phi slot is stored by both predecessors',
              'slots=%d stores=%d' % (phi_slots, phi_stores))
        # alpha-2's set must not lose a function to alpha-2b.
        gone = sorted(set(ls_names) - set(n for _, n, _, _ in phi_fix))
        check(not gone, 'alpha-2b translates every function alpha-2 did',
              ', '.join(gone[:4]) or 'none lost')
        if phi_ls:
            vals = sum(d['values'] for d in phi_ls)
            peak = max(d['peak'] for d in phi_ls)
            under = sum(1 for d in phi_ls if d['peak'] <= 5)
            sp5 = sum(d['spills'] for d in phi_ls)
            sp5f = sum(1 for d in phi_ls if d['spills'])
            sp8 = sum(d['spills8'] for d in phi_ls)
            sp8f = sum(1 for d in phi_ls if d['spills8'])
            across = sum(d['across_call'] for d in phi_ls)
            bad = []
            if len(phi_ls) != WANT_PHI_TRANSLATED:
                bad.append('lines=%d want %d'
                           % (len(phi_ls), WANT_PHI_TRANSLATED))
            if vals != WANT_PHI_LS_VALUES:
                bad.append('values=%d want %d' % (vals, WANT_PHI_LS_VALUES))
            if peak != WANT_PHI_LS_PEAK_MAX:
                bad.append('peak_max=%d want %d' % (peak, WANT_PHI_LS_PEAK_MAX))
            if under != WANT_PHI_LS_UNDER5:
                bad.append('under5=%d want %d' % (under, WANT_PHI_LS_UNDER5))
            if sp5 != WANT_PHI_LS_SPILL5:
                bad.append('spills=%d want %d' % (sp5, WANT_PHI_LS_SPILL5))
            if sp5f != WANT_PHI_LS_SPILL5_FNS:
                bad.append('spill_fns=%d want %d'
                           % (sp5f, WANT_PHI_LS_SPILL5_FNS))
            if sp8 != WANT_PHI_LS_SPILL8:
                bad.append('spills8=%d want %d' % (sp8, WANT_PHI_LS_SPILL8))
            if sp8f != WANT_PHI_LS_SPILL8_FNS:
                bad.append('spill8_fns=%d want %d'
                           % (sp8f, WANT_PHI_LS_SPILL8_FNS))
            if across != WANT_PHI_LS_ACROSS_CALL:
                bad.append('across_call=%d want %d'
                           % (across, WANT_PHI_LS_ACROSS_CALL))
            check(not bad,
                  'the phi slots cost %d values, peak %d, %d/%d still under 5 '
                  'registers' % (WANT_PHI_LS_VALUES, WANT_PHI_LS_PEAK_MAX,
                                 WANT_PHI_LS_UNDER5, WANT_PHI_TRANSLATED), bad)
            # The 8-register pool still fits 6 functions short of everything:
            # alpha-3's emitter cannot pretend the pool is big enough.
            check(sp8 > 0 and sp8f > 0 and sp8 < sp5,
                  'the 8-register pool spills less but not nothing',
                  'spills8=%d in %d functions vs %d' % (sp8, sp8f, sp5))
        # --- 7b. the fixture has the shape section 57 describes -----------
        sel = os.path.join(work, 'phi_sel.c')
        with open(sel, 'w', encoding='utf-8') as fh:
            fh.write('int sel(int c, int a, int b) { return c ? a + 1 : b * 2; }\n')
        cmd, _ = unit_argv(ARKCC, work, sel, STACK)
        rc1, log1 = run_env(cmd, work, {'ARKCC_RMIR_COV': '1',
                                        'ARKCC_RMIR_DUMP': '1'})
        rc2, log2 = run_env(cmd, work, {'ARKCC_RMIR_COV': '1',
                                        'ARKCC_RMIR_PHI': '1',
                                        'ARKCC_RMIR_DUMP': '1'})
        if rc1 != 0 or rc2 != 0:
            check(False, 'the phi fixture builds both ways', log1 or log2)
        else:
            off_join = [ln for ln in log1.splitlines()
                        if ln.startswith('rmir-refuse sel: join (')]
            check(bool(off_join) and 'rmir-sel' not in log1,
                  'without the phi slots the ternary is refused as a join',
                  '; '.join(log1.splitlines()[:2]))
            plan = [ln for ln in log2.splitlines()
                    if ln.startswith('rmir-phi sel: ')]
            check(len(plan) == 1 and 'slots=1 stores=2' in plan[0],
                  'the ternary join materialises one slot with two stores',
                  '; '.join(plan) or 'no rmir-phi line')
            check(log2.count('PEDGE') >= 2,
                  'both predecessors emit a PEDGE store', '%d'
                  % log2.count('PEDGE'))
            body = [ln for ln in log2.splitlines() if ' RET ' in ln]
            check(bool(body), 'the join block returns the phi slot',
                  '; '.join(body[:1]))

        # --- 5. the crop matrix compiles ----------------------------------
        bad = flag_matrix(work)
        if bad is None:
            skip('the two RMIR builds compile', 'no C compiler')
        else:
            check(not bad, 'the two RMIR builds compile', '; '.join(bad))

        return 1 if H.failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)


def flag_matrix(work):
    """Compile backend_arm.c with RMIR on and off (MIR on in both).

    Returns a list of failures (empty = both compiled), or None when there is
    no C compiler to ask."""
    cc = os.environ.get('CC') or shutil.which('gcc')
    if not cc:
        return None
    src = os.path.join(ROOT, 'src', 'backend', 'arm', 'backend_arm.c')
    base = [cc, '-O0', '-std=c99', '-Wno-unused-parameter',
            '-Wno-unused-but-set-variable', '-Wno-unused-variable',
            '-Wno-unused-function',
            '-I', os.path.join(ROOT, 'include'), '-fsyntax-only', src]
    bad = []
    for rmir in (0, 1):
        cmd = base + ['-DARKCC_FEATURE_MIR=1',
                      '-DARKCC_FEATURE_RMIR=%d' % rmir]
        p = subprocess.run(cmd, cwd=ROOT, stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT)
        if p.returncode != 0:
            out = p.stdout.decode('utf-8', 'replace')
            first = [ln for ln in out.splitlines() if 'error' in ln]
            bad.append('RMIR=%d: %s'
                       % (rmir, (first or ['rc=%d' % p.returncode])[0]))
    return bad


if __name__ == '__main__':
    sys.exit(main())
