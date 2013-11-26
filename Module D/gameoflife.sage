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
				pass
		return n


def mDp4(m, k):

	b = Board(m)
	b.display()
	for i in range(k):
		print "Step: ", k + 1
		print ""
		b.play()
		b.display()


#m = Matrix([ [1, 0, 0], [0, 1, 0], [0, 0, 1] ])
#mDp4(m, 1)


def mDp2(m):

	new = copy.copy(m)
	for r in range(m.nrows()):
		for c in range(m.ncols()):

			rmin = (r - 1) if (r - 1 >= 0) else r
			rmax = (r + 1) if (r + 1 < m.nrows()) else r
			cmin = (c - 1) if (c - 1 >= 0) else c
			cmax = (c + 1) if (c + 1 < m.ncols()) else c

			count = 0
			ncheck = 0
			for i in range(rmin, rmax + 1):
				for j in range(cmin, cmax + 1):
					if(i, j) != (r, c):
						ncheck += 1
					if m[i, j] == 1 and (i, j) != (r, c):
						count += 1

			if count < 2:
				new[r, c] = 0
			elif count > 3:
				new[r, c] = 0
			elif count == 2 and m[r, c] == 1:
				new[r, c] = 1
			elif count == 3:
				new[r, c] = 1

	return new


def mDp1(m, c):
	m = mDp2(m)
	r, c = c
	return m[r, c]

def mDp3(m, k):

	for _ in range(k):
		m = mDp2(m)
	return m

def mDp4(m, k):
	memo = [False] * m.ncols()

	def play(m):
		new = copy.copy(m)
		for r in range(m.nrows()):
			for c in range(m.ncols()):

				rcurr = r
				ccurr = c

				checked = 0
				count = 0
				for i in range(-1, 2):
					if memo[i] == False:
						continue
					rcurr = (r + i)
					if rcurr < 0:
						continue
					if rcurr == m.nrows():
						continue
					for j in range(-1, 2):
						ccurr = (c + j)
						if ccurr < 0:
							continue
						if ccurr == m.ncols():
							continue
						if m[rcurr, ccurr] == 1 and (rcurr, ccurr) != (r, c):
							count += 1
						if (rcurr, ccurr) != (r, c):
							checked += 1






				if count < 2:
					new[r, c] = 0
				elif count > 3:
					new[r, c] = 0
				elif count == 2 and m[r, c] == 1:
					new[r, c] = 1
					memo[r] = True
				elif count == 3:
					new[r, c] = 1
					memo[r] = True



		return new

	for _ in range(k):
		m = play(m)

	return m

def mDp5():
	lis = [ \
		matrix([ [0, 0, 0, 0], [0, 1, 1, 0], [0, 1, 1, 0], [0, 0, 0, 0] ]), \
		matrix([ [ 0, 1, 1, 0], [1, 0, 0, 1], [0, 1, 1, 0] ]), \
		matrix([  [0, 1, 1, 0], [1, 0, 0, 1], [0, 1, 0, 1], [0, 0, 1, 0], ]), \
		matrix([ [1, 1, 0], [1, 0, 1], [0, 1, 0] ]), \
		matrix([ [0, 1, 0], [1, 0, 1], [0, 1, 0] ]), \
		matrix([ [1, 1, 0], [1, 0, 1], [0, 1, 1] ]), \
		matrix([ [1, 1, 0, 0], [1, 0, 0, 1], [0, 0, 1, 1]]), \
		matrix([ [0, 1, 1, 0], [1, 0, 0, 1], [1, 0, 0, 1], [0, 1, 1, 0] ]), \
		matrix([ [0, 1, 1, 0, 0], [1, 0, 0, 1, 0], [0, 1, 0, 0, 1], [0, 0, 1, 1, 0] ]), \
		matrix([ [0, 0, 0, 1, 1], [0, 0, 1, 0, 1], [0, 0, 1, 0, 0], [1, 0, 1, 0, 0], [1, 1, 0, 0, 0] ]) \
	]

	return lis


def mDp6():

	lis = [ \
		matrix([ [1, 1, 0, 0, 0], [1, 0, 1, 0, 0], [0, 0, 0, 0, 0], [0, 0, 1, 0, 1], [0, 0, 0, 1, 1] ]), \
		matrix([ [0, 0, 0], [1, 1, 1], [0, 0, 0] ]), \
		matrix([ [0, 0, 0, 0], [0, 1, 1, 1], [1, 1, 1, 0], [0, 0, 0, 0] ]), \
		matrix([ [1, 1, 0, 0], [1, 1, 0, 0], [0, 0, 1, 1], [0, 0, 1, 1] ]), \
		matrix([ [0, 0, 1, 0], [1, 0, 1, 0], [0, 1, 0, 1], [0, 1, 0, 0] ]) \
	]

	return lis

def mDp7():

	lis = [ \
		matrix([ [1, 0, 0], [0, 1, 1], [1, 1, 0] ]), \
		matrix([ [0, 0, 0, 1, 0, 0], [0, 1, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 1], [1, 1, 1, 1, 1, 0] ]) \
	]

	return lis

def mDp8(m, k):

	def play(m):
		new = copy.copy(m)
		for r in range(m.nrows()):
			for c in range(m.ncols()):

				rcurr = r
				ccurr = c

				checked = 0
				count = 0
				for i in range(-1, 2):
					rcurr = (r + i) % m.nrows()				
					for j in range(-1, 2):
						ccurr = (c + j) % m.ncols()
						if m[rcurr, ccurr] == 1 and (rcurr, ccurr) != (r, c):
							count += 1
						if (rcurr, ccurr) != (r, c):
							checked += 1






				if count < 2:
					new[r, c] = 0
				elif count > 3:
					new[r, c] = 0
				elif count == 2 and m[r, c] == 1:
					new[r, c] = 1
				elif count == 3:
					new[r, c] = 1



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

				checked = 0
				count = 0
				for i in range(-1, 2):
					rcurr = (r + i) % m.nrows()				
					for j in range(-1, 2):
						#ccurr = (c + j) % m.ncols()
						if c + j < 0:
							ccurr = m.ncols() - 1 - c
						if m[rcurr, ccurr] == 1 and (rcurr, ccurr) != (r, c):
							count += 1
						if (rcurr, ccurr) != (r, c):
							checked += 1






				if count < 2:
					new[r, c] = 0
				elif count > 3:
					new[r, c] = 0
				elif count == 2 and m[r, c] == 1:
					new[r, c] = 1
				elif count == 3:
					new[r, c] = 1


		print "After:"
		print new
		print "Correct:"
		print matrix([[0,1,0,0,0],[0,0,0,1,0],[0,0,1,0,1],[1,1,0,0,0],[0,0,1,0,1]])
		return new

	for _ in range(k):
		m = play(m)

	return m

a =  matrix([[0,0,0,0,0],[0,0,0,0,0],[0,0,1,1,1],[0,0,1,0,1],[0,0,1,1,1]])
k = 1
mDp9(a, k)