# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz "RO"
ark_str_1:
    .asciz "RW"
ark_str_2:
    .asciz "ZI"
ark_str_3:
    .asciz "XO"
ark_str_4:
    .asciz "FIRST"
ark_str_5:
    .asciz "LAST"
ark_str_6:
    .asciz "RO"
ark_str_7:
    .asciz "RW"
ark_str_8:
    .asciz "ZI"
ark_str_9:
    .asciz "XO"
ark_str_10:
    .asciz "FIRST"
ark_str_11:
    .asciz "LAST"
ark_str_12:
    .asciz "[scatter] cannot open %s\n"
ark_str_13:
    .asciz "[scatter] file too large (>= %d), truncated\n"
ark_str_14:
    .asciz "LR_"
ark_str_15:
    .asciz "ER_"
ark_str_16:
    .asciz "RW_"
ark_str_17:
    .asciz "ZI_"
ark_str_18:
    .asciz "[scatter] parsed %s\n"
ark_str_19:
    .asciz "LR %s @0x%X size 0x%X\n"
ark_str_20:
    .asciz " [.ANY]"
ark_str_21:
    .asciz ""
ark_str_22:
    .asciz "  ER %s @0x%X size 0x%X attrs 0x%X%s\n"
ark_str_23:
    .asciz "    section: %s\n"
ark_str_24:
    .asciz "    selectors: %s\n"
ark_str_25:
    .asciz "LR_DEFAULT"
ark_str_26:
    .asciz "AT"
ark_str_27:
    .asciz ""
ark_str_28:
    .asciz "[ld] cannot open %s\n"
ark_str_29:
    .asciz "[ld] file too large (>= %d), truncated\n"
ark_str_30:
    .asciz "MEMORY"
ark_str_31:
    .asciz "SECTIONS"
ark_str_32:
    .asciz "[ld] parsed %s\n"
ark_str_33:
    .asciz "(null)"
ark_str_34:
    .asciz "0123456789ABCDEF"
ark_str_35:
    .asciz ".rodata"
ark_str_36:
    .asciz ".rodata"
ark_str_37:
    .asciz ".bss"
ark_str_38:
    .asciz ".bss"
ark_str_39:
    .asciz ".data"
ark_str_40:
    .asciz ".data"
ark_str_41:
    .asciz ".text"
ark_str_42:
    .asciz ".text"
ark_str_43:
    .asciz "+ZI"
ark_str_44:
    .asciz ".bss"
ark_str_45:
    .asciz "+RW"
ark_str_46:
    .asciz ".data"
ark_str_47:
    .asciz "+RO"
ark_str_48:
    .asciz "+XO"
ark_str_49:
    .asciz ".text"
ark_str_50:
    .asciz ".text"
ark_str_51:
    .asciz "MEMORY {\n"
ark_str_52:
    .asciz "  %s (rx) : ORIGIN = 0x%X, LENGTH = 0x%X\n"
ark_str_53:
    .asciz "  %s (rwx) : ORIGIN = 0x%X, LENGTH = 0x%X\n"
ark_str_54:
    .asciz "}\n"
ark_str_55:
    .asciz "SECTIONS {\n"
ark_str_56:
    .asciz ""
ark_str_57:
    .asciz "  %s 0x%X : { %s } > %s"
ark_str_58:
    .asciz ".data"
ark_str_59:
    .asciz " AT > %s"
ark_str_60:
    .asciz "\n"
ark_str_61:
    .asciz "}\n"
ark_str_62:
    .asciz "%s 0x%X 0x%X {\n"
ark_str_63:
    .asciz "    %s 0x%X 0x%X {\n"
ark_str_64:
    .asciz "        %s\n"
ark_str_65:
    .asciz "    }\n"
ark_str_66:
    .asciz "}\n"
    .data
    .text
    .globl sc_isspace
sc_isspace:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lsc_isspace_8
    push dword ptr [ebp-48]
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isspace_9
.Lsc_isspace_8:
    push 1
.Lsc_isspace_9:
    pop eax
    test eax, eax
    jnz .Lsc_isspace_6
    push dword ptr [ebp-48]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isspace_7
.Lsc_isspace_6:
    push 1
.Lsc_isspace_7:
    pop eax
    test eax, eax
    jnz .Lsc_isspace_4
    push dword ptr [ebp-48]
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isspace_5
.Lsc_isspace_4:
    push 1
.Lsc_isspace_5:
    pop eax
    test eax, eax
    jnz .Lsc_isspace_2
    push dword ptr [ebp-48]
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isspace_3
.Lsc_isspace_2:
    push 1
.Lsc_isspace_3:
    pop eax
    test eax, eax
    jnz .Lsc_isspace_0
    push dword ptr [ebp-48]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isspace_1
.Lsc_isspace_0:
    push 1
.Lsc_isspace_1:
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl sc_isalnum
sc_isalnum:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lsc_isalnum_4
    push dword ptr [ebp-48]
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isalnum_5
.Lsc_isalnum_4:
    push 0
.Lsc_isalnum_5:
    pop eax
    test eax, eax
    jnz .Lsc_isalnum_2
    push dword ptr [ebp-48]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lsc_isalnum_6
    push dword ptr [ebp-48]
    push 122
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isalnum_7
.Lsc_isalnum_6:
    push 0
.Lsc_isalnum_7:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isalnum_3
.Lsc_isalnum_2:
    push 1
.Lsc_isalnum_3:
    pop eax
    test eax, eax
    jnz .Lsc_isalnum_0
    push dword ptr [ebp-48]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lsc_isalnum_8
    push dword ptr [ebp-48]
    push 90
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isalnum_9
.Lsc_isalnum_8:
    push 0
.Lsc_isalnum_9:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isalnum_1
.Lsc_isalnum_0:
    push 1
.Lsc_isalnum_1:
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl sc_isdigit
sc_isdigit:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lsc_isdigit_0
    push dword ptr [ebp-48]
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isdigit_1
.Lsc_isdigit_0:
    push 0
.Lsc_isdigit_1:
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl sc_isxdigit
sc_isxdigit:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lsc_isxdigit_4
    push dword ptr [ebp-48]
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isxdigit_5
.Lsc_isxdigit_4:
    push 0
.Lsc_isxdigit_5:
    pop eax
    test eax, eax
    jnz .Lsc_isxdigit_2
    push dword ptr [ebp-48]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lsc_isxdigit_6
    push dword ptr [ebp-48]
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isxdigit_7
.Lsc_isxdigit_6:
    push 0
.Lsc_isxdigit_7:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isxdigit_3
.Lsc_isxdigit_2:
    push 1
.Lsc_isxdigit_3:
    pop eax
    test eax, eax
    jnz .Lsc_isxdigit_0
    push dword ptr [ebp-48]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lsc_isxdigit_8
    push dword ptr [ebp-48]
    push 70
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isxdigit_9
.Lsc_isxdigit_8:
    push 0
.Lsc_isxdigit_9:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_isxdigit_1
.Lsc_isxdigit_0:
    push 1
.Lsc_isxdigit_1:
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl sc_toupper
sc_toupper:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lsc_toupper_2
    push dword ptr [ebp-48]
    push 122
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lsc_toupper_3
.Lsc_toupper_2:
    push 0
.Lsc_toupper_3:
    pop eax
    test eax, eax
    jz .Lsc_toupper_0
    push dword ptr [ebp-48]
    push 32
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    jmp .Lsc_toupper_1
.Lsc_toupper_0:
    push dword ptr [ebp-48]
.Lsc_toupper_1:
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl skip_ws
skip_ws:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
.Lskip_ws_0:
.Lskip_ws_3:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_5
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call sc_isspace
    mov esp, [ebp-64]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_ws_6
.Lskip_ws_5:
    push 0
.Lskip_ws_6:
    pop eax
    test eax, eax
    jz .Lskip_ws_4
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lskip_ws_3
.Lskip_ws_4:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 59
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_7
.Lskip_ws_9:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_11
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_ws_12
.Lskip_ws_11:
    push 0
.Lskip_ws_12:
    pop eax
    test eax, eax
    jz .Lskip_ws_10
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lskip_ws_9
.Lskip_ws_10:
    jmp .Lskip_ws_2
    jmp .Lskip_ws_8
.Lskip_ws_7:
.Lskip_ws_8:
    jmp .Lskip_ws_1
.Lskip_ws_2:
    jmp .Lskip_ws_0
.Lskip_ws_1:
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl read_ident
read_ident:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-64], eax
.Lread_ident_0:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lread_ident_2
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call sc_isalnum
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jnz .Lread_ident_6
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 95
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_ident_7
.Lread_ident_6:
    push 1
.Lread_ident_7:
    pop eax
    test eax, eax
    jnz .Lread_ident_4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 36
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_ident_5
.Lread_ident_4:
    push 1
.Lread_ident_5:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_ident_3
.Lread_ident_2:
    push 0
.Lread_ident_3:
    pop eax
    test eax, eax
    jz .Lread_ident_1
    push dword ptr [ebp-64]
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_ident_8
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lread_ident_9
.Lread_ident_8:
.Lread_ident_9:
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lread_ident_0
.Lread_ident_1:
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl read_addr
read_addr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-48]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_addr_2
    push dword ptr [ebp-48]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 120
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_addr_4
    push dword ptr [ebp-48]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 88
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_addr_5
.Lread_addr_4:
    push 1
.Lread_addr_5:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_addr_3
.Lread_addr_2:
    push 0
.Lread_addr_3:
    pop eax
    test eax, eax
    jz .Lread_addr_0
    push dword ptr [ebp-48]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
