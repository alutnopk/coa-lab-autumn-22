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
# n: $s0
# a: $s1
# r: $s2
# m: $s3
# matrix address: $s4
# determinant value: $s5

main:
	li $v0, 4
	li $a0, prompt1
	syscall


	li $v0, 5
    syscall # Accepts n
    move $s0, $v0
	blez $s0, error_input #sanity check

	li $v0, 5
    syscall # Accepts a
    move $s1, $v0
	blez $s1, error_input #sanity check

	li $v0, 5
    syscall # Accepts r
    move $s2, $v0
	blez $s2, error_input #sanity check

	li $v0, 5
    syscall # Accepts m
    move $s3, $v0
	blez $s3, error_input #sanity check

	


	

error_input:
	li $v0, 4
	la $a0, error_msg
	syscall

exit_function:
	li $v0, 10
	syscall






