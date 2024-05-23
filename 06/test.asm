.model small
.stack 64
.data
    a db 2, 4, 5, 9, 2, 10, 3
    res db ?
.code
start:
    mov AX, @data
    mov DS, AX
    xor SI, SI
    xor DX, DX
    mov CX, 7
func:
    mov AL, a[SI]
    cmp AL, 5
    jg foo
    inc SI
    loop func
foo:
    dec CX
foo2:
    inc SI
    mov AL, a[SI]
    test AL, 1
    jnz foo1
    inc DL
    loop foo2
foo1:
    mov res, DL
    mov AX, 4c00h
    int 21h
    end start
    