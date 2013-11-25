

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

def lev(x, lenx, y, leny):
	if lenx == 0: 
		return leny
	if leny == 0: 
		return lenx

	if x[lenx - 1] == y[leny - 1]: 
		cost = 0
	else: 
		cost = 1

	return min( lev(x, lenx - 1, y, leny) + 1,\
		        lev(x, lenx, y, leny - 1) + 1,\
		        lev(x, lenx - 1 , y, leny - 1) + cost  \
		      )

def mEp4(x, y):

	return lev(x, len(x), y, len(y))


def mEp6(L, dist):

	#If we only have two points, we should also just have a single class.
	if len(L) == 2:
		return L[0][1] == L[1][1]

	#Store sorted points.
	classes = {}
	#Map class distances.
	distances = {}
	#Stray points
	strays = []
	#We sort the points into their classes, so that we can verify each class.
	for p in L:
		if p[1] not in  classes:
			classes[p[1]] = []
		classes[p[1]].append(p)

	#Check the expected distances value for each classification.
	for c in classes:
		points = classes[c]
		#If we only have one pair in this class, we can assume the distance value for that class is that distance.
		if len(points) == 2:
			distances[c] = dist(points[0][0], points[1][0])
		#If we have a stray point (point mapped to a single class) we have to check it later.
		elif len(points) == 1:
			strays.append(points[0])
		#If we have more than one pair - we have to check all distances between all points in the same class, since they should all have the same distance.
		else:
			for p1 in points:
				for p2 in points:
					if p1 is not p2:
						#If we know the distance value already, the distance between the current points should be that value.
						if c in distances:
							if dist(p1[0], p1[0]) != distances[c]:
								#If it isn't, we found a wrongly classified point.
								return False

	print distances
	for s in strays:
		for p in L:
			if s is p:
				continue
			d = dist(s[0], p[0])
			print "Checking ", d
			for known in distances:
				#We now check the distance of the stray point against the known distances.
				#If we find a distance we already know - we have a point that's wrongly classified.
				if d == distances[known]:
					return False
	for p1 in L:
		for p2 in L:
			if p1 is not p2 and p1[1] == p2[1]:
				#print "Comparing", L.index(p1), "with", L.index(p2)
				correct = True if (dist(p1[0], p2[0]) == distances[p1[1]]) else False
				#print dist(p1[0], p2[0]), p1[1], p2[1], correct
				if correct is False:
					return False
	return correct

ans = mEp6([((18.684,-35.59,-12.72,-4.557,38.798,15.954,19.615,-37.402,-18.726,-16.158,25.33,-28.064,-12.945,-16.612,-21.755,48.783), 0),((42.666,-24.739,-5.678,-40.24,10.303,29.46,-39.902,46.325,-19.947,22.607,-23.709,26.949,47.592,42.573,-31.44,-42.857), 0),((-47.516,37.541,48.493,-3.954,17.07,6.259,30.533,16.987,43.545,48.857,5.077,-15.084,8.505,-44.164,5.31,12.261), 2),((-1.782,-24.349,-17.76,-38.726,-25.525,-12.317,45.205,-12.874,-18.503,-21.852,-10.058,35.404,1.016,24.348,10.468,-8.082), 2),((-4.946,-8.562,-18.817,-26.257,-4.467,2.818,-24.955,-8.069,-5.221,32.152,49.667,-9.631,-1.915,9.52,49.799,46.255), 4)], mEp2)
print ans