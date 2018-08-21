.data 
  
       sl: .asciiz "Hello world.\n"

.text
       la     $t2 sl
       move   $a0 $t2
       li     $v0 4
       syscall
       
       la     $t2 sl
       lb     $a0 6($t2)
       li     $v0 11
       syscall
  


  
