.Lread_addr_6:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lread_addr_8
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call sc_isxdigit
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_addr_9
.Lread_addr_8:
    push 0
.Lread_addr_9:
    pop eax
    test eax, eax
    jz .Lread_addr_7
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_addr_12
    push dword ptr [ebp-72]
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_addr_13
.Lread_addr_12:
    push 0
.Lread_addr_13:
    pop eax
    test eax, eax
    jz .Lread_addr_10
    push dword ptr [ebp-72]
    push 48
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    jmp .Lread_addr_11
.Lread_addr_10:
    push dword ptr [ebp-72]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_addr_16
    push dword ptr [ebp-72]
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_addr_17
.Lread_addr_16:
    push 0
.Lread_addr_17:
    pop eax
    test eax, eax
    jz .Lread_addr_14
    push dword ptr [ebp-72]
    push 97
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 10
    pop ecx
    pop eax
    add eax, ecx
    push eax
    jmp .Lread_addr_15
.Lread_addr_14:
    push dword ptr [ebp-72]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_addr_20
    push dword ptr [ebp-72]
    push 70
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_addr_21
.Lread_addr_20:
    push 0
.Lread_addr_21:
    pop eax
    test eax, eax
    jz .Lread_addr_18
    push dword ptr [ebp-72]
    push 65
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 10
    pop ecx
    pop eax
    add eax, ecx
    push eax
    jmp .Lread_addr_19
.Lread_addr_18:
    push 0
.Lread_addr_19:
.Lread_addr_15:
.Lread_addr_11:
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-64]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lread_addr_6
.Lread_addr_7:
    jmp .Lread_addr_1
.Lread_addr_0:
.Lread_addr_22:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lread_addr_24
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call sc_isdigit
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_addr_25
.Lread_addr_24:
    push 0
.Lread_addr_25:
    pop eax
    test eax, eax
    jz .Lread_addr_23
    push dword ptr [ebp-64]
    push 10
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lread_addr_22
.Lread_addr_23:
.Lread_addr_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 75
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_addr_28
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 107
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_addr_29
.Lread_addr_28:
    push 1
.Lread_addr_29:
    pop eax
    test eax, eax
    jz .Lread_addr_26
    push dword ptr [ebp-64]
    push 1024
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lread_addr_27
.Lread_addr_26:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 77
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_addr_32
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 109
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_addr_33
.Lread_addr_32:
    push 1
.Lread_addr_33:
    pop eax
    test eax, eax
    jz .Lread_addr_30
    push dword ptr [ebp-64]
    push 1024
    push 1024
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lread_addr_31
.Lread_addr_30:
.Lread_addr_31:
.Lread_addr_27:
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl collect_braces
collect_braces:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 380
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call skip_ws
    mov esp, [ebp-128]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcollect_braces_0
    push dword ptr [ebp-80]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lcollect_braces_1
.Lcollect_braces_0:
.Lcollect_braces_1:
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lcollect_braces_2:
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcollect_braces_5
    jmp .Lcollect_braces_3
    jmp .Lcollect_braces_6
.Lcollect_braces_5:
.Lcollect_braces_6:
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcollect_braces_7
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    jmp .Lcollect_braces_8
.Lcollect_braces_7:
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcollect_braces_9
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcollect_braces_11
    jmp .Lcollect_braces_3
    jmp .Lcollect_braces_12
.Lcollect_braces_11:
.Lcollect_braces_12:
    jmp .Lcollect_braces_10
.Lcollect_braces_9:
.Lcollect_braces_10:
.Lcollect_braces_8:
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
.Lcollect_braces_4:
    jmp .Lcollect_braces_2
.Lcollect_braces_3:
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcollect_braces_13
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
    jmp .Lcollect_braces_14
.Lcollect_braces_13:
.Lcollect_braces_14:
    push dword ptr [ebp-96]
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-128]
    push eax
    pop eax
    mov [ebp-112], eax
    push 0
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
.Lcollect_braces_15:
    push dword ptr [ebp-120]
    push dword ptr [ebp-104]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcollect_braces_16
    push dword ptr [ebp-112]
    push dword ptr [ebp-120]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-120]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lcollect_braces_17:
    push dword ptr [ebp-120]
    push dword ptr [ebp-120]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-120], eax
    add esp, 4
    jmp .Lcollect_braces_15
.Lcollect_braces_16:
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push dword ptr [ebp-112]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push dword ptr [ebp-104]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl parse_selectors
parse_selectors:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 428
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_selectors_2
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_3
.Lparse_selectors_2:
    push 1
.Lparse_selectors_3:
    pop eax
    test eax, eax
    jz .Lparse_selectors_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_selectors_1
.Lparse_selectors_0:
.Lparse_selectors_1:
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lparse_selectors_4:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_5
.Lparse_selectors_6:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_8
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sc_isspace
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_selectors_10
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 44
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_11
.Lparse_selectors_10:
    push 1
.Lparse_selectors_11:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_9
.Lparse_selectors_8:
    push 0
.Lparse_selectors_9:
    pop eax
    test eax, eax
    jz .Lparse_selectors_7
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lparse_selectors_6
.Lparse_selectors_7:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_12
    jmp .Lparse_selectors_5
    jmp .Lparse_selectors_13
.Lparse_selectors_12:
.Lparse_selectors_13:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 59
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_14
.Lparse_selectors_16:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_18
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_19
.Lparse_selectors_18:
    push 0
.Lparse_selectors_19:
    pop eax
    test eax, eax
    jz .Lparse_selectors_17
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lparse_selectors_16
.Lparse_selectors_17:
    jmp .Lparse_selectors_4
    jmp .Lparse_selectors_15
.Lparse_selectors_14:
.Lparse_selectors_15:
    push dword ptr [ebp-64]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_26
    push dword ptr [ebp-64]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_selectors_28
    push dword ptr [ebp-64]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_29
.Lparse_selectors_28:
    push 1
.Lparse_selectors_29:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_27
.Lparse_selectors_26:
    push 0
.Lparse_selectors_27:
    pop eax
    test eax, eax
    jz .Lparse_selectors_24
    push dword ptr [ebp-64]
    push 2
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 78
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_selectors_30
    push dword ptr [ebp-64]
    push 2
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 110
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_31
.Lparse_selectors_30:
    push 1
.Lparse_selectors_31:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_25
.Lparse_selectors_24:
    push 0
.Lparse_selectors_25:
    pop eax
    test eax, eax
    jz .Lparse_selectors_22
    push dword ptr [ebp-64]
    push 3
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 89
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_selectors_32
    push dword ptr [ebp-64]
    push 3
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 121
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_33
.Lparse_selectors_32:
    push 1
.Lparse_selectors_33:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_23
.Lparse_selectors_22:
    push 0
.Lparse_selectors_23:
    pop eax
    test eax, eax
    jz .Lparse_selectors_20
    push dword ptr [ebp-56]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lparse_selectors_21
.Lparse_selectors_20:
    push dword ptr [ebp-64]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 42
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_34
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
.Lparse_selectors_36:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_38
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sc_isalnum
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_selectors_46
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 95
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_47
.Lparse_selectors_46:
    push 1
.Lparse_selectors_47:
    pop eax
    test eax, eax
    jnz .Lparse_selectors_44
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_45
.Lparse_selectors_44:
    push 1
.Lparse_selectors_45:
    pop eax
    test eax, eax
    jnz .Lparse_selectors_42
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 42
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_43
.Lparse_selectors_42:
    push 1
.Lparse_selectors_43:
    pop eax
    test eax, eax
    jnz .Lparse_selectors_40
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_41
.Lparse_selectors_40:
    push 1
.Lparse_selectors_41:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_39
.Lparse_selectors_38:
    push 0
.Lparse_selectors_39:
    pop eax
    test eax, eax
    jz .Lparse_selectors_37
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lparse_selectors_36
.Lparse_selectors_37:
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_48
    push dword ptr [ebp-64]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
.Lparse_selectors_50:
    push dword ptr [ebp-96]
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_51
    push dword ptr [ebp-88]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lparse_selectors_52:
    push dword ptr [ebp-96]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    add esp, 4
    jmp .Lparse_selectors_50
.Lparse_selectors_51:
    push dword ptr [ebp-88]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_49
.Lparse_selectors_48:
.Lparse_selectors_49:
    jmp .Lparse_selectors_35
.Lparse_selectors_34:
.Lparse_selectors_35:
.Lparse_selectors_21:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 40
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_53
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-80], eax
.Lparse_selectors_55:
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_57
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 41
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_58
.Lparse_selectors_57:
    push 0
.Lparse_selectors_58:
    pop eax
    test eax, eax
    jz .Lparse_selectors_56
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
    jmp .Lparse_selectors_55
.Lparse_selectors_56:
    push dword ptr [ebp-56]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_59
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-160], eax
.Lparse_selectors_61:
    push dword ptr [ebp-88]
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_63
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sc_isspace
    mov esp, [ebp-176]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_64
.Lparse_selectors_63:
    push 0
.Lparse_selectors_64:
    pop eax
    test eax, eax
    jz .Lparse_selectors_62
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lparse_selectors_61
.Lparse_selectors_62:
.Lparse_selectors_65:
    push dword ptr [ebp-88]
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_69
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sc_isalnum
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_selectors_75
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 95
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_76
.Lparse_selectors_75:
    push 1
.Lparse_selectors_76:
    pop eax
    test eax, eax
    jnz .Lparse_selectors_73
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 36
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_74
.Lparse_selectors_73:
    push 1
.Lparse_selectors_74:
    pop eax
    test eax, eax
    jnz .Lparse_selectors_71
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_72
.Lparse_selectors_71:
    push 1
