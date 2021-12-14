.data
C:	.word	10, 20, 30
.text
main:	li $s0, 30
	li $s1, 0
	la $s3, C
Loop:	sll $t1, $s1, 2
	add $t1, $t1, $s3
	lw $t0, 0($t1)
	beq $t0, $s0, Exit
	addi $s1, $s1, 1
	j Loop
Exit:	li $v0, 10		# exit
	syscall