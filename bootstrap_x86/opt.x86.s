# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
    .data
    .text
    .globl compact_func
compact_func:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lcompact_func_0:
    push dword ptr [ebp-56]
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
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcompact_func_1
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcompact_func_3
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcompact_func_5
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
    push dword ptr [ebp-64]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edi
    pop esi
    mov ecx, 32
    rep movsb
    add esp, 4
    jmp .Lcompact_func_6
.Lcompact_func_5:
.Lcompact_func_6:
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
    jmp .Lcompact_func_4
.Lcompact_func_3:
.Lcompact_func_4:
.Lcompact_func_2:
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
    jmp .Lcompact_func_0
.Lcompact_func_1:
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

    .globl eval_binary
eval_binary:
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
    push dword ptr [ebp-64]
    push 256
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-64]
    push 256
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_1
    push dword ptr [ebp-104]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_2
    push dword ptr [ebp-104]
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_3
    push dword ptr [ebp-104]
    push 18
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_4
    push dword ptr [ebp-104]
    push 19
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_5
    push dword ptr [ebp-104]
    push 30
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_6
    push dword ptr [ebp-104]
    push 31
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_7
    push dword ptr [ebp-104]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_8
    push dword ptr [ebp-104]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_9
    push dword ptr [ebp-104]
    push 35
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_10
    push dword ptr [ebp-104]
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_11
    push dword ptr [ebp-104]
    push 22
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_12
    push dword ptr [ebp-104]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_13
    push dword ptr [ebp-104]
    push 24
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_14
    push dword ptr [ebp-104]
    push 25
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_15
    push dword ptr [ebp-104]
    push 26
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_16
    push dword ptr [ebp-104]
    push 27
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_17
    push dword ptr [ebp-104]
    push 28
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_18
    jmp .Leval_binary_19
.Leval_binary_1:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_2:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    pop ebx
    pop eax
    pop edx
    sub eax, ecx
    sub edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_3:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    imul eax, ecx
    push 0
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_4:
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
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_20
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Leval_binary_21
.Leval_binary_20:
.Leval_binary_21:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Leval_binary_22
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    xor edx, edx
    div ecx
    push 0
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_23
.Leval_binary_22:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cdq
    idiv ecx
    push edx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
.Leval_binary_23:
    jmp .Leval_binary_0
.Leval_binary_5:
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
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_24
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Leval_binary_25
.Leval_binary_24:
.Leval_binary_25:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Leval_binary_26
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    xor edx, edx
    div ecx
    push 0
    push edx
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_27
.Leval_binary_26:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cdq
    idiv ecx
    push 0
    push edx
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
.Leval_binary_27:
    jmp .Leval_binary_0
.Leval_binary_6:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    pop ebx
    pop eax
    pop edx
    and eax, ecx
    and edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_7:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    pop ebx
    pop eax
    pop edx
    or eax, ecx
    or edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_8:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    pop ebx
    pop eax
    pop edx
    xor eax, ecx
    xor edx, ebx
    push edx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_9:
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
    jnz .Leval_binary_30
    push dword ptr [ebp-56]
    push 64
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
    setge al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Leval_binary_31
.Leval_binary_30:
    push 1
.Leval_binary_31:
    pop eax
    test eax, eax
    jz .Leval_binary_28
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Leval_binary_29
.Leval_binary_28:
.Leval_binary_29:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_34
    push dword ptr [ebp-48]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Leval_binary_35
.Leval_binary_34:
    push 0
.Leval_binary_35:
    pop eax
    test eax, eax
    jz .Leval_binary_32
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Leval_binary_33
.Leval_binary_32:
.Leval_binary_33:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    shl eax, cl
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_10:
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
    jnz .Leval_binary_38
    push dword ptr [ebp-56]
    push 64
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
    setge al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Leval_binary_39
.Leval_binary_38:
    push 1
.Leval_binary_39:
    pop eax
    test eax, eax
    jz .Leval_binary_36
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Leval_binary_37
.Leval_binary_36:
.Leval_binary_37:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Leval_binary_40
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_41
.Leval_binary_40:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    sar eax, cl
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
.Leval_binary_41:
    jmp .Leval_binary_0
.Leval_binary_11:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
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
    jz .Leval_binary_42
    push 1
    jmp .Leval_binary_43
.Leval_binary_42:
    push 0
.Leval_binary_43:
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_12:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_44
    push 1
    jmp .Leval_binary_45
.Leval_binary_44:
    push 0
.Leval_binary_45:
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_13:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Leval_binary_46
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setb al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_48
    push 1
    jmp .Leval_binary_49
.Leval_binary_48:
    push 0
.Leval_binary_49:
    jmp .Leval_binary_47
.Leval_binary_46:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
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
    jz .Leval_binary_50
    push 1
    jmp .Leval_binary_51
.Leval_binary_50:
    push 0
.Leval_binary_51:
.Leval_binary_47:
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_14:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Leval_binary_52
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    seta al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_54
    push 1
    jmp .Leval_binary_55
.Leval_binary_54:
    push 0
.Leval_binary_55:
    jmp .Leval_binary_53
.Leval_binary_52:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_56
    push 1
    jmp .Leval_binary_57
.Leval_binary_56:
    push 0
.Leval_binary_57:
.Leval_binary_53:
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_15:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Leval_binary_58
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setbe al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_60
    push 1
    jmp .Leval_binary_61
.Leval_binary_60:
    push 0
.Leval_binary_61:
    jmp .Leval_binary_59
.Leval_binary_58:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_62
    push 1
    jmp .Leval_binary_63
.Leval_binary_62:
    push 0
.Leval_binary_63:
.Leval_binary_59:
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_16:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Leval_binary_64
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setae al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_66
    push 1
    jmp .Leval_binary_67
.Leval_binary_66:
    push 0
.Leval_binary_67:
    jmp .Leval_binary_65
.Leval_binary_64:
    push dword ptr [ebp-48]
    push dword ptr [ebp-56]
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_68
    push 1
    jmp .Leval_binary_69
.Leval_binary_68:
    push 0
