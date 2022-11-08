#####
# Assignment: 3
# Problem: 3
# Autumn Semester 2022
# Group: 12
# Members: Ashish Rekhani (20CS10010), Kartik Pontula (20CS10031)
#####
# Data Segment

.data
array: .space 40
prompt_init: .asciiz "Enter 10 integers\n"
prompt_key: .asciiz "Enter the value of key: "
prompt_key_confirm: .asciiz "The key to be searched is: "
prompt_num: .asciiz "Enter Number "
prompt_colon: .asciiz ": "
prompt_sortsuccess: .asciiz "Sorted Array: "
space: .asciiz " "
prompt_searchsuccess: .asciiz " is FOUND in the array at index (0-based indexing) "
prompt_searchfail: .asciiz " NOT FOUND in the array.\n";
newline: .asciiz "\n"

.text
.globl main

# register legend for main:
# $s1: size of the array (10)
# $s2: key to be searched

main:
    jal init_stack
    li $s1, 10
    li $v0, 4
    la $a0, prompt_init # prints "Enter 10 integers\n"
    syscall

# register legend for read_array: 
# $t0: counter i
# $t1: 4*i (offset)

read_array:
    li $t0, 0
    li $t1, 0
    
read_array_loop:
    
    li $v0, 4
    la $a0, prompt_num
    syscall # prints "Enter Number"

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
    

    # printing the input array
    # la $a0, array
    # jal print_array

    li $v0, 4
    la $a0, prompt_key
    syscall # prints "Enter the value of key: "

    li $v0, 5
    syscall # accepts integer
    move $s2, $v0   # stores key in $s2

    la $a0, array   # load array address in $a0
    li $a1, 0   # load start index in $a1
    li $a2, 9   # load end index in $a2
    jal recursive_sort  # recursive sort function is called

    li $v0, 4
    la $a0, prompt_sortsuccess
    syscall

    # The sorted array is printed
    la $a0, array
    jal print_array

    # li $v0, 4
    # la $a0, prompt_key_confirm
    # syscall

    # li $v0, 1
    # move $a0, $s2
    # syscall

    # li $v0, 4
    # la $a0, newline
    # syscall

    # The key is searched in the array
    la $a0, array   # load array address in $a0
    li $a1, 0   # load start index in $a1
    li $a2, 9   # load end index in $a2
    move $a3, $s2   # load key in $a3
    jal recursive_search  # recursive search function is called

    move $s3, $v0   # the result is stored in $s3
    beq $s3, -1, search_fail # if the result is -1, the key is not found

    li $v0, 1
    move $a0, $s2
    syscall 

    li $v0, 4
    la $a0, prompt_searchsuccess
    syscall

    li $v0, 1
    move $a0, $s3   # the index of the key is printed
    syscall 

    li $v0, 4
    la $a0, newline
    syscall

    b function_end

# register legend for recursive_search:
# $a0: array
# $a1: start index
# $a2: end index
# $a3: key

recursive_search:
    move $t0, $ra   # temporarily storing return address in $t0
    jal init_stack  # initialising stack
    move $t1, $a0   # temporarily storing array address in $t1

    move $a0, $t0   # old return address is push in stack (fp - 4)
    jal pushToStack

    move $a0, $t1   # restore array address back in $a0
    li $v0, -1      # return value of the function is set to -1 as default

    # while start <= end
    bgt $a1, $a2, recursive_search_end # if start index > end index, key is not found

    # mid1 = start + (end - start) / 3
    li $t5, 3
    sub $t0, $a2, $a1   # t0 = end - start
    div $t0, $t5       # t0 = t0 / 3
    mflo $t0            # t0 = quotient
    add $t1, $a1, $t0   # t1 = start + t0 = mid1
    sub $t2, $a2, $t0   # t2 = end - t0 = mid2

    sll $t3, $t1, 2     # t3 = 4 * mid1 
    add $t3, $t3, $a0   # t3 = array + 4 * mid1
    lw $t3, 0($t3)      # t3 = array[mid1]

    sll $t4, $t2, 2     # t4 = 4 * mid2
    add $t4, $t4, $a0   # t4 = array + 4 * mid2
    lw $t4, 0($t4)      # t4 = array[mid2]

