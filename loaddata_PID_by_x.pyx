import csv

def loaddata_PID_by_x(path, by='session', numrows=None):
    cdef dict data = {}
    cdef int idx
    cdef list row

    with open(path, "r") as view_file:
        csv_reader = csv.reader(view_file, delimiter="\t")
        
        for idx, row in enumerate(csv_reader):
            
            product = str(row[1])
            
            if by == 'session':
                grouping_id = row[3]
            elif by == 'user':
                grouping_id = row[0]

            if grouping_id not in data:
                data[grouping_id] = []
            try:
                data[str(grouping_id)].append(product)
            except KeyError:
                 continue
            if numrows and len(data) >= numrows:
                break
                
    return data