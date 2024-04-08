.model small
.stack 100h
.data
	array  db 1, 5, 8, 10, 23, 54
	result db ?
.code
main proc far
	mov ax, @data
	mov ds, ax
	xor bl, bl
	mov cx, 6
	xor si, si
arr_trav:
	mov  al, array[si]
	call is2in5
	test dl, 1
	jz   loop_end
	inc  bl
loop_end:
	loop arr_trav
	mov  result, bl
	ret
main   endp

is2in5 proc
	push bx cx si
	xor  dl, dl
when_h_d:
	cbw
	cmp  al, 1
	jl   proc_end
	mov  bl, 5
	idiv bl
	cmp  ah, 2
	jne  when_h_d
	mov  dl, 1
proc_end:
	pop si cx bx
	ret
is2in5 endp
end    main