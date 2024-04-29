.model small
.stack 64
.data
	tox     db 23, 24 dup(?)
	nor_tox db 24 dup(?)
	message db "There is no uppercase in this text$"
	endl    db 10, 13, '$'
.code
main proc far
	mov ax, @data
	mov ds, ax
	mov ah, 10
	lea dx, tox
	int 21h
	mov cl, tox + 1
	xor ch, ch
	mov si, 2
	xor di, di
	xor bl, bl
	mov ah, 9
	lea dx, endl
	int 21h
traverse:
	mov al, tox[si]
	call is_upper
	cmp dl, 1
	jne nex_iter
	inc bl
	add al, 20h
	mov nor_tox[di], al
	inc di
nex_iter:
	inc si
	loop traverse
	mov nor_tox[di], '$'
	cmp bl, 0
	jne inchvor
	mov ah, 9
	lea dx, message
	int 21h
	jmp to_end
inchvor:
	mov ah, 9
	lea dx, nor_tox
	int 21h
to_end:
	ret
main endp

is_upper proc
	push cx si ax
	xor dl, dl
	cmp al, 'A'
	jb false_re
	cmp al, 'Z'
	ja false_re
	mov dl, 1
false_re:
	pop ax si cx
	ret
is_upper endp
end  main