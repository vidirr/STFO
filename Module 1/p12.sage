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

m1p12(5)