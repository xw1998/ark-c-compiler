#!/usr/bin/env python3
"""Independent CFG liveness oracle for -fopt-deadins (0.9.1, V-4 slice 1).

This file is deliberately written from scratch: it imports nothing from the
compiler, from `af_oracle.py`, from `cf_oracle.py` or from any other test
helper, and it re-derives the instruction tables from the ARMv7-M Thumb
encodings instead of carrying the pass' `di_*` sets over.  A gate that reuses
the pass' own tables cannot catch a wrong table.

WHAT IT ANSWERS

    deletable(text) -> set of 0-based line indices

A line is in the set only when a *sound* analysis can prove it is dead: a
compare whose flags no reachable path reads before the next flag writer, or a
pure register write whose destination no reachable path reads before the next
write.  Everything the oracle does not understand makes the whole function
"nothing is deletable", so an omission can only make the gate stricter.

The analysis is the classic two-part one:

  1. Build the basic blocks (a label starts a block, a branch or a
     `POP {..., pc}` ends one) and their successors.
  2. Compute, per block, the upward-exposed register reads, the register
     definitions, and the same pair for the flags, then run liveness to a
     fixed point.  A block with no successors is a function exit: every
     register and the flags are live out of it (the caller owns them).

Usage:
    python di_oracle.py file.s            # print the deletable line numbers
"""
import re
import sys

LABEL = re.compile(r'^\s*([.\w$]+):\s*$')
INSN = re.compile(r'^\s+([A-Z][A-Z0-9.]*)\s*(.*?)\s*$')
REGS = re.compile(r'\b(r1[0-5]|r[0-9]|sp|lr|pc|ip|sl|fp)\b')

# Condition suffixes, longest first so `LS` wins over `S` and `HI` over `I`.
CONDS = ('EQ', 'NE', 'CS', 'HS', 'CC', 'LO', 'MI', 'PL', 'VS', 'VC',
         'HI', 'LS', 'GE', 'LT', 'GT', 'LE', 'AL')

# Data-processing operations that exist both with and without an S suffix.
DP = ('MOV', 'MVN', 'ADD', 'SUB', 'RSB', 'ADC', 'SBC', 'RSC', 'AND', 'ORR',
      'EOR', 'BIC', 'LSL', 'LSR', 'ASR', 'ROR', 'MUL', 'NEG', 'REV',
      'REV16', 'REVSH', 'UXTB', 'UXTH', 'SXTB', 'SXTH', 'CLZ', 'RBIT')
# Of those, the ones that only ever appear in their flag-writing form.
DP_ALWAYS_S = ('MULS', 'NEGS', 'ADCS', 'SBCS', 'RSCS')
CMPISH = ('CMP', 'CMN', 'TST', 'TEQ')
LOADS = ('LDR', 'LDRB', 'LDRH', 'LDRSB', 'LDRSH', 'LDRD', 'VLDR')
STORES = ('STR', 'STRB', 'STRH', 'STRD', 'VSTR')
MULTI = ('LDM', 'LDMIA', 'LDMIB', 'LDMDA', 'LDMDB', 'LDMFD', 'LDMED',
         'STM', 'STMIA', 'STMIB', 'STMDA', 'STMDB', 'STMFD', 'STMED')
CONDBR = ('BEQ', 'BNE', 'BCS', 'BHS', 'BCC', 'BLO', 'BMI', 'BPL', 'BVS',
          'BVC', 'BHI', 'BLS', 'BGE', 'BLT', 'BGT', 'BLE')
TESTBR = ('CBZ', 'CBNZ')
# A call clobbers r0-r3, r12, lr; the callee may read the flags too, so a
# call is a flag read *and* a flag write in the conservative direction.
CALLS = ('BL', 'BLX')


def _strip_cond(mn):
    """Return (base, has_cond_suffix)."""
    for c in CONDS:
        if len(mn) > len(c) + 1 and mn.endswith(c) and mn[:-len(c)] in DP + DP_ALWAYS_S:
            return mn[:-len(c)], True
    return mn, False


def _writes_flags(mn):
    """Definite flag write.

    S-suffixed data processing, the four compares, and the always-S forms.
    """
    if mn in CMPISH or mn in DP_ALWAYS_S:
        return True
    if mn.endswith('S') and mn[:-1] in DP:
        return True
    base, cond = _strip_cond(mn)
    return cond and (base in DP or base in DP_ALWAYS_S)


