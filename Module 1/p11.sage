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