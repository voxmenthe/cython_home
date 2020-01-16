import cython
cimport cython


# import numpy as np
# cimport numpy as np

# cimport numpy as np
import datetime
# import numpy as np
# import pandas as pd
from libc.stdlib cimport atoi, malloc, free 
from libc.string cimport strcpy

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

# def convert_date_fast(np.ndarray date_vec, np.ndarray time_vec):
# 	cdef int i, d_year, d_month, d_day, t_hour, t_min, t_sec, t_ms
# 	cdef int N = len(date_vec)
# 	cdef np.ndarray out_ar = np.empty(N, dtype=np.object)  
# 	cdef bytes prev_date = <bytes> 'xx/xx/xxxx'
# 	cdef char *date_str = <char *> malloc(20)
# 	cdef char *time_str = <char *> malloc(20)

# 	for i in range(N):
# 		if date_vec[i] != prev_date:
# 			prev_date = date_vec[i] 
# 			strcpy(date_str, prev_date) ### xx/xx/xxxx
# 			date_str[2] = 0 
# 			date_str[5] = 0 
# 			d_year = atoi(date_str+6)
# 			d_month = atoi(date_str+3)
# 			d_day = atoi(date_str)

# 		strcpy(time_str, time_vec[i])   ### xx:xx:xx:xxxxxx
# 		time_str[2] = 0
# 		time_str[5] = 0
# 		time_str[8] = 0
# 		t_hour = atoi(time_str)
# 		t_min = atoi(time_str+3)
# 		t_sec = atoi(time_str+6)
# 		t_ms = atoi(time_str+9)

# 		out_ar[i] = datetime.datetime(d_year, d_month, d_day, t_hour, t_min, t_sec, t_ms)
# 	free(date_str)
# 	free(time_str)
# 	return pd.to_datetime(out_ar)

###########################################################

def to_dt(str datestring):
	return datetime.datetime.strptime(datestring, '%Y-%m-%d %H:%M:%S')

###########################################################


