# My_assembly <br/> <h2>The workshop</h2>
Everything you need to know about basics in x86-64 Assembly

## :book: Table of content
- [Requirements](#Requirements)
- [Assembly_syntax](#Assembly_syntax)
- [Assembly_to_ELF_object_file](#Assembly)
- [Author](#Author)
- [License](#License)

## Requirements
Heres a list of the different tools used during this concept: 
- Linux 3.13.0-92-generic
- Ubuntu 14.04 LTS
- NASM version 2.10.09
- gcc version 4.8.4

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

## Author
Gonzalo Gomez Millan  
:octocat: [GitHub](https://github.com/gogomillan)
:newspaper: [Twitter](https://twitter.com/gogomillan)
:notebook: [LinkedIn](https://linkedin.com/in/gogomillan)

## License
MIT Licence [(read)](LICENSE)
