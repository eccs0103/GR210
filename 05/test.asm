.model small
.stack 64
.data
    a db 3, 4, 7, 2, 5, 9
    res dw ?
.code
start:
    mov AX, @data
    mov DS, AX
    xor DX, DX
    xor SI, SI
    mov CX, 6
func:
    mov AL, a[SI]
    cmp AL, 5
    jg le1
    add DL, AL
    adc DH, 0
    inc SI
    loop func
le1:
    mov res, DX
    mov AX, 4C00H
    int 21h
    end start