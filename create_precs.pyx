import csv

def create_precs(df, save_path):
	with open(save_path, 'w', newline='') as csvfile:
		writer = csv.writer(csvfile, delimiter='\t')
		for anch in df.index:
			row = df.loc[anch]
			idx = reversed(range(len(row)))
			for pid in row:
				writer.writerow([anch, pid, next(idx)])

	print("Saved recs file as {}".format(save_path))