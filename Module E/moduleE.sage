

def mEp1(x, y):

	sum = 0
	for i in range(len(x)):
		sum += (x[i] - y[i])**2
	return sqrt(sum)

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


x = vector([1, 0, 1, 0])
y = vector([1, 1, 0, 1])
ans = mEp4(x, y)
print ans