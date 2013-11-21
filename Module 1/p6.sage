def m1p6(n):
    sum = 0
    square = 0
    for i in range(0, n + 1):
        sum += i**2
        square += i
    diff = square**2 - sum
    return diff

m1p6(10)