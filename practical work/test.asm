.model small
.stack 64
.data
	Message db "chka$"
.code
Main proc far
	         mov  AX, @data
	         mov  DS, AX
	;Code below
	         call Clear
	         xor  AL, AL
	         xor  CX, CX
	Input:   call ReadChr
	         cmp  AL, '&'
	         je   End1
	         call IsUpper
	         cmp  DL, 1
	         jne  Next1
	         call ToLower
	         call WriteChr
	         inc  CX
	Next1:   jmp  Input
	End1:    cmp  CX, 0
	         jg   End3
	         call EndLine
	         lea  AX, Message
	         call WriteStr
	End3:    
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

	;Returns (0 | 1) in DL if the character in AL is upper
IsUpper proc
	         xor  DL, DL
	         cmp  AL, 'A'
	         jb   End2
	         cmp  AL, 'Z'
	         ja   End2
	         mov  DL, 1
	End2:    ret
IsUpper endp
	;Makes upper character in AL to lower
ToLower proc
	         add  AL, 20h
	         ret
ToLower endp

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
