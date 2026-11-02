$ErrorActionPreference = 'Continue'

# x86 backend gate.
# Run from the repository root: arkcc.exe must already be built here.
#
# What this gate proves (and what it does not):
#   1. every example emits x86 assembly text        (emit check)
#   2. that text is accepted by a real assembler    (gcc -m32 -c, if gcc exists)
#   3. -target aliases resolve to the same backend  (byte-identical output)
#   4. the operand check and the assembler check are live (negative controls)
#
# It does NOT link or execute the result: the output is i386 System V (ELF,
# no symbol underscore), which cannot be linked by the MinGW PE toolchain on
# this host. Execution-level verification is tracked as an open item in
# docs/MANUAL.md (section 12).

if (-not (Test-Path .\arkcc.exe)) {
    Write-Host "[run_tests_x86] arkcc.exe not found, please build first"
    exit 1
}

$script_pass = 0
$script_fail = 0
$script_skip = 0
$failedList = @()

function Check([string]$name, [bool]$ok, [string]$detail) {
    if ($ok) {
        $script:script_pass++
        Write-Host ("  [ OK ] {0,-34} {1}" -f $name, $detail)
    } else {
        $script:script_fail++
        $script:failedList += $name
        Write-Host ("  [FAIL] {0,-34} {1}" -f $name, $detail)
    }
}

function Skip([string]$name, [string]$detail) {
    $script:script_skip++
    Write-Host ("  [SKIP] {0,-34} {1}" -f $name, $detail)
}

# --- generated files go to a scratch directory, never into the repo ---
$tmp = Join-Path $env:TEMP 'arkcc_x86_gate'
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue }
New-Item -ItemType Directory -Force -Path $tmp | Out-Null

# Multi-file cases are linked by separate gates; they are not single-file emits.
$skipFiles = @('feat_multifile_a.c', 'feat_multifile_b.c', 'feat_multifile_main.c',
               'test_multi_a.c', 'test_multi_b.c')
# Extended inline asm needs operand substitution, which this backend refuses
# on purpose (it would otherwise emit text no assembler accepts).
$expectEmitFail = @('test_asm_operand.c')

$examples = Get-ChildItem examples\*.c |
    Where-Object { $_.Name -notin $skipFiles -and $_.Name -notlike '*.gen.c' }

$gcc = Get-Command gcc -ErrorAction SilentlyContinue
$gasGate = $null -ne $gcc -and $null -ne (Get-Command objdump -ErrorAction SilentlyContinue)

Write-Host "===== Ark C Compiler x86 (i386 cdecl) backend gate ====="
Write-Host ("  assembler cross-check: " + $(if ($gasGate) { 'gcc -m32 -c' } else { 'UNAVAILABLE (gcc/objdump not found)' }))
Write-Host ""

Write-Host "--- 1. per-example emit ---"
foreach ($f in $examples) {
    $base = $f.BaseName
    $outS = Join-Path $tmp "$base.s"
    & .\arkcc.exe $f.FullName -target x86 -S -o $outS 2>&1 | Out-Null
    $rc = $LASTEXITCODE
    if ($f.Name -in $expectEmitFail) {
        Check "emit-expected-fail/$($f.Name)" ($rc -ne 0) "exit=$rc (operand substitution refused)"
        continue
    }
    if ($rc -ne 0) {
        Check "emit/$($f.Name)" $false "emit failed exit=$rc"
        continue
    }
    if (-not (Test-Path $outS)) {
        Check "emit/$($f.Name)" $false "no output file"
        continue
    }
    $size = (Get-Item $outS).Length
    Check "emit/$($f.Name)" ($size -gt 0) "$size bytes"
}

Write-Host ""
Write-Host "--- 2. assembler cross-check (text must be real, assemblable asm) ---"
if ($gasGate) {
    foreach ($f in $examples) {
        if ($f.Name -in $expectEmitFail) { continue }
        $base = $f.BaseName
        $outS = Join-Path $tmp "$base.s"
        if (-not (Test-Path $outS)) { continue }
        $outO = Join-Path $tmp "$base.o"
        $errFile = Join-Path $tmp "$base.gas.err"
        & gcc -m32 -c $outS -o $outO 2> $errFile | Out-Null
        $rc = $LASTEXITCODE
        $detail = if ($rc -eq 0) { 'accepted' } else { ((Get-Content $errFile -ErrorAction SilentlyContinue) | Select-Object -First 1) }
        Check "gas/$($f.Name)" ($rc -eq 0) $detail
    }
} else {
    Skip 'gas/*' 'gcc not on PATH, syntax gate not exercised'
}

