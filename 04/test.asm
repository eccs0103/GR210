.model small
.stack 64
.data
	a db 4, 7, 11, 21, 14
	res db 5 dup(?)
	c db 7
.code
start:
	mov AX, @data
	mov DS, AX
	sub SI, SI
	sub DI, DI
	mov CX, 5
func:
	mov AL, a[SI]
	mov DL, AL
	cbw
	idiv c
	cmp AH, 0
	jne p
	mov res[DI], DL
	inc DI
p:
	inc SI
	loop func
	mov AX, 4h00h
	int 21h
	end start
