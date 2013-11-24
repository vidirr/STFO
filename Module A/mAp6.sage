1#Helper functions
class Square:

	def __init__(self, xmin, ymin, length):

		self.xmin = xmin
		self.xmax = xmin + length
		self.ymin = ymin
		self.ymax = ymin + length

	def __repr__(self):
		return "[{0}, {1}], [{2}, {3}]".format(self.xmin, self.ymin, self.xmax, self.ymax)

	def checkIntersection(self, other):
		if(self.xmax < other.xmin): return False #Other is to the right of self 
		if(self.xmin > other.xmax): return False #Other is to the left of self
		if(self.ymax < other.ymin): return False #Other is above self
		if(self.ymin > other.ymax): return False #Other is below self
		return True

def gen_polygon(x_range, y_range, alpha):
	xmin, xmax = x_range
	ymin, ymax = y_range
	lis = [ [xmin, ymin], [xmin, ymax], [xmax, ymax],  [xmax, ymin] ]
	return polygon2d(lis, alpha=alpha)

def plotPic(Cs, Ls, alpha=1, lines=False, axes=False):

	P = None
	lowestx = 1000 
	lowesty = 1000
	highestx = -1000
	highesty = -1000

	for i in range(len(Cs)):
		xmin, ymin = Cs[i]
		xlen = ylen = Ls[i]

		if xmin < lowestx:
			lowestx = xmin

		if ymin < lowesty:
			lowesty = ymin

		if xmin + xlen > highestx:
			highestx = xmin + xlen

		if ymin + ylen > highesty:
			highesty = ymin + ylen

	xmin = lowestx
	xmax = highestx
	ymin = lowesty
	ymax = highesty

	for i in range(len(Cs)):
		x, y = Cs[i]
		xlen = ylen = Ls[i]

		if P is None:
			P = gen_polygon((x, x+xlen), (y, y+ylen), alpha)
		else:
			P += gen_polygon((x, x+xlen), (y, y+ylen), alpha)
		if lines:
        		P += line([(xmin, y), (xmax, y)], color='black') #Vertical
        		P += line([(xmin, y+ylen), (xmax, y+ylen)], color='black') #Vertical
        		P += line([(x, ymin), (x, ymax)], color='black')
        		P += line([(x + xlen, ymin), (x + xlen, ymax)], color='black')
	
	P.show(xmin=xmin-3, xmax=xmax+3, ymin=ymin-3, ymax=ymax+3, axes=axes)

def mAp6(Cs, Ls):

	squares = []
	connected = []
	for i in range(len(Cs)):

		#Generate all the squares.
		xmin, ymin = Cs[i]
		length = Ls[i]
		squares.append(Square(xmin, ymin, length))

	plotPic(Cs, Ls, alpha=0.3, lines=False, axes=True)

	broken = False
	#Select the first square from squares and start looking for neighbours.
	connected.append(squares[0])
	squares.remove(squares[0])

	while len(squares) > 0:
		found = False
		for s1 in connected:
			for s2 in squares:
				if s1.checkIntersection(s2):
					found = True
					connected.append(s2)
					squares.remove(s2)

		if found is False:
			return False

	return True
