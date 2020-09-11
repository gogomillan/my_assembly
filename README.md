# My_assembly
Everything you need to know about basics in x86-64 Assembly

## :book: Table of content
- [Requirements](#Requirements)
- [Assembly_syntax](#Assembly_syntax)
- [Assembly_to_ELF_object_file](#Assembly)
- [Static_sections](#Static_sections)
- [Workshop](#Workshop)
- [Author](#Author)
- [License](#License)

## Requirements
Heres a list of the different tools used during this concept: 
- Linux 3.13.0-92-generic
- Ubuntu 14.04 LTS
- NASM version 2.10.09
- gcc version 4.8.4
- [EYNTK] x86-64 Assembly (Refference to the Holberton's intranet)

## Assembly_syntax
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

## Static_sections

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

## Workshop

### Task 0: Add me

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

## Author
Gonzalo Gomez Millan  
:octocat: [GitHub](https://github.com/gogomillan)  
:newspaper: [Twitter](https://twitter.com/gogomillan)  
:notebook: [LinkedIn](https://linkedin.com/in/gogomillan)  

## License
MIT Licence [(read)](LICENSE)
