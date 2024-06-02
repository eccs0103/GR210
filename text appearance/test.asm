.model small
.stack 1000h
.data
	NewLine  equ 10, 13
	EndLine  equ 3
	Sentence db  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", NewLine
	         db  "Ut vitae nibh velit. Pellentesque ac suscipit turpis.", NewLine
	         db  "Mauris tempor elit quis ex tincidunt, sed tempor lorem lacinia.", NewLine
	         db  "Aliquam efficitur cursus sodales.", NewLine
	         db  "Proin lacinia tortor sollicitudin, maximus mi ac, auctor lacus.", NewLine
	         db  "Quisque pellentesque id ante aliquam imperdiet.", NewLine
	         db  "Donec porta orci urna.", NewLine
	         db  "Vestibulum quis viverra lacus.", NewLine
	         db  "Nulla pulvinar bibendum tortor, eget tincidunt dolor fringilla quis.", NewLine
	         db  "Sed id nulla mollis, pretium neque nec, luctus orci.", EndLine
.code
	;Clears the console
Clear proc
	         push AX
	         mov  AL, 2
	         xor  AH, AH
	         int  10h
	         pop  AX
	         ret
Clear endp

	;Pause execution for the number of microseconds in AX
Sleep proc
	         push AX CX DX
	         mov  DX, AX
	         xor  CX, CX
	         xor  AL, AL
	         mov  AH, 86h
	         int  15h
	         pop  DX CX AX
	         ret
Sleep endp

	;Wait for key input
ReadKey proc
	         push AX DX
	         xor  AL, AL
	         mov  AH, 1
	         int  21h
	         mov  DL, 8
	         mov  AH, 2
	         int  21h
	         pop  DX AX
	         ret
ReadKey endp

	;Write character in AL
WriteChr proc
	         push DX AX BX
	         mov  DL, AL
	         xor  AL, AL
	         mov  AH, 6
	         int  21h
	         pop  BX AX DX
	         ret
WriteChr endp

	;Render character in AL
RendChr proc
	         cmp  AL, 32
	         jl   Skip1
	         cmp  AL, 126
	         jg   Skip1
	         push BX CX AX
	         mov  BL, AL
	         mov  CL, 32
	Return1: mov  AX, 1
	         call Sleep
	         mov  AL, CL
	         call WriteChr
	         cmp  CL, BL
	         je   Skip2
	         cmp  CL, 126
	         je   Skip2
	         mov  AL, 8
	         call WriteChr
	         inc  CL
	         jmp  Return1
	Skip2:   pop  AX CX BX
	Skip1:   ret
RendChr endp

	;Render string starting from address in AX
RendStr proc
	         mov  BX, AX
	         push BX AX
	Return2: mov  AL, [BX]
	         cmp  AL, 3
	         je   Skip3
	         cmp  AL, 10
	         je   Skip4
	         cmp  AL, 13
	         je   Skip4
	         call RendChr
	         inc  BX
	         jmp  Return2
	Skip4:   call WriteChr
	         inc  BX
	         jmp  Return2
	Skip3:   pop  AX BX
	         ret
RendStr endp

	;Main procedure
Main proc far
	         mov  AX, @data
	         mov  DS, AX

	         call Clear
	         call ReadKey
	         lea  AX, Sentence
	         call RendStr

	         ret
Main endp
end Main