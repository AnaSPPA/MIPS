.data

.text
main:	li $v0, 5
	syscall
	
	jal Parid
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 10
	syscall
	
Parid:	move $t2, $v0
	li $t1, 0
	li $t3, 0

while:	beq $t2, 0, Fin
	andi $t3, $t2, 1
	bne $t3, $zero, CambP
	srl $t2, $t2, 1
	j while

CambP:	sub $t1, $t3, $t1
	srl $t2, $t2, 1
	j while
	
Fin:	jr $ra