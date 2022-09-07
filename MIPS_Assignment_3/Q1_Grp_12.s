#####
# Assignment: 3
# Problem: 1
# Autumn Semester 2022
# Group: 12
# Members: Ashish Rekhani (20CS10010), Kartik Pontula (20CS10031)
#####
# Data Segment

.data
prompt1: .asciiz "Enter four positive integers (n, a, r, and m): "
prompt2: .asciiz "Array A is:\n"
final_result: .asciiz "\nFinal determinant of the matrix A is "
newline: .asciiz "\n"
error_msg: .asciiz "Entered integers should be positive.\n"
blank_space: .asciiz " "
.text
.globl main

# register legend for main:
# n: -8($fp)
# a: -12($fp)
# r: -16($fp)
# m: -20(%fp)
# matrix address: $s4
# determinant value: $s5

main:
	move $s0, $ra

    jal initStack

    move $a0, $s0
    jal pushToStack # $ra stored in -4($fp)

	li $v0, 4
	li $a0, prompt1
	syscall


	li $v0, 5
    syscall # Accepts n
    move $a0, $v0
	blez $a0, error_input #sanity check
	jal pushToStack # n stored in -8($fp)

	li $v0, 5
    syscall # Accepts a
    move $a0, $v0
	blez $a0, error_input #sanity check
	jal pushToStack # a stored in -12($fp)

	li $v0, 5
    syscall # Accepts r
    move $a0, $v0
	blez $a0, error_input #sanity check
	jal pushToStack # r stored in -16($fp)

	li $v0, 5
    syscall # Accepts m
    move $a0, $v0
	blez $a0, error_input #sanity check
	jal pushToStack # m stored in -20($fp)

	lw $t0, -8($fp)
	mult $t0, $t0
	mflo $a0
	jal mallocInStack # allocate 4 * n^2 bytes in stack
	move $s0, $v0 # save address of array in $s0

	move $t0, $a0 # t0 stores n^2
	move $t1, $s0 # t1 stores address of A[0]
	lw $t2, -12($fp) # t2 = a
	lw $t3, -16($fp) # t3 = r
	lw $t4, -20($fp) # t4 = m
	move $t5, $zero
	# populate_loop description
	# t0: stores n^2
	# t1: stores address of A[i]
	# t2: stores current term
	# t3: stores r
	# t4: stores m
	# t5: loop index

	populate_loop:
	beq $t5, $t0, populate_loop_end

	sw $t2, ($t1)

	mul $t2, $t2, $t3
	div $t2, $t4
	mfhi $t2
	addi $t1, $t1, 4
	addi $t5, $t5, 1
	j populate_loop
	populate_loop_end:

	li $v0, 4
	li $a0, prompt2
	syscall

	lw $a0, -8($fp) # n is 1st argument
	move $a1, $s0 # address of A[0] is 2nd argument
	jal printMatrix

	lw $a0, -8($fp)
	move $a1, $s0
	jal recursiveDet

	move $t0, $v0

	li $v0, 4
    la $a0, final_result
    syscall

    li $v0, 1
    move $a0, $t0       # printing determinant of matrix
    syscall

	lw $ra, -4($fp)
	move $sp, $fp
	llw $fp, ($sp)
	addi $sp, 4
	# jr $ra
	li $v0, 10
	syscall
initStack:
	addi $sp, $sp, -4
	sw $fp, ($sp)
	move $fp, $sp
	jr $ra

pushToStack:
    addi $sp, $sp, -4
    sw $a0, ($sp)
    jr $ra

mallocInStack:
    sll $t0, $a0, 2
    sub $sp, $sp, $t0
    move $v0, $sp
    jr $ra
printMatrix:
    move $t0, $a0
    move $t1, $a0
    move $t2, $a1 # current pointer is t2
    move $t3, $zero # counter i is t3
    print_outer_loop:
        bge $t3, $a0, print_outer_exit
        move $t4, $zero # counter j is t4
        print_inner_loop:
            bge $t4, $a0, print_inner_exit
            lw $t5, ($t2) # current element is t5

            li $v0, 1
            move $a0, $t5
            syscall # prints current integer
            move $a0, $t0

            li $v0, 4
            la $a0, blank_space
            syscall
            move $a0, $t0

            addi $t2, $t2, 4
            addi $t4, $t4, 1
        j print_inner_loop
        print_inner_exit:
        li $v0, 4
        la $a0, newline
        syscall
        move $a0, $t0

        addi $t3, $t3, 1
    b print_outer_loop
    print_outer_exit:
    jr $ra

