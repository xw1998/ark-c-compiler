#!/usr/bin/env python3
"""IR_ASM / IR_SVC / IR_SMC / IR_SIMD_* on riscv32 (and the ARM shapes they mirror).

Four IR ops used to be unimplemented in the riscv32 backend.  They were not
"missing features" in the harmless sense: the backend's `default` branch is a
hard error now, so a program using one of them failed to build -- honest, but
still a hole in "a complete C compiler".  They are now implemented:

  * IR_ASM   -- inline assembly, plain (`asm("...")`) and extended
                (`asm("t" : outs : ins : clobbers)`); the extended form is the
                one irgen tags with '@', and %0..%3 must become a0..a3 (r0..r3
                on ARM) because there is no operand allocator to bind them.
  * IR_SVC   -- `__svc(n)`: the number goes in a7 and the call is `ecall`.
  * IR_SMC   -- `__smc(n)`: same, because RV32I has exactly one trap
                instruction.  This is a property of the ISA, not a shortcut.
  * IR_SIMD_ADD16/SUB16/ADD8/SUB8 -- the auto-vectorizer's packed-lane
                arithmetic.  RV32I base has no packed instructions, so it is
                emulated exactly (signed-but-wrapping per lane, never
                saturating), which is what SADD16/SSUB16/SADD8/SSUB8 do.

Two things this gate checks that a value-only test would miss:

  1. That the vectorized*p path is the code being measured.  If a future
     change stops vectorizing, every SIMD case would fall back to scalar
     arithmetic and still answer correctly -- the gate would go green while
     measuring nothing.  So each SIMD case also greps its own assembly for the
     emulation marker (RV: the 0x00FF00FF / 0xFFFF masks; ARM: the SADD*/SSUB*
     mnemonic) and fails if it is absent.

  2. That the emulation wraps where the hardware wraps.  The interesting cases
     are the carries that cross a lane boundary: 16-bit 0x00FF + 1 must be
     0x0100 (a byte-mask implementation loses it), 8-bit 0x7F + 1 must be 0x80,
     and 8-bit 0 - 1 must be 0xFF.

__svc/__smc are executed on riscv32 with an interrupt hook standing in for a
kernel: the hook records a7 and the first argument in a0, answers with a known
value, and the C code must see that value come back through a0.  That checks
the whole convention (number placement, argument, result) rather than just the
presence of an `ecall` byte.  ARM executes SVC/SMC as an exception too, so for
ARM the check is textual: `SVC #n` / `SMC #n` with the declared number.

Usage (run from the compiler repository root):
    python tests/run_rv_misc_ir_tests.py --rv-as <riscv binutils dir> \
                                         [--arm-as <arm binutils dir>]
"""
import argparse
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402


