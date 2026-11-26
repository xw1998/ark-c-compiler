#!/usr/bin/env python3
"""Gate for the same-value comparison-run fold (0.9.1, S17).

One switch, one shape analysis (`ark_chainfold_function`, backend_arm.c):

  -fopt-chainfold   A *layer* is five instructions

                        LDR  rL, .Llit       ; a literal-pool load
                        CMP  rX, rL          ; two operands, rX != rL
                        BNE  label
                        MOV|MOVW rD, #v      ; two operands
                        B    label

                    and a *run* is two or more adjacent layers with the same
                    compared register, the same load register, the same
                    destination, the same value text and the same MOV/MOVW
                    mnemonic, where each layer's `BNE` lands exactly on the
                    next layer and every layer's `B` lands on one and the same
                    instruction.  A run of m layers keeps the last `MOV`/`B`,
                    turns each earlier `BNE` into `BEQ <hit>` and puts one
                    fresh `<hit>:` label in front of the kept `MOV`, so it
                    removes 2(m-1) instructions, rewrites m-1 and adds m-1
                    label lines.  Every layer keeps its own entry label, so a
                    jump into layer k still executes layer k's five
                    instructions; nothing outside the run moves.

The rule is frozen in docs/EXPR_MODEL.md S22.3; the measurements and the
verdict are recorded in S23.

What this gate pins:

  1. OFF IS OFF.  All 95 translation units of the corpus, with the switch
     off, come out byte-identical to the same build with
     `-fno-opt-chainfold`, and still total 10,106 instructions / 371,771
     bytes (the S16 figure).
  2. IT FIRES, AND ONLY BY THE RULE.  The whole corpus is compared line by
     line against the switch-off arm: every difference is either three lines
     `BNE` / `MOV|MOVW rD, #v` / `B` replaced by one `BEQ .Lcf_*`, or one
     inserted `.Lcf_*:` label line.  Nothing else is added, removed or
     rewritten.  178 rewrites, 60 labels, 9,750 / 357,713 in total, and one
     translation unit affected (stm32f4xx_hal_dma_ex.c, 1,669 -> 1,313).
  3. INDEPENDENT RECONSTRUCTION.  `tests/cf_oracle.py` re-implements the rule
     from the text alone (no shared code, no shared constants with the
     compiler); after normalising the generated label the two texts are
     byte-identical for all 95 units.  Every run is re-proved from the
     switch-off text: each folded `BNE` really lands on the next layer, all
     the `B`s of a run really land on the same instruction, the five
     instruction shapes agree inside a run, every generated label is defined
     exactly once and is referenced exactly m-1 times.
  4. IT DECLINES WHEN IT MUST.  Every layer whose successor does not extend
     it is explained from the switch-off text — a different compared
     register, a different load register, a different destination, a
     different MOV form, a different value text, a `BNE` that does not land
     on the next layer, a label in between, a `B` with a different target, no
     following layer — and none of those layers is touched.  A hand-written
     fixture whose four layers carry four different values comes out
     byte-identical in both arms while still containing the layer shape.
  5. THE ANSWER DOES NOT CHANGE.  One emit-and-run fixture with a four-layer
     same-value run plus a four-layer all-different chain returns the same
     value and the same 256-byte RAM snapshot in both arms for 12 inputs, and
     matches an expectation computed in Python from the C source; a variant
     in which the first layer loses its value (the exact mistake a broken
     fold makes) returns a different value, so the harness sees a lost
     assignment.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_CHAINFOLD=0
     refuses the flag by name (C3900U) and still compiles the same text
     without it.

Usage: run_chainfold_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import collections
import difflib
import glob
import os
import re
import shutil
import struct
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import cf_oracle

try:
    from unicorn import (Uc, UcError, UC_ARCH_ARM, UC_MODE_MCLASS,
                         UC_MODE_THUMB, UC_PROT_ALL,
                         UC_HOOK_MEM_FETCH_UNMAPPED)
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_SP, UC_ARM_REG_LR
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

# 31 switches: the S15 line (26 text passes + spill + ldhoist + stackframe
# + deadins + ladderload + ladderstage), plus the two S16 switches.  This is
# the S16 line the S17 measurement was taken on.
PASSES = ['-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
          '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
          '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop', '-fopt-slotreg',
          '-fopt-strength', '-fopt-vstack', '-fopt-vreg', '-fopt-cmat',
          '-fopt-pair', '-fopt-litpool', '-fopt-frame', '-fopt-voldmb',
          '-fopt-constcond', '-fopt-boolmat', '-fopt-exit', '-fopt-bitmask',
          '-fopt-spill', '-fopt-ldhoist', '-fopt-stackframe', '-fopt-deadins',
          '-fopt-ladderload', '-fopt-ladderstage']
S16 = ['-fopt-birthdest', '-fopt-basefold']
BASE = PASSES + S16
FLAG = ['-fopt-chainfold']
NOFLAG = ['-fno-opt-chainfold']

COMMON = ['-D', 'STM32F401xE', '-D', 'USE_HAL_DRIVER', '--reloc-data']
ASM_ARM = ['-target', 'arm', '-O2', '-mcpu', 'Cortex-M4']
INC_DIRS = [os.path.join(ROOT, p) for p in [
    'examples/ark_test/Core/Inc', 'examples/ark_test/Core/Inc/HAL_Driver/Inc',
    'examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Inc',
    'examples/ark_test/Drivers/CMSIS/Device/ST/STM32F4xx/Include',
    'examples/ark_test/Drivers/CMSIS/Include', 'stdlib/include']]
CORPUS_DIRS = ['examples/ark_test/Core/Src',
               'examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Src']

WANT_OFF_INSNS = 10106
WANT_OFF_BYTES = 371771
WANT_ON_INSNS = 9750
WANT_ON_BYTES = 357713

WANT_RUNS = 60
WANT_REWRITE = 178
WANT_DEL_MOV = 178
WANT_DEL_B = 178
WANT_LABELS = 60
WANT_RUN_SIZES = {4: 58, 3: 2}
# Every layer of the corpus, and why its successor does not extend it.
WANT_CENSUS = {'extend': 178, 'move_form': 31, 'no_following_layer': 24,
               'value': 16}
WANT_LAYERS = 249

# The one translation unit the fold touches: insns / bytes, off -> on.
TU_DMA = 'stm32f4xx_hal_dma_ex.c'
WANT_TU = {TU_DMA: (1669, 70203, 1313, 56145)}

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

# One fixture: `take` and `pick` each carry a four-layer same-value run, and
# `dist` carries a four-layer chain whose layers all differ (nothing may fold
# there).  The compared values are absolute peripheral addresses, so each layer
# loads its operand from the literal pool and the shape is the one the rule
# describes.  The answer mixes the accumulated value into the low byte, and
# `take` also stores it in `seen`, so a lost or mis-aimed layer changes both the
# return value and the RAM snapshot.
FIXTURE = r'''
volatile unsigned src[6];
unsigned seen[8];

#define FLAG(v) \
    ((v == 0x40026458u) ? 0x00200000u : \
     (v == 0x40026410u) ? 0x00200000u : \
     (v == 0x40026070u) ? 0x00200000u : \
     (v == 0x40026470u) ? 0x00200000u : 0x00100000u)

#define DIST(v) \
    ((v == 0x40026458u) ? 0x00200000u : \
     (v == 0x40026410u) ? 0x00210000u : \
     (v == 0x40026070u) ? 0x00220000u : \
     (v == 0x40026470u) ? 0x00230000u : 0x00100000u)

__attribute__((noinline)) void take(unsigned v)
{
    seen[0] = FLAG(v);
}

__attribute__((noinline)) unsigned pick(unsigned v)
{
    return FLAG(v);
}

__attribute__((noinline)) unsigned dist(unsigned v)
{
    return DIST(v);
}

int main(void)
{
    unsigned i, k = 0u, acc = 0u;
    src[0] = 0x40026458u; src[1] = 0x40026410u; src[2] = 0x40026070u;
    src[3] = 0x40026470u; src[4] = 0u; src[5] = 1u;
    for (i = 0u; i < 12u; i++) {
        unsigned v = src[k];
        take(v);
        acc = acc * 31u + (pick(v) >> 12) + (seen[0] >> 12)
                         + (dist(v) >> 12);
        if (++k == 6u) k = 0u;
    }
    return (int)(((acc >> 20) ^ (acc >> 12) ^ (acc >> 4)) & 0xFFu);
}
'''

# The sabotage: the first layer keeps a different value, which is exactly the
# mistake a fold makes when it believes two layers agree.
SABOTAGE = ("((v == 0x40026458u) ? 0x00200000u :",
            "((v == 0x40026458u) ? 0x00100000u :")

# A chain with the layer shape but four different values: nothing may fold.
MUSTNOT = r'''
volatile unsigned src[6];
unsigned seen[8];

#define DIST(v) \
    ((v == 0x40026458u) ? 0x00200000u : \
     (v == 0x40026410u) ? 0x00210000u : \
     (v == 0x40026070u) ? 0x00220000u : \
     (v == 0x40026470u) ? 0x00230000u : 0x00100000u)

__attribute__((noinline)) unsigned dist(unsigned v)
{
    return DIST(v);
}

__attribute__((noinline)) void take(unsigned v)
{
    seen[0] = DIST(v);
}

int main(void)
{
    unsigned i, k = 0u, acc = 0u;
    src[0] = 0x40026458u; src[1] = 0x40026410u; src[2] = 0x40026070u;
    src[3] = 0x40026470u; src[4] = 0u; src[5] = 1u;
    for (i = 0u; i < 12u; i++) {
        unsigned v = src[k];
        take(v);
        acc = acc * 31u + (dist(v) >> 12) + (seen[0] >> 12);
        if (++k == 6u) k = 0u;
    }
    return (int)(((acc >> 20) ^ (acc >> 12) ^ (acc >> 4)) & 0xFFu);
}
'''

# What FIXTURE must return, computed from the C source above (not from any
# build): src holds the first four addresses, which FLAG maps to 0x00200000 and
# DIST maps to 0x00200000 / 0x00210000 / 0x00220000 / 0x00230000; the last two
# entries match nothing, so both macros give 0x00100000.  main accumulates
# `acc * 31 + 2 * (FLAG >> 12) + (DIST >> 12)` twelve times over a k that
# wraps 0..5, and folds the top bytes down.
FIXTURE_FLAG = [0x00200000, 0x00200000, 0x00200000, 0x00200000, 0x00100000,
                0x00100000]
FIXTURE_DIST = [0x00200000, 0x00210000, 0x00220000, 0x00230000, 0x00100000,
                0x00100000]

# --- text helpers ----------------------------------------------------------

CF_LABEL = re.compile(r'^\.Lcf_\d+_\d+:$')
CF_LABEL_NAME = r'\.Lcf_\d+_\d+'

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

def insn_list(text):
    return [ln for ln in text.splitlines() if is_insn(ln)]

def insn_count(text):
    return sum(1 for ln in text.splitlines() if is_insn(ln))

def is_mov_imm(ln):
    mn, rest = insn(ln)
    if mn not in ('MOV', 'MOVW'):
        return False
    parts = rest.split(',')
    return len(parts) == 2 and parts[1].strip().startswith('#')

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
    cmd += list(BASE) + list(flags)
    rc, log = run(cmd, work)
    if rc != 0:
        return None, (log.strip().splitlines() or ['asm failed'])[0]
    return read_text(out), None

def build_image(arkcc, work, src, flags, tag):
    out = os.path.join(work, '%s.bin' % tag)
    cmd = [arkcc] + ASM_ARM + COMMON + ['--vector-table', '-o', out, src]
    for d in INC_DIRS:
        cmd += ['-I', d]
    cmd += list(BASE) + list(flags)
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

def classify(off_text, on_text):
    """(rewrites, deleted MOVs, deleted Bs, labels, bad).

    The only differences the rule may produce, line by line:

        replace 3 -> 1   `BNE label` / `MOV|MOVW rD, #v` / `B label`
                         -> `    BEQ .Lcf_<...>`
        insert  0 -> 1   `.Lcf_<...>:`

    Anything else is reported as `bad`.
    """
    a, b = off_text.splitlines(), on_text.splitlines()
    sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
    n_rw = n_mov = n_b = n_lab = 0
    bad = []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == 'equal':
            continue
        n, m = i2 - i1, j2 - j1
        if tag == 'insert' and m == 1 and CF_LABEL.match(b[j1]):
            n_lab += 1
            continue
        if tag == 'replace' and n == 3 and m == 1:
            x, y, z = a[i1], a[i1 + 1], a[i1 + 2]
            if (insn(x)[0] == 'BNE' and is_mov_imm(y) and
                    insn(z)[0] == 'B' and
                    b[j1].strip().startswith('BEQ .Lcf_')):
                n_rw += 1
                n_mov += 1
                n_b += 1
                continue
        bad.append((tag, n, m, a[i1:i2], b[j1:j2]))
    return n_rw, n_mov, n_b, n_lab, bad

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

def expected_value(flag, dist, rounds=12):
    """Recompute FIXTURE's return value from the C source, in Python."""
    acc = 0
    for i in range(rounds):
        k = i % 6
        acc = (acc * 31 + (flag[k] >> 12) * 2 + (dist[k] >> 12)) & 0xFFFFFFFF
    return ((acc >> 20) ^ (acc >> 12) ^ (acc >> 4)) & 0xFF

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

    work = tempfile.mkdtemp(prefix='arkcc_cf_')
    try:
        # --- 1. off is off ------------------------------------------------
        off, errs = corpus_build(arkcc, work, [], 'off', units)
        offb, errs2 = corpus_build(arkcc, work, NOFLAG, 'offb', units)
        if errs or errs2:
            check(False, 'the corpus compiles with the switch off',
                  (errs + errs2)[0][:120])
            return 1
        diff = [k for k in off if off[k] != offb[k]]
        check(not diff, 'with the switch off the text is byte-identical to '
                        'the same build with -fno-opt-chainfold',
              '%d file(s) differ' % len(diff))
        total_i = sum(insn_count(t) for t in off.values())
        total_b = sum(len(t.encode('utf-8')) for t in off.values())
        check(total_i == WANT_OFF_INSNS and total_b == WANT_OFF_BYTES,
              'the unoptimised corpus still emits the S16 total',
              '%d insns / %d bytes' % (total_i, total_b))

        # --- 2. it fires, and only by the rule -----------------------------
        on, errs = corpus_build(arkcc, work, FLAG, 'on', units)
        if errs:
            check(False, 'the -fopt-chainfold arm compiles the corpus',
                  errs[0][:120])
            return 1
        tot = [0, 0, 0, 0]
        bad_all = []
        per_tu = {}
        for k in sorted(off):
            rw, dm, db, lb, bad = classify(off[k], on[k])
            tot[0] += rw
            tot[1] += dm
            tot[2] += db
            tot[3] += lb
            per_tu[k] = (rw, dm, db, lb)
            bad_all += [('%s: %s %d->%d %s -> %s' %
                         (k, bd[0], bd[1], bd[2],
                          ' | '.join(x.strip() for x in bd[3])[:80],
                          ' | '.join(x.strip() for x in bd[4])[:80]))
                        for bd in bad[:1]]
        check(not bad_all, 'every changed line is one of the two allowed '
                           'forms', '; '.join(bad_all[:2]) or 'none unexplained')
        check(tot == [WANT_REWRITE, WANT_DEL_MOV, WANT_DEL_B, WANT_LABELS],
              'the fold rewrites exactly %d `BNE`, deletes %d `MOV` + %d `B` '
              'and adds exactly %d labels'
              % (WANT_REWRITE, WANT_DEL_MOV, WANT_DEL_B, WANT_LABELS),
              'rewrite %d, del MOV %d, del B %d, labels %d' % tuple(tot))
        on_i = sum(insn_count(t) for t in on.values())
        on_b = sum(len(t.encode('utf-8')) for t in on.values())
        check(on_i == WANT_ON_INSNS and on_b == WANT_ON_BYTES,
              'the folded corpus totals %d instructions / %d bytes'
              % (WANT_ON_INSNS, WANT_ON_BYTES),
              '%d insns / %d bytes' % (on_i, on_b))
        check(on_i == total_i - 2 * WANT_REWRITE,
              'the removed instructions are exactly 2 per rewrite',
              '%d - 2 * %d = %d' % (total_i, WANT_REWRITE, on_i))
        touched = sorted(k for k in per_tu if any(per_tu[k]))
        check(touched == sorted(WANT_TU),
              'the fold touches exactly %d translation unit(s)' % len(WANT_TU),
              ', '.join(touched) or 'none')
        for name, want in sorted(WANT_TU.items()):
            got = (insn_count(off[name]), len(off[name].encode('utf-8')),
                   insn_count(on[name]), len(on[name].encode('utf-8')))
            check(got == want, '%s: %d/%d -> %d/%d'
                  % (name, want[0], want[1], want[2], want[3]),
                  '%d/%d -> %d/%d' % got)

        # --- 3. independent reconstruction --------------------------------
        drift = []
        for k in off:
            got = cf_oracle.normalise(cf_oracle.transform(off[k]))
            want = cf_oracle.normalise(on[k])
            if got != want:
                drift.append(k)
        check(not drift, 'cf_oracle reproduces all %d folded translations '
                         'byte for byte' % len(off),
              '; '.join(drift[:3]) or 'after normalising .Lcf_<a>_<b>')

        run_bad = []
        lab_bad = []
        sizes = collections.Counter()
        runs_total = 0
        refs_total = 0
        for k in sorted(off):
            t = cf_oracle.Text(off[k])
            off_runs = cf_oracle.runs(t)
            runs_total += len(off_runs)
            on_lines = on[k].splitlines()
            # Instruction ordinals let the folded text be walked without
            # looking at line distances: a replaced layer is LDR / CMP /
            # BEQ <hit> on consecutive ordinals, so the layers of one run sit
            # exactly three ordinals apart.
            ilines = [i for i in range(len(on_lines)) if is_insn(on_lines[i])]
            marks = []
            for o in range(2, len(ilines)):
                a0, a1, a2 = ilines[o - 2], ilines[o - 1], ilines[o]
                ma, ra = insn(on_lines[a0])
                mb, rb = insn(on_lines[a1])
                mc, rc = insn(on_lines[a2])
                if ma != 'LDR' or mb != 'CMP' or mc != 'BEQ':
                    continue
                pa, pb = ra.split(','), rb.split(',')
                if len(pa) != 2 or not pa[1].strip().startswith('.'):
                    continue
                if len(pb) != 2 or pb[1].strip() != pa[0].strip():
                    continue
                if not rc.strip().startswith('.Lcf_'):
                    continue
                marks.append((o, rc.strip()))
            groups = []
            for o, lab in marks:
                if groups and o == groups[-1][-1][0] + 3:
                    groups[-1].append((o, lab))
                else:
                    groups.append([(o, lab)])
            if len(groups) != len(off_runs):
                lab_bad.append('%s: %d rewritten groups for %d oracle runs'
                               % (k, len(groups), len(off_runs)))
            if sorted(len(g) + 1 for g in groups) != sorted(
                    len(r) for r in off_runs):
                lab_bad.append('%s: group sizes %s != run sizes %s'
                               % (k, sorted(len(g) + 1 for g in groups),
                                  sorted(len(r) for r in off_runs)))
            for g in groups:
                labs = set(lab for _, lab in g)
                if len(labs) != 1:
                    run_bad.append('%s: the layers of one run aim at %d '
                                   'labels' % (k, len(labs)))
                    continue
                lab = labs.pop()
                sizes[len(g) + 1] += 1
                refs_total += len(g)
                regs = set()
                for o, _ in g:
                    regs.add(insn(on_lines[ilines[o - 1]])[1].split(',')[0]
                             .strip())
                last = g[-1][0]
                if last + 5 >= len(ilines):
                    run_bad.append('%s: the run ending at line %d is truncated'
                                   % (k, ilines[last] + 1))
                    continue
                keep = ilines[last + 1:last + 6]
                mn = [insn(on_lines[q])[0] for q in keep]
                if mn[:3] != ['LDR', 'CMP', 'BNE']:
                    run_bad.append('%s: the kept layer after line %d is %s'
                                   % (k, ilines[last] + 1, mn[:3]))
                    continue
                regs.add(insn(on_lines[keep[1]])[1].split(',')[0].strip())
                if len(regs) != 1:
                    run_bad.append('%s: compared registers differ inside a run'
                                   % k)
                if insn(on_lines[keep[3]])[0] not in ('MOV', 'MOVW') or \
                        not is_mov_imm(on_lines[keep[3]]):
                    run_bad.append('%s: the kept layer does not end in '
                                   'MOV rD, #v' % k)
                    continue
                if mn[4] != 'B':
                    run_bad.append('%s: the kept layer does not end in B' % k)
                    continue
                between = '\n'.join(on_lines[keep[2] + 1:keep[3]])
                if (lab + ':') not in between:
                    run_bad.append('%s: %s does not sit in front of the kept '
                                   'MOV' % (k, lab))
                    continue
                if last + 6 < len(ilines) and \
                        insn(on_lines[ilines[last + 6]])[0] == 'BEQ' and \
                        insn(on_lines[ilines[last + 6]])[1].strip() == lab:
                    run_bad.append('%s: the kept layer was folded too' % k)
            defs = [ln for ln in on_lines if CF_LABEL.match(ln)]
            if len(defs) != len(set(defs)):
                lab_bad.append('%s: duplicate label definition' % k)
            if len(defs) != len(groups):
                lab_bad.append('%s: %d labels for %d runs'
                               % (k, len(defs), len(groups)))
            used = collections.Counter(lab for g in groups for _, lab in g)
            defined = collections.Counter(ln.strip().rstrip(':') for ln in defs)
            if set(used) != set(defined):
                lab_bad.append('%s: labels used %d, defined %d'
                               % (k, len(used), len(defined)))
            if any(defined[lab] != 1 for lab in defined):
                lab_bad.append('%s: a label is defined more than once' % k)
        check(not run_bad, 'every run is re-proved from the folded text '
                           '(each replaced layer reads LDR/CMP/BEQ on the same '
                           'registers, the kept layer still reads LDR/CMP/BNE '
                           'and ends in MOV/B, and the generated label sits '
                           'exactly in front of it)',
              '; '.join(run_bad[:3]) or '%d runs' % runs_total)
        check(runs_total == WANT_RUNS, 'the corpus contains exactly %d runs'
              % WANT_RUNS, '%d' % runs_total)
        check(dict(sorted(sizes.items())) == dict(sorted(
            WANT_RUN_SIZES.items())),
              'the run sizes are pinned', '%s' % dict(sorted(sizes.items())))
        check(not lab_bad, 'every generated label is defined once and is '
                           'referenced by exactly its run size minus one',
              '; '.join(lab_bad[:3]) or '%d labels, %d references'
              % (WANT_LABELS, refs_total))

        # --- 4. it declines when it must ----------------------------------
        census = collections.Counter()
        touched_layers = []
        for k in sorted(off):
            t = cf_oracle.Text(off[k])
            on_lines = set(on[k].splitlines())
            for lay in cf_oracle.layers(t):
                why = cf_oracle.explain(t, lay,
                                        t.layer(t.nxt(lay['b']))) or 'extend'
                census[why] += 1
                if why == 'extend':
                    continue
                if t.lines[lay['br']] not in on_lines:
                    touched_layers.append('%s:%d' % (k, lay['br'] + 1))
        print('[note] layer census %s (total %d)'
              % (dict(sorted(census.items())), sum(census.values())))
        check(sum(census.values()) == WANT_LAYERS,
              'the corpus holds exactly %d layers' % WANT_LAYERS,
              '%d' % sum(census.values()))
        check(set(census) <= set(WANT_CENSUS),
              'every refusal has a re-derivable reason (no unknown reason)',
              '%s' % dict(sorted(census.items())))
        check(all(census.get(reason, 0) == want
                  for reason, want in WANT_CENSUS.items()),
              'the refusal reasons are pinned',
              '; '.join('%s %d/%d' % (r, census.get(r, 0), w)
                        for r, w in sorted(WANT_CENSUS.items())))
        check(not touched_layers,
              'every layer the rule refuses is still in the text unscathed',
              '; '.join(touched_layers[:3]) or 'all refused layers intact')

        # a chain with the layer shape but four different values
        mn_src = os.path.join(work, 'mustnot.c')
        with open(mn_src, 'w', newline='\n', encoding='utf-8') as fh:
            fh.write(STARTUP + MUSTNOT)
        mn_txt = {}
        for tag, fl in (('off', []), ('on', FLAG)):
            txt, err = build_asm(arkcc, work, mn_src, fl, 'mn_' + tag)
            if err:
                check(False, 'the must-not fixture compiles', err[:120])
                mn_txt = {}
                break
            mn_txt[tag] = txt
        if mn_txt:
            mt = cf_oracle.Text(mn_txt['off'])
            n_layers = len(cf_oracle.layers(mt))
            check(n_layers >= 4,
                  'the must-not fixture really contains the layer shape',
                  '%d layers' % n_layers)
            check(not cf_oracle.runs(mt),
                  'no run forms when the four layers carry four values',
                  '%d run(s)' % len(cf_oracle.runs(mt)))
            check(mn_txt['on'] == mn_txt['off'],
                  'the must-not fixture comes out byte-identical in both arms',
                  '%d bytes' % len(mn_txt['off']))

        # --- 5. the answer does not change --------------------------------
        if not HAVE_UNICORN:
            skip('the two arms agree when the fixture is executed',
                 'python package unicorn missing')
        else:
            fx_src = os.path.join(work, 's17_fixture.c')
            with open(fx_src, 'w', newline='\n', encoding='utf-8') as fh:
                fh.write(STARTUP + FIXTURE)
            vals, snaps, failed = {}, {}, []
            fx_runs = None
            for tag, fl in (('off', []), ('on', FLAG)):
                txt, te = build_asm(arkcc, work, fx_src, fl, 'fx_' + tag)
                img, ie = build_image(arkcc, work, fx_src, fl, 'fx_' + tag)
                if te or ie:
                    failed.append('%s: %s' % (tag, (te or ie)[:100]))
                    continue
                if tag == 'off':
                    fx_runs = [len(r) for r in
                               cf_oracle.runs(cf_oracle.Text(txt))]
                st, val, snap, det = run_image(img)
                if st != 'returned':
                    failed.append('%s arm did not return (%s %s)'
                                  % (tag, st, det))
                    continue
                vals[tag], snaps[tag] = val, snap
            if failed:
                check(False, 'the two arms execute the fixture',
                      '; '.join(failed[:2]))
            else:
                want = expected_value(FIXTURE_FLAG, FIXTURE_DIST)
                check(fx_runs is not None and max(fx_runs) >= 4,
                      'the executed fixture really carries a four-layer run',
                      'runs %s' % fx_runs)
                check(vals['off'] == want and vals['on'] == want,
                      'both arms return the value the C source says (%d)'
                      % want,
                      'off=%d on=%d' % (vals['off'], vals['on']))
                check(snaps['off'] == snaps['on'],
                      'both arms leave the same RAM snapshot',
                      '%d bytes each' % len(snaps['off']))
                neg_src = os.path.join(work, 's17_fixture_bad.c')
                body = FIXTURE
                if SABOTAGE[0] not in body:
                    check(False, 'the sabotage anchor is present', SABOTAGE[0])
                else:
                    body = body.replace(SABOTAGE[0], SABOTAGE[1], 1)
                    with open(neg_src, 'w', newline='\n',
                              encoding='utf-8') as fh:
                        fh.write(STARTUP + body)
                    img, ie = build_image(arkcc, work, neg_src, FLAG,
                                          'fx_neg')
                    if ie:
                        check(False, 'the sabotaged fixture builds', ie[:100])
                    else:
                        st, val, snap, det = run_image(img)
                        check(st == 'returned' and val != vals['on'],
                              'a fixture whose first layer loses its value '
                              'returns a different value (the harness sees a '
                              'lost assignment)',
                              '%s vs %s' % (val, vals['on']))

        # --- 6. cropped out, refused --------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_CHAINFOLD=0'],
                                   'arkcc_nocf')
        if trimmed is None:
            skip('a cropped build refuses the switch', why)
        else:
            real = os.path.join(ROOT, 'examples/ark_test/Drivers',
                                'STM32F4xx_HAL_Driver/Src', TU_DMA)
            inc = []
            for d in INC_DIRS:
                inc += ['-I', d]
            rc, log = run([trimmed, '-S'] + ASM_ARM + COMMON +
                          ['-O2'] + inc + [real, '-o', 't.s', '-fopt-chainfold'],
                          work)
            check(rc != 0 and 'C3900U' in log and '-fopt-chainfold' in log,
                  'the cropped build refuses -fopt-chainfold by name',
                  'rc=%d' % rc)
            rc2, log2 = run([trimmed, '-S'] + ASM_ARM + COMMON + ['-O2'] +
                            inc + [real, '-o', 't2.s'] + BASE, work)
            rc3, log3 = run([arkcc, '-S'] + ASM_ARM + COMMON + ['-O2'] +
                            inc + [real, '-o', 't3.s'] + BASE, work)
            if rc2 != 0 or rc3 != 0:
                check(False, 'the cropped build still compiles the fixture',
                      (log2 or log3).strip().splitlines()[:1])
            else:
                check(read_text(os.path.join(work, 't2.s')) ==
                      read_text(os.path.join(work, 't3.s')),
                      'the cropped build writes the same text as the full '
                      'build when the switch is absent')
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())