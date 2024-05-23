.model small
.stack 64
.data
	
.code
Main proc far
	         mov  ax, @data
	         mov  ds, ax
	;Code below
	         
	;Code above
	         ret
Main endp

	;Clears the console
Clear proc
	         push ax
	         mov  al, 2
	         xor  ah, ah
	         int  10h
	         pop  ax
	         ret
Clear endp

	;Converts the number in AL to a character.
NumToChr proc
	         add  al, 30h
	         ret
NumToChr endp

	;Converts the character in AL to a number.
ChrToNum proc
	         sub  al, 30h
	         ret
ChrToNum endp

	;Reads a character from the console and stores it in AL.
ReadChr proc
	         push ax dx
	         mov  ah, 1
	         int  21h
	         mov  dl, al
	         pop  ax
	         mov  al, dl
	         pop  dx
	         ret
ReadChr endp

	;Writess the character in AL to the console.
WriteChr proc
	         push ax
	         mov  dl, al
	         mov  ah, 6
	         int  21h
	         pop  ax
	         ret
WriteChr endp

	;Writes a newline to the console
EndLine proc
	         push ax
	         mov  al, 10
	         call WriteChr
	         mov  al, 13
	         call WriteChr
	         pop  ax
	         ret
EndLine endp

	;Writes the number in AX to the console.
WriteNum proc
	         push bx cx ax dx
	         mov  bx, 10
	         xor  cx, cx
	CheckDig:xor  dx, dx
	         div  bx
	         push dx
	         inc  cx
	         cmp  ax, 0
	         jne  CheckDig
	         xor  ax, ax
	PopDigs: pop  dx
	         add  dx, 30h
	         mov  ah, 6
	         int  21h
	         loop PopDigs
	         pop  dx ax cx bx
	         call EndLine
	         ret
WriteNum endp

	;Reads a string from the console and stores it at address AX.
ReadStr proc
	         push dx si bx
	         mov  dx, ax
	         mov  ah, 10
	         int  21h
	         inc  dx
	         mov  si, dx
	         mov  bl, [si]
	         xor  bh, bh
	         inc  dx
	         mov  ax, dx
	         add  bx, ax
	         mov  byte ptr [bx], '$'
	         pop  bx si dx
	         call EndLine
	         ret
ReadStr endp
	
	;Gets the address from AX and writes the string to the console.
WriteStr proc
	         push dx ax
	         mov  dx, ax
	         mov  ah, 9
	         int  21h
	         pop  ax dx
	         call EndLine
	         ret
WriteStr endp

end Main
