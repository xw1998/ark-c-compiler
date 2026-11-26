#!/usr/bin/env python3
"""Independent re-implementation of the -fopt-addrfold rules (0.9.1, S20).

The compiler's pass lives in `lv_pass` / `ark_addrfold_function`
(backend_arm.c); this module shares no code and no constants with it.  It
reads the switch-off assembly text, re-derives the basic blocks and the
liveness on its own, and rewrites the text by the two rules alone, so the
gate can compare the compiler's switch-on text against a second opinion.

The rules, as frozen in docs/EXPR_MODEL.md section 30.3:

    A  ADD|SUB rA, rB, #k1
       ADD|SUB rC, rA, #k2      (rA dead)  ->  ADD|SUB rC, rB, #k1+-k2
    B  ADD      rA, rB, #k1     (k1 >= 0)
       LDR|STR* rD, [rA, #k2]   (k2 >= 0)  ->  LDR|STR* rD, [rB, #k1+k2]

What must hold, and why:

  * the two instructions are adjacent inside one basic block, neither under
    an IT and neither with a `!` write-back;
  * no register outside r0-r12 takes part;
  * `rA` is not live after the second instruction, so deleting the first one
    is invisible;
  * the rewritten instruction is no wider than the original -- a deleted
    16-bit ADD must not come back as a 32-bit access (see `alu_size` /
    `mem_size`, which mirror the internal assembler's immediate shapes);
  * rule A keeps |k1+k2| <= 255 and skips k1+k2 == 0; rule B keeps
    0 <= k1+k2 <= 4095 with both offsets non-negative;
  * no conditional-flag consumer inside the second instruction's own basic
    block can see it: flags are block-local in this code base, a reader
    reached before any writer refuses the fold, a conditional branch counts
    as a reader, and `CBZ`/`CBNZ` (which read a register, not the flags) only
    end the block.

Every operand is a plain non-negative decimal in this emitter, so anything
else -- a symbol, a hex constant, a shifted operand -- is simply not a
candidate.
"""
import re

_MN = re.compile(r'[A-Za-z]+')
_TOKEN = re.compile(r'[A-Za-z0-9_]+')
_RNUM = re.compile(r'r(\d+)\Z')
_IMM = re.compile(r'#(\d{1,5})\Z')
_MEM = re.compile(r'\[r(\d+)(?:, #(\d+))?\]\Z')

COND = set(['EQ', 'NE', 'CS', 'HS', 'CC', 'LO', 'MI', 'PL', 'VS', 'VC',
            'HI', 'LS', 'GE', 'LT', 'GT', 'LE', 'AL'])

MEM_MN = ('LDR', 'LDRB', 'LDRH', 'LDRSH', 'STR', 'STRB', 'STRH')

# --- text ---------------------------------------------------------------

def parse(s):
    """(mnemonic, [operands]) for one trimmed instruction line, or None.

    Letters for the mnemonic, one space, then operands split on commas that
    are not inside `[]` or `{}`.
    """
    m = _MN.match(s)
    if not m or m.end() >= len(s) or s[m.end()] != ' ':
        return None
    mn = m.group(0)
    rest = s[m.end() + 1:]
    ops, cur, depth = [], '', 0
    for ch in rest:
        if ch in '[{':
            depth += 1
        elif ch in ']}':
            depth -= 1
        if ch == ',' and depth == 0:
            ops.append(cur.strip())
            cur = ''
            continue
        cur += ch
    ops.append(cur.strip())
    return mn, ops[:4]

def rebuild(mn, ops):
    """One instruction line as the pass would write it."""
    return mn + ''.join((', ' if i else ' ') + o for i, o in enumerate(ops))

def reg(s):
    """The single register r0-r15 named by `s`, or None."""
    t = s.strip().lower()
    if t == 'sp':
        return 13
    if t == 'lr':
        return 14
    if t == 'pc':
        return 15
    m = _RNUM.match(t)
    if not m:
        return None
    v = int(m.group(1))
    return v if 0 <= v <= 15 else None

def regs_mask(s):
    """Every register named by `s` (r0-r15, sp, lr, pc), as a bit mask."""
    m = 0
    for tok in _TOKEN.findall(s):
        t = tok.lower()
        if t in ('sp', 'lr', 'pc'):
            m |= 1 << {'sp': 13, 'lr': 14, 'pc': 15}[t]
        else:
            g = _RNUM.match(t)
            if g:
                v = int(g.group(1))
                if 0 <= v <= 15:
                    m |= 1 << v
    return m

def imm(s):
    """`#<decimal, at most 5 digits>` -> value, else None."""
    m = _IMM.match(s)
    return int(m.group(1)) if m else None

# --- the machine's own conventions --------------------------------------

