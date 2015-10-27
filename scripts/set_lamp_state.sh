#!/bin/bash

if [ -z "$ROOT" ]
then
    ROOT=$(while ! test -e env.sh.sample; do cd ..; done; pwd)
    export ROOT
fi

. $ROOT/env.sh

mkdir -p $IDS_FOLDER

at=`cat $ROOT_IDS_FOLDER/$ACCESS_TOKEN_FILENAME`
id=`cat $1/$IDS_FOLDER/lamp0$2.json.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
echo Retrieving ID: $id
curl -i -X POST -H "Content-Type: text/plain" \
   	-H "Authorization: $at" \
   	-d "{\"status\": \"$3\"}" \
		http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id/actuations/lampstatus

