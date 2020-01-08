from libc.stdio cimport *

cdef extern from "stdio.h":
    FILE *fopen(const char *, const char *)
    int fclose(FILE *)
    ssize_t getline(char **, size_t *, FILE *)

def threshold(data_dict, min_n=2):
    dd = {k:v for k, v in data_dict.items() if len(v) > min_n-1}
    return dd

def loaddata_SUB_combo_new(event_csv_path, mapping_dict, min_n=2):
    filename_byte_string = event_csv_path.encode("UTF-8")
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

    cdef str user_id
    cdef int product_id
    cdef str subbed_attr
 
    while True:
        read = getline(&line, &l, cfile)
        if read == -1: break
        decoded = line.decode("UTF-8")
        row = decoded.split('\t')
        user_id = row[0]
        product_id = row[1]
        subbed_attr = mapping_dict[product_id]
        if user_id not in output:
            output[user_id] = []
        else:
            output[user_id].append(subbed_attr)
 
    fclose(cfile)
 
    return output