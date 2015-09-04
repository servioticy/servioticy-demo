#!/bin/bash
. env.sh

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER

echo
echo "*********************************"
echo servIoTicy final demo tester
echo  Generating a sensor update
echo "*********************************"
echo

$SCRIPTS/get_access_token.sh $START_FOLDER
$SCRIPTS/get_random_access_token.sh $START_FOLDER
$SCRIPTS/push_data_so.sh $START_FOLDER
sleep $PUSH_DATA_DELAY
$SCRIPTS/retrieve_data_so.sh $START_FOLDER
$SCRIPTS/retrieve_data_dpp_agg.sh $START_FOLDER
$SCRIPTS/retrieve_data_dpp_filt.sh $START_FOLDER
