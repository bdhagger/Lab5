.data 
 array: .word 8      # allocates 8 bytes of memory in data
 
.text
 
la       $t0 array   # puts first address of array into $t0
li       $t1 0       # initialize array offset
li       $t3 0       # initialize value to store
move     $t2 $t0     # intitialize address of current array location

loop:

sb      $t3 ($t2)    # put lsb of $t3 into memory address $t2
addi    $t3 $t3 1    # increment value
addi    $t1 $t1 4    # increment array offset
add     $t2 $t0 $t1  # update address

move    $a0 $t3      # print values in array
li      $v0 1
syscall

blt     $t1 32 loop  # conditional statement
li      $v0 10
syscall