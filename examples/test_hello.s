; test_hello.s ¡ª ¼òµ¥ Thumb-2 »ã±à²âÊÔ
.thumb
.text
.global main
main:
    PUSH {r5, r6, r7, lr}
    MOV r0, #42
    POP {r5, r6, r7, pc}
