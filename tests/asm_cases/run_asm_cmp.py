#!/usr/bin/env python3
"""Assembler gate: arkc's encoder against the GNU assembler, instruction by
instruction, plus the --asm-extra switch in both of its states.

Why this exists
---------------
The `--asm-extra` extension adds the mnemonics the backend itself never emits
(ADDS/SUBS with flags, LDM/STM in all four of their shapes, TBB/TBH, LDRD/STRD,
MLA/..., ADR, CBZ/CBNZ, MRS/MSR).  Those encoders are hand-written bit patterns,
and "the bit pattern looks like what the ARM ARM says" is exactly the argument
that shipped the VFP nibble bug.  The only acceptable evidence is an independent
encoder agreeing on the same source.

So every case in this directory is assembled twice -- by arkc and by
arm-none-eabi-as -- and the two images are compared as *decoded instructions*
(`objdump -D -Mforce-thumb` text), not as raw bytes:

  * ARM often has several valid encodings for one instruction.  GAS prefers the
    modified-immediate form for `adds.w Rd, Rn, #300`; arkc emits the imm12
    form.  Both execute identically, so byte equality would report a difference
    where there is none.
  * Comparing disassembly still catches every *semantic* difference, because
    objdump decodes both streams with the same official decoder.

A second table (SWITCH_CASES) covers the other half of the contract: with
`--asm-extra` off, each of those mnemonics must be rejected as unknown.  A
switch whose "off" state is never exercised is not a switch -- and the default
build is the off state, so this is the path users actually get.

Usage:
    python tests/asm_cases/run_asm_cmp.py [--arkcc PATH] [--gnu-bin DIR] [-v]

Exit codes: 0 all identical, 1 a real difference, 2 cannot judge (no arkcc, or
no GNU toolchain: the gate refuses to pass on absent evidence).
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))

DEFAULT_GNU_BIN = (
    "D:/ST/STM32CubeIDE_1.16.1/STM32CubeIDE/plugins/"
    "com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32."
    "12.3.rel1.win32_1.0.200.202406191623/tools/bin"
)

# One file per group of encoders.  The .s files live next to this script.
CASES = [
    "01_dp_flags.s",
    "02_ldm_stm.s",
    "03_mul_acc.s",
    "04_sysreg.s",
    "05_pcrel.s",
    "06_table_ldrd.s",
    "07_vfp_literal.s",
    "08_ldr_str_addr.s",
    "09_vfp_ldstm.s",
    "10_armasm_alias.s",
]

# --asm-extra switch contract.  Each entry is (mnemonic, source line that must
# assemble when the switch is on).  The target label `tgt` and the trailing nop
# keep every operand form reachable.
SWITCH_CASES = [
    ("ADDS",   "adds r0, r1, #300"),
    ("SUBS",   "subs.w r0, r1, #400"),
    ("ANDS",   "ands r0, r1"),
    ("ORRS",   "orrs r0, r1"),
    ("EORS",   "eors r0, r1"),
    ("BICS",   "bics r0, r1"),
    ("MVNS",   "mvns r0, r1"),
    ("MULS",   "muls r0, r1"),
    ("LSLS",   "lsls r0, r1, #3"),
    ("LSRS",   "lsrs r0, r1, r2"),
    ("ASRS",   "asrs r0, r1, #3"),
    ("ADR",    "adr r0, tgt"),
    ("CBZ",    "cbz r0, tgt"),
    ("CBNZ",   "cbnz r0, tgt"),
    ("LDM",    "ldm r0!, {r1, r2}"),
    ("LDMIA",  "ldmia r0!, {r1}"),
    ("STM",    "stm r0!, {r1}"),
    ("STMIA",  "stmia r0!, {r1}"),
    ("LDMDB",  "ldmdb r0!, {r9, r10}"),
    ("STMDB",  "stmdb r0, {r9, r10}"),
    ("TBB",    "tbb [r0, r1]"),
    ("TBH",    "tbh [r0, r1, lsl #1]"),
    ("LDRD",   "ldrd r0, r1, [r2, #8]"),
    ("STRD",   "strd r0, r1, [r2, #-8]"),
    ("MLA",    "mla r0, r1, r2, r3"),
    ("MLS",    "mls r0, r1, r2, r3"),
    ("SMULL",  "smull r0, r1, r2, r3"),
    ("SMLAL",  "smlal r0, r1, r2, r3"),
    ("MRS",    "mrs r0, msp"),
    ("MSR",    "msr msp, r0"),
]


def gas_image(asm, objcopy, path):
    obj = path + ".gas.o"
    blob = path + ".gas.bin"
    # -mfpu matters: without it GAS refuses even "vldmia r0!, {s0-s3}" with
    # "selected FPU does not support instruction", i.e. the check would look
    # like a difference between the encoders when it is a missing -mfpu.
    proc = subprocess.run([asm, "-mthumb", "-mcpu=cortex-m7", "-mfpu=fpv5-d16",
                           "-o", obj, path], capture_output=True, text=True)
    if proc.returncode != 0:
        return None, proc.stderr.strip()
    proc = subprocess.run([objcopy, "-O", "binary", obj, blob],
                          capture_output=True, text=True)
    if proc.returncode != 0:
        return None, proc.stderr.strip()
    with open(blob, "rb") as fh:
        return fh.read(), None


def arkc_image(arkcc, path, extra):
    out = path + ".ark.bin"
    if os.path.exists(out):
        os.remove(out)
    proc = subprocess.run([arkcc, path, "-target", "arm"] + list(extra) + ["-o", out],
                          capture_output=True, text=True)
    if proc.returncode != 0:
        return None, (proc.stderr or proc.stdout).strip()
    with open(out, "rb") as fh:
        return fh.read(), None


def decoded(objdump, path):
    """Mnemonic+operand text of every instruction in a raw binary."""
    proc = subprocess.run([objdump, "-D", "-b", "binary", "-marm", "-Mforce-thumb",
                           path], capture_output=True, text=True, errors="replace")
    out = []
    for line in proc.stdout.splitlines():
        parts = line.split("\t")
        if len(parts) >= 3 and parts[2].strip():
            out.append(parts[2].strip())
    return out


def compare_case(arkcc, tools, workdir, name):
    # Assemble a copy inside the work directory: the two assemblers write their
    # objects next to the source, and a gate must not leave litter in the repo.
    src = os.path.join(HERE, name)
    path = os.path.join(workdir, name)
    shutil.copyfile(src, path)
    g, err_gas = gas_image(tools["as"], tools["objcopy"], path)
    a, err_ark = arkc_image(arkcc, path, ["--asm-extra"])
    if g is None or a is None:
        print("[FAIL] %-26s gas=%s arkc=%s"
              % (name, err_gas or "ok", (err_ark or "ok").splitlines()[0][:70]))
        return False
    dg = decoded(tools["objdump"], path + ".gas.bin")
    da = decoded(tools["objdump"], path + ".ark.bin")
    if dg == da:
        same = "bytes identical" if g == a else "%d bytes, %d differ (decoded equal)" % (
            len(g), sum(1 for x, y in zip(g, a) if x != y))
        print("[ok  ] %-26s %d insn decoded identically (%s)" % (name, len(dg), same))
        return True
    print("[FAIL] %-26s gas=%d bytes arkc=%d bytes" % (name, len(g), len(a)))
    for i in range(min(len(dg), len(da))):
        if dg[i] != da[i]:
            print("        insn #%d: gas=%r arkc=%r" % (i, dg[i], da[i]))
            break
    if len(dg) != len(da):
        print("        instruction count differs: gas=%d arkc=%d" % (len(dg), len(da)))
    return False


def check_switch(arkcc, workdir):
    """--asm-extra on: assembles.  off: rejected as an unknown mnemonic."""
    bad = 0
    for mnemonic, line in SWITCH_CASES:
        path = os.path.join(workdir, "sw_%s.s" % mnemonic)
        with open(path, "w", newline="\n") as fh:
            fh.write(".syntax unified\n.thumb\n.text\n    %s\n    nop\ntgt:\n    nop\n"
                     % line)
        on, err_on = arkc_image(arkcc, path, ["--asm-extra"])
        off, err_off = arkc_image(arkcc, path, ["--no-asm-extra"])
        if on is None:
            print("[FAIL] %-8s --asm-extra rejected it: %s"
                  % (mnemonic, (err_on or "").splitlines()[0][:70]))
            bad += 1
        elif off is not None:
            print("[FAIL] %-8s assembled with --no-asm-extra (switch does nothing)"
                  % mnemonic)
            bad += 1
        elif "unknown mnemonic" not in (err_off or ""):
            print("[FAIL] %-8s refused for the wrong reason: %s"
                  % (mnemonic, (err_off or "").splitlines()[0][:70]))
            bad += 1
    if bad == 0:
        print("[ok  ] switch               %d mnemonics: on assembles, off rejects"
              % len(SWITCH_CASES))
    return bad == 0



# Address forms that ARMv7-M does not have, and immediates that do not fit.
# Each entry is (source line, text the message must contain).  Every one of
# these used to assemble to *something* -- a different register, a truncated
# immediate, a silently dropped writeback -- so "it is rejected, and for this
# reason" is the whole contract.  A gate that only walked the happy path would
# go green again the day someone restored a mask.
REFUSE_CASES = [
    ("ldr r0, [r1, r2]!",   "does not exist in Thumb"),
    ("ldr r0, [r1], r2",    "does not exist in Thumb"),
    ("vldmia r0!, {s0, s2}", "contiguous"),
    ("vldmia r0!, {s0, d1}", "contiguous"),
    ("vpush {s0, s2}",      "contiguous"),
    ("ldrd r0, r1, [r2, r3]", "not exist for this instruction"),
    ("vldr s0, [r1, r2]",   "not exist for this instruction"),
    ("ldr r0, [r1, #4096]", "0..4095"),
    ("mov r0, #0x12345",    "0..65535"),
    ("add r0, r1, #5000",   "0..4095"),
    ("sub sp, sp, #5000",   "0..4095"),
    ("addw r0, r1, #5000",  "0..4095"),
    ("ldmib r0!, {r1}",     "unknown mnemonic"),
    ("stmda r0!, {r1}",     "unknown mnemonic"),
    ("strd r8, r9, [r10, r11, lsl #2]", "not exist for this instruction"),
]

def check_refusals(arkcc, workdir):
    """Lines that must be refused, and refused for the stated reason."""
    bad = 0
    idx = 0
    for line, needle in REFUSE_CASES:
        path = os.path.join(workdir, "rf_%d.s" % idx)
        idx += 1
        with open(path, "w", newline="\n") as fh:
            fh.write(".syntax unified\n.thumb\n.text\n    %s\n    nop\n" % line)
        img, err = arkc_image(arkcc, path, ["--asm-extra"])
        text = err or ""
        if img is not None:
            print("[FAIL] refused?  %-34s assembled anyway" % line)
            bad += 1
        elif needle not in text:
            print("[FAIL] refused?  %-34s wrong reason: %s"
                  % (line, text.splitlines()[0][:70] if text else "(no message)"))
            bad += 1
    if bad == 0:
        print("[ok  ] refusals            %d lines rejected with the stated reason"
              % len(REFUSE_CASES))
    return bad == 0

def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--arkcc", default=None)
    ap.add_argument("--gnu-bin", default=os.environ.get("ARM_GNU_BIN", DEFAULT_GNU_BIN))
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args(argv)

    arkcc = args.arkcc or os.path.join(ROOT, "arkcc.exe" if os.name == "nt" else "arkcc")
    if not os.path.exists(arkcc):
        print("[asm-cmp] arkcc not found at %s; build first" % arkcc)
        return 2
    tools = {
        "as":      os.path.join(args.gnu_bin, "arm-none-eabi-as.exe"
                                if os.name == "nt" else "arm-none-eabi-as"),
        "objcopy": os.path.join(args.gnu_bin, "arm-none-eabi-objcopy.exe"
                                if os.name == "nt" else "arm-none-eabi-objcopy"),
        "objdump": os.path.join(args.gnu_bin, "arm-none-eabi-objdump.exe"
                                if os.name == "nt" else "arm-none-eabi-objdump"),
    }
    missing = [k for k, v in tools.items() if not os.path.exists(v)]
    if missing:
        print("[asm-cmp] skipped: no GNU ARM toolchain (%s); pass --gnu-bin DIR"
              % ", ".join(missing))
        return 2

    workdir = tempfile.mkdtemp(prefix="arkcm_")
    ok = 0
    bad = 0
    for name in CASES:
        if compare_case(arkcc, tools, workdir, name):
            ok += 1
        else:
            bad += 1
    if check_switch(arkcc, workdir):
        ok += 1
    else:
        bad += 1
    if check_refusals(arkcc, workdir):
        ok += 1
    else:
        bad += 1
    print("\nidentical=%d differ=%d" % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
