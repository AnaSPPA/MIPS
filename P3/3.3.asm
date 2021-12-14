.data

.text
main:	li $v0, 5
	syscall
	move $a0, $v0
	li $s0, 2
	
	jal Suma
	
	li $v0, 1
	add $a0, $v1, $zero
	syscall
	li $v0, 10
	syscall
	
Suma:	add $t1, $zero, $a0
	
Procd:	beq $t1, $zero, Exit
	
	add $s1, $s1, $s0
	
	addi $s0, $s0, 2
	addi $t1, $t1, -1
	 
	j Procd

Exit:	add $v1, $s1, $zero
	
	jr $ra
