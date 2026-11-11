# Ark C Compiler regression runner.
#
# For every examples/*.c:
#   1. [arm]  -target arm -S must emit assembly without error (syntax/IR smoke
#             test).  $expectArmFail lists files whose ARM emit MUST be refused
#             instead; it is empty now that the ARM backend has a va region, and
#             the table stays as the place to pin a future refusal.
#   2. [c]    -target c -> host gcc -> run, and the process exit code must equal the
#             "Expected exit code: N" value declared in the test's comment header.
#
# Why the expected-value check exists: the old runner treated EVERY non-negative
# exit code as a pass ("tests use main()'s return value as a computation result"),
# so a test could return 0 (or any wrong value) and still be reported green. That
# made "N passed, 0 failed" meaningless: it only detected hard crashes.
#
# Usage:
#   powershell -File examples\run_tests.ps1               # run everything
#   powershell -File examples\run_tests.ps1 -Filter setjmp
#   powershell -File examples\run_tests.ps1 -Gcc "D:\mingw\MinGW\bin\gcc.exe"
#
# Exit code: 0 = all expectations met, 1 = at least one failure, 2 = setup problem.

param(
    [string]$Filter = "",
    [string]$Gcc = "",
    [switch]$KeepArtifacts
)

$ErrorActionPreference = 'Stop'
Set-Location (Split-Path -Parent $PSScriptRoot)

if (-not (Test-Path .\arkcc.exe)) {
    Write-Host "[run_tests] arkcc.exe not found, please build first"
    exit 2
}

# ---- locate gcc -----------------------------------------------------------
if ($Gcc -eq "") {
    $cmd = Get-Command gcc -ErrorAction SilentlyContinue
    if ($cmd) {
        $Gcc = $cmd.Source
    } else {
        $candidates = @(
            "D:\mingw\MinGW\bin\gcc.exe",
            "C:\mingw\bin\gcc.exe",
            "C:\msys64\mingw64\bin\gcc.exe",
            "C:\TDM-GCC-64\bin\gcc.exe",
            "C:\mingw64\bin\gcc.exe"
        )
        foreach ($c in $candidates) { if (Test-Path $c) { $Gcc = $c; break } }
    }
}
if ($Gcc -eq "" -or -not (Test-Path $Gcc)) {
    Write-Host "[run_tests] host gcc not found; pass -Gcc <path-to-gcc.exe>"
    exit 2
}

# gcc needs its own directory on PATH to find its cc1/as/ld children.
$gccBin = Split-Path -Parent $Gcc
$env:PATH = $gccBin + ";" + $env:PATH

$Arkcc = (Resolve-Path .\arkcc.exe).Path
Write-Host "[run_tests] arkcc : $Arkcc"
Write-Host "[run_tests] gcc   : $Gcc"

# ---- tests that cannot run through the C backend on a PC -------------------
# Reason per entry so nobody has to rediscover it.
$skipC = @{
    # ARM inline assembly in __asm blocks; host gcc cannot assemble it.
    "test_asm_func"             = "ARM-only (inline __asm block)"
    "test_asm_operand"          = "ARM-only (inline __asm operands)"
    # Touches STM32 hardware registers (e.g. 0x580244E0) -> faults on host.
    "stm32_blink"               = "STM32 hardware access"
    "stm32_shell_blink"         = "STM32 hardware access"
    # Multi-file programs are not listed here on purpose: the directory filter
    # below excludes feat_multifile_* / test_multi_*, because their extra .c
    # files are not on the gcc command line and the helpers are not standalone
    # tests. Dead entries in this table would only mask that.
}

# Files whose ARM emit MUST fail. These use a feature the ARM backend does
# not implement, and the point of the entry is to keep that honest: if
# somebody implements the feature the ARM emit starts succeeding and this
# table turns red -- the signal is to move the file back to the normal [arm]
# check and delete the entry, not to "fix" the test.
# No file is exempt from the ARM emit check: the ARM backend implements the
# va region now (4-byte word slots -- see src/backend/arm/backend_arm.c
# and stdlib/include/stdarg.h), so the four variadic files that used to be
# listed here emit like everything else.  Execution of that region is gated
# separately by examples/run_va_gate.py, which runs the produced code in
# unicorn and compares the result against gcc.
$expectArmFail = @{}

