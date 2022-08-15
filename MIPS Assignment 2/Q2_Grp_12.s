#####
# Assignment: 2
# Problem: 1
# Autumn Semester 2022
# Group: 12
# Members: Ashish Rekhani (20CS10010), Kartik Pontula (20CS10031)
#####

# Data Segment
.data
prompt_init: .asciiz "Enter 10 integers\n"
prompt_num: .asciiz "Number "
prompt_colon: .asciiz ": "
prompt_k: .asciiz "Enter the value of k: "

array: .space 32

# Text Segment
.text
.globl main
main:
    
    li $v0, 4
    la $a0, prompt_init # prints "Enter 10 integers\n"
    syscall

    li $s0, 1 # Loop counter
    la $t0, array # Address of array

    array_loop:
        bgt $s0, 10, array_loop_exit
        
        li $v0, 4
        la $a0, prompt_num
        syscall # prints "Number"
        li $v0, 1
        move $a0, $s0
        syscall # prints counter
        li $v0, 4
        la $a0, prompt_colon
        syscall # prints ": "

        li $v0, 5
        syscall # accepts integer
        sw $v0, ($t0) # assigns into array

        addiu $t0, 4, $t0 # increments address to next position
        addiu $s0, 1, $s0 # increments counter
    array_loop_exit:

    li $v0, 4
    la $a0, prompt_k
    syscall # prints "Enter the value of k: "

    li $v0, 5
    syscall
    sw $v0, $a0 # stores k in $s0

SWAP:
    lw $t0, ($a0)
    lw $t1, ($a1)
    sw $t0, ($a1)
    sw $t1, ($a0)

sort_array:

find_k_largest:

