#ifndef MADRYGA_H
    #define MADRYGA_H
    #include <stdbool.h>
    typedef unsigned long long ULL;
    void encrypt(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, ULL key);
    void decrypt(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, ULL key);
    void encrypt_weak(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum);
    void decrypt_weak(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum);
#endif 