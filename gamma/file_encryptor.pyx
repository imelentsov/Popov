'''
Created on 2014-12-25 11:03
@summary: 
@author: i.melentsov
'''
from cio import open as copen
from cio cimport SEEK_CUR, SEEK_SET

def process_file(file_name, func, block_size, iterationNum, key, max_deviation):
    buf = bytearray(block_size)
    total_weight = 0
    blocks_num = 0
    first = block_size << 3
    last = 0
    blocks = [set() for i in range(first)] # num of 1 in block -> [blocks]
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
                bits = bits_in_block(buf)
                if bits > last:
                    last = bits
                if bits < first:
                    first = bits
                total_weight += bits
                blocks[bits].add(blocks_num)
                blocks_num += 1
                
                f.fseek(-readed, SEEK_CUR)
                f.fwrite(buf, 1, block_size)
                f.fseek(0, SEEK_CUR)
        # read all
        f.fseek(0, SEEK_SET) # ready for writing
        center = (blocks_num * block_size) << 2
        possible_deviation =  (center << 1) * max_deviation # 10% * blocks_num * block_size * 8
        cur_deviation = total_weight - center
        index = 0
        while abs(cur_deviation) > possible_deviation:
            if cur_deviation < 0:
                index = first
            else:
               index = last

            block_index = blocks[index].pop()
            total_weight -= index
            f.fseek(block_index * block_size, SEEK_SET)
            f.fread(buf, 1, block_size)
            func(buf, block_size, iterationNum, key)
            f.fseek(-block_size, SEEK_CUR)
            f.fwrite(buf, 1, block_size)

            bits = bits_in_block(buf)
            total_weight += bits
            blocks[bits].add(block_index)
            if blocks_num == 1:
                last = bits
                first = bits
            else:
                need_to_ch_last = True
                need_to_ch_first = True
                if bits > last:
                    last = bits
                    need_to_ch_last = False
                if bits < first:
                    first = bits
                    need_to_ch_first = False
                if index == first and need_to_ch_first:
                    while not blocks[first]:
                        first += 1
                if index == last and need_to_ch_last:
                    while not blocks[last]:
                        last -= 1
            cur_deviation = total_weight - center
        print("Generated gamma {} to {}.".format(total_weight, abs((center << 1) - total_weight)))

def bits_in_block(block):
    res = 0
    for byte in block:
        for i from 0 <= i < 8:
            res += (byte >> i) & 1
    return res