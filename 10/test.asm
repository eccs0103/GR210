.model small
.stack 64
.data
	a db 39
	a dw 291
.code
main proc far
	mov AX, @data
	mov DS, AX
	mov CX, 8
	xor DL, DL
number_traverse:
	shr AL, 1
	jnc continue_loop
	inc DL
continue_loop:
	loop number_traverse
	mov AX, b
	mov CL, DL
	ror AX, CL
	mov b, AX
	ret
main endp
end main