.Lparse_selectors_72:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_70
.Lparse_selectors_69:
    push 0
.Lparse_selectors_70:
    pop eax
    test eax, eax
    jz .Lparse_selectors_67
    push dword ptr [ebp-160]
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_68
.Lparse_selectors_67:
    push 0
.Lparse_selectors_68:
    pop eax
    test eax, eax
    jz .Lparse_selectors_66
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-160]
    push dword ptr [ebp-160]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-160], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lparse_selectors_65
.Lparse_selectors_66:
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-160]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-160]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_79
    lea eax, [ebp-96]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 43
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_80
.Lparse_selectors_79:
    push 0
.Lparse_selectors_80:
    pop eax
    test eax, eax
    jz .Lparse_selectors_77
    push dword ptr [ebp-56]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-176]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_78
.Lparse_selectors_77:
.Lparse_selectors_78:
    jmp .Lparse_selectors_60
.Lparse_selectors_59:
.Lparse_selectors_60:
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-88], eax
.Lparse_selectors_81:
    push dword ptr [ebp-88]
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_82
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 43
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_83
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    push 0
    pop eax
    mov [ebp-112], eax
.Lparse_selectors_85:
    push dword ptr [ebp-88]
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_89
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sc_isalnum
    mov esp, [ebp-176]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_90
.Lparse_selectors_89:
    push 0
.Lparse_selectors_90:
    pop eax
    test eax, eax
    jz .Lparse_selectors_87
    push dword ptr [ebp-112]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_88
.Lparse_selectors_87:
    push 0
.Lparse_selectors_88:
    pop eax
    test eax, eax
    jz .Lparse_selectors_86
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-112]
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-112], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sc_toupper
    mov esp, [ebp-176]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lparse_selectors_85
.Lparse_selectors_86:
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ark_str_0]
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_91
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_92
.Lparse_selectors_91:
    lea eax, [ark_str_1]
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_93
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 2
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_94
.Lparse_selectors_93:
    lea eax, [ark_str_2]
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_95
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 4
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_96
.Lparse_selectors_95:
    lea eax, [ark_str_3]
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_97
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 8
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_98
.Lparse_selectors_97:
    lea eax, [ark_str_4]
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_99
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_100
.Lparse_selectors_99:
    lea eax, [ark_str_5]
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_101
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_102
.Lparse_selectors_101:
.Lparse_selectors_102:
.Lparse_selectors_100:
.Lparse_selectors_98:
.Lparse_selectors_96:
.Lparse_selectors_94:
.Lparse_selectors_92:
    jmp .Lparse_selectors_84
.Lparse_selectors_83:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
.Lparse_selectors_84:
    jmp .Lparse_selectors_81
.Lparse_selectors_82:
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 41
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_103
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    jmp .Lparse_selectors_104
.Lparse_selectors_103:
    push dword ptr [ebp-80]
.Lparse_selectors_104:
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lparse_selectors_4
    jmp .Lparse_selectors_54
.Lparse_selectors_53:
.Lparse_selectors_54:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 43
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_105
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
.Lparse_selectors_107:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_111
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sc_isalnum
    mov esp, [ebp-176]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_112
.Lparse_selectors_111:
    push 0
.Lparse_selectors_112:
    pop eax
    test eax, eax
    jz .Lparse_selectors_109
    push dword ptr [ebp-88]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_selectors_110
.Lparse_selectors_109:
    push 0
.Lparse_selectors_110:
    pop eax
    test eax, eax
    jz .Lparse_selectors_108
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sc_toupper
    mov esp, [ebp-176]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lparse_selectors_107
.Lparse_selectors_108:
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ark_str_6]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_113
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_114
.Lparse_selectors_113:
    lea eax, [ark_str_7]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_115
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 2
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_116
.Lparse_selectors_115:
    lea eax, [ark_str_8]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_117
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 4
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_118
.Lparse_selectors_117:
    lea eax, [ark_str_9]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_119
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 8
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_120
.Lparse_selectors_119:
    lea eax, [ark_str_10]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_121
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_122
.Lparse_selectors_121:
    lea eax, [ark_str_11]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ark_streq
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_selectors_123
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_selectors_124
.Lparse_selectors_123:
.Lparse_selectors_124:
.Lparse_selectors_122:
.Lparse_selectors_120:
.Lparse_selectors_118:
.Lparse_selectors_116:
.Lparse_selectors_114:
    jmp .Lparse_selectors_4
    jmp .Lparse_selectors_106
.Lparse_selectors_105:
.Lparse_selectors_106:
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lparse_selectors_4
.Lparse_selectors_5:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_parse_file
scatter_parse_file:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 540
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 1024
    push 1024
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lscatter_parse_file_2
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_3
.Lscatter_parse_file_2:
    push 1
.Lscatter_parse_file_3:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_0
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_parse_file_1
.Lscatter_parse_file_0:
.Lscatter_parse_file_1:
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-88]
    push dword ptr [ebp-64]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    pop eax
    mov [ebp-312], eax
    mov [ebp-288], esp
    push dword ptr [ebp-312]
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call fs_read_file
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_4
    push dword ptr [ebp-48]
    lea eax, [ark_str_12]
    push eax
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call ark_log
    mov esp, [ebp-288]
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call mem_pool_free
    mov esp, [ebp-288]
    push eax
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_parse_file_5
.Lscatter_parse_file_4:
.Lscatter_parse_file_5:
    push dword ptr [ebp-80]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_6
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    lea eax, [ark_str_13]
    push eax
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call ark_log
    mov esp, [ebp-288]
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call mem_pool_free
    mov esp, [ebp-288]
    push eax
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_parse_file_7
.Lscatter_parse_file_6:
.Lscatter_parse_file_7:
    push dword ptr [ebp-64]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lscatter_parse_file_8:
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_9
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call skip_ws
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_10
    jmp .Lscatter_parse_file_9
    jmp .Lscatter_parse_file_11
.Lscatter_parse_file_10:
.Lscatter_parse_file_11:
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call read_ident
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    lea eax, [ebp-96]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_12
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    jmp .Lscatter_parse_file_8
    jmp .Lscatter_parse_file_13
.Lscatter_parse_file_12:
.Lscatter_parse_file_13:
    push 3
    lea eax, [ark_str_14]
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    pop eax
    mov [ebp-312], eax
    mov [ebp-288], esp
    push dword ptr [ebp-312]
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call strncmp
    mov esp, [ebp-288]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_14
.Lscatter_parse_file_16:
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_18
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_19
.Lscatter_parse_file_18:
    push 0
.Lscatter_parse_file_19:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_17
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    jmp .Lscatter_parse_file_16
.Lscatter_parse_file_17:
    jmp .Lscatter_parse_file_8
    jmp .Lscatter_parse_file_15
.Lscatter_parse_file_14:
.Lscatter_parse_file_15:
    push 20
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-288]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-160]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-160]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-160]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-160]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call skip_ws
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lscatter_parse_file_22
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call sc_isdigit
    mov esp, [ebp-288]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_23
.Lscatter_parse_file_22:
    push 1
.Lscatter_parse_file_23:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_20
    push dword ptr [ebp-160]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call read_addr
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lscatter_parse_file_21
.Lscatter_parse_file_20:
.Lscatter_parse_file_21:
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call skip_ws
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lscatter_parse_file_26
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call sc_isdigit
    mov esp, [ebp-288]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_27
.Lscatter_parse_file_26:
    push 1
.Lscatter_parse_file_27:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_24
    push dword ptr [ebp-160]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call read_addr
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lscatter_parse_file_25
.Lscatter_parse_file_24:
.Lscatter_parse_file_25:
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call skip_ws
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lscatter_parse_file_28:
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_32
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_33
.Lscatter_parse_file_32:
    push 0
.Lscatter_parse_file_33:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_30
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_31
.Lscatter_parse_file_30:
    push 0
.Lscatter_parse_file_31:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_29
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    jmp .Lscatter_parse_file_28
.Lscatter_parse_file_29:
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_34
    lea eax, [ebp-176]
    push eax
    lea eax, [ebp-168]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    pop eax
    mov [ebp-312], eax
    mov [ebp-288], esp
    push dword ptr [ebp-312]
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call collect_braces
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-168]
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
.Lscatter_parse_file_36:
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_37
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call skip_ws
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_38
    jmp .Lscatter_parse_file_37
    jmp .Lscatter_parse_file_39
.Lscatter_parse_file_38:
.Lscatter_parse_file_39:
    lea eax, [ebp-192]
    push eax
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call read_ident
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    lea eax, [ebp-192]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_40
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    add esp, 4
    jmp .Lscatter_parse_file_36
    jmp .Lscatter_parse_file_41
.Lscatter_parse_file_40:
.Lscatter_parse_file_41:
    push 3
    lea eax, [ark_str_15]
    push eax
    lea eax, [ebp-192]
    push eax
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    pop eax
    mov [ebp-312], eax
    mov [ebp-288], esp
    push dword ptr [ebp-312]
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call strncmp
    mov esp, [ebp-288]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lscatter_parse_file_46
    push 3
    lea eax, [ark_str_16]
    push eax
    lea eax, [ebp-192]
    push eax
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    pop eax
    mov [ebp-312], eax
    mov [ebp-288], esp
    push dword ptr [ebp-312]
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call strncmp
    mov esp, [ebp-288]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_47
.Lscatter_parse_file_46:
    push 1
