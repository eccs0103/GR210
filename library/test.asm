.model small
.stack 64
.data
	NewLine db 10, 13, '$'
.code
Main proc far
	         mov  ax, @data
	         mov  ds, ax
	;Code below
	         
	;Code above
	         ret
Main endp

	; Converts the number in AL to a character.
NumToChr proc
	         add  al, 30h
	         ret
NumToChr endp
	
	; Converts the character in AL to a number.
ChrToNum proc
	         sub  al, 30h
	         ret
ChrToNum endp
	
	; Writes the number in AX to the console.
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
	         ret
WriteNum endp
	
	; Reads a character from the console and stores it in AL.
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
	
	; Writes the character in AL to the console.
WriteChr proc
	         push ax
	         mov  dl, al
	         mov  ah, 6
	         int  21h
	         pop  ax
	         ret
WriteChr endp
	
	; Reads a string from the console and stores it at address DX.
ReadStr proc
	         push ax
	         mov  ah, 10
	         int  21h
	         pop  ax
	         ret
ReadStr endp
	
	; Gets the address from DX and writes the string to the console.
WriteStr proc
	         push ax
	         mov  ah, 9
	         int  21h
	         pop  ax
	         ret
WriteStr endp
	
	; Clears the console
Clear proc
	         push ax
	         mov  al, 2
	         xor  ah, ah
	         int  10h
	         pop  ax
	         ret
Clear endp

end Main
