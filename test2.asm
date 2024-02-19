sseg segment stack
	db 64 DUP(?)
sseg ends

dseg segment
	message db "Hello!", 0dh, 0ah, '$'
	a db 5
	b db 3
	c db 6
	res db ?
dseg ends

cseg segment
	assume cs:cseg, ss:sseg ds:dseg
start:
	mov al, 3
	imul a			; ax = 3a
	mov cx, ax		; cx = 3a
	mov al, 5
	imul b 			; ax = 5b
	add cx, ax		; cx = 3a + 5b
	mov al, 2
	imul c			; ax = 2c
cseg ends

end start