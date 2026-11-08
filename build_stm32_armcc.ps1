# Ark C Compiler - STM32 firmware build with armcc5
# Run from project root: powershell -ExecutionPolicy Bypass -File build_stm32_armcc.ps1

$ARMCC   = "D:\Keil_v5\ARM\ARMCC\bin\armcc.exe"
$ARMASM  = "D:\Keil_v5\ARM\ARMCC\bin\armasm.exe"
$ARMLINK = "D:\Keil_v5\ARM\ARMCC\bin\armlink.exe"
$FROMELF = "D:\Keil_v5\ARM\ARMCC\bin\fromelf.exe"

# Use relative paths from CWD to avoid Chinese path encoding issues
$MDK     = "mdk\STM32H743_ArkCC"
$OBJDIR  = "bootstrap_x86\armcc_objs"
$SCT     = "$MDK\Linker\STM32H743VITx_FLASH.sct"
$ELF     = "$OBJDIR\arkcc_stm32.elf"
$HEX     = "$OBJDIR\arkcc_stm32.hex"
$BIN     = "$OBJDIR\arkcc_stm32.bin"

# Common flags
$CFLAGS_BASE = @(
    "-c", "--cpu=Cortex-M7", "--thumb", "-O0", "-g", "--c99", "--apcs=interwork",
    "-DARM_MATH_CM7", "-DUSE_HAL_DRIVER", "-DSTM32H743xx",
    "-DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN", "-DARKCC_BACKEND_X86_64=0",
    "-DHAL_MAX_DELAY=0xFFFFFFFFU",
    "-Iinclude",
    "-Istdlib\include",
    "-Iport\stm32",
    "-I$MDK\User\Inc",
    "-I$MDK\Drivers\CMSIS\Device\ST\STM32H7xx\Include",
    "-I$MDK\Drivers\CMSIS\Include"
)

# Ensure output directory exists
if (!(Test-Path $OBJDIR)) { New-Item -ItemType Directory -Path $OBJDIR -Force | Out-Null }

# Function to compile a single .c file
function Compile-C($srcRel, $objName) {
    $src = $srcRel
    $obj = "$OBJDIR\$objName"
    if (!(Test-Path $src)) { Write-Host "SKIP (not found): $src" -ForegroundColor Yellow; return $false }
    $args = $CFLAGS_BASE + @($src, "-o$obj")
    Write-Host "CC $srcRel" -ForegroundColor Cyan
    & $ARMCC @args 2>&1 | ForEach-Object {
        $line = $_.ToString()
        if ($line -match "Error") { Write-Host "  $line" -ForegroundColor Red }
        elseif ($line -match "Warning") { Write-Host "  $line" -ForegroundColor Yellow }
        else { Write-Host "  $line" -ForegroundColor Gray }
    }
    if ($LASTEXITCODE -ne 0) { Write-Host "FAIL: $srcRel (exit $LASTEXITCODE)" -ForegroundColor Red; return $false }
    return $true
}

# === 1. Compile arkCC core source files ===
$coreFiles = @(
    @{src="src\ast.c";              obj="ast.o"},
    @{src="src\agginit.c";         obj="agginit.o"},
    @{src="src\codegen_common.c";   obj="codegen_common.o"},
    @{src="src\compiler.c";         obj="compiler.o"},
    @{src="src\config.c";           obj="config.o"},
    @{src="src\cpu.c";              obj="cpu.o"},
    @{src="src\diag.c";             obj="diag.o"},
    @{src="src\diag_msg_table.c";   obj="diag_msg_table.o"},
    @{src="src\ir.c";               obj="ir.o"},
    @{src="src\irgen.c";            obj="irgen.o"},
    @{src="src\lexer.c";            obj="lexer.o"},
    @{src="src\memory.c";           obj="memory.o"},
    @{src="src\opt.c";              obj="opt.o"},
    @{src="src\parser.c";           obj="parser.o"},
    @{src="src\preproc.c";          obj="preproc.o"},
    @{src="src\scatter.c";          obj="scatter.o"},
    @{src="src\sema.c";             obj="sema.o"},
    @{src="src\symtab.c";           obj="symtab.o"},
    @{src="src\type.c";              obj="type.o"}
)

