#####
# Assignment: 2
# Problem: 3
# Autumn Semester 2022
# Group: 12
# Members: Ashish Rekhani (20CS10010), Kartik Pontula (20CS10031)
#####

# Data Segment
.data
prompt_init: .asciiz "Enter four positive integers m, n, a and r: "
prompt_A: .asciiz "Matrix A:\n"
prompt_B: .asciiz "Matrix B:\n"
blank_space: .asciiz " "
newline: .asciiz "\n"
error_msg: .asciiz "Invalid input. Please enter a positive number."
# Text Segment
.text
.globl main
main:
    jal initStack

    li $v0, 4
    la $a0, prompt_init
    syscall # prompts user for input

    li $v0, 5
    syscall
    move $s0, $v0 # m
    ble $s0, 0, error
    li $v0, 5
    syscall
    move $s1, $v0 # n
    ble $s1, 0, error
    li $v0, 5
    syscall
    move $s2, $v0 # a
    ble $s2, 0, error
    li $v0, 5
    syscall
    move $s3, $v0 # r
    ble $s3, 0, error

    mul $a0, $s0, $s1 # m*n
    jal mallocInStack
    move $s4, $v0 # s4 is address of A

    mul $a0, $s0, $s1 # m*n
    jal mallocInStack
    move $s5, $v0 # s5 is address of B

    # populate A with GP
    move $t0, $zero # counter i
    mul $t1, $s0, $s1 # m*n
    move $t2, $s2 # current element
    move $t3, $s4 # pointer for A
    populate_loop:
        bge $t0, $t1, populate_exit
        sw $t2, ($t3)

        mul $t2, $t2, $s3 # next term of GP
        addi $t3, $t3, 4 # increment pointer
        addi $t0, $t0, 1
    b populate_loop
    populate_exit:

    # display A
    li $v0, 4
    la $a0, prompt_A
    syscall
    move $a0, $s0
    move $a1, $s1
    move $a2, $s4
    jal printMatrix

    # find transpose of A 
    move $a0, $s0
    move $a1, $s1
    move $a2, $s4
    move $a3, $s5
    jal transposeMatrix

    # display B
    li $v0, 4
    la $a0, prompt_B
    syscall
    move $a0, $s0
    move $a1, $s1
    move $a2, $s5
    jal printMatrix

    mul $t0, $s0, $s1
    mul $t0, $t0, 8
    add $sp, $sp, $t0

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
    mul $t0, $a0, 4
    sub $sp, $sp, $t0
    move $v0, $sp
    jr $ra

printMatrix:
    move $t0, $a0
    move $t1, $a1
    move $t2, $a2 # current pointer is t2
    move $t3, $zero # counter i is t3
    print_outer_loop:
        bge $t3, $a0, print_outer_exit
        move $t4, $zero # counter j is t4
        print_inner_loop:
            bge $t4, $a1, print_inner_exit
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
        b print_inner_loop
        print_inner_exit:
        li $v0, 4
        la $a0, newline
        syscall
        move $a0, $t0

        addi $t3, $t3, 1
    b print_outer_loop
    print_outer_exit:
    jr $ra

transposeMatrix:
    move $t0, $a0 # copy of a0
    mul $t1, $a0, $a1 # m*n
    move $t2, $a2 # t2 is A pointer
    move $t3, $a3 # t3 is B pointer
    move $t4, $zero # t4 is i counter
    move $t5, $zero # t5 is j counter

    transpose_outer_loop:
        bge $t4, $a1, transpose_outer_exit # loop n times
        move $t5, $zero # t5 is j counter
        move $t7, $t3 # t7 is offset
        transpose_inner_loop:
            bge $t5, $a0, transpose_inner_exit # loop m times
            lw $t6, ($t2) # current element is t6

            sw $t6, ($t7) # assign element into B

            addi $t2, $t2, 4 # point to next element in A
            mul $t8, $a1, 4
            add $t7, $t7, $t8 # increase B pointer by 4*n
            addi $t5, $t5, 1 # j++
        b transpose_inner_loop
        transpose_inner_exit:

        addi $t3, $t3, 4
        addi $t4, $t4, 1
    b transpose_outer_loop
    transpose_outer_exit:
    jr $ra

error:
    li $v0, 4
    la $a0, error_msg
    syscall
    li $v0, 10
    syscall