# Files that *declare* a global whose storage lives in another translation unit
# (stdlib/src/errno.c defines `errno`, errno.h only declares it).  A single-object
# ARM image has no channel for another unit's data address, so the ARM emit must
# fail -- with exactly that diagnostic.  It is not an unimplemented feature, so
# it does not belong in $expectArmFail; and it is not a failure either, because
# the file still runs through the C backend (host gcc links the real errno).
$armNeedsLink = @{
    "c99_armcc5_compat_test" = "errno lives in stdlib/src/errno.c (build with -c + link)"
}

function Get-ExpectedExitCode {
    param([string]$Path)

    # Only look inside the leading comment header (first 40 lines) so a stray
    # "Expected exit code" inside a code comment cannot hijack the assertion.
    $head = Get-Content -LiteralPath $Path -TotalCount 40 -ErrorAction Stop
    foreach ($line in $head) {
        if ($line -match 'Expected\s+exit\s+code\s*:\s*(.+?)\s*$') {
            $raw = $Matches[1].Trim()
            # Accept "42", "-3", "0x2A"; reject expressions (they are ambiguous
            # and must be normalised in the test source instead of guessed here).
            # A literal, optionally followed by a human explanation in parentheses
            # (e.g. "127   (g_x(7) + g_dim(7) ...)"); the number is what is checked.
            if ($raw -match '^(-?)(0x[0-9A-Fa-f]+|\d+)\b') {
                $neg = $Matches[1] -eq '-'
                $num = $Matches[2]
                if ($num -match '^0x') { $v = [int64][Convert]::ToInt64($num.Substring(2), 16) }
                else { $v = [int64]$num }
                if ($neg) { $v = -$v }
                return @{ Found = $true; Value = [int]$v; Raw = $raw }
            }
            return @{ Found = $false; Value = 0; Raw = $raw }
        }
    }
    return @{ Found = $false; Value = 0; Raw = "" }
}

function Invoke-Cmd {
    # Run an executable with an explicit argument array (PowerShell quotes each
    # element), swallow its stdout/stderr, and return the exit code plus the
    # first output line so a failure can be explained.
    param([string]$Exe, [string[]]$Argv)

    # A native command writing to stderr raises NativeCommandError under
    # 'Stop', which would abort the whole run just because arkcc printed a
    # diagnostic. Keep 'Continue' for the duration of the call.
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    $out = & $Exe @Argv 2>&1
    $code = $LASTEXITCODE
    $ErrorActionPreference = $prevEAP
    $text = @($out | ForEach-Object { "$_" })
    $first = ""
    if ($text.Count -gt 0) { $first = $text[0].Trim() }
    return @{ Code = $code; First = $first; Text = ($text -join "`n") }
}

$examples = Get-ChildItem examples\*.c |
    Where-Object { $_.Name -notlike "*.gen.c" -and $_.Name -notlike "feat_multifile_*" -and $_.Name -notlike "test_multi_*" }
if ($Filter -ne "") {
    $examples = $examples | Where-Object { $_.BaseName -like "*$Filter*" }
}
if ($examples.Count -eq 0) {
    Write-Host "[run_tests] no test files matched"
    exit 2
}

$pass = @()
$fail = @()
$skip = @()
$noexp = @()

