#include "madryga_cipher.h"

const ULL keyRandomConstant = 0x0f1e2d3c4b5a6978L;
const US keyRandomConstantWeak = 0x6978;
const char keyRotationBits = 3;
const unsigned short blockSize = 128;
const unsigned char iterationNum = 8;

// block size is 2^n
template<typename T> void encrypt_t(unsigned char * buffer, T key, const T _keyRandomConstant) {
    unsigned short blockSizeMask = blockSize - 1, j;
    unsigned char i;
    for (i = 0; i < iterationNum; ++i) {
        for (j = 0; j < blockSize; ++j) {
            key ^= _keyRandomConstant;
            key = (key << keyRotationBits) | (key >> ((sizeof(T) << 3) - keyRotationBits));
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

template<typename T> void decrypt_t(unsigned char * buffer, T key, const T _keyRandomConstant) {
    unsigned short blockSizeMask = blockSize - 1, j;
    unsigned char i;
    unsigned char rotations = (((int)blockSize) * iterationNum) % ((sizeof(US) << 3) * keyRotationBits);
    for (j = 0; j < rotations; ++j) {
        key ^= _keyRandomConstant;
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
            key ^= _keyRandomConstant;
        }
    }
}

void encrypt(unsigned char * buffer, ULL key) {
    encrypt_t<ULL>(buffer, key, keyRandomConstant);
}

void encrypt_weak(unsigned char * buffer, US key) {
    encrypt_t<US>(buffer, key, keyRandomConstantWeak);
}

void decrypt(unsigned char * buffer, ULL key) {
    decrypt_t<ULL>(buffer, key, keyRandomConstant);
}

void decrypt_weak(unsigned char * buffer, US key) {
    decrypt_t<US>(buffer, key, keyRandomConstantWeak);
}
