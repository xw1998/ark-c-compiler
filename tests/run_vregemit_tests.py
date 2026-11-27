#!/usr/bin/env python3
"""Gate for the V-5 virtual-register emission path, first slice (0.9.1, V-5-a).

V-5 replaces the emission *model*: instead of parking every intermediate value
on the in-memory value stack and evaluating with r0/r1 as fixed operands, the
expression is evaluated in virtual registers and emitted with the wide
encodings the internal assembler already understands.  The text still runs
through the 33 text passes; that is what separates this from V-4 slice 2a,
which threw the passes away and lost 1.683x.

The pre-registration is docs/EXPR_MODEL.md section 40.4.  It freezes the
routing rule (a leaf integer function: no `BL`, no VFP/`__aeabi`, no
address-taken frame) and it says the *criteria* are frozen in two steps:
build the path, measure it without touching the criteria, then freeze the
next slice's numbers.  This gate is step 1 -- the path is wired in and routes
nothing yet, so it pins exactly what "wired in" must mean:

  1. OFF IS OFF.  All 95 translation units, with `-fopt-vregemit` given, come
     out byte-identical to the same build without it: 9,588 instructions /
     354,989 bytes on the S17+S19-a+S21 stack.  A switch that changes text
     before its emitter exists would be lying about what it does.
  2. THE ROUTING RULE IS THE DOCUMENTED ONE.  With ARKCC_VREGEMIT_STATS=1 the
     compiler reports, per translation unit, how many functions and
     instructions its router accepts.  Summed over the corpus: 137 of 212
     functions, 11,782 of 35,438 instructions (pre-pass text, which is what
     the router sees).  Pinned here as the baseline the next slice's criteria
     are frozen against.
  3. IT ROUTES WHAT IT SAYS.  Five fixtures, one shape each: a leaf integer
     function is accepted; a function with a call, one that takes the address
     of a local, one that does float arithmetic, and a variadic one are not.
     The variadic shape is refused on the IR function flags (a variadic
     function with only named `int` parameters has no text feature that gives
     it away), the other four on the emitted text.
  4. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_VREGEMIT=0 refuses
     the switch by name (C3900U) and still compiles the same text without it.

Usage: run_vregemit_tests.py [path-to-arkcc]
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

FLAG = ['-fopt-vregemit']
STACK = ['-fopt-chainfold', '-fopt-pushpop', '-fopt-remat']

# 1. OFF IS OFF, pinned on the S17+S19-a+S21 stack.
WANT_INSNS = 9588
WANT_BYTES = 354989

# 2. routing census over the 95 units (pre-pass text: what the router sees).
WANT_ELIG_FUNCS = 137
WANT_ELIG_INSNS = 11782
WANT_FUNCS = 212
WANT_INSNS_TOTAL = 35438

check = H.check
skip = H.skip
read_text = H.read_text
insn_count = H.insn_count
build_arkcc = H.build_arkcc
corpus_units = H.corpus_units

ARKCC = None


def run_env(argv, cwd, extra_env=None):
    """H.run, with the environment the census line needs."""
    env = dict(os.environ)
    if extra_env:
        env.update(extra_env)
    p = subprocess.run(argv, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT, env=env)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


def census(arkcc, work, src, extra=()):
    """Run one TU with the stats line on; return (funcs, insns, elig_f, elig_i)."""
    out = os.path.join(work, 'census.s')
    cmd = [arkcc] + H.ASM_ARM + H.COMMON + ['-S', '-o', out, src]
    for d in H.INC_DIRS:
        cmd += ['-I', d]
    cmd += list(H.BASE) + list(STACK) + list(FLAG) + list(extra)
    rc, log = run_env(cmd, work, {'ARKCC_VREGEMIT_STATS': '1'})
    if rc != 0:
        return None, log.strip().splitlines()[:1]
    for ln in log.splitlines():
        if ln.startswith('vregemit: '):
            d = dict(kv.split('=') for kv in ln[len('vregemit: '):].split())
            return (int(d['functions']), int(d['instructions']),
                    int(d['eligible_functions']),
                    int(d['eligible_instructions'])), ''
    return None, 'no vregemit census line'


def main():
    global ARKCC
    ARKCC = os.path.abspath(sys.argv[1] if len(sys.argv) > 1
                            else os.path.join(ROOT, 'arkcc.exe'))
    if not os.path.isfile(ARKCC):
        print('setup: %s is not a file' % ARKCC)
        return 2
    work = tempfile.mkdtemp(prefix='vregemit_')
    try:
        # --- 1. OFF IS OFF ------------------------------------------------
        off, errs = H.corpus_build(ARKCC, work, list(H.BASE) + STACK,
                                   'off', corpus_units())
        if errs:
            check(False, 'the corpus builds with the switch off', errs[:1])
            return 1
        on, errs = H.corpus_build(ARKCC, work, list(H.BASE) + STACK + FLAG,
                                  'on', corpus_units())
        if errs:
            check(False, 'the corpus builds with the switch on', errs[:1])
            return 1
        diff = [k for k in off if off[k] != on.get(k)]
        check(not diff,
              'the switch changes no byte of the 95 units',
              '%d of 95 differ' % len(diff))
        off_text = '\n'.join(off[k] for k in sorted(off))
        check(insn_count(off_text) == WANT_INSNS,
              'the switch-off corpus carries the pinned %d instructions'
              % WANT_INSNS, '%d' % insn_count(off_text))
        check(sum(len(off[k].encode('utf-8', 'replace')) for k in off)
              == WANT_BYTES,
              'the switch-off corpus carries the pinned %d bytes' % WANT_BYTES,
              '%d' % sum(len(off[k].encode('utf-8', 'replace')) for k in off))

        # --- 2. the routing census ----------------------------------------
        tf = ti = te = tie = 0
        missing = []
        for src in corpus_units():
            got, why = census(ARKCC, work, src)
            if got is None:
                missing.append('%s: %s' % (os.path.basename(src), why))
                continue
            tf += got[0]
            ti += got[1]
            te += got[2]
            tie += got[3]
        check(not missing, 'every unit reports a census line', missing[:1])
        check((tf, ti, te, tie) ==
              (WANT_FUNCS, WANT_INSNS_TOTAL, WANT_ELIG_FUNCS,
               WANT_ELIG_INSNS),
              'the router accepts %d of %d functions, %d of %d instructions'
              % (WANT_ELIG_FUNCS, WANT_FUNCS, WANT_ELIG_INSNS,
                 WANT_INSNS_TOTAL),
              'got %d/%d, %d/%d' % (te, tf, tie, ti))

        # --- 3. the routing rule on one shape each ------------------------
        fixtures = [
            ('leaf.c',
             'int leaf(int a, int b) { return a * 3 + b; }\n', 1),
            ('call.c',
             'extern int g(int);\nint call(int a) { return g(a) + 1; }\n', 0),
            ('addr.c',
             'int addr(int a) { int v = a; int *p = &v; *p += 1; return v; }\n',
             0),
            ('flt.c',
             'double flt(double a) { return a * 2.0 + 1.0; }\n', 0),
            ('variadic.c',
             'int variadic(int n, ...) { return n; }\n', 0),
        ]
        for name, body, want in fixtures:
            src = os.path.join(work, name)
            with open(src, 'w', encoding='utf-8') as fh:
                fh.write(body)
            got, why = census(ARKCC, work, src)
            if got is None:
                check(False, 'the %s fixture reports a census line' % name, why)
                continue
            check(got[2] == want,
                  'the router %s the %s shape'
                  % ('accepts' if want else 'refuses', name.split('.')[0]),
                  'eligible_functions=%d want %d' % (got[2], want))

        # --- 4. cropped out, refused --------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_VREGEMIT=0'],
                                   'arkcc_novregemit')
        if trimmed is None:
            skip('a cropped build refuses the switch', why)
        else:
            src = os.path.join(work, 'leaf.c')
            rc, log = run_env([trimmed] + H.ASM_ARM + H.COMMON +
                              ['-S', '-o', os.path.join(work, 't.s'), src] +
                              list(H.BASE) + FLAG, work)
            check(rc != 0 and 'C3900U' in log and '-fopt-vregemit' in log,
                  'the cropped build refuses -fopt-vregemit by name',
                  'rc=%d' % rc)
            rc2, log2 = run_env([trimmed] + H.ASM_ARM + H.COMMON +
                                ['-S', '-o', os.path.join(work, 't2.s'), src] +
                                list(H.BASE), work)
            rc3, log3 = run_env([ARKCC] + H.ASM_ARM + H.COMMON +
                                ['-S', '-o', os.path.join(work, 't3.s'), src] +
                                list(H.BASE), work)
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
