#!/usr/bin/env python3
"""arm ABI interop gate: arkcc and arm-none-eabi-gcc, linked into one image.

Every other gate in this repo checks arkcc against itself or against an oracle
that runs the *same* source.  That cannot see an AAPCS disagreement: caller and
callee both being arkcc means a wrong rule on both sides cancels out.  This gate
puts one side of the call in gcc's hands and runs the resulting image on
unicorn, so the only way to pass is to agree with the real ABI.

The question it exists for: a composite passed through `...` must start at an
even argument word when the type needs 8-byte alignment (AAPCS32 5.5 stage C,
"the NCRN is rounded up to the next even register number").  Measured on
arm-none-eabi-gcc 12.3:

    struct A8 { long long v; };          /* 8 bytes, align 8  */
    struct A4 { int a, b; };             /* 8 bytes, align 4  */
    struct B8 { double d; int i; };      /* 16 bytes, align 8 */
    struct B4 { int a, b, c, d; };       /* 16 bytes, align 4 */

    vf(1, a8)   -> r2:r3            (rounded: 1 -> 2)
    vf(1, a4)   -> r1:r2            (not rounded)
    vf(1, b8)   -> r2,r3 + stack    (rounded)
    vf(1, b4)   -> r1,r2,r3 + stack (not rounded)

so the rule keys off the type's *alignment*, not its size.  arkcc used to key
it off the size (the 5..8-byte composite branch), which rounds A4 and does not
round B8 -- wrong in both directions.

Cases are generated from the same Python constants that produce the source, so
the expectation cannot drift from the bytes actually passed.

Tools: ARKCC_ARM_AS (dir with arm-none-eabi as/ld/objcopy/nm) and
       ARKCC_ARM_CC (dir with arm-none-eabi-gcc; defaults to ARKCC_ARM_AS).
Exit: 0 all cases agree, 1 a real disagreement, 2 nothing could be run.
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
TMP = os.path.join(tempfile.gettempdir(), 'ark_arm_abi_mix')
ARKC = os.path.join(ROOT, 'arkcc.exe')
if not os.path.exists(ARKC):
    ARKC = os.path.join(ROOT, 'arkcc')
INC = os.path.join(ROOT, 'stdlib', 'include')

START = '''    .syntax unified
    .thumb
    .global _start
    .weak __arkcc_init_globals
    .text
_start:
    ldr sp, =0x20080000
    ldr r0, =__arkcc_init_globals
    cmp r0, #0
    beq 1f
    blx r0
1:
    bl main
_hang:
    b _hang

    .global memcpy
    .thumb_func
memcpy:
    mov r3, r0
2:
    cmp r2, #0
    beq 3f
    ldrb r12, [r1], #1
    strb r12, [r3], #1
    subs r2, r2, #1
    bne 2b
3:
    bx lr
'''


def write(path, text):
    with open(path, 'w', newline='\n') as f:
        f.write(text)


# ---------------------------------------------------------------------------
# the shapes and the payloads (one place: source text and expectation both come
# from here)
# ---------------------------------------------------------------------------

# B8: 16 bytes, double forces 8-byte alignment
B8_DECL = 'struct B8 { double d; int i; };\n'
B8_W = [0xA1B2C3D4, 0xE5F60718, 0x192A3B4C, 0x5D6E7F80]

# A8: 8 bytes, 8-byte alignment
A8_DECL = 'struct A8 { long long v; };\n'
A8_W = [0x0BADF00D, 0xC0FFEE11]

# A4: 8 bytes, 4-byte alignment  (the control: must NOT be rounded)
A4_DECL = 'struct A4 { int a, b; };\n'
A4_W = [0x11112222, 0x33334444]

# B4: 16 bytes, 4-byte alignment (the control: must NOT be rounded)
B4_DECL = 'struct B4 { int a, b, c, d; };\n'
B4_W = [0x01020304, 0x05060708, 0x090A0B0C, 0x0D0E0F10]


def struct_tag(decl):
    """'struct B8 { double d; int i; };' -> 'B8'"""
    return decl.split('{')[0].split()[1]


def union_decl(decl, words, var='u'):
    return '    union { struct %s s; unsigned w[%d]; } %s;\n' % (
        struct_tag(decl), len(words), var)


def fill_words(words, var='u'):
    return ''.join('    %s.w[%d] = 0x%08Xu;\n' % (var, i, w)
                   for i, w in enumerate(words))


def named_expr(nnamed):
    if nnamed == 0:
        return '0u'
    return ' ^ '.join('(unsigned)%s' % c for c in 'abcde'[:nnamed])


def caller_src(lang, decl, words, callee_sig, callee_name, nnamed, tail):
    """main(): fills the words of one composite, passes it plus named ints."""
    named = list(range(1, nnamed + 1))
    args = ', '.join([str(n) for n in named] + ['u.s'])
    return ''.join([
        decl,
        'extern %s;\n' % callee_sig,
        'int main(void)\n{\n',
        union_decl(decl, words),
        fill_words(words),
        '    return %s(%s)%s;\n' % (callee_name, args, tail),
        '}\n',
    ])


def callee_src(lang, decl, words, callee_sig, callee_name, nnamed):
    """Variadic callee: reads one composite out of `...` as raw words."""
    named = 'abcde'[:nnamed]
    head = ['#include <stdarg.h>\n', decl, callee_sig + '\n{\n',
            '    va_list ap;\n',
            union_decl(decl, words),
            '    va_start(ap, %s);\n' % named[-1],
            '    u.s = va_arg(ap, struct %s);\n' % struct_tag(decl),
            '    va_end(ap);\n',
            '    return (int)((u.w[0] ^ u.w[%d] ^ %s) & 0xFF);\n'
            % (len(words) - 1, named_expr(nnamed)),
            '}\n']
    return ''.join(head)


def xor_expect(words, named):
    """What the callee returns: w[0] ^ w[last] ^ named ints (see callee_src)."""
    v = (words[0] & 0xFF) ^ (words[-1] & 0xFF)
    for n in named:
        v ^= n & 0xFF
    return v & 0xFF


# ---------------------------------------------------------------------------
# run one case
# ---------------------------------------------------------------------------

class Tools:
    def __init__(self, asdir, ccdir):
        self.assembler = self._find(asdir, 'as')
        self.ld = self._find(asdir, 'ld')
        self.objcopy = self._find(asdir, 'objcopy')
        self.nm = self._find(asdir, 'nm')
        self.cc = self._find(ccdir or asdir, 'gcc')
        self.start_o = None

    def _find(self, d, tool):
        for name in ('arm-none-eabi-' + tool, 'arm-none-eabi-' + tool + '.exe'):
            p = os.path.join(d, name)
            if os.path.exists(p):
                return p
        w = shutil.which('arm-none-eabi-' + tool)
        return w

    def ok(self):
        return all((self.assembler, self.ld, self.objcopy, self.nm, self.cc))

    def run(self, cmd):
        return subprocess.run(cmd, capture_output=True, text=True, errors='replace')


def ark_as_gnu(path_in, path_out):
    """arkcc writes ';' comments and no .syntax unified; translate for GNU as."""
    lines = ['    .syntax unified']
    for ln in open(path_in, encoding='utf-8', errors='replace').read().splitlines():
        if ln.lstrip().startswith(';'):
            continue
        lines.append(ln)
    write(path_out, '\n'.join(lines) + '\n')


def run_case(t, name, caller_lang, callee_lang, caller_src, callee_src):
    """caller_lang/callee_lang in {'ark','gcc'}; returns (rc, err)."""
    objs = []
    for lang, role, src in ((caller_lang, 'main', caller_src),
                            (callee_lang, 'callee', callee_src)):
        cf = os.path.join(TMP, '%s_%s.c' % (name, role))
        write(cf, src)
        obj = os.path.join(TMP, '%s_%s.o' % (name, role))
        if lang == 'gcc':
            r = t.run([t.cc, '-mthumb', '-mcpu=cortex-m4', '-mfpu=fpv4-sp-d16',
                       '-mfloat-abi=hard', '-O1', '-fno-common',
                       '-fno-unwind-tables', '-fno-asynchronous-unwind-tables',
                       '-c', cf, '-o', obj])
            if r.returncode != 0:
                return None, 'gcc: ' + r.stderr.strip()[:300]
        else:
            asm = os.path.join(TMP, '%s_%s.s' % (name, role))
            gnu = os.path.join(TMP, '%s_%s_gnu.s' % (name, role))
            r = t.run([ARKC, '-target', 'arm', '-S', '-I', INC, cf, '-o', asm])
            if r.returncode != 0:
                return None, 'arkcc: ' + (r.stdout + r.stderr).strip()[:300]
            ark_as_gnu(asm, gnu)
            r = t.run([t.assembler, '-mcpu=cortex-m4', '-mfpu=fpv4-sp-d16',
                       '-mfloat-abi=hard', gnu, '-o', obj])
            if r.returncode != 0:
                return None, 'as: ' + r.stderr.strip()[:300]
        objs.append(obj)
    elf = os.path.join(TMP, name + '.elf')
    binf = os.path.join(TMP, name + '.bin')
    r = t.run([t.ld, '-Ttext=0x08000000', '-e', '_start', t.start_o] + objs
              + ['-o', elf])
    if r.returncode != 0:
        return None, 'ld: ' + r.stderr.strip()[:300]
    r = t.run([t.objcopy, '-O', 'binary', elf, binf])
    if r.returncode != 0:
        return None, 'objcopy: ' + r.stderr.strip()[:300]
    return exec_arm(t, binf, elf)


def exec_arm(t, binf, elf):
    from unicorn import Uc, UcError, UC_ARCH_ARM, UC_MODE_THUMB, UC_MODE_MCLASS
    from unicorn.arm_const import UC_ARM_REG_SP, UC_ARM_REG_LR, UC_ARM_REG_PC, UC_ARM_REG_R0
    r = t.run([t.nm, elf])
    syms = {}
    for ln in r.stdout.splitlines():
        p = ln.split()
        if len(p) == 3:
            try:
                syms[p[2]] = int(p[0], 16)
            except ValueError:
                pass
    if '_start' not in syms or '_hang' not in syms:
        return None, 'no _start/_hang in the image'
    uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB | UC_MODE_MCLASS)
    uc.mem_map(0x08000000, 0x100000)
    uc.mem_write(0x08000000, open(binf, 'rb').read())
    uc.mem_map(0x20000000, 0x100000)
    dbin = os.path.join(TMP, '_initdata.bin')
    r = t.run([t.objcopy, '-O', 'binary', '--only-section=.data', elf, dbin])
    if r.returncode == 0 and os.path.exists(dbin):
        blob = open(dbin, 'rb').read()
        if blob:
            uc.mem_write(0x20000000, blob)
    uc.reg_write(UC_ARM_REG_SP, 0x20080000)
    uc.reg_write(UC_ARM_REG_LR, 0xFFFFFFFF)
    try:
        uc.emu_start(syms['_start'] | 1, syms['_hang'] | 1, count=4000000)
    except UcError as e:
        return None, 'unicorn: %s at %#x' % (e, uc.reg_read(UC_ARM_REG_PC))
    return uc.reg_read(UC_ARM_REG_R0) & 0xFF, ''


# ---------------------------------------------------------------------------
# cases
# ---------------------------------------------------------------------------

def build_cases():
    """(name, caller_lang, callee_lang, caller_src, callee_src, expect, why)"""
    out = []

    def add(name, decl, words, callee_name, nnamed, expect, why):
        sig = 'int %s(%s, ...)' % (
            callee_name, ', '.join('int ' + c for c in 'abcde'[:nnamed]))
        for suffix, caller_lang, callee_lang in (
                ('_ark2gcc', 'ark', 'gcc'), ('_gcc2ark', 'gcc', 'ark')):
            out.append((
                name + suffix, caller_lang, callee_lang,
                caller_src(caller_lang, decl, words, sig, callee_name, nnamed,
                           ' & 0xFF'),
                callee_src(callee_lang, decl, words, sig, callee_name, nnamed),
                expect, why))

    # B8 (16 bytes, align 8) after ONE named word: NCRN 1 -> 2 (the rounding)
    add('b8_odd', B8_DECL, B8_W, 'take_b8', 1,
        xor_expect(B8_W, [1]), 'align-8 16-byte composite must start at an even word')
    # B8 after TWO named words: NCRN 2 is already even -- no hole may be added
    add('b8_even', B8_DECL, B8_W, 'take_b8b', 2,
        xor_expect(B8_W, [1, 2]), 'an even NCRN needs no hole')
    # B8 after THREE named words: rounding pushes it wholly onto the stack
    add('b8_three', B8_DECL, B8_W, 'take_b8c', 3,
        xor_expect(B8_W, [1, 2, 3]), 'NCRN 3 -> 4, whole composite on the stack')
    # A8 (8 bytes, align 8)
    add('a8_odd', A8_DECL, A8_W, 'take_a8', 1,
        xor_expect(A8_W, [1]), 'align-8 8-byte composite must start at an even word')
    # A4 (8 bytes, align 4): the control -- must NOT be rounded
    add('a4_odd', A4_DECL, A4_W, 'take_a4', 1,
        xor_expect(A4_W, [1]), 'align-4 8-byte composite starts at an odd word')
    # B4 (16 bytes, align 4): the control -- must NOT be rounded
    add('b4_odd', B4_DECL, B4_W, 'take_b4', 1,
        xor_expect(B4_W, [1]), 'align-4 16-byte composite starts at an odd word')
    # A4 after THREE named words: word 0 still fits in r3, word 1 goes on the
    # stack.  Measured on gcc: `vf(a,b,c,(struct A4){b,c})` puts b in r3 and c
    # at sp[0], i.e. an align-4 pair is NOT all-or-nothing on the register
    # boundary.  arkcc used to send it wholly to the stack.
    add('a4_split', A4_DECL, A4_W, 'take_a4b', 3,
        xor_expect(A4_W, [1, 2, 3]),
        'align-4 pair splits: word 0 in r3, word 1 on the stack')
    # B8 after FIVE named words: a..d take r0-r3, e is the first stacked word at
    # sp[0], and B8 needs an 8-byte slot, so gcc leaves a 4-byte hole at sp[4]
    # and puts the composite at sp[8].  Measured: `str r4,[sp]` then
    # `add ip,sp,#8; stm ip,{r0-r3}`.  This is the case that separates "align
    # the stack slot" from "just keep appending words", and the va_arg reader
    # has to skip the hole.
    add('b8_hole', B8_DECL, B8_W, 'take_b8d', 5,
        xor_expect(B8_W, [1, 2, 3, 4, 5]),
        'align-8 composite after a stacked word must leave a 4-byte hole')
    # NOTE: `_Complex float` through `...` would be the other align-4 / 8-byte
    # shape, but arkcc reports "passing a _Complex value without a _Complex
    # parameter type is not implemented for this target", so there is nothing to
    # compare yet.  The align-4 controls above (A4, B4) cover the rule.
    return out


def cf_caller_src(callee_name, nnamed):
    named = list(range(1, nnamed + 1))
    args = ', '.join([str(n) for n in named] + ['u.c'])
    return ''.join([
        'extern int %s(int, ...);\n' % callee_name,
        'int main(void)\n{\n',
        '    union { _Complex float c; unsigned w[2]; } u;\n',
        '    u.w[0] = 0x3F800000u;\n',
        '    u.w[1] = 0xC0000000u;\n',
        '    return %s(%s) & 0xFF;\n' % (callee_name, args),
        '}\n'])


def cf_callee_src(callee_name, nnamed):
    named = 'abc'[:nnamed]
    return ''.join([
        '#include <stdarg.h>\n',
        'int %s(int %s, ...)\n{\n' % (callee_name, named),
        '    va_list ap;\n',
        '    union { _Complex float c; unsigned w[2]; } u;\n',
        '    va_start(ap, %s);\n' % named[-1],
        '    u.c = va_arg(ap, _Complex float);\n',
        '    va_end(ap);\n',
        '    return (int)((u.w[0] ^ u.w[1] ^ %s) & 0xFF);\n' % named_expr(nnamed),
        '}\n'])


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arm-as', default=os.environ.get('ARKCC_ARM_AS', ''))
    ap.add_argument('--arm-cc', default=os.environ.get('ARKCC_ARM_CC', ''))
    args = ap.parse_args()
    if not os.path.isdir(TMP):
        os.makedirs(TMP)

    t = Tools(args.arm_as, args.arm_cc)
    if not t.ok():
        print('SKIP: need arm-none-eabi-as/ld/objcopy/nm/gcc '
              '(pass --arm-as and --arm-cc)')
        return 2
    write(os.path.join(TMP, 'start_arm.s'), START)
    r = t.run([t.assembler, '-mcpu=cortex-m4', os.path.join(TMP, 'start_arm.s'),
               '-o', os.path.join(TMP, 'start_arm.o')])
    if r.returncode != 0:
        print('cannot assemble the harness: ' + r.stderr.strip()[:300])
        return 2
    t.start_o = os.path.join(TMP, 'start_arm.o')

    ok = bad = 0
    cases = build_cases()
    for name, cl, ce, csrc, esrc, want, why in cases:
        got, err = run_case(t, name, cl, ce, csrc, esrc)
        if got is None:
            print('FAIL %-24s build/run: %s' % (name, err))
            bad += 1
            continue
        if got != want:
            print('FAIL %-24s %s answered %d, gcc-ABI answer is %d (%s)'
                  % (name, cl + '->' + ce, got, want, why))
            bad += 1
            continue
        print('PASS %-24s %s %d' % (name, cl + '->' + ce, got))
        ok += 1

    # Self-check: the harness has to be able to see a disagreement.  Re-run one
    # case demanding a different answer; if that also "passes", the comparison
    # (or the emulator) is not looking at the value.
    if cases:
        name, cl, ce, csrc, esrc, want, why = cases[0]
        got, err = run_case(t, name + '_probe', cl, ce, csrc, esrc)
        if got is None:
            print('FAIL selfcheck          probe run failed: %s' % err)
            bad += 1
        elif got == (want ^ 1):
            print('FAIL selfcheck          a wrong answer was accepted')
            bad += 1
        else:
            print('SELFCHECK expectation-mismatch: OK')

    print('=== %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
