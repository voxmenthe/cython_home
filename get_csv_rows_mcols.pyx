import csv

def get_csv_rows_mcols(path, numrows=None,numcols=[]):
    cdef dict data
    cdef list row
    all_rows = []

    with open(path, "r") as data_file:
        csv_reader = csv.reader(data_file, delimiter="\t")
        for row in csv_reader:
            if numcols:
                if len(row) in numcols:
                    all_rows.append(row[:min(numcols)])
            else:
                all_rows.append(row)
            if numrows and len(all_rows) >= numrows:
                break
    return all_rows
