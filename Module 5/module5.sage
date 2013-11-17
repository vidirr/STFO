#Problem 1

def m5p1(g):
    G = g
    P = MixedIntegerLinearProgram()

    V = P.new_variable(binary=True)
    P.set_objective( sum([V[ve] for ve in G.vertices()]))
    
    for v1 in G.vertices():
        for v2 in G.vertices():
            if v1 not in G.neighbors(v2) and v1 != v2:
                P.add_constraint(V[v1] + V[v2] <= 1)

    return P.solve()

#Problem 2

def m5p2(g):
    G = g
    P = MixedIntegerLinearProgram()

    V = P.new_variable(binary=True)
    P.set_objective( sum([V[ve] for ve in G.vertices()]))
    
    for v1 in G.vertices():
        for v2 in G.vertices():
            if v1 in G.neighbors(v2) and v1 != v2:
                P.add_constraint(V[v1] + V[v2] <= 1)

    return P.solve()      

#Problem 4

def m5p4(xmin, xmax, ymin, ymax): 
    return lambda x, y: xmin <= x <= xmax and ymin <= y <= ymax

#Problem 5

def m5p5(x0, y0, r):
    return lambda x, y: (x0 - r) <= x <= (x0 + r) and (y0 -r) <= y <= (y0 + r)

#Problem 6

def m5p6(x0, y0, r):
    return lambda x, y: sqrt( (x0 - x)**2 + (y0 - y)**2 ) <= r

#Problem 7.

def hits(P, n=10000, xmin=-1, xmax=1, ymin=-1, ymax=1):
    
    count = 0
    
    for i in xrange(n):
        x = random() * (xmax - xmin) + xmin
        y = random() * (ymax - ymin) + ymin

        if P(x, y):
            count += 1

    return count


def m5p7(P, n=10000, xmin=-1, xmax=1, ymin=-1, ymax=1):
    count = hits(P, n, xmin, xmax, ymin, ymax)
    area = abs(xmin - xmax) * abs(ymin - ymax)
    ratio = float(count)/float(n)
    return float(ratio * area)

#Problem 8

def hits_z(f, n=10000, xmin=-1, xmax=1, ymin=-1, ymax=1, zmin=-1, zmax=1):
    
    count = 0

    for i in xrange(n):
        x = random() * (xmax - xmin) + xmin
        y = random() * (ymax - ymin) + ymin
        z = random() * (zmax - zmin) + zmin

        if xmin <= x <= xmax and ymin <= y <= ymax and 0 <= z <= f(x, y):
            count += 1 

             
    return count

x, y = var('x', 'y')
def m5p8(f, n=10000, xmin=-1, xmax=1, ymin=-1, ymax=1, zmin=-1, zmax=1):
    count = hits_z(f, n, xmin, xmax, ymin, ymax, zmin, zmax)
    area = abs(xmin - xmax) * abs(ymin - ymax) * abs(zmin - zmax)
    #print "Area: ", area, "Number of points:", count, "Total:", n
    ratio = float(count)/float(n)
    return float(ratio * area)