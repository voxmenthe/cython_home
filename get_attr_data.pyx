import csv

def get_attr_data(attr_file, numrows=None, num_cols = 22):
    cdef list ok_rows = []
    cdef int i
    cdef list row
    
    with open(attr_file, "r") as atfile:
        csv_reader = csv.reader(atfile, delimiter="\t")
    
        for i, row in enumerate(csv_reader):        
            if len(row) == num_cols: ok_rows.append(row)
            if i >= numrows: break
    
    return ok_rows