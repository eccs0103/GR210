.model small
.stack 64
.data
	Text db 20, 21 dup(?)
.code
Main proc far
	         mov  AX, @data
	         mov  DS, AX
	;Code below
	         
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

	;Converts the number in AL to a character.
NumToChr proc
	         add  AL, 30h
	         ret
NumToChr endp

	;Converts the character in AL to a number.
ChrToNum proc
	         sub  AL, 30h
	         ret
ChrToNum endp

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

	;Writess the character in AL to the console.
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
