#!/bin/bash

if [ -z "$ROOT" ]
then
    ROOT=$(while ! test -e env.sh.sample; do cd ..; done; pwd)
    export ROOT
fi

. $ROOT/env.sh

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER


at=`cat $ROOT_IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

echo
echo "*********************************"
echo servIoTicy final demo tester
echo     Setting lamp state
echo "*********************************"



	echo Retrieving ID: $1
	curl -i -X GET -H "Content-Type: text/plain" \
   	-H "Authorization: $at" \
		http://$API_PUB_NODES:$API_PUB_SEC_PORT/$1

echo
