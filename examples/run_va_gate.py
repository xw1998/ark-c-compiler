#!/usr/bin/env python3
"""ARM Thumb-2 / RV32I varargs gate: compile, assemble, RUN, compare.

Every other gate in this repo stops at the emitted text.  This one executes the
varargs code on both non-C backends and compares the result against gcc, because
that is the only way to tell "the va region is written" from "the va region is
written correctly" -- the failure this replaces was `va_start` compiling into
`LDR r0,[r0]` (address 0, the vector table) and answering with the initial SP.

How a case runs:
  arkcc -target <arm|riscv32> -S  ->  GNU as  ->  ld (flat image at 0x08000000)
  ->  unicorn  ->  the value main() returned is the exit code
The same source is compiled by the host gcc and run natively; its exit code is
the expected value, so the case list stays type-directed (no magic numbers).

Covered (ARM): all-register and register+stack arguments; a 64-bit argument in
a register pair and on the stack; a named long long / four named ints that force
the tail onto the stack; an odd named count so the first 64-bit value has to
skip an alignment word; double arguments and float arguments promoted to double.
Covered (RV32I): the 32-bit cases, plus the two refusals that mark the edge of
what that backend can pass (no stack arguments, no two-word values).

Tools (override with --arm-as / --rv-as or the environment):
  ARKCC_ARM_AS   directory holding arm-none-eabi-as / -ld / -objcopy / -nm
  ARKCC_RV_AS    directory holding riscv64-unknown-elf-as / -ld / ...
  ARKCC_GCC      host gcc (default: gcc on PATH)
A target whose toolchain is missing is SKIPPED, not failed; exit 2 means no
target could be run at all (nothing was verified), 1 means a real failure.
"""
import argparse
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
TMP = os.path.join(ROOT, 'build_va_gate')
ARKC = os.path.join(ROOT, 'arkcc.exe')
if not os.path.exists(ARKC):
    ARKC = os.path.join(ROOT, 'arkcc')
INC = os.path.join(ROOT, 'stdlib', 'include')

# ---------------------------------------------------------------------------
# case sources
# ---------------------------------------------------------------------------

PRELUDE = r'''
#include <stdarg.h>

static int s4(int n, ...)
{
    va_list ap; int a, b, c, d;
    va_start(ap, n);
    a = va_arg(ap, int); b = va_arg(ap, int);
    c = va_arg(ap, int); d = va_arg(ap, int);
    va_end(ap);
    return a + 2 * b + 3 * c + 4 * d;
}
static int sN(int n, ...)
{
    va_list ap; int i, s = 0;
    va_start(ap, n);
    for (i = 0; i < n; i++) s = s * 3 + va_arg(ap, int);
    va_end(ap);
    return s;
}
static int s6flat(int n, ...)
{
    va_list ap; int a, b, c, d, e, f;
    va_start(ap, n);
    a = va_arg(ap, int); b = va_arg(ap, int); c = va_arg(ap, int);
    d = va_arg(ap, int); e = va_arg(ap, int); f = va_arg(ap, int);
    va_end(ap);
    return a + 2 * b + 3 * c + 4 * d + 5 * e + 6 * f;
}
static int four_named(int a, int b, int c, int d, ...)
{
    va_list ap; int x, y;
    va_start(ap, d);
    x = va_arg(ap, int);
    y = va_arg(ap, int);
    va_end(ap);
    return a + b + c + d + x * 10 + y * 100;
}
'''

# 64-bit and floating values: only the ARM target has the two-word value model
# these need (the RV32I backend refuses 8-byte loads/stores by name, and the
# gate asserts that refusal below).
PRELUDE_64 = r'''
union llw { long long v; int w[2]; };
union ddw { double d; int w[2]; };

static int llw_sum(int n, ...)
{
    union llw u; va_list ap; int s = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) { u.v = va_arg(ap, long long); s += u.w[0] + u.w[1]; }
    va_end(ap);
    return s;
}
static int dsum(int n, ...)
{
    union ddw u; va_list ap; int s = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) { u.d = va_arg(ap, double); s = s * 31 + (u.w[1] >> 20) + u.w[0]; }
    va_end(ap);
    return s;
}
/* A negative double built by setting the sign bit: the ARM backend's unary
 * minus on a 64-bit value goes through its integer path (NEG on the high word),
 * which is not IEEE negation -- a separate defect this gate should not measure. */
static double mkneg(double x)
{
    union ddw u;
    u.d = x;
    u.w[1] = u.w[1] | 0x80000000u;
    return u.d;
}
static int named_ll(int a, long long b, ...)
{
    union llw u; va_list ap; int x, y;
    u.v = b;
    va_start(ap, b);
    x = va_arg(ap, int);
    y = va_arg(ap, int);
    va_end(ap);
    return a + u.w[0] + u.w[1] + x * 10 + y * 100;
}
static int odd_named(int a, ...)
{
    union llw u; va_list ap;
    va_start(ap, a);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + u.w[0] + u.w[1];
}
static int two_named_ll(int a, long long b, ...)
{
    union llw u; va_list ap;
    va_start(ap, b);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + u.w[0] + u.w[1];
}
static int after_ll_pair(int a, long long b, long long c, ...)
{
    va_list ap; int x;
    va_start(ap, c);
    x = va_arg(ap, int);
    va_end(ap);
    return a + x;
}
'''

