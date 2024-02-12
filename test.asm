.model small
.stack 64
.data
a db 'HELLO GR210', 10, 13, '$'
.code
start:
	mov ax, @data
	mov ds, ax
	mov ah, 9
	lea dx, a
	int 21h
	mov ax, 4c00h
	int 21h
end start