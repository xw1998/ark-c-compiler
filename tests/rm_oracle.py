#!/usr/bin/env python3
"""Independent re-implementation of the -fopt-remat rule (0.9.1, S21).

The compiler's pass is `ark_remat_function` (backend_arm.c); this module shares
no code with it -- it re-parses the text (through `af_oracle`, which is itself
an independent parser) and re-derives the one rule, so the gate can compare the
compiler's switch-on text against a second opinion.

The rule, as frozen in docs/EXPR_MODEL.md section 31.2:

    MOV|MOVW rX, #imm     (or)   LDR rX, .Llit_k
    ...                    nothing writes rX, no branch can be entered ...
    MOV|MOVW rX, #imm     (or)   LDR rX, .Llit_k          <- deleted

What must hold, and why:

  * the value is the same -- mnemonic and every operand text identical, so
    `MOV` and `MOVW` never mix and no immediate is re-lexed as a number;
  * nothing in between writes rX, so the register still holds that value;
  * the region is straight line: it ends at any branch, return or call and at
    any label a branch can land on; a label nothing references can only be
    reached by fallthrough and is transparent;
  * neither line sits under an IT (the conditional instruction count cannot
    change);
  * `MOV`/`MOVW`/`LDR` from the pool write no flags, so deleting one changes
    nothing a flag consumer can see.

Only literal-pool loads (`.Llit...`) count as materialising a constant;
`LDR rX, [rY, #imm]` reads memory and is never a candidate.
"""
import af_oracle as A


def ident(ins):
    """(register, value key) for an instruction that puts a constant in a
    register, else None."""
    if ins is None:
        return None
    mn, ops = ins
    if len(ops) != 2:
        return None
    r = A.reg(ops[0])
    if r is None or r > 12:
        return None
    if mn in ('MOV', 'MOVW'):
        if not ops[1].startswith('#') or len(ops[1]) < 2:
            return None
        return (r, mn + ' ' + ops[1])
    if mn == 'LDR':
        if not ops[1].startswith('.Llit'):
            return None
        return (r, 'LDR ' + ops[1])
    return None


def label_refs(t):
    """Line indices of labels a branch (or any operand naming a label at all)
    can land on.  Anything that is not a register is taken as a possible
    label, so the cp of "too many" only stops the scan earlier."""
    refs = set()
    for i in range(len(t.lines)):
        if t.kind[i] != 1:
            continue
        for o in t.ins[i][1]:
            if not o or o[0] in '#[':
                continue
            if A.reg(o) is not None:
                continue
            if o in t.labels:
                refs.add(t.labels[o])
    return refs


def generated_start(lines):
    """Index of the first line of the compiler's generated tail, or len(lines).

    `__arkcc_init_globals` and everything after it is emitted once per TU,
    outside any C function, so the per-function pass never sees it.  The
    oracle is restricted to the same scope; the boundary is the label
    *definition* -- the line that reads `__arkcc_init_globals:` -- not the
    `BL __arkcc_init_globals` the startup code emits far earlier."""
    for i, ln in enumerate(lines):
        if ln.strip() == '__arkcc_init_globals:':
            return i
    return len(lines)


def one_pass(text):
    """(new_text, sites) for one round.  Deleting a duplicate cannot expose
    another one, so a second round is never needed."""
    t = A.Text(text)
    n = len(t.lines)
    tail_start = generated_start(t.lines)
    refs = label_refs(t)
    dead = set()
    sites = []
    i = 0
    while i < tail_start:
        cur = ident(t.ins[i]) if t.kind[i] == 1 else None
        if cur is not None and not t.it[i]:
            rx, key = cur
            j = i + 1
            got = []
            while j < tail_start:
                if t.kind[j] == 2:
                    if j in refs:
                        break
                    j += 1
                    continue
                if t.kind[j] != 1:
                    j += 1
                    continue
                if t.it[j]:
                    break
                mn, ops = t.ins[j]
                if A.branch_kind(mn) or A.ends_block(mn, ops):
                    break
                nxt = ident(t.ins[j])
                if nxt is not None and nxt[0] == rx and nxt[1] == key:
                    got.append(j)
                    j += 1
                    continue
                _rd, wr = A.rw(mn, ops)
                if wr & (1 << rx):
                    break
                j += 1
            if got:
                dead.update(got)
                for g in got:
                    sites.append({'at': i, 'second': g, 'reg': rx,
                                  'key': key,
                                  'line': t.lines[g].strip()})
                i = j
                continue
        i += 1
    out = [t.lines[k] for k in range(n) if k not in dead]
    tail = '\n' if text.endswith('\n') else ''
    return '\n'.join(out) + tail, sites


def transform(text):
    return one_pass(text)[0]
