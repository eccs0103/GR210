.model small
.stack 64
.data
	message db "Invalid symbol$"
.code
main proc far
	         mov  ax, @data
	         mov  ds, ax
	         xor  dh, dh
	again:   
	         mov  ah, 1
	         int  21h
	         cmp  al, '*'
	         je   proc_end
	         call is_upp
	         test bl, 1
	         jz   again
	         inc  dh
	         mov  ah, 6
	         mov  dl, al
	         int  21h
	         jmp  again
	proc_end:
	         cmp  dh, 0
	         jne  very_end
	         mov  ah, 9
	         lea  dx, message
	         int  21h
	very_end:
	         ret
main endp

is_upp proc
	         push ax
	         xor  bl, bl
	         cmp  al, 'A'
	         jb   false_re
	         cmp  al, 'Z'
	         ja   false_re
	         mov  bl, 1
	false_re:
	         pop  ax
	         ret
is_upp endp
end  main
