#include "madryga_cipher.h"

const US keyRandomConstant = 0x6978;
const char keyRotationBits = 3;

// block size is 2^n
void encrypt(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, US key) {
    unsigned short blockSizeMask = blockSize - 1, j;
    unsigned char i;
    for (i = 0; i < iterationNum; ++i) {
        for (j = 0; j < blockSize; ++j) {
            key ^= keyRandomConstant;
            key = (key << keyRotationBits) | (key >> ((sizeof(US) << 3) - keyRotationBits));
            char roll = buffer[j] & 7;
            buffer[j] = buffer[j] ^ ((unsigned char*)&key)[0];
            unsigned short prev_prev_ind = (j - 2) & blockSizeMask;
            unsigned short prev_ind = (j - 1) & blockSizeMask;
            unsigned short val = (((unsigned short)buffer[prev_prev_ind]) << 8) | buffer[prev_ind];
            val = (val << roll) | (val >> ((sizeof(short) << 3) - roll));
            buffer[prev_prev_ind] = ((unsigned char*)&val)[0];
            buffer[prev_ind] = ((unsigned char*)&val)[1];
        }
    }
}

void decrypt(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum, US key) {
    unsigned short blockSizeMask = blockSize - 1, j;
    unsigned char i;
    unsigned char rotations = (((int)blockSize) * iterationNum) % ((sizeof(US) << 3) * keyRotationBits);
    for (j = 0; j < rotations; ++j) {
        key ^= keyRandomConstant;
        key = (key << keyRotationBits) | (key >> ((sizeof(US) << 3) - keyRotationBits));
    }
    for (i = 0; i < iterationNum; ++i) {
        for (j = blockSizeMask; j < 255; --j) {
            buffer[j] = buffer[j] ^ ((char*)&key)[0];
            char roll = buffer[j] & 7;
            unsigned short prev_prev_ind = (j - 2) & blockSizeMask;
            unsigned short prev_ind = (j - 1) & blockSizeMask;
            unsigned short val = (((unsigned short)buffer[prev_prev_ind]) << 8) | buffer[prev_ind];
            val = (val >> roll) | (val << ((sizeof(short) << 3) - roll));
            buffer[prev_prev_ind] = ((unsigned char*)&val)[0];
            buffer[prev_ind] = ((unsigned char*)&val)[1];
            key = (key >> keyRotationBits) | (key << ((sizeof(US) << 3) - keyRotationBits));
            key ^= keyRandomConstant;
        }
    }
}

void encrypt_weak(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum) {
    unsigned short blockSizeMask = blockSize - 1, j;
    unsigned char i;
    for (i = 0; i < iterationNum; ++i) {
        for (j = 0; j < blockSize; ++j) {
            char roll = buffer[j] & 7;
            unsigned short prev_prev_ind = (j - 2) & blockSizeMask;
            unsigned short prev_ind = (j - 1) & blockSizeMask;
            unsigned short val = (((unsigned short)buffer[prev_prev_ind]) << 8) | buffer[prev_ind];
            val = (val << roll) | (val >> ((sizeof(short) << 3) - roll));
            buffer[prev_prev_ind] = ((unsigned char*)&val)[0];
            buffer[prev_ind] = ((unsigned char*)&val)[1];
        }
    }
}

void decrypt_weak(unsigned char * buffer, unsigned short blockSize, unsigned char iterationNum) {
    unsigned short blockSizeMask = blockSize - 1, j;
    unsigned char i;
    for (i = 0; i < iterationNum; ++i) {
        for (j = blockSizeMask; j < 255; --j) {
            char roll = buffer[j] & 7;
            unsigned short prev_prev_ind = (j - 2) & blockSizeMask;
            unsigned short prev_ind = (j - 1) & blockSizeMask;
            unsigned short val = (((unsigned short)buffer[prev_prev_ind]) << 8) | buffer[prev_ind];
            val = (val >> roll) | (val << ((sizeof(short) << 3) - roll));
            buffer[prev_prev_ind] = ((unsigned char*)&val)[0];
            buffer[prev_ind] = ((unsigned char*)&val)[1];
        }
    }
}