.Lscatter_parse_file_47:
    pop eax
    test eax, eax
    jnz .Lscatter_parse_file_44
    push 3
    lea eax, [ark_str_17]
    push eax
    lea eax, [ebp-192]
    push eax
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    pop eax
    mov [ebp-312], eax
    mov [ebp-288], esp
    push dword ptr [ebp-312]
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call strncmp
    mov esp, [ebp-288]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_45
.Lscatter_parse_file_44:
    push 1
.Lscatter_parse_file_45:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_42
    push 36
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-256], eax
    push dword ptr [ebp-256]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-192]
    push eax
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-288]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-256]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-256]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-256]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-256]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-256]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-256]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-256]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-256]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call skip_ws
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lscatter_parse_file_50
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call sc_isdigit
    mov esp, [ebp-288]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_51
.Lscatter_parse_file_50:
    push 1
.Lscatter_parse_file_51:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_48
    push dword ptr [ebp-256]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call read_addr
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .Lscatter_parse_file_49
.Lscatter_parse_file_48:
.Lscatter_parse_file_49:
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call skip_ws
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lscatter_parse_file_54
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call sc_isdigit
    mov esp, [ebp-288]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_55
.Lscatter_parse_file_54:
    push 1
.Lscatter_parse_file_55:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_52
    push dword ptr [ebp-256]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call read_addr
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .Lscatter_parse_file_53
.Lscatter_parse_file_52:
.Lscatter_parse_file_53:
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call skip_ws
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
.Lscatter_parse_file_56:
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_60
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_61
.Lscatter_parse_file_60:
    push 0
.Lscatter_parse_file_61:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_58
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_59
.Lscatter_parse_file_58:
    push 0
.Lscatter_parse_file_59:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_57
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    add esp, 4
    jmp .Lscatter_parse_file_56
.Lscatter_parse_file_57:
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_62
    lea eax, [ebp-272]
    push eax
    lea eax, [ebp-264]
    push eax
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    pop eax
    mov [ebp-312], eax
    mov [ebp-288], esp
    push dword ptr [ebp-312]
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call collect_braces
    mov esp, [ebp-288]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    push dword ptr [ebp-256]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-264]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-256]
    push dword ptr [ebp-264]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call parse_selectors
    mov esp, [ebp-288]
    jmp .Lscatter_parse_file_63
.Lscatter_parse_file_62:
.Lscatter_parse_file_63:
    push dword ptr [ebp-160]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-264], eax
.Lscatter_parse_file_64:
    push dword ptr [ebp-264]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_65
    push dword ptr [ebp-264]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-264], eax
    push dword ptr [ebp-264]
    add esp, 4
    jmp .Lscatter_parse_file_64
.Lscatter_parse_file_65:
    push dword ptr [ebp-264]
    push dword ptr [ebp-256]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lscatter_parse_file_43
.Lscatter_parse_file_42:
.Lscatter_parse_file_66:
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_68
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-304], eax
    mov [ebp-288], esp
    push dword ptr [ebp-304]
    and esp, -16
    call sc_isspace
    mov esp, [ebp-288]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_parse_file_69
.Lscatter_parse_file_68:
    push 0
.Lscatter_parse_file_69:
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_67
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    add esp, 4
    jmp .Lscatter_parse_file_66
.Lscatter_parse_file_67:
.Lscatter_parse_file_43:
    jmp .Lscatter_parse_file_36
.Lscatter_parse_file_37:
    jmp .Lscatter_parse_file_35
.Lscatter_parse_file_34:
.Lscatter_parse_file_35:
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
.Lscatter_parse_file_70:
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_parse_file_71
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lscatter_parse_file_70
.Lscatter_parse_file_71:
    push dword ptr [ebp-168]
    push dword ptr [ebp-160]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lscatter_parse_file_8
.Lscatter_parse_file_9:
    push dword ptr [ebp-48]
    lea eax, [ark_str_18]
    push eax
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call ark_log
    mov esp, [ebp-288]
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    mov [ebp-288], esp
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    and esp, -16
    call mem_pool_free
    mov esp, [ebp-288]
    push eax
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_free
scatter_free:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lscatter_free_0
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lscatter_free_1
.Lscatter_free_0:
.Lscatter_free_1:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_dump
scatter_dump:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_dump_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_dump_1
.Lscatter_dump_0:
.Lscatter_dump_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lscatter_dump_2:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lscatter_dump_3
    push dword ptr [ebp-56]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_19]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    pop eax
    mov [ebp-104], eax
    pop eax
    mov [ebp-108], eax
    mov [ebp-80], esp
    push dword ptr [ebp-108]
    push dword ptr [ebp-104]
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_log
    mov esp, [ebp-80]
    push eax
    push dword ptr [ebp-56]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lscatter_dump_5:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lscatter_dump_6
    push dword ptr [ebp-64]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_dump_8
    lea eax, [ark_str_20]
    push eax
    jmp .Lscatter_dump_9
.Lscatter_dump_8:
    lea eax, [ark_str_21]
    push eax
.Lscatter_dump_9:
    push dword ptr [ebp-64]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-64]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-64]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_22]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    pop eax
    mov [ebp-104], eax
    pop eax
    mov [ebp-108], eax
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-80], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    push dword ptr [ebp-108]
    push dword ptr [ebp-104]
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_log
    mov esp, [ebp-80]
    push eax
    push dword ptr [ebp-64]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_dump_10
    push dword ptr [ebp-64]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_23]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_log
    mov esp, [ebp-80]
    push eax
    jmp .Lscatter_dump_11
.Lscatter_dump_10:
.Lscatter_dump_11:
    push dword ptr [ebp-64]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_dump_12
    push dword ptr [ebp-64]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_24]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_log
    mov esp, [ebp-80]
    push eax
    jmp .Lscatter_dump_13
.Lscatter_dump_12:
.Lscatter_dump_13:
.Lscatter_dump_7:
    push dword ptr [ebp-64]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lscatter_dump_5
.Lscatter_dump_6:
.Lscatter_dump_4:
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lscatter_dump_2
.Lscatter_dump_3:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl skip_ld_ws
skip_ld_ws:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
.Lskip_ld_ws_0:
.Lskip_ld_ws_3:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_5
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call sc_isspace
    mov esp, [ebp-64]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_ld_ws_6
.Lskip_ld_ws_5:
    push 0
.Lskip_ld_ws_6:
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_4
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lskip_ld_ws_3
.Lskip_ld_ws_4:
    push dword ptr [ebp-48]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_9
    push dword ptr [ebp-48]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 42
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_ld_ws_10
.Lskip_ld_ws_9:
    push 0
.Lskip_ld_ws_10:
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_7
    push dword ptr [ebp-48]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
.Lskip_ld_ws_11:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_13
    push dword ptr [ebp-48]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 42
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_15
    push dword ptr [ebp-48]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_ld_ws_16
.Lskip_ld_ws_15:
    push 0
.Lskip_ld_ws_16:
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_ld_ws_14
.Lskip_ld_ws_13:
    push 0
.Lskip_ld_ws_14:
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_12
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lskip_ld_ws_11
.Lskip_ld_ws_12:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_17
    push dword ptr [ebp-48]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    jmp .Lskip_ld_ws_18
.Lskip_ld_ws_17:
.Lskip_ld_ws_18:
    jmp .Lskip_ld_ws_2
    jmp .Lskip_ld_ws_8
.Lskip_ld_ws_7:
.Lskip_ld_ws_8:
    push dword ptr [ebp-48]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_21
    push dword ptr [ebp-48]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_ld_ws_22
.Lskip_ld_ws_21:
    push 0
.Lskip_ld_ws_22:
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_19
.Lskip_ld_ws_23:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_25
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_ld_ws_26
.Lskip_ld_ws_25:
    push 0
.Lskip_ld_ws_26:
    pop eax
    test eax, eax
    jz .Lskip_ld_ws_24
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lskip_ld_ws_23
.Lskip_ld_ws_24:
    jmp .Lskip_ld_ws_2
    jmp .Lskip_ld_ws_20
.Lskip_ld_ws_19:
.Lskip_ld_ws_20:
    jmp .Lskip_ld_ws_1
.Lskip_ld_ws_2:
    jmp .Lskip_ld_ws_0
.Lskip_ld_ws_1:
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl read_section_name
read_section_name:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_section_name_0
    push dword ptr [ebp-64]
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_section_name_2
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lread_section_name_3
.Lread_section_name_2:
.Lread_section_name_3:
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lread_section_name_1
.Lread_section_name_0:
.Lread_section_name_1:
.Lread_section_name_4:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lread_section_name_6
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call sc_isalnum
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jnz .Lread_section_name_10
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 95
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_section_name_11
.Lread_section_name_10:
    push 1
.Lread_section_name_11:
    pop eax
    test eax, eax
    jnz .Lread_section_name_8
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_section_name_9
.Lread_section_name_8:
    push 1
.Lread_section_name_9:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_section_name_7
.Lread_section_name_6:
    push 0
.Lread_section_name_7:
    pop eax
    test eax, eax
    jz .Lread_section_name_5
    push dword ptr [ebp-64]
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_section_name_12
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lread_section_name_13
.Lread_section_name_12:
.Lread_section_name_13:
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lread_section_name_4
.Lread_section_name_5:
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl find_load_region
find_load_region:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lfind_load_region_2
    push dword ptr [ebp-56]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lfind_load_region_3
.Lfind_load_region_2:
    push 1
.Lfind_load_region_3:
    pop eax
    test eax, eax
    jz .Lfind_load_region_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lfind_load_region_1
.Lfind_load_region_0:
.Lfind_load_region_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lfind_load_region_4:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lfind_load_region_5
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lfind_load_region_7
    push dword ptr [ebp-64]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lfind_load_region_8
