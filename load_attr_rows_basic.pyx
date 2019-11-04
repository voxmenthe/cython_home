from libc.stdio cimport *

cdef extern from "stdio.h":
    FILE *fopen(const char *, const char *)
    int fclose(FILE *)
    ssize_t getline(char **, size_t *, FILE *)

"""
Assuming these column positions are still valid:
[('product_id', 0), ('prod_name', 1), ('today_price', 2), ('availability_flag', 5), ('home_category_id', 6), 
 ('gmm_id', 7), ('div_id', 8), ('department_id', 9), ('prod_age_txt', 10), ('new_arrival', 11), ('brand', 12), 
 ('age_category', 15), ('gender', 17), ('master_product_flag', 18), ('recommend_pdp', 19), ('site_product_type', 21), 
 ('pwp_ind', 24)]
 """


def load_attr_rows_basic(filename):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef str decoded
    cdef list row
    cdef list output_rows
    output_rows = []

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
        output_rows.append( row[0:3] + row[5:13] + [row[15]] + row[17:20] + [row[21]] + [row[24]] )
 
    fclose(cfile)
 
    return output_rows