#Problem 1
def m1p1(n):
    s = 0
    for i in range(0, n):
        if i % 3 == 0 or i % 5 == 0:
            s += i
    return s

#Problem 2
def m1p2(n):
    s = 0
    fib = 1
    i = 0
    while fib < n:
        fib += fibonacci(i)
        i += 1
        if fib % 2 == 0 and fib < n:
            s += fib
    return s

#Problem 3
def m1p3(n):
    f = factor(n)
    return f[len(f)-1:][0][0]

#Problem 4
def m1p4(n):
    largest = 0
    for x in range(0, 10**n):
        for y in range(0, 10**n):
            cur = x * y
            s = str(cur)
            if s == s[::-1]:
                if cur > largest:
                    largest = cur
    return largest

#Problem 5
def m1p5(n):
    number = n
    while True:
        for d in range(1, n + 1):
            if number % d == 0:
                if d == n:
                    return number
            else:
                number += 1
                break

#Problem 6
def m1p6(n):
    sum = 0
    square = 0
    for i in range(0, n + 1):
        sum += i**2
        square += i
    diff = square**2 - sum
    return diff

#Problem 7
def m1p7(n):
    p = Primes()
    return p.unrank(n - 1)

#Problem 8
def m1p8(n, k):
    sum = 0
    pos = 0
    s = str(n)
    while pos + k < len(s):
        cur_pos = pos + 1
        cur_sum = int(s[pos])
        while cur_pos < pos + k:
            cur_sum *= int(s[cur_pos])
            cur_pos += 1
        if cur_sum > sum:
            sum = cur_sum
        pos += 1
    return sum

#Problem 9
def m1p9(n):
    arr = []
    for a in range(1, n):
        for b in range(a + 1, n):
            c = a**2 + b**2
            c = c**0.5
            if int(c) == c and a + b + c == n:
                arr.append(a*b*int(c))
    return arr

#Problem 10
def m1p10(n):
    return  sum(list(primes(0, n)))

#Problem 11
def m1p11(n, k):
    r = n.nrows()
    c = n.ncols()
    largest = 0
    for i in range(r):
        for j in range(c):
            #Row sum
            if i + k <= r:
                rsum = 1
                for a in range(i, i + k):
                    rsum *= n[a][j]
                if rsum > largest:
                    largest = rsum
            #Col sum
            if j + k <= c:
                csum = 1
                for a in range(j, j + k):
                    csum *= n[i][a]
                if csum > largest:
                    largest = csum
            #Diagonal sum - increasing cols
            if i + k <= r and j + k <= c:
                dsum = 1
                for s in range(k):
                    dsum *= n[i + s][j + s]
                if dsum > largest:
                    largest = dsum
            #Diagonal sum - decreasing cols
            if i + k <= r and j - k >= 0:
                dsum = 1
                for s in range(k):
                    dsum *= n[i + s][j - s]
                if dsum > largest:
                    largest = dsum

    return largest

#Problem 12
def m1p12(n):
    div_count = 0
    tri = 0
    count = 1
    while div_count <= n:
        div_count = 0
        tri += count
        count += 1
        for i in range(1, tri + 1):
            if tri % i == 0:
                div_count += 1
    return tri

#Problem 13
def m1p13(li, k):
    sum = 0
    for l in li:
        sum += l
    return int(str(sum)[0:k])

#Problem 14
def m1p14(n):
    longest_path = 0
    highest_number = 0
    mem = {}

    for i in range(1, n):
        #Check if we already know the path for i
        exists = mem.get(i, False)
        if exists:
            #If we know the path, check if higher.
            if exists[1] > longest_path:
                longest_path = exists[1]
                highest_number = i
                #If higher we just continue on to the next number, but set this one as the highest.
                continue
        #If it's unknown we just carry on as usual.
        else:
            curr_len = asgeir_krutt(i, mem)
            if curr_len > longest_path:
                longest_path = curr_len
                highest_number = i

    return highest_number


#Inserts the next number in the path into memory.
#If the next number doesn' t exists it recursively travels the path until it hits a known path,
#and then returns the length of the path to 1 from n.
def asgeir_krutt(n, mem):
    curr = n
    #Base case, inserting 1 into mem since all paths (supposedly) lead to 1.
    if n == 1:
        mem[1] = (1, 0)
        return 1
    if n % 2 == 0:
        curr = n / 2
    else:
        curr = (3 * curr + 1) / 2

    exists = mem.get(curr, False)
    #If the number doesn't exist we get the length of the path to 1 by recursively travelling down.
    if exists == False:
    #Current number is 1 step further away from 1 then the next number in the sequence.
        path_length =  asgeir_krutt(curr, mem) + 1
        mem[n] = (curr, path_length)
        return path_length + 1
    #If we hit a number we already know, then we also know how far away from 1 that number is.
    else:
        return exists[1] + 1

#Problem 15
def m1p15(n, m):
    c = Combinations(range(n+m, m))
    return c.cardinality()