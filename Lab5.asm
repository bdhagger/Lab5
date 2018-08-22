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
       fs:  .asciiz "0xFFFFFF"
       os:  .asciiz "0x000000"
       

.text
       la      $a0   bn          # print binary message
       li      $v0   4 
       syscall               

       lw      $t0   ($a1)       # read and print program argument string
       move    $a0   $t0
       li      $v0   4
       syscall

       lb      $t1   ($t0)       # put first character of arg string into t1
       move    $a0   $t1
       
       lb      $t2   one         # load string "1" into t2
       move    $a0   $t2
       
       li      $s0   0           # initialize s0 to zero
       
       beq     $t1   $t2   rEq
       
 
back1: 
       la      $a0   nl          # print a new line
       li      $v0   4
       syscall
       
       addi    $t3   $zero 0     # initialize index to 0
       addi    $t4   $zero 8     # initialize power to 7
       addi    $t5   $zero 0     # initialize binary value to 0       
       
while:
       beq     $t3   8     hextime
       lb      $t1   ($t0)       # put first character of arg string into t3
       move    $a0   $t1
       #li      $v0   11	 # print each character of string
       #syscall
      
       beq     $t1   $t2   rEq2  # ones found in binary

midw:      
       addi    $t0   $t0   1
       li      $v0   4
       la      $a0   nl          # print a new line
       #syscall
       
       addi    $t3   $t3   1
       j       while

rEq2:
       sub     $t4   $t4   1
       move    $a0   $t4         # print the power
       li      $v0   1
       #syscall
       
       li      $t7  0
       beq     $t4  $t7 found0
       li      $t7  1
       beq     $t4  $t7 found1
       li      $t7  2
       beq     $t4  $t7 found2
       li      $t7  3
       beq     $t4  $t7 found3
       li      $t7  4
       beq     $t4  $t7 found4
       li      $t7  5
       beq     $t4  $t7 found5
       li      $t7  6
       beq     $t4  $t7 found6
       li      $t7  7
       beq     $t4  $t7 found7
       
       j       midw

found0:
       add     $s0  $s0 1
       j       midw
       
found1:
       add     $s0  $s0 2
       j       midw
       
found2:
       add     $s0  $s0 4
       j       midw
       
found3:
       add     $s0  $s0 8
       j       midw
       
found4:
       add     $s0  $s0 16
       j       midw
       
found5:
       add     $s0  $s0 32
       j       midw
       
found6:
       add     $s0  $s0 64
       j       midw
       
found7:
       add     $s0  $s0 128
       j       midw
       
hextime:
       la      $a0 hx     # print hex message
       li      $v0 4
       syscall
       
       lw      $t0   ($a1)       # read and print program argument string
       lb      $t1   ($t0)       # put first character of arg string into t1
       move    $a0   $t1
       
       beq     $t1   $t2   printFs
       
       la      $a0   os
       li      $v0   4
       syscall

hex:
       #move    $a0 $s0
       #li      $v0 34
       #syscall
  
       la      $a0 dc     # print dec message
       li      $v0 4
       syscall
       
       move    $a0   $s0         # print value of s0
       li      $v0   1
       syscall
       
       la      $a0 nl     # print new line
       li      $v0 4
       syscall
       
       li      $v0   10          # end
       syscall

printFs:
       la      $a0   fs
       li      $v0   4
       syscall
       j       hex
     
rEq:
       add     $s0   $s0   -256  # sign extend by adding the 24 1s in front of the 8 bit binary number
       j       back1
       
  

