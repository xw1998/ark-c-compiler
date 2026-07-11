# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz "Cortex-"
ark_str_1:
    .asciz "__TARGET_ARCH_6_M"
ark_str_2:
    .asciz "__TARGET_ARCH_7_M"
ark_str_3:
    .asciz "__TARGET_ARCH_7E_M"
ark_str_4:
    .asciz "__TARGET_ARCH_8_M"
ark_str_5:
    .asciz "__TARGET_ARCH_8_M_BASE"
ark_str_6:
    .asciz "__TARGET_ARCH_8_M_MAIN"
ark_str_7:
    .asciz "__TARGET_FEATURE_DSP"
ark_str_8:
    .asciz "__TARGET_FPU_VFP"
ark_str_9:
    .asciz "__TARGET_FPU_FPV5"
ark_str_10:
    .asciz "__TARGET_FPU_DP"
ark_str_11:
    .asciz "1"
ark_str_12:
    .asciz "__TARGET_ARCH_6_M"
ark_str_13:
    .asciz "1"
ark_str_14:
    .asciz "__TARGET_ARCH_7E_M"
ark_str_15:
    .asciz "1"
ark_str_16:
    .asciz "__TARGET_ARCH_7_M"
ark_str_17:
    .asciz "1"
ark_str_18:
    .asciz "__TARGET_ARCH_8_M_MAIN"
ark_str_19:
    .asciz "1"
ark_str_20:
    .asciz "__TARGET_ARCH_8_M_BASE"
ark_str_21:
    .asciz "1"
ark_str_22:
    .asciz "__TARGET_ARCH_8_M"
ark_str_23:
    .asciz "1"
ark_str_24:
    .asciz "__TARGET_FEATURE_DSP"
ark_str_25:
    .asciz "1"
ark_str_26:
    .asciz "__TARGET_FPU_VFP"
ark_str_27:
    .asciz "1"
ark_str_28:
    .asciz "__TARGET_FPU_FPV5"
ark_str_29:
    .asciz "1"
ark_str_30:
    .asciz "__TARGET_FPU_DP"
ark_str_31:
    .asciz "__TARGET_CPU_NAME"
ark_str_32:
    .asciz "__TARGET_ARCH_M"
    .data
    .globl g_cpu_table
    .local g_cpu_table
g_cpu_table:
    .quad 27723460419
    .quad 0
    .quad 0
    .quad 1
    .quad 27723460419
    .quad 0
    .quad 0
    .quad 1
    .quad 27723460419
    .quad 0
    .quad 0
    .quad 1
    .quad 32018427715
    .quad 0
    .quad 0
    .quad 1
    .quad 32018427715
    .quad 4294967297
    .quad 1
    .quad 8525391429793480705
    .quad 32018427715
    .quad 4294967297
    .quad 4294967297
    .quad 8525391429793480705
    .quad 36313395011
    .quad 0
    .quad 0
    .quad 1
    .quad 36313395011
    .quad 4294967297
    .quad 1
    .quad 8525391429793480705
    .text
    .globl cpu_strcaseeq
cpu_strcaseeq:
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
.Lcpu_strcaseeq_0:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_strcaseeq_2
    push dword ptr [ebp-56]
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
    jmp .Lcpu_strcaseeq_3
.Lcpu_strcaseeq_2:
    push 0
.Lcpu_strcaseeq_3:
    pop eax
    test eax, eax
    jz .Lcpu_strcaseeq_1
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-64]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_strcaseeq_6
    push dword ptr [ebp-64]
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
    jmp .Lcpu_strcaseeq_7
.Lcpu_strcaseeq_6:
    push 0
.Lcpu_strcaseeq_7:
    pop eax
    test eax, eax
    jz .Lcpu_strcaseeq_4
    push dword ptr [ebp-64]
    push 65
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 97
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lcpu_strcaseeq_5
.Lcpu_strcaseeq_4:
.Lcpu_strcaseeq_5:
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
    jz .Lcpu_strcaseeq_10
    push dword ptr [ebp-72]
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
    jmp .Lcpu_strcaseeq_11
.Lcpu_strcaseeq_10:
    push 0
.Lcpu_strcaseeq_11:
    pop eax
    test eax, eax
    jz .Lcpu_strcaseeq_8
    push dword ptr [ebp-72]
    push 65
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 97
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lcpu_strcaseeq_9
.Lcpu_strcaseeq_8:
.Lcpu_strcaseeq_9:
    push dword ptr [ebp-64]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_strcaseeq_12
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lcpu_strcaseeq_13
.Lcpu_strcaseeq_12:
.Lcpu_strcaseeq_13:
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
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    jmp .Lcpu_strcaseeq_0
.Lcpu_strcaseeq_1:
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
    jz .Lcpu_strcaseeq_14
    push dword ptr [ebp-56]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lcpu_strcaseeq_15
