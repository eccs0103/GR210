.model small
.stack 100h
.data
	Text    db 30, 31 dup(?)
	Result  db 31 dup(?)
	NewLine db 10, 13, '$'
	Message db "Text isn't contain lowercases$"
.code
Main proc far
	mov  ax,         @data
	mov  ds,         ax
	;Code #region
	mov  ah,         10
	lea  dx,         Text
	int  21h
	mov  ah,         9
	lea  dx,         NewLine
	int  21h
	xor  bl,         bl
	mov  si,         2
	xor  di,         di
	mov  cl,         Text + 1
	xor  ch,         ch
	Mapping:
	mov  al,         Text[si]
	call IsLower
	cmp  dl,         1
	jne  LoopEnd1
	mov  Result[di], al
	inc  di
	inc  bl
	LoopEnd1:
	inc  si
	loop Mapping
	mov  Result[di], '$'
	cmp  bl,         0
	jg   HaveLow
	mov  ah,         9
	lea  dx,         Message
	int  21h
	jmp  ToEnd
	HaveLow:
	call PrintNum
	mov  ah,         10
	lea  dx,         Result
	int  21h
	ToEnd:
	;Code #endregion
	ret
Main    endp

IsLower proc
	push ax bx cx si di
	xor  dl, dl
	cmp  al, 'a'
	jb   FalseRe1
	cmp  al, 'z'
	ja   FalseRe1
	mov  dl, 1
	FalseRe1:
	pop  di si cx bx ax
IsLower  endp

PrintNum proc
	push ax bx cx dx si di
	mov  bl, 10
	mov  al, bl
	xor  cx, cx
	HaveDig:
	xor  ah, ah
	idiv bl
	push ax
	inc  cx
	cmp  al, 0
	jne  HaveDig
	PopDigs:
	pop  dx
	mov  dl, dh
	add  dl, 30h
	mov  ah, 6
	int  21h
	loop PopDigs
	pop  di si dx cx bx ax
	ret
PrintNum endp
end      Main