.Lfind_load_region_7:
.Lfind_load_region_8:
.Lfind_load_region_6:
    push dword ptr [ebp-64]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lfind_load_region_4
.Lfind_load_region_5:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl first_or_default_load_region
first_or_default_load_region:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lfirst_or_default_load_region_0
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lfirst_or_default_load_region_1
.Lfirst_or_default_load_region_0:
.Lfirst_or_default_load_region_1:
    push 20
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-64]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ark_str_25]
    push eax
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-64]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl make_er_name
make_er_name:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 412
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push 0
    pop eax
    mov [ebp-144], eax
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-144]
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 69
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-144]
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 82
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-144]
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 95
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lmake_er_name_0:
    push dword ptr [ebp-48]
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lmake_er_name_2
    push dword ptr [ebp-144]
    push 76
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmake_er_name_3
.Lmake_er_name_2:
    push 0
.Lmake_er_name_3:
    pop eax
    test eax, eax
    jz .Lmake_er_name_1
    push dword ptr [ebp-48]
    push dword ptr [ebp-136]
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmake_er_name_4
    jmp .Lmake_er_name_0
    jmp .Lmake_er_name_5
.Lmake_er_name_4:
.Lmake_er_name_5:
    push dword ptr [ebp-152]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call sc_isalnum
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lmake_er_name_8
    push dword ptr [ebp-152]
    push 95
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmake_er_name_9
.Lmake_er_name_8:
    push 1
.Lmake_er_name_9:
    pop eax
    test eax, eax
    jz .Lmake_er_name_6
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-144]
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-152]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call sc_toupper
    mov esp, [ebp-160]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lmake_er_name_7
.Lmake_er_name_6:
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-144]
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 95
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lmake_er_name_7:
    jmp .Lmake_er_name_0
.Lmake_er_name_1:
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ebp-56]
    push eax
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-160]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl parse_ld_memory
parse_ld_memory:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 476
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-192], eax
    push 0
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_0
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_ld_memory_1
.Lparse_ld_memory_0:
.Lparse_ld_memory_1:
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
.Lparse_ld_memory_2:
    push dword ptr [ebp-216]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_3
    push dword ptr [ebp-216]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
    jmp .Lparse_ld_memory_2
.Lparse_ld_memory_3:
.Lparse_ld_memory_4:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_7
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_memory_5
    jmp .Lparse_ld_memory_8
.Lparse_ld_memory_7:
.Lparse_ld_memory_8:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_9
    jmp .Lparse_ld_memory_5
    jmp .Lparse_ld_memory_10
.Lparse_ld_memory_9:
.Lparse_ld_memory_10:
    lea eax, [ebp-64]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ebp-128]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push 0
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    add esp, 4
    push 0
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
    lea eax, [ebp-64]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    pop eax
    mov [ebp-244], eax
    mov [ebp-224], esp
    push dword ptr [ebp-244]
    push dword ptr [ebp-240]
    and esp, -16
    call read_ident
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    lea eax, [ebp-64]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_11
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_memory_6
    jmp .Lparse_ld_memory_12
.Lparse_ld_memory_11:
.Lparse_ld_memory_12:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 40
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_13
.Lparse_ld_memory_15:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_17
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 41
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_ld_memory_18
.Lparse_ld_memory_17:
    push 0
.Lparse_ld_memory_18:
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_16
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_memory_15
.Lparse_ld_memory_16:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 41
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_19
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_memory_20
.Lparse_ld_memory_19:
.Lparse_ld_memory_20:
    jmp .Lparse_ld_memory_14
.Lparse_ld_memory_13:
.Lparse_ld_memory_14:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 58
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_21
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_memory_22
.Lparse_ld_memory_21:
.Lparse_ld_memory_22:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    lea eax, [ebp-128]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    pop eax
    mov [ebp-244], eax
    mov [ebp-224], esp
    push dword ptr [ebp-244]
    push dword ptr [ebp-240]
    and esp, -16
    call read_ident
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 61
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_23
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_memory_24
.Lparse_ld_memory_23:
.Lparse_ld_memory_24:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    lea eax, [ebp-192]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    pop eax
    mov [ebp-244], eax
    mov [ebp-224], esp
    push dword ptr [ebp-244]
    push dword ptr [ebp-240]
    and esp, -16
    call read_addr
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 44
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_25
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_memory_26
.Lparse_ld_memory_25:
.Lparse_ld_memory_26:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    lea eax, [ebp-128]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    pop eax
    mov [ebp-244], eax
    mov [ebp-224], esp
    push dword ptr [ebp-244]
    push dword ptr [ebp-240]
    and esp, -16
    call read_ident
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 61
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_memory_27
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_memory_28
.Lparse_ld_memory_27:
.Lparse_ld_memory_28:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    lea eax, [ebp-200]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-240], eax
    pop eax
    mov [ebp-244], eax
    mov [ebp-224], esp
    push dword ptr [ebp-244]
    push dword ptr [ebp-240]
    and esp, -16
    call read_addr
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push 20
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-224]
    push eax
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    add esp, 4
    push dword ptr [ebp-208]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-64]
    push eax
    pop eax
    mov [ebp-240], eax
    mov [ebp-224], esp
    push dword ptr [ebp-240]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-224]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-208]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-192]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-208]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-200]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-208]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-208]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-216]
    push dword ptr [ebp-208]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-208]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
.Lparse_ld_memory_6:
    jmp .Lparse_ld_memory_4
.Lparse_ld_memory_5:
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl parse_ld_sections
parse_ld_sections:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 588
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-272], eax
    push 0
    pop eax
    mov [ebp-280], eax
    push 0
    pop eax
    mov [ebp-288], eax
    push 0
    pop eax
    mov [ebp-296], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_0
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_ld_sections_1
.Lparse_ld_sections_0:
.Lparse_ld_sections_1:
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
.Lparse_ld_sections_2:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_5
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_sections_3
    jmp .Lparse_ld_sections_6
.Lparse_ld_sections_5:
.Lparse_ld_sections_6:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_7
    jmp .Lparse_ld_sections_3
    jmp .Lparse_ld_sections_8
.Lparse_ld_sections_7:
.Lparse_ld_sections_8:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_9
.Lparse_ld_sections_11:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_15
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call sc_isspace
    mov esp, [ebp-336]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_ld_sections_16
.Lparse_ld_sections_15:
    push 0
.Lparse_ld_sections_16:
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_13
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_ld_sections_14
.Lparse_ld_sections_13:
    push 0
.Lparse_ld_sections_14:
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_12
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_sections_11
.Lparse_ld_sections_12:
    jmp .Lparse_ld_sections_4
    jmp .Lparse_ld_sections_10
.Lparse_ld_sections_9:
.Lparse_ld_sections_10:
    lea eax, [ebp-64]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ebp-128]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push 0
    pop eax
    mov [ebp-272], eax
    push dword ptr [ebp-272]
    add esp, 4
    push 0
    pop eax
    mov [ebp-280], eax
    push dword ptr [ebp-280]
    add esp, 4
    push 0
    pop eax
    mov [ebp-288], eax
    push dword ptr [ebp-288]
    add esp, 4
    push 0
    pop eax
    mov [ebp-296], eax
    push dword ptr [ebp-296]
    add esp, 4
    lea eax, [ebp-64]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    pop eax
    mov [ebp-356], eax
    mov [ebp-336], esp
    push dword ptr [ebp-356]
    push dword ptr [ebp-352]
    and esp, -16
    call read_section_name
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    lea eax, [ebp-64]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_17
    jmp .Lparse_ld_sections_4
    jmp .Lparse_ld_sections_18
.Lparse_ld_sections_17:
.Lparse_ld_sections_18:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_ld_sections_21
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call sc_isdigit
    mov esp, [ebp-336]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_ld_sections_22
.Lparse_ld_sections_21:
    push 1
.Lparse_ld_sections_22:
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_19
    lea eax, [ebp-272]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    pop eax
    mov [ebp-356], eax
    mov [ebp-336], esp
    push dword ptr [ebp-356]
    push dword ptr [ebp-352]
    and esp, -16
    call read_addr
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push 1
    pop eax
    mov [ebp-280], eax
    push dword ptr [ebp-280]
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    jmp .Lparse_ld_sections_20
.Lparse_ld_sections_19:
.Lparse_ld_sections_20:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 58
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_23
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_ld_sections_24
.Lparse_ld_sections_23:
.Lparse_ld_sections_24:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_25
    lea eax, [ebp-296]
    push eax
    lea eax, [ebp-288]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    pop eax
    mov [ebp-356], eax
    pop eax
    mov [ebp-360], eax
    mov [ebp-336], esp
    push dword ptr [ebp-360]
    push dword ptr [ebp-356]
    push dword ptr [ebp-352]
    and esp, -16
    call collect_braces
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    jmp .Lparse_ld_sections_26
.Lparse_ld_sections_25:
.Lparse_ld_sections_26:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 62
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_27
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    lea eax, [ebp-128]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    pop eax
    mov [ebp-356], eax
    mov [ebp-336], esp
    push dword ptr [ebp-356]
    push dword ptr [ebp-352]
    and esp, -16
    call read_ident
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-328], eax
    push dword ptr [ebp-328]
    add esp, 4
    lea eax, [ebp-192]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ebp-192]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    pop eax
    mov [ebp-356], eax
    mov [ebp-336], esp
    push dword ptr [ebp-356]
    push dword ptr [ebp-352]
    and esp, -16
    call read_ident
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    lea eax, [ark_str_26]
    push eax
    lea eax, [ebp-192]
    push eax
    pop eax
    mov [ebp-352], eax
    pop eax
    mov [ebp-356], eax
    mov [ebp-336], esp
    push dword ptr [ebp-356]
    push dword ptr [ebp-352]
    and esp, -16
    call ark_streq
    mov esp, [ebp-336]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_29
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 62
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_31
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    lea eax, [ebp-208]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ebp-208]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    pop eax
    mov [ebp-356], eax
    mov [ebp-336], esp
    push dword ptr [ebp-356]
    push dword ptr [ebp-352]
    and esp, -16
    call read_ident
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
    jmp .Lparse_ld_sections_32
