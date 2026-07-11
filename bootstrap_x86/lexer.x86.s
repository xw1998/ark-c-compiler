# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz "[lexer] line %d: unknown char '%c' (0x%02X)\n"
ark_str_1:
    .asciz "[parser] line %d: expected token kind %d but got %d\n"
ark_str_2:
    .asciz "EOF"
ark_str_3:
    .asciz "ident"
ark_str_4:
    .asciz "num"
ark_str_5:
    .asciz "str"
ark_str_6:
    .asciz "fconst"
ark_str_7:
    .asciz "tok"
    .data
    .globl g_keywords
    .local g_keywords
g_keywords:
    .quad 4302597737
    .quad 10508920931
    .quad 14569533302
    .quad 19150431602
    .quad 21474862697
    .quad 27471866981
    .quad 31883618423
    .quad 34367237990
    .quad 40288744034
    .quad 44903067491
    .quad 47244668772
    .quad 255322974323
    .quad 259433328492
    .quad 263845276019
    .quad 268057144949
    .quad 272217631846
    .quad 276529770340
    .quad 281042436703
    .quad 285404458851
    .quad 289397305206
    .quad 294011495794
    .quad 298121457257
    .quad 302600254579
    .quad 306644809829
    .quad 311107548513
    .quad 315300996466
    .quad 319798015091
    .quad 323991727733
    .quad 328253927013
    .quad 332414351732
    .quad 336709970291
    .quad 341255485299
    .quad 345299444067
    .quad 349526451556
    .quad 354057219943
    .quad 375614693215
    .quad 379558130529
    .quad 379892883295
    .quad 379892883295
    .quad 298205142879
    .quad 298205142879
    .quad 289632837471
    .quad 285336624991
    .quad 293759770463
    .quad 388534329183
    .quad 392761532255
    .quad 396839313247
    .quad 401066581855
    .quad 405361680223
    .quad 409840213855
    .quad 414269398879
    .quad 418481659743
    .quad 422775775071
    .quad 431332737887
    .quad 431365513055
    .quad 435426844511
    .quad 439839121247
    .quad 444200345439
    .quad 448646897503
    .quad 452823965535
    .quad 457102810975
    .quad 461413900127
    .quad 465708867423
    .quad 470003834719
    .quad 474298802015
    .quad 478779039583
    .quad 482955321183
    .quad 487033298783
    .quad 491512946527
    .quad 495790743391
    .quad 499917283167
    .quad 504145731423
    .quad 508507217759
    .quad 0
    .text
    .globl utf8_encode
utf8_encode:
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
    push 128
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lutf8_encode_0
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
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov byte ptr [eax], dl
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
    jmp .Lutf8_encode_1
.Lutf8_encode_0:
    push dword ptr [ebp-48]
    push 2048
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lutf8_encode_2
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
    push 192
    push dword ptr [ebp-48]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop ecx
    pop eax
    or eax, ecx
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
    push 128
    push dword ptr [ebp-48]
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push 2
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lutf8_encode_3
.Lutf8_encode_2:
    push dword ptr [ebp-48]
    push 65536
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lutf8_encode_4
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
    push 224
    push dword ptr [ebp-48]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop ecx
    pop eax
    or eax, ecx
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
    push 128
    push dword ptr [ebp-48]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
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
    push 128
    push dword ptr [ebp-48]
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push 3
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lutf8_encode_5
.Lutf8_encode_4:
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
    push 240
    push dword ptr [ebp-48]
    push 18
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop ecx
    pop eax
    or eax, ecx
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
    push 128
    push dword ptr [ebp-48]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
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
    push 128
    push dword ptr [ebp-48]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
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
    push 128
    push dword ptr [ebp-48]
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lutf8_encode_5:
.Lutf8_encode_3:
.Lutf8_encode_1:
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

    .globl lexer_read_token_with_pos
lexer_read_token_with_pos:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 380
    mov eax, [ebp+8]
    mov [ebp-328], eax
    mov eax, [ebp+12]
    mov [ebp-48], eax
.Llexer_read_token_with_pos_0:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_1
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_with_pos_6
    push dword ptr [ebp-112]
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
    jmp .Llexer_read_token_with_pos_7
.Llexer_read_token_with_pos_6:
    push 1
.Llexer_read_token_with_pos_7:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_with_pos_4
    push dword ptr [ebp-112]
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
    jmp .Llexer_read_token_with_pos_5
.Llexer_read_token_with_pos_4:
    push 1
.Llexer_read_token_with_pos_5:
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_2
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
    add esp, 4
    jmp .Llexer_read_token_with_pos_3
.Llexer_read_token_with_pos_2:
    push dword ptr [ebp-112]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_8
    push dword ptr [ebp-48]
    push 8
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
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_with_pos_9
.Llexer_read_token_with_pos_8:
    push dword ptr [ebp-112]
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_12
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
    jmp .Llexer_read_token_with_pos_13
.Llexer_read_token_with_pos_12:
    push 0
.Llexer_read_token_with_pos_13:
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_10
.Llexer_read_token_with_pos_14:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_16
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
    jmp .Llexer_read_token_with_pos_17
.Llexer_read_token_with_pos_16:
    push 0
.Llexer_read_token_with_pos_17:
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_15
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
    add esp, 4
    jmp .Llexer_read_token_with_pos_14
.Llexer_read_token_with_pos_15:
    jmp .Llexer_read_token_with_pos_11
.Llexer_read_token_with_pos_10:
    push dword ptr [ebp-112]
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_20
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
    jmp .Llexer_read_token_with_pos_21
.Llexer_read_token_with_pos_20:
    push 0
.Llexer_read_token_with_pos_21:
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_18
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Llexer_read_token_with_pos_22:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_24
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
    jz .Llexer_read_token_with_pos_26
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
    jmp .Llexer_read_token_with_pos_27
.Llexer_read_token_with_pos_26:
    push 0
.Llexer_read_token_with_pos_27:
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
    jmp .Llexer_read_token_with_pos_25
.Llexer_read_token_with_pos_24:
    push 0
.Llexer_read_token_with_pos_25:
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_23
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
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_28
    push dword ptr [ebp-48]
    push 8
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
    add esp, 4
    jmp .Llexer_read_token_with_pos_29
.Llexer_read_token_with_pos_28:
.Llexer_read_token_with_pos_29:
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
    add esp, 4
    jmp .Llexer_read_token_with_pos_22
.Llexer_read_token_with_pos_23:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_30
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Llexer_read_token_with_pos_31
.Llexer_read_token_with_pos_30:
.Llexer_read_token_with_pos_31:
    jmp .Llexer_read_token_with_pos_19
.Llexer_read_token_with_pos_18:
    jmp .Llexer_read_token_with_pos_1
.Llexer_read_token_with_pos_19:
.Llexer_read_token_with_pos_11:
.Llexer_read_token_with_pos_9:
.Llexer_read_token_with_pos_3:
    jmp .Llexer_read_token_with_pos_0
.Llexer_read_token_with_pos_1:
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
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    lea eax, [ebp-64]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call lexer_read_token
    mov esp, [ebp-128]
    push eax
    lea eax, [ebp-64]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    add esp, 4
    lea eax, [ebp-64]
    push eax
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
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_with_pos_32
    lea eax, [ebp-64]
    push eax
    push 32
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
    jmp .Llexer_read_token_with_pos_33
.Llexer_read_token_with_pos_32:
.Llexer_read_token_with_pos_33:
    lea eax, [ebp-64]
    push eax
    pop eax
    mov eax, [ebp-328]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    mov eax, [ebp-328]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    mov eax, [ebp-328]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl is_alpha
is_alpha:
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
    jz .Lis_alpha_4
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
    jmp .Lis_alpha_5
.Lis_alpha_4:
    push 0
.Lis_alpha_5:
    pop eax
    test eax, eax
    jnz .Lis_alpha_2
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
    jz .Lis_alpha_6
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
    jmp .Lis_alpha_7
.Lis_alpha_6:
    push 0
.Lis_alpha_7:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lis_alpha_3
.Lis_alpha_2:
    push 1
.Lis_alpha_3:
    pop eax
    test eax, eax
    jnz .Lis_alpha_0
    push dword ptr [ebp-48]
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
    jmp .Lis_alpha_1
.Lis_alpha_0:
    push 1
.Lis_alpha_1:
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

    .globl is_digit
is_digit:
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
    jz .Lis_digit_0
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
    jmp .Lis_digit_1
.Lis_digit_0:
    push 0
.Lis_digit_1:
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

    .globl is_alnum
is_alnum:
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call is_alpha
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jnz .Lis_alnum_0
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call is_digit
    mov esp, [ebp-64]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lis_alnum_1
.Lis_alnum_0:
    push 1
.Lis_alnum_1:
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

    .globl is_hex
is_hex:
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call is_digit
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jnz .Lis_hex_2
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
    jz .Lis_hex_4
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
    jmp .Lis_hex_5
