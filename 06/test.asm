.model small
.stack 64
.data
    a db 2, 4, 5, 9, 2, 10, 3
    res db ?
.code
start:
    mov ax, @data
    mov ds, ax
    xor si, si
    xor dx, dx
    mov cx, 7
func:
    mov al, a[si]
    cmp al, 5
    jg foo
    inc si
    loop func
foo:
    dec cx
foo2:
    inc si
    mov al, a[si]
    test al, 1
    jnz foo1
    inc dl
    loop foo2
foo1:
    mov res, dl
    mov ax, 4c00h
    int 21h
    end start
    