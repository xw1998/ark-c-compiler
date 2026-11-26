#!/usr/bin/env python3
"""Gate for the dead-instruction pass (0.9.1, -fopt-deadins / S13, V-4 slice 1).

The pass builds the function's control-flow graph and deletes a register
write whose destination no reachable path reads before the next write of it,
and a `CMP`/`CMN`/`TST`/`TEQ` whose flags no reachable path reads before the
next flag write.  The rules are frozen in docs/EXPR_MODEL.md S35.1.

What this gate pins:

  0. THE CHECKER KNOWS THE ANSWERS.  `di_oracle.py` is run on hand-written
     assembly whose deletable set is known by hand -- both directions, and
     including flags carried across a branch and a write dead only across a
     branch.  A checker that never finds a fault proves nothing.
  1. OFF IS OFF.  `-O2 <passes>` and `-O2 <passes> -fno-opt-deadins` are
     byte-identical as text and as an image.
  2. IT FIRES, AND ONLY ON DEAD WRITES.  On a real source file the pass
     removes instruction lines and adds none.  Every removed line is
     re-justified by the same independent oracle: a line may go only when no
     reachable path reads its destination (or the flags it writes) before the
     next write of it.  The gate is one-sided on purpose -- the oracle may be
     laxer than the pass, never stricter.
  3. THE REMOVED VALUE CHANGED NOTHING.  The image returns the same answer as
     the unoptimised image, and that answer is the one the source promises.
  4. USER ASSEMBLY IS LEFT ALONE.  A function that holds inline assembly is
     skipped by the whole text-pass chain (`fn_user_asm`), so every fixture
     here -- a write whose flags a branch reads, a write a later instruction
     reads, an instruction under `IT`, an unknown mnemonic, flags carried
     across a branch -- must leave the text byte-identical.
  4b. THE ENCODING FACT IT LEANS ON IS EXECUTED.  This assembler emits the
     flag-writing 16-bit form for a register `AND`; the fixture runs that and
     requires the `AND` to clobber the compare's zero flag.
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_DEADINS=0 refuses
     `-fopt-deadins` by name (C3900U) and still compiles without the flag.

Why 4 uses a smaller pass set than 1-3: the fixtures are inline assembly, and
-fopt-live/-fopt-cmat delete any inline-assembly line whose destination looks
dead to them (they cannot tell user text from emitted text).  That is a
pre-existing defect of those two passes, not of this one; running the fixtures
with the three flags where inline text survives keeps the check meaningful
while the defect is open (registered in docs/EXPR_MODEL.md S15.6).

Where the pass' own liveness rules are checked: on compiler-generated code,
by the oracle in 0 and 2.  The pass never rewrites a user-assembly function,
so no fixture of that shape can test the rules themselves.

Usage: run_deadins_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import glob
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
try:
    from run_arm_exec import STARTUP, run_image, HAVE_UNICORN
except Exception:                                        # pragma: no cover
    STARTUP, run_image, HAVE_UNICORN = '', None, False

FLAG = '-fopt-deadins'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']
PASSES = ['-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
          '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
          '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop', '-fopt-slotreg',
          '-fopt-strength', '-fopt-vstack', '-fopt-vreg', '-fopt-cmat',
          '-fopt-pair', '-fopt-litpool', '-fopt-frame', '-fopt-voldmb',
          '-fopt-constcond', '-fopt-boolmat', '-fopt-exit', '-fopt-bitmask',
          '-fopt-spill', '-fopt-ldhoist']
# Inline-assembly fixtures: only the flags under which inline text survives.
SMALL = ['-fopt-vstack', '-fopt-addr', '-fopt-frame']

# A real source file the pass measurably shrinks (bitfield write-read-back
# sequences: a load, a mask and a shift that the next statement overwrites).
REAL_SRC = os.path.join(ROOT, 'examples', 'feat_bitfield.c')
REAL_WANT = 4                      # examples/feat_bitfield.c documents 4

# --- the independent oracle ------------------------------------------------
#
# `di_oracle.py` is a separate file on purpose: it rebuilds the instruction
# tables and the liveness equations from the Thumb encodings instead of
# importing this pass' own sets, so a wrong table in the pass cannot be a
# wrong table in the checker.  See its header for what it models.

import di_oracle

INSN_RE = re.compile(r'^(\s+)([A-Z][A-Z0-9.]*)(.*)$')

CLASH = r'''
/* Every function in this file contains user assembly, and a function that
 * holds user assembly is never rewritten by any text pass (`fn_user_asm`
 * bails out before the frame passes run, see the comment at
 * `arm_skip_frame_opts` in src/backend/arm/backend_arm.c).  So what the
 * checks below really pin is that bait-out: whatever the inline text does,
 * the two arms must be byte-identical.  The pass' *liveness* rules are
 * checked on compiler-generated code in sections 2, 2b and 0 instead. */

/* The write sets the flags a branch consumes. */
unsigned di_flags(unsigned x)
{
    __asm volatile("    MOVS r4, #1");
    __asm volatile("    BNE .Ldi_e1");
    __asm volatile(".Ldi_e1:");
    return x + 2u;
}

/* MUST NOT TRIGGER: a later instruction reads the value. */
unsigned di_read(unsigned x)
{
    __asm volatile("    MOV r4, #11");
    __asm volatile("    ADD r4, r4, #1");
    __asm volatile("    ADD r4, r4, r4");
    return x + 1u;
}

/* MUST NOT TRIGGER: an instruction under IT, and an unknown mnemonic that
 * has to act as a barrier for everything after it. */
unsigned di_it(unsigned x)
{
    __asm volatile("    IT EQ");
    __asm volatile("    MOVEQ r4, #1");
    return x + 3u;
}

unsigned di_barrier(unsigned x)
{
    __asm volatile("    MOV r4, #11");
    __asm volatile("    CPSID i");
    return x + 4u;
}

/* The compare's flags travel across an unconditional branch into the block
 * that reads them; a block-local scan cannot see the reader. */
unsigned di_flagcross(unsigned x)
{
    __asm volatile("    MOV r0, #1");
    __asm volatile("    CMP r0, #1");
    __asm volatile("    B .Ldi_c1");
    __asm volatile(".Ldi_c1:");
    __asm volatile("    BEQ .Ldi_c2");
    __asm volatile(".Ldi_c2:");
    return x + 5u;
}

unsigned di_plain(unsigned x)
{
    unsigned v = x + 1u;
    return v * 3u;
}

int main(void) { return (int)(di_plain(2u) & 0xFFu); }
'''

# The encoding fact `di_oracle.py` leans on: this assembler emits the
# flag-writing 16-bit form (`ANDS`) for a register `AND`, so the `AND` below
# clobbers the zero flag the compare set and the `IT EQ` / `MOVEQ` pair must
# not fire.  Returns 1.  If a future encoder switches to the non-flag-writing
# T2 form the value becomes 7 (MOVEQ fires on the compare's Z=1) and this
# gate fails instead of the oracle silently disagreeing with the encoder.
ENC = r'''
int main(void)
{
    __asm volatile("    MOV r0, #3");
    __asm volatile("    MOVW r1, #1");
    __asm volatile("    CMP r1, #1");
    __asm volatile("    AND r0, r1");
    __asm volatile("    IT EQ");
    __asm volatile("    MOVEQ r0, #7");
    __asm volatile(".Lenc_spin:");
    __asm volatile("    B .Lenc_spin");
    return 0;
}
'''

# Hand-written assembly with answers derived by hand, used to keep the oracle
# honest: a checker that never finds a fault proves nothing.  Line numbers are
# 0-based, matching `di_oracle.deletable`.
ORACLE_CASES = [
    ('a compare whose flags a branch reads keeps it',
     'f:\n    PUSH {r4, lr}\n    CMP r0, #1\n    BEQ .La\n.La:\n'
     '    POP {r4, pc}\n', set()),
    ('a write overwritten in the same block goes',
     'f:\n    PUSH {r4, lr}\n    MOV r4, #7\n    MOV r4, #9\n'
     '    POP {r4, pc}\n', {2}),
    ('a write dead only across a branch goes',
     'f:\n    PUSH {r4, lr}\n    MOV r4, #7\n    B .Lb\n.Lb:\n'
     '    MOV r4, #9\n    MOV r0, r4\n    POP {r4, pc}\n', {2}),
    ('flags carried across a branch keep the compare',
     'f:\n    PUSH {r4, lr}\n    CMP r0, #1\n    B .Lb\n.Lb:\n'
     '    BEQ .Lc\n.Lc:\n    POP {r4, pc}\n', set()),
    ('a write the successor block reads survives',
     'f:\n    PUSH {r4, lr}\n    MOV r4, #7\n    B .Lb\n.Lb:\n'
     '    ADD r0, r4, #0\n    POP {r4, pc}\n', set()),
    ('a compare before another compare goes',
     'f:\n    PUSH {r4, lr}\n    CMP r0, #1\n    CMP r0, #2\n'
     '    POP {r4, pc}\n', {2}),
]

failures, skips = [], []

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

def write(path, text, startup=True):
    with open(path, 'w', newline='\n', encoding='utf-8') as fh:
        fh.write((STARTUP if startup else '') + text)

def run(argv, cwd):
    p = subprocess.run(argv, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')

def read_text(path):
    """Read a text artefact tolerantly.

    `.file 1 "<path>"` embeds the source path exactly as the OS handed it over,
    which on a non-UTF-8 Windows locale is GBK; both arms of every comparison
    use the same path, so a lossy decode stays comparable.
    """
    with open(path, 'rb') as fh:
        return fh.read().decode('utf-8', 'replace')

def build(arkcc, work, src, flags, tag, img=True, startup=False):
    asm = os.path.join(work, '%s_%s.s' % (tag[0], tag[1]))
    rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src, '-o', asm]
                  + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['asm failed']
    text = read_text(asm)
    if not img:
        return text, None, None
    isrc = src
    if startup:
        # The reset vector lives in the harness' startup source; a file that
        # is meant for the position-independent harness has to carry it.
        isrc = os.path.join(work, '%s_%s.img.c' % (tag[0], tag[1]))
        with open(src, 'rb') as fh:
            body = fh.read()
        with open(isrc, 'wb') as fh:
            # An initialised global makes the compiler emit the .data/.bss init
            # body; without one, `--vector-table`'s Reset_Handler would call a
            # `__arkcc_init_globals` that this file never defines.
            fh.write(STARTUP.encode('utf-8') +
                     b'int ark_di_dummy_init = 1;\n' + body)
    ipath = os.path.join(work, '%s_%s.bin' % (tag[0], tag[1]))
    rc, log = run([arkcc] + IMG_ARM + ['-O2', '-I', INC, isrc, '-o', ipath]
                  + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['image failed']
    with open(ipath, 'rb') as fh:
        return text, fh.read(), None

def build_arkcc(where, defines, name):
    cc = os.environ.get('CC', 'gcc')
    if not shutil.which(cc):
        return None, 'no %s on PATH' % cc
    srcs = (sorted(glob.glob('src/*.c')) +
            sorted(glob.glob('src/backend/*/*.c')) +
            ['src/backend/registry.c', 'port/host/flash_fs_host.c',
             'port/host/platform_host.c', 'port/host/debug_host.c'])
    out = os.path.join(where, name + ('.exe' if os.name == 'nt' else ''))
    cmd = [cc, '-Wall', '-O2', '-std=c99', '-Wno-unused-parameter',
           '-Wno-unused-but-set-variable', '-Wno-unused-variable',
           '-Wno-unused-function', '-Iinclude'] + defines + srcs + ['-o', out]
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if p.returncode != 0:
        return None, (p.stdout.decode('utf-8', 'replace').strip().splitlines()
                      or ['build failed'])[-1][:160]
    return out, ''

def main():
    global INC
    if not os.path.isdir(INC):
        INC = os.path.join(os.getcwd(), 'stdlib', 'include')

    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_di_')
    try:
        # --- 0. the oracle itself answers known-truth cases -------------------
        # A checker that says "everything is fine" is worthless, so the
        # checker is first run on hand-written assembly whose answer is known
        # by hand.  The two cross-block cases are the reason this pass exists.
        for name, asm, want in ORACLE_CASES:
            got = di_oracle.deletable(asm)
            check(got == want, 'oracle: %s' % name,
                  'deletable=%s want=%s' % (sorted(got), sorted(want)))

        # --- 1. off is off --------------------------------------------------
        t0, b0, e0 = build(arkcc, work, REAL_SRC, PASSES, ('real', 'plain'),
                           startup=True)
        t1, b1, e1 = build(arkcc, work, REAL_SRC,
                          PASSES + ['-fno-opt-deadins'], ('real', 'nofl'),
                          startup=True)
        if e0 or e1:
            check(False, 'the default build compiles the real fixture',
                  (e0 or e1)[0][:120])
            return 1
        check(t0 == t1 and b0 == b1,
              'the default build ignores the pass '
              '(-O2 == -O2 -fno-opt-deadins)',
              '%d/%d bytes' % (len(t0), len(t1)))

        off_t, off_bin, e2 = build(arkcc, work, REAL_SRC, PASSES,
                                   ('real', 'off'), startup=True)
        on_t, on_bin, e3 = build(arkcc, work, REAL_SRC, PASSES + [FLAG],
                                 ('real', 'on'), startup=True)
        if e2 or e3:
            check(False, 'both arms build the real fixture',
                  (e2 or e3)[0][:120])
            return 1

        # --- 2. it fires, and only on provably dead writes -------------------
        off_lines = off_t.splitlines()
        # Line-level difference: the pass only ever drops whole lines, so a
        # line of the optimised text is "kept" if it is present with the same
        # multiplicity.  Deletions are the leftover prefix of the unoptimised
        # text in order.
        import difflib
        sm = difflib.SequenceMatcher(None, off_lines, on_t.splitlines(),
                                     autojunk=False)
        dels, adds = [], []
        for tag, i1, i2, j1, j2 in sm.get_opcodes():
            if tag in ('delete', 'replace'):
                dels += list(range(i1, i2))
            if tag in ('insert', 'replace'):
                adds += list(range(j1, j2))
        dels = [i for i in dels if off_lines[i].strip()]
        added = []
        for tag, i1, i2, j1, j2 in sm.get_opcodes():
            if tag in ('insert', 'replace'):
                added += [ln for ln in on_t.splitlines()[j1:j2] if ln.strip()]
        check(bool(dels), 'the pass removes instruction lines from real code',
              '%d line(s)' % len(dels))
        check(not added, 'the pass never adds a line',
              ' '.join(a.strip() for a in added[:4]) or 'none')
        check(all(INSN_RE.match(off_lines[i]) for i in dels),
              'every removed line is an instruction line')
        dead = set(dels)
        oracle = di_oracle.deletable(off_t)
        unjustified = sorted(dead - oracle)
        check(not unjustified,
              'every removed write is dead by the independent CFG oracle',
              '; '.join(off_lines[i].strip()
                        for i in unjustified[:4]) or 'all')

        # --- 2b. the same containment over every translation unit ------------
        # One file cannot show that the pass keeps its promise on the shapes
        # it was widened for (a write or a compare that only a *successor*
        # block kills).  The corpus has them, so the oracle is run over every
        # deletion the pass makes in tests/chainfold corpus.
        if '--no-corpus' in sys.argv:
            skip('every corpus deletion is oracle-justified', '--no-corpus')
        else:
            import run_chainfold_tests as H
            units = H.corpus_units()
            total, bad2, failed2 = 0, [], []
            for n, unit in enumerate(units):
                # The corpus needs the STM32 include maze and the frozen
                # 34-flag baseline, so it borrows the chainfold helpers
                # instead of the local single-file `build()`.
                # BASE already carries -fopt-deadins, so the off arm turns
                # it back off explicitly; both flag lists end at the same
                # place, which keeps every other pass identical.
                o_t, e = H.build_asm(arkcc, work, unit, ['-fno-opt-deadins'],
                                     'cp_off_%03d' % n)
                n_t, e2 = H.build_asm(arkcc, work, unit, ['-fopt-deadins'],
                                      'cp_on_%03d' % n)
                if e or e2:
                    failed2.append(os.path.basename(unit))
                    continue
                sm2 = difflib.SequenceMatcher(None, o_t.splitlines(),
                                              n_t.splitlines(), autojunk=False)
                dl = []
                for tag, i1, i2, j1, j2 in sm2.get_opcodes():
                    if tag in ('delete', 'replace'):
                        dl += list(range(i1, i2))
                ol = o_t.splitlines()
                dl = [i for i in dl if INSN_RE.match(ol[i])]
                total += len(dl)
                ok2 = di_oracle.deletable(o_t)
                for i in dl:
                    if i not in ok2:
                        bad2.append('%s:%s' % (os.path.basename(unit),
                                               ol[i].strip()))
            check(not failed2, 'every corpus unit builds in both arms',
                  ' '.join(failed2[:3]) or '%d units' % len(units))
            check(not bad2,
                  'every corpus deletion is oracle-justified',
                  '%d deletion(s) over %d units%s'
                  % (total, len(units),
                     ('; %s' % '; '.join(bad2[:3])) if bad2 else ''))
            check(total > 0, 'the corpus check saw deletions at all',
                  '%d' % total)

        # --- 3. the answer does not change -----------------------------------
        if not HAVE_UNICORN:
            skip('the images agree with each other and with the source',
                 'python package unicorn missing')
        else:
            vals, ok = {}, True
            for tag, blob in (('off', off_bin), ('on', on_bin)):
                st, val, _ = run_image(blob)
                if st != 'returned':
                    check(False, '%s arm returns' % tag, st)
                    ok = False
                    break
                vals[tag] = val
            if ok:
                check(vals['off'] == vals['on'] == REAL_WANT,
                      'both arms return %d, the value the source promises'
                      % REAL_WANT,
                      ' '.join('%s=%s' % (k, vals[k]) for k in ('off', 'on')))
                check(len(on_bin) <= len(off_bin),
                      'the image never grows',
                      'off/on=%d/%d bytes' % (len(off_bin), len(on_bin)))

        # --- 4. user assembly is left alone ----------------------------------
        # Every fixture here holds inline assembly, and a function with user
        # assembly is skipped by the whole text-pass chain.  The check is that
        # the skip really happens: any of these writes would be deleted if the
        # pass had run over the function.
        write(os.path.join(work, 'clash.c'), CLASH)
        src = os.path.join(work, 'clash.c')
        to, _, eo = build(arkcc, work, src, SMALL, ('clash', 'off'), img=False)
        tn, _, en = build(arkcc, work, src, SMALL + [FLAG], ('clash', 'on'),
                          img=False)
        if eo or en:
            check(False, 'the user-assembly fixtures build', (eo or en)[0][:120])
        else:
            for fn, why in (('di_flags', 'a write whose flags a branch reads'),
                            ('di_read', 'a write a later instruction reads'),
                            ('di_it', 'an instruction under IT'),
                            ('di_barrier', 'an unknown mnemonic (barrier)'),
                            ('di_flagcross', 'flags carried across a branch')):
                fo = re.search(r'^%s:\n(.*?)^\.size %s,' % (fn, fn), to,
                               re.M | re.S)
                fn2 = re.search(r'^%s:\n(.*?)^\.size %s,' % (fn, fn), tn,
                                re.M | re.S)
                check(bool(fo) and bool(fn2) and fo.group(1) == fn2.group(1),
                      '%s: a function holding user assembly (%s) is untouched'
                      % (fn, why),
                      '%d/%d bytes' % (len(fo.group(1)) if fo else 0,
                                       len(fn2.group(1)) if fn2 else 0))
            check(to.count('MOV r4, #11') == tn.count('MOV r4, #11') and
                  tn.count('MOV r4, #11') >= 1,
                  'the inline-assembly writes are still in the text',
                  '%d occurrence(s)' % tn.count('MOV r4, #11'))

        # --- 4b. the encoding fact the oracle relies on ----------------------
        write(os.path.join(work, 'enc.c'), ENC, startup=False)
        _, enc_bin, ee = build(arkcc, work, os.path.join(work, 'enc.c'), SMALL,
                               ('enc', 'off'), startup=True)
        if ee:
            check(False, 'the encoding fixture builds', ee[0][:120])
        elif not HAVE_UNICORN:
            skip('a register AND writes the flags (the 16-bit ANDS form)',
                 'python package unicorn missing')
        else:
            # The fixture spins at the end (`B .Lenc_spin`), so the value is
            # read out of r0 after a small instruction budget instead of from
            # a return: r0 = 1 means the AND clobbered the compare's Z, r0 = 7
            # means it left it alone.
            st, val, _ = run_image(enc_bin, 2000)
            check(st == 'limit' and val == 1,
                  'a register AND writes the flags (the 16-bit ANDS form)',
                  '%s=%s' % (st, val))

        # --- 5. cropped out, refused -----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_DEADINS=0'],
                                   'arkcc_nodi')
        if trimmed is None:
            skip('a cropped build refuses -fopt-deadins', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          REAL_SRC, '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-deadins by name',
                  'rc=%d' % rc)
            rc2, log2 = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                             REAL_SRC, '-o', 't2.s'] + PASSES, work)
            rc3, log3 = run([arkcc, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                             REAL_SRC, '-o', 't3.s'] + PASSES, work)
            if rc2 != 0 or rc3 != 0:
                check(False, 'the cropped build still compiles the fixture',
                      (log2 or log3).strip().splitlines()[:1])
            else:
                check(read_text(os.path.join(work, 't2.s')) ==
                      read_text(os.path.join(work, 't3.s')),
                      'the cropped build writes the same text as the full '
                      'build when the flag is absent')
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
