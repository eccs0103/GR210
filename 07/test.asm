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
	xor AX, AX
	xor BL, BL
	mov CX, 7
foo:
	mov DL, a[SI]
	cmp DL, 5
	jng foo1
	add AL, DL
	adc AH, 0
	inc BL
foo1:
	inc SI
	loop foo
	idiv BL
	mov res, AL
	mov AX, 4c00h
	int 21h
	end start