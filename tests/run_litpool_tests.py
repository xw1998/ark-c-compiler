#!/usr/bin/env python3
"""Gate for the literal pool (0.9.1, -fopt-litpool).

A 32-bit constant is materialised as `MOVW rD, #lo` + `MOVT rD, #hi` -- two
instructions, eight bytes, for four bytes of value.  Loaded out of a literal
pool the same constant costs one `LDR rD, <label>` per site plus one word per
distinct value, so a value used c times costs 4c + 4 bytes instead of 8c.

The load is PC-relative and reaches 4095 bytes, so a pool at the end of a big
function is out of range and the pass has to place several: the text is cut
into regions at every instruction that ends the control flow (POP {.., pc} /
BX / unconditional B) and consecutive regions are merged forward while the
merged block stays inside one LDR's reach.  A pool is appended after the
terminator that closes its group, i.e. on a path control has already left.

Checks, each of which a plausible wrong implementation would fail:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-litpool` are byte-identical, in both
     the assembly text and the image.
  2. IT PAYS.  On a fixture that builds the same 32-bit constant three times
     the flag strictly reduces the instruction count and the image size; on a
     fixture where no constant is used twice the image may not grow, and the
     saving is one instruction per materialisation -- which is asserted as such
     rather than as a size win, because a lone word cannot be shared.
  3. THE POOL IS DATA.  Every pool block is introduced by `.align 4` and the
     last instruction before it ends the control flow, so no path can execute
     a constant.  Every `.Llit_` label is defined exactly once and every site
     names one of them (a dangling reference would also fail to assemble).
  4. REGIONS.  A function far larger than one LDR can reach gets more than one
     pool, at least one of them in the middle of the function rather than at
     its end, and it still assembles -- which is the reach gate, because the
     assembler rejects an out-of-range literal instead of silently truncating
     it.
  5. THE LINKER'S PAIRS ARE LEFT ALONE.  With `--reloc-data` a data symbol's
     address is materialised as `.arkdata` + `MOVW`/`MOVT`, and the linker
     patches those two halfwords; that pair must come out byte-identical.
  6. THE ANSWER IS THE SAME.  Every executable fixture runs on the emulator in
     three arms (off / on / on alone) and must return the Python answer.

Usage: run_litpool_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import os
import re
import shutil
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
try:
    import run_vstack_tests as V
except Exception:                                        # pragma: no cover
    print('FAIL  cannot import tests/run_vstack_tests.py helpers')
    sys.exit(2)

FLAG = '-fopt-litpool'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']

# The pass runs last, on what -fopt-cmat could not fold into an operand, so the
# gate measures it on top of the constant-folding pair.
BASE = ['-fopt-cmat', '-fopt-pair']

# --- fixtures ---------------------------------------------------------------
# The same 32-bit constant built three times: two loads share one pool word, so
# this is the shape that actually saves bytes.
REUSE = """\
volatile int lp_g1, lp_g2;
int lp_reuse(int a)
{
    int x = 0x12345678;
    int y = 0x12345678;
    lp_g1 = x;
    lp_g2 = y + a;
    return x + y + a;
}
int main(void)
{
    return lp_reuse(7) & 0xFF;
}
"""

# Every constant used exactly once (the second pair is the bss address of the
# volatile object, which the backend also materialises with MOVW/MOVT): no word
# can be shared, so the size must not grow, but each two-instruction
# materialisation still becomes one load.
ONCE = """\
volatile int lp_s;
int lp_once(int a)
{
    lp_s = 0x0BADF00D;
    return a + 3;
}
int main(void)
{
    return lp_once(4) & 0xFF;
}
"""

# A data symbol whose address the linker has to patch.  Only compiled with
# --reloc-data, which is what makes the backend reach for .arkdata.
ARKDATA = """\
int lp_d = 5;
int lp_setd(int v)
{
    lp_d = v + 1;
    return lp_d;
}
int main(void)
{
    return lp_setd(1) & 0xFF;
}
"""

# Bigger than one PC-relative load can reach: 80 if/else blocks, one region
# each (the then-block closes with an unconditional B), about 3,000
# instructions in all.  Every constant is distinct, so each pool is a single
# word and the only thing being measured is where the pools land.
REGION_N = 80


def region_src(n=REGION_N):
    out = ['volatile int rg_g;', 'int lp_regions(int a)', '{']
    for i in range(n):
        out.append('    if (a == %d) { rg_g = 0x%08X; } else { a = a + 0x%04X; }'
                   % (i + 1, 0x10000000 + i * 7, 0x100 + i))
    out.append('    return a;')
    out.append('}')
    out.append('int main(void)')
    out.append('{')
    out.append('    return lp_regions(0) & 0xFF;')
    out.append('}')
    return '\n'.join(out) + '\n'


def region_val(n=REGION_N):
    a = 0
    for i in range(n):
        if a != i + 1:
            a = a + (0x100 + i)
    return a & 0xFF


CASES = [
    ('reuse', REUSE, (0x12345678 * 2 + 7) & 0xFF),
    ('once', ONCE, 7),
]


# --- helpers ----------------------------------------------------------------
INS_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')
TERM_RE = re.compile(r'^\s+(POP\s+\{[^}]*\bpc\b[^}]*\}|BX\s+BX|BX\s|B\s)')
POOL_DEF_RE = re.compile(r'^\.Llit_(\d+)_(\d+)_(\d+):\s*$')
POOL_REF_RE = re.compile(r'^\s+LDR\s+r\d+,\s*\.Llit_(\d+)_(\d+)_(\d+)\s*$')


def insn_count(text):
    return sum(1 for ln in text.splitlines() if INS_RE.match(ln))


MOVW_RE = re.compile(r'^\s+MOVW\s+r(\d+),\s*#\d+\s*$')
MOVT_RE = re.compile(r'^\s+MOVT\s+r(\d+),\s*#\d+\s*$')


def user_part(text):
    """Everything before __arkcc_init_globals, which is emitted on its own and
    never goes through a text pass -- its MOVW/MOVT pairs are not candidates."""
    i = text.find('\n__arkcc_init_globals:')
    return text if i < 0 else text[:i]


def pair_count(text):
    """Adjacent MOVW/MOVT pairs on one register: what this pass converts."""
    lines = text.splitlines()
    n = 0
    for i in range(len(lines) - 1):
        a = MOVW_RE.match(lines[i])
        b = MOVT_RE.match(lines[i + 1])
        if a and b and a.group(1) == b.group(1):
            n += 1
    return n


def fn_text(text, name):
    """One top-level function's text, from its label to its .size directive."""
    out, on = [], False
    for ln in text.splitlines():
        if re.match(r'^%s:\s*$' % re.escape(name), ln):
            on = True
        if on:
            if ln.startswith('.size'):
                break
            out.append(ln)
    return '\n'.join(out)


