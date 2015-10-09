#!/bin/bash

if [ -z "$ROOT" ]
then
    ROOT=$(while ! test -e env.sh.sample; do cd ..; done; pwd)
    export ROOT
fi

. $ROOT/env.sh

START_FOLDER=$PWD
SAMPLE_ACTION_DATA=action.json

at=`cat $ROOT_IDS_FOLDER/$ACCESS_TOKEN_FILENAME`
mkdir -p $TMPDIR

for file in `ls $1/$SOS_FOLDER | head -1`
do

  echo $file
  id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
  rt=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -8 | tail -1`
  rm -rf $TMPDIR/$SAMPLE_ACTION_DATA
  #echo "      Subscribing to topic /topic/"$rt"."$id".actions"
  echo "      Subscribing to topic /topic/"$id".actions"
  #$NODE_HOME/bin/node $SCRIPTS/action_subscribe.js $rt $id > $TMPDIR/$SAMPLE_ACTION_DATA
  $NODE_HOME/bin/node $SCRIPTS/action_subscribe.js $id > $TMPDIR/$SAMPLE_ACTION_DATA


done