# (name, main body, targets the case applies to)
CASES = [
    ('s4',       'return s4(4, 1, 2, 3, 4) & 0xFF;', 'arm rv'),
    ('s6flat',   'return s6flat(6, 1, 2, 3, 4, 5, 6) & 0xFF;', 'arm rv'),
    ('loop3',    'return sN(3, 1, 0, 1) & 0xFF;', 'arm rv'),
    ('loop4',    'return sN(4, 1, 2, 3, 4) & 0xFF;', 'arm rv'),
    ('four',     'return four_named(1, 2, 3, 4, 5, 6) & 0xFF;', 'arm rv'),
    ('ll_reg',   'return llw_sum(1, 0x1122334455667788LL) & 0xFF;', 'arm'),
    ('ll_mix',   'return llw_sum(2, 0x1122334455667788LL, 0x99aabbccddeeff00LL) & 0xFF;', 'arm'),
    ('named_ll', 'return named_ll(1, 0x1122334455667788LL, 7, 8) & 0xFF;', 'arm'),
    ('odd_ll',   'return odd_named(1, 0x1122334455667788LL) & 0xFF;', 'arm'),
    ('two_ll',   'return two_named_ll(1, 0x1122334455667788LL, 0x99aabbccddeeff00LL) & 0xFF;', 'arm'),
    ('pair',     'return after_ll_pair(1, 0x1122334455667788LL, 0x99aabbccddeeff00LL, 9) & 0xFF;', 'arm'),
    ('d_one',    'return dsum(1, 1.5) & 0xFF;', 'arm'),
    ('d_three',  'return dsum(3, 1.5, 2.5, 3.5) & 0xFF;', 'arm'),
    ('d_neg',    'return dsum(2, 1024.5, mkneg(2.5)) & 0xFF;', 'arm'),
    ('d_prom',   'return dsum(1, 1.5f) & 0xFF;', 'arm'),
    # 34 argument words: 4 in r0-r3 and 30 on the stack.  The ARM region is the
    # caller's own image, so the only limit is the caller's stack -- there is
    # no mirrored window to overflow any more.
    ('many_stack', 'return sN(33, ' + ', '.join(str(i) for i in range(1, 34)) + ') & 0xFF;',
     'arm'),
]

# Arguments a target cannot pass must be a build error, and that is asserted.
REFUSE = [
    # The RV32I backend passes arguments only in a0-a7 (no stack arguments).
    ('toomany', 'return sN(8, 1, 0, 1, 1, 0, 0, 1, 0) & 0xFF;',
     'stack arguments are not implemented', ''),
    # ...and it has no two-word value model, so a 64-bit va_arg cannot be built.
    ('ll_refused', 'return llw_sum(1, 0x1122334455667788LL) & 0xFF;',
     '8-byte loads are not implemented', 'll'),
]

# A 64-bit reader for the refusal case above (the RV32I prelude has none).
LL_SNIPPET = r'''
union llw { long long v; int w[2]; };
static int llw_sum(int n, ...)
{
    union llw u; va_list ap; int s = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) { u.v = va_arg(ap, long long); s += u.w[0] + u.w[1]; }
    va_end(ap);
    return s;
}
'''

ARM_START = '''    .syntax unified
    .thumb
    .global _start
    .text
_start:
    ldr sp, =0x20080000
    bl main
_hang:
    b _hang
'''

RV_START = '''    .text
    .global _start
_start:
    li sp, 0x20080000
    call main
hang:
    j hang
'''