.Leval_binary_69:
.Leval_binary_65:
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_17:
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Leval_binary_72
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Leval_binary_73
.Leval_binary_72:
    push 0
.Leval_binary_73:
    pop eax
    test eax, eax
    jz .Leval_binary_70
    push 1
    jmp .Leval_binary_71
.Leval_binary_70:
    push 0
.Leval_binary_71:
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_18:
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    test eax, eax
    jnz .Leval_binary_76
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Leval_binary_77
.Leval_binary_76:
    push 1
.Leval_binary_77:
    pop eax
    test eax, eax
    jz .Leval_binary_74
    push 1
    jmp .Leval_binary_75
.Leval_binary_74:
    push 0
.Leval_binary_75:
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    add esp, 4
    jmp .Leval_binary_0
.Leval_binary_19:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Leval_binary_0:
    push dword ptr [ebp-72]
    push dword ptr [ebp-96]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    push 1
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

    .globl opt_constfold_func
opt_constfold_func:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 364
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 1
    pop eax
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-64], eax
.Lopt_constfold_func_0:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lopt_constfold_func_2
    push dword ptr [ebp-64]
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
    jmp .Lopt_constfold_func_3
.Lopt_constfold_func_2:
    push 0
.Lopt_constfold_func_3:
    pop eax
    test eax, eax
    jz .Lopt_constfold_func_1
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
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
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lopt_constfold_func_4:
    push dword ptr [ebp-72]
    push 2
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
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_constfold_func_5
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
    push dword ptr [ebp-72]
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
    mov [ebp-80], eax
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
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    mov [ebp-88], eax
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
    push dword ptr [ebp-72]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    mov [ebp-96], eax
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
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_constfold_func_7
    jmp .Lopt_constfold_func_6
    jmp .Lopt_constfold_func_8
.Lopt_constfold_func_7:
.Lopt_constfold_func_8:
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
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_constfold_func_9
    jmp .Lopt_constfold_func_6
    jmp .Lopt_constfold_func_10
.Lopt_constfold_func_9:
.Lopt_constfold_func_10:
    push dword ptr [ebp-96]
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
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_constfold_func_11
    jmp .Lopt_constfold_func_6
    jmp .Lopt_constfold_func_12
.Lopt_constfold_func_11:
.Lopt_constfold_func_12:
    push dword ptr [ebp-80]
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
    push dword ptr [ebp-88]
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
    pop ecx
    pop eax
    or eax, ecx
    push eax
    push dword ptr [ebp-96]
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
    pop ecx
    pop eax
    or eax, ecx
    push eax
    push 65536
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lopt_constfold_func_13
    jmp .Lopt_constfold_func_6
    jmp .Lopt_constfold_func_14
.Lopt_constfold_func_13:
.Lopt_constfold_func_14:
    lea eax, [ebp-104]
    push eax
    push dword ptr [ebp-96]
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
    push dword ptr [ebp-88]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
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
    call eval_binary
    mov esp, [ebp-112]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_constfold_func_15
    jmp .Lopt_constfold_func_6
    jmp .Lopt_constfold_func_16
.Lopt_constfold_func_15:
.Lopt_constfold_func_16:
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-104]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-88]
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
    push dword ptr [ebp-96]
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
    push 1
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lopt_constfold_func_6:
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
    jmp .Lopt_constfold_func_4
.Lopt_constfold_func_5:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lopt_constfold_func_17
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call compact_func
    mov esp, [ebp-112]
    jmp .Lopt_constfold_func_18
.Lopt_constfold_func_17:
.Lopt_constfold_func_18:
    jmp .Lopt_constfold_func_0
.Lopt_constfold_func_1:
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

    .globl opt_dce_func
opt_dce_func:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lopt_dce_func_0:
    push dword ptr [ebp-56]
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
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_dce_func_1
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
    mov [ebp-72], eax
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lopt_dce_func_3
    push dword ptr [ebp-72]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_dce_func_7
    push dword ptr [ebp-72]
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
    push 25
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
    jmp .Lopt_dce_func_8
.Lopt_dce_func_7:
    push 1
.Lopt_dce_func_8:
    pop eax
    test eax, eax
    jz .Lopt_dce_func_5
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lopt_dce_func_2
    jmp .Lopt_dce_func_6
.Lopt_dce_func_5:
.Lopt_dce_func_6:
    push dword ptr [ebp-72]
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
    push 65536
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lopt_dce_func_9
    jmp .Lopt_dce_func_2
    jmp .Lopt_dce_func_10
.Lopt_dce_func_9:
.Lopt_dce_func_10:
    push dword ptr [ebp-72]
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
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_dce_func_13
    push dword ptr [ebp-72]
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
    push 17
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
    jmp .Lopt_dce_func_14
.Lopt_dce_func_13:
    push 0
.Lopt_dce_func_14:
    pop eax
    test eax, eax
    jz .Lopt_dce_func_11
    push dword ptr [ebp-72]
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
    jmp .Lopt_dce_func_12
.Lopt_dce_func_11:
.Lopt_dce_func_12:
    jmp .Lopt_dce_func_2
    jmp .Lopt_dce_func_4
.Lopt_dce_func_3:
.Lopt_dce_func_4:
    push dword ptr [ebp-72]
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
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_dce_func_19
    push dword ptr [ebp-72]
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
    jmp .Lopt_dce_func_20
.Lopt_dce_func_19:
    push 1
.Lopt_dce_func_20:
    pop eax
    test eax, eax
    jnz .Lopt_dce_func_17
    push dword ptr [ebp-72]
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
    push 26
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
    jmp .Lopt_dce_func_18
.Lopt_dce_func_17:
    push 1
.Lopt_dce_func_18:
    pop eax
    test eax, eax
    jz .Lopt_dce_func_15
    push 1
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Lopt_dce_func_16
.Lopt_dce_func_15:
.Lopt_dce_func_16:
.Lopt_dce_func_2:
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
    jmp .Lopt_dce_func_0
.Lopt_dce_func_1:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call compact_func
    mov esp, [ebp-80]
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

    .globl opt_run
opt_run:
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
    jz .Lopt_run_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lopt_run_1
