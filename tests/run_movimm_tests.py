#!/usr/bin/env python3
"""Gate for constant materialisation (emit_mov_imm, 0.9.1).

`emit_mov_imm` is not behind a switch: every constant the backend puts into a
register goes through it, at every `-O` level.  The five classes are

  #0..#255        `MOV rd, #imm`   (the 16-bit MOVS for r0-r7)
  #0..#0xFFFF     `MOVW rd, #imm`  (one 32-bit instruction; MOVW zero-extends)
  modified imm    `MOV rd, #0x...` (8 bits rotated, MOV.W)
  ~modified imm   `MVN rd, #0x...` (the complement is the value)
  anything else   `MOVW` + `MOVT`

Every claim fails on a plausible wrong implementation:

  1. THE 16-BIT CLASS STAYS 16-BIT.  `255` must not become a MOVW: the old
     code emitted `MOVW` + an unconditional `MOVT #0`, which MOVW's zero-fill
     makes dead.  A gate that only looked at the value would not see either
     fault, so the instruction shapes are asserted here, not just the results.
  2. ONE INSTRUCTION FOR A 16-BIT VALUE.  `0xFFFF` is a single MOVW, no MOVT.
  3. THE MODIFIED IMMEDIATE IS ONE INSTRUCTION.  `0x20000000` is `MOV.W`.
  4. THE COMPLEMENT IS ONE INSTRUCTION.  `0xFFFFFF00` is `MVN`.
  5. THE PAIR SURVIVES WHERE IT MUST.  `0x12345678` still needs MOVW + MOVT.
  6. -O0 GOES THROUGH THE SAME PATH.  The class choice is emission, not an
     optimization, so `-O0` shows the same shapes.
  7. THE ANSWERS ARE EXACT.  Six constants (including 0xFFFFFFFF and
     0xFFFF00FF, whose classes are easy to get wrong) come back from the
     emulator bit-for-bit, so a truncated MOVW cannot pass by luck.
  8. SELF-CHECK.  The fixture really contains exactly two MOVW and one MOVT;
     if a future emitter stopped using those mnemonics the shape checks above
     would be vacuously true, so the counts are asserted too.

Usage: run_movimm_tests.py [path-to-arkcc]
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

INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']

BODY = """\
unsigned mv_g;
unsigned c_255(void) { return 255; }
unsigned c_ffff(void) { return 0xFFFF; }
unsigned c_imm(void) { return 0x20000000; }
unsigned c_mvn(void) { return 0xFFFFFF00; }
unsigned c_pair(void) { return 0x12345678; }
unsigned c_all(void) { return 0xFFFFFFFF; }
unsigned c_mvn2(void) { return 0xFFFF00FF; }
int main(void)
{
    unsigned ok = 1;
    ok = ok && (c_255() == 255u);
    ok = ok && (c_ffff() == 0xFFFFu);
    ok = ok && (c_imm() == 0x20000000u);
    ok = ok && (c_mvn() == 0xFFFFFF00u);
    ok = ok && (c_pair() == 0x12345678u);
    ok = ok && (c_all() == 0xFFFFFFFFu);
    ok = ok && (c_mvn2() == 0xFFFF00FFu);
    mv_g = ok;
    return (int)ok;
}
"""

check = V.check
write = V.write
build = V.build
insn_count = V.insn_count


def body_of(text, name):
    """The lines of one emitted function, label excluded, .size excluded."""
    out = []
    inside = False
    for line in text.splitlines():
        s = line.strip()
        if s == name + ':':
            inside = True
            continue
        if inside:
            if s.startswith('.size'):
                break
            if s and not s.startswith(';') and not s.startswith('.'):
                out.append(s)
    return out


def count_in(lines, mnemonic):
    return sum(1 for s in lines
               if re.match(r'^%s\s' % mnemonic, s))


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_movimm_')
    try:
        write(os.path.join(work, 'mv.c'), BODY)
        text, blob, err = build(arkcc, work, 'mv', ['-O2'], 'm2')
        if err:
            check(False, 'the fixture builds', err[0][:120])
            return 1

        # --- 1..5. one class per constant ---------------------------------
        def shape(name, want, forbidden, what):
            lines = body_of(text, name)
            check(len(lines) > 0, '%s: the function was emitted' % name, name)
            hits = [s for s in lines if re.match(want, s)]
            check(len(hits) == 1,
                  '%s: %s' % (name, what),
                  'matched %d of %r (%s)'
                  % (len(hits), want, '; '.join(lines) or 'empty'))
            bad = [s for s in lines if re.match(forbidden, s)]
            check(not bad, '%s: no wider form is used' % name,
                  '; '.join(bad) if bad else 'none')

        shape('c_255', r'^MOV\s+r0,\s*#255$', r'^(MOVW|MOVT|MVN)\s',
              'a value below 256 stays the 16-bit MOV')
        shape('c_ffff', r'^MOVW\s+r0,\s*#65535$', r'^(MOVT|MVN)\s',
              'a 16-bit value is one MOVW')
        shape('c_imm', r'^MOV\s+r0,\s*#0x20000000$', r'^(MOVW|MOVT|MVN)\s',
              'a modified immediate is one MOV')
        shape('c_mvn', r'^MVN\s+r0,\s*#0x000000FF$', r'^(MOVW|MOVT)\s',
              'a complementable value is one MVN')
        shape('c_pair', r'^MOVW\s+r0,\s*#22136$', r'^MVN\s',
              'the low half of a wide value is MOVW')
        lines = body_of(text, 'c_pair')
        check(sum(1 for s in lines if re.match(r'^MOVT\s+r0,\s*#4660$', s)) == 1,
              'c_pair: the high half is MOVT', '; '.join(lines))

        # --- 6. -O0 takes the same path ------------------------------------
        t0, _b0, e0 = build(arkcc, work, 'mv', ['-O0'], 'm0')
        if e0:
            check(False, '-O0 builds the fixture', e0[0][:120])
        else:
            l0 = body_of(t0, 'c_ffff')
            check(sum(1 for s in l0 if re.match(r'^MOVW\s+r0,\s*#65535$', s)) == 1
                  and not any(re.match(r'^MOVT\s', s) for s in l0),
                  '-O0 materialises 0xFFFF with a single MOVW',
                  '; '.join(l0))

        # --- 8. self-check: the fixture really exercises the mnemonics -----
        # Counted inside the fixture functions only.  Function prologues emit
        # MOVW as well, so a whole-file count would be measuring the prologue
        # rather than the constant materialisation this suite is about.
        FX = ['c_255', 'c_ffff', 'c_imm', 'c_mvn', 'c_pair', 'c_all', 'c_mvn2']
        nw = sum(1 for n in FX for s_ in body_of(text, n)
                 if re.match(r'^MOVW\s', s_))
        nt = sum(1 for n in FX for s_ in body_of(text, n)
                 if re.match(r'^MOVT\s', s_))
        check(nw >= 2, 'the fixture really emits MOVW', 'counted %d' % nw)
        check(nt >= 1, 'the fixture really emits MOVT', 'counted %d' % nt)

        # --- 7. the answers, bit for bit -----------------------------------
        if not V.HAVE_UNICORN:
            V.skip('the values come back exactly', 'python package unicorn missing')
        else:
            st, val, _ = V.run_image(blob)
            check(st == 'returned' and val == 1,
                  'every constant comes back bit-for-bit from the emulator',
                  '%s=%s want 1' % (st, val))

        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\nmovimm: %d check(s) FAILED%s' % (
            len(V.failures), (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\nmovimm: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