def write(path, text):
    with open(path, 'w', newline='\n') as f:
        f.write(text)


class Runner:
    def __init__(self, gcc):
        self.gcc = gcc
        self.passed = 0
        self.failed = 0

    def run(self, cmd):
        return subprocess.run(cmd, capture_output=True, text=True, errors='replace')

    def oracle(self, src, exe):
        if not self.gcc:
            return None, 'no host gcc'
        r = self.run([self.gcc, '-w', src, '-o', exe])
        if r.returncode != 0:
            return None, r.stderr
        return self.run([exe]).returncode & 0xFF, ''

    def compile(self, target, src, asm):
        r = self.run([ARKC, '-target', target, '-S', '-I', INC, src, '-o', asm])
        if r.returncode != 0:
            return 'arkcc: ' + (r.stdout + r.stderr).strip()
        return ''

    def symbols(self, elf, nm):
        out = {}
        r = self.run([nm, elf])
        for ln in r.stdout.splitlines():
            p = ln.split()
            if len(p) == 3:
                try:
                    out[p[2]] = int(p[0], 16)
                except ValueError:
                    pass
        return out

    def arm(self, name, src, tool):
        asm = os.path.join(TMP, name + '.s')
        gnu = os.path.join(TMP, name + '_gnu.s')
        obj = os.path.join(TMP, name + '.o')
        elf = os.path.join(TMP, name + '.elf')
        binf = os.path.join(TMP, name + '.bin')
        err = self.compile('arm', src, asm)
        if err:
            return None, err
        # arkcc's own text uses ';' comments and omits .syntax unified: both are
        # its conventions, so the host assembler needs them translated.
        lines = ['    .syntax unified']
        for ln in open(asm, encoding='utf-8', errors='replace').read().splitlines():
            if ln.lstrip().startswith(';'):
                continue
            lines.append(ln)
        write(gnu, '\n'.join(lines) + '\n')
        r = self.run([tool('as'), '-mcpu=cortex-m4', '-mfpu=fpv4-sp-d16',
                      '-mfloat-abi=hard', gnu, '-o', obj])
        if r.returncode != 0:
            return None, 'as: ' + r.stderr.strip()
        r = self.run([tool('ld'), '-Ttext=0x08000000', '-e', '_start',
                      os.path.join(TMP, 'start_arm.o'), obj, '-o', elf])
        if r.returncode != 0:
            return None, 'ld: ' + r.stderr.strip()
        r = self.run([tool('objcopy'), '-O', 'binary', elf, binf])
        if r.returncode != 0:
            return None, 'objcopy: ' + r.stderr.strip()
        return self.exec_arm(binf, elf, tool)

    def rv(self, name, src, tool):
        asm = os.path.join(TMP, name + '.s')
        obj = os.path.join(TMP, name + '.o')
        elf = os.path.join(TMP, name + '.elf')
        binf = os.path.join(TMP, name + '.bin')
        err = self.compile('riscv32', src, asm)
        if err:
            return None, err
        r = self.run([tool('as'), '-march=rv32im', '-mabi=ilp32', asm, '-o', obj])
        if r.returncode != 0:
            return None, 'as: ' + r.stderr.strip()
        r = self.run([tool('ld'), '-m', 'elf32lriscv', '-Ttext=0x08000000', '-e', '_start',
                      os.path.join(TMP, 'start_rv.o'), obj, '-o', elf])
        if r.returncode != 0:
            return None, 'ld: ' + r.stderr.strip()
        r = self.run([tool('objcopy'), '-O', 'binary', elf, binf])
        if r.returncode != 0:
            return None, 'objcopy: ' + r.stderr.strip()
        return self.exec_rv(binf, elf, tool)

    def exec_arm(self, binf, elf, tool):
        from unicorn import Uc, UcError, UC_ARCH_ARM, UC_MODE_THUMB, UC_MODE_MCLASS
        from unicorn.arm_const import (UC_ARM_REG_SP, UC_ARM_REG_LR,
                                       UC_ARM_REG_PC, UC_ARM_REG_R0)
        syms = self.symbols(elf, tool('nm'))
        uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB | UC_MODE_MCLASS)
        uc.mem_map(0x08000000, 0x100000)
        uc.mem_write(0x08000000, open(binf, 'rb').read())
        uc.mem_map(0x20000000, 0x100000)
        uc.reg_write(UC_ARM_REG_SP, 0x20080000)
        uc.reg_write(UC_ARM_REG_LR, 0xFFFFFFFF)
        try:
            uc.emu_start(syms['_start'] | 1, syms['_hang'] | 1, count=4000000)
        except UcError as e:
            return None, 'unicorn: %s at %#x' % (e, uc.reg_read(UC_ARM_REG_PC))
        return uc.reg_read(UC_ARM_REG_R0) & 0xFF, ''

    def exec_rv(self, binf, elf, tool):
        from unicorn import Uc, UcError, UC_ARCH_RISCV, UC_MODE_RISCV32
        from unicorn.riscv_const import UC_RISCV_REG_A0, UC_RISCV_REG_PC
        syms = self.symbols(elf, tool('nm'))
        uc = Uc(UC_ARCH_RISCV, UC_MODE_RISCV32)
        uc.mem_map(0x08000000, 0x100000)
        uc.mem_write(0x08000000, open(binf, 'rb').read())
        uc.mem_map(0x20000000, 0x100000)
        try:
            uc.emu_start(syms['_start'], syms['hang'], count=4000000)
        except UcError as e:
            return None, 'unicorn: %s at %#x' % (e, uc.reg_read(UC_RISCV_REG_PC))
        return uc.reg_read(UC_RISCV_REG_A0) & 0xFF, ''