.Lis_hex_4:
    push 0
.Lis_hex_5:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lis_hex_3
.Lis_hex_2:
    push 1
.Lis_hex_3:
    pop eax
    test eax, eax
    jnz .Lis_hex_0
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
    jz .Lis_hex_6
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
    jmp .Lis_hex_7
.Lis_hex_6:
    push 0
.Lis_hex_7:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lis_hex_1
.Lis_hex_0:
    push 1
.Lis_hex_1:
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

    .globl is_oct
is_oct:
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
    jz .Lis_oct_0
    push dword ptr [ebp-48]
    push 55
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
    jmp .Lis_oct_1
.Lis_oct_0:
    push 0
.Lis_oct_1:
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

    .globl is_ident_start
is_ident_start:
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call is_alpha
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lis_ident_start_0
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lis_ident_start_1
.Lis_ident_start_0:
.Lis_ident_start_1:
    push dword ptr [ebp-48]
    push 36
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lis_ident_start_4
    lea eax, [g_config]
    push eax
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lis_ident_start_5
.Lis_ident_start_4:
    push 0
.Lis_ident_start_5:
    pop eax
    test eax, eax
    jz .Lis_ident_start_2
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lis_ident_start_3
.Lis_ident_start_2:
.Lis_ident_start_3:
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

    .globl is_ident_char
is_ident_char:
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call is_alnum
    mov esp, [ebp-64]
    push eax
    pop eax
    test eax, eax
    jz .Lis_ident_char_0
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lis_ident_char_1
.Lis_ident_char_0:
.Lis_ident_char_1:
    push dword ptr [ebp-48]
    push 36
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lis_ident_char_4
    lea eax, [g_config]
    push eax
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lis_ident_char_5
.Lis_ident_char_4:
    push 0
.Lis_ident_char_5:
    pop eax
    test eax, eax
    jz .Lis_ident_char_2
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lis_ident_char_3
.Lis_ident_char_2:
.Lis_ident_char_3:
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

    .globl hex_val
hex_val:
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
    jz .Lhex_val_2
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
    jmp .Lhex_val_3
.Lhex_val_2:
    push 0
.Lhex_val_3:
    pop eax
    test eax, eax
    jz .Lhex_val_0
    push dword ptr [ebp-48]
    push 48
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lhex_val_1
.Lhex_val_0:
.Lhex_val_1:
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
    jz .Lhex_val_6
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
    jmp .Lhex_val_7
.Lhex_val_6:
    push 0
.Lhex_val_7:
    pop eax
    test eax, eax
    jz .Lhex_val_4
    push dword ptr [ebp-48]
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
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lhex_val_5
.Lhex_val_4:
.Lhex_val_5:
    push dword ptr [ebp-48]
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

    .globl make_token
make_token:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 364
    mov eax, [ebp+8]
    mov [ebp-312], eax
    mov eax, [ebp+12]
    mov [ebp-48], eax
    mov eax, [ebp+16]
    mov [ebp-56], eax
    lea eax, [ebp-64]
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
    lea eax, [ebp-64]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ebp-64]
    push eax
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
    lea eax, [ebp-64]
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
    lea eax, [ebp-64]
    push eax
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
    lea eax, [ebp-64]
    push eax
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
    lea eax, [ebp-64]
    push eax
    push 36
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
    lea eax, [ebp-64]
    push eax
    push 40
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
    lea eax, [ebp-64]
    push eax
    pop eax
    mov eax, [ebp-312]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    mov eax, [ebp-312]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    mov eax, [ebp-312]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl make_number
make_number:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 364
    mov eax, [ebp+8]
    mov [ebp-312], eax
    mov eax, [ebp+12]
    mov [ebp-48], eax
    mov eax, [ebp+16]
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 12
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    mov [ebp-112], esp
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call make_token
    mov esp, [ebp-112]
    push eax
    lea eax, [ebp-64]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-64]
    push eax
    push 8
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
    lea eax, [ebp-64]
    push eax
    pop eax
    mov eax, [ebp-312]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    mov eax, [ebp-312]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    mov eax, [ebp-312]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl make_ident
make_ident:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 380
    mov eax, [ebp+8]
    mov [ebp-328], eax
    mov eax, [ebp+12]
    mov [ebp-48], eax
    mov eax, [ebp+16]
    mov [ebp-56], eax
    mov eax, [ebp+20]
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 14
    pop eax
    mov [ebp-144], eax
    pop eax
    mov [ebp-148], eax
    mov [ebp-128], esp
    push dword ptr [ebp-148]
    push dword ptr [ebp-144]
    and esp, -16
    call make_token
    mov esp, [ebp-128]
    push eax
    lea eax, [ebp-72]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-72]
    push eax
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-144], eax
    pop eax
    mov [ebp-148], eax
    mov [ebp-128], esp
    push dword ptr [ebp-148]
    push dword ptr [ebp-144]
    and esp, -16
    call mem_strndup
    mov esp, [ebp-128]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ebp-72]
    push eax
    pop eax
    mov eax, [ebp-328]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    mov eax, [ebp-328]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    mov eax, [ebp-328]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl kw_eq
kw_eq:
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
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lkw_eq_0:
    push dword ptr [ebp-72]
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lkw_eq_1
    push dword ptr [ebp-48]
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
    push dword ptr [ebp-64]
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
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lkw_eq_3
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lkw_eq_4
.Lkw_eq_3:
.Lkw_eq_4:
    push dword ptr [ebp-64]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lkw_eq_5
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lkw_eq_6
.Lkw_eq_5:
.Lkw_eq_6:
.Lkw_eq_2:
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
    jmp .Lkw_eq_0
.Lkw_eq_1:
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
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

    .globl check_keyword
check_keyword:
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
    push dword ptr [ebp-64]
    add esp, 4
.Lcheck_keyword_0:
    lea eax, [g_keywords]
    push eax
    push dword ptr [ebp-64]
    push 8
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
    test eax, eax
    jz .Lcheck_keyword_1
    lea eax, [g_keywords]
    push eax
    push dword ptr [ebp-64]
    push 8
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
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
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
    call kw_eq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lcheck_keyword_3
    lea eax, [g_keywords]
    push eax
    push dword ptr [ebp-64]
    push 8
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
    jmp .Lcheck_keyword_4
.Lcheck_keyword_3:
.Lcheck_keyword_4:
.Lcheck_keyword_2:
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
    jmp .Lcheck_keyword_0
.Lcheck_keyword_1:
    push 1
    pop eax
    neg eax
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

    .globl skip_ws_and_comments
skip_ws_and_comments:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
.Lskip_ws_and_comments_0:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_1
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lskip_ws_and_comments_6
    push dword ptr [ebp-56]
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
    jmp .Lskip_ws_and_comments_7
.Lskip_ws_and_comments_6:
    push 1
.Lskip_ws_and_comments_7:
    pop eax
    test eax, eax
    jnz .Lskip_ws_and_comments_4
    push dword ptr [ebp-56]
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
    jmp .Lskip_ws_and_comments_5
.Lskip_ws_and_comments_4:
    push 1
.Lskip_ws_and_comments_5:
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_2
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
    add esp, 4
    jmp .Lskip_ws_and_comments_3
.Lskip_ws_and_comments_2:
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
    jz .Lskip_ws_and_comments_8
    push dword ptr [ebp-48]
    push 8
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
    add esp, 4
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
    add esp, 4
    jmp .Lskip_ws_and_comments_9
.Lskip_ws_and_comments_8:
    push dword ptr [ebp-56]
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_12
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
    jmp .Lskip_ws_and_comments_13
.Lskip_ws_and_comments_12:
    push 0
.Lskip_ws_and_comments_13:
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_10
.Lskip_ws_and_comments_14:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_16
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
    jmp .Lskip_ws_and_comments_17
.Lskip_ws_and_comments_16:
    push 0
.Lskip_ws_and_comments_17:
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_15
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
    add esp, 4
    jmp .Lskip_ws_and_comments_14
.Lskip_ws_and_comments_15:
    jmp .Lskip_ws_and_comments_11
.Lskip_ws_and_comments_10:
    push dword ptr [ebp-56]
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_20
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
    jmp .Lskip_ws_and_comments_21
.Lskip_ws_and_comments_20:
    push 0
.Lskip_ws_and_comments_21:
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_18
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lskip_ws_and_comments_22:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_24
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
    jz .Lskip_ws_and_comments_26
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
    jmp .Lskip_ws_and_comments_27
.Lskip_ws_and_comments_26:
    push 0
.Lskip_ws_and_comments_27:
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
    jmp .Lskip_ws_and_comments_25
.Lskip_ws_and_comments_24:
    push 0
.Lskip_ws_and_comments_25:
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_23
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
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_28
    push dword ptr [ebp-48]
    push 8
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
    add esp, 4
    jmp .Lskip_ws_and_comments_29
