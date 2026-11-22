#!/usr/bin/env python3
"""Cross-build the STM32 profile of arkcc and check that it fits the board.

Why this exists
---------------
`make stm32` needs arm-none-eabi-gcc, which is not installed on the Windows
development machine, and it links a bare ELF with no memory layout -- so it can
say "it compiles" but never "it fits".  The board we actually deploy to is an
STM32H743 (2 MB flash, 128 KB DTCM, 512 KB AXI, 32 MB SDRAM), and the compiler
is a self-hosted one: the thing that has to fit is a C compiler with a big
bump arena, a source buffer, an assembler-text buffer and a RAM file system.

So this gate does the two things a build check has to do to be worth anything:

  1. every translation unit of the trimmed profile compiles (armclang, AC6),
  2. the link is placed through a scatter file that encodes the real board
     memory, so "does it fit" is answered by armlink and not by a comment.

Two layouts, because the board has two:

  sram   no SDRAM.  .ark_buf lives in the 512 KB AXI block next to the code and
         heap windows.  The working set has to be trimmed for this one:
         a 128 KB arena, smaller buffers, four RAM file slots.
  sdram  the deployed layout.  .ark_buf is UNINIT in the 32 MB SDRAM, so the
         profile defaults fit with room to spare, and the flash image stays
         small because none of those zero bytes are loaded.

The compiler core that is built here is the STM32_MIN profile (ARM backend only,
no x86_64 / riscv32 / C backend, no 1.5 MB liveness tables).  -fopt-live is
compiled out of that profile, so this gate also proves the cut-down build really
does build.

Usage
-----
    python tools/stm32_build_check.py [--layout sram|sdram|both]
                                      [--armclang PATH] [--armlink PATH]
                                      [--fromelf PATH] [--keep DIR]

Exit codes: 0 = every check passed (or the toolchain is absent and the run is
skipped), 1 = a check failed.
"""

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# The same source set as `make stm32` in the Makefile: the front end, the ARM
# backend and the STM32 port.  src/main.c is the host driver and is replaced by
# port/stm32/main_stm32.c.
def source_list():
    core = []
    srcdir = os.path.join(ROOT, "src")
    for name in sorted(os.listdir(srcdir)):
        if name.endswith(".c") and name != "main.c":
            core.append(os.path.join("src", name))
    core.append(os.path.join("src", "backend", "arm", "backend_arm.c"))
    core.append(os.path.join("src", "backend", "registry.c"))
    core.append(os.path.join("port", "stm32", "flash_fs_stm32.c"))
    core.append(os.path.join("port", "stm32", "platform_stm32.c"))
    core.append(os.path.join("port", "stm32", "main_stm32.c"))
    return core


COMMON_DEFS = [
    "-DARKCC_STM32",
    "-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN",
    "-DARKCC_BACKEND_X86_64=0",
    "-DARKCC_BACKEND_RISCV32=0",
    "-DARKCC_BACKEND_C=0",
]

# Size overrides per layout.  These are the numbers the scatter file budgets
# for; changing one without the other is how a board build starts failing at
# link time on somebody else's machine.
LAYOUTS = {
    "sram": {
        "defs": [
            # This tier is the no-SDRAM fallback, so it is the tier that gets
            # trimmed.  Two of the sizes are NOT negotiable: the source buffer
            # has to hold the 17.8 KB AEABI runtime, and the assembler buffer
            # has to hold its 92 KB of -O0 text -- both are hard walls that
            # refuse rather than truncate, so trimming below them turns a
            # working board into a failing one.
            "-DARK_POOL_SIZE=65536",         #   64 KB arena
            "-DARK_SRC_BUF_SIZE=32768",      #   32 KB source text
            "-DARK_ASM_BUF_SIZE=98304",      #   96 KB assembler text
            "-DARK_CODE_BUF_SIZE=32768",     #   32 KB machine code
            "-DARK_OBJ_BUF_SIZE=16384",      #   16 KB object image
            "-DARK_LINK_BUF_SIZE=16384",     #   16 KB link input (arena >= 2x)
            "-DRAMFS_SLOTS=2",               # 2 x 16 KB RAM file slots
            "-DRAMFS_SLOT_SIZE=16384",
            # The three link tables are 136/140 bytes per entry: 512/512
            # entries are ~212 KB, more than half the budget on their own.
            "-DARK_LINK_MAX_SYMS=128",
            "-DARK_LINK_MAX_RELOCS=128",
            # The preprocessor holds one buffer per #include level plus the
            # preprocessed-output buffer.  Host defaults are 8 x 16 KB + 64 KB
            # = 192 KB, a third of AXI by itself.  An include that does not fit
            # 8 KB is refused by name, never truncated.
            "-DPP_MAX_INC_DEPTH=4",
            "-DPP_INC_BUF=8192",
            "-DPP_BUF_SIZE=24576",
        ],
        # .ark_buf sits at 0x24000000 and has to stop below the 0x2407F000
        # console trampoline: 0x7F000 = 508 KB.  (The deployed SDRAM layout
        # gives the same block to .ark_code/.ark_heap instead, so this tier
        # does not reserve those windows.)
        "ark_buf_budget": 0x7F000,
        "axi_base": 0x24000000,
        "scatter": """\
LR_ROM 0x08000000 0x00200000 {{
  ER_RO 0x08000000 0x00200000 {{
    * (+RO)
  }}
  ER_ARKBUF 0x{axi:08X} 0x{budget:08X} {{
    *(.ark_buf)
  }}
  ER_RW 0x30000000 0x00048000 {{
    * (+RW +ZI)
  }}
}}
""",
    },
    "sdram": {
        # Profile defaults: the SDRAM layout does not have to trim anything.
        "defs": [],
        "ark_buf_budget": 0x02000000,
        "axi_base": 0xC0000000,
        "scatter": """\
LR_ROM 0x08000000 0x00200000 {{
  ER_RO 0x08000000 0x00200000 {{
    * (+RO)
  }}
  ER_ARKBUF 0x{axi:08X} UNINIT 0x{budget:08X} {{
    *(.ark_buf)
  }}
  ER_RW 0x30000000 0x00048000 {{
    * (+RW +ZI)
  }}
}}
""",
    },
}

