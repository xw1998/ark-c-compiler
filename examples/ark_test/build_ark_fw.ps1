# Build STM32F401xE firmware from ARKOBJ2 for ark_test HAL project
param(
    [string]$ObjFile = "ark_test_all.ark_obj",
    [string]$OutBin = "ark_test_fw.bin"
)
$flashBase = 0x08000000
$spTop     = 0x20018000  # 96KB SRAM for STM32F401xE

$obj = [System.IO.File]::ReadAllBytes($ObjFile)

# Verify ARKOBJ2 header
$header = [System.Text.Encoding]::ASCII.GetString($obj[0..6])
if ($header -ne 'ARKOBJ2') {
    Write-Host "ERROR: Not ARKOBJ2 format (got: $header)"
    exit 1
}

# Parse ARKOBJ2
$pos = 8
$codeSize = [BitConverter]::ToInt32($obj, $pos); $pos += 4
$codeBytes = $obj[($pos)..($pos + $codeSize - 1)]
$pos += $codeSize

$symCount = [BitConverter]::ToInt32($obj, $pos); $pos += 4
Write-Host "code size: $codeSize bytes, symbols: $symCount"

$syms = @{}
for ($i = 0; $i -lt $symCount; $i++) {
    $nameLen = [BitConverter]::ToInt32($obj, $pos); $pos += 4
    $name = [System.Text.Encoding]::ASCII.GetString($obj, $pos, $nameLen - 1)
    $pos += $nameLen
    $offset = [BitConverter]::ToInt32($obj, $pos); $pos += 4
    $type   = $obj[$pos]; $pos += 1
    $isWeak = $obj[$pos]; $pos += 1
    $syms[$name] = $offset
}

# STM32F401xE: 16 system exceptions + 93 peripheral IRQs = 109 vectors.
# Pad to 8-byte alignment so code start is 8-byte aligned (AAPCS SP requirement
# and ensures 32-bit Thumb-2 instructions land on natural boundaries).
$vtEntries = 109
$vtSize = $vtEntries * 4
# Round up to 8-byte boundary (109*4=436 -> 440). Use 112 entries = 448 bytes.
$vtEntriesPadded = ($vtEntries + 1) -band (-bnot 1)  # round up to even
$vtSizePadded = $vtEntriesPadded * 4
$vt = New-Object byte[] $vtSizePadded

# [0] Initial SP
[Array]::Copy([BitConverter]::GetBytes([uint32]$spTop), 0, $vt, 0, 4)

function HandlerAddr($offset) {
    # Thumb bit set: address | 1
    return [uint32]($flashBase + $vtSizePadded + $offset + 1)
}

function GetSym($name) {
    if ($syms.ContainsKey($name)) { return $syms[$name] }
    return $syms['Default_Handler']
}

# System exception handlers (indices 1-15)
$sysHandlers = @(
    'Reset_Handler',      # 1
    'NMI_Handler',        # 2
    'HardFault_Handler',  # 3
    'MemManage_Handler',  # 4
    'BusFault_Handler',   # 5
    'UsageFault_Handler', # 6
    $null,                # 7 Reserved
    $null,                # 8 Reserved
    $null,                # 9 Reserved
    $null,                # 10 Reserved
    'SVC_Handler',        # 11
    'DebugMon_Handler',   # 12
    $null,                # 13 Reserved
    'PendSV_Handler',     # 14
    'SysTick_Handler'     # 15
)
for ($i = 0; $i -lt 15; $i++) {
    $idx = $i + 1
    if ($sysHandlers[$i]) {
        $off = GetSym $sysHandlers[$i]
        $addr = HandlerAddr $off
    } else {
        $addr = 0
    }
    [Array]::Copy([BitConverter]::GetBytes([uint32]$addr), 0, $vt, $idx * 4, 4)
}

# Peripheral IRQs (indices 16+): all default to Default_Handler
$defaultAddr = [uint32](HandlerAddr (GetSym 'Default_Handler'))
for ($i = 16; $i -lt $vtEntries; $i++) {
    [Array]::Copy([BitConverter]::GetBytes([uint32]$defaultAddr), 0, $vt, $i * 4, 4)
}

# Combine vector table + code, with 8-byte padding on code end so the
# resulting firmware file is a multiple of 8 bytes (AAPCS alignment).
$codeLenPadded = ($codeBytes.Length + 7) -band (-bnot 7)  # round up to 8
$codePadded = New-Object byte[] $codeLenPadded
[Array]::Copy($codeBytes, 0, $codePadded, 0, $codeBytes.Length)

$fwLen = $vt.Length + $codePadded.Length
$fw = New-Object byte[] $fwLen
$vt.CopyTo($fw, 0)
[Array]::Copy($codePadded, 0, $fw, $vt.Length, $codePadded.Length)

[System.IO.File]::WriteAllBytes($OutBin, $fw)
Write-Host ""
Write-Host "firmware: $OutBin ($($fw.Length) bytes)"
Write-Host ("  Reset     = 0x{0:X8}" -f [BitConverter]::ToUInt32($vt, 4))
Write-Host ("  NMI       = 0x{0:X8}" -f [BitConverter]::ToUInt32($vt, 8))
Write-Host ("  HardFault = 0x{0:X8}" -f [BitConverter]::ToUInt32($vt, 12))
Write-Host ("  SysTick   = 0x{0:X8}" -f [BitConverter]::ToUInt32($vt, 60))
Write-Host ("  Default   = 0x{0:X8}" -f [BitConverter]::ToUInt32($vt, 64))
