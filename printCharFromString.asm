.data 
 array: .asciiz "David"      # allocates 8 bytes of memory in data
 nl:    .asciiz "\n"

.text
 
la       $t1 array   # puts first address of array into $t1
move     $a0 $t1     
li       $v0 4       # prints "David"
syscall

la       $a0 nl      # prints a new line
syscall

la      $t2 array    
lb      $a0 3($t2)   # prints array[3] which is "i"
li      $v0 11
syscall
