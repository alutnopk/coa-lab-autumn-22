# $20 is used for base address of array
# $21 for n
# $8 for i
# $9 for j

#1
xor  $0, $0
xor  $1, $1
addi $1, 100
sw $1, 0, $0
xor  $1, $1
addi $1, 50
sw $1, 1, $0
xor  $1, $1
addi $1, 300
sw $1, 2, $0
xor  $1, $1
addi $1, 45
sw $1, 3, $0
xor  $1, $1
addi $1, 54
sw $1, 4, $0
xor  $1, $1
addi $1, 6
sw $1, 5, $0
xor  $1, $1
addi $1, 70
sw $1, 6, $0
xor  $1, $1
addi $1, 8
sw $1, 7, $0
xor  $1, $1
addi $1, 900
sw $1, 8, $0
xor  $1, $1
addi $1, 16
#31
sw $1, 9, $0

# make sure to add 31 to any jump statement below... to the instruction number you want to jump

# main:
#32
    xor $20, $20        # base address of array = 0 ($20)
#33
    xor $21, $21
#34
    addi $21, 10        # $21 = n = 10
#35
    xor $8, $8          # $8 = i = 0
#36
    xor $9, $9          # $9 = j = 0

#fori:
#37
    xor $10, $10
#38
    add $10, $8
#39
    comp $11, $21
#40
    add $10, $11
#41
    addi $10, 1         # $10 = i - (n - 1) = i - n + 1
#42
    bz $10, 71    # if i == n - 1, jump to exitfori
#43
    xor $9, $9          # j = 0

#forj:
#44
    xor $11, $11
#45
    add $11, $9
#46
    add $11, $10        # $11 = j + i - n + 1
#47
    bz $11, 69    # if j == n - i - 1, jump to exitforj

#48
    xor $12, $12
#49
    add $12, $9
#50
    shll $12, 0         # 4 * j may not needed confirm thissssssssssss
#51
    add $12, $20        # arr + 4 * j
#52
    lw $13, 0($12)      # $13 = arr[j]
#53
    xor $4, $4
#54
    add $4, $12
#55
    addi $12, 1         # change here accordingly rn it is 1 if you use shll 2 in 19th instruction then write 4 
#56
    lw $14, 0($12)      # $14 = arr[j + 1]
#57
    xor $5, $5
#58
    add $5, $12

#59
    comp $15, $14
#60
    add $13, $15        # arr[j] - arr[j + 1]
#61
    bltz $13, 67
#62
    bz $13, 67
#63
    lw $18, 0($4)
#64
    lw $19, 0($5)
#65
    sw $18, 0($5)
#66
    sw $19, 0($4)

#incj:
#67
    addi $9, 1          # j = j + 1
#68
    b 44

#exitforj:
#69
    addi $8, 1          # i = i + 1
#70
    b 37

#exitfori:
#71
    xor $16, $16    
#72
    addi $16, 1         # to indicate completion of sorting

#putting values from memory to register to display on FPGA

    xor $20, $20
    
    lw  $22,0($20) 
    lw  $23,1($20)
    lw  $24,2($20)
    lw  $25,3($20)
    lw  $26,4($20)
    lw  $27,5($20)
    lw  $28,6($20)
    lw  $29,7($20)
    lw  $30,8($20)
    lw  $31,9($20)