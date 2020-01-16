import cython
cimport cython


# import numpy as np
# cimport numpy as np

cimport numpy as np
import datetime
import numpy as np
import pandas as pd
from libc.stdlib cimport atoi, malloc, free 
from libc.string cimport strcpy

define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION

### Modified code from Michael WS:
### https://stackoverflow.com/a/15812787/2447082

###########################################################
###########################################################
###########################################################

from libc.stdio cimport *

cdef extern from "stdio.h":
	FILE *fopen(const char *, const char *)
	int fclose(FILE *)
	ssize_t getline(char **, size_t *, FILE *)

###########################################################
###########################################################
###########################################################

### Modified code from Michael WS:
### https://stackoverflow.com/a/15812787/2447082

def convert_date_fast(np.ndarray date_vec, np.ndarray time_vec):
	cdef int i, d_year, d_month, d_day, t_hour, t_min, t_sec, t_ms
	cdef int N = len(date_vec)
	cdef np.ndarray out_ar = np.empty(N, dtype=np.object)  
	cdef bytes prev_date = <bytes> 'xx/xx/xxxx'
	cdef char *date_str = <char *> malloc(20)
	cdef char *time_str = <char *> malloc(20)

	for i in range(N):
		if date_vec[i] != prev_date:
			prev_date = date_vec[i] 
			strcpy(date_str, prev_date) ### xx/xx/xxxx
			date_str[2] = 0 
			date_str[5] = 0 
			d_year = atoi(date_str+6)
			d_month = atoi(date_str+3)
			d_day = atoi(date_str)

		strcpy(time_str, time_vec[i])   ### xx:xx:xx:xxxxxx
		time_str[2] = 0
		time_str[5] = 0
		time_str[8] = 0
		t_hour = atoi(time_str)
		t_min = atoi(time_str+3)
		t_sec = atoi(time_str+6)
		t_ms = atoi(time_str+9)

		out_ar[i] = datetime.datetime(d_year, d_month, d_day, t_hour, t_min, t_sec, t_ms)
	free(date_str)
	free(time_str)
	return pd.to_datetime(out_ar)

###########################################################
###########################################################


# intermediate test
def sort_by_timestamp_while_reading(eventfile):
	
	eventfile_byte_string = eventfile.encode("UTF-8")
	cdef char* fname = eventfile_byte_string
	cdef FILE* ecfile

	cdef str decoded
	cdef list row

	cdef list output
	output = []

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
		read = getline(&line, &l, ecfile)
		if read == -1: break
		decoded = line.decode("UTF-8")
		row = decoded.split('\t')

		timestamp = row[2]

		if timestamp >= last_timestamp:
			output.append(row)
		else:
			output = [row] + output

		last_timestamp = timestamp

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
		#row = decoded.split('\t')

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
"""