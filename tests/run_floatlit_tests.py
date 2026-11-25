#!/usr/bin/env python
"""Gate: floating literals must be converted exactly (one rounding, no drift).

What the compiler promises
--------------------------
`0.1`, `123456789012345678.0`, `1e-320` and `0x1.0000000000000800000001p0`
denote *specific* IEEE-754 values: the nearest one to the exact decimal/hex
value, ties to even.  The same holds for a literal with an `f` suffix, which
must be rounded once, straight to binary32.

What this gate has to catch
---------------------------
The lexer used to accumulate digits in `double` (`v = v * 10 + d`), which
rounds at every step, and it built hex floats the same way.  So:

  * 123456789012345678.0 came out 0x437b69b4ba630f36 instead of ...0f35;
  * 0x1.0000000000000800000001p0 came out 1.0 instead of the next double up.

Both were 1-ulp wrong answers that no other gate noticed, because they only
show up on long mantissas.  This gate reads the emitted constant pool and
compares every bit pattern against Python's correctly rounded value.

Anti-false-green
----------------
  * the pool entry for a literal is located through the `LDR r0, =.L_dbl_k`
    that the generated function actually contains, so a stale pool index or a
    wrong function body cannot pass by accident;
  * every function has to end up with a pool entry (a pool that silently
    became empty is red, not "nothing to compare");
  * the case table is checked against a *naive* digit accumulator first: at
    least one case must disagree with it, otherwise the table would not have
    caught the bug this gate exists for (self check, `naive_hits`);
  * single-precision expectations come from an independent exact rounding
    routine written in the script (Fractions), which is itself cross-checked
    against hard-coded bit patterns.

Usage: run_floatlit_tests.py [path-to-arkcc]
Exit 0 = every literal arrived intact, 1 = a mismatch, 2 = setup problem.
"""
import os
import random
import re
import struct
import subprocess
import sys
import tempfile
from fractions import Fraction

PY = sys.executable
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)


def bits64(v):
    return struct.unpack('<Q', struct.pack('<d', v))[0]


def bits32(v):
    return struct.unpack('<I', struct.pack('<f', v))[0]


# ---- independent exact reference for binary32 (the gate must not trust the
# ---- thing it is checking, so this is Fractions arithmetic, not float())
def floor_log2(fr):
    e = fr.numerator.bit_length() - fr.denominator.bit_length()
    while Fraction(2) ** (e + 1) <= fr:
        e += 1
    while Fraction(2) ** e > fr:
        e -= 1
    return e


def ref_f32(fr, neg_zero=False):
    neg = fr < 0 or (fr == 0 and neg_zero)
    if fr < 0:
        fr = -fr
    if fr == 0:
        return 0x80000000 if neg else 0
    e = floor_log2(fr)
    if e > 127:
        return (0x80000000 if neg else 0) | 0x7F800000
    q = fr / Fraction(2) ** (e - 23)
    n = q.numerator // q.denominator
    rem = q - n
    if rem > Fraction(1, 2) or (rem == Fraction(1, 2) and (n & 1)):
        n += 1
    if n == 1 << 24:
        n >>= 1
        e += 1
    if e > 127:
        return (0x80000000 if neg else 0) | 0x7F800000
    if e < -126:
        q = fr / Fraction(2) ** (-149)
        n = q.numerator // q.denominator
        rem = q - n
        if rem > Fraction(1, 2) or (rem == Fraction(1, 2) and (n & 1)):
            n += 1
        if n >= 1 << 23:
            return (0x80000000 if neg else 0) | (1 << 23)
        return n | (0x80000000 if neg else 0)
    return ((e + 127) << 23) | (n - (1 << 23)) | (0x80000000 if neg else 0)


# ---- the naive accumulator the lexer used to have, kept as the self check
def naive_decimal(text):
    s = text
    neg = s.startswith('-')
    if neg:
        s = s[1:]
    intp = 0.0
    fracp = 0.0
    scale = 1.0
    i = 0
    while i < len(s) and s[i].isdigit():
        intp = intp * 10.0 + int(s[i])
        i += 1
    if i < len(s) and s[i] == '.':
        i += 1
        while i < len(s) and s[i].isdigit():
            fracp = fracp * 10.0 + int(s[i])
            scale *= 10.0
            i += 1
    v = intp + fracp / scale
    if i < len(s) and s[i] in 'eE':
        i += 1
        eneg = False
        if i < len(s) and s[i] in '+-':
            eneg = s[i] == '-'
            i += 1
        ev = 0
        while i < len(s) and s[i].isdigit():
            ev = ev * 10 + int(s[i])
            i += 1
        v = v * (10.0 ** (-ev if eneg else ev))
    return -v if neg else v


