10 gosub 8000

50 def fnmod(x) = x - int(x/25) * 25 
55 def fnci(x) = (map(i,1) and x) = x
60 def fncn(x) = (map(i-25,1) and x) = x
65 def fnce(x) = (map(i+1,1) and x) = x
70 def fncs(x) = (map(i+25,1) and x) = x
75 def fncw(x) = (map(i-1,1) and x) = x

100 dim map(250, 4) : rem 25 x 10, mon, treasure, wpn
105 dim ms(40, 3) : rem lbl, hp, str

110 print "Generating map..."
115 for i = 1 to 250
120 gosub 400 : rem gen exits
125 next i

130 print "Generating monsters..."
135 for i = 1 to 40
140 gosub 500 : rem gen monsters
145 next i

150 print "Generating treasure..."
155 for i = 1 to 40 : gosub 600 : next i

170 print "Generating items..."
175 for i = 1 to 10 : gosub 700 : next i
180 for i = 1 to 10 : gosub 700 : next i

190 ar = int(rnd(1) * 250) + 1 : rem cur room
195 ah = int(rnd(1) * 10) + 10 : rem hp
200 at = int(rnd(1) * 10) + 1 : rem strength
205 ai = 0 : rem inventory
210 as = 0 : rem score

250 rem game cycle
255 gosub 1500 : rem print room def
260 gosub 2000 : rem input next act
265 goto 250

310 goto 9000 : end

400 rem generate map, input: i
410 map(i,1) = int((rnd(1) * 15)) + 1 : rem start

412 rem add historic cells
413 j = i-25
415 if i>25 then if fnci(1) and not(fncn(4)) then map(j,1)=map(j,1)+4
417 j = i-1
420 if i>1 then if fnci(8) and not(fncw(2)) then map(j,1)=map(j,1)+2

425 rem edges
430 if i <= 25 and fnci(1) then map(i, 1) = map(i, 1) - 1
435 if fnmod(i) = 0 and fnci(2) then map(i, 1) = map(i, 1) - 2
440 if i >= 226 and fnci(4) then map(i, 1) = map(i, 1) - 4
445 if fnmod(i) = 1 and fnci(8) then map(i, 1) = map(i, 1) - 8

450 rem adjacent rooms
455 if i>25 then if fncn(4) and not(fnci(1)) then map(i,1) = map(i,1)+1
460 if i<250 then if fnce(8) and not(fnci(2)) then map(i,1) = map(i,1)+2
465 if i<225 then if fncs(1) and not(fnci(4)) then map(i,1) = map(i,1)+4
470 if i>1 then if fncw(2) and not(fnci(8)) then map(i,1) = map(i,1)+8

499 return

500 rem generate monster, input: i
510 ms(i, 1) = int(rnd(1) * 4) + 1 : rem name
515 ms(i, 2) = int(rnd(1) * 10) + 1 : rem hp
520 ms(i, 3) = int(rnd(1) * 4) + 1 : rem str
525 r = int(rnd(1) * 250) + 1 : rem room
530 if map(r, 1) = 0 then goto 525
535 map(r, 2) = i
599 return

600 rem generate treasure, input: i
605 r = int(rnd(1) * 250) + 1 : rem room
610 if map(r, 1) = 0 then goto 605
615 map(r, 3) = int(rnd(1) * 4) + 1 : rem name
699 return

700 rem generate items, input: i
705 r = int(rnd(1) * 250) + 1 : rem room
710 if map(r, 1) = 0 then goto 605
715 map(r, 4) = i : rem items escalate
799 return

1500 rem print room output, input: ar
1505 i = ar

1510 print : print "Exits: "; 
1515 if fnci(1) then print "North ";
1520 if fnci(2) then print "East ";
1525 if fnci(4) then print "South ";
1530 if fnci(8) then print "West ";
1535 print

1600 if map(i, 2) = 0 then goto 1700
1605 m = map(i, 2) : q = ms(m, 1) : gosub 7000
1610 print l$; " appeared! HP:"; ms(m, 2); "Str: " ms(m, 3)

1700 if map(i, 3) = 0 then goto 1800
1705 m = map(i, 3) : q = m : gosub 7100
1710 print "Treasure! A golden "; l$; "!"

1800 if map(i, 4) = 0 then goto 1900
1805 m = map(i, 4) : q = m : gosub 7200
1810 print "A "; l$ ; " lies on the floor"

