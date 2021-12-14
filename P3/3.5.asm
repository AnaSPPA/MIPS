.data
A:	.space 128
B:	.space	128
n:	.word 

.text
main:	la $a0, A		# Copia la direccion del vector A
	li $a1, 128		# Y hacemos hueco para el input
	li $v0, 8		# Input string
	syscall

	la $a1, B		# Direccion del vector B
	
	la $a2, n
	li $v0, 5			# Input numero
	syscall
	sw $v0, 0($a2)			# Guarda la respuesta

	jal CnvMay			# Todo a mayusculas
	
	jal CopInv			# Invierte la cadena
	
	li $t0, 0
	lbu $s2, 0($a2)			# Cargamos el numero
	
	jal QuitEs			# Quita los n espacios
	
	li $a0, 0
	
	li $v0, 4		
	add $a0, $zero, $t2		# Para imprimir B
	syscall
	
	li $v0, 10			#Fin
	syscall
	
CnvMay:	li $t0, 0

While:	add $s0, $t0, $a0		
	lbu $t1, 0($s0)			# Lee el primer caracter de A
	beq $t1, $zero, FinM		# Si caracter = 0 -> Fin
	
	addi $t2, $zero, 90		# Cargamos el valor de la ultima letra mayuscula (ascii 90 = Z)
	ble $t1, $t2, Save		# Si nuestro caracter < Z -> guardamos
	
	addi $t1, $t1, -32		# Sino, hayamos su correspondiente mayuscula
	
Save:	sb $t1, 0($s0)			# Guardamos caracter en mayuscula
	addi $t0, $t0, 1
	
	j While
	
FinM:	jr $ra				# Vuelta al main


CopInv:	li $t0, 0
	li $t1, 0
	li $s1, -1

	move $a3, $a0			# Para no cargarnos la direccion inicial de a0
	
StrLn:	lb $t2, 0($a3)			# Averiguamos el tamaño del String
	
	beq $t2, $zero, Strcpy		# Si el caracter = 0 -> pasamos a copiar la cadena al revés
	
	addi $s1, $s1, 1		# Tamaño++
	addi $a3, $a3, 1		# Caracter++
	
	j StrLn
	
Strcpy:	add $t1, $t0, $a0
	lbu $t1, 0($t1)			# a(i)
	beq $t1, $zero, FinC		# a(i) = 0 -> no copiamos más
	
	add $t2, $s1, $a1		# Cargamos la ultima posicion de B
	sb $t1, 0($t2)			# Guardamos en b(i)
	
	addi $t0, $t0, 1		
	addi $s1, $s1, -1		
	
	j Strcpy
	
FinC:	jr $ra				# Fin de copia

QuitEs:	add $t1, $t0, $t2
	lbu $t3, 0($t1)			# Cargamos b(i)
	
	beq $t3, $zero, FinB		# Si es nulo -> Fin
	
	beq $t3, 32, BorrEs		# Si es un espacio -> Borramos 
	
	sb $t3, 0($t1)			# Sino, guardamos tal cual
	
	addi $t0, $t0, 1
	j QuitEs
	
BorrEs:	beq $t3, $zero, FinB		# Caracter nulo -> Fin
	
	addi $t0, $t0, 1		
	add $t1, $t0, $t2
	lbu $t3, 0($t1)			# Cargamos el siguiente caracter al espacio (o al caracter actual)
	
	beq $t3, 32, Rept		# Si es un espacio -> Rept
	
	addi $t0, $t0, -1
	add $t1, $t0, $t2
	
	sb $t3, 0($t1)			# Sino, lo sobreescribimos con el siguiente caracter
	
	addi $t0, $t0, 1
	
	j BorrEs

Rept:	addi $s2, $s2, -1
	
	ble $s2, $zero, FinB		# Si n introducido = 0 -> Fin

	addi $t0, $t0, 1		# Repetimos lo mismo que en BorrEs
	add $t1, $t0, $t2
	lbu $t3, 0($t1)
	
	addi $t0, $t0, -1
	add $t1, $t0, $t2
	
	sb $t3, 0($t1)
	
	addi $t0, $t0, 1
	
	j BorrEs
	
FinB:	jr $ra				# Fin de borrar