.Lskip_ws_and_comments_28:
.Lskip_ws_and_comments_29:
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
    add esp, 4
    jmp .Lskip_ws_and_comments_22
.Lskip_ws_and_comments_23:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lskip_ws_and_comments_30
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lskip_ws_and_comments_31
.Lskip_ws_and_comments_30:
.Lskip_ws_and_comments_31:
    jmp .Lskip_ws_and_comments_19
.Lskip_ws_and_comments_18:
    jmp .Lskip_ws_and_comments_1
.Lskip_ws_and_comments_19:
.Lskip_ws_and_comments_11:
.Lskip_ws_and_comments_9:
.Lskip_ws_and_comments_3:
    jmp .Lskip_ws_and_comments_0
.Lskip_ws_and_comments_1:
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

    .globl read_escape
read_escape:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 120
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_escape_0
    push dword ptr [ebp-48]
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
    add esp, 4
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lread_escape_2:
    push dword ptr [ebp-48]
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call is_hex
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lread_escape_3
    push dword ptr [ebp-64]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-48]
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call hex_val
    mov esp, [ebp-80]
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
    add esp, 4
    jmp .Lread_escape_2
.Lread_escape_3:
    push dword ptr [ebp-64]
    push 255
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lread_escape_1
.Lread_escape_0:
.Lread_escape_1:
    push dword ptr [ebp-56]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_escape_6
    push dword ptr [ebp-56]
    push 55
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
    jmp .Lread_escape_7
.Lread_escape_6:
    push 0
.Lread_escape_7:
    pop eax
    test eax, eax
    jz .Lread_escape_4
    push 0
    pop eax
    mov [ebp-72], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lread_escape_8:
    push dword ptr [ebp-72]
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lread_escape_10
    push dword ptr [ebp-48]
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call is_oct
    mov esp, [ebp-80]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lread_escape_11
.Lread_escape_10:
    push 0
.Lread_escape_11:
    pop eax
    test eax, eax
    jz .Lread_escape_9
    push dword ptr [ebp-64]
    push 8
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-48]
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
    add esp, 4
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
    jmp .Lread_escape_8
.Lread_escape_9:
    push dword ptr [ebp-64]
    push 255
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lread_escape_5
.Lread_escape_4:
.Lread_escape_5:
    push dword ptr [ebp-48]
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
    add esp, 4
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 110
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_13
    push dword ptr [ebp-72]
    push 116
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_14
    push dword ptr [ebp-72]
    push 114
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_15
    push dword ptr [ebp-72]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_16
    push dword ptr [ebp-72]
    push 39
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_17
    push dword ptr [ebp-72]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_18
    push dword ptr [ebp-72]
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_19
    push dword ptr [ebp-72]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_20
    push dword ptr [ebp-72]
    push 98
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_21
    push dword ptr [ebp-72]
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_22
    push dword ptr [ebp-72]
    push 118
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_23
    push dword ptr [ebp-72]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lread_escape_24
    jmp .Lread_escape_25
.Lread_escape_13:
    push 10
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_14:
    push 9
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_15:
    push 13
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_16:
    push 92
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_17:
    push 39
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_18:
    push 34
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_19:
    push 63
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_20:
    push 7
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_21:
    push 8
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_22:
    push 12
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_23:
    push 11
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_24:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_25:
    push dword ptr [ebp-56]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lread_escape_12:
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

    .globl lexer_read_token
lexer_read_token:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 556
    mov eax, [ebp+8]
    mov [ebp-504], eax
    mov eax, [ebp+12]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call skip_ws_and_comments
    mov esp, [ebp-304]
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
    mov [ebp-56], eax
    push dword ptr [ebp-56]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
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
    jz .Llexer_read_token_0
    lea eax, [ebp-80]
    push eax
    push dword ptr [ebp-64]
    push 0
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    lea eax, [ebp-80]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    add esp, 4
    lea eax, [ebp-80]
    push eax
    push 32
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
    lea eax, [ebp-80]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_1
.Llexer_read_token_0:
.Llexer_read_token_1:
    lea eax, [g_config]
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
    jz .Llexer_read_token_6
    push dword ptr [ebp-72]
    push 76
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
    jmp .Llexer_read_token_7
.Llexer_read_token_6:
    push 0
.Llexer_read_token_7:
    pop eax
    test eax, eax
    jz .Llexer_read_token_4
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
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_8
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
    push 39
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
    jmp .Llexer_read_token_9
.Llexer_read_token_8:
    push 1
.Llexer_read_token_9:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llexer_read_token_5
.Llexer_read_token_4:
    push 0
.Llexer_read_token_5:
    pop eax
    test eax, eax
    jz .Llexer_read_token_2
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
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_10
    push dword ptr [ebp-64]
    push 13
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    lea eax, [ebp-128]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    push 32
    pop eax
    mov [ebp-176], eax
    push 0
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-176]
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-192], eax
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Llexer_read_token_12:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_14
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
    movsx eax, byte ptr [eax]
    push eax
    push 34
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
    jmp .Llexer_read_token_15
.Llexer_read_token_14:
    push 0
.Llexer_read_token_15:
    pop eax
    test eax, eax
    jz .Llexer_read_token_13
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
    movsx eax, byte ptr [eax]
    push eax
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_18
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
    jmp .Llexer_read_token_19
.Llexer_read_token_18:
    push 0
.Llexer_read_token_19:
    pop eax
    test eax, eax
    jz .Llexer_read_token_16
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
    add esp, 4
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call read_escape
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
    jmp .Llexer_read_token_17
.Llexer_read_token_16:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
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
    add esp, 4
.Llexer_read_token_17:
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_20
    push dword ptr [ebp-176]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    push dword ptr [ebp-176]
    push dword ptr [ebp-192]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    mov [ebp-304], esp
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    add esp, 4
    push dword ptr [ebp-208]
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Llexer_read_token_21
.Llexer_read_token_20:
.Llexer_read_token_21:
    push dword ptr [ebp-192]
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-200]
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Llexer_read_token_12
.Llexer_read_token_13:
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
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_22
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
    add esp, 4
    jmp .Llexer_read_token_23
.Llexer_read_token_22:
.Llexer_read_token_23:
    push dword ptr [ebp-192]
    push dword ptr [ebp-184]
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
    push 24
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
    lea eax, [ebp-128]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
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
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ebp-128]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_11
.Llexer_read_token_10:
    push 0
    pop eax
    mov [ebp-128], eax
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_24
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
    add esp, 4
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call read_escape
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Llexer_read_token_25
.Llexer_read_token_24:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_26
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_27
.Llexer_read_token_26:
.Llexer_read_token_27:
.Llexer_read_token_25:
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
    movsx eax, byte ptr [eax]
    push eax
    push 39
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_28
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
    add esp, 4
    jmp .Llexer_read_token_29
.Llexer_read_token_28:
.Llexer_read_token_29:
    push dword ptr [ebp-64]
    push dword ptr [ebp-128]
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
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_number
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_11:
    jmp .Llexer_read_token_3
.Llexer_read_token_2:
.Llexer_read_token_3:
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_ident_start
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_32
    push dword ptr [ebp-72]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_34
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
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_36
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
    push 85
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
    jmp .Llexer_read_token_37
.Llexer_read_token_36:
    push 1
.Llexer_read_token_37:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llexer_read_token_35
.Llexer_read_token_34:
    push 0
.Llexer_read_token_35:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llexer_read_token_33
.Llexer_read_token_32:
    push 1
.Llexer_read_token_33:
    pop eax
    test eax, eax
    jz .Llexer_read_token_30
    push 32
    pop eax
    mov [ebp-136], eax
    push 0
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-136]
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-72]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_38
    jmp .Llexer_read_token_39
.Llexer_read_token_38:
    push dword ptr [ebp-128]
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
    push dword ptr [ebp-72]
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
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
    add esp, 4
.Llexer_read_token_39:
.Llexer_read_token_40:
    push 1
    pop eax
    test eax, eax
    jz .Llexer_read_token_41
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_ident_char
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_42
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_44
    push dword ptr [ebp-136]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    mov [ebp-304], esp
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-168]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Llexer_read_token_45
.Llexer_read_token_44:
.Llexer_read_token_45:
    push dword ptr [ebp-128]
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
    push dword ptr [ebp-160]
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_43
.Llexer_read_token_42:
    push dword ptr [ebp-160]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_48
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
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_50
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
    push 85
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
    jmp .Llexer_read_token_51
.Llexer_read_token_50:
    push 1
.Llexer_read_token_51:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llexer_read_token_49
.Llexer_read_token_48:
    push 0
.Llexer_read_token_49:
    pop eax
    test eax, eax
    jz .Llexer_read_token_46
    push 0
    pop eax
    mov [ebp-168], eax
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
    mov [ebp-192], eax
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-192]
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_52
    push 4
    jmp .Llexer_read_token_53
.Llexer_read_token_52:
    push 8
