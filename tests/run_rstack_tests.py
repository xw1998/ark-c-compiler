#!/usr/bin/env python3
"""Gate for the depth-2 expression stack (-fopt-rstack, 0.9.1 S49/S50).

`--reg-top` keeps the top of the IR value stack in r0 and everything below it
on the machine stack, so a binary expression still pays a whole push/pop pair
plus a register copy:

    PUSH {r0}          ; the left operand goes to memory
    <right operand>    ; ... and is loaded back into r0
    MOV r1, r0
    POP r0
    ADD r0, r0, r1

`-fopt-rstack` extends the invariant to two words -- r0 holds the top, r1 holds
the one under it -- so the same expression becomes

    MOV r1, r0         ; the left operand moves one level down, in a register
    <right operand>
    ADD r0, r0, r1

The rule is frozen in docs/EXPR_MODEL.md section 49.4.  This gate pins:

  1. OFF IS OFF, TWICE.  With the switch written off, all 95 corpus units come
     out byte-identical to the same build without the option; and the option
     alone (without --reg-top, i.e. without the model it extends) changes not
     one byte either.
  2. IT FIRES.  On the arm where it exists (BASE + --reg-top) the corpus drops
     from 16,245 to 15,901 instructions (-344), PUSH 479 -> 472, POP 463 -> 456,
     register-to-register MOVs 1,379 -> 985.  Growth is bounded: exactly four
     translation units grow, each by at most +3 instructions (stm32f4xx_hal.c
     +1, stm32f4xx_hal_dma_ex.c +3, stm32f4xx_hal_pwr_ex.c +3,
     stm32f4xx_hal_rcc_ex.c +3), and every other unit shrinks or stays flat.
  3. NO WASTED MOV.  The instrumented counter (ARKCC_RSTACK_STATS=1) reports
     1,573 depth-2 entries and 1,573 consumed pairs: the look-ahead never moves
     a value into r1 unless the very next op takes it back, so the one MOV this
     slice adds is always paid for.
  4. THE ANSWER DOES NOT CHANGE.  One emit-and-run fixture (nested binary, a
     five-argument call, runtime shifts, a bitfield, a switch) returns the value
     the C source says in both arms and leaves the same RAM in both arms.
  5. THE ASSEMBLER CAN NOW ENCODE WHAT THIS SLICE EMITS.  A three-operand
     register shift `LSL Rd, Rn, Rs` with Rn != Rd used to be encoded as the
     16-bit `Rdn <<= Rs`, silently dropping the value register (measured:
     `LSL r0, r1, r0` with r0=2, r1=12 gave 8).  The shift fixture above runs
     through `LSL r0, r1, r0`, so check 4 fails if that regression returns; the
     size pass is pinned by 3 too (a width disagreement aborts the image).
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_RSTACK=0 refuses
     the flag by name (C3900U) and still compiles the same text without it.

Usage: run_rstack_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import shutil
import struct
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

FLAG = ['-fopt-rstack']
NOFLAG = ['-fno-opt-rstack']
# build_asm() appends H.BASE itself, so these are the extras on top of it.
TEXT = ['-fopt-chainfold', '-fopt-pushpop', '-fopt-remat']
ARM_A = TEXT + ['--reg-top']
ARM_B = ARM_A + FLAG

WANT_A = (16245, 299991, 479, 463, 1379)     # insns, bytes, push, pop, mov rr
WANT_B = (15901, 295993, 472, 456, 985)
WANT_BODY_A, WANT_BODY_B = 496, 482          # body push/pop (outside pro/epi)
WANT_SITES = 1573
# The exact units that grow, with their measured delta.  Anything outside this
# set, or any unit above +3, is a regression: the depth-2 model must not be a
# net loss on any translation unit it cannot help.
WANT_GROW = {
    'stm32f4xx_hal.c': 1,
    'stm32f4xx_hal_dma_ex.c': 3,
    'stm32f4xx_hal_pwr_ex.c': 3,
    'stm32f4xx_hal_rcc_ex.c': 3,
}

FIXTURE = r'''
volatile int dummy;
#define OUT ((volatile int *)0x20010000)
#define IN  ((volatile int *)0x20010100)

__attribute__((noinline)) int nest(int a, int b, int c)
{
    return (a + b) * (b - c) + (a * c) - (a - b) / 2;
}

__attribute__((noinline)) int five(int a, int b, int c, int d, int e)
{
    return a - b * 2 + c * 3 - d * 4 + e * 5;
}

__attribute__((noinline)) int sh(int a, int k)
{
    return (a << k) + (a >> k);
}

__attribute__((noinline)) int bf(unsigned v)
{
    return (int)((v >> 3) & 0x1Fu) - (int)(v & 7u);
}

__attribute__((noinline)) int sw(int v)
{
    switch (v & 3) {
    case 0: return 11;
    case 1: return -7;
    case 2: return v * 2;
    }
    return 99;
}

int main(void)
{
    static const int tab[5][3] = {
        {12, 5, 3}, {7, 2, 9}, {-4, 6, 1}, {0, 0, 0}, {100, 3, -7}
    };
    int i, a, b, c;
    for (i = 0; i < 5; i++) {
        a = tab[i][0]; b = tab[i][1]; c = tab[i][2];
        OUT[i * 8 + 0] = nest(a, b, c);
        OUT[i * 8 + 1] = five(a, b, c, 4, 5);
        OUT[i * 8 + 2] = sh(a, 2);
        OUT[i * 8 + 3] = sh(a + 88, 3);
        OUT[i * 8 + 4] = bf(0xA5A5u + (unsigned)b);
        OUT[i * 8 + 5] = sw(1);
        OUT[i * 8 + 6] = sw(2);
        OUT[i * 8 + 7] = sw(3);
    }
    dummy = i;
    return 5;
}
'''

# inputs, [a, b, c, 0xa5a5 + b]
INPUTS = [[12, 5, 3], [7, 2, 9], [-4, 6, 1], [0, 0, 0], [100, 3, -7]]


def expect(a, b, c):
    return [
        (a + b) * (b - c) + (a * c) - int_trunc((a - b) / 2),
        a - b * 2 + c * 3 - 16 + 25,
        sh(a, 2),
        sh(a + 88, 3),
        bf((0xA5A5 + b) & 0xFFFFFFFF),
        -7,             # sw(1)
        4,              # sw(2) with v = 2
        99,             # sw(3)
    ]


def int_trunc(x):
    return int(x) if x >= 0 else -int(-x)


def sh(a, k):
    a &= 0xFFFFFFFF
    if a >= 0x80000000:
        a -= 0x100000000
    return (a << k) + (a >> k)


def bf(v):
    v &= 0xFFFFFFFF
    return (((v >> 3) & 0x1F) - (v & 7))


def tot(res):
    ins = byt = push = pop = movrr = 0
    per_unit = {}
    for k, t in res.items():
        u = [0, 0, 0, 0, 0]
        for ln in t.splitlines():
            mn, rest = H.insn(ln)
            if mn is None:
                continue
            ins += 1
            u[0] += 1
            byt += len(ln.encode('utf-8'))
            if mn in ('PUSH', 'PUSH.W'):
                push += 1
                u[2] += 1
            elif mn in ('POP', 'POP.W'):
                pop += 1
                u[3] += 1
            elif mn.startswith('MOV') and rest:
                ops = [x.strip() for x in rest.split(',')]
                if len(ops) == 2 and ops[0].startswith('r') and \
                        ops[1].startswith('r'):
                    movrr += 1
                    u[4] += 1
        per_unit[k] = tuple(u)
    return (ins, byt, push, pop, movrr), per_unit


def fn_insns(text):
    """Instructions of each function, keyed by '.global' name."""
    out, cur, name = {}, None, None
    for ln in text.splitlines():
        s = ln.strip()
        if s.startswith('.global '):
            if cur is not None:
                out[name] = cur
            name, cur = s.split(None, 1)[1], []
            continue
        if cur is not None and H.insn(ln)[0] is not None:
            cur.append(H.insn(ln)[0])
    if cur is not None:
        out[name] = cur
    return out


def body_pushpop(res):
    tot_n = body = 0
    for t in res.values():
        for ins in fn_insns(t).values():
            n = len(ins)
            for k, mn in enumerate(ins):
                if not (mn.startswith('PUSH') or mn.startswith('POP')):
                    continue
                tot_n += 1
                if 4 <= k < n - 4:
                    body += 1
    return tot_n, body


def rstack_stats(arkcc, work, units, flags):
    """Sum the instrumented counter over the corpus."""
    import subprocess
    depth2 = saved = 0
    env = dict(os.environ)
    env['ARKCC_RSTACK_STATS'] = '1'
    for src in units:
        out = os.path.join(work, 'st.s')
        cmd = [arkcc] + H.ASM_ARM + H.COMMON + ['-S', '-o', out, src]
        for d in H.INC_DIRS:
            cmd += ['-I', d]
        cmd += list(H.BASE) + list(flags)
        p = subprocess.run(cmd, cwd=work, stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT, env=env)
        for ln in p.stdout.decode('utf-8', 'replace').splitlines():
            if ln.startswith('rstack:'):
                d = dict(x.split('=') for x in ln.split()[1:])
                depth2 += int(d['depth2'])
                saved += int(d['pairs_saved'])
    return depth2, saved


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

    work = tempfile.mkdtemp(prefix='arkcc_rs_')
    try:
        # --- 1. off is off, twice ----------------------------------------
        a, errs = H.corpus_build(arkcc, work, ARM_A, 'a', units)
        an, errs2 = H.corpus_build(arkcc, work, ARM_A + NOFLAG, 'an', units)
        if errs or errs2:
            H.check(False, 'the corpus compiles on the --reg-top arm',
                    (errs + errs2)[0][:120])
            return 1
        diff = [k for k in a if a[k] != an[k]]
        H.check(not diff, 'with -fopt-rstack written off the text is '
                          'byte-identical to the same arm without it',
                '%d file(s) differ' % len(diff))

        inert, _ = H.corpus_build(arkcc, work, TEXT + FLAG, 'inert', units)
        plain, _ = H.corpus_build(arkcc, work, TEXT, 'plain', units)
        diff2 = [k for k in inert if inert[k] != plain[k]]
        H.check(not diff2, 'the switch alone (without --reg-top, the model it '
                           'extends) changes not one byte',
                '%d file(s) differ' % len(diff2))

        # --- 2. it fires --------------------------------------------------
        b, errs3 = H.corpus_build(arkcc, work, ARM_B, 'b', units)
        if errs3:
            H.check(False, 'the corpus compiles with the switch on',
                    errs3[0][:120])
            return 1
        ta, pa = tot(a)
        tb, pb = tot(b)
        H.check(ta == WANT_A, 'the --reg-top arm is %d instructions / %d bytes '
                              '(push %d, pop %d, mov-rr %d)' % WANT_A,
                '%s' % (ta,))
        H.check(tb == WANT_B, 'with -fopt-rstack it is %d instructions / %d '
                              'bytes (push %d, pop %d, mov-rr %d)' % WANT_B,
                '%s' % (tb,))
        grow = {k: pb[k][0] - pa[k][0] for k in pa if pb[k][0] > pa[k][0]}
        H.check(grow == WANT_GROW,
                'exactly four units grow, each by at most +3 (%s)' % WANT_GROW,
                'measured %s' % grow)
        H.check(ta[0] - tb[0] == 344,
              'the corpus shrinks by 344 instructions', '%d'
              % (ta[0] - tb[0]))
        ba, bb = body_pushpop(a), body_pushpop(b)
        H.check(ba == (942, WANT_BODY_A) and bb == (928, WANT_BODY_B),
                'body push/pop goes %d -> %d (out of %d / %d total)'
                % (WANT_BODY_A, WANT_BODY_B, ba[0], bb[0]), '%s %s' % (ba, bb))

        # --- 3. no wasted MOV --------------------------------------------
        d2, saved = rstack_stats(arkcc, work, units, ARM_B)
        H.check(d2 == WANT_SITES and saved == WANT_SITES,
                'the look-ahead entered depth 2 %d times and every one of them '
                'was consumed by the next op' % WANT_SITES,
                'depth2=%d pairs=%d' % (d2, saved))

        # --- 4./5. the answer does not change ----------------------------
        if not HAVE_UNICORN:
            H.skip('the two arms agree when the fixture is executed',
                   'python package unicorn missing')
        else:
            fx = os.path.join(work, 's50_fixture.c')
            with open(fx, 'w', newline='\n', encoding='utf-8') as fh:
                fh.write(H.STARTUP + FIXTURE)
            bad, vals, snaps, sites = [], {}, {}, {}
            for tag, fl in (('off', ARM_A), ('on', ARM_B)):
                img, ie = H.build_image(arkcc, work, fx, fl, tag)
                if img is None:
                    bad.append('%s: %s' % (tag, ie[:100]))
                    continue
                st, val, snap, det = H.run_image(img, snap_len=0x10200)
                if st != 'returned':
                    bad.append('%s arm did not return (%s %s)'
                               % (tag, st, det))
                    continue
                vals[tag] = val
                snaps[tag] = snap
                sites[tag] = [int.from_bytes(snap[0x10000 + 4 * k:
                                                 0x10004 + 4 * k],
                                             'little', signed=True)
                              for k in range(40)]
            if bad:
                H.check(False, 'the two arms execute the fixture',
                        '; '.join(bad[:2]))
            else:
                want = []
                for row in INPUTS:
                    want += expect(*row)
                H.check(vals['off'] == vals['on'] == 5,
                        'both arms return the fixture value',
                        'off=%s on=%s' % (vals['off'], vals['on']))
                H.check(sites['off'] == want, 'the --reg-top arm computes the '
                                              'values the C source says',
                        '%s vs %s' % (sites['off'], want))
                H.check(sites['on'] == want, 'the -fopt-rstack arm computes '
                                             'the same values',
                        '%s vs %s' % (sites['on'], want))
                H.check(snaps['off'] == snaps['on'],
                        'both arms leave the same RAM image',
                        '%d bytes each' % len(snaps['off']))

        # --- 6. cropped out, refused --------------------------------------
        trimmed, why = H.build_arkcc(work, ['-DARKCC_FEATURE_OPT_RSTACK=0'],
                                     'arkcc_nors')
        if trimmed is None:
            H.skip('a cropped build refuses the switch', why)
        else:
            src = units[0]
            inc = []
            for d in H.INC_DIRS:
                inc += ['-I', d]
            rc, log = H.run([trimmed, '-S'] + H.ASM_ARM + H.COMMON +
                            ['-O2'] + inc + [src, '-o', 'c1.s',
                                             '-fopt-rstack'], work)
            H.check(rc != 0 and 'C3900U' in log and '-fopt-rstack' in log,
                    'the cropped build refuses -fopt-rstack by name',
                    'rc=%d' % rc)
            rc2, log2 = H.run([trimmed, '-S'] + H.ASM_ARM + H.COMMON +
                              ['-O2'] + inc + [src, '-o', 'c2.s'] + ARM_A,
                              work)
            rc3, log3 = H.run([arkcc, '-S'] + H.ASM_ARM + H.COMMON +
                              ['-O2'] + inc + [src, '-o', 'c3.s'] + ARM_A,
                              work)
            if rc2 != 0 or rc3 != 0:
                H.check(False, 'the cropped build still compiles the fixture',
                        (log2 or log3).strip().splitlines()[:1])
            else:
                H.check(H.read_text(os.path.join(work, 'c2.s')) ==
                        H.read_text(os.path.join(work, 'c3.s')),
                        'the cropped build writes the same text as the full '
                        'build when the switch is absent')
        return 1 if H.failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    sys.exit(main())
