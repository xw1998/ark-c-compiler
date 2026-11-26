#!/usr/bin/env python3
"""Independent re-implementation of the -fopt-pushpop rule (0.9.1, S19-a).

The compiler's pass lives in `ark_pushpop_function` (backend_arm.c); this
module shares no code and no constants with it.  It reads the switch-off
assembly text and rewrites it by the rule alone, so the gate can compare the
compiler's switch-on text against a second opinion.

The rule, as frozen in docs/EXPR_MODEL.md section 27.3:

    <def>            ; `MOV|MOVW rX, #imm`, `LDR rX, .Llit` or `MOV rX, rY`,
                     ; the instruction straight before the PUSH, with no
                     ; label line between the two
    PUSH {rX}        ; one register, r0-r12
    ...
    POP {rY}         ; one register, r0-r12; the first PUSH/POP after the
                     ; PUSH, with no BL/BLX and no instruction naming sp in
                     ; between

  * every branch inside the PUSH..POP span lands on a label inside the span,
    and no label inside the span is reached from outside it;
  * if rX is named by no instruction inside the span and rY == rX, both
    lines go; if rX is untouched and rY != rX, the PUSH line goes and the
    POP line becomes `MOV rY, rX`;
  * if rX is clobbered inside the span, the PUSH line goes and the POP line
    becomes `<def> rY, <same operand>`, which is allowed for the `MOV rX, rY`
    form only while rY is untouched too.

The definition itself is left in place; a definition that has just become
dead is `-fopt-deadins`' business.
"""
import re

_MN = re.compile(r'[A-Za-z]+')
_TOKEN = re.compile(r'[A-Za-z0-9_]+')
_BCC = set(['BNE', 'BEQ', 'BLS', 'BHI', 'BCC', 'BCS', 'BLO', 'BHS',
            'BMI', 'BPL', 'BGT', 'BGE', 'BLT', 'BLE', 'BVS', 'BVC'])
_ADDR = re.compile(r'r(\d+)\Z')


def bits(regs):
    m = 0
    for r in regs:
        m |= 1 << r
    return m


def regs_in(s):
    """Every register named by `s` (r0-r15, sp, lr, pc), as a set."""
    out = set()
    for tok in _TOKEN.findall(s):
        t = tok.lower()
        if t == 'sp':
            out.add(13)
        elif t == 'lr':
            out.add(14)
        elif t == 'pc':
            out.add(15)
        else:
            m = _ADDR.match(t)
            if m:
                v = int(m.group(1))
                if 0 <= v <= 15:
                    out.add(v)
    return out