def branch_kind(mn):
    """0 none, 1 unconditional branch, 2 conditional branch, 3 call,
    4 BX/BLX r."""
    L = len(mn)
    if mn in ('CBZ', 'CBNZ'):
        return 2
    if not mn or mn[0] != 'B':
        return 0
    if L == 1:
        return 1
    if L == 2 and mn[1] == 'L':
        return 3
    if L == 2 and mn[1] == 'X':
        return 4
    if L == 3 and mn[1] == 'L' and mn[2] == 'X':
        return 3
    if L == 3:
        return 2 if mn[1:] in COND else 0
    return 0

def dest_only(mn):
    if mn.startswith('MOV'):
        return True
    return mn in ('MVN', 'NEG', 'UXTB', 'UXTH', 'SXTB', 'SXTH',
                  'REV', 'REV16', 'REVSH', 'RBIT', 'CLZ')

def rw(mn, ops):
    """(registers read, registers written) by one instruction."""
    r = w = 0
    if mn in ('BL', 'BLX'):
        r = 0xF
        for o in ops:
            r |= regs_mask(o)
        return r, 0xF | (1 << 12) | (1 << 14)
    if mn in ('B', 'BX'):
        for o in ops:
            r |= regs_mask(o)
        return r, 0
    if len(mn) == 3 and mn[0] == 'B':
        for o in ops:
            r |= regs_mask(o)
        return r, 0
    if mn in ('CBZ', 'CBNZ'):
        return regs_mask(ops[0]) if ops else 0, 0
    if mn in ('CMP', 'CMN', 'TST', 'TEQ'):
        for o in ops:
            r |= regs_mask(o)
        return r, 0
    if mn == 'PUSH' or mn.startswith('STM') or mn.startswith('STR') or \
            mn.startswith('VSTR'):
        for o in ops:
            r |= regs_mask(o)
        return r, 0
    if mn == 'POP':
        for o in ops:
            w |= regs_mask(o)
        return 0, w
    if mn.startswith('LDM'):
        if ops:
            r |= regs_mask(ops[0])
        for o in ops[1:]:
            w |= regs_mask(o)
        return r, w
    if mn.startswith('LDR') or mn.startswith('VLDR'):
        if ops:
            w |= regs_mask(ops[0])
        for o in ops[1:]:
            r |= regs_mask(o)
        return r, w
    if ops:
        w = regs_mask(ops[0])
        for o in ops[1:]:
            r |= regs_mask(o)
        if not dest_only(mn):
            r |= w
        if mn == 'MOVT':
            r |= w
    return r, w

def ends_block(mn, ops):
    if branch_kind(mn) in (1, 2, 4):
        return True
    if mn == 'POP':
        for o in ops:
            if regs_mask(o) & (1 << 15):
                return True
    return False

def has_writeback(ops):
    return any(o.endswith('!') for o in ops)

# --- the fold's own shapes ----------------------------------------------

def alu_imm(p):
    """`ADD|SUB rD, rN, #imm` with every register in r0-r12 -> (rd, rn, k)."""
    if p is None:
        return None
    mn, ops = p
    if mn not in ('ADD', 'SUB') or len(ops) != 3:
        return None
    rd, rn = reg(ops[0]), reg(ops[1])
    k = imm(ops[2])
    if rd is None or rn is None or k is None or rd > 12 or rn > 12:
        return None
    return rd, rn, (-k if mn == 'SUB' else k)

def mem_imm(p):
    """`LDR|STR* rD, [rN]` / `[rN, #imm]` -> (rd, rn, k)."""
    if p is None:
        return None
    mn, ops = p
    if mn not in MEM_MN or len(ops) != 2:
        return None
    rd = reg(ops[0])
    if rd is None or rd > 12:
        return None
    m = _MEM.match(ops[1].strip())
    if not m:
        return None
    rn = int(m.group(1))
    if rn > 12:
        return None
    return rd, rn, (int(m.group(2)) if m.group(2) is not None else 0)

def alu_size(rd, rn, v):
    """Encoded width of `ADD|SUB rD, rN, #v`."""
    if 0 <= v <= 255 and rd == rn and rd <= 7:
        return 2
    if 0 <= v <= 7 and rd <= 7 and rn <= 7:
        return 2
    return 4

def mem_size(mn, rt, rn, v):
    """Encoded width of `LDR|STR* rD, [rN, #v]`."""
    low = rt <= 7 and rn <= 7
    if mn in ('LDR', 'STR'):
        return 2 if (low and 0 <= v <= 124 and (v & 3) == 0) else 4
    if mn in ('LDRB', 'STRB'):
        return 2 if (low and 0 <= v <= 31) else 4
    if mn in ('LDRH', 'STRH'):
        return 2 if (low and 0 <= v <= 62 and (v & 1) == 0) else 4
    return 4                              # LDRSH: no 16-bit immediate form

