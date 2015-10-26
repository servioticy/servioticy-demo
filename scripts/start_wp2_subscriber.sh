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

rm -rf $TMPDIR/$SAMPLE_ACTION_DATA
echo "      Subscribing to topic /topic/"$id".actions"
$NODE_HOME/bin/node $SCRIPTS/action_subscribe.js $2 > $TMPDIR/$SAMPLE_ACTION_DATA


