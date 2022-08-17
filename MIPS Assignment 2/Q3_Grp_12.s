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
blank_space: .asciiz " "
newline: .asciiz "\n"
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
    li $v0, 5
    syscall
    move $s1, $v0 # n
    li $v0, 5
    syscall
    move $s2, $v0 # a
    li $v0, 5
    syscall
    move $s3, $v0 # r


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
        print_inner_exit:
        li $v0, 4
        la $a0, newline
        syscall
        move $a0, $t0

        addi $t3, $t3, 1
    print_outer_exit:
    jr $ra

transposeMatrix:
    jr $ra


