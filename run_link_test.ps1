# run_link_test.ps1 - multi-object (-link) gate for the ARKOBJ2 binary linker.
#
# Covered here:
#   1. -c on an ARM C source writes an ARKOBJ2 object (magic + code + syms).
#   2. Objects that declare RAM (.data/.bss) carry the reserved
#      __arkcc_ram_start / __arkcc_ram_end descriptors; objects without RAM
#      do not.
#   3. A real link produces ONE image: the output is not the raw concatenation
#      of the input objects, and its length equals the sum of the code sizes.
#      (Before the magic-detection fix every -link silently wrote the objects
#      back to back and reported success, so this is the anti-false-green
#      check for the whole script.)
#   4. Negative: two objects that both place .data/.bss at the same SRAM base
#      must fail loudly (data sections are not relocated by -link).
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

function Get-Bytes($path) {
    return [System.IO.File]::ReadAllBytes($path)
}

function Test-ObjMagic($path) {
    if (-not (Test-Path $path)) { return $false }
    $b = Get-Bytes $path
    if ($b.Length -lt 12) { return $false }
    $m = [System.Text.Encoding]::ASCII.GetString($b, 0, 8)
    return ($m -eq "ARKOBJ2`n")
}

function Get-CodeLen($path) {
    $b = Get-Bytes $path
    return [System.BitConverter]::ToInt32($b, 8)
}

function Test-ContainsAscii($path, $needle) {
    if (-not (Test-Path $path)) { return $false }
    $b = Get-Bytes $path
    $s = [System.Text.Encoding]::ASCII.GetString($b)
    return $s.Contains($needle)
}

if (-not (Test-Path '.\arkcc.exe')) {
    Write-Host 'FAIL arkcc.exe not found; run make first' -ForegroundColor Red
    exit 1
}

$tmp = Join-Path $env:TEMP ("arkcc_link_gate_" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tmp | Out-Null

try {
    # --- inputs: two units with RAM, two without -------------------------
    Set-Content -Path (Join-Path $tmp 'ramA.c') -Encoding ASCII -Value @(
        'int ga = 1;',
        'int add_a(int x) { return x + ga; }')
    Set-Content -Path (Join-Path $tmp 'ramB.c') -Encoding ASCII -Value @(
        'int gb = 2;',
        'int add_b(int x) { return x + gb; }')
    Set-Content -Path (Join-Path $tmp 'nora1.c') -Encoding ASCII -Value @(
        'int twice(int x) { return x * 2; }')
    Set-Content -Path (Join-Path $tmp 'nora2.c') -Encoding ASCII -Value @(
        'int thrice(int x) { return x * 3; }')

    $objA = Join-Path $tmp 'ramA.ark_obj'
    $objB = Join-Path $tmp 'ramB.ark_obj'
    $objC = Join-Path $tmp 'nora1.ark_obj'
    $objD = Join-Path $tmp 'nora2.ark_obj'

    foreach ($pair in @(@('ramA.c', $objA), @('ramB.c', $objB),
                        @('nora1.c', $objC), @('nora2.c', $objD))) {
        $src = Join-Path $tmp $pair[0]
        & .\arkcc.exe $src -target arm -c -o $pair[1] 2>&1 | Out-Null
        Check "-c $($pair[0]) (exit=$LASTEXITCODE)" ($LASTEXITCODE -eq 0) "arkcc returned $LASTEXITCODE"
    }

    # 1. object format
    Check 'object has ARKOBJ2 magic' (Test-ObjMagic $objA) 'magic missing'
    $codeA = Get-CodeLen $objA
    Check 'object code size is plausible' (($codeA -gt 32) -and ($codeA -lt 100000)) "code size $codeA"

    # 2. RAM descriptors are present exactly where RAM exists
    Check 'RAM object carries __arkcc_ram_start' (Test-ContainsAscii $objA '__arkcc_ram_start') 'descriptor missing'
    Check 'RAM object carries __arkcc_ram_end' (Test-ContainsAscii $objA '__arkcc_ram_end') 'descriptor missing'
    Check 'RAM-free object has no RAM descriptor' (-not (Test-ContainsAscii $objC '__arkcc_ram_start')) 'descriptor leaked'

    # 3. real link: one image, not a concatenation of objects
    $linkTwo = Join-Path $tmp 'nora_link.bin'
    & .\arkcc.exe -link $objC $objD -o $linkTwo 2>&1 | Out-Null
    Check "link two RAM-free objects (exit=$LASTEXITCODE)" ($LASTEXITCODE -eq 0) "arkcc returned $LASTEXITCODE"
    if ((Test-Path $linkTwo) -and (Test-ObjMagic $objC) -and (Test-ObjMagic $objD)) {
        $lb = Get-Bytes $linkTwo
        $magicInImage = [System.Text.Encoding]::ASCII.GetString($lb, 0, [Math]::Min(8, $lb.Length))
        Check 'linked image is not raw object concat' ($magicInImage -ne "ARKOBJ2`n") 'output still starts with the object magic'
        $want = (Get-CodeLen $objC) + (Get-CodeLen $objD)
        Check 'linked image length equals sum of code sizes' ($lb.Length -eq $want) "got $($lb.Length) want $want"
    } else {
        Check 'linked image is not raw object concat' $false 'no output'
        Check 'linked image length equals sum of code sizes' $false 'no output'
    }

    # 4. negative: two RAM objects would alias .data/.bss at the same base
    $linkBad = Join-Path $tmp 'ram_link.bin'
    $outBad = & .\arkcc.exe -link $objA $objB -o $linkBad 2>&1 | Out-String
    Check 'two RAM objects fail to link' ($LASTEXITCODE -ne 0) "exit=$LASTEXITCODE"
    Check 'overlap error names the SRAM range' ($outBad -match 'SRAM overlap') "output: $outBad"
    Check 'no image written on overlap' (-not (Test-Path $linkBad)) 'output file exists'

    # 5. one RAM object + one RAM-free object links fine
    $linkOk = Join-Path $tmp 'mixed_link.bin'
    & .\arkcc.exe -link $objA $objC -o $linkOk 2>&1 | Out-Null
    Check "one RAM object links (exit=$LASTEXITCODE)" ($LASTEXITCODE -eq 0) "arkcc returned $LASTEXITCODE"
    Check 'mixed link wrote an image' (Test-Path $linkOk) 'no output'
}
finally {
    Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
}

Write-Host ''
Write-Host "link gate: pass=$p fail=$f"
if ($f -gt 0) { exit 1 }
exit 0