.Lopt_run_0:
.Lopt_run_1:
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_run_2
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lopt_run_4:
    push dword ptr [ebp-64]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_run_5
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
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call opt_constfold_func
    mov esp, [ebp-80]
.Lopt_run_6:
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
    jmp .Lopt_run_4
.Lopt_run_5:
    jmp .Lopt_run_3
.Lopt_run_2:
.Lopt_run_3:
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_run_7
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lopt_run_9:
    push dword ptr [ebp-64]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_run_10
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
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call opt_dce_func
    mov esp, [ebp-80]
.Lopt_run_11:
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
    jmp .Lopt_run_9
.Lopt_run_10:
    jmp .Lopt_run_8
.Lopt_run_7:
.Lopt_run_8:
    push dword ptr [ebp-56]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_run_14
    lea eax, [g_config]
    push eax
    push 36
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
    jmp .Lopt_run_15
.Lopt_run_14:
    push 0
.Lopt_run_15:
    pop eax
    test eax, eax
    jz .Lopt_run_12
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call opt_inline
    mov esp, [ebp-80]
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_run_16
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lopt_run_18:
    push dword ptr [ebp-64]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_run_19
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
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call opt_dce_func
    mov esp, [ebp-80]
.Lopt_run_20:
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
    jmp .Lopt_run_18
.Lopt_run_19:
    jmp .Lopt_run_17
.Lopt_run_16:
.Lopt_run_17:
    jmp .Lopt_run_13
.Lopt_run_12:
.Lopt_run_13:
    lea eax, [g_config]
    push eax
    push 40
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
    jnz .Lopt_run_23
    push dword ptr [ebp-56]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_run_24
.Lopt_run_23:
    push 1
.Lopt_run_24:
    pop eax
    test eax, eax
    jz .Lopt_run_21
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call opt_vectorize
    mov esp, [ebp-80]
    jmp .Lopt_run_22
.Lopt_run_21:
.Lopt_run_22:
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

    .globl count_insts_and_check_recursion
count_insts_and_check_recursion:
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
    mov [ebp-80], eax
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-64]
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lcount_insts_and_check_recursion_0:
    push dword ptr [ebp-72]
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
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcount_insts_and_check_recursion_1
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
    push dword ptr [ebp-72]
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lcount_insts_and_check_recursion_9
    push dword ptr [ebp-96]
    push 17
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
    jmp .Lcount_insts_and_check_recursion_10
.Lcount_insts_and_check_recursion_9:
    push 1
.Lcount_insts_and_check_recursion_10:
    pop eax
    test eax, eax
    jnz .Lcount_insts_and_check_recursion_7
    push dword ptr [ebp-96]
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
    jmp .Lcount_insts_and_check_recursion_8
.Lcount_insts_and_check_recursion_7:
    push 1
.Lcount_insts_and_check_recursion_8:
    pop eax
    test eax, eax
    jnz .Lcount_insts_and_check_recursion_5
    push dword ptr [ebp-96]
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
    jmp .Lcount_insts_and_check_recursion_6
.Lcount_insts_and_check_recursion_5:
    push 1
.Lcount_insts_and_check_recursion_6:
    pop eax
    test eax, eax
    jz .Lcount_insts_and_check_recursion_3
    jmp .Lcount_insts_and_check_recursion_2
    jmp .Lcount_insts_and_check_recursion_4
.Lcount_insts_and_check_recursion_3:
.Lcount_insts_and_check_recursion_4:
    push dword ptr [ebp-96]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcount_insts_and_check_recursion_15
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
    push dword ptr [ebp-72]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    jmp .Lcount_insts_and_check_recursion_16
.Lcount_insts_and_check_recursion_15:
    push 0
.Lcount_insts_and_check_recursion_16:
    pop eax
    test eax, eax
    jz .Lcount_insts_and_check_recursion_13
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
    push dword ptr [ebp-72]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lcount_insts_and_check_recursion_14
.Lcount_insts_and_check_recursion_13:
    push 0
.Lcount_insts_and_check_recursion_14:
    pop eax
    test eax, eax
    jz .Lcount_insts_and_check_recursion_11
    push 1
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lcount_insts_and_check_recursion_12
.Lcount_insts_and_check_recursion_11:
.Lcount_insts_and_check_recursion_12:
    push dword ptr [ebp-96]
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lcount_insts_and_check_recursion_19
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
    push dword ptr [ebp-72]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 8
    pop ecx
    pop eax
    sar eax, cl
    push eax
    push 0
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
    jmp .Lcount_insts_and_check_recursion_20
.Lcount_insts_and_check_recursion_19:
    push 0
.Lcount_insts_and_check_recursion_20:
    pop eax
    test eax, eax
    jz .Lcount_insts_and_check_recursion_17
    push dword ptr [ebp-64]
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lcount_insts_and_check_recursion_18
.Lcount_insts_and_check_recursion_17:
.Lcount_insts_and_check_recursion_18:
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
.Lcount_insts_and_check_recursion_2:
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
    jmp .Lcount_insts_and_check_recursion_0
.Lcount_insts_and_check_recursion_1:
    push dword ptr [ebp-56]
    push dword ptr [ebp-80]
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

    .globl opt_inline
opt_inline:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 492
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
    jnz .Lopt_inline_2
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
    jmp .Lopt_inline_3
.Lopt_inline_2:
    push 1
.Lopt_inline_3:
    pop eax
    test eax, eax
    jz .Lopt_inline_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lopt_inline_1
.Lopt_inline_0:
.Lopt_inline_1:
    push 12
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
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lopt_inline_4:
    push dword ptr [ebp-56]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_5
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
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-104], eax
    lea eax, [ebp-104]
    push eax
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    pop eax
    mov [ebp-264], eax
    mov [ebp-240], esp
    push dword ptr [ebp-264]
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call count_insts_and_check_recursion
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push 12
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
    push dword ptr [ebp-88]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push 12
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-96]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push 12
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    push dword ptr [ebp-112]
    pop eax
    test eax, eax
    jz .Lopt_inline_7
    jmp .Lopt_inline_6
    jmp .Lopt_inline_8
