'''
Created on 2014-12-25 11:03
@summary: 
@author: i.melentsov
'''
from cio cimport SEEK_CUR
from madryga import encrypt

def process_file(f, func, block_size, iterationNum, key, writeToFile=True):
    buf = bytearray(block_size)
    eof = False
    while not eof:
        readed = f.fread(buf, 1, block_size)
        if (readed < block_size):
            eof = True
            for i in range(readed, block_size):
                buf[i] = 0
        if (readed > 0):
            if func(buf, block_size, iterationNum, key):
                if writeToFile:
                    f.fseek(-readed, SEEK_CUR)
                    f.fwrite(buf, 1, block_size)
                    f.fseek(0, SEEK_CUR)
            else:
                return False
    return True
