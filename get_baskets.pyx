import csv

#def get_baskets(data,path,numrows=None):
def get_baskets(path, min_n=2, numrows=None):
    #data = dict()
    cdef dict data = {}

    with open(path, "r") as view_file:
        csv_reader = csv.reader(view_file, delimiter="\t")
        for id, row in enumerate(csv_reader):
            product = str(row[1])
            visitor_id = row[3]

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

# def get_multiple_baskets(paths, min_n=2, numrows=None):
#     #data = dict()
#     cdef dict data = {}

#     for path in enumerate(paths):
#         with open(path, "r") as view_file:
#             csv_reader = csv.reader(view_file, delimiter="\t")
#             for id, row in enumerate(csv_reader):
#                 product = str(row[1])
#                 visitor_id = row[3]

#                 if visitor_id not in data:
#                     data[visitor_id] = []
#                 try:
#                     data[str(visitor_id)].append(product)
#                 except KeyError:
#                      continue
#                 if numrows and len(data) >= numrows:
#                     break

#     # threshold
#     data = {k:v for k, v in data.items() if len(v) > min_n-1}

#     return data