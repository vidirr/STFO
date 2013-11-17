#Problem 14
matches = 0
def m1p14(n):
    global matches
    longest_path = 0
    highest_number = 0
    mem = {}


    for i in range(1, n):
        #Check if we already know the path for i
        exists = mem.get(i, False)
        if exists:
            matches += 1
            #If we know the path, check if higher.
            if exists[1] > longest_path:
                longest_path = exists[1]
                highest_number = i
                #If higher we just continue on to the next number, but set this one as the highest.
                continue
        #If it's unknown we just carry on as usual.
        else:
            curr_len = asgeir_krutt(i, mem)
            if curr_len > longest_path:
                longest_path = curr_len
                highest_number = i

    return highest_number


#Inserts the next number in the path into memory.
#If the next number doesn' t exists it recursively travels the path until it hits a known path,
#and then returns the length of the path to 1 from n.
def asgeir_krutt(n, mem):
    global matches
    curr = n
    #Base case, inserting 1 into mem since all paths (supposedly) lead to 1.
    if n == 1:
        mem[1] = (1, 0)
        return 1
    if n % 2 == 0:
        curr = n / 2
    else:
        curr = (3 * curr + 1) / 2

    exists = mem.get(curr, False)
    #If the number doesn't exist we get the length of the path to 1 by recursively travelling down.
    if exists == False:
    #Current number is 1 step further away from 1 then the next number in the sequence.
        path_length =  asgeir_krutt(curr, mem) + 1
        mem[n] = (curr, path_length)
        return path_length + 1
    #If we hit a number we already know, then we also know how far away from 1 that number is.
    else:
        matches += 1
        return exists[1] + 1

import time
t = time.time()
m1p14(1000000)
print time.time() - t, " seconds."
print matches, " matches."