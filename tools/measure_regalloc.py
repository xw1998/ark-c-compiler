#!/usr/bin/env python3
"""Measure -fopt-regalloc on a real project, not on a test case.

Why this is a tool and not a gate
---------------------------------
`tests/run_regalloc_tests.py` is the gate: three claims, all of them pass/fail.
This script answers a different question that has no pass/fail answer -- *where*
does the allocator engage in real firmware, how much does it actually save per
file, and does anything get bigger?  A gate cannot ask that; a measurement can,
and its numbers are what gets quoted in the docs.

What it does, per translation unit and per arm:
  * `-S`  -> count of frame references (`[r6, #n]`), number of moved registers,
            and the size of the emitted text;
  * `-c`  -> the object size arkc actually wrote.

Every source in the project is compiled, including the ones that take minutes
(backend_arm.c is ~400 KB of C).  A file that fails to compile in either arm is
reported as a failure and *excluded from the totals*: averaging over a silently
missing file is how a measurement turns into a lie.

Usage:
    python tools/measure_regalloc.py --project mdk/STM32H743_ArkCC/ArkCC.uvprojx
    python tools/measure_regalloc.py --project ... --limit 5      # quick look
    python tools/measure_regalloc.py --file path.c -I ... -D ...  # one file

Exit: 0 measured (whatever the numbers), 1 something failed to compile,
      2 cannot run (no arkcc).
"""
import argparse
import os
import re
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)

FP = "-fopt-regalloc"


def project_sources(uvprojx):
    """<FilePath> entries ending in .c, resolved against the project directory."""
    base = os.path.dirname(os.path.abspath(uvprojx))
    with open(uvprojx, encoding="utf-8", errors="replace") as fh:
        text = fh.read()
    out = []
    for m in re.finditer(r"<FilePath>([^<]+)</FilePath>", text):
        rel = m.group(1).strip()
        if not rel.lower().endswith(".c"):
            continue
        out.append(os.path.normpath(os.path.join(base, rel.replace("\\", "/"))))
    return out


def comp(arkcc, src, extra, mode, dst):
    argv = [arkcc, src, "-target", "arm", mode, "-o", dst] + list(extra)
    p = subprocess.run(argv, capture_output=True, text=True, errors="replace")
    return p.returncode, (p.stdout + p.stderr)


def stat_text(path):
    with open(path, encoding="utf-8", errors="replace") as fh:
        t = fh.read()
    moved = len(re.findall(r"MOV (?:r0, r(?:8|9|10|11)|r(?:8|9|10|11), r0)", t))
    return {
        "refs": t.count("[r6, #"),
        "moved": moved,
        "bytes": os.path.getsize(path),
        "funcs": t.count("PUSH {r5, r6, r7, r") ,
    }


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--arkcc", default=None)
    ap.add_argument("--project", default=None, help="MDK .uvprojx to take -I/-D and the file list from")
    ap.add_argument("--file", action="append", default=[], help="extra/alternative source file")
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("-I", action="append", default=[])
    ap.add_argument("-D", action="append", default=[])
    ap.add_argument("--keep", action="store_true")
    ap.add_argument("--flag", action="append", default=[],
                    help="the arm to measure against the default (default: %s)" % FP)
    args = ap.parse_args(argv)

    arkcc = args.arkcc or os.path.join(ROOT, "arkcc.exe" if os.name == "nt" else "arkcc")
    if not os.path.exists(arkcc):
        print("[regalloc-measure] arkcc not found at %s; build first" % arkcc)
        return 2

    files = list(args.file)
    extra = []
    if args.project:
        files = project_sources(args.project) + files
        extra += ["--uvprojx", args.project]
    for d in args.I:
        extra += ["-I", d]
    for d in args.D:
        extra += ["-D", d]
    files = [f for f in files if os.path.exists(f)]
    if args.limit:
        files = files[:args.limit]
    if not files:
        print("[regalloc-measure] nothing to compile")
        return 2

    work = tempfile.mkdtemp(prefix="arkrameasure_")
    rows = []
    failed = 0
    for src in files:
        name = os.path.basename(src)
        tag = os.path.splitext(name)[0]
        s_off, o_off = os.path.join(work, tag + "_off.s"), os.path.join(work, tag + "_off.obj")
        s_on, o_on = os.path.join(work, tag + "_on.s"), os.path.join(work, tag + "_on.obj")
        rc, log = comp(arkcc, src, extra, "-S", s_off)
        if rc != 0:
            print("[FAIL] %-28s -S (default): %s" % (name, log.strip().splitlines()[0][:90]))
            failed += 1
            continue
        on_flags = extra + (args.flag or [FP])
        rc2, log2 = comp(arkcc, src, on_flags, "-S", s_on)
        if rc2 != 0:
            print("[FAIL] %-28s -S (%s): %s" % (name, FP, log2.strip().splitlines()[0][:90]))
            failed += 1
            continue
        rc3, log3 = comp(arkcc, src, extra, "-c", o_off)
        rc4, log4 = comp(arkcc, src, on_flags, "-c", o_on)
        if rc3 != 0 or rc4 != 0:
            print("[FAIL] %-28s -c: %s" % (name, (log3 or log4).strip().splitlines()[0][:90]))
            failed += 1
            continue
        a, b = stat_text(s_off), stat_text(s_on)
        rows.append({
            "name": name,
            "refs_off": a["refs"], "refs_on": b["refs"],
            "moved": b["moved"], "funcs": b["funcs"],
            "asm_off": a["bytes"], "asm_on": b["bytes"],
            "obj_off": os.path.getsize(o_off), "obj_on": os.path.getsize(o_on),
        })

    if not rows:
        print("[regalloc-measure] every file failed")
        return 1

    rows.sort(key=lambda r: (r["obj_off"] - r["obj_on"]), reverse=True)
    print("%-28s %8s %8s %8s %7s %6s" %
          ("file", "obj off", "obj on", "saved", "refs", "moved"))
    for r in rows:
        print("%-28s %8d %8d %8d %3d->%-3d %6d" %
              (r["name"], r["obj_off"], r["obj_on"], r["obj_off"] - r["obj_on"],
               r["refs_off"], r["refs_on"], r["moved"]))
    t_off = sum(r["obj_off"] for r in rows)
    t_on = sum(r["obj_on"] for r in rows)
    tot_refs_off = sum(r["refs_off"] for r in rows)
    tot_refs_on = sum(r["refs_on"] for r in rows)
    print("\nfiles=%d failed=%d" % (len(rows), failed))
    print("objects: %d -> %d bytes (%+d, %.2f%%)" %
          (t_off, t_on, t_on - t_off, 100.0 * (t_on - t_off) / t_off if t_off else 0.0))
    print("frame refs [r6, #n]: %d -> %d (%+d)" % (tot_refs_off, tot_refs_on, tot_refs_on - tot_refs_off))
    print("moved registers: %d across %d files" %
          (sum(r["moved"] for r in rows), sum(1 for r in rows if r["moved"])))
    bigger = [r["name"] for r in rows if r["obj_on"] > r["obj_off"]]
    if bigger:
        print("GREW: %s" % ", ".join(bigger))
    if not args.keep:
        for r in rows:
            for ext in ("_off.s", "_on.s", "_off.obj", "_on.obj"):
                p = os.path.join(work, os.path.splitext(r["name"])[0] + ext)
                if os.path.exists(p):
                    os.remove(p)
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
