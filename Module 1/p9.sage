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

m1p9(1000)