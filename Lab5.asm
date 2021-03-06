#########################################################################################
# Created by: Haggerty, Barbara Louise
# bdhagger
# 11 August 2018
#
# Assignment: Lab 5: ASCII Binary to Decimal
# CMPE 012, Computer Systems and Assembly Language
# UC Santa Cruz, Summer 2018
#
# Description: This program reads a binary number from user input and prints it out
#              as a binary, hexadecimal, and decimal number.
#
# Notes: This program is intended to be run from the MARS IDE. 
#          * Turn on program arguments from the Settings menu.
#               - "Program arguments provided to MIPS program"
#
#########################################################################################

# PSEUDO CODE

# read and store the 8-bit number string
# print “You entered the binary number:” from data declarations
# print original 8 bit number string and new line
#
# loop through each character in the the 8-bit number string
#    convert each character to an integer with a mask
#    shift the number and add 32 bits then store it in s0
#
# print “The hex representation of the sign-extended number is:” from data declarations
# loop through characters in number string
#    shift and mask bits
#    push them to stack
# loop through each hex digit
#    pop off stack 
#    print ASCII hex
# print new line
#
# print “The number in decimal is:” from data declarations
# calculate each decimal digit like you would on paper
# check if each place rolls over to the next place when adding 1
# set conditions for unwanted zeros in front of number
# print decimal string by each digit and print a new line
# exit the program

#########################################################################################

# REGISTER USAGE

# a0 stores what will be printed
# a1 is the first program argument

# t0 holds the address of the program argument
# t1 is a loop index
# t2 holds a bit mask
# t3 stores a character from the argument string
# t4 holds the hex look up table address
# t5 holds a number to shift by
# t6 is a ones place
# t7 is a tens place
# t8 is a hundreds place

# s0 stores the 32-bit sign extended value entered by the user
# v0 sets the syscalls to print strings and characters only

#########################################################################################

# PROGRAM

.data 
       bn:     .asciiz "You entered the binary number:\n"
       hx:     .asciiz "\nThe hex representation of the sign-extended number is:\n"
       dc:     .asciiz "\n\nThe number in decimal is:\n"
       nl:     .asciiz "\n"
       ox:     .asciiz "0x"
       hx_lut: .byte '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' #lookup table from binary to ascii value as hex for 8 bits

.text
       la      $a0     bn                    # print binary message
       li      $v0     4 
       syscall               
  
       lw      $t0     ($a1)                 # read and print program argument string
       move    $a0     $t0 
       li      $v0     4
       syscall
       
       la      $a0     nl                    # print new line
       li      $v0     4
       syscall

       li      $s0     0                     # initialize s0 to zero
       
#---------------------------sign extension------------------------------

intFromStr:  
       li      $s0     0x00000000            # final int
       li      $t1     0                     # loop counter
       li      $t2     0x00000080            # t3 holds mask
            
bitLoop:     
       add     $t3     $t0        $t1        # get address of character
       lb      $t3     ($t3)                 # store character in t4
       beq     $t3     48         shiftMask  # check if shift is needed
     
       or      $s0     $s0        $t2        # OR the bits
       
shiftMask:   

       srl     $t2     $t2        1          # shift the bits
       add     $t1     $t1        1       
       bne     $t1     8          bitLoop
             
       li      $t1     0x00000080
       and     $t1     $t1        $s0        # AND to get needed bits
       beq     $t1     0          hextime 
       addi    $s0     $s0        0xFFFFFF00 # sign extend with Fs         

#-----------------------------hex conversion------------------------------

hextime:
       la      $a0     hx                    # print hex message
       li      $v0     4
       syscall

       la      $a0     ox                    # print start of hex
       li      $v0     4 
       syscall
       
bin2hex:  
       la      $t4     hx_lut
       li      $t1     8                     # loop counter
              
loop:  sub     $t1     $t1        1          # sub loop counter
       add     $t3     $s0        0          # get original number

       mul     $t5     $t1        4          # get number of times to shift
       srlv    $t3     $t3        $t5        # shift important bits to LSB
       
       and     $t3     $t3        0xF        # mask off bits we don't care about
       add     $t3     $t3        $t4        # add look up table offset
       lb      $t3     ($t3)                 # load in ascii value from table
       sub     $sp     $sp        4          # push t3 onto the stack
       sw      $t3     ($sp)
       bne     $t1     0          loop       # exit loop when done
       
printHexFromStack:  
       li      $t1     8                     # loop counter
       addi    $sp     $sp        28
                    
printLoop: 
       sub     $t1     $t1        1          # sub loop counter  
       lw      $t3     ($sp)                 # pop stack to t3
       sub     $sp     $sp        4          # push t3 onto the stack
           
       move    $a0     $t3                   # print ASCII hex
       li      $v0     11
       syscall
       bne     $t1     0          printLoop
           
#-----------------------decimal conversion------------------------------

dectime:  
       la      $a0     dc                    # print dec message
       li      $v0     4
       syscall
       
binToSignedDec:
       li      $t6      0                    # Onces Place
       li      $t7      0                    # Tens Place
       li      $t8      0                    # Hundreds Place
       
       move    $t1     $s0
       move    $t2     $s0
       andi    $t1     $t1        0x80000000 # mask all bit sign bit
       bne     $t1     0          twos_cmp   # conditional statement
         
subNum:
       sub     $t2     $t2        1          # subtract original value
       j       incOnes
       
check: bne     $t2     0          subNum     # check if digit is a zero
       j       printDec            
       
twos_cmp:
       xori    $t2     0xFFFFFFFF            # XOR the bits
       addi    $t2     $t2        1
       j       subNum

incOnes: 
      add      $t6    $t6         1          # increment the value of the digit
      bne      $t6    10          check
         
incTens: 
      li       $t6     0                     # clear ones place    
      addi     $t7     $t7        1
      bne      $t7     10         check
 
incHuns:  
      li       $t7     0                     # clear tens place    
      addi     $t8     $t8        1
      j        check         
            
printDec:
      beq      $t1     0          printHund
      li       $a0     45                    # print minus Sign
      li       $v0     11
      syscall
          
 printHund: 
       la      $t4     hx_lut         
 
       beq     $t8     0          cond10s    # print hundreds place if it isn't Zero
       add     $t8     $t8        $t4
       lb      $t8     ($t8)
       move    $a0     $t8                     
       li      $v0     11                    # print ASCII decimal in 100s place
       syscall 
       j       print10s
            
cond10s:    
       beqz    $t7     printOnes             # print tens place if it isn't a leading zero

print10s: 
       add     $t7     $t7        $t4
       lb      $t7     ($t7)
       move    $a0     $t7                     
       li      $v0     11                    # print ASCII decimal in 10s place
       syscall
   
 printOnes:   
       add     $t6     $t6        $t4
       lb      $t6     ($t6)
       move    $a0     $t6                     
       li      $v0     11                    # print ASCII decimal in 1s place
       syscall     

       la      $a0     nl                    # print new line
       li      $v0     4
       syscall
       
       li      $v0     10                    # end
       syscall 


  

