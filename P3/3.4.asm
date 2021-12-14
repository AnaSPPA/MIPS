.data
A:	.asciiz "Hello world!"
B:	.asciiz	""
.text
main:	la $a0, A
	la $a1, B
	
	jal Cdncpy
	
	li $v0, 10
	syscall
	
Cdncpy:	li $t0, 0

Strcpy:	add $t1, $t0, $a0
	lbu $t1, 0($t1)
	beq $t1, $zero, Exit
	add $t2, $t0, $a1
	sb $t1, 0($t2)
	addi $t0, $t0, 1
	j Strcpy

Exit:	add $v1, $s1, $zero
	
	jr $ra