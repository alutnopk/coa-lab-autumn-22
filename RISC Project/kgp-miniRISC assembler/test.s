add $t0, $t1
comp $t2, $t3
and $t4, $t5
xor $t6, $t7
shll $t0, 15
shrl $t1, 16
shllv $t2, $t3
shrlv $t4, $t5
shra $t6, 14
shrav $s0, $s1
br $s1
bltz $s2, 19
bz $s3, 21
bnz $s4, 10
b 72
bl 19
bcy 31
bncy 1
diff $s5, $s6
lw $s0, 23($s1)
sw $t0, 19($t2)