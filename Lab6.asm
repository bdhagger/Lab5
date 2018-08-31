####################################################################################
# Created by:  Haggerty, Barbara Louise
#              bdhagger
#              23 August 2018
#
# Assignment:  Lab 6: Musical Subroutines
#              CMPE 012, Computer Systems and Assembly Language
#              UC Santa Cruz, Summer 2018
# 
# Description: This program will read a string that lists a series of notes with  
#              pitch and duration. The string will be interpreted as audio which 
#              will then be played using the syscall system service 33.
# 
# Notes:       This program is intended to be run from the MARS IDE.
####################################################################################

# REGISTER USAGE

# $t1 gets string address
# $t2 is a null character
# $t3 is an ascii space
# $t4 holds value to output

#---------- play_song ----------

# input: $a0 - address of first character in string containing song
#        $a1 - tempo of song in beats per minute

#------- get_song_length -------

# input:  $a0 - address of first character in string containing song
# output: $v0 - number of notes in song

#---------- play_note ----------

# input: $a0 - pitch
#        $a1 - note duration in milliseconds

#---------- read_note ----------

# input: $a0 - address of first character in string containing note encoding
#        $a1 - rhythm of previous note
#
# output: $v0 - note rhythm in bits [31:16], note pitch in bits [15:0]
#               note rhythm: (1 = 4 beats, 2 = 2 beats, 4 = 1 beat,
#                             8 = 1/2 beat, 16 = 1/4 beat)
#               note pitch: (MIDI value, 0-127)
#         $v1 - address of first character of what would be next note

#---------- get_pitch ----------

# input: $a0 - address of first character in string containing note encoding
#
# output: $v0 - MIDI pitch value
#         $v1 - address of character after pitch is determined

#--------- get_rhythm -----------

# input: $a0 - address of character in string containing song encoding
#              after pitch is determined
#        $a1 - previous note rhythm
#
# output: $v0 - note rhythm, default to previous note rhythm if no number
#               is present in note encoding
#  
#         $v1 - address of first character of next note

####################################################################################

.text
     
#---------- play_song ----------
play_song:  
            # The string address is already in $a0
            # li       $v0         4 
            # syscall
            
            # $a1 has the tempo of song in beats per minute
            # move     $a0, $a1
            # li      $v0 1
            # syscall
            
            # call all the jals here
            jr       $ra
       
#------- get_song_length -------
get_song_length:
       la      $t1              ($a0)               # t1 gets string address
       li      $t2              0x0                 # t2 represents null
       li      $t3              0x20                # t3 is an ascii space
       li      $t4              1                   # t4 temporarily holds the number of notes

gsl:
       lb      $t0              ($t1)               # current character
       beq     $t0              $t2       numNotes  # check if reached the end of the string
       beq     $t0              $t3       space     # check if it's a space
       
       add     $t1              $t1       1         # jump over space
       j       gsl
         
space:
       add     $t4              $t4       1         # increment number of notes      
       add     $t1              $t1       1         # jump over space
       j       gsl
       
numNotes:
       move     $v0             $t4
       jr       $ra
       

           
#---------- play_note ----------
play_note:
            jr       $ra
               
#---------- read_note ----------
read_note:
            
            jr       $ra
                  
#---------- get_pitch ----------
get_pitch:
            jr       $ra
      
#---------- get_rhythm ----------
get_rhythm:                                      
            jr       $ra
       
