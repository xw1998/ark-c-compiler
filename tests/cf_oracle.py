#!/usr/bin/env python3
"""Independent re-implementation of the S17 same-value comparison-run fold.

This module reproduces `ark_chainfold_function` (src/backend/arm/backend_arm.c)
from the emitted text alone: no code, no constant and no table is shared with
the compiler.  The rule is frozen in docs/EXPR_MODEL.md S22.3:

A *layer* is five instructions (label lines may sit in between):

    LDR rL, .Llit          ; a literal-pool load into rL
    CMP rX, rL             ; two operands, rX != rL
    BNE label              ; only BNE is accepted
    MOV|MOVW rD, #v        ; two operands
    B label                ; immediately after the MOV

A *run* is two or more adjacent layers with the same compared register, the
same load register, the same destination, the same value text and the same
`MOV`/`MOVW` mnemonic, where each layer's `BNE` lands exactly on the next
layer and every layer's `B` lands on one and the same instruction.  A run of
m layers keeps the last `MOV`/`B`, turns each earlier `BNE` into `BEQ <hit>`
and puts one fresh `<hit>:` label in front of the kept `MOV`.

The generated label carries the compiler's buffer offset, which the oracle
cannot know; `normalise` maps every generated label to `.Lcf_#` so the two
outputs can be compared byte for byte.

Usage as a module: `transform(text)` -> text, `layers(text)`, `runs(text)`.
Usage as a script: `cf_oracle.py off.s on.s` compares one file.
"""
import re
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import rb_oracle

# kind: 0 = blank/directive, 1 = instruction, 2 = label
INSN, LABEL = 1, 2

MOVS = ('MOV', 'MOVW')


def scan(lines):
    return rb_oracle.scan(lines)


def _nxt(kind, i, n):
    j = i + 1
    while j < n and kind[j] != INSN:
        j += 1
    return j if j < n else -1


class Text(object):
    """One translation unit: lines, kinds, parsed forms, label positions."""

    def __init__(self, text):
        self.lines = text.splitlines()
        self.kind, self.insn, self.label = scan(self.lines)
        self.n = len(self.lines)
        self.lpos = {}
        for i in range(self.n):
            if self.kind[i] == LABEL:
                self.lpos[self.label[i]] = i

    def nxt(self, i):
        return _nxt(self.kind, i, self.n)

    def target(self, name):
        """First instruction line at or after label `name`, or -1."""
        if name not in self.lpos:
            return -1
        q = self.lpos[name]
        while q < self.n and self.kind[q] != INSN:
            q += 1
        return q if q < self.n else -1

    def layer(self, i):
        """The layer starting at line i, or None."""
        if i < 0 or i >= self.n or self.kind[i] != INSN:
            return None
        mn, ops = self.insn[i]
        if mn != 'LDR' or len(ops) != 2 or not ops[1].startswith('.'):
            return None
        rl = rb_oracle.reg(ops[0])
        if rl is None:
            return None
        j = self.nxt(i)
        if j < 0:
            return None
        mn2, ops2 = self.insn[j]
        if mn2 != 'CMP' or len(ops2) != 2:
            return None
        if rb_oracle.reg(ops2[1]) != rl:
            return None
        rx = rb_oracle.reg(ops2[0])
        if rx is None:
            return None
        k = self.nxt(j)
        if k < 0:
            return None
        mn3, ops3 = self.insn[k]
        if mn3 != 'BNE' or len(ops3) != 1 or not ops3[0].startswith('.'):
            return None
        m = self.nxt(k)
        if m < 0:
            return None
        if self.insn[m][0] not in MOVS or len(self.insn[m][1]) != 2:
            return None
        if not self.insn[m][1][1].startswith('#'):
            return None
        rd = rb_oracle.reg(self.insn[m][1][0])
        if rd is None:
            return None
        if m + 1 >= self.n or self.kind[m + 1] != INSN:
            return None
        if self.insn[m + 1][0] != 'B' or len(self.insn[m + 1][1]) != 1:
            return None
        if not self.insn[m + 1][1][0].startswith('.'):
            return None
        if rd == rx or rd == rl:
            return None
        return {'ldr': i, 'cmp': j, 'br': k, 'mov': m, 'b': m + 1,
                'rl': rl, 'rx': rx, 'rd': rd}


