

def mEp1(x, y):

	sum = 0
	for i in range(len(x)):
		sum += (x[i] - y[i])**2
	return sqrt(sum).n()

def mEp2(x, y):

	sum = 0
	for i in range(len(x)):
		sum += abs(x[i] - y[i])
	return sum


def mEp3(x, y):

	sum = 0
	for i in range(len(x)):
		if x[i] != y[i]:
			sum += 1
	return sum


def mEp4(x, y):

	#This is basically just a direct implementation
	#of the "Iterative with full matrix" implementation
	#on Wikipedia. 

	if x == y:
		return 0

	m = len(x)
	n = len(y)
	mat = matrix(m + 1, n + 1)

	for i in range(m):
		mat[i, 0] = i

	for j in range(n):
		mat[0, j] = j


	for j in range(1, n + 1):
		for i in range(1, m + 1):
			
			if x[i-1] == y[j-1]:
				mat[i, j] = mat[i-1, j-1]

			else:
				mat[i, j] = min(mat[i-1, j]+1, mat[i, j-1]+1, mat[i-1, j-1] +1)

	ans = mat[m, n]
	return ans


def mEp5(x, y):
	xm = []
	ym = []
	xcur = []
	ycur = []

	for i in range(len(x)):
		xcur.append(x[i])
		ycur.append(y[i])
		if (i + 1) % sqrt(len(x)) == 0:
			xm.append(xcur)
			ym.append(ycur)
			xcur = []
			ycur = []

	xm = matrix(xm)
	ym = matrix(ym)

	return (xm - ym).rank()



def mEp6(L, dist):

	for p1 in L:
		closest = None
		for p2 in L:
			if p1 is not p2:
				
				if closest is None:
					#assume first point is the closest.
					closest = (p2[0], p2[1], dist(p1[0], p2[0]) )
				else:
					if dist(p1[0], p2[0]) < closest[2]:
						closest = ( p2[0], p2[1], dist(p1[0], p2[0]) )	
		if p1[1] != closest[1]:
			return False
	return True


def mEp7(L, J, dist):

	#Store the points after we label them.
	labeled = []
	#For each unlabeled point.
	for q in J:
		#No closest point is known
		closest = None
		#So - for each point that has been labeled
		for p in L:
			#Find the distance
			d = dist(q, p[0])
			#If this is the first point we check, we asume he's the closest one.
			if closest is None:
				closest = (p[0], p[1], d)
			#But if we know a point, we have to check if this point is actually closer.
			else:
				#So - if the distance between this point and the currently assumed closest point is the same
				if d == closest[2]:
					#We select the point that has the lower class (closest might have class 4, but p has class 2 - so we select 2)
					closest = closest if (closest[1] < p[1]) else (p[0], p[1], d)
				#If we find a point that is actually closer then the point we last said was closest we just replace it
				elif d < closest[2]:
					closest = (p[0], p[1], d)
		#After checking all the points in L we have found the closest point, so we add the previously unclassified point q to our list
		#and add his class as well - and then carry on to the next point in q.
		labeled.append((q, closest[1]))

	#all done.
	return labeled


class Node:
	
	def __init__(self, location, c=None):
		self._location = location
		self._luClass = c
		self._neighbours = []

	def __repr__(self):
		return "Node: ({0}), {1}\n".format(self._location, self._luClass)

	def location(self):
		return self._location

	def luClass(self):
		return self._luClass

	def addNeighbour(self, node, dist):
		d = dist(self.location(), node.location())
		self._neighbours.append((node, d))

	def classify(self, k):
		neighbours = sorted(self._neighbours, key=lambda x: x[1])
		neighbours = neighbours[:k]

		frequency = {}
		for n in neighbours:
			n = n[0]
			#import time; time.sleep(10)
			if n.luClass() in frequency:
				frequency[n.luClass()] += 1
			else:
				frequency[n.luClass()] = 1

		most_frequent = None
		freq = 0
		for f in frequency:
			if most_frequent is None:
				most_frequent = f
				freq = frequency[f]
			else:
				if frequency[f] == freq:
					if f < most_frequent:
						most_frequent = f
						freq = most_frequent[f]
				elif frequency[f] > freq:
					most_frequent = f
					freq = frequency[f]

		self._luClass = most_frequent



def mEp8(L, J, dist, k):

	sortedNodes = []
	unsortedNodes = []

	for p in L:
		node = Node(location=p[0], c=p[1])
		sortedNodes.append(node)

	for q in J:
		node = Node(location=q)
		unsortedNodes.append(node)

	after_classification = []

	for unsortedNode in unsortedNodes:
		for sortedNode in sortedNodes:
			unsortedNode.addNeighbour(sortedNode, dist)
		unsortedNode.classify(k)
		after_classification.append( (unsortedNode.location(), unsortedNode.luClass()) )

	return after_classification


