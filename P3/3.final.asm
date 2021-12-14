.data
A:	.asciiz "Hola mundo dos"
B:	.asciiz "              "
C:	.asciiz "              "
esp:	.asciiz " "
D:	.word 0

.text
main:	la $s3, A		# Copiamos las direcciones

	la $t0, B
	la $t1, C
	
	la $t6, esp
	lbu $s4, 0($t6)		
	
	la $s1, D
	lw $s5, 0($s1)
	
	li $t3, 0		# para detectar los pares
	li $s0, -1		# inidializamos i = -1

Strcpy:	addi $s0, $s0, 1	# i++ (se inicia con i = 0)

	add $t2, $s0, $s3	# a(i)
	lbu $t2, 0($t2)		# Contenido de a(i)
	
	beq $t2, $zero, Out	# si a(i) = 0 vamos a Out
	bne $s4, $t2, Comprb	# comprobamos si el caracter es un espacio
				# si no lo es, vamos a Compr
	addi $s5, $s5, 1	# si lo es, añadimos un 1 a su registro

Comprb:	beq $s0, $t3, Par	# comprobamos si es par, si lo es, vamos a Par

	add $t4, $t1, $s0	# si no lo es, añadimos al registro impar
	sb $t2, 0($t4)		# y lo guardamos
	
	j Strcpy

Par:	add $t5, $t0, $s0	# es par, lo añadimos a su registro
	sb $t2, 0($t5)		# y lo guardamos
	
	addi $t3, $t3, 2
	
	j Strcpy

Out:	li $v0, 4		
	add $a0, $zero, $t0	# para imprimir B
	syscall
	
	li $v0, 4
	add $a0, $zero, $t1	# para imprimir C
	syscall
	
	sw $s5, 0($s1)
	li $v0, 1
	lw $s5, 0($s1)
	add $a0, $zero, $s5	# para imprimir D
	syscall
	
	li $v0, 10
	syscall
	
	
