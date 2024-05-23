.model small
.stack 100h
.data
	array  db 1, 5, 8, 10, 23, 54
	result db ?
.code
main proc far
	mov AX, @data
	mov DS, AX
	xor BL, BL
	mov CX, 6
	xor SI, SI
arr_trav:
	mov  AL, array[SI]
	call is2in5
	test DL, 1
	jz   loop_end
	inc  BL
loop_end:
	loop arr_trav
	mov  result, BL
	ret
main   endp

is2in5 proc
	push BX CX SI
	xor  DL, DL
when_h_d:
	cbw
	cmp  AL, 1
	jl   proc_end
	mov  BL, 5
	idiv BL
	cmp  AH, 2
	jne  when_h_d
	mov  DL, 1
proc_end:
	pop SI CX BX
	ret
is2in5 endp
end    main