#!/usr/bin/env python3
"""Gate for the crop holes (0.9.1, S52).

A croppable compiler makes two promises at once, and one mistake broke both:
a helper function lived inside the `#if` of the pass it was written for, while
its callers lived somewhere else and were still compiled in.

Measured before the fix, with gcc on the host:

    -DARKCC_FEATURE_OPT_LIVE=0   -> undefined reference to lv_bit, lv_regs,
                                    lv_rw, lv_branch_kind, lv_ends_block
    -DARKCC_FEATURE_OPT_SPILL=0  -> undefined reference to sp_reglist
                                    (called by -fopt-pushpop, which is on)

The liveness engine (`lv_*`) is drawn on by -fopt-remat, -fopt-ldhoist,
-fopt-stackframe, -fopt-deadins and -fopt-pushpop, not only by -fopt-live;
`sp_reglist` is the shared register-list reader of -fopt-spill *and*
-fopt-pushpop.  Both crops linked anyway only because the per-pass gates
treated a failed cropped build as `skip`, so the holes read as "not
applicable" instead of as a broken configuration.  (The fix is two derived
macros, ARKCC_NEED_LV / ARKCC_NEED_SP, in include/arkcc_config.h.)

This gate does not skip.  A cropped build that does not link is a FAIL, and
each crop is checked on four points:

  1. THE CROPPED BUILD LINKS.  `-DARKCC_FEATURE_OPT_<X>=0` compiles and links
     into a working arkcc.  This is the check the other gates could not make.
  2. THE CROPPED-AWAY SWITCH IS REFUSED BY NAME.  `-fopt-live` alone on the
     live-free build must fail with C3900U and name the flag, not be accepted
     and silently ignored (one switch, one meaning).  The live crop refuses
     -fopt-live, -fopt-spill and -fopt-coalesce: both of those ride on the
     liveness engine by definition, so cropping live crops them too.
  3. OFF IS OFF.  With the switches absent the cropped build writes byte for
     byte the same assembly as the full build -- on a synthetic fixture and on
     a real HAL unit.  The shared flag set is settled first: an S15-line
     switch list is offered to the cropped build and every flag it refuses
     (C3900U, by name) is dropped for *both* sides, so the comparison is made
     on switches the cropped build really has.  Cropping removes code, never
     behaviour.
  4. THE COMPARATOR IS NOT A RUBBER STAMP.  The full build *accepts* the
     switches, so point 2 cannot pass by every build refusing everything.

Usage: run_crop_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import re
import shutil
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import run_chainfold_tests as H

check = H.check
build_arkcc, build_asm, run = H.build_arkcc, H.build_asm, H.run

REFUSED_RE = re.compile(r'C3900U: (\S+) is not compiled into this build')

SMALL = r'''
int leaf(int a, int b) { return a * 3 + b; }

int weighted(const int *p, int n)
{
    int i, s = 0;
    for (i = 0; i < n; i++)
        s += p[i] * (i + 1);
    return s;
}

int cross(int a)
{
    int acc = 0;
    while (a > 0) {
        acc += a & 3;
        if (a & 1)
            acc *= 2;
        a >>= 2;
    }
    return acc;
}
'''

# crop tag, defines, switches the cropped build must refuse by name
CROPS = [
    ('live',       ['-DARKCC_FEATURE_OPT_LIVE=0'],
     ['-fopt-live', '-fopt-spill', '-fopt-coalesce']),
    ('spill',      ['-DARKCC_FEATURE_OPT_SPILL=0'],
     ['-fopt-spill']),
    ('pushpop',    ['-DARKCC_FEATURE_OPT_PUSHPOP=0'],
     ['-fopt-pushpop']),
    ('live+spill', ['-DARKCC_FEATURE_OPT_LIVE=0',
                    '-DARKCC_FEATURE_OPT_SPILL=0'],
     ['-fopt-live', '-fopt-spill', '-fopt-coalesce']),
]


def compile_to(arkcc, work, src, flags, tag):
    """-S a fixture with the given flags (the harness BASE is *not* added)."""
    out = os.path.join(work, '%s.s' % tag)
    cmd = [arkcc] + H.ASM_ARM + H.COMMON + ['-S', '-o', out, src]
    for d in H.INC_DIRS:
        cmd += ['-I', d]
    cmd += list(flags)
    rc, log = run(cmd, work)
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


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_crop_')
    try:
        small = os.path.join(work, 'crop_small.c')
        with open(small, 'w', newline='\n', encoding='utf-8') as fh:
            fh.write(SMALL)
        units = H.corpus_units()
        real = units[0] if units else small       # one real HAL unit as well
        fixtures = [('small', small),
                    ('corpus:%s' % os.path.basename(real), real)]

        # baseline: the full build, offered the S15/S16 line
        base = {}
        for fx, path in fixtures:
            txt, rc, err = compile_to(arkcc, work, path, H.BASE,
                                      'full_%s' % fx.split(':')[0])
            base[fx] = txt
            check(txt is not None,
                  'the full build compiles the %s fixture with the 33-switch '
                  'line' % fx, '' if txt else (err.strip().splitlines() or
                                               ['?'])[0][:120])

        for tag, defines, refused in CROPS:
            print('--- crop %s ( %s )' % (tag, ' '.join(defines)))
            trimmed, why = build_arkcc(work, defines,
                                       'arkcc_no_%s' % tag.replace('+', '_'))

            # --- 1. the cropped build links ------------------------------
            if trimmed is None:
                check(False, 'the %s crop links into a working arkcc' % tag,
                      why)
                continue
            check(True, 'the %s crop links into a working arkcc' % tag)

            # --- 2. the cropped-away switch is refused by name -----------
            for flag in refused:
                txt, rc, log = compile_to(trimmed, work, small, [flag],
                                          'ref_%s_%s'
                                          % (tag.replace('+', '_'), flag[1:]))
                check(rc != 0 and 'C3900U' in log and flag in log,
                      'the %s crop refuses %s by name' % (tag, flag),
                      'rc=%d' % rc)

            # --- 3. off is off ------------------------------------------
            usable, dropped, err = settle_flags(trimmed, work, small, H.BASE,
                                                tag.replace('+', '_'))
            if usable is None:
                check(False,
                      'the %s crop accepts a settled subset of the 33-switch '
                      'line' % tag, err)
                continue
            print('      %d of %d switches kept, dropped: %s'
                  % (len(usable), len(H.BASE), ' '.join(dropped) or '-'))
            for fx, path in fixtures:
                t2, rc2, e2 = compile_to(trimmed, work, path, usable,
                                         'crop_%s_%s'
                                         % (tag.replace('+', '_'),
                                            fx.split(':')[0]))
                t3, rc3, e3 = compile_to(arkcc, work, path, usable,
                                         'full2_%s_%s'
                                         % (tag.replace('+', '_'),
                                            fx.split(':')[0]))
                if t2 is None or t3 is None:
                    check(False, 'the %s crop and the full build both compile '
                          'the %s fixture' % (tag, fx),
                          ((e2 or e3).strip().splitlines() or ['?'])[0][:120])
                else:
                    check(t2 == t3,
                          'with the switches absent the %s crop writes the '
                          'same text as the full build (%s)' % (tag, fx),
                          '%d vs %d bytes' % (len(t2), len(t3)))

        # --- 4. the comparator is not a rubber stamp ---------------------
        for flag in ('-fopt-live', '-fopt-spill', '-fopt-coalesce',
                     '-fopt-pushpop'):
            txt, rc, log = compile_to(arkcc, work, small, [flag],
                                      'full_%s' % flag[1:])
            check(rc == 0,
                  'the full build accepts %s, so the refusals above are not a '
                  'blanket no' % flag, 'rc=%d' % rc)

        return 1 if H.failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    sys.exit(main())