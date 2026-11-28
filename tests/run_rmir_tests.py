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
