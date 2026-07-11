# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz ""
ark_str_1:
    .asciz ""
    .data
    .globl ty_void
    .local ty_void
ty_void:
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_char
    .local ty_char
ty_char:
    .quad 1
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_short
    .local ty_short
ty_short:
    .quad 2
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_int
    .local ty_int
ty_int:
    .quad 3
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_long
    .local ty_long
ty_long:
    .quad 4
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_llong
    .local ty_llong
ty_llong:
    .quad 5
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_bool
    .local ty_bool
ty_bool:
    .quad 6
    .quad 4294967296
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_float
    .local ty_float
ty_float:
    .quad 7
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_double
    .local ty_double
ty_double:
    .quad 8
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_uchar
    .local ty_uchar
ty_uchar:
    .quad 1
    .quad 4294967296
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_ushort
    .local ty_ushort
ty_ushort:
    .quad 2
    .quad 4294967296
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_uint
    .local ty_uint
ty_uint:
    .quad 3
    .quad 4294967296
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_ulong
    .local ty_ulong
ty_ulong:
    .quad 4
    .quad 4294967296
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_ullong
    .local ty_ullong
ty_ullong:
    .quad 5
    .quad 4294967296
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl ty_wchar
    .local ty_wchar
ty_wchar:
    .quad 15
    .quad 4294967296
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .long 0
    .globl g_pack_align
    .local g_pack_align
g_pack_align:
    .long 0
    .globl g_ptr_size
    .local g_ptr_size
g_ptr_size:
    .long 4
    .text
    .globl type_void
type_void:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_void]
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

    .globl type_char
type_char:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_char]
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

    .globl type_short
type_short:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_short]
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

    .globl type_int
type_int:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_int]
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

    .globl type_long
type_long:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_long]
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

    .globl type_llong
type_llong:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_llong]
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

    .globl type_bool
type_bool:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_bool]
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

    .globl type_float
type_float:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_float]
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

    .globl type_double
type_double:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_double]
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

    .globl type_uchar
type_uchar:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_uchar]
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

    .globl type_ushort
type_ushort:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_ushort]
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

    .globl type_uint
type_uint:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_uint]
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

    .globl type_ulong
type_ulong:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_ulong]
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

    .globl type_ullong
type_ullong:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_ullong]
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

    .globl type_pointer
type_pointer:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 60
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
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 9
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
    push dword ptr [ebp-48]
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

    .globl type_qualified
type_qualified:
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
    jz .Ltype_qualified_0
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_qualified_1
.Ltype_qualified_0:
.Ltype_qualified_1:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_qualified_4
    push dword ptr [ebp-64]
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
    jmp .Ltype_qualified_5
.Ltype_qualified_4:
    push 0
.Ltype_qualified_5:
    pop eax
    test eax, eax
    jz .Ltype_qualified_2
    push dword ptr [ebp-48]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_qualified_3
.Ltype_qualified_2:
.Ltype_qualified_3:
    push 60
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-48]
    push dword ptr [ebp-72]
    pop edi
    pop esi
    mov ecx, 60
    rep movsb
    add esp, 4
    push dword ptr [ebp-72]
    push 48
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
    push 52
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

    .globl type_array
type_array:
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
    push 60
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
    push 10
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
    push dword ptr [ebp-48]
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

    .globl type_struct
type_struct:
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
    push 60
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
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Ltype_struct_0
    push 12
    jmp .Ltype_struct_1
.Ltype_struct_0:
    push 11
.Ltype_struct_1:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Ltype_struct_2
    push dword ptr [ebp-64]
    push 20
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
    jmp .Ltype_struct_3
.Ltype_struct_2:
.Ltype_struct_3:
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

    .globl type_enum
type_enum:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 60
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
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 14
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    jz .Ltype_enum_0
    push dword ptr [ebp-56]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
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
    jmp .Ltype_enum_1
.Ltype_enum_0:
.Ltype_enum_1:
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

    .globl type_func
type_func:
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
    push 60
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
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
    push dword ptr [ebp-80]
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
    push dword ptr [ebp-80]
    push 28
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
    push 32
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
    push 16
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

    .globl type_wchar
type_wchar:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ty_wchar]
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

    .globl type_complex
type_complex:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 60
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
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 16
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
    push dword ptr [ebp-48]
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

    .globl type_set_pack
type_set_pack:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    mov eax, [esp]
    push eax
    pop eax
    mov [g_pack_align], eax
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

    .globl type_get_pack
