# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz ""
    .data
    .text
    .globl ast_new
ast_new:
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
    push 144
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
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
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push 8
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
    push dword ptr [ebp-64]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, 0
    push eax
    mov eax, 0
    push eax
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-64]
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

    .globl ast_num
ast_num:
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
    push 16
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ast_new
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-80], esp
    and esp, -16
    call type_int
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-64]
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

    .globl ast_str
ast_str:
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
    push 21
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ast_new
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-80], esp
    and esp, -16
    call type_char
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call type_pointer
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Last_str_0
    push dword ptr [ebp-48]
    jmp .Last_str_1
.Last_str_0:
    lea eax, [ark_str_0]
    push eax
.Last_str_1:
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
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

    .globl ast_var
ast_var:
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
    push 17
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ast_new
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
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

    .globl ast_binary
ast_binary:
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
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 12
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
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

    .globl ast_unary
ast_unary:
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
    push dword ptr [ebp-64]
    push 13
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ast_new
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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

    .globl ast_assign
ast_assign:
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
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 15
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
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

    .globl ast_if
ast_if:
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
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 6
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
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

    .globl ast_while
ast_while:
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
    push dword ptr [ebp-64]
    push 7
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ast_new
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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

    .globl ast_for
ast_for:
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
    mov eax, [ebp+20]
    mov [ebp-72], eax
    mov eax, [ebp+24]
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 8
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
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

    .globl ast_block
ast_block:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 4
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call ast_new
    mov esp, [ebp-64]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 24
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
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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

    .globl block_add_stmt
block_add_stmt:
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
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-48]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lblock_add_stmt_0
    push dword ptr [ebp-48]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    jz .Lblock_add_stmt_2
    push dword ptr [ebp-48]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    jmp .Lblock_add_stmt_3
.Lblock_add_stmt_2:
    push 8
.Lblock_add_stmt_3:
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 24
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
    pop eax
    mov [ebp-104], eax
    mov [ebp-80], esp
    push dword ptr [ebp-104]
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lblock_add_stmt_1
.Lblock_add_stmt_0:
.Lblock_add_stmt_1:
    push dword ptr [ebp-48]
    push 24
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
    imul eax, ecx
    push eax
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
    push dword ptr [ebp-48]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
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

    .globl ast_func_def
ast_func_def:
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
    mov eax, [ebp+20]
    mov [ebp-72], eax
    mov eax, [ebp+24]
    mov [ebp-80], eax
    mov eax, [ebp+28]
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    push 1
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call ast_new
    mov esp, [ebp-112]
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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
    push dword ptr [ebp-96]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-96]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-96]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-96]
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

    .globl ast_var_decl
ast_var_decl:
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
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 3
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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

    .globl ast_func_call
ast_func_call:
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
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 19
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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

    .globl ast_array_access
ast_array_access:
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
    push dword ptr [ebp-64]
    push 18
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ast_new
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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

    .globl ast_member
ast_member:
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
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 23
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-96]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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

    .globl ast_cast
ast_cast:
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
    push dword ptr [ebp-64]
    push 22
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ast_new
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 24
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
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-72]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
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

    .globl ast_sizeof_val
ast_sizeof_val:
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
    push 24
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ast_new
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-64]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-80], esp
    and esp, -16
    call type_int
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
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

