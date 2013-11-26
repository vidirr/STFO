import knn
import random
 
def column(A, j):
   return [row[j] for row in A]
 
def test(data, k):
   random.shuffle(data)
   pts, labels = column(data, 0), column(data, 1)
 
   trainingData = pts[:800]
   trainingLabels = labels[:800]
   testData = pts[800:]
   testLabels = labels[800:]
 
   f = knn.makeKNNClassifier(trainingData, trainingLabels,
                             k, knn.euclideanDistance)
   correct = 0
   total = len(testLabels)
 
   for (point, label) in zip(testData, testLabels):
      if f(point) == label:
         correct += 1
 
   return float(correct) / total


if __name__ == "__main__":

   data = []
   import time
   for line in open("digits.dat", "r"):
      data.append(line)

   foo = test(data, 7)
   print foo