def parse(s):
    """(mnemonic, [operands]) for one trimmed instruction line, or None.

    Mirrors the compiler's parser: letters for the mnemonic, one space, then
    operands split on commas that are not inside `[]` or `{}`.
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


def one_reg(op):
    """The single register of a `{rN}` list, or None."""
    s = op.strip()
    if not s.startswith('{') or not s.endswith('}'):
        return None
    inner = s[1:-1].replace(' ', '').replace('\t', '')
    if not inner or ',' in inner:
        return None
    t = inner.lower()
    if t in ('sp', 'lr', 'pc'):
        return {'sp': 13, 'lr': 14, 'pc': 15}[t]
    m = _ADDR.match(t)
    if not m:
        return None
    v = int(m.group(1))
    return v if 0 <= v <= 15 else None


def push_reg(ins):
    if ins is None:
        return None
    mn, ops = ins
    if mn != 'PUSH' or len(ops) != 1:
        return None
    r = one_reg(ops[0])
    return r if r is not None and r <= 12 else None


def pop_reg(ins):
    if ins is None:
        return None
    mn, ops = ins
    if mn != 'POP' or len(ops) != 1:
        return None
    r = one_reg(ops[0])
    return r if r is not None and r <= 12 else None


def branch_target(ins):
    """Label name of `B .Lx` / `Bcc .Lx`, else None."""
    if ins is None:
        return None
    mn, ops = ins
    if len(ops) != 1 or not ops[0].startswith('.'):
        return None
    if mn == 'B' or mn in _BCC:
        return ops[0]
    return None


def definition(ins, rx):
    """(mnemonic, operand text, source register or None) for a re-buildable
    definition of register `rx`, else None."""
    if ins is None:
        return None
    mn, ops = ins
    if len(ops) != 2:
        return None
    if mn not in ('MOV', 'MOVW', 'LDR'):
        return None
    m = _ADDR.match(ops[0].lower())
    if not m or int(m.group(1)) != rx:
        return None
    if mn == 'LDR':
        if not ops[1].startswith('.'):
            return None
        return (mn, ops[1], None)
    if ops[1].startswith('#'):
        return (mn, ops[1], None)
    if mn != 'MOV':
        return None
    m = _ADDR.match(ops[1].lower())
    if not m:
        return None
    return (mn, ops[1], int(m.group(1)))


class Text(object):
    """Line classification, the same way the compiler's scanner sees a file.

    `kind[i]` is 1 for an instruction, 2 for a label, 0 for anything the
    scanner skips (blank, comment, directive).
    """

    def __init__(self, text):
        self.lines = text.splitlines()
        self.kind = []
        self.ins = []
        self.label = {}
        for i, ln in enumerate(self.lines):
            s = ln.strip()
            if not s or s[0] in ';@':
                self.kind.append(0)
                self.ins.append(None)
                continue
            if s.endswith(':'):
                self.kind.append(2)
                self.ins.append(None)
                self.label[s[:-1]] = i
                continue
            if s[0] == '.':
                self.kind.append(0)
                self.ins.append(None)
                continue
            p = parse(s)
            self.kind.append(1 if p else 0)
            self.ins.append(p)
    #
    def prev_insn(self, i):
        for j in range(i - 1, -1, -1):
            if self.kind[j] == 1:
                return j
        return -1

    def named_between(self, a, b, r):
        for k in range(a + 1, b):
            if self.kind[k] == 1 and r in regs_in(' '.join(self.ins[k][1])):
                return True
        return False

    def span_ok(self, p, q):
        for i in range(p, q + 1):
            if self.kind[i] != 1:
                continue
            t = branch_target(self.ins[i])
            if t is None:
                continue
            lp = self.label.get(t, -1)
            if lp <= p or lp >= q:
                return False
        for i in range(len(self.lines)):
            if p < i < q or self.kind[i] != 1:
                continue
            t = branch_target(self.ins[i])
            if t is None:
                continue
            lp = self.label.get(t, -1)
            if p < lp < q:
                return False
        return True


def sites(text):
    """All applications of the rule, in the compiler's order.

    Each entry is a dict with `push` / `pop` line indices (0-based), `kind`
    ('pair' for both halves deleted, 'copy' for `MOV rY, rX`, 'remat' for a
    re-materialised definition) and `rep` (the replacement line for the POP,
    or None).
    """
    t = text if isinstance(text, Text) else Text(text)
    out = []
    for i in range(len(t.lines)):
        rx = push_reg(t.ins[i]) if t.kind[i] == 1 else None
        if rx is None:
            continue
        d = t.prev_insn(i)
        if d < 0:
            continue
        if any(t.kind[k] != 0 for k in range(d + 1, i)):
            continue
        dfn = definition(t.ins[d], rx)
        if dfn is None:
            continue
        q = -1
        for k in range(i + 1, len(t.lines)):
            if t.kind[k] != 1:
                continue
            mn, ops = t.ins[k]
            if mn == 'PUSH':
                break
            if mn == 'POP':
                if pop_reg(t.ins[k]) is not None:
                    q = k
                break
            if mn in ('BL', 'BLX'):
                break
            if 13 in regs_in(' '.join(ops)):
                break
        if q < 0:
            continue
        if not t.span_ok(i, q):
            continue
        ry = pop_reg(t.ins[q])
        if not t.named_between(i, q, rx):
            if ry == rx:
                out.append(dict(push=i, pop=q, kind='pair', rep=None, defn=d))
            else:
                out.append(dict(push=i, pop=q, kind='copy', defn=d,
                                rep='    MOV r%d, r%d' % (ry, rx)))
        elif dfn[2] is not None:
            if t.named_between(i, q, dfn[2]):
                continue
            out.append(dict(push=i, pop=q, kind='copy', defn=d,
                            rep='    MOV r%d, r%d' % (ry, dfn[2])))
        else:
            out.append(dict(push=i, pop=q, kind='remat', defn=d,
                            rep='    %s r%d, %s' % (dfn[0], ry, dfn[1])))
    return out


def transform(text):
    """(rewritten text, sites).  The definition lines are left in place."""
    t = text if isinstance(text, Text) else Text(text)
    ss = sites(t)
    if not ss:
        return text, ss
    drop = {}
    for s in ss:
        drop[s['push']] = None
        drop[s['pop']] = s['rep']
    out = []
    for i, ln in enumerate(t.lines):
        if i in drop:
            if drop[i] is not None:
                out.append(drop[i])
            continue
        out.append(ln)
    return '\n'.join(out) + ('\n' if text.endswith('\n') else ''), ss


def explain(text, push_index):
    """Why the PUSH at `push_index` is not a site, or None when it is one."""
    t = text if isinstance(text, Text) else Text(text)
    i = push_index
    rx = push_reg(t.ins[i])
    if rx is None:
        return 'not_a_single_push'
    d = t.prev_insn(i)
    if d < 0:
        return 'no_definition'
    if any(t.kind[k] != 0 for k in range(d + 1, i)):
        return 'label_before_push'
    dfn = definition(t.ins[d], rx)
    if dfn is None:
        return 'no_definition'
    q = -1
    for k in range(i + 1, len(t.lines)):
        if t.kind[k] != 1:
            continue
        mn, ops = t.ins[k]
        if mn == 'PUSH':
            return 'nested_push'
        if mn == 'POP':
            if pop_reg(t.ins[k]) is not None:
                q = k
            else:
                return 'pop_not_single'
            break
        if mn in ('BL', 'BLX'):
            return 'call_in_span'
        if 13 in regs_in(' '.join(ops)):
            return 'sp_in_span'
    if q < 0:
        return 'no_pop'
    if not t.span_ok(i, q):
        return 'span_split'
    ry = pop_reg(t.ins[q])
    if not t.named_between(i, q, rx):
        return None
    if dfn[2] is not None:
        if t.named_between(i, q, dfn[2]):
            return 'copy_source_clobbered'
        return None
    return None
