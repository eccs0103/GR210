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
	xor ax, ax
	xor bl, bl
	mov cx, 7
foo:
	mov dl, a[si]
	cmp dl, 5
	jng foo1
	add al, dl
	adc ah, 0
	inc bl
foo1:
	inc si
	loop foo
	idiv bl
	mov res, al
	mov ax, 4c00h
	int 21h
	end start