FRAME_CAP = 1024   # bytes; nothing in this gate needs a bigger frame

def frame_peak(asm_path, target):
    """Largest stack adjustment in one function of the emitted assembly.

    The point of this check: an earlier version of the ARM and RV32I variadic
    support mirrored the whole argument register file into the frame at a fixed
    offset, which forced an 8 KB frame on every variadic function while a
    mini-app task on the board only gets 4 KB (APP_TASK_STACK_SIZE).  It passed
    every execution test here and could never have run on the target, so the
    frame size is asserted, not assumed.
    """
    try:
        text = open(asm_path, encoding='utf-8', errors='replace').read()
    except OSError:
        return None
    peak = 0
    if target == 'arm':
        for m in re.finditer(r'^\s*SUB\s+sp,\s*sp,\s*#(\d+)', text, re.M):
            peak = max(peak, int(m.group(1)))
    else:
        # RV32I forms the size in a register: "li t0, N" then "sub sp, sp, t0".
        for m in re.finditer(r'^\s*li\s+t0,\s*(\d+)\s*\n\s*sub\s+sp,\s*sp,\s*t0',
                             text, re.M):
            peak = max(peak, int(m.group(1)))
    return peak

def tool_finder(prefix, path):
    """Return a function 'as'/'ld'/... -> absolute tool path, or None."""
    if not path:
        return None

    def find(kind):
        name = prefix + kind
        exe = os.path.join(path, name + '.exe')
        if os.path.exists(exe):
            return exe
        found = shutil.which(name)
        if found:
            return found
        raise SystemExit('toolchain binary not found: %s in %s' % (name, path))

    try:
        find('as')
    except SystemExit:
        return None
    return find


# Instructions whose encoding this gate must pin down byte for byte.
#
# The ARM cases below go through GNU as; the board goes through arkc's own
# assembler.  Two encoders for one text means "GNU as accepted it" says nothing
# about the target, and the va epilogue is the one instruction pair where that
# difference bit: `POP {r5, r6, r7, lr}` has no 16-bit form at all (bit 8 is PC
# in POP, LR only in PUSH), the internal encoder silently dropped `lr`, and the
# variadic return then popped three registers instead of four -- 4 bytes of
# stack lost and a stale lr on every return, invisible on the host.
ENCODING = [
    ('pop_lr',
     '.thumb\n.text\n.global f\nf:\n'
     '    PUSH {r5, r6, r7, lr}\n    POP {r5, r6, r7, lr}\n    BX lr\n',
     b'\xe0\xb5\xbd\xe8\xe0\x40\x70\x47'),
    ('pop_pc',
     '.thumb\n.text\n.global g\ng:\n    POP {r5, r6, r7, pc}\n',
     b'\xe0\xbd'),
]


