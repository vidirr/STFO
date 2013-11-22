
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
	return polygon2d(lis, alpha=1)

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

	xmin = lowestx
	xmax = highestx
	ymin = lowesty
	ymax = highesty

	for i in range(len(Cs)):
		x, y = Cs[i]
		xlen = ylen = Ls[i]

		if P is None:
			P = gen_polygon((x, x+xlen), (y, y+ylen))
		else:
			P += gen_polygon((x, x+xlen), (y, y+ylen))
		
		P += line([(xmin, y), (xmax, y)], color='black') #Vertical
		P += line([(xmin, y+ylen), (xmax, y+ylen)], color='black') #Vertical
		P += line([(x, ymin), (x, ymax)], color='black')
		P += line([(x + xlen, ymin), (x + xlen, ymax)], color='black')
	
	P.show(xmin=xmin-3, xmax=xmax+3, ymin=ymin-3, ymax=ymax+3, axes=False)

def mAp7(Cs, Ls):

	squares = []
	connected = []
	for i in range(len(Cs)):

		#Generate all the squares.
		xmin, ymin = Cs[i]
		length = Ls[i]
		squares.append(Square(xmin, ymin, length))

	plotPic(Cs, Ls)

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

mAp7([(-2.0, 1.0), (-8.9, 2.7), (4.4, 2.6), (-5.5, -4.8), (-8.0, 1.2), (-8.3, 5.3), (8.4, -3.7), (4.9, 5.6), (3.3, 2.0), (-2.6, -3.0)], [5.9, 6.7, 7.2, 6.0, 5.2, 6.6, 6.8, 6.6, 6.6, 6.6])
