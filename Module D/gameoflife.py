# This file was *autogenerated* from the file gameoflife.sage.
from sage.all_cmdline import *   # import sage library
_sage_const_3 = Integer(3); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_4 = Integer(4)
import copy

class Board:
	
	def __init__(self, initial_layout):

		self._aliveCells = {}
		self._frozenCells = {}
		self._possibleRevival = []

		self._cells = {}

		self._r = initial_layout.nrows()
		self._c = initial_layout.ncols()

		#Construct the original "board"
		for i in xrange(self._r):
			for j in xrange(self._c):

				alive = True if (initial_layout[i, j] ==  _sage_const_1 ) else False
				#All cells are stored in a ditionary that is mapped by their position on the board.
				#self._cells[c.pos()] = c

				#Keep track of the live cells.
				if alive:
					c = Cell(pos=(i, j), alive=alive, board=self)
					self._aliveCells[c.pos()] = c


	def play(self):

		#self.findPossibleRevivals()

		cells = self._aliveCells
		for cell in cells:
			cells[cell].update()

	def display(self):

		print " ",
		for i in range(self._c):
			print i,
		print ""

		for i in range(self._c):
			print i,
			for j in range(self._r):
				if (i, j) in self._aliveCells or (i, j) in self._frozenCells:
					print "X",
				else:
					print " ",
			print ""
		print "\n"

	def live(self):
		print self._aliveCells

	def getActiveCells(self):
		return dict( self._aliveCells.items() +  self._frozenCells.items() )

	def nrows(self):
		return self._r

	def ncols(self):
		return self._c



class Cell:

	def __init__(self, pos, alive, board, neighbours=[]):

		self._pos = pos
		self._alive = alive
		self._neighbours  = neighbours
		self._board = board

	def __repr__(self):
		return str(self._pos) + " - " + str(self._alive)

	def setNeighbours(neighbours):
		self._neighbours = neighbours

	def getNeighbours(self):
		return self._neighbours

	def addNeighbour(cell):
		self._neighbours.append(cell)

	def isAlive(self):
		return self._alive

	def kill(self):
		self._alive = False

	def pos(self):
		return self._pos

	def x(self):
		return self._pos[_sage_const_0 ]

	def y(self):
		return self._pos[_sage_const_1 ]

	def update(self):

		n = self.findNeighbours()

		#If True then survives, False dead.
		if n <= _sage_const_1 :
			return False
		if n >= _sage_const_4 :
			return False
		else:
			return False



	def generateNeighbours(self):

		b = self._board
		r, c = self.pos()

		rmin = (r - _sage_const_1 ) if (r - _sage_const_1  >= _sage_const_0 ) else _sage_const_0 
		rmax = (r + _sage_const_1 ) if (r + _sage_const_1  < b.nrows()) else b.nrows()
		cmin = (c - _sage_const_1 ) if (c - _sage_const_1  >= _sage_const_0 ) else _sage_const_0 
		cmax = (c + _sage_const_1 ) if (c + _sage_const_1  < b.ncols()) else b.ncols()

		n = _sage_const_0 
		#Count neighbours
		for i in range(rmin, rmax):
			for j in range(cmin, cmax):
				pass
		return n


def mDp4(m, k):

	b = Board(m)
	b.display()
	for i in range(k):
		print "Step: ", k + _sage_const_1 
		print ""
		b.play()
		b.display()


#m = Matrix([ [1, 0, 0], [0, 1, 0], [0, 0, 1] ])
#mDp4(m, 1)


def mDp2(m):

	new = copy.copy(m)
	for r in range(m.nrows()):
		for c in range(m.ncols()):

			rmin = (r - _sage_const_1 ) if (r - _sage_const_1  >= _sage_const_0 ) else r
			rmax = (r + _sage_const_1 ) if (r + _sage_const_1  < m.nrows()) else r
			cmin = (c - _sage_const_1 ) if (c - _sage_const_1  >= _sage_const_0 ) else c
			cmax = (c + _sage_const_1 ) if (c + _sage_const_1  < m.ncols()) else c

			count = _sage_const_0 
			ncheck = _sage_const_0 
			for i in range(rmin, rmax + _sage_const_1 ):
				for j in range(cmin, cmax + _sage_const_1 ):
					if(i, j) != (r, c):
						ncheck += _sage_const_1 
					if m[i, j] == _sage_const_1  and (i, j) != (r, c):
						count += _sage_const_1 

			if count < _sage_const_2 :
				new[r, c] = _sage_const_0 
			elif count > _sage_const_3 :
				new[r, c] = _sage_const_0 
			elif count == _sage_const_2  and m[r, c] == _sage_const_1 :
				new[r, c] = _sage_const_1 
			elif count == _sage_const_3 :
				new[r, c] = _sage_const_1 

	return new


def mDp1(m, c):
	m = mDp2(m)
	r, c = c
	return m[r, c]

def mDp3(m, k):

	for _ in range(k):
		m = mDp2(m)
	return m

A = matrix([ [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_0 ] ])
#ans = mDp3(A, 6)
#print ans

