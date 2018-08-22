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
# prepare v0 to print string
# print “You entered the binary number:/n” from data declarations
# print original 8 bit number string and new line
#
# loop through each character in the the 8-bit number string
#    convert each character to an integer
# sign extend the 8-bit number to 32 bits and store it in s0
#
# loop through every chunk of 4 bits in s0
#    assign each chunk to its corresponding hex value
# loop through each hex digit
#    convert each hex digit to a string
# print “The hex representation of the sign-extended number is:\n” from data declarations
# print hex string and new line
#
# calculate the hex digits as a decimal based on A-F
# convert each decimal digit to a string
# print “The number in decimal is:\n” from data declarations
# print decimal string and new line
# exit the program

#########################################################################################

# REGISTER USAGE

# a0 stores what will be printed
# a1 is the first program argument

# t0 holds the first program argument
# t1 holds a character of the program argument
# t2 holds the string "1" to compare with 1st character
# t3 is used as an index
# t4 is used for a power
# t5 holds the value of the binary position (2^(7 - i))
# t6 holds integer value for 4 bits of the string

# s0 stores the 32-bit sign extended value entered by the user
# v0 sets the syscalls to print strings and characters only

#########################################################################################

# PROGRAM

.data 
       bn:  .asciiz "You entered the binary number:\n"
       hx:  .asciiz "\nThe hex representation of the sign-extended number is:\n"
       dc:  .asciiz "\n\nThe number in decimal is:\n"
       nl:  .asciiz "\n"
       one: .asciiz "1"
       ox:  .asciiz "0x"
       se:  .asciiz " found a 1 "
       hex_lut:  .byte '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' #lookup table from binary to ascii value as hex for 8 bits

.text
       la      $a0   bn          # print binary message
       li      $v0   4 
       syscall               

       lw      $t0   ($a1)       # read and print program argument string
       move    $a0   $t0
       li      $v0   4
       syscall
       
       la      $a0   nl          # print new line
       li      $v0   4
       syscall

       lb      $t1   ($t0)       # put first character of arg string into t1
       move    $a0   $t1
       
       lb      $t2   one         # load string "1" into t2
       move    $a0   $t2
       
       li      $s0   0           # initialize s0 to zero
       
       
#---------------------------sign extension------------------------------

intFromStr:  li  $t3, 0x00000080   #t3 holds mask
             li  $t2, 0  #loop counter
             li  $t5, 0x00000000 #final int
            
loop900:     add $t4, $t0, $t2  #get address of charecter
             lb  $t4, ($t4)     #store charecter iun t4
             beq $t4, 48, shiftMask
             
             or  $t5, $t5, $t3
shiftMask:   srl $t3, $t3, 1
             add $t2, $t2, 1       
             bne $t2, 8,  loop900
             
             li $t2, 0x00000080
             and $t2, $t2, $t5
             beq $t2, 0, done 
             addi $t5, $t5, 0xFFFFFF00          
             
done:        add $t4, $t4, 0 #NONDONSADNOSANDOSDNGFKSDNGNFDKJLGNDFSKLGNDWKSL

#-----------------------------hex conversion------------------------------

hextime:
       la      $a0    hx          # print hex message
       li      $v0    4
       syscall
       
       li      $t3    0
       li      $t6    0
       li      $t4    8
       
       lw      $t0   ($a1)         # read and print program argument string
       lb      $t1   ($t0)         # put first character of arg string into t1
       move    $a0   $t1
       
       la      $a0    ox          # print start of hex
       li      $v0    4
       syscall
       
bin2hex:  
       la      $t7,  hex_lut
       move    $t0, $t5 # $t0 contains a signed 32 bit number
       li      $t1, 8  #loop counter

              
loop:  sub     $t1, $t1, 1     #sub loop counter
       add     $t3, $t0, 0     #get original number

       mul     $t4, $t1, 4     #get number of times to shift
       srlv    $t3, $t3, $t4   #shift important bits to LSB
       
       and     $t3, $t3, 0xF   # mask off bits we don't care about
       add     $t3, $t3, $t7   #add look up table offset
       lb      $t3, ($t3)      # load in ascii value from table
       sub     $sp,$sp,4       # push t3 onto the stack
       sw      $t3,($sp)
       bne     $t1, 0, loop    #exit loop when done
       
       

printHexFromStack:  li    $t1, 8  #loop counter
                    addi  $sp, $sp, 28
                    
printLoop: sub     $t1, $t1, 1     #sub loop counter  
           lw      $t3,($sp)       #pop stack to t3
           sub     $sp,$sp,4       # push t3 onto the stack
           
           move   $a0, $t3
           li     $v0, 11
           syscall
           bne  $t1, 0 printLoop
           
#-----------------------end of hex conversion------------------------------

dectime:  
       la      $a0 dc             # print dec message
       li      $v0 4
       syscall
       
       move    $a0   $s0          # print value of s0
       li      $v0   1
       syscall
       
       la      $a0 nl             # print new line
       li      $v0 4
       syscall
       
       li      $v0   10           # end
       syscall 


  

