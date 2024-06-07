global _start

section .data
intro db "Welcome to the Assembed Calulator!",0x0a,"Choose an operation:",0x0a,"1.Add",0x0a,"2.Subtract",0x0a,"3.Multiply",0x0a,"4.Divide",0x0a,"Enter Your Choice: "
len_intro equ $-intro
op1 db "Enter operand 1:"
len_op1 equ $-op1 
op2 db "Enter operand 2:"
len_op2 equ $-op2
zero_err db "Cannot divide by 0!"
len_err equ $-zero_err
res db "The result is "
len_res equ $-res
inv db "Invalid operation",0x0a
len_inv equ $-inv
nl db 0x0a
lnl equ $-nl

section .bss
func: resb 4
oper1: resb 4
oper2: resb 4
result: resb 4
temp: resb 4

section .text
_start : 

mov ecx,intro
mov edx,len_intro
call print
lea ecx,[func]
mov edx,4
call input
xor eax,eax
lea esi,[func]
call convert
mov [func],eax

mov ecx,op1
mov edx,len_op1
call print
lea ecx,[oper1]
mov edx,4
call input
xor eax,eax
lea esi,[oper1]
call convert
mov [oper1],eax

mov ecx,op2
mov edx,len_op2
call print
lea ecx,[oper2]
mov edx,4
call input
xor eax,eax
lea esi,[oper2]
call convert
mov [oper2],eax

mov ax,[func]
 
cmp ax,1
je addF

cmp ax,2
je subF

cmp ax,3
je multF

cmp ax,4
je divF

mov ecx,inv
mov edx,len_inv
call print
mov eax,1
mov ebx,0
int 0x80
 

print_result_string:
mov ecx,res
mov edx,len_res
call print
;mov cx,0
;mov eax,[result]
;mov ecx,10

exit:
;mov ecx,nl
;mov edx,lnl
;call print
mov eax,1
mov ebx,[result]
int 0x80 


err_exit:
mov ecx,zero_err
mov edx,len_err
call print
mov eax,1
mov ebx,0
int 0x80 

inter:
pop edx
jmp edx


convert:
    movzx edx, byte [esi]
    cmp edx, 0x0a  ; newline character
    je inter
    imul eax, 10
    sub edx, '0'
    add eax, edx
    inc esi
    jmp convert

input:
push ebp
mov ebp,esp
mov eax,3
mov ebx,0
int 0x80
mov esp,ebp
pop ebp
ret

divF:
push ebp
mov ebp,esp
mov bl,[oper2]
cmp bl,0
je err_exit
mov ax,[oper1]
div bl
mov [result],al
mov esp,ebp
pop ebp
jmp print_result_string


multF:
push ebp
mov ebp,esp
mov ax,[oper1]
mov bx,[oper2]
mul bx
mov [result],ax
mov esp,ebp
pop ebp
jmp print_result_string



subF:
push ebp
mov ebp,esp
mov ax,[oper1]
sub ax,[oper2]
mov [result],ax
mov esp,ebp
pop ebp
jmp print_result_string


addF:
push ebp
mov ebp,esp
mov ax,[oper1]
mov bx,[oper2]
add ax,bx
mov [result],ax
mov esp,ebp
pop ebp
jmp print_result_string


print:
push ebp
mov ebp,esp
push eax
push ebx
mov eax,4
mov ebx,1
int 0x80
pop ebx
pop eax
mov esp,ebp
pop ebp
ret
