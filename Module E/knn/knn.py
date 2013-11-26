import math
import heapq
import random
from sage.all import *


def gaussCluster(center, stdDev, count=50):
    return [(random.gauss(center[0], stdDev),
             random.gauss(center[1], stdDev)) for _ in range(count)]

def makeDummyData():
    return gaussCluster((-4,0), 1) + gaussCluster((4,0), 1)

def euclideanDistance(x,y):
    return math.sqrt(sum([(a-b)**2 for (a,b) in zip(x,y)]))

def mEp1(x, y):

  s = 0
  for i in range(len(x)):
    s += (x[i] - y[i])**2
  return math.sqrt(s)

def mEp2(x, y):

  s = 0
  for i in range(len(x)):
    s += abs(x[i] - y[i])
  return s


def mEp3(x, y):

  s = 0
  for i in range(len(x)):
    if x[i] != y[i]:
      s += 1
  return s

def mEp4(x, y):

  #This is basically just a direct implementation
  #of the "Iterative with full matrix" implementation
  #on Wikipedia. 

  if x == y:
    return 0

  m = len(x)
  n = len(y)
  mat = matrix(m + 1, n + 1)

  for i in range(m):
    mat[i, 0] = i

  for j in range(n):
    mat[0, j] = j


  for j in range(1, n + 1):
    for i in range(1, m + 1):
      
      if x[i-1] == y[j-1]:
        mat[i, j] = mat[i-1, j-1]

      else:
        a = mat[i-1, j] + 1
        b = mat[i, j-1] + 1
        c = mat[i-1, j-1] + 1
        mat[i,j] = min(a, b, c)

  ans = mat[m, n]
  return ans


def mEp5(x, y):
  xm = []
  ym = []
  xcur = []
  ycur = []

  for i in range(len(x)):
    xcur.append(x[i])
    ycur.append(y[i])
    if (i + 1) % sqrt(len(x)).n() == 0:
      xm.append(xcur)
      ym.append(ycur)
      xcur = []
      ycur = []

  xm = matrix(xm)
  ym = matrix(ym)

  return (xm - ym).rank()


def makeKNNClassifier(data, labels, k, distance):
    def classify(x):
        closestPoints = heapq.nsmallest(k, enumerate(data), key=lambda y: distance(x, y[1]))
        closestLabels = [labels[i] for (i, pt) in closestPoints]
        return max(set(closestLabels), key=closestLabels.count)

    return classify

if __name__ == "__main__":
   import sys

   k = int(sys.argv[1]) if len(sys.argv) == 2 else 8

   trainingPoints = makeDummyData() # has 50 points from each class
   trainingLabels = [1] * 50 + [2] * 50  # an arbitrary choice of labeling

   f = makeKNNClassifier(trainingPoints, trainingLabels, k, euclideanDistance)
   print f((-3,0))
   print f((3,0))
   print f((0,0))
