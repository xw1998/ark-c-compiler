#!/usr/bin/env python3
"""Gate for the MOVW/MOVT pairing fix (0.9.1, S18).

`-fopt-birthdest` (S16) renames a result that is born in one register and then
copied into its destination.  The rename is only sound when the single
instruction really writes the whole 32-bit destination.  `MOVT` does not: it
writes the high half only, so renaming it and deleting the copy leaves the
destination holding half a constant.  S18 removed `MOVT` from the "writes its
whole destination" list and taught the liveness scan that `MOVT` reads the
register it writes.

The rule is frozen in docs/EXPR_MODEL.md S24; the measurements and the verdict
are recorded in S25.

What this gate pins:

  1. THE PRICE OF THE FIX IS ZERO ON THE CORPUS.  The switch-off corpus still
     totals 10,172 instructions / 372,761 bytes (the S16 figure), and the same
     corpus with `-fno-opt-birthdest` totals 10,330 / 375,131.  The difference
     is exactly the 158 sites S16 attributed to `-fopt-birthdest`, so the fix
     did not reduce the number of renames the corpus performs -- it only
     stopped a rename that was never counted because the corpus never held the
     shape.
  2. THE FIXTURE REALLY CARRIES THE SHAPE, AND IT IS UNTOUCHED.  The executed
     fixture's `-fopt-birthdest` arm contains the `MOVW rD, #lo` / `MOVT rD,
     #hi` pair that materialises the `.bss` end, and those two lines are
     byte-identical in the `-fno-opt-birthdest` arm.  Before S18 the pair came
     out as `MOVW rD, #lo` / `MOVT rE, #hi` (E != D) with the copy deleted.
  3. THE ANSWER IS WHAT THE C SOURCE SAYS.  The fixture returns the value a
     Python model of the C source computes, and the same 256-byte RAM snapshot,
     in both arms.  The model is computed from the source text, not from any
     build.
  4. EVERY ADJACENT PAIR IN THE CORPUS AGREES.  Scanning all 95 translation
     units of the `-fopt-birthdest` arm, every `MOVW rD` that is immediately
     followed by a `MOVT` is followed by `MOVT rD`: 102 pairs, 0 mismatches.
  5. THE SCANNER CAN SEE THE MISTAKE.  Taking a real pair and rewriting its
     `MOVT` to a different register is reported as exactly one mismatch, so a
     green item 4 is not vacuous.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_REGBIRTH=0 refuses
     `-fopt-birthdest` and `-fopt-basefold` by name (C3900U) and still
     compiles the same text without them, byte for byte like the full build.

Usage: run_movtpair_tests.py [path-to-arkcc]
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

failures, skips = [], []

WANT_ON_INSNS = 10172          # the S16 total, `-fopt-birthdest` on
WANT_ON_BYTES = 372761
WANT_NOBD_INSNS = 10330        # the same corpus with -fno-opt-birthdest
WANT_NOBD_BYTES = 375131
WANT_BIRTHDEST_SITES = 158     # S16 attributed 158 renames to the switch

WANT_CORPUS_PAIRS = 102
WANT_CORPUS_MISMATCH = 0

# The minimal wrong-code repro: `i % 6u` plus a read-back of a global the same
# function wrote.  In the `.bss`-clearing prologue the compiler materialises the
# end of `.bss` as `MOVW r1, #28` / `MOVT r1, #8192` and then needs that value
# in another register; before S18 the `MOVT` was renamed and the copy deleted.
# `src` receives 1..6 and the answer folds the accumulator into its low byte,
# so a half-written constant changes both the return value and the RAM image.
FIXTURE = """
unsigned src[6];
unsigned seen[1];
int main(void)
{
    unsigned i, acc = 0u;
    src[0] = 1u; src[1] = 2u; src[2] = 3u; src[3] = 4u; src[4] = 5u;
    src[5] = 6u;
    for (i = 0u; i < 12u; i++) {
        unsigned k = i % 6u;
        seen[0] = src[k];
        acc = acc * 31u + seen[0];
    }
    return (int)(acc & 0xFFu);
}
"""

# --- the pairing scanner (items 2, 4, 5) -----------------------------------

MW = re.compile(r'^\s*MOVW\s+r(\d+)\s*,')
MT = re.compile(r'^\s*MOVT\s+r(\d+)\s*,')


def scan_pairs(text):
    """[(movw_reg, movt_reg, movw_line, movt_line)] and the mismatches."""
    lines = text.splitlines()
    pairs, bad = [], []
    for i, ln in enumerate(lines):
        m = MW.match(ln)
        if not m:
            continue
        j = i + 1
        while j < len(lines) and (not lines[j].strip() or
                                  lines[j].strip().startswith('.')):
            j += 1
        if j >= len(lines):
            continue
        n = MT.match(lines[j])
        if not n:
            continue
        row = (m.group(1), n.group(1), ln.strip(), lines[j].strip())
        pairs.append(row)
        if m.group(1) != n.group(1):
            bad.append('line %d: %s / %s' % (i + 1, ln.strip(),
                                             lines[j].strip()))
    return pairs, bad


def check(cond, what, detail=''):
    if cond:
        print('[ok  ] %s%s' % (what, ('  (%s)' % detail) if detail else ''))
    else:
        print('[FAIL] %s%s' % (what, ('  (%s)' % detail) if detail else ''))
        failures.append(what)
    return bool(cond)


def skip(what, why=''):
    print('[skip] %s%s' % (what, ('  (%s)' % why) if why else ''))
    skips.append(what)


def expected_value():
    """Recompute FIXTURE's return value from the C source, in Python."""
    src = [1, 2, 3, 4, 5, 6]
    acc = 0
    for i in range(12):
        acc = (acc * 31 + src[i % 6]) & 0xFFFFFFFF
    return acc & 0xFF


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2
    units = H.corpus_units()
    if len(units) != 95:
        print('FAIL  corpus is %d files, expected 95' % len(units))
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_mp_')
    try:
        # --- 1. the price of the fix is zero on the corpus -----------------
        on, errs = H.corpus_build(arkcc, work, [], 'on', units)
        nobd, errs2 = H.corpus_build(arkcc, work, ['-fno-opt-birthdest'],
                                     'nobd', units)
        if errs or errs2:
            check(False, 'the corpus compiles in both arms',
                  (errs + errs2)[0][:120])
            return 1
        on_i = sum(H.insn_count(t) for t in on.values())
        on_b = sum(len(t.encode('utf-8')) for t in on.values())
        nb_i = sum(H.insn_count(t) for t in nobd.values())
        nb_b = sum(len(t.encode('utf-8')) for t in nobd.values())
        check(on_i == WANT_ON_INSNS and on_b == WANT_ON_BYTES,
              'the -fopt-birthdest corpus still emits the S16 total',
              '%d insns / %d bytes' % (on_i, on_b))
        check(nb_i == WANT_NOBD_INSNS and nb_b == WANT_NOBD_BYTES,
              'the -fno-opt-birthdest corpus totals %d instructions / '
              '%d bytes' % (WANT_NOBD_INSNS, WANT_NOBD_BYTES),
              '%d insns / %d bytes' % (nb_i, nb_b))
        check(nb_i - on_i == WANT_BIRTHDEST_SITES,
              'the switch still accounts for exactly %d renames (the fix '
              'costs no rename on this corpus)' % WANT_BIRTHDEST_SITES,
              '%d - %d = %d' % (nb_i, on_i, nb_i - on_i))

        # --- 4. every adjacent pair in the corpus agrees -------------------
        all_pairs, all_bad = 0, []
        for k in sorted(on):
            pairs, bad = scan_pairs(on[k])
            all_pairs += len(pairs)
            all_bad += ['%s %s' % (k, b) for b in bad]
        check(not all_bad, 'every `MOVW rD` that an adjacent `MOVT` follows is '
                           'followed by `MOVT rD`', '; '.join(all_bad[:3]) or
              '%d pairs, 0 mismatches' % all_pairs)
        check(all_pairs == WANT_CORPUS_PAIRS and WANT_CORPUS_MISMATCH == 0,
              'the corpus contains exactly %d adjacent pairs'
              % WANT_CORPUS_PAIRS, '%d' % all_pairs)

        # --- 5. the scanner can see the mistake ---------------------------
        victim = None
        for k in sorted(on):
            pairs, bad = scan_pairs(on[k])
            if pairs:
                victim = (k, pairs[0])
                break
        if victim is None:
            check(False, 'the scanner self-test has a pair to work on',
                  'no pair in the corpus')
        else:
            k, (d, e, w_line, t_line) = victim
            other = '9' if d != '9' else '8'
            mut = on[k].replace(t_line, 'MOVT r%s,' % other, 1)
            check(mut != on[k], 'the scanner self-test really rewrote the '
                                'MOVT line', t_line)
            mp, mb = scan_pairs(mut)
            check(len(mb) == 1 and len(mp) == len(scan_pairs(on[k])[0]),
                  'rewriting one `MOVT` to a different register is reported '
                  'as exactly one mismatch', '%d mismatch(es)' % len(mb))
            if any('MOVT r%s,' % other in ln for ln in on[k].splitlines()):
                skip('the mutated text is a clean one-line change',
                     'the register r%s already appears as a MOVT target in %s'
                     % (other, k))

        # --- 2/3. the fixture: shape present, untouched, same answer ------
        fx_src = os.path.join(work, 's18_fixture.c')
        with open(fx_src, 'w', newline='\n', encoding='utf-8') as fh:
            fh.write(H.STARTUP + FIXTURE)
        fx = {}
        failed = []
        for tag, fl in (('on', []), ('nobd', ['-fno-opt-birthdest'])):
            txt, te = H.build_asm(arkcc, work, fx_src, fl, 'fx_' + tag)
            if te:
                failed.append('%s: %s' % (tag, te[:100]))
                continue
            fx[tag] = txt
        if failed:
            check(False, 'the fixture compiles in both arms',
                  '; '.join(failed[:2]))
        else:
            pairs, bad = scan_pairs(fx['on'])
            check(pairs and not bad,
                  'the -fopt-birthdest arm of the fixture carries the '
                  'MOVW/MOVT pair of the .bss end', '%d pair(s)' % len(pairs))
            np_, _ = scan_pairs(fx['nobd'])
            a = [p[2:] for p in pairs]
            b = [p[2:] for p in np_]
            drift = ('%d vs %d pairs' % (len(a), len(b)) if len(a) != len(b)
                     else next((('with: %s / %s  without: %s / %s'
                                 % (a[i][0], a[i][1], b[i][0], b[i][1]))
                                for i in range(len(a)) if a[i] != b[i]),
                               'identical'))
            check(pairs and a == b,
                  'the pair is byte-identical in the arm without the switch',
                  drift)

            want = expected_value()
            if not H.HAVE_UNICORN:
                skip('the two arms return the value the C source says',
                     'python package unicorn missing')
            else:
                vals, snaps = {}, {}
                for tag, fl in (('on', []), ('nobd', ['-fno-opt-birthdest'])):
                    img, ie = H.build_image(arkcc, work, fx_src, fl,
                                            'fx_' + tag)
                    if ie:
                        failed.append('%s image: %s' % (tag, ie[:100]))
                        continue
                    st, val, snap, det = H.run_image(img)
                    if st != 'returned':
                        failed.append('%s arm did not return (%s %s)'
                                      % (tag, st, det))
                        continue
                    vals[tag], snaps[tag] = val, snap
                if failed:
                    check(False, 'the two arms execute the fixture',
                          '; '.join(failed[:2]))
                else:
                    check(vals['on'] == want and vals['nobd'] == want,
                          'both arms return the value the C source says (%d)'
                          % want,
                          'on=%d nobd=%d' % (vals['on'], vals['nobd']))
                    check(snaps['on'] == snaps['nobd'],
                          'both arms leave the same RAM snapshot',
                          '%d bytes each' % len(snaps['on']))

        # --- 6. cropped out, refused --------------------------------------
        trimmed, why = H.build_arkcc(
            work, ['-DARKCC_FEATURE_OPT_REGBIRTH=0'], 'arkcc_norb')
        if trimmed is None:
            skip('a cropped build refuses the switches', why)
        else:
            real = os.path.join(ROOT, 'examples/ark_test/Drivers',
                                'STM32F4xx_HAL_Driver/Src',
                                'stm32f4xx_hal_dma_ex.c')
            inc = []
            for d in H.INC_DIRS:
                inc += ['-I', d]
            for flag in ('-fopt-birthdest', '-fopt-basefold'):
                rc, log = H.run([trimmed, '-S'] + H.ASM_ARM + H.COMMON +
                                ['-O2'] + inc + [real, '-o', 't.s', flag],
                                work)
                check(rc != 0 and 'C3900U' in log and flag in log,
                      'the cropped build refuses %s by name' % flag,
                      'rc=%d' % rc)
            rc2, log2 = H.run([trimmed, '-S'] + H.ASM_ARM + H.COMMON +
                              ['-O2'] + inc + [real, '-o', 't2.s'], work)
            rc3, log3 = H.run([arkcc, '-S'] + H.ASM_ARM + H.COMMON +
                              ['-O2'] + inc + [real, '-o', 't3.s'], work)
            if rc2 != 0 or rc3 != 0:
                check(False, 'the cropped build still compiles the fixture',
                      (log2 or log3).strip().splitlines()[:1])
            else:
                check(H.read_text(os.path.join(work, 't2.s')) ==
                      H.read_text(os.path.join(work, 't3.s')),
                      'the cropped build writes the same text as the full '
                      'build when the switches are absent')
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    sys.exit(main())
