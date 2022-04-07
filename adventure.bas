10 print "A very small adventure!"
20 print "-----------------------"
30 print "A procedurally generated adventure"
35 print "game, where no two adventures are "
40 print "the same."
45 print

50 def fnmod(x) = x - int(x/25) * 25 
55 def fnci(x) = (map(i,1) and x) = x
60 def fncn(x) = (map(i-25,1) and x) = x
65 def fnce(x) = (map(i+1,1) and x) = x
70 def fncs(x) = (map(i+25,1) and x) = x
75 def fncw(x) = (map(i-1,1) and x) = x

100 dim map(250, 3) : rem 25 x 10, mon, treasure
105 dim ms(40, 3) : rem lbl, hp, str

120 print "Generating map..."
125 for i = 1 to 250
130 gosub 400 : rem gen exits
135 next i

140 print "Generating monsters..."
145 for i = 1 to 40
150 gosub 500 : rem gen monsters
155 next i

160 print "Generating treasure..."
165 for i = 1 to 40
170 gosub 600 : rem gen treasure
175 next i

180 ar = int(rnd(1) * 250) + 1 : rem cur room
185 ah = int(rnd(1) * 10) + 10 : rem hp
186 at = int(rnd(1) * 10) + 1 : rem strength
190 let as = 0

200 rem game cycle
210 gosub 1500 : rem print room def
220 gosub 2000 : rem input next act
230 goto 200

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
612 print r
615 map(r, 3) = int(rnd(1) * 4) + 1 : rem name
699 return

1500 rem print room output, input: ar
1505 i = ar

1510 print : print "Exits:"; i ;
1515 if fnci(1) then print "N";
1520 if fnci(2) then print "E";
1525 if fnci(4) then print "S";
1530 if fnci(8) then print "W";
1535 print

1600 if map(i, 2) = 0 then goto 1700
1605 m = map(i, 2)
1610 if ms(m, 1) = 1 then l$ = "Goblin"
1615 if ms(m, 1) = 2 then l$ = "Elf"
1620 if ms(m, 1) = 3 then l$ = "Tribble"
1625 if ms(m, 1) = 4 then l$ = "Wumpus"
1630 print l$; " appeared! HP:"; ms(m, 2); "Str: " ms(m, 3)

1700 if map(i, 3) = 0 then goto 1990
1705 m = map(i, 3)
1710 if m = 1 then l$ = "chest!"
1715 if m = 2 then l$ = "chalice!"
1720 if m = 3 then l$ = "fleece!"
1725 if m = 4 then l$ = "harp!"
1730 print "Treasure! A golden "; l$; "!"

1990 print "You've scored "; as; "/40"
1995 print "You have "; ah; " HP"
1997 print "You have "; at; " Str"
1999 return

2000 input "Next action"; a$ : a$ = left$(a$,1)
2005 i = ar
2010 if map(i, 2) = 0 then goto 2030
2015 if (a$ = "h" or a$ = "H") then gosub 3000 : goto 2025
2020 print "You monster stops you from leaving!" 
2025 goto 2999 : rem combat end
2030 if map(i,3)<>0 then if (a$="p" or a$="P") then gosub 4000
2035 if fnci(1) then if (a$ = "n" or a$ = "N") then ar = ar - 25
2040 if fnci(2) then if (a$ = "e" or a$ = "E") then ar = ar + 1
2045 if fnci(4) then if (a$ = "s" or a$ = "S") then ar = ar + 25
2050 if fnci(8) then if (a$ = "w" or a$ = "W") then ar = ar - 1
2999 return

3000 rem combat routine
3005 i = ar
3010 m = map(i, 2)
3015 cs = ms(m, 3) * rnd(1) - at * rnd(1)
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
4010 print "You pick up the treasure!"
4015 as = as + 1
4020 map(i, 3) = 0
4999 return


9000 print "Thanks for playing."
