def m2p1(perm):

	c = 0
	for i in range(len(perm) - 1):
		for j in range(i, len(perm) - 1):
			if perm[i] < perm[j]:
				c += 1
	return c

def m2p2(perm):

	c = 0
	for i in range(1, len(perm) - 1):
		if perm[i - 1] < perm[i] and perm[i] > perm[i + 1]:
			c += 1
	return c

def m2p3(n):

	return fibonacci(n + 1)

def m2p4(perm, patt):
	from sage.combinat.permutation import to_standard

	for i in range(0, len(perm) - len(patt)):
		check = to_standard(perm[i: i + len(patt)])
		if check == patt:
			return True
	return False
	
def m2p4_2(perm, patt):
	#Pattern can't be longer then permutation.
	if len(patt) > len(perm):
		return False
	#equal lengths should contain the same numbers - which all equal length perms do?
	if len(patt) == len(perm):
		return sorted(patt) == sorted(perm)
	else:
		return patt.number_of_descents() <= perm.number_of_descents() and patt.inversions() <= perm.inversions()
		
def m2p4_3(p,cl):
	combs = list(Combinations(p))
	for i in range(0, len(combs)):
		check = to_standard(combs[i])
		if check == cl:
			return True
	return False

#Bubble sort with 1 iteration.
def B(lis):
	lis = list(lis)
	for i in range(len(lis) - 1):
		if lis[i] > lis[i + 1]:
			lis[i], lis[i + 1] = lis[i + 1], lis[i]
	return Permutation(lis)

def m1p5(perm):

	return B(perm[:])
	
# EÐA
def bubble(p):
	if p == []:
		return []

	n = max(p)
	i = p.index(n)

	return bubble(p[0:i]) + p[i+1:] + [n]

 def m2p6():
	return Permutation([1,3,2]), Permutation([2,1,3])

def m2p6():

	return Permutation([1,3,2]), Permutation([2,1,3])

def m1p7(perm):
	import bisect
	perm = perm[:]
	s = sorted(perm)
	for i in range(len(perm)):
		perm[i] = bisect.bisect_left(s,perm[i]) +1
	
	return Permutation(perm)
