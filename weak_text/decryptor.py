#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Decryptor. Determine type of encoding by first block.
Usage:
    -k, --key - specifies key for encryption/decription in hex
    -f, --file - specifies file for encryption/decription
    -s, --blockSize - specifies blockSize should be power of 2
    -i, --iterations - specifies number of iterations in madryga algorithm
    -h, --help - display this information
"""

'''
Created on 2014-12-28 14:51
@summary: 
@author: i.melentsov
'''
import getopt, sys
from madryga import decrypt
from file_encryptor import process_file

from cio import open as copen

def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "k:f:i:s:h", ["help", "key=", "file=", "iterations=", "blockSize="])
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
    for o, a in opts:
        if o in ("-h", "--help"):
            print(__doc__)
            sys.exit()
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
        else:
            assert False, "Unhandled option"
    if encFile is None:
        print ("File not specified.")
        mayContinue = False
    if not mayContinue:
        print ("Exit.")
        sys.exit(2)
    with copen(encFile, "rb+") as f:
        if not process_file(f, decrypt_and_check, blockSize, iterationNum, key, True):
            f.anew()
            if not process_file(f, decrypt_and_check, blockSize, iterationNum, key):
                print("Can not decrypt file. Check blockSize, iterationNum, key and initial text should be in ascii.")
            else:
                print("Strong text was decrypted.")
        else:
            print("Weak text was decrypted.")

def decrypt_and_check(buf, block_size, iterationNum, key, weak):
    decrypt(buf, block_size, iterationNum, key, weak)
    try:
        buf.decode('ascii')
        return True
    except Exception:
        return False

if __name__ == '__main__':
    main()