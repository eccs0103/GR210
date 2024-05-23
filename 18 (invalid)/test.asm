.model small
.stack 100h
.data
	Text    db 30, 31 dup(?)
	Result  db 31 dup(?)
	NewLine db 10, 13, '$'
	Message db "Text isn't contain lowercases$"
.code
Main proc far
	mov  AX,         @data
	mov  DS,         AX
	;Code #region
	mov  AH,         10
	lea  DX,         Text
	int  21h
	mov  AH,         9
	lea  DX,         NewLine
	int  21h
	xor  BL,         BL
	mov  SI,         2
	xor  DI,         DI
	mov  CL,         Text + 1
	xor  CH,         CH
	Mapping:
	mov  AL,         Text[SI]
	call IsLower
	cmp  DL,         1
	jne  LoopEnd1
	mov  Result[DI], AL
	inc  DI
	inc  BL
	LoopEnd1:
	inc  SI
	loop Mapping
	mov  Result[DI], '$'
	cmp  BL,         0
	jg   HaveLow
	mov  AH,         9
	lea  DX,         Message
	int  21h
	jmp  ToEnd
	HaveLow:
	call PrintNum
	mov  AH,         10
	lea  DX,         Result
	int  21h
	ToEnd:
	;Code #endregion
	ret
Main    endp

IsLower proc
	push AX BX CX SI DI
	xor  DL, DL
	cmp  AL, 'a'
	jb   FalseRe1
	cmp  AL, 'z'
	ja   FalseRe1
	mov  DL, 1
	FalseRe1:
	pop  DI SI CX BX AX
IsLower  endp

PrintNum proc
	push AX BX CX DX SI DI
	mov  BL, 10
	mov  AL, BL
	xor  CX, CX
	HaveDig:
	xor  AH, AH
	idiv BL
	push AX
	inc  CX
	cmp  AL, 0
	jne  HaveDig
	PopDigs:
	pop  DX
	mov  DL, DH
	add  DL, 30h
	mov  AH, 6
	int  21h
	loop PopDigs
	pop  DI SI DX CX BX AX
	ret
PrintNum endp
end      Main
