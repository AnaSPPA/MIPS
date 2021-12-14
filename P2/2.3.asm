.data
A:	.word	1, 4, 5, 8, 9, 12, 13, 16, 17, 20
B:	.word	2, 3, 6, 7, 10, 11, 14, 15, 18, 19
C:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.text
main:	la $s0, A
	la $s1, B
	la $s2, C
	li $s3, 10		#contador
Loop:	lw $t0, 0($s0)
	lw $t1, 0($s1)
	add $t2, $t0, $t1
	sw $t2, 0($s2)
	sub $s3, $s3, 1
	beq $s3, 0, Exit
	add $s0, $s0, 4
	add $s1, $s1, 4
	add $s2, $s2, 4
	j Loop
Exit:	li $v0, 10       	#exit
    	syscall