.PHONY: all

all:
	bunx peggy -o bin/gyro-parser.js src/gyro-grammar.peggy

compile:
	nasm -F dwarf -g -f elf32 -o $(in).o $(in) 
	ld -m elf_i386 -o $(out) $(in).o
	rm $(in).o