.Lopt_inline_7:
.Lopt_inline_8:
    push dword ptr [ebp-88]
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
    jz .Lopt_inline_9
    jmp .Lopt_inline_6
    jmp .Lopt_inline_10
.Lopt_inline_9:
.Lopt_inline_10:
    push dword ptr [ebp-88]
    push 36
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
    jnz .Lopt_inline_15
    push dword ptr [ebp-88]
    push 44
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
    jmp .Lopt_inline_16
.Lopt_inline_15:
    push 1
.Lopt_inline_16:
    pop eax
    test eax, eax
    jnz .Lopt_inline_13
    push dword ptr [ebp-88]
    push 56
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
    jmp .Lopt_inline_14
.Lopt_inline_13:
    push 1
.Lopt_inline_14:
    pop eax
    test eax, eax
    jz .Lopt_inline_11
    jmp .Lopt_inline_6
    jmp .Lopt_inline_12
.Lopt_inline_11:
.Lopt_inline_12:
    push dword ptr [ebp-88]
    push 64
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
    jnz .Lopt_inline_19
    push dword ptr [ebp-88]
    push 68
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
    jmp .Lopt_inline_20
.Lopt_inline_19:
    push 1
.Lopt_inline_20:
    pop eax
    test eax, eax
    jz .Lopt_inline_17
    jmp .Lopt_inline_6
    jmp .Lopt_inline_18
.Lopt_inline_17:
.Lopt_inline_18:
    push dword ptr [ebp-88]
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
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_21
    jmp .Lopt_inline_6
    jmp .Lopt_inline_22
.Lopt_inline_21:
.Lopt_inline_22:
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    jz .Lopt_inline_23
    jmp .Lopt_inline_6
    jmp .Lopt_inline_24
.Lopt_inline_23:
.Lopt_inline_24:
    push dword ptr [ebp-88]
    push 60
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
    jz .Lopt_inline_25
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push 12
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
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
    jmp .Lopt_inline_26
.Lopt_inline_25:
    push dword ptr [ebp-96]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_27
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push 12
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
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
    jmp .Lopt_inline_28
.Lopt_inline_27:
.Lopt_inline_28:
.Lopt_inline_26:
.Lopt_inline_6:
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
    jmp .Lopt_inline_4
.Lopt_inline_5:
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lopt_inline_29:
    push dword ptr [ebp-56]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_30
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
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-104], eax
    push 0
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lopt_inline_32:
    push dword ptr [ebp-64]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_33
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
    push dword ptr [ebp-64]
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
    mov [ebp-128], eax
    push dword ptr [ebp-128]
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
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_35
    jmp .Lopt_inline_34
    jmp .Lopt_inline_36
.Lopt_inline_35:
.Lopt_inline_36:
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lopt_inline_37:
    push dword ptr [ebp-72]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_38
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    jz .Lopt_inline_46
    push dword ptr [ebp-128]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_inline_47
.Lopt_inline_46:
    push 0
.Lopt_inline_47:
    pop eax
    test eax, eax
    jz .Lopt_inline_44
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
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
    push dword ptr [ebp-128]
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
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call ark_streq
    mov esp, [ebp-240]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_inline_45
.Lopt_inline_44:
    push 0
.Lopt_inline_45:
    pop eax
    test eax, eax
    jz .Lopt_inline_42
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
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
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
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call ark_streq
    mov esp, [ebp-240]
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
    jmp .Lopt_inline_43
.Lopt_inline_42:
    push 0
.Lopt_inline_43:
    pop eax
    test eax, eax
    jz .Lopt_inline_40
    push 1
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Lopt_inline_38
    jmp .Lopt_inline_41
.Lopt_inline_40:
.Lopt_inline_41:
.Lopt_inline_39:
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
    jmp .Lopt_inline_37
.Lopt_inline_38:
    push dword ptr [ebp-120]
    pop eax
    test eax, eax
    jz .Lopt_inline_48
    jmp .Lopt_inline_33
    jmp .Lopt_inline_49
.Lopt_inline_48:
.Lopt_inline_49:
.Lopt_inline_34:
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
    jmp .Lopt_inline_32
.Lopt_inline_33:
    push dword ptr [ebp-120]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_50
    jmp .Lopt_inline_31
    jmp .Lopt_inline_51
.Lopt_inline_50:
.Lopt_inline_51:
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
    push 3
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push 4096
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lopt_inline_52:
    push dword ptr [ebp-64]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_53
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
    push dword ptr [ebp-64]
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
    mov [ebp-128], eax
    push dword ptr [ebp-128]
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
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_55
    jmp .Lopt_inline_54
    jmp .Lopt_inline_56
.Lopt_inline_55:
.Lopt_inline_56:
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lopt_inline_57:
    push dword ptr [ebp-72]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_58
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    jz .Lopt_inline_66
    push dword ptr [ebp-128]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_inline_67
.Lopt_inline_66:
    push 0
.Lopt_inline_67:
    pop eax
    test eax, eax
    jz .Lopt_inline_64
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
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
    push dword ptr [ebp-128]
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
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call ark_streq
    mov esp, [ebp-240]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_inline_65
.Lopt_inline_64:
    push 0
.Lopt_inline_65:
    pop eax
    test eax, eax
    jz .Lopt_inline_62
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
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
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
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call ark_streq
    mov esp, [ebp-240]
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
    jmp .Lopt_inline_63
.Lopt_inline_62:
    push 0
.Lopt_inline_63:
    pop eax
    test eax, eax
    jz .Lopt_inline_60
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
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
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-96]
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-136]
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
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    push 128
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
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    add esp, 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lopt_inline_58
    jmp .Lopt_inline_61
.Lopt_inline_60:
.Lopt_inline_61:
.Lopt_inline_59:
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
    jmp .Lopt_inline_57
.Lopt_inline_58:
.Lopt_inline_54:
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
    jmp .Lopt_inline_52
.Lopt_inline_53:
    push 32
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lopt_inline_68:
    push dword ptr [ebp-64]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_69
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
    push dword ptr [ebp-64]
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
    mov [ebp-128], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-176], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-128]
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
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_71
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edi
    pop esi
    mov ecx, 32
    rep movsb
    add esp, 4
    jmp .Lopt_inline_70
    jmp .Lopt_inline_72
