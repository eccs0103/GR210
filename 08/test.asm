.model small
.stack 64
.data
    array db 5, 12, 7, 8, 6, 31
    res db ?
.code
main proc far
    mov AX, @data
    mov DS, AX
    xor SI, SI
    mov CX, 5
    xor DL, DL
array_loop:
    mov AL, array[SI]
    mov DH, array[SI + 1]
    call is_simple_pair
    cmp BL, 1
    jne exit_array_loop
    inc DL
exit_array_loop:
    inc SI
    loop array_loop
ret
main endp

is_simple_pair proc
    push SI CX AX DX
    xor BL, BL
is_equal:
    cmp AL, DL
    jz restore_data
    jg al_substract_dh
    xchg CL, DH
al_substract_dh:
    sub AL, DH
    jmp is_equal
    cmp AL, 1
    jne restore_data
    mov BL, 1
restore_data:
    pop DX AX CX SI
    ret
is_simple_pair endp

end main