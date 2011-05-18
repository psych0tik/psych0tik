#!/usr/bin/python
import curses, sys, random, time, os, signal
## TODO
## initialise curses
## make used chars less liekly in random pool
## >> randchar class i think, then make it public
## PUT THE BLOODY COLOURS BACK!
## make damn sure that curser is off
## initPairs() shouldn't be a method of ScreenObj
class ScreenObj(object):
    def __init__(self):
        self.Running = True
        self.stdscr = curses.initscr()
        curses.noecho()
        curses.start_color()
        self.origmodes = []
        if True: #curses.can_change_color():## Debug _ True:
            for i in range(1,6):
                self.origmodes.append(curses.color_content(i))
            curses.init_color(1, 0, 150, 0)
            curses.init_color(2, 0, 350, 0)
            curses.init_color(3, 0, 500, 0)
            curses.init_color(4, 0, 680, 0)
            curses.init_color(5, 0, 999, 0)
        self.initPairs()
        self.height, self.width = self.stdscr.getmaxyx()
        self.stdscr.refresh()
    def initPairs(self):
        """THIS DOESN'T NEED TO BE A METHOD!!"""
        curses.init_pair(1, 1, curses.COLOR_BLACK)
        curses.init_pair(2, 2, curses.COLOR_BLACK)
        curses.init_pair(3, 3, curses.COLOR_BLACK)
        curses.init_pair(4, 4, curses.COLOR_BLACK)
        curses.init_pair(5, 5, curses.COLOR_BLACK)    
    def _destroy(self):
        iter = 1
        for i, h, j in self.origmodes:
            #print iter, i, h, j
            curses.init_color(iter, i, h, j)
            iter += 1
        self.initPairs() ## demethodise!
class scrollingLetter(object):
    def __init__(self, screen, x=-1, y=-1, trailLength=3, charlist=[' ']):
        self.charlist = charlist
        self.train = [random.choice(self.charlist)]
        self.trailLength = trailLength
        self.length = 0
        self.modeLength = len(self.getModes())
        self.screen = screen
        if x == -1: self.x = random.randint(0,self.screen.width)
        else: self.x = x
        if y == -1: self.y = highRandInt(self.screen.height-8)
        else: self.y = 0
        self.bottom = self.screen.height
    def getModes(self):
        return [curses.color_pair(5),curses.color_pair(4),curses.color_pair(3),curses.color_pair(2),curses.color_pair(1) ]
    def _pump(self):
        modes = self.getModes()
        self.length += 1
        if random.random() < .02: return self._die(0)
        elif self.y + self.length + 1> self.screen.height:
            return self._die(random.randint(0, self.screen.height))
        self.train.append(random.choice(self.charlist))
        i = 0
        while i < len(self.train) and self.y + self.length-i< self.screen.height and i < self.modeLength: 
            if len(modes) > 1:
                try: self.screen.stdscr.addstr(self.y+self.length-i, self.x, self.train[-i], modes.pop(0))
                except: pass
            else:
                self.screen.stdscr.addstr(self.y+self.length-i, self.x, self.train[-i], modes[-1])
            i += 1
        return True
    def _die(self, newPos):
        for i in range(0, len(self.getModes())):
            try: self.screen.stdscr.addstr(self.y+self.length-i, self.x, self.train[-i], self.getModes()[-1])
            except: pass
        return newPos
def highRandInt(high):
    low = high/2
    return random.randint(0, low)*2

