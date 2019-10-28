from libc.stdio cimport *
from libc.stdlib cimport malloc
from libc.string cimport strcpy, strlen
 
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
        output.append([str(x) for x in line.split(b'\t')])
        #yield line
 
    fclose(cfile)
 
    return output #[]

# def read_file4(filename):
#     filename_byte_string = filename.encode("UTF-8")
#     cdef char* fname = filename_byte_string
 
#     cdef FILE* cfile
    
#     cdef list output
#     output = []

#     cfile = fopen(fname, "rb")
#     if cfile == NULL:
#         raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

#     #cdef char * line = NULL
#     cdef char * l = c_call_returning_a_c_string()
#     #cdef size_t l = 0
#     #cdef Py_ssize_t l = 0
#     cdef ssize_t read
    
#     while True:
#         read = getline(&line, &l, cfile)
#         if read == -1: break
        
#         # get pointer and length from a C function
#         #get_a_c_string(&line, &l)

#         #uline = line[:l].decode('UTF-8')
#         uline = line.decode('UTF-8')
#         output.append(uline.split('\t'))
#         #yield line
 
#     fclose(cfile)
 
#     return output #[]
