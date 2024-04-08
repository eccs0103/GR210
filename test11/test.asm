.model small
.stack 100h
.data
	array  db  1, 6, 8, 23, 10, 31
	count  equ $-array
	result db  ?
.code
main proc far
	mov ax, @data
	mov ds, ax
	xor bx, bx
	mov cx, count + 1
	mov si, count
array_traverse:
	dec  cx
	dec  si
	mov  al, array[si]
	test bh, 1
	jnz  count_even
	call check_7_and_5
	test dx, 1
	jz   array_traverse
count_even:
	call check_even
	test dx, 1
	jz   loop_end
	inc  bl
loop_end:
	loop array_traverse
	mov  result, bl
	ret
main          endp

check_7_and_5 proc
	push bx cx
	xor  dx, dx
	cmp  al, 7
	jle  procedure_end
	xor  ah, ah
	mov  bl, 5
	idiv bl
	test ah, 1
	jnz  procedure_end
	mov  dx, 1
procedure_end:
	pop cx bx
	ret
check_7_and_5 endp

check_even    proc
	push bx cx
	xor  dx, dx
	test al, 1
	jnz  procedure_end
	mov  dx, 1
procedure_end:
	pop cx bx
	ret
check_even endp
end        main