# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
    .data
    .text
    .globl asmbuf_init
asmbuf_init:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4096
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
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
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-64]
    push eax
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

    .globl asmbuf_grow
asmbuf_grow:
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
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
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
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lasmbuf_grow_0
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
    mov [ebp-64], eax
.Lasmbuf_grow_2:
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
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lasmbuf_grow_3
    push dword ptr [ebp-64]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lasmbuf_grow_2
.Lasmbuf_grow_3:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
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
    jmp .Lasmbuf_grow_1
.Lasmbuf_grow_0:
.Lasmbuf_grow_1:
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

    .globl asmbuf_putc
asmbuf_putc:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 1
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call asmbuf_grow
    mov esp, [ebp-64]
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
    push dword ptr [ebp-48]
    push 4
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
    pop eax
    pop ecx
    push eax
    push ecx
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
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 1
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
    mov byte ptr [eax], dl
    push edx
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

    .globl asmbuf_puts
asmbuf_puts:
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
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call ark_strlen
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call asmbuf_grow
    mov esp, [ebp-80]
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lasmbuf_puts_0:
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lasmbuf_puts_1
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
    push dword ptr [ebp-48]
    push 4
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
    pop eax
    pop ecx
    push eax
    push ecx
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
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
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
.Lasmbuf_puts_2:
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
    jmp .Lasmbuf_puts_0
.Lasmbuf_puts_1:
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

    .globl asmbuf_int
asmbuf_int:
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
    push 0
    pop eax
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-56]
    push 0
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
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lasmbuf_int_0
    push 1
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-56]
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    add esp, 4
    jmp .Lasmbuf_int_1
.Lasmbuf_int_0:
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    add esp, 4
.Lasmbuf_int_1:
    push dword ptr [ebp-112]
    push 0
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
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lasmbuf_int_2
    lea eax, [ebp-64]
    push eax
    push dword ptr [ebp-96]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
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
    jmp .Lasmbuf_int_3
.Lasmbuf_int_2:
.Lasmbuf_int_3:
.Lasmbuf_int_4:
    push dword ptr [ebp-112]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lasmbuf_int_5
    lea eax, [ebp-64]
    push eax
    push dword ptr [ebp-96]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
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
    push dword ptr [ebp-112]
    push 10
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
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    xor edx, edx
    div ecx
    push 0
    push edx
    add esp, 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-112]
    push 10
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
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    xor edx, edx
    div ecx
    push 0
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    add esp, 4
    jmp .Lasmbuf_int_4
.Lasmbuf_int_5:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lasmbuf_int_6
    push 45
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-144], eax
    pop eax
    mov [ebp-148], eax
    mov [ebp-128], esp
    push dword ptr [ebp-148]
    push dword ptr [ebp-144]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-128]
    jmp .Lasmbuf_int_7
.Lasmbuf_int_6:
.Lasmbuf_int_7:
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
.Lasmbuf_int_8:
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lasmbuf_int_9
    lea eax, [ebp-64]
    push eax
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
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-144], eax
    pop eax
    mov [ebp-148], eax
    mov [ebp-128], esp
    push dword ptr [ebp-148]
    push dword ptr [ebp-144]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-128]
.Lasmbuf_int_10:
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    add esp, 4
    jmp .Lasmbuf_int_8
.Lasmbuf_int_9:
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

    .globl asmbuf_printf_int
asmbuf_printf_int:
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
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lasmbuf_printf_int_0
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
    call asmbuf_puts
    mov esp, [ebp-80]
    jmp .Lasmbuf_printf_int_1
.Lasmbuf_printf_int_0:
.Lasmbuf_printf_int_1:
    push dword ptr [ebp-64]
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
    # unknown IR op: CDECL64
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-80]
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Lasmbuf_printf_int_2
    push dword ptr [ebp-72]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-80]
    jmp .Lasmbuf_printf_int_3
.Lasmbuf_printf_int_2:
.Lasmbuf_printf_int_3:
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

