# run_asm_test.ps1 - assembly-input gate.
#
# Checks that every accepted assembly suffix (.s / .S / .asm / .ASM) is routed to
# the backend assembler and yields byte-identical machine code, that -S on an
# assembly input is a pass-through, that a missing file fails loudly, and that a
# C source is still compiled through the normal frontend (i.e. the extension
# probe did not swallow ordinary inputs).
#
# ASCII only on purpose: Windows PowerShell 5.1 reads .ps1 as ANSI unless the
# file carries a BOM, so non-ASCII text here would be mangled.

$ErrorActionPreference = 'Continue'

$p = 0
$f = 0

function Check($name, $cond, $detail) {
    # $script: scope is required: a plain $p inside a function would be a new
    # local copy, leaving the summary counters (and the exit code) stuck at 0,
    # which would turn this gate into a false green.
    if ($cond) {
        $script:p++
        Write-Host "PASS $name"
    } else {
        $script:f++
        Write-Host "FAIL $name  $detail" -ForegroundColor Red
    }
}

if (-not (Test-Path '.\arkcc.exe')) {
    Write-Host 'FAIL arkcc.exe not found; run make first' -ForegroundColor Red
    exit 1
}

$src = 'examples\test_hello.s'
if (-not (Test-Path $src)) {
    Write-Host "FAIL reference assembly $src missing" -ForegroundColor Red
    exit 1
}

$tmp = Join-Path $env:TEMP ("arkcc_asm_gate_" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tmp | Out-Null

try {
    # 1. Same source under all four accepted suffixes -> identical binaries.
    $suffixes = @('s', 'S', 'asm', 'ASM')
    $hashes = @{}
    foreach ($suf in $suffixes) {
        $inp = Join-Path $tmp "hello.$suf"
        Copy-Item $src $inp -Force
        $bin = Join-Path $tmp "hello_$suf.bin"
        & .\arkcc.exe $inp -target arm -o $bin 2>&1 | Out-Null
        $rc = $LASTEXITCODE
        Check ".$suf assembles (exit=$rc)" ($rc -eq 0) "arkcc returned $rc"
        if (Test-Path $bin) {
            $hashes[$suf] = (Get-FileHash $bin -Algorithm SHA256).Hash
        } else {
            $hashes[$suf] = 'MISSING'
        }
    }
    $ref = $hashes['s']
    Check '.S output byte-identical to .s' ($hashes['S'] -eq $ref) "$($hashes['S']) vs $ref"
    Check '.asm output byte-identical to .s' ($hashes['asm'] -eq $ref) "$($hashes['asm']) vs $ref"
    Check '.ASM output byte-identical to .s' ($hashes['ASM'] -eq $ref) "$($hashes['ASM']) vs $ref"
    Check 'assembled image is non-empty' ($ref -ne 'MISSING') 'no .bin produced'

    # 2. -S on an assembly input must pass the text through unchanged.
    $pass = Join-Path $tmp 'passthrough.s'
    $asmIn = Join-Path $tmp 'hello_pt.asm'
    Copy-Item $src $asmIn -Force
    & .\arkcc.exe $asmIn -target arm -S -o $pass 2>&1 | Out-Null
    $rc = $LASTEXITCODE
    Check "-S passthrough on .asm (exit=$rc)" ($rc -eq 0) "arkcc returned $rc"
    if (Test-Path $pass) {
        $a = (Get-Content $src -Raw)
        $b = (Get-Content $pass -Raw)
        Check '-S passthrough text unchanged' ($a -eq $b) 'output differs from source'
    } else {
        Check '-S passthrough text unchanged' $false 'no output written'
    }

    # 3. Missing input must fail, not silently succeed.
    $missing = Join-Path $tmp 'does_not_exist.asm'
    & .\arkcc.exe $missing -target arm -o (Join-Path $tmp 'none.bin') 2>&1 | Out-Null
    Check 'missing .asm fails loudly' ($LASTEXITCODE -ne 0) "exit=$LASTEXITCODE"

    # 4. Regression guard: a .c input is still frontend-compiled, not treated
    #    as assembly (the extension probe must not swallow C sources).
    $cAsm = Join-Path $tmp 'hello_from_c.s'
    & .\arkcc.exe examples\hello.c -target arm -S -o $cAsm 2>&1 | Out-Null
    $rc = $LASTEXITCODE
    Check "C source still compiles (exit=$rc)" ($rc -eq 0) "arkcc returned $rc"
    if (Test-Path $cAsm) {
        $len = (Get-Item $cAsm).Length
        Check 'C source produced real assembly' ($len -gt 0) "output empty"
    } else {
        Check 'C source produced real assembly' $false 'no output written'
    }
}
finally {
    Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
}

Write-Host ''
Write-Host "asm-input gate: pass=$p fail=$f"
if ($f -gt 0) { exit 1 }
exit 0