# How many words a call leaves on the IR stack, when the callee is only
# declared in this translation unit.
#
# irgen decides the pop count from the *call expression's* type; the backends
# used to decide the push count by looking the callee up in prog->funcs, i.e.
# only among functions this file defines.  A declared-only callee therefore got
# "returns one word" no matter what its prototype said:
#   extern void h(void); h();            -> pushed r0 that nobody popped,
#                                           4 bytes of stack leaked per call
#   extern long long e(void); return e();-> high word never pushed, silently
#                                           wrong 64-bit result
# The leaked word is what broke va_arg on the board: MINISTART's
# __arkcc_init_globals() call left the MiniApp frame 4 bytes off, so the
# argument region was no longer 8-byte aligned and every 64-bit va_arg read
# one word early.  Both shapes are asserted here.
SHAPE_SRC = (
    'extern void h(void);\n'
    'extern long long e(void);\n'
    'int main(void) { h(); return (int)(e() >> 40) & 0xFF; }\n'
)


def shape_checks(r):
    src = os.path.join(TMP, 'shape_voidcall.c')
    asm = os.path.join(TMP, 'shape_voidcall.s')
    write(src, SHAPE_SRC)
    rc = r.run([ARKC, '-target', 'arm', '-S', '-O1', '-I', INC, src, '-o', asm])
    if rc.returncode != 0:
        print('FAIL asm/void_call  arkcc failed: %s'
              % (rc.stdout + rc.stderr).strip()[:160])
        r.failed += 1
        return
    lines = [ln.strip() for ln in open(asm, encoding='utf-8', errors='replace')]
    lines = [ln for ln in lines if ln and not ln.startswith(';')]

    def after(mnemonic):
        for i, ln in enumerate(lines):
            if ln.replace('  ', ' ') == mnemonic:
                return lines[i + 1:i + 4]
        return None

    tail = after('BL h')
    want = 'PUSH {r0}'
    if tail is None:
        print('FAIL asm/void_call  no "BL h" in the emitted assembly')
        r.failed += 1
    elif tail[0] == want:
        print('FAIL asm/void_call  a declared-only void call pushed a result: %r'
              % (tail,))
        r.failed += 1
    else:
        print('PASS asm/void_call  h() pushes nothing')
        r.passed += 1

    tail = after('BL e')
    if tail is None:
        print('FAIL asm/void_call  no "BL e" in the emitted assembly')
        r.failed += 1
    elif tail[0] != 'PUSH {r0}' or tail[1] != 'PUSH {r1}':
        print('FAIL asm/void_call  a declared-only long long call must push both '
              'words, got %r' % (tail,))
        r.failed += 1
    else:
        print('PASS asm/void_call  e() pushes both words')
        r.passed += 1


