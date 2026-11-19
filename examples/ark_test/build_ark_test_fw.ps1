# Build ark_test HAL project: compile + generate firmware
$ErrorActionPreference = "Continue"

# Step 1: Compile with arkcc
Write-Host "[1/2] Compiling ark_test_all.c with arkcc..."
./arkcc.exe examples/ark_test/ark_test_all.c -target arm -c --vector-table `
    -D STM32F401xE `
    -I examples/ark_test `
    -I examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Inc `
    -I examples/ark_test/Core/Inc `
    -I examples/ark_test/Drivers/CMSIS/Device/ST/STM32F4xx/Include `
    -I examples/ark_test/Drivers/CMSIS/Core/Include `
    -o examples/ark_test/ark_test_all.ark_obj

if ($LASTEXITCODE -ne 0) {
    Write-Host "FAIL: arkcc compilation failed" -ForegroundColor Red
    exit 1
}
Write-Host "  OK: ark_test_all.ark_obj generated"

# Step 2: Generate firmware binary
Write-Host "[2/2] Generating firmware..."
# Name the interpreter by its own path: a bare `powershell` is resolved through
# PATH, which is not the same PATH this file was launched with (Git Bash, MSYS,
# a CI shell), and a missing command reports no exit code at all -- the step
# then "failed" and the script still printed BUILD SUCCESSFUL.
$psExe = Join-Path $PSHOME 'powershell.exe'
if (-not (Test-Path $psExe)) { $psExe = Join-Path $PSHOME 'pwsh.exe' }
& $psExe -NoProfile -ExecutionPolicy Bypass -File examples\ark_test\build_ark_fw.ps1 -ObjFile examples/ark_test/ark_test_all.ark_obj -OutBin examples/ark_test/ark_test_fw.bin

if ($LASTEXITCODE -ne 0) {
    Write-Host "FAIL: firmware generation failed (exit $LASTEXITCODE)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "BUILD SUCCESSFUL" -ForegroundColor Green
Write-Host "  Firmware: examples/ark_test/ark_test_fw.bin"
