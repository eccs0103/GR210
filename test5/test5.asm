.model small
.stack 64
.data
    a db 3, 4, 7, 2, 5, 9
    res dw ?
.code
start:
    mov ax, @data
    mov ds, ax
    xor dx, dx
    xor si, si
    mov cx, 6
func:
    mov al, a[si]
    cmp al, 5
    jg le1
    add dl, al
    adc dh, 0
    inc si
    loop func
le1:
    mov res, dx
    mov ax, 4C00H
    int 21h
    end start