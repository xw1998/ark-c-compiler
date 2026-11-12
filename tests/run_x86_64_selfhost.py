#!/usr/bin/env python3
"""x86_64 self-host probe: arkcc compiles arkcc, then the self-compiled
compiler compiles a payload and must reproduce the host compiler's object
byte for byte.

The image cannot be loaded by Windows (a flat ARKOBJ2 image has no PE/ELF
header and no OS ABI), so it runs on unicorn and the probe replaces the host
I/O layer with an embedded source plus a RAM output buffer.  See
selfprobe.c for what that leaves under test.
"""
import argparse
import os
import struct
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
ARKCC = os.path.join(ROOT, 'arkcc.exe')
OUT = os.path.join(ROOT, 'build_x86_64_selfhost')
IMAGE_BASE = 0x400000
STACK_TOP = 0x20000000

DEFS = ['-DARK_POOL_SIZE=524288', '-DARK_ASM_BUF_SIZE=65536',
        '-DARK_CODE_BUF_SIZE=32768', '-DARK_LINK_BUF_SIZE=65536',
        '-DARK_OBJ_BUF_SIZE=65552', '-DPP_INC_BUF=8192',
        '-DPP_MAX_INC_DEPTH=8', '-DPP_BUF_SIZE=65536',
        '-DARK_LINK_MAX_SYMS=512', '-DARK_LINK_MAX_RELOCS=512']


def run(cmd, cwd=None):
    p = subprocess.run(cmd, cwd=cwd, capture_output=True)
    return p.returncode, (p.stdout + p.stderr).decode('utf-8', 'replace')


def syms_of(path):
    with open(path, 'rb') as f:
        d = f.read()
    if d[:8] != b'ARKOBJ2\n':
        raise SystemExit('not an ARKOBJ2 object: %s' % path)
    off = 8
    cs = struct.unpack_from('<i', d, off)[0]
    off += 4 + cs
    count = struct.unpack_from('<i', d, off)[0]
    off += 4
    out = {}
    for _ in range(count):
        nl = struct.unpack_from('<i', d, off)[0]
        off += 4
        name = d[off:off + nl].split(b'\0')[0].decode()
        off += nl
        so = struct.unpack_from('<i', d, off)[0]
        off += 6
        out[name] = so
    return out


def fnv(data):
    h = 2166136261
    for b in data:
        h = ((h ^ b) * 16777619) & 0xFFFFFFFF
    return h


def dump_log(uc, base, ps):
    """Print what the self-hosted compiler managed to say before it died."""
    if 'g_log' not in ps:
        print('(probe has no g_log symbol)')
        return
    raw = bytes(uc.mem_read(base + ps['g_log'], 32768))
    text = raw.split(b'\0')[0].decode('utf-8', 'replace')
    lines = text.splitlines()
    print('--- self-hosted compiler log (last %d lines) ---' % min(len(lines), 40))
    for line in lines[-40:]:
        print('  | ' + line)
    print('--- end log ---')


