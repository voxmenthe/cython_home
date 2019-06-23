import csv

def get_csv_rows(path, numrows=None,numcols=None,truncate=False):
    """
    path: filepath :: the path of the csv file to be read
    numrows: int or False/None :: the number of rows to load
    numcols: int or False/None :: only load rows of length numcols
    truncate: int or False/None :: automatically truncate rows to length truncate

    Note: only numcols or truncate can be set but not both.
    """
    cdef dict data
    cdef list row
    cdef int counter
    all_rows = []

    with open(path, "r") as data_file:
        csv_reader = csv.reader(data_file, delimiter="\t")
        if numrows: counter = 0
        assert not truncate and numcols, "Can only set one of truncate or numcols but not both"
        for row in csv_reader:

            if numrows:
                counter += 1
                if counter >= numrows: break

            if truncate:
                row = all_rows.append(row[:truncate])
            elif numcols:
                if len(row) == numcols:
                    all_rows.append(row)
            else:
                all_rows.append(row)

    return all_rows