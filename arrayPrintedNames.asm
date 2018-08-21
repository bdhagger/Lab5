.data 
 Ryan:     .asciiz "Ryan\n"
 Austin:   .asciiz "Austin\n"
 Catherine:.asciiz "Catherine\n"
 Elle:     .asciiz "Elle\n"
 names:    .word Ryan, Austin, Catherine, Elle
 iterator: .word 0
 size:     .word 3

.text

la  $t0 names
lw  $t1 iterator
lw  $t2 size

# print(names[i])
begin_loop:

bgt $t1 $t2 exit_loop
sll $t3 $t1 2 		#t3 = 4 * i
addu $t3 $t3 $t0	# 4i = 4i + mem location of the array --> 1000 + 4 = 1004

li $v0 4
lw $a0 0($t3)
syscall

addi $t1 $t1 1

j begin_loop

exit_loop:
