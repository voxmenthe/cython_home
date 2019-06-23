import csv

def loaddata_PID(data,path,numrows=None):
    """
    Inputs:
        data :: dict ::
        path :: str :: a path to a tab-delimited csv file
        numrows :: int :: how many rows to load
    """
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
    return data
