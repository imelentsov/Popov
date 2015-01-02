# distutils: language = c
# distutils: sources = madryga_cipher.c
'''
Created on 2014-12-23 10:39
@summary: 
@author: i.melentsov
'''
ctypedef unsigned short US;

cdef extern from "madryga_cipher.h":
    void c_encrypt "encrypt" (unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, US key)
    void c_decrypt "decrypt" (unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, US key)

def encrypt(text, blockSize, iterationNum, key):
    c_encrypt(<unsigned char*>text, blockSize, iterationNum, key)
    return True

def decrypt(text, blockSize, iterationNum, key):
    c_decrypt(<unsigned char*>text, blockSize, iterationNum, key)
    return True
