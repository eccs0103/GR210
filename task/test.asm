.model small
.stack 100h
.data

.code
Main   proc far
	mov  ax, @data
	mov  ds, ax
	;Code #region
	mov  ax, 64
	mov  bx, 8
	call IsDivide
	mov  ah, 2
	;mov  dl, dl
	int  21h
	;Code #endregion
	ret
Main     endp

; Is `ax` dividing to `bx`
; Returns (0 | 1) in `dl`
IsDivide proc
	push ax bx
	div  bx
	cmp  dx, 0
	jne  False1
	mov  dl, 1
	jmp  ProcEnd1
	False1:
	mov  dl, 0
	ProcEnd1:
	pop  bx ax
	ret
IsDivide endp
end      Main