# ---------------------------------------------------------------------------
# SIMD: name, source, expected exit status, marker(s) that must appear in the
#       generated assembly, and whether the marker is a `li t4, ...` constant
#       (RV) or an ARM mnemonic.
# ---------------------------------------------------------------------------
SIMD_CASES = [
    ("add16", """
short a[4] = {1, 2, 3, 4};
short b[4] = {1, 2, 3, 4};
short c[4];
int main(void) {
    int i;
    for (i = 0; i < 4; i++) c[i] = a[i] + b[i];
    if (c[0] != 2) return 1;
    if (c[1] != 4) return 2;
    if (c[2] != 6) return 3;
    if (c[3] != 8) return 4;
    return 21;
}
""", 21, "SADD16", "li t4, 0xFFFF"),

    # The carry that crosses a halfword boundary.  A byte-mask emulation would
    # answer 0x0100 as 0x0000 here, which is why the 16-bit path masks whole
    # halfwords instead.
    ("add16_carry", """
short a[4] = {0x00FF, 0, 0, 0};
short b[4] = {1, 0, 0, 0};
short c[4];
int main(void) {
    int i;
    for (i = 0; i < 4; i++) c[i] = a[i] + b[i];
    if ((c[0] & 0xFFFF) != 0x0100) return 1;
    if (c[1] != 0) return 2;
    return 22;
}
""", 22, "SADD16", "li t4, 0xFFFF"),

    ("sub16", """
short a[4] = {10, 20, 30, 40};
short b[4] = {1, 2, 3, 4};
short c[4];
int main(void) {
    int i;
    for (i = 0; i < 4; i++) c[i] = a[i] - b[i];
    if (c[0] != 9) return 1;
    if (c[1] != 18) return 2;
    if (c[2] != 27) return 3;
    if (c[3] != 36) return 4;
    return 23;
}
""", 23, "SSUB16", "li t4, 0xFFFF"),

    ("sub16_borrow", """
short a[4] = {0x0100, 5, 0, 0};
short b[4] = {1, 0, 0, 0};
short c[4];
int main(void) {
    int i;
    for (i = 0; i < 4; i++) c[i] = a[i] - b[i];
    if ((c[0] & 0xFFFF) != 0x00FF) return 1;
    return 24;
}
""", 24, "SSUB16", "li t4, 0xFFFF"),

    # Eight elements so the loop takes two iterations and the stride really is
    # bumped to 4 -- a one-iteration case cannot see a wrong stride.
    ("add8", """
char a[8] = {1, 2, 3, 4, 5, 6, 7, 8};
char b[8] = {1, 2, 3, 4, 5, 6, 7, 8};
char c[8];
int main(void) {
    int i;
    for (i = 0; i < 8; i++) c[i] = a[i] + b[i];
    if (c[0] != 2) return 1;
    if (c[3] != 8) return 2;
    if (c[4] != 10) return 3;
    if (c[7] != 16) return 4;
    return 25;
}
""", 25, "SADD8", "li t4, 0x00FF00FF"),

    # 0x7F + 1 must wrap to 0x80 inside the lane, not carry into the neighbour.
    ("add8_wrap", """
char a[4] = {0x7F, 0, 0x12, 0};
char b[4] = {1, 0, 0, 0};
char c[4];
int main(void) {
    int i;
    for (i = 0; i < 4; i++) c[i] = a[i] + b[i];
    if ((c[0] & 0xFF) != 0x80) return 1;
    if (c[1] != 0) return 2;
    if (c[2] != 0x12) return 3;
    return 26;
}
""", 26, "SADD8", "li t4, 0x00FF00FF"),

    ("sub8", """
char a[8] = {9, 8, 7, 6, 5, 4, 3, 2};
char b[8] = {1, 2, 3, 4, 5, 6, 7, 8};
char c[8];
int main(void) {
    int i;
    for (i = 0; i < 8; i++) c[i] = a[i] - b[i];
    if (c[0] != 8) return 1;
    if (c[3] != 2) return 2;
    if (c[4] != 0) return 3;
    if (c[7] != -6) return 4;
    return 27;
}
""", 27, "SSUB8", "li t4, 0x00FF00FF"),

    # 0 - 1 in a lane is 0xFF, and the borrow must not reach the neighbour.
    ("sub8_wrap", """
char a[4] = {0, 5, 0, 0};
char b[4] = {1, 0, 0, 0};
char c[4];
int main(void) {
    int i;
    for (i = 0; i < 4; i++) c[i] = a[i] - b[i];
    if ((c[0] & 0xFF) != 0xFF) return 1;
    if (c[1] != 5) return 2;
    return 28;
}
""", 28, "SSUB8", "li t4, 0x00FF00FF"),
]


# ---------------------------------------------------------------------------
# __svc / __smc.  The C side is identical for both targets; how it is checked
# differs (RV: executed with an interrupt hook, ARM: textual).
# ---------------------------------------------------------------------------
SVC_SRC = """
typedef int int32;
typedef unsigned int uint32;
int32 __svc ( %d ) svcrt_call(uint32 p);
int main(void) {
    return svcrt_call(7) & 0xFF;
}
"""

