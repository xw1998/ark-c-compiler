#!/usr/bin/env python3
"""Gate for the V-4' stage A routing census (-fopt-alloc, 0.9.1, S43.8).

docs/EXPR_MODEL.md section 43 pre-registered stage A: re-emit a whole function
body from IR through a CFG register allocator, and judge it on absolute
instruction counts (landing <= 8,588 on the 95-TU corpus).  43.4.5 also froze
a routing self-check, so that "the document says it routes 208 functions"
could never pass while the code routed 20.

This gate is the routing census only: the switch decides which functions stage
A *may* take, changes not one byte, and reports its answer per translation unit
(ARKCC_ALLOC_STATS=1).  It deliberately does not pin a benefit, because no
emitter exists: see section 43.8, where the routing ceiling measured here
(565 removable instructions inside the routed functions, against the 1,000 a
landing needs) is what retires stage A before a line of it is written.

Checks:

  1. OFF IS OFF.  All 95 units, with -fopt-alloc given, are byte-identical to
     the same build without it, and the corpus still carries the pinned
     9,588 instructions / 354,989 bytes of the S17+S19-a+S21 stack.
  2. THE CENSUS IS PINNED.  Summed over the corpus: 167 of 212 functions and
     6,064 of 17,116 IR instructions routed, of which 47 contain a call, 1
     uses stack arguments and 10 have a back edge.  The pre-registration
     projected 208 of 211; the measurement refutes that projection, and
     section 43.8 records the correction together with the breakdown of the 45
     functions that are refused and why.  The pinned number here is the
     measurement, not the projection.
  3. REFUSALS.  Five shapes must route zero functions: inline __asm, VLA,
     long long, float and variadic.  Both arms must also print the same text
     byte for byte (43.4.3), because a routing decision may not leak into the
     emitted text.
  4. ACCEPTANCES.  Eight integer shapes must each route exactly one function:
     leaf arithmetic, a counted loop, do-while, recursion, a call, a switch,
     several exits, a bitfield, and a five-argument call (stack arguments).
     This is what "the model covers CFG shapes" means in code, not prose.
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_ALLOC=0 refuses
     the switch by name (C3900U) and writes the same text as the full build
     when the switch is absent.
  6. THE FLAG MATRIX COMPILES.  backend_arm.c must compile under all four
     combinations of ARKCC_FEATURE_VREGEMIT and ARKCC_FEATURE_OPT_ALLOC: the
     census block first landed inside the VREGEMIT guard, so cropping VREGEMIT
     alone left its call sites calling functions that no longer existed -- a
     configuration nobody built, and so nobody caught.  Skipped only when no C
     compiler is on PATH.

Usage: run_alloc_tests.py [path-to-arkcc]
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

FLAG = ['-fopt-alloc']
STACK = ['-fopt-chainfold', '-fopt-pushpop', '-fopt-remat']

# 1. OFF IS OFF, pinned on the S17+S19-a+S21 stack.
WANT_INSNS = 9588
WANT_BYTES = 354989

# 2. the routing census over the 95 units (measured, see 43.8).
WANT_FUNCS = 212
WANT_IR = 17116
WANT_ELIG_FUNCS = 167
WANT_ELIG_IR = 6064
WANT_CALL = 47
WANT_STACKARG = 1
WANT_LOOP = 10

# 2b. the same walk with joins reconciled instead of refused (S44.2): the set a
# real allocator would serve, the MOVs its joins would cost, and the widest
# simultaneous live-value count anywhere in the corpus.
WANT_JOIN_FUNCS = 188
WANT_JOIN_MOVES = 399
WANT_PEAK = 5

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


def census(arkcc, work, src, extra=(), stats=True):
    """Run one TU; return (dict of counters, stderr log) or (None, why)."""
    out = os.path.join(work, 'census.s')
    cmd = [arkcc] + H.ASM_ARM + H.COMMON + ['-S', '-o', out, src]
    for d in H.INC_DIRS:
        cmd += ['-I', d]
    cmd += list(H.BASE) + list(STACK) + list(FLAG) + list(extra)
    env = {'ARKCC_ALLOC_STATS': '1'} if stats else {}
    rc, log = run_env(cmd, work, env)
    if rc != 0:
        return None, ' '.join(log.strip().splitlines()[:1])
    for ln in log.splitlines():
        if ln.startswith('alloc: '):
            d = dict(kv.split('=') for kv in ln[len('alloc: '):].split())
            return dict((k, int(v)) for k, v in d.items()), log
    return None, 'no alloc census line'


def compile_text(arkcc, work, src, extra=()):
    """Emitted text of one TU, switch on or off by `extra`."""
    out = os.path.join(work, 'text.s')
    cmd = [arkcc] + H.ASM_ARM + H.COMMON + ['-S', '-o', out, src]
    for d in H.INC_DIRS:
        cmd += ['-I', d]
    cmd += list(H.BASE) + list(STACK) + list(extra)
    rc, log = run_env(cmd, work)
    if rc != 0:
        return None, ' '.join(log.strip().splitlines()[:1])
    return read_text(out), None


def main():
    global ARKCC
    ARKCC = os.path.abspath(sys.argv[1] if len(sys.argv) > 1
                            else os.path.join(ROOT, 'arkcc.exe'))
    if not os.path.isfile(ARKCC):
        print('setup: %s is not a file' % ARKCC)
        return 2
    work = tempfile.mkdtemp(prefix='alloc_')
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
        agg = dict((k, 0) for k in ('functions', 'ir', 'eligible_functions',
                                    'eligible_ir', 'call', 'stackarg', 'loop',
                                    'routable_join', 'join_moves'))
        peak = [0]
        missing = []
        for src in corpus_units():
            got, why = census(ARKCC, work, src)
            if got is None:
                missing.append('%s: %s' % (os.path.basename(src), why))
                continue
            for k in agg:
                agg[k] += got.get(k, 0)
            if int(got.get('peak_max', 0)) > peak[0]:
                peak[0] = int(got.get('peak_max', 0))
        check(not missing, 'every unit reports a census line', missing[:1])
        want = {'functions': WANT_FUNCS, 'ir': WANT_IR,
                'eligible_functions': WANT_ELIG_FUNCS,
                'eligible_ir': WANT_ELIG_IR, 'call': WANT_CALL,
                'stackarg': WANT_STACKARG, 'loop': WANT_LOOP}
        bad = ['%s=%d want %d' % (k, agg[k], want[k])
               for k in want if agg[k] != want[k]]
        check(not bad,
              'the router accepts %d of %d functions, %d of %d IR instructions'
              % (WANT_ELIG_FUNCS, WANT_FUNCS, WANT_ELIG_IR, WANT_IR), bad)
        # The instrument must not be a constant: a router that accepts nothing
        # or everything would pass a hand-picked pin, so both directions are
        # asserted against the corpus totals.
        check(0 < agg['eligible_functions'] < agg['functions'],
              'the census separates accepted from refused functions',
              '%d of %d' % (agg['eligible_functions'], agg['functions']))
        # --- 2b. joins reconciled: S44.2 prices the allocator's real set ----
        check(agg['routable_join'] >= agg['eligible_functions'],
              'reconciling joins never loses a routed function',
              '%d vs %d' % (agg['routable_join'], agg['eligible_functions']))
        want2 = {'routable_join': WANT_JOIN_FUNCS,
                 'join_moves': WANT_JOIN_MOVES}
        bad2 = ['%s=%d want %d' % (k, agg[k], want2[k])
                for k in want2 if agg[k] != want2[k]]
        check(not bad2,
              'join reconciliation serves %d functions at %d moves'
              % (WANT_JOIN_FUNCS, WANT_JOIN_MOVES), bad2)
        check(peak[0] == WANT_PEAK,
              'the widest live-value count in the corpus is %d' % WANT_PEAK,
              '%d' % peak[0])

        # --- 3. refusals, five shapes, both arms byte-identical -----------
        refuse = [
            ('asm.c', 'int f(int a) { __asm("nop"); return a; }\n'),
            ('vla.c', 'int f(int n) { int a[n]; a[0] = n; return a[0]; }\n'),
            ('llong.c', 'long long f(long long a) { return a + 1; }\n'),
            ('flt.c', 'double f(double a) { return a * 2.0 + 1.0; }\n'),
            ('variadic.c', 'int f(int n, ...) { return n; }\n'),
        ]
        for name, body in refuse:
            src = os.path.join(work, name)
            with open(src, 'w', encoding='utf-8') as fh:
                fh.write(body)
            got, why = census(ARKCC, work, src)
            if got is None:
                check(False, 'the %s fixture reports a census line' % name, why)
                continue
            check(got['functions'] == 1 and got['eligible_functions'] == 0,
                  'the router refuses the %s shape' % name.split('.')[0],
                  '%d of %d routed' % (got['eligible_functions'],
                                       got['functions']))
            t_off, e1 = compile_text(ARKCC, work, src)
            t_on, e2 = compile_text(ARKCC, work, src, FLAG)
            if t_off is None or t_on is None:
                check(False, 'the %s fixture builds both arms' % name, e1 or e2)
            else:
                check(t_off == t_on,
                      'the %s fixture is byte-identical in both arms' % name)

        # --- 4. accepts, the nine CFG shapes the model claims -------------
        accept = [
            ('leaf', 'int f(int a, int b) { return a * 3 + b; }\n'),
            ('loop', 'int f(int n) { int s = 0, i; for (i = 0; i < n; i++) '
                     's += i; return s; }\n'),
            ('dowhile', 'int f(int n) { int s = 0; do { s += n; n--; } '
                        'while (n > 0); return s; }\n'),
            ('recursion', 'int f(int n) { if (n <= 1) return 1; '
                          'return f(n - 1) + n; }\n'),
            ('call', 'extern int g(int);\nint f(int a) { return g(a) + 1; }\n'),
            ('switch', 'int f(int x) { switch (x) { case 1: return 10; '
                       'case 2: return 20; default: return 0; } }\n'),
            ('exits', 'int f(int a) { if (a > 0) return 1; '
                      'if (a < 0) return -1; return 0; }\n'),
            ('bitfield', 'struct S { unsigned a : 3; unsigned b : 5; };\n'
                         'struct S s;\n'
                         'int f(void) { s.a = 5; return (int)s.b; }\n'),
            ('stackargs', 'int f(int a, int b, int c, int d, int e) '
                          '{ return a + e; }\n'),
        ]
        for name, body in accept:
            src = os.path.join(work, 'acc_%s.c' % name)
            with open(src, 'w', encoding='utf-8') as fh:
                fh.write(body)
            got, why = census(ARKCC, work, src)
            if got is None:
                check(False, 'the %s fixture reports a census line' % name, why)
                continue
            check(got['functions'] == 1 and got['eligible_functions'] == 1,
                  'the router accepts the %s shape' % name,
                  '%d of %d routed' % (got['eligible_functions'],
                                       got['functions']))
        # stack arguments and loops must be visible in the counters, or the
        # shape is accepted for a reason nobody checked.
        got, why = census(ARKCC, work, os.path.join(work, 'acc_stackargs.c'))
        check(got is not None and got.get('stackarg') == 1,
              'the stack-argument fixture is counted as such',
              why or 'stackarg=%d' % (got or {}).get('stackarg', -1))
        got, why = census(ARKCC, work, os.path.join(work, 'acc_loop.c'))
        check(got is not None and got.get('loop') == 1,
              'the loop fixture is counted as having a back edge',
              why or 'loop=%d' % (got or {}).get('loop', -1))

        # --- 5. cropped out, refused --------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_ALLOC=0'],
                                   'arkcc_noalloc')
        if trimmed is None:
            skip('a cropped build refuses the switch', why)
        else:
            src = os.path.join(work, 'leaf')
            leaf = os.path.join(work, 'acc_leaf.c')
            rc, log = run_env([trimmed] + H.ASM_ARM + H.COMMON +
                              ['-S', '-o', os.path.join(work, 't.s'), leaf] +
                              list(H.BASE) + FLAG, work)
            check(rc != 0 and 'C3900U' in log and '-fopt-alloc' in log,
                  'the cropped build refuses -fopt-alloc by name',
                  'rc=%d' % rc)
            rc2, log2 = run_env([trimmed] + H.ASM_ARM + H.COMMON +
                                ['-S', '-o', os.path.join(work, 't2.s'), leaf] +
                                list(H.BASE), work)
            rc3, log3 = run_env([ARKCC] + H.ASM_ARM + H.COMMON +
                                ['-S', '-o', os.path.join(work, 't3.s'), leaf] +
                                list(H.BASE), work)
            if rc2 != 0 or rc3 != 0:
                check(False, 'the cropped build still compiles the fixture',
                      (log2 or log3).strip().splitlines()[:1])
            else:
                check(read_text(os.path.join(work, 't2.s')) ==
                      read_text(os.path.join(work, 't3.s')),
                      'the cropped build writes the same text as the full '
                      'build when the switch is absent')
        # --- 6. the crop matrix compiles -----------------------------------
        bad = flag_matrix(work)
        if bad is None:
            skip('the four VREGEMIT x OPT_ALLOC builds compile', 'no C compiler')
        else:
            check(not bad, 'the four VREGEMIT x OPT_ALLOC builds compile',
                  '; '.join(bad))

        return 1 if H.failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)


def flag_matrix(work):
    """Compile backend_arm.c under all four VREGEMIT x OPT_ALLOC combinations.

    Returns a list of failures (empty = all four compiled), or None when there
    is no C compiler to ask."""
    cc = os.environ.get('CC') or shutil.which('gcc')
    if not cc:
        return None
    src = os.path.join(ROOT, 'src', 'backend', 'arm', 'backend_arm.c')
    base = [cc, '-O0', '-std=c99', '-Wno-unused-parameter',
            '-Wno-unused-but-set-variable', '-Wno-unused-variable',
            '-Wno-unused-function',
            '-I', os.path.join(ROOT, 'include'), '-fsyntax-only', src]
    bad = []
    for vre in (0, 1):
        for alc in (0, 1):
            cmd = base + ['-DARKCC_FEATURE_VREGEMIT=%d' % vre,
                          '-DARKCC_FEATURE_OPT_ALLOC=%d' % alc]
            p = subprocess.run(cmd, cwd=ROOT, stdout=subprocess.PIPE,
                               stderr=subprocess.STDOUT)
            if p.returncode != 0:
                out = p.stdout.decode('utf-8', 'replace')
                first = [ln for ln in out.splitlines() if 'error' in ln]
                bad.append('VREGEMIT=%d ALLOC=%d: %s'
                           % (vre, alc, (first or ['rc=%d' % p.returncode])[0]))
    return bad

if __name__ == '__main__':
    sys.exit(main())
