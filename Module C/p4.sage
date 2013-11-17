import sage.misc.prandom as r


def checkPrime(pos, n):
	return pos in primes(n)


def getCroak(pos, n):

	n = r.randint(1, 3)
	isPrime = checkPrime(pos, n)

	#print pos, isPrime
	if isPrime:
		#2/3 that it croaks prime on a prime number.
		if n < 3:
			return 1
		else:
			return 0

	else:
		#1/3 that it croaks prime if not on a prime number.
		if n < 2:
			return 1
		else:
			return 0

def getJump(pos, n):

	#Right
	if pos == 0:
		return 2

	#Left
	if pos == n - 1:
		return 1

	#Else random
	return r.randint(1, 2)


def play(n, turns):

	pos = r.randint(0, n)
	current_turn = []

	for i in range(turns):
		croak = getCroak(pos, n)
		current_turn.append(croak)
		direction = getJump(pos, n)

		if direction == 1:
			pos -= 1
		else:
			pos += 1

	return current_turn



def mCp4(n, L, turns=10000):


	count = 0

	for i in range(turns):
		curr = play(n, len(L))
		if L == curr:
			count += 1

	return count/turns