recursiveDet:
	# a0 is n, a1 is address of array
	move $t0, $a0
	move $a0, $ra
	jal pushToStack
	move $a0, $s0
	jal pushToStack
	move $a0, $s1
	jal pushToStack
	move $a0, $s2
	jal pushToStack
	move $a0, $s3
	jal pushToStack
	move $s0, $t0 # n
	move $s1, $a1 # address of A
	li $s2, 0 # skip column counter
	li $s3, 0 # determinant
	# s0: n
	# s1: &A
	bne $s0, 1, not_one
	# base case: A has one element
	lw $v0, ($s1)
	# reloading old register values from memory
	lw $ra, 16($sp)
	lw $s0, 12($sp)
	lw $s1, 8($sp)
	lw $s2, 4($sp)
	lw $s3, 0($sp)
	addi $sp, $sp, 20
	jr $ra

	not_one: # recursive procedure begins
	recursion_loop:
	addi $t0, $s0, -1
	mult $t0, $t0
	mflo $a0 # stores (n-1)^2
	jal mallocInStack
	move $t0, $v0

	# s0: n
	# s1: matrix address
	# s2: column number to be skipped
	# s3: det
	# t0: submatrix address
	# s1, t0, s0, s2
	# t1: i
	# t2: j
	# t3: i'
	# t4: j'
	li $t1, 1 # i
	li $t2, 0 # j

	submatrix_outer:
	beq $t1, $s0, submatrix_outer_end
	submatrix_inner:
		beq $t2, $s0, submatrix_inner_end
		addi $t3, $t1, -1 # i' = i-1
		move $t4, $t2 # j' = j-1

		beq $t2, $s2, skip # if j'==j, skip column
		blt $t1, $a3, populate_submat
		addi $t4, $t4, -1 # j'--

		populate_submat:
		mult $t1, $s0 # n*i
		mflo $t5
		add $t5, $t5, $t2 # n*i + j
		sll $t5, $t5, 2 # 4*(n*i+j)
		add $t5, $t5, $s1 # address of A[i][j]
		lw $t5, ($t5) # t5 = A[i][j]

		addi $t6, $s0, -1
		mult $t6, $t3
		mflo $t6 # i'*(n-1)
		add $t6, $t6, $t4
		sll $t6, $t6, 2 # 4*i'*(n-1)
		add $t6, $t6, $t0 # t6 = &submat[i'][j']

		sw $t5, ($t6) # submat[i'][j'] = A[i][j]
		skip:
		addi $t2, $t2, 1
		j submatrix_inner
	submatrix_inner_end:
	addi $t1, $t1, 1
	li $t2, 0
	submatrix_outer_end:

	# submatrix has been populated
	addi $a0, $s0, -1
	move $a1, $t0
	jal recursiveDet

	addi $t1, $s0, -1   # t1 = n - 1
    mult $t1, $t1
	mflo $t1            # t1 = (n - 1)^2
	sll $t1, $t1, 2     # t1 *= 4
	add $sp, $sp, $t1   # moving stack pointer; deallocating

	andi $t1, $s2, 1        # t1 = j & 1 [j = s2]  
	beq $t1, 0, eval_val    # if t1 = 0 ( j is even go to eval_val )

    # if j is odd 
	sub $v0, $zero, $v0  # det(b) = -det(b) if j is odd 

	eval_val:
		sll $t1, $s2, 2     # t1 = 4*j
		add $t1, $s1, $t1   # t1 = &array[0][j]
		lw  $t1,  0($t1)      # t1 = array[0][j]

		mult $v0, $t1       # (-1)^j . det(b) . a[0][j]
		mflo $v0            # v0 =  (-1)^j . a[0][j] . det(b) 
		add $s3, $s3, $v0   # s3 += v0 ( s3 : det(A) )

	addi $s2, $s2, 1        # j++
	blt $s2, $s0, recursion_loop  # if (s2) j < (s0) n , keep looping        

    move $v0, $s3               # ( return value ) v0 = det(A)

	lw $ra, 16($sp)
	lw $s0, 12($sp)
	lw $s1, 8($sp)
	lw $s2, 4($sp)
	lw $s3, 0($sp)

	addi $sp, $sp, 20    # deallocating by incrementing stack pointer

	jr $ra    
error_input:
	li $v0, 4
	la $a0, error_msg
	syscall

exit_function:
	li $v0, 10
	syscall






