.model small
.stack 64
.code
main   proc far
	mov ah, 1
	int 21h
	mov ah, 2
	mov dh, 12
	mov dl, 40
	mov bh, 0
	int 10h
	mov ah, 6
	mov dl, al
	int 21h
	ret
main endp
end  main
