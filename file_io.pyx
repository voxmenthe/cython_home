from libc.stdio cimport *
 
cdef extern from "stdio.h":
    #FILE * fopen ( const char * filename, const char * mode )
    FILE *fopen(const char *, const char *)
    #int fclose ( FILE * stream )
    int fclose(FILE *)
    #ssize_t getline(char **lineptr, size_t *n, FILE *stream);
    ssize_t getline(char **, size_t *, FILE *)
 
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
        output.append(line.split('\t'))
        #yield line
 
    fclose(cfile)
 
    return output #[]

