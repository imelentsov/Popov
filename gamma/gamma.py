#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Gamma generator.
Usage:
    -k, --key - specify key for gamma generation in hex
    -f, --file - specify file for gamma generation
    -s, --blockSize - specify blockSize should be power of 2
    -i, --iterations - specify number of iterations in madryga algorithm
    -h, --help - display this information
    -d, --max_deviation - specify maximal deviation rate from half of bits
"""

'''
Created on 2014-12-14 15:03
@summary: 
@author: i.melentsov
'''
import getopt, sys
from madryga import encrypt
from file_encryptor import process_file

def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "k:f:i:s:hd:", ["help", "key=", "file=", "iterations=", "blockSize=", "max_deviation="])
    except getopt.GetoptError as err:
        # print help information and exit:
        print (str(err))
        print(__doc__)
        sys.exit(2)
    key = None
    encFile = None
    iterationNum = 8
    blockSize = 128
    mayContinue = True
    max_deviation = 0.1
    for o, a in opts:
        if o in ("-h", "--help"):
            print(__doc__)
            sys.exit()
        elif o == "-e":
            pass
        elif o in ("-k", "--key"):
            key = int(a, base=16)
        elif o in ("-f", "--file"):
            encFile = a
        elif o in ("-i", "--iterations"):
            iterationNum = int(a)
            if iterationNum <= 0:
                print ("Number of iterations should be greater than 0")
                mayContinue = False
        elif o in ("-s", "--blockSize"):
            blockSize = int(a)
            prom = blockSize
            count = 0 
            while prom > 0:
                count += prom & 1
                prom >>= 1
            if count != 1:
                print ("BlockSize should be power of 2.")
                mayContinue = False
        elif o in ("-d", "--max_deviation"):
            max_deviation = float(a)
            if max_deviation < 0 or max_deviation > 1:
                print("Max deviation should be grater then 0 and less then 1")
                mayContinue = False
        else:
            assert False, "Unhandled option"
    if key is None:
        print ("Key not specified.")
        mayContinue = False
    if encFile is None:
        print ("File not specified.")
        mayContinue= False
    if not mayContinue:
        print ("Exit.")
        sys.exit(2)
    process_file(encFile, encrypt, blockSize, iterationNum, key, max_deviation)

if __name__ == '__main__':
    main()