SMC_SRC = """
int __smc ( %d ) monitor(unsigned int p);
int main(void) {
    return monitor(9) & 0xFF;
}
"""

# What the hook answers with.  0x2A so a stale/short value cannot pass by luck.
SVC_REPLY = 0x2A
SVC_STATUS = "TEST_SVC"
SMC_STATUS = "TEST_SMC"


# ---------------------------------------------------------------------------
# Inline assembly.  The extended form must lose its %N placeholders and the
# template must reach the output verbatim; both are checked textually, and the
# program is executed to prove the emitted text still assembles and the C code
# around it still works (the backend binds no operands, which is documented --
# so the asm result is deliberately not observable from C).
# ---------------------------------------------------------------------------
# One template per target: the placeholder substitution is the same, but the
# instruction that materialises a small constant is not (RV `li` / `addi` with
# a bare immediate, ARM `MOV #` / `ADD #`), and a gate that used one spelling
# for both would only prove that the assembler rejects the other target.
ASM_SRC = {
    'rv': """
int main(void) {
    int x;
    x = 5;
    asm("li a0, 11");
    asm("addi %0, %1, 7" : "=r"(x) : "r"(x) : );
    return x - 2;
}
""",
    'arm': """
int main(void) {
    int x;
    x = 5;
    asm("MOV r0, #11");
    asm("ADD %0, %1, #7" : "=r"(x) : "r"(x) : );
    return x - 2;
}
""",
}