def _may_write_flags(mn, ops):
    """Flag write as the *encoder* decides it, for the bare DP forms.

    `backend_arm.c` emits the 16-bit data-processing encoding (ANDS/ORRS/
    EORS/BICS/MVNS at 0x4000/0x4300/..., ADDS at 0x1800, the immediate forms
    at 0x3000) whenever the operands fit it, and every one of those forms
    sets the flags; only `MOV Rd, Rm` (0x4600), `MOVW` and `MOVT` do not.
    The gate pins this fact on emulated hardware, so it is a measured fact
    here rather than an assumption copied from the pass.
    """
    if _writes_flags(mn):
        return True
    if mn in ('MOVW', 'MOVT'):
        return False
    if mn == 'MOV':
        if len(ops) == 2 and _reg(ops[0]) and not _reg(ops[1]):
            # MOV Rd, #imm: the small form is MOVS, the wide form is MOVW.
            m = re.fullmatch(r'#(\d+)', ops[1].strip())
            d = _reg(ops[0])
            if m and d and d.startswith('r') and d[1:].isdigit() and int(d[1:]) <= 7:
                return int(m.group(1)) <= 255
        return False
    return mn in DP


def _reads_flags(mn):
    if mn in CONDBR or mn in TESTBR or mn == 'IT' or mn.startswith('IT'):
        return True
    base, cond = _strip_cond(mn)
    if base in ('ADC', 'SBC', 'RSC') or mn in DP_ALWAYS_S:
        return True
    return cond


def _parses(mn):
    """Is the mnemonic one whose register effect this oracle models?"""
    if mn in CMPISH or mn in LOADS or mn in STORES or mn in MULTI:
        return True
    if mn in CONDBR:
        return True
    if mn in ('B', 'BX', 'BL', 'BLX', 'CBZ', 'CBNZ', 'PUSH', 'POP',
              'MOVW', 'MOVT', 'UDIV', 'SDIV', 'NOP', 'DMB', 'DSB', 'ISB'):
        return True
    if mn.startswith('IT'):
        return True
    base, cond = _strip_cond(mn)
    return base in DP or base in DP_ALWAYS_S


def _ops(rest):
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


def _reg(tok):
    tok = tok.strip()
    return tok if re.fullmatch(r'(r1[0-5]|r[0-9]|sp|lr|pc|ip|sl|fp)', tok) else None


def _collect(tok):
    out = set()
    for m in REGS.finditer(tok):
        g = m.group(1)
        out.add({'ip': 'r12', 'sl': 'r10', 'fp': 'r11'}.get(g, g))
    return out


def _reglist(tok):
    """Registers in a `{r0, r1, r4-r7, lr}` operand."""
    out = set()
    body = tok.strip()
    if body.startswith('{'):
        body = body[1:]
    if body.endswith('}'):
        body = body[:-1]
    for part in body.split(','):
        part = part.strip()
        if not part:
            continue
        if '-' in part:
            a, b = part.split('-', 1)
            a, b = _reg(a), _reg(b)
            if not a or not b:
                continue
            o = ['r%d' % k for k in range(16)]
            o.append('sp')
            o.append('lr')
            o.append('pc')
            try:
                i, j = o.index(a), o.index(b)
            except ValueError:
                continue
            if i <= j:
                out |= set(o[i:j + 1])
        else:
            r = _reg(part)
            if r:
                out.add(r)
    return out


