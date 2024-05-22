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
	      assume ss:sseg, ds:dseg, es:eseg, cs:cseg,
Main proc far
	      push   ds
	      xor    ax, ax
	      push   ax
	      mov    ax, dseg
	      mov    ds, ax
	      mov    ax, eseg
	      mov    es, ax
	      mov    ah, 10
	      lea    dx, array
	      int    21h
	      xor    bl, bl
	      xor    ch, ch
	      mov    cl, array[1]
	      lea    si, array[2]
	      lea    di, es:array2
	      cld
	      rep    movsb
	      mov    al, 'S'
	      lea    di, es:array2
	      xor    ch, ch
	      mov    cl, array[1]
	      repne  scasb
	      jz     lab1
	      mov    ah, 9
	      lea    dx, message
	      int    21h
	      jmp    final
	lab1: mov    cx, 2
	      lea    di, es:tox
	      mov    al, '7'
	      rep    stosb
	      mov    cx, 3
	      lea    di, es:tox[2]
	      mov    al, '*'
	      rep    stosb
	      mov    cx, 2
	      lea    di, es:tox[5]
	      mov    al, '9'
	      rep    stosb
	      mov    ah, 9
	      lea    dx, es:tox
	      int    21h
	final:ret
Main endp
cseg ends
end Main