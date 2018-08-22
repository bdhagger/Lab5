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
then made special conditions for which characters get to be printed so that 
zeros and minus signs only appear when needed.

What did you learn in this lab?
In this lab, I got to learn about how arrays and printing characters worked
in MIPS. I also got to learn about different tricks on how to manipulate 
bit numbers to attain the value I want. For example, I never heard of bit 
masking before, but I got to understand what it meant and use it to my 
advantage for this lab.

Did you encounter any issues? Were there parts of this lab you found enjoyable?
I had many issues trying to translate my knowledge of java and C to MIPS. 
Jumping around with loops became messes. Then trying to do simple tasks like
looping through each index of an array was unexpectedly difficult. I did, however, 
enjoy learning about how computers store and print out values differently in 
ASCII than decimal. Even though adding to the values to get from decimal to ASCII
was taught in class, it took seeing in in action to truly understand it.

How would you redesign this lab to make it better?
Similar to the other labs, I believe the prompt should be much more clear than it
was. It took too long to understand whether $s0 would hold an array or binary or 
integer value. I would also advise that the lab parts be divided differently.
To encourage students to actually start earlier on the two week lab, Part A should have 
included the sign extension to be done so that the real half of the lab would be taken care 
of in the first week. Then Part B would only need the ASCII conversions and students could
have more time exploring different conversion methods.
