# bootstrap_x86_build.ps1 - x86 32-bit full self-bootstrap script
#
# Full self-hosting verification: builds arkcc with host gcc, then uses arkcc's
# x86 backend to compile arkcc's own sources to 32-bit assembly, assembles+links
# with gcc -m32 into arkcc_bootstrap.exe, and verifies it can compile hello.c.
#
# Phases:
#   1. Build arkcc.exe with host gcc (if not present)
#   2. Compile each arkcc .c source with arkcc -target x86 -S -> .x86.s
#   3. Assemble + link all .x86.s with gcc -m32 -> arkcc_bootstrap.exe
#   4. Test: arkcc_bootstrap.exe compiles hello.c -> exit code 42
#
# Usage:  .\bootstrap_x86_build.ps1
# Requires: gcc with -m32 support (mingw32 / gcc-multilib)
# Note: ErrorActionPreference is 'Continue' (not Stop) so that native commands
#       (arkcc/gcc) writing to stderr do not abort the script prematurely.
$ErrorActionPreference = "Continue"

$ROOT = $PSScriptRoot
Set-Location $ROOT
$OUTDIR = Join-Path $ROOT "bootstrap_x86"

Write-Host "=== x86 Full Bootstrap Build ===" -ForegroundColor Cyan

# --- 0. Pre-flight: verify gcc -m32 support ---
$gccExe = (Get-Command gcc -ErrorAction SilentlyContinue)
if (-not $gccExe) {
    Write-Host "FAIL: gcc not found on PATH." -ForegroundColor Red
    exit 1
}
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
Write-Host "[0/4] gcc -m32 support verified" -ForegroundColor Green

# --- 1. Build arkcc.exe with host gcc (if not present) ---
if (-not (Test-Path ".\arkcc.exe")) {
    Write-Host "[1/4] Building arkcc.exe with host gcc..."
    $srcCore = Get-ChildItem -Path "src\*.c" | ForEach-Object { $_.FullName }
    $srcBE   = Get-ChildItem -Path "src\backend\*\*.c" | ForEach-Object { $_.FullName }
    $srcBE  += "src\backend\registry.c"
    $srcHost = @("port\host\flash_fs_host.c", "port\host\platform_host.c", "port\host\debug_host.c")
    $allSrc  = @()
    $allSrc += $srcCore
    $allSrc += $srcBE
    $allSrc += $srcHost | ForEach-Object { Join-Path $ROOT $_ }
    & gcc -Wall -Wextra -O2 -std=c99 -Iinclude $allSrc -o arkcc.exe 2>&1 | ForEach-Object { Write-Host "  $_" }
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path ".\arkcc.exe")) {
        Write-Host "FAIL: host build of arkcc.exe failed (exit=$LASTEXITCODE)" -ForegroundColor Red
        exit 1
    }
    Write-Host "  OK: arkcc.exe built" -ForegroundColor Green
} else {
    Write-Host "[1/4] arkcc.exe already exists, skipping host build" -ForegroundColor Green
}

# --- 2. Compile each arkcc .c source with arkcc -target x86 -S ---
if (-not (Test-Path $OUTDIR)) { New-Item -ItemType Directory -Path $OUTDIR | Out-Null }

$srcFiles = @(
    'ast','codegen_common','compiler','config','cpu','ir','irgen','lexer',
    'main','memory','opt','parser','preproc','scatter','sema','symtab','type'
)
$backendFiles = @(
    'src\backend\c\backend_c',
    'src\backend\arm\backend_arm',
    'src\backend\x86_64\backend_x86_64',
    'src\backend\riscv32\backend_riscv32',
    'src\backend\registry'
)
$portFiles = @(
    'port\host\flash_fs_host',
    'port\host\platform_host'
)
$allFiles = @()
foreach ($s in $srcFiles) { $allFiles += "src\$s.c" }
$allFiles += $backendFiles | ForEach-Object { "$_.c" }
$allFiles += $portFiles | ForEach-Object { "$_.c" }