foreach ($f in $examples) {
    $base = $f.BaseName
    $fileFailures = @()
    $detail = ""

    Write-Host "===== $($f.Name) ====="

    # --- 1. ARM backend: emit assembly, no run (no ARM target available) ---
    $armOut = Join-Path $env:TEMP "$base.arm.s"
    Remove-Item -LiteralPath $armOut -ErrorAction SilentlyContinue
    $arm = Invoke-Cmd -Exe $Arkcc -Argv @($f.FullName, "-target", "arm", "-S", "-o", $armOut)
    Remove-Item -LiteralPath $armOut -ErrorAction SilentlyContinue
    if ($expectArmFail.ContainsKey($base)) {
        # Expected refusal: the emit must fail AND say why. A bare nonzero
        # exit would also come out of a crash, so the text is checked too.
        if ($arm.Code -eq 0) {
            Write-Host "  [arm] EMIT SUCCEEDED but this file must be refused"
            $fileFailures += "arm emit should have been refused"
            $detail = "the ARM backend accepted a feature it does not implement"
        } elseif ($arm.Text -notmatch "not supported by the ARM backend") {
            Write-Host "  [arm] REFUSED with the wrong diagnostic (exit $($arm.Code))"
            if ($arm.First -ne "") { Write-Host "        $($arm.First)" }
            $fileFailures += "arm refusal diagnostic mismatch"
            $detail = $arm.First
        } else {
            Write-Host "  [arm] REFUSED as expected ($($expectArmFail[$base]))"
        }
    } elseif ($arm.Code -ne 0 -and $armNeedsLink.ContainsKey($base)) {
        if ($arm.Text -notmatch "carries no channel for another unit's data address") {
            Write-Host "  [arm] EMIT FAILED for an unexpected reason (exit $($arm.Code))"
            if ($arm.First -ne "") { Write-Host "        $($arm.First)" }
            $fileFailures += "arm emit failed with the wrong diagnostic"
            $detail = $arm.First
        } else {
            Write-Host "  [arm] REFUSED as expected ($($armNeedsLink[$base]))"
        }
    } elseif ($arm.Code -ne 0) {
        Write-Host "  [arm] EMIT FAILED (exit $($arm.Code))"
        if ($arm.First -ne "") { Write-Host "        $($arm.First)" }
        $fileFailures += "arm emit failed"
        $detail = $arm.First
    } else {
        Write-Host "  [arm] asm OK"
    }

    # --- 2. C backend: emit -> gcc -> run -> compare exit code ---
    if ($skipC.ContainsKey($base)) {
        Write-Host "  [c]   SKIP ($($skipC[$base]))"
        # A skipped C run is NOT a pass: only the ARM emit above was checked.
        # Counting it as `pass` made the old summary claim coverage it never
        # had, so skip and pass are now disjoint buckets.
        if ($fileFailures.Count -eq 0) { $skip += "$base ($($skipC[$base]))" }
        else { $fail += @{ Name = $base; Reasons = $fileFailures; Detail = $detail } }
        continue
    }

    $expect = Get-ExpectedExitCode -Path $f.FullName

    $genc = Join-Path (Get-Location) "examples\$base.gen.c"
    $exe  = Join-Path (Get-Location) "examples\$base.gen.exe"
    Remove-Item -LiteralPath $genc -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $exe -ErrorAction SilentlyContinue

    $emit = Invoke-Cmd -Exe $Arkcc -Argv @($f.FullName, "-target", "c", "-o", $genc)
    if ($emit.Code -ne 0) {
        Write-Host "  [c]   EMIT FAILED (exit $($emit.Code))"
        if ($emit.First -ne "") { Write-Host "        $($emit.First)" }
        $fileFailures += "c emit failed"
        $detail = $emit.First
        $fail += @{ Name = $base; Reasons = $fileFailures; Detail = $detail }
        continue
    }
    if (-not (Test-Path $genc)) {
        Write-Host "  [c]   EMIT reported success but produced no file"
        $fileFailures += "c emit produced no output"
        $fail += @{ Name = $base; Reasons = $fileFailures; Detail = $detail }
        continue
    }

    # -O0 is the semantic baseline: it keeps the suite stable while the
    # generated code is still evolving. The old strict-aliasing UB (frame
    # accessed through casted pointers) is gone - frame reads/writes now go
    # through the ark_fld/ark_fst memcpy helpers in the emitted prelude - and
    # the whole suite was re-verified clean at -O2 without
    # -fno-strict-aliasing. The flag is kept as a cheap guard against new
    # aliasing regressions in the emitter.
    $cc = Invoke-Cmd -Exe $Gcc -Argv @("-O0", "-w", "-fno-strict-aliasing", $genc, "-o", $exe, "-lm")
    if ($cc.Code -ne 0) {
        Write-Host "  [c]   gcc FAILED to compile generated C"
        if ($cc.First -ne "") { Write-Host "        $($cc.First)" }
        $fileFailures += "gcc compile failed"
        $detail = $cc.First
        $fail += @{ Name = $base; Reasons = $fileFailures; Detail = $detail }
        continue
    }

    # Run the produced executable and capture its exit status.
    $run = Invoke-Cmd -Exe $exe -Argv @()
    $rc = $run.Code

    # Windows exit codes: NTSTATUS-style crash values arrive as large unsigned
    # (0xC0000005) or negative numbers; normalise to unsigned for reporting.
    # NOTE: PowerShell 5.1 parses the literal 0xC0000000 as Int32 and silently
    # wraps it to -1073741824, which makes any small positive exit code look
    # like a crash. Use explicit decimal Int64 constants instead.
    $urc = if ($rc -lt 0) { [int64]$rc + 4294967296 } else { [int64]$rc }
    $crashBase = [int64]3221225472

    if ($urc -ge $crashBase) {
        $hex = ('0x{0:X8}' -f $urc)
        Write-Host "  [c]   CRASH (status $hex)"
        $fileFailures += "crash $hex"
    } elseif (-not $expect.Found) {
        if ($expect.Raw -ne "") {
            Write-Host "  [c]   exit=$urc, expectation '$($expect.Raw)' is not a literal -> NOT CHECKED"
            $noexp += "$base ('$($expect.Raw)')"
        } else {
            Write-Host "  [c]   exit=$urc, no 'Expected exit code' declared -> NOT CHECKED"
            $noexp += "$base (none)"
        }
    } elseif ($urc -ne $expect.Value) {
        Write-Host "  [c]   MISMATCH: exit=$urc, expected=$($expect.Value)"
        $fileFailures += "exit $urc != expected $($expect.Value)"
    } else {
        Write-Host "  [c]   exit=$urc (expected) OK"
    }

    if ($fileFailures.Count -eq 0) { $pass += $base }
    else { $fail += @{ Name = $base; Reasons = $fileFailures; Detail = $detail } }
}

