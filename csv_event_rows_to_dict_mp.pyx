import gc
import csv
from multiprocessing import Process, Manager

def csv_event_rows_to_dict_mp(path,chunksize=600000):
	"""
	path: filepath :: the path of the csv file to be read
	numrows: int or False/None :: the number of rows to load
	numcols: int or False/None :: only load rows of length numcols
	truncate: int or False/None :: automatically truncate rows to length truncate

	Note: only numcols or truncate can be set but not both.
	"""

	def gen_chunks(reader, chunksize=600000):
		""" 
		Chunk generator. Take a CSV `reader` and yield
		`chunksize` sized slices. 
		"""
		cdef list line
		cdef list chunk
		chunk = []
		for i, line in enumerate(reader):
			if (i % chunksize == 0 and i > 0):
				yield chunk
				del chunk[:]  # or: chunk = []
			chunk.append(line)
		yield chunk


	def process_chunk(csv_generator, data):
		cdef list row
		for chunk in csv_generator
			for row in chunk:
				if row[0] in data.keys():
					data[row[0]].append((row[1],row[2]))
				else:
					data[row[0]] = [(row[1],row[2])]
			del chunk
			gc.collect()
	#return data

	manager = Manager()
	data_dict = manager.dict()

	with open(path, "r") as data_file:
		csv_reader = csv.reader(data_file, delimiter="\t")
		csv_generator = gen_chunks(csv_reader, chunksize=chunksize)
		p1 = Process(target=process_chunk, args=(csv_generator, data_dict))
		p2 = Process(target=process_chunk, args=(csv_generator, data_dict))
		p3 = Process(target=process_chunk, args=(csv_generator, data_dict))
		p4 = Process(target=process_chunk, args=(csv_generator, data_dict))
		p1.start()
		p2.start()
		p3.start()
		p4.start()
		p1.join()
		p2.join()
		p3.join()
		p4.join()

	return data_dict
