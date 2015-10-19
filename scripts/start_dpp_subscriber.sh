#!/bin/bash

if [ -z "$ROOT" ]
then
    ROOT=$(while ! test -e env.sh.sample; do cd ..; done; pwd)
    export ROOT
fi

. $ROOT/env.sh

START_FOLDER=$PWD
SAMPLE_ACTION_DATA=action.json

at=`cat $ROOT_IDS_FOLDER/$RANDOM_ACCESS_TOKEN_FILENAME`
mkdir -p $TMPDIR

for file in `ls $1/$DPPS_FOLDER | head -1`
do

  echo $file
  id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
  rt=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -8 | tail -1`
  rm -rf $TMPDIR/$SAMPLE_ACTION_DATA

  echo "      Subscribing to topic /topic/"$at"."$id".streams."$SAMPLE_DPP_AGG_STREAM".updates"
  $NODE_HOME/bin/node $SCRIPTS/dpp_data_subscribe.js $at $id $SAMPLE_DPP_AGG_STREAM

done
