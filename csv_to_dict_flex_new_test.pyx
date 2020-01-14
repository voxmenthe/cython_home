import cython
cimport cython

# import numpy as np
# cimport numpy as np

from libc.stdio cimport *

cdef extern from "stdio.h":
    FILE *fopen(const char *, const char *)
    int fclose(FILE *)
    ssize_t getline(char **, size_t *, FILE *)

@cython.boundscheck(False)
@cython.wraparound(False)
def csv_to_dict_flex_new_v1(filename,by="user",dedup=False):
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
                    output[key].append(entry)                    
            else:
                output[key].append(entry)
        else:
            output[key] = [entry]
 
    fclose(cfile)
 
    return output


def csv_to_dict_flex_new_v2(filename,by="user",dedup=False):
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
    cdef str item_id
    cdef str timestamp
 
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

        item_id = row[1]
        timestamp = row[2]
        #entry = (row[1],row[2])
        entry = (item_id,timestamp)

        if key in output.keys():
            if dedup:
                if entry not in output[key]:
                    output[key].append(entry)                    
            else:
                output[key].append(entry)
        else:
            output[key] = [entry]
 
    fclose(cfile)
 
    return output

@cython.boundscheck(False)
@cython.wraparound(False)
def csv_to_dict_flex_new_v3(filename,by="user",dedup=False):
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
    cdef str item_id
    cdef str timestamp
 
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

        item_id = row[1]
        timestamp = row[2]
        #entry = (row[1],row[2])
        entry = (item_id,timestamp)

        if key in output.keys():
            if dedup:
                if entry not in output[key]:
                    output[key].append(entry)                    
            else:
                output[key].append(entry)
        else:
            output[key] = [entry]
 
    fclose(cfile)
 
    return output

# For use in csv_to_dict_flex_new_v4 and maybe subsequent versions
cdef struct ENTRY:
    int item_id
    char* timestamp

@cython.boundscheck(False)
@cython.wraparound(False)
def csv_to_dict_flex_new_v4(filename,by="user",dedup=False):
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
    cdef str item_id
    cdef str timestamp

    #cdef ENTRY myentry
    cdef tuple myentry
 
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

        item_id = row[1]
        timestamp = row[2]
        #entry = (row[1],row[2])
        myentry = (item_id,timestamp)

        if key in output.keys():
            if dedup:
                if myentry not in output[key]:
                    output[key].append(myentry)                    
            else:
                output[key].append(myentry)
        else:
            output[key] = [myentry]
 
    fclose(cfile)
 
    return output

@cython.boundscheck(False)
@cython.wraparound(False)
def csv_to_dict_flex_new_v5(filename,by="user",dedup=False):
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
    cdef str item_id
    cdef str timestamp

    cdef tuple myentry
 
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

        item_id = row[1]
        timestamp = row[2]
        #entry = (row[1],row[2])
        myentry = (item_id,timestamp)

        if key in output.keys():
            if dedup:
                if myentry not in output[key]:
                    output[key].append(myentry)                    
            else:
                output[key].append(myentry)
        else:
            output[key] = [myentry]
 
    fclose(cfile)
 
    return output

def csv_to_dict_flex_new_v6(filename,by="user",dedup=False):
    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef str decoded
    cdef list row
    cdef dict output = {}
    cdef list temp_events_list = []

    cfile = fopen(fname, "rb")

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read

    cdef str key
    cdef str item_id
    cdef str timestamp

    cdef tuple myentry
 
    while True:
        temp_events_list = []
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

        item_id = row[1]
        timestamp = row[2]
        #entry = (row[1],row[2])
        myentry = (item_id,timestamp)

        if key in output.keys():
            if dedup:
                if myentry not in output[key]:
                    output[key].append(myentry)                    
            else:
                output[key].append(myentry)
        else:
            output[key] = [myentry]
 
    fclose(cfile)
 
    return output

#from libcpp.list cimport list as cpplist

def csv_to_dict_flex_new_v7(filename,by="user",dedup=False):

    #cdef cpplist row

    filename_byte_string = filename.encode("UTF-8")
    cdef char* fname = filename_byte_string
 
    cdef FILE* cfile
    
    cdef str decoded
    cdef list row
    cdef dict output = {}
    cdef list temp_events_list = []

    cfile = fopen(fname, "rb")

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read

    cdef str key
    cdef str item_id
    cdef str timestamp

    cdef tuple myentry
 
    while True:
        temp_events_list = []
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

        item_id = row[1]
        timestamp = row[2]
        #entry = (row[1],row[2])
        myentry = (item_id,timestamp)

        if key in output.keys():
            if dedup:
                if myentry not in output[key]:
                    output[key].append(myentry)                    
            else:
                output[key].append(myentry)
        else:
            output[key] = [myentry]
 
    fclose(cfile)
 
    return output
