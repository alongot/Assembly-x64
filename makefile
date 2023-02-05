all: main

main: main.o functions64.o sortfunctions.o
	ld  main.o functions64.o sortfunctions.o -o main

main.o: main.asm
	nasm -g -f elf64 -F dwarf main.asm -l main.lst
	
sortfunctions.o: sortfunctions.asm
	nasm -g -f elf64 -F dwarf sortfunctions.asm -l sortfunctions.lst

clean:
	rm -f ./main.o || true
	rm -f ./sortfunctions.o || true
	rm -f ./sortfunctions.lst || true
	rm -f ./main.lst || true
	rm -f ./main || true
