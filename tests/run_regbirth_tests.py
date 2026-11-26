#!/usr/bin/env python3
"""Gate for the result-birth / base-fold pass (0.9.1, S16).

Two switches, one shape analysis (`ark_regbirth_function`, backend_arm.c):

  -fopt-birthdest   `OP r0, ...` followed by `MOV rD, r0` becomes
                    `OP rD, ...`, and the copy is deleted, when `r0` is
                    provably dead afterwards, the rename does not widen a
                    16-bit encoding, and the producer does not read its own
                    destination (a two-operand `AND r0, r7` means
                    `r0 = r0 & r7`, so renaming it would change the value).
  -fopt-basefold    `ADD rB, rX, #imm` with exactly one following access
                    `LDR|STR* rD, [rB(, #off)]` becomes
                    `LDR|STR* rD, [rX, #imm+off]`, and the ADD is deleted,
                    when `rX` is untouched in between and `rB` is dead after.

The rules are frozen in docs/EXPR_MODEL.md S20; the measurements and the
verdict are recorded in S21.

What this gate pins:

  1. OFF IS OFF.  All 95 translation units of the corpus, with both switches
     off, come out byte-identical to the same build with
     `-fno-opt-birthdest -fno-opt-basefold`, and still total 10,347
     instructions / 375,454 bytes (the S15 figure).
  2. IT FIRES, AND ONLY ON THE TWO SHAPES.  Four arms over the whole corpus
     (both off / only A / only B / both).  The A arm changes exactly 158
     instruction lines and every change is one `OP r0, ...` + `MOV rD, r0`
     pair collapsed into `OP rD, ...`; the B arm changes exactly 17 and every
     change is one `ADD rB, rX, #imm` + one access whose base moves from `rB`
     to `rX` and whose offset grows by exactly `imm`; the two arms act on
     disjoint sites and together make the combined arm.  No line is ever
     added or rewritten into anything else.
  3. INDEPENDENT RECONSTRUCTION.  `tests/rb_oracle.py` re-implements the two
     rules from the text alone (no shared code, no shared constants with the
     compiler) and its output is byte-identical to every one of the 285
     non-off arms; every deleted anchor is re-derived: the copy's source `r0`
     / the folded base `rB` really is written before it is read on every path
     the scanner can order, and the encoding/stated-operand guards hold.
  4. IT DECLINES WHEN IT MUST.  Every candidate the pass refused is still in
     the text byte-for-byte, and the refusal is re-derived from the
     unoptimised text: a two-operand producer that reads its own destination,
     a destination mentioned among the producer's operands, a rename that
     would widen a 16-bit encoding, a value that is still live, a base that is
     used again, an index that is rewritten in between, an offset that does
     not fit.  Two hand-written fixtures with the two "must not fire" shapes
     come out identical in all four arms.
  5. THE ANSWER DOES NOT CHANGE.  One emit-and-run fixture that exercises
     both shapes (four A sites, one B site) returns the same value and the
     same RAM snapshot in all four arms for 12 inputs; a sabotaged copy (one
     folded store removed) returns a different value, so the harness sees
     exactly the writes the pass reasons about.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_REGBIRTH=0
     refuses both flags by name (C3900U) and still compiles the same text
     without them.

Usage: run_regbirth_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import difflib
import glob
import os
import shutil
import struct
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import rb_oracle

try:
    from unicorn import (Uc, UcError, UC_ARCH_ARM, UC_MODE_MCLASS,
                         UC_MODE_THUMB, UC_PROT_ALL,
                         UC_HOOK_MEM_FETCH_UNMAPPED)
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_SP, UC_ARM_REG_LR
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

FLAGS_A = ['-fopt-birthdest']
FLAGS_B = ['-fopt-basefold']
FLAGS_C = FLAGS_A + FLAGS_B

# 29 switches: the S15 line (26 + spill + ldhoist + stackframe + deadins
# + ladderload + ladderstage).
PASSES = ['-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
          '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
          '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop', '-fopt-slotreg',
          '-fopt-strength', '-fopt-vstack', '-fopt-vreg', '-fopt-cmat',
          '-fopt-pair', '-fopt-litpool', '-fopt-frame', '-fopt-voldmb',
          '-fopt-constcond', '-fopt-boolmat', '-fopt-exit', '-fopt-bitmask',
          '-fopt-spill', '-fopt-ldhoist', '-fopt-stackframe', '-fopt-deadins',
          '-fopt-ladderload', '-fopt-ladderstage']

COMMON = ['-D', 'STM32F401xE', '-D', 'USE_HAL_DRIVER', '--reloc-data']
ASM_ARM = ['-target', 'arm', '-O2', '-mcpu', 'Cortex-M4']
INC_DIRS = [os.path.join(ROOT, p) for p in [
    'examples/ark_test/Core/Inc', 'examples/ark_test/Core/Inc/HAL_Driver/Inc',
    'examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Inc',
    'examples/ark_test/Drivers/CMSIS/Device/ST/STM32F4xx/Include',
    'examples/ark_test/Drivers/CMSIS/Include', 'stdlib/include']]
CORPUS_DIRS = ['examples/ark_test/Core/Src',
               'examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Src']

# The three translation units whose per-TU counts are pinned.
TU_DMA = 'stm32f4xx_hal_dma.c'          # 1481 / A 43 / B 1 / both 44
TU_GPIO = 'stm32f4xx_hal_gpio.c'        #  595 / A 25 / B 3 / both 28
TU_CORTEX = 'stm32f4xx_hal_cortex.c'    #  571 / A  1 / B 0 / both  1
WANT_TU = {TU_DMA: (1481, 43, 1, 44),
           TU_GPIO: (595, 25, 3, 28),
           TU_CORTEX: (571, 1, 0, 1)}

WANT_OFF_INSNS = 10347
WANT_OFF_BYTES = 375454
WANT_A = 158
WANT_B = 17
WANT_BOTH = 175

WORKERS = 4

STARTUP = """\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void)
{
    int rc;
    __arkcc_init_globals();
    rc = main();
    return rc;
}
"""

# One fixture, both shapes.  `seed` produces the B site (a constant-offset
# store whose base is computed into a temp, with the value already in a
# register); `fold` produces four A sites (`ADD r0, ...` staged into `r1`/`r5`)
# and reads every field back, so a lost or mis-aimed store changes the result.
FIXTURE = r'''
typedef struct { unsigned a[4]; unsigned b[4]; } S16Q;

__attribute__((noinline)) void seed(S16Q *q, unsigned k)
{
    unsigned v = (k << 1) + 3u;
    if (k != 0u) { q->b[0] = v; }
    if (k != 1u) { q->b[3] = v + 1u; }
}

__attribute__((noinline)) unsigned fold(S16Q *q, unsigned k)
{
    S16Q *t = &q[0];
    unsigned v = k * 7u;
    if (k & 1u) { t->a[0] = v; }
    if (k & 2u) { t->a[1] = v + 1u; }
    return q->a[0] + q->a[1] + q->b[0] + q->b[3];
}

int main(void)
{
    S16Q q;
    unsigned i, acc = 0u;
    for (i = 0u; i < 12u; i++) {
        q.a[0] = 0u; q.a[1] = 0u; q.a[2] = 0u; q.a[3] = 0u;
        q.b[0] = 0u; q.b[1] = 0u; q.b[2] = 0u; q.b[3] = 0u;
        seed(&q, i);
        acc = acc * 31u + fold(&q, i);
    }
    return (int)(acc & 0xFFu);
}
'''

SABOTAGE_LINE = '    if (k != 0u) { q->b[0] = v; }\n'

# Two fixtures with the "must not fire" shapes.
MUSTNOT = r'''
__attribute__((noinline)) unsigned fa(unsigned *p, unsigned k)
{
    unsigned *q = p + 1;
    return *q + *p + k;
}

__attribute__((noinline)) unsigned fb(unsigned *p)
{
    unsigned *q = p + 1;
    unsigned a = *q;
    return a + (unsigned)(q - p);
}

int main(void)
{
    unsigned buf[4];
    buf[0] = 1u; buf[1] = 2u; buf[2] = 0u; buf[3] = 0u;
    return (int)(fa(buf, 3u) + fb(buf));
}
'''

# --- text helpers ----------------------------------------------------------

PURE2 = rb_oracle.PURE2
SINGLE = rb_oracle.SINGLE
IT_INS = rb_oracle.IT_INS
COND_BR = rb_oracle.COND_BR
WHOLE = rb_oracle.WHOLE
REG_RE = r'(r\d{1,2}|sp|lr|pc)'

def is_insn(ln):
    s = ln.strip()
    if not s or s.startswith('.') or s.startswith('@') or s.startswith(';'):
        return False
    return ln.startswith('    ') or ln.startswith('\t')

def insn(ln):
    s = ln.strip()
    if not is_insn(ln):
        return None, None
    parts = s.split(None, 1)
    return parts[0], (parts[1] if len(parts) > 1 else '')

def operands(rest):
    return rb_oracle.operands(rest)

def split_ops(ln):
    mn, rest = insn(ln)
    return mn, (operands(rest) if mn else [])

def insn_list(text):
    return [ln for ln in text.splitlines() if is_insn(ln)]

def insn_count(text):
    return sum(1 for ln in text.splitlines() if is_insn(ln))

def label_line(lines, name):
    for i, ln in enumerate(lines):
        if ln.strip() == name + ':':
            return i
    return -1

def mem_of(ops):
    """(Rd, Rb, off) of `Rd, [Rb]` / `Rd, [Rb, #off]`, else None."""
    if len(ops) != 2:
        return None
    import re
    m = re.fullmatch(r'\[(r\d+)\]', ops[1])
    if m:
        return ops[0], m.group(1), 0
    m = re.fullmatch(r'\[(r\d+), #(\d+)\]', ops[1])
    if m:
        return ops[0], m.group(1), int(m.group(2))
    return None

def add_imm(ln):
    """(rB, rX, imm) of `ADD rB, rX, #imm`, else None."""
    mn, ops = split_ops(ln)
    if mn != 'ADD' or len(ops) != 3 or not ops[2].startswith('#'):
        return None
    body = ops[2][1:]
    if not body.isdigit():
        return None
    return ops[0], ops[1], int(body)

# --- process helpers -------------------------------------------------------

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

def run(argv, cwd):
    p = subprocess.run(argv, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')

def read_text(path):
    with open(path, 'rb') as fh:
        return fh.read().decode('utf-8', 'replace')

def build_asm(arkcc, work, src, flags, tag):
    out = os.path.join(work, '%s.s' % tag)
    cmd = [arkcc] + ASM_ARM + COMMON + ['-S', '-o', out, src]
    for d in INC_DIRS:
        cmd += ['-I', d]
    cmd += list(PASSES) + list(flags)
    rc, log = run(cmd, work)
    if rc != 0:
        return None, (log.strip().splitlines() or ['asm failed'])[0]
    return read_text(out), None

def build_image(arkcc, work, src, flags, tag):
    out = os.path.join(work, '%s.bin' % tag)
    cmd = [arkcc] + ASM_ARM + COMMON + ['--vector-table', '-o', out, src]
    for d in INC_DIRS:
        cmd += ['-I', d]
    cmd += list(PASSES) + list(flags)
    rc, log = run(cmd, work)
    if rc != 0:
        return None, (log.strip().splitlines() or ['image failed'])[0]
    with open(out, 'rb') as fh:
        return fh.read(), None

def build_arkcc(where, defines, name):
    cc = os.environ.get('CC', 'gcc')
    if not shutil.which(cc):
        return None, 'no %s on PATH' % cc
    srcs = (sorted(glob.glob(os.path.join(ROOT, 'src/*.c'))) +
            sorted(glob.glob(os.path.join(ROOT, 'src/backend/*/*.c'))) +
            [os.path.join(ROOT, p) for p in
             ('src/backend/registry.c', 'port/host/flash_fs_host.c',
              'port/host/platform_host.c', 'port/host/debug_host.c')])
    out = os.path.join(where, name + ('.exe' if os.name == 'nt' else ''))
    cmd = [cc, '-Wall', '-O2', '-std=c99', '-Wno-unused-parameter',
           '-Wno-unused-but-set-variable', '-Wno-unused-variable',
           '-Wno-unused-function', '-I', os.path.join(ROOT, 'include')]
    cmd += defines + srcs + ['-o', out]
    p = subprocess.run(cmd, cwd=ROOT, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    if p.returncode != 0:
        return None, (p.stdout.decode('utf-8', 'replace').strip().splitlines()
                      or ['build failed'])[-1][:160]
    return out, ''

# --- corpus ----------------------------------------------------------------

def corpus_units():
    out = []
    for d in CORPUS_DIRS:
        full = os.path.join(ROOT, d)
        for f in sorted(os.listdir(full)):
            if f.endswith('.c') and not f.startswith('_') and \
                    '_template' not in f:
                out.append(os.path.join(full, f))
    return out

def corpus_build(arkcc, work, flags, tag, units):
    """{basename: text or None} for one arm, compiled in parallel."""
    def one(src):
        base = os.path.basename(src)
        txt, err = build_asm(arkcc, work, src, flags,
                             tag + '_' + base.replace('.', '_'))
        return base, txt, err
    with ThreadPoolExecutor(max_workers=WORKERS) as ex:
        rows = list(ex.map(one, units))
    res, errs = {}, []
    for base, txt, err in rows:
        res[base] = txt
        if txt is None:
            errs.append('%s: %s' % (base, err))
    return res, errs

# --- classification (item 2) ----------------------------------------------

def a_shape(x, y, z):
    """`x` + `y` collapsed into `z`: strict rule-A shape check."""
    mx, ox = split_ops(x)
    my, oy = split_ops(y)
    mz, oz = split_ops(z)
    if mx not in SINGLE or my != 'MOV' or len(oy) != 2 or oy[1] != 'r0':
        return False
    if not ox or ox[0] != 'r0' or mz != mx or not oz:
        return False
    if ay_writeback(ox):
        return False
    return oz[0] == oy[0] and oz[0] != 'r0' and oz[1:] == ox[1:]

def ay_writeback(ops):
    for s in ops[1:]:
        if '!' in s:
            return True
        if ']' in s and s[s.index(']') + 1:].strip():
            return True
    return False

def fold_b(x, y, z):
    """`x` = `ADD rB, rX, #imm` and `y` = an access on [rB] folded into `z`.

    Returns (x, y, z, imm, off0) or None.
    """
    add = add_imm(x)
    if add is None:
        return None
    rb, rx, imm = add
    my, oy = split_ops(y)
    mz, oz = split_ops(z)
    mm = mem_of(oy)
    nm = mem_of(oz)
    if mm is None or nm is None or mz != my:
        return None
    if mm[1] != rb or nm[0] != mm[0] or nm[1] != rx:
        return None
    if nm[2] != imm + mm[2]:
        return None
    return (x, y, z, imm, mm[2])

def classify(off_text, on_text):
    """(A sites, B sites, bad, A insn indices, B insn indices).

    Sites are recognised on instruction lines only; the indices are positions
    in the unoptimised *instruction* list, so a duplicate line can never be
    confused with the site that actually fired.
    """
    a, b = insn_list(off_text), insn_list(on_text)
    sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
    A, B, bad, IA, IB = [], [], [], [], []
    pend_add, pend_mem, added = [], [], []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == 'equal':
            continue
        n, m = i2 - i1, j2 - j1
        if tag == 'insert':
            added += [(None, b[k]) for k in range(j1, j2)]
            continue
        if n and n % 2 == 0 and m == n // 2:
            for t in range(n // 2):
                x, y, z = a[i1 + 2 * t], a[i1 + 2 * t + 1], b[j1 + t]
                site = fold_b(x, y, z)
                if a_shape(x, y, z):
                    A.append((x, y, z))
                    IA.append(i1 + 2 * t)
                elif site:
                    B.append(site)
                    IB.append(i1 + 2 * t)
                else:
                    bad.append(('A shape', x, y, z))
            continue
        if tag == 'delete' and n == 1:
            if add_imm(a[i1]):
                pend_add.append((i1, a[i1]))
            else:
                pend_mem.append((i1, a[i1]))
            continue
        if tag == 'replace' and n == 1 and m == 1:
            pend_mem.append((i1, a[i1]))
            added.append((a[i1], b[j1]))
            continue
        bad.append(('hunk', tag, n, m, a[i1:i2], b[j1:j2]))
    # pair each pending ADD with one memory rewrite that it explains
    for ai, add in pend_add:
        done = False
        for k, (mi, cand) in enumerate(pend_mem):
            if cand is None:
                continue
            for w, (src, new) in enumerate(added):
                if src is None or new is None:
                    continue
                site = fold_b(add, cand, new)
                if site is None:
                    continue
                B.append(site)
                IB.append(ai)
                pend_mem[k] = (mi, None)
                added[w] = (None, None)
                done = True
                break
            if done:
                break
        if not done:
            bad.append(('unpaired ADD', add))
    left = [new for src, new in added if new is not None]
    if left:
        bad.append(('unexplained rewrite', left[:3]))
    return A, B, bad, IA, IB

def insn_lines(lines):
    """Line indices of the instruction lines, in order."""
    return [w for w in range(len(lines)) if is_insn(lines[w])]

def window(lines, i, count=5):
    """The next `count` instruction lines after line `i`."""
    out, q = [], i + 1
    while q < len(lines) and len(out) < count:
        if is_insn(lines[q]):
            out.append(q)
        q += 1
    return out

# --- refusal re-derivation (item 4) ----------------------------------------

def explain_a(off_lines, i):
    """Why the pass could not take the A candidate at instruction line i.

    Returns (category, detail).  Called only for candidates that are still in
    the text of every arm.
    """
    mn, ops = split_ops(off_lines[i])
    if ay_writeback(ops):
        return 'writeback', ops[1]
    if len(ops) == 2 and mn not in PURE2:
        return 'dest_read', '%s r0, %s' % (mn, ops[1])
    nxt = i + 1
    while nxt < len(off_lines) and not is_insn(off_lines[nxt]):
        if off_lines[nxt].strip().endswith(':'):
            return 'label_between', off_lines[nxt].strip()
        nxt += 1
    if nxt >= len(off_lines):
        return 'end_of_text', ''
    nxt_ops = split_ops(off_lines[nxt])[1]
    rd = rb_oracle.reg(nxt_ops[0]) if nxt_ops else None
    if rd is None:
        return 'no_copy', ''
    if any(rb_oracle.mentions(t, rd) for t in ops[1:]):
        return 'dest_in_ops', 'r%d' % rd
    if rb_oracle.narrow(ops) and rd > 7:
        return 'encoding', 'r%d' % rd
    if not rb_oracle.dead_after(*rb_oracle.scan(off_lines), nxt + 1, 0):
        return 'live', 'r0 still needed'
    return 'unknown', ''

def explain_b(off_lines, i, kind, insn_, label):
    """Why the pass could not take the B candidate `ADD rB, rX, #imm` at i."""
    add = add_imm(off_lines[i])
    if add is None:
        return 'not_add_imm', ''
    rb, rx, imm = add
    if imm <= 0 or imm % 4 or imm > 1020:
        return 'imm_range', str(imm)
    n = len(off_lines)
    for j in range(i + 1, min(i + 6, n)):
        if kind[j] == 2:
            return 'label_between', off_lines[j].strip()
        if kind[j] == 0:
            continue
        mn, ops = insn_[j]
        mm = mem_of(ops)
        if mm is None:
            if any(rb_oracle.mentions(t, rb) for t in ops):
                return 'base_used', off_lines[j].strip()
            if rb_oracle.primary_dest(insn_[j]) == rb_oracle.reg(rx):
                return 'index_written', off_lines[j].strip()
            if (mn.startswith('B') or mn in WHOLE or mn in IT_INS):
                return 'barrier', off_lines[j].strip()
            continue
        if mm[1] != rb:
            return 'other_base', off_lines[j].strip()
        if imm + mm[2] > 4095:
            return 'offset_too_big', ''
        if mn.startswith('STR') and mm[0] == rb:
            return 'store_of_base', off_lines[j].strip()
        if rb_oracle.mentions(ops[1], rx):
            return 'index_in_operand', off_lines[j].strip()
        if not rb_oracle.dead_after(kind, insn_, label, j + 1,
                                    rb_oracle.reg(rb)):
            return 'live', 'r%s still needed' % rb[1:]
        return 'unknown', ''
    return 'no_access', ''

# --- execution -------------------------------------------------------------

def run_image(blob, max_insn=5000000, snap_len=0x100):
    """Execute an arkc image; return (status, r0, ram snapshot, detail)."""
    if len(blob) < 8:
        return 'fault', 0, b'', 'image shorter than a vector table'
    sp = struct.unpack_from('<I', blob, 0)[0]
    entry = struct.unpack_from('<I', blob, 4)[0]
    if (entry & 1) == 0:
        return 'fault', 0, b'', 'reset vector has no Thumb bit'
    uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB | UC_MODE_MCLASS)
    flash = 0x08000000
    uc.mem_map(flash, (len(blob) + 0xFFF) & ~0xFFF, UC_PROT_ALL)
    uc.mem_write(flash, blob)
    uc.mem_map(0x20000000, 0x20000, UC_PROT_ALL)
    sentinel = 0x10000000
    state = {'status': None, 'detail': ''}

    def on_bad_fetch(uc_, access, address, size, value, user):
        if (address & ~1) == sentinel:
            state['status'] = 'returned'
        else:
            state['status'] = 'fault'
            state['detail'] = 'fetch from unmapped 0x%08X' % address
        return False

    uc.hook_add(UC_HOOK_MEM_FETCH_UNMAPPED, on_bad_fetch)
    uc.reg_write(UC_ARM_REG_SP, sp)
    uc.reg_write(UC_ARM_REG_LR, sentinel | 1)
    try:
        uc.emu_start(entry, 0, count=max_insn)
    except UcError:
        if state['status'] is None:
            return 'fault', 0, b'', 'unhandled exception'
    value = uc.reg_read(UC_ARM_REG_R0)
    snap = bytes(uc.mem_read(0x20000000, snap_len))
    if state['status'] == 'fault':
        return 'fault', value, snap, state['detail']
    if state['status'] == 'returned':
        return 'returned', value, snap, ''
    return 'limit', value, snap, 'instruction budget spent'

# --- main ------------------------------------------------------------------

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2
    units = corpus_units()
    if len(units) != 95:
        print('FAIL  corpus is %d files, expected 95' % len(units))
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_rb_')
    try:
        # --- 1. off is off ------------------------------------------------
        off, errs = corpus_build(arkcc, work, [], 'off', units)
        offb, errs2 = corpus_build(arkcc, work,
                                   ['-fno-opt-birthdest', '-fno-opt-basefold'],
                                   'offb', units)
        if errs or errs2:
            check(False, 'the corpus compiles with both switches off',
                  (errs + errs2)[0][:120])
            return 1
        diff = [k for k in off if off[k] != offb[k]]
        check(not diff, 'with both switches off the text is byte-identical '
                        'to the same build with -fno-opt-birthdest '
                        '-fno-opt-basefold', '%d file(s) differ' % len(diff))
        total_i = sum(insn_count(t) for t in off.values())
        total_b = sum(len(t.encode('utf-8')) for t in off.values())
        check(total_i == WANT_OFF_INSNS and total_b == WANT_OFF_BYTES,
              'the unoptimised corpus still emits the S15 total',
              '%d insns / %d bytes' % (total_i, total_b))

        # --- 2. it fires, and only on the two shapes -----------------------
        arms = {}
        for tag, fl in (('a', FLAGS_A), ('b', FLAGS_B), ('c', FLAGS_C)):
            arms[tag], errs = corpus_build(arkcc, work, fl, tag, units)
            if errs:
                check(False, 'the %s arm compiles the corpus' % tag,
                      errs[0][:120])
                return 1
        stats = {}
        bad_all = []
        for tag in ('a', 'b', 'c'):
            A = B = 0
            per = {}
            for k in off:
                Aa, Bb, bad, _, _ = classify(off[k], arms[tag][k])
                A += len(Aa)
                B += len(Bb)
                per[k] = (len(Aa), len(Bb))
                bad_all += [(tag, k) + tuple(str(z)[:90] for z in bd)
                            for bd in bad[:1]]
            stats[tag] = (A, B, per)
        check(not bad_all, 'every changed line is one of the two shapes',
              '; '.join('/'.join(z) for z in bad_all[:2]) or 'none unexplained')
        check(stats['a'][0] == WANT_A and stats['a'][1] == 0,
              '-fopt-birthdest collapses exactly %d arithmetic copies'
              % WANT_A, 'A=%d B=%d' % stats['a'][:2])
        check(stats['b'][1] == WANT_B and stats['b'][0] == 0,
              '-fopt-basefold folds exactly %d base adds' % WANT_B,
              'A=%d B=%d' % stats['b'][:2])
        check(stats['c'][0] == WANT_A and stats['c'][1] == WANT_B,
              'both switches together make exactly %d + %d = %d'
              % (WANT_A, WANT_B, WANT_BOTH),
              'A=%d B=%d' % stats['c'][:2])
        for name, want in sorted(WANT_TU.items()):
            check(insn_count(off[name]) == want[0],
                  '%s emits %d instructions unoptimised' % (name, want[0]),
                  '%d' % insn_count(off[name]))
            got = (stats['a'][2][name][0], stats['b'][2][name][1],
                   stats['c'][2][name][0] + stats['c'][2][name][1])
            check(got == want[1:],
                  '%s: %d A, %d B, %d both' % (name, want[1], want[2], want[3]),
                  '%d, %d, %d' % got)
        check(insn_count(''.join(arms['c'].values())) ==
              insn_count(''.join(off.values())) - WANT_BOTH,
              'the combined arm removes exactly %d instructions' % WANT_BOTH,
              '%d -> %d' % (WANT_OFF_INSNS,
                            insn_count(''.join(arms['c'].values()))))

        # --- 3. independent reconstruction --------------------------------
        drift = []
        for tag, use_a, use_b in (('a', True, False), ('b', False, True),
                                  ('c', True, True)):
            for k in off:
                want = rb_oracle.transform(off[k], use_a=use_a, use_b=use_b)
                if want != arms[tag][k]:
                    drift.append('%s/%s' % (tag, k))
        check(not drift, 'rb_oracle reproduces all %d non-off arms byte '
                         'for byte' % (3 * len(off)),
              '; '.join(drift[:3]) or '285 translations')
        # and every deleted anchor is re-derived from the off text
        dead_bad = []
        for k in off:
            lines = off[k].splitlines()
            kind, insn_, label = rb_oracle.scan(lines)
            Aa, Bb, _, IA, IB = classify(off[k], arms['c'][k])
            ilines = insn_lines(lines)
            for (x, y, z), ai in zip(Aa, IA):
                i = ilines[ai]
                win = window(lines, i, 1)
                if not win or lines[win[0]] != y:
                    dead_bad.append('%s: MOV not adjacent to producer' % k)
                    continue
                if not rb_oracle.dead_after(kind, insn_, label, win[0] + 1, 0):
                    dead_bad.append('%s: r0 still live after %s'
                                    % (k, y.strip()))
                if not a_shape(x, y, z):
                    dead_bad.append('%s: %s' % (k, z.strip()))
            for (add, cand, new, imm, off0), bi in zip(Bb, IB):
                i = ilines[bi]
                j = None
                for q in window(lines, i):
                    if lines[q] == cand:
                        j = q
                        break
                if j is None:
                    dead_bad.append('%s: folded access not found' % k)
                    continue
                if not rb_oracle.dead_after(kind, insn_, label, j + 1,
                                            rb_oracle.reg(add_imm(add)[0])):
                    dead_bad.append('%s: base still live after %s'
                                    % (k, cand.strip()))
                if imm + off0 > 4095:
                    dead_bad.append('%s: offset overflow' % k)
        check(not dead_bad, 'every deleted anchor is re-proved dead from the '
                            'unoptimised text',
              '; '.join(dead_bad[:3]) or '%d A + %d B sites'
              % (WANT_A, WANT_B))

        # --- 4. it declines when it must ----------------------------------
        cat_a = {}
        cand_a = 0
        cat_b = {}
        cand_b = 0
        moved = []
        for k in off:
            lines = off[k].splitlines()
            kind, insn_, label = rb_oracle.scan(lines)
            Aa, Bb, _, IA, IB = classify(off[k], arms['c'][k])
            ilines = insn_lines(lines)
            taken_a = set(ilines[z] for z in IA)
            taken_b = set(ilines[z] for z in IB)
            n = len(lines)
            for i in range(n):
                if kind[i] != 1:
                    continue
                mn, ops = insn_[i]
                if not ops or ops[0] != 'r0' or mn not in SINGLE:
                    continue
                nxt = i + 1
                while nxt < n and kind[nxt] == 0:
                    nxt += 1
                if nxt >= n or kind[nxt] != 1:
                    continue
                if insn_[nxt][0] != 'MOV' or len(insn_[nxt][1]) != 2 or \
                        insn_[nxt][1][1] != 'r0':
                    continue
                rd = rb_oracle.reg(insn_[nxt][1][0])
                if rd is None or rd == 0:
                    continue
                cand_a += 1
                if i in taken_a:
                    continue
                moved.append(('a', k, lines[i]))
                cat, detail = explain_a(lines, i)
                cat_a[cat] = cat_a.get(cat, 0) + 1
            # B candidates: an ADD whose one access is inside the window
            for i in range(n):
                if kind[i] != 1:
                    continue
                add = add_imm(lines[i])
                if add is None:
                    continue
                if i in taken_b:
                    cand_b += 1
                    continue
                cat, detail = explain_b(lines, i, kind, insn_, label)
                if cat in ('no_access', 'not_add_imm'):
                    continue
                cand_b += 1
                moved.append(('b', k, lines[i]))
                cat_b[cat] = cat_b.get(cat, 0) + 1
        print('[note] A candidates %d = fired %d + refused %d %s'
              % (cand_a, cand_a - sum(cat_a.values()), sum(cat_a.values()),
                 dict(sorted(cat_a.items()))))
        print('[note] B candidates %d = fired %d + refused %d %s'
              % (cand_b, cand_b - sum(cat_b.values()), sum(cat_b.values()),
                 dict(sorted(cat_b.items()))))
        missing = []
        for kind_, k, ln in moved:
            arm = arms['a'][k] if kind_ == 'a' else arms['b'][k]
            if ('\n' + ln + '\n') not in arm:
                missing.append('%s/%s: %s' % (kind_, k, ln.strip()))
        check(not missing, 'every refused candidate is still in the text of '
                           'the arm that would have used it',
              '; '.join(missing[:3]) or '%d candidate line(s)' % len(moved))
        check(cat_a.get('dest_read', 0) >= 50,
              'the two-operand shapes that read their own destination are '
              'refused', '%d site(s)' % cat_a.get('dest_read', 0))
        check(cat_a.get('live', 0) >= 1 and cat_a.get('encoding', 0) >= 1,
              'the liveness and encoding guards are exercised by real sites',
              'live %d, encoding %d' % (cat_a.get('live', 0),
                                        cat_a.get('encoding', 0)))
        check(cat_a.get('unknown', 0) == 0 and cat_b.get('unknown', 0) == 0,
              'every refusal has a re-derivable reason',
              'unknown A %d, B %d' % (cat_a.get('unknown', 0),
                                      cat_b.get('unknown', 0)))
        check(sum(cat_b.values()) > 0 and cat_b.get('index_written', 0) >= 1,
              'the base-fold guards are exercised by real sites',
              '%s' % dict(sorted(cat_b.items())))

        # two hand-written fixtures with the same shapes stay identical
        fix_src = os.path.join(work, 'mustnot.c')
        with open(fix_src, 'w', newline='\n', encoding='utf-8') as fh:
            fh.write(STARTUP + 'int ark_mn_dummy_init = 1;\n' + MUSTNOT)
        texts = {}
        for tag, fl in (('off', []), ('a', FLAGS_A), ('b', FLAGS_B),
                        ('c', FLAGS_C)):
            txt, err = build_asm(arkcc, work, fix_src, fl, 'mn_' + tag)
            if err:
                check(False, 'the must-not-fixture compiles', err[:120])
                texts = {}
                break
            texts[tag] = txt
        if texts:
            check(all(texts[t] == texts['off'] for t in ('a', 'b', 'c')),
                  'the two must-not shapes come out byte-identical in all '
                  'four arms', '%d bytes' % len(texts['off']))

        # --- 5. the answer does not change --------------------------------
        if not HAVE_UNICORN:
            skip('the four arms agree when the fixture is executed',
                 'python package unicorn missing')
        else:
            fx_src = os.path.join(work, 's16_fixture.c')
            with open(fx_src, 'w', newline='\n', encoding='utf-8') as fh:
                fh.write(STARTUP + 'int ark_s16_dummy_init = 1;\n' + FIXTURE)
            vals, snaps, changed, failed = {}, {}, {}, []
            for tag, fl in (('off', []), ('a', FLAGS_A), ('b', FLAGS_B),
                            ('c', FLAGS_C)):
                txt, te = build_asm(arkcc, work, fx_src, fl, 'fx_' + tag)
                img, ie = build_image(arkcc, work, fx_src, fl, 'fx_' + tag)
                if te or ie:
                    failed.append('%s: %s' % (tag, (te or ie)[:100]))
                    continue
                if tag != 'off':
                    Aa, Bb, bad, _, _ = classify(
                        read_text(os.path.join(work, 'fx_off.s')), txt)
                    changed[tag] = (len(Aa), len(Bb))
                st, val, snap, det = run_image(img)
                if st != 'returned':
                    failed.append('%s arm did not return (%s %s)'
                                  % (tag, st, det))
                    continue
                vals[tag], snaps[tag] = val, snap
            if failed:
                check(False, 'the four arms execute the fixture',
                      '; '.join(failed[:2]))
            else:
                check(len(set(vals.values())) == 1,
                      'all four arms return the same value for 12 inputs',
                      ' '.join('%s=%s' % (k, vals[k]) for k in
                               ('off', 'a', 'b', 'c')))
                check(len(set(snaps.values())) == 1,
                      'all four arms leave the same RAM snapshot',
                      '%d bytes each' % len(snaps['off']))
                check(changed.get('a', (0, 0))[0] > 0 and
                      changed.get('b', (0, 0))[1] > 0,
                      'the executed fixture really exercises both switches',
                      'A -%d, B -%d site(s)' % (changed.get('a', (0, 0))[0],
                                                changed.get('b', (0, 0))[1]))
                neg = os.path.join(work, 's16_fixture_neg.c')
                body = FIXTURE.replace(SABOTAGE_LINE, '', 1)
                with open(neg, 'w', newline='\n', encoding='utf-8') as fh:
                    fh.write(STARTUP + 'int ark_s16_dummy_init = 1;\n' + body)
                img, ie = build_image(arkcc, work, neg, FLAGS_C, 'fx_neg')
                if ie:
                    check(False, 'the sabotaged fixture builds', ie[:100])
                else:
                    st, val, snap, det = run_image(img)
                    check(st == 'returned' and val != vals['c'],
                          'a sabotaged fixture returns a different value '
                          '(the harness sees a wrong deletion)',
                          '%s vs %s' % (val, vals['c']))

        # --- 6. cropped out, refused --------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_REGBIRTH=0'],
                                   'arkcc_norb')
        if trimmed is None:
            skip('a cropped build refuses both switches', why)
        else:
            real = os.path.join(ROOT, 'examples/ark_test/Drivers',
                                'STM32F4xx_HAL_Driver/Src', TU_DMA)
            for flag in ('-fopt-birthdest', '-fopt-basefold'):
                inc = []
                for d in INC_DIRS:
                    inc += ['-I', d]
                rc, log = run([trimmed, '-S'] + ASM_ARM + COMMON +
                              ['-O2'] + inc + [real, '-o', 't.s', flag], work)
                check(rc != 0 and 'C3900U' in log and flag in log,
                      'the cropped build refuses %s by name' % flag,
                      'rc=%d' % rc)
            inc = []
            for d in INC_DIRS:
                inc += ['-I', d]
            rc2, log2 = run([trimmed, '-S'] + ASM_ARM + COMMON + ['-O2'] +
                            inc + [real, '-o', 't2.s'] + PASSES, work)
            rc3, log3 = run([arkcc, '-S'] + ASM_ARM + COMMON + ['-O2'] +
                            inc + [real, '-o', 't3.s'] + PASSES, work)
            if rc2 != 0 or rc3 != 0:
                check(False, 'the cropped build still compiles the fixture',
                      (log2 or log3).strip().splitlines()[:1])
            else:
                check(read_text(os.path.join(work, 't2.s')) ==
                      read_text(os.path.join(work, 't3.s')),
                      'the cropped build writes the same text as the full '
                      'build when the switches are absent')
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