Write-Host "[2/4] Compiling $($allFiles.Count) sources with arkcc -target x86 -S ..."
$fail = 0
$asmFiles = @()
foreach ($f in $allFiles) {
    $base = [System.IO.Path]::GetFileNameWithoutExtension($f)
    $out  = Join-Path $OUTDIR "$base.x86.s"
    & .\arkcc.exe -target x86 -I include $f -S -o $out 2>$null
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $out)) {
        Write-Host "  FAIL: $f (exit=$LASTEXITCODE)" -ForegroundColor Red
        $fail++
    } else {
        $asmFiles += $out
        Write-Host "  OK:   $f -> $base.x86.s"
    }
}
Write-Host "Phase 2: $fail failures, $($asmFiles.Count) assemblies"
if ($fail -gt 0) {
    Write-Host "WARN: $fail source(s) failed to compile with x86 backend." -ForegroundColor Yellow
    Write-Host "      Continuing with the $($asmFiles.Count) that succeeded." -ForegroundColor Yellow
}
if ($asmFiles.Count -eq 0) {
    Write-Host "FAIL: no assemblies produced, cannot link." -ForegroundColor Red
    exit 2
}

# On Windows (PE/COFF), C global symbols need a leading underscore: the CRT
# startup looks for _main, but the x86 backend emits main (ELF convention).
# The --defsym linker flag creates the alias _main -> main.
$extraLinkFlags = @()
if ($env:OS -eq 'Windows_NT') {
    $extraLinkFlags += '-Wl,--defsym,_main=main'
}

# --- 3. Assemble + link all .x86.s with gcc -m32 ---
Write-Host "[3/4] Linking $($asmFiles.Count) assemblies with gcc -m32 ..."
$bootstrapExe = Join-Path $OUTDIR "arkcc_bootstrap.exe"
$linkArgs = @('-m32') + $extraLinkFlags + $asmFiles + @('-o', $bootstrapExe)
& gcc @linkArgs 2>$null
if ($LASTEXITCODE -ne 0 -or -not (Test-Path $bootstrapExe)) {
    Write-Host "FAIL: gcc -m32 link failed (exit=$LASTEXITCODE)" -ForegroundColor Red
    Write-Host "  Assemblies left in $OUTDIR for inspection." -ForegroundColor Yellow
    exit 3
}
Write-Host "  OK: $bootstrapExe built" -ForegroundColor Green

# --- 4. Test: bootstrap arkcc compiles hello.c ---
Write-Host "[4/4] Testing bootstrap arkcc on examples\hello.c ..."
$helloS = Join-Path $OUTDIR "hello_bootstrap.x86.s"
$helloExe = Join-Path $OUTDIR "hello_bootstrap.exe"
& $bootstrapExe examples\hello.c -target x86 -S -o $helloS 2>$null
if ($LASTEXITCODE -ne 0 -or -not (Test-Path $helloS)) {
    Write-Host "FAIL: bootstrap arkcc could not compile hello.c (exit=$LASTEXITCODE)" -ForegroundColor Red
    exit 4
}
& gcc -m32 @extraLinkFlags $helloS -o $helloExe 2>$null
if ($LASTEXITCODE -ne 0 -or -not (Test-Path $helloExe)) {
    Write-Host "FAIL: gcc -m32 could not assemble bootstrap hello.s (exit=$LASTEXITCODE)" -ForegroundColor Red
    exit 4
}
& $helloExe
$rc = $LASTEXITCODE
Write-Host "  hello.c exit code: $rc"

# --- Result ---
if ($rc -eq 42) {
    Write-Host ""
    Write-Host "PASS: x86 full bootstrap successful (exit code 42)" -ForegroundColor Green
    exit 0
} else {
    Write-Host ""
    Write-Host "FAIL: expected exit code 42, got $rc" -ForegroundColor Red
    exit 1
}
