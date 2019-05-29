import csv
import json
import requests

def create_ur_recs(test_set_pids, CURRENT_QUERY, PIO_HOST, save_path, print_every=None):
    cdef int i
    cdef list row

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
                row = getPIO(PIO_HOST, anch, CURRENT_QUERY)
                if print_every and i % print_every == 0:
                    print(i, row)
                idx = reversed(range(len(row)))
                for pid in row:
                    writer.writerow([anch, pid, next(idx)+1])
            except:
                print("row {} skipped".format(i))

    print("Saved recs file as {}".format(save_path))