type_get_pack:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [g_pack_align]
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

    .globl type_struct_add_field
type_struct_add_field:
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
    push 24
    pop eax
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-128]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call type_align
    mov esp, [ebp-128]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call type_size
    mov esp, [ebp-128]
    push eax
    pop eax
    mov [ebp-88], eax
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
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-104], eax
    push 0
    pop eax
    mov [ebp-112], eax
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_0
    push 0
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Ltype_struct_add_field_1
.Ltype_struct_add_field_0:
.Ltype_struct_add_field_1:
    mov eax, [g_pack_align]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_2
    mov eax, [g_pack_align]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Ltype_struct_add_field_3
.Ltype_struct_add_field_2:
.Ltype_struct_add_field_3:
    push dword ptr [ebp-48]
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
    jz .Ltype_struct_add_field_4
    push 1
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Ltype_struct_add_field_5
.Ltype_struct_add_field_4:
.Ltype_struct_add_field_5:
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_8
    push dword ptr [ebp-80]
    push dword ptr [ebp-104]
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
    jmp .Ltype_struct_add_field_9
.Ltype_struct_add_field_8:
    push 0
.Ltype_struct_add_field_9:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_6
    push dword ptr [ebp-104]
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Ltype_struct_add_field_7
.Ltype_struct_add_field_6:
.Ltype_struct_add_field_7:
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_10
    push 1
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Ltype_struct_add_field_11
.Ltype_struct_add_field_10:
.Ltype_struct_add_field_11:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_16
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
    jmp .Ltype_struct_add_field_17
.Ltype_struct_add_field_16:
    push 0
.Ltype_struct_add_field_17:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_14
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
    jmp .Ltype_struct_add_field_15
.Ltype_struct_add_field_14:
    push 0
.Ltype_struct_add_field_15:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_12
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Ltype_struct_add_field_13
.Ltype_struct_add_field_12:
.Ltype_struct_add_field_13:
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_20
    push dword ptr [ebp-48]
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
    jmp .Ltype_struct_add_field_21
.Ltype_struct_add_field_20:
    push 0
.Ltype_struct_add_field_21:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_18
    push dword ptr [ebp-48]
    push 40
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
    jmp .Ltype_struct_add_field_19
.Ltype_struct_add_field_18:
.Ltype_struct_add_field_19:
    push dword ptr [ebp-96]
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_22
    push dword ptr [ebp-56]
    jmp .Ltype_struct_add_field_23
.Ltype_struct_add_field_22:
    lea eax, [ark_str_0]
    push eax
.Ltype_struct_add_field_23:
    pop eax
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-128]
    push eax
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
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 8
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
    push dword ptr [ebp-72]
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
    push dword ptr [ebp-72]
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
    push dword ptr [ebp-48]
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
    jz .Ltype_struct_add_field_24
    push dword ptr [ebp-48]
    push 24
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
    jmp .Ltype_struct_add_field_25
.Ltype_struct_add_field_24:
    push dword ptr [ebp-48]
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
    mov [ebp-120], eax
.Ltype_struct_add_field_26:
    push dword ptr [ebp-120]
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
    jz .Ltype_struct_add_field_27
    push dword ptr [ebp-120]
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
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Ltype_struct_add_field_26
.Ltype_struct_add_field_27:
    push dword ptr [ebp-120]
    push 20
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
.Ltype_struct_add_field_25:
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_28
    push dword ptr [ebp-112]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_32
    push dword ptr [ebp-88]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Ltype_struct_add_field_33
.Ltype_struct_add_field_32:
    push 0
.Ltype_struct_add_field_33:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_30
    push dword ptr [ebp-48]
    push 8
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
    jmp .Ltype_struct_add_field_31
.Ltype_struct_add_field_30:
.Ltype_struct_add_field_31:
    jmp .Ltype_struct_add_field_29
.Ltype_struct_add_field_28:
    push dword ptr [ebp-112]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_field_34
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-96]
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
    jmp .Ltype_struct_add_field_35
.Ltype_struct_add_field_34:
.Ltype_struct_add_field_35:
.Ltype_struct_add_field_29:
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

    .globl type_struct_add_bitfield
type_struct_add_bitfield:
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
    mov eax, [ebp+16]
    mov [ebp-64], eax
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call type_size
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push 8
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call type_align
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-104], eax
    push 0
    pop eax
    mov [ebp-120], eax
    mov eax, [g_pack_align]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_0
    mov eax, [g_pack_align]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Ltype_struct_add_bitfield_1
