'''
Created on 2014-12-25 11:03
@summary: 
@author: i.melentsov
'''
from cio cimport SEEK_CUR

def process_file(f, func, block_size, iterationNum, key, weak=False):
    buf = bytearray(block_size)
    eof = False
    while not eof:
        readed = f.fread(buf, 1, block_size)
        if (readed < block_size):
            eof = True
            for i in range(readed, block_size):
                buf[i] = 0
        if (readed > 0):
            if not func(buf, block_size, iterationNum, key, weak):
                return False
            f.fseek(-readed, SEEK_CUR)
            f.fwrite(buf, 1, block_size)
            f.fseek(0, SEEK_CUR)
    return True
