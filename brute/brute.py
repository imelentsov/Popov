#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Script will find key for file decryption
    -f, --file - specifies file to be bruted
    -h, --help - display this information
"""

'''
Created on 2014-12-27 04:16
@summary: 
@author: i.melentsov
'''
import getopt, sys
from madryga import decrypt
from file_encryptor import process_file
from cio import open as copen

def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "f:h", ["help", "file="])
    except getopt.GetoptError as err:
        # print help information and exit:
        print (str(err))
        print(__doc__)
        sys.exit(2)
    encFile = None
    iterationNum = 8
    blockSize = 128
    for o, a in opts:
        if o in ("-h", "--help"):
            print(__doc__)
            sys.exit()
        elif o in ("-f", "--file"):
            encFile = a
        else:
            assert False, "Unhandled option"
    if encFile is None:
        print ("File not specified.")
        print ("Exit.")
        sys.exit(2)

    with copen(encFile, "rb") as f:
        for key in range(65536):
            f.anew()
            if process_file(f, decrypt_brut, blockSize, iterationNum, key, False):
                print("Decrypted on key - ", hex(key))
                return
    print("Decryption key was not found.\nInitial file not in ascii or file was encrypted with strong cipher.")

def decrypt_brut(buf, block_size, iterationNum, key):
    decrypt(buf, block_size, iterationNum, key)
    try:
        buf.decode('ascii')
        return True
    except Exception:
        return False

if __name__ == '__main__':
    main()