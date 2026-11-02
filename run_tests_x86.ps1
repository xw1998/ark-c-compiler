$ErrorActionPreference = 'Continue'

# Run from the repository root: arkcc.exe must already be built here.
if (-not (Test-Path .\arkcc.exe)) {
    Write-Host "[run_tests_x86] arkcc.exe not found, please build first"
    exit 1
}

# Multi-file cases need -link to be built together; skip them here.
$skip = @('feat_multifile_a.c','feat_multifile_b.c','feat_multifile_main.c','test_multi_a.c','test_multi_b.c')
$examples = Get-ChildItem examples\*.c | Where-Object { $_.Name -notin $skip -and $_.Name -notlike "*.gen.c" }

$passed = 0
$failed = 0
$failedList = @()

Write-Host "===== Ark C Compiler x86_64 backend - C99 conformance test ====="
Write-Host ""

foreach ($f in $examples) {
    $base = $f.BaseName
    $outS = "$base.x86.s"
    # The x86_64 backend follows System V ABI; only -S output is checked.
    & .\arkcc.exe $f.FullName -target x86_64 -S -o $outS 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host ("  [FAIL] {0,-30} x86_64 emit failed" -f $f.Name)
        $failed++
        $failedList += $f.Name
        continue
    }
    $passed++
    Write-Host ("  [ OK ] {0,-30} x86_64 asm ({1} bytes)" -f $f.Name, (Get-Item $outS).Length)
}

Write-Host ""
Write-Host "==== summary: $passed passed, $failed failed (total $($examples.Count)) ===="
if ($failed -gt 0) {
    Write-Host "Failed files:"
    foreach ($n in $failedList) { Write-Host "  - $n" }
    exit 1
}
exit 0