.Lopt_inline_71:
.Lopt_inline_72:
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lopt_inline_73:
    push dword ptr [ebp-72]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_74
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    jz .Lopt_inline_82
    push dword ptr [ebp-128]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_inline_83
.Lopt_inline_82:
    push 0
.Lopt_inline_83:
    pop eax
    test eax, eax
    jz .Lopt_inline_80
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
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
    push dword ptr [ebp-128]
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
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call ark_streq
    mov esp, [ebp-240]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_inline_81
.Lopt_inline_80:
    push 0
.Lopt_inline_81:
    pop eax
    test eax, eax
    jz .Lopt_inline_78
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
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
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
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call ark_streq
    mov esp, [ebp-240]
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
    jmp .Lopt_inline_79
.Lopt_inline_78:
    push 0
.Lopt_inline_79:
    pop eax
    test eax, eax
    jz .Lopt_inline_76
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    push 12
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
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lopt_inline_74
    jmp .Lopt_inline_77
.Lopt_inline_76:
.Lopt_inline_77:
.Lopt_inline_75:
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
    jmp .Lopt_inline_73
.Lopt_inline_74:
    push dword ptr [ebp-136]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_84
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edi
    pop esi
    mov ecx, 32
    rep movsb
    add esp, 4
    jmp .Lopt_inline_70
    jmp .Lopt_inline_85
.Lopt_inline_84:
.Lopt_inline_85:
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push dword ptr [ebp-144]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_86
    push 0
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    jmp .Lopt_inline_87
.Lopt_inline_86:
.Lopt_inline_87:
    push dword ptr [ebp-144]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_88
    push 4
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    jmp .Lopt_inline_89
.Lopt_inline_88:
.Lopt_inline_89:
    push dword ptr [ebp-88]
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
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    push dword ptr [ebp-152]
    push dword ptr [ebp-144]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
    push dword ptr [ebp-88]
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
    push dword ptr [ebp-136]
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
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lopt_inline_90:
    push dword ptr [ebp-72]
    push dword ptr [ebp-136]
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
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_91
    push dword ptr [ebp-136]
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
    push dword ptr [ebp-72]
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
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_93
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lopt_inline_94
.Lopt_inline_93:
    push dword ptr [ebp-136]
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
    push dword ptr [ebp-72]
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
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_95
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .Lopt_inline_91
    jmp .Lopt_inline_96
.Lopt_inline_95:
.Lopt_inline_96:
.Lopt_inline_94:
.Lopt_inline_92:
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
    jmp .Lopt_inline_90
.Lopt_inline_91:
    push dword ptr [ebp-176]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_99
    push dword ptr [ebp-184]
    push 0
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
    jmp .Lopt_inline_100
.Lopt_inline_99:
    push 1
.Lopt_inline_100:
    pop eax
    test eax, eax
    jz .Lopt_inline_97
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edi
    pop esi
    mov ecx, 32
    rep movsb
    add esp, 4
    jmp .Lopt_inline_70
    jmp .Lopt_inline_98
.Lopt_inline_97:
.Lopt_inline_98:
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lopt_inline_101:
    push dword ptr [ebp-72]
    push dword ptr [ebp-144]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_102
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
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
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 5
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-192]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-152]
    push dword ptr [ebp-72]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-192]
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
    push dword ptr [ebp-192]
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
    push dword ptr [ebp-192]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lopt_inline_103:
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
    jmp .Lopt_inline_101
.Lopt_inline_102:
    push dword ptr [ebp-176]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lopt_inline_104:
    push dword ptr [ebp-72]
    push dword ptr [ebp-184]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_inline_105
    push dword ptr [ebp-136]
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
    push dword ptr [ebp-72]
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
    mov [ebp-192], eax
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
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
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    push dword ptr [ebp-192]
    push dword ptr [ebp-200]
    pop edi
    pop esi
    mov ecx, 32
    rep movsb
    add esp, 4
    push dword ptr [ebp-192]
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
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    push 5
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_108
    push dword ptr [ebp-208]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_109
    push dword ptr [ebp-208]
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_110
    push dword ptr [ebp-208]
    push 18
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_111
    push dword ptr [ebp-208]
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_112
    push dword ptr [ebp-208]
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_113
    push dword ptr [ebp-208]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_114
    push dword ptr [ebp-208]
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_115
    push dword ptr [ebp-208]
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_116
    push dword ptr [ebp-208]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_117
    push dword ptr [ebp-208]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_118
    push dword ptr [ebp-208]
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_inline_119
    jmp .Lopt_inline_120
.Lopt_inline_108:
.Lopt_inline_109:
.Lopt_inline_110:
.Lopt_inline_111:
    push dword ptr [ebp-200]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-192]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-160]
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
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lopt_inline_107
.Lopt_inline_112:
    push dword ptr [ebp-192]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    mov [ebp-216], eax
    push dword ptr [ebp-192]
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
    push 255
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-200]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 2
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-200]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-152]
    push dword ptr [ebp-224]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-200]
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
    push dword ptr [ebp-200]
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
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
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
    mov [ebp-232], eax
    push dword ptr [ebp-232]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 5
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-232]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-160]
    push dword ptr [ebp-216]
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-232]
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
    push dword ptr [ebp-232]
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
    push dword ptr [ebp-232]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-192]
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lopt_inline_107
.Lopt_inline_113:
    push dword ptr [ebp-200]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 13
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-200]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-168]
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
    push dword ptr [ebp-200]
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
    push dword ptr [ebp-200]
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
    jmp .Lopt_inline_107
.Lopt_inline_114:
.Lopt_inline_115:
.Lopt_inline_116:
.Lopt_inline_117:
    push dword ptr [ebp-200]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-192]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
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
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lopt_inline_107
.Lopt_inline_118:
.Lopt_inline_119:
    push dword ptr [ebp-200]
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
    jmp .Lopt_inline_107
.Lopt_inline_120:
    jmp .Lopt_inline_107
