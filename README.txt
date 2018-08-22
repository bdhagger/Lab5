------------------------
Lab 5: ASCII Binary to Decimal
CMPE 012 Summer 2018

Haggerty, Barbara Louise
bdhagger
-------------------------

What was your approach to converting the binary number to decimal?
To convert the binary number to a decimal, I took my 32-bit sign-extended
value and manipulated it to first print the hundreds place, then the tens 
place, and finally the ones place. I masked and XORed the bits of the number
then made special conditions for which characters get to be printed.

What did you learn in this lab?
In this lab, I got to learn about how arrays and printing characters worked
in MIPS. I also got to learn about different tricks on how to manipulate 
bit numbers to attain the value I want. For example, I never heard of bit 
masking before, but I got to understand what it meant and use it to my 
advantage.

Did you encounter any issues? Were there parts of this lab you found enjoyable?
I had many issues trying to translate my knowledge of java and C to MIPS. 
Jumping around with loops became messes. Then trying to do simple tasks like
looping through each index of an array was unexpectedly difficult. I did, however, 
enjoy leanring about how computers store and print out values differently in 
ASCII than how they were originally. Even though adding certain values to your
registers was taught in class, it took seeing in in action to truly understand it.

How would you redesign this lab to make it better?
Similar to the other labs, I believe the prompt should be much more clear than it
was. It took too long to understand whether $s0 would hold an array or binary or 
integer value. I would also try to advise that the lab parts to be divided differently.
To encourage students to actually start earlier on the two week lab, Part A should have 
included the sign extension to be done. Then Part B would only need the ASCII conversions
to be done and the students would have gotten the rea; first half of the project done 
before it.
