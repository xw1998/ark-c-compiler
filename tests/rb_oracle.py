#!/usr/bin/env python3
"""Independent reimplementation of the S16 pass (docs/EXPR_MODEL.md S20).

This file does not share code with the compiler: it reads the *text* the
compiler emitted with both switches off, applies the two frozen rules itself,
and returns the text it expects the compiler to produce with the switches on.
`run_regbirth_tests.py` compares that against the real output, so a drift
between the rule as written and the rule as compiled shows up as a line
difference instead of as a number that happens to match.

Rules (see docs/EXPR_MODEL.md S20.2):

  A  `OP r0, ...` / `MOV rD, r0`  ->  `OP rD, ...`   (delete the MOV)
  B  `ADD rB, rX, #imm` + one `LDR|STR* rD, [rB(, #off)]`
     ->  `LDR|STR* rD, [rX(, #imm+off)]`             (delete the ADD)

Both need a forward liveness proof for `r0` / `rB`, stop at anything they
cannot order, and refuse a rename that would widen a 16-bit encoding.

Usage:  python rb_oracle.py <off.s> [<off.s> ...]     (prints the expected text)
        import rb_oracle; rb_oracle.transform(text, use_a=True, use_b=False)
"""
import re
import sys

SINGLE = set('MOV MOVW MOVT MVN ADD SUB AND ORR EOR BIC ORN LSL LSR ASR ROR '
             'RSB SBC ADC RSC MUL UDIV SDIV UXTB UXTH SXTB SXTH REV REV16 '
             'REVSH RRX CLZ LDR LDRB LDRH LDRSB LDRSH'.split())

LOAD_NODST = set('MOV MOVW MVN LDR LDRB LDRH LDRSB LDRSH REV REV16 REVSH '
                 'RRX CLZ UXTB UXTH SXTB SXTH'.split())

WHOLE = ('POP', 'LDM', 'LDMIA', 'LDMIB', 'LDMDA', 'LDMDB')
# Two-operand forms whose op[0] is a plain write.  Everything else that is
# spelled with two operands (`AND r0, r7`, `ORR r0, r1`, `LSL r0, r1`,
# `MUL r0, r1`) reads its destination as well -- the encoder emits the 16-bit
# `Rdn = Rdn OP Rm` form -- so rule A refuses it (see docs, S21).
PURE2 = set('MOV MOVW MOVT MVN LDR LDRB LDRH LDRSB LDRSH UXTB UXTH SXTB '
            'SXTH REV REV16 REVSH RRX CLZ'.split())
COND_BR = re.compile(r'^B(EQ|NE|CS|CC|HS|LO|MI|PL|VS|VC|HI|LS|GE|LT|GT|LE)$')
IT_INS = ('IT', 'ITE', 'ITT', 'ITTE', 'ITET')


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
            continue
        cur += ch
    if cur.strip():
        out.append(cur.strip())
    return out


def parse(text_line):
    s = text_line.strip()
    parts = s.split(None, 1)
    return parts[0], (operands(parts[1]) if len(parts) > 1 else [])


def reg(tok):
    return int(tok[1:]) if re.fullmatch(r'r\d+', tok) else None


def mentions(text, r):
    for m in re.finditer(r'(?<![A-Za-z0-9_])r(\d+)', text):
        if int(m.group(1)) == r:
            return True
    return False


def scan(text_lines):
    """Kind (0 pad/directive, 1 instruction, 2 label) and parsed form."""
    kind, insn, label = [], [], []
    for ln in text_lines:
        t = ln.strip()
        if not t or t[0] in ';@':
            kind.append(0); insn.append(None); label.append(None); continue
        if t.endswith(':'):
            kind.append(2); insn.append(None); label.append(t[:-1]); continue
        if t.startswith('.'):
            kind.append(0); insn.append(None); label.append(None); continue
        if ln.startswith('    ') or ln.startswith('\t'):
            kind.append(1); insn.append(parse(t)); label.append(None); continue
        kind.append(0); insn.append(None); label.append(None)
    return kind, insn, label


def pure_dest(mn, ops):
    """True when op[0] is written and never read by this instruction."""
    if len(ops) >= 3:
        return True
    if len(ops) < 2:
        return False
    return mn in PURE2

def primary_dest(i):
    """Register written as the primary destination, or None."""
    mn, ops = i
    if not ops:
        return None
    if mn in ('CMP', 'CMN', 'TST', 'TEQ', 'PUSH', 'POP', 'STM', 'STMDB',
              'STMIA', 'STR', 'STRB', 'STRH', 'B', 'BL', 'BX', 'BLX'):
        return None
    if mn.startswith('B') and mn != 'BIC':
        return None
    if mn in IT_INS:
        return None
    return reg(ops[0])


def reads(i, r):
    mn, ops = i
    for k in range(1, len(ops)):
        if mentions(ops[k], r):
            return True
    if ops and mentions(ops[0], r) and not (len(ops) >= 3 or mn in LOAD_NODST):
        return True
    return False


def list_has(ops, r):
    """`{r5, r6, r7, r8, pc}` written with ', ' separators (the emitter's form)."""
    if len(ops) != 1 or not ops[0].startswith('{'):
        return False
    body = ops[0][1:].rstrip('}')
    for item in body.split(','):
        item = item.strip()
        m = re.fullmatch(r'r(\d+)(?:-r(\d+))?', item)
        if not m:
            if item in ('sp', 'lr'):
                a = 13 if item == 'sp' else 14
                if a == r:
                    return True
                continue
            if item == 'pc':
                if r == 15:
                    return True
                continue
            return False
        a = int(m.group(1))
        b = int(m.group(2)) if m.group(2) else a
        if a <= r <= b:
            return True
    return False