.Lopt_inline_107:
.Lopt_inline_106:
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
    jmp .Lopt_inline_104
.Lopt_inline_105:
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
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
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 12
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-192]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-168]
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
    push dword ptr [ebp-192]
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
    push dword ptr [ebp-192]
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
    push dword ptr [ebp-192]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-160]
    push dword ptr [ebp-136]
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
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-168]
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
.Lopt_inline_70:
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
    jmp .Lopt_inline_68
.Lopt_inline_69:
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-104]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-96]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lopt_inline_31:
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
    jmp .Lopt_inline_29
.Lopt_inline_30:
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

    .globl body_has_unsafe_op
body_has_unsafe_op:
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
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lbody_has_unsafe_op_0:
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
    jz .Lbody_has_unsafe_op_1
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
    push dword ptr [ebp-72]
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
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lbody_has_unsafe_op_5
    push dword ptr [ebp-80]
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
    jmp .Lbody_has_unsafe_op_6
.Lbody_has_unsafe_op_5:
    push 1
.Lbody_has_unsafe_op_6:
    pop eax
    test eax, eax
    jz .Lbody_has_unsafe_op_3
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lbody_has_unsafe_op_4
.Lbody_has_unsafe_op_3:
.Lbody_has_unsafe_op_4:
    push dword ptr [ebp-80]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lbody_has_unsafe_op_9
    push dword ptr [ebp-80]
    push 25
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
    jmp .Lbody_has_unsafe_op_10
.Lbody_has_unsafe_op_9:
    push 1
.Lbody_has_unsafe_op_10:
    pop eax
    test eax, eax
    jz .Lbody_has_unsafe_op_7
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lbody_has_unsafe_op_8
.Lbody_has_unsafe_op_7:
.Lbody_has_unsafe_op_8:
.Lbody_has_unsafe_op_2:
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
    jmp .Lbody_has_unsafe_op_0
.Lbody_has_unsafe_op_1:
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

    .globl match_vectorize_body
match_vectorize_body:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 460
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
    mov eax, [ebp+32]
    mov [ebp-96], eax
    mov eax, [ebp+36]
    mov [ebp-104], eax
    mov eax, [ebp+40]
    mov [ebp-112], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-128], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-136], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-144], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-152], eax
    push 0
    pop eax
    mov [ebp-160], eax
    push 0
    pop eax
    mov [ebp-168], eax
    push 0
    pop eax
    mov [ebp-176], eax
    push 0
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
.Lmatch_vectorize_body_0:
    push dword ptr [ebp-120]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_1
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
    push dword ptr [ebp-120]
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
    mov [ebp-192], eax
    push dword ptr [ebp-192]
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
    push 7
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_3
    push dword ptr [ebp-176]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_5
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-192]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
    jmp .Lmatch_vectorize_body_6
.Lmatch_vectorize_body_5:
    push dword ptr [ebp-176]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_7
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    push dword ptr [ebp-192]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-160]
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
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_9
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmatch_vectorize_body_10
.Lmatch_vectorize_body_9:
.Lmatch_vectorize_body_10:
    jmp .Lmatch_vectorize_body_8
.Lmatch_vectorize_body_7:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lmatch_vectorize_body_8:
.Lmatch_vectorize_body_6:
    push dword ptr [ebp-176]
    push dword ptr [ebp-176]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-176], eax
    add esp, 4
    jmp .Lmatch_vectorize_body_4
.Lmatch_vectorize_body_3:
    push dword ptr [ebp-192]
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
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_11
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_13
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmatch_vectorize_body_14
.Lmatch_vectorize_body_13:
.Lmatch_vectorize_body_14:
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    push dword ptr [ebp-160]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_17
    push dword ptr [ebp-192]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-160]
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
    jmp .Lmatch_vectorize_body_18
.Lmatch_vectorize_body_17:
    push 0
.Lmatch_vectorize_body_18:
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_15
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmatch_vectorize_body_16
.Lmatch_vectorize_body_15:
.Lmatch_vectorize_body_16:
    push dword ptr [ebp-160]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_19
    push dword ptr [ebp-192]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
    jmp .Lmatch_vectorize_body_20
.Lmatch_vectorize_body_19:
.Lmatch_vectorize_body_20:
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
    jmp .Lmatch_vectorize_body_12
.Lmatch_vectorize_body_11:
    push dword ptr [ebp-192]
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
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_23
    push dword ptr [ebp-176]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmatch_vectorize_body_24
.Lmatch_vectorize_body_23:
    push 0
.Lmatch_vectorize_body_24:
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_21
    push dword ptr [ebp-192]
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
    push 256
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lmatch_vectorize_body_27
    push dword ptr [ebp-200]
    push 16
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
    jmp .Lmatch_vectorize_body_28
.Lmatch_vectorize_body_27:
    push 1
.Lmatch_vectorize_body_28:
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_25
    push dword ptr [ebp-144]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_29
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmatch_vectorize_body_30
.Lmatch_vectorize_body_29:
.Lmatch_vectorize_body_30:
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push dword ptr [ebp-200]
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lmatch_vectorize_body_26
.Lmatch_vectorize_body_25:
.Lmatch_vectorize_body_26:
    jmp .Lmatch_vectorize_body_22
.Lmatch_vectorize_body_21:
.Lmatch_vectorize_body_22:
.Lmatch_vectorize_body_12:
.Lmatch_vectorize_body_4:
.Lmatch_vectorize_body_2:
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
    jmp .Lmatch_vectorize_body_0
.Lmatch_vectorize_body_1:
    push dword ptr [ebp-176]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lmatch_vectorize_body_35
    push dword ptr [ebp-184]
    push 1
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
    jmp .Lmatch_vectorize_body_36
.Lmatch_vectorize_body_35:
    push 1
.Lmatch_vectorize_body_36:
    pop eax
    test eax, eax
    jnz .Lmatch_vectorize_body_33
    push dword ptr [ebp-144]
    push 0
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
    jmp .Lmatch_vectorize_body_34
.Lmatch_vectorize_body_33:
    push 1
