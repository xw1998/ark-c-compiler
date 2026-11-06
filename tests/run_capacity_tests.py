#!/usr/bin/env python
"""Capacity gates: the host build must have no artificial limits.

Three checks, each aimed at a limit that used to be profile-shaped:

  1. objects   -- 120 .c files, one object each, linked into one image.
                  The old LD_MAX_OBJS was 64 and objects past it were merged
                  but their RAM window / __arkcc_init_globals body silently
                  skipped.  arkcc_config.h now gives the host 1024 and -link
                  reports the count instead of dropping.
  2. headers   -- one translation unit that includes 1200 distinct headers,
                  with -MMD.  The dependency list grows by doubling on the
                  host (ARKCC_FEATURE_DEP_FILES_DYN); the board keeps the
                  fixed table.  The .d file must name every header.
  3. include dirs -- 129 -I paths.  The old table held 16 and dropped the
                  rest without a word, which surfaced as "cannot open source
                  input file" for a header that was there.  128 is the host
                  table, so the 129th must be a reported error.

Exit code 0 = all three behaved.  No toolchain needed (host arkcc only).
"""
import os
import shutil
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ARKCC = os.path.join(ROOT, "arkcc.exe")
if not os.path.exists(ARKCC):
    ARKCC = os.path.join(ROOT, "arkcc")

N_OBJS = 120
N_HDRS = 1200
N_DIRS = 129

def run(args, cwd):
    p = subprocess.run([ARKCC] + args, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode("utf-8", "replace")

def case_objects(tmp):
    src = os.path.join(tmp, "obj")
    os.makedirs(src)
    objs = []
    for i in range(N_OBJS):
        name = "o%d" % i
        prev = "extern int f%d(void);\n" % (i - 1) if i else ""
        call = ("return f%d() + g%d;\n" % (i - 1, i)) if i else "return g0;\n"
        body = ("int g%d = %d;\n" % (i, i)) + prev + \
               ("int f%d(void) { %s}\n" % (i, call))
        with open(os.path.join(src, name + ".c"), "w") as f:
            f.write(body)
        rc, out = run(["-c", name + ".c", "-target", "arm", "--reloc-data",
                       "-o", name + ".o"], src)
        if rc != 0:
            return False, "object %d failed to compile:\n%s" % (i, out)
        objs.append(name + ".o")
    rc, out = run(["-link"] + objs + ["-target", "arm", "--reloc-data",
                                      "-o", "img.bin"], src)
    if rc != 0:
        return False, "linking %d objects failed (rc=%d):\n%s" % (N_OBJS, rc, out)
    path = os.path.join(src, "img.bin")
    if not os.path.exists(path):
        return False, "no image written for %d objects" % N_OBJS
    size = os.path.getsize(path)
    if size <= 0:
        return False, "image is empty"
    # every object contributes code, so the image cannot be tiny
    if size < N_OBJS * 8:
        return False, "image is only %d bytes for %d objects" % (size, N_OBJS)
    return True, "%d objects -> %d byte image" % (N_OBJS, size)

def case_headers(tmp):
    src = os.path.join(tmp, "hdr")
    os.makedirs(src)
    inc = os.path.join(src, "inc")
    os.makedirs(inc)
    for i in range(N_HDRS):
        with open(os.path.join(inc, "h%d.h" % i), "w") as f:
            f.write("#ifndef H%d_H\n#define H%d_H\nint v%d;\n#endif\n"
                    % (i, i, i))
    main_c = "".join('#include "h%d.h"\n' % i for i in range(N_HDRS))
    main_c += "int main(void) { return 0; }\n"
    with open(os.path.join(src, "main.c"), "w") as f:
        f.write(main_c)
    rc, out = run(["-c", "main.c", "-target", "arm", "-I", "inc", "-MMD",
                   "-o", "main.o"], src)
    if rc != 0:
        return False, "compiling %d headers failed:\n%s" % (N_HDRS, out)
    dep = os.path.join(src, "main.d")
    if not os.path.exists(dep):
        # -MMD may name the file after the output
        cand = [n for n in os.listdir(src) if n.endswith(".d")]
        if not cand:
            return False, "no dependency file written"
        dep = os.path.join(src, cand[0])
    text = open(dep, "r").read()
    got = text.count("h")  # cheap sanity, exact check below
    missing = [i for i in range(N_HDRS) if ("h%d.h" % i) not in text]
    if missing:
        return False, ("dependency file names %d of %d headers (first missing h%d.h)"
                       % (N_HDRS - len(missing), N_HDRS, missing[0]))
    return True, "%d headers all present in the dependency file" % N_HDRS

def case_incdirs(tmp):
    src = os.path.join(tmp, "dirs")
    os.makedirs(src)
    args = ["-c", "main.c", "-target", "arm"]
    for i in range(N_DIRS):
        d = os.path.join(src, "d%d" % i)
        os.makedirs(d)
        args += ["-I", "d%d" % i]
    with open(os.path.join(src, "main.c"), "w") as f:
        f.write("int main(void) { return 0; }\n")
    rc, out = run(args + ["-o", "main.o"], src)
    if rc == 0:
        return False, ("%d -I paths were accepted; the host table is supposed to "
                       "hold 128 and report the 129th" % N_DIRS)
    if "ARK_PP_MAX_INC_DIRS" not in out:
        return False, "the %dth -I was refused without saying why:\n%s" % (N_DIRS, out)
    return True, "%d -I paths -> reported error naming ARK_PP_MAX_INC_DIRS" % N_DIRS

def main():
    if not os.path.exists(ARKCC):
        print("arkcc not found at %s" % ARKCC)
        return 2
    tmp = tempfile.mkdtemp(prefix="arkcc_cap_")
    fails = 0
    try:
        for name, fn in (("objects", case_objects), ("headers", case_headers),
                         ("incdirs", case_incdirs)):
            ok, msg = fn(tmp)
            print("%-10s %s  %s" % (name, "PASS" if ok else "FAIL", msg))
            if not ok:
                fails += 1
    finally:
        shutil.rmtree(tmp, ignore_errors=True)
    print("capacity: %d passed, %d failed" % (3 - fails, fails))
    return 0 if fails == 0 else 1

if __name__ == "__main__":
    sys.exit(main())
