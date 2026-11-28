#!/usr/bin/env python3
"""Gate for the V-6 value-resident emitter (-fopt-vemit, 0.9.1, S53).

V-6 attacks the value stack itself: inside a function it can model end to end
it keeps stack level d in r<d>, so the PUSH {r0} / POP {r0} round trips the
generic emitter writes for every IR value are never written at all.  The
pre-registration is docs/EXPR_MODEL.md section 53.  It froze two things before
a line was written: the emitter must be all-or-nothing per function (a refused
function is byte-identical to a build without the switch), and the S45-a
judgement -- the corpus on the best arm must reach 9,150 instructions -- was
the only thing that could keep the switch in the default chain.

The measurement came out the other way, and this gate pins the measurement as
well as the invariants.  Its five points:

  1. THE SWITCH ABSENT CHANGES NOTHING.  The 95-unit corpus on the
     S17+S19-a+S21 stack is 9,588 instructions / 354,989 bytes, exactly as it
     was before this slice: the feature lives behind its switch and behind its
     crop, and neither is on by default.
  2. THE SWITCH IS WIRED -- AND MEASURABLY NOT GOOD ENOUGH.  The same line
     with -fopt-vemit is 10,450 instructions / 367,644 bytes.  That is the
     recorded reason the slice is withdrawn from the default chain: the
     in-loop peepholes (-fopt-pair, -fopt-imm) and the text chain fuse pushes
     into their consumers, and a shape a pass does not recognise loses more
     than the deleted PUSH/POP pairs gain.  Pinned so the number cannot drift
     silently and so a future slice starts from the real baseline.
  3. THE EMITTER ACCOUNTS FOR ITSELF.  ARKCC_VEMIT_STATS=1 must report, per
     translation unit, taken/fallback/seen with taken + fallback == seen, and
     the corpus sums are pinned at 120 taken / 3,857 IR instructions / 212
     seen.  The report comes from the same walk that every V-6 count in the
     docs is taken from, so a silent routing change fails here.
  4. SEMANTICS DO NOT MOVE.  Fifteen fixtures -- leaf arithmetic, nested
     binary, a five-way switch, a bit-field, multi-exit early returns, array
     indexing, globals, truncation, post-increment, a loop, DUP, unary,
     char indexing, ?: and a void return -- are compiled with and without the
     switch and run on the emulator: both arms must return the value the C
     source says, and both arms must leave the same RAM.  Equal-and-wrong
     cannot pass: the value is checked against the C level, not against the
     other arm.
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_VEMIT=0 links and
     refuses -fopt-vemit by name (C3900U) instead of accepting and ignoring
     it, while the same build with the switch absent writes byte for byte the
     text the full build writes, on a fixture and on a real HAL unit.  The
     full build accepts the switch, so point 5 cannot pass by every build
     refusing everything.

Usage: run_vemit_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import re
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import run_chainfold_tests as H        # the shared corpus harness

FLAG = ['-fopt-vemit']
STACK = ['-fopt-chainfold', '-fopt-pushpop', '-fopt-remat']

# 1. the switch absent: the pinned stack.
WANT_OFF_INSNS = 9588
WANT_OFF_BYTES = 354989

# 2. the switch given: the pinned (worse) measurement.
WANT_ON_INSNS = 10450
WANT_ON_BYTES = 367644

# 3. the emitter's own accounting over the corpus.
WANT_TAKEN = 120
WANT_TAKEN_IR = 3857
WANT_SEEN = 212

REFUSED_RE = re.compile(r'C3900U: (\S+) is not compiled into this build')

PRELUDE = r'''
typedef volatile int *OUTP;
#define OUT ((OUTP)0x20010000u)
'''

HELPER = 'void __arkcc_init_globals(void){}\n'

GLOBALS = r'''
int g_a, g_b;
int garr[8];
'''

# name, body, expected return value at the C level
PROGS = [
    ('leaf', 'int f(int a,int b,int c){int t=a+b;int u=t*c;return u-t;} '
             'int main(void){return f(3,4,5);}', 28),
    ('nested', 'int main(void){int a=2,b=3,c=4,d=5;'
               'return (a+b)*(c-d)+((a*b)-(c/d));}', 1),
    ('switch', 'int k(int x){switch(x){case 0:return 7;case 1:return 9;'
               'case 2:return 11;default:return 13;}} '
               'int main(void){return k(0)+k(1)*2+k(2)*3+k(9)*4;}', 110),
    ('bitfield', 'struct S{unsigned a:3;unsigned b:5;int c:4;}; '
                 'int main(void){struct S s; s.a=5;s.b=17;s.c=-3; '
                 'return (int)s.a+(int)s.b+s.c;}', 19),
    ('multiexit', 'int f(int x){if(x>10)return 1;if(x>5)return 2;'
                  'if(x>0)return 3;return 4;} '
                  'int main(void){return f(20)+f(7)*2+f(1)*3+f(-1)*4;}', 30),
    ('array', 'int main(void){int i,s=0;for(i=0;i<8;i++)garr[i]=i*3;'
              'for(i=0;i<8;i++)s+=garr[i];return s;}', 84),
    ('globals', 'int main(void){g_a=11;g_b=g_a*2;g_a=g_b+1;'
                'return g_a+g_b;}', 45),
    ('trunc', 'int main(void){int x=0x1FF; signed char c=(signed char)x; '
              'unsigned char u=(unsigned char)x; short sh=(short)0x12345678; '
              'return (int)c+(int)u+(int)(sh&0xFF);}', 374),
    ('postinc', 'int main(void){int i=0;OUT[0]=5;OUT[1]=6;'
                'return OUT[i++]+OUT[i++]*10;}', 65),
    ('loop', 'int main(void){int i=0,s=0;while(i<10){s+=i;i++;}return s;}', 45),
    ('dup', 'int main(void){int a,b;a=b=7;return a+b;}', 14),
    ('unary', 'int main(void){int a=5;'
              'return (-a)+(!a)+(!0)+(~a)+1;}', -9),
    ('charidx', 'int main(void){char buf[4];buf[0]=1;buf[1]=2;buf[2]=3;'
                'buf[3]=4;return buf[0]+buf[1]*2+buf[2]*3+buf[3]*4;}', 30),
    ('cond', 'int f(int a,int b){return a>b?a-b:b-a;} '
             'int main(void){return f(9,4)+f(2,7)*2;}', 15),
    ('voidret', 'int g; void set(int v){g=v+1;} '
                'int main(void){set(41);return g;}', 42),
]

SMALL = r'''
int leaf(int a, int b) { return a * 3 + b; }
int pick(int a, int b) { return a > b ? a - b : b - a; }
'''

failures, skips = [], []


def check(cond, what, detail=''):
    if cond:
        print('[ok  ] %s%s' % (what, ('  (%s)' % detail) if detail else ''))
    else:
        print('[FAIL] %s%s' % (what, ('  (%s)' % detail) if detail else ''))
        failures.append(what)
    return bool(cond)


def count(res):
    """Instructions and bytes over a corpus_build() result."""
    insns = size = 0
    for txt in res.values():
        if not txt:
            continue
        size += len(txt.encode('utf-8'))
        for ln in txt.splitlines():
            if H.insn(ln)[0]:
                insns += 1
    return insns, size


def compile_to(arkcc, work, src, flags, tag):
    """-S a source with exactly `flags` (the harness BASE is not added)."""
    out = os.path.join(work, '%s.s' % tag)
    cmd = [arkcc] + H.ASM_ARM + H.COMMON + ['-S', '-o', out, src]
    for d in H.INC_DIRS:
        cmd += ['-I', d]
    cmd += list(flags)
    rc, log = H.run(cmd, work)
    if rc != 0:
        return None, rc, log
    return H.read_text(out), rc, log


def settle_flags(arkcc, work, src, flags, tag):
    """Drop every switch the build refuses by name; return what it accepts."""
    flags = list(flags)
    dropped = []
    for _ in range(len(flags) + 2):
        txt, rc, log = compile_to(arkcc, work, src, flags, tag + '_settle')
        if rc == 0:
            return flags, dropped, ''
        m = REFUSED_RE.search(log)
        if not m or m.group(1) not in flags:
            return None, dropped, (log.strip().splitlines() or ['?'])[0][:120]
        dropped.append(m.group(1))
        flags.remove(m.group(1))
    return None, dropped, 'the refusals did not settle'


def stats_of(arkcc, work, src, flags, tag):
    """Run one TU with ARKCC_VEMIT_STATS=1 and parse the vemit6 line."""
    out = os.path.join(work, '%s.s' % tag)
    cmd = [arkcc] + H.ASM_ARM + H.COMMON + ['-S', '-o', out, src]
    for d in H.INC_DIRS:
        cmd += ['-I', d]
    cmd += list(flags)
    env = dict(os.environ)
    env['ARKCC_VEMIT_STATS'] = '1'
    import subprocess
    p = subprocess.run(cmd, cwd=work, capture_output=True, text=True, env=env)
    if p.returncode != 0:
        return None
    out_ = {}
    for ln in p.stderr.splitlines():
        if ln.startswith('vemit6:'):
            for kv in ln.split()[1:]:
                k, _, v = kv.partition('=')
                out_[k] = int(v)
    return out_ or None


def run_fixture(arkcc, work, tag, body):
    src = os.path.join(work, 've_%s.c' % tag)
    with open(src, 'w', newline='\n', encoding='utf-8') as fh:
        fh.write(H.STARTUP + HELPER + PRELUDE + GLOBALS + body)
    img, err = H.build_image(arkcc, work, src, list(H.BASE) + STACK, 've_a_' + tag)
    if img is None:
        return None, 'off arm: %s' % err
    st, ret_a, snap_a, det = H.run_image(img, snap_len=0x10200)
    if st != 'returned':
        return None, 'off arm %s %s' % (st, det)
    img, err = H.build_image(arkcc, work, src,
                             list(H.BASE) + STACK + FLAG, 've_b_' + tag)
    if img is None:
        return None, 'on arm: %s' % err
    st, ret_b, snap_b, det = H.run_image(img, snap_len=0x10200)
    if st != 'returned':
        return None, 'on arm %s %s' % (st, det)
    return (ret_a, snap_a, ret_b, snap_b), ''


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_vemit_')
    try:
        units = H.corpus_units()
        if len(units) < 90:
            print('FAIL  corpus too small: %d units' % len(units))
            return 2

        # --- 1 and 2: the switch absent and given, both pinned ------------
        print('--- the corpus, switch absent and switch given')
        off, errs = H.corpus_build(arkcc, work, STACK, 've_off', units)
        check(not errs, 'the 95-unit corpus builds without the switch',
              '%d failed' % len(errs))
        insns_off, bytes_off = count(off)
        check((insns_off, bytes_off) == (WANT_OFF_INSNS, WANT_OFF_BYTES),
              'without -fopt-vemit the stack is the pinned one',
              '%d insns / %d bytes (want %d / %d)'
              % (insns_off, bytes_off, WANT_OFF_INSNS, WANT_OFF_BYTES))

        on, errs = H.corpus_build(arkcc, work, STACK + FLAG, 've_on', units)
        check(not errs, 'the 95-unit corpus builds with the switch',
              '%d failed' % len(errs))
        insns_on, bytes_on = count(on)
        check((insns_on, bytes_on) == (WANT_ON_INSNS, WANT_ON_BYTES),
              'with -fopt-vemit the corpus is the pinned measurement '
              '(+%d insns: the reason the slice stays off)'
              % (WANT_ON_INSNS - WANT_OFF_INSNS),
              '%d insns / %d bytes (want %d / %d)'
              % (insns_on, bytes_on, WANT_ON_INSNS, WANT_ON_BYTES))

        # the emitter must be visible, or every later check is vacuous
        diff_units = [k for k in on if on[k] != off[k]]
        check(len(diff_units) > 0,
              'the switch really changes the text of some unit',
              '%d units differ' % len(diff_units))

        # --- 3: the emitter's own accounting ------------------------------
        print('--- accounting (ARKCC_VEMIT_STATS=1)')
        tot = {'taken_functions': 0, 'taken_ir': 0,
               'seen_functions': 0, 'fallback_functions': 0}
        missing = 0
        for src in units:
            d = stats_of(arkcc, work, src, list(H.BASE) + STACK + FLAG, 've_st')
            if d is None:
                missing += 1
                continue
            for k in tot:
                tot[k] += d.get(k, 0)
        check(missing == 0, 'every unit reports its vemit6 line',
              '%d silent' % missing)
        check(tot['taken_functions'] == WANT_TAKEN and
              tot['taken_ir'] == WANT_TAKEN_IR and
              tot['seen_functions'] == WANT_SEEN,
              'the corpus census is the pinned one',
              'taken=%d ir=%d seen=%d (want %d / %d / %d)'
              % (tot['taken_functions'], tot['taken_ir'],
                 tot['seen_functions'], WANT_TAKEN, WANT_TAKEN_IR, WANT_SEEN))
        check(tot['taken_functions'] + tot['fallback_functions'] ==
              tot['seen_functions'],
              'taken + fallback == seen (every function is accounted for)',
              '%d + %d == %d' % (tot['taken_functions'],
                                 tot['fallback_functions'],
                                 tot['seen_functions']))
        # the report must be per-TU, not a counter left running across TUs
        small = os.path.join(work, 've_small.c')
        with open(small, 'w', newline='\n', encoding='utf-8') as fh:
            fh.write(SMALL)
        d1 = stats_of(arkcc, work, small, list(H.BASE) + STACK + FLAG, 've_s1')
        d2 = stats_of(arkcc, work, small, list(H.BASE) + STACK + FLAG, 've_s2')
        check(d1 is not None and d2 is not None and d1 == d2,
              'the report is per translation unit, not cumulative',
              '%s vs %s' % (d1, d2))
        check(d1 is not None and d1.get('seen_functions', 0) > 0 and
              d1.get('taken_functions', 0) > 0,
              'a leaf fixture is taken by the emitter', str(d1))

        # --- 4: semantics, both arms, against the C level -----------------
        print('--- semantics on %d fixtures' % len(PROGS))
        for name, body, want in PROGS:
            got, why = run_fixture(arkcc, work, name, body)
            if got is None:
                check(False, '%s: both arms run' % name, why)
                continue
            ret_a, snap_a, ret_b, snap_b = got
            want32 = want & 0xFFFFFFFF
            check(ret_a == want32,
                  '%s: the arm without the switch returns what C says' % name,
                  '%d' % ret_a if ret_a == want32 else
                  'got %d want %d' % (ret_a, want32))
            check(ret_b == want32,
                  '%s: the arm with the switch returns what C says' % name,
                  '%d' % ret_b if ret_b == want32 else
                  'got %d want %d' % (ret_b, want32))
            check(snap_a == snap_b,
                  '%s: both arms leave the same RAM' % name)

        # the comparator is not a rubber stamp: a wrong `want` must fail
        got, why = run_fixture(arkcc, work, 'dup', PROGS[10][1])
        wrong = got is not None and got[2] != (PROGS[10][2] + 1) & 0xFFFFFFFF
        check(wrong, 'the semantic comparator rejects a wrong expectation')

        # --- 5: cropped out, refused -------------------------------------
        print('--- crop -DARKCC_FEATURE_OPT_VEMIT=0')
        trimmed, why = H.build_arkcc(work, ['-DARKCC_FEATURE_OPT_VEMIT=0'],
                                     'arkcc_no_vemit')
        check(trimmed is not None, 'the vemit crop links into a working arkcc',
              why)
        if trimmed is not None:
            _, rc, log = compile_to(trimmed, work, small, FLAG, 've_refuse')
            check(rc != 0 and 'C3900U' in log and '-fopt-vemit' in log,
                  'the crop refuses -fopt-vemit by name', 'rc=%d' % rc)

            flags, dropped, err = settle_flags(trimmed, work, small,
                                               list(H.BASE) + STACK, 've_settle')
            check(flags is not None,
                  'the crop accepts the shared switch line', err)
            if flags is not None:
                fx, rc, log = compile_to(trimmed, work, small,
                                         flags, 've_crop_small')
                full, rc2, _ = compile_to(arkcc, work, small,
                                          flags, 've_full_small')
                check(fx is not None and fx == full,
                      'the cropped build writes the same fixture text')
                real = units[0]
                fx, rc, log = compile_to(trimmed, work, real,
                                         flags, 've_crop_real')
                full, rc2, _ = compile_to(arkcc, work, real,
                                          flags, 've_full_real')
                check(fx is not None and fx == full,
                      'the cropped build writes the same %s text'
                      % os.path.basename(real))
                # not a rubber stamp: the full build accepts the switch
                txt, rc, log = compile_to(arkcc, work, small,
                                          flags + FLAG, 've_full_take')
                check(rc == 0 and txt is not None,
                      'the full build accepts -fopt-vemit', 'rc=%d' % rc)
    finally:
        import shutil
        shutil.rmtree(work, ignore_errors=True)

    print()
    if failures:
        print('FAILED %d check(s):' % len(failures))
        for f in failures:
            print('  - %s' % f)
        return 1
    print('all checks passed')
    return 0


if __name__ == '__main__':
    sys.exit(main())
