#####
# Assignment: 2
# Problem: 2
# Autumn Semester 2022
# Group: 12
# Members: Ashish Rekhani (20CS10010), Kartik Pontula (20CS10031)
#####

.globl main
# Data Segment
.data
prompt_init: .asciiz "Enter 10 integers\n"
prompt_num: .asciiz "Enter Number "
prompt_colon: .asciiz ": "
prompt_k: .asciiz "Enter the value of k: "
prompt_error: .asciiz "Error: Invalid value of k. Value of k should be between 1 and 10.\n"
prompt_res: .asciiz "The kth largest number is: "
newline: .asciiz "\n"
space: .asciiz " "
prompt_sort: .asciiz "The array has been sorted successfully.\n The sorted array is: "
array: .space 40

# Text Segment
.text
main:
    li $s1, 10
    li $v0, 4
    la $a0, prompt_init # prints "Enter 10 integers\n"
    syscall

    jal read_array

    li $v0, 4
    la $a0, prompt_k
    syscall # prints "Enter the value of k: "

    li $v0, 5
    syscall
    move $s1, $v0 # stores k in $s1

    # sanity check (if k > 10 or k <= 0)
    bgt $s1, 10, error_exit
    ble $s1, 0, error_exit

    # printing the array
    la $a0, array
    jal print_arr

    # calling the sort_array function
    la $a0, array
    li $a1, 10
    jal sort_array

    # printing the sorted array
    la $a0, prompt_sort
    li $v0, 4
    syscall 

    la $a0, array
    jal print_arr

    # printing the kth largest number
    la $a0, prompt_res
    li $v0, 4
    syscall

    # get_kth_largest function is called and the required integer is printed
    la $a0, array
    move $a1, $s1
    jal get_kth_largest

    li $v0, 5
    la $a0, newline
    syscall

    # exiting the program
    li $v0, 10
    syscall

read_array:
    li $t0, 0
    la $t1, array
    b array_loop
    
array_loop:
    
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
    sw $v0, 0($t1)

    addi $t0, $t0, 1 # increments counter
    addiu $t1, $t1, 4 # increments array pointer
    bne $t0, 10, array_loop # loops until counter is 10
    jr $ra # return back to main

# Register Legend:
# $a0: array
# a1 : k 
# $t0: i
get_kth_largest:
    
    li $t0, -1
    add $t0, $t0, $a1 # t0 = k - 1
    mul $t0, $t0, 4 # $t0 = $t0 * 4
    add $t0, $t0, $a0 # $t0 = $t0 + $a0
    lw $t1, 0($t0) # $t1 = $t0[0]

    # printing the k-th largest integer
    li $v0, 1
    move $a0, $t1
    syscall
    jr $ra


# Register Legend:
# $a0: array
# a1 : 10 (size of the array)
# $t0: i
# $t1: j
# $t2 : 4*j
# t3 : t2 + 4

sort_array:
    li $t0, 0 # counter i = 0
    li $t1, 0 # counter j = 0
    li $t2, 0 # t2 = 4*j
    addi $t3, $t2, 4 # t3 = t2 + 4
    b outer_loop

outer_loop:
    addi $t0, $t0, 1 # increments i
    li $t1, 0 # counter j = 0
    ble $t0, 10, inner_loop # if i < 10, go to inner_loop
    jr $ra # return back to main

inner_loop:
    add $t5, $t0, $t1 # t5 = i + j
    bgt $t5, 9, outer_loop # if t5 > 9, go to outer_loop

    lw $a0, array($t2)
    lw $a1, array($t3)
    bgt $a0, $a1, swap # if array[j] > array[j+1], go to swap

inner_loop_increments: 
    addi $t1, $t1, 1 # increments j
    add $t2, $t2, $4 # t2 = 4*j
    add $t3, $t3, $4 # t3 = 4*(j+1)
    j inner_loop # go to inner_loop

SWAP:
    sw $a1, array($t2) # array[j] = array[j+1]
    sw $a0, array($t3) # array[j+1] = array[j]
    b inner_loop_increments


error_exit:
    li $v0, 4
    la $a0, prompt_error
    syscall
    li $v0, 10
    syscall

# Register Legend:
# $a0: array
# $t0: i
# $t1: 4*i
print_arr:
    li $t0, 0 # counter i = 0
    li $t1, 0 # stores offset

print_int:
    lw $t2, array($t1) # $t2 = array[i]

    li $v0, 1
    move $a0, $t2
    syscall # prints array[i]

    la $a0, space
    li $v0, 4
    syscall # prints " "

    addi $t0, $t0, 1 # incrementing i
    addi $t1, $t1, 4 # increments to next address
    blt $t0, 10, print_int # loops until counter is 10
    
    la $a0, newline
    li $v0, 4
    syscall
     
    jr $ra

    




