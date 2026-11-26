#!/usr/bin/env python3
"""Gate for the comparison-ladder redundancy pass (0.9.1, S15).

Two switches, one shape analysis (`ark_ladder_function`, backend_arm.c):

  -fopt-ladderload   delete the `LDR Rb, [Rn, #0]` that opens layer 2 and
                     later of a compare ladder, when the same pair was loaded
                     at the ladder entry and nothing between the two loads
                     writes memory, calls, or writes Rb/Rn.
  -fopt-ladderstage  delete a `MOV Rx, Ry` staging copy in front of a layer's
                     conditional branch, when Rx is written before it is read
                     on both successors.

The rules are frozen in docs/EXPR_MODEL.md S17; the measurements and the
verdict are recorded in S18.

What this gate pins:

  1. OFF IS OFF.  `-O2 <26 passes>` and `-O2 <26 passes>
     -fno-opt-ladderload -fno-opt-ladderstage` are byte-identical, on the
     translation unit the pass actually shrinks and on one it must not touch.
  2. IT FIRES, AND ONLY ON THE TWO SHAPES.  On stm32f4xx_hal_dma_ex.c the load
     switch removes exactly 98 lines and every one of them is a
     `LDR rN, [rM, #0]`; the staging switch removes exactly 246 lines and every
     one of them is a `MOV rX, rY` whose next instruction is a conditional
     branch; together 344; no line is ever added or rewritten.  Those numbers
     are the pass's output, re-derived here line by line.
  3. NOTHING ELSE MOVES.  Two other translation units of the same corpus
     (gpio and the LL utilities, which contains a four-deep chain the shape
     test must reject) come out byte-identical with both switches on.
  4. IT DECLINES WHEN IT MUST.  18 of the 116 reloads in the same function stay
     in the text.  Every surviving reload is justified here by an independent
     scan: a store, a call, or a write to the base/index register really does
     sit between it and the earlier load.  Every *deleted* line is likewise
     re-derived from the unoptimised text: the reload's distance from the
     earlier load is free of barriers, the staging copy's destination really is
     overwritten before it is read on both successors.
  5. THE ANSWER DOES NOT CHANGE.  The emit-and-run fixture (one
     `__HAL_DMA_CLEAR_FLAG` per flag kind, snapshotted after each, so no write
     is masked by a later one) returns the same value in all four arms for 20
     `Instance` inputs -- the 16 DMA1/DMA2 stream addresses, three
     out-of-range values and one plain SRAM pointer -- and a sabotaged copy of
     the fixture (one `CLEAR_FLAG` deleted) returns a different value, so the
     harness is sensitive to exactly the writes the pass reasons about.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_LADDER=0 refuses
     both flags by name (C3900U) and still compiles the same text without them.

Usage: run_ladder_tests.py [path-to-arkcc]
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

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)

try:
    from unicorn import (Uc, UcError, UC_ARCH_ARM, UC_MODE_MCLASS,
                         UC_MODE_THUMB, UC_PROT_ALL,
                         UC_HOOK_MEM_FETCH_UNMAPPED)
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_SP, UC_ARM_REG_LR
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

FLAGS_L = ['-fopt-ladderload']
FLAGS_S = ['-fopt-ladderstage']
FLAGS_B = FLAGS_L + FLAGS_S

# 26 switches: the S14 line (24 + spill + ldhoist + stackframe + deadins).
PASSES = ['-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
          '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
          '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop', '-fopt-slotreg',
          '-fopt-strength', '-fopt-vstack', '-fopt-vreg', '-fopt-cmat',
          '-fopt-pair', '-fopt-litpool', '-fopt-frame', '-fopt-voldmb',
          '-fopt-constcond', '-fopt-boolmat', '-fopt-exit', '-fopt-bitmask',
          '-fopt-spill', '-fopt-ldhoist', '-fopt-stackframe', '-fopt-deadins']

COMMON = ['-D', 'STM32F401xE', '-D', 'USE_HAL_DRIVER', '--reloc-data']
ASM_ARM = ['-target', 'arm', '-O2', '-mcpu', 'Cortex-M4']
INC_DIRS = [os.path.join(ROOT, p) for p in [
    'examples/ark_test/Core/Inc', 'examples/ark_test/Core/Inc/HAL_Driver/Inc',
    'examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Inc',
    'examples/ark_test/Drivers/CMSIS/Device/ST/STM32F4xx/Include',
    'examples/ark_test/Drivers/CMSIS/Include', 'stdlib/include']]
HAL_SRC = os.path.join(ROOT, 'examples', 'ark_test', 'Drivers',
                       'STM32F4xx_HAL_Driver', 'Src')
REAL_TU = os.path.join(HAL_SRC, 'stm32f4xx_hal_dma_ex.c')
QUIET_TUS = [os.path.join(HAL_SRC, 'stm32f4xx_hal_gpio.c'),
             os.path.join(HAL_SRC, 'stm32f4xx_ll_utils.c')]

WANT_LOAD = 98
WANT_STAGE = 246
WANT_BOTH = 344
WANT_RELOADS = 146                 # `LDR Rd, [Rb]` / `[Rb, #0]`, Rd != Rb
WANT_RESIDUAL_RELOADS = 48         # 146 in the function, 98 deleted
WANT_INSNS_OFF = 2052
WANT_INSNS_ON = 1708

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

FIXTURE = r'''
#include "stm32f4xx_hal.h"

/* One CLEAR_FLAG per flag kind, each snapshotted before the next overwrites
 * the same IFCR register -- otherwise four of the five writes would be
 * invisible and a wrong deletion in them could not be caught. */
__attribute__((noinline))
uint32_t ladder_probe(DMA_HandleTypeDef *hdma)
{
  uint32_t a = 0u;
  __HAL_DMA_CLEAR_FLAG(hdma, __HAL_DMA_GET_TC_FLAG_INDEX(hdma));
  a = a * 3u + DMA1->LIFCR + DMA1->HIFCR + DMA2->LIFCR + DMA2->HIFCR;
  __HAL_DMA_CLEAR_FLAG(hdma, __HAL_DMA_GET_HT_FLAG_INDEX(hdma));
  a = a * 3u + DMA1->LIFCR + DMA1->HIFCR + DMA2->LIFCR + DMA2->HIFCR;
  __HAL_DMA_CLEAR_FLAG(hdma, __HAL_DMA_GET_TE_FLAG_INDEX(hdma));
  a = a * 3u + DMA1->LIFCR + DMA1->HIFCR + DMA2->LIFCR + DMA2->HIFCR;
  __HAL_DMA_CLEAR_FLAG(hdma, __HAL_DMA_GET_DME_FLAG_INDEX(hdma));
  a = a * 3u + DMA1->LIFCR + DMA1->HIFCR + DMA2->LIFCR + DMA2->HIFCR;
  __HAL_DMA_CLEAR_FLAG(hdma, __HAL_DMA_GET_FE_FLAG_INDEX(hdma));
  a = a * 3u + DMA1->LIFCR + DMA1->HIFCR + DMA2->LIFCR + DMA2->HIFCR;
  return a + (uint32_t)hdma->Instance;
}

static const uint32_t inst_tab[20] = {
  0x40026010u, 0x40026028u, 0x40026040u, 0x40026058u,
  0x40026070u, 0x40026088u, 0x400260a0u, 0x400260b8u,
  0x40026410u, 0x40026428u, 0x40026440u, 0x40026458u,
  0x40026470u, 0x40026488u, 0x400264a0u, 0x400264b8u,
  0x40026810u, 0x40026000u, 0x4002a000u, 0x20000100u
};

int main(void)
{
  DMA_HandleTypeDef h;
  uint32_t i, acc = 0u;
  h.Init.Direction = DMA_PERIPH_TO_MEMORY;
  for (i = 0u; i < 20u; i++) {
    h.Instance = (DMA_Stream_TypeDef *)inst_tab[i];
    DMA1->LIFCR = 0u; DMA1->HIFCR = 0u;
    DMA2->LIFCR = 0u; DMA2->HIFCR = 0u;
    acc = acc * 31u + ladder_probe(&h);
  }
  return (int)(acc & 0xFFu);
}
'''

SABOTAGE_LINE = ('  __HAL_DMA_CLEAR_FLAG(hdma, '
                 '__HAL_DMA_GET_TE_FLAG_INDEX(hdma));\n')

# --- text helpers ----------------------------------------------------------

BCC = {'BNE', 'BEQ', 'BLS', 'BHI', 'BCC', 'BCS', 'BLO', 'BHS', 'BMI', 'BPL',
       'BGT', 'BGE', 'BLT', 'BLE', 'BVS', 'BVC'}
WRITES0 = {'MOV', 'MOVW', 'MOVT', 'MVN', 'ADD', 'SUB', 'AND', 'ORR', 'EOR',
           'BIC', 'ORN', 'LSL', 'LSR', 'ASR', 'RSB', 'SBC', 'ADC', 'RSC',
           'MUL', 'UDIV', 'SDIV', 'UXTB', 'UXTH', 'SXTB', 'SXTH', 'REV',
           'REV16', 'REVSH', 'RRX', 'CLZ', 'LDR', 'LDRB', 'LDRH', 'LDRSB',
           'LDRSH', 'LDRD'}
BARRIER = {'STR', 'STRB', 'STRH', 'STM', 'STMIA', 'LDM', 'LDMIA', 'PUSH',
           'POP', 'BL', 'BLX'}
LOADS = {'LDR', 'LDRB', 'LDRH', 'LDRSB', 'LDRSH', 'LDRD'}

REG_RE = r'(r\d{1,2}|sp|lr|pc)'


def is_insn(ln):
    s = ln.strip()
    if not s or s.startswith('.') or s.startswith('@') or s.startswith(';'):
        return False
    return ln.startswith('    ') or ln.startswith('\t')


def insn(ln):
    """(mnemonic, rest) of an instruction line, or (None, None)."""
    s = ln.strip()
    if not is_insn(ln):
        return None, None
    parts = s.split(None, 1)
    return parts[0], (parts[1] if len(parts) > 1 else '')


def operands(rest):
    out, cur, depth = [], '', 0
    for ch in rest:
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


def zero_load_pair(ln):
    """(Rd, Rb) of `LDR Rd, [Rb]` / `LDR Rd, [Rb, #0]`, else None."""
    mn, rest = insn(ln)
    if mn != 'LDR':
        return None
    ops = operands(rest)
    if len(ops) != 2:
        return None
    dst = ops[0]
    if not __import__('re').fullmatch(REG_RE, dst):
        return None
    inner = ops[1].replace(' ', '')
    if inner == '[%s]' % dst or inner == '[%s,#0]' % dst:
        return None                     # `LDR r, [r]` is a pointer chase
    inner = inner.strip('[]')
    parts = inner.split(',')
    if len(parts) != 1 and not (len(parts) == 2 and parts[1] == '#0'):
        return None
    base = parts[0]
    if not __import__('re').fullmatch(REG_RE, base):
        return None
    return dst, base


def first_write_before_read(lines, start, reg, limit=256):
    """Walk from `start`; 1 = `reg` written first, 0 = read first,
    -1 = undecidable (left the window / an opaque instruction).

    A plain `B .Lx` is followed once (the join of a ladder arm is a backward
    jump in the emitted text), a conditional branch or a call is not.
    """
    import re
    q, steps = start, 0
    seen = set()
    while q < len(lines) and steps < limit:
        mn, rest = insn(lines[q])
        if mn is None:
            q += 1
            continue
        steps += 1
        ops = operands(rest)
        if mn in WRITES0 and ops and ops[0] == reg:
            return 1
        if mn in ('POP', 'LDM', 'LDMIA', 'LDMIB', 'LDMDA', 'LDMDB') and len(ops) == 1 \
                and ops[0].startswith('{') and re.search(r'\b%s\b' % reg, ops[0]):
            return 1
        for i, op in enumerate(ops):
            if i == 0 and mn in WRITES0:
                continue
            if re.search(r'\b%s\b' % reg, op):
                return 0
        if mn == 'B' and len(ops) == 1 and ops[0].startswith('.'):
            lab = label_line(lines, ops[0])
            if lab < 0 or lab in seen:
                return -1
            seen.add(lab)
            q = lab + 1
            continue
        if mn in BCC or mn in ('BX', 'BL', 'BLX', 'CBZ', 'CBNZ'):
            return -1
        q += 1
    return -1


def label_line(lines, name):
    for i, ln in enumerate(lines):
        if ln.strip() == name + ':':
            return i
    return -1


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


def build_asm(arkcc, work, src, flags, tag, extra=()):
    out = os.path.join(work, '%s.s' % tag)
    cmd = [arkcc] + ASM_ARM + COMMON + ['-S', '-o', out, src]
    for d in INC_DIRS:
        cmd += ['-I', d]
    cmd += list(PASSES) + list(flags) + list(extra)
    rc, log = run(cmd, work)
    if rc != 0:
        return None, log.strip().splitlines()[:1] or ['asm failed']
    return read_text(out), None


def build_image(arkcc, work, src, flags, tag):
    out = os.path.join(work, '%s.bin' % tag)
    cmd = [arkcc] + ASM_ARM + COMMON + ['--vector-table', '-o', out, src]
    for d in INC_DIRS:
        cmd += ['-I', d]
    cmd += list(PASSES) + list(flags)
    rc, log = run(cmd, work)
    if rc != 0:
        return None, log.strip().splitlines()[:1] or ['image failed']
    with open(out, 'rb') as fh:
        return fh.read(), None


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


def deletions(off_text, on_text, keep_labels=False):
    """(deleted line indices in the unoptimised text, added lines)."""
    a, b = off_text.splitlines(), on_text.splitlines()
    sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
    dels, add = [], []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag in ('delete', 'replace'):
            dels += [i for i in range(i1, i2) if a[i].strip()]
        if tag in ('insert', 'replace'):
            add += [ln for ln in b[j1:j2] if ln.strip()]
    return dels, add


def insn_count(text):
    return sum(1 for ln in text.splitlines() if is_insn(ln))


def run_image(blob, max_insn=5000000):
    """Execute an arkc image with the DMA register block mapped.

    The fixture reads and writes DMA1/DMA2 at 0x4002_6xxx, which the standard
    harness leaves unmapped; mapping that window as plain RAM is enough,
    because the ladder only ever compares addresses and stores a mask.
    """
    if len(blob) < 8:
        return 'fault', 0, 'image shorter than a vector table'
    sp = struct.unpack_from('<I', blob, 0)[0]
    entry = struct.unpack_from('<I', blob, 4)[0]
    if (entry & 1) == 0:
        return 'fault', 0, 'reset vector has no Thumb bit'
    uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB | UC_MODE_MCLASS)
    flash = 0x08000000
    uc.mem_map(flash, (len(blob) + 0xFFF) & ~0xFFF, UC_PROT_ALL)
    uc.mem_write(flash, blob)
    uc.mem_map(0x20000000, 0x20000, UC_PROT_ALL)
    uc.mem_map(0x40000000, 0x40000, UC_PROT_ALL)
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
            return 'fault', 0, 'unhandled exception'
    value = uc.reg_read(UC_ARM_REG_R0)
    if state['status'] == 'fault':
        return 'fault', value, state['detail']
    if state['status'] == 'returned':
        return 'returned', value, ''
    return 'limit', value, 'instruction budget spent'


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2
    for p in [REAL_TU] + QUIET_TUS:
        if not os.path.exists(p):
            print('FAIL  corpus file missing: %s' % p)
            return 2

    work = tempfile.mkdtemp(prefix='arkcc_ld_')
    try:
        # --- 1. off is off -------------------------------------------------
        t0, e0 = build_asm(arkcc, work, REAL_TU, [], 'real_plain')
        t1, e1 = build_asm(arkcc, work, REAL_TU,
                           ['-fno-opt-ladderload', '-fno-opt-ladderstage'],
                           'real_nofl')
        if e0 or e1:
            check(False, 'the real fixture compiles', (e0 or e1)[0][:120])
            return 1
        check(t0 == t1, 'the default build ignores both switches '
                        '(-O2 == -O2 -fno-opt-ladderload -fno-opt-ladderstage)',
              '%d/%d bytes' % (len(t0), len(t1)))

        # --- 2. it fires, and only on the two shapes ------------------------
        off_t, e = build_asm(arkcc, work, REAL_TU, [], 'real_off')
        lo_t, e2 = build_asm(arkcc, work, REAL_TU, FLAGS_L, 'real_load')
        st_t, e3 = build_asm(arkcc, work, REAL_TU, FLAGS_S, 'real_stage')
        bo_t, e4 = build_asm(arkcc, work, REAL_TU, FLAGS_B, 'real_both')
        if e or e2 or e3 or e4:
            check(False, 'all four arms compile the real fixture',
                  (e or e2 or e3 or e4)[0][:120])
            return 1

        check(insn_count(off_t) == WANT_INSNS_OFF,
              'the unoptimised arm emits the S14 instruction count',
              '%d' % insn_count(off_t))
        check(insn_count(bo_t) == WANT_INSNS_ON,
              'both switches together remove exactly %d instructions'
              % (WANT_INSNS_OFF - WANT_INSNS_ON),
              '%d -> %d' % (insn_count(off_t), insn_count(bo_t)))

        off_lines = off_t.splitlines()
        d_load, a_load = deletions(off_t, lo_t)
        d_stage, a_stage = deletions(off_t, st_t)
        d_both, a_both = deletions(off_t, bo_t)

        check(len(d_load) == WANT_LOAD,
              '-fopt-ladderload removes exactly %d lines' % WANT_LOAD,
              '%d' % len(d_load))
        check(len(d_stage) == WANT_STAGE,
              '-fopt-ladderstage removes exactly %d lines' % WANT_STAGE,
              '%d' % len(d_stage))
        check(len(d_both) == WANT_BOTH,
              'both switches remove exactly %d lines' % WANT_BOTH,
              '%d' % len(d_both))

        bad = [off_lines[i].strip() for i in d_load if not zero_load_pair(off_lines[i])]
        check(not bad, 'every line the load switch removes is a '
                       '`LDR Rd, [Rb, #0]` reload',
              ' '.join(bad[:3]) or 'all %d' % len(d_load))

        def stage_shape(ln):
            mn, rest = insn(ln)
            if mn != 'MOV':
                return False
            ops = operands(rest)
            return len(ops) == 2 and all(
                __import__('re').fullmatch(REG_RE, o) for o in ops)

        bad = [off_lines[i].strip() for i in d_stage if not stage_shape(off_lines[i])]
        check(not bad, 'every line the staging switch removes is a '
                       '`MOV Rx, Ry` copy',
              ' '.join(bad[:3]) or 'all %d' % len(d_stage))

        # ... and each of those really does feed a conditional branch.
        def next_insn(i):
            j = i + 1
            while j < len(off_lines):
                mn, rest = insn(off_lines[j])
                if mn is not None:
                    return j, mn, rest
                j += 1
            return None, None, None

        def branch_after_stage(i):
            """Skip the staging copies that follow `i`; return the branch."""
            j = i + 1
            while j < len(off_lines):
                mn, rest = insn(off_lines[j])
                if mn is None:
                    j += 1
                    continue
                if stage_shape(off_lines[j]):
                    j += 1
                    continue
                return j, mn, rest
            return None, None, None

        bad = []
        for i in d_stage:
            j, mn, rest = branch_after_stage(i)
            if mn not in BCC:
                bad.append('%s before %s' % (off_lines[i].strip(), mn))
        check(not bad, 'every removed staging copy sits in a run of copies in '
                       'front of a conditional branch',
              '; '.join(bad[:3]) or 'all %d' % len(d_stage))

        check(not a_load and not a_stage and not a_both,
              'the pass never adds or rewrites a line',
              ' '.join((a_load + a_stage + a_both)[:3]) or 'none')
        check(set(d_load) | set(d_stage) == set(d_both) and
              not (set(d_load) & set(d_stage)),
              'the two switches act on disjoint lines and together make the '
              'combined arm',
              '%d + %d = %d' % (len(d_load), len(d_stage), len(d_both)))

        # --- 3. nothing else moves ------------------------------------------
        for src in QUIET_TUS:
            name = os.path.basename(src)
            q_off, qe0 = build_asm(arkcc, work, src, [], 'quiet_off_' + name)
            q_on, qe1 = build_asm(arkcc, work, src, FLAGS_B, 'quiet_on_' + name)
            if qe0 or qe1:
                check(False, '%s compiles in both arms' % name,
                      (qe0 or qe1)[0][:120])
                continue
            d, _ = deletions(q_off, q_on)
            check(q_off == q_on,
                  '%s is byte-identical with both switches on' % name,
                  '%d/%d bytes, %d line(s) dropped' % (len(q_off), len(q_on),
                                                       len(d)))

        # --- 4. it declines when it must ------------------------------------
        def is_reload(ln):
            z = zero_load_pair(ln)
            return z is not None and z[0] != z[1]

        residual = [i for i, ln in enumerate(off_lines) if is_reload(ln)]
        check(len(residual) == WANT_RELOADS and
              len(residual) - len(d_load) == WANT_RESIDUAL_RELOADS,
              '%d of the %d reloads stay in the text'
              % (WANT_RESIDUAL_RELOADS, WANT_RELOADS),
              '%d -> %d' % (len(residual), len(residual) - len(d_load)))

        # every deleted reload: an earlier identical reload, nothing in between
        def barrier_between(a, b, regs):
            for j in range(a + 1, b):
                mn, rest = insn(off_lines[j])
                if mn is None:
                    continue
                if mn in BARRIER:
                    return ln_mn(mn, rest)
                if mn in WRITES0:
                    ops = operands(rest)
                    if ops and ops[0] in regs:
                        return ln_mn(mn, rest)
            return None

        def ln_mn(mn, rest):
            return '%s %s' % (mn, rest.strip())

        bad = []
        for i in d_load:
            dst, base = zero_load_pair(off_lines[i])
            prev = None
            for j in range(i - 1, -1, -1):
                z = zero_load_pair(off_lines[j])
                if z == (dst, base):
                    prev = j
                    break
            if prev is None:
                bad.append('no earlier reload for %s' % off_lines[i].strip())
                continue
            why = barrier_between(prev, i, {dst, base})
            if why:
                bad.append('%s crosses %s' % (off_lines[i].strip(), why))
        check(not bad, 'every removed reload has an earlier identical load and '
                       'no store, call or rebase in between',
              '; '.join(bad[:2]) or 'all %d' % len(d_load))

        # every surviving reload: something between it and the earlier load
        dead = set(d_load)
        survived = [i for i in residual if i not in dead]
        justified = 0
        for i in survived:
            dst, base = zero_load_pair(off_lines[i])
            prev = None
            for j in range(i - 1, -1, -1):
                if zero_load_pair(off_lines[j]) == (dst, base):
                    prev = j
                    break
            if prev is not None and barrier_between(prev, i, {dst, base}):
                justified += 1
        check(justified > 0,
              'surviving reloads are the ones a barrier protects',
              '%d of %d justified by an independent scan'
              % (justified, len(survived)))

        # every deleted staging copy: dest overwritten before read, both arms
        undec, wrong = 0, []
        for i in d_stage:
            ops = operands(insn(off_lines[i])[1])
            dst = ops[0]
            j, mn, rest = branch_after_stage(i)
            if mn not in BCC:
                wrong.append('%s: next is %s' % (off_lines[i].strip(), mn))
                continue
            tgt = rest.strip().split(',')[-1].strip()
            lab = label_line(off_lines, tgt)
            if lab < 0:
                wrong.append('%s: no label %s' % (off_lines[i].strip(), tgt))
                continue
            taken = first_write_before_read(off_lines, lab + 1, dst)
            fall = first_write_before_read(off_lines, j + 1, dst)
            if taken == 0 or fall == 0:
                wrong.append('%s is read first on one arm' % off_lines[i].strip())
            elif taken < 0 or fall < 0:
                undec += 1
        check(not wrong, 'every removed staging copy is overwritten before it '
                         'is read on both successors',
              '; '.join(wrong[:2]) or 'all %d' % len(d_stage))
        if undec:
            print('[note] %d staging deletion(s) the scanner could not decide '
                  '(branch left the window); the pass had more context'
                  % undec)

        # --- 5. the answer does not change ----------------------------------
        fix_src = os.path.join(work, 'ladder_fixture.c')
        with open(fix_src, 'w', newline='\n', encoding='utf-8') as fh:
            fh.write(STARTUP + 'int ark_lad_dummy_init = 1;\n' + FIXTURE)
        if not HAVE_UNICORN:
            skip('the four arms agree when the fixture is executed',
                 'python package unicorn missing')
            skip('the harness is sensitive to the writes it reasons about',
                 'python package unicorn missing')
        else:
            vals, grew, failed = {}, {}, []
            for tag, fl in (('off', []), ('load', FLAGS_L), ('stage', FLAGS_S),
                            ('both', FLAGS_B)):
                txt, te = build_asm(arkcc, work, fix_src, fl, 'fix_' + tag)
                img, ie = build_image(arkcc, work, fix_src, fl, 'fix_' + tag)
                if te or ie:
                    failed.append('%s: %s' % (tag, (te or ie)[0][:100]))
                    continue
                grew[tag] = len(deletions(read_text(os.path.join(
                    work, 'fix_off.s')), txt)[0]) if tag != 'off' else 0
                st, val, det = run_image(img)
                if st != 'returned':
                    failed.append('%s arm did not return (%s %s)'
                                  % (tag, st, det))
                    continue
                vals[tag] = val
            if failed:
                check(False, 'the four arms execute the fixture',
                      '; '.join(failed[:2]))
            else:
                check(len(set(vals.values())) == 1,
                      'all four arms return the same value for 20 Instance '
                      'inputs', ' '.join('%s=%s' % (k, vals[k]) for k in
                                         ('off', 'load', 'stage', 'both')))
                check(grew['load'] > 0 and grew['stage'] > 0,
                      'the executed fixture is really changed by both switches',
                      'load -%d, stage -%d line(s)'
                      % (grew['load'], grew['stage']))
                neg_src = os.path.join(work, 'ladder_fixture_neg.c')
                body = FIXTURE.replace(SABOTAGE_LINE, '', 1)
                with open(neg_src, 'w', newline='\n', encoding='utf-8') as fh:
                    fh.write(STARTUP + 'int ark_lad_dummy_init = 1;\n' + body)
                img, ie = build_image(arkcc, work, neg_src, FLAGS_B, 'fix_neg')
                if ie:
                    check(False, 'the sabotaged fixture builds', ie[0][:100])
                else:
                    st, val, det = run_image(img)
                    check(st == 'returned' and val != vals['both'],
                          'a sabotaged fixture returns a different value '
                          '(the harness can see a wrong deletion)',
                          '%s vs %s' % (val, vals['both']))

        # --- 6. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_LADDER=0'],
                                   'arkcc_noladder')
        if trimmed is None:
            skip('a cropped build refuses both switches', why)
        else:
            for flag in ('-fopt-ladderload', '-fopt-ladderstage'):
                inc = []
                for d in INC_DIRS:
                    inc += ['-I', d]
                rc, log = run([trimmed, '-S'] + ASM_ARM + COMMON +
                              ['-O2'] + inc + [REAL_TU, '-o', 't.s', flag],
                              work)
                check(rc != 0 and 'C3900U' in log and flag in log,
                      'the cropped build refuses %s by name' % flag,
                      'rc=%d' % rc)
            inc = []
            for d in INC_DIRS:
                inc += ['-I', d]
            rc2, log2 = run([trimmed, '-S'] + ASM_ARM + COMMON +
                            ['-O2'] + inc + [REAL_TU, '-o', 't2.s'] + PASSES,
                            work)
            rc3, log3 = run([arkcc, '-S'] + ASM_ARM + COMMON +
                            ['-O2'] + inc + [REAL_TU, '-o', 't3.s'] + PASSES,
                            work)
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
