import csv

def get_baskets_cdef(path,min_n=2,numrows=None):
    #data = dict()
    cdef dict data = {}
    cdef int product = 8888888

    with open(path, "r") as view_file:
        csv_reader = csv.reader(view_file, delimiter="\t")
        for id, row in enumerate(csv_reader):
            product = int(row[1])
            visitor_id = str(row[3])

            if visitor_id not in data:
                data[visitor_id] = []
            try:
                data[str(visitor_id)].append(product)
            except KeyError:
                 continue
            if numrows and len(data) >= numrows:
                break
    # threshold
    data = {k:v for k, v in data.items() if len(v) > min_n-1}

    return data