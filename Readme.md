Created a basic calulator for 8-bit unsigned integters using x86-32bit assembly for linux machines.

### Pre-requisites
1. User needs to be on a 32-bit linux machine, either a virtual or actual one.
2. User must install `nasm` assembler. To install do `sudo apt install nasm`

### Installation and Running
1. To run simply copy and paste the two files in the same folder
2. Open a terminal in the folder.
3. Use the `run.sh` bash script file to assemble, link and run all at once.
4. Type `./run.sh calc` , to do the same.
5. Make sure to replace `calc` with the file name of assembly file if you decide to change it.

### Bugs
Unable to output result integer as a string and thus the program uses `ebx` register to return the result as the return code of the program.
The output does looks formatted by=ut requires further work.
