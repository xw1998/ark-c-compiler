# run_arm_exec_test.ps1 - ARM execution gate: compile -> link -> RUN on QEMU.
#
# Every other gate in this repo stops at the byte level (assembly text, object
# layout, golden encodings).  This one closes the loop: the emitted Thumb-2
# code is executed by qemu-system-arm on the MPS2-AN385 board and the workload
# result comes back as the emulator exit code.
#
# Covered here:
#   1. Three objects (C startup, assembly semihosting trampoline, C workload)
#      compile with -c and link into one image with --scatter.
#   2. The image starts with a Cortex-M vector table: SP == 0x20040000 (end of
#      the scatter RW region) and the reset vector sits past the table with
#      bit 0 set (Cortex-M loads EPSR.T from that bit; an even address would
#      raise INVSTATE and lock the core).
#   3. Workload A really returns 8, workload B really returns 3 - two different
#      values, so a constant or ignored exit code cannot pass.
#   4. Negative control: the same image compared against a wrong expected value
#      MUST be reported as a failure (proves the comparison is not vacuous).
#
# The gate exits 0 only when every check passed.  Exit code 2 means QEMU is
# missing: the gate then reports that it cannot verify anything, instead of
# quietly passing.
#
# ASCII only on purpose: Windows PowerShell 5.1 reads .ps1 as ANSI unless the
# file carries a BOM, so non-ASCII text here would be mangled.

param(
    [string]$Qemu = $env:ARKCC_QEMU
)

$ErrorActionPreference = 'Continue'

$p = 0
$f = 0

function Check($name, $cond, $detail) {
    if ($cond) {
        $script:p++
        Write-Host "PASS $name"
    } else {
        $script:f++
        Write-Host "FAIL $name  $detail" -ForegroundColor Red
    }
}

function Get-Bytes($path) {
    if (-not (Test-Path $path)) { return $null }
    return [System.IO.File]::ReadAllBytes($path)
}

function Test-ObjMagic($path) {
    $b = Get-Bytes $path
    if ($null -eq $b -or $b.Length -lt 12) { return $false }
    $m = [System.Text.Encoding]::ASCII.GetString($b, 0, 8)
    return ($m -eq "ARKOBJ2`n")
}

function Get-U32($path, $off) {
    $b = Get-Bytes $path
    if ($null -eq $b -or $b.Length -lt ($off + 4)) { return -1 }
    return [System.BitConverter]::ToUInt32($b, $off)
}

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$arkcc = Join-Path $root 'arkcc.exe'
$fixture = Join-Path $root 'tests\arm_exec'
$work = Join-Path $env:TEMP 'arkcc_arm_exec'

if (-not $Qemu) { $Qemu = 'D:\qemu\mingw64\bin\qemu-system-arm.exe' }

Check 'arkcc.exe present' (Test-Path $arkcc) $arkcc
Check 'fixture sources present' (Test-Path (Join-Path $fixture 'startup.c')) $fixture
Check 'scatter file present' (Test-Path (Join-Path $fixture 'qemu_mps2.sct')) $fixture

if (-not (Test-Path $Qemu)) {
    Write-Host "SKIP cannot verify: qemu-system-arm not found at $Qemu" -ForegroundColor Yellow
    Write-Host "     install QEMU for Windows and re-run with -Qemu <path>, or set ARKCC_QEMU." -ForegroundColor Yellow
    Write-Host "arm exec gate: pass=$p fail=$f (NOT VERIFIED)"
    exit 2
}

if (Test-Path $work) { Remove-Item -Recurse -Force $work }
New-Item -ItemType Directory -Path $work -Force | Out-Null

$sct = Join-Path $fixture 'qemu_mps2.sct'

function Build-Image($workload, $tag) {
    $objs = @()
    foreach ($unit in @(@('startup.c', 'startup'), @('sh_call.s', 'sh_call'), @($workload, $tag))) {
        $src = Join-Path $fixture $unit[0]
        $obj = Join-Path $work ($unit[1] + '.ark_obj')
        & $arkcc -target arm -c $src -o $obj 2>&1 | Out-Null
        $objs += $obj
    }
    $image = Join-Path $work ($tag + '.bin')
    & $arkcc -link $objs[0] $objs[1] $objs[2] --scatter $sct -o $image 2>&1 | Out-Null
    return @{ Objs = $objs; Image = $image }
}

function Run-Image($image) {
    # -kernel loads the raw image at 0x00000000 (MPS2 code SRAM); the reset
    # vector then runs the startup object, which exits through semihosting.
    & $Qemu -machine mps2-an385 -nographic -semihosting-config enable=on,target=native -kernel $image 2>&1 | Out-Null
    return $LASTEXITCODE
}

# --- workload A -----------------------------------------------------------
$a = Build-Image 'compute_a.c' 'compute_a'
Check 'A: startup object is ARKOBJ2' (Test-ObjMagic $a.Objs[0]) $a.Objs[0]
Check 'A: trampoline object is ARKOBJ2' (Test-ObjMagic $a.Objs[1]) $a.Objs[1]
Check 'A: workload object is ARKOBJ2' (Test-ObjMagic $a.Objs[2]) $a.Objs[2]
Check 'A: linked image exists' (Test-Path $a.Image) $a.Image

$sp = Get-U32 $a.Image 0
$rv = Get-U32 $a.Image 4
Check 'A: vector[0] is the scatter RW end (0x20040000)' ($sp -eq 0x20040000) ("got 0x{0:X8}" -f $sp)
# Cortex-M loads EPSR.T from vector bit 0, so a runnable entry is always odd;
# the address itself must sit past the two reserved vector words.
Check 'A: reset vector is past the table and carries the Thumb bit' (((($rv -band 1) -eq 1) -and (($rv -band 0xFFFFFFFE) -ge 0x400))) ("got 0x{0:X8}" -f $rv)

$rcA = Run-Image $a.Image
Write-Host ("     workload A exit code = {0} (expected 8)" -f $rcA)
Check 'A: workload result is 8' ($rcA -eq 8) ("got $rcA")

# --- workload B (different value => the exit code is not a constant) ------
$b = Build-Image 'compute_b.c' 'compute_b'
$rcB = Run-Image $b.Image
Write-Host ("     workload B exit code = {0} (expected 3)" -f $rcB)
Check 'B: workload result is 3' ($rcB -eq 3) ("got $rcB")
Check 'B: two workloads give different codes' ($rcA -ne $rcB) ("$rcA vs $rcB")

# --- negative control -----------------------------------------------------
# Deliberately compare workload A against a wrong expectation.  If this came
# back "passing", the gate above would be measuring nothing.
$wrongOk = ($rcA -eq 9)
Check 'negative control: wrong expectation is rejected' (-not $wrongOk) ("exit $rcA matched 9")

Write-Host ""
Write-Host "qemu: $Qemu"
Write-Host "arm exec gate: pass=$p fail=$f"
if ($f -gt 0) { exit 1 }
exit 0
