from libc.stdio cimport *

cdef extern from "stdio.h":
    FILE *fopen(const char *, const char *)
    int fclose(FILE *)
    ssize_t getline(char **, size_t *, FILE *)


def load_pid_ptype_dict_from_attr(filename):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef str decoded
    cdef list row
    cdef dict output_dict
    output_dict = {}

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
        output_dict[row[0]] = row[21]
 
    fclose(cfile)
 
    return output_dict