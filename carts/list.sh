#!/bin/bash
. ../env.sh

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER
mkdir -p $TMPDIR

echo
echo "*********************************"
echo servIoTicy final demo tester
echo  Listing SOs and DPPs
echo "*********************************"
echo

$SCRIPTS/get_access_token.sh $START_FOLDER
$SCRIPTS/get_random_access_token.sh $START_FOLDER
$SCRIPTS/list_so_ids.sh $START_FOLDER

echo Done.
echo
