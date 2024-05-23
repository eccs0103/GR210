.model small
.stack 64
.data
    a db 3, 2, 1, 5, 7, 8
    res db 6 dup(?)
.code
main proc far
    mov AX, @data
    mov DS, AX
    xor SI, SI
    mov CX, 6
    xor DI, DI
loop_traverse:
    mov AL, a[SI]
    call is_passed
    cmp AH, 1
    jne test_not_passed
    mov res[DI], AL
    inc DI
test_not_passed:
    inc SI
    loop loop_traverse
    ret
main endp

is_passed proc
    push SI CX DI
    xor AH, AH
    test AL, 1
    jz return_false
    test AL, 2
    jnz return_false
    and AL, 11110111b
    xor AL, 00010000b
    mov AH, 1
return_false:
    pop DI CX SI
    ret
is_passed endp
end main