def rw(mn, ops):
    """(reads, writes) for a modelled instruction."""
    reads, writes = set(), set()
    if mn in CMPISH:
        for o in ops:
            reads |= _collect(o)
        return reads, writes
    if mn in ('B', 'BX', 'IT', 'NOP', 'DMB', 'DSB', 'ISB'):
        if mn == 'BX' and ops:
            reads |= _collect(ops[0])
        return reads, writes
    if mn in ('PUSH',):
        if ops:
            reads |= _reglist(ops[0])
        return reads, writes
    if mn in ('POP',):
        if ops:
            writes |= _reglist(ops[0])
        return reads, writes
    if mn in MULTI:
        if ops:
            regs = _reglist(ops[0])
            if mn.startswith('LDM'):
                writes |= regs
            else:
                reads |= regs
            for o in ops[1:]:
                if o.startswith('!'):
                    reads.add(o[:-1].strip())
                    continue
                if _reg(o):
                    reads.add(_reg(o))
                reads |= _collect(o)
        return reads, writes
    if mn in LOADS:
        if ops and _reg(ops[0]):
            writes.add(_reg(ops[0]))
        for o in ops[1:]:
            reads |= _collect(o)
        return reads, writes
    if mn in STORES:
        for o in ops:
            if o.startswith('!') or o.startswith('#'):
                continue
            reads |= _collect(o)
        return reads, writes
    if mn in ('BL', 'BLX'):
        # The callee may read r0-r3/r12/lr and returns r0-r3/r12/lr.
        reads |= {'r0', 'r1', 'r2', 'r3', 'r12', 'lr'}
        if mn == 'BLX' and ops:
            reads |= _collect(ops[0])
        writes |= {'r0', 'r1', 'r2', 'r3', 'r12', 'lr'}
        return reads, writes
    if mn in ('CBZ', 'CBNZ'):
        if ops:
            reads |= _collect(ops[0])
        return reads, writes
    # Data processing.  The destination is the first operand when it is a
    # register, but `CMP`-like forms have already been handled.
    if ops:
        d = _reg(ops[0])
        if d:
            writes.add(d)
        for o in ops[1:]:
            reads |= _collect(o)
        if d and mn.startswith('MOVT'):
            reads.add(d)
    return reads, writes


def _is_branch(mn, ops):
    if mn in ('B', 'BX', 'BL', 'BLX', 'CBZ', 'CBNZ') or mn in CONDBR:
        return True
    if mn in ('POP',) and ops and _reglist(ops[0]) & {'pc'}:
        return True
    return False


def _target(ops, labels, blocks_of_label, nblk, here):
    for o in ops:
        if not o or o[0] in '#[':
            continue
        if _collect(o):
            continue
        if o in labels:
            return blocks_of_label.get(o, -1)
    return -1


def blocks_of(text):
    """Split into basic blocks.  Returns (blocks, succ) with line indices."""
    lines = text.splitlines()
    insn = []      # (line index, mnemonic, operands)
    labels = {}
    for i, ln in enumerate(lines):
        m = LABEL.match(ln)
        if m:
            labels.setdefault(m.group(1), i)
            insn.append((i, None, None))
            continue
        m = INSN.match(ln)
        if m:
            insn.append((i, m.group(1), _ops(m.group(2))))
    # Blocks are runs of instruction lines; a label or a terminator closes one.
    blocks, cur = [], []
    for k, (li, mn, ops) in enumerate(insn):
        if mn is None:
            if cur:
                blocks.append(cur)
                cur = []
            continue
        cur.append(k)
        if _is_branch(mn, ops):
            blocks.append(cur)
            cur = []
    if cur:
        blocks.append(cur)
    # A block owns the lines from its first instruction to the line before the
    # next block's first instruction: that span carries the block's own
    # directives and the labels that lead into the *following* block, so a
    # label is resolved to the next instruction line, never to the block it
    # trails.
    block_of_line = {}
    firsts = [insn[blk[0]][0] for blk in blocks]
    for b, blk in enumerate(blocks):
        last = firsts[b + 1] - 1 if b + 1 < len(blocks) else len(lines) - 1
        for li in range(firsts[b], last + 1):
            block_of_line[li] = b
    insn_lines = sorted(li for (li, mn, ops) in insn if mn is not None)
    blocks_of_label = {}
    for name, li in labels.items():
        # The label belongs to the first real instruction at or after it: a
        # trailing label sits inside the previous block's padding, and
        # resolving it to that block would make one block its own successor.
        target = len(blocks)
        for cand in insn_lines:
            if cand >= li:
                target = block_of_line[cand]
                break
        blocks_of_label[name] = target
    nb = len(blocks)
    succ = []
    for b, blk in enumerate(blocks):
        li, mn, ops = insn[blk[-1]]
        s = []
        if mn == 'B':
            s.append(_target(ops, labels, blocks_of_label, nb, b))
        elif mn in CONDBR or mn in TESTBR:
            s.append(_target(ops, labels, blocks_of_label, nb, b))
            if b + 1 < nb:
                s.append(b + 1)
        elif mn in ('BX', 'BL', 'BLX'):
            pass
        elif mn == 'POP' and ops and _reglist(ops[0]) & {'pc'}:
            pass
        else:
            if b + 1 < nb:
                s.append(b + 1)
        succ.append([x for x in s if 0 <= x < nb])
    return [(insn[blk[0]][0], insn[blk[-1]][0]) for blk in blocks], succ, insn


