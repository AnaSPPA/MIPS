.data
C:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.text
main:	li $s0, 0
	la $s1, C
	addi $t0, $s1, 0
Loop:	sll $t1, $s0, 1
	sw $t1, 0($t0)
	beq $s0, 10, Exit
	addi $s0, $s0, 1
	addi $t0, $t0, 4
	j Loop
Exit:	li $v0, 10		# exit
	syscall