Write-Host ""
Write-Host "--- 3. target alias equivalence ---"
$probe = Join-Path $tmp 'alias_probe.c'
Set-Content -Path $probe -Value @(
    'int g;',
    'static int helper(int x) { return x * 3 + 1; }',
    'int main(void) { g = helper(7); return g; }'
) -Encoding ASCII
$aliasNames = @('x86', 'x86_64', 'x86-64', 'x86_64-msvc', 'i386', 'i686')
$refFile = Join-Path $tmp 'alias_x86.s'
& .\arkcc.exe $probe -target x86 -S -o $refFile 2>&1 | Out-Null
Check 'alias/x86-baseline' ($LASTEXITCODE -eq 0 -and (Test-Path $refFile)) 'canonical name emits'
$refBytes = if (Test-Path $refFile) { [System.IO.File]::ReadAllBytes($refFile) } else { @() }
foreach ($name in $aliasNames) {
    if ($name -eq 'x86') { continue }
    $outS = Join-Path $tmp "alias_$($name -replace '[^A-Za-z0-9]','_').s"
    & .\arkcc.exe $probe -target $name -S -o $outS 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $outS)) {
        Check "alias/$name" $false 'did not resolve'
        continue
    }
    $b = [System.IO.File]::ReadAllBytes($outS)
    $same = ($b.Length -eq $refBytes.Length)
    if ($same) {
        for ($i = 0; $i -lt $b.Length; $i++) {
            if ($b[$i] -ne $refBytes[$i]) { $same = $false; break }
        }
    }
    Check "alias/$name" $same 'byte-identical to -target x86'
}

Write-Host ""
Write-Host "--- 4. negative controls (anti fake-green) ---"
& .\arkcc.exe $probe -target no-such-backend -S -o (Join-Path $tmp 'bogus.s') 2>&1 | Out-Null
Check 'negative/unknown-target-rejected' ($LASTEXITCODE -ne 0) "exit=$LASTEXITCODE"

# A file the emitter must refuse: proves the inline-asm operand check runs.
$asmProbe = Join-Path $tmp 'operand_probe.c'
Set-Content -Path $asmProbe -Value @(
    'int f(int x) { int r; __asm__ volatile("mov %0, %1" : "=r"(r) : "r"(x)); return r; }',
    'int main(void) { return f(1); }'
) -Encoding ASCII
& .\arkcc.exe $asmProbe -target x86 -S -o (Join-Path $tmp 'operand_probe.s') 2>&1 | Out-Null
Check 'negative/inline-asm-operand-refused' ($LASTEXITCODE -ne 0) "exit=$LASTEXITCODE"

if ($gasGate) {
    # Corrupt one instruction that the emitter used to produce (32->32 sign
    # extend). The assembler must reject it, which proves section 2 can fail.
    $badS = Join-Path $tmp 'corrupt.s'
    Set-Content -Path $badS -Value @(
        '    .intel_syntax noprefix',
        '    .text',
        '    .globl main',
        'main:',
        '    movsx eax, dword ptr [eax]',
        '    ret'
    ) -Encoding ASCII
    & gcc -m32 -c $badS -o (Join-Path $tmp 'corrupt.o') 2>&1 | Out-Null
    Check 'negative/gas-rejects-bad-insn' ($LASTEXITCODE -ne 0) "exit=$LASTEXITCODE"
} else {
    Skip 'negative/gas-rejects-bad-insn' 'gcc not on PATH'
}

Write-Host ""
Write-Host "==== summary: pass=$script_pass fail=$script_fail skip=$script_skip ===="
if ($script_fail -gt 0) {
    Write-Host "Failed checks:"
    foreach ($n in $failedList) { Write-Host "  - $n" }
    exit 1
}
exit 0