.Llexer_read_token_53:
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    push 0
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
.Llexer_read_token_54:
    push dword ptr [ebp-184]
    push dword ptr [ebp-176]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_55
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
    push dword ptr [ebp-184]
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
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_hex
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_57
    jmp .Llexer_read_token_55
    jmp .Llexer_read_token_58
.Llexer_read_token_57:
.Llexer_read_token_58:
    push dword ptr [ebp-168]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
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
    push dword ptr [ebp-184]
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
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call hex_val
    mov esp, [ebp-304]
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
.Llexer_read_token_56:
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
    jmp .Llexer_read_token_54
.Llexer_read_token_55:
    push dword ptr [ebp-184]
    push dword ptr [ebp-176]
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_59
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
    push dword ptr [ebp-176]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-168]
    push 128
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_61
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_63
    push dword ptr [ebp-136]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    mov [ebp-304], esp
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-200]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Llexer_read_token_64
.Llexer_read_token_63:
.Llexer_read_token_64:
    push dword ptr [ebp-128]
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
    push dword ptr [ebp-168]
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Llexer_read_token_62
.Llexer_read_token_61:
    push dword ptr [ebp-168]
    push 2048
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_65
    push dword ptr [ebp-144]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_67
    push dword ptr [ebp-136]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    mov [ebp-304], esp
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-200]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Llexer_read_token_68
.Llexer_read_token_67:
.Llexer_read_token_68:
    push dword ptr [ebp-128]
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
    push 192
    push dword ptr [ebp-168]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-128]
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
    push 128
    push dword ptr [ebp-168]
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Llexer_read_token_66
.Llexer_read_token_65:
    push dword ptr [ebp-168]
    push 65536
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_69
    push dword ptr [ebp-144]
    push 3
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_71
    push dword ptr [ebp-136]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    mov [ebp-304], esp
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-200]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Llexer_read_token_72
.Llexer_read_token_71:
.Llexer_read_token_72:
    push dword ptr [ebp-128]
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
    push 224
    push dword ptr [ebp-168]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-128]
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
    push 128
    push dword ptr [ebp-168]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-128]
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
    push 128
    push dword ptr [ebp-168]
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Llexer_read_token_70
.Llexer_read_token_69:
    push dword ptr [ebp-144]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_73
    push dword ptr [ebp-136]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    mov [ebp-304], esp
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-200]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Llexer_read_token_74
.Llexer_read_token_73:
.Llexer_read_token_74:
    push dword ptr [ebp-128]
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
    push 240
    push dword ptr [ebp-168]
    push 18
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-128]
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
    push 128
    push dword ptr [ebp-168]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-128]
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
    push 128
    push dword ptr [ebp-168]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-128]
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
    push 128
    push dword ptr [ebp-168]
    push 63
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Llexer_read_token_70:
.Llexer_read_token_66:
.Llexer_read_token_62:
    jmp .Llexer_read_token_60
.Llexer_read_token_59:
    push dword ptr [ebp-144]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-184]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_75
    push dword ptr [ebp-136]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-184]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    mov [ebp-304], esp
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-200]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Llexer_read_token_76
.Llexer_read_token_75:
.Llexer_read_token_76:
    push dword ptr [ebp-128]
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
    push 92
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-128]
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
    push dword ptr [ebp-192]
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push 0
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
.Llexer_read_token_77:
    push dword ptr [ebp-200]
    push dword ptr [ebp-184]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_78
    push dword ptr [ebp-128]
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
    push dword ptr [ebp-200]
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
.Llexer_read_token_79:
    push dword ptr [ebp-200]
    push dword ptr [ebp-200]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    add esp, 4
    jmp .Llexer_read_token_77
.Llexer_read_token_78:
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
    push dword ptr [ebp-184]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Llexer_read_token_60:
    jmp .Llexer_read_token_47
.Llexer_read_token_46:
    jmp .Llexer_read_token_41
.Llexer_read_token_47:
.Llexer_read_token_43:
    jmp .Llexer_read_token_40
.Llexer_read_token_41:
    push dword ptr [ebp-128]
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
    push dword ptr [ebp-144]
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call check_keyword
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_80
    push dword ptr [ebp-64]
    push dword ptr [ebp-152]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    lea eax, [ebp-160]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-160]
    push eax
    push 32
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
    lea eax, [ebp-160]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_81
.Llexer_read_token_80:
.Llexer_read_token_81:
    push dword ptr [ebp-64]
    push 14
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    lea eax, [ebp-160]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-160]
    push eax
    push 24
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
    lea eax, [ebp-160]
    push eax
    push 32
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
    lea eax, [ebp-160]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_31
.Llexer_read_token_30:
.Llexer_read_token_31:
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_digit
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_84
    push dword ptr [ebp-72]
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_86
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
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_digit
    mov esp, [ebp-304]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llexer_read_token_87
.Llexer_read_token_86:
    push 0
.Llexer_read_token_87:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llexer_read_token_85
.Llexer_read_token_84:
    push 1
.Llexer_read_token_85:
    pop eax
    test eax, eax
    jz .Llexer_read_token_82
    push 0
    pop eax
    mov [ebp-128], eax
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
    mov [ebp-136], eax
    mov eax, 0
    push eax
    mov eax, 0
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-72]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_90
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
    jnz .Llexer_read_token_92
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
    jmp .Llexer_read_token_93
.Llexer_read_token_92:
    push 1
.Llexer_read_token_93:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llexer_read_token_91
.Llexer_read_token_90:
    push 0
.Llexer_read_token_91:
    pop eax
    test eax, eax
    jz .Llexer_read_token_88
    push 0
    pop eax
    mov [ebp-160], eax
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
    mov [ebp-168], eax
    mov eax, 0
    push eax
    mov eax, 0
    push eax
    pop eax
    mov [ebp-176], eax
    mov eax, 1072693248
    push eax
    mov eax, 0
    push eax
    pop eax
    mov [ebp-184], eax
    push 0
    pop eax
    mov [ebp-192], eax
    push 0
    pop eax
    mov [ebp-200], eax
    push 0
    pop eax
    mov [ebp-208], eax
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Llexer_read_token_94:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_hex
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_95
    push dword ptr [ebp-168]
    push 16
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
    imul eax, ecx
    push 0
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
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call hex_val
    mov esp, [ebp-304]
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
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_94
.Llexer_read_token_95:
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
    jz .Llexer_read_token_96
    push 1
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
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
    add esp, 4
.Llexer_read_token_98:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_hex
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_99
    push dword ptr [ebp-176]
    mov eax, 1076887552
    push eax
    mov eax, 0
    push eax
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    mulsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call hex_val
    mov esp, [ebp-304]
    push eax
    pop eax
    cvtsi2sd xmm0, eax
    sub esp, 8
    movq [esp], xmm0
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    addsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    add esp, 4
    push dword ptr [ebp-184]
    mov eax, 1076887552
    push eax
    mov eax, 0
    push eax
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    mulsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_98
.Llexer_read_token_99:
    jmp .Llexer_read_token_97
.Llexer_read_token_96:
.Llexer_read_token_97:
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
    movsx eax, byte ptr [eax]
    push eax
    push 112
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_102
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
    jmp .Llexer_read_token_103
.Llexer_read_token_102:
    push 1
.Llexer_read_token_103:
    pop eax
    test eax, eax
    jz .Llexer_read_token_100
    push 1
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
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
    add esp, 4
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
    jz .Llexer_read_token_104
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
    add esp, 4
    jmp .Llexer_read_token_105
.Llexer_read_token_104:
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
    movsx eax, byte ptr [eax]
    push eax
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_106
    push 1
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_107
.Llexer_read_token_106:
.Llexer_read_token_107:
.Llexer_read_token_105:
.Llexer_read_token_108:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_digit
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_109
    push dword ptr [ebp-200]
    push 10
    pop ecx
    pop eax
    imul eax, ecx
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
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_108
.Llexer_read_token_109:
    push 1
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    add esp, 4
    jmp .Llexer_read_token_101
.Llexer_read_token_100:
.Llexer_read_token_101:
    push dword ptr [ebp-160]
    pop eax
    test eax, eax
    jz .Llexer_read_token_110
    mov eax, 1072693248
    push eax
    mov eax, 0
    push eax
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-168]
    pop eax
    add esp, 4
    cvtsi2sd xmm0, eax
    sub esp, 8
    movq [esp], xmm0
    push dword ptr [ebp-176]
    push dword ptr [ebp-184]
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    divsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    addsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
    add esp, 4
    push 0
    pop eax
    mov [ebp-232], eax
    push dword ptr [ebp-232]
    add esp, 4
.Llexer_read_token_112:
    push dword ptr [ebp-232]
    push dword ptr [ebp-200]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_113
    push dword ptr [ebp-224]
    mov eax, 1073741824
    push eax
    mov eax, 0
    push eax
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    mulsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
    add esp, 4
.Llexer_read_token_114:
    push dword ptr [ebp-232]
    push dword ptr [ebp-232]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-232], eax
    add esp, 4
    jmp .Llexer_read_token_112
