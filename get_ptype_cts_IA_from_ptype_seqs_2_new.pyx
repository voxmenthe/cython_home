def get_ptype_cts_IA_from_ptype_seqs_2_new(sequences_list, all_prodtypes):
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

    cdef str past_ptype1
    past_ptype1 = ""

    cdef int seqlen

    for pt in all_prodtypes:
        inner_dicts[pt] = dict.fromkeys(all_prodtypes,0)

    for seq in sequences_list:
        seq = [x[1] for x in seq if x[1] != '']
        seqlen = len(seq)
        if seqlen > 0:
            current_ptype = seq[0]
            for event in seq:
                if event != current_ptype:                    
                    inner_dicts[current_ptype][event] += 1
                    if past_ptype: inner_dicts[current_ptype][past_ptype1] += 1
                    past_ptype1 = current_ptype
                    current_ptype = event
                if i + n_offset >= seqlen:
                    break 

    return inner_dicts