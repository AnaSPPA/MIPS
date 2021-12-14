.data
.align 2
X:	.space	160 
Y:	.space	160
msg01:	.asciiz	"A continuación introducirá los componentes (enteros positivos) del vector 'x'.\n"
msg02:	.asciiz "Siendo el vector 'x': ("
msg03:	.asciiz "El vector 'y' resultante es: ("
msg04:	.asciiz	"Teclee la componente o introduzca un número negativo para terminar: "
char:	.asciiz ") \n"
char2:	.ascii	","

.text
main:	la $a0, msg01
	li $v0, 4		#imprimo mensaje
	syscall
			
	la $a1, X		#dirección de X
	la $a2, Y		#dirección de Y
	la $a0, msg04		#mensaje necesario en la función
	
	jal PedirV		#función que pide valores
	
	li $t0, 0		
	jal Math		#función que calcula los valores
	
	la $a0, msg02		
	li $v0, 4		#imprimo mensaje 
	syscall
	
	li $t0, 0
	li $t1, 0
	la $a1, X		#dirección de X
	la $a3, char2		#dirección de la ","
	jal ImprX		#imprimo X
	
	li $v0, 4
	la $a0, char		#imprimo ")"
	syscall
	
	la $a0, msg03		
	li $v0, 4		#imprimo mensaje
	syscall

	li $t0, 0
	li $t1, 0
	jal ImprY		#imprimo Y

	li $v0, 4
	la $a0, char		#imprimo ")"
	syscall
	
Fin:	li $v0, 10		#fin
	syscall

################ FUNCIÓN PEDIRV ################
# FUNCIONALIDAD: 
#	Esta función nos permite ir pidiendo las componentes del 
#	vector 'X' y guardar cada una en su lugar dentro del
#	propio vector.
#
# PARÁMETROS:
#	La dirección en memoria del mensaje a imprimir en cada iteración
#	La dirección del vector 'X'
#
# RETURN:
#	Termina con el vector 'X' con todas sus componentes en su sitio
#

PedirV:	beq $t2, 40, FinPV	#¿40 valores? -> fin
	
	li $v0, 4		#imprimimos mensaje
	syscall	
	
	li $v0, 5		#pide valores -> v0
	syscall
	
	blt $v0, 0, FinPV	#¿valor negativo? -> fin
		
	add $t0, $t1, $a1	#actualiza dirección del vector
	sw $v0, 0($t0)		#guardamos valor
	
	addi $t1, $t1, 4	
	addi $t2, $t2, 1	#contador
	
	j PedirV		#bucle

FinPV:	jr $ra			#volvemos al main

################ FUNCIÓN MATH ################
# FUNCIONALIDAD: 
#	Esta función calcula las componentes del vector 'Y' tal y como
#	se especifica, con varios bucles y condicionales para distinguir
#	entre diferentes casos dependiendo de la componente en cuestión
#
# PARÁMETROS:
#	La dirección en memoria del vector 'X'
#	La dirección en memoria del vector 'Y'
#
# RETURN:
#	Termina con el vector 'Y' lleno de componentes calculadas desde el
#	vector 'X', cada una en su lugar
#

Math:	addi $sp, $sp, -24
	sw $s5, 20($sp)		#salvamos los registros tipo $s en pila
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)

Loop1:	bge $t4, $t1, Exit	#contador supera el nº de valores almacenados en el contador duplicado
	
	add $t3, $t4, $a1	#actualizamos la dirección del vector X
	lw $s0, 0($t3)		#x del medio
	lw $s1, 4($t3)		#x+1
	lw $s2, 8($t3)		#x+2
	lw $s4, -4($t3)		#x-1
	lw $s5, -8($t3)		#x-2
	
	mul $s3, $s0, $s0	#potencias
	mul $s0, $s0, $s3
	mul $s1, $s1, $s1
	
	add $s0, $s1, $s0	#sumas
	add $s0, $s0, $s2
	
	bgtz $s4, Sum		#x-1 > 0
	bgtz $s5, Sum2		#x-2 > 0
	
	j Save
	
Sum:	mul $s4, $s4, $s4	#potencia
	add $s0, $s0, $s4	#suma
	
	bgtz $s5, Sum2		#x-2 > 0
	
	j Save

Sum2:	add $s0, $s0, $s5	#suma

	j Save
	
Save:	add $t5, $t4, $a2	#actualizamos dirección del vector Y
	sw $s0, 0($t5)		#guardamos en vector Y
	
	addi $t4, $t4, 4	
	addi $t0, $t0, 1
	
	j Loop1			#bucle
	

Exit:	lw $s5, 20($sp)		#recuperamos los registros de tipo $s
	lw $s4, 16($sp)
	lw $s3, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 24
	
	jr $ra			#vuelta al main

################ FUNCIÓN IMPRX ################
# FUNCIONALIDAD: 
#	Esta función nos permite imprimir por consola el vector 'X'
#
# PARÁMETROS:
#	La dirección en memoria del vector 'X'
#	La dirección en memoria de 'char2'
#
# RETURN:
#	Imprime por consola el vector 'X' con cada componente separada
#	por comas
#

ImprX:	addi $sp, $sp, -8
	sw $s1, 4($sp)		#salvamos los registros $s en pila
	sw $s0, 0($sp)
	
Loop2:	add $s0, $t1, $a1	#actualizamos dirección del vector X
	lw $s1, 0($s0)		#cargamos valores
	
	li $v0, 1		#imprimimos numero
	move $a0, $s1
	syscall
		
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	
	bge $t0, $t2, Exit2	#¿todos los valores impresos? -> Exit2
	
	li $v0, 4
	move $a0, $a3		#imprimimos ','
	syscall
	
	li $v0, 11
	li $a0, 32		#imprimimos espacio en blanco
	syscall

	j Loop2			#bucle

Exit2: 	lw $s1, 4($sp)		#recuperamos los registros tipo $s
	lw $s0, 0($sp)
	addi $sp, $sp, 8

	jr $ra			#vuelta al main

################ FUNCIÓN IMPRY ################
# FUNCIONALIDAD: 
#	Esta función nos permite imprimir por consola el vector 'X'
#
# PARÁMETROS:
#	La dirección en memoria del vector 'Y'
#	La dirección en memoria de 'char2'
#
# RETURN:
#	Imprime por consola el vector 'Y' con cada componente separada
#	por comas
#

ImprY:	addi $sp, $sp, -4	
	sw $s0, 0($sp)		#salvamos $s0 en pila
	
Loop3:	add $s0, $t1, $a2	#actualizamos dirección del vector Y
	lw $a0, 0($s0)		#cargamos valores
	
	li $v0, 1		#imprimimos valor
	syscall
		
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	
	bge $t0, $t2, Exit3	#¿todos los valores impresos? -> Exit3
	
	li $v0, 4
	move $a0, $a3		#imprimimos ','
	syscall
	
	li $v0, 11
	li $a0, 32		#imprimimos espacio en blanco
	syscall

	j Loop3			#bucle
	
Exit3: 	lw $s0, 0($sp)		#recuperamos $s0
	addi $sp, $sp, 4
	
	jr $ra			#vuelta al main
