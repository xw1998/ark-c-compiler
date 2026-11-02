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

    # 5. Encoding golden bytes. These bytes were produced by MDK armasm 5.06
    #    (--thumb --cpu Cortex-M4) and read back with fromelf, so this pins the
    #    exact encoding of the mnemonics the ARM emitter relies on but which the
    #    text assembler once reported as "unknown mnemonic" (they used to be
    #    silently compiled to NOP). The check is self-contained: it does not
    #    require armasm to be installed.
    $encSrc = Join-Path $tmp 'encodings.s'
    $encLines = @(
        '    .text'
        '    TST r4, r1'
        '    CLZ r2, r0'
        '    SXTB r0, r0'
        '    SXTH r1, r2'
        '    UXTB r3, r4'
        '    UXTH r5, r6'
        '    SVC #18'
        '    MOVS r0, #42'
        '    SADD16 r0, r0, r1'
        '    TST r8, r9'
        '    CLZ r12, r11'
        '    SXTB r0, r8'
        '    UXTH r9, r3'
        '    MOVS r0, r1'
        '    MOVS r12, r3'
        '    SADD16 r9, r10, r11'
        '    MOVS r0, #200'
        '    SVC #255'
        '    BKPT 0xAB'
        '    BKPT #0x12'
        '    MUL r2, r2, r1'
        '    MUL r0, r1'
    )
    Set-Content -Path $encSrc -Value $encLines -Encoding ASCII
    $encBin = Join-Path $tmp 'encodings.bin'
    & .\arkcc.exe $encSrc -target arm -o $encBin 2>&1 | Out-Null
    $rc = $LASTEXITCODE
    Check "encoding sample assembles (exit=$rc)" ($rc -eq 0) "arkcc returned $rc"
    # Golden: 0x420c 0xfab0f280 0xb240 0xb211 0xb2e3 0xb2b5 0xdf12 0x202a
    #         0xfa90f001 0xea180f09 0xfabbfc8b 0xfa4ff088 0xfa1ff983 0x0008
    #         0xea5f0c03 0xfa9af90b 0x20c8 0xdfff  (little-endian halfwords)
    #   BKPT 0xAB -> 0xbeab, BKPT #0x12 -> 0xbe12 (semihosting trap),
    #   MUL r2, r2, r1 -> 0x434a, MUL r0, r1 -> 0x4348 (two-operand form).
    $goldenHex = '0c42b0fa80f240b211b2e3b2b5b212df2a2090fa01f018ea090fbbfa8bfc4ffa88f01ffa83f908005fea030c9afa0bf9c820ffdfabbe12be4a434843'
    $golden = New-Object 'byte[]' ($goldenHex.Length / 2)
    for ($i = 0; $i -lt $golden.Length; $i++) {
        $golden[$i] = [Convert]::ToByte($goldenHex.Substring($i * 2, 2), 16)
    }
    if (Test-Path $encBin) {
        $got = [System.IO.File]::ReadAllBytes($encBin)
        $same = ($got.Length -eq $golden.Length)
        $firstDiff = -2
        if ($same) {
            $firstDiff = -1
            for ($i = 0; $i -lt $got.Length; $i++) {
                if ($got[$i] -ne $golden[$i]) { $same = $false; $firstDiff = $i; break }
            }
        }
        Check 'encoding matches armasm golden bytes' $same ("len got=$($got.Length) want=$($golden.Length) firstdiff=$firstDiff")
    } else {
        Check 'encoding matches armasm golden bytes' $false 'no .bin produced'
    }

    # 6. An unimplemented/typo'd mnemonic must fail the assembly instead of
    #    silently becoming a NOP (regression guard for the hard-error path).
    $badSrc = Join-Path $tmp 'bad.s'
    Set-Content -Path $badSrc -Value @('    .text', '    BOGUSMNEM r0, r1') -Encoding ASCII
    & .\arkcc.exe $badSrc -target arm -o (Join-Path $tmp 'bad.bin') 2>&1 | Out-Null
    Check 'unknown mnemonic fails loudly' ($LASTEXITCODE -ne 0) "exit=$LASTEXITCODE"

    # 7. MUL with three distinct registers needs the 32-bit T2 form, which the
    #    text assembler does not emit. It must fail loudly instead of silently
    #    dropping the third operand (that used to turn 'MUL r2, r2, r1' into
    #    'MUL r2, r2, r2', i.e. every integer modulo computed q*q).
    $mulSrc = Join-Path $tmp 'mul3.s'
    Set-Content -Path $mulSrc -Value @('    .text', '    MUL r0, r1, r2') -Encoding ASCII
    & .\arkcc.exe $mulSrc -target arm -o (Join-Path $tmp 'mul3.bin') 2>&1 | Out-Null
    Check 'three-distinct-register MUL fails loudly' ($LASTEXITCODE -ne 0) "exit=$LASTEXITCODE"
}
finally {
    Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
}

Write-Host ''
Write-Host "asm-input gate: pass=$p fail=$f"
if ($f -gt 0) { exit 1 }
exit 0
