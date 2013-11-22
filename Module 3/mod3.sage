#Problem1
def m3p1(n):
    if n <= 1:
        return 0
    if n == 2:
        return 1
    if n > 2:
        return m3p1(n-1) + m3p1(n-2) + m3p1(n-3)
                
#Problem2
memo = {0:0, 1:0, 2:1}
def m3p2(n):
    if n in memo:
        return memo[n]
    else:
        new = m3p2(n-1) + m3p2(n-2) + m3p2(n-3)
        memo[n] = new
        return new

#Problem3
def m3p3(n):
    T = [0,0,1] + [0]*(n-2) 
    for i in range(3,n+1):
        T[i] = T[i-1] + T[i-2]+ T[i-3]
    return T[n]

#Problem4
def m3p4(n):
    if n <=1 :
        return 0
    t3, t2, t1 = 1,0,0
    for i in range(3,n+1):
        t3,t2,t1=t3+t2+t1,t3,t2 
    return t3


#Problem5
def m3p5(n, L):
    leidir = [1] + [0 for i in xrange(n)] 
                                    
    for pen in L:                          
        for i in xrange(pen, n+1): 
            leidir[i] = leidir[i] + leidir[i-pen]            
    return leidir[n]
       
#Problem6
def m3p6(k):
    tolur = range(1,1000)
    leidir = [1]+[0 for i in xrange(k)]
    
    for n in tolur:
        for i in xrange(n, k+1):
            leidir[i] = leidir[i] + leidir[i-n]
    return leidir[k]-1


#Problem7
def m3p7(k):
    prims = list(primes(1, 1000))
    count = 0
    while True:
      leidir = [1]+[0 for i in xrange(count)]
      for n in prims:
        for i in range(n, count+1):
          leidir[i] = leidir[i] + leidir[i-n]       
      if leidir[count] > k: break
      count = count+1
    if k in prims:
        return count+1
    else:
        return count



