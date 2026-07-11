# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz "Available targets:\n"
ark_str_1:
    .asciz "  %-10s %s\n"
    .data
    .globl g_backends
    .local g_backends
g_backends:
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .globl g_count
    .local g_count
g_count:
    .long 0
    .globl g_inited
    .local g_inited
g_inited:
    .long 0
    .text
    .globl registry_init
registry_init:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [g_inited]
    push eax
    pop eax
    test eax, eax
    jz .Lregistry_init_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lregistry_init_1
.Lregistry_init_0:
.Lregistry_init_1:
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_inited], eax
    add esp, 4
    lea eax, [g_backends]
    push eax
    mov eax, [g_count]
    push eax
    mov eax, [g_count]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [g_count], eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-64], esp
    and esp, -16
    call ark_backend_arm
    mov esp, [ebp-64]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [g_backends]
    push eax
    mov eax, [g_count]
    push eax
    mov eax, [g_count]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [g_count], eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-64], esp
    and esp, -16
    call ark_backend_x86_64
    mov esp, [ebp-64]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [g_backends]
    push eax
    mov eax, [g_count]
    push eax
    mov eax, [g_count]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [g_count], eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-64], esp
    and esp, -16
    call ark_backend_x86_64_msvc
    mov esp, [ebp-64]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [g_backends]
    push eax
    mov eax, [g_count]
    push eax
    mov eax, [g_count]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [g_count], eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-64], esp
    and esp, -16
    call ark_backend_riscv32
    mov esp, [ebp-64]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [g_backends]
    push eax
    mov eax, [g_count]
    push eax
    mov eax, [g_count]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [g_count], eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-64], esp
    and esp, -16
    call ark_backend_c
    mov esp, [ebp-64]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
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

    .globl ark_backend_find
ark_backend_find:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov [ebp-64], esp
    and esp, -16
    call registry_init
    mov esp, [ebp-64]
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lark_backend_find_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lark_backend_find_1
.Lark_backend_find_0:
.Lark_backend_find_1:
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lark_backend_find_2:
    push dword ptr [ebp-56]
    mov eax, [g_count]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lark_backend_find_3
    push dword ptr [ebp-48]
    lea eax, [g_backends]
    push eax
    push dword ptr [ebp-56]
    push 4
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
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
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
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call ark_streq
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lark_backend_find_5
    lea eax, [g_backends]
    push eax
    push dword ptr [ebp-56]
    push 4
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
    jmp .Lark_backend_find_6
.Lark_backend_find_5:
.Lark_backend_find_6:
.Lark_backend_find_4:
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
    jmp .Lark_backend_find_2
.Lark_backend_find_3:
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

    .globl ark_backend_default
ark_backend_default:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov [ebp-64], esp
    and esp, -16
    call registry_init
    mov esp, [ebp-64]
    lea eax, [g_backends]
    push eax
    push 0
    push 4
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

    .globl ark_backend_list
ark_backend_list:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov [ebp-64], esp
    and esp, -16
    call registry_init
    mov esp, [ebp-64]
    lea eax, [ark_str_0]
    push eax
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call ark_log
    mov esp, [ebp-64]
    push eax
    push 0
    pop eax
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    add esp, 4
.Lark_backend_list_0:
    push dword ptr [ebp-48]
    mov eax, [g_count]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lark_backend_list_1
    lea eax, [g_backends]
    push eax
    push dword ptr [ebp-48]
    push 4
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
    lea eax, [g_backends]
    push eax
    push dword ptr [ebp-48]
    push 4
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
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
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
    lea eax, [ark_str_1]
    push eax
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    pop eax
    mov [ebp-88], eax
    mov [ebp-64], esp
    push dword ptr [ebp-88]
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call ark_log
    mov esp, [ebp-64]
    push eax
.Lark_backend_list_2:
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
    jmp .Lark_backend_list_0
.Lark_backend_list_1:
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

