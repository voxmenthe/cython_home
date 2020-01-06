def seqs_to_df_rows(seqs, vector_dict, mmm_dict, N_ROWS=None):

	cdef list output
	cdef list actions

	cdef tuple action

	cdef str uid
	cdef str item_id
	cdef str event_type
	
	output = []
	
	for actions in seqs[1:N_ROWS]:

		uid = actions[0]

		for action in actions[1:]:

			item_id = action[0]
			event_type = action[2]

			try:
				vector_dict[int(item_id)]
				output.append([uid, mmm_dict[uid], item_id, event_type] + vector_dict[int(item_id)])

			except:
				continue

	return output