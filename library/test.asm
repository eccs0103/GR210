.model small
.stack 64
.code
Main proc far
	         mov  AX, @data
	         mov  DS, AX
	;Code below
	         call Clear
	;Code above
	         ret
Main endp

	;Clears the console
Clear proc
	         push AX
	         mov  AL, 2
	         xor  AH, AH
	         int  10h
	         pop  AX
	         ret
Clear endp

	;Converts the digit in AL to a character.
DigToChr proc
	         add  AL, 30h
	         ret
DigToChr endp

	;Converts the character in AL to a digit.
ChrToDig proc
	         sub  AL, 30h
	         ret
ChrToDig endp

	;Returns (0 | 1) in DL if the character in AL is digit
IsDigit proc
	         xor  DL, DL
	         cmp  AL, '0'
	         jb   Result1
	         cmp  AL, '9'
	         ja   Result1
	         mov  DL, 1
	Result1: ret
IsDigit endp

	;Makes upper character in AL to lower
ToLower proc
	         add  AL, 20h
	         ret
ToLower endp

	;Makes lower character in AL to upper
ToUpper proc
	         sub  AL, 20h
	         ret
ToUpper endp

	;Returns (0 | 1) in DL if the character in AL is lower
IsLower proc
	         xor  DL, DL
	         cmp  AL, 'a'
	         jb   Result2
	         cmp  AL, 'z'
	         ja   Result2
	         mov  DL, 1
	Result2: ret
IsLower endp

	;Returns (0 | 1) in DL if the character in AL is upper
IsUpper proc
	         xor  DL, DL
	         cmp  AL, 'A'
	         jb   Result3
	         cmp  AL, 'Z'
	         ja   Result3
	         mov  DL, 1
	Result3: ret
IsUpper endp

	;Reads a character from the console and stores it in AL.
ReadChr proc
	         push AX DX
	         mov  AH, 1
	         int  21h
	         mov  DL, AL
	         pop  AX
	         mov  AL, DL
	         pop  DX
	         ret
ReadChr endp

	;Writes the character in AL to the console.
WriteChr proc
	         push AX
	         mov  DL, AL
	         mov  AH, 6
	         int  21h
	         pop  AX
	         ret
WriteChr endp

	;Writes a newline to the console
EndLine proc
	         push AX
	         mov  AL, 10
	         call WriteChr
	         mov  AL, 13
	         call WriteChr
	         pop  AX
	         ret
EndLine endp

	;Writes the number in AX to the console.
WriteNum proc
	         push BX CX AX DX
	         mov  BX, 10
	         xor  CX, CX
	CheckDig:xor  DX, DX
	         div  BX
	         push DX
	         inc  CX
	         cmp  AX, 0
	         jne  CheckDig
	         xor  AX, AX
	PopDigs: pop  DX
	         add  DX, 30h
	         mov  AH, 6
	         int  21h
	         loop PopDigs
	         pop  DX AX CX BX
	         call EndLine
	         ret
WriteNum endp

	;Reads a string from the console and stores it at address AX.
ReadStr proc
	         push DX AX SI BX
	         mov  DX, AX
	         mov  AH, 10
	         int  21h
	         inc  DX
	         mov  SI, DX
	         mov  BL, [SI]
	         xor  BH, BH
	         inc  DX
	         add  BX, DX
	         mov  byte ptr [BX], '$'
	         pop  BX SI AX DX
	         call EndLine
	         ret
ReadStr endp
	
	;Gets the address from AX and writes the string to the console.
WriteStr proc
	         push DX AX
	         mov  DX, AX
	         mov  AH, 9
	         int  21h
	         pop  AX DX
	         call EndLine
	         ret
WriteStr endp
end Main