# if key == array[mid1]
recursive_search_mid1:
    bne $a3, $t3, recursive_search_mid2 # if key != array[mid1], check for key == array[mid2]
    move $v0, $t1   # if key == array[mid1], return mid1
    b recursive_search_end

# else if key == array[mid2]
recursive_search_mid2:
    bne $a3, $t4, recursive_search_left # if key != array[mid2]
    move $v0, $t2   # if key == array[mid2], return mid2
    b recursive_search_end

# else if key < array[mid1]
recursive_search_left:
    bge $a3, $t3, recursive_search_right # if key >= array[mid1]
    
    # recursive_search(array, start, mid1 - 1, key)
    # array address already stored in $a0
    # start index already stored in $a1
    sub $a2, $t1, 1 # end index = mid1 - 1
    # key already stored in $a3
    jal recursive_search
    b recursive_search_end

recursive_search_right:
    ble $a3, $t4, recursive_search_middle # if key <= array[mid2]

    # recursive_search(array, mid2 + 1, end, key)
    # array address already stored in $a0
    add $a1, $t2, 1 # start index = mid2 + 1
    # end index already stored in $a2
    # key already stored in $a3
    jal recursive_search
    b recursive_search_end

recursive_search_middle:
    # recursive_search(array, mid1 + 1, mid2 - 1, key)
    # array address already stored in $a0
    add $a1, $t1, 1 # start index = mid1 + 1
    sub $a2, $t2, 1 # end index = mid2 - 1
    # key already stored in $a3
    jal recursive_search
    b recursive_search_end

recursive_search_end:
    lw $ra, -4($fp)     # return address is loaded from stack

    addi $sp, $sp, 4    # stack is popped
    lw $fp, 0($sp)      # frame pointer is loaded from stack
    addi $sp, $sp, 4    # stack pointer is restored
    jr $ra



# prints the search_fail prompt
search_fail:
    li $v0, 1
    move $a0, $s2   # print the key
    syscall

    li $v0, 4
    la $a0, prompt_searchfail
    syscall 

    b function_end

# end of the function
function_end:

    lw $fp, 0($sp)  # restore frame pointer
    addi $sp, $sp, 4    # restore stack pointer

    # exit from the function
    li $v0, 10
    syscall 
    
# register legend for recursive_sort:
# $a0: array address
# $a1: start index (left)
# $a2: end index (right)
# $s0: l
# $s1: r
# $s2: p
recursive_sort:
    move $t0, $ra   # store return address
    jal init_stack
    move $t1, $a0   # store array address

    move $a0, $t0   # storing old return address in stack (fp - 4)
    jal pushToStack
    move $a0, $s0   # storing l in stack (fp - 8)
    jal pushToStack
    move $a0, $s1   # storing r in stack (fp - 12)
    jal pushToStack
    move $a0, $s2   # storing p in stack (fp - 16)
    jal pushToStack
    move $a0, $t1   # storing array address in stack (fp - 20)
    jal pushToStack
    move $a0, $a1   # storing left in stack (fp - 24)
    jal pushToStack
    move $a0, $a2   # storing right in stack (fp - 28)
    jal pushToStack
    
    move $a0, $t1   # load array address in $a0

    move $s0, $a1   # load left in $s0; l = left
    move $s1, $a2   # load right in $s1; r = right
    move $s2, $a1   # load left in $s2 as p; p = left

# while l < r
recursive_sort_loop:
    bge $s0, $s1, recursive_sort_end # if l >= r, end the loop

# while A[l] <= A[p] and l < right
# l++
recursive_sort_loop_l:
    mul $t0, $s0, 4 # $t0 = 4 * l
    add $t0, $t0, $a0 # $t0 = array + 4 * l
    lw $t0, 0($t0) # $t0 = array[l]

    mul $t1, $s2, 4 # $t1 = 4 * p
    add $t1, $t1, $a0 # $t1 = array + 4 * p
    lw $t1, 0($t1) # $t1 = array[p]

    bgt $t0, $t1, recursive_sort_loop_r # if array[l] > array[p], go to recursive_sort_loop_r
    bge $s0, $a2, recursive_sort_loop_r # if l >= right, go to recursive_sort_loop_r

    addi $s0, $s0, 1 # l = l + 1
    b recursive_sort_loop_l # go to recursive_sort_loop_l

