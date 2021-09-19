.data

.globl c
c: .byte -20

.globl i
.align 4
i: .int -256

.globl ui
.align 4
ui: .long 1024

.globl l
.align 8
l: .quad 128

.globl ul
.align 8
ul: .quad 2048

.globl v
.align 4
v: .int 10, 20, 30, 40, 50

.globl us
.align 2
us: .word 111

.text

.globl aux
aux:
	pushq %rbp
	movq  %rsp, %rbp

	# Se necessário, usar apenas os registradores 
	# (ou suas variações) abaixo:
	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11

	# ptr -> %r8

	# i = c
	movb	c, %al		# al = c
	movsbl	%al, %eax	# eax = (int)al  (extensão)
	movl	%eax, i		# i = eax

	# ui = i
	movl	i, %ecx		# ecx = i
	movl	%ecx, ui	# ui = ecx

	# ul = ui
	movl	ui, %eax	# eax = ui
	movq	%rax, ul	# ul = rax

	# us = ul
	movq	ul, %r9
	movw	%r9w, us

	# reg = i
	# reg = reg + 10
	# reg = reg - 5
	# c = (char)reg
	movl	i,   %eax
	addl	$10, %eax
	subl	$5,  %eax
	movb	%al, c

	# ptr = &l
	movq	$l, %r8		# r8  = &l
	movq	$128, (%r8)	# *r8 = 128

	leave
	ret
