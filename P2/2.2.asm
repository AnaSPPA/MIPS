.data

.text
main:	li $s3, 10
	li $s5, 0
Loop:	add $s5, $s5, $s3
	subi $s3, $s3, 1
	beq $s3, 0, Exit
	j Loop
Exit:	li $v0, 10		# exit
	syscall