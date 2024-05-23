sseg segment stack
	db 256 DUP(?)
sseg ends

dseg segment
	message db "Hello!", 0dh, 0ah, '$'
dseg ends

cseg segment
	assume CS:cseg, DS:dseg
start:
	mov AX, sseg
	mov SS, AX
	mov sp, offset sseg + 256 ; Set stack pointer

	mov AX, dseg
	mov DS, AX

	lea DX, message ; Load effective address of the message into DX
	mov AH, 9       ; DOS function to print string
	int 21h

	mov AX, 4c00h ; DOS function to exit
	int 21h
cseg ends

end  start