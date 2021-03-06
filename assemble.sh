#!/bin/bash

set -euxo pipefail

crate=riscv-rt

# remove existing blobs because otherwise this will append object files to the old blobs
rm -f bin/*.a

riscv64-unknown-elf-gcc -ggdb3 -c -mabi=ilp32 -march=rv32imac asm.S -o bin/$crate.o
riscv64-unknown-elf-ar crs bin/riscv32imac-unknown-none-elf.a bin/$crate.o
riscv64-unknown-elf-ar crs bin/riscv32imc-unknown-none-elf.a bin/$crate.o

riscv64-unknown-elf-gcc -ggdb3 -c -mabi=ilp32 -march=rv32i asm.S -o bin/$crate.o
riscv64-unknown-elf-ar crs bin/riscv32i-unknown-none-elf.a bin/$crate.o

riscv64-unknown-elf-gcc -ggdb3 -c -mabi=lp64 -march=rv64imac asm.S -o bin/$crate.o
riscv64-unknown-elf-ar crs bin/riscv64imac-unknown-none-elf.a bin/$crate.o
riscv64-unknown-elf-ar crs bin/riscv64gc-unknown-none-elf.a bin/$crate.o

rm bin/$crate.o