.Ltype_struct_add_bitfield_0:
.Ltype_struct_add_bitfield_1:
    push dword ptr [ebp-48]
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
    jz .Ltype_struct_add_bitfield_2
    push 1
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Ltype_struct_add_bitfield_3
.Ltype_struct_add_bitfield_2:
.Ltype_struct_add_bitfield_3:
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_6
    push dword ptr [ebp-96]
    push dword ptr [ebp-104]
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
    jmp .Ltype_struct_add_bitfield_7
.Ltype_struct_add_bitfield_6:
    push 0
.Ltype_struct_add_bitfield_7:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_4
    push dword ptr [ebp-104]
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Ltype_struct_add_bitfield_5
.Ltype_struct_add_bitfield_4:
.Ltype_struct_add_bitfield_5:
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_10
    push dword ptr [ebp-48]
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
    jmp .Ltype_struct_add_bitfield_11
.Ltype_struct_add_bitfield_10:
    push 0
.Ltype_struct_add_bitfield_11:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_8
    push dword ptr [ebp-48]
    push 40
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
    jmp .Ltype_struct_add_bitfield_9
.Ltype_struct_add_bitfield_8:
.Ltype_struct_add_bitfield_9:
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_12
    push 1
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Ltype_struct_add_bitfield_13
.Ltype_struct_add_bitfield_12:
.Ltype_struct_add_bitfield_13:
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
    jz .Ltype_struct_add_bitfield_14
    push dword ptr [ebp-48]
    push 56
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
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_struct_add_bitfield_15
.Ltype_struct_add_bitfield_14:
.Ltype_struct_add_bitfield_15:
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_16
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
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
    call type_struct_add_field
    mov esp, [ebp-160]
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_struct_add_bitfield_17
.Ltype_struct_add_bitfield_16:
.Ltype_struct_add_bitfield_17:
    push dword ptr [ebp-72]
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_18
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Ltype_struct_add_bitfield_19
.Ltype_struct_add_bitfield_18:
.Ltype_struct_add_bitfield_19:
    push dword ptr [ebp-48]
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
    jz .Ltype_struct_add_bitfield_20
    push dword ptr [ebp-48]
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
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
.Ltype_struct_add_bitfield_22:
    push dword ptr [ebp-120]
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
    jz .Ltype_struct_add_bitfield_23
    push dword ptr [ebp-120]
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
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Ltype_struct_add_bitfield_22
.Ltype_struct_add_bitfield_23:
    jmp .Ltype_struct_add_bitfield_21
.Ltype_struct_add_bitfield_20:
.Ltype_struct_add_bitfield_21:
    push dword ptr [ebp-120]
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_32
    push dword ptr [ebp-120]
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
    jmp .Ltype_struct_add_bitfield_33
.Ltype_struct_add_bitfield_32:
    push 0
.Ltype_struct_add_bitfield_33:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_30
    push dword ptr [ebp-120]
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
    jmp .Ltype_struct_add_bitfield_31
.Ltype_struct_add_bitfield_30:
    push 0
.Ltype_struct_add_bitfield_31:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_28
    push dword ptr [ebp-120]
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
    push dword ptr [ebp-120]
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
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
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
    jmp .Ltype_struct_add_bitfield_29
.Ltype_struct_add_bitfield_28:
    push 0
.Ltype_struct_add_bitfield_29:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_26
    push dword ptr [ebp-48]
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
    jmp .Ltype_struct_add_bitfield_27
.Ltype_struct_add_bitfield_26:
    push 0
.Ltype_struct_add_bitfield_27:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_24
    push dword ptr [ebp-120]
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
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-120]
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
    push dword ptr [ebp-120]
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
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Ltype_struct_add_bitfield_25
.Ltype_struct_add_bitfield_24:
    push dword ptr [ebp-48]
    push 56
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
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-128]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push 0
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_34
    push dword ptr [ebp-80]
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
    jz .Ltype_struct_add_bitfield_36
    push dword ptr [ebp-48]
    push 8
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
    jmp .Ltype_struct_add_bitfield_37
.Ltype_struct_add_bitfield_36:
.Ltype_struct_add_bitfield_37:
    jmp .Ltype_struct_add_bitfield_35
.Ltype_struct_add_bitfield_34:
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Ltype_struct_add_bitfield_35:
.Ltype_struct_add_bitfield_25:
    push 24
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Ltype_struct_add_bitfield_38
    push dword ptr [ebp-56]
    jmp .Ltype_struct_add_bitfield_39