.Llexer_read_token_113:
    push dword ptr [ebp-208]
    pop eax
    test eax, eax
    jz .Llexer_read_token_115
    push dword ptr [ebp-192]
    pop eax
    test eax, eax
    jz .Llexer_read_token_117
    push dword ptr [ebp-216]
    push dword ptr [ebp-224]
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    divsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
    add esp, 4
    jmp .Llexer_read_token_118
.Llexer_read_token_117:
    push dword ptr [ebp-216]
    push dword ptr [ebp-224]
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    mulsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
    add esp, 4
.Llexer_read_token_118:
    jmp .Llexer_read_token_116
.Llexer_read_token_115:
.Llexer_read_token_116:
    push 0
    pop eax
    mov [ebp-240], eax
.Llexer_read_token_119:
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
    movsx eax, byte ptr [eax]
    push eax
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_125
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
    jmp .Llexer_read_token_126
.Llexer_read_token_125:
    push 1
.Llexer_read_token_126:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_123
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
    movsx eax, byte ptr [eax]
    push eax
    push 108
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
    jmp .Llexer_read_token_124
.Llexer_read_token_123:
    push 1
.Llexer_read_token_124:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_121
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
    movsx eax, byte ptr [eax]
    push eax
    push 76
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
    jmp .Llexer_read_token_122
.Llexer_read_token_121:
    push 1
.Llexer_read_token_122:
    pop eax
    test eax, eax
    jz .Llexer_read_token_120
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
    movsx eax, byte ptr [eax]
    push eax
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_129
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
    jmp .Llexer_read_token_130
.Llexer_read_token_129:
    push 1
.Llexer_read_token_130:
    pop eax
    test eax, eax
    jz .Llexer_read_token_127
    push 1
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-240]
    add esp, 4
    jmp .Llexer_read_token_128
.Llexer_read_token_127:
.Llexer_read_token_128:
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
    add esp, 4
    jmp .Llexer_read_token_119
.Llexer_read_token_120:
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
    movsx eax, byte ptr [eax]
    push eax
    push 105
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_137
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
    movsx eax, byte ptr [eax]
    push eax
    push 73
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
    jmp .Llexer_read_token_138
.Llexer_read_token_137:
    push 1
.Llexer_read_token_138:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_135
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
    movsx eax, byte ptr [eax]
    push eax
    push 106
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
    jmp .Llexer_read_token_136
.Llexer_read_token_135:
    push 1
.Llexer_read_token_136:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_133
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
    movsx eax, byte ptr [eax]
    push eax
    push 74
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
    jmp .Llexer_read_token_134
.Llexer_read_token_133:
    push 1
.Llexer_read_token_134:
    pop eax
    test eax, eax
    jz .Llexer_read_token_131
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
    add esp, 4
    push dword ptr [ebp-64]
    push 83
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    lea eax, [ebp-248]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-248]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-216]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ebp-248]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-216]
    movq xmm0, [esp]
    add esp, 8
    cvttsd2si eax, xmm0
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
    lea eax, [ebp-248]
    push eax
    push 36
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
    lea eax, [ebp-248]
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-240]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ebp-248]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_132
.Llexer_read_token_131:
.Llexer_read_token_132:
    push dword ptr [ebp-64]
    push 83
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    lea eax, [ebp-248]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-248]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-216]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ebp-248]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-216]
    movq xmm0, [esp]
    add esp, 8
    cvttsd2si eax, xmm0
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
    lea eax, [ebp-248]
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-240]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ebp-248]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_111
.Llexer_read_token_110:
.Llexer_read_token_111:
    push dword ptr [ebp-168]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    add esp, 4
.Llexer_read_token_139:
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
    movsx eax, byte ptr [eax]
    push eax
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_145
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
    movsx eax, byte ptr [eax]
    push eax
    push 85
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
    jmp .Llexer_read_token_146
.Llexer_read_token_145:
    push 1
.Llexer_read_token_146:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_143
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
    movsx eax, byte ptr [eax]
    push eax
    push 108
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
    jmp .Llexer_read_token_144
.Llexer_read_token_143:
    push 1
.Llexer_read_token_144:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_141
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
    movsx eax, byte ptr [eax]
    push eax
    push 76
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
    jmp .Llexer_read_token_142
.Llexer_read_token_141:
    push 1
.Llexer_read_token_142:
    pop eax
    test eax, eax
    jz .Llexer_read_token_140
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
    add esp, 4
    jmp .Llexer_read_token_139
.Llexer_read_token_140:
    push dword ptr [ebp-64]
    push dword ptr [ebp-136]
    # unknown IR op: CDECL64
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_number
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_89
.Llexer_read_token_88:
.Llexer_read_token_89:
    push dword ptr [ebp-72]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_149
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
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_oct
    mov esp, [ebp-304]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llexer_read_token_150
.Llexer_read_token_149:
    push 0
.Llexer_read_token_150:
    pop eax
    test eax, eax
    jz .Llexer_read_token_147
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
    add esp, 4
.Llexer_read_token_151:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_oct
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_152
    push dword ptr [ebp-136]
    push 8
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
    imul eax, ecx
    push 0
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
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_151
.Llexer_read_token_152:
.Llexer_read_token_153:
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
    movsx eax, byte ptr [eax]
    push eax
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_159
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
    movsx eax, byte ptr [eax]
    push eax
    push 85
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
    jmp .Llexer_read_token_160
.Llexer_read_token_159:
    push 1
.Llexer_read_token_160:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_157
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
    movsx eax, byte ptr [eax]
    push eax
    push 108
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
    jmp .Llexer_read_token_158
.Llexer_read_token_157:
    push 1
.Llexer_read_token_158:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_155
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
    movsx eax, byte ptr [eax]
    push eax
    push 76
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
    jmp .Llexer_read_token_156
.Llexer_read_token_155:
    push 1
.Llexer_read_token_156:
    pop eax
    test eax, eax
    jz .Llexer_read_token_154
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
    add esp, 4
    jmp .Llexer_read_token_153
.Llexer_read_token_154:
    push dword ptr [ebp-64]
    push dword ptr [ebp-136]
    # unknown IR op: CDECL64
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_number
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_148
.Llexer_read_token_147:
.Llexer_read_token_148:
.Llexer_read_token_161:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_digit
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_162
    push dword ptr [ebp-136]
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
    imul eax, ecx
    push 0
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
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_161
.Llexer_read_token_162:
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
    jz .Llexer_read_token_163
    push 1
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
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
    add esp, 4
.Llexer_read_token_165:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_digit
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_166
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
    add esp, 4
    jmp .Llexer_read_token_165
.Llexer_read_token_166:
    jmp .Llexer_read_token_164
.Llexer_read_token_163:
.Llexer_read_token_164:
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
    movsx eax, byte ptr [eax]
    push eax
    push 101
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_169
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
    movsx eax, byte ptr [eax]
    push eax
    push 69
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
    jmp .Llexer_read_token_170
.Llexer_read_token_169:
    push 1
.Llexer_read_token_170:
    pop eax
    test eax, eax
    jz .Llexer_read_token_167
    push 1
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
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
    add esp, 4
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
    jnz .Llexer_read_token_173
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
    movsx eax, byte ptr [eax]
    push eax
    push 45
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
    jmp .Llexer_read_token_174
.Llexer_read_token_173:
    push 1
.Llexer_read_token_174:
    pop eax
    test eax, eax
    jz .Llexer_read_token_171
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
    add esp, 4
    jmp .Llexer_read_token_172
.Llexer_read_token_171:
.Llexer_read_token_172:
.Llexer_read_token_175:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_digit
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_176
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
    add esp, 4
    jmp .Llexer_read_token_175
.Llexer_read_token_176:
    jmp .Llexer_read_token_168
.Llexer_read_token_167:
.Llexer_read_token_168:
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Llexer_read_token_177
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-152], eax
    mov eax, 1072693248
    push eax
    mov eax, 0
    push eax
    pop eax
    mov [ebp-160], eax
    mov eax, 0
    push eax
    mov eax, 0
    push eax
    pop eax
    mov [ebp-168], eax
    mov eax, 0
    push eax
    mov eax, 0
    push eax
    pop eax
    mov [ebp-176], eax
    mov eax, 1072693248
    push eax
    mov eax, 0
    push eax
    pop eax
    mov [ebp-184], eax
    push 0
    pop eax
    mov [ebp-192], eax
    push 0
    pop eax
    mov [ebp-200], eax
    push 0
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_179
    mov eax, 1072693248
    push eax
    mov eax, 0
    push eax
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
    add esp, 4
    push dword ptr [ebp-152]
    push dword ptr [ebp-152]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-152], eax
    add esp, 4
    jmp .Llexer_read_token_180
