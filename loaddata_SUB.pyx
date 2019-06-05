def loaddata_SUB(df,mapping_dict):
	data = OrderedDict()
	
	for row in df.iterrows():
		pid = row[1][1]
		visitor_id = str(row[1][3])

		if visitor_id not in data:
			data[visitor_id] = []

		try:
			data[visitor_id].append(mapping_dict[pid])
		except KeyError:
			 continue
	return data