.Lparse_ld_sections_31:
.Lparse_ld_sections_32:
    jmp .Lparse_ld_sections_30
.Lparse_ld_sections_29:
    push dword ptr [ebp-328]
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
.Lparse_ld_sections_30:
    jmp .Lparse_ld_sections_28
.Lparse_ld_sections_27:
.Lparse_ld_sections_28:
    lea eax, [ebp-128]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-352], eax
    pop eax
    mov [ebp-356], eax
    mov [ebp-336], esp
    push dword ptr [ebp-356]
    push dword ptr [ebp-352]
    and esp, -16
    call find_load_region
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-304], eax
    push dword ptr [ebp-304]
    add esp, 4
    push dword ptr [ebp-304]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_33
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call first_or_default_load_region
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-304], eax
    push dword ptr [ebp-304]
    add esp, 4
    jmp .Lparse_ld_sections_34
.Lparse_ld_sections_33:
.Lparse_ld_sections_34:
    push 36
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-336]
    push eax
    pop eax
    mov [ebp-312], eax
    push dword ptr [ebp-312]
    add esp, 4
    push dword ptr [ebp-312]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-64]
    push eax
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call make_er_name
    mov esp, [ebp-336]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-312]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-280]
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_35
    push dword ptr [ebp-272]
    jmp .Lparse_ld_sections_36
.Lparse_ld_sections_35:
    push 0
.Lparse_ld_sections_36:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-312]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-312]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-288]
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_37
    push dword ptr [ebp-288]
    jmp .Lparse_ld_sections_38
.Lparse_ld_sections_37:
    lea eax, [ark_str_27]
    push eax
    pop eax
    mov [ebp-352], eax
    mov [ebp-336], esp
    push dword ptr [ebp-352]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-336]
    push eax
.Lparse_ld_sections_38:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-312]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-312]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-312]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-312]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-312]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-312]
    push dword ptr [ebp-312]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-352], eax
    pop eax
    mov [ebp-356], eax
    mov [ebp-336], esp
    push dword ptr [ebp-356]
    push dword ptr [ebp-352]
    and esp, -16
    call parse_selectors
    mov esp, [ebp-336]
    push dword ptr [ebp-304]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-320], eax
    push dword ptr [ebp-320]
    add esp, 4
.Lparse_ld_sections_39:
    push dword ptr [ebp-320]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_ld_sections_40
    push dword ptr [ebp-320]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-320], eax
    push dword ptr [ebp-320]
    add esp, 4
    jmp .Lparse_ld_sections_39
.Lparse_ld_sections_40:
    push dword ptr [ebp-320]
    push dword ptr [ebp-312]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lparse_ld_sections_4:
    jmp .Lparse_ld_sections_2
.Lparse_ld_sections_3:
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl linker_script_parse_file
linker_script_parse_file:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 412
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 1024
    push 1024
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llinker_script_parse_file_2
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llinker_script_parse_file_3
.Llinker_script_parse_file_2:
    push 1
.Llinker_script_parse_file_3:
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_0
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llinker_script_parse_file_1
.Llinker_script_parse_file_0:
.Llinker_script_parse_file_1:
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-88]
    push dword ptr [ebp-64]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    pop eax
    mov [ebp-184], eax
    mov [ebp-160], esp
    push dword ptr [ebp-184]
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call fs_read_file
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_4
    push dword ptr [ebp-48]
    lea eax, [ark_str_28]
    push eax
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_log
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call mem_pool_free
    mov esp, [ebp-160]
    push eax
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llinker_script_parse_file_5
.Llinker_script_parse_file_4:
.Llinker_script_parse_file_5:
    push dword ptr [ebp-80]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_6
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    lea eax, [ark_str_29]
    push eax
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_log
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call mem_pool_free
    mov esp, [ebp-160]
    push eax
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llinker_script_parse_file_7
.Llinker_script_parse_file_6:
.Llinker_script_parse_file_7:
    push dword ptr [ebp-64]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Llinker_script_parse_file_8:
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_9
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call skip_ld_ws
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_10
    jmp .Llinker_script_parse_file_9
    jmp .Llinker_script_parse_file_11
.Llinker_script_parse_file_10:
.Llinker_script_parse_file_11:
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call read_ident
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    lea eax, [ebp-96]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_12
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    jmp .Llinker_script_parse_file_8
    jmp .Llinker_script_parse_file_13
.Llinker_script_parse_file_12:
.Llinker_script_parse_file_13:
    lea eax, [ark_str_30]
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_14
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call parse_ld_memory
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Llinker_script_parse_file_15
.Llinker_script_parse_file_14:
    lea eax, [ark_str_31]
    push eax
    lea eax, [ebp-96]
    push eax
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_16
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call parse_ld_sections
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Llinker_script_parse_file_17
.Llinker_script_parse_file_16:
.Llinker_script_parse_file_18:
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_20
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llinker_script_parse_file_21
.Llinker_script_parse_file_20:
    push 0
.Llinker_script_parse_file_21:
    pop eax
    test eax, eax
    jz .Llinker_script_parse_file_19
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    jmp .Llinker_script_parse_file_18
.Llinker_script_parse_file_19:
.Llinker_script_parse_file_17:
.Llinker_script_parse_file_15:
    jmp .Llinker_script_parse_file_8
.Llinker_script_parse_file_9:
    push dword ptr [ebp-48]
    lea eax, [ark_str_32]
    push eax
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_log
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call mem_pool_free
    mov esp, [ebp-160]
    push eax
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_lookup_addr
scatter_lookup_addr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lscatter_lookup_addr_2
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_lookup_addr_3
.Lscatter_lookup_addr_2:
    push 1
.Lscatter_lookup_addr_3:
    pop eax
    test eax, eax
    jz .Lscatter_lookup_addr_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_lookup_addr_1
.Lscatter_lookup_addr_0:
.Lscatter_lookup_addr_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lscatter_lookup_addr_4:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lscatter_lookup_addr_5
    push dword ptr [ebp-64]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lscatter_lookup_addr_7:
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Lscatter_lookup_addr_8
    push dword ptr [ebp-72]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_lookup_addr_12
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call strstr
    mov esp, [ebp-80]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_lookup_addr_13
.Lscatter_lookup_addr_12:
    push 0
.Lscatter_lookup_addr_13:
    pop eax
    test eax, eax
    jz .Lscatter_lookup_addr_10
    push dword ptr [ebp-72]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_lookup_addr_11
.Lscatter_lookup_addr_10:
.Lscatter_lookup_addr_11:
.Lscatter_lookup_addr_9:
    push dword ptr [ebp-72]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lscatter_lookup_addr_7
.Lscatter_lookup_addr_8:
.Lscatter_lookup_addr_6:
    push dword ptr [ebp-64]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lscatter_lookup_addr_4
.Lscatter_lookup_addr_5:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_get_er_base_for_section
scatter_get_er_base_for_section:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lscatter_get_er_base_for_section_2
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_get_er_base_for_section_3
.Lscatter_get_er_base_for_section_2:
    push 1
.Lscatter_get_er_base_for_section_3:
    pop eax
    test eax, eax
    jz .Lscatter_get_er_base_for_section_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_get_er_base_for_section_1
.Lscatter_get_er_base_for_section_0:
.Lscatter_get_er_base_for_section_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lscatter_get_er_base_for_section_4:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lscatter_get_er_base_for_section_5
    push dword ptr [ebp-64]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lscatter_get_er_base_for_section_7:
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Lscatter_get_er_base_for_section_8
    push dword ptr [ebp-72]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_get_er_base_for_section_12
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_get_er_base_for_section_13
.Lscatter_get_er_base_for_section_12:
    push 0
.Lscatter_get_er_base_for_section_13:
    pop eax
    test eax, eax
    jz .Lscatter_get_er_base_for_section_10
    push dword ptr [ebp-72]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_get_er_base_for_section_11
.Lscatter_get_er_base_for_section_10:
.Lscatter_get_er_base_for_section_11:
.Lscatter_get_er_base_for_section_9:
    push dword ptr [ebp-72]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lscatter_get_er_base_for_section_7
.Lscatter_get_er_base_for_section_8:
.Lscatter_get_er_base_for_section_6:
    push dword ptr [ebp-64]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lscatter_get_er_base_for_section_4
.Lscatter_get_er_base_for_section_5:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lscatter_get_er_base_for_section_14:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lscatter_get_er_base_for_section_15
    push dword ptr [ebp-64]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lscatter_get_er_base_for_section_17:
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Lscatter_get_er_base_for_section_18
    push dword ptr [ebp-72]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_get_er_base_for_section_22
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call strstr
    mov esp, [ebp-80]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_get_er_base_for_section_23
.Lscatter_get_er_base_for_section_22:
    push 0
.Lscatter_get_er_base_for_section_23:
    pop eax
    test eax, eax
    jz .Lscatter_get_er_base_for_section_20
    push dword ptr [ebp-72]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_get_er_base_for_section_21
