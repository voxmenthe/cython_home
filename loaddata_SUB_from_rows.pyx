from collections import OrderedDict

def loaddata_SUB_from_rows(rows,mapping_dict):
    data = OrderedDict()
    cdef list row 

    for row in rows:
        pid = row[1]
        visitor_id = str([3])

        if visitor_id not in data:
            data[visitor_id] = []

        try:
            data[visitor_id].append(mapping_dict[pid])
        except KeyError:
             continue
    return data