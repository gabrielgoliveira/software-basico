.section .rodata

	cond1: .string "'a' é maior do que 'b'\n"
	cond2: .string "'a' não é maior do que 'b'\n"

.data
	.globl a
	.align 4
	a: .int 30
	
	.globl a
	.align 4
	b: .int 45

.text

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp



   # Seu código aqui...



   movl $0, %eax

   leave

   ret