.Lscatter_get_er_base_for_section_20:
.Lscatter_get_er_base_for_section_21:
.Lscatter_get_er_base_for_section_19:
    push dword ptr [ebp-72]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lscatter_get_er_base_for_section_17
.Lscatter_get_er_base_for_section_18:
.Lscatter_get_er_base_for_section_16:
    push dword ptr [ebp-64]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lscatter_get_er_base_for_section_14
.Lscatter_get_er_base_for_section_15:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_find_er_by_attr
scatter_find_er_by_attr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_find_er_by_attr_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_find_er_by_attr_1
.Lscatter_find_er_by_attr_0:
.Lscatter_find_er_by_attr_1:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lscatter_find_er_by_attr_2:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lscatter_find_er_by_attr_3
    push dword ptr [ebp-64]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lscatter_find_er_by_attr_5:
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Lscatter_find_er_by_attr_6
    push dword ptr [ebp-72]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_find_er_by_attr_8
    push dword ptr [ebp-72]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_find_er_by_attr_9
.Lscatter_find_er_by_attr_8:
.Lscatter_find_er_by_attr_9:
.Lscatter_find_er_by_attr_7:
    push dword ptr [ebp-72]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lscatter_find_er_by_attr_5
.Lscatter_find_er_by_attr_6:
.Lscatter_find_er_by_attr_4:
    push dword ptr [ebp-64]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lscatter_find_er_by_attr_2
.Lscatter_find_er_by_attr_3:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_get_flash_base
scatter_get_flash_base:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lscatter_get_flash_base_2
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_get_flash_base_3
.Lscatter_get_flash_base_2:
    push 0
.Lscatter_get_flash_base_3:
    pop eax
    test eax, eax
    jz .Lscatter_get_flash_base_0
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_get_flash_base_1
.Lscatter_get_flash_base_0:
.Lscatter_get_flash_base_1:
    push 134217728
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_get_data_base
scatter_get_data_base:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call scatter_find_er_by_attr
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lscatter_get_data_base_0
    push dword ptr [ebp-64]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_get_data_base_1
.Lscatter_get_data_base_0:
.Lscatter_get_data_base_1:
    push 536870912
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_er_fits
scatter_er_fits:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_er_fits_0
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_er_fits_1
.Lscatter_er_fits_0:
.Lscatter_er_fits_1:
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_er_fits_2
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_er_fits_3
.Lscatter_er_fits_2:
.Lscatter_er_fits_3:
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl put_fmt
put_fmt:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 8364
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    mov eax, [ebp+20]
    mov [ebp-72], eax
    mov eax, [ebp+8]
    mov [ebp-8048], eax
    mov eax, [ebp+12]
    mov [ebp-8056], eax
    mov eax, [ebp+16]
    mov [ebp-8064], eax
    mov eax, [ebp+20]
    mov [ebp-8072], eax
    mov eax, [ebp+24]
    mov [ebp-8080], eax
    mov eax, [ebp+28]
    mov [ebp-8088], eax
    mov eax, [ebp+32]
    mov [ebp-8096], eax
    mov eax, [ebp+36]
    mov [ebp-8104], eax
    push 0
    pop eax
    mov [ebp-88], eax
    lea eax, [ebp+24]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
.Lput_fmt_0:
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_1
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 37
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_4
    push dword ptr [ebp-96]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_5
.Lput_fmt_4:
    push 0
.Lput_fmt_5:
    pop eax
    test eax, eax
    jz .Lput_fmt_2
    push dword ptr [ebp-96]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-96]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    push dword ptr [ebp-104]
    push 115
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_6
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_8
    lea eax, [ark_str_33]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lput_fmt_9
.Lput_fmt_8:
.Lput_fmt_9:
.Lput_fmt_10:
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_11
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lput_fmt_14
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_15
.Lput_fmt_14:
    push 0
.Lput_fmt_15:
    pop eax
    test eax, eax
    jz .Lput_fmt_12
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_13
.Lput_fmt_12:
.Lput_fmt_13:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    push dword ptr [ebp-112]
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-112], eax
    add esp, 4
    jmp .Lput_fmt_10
.Lput_fmt_11:
    jmp .Lput_fmt_7
.Lput_fmt_6:
    push dword ptr [ebp-104]
    push 88
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_16
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-112], eax
    push 0
    pop eax
    mov [ebp-128], eax
    lea eax, [ark_str_34]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_18
    lea eax, [ebp-120]
    push eax
    push dword ptr [ebp-128]
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 48
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_19
.Lput_fmt_18:
.Lput_fmt_19:
.Lput_fmt_20:
    push dword ptr [ebp-112]
    pop eax
    test eax, eax
    jz .Lput_fmt_22
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_23
.Lput_fmt_22:
    push 0
.Lput_fmt_23:
    pop eax
    test eax, eax
    jz .Lput_fmt_21
    lea eax, [ebp-120]
    push eax
    push dword ptr [ebp-128]
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    push dword ptr [ebp-112]
    push 15
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lput_fmt_20
.Lput_fmt_21:
.Lput_fmt_24:
    push dword ptr [ebp-128]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_25
    push dword ptr [ebp-128]
    push dword ptr [ebp-128]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lput_fmt_28
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_29
.Lput_fmt_28:
    push 0
.Lput_fmt_29:
    pop eax
    test eax, eax
    jz .Lput_fmt_26
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-120]
    push eax
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_27
.Lput_fmt_26:
.Lput_fmt_27:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lput_fmt_24
.Lput_fmt_25:
    jmp .Lput_fmt_17
.Lput_fmt_16:
    push dword ptr [ebp-104]
    push 100
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_30
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-112], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push 0
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_32
    push 1
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push dword ptr [ebp-112]
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    jmp .Lput_fmt_33
.Lput_fmt_32:
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
.Lput_fmt_33:
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_34
    lea eax, [ebp-120]
    push eax
    push dword ptr [ebp-136]
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 48
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_35
.Lput_fmt_34:
.Lput_fmt_35:
.Lput_fmt_36:
    push dword ptr [ebp-152]
    pop eax
    test eax, eax
    jz .Lput_fmt_38
    push dword ptr [ebp-136]
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_39
.Lput_fmt_38:
    push 0
.Lput_fmt_39:
    pop eax
    test eax, eax
    jz .Lput_fmt_37
    lea eax, [ebp-120]
    push eax
    push dword ptr [ebp-136]
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 48
    push dword ptr [ebp-152]
    push 10
    pop ecx
    pop eax
    xor edx, edx
    div ecx
    push edx
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-152]
    push 10
    pop ecx
    pop eax
    xor edx, edx
    div ecx
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    jmp .Lput_fmt_36
.Lput_fmt_37:
    push dword ptr [ebp-144]
    pop eax
    test eax, eax
    jz .Lput_fmt_40
    lea eax, [ebp-120]
    push eax
    push dword ptr [ebp-136]
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 45
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_41
.Lput_fmt_40:
.Lput_fmt_41:
.Lput_fmt_42:
    push dword ptr [ebp-136]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_43
    push dword ptr [ebp-136]
    push dword ptr [ebp-136]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lput_fmt_46
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_47
.Lput_fmt_46:
    push 0
.Lput_fmt_47:
    pop eax
    test eax, eax
    jz .Lput_fmt_44
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-120]
    push eax
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_45
.Lput_fmt_44:
.Lput_fmt_45:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lput_fmt_42
.Lput_fmt_43:
    jmp .Lput_fmt_31
.Lput_fmt_30:
    push dword ptr [ebp-104]
    push 99
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_48
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lput_fmt_52
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_53
.Lput_fmt_52:
    push 0
.Lput_fmt_53:
    pop eax
    test eax, eax
    jz .Lput_fmt_50
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_51
.Lput_fmt_50:
.Lput_fmt_51:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lput_fmt_49
.Lput_fmt_48:
    push dword ptr [ebp-104]
    push 37
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lput_fmt_54
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lput_fmt_58
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_59
.Lput_fmt_58:
    push 0
.Lput_fmt_59:
    pop eax
    test eax, eax
    jz .Lput_fmt_56
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 37
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_57
.Lput_fmt_56:
.Lput_fmt_57:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lput_fmt_55
.Lput_fmt_54:
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lput_fmt_62
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_63
.Lput_fmt_62:
    push 0
.Lput_fmt_63:
    pop eax
    test eax, eax
    jz .Lput_fmt_60
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 37
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_61
.Lput_fmt_60:
.Lput_fmt_61:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lput_fmt_66
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_67
.Lput_fmt_66:
    push 0
.Lput_fmt_67:
    pop eax
    test eax, eax
    jz .Lput_fmt_64
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-104]
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_65
.Lput_fmt_64:
.Lput_fmt_65:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
.Lput_fmt_55:
.Lput_fmt_49:
.Lput_fmt_31:
.Lput_fmt_17:
.Lput_fmt_7:
    jmp .Lput_fmt_3
.Lput_fmt_2:
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lput_fmt_70
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_71
.Lput_fmt_70:
    push 0
.Lput_fmt_71:
    pop eax
    test eax, eax
    jz .Lput_fmt_68
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_69
.Lput_fmt_68:
.Lput_fmt_69:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    push dword ptr [ebp-96]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    add esp, 4
.Lput_fmt_3:
    jmp .Lput_fmt_0
.Lput_fmt_1:
    push 0
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lput_fmt_74
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lput_fmt_75
.Lput_fmt_74:
    push 0
.Lput_fmt_75:
    pop eax
    test eax, eax
    jz .Lput_fmt_72
    push dword ptr [ebp-48]
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lput_fmt_73
.Lput_fmt_72:
.Lput_fmt_73:
    push dword ptr [ebp-64]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl derive_section_name
