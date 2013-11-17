def m1p3(n):
    f = factor(n)
    return f[len(f)-1:][0][0]

m1p3(13195)