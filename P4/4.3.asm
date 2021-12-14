.data
msg01:	.asciiz	"Escriba el valor del parámetro 'x': "
msg02:	.asciiz	"Ahora el del parámetro 'i': "
msg03:	.asciiz	"Y el del parámetro 'j': "
msg04:	.asciiz	" - Algún parámetro se sale de rango"
msg05:	.asciiz	" - El parámetro 'i' es mayor que 'j'"
msg06:	.ascii " - Todo correcto, el resultado es: "
.text
main:	li $s0, 31		#para comprobar si se sale de rango

	la $a0, msg01
	li $v0, 4		#pedimos x
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	la $a0, msg02		#pedimos i
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	la $a0, msg03		#pedimos j
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $a2, $v0		#parámetros
	move $a1, $t1
	move $s5, $t1		#duplico 'i' para desplazar el nº final a la derecha
	move $a0, $t0
	
	
	jal RepBin
	
	move $a0, $v0		#nº que indica el error a a0
	
	li $v0, 1		#imprime el error
	syscall
	
	li $v0, 4		#imprime el mensaje de error
	move $a0, $s2
	syscall
	
	bne $s4, $zero, FinB	#comprueba si existe resultado o solo habia error

	li $v0, 10		#fin
	syscall
	
FinB:	li $v0, 1		#si no habia error, emite el resultado
	move $a0, $s4
	syscall
	
	li $v0, 10		#fin
	syscall
	
RepBin:	blt $a2, $a1, Menor		#comprobamos errores
	bgt $a1, $s0, Rang
	bgt $a2, $s0, Rang
	blt $a1, $zero, Rang
	blt $a2, $zero, Rang
	
	sub $s3, $a2, $a1		#hayamos el n entre 'j' e 'i'

While:	beq $a1, $zero, Op
	sll $s3, $s3, 1			#desplazamos n 'i' veces a la izq
	addi $a1, $a1, -1
	
	j While
	
#Masc:	beq $s3, $zero, Op		#si se termina n, ya tenemos mascara
#	andi $t0, $s3, 1		#ultimo bit
#	beq $t0, $zero, Camb		#si es 0, cambiamos a 1
#	srl $s3, $s3, 1			#siguiente bit
#	j Masc

#Camb:	addi $s3, $s3, 1		#sumamos 1 si es 0
#	srl $s3, $s3, 1			#siguiente bit
#	j Masc

Op:	and $s4, $s3, $a0		#and con la mascara y 'x'
	
While2:	beq $s5, $zero, Fin		#desplazamos a la derecha
	srl $s4, $s4, 1
	addi $s5, $s5, -1
	
	j While2

Menor:	li $v0, 2			#i>j
	la $s2, msg05
	jr $ra

Rang:	li $v0, 1			#parametro fuera de rango
	la $s2, msg04
	jr $ra
	
Fin:	li $v0, 0			#vuelta al main
	la $s2, msg06
	jr $ra
