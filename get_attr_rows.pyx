import csv

def get_attr_rows(attr_file, numrows=None, num_cols = 23):
    cdef list all_rows = []
    cdef int i
    cdef list row
    
    with open(attr_file, "r") as atfile:
        csv_reader = csv.reader(atfile, delimiter="\t")
    
        for i, row in enumerate(csv_reader):
            if len(row) == num_cols: all_rows.append(row)
            if numrows and i > numrows: break
    
    return all_rows