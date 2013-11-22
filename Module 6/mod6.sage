from math import pi, cos 
from random import random 

def m6p1(n):
    skipti=0
    count=0
    while count<n: 
       d=random()
       horn=random()*pi/2
       if d<=cos(horn):
          skipti+=1
       count+=1
    return skipti/n 


def m6p3(x,y, rad=2):
       
    if(x**2 + y**2 < rad**2) and x is not 0 and y is not 0:                                                                                                                
        return True
    else:    
        return False
