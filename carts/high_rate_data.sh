#!/bin/bash
. ../env.sh

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
$SCRIPTS/push_data_so_at_rate.sh $START_FOLDER 10
