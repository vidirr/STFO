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

m1p4(2)