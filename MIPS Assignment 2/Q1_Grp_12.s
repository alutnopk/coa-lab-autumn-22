# header
# Data Segment
.data

prompt1:
    .asciiz "Enter first number:"
prompt2:
    .asciiz "Enter second number:"
error_msg:
    .asciiz "Invalid input."
output:
    .asciiz "Product of the two numbers are:"
newline:
    .asciiz "\n"

# Text Segment
.text
.globl main

main:
    li $v0, 4
    la $a0, prompt1
    syscall # Prompts for 1st number
    li $v0, 5
    syscall # Accepts 1st number
    move $a0, $v0

    li $v0, 4
    la $a0, prompt2
    syscall # Prompts for 1st number
    li $v0, 5
    syscall # Accepts 1st number
    move $a1, $v0

    # Sanity check
    # check if number 1 is between -2^15 and +2^15 - 1
    lower_bound1:
    bge $a0, 0xFFFF8000, upper_bound1
    j error
    upper_bound1:
    ble $a0, 0x00007FFF, lower_bound2
    j error
    # check if number 2 is between -2^15 and +2^15 - 1
    lower_bound2:
    bge $a1, 0xFFFF8000, upper_bound2
    j error
    upper_bound2:
    ble $a1, 0x00007FFF, valid
    j error
    
    valid: # Sanity check passed

    # between 0x00007FFF and 0xFFFF8000
    # 17 bits needed
    # in each pass
    # check lsb and prev lsb: perform (or don't) action
    # do ARS on product
    # do dis X times
    jal multiply_booth

multiply_booth:
    # 
    jr $ra


error:
    li $v0, 4
    la $a0, error_msg
    syscall
    li $v0, 10
    syscall
