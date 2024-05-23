sseg segment stack "stack"
	     db 64 dup(?)
sseg ends
dseg segment "data"
	array   db 29, 30 dup(?)
	message db "chka$"
dseg ends
eseg segment "data"
	tox    db 7 dup(?), '$'
	array2 db 29 dup(?)
eseg ends
cseg segment "code"
	      assume SS:sseg, DS:dseg, ES:eseg, CS:cseg,
Main proc far
	      push   DS
	      xor    AX, AX
	      push   AX
	      mov    AX, dseg
	      mov    DS, AX
	      mov    AX, eseg
	      mov    ES, AX
	      mov    AH, 10
	      lea    DX, array
	      int    21h
	      xor    BL, BL
	      xor    CH, CH
	      mov    CL, array[1]
	      lea    SI, array[2]
	      lea    DI, ES:array2
	      cld
	      rep    movsb
	      mov    AL, 'S'
	      lea    DI, ES:array2
	      xor    CH, CH
	      mov    CL, array[1]
	      repne  scasb
	      jz     lab1
	      mov    AH, 9
	      lea    DX, message
	      int    21h
	      jmp    final
	lab1: mov    CX, 2
	      lea    DI, ES:tox
	      mov    AL, '7'
	      rep    stosb
	      mov    CX, 3
	      lea    DI, ES:tox[2]
	      mov    AL, '*'
	      rep    stosb
	      mov    CX, 2
	      lea    DI, ES:tox[5]
	      mov    AL, '9'
	      rep    stosb
	      mov    AH, 9
	      lea    DX, ES:tox
	      int    21h
	final:ret
Main endp
cseg ends
end Main