.Ltype_struct_add_bitfield_38:
    lea eax, [ark_str_1]
    push eax
.Ltype_struct_add_bitfield_39:
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-160]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-112]
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
    push dword ptr [ebp-112]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-112]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-112]
    push 16
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
    push dword ptr [ebp-112]
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
    push dword ptr [ebp-48]
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
    jz .Ltype_struct_add_bitfield_40
    push dword ptr [ebp-48]
    push 24
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
    jmp .Ltype_struct_add_bitfield_41
.Ltype_struct_add_bitfield_40:
    push dword ptr [ebp-48]
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
    mov [ebp-144], eax
.Ltype_struct_add_bitfield_42:
    push dword ptr [ebp-144]
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
    jz .Ltype_struct_add_bitfield_43
    push dword ptr [ebp-144]
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
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    jmp .Ltype_struct_add_bitfield_42
.Ltype_struct_add_bitfield_43:
    push dword ptr [ebp-144]
    push 20
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
.Ltype_struct_add_bitfield_41:
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

    .globl type_struct_add_anonymous
type_struct_add_anonymous:
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
    push 1
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
    jnz .Ltype_struct_add_anonymous_2
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
    jmp .Ltype_struct_add_anonymous_3
.Ltype_struct_add_anonymous_2:
    push 1
.Ltype_struct_add_anonymous_3:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_anonymous_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_struct_add_anonymous_1
.Ltype_struct_add_anonymous_0:
.Ltype_struct_add_anonymous_1:
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call type_align
    mov esp, [ebp-112]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_anonymous_4
    push 1
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Ltype_struct_add_anonymous_5
.Ltype_struct_add_anonymous_4:
.Ltype_struct_add_anonymous_5:
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_anonymous_6
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Ltype_struct_add_anonymous_7
.Ltype_struct_add_anonymous_6:
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
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-64]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Ltype_struct_add_anonymous_7:
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call type_size
    mov esp, [ebp-112]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
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
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Ltype_struct_add_anonymous_8:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Ltype_struct_add_anonymous_9
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
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_struct_add_anonymous_13
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Ltype_struct_add_anonymous_14
.Ltype_struct_add_anonymous_13:
    push 1
.Ltype_struct_add_anonymous_14:
    pop eax
    test eax, eax
    jz .Ltype_struct_add_anonymous_11
    jmp .Ltype_struct_add_anonymous_10
    jmp .Ltype_struct_add_anonymous_12
.Ltype_struct_add_anonymous_11:
.Ltype_struct_add_anonymous_12:
    push 24
    pop eax
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-112]
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop eax
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-112]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    push 4
    pop ecx
    pop eax
    add eax, ecx
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    push 12
    pop ecx
    pop eax
    add eax, ecx
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-96]
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
    push dword ptr [ebp-48]
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
    jz .Ltype_struct_add_anonymous_15
    push dword ptr [ebp-48]
    push 24
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
    jmp .Ltype_struct_add_anonymous_16
.Ltype_struct_add_anonymous_15:
    push dword ptr [ebp-48]
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
    mov [ebp-104], eax
.Ltype_struct_add_anonymous_17:
    push dword ptr [ebp-104]
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
    jz .Ltype_struct_add_anonymous_18
    push dword ptr [ebp-104]
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
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Ltype_struct_add_anonymous_17
.Ltype_struct_add_anonymous_18:
    push dword ptr [ebp-104]
    push 20
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
.Ltype_struct_add_anonymous_16:
.Ltype_struct_add_anonymous_10:
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
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Ltype_struct_add_anonymous_8
.Ltype_struct_add_anonymous_9:
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_struct_add_anonymous_19
    push dword ptr [ebp-80]
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
    jz .Ltype_struct_add_anonymous_21
    push dword ptr [ebp-48]
    push 8
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
    jmp .Ltype_struct_add_anonymous_22
.Ltype_struct_add_anonymous_21:
.Ltype_struct_add_anonymous_22:
    jmp .Ltype_struct_add_anonymous_20
.Ltype_struct_add_anonymous_19:
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    push dword ptr [ebp-80]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Ltype_struct_add_anonymous_20:
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

    .globl type_set_ptr_size
type_set_ptr_size:
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
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_set_ptr_size_2
    push dword ptr [ebp-48]
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
    jmp .Ltype_set_ptr_size_3
