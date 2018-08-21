.data 
 array: .asciiz "David"      # allocates 8 bytes of memory in data
 nl:    .asciiz "\n"

.text
 
la       $t1 array   # puts first address of array into $t0
move     $a0 $t1     # intitialize address of current array location
li       $v0 4       # initialize array offset
syscall

la       $a0 nl
syscall

la      $t2 array
lb      $a0 3($t2)
li      $v0 11
syscall