
#!/bin/bash

#Program: Random Array
#Author: Leo Hyodo

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble executive.asm"
nasm -f elf64 -l executive.lis -o executive.o executive.asm

echo "Assemble fill_random_array.asm"
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

echo "Assemble show_array.asm"
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm

echo "Assemble normalize_array.asm"
nasm -f elf64 -l normalize_array.lis -o normalize_array.o normalize_array.asm

echo "compile main.c using gcc compiler standard 2017"
gcc -c -Wall -m64 -fno-pie -no-pie -o main.o main.c -std=c17

echo "compile quick_sort.c using the gcc compiler standard 2017"
gcc -c -Wall -no-pie -m64 -std=c17 -o quick_sort.o quick_sort.c

echo "Link object files using the gcc Linker standard 2017"
gcc -m64 -no-pie -o array-random.out executive.o main.o fill_random_array.o show_array.o quick_sort.o normalize_array.o -std=c17

echo "Run the Random Array Program:"
./array-random.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
