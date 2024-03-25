.model small
.stack 64
.data
    array db 5, 12, 7, 8, 6, 31
    res db ?
.code
main proc far
    mov ax, @data
    mov ds, ax
    xor si, si
    mov cx, 5
    xor dl, dl
array_loop:
    mov al, array[si]
    mov dh, array[si + 1]
    call is_simple_pair
    cmp bl, 1
    jne exit_array_loop
    inc dl
exit_array_loop:
    inc si
    loop array_loop
ret
main endp

is_simple_pair proc
    push si cx ax dx
    xor bl, bl
is_equal:
    cmp al, dl
    jz restore_data
    jg al_substract_dh
    xchg cl, dh
al_substract_dh:
    sub al, dh
    jmp is_equal
    cmp al, 1
    jne restore_data
    mov bl, 1
restore_data:
    pop dx ax cx si
    ret
is_simple_pair endp

end main