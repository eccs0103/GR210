sseg segment stack
	db 64 DUP(?)
sseg ends

dseg segment
	message db "Hello!", 0dh, 0ah, '$'
	a db 5
	b db 3
	c db 6
	res db ?
dseg ends

cseg segment
	assume CS:cseg, SS:sseg, DS:dseg

	push DS
	sub AX, AX
	push AX
	mov AX, dseg
	mov DS, AX
start:
	mov AL, 3
	imul a			; AX = 3a
	mov CX, AX		; CX = 3a
	mov AL, 5
	imul b 			; AX = 5b
	add CX, AX		; CX = 3a + 5b
	mov AL, 2
	imul c			; AX = 2c
	sub AL, 4		; AL = 2c - 4
	mov DL, AL		; DL = AL = 2c - 4
	mov AX, CX		; AX = CS = 3a + 5b
	idiv DL			; AL = (3a + 5b) / (2c - 4)
	mov res, AL

	mov AX, 4c00h
	int 21h
cseg ends

end start