# === 2. Compile backend files ===
$backendFiles = @(
    @{src="src\backend\arm\backend_arm.c"; obj="backend_arm.o"},
    @{src="src\backend\registry.c";         obj="registry.o"}
)

# === 3. Compile STM32 port files (exclude main_stm32.c - MDK main.c provides main) ===
$portFiles = @(
    @{src="port\stm32\flash_fs_stm32.c";  obj="flash_fs_stm32.o"},
    @{src="port\stm32\platform_stm32.c";   obj="platform_stm32.o"}
)

# === 4. Compile MDK user files ===
$mdkFiles = @(
    @{src="$MDK\User\main.c";              obj="mdk_main.o"},
    @{src="$MDK\User\stm32h7xx_it.c";      obj="stm32h7xx_it.o"},
    @{src="$MDK\User\stm32h7xx_hal_msp.c"; obj="stm32h7xx_hal_msp.o"},
    @{src="$MDK\User\system_stm32h7xx.c";   obj="system_stm32h7xx.o"},
    @{src="$MDK\User\bsp_w25q.c";           obj="bsp_w25q.o"}
)

# Compile all .c files
$allFiles = $coreFiles + $backendFiles + $portFiles + $mdkFiles
$failed = 0
foreach ($f in $allFiles) {
    if (!(Compile-C $f.src $f.obj)) { $failed++ }
}

if ($failed -gt 0) {
    Write-Host "`n$failed file(s) failed to compile" -ForegroundColor Red
    exit 1
}

Write-Host "`nAll C files compiled successfully" -ForegroundColor Green

# === 5. Assemble startup file ===
Write-Host "AS startup_stm32h743xx.s" -ForegroundColor Cyan
& $ARMASM --cpu=Cortex-M7 --thumb --apcs=interwork -g `
    "-I$MDK\Startup" `
    "$MDK\Startup\startup_stm32h743xx.s" `
    "-o$OBJDIR\startup_stm32h743xx.o" 2>&1 | ForEach-Object {
    Write-Host "  $_" -ForegroundColor Gray
}
if ($LASTEXITCODE -ne 0) { Write-Host "FAIL: startup (exit $LASTEXITCODE)" -ForegroundColor Red; exit 1 }

# === 6. Link ===
# Derived from $allFiles on purpose: a hand-maintained second list is exactly
# how a new module gets compiled but never linked.
$objs = @("$OBJDIR\startup_stm32h743xx.o") + ($allFiles | ForEach-Object { "$OBJDIR\$($_.obj)" })

Write-Host "`nLINK arkcc_stm32.elf" -ForegroundColor Cyan
$linkArgs = @(
    "--map",
    "--symbols",
    "--summary_stderr",
    "--info=totals",
    "--info=sizes",
    "--info=unused",
    "--info=summarysizes"
) + $objs + @(
    "--scatter=$SCT",
    "-o$ELF"
)
& $ARMLINK @linkArgs 2>&1 | ForEach-Object {
    $line = $_.ToString()
    if ($line -match "Error") { Write-Host "  $line" -ForegroundColor Red }
    elseif ($line -match "Warning") { Write-Host "  $line" -ForegroundColor Yellow }
    else { Write-Host "  $line" -ForegroundColor Gray }
}
if ($LASTEXITCODE -ne 0) { Write-Host "FAIL: link (exit $LASTEXITCODE)" -ForegroundColor Red; exit 1 }

# === 7. Generate .hex and .bin ===
Write-Host "GEN arkcc_stm32.hex" -ForegroundColor Cyan
& $FROMELF --i32 -o $HEX $ELF 2>&1 | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
if ($LASTEXITCODE -ne 0) { Write-Host "FAIL: hex (exit $LASTEXITCODE)" -ForegroundColor Red; exit 1 }

Write-Host "GEN arkcc_stm32.bin" -ForegroundColor Cyan
& $FROMELF --bin -o $BIN $ELF 2>&1 | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
if ($LASTEXITCODE -ne 0) { Write-Host "FAIL: bin (exit $LASTEXITCODE)" -ForegroundColor Red; exit 1 }

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "BUILD SUCCESSFUL" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "ELF: $ELF"
Write-Host "HEX: $HEX"
Write-Host "BIN: $BIN"
