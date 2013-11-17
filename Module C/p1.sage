import Queue

class Node:

	def __init__(self, parent, r, c, weight):
		self.r = r
		self.c = c
		self.weight = weight
		self.leafs = []
		self.parent = parent

	def __repr__(self):
		return str((self.r, self.c)) + " - " + str(self.weight)

	def addLeaf(self, l):
		self.leafs.append(l)


	def getLeafs(self):
		return self.leafs

	def setParent(self, n):
		self.parent = n

	def getParent(self):
		return self.parent

	def hash(self):
		return (self.r, self.c)


def generateNeighbours(node, m):

	rmax = m.nrows() - 1
	cmax = m.ncols() - 1
	r, c = node.r, node.c
	neighbours = []

	#Cell below current cell.
	if r + 1 <= rmax:
		n = Node(node, r + 1, c, node.weight + m[r + 1, c])
		neighbours.append(n)
	#Cell to the right of current cell.
	if c + 1 <= cmax:
		n = Node(node, r, c + 1, node.weight + m[r, c + 1])
		neighbours.append(n)
	#Cell above of current cell
	if r - 1 >= 0:
		n = Node(node, r - 1, c, node.weight + m[r -1, c])
		neighbours.append(n)

	return neighbours


def getMatrix():

	alls = []
	for line in open("matrix.txt", "r"):
		alls.append(map(int, line.split(",")))

	return Matrix(alls)

def mCp1(m=None):


	if m is None:
		m = getMatrix()

	#Root of the tree - outside of the matrix.
	root = Node(None, -1, -1, 0)
	frontier = Queue.PriorityQueue()
	explored = {}
	pqHash = {}
	#add the first nodes to the tree.
	for i in range(m.nrows()):
		w = m[i, 0]
		n = Node(root, i, 0, w)
		root.addLeaf(n)

		frontier.put( (w, n) )
		pqHash[n.hash()] = n


	while True:

		if frontier.empty():
			return None

		weight, node = frontier.get()
		#Remove it from the set that we use to remember the nodes in the pq.
		del pqHash[node.hash()]
		#Goal is that we've reached the last column.
		if node.c == m.ncols() - 1:
			return weight
		explored[node.hash()] = True
		for n in generateNeighbours(node, m):
			if n.hash() not in explored:
				if n.hash() not in pqHash:
					frontier.put( (n.weight, n) )
					pqHash[n.hash()] = n
				elif pqHash[n.hash()].weight > n.weight:
					pqHash[n.hash()] = n
					frontier.put( (n.weight, n) )