HARD_DEC = [
    "123456789012345678.0",          # the 1-ulp regression
    "0.1", "0.2", "0.3", "1.0", "2.5",
    "1e-320", "4.9406564584124654e-324", "2.4703282292062328e-324",
    "2.4703282292062327e-324", "1e-323", "3e-324", "2e-324",
    "2.2250738585072011e-308", "2.2250738585072012e-308",
    "1.7976931348623157e308", "1.7976931348623159e308",
    "1.00000000000000011102230246251565404236316680908203125",
    "9007199254740992.5", "9007199254740993.0",
    "1.2345678901234567890123456789012345678901234567890e-17",
    "123456789012345678901234567890123456789012345678901234567890e0",
]
HARD_HEX = [
    "0x1.0000000000000800000001p0",  # the other 1-ulp regression
    "0x1.0000000000001800000001p0",
    "0x1.0000000000000810000000p0",
    "0x1.fffffffffffff8p0", "0x1.fffffffffffffp1023", "0x1p-1074",
    "0x1.921fb54442d18p+1", "0x0.0000000000001p0", "0x1p1024",
]
HARD_F32 = [
    "0.1", "16777217", "16777216.5", "1.1754942e-38", "7.038531e-26",
    "1.401298464324817e-45", "3.4028236e38",
    "1.0000000596046447753906251",
]

LDR_RE = re.compile(r'LDR r0, =\.L_(dbl|flt)_(\d+)')
FUNC_RE = re.compile(r'^([A-Za-z_]\w*):$')
DBL_DEF_RE = re.compile(r'^\.L_dbl_(\d+):$')
FLT_DEF_RE = re.compile(r'^\.L_flt_(\d+):$')
WORD_RE = re.compile(r'^\s*\.word 0x([0-9a-fA-F]+)$')


def run_arkcc(arkcc, src, out):
    r = subprocess.run([arkcc, '-S', '-target', 'arm', '-o', out, src],
                       capture_output=True, text=True)
    if r.returncode != 0:
        return None, (r.stdout or '') + (r.stderr or '')
    with open(out, 'r', encoding='utf-8') as f:
        return f.read(), ''


def parse_pools(text):
    """label -> bit pattern, function -> (kind, label), function -> body."""
    pools = {'dbl': {}, 'flt': {}}
    funcs = {}
    bodies = {}
    cur = None
    lines = text.splitlines()
    i = 0
    while i < len(lines):
        ln = lines[i]
        m = FUNC_RE.match(ln)
        if m and not ln.startswith('.L'):
            cur = m.group(1)
            bodies[cur] = []
            i += 1
            continue
        m = DBL_DEF_RE.match(ln)
        if m:
            lo = WORD_RE.match(lines[i + 1]).group(1)
            hi = WORD_RE.match(lines[i + 2]).group(1)
            pools['dbl'][int(m.group(1))] = (int(hi, 16) << 32) | int(lo, 16)
            i += 3
            continue
        m = FLT_DEF_RE.match(ln)
        if m:
            w = WORD_RE.match(lines[i + 1]).group(1)
            pools['flt'][int(m.group(1))] = int(w, 16)
            i += 2
            continue
        m = LDR_RE.search(ln)
        if m and cur:
            funcs[cur] = (m.group(1), int(m.group(2)))
        if cur is not None:
            bodies[cur].append(ln)
        i += 1
    return pools, funcs, bodies


def check_batch(arkcc, workdir, index, kind, lits, expect, failures):
    """kind: 'dbl' or 'flt'.  lits: text.  expect: list of bit patterns."""
    src = os.path.join(workdir, 'lit%d_%s.c' % (index, kind))
    asm = os.path.join(workdir, 'lit%d_%s.s' % (index, kind))
    with open(src, 'w', encoding='utf-8') as f:
        f.write('double use_d(double);\nfloat use_f(float);\n')
        for i, lit in enumerate(lits):
            if kind == 'dbl':
                f.write('double p%d(double x){ return x + (%s); }\n' % (i, lit))
            else:
                f.write('float p%d(float x){ return x + (%sf); }\n' % (i, lit))
    text, err = run_arkcc(arkcc, src, asm)
    if text is None:
        failures.append('compile failed for %s batch %d: %s'
                        % (kind, index, err.strip()[:400]))
        return
    pools, funcs, bodies = parse_pools(text)
    for i, (lit, exp) in enumerate(zip(lits, expect)):
        neg = lit.startswith('-')
        name = 'p%d' % i
        if name not in funcs:
            failures.append('%s %r: no constant load in %s' % (kind, lit, name))
            continue
        got_kind, label = funcs[name]
        if got_kind != kind:
            failures.append('%s %r: loaded .L_%s_%d instead'
                            % (kind, lit, got_kind, label))
            continue
        got = pools[kind].get(label)
        if got is None:
            failures.append('%s %r: .L_%s_%d has no definition'
                            % (kind, lit, kind, label))
            continue
        if neg:
            # a leading '-' is a runtime sign fix-up on the magnitude, not a
            # different pool entry (the lexer only ever sees the digits)
            if got != exp:
                failures.append('%s %r: pool holds %0*x, want magnitude %0*x'
                                % (kind, lit, 8 if kind == 'flt' else 16, got,
                                   8 if kind == 'flt' else 16, exp))
            elif not re.search(r'EOR\s+\w+,\s*\w+,\s*#0x80000000',
                               '\n'.join(bodies.get(name, []))):
                failures.append('%s %r: negative literal without a sign fix-up'
                                % (kind, lit))
        elif got != exp:
            failures.append('%s %r: got %0*x, want %0*x'
                            % (kind, lit, 8 if kind == 'flt' else 16, got,
                               8 if kind == 'flt' else 16, exp))


