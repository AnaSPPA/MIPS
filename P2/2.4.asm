.data
A:	.asciiz "Hello world!"
B:	.asciiz 
.text
main:	la $s0, A
	la $s1, B
	li $s2, 0
	
Strcpy:	add $t1, $s2, $s0
	lbu $t1, 0($t1)
	beq $t1, $zero, Exit
	add $t2, $s2, $s1
	sb $t1, 0($t2)
	addi $s2, $s2, 1
	j Strcpy
	
Exit:	li $v0, 4
	add $a0, $zero, $s1
	syscall
	li $v0, 10
	syscall
	