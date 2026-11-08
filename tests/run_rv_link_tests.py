#!/usr/bin/env python3
"""riscv32 object gate: `-c` + `-link` must produce one runnable flat image.

The riscv32 backend only ever produced a whole-program flat image before this
gate existed: every translation unit became its own image at 0x08000000, so a
program split across files could not be built at all.  This gate holds the new
object mode to what it claims:

  splitting   two translation units that call / read / write across the border
              must link into one image and run, with `auipc`+`addi`/`jalr` pairs
              rewritten to match where each object really landed.
  export      only names a source actually exports (`.globl`, or a non-static C
              definition) may cross the border.  Two translation units that each
              define their own `static helper` must not collide -- that is what
              the export table is for, and a linker that exports every label
              would silently bind one file's helper into the other's calls.
  abs32       `.word sym` is a full 32-bit absolute address, not a PC-relative
              one, so it needs its own relocation type and it must be resolved
              against the image base, not against the site address.
  refusal     an unresolved symbol, or a branch that would have to cross an
              object boundary, must fail the build *and* leave no image behind.
              A half-linked image that still exits 0 is exactly the wrong answer
              this project forbids.  RV32I has no relocatable 32-bit branch, so
              "call it as a function instead" is the honest response.
  isa         signing an object with its target ISA and refusing to mix them:
              linking riscv32 objects without `-target riscv32` used to be
              accepted and would have been relocated as ARM, silently.

The per-object base printed by `-v` plus ARKCC_DUMP_SYMS is how the runtime arm
turns an object-relative offset into an address; a flat image carries no symbol
table of its own.

Usage (from the repository root):
    python tests/run_rv_link_tests.py
"""
import argparse
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
TMP = os.path.join(ROOT, 'build_rv_link')

IMAGE_BASE = 0x08000000
STACK_TOP = 0x20080000
HANG = 0x200FF000

# A case is: name, list of (filename, source), expected a0.
# Sources are chosen so that the answer is arithmetic the compiler cannot fake:
# every expected value is written out by hand from the C, never taken from a run.
CASES = [
    ("cross_call",
     [("a.c", """
extern int add(int a, int b);
int main(void) { return add(20, 22); }
"""),
      ("b.c", """
int add(int a, int b) { return a + b; }
""")],
     42),

    ("extern_global",
     [("g1.c", """
extern int gv;
int main(void) { return gv; }
"""),
      ("g2.c", """
int gv = 37;
""")],
     37),

    ("cross_data",
     [("d1.c", """
int tbl[3] = {10, 20, 30};
int main(void);
"""),
      ("d2.c", """
extern int tbl[];
int sum(void) {
    int i, s = 0;
    for (i = 0; i < 3; i++) s += tbl[i];
    return s;
}
int main(void) { return sum(); }
""")],
     60),

    ("static_names",
     [("s1.c", """
extern int other(void);
static int helper(int x) { return x * 3; }
int main(void) { return helper(4) + other(); }
"""),
      ("s2.c", """
static int helper(int x) { return x + 100; }
int other(void) { return helper(1); }
""")],
     113),                         # 4*3 + (1+100)

    ("abs32_fnptr",
     [("w1.s", """
    .data
    .globl tab
tab:
    .word target
    .text
    .globl main
main:
    la t0, tab
    lw t0, 0(t0)
    jr t0
"""),
      ("w2.s", """
    .text
    .globl target
target:
    li a0, 55
    ret
""")],
     55),

    ("three_objects",
     [("m.c", """
extern int twice(int);
extern int base;
int main(void) { return twice(base) + 1; }
"""),
      ("n.c", """
int base = 21;
"""),
      ("o.c", """
extern int base;
int twice(int x) { return x * 2; }
""")],
     43),                          # 21*2 + 1
]

REJECTS = [
    # name, sources, expected substring
    ("unresolved", [("u.c", """
extern int missing(int);
int main(void) { return missing(3); }
""")], "unresolved symbol"),

    ("cross_branch", [("br.s", """
    .text
    .globl main
main:
    j elsewhere
""")], "cannot cross objects"),
]


def write(path, text):
    with open(path, 'w', newline='\n', encoding='utf-8') as f:
        f.write(text)


