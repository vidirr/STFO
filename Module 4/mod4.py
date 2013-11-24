# This file was *autogenerated* from the file mod4.sage.
from sage.all_cmdline import *   # import sage library
_sage_const_3 = Integer(3); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_18 = Integer(18); _sage_const_0 = Integer(0); _sage_const_17 = Integer(17); _sage_const_15 = Integer(15); _sage_const_22 = Integer(22); _sage_const_19 = Integer(19); _sage_const_21 = Integer(21); _sage_const_27 = Integer(27); _sage_const_25 = Integer(25)

RCSites = [(_sage_const_17 , _sage_const_3 ), (_sage_const_3 , _sage_const_15 ), (_sage_const_27 , _sage_const_19 ), (_sage_const_22 , _sage_const_21 ), (_sage_const_18 , _sage_const_25 )]

def m4p1(L):
	xsum = _sage_const_0 
	ysum = _sage_const_0 

	for p in L:
		xsum += p[_sage_const_0 ]
		ysum += p[_sage_const_1 ]

	n = len(L)
	return (xsum/n, ysum/n)

def m4p2(p, q):

	return sqrt( (p[_sage_const_0 ] - q[_sage_const_0 ])**_sage_const_2  + (p[_sage_const_1 ] - q[_sage_const_1 ])**_sage_const_2  ).n()


def m4p3(p, q):
	#print "P: {0} - Q: {1}".format(p, q)
	#import time; time.sleep(10)
	return float( abs(p[_sage_const_0 ] - q[_sage_const_0 ]) + abs(p[_sage_const_1 ] - q[_sage_const_1 ])  )



def m4p4(sites, gridsize, B, f=_sage_const_1 /_sage_const_2 , g=_sage_const_1 ,d=m4p3):

	lis = []
	rows, cols = gridsize

	for r in range(rows):
		
		cur = []
		for c in range(cols):
			p = _sage_const_0 	
			for cs in sites:
				
				x = (r, c)
				theta = _sage_const_1  if (d(x, cs) > B) else _sage_const_0  #SO
				first = theta / (d(x, cs)**f) if (theta is _sage_const_1 ) else _sage_const_0  #GODDAMN
				second = ((_sage_const_1  - theta)*B**(g - f)) / (_sage_const_2 *B - d(x, cs))**g if (theta is _sage_const_0 ) else _sage_const_0  #GORGEOUS!!!
				p += first + second
			cur.append(p)
		lis.append(cur)

	return lis


sites = [(_sage_const_0 , _sage_const_0 ), (_sage_const_2 , _sage_const_2 )]
gridsize = (_sage_const_3 , _sage_const_3 )
B = _sage_const_1 

ans = m4p4(sites, gridsize, B)

def m4p5(A):

	highest = -_sage_const_1 
	for r in range(len(A)):
		for c in range(len(A[_sage_const_0 ])):
			if A[r][c] > highest:
				highest = A[r][c]

	points = []
	for r in range(len(A)):
		for c in range(len(A[_sage_const_0 ])):
			if A[r][c] == highest:
				points.append((r, c))

	return set(points)

ans = m4p5(ans)
print ans
