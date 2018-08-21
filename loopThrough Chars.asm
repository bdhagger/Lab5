.data

string: .asciiz "Isabella"
nl:     .asciiz "\n"

.text 

addi $t0 $zero 0

while:

beq $t0 8 exit
lb $t6 string($t0)
addi $t0 $t0 1

# print current char
li $v0 11
move $a0 $t6
syscall

li $v0 4
la $a0 nl
syscall

j while

exit:

li $v0 10
syscall