.Llexer_read_token_179:
.Llexer_read_token_180:
.Llexer_read_token_181:
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_digit
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_182
    push dword ptr [ebp-168]
    mov eax, 1076101120
    push eax
    mov eax, 0
    push eax
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    mulsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    push dword ptr [ebp-152]
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
    pop eax
    cvtsi2sd xmm0, eax
    sub esp, 8
    movq [esp], xmm0
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    addsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    add esp, 4
    push dword ptr [ebp-152]
    push dword ptr [ebp-152]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-152], eax
    add esp, 4
    jmp .Llexer_read_token_181
.Llexer_read_token_182:
    push dword ptr [ebp-152]
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
    jz .Llexer_read_token_183
    push dword ptr [ebp-152]
    push dword ptr [ebp-152]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-152], eax
    add esp, 4
.Llexer_read_token_185:
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_digit
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_186
    push dword ptr [ebp-176]
    mov eax, 1076101120
    push eax
    mov eax, 0
    push eax
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    mulsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    push dword ptr [ebp-152]
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
    pop eax
    cvtsi2sd xmm0, eax
    sub esp, 8
    movq [esp], xmm0
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    addsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    add esp, 4
    push dword ptr [ebp-184]
    mov eax, 1076101120
    push eax
    mov eax, 0
    push eax
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    mulsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    add esp, 4
    push dword ptr [ebp-152]
    push dword ptr [ebp-152]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-152], eax
    add esp, 4
    jmp .Llexer_read_token_185
.Llexer_read_token_186:
    jmp .Llexer_read_token_184
.Llexer_read_token_183:
.Llexer_read_token_184:
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 101
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_189
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 69
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
    jmp .Llexer_read_token_190
.Llexer_read_token_189:
    push 1
.Llexer_read_token_190:
    pop eax
    test eax, eax
    jz .Llexer_read_token_187
    push 1
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    add esp, 4
    push dword ptr [ebp-152]
    push dword ptr [ebp-152]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-152], eax
    add esp, 4
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_191
    push 1
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
    push dword ptr [ebp-152]
    push dword ptr [ebp-152]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-152], eax
    add esp, 4
    jmp .Llexer_read_token_192
.Llexer_read_token_191:
    push dword ptr [ebp-152]
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
    jz .Llexer_read_token_193
    push dword ptr [ebp-152]
    push dword ptr [ebp-152]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-152], eax
    add esp, 4
    jmp .Llexer_read_token_194
.Llexer_read_token_193:
.Llexer_read_token_194:
.Llexer_read_token_192:
.Llexer_read_token_195:
    push dword ptr [ebp-152]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_digit
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_196
    push dword ptr [ebp-208]
    push 10
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-152]
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
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    add esp, 4
    push dword ptr [ebp-152]
    push dword ptr [ebp-152]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-152], eax
    add esp, 4
    jmp .Llexer_read_token_195
.Llexer_read_token_196:
    jmp .Llexer_read_token_188
.Llexer_read_token_187:
.Llexer_read_token_188:
    push dword ptr [ebp-160]
    push dword ptr [ebp-168]
    push dword ptr [ebp-176]
    push dword ptr [ebp-184]
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    divsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    addsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    movq xmm1, [esp]
    add esp, 8
    movq xmm0, [esp]
    add esp, 8
    mulsd xmm0, xmm1
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    add esp, 4
    push dword ptr [ebp-192]
    pop eax
    test eax, eax
    jz .Llexer_read_token_197
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
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-288], eax
    push 0
    add esp, 4
    push 0
    add esp, 4
    push dword ptr [ebp-288]
    push 64
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_199
    push 64
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-288], eax
    push dword ptr [ebp-288]
    add esp, 4
    jmp .Llexer_read_token_200
.Llexer_read_token_199:
.Llexer_read_token_200:
    push 0
    pop eax
    mov [ebp-296], eax
    push dword ptr [ebp-296]
    add esp, 4
.Llexer_read_token_201:
    push dword ptr [ebp-296]
    push dword ptr [ebp-288]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_202
    lea eax, [ebp-224]
    push eax
    push dword ptr [ebp-296]
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
    push dword ptr [ebp-296]
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
.Llexer_read_token_203:
    push dword ptr [ebp-296]
    push dword ptr [ebp-296]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-296], eax
    add esp, 4
    jmp .Llexer_read_token_201
.Llexer_read_token_202:
    lea eax, [ebp-224]
    push eax
    push dword ptr [ebp-288]
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
    lea eax, [ebp-224]
    push eax
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call strtod
    mov esp, [ebp-304]
    push eax
    pop eax
    cvtsi2sd xmm0, eax
    sub esp, 8
    movq [esp], xmm0
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    add esp, 4
    jmp .Llexer_read_token_198
.Llexer_read_token_197:
.Llexer_read_token_198:
    push 0
    pop eax
    mov [ebp-224], eax
.Llexer_read_token_204:
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
    movsx eax, byte ptr [eax]
    push eax
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_210
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
    jmp .Llexer_read_token_211
.Llexer_read_token_210:
    push 1
.Llexer_read_token_211:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_208
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
    movsx eax, byte ptr [eax]
    push eax
    push 108
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
    jmp .Llexer_read_token_209
.Llexer_read_token_208:
    push 1
.Llexer_read_token_209:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_206
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
    movsx eax, byte ptr [eax]
    push eax
    push 76
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
    jmp .Llexer_read_token_207
.Llexer_read_token_206:
    push 1
.Llexer_read_token_207:
    pop eax
    test eax, eax
    jz .Llexer_read_token_205
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
    movsx eax, byte ptr [eax]
    push eax
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_214
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
    jmp .Llexer_read_token_215
.Llexer_read_token_214:
    push 1
.Llexer_read_token_215:
    pop eax
    test eax, eax
    jz .Llexer_read_token_212
    push 1
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
    jmp .Llexer_read_token_213
.Llexer_read_token_212:
.Llexer_read_token_213:
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
    add esp, 4
    jmp .Llexer_read_token_204
.Llexer_read_token_205:
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
    movsx eax, byte ptr [eax]
    push eax
    push 105
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_222
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
    movsx eax, byte ptr [eax]
    push eax
    push 73
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
    jmp .Llexer_read_token_223
.Llexer_read_token_222:
    push 1
.Llexer_read_token_223:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_220
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
    movsx eax, byte ptr [eax]
    push eax
    push 106
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
    jmp .Llexer_read_token_221
.Llexer_read_token_220:
    push 1
.Llexer_read_token_221:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_218
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
    movsx eax, byte ptr [eax]
    push eax
    push 74
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
    jmp .Llexer_read_token_219
.Llexer_read_token_218:
    push 1
.Llexer_read_token_219:
    pop eax
    test eax, eax
    jz .Llexer_read_token_216
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
    add esp, 4
    push dword ptr [ebp-64]
    push 83
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    lea eax, [ebp-232]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-232]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ebp-232]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    movq xmm0, [esp]
    add esp, 8
    cvttsd2si eax, xmm0
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
    lea eax, [ebp-232]
    push eax
    push 36
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
    lea eax, [ebp-232]
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-224]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ebp-232]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_217
.Llexer_read_token_216:
.Llexer_read_token_217:
    push dword ptr [ebp-64]
    push 83
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    lea eax, [ebp-232]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-232]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ebp-232]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    movq xmm0, [esp]
    add esp, 8
    cvttsd2si eax, xmm0
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
    lea eax, [ebp-232]
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-224]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ebp-232]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_178
.Llexer_read_token_177:
.Llexer_read_token_178:
.Llexer_read_token_224:
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
    movsx eax, byte ptr [eax]
    push eax
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_230
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
    movsx eax, byte ptr [eax]
    push eax
    push 85
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
    jmp .Llexer_read_token_231
.Llexer_read_token_230:
    push 1
.Llexer_read_token_231:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_228
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
    movsx eax, byte ptr [eax]
    push eax
    push 108
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
    jmp .Llexer_read_token_229
.Llexer_read_token_228:
    push 1
.Llexer_read_token_229:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_226
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
    movsx eax, byte ptr [eax]
    push eax
    push 76
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
    jmp .Llexer_read_token_227
.Llexer_read_token_226:
    push 1
.Llexer_read_token_227:
    pop eax
    test eax, eax
    jz .Llexer_read_token_225
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
    add esp, 4
    jmp .Llexer_read_token_224
.Llexer_read_token_225:
    push dword ptr [ebp-64]
    push dword ptr [ebp-136]
    # unknown IR op: CDECL64
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_number
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_83
.Llexer_read_token_82:
.Llexer_read_token_83:
    push dword ptr [ebp-72]
    push 39
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_232
    push 0
    pop eax
    mov [ebp-128], eax
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
    add esp, 4
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
    movsx eax, byte ptr [eax]
    push eax
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_234
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
    add esp, 4
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call read_escape
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Llexer_read_token_235
.Llexer_read_token_234:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_236
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_237
.Llexer_read_token_236:
.Llexer_read_token_237:
.Llexer_read_token_235:
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
    movsx eax, byte ptr [eax]
    push eax
    push 39
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_238
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
    add esp, 4
    jmp .Llexer_read_token_239