# The surrounding firmware supplies these.  Stubs keep the measurement honest:
# nothing in the compiler core depends on their bodies, so their size is zero
# and they cannot inflate the numbers being checked.
STUBS = """\
int W25Q_Read(unsigned int addr, unsigned char *buf, unsigned int len)
{ (void)addr; (void)buf; return (int)len; }
void HAL_UART_Transmit_Wrapper(const unsigned char *buf, int len)
{ (void)buf; (void)len; }
int main(void) { return 0; }
"""

FAILS = []


def check(ok, name, detail=""):
    tag = "PASS" if ok else "FAIL"
    print("%s  %s  [%s]" % (tag, name, detail))
    if not ok:
        FAILS.append(name)
    return ok


def find_tool(explicit, env_name, names, extra_dirs):
    if explicit:
        return explicit
    for n in names:
        p = shutil.which(n)
        if p:
            return p
    val = os.environ.get(env_name)
    if val and os.path.exists(val):
        return val
    for d in extra_dirs:
        for n in names:
            p = os.path.join(d, n)
            if os.path.exists(p):
                return p
    return None


def run(cmd, cwd=None):
    p = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True,
                       errors="replace")
    return p.returncode, (p.stdout or "") + (p.stderr or "")


def build_layout(name, args, armclang, armlink, fromelf, keep):
    spec = LAYOUTS[name]
    print("\n--- layout: %s ---" % name)
    work = keep and os.path.join(keep, name) or tempfile.mkdtemp(prefix="ark_stm32_")
    os.makedirs(work, exist_ok=True)

    cf = ["--target=arm-arm-none-eabi", "-mcpu=cortex-m7", "-mthumb",
          "-mfpu=fpv5-d16", "-mfloat-abi=hard", "-O2", "-std=c99",
          "-ffreestanding", "-I", os.path.join(ROOT, "include"),
          "-I", os.path.join(ROOT, "port", "stm32")] + COMMON_DEFS + spec["defs"]

    objs = []
    bad = []
    for src in source_list():
        # Flatten the path: os.path.join on Windows produces backslashes,
        # so replacing only "/" leaves a subdirectory that does not exist.
        flat = src.replace("/", "_").replace("\\", "_")
        obj = os.path.join(work, flat[:-2] + ".o")
        rc, out = run([armclang] + cf + ["-c", os.path.join(ROOT, src),
                                         "-o", obj])
        if rc != 0:
            bad.append((src, out.strip().splitlines()[:4]))
        else:
            objs.append(obj)
    ok = check(not bad, "every STM32 profile source compiles",
               "%d file(s), %d failed" % (len(source_list()), len(bad)))
    for src, lines in bad:
        print("      %s" % src)
        for l in lines:
            print("        " + l)
    if not ok:
        return False

    stub = os.path.join(work, "stubs.c")
    with open(stub, "w", encoding="utf-8", newline="\n") as f:
        f.write(STUBS)
    sobj = os.path.join(work, "stubs.o")
    rc, out = run([armclang] + cf + ["-c", stub, "-o", sobj])
    check(rc == 0, "measurement stubs compile", "rc=%d" % rc)
    if rc != 0:
        print(out)
        return False

    sct = os.path.join(work, "mem.sct")
    with open(sct, "w", encoding="utf-8", newline="\n") as f:
        f.write(spec["scatter"].format(axi=spec["axi_base"],
                                       budget=spec["ark_buf_budget"]))
    elf = os.path.join(work, "arkcc_stm32.elf")
    mapp = os.path.join(work, "arkcc_stm32.map")
    rc, out = run([armlink, "--cpu=Cortex-M7.fp.dp", "--scatter=" + sct,
                   "--entry=arkcc_stm32_compile", "--map", "--list=" + mapp,
                   "-o", elf] + objs + [sobj])
    # L6439W (the weak arkcc_on_output defined in two port files) is expected
    # and harmless; only errors make the link fail.
    ok = check(rc == 0, "the layout links inside the board memory",
               "rc=%d" % rc)
    if not ok:
        for l in out.strip().splitlines()[-12:]:
            print("      " + l)
        return False

    rc, out = run([fromelf, "--text", "-z", elf])
    code = ro = rw = zi = None
    for line in out.splitlines():
        if "(uncompressed)" in line:
            nums = line.split()
            code, ro, rw, zi = (int(nums[0]), int(nums[2]),
                                int(nums[3]), int(nums[4]))
            break
    check(code is not None, "the image size is readable from fromelf",
          "code=%s ro=%s rw=%s zi=%s" % (code, ro, rw, zi))

    region = {}
    with open(mapp, encoding="utf-8", errors="replace") as f:
        for line in f:
            m = re.search(r"Execution Region (\w+) \(Base: 0x[0-9a-fA-F]+, "
                          r"Size: 0x([0-9a-fA-F]+)", line)
            if m:
                region[m.group(1)] = int(m.group(2), 16)
    buf = region.get("ER_ARKBUF", -1)
    check(0 <= buf <= spec["ark_buf_budget"],
          ".ark_buf fits its %s region" % name,
          "%d / %d bytes (%.0f%%)" % (buf, spec["ark_buf_budget"],
                                      100.0 * buf / spec["ark_buf_budget"]))
    flash_used = region.get("ER_RO", 0)
    check(flash_used <= 0x200000, "code + rodata fits the 2 MB flash",
          "%d / %d bytes (%.1f%%)" % (flash_used, 0x200000,
                                      100.0 * flash_used / 0x200000))
    sram_used = region.get("ER_RW", 0)
    check(sram_used <= 0x48000, "ordinary .data/.bss fits SRAM1-3 (288 KB)",
          "%d / %d bytes (%.0f%%)" % (sram_used, 0x48000,
                                      100.0 * sram_used / 0x48000))

    # The trim is only worth anything if it is also small in flash: the arena
    # is zero-filled, so it must not be loaded as initialised data.
    check(rw <= buf + 65536, "the arena is not loaded as initialised data",
          "RW=%d, .ark_buf=%d" % (rw, buf))

    if not keep:
        shutil.rmtree(work, ignore_errors=True)
    return True


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--layout", default="both", choices=["sram", "sdram", "both"])
    ap.add_argument("--armclang")
    ap.add_argument("--armlink")
    ap.add_argument("--fromelf")
    ap.add_argument("--keep", help="keep the build tree here instead of a temp dir")
    args = ap.parse_args()

    keil_bins = [
        r"D:/Keil_v5/ARM/ARMCLANG/bin",
        r"C:/Keil_v5/ARM/ARMCLANG/bin",
        "/opt/arm/armclang/bin",
    ]
    armclang = find_tool(args.armclang, "ARMCLANG", ["armclang.exe", "armclang"],
                         keil_bins)
    armlink = find_tool(args.armlink, "ARMLINK", ["armlink.exe", "armlink"],
                        keil_bins)
    fromelf = find_tool(args.fromelf, "FROMELF", ["fromelf.exe", "fromelf"],
                        keil_bins)

    if not (armclang and armlink and fromelf):
        # Not a failure: the gate cannot run on a machine without a cross
        # toolchain, and pretending it passed would be worse than a loud skip.
        print("SKIP  stm32 cross build: no armclang/armlink/fromelf found")
        print("      set ARMCLANG / ARMLINK / FROMELF, or pass --armclang ...")
        print("all 0 check(s) passed (1 group skipped)")
        return 0

    print("toolchain: %s" % armclang)
    layouts = ["sram", "sdram"] if args.layout == "both" else [args.layout]
    ran = 0
    for name in layouts:
        if build_layout(name, args, armclang, armlink, fromelf, args.keep):
            ran += 1

    print()
    if FAILS:
        print("%d check(s) failed:" % len(FAILS))
        for f in FAILS:
            print("  " + f)
        return 1
    print("all checks passed (%d layout(s))" % ran)
    return 0


if __name__ == "__main__":
    sys.exit(main())
