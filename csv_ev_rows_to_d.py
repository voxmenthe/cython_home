import gc
import csv

from libc.stdio cimport *

cdef extern from "stdio.h":
    #FILE * fopen ( const char * filename, const char * mode )
    FILE *fopen(const char *, const char *)
    #int fclose ( FILE * stream )
    int fclose(FILE *)
    #ssize_t getline(char **lineptr, size_t *n, FILE *stream);
    ssize_t getline(char **, size_t *, FILE *)

def read_file_ev_rows(filename, chunksize=600000):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef list row
    cdef list output
    cdef dict data
    cdef int counter

    output = []
    data = {}
    counter = 0

    cfile = fopen(fname, "rb")
    if cfile == NULL:
        raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read
 
    while True:
        counter += 1
        read = getline(&line, &l, cfile)
        if read == -1: break
        row = line.split(b'\t')
        output.append((row[0],(row[1],row[2])))
        #yield line
 
    fclose(cfile)
 
    return output #[]