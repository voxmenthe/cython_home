def process_chunk(csv_generator, data_dict):
	cdef list row
	for chunk in csv_generator:
		for row in chunk:
			print("row": row)
			if row[0] in data_dict.keys():
				data_dict[row[0]].append((row[1],row[2]))
			else:
				data_dict[row[0]] = [(row[1],row[2])]