

extern printf
extern scanf
global assign5

segment .data
welcome db "Welcome to the Right Triangle Analyzer",10,0
input2prompt db "Please input the lengths of the two legs of a right triangle separated by ws and press enter ",0
area db "The area of the triangle is %7.4lf", 10,0
hypo db "The hypotenuse has length %7.7lf", 10,0
good_bye db "This module will now return the hypotenuse to the caller",10,0

two_float_format db "%lf %lf",0


output_two_float db "The length of the sides are %5.3lf and %5.3lf.",10,0


segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

assign5:


push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;Registers rax, rip, and rsp are usually not backed up.
push qword 0


;Display a welcome message to the viewer.
mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, welcome               ;"The Assembly function floatio has begun execution"
call printf


;Display a prompt message asking for inputs
push qword 99
mov rax, 0
mov rdi, input2prompt          ;"Please input 2 floating point numbers using the keyboard: "
call printf
pop rax


push qword 99 ;Get on boundary
;Create space for 2 float numbers
push qword -1
push qword -2
mov rax, 0
mov rdi, two_float_format      ;"%lf%lf"
mov rsi, rsp                   ;rsi points to first quadword on the stack
mov rdx, rsp
add rdx, 8                     ;rdx points to second quadword on the stack
call scanf

movsd xmm12, [rsp]
movsd xmm13, [rsp+8]
pop rax                        ;Reverse the previous "push qword -2"
pop rax                        ;Reverse the previous "push qword -1"
pop rax                        ;Reverse the previous "push qword 99"

;Display 2 float numbers
push qword 99                  ;Get on the boundary
mov rax, 2
mov rdi, output_two_float
movsd xmm0, xmm12
movsd xmm1, xmm13
call printf
pop rax                        ;Reverse previous "push qword 99"

;Find area
movsd xmm14, xmm12
mulsd xmm14, xmm13
mov rbx, 0x4000000000000000
push rbx
divsd xmm14, [rsp]
pop rax

;display area
push qword 99
mov rax, 1
mov rdi, area
movsd xmm0, xmm14
call printf
pop rax

;find hypotenuse
mulsd xmm12, xmm12
mulsd xmm13, xmm13
addsd xmm12, xmm13
sqrtsd xmm15, xmm12

;display hypotenuse
push qword 99
mov rax, 1
mov rdi, hypo
movsd xmm0, xmm15
call printf
pop rax

;========== Prepare to exit from this program ==================================================================

;Display good-bye message (the next block of instructions)
mov rax, 0
mov rdi, good_bye
call printf

pop rax                        ;Reverse the push near the beginning of this asm function.

movsd xmm0, xmm15              ;Select the largest value for return to caller.

;===== Restore original values to integer registers ===============================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
