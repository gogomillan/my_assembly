GLOBAL main

main:
	; put 1 (1 byte int/char) into accumulator register
	mov	eax, 1
	; add 2 (1 byte int/char), storing result in accumulator
	add     eax, 2

	ret
