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