.Llexer_read_token_238:
.Llexer_read_token_239:
    push dword ptr [ebp-64]
    push dword ptr [ebp-128]
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
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_number
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_233
.Llexer_read_token_232:
.Llexer_read_token_233:
    push dword ptr [ebp-72]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_240
    push dword ptr [ebp-64]
    push 13
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    lea eax, [ebp-128]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    push 32
    pop eax
    mov [ebp-176], eax
    push 0
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-176]
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-192], eax
.Llexer_read_token_242:
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
    add esp, 4
.Llexer_read_token_245:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_247
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
    movsx eax, byte ptr [eax]
    push eax
    push 34
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
    jmp .Llexer_read_token_248
.Llexer_read_token_247:
    push 0
.Llexer_read_token_248:
    pop eax
    test eax, eax
    jz .Llexer_read_token_246
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
    movsx eax, byte ptr [eax]
    push eax
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_251
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
    jmp .Llexer_read_token_252
.Llexer_read_token_251:
    push 0
.Llexer_read_token_252:
    pop eax
    test eax, eax
    jz .Llexer_read_token_249
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
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_255
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
    push 85
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
    jmp .Llexer_read_token_256
.Llexer_read_token_255:
    push 1
.Llexer_read_token_256:
    pop eax
    test eax, eax
    jz .Llexer_read_token_253
    push 0
    pop eax
    mov [ebp-208], eax
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
    mov [ebp-232], eax
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-232]
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_257
    push 4
    jmp .Llexer_read_token_258
.Llexer_read_token_257:
    push 8
.Llexer_read_token_258:
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
    push 0
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
.Llexer_read_token_259:
    push dword ptr [ebp-224]
    push dword ptr [ebp-216]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_260
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
    push dword ptr [ebp-224]
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
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call is_hex
    mov esp, [ebp-304]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_262
    jmp .Llexer_read_token_260
    jmp .Llexer_read_token_263
.Llexer_read_token_262:
.Llexer_read_token_263:
    push dword ptr [ebp-208]
    push 16
    pop ecx
    pop eax
    imul eax, ecx
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
    push dword ptr [ebp-224]
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
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call hex_val
    mov esp, [ebp-304]
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    add esp, 4
.Llexer_read_token_261:
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    add esp, 4
    jmp .Llexer_read_token_259
.Llexer_read_token_260:
    push dword ptr [ebp-224]
    push dword ptr [ebp-216]
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_264
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
    push dword ptr [ebp-216]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ebp-240]
    push eax
    push dword ptr [ebp-208]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call utf8_encode
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-248], eax
    push dword ptr [ebp-248]
    add esp, 4
    push dword ptr [ebp-184]
    push dword ptr [ebp-248]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_266
    push dword ptr [ebp-176]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-256], eax
.Llexer_read_token_268:
    push dword ptr [ebp-184]
    push dword ptr [ebp-248]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-256]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_269
    push dword ptr [ebp-256]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-256], eax
    push dword ptr [ebp-256]
    add esp, 4
    jmp .Llexer_read_token_268
.Llexer_read_token_269:
    push dword ptr [ebp-256]
    push dword ptr [ebp-176]
    push dword ptr [ebp-192]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    mov [ebp-304], esp
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    add esp, 4
    push dword ptr [ebp-256]
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Llexer_read_token_267
.Llexer_read_token_266:
.Llexer_read_token_267:
    push 0
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
.Llexer_read_token_270:
    push dword ptr [ebp-224]
    push dword ptr [ebp-248]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_271
    push dword ptr [ebp-192]
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-240]
    push eax
    push dword ptr [ebp-224]
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
.Llexer_read_token_272:
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    add esp, 4
    jmp .Llexer_read_token_270
.Llexer_read_token_271:
    jmp .Llexer_read_token_245
    jmp .Llexer_read_token_265
.Llexer_read_token_264:
.Llexer_read_token_265:
    push dword ptr [ebp-232]
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
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
    add esp, 4
    jmp .Llexer_read_token_254
.Llexer_read_token_253:
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
    add esp, 4
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-320], eax
    mov [ebp-304], esp
    push dword ptr [ebp-320]
    and esp, -16
    call read_escape
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
.Llexer_read_token_254:
    jmp .Llexer_read_token_250
.Llexer_read_token_249:
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
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
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
    add esp, 4
.Llexer_read_token_250:
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_273
    push dword ptr [ebp-176]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    push dword ptr [ebp-176]
    push dword ptr [ebp-192]
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    mov [ebp-304], esp
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-304]
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    add esp, 4
    push dword ptr [ebp-208]
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Llexer_read_token_274
.Llexer_read_token_273:
.Llexer_read_token_274:
    push dword ptr [ebp-192]
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-200]
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Llexer_read_token_245
.Llexer_read_token_246:
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
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_275
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
    add esp, 4
    jmp .Llexer_read_token_276
.Llexer_read_token_275:
.Llexer_read_token_276:
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
    mov [ebp-200], eax
.Llexer_read_token_277:
    push dword ptr [ebp-200]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_283
    push dword ptr [ebp-200]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
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
    jmp .Llexer_read_token_284
.Llexer_read_token_283:
    push 1
.Llexer_read_token_284:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_281
    push dword ptr [ebp-200]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
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
    jmp .Llexer_read_token_282
.Llexer_read_token_281:
    push 1
.Llexer_read_token_282:
    pop eax
    test eax, eax
    jnz .Llexer_read_token_279
    push dword ptr [ebp-200]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
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
    jmp .Llexer_read_token_280
.Llexer_read_token_279:
    push 1
.Llexer_read_token_280:
    pop eax
    test eax, eax
    jz .Llexer_read_token_278
    push dword ptr [ebp-200]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_285
    push dword ptr [ebp-48]
    push 8
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
    add esp, 4
    jmp .Llexer_read_token_286
.Llexer_read_token_285:
.Llexer_read_token_286:
    push dword ptr [ebp-200]
    push dword ptr [ebp-200]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    add esp, 4
    jmp .Llexer_read_token_277
.Llexer_read_token_278:
    push dword ptr [ebp-200]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_287
    push dword ptr [ebp-48]
    push 4
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
    jmp .Llexer_read_token_244
    jmp .Llexer_read_token_288
.Llexer_read_token_287:
.Llexer_read_token_288:
    jmp .Llexer_read_token_243
.Llexer_read_token_244:
    jmp .Llexer_read_token_242
.Llexer_read_token_243:
    push dword ptr [ebp-192]
    push dword ptr [ebp-184]
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
    push 24
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
    lea eax, [ebp-128]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_241
.Llexer_read_token_240:
.Llexer_read_token_241:
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
    add esp, 4
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    push 40
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_290
    push dword ptr [ebp-128]
    push 41
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_291
    push dword ptr [ebp-128]
    push 123
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_292
    push dword ptr [ebp-128]
    push 125
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_293
    push dword ptr [ebp-128]
    push 91
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_294
    push dword ptr [ebp-128]
    push 93
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_295
    push dword ptr [ebp-128]
    push 59
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_296
    push dword ptr [ebp-128]
    push 44
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_297
    push dword ptr [ebp-128]
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_298
    push dword ptr [ebp-128]
    push 58
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_299
    push dword ptr [ebp-128]
    push 35
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_300
    push dword ptr [ebp-128]
    push 126
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_301
    push dword ptr [ebp-128]
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_302
    push dword ptr [ebp-128]
    push 94
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_303
    push dword ptr [ebp-128]
    push 43
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_304
    push dword ptr [ebp-128]
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_305
    push dword ptr [ebp-128]
    push 42
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_306
    push dword ptr [ebp-128]
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_307
    push dword ptr [ebp-128]
    push 37
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_308
    push dword ptr [ebp-128]
    push 61
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_309
    push dword ptr [ebp-128]
    push 33
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_310
    push dword ptr [ebp-128]
    push 60
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_311
    push dword ptr [ebp-128]
    push 62
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_312
    push dword ptr [ebp-128]
    push 38
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_313
    push dword ptr [ebp-128]
    push 124
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Llexer_read_token_314
    jmp .Llexer_read_token_315
.Llexer_read_token_290:
    push dword ptr [ebp-64]
    push 48
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_291:
    push dword ptr [ebp-64]
    push 49
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_292:
    push dword ptr [ebp-64]
    push 50
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_293:
    push dword ptr [ebp-64]
    push 51
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_294:
    push dword ptr [ebp-64]
    push 52
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_295:
    push dword ptr [ebp-64]
    push 53
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_296:
    push dword ptr [ebp-64]
    push 54
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_297:
    push dword ptr [ebp-64]
    push 55
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_298:
    push dword ptr [ebp-64]
    push 57
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_299:
    push dword ptr [ebp-64]
    push 56
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_300:
    push dword ptr [ebp-64]
    push 58
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_301:
    push dword ptr [ebp-64]
    push 33
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_302:
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
    jz .Llexer_read_token_318
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Llexer_read_token_319
.Llexer_read_token_318:
    push 0