def main():
    global ARKCC
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc', default=ARKCC)
    args = ap.parse_args()
    ARKCC = os.path.abspath(args.arkcc)
    if not os.path.exists(ARKCC):
        print('SKIP: no arkcc at %s' % ARKCC)
        return 1
    try:
        import unicorn  # noqa: F401
    except Exception as exc:            # noqa: BLE001
        print('SKIP: unicorn unavailable (%s) -- x86-64 emulation' % exc)
        return 1
    os.makedirs(OUT, exist_ok=True)
    tus = []
    for d in ['src', 'src/backend']:
        for name in sorted(os.listdir(os.path.join(ROOT, d))):
            if name.endswith('.c'):
                tus.append(os.path.join(d, name))
    # main.c is the *host* CLI: it owns main(), stdio and malloc, none of which
    # belongs in the image (the probe supplies main(), libcstub.c supplies the
    # rest).  registry.c goes last so every backend is already referenced.
    tus = [t for t in tus if not t.endswith('registry.c')
           and not t.endswith('main.c')]
    for d in ['src/backend/arm', 'src/backend/c', 'src/backend/riscv32',
              'src/backend/x86_64']:
        for name in sorted(os.listdir(os.path.join(ROOT, d))):
            if name.endswith('.c'):
                tus.append(os.path.join(d, name))
    tus.append('src/backend/registry.c')
    # port/host/*.c is deliberately absent: selfprobe.c implements that layer.

    objs = []
    for tu in tus:
        o = os.path.join(OUT, os.path.basename(tu).replace('.c', '.o'))
        rc, msg = run([ARKCC, '-target', 'x86_64', '-c',
                       os.path.join(ROOT, tu), '-I', os.path.join(ROOT, 'include')]
                      + DEFS + ['-o', o])
        if rc != 0:
            print('FAIL self-compile %s\n%s' % (tu, msg[-2000:]))
            return 1
        objs.append(o)
    print('self-compiled %d translation units' % len(objs))

    probe_o = os.path.join(OUT, 'p_selfprobe.o')
    rc, msg = run([ARKCC, '-target', 'x86_64', '-c',
                   os.path.join(ROOT, 'tests', 'selfhost', 'selfprobe.c'),
                   '-I', os.path.join(ROOT, 'include'),
                   '-I', os.path.join(ROOT, 'tests', 'selfhost')]
                  + DEFS + ['-o', probe_o])
    if rc != 0:
        print('FAIL self-compile selfprobe.c\n%s' % msg[-2000:])
        return 1

    libc_o = os.path.join(OUT, 'p_libcstub.o')
    rc, msg = run([ARKCC, '-target', 'x86_64', '-c',
                   os.path.join(ROOT, 'tests', 'selfhost', 'libcstub.c'),
                   '-I', os.path.join(ROOT, 'include')] + DEFS + ['-o', libc_o])
    if rc != 0:
        print('FAIL self-compile libcstub.c\n%s' % msg[-2000:])
        return 1

    img = os.path.join(OUT, 'selfhost.bin')
    rc, msg = run([ARKCC, '-target', 'x86_64', '-link', probe_o, libc_o] + objs +
                  ['-o', img, '-v'])
    if rc != 0:
        print('FAIL link\n%s' % msg[-3000:])
        return 1
    code = open(img, 'rb').read()
    print('built self-host image: %d bytes' % len(code))

    ps = syms_of(probe_o)
    ls = syms_of(libc_o)
    # A symbol offset is relative to the object image it belongs to, so an
    # absolute address is IMAGE_BASE + object base + offset.  Object 0 is the
    # probe and object 1 is libcstub.c (the -v listing follows the link order).
    bases = []
    for line in msg.splitlines():
        if line.startswith('[link] object '):
            bases.append(int(line.split('base ')[1].split(',')[0], 16))
    if len(bases) != 2 + len(objs):
        print('FAIL could not read the link map (%d objects listed)' % len(bases))
        return 1
    for need in ('main', 'g_out_len', 'g_out_sum', 'g_probe_rc'):
        if need not in ps:
            print('FAIL probe object has no symbol %s' % need)
            return 1
    for need in ('g_stub_hits', 'g_snprintf_unknown'):
        if need not in ls:
            print('FAIL libc stub object has no symbol %s' % need)
            return 1

    from unicorn import Uc, UcError, UC_ARCH_X86, UC_MODE_64
    from unicorn.x86_const import UC_X86_REG_RAX, UC_X86_REG_RIP, UC_X86_REG_RSP
    uc = Uc(UC_ARCH_X86, UC_MODE_64)
    size = (len(code) + 0xFFF) & ~0xFFF
    uc.mem_map(IMAGE_BASE, max(size, 0x10000))
    uc.mem_write(IMAGE_BASE, code)
    uc.mem_map(STACK_TOP - 0x800000, 0x800000)
    sp = STACK_TOP - 0x1000
    uc.mem_write(sp, struct.pack('<Q', 0xDEADBEEF))
    uc.reg_write(UC_X86_REG_RSP, sp)
    try:
        uc.emu_start(IMAGE_BASE + ps['main'], 0xDEADBEEF, count=200000000)
    except UcError as exc:
        print('FAIL unicorn: %s at %#x' % (exc, uc.reg_read(UC_X86_REG_RIP)))
        dump_log(uc, IMAGE_BASE, ps)
        return 1

    def rd(name, table=None, obj=0):
        # Two of the counters live in libcstub.c (ls, object 1), not in the
        # probe (ps, object 0).
        raw = uc.mem_read(IMAGE_BASE + bases[obj] + (table or ps)[name], 4)
        return struct.unpack('<i', bytes(raw))[0]
    # Assembly text the self-hosted code generator produced.  Comparing it with
    # the host's -S output says whether a difference sits in the code
    # generator (text differs) or in the assembler (text equal, bytes do not).
    if 'g_asmout_len' in ps:
        alen = rd('g_asmout_len')
        if alen > 0:
            raw = bytes(uc.mem_read(IMAGE_BASE + bases[0] + ps['g_asmout'], alen))
            self_s = os.path.join(OUT, 'payload_self.s')
            with open(self_s, 'wb') as f:
                f.write(raw)
            ref_s = os.path.join(OUT, 'payload_ref.s')
            rc2, msg2 = run([ARKCC, '-target', 'x86_64', '-S',
                             os.path.join(ROOT, 'tests', 'selfhost', 'payload.c'),
                             '-o', ref_s], cwd=OUT)
            if rc2 == 0:
                a = raw.decode('utf-8', 'replace').splitlines()
                b = open(ref_s, 'rb').read().decode('utf-8', 'replace').splitlines()
                if a == b:
                    print('asm  : text identical (%d lines)' % len(a))
                else:
                    import difflib
                    diff = list(difflib.unified_diff(b, a, 'host.s', 'self.s', lineterm=''))
                    print('asm  : text DIFFERS (%d lines, %d diff lines)' % (len(a), len(diff)))
                    for line in diff[:60]:
                        print('   ' + line)
                    print('     self: %s' % self_s)
                    print('     host: %s' % ref_s)
            else:
                print('asm  : host -S failed: %s' % msg2[-400:])


    probe_rc = rd('g_probe_rc')
    self_len = rd('g_out_len')
    self_sum = rd('g_out_sum') & 0xFFFFFFFF
    print('probe: ark_compile rc=%d object=%d bytes fnv=%08x'
          % (probe_rc, self_len, self_sum))
    if probe_rc != 0:
        print('FAIL the self-hosted compiler returned an error')
        dump_log(uc, IMAGE_BASE, ps)
        return 1
    stubs = rd('g_stub_hits', ls, 1)
    unknown = rd('g_snprintf_unknown', ls, 1)
    print('probe: libc stubs hit %d (expected 0), unknown printf conversions %d'
          % (stubs, unknown))
    if stubs != 0 or unknown != 0:
        print('FAIL the compiler reached a stub: that path has no real '
              'implementation in this image')
        return 1

    # Reference: the same payload through the host-built arkcc, run from a
    # directory with no arkcc.cfg so that both sides start from config_init().
    ref = os.path.join(OUT, 'payload_ref.o')
    rc, msg = run([ARKCC, '-target', 'x86_64', '-c',
                   os.path.join(ROOT, 'tests', 'selfhost', 'payload.c'),
                   '-o', ref], cwd=OUT)
    if rc != 0:
        print('FAIL host reference compile\n%s' % msg[-2000:])
        return 1
    data = open(ref, 'rb').read()
    ref_len, ref_sum = len(data), fnv(data)
    print('host : object=%d bytes fnv=%08x' % (ref_len, ref_sum))
    if (self_len, self_sum) != (ref_len, ref_sum):
        # Keep both objects so the difference can be inspected instead of
        # guessed at: same length but a different digest means a codegen
        # difference, a different length means a structural one.
        got = os.path.join(OUT, 'payload_self.o')
        with open(got, 'wb') as f:
            f.write(bytes(uc.mem_read(IMAGE_BASE + bases[0] + ps['g_obj'],
                                      self_len)))
        print('FAIL mismatch: the self-hosted compiler did not reproduce the '
              'host object')
        print('     self: %s (%d bytes)' % (got, self_len))
        print('     host: %s (%d bytes)' % (ref, ref_len))
        return 1
    print('PASS self-host: byte-identical object')
    return 0


if __name__ == '__main__':
    sys.exit(main())
