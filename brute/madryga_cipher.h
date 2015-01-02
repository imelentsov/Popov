#ifndef MADRYGA_H
    #define MADRYGA_H
    #include <stdbool.h>
    typedef unsigned short US;
    void encrypt(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, US key);
    void decrypt(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, US key);
    void encrypt_weak(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum);
    void decrypt_weak(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum);
#endif 