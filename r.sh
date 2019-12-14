#!/bin/bash


rm *.o
rm *.out
rm *.lis

echo "Assemble assign5.asm"
nasm -f elf64 -l assign5.lis -o assign5.o assign5.asm

echo "Compile driver.c"
gcc -c -Wall -m64 -no-pie -o driver.o driver.c -std=c11

echo "Link the object files using the gcc linker standard 2011"
gcc -m64 -no-pie -o test.out assign5.o driver.o -std=c11

echo "Run the program Floating IO:"
./test.out

echo "The script file will terminate"