class Gate:
    def __init__(self, arkcc):
        self.arkcc = arkcc
        self.ok = 0
        self.bad = 0

    def run(self, cmd, env=None):
        return subprocess.run(cmd, capture_output=True, text=True,
                              errors='replace', env=env)

    @staticmethod
    def msg(out):
        """Diagnostics only.  `-v` prepends the config banner, so compare a
        refusal's reason against everything but that banner -- matching on a
        prefix of the banner would pass every case for the wrong reason."""
        keep = [ln for ln in out.splitlines()
                if ln.strip() and not ln.startswith('  ')
                and not ln.strip().startswith('[arkcc] config:')]
        return '\n'.join(keep)

    def compile_obj(self, src, obj):
        """Compile one translation unit to an object.  Returns (syms, error)."""
        if os.path.exists(obj):
            os.remove(obj)
        env = dict(os.environ)
        env['ARKCC_DUMP_SYMS'] = '1'
        r = self.run([self.arkcc, '-target', 'riscv32', '-c', src, '-o', obj],
                     env=env)
        out = r.stdout + r.stderr
        if r.returncode != 0:
            return None, 'compile of %s failed: %s' % (
                os.path.basename(src), self.msg(out))
        if not os.path.exists(obj):
            return None, ('compile of %s reported success but wrote no object'
                          % os.path.basename(src))
        syms = {}
        for ln in out.splitlines():
            m = re.match(r'^RV_SYM\s+(\S+)\s+0x([0-9A-Fa-f]+)$', ln.strip())
            if m:
                # Object-mode symbols are printed relative to the flat image
                # base, which the linker will supply; keep the bare offset.
                syms[m.group(1)] = int(m.group(2), 16) - IMAGE_BASE
        return syms, ''

    def link(self, objs, img, target=True):
        """Link objects.  Returns (blob|None, bases, error)."""
        if os.path.exists(img):
            os.remove(img)
        cmd = [self.arkcc] + (['-target', 'riscv32'] if target else []) + \
              ['-link'] + objs + ['-o', img, '-v']
        r = self.run(cmd)
        out = r.stdout + r.stderr
        bases = {}
        for ln in out.splitlines():
            m = re.match(r'^\[link\] object (\d+): base 0x([0-9A-Fa-f]+),',
                         ln.strip())
            if m:
                bases[int(m.group(1))] = int(m.group(2), 16)
        if r.returncode != 0:
            return None, bases, self.msg(out)
        if not os.path.exists(img):
            return None, bases, 'the link reported success but wrote no image'
        return open(img, 'rb').read(), bases, ''

    def build(self, name, sources):
        """Compile all sources then link them.  Returns (blob, main_addr, files)."""
        objs = []
        per_obj_syms = []
        for fname, text in sources:
            src = os.path.join(TMP, name + '_' + fname)
            write(src, text)
            obj = src[:-2] + '.ark_obj'
            syms, err = self.compile_obj(src, obj)
            if syms is None:
                return None, None, [], err
            objs.append(obj)
            per_obj_syms.append(syms)
        img = os.path.join(TMP, name + '.bin')
        blob, bases, err = self.link(objs, img)
        if blob is None:
            return None, None, objs, err
        main_addr = None
        for i, syms in enumerate(per_obj_syms):
            if 'main' in syms:
                if i not in bases:
                    return None, None, objs, ('no base reported for object %d; '
                                              'cannot locate main' % i)
                main_addr = IMAGE_BASE + bases[i] + syms['main']
                break
        if main_addr is None:
            return None, None, objs, 'no object defines main'
        return blob, main_addr, objs, ''

    def execute(self, blob, entry):
        from unicorn import Uc, UcError, UC_ARCH_RISCV, UC_MODE_RISCV32
        from unicorn.riscv_const import (UC_RISCV_REG_A0, UC_RISCV_REG_PC,
                                         UC_RISCV_REG_RA, UC_RISCV_REG_SP)
        uc = Uc(UC_ARCH_RISCV, UC_MODE_RISCV32)
        uc.mem_map(IMAGE_BASE, 0x100000)
        uc.mem_write(IMAGE_BASE, blob)
        uc.mem_map(0x20000000, 0x100000)
        uc.mem_write(HANG, bytes([0x6f, 0x00, 0x00, 0x00]))   # j .
        uc.reg_write(UC_RISCV_REG_SP, STACK_TOP)
        uc.reg_write(UC_RISCV_REG_RA, HANG)
        try:
            uc.emu_start(entry, HANG, count=4000000)
        except UcError as e:
            return None, 'unicorn: %s at %#x' % (e, uc.reg_read(UC_RISCV_REG_PC))
        return uc.reg_read(UC_RISCV_REG_A0) & 0xFF, ''

    def fail(self, name, msg):
        print('FAIL %-22s %s' % (name, msg))
        self.bad += 1


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    arkcc = os.path.abspath(args.arkcc)
    if not os.path.exists(arkcc):
        print('no such compiler: %s' % arkcc)
        return 2
    os.makedirs(TMP, exist_ok=True)
    gate = Gate(arkcc)

    for name, sources, want in CASES:
        blob, entry, objs, err = gate.build(name, sources)
        if blob is None:
            gate.fail(name, 'build: %s' % err)
            continue
        got, err = gate.execute(blob, entry)
        if got is None:
            gate.fail(name, 'run: %s' % err)
            continue
        if got != want:
            gate.fail(name, 'arkcc=%r want=%r' % (got, want))
            continue
        print('PASS %-22s %d' % (name, got))
        gate.ok += 1

    # --- refusal arms -------------------------------------------------------
    for name, sources, needle in REJECTS:
        objs = []
        broken = None
        for fname, text in sources:
            src = os.path.join(TMP, name + '_' + fname)
            write(src, text)
            obj = src[:-2] + '.ark_obj'
            syms, err = gate.compile_obj(src, obj)
            if syms is None:
                broken = err
                break
            objs.append(obj)
        if broken:
            # A source that will not even assemble is also a correct refusal,
            # as long as it was refused for the stated reason and left nothing.
            if needle not in broken:
                gate.fail(name, 'rejected, but not for the stated reason: %s'
                          % broken.replace('\n', ' | ')[:160])
            elif any(os.path.exists(o) for o in objs):
                gate.fail(name, 'rejected but left an object behind')
            else:
                print('PASS %-22s refused at compile: %s' % (name, needle))
                gate.ok += 1
            continue
        img = os.path.join(TMP, name + '.bin')
        blob, bases, err = gate.link(objs, img)
        if blob is not None:
            gate.fail(name, 'the linker accepted it (rc=0, %d bytes)'
                      % len(blob))
            continue
        if needle not in err:
            gate.fail(name, 'rejected, but not for the stated reason: %s'
                      % err.replace('\n', ' | ')[:160])
            continue
        if os.path.exists(img):
            gate.fail(name, 'rejected but left an image behind')
            continue
        print('PASS %-22s refused at link: %s' % (name, needle))
        gate.ok += 1

    # --- ISA descriptor -----------------------------------------------------
    # Linking riscv32 objects without saying so must not fall through to the
    # ARM relocation path, which would write Thumb branch encodings into the
    # image and exit 0.
    blob, entry, objs, err = gate.build('isa', CASES[0][1])
    if blob is None:
        gate.fail('isa_missing_target', 'setup: %s' % err)
    else:
        img = os.path.join(TMP, 'isa.bin')
        out, bases, err = gate.link(objs, img, target=False)
        if out is not None:
            gate.fail('isa_missing_target', 'linked without -target riscv32 '
                      '(%d bytes); an RV object was relocated as another ISA'
                      % len(out))
        elif 'riscv32' not in err:
            gate.fail('isa_missing_target', 'rejected, but not for the stated '
                      'reason: %s' % err.replace('\n', ' | ')[:160])
        elif os.path.exists(img):
            gate.fail('isa_missing_target', 'rejected but left an image behind')
        else:
            print('PASS %-22s refused: riscv32 objects need -target riscv32'
                  % 'isa_missing_target')
            gate.ok += 1

    # --- anti-false-green ---------------------------------------------------
    # If the runtime arm cannot see a different answer, every PASS above is
    # meaningless.  Same program, one operand changed.
    src = CASES[0][1][1][1].replace('a + b', 'a - b')
    assert src != CASES[0][1][1][1], 'the self-check mutation changed nothing'
    blob, entry, objs, err = gate.build('selfcheck',
                                        [(CASES[0][1][0][0], CASES[0][1][0][1]),
                                         (CASES[0][1][1][0], src)])
    got = None
    if blob is not None:
        got, err = gate.execute(blob, entry)
    changed = (20 - 22) & 0xFF
    assert changed != CASES[0][2], 'the self-check mutation keeps the answer'
    if got is None:
        gate.fail('selfcheck', 'run: %s' % err)
    elif got != changed:
        gate.fail('selfcheck', 'a changed operator gave %r (expected %r): the '
                  'runner is not reading the return value' % (got, changed))
    else:
        print('SELFCHECK wrong-answer-visibility: OK')
        gate.ok += 1

    print('=== %d passed, %d failed ===' % (gate.ok, gate.bad))
    return 0 if gate.bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
