#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Madryga algorithm.
Usage:
    -k, --key - specify key for encryption/decription in hex
    -f, --file - specify file for encryption/decription
    -e, -d - specify what exactly to do (e - means encrypt, d - decrypt). 
      If no parameter specified then encryption applied. 
    -w - if specified then weak encryption/decription will be applyed (only mixing)
        in weak mode key is not necessary
    -s, --blockSize - specify blockSize should be power of 2
    -i, --iterations - specify number of iterations in madryga algorithm
    -h, --help - display this information
"""

'''
Created on 2014-12-14 15:03
@summary: 
@author: i.melentsov
'''
import getopt, sys
from madryga import encrypt, decrypt
from file_encryptor import process_file

def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "k:f:i:s:dewh", ["help", "key=", "file=", "iterations=", "blockSize="])
    except getopt.GetoptError as err:
        # print help information and exit:
        print (str(err))
        print(__doc__)
        sys.exit(2)
    needToEncrypt = True
    key = None
    encFile = None
    weak = False
    iterationNum = 8
    blockSize = 128
    mayContinue = True
    for o, a in opts:
        if o == "-d":
            needToEncrypt = False
        elif o in ("-h", "--help"):
            print(__doc__)
            sys.exit()
        elif o == "-e":
            pass
        elif o in ("-k", "--key"):
            key = int(a, base=16)
        elif o in ("-f", "--file"):
            encFile = a
        elif o == "-w":
            weak = True
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
        else:
            assert False, "Unhandled option"
    if weak:
        key = None
    elif key is None:
        print ("Key not specified.")
        mayContinue = False
    if encFile is None:
        print ("File not specified.")
        mayContinue= False
    if not mayContinue:
        print ("Exit.")
        sys.exit(2)
    process_file(encFile, encrypt if needToEncrypt else decrypt, blockSize, iterationNum, key)

if __name__ == '__main__':
    main()