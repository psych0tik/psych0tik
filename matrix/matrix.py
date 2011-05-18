#!/usr/bin/python
import curses, sys, random, time, os, signal, libmatrix
import atexit
## TODO
## initialise curses ## make used chars less liekly in random pool
## >> randchar class i think, then make it public
## PUT THE BLOODY COLOURS BACK!
## make damn sure that curser is off
## initPairs() shouldn't be a method of ScreenObj
CHARLIST = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', '\\', ']', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}']
if len(sys.argv) > 2:
    maxChars = int(sys.argv[2])
else:
    maxChars = 3
@atexit.register
def DoOnExit():
    cleanExit(None, None)
pause = 0.0001
if len(sys.argv) > 1:
    pause = float(sys.argv[1])
def cleanExit(sig, stackFram):
    curses.echo()
    os.Term.Running = False ## bad naughty rich, stop accessing arbitrary 
    time.sleep(0.1)
    os.Term._destroy()      ## objects!
    curses.endwin()
    sys.exit()
handlers = []
for i in (1, 2, 3, 4, 5, 6, 7, 8, 10, 11):
    handlers.append(signal.signal(i, cleanExit))
#oldHandler = signal.signal(2, cleanExit)
#newHandler = signal.signal(1, cleanExit)
os.Term = libmatrix.ScreenObj()
curses.curs_set(False) # might need this
iterations = 0
scrollers = []
for i in range (0,os.Term.width):
    scrollers.append(libmatrix.scrollingLetter(os.Term, x=i, y=0, charlist=CHARLIST))
while os.Term.Running:
    if len(scrollers) == 0:
        break
    i = random.choice(scrollers)
    oops = i._pump()
    if oops != True:
        scrollers.append(libmatrix.scrollingLetter(os.Term, i.x, y=oops, charlist=CHARLIST))
        del scrollers[scrollers.index(i)]
    time.sleep(pause)
    os.Term.stdscr.refresh()

