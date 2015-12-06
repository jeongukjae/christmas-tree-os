all: build

build:
	nasm -o BootLoader.bin BootLoader.asm
	nasm -o Kernel.bin Kernel.asm
	cat BootLoader.bin Kernel.bin > OS.img

run:
	qemu-system-x86_64 -fda ./OS.img