# cython: embedsignature=True
'''
Created on 2014-12-15 12:40
@summary: Wrapper on stdio read/write file functions
@author: i.melentsov
'''

cdef class FileReaderWriter:
    cdef FILE* cfile

    def __init__(self, filename, mode):
        self.cfile = fopen(<char*>filename, <char*>mode)
        if self.cfile == NULL:
            raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

    def fseek(self, offset, origin):
        return fseek(self.cfile, offset, origin)

    def fread(self, ptr, size, count):
        return fread(<char*>ptr, size, count, self.cfile)

    def fwrite(self, ptr, size, count):
        return fwrite(<char*>ptr, size, count, self.cfile)

    def readAll(self):
        fseek(self.cfile, 0, SEEK_END);
        cdef long int fileLen
        fileLen = ftell(self.cfile)
        fseek(self.cfile, 0, SEEK_SET)

        buf = bytearray(fileLen)
        fread(<char*>buf, 1, fileLen, self.cfile)
        return buf

    def writeAll(self, data):
        return fwrite (<char*>data, 1, len(data), self.cfile)

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        if self.cfile != NULL:
            fclose(self.cfile)
            self.cfile = NULL

    def __dealloc__(self):
        if self.cfile != NULL:
            fclose(self.cfile)

def open(filename, mode):
    return FileReaderWriter(str.encode(filename), str.encode(mode))