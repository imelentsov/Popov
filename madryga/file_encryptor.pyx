'''
Created on 2014-12-25 11:03
@summary: 
@author: i.melentsov
'''
from cio import open as copen
from cio cimport SEEK_CUR

def process_file(file_name, func, block_size, iterationNum, key):
    buf = bytearray(block_size)
    with copen(file_name, "rb+") as f:
        eof = False
        while not eof:
            readed = f.fread(buf, 1, block_size)
            if (readed < block_size):
                eof = True
                for i in range(readed, block_size):
                    buf[i] = 0
            if (readed > 0):
                func(buf, block_size, iterationNum, key)
                f.fseek(-readed, SEEK_CUR)
                f.fwrite(buf, 1, block_size)
                f.fseek(0, SEEK_CUR)