.Llexer_read_token_319:
    pop eax
    test eax, eax
    jz .Llexer_read_token_316
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
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push 86
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_317
.Llexer_read_token_316:
.Llexer_read_token_317:
    push dword ptr [ebp-64]
    push 84
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_303:
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
    jz .Llexer_read_token_320
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
    add esp, 4
    push dword ptr [ebp-64]
    push 43
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_321
.Llexer_read_token_320:
.Llexer_read_token_321:
    push dword ptr [ebp-64]
    push 32
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_304:
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
    jz .Llexer_read_token_322
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
    add esp, 4
    push dword ptr [ebp-64]
    push 46
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_323
.Llexer_read_token_322:
.Llexer_read_token_323:
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
    jz .Llexer_read_token_324
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
    add esp, 4
    push dword ptr [ebp-64]
    push 36
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_325
.Llexer_read_token_324:
.Llexer_read_token_325:
    push dword ptr [ebp-64]
    push 15
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_305:
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
    movsx eax, byte ptr [eax]
    push eax
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_326
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
    add esp, 4
    push dword ptr [ebp-64]
    push 47
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_327
.Llexer_read_token_326:
.Llexer_read_token_327:
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
    jz .Llexer_read_token_328
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
    add esp, 4
    push dword ptr [ebp-64]
    push 37
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_329
.Llexer_read_token_328:
.Llexer_read_token_329:
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
    jz .Llexer_read_token_330
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
    add esp, 4
    push dword ptr [ebp-64]
    push 85
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_331
.Llexer_read_token_330:
.Llexer_read_token_331:
    push dword ptr [ebp-64]
    push 16
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_306:
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
    jz .Llexer_read_token_332
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
    add esp, 4
    push dword ptr [ebp-64]
    push 38
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_333
.Llexer_read_token_332:
.Llexer_read_token_333:
    push dword ptr [ebp-64]
    push 17
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_307:
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
    jz .Llexer_read_token_334
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
    add esp, 4
    push dword ptr [ebp-64]
    push 39
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_335
.Llexer_read_token_334:
.Llexer_read_token_335:
    push dword ptr [ebp-64]
    push 18
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_308:
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
    jz .Llexer_read_token_336
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
    add esp, 4
    push dword ptr [ebp-64]
    push 40
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_337
.Llexer_read_token_336:
.Llexer_read_token_337:
    push dword ptr [ebp-64]
    push 19
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_309:
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
    jz .Llexer_read_token_338
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
    add esp, 4
    push dword ptr [ebp-64]
    push 21
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_339
.Llexer_read_token_338:
.Llexer_read_token_339:
    push dword ptr [ebp-64]
    push 20
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_310:
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
    jz .Llexer_read_token_340
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
    add esp, 4
    push dword ptr [ebp-64]
    push 22
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_341
.Llexer_read_token_340:
.Llexer_read_token_341:
    push dword ptr [ebp-64]
    push 29
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_311:
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
    jz .Llexer_read_token_342
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
    add esp, 4
    push dword ptr [ebp-64]
    push 25
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_343
.Llexer_read_token_342:
.Llexer_read_token_343:
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
    movsx eax, byte ptr [eax]
    push eax
    push 60
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_344
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
    add esp, 4
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
    jz .Llexer_read_token_346
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
    add esp, 4
    push dword ptr [ebp-64]
    push 44
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_347
.Llexer_read_token_346:
.Llexer_read_token_347:
    push dword ptr [ebp-64]
    push 34
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_345
.Llexer_read_token_344:
.Llexer_read_token_345:
    push dword ptr [ebp-64]
    push 23
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_312:
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
    jz .Llexer_read_token_348
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
    add esp, 4
    push dword ptr [ebp-64]
    push 26
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_349
.Llexer_read_token_348:
.Llexer_read_token_349:
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
    jz .Llexer_read_token_350
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
    add esp, 4
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
    jz .Llexer_read_token_352
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
    add esp, 4
    push dword ptr [ebp-64]
    push 45
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_353
.Llexer_read_token_352:
.Llexer_read_token_353:
    push dword ptr [ebp-64]
    push 35
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_351
.Llexer_read_token_350:
.Llexer_read_token_351:
    push dword ptr [ebp-64]
    push 24
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_313:
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
    movsx eax, byte ptr [eax]
    push eax
    push 38
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_354
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
    add esp, 4
    push dword ptr [ebp-64]
    push 27
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_355
.Llexer_read_token_354:
.Llexer_read_token_355:
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
    jz .Llexer_read_token_356
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
    add esp, 4
    push dword ptr [ebp-64]
    push 41
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_357
.Llexer_read_token_356:
.Llexer_read_token_357:
    push dword ptr [ebp-64]
    push 30
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_314:
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
    movsx eax, byte ptr [eax]
    push eax
    push 124
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_read_token_358
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
    add esp, 4
    push dword ptr [ebp-64]
    push 28
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_359
.Llexer_read_token_358:
.Llexer_read_token_359:
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
    jz .Llexer_read_token_360
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
    add esp, 4
    push dword ptr [ebp-64]
    push 42
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Llexer_read_token_361
.Llexer_read_token_360:
.Llexer_read_token_361:
    push dword ptr [ebp-64]
    push 31
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_315:
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    lea eax, [ark_str_0]
    push eax
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    pop eax
    mov [ebp-328], eax
    pop eax
    mov [ebp-332], eax
    mov [ebp-304], esp
    push dword ptr [ebp-332]
    push dword ptr [ebp-328]
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call ark_log
    mov esp, [ebp-304]
    push eax
    push dword ptr [ebp-64]
    push 0
    pop eax
    mov [ebp-320], eax
    pop eax
    mov [ebp-324], eax
    mov [ebp-304], esp
    push dword ptr [ebp-324]
    push dword ptr [ebp-320]
    and esp, -16
    call make_token
    mov esp, [ebp-304]
    push eax
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Llexer_read_token_289:
    push 0
    pop eax
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    mov eax, [ebp-504]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl lexer_init
lexer_init:
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
    push dword ptr [ebp-48]
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
    push dword ptr [ebp-48]
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
    push dword ptr [ebp-48]
    push 16
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
    call lexer_read_token_with_pos
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    add esp, 4
    push dword ptr [ebp-48]
    push 64
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
    call lexer_read_token_with_pos
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
    push 64
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
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

    .globl lexer_peek
lexer_peek:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-264], eax
    mov eax, [ebp+12]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov eax, [ebp-264]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    mov eax, [ebp-264]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    mov eax, [ebp-264]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl lexer_peek2
lexer_peek2:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-264], eax
    mov eax, [ebp+12]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 64
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov eax, [ebp-264]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    mov eax, [ebp-264]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    mov eax, [ebp-264]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl lexer_next
lexer_next:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 364
    mov eax, [ebp+8]
    mov [ebp-312], eax
    mov eax, [ebp+12]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-56]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    push dword ptr [ebp-48]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 64
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    add esp, 4
    push dword ptr [ebp-48]
    push 64
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call lexer_read_token_with_pos
    mov esp, [ebp-112]
    push eax
    push dword ptr [ebp-48]
    push 64
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    add esp, 4
    lea eax, [ebp-56]
    push eax
    pop eax
    mov eax, [ebp-312]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    mov eax, [ebp-312]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    mov eax, [ebp-312]
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl lexer_advance
lexer_advance:
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_next
    mov esp, [ebp-64]
    push eax
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

    .globl lexer_expect
lexer_expect:
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
    push 16
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
    push dword ptr [ebp-56]
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Llexer_expect_0
    push dword ptr [ebp-48]
    push 16
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
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    push 16
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
    pop eax
    mov [ebp-92], eax
    mov [ebp-64], esp
    push dword ptr [ebp-92]
    push dword ptr [ebp-88]
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call ark_log
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
    jmp .Llexer_expect_1
.Llexer_expect_0:
.Llexer_expect_1:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
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

    .globl token_kind_name
token_kind_name:
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
    jnz .Ltoken_kind_name_1
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
    jnz .Ltoken_kind_name_2
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
    jnz .Ltoken_kind_name_3
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
    jnz .Ltoken_kind_name_4
    push dword ptr [ebp-56]
    push 83
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Ltoken_kind_name_5
    jmp .Ltoken_kind_name_6
.Ltoken_kind_name_1:
    lea eax, [ark_str_2]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltoken_kind_name_2:
    lea eax, [ark_str_3]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltoken_kind_name_3:
    lea eax, [ark_str_4]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltoken_kind_name_4:
    lea eax, [ark_str_5]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltoken_kind_name_5:
    lea eax, [ark_str_6]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltoken_kind_name_6:
    lea eax, [ark_str_7]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Ltoken_kind_name_0:
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