def main(argv):
    arkcc = argv[1] if len(argv) > 1 else os.path.join(ROOT, 'arkcc.exe')
    if not os.path.exists(arkcc):
        print('setup: %s not found' % arkcc)
        return 2

    failures = []
    checks = 0

    # ---- self check: the table must disagree with the old accumulator
    naive_hits = 0
    for lit in HARD_DEC:
        if naive_decimal(lit) != float(lit):
            naive_hits += 1
    if naive_hits == 0:
        print('SELF CHECK FAILED: no case distinguishes exact conversion from '
              'the naive digit accumulator; the table proves nothing')
        return 1
    print('self check: %d hard decimal case(s) disagree with the naive '
          'accumulator (the old bug) -- ok' % naive_hits)

    # ---- self check: the reference f32 routine reproduces known patterns
    for lit, want in [("0.1", 0x3DCCCCCD), ("16777217", 0x4B800000),
                      ("1.0", 0x3F800000), ("0x1p-149", 0x00000001)]:
        fr = Fraction(float.fromhex(lit)) if lit.startswith('0x') else Fraction(lit)
        got = ref_f32(fr)
        if got != want:
            print('SELF CHECK FAILED: ref_f32(%s) = %08x, want %08x'
                  % (lit, got, want))
            return 1
    print('self check: binary32 reference reproduces known patterns -- ok')

    dec = list(HARD_DEC)
    hx = list(HARD_HEX)
    rnd = random.Random(20261125)
    for _ in range(220):
        n = rnd.randint(1, 22)
        digits = ''.join(rnd.choice('0123456789') for _ in range(n))
        t = digits[0] + ('.' + digits[1:] if n > 1 else '')
        t += 'e' + str(rnd.randint(-330, 310))
        if rnd.random() < 0.2:
            t = '-' + t
        dec.append(t)
    for _ in range(80):
        n = rnd.randint(1, 20)
        digits = ''.join(rnd.choice('0123456789abcdef') for _ in range(n))
        t = '0x' + digits[0] + ('.' + digits[1:] if n > 1 else '')
        t += 'p' + str(rnd.randint(-1080, 1040))
        hx.append(t)
    f32 = list(HARD_F32)
    for _ in range(80):
        n = rnd.randint(1, 18)
        digits = ''.join(rnd.choice('0123456789') for _ in range(n))
        f32.append(digits[0] + ('.' + digits[1:] if n > 1 else '') +
                   'e' + str(rnd.randint(-45, 38)))

    # C requires a floating constant to have a '.' or an exponent before the
    # suffix: `1f` is an invalid suffix on an integer constant, so the table
    # spells the bare integers as `1.0f` instead of relying on an extension.
    f32 = [lit if ('.' in lit or 'e' in lit or 'E' in lit) else lit + '.0'
           for lit in f32]

    workdir = tempfile.mkdtemp(prefix='floatlit_')
    try:
        batches = [('dbl', dec), ('dbl', hx), ('flt', f32)]
        for kind, lits in batches:
            exp = []
            # a leading '-' is a sign fix-up on the emitted magnitude
            for lit in lits:
                mag = lit[1:] if lit.startswith('-') else lit
                if kind == 'dbl':
                    try:
                        exp.append(bits64(float.fromhex(mag)
                                          if mag.startswith('0x')
                                          else float(mag)))
                    except OverflowError:
                        exp.append(bits64(float('inf')))
                else:
                    exp.append(ref_f32(Fraction(mag)))
            step = 60
            for k in range(0, len(lits), step):
                chunk = lits[k:k + step]
                cexp = exp[k:k + step]
                check_batch(arkcc, workdir, k // step, kind, chunk, cexp,
                            failures)
                checks += len(chunk)
    finally:
        try:
            for name in os.listdir(workdir):
                os.unlink(os.path.join(workdir, name))
            os.rmdir(workdir)
        except OSError:
            pass

    if failures:
        for f in failures[:20]:
            print('FAIL ' + f)
        print('%d of %d literals did not arrive intact'
              % (len(failures), checks))
        return 1
    print('%d floating literals round-trip bit for bit (%d decimal, %d hex, '
          '%d binary32)' % (checks, len(dec), len(hx), len(f32)))
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))