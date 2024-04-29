sseg segment stack
	db 256 DUP(?)
sseg ends

dseg segment
	message db "Hello!", 0dh, 0ah, '$'
dseg ends

cseg segment
	assume cs:cseg, ds:dseg
start:
	mov ax, sseg
	mov ss, ax
	mov sp, offset sseg + 256 ; Set stack pointer

	mov ax, dseg
	mov ds, ax

	lea dx, message ; Load effective address of the message into dx
	mov ah, 9       ; DOS function to print string
	int 21h

	mov ax, 4c00h ; DOS function to exit
	int 21h
cseg ends

end  start