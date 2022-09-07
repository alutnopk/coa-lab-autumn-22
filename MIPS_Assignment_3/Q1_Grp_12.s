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
	# move $a0, $s0
	# jal pushToStack
	# move $a0, $s1
	# jal pushToStack
	# move $a0, $s2
	# jal pushToStack
	# move $a0, $s3
	# jal pushToStack
	move $t0, $a0 
	move $t1, $a1
	# t0: n
	# t1: 
	bne 
error_input:
	li $v0, 4
	la $a0, error_msg
	syscall

exit_function:
	li $v0, 10
	syscall