def encoding_checks(r):
    """arkcc's own assembler, checked byte for byte (no external toolchain)."""
    for name, text, want in ENCODING:
        src = os.path.join(TMP, 'enc_' + name + '.s')
        out = os.path.join(TMP, 'enc_' + name + '.bin')
        write(src, text)
        if os.path.exists(out):
            os.remove(out)
        rc = r.run([ARKC, '-target', 'arm', src, '-o', out])
        if rc.returncode != 0:
            print('FAIL asm/%-9s assembler failed: %s'
                  % (name, (rc.stdout + rc.stderr).strip()[:160]))
            r.failed += 1
            continue
        try:
            got = open(out, 'rb').read()
        except OSError as e:
            print('FAIL asm/%-9s no output: %s' % (name, e))
            r.failed += 1
            continue
        if got != want:
            print('FAIL asm/%-9s got %s want %s'
                  % (name, got.hex(), want.hex()))
            r.failed += 1
        else:
            print('PASS asm/%-9s %s' % (name, want.hex()))
            r.passed += 1


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arm-as', default=os.environ.get('ARKCC_ARM_AS', ''))
    ap.add_argument('--rv-as', default=os.environ.get('ARKCC_RV_AS', ''))
    ap.add_argument('--gcc', default=os.environ.get('ARKCC_GCC', 'gcc'))
    args = ap.parse_args()

    try:
        import unicorn  # noqa: F401
    except ImportError:
        print('SKIP: the unicorn python package is not installed '
              '(pip install unicorn); nothing was verified')
        return 2

    os.makedirs(TMP, exist_ok=True)
    write(os.path.join(TMP, 'start_arm.s'), ARM_START)
    write(os.path.join(TMP, 'start_rv.s'), RV_START)

    r = Runner(args.gcc if shutil.which(args.gcc) else None)
    ran = 0

    encoding_checks(r)
    shape_checks(r)

    arm_tool = tool_finder('arm-none-eabi-', args.arm_as)
    if arm_tool:
        ran += 1
        rc = r.run([arm_tool('as'), '-mcpu=cortex-m4',
                    os.path.join(TMP, 'start_arm.s'),
                    '-o', os.path.join(TMP, 'start_arm.o')])
        if rc.returncode != 0:
            print('FAIL arm start stub: ' + rc.stderr.strip()[:200])
            r.failed += 1
        for name, body, targets in CASES:
            if 'arm' not in targets.split():
                continue
            src = os.path.join(TMP, 'arm_' + name + '.c')
            write(src, PRELUDE + PRELUDE_64 + '\nint main(void)\n{\n    ' + body + '\n}\n')
            exp, err = r.oracle(src, os.path.join(TMP, 'arm_' + name + '_gcc.exe'))
            if exp is None:
                print('SKIP arm/%-9s no gcc oracle: %s' % (name, err.strip()[:80]))
                r.failed += 1
                continue
            got, err = r.arm('arm_' + name, src, arm_tool)
            if got is None:
                print('FAIL arm/%-9s %s' % (name, err.strip()[:200]))
                r.failed += 1
            elif got != exp:
                print('FAIL arm/%-9s arm=%d expected=%d' % (name, got, exp))
                r.failed += 1
            else:
                pk = frame_peak(os.path.join(TMP, 'arm_' + name + '.s'), 'arm')
                if pk is not None and pk > FRAME_CAP:
                    print('FAIL arm/%-9s frame %d B > %d (a variadic frame must '
                          'stay small)' % (name, pk, FRAME_CAP))
                    r.failed += 1
                else:
                    print('PASS arm/%-9s %d' % (name, got))
                    r.passed += 1
    else:
        print('SKIP arm: no arm-none-eabi toolchain (set --arm-as / ARKCC_ARM_AS)')

    rv_tool = tool_finder('riscv64-unknown-elf-', args.rv_as)
    if rv_tool:
        ran += 1
        rc = r.run([rv_tool('as'), '-march=rv32im', '-mabi=ilp32',
                    os.path.join(TMP, 'start_rv.s'),
                    '-o', os.path.join(TMP, 'start_rv.o')])
        if rc.returncode != 0:
            print('FAIL rv start stub: ' + rc.stderr.strip()[:200])
            r.failed += 1
        for name, body, targets in CASES:
            if 'rv' not in targets.split():
                continue
            src = os.path.join(TMP, 'rv_' + name + '.c')
            write(src, PRELUDE + '\nint main(void)\n{\n    ' + body + '\n}\n')
            exp, err = r.oracle(src, os.path.join(TMP, 'rv_' + name + '_gcc.exe'))
            if exp is None:
                print('SKIP rv/%-9s no gcc oracle: %s' % (name, err.strip()[:80]))
                r.failed += 1
                continue
            got, err = r.rv('rv_' + name, src, rv_tool)
            if got is None:
                print('FAIL rv/%-9s %s' % (name, err.strip()[:200]))
                r.failed += 1
            elif got != exp:
                print('FAIL rv/%-9s rv=%d expected=%d' % (name, got, exp))
                r.failed += 1
            else:
                pk = frame_peak(os.path.join(TMP, 'rv_' + name + '.s'), 'rv')
                if pk is not None and pk > FRAME_CAP:
                    print('FAIL rv/%-9s frame %d B > %d (a variadic frame must '
                          'stay small)' % (name, pk, FRAME_CAP))
                    r.failed += 1
                else:
                    print('PASS rv/%-9s %d' % (name, got))
                    r.passed += 1
        for name, body, want, extra in REFUSE:
            src = os.path.join(TMP, 'rv_' + name + '.c')
            head = PRELUDE + (LL_SNIPPET if extra == 'll' else '')
            write(src, head + '\nint main(void)\n{\n    ' + body + '\n}\n')
            rc = r.run([ARKC, '-target', 'riscv32', '-S', '-I', INC, src,
                        '-o', os.path.join(TMP, 'rv_' + name + '.s')])
            msg = rc.stdout + rc.stderr
            if rc.returncode != 0 and want in msg:
                print('PASS rv/%-9s refused' % name)
                r.passed += 1
            else:
                print('FAIL rv/%-9s expected a refusal (%r), rc=%d'
                      % (name, want, rc.returncode))
                r.failed += 1
    else:
        print('SKIP rv: no riscv64-unknown-elf toolchain (set --rv-as / ARKCC_RV_AS)')

    print('\n%d passed, %d failed, %d target(s) run' % (r.passed, r.failed, ran))
    if ran == 0:
        return 2
    return 0 if r.failed == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
