# This file was *autogenerated* from the file module5.sage.
from sage.all_cmdline import *   # import sage library
_sage_const_1p000000 = RealNumber('1.000000'); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_0p477607 = RealNumber('0.477607'); _sage_const_1p617192 = RealNumber('1.617192'); _sage_const_10000 = Integer(10000); _sage_const_0p105119 = RealNumber('0.105119'); _sage_const_1p773545 = RealNumber('1.773545'); _sage_const_16p290923 = RealNumber('16.290923')#Problem 4

def m5p4(xmin, xmax, ymin, ymax): 
    return lambda x, y: xmin <= x <= xmax and ymin <= y <= ymax

#Problem 5

def m5p5(x0, y0, r):
    return lambda x, y: (x0 - r) <= x <= (x0 + r) and (y0 -r) <= y <= (y0 + r)

#Problem 6

def m5p6(x0, y0, r):
    return lambda x, y: sqrt( (x0 - x)**_sage_const_2  + (y0 - y)**_sage_const_2  ) <= r

#Problem 7.

def hits(P, n=_sage_const_10000 , xmin=-_sage_const_1 , xmax=_sage_const_1 , ymin=-_sage_const_1 , ymax=_sage_const_1 ):
    
    #out = []
    #all = []
    count = _sage_const_0 
    for i in xrange(n):
        x = random() * (xmax - xmin) + xmin
        y = random() * (ymax - ymin) + ymin

        if P(x, y):
            count += _sage_const_1 

    return count


def m5p7(P, n=_sage_const_10000 , xmin=-_sage_const_1 , xmax=_sage_const_1 , ymin=-_sage_const_1 , ymax=_sage_const_1 ):
    count = hits(P, n, xmin, xmax, ymin, ymax)
    area = abs(xmin - xmax) * abs(ymin - ymax)
    ratio = float(count)/float(n)
    return float(ratio * area)

#Problem 8

def hits_z(f, n=_sage_const_10000 , xmin=-_sage_const_1 , xmax=_sage_const_1 , ymin=-_sage_const_1 , ymax=_sage_const_1 , zmin=-_sage_const_1 , zmax=_sage_const_1 ):
    
    count = _sage_const_0 

    for i in xrange(n):
        x = random() * (xmax - xmin) + xmin
        y = random() * (ymax - ymin) + ymin
        z = random() * (zmax - zmin) + zmin
        
        if xmin <= x <= xmax and ymin <= y <= ymax and _sage_const_0  <= z <= f(x, y):
            count += _sage_const_1   
    return count


def m5p8(f, n=_sage_const_10000 , xmin=-_sage_const_1 , xmax=_sage_const_1 , ymin=-_sage_const_1 , ymax=_sage_const_1 , zmin=-_sage_const_1 , zmax=_sage_const_1 ):
    count = hits_z(f)
    area = abs(xmin - xmax) * abs(ymin - ymax) * abs(zmin - zmax)
    print "Area: ", area, "Number of points:", len(d), "Total:", n
    ratio = float(count)/float(n)
    return float(ratio * area)


m5p8(x**_sage_const_2  + y**_sage_const_2 , _sage_const_10000 , -_sage_const_0p105119 , _sage_const_0p477607 , -_sage_const_1p773545 , -_sage_const_1p617192 , -_sage_const_1p000000 , _sage_const_16p290923 )
