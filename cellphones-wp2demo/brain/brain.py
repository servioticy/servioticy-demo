import httplib2
import json
import time
import sys

def request(partial_url, method, body, headers):
    h = httplib2.Http()
    response, content = h.request(
        "http://api.servioticy.com:9090/" + partial_url,
        method,
        body,
        headers)
    return response, content.decode('utf-8')

def main():
    token = sys.argv[3]
    headers = {
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8'
    }
    query = {
        "timerange": True,
        "rangefrom": (time.time() - 5) * 1000
    }
    susjson = request(sys.argv[1] + "/streams/" + sys.argv[2] + "/search", 'POST', json.dumps(query), headers)
    
    susById = {}
    line = []
    
    for su in json.loads(susjson):
        if su["channels"]["id"]["current-value"] not in susById:
            susById[su["channels"]["id"]["current-value"]] = []
        susById[su["channels"]["id"]["current-value"]].append(su)
    for id in susById:
        beacons = []
        for su in susById[id]:
            if not beacons:
                beacons.append(su["channels"]["beacon"]["current-value"])
                continue
            if su["channels"]["beacon"]["current-value"] not in beacons:
                line.append(id)
                continue
    
    if not line:
        print("No line waiting")
    else:
        print("Line: " + str(len(line)) + " people waiting")
    return

if __name__ == '__main__':
    main()
