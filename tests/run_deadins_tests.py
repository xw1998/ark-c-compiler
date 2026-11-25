#!/usr/bin/env python3
"""Gate for the block-local dead-instruction pass (0.9.1, -fopt-deadins / S13).

The pass walks each basic block backwards and deletes a register write whose
destination is overwritten before it is read, and a `CMP`/`CMN`/`TST`/`TEQ`
whose flags are dead.  The rules are frozen in docs/EXPR_MODEL.md S14.2.

What this gate pins:

  1. OFF IS OFF.  `-O2 <passes>` and `-O2 <passes> -fno-opt-deadins` are
     byte-identical as text and as an image.
  2. IT FIRES, AND ONLY ON DEAD WRITES.  On a real source file the pass
     removes instruction lines and adds none.  Every removed line is
     re-justified here by an independent backwards scan of the *unoptimised*
     text: it must be a pure register write (no memory, no flags) whose
     destination is not read anywhere later in the same block before it is
     written again, and the block must really end where the pass says.
  3. THE REMOVED VALUE CHANGED NOTHING.  The image returns the same answer as
     the unoptimised image, and that answer is the one the source promises.
  4. IT DECLINES WHEN IT MUST.  A write whose flags feed a branch, a write the
     next instruction reads, an instruction under `IT`, and an unknown mnemonic
     (a barrier) all leave the text byte-identical.
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_DEADINS=0 refuses
     `-fopt-deadins` by name (C3900U) and still compiles without the flag.

Why 4 uses a smaller pass set than 1-3: the fixtures are inline assembly, and
-fopt-live/-fopt-cmat delete any inline-assembly line whose destination looks
dead to them (they cannot tell user text from emitted text).  That is a
pre-existing defect of those two passes, not of this one; running the fixtures
with the three flags where inline text survives keeps the check meaningful
while the defect is open (registered in docs/EXPR_MODEL.md S15.6).

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

# --- the independent justification scan -----------------------------------

INSN_RE = re.compile(r'^(\s+)([A-Z][A-Z0-9.]*)(.*)$')
LABEL_RE = re.compile(r'^\s*(\.[A-Za-z0-9_.]+):')

PURE = {'MOV', 'MOVW', 'ADD', 'SUB', 'AND', 'ORR', 'EOR', 'BIC', 'MVN',
        'LSL', 'LSR', 'ASR', 'UXTB', 'UXTH', 'SXTB', 'SXTH', 'MUL', 'RSB',
        'NEG', 'REV', 'REV16', 'REVSH', 'MOVT'}
WFLAGS = {'MOVS', 'ADDS', 'SUBS', 'ANDS', 'ORRS', 'EORS', 'BICS', 'MVNS',
          'LSLS', 'LSRS', 'ASRS', 'MULS', 'RSBS', 'NEGS', 'ADCS', 'SBCS'}
RFLAGS = {'ADC', 'ADCS', 'SBC', 'SBCS', 'RSC', 'RSCS'}
ENDS = {'B', 'BX', 'BL', 'BLX', 'CBZ', 'CBNZ'}
# Mnemonics whose live-set effect is modelled exactly enough to keep scanning
# instead of restarting from "everything is live".  BL/BLX and anything not
# listed here stay barriers.
KNOWN = {'LDR', 'LDRB', 'LDRH', 'LDRSB', 'LDRSH', 'VLDR',
         'STR', 'STRB', 'STRH', 'VSTR',
         'LDM', 'LDMIA', 'LDMIB', 'LDMDA', 'LDMDB',
         'STM', 'STMIA', 'STMIB', 'STMDA', 'STMDB',
         'PUSH', 'POP', 'B', 'BX', 'CBZ', 'CBNZ'}
CMPISH = {'CMP', 'CMN', 'TST', 'TEQ'}

def regs_in(txt):
    s = set()
    for m in re.finditer(r'\b(r\d{1,2}|sp|lr|pc)\b', txt):
        s.add(m.group(1))
    return s

def operands(txt):
    out, cur, depth = [], '', 0
    for ch in txt:
        if ch in '[{':
            depth += 1
        elif ch in ']}':
            depth -= 1
        if ch == ',' and depth == 0:
            out.append(cur.strip())
            cur = ''
        else:
            cur += ch
    if cur.strip():
        out.append(cur.strip())
    return out

def reads_writes(mn, ops):
    """(reads, writes, writes_flags) for one instruction, conservatively.

    Only writes are approximated, and always from *below* (a write we fail to
    notice keeps its register live, which can only make this checker laxer
    about a deletion, never stricter).  Reads are approximated from above:
    every register named in a non-destination operand is read.  That is the
    same envelope the compiler's own pass uses (`di_known` + `lv_rw`).
    """
    ops = ops[:]
    w = set()
    wf = mn in WFLAGS or mn in CMPISH
    if mn in PURE or mn in WFLAGS:
        if ops and re.fullmatch(r'(r\d{1,2}|lr|pc)', ops[0]):
            w = {ops[0]}
    elif mn in ('LDR', 'LDRB', 'LDRH', 'LDRSB', 'LDRSH', 'VLDR'):
        if ops and re.fullmatch(r'r\d{1,2}', ops[0]):
            w = {ops[0]}
    r = set()
    for i, op in enumerate(ops):
        if i == 0 and w:
            continue
        r |= regs_in(op)
    if mn == 'MOVT' and w:
        r |= w
    return r, w, wf

def justified(text):
    """Return (deleted_indices, bad) where bad lists unjustified deletions.

    `text` is the UNOPTIMISED assembly; the caller passes the set of line
    numbers the optimised text no longer has.  Blocks are split exactly the
    way the compiler splits them: a label starts one, a branch or a
    `POP {..., pc}` ends one.
    """
    lines = text.splitlines()
    blocks, cur = [], []
    for i, ln in enumerate(lines):
        cur.append(i)
        m = INSN_RE.match(ln)
        if LABEL_RE.match(ln):
            blocks.append(cur)
            cur = []
            continue
        if m and (m.group(2) in ENDS or m.group(2).startswith('B') and
                  m.group(2) not in ('BIC', 'BFI', 'BFC') and
                  len(m.group(2)) <= 3 or
                  (m.group(2) == 'POP' and 'pc' in m.group(3))):
            blocks.append(cur)
            cur = []
    if cur:
        blocks.append(cur)
    return blocks

def check_block(lines, idx, dead, bad):
    """Re-derive every deletion in one block.  `dead` is the set of line
    numbers the pass removed; they are absent from the program."""
    live = set('r%d' % k for k in range(13))
    needf = False
    for i in reversed(idx):
        ln = lines[i]
        m = INSN_RE.match(ln)
        if not m:
            continue
        mn, rest = m.group(2), m.group(3)
        if i in dead:
            if mn in CMPISH:
                if needf:
                    bad.append((i, ln.strip(), 'flags are live'))
                continue
            if mn not in PURE and mn not in WFLAGS:
                bad.append((i, ln.strip(), 'not a pure register write'))
                continue
            ops = operands(rest)
            if not ops or not re.fullmatch(r'r\d{1,2}', ops[0]):
                bad.append((i, ln.strip(), 'no register destination'))
                continue
            if ops[0] in live:
                bad.append((i, ln.strip(), '%s is live' % ops[0]))
                continue
            if mn in WFLAGS and needf:
                bad.append((i, ln.strip(), 'flags are live'))
                continue
            continue
        if mn in RFLAGS:
            needf = True
        r, w, wf = reads_writes(mn, operands(rest))
        if mn in CMPISH:
            needf = False
            live |= r
            continue
        if mn in PURE or mn in WFLAGS:
            live = (live - w) | r
            if wf:
                needf = False
            continue
        if mn in KNOWN:
            live = (live - w) | r
            continue
        # call, barrier, or unknown: keep everything alive
        live = set('r%d' % k for k in range(13))
        needf = True

CLASH = r'''
/* MUST NOT TRIGGER: the write sets the flags a branch consumes. */
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

unsigned di_plain(unsigned x)
{
    unsigned v = x + 1u;
    return v * 3u;
}

int main(void) { return (int)(di_plain(2u) & 0xFFu); }
'''

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
        bad = []
        dead = set(dels)
        for idx in justified(off_t):
            check_block(off_lines, idx, dead, bad)
        check(not bad, 'every removed write is dead by an independent scan',
              '; '.join('%s: %s' % (t, w) for _, t, w in bad[:4]) or 'all')

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

        # --- 4. it declines when it must -------------------------------------
        write(os.path.join(work, 'clash.c'), CLASH)
        src = os.path.join(work, 'clash.c')
        to, _, eo = build(arkcc, work, src, SMALL, ('clash', 'off'), img=False)
        tn, _, en = build(arkcc, work, src, SMALL + [FLAG], ('clash', 'on'),
                          img=False)
        if eo or en:
            check(False, 'the decline fixtures build', (eo or en)[0][:120])
        else:
            for fn, why in (('di_flags', 'a write whose flags a branch reads'),
                            ('di_read', 'a write a later instruction reads'),
                            ('di_it', 'an instruction under IT'),
                            ('di_barrier', 'an unknown mnemonic (barrier)')):
                fo = re.search(r'^%s:\n(.*?)^\.size %s,' % (fn, fn), to,
                               re.M | re.S)
                fn2 = re.search(r'^%s:\n(.*?)^\.size %s,' % (fn, fn), tn,
                                re.M | re.S)
                check(bool(fo) and bool(fn2) and fo.group(1) == fn2.group(1),
                      '%s: %s leaves the text byte-identical' % (fn, why),
                      '%d/%d bytes' % (len(fo.group(1)) if fo else 0,
                                       len(fn2.group(1)) if fn2 else 0))
            check(to.count('MOV r4, #11') == tn.count('MOV r4, #11') and
                  tn.count('MOV r4, #11') >= 1,
                  'the inline-assembly writes are still in the text',
                  '%d occurrence(s)' % tn.count('MOV r4, #11'))

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