def mDp5():
	lis = [ \
		matrix([ [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 ], [_sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_0 ], [_sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_0 ], [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 ] ]), \
		matrix([ [ _sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_0 ] ]), \
		matrix([  [_sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_0 ], ]), \
		matrix([ [_sage_const_1 , _sage_const_1 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_1 , _sage_const_0 ] ]), \
		matrix([ [_sage_const_0 , _sage_const_1 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_1 , _sage_const_0 ] ]), \
		matrix([ [_sage_const_1 , _sage_const_1 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_1 , _sage_const_1 ] ]), \
		matrix([ [_sage_const_1 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_1 ]]), \
		matrix([ [_sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_1 ], [_sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_0 ] ]), \
		matrix([ [_sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_0 ], [_sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_0 ] ]), \
		matrix([ [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_0 ] ]) \
	]

	return lis


def mDp6():

	lis = [ \
		matrix([ [_sage_const_1 , _sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_1 ] ]), \
		matrix([ [_sage_const_0 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_1 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_0 ] ]), \
		matrix([ [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 ], [_sage_const_0 , _sage_const_1 , _sage_const_1 , _sage_const_1 ], [_sage_const_1 , _sage_const_1 , _sage_const_1 , _sage_const_0 ], [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 ] ]), \
		matrix([ [_sage_const_1 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_1 ], [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_1 ] ]), \
		matrix([ [_sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_1 , _sage_const_0 ], [_sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_1 ], [_sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_0 ] ]) \
	]

	return lis

def mDp7():

	lis = [ \
		matrix([ [_sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_0 , _sage_const_1 , _sage_const_1 ], [_sage_const_1 , _sage_const_1 , _sage_const_0 ] ]), \
		matrix([ [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_0 ], [_sage_const_0 , _sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_1 ], [_sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 ], [_sage_const_1 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_1 ], [_sage_const_1 , _sage_const_1 , _sage_const_1 , _sage_const_1 , _sage_const_1 , _sage_const_0 ] ]) \
	]

	return lis

def mDp8(m, k):

	def play(m):
		new = copy.copy(m)
		for r in range(m.nrows()):
			for c in range(m.ncols()):

				rcurr = r
				ccurr = c

				checked = _sage_const_0 
				count = _sage_const_0 
				for i in range(-_sage_const_1 , _sage_const_2 ):
					rcurr = (r + i) % m.nrows()				
					for j in range(-_sage_const_1 , _sage_const_2 ):
						ccurr = (c + j) % m.ncols()
						if m[rcurr, ccurr] == _sage_const_1  and (rcurr, ccurr) != (r, c):
							count += _sage_const_1 
						if (rcurr, ccurr) != (r, c):
							checked += _sage_const_1 






				if count < _sage_const_2 :
					new[r, c] = _sage_const_0 
				elif count > _sage_const_3 :
					new[r, c] = _sage_const_0 
				elif count == _sage_const_2  and m[r, c] == _sage_const_1 :
					new[r, c] = _sage_const_1 
				elif count == _sage_const_3 :
					new[r, c] = _sage_const_1 



		return new

	for _ in range(k):
		m = play(m)

	return m

def mDp9(m, k):

	def play(m):

		print "Before:"
		print m

		new = copy.copy(m)
		for r in range(m.nrows()):
			for c in range(m.ncols()):

				rcurr = r
				ccurr = c

				checked = _sage_const_0 
				count = _sage_const_0 
				for i in range(-_sage_const_1 , _sage_const_2 ):
					rcurr = (r + i) % m.nrows()				
					for j in range(-_sage_const_1 , _sage_const_2 ):
						#ccurr = (c + j) % m.ncols()
						if c + j < _sage_const_0 :
							ccurr = m.ncols() - _sage_const_1  - c
						if m[rcurr, ccurr] == _sage_const_1  and (rcurr, ccurr) != (r, c):
							count += _sage_const_1 
						if (rcurr, ccurr) != (r, c):
							checked += _sage_const_1 






				if count < _sage_const_2 :
					new[r, c] = _sage_const_0 
				elif count > _sage_const_3 :
					new[r, c] = _sage_const_0 
				elif count == _sage_const_2  and m[r, c] == _sage_const_1 :
					new[r, c] = _sage_const_1 
				elif count == _sage_const_3 :
					new[r, c] = _sage_const_1 


		print "After:"
		print new
		print "Correct:"
		print matrix([[_sage_const_0 ,_sage_const_1 ,_sage_const_0 ,_sage_const_0 ,_sage_const_0 ],[_sage_const_0 ,_sage_const_0 ,_sage_const_0 ,_sage_const_1 ,_sage_const_0 ],[_sage_const_0 ,_sage_const_0 ,_sage_const_1 ,_sage_const_0 ,_sage_const_1 ],[_sage_const_1 ,_sage_const_1 ,_sage_const_0 ,_sage_const_0 ,_sage_const_0 ],[_sage_const_0 ,_sage_const_0 ,_sage_const_1 ,_sage_const_0 ,_sage_const_1 ]])
		return new

	for _ in range(k):
		m = play(m)

	return m

a =  matrix([[_sage_const_0 ,_sage_const_0 ,_sage_const_0 ,_sage_const_0 ,_sage_const_0 ],[_sage_const_0 ,_sage_const_0 ,_sage_const_0 ,_sage_const_0 ,_sage_const_0 ],[_sage_const_0 ,_sage_const_0 ,_sage_const_1 ,_sage_const_1 ,_sage_const_1 ],[_sage_const_0 ,_sage_const_0 ,_sage_const_1 ,_sage_const_0 ,_sage_const_1 ],[_sage_const_0 ,_sage_const_0 ,_sage_const_1 ,_sage_const_1 ,_sage_const_1 ]])
k = _sage_const_1 
mDp9(a, k)
