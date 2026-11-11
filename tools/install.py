#!/usr/bin/env python3
"""Install arkcc: the driver, the headers and the library sources it is meant to
be used with.

Why a script instead of shell lines in the Makefile
---------------------------------------------------
`install` has to work under cmd.exe + mingw32-make (the documented Windows dev
environment) *and* under a POSIX shell, and it has to be checkable: "the file is
there" is not the same as "the file that is there is the one we just built".
This script copies, then re-opens every destination and compares it byte for
byte with its source, and fails loudly if anything disagrees.  It never deletes
anything: an existing file is overwritten only after it has been read
successfully and only when its content actually differs.

Layout written under DESTDIR + PREFIX
-------------------------------------
    bin/arkcc[.exe]              the driver
    include/ark/*.h              the 22 standard headers the library expects
    lib/ark/src/*.c              the library sources (compiled per target, not
    lib/ark/src/arm/*            pre-built: what runtime an image needs is the
                                 linker's decision, see README)
    lib/ark/README.md            how to build the library for a target

Usage:
    python tools/install.py [--prefix DIR] [--destdir DIR] [--arkcc PATH]
                            [--dry-run]

`DESTDIR` is the staging root (distro packaging, `make install DESTDIR=/tmp/x`);
`PREFIX` is the path the compiler will live at on the target (`/usr/local`).
"""
import argparse
import os
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)

LIB_README = """\
# arkcc library

`src/` holds the C library sources; `include` lives at `../include/ark`.
Nothing here is pre-built: compile the sources for the target you are using,
because an image only links the pieces it needs (`aeabi.c` and
`aeabi_divmod.s` carry the 64-bit runtime for a flat ARM image, `stdio.c`
pulls in `putchar_default.c` only if you want the weak default).

Typical use, from a project directory:

    arkcc -target arm -c $(ARK_LIB)/src/stdlib.c     -o stdlib.obj
    arkcc -target arm -c $(ARK_LIB)/src/heap.c       -o heap.obj
    arkcc -target arm -c $(ARK_LIB)/src/string.c     -o string.obj
    arkcc -target arm -c $(ARK_LIB)/src/printf.c     -o printf.obj
    arkcc -target arm -c $(ARK_LIB)/src/arm/aeabi.c  -o aeabi.obj

Header search path: `-I $(PREFIX)/include/ark`.
"""


def fail(msg):
    sys.stderr.write('install: %s\n' % msg)
    sys.exit(1)


def same_file(a, b):
    try:
        if os.path.getsize(a) != os.path.getsize(b):
            return False
        with open(a, 'rb') as fa, open(b, 'rb') as fb:
            while True:
                x = fa.read(65536)
                y = fb.read(65536)
                if x != y:
                    return False
                if not x:
                    return True
    except OSError:
        return False


