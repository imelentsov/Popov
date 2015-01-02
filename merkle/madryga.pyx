# distutils: language = c++
# distutils: sources = madryga_cipher.cpp
'''
Created on 2014-12-23 10:39
@summary: 
@author: i.melentsov
'''
ctypedef unsigned short US;
ctypedef unsigned long long ULL;

cdef extern from "madryga_cipher.h":
    void c_encrypt "encrypt" (unsigned char * buffer, ULL key)
    void c_decrypt "decrypt" (unsigned char * buffer, ULL key)
    void c_encrypt_weak "encrypt_weak" (unsigned char * buffer, US key)
    void c_decrypt_weak "decrypt_weak" (unsigned char * buffer, US key)

def encrypt(text, key):
    c_encrypt(<unsigned char*>text, key)
    return True

def decrypt(text, key):
    c_decrypt(<unsigned char*>text, key)
    return True

def encrypt_weak(text, key):
    c_encrypt_weak(<unsigned char*>text, key)
    return True

def decrypt_weak(text, key):
    c_decrypt_weak(<unsigned char*>text, key)
    return True
