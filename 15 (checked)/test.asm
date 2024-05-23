.model small
.stack 64
.code
main   proc far
	mov AH, 1
	int 21h
	mov AH, 2
	mov DH, 12
	mov DL, 40
	mov BH, 0
	int 10h
	mov AH, 6
	mov DL, AL
	int 21h
	ret
main endp
end  main
