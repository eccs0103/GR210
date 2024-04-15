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
	assume ss:sseg, ds:dseg, es:eseg, cs:cseg
main proc far
	push ds
	xor  ax, ax
	push ax
	mov  ax, dseg
	mov  ds, ax
	; my code below
	mov  ah, 10
	lea  dx, tox
	int  21h
	lea  si, tox
	lea  di, es:tox1
	mov  cl, tox + 1
	xor  ch, ch
	cld
rep movsb
	mov al, "A"
	mov cl, tox + 1
	xor ch, ch
	lea di, es:tox1
repne scasb
	jnz chka_str    ; "A" was found
	lea di, es:res
	mov al, "A"
	mov cx, 3
rep stosb
	lea di, es:res + 6
	mov cx, 3
rep stosb
	lea di, es:res + 3
	mov al, "*"
	mov cx, 3
rep stosb
	mov ah, 9
	lea dx, res
	int 21h
	jmp code_end
chka_str:
	mov ah, 9
	lea di, a
	int 21h
code_end:
	; my code above
	ret
main endp
cseg ends
end  main