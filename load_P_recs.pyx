import csv

def load_P_recs(path,max_recs=15,numrows=None):
    """
    Function for loading P-model recommendations
    """
    cdef dict all_rows = {}
    cdef list row
    cdef list recs
    #cdef str anchor_pid
    with open(path, "r") as view_file:
        csv_reader = csv.reader(view_file, delimiter="\t")
        for row in csv_reader:
            anchor_pid = row[1]
            recs = row[2].split('|')
            if len(recs) < max_recs:
                recs.extend([None]* (max_recs-len(recs)))
            all_rows[anchor_pid] = recs
            if numrows and len(all_rows) >= numrows:
                break
    return all_rows