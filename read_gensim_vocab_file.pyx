# not working yet due to not adding pandas stuffx
import csv

def read_gensim_vocab_file(vocfile,veclen=128):
	cdef list row
	cdef int i
	with open(vocfile,'r') as f:
		rows = []
		csv_reader = csv.reader(f,delimiter="\t")
		for i, row in enumerate(csv_reader):
			row = row[0].strip().split()
			rows.append(row[:-1])
		df = pd.DataFrame(rows).set_index(0).fillna(value='ZZ99ZZ99').reset_index().astype('str')
		#df - apply remove '' before summing
		#df = df.apply(lambda x: x.str.replace("'","") if x.dtype == "object" else x) # not doing this b/c hard to strip from sub_attr
	return list(df.sum(axis=1).astype('str').str.replace('ZZ99ZZ99',""))