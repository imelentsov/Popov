#ifndef MADRYGA_H
    #define MADRYGA_H
    #include <stdbool.h>
    typedef unsigned long long ULL;
    typedef unsigned short US;
    void encrypt(unsigned char * buffer, ULL key);
    void encrypt_weak(unsigned char * buffer, US key);
    void decrypt(unsigned char * buffer, ULL key);
    void decrypt_weak(unsigned char * buffer, US key);
#endif 