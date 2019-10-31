def get_prodtype_counts_IA_from_prodtype_sequences(sequences_list, all_prodtypes):
    cdef dict inner_dicts
    inner_dicts = {}

    cdef str pt
    pt = ""

    cdef list seq
    seq = []

    cdef str event
    event = ""

    cdef str current_ptype
    current_ptype = ""

    for pt in all_prodtypes:
        inner_dicts[pt] = dict.fromkeys(all_prodtypes,0)

    for seq in sequences_list:
        seq = [x[1] for x in seq if x[1] != '']
        if len(seq) > 0:
            current_ptype = seq[0]
            for event in seq:
                inner_dicts[current_ptype][event] += 1
                current_ptype = event

    return inner_dicts