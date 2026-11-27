#!/usr/bin/env python3
"""Gate for the subscript post-increment defect (0.9.1, S51).

`OUT[i++] = v;` was wrong on the S16 line whenever an earlier subscript store
had already been emitted: the second one took its address from the value
*after* the increment.  Measured under `unicorn` before the fix:

    int i=0; OUT[i++] = 11; OUT[i++] = 22;      ->  [11,0,22]   (want [11,22])
    int a=0,b=1; OUT[a++] = 11; OUT[b++] = 22;  ->  [11,0,22]   (want [11,22])
    int i=0; OUT[0] = 11; OUT[i++] = 22;        ->  [11,22]     (want [22])

The IR was right all along (`ARKCC_DUMP_IR=1` is identical on every arm); the
defect was in the region scan of -fopt-vreg.  A load's elision region ran past
a *store to the same slot from another register*, and every later read of the
load's register was then renamed onto the cache register -- which by then held
the stored value, not the loaded one.  The same source on the raw emitter (no
`-fopt-*` at all) and on the `--reg-top` arm was correct, which is how the
shape was cornered.  The scan now stops in front of such a store and the load
falls back to `MOV rD, rC`, the same single instruction the LDR cost.

Checks:

  1. THE ANSWER IS THE SAME, ON FOUR ARMS.  Eleven post-increment shapes are
     compiled and executed on the raw emitter, the S16 line, the `--reg-top`
     arm and the four-switch set that reproduced the defect
     (`-fopt-peep -fopt-prop -fopt-vstack -fopt-vreg`).  Every arm must
     produce the values the C source says and leave the same RAM.
  2. THE DEFECT'S OWN SHAPE IS PINNED.  The three rows above are in that list
     by value, so a regression names the row it broke instead of a total.
  3. THE PASS STILL NEVER GROWS A UNIT.  Over the 95-TU corpus, with
     `-fopt-vreg` no translation unit carries more instructions than the same
     build with `-fno-opt-vreg` (the contract in the pass header), and the
     aggregate is reported.
  4. THE COMPARATOR IS NOT A RUBBER STAMP.  A deliberately wrong expectation
     must be rejected, so check 1 cannot pass by comparing nothing to nothing.

Usage: run_subpostinc_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import shutil
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import run_chainfold_tests as H

try:
    from unicorn import Uc, UcError  # noqa: F401  (presence probe only)
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

# A build helper H.build_image() appends H.BASE itself; these are the extras.
ARMS = [
    ('raw',     []),
    ('S16',     []),
    ('regtop',  ['--reg-top']),
    ('minimal', ['-fopt-peep', '-fopt-prop', '-fopt-vstack', '-fopt-vreg']),
]
RAW_ARMS = {'raw'}          # this arm gets no pass list at all

PRELUDE = r'''
typedef volatile int *OUTP;
#define OUT ((OUTP)0x20010000u)
'''

# name, body, expected words at OUT[0..], expected return value
SHAPES = [
    ('single_postinc',
     'int main(void){ int i=0; OUT[i++]=11; return i; }',
     [11, 0, 0, 0], 1),
    ('single_postinc_from1',
     'int main(void){ int i=1; OUT[i++]=22; return i; }',
     [0, 22, 0, 0], 2),
    ('postinc_then_plain_index',
     'int main(void){ int i=0; OUT[i++]=11; OUT[i]=22; return i; }',
     [11, 22, 0, 0], 1),
    ('postinc_then_bump',
     'int main(void){ int i=0; OUT[i++]=11; i++; OUT[i]=22; return i; }',
     [11, 0, 22, 0], 2),
    ('twice',                       # the defect's cheapest shape
     'int main(void){ int i=0; OUT[i++]=11; OUT[i++]=22; return i; }',
     [11, 22, 0, 0], 2),
    ('two_variables',               # not the same variable: still failed
     'int main(void){ int a=0,b=1; OUT[a++]=11; OUT[b++]=22; return a+b; }',
     [11, 22, 0, 0], 3),
    ('plain_then_postinc',          # only the *second* statement increments
     'int main(void){ int i=0; OUT[0]=11; OUT[i++]=22; return i; }',
     [22, 0, 0, 0], 1),
    ('thrice',
     'int main(void){ int i=0; OUT[i++]=11; OUT[i++]=22; OUT[i++]=33; '
     'return i; }',
     [11, 22, 33, 0], 3),
    ('postinc_after_preinc',
     'int main(void){ int i=0; OUT[i++]=11; OUT[++i]=22; return i; }',
     [11, 0, 22, 0], 2),
    ('counted_loop',
     'int main(void){ int i,s=0; for(i=0;i<4;i++) OUT[i]=i+1; '
     'for(i=0;i<4;i++) s+=OUT[i]; return s; }',
     [1, 2, 3, 4], 10),
    ('postinc_on_load',             # the same shape with the increment read
     'int main(void){ int i=0; OUT[0]=5; OUT[1]=6; '
     'return OUT[i++] + OUT[i++]*10; }',
     [5, 6, 0, 0], 65),
]

HELPER = 'void __arkcc_init_globals(void){}\n'


def words(snap, n=4):
    return [int.from_bytes(snap[0x10000 + 4 * k:0x10004 + 4 * k], 'little',
                           signed=True) for k in range(n)]


def run_shape(arkcc, work, name, body, arm, flags):
    src = os.path.join(work, 'sp_%s_%s.c' % (name, arm))
    with open(src, 'w', newline='\n', encoding='utf-8') as fh:
        fh.write(H.STARTUP + HELPER + PRELUDE + body)
    img, err = H.build_image(arkcc, work, src, flags, 'sp_%s_%s' % (name, arm))
    if img is None:
        return None, '%s/%s: %s' % (name, arm, err[:100])
    st, ret, snap, det = H.run_image(img, snap_len=0x10200)
    if st != 'returned':
        return None, '%s/%s did not return (%s %s)' % (name, arm, st, det)
    return (ret, snap), None


def corpus_counts(arkcc, work, units, flags, tag):
    res, errs = H.corpus_build(arkcc, work, flags, tag, units)
    if errs:
        return None, errs[0][:120]
    out = {}
    for k, text in res.items():
        out[k] = sum(1 for ln in text.splitlines() if H.insn(ln)[0])
    return out, None


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2
    if not HAVE_UNICORN:
        print('SKIP  python package unicorn is missing; nothing to execute')
        return 0

    work = tempfile.mkdtemp(prefix='arkcc_sp_')
    try:
        # --- 1./2. the answer is the same on every arm --------------------
        bad = []
        for name, body, want_out, want_ret in SHAPES:
            got = {}
            for arm, extra in ARMS:
                flags = [] if arm in RAW_ARMS else list(H.BASE) + extra
                r, err = run_shape(arkcc, work, name, body, arm, flags)
                if err:
                    bad.append(err)
                    continue
                got[arm] = r
            if len(got) != len(ARMS):
                continue
            for arm, _ in ARMS:
                ret, snap = got[arm]
                if ret != want_ret or words(snap) != want_out:
                    bad.append('%s/%s: ret=%d OUT=%s (want ret=%d OUT=%s)'
                               % (name, arm, ret, words(snap), want_ret,
                                  want_out))
            snaps = [got[arm][1] for arm, _ in ARMS]
            if any(s != snaps[0] for s in snaps[1:]):
                bad.append('%s: the four arms leave different RAM' % name)
        H.check(not bad,
                'all %d post-increment shapes give the C answer on all %d '
                'arms (raw emitter, S16 line, --reg-top, the four-switch set '
                'that reproduced the defect)'
                % (len(SHAPES), len(ARMS)),
                '; '.join(bad[:3]))

        # --- 3. the pass still never grows a unit -------------------------
        units = H.corpus_units()
        on, e1 = corpus_counts(arkcc, work, units, list(H.BASE) + ['-fopt-vreg'], 'on')
        off, e2 = corpus_counts(arkcc, work, units,
                                list(H.BASE) + ['-fno-opt-vreg'], 'off')
        if e1 or e2:
            H.check(False, 'the corpus compiles on both -fopt-vreg arms',
                    (e1 or e2))
        else:
            grow = {k: on[k] - off[k] for k in off if on[k] > off[k]}
            H.check(not grow,
                    'with -fopt-vreg no unit grows (%d units, %d -> %d '
                    'instructions)' % (len(off), sum(off.values()),
                                       sum(on.values())),
                    'growth: %s' % grow)

        # --- 4. the comparator is not a rubber stamp ----------------------
        name, body, want_out, want_ret = SHAPES[4]          # 'twice'
        r, err = run_shape(arkcc, work, name, body, 'S16', list(H.BASE))
        ok_self = False
        if err is None:
            ret, snap = r
            good = (ret == want_ret and words(snap) == want_out)
            wrong = want_out[:]
            wrong[0] = want_out[0] + 1
            bad_cmp = (ret == want_ret and words(snap) == wrong)
            ok_self = good and not bad_cmp
        H.check(ok_self,
                'the comparator accepts the measured RAM and rejects a value '
                'that is off by one', 'two-sided')

        return 1 if H.failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    sys.exit(main())
