.data
Intr:	.asciiz "Las 10 primeras potencias de 4 son: "
Esp:	.ascii ", "
.text
main:	la $a0, Intr		#carga la dirección del String en $a0
	la $s1, Esp		#carga la dirección del String in $s1
	
	li $s0, 10		#contador para solo imprimir 10 potencias
	
	li $v0, 4		#llamada al sistema para que imprima el String almacenado en $a0
	syscall
	
	li $s2, 4		#constante con la que haremos las potencias
	
PotCua:	li $v0, 1		#llamada al sistema para que imprima el entero almacenado en $a0
	move $a0, $s2
	syscall

	sll $s2, $s2, 2		#multiplica $s2 por 4
	
	beq $s0, $zero, Fin	#cuando el contador valga 0 sale del bucle y se dirige a Fin
	
	li $v0, 4		#llamada al sistema para que imprima el String almacenado en $a0
	move $a0, $s1
	syscall

	addi $s0, $s0, -1	#actualiza el contador
	
	j PotCua		#crea el bucle
	
Fin:	li $v0, 10		#llamada al sistema que hace que el programa termine
	syscall
