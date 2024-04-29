.model small
.stack 64
.data
	a db 4, 7, 11, 21, 14
	res db 5 dup(?)
	c db 7
.code
start:
	mov ax, @data
	mov ds, ax
	sub si, si
	sub di, di
	mov cx, 5
func:
	mov al, a[si]
	mov dl, al
	cbw
	idiv c
	cmp ah, 0
	jne p
	mov res[di], dl
	inc di
p:
	inc si
	loop func
	mov ax, 4h00h
	int 21h
	end start
