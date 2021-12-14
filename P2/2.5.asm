.data
A:	.asciiz "Hola Mundo Dos\0"
B:	.asciiz "B:                "
C:	.asciiz "C:                "
.text
main:	la $s0, A
	la $s1, B
	la $s2, C
	li $s3, 0
	li $t1, 0
	li $t2, 1
	
Cadcpy:	add $t0, $s3, $s0
	lbu $t0, 0($t0)
	
	beq $t0, $zero, Exit
	
	beq $s3, $t1, Par
	
	beq $s3, $t2, Impar
	
Par:	add $t3, $s3, $s2
	sb $t0, 0($t3)
	addi $t1, $t1, 2
	j Inicio
	
Impar:	add $t3, $s3, $s1
	sb $t0, 0($t3)
	addi $t2, $t2, 2
	j Inicio

Inicio:	addi $s3, $s3, 1
	j Cadcpy
	
Exit:	li $v0, 4
	add $a0, $zero, $s2
	syscall
	li $v0, 4
	add $a0, $zero, $s1
	syscall
	li $v0, 10
	syscall
