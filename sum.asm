; NASM code style

	section	.text	; Code section
	global	main	; The standard gcc entry point

main:			; The program label for the entry point
	mov	eax, 1	; put 1 (1 byte int/char) into accumulator register
	add	eax, 2	; add 2 (1 byte int/char), storing result in accumulator

	ret		; Return
