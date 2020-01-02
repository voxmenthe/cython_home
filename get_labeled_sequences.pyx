cimport cython

# import numpy as np
# cimport numpy as np

from pandas import unique as puq
from operator import itemgetter

def unique_by_indices(list_of_stuff, indices=[0,-1]):
    
    cdef set seen
    cdef list result
    cdef tuple set_matcher

    seen = set()
    result = []
    
    for item in list_of_stuff:
        set_matcher = tuple([item[x] for x in indices])
        if set_matcher not in seen:
            result.append(item)
            seen.add(set_matcher)
    return result

def get_labeled_sequences(atb_dict=None, purchase_dict=None, view_dict=None, unique=True):
    cdef list vs
    cdef list vsl
    cdef list at
    cdef list atl
    cdef list pu
    cdef list pul
    cdef list all_user_ids

    atbids = list(atb_dict.keys())
    puids = list(purchase_dict.keys())

    all_user_ids = puq(atbids + puids)

    for user_id in all_user_ids:

        if view_dict:
            vs = sorted(view_dict[user_id],key=itemgetter(1))
            vsl = [x + ("VIEW",) for x in vs]
            if unique: vsl = unique_by_indices(vsl)
        
        at = sorted(atb_dict[user_id],key=itemgetter(1))
        atl = [x + ("ATB",) for x in at]
        if unique: atl = unique_by_indices(atl)
        
        pu = sorted(purchase_dict[user_id],key=itemgetter(1))
        pul = [x + ("PURCHASE",) for x in pu]
        if unique: pul = unique_by_indices(pul)
    
    if view_dict:
        full_sequence = sorted(vsl+atl+pul,key=itemgetter(1))
    else:
        full_sequence = sorted(atl+pul,key=itemgetter(1))

    return puq(full_sequence)