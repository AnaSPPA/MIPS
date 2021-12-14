.data

.text
main:	li $s0, 10
	li $s1, 1
Loop:	beq $s0, $s1, Exit
	addi $s1, $s1, 1
	j Loop
Exit:	li $v0, 10		# exit
	syscall
	