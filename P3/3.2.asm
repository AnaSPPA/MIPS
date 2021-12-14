.data

.text
main:	li $v0, 5
	syscall
	move $s0, $v0
	li $t1, 2
	
Suma:	beq $s0, $zero, Exit
	
	add $t0, $t0, $t1
	
	addi $t1, $t1, 2
	subi $s0, $s0, 1
	 
	j Suma
	
Exit:	li $v0, 1
	add $a0, $t0, $zero
	syscall
	
	li $v0, 10
	syscall
	