.Ltype_set_ptr_size_2:
    push 1
.Ltype_set_ptr_size_3:
    pop eax
    test eax, eax
    jz .Ltype_set_ptr_size_0
    push dword ptr [ebp-48]
    mov eax, [esp]
    push eax
    pop eax
    mov [g_ptr_size], eax
    add esp, 4
    jmp .Ltype_set_ptr_size_1
.Ltype_set_ptr_size_0:
.Ltype_set_ptr_size_1:
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

    .globl type_size
type_size:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
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
    jz .Ltype_size_0
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_size_1
.Ltype_size_0:
.Ltype_size_1:
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_3
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_4
    push dword ptr [ebp-56]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_5
    push dword ptr [ebp-56]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_6
    push dword ptr [ebp-56]
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_7
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_8
    push dword ptr [ebp-56]
    push 5
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_9
    push dword ptr [ebp-56]
    push 7
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_10
    push dword ptr [ebp-56]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_11
    push dword ptr [ebp-56]
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_12
    push dword ptr [ebp-56]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_13
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_14
    push dword ptr [ebp-56]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_15
    push dword ptr [ebp-56]
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_16
    push dword ptr [ebp-56]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_17
    push dword ptr [ebp-56]
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_18
    push dword ptr [ebp-56]
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_size_19
    jmp .Ltype_size_2
.Ltype_size_3:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_4:
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_5:
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_6:
    push 2
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_7:
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_8:
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_9:
    push 8
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_10:
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_11:
    push 8
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_12:
    mov eax, [g_ptr_size]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_13:
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_14:
    push 2
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call type_size
    mov esp, [ebp-96]
    push eax
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_15:
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call type_size
    mov esp, [ebp-96]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_size_20
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
    jmp .Ltype_size_21
.Ltype_size_20:
    push 1
.Ltype_size_21:
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_16:
    push 1
    pop eax
    mov [ebp-64], eax
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
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Ltype_size_22:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Ltype_size_23
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
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call type_align
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_size_25
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Ltype_size_26
.Ltype_size_25:
.Ltype_size_26:
.Ltype_size_24:
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
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Ltype_size_22
.Ltype_size_23:
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_size_27
    push 1
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Ltype_size_28
.Ltype_size_27:
.Ltype_size_28:
    push dword ptr [ebp-48]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_size_31
    push dword ptr [ebp-48]
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
    push dword ptr [ebp-64]
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
    jmp .Ltype_size_32
.Ltype_size_31:
    push 0
.Ltype_size_32:
    pop eax
    test eax, eax
    jz .Ltype_size_29
    push dword ptr [ebp-48]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Ltype_size_30
.Ltype_size_29:
.Ltype_size_30:
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_17:
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
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_18:
    lea eax, [g_config]
    push eax
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
    add esp, 4
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_19:
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_size_2:
    push 4
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

    .globl type_align
type_align:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
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
    jz .Ltype_align_0
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_align_1
.Ltype_align_0:
.Ltype_align_1:
    push dword ptr [ebp-48]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_align_2
    push dword ptr [ebp-48]
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
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_align_3
.Ltype_align_2:
.Ltype_align_3:
    push dword ptr [ebp-48]
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
    jz .Ltype_align_4
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_align_5
.Ltype_align_4:
.Ltype_align_5:
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
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_7
    push dword ptr [ebp-56]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_8
    push dword ptr [ebp-56]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_9
    push dword ptr [ebp-56]
    push 5
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_10
    push dword ptr [ebp-56]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_11
    push dword ptr [ebp-56]
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_12
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_13
    push dword ptr [ebp-56]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_14
    push dword ptr [ebp-56]
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_15
    push dword ptr [ebp-56]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_align_16
    jmp .Ltype_align_17
.Ltype_align_7:
.Ltype_align_8:
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_align_9:
    push 2
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_align_10:
.Ltype_align_11:
    push 8
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_align_12:
    mov eax, [g_ptr_size]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_align_13:
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call type_align
    mov esp, [ebp-96]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_align_14:
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call type_align
    mov esp, [ebp-96]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_align_15:
.Ltype_align_16:
    push 1
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-48]
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
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Ltype_align_18:
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Ltype_align_19
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call type_align
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_align_21
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Ltype_align_22
.Ltype_align_21:
.Ltype_align_22:
.Ltype_align_20:
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Ltype_align_18
.Ltype_align_19:
    push dword ptr [ebp-64]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_align_17:
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltype_align_6:
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

    .globl type_equal
