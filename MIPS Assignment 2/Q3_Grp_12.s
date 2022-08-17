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

# Text Segment
.text
.globl main
main:
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
    jr $ra

pushToStack:
    jr $ra

mallocInStack:
    jr $ra

printMatrix:
    jr $ra

transposeMatrix:
    jr $ra


