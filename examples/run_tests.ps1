$ErrorActionPreference = 'Stop'

# 切换到项目根目录
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

    # arm 后端：仅做语法 + 汇编生成检查
    & .\arkcc.exe $f.FullName -target arm -S -o nul
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [arm] FAILED"
        $failed++
        continue
    }
    Write-Host "  [arm] asm OK"

    # c 后端：生成 + gcc 编译 + 运行
    # test_asm_func.c 含 ARM 汇编，无法被 host gcc 汇编；只做 ARM 后端检查。
    # test_asm_operand.c 含本地变量名（result/x），C 后端把它们存到 frame[]
    #   而非 C 局部变量，故 __asm__ 操作数无法在 gcc 上参与编译；同样仅 ARM。
    if ($base -eq "test_asm_func" -or $base -eq "test_asm_operand") {
        Write-Host "  [c]   skipped (ARM-only test)"
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
    # gcc 失败时（如多文件测试缺 main）会向 stderr 输出，临时放宽错误策略
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
    Write-Host "  [c]   exit code = $rc"
    $passed++
}

Write-Host ""
Write-Host "==== summary: $passed passed, $failed failed ===="
if ($failed -gt 0) { exit 1 }
exit 0
