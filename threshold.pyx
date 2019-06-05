def threshold(data_dict, min_n=2):
    dd = {k:v for k, v in data_dict.items() if len(v) > min_n-1}
    return dd