.model small
.stack 64
.data
	tox     db 23, 24 dup(?)
	nor_tox db 24 dup(?)
	message db "There is no uppercase in this text$"
	endl    db 10, 13, '$'
.code
main proc far
	mov AX, @data
	mov DS, AX
	mov AH, 10
	lea DX, tox
	int 21h
	mov CL, tox + 1
	xor CH, CH
	mov SI, 2
	xor DI, DI
	xor BL, BL
	mov AH, 9
	lea DX, endl
	int 21h
traverse:
	mov  AL,          tox[SI]
	call is_upper
	cmp  DL,          1
	jne  nex_iter
	inc  BL
	add  AL,          20h
	mov  nor_tox[DI], AL
	inc  DI
nex_iter:
	inc  SI
	loop traverse
	mov  nor_tox[DI], '$'
	cmp  BL,          0
	jne  inchvor
	mov  AH,          9
	lea  DX,          message
	int  21h
	jmp  to_end
inchvor:
	mov AH, 9
	lea DX, nor_tox
	int 21h
to_end:
	ret
main     endp

is_upper proc
	push CX SI AX
	xor  DL, DL
	cmp  AL, 'A'
	jb   false_re
	cmp  AL, 'Z'
	ja   false_re
	mov  DL, 1
false_re:
	pop AX SI CX
	ret
is_upper endp
end      main