def m1p1(n):
    s = 0
    for i in range(0, n):
        if i % 3 == 0 or i % 5 == 0:
            s += i
    return s

m1p1(1000)
m1p1(20)