.model small
.stack 64
.data
    a db 3, 2, 1, 5, 7, 8
    res db 6 dup(?)
.code
main proc far
    mov ax, @data
    mov ds, ax
    xor si, si
    mov cx, 6
    xor di, di
loop_traverse:
    mov al, a[si]
    call is_passed
    cmp ah, 1
    jne test_not_passed
    mov res[di], al
    inc di
test_not_passed:
    inc si
    loop loop_traverse
    ret
main endp

is_passed proc
    push si cx di
    xor ah, ah
    test al, 1
    jz return_false
    test al, 2
    jnz return_false
    and al, 11110111b
    xor al, 00010000b
    mov ah, 1
return_false:
    pop di cx si
    ret
is_passed endp
end main