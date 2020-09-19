# My_assembly
Everything you need to know about basics in x86-64 Assembly

## :books: Table of content
- [Requirements](#Requirements)
- [Assembly syntax](#Assembly-syntax)
- [Assembly_to_ELF_object_file](#Assembly)
- [Static sections](#Static-sections)
- [Workshop](#Workshop-arrow_up)
- [Author](#Author-arrow_up)
- [License](#Licence-arrow_up)

## Requirements
Heres a list of the different tools used during this concept: 
- Linux 3.13.0-92-generic
- Ubuntu 14.04 LTS
- NASM version 2.10.09
- gcc version 4.8.4
- [EYNTK] x86-64 Assembly (Refference to the Holberton's intranet)

## Assembly syntax
- x86 Assembly
- 64-bit architecture
- Intel

## Assembly to ELF object file
Do you remember the different steps to transform a C source file onto an
executable file? Here it goes:

- Preprocessing (Remove comments, replace macros, include headers, )
- Compilation (Compile C into assembly)
- Assembly (Assemble to object file)
- Linking (Link object files to form the executable)

It is pretty easy to guess that we will only need the two last steps in order
to transform our assembly code onto an executable. One thing though: were only
gonna use gcc for linking.

In order to assemble our code to form an object file, well use the tool nasm
(apt-get install nasm).

Heres the command line well use to assemble our asm files:
```
$ nasm -f elf64 <file.asm>
```
This command forms a .o file that we can then link with other .o files (even
if they were compiled from C source code).

## Static sections

- Code: .text
- Read-only data: .rodata
- Read/write data: .data
- Unitialized data: .bss
- See nm and objdump


**Example:**
```
alex@~/0x09-libasm/Concept$ cat example_0.asm 
BITS 64

global my_function      ; EXPORT our function 'my_function'
extern another_function     ; IMPORT the function 'another_function'

section .data
                ; Declare static data
    my_str db "Holberton", 0Ah, 0
    ; "Holberton", followed by a new line (0A hexa), and \0


section .text
                ; Code section

my_function:            ; This is a symbol
    ; Do some
    ; some
    ; stuff
    ; here
alex@~/0x09-libasm/Concept$ nasm -f elf64 example_0.asm 
alex@~/0x09-libasm/Concept$ 
```

## Workshop \[[:arrow_up:](#My_assembly)\]

### Task 0: Hello Worl!
Write a program that writes Hello wolrd text on the screen

**Example:**
```bash
vagrant@gogomillan:~$ cat hello_64.asm
; Equivalent C code
; /* hello.c */
; #include <stdio.h>
; int main()
; {
;   char msg[] = "Hello world\n";
;   printf("%s\n",msg);
;   return (0);
; }

; NASM code style
; Declare needed C  functions
        extern  printf          ; the C function, to be called

        section .data           ; Data section, initialized variables
msg:    db "Hello world", 0     ; C string needs 0
fmt:    db "%s", 10, 0          ; The printf format, "\n",'0'

        section .text           ; Code section.

        global  main            ; the standard gcc entry point
main:                           ; the program label for the entry point
        push    rbp             ; set up stack frame, must be alligned

        mov     rdi, fmt
        mov     rsi, msg
        mov     rax, 0          ; or can be  xor  rax,rax
        call    printf          ; Call C function

        pop     rbp             ; restore stack

        mov     rax, 0          ; normal, no error, return value
        ret                     ; return
vagrant@gogomillan:~$ nasm -f elf64 hello_64.asm
vagrant@gogomillan:~$ gcc -o hello_64  hello_64.o
vagrant@gogomillan:~$ ./hello_64
Hello world
vagrant@gogomillan:~$
```
**File:** 
\[ [hello_64.asm](hello_64.asm) \]

### Task 1: Returning!
Write a program that add two numbers and return the return to the OS

**Example:**
```bash
vagrant@gogomillan:~$ cat sum.asm
; NASM code style

        section .text   ; Code section
        global  main    ; The standard gcc entry point

main:                   ; The program label for the entry point
        mov     eax, 1  ; put 1 (1 byte int/char) into accumulator register
        add     eax, 2  ; add 2 (1 byte int/char), storing result in accumulator

        ret             ; Return
vagrant@gogomillan:~$ nasm -f elf64 sum.asm
vagrant@gogomillan:~$ gcc -o sum sum.o
vagrant@gogomillan:~$ ./sum
vagrant@gogomillan:~$ echo $?
3
vagrant@gogomillan:~$
```
**File:** 
\[ [sum.asm](sum.asm) \]

### Task 2: Add me

Write a simple procedure in Assembly that takes two integers as parameters
(32-bit), and returns their sum as an integer (32-bit).  

For this problem you dont have to use any local variable, so you dont have to
take care of the stack yet.  

The purpose here is to learn how to do simple arithmetic on registers and return
a value.

**Example:**  
```bash
alex@~/0x09-libasm/Concept$ cat add_me_main.c 
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int add_me(int a, int b);

/**
 * main - Program entry point
 * @argc: Arguments counter
 * @argv: Arguments vector
 *
 * Return: EXIT_SUCCESS or EXIT_FAILURE
 */
int main(int argc, const char *argv[])
{
    int a;
    int b;
    int res;

    if (argc < 3)
    {
        dprintf(STDERR_FILENO, "Usage: %s <a> <b>\n", argv[0]);
        return (EXIT_FAILURE);
    }

    a = atoi(argv[1]);
    b = atoi(argv[2]);
    res = add_me(a, b);

    printf("%d + %d = %d\n", a, b, res);

    return (EXIT_SUCCESS);
}
alex@~/0x09-libasm/Concept$ nasm -f elf64 add_me.asm 
alex@~/0x09-libasm/Concept$ gcc -c add_me_main.c 
alex@~/0x09-libasm/Concept$ gcc add_me.o add_me_main.o 
alex@~/0x09-libasm/Concept$ ./a.out 402 98
402 + 98 = 500
alex@~/0x09-libasm/Concept$ ./a.out 1 1
1 + 1 = 2
alex@~/0x09-libasm/Concept$ ./a.out 23424 234234
23424 + 234234 = 257658
alex@~/0x09-libasm/Concept$ 
```
**Files:** 
\[ [add_me.asm](add_me.asm) \]

### Task 3: Swap
Write a procedure in Assembly that takes two pointers to int as parameters
(64-bit), and swap the values they point to. Your procedure does not return
anything.

The purpose here is to learn how to manipulate data that is not stored in
registers but in memory.

**Example:**
```bash
alex@~/0x09-libasm/Concept$ cat swap_main.c 
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void swap(int *a, int *b);

/**
 * main - Program entry point
 * @argc: Arguments counter
 * @argv: Arguments vector
 *
 * Return: EXIT_SUCCESS or EXIT_FAILURE
 */
int main(int argc, const char *argv[])
{
    int a;
    int b;

    if (argc < 3)
    {
        dprintf(STDERR_FILENO, "Usage: %s <a> <b>\n", argv[0]);
        return (EXIT_FAILURE);
    }

    a = atoi(argv[1]);
    b = atoi(argv[2]);

    printf("Before: a = %d, b = %d\n", a, b);

    swap(&a, &b);

    printf("After: a = %d, b = %d\n", a, b);

    return (EXIT_SUCCESS);
}
alex@~/0x09-libasm/Concept$ nasm -f elf64 swap.asm 
alex@~/0x09-libasm/Concept$ gcc -c swap_main.c 
alex@~/0x09-libasm/Concept$ gcc swap.o swap_main.o 
alex@~/0x09-libasm/Concept$ ./a.out 402 98
Before: a = 402, b = 98
After: a = 98, b = 402
alex@~/0x09-libasm/Concept$ ./a.out 1234 5678
Before: a = 1234, b = 5678
After: a = 5678, b = 1234
alex@~/0x09-libasm/Concept$ 
```
**Files:** 
\[ [swap.asm](swap.asm) \]


## Author \[[:arrow_up:](#My_assembly)\]
Gonzalo Gomez Millan  
[![GitHub](https://img.shields.io/badge/github-%23100000.svg?&style=for-the-badge&logo=github&logoColor=white)](https://github.com/gogomillan)
[![Tweeting](https://img.shields.io/badge/twitter-%231DA1F2.svg?&style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/gogomillan)
[![Linking](https://img.shields.io/badge/linkedin-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/gogomillan)

## Licence \[[:arrow_up:](#My_assembly)\]
MIT
\[ [Read](LICENSE) \]