.Lmatch_vectorize_body_34:
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_31
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmatch_vectorize_body_32
.Lmatch_vectorize_body_31:
.Lmatch_vectorize_body_32:
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lmatch_vectorize_body_41
    push dword ptr [ebp-144]
    push dword ptr [ebp-136]
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
    jmp .Lmatch_vectorize_body_42
.Lmatch_vectorize_body_41:
    push 1
.Lmatch_vectorize_body_42:
    pop eax
    test eax, eax
    jnz .Lmatch_vectorize_body_39
    push dword ptr [ebp-152]
    push dword ptr [ebp-144]
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
    jmp .Lmatch_vectorize_body_40
.Lmatch_vectorize_body_39:
    push 1
.Lmatch_vectorize_body_40:
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_37
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmatch_vectorize_body_38
.Lmatch_vectorize_body_37:
.Lmatch_vectorize_body_38:
    push dword ptr [ebp-160]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_45
    push dword ptr [ebp-160]
    push 2
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
    jmp .Lmatch_vectorize_body_46
.Lmatch_vectorize_body_45:
    push 0
.Lmatch_vectorize_body_46:
    pop eax
    test eax, eax
    jz .Lmatch_vectorize_body_43
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmatch_vectorize_body_44
.Lmatch_vectorize_body_43:
.Lmatch_vectorize_body_44:
    push dword ptr [ebp-72]
    push dword ptr [ebp-160]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push dword ptr [ebp-168]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    push dword ptr [ebp-136]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-104]
    push dword ptr [ebp-144]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-112]
    push dword ptr [ebp-152]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 1
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

    .globl opt_vectorize
opt_vectorize:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 524
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
    jz .Lopt_vectorize_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lopt_vectorize_1
.Lopt_vectorize_0:
.Lopt_vectorize_1:
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lopt_vectorize_2:
    push dword ptr [ebp-56]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_3
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
    mov [ebp-72], eax
    push 0
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lopt_vectorize_5:
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
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
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_6
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-88], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-96], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-104], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-112], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-120], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-128], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-136], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-144], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-152], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-160], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-168], eax
    push 0
    pop eax
    mov [ebp-176], eax
    push 0
    pop eax
    mov [ebp-184], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-192], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-200], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-208], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-216], eax
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
    push dword ptr [ebp-80]
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
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_8
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_9
.Lopt_vectorize_8:
.Lopt_vectorize_9:
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
    push dword ptr [ebp-80]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lopt_vectorize_10:
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_11
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
    push dword ptr [ebp-64]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_15
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
    push dword ptr [ebp-64]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_vectorize_16
.Lopt_vectorize_15:
    push 0
.Lopt_vectorize_16:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_13
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lopt_vectorize_11
    jmp .Lopt_vectorize_14
.Lopt_vectorize_13:
.Lopt_vectorize_14:
.Lopt_vectorize_12:
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lopt_vectorize_10
.Lopt_vectorize_11:
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
    jz .Lopt_vectorize_17
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_18
.Lopt_vectorize_17:
.Lopt_vectorize_18:
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lopt_vectorize_19:
    push dword ptr [ebp-64]
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_20
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
    push dword ptr [ebp-64]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_22
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
    push dword ptr [ebp-64]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lopt_vectorize_20
    jmp .Lopt_vectorize_23
.Lopt_vectorize_22:
.Lopt_vectorize_23:
.Lopt_vectorize_21:
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
    jmp .Lopt_vectorize_19
.Lopt_vectorize_20:
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_24
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_25
.Lopt_vectorize_24:
.Lopt_vectorize_25:
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lopt_vectorize_26:
    push dword ptr [ebp-64]
    push dword ptr [ebp-112]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_27
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
    push dword ptr [ebp-64]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_29
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
    push dword ptr [ebp-64]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Lopt_vectorize_27
    jmp .Lopt_vectorize_30
.Lopt_vectorize_29:
.Lopt_vectorize_30:
.Lopt_vectorize_28:
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lopt_vectorize_26
.Lopt_vectorize_27:
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_31
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_32
.Lopt_vectorize_31:
.Lopt_vectorize_32:
    push dword ptr [ebp-104]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_33
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_34
.Lopt_vectorize_33:
.Lopt_vectorize_34:
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
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
    jz .Lopt_vectorize_35
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_36
.Lopt_vectorize_35:
.Lopt_vectorize_36:
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
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_vectorize_39
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
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-96]
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
    jmp .Lopt_vectorize_40
.Lopt_vectorize_39:
    push 1
.Lopt_vectorize_40:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_37
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_38
.Lopt_vectorize_37:
.Lopt_vectorize_38:
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    push dword ptr [ebp-120]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-248], eax
    push dword ptr [ebp-248]
    add esp, 4
.Lopt_vectorize_41:
    push dword ptr [ebp-248]
    push dword ptr [ebp-120]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_42
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
    push dword ptr [ebp-248]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_44
    push dword ptr [ebp-248]
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-240]
    add esp, 4
    jmp .Lopt_vectorize_42
    jmp .Lopt_vectorize_45
.Lopt_vectorize_44:
.Lopt_vectorize_45:
.Lopt_vectorize_43:
    push dword ptr [ebp-248]
    push dword ptr [ebp-248]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-248], eax
    add esp, 4
    jmp .Lopt_vectorize_41
.Lopt_vectorize_42:
    push dword ptr [ebp-240]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_46
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_47
.Lopt_vectorize_46:
.Lopt_vectorize_47:
    push dword ptr [ebp-240]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-240]
    push 3
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push dword ptr [ebp-112]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_48
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_49
.Lopt_vectorize_48:
.Lopt_vectorize_49:
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
    push dword ptr [ebp-240]
    push 3
    pop ecx
    pop eax
    sub eax, ecx
    push eax
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
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_50
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_51
.Lopt_vectorize_50:
.Lopt_vectorize_51:
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
    push dword ptr [ebp-240]
    push 2
    pop ecx
    pop eax
    sub eax, ecx
    push eax
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
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_52
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_53
.Lopt_vectorize_52:
.Lopt_vectorize_53:
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
    push dword ptr [ebp-240]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
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
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_54
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_55
.Lopt_vectorize_54:
.Lopt_vectorize_55:
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
    push dword ptr [ebp-240]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-256], eax
    push dword ptr [ebp-256]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_60
    push dword ptr [ebp-256]
    push 25
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
    jmp .Lopt_vectorize_61
