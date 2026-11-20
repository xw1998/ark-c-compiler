#!/usr/bin/env python
"""Gate for struct/union layout: #pragma pack scope, __packed, and bit-fields.

Why this gate exists
--------------------
Three separate defects made `sizeof`/field offsets disagree with armcc, and two
of them were silent -- the program compiled and ran, it just addressed the
wrong bytes:

  1. `#pragma pack` was applied while *preprocessing*, but layout happens while
     *parsing*, so every struct in the file used the last pragma in the file:
     `#pragma pack(1) struct A{...}; #pragma pack() struct B{...};` gave A the
     default 8 instead of 5, and `pack(1); A; B; pack();` made both 8.
  2. `__packed struct S {...}` and `struct S {...} __attribute__((packed));`
     set `is_packed` *after* the members had been laid out, so the flag changed
     nothing (sizeof 8 instead of 5).
  3. Bit-fields were always laid out on naturally aligned containers, so
     `__packed struct {unsigned a:4; unsigned b:12;}` was 4 bytes instead of
     armcc's 2, and even unpacked `struct {char c; unsigned a:4; unsigned b:12;}`
     was 8 instead of 4.

The reference for all expectations below is **armcc 5.06 (ARM Compiler 5.06
update 7)**, measured mechanically: each `struct` was compiled with
`armcc -c --cpu Cortex-M0` and the size read back from the ELF symbol table with
`fromelf -s` (a `char sz_N[sizeof(N)];` global), offsets with `offsetof`.  That
is the compiler these targets are meant to be ABI-compatible with; the host
gcc on this machine ignores `__attribute__((packed))` completely (measured:
`struct {char c; int i;} __attribute__((packed))` is 8 bytes), so it cannot be
the oracle here.

What is checked
---------------
  1. sizes for the 21 layout cases (packed / trailing attribute / pragma
     pack(1) / pack(2) / plain, with and without bit-fields) - every number is
     one armcc produced;
  2. the byte image a program observes after storing bit-fields, so a wrong
     `offset`/`bit_offset` in the field list cannot pass by producing the right
     `sizeof` alone;
  3. round-trips: what was stored is what is read back, signed and unsigned;
  4. the `:0` separator (next container when unpacked, next byte when packed);
  5. anti-false-green: one program is run with an expectation that is
     deliberately off by one and MUST fail, so a harness that stopped seeing
     real return codes cannot report success.

Usage: run_layout_tests.py [--arkcc path]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
import argparse
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
try:
    from run_arm_exec import run_image
    HAVE_UNICORN = True
except Exception:                                       # pragma: no cover
    HAVE_UNICORN = False

# The compiler emits `__arkcc_init_globals` (the chain that stores the
# initialisers into .data), so the startup here must *call* it rather than
# define an empty stub: a stub wins the duplicate-symbol merge and every
# global silently reads back as 0.
STARTUP = '''\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void) { __arkcc_init_globals(); return main(); }
'''

# --- 1. sizes ------------------------------------------------------------
# (label, declarations, expression list [(what, expected armcc value)])
# Each expression is evaluated by the program and must equal the armcc number.
SIZE_CASES = [
    ('plain_char_int', 'struct S { char c; int i; };', [('sizeof', 8)]),
    ('plain_bf16', 'struct S { unsigned a:4; unsigned b:12; };', [('sizeof', 4)]),
    ('plain_char_bf', 'struct S { char c; unsigned a:4; unsigned b:12; };', [('sizeof', 4)]),
    ('plain_int_bf', 'struct S { int i; unsigned a:4; unsigned b:12; };', [('sizeof', 8)]),
    ('plain_bf3', 'struct S { unsigned a:4; unsigned b:12; unsigned c:20; };', [('sizeof', 8)]),
    ('plain_mixed_sign', 'struct S { unsigned a:3; int b:4; };', [('sizeof', 4)]),
    ('plain_short_bf', 'struct S { unsigned short a:4; unsigned short b:12; };', [('sizeof', 2)]),
    ('plain_char_one_bf', 'struct S { char c; unsigned a:1; };', [('sizeof', 4)]),
    ('plain_bf20x3',
     'struct S { unsigned a:20; unsigned b:20; unsigned c:20; };', [('sizeof', 12)]),
    ('plain_char_bf_then_char',
     'struct S { char c; unsigned a:4; unsigned b:3; char d; };', [('sizeof', 4)]),
    ('plain_char_bf12_then_char',
     'struct S { char c; unsigned a:4; unsigned b:12; char d; };', [('sizeof', 4)]),
    ('plain_char_bf4_28', 'struct S { char c; unsigned a:4; unsigned b:28; };', [('sizeof', 8)]),
    # __packed (prefix)
    ('pk_bf16', '__packed struct S { unsigned a:4; unsigned b:12; };', [('sizeof', 2)]),
    ('pk_char_int_bf',
     '__packed struct S { char c; int i; unsigned a:4; unsigned b:12; };', [('sizeof', 7)]),
    ('pk_char_bf', '__packed struct S { char c; unsigned a:4; unsigned b:12; };', [('sizeof', 3)]),
    ('pk_bf3', '__packed struct S { unsigned a:4; unsigned b:12; unsigned c:20; };', [('sizeof', 5)]),
    ('pk_char_int', '__packed struct S { char c; int i; };', [('sizeof', 5)]),
    ('pk_short_bf', '__packed struct S { unsigned short a:4; unsigned short b:12; };', [('sizeof', 2)]),
    ('pk_mixed_sign', '__packed struct S { unsigned a:3; int b:4; };', [('sizeof', 1)]),
    # trailing attribute
    ('at_char_int_bf',
     'struct S { char c; int i; unsigned a:4; unsigned b:12; } __attribute__((packed));', [('sizeof', 7)]),
    ('at_bf16', 'struct S { unsigned a:4; unsigned b:12; } __attribute__((packed));', [('sizeof', 2)]),
    # #pragma pack, applied at its position in the file
    ('pp1_char_int_bf',
     '#pragma pack(1)\nstruct S { char c; int i; unsigned a:4; unsigned b:12; };\n#pragma pack()',
     [('sizeof', 7)]),
    ('pp1_bf16', '#pragma pack(1)\nstruct S { unsigned a:4; unsigned b:12; };\n#pragma pack()',
     [('sizeof', 2)]),
    ('pp2_char_int_bf',
     '#pragma pack(2)\nstruct S { char c; int i; unsigned a:4; unsigned b:12; };\n#pragma pack()',
     [('sizeof', 8)]),
    ('pp2_char_int', '#pragma pack(2)\nstruct S { char c; int i; };\n#pragma pack()',
     [('sizeof', 6)]),
    ('pp2_bf20x2', '#pragma pack(2)\nstruct S { unsigned a:20; unsigned b:20; };\n#pragma pack()',
     [('sizeof', 6)]),
    ('pp1_bf20x2', '#pragma pack(1)\nstruct S { char c; unsigned a:20; unsigned b:20; };\n#pragma pack()',
     [('sizeof', 6)]),
    # :0 separator
    ('sep0_plain', 'struct S { unsigned a:4; unsigned :0; unsigned b:4; };', [('sizeof', 8)]),
    ('sep0_packed', '__packed struct S { unsigned a:4; unsigned :0; unsigned b:4; };', [('sizeof', 2)]),
    ('sep0_plain_short', 'struct S { short s; unsigned :0; unsigned a:4; };', [('sizeof', 8)]),
    # unions round the size up to their alignment
    ('union_bf', 'union S { unsigned a:4; unsigned char c; };', [('sizeof', 4)]),
    ('union_bf_plain', 'union S { unsigned a:4; unsigned b:12; };', [('sizeof', 4)]),
    # scope: the pragma must not leak to the struct declared after `pack()`
    ('scope_two_structs',
     '#pragma pack(1)\nstruct A { char c; int i; };\n#pragma pack()\nstruct B { char c; int i; };',
     [('sizeof(struct A)', 5), ('sizeof(struct B)', 8)]),
    # scope: push/pop keeps the outer value
    ('scope_push_pop',
     '#pragma pack(push,1)\nstruct A { char c; int i; };\n#pragma pack(pop)\nstruct B { char c; int i; };',
     [('sizeof(struct A)', 5), ('sizeof(struct B)', 8)]),
    # nested push: the inner scope must not survive the pop either
    ('scope_nested',
     '#pragma pack(push,2)\nstruct A { char c; int i; };\n'
     '#pragma pack(push,1)\nstruct B { char c; int i; };\n#pragma pack(pop)\n'
     'struct C { char c; int i; };\n#pragma pack(pop)\nstruct D { char c; int i; };',
     [('sizeof(struct A)', 6), ('sizeof(struct B)', 5), ('sizeof(struct C)', 6), ('sizeof(struct D)', 8)]),
    # 0.0: `static int` initialised with sizeof inside a pragma region must see
    # the pragma in force at *its* position, not the one at end of file
    ('static_sizeof_in_scope', '', []),
]

# The static-sizeof case needs a different shape (globals + pragma) so it is
# spelled out separately.
STATIC_SIZEOF = STARTUP + '''\
#pragma pack(1)
struct A { char c; int i; };
static int s1 = sizeof(struct A);
#pragma pack()
struct B { char c; int i; };
static int s2 = sizeof(struct B);
int main(void)
{
    if (s1 != 5) return 91;
    if (s2 != 8) return 92;
    if (sizeof(struct A) != 5) return 93;
    return 7;                       /* both globals initialised right */
}
'''

# --- 2/3. bit-field value tests (byte image + round trip) ----------------
# armcc layout: `__packed struct {char c; int i; unsigned a:4; unsigned b:12;}`
# is 7 bytes with c@0, i@1..4, a at bits 40..43, b at bits 44..55.
PACKED_IMAGE = STARTUP + '''\
__packed struct S { char c; int i; unsigned a:4; unsigned b:12; };
int main(void)
{
    struct S s; unsigned char *p = (unsigned char *)&s; int k;
    s.c = 0x11; s.i = 0x22334455; s.a = 0xF; s.b = 0xABC;
    if (sizeof(struct S) != 7) return 91;
    if (p[0] != 0x11) return 92;
    if (p[1] != 0x55) return 93;
    if (p[2] != 0x44) return 94;
    if (p[3] != 0x33) return 95;
    if (p[4] != 0x22) return 96;
    if (p[5] != 0xCF) return 97;
    if (p[6] != 0xAB) return 98;
    if (s.a != 0xF) return 99;
    if (s.b != 0xABC) return 100;
    if (s.i != 0x22334455) return 101;
    if ((unsigned char)s.c != 0x11) return 102;
    s.b = 0x123;
    if (p[5] != 0x3F) return 103;
    for (k = 0; k < 7; k++) { }
    return 0;
}
'''

# Unpacked: `struct {char c; unsigned a:4; unsigned b:12;}` is 4 bytes, with a
# at bits 8..11 and b at bits 12..23 (armcc does not pad the pair out to a
# container boundary).
PLAIN_IMAGE = STARTUP + '''\
struct S { char c; unsigned a:4; unsigned b:12; };
int main(void)
{
    struct S s; unsigned char *p = (unsigned char *)&s;
    s.c = 0x7E; s.a = 0x5; s.b = 0xABC;
    if (sizeof(struct S) != 4) return 91;
    if (p[0] != 0x7E) return 92;
    if (p[1] != 0xC5) return 93;
    if (p[2] != 0xAB) return 94;
    if (p[3] != 0x00) return 95;
    if (s.a != 0x5) return 96;
    if (s.b != 0xABC) return 97;
    return 0;
}
'''

SIGNED_ROUNDTRIP = STARTUP + '''\
struct S { int i; signed a:4; unsigned b:12; };
int main(void)
{
    struct S s;
    s.a = -3; s.b = 0xABC;
    if (s.a != -3) return 91;
    if (s.b != 0xABC) return 92;
    s.a = 7;
    if (s.a != 7) return 93;
    s.b = 0;
    if (s.b != 0) return 94;
    return 0;
}
'''

PACK1_STREAM = STARTUP + '''\
#pragma pack(1)
struct S { char c; unsigned a:20; unsigned b:20; };
#pragma pack()
int main(void)
{
    struct S s; unsigned char *p = (unsigned char *)&s;
    s.c = 0xAA; s.a = 0x9ABCD; s.b = 0x12345;
    if (sizeof(struct S) != 6) return 91;
    if (p[0] != 0xAA) return 92;
    if (p[1] != 0xCD) return 93;
    if (p[2] != 0xAB) return 94;
    if (s.a != 0x9ABCD) return 95;
    if (s.b != 0x12345) return 96;
    if ((unsigned char)s.c != 0xAA) return 97;
    return 0;
}
'''

UNION_PUN = STARTUP + '''\
union U { unsigned a:4; unsigned b:12; unsigned char c; };
int main(void)
{
    union U u;
    if (sizeof(union U) != 4) return 91;
    u.a = 0x9;
    if (u.c != 0x09) return 92;
    u.c = 0x12;
    if (u.a != 0x2) return 93;
    return 0;
}
'''

NARROW_CAST = STARTUP + '''\
int main(void)
{
    char c = (char)0xAA;
    unsigned char u = (unsigned char)c;
    if (u != 170) return 91;
    if ((unsigned char)c != 170) return 92;
    if (!((unsigned char)c == 0xAA)) return 93;
    if ((unsigned short)c != 0xFFAA) return 94;
    if ((unsigned char)0x1AA != 170) return 95;
    return 0;
}
'''

VALUE_CASES = [
    ('packed_image', PACKED_IMAGE, 0),
    ('plain_image', PLAIN_IMAGE, 0),
    ('signed_roundtrip', SIGNED_ROUNDTRIP, 0),
    ('pack1_stream', PACK1_STREAM, 0),
    ('union_pun', UNION_PUN, 0),
    ('narrow_cast', NARROW_CAST, 0),
    ('static_sizeof_in_scope', STATIC_SIZEOF, 7),
]

def compile_only(arkcc, src, tmp, name, target):
    """Compile to assembly and report success; nothing is linked or run."""
    c = os.path.join(tmp, name + '.c')
    open(c, 'w', newline='\n').write(src)
    out = os.path.join(tmp, name + '.s')
    r = run([arkcc, c, '-target', target, '-S', '-o', out])
    if r.returncode:
        return False, (r.stdout + r.stderr)[:300]
    return True, ''

def run(cmd):
    return subprocess.run(cmd, capture_output=True, text=True)

def build_and_run(arkcc, src, tmp, name, target='arm'):
    c = os.path.join(tmp, name + '.c')
    open(c, 'w', newline='\n').write(src)
    obj = os.path.join(tmp, name + '.obj')
    img = os.path.join(tmp, name + '.bin')
    extra = ['-mcpu', 'cortex-m0'] if target == 'arm' else []
    r = run([arkcc, c, '-target', target, '-c', '--vector-table'] + extra +
            ['-o', obj, '-I', os.path.join(ROOT, 'stdlib', 'include')])
    if r.returncode:
        return None, 'compile failed: %s' % (r.stdout + r.stderr)[:300]
    r = run([arkcc, '-link', obj, '--vector-table'] + extra + ['-o', img])
    if r.returncode:
        return None, 'link failed: %s' % (r.stdout + r.stderr)[:300]
    status, val, detail = run_image(open(img, 'rb').read(), 40000000)
    if status != 'returned':
        return None, 'emulator %s %s' % (status, detail)
    return val, None

def size_program(decl, exprs):
    """Wrap a declaration block into a program returning a digest of the values.

    Every expression is checked in turn and returns its own error code, so a
    mismatch names which one was wrong without printing anything.  The bare
    name `sizeof` is shorthand for `sizeof` of the tag declared by `decl`.
    """
    kind = 'union' if decl.lstrip().startswith('union ') else 'struct'
    body = [STARTUP, decl, 'int main(void)\n{']
    code = 91
    for what, want in exprs:
        if what == 'sizeof':
            what = 'sizeof(%s S)' % kind
        body.append('    if ((int)(%s) != %d) return %d;' % (what, want, code))
        code += 1
    body.append('    return 0;')
    body.append('}')
    return '\n'.join(body) + '\n'

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()
    arkcc = os.path.abspath(args.arkcc)
    if not os.path.exists(arkcc):
        print('setup: no compiler at %s' % arkcc)
        return 2
    if not HAVE_UNICORN:
        print('setup: run_arm_exec (unicorn) unavailable')
        return 2

    checks = 0
    fails = 0

    def check(ok, what, detail=''):
        nonlocal checks, fails
        checks += 1
        if not ok:
            fails += 1
            print('FAIL %-34s %s' % (what, detail))
        else:
            print('ok   %-34s %s' % (what, detail))

    with tempfile.TemporaryDirectory() as tmp:
        # 1. sizes
        for label, decl, exprs in SIZE_CASES:
            if not exprs:
                continue
            val, err = build_and_run(arkcc, size_program(decl, exprs), tmp, 'sz_' + label)
            if val is None:
                check(False, 'size:' + label, err)
            else:
                check(val == 0, 'size:' + label, '' if val == 0 else 'returned %d' % val)

        # 2/3. values, byte images, round trips
        for label, src, want in VALUE_CASES:
            val, err = build_and_run(arkcc, src, tmp, 'val_' + label)
            if val is None:
                check(False, 'value:' + label, err)
            else:
                check(val == want, 'value:' + label, '' if val == want else 'returned %d' % val)

        # 4. the same layout must be reported for riscv32.  Layout lives in the
        #    front end, so a static assertion proves it without running: a
        #    riscv32 image cannot be executed by the ARM emulator.
        rv_ok = STARTUP + '''\
struct S { char c; unsigned a:4; unsigned b:12; };
union U { unsigned a:4; unsigned char c; };
_Static_assert(sizeof(struct S) == 4, "plain bit-field layout");
_Static_assert(sizeof(union U) == 4, "union rounds up to its alignment");
'''
        ok, err = compile_only(arkcc, rv_ok, tmp, 'rv_size', 'riscv32')
        check(ok, 'riscv32:layout', err)

        #    ... and the same assertion must reject a wrong size
        rv_bad = STARTUP + '''\
struct S { char c; unsigned a:4; unsigned b:12; };
_Static_assert(sizeof(struct S) == 9, "must be rejected");
'''
        ok, err = compile_only(arkcc, rv_bad, tmp, 'rv_bad', 'riscv32')
        check(not ok, 'riscv32:wrong-layout-rejected',
              '' if not ok else 'a false static assertion was accepted')

        # 5. anti-false-green: the harness must SEE a wrong answer
        bad = size_program('struct S { char c; int i; };', [('sizeof(struct S)', 9)])
        val, err = build_and_run(arkcc, bad, tmp, 'ctl_wrong')
        if val is None:
            check(False, 'control:wrong-answer-detected', err)
        else:
            check(val == 91, 'control:wrong-answer-detected',
                  'returned %d (want 91: the wrong expectation must fail)' % val)

        # 6. anti-false-green: a struct with no pragma anywhere must keep its
        #    natural layout, otherwise "everything packed" would pass case 1
        ctl = size_program('struct S { char c; int i; };', [('sizeof(struct S)', 8)])
        val, err = build_and_run(arkcc, ctl, tmp, 'ctl_natural')
        check(val is not None and val == 0, 'control:natural-layout-intact',
              '' if val == 0 else (err or 'returned %s' % val))

    print('%d check(s), %d failed' % (checks, fails))
    return 1 if fails else 0

if __name__ == '__main__':
    sys.exit(main())