1900 print
1910 print "You've scored "; as; "/40"
1915 print "You have "; ah; " HP"
1920 print "You have "; at; " Str"
1930 if ai = 0 goto 1999
1935 q = ai : gosub 7200
1940 print "You're carrying a "; l$ ; "(+" ; ai ; ")"
1999 return

2000 print : input "Next action"; a$ : a$ = left$(a$,1)
2005 i = ar
2010 if map(i, 2) = 0 then goto 2030
2015 if (a$ = "h" or a$ = "H") then gosub 3000 : goto 2025
2020 print "You monster stops you from leaving!" 
2025 goto 2999 : rem combat end
2030 m = map(i, 3) <> 0 or map(i, 4)<>0
2035 if m then if (a$="p" or a$="P") then gosub 4000
2040 if fnci(1) then if (a$ = "n" or a$ = "N") then ar = ar - 25
2045 if fnci(2) then if (a$ = "e" or a$ = "E") then ar = ar + 1
2050 if fnci(4) then if (a$ = "s" or a$ = "S") then ar = ar + 25
2055 if fnci(8) then if (a$ = "w" or a$ = "W") then ar = ar - 1
2999 return

3000 rem combat routine
3005 i = ar
3010 m = map(i, 2)
3015 cs = (ms(m, 3) * rnd(1)) - (at * rnd(1))
3020 if cs > 0 goto 3050
3025 rem monster hit
3030 print "player hits the monster!"
3035 ms(m, 2) = ms(m, 2) - 1
3040 if ms(m, 2) <= 0 then print "Monster died!" : map(i, 2) = 0
3045 goto 3999
3050 rem player hit
3055 print "monster hits the player!"
3060 ah = ah - 1
3065 if ah <= 0 then print "You died!" : goto 9000
3999 return

4000 rem pick-up routine
4005 i = ar
4010 if map(i, 3) = 0 then goto 4100 : rem treasure
4015 print "You pick up the treasure!"
4020 as = as + 1
4025 map(i, 3) = 0
4029 if as > 39 goto 9050 : rem win condition
4030 goto 4999
4100 if map(i, 4) = 0 then goto 4999 : rem item
4105 m = map(i, 4) : map(i, 4) = 0
4110 if ai = 0 goto 4200 : rem drop
4115 q = ai : gosub 7200 : print "You drop the " l$
4120 map(i, 4) = ai
4125 at = at - ai : rem str
4200 q = m : gosub 7200 : print "You pick up the " l$
4205 ai = m
4210 at = at + ai : rem str
4999 return

7000 rem creature label setting, input q
7005 if q = 1 then l$ = "Goblin"
7010 if q = 2 then l$ = "Elf"
7015 if q = 3 then l$ = "Tribble"
7020 if q = 4 then l$ = "Wumpus"
7025 return

7100 rem treasure label setting, input q
7105 if q = 1 then l$ = "chest!"
7110 if q = 2 then l$ = "chalice!"
7115 if q = 3 then l$ = "fleece!"
7120 if q = 4 then l$ = "harp!"
7125 return

7200 rem item label setting, input q
7205 if q = 1 then l$ = "toothpick"
7210 if q = 2 then l$ = "knife"
7215 if q = 3 then l$ = "small sword"
7220 if q = 4 then l$ = "rapier"
7225 if q = 5 then l$ = "axe"
7230 if q = 6 then l$ = "double headed axe"
7235 if q = 7 then l$ = "large sword"
7240 if q = 8 then l$ = "VERY large sword"
7245 if q = 9 then l$ = "great axe"
7250 if q = 10 then l$ = "a VERY large sword, with knobbly bits"
7255 return

8000 rem intro
8005 print "A very small adventure!"
8010 print "-----------------------"
8015 print "A procedurally generated adventure game, where no"
8020 print "two adventures are the same."
8025 print
8030 print "Try and find all 40 treasures in the 250 room dungeon."
8035 print
8040 print "Commands:"
8045 print "(N)orth, (S)outh, (E)ast, (W)est, (P)ick Up, (H)it"
8050 print
8999 return

9000 rem dead
9005 print "You found "; as; " out of 40 treasures!" : goto 9999
9050 print "You found ALL the treasures!  You retire to a life of "
9060 print "luxury and excess.  Until your next adventure."
9999 print "Thanks for playing!"
