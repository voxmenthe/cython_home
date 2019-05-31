import csv
import json
import requests

def create_ur_recs_dict_and_csv_full_row(test_set_pids, CURRENT_QUERY, PIO_HOST, save_path, print_every=None):
    cdef int i
    cdef list row
    output = {}

    def getPIO(host, productid, query):
        productid = str(productid)
        query['item'] = productid
        headers = { "Accept":"application/json" }
        r = requests.post(host, data = json.dumps(query), headers=headers)
        json_res = json.loads(r.text)
        
        item_list = [item['item'] for item in json_res['itemScores']]
        return item_list

    with open(save_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile, delimiter='\t')
        for i, anch in enumerate(test_set_pids):

            try:
                recs = getPIO(PIO_HOST, anch, CURRENT_QUERY)
                writer.writerow([anch, recs])
                output[anch] = recs

            except:
                print("row {} skipped".format(i))

            if print_every and i % print_every == 0:
                    print(i, recs)

    print("Saved recs file as {}".format(save_path))

    return output