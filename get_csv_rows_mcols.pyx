import csv

def get_csv_rows_mcols(path, numrows=None,numcols=[],truncate=True):
    cdef dict data
    cdef list row
    all_rows = []
    
    if numcols:
        mincols = min(numcols)

    with open(path, "r") as data_file:
        csv_reader = csv.reader(data_file, delimiter="\t")
        for row in csv_reader:
            if numcols:
                if len(row) in numcols:
                    if truncate:
                        all_rows.append(row[:mincols])
                    else:
                        all_rows.append(row)
            else:
                all_rows.append(row)
            if numrows and len(all_rows) >= numrows:
                break
    return all_rows