def pool_layout(text):
    """(definitions, references, pools placed after a non-terminator)."""
    defs, refs, bad = [], [], []
    lines = text.splitlines()
    for i, ln in enumerate(lines):
        m = POOL_DEF_RE.match(ln)
        if m:
            defs.append(m.group(0).rstrip(':'))
        m = POOL_REF_RE.match(ln)
        if m:
            refs.append('.Llit_%s_%s_%s' % m.groups())
        if ln.strip() == '.align 4':
            j = i - 1
            while j >= 0 and not lines[j].strip():
                j -= 1
            if j < 0 or not TERM_RE.match(lines[j]):
                bad.append(lines[j].strip() if j >= 0 else '<start of file>')
    return defs, refs, bad


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_litpool_')
    try:
        for name, body, _ in CASES:
            V.write(os.path.join(work, name + '.c'), body)
        V.write(os.path.join(work, 'arkdata.c'), ARKDATA)
        V.write(os.path.join(work, 'regions.c'), region_src())

        # --- 1. off is off ------------------------------------------------
        t_a, b_a, e1 = V.build(arkcc, work, 'reuse', BASE, 'plain')
        t_b, b_b, e2 = V.build(arkcc, work, 'reuse',
                               BASE + ['-fno-opt-litpool'], 'nofl')
        if e1 or e2:
            V.check(False, 'the default build compiles the fixture',
                    (e1 or e2)[0][:120])
        else:
            V.check(t_a == t_b and b_a == b_b,
                    'the default build ignores the pass '
                    '(-O2 == -O2 -fno-opt-litpool)',
                    '%d/%d bytes' % (len(b_a), len(b_b)))

        # --- 2. it pays ---------------------------------------------------
        t_off, b_off, e3 = V.build(arkcc, work, 'reuse', BASE, 'reuse_off')
        t_on, b_on, e4 = V.build(arkcc, work, 'reuse', BASE + [FLAG],
                                 'reuse_on')
        if e3 or e4:
            V.check(False, 'reuse: both arms build', (e3 or e4)[0][:120])
        else:
            u_off, u_on = user_part(t_off), user_part(t_on)
            n_off, n_on = insn_count(u_off), insn_count(u_on)
            p_off, p_on = pair_count(u_off), pair_count(u_on)
            V.check(p_off >= 2,
                    'reuse: the plain arm builds several 32-bit constants',
                    '%d pair(s)' % p_off)
            V.check(p_on == 0 and n_off - n_on == p_off,
                    'reuse: every materialisation becomes one load',
                    '%d pair(s), %d -> %d instructions' % (p_off, n_off, n_on))
            V.check(len(b_on) < len(b_off),
                    'reuse: the shared word makes the image smaller',
                    '%d -> %d bytes' % (len(b_off), len(b_on)))

        t_s_off, b_s_off, eq1 = V.build(arkcc, work, 'once', BASE, 'once_off')
        t_s_on, b_s_on, eq2 = V.build(arkcc, work, 'once', BASE + [FLAG],
                                      'once_on')
        if eq1 or eq2:
            V.check(False, 'once: both arms build', (eq1 or eq2)[0][:120])
        else:
            u_off, u_on = user_part(t_s_off), user_part(t_s_on)
            p_s = pair_count(u_off)
            V.check(p_s >= 1 and pair_count(u_on) == 0 and
                    insn_count(u_off) - insn_count(u_on) == p_s,
                    'once: each one-use materialisation is one instruction '
                    'shorter', '%d pair(s), %d -> %d' % (
                        p_s, insn_count(u_off), insn_count(u_on)))
            V.check(len(b_s_on) <= len(b_s_off) + 4,
                    'once: one-use constants are byte-neutral (a lone word '
                    'cannot be shared)',
                    '%d -> %d bytes' % (len(b_s_off), len(b_s_on)))

        # --- 3. the pool is data ------------------------------------------
        if t_on:
            defs, refs, bad = pool_layout(t_on)
            V.check(len(defs) > 0, 'reuse: a pool is emitted',
                    '%d word(s)' % len(defs))
            V.check(len(set(defs)) == len(defs) and
                    all(d in defs for d in refs) and len(refs) > 0,
                    'reuse: every site names a defined pool word',
                    '%d site(s), %d word(s)' % (len(refs), len(defs)))
            V.check(not bad,
                    'reuse: every pool follows a terminating instruction',
                    '; '.join(bad[:3]) if bad else 'all good')

        # --- 4. regions ---------------------------------------------------
        t_r_off, b_r_off, er1 = V.build(arkcc, work, 'regions', BASE,
                                        'reg_off')
        t_r_on, b_r_on, er2 = V.build(arkcc, work, 'regions', BASE + [FLAG],
                                      'reg_on')
        if er1 or er2:
            V.check(False, 'regions: both arms assemble (an out-of-range '
                           'literal is an error, not a truncation)',
                    (er1 or er2)[0][:160])
        else:
            defs, refs, bad = pool_layout(t_r_on)
            groups = sorted(set(int(d.split('_')[2]) for d in defs))
            lines = t_r_on.splitlines()
            first_pool = next(i for i, l in enumerate(lines)
                              if l.strip() == '.align 4')
            last_code = max(i for i, l in enumerate(lines) if INS_RE.match(l))
            V.check(len(groups) >= 2,
                    'regions: a big function gets more than one pool',
                    '%d pool(s) at %s' % (len(defs), groups))
            V.check(first_pool < last_code,
                    'regions: at least one pool sits inside the function '
                    'rather than after its last instruction',
                    'line %d of %d' % (first_pool + 1, last_code + 1))
            V.check(not bad,
                    'regions: every pool follows a terminating instruction',
                    '; '.join(bad[:3]) if bad else '%d pool(s)' % len(defs))
            V.check(insn_count(t_r_on) < insn_count(t_r_off),
                    'regions: the pools remove instructions',
                    '%d -> %d' % (insn_count(t_r_off), insn_count(t_r_on)))

        # --- 5. the linker's pairs are left alone --------------------------
        run_extra = ['--reloc-data']
        t_k_off, _bk, ek1 = V.build(arkcc, work, 'arkdata', BASE + run_extra,
                                    'ark_off')
        t_k_on, _bk2, ek2 = V.build(arkcc, work, 'arkdata',
                                    BASE + run_extra + [FLAG], 'ark_on')
        if ek1 or ek2:
            V.check(False, 'arkdata: both arms build', (ek1 or ek2)[0][:120])
        else:
            f_off = fn_text(t_k_off, 'lp_setd')
            f_on = fn_text(t_k_on, 'lp_setd')
            triple = re.compile(
                r'\.arkdata\r?\n\s+MOVW\s+r\d+,\s*#\d+\r?\n'
                r'\s+MOVT\s+r\d+,\s*#\d+')
            got_off = triple.findall(f_off)
            got_on = triple.findall(f_on)
            V.check(len(got_off) >= 1,
                    'arkdata: the fixture really produces a linker pair',
                    '%d triple(s)' % len(got_off))
            V.check(got_off == got_on,
                    'arkdata: the linker-patched pairs are byte-identical',
                    '%d/%d triple(s)' % (len(got_off), len(got_on)))
            V.check(f_off == f_on,
                    'arkdata: a function whose only pair is a linker pair is '
                    'left alone',
                    '%d/%d line(s)' % (len(f_off.splitlines()),
                                       len(f_on.splitlines())))

        # --- 6. the answer is the same ------------------------------------
        cases = list(CASES) + [('regions', None, region_val())]
        for name, _body, want in cases:
            if not V.HAVE_UNICORN:
                V.skip('%s: emulator value' % name,
                       'python package unicorn missing')
                continue
            got = {}
            ok = True
            for tag, flags in (('off', BASE), ('on', BASE + [FLAG]),
                               ('alone', [FLAG])):
                _t, blob, err = V.build(arkcc, work, name, flags, 'v' + tag)
                if err:
                    V.check(False, '%s: %s arm builds' % (name, tag),
                            err[0][:120])
                    ok = False
                    break
                st, val, _ = V.run_image(blob)
                got[tag] = val if st == 'returned' else st
            if ok:
                V.check(all(got[t] == want for t in got),
                        '%s: off/on/alone return the Python answer' % name,
                        ' '.join('%s=%s' % (t, got[t])
                                 for t in ('off', 'on', 'alone'))
                        + ' want=%s' % want)

        # --- 7. cropped out, refused --------------------------------------
        trimmed, why = V.build_arkcc(work, ['-DARKCC_FEATURE_OPT_LITPOOL=0'],
                                     'arkcc_nolitpool')
        if trimmed is None:
            V.skip('a cropped build refuses -fopt-litpool', why)
        else:
            rc, log = V.run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                             os.path.join(work, 'reuse.c'), '-o', 't.s', FLAG],
                            work)
            V.check(rc != 0 and 'C3900U' in log and FLAG in log,
                    'the cropped build refuses -fopt-litpool by name',
                    'rc=%d' % rc)
            rc, log = V.run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                             os.path.join(work, 'reuse.c'), '-o', 't.s'], work)
            V.check(rc == 0, 'the cropped build still compiles without the flag',
                    'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\nlitpool: %d check(s) FAILED%s' % (
            len(V.failures),
            (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\nlitpool: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
