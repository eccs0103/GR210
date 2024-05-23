.model small
.stack 64
.data
	message db "Invalid symbol$"
.code
main proc far
	         mov  AX, @data
	         mov  DS, AX
	         xor  DH, DH
	again:   
	         mov  AH, 1
	         int  21h
	         cmp  AL, '*'
	         je   proc_end
	         call is_upp
	         test BL, 1
	         jz   again
	         inc  DH
	         mov  AH, 6
	         mov  DL, AL
	         int  21h
	         jmp  again
	proc_end:
	         cmp  DH, 0
	         jne  very_end
	         mov  AH, 9
	         lea  DX, message
	         int  21h
	very_end:
	         ret
main endp

is_upp proc
	         push AX
	         xor  BL, BL
	         cmp  AL, 'A'
	         jb   false_re
	         cmp  AL, 'Z'
	         ja   false_re
	         mov  BL, 1
	false_re:
	         pop  AX
	         ret
is_upp endp
end  main
