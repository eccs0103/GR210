.model small
.stack 100h
.data
	array1 db 1, 6, 8, 23, 10, 31
	array2 db 6 dup(?)
.code
main proc far
	mov AX, @data
	mov DS, AX
	mov CX, 5
	xor SI, SI
loop1:
	mov AL, array1[SI]
	call is_even
	mov array2[SI], DL
	inc SI
	loop loop1
	ret
main          endp

is_even proc
	push CX SI
	xor BL, BL
	mov CX, 8
	xor DL, DL
have_dig:
	shl AL, 1
	jnc next_dig
	inc BL
next_dig:
	loop have_dig
	test BL, 1
	jnz false_res
	mov DL, 1
false_res:
	pop SI CX
	ret
is_even endp
end        main