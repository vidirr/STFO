

RCSites = [(17, 3), (3, 15), (27, 19), (22, 21), (18, 25)]

def m4p1(L):
	xsum = 0
	ysum = 0

	for p in L:
		xsum += p[0]
		ysum += p[1]

	n = len(L)
	return (xsum/n, ysum/n)

def m4p2(p, q):

	return sqrt( (p[0] - q[0])**2 + (p[1] - q[1])**2 ).n()


def m4p3(p, q):
	#print "P: {0} - Q: {1}".format(p, q)
	#import time; time.sleep(10)
	return float( abs(p[0] - q[0]) + abs(p[1] - q[1])  )



def m4p4(sites, gridsize, B, f=1/2, g=1,d=m4p3):

	lis = []
	rows, cols = gridsize

	for r in range(rows):
		
		cur = []
		for c in range(cols):
			p = 0	
			for cs in sites:
				
				x = (r, c)
				theta = 1 if (d(x, cs) > B) else 0 #SO
				first = theta / (d(x, cs)**f) if (theta is 1) else 0 #GODDAMN
				second = ((1 - theta)*B**(g - f)) / (2*B - d(x, cs))**g if (theta is 0) else 0 #GORGEOUS!!!
				p += first + second
			cur.append(p)
		lis.append(cur)

	return lis


sites = [(0, 0), (2, 2)]
gridsize = (3, 3)
B = 1

ans = m4p4(sites, gridsize, B)

def m4p5(A):

	highest = -1
	for r in range(len(A)):
		for c in range(len(A[0])):
			if A[r][c] > highest:
				highest = A[r][c]

	points = []
	for r in range(len(A)):
		for c in range(len(A[0]))ö:
			if A[r][c] == highest:
				points.append((r, c))

	return set(points)



sites = RCSites
residence = (17, 19)
B = 10
A = m4p4(sites, (50,50), B)
pts1 = points(sites, size = 100, color = "red")

if residence != -1:
	pts2 = point(residence, size = 100, color = "black")
else:
	pts2 = Graphics()

pts3 = point(m4p1(sites), size = 100, color = "blue")
pts4 = points(m4p5(A), size = 100, color = "green")
plot1 = matrix_plot(matrix(A).transpose(), cmap = 'coolwarm', xmin = 0, xmax = 50, ymin = 0, ymax = 50)
show(pts1+pts2+pts3+pts4+plot1)