def layers(t):
    """Every layer in the text, keyed by its LDR line."""
    return [t.layer(i) for i in range(t.n) if t.layer(i)]


def explain(t, a, b):
    """Why layer b does not extend a's run.  '' when it does."""
    if b is None:
        return 'no_following_layer'
    if b['rx'] != a['rx']:
        return 'cmp_register'
    if b['rl'] != a['rl']:
        return 'load_register'
    if b['rd'] != a['rd']:
        return 'destination'
    if t.insn[b['mov']][0] != t.insn[a['mov']][0]:
        return 'move_form'
    if t.insn[b['mov']][1][1] != t.insn[a['mov']][1][1]:
        return 'value'
    name = t.insn[a['br']][1][0]
    if name not in t.lpos:
        return 'bne_target'
    if t.target(name) != b['ldr']:
        return 'label_between'
    jt = t.target(t.insn[a['b']][1][0])
    jt2 = t.target(t.insn[b['b']][1][0])
    if jt < 0 or jt2 < 0:
        return 'join_target'
    if jt != jt2:
        return 'join_differs'
    return ''


def runs(t):
    """All maximal runs (>= 2 layers), in text order."""
    out = []
    i = 0
    while i < t.n:
        a = t.layer(i)
        if a is None:
            i += 1
            continue
        run = [a]
        while True:
            b = t.layer(t.nxt(run[-1]['b']))
            if b is None or explain(t, run[-1], b):
                break
            run.append(b)
        if len(run) >= 2:
            out.append(run)
            i = run[-1]['b'] + 1
        else:
            i += 1
    return out


def refusals(t):
    """{reason: count} for every layer whose successor does not extend it."""
    out = {}
    done = set()
    for run in runs(t):
        done.add(run[-1]['ldr'])
    for lay in layers(t):
        if lay['ldr'] in done:
            continue
        why = explain(t, lay, t.layer(t.nxt(lay['b'])))
        if why:
            out[why] = out.get(why, 0) + 1
    return out


def transform(text):
    """Fold every same-value comparison run; returns the new text."""
    t = Text(text)
    drop = set()
    rewrite = {}
    prelabel = {}
    runs_seen = 0
    for run in runs(t):
        hit = '.Lcf_0_%d' % run[0]['ldr']
        for lay in run[:-1]:
            rewrite[lay['br']] = '    BEQ %s' % hit
            drop.add(lay['mov'])
            drop.add(lay['b'])
        prelabel[run[-1]['mov']] = hit + ':'
        runs_seen += 1
    if not runs_seen:
        return text
    out = []
    for i in range(t.n):
        if i in prelabel:
            out.append(prelabel[i])
        if i in drop:
            continue
        out.append(rewrite.get(i, t.lines[i]))
    return '\n'.join(out) + '\n'


GEN_RE = re.compile(r'\.Lcf_\d+_\d+')


def normalise(text):
    """Map every generated hit label to `.Lcf_#` (see the module docstring)."""
    return GEN_RE.sub('.Lcf_#', text)


def main(argv):
    if len(argv) != 3:
        print('usage: cf_oracle.py off.s on.s')
        return 2
    with open(argv[1], 'rb') as fh:
        off = fh.read().decode('utf-8', 'replace')
    with open(argv[2], 'rb') as fh:
        on = fh.read().decode('utf-8', 'replace')
    got = normalise(transform(off))
    want = normalise(on)
    if got == want:
        print('identical (%d runs)' % len(runs(Text(off))))
        return 0
    a, b = got.splitlines(), want.splitlines()
    import difflib
    for ln in list(difflib.unified_diff(a, b, 'oracle', 'compiler', n=1))[:40]:
        print(ln)
    return 1


if __name__ == '__main__':
    sys.exit(main(sys.argv))
