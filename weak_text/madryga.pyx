# distutils: language = c
# distutils: sources = madryga_cipher.c
'''
Created on 2014-12-23 10:39
@summary: 
@author: i.melentsov
'''
ctypedef unsigned long long ULL;

cdef extern from "madryga_cipher.h":
    #ctypedef ULL
    void c_encrypt "encrypt" (unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, ULL key)
    void c_decrypt "decrypt" (unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, ULL key)
    void c_encrypt_weak "encrypt_weak" (unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum)
    void c_decrypt_weak "decrypt_weak" (unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum)

def encrypt(text, blockSize, iterationNum, key, weak):
    if weak:
        c_encrypt_weak(<unsigned char*>text, blockSize, iterationNum)
    else:
        c_encrypt(<unsigned char*>text, blockSize, iterationNum, key)
    return True

def decrypt(text, blockSize, iterationNum, key, weak):
    if weak:
        c_decrypt_weak(<unsigned char*>text, blockSize, iterationNum)
    else:
        c_decrypt(<unsigned char*>text, blockSize, iterationNum, key)
    return True
        