.Lcpu_strcaseeq_14:
    push 0
.Lcpu_strcaseeq_15:
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

    .globl cpu_name_matches
cpu_name_matches:
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
    lea eax, [ark_str_0]
    push eax
    pop eax
    mov [ebp-64], eax
    push 7
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call cpu_strcaseeq
    mov esp, [ebp-112]
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_name_matches_0
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lcpu_name_matches_1
.Lcpu_name_matches_0:
.Lcpu_name_matches_1:
    push 0
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lcpu_name_matches_2:
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_name_matches_3
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
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-56]
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
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-88]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_name_matches_7
    push dword ptr [ebp-88]
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
    jmp .Lcpu_name_matches_8
.Lcpu_name_matches_7:
    push 0
.Lcpu_name_matches_8:
    pop eax
    test eax, eax
    jz .Lcpu_name_matches_5
    push dword ptr [ebp-88]
    push 65
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 97
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lcpu_name_matches_6
.Lcpu_name_matches_5:
.Lcpu_name_matches_6:
    push dword ptr [ebp-96]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_name_matches_11
    push dword ptr [ebp-96]
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
    jmp .Lcpu_name_matches_12
.Lcpu_name_matches_11:
    push 0
.Lcpu_name_matches_12:
    pop eax
    test eax, eax
    jz .Lcpu_name_matches_9
    push dword ptr [ebp-96]
    push 65
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 97
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lcpu_name_matches_10
.Lcpu_name_matches_9:
.Lcpu_name_matches_10:
    push dword ptr [ebp-88]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_name_matches_13
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lcpu_name_matches_14
.Lcpu_name_matches_13:
.Lcpu_name_matches_14:
.Lcpu_name_matches_4:
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
    jmp .Lcpu_name_matches_2
.Lcpu_name_matches_3:
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call cpu_strcaseeq
    mov esp, [ebp-112]
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_name_matches_15
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lcpu_name_matches_16
.Lcpu_name_matches_15:
.Lcpu_name_matches_16:
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

    .globl cpu_lookup
cpu_lookup:
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
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lcpu_lookup_2
    push dword ptr [ebp-48]
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
    jmp .Lcpu_lookup_3
.Lcpu_lookup_2:
    push 1
.Lcpu_lookup_3:
    pop eax
    test eax, eax
    jz .Lcpu_lookup_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lcpu_lookup_1
.Lcpu_lookup_0:
.Lcpu_lookup_1:
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lcpu_lookup_4:
    push dword ptr [ebp-56]
    push 256
    push 32
    pop ecx
    pop eax
    cdq
    idiv ecx
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_lookup_5
    lea eax, [g_cpu_table]
    push eax
    push dword ptr [ebp-56]
    push 32
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
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call cpu_name_matches
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_lookup_7
    lea eax, [g_cpu_table]
    push eax
    push dword ptr [ebp-56]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lcpu_lookup_8
.Lcpu_lookup_7:
.Lcpu_lookup_8:
.Lcpu_lookup_6:
    push dword ptr [ebp-56]
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    jmp .Lcpu_lookup_4
.Lcpu_lookup_5:
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

    .globl int_to_str
int_to_str:
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
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lint_to_str_0
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
    push 45
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lint_to_str_1
.Lint_to_str_0:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
.Lint_to_str_1:
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lint_to_str_2
    lea eax, [ebp-72]
    push eax
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
    push 48
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lint_to_str_3
.Lint_to_str_2:
.Lint_to_str_3:
.Lint_to_str_4:
    push dword ptr [ebp-96]
    pop eax
    test eax, eax
    jz .Lint_to_str_5
    lea eax, [ebp-72]
    push eax
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
    push 48
    push dword ptr [ebp-96]
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
    push dword ptr [ebp-96]
    push 10
    pop ecx
    pop eax
    xor edx, edx
    div ecx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lint_to_str_4
.Lint_to_str_5:
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lint_to_str_6:
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lint_to_str_7
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    sub eax, ecx
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
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lint_to_str_8:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lint_to_str_6
.Lint_to_str_7:
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

    .globl cpu_apply_predefines
cpu_apply_predefines:
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
    jz .Lcpu_apply_predefines_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lcpu_apply_predefines_1
.Lcpu_apply_predefines_0:
.Lcpu_apply_predefines_1:
    lea eax, [ark_str_1]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
    push eax
    lea eax, [ark_str_2]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
    push eax
    lea eax, [ark_str_3]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
    push eax
    lea eax, [ark_str_4]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
    push eax
    lea eax, [ark_str_5]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
    push eax
    lea eax, [ark_str_6]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
    push eax
    lea eax, [ark_str_7]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
    push eax
    lea eax, [ark_str_8]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
    push eax
    lea eax, [ark_str_9]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
    push eax
    lea eax, [ark_str_10]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_undef
    mov esp, [ebp-80]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lcpu_apply_predefines_3
    push dword ptr [ebp-72]
    push 7
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lcpu_apply_predefines_4
    push dword ptr [ebp-72]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lcpu_apply_predefines_5
    jmp .Lcpu_apply_predefines_6
