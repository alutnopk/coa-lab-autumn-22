 

 
 
addi $1, 1
 
sw $1, 1, $0
 
addi $1, 2
 
sw $1, 2, $0
 
addi $1, 3
 
sw $1, 3, $0
 
addi $1, 4
 
sw $1, 4, $0
 
addi $1, 5
 
sw $1, 5, $0
 
addi $1, 6
 
sw $1, 6, $0
 
addi $1, 7
 
sw $1, 7, $0
 
addi $1, 8
 
sw $1, 8, $0
 
addi $1, 9
 
sw $1, 9, $0
 
addi $1, 10
 
sw $1, 10, $0

 
 
b 54

 
 

 
 
compi $7, -1
 
compi $8, -10

 
 
xor $15, $15  
 
add $15, $8  
 
xor $16, $16  
 
comp $16, $7  
 
add $15, $16  
 
bltz $15, 52  

 
 
xor $15, $15  
 
add $15, $7  
 
xor $16, $16  
 
add $16, $8  
 
add $15, $16  
 
shra $15, 1  

 
 
lw $17, 0, $15

 
 
xor $18, $18
 
add $18, $17
 
xor $18, $2
 
bz $18, 50  

 
 
comp $18, $2  
 
add $18, $17  
 
bltz $18, 47  

 
 
compi $8, 1
 
add $8, $15
 
b 24

 
 
compi $7, -1
 
add $7, $15
 
b 24

 
 
addi $1, 1
 
b 53

 
 
addi $1, -1

 
 
br $31

 
 

 
xor $2, $2
xor $1, $1
addi $2, 1  
bl 22  

 
xor $2, $2
xor $1, $1
addi $2, 2  
bl 22  

 
xor $2, $2
xor $1, $1
addi $2, 3  
bl 22  

 
xor $2, $2
xor $1, $1
addi $2, 15  
bl 22  

 
xor $2, $2
xor $1, $1
addi $2, 47  
bl 22  

 
xor $2, $2
xor $1, $1
addi $2, 55  
bl 22  

 
xor $2, $2
xor $1, $1
addi $2, 0  
bl 22  