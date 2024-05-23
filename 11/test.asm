.model small
.stack 100h
.data
	array  db  1, 6, 8, 23, 10, 31
	count  equ $-array
	result db  ?
.code
main proc far
	mov AX, @data
	mov DS, AX
	xor BX, BX
	mov CX, count + 1
	mov SI, count
array_traverse:
	dec  CX
	dec  SI
	mov  AL, array[SI]
	test BH, 1
	jnz  count_even
	call check_7_and_5
	test DX, 1
	jz   array_traverse
count_even:
	call check_even
	test DX, 1
	jz   loop_end
	inc  BL
loop_end:
	loop array_traverse
	mov  result, BL
	ret
main          endp

check_7_and_5 proc
	push BX CX
	xor  DX, DX
	cmp  AL, 7
	jle  procedure_end
	xor  AH, AH
	mov  BL, 5
	idiv BL
	test AH, 1
	jnz  procedure_end
	mov  DX, 1
procedure_end:
	pop CX BX
	ret
check_7_and_5 endp

check_even    proc
	push BX CX
	xor  DX, DX
	test AL, 1
	jnz  procedure_end
	mov  DX, 1
procedure_end:
	pop CX BX
	ret
check_even endp
end        main