cdef extern from "stdio.h":
    ctypedef struct FILE

    enum: SEEK_SET
    enum: SEEK_CUR
    enum: SEEK_END

    #FILE * fopen ( const char * filename, const char * mode )
    FILE* fopen(const char *, const char *)

    # size_t fread ( void * ptr, size_t size, size_t count, FILE * stream )
    size_t fread (void *, size_t, size_t, FILE *)

    # size_t fwrite ( const void * ptr, size_t size, size_t count, FILE * stream )
    size_t fwrite (const void *, size_t, size_t, FILE *)

    #int fseek (FILE * stream, long int offset, int origin)
    int fseek (FILE *, long int, int)

    long int ftell (FILE *)

    int fclose(FILE *)