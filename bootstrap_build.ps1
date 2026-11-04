# Bootstrap build script: compile arkcc sources with arkcc, then gcc, then link
$ErrorActionPreference = 'SilentlyContinue'

$srcFiles = @(
    'ast','codegen_common','compiler','config','cpu','diag','diag_msg_table','ir','irgen','lexer',
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

Write-Host "=== Phase 1: Compile $($allFiles.Count) sources with arkcc ==="
$fail = 0
foreach ($f in $allFiles) {
    $base = [System.IO.Path]::GetFileNameWithoutExtension($f)
    $out = "bootstrap\src_$base.c.gen.c"
    & .\arkcc.exe -target c -I include $f -o $out 2>$null
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $out)) {
        Write-Host "  FAIL: $f -> $out (exit=$LASTEXITCODE)"
        $fail++
    } else {
        Write-Host "  OK:   $f"
    }
}
Write-Host "Phase 1: $fail failures"
if ($fail -gt 0) { exit 1 }

Write-Host ""
Write-Host "=== Phase 2: Compile .gen.c with gcc ==="
$fail2 = 0
$objs = @()
foreach ($f in $allFiles) {
    $base = [System.IO.Path]::GetFileNameWithoutExtension($f)
    $gen = "bootstrap\src_$base.c.gen.c"
    $obj = "bootstrap\src_$base.c.gen.o"
    & gcc -w -O0 -g -std=c99 -Iinclude -c $gen -o $obj 2>$null
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $obj)) {
        Write-Host "  FAIL: $gen (exit=$LASTEXITCODE)"
        $fail2++
    } else {
        $objs += $obj
        Write-Host "  OK:   $gen"
    }
}
Write-Host "Phase 2: $fail2 failures"
if ($fail2 -gt 0) { exit 2 }

Write-Host ""
Write-Host "=== Phase 3: Link into arkcc_bootstrap.exe ==="
$linkArgs = @('-O2','-std=c99','-Wl,--stack,67108864') + $objs + @('-o','bootstrap\arkcc_bootstrap.exe')
& gcc @linkArgs 2>$null
if ($LASTEXITCODE -ne 0 -or -not (Test-Path 'bootstrap\arkcc_bootstrap.exe')) {
    Write-Host "  FAIL: link (exit=$LASTEXITCODE)"
    exit 3
}
Write-Host "  OK: bootstrap\arkcc_bootstrap.exe built"
Write-Host ""
Write-Host "=== Phase 4: Test bootstrap ==="
& .\bootstrap\arkcc_bootstrap.exe -target c -I include examples\hello.c -o bootstrap\hello_bootstrap.gen.c 2>&1
Write-Host "Bootstrap exit code: $LASTEXITCODE"
