import cython
cimport cython


# import numpy as np
# cimport numpy as np

from libc.stdio cimport *

cdef extern from "stdio.h":
    FILE *fopen(const char *, const char *)
    int fclose(FILE *)
    ssize_t getline(char **, size_t *, FILE *)

# intermediate test
def sort_by_timestamp_while_reading(eventfile):
	
	eventfile_byte_string = eventfile.encode("UTF-8")
	cdef char* fname = eventfile_byte_string
	cdef FILE* ecfile

    cdef str decoded
    cdef list row

    cdef list output

    ecfile = fopen(fname, "rb")

    cdef char * line = NULL
    cdef size_t l = 0
    cdef ssize_t read

    cdef str user_id
    cdef str item_id
    cdef str timestamp
    cdef str last_timestamp

    last_timestamp = ''
 
    while True:
        read = getline(&line, &l, vcfile)
        if read == -1: break
        decoded = line.decode("UTF-8")
        row = decoded.split('\t')

        timestamp = row[2]

        if timestamp >= last_timestamp:
        	output.append(row)
        else:
        	output = [row] + output

	return output

"""
Note this:
from cpython cimport array
  from libc.string cimport memcpy
  def cyappend3(array.array arr, long long int x):
           cdef Py_ssize_t n=len(arr)
           cdef array.array res = array.clone(arr,n+1,False)
           memcpy(res.data.as_voidptr, arr.data.as_voidptr, 8*n)#that is pretty sloppy..
           res.data.as_longlongs[n]=x
           return res

from: https://stackoverflow.com/questions/46980273/what-is-the-fastest-way-in-cython-to-create-a-new-array-from-an-existing-array-a
"""

def all_event_csvs_to_one_dict(viewfile, atbfile, purchasefile, by="user", dedup=False):
    viewfile_byte_string = viewfile.encode("UTF-8")
    atbfile_byte_string = atbfile.encode("UTF-8")
    purchasefile_byte_string = purchasefile.encode("UTF-8")

    cdef char* vfname = viewfile_byte_string
    cdef char* afname = atbfile_byte_string
    cdef char* pfname = purchasefile_byte_string
 
    cdef FILE* vcfile
    cdef FILE* acfile
    cdef FILE* pcfile
    
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
        read = getline(&line, &l, vcfile)
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