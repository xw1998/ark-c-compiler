$ErrorActionPreference = 'Continue'
$log = "test_result.txt"
Set-Content $log "ArkCC Full Regression Test"

$skip = @('feat_multifile_a.c','feat_multifile_b.c','feat_multifile_main.c','test_multi_a.c','test_multi_b.c','stm32_blink.c','stm32_shell_blink.c')
$armOnly = @('test_asm_func.c','test_asm_operand.c')
# c99_armcc5_compat_test.c exercises many features that rely on inline expansion
# (struct return, varargs, etc.) which are only available at -O2+. Run it at -O2.
$needsO2 = @('c99_armcc5_compat_test.c')
# `errno` is a *data* object, and its storage lives in stdlib/src/errno.c, not in
# this translation unit.  A single-object image has no channel for another unit's
# data address, so the ARM emit necessarily fails here and only the `-target c`
# path (host gcc links the real errno) can run it.  Counting that as a pass would
# be a wrong answer; counting it as a fail hides that the example still works.
$armEmitFail = @('c99_armcc5_compat_test.c')
$examples = Get-ChildItem examples\*.c | Where-Object { $_.Name -notin $skip -and $_.Name -notlike "*.gen.c" }

$p=0; $f=0; $c=0
Add-Content $log "Total examples: $($examples.Count)"

foreach ($x in $examples) {
    $b=$x.BaseName
    $genC = "$b.gen.c"
    $exe = "$b.gen.exe"
    & .\arkcc.exe $x.FullName -target arm -S -o nul 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        if ($armEmitFail -contains $x.Name) {
            Add-Content $log "EXPECTED-FAIL $($x.Name) [ARM-emit: errno lives in stdlib/src/errno.c]"
        } else {
            $f++; Add-Content $log "FAIL $($x.Name) [ARM-emit]"; continue
        }
    }
    if ($armOnly -contains $x.Name) { $p++; continue }
    & .\arkcc.exe $x.FullName -target c -o $genC 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { $f++; Add-Content $log "FAIL $($x.Name) [C-emit]"; continue }
    $gccFlags = @('-std=c99','-O2','-fno-strict-aliasing','-w','-o',$exe,$genC)
    if ($needsO2 -contains $x.Name) {
        & .\arkcc.exe $x.FullName -target c -O2 -o $genC 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { $f++; Add-Content $log "FAIL $($x.Name) [C-emit-O2]"; continue }
    }
    & gcc -std=c99 -O2 -fno-strict-aliasing -w -o $exe $genC 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { $f++; Add-Content $log "FAIL $($x.Name) [gcc]"; continue }
    $null = & .\$exe 2>&1
    $rc = $LASTEXITCODE
    if ($rc -lt 0) {
        # A crash is NOT a pass: the old runner incremented $p unconditionally,
        # so 0xC0000005 counted as green.
        $c++
        Add-Content $log "CRASH $($x.Name) [exit=$rc]"
        Write-Host "[$p/$($examples.Count)] $($x.Name) CRASH exit=$rc"
        continue
    }
    $p++
    Write-Host "[$p/$($examples.Count)] $($x.Name) exit=$rc"
}

# ---- negative self-check: the IR-generation gate must actually fire ----------
# "(a,b) += 3" is accepted by sema but has no lowering; before the gate existed
# irgen logged one line and pushed a 0, so the binary silently computed garbage.
$negSrc = Join-Path $env:TEMP "arkcc_irgen_gate.c"
$negOut = Join-Path $env:TEMP "arkcc_irgen_gate.bin"
Set-Content -Path $negSrc -Value 'int main(void){int a=1,b=2;(a,b)+=3;return a+b;}' -Encoding ASCII
Remove-Item -LiteralPath $negOut -ErrorAction SilentlyContinue
$negText = (& .\arkcc.exe $negSrc -target arm -o $negOut 2>&1 | Out-String)
$negRc = $LASTEXITCODE
# The negative control is "an unlowerable construct must fail loudly and write
# no image". Since the diagnostic layer now names the problem itself (#137 for
# an assignment to a comma expression) the generic "could not be lowered" line
# is only printed when irgen failed without a diagnostic, so accept either.
$negOk = ($negRc -ne 0) -and ($negText -match "could not be lowered|#137") -and (-not (Test-Path $negOut))
$selfCk = if ($negOk) { "OK" } else { "FAIL" }
if (-not $negOk) { $f++ }
Add-Content $log "SELFCHECK irgen-gate: $selfCk (exit=$negRc, image=$([bool](Test-Path $negOut)))"
Write-Host "SELFCHECK irgen-gate: $selfCk (exit=$negRc)"
Remove-Item -LiteralPath $negSrc -ErrorAction SilentlyContinue

