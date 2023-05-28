1000 rem ------------------------------
1010 rem creating a maze in basic
1020 rem ------------------------------
1030 rem initialisation definitions
1040 rem ------------------------------
1050 dim v(19,11):rem visited pos
1060 dim xs(19)  :rem maze x values
1070 dim ys(11)  :rem maze y values
1080 dim d$(4)   :rem directions
1090 db=0        :rem debug,0=off
1100 mc=32 +128  :rem maze char
1110 poke 53280,0:rem set border black
1120 poke 53281,0:rem set screen black
1130 rem ------------------------------
1140 rem define stack for x,y
1150 rem ------------------------------
1160 dim px(209):rem stack x pos
1170 dim py(209):rem stack y pos
1180 rem ------------------------------
1190 rem start main
1200 rem ------------------------------
1210 sc=0:rem init stack counter
1220 rem ------------------------------
1230 gosub 4500:rem draw the  maze
1240 rem ------------------------------
1250 rem init or clear the visited pos
1260 rem ------------------------------
1270 fory=1to11:forx=1to19:v(x,y)=0:nextx,y
1280 rem ------------------------------
1290 rem place maze cell pos in array
1300 rem ------------------------------
1310 x=2:fori=1to19:xs(i)=x:x=x+2:nexti
1320 y=1:fori=1to11:ys(i)=y*40:y=y+2:nexti
1330 rem ------------------------------
1340 rem rnd a start pos on top row
1350 rem ------------------------------
1360 x=int(rnd(1)*19)+1:rem rnd x
1370 y=1:rem first line on screen
1380 rem -----------------------------
1390 rem start with the maze path
1400 rem -----------------------------
1410 poke1023+xs(x),mc
1420 poke1023+xs(x)+ys(y),mc
1430 v(x,y)=1:rem mark as visited
1440 rem -----------------------------
1450 rem determin valid positions
1460 rem -----------------------------
1470 rem first clear variable
1480 rem -----------------------------
1490 fori=1to4:d$(i)="":nexti:i=1
1500 rem -----------------------------
1510 rem ok determine the directions
1520 rem ------------------------------
1530 ifx>1thenifv(x-1,y)=0thend$(i)="l":i=i+1
1540 ifx<19thenifv(x+1,y)=0thend$(i)="r":i=i+1
1550 ify<11thenifv(x,y+1)=0thend$(i)="a":i=2
1560 ify>1thenifv(x,y-1)=0thend$(i)="u":i=2
1570 rem -----------------------------
1580 if db=1 then gosub4200:rem debug
1590 rem -----------------------------
1600 rem now check is a direction is found
1610 rem if not check from stack
1620 rem -----------------------------
1630 ifi=1then gosub4100:ifi<>1then1490
1640 rem -----------------------------
1650 rem is none on stack then done
1660 rem -----------------------------
1670 if sc=-1 then gosub 4300:goto 1210
1680 rem -----------------------------
1690 rem directions are found
1700 rem -----------------------------
1710 if i>=2 then gosub 4000
1720 rem -----------------------------
1730 rem select a rnd position to go
1740 rem -----------------------------
1750 dd$=d$(int(rnd(1)*i)+1)
1760 rem -----------------------------
1770 rem set new coordinate
1780 rem -----------------------------
1790 if dd$="l" then x=x-1
1800 if dd$="r" then x=x+1
1810 if dd$="a" then y=y+1
1820 if dd$="u" then y=y-1
1830 rem -----------------------------
1840 rem place char in cell of the maze
1850 rem ------------------------------
1860 poke 1023+xs(x)+ys(y),mc
1870 rem ------------------------------
1880 rem mark pos as visited
1890 rem ------------------------------
1900 v(x,y)=1
1910 rem ------------------------------
1920 rem remove wall between cells
1930 rem ------------------------------
1940 xx=xs(x)
1950 yy=ys(y)
1960 rem -- based on last clear wall --
1970 ifdd$="l"thenpoke1023+xx+1+yy,mc
1980 ifdd$="r"thenpoke1023+xx-1+yy,mc
1990 ifdd$="a"thenpoke1023+xx+yy-40,mc
2000 ifdd$="u"thenpoke1023+xx+yy+40,mc
2010 rem ------------------------------
2020 rem validate bounderies are reached
2030 rem ------------------------------
2040 if x<=19 and y<=11 then 1490
2050 rem ------------------------------
2060 rem try other positions if any
2070 rem ------------------------------
2080 if sc>0 then gosub 4100:goto 1490
2090 goto 1230: rem start all over
4000 rem ------------------------------
4010 rem push on stack
4020 rem ------------------------------
4030 if sc<209 then sc=sc+1:px(sc)=x:py(sc)=y
4040 return
4100 rem ------------------------------
4110 rem pop from stack
4120 rem ------------------------------
4130 if sc > 0 then x=px(sc):y=py(sc):sc=sc-1:i=2
4140 if sc = 0 then sc = -1
4141 rem ------------------------------
4150 rem if debug on show retry pos
4151 rem ------------------------------
4160 ifdb=1then poke55296+xs(x)+ys(y),4
4170 return
4200 rem ------------------------------
4210 rem debug on set db=1 to activate
4220 rem ------------------------------
4230 poke214,21:print:poke211,5:printspc(20)
4240 poke214,21:print:poke211,1:print"db";x,y,sc,i
4250 geta$:ifa$="" then 4250 :rem wait
4260 return
4300 rem -----------------------------
4310 rem -- end program open maze
4320 rem -----------------------------
4330 y=int(rnd(1)*11)+1 :rem rnd y pos
4340 x=19:rem start x first line
4350 rem -----------------------------
4360 rem -- create opening on right --
4370 rem -----------------------------
4380 poke 1023+xs(x)+ys(y)+1,mc
4390 geta$:ifa$="" then 4390:rem wait
4400 return
4500 rem -----------------------------
4510 rem --  drawing the maze boxes --
4520 rem -----------------------------
4530 print chr$(147);
4540 rem -----------------------------
4550 rem print first line of maze
4560 rem -----------------------------
4570 print chr$(176)+chr$(99);
4580 for i=1 to 9:print chr$(178)+chr$(99)+chr$(178)+chr$(99);:next i
4590 print chr$(174)
4600 rem -----------------------------
4610 rem print middle part of maze
4620 rem -----------------------------
4630 for y = 1 to 10
4640 for i=1 to 10: print chr$(98)++chr$(32)+chr$(98)+chr$(32);:next i
4650 print chr$(171)+chr$(99);
4660 for i=1 to 9: print chr$(123)+chr$(99)+chr$(123)+chr$(99);:next i
4670 print chr$(179)+chr$(32);
4680 next y
4690 rem -----------------------------
4700 rem last 2 lines of maze
4710 rem -----------------------------
4720 for i=1 to 10: print chr$(98)++chr$(32)+chr$(98)+chr$(32);:next i
4730 print chr$(173)+chr$(99);
4740 for i=1 to 9: print chr$(177)+chr$(99)+chr$(177)+chr$(99);:next i
4750 print chr$(189)
4760 if db=1 then geta$:ifa$="" then 4760: rem wait on key
4770 return