def flag_effect(mn):
    """1 = leaves the flags alone, 2 = writes them, 0 = reads them or ends
    the straight-line run."""
    if mn in ('ADC', 'ADCS', 'SBC', 'SBCS'):
        return 0
    if mn.startswith('IT'):
        return 0
    if len(mn) == 3 and mn[0] == 'B' and mn[1:] in COND:
        return 0
    if mn in ('MOV', 'MOVW', 'MOVT', 'LDR', 'LDRB', 'LDRH', 'LDRSB', 'LDRSH',
              'STR', 'STRB', 'STRH', 'PUSH', 'POP', 'NOP', 'VLDR', 'VSTR'):
        return 1
    if mn.startswith('LDM') or mn.startswith('STM'):
        return 1
    if mn in ('CBZ', 'CBNZ'):
        return 1
    if mn in ('B', 'BL', 'BX', 'BLX'):
        return 0
    return 2

# --- the analysis -------------------------------------------------------

class Text(object):
    """One translation unit's assembly, split into lines and classified the
    way the pass classifies it.  Kind 0 is anything that is not an
    instruction (a blank line, a comment, a directive), 1 an instruction, 2 a
    label."""

    def __init__(self, text):
        self.text = text
        self.lines = text.splitlines()
        n = len(self.lines)
        self.kind = [0] * n
        self.ins = [None] * n
        self.it = [0] * n
        labels = {}
        for i in range(n):
            t = self.lines[i].strip()
            if not t or t[0] in ';@':
                continue
            if t.endswith(':'):
                self.kind[i] = 2
                labels[t[:-1]] = i
                continue
            if t[0] == '.':
                continue
            p = parse(t)
            if p:
                self.kind[i] = 1
                self.ins[i] = p
        self.labels = labels
        for i in range(n):
            if self.kind[i] != 1:
                continue
            mn = self.ins[i][0]
            if mn.startswith('IT') and (len(mn) == 2 or mn[2:3] in ('T', 'E')):
                cnt = len(mn) - 1
                c = 0
                for j in range(i + 1, n):
                    if c >= cnt:
                        break
                    if self.kind[j] == 2:
                        break
                    if self.kind[j] == 1:
                        self.it[j] = 1
                        c += 1
        # basic blocks
        self.bof = [-1] * n
        self.blocks = []                    # [first, last, succ0, succ1, sx]
        prev_end = True
        seen_label = False
        for i in range(n):
            if self.kind[i] == 2:
                seen_label = True
                continue
            if self.kind[i] != 1:
                continue
            if not self.blocks or prev_end or seen_label:
                self.blocks.append([i, i, -1, -1, 0])
            else:
                self.blocks[-1][1] = i
            self.bof[i] = len(self.blocks) - 1
            seen_label = False
            prev_end = ends_block(*self.ins[i])
        nb = len(self.blocks)
        for i in range(nb):
            first, last = self.blocks[i][0], self.blocks[i][1]
            mn, ops = self.ins[last]
            k = branch_kind(mn)
            tgt = -1
            if k in (1, 2):
                for o in ops:
                    if not o or o[0] in '#[':
                        continue
                    if regs_mask(o):
                        continue
                    if o in self.labels:
                        tgt = self.labels[o]
                        break
                if tgt >= 0:
                    line = tgt
                    tgt = -1
                    for L in range(line, n):
                        if self.bof[L] >= 0:
                            tgt = self.bof[L]
                            break
            if k == 1:
                self.blocks[i][2] = tgt
                self.blocks[i][4] = 2 if tgt < 0 else 0
            elif k == 2:
                self.blocks[i][2] = tgt
                self.blocks[i][3] = i + 1 if i + 1 < nb else -1
                self.blocks[i][4] = 2 if tgt < 0 else 0
            elif k == 4:
                self.blocks[i][2] = -1
                self.blocks[i][4] = 1
            elif ends_block(mn, ops):
                self.blocks[i][2] = -1
                self.blocks[i][4] = 1
            else:
                self.blocks[i][2] = i + 1 if i + 1 < nb else -1
                self.blocks[i][4] = 0 if i + 1 < nb else 1
        self.retmask = 0xF
        self.la = [0] * n

    def solve(self, retmask):
        """Block liveness to a fixed point, then live-after per instruction."""
        n = len(self.lines)
        self.retmask = retmask
        use, dfn, inn, out = [], [], [], []
        for first, last, s0, s1, sx in self.blocks:
            u = d = 0
            for j in range(first, last + 1):
                if self.kind[j] != 1:
                    continue
                rd, wr = rw(*self.ins[j])
                u |= rd & ~d
                d |= wr
            use.append(u)
            dfn.append(d)
            inn.append(0)
            out.append(0)
        for _ in range(64):
            ch = False
            for i in range(len(self.blocks) - 1, -1, -1):
                s0, s1, sx = self.blocks[i][2], self.blocks[i][3], self.blocks[i][4]
                o = 0
                if s0 >= 0:
                    o |= inn[s0]
                if s1 >= 0:
                    o |= inn[s1]
                if s0 < 0:
                    o |= 0xF if sx == 2 else retmask
                u = use[i] | (o & ~dfn[i])
                if u != inn[i] or o != out[i]:
                    inn[i] = u
                    out[i] = o
                    ch = True
            if not ch:
                break
        self.la = [0] * n
        for i, (_first, last, _s0, _s1, sx) in enumerate(self.blocks):
            live = out[i]
            if self.blocks[i][2] < 0:
                live |= 0xF if sx == 2 else retmask
            for j in range(last, self.blocks[i][0] - 1, -1):
                if self.kind[j] != 1:
                    continue
                self.la[j] = live
                rd, wr = rw(*self.ins[j])
                live = (live & ~wr) | rd

    def flags_free(self, j):
        """May the flags written at line `j` be replaced?"""
        blk = self.bof[j]
        for k in range(j + 1, len(self.lines)):
            if self.kind[k] == 0:
                continue
            if self.kind[k] != 1 or self.bof[k] != blk:
                return True
            e = flag_effect(self.ins[k][0])
            if e == 2:
                return True
            if e == 0:
                return False
        return True

    def same(self, i):
        """Does line `i`'s parse rebuild to exactly that line's text?"""
        mn, ops = self.ins[i]
        return rebuild(mn, ops) == self.lines[i].strip()