type_equal:
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
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_equal_2
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
    jmp .Ltype_equal_3
.Ltype_equal_2:
    push 1
.Ltype_equal_3:
    pop eax
    test eax, eax
    jz .Ltype_equal_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_equal_1
.Ltype_equal_0:
.Ltype_equal_1:
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
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_equal_4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_equal_5
.Ltype_equal_4:
.Ltype_equal_5:
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
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_equal_8
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
    jmp .Ltype_equal_9
.Ltype_equal_8:
    push 1
.Ltype_equal_9:
    pop eax
    test eax, eax
    jz .Ltype_equal_6
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
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call type_equal
    mov esp, [ebp-64]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_equal_7
.Ltype_equal_6:
.Ltype_equal_7:
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
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_equal_10
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
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call type_equal
    mov esp, [ebp-64]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_equal_11
.Ltype_equal_10:
.Ltype_equal_11:
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
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_equal_12
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_equal_13
.Ltype_equal_12:
.Ltype_equal_13:
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

    .globl type_is_integer
type_is_integer:
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
    jz .Ltype_is_integer_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_is_integer_1
.Ltype_is_integer_0:
.Ltype_is_integer_1:
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
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_is_integer_14
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
    push 2
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
    jmp .Ltype_is_integer_15
.Ltype_is_integer_14:
    push 1
.Ltype_is_integer_15:
    pop eax
    test eax, eax
    jnz .Ltype_is_integer_12
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
    push 3
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
    jmp .Ltype_is_integer_13
.Ltype_is_integer_12:
    push 1
.Ltype_is_integer_13:
    pop eax
    test eax, eax
    jnz .Ltype_is_integer_10
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
    jmp .Ltype_is_integer_11
.Ltype_is_integer_10:
    push 1
.Ltype_is_integer_11:
    pop eax
    test eax, eax
    jnz .Ltype_is_integer_8
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
    jmp .Ltype_is_integer_9
.Ltype_is_integer_8:
    push 1
.Ltype_is_integer_9:
    pop eax
    test eax, eax
    jnz .Ltype_is_integer_6
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
    push 6
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
    jmp .Ltype_is_integer_7
.Ltype_is_integer_6:
    push 1
.Ltype_is_integer_7:
    pop eax
    test eax, eax
    jnz .Ltype_is_integer_4
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
    push 14
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
    jmp .Ltype_is_integer_5
.Ltype_is_integer_4:
    push 1
.Ltype_is_integer_5:
    pop eax
    test eax, eax
    jnz .Ltype_is_integer_2
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
    jmp .Ltype_is_integer_3
.Ltype_is_integer_2:
    push 1
.Ltype_is_integer_3:
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

    .globl type_is_arith
type_is_arith:
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
    jz .Ltype_is_arith_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_is_arith_1
.Ltype_is_arith_0:
.Ltype_is_arith_1:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call type_is_integer
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_is_arith_4
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
    push 7
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
    jmp .Ltype_is_arith_5
.Ltype_is_arith_4:
    push 1
.Ltype_is_arith_5:
    pop eax
    test eax, eax
    jnz .Ltype_is_arith_2
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
    jmp .Ltype_is_arith_3
.Ltype_is_arith_2:
    push 1
.Ltype_is_arith_3:
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

    .globl type_is_scalar
type_is_scalar:
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
    jz .Ltype_is_scalar_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_is_scalar_1
.Ltype_is_scalar_0:
.Ltype_is_scalar_1:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call type_is_arith
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jnz .Ltype_is_scalar_2
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
    jmp .Ltype_is_scalar_3
.Ltype_is_scalar_2:
    push 1
.Ltype_is_scalar_3:
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

    .globl type_find_field
type_find_field:
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
    jnz .Ltype_find_field_2
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
    jmp .Ltype_find_field_3
.Ltype_find_field_2:
    push 1
.Ltype_find_field_3:
    pop eax
    test eax, eax
    jz .Ltype_find_field_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_find_field_1
.Ltype_find_field_0:
.Ltype_find_field_1:
    push dword ptr [ebp-48]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Ltype_find_field_4:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Ltype_find_field_5
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
    jz .Ltype_find_field_7
    push dword ptr [ebp-64]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_find_field_8
.Ltype_find_field_7:
.Ltype_find_field_8:
.Ltype_find_field_6:
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    jmp .Ltype_find_field_4
.Ltype_find_field_5:
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