derive_section_name:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Lderive_section_name_0
    lea eax, [ark_str_35]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call strstr
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lderive_section_name_2
    lea eax, [ark_str_36]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lderive_section_name_3
.Lderive_section_name_2:
.Lderive_section_name_3:
    lea eax, [ark_str_37]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call strstr
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lderive_section_name_4
    lea eax, [ark_str_38]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lderive_section_name_5
.Lderive_section_name_4:
.Lderive_section_name_5:
    lea eax, [ark_str_39]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call strstr
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lderive_section_name_6
    lea eax, [ark_str_40]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lderive_section_name_7
.Lderive_section_name_6:
.Lderive_section_name_7:
    lea eax, [ark_str_41]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call strstr
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lderive_section_name_8
    lea eax, [ark_str_42]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lderive_section_name_9
.Lderive_section_name_8:
.Lderive_section_name_9:
    lea eax, [ark_str_43]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call strstr
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lderive_section_name_10
    lea eax, [ark_str_44]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lderive_section_name_11
.Lderive_section_name_10:
.Lderive_section_name_11:
    lea eax, [ark_str_45]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call strstr
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lderive_section_name_12
    lea eax, [ark_str_46]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lderive_section_name_13
.Lderive_section_name_12:
.Lderive_section_name_13:
    lea eax, [ark_str_47]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call strstr
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jnz .Lderive_section_name_16
    lea eax, [ark_str_48]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call strstr
    mov esp, [ebp-64]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lderive_section_name_17
.Lderive_section_name_16:
    push 1
.Lderive_section_name_17:
    pop eax
    test eax, eax
    jz .Lderive_section_name_14
    lea eax, [ark_str_49]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lderive_section_name_15
.Lderive_section_name_14:
.Lderive_section_name_15:
    jmp .Lderive_section_name_1
.Lderive_section_name_0:
.Lderive_section_name_1:
    lea eax, [ark_str_50]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_to_ld_script
scatter_to_ld_script:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 364
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_to_ld_script_1
.Lscatter_to_ld_script_0:
.Lscatter_to_ld_script_1:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_4
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_to_ld_script_5
.Lscatter_to_ld_script_4:
    push 0
.Lscatter_to_ld_script_5:
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_2
    push dword ptr [ebp-56]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lscatter_to_ld_script_3
.Lscatter_to_ld_script_2:
.Lscatter_to_ld_script_3:
    lea eax, [ark_str_51]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    mov [ebp-112], esp
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call put_fmt
    mov esp, [ebp-112]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lscatter_to_ld_script_6:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_7
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-80]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_52]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    pop eax
    mov [ebp-144], eax
    pop eax
    mov [ebp-148], eax
    pop eax
    mov [ebp-152], eax
    mov [ebp-112], esp
    push dword ptr [ebp-152]
    push dword ptr [ebp-148]
    push dword ptr [ebp-144]
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call put_fmt
    mov esp, [ebp-112]
    push eax
    add esp, 4
.Lscatter_to_ld_script_8:
    push dword ptr [ebp-80]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lscatter_to_ld_script_6
.Lscatter_to_ld_script_7:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lscatter_to_ld_script_9:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_10
    push dword ptr [ebp-80]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lscatter_to_ld_script_12:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_13
    push 0
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
.Lscatter_to_ld_script_15:
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_16
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call ark_streq
    mov esp, [ebp-112]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_18
    push 1
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lscatter_to_ld_script_16
    jmp .Lscatter_to_ld_script_19
.Lscatter_to_ld_script_18:
.Lscatter_to_ld_script_19:
.Lscatter_to_ld_script_17:
    push dword ptr [ebp-104]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lscatter_to_ld_script_15
.Lscatter_to_ld_script_16:
    push dword ptr [ebp-96]
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_20
    jmp .Lscatter_to_ld_script_14
    jmp .Lscatter_to_ld_script_21
.Lscatter_to_ld_script_20:
.Lscatter_to_ld_script_21:
    push dword ptr [ebp-88]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_53]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    pop eax
    mov [ebp-144], eax
    pop eax
    mov [ebp-148], eax
    pop eax
    mov [ebp-152], eax
    mov [ebp-112], esp
    push dword ptr [ebp-152]
    push dword ptr [ebp-148]
    push dword ptr [ebp-144]
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call put_fmt
    mov esp, [ebp-112]
    push eax
    add esp, 4
.Lscatter_to_ld_script_14:
    push dword ptr [ebp-88]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lscatter_to_ld_script_12
.Lscatter_to_ld_script_13:
.Lscatter_to_ld_script_11:
    push dword ptr [ebp-80]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lscatter_to_ld_script_9
.Lscatter_to_ld_script_10:
    lea eax, [ark_str_54]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    mov [ebp-112], esp
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call put_fmt
    mov esp, [ebp-112]
    push eax
    add esp, 4
    lea eax, [ark_str_55]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    mov [ebp-112], esp
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call put_fmt
    mov esp, [ebp-112]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lscatter_to_ld_script_22:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_23
    push dword ptr [ebp-80]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lscatter_to_ld_script_25:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_26
    push dword ptr [ebp-88]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call derive_section_name
    mov esp, [ebp-112]
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_28
    push dword ptr [ebp-88]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    jmp .Lscatter_to_ld_script_29
.Lscatter_to_ld_script_28:
    lea eax, [ark_str_56]
    push eax
.Lscatter_to_ld_script_29:
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-96]
    lea eax, [ark_str_57]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    pop eax
    mov [ebp-144], eax
    pop eax
    mov [ebp-148], eax
    pop eax
    mov [ebp-152], eax
    pop eax
    mov [ebp-156], eax
    mov [ebp-112], esp
    push dword ptr [ebp-156]
    push dword ptr [ebp-152]
    push dword ptr [ebp-148]
    push dword ptr [ebp-144]
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call put_fmt
    mov esp, [ebp-112]
    push eax
    add esp, 4
    lea eax, [ark_str_58]
    push eax
    push dword ptr [ebp-96]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call ark_streq
    mov esp, [ebp-112]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_to_ld_script_30
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_59]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    pop eax
    mov [ebp-144], eax
    mov [ebp-112], esp
    push dword ptr [ebp-144]
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call put_fmt
    mov esp, [ebp-112]
    push eax
    add esp, 4
    jmp .Lscatter_to_ld_script_31
.Lscatter_to_ld_script_30:
.Lscatter_to_ld_script_31:
    lea eax, [ark_str_60]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    mov [ebp-112], esp
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call put_fmt
    mov esp, [ebp-112]
    push eax
    add esp, 4
.Lscatter_to_ld_script_27:
    push dword ptr [ebp-88]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lscatter_to_ld_script_25
.Lscatter_to_ld_script_26:
.Lscatter_to_ld_script_24:
    push dword ptr [ebp-80]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lscatter_to_ld_script_22
.Lscatter_to_ld_script_23:
    lea eax, [ark_str_61]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    mov [ebp-112], esp
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call put_fmt
    mov esp, [ebp-112]
    push eax
    add esp, 4
    push dword ptr [ebp-72]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl scatter_to_sct_file
scatter_to_sct_file:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_to_sct_file_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lscatter_to_sct_file_1
.Lscatter_to_sct_file_0:
.Lscatter_to_sct_file_1:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lscatter_to_sct_file_4
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_to_sct_file_5
.Lscatter_to_sct_file_4:
    push 0
.Lscatter_to_sct_file_5:
    pop eax
    test eax, eax
    jz .Lscatter_to_sct_file_2
    push dword ptr [ebp-56]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lscatter_to_sct_file_3
.Lscatter_to_sct_file_2:
.Lscatter_to_sct_file_3:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lscatter_to_sct_file_6:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Lscatter_to_sct_file_7
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-80]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_62]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    mov [ebp-96], esp
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call put_fmt
    mov esp, [ebp-96]
    push eax
    add esp, 4
    push dword ptr [ebp-80]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lscatter_to_sct_file_9:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lscatter_to_sct_file_10
    push dword ptr [ebp-88]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_63]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    mov [ebp-96], esp
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call put_fmt
    mov esp, [ebp-96]
    push eax
    add esp, 4
    push dword ptr [ebp-88]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lscatter_to_sct_file_14
    push dword ptr [ebp-88]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lscatter_to_sct_file_15
.Lscatter_to_sct_file_14:
    push 0
.Lscatter_to_sct_file_15:
    pop eax
    test eax, eax
    jz .Lscatter_to_sct_file_12
    push dword ptr [ebp-88]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ark_str_64]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    pop eax
    mov [ebp-128], eax
    mov [ebp-96], esp
    push dword ptr [ebp-128]
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call put_fmt
    mov esp, [ebp-96]
    push eax
    add esp, 4
    jmp .Lscatter_to_sct_file_13
.Lscatter_to_sct_file_12:
.Lscatter_to_sct_file_13:
    lea eax, [ark_str_65]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call put_fmt
    mov esp, [ebp-96]
    push eax
    add esp, 4
.Lscatter_to_sct_file_11:
    push dword ptr [ebp-88]
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lscatter_to_sct_file_9
.Lscatter_to_sct_file_10:
    lea eax, [ark_str_66]
    push eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call put_fmt
    mov esp, [ebp-96]
    push eax
    add esp, 4
.Lscatter_to_sct_file_8:
    push dword ptr [ebp-80]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lscatter_to_sct_file_6
.Lscatter_to_sct_file_7:
    push dword ptr [ebp-72]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