# --- the rules ----------------------------------------------------------

def one_pass(text, retmask=0xF):
    """One rewrite round over the whole text.  Returns (new_text, sites)."""
    t = Text(text)
    t.solve(retmask)
    n = len(t.lines)
    sites = []
    out = []
    i = 0
    while i < n:
        if t.kind[i] != 1 or t.it[i] or has_writeback(t.ins[i][1]):
            out.append(t.lines[i])
            i += 1
            continue
        a = alu_imm(t.ins[i])
        if a is not None:
            ra, rb, k1 = a
            j = i + 1
            while j < n and t.kind[j] not in (1, 2):
                j += 1
            if (j < n and t.kind[j] == 1 and t.bof[j] == t.bof[i] and
                    not t.it[j] and not has_writeback(t.ins[j][1]) and
                    not (t.la[j] & (1 << ra)) and t.flags_free(j) and
                    t.same(i) and t.same(j)):
                new = None
                b = alu_imm(t.ins[j])
                m = mem_imm(t.ins[j])
                if b is not None and b[1] == ra:
                    rd2, _rn2, k2 = b
                    tot = k1 + k2
                    if (tot != 0 and abs(tot) <= 255 and
                            alu_size(rd2, rb, abs(tot)) <=
                            alu_size(rd2, ra, abs(k2))):
                        new = (('SUB' if tot < 0 else 'ADD'),
                               ['r%d' % rd2, 'r%d' % rb, '#%d' % abs(tot)])
                elif m is not None and m[1] == ra and k1 >= 0 and m[2] >= 0:
                    rd2, _rn2, k2 = m
                    tot = k1 + k2
                    if (tot <= 4095 and
                            mem_size(t.ins[j][0], rd2, rb, tot) <=
                            mem_size(t.ins[j][0], rd2, ra, k2)):
                        new = (t.ins[j][0],
                               ['r%d' % rd2, '[r%d, #%d]' % (rb, tot)])
                if new is not None:
                    for k in range(i + 1, j):
                        out.append(t.lines[k])
                    out.append('    ' + rebuild(*new))
                    sites.append({'at': i, 'second': j,
                                  'kind': 'A' if b is not None else 'B',
                                  'line': '    ' + rebuild(*new)})
                    i = j + 1
                    continue
        out.append(t.lines[i])
        i += 1
    tail = '\n' if text.endswith('\n') else ''
    return '\n'.join(out) + tail, sites

def steps(text, retmask=0xF, rounds=4):
    """One entry per rewrite round: (text before, text after, sites).

    The pass iterates to a fixed point, and a site's line numbers only mean
    something inside the round that produced it, so the gate walks these
    instead of the flattened list."""
    out = []
    for _ in range(rounds):
        new, s = one_pass(text, retmask)
        if new == text:
            break
        out.append((text, new, s))
        text = new
    return out, text

def transform(text, retmask=0xF, rounds=4):
    """The rules to a fixed point.  Returns (new_text, sites)."""
    chunks, final = steps(text, retmask, rounds)
    sites = []
    for _a, _b, s in chunks:
        sites += s
    return final, sites

def sites(text, retmask=0xF):
    return transform(text, retmask)[1]
