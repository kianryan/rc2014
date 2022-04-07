10 rem a simple guessing game
20 a = int(rnd(1) * 10) + 1
30 print "guess a number between 1 and 10"
40 input g
50 if a = g then print "good guess" : goto 80
60 print "not so good";
65 if g < a then print ", try higher"
68 if g > a then print ", try lower"
70 goto 30
80 input "thanks for playing, play again";i$
90 if i$ = "y" goto 20