def dead_after(kind, insn, label, q, r, hooks=8):
    """True when `r` is provably not needed from line `q` onwards."""
    hops = 0
    while q < len(kind):
        if kind[q] == 0:
            q += 1
            continue
        if kind[q] == 2:
            return False                    # a label: other paths arrive here
        mn, ops = insn[q]
        if mn in ('BL', 'BLX', 'BX'):
            return False
        if mn in WHOLE:
            if list_has(ops, r):
                return True                 # restored by the pop/ldm
            if mentions(' '.join(ops), 15):
                return False                # returns, r may be the result
            q += 1
            continue
        if mn == 'B' or COND_BR.match(mn):
            if mn != 'B' or len(ops) != 1 or not re.fullmatch(r'\.?[\w.$]+', ops[0]):
                return False
            tgt = [z for z in range(len(kind)) if kind[z] == 2 and label[z] == ops[0]]
            if not tgt:
                return False
            hops += 1
            if hops > hooks:
                return False
            q = tgt[0] + 1
            continue
        if mn in ('CBZ', 'CBNZ') or mn in IT_INS:
            return False
        if reads(insn[q], r):
            return False
        if primary_dest(insn[q]) == r:
            return True
        q += 1
    return True


def has_writeback(ops):
    for s in ops[1:]:
        if '!' in s:
            return True
        if ']' in s and s[s.index(']') + 1:].strip():
            return True
    return False


def narrow(ops):
    """Every register r0-r7 and no immediate above 7 (conservative)."""
    for t in ops:
        for r in range(8, 16):
            if mentions(t, r):
                return False
        if t.startswith('#'):
            body = t[1:]
            if body.startswith('-') or not body.isdigit():
                return False
            if int(body) > 7 and not (ops[0].startswith('[') or mentions(t, 0)):
                return False
    return True


def memory_operand(ops):
    """(Rd, Rb text, offset) of `Rd, [Rb]` / `Rd, [Rb, #off]`, else None."""
    if len(ops) != 2:
        return None
    rd = reg(ops[0])
    if rd is None:
        return None
    m = re.fullmatch(r'\[(r\d+)\]', ops[1])
    if m:
        return rd, m.group(1), 0
    m = re.fullmatch(r'\[(r\d+), #(\d+)\]', ops[1])
    if m:
        return rd, m.group(1), int(m.group(2))
    return None


def transform(text, use_a=True, use_b=True):
    """The text with both rules applied, as the compiler should emit it."""
    lines = text.splitlines()
    kind, insn, label = scan(lines)
    n = len(lines)
    delete = [False] * n
    replace = {}
    i = 0
    while i < n:
        if kind[i] != 1 or delete[i]:
            i += 1
            continue
        mn, ops = insn[i]

        if (use_a and ops and ops[0] == 'r0' and mn in SINGLE
                and pure_dest(mn, ops) and not has_writeback(ops)):
            nxt = i + 1
            while nxt < n and kind[nxt] == 0:
                nxt += 1
            if (nxt < n and kind[nxt] == 1 and insn[nxt][0] == 'MOV'
                    and len(insn[nxt][1]) == 2 and insn[nxt][1][1] == 'r0'):
                rd = reg(insn[nxt][1][0])
                if (rd is not None and rd != 0
                        and not any(mentions(t, rd) for t in ops[1:])
                        and (not narrow(ops) or rd <= 7)
                        and dead_after(kind, insn, label, nxt + 1, 0)):
                    replace[i] = ('    ' + mn + ' r%d' % rd +
                                  (', ' + ', '.join(ops[1:]) if len(ops) > 1 else ''))
                    delete[nxt] = True
                    i = nxt + 1
                    continue

        if (use_b and mn == 'ADD' and len(ops) == 3 and ops[2].startswith('#')
                and not has_writeback(ops)):
            rb, rx = reg(ops[0]), reg(ops[1])
            body = ops[2][1:]
            if rb is not None and rx is not None and body.isdigit():
                imm = int(body)
                if 0 < imm <= 1020 and imm % 4 == 0:
                    done = False
                    for j in range(i + 1, min(i + 6, n)):
                        if kind[j] == 2:
                            break
                        if kind[j] == 0:
                            continue
                        if delete[j]:
                            break
                        jmn, jops = insn[j]
                        mem = memory_operand(jops)
                        if mem is None:
                            if any(mentions(t, rb) for t in jops):
                                break
                            if primary_dest(insn[j]) == rx:
                                break
                            if (jmn.startswith('B') or jmn in ('PUSH', 'POP', 'LDM',
                                                               'STM', 'LDMIA', 'STMIA')
                                    or jmn in IT_INS):
                                break
                            continue
                        rd2, base, off = mem
                        if base != 'r%d' % rb:
                            break
                        total = imm + off
                        if total > 4095:
                            break
                        if jmn.startswith('STR') and rd2 == rb:
                            break
                        if mentions(jops[1], rx):
                            break
                        if not dead_after(kind, insn, label, j + 1, rb):
                            break
                        addr = ('[r%d]' % rx if total == 0
                                else '[r%d, #%d]' % (rx, total))
                        replace[j] = '    ' + jmn + ' ' + jops[0] + ', ' + addr
                        delete[i] = True
                        done = True
                        break
                    if done:
                        i = j + 1
                        continue
        i += 1

    out = []
    for k in range(n):
        if delete[k]:
            continue
        out.append(replace.get(k, lines[k]))
    return '\n'.join(out) + ('\n' if text.endswith('\n') else '')


if __name__ == '__main__':
    for path in sys.argv[1:]:
        with open(path, 'r', encoding='utf-8', errors='replace') as fh:
            sys.stdout.write(transform(fh.read()))