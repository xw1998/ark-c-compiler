# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz "Jan  1 1970"
ark_str_1:
    .asciz "00:00:00"
ark_str_2:
    .asciz ""
ark_str_3:
    .asciz "[arkcc] FATAL: %s\n"
    .data
    .globl ark_sl_ark_get_date_time_mon_names
    .local ark_sl_ark_get_date_time_mon_names
ark_sl_ark_get_date_time_mon_names:
    .quad 27695899046994250
    .quad 32211571827695949
    .quad 31091208134156621
    .quad 29120844641629514
    .quad 32760288259368275
    .quad 27977365434298190
    .text
    .globl ark_get_date_time
ark_get_date_time:
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
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call time
    mov esp, [ebp-112]
    push eax
    pop eax
    mov [ebp-64], eax
    lea eax, [ebp-64]
    push eax
    pop eax
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call localtime
    mov esp, [ebp-112]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Lark_get_date_time_0
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
    mov [ebp-80], eax
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
    push 1900
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    lea eax, [ark_sl_ark_get_date_time_mon_names]
    push eax
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
    push 12
    pop ecx
    pop eax
    cdq
    idiv ecx
    push edx
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
    push dword ptr [ebp-96]
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-48]
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
    push dword ptr [ebp-96]
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-48]
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
    push 32
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-48]
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
    push dword ptr [ebp-80]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lark_get_date_time_2
    push 32
    jmp .Lark_get_date_time_3
.Lark_get_date_time_2:
    push 48
    push dword ptr [ebp-80]
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
.Lark_get_date_time_3:
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 5
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
    push dword ptr [ebp-80]
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
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
    push dword ptr [ebp-48]
    push 6
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 32
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 7
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
    push dword ptr [ebp-88]
    push 1000
    pop ecx
    pop eax
    cdq
    idiv ecx
    push eax
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
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
    push dword ptr [ebp-48]
    push 8
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
    push dword ptr [ebp-88]
    push 100
    pop ecx
    pop eax
    cdq
    idiv ecx
    push eax
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
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
    push dword ptr [ebp-48]
    push 9
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
    push dword ptr [ebp-88]
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
    push eax
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
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
    push dword ptr [ebp-48]
    push 10
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
    push dword ptr [ebp-88]
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
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
    push dword ptr [ebp-48]
    push 11
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
    push 48
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
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-56]
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
    push 48
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
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
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
    push dword ptr [ebp-56]
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
    push 58
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-56]
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
    push 48
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
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-56]
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
    push 48
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
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
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
    push dword ptr [ebp-56]
    push 5
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 58
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 6
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
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-56]
    push 7
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
    push 10
    pop ecx
    pop eax
    cdq
    idiv ecx
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
    push dword ptr [ebp-56]
    push 8
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
    jmp .Lark_get_date_time_1
.Lark_get_date_time_0:
    lea eax, [ark_str_0]
    push eax
    pop eax
    mov [ebp-80], eax
    lea eax, [ark_str_1]
    push eax
    pop eax
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
.Lark_get_date_time_4:
    push dword ptr [ebp-96]
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lark_get_date_time_5
    push dword ptr [ebp-48]
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
    push dword ptr [ebp-80]
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
.Lark_get_date_time_6:
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
    jmp .Lark_get_date_time_4
.Lark_get_date_time_5:
    push dword ptr [ebp-48]
    push 11
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
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
.Lark_get_date_time_7:
    push dword ptr [ebp-96]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lark_get_date_time_8
    push dword ptr [ebp-56]
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
.Lark_get_date_time_9:
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
    jmp .Lark_get_date_time_7
.Lark_get_date_time_8:
    push dword ptr [ebp-56]
    push 8
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
.Lark_get_date_time_1:
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

    .globl ark_log
ark_log:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 8364
    mov eax, [ebp+8]
    mov [ebp-48], eax
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
    lea eax, [ebp+12]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    mov eax, [stderr]
    push eax
    pop eax
    mov [ebp-8128], eax
    pop eax
    mov [ebp-8132], eax
    pop eax
    mov [ebp-8136], eax
    mov [ebp-8112], esp
    push dword ptr [ebp-8136]
    push dword ptr [ebp-8132]
    push dword ptr [ebp-8128]
    and esp, -16
    call vfprintf
    mov esp, [ebp-8112]
    push eax
    add esp, 4
    push 0
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

    .globl ark_abort
ark_abort:
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
    jz .Lark_abort_0
    push dword ptr [ebp-48]
    jmp .Lark_abort_1
.Lark_abort_0:
    lea eax, [ark_str_2]
    push eax
.Lark_abort_1:
    lea eax, [ark_str_3]
    push eax
    mov eax, [stderr]
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
    call fprintf
    mov esp, [ebp-64]
    push eax
    add esp, 4
    push 1
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call exit
    mov esp, [ebp-64]
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

