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

m1p2(95)