def put(src, dst, mode, dry, log):
    """Copy src -> dst, then prove dst now equals src."""
    if dry:
        log.append('would install %s' % dst)
        return 0
    parent = os.path.dirname(dst)
    if parent and not os.path.isdir(parent):
        os.makedirs(parent)
    if os.path.exists(dst) and same_file(src, dst):
        # Rewriting an identical file would only change its mtime; a stamp file
        # that has not changed must stay untouched for `make`'s sake.
        log.append('up to date    %s' % dst)
        return 0
    tmp = dst + '.arkinst'
    shutil.copyfile(src, tmp)
    if mode is not None:
        os.chmod(tmp, mode)
    if os.path.exists(dst):
        os.remove(dst)
    os.rename(tmp, dst)
    if not same_file(src, dst):
        fail('%s does not match its source after the copy' % dst)
    log.append('installed     %s' % dst)
    return 1


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--prefix', default=os.environ.get('PREFIX', '/usr/local'))
    ap.add_argument('--destdir', default=os.environ.get('DESTDIR', ''))
    ap.add_argument('--arkcc', default=os.path.join(
        ROOT, 'arkcc.exe' if os.name == 'nt' else 'arkcc'))
    ap.add_argument('--dry-run', action='store_true')
    args = ap.parse_args()

    if not os.path.isfile(args.arkcc):
        fail('%s does not exist -- run `make` first' % args.arkcc)

    # A DESTDIR that does not exist yet is normal (packaging), a PREFIX that is
    # relative is not: the installed paths end up in scripts and .sct files.
    if args.destdir:
        root = os.path.abspath(args.destdir)
        # PREFIX is the path the compiler will live at *inside* DESTDIR, so it
        # must be relative there.  An absolute PREFIX is not merely odd: on
        # Windows os.path.join() drops an absolute second element, so DESTDIR
        # would be silently ignored and the files would land in PREFIX itself.
        # MSYS/Git Bash produces exactly that by rewriting "/usr/local" into a
        # Windows absolute path before this script ever sees it.
        prefix_rel = args.prefix.lstrip('/\\')
        if os.path.isabs(prefix_rel) or (len(prefix_rel) > 1
                                         and prefix_rel[1] == ':'):
            fail('--prefix %r is absolute, so DESTDIR would be ignored; with '
                 'DESTDIR set, PREFIX must be a path inside it (e.g. usr/local).'
                 '  Under Git Bash/MSYS the shell rewrites "/usr/local" into a '
                 'Windows path -- pass Windows-style paths instead, or set '
                 'MSYS_NO_PATHCONV=1.' % args.prefix)
        dest = os.path.join(root, prefix_rel)
        if os.path.normpath(dest) != os.path.normpath(root) and \
                not os.path.normpath(dest).startswith(
                    os.path.normpath(root) + os.sep):
            fail('DESTDIR %r + PREFIX %r escapes the staging root (%r)'
                 % (args.destdir, args.prefix, dest))
    else:
        dest = args.prefix
    if not os.path.isabs(dest):
        fail('PREFIX/DESTDIR resolve to a relative path (%r); give an absolute '
             'one' % dest)

    if os.name == 'nt' and args.prefix in ('/usr/local', '\\usr\\local') and not args.destdir:
        sys.stderr.write(
            'install: note: PREFIX defaults to /usr/local, which on Windows '
            'resolves to %s; pass --prefix C:/ArkCC for a native layout\n'
            % os.path.abspath(dest))

    bindir = os.path.join(dest, 'bin')
    incdir = os.path.join(dest, 'include', 'ark')
    libdir = os.path.join(dest, 'lib', 'ark')

    log = []
    changed = 0

    exe_mode = None
    if os.name != 'nt':
        exe_mode = 0o755

    changed += put(args.arkcc, os.path.join(bindir, os.path.basename(args.arkcc)),
                   exe_mode, args.dry_run, log)

    inc_src = os.path.join(ROOT, 'stdlib', 'include')
    headers = sorted(h for h in os.listdir(inc_src) if h.endswith('.h'))
    if not headers:
        fail('%s has no headers' % inc_src)
    for h in headers:
        changed += put(os.path.join(inc_src, h), os.path.join(incdir, h),
                       None, args.dry_run, log)

    src_root = os.path.join(ROOT, 'stdlib', 'src')
    lib_sources = sorted(f for f in os.listdir(src_root)
                         if f.endswith('.c') or f.endswith('.s'))
    arm_sources = sorted(f for f in os.listdir(os.path.join(src_root, 'arm')))
    if not lib_sources:
        fail('%s has no sources' % src_root)
    for f in lib_sources:
        changed += put(os.path.join(src_root, f), os.path.join(libdir, 'src', f),
                       None, args.dry_run, log)
    for f in arm_sources:
        changed += put(os.path.join(src_root, 'arm', f),
                       os.path.join(libdir, 'src', 'arm', f),
                       None, args.dry_run, log)

    if not args.dry_run:
        readme = os.path.join(libdir, 'README.md')
        if not os.path.isdir(os.path.dirname(readme)):
            os.makedirs(os.path.dirname(readme))
        body = LIB_README.encode('utf-8')
        if os.path.exists(readme) and open(readme, 'rb').read() == body:
            log.append('up to date    %s' % readme)
        else:
            with open(readme, 'wb') as f:
                f.write(body)
            log.append('wrote         %s' % readme)

    for line in log:
        print(line)
    print('%s%d file(s) %s under %s'
          % ('dry run: ' if args.dry_run else '',
             len(log) if args.dry_run else changed,
             'would be installed' if args.dry_run else 'installed/updated',
             os.path.abspath(dest)))
    print('add %s to PATH; use -I %s when building against the library'
          % (bindir, incdir))
    return 0


if __name__ == '__main__':
    sys.exit(main())
