# variable data
.data
	matrixRows: .word 2
	matrixColumns: .word 3
	vectorRows: .word 3
	
	vectorX: .word 1, 2, 3
	vectorY: .word 1, 2, 3
	matrix: .word 5, 6, 7, 8, 9, 10
	
# instructions
.text
	# access to data from memory
	lui $s0, 0x1001
	ori $s0, $s0, 0				# s0 contains address of matrixRows
	
	addi $s1, $s0, 4			# s1 contains address of matrixColumns
	
	addi $s2, $s1, 4			# s2 contains address of vectorRows
	
	addi $s3, $s2, 4			# s3 contains address of first index of vectorX
	
	lw $t0, 0($s2)				# load vectorRows (value) in t1
	sll $t1, $t0, 2				# multiply by 4 by shifting left by 2
	
	add $s4, $s3, $t1			# s4 contains address of first index of VectorY >> address(vectorX[0]) + 4n
	
	add $s5, $s4, $t1			# s5 contains address of first index of matrix
	
	# transpose Y				# don't consider this as a necessary step
	
	# multiply X and transposeY
	ori $t2, $zero, 0			# initialize counter for for-loop j
	ori $t3, $zero, 0			# initialize counter for for-loop i
	lw $t8, 0($s2)				# load vectorRows in t8
	
loop:	lw $t4, 0($s3)				# load first element of vectorX in t4
	lw $t5, 0($s4)				# load first element of vectorY (transpose) in t5
	
	ori $t6, $zero, 0			# this code is to multiply t4 with t5
multp:	add $t7, $t7, $t4
	addi $t6, $t6, 1
	bne $t6, $t5, multp
	
	sw $t7, 0($s6)				# store result of first multiply at address in s6
	addi $s6, $s6, 4			# increment address
	addi $s4, $s4, 4			# increment vectorY element
	
	bne $t3, $t8, loop			# branch for loop i (inner loop)
	addi $s3, $s3, 4			# increment vectorX element
	bne $t2, $t8, loop			# branch for loop j (outer loop)
	
	
	# matrix product multiplication
	# printing the array