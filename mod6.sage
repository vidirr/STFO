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


def m6p3(x,y):
    radius = 2         
    if(x^2+y^2>2*radius^2) or (x==0)and(y==0):                                                                                                                
        return false
    else:    
        return true
