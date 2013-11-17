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

				alive = True if (initial_layout[i, j] ==  1) else False
				#All cells are stored in a ditionary that is mapped by their position on the board.
				#self._cells[c.pos()] = c

				#Keep track of the live cells.
				if alive:
					c = Cell(pos=(i, j), alive=alive, board=self)
					self._aliveCells[c.pos()] = c


	def play(self):

		self.findPossibleRevivals()

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
		return self._pos[0]

	def y(self):
		return self._pos[1]

	def update(self):

		n = self.findNeighbours()

		#If True then survives, False dead.
		if n <= 1:
			return False
		if n >= 4:
			return False
		else:
			return False



	def generateNeighbours(self):

		b = self._board
		r, c = self.pos()

		rmin = (r - 1) if (r - 1 >= 0) else 0
		rmax = (r + 1) if (r + 1 < b.nrows()) else b.nrows()
		cmin = (c - 1) if (c - 1 >= 0) else 0
		cmax = (c + 1) if (c + 1 < b.ncols()) else b.ncols()

		n = 0
		#Count neighbours
		for i in range(rmin, rmax):
			for j in range(cmin, cmax):
				if (i, j) in cells:
					n += 1
		return n


def mDp4(m, k):

	b = Board(m)
	for i in range(k):
		print "Step: ", k + 1
		print ""
		b.display()
		b.play()


m = Matrix([ [1, 0, 0], [0, 1, 0], [0, 0, 1] ])
mDp4(m, 3)