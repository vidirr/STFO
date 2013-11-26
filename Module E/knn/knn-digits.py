import knn
import random
import time
import sys

def column(A, j):
   return [row[j] for row in A]

def digitsData():
   ''' Read in the handwritten digits data from the file 'digits.dat', and
       return the data points and their labels as two lists. '''
   with open('digits.dat') as inFile:
      lines = inFile.readlines()

   data = [line.strip().split(',') for line in lines]
   data = [([int(x) for x in point.split()], int(label)) for (point, label) in data]

   return data

def test(data, k):
   random.seed(2003892049)
   random.shuffle(data)
   pts, labels = column(data, 0), column(data, 1)

   trainingData = pts[:800]
   trainingLabels = labels[:800]
   testData = pts[800:]
   testLabels = labels[800:]

   f = knn.makeKNNClassifier(trainingData, trainingLabels, k, knn.mEp4)
   correct = 0.0
   total = len(testLabels)
   t1 = time.time()
   for (point, label) in zip(testData, testLabels):
      if f(point) == label:
         correct += 1
      print "Total time: {0} s\r".format(round(time.time() - t1, 2)),
      sys.stdout.flush()
   return correct/total


if __name__ == "__main__":
   data = digitsData()
   print "k\tcorrect"
   out = open("results_mep4.txt", "w")

   out.write("[ ")
   for k in range(16,50):
      successRate = test(data, k)
      print "%d\t%.3f" % (k, successRate)
      out.write(", ({0}, {1})".format(k, successRate))
   out.write(" ]")
   out.close()
