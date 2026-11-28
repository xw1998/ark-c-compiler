"""Independent reconstruction of the -fopt-isel2 rules, from the text alone.

Every rule removes exactly one instruction and adds none:

  R1  AND rD, rS, #2^k / CMP rD, #2^k / B{EQ,NE} L  ->  ANDS rD, rS, #2^k / B{swapped} L
  R2  AND rD, rS, #m   / CMP rD, #0     / B{EQ,NE} L  ->  ANDS rD, rS, #m    / B L
  R3  MOV rT, rB       / OP rT, X  (OP a two-operand ADD/SUB/AND/ORR/EOR/BIC)
                                                    ->  OP rT, rB, X
  R4  LDRB|LDRH|LDRSB|LDRSH rD, [...] / UXTB|UXTH|SXTB|SXTH rD, rD
                                                    ->  the extend is dropped

Adjacency is measured between *instructions*: a `.loc` or `.cfi` directive
between two instructions does not break a rule (the emitter puts one in front
of nearly every statement).  A label is transparent only when no branch in the
function names it; any other text between the two instructions refuses the
site, as does an `IT`, and so does a following instruction that reads the
flags (for the rules that change or delete the compare).

This is a second, independent implementation of the same rules: it shares no
code with the compiler.  It exists so a test can ask whether the switch did
exactly what the rules say and nothing else.
"""
import sys

ALU = ('ADD', 'SUB', 'AND', 'ORR', 'EOR', 'BIC')
NARROW = {'LDRB': ('UXTB',), 'LDRH': ('UXTH',),
          'LDRSB': ('SXTB',), 'LDRSH': ('SXTH',)}
REGS = ('r0','r1','r2','r3','r4','r5','r6','r7','r8','r9','r10','r11','r12',
        'sp','lr','pc','r13','r14','r15')
LOW = set('r%d' % i for i in range(13))


def parse(t):
    raw = t
    t = t.strip()
    if not t or t[0] in '.;@':
        return None
    n = 0
    while n < len(t) and t[n].isalpha():
        n += 1
    mn = t[:n].upper()
    rest = t[n:]
    if not mn or not rest.startswith(' '):
        return None
    ops, cur, depth = [], '', 0
    for ch in rest:
        if ch in '[{':
            depth += 1
        elif ch in ']}':
            depth -= 1
        if ch == ',' and depth == 0:
            ops.append(cur.strip()); cur = ''
        else:
            cur += ch
    if cur.strip():
        ops.append(cur.strip())
    return [mn, ops, t, raw]


def low(o):
    o = o.strip()
    return o in LOW


def imm(o):
    o = o.strip()
    if o.startswith('#'):
        try:
            return int(o[1:], 0)
        except ValueError:
            return None
    return None


def reads_flags(mn):
    if mn in ('ADC', 'ADCS', 'SBC', 'SBCS'):
        return True
    if mn.startswith('IT'):
        return True
    if len(mn) == 3 and mn[0] == 'B' and mn[1:] not in ('L', 'X', 'LX'):
        return True
    return False


def match(a, b, d=None):
    """Returns (replacement_lines, rule_name) or None."""
    if a is None:
        return None
    # R4
    if b is not None and len(a[1]) == 2 and len(b[1]) == 2 and a[0] in NARROW:
        if b[0] in NARROW[a[0]] and low(a[1][0]) and \
                b[1][0] == a[1][0] and b[1][1] == a[1][0]:
            return ([a[3]], 'R4')
    # R3
    if b is not None and len(a[1]) == 2 and len(b[1]) == 2 and a[0] == 'MOV' \
            and low(a[1][0]) and low(a[1][1]) and a[1][0] != a[1][1] \
            and b[0] in ALU and low(b[1][1]) \
            and b[1][0] == a[1][0] and b[1][1] != a[1][0]:
        return (['    %s %s, %s, %s' % (b[0], b[1][0], a[1][1], b[1][1])], 'R3')
    if b is None or d is None:
        return None
    if d[0] not in ('BEQ', 'BNE'):
        return None
    # R1/R2
    if a[0] == 'AND' and len(a[1]) == 3 and len(b[1]) == 2 and b[0] == 'CMP' \
            and low(a[1][0]) and low(a[1][1]) and b[1][0] == a[1][0]:
        k = imm(a[1][2]); cv = imm(b[1][1])
        if k is not None and cv is not None and k > 0:
            if (k & (k - 1)) == 0 and cv == k:
                sw = 'BNE' if d[0] == 'BEQ' else 'BEQ'
                return (['    ANDS %s, %s, %s' % (a[1][0], a[1][1], a[1][2]),
                         '    %s %s' % (sw, ', '.join(d[1]))], 'R1')
            if cv == 0:
                return (['    ANDS %s, %s, %s' % (a[1][0], a[1][1], a[1][2]),
                         '    %s %s' % (d[0], ', '.join(d[1]))], 'R2')
    return None


