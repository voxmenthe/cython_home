from libc.stdio cimport *

cdef extern from "stdio.h":
    FILE *fopen(const char *, const char *)
    int fclose(FILE *)
    ssize_t getline(char **, size_t *, FILE *)


def loaddata_PID_cyth_new(data, filename):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef str decoded
    cdef list row

    cfile = fopen(fname, "rb")
    if cfile == NULL:
        raise FileNotFoundError(2, "No such file or directory: '%s'" % filename)

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read

    cdef str product
    cdef str visitor_id
 
    while True:
        read = getline(&line, &l, cfile)
        if read == -1: break
        decoded = line.decode("UTF-8")
        row = decoded.split('\t')


        product = str(row[1])
        visitor_id = row[3]

        if visitor_id not in data:
            data[visitor_id] = []
        try:
            data[visitor_id].append(product)
        except KeyError:
             continue
        # if numrows and len(data) >= numrows:
        #     break
 
    fclose(cfile)
 
    return data

# import csv

# def loaddata_PID(data,path,numrows=None):
#     """
#     Inputs:
#         data :: dict ::
#         path :: str :: a path to a tab-delimited csv file
#         numrows :: int :: how many rows to load
#     """
#     with open(path, "r") as view_file:
#         csv_reader = csv.reader(view_file, delimiter="\t")
#         for id, row in enumerate(csv_reader):
#             product = str(row[1])
#             visitor_id = row[3]

#             if visitor_id not in data:
#                 data[visitor_id] = []
#             try:
#                 data[str(visitor_id)].append(product)
#             except KeyError:
#                  continue
#             if numrows and len(data) >= numrows:
#                 break
#     return data