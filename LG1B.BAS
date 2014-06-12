DECLARE FUNCTION eleCons! (entry$, maxCons!)
DECLARE FUNCTION eleDups! (entry$, maxEles!)
DECLARE FUNCTION incEntry$ (entry$, strlist$, level!)

CLS
GOSUB splash
GOSUB getParams
GOSUB initvars
'gosub errorcheck
OPEN strfile$ FOR OUTPUT AS 1
PRINT #1, entry$
WHILE maxEntry = 0
entry$ = incEntry(entry$, strlist$, intstartsize)
GOSUB cMask
GOSUB wEntry
WEND
CLOSE
PRINT
PRINT "Finished writing the list to "; strfile$
END

splash:
'software info.
PRINT "Skele's List Generator v4.5.4"
PRINT "created by Skele Drew"
PRINT "copyright (c) 2006-2007 Skeleville Software"
PRINT "written on 4/2/06"
PRINT
RETURN

getParams:
INPUT "Enter included characters "; strlist$
INPUT "Enter the start string "; entry$
INPUT "Enter the end string "; eEntry$
INPUT "Enter the maximum amount of an element  "; maxEles '1 to intstartsize.
INPUT "Enter the maximum consecutive elements "; maxCons '0 to intstartsize.
INPUT "Enter the file name for saving "; strfile$
RETURN

initvars:
'calculate and create other variables.
intlistsize = LEN(strlist$)
intstartsize = LEN(entry$)
intendsize = LEN(eEntry$)
maxEntry = 0
RETURN

cMask:
'counts the amount of a single character and consecutive characters.
totEles = eleDups(entry$, maxEles)
IF NOT totEles > maxEles THEN
totCons = eleCons(entry$, maxCons)
END IF
RETURN

wEntry:
'writes the current entry.
'PRINT "debug7: ", totEles, totCons
IF NOT (totEles > maxEles OR totCons > maxCons) THEN
'GOSUB rEntry
PRINT "Writing: ", entry$
PRINT #1, entry$
END IF
'PRINT "debug0: ", entry$, eEntry$
IF entry$ = eEntry$ THEN
maxEntry = 1
END IF
RETURN


rEntry: 'obselete. make function.
'reverses the order of 'entry'.
entry$ = ""
FOR i2 = 1 TO intstartsize
entry$ = MID$(entry$, i2, 1) + entry$
NEXT
RETURN

testParams:
'test values for input.
strlist$ = "ABC"
entry$ = "AAA"
eEntry$ = "CCC"
maxEles = 1
maxCons = 1
strfile$ = "c:\docs\lgtest.txt"
RETURN

'notes:
'to enhance included characters.
'to add masking factor. done
'to add time taken, amount written, etc.
'to add listing interrupt and settings save.
'to add error checking functions.
'to add custom interruptable input and output.

FUNCTION eleCons (entry$, maxCons)
'checks consecutive elements.
intstartsize = LEN(entry$)
FOR i6 = 1 TO (intstartsize - maxCons)
totCons = 0
FOR i7 = i6 TO (i6 + maxCons) 'subtract 1 from 'maxCons'
IF MID$(entry$, i7, 1) = MID$(entry$, (i7 + 1), 1) THEN
totCons = totCons + 1
END IF
IF totCons > maxCons THEN
EXIT FOR
END IF
NEXT
IF totCons > maxCons THEN
EXIT FOR
END IF
NEXT
eleCons = totCons
'PRINT "Maximum Consecutive: "; maxCons
END FUNCTION

FUNCTION eleDups (entry$, maxEles)
'checks the amount of element occurences.
intstartsize = LEN(entry$)
FOR i4 = 1 TO (intstartsize - maxEles)
totEles = 1
FOR i5 = (i4 + 1) TO intstartsize
IF MID$(entry$, i4, 1) = MID$(entry$, i5, 1) THEN
totEles = totEles + 1
END IF
IF totEles > maxEles THEN
EXIT FOR
END IF
NEXT
IF totEles > maxEles THEN
EXIT FOR
END IF
NEXT
eleDups = totEles
'PRINT "Maximum Duplication: "; maxEles
END FUNCTION

FUNCTION incEntry$ (entry$, strlist$, level)
'this function increments a string according to a list of the characters to
'include. it also demonstrates recusive functions (function that calls itself).
'PRINT "debug3: ", level, intlistsize, entry$, strlist$
intlistsize = LEN(strlist$)
intstartsize = LEN(entry$)
'next 5 lines used to increase the 'entry' size if at maximum.
IF level = 0 THEN
entry$ = MID$(strlist$, 1, 1) + entry$
intstartsize = LEN(entry$)
level = intstartsize
END IF
IF level < intstartsize THEN
MID$(entry$, (level + 1), 1) = MID$(strlist$, 1, 1)
'PRINT "debug1: "; entry$, level
END IF
'PRINT "debug2: "; MID$(entry$, level, 1), MID$(strlist$, (intlistsize - 1), 1)
IF MID$(entry$, level, 1) = MID$(strlist$, intlistsize, 1) THEN
level = level - 1
entry$ = incEntry(entry$, strlist$, level)
level = level + 1
ELSE
FOR i = 1 TO intlistsize
IF MID$(entry$, level, 1) = MID$(strlist$, i, 1) THEN
MID$(entry$, level, 1) = MID$(strlist$, (i + 1), 1)
EXIT FOR
END IF
NEXT
END IF
incEntry$ = entry$
END FUNCTION
