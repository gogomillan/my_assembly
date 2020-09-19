; NASM code style

	section	.text		; Code section
	global	swap		; Exprting the function name

swap:				; The sumbol or function name label
	mov	eax, [rdi]	; Store the value pointed by the first argument into eax(int val)
				; rdi(long) points to the memory address for first argument
	xor	eax, [rsi]	; Apply xor to the first argument previous stored from the
				; second one. The eax register will have the parity.
	xor	[rdi], eax	; Apply the parity to the fist value pointed, then get the second one
	xor	[rsi], eax	; Apply the parity to the second value pointed, then get the first one

	ret			; Return
