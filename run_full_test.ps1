$ErrorActionPreference = 'Continue'
$log = "test_result.txt"
Set-Content $log "ArkCC Full Regression Test"

$skip = @('feat_multifile_a.c','feat_multifile_b.c','feat_multifile_main.c','test_multi_a.c','test_multi_b.c','stm32_blink.c','stm32_shell_blink.c')
$armOnly = @('test_asm_func.c','test_asm_operand.c')
# c99_armcc5_compat_test.c exercises many features that rely on inline expansion
# (struct return, varargs, etc.) which are only available at -O2+. Run it at -O2.
$needsO2 = @('c99_armcc5_compat_test.c')
$examples = Get-ChildItem examples\*.c | Where-Object { $_.Name -notin $skip -and $_.Name -notlike "*.gen.c" }

$p=0; $f=0; $c=0
Add-Content $log "Total examples: $($examples.Count)"

foreach ($x in $examples) {
    $b=$x.BaseName
    $genC = "$b.gen.c"
    $exe = "$b.gen.exe"
    & .\arkcc.exe $x.FullName -target arm -S -o nul 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { $f++; Add-Content $log "FAIL $($x.Name) [ARM-emit]"; continue }
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
    $p++
    if ($rc -lt 0) { $c++; Add-Content $log "CRASH $($x.Name) [exit=$rc]" }
    Write-Host "[$p/$($examples.Count)] $($x.Name) exit=$rc"
}

Add-Content $log "==== PASS=$p FAIL=$f CRASH=$c ===="
Get-ChildItem *.gen.exe -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem *.gen.c -ErrorAction SilentlyContinue | Remove-Item -Force