# ---- sentinel self-check: an ordinary block-scope prototype is not __smc ---
# Two files defined the "this is not an __smc function" value differently: ast.h
# says -1, symtab.c zero-filled 0, and irgen accepts any smc_num >= 0 as a real
# __smc(n) function.  A prototype written inside a block (C99 6.2.2p5) therefore
# lowered every call to it as "SMC #0" -- the assembler rejects that, and a core
# without the security extension would trap on it.  Both directions are asserted
# here: a plain block-scope prototype must not emit SMC, and a real __smc(3)
# must still emit "SMC #3" (a sentinel that silences the feature is also wrong).
# The match is "SMC #" and not "SMC": the .file directive repeats the source
# path, and a temp name containing "smc" made the first version of this check
# fail on its own file name.
$smcPlain  = Join-Path $env:TEMP "arkcc_smc_plain.c"
$smcReal   = Join-Path $env:TEMP "arkcc_smc_real.c"
$smcPlainS = Join-Path $env:TEMP "arkcc_smc_plain.s"
$smcRealS  = Join-Path $env:TEMP "arkcc_smc_real.s"
Remove-Item -LiteralPath $smcPlainS, $smcRealS -ErrorAction SilentlyContinue
Set-Content -Path $smcPlain -Encoding ASCII -Value 'int h(int v){return v;} int main(void){int r;{extern int h(int);r=h(2);}return r;}'
Set-Content -Path $smcReal  -Encoding ASCII -Value 'extern void __smc(3) monitor(void); int main(void){monitor();return 0;}'
& .\arkcc.exe $smcPlain -target arm -S -o $smcPlainS 2>&1 | Out-Null
$smcRcPlain = $LASTEXITCODE
& .\arkcc.exe $smcReal -target arm -S -o $smcRealS 2>&1 | Out-Null
$smcRcReal = $LASTEXITCODE
$smcPlainHit = (Test-Path $smcPlainS) -and [bool](Select-String -Path $smcPlainS -Pattern 'SMC #' -Quiet)
$smcRealHit  = (Test-Path $smcRealS)  -and [bool](Select-String -Path $smcRealS  -Pattern 'SMC #3' -Quiet)
$smcOk = ($smcRcPlain -eq 0) -and ($smcRcReal -eq 0) -and (-not $smcPlainHit) -and $smcRealHit
if (-not $smcOk) { $f++ }
$smcText = if ($smcOk) { "OK" } else { "FAIL" }
Add-Content $log "SELFCHECK smc-sentinel: $smcText (plain rc=$smcRcPlain smc=$smcPlainHit / smc3 rc=$smcRcReal smc3=$smcRealHit)"
Write-Host "SELFCHECK smc-sentinel: $smcText (plain rc=$smcRcPlain smc=$smcPlainHit / smc3 rc=$smcRcReal smc3=$smcRealHit)"
Remove-Item -LiteralPath $smcPlain, $smcReal, $smcPlainS, $smcRealS -ErrorAction SilentlyContinue

Add-Content $log "==== PASS=$p FAIL=$f CRASH=$c ===="
Write-Host "==== PASS=$p FAIL=$f CRASH=$c ===="
Get-ChildItem *.gen.exe -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem *.gen.c -ErrorAction SilentlyContinue | Remove-Item -Force

# Exit code is the gate: the old script always exited 0, so CI could not tell a
# total failure from a clean run.
if (($f -gt 0) -or ($c -gt 0)) { exit 1 }
exit 0
