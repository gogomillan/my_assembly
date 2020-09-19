; NASM code style

	section	.text		; Code section
	global	add_me		; Exporting the function name

add_me:				; The symbol or function label
	mov	eax, edi	; Put the first argument into accumulator register
	add	eax, esi	; Put the second argument into accumulator register

	ret			; Return