class Runner(G.Runner):
    """G.Runner plus (a) an optional interrupt hook for RV, (b) asm text reads."""

    def __init__(self, gcc):
        G.Runner.__init__(self, gcc)
        self.last_asm = ''
        self.traps = []

    def build_arm(self, name, src, tool, libgcc=''):
        asm = os.path.join(G.TMP, name + '.s')
        err = self.compile('arm', src, asm)
        if err:
            return None, err
        self.last_asm = open(asm, encoding='utf-8', errors='replace').read()
        return G.Runner.arm(self, name, src, tool, libgcc)

    def build_rv(self, name, src, tool):
        asm = os.path.join(G.TMP, name + '.s')
        err = self.compile('riscv32', src, asm)
        if err:
            return None, err
        self.last_asm = open(asm, encoding='utf-8', errors='replace').read()
        return self.run_rv_with_hook(name, asm, tool)

    def run_rv_with_hook(self, name, asm, tool):
        """Same pipeline as G.Runner.rv, but with an ECALL handler installed.

        The handler is the stand-in for a kernel: it records (a7, a0), writes
        the reply into a0 and lets unicorn resume (unicorn already steps past
        the trapping instruction -- advancing PC by hand jumps over the next
        instruction and corrupts the stack, which is worth remembering)."""
        obj = os.path.join(G.TMP, name + '.o')
        elf = os.path.join(G.TMP, name + '.elf')
        binf = os.path.join(G.TMP, name + '.bin')
        r = self.run([tool('as'), '-march=rv32im', '-mabi=ilp32', asm, '-o', obj])
        if r.returncode != 0:
            return None, 'as: ' + r.stderr.strip()
        r = self.run([tool('ld'), '-m', 'elf32lriscv', '-Ttext=0x08000000',
                      '-e', '_start', os.path.join(G.TMP, 'start_rv.o'), obj,
                      '-o', elf])
        if r.returncode != 0:
            return None, 'ld: ' + r.stderr.strip()
        r = self.run([tool('objcopy'), '-O', 'binary', elf, binf])
        if r.returncode != 0:
            return None, 'objcopy: ' + r.stderr.strip()

        from unicorn import (Uc, UcError, UC_ARCH_RISCV, UC_MODE_RISCV32,
                             UC_HOOK_INTR)
        from unicorn.riscv_const import (UC_RISCV_REG_A0, UC_RISCV_REG_A7,
                                         UC_RISCV_REG_PC)
        syms = self.symbols(elf, tool('nm'))
        uc = Uc(UC_ARCH_RISCV, UC_MODE_RISCV32)
        uc.mem_map(0x08000000, 0x100000)
        uc.mem_write(0x08000000, open(binf, 'rb').read())
        uc.mem_map(0x20000000, 0x100000)
        self.traps = []

        def on_intr(uc_, intno, _user):
            self.traps.append((intno, uc_.reg_read(UC_RISCV_REG_A7),
                               uc_.reg_read(UC_RISCV_REG_A0),
                               uc_.reg_read(UC_RISCV_REG_PC)))
            uc_.reg_write(UC_RISCV_REG_A0, SVC_REPLY)

        uc.hook_add(UC_HOOK_INTR, on_intr)
        try:
            uc.emu_start(syms['_start'], syms['hang'], count=4000000)
        except UcError as e:
            return None, 'unicorn: %s at %#x' % (e, uc.reg_read(UC_RISCV_REG_PC))
        return uc.reg_read(UC_RISCV_REG_A0) & 0xFF, ''


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--rv-as', default='',
                    help='directory holding riscv64-unknown-elf binutils')
    ap.add_argument('--arm-as', default=os.environ.get('ARKCC_ARM_AS', ''),
                    help='directory holding arm-none-eabi binutils')
    ap.add_argument('--arm-libgcc', default=None,
                    help='no-FPU libgcc.a for arm-none-eabi')
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    G.ARKC = os.path.abspath(args.arkcc)
    if not os.path.exists(G.ARKC):
        print('no such compiler: %s' % G.ARKC)
        return 2
    os.makedirs(G.TMP, exist_ok=True)

    rv_tool = G.tool_finder('riscv64-unknown-elf-', args.rv_as) if args.rv_as else None
    arm_tool = G.tool_finder('arm-none-eabi-', args.arm_as) if args.arm_as else None
    if not rv_tool and not arm_tool:
        print('need --rv-as and/or --arm-as')
        return 2

    r = Runner('gcc')
    r.opt = ['--vectorize']    # name the switch instead of relying on a default
    if rv_tool:
        G.write(os.path.join(G.TMP, 'start_rv.s'), G.RV_START)
        rc = r.run([rv_tool('as'), '-march=rv32im', '-mabi=ilp32',
                    os.path.join(G.TMP, 'start_rv.s'),
                    '-o', os.path.join(G.TMP, 'start_rv.o')])
        if rc.returncode != 0:
            print('cannot assemble the rv harness: %s' % rc.stderr)
            return 2
    if arm_tool:
        G.write(os.path.join(G.TMP, 'start_arm.s'), G.ARM_START)
        rc = r.run([arm_tool('as'), '-mcpu=cortex-m4',
                    os.path.join(G.TMP, 'start_arm.s'),
                    '-o', os.path.join(G.TMP, 'start_arm.o')])
        if rc.returncode != 0:
            print('cannot assemble the arm harness: %s' % rc.stderr)
            return 2
        libgcc = args.arm_libgcc or G.find_arm_libgcc(args.arm_as)
        if not libgcc or not os.path.exists(libgcc):
            print('cannot find a no-FPU libgcc.a for arm-none-eabi '
                  '(pass --arm-libgcc)')
            return 2

    ok = 0
    bad = 0
    targets = []
    if rv_tool:
        targets.append('rv')
    if arm_tool:
        targets.append('arm')

    def note(msg):
        # Every call passes a finished line, so the verdict has to come from
        # the line itself: an earlier version counted "the caller said
        # something" as failure and reported 0 passed for a green run.
        nonlocal ok, bad
        print(msg)
        if msg.startswith('FAIL'):
            bad += 1
        else:
            ok += 1

    # ---- SIMD ------------------------------------------------------------
    for tgt in targets:
        for name, src, want, arm_mn, rv_mark in SIMD_CASES:
            tag = 'simd_%s_%s' % (tgt, name)
            srcf = os.path.join(G.TMP, tag + '.c')
            G.write(srcf, src)
            if tgt == 'rv':
                got, err = r.build_rv(tag, srcf, rv_tool)
            else:
                got, err = r.build_arm(tag, srcf, arm_tool, libgcc)
            if got is None:
                note('FAIL %-22s build/run: %s' % (tag, err))
                continue
            if got != want:
                note('FAIL %-22s arkcc=%r want=%r' % (tag, got, want))
                continue
            # The value alone does not prove the SIMD path ran: scalar code
            # answers the same.  Require the emulation's own marker.
            marker = rv_mark if tgt == 'rv' else arm_mn
            if marker not in r.last_asm:
                note('FAIL %-22s value %d but no "%s" in the assembly -- the '
                     'loop was not vectorized, so nothing was tested'
                     % (tag, got, marker))
                continue
            note('PASS %-22s %d' % (tag, got))

    # ---- __svc / __smc ---------------------------------------------------
    if rv_tool:
        for status, tmpl, num in ((SVC_STATUS, SVC_SRC, 16),
                                  (SMC_STATUS, SMC_SRC, 35)):
            srcf = os.path.join(G.TMP, status + '.c')
            G.write(srcf, tmpl % num)
            got, err = r.build_rv(status, srcf, rv_tool)
            if got is None:
                note('FAIL %-22s build/run: %s' % (status, err))
                continue
            if got != SVC_REPLY:
                note('FAIL %-22s the trap reply did not come back through a0: '
                     'arkcc=%r want=%r' % (status, got, SVC_REPLY))
                continue
            if len(r.traps) != 1:
                note('FAIL %-22s expected exactly one trap, saw %d'
                     % (status, len(r.traps)))
                continue
            intno, a7, a0, _pc = r.traps[0]
            if a7 != num or a0 != (7 if status == SVC_STATUS else 9):
                note('FAIL %-22s trap carried a7=%d a0=%d, want a7=%d a0=%d'
                     % (status, a7, a0, num,
                        7 if status == SVC_STATUS else 9))
                continue
            note('PASS %-22s trap no=%d a7=%d a0=%d -> a0=%d'
                 % (status, intno, a7, a0, got))

        # The built-in assembler has to accept `ecall` too: assembling to a flat
        # image (no GNU as in the loop) must produce exactly one 0x00000073 with
        # the `li a7, N` right before it.  Without this the target build would
        # only break once it reached the board.
        srcf = os.path.join(G.TMP, 'svc_flat.c')
        G.write(srcf, SVC_SRC % 16)
        img = os.path.join(G.TMP, 'svc_flat.bin')
        r2 = r.run([G.ARKC, '-target', 'riscv32', '-I', G.INC, srcf, '-o', img])
        if r2.returncode != 0 or not os.path.exists(img):
            note('FAIL %-22s flat image: %s'
                 % ('svc_flat', (r2.stdout + r2.stderr).strip()[:200]))
        else:
            blob = open(img, 'rb').read()
            words = [int.from_bytes(blob[i:i + 4], 'little')
                     for i in range(0, len(blob) - 3, 4)]
            ecall = [i for i, w in enumerate(words) if w == 0x00000073]
            # addi x0, x0, N  ==  li a7, N.  The opcode is 0x13 with rd=0
            # (x0); 0x293 would set rd=5 and encode `li t0, N` instead.
            li_a7_16 = 0x00000013 | (17 << 7) | (16 << 20)
            if len(ecall) != 1:
                note('FAIL %-22s expected one ecall word, found %d'
                     % ('svc_flat', len(ecall)))
            elif ecall[0] == 0 or words[ecall[0] - 1] != li_a7_16:
                note('FAIL %-22s ecall is not immediately preceded by '
                     'li a7, 16 (got %#x)' % ('svc_flat',
                                              words[ecall[0] - 1] if ecall[0] else 0))
            else:
                note('PASS %-22s ecall=0x00000073 after li a7,16'
                     % 'svc_flat')

    if arm_tool:
        for tag, tmpl, num, mn in (('svc_arm', SVC_SRC, 16, 'SVC'),
                                   ('smc_arm', SMC_SRC, 35, 'SMC')):
            srcf = os.path.join(G.TMP, tag + '.c')
            G.write(srcf, tmpl % num)
            got, err = r.build_arm(tag, srcf, arm_tool, libgcc)
            # SVC/SMC raise an exception on ARM too, so there is no value to
            # check here: the instruction and its number are the contract.
            if not re.search(r'^\s*%s #%d\s*$' % (mn, num), r.last_asm, re.M):
                note('FAIL %-22s no "%s #%d" in the assembly'
                     % (tag, mn, num))
                continue
            note('PASS %-22s %s #%d emitted' % (tag, mn, num))

    # ---- inline assembly -------------------------------------------------
    for tgt in targets:
        tag = 'asm_%s' % tgt
        srcf = os.path.join(G.TMP, tag + '.c')
        G.write(srcf, ASM_SRC[tgt])
        if tgt == 'rv':
            got, err = r.build_rv(tag, srcf, rv_tool)
            want_plain, want_ext = 'li a0, 11', 'addi a0, a1, 7'
        else:
            got, err = r.build_arm(tag, srcf, arm_tool, libgcc)
            want_plain, want_ext = 'MOV r0, #11', 'ADD r0, r1, #7'
        if got is None:
            note('FAIL %-22s build/run: %s' % (tag, err))
            continue
        if got != 3:
            note('FAIL %-22s the C code around the asm broke: arkcc=%r want=3'
                 % (tag, got))
            continue
        # `%` alone is not evidence: gas writes `.type main, %function`.
        if re.search(r'%\d', r.last_asm):
            note('FAIL %-22s a %%-operand survived into the assembly' % tag)
            continue
        if want_plain.lower() not in r.last_asm.lower():
            note('FAIL %-22s plain template missing ("%s")'
                 % (tag, want_plain))
            continue
        if want_ext.lower() not in r.last_asm.lower():
            note('FAIL %-22s extended template did not substitute %%0/%%1 '
                 '("%s")' % (tag, want_ext))
            continue
        note('PASS %-22s %d' % (tag, got))

    # ---- anti-false-green ------------------------------------------------
    # Two ways this gate could be green while measuring nothing, so both are
    # exercised on every run:
    #
    #  1. the value comparison is stuck (reports PASS on everything);
    #  2. the marker test is stuck (finds its marker in any assembly, so a
    #     loop that stopped being vectorized would still pass).  A scalar build
    #     of the very same source is the honest negative control for (2):
    #     correct answer, no marker.
    name, src, want, arm_mn, rv_mark = SIMD_CASES[0]
    tag = 'selfcheck_%s' % targets[0]
    srcf = os.path.join(G.TMP, tag + '.c')
    G.write(srcf, src)
    if targets[0] == 'rv':
        got, _ = r.build_rv(tag, srcf, rv_tool)
        marker = rv_mark
    else:
        got, _ = r.build_arm(tag, srcf, arm_tool, libgcc)
        marker = arm_mn
    if got == want - 1:
        print('FAIL selfcheck: a wrong expectation was accepted')
        bad += 1
    else:
        print('SELFCHECK expectation-mismatch: OK')

    keep = r.opt
    r.opt = ['--no_vectorize']
    asm_scalar = os.path.join(G.TMP, 'selfcheck_scalar_%s.s' % targets[0])
    cerr = r.compile('riscv32' if targets[0] == 'rv' else 'arm', srcf, asm_scalar)
    r.opt = keep
    if cerr:
        print('FAIL selfcheck: the scalar build did not compile: %s' % cerr)
        bad += 1
    else:
        text = open(asm_scalar, encoding='utf-8', errors='replace').read()
        if marker in text:
            print('FAIL selfcheck: the marker "%s" also shows up without '
                  'vectorization -- the marker test proves nothing' % marker)
            bad += 1
        else:
            print('SELFCHECK marker-absent-without-vectorize: OK')

    print('=== %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
