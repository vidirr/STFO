
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

def gen_polygon(x_range, y_range):
	xmin, xmax = x_range
	ymin, ymax = y_range
	lis = [ [xmin, ymin], [xmin, ymax], [xmax, ymax],  [xmax, ymin] ]
	return polygon2d(lis, alpha=0.1)

def plotPic(Cs, Ls):

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


		if P is None:
			P = gen_polygon((xmin, xmin+xlen), (ymin, ymin+ylen))
		else:
			P += gen_polygon((xmin, xmin+xlen), (ymin, ymin+ylen))
	

	xmin = lowestx
	xmax = highestx
	ymin = lowesty
	ymax = highesty

	if (abs(lowestx) < highestx):
		xmin = -highestx
		xmax = highestx
	else:
		xmin = lowestx
		xmax = abs(highestx)


	if (abs(lowesty) < highesty):
		ymin = -highesty
		ymax = highesty
	else:
		ymin = lowesty
		ymax = abs(lowesty)

	P.show(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax)

def mAp6(Cs, Ls):

	squares = []
	connected = []
	for i in range(len(Cs)):

		#Generate all the squares.
		xmin, ymin = Cs[i]
		length = Ls[i]
		squares.append(Square(xmin, ymin, length))

	#plotPic(Cs, Ls)

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