def analyse(lines):
    """Per-line class, referenced-label set and IT membership."""
    ins = [parse(l) for l in lines]
    kd = [0] * len(lines)
    labels = {}
    for i, o in enumerate(ins):
        if o is not None:
            kd[i] = 1
        else:
            t = lines[i].strip()
            # A label is recognised by its trailing colon *before* the
            # directive test: every label this compiler emits starts with
            # `.L`, and reading those as directives made the gap test blind
            # to a branch landing between the instructions of a rule.
            if t and t.endswith(':') and not t.startswith((';', '@')):
                kd[i] = 2
                labels[t[:-1]] = i
    rref = set()
    for o in ins:
        if o is None:
            continue
        for op in o[1]:
            op = op.strip()
            if op in labels and op not in REGS:
                rref.add(labels[op])
    init = set()
    for i, o in enumerate(ins):
        if o is None:
            continue
        mn = o[0]
        if mn.startswith('IT') and (len(mn) == 2 or mn[2] in 'TE'):
            cnt, c = len(mn) - 1, 0
            for j in range(i + 1, len(lines)):
                if kd[j] == 2:
                    break
                if kd[j] == 1:
                    init.add(j); c += 1
                    if c >= cnt:
                        break
    return ins, kd, rref, init


def gap_ok(lines, kd, rref, lo, hi):
    for j in range(lo + 1, hi):
        if kd[j] == 1:
            return False
        if kd[j] == 2:
            if j in rref:
                return False
            continue
        t = lines[j].strip()
        if t and not t.startswith(('.', ';', '@')):
            return False
    return True


def one_pass(lines):
    ins, kd, rref, init = analyse(lines)
    idx = [i for i, o in enumerate(ins) if o is not None]
    out = list(lines)
    counts = {}
    k = 0
    while k < len(idx):
        i = idx[k]
        a = ins[i]
        b = ins[idx[k + 1]] if k + 1 < len(idx) else None
        d = ins[idx[k + 2]] if k + 2 < len(idx) else None
        m = None
        if i not in init:
            m = match(a, b, d)
        if m:
            rep, name = m
            used = 3 if name in ('R1', 'R2') else 2
            ok = all(gap_ok(lines, kd, rref, idx[k + j], idx[k + j + 1])
                     for j in range(used - 1))
            if ok and used == 3 and k + used < len(idx) \
                    and reads_flags(ins[idx[k + used]][0]):
                ok = False
            if ok:
                for j, txt in enumerate(rep):
                    out[idx[k + j]] = txt
                for j in range(len(rep), used):
                    out[idx[k + j]] = None
                counts[name] = counts.get(name, 0) + 1
                k += used
                continue
        k += 1
    return [l for l in out if l is not None], counts


def apply_text(txt, rounds=4):
    lines = txt.split('\n')
    total = {}
    for _ in range(rounds):
        lines, c = one_pass(lines)
        for k, v in c.items():
            total[k] = total.get(k, 0) + v
        if not c:
            break
    return '\n'.join(lines), total


def count_ins(lines):
    return sum(1 for l in lines if parse(l) is not None)


if __name__ == '__main__':
    import glob, os
    tot = {}
    files = sorted(glob.glob(os.path.join(sys.argv[1], sys.argv[2])))
    n0 = n1 = 0
    for p in files:
        txt = open(p, 'rb').read().decode('utf-8', 'replace')
        before = txt.split('\n')
        after, c = apply_text(txt)
        for k, v in c.items():
            tot[k] = tot.get(k, 0) + v
        n0 += count_ins(before)
        n1 += count_ins(after.split('\n'))
    print('instructions %d -> %d  (saved %d)' % (n0, n1, n0 - n1))
    for k in sorted(tot):
        print('  %s %5d' % (k, tot[k]))
