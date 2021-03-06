from libc.stdio cimport *
from libc.stdlib cimport malloc
from libc.string cimport strcpy, strlen

#import numpy as np
#cimport numpy as np

cdef extern from "stdio.h":
    #FILE * fopen ( const char * filename, const char * mode )
    FILE *fopen(const char *, const char *)
    #int fclose ( FILE * stream )
    int fclose(FILE *)
    #ssize_t getline(char **lineptr, size_t *n, FILE *stream);
    ssize_t getline(char **, size_t *, FILE *)

# cdef char* c_call_returning_a_c_string():
#     cdef char* c_string = <char *> malloc((n + 1) * sizeof(char))
#     if not c_string:
#         raise MemoryError()
#     strcpy(c_string, hello_world)
#     return c_string

# cdef void get_a_c_string(char** c_string_ptr, Py_ssize_t *length):
#     c_string_ptr[0] = <char *> malloc((n + 1) * sizeof(char))
#     if not c_string_ptr[0]:
#         raise MemoryError()

#     strcpy(c_string_ptr[0], hello_world)
#     length[0] = n
 
def read_file_slow(filename):
    output = []
    f = open(filename, "rb")
    while True:
        line = f.readline()
        if not line: break
        output.append(line)
        #yield line
 
    f.close()
 
    return output

def read_file(filename):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef list output
    output = []

    cfile = fopen(fname, "rb")
    if cfile == NULL:
        raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read
 
    while True:
        read = getline(&line, &l, cfile)
        if read == -1: break
        output.append(line)
        #yield line
 
    fclose(cfile)
 
    return output #[]

 
def read_file2(filename):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef list output
    output = []

    cfile = fopen(fname, "rb")
    if cfile == NULL:
        raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read
 
    while True:
        read = getline(&line, &l, cfile)
        if read == -1: break
        output.append(line.split(b'\t'))
        #yield line
 
    fclose(cfile)
 
    return output #[]

def read_file3(filename):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef str row
    cdef list output
    output = []

    cfile = fopen(fname, "rb")
    if cfile == NULL:
        raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read
 
    while True:
        read = getline(&line, &l, cfile)
        if read == -1: break
        row = line.decode("UTF-8")
        output.append(row.split('\t'))
        #yield line
 
    fclose(cfile)
 
    return output #[]

def read_file3a(filename):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef list output
    output = []

    cfile = fopen(fname, "rb")
    if cfile == NULL:
        raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read
 
    while True:
        read = getline(&line, &l, cfile)
        if read == -1: break
        output.append(line.decode("UTF-8").split('\t'))
        #yield line
 
    fclose(cfile)
 
    return output #[]

def read_file_to_tuples(filename):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef str decoded
    cdef list row
    cdef list output
    output = []

    cfile = fopen(fname, "rb")
    if cfile == NULL:
        raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read
 
    while True:
        read = getline(&line, &l, cfile)
        if read == -1: break
        decoded = line.decode("UTF-8")
        row = decoded.split('\t')
        output.append((row[0], (row[1], row[2])))
        #yield line
 
    fclose(cfile)
 
    return output #[]

def read_file_to_dict(filename):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef str decoded
    cdef list row
    cdef dict output
    output = {}

    cfile = fopen(fname, "rb")
    if cfile == NULL:
        raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read
 
    while True:
        read = getline(&line, &l, cfile)
        if read == -1: break
        decoded = line.decode("UTF-8")
        row = decoded.split('\t')
        if row[0] in output.keys():
            output[row[0]].append((row[1],row[2]))
        else:
            output[row[0]] = [(row[1],row[2])]
 
    fclose(cfile)
 
    return output #[]
