# bootstrap_x86.ps1 - x86 32-bit bootstrap verification script
#
# Verifies the arkcc x86 backend by compiling hello.c to 32-bit x86 assembly,
# then assembling+linking with gcc -m32, and running the result.
#
# Workflow: arkcc -target x86 -S hello.c -> hello_x86.s -> gcc -m32 -> hello_x86.exe
#
# Usage:  .\bootstrap_x86.ps1
# Requires: arkcc.exe (built via `make` or `gcc ... -o arkcc.exe`)
#           gcc with -m32 support (mingw32 / multilib on Linux)
# Note: ErrorActionPreference is 'Continue' (not Stop) so that native commands
#       (arkcc/gcc) writing to stderr do not abort the script prematurely.
$ErrorActionPreference = "Continue"

$ROOT = $PSScriptRoot
Set-Location $ROOT

Write-Host "=== x86 Bootstrap Test ===" -ForegroundColor Cyan

# --- 0. Pre-flight checks ---
if (-not (Test-Path ".\arkcc.exe")) {
    Write-Host "FAIL: arkcc.exe not found. Run 'make' first to build the compiler." -ForegroundColor Red
    exit 1
}

# Verify gcc is available
$gccExe = (Get-Command gcc -ErrorAction SilentlyContinue)
if (-not $gccExe) {
    Write-Host "FAIL: gcc not found on PATH. Install mingw-w64 (with 32-bit support) or a multilib toolchain." -ForegroundColor Red
    exit 1
}

# Verify gcc supports -m32 by compiling a tiny test program
$m32Probe = Join-Path $env:TEMP "arkcc_m32_probe.c"
$m32Obj   = Join-Path $env:TEMP "arkcc_m32_probe.o"
"int main(void){return 0;}" | Out-File -FilePath $m32Probe -Encoding ascii -NoNewline
& gcc -m32 -c $m32Probe -o $m32Obj 2>$null
if ($LASTEXITCODE -ne 0 -or -not (Test-Path $m32Obj)) {
    Write-Host "FAIL: gcc does not support -m32 on this system." -ForegroundColor Red
    Write-Host "  On Windows: install mingw-w64-i686-gcc (32-bit toolchain)." -ForegroundColor Yellow
    Write-Host "  On Linux:   install gcc-multilib (e.g. 'sudo apt install gcc-multilib')." -ForegroundColor Yellow
    Remove-Item $m32Probe -ErrorAction SilentlyContinue
    exit 1
}
Remove-Item $m32Probe, $m32Obj -ErrorAction SilentlyContinue

# On Windows (PE/COFF), C global symbols need a leading underscore: the CRT
# startup looks for _main, but the x86 backend emits main (ELF convention).
# The --defsym linker flag creates the alias _main -> main.
$linkFlags = @('-m32')
if ($env:OS -eq 'Windows_NT') {
    $linkFlags += '-Wl,--defsym,_main=main'
}

# --- 1. Generate x86 assembly with arkcc ---
Write-Host "[1/3] Generating x86 assembly from examples\hello.c ..."
& .\arkcc.exe examples\hello.c -target x86 -S -o hello_x86.s
if ($LASTEXITCODE -ne 0 -or -not (Test-Path "hello_x86.s")) {
    Write-Host "FAIL: arkcc compilation failed (exit=$LASTEXITCODE)" -ForegroundColor Red
    exit 1
}
Write-Host "  OK: hello_x86.s generated"

# --- 2. Assemble and link with gcc -m32 ---
Write-Host "[2/3] Assembling + linking with gcc -m32 ..."
& gcc @linkFlags hello_x86.s -o hello_x86.exe 2>$null
if ($LASTEXITCODE -ne 0 -or -not (Test-Path "hello_x86.exe")) {
    Write-Host "FAIL: gcc -m32 assembly/link failed (exit=$LASTEXITCODE)" -ForegroundColor Red
    Write-Host "  Assembly output was left in hello_x86.s for inspection." -ForegroundColor Yellow
    exit 1
}
Write-Host "  OK: hello_x86.exe built"

# --- 3. Run and verify exit code ---
Write-Host "[3/3] Running hello_x86.exe ..."
& .\hello_x86.exe
$rc = $LASTEXITCODE
Write-Host "  Exit code: $rc"

# --- Cleanup ---
Remove-Item hello_x86.s, hello_x86.exe -ErrorAction SilentlyContinue

# --- Result ---
if ($rc -eq 42) {
    Write-Host "PASS: x86 bootstrap successful (exit code 42)" -ForegroundColor Green
    exit 0
} else {
    Write-Host "FAIL: expected exit code 42, got $rc" -ForegroundColor Red
    exit 1
}
