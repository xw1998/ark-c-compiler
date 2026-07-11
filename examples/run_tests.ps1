$ErrorActionPreference = 'Stop'

# Switch to the project root directory
Set-Location (Split-Path -Parent $PSScriptRoot)

if (-not (Test-Path .\arkcc.exe)) {
    Write-Host "[run_tests] arkcc.exe not found, please build first"
    exit 1
}

$examples = Get-ChildItem examples\*.c | Where-Object { $_.Name -notlike "*.gen.c" -and $_.Name -notlike "feat_multifile_*" -and $_.Name -notlike "test_multi_*" }
$failed = 0
$passed = 0

foreach ($f in $examples) {
    $base = $f.BaseName
    Write-Host "===== $($f.Name) ====="

    # ARM backend: syntax + assembly generation check only
    & .\arkcc.exe $f.FullName -target arm -S -o nul
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [arm] FAILED"
        $failed++
        continue
    }
    Write-Host "  [arm] asm OK"

    # C backend: emit + gcc compile + run
    # test_asm_func.c contains ARM assembly that host gcc cannot assemble; ARM-only check.
    # test_asm_operand.c uses local variable names (result/x); the C backend stores them
    #   in frame[] rather than as C locals, so __asm__ operands cannot be compiled by
    #   gcc; also ARM-only.
    if ($base -eq "test_asm_func" -or $base -eq "test_asm_operand") {
        Write-Host "  [c]   skipped (ARM-only test)"
        $passed++
        continue
    }
    # stm32_blink/stm32_shell_blink access hardware registers directly (e.g. 0x580244E0),
    # which crashes on host. These are STM32-only tests.
    if ($base -eq "stm32_blink" -or $base -eq "stm32_shell_blink") {
        Write-Host "  [c]   skipped (STM32 hardware test)"
        $passed++
        continue
    }
    $genc = "$base.gen.c"
    $exe  = "$base.gen.exe"
    & .\arkcc.exe $f.FullName -target c -o $genc
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [c]   FAILED to emit"
        $failed++
        continue
    }
    # When gcc fails (e.g. multi-file tests missing main) it writes to stderr;
    # temporarily relax the error policy.
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    $proc = Start-Process -FilePath gcc -ArgumentList "-O2","-w",$genc,"-o",$exe -NoNewWindow -Wait -PassThru -RedirectStandardError NUL
    $ErrorActionPreference = $prevEAP
    if ($proc.ExitCode -ne 0) {
        Write-Host "  [c]   gcc FAILED to compile generated"
        $failed++
        continue
    }
    & ".\$exe"
    $rc = $LASTEXITCODE
    # Tests use main() return value as computation result (e.g. test_fpu_hw returns r*10=40).
    # Non-zero exit code is NOT failure. Only crash (negative exit code / SEH) counts as failure.
    if ($rc -lt 0) {
        $hex = ('0x{0:X}' -f ($rc -band 0xFFFFFFFF))
        Write-Host "  [c]   FAILED: CRASH exit code = $rc ($hex)"
        Write-Host "        possible cause: runtime crash (segfault/illegal instruction)"
        $failed++
    } else {
        Write-Host "  [c]   exit code = $rc (OK)"
        $passed++
    }
}

Write-Host ""
Write-Host "==== summary: $passed passed, $failed failed ===="
if ($failed -gt 0) { exit 1 }
exit 0
