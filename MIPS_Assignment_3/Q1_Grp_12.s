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
final_result: .asciiz "Final determinant of the matrix A is "
newline: .asciiz "\n"
error_msg: .asciiz "Entered integers should be positive.\n"

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
	# loop register description
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
	populate_loop_end:


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

popFromStack:
    lw $v0, ($sp)
	# addi $sp, $sp, 4


error_input:
	li $v0, 4
	la $a0, error_msg
	syscall

exit_function:
	li $v0, 10
	syscall






