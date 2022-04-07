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

100 dim map(250, 2) : rem 25 x 10
105 dim ms(40, 2)
110 dim mt(20, 2)

120 print "Generating map..."
125 for i = 1 to 250
130 gosub 400 : rem gen exits
135 next i

140 print "Generating monsters..."
145 for i = 1 to 40
150 gosub 500 : rem gen monsters
155 next i

175 rem ar = current room
180 let ar = int(rnd(1) * 250) + 1
185 rem ah = current hp
190 let ah = int(rnd(1) * 10) + 10

200 rem game cycle
210 gosub 1500 : rem print room def
220 gosub 1600 : rem input next act
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
520 r = int(rnd(1) * 250) + 1 : rem room
525 if map(r, 1) = 0 then goto 520
530 map(r, 2) = i
599 return

600 rem generate treasure, input: i
699 return

1500 rem print room output, input: ar
1505 i = ar
1510 print "Exits:"; i
1515 if fnci(1) then print "N";
1520 if fnci(2) then print "E";
1525 if fnci(4) then print "S";
1530 if fnci(8) then print "W";
1535 print
1540 if map(i, 2) = 0 then goto 1599
1560 m = map(i, 2)
1575 if ms(m, 1) = 1 then print "Goblin appeared! HP:"; ms(m, 2)
1580 if ms(m, 1) = 2 then print "Elf appeared! HP:"; ms(m, 2)
1585 if ms(m, 1) = 3 then print "Tribble appeared! HP:"; ms(m, 2)
1590 if ms(m, 1) = 4 then print "Wumpus appeared! HP:"; ms(m, 2)

1599 return

1600 rem print

1610 input "Next action"; a$ : a$ = left$(a$,1)
1615 i = ar
1620 if map(i, 2) = 0 then goto 1640
1625 if (a$ = "h" or a$ = "H") then gosub 2000 : goto 1635
1630 print "You monster stops you from leaving!" 
1635 goto 1699
1640 if fnci(1) then if (a$ = "n" or a$ = "N") then ar = ar - 25
1645 if fnci(2) then if (a$ = "e" or a$ = "E") then ar = ar + 1
1650 if fnci(4) then if (a$ = "s" or a$ = "S") then ar = ar + 25
1655 if fnci(8) then if (a$ = "w" or a$ = "W") then ar = ar - 1
1699 return

2000 rem combat routine
2005 i = ar
2010 m = map(i, 2)
2010 ms(m, 2) = ms(m, 2) - 1
2015 if ms(m, 2) <= 0 then print "Monster died!" : map(i, 2) = 0

2999 return

9000 print "Thanks for playing."
