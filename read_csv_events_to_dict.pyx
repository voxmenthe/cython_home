from libc.stdio cimport *

cdef extern from "stdio.h":
    FILE *fopen(const char *, const char *)
    int fclose(FILE *)
    ssize_t getline(char **, size_t *, FILE *)


def read_csv_events_to_dict(filename,by="user",dedup=False):
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

    cdef str key
 
    while True:
        read = getline(&line, &l, cfile)
        if read == -1: break
        decoded = line.decode("UTF-8")
        row = decoded.split('\t')

        if by == "user":
            key = row[0]
        elif by == "session":
            key = row[3]
        else:
            print("Must organize by either user or session")

        entry = (row[1],row[2])

        if key in output.keys():
            if dedup:
                if entry not in output[key]:
                    output[key].append((row[1],row[2]))                    
            else:
                output[key].append((row[1],row[2]))
        else:
            output[key] = [(row[1],row[2])]
 
    fclose(cfile)
 
    return output
