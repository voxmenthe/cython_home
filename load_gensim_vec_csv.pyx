import csv

def load_gensim_vec_csv(vectors_filename, dims=100):
	cdef list row
	cdef int i
	cdef list orig_row
    with open(vectors_filename,'r') as f:
        rows = []
        csv_reader = csv.reader(f)
        for i, row in enumerate(csv_reader):
            if i == 0:
                continue
            orig_row = row.copy()
            if len(row) > 1:
                row = [row[-1]]
            row = row[0].strip().split()[-dims:]
            #print(len(row))
            #print(row)
            if len(row) > 1:
                rows.append(row)
            else:
                print("This row not added: ",'\n',row)
                print("Original Row: ")
                print(orig_row)
                print()
        #vector_df = pd.DataFrame(rows)
    return rows #vector_df
