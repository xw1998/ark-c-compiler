$file = 'd:\นคื๗\git_project\ark c compiler\src\parser.c'
$patterns = @('parse_func_modifiers','parse_declspec','parse_attribute','TOK_SVC','TOK_IRQ','TOK_WEAK','TOK_NAKED','TOK_ASM_FUNC','TOK_PACKED_KW','TOK_ALIGN_KW','TOK_AT','TOK_SOFTFP','TOK_FORCEINLINE')
$lines = Get-Content $file
for ($i = 0; $i -lt $lines.Count; $i++) {
    foreach ($pat in $patterns) {
        if ($lines[$i] -like "*$pat*") {
            Write-Host ("{0}:{1}" -f ($i+1), $lines[$i].Trim())
            break
        }
    }
}