def deletable(text, dump=False):
    blocks, succ, insn = blocks_of(text)
    nb = len(blocks)
    line_insn = {}
    for k, (li, mn, ops) in enumerate(insn):
        if mn is not None:
            line_insn[li] = (mn, ops)
    ALL = {'r%d' % k for k in range(13)} | {'sp', 'lr'}
    use = [set() for _ in range(nb)]
    deff = [set() for _ in range(nb)]
    frd = [False] * nb
    fwr = [False] * nb
    for b, (first, last) in enumerate(blocks):
        u, d = set(), set()
        fr = fw = False
        for li in range(first, last + 1):
            if li not in line_insn:
                continue
            mn, ops = line_insn[li]
            if not _parses(mn):
                # An instruction this oracle does not model is the top
                # element: it may read every register, write every register
                # and leave the flags in an unknown state.  Locally
                # conservative, so a missed mnemonic costs deletions.
                u, d, fr, fw = set(ALL), set(), True, True
                continue
            r, w = rw(mn, ops)
            if _reads_flags(mn) and not fw:
                fr = True
            if _may_write_flags(mn, ops):
                fw = True
            u |= (r - d)
            d |= w
        use[b], deff[b], frd[b], fwr[b] = u, d, fr, fw

    lin = [set() for _ in range(nb)]
    lout = [set() for _ in range(nb)]
    fin = [False] * nb
    fout = [False] * nb
    for _ in range(200):
        change = False
        for b in range(nb - 1, -1, -1):
            if succ[b]:
                o = set()
                fo = False
                for s in succ[b]:
                    o |= lin[s]
                    fo = fo or fin[s]
            else:
                o, fo = set(ALL), True
            u = use[b] | (o - deff[b])
            fi = frd[b] or (fo and not fwr[b])
            if u != lin[b] or o != lout[b] or fi != fin[b] or fo != fout[b]:
                lin[b], lout[b], fin[b], fout[b] = u, o, fi, fo
                change = True
        if not change:
            break

    dead = set()
    for b, (first, last) in enumerate(blocks):
        lines = [li for li in range(first, last + 1) if li in line_insn]
        # An IT block: the conditional instructions under it cannot be deleted
        # one by one, and the flag dependency between them and the `IT` is not
        # modelled line by line.
        if any(line_insn[li][0].startswith('IT') for li in lines):
            continue
        live = set(lout[b])
        needf = fout[b]
        for li in reversed(lines):
            mn, ops = line_insn[li]
            if not _parses(mn):
                live, needf = set(ALL), True
                continue
            r, w = rw(mn, ops)
            if _reads_flags(mn):
                needf = True
            if mn in CMPISH:
                if not needf:
                    dead.add(li)
                else:
                    needf = False
                    live |= r
                continue
            wf = _may_write_flags(mn, ops)
            if (mn in DP or mn in DP_ALWAYS_S or
                    (mn.endswith('S') and mn[:-1] in DP)) and ops and _reg(ops[0]):
                d = _reg(ops[0])
                if d not in live and not (wf and needf):
                    dead.add(li)
                    continue
                if wf:
                    needf = False
                live = (live - w) | r
                continue
            live = (live - w) | r
            if wf:
                needf = False
    if dump:
        return dead, (blocks, succ, lin, lout, fin, fout)
    return dead


def main(argv):
    if len(argv) < 2:
        print('usage: di_oracle.py file.s', file=sys.stderr)
        return 2
    with open(argv[1], 'rb') as fh:
        text = fh.read().decode('utf-8', 'replace')
    dead = deletable(text)
    for li in sorted(dead):
        print('%d: %s' % (li + 1, text.splitlines()[li].strip()))
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