.Lopt_vectorize_60:
    push 0
.Lopt_vectorize_61:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_58
    push dword ptr [ebp-256]
    push 22
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
    jmp .Lopt_vectorize_59
.Lopt_vectorize_58:
    push 0
.Lopt_vectorize_59:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_56
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_57
.Lopt_vectorize_56:
.Lopt_vectorize_57:
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
    push dword ptr [ebp-240]
    push 3
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
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
    push dword ptr [ebp-240]
    push 2
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-288], eax
    pop eax
    mov [ebp-292], eax
    pop eax
    mov [ebp-296], eax
    mov [ebp-272], esp
    push dword ptr [ebp-296]
    push dword ptr [ebp-292]
    push dword ptr [ebp-288]
    and esp, -16
    call body_has_unsafe_op
    mov esp, [ebp-272]
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_62
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_63
.Lopt_vectorize_62:
.Lopt_vectorize_63:
    lea eax, [ebp-216]
    push eax
    lea eax, [ebp-208]
    push eax
    lea eax, [ebp-200]
    push eax
    lea eax, [ebp-192]
    push eax
    lea eax, [ebp-184]
    push eax
    lea eax, [ebp-176]
    push eax
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-288], eax
    pop eax
    mov [ebp-292], eax
    pop eax
    mov [ebp-296], eax
    pop eax
    mov [ebp-300], eax
    pop eax
    mov [ebp-304], eax
    pop eax
    mov [ebp-308], eax
    pop eax
    mov [ebp-312], eax
    pop eax
    mov [ebp-316], eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-272], esp
    push dword ptr [ebp-320]
    push dword ptr [ebp-316]
    push dword ptr [ebp-312]
    push dword ptr [ebp-308]
    push dword ptr [ebp-304]
    push dword ptr [ebp-300]
    push dword ptr [ebp-296]
    push dword ptr [ebp-292]
    push dword ptr [ebp-288]
    and esp, -16
    call match_vectorize_body
    mov esp, [ebp-272]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_64
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_65
.Lopt_vectorize_64:
.Lopt_vectorize_65:
    push dword ptr [ebp-176]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_66
    push 2
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
    push dword ptr [ebp-184]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_68
    push 52
    jmp .Lopt_vectorize_69
.Lopt_vectorize_68:
    push 53
.Lopt_vectorize_69:
    pop eax
    mov [ebp-232], eax
    push dword ptr [ebp-232]
    add esp, 4
    jmp .Lopt_vectorize_67
.Lopt_vectorize_66:
    push 4
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
    push dword ptr [ebp-184]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_70
    push 54
    jmp .Lopt_vectorize_71
.Lopt_vectorize_70:
    push 55
.Lopt_vectorize_71:
    pop eax
    mov [ebp-232], eax
    push dword ptr [ebp-232]
    add esp, 4
.Lopt_vectorize_67:
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lopt_vectorize_74
    push dword ptr [ebp-168]
    push dword ptr [ebp-224]
    pop ecx
    pop eax
    cdq
    idiv ecx
    push edx
    push 0
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
    jmp .Lopt_vectorize_75
.Lopt_vectorize_74:
    push 1
.Lopt_vectorize_75:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_72
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_73
.Lopt_vectorize_72:
.Lopt_vectorize_73:
    push 0
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-248], eax
    push dword ptr [ebp-248]
    add esp, 4
.Lopt_vectorize_76:
    push dword ptr [ebp-248]
    push dword ptr [ebp-152]
    push 2
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
    pop eax
    test eax, eax
    jz .Lopt_vectorize_77
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
    push dword ptr [ebp-248]
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
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_89
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
    push dword ptr [ebp-248]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 1
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_vectorize_90
.Lopt_vectorize_89:
    push 0
.Lopt_vectorize_90:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_87
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
    push dword ptr [ebp-248]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push 8
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
    jmp .Lopt_vectorize_88
.Lopt_vectorize_87:
    push 0
.Lopt_vectorize_88:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_85
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
    push dword ptr [ebp-248]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 256
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    push 15
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
    jmp .Lopt_vectorize_86
.Lopt_vectorize_85:
    push 0
.Lopt_vectorize_86:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_83
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
    push dword ptr [ebp-248]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push 5
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
    jmp .Lopt_vectorize_84
.Lopt_vectorize_83:
    push 0
.Lopt_vectorize_84:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_81
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
    push dword ptr [ebp-248]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-160]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lopt_vectorize_82
.Lopt_vectorize_81:
    push 0
.Lopt_vectorize_82:
    pop eax
    test eax, eax
    jz .Lopt_vectorize_79
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
    push dword ptr [ebp-248]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-224]
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
    push 1
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-240]
    add esp, 4
    jmp .Lopt_vectorize_77
    jmp .Lopt_vectorize_80
.Lopt_vectorize_79:
.Lopt_vectorize_80:
.Lopt_vectorize_78:
    push dword ptr [ebp-248]
    push dword ptr [ebp-248]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-248], eax
    add esp, 4
    jmp .Lopt_vectorize_76
.Lopt_vectorize_77:
    push dword ptr [ebp-240]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lopt_vectorize_91
    jmp .Lopt_vectorize_7
    jmp .Lopt_vectorize_92
.Lopt_vectorize_91:
.Lopt_vectorize_92:
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
    push dword ptr [ebp-192]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    push dword ptr [ebp-224]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    push dword ptr [ebp-200]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    push dword ptr [ebp-224]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    push dword ptr [ebp-216]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    push dword ptr [ebp-224]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    push dword ptr [ebp-208]
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
    push dword ptr [ebp-232]
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
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-208]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
.Lopt_vectorize_7:
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
    jmp .Lopt_vectorize_5
.Lopt_vectorize_6:
.Lopt_vectorize_4:
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
    jmp .Lopt_vectorize_2
.Lopt_vectorize_3:
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

