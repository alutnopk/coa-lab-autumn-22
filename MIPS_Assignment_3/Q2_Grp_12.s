#####
# Assignment: 3
# Problem: 1
# Autumn Semester 2022
# Group: 12
# Members: Ashish Rekhani (20CS10010), Kartik Pontula (20CS10031)
#####
# Data Segment

.data

array: .space 40
prompt_init: .asciiz "Enter 10 integers\n"
prompt_num: .asciiz "Enter Number "
prompt_colon: .asciiz ": "
prompt_success: .asciiz "Sorted Array: "
space: .asciiz " "
newline: .asciiz "\n"


.text
.globl main

# register legend for main:
# $s1: size of the array (10)

main:
    li $s1, 10
    li $v0, 4
    la $a0, prompt_init # prints "Enter 10 integers\n"
    syscall

    jal read_array

    la $a0, array
    jal print_array

    la $a0, array   # load array address in $a0
    li $a1, 0   # load start index in $a1
    li $a2, 9   # load end index in $a2
    jal recursive_sort  # recursive sort function is called

    li $v0, 4
    la $a0, prompt_success
    syscall

    # The final sorted array is printed
    la $a0, array
    jal print_array

    # exit from the function
    li $v0, 10
    syscall 


recursive_sort:




# register legend for print_array:
# $a0: array
# t0: counter i
# t1: 4*i (offset)
print_array:
    li $t0, 0
    li $t1, 0
    move $s0, $a0

print_array_loop:
    add $t2, $s0, $t1 
    lw $t2, 0($t2) # array[t0] = t2
    
    li $v0, 1
    move $a0, $t2 
    syscall # prints array[t2]

    li $v0, 4
    move $a0, space # prints " "
    syscall

    addi $t0, $t0, 1
    addiu $t1, $t1, 4
    blt $t0, 10, print_array_loop # continue in the loop till i = 10

    li $v0, 4
    move $a0, newline # prints newline
    syscall

    jr $ra 

#register legend for read_array: 
# $t0: counter i
# $t1: 4*i (offset)

read_array:
    li $t0, 0
    li $t1, 0
    b read_array_loop
    
read_array_loop:
    
    li $v0, 4
    la $a0, prompt_num
    syscall # prints "Number"

    li $v0, 1
    move $a0, $t0
    syscall # prints counter
    
    li $v0, 4
    la $a0, prompt_colon
    syscall # prints ": "

    li $v0, 5
    syscall # accepts integer
    sw $v0, array($t1)

    addi $t0, $t0, 1 # increments counter
    addiu $t1, $t1, 4 # increments array pointer
    bne $t0, 10, read_array_loop # loops until counter is 10
    jr $ra # return back to main