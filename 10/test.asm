.model small
.stack 64
.data
	a db 39
	a dw 291
.code
main proc far
	mov ax, @data
	mov ds, ax
	mov cx, 8
	xor dl, dl
number_traverse:
	shr al, 1
	jnc continue_loop
	inc dl
continue_loop:
	loop number_traverse
	mov ax, b
	mov cl, dl
	ror ax, cl
	mov b, ax
	ret
main endp
end main