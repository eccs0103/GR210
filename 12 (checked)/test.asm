.model small
.stack 100h
.data
	array1 db 1, 6, 8, 23, 10, 31
	array2 db 6 dup(?)
.code
main proc far
	mov ax, @data
	mov ds, ax
	mov cx, 5
	xor si, si
loop1:
	mov al, array1[si]
	call is_even
	mov array2[si], dl
	inc si
	loop loop1
	ret
main          endp

is_even proc
	push cx si
	xor bl, bl
	mov cx, 8
	xor dl, dl
have_dig:
	shl al, 1
	jnc next_dig
	inc bl
next_dig:
	loop have_dig
	test bl, 1
	jnz false_res
	mov dl, 1
false_res:
	pop si cx
	ret
is_even endp
end        main