# while A[r] >= A[p] and r > left
# r--
recursive_sort_loop_r:
    mul $t0, $s1, 4 # $t0 = 4 * r
    add $t0, $t0, $a0 # $t0 = array + 4 * r
    lw $t0, 0($t0) # $t0 = array[r]

    mul $t1, $s2, 4 # $t1 = 4 * p
    add $t1, $t1, $a0 # $t1 = array + 4 * p
    lw $t1, 0($t1) # $t1 = array[p]

    blt $t0, $t1, recursive_sort_loop_swap # if array[r] < array[p], go to recursive_sort_loop_swap
    ble $s1, $a1, recursive_sort_loop_swap # if r <= left , go to recursive_sort_loop_swap

    addi $s1, $s1, -1 # r = r - 1
    b recursive_sort_loop_r # go to recursive_sort_loop_r

# if l < r then swap A[l] and A[r]
recursive_sort_loop_swap:
    bge $s0, $s1, recursive_sort_recursion # if l >= r, go to recursive_sort_loop
    
    # swap A[l] and A[r]
    # a0 already stores array address
    move $a1, $s0 # load l in $a1
    move $a2, $s1 # load r in $a2
    jal SWAP # swap function is called

    lw $a1, -24($fp) # load left in $a1
    lw $a2, -28($fp) # load right in $a2

    b recursive_sort_loop # go to recursive_sort_loop

# if l >= r then
recursive_sort_recursion:
    # swap A[p] and A[r]
    # $a0 already stores array address
    move $a1, $s2 # load p in $a1
    move $a2, $s1 # load r in $a2
    jal SWAP # swap function is called

    # calling recursive_sort(array, left, r - 1)
    # $a0 already stores array address
    lw $a1, -24($fp) # load left in $a1
    addi $a2, $s1, -1 # set r - 1 in $a2
    jal recursive_sort # recursive_sort function is called

    # calling recursive_sort(array, r + 1, right)
    # $a0 already stores array address
    addi $a1, $s1, 1 # set r + 1 in $a1
    lw $a2, -28($fp) # load right in $a2
    jal recursive_sort # recursive_sort function is called

    b recursive_sort_end # go to recursive_sort_end
    

recursive_sort_end:
    lw $ra, -4($fp) # load return address from stack
    lw $s0, -8($fp) # load l from stack
    lw $s1, -12($fp) # load r from stack
    lw $s2, -16($fp) # load p from stack
    addi $sp, $sp, 28 # pop stack

    lw $fp, 0($sp) # load old frame pointer
    addi $sp, $sp, 4 # pop stack

    jr $ra # return


# register legend for SWAP
# $a0: array address
# $a1: index 1
# $a2: index 2
SWAP:
    mul $t0, $a1, 4 # $t0 = 4 * i1
    add $t0, $t0, $a0 # $t0 = array + 4 * i1
    lw $t2, 0($t0) # $t2 = array[i1]

    mul $t1, $a2, 4 # $t1 = 4 * i2
    add $t1, $t1, $a0 # $t1 = array + 4 * i2
    lw $t3, 0($t1) # $t3 = array[i2]

    sw $t3, 0($t0) # array[i1] = array[i2] 
    sw $t2, 0($t1) # array[i2] = array[i1]
    jr $ra

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
    la $a0, space # prints " "
    syscall

    addi $t0, $t0, 1
    addiu $t1, $t1, 4
    blt $t0, 10, print_array_loop # continue in the loop till i = 10

    li $v0, 4
    la $a0, newline # prints newline
    syscall

    jr $ra # return to the caller

init_stack:
    addi $sp, $sp, -4
    sw $fp, 0($sp)
    move $fp, $sp
    jr $ra

pushToStack:
    addi $sp, $sp, -4
    sw $a0, ($sp)
    jr $ra