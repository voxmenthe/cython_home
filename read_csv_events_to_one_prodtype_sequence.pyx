from libc.stdio cimport *

cdef extern from "stdio.h":
    FILE *fopen(const char *, const char *)
    int fclose(FILE *)
    ssize_t getline(char **, size_t *, FILE *)


def read_csv_events_to_one_prodtype_sequence(filename, pid_ptype_dict):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef str decoded
    cdef str ptype
    cdef list row
    cdef dict ptype_all_seq
    ptype_all_seq = {}

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
        if row[0] in ptype_all_seq.keys():
            # row[2] is timestamp, row[1] is pid
            ptype = pid_ptype_dict[row[1]]
            ptype_all_seq[row[0]].append((row[2],ptype))
        else:
            ptype_all_seq[row[0]] = [(row[2],ptype)]
 
    fclose(cfile)
 
    return [sorted(x) for x in ptype_all_seq.values()]
