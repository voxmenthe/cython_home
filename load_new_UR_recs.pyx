import csv

def load_new_UR_recs(path,numrows=None):
    """
    Function for loading UR recs csvs that have format:
    ANCHOR_PID <tab> [list of recs pids]
    """
    cdef dict all_rows = {}
    cdef list row
    cdef list recs
    #cdef str anchor_pid
    with open(path, "r") as view_file:
        csv_reader = csv.reader(view_file, delimiter="\t")
        for row in csv_reader:
            anchor_pid = row[0]
            recs = eval(row[1])
            all_rows[anchor_pid] = recs
            if numrows and len(all_rows) >= numrows:
                break
    return all_rows