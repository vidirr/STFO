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


m1p5(10)