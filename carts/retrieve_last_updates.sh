#!/bin/bash

if [ -z "$ROOT" ]
then
    ROOT=$(while ! test -e env.sh.sample; do cd ..; done; pwd)
    export ROOT
fi

. $ROOT/env.sh:

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER

echo
echo "*********************************"
echo servIoTicy final demo tester
echo  "Retrieve most recent sensor update (lastUpdate)"
echo "*********************************"
echo

$SCRIPTS/get_access_token.sh $START_FOLDER
$SCRIPTS/get_random_access_token.sh $START_FOLDER
$SCRIPTS/retrieve_data_lastupdate_so.sh $START_FOLDER
$SCRIPTS/retrieve_data_dpp_last_update_agg.sh $START_FOLDER
$SCRIPTS/retrieve_data_dpp_last_update_filt.sh $START_FOLDER