.Lcpu_apply_predefines_3:
    lea eax, [ark_str_11]
    push eax
    lea eax, [ark_str_12]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
    jmp .Lcpu_apply_predefines_2
.Lcpu_apply_predefines_4:
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
    pop eax
    test eax, eax
    jz .Lcpu_apply_predefines_7
    lea eax, [ark_str_13]
    push eax
    lea eax, [ark_str_14]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
    jmp .Lcpu_apply_predefines_8
.Lcpu_apply_predefines_7:
    lea eax, [ark_str_15]
    push eax
    lea eax, [ark_str_16]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
.Lcpu_apply_predefines_8:
    jmp .Lcpu_apply_predefines_2
.Lcpu_apply_predefines_5:
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
    pop eax
    test eax, eax
    jz .Lcpu_apply_predefines_9
    lea eax, [ark_str_17]
    push eax
    lea eax, [ark_str_18]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
    jmp .Lcpu_apply_predefines_10
.Lcpu_apply_predefines_9:
    lea eax, [ark_str_19]
    push eax
    lea eax, [ark_str_20]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
.Lcpu_apply_predefines_10:
    lea eax, [ark_str_21]
    push eax
    lea eax, [ark_str_22]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
    jmp .Lcpu_apply_predefines_2
.Lcpu_apply_predefines_6:
    jmp .Lcpu_apply_predefines_2
.Lcpu_apply_predefines_2:
    push dword ptr [ebp-48]
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
    jz .Lcpu_apply_predefines_11
    lea eax, [ark_str_23]
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
    call preproc_define
    mov esp, [ebp-80]
    push eax
    jmp .Lcpu_apply_predefines_12
.Lcpu_apply_predefines_11:
.Lcpu_apply_predefines_12:
    push dword ptr [ebp-48]
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
    test eax, eax
    jz .Lcpu_apply_predefines_13
    lea eax, [ark_str_25]
    push eax
    lea eax, [ark_str_26]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
    push dword ptr [ebp-48]
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
    jz .Lcpu_apply_predefines_15
    push dword ptr [ebp-48]
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
    push 86
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcpu_apply_predefines_25
    push dword ptr [ebp-48]
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
    push 70
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
    jmp .Lcpu_apply_predefines_26
.Lcpu_apply_predefines_25:
    push 0
.Lcpu_apply_predefines_26:
    pop eax
    test eax, eax
    jz .Lcpu_apply_predefines_23
    push dword ptr [ebp-48]
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
    push 80
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
    jmp .Lcpu_apply_predefines_24
.Lcpu_apply_predefines_23:
    push 0
.Lcpu_apply_predefines_24:
    pop eax
    test eax, eax
    jz .Lcpu_apply_predefines_21
    push dword ptr [ebp-48]
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
    push 118
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
    jmp .Lcpu_apply_predefines_22
.Lcpu_apply_predefines_21:
    push 0
.Lcpu_apply_predefines_22:
    pop eax
    test eax, eax
    jz .Lcpu_apply_predefines_19
    push dword ptr [ebp-48]
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
    push 4
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
    push 53
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
    jmp .Lcpu_apply_predefines_20
.Lcpu_apply_predefines_19:
    push 0
.Lcpu_apply_predefines_20:
    pop eax
    test eax, eax
    jz .Lcpu_apply_predefines_17
    lea eax, [ark_str_27]
    push eax
    lea eax, [ark_str_28]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
    jmp .Lcpu_apply_predefines_18
.Lcpu_apply_predefines_17:
.Lcpu_apply_predefines_18:
    jmp .Lcpu_apply_predefines_16
.Lcpu_apply_predefines_15:
.Lcpu_apply_predefines_16:
    push dword ptr [ebp-48]
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
    jz .Lcpu_apply_predefines_27
    lea eax, [ark_str_29]
    push eax
    lea eax, [ark_str_30]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
    jmp .Lcpu_apply_predefines_28
.Lcpu_apply_predefines_27:
.Lcpu_apply_predefines_28:
    jmp .Lcpu_apply_predefines_14
.Lcpu_apply_predefines_13:
.Lcpu_apply_predefines_14:
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
    lea eax, [ark_str_31]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call int_to_str
    mov esp, [ebp-80]
    lea eax, [ebp-56]
    push eax
    lea eax, [ark_str_32]
    push eax
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call preproc_define
    mov esp, [ebp-80]
    push eax
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

