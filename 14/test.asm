sseg segment stack "stack"
	db 64 dup(?)
sseg ends
dseg segment "data"
	tox db 20, 21 dup(?)
	a   db "chka$"
dseg ends
eseg segment "data"
	res  db 9 dup(?), "$"
	tox1 db 20 dup(?)
eseg ends
cseg segment "code"
	assume SS:sseg, DS:dseg, ES:eseg, CS:cseg
main proc far
	push DS
	xor  AX, AX
	push AX
	mov  AX, dseg
	mov  DS, AX
	; my code below
	mov  AH, 10
	lea  DX, tox
	int  21h
	lea  SI, tox
	lea  DI, ES:tox1
	mov  CL, tox + 1
	xor  CH, CH
	cld
rep movsb
	mov AL, "A"
	mov CL, tox + 1
	xor CH, CH
	lea DI, ES:tox1
repne scasb
	jnz chka_str    ; "A" was found
	lea DI, ES:res
	mov AL, "A"
	mov CX, 3
rep stosb
	lea DI, ES:res + 6
	mov CX, 3
rep stosb
	lea DI, ES:res + 3
	mov AL, "*"
	mov CX, 3
rep stosb
	mov AH, 9
	lea DX, res
	int 21h
	jmp code_end
chka_str:
	mov AH, 9
	lea DI, a
	int 21h
code_end:
	; my code above
	ret
main endp
cseg ends
end  main