# intermediate test
def sort_by_timestamp(eventfile):
	
	eventfile_byte_string = eventfile.encode("UTF-8")
	cdef char* fname = eventfile_byte_string
	cdef FILE* ecfile

	cdef str decoded
	cdef list row
	
	cdef list timestamps
	timestamps = []

	cdef list output
	output = []

	ecfile = fopen(fname, "rb")

	cdef char * line = NULL
	cdef size_t l = 0
	cdef ssize_t read

	cdef str user_id
	cdef str item_id
	#cdef str timestamp
	
	while True:
		read = getline(&line, &l, ecfile)
		if read == -1: break
		decoded = line.decode("UTF-8")
		row = decoded.split('\t')

		#timestamp = row[2]
		#print(row[2])
		if row[2] == 'evnt_ts':
			continue
		timestamp = datetime.datetime.strptime(row[2], '%Y-%m-%d %H:%M:%S')
		
		row.append('EVENT_TYPE')
		
		idx = bisect.bisect(timestamps, timestamp)
		bisect.insort(timestamps, timestamp)
		output.insert(idx, row)
		
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

	vcfile = fopen(vfname, "rb")
	acfile = fopen(afname, "rb")
	pcfile = fopen(pfname, "rb")

	cdef char * line = NULL
	cdef size_t l = 0
	cdef ssize_t read

	cdef str key
	cdef str item_id
	#cdef str timestamp

	cdef tuple myentry

	cdef dict entryfiles

	# eventfiles = {
	# 				'view' : {'file': vcfile, 'event_type': 'VIEW'},
	# 				'atb' : {'file': acfile, 'event_type': 'ATB'},
	# 				'purchase' : {'file': pcfile, 'event_type': 'PURCHASE'}
	# 			}
 
	# for EVT in eventfiles: 		
	while True:
		vread = getline(&line, &l, vcfile)
		if vread != -1:
			decoded = line.decode("UTF-8")
			row = decoded.split('\t')

			# if by == "user":
			# 	key = row[0]
			# elif by == "session":
			# 	key = row[3]
			# else:
			# 	print("Must organize by either user or session")

			key = row[0]
			item_id = row[1]
			#timestamp = row[2]
			if row[2] == 'evnt_ts':
				continue
			timestamp = datetime.datetime.strptime(row[2], '%Y-%m-%d %H:%M:%S')

			myentry = (item_id,timestamp, 'VIEW')

			if key in output.keys():
				if dedup:
					if myentry not in output[key]:
						idx = bisect.bisect(output[key]['TIMESTAMPS'], timestamp)
						bisect.insort(output[key]['TIMESTAMPS'], timestamp)
						output[key]['FULL_SEQUENCE'].insert(idx,myentry)                    
				else:
					idx = bisect.bisect(output[key]['TIMESTAMPS'], timestamp)
					bisect.insort(output[key]['TIMESTAMPS'], timestamp)
					output[key]['FULL_SEQUENCE'].insert(idx,myentry)
			else:
				output[key] = {'FULL_SEQUENCE' : [myentry], 'TIMESTAMPS' : [timestamp]}

	fclose(vcfile)

	while True:
		vread = getline(&line, &l, acfile)
		if vread != -1:
			decoded = line.decode("UTF-8")
			row = decoded.split('\t')

			# if by == "user":
			# 	key = row[0]
			# elif by == "session":
			# 	key = row[3]
			# else:
			# 	print("Must organize by either user or session")

			key = row[0]
			item_id = row[1]
			#timestamp = row[2]
			if row[2] == 'evnt_ts':
				continue
			timestamp = datetime.datetime.strptime(row[2], '%Y-%m-%d %H:%M:%S')

			myentry = (item_id,timestamp, 'ATB')

			if key in output.keys():
				if dedup:
					if myentry not in output[key]:
						idx = bisect.bisect(output[key]['TIMESTAMPS'], timestamp)
						bisect.insort(output[key]['TIMESTAMPS'], timestamp)
						output[key]['FULL_SEQUENCE'].insert(idx,myentry)                    
				else:
					idx = bisect.bisect(output[key]['TIMESTAMPS'], timestamp)
					bisect.insort(output[key]['TIMESTAMPS'], timestamp)
					output[key]['FULL_SEQUENCE'].insert(idx,myentry)
			else:
				output[key] = {'FULL_SEQUENCE' : [myentry], 'TIMESTAMPS' : [timestamp]}

	fclose(acfile)

	while True:
		vread = getline(&line, &l, pcfile)
		if vread != -1:
			decoded = line.decode("UTF-8")
			row = decoded.split('\t')

			# if by == "user":
			# 	key = row[0]
			# elif by == "session":
			# 	key = row[3]
			# else:
			# 	print("Must organize by either user or session")

			key = row[0]
			item_id = row[1]
			#timestamp = row[2]
			if row[2] == 'evnt_ts':
				continue
			timestamp = datetime.datetime.strptime(row[2], '%Y-%m-%d %H:%M:%S')

			myentry = (item_id,timestamp, 'PURCHASE')

			if key in output.keys():
				if dedup:
					if myentry not in output[key]:
						idx = bisect.bisect(output[key]['TIMESTAMPS'], timestamp)
						bisect.insort(output[key]['TIMESTAMPS'], timestamp)
						output[key]['FULL_SEQUENCE'].insert(idx,myentry)                    
				else:
					idx = bisect.bisect(output[key]['TIMESTAMPS'], timestamp)
					bisect.insort(output[key]['TIMESTAMPS'], timestamp)
					output[key]['FULL_SEQUENCE'].insert(idx,myentry)
			else:
				output[key] = {'FULL_SEQUENCE' : [myentry], 'TIMESTAMPS' : [timestamp]}

	fclose(pcfile)
 
	return output