# ---- summary --------------------------------------------------------------
Write-Host ""
Write-Host "==================== summary ===================="
Write-Host ("  asserted pass : {0}" -f $pass.Count)
Write-Host ("  failed        : {0}" -f $fail.Count)
Write-Host ("  c-run skipped : {0}  (arm emit checked; exit code NOT asserted)" -f $skip.Count)
Write-Host ("  not asserted  : {0}" -f $noexp.Count)
Write-Host ("  total listed  : {0}" -f ($pass.Count + $fail.Count + $skip.Count + $noexp.Count))

if ($fail.Count -gt 0) {
    Write-Host ""
    Write-Host "---- failures ----"
    foreach ($item in $fail) {
        if ($item -is [string]) { Write-Host "  $item" }
        else {
            $line = "  {0}: {1}" -f $item.Name, ($item.Reasons -join "; ")
            if ($item.Detail -ne "") { $line += "  [$($item.Detail)]" }
            Write-Host $line
        }
    }
}
if ($noexp.Count -gt 0) {
    Write-Host ""
    Write-Host "---- no machine-checkable expectation (add 'Expected exit code: N') ----"
    foreach ($n in $noexp) { Write-Host "  $n" }
}
if ($skip.Count -gt 0) {
    Write-Host ""
    Write-Host "---- c backend skipped ----"
    foreach ($s in $skip) { Write-Host "  $s" }
}

if (-not $KeepArtifacts) {
    Get-ChildItem examples\*.gen.c -ErrorAction SilentlyContinue | Remove-Item -ErrorAction SilentlyContinue
    Get-ChildItem examples\*.gen.exe -ErrorAction SilentlyContinue | Remove-Item -ErrorAction SilentlyContinue
}

if ($fail.